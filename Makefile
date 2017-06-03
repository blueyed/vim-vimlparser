VIM_COMPILER:=vim -N --cmd 'set rtp+=.' -c q -u
COMPILED_FILES:=js/vimlparser.js py/vimlparser.py

all: $(COMPILED_FILES)

js/vimlparser.js: autoload/vimlparser.vim js/jscompiler.vim js/vimlfunc.js
	$(VIM_COMPILER) js/jscompiler.vim

py/vimlparser.py: autoload/vimlparser.vim py/pycompiler.vim py/vimlfunc.py
	$(VIM_COMPILER) py/pycompiler.vim

force_compile:
	$(RM) $(COMPILED_FILES)

check: all
	git diff --exit-code $(COMPILED_FILES) || { \
	  echo 'Compiled files were updated, but should have been committed.'; \
	  exit 1; }
