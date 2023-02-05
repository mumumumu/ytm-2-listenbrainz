# Description
A simple script to import [YouTube Music](https://music.youtube.com/) listen history to [ListenBrainz](https://listenbrainz.org/).

# Pre-requisites
To run this script you will need:
- to have `jq` and `curl` installed
- a ListenBrainz API token (found on your [profile page](https://listenbrainz.org/profile/))
- a JSON dump of your YouTube Music history (export from [Google Takeout](https://takeout.google.com))

# Usage
Place your exported JSON file(s) in the `history` directory and run the following command:
```sh
USER_TOKEN=<your API token> ./import-ytm-history.sh
```
