set nocompatible      " We're running Vim, not Vi!

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
        Plug 'Shougo/vimproc.vim', { 'do': 'make' }

        Plug 'rking/ag.vim'

        "Plug 'scrooloose/syntastic'
        Plug 'w0rp/ale'
        "Plug('pydave/AsyncCommand')
        "Plug('stgpetrovic/syntastic-async')
        "Plug 'thinca/vim-quickrun'
        "Plug 'Shougo/vimproc.vim'
        "Plug 'osyo-manga/shabadou.vim'
        "Plug 'jceb/vim-hier'
        "Plug 'osyo-manga/vim-watchdogs'

        Plug 'kien/ctrlp.vim'

        Plug 'airblade/vim-gitgutter'
        Plug 'nathanaelkane/vim-indent-guides'

        Plug 'maxbrunsfeld/vim-yankstack'
        Plug 'sjl/gundo.vim'

        Plug 'tshirtman/vim-cython'
        Plug 'jlanzarotta/bufexplorer'
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'tpope/vim-surround'
        Plug 'lambdalisue/nose.vim'
        Plug 'scrooloose/nerdcommenter'
        Plug 'scrooloose/nerdtree'
        Plug 'ivanov/vim-ipython'

        "Plug 'SirVer/ultisnips'
        Plug 'honza/vim-snippets'

        Plug 'flazz/vim-colorschemes'

        Plug 'hynek/vim-python-pep8-indent'
        Plug 'terryma/vim-multiple-cursors'

        Plug 'unblevable/quick-scope'

        " color schemes
        Plug 'nanotech/jellybeans.vim'

        if ! has("gui_macvim")
                Plug 'KabbAmine/zeavim.vim'
                nmap Z <Plug>Zeavim
        end

        " CPP development
        Plug 'lyuts/vim-rtags'
        Plug 'jez/vim-ispc' " ispc syntax highlighting
        Plug 'rhysd/vim-clang-format'

        Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
        Plug 'tpope/vim-dispatch'

        " Completion
        "Plug 'valloric/youcompleteme', { 'do': '/usr/bin/python install.py --clang-completer' }
        "Plug 'lifepillar/vim-mucomplete'
        "Plug 'Shougo/deoplete.nvim'
        "Plug 'zchee/deoplete-jedi'
        "Plug 'roxma/nvim-yarp'
        "Plug 'roxma/vim-hug-neovim-rpc'

        "Plug 'Townk/vim-autoclose'
        "Plug 'klen/python-mode'
call plug#end()

syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype plugin on    " Enable filetype-specific plugins

" for macvim, the window will be quite small unless we set the number of lines
" and columns - setting them too big will make macvim truncate them to fit the
" full screen
if has("gui_macvim")
    set lines=999 columns=9999
endif

if has("gui_running") && ! has("gui_macvim")
        " Orange curly underline for spell errors
        highlight SpellBad term=underline gui=undercurl guisp=Orange
        set guifont=Inconsolata\ 12
elseif has("gui_macvim")
        set guifont=Inconsolata\ for\ Powerline\ 13
endif


" blink when esc in normal mode
nmap <Esc> :set cul! cuc!<cr>:set cul! cuc!<cr> 

" ui
set wildmode=longest:full
set wildmenu
set hidden
set ignorecase
set incsearch
set mouse=a
set guioptions-=T " remove toolbar
set guioptions-=m " remove menu bar
set guioptions+=c " console for simple prompts
set noequalalways
set showcmd		" display incomplete commands

set foldmethod=indent
set foldlevel=10

set enc=utf-8
set cindent
set smarttab
set expandtab
set hls
set smartcase
set nu!

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" easier window navigation
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" GRB: clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<CR>/<BS>

" toggle spell-check with F11 and F11 key
map <F11> <Esc>:setlocal invspell<CR>

" F10/F11 executes async release/debug build, shift-F10/F11 synchronous builds
nmap <F10> :set makeprg=make\ -C\ build\ -j8<CR>:Make!<CR>
nmap <S-F10> :set makeprg=make\ -C\ build\ -j8<CR>:Make<CR>
nmap <F11> :set makeprg=make\ -C\ build_debug\ -j8<CR>:Make!<CR>
nmap <S-F11> :set makeprg=make\ -C\ build_debug\ -j8<CR>:Make<CR>

map <C-S> :w<CR>

" By default, j and k move you one line down and ups but on a linewise basis, which is annoying. If I hit j I would expect the cursor to move down a single row on the screen, just like every other text editing area in the world. The following does just that:
nmap j gj
nmap k gk

" map H to ^ and L to $. h is left, H is far left
nmap H ^
nmap L $

" quickly navigate matches in quickfix window (e.g. search results, compile errors)
nmap <a-k> :cp<CR>
nmap <a-j> :cn<CR>

"" better maps for switching windows
"map <silent><C-Left> <C-T>
"map <silent><C-Right> <C-]>

" indentation
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType c,h,cpp,cuda setlocal expandtab cindent shiftwidth=4 tabstop=4 softtabstop=4 
autocmd FileType cython setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

if has('gui_running')
  "let g:mayansmoke_cursor_line_visibility = 1
  "set cul
  color mayansmoke
end

autocmd BufEnter * :syntax sync fromstart

" setup locations of backup, undo and swap files
set backup                        " make backup files
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set writebackup

" quickly set a "breakpoint" in python by hitting F9
nnoremap <F9> Oimport ipdb; ipdb.set_trace()<ESC>

" for Latex Suite
"set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

" GLSL support
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl

 " " pymode options - DISABLED BECAUSE WE CURRENTLY DON'T USE PYMODE
 " let g:pymode_rope = 0
 " let g:pymode_rope_completion = 0
 " let g:pymode_rope_complete_on_dot = 0
 " let g:pymode_lint = 1 " syntastic does that
 " let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe', 'pylint']
 " let g:pymode_lint_on_write = 1
 " let g:pymode_lint_unmodified = 1
 " let g:pymode_lint_cwindow = 0
 " let g:pymode_breakpoint = 1
 " let g:pymode_breakpoint_key = '<F9>'
 " let g:pymode_folding = 0 " don't autofold code
 " let g:pymode_doc = 0
 " let g:pymode_doc_key = 'K'

" syntastic options
"let g:syntastic_python_checkers = ['python', 'flake8', 'pylint']
let g:syntastic_python_checkers = ['python', 'pyflakes']
", 'pylint']
let g:syntastic_aggregate_errors = 1

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
"let g:ale_sign_error = '>>'
"let g:ale_sign_warning = '--'
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0

" Ag options
nnoremap K :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>

" indent guides options
autocmd VimEnter * :IndentGuidesEnable
let g:indent_guides_auto_colors = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#eaeae2   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#fbfbf9 ctermbg=4
let g:indent_guides_color_change_percent = 3

" airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'

" yankstack config
let g:yankstack_map_keys = 0
nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-s-p> <Plug>yankstack_substitute_newer_paste

" bufexplorer options
map <C-TAB> :BufExplorer<CR>
"map <S-TAB> <C-^>
let g:bufExplorerShowRelativePath=1

" nosetest
autocmd FileType python compiler nose

"" ctrlp options
let g:ctrlp_map = '<c-f>'
let g:ctrlp_switch_buffer = 0 " don't switch buffer when file already open
"let g:ctrlp_cmd = 'CtrlPBuffer'
" use Ag as a search tool, which makes ctrlp much faster
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" nerdtree options
" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']


" vim-python options
let g:ipy_perform_mappings=0
map  <buffer> <silent> <C-Return>     <Plug>(IPython-RunFile)
map  <buffer> <silent> <M-Return>     <Plug>(IPython-RunLine)
xmap <buffer> <silent> <C-M-Return>   <Plug>(IPython-RunLines)

" utilsnip options
" change main key
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsJumpForwardTrigger='<c-e>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
let g:UltiSnipsEditSplit="vertical"

" Gundo options
nnoremap <C-A-Z> :GundoToggle<CR>


"
" UltiSnips completion function that tries to expand a snippet. If there's no
" snippet for expanding, it checks for completion window and if it's
" shown, selects first element. If there's no completion window it tries to
" jump to next placeholder. If there's no placeholder it just returns TAB key 
"function! g:UltiSnips_Complete()
"    call UltiSnips_ExpandSnippet()
"    if g:ulti_expand_res == 0
"        if pumvisible()
"            return "\<C-n>"
"        else
"            call UltiSnips_JumpForwards()
"            if g:ulti_jump_forwards_res == 0
"               return "\<TAB>"
"            endif
"        endif
"    endif
"    return ""
"endfunction
"
"au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"


" YouCompleteMe options
"if has("gui_macvim")
"	let g:ycm_path_to_python_interpreter = '/usr/bin/python'
"endif
let g:ycm_python_binary_path = '/Users/loo/anaconda3/envs/cg27/bin/python'
"
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_key_invoke_completion = '<C-Tab>'
let g:ycm_server_use_vim_stdout = 1
let g:ycm_server_log_level = 'debug'
nmap gd :YcmCompleter GoToDeclaration<CR>
nmap gt :YcmCompleter GoToDefinition<CR>
nmap gr :YcmCompleter GoToReferences<CR>

set completeopt-=preview
set completeopt+=longest,menuone,noselect
let g:jedi#popup_on_dot = 0  " It may be 1 as well
let g:mucomplete#enable_auto_at_startup = 1

" Use deoplete.
let g:deoplete#enable_at_startup = 1


"====[ Make the 81st column stand out ]====================
"
    " EITHER the entire 81st column, full-screen...
    highlight ColorColumn ctermbg=magenta
    set colorcolumn=81

"=====[ Highlight matches when jumping to next ]=============
    " This rewires n and N to do the highlighing...
    "nnoremap <silent> n   n:call HLNext(0.1)<cr>
    "nnoremap <silent> N   N:call HLNext(0.1)<cr>

    "" EITHER blink the line containing the match...
    "function! HLNext (blinktime)
    "    set invcursorline
    "    redraw
    "    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    "    set invcursorline
    "    redraw
    "endfunction


"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======

    exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
    set list


function! Nightmode()
        if has('gui_running')
                let g:qs_first_occurrence_highlight_color = '#a9cce1'
                let g:qs_second_occurrence_highlight_color = '#c898f1'
        endif
        exec "color badwolf"
        return ""
endfunction

function! Daymode()
        if has('gui_running')
                let g:qs_first_occurrence_highlight_color = '#1c5e83'
                let g:qs_second_occurrence_highlight_color = '#252525'
        endif
        exec "color mayansmoke"
        return ""
endfunction

command! Nightmode call Nightmode()
command! Daymode call Daymode()


" adjustments for C++ development
" from http://xania.org/201108/vim-and-gcc-4-5
function! Make() 
    silent make
    redraw!
    cw 8
    echo getqflist()[-1].text
endfunction

set errorformat=%*[^\"]\"%f\"%*\\D%l:\ %m,\"%f\"%*\\D%l:\ %m,%-G%f:%l:\ (Each\ undeclared\ identifier\ is\ reported\ only\ once,%-G%f:%l:\ for\ each\ function\ it\ appears\ in.),%-GIn\ file\ included\ from\ %f:%l:%c:,%-GIn\ file\ included\ from\ %f:%l:%c,%-GIn\ file\ included\ from\ %f:%l,%-Gfrom\ %f:%l:%c,%-Gfrom\ %f:%l,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,\"%f\"\\,\ line\ %l%*\\D%c%*[^\ ]\ %m,%D%*\\a[%*\\d]:\ Entering\ directory\ `%f',%X%*\\a[%*\\d]:\ Leaving\ directory\ `%f',%D%*\\a:\ Entering\ directory\ `%f',%X%*\\a:\ Leaving\ directory\ `%f',%DMaking\ %*\\a\ in\ %f,%f\|%l\|\ %m

nnoremap <c-F10> :call Make()<CR>

" highlight last inserted text
nnoremap gV `[v`]

if has("gui_macvim")
        let g:ag_prg="/usr/local/bin/ag --vimgrep"
endif


" clang format options
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "false",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <C-A> :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <C-A> :ClangFormat<CR>

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
