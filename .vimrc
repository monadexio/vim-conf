" NB: helpful commands when hacking this .vimrc:
" ,ev  <-- open .vimrc
" ,rv  <-- reload .vimrc
"
filetype off
execute pathogen#infect()

filetype plugin indent on
set nocompatible
set modelines=0

" Tabs/spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Basic options
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set wildignore+=*.pyc,*.beam,*.dump,*~,*.o,.git,*.png,*.jpg,*.gif
" Disable beeping
" http://vim.wikia.com/wiki/Disable_beeping
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif
set ttyfast
set ruler
set backspace=indent,eol,start
set relativenumber
set laststatus=2

" persistent undo
set undodir=~/.vim/tmp/undo// " backups
set undofile

" Backups
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups

" Leader
let mapleader = ","

" Searching
"nnoremap / /\v
"vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault
" ,<space> clears search result highlights etc
map <leader><space> :let @/=''<cr>
runtime macros/matchit.vim

" Soft/hard wrapping
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=+1

" Use the same symbols as TextMate for tabstops and EOLs
set list
set listchars=tab:▸\ ,eol:¬

" Color scheme (terminal)
syntax on
set background=light
colorscheme peachpuff
hi ColorColumn ctermbg=lightgrey guibg=lightgrey
" hi ColorColumn ctermbg=lightcyan guibg=lightcyan
" hi ColorColumn ctermbg=lightgreen guibg=lightgreen
hi CursorLine cterm=NONE ctermbg=lightgrey guibg=lightgrey

" NERD Tree
map <F2> :NERDTreeToggle<cr>
let NERDTreeIgnore=['\.pyc$', '\.beam$', '\.dump$', '\~$', '^\.']

" For beginners
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
"nnoremap j gj
"nnoremap k gk

" Alt+up/down will go down a 'line', even within one large, wrapped line
map  <A-j> gj
map  <A-k> gk
imap <A-j> <ESC>gji
imap <A-k> <ESC>gki
map  <A-down> gj
map  <A-up> gk
imap <A-down> <ESC>gji
imap <A-up> <ESC>gki


" Scroll-lock-to-centre toggle
map <leader>zz :let &scrolloff=999-&scrolloff<cr>

" Allow minimised splits to use less space
set wmh=0

" Easy buffer navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <leader>w <C-w>v<C-w>l

let g:erlang_folding=1

" Get rid of help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Various syntax stuff
au BufNewFile,BufRead *.escript set filetype=erlang
au BufNewFile,BufRead *.app.src set filetype=erlang
au BufNewFile,BufRead *.app     set filetype=erlang
au BufNewFile,BufRead *.appup   set filetype=erlang
au BufNewFile,BufRead *.erl     set filetype=erlang
au BufNewFile,BufRead rebar.config set filetype=erlang

""au FileType {erl,erlang} au BufWritePost <buffer> silent ! [ -e tags ] &&
""    \ ( awk -F'\t' '$2\!="%:gs/'/'\''/"{print}' tags ; ctags --languages=erlang -f- '%:gs/'/'\''/' )
""    \ | sort -t$'\t' -k1,1 -o tags.new "&& mv tags.new tags

au BufNewFile,BufRead *.m*down set filetype=markdown
au BufNewFile,BufRead *.m*down nnoremap <leader>1 yypVr=
au BufNewFile,BufRead *.m*down nnoremap <leader>2 yypVr-
au BufNewFile,BufRead *.m*down nnoremap <leader>3 I### <ESC>

" Sort CSS
map <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:let @/=''<CR>

" Clean whitespace
map <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Ack
map <leader>a :Ack

" " Yankring
" nnoremap <silent> <F3> :YRShow<cr>
" nnoremap <silent> <leader>y :YRShow<cr>

" Formatting, TextMate-style
map <leader>q gqip

nmap <leader>m :make<cr>

" Google's JSLint
"nmap <silent> <leader>ff :QFix<cr>
"nmap <leader>fn :cn<cr>
"nmap <leader>fp :cp<cr>
"
"command -bang -nargs=? QFix call QFixToggle(<bang>0)
"function! QFixToggle(forced)
"  if exists("g:qfix_win") && a:forced == 0
"    cclose
"    unlet g:qfix_win
"  else
"    copen 10
"    let g:qfix_win = bufnr("$")
"  endif
"endfunction

" Easier linewise reselection
map <leader>v V`]

" Faster Esc (hit jj in insert mode)
inoremap jj <ESC>

" Edit .vimrc
nmap <leader>ev :e $MYVIMRC<cr>
" Reload .vimrc
nmap <leader>rv :source $MYVIMRC<cr>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Disable useless HTML5 junk
let g:event_handler_attributes_complete = 0
let g:rdfa_attributes_complete = 0
let g:microdata_attributes_complete = 0
let g:atia_attributes_complete = 0

" Shouldn't need shift
nnoremap ; :

" Save when losing focus
"au FocusLost * :wa

" Stop it, hash key
inoremap # X<BS>#

" workround pathogen and vim session conflict
" https://github.com/tpope/vim-pathogen/issues/16
set sessionoptions-=options

set path+=**

augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" via: http://whynotwiki.com/Vim
" Ruby
" Use v or # to get a variable interpolation (inside of a string)}
" ysiw#   Wrap the token under the cursor in #{}
" v...s#  Wrap the selection in #{}
let g:surround_113 = "#{\r}"   " v
let g:surround_35  = "#{\r}"   " #

" Select text in an ERb file with visual mode and then press s- or s=
" Or yss- to do entire line.
let g:surround_45 = "<% \r %>"    " -
let g:surround_61 = "<%= \r %>"   " =

" Existing instructions can be found within Vim7 using
" :h ft-syntax-omni
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype * setlocal omnifunc=syntaxcomplete#Complete
endif

let g:yankring_enabled = 0

let g:ycm_extra_conf_globlist = ['~/']
let g:ycm_confirm_extra_conf = 0
let g:ycm_show_diagnostics_ui = 0

let g:html_exclude_tags = ['html']
