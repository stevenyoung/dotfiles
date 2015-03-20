# ~/.config/fish/config.fish
set -xg PATH /usr/local/apache-maven-3.2.3/bin /usr/local/bin /usr/local/go/bin /usr/local/mysql/bin /usr/local/go_appengine /usr/local/bin ~/bin $PATH

set -xg JAVA_HOME (/usr/libexec/java_home -v 1.8)
set -xg CHORUS_HOME /Users/steven/Desktop/workspace/rails/chorus
set -xg DYLD_LIBRARY_PATH /Users/steven/Desktop/workspace/rails/chorus/postgres/lib
set -xg PATH $CHORUS_HOME/bin $CHORUS_HOME/postgres/bin $PATH
set -xg JRUBY_OPTS "-X+O --client -J-Xmx2048m -J-Xms512m -J-Xmn128m -J-XX:MaxPermSize=128m -Xcext.enabled=true -J-Djava.library.path=$CHORUS_HOME/vendor/hadoop/lib/"


set -xg RBENV_ROOT /usr/local/var/rbenv
. (rbenv init -|psub)

set fish_git_dirty_color red

function parse_git_dirty
    git diff --quiet --ignore-submodules HEAD 2>/dev/null
    if test $status = 1
      echo (set_color $fish_git_dirty_color)"Δ"(set_color normal)
    end
end

function parse_git_branch
  set -l branch (git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  echo "("$branch")" (parse_git_dirty)
end

# Only show username/host if not default
function usernamehost
  if test $USER != 'steven'
    echo "$USER at $HOSTNAME in "
  end
end

function fish_prompt
  printf '%s%s %s%s%s$ '  (usernamehost) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (parse_git_branch)
end
