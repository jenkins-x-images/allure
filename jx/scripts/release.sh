#!/usr/bin/env bash

export DOCKER_REGISTRY=docker.io
export IMAGE=allure

jx step next-version --use-git-tag-only > VERSION

export VERSION=$(cat VERSION)
echo "Creating docker image: jenkinsxio/$IMAGE:$VERSION"

docker build -t ${DOCKER_REGISTRY}/jenkinsxio/$IMAGE:$VERSION .
docker push ${DOCKER_REGISTRY}/jenkinsxio/$IMAGE:$VERSION

echo
echo "pushing new version to git tag.."

jx step tag --version $VERSION

echo
echo "pushed docker image: ${DOCKER_REGISTRY}/jenkinsxio/$IMAGE:$VERSION"
echo "you can browse the versions here: https://hub.docker.com/r/jenkinsxio/$IMAGE/"

