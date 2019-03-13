### My Dotfiles

To set up on a new machine, run:
```
$ alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
$ git clone --bare git@github.com:tneumann/dotfiles.git $HOME/.cfg
$ mkdir -p .config-backup && config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
$ config checkout
```

Also see: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
