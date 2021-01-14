FROM alpine:latest

LABEL repository="http://github.com/Germanedge/github-auto-branch-merge"
LABEL homepage="http://github.com/Germanedge/github-auto-branch-merge"
LABEL "com.github.actions.name"="Auto Branch Merge"
LABEL "com.github.actions.description"="Automatically merge the source branch into the target branch"
LABEL "com.github.actions.icon"="git-merge"
LABEL "com.github.actions.color"="orange"

RUN apk --no-cache add bash curl git git-lfs jq

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
