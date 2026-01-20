response=$(curl -s -X GET -H "Accept: application/json" "https://v2.jokeapi.dev/joke/Misc")
type=$(echo "$response" | jq -r ".type")
if [ "$type" != "single" ]; then
  setup=$(echo "$response" | jq -r ".setup")
  delivery=$(echo "$response" | jq -r ".delivery")
  joke="$setup\n $delivery"
else
  joke=$(echo "$response" | jq -r ".joke")
fi
if [ -z "$joke" ] || [ "$joke" = "null" ]; then
  sleep 1h
  continue
fi
notify-send "Joke of the Day" "$joke"
sleep 1d
done