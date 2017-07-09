" syntax highlighting

set nocompatible              " be iMproved, required
set bg=dark
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"
" " The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'craigemery/vim-autotag'
Plugin 'scrooloose/nerdtree'
Plugin 'rust-lang/rust.vim'
Plugin 'xolox/vim-misc'
Plugin 'Valloric/YouCompleteMe'
Plugin 'gberenfield/dotvim'
Plugin 'xolox/vim-easytags'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-markdown'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'elzr/vim-json'
Plugin 'tomtom/tinykeymap_vim'
Plugin 'uarun/vim-protobuf'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/taglist.vim'
Plugin 'chrisbra/csv.vim' 
Plugin 'racer-rust/vim-racer'
"
" " All of your Plugins must be added before the following line
call vundle#end()            " required
" filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line

set bg=dark
syntax on
colorscheme elflord

set ruler
set number
set smarttab
set fileformats=unix,dos,mac " support all three, in this order
set formatoptions=tcqor " t=text, c=comments, q=format with "gq", o,r=autoinsert comment leader
set cindent " indent on cinwords set shiftwidth=3                " set shiftwidth to 3 spaces" 
set tabstop=3                   " set tab to 3 spaces
set showmatch                   " Show matching brackets/braces/parantheses.
set background=dark     " set background to dark
set showcmd                             " Show (partial) command in status line.
set autowrite                   " Automatically save before commands like :next and :make
set textwidth=98                " My terminal is 98 characters wide
set visualbell                          " Silence the bell, use a flash instead
set cinoptions=:.5s,>1s,p0,t0,(0,g2     " :.5s = indent case statements 1/2 shiftwidth
set cinwords=if,else,while,do,for,switch,case,class,try   " Which keywords should indent
set showmatch
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%02l,%02v]\ [%p%%]\ [LEN=%L] "Shows detailed status line with formatting
set laststatus=2 "This Makes the status bar visible
set mat=5
set tabstop=3 shiftwidth=3 expandtab
filetype plugin on
filetype indent on
set modeline
set mouse=a
set nocompatible
set cryptmethod=blowfish
" vimrc file for following the coding standards specified in PEP 7 & 8.
"
" To use this file, source it in your own personal .vimrc file (``source
" <filename>``) or, if you don't have a .vimrc file, you can just symlink to it
" (``ln -s <this file> ~/.vimrc``).  All options are protected by autocmds
" (read below for an explanation of the command) so blind sourcing of this file
" is safe and will not affect your settings for non-Python or non-C files.
"
"
" All setting are protected by 'au' ('autocmd') statements.  Only files ending
" in .py or .pyw will trigger the Python settings while files ending in *.c or
" *.h will trigger the C settings.  This makes the file "safe" in terms of only
" adjusting settings for Python and C files.
"
" Only basic settings needed to enforce the style guidelines are set.
" Some suggested options are listed but commented out at the end of this file.

" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
au BufRead,BufNewFile *py,*pyw,*.c,*.h,*.pl,*.pm  set tabstop=3

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python and PHP: 3 spaces
" C and perl : tabs (pre-existing files) or 3 spaces (new files)
au BufRead,BufNewFile *.py,*pyw,*.php set shiftwidth=3
au BufRead,BufNewFile *.py,*.pyw,*.php set expandtab

" These are the bufreads for rust-tags
autocmd BufRead *.rs :setlocal tags=./rusty_tags.vi;/
autocmd BufWrite *.rs :silent! exec "!rusty_tags vi --quite --start-dir=" .expand(%:p:h') . "&"
autocmd BufRead *.rs :setlocal  tags=./.rusty_tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi 


fu Select_c_style()
  if search('^\t', 'n', 150)
    set shiftwidth=3
    set noexpandtab
  el 
    set shiftwidth=3
    set expandtab
  en
endf
au BufRead,BufNewFile *.c,*.h,*.pl,*.pm,*.php call Select_c_style()
au BufRead,BufNewFile Makefile* set noexpandtab

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.pl,*.pm,*.php match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" Python: 79 
" C: 79
" Perl: 79
" PHP: 79
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.pl,*.pm,*.php set textwidth=79

" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" Python and Perl: not needed
" C: prevents insertion of '*' at the beginning of every line in a comment
au BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r

" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.
" Python: yes
" C: yes
" Perl: yes
au BufNewFile *.py,*.pyw,*.c,*.h,*.pm,*.php set fileformat=unix

" These commands set up the program to read a binary file as a hex file
augroup Binary
   autocmd!
   autocmd BufReadPre *.bin let &bin=1
   autocmd BufReadPost *.bin if &bin | %!xxd
   autocmd BufReadPost *.bin set ft=xxd | endif
   autocmd BufWritePre *.bin if &bin | %!xxd -r
   autocmd BufWritePre *.bin endif
   autocmd BufWritePost *.bin if &bin | %!xxd
   autocmd BufWritePost *.bin set nomod | endif
augroup END

set encoding=utf=8

" ----------------------------------------------------------------------------
" The following section contains suggested settings.  While in no way required
" to meet coding standards, they are helpful.

" Set the default file encoding to UTF-8: ``set encoding=utf-8``

" Puts a marker at the beginning of the file to differentiate between UTF and
" UCS encoding (WARNING: can trick shells into thinking a text file is actually
" a binary file when executing the text file): ``set bomb``

" For full syntax highlighting:
"``let python_highlight_all=1``
"``syntax on``

" Automatically indent based on file type: ``filetype indent on``
" Keep indentation level from previous line: ``set autoindent``

" Folding based on indentation: ``set foldmethod=indent``

" Show tabs and trailing spaces.
" Ctrl-K >> for »
" Ctrl-K .M for ·
" (use :dig for list of digraphs)

" my perl includes pod
let perl_include_pod = 1
" syntax color complex things like @{${"foo"}}
let perl_extended_vars = 1

" Fold the code block when <F2> is pressed
"set foldmethod=indent
nmap <F2> 0v%zf

syntax on
filetype plugin indent on

" Change backup directory to a standard one
set backupdir=~/.vimtmp
set directory=~/.vimtmp

"Configuration for pydiction
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'

" These are my mappings of my function keys
nmap <F5> :NERDTreeToggle<CR>
nmap <F6>  :TlistToggle<CR>
nmap <F7> :TagbarToggle<CR>

" These allow me to automatically run NERDTree when opening vim
" autocmd VimEnter * TlistOpen
" autocmd VimEnter * NERDTree 
map <leader>gt:call TimeLapse() <CR>
let g:zipPlugin_ext = '*.zip,*.jar,*.xpi,*.ja,*.war,*.ear,*.celzip,*.oxt,*.kmz,*.wsz,*.xap,*.docx,*.docm,*.dotx,*.dotm,*.potx,*.potm,*.ppsx,*.ppsm,*.pptx,*.pptm,*.ppam,*.sldx,*.thmx,*.crtx,*.vdw,*.glox,*.gcsx,*.gqsx'
