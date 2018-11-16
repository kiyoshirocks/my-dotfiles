"       ┌────────────────────────────────────┐
"       │▌ ▌▗          ▌  ▗   ▛▀▖      ▌     │
"       │▙▞ ▄ ▌ ▌▞▀▖▞▀▘▛▀▖▄   ▙▄▘▞▀▖▞▀▖▌▗▘▞▀▘│
"       │▌▝▖▐ ▚▄▌▌ ▌▝▀▖▌ ▌▐ ▗▖▌▚ ▌ ▌▌ ▖▛▚ ▝▀▖│
"       │▘ ▘▀▘▗▄▘▝▀ ▀▀ ▘ ▘▀▘▝▘▘ ▘▝▀ ▝▀ ▘ ▘▀▀ │
"       └────────────────────────────────────┘
"       --  https://kiyoshirocks.github.io  --
"          It's Kiyoshi's vim settings from:
"       https://github.com/kiyoshirocks/my-vimrc 


" ----------------------------------------------------
" Vundle.vim - vim plugin manager 
" source: https://github.com/VundleVim/Vundle.vim
" ----------------------------------------------------
" 
" usage:
" ,,            toggle NERDTree
" cc            comment line
" cu            uncomment line
" ce            comment to EOL
" Ctrl-n        toggle mouse
" Ctrl-l        toggle wrap
" Ctrl-t        transform tab to space
"
" ----------------------------------------------------
" Setting start
" ----------------------------------------------------
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" add your plugin here

Plugin 'VundleVim/Vundle.vim'                       " required
Plugin 'altercation/vim-colors-solarized'           " solarized theme
Plugin 'scrooloose/nerdtree'                        " file/directory treee
Plugin 'scrooloose/nerdcommenter'                   " code commenter
Plugin 'kien/ctrlp.vim'                             " <Ctrl-p> Fuzzy file, buffer, mru, tag, etc finder
Plugin 'L9'                                         " script library
Plugin 'tomtom/tlib_vim'                            " library
Plugin 'garbas/vim-snipmate'                        " snipmate require
Plugin 'honza/vim-snippets'                         " snippets require
Plugin 'MarcWeber/vim-addon-mw-utils'               " snippets require
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-markdown'
Plugin 'kchmck/vim-coffee-script'



filetype plugin indent on
call vundle#end() 

" ----------------------------------------------------
" vim settings
" ----------------------------------------------------

set number
set ignorecase
set smartcase
set hlsearch
set incsearch
set smartindent
set confirm
set backspace=indent,eol,start
set cmdheight=1
set showcmd
set showmode
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

set wrap
set lbr
set fo+=mB
set mouse=a
syntax enable
syntax on

set encoding=utf-8
set fileencodings=utf-8,utf-16,big5,gb2312,gbk,gb18030,euc-jp,euc-kr,latin1
set fileencoding=utf-8
set fileformats=unix,dos

set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set pastetoggle=<F13>

" ----------------------------------------------------
" theme settings
" ----------------------------------------------------

set background=dark
colorscheme solarized
set t_Co=256

" ----------------------------------------------------
" status bar settings
" ----------------------------------------------------

set laststatus=2

set statusline=%#filepath#
set statusline+=\ %f
set statusline+=\ %#separ_01#

set statusline+=%=

set statusline+=%#filetype#
set statusline+=\ %{strlen(&filetype)?&filetype:'plain'}\ [%{strlen(&fenc)?&fenc:&enc},\ %{&ff}]

set statusline+=\ %#separ_02#
set statusline+=%#position#
set statusline+=\ %3c,%5l/%4L\ [%3p%%]\  

set statusline+=%#separ_03#
set statusline+=%#filesize#
set statusline+=\ %{FileSize()}%{IsBinary()}

hi filepath cterm=none ctermbg=240  ctermfg=40
hi separ_01 cterm=none ctermbg=237  ctermfg=240
hi filetype cterm=none ctermbg=237  ctermfg=45
hi separ_02 cterm=none ctermbg=31   ctermfg=237
hi position cterm=none ctermbg=31   ctermfg=228
hi separ_03 cterm=none ctermbg=34   ctermfg=31
hi filesize cterm=none ctermbg=34   ctermfg=228

hi Search   cterm=NONE ctermbg=24   ctermfg=214
"
" view functions

function IsBinary()
    if (&binary == 0)
        return ""
    else
        return "[Binary] "
    endif
endfunction
function FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return "[E] "
    endif
    if bytes < 1024
        return "[" . bytes . "B]"
    elseif bytes < 1048576
        return "[" . (bytes / 1024) . "KB]"
    else
        return "[" . (bytes / 1048576) . "MB]"
    endif
endfunction


" ----------------------------------------------------
" Key mapping
" ----------------------------------------------------

" nerd tree toggle

" autocmd VimEnter * NERDTree
map <silent>,, :NERDTreeToggle<CR>

" nerd commenter

let g:NERDSpaceDelims=1
map cc          <plug>NERDCommenterComment<CR>
map cu          <plug>NERDCommenterUncomment<CR>
map cs          <plug>NERDCommenterSexy<CR>
map ci          <plug>NERDCommenterInvert<CR>
map cy          <plug>NERDCommenterYank<CR>
map ce          <plug>NERDCommenterToEOL<CR>
map c<space>    <plug>NERDCommenterToggle<CR>

" ----------------------------------------------------
" Functions
" ----------------------------------------------------

" tab to space : ctrl-t

map <C-t> :call TabToSpaces()<CR>
map! <C-t> <Esc>:call TabToSpaces()<CR>
function TabToSpaces()
    retab
    echo "Convert tab to spaces."
endfunction

" toggle wrap : ctrl-l

map <C-l> :call SwitchLineBreakingMode()<CR>
map! <C-l> <Esc>:call SwitchLineBreakingMode()<CR>
function SwitchLineBreakingMode()
    if (&wrap == 0)
        set wrap
        echo "Switch to line breaking mode."
    else
        set nowrap
        echo "Switch to one line mode."
    endif
endfunction

" toggle mouse

map <C-n> :call SwitchMouseMode()<CR>
map! <C-n> <Esc>:call SwitchMouseMode()<CR>
function SwitchMouseMode()
    if (&mouse == "a")
        let &mouse = ""
        echo "Mouse is disabled."
    else
        let &mouse = "a"
        echo "Mouse is enabled."
    endif
endfunction


" ----------------------------------------------------
" Setting end
" ----------------------------------------------------

