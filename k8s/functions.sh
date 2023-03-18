deployService() {
  SERVICE=$1
  ENVIRONMENT=$2
  TRIGGER_ACTION=$3
  TAG=$4
  if test -z "$TAG"
  then
    (set -x; helm upgrade --install "$SERVICE" charts/"$SERVICE" -f envs/"$ENVIRONMENT"/"$SERVICE".yaml --namespace="$ENVIRONMENT" --set parameters.TRIGGER_ACTION="$TRIGGER_ACTION")
  else
    (set -x; helm upgrade --install "$SERVICE" charts/"$SERVICE" -f envs/"$ENVIRONMENT"/"$SERVICE".yaml --namespace="$ENVIRONMENT" --set parameters.TRIGGER_ACTION="$TRIGGER_ACTION" --set image.tag="$TAG")
  fi
}

upgradeDev() {
  TRIGGER_ACTION="LOCAL-UPGRADE-AT-$(date +%s)"
  deployService bonbonus-ml-service dev "$TRIGGER_ACTION"
  deployService bonbonus-backend-service dev "$TRIGGER_ACTION"
}

"$@"