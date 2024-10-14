#!/bin/bash

set -ex

ASSERTSO1='https://github.com/gensmusic/asserts01/raw/main'

# 格式 地址#下载的文件名
urls=(
  "$ASSERTSO1/gltf/tower.glb#public/gltf/tower.glb"
  "$ASSERTSO1/gltf/Cesium_Air.glb#public/gltf/Cesium_Air.glb"
)

for item in "${urls[@]}"
do
  IFS="#" read -ra arr <<< "$item"
  url="${arr[0]}"
  filename="${arr[1]}"

  mkdir -p $(dirname $filename)
  if [ -e "$filename" ]; then
    echo "$filename 已存在"
    continue
  fi

  wget $url -O $filename
done

# 直接下载 asserts01 仓库目录
ASSERTS_REPO="https://github.com/gensmusic/asserts01"
ASSERTS_PATH="./tmp/asserts01"
mkdir -p ./tmp
if [ -e $ASSERTS_PATH ]; then
  pushd $ASSERTS_PATH
  git pull
  popd
else
  git clone $ASSERTS_REPO $ASSERTS_PATH
fi


rm -rf ./public/3dfiles
cp -rf $ASSERTS_PATH/3dtiles ./public/