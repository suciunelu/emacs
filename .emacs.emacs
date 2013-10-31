(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes nil)
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier New" :foundry "outline" :slant normal :weight normal :height 143 :width normal)))))

;; keyboard settings

(global-set-key (kbd "C-c e") 'hs-show-block)
(global-set-key (kbd "C-c s") 'hs-show-all)
(global-set-key (kbd "C-c c") 'hs-hide-block)
(global-set-key (kbd "C-c c") 'hs-hide-all)
(global-set-key (kbd "C-c a") 'hs-hide-all)
(global-set-key (kbd "C-c !") 'nodejs-repl)
(global-set-key (kbd "C-c r") 'js-send-region)
(global-set-key (kbd "C-c j") 'run-js)
(global-set-key (kbd "C-h") 'rgrep)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-f") 'isearch-forward)
(global-set-key (kbd "C-r") 'isearch-backward)
(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "C-t") 'sgml-tag)


;; setup rgrep command
(setq find-program "\"C:/cygwin/bin/find.exe\"")
(setq grep-program "\"C:/cygwin/bin/grep.exe\"")
(defadvice grep-compute-defaults (around grep-compute-defaults-advice-null-device)
  "Use cygwin's /dev/null as the null-device."
  (let ((null-device "/dev/null"))
	ad-do-it))
(ad-activate 'grep-compute-defaults)

;;(setq tags-table-list ("~/emacs" "\"c:/emacs/emcas-24.3/lisp/src\""))

;; setup nodejs repl
(add-to-list 'load-path "\"C:/emacs/emacs-24.3/lisp\"")
(require 'nodejs-repl)


;;http://blog.deadpansincerity.com/2011/05/setting-up-emacs-as-a-javascript-editing-environment-for-fun-and-profit/
;; setup autocomplete
(add-to-list 'load-path "\"~/site-lisp/auto-complete-1.3.1\"")
(require 'auto-complete-config)
;; load dictionaries
(add-to-list 'ac-dictionary-directories "\"~\site-lisp/auto-complete-1.3.1/dict\"")
; Use dictionaries by default
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)
; Start auto-completion after 2 characters of a word
(setq ac-auto-start 2)
; case sensitivity is important when finding matches
(setq ac-ignore-case nil)

;; setup yasnippet
(add-to-list 'load-path "~/site-lisp/yasnippet")
(require 'yasnippet)
;;(yas-global-mode 1)
(yas--initialize)
(yas/load-directory "~/site-lisp/yasnippet")
;; have the snippets in the auto-complete dropdown
(add-to-list 'ac-sources 'ac-source-yasnippet)

;; syntax check with lintnode
(add-to-list 'load-path "~/site-lisp/lintnode")
(require 'flymake-jslint)
;; Make sure we can find the lintnode executable
(setq lintnode-location "~/site-lisp/lintnode")
;; JSLint can be... opinionated
(setq lintnode-jslint-excludes (list 'nomen 'undef 'plusplus 'onevar 'white))
;; Start the server when we first open a js file and start checking
(add-hook 'js-mode-hook
          (lambda ()
            (lintnode-hook)))
(require 'flymake-cursor)

;; code folding
(add-hook 'js-mode-hook
          (lambda ()
            ;; Scan the file for nested code blocks
            (imenu-add-menubar-index)
            ;; Activate the folding mode
            (hs-minor-mode t)))


;; javascript console
(add-to-list 'load-path "~/lisp")
(require 'js-comint)
;;(require 'js-config)

;; Use node as our repl
(setq inferior-js-program-command "node")

(setq inferior-js-mode-hook
      (lambda ()
        ;; We like nice colors
        (ansi-color-for-comint-mode-on)
        ;; Deal with some prompt nonsense
        (add-to-list 'comint-preoutput-filter-functions
                     (lambda (output)
        	               (replace-regexp-in-string ".*1G\.\.\..*5G" "..."
                	     		(replace-regexp-in-string ".*1G.*3G" "&gt;" output))))))	
