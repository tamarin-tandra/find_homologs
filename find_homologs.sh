#!/bin/bash

#Input and output file names
query_file="$1"
subject_file="$2"
output_file="$3"

#Perform BLAST search and filter for perfect matches
tblastn -query "$query_file" -subject "$subject_file" -outfmt "6 qseqid sseqid pident length" | \
    awk '$3 > 30 && $4 > 0.9 * length ($1)' > "$output_file"

#Print the number of perfect matches to stdout
number_of_matches=$(wc -l < "$output_file")
echo "Number of matches: $number_of_matches"
