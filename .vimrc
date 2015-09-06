"--------------------------------------------------------------------------
" neobundle
set nocompatible               " Be iMproved
filetype off                   " Required!

" キーボードのBackspaceを有効にする
set backspace=indent,eol,start

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'rhysd/github-complete.vim'
NeoBundle 'itchyny/lightline.vim'
" VimでRailsを使う
NeoBundle 'tpope/vim-rails'
" vimでslimを使う
NeoBundle 'slim-template/vim-slim'
" Ruby向けにendを自動挿入してくれる
NeoBundle 'tpope/vim-endwise'
" ファイルオープンを便利に
NeoBundle 'Shougo/unite.vim'
" Unite.vimで最近使ったファイルを表示できるようにする
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'basyura/unite-rails'
" コメントON/OFFを手軽に実行
NeoBundle 'tomtom/tcomment_vim'
" ファイルをtree表示してくれる
NeoBundle 'scrooloose/nerdtree'
" Color Theme
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'chriskempson/vim-tomorrow-theme'
" Gitを便利に使う
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'tpope/vim-fugitive'
call neobundle#end()

filetype plugin indent on     " Required!

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

set laststatus=2
set t_Co=256
let g:lightline = {
      \ 'colorscheme': 'wombat'
      \ }

" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
""""""""""""""""""""""""""""""
" Unit.vimの設定
""""""""""""""""""""""""""""""
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" colorscheme
""""""""""""""""""""""""""""""
syntax on
set background=dark
if ($ft=='ruby')
  colorscheme Tomorrow-Night
else
  colorscheme hybrid
endif
""""""""""""""""""""""""""""""

"------------------------------------
"" Unite-rails.vim↲
"------------------------------------
""{{{
function! UniteRailsSetting()
  nnoremap <buffer><C-V>           :<C-U>Unite rails/view<CR>
  nnoremap <buffer><C-M>           :<C-U>Unite rails/model<CR>
  nnoremap <buffer><C-C>           :<C-U>Unite rails/controller<CR>
  nnoremap <buffer><C-C>c          :<C-U>Unite rails/config<CR>
  nnoremap <buffer><C-S>           :<C-U>Unite rails/spec<CR>
  nnoremap <buffer><C-H>m          :<C-U>Unite rails/db -input=migrate<CR>
  nnoremap <buffer><C-L>l          :<C-U>Unite rails/lib<CR>
  nnoremap <buffer><expr><C-H>g    ':e '.b:rails_root.'/Gemfile<CR>'
  nnoremap <buffer><expr><C-H>r    ':e '.b:rails_root.'/config/routes.rb<CR>'
  nnoremap <buffer><expr><C-H>se    ':e '.b:rails_root.'/db/seeds.rb<CR>'
  nnoremap <buffer><C-H>ra          :<C-U>Unite rails/rake<CR>
  nnoremap <buffer><C-H>h          :<C-U>Unite rails/heroku<CR>
endfunction
aug MyAutoCmd
  au User Rails call UniteRailsSetting()
aug END
"}}}

""""""""""""""""""""""""""""""
" 各種オプションの設定
""""""""""""""""""""""""""""""
" 行番号を表示する
set number
" カーソル行の背景色を変える
set cursorline
" タブ入力を複数の空白入力に置き換える
set expandtab
" 画面上でタブ文字が占める幅
set tabstop=2
" 自動インデントでずれる幅
set shiftwidth=2
" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=2
" 開業時に前の行のインデントを継続する
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデント増減する
set smartindent
" マウス入力を付けつける
set mouse=a
""""""""""""""""""""""""""""""
