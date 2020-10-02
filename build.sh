#!/bin/bash

IMAGE=quay.io/pypa/manylinux2014_x86_64

docker pull ${IMAGE}
docker run \
    --rm \
    -v ${PWD}/build:/build \
    -v ${PWD}/scripts:/scripts \
    ${IMAGE} \
    /scripts/build-wheel.sh
