#!/bin/bash
mkdir results
testing_map=(
  dataset/map/random-32-32-20.map
  dataset/map/empty-32-32.map
  dataset/map/warehouse-10-20-10-2-1.map
  dataset/map/den520d.map
);

testing_num_of_agent=(
"20 30 40 50 60 70"
"50 70 90 110 130 150"
"50 70 90 110 130 150"
"60 80 100 120 140 160"
);

timeOut=60;
index=0;
for map in "${testing_map[@]}"; do
  map_file="$(basename -- $map)";
  map_name=$(echo "$map_file" | cut -f 1 -d '.')

  mkdir results/$map_name
  mkdir results/$map_name/even
  mkdir results/$map_name/random
  num_of_agent=${testing_num_of_agent[index]};
#  heuristic_flag=(N BP CH CHBP CHBPNS CHBPNM CHBPNRM);
#  for ablation study: CHBPNS CHBPNM CHBPNRM;
  heuristic_flag=(N BP CH CHBP);
  for i in $num_of_agent; do
    for f in "${heuristic_flag[@]}"; do
      echo "Run benchmark: Agents size: "$i" Heuristic flag: " $f;
      bash ./run_experiments.sh $map $i $timeOut $f
    done
  done
  ((index=index+1))
done