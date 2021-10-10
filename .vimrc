"______________/**** GENERAL ****\____________________
syntax on                         " Enable syntax highlighting
set backspace=indent,eol,start    " Make backspace work over multiple lines
set colorcolumn=80                " Enables the vertical column position
set cursorline                    " Show line below cursor
set laststatus=2                  " Show the statusline
set mouse=a                       " Enables mouse activity
set nobackup                      " what it says
set nocompatible                  " Make VIM work better rather than be VI compatible
set noswapfile                    " what it says
set number                        " Enable line numbers in gutter
set numberwidth=5                 " Make the line number gutter wide
set tabpagemax=50                 " Enables multiple files open at one time
"______________/**** PLUGINS ****\____________________
call plug#begin('~/.vim/plugged') " load plugins
Plug 'w0rp/ale'                   " language server support
Plug 'mattn/emmet-vim'            " html template scaffolding
Plug 'zivyangll/git-blame.vim'    " git blame support
Plug 'nanotech/jellybeans.vim'    " colorscheme
Plug 'martinda/Jenkinsfile-vim-syntax' " what it says on the label
Plug 'vim-airline/vim-airline'    " idk
Plug 'vim-airline/vim-ariline-themes' " idk
Plug 'fatih/vim-go'               " gofmt, gopls, delve
Plug 'plasticboy/vim-markdown'    " markdown syntax highlighting
Plug 'leafOfTree/vim-svelte-plugin' " svelte syntax highlighting
call plug#end()
"______________/**** COLORS  ****\____________________
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
let g:jellybeans_use_term_italics = 1
colorscheme jellybeans
"______________/**** TABS   ****\_____________________
set tabstop=2                     " Tab indention levels every four columns
set shiftwidth=2                  " Indent/outdent by four columns
set expandtab                     " Convert all tabs that ar typed into spaces
set shiftround                    " Always indent/outdent to nearest tabstop
set smarttab                      " Use shiftwidths at left margin, tabstop everywhere else
"______________/**** SEARCH ****\_____________________
set incsearch                     " Lookahead as search pattern is specified
set ignorecase                    " Ignore case in all searches...
set smartcase                     " ...unless uppercase letters used
set hlsearch                      " Highlight all matches
highlight clear search            " TBD
highlight search ctermfg=164      " Pinkish purple
"______________/**** FORMAT ****\_____________________
set list listchars=tab:⇥␣,trail:␣ " Highlight whitespace
set autoindent                    " Retain indentation on next line
set smartindent                   " Turn on autoindenting of blocks
set copyindent
"______________/*** MAPPINGS ***\_____________________
ino jj <esc>
noremap ; :
noremap <space> :noh<return>
let mapleader=','
noremap <Leader>W :w !sudo tee % > /dev/null
noremap <Leader>f :ALEFix<return>
noremap <Leader>h :ALEHover<return>
noremap <Leader>d :ALEGoToDefinition<return>
noremap <Leader>r :ALEFindReferences<return>
noremap <Leader>j :ALENext<return>
noremap <Leader>k :ALEPrevious<return>j
noremap <Leader>? :ALEDetail<return>
noremap <Leader>t :ALEGoToTypeDefinitionInSplit<return>
noremap <Leader>i :ALEInfo<return>
noremap <Leader>b :<C-u>call gitblame#echo()<CR>
" _____________/**** ALE     ****\____________________
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_completion_enabled=1     " Enable Ale Code Completion
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'html': ['prettier']
\}
let g:ale_linters = {
\   'html': []
\}
let g:ale_linter_aliases = {}
" _____________/**** FILETYPE **\____________________

" Emmet
" enable emmet for html & css only
let g:user_emmet_install_global = 0
autocmd FileType gohtmltmpl,html,css EmmetInstall

" Makefiles
autocmd FileType make setlocal noexpandtab

autocmd BufRead,BufNewFile *.tsv set filetype=tsv
autocmd FileType tsv setlocal noexpandtab

" Go
let g:ale_go_langserver_executable = 'gopls' " Use gopls language server
let g:go_code_completion_enabled=0           " Disable Go Code Completion
let g:ale_fixers['go'] = ['gofmt', 'goimports']
let g:ale_fixers['gohtmltmpl'] = ['prettier']
let g:ale_linters['go'] = ['gopls', 'golint', 'govet', 'gometalinter']
let g:go_highlight_types = 0
let g:go_fmt_fail_silently = 1
let g:go_fmt_autosave = 0
let g:go_auto_type_info = 0 " conflicts with Ale hover for issues
autocmd BufRead,BufNewFile *.tmpl set filetype=gohtmltmpl
autocmd FileType gohtmltmpl set tabstop=2
autocmd FileType gohtmltmpl set shiftwidth=2
autocmd FileType go setlocal noexpandtab
autocmd FileType go setlocal list& listchars&
autocmd FileType go noremap <leader><tab> :GoTest<return>
autocmd FileType go noremap <leader>gcc :GoCoverageClear<return>
autocmd FileType gohtmltmpl let b:ale_javascript_prettier_options = '--parser=html'

" JavaScript
let g:ale_fixers['javascript'] = ['eslint', 'prettier']
let g:ale_linters['javascript'] = ['eslint']

" Svelte
let g:ale_fixers['svelte'] = ['eslint', 'prettier']
let g:ale_linters['svelte'] = ['eslint', 'svelteserver']
let g:vim_svelte_plugin_use_typescript=1

" TypeScript
let g:ale_fixers['typescript'] = ['eslint', 'prettier']
let g:ale_fixers['typescriptreact'] = ['eslint', 'prettier']
