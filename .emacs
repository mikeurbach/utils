(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eclim-eclipse-dirs (quote ("/Applications/Eclipse.app/Contents/Eclipse/")))
 '(eclim-executable
   "/Applications/Eclipse.app/Contents/Eclipse/plugins/org.eclim_2.7.2/bin/eclim")
 '(eclimd-default-workspace "/Users/mikeurbach/eclipse-workspace")
 '(explicit-bash-args (quote ("--noediting" "-i" "-l")))
 '(grep-command
   "grep -nHr --exclude-dir coverage --exclude-dir log --exclude-dir .git --exclude-dir bin --exclude-dir build --exclude \\*~ -e ")
 '(grep-find-command (quote ("find . -type f -exec grep -nH -e  {} +" . 34)))
 '(grep-find-template "find . <X> -type f <F> -exec grep <C> -nH -e <R> {} +")
 '(grep-highlight-matches nil)
 '(grep-template "grep <X> <C> -nH -e <R> <F>")
 '(grep-use-null-device nil)
 '(indent-tabs-mode nil)
 '(js-indent-level 2)
 '(lua-indent-level 2)
 '(lua-prefix-key "C-c")
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("marmalade" . "https://marmalade-repo.org/packages/")
     ("melpa" . "https://melpa.org/packages/"))))
 '(racket-program "/Applications/Racket v7.1/bin/racket")
 '(tab-width 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-preview ((t (:background "black" :foreground "red"))))
 '(company-preview-common ((t (:foreground "red"))))
 '(company-preview-search ((t (:inherit company-preview))))
 '(company-scrollbar-bg ((t (:background "brightwhite"))))
 '(company-scrollbar-fg ((t (:background "red"))))
 '(company-template-field ((t (:background "magenta" :foreground "black"))))
 '(company-tooltip ((t (:background "brightwhite" :foreground "black"))))
 '(company-tooltip-annotation ((t (:background "brightwhite" :foreground "black"))))
 '(company-tooltip-annotation-selection ((t (:background "color-253"))))
 '(company-tooltip-common ((t (:background "brightwhite" :foreground "red"))))
 '(company-tooltip-common-selection ((t (:background "color-253" :foreground "red"))))
 '(company-tooltip-mouse ((t (:foreground "black"))))
 '(company-tooltip-search ((t (:background "brightwhite" :foreground "black"))))
 '(company-tooltip-selection ((t (:background "color-253" :foreground "black")))))

(setq initial-buffer-choice 'shell)

(add-hook 'before-save-hook #'gofmt-before-save)

;; java shit
(setq package-enable-at-startup nil)
(package-initialize)

(require 'eclim)
(setq eclimd-autostart t)

(add-hook 'java-mode-hook '(lambda() (eclim-mode t)))
(add-hook 'java-mode-hook '(lambda() (setq c-basic-offset 2)))
(add-hook 'java-mode-hook '(lambda() (global-company-mode t)))

;; (defun format-java ()
;;   (interactive)
;;   (eclim-format-java)
;;   (revert-buffer :ignore-auto :noconfirm))

;; (add-hook 'java-mode-hook '(lambda() (add-hook 'before-save-hook 'eclim-java-format)))

(require 'eclimd)

(require 'company)
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)

(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

(require 'gradle-mode)
(add-hook 'java-mode-hook '(lambda() (gradle-mode 1)))

(defun build-and-run ()
  (interactive)
  (gradle-run "--daemon bootRun"))

(defun build-and-debug ()
  (interactive)
  (gradle-run "--daemon -DDEBUG=true bootRun"))

(define-key gradle-mode-map (kbd "C-c C-g r") 'build-and-run)
(define-key gradle-mode-map (kbd "C-c C-g d") 'build-and-debug)
(define-key gradle-mode-map (kbd "C-c C-g t") 'gradle-test)
(define-key gradle-mode-map (kbd "C-c C-e p") 'eclim-problems-correct)

;; hack to fix multi-projects in eclim
;; see: https://stackoverflow.com/questions/39505506/company-emacs-eclim-uses-wrong-path-for-project
(defun eclim-fix-relative-path (path)
  (replace-regexp-in-string "^.*src/" "src/" path))

(advice-add 'eclim--project-current-file :filter-return #'eclim-fix-relative-path)

;; custom packages
;; (add-to-list 'load-path "~/.emacs.d/custom/")

;; org-jira
;; https://github.com/ahungry/org-jira/commit/1412d6bd4d23ff50433ccb86d915410006924184
;; (load "jiralib.el")
;; (load "org-jira.el")
;; (setq jiralib-url "https://banjoinc.atlassian.net")

;; racket-mode customization
(put '$vau 'racket-indent-function 2)
(put '$if 'racket-indent-function 1)
(put '$define! 'racket-indent-function 1)
(put 'wrap 'racket-indent-function 0)
(put 'unwrap 'racket-indent-function 1)
(put '$sequence 'racket-indent-function 0)
(put '$lambda 'racket-indent-function 1)
(put '$let 'racket-indent-function 1)
