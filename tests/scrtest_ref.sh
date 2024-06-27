#! /bin/bash

if [ -f log.txt ]; then
        echo "rm old results_ref log"
        rm results_ref.txt
fi

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
do  
	echo -n "S_KO $i :" > buffer.txt
	BUFFER=$(cat buffer.txt) 
	../bin/minicc_ref Syntaxe/KO/test$i.c -s &> buffer.txt
	TEMP=$(echo $(cat buffer.txt)  | cut -d ":" -f 1)
	echo $BUFFER$TEMP >> results_ref.txt
done

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
do 
	echo -n "S_OK $i :" > buffer.txt
	BUFFER=$(cat buffer.txt) 
	../bin/minicc_ref Syntaxe/OK/test$i.c -s &> buffer.txt
	RESULT=$(cat buffer.txt)
	if [ -z "$RESULT" ]
	then
		echo -n "Test okay" > buffer.txt
		RESULT=$(cat buffer.txt) 
	else
		RESULT=$(cat buffer.txt)
	fi
	echo $BUFFER$RESULT >> results_ref.txt
done

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
do 
	echo -n "V_KO $i :" > buffer.txt
	BUFFER=$(cat buffer.txt) 
	../bin/minicc_ref Verif/KO/test$i.c  &> buffer.txt
	TEMP=$(echo $(cat buffer.txt)  | cut -d ":" -f 1)
	echo $BUFFER$TEMP >> results_ref.txt
done

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 
do 
	echo -n "V_OK $i :" > buffer.txt
	BUFFER=$(cat buffer.txt) 
	../bin/minicc Verif/OK/test$i.c -s &> buffer.txt
	RESULT=$(cat buffer.txt) 
	if [ -z "$RESULT" ]
	then
		echo -n "Test okay" > buffer.txt
		RESULT=$(cat buffer.txt) 
	else
		RESULT=$(cat buffer.txt)
	fi
	echo $BUFFER$RESULT >> results_ref.txt
done

for i in 1 2 
do 
	echo -n "G_KO $i :" > buffer.txt
	BUFFER=$(cat buffer.txt) 
	../bin/minicc_ref Gencode/KO/test$i.c &> buffer.txt
	AUTRE=$(cat buffer.txt)
	java -jar ../tools/Mars_4_2.jar  out.s > buffer.txt
	head -n 3 buffer.txt | tail -1 > buff.txt
	TEMP=$(cat buff.txt)
	echo $BUFFER$TEMP$AUTRE >> results_ref.txt
done

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
do 
	echo -n "G_OK $i :" > buffer.txt
	BUFFER=$(cat buffer.txt) 
	../bin/minicc_ref Gencode/OK/test$i.c &> buffer.txt
	AUTRE=$(cat buffer.txt)
	java -jar ../tools/Mars_4_2.jar  out.s > buff.txt
	head -n 3 buff.txt | tail -1 > buffy.txt
	RESULT=$(cat buffy.txt) 
	cat buffy.txt
	echo $BUFFER$RESULT >> results_ref.txt
done
rm buff.txt buffy.txt
