#!/usr/bin/env bash
train=true
dotest=false
dataset=s800

while [ "$1" != "" ]; do
	case $1 in 
		-test )		dotest=true
				train=false
				;;
		-dataset )	shift
				dataset=$1
				;;
	esac
	shift
done

export BIOBERT_DIR=gs://skills-mining/biobert/pubmed_pmc_470k
export NER_DIR=gs://skills-mining/biobert/NERData/$dataset
export OUTPUT_DIR=gs://skills-mining/biobert/output/
python biobert/run_ner.py \
	   --do_train=$train \
	   --do_eval=$train \
	   --do_test=$dotest \
	   --use_tpu=true \
	   --vocab_file=$BIOBERT_DIR/vocab.txt \
	   --bert_config_file=$BIOBERT_DIR/bert_config.json \
	   --init_checkpoint=$BIOBERT_DIR/biobert_model.ckpt \
	   --num_train_epochs=50.0 \
	   --data_dir=$NER_DIR/ \
	   --output_dir=$OUTPUT_DIR