set number "显示行号
set nocompatible "不模拟vi模式
set tabstop=4 "tab代表4个空格
" Show the next match while entering a search  实时搜索匹配
set incsearch
set showmatch "类似当输入一个左括号时会匹配相应的那个右括号
" set foldmethod=indent "启动缩进折叠 按照缩进层次自动折叠
set backspace=indent,eol,start
set smartindent
set ruler
set showcmd
set expandtab
set shiftwidth=4
" set foldcolumn=2
set history=10000
set nrformats=
"搜索不高亮
set nohlsearch

set wildmenu
set wildmode=full

set ai

"vim-powerline插件
set laststatus=2
let g:Powerline_symbols='fancy'
set encoding=utf-8
" 配色Vim为256
set t_Co=256
set bg=dark
colorscheme default

" set wildmode=longest,list
syntax enable "语法高亮
" 得需要安装好solarized 将solarized.vim mv到.vim/colors中
" colorscheme solarized
" --- configure Vundle(一个vim的管理插件) ---
filetype on "打开文件类型检测功能
"filetype off "打开这个选项后php文件变量就不高亮了
"


" nerdtree
" 默认是否用 l 代替 o 打开文件"
let g:vj_nerdtree_compatible = 1
" NerdTree没有箭头"
let g:NERDTreeDirArrows=0 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'

call vundle#end() 
" 引入vundle管理的插件文件,类似Gemfile "
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif


" 团队vimrc文件根目录
let VIMIDE_DIR=expand("<sfile>:p:h")
if filereadable(expand(VIMIDE_DIR.'/.vimrc.bundles'))
    "exec 'source '.VIMIDE_DIR.'/.vimrc.bundles'
endif
if filereadable(expand(VIMIDE_DIR."/.vimrc.local"))
   " exec 'source '.VIMIDE_DIR.'/.vimrc.local'
endif
filetype plugin indent on
" --- END configure Vundle ---
" 在 vim 启动的时候默认开启 NERDTree（autocmd 可以缩写为 au）
"autocmd VimEnter * NERDTree
" php和html文件的补全规则 输入的时候按ctrl+x 以及ctrl+o 
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType c setlocal omnifunc=ccomplete#Complete
"autocmd FileType vim set omnifunc=syntaxcomplete#Complete

" 去除 PHP 尖括号「<:>」的默认匹配与自动补全
autocmd FileType php set matchpairs-=<:>
" Visual Mode 快捷键 不知道有啥用
map vi' <Esc>?'<CR>lv/'<CR>h
map vi" <Esc>?"<CR>lv/"<CR>h
map va' <Esc>?'<CR>v/'<CR>
map va" <Esc>?"<CR>v/"<CR>
map vix <Esc>?><CR>lv/<<CR>h
map vi= <ESC>?\s\+\S\+\s*=\s*\S\+<CR>lv/=<CR>/\S<CR>/[\s<>\n]<CR>h
map vi/ <Esc>?\/<CR>l<Esc>v/\/<CR>h
map vt) <ESC>v/)<CR>h
map vt' <ESC>v/'<CR>h
map vt" <ESC>v/"<CR>h
map vt; <ESC>v/;<CR>h
map vt, <ESC>v/,<CR>h
map vt} <ESC>v/}<CR>h

map <F11> :NERDTreeMirror<CR>
map <F10> :NERDTreeToggle<CR>
" 关闭方向键, 强迫自己用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>
" 分屏窗口移动, Smart way to move between windows"
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <C-n> :MBEbf<CR>
map <C-b> :MBEbb<CR>
map <C-g> :pwd<CR>
" F8启动golang
noremap <F8> <Esc> :call GolangBuild() <CR> 
let s:prjroot=fnamemodify('',':p')
function GolangBuild()
    if filereadable(s:prjroot.'install')
        exec ':!sh '.s:prjroot.'install'
        execute "! echo -e --- Finished ---\n"
    endif
endfunction
" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")| exe "normal! g'\"" | endif
endif
" 用 editorconfig 统一托管缩进格式，所以不需要对 Vim 单独配置
" " autocmd FileType html,css,javascript setlocal shiftwidth=2 | set
"
"autocmd BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/*,*_ngx.conf set filetype=nginx | syntax on

"let editorconfig=expand('~/.vim/team_bundle/.editorconfig')
"if filereadable(editorconfig)
"    let g:editorconfig_Beautifier=editorconfig
"endif
"自动补全花括号并换行
inoremap { {<CR>}<ESC>O
inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
" ctags
let g:prj = getcwd()
func! UpdatePrjTags()
    " 将 _prj/ 下 tags 结尾的文件"
    let a:tag_list=split(globpath(g:prj."/_prj/", '*tags'), "\n")
    set tags=
    let i=0
    while i<len(a:tag_list)
        if filereadable(a:tag_list[i])
""            echom a:tag_list[i]
""            execute "set tags+=".a:tag_list[i].";"
        endif
        let i+=1
    endwhile
endf
if filereadable('./_prj/tags')
    :call UpdatePrjTags()
endif
let prjpath = g:prj . "/_prj/tags"
map <F9> :!ctags --tag-relative=yes -f /xxx/www/wdurl_dev/wdurl/_prj/tags -R<CR> set tags=/xxx/www/wdurl_dev/wdurl/_prj/tags;
"map <F9> :!ctags -R <CR>
"set tags=tags; " ; 不可省略，表示若当前目录中不存在tags， 则在父目录中寻找。"
set autochdir

let g:miniBufExplMapWindowNavVim = 1   
let g:miniBufExplMapWindowNavArrows = 1   
let g:miniBufExplMapCTabSwitchBufs = 1   
let g:miniBufExplModSelTarget = 1  
let g:miniBufExplMoreThanOne=0
