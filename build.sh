#!/bin/bash

root="$(pwd)"

minifyRepo="tdewolff/minify"
minifyReleases="https://api.github.com/repos/$minifyRepo/releases"
minifyDownloadURL=""

if [ ! -f "$root/minify" ]; then
    minifyTag=$(curl -s "$minifyReleases" | jq -r '.[0].tag_name')

    minifyDownloadURL="https://github.com/$minifyRepo/releases/download/$minifyTag/minify_linux_amd64.tar.gz"

    curl -L -o "$root/minify.tar.gz" "$minifyDownloadURL"

    mkdir -p "$root/temp"

    tar -xzf "$root/minify.tar.gz" -C "$root/temp"

    mv "$root/temp/minify" "$root/"

    rm -rf "$root/temp"
    rm "$root/minify.tar.gz"
fi

"$root/minify" -r -o "$root/build/" "$root/css/v3/"