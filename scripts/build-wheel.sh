#!/bin/bash

LIBMAXMINDDB_VERSION=1.4.3
MAXMINDDB_PY_VERSION=2.0.2

cd /tmp
curl -L -O https://github.com/maxmind/libmaxminddb/releases/download/${LIBMAXMINDDB_VERSION}/libmaxminddb-${LIBMAXMINDDB_VERSION}.tar.gz
tar xzvf libmaxminddb-${LIBMAXMINDDB_VERSION}.tar.gz
cd libmaxminddb-${LIBMAXMINDDB_VERSION}
./configure
make
make check
make install
ldconfig

cd /tmp
curl -L -O https://github.com/maxmind/MaxMind-DB-Reader-python/archive/v${MAXMINDDB_PY_VERSION}.tar.gz
tar xzvf v${MAXMINDDB_PY_VERSION}.tar.gz
cd MaxMind-DB-Reader-python-${MAXMINDDB_PY_VERSION}

for PYBIN in /opt/python/*/bin; do
    ${PYBIN}/python setup.py build
    ${PYBIN}/python setup.py bdist_wheel -d /tmp/build
done

set -x
for whl in /tmp/build/*.whl; do
    auditwheel repair "$whl" -w /build/
done
