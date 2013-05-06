#!/bin/sh
set -x
BUILD_LOCALE=$1
: ${BUILD_LOCALE:=ja}

RST_FILES="
	contents01.rst
	contents02.rst
	doc.rst
	history.rst
	index.rst
	indexPdf.rst
"
for f in $RST_FILES ; do touch $f; done 

[ "x$BUILD_LOCALE" != "xja" ] && BUILD_LOCALE=en

#rm -rf locale _build/locale ; make gettext
#sphinx-gettext-helper -p _build/locale -b -u
#for t in html pdf ; do
for t in gettext html ; do
echo === $t ===
SPHINXBUILD=../bin/sphinx-build MAKE=gmake LANGUAGE=${BUILD_LOCALE} gmake -e $t
echo 
done
mkdir -p /opt/glNetViz/docs/${BUILD_LOCALE}/html
cp -rf  _build/html/* /opt/glNetViz/docs/${BUILD_LOCALE}/html/
