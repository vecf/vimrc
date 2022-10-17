" Required to test changes without installing plugins
" Disable compatibility with vi which can cause unexpected issues.
set nocompatible
syntax on

" Automatic install of vimplug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install plugins using vimplug
call plug#begin()
" Plug 'taketwo/vim-ros'
Plug 'tpope/vim-commentary'
" Plug 'tmhedberg/SimpylFold' "Python folding (ok)
" Plug 'preservim/nerdtree' "Tree browser with copy for dirs etc (ok)
" Plug 'lambdalisue/fern.vim' "Tree browser with copy for dirs etc (bad)
" Plug 'dkarter/bullets.vim' "Markdown automatic bullets (bad)
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""" KEYMAPPINGS
""""""""""""""""""""""" PHILOSOPHY STARTS: <ESC> means <C-W>
" NAVIGATE BETWEEN WINDOWS USING ALT KEY
nnoremap <Esc>h <C-w>h
nnoremap <Esc>j <C-w>j
nnoremap <Esc>k <C-w>k
nnoremap <Esc>l <C-w>l
  " get out of terminal with alt mappings also
tmap <Esc>h <C-w>h
tmap <Esc>j <C-w>j
tmap <Esc>k <C-w>k
tmap <Esc>l <C-w>l

" QUITTING
noremap <Esc>q <C-w>q
  " uniformity extension: (breaks with philosohpy, but increases uniformity)
  " sending <C-w>q to a term in normal mode won't quit it becase a job is
  " still running. 
  "
  " When a terminal is in insert mode, the normal and insert mode mappings are
  " used. Which purposely don't have ! appended to avoid data loss. TODO
  " ...what to make of this?
tmap <Esc>q <C-w>:q!<CR> 
" tmap <Esc>q <C-d>|" cleaner mapping achieves the same (inferior) result

""""""""""""""""""""""" PHILOSOPHY ENDS: <ESC> means <C-W>

""""""""""""""""""""""" Byobu-like mappings start
" NOT PERFECT, BUT WORKABLE RESIZING
nnoremap <Esc>K <C-w>+
nnoremap <Esc>J <C-w>-
nnoremap <Esc>L <C-w>>
nnoremap <Esc>H <C-w><
tmap <Esc>K <C-w>+
tmap <Esc>J <C-w>-
tmap <Esc>L <C-w>>
tmap <Esc>H <C-w><
"TODO arrows!
""""""""""""""""""""""" Byobu-like mappings end

""""""""""""""""""""""" Own inventions start
" terminal insert mode related
" paste yanked text with <alt>-p in terminal
tmap <Esc>p <C-w>""
" just wait a bit for terminal to go into normal mode
tmap <Esc> <C-w>N

" changing tabs
" t is for tab
nnoremap <Esc>t gt
inoremap <Esc>t <Esc>gt
nnoremap <Esc>T gT
inoremap <Esc>T <Esc>gT
tmap <Esc>t <C-w>gt
tmap <Esc>T <C-w>gT

" tabedit vimrc
" c is for configure
nnoremap <Esc>c :tabedit ~/.vimrc<CR>
inoremap <Esc>c <Esc>:tabedit ~/.vimrc<CR>
tmap <Esc>c <C-w>:tabedit ~/.vimrc<CR>

" source vimrc
" no mnemonic for b
nnoremap <Esc>b :source ~/.vimrc<CR>
inoremap <Esc>b <Esc>:source ~/.vimrc<CR>
tmap <Esc>b <C-w>:source ~/.vimrc<CR>

" saving
" w is for write
nnoremap <Esc>w :w<CR> 
inoremap <Esc>w <Esc>:w<CR>

""""""""""""""""""""""" Own inventions end

" preferences
set showcmd
set expandtab
set shiftwidth=2 softtabstop=2 tabstop=2 " todo for markdown files only
" search highlighting
set hls
" ... and its companion: you want search highlighting only until you start editing!
" TODO why does this not expand recursively and put you in an infinite loop?
nnoremap i :noh<CR>i
set mouse=nv "Press : to get normal terminal mouse
set noequalalways

"vim-ros settings
" TODO

" Netrw customizations this really does not work well to
" copy/move/paste/delete files and directories (sadly)
" let g:netrw_preview = 1   " Open previews to the right
" let g:netrw_liststyle= 3  " Tree becomes default style
" let g:netrw_banner = 0    " Disable banner
" let g:netrw_keepdir = 0  " Change to browse dir

" wishlist
" clipboard integration (just switch to nvim?)
" shortcut for vimgrepping recursively for keyword under cursor
" Join windows and move windows
" get alt-q to still work if a command is half typed in normal mode
" in netrw automatically be in search mode from the start

""""""""""""""""""""""""""""""""""""""""""""""""""""" BUGS
" Doing git commit using vim inside a terminal cannot discern where the exit
" should go.

""""""""""""""""""""""" WINDOWING
" Set to split on right and below by default
set splitright splitbelow

" prefixing w to all window mnemonics helps to not put timeouts on things like dd
" since vim has no other possible following chars to wait for.
" it also makes all vim window related commands completely uniform:
" window (duplicate|new|explore|terminal) (tab|split|vertical|replace)
" basically, that is 'window what where'
" This makes window manipulation a sort of language in vim!

" TODO many of these do not work in netrw?
" TODO implement zoom
" wdt can kind of work like zoom, but the issue is if it is used on terminals, 
" TODO C-^ doesn't work like one would expect for the explorer case.
" it causes a lot of typing and freezes the terminal, which is not what a real zoom does. So maybe an additional zoom is good.

" Open a new terminal
noremap wtt :tab term<CR>
noremap wts :term<CR>
noremap wtv :vert term<CR>
noremap wtr :term ++curwin<CR>

" Duplicate the current buffer
noremap wdt :tab split<CR>
noremap wds :split<CR>
noremap wdv :vsplit<CR>
noremap wdr :echo('window duplicate replace is a nop!')<CR>

" Open a new empty buffer
noremap wnt :tab new<CR>
noremap wns :new<CR>
noremap wnv :vert new<CR>
noremap wnr :enew<CR>

" Open a new explorer tab in the current files directory
noremap wet :Texplore<CR>
noremap wes :Sexplore<CR>
noremap wev :Vexplore<CR>
noremap wer :Explore<CR>
""""""""""""""""""""""" WINDOWING ENDS

" TODO
" sudo command from non-sudo vim
