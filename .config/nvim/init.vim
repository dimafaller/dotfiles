let mapleader =","
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif
autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'jreybert/vimagit'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'kovetskiy/sxhkd-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'mattn/emmet-vim'
Plug 'ap/vim-css-color'
Plug 'lervag/vimtex'
Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-startify'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'machakann/vim-sandwich'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/gv.vim'
Plug 'preservim/nerdtree'
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
    Plug 'kristijanhusak/defx-git'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()

nnoremap c "_c
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber "the relative number feature
set bg=dark
colorscheme gruvbox
set go=a
set mouse=a
set cursorline "highlitinig the current line
set nohlsearch
set clipboard+=unnamedplus
set ts=4
nnoremap <A-z> :tabp<CR>
nnoremap <A-n> :tabn<CR>
set wildmode=longest,list,full
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
let g:limelight_default_coefficient = 0.7
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
map <leader>f :Goyo \| set bg=dark \| set linebreak<CR>
map <leader>o :setlocal spell! spelllang=ru_ru<CR>
set splitbelow splitright
map Q gq
map <leader>s :!clear && shellcheck %<CR>
nnoremap S :%s//g<Left><Left>
map <leader>c :w! \| !compiler <c-r>%<CR>
map <leader>p :!opout <c-r>%<CR><CR>
autocmd VimLeave *.tex !texclear %
let g:tex_flavor = 'latex'
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
map <leader>v :VimwikiIndex
let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=dark
autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e
autocmd BufWritePost files,directories !shortcuts
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

if &diff
    highlight! link DiffText MatchParen
endif

function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>

" -----Code Generation-----
noremap <leader><Tab> <Esc>/<++><Enter>"_c4l
inoremap <leader><Tab> <Esc>/<++><Enter>"_c4l
vnoremap <leader><Tab> <Esc>/<++><Enter>"_c4l
inoremap .mn <++>
map <leader>b i#!/bin/sh<CR><CR>
autocmd FileType sh inoremap .f ()<Space>{<CR><Tab><++><CR>}<CR><CR><++><Esc>?()<CR>
autocmd FileType sh inoremap .i if<Space>[<Space>];<Space>then<CR><++><CR>fi<CR><CR><++><Esc>?];<CR>hi<Space>
autocmd FileType sh inoremap .ei elif<Space>[<Space>];<Space>then<CR><++><CR><Esc>?];<CR>hi<Space>
autocmd FileType sh inoremap .sw case<Space>""<Space>in<CR><++>)<Space><++><Space>;;<CR><++><CR>esac<CR><CR><++><Esc>?"<CR>i
autocmd FileType sh inoremap .ca )<Space><++><Space>;;<CR><++><Esc>?)<CR>i
autocmd FileType markdown noremap <leader>r i---<CR>title:<Space><++><CR>author:<Space>"Brodie Robertson"<CR>geometry:<CR>-<Space>top=30mm<CR>-<Space>left=20mm<CR>-<Space>right=20mm<CR>-<Space>bottom=30mm<CR>header-includes:<Space>\|<CR><Tab>\usepackage{float}<CR>\let\origfigure\figure<CR>\let\endorigfigure\endfigure<CR>\renewenvironment{figure}[1][2]<Space>{<CR><Tab>\expandafter\origfigure\expandafter[H]<CR><BS>}<Space>{<CR><Tab>\endorigfigure<CR><BS>}<CR><BS>---<CR><CR>
autocmd FileType markdown inoremap .i ![](<++>){#fig:<++>}<Space><CR><CR><++><Esc>kkF]i
autocmd FileType markdown inoremap .a [](<++>)<Space><++><Esc>F]i
autocmd FileType markdown inoremap .1 #<Space><CR><CR><++><Esc>2k<S-a>
autocmd FileType markdown inoremap .2 ##<Space><CR><CR><++><Esc>2k<S-a>
autocmd FileType markdown inoremap .3 ###<Space><CR><CR><++><Esc>2k<S-a>
autocmd FileType markdown inoremap .4 ####<Space><CR><CR><++><Esc>2k<S-a>
autocmd FileType markdown inoremap .5 #####<Space><CR><CR><++><Esc>2k<S-a>
autocmd FileType markdown inoremap .u +<Space><CR><++><Esc>1k<S-a>
autocmd FileType markdown inoremap .o 1.<Space><CR><++><Esc>1k<S-a>
autocmd FileType markdown inoremap .f +@fig:

"Vim Auto Closetag (filenames like *.xml, *.html, *.xhtml, etc)
let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.js,*.tsx'
let g:closetag_xhtml_filenames = '*.xml,*.xhtml,*.jsx,*.js,*.tsx'
let g:closetag_filetypes = 'html,xhtml,jsx,js,tsx'
let g:closetag_xhtml_filetypes = 'xml,xhtml,jsx,js,tsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

"COC Settings
"Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-prettier',
    \ 'coc-tsserver',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-json',
    \ 'coc-angular',
    \ 'coc-vimtex'
    \ ]
set updatetime=300
set nobackup
set nowritebackup
set shortmess+=c
set signcolumn=yes
inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
endfunction
nmap <rn> <Plug>(coc-rename)
augroup mygroup
    autocmd!
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"DEFX
"Bingings start
nnoremap <C-n> :Defx<CR>
nnoremap <silent> <leader>ff :Defx -toggle=0 -search=`expand('%:p')`<CR>
autocmd FileType defx call s:defx_my_settings()
" Define mappings
function! s:defx_my_settings() abort
	nnoremap <nowait><silent><buffer><expr> c
		\ defx#do_action('copy')
	nnoremap <silent><buffer><expr> x
		\ defx#do_action('move')
	nnoremap <nowait><silent><buffer><expr> d
		\ defx#do_action('remove')
	nnoremap <silent><buffer><expr> p
		\ defx#do_action('paste')
	nnoremap <silent><buffer><expr> r
		\ defx#do_action('rename')
	nnoremap <silent><buffer><expr> K
		\ defx#do_action('new_directory')
	noremap <silent><buffer><expr> m
		\ defx#do_action('new_file')
	nnoremap <silent><buffer><expr> M
		\ defx#do_action('new_multiple_files')
	nnoremap <silent><buffer><expr> <CR>
		\ defx#is_directory() ?
		\ defx#do_action('open_or_close_tree') :
		\ defx#do_action('drop')
	nnoremap <silent><buffer><expr> o
		\ defx#is_directory() ?
		\ defx#do_action('open_or_close_tree') :
		\ defx#do_action('drop')
	nnoremap <silent><buffer><expr> <2-LeftMouse>
		\ defx#is_directory() ?
		\ defx#do_action('open_or_close_tree') :
		\ defx#do_action('drop')
	nnoremap <silent><buffer><expr> i
		\ defx#do_action('close_tree')
	nnoremap <silent><buffer><expr> l
		\ defx#do_action('open_directory')
	nnoremap <silent><buffer><expr> h
		\ defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> v
		\ defx#do_action('toggle_select')
	nnoremap <silent><buffer><expr> V
		\ defx#do_action('clear_select_all')
	nnoremap <silent><buffer><expr> *
		\ defx#do_action('toggle_select_all')
	nnoremap <silent><buffer><expr> E
		\ defx#do_action('open', 'vsplit')
	nnoremap <silent><buffer><expr> P
		\ defx#do_action('preview')
	nnoremap <silent><buffer><expr> C
		\ defx#do_action('toggle_columns', 'indent:icon:filename:type:size:time')
	nnoremap <silent><buffer><expr> S
		\ defx#do_action('toggle_sort', 'time')
	nnoremap <silent><buffer><expr> s
		\ defx#do_action('search')
	nnoremap <silent><buffer><expr> !
		\ defx#do_action('execute_command')
	nnoremap <silent><buffer><expr> X
		\ defx#do_action('execute_system')
	nnoremap <silent><buffer><expr> yy
		\ defx#do_action('yank_path')
	nnoremap <silent><buffer><expr> .
		\ defx#do_action('toggle_ignored_files')
	nnoremap <silent><buffer><expr> ;
		\ defx#do_action('repeat')
	nnoremap <silent><buffer><expr> ~
		\ defx#do_action('cd')
	nnoremap <silent><buffer><expr> q
		\ defx#do_action('quit')
	nnoremap <silent><buffer><expr> j
		\ line('.') == line('$') ? 'gg' : 'j'
	nnoremap <silent><buffer><expr> k
		\ line('.') == 1 ? 'G' : 'k'
	nnoremap <silent><buffer><expr> <C-r>
		\ defx#do_action('redraw')
	nnoremap <silent><buffer><expr> <C-g>
		\ defx#do_action('print')
	nnoremap <silent><buffer><expr> cd
		\ defx#do_action('change_vim_cwd')
endfunction

"Defx configs
call defx#custom#option('_', {
  \ 'winwidth': 30,
  \ 'split': 'vertical',
  \ 'direction': 'topleft',
  \ 'show_ignored_files': 0,
  \ 'resume': 1,
  \ 'toggle': 1,
  \ 'columns': 'mark:indent:icon:filename',
  \ })

call defx#custom#column('icon', {
  \ 'directory_icon': '',
  \ 'opened_icon': 'ﱮ',
  \ })

call defx#custom#column('mark', {
  \ 'readonly_icon': '',
  \ 'selected_icon': '',
  \ })

"Defx-git configs
call defx#custom#column('git', 'indicators', {
  \ 'Modified'  : '✹',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ })

"Git Gutter
highlight GitGutterAdd guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
nmap ) <Plug>(GitGutterNextHunk)
nmap ( <Plug>(GitGutterPrevHunk)
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0
let g:gitgutter_highlight_linenrs = 1

"fzf
map ; :Files<CR>
let g:fzf_preview_window = 'right:50%'
