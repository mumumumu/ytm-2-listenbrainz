#!/bin/sh

jq -cs 'add | [
  .[] | select( .header == "YouTube Music") | 
  ({
    listened_at: .time | sub("\\.[0-9]+Z$"; "Z") | fromdate,
    track_metadata: {
      artist_name: .subtitles[0].name | sub(" - Topic$"; ""),
      track_name: .title | sub("^Watched "; "")
    }
  })?
] | _nwise(1000) | { listen_type: "import", payload: . }' history/* \
| awk '{print > "chunks/"NR".json"}'

endpoint="https://api.listenbrainz.org/1/submit-listens"

for file in chunks/*.json; do
    curl -w "$file - %{response_code}\n" -X POST $endpoint \
      -H "Authorization: Token $USER_TOKEN" \
      -H "Content-Type: application/json" \
      -d @$file
done
