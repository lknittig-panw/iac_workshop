#!/bin/sh
api_response=`curl -s -H 'content-type: application/json'   https://scan.api.redlock.io/v1/iac   --data-binary "@AWS_S3_TFT.json"`
rules_matched_count=`jq '.result.rules_matched|length' <<< $api_response`
echo "rules matched count: $rules_matched_count";
if [ "$rules_matched_count" -ne 0 ];then
  echo "Build failed with error code $rules_matched_count because the following checks failed:";
  jq '.result.rules_matched' <<< $api_response
fi
exit $rules_matched_count
