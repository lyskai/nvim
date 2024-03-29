call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'majutsushi/tagbar'
Plug 'morhetz/gruvbox'
" 语法检查
Plug 'neomake/neomake'
Plug 'easymotion/vim-easymotion' " 使用ss 查找两个字母并跳转

" 自动补全 感觉没有enable
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'zchee/deoplete-jedi'
" " 自动补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wellle/tmux-complete.vim'
" " 括号匹配
Plug 'jiangmiao/auto-pairs'

Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'   "状态栏插件
Plug 'vim-airline/vim-airline-themes' "状态栏插件

" Python
"Plug 'tmhedberg/SimpylFold', { 'for' :['python', 'vim-plug']  }
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug']  }
Plug 'numirias/semshi', {'do' : ':UpdateRemotePlugins'}
Plug 'tweekmonster/braceless.vim'
Plug 'vim-scripts/indentpython.vim' " python缩进脚本
"Plug 'davidhalter/jedi-vim' "python 语法自动提示

" ========================================
Plug 'mhinz/vim-startify'  " 可以显示历史文件
Plug 'kien/ctrlp.vim'  " 文件模糊搜索器

Plug 'universal-ctags/ctags'

"https://zhuanlan.zhihu.com/p/102033129
Plug 'BurntSushi/ripgrep'
Plug 'Yggdroot/LeaderF'  " ======================== ctrlp
Plug 'ludovicchabant/vim-gutentags' " no need cscope anymore  => Auto Generate tags
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'

" Git
Plug 'junegunn/gv.vim'  " 查看提交记录
Plug 'tpope/vim-fugitive'  " git插件
Plug 'theniceboy/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }
Plug 'airblade/vim-gitgutter'  "vim显示文件变动

call plug#end()

colorscheme gruvbox

set showmatch
set mouse=v
" show line number
set nu
" highlight current line
set cursorline

" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 0

" " open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"

set syntax=on
set noexpandtab
set tabstop=8
set shiftwidth=8
set autoindent
set listchars=tab:>-,trail:-
set list
set ruler

"Add spell check
setlocal spell

" vim-fugitive
set splitbelow
let mapleader=","
nmap <leader>t :TagbarToggle<cr>
nmap <leader>e :NERDTreeToggle<cr>
let g:winManagerWindowLayout='NERDTree|Tagbar'
let g:tagbar_autofocus = 1
let g:tagbar_usearrows = 1
let g:tagbar_iconchars = ['+', '+']
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"
"let g:NERDTreeMinimalUI = 1
"let g:NERDTreeChDirMode = 2

" === vim-easymotion
nmap ss <Plug>(easymotion-s2)

if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		\| exe "normal! g'\"" | endif
endif

" close nerdtree if it's the last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"if &term == "linux"
"	set t_ti=^[[?1049h
"	set t_te=^[[?1049l
"endif  

"set tags=tags;
"set autochdir
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 .cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('/local/mnt/workspace/kaliu/local/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
"检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数 "
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

"let g:gutentags_trace = 1

let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = max([25, winwidth(0) / 5])

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <C-g> :Rg<Cr>
"vim fzf search word under cursor
nnoremap <silent><Leader>s :Rg <C-R><C-W><CR>

" Use tab for completion
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
