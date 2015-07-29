#!/bin/bash
#
# See README.rst for more information about this script.
#
# Before running, please clone the following repositories:
#     git clone https://github.com/gitenberg-dev/asciidoctor-htmlbook.git
#     git clone https://github.com/gitenberg-dev/HTMLBook

VERSION=`ruby -e "require 'yaml'; meta = YAML.load_file('metadata.yaml'); puts meta['_version'];"`
if [ ! -d OEBPS ]; then
	mkdir OEBPS
fi
asciidoctor -a toc,version=$VERSION -b xhtml5 -T ./asciidoctor-htmlbook/htmlbook-autogen/ -d book News-from-Nowhere.asciidoc -o book.html
xsltproc -stringparam external.assets.list " " ./HTMLBook/htmlbook-xsl/epub.xsl book.html
cp ./HTMLBook/stylesheets/epub/epub.css OEBPS
zip -rX book.epub mimetype
zip -rX book.epub OEBPS/ META-INF/
mv book.epub News-from-Nowhere.epub
rm -r OEBPS
