#!/bin/bash

BRANCH="master"

if (($# > 0)); then
    BRANCH=$1
fi

echo " +++ SELECTED BRANCH: $BRANCH"

echo " +++ UPDATE DOCKER PROJECT"
git checkout "$BRANCH"

git reset -- hard HEAD

git pull

echo " +++ UPDATE SUBMODULES"
( git submodule update --recursive --remote )

echo " +++ UPDATE WEBAPP BUILD"
cd webapp-RGQL || exit 1
yarn install
yarn build

echo " +++ RUN DOCKER COMPOSE"
docker-compose up -d

exit 0