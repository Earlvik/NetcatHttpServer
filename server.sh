#!/bin/bash

touch fifo
while true
do
cat fifo | nc -l 1234 |(
i=0;
while read lines[$i] && [ ${#lines[$i]} -gt 1 ];
do i=$[$i +1]
done
if [[ $lines[0] == "GET /echo HTTP/1."* ]]
then
( IFS=$'\n'; echo "${lines[*]}"> fifo );
elif [[  $lines[0] == "GET /hello HTTP/1."* ]]
then
cat hello.html >  fifo;
fi
)
done
