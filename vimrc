set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'terryma/vim-expand-region'
Plugin 'airblade/vim-gitgutter'
Plugin 'dylanaraps/wal.vim'

Plugin 'sheerun/vim-polyglot'

call vundle#end()            " required
filetype plugin indent on    " required

" Force 256 colors
set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"
set t_ut= " improve screen clearing by using the background color
syntax on
let base16colorspace=256  " Access colors present in 256 colorspace
set background=dark
colorscheme wal
hi Comment ctermfg=LightBlue
set term=screen-256color
let $TERM='screen-256color'
" fix base16 matching parentheses disappearing on cursor
highlight! link MatchParen StatusLine

set enc=utf-8

set guioptions-=r
set guioptions-=l
set guioptions-=L
set guioptions-=R

autocmd StdinReadPre * let s:std_in=1

map <C-n> :NERDTreeToggle<CR>

filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab

let mapleader = "\<Space>"

nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nmap <Leader><Leader> V
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Hide the default mode text (e.g. -- INSERT -- below the statusline)
set noshowmode

set wildmode=full
set wildignore+=*/tmp/*,*.so,*.swp,*/_build/*

" Show trailing whitespace and spaces before a tab:
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\\t/

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Split line (sister to [J]oin lines above)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Delete trailing white space on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
au BufWrite * silent call DeleteTrailingWS()

" Makes foo-bar considered one word
set iskeyword+=-

" Start scrolling 3 lines before the border
set scrolloff=3

" Ruby is an oddball in the family, use special spacing/rules
if v:version >= 703
  " Note: Relative number is quite slow with Ruby, so is cursorline
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 norelativenumber nocursorline
else
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2
endif

" Syntax coloring lines that are too long just slows down the world
" set synmaxcol=128

"speeding up vim by:
set ttyfast " u got a fast terminal
set ttyscroll=3
set lazyredraw " to avoid scrolling problems
set redrawtime=10000

"search visually selected text
vnoremap // y/<C-R>"<CR>

noremap <C-P> :FZF<CR>

" match do/end in ruby
runtime macros/matchit.vim

" ruby path if you are using RVM
let g:ruby_path = system('rvm current')

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Add a bit extra margin to the left
set foldcolumn=2

" Highlight search results
set hlsearch

"Enter disables highlihting
nnoremap <CR> :noh<CR><CR>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Git
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>

"" Tests
noremap <Leader>t :!mix test<CR>
noremap <Leader>T :!mix test %<CR>

" Search like browsers
set incsearch

" Ignore case when lowercase search
:set ignorecase
:set smartcase
