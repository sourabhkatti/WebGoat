#!/usr/bin/env bash

echo "STARTING DEPLOY SCRIPT"
# export DOCKER_USER="XgPc0UKRTUI70I4YWNQpThPPWeQIxkmzh1GNoR/SSDC2GPIBq3EfkkbSQewqil8stTy+S1/xSzc0JXG8NTn7UOxHVHA/2nhI6jX9E+DKtXQ89YwmaDNQjkbMjziAtDCIex+5TRykxNfkxj6VPYbDssrzI7iJXOIZVj/HoyO3O5E="
# export DOCKER_PASS="aly5TKBUK9sIiqtMbytNNPZHQhC0a7Yond5tEtuJ8fO+j/KZB4Uro3I6BhzYjGWFb5Kndd0j2TXHPFvtOl402J1CmFsY3v0BhilQd0g6zOssp5T0A73m8Jgq4ItV8wQJJy2bQsXqL1B+uFYieYPiMchj7JxWW0vBn7TV5b68l6U="
docker login -u $DOCKER_USER -p $DOCKER_PASS
export REPO=webgoat/webgoat-8.0

cd webgoat-server
ls target/

if [ ! -z "${TRAVIS_TAG}" ]; then
  # If we push a tag to master this will update the LATEST Docker image and tag with the version number
  docker build --build-arg webgoat_version=${TRAVIS_TAG:1} -f Dockerfile -t $REPO:latest -t $REPO:${TRAVIS_TAG} .
  docker push $REPO
#elif [ ! -z "${TRAVIS_TAG}" ]; then
#  # Creating a tag build we push it to Docker with that tag
#  docker build --build-arg webgoat_version=${TRAVIS_TAG:1} -f Dockerfile -t $REPO:${TRAVIS_TAG} -t $REPO:latest .
#  docker push $REPO
#elif [ "${BRANCH}" == "develop" ]; then
#  docker build -f Dockerfile -t $REPO:snapshot .
#  docker push $REPO
else
  echo "Skipping releasing to DockerHub because it is a build of branch ${BRANCH}"
fi


export REPO=webgoat/webwolf
cd ..
cd webwolf
ls target/

if [ ! -z "${TRAVIS_TAG}" ]; then
  # If we push a tag to master this will update the LATEST Docker image and tag with the version number
  docker build --build-arg webwolf_version=${TRAVIS_TAG:1} -f Dockerfile -t $REPO:latest -t $REPO:${TRAVIS_TAG} .
  docker push $REPO
else
  echo "Skipping releasing to DockerHub because it is a build of branch ${BRANCH}"
fi