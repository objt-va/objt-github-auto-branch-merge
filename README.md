# Auto Branch Merge Action

Automatically merge the source branch into the target branch by using native git merge.

If the merge is not necessary, the action will do nothing.
If the merge fails due to conflicts, the action will fail, and the repository
maintainer should perform the merge manually.

## Installation

To enable the action simply create the `.github/workflows/auto-merge.yml`
file with the following content:

```yml
on:
  push:
    branches:
      - "feature/*"
jobs:
  auto-dev-merge:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Set env variables
        uses: FranzDiebold/github-env-vars-action@v1.2.1
      - name: Merge branch
        uses: Germanedge/github-auto-branch-merge@main
        with:
          target_branch: 'dev'
          source_branch: ${{ env.GITHUB_REF_NAME }}
          commit_message: "[Automated] Merge branch '${{env.GITHUB_REF_NAME}}' into dev"
        env:
          GITHUB_TOKEN: ${{ github.token }}
```

## Parameters

### `source_branch`

The name of the source branch.

### `target_branch`

The name of the development branch.

### `allow_ff`

Allow fast forward merge (default `false`). If not enabled, merges will use
`--no-ff`.

### `ff_only`

Refuse to merge and exit unless the current HEAD is already up to date or the
merge can be resolved as a fast-forward (default `false`).
Requires `allow_ff=true`.

### `user_name`

User name for git commits (default `Auto Merge Action`).

### `user_email`

User email for git commits (default `actions@github.com`).

### `commit_message`

Message for merge commit

### `push_token`

Environment variable containing the token to use for push (default
`GITHUB_TOKEN`).
Useful for pushing on protected branches.
Using a secret to store this variable value is strongly recommended, since this
value will be printed in the logs.
The `GITHUB_TOKEN` is still used for API calls, therefore both token should be
available.

```yml
      with:
        push_token: 'FOO_TOKEN'
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        FOO_TOKEN: ${{ secrets.FOO_TOKEN }}
```
