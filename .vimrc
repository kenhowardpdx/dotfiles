syntax on
call plug#begin('~/.vim/plugged')
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'w0rp/ale'
Plug 'nanotech/jellybeans.vim'
Plug 'zivyangll/git-blame.vim'
Plug 'fatih/vim-go'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()
"__________/ General Settings \_______________________________________________
set nocompatible   " Make VIM work better rather than be VI compatible
set backspace=indent,eol,start
set number
set numberwidth=5
set cursorline
set cursorcolumn
set nobackup
set noswapfile
set laststatus=2

" _________/ ALE Settings \__________________________________________________
" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_go_langserver_executable = 'gopls'
let g:ale_completion_enabled=1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'go': ['gofmt', 'goimports'],
\   'html': ['prettier'],
\   'gohtmltmpl': ['prettier'],
\   'javascript': ['eslint', 'prettier'],
\   'json': ['jq'],
\   'typescript': ['eslint', 'prettier']
\}
let g:ale_linters = {
\ 'go': ['gopls', 'golint', 'govet', 'gometalinter'],
\ 'javascript': ['eslint'],
\ 'html': []
\}
" Other stuff
let g:go_code_completion_enabled = 0

"__________/ Colors \_________________________________________________________
" Italics handling
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
" Theme
let g:jellybeans_use_term_italics = 1
colorscheme jellybeans
set colorcolumn=80
set mouse=a
set tabpagemax=50
syntax on

"__________/ Tab handling \___________________________________________________
set tabstop=2      " Tab indentation levels every four columns
set shiftwidth=2   " Indent/outdent by four columns
set expandtab      " Convert all tabs that are typed into spaces
set shiftround     " Always indent/outdent to nearest tabstop
set smarttab       " Use shiftwidths at left margin, tabstop everywhere else

"__________/ Set up smarter search options \__________________________________
set incsearch " Lookahead as search pattern is specified
set ignorecase " Ignore case in all searches...
set smartcase " ...unless uppercase letters used
set hlsearch " Highlight all matches
highlight clear search
highlight       search ctermfg=164 " Pinkish purple

"__________/ Highlight Whitespace \___________________________________________
set list listchars=tab:⇥␣,trail:␣

"__________/ Fix smartindent stupidities \____________________________________
set autoindent  " Retain indentation on next line
set smartindent " Turn on autoindenting of blocks
set copyindent

"__________/ Key Mappings \___________________________________________________
ino jj <esc>
noremap ; :
noremap <space> :noh<return>
let mapleader=','
noremap <Leader>W :w !sudo tee % > /dev/null
" noremap <Leader>j :SyntasticCheck<return>
noremap <Leader>f :ALEFix<return>
noremap <Leader>h :ALEHover<return>
noremap <Leader>d :ALEGoToDefinitionInSplit<return>
noremap <Leader>r :ALEFindReferences<return>
noremap <Leader>j :ALENext<return>
noremap <Leader>k :ALEPrevious<return>j
noremap <Leader>? :ALEDetail<return>
noremap <Leader>t :ALEGoToTypeDefinitionInSplit<return>
noremap <Leader>i :ALEInfo<return>
noremap <Leader>b :<C-u>call gitblame#echo()<CR>

" Makefile files
autocmd FileType make setlocal noexpandtab

" TSV files
autocmd BufRead,BufNewFile *.tsv set filetype=tsv
autocmd FileType tsv setlocal noexpandtab

" Go files
let g:go_highlight_types = 0
let g:go_fmt_fail_silently = 1
let g:go_fmt_autosave = 0
let g:go_auto_type_info = 1 " conflicts with Ale hover for issues
autocmd FileType go setlocal noexpandtab
autocmd FileType go setlocal list& listchars&
autocmd FileType go noremap <leader><tab> :GoTest<return>
autocmd FileType go noremap <leader>gc :GoCoverage<return>
autocmd FileType go noremap <leader>gcc :GoCoverageClear<return>

" Go HTML files
autocmd BufRead,BufNewFile *.tmpl set filetype=gohtmltmpl
autocmd FileType gohtmltmpl set tabstop=2
autocmd FileType gohtmltmpl set shiftwidth=2
autocmd FileType gohtmltmpl let b:ale_javascript_prettier_options = '--parser=html'