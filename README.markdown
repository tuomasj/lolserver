# LOLSERVER #

Lolserver is static web server, that hosts your current directory in [http://localhost:4567](http://localhost:4567). It also renders markdown documents.

![Directory Index](directory-index.png)

## INSTALL ##

### RUBY (OPTIONAL) ###

#### Mac OS X / Linux ####

Optional: You need to install Ruby. I'd suggest you use [rbenv](https://github.com/sstephenson/rbenv/).

#### Windows ####

If you are running Windows, use [rubyinstaller.org](http://rubyinstaller.org).

### INSTALL LOLSERVER ###

You can install this gem from github. Nope, I haven't pushed this into rubygems. Not yet, anyway.

```
git clone http://github.com/tuomasj/lolserver
gem build lolserver.gemspec
gem install lolserver-0.0.1.gem
```

### DEPENDENCIES ###

**lolserver** has only one dependency, which is [sinatra](http://sinatrarb.com).

## RUNNING ##

Open console window, go to the directory of your choise and start **lolserver**.

```
cd your/project/folder
lolserver
´´´

Then, open your browser on (http://localhost:4567)[http://localhost:4567].

## DISCLAIMER ##

This little tool was built using the ideology called "Scratch your own itch".
It means that this tool is experimental, and you will use it on your own risk.

Running **lolserver** on wifi network opens your file system to everyone on that network if your firewall does not block incoming connections on port 4567. So please be careful.
