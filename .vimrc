" 全局绑定按钮
let g:mapleader = ' '

" 自动安装plug管理插件
if empty(glob("/usr/share/vim/vim81/autoload/plug.vim"))
    execute '!sudo curl -fLo /usr/share/vim/vim81/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/vimplugin')

	Plug 'bling/vim-airline'
	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'ervandew/supertab'  
	Plug 'vim-scripts/pydoc.vim'

	" =========================YouCompleteMe====================================
    function! BuildYCM(info)
    " info is a dictionary with 3 fields
    " - name:   name of the plugin
    " - status: 'installed', 'updated', or 'unchanged'
    " - force:  set on PlugInstall! or PlugUpdate!
    	if a:info.status == 'installed' || a:info.force
    		!python install.py --clang-completer
    	endif
    endfunction
    Plug 'Valloric/YouCompleteMe', {'do' : function('BuildYCM'), 'for' : ['c', 'cpp', 'h', 'python' ]}
    "=========================YouCompleteMe====================================

	Plug 'godlygeek/tabular'
	Plug 'plasticboy/vim-markdown'
	
    Plug 'iamcco/mathjax-support-for-mkdp'
    Plug 'iamcco/markdown-preview.vim'
	Plug 'w0rp/ale'
	Plug 'google/yapf'
	Plug 'timothycrosley/isort'
	Plug 'skywind3000/asyncrun.vim'

    Plug 'Chiel92/vim-autoformat', {'for' : ['html','js']}

	Plug 'takac/vim-fontmanager'

call plug#end()

" 文件树 
let NERDTreeWinPos='left'
let NERDTreeWinSize=18
map <leader>f :NERDTreeToggle<CR>

" air-line 插件配置
set laststatus=2
"打开tabline功能,方便查看Buffer和切换,省去了minibufexpl插件
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 2
nnoremap <C-tab> :bn<CR>
nnoremap <C-s-tab> :bp<CR>

" Youcompleme 设置
" 两个字符后开始进行符号的语义补全
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 0
"let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
"set completeopt=menu,menuone

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }
let g:ycm_filetype_whitelist = { 
			\ "c":1,
			\ "cpp":1, 
			\ "h":1,
			\ "python":1,
			\ "py":1
			\ }


" 自动整理python import 包autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>
" 自动针对python 进行代码格式化autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>

"""""""""""""""""""""""""""
" Quick Compile And Run
"""""""""""""""""""""""""""
" rp runpython 执行当前python文件
nmap <Leader>rp :AsyncRun python %<CR>
" q 快速退出quickfix
nmap <Leader>q  :cclose<CR>
" rs close 当前执行job
nmap <leader>rs :AsyncStop
" 自动执行打开quickfix 6行
let g:asyncrun_open = 6

" 异步语法检查" ale-setting {{{
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = 'X'
let g:ale_sign_warning = '?'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['X %d', '? %d', ' OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"打开文件时不进行检查let g:ale_lint_on_enter = 0

"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>
"使用clang对c和c++进行语法检查，对python使用pylint进行语法检查" let g:ale_linters = {
" \   'c++': ['clang'],
" \   'c': ['clang'],
" \   'python': ['pylint'],
" \}
" }}}

if has('multi_byte_ime')
	"未开启IME时光标背景色
	hi Cursor guifg=bg guibg=Orange gui=NONE
	"开启IME时光标背景色
	hi CursorIM guifg=NONE guibg=Skyblue gui=NONE
	" 关闭Vim的自动切换IME输入法(插入模式和检索模式)
	set iminsert=0 imsearch=0
	" 插入模式输入法状态未被记录时，默认关闭IME
	"inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

let g:asyncrun_encs='gbk'


" -----------------------------------------------------------------------------
"  < Xjy 使用习惯配置 >
" -----------------------------------------------------------------------------
" 快速编辑rc文件
"nmap <Leader>rc :tabedit $VIM/_vimrc<CR>
nmap <leader>rc :tabedit ~/.vimrc<CR>			

filetype plugin on

"文件编码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set encoding=utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" 设置显示行号
set number

" 设置自动换行
set textwidth=100

" 自动换行
 set nowrap

" 语法高亮开关保持当前的色彩设置
syntax enable

" 用缺省值覆盖自己的色彩设置
syntax on 

" 设置退格键
set backspace=indent,eol,start whichwrap+=<,>,[,] "允许退格键的使用
" 去掉GUI
"去掉所有GUI set go=
" 去掉菜单 b下面的滚动条 h右滚动条
set go=b,h

" 设置语法高亮
set hlsearch

" 实时匹配输入搜索结果
" set incsearch

" 设制颜色
colorscheme evening 

" 映射习惯
" 全选nmap <c-a> ggVG
vmap <c-a> <esc>ggVG

" 设置历史
set history=5000

" 显示行列信息 
set ruler

" 在Vim窗口的右下角显示一个完整的命令已经完成的部分set showcmd

" 根据文件类型启用缩进
filetype indent on
set autoindent
set tabstop=4 " tab键四个空格
" 字体设置
if has("win32")
"	set guifont=Courier\ New:h13
	" set guifontwide=YaHei\ Consolas\ Hybrid:h13 
	set guifont=Consolas:h16
else
	let g:fontman_font = "Monospace"
	let g:fontman_size = 14
endif


" 自动缩进
set sw=4

" 不在单词中间换行
set lbr

" 打开断行对亚洲语言支持
set fo+=mB

" 显士括号配对
set showmatch

set wildmenu

set mousemodel=popup

set autochdir

" 启动的时候不显示那个援助索马里儿童的提示
" set shortmess=atI

" 输入法自动切换中英文
" set noimcmdline

" 支持DOS 和 UNIX 换行符差异set fileformats=unix,dos
" 编辑配置文件自动生效
if has('autocmd')
   "autocmd! bufwritepost _vimrc source $VIM/_vimrc
   autocmd! bufwritepost .vimrc source ~/.vimrc
endif

packadd! matchit

