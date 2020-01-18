#!/usr/bin/env bash

source="../src/GwentTracker/data"
dest="../src/GwentTracker/locale/cards.pot"

cat > ${dest} <<EOF
msgid ""
msgstr ""
"Content-Type: text/plain; charset=UTF-8\n"
"Plural-Forms: nplurals=2; plural=n != 1;\n"
"X-Poedit-KeywordsList: GetString;GetPluralString:1,2;GetParticularString:1c,2;GetParticularPluralString:1c,2,3;_;_n:1,2;_p:1c,2;_pn:1c,2,3\n"
EOF

egrep -no '\s+\w+:\ [^0-9\[#/]+$' ${source}/*.yml | \
 sed 's/:/|/1;s//|/1;s//|/1' | \
 sed -r 's/"|(\|)\s+|\s+$/\1/g' | \
 cut -d '|' -f 1-4 | \
 sort -t '|' -u -k 4,4 | \
 sort -t'|' -k1,1 -k2n,2 | \
 while read line; do
    IFS='|' read file lineNum property value <<< "$line"
    
    cat >> ${dest} <<EOF
    
#: ${file:3}:${lineNum} -> Card.${property}
msgid "${value}"
msgstr ""
EOF
 done