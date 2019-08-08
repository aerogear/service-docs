#!/bin/bash
echo $SHELL
echo 'netlify-publish-adoc'
node_modules/.bin/antora --html-url-extension-style=indexify --pull ../antora-site.yml
 
echo 'node-publish-adoc'
gem install asciidoctor


for filename in ../modules/ROOT/pages/*.adoc; do

  echo $filename
  cat ../bin/downstream-attributes $filename > temp.txt
  ../bin/asciidoc-coalescer.rb -a include-tags="!excludeDownstream;!excludeAll" temp.txt > ../build/site/$(basename "$filename")

done

cp -r ../etc ../build/site/
cp ../etc/index.html ../build/site/index.html
