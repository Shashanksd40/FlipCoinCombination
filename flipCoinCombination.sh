#!/bin/bash -x
declare -A coinsCombination
declare -A coinsCombCount
coinstore=1
singlet(){
	count=0
	while [[ $count -lt 20 ]]
	do
		coin=$((RANDOM%2))
		count=$(($count+1))
		if [ $coin -eq 0 ]
		then
			headWins=$((headWins+1))
			coinsCombCount[H]=$headWins
			#coinsCombination[$((coinstore++))]="H"
		else
			tailWins=$((tailWins+1))
			coinsCombCount[T]=$tailWins
			#coinsCombination[$((coinstore++))]="T"
		fi
	done
}
doublet(){
	count=0
	while [[ $count -lt 20 ]]
	do
		doubCoins=""
		count=$(($count+1))
		for ((i=1;i<=2;i++))
		do
			coin=$((RANDOM%2))
			if [ $coin -eq 0 ];then
				headWins=$((headWins+1))
				doubCoins="${doubCoins}""H"
			elif [ $coin -eq 1 ];then
				tailWins=$((tailWins+1))
				doubCoins="${doubCoins}""T"
			fi
		done
		doublet[$((coinstore++))]=$doubCoins
		if [ "$doubCoins" = "HH" ];then
			hh_Wins=$(($hh_Wins+1))
			coinsCombCount[HH]=$hh_Wins
		elif [ "$doubCoins" = "HT" ];then
			ht_Wins=$(($ht_Wins+1))
			coinsCombCount[HT]=$ht_Wins
		elif [ "$doubCoins" = "TH" ];then
			th_Wins=$(($th_Wins+1))
			coinsCombCount[TH]=$th_Wins
		elif [ "$doubCoins" = "TT" ];then
			tt_Wins=$(($tt_Wins+1))
			coinsCombCount[TT]=$tt_Wins
		fi
	done
}
triplet(){
	count=0
	while [[ $count -lt 20 ]]
	do
	   doubCoins=""
	   count=$(($count+1))
	   for ((i=1;i<=3;i++))
	   do
	      coin=$((RANDOM%2))
	      if [ $coin -eq 0 ];then
	         headWins=$((headWins+1))
	         doubCoins="${doubCoins}""H"
	      elif [ $coin -eq 1 ];then
	         tailWins=$((tailWins+1))
	         doubCoins="${doubCoins}""T"
	      fi
	   done
	   doublet[$((coinstore++))]=$doubCoins
	   if [ "$doubCoins" = "HHH" ];then
	      hhh_Wins=$(($hhh_Wins+1))
			coinsCombCount[HHH]=$hhh_Wins
	   elif [ "$doubCoins" = "HHT" ];then
	      hht_Wins=$(($hht_Wins+1))
			coinsCombCount[HHT]=$hht_Wins
	   elif [ "$doubCoins" = "HTH" ];then
	      hth_Wins=$(($hth_Wins+1))
			coinsCombCount[HTH]=$hth_Wins
	   elif [ "$doubCoins" = "THH" ];then
	      thh_Wins=$(($thh_Wins+1))
			coinsCombCount[THH]=$thh_Wins
	   elif [ "$doubCoins" = "HTT" ];then
	      htt_Wins=$(($htt_Wins+1))
			coinsCombCount[HTT]=$htt_Wins
	   elif [ "$doubCoins" = "THT" ];then
	      tht_Wins=$(($tht_Wins+1))
			coinsCombCount[THT]=$tht_Wins
	   elif [ "$doubCoins" = "TTH" ];then
	      tth_Wins=$(($tth_Wins+1))
			coinsCombCount[TTH]=$tth_Wins
	   elif [ "$doubCoins" = "TTT" ];then
	      ttt_Wins=$(($ttt_Wins+1))
			coinsCombCount[TTT]=$ttt_Wins
	   fi
	done
}
singlet
doublet
triplet
echo ${!coinsCombCount[@]}
echo ${coinsCombCount[@]}
max=0
secMax=0
j=H
array=(H T HH HT TH TT HHH HHT HTH THH HTT THT TTH TTT)
for i in ${array[@]}
do
	if [[ ${coinsCombCount[$i]} -gt $max ]];
	then
		j=$i
		max=${coinsCombCount[$i]}
	fi
done
echo max is $j : ${coinsCombCount[$j]}
percent=`echo " scale=2; (${coinsCombCount[$j]}/20)*100" | bc`
echo And Percent is : $percent
