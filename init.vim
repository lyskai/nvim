call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'majutsushi/tagbar'
Plug 'morhetz/gruvbox'
" python support
Plug 'numirias/semshi', {'do' : ':UpdateRemotePlugins'}
" 语法检查
Plug 'neomake/neomake'
" 自动补全 感觉没有enable
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'zchee/deoplete-jedi'

Plug 'easymotion/vim-easymotion' " 使用ss 查找两个字母并跳转"
" " 自动补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wellle/tmux-complete.vim'
" " 括号匹配
Plug 'jiangmiao/auto-pairs'
Plug 'davidhalter/jedi-vim'

Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'   "状态栏插件
Plug 'vim-airline/vim-airline-themes' "状态栏插件

" Python
"Plug 'tmhedberg/SimpylFold', { 'for' :['python', 'vim-plug']  }
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug']  }
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug']  }
Plug 'tweekmonster/braceless.vim'
Plug 'vim-scripts/indentpython.vim' " python缩进脚本

Plug 'mhinz/vim-startify'  " 可以显示历史文件
Plug 'kien/ctrlp.vim'  " 文件模糊搜索器

Plug 'universal-ctags/ctags'

"https://zhuanlan.zhihu.com/p/102033129
Plug 'BurntSushi/ripgrep'
Plug 'Yggdroot/LeaderF'  " ======================== ctrlp
Plug 'ludovicchabant/vim-gutentags' " no need cscope anymore
Plug 'junegunn/fzf'
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

let mapleader=","
nmap <leader>tt :TagbarToggle<cr>
nmap <leader>ee :NERDTreeToggle<cr>
let g:winManagerWindowLayout='NERDTree|Tagbar'
let g:tagbar_autofocus = 1
let g:tagbar_usearrows = 1
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"

" === vim-easymotion
nmap ss <Plug>(easymotion-s2)

function! LoadCscope()
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
	let path = strpart(db, 0, match(db, "/cscope.out$"))
	set nocscopeverbose " suppress 'duplicate connection' error
	"print db
	exe "cs add " . db . " " . path
	set cscopeverbose
    endif
endfunction
au BufEnter *  call LoadCscope()

if has("cscope")
	set cscopetag
	set csto=0
	"if filereadable("cscope.out")
	"	cs add cscope.out
	"endif
	"set csverb
	nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

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

let g:tagbar_ctags_bin = 'ctags'
