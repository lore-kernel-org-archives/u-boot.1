Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936F1C4706F
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:07:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C05D787874;
	Fri, 22 Dec 2023 22:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pdL+ttz6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0364C87860; Fri, 22 Dec 2023 22:03:48 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D597487809
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40d2376db79so17313705e9.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703279023; x=1703883823;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWYf00QURgxYwGwxg4I3UZcUlYhYr+Ilzp87Seq0iMo=;
 b=pdL+ttz6odbABxzQqwFZEDtTeSqBO23MiX9k5qPRv/g1eL+vbmSYy+0s0zFqakdqSH
 rAiSMk+ZtioMYZDIQKBkh9w7IACwFocUluyEP6nPrpTecNx0jDoXnHetVyzOYf+++nsX
 TKW4J7qNgoZWA0SwjaoH1SZK29Ka68QqvdBrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703279023; x=1703883823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IWYf00QURgxYwGwxg4I3UZcUlYhYr+Ilzp87Seq0iMo=;
 b=MLm9qPivKveEbsFJvEakZB3YYJJ2F5DstTTGsLkTua4p0gR55NRl93bng69Y3cZZqu
 aPC08VJmSRUrbsv8HZL6khQ+eAIvawmqSiXL2ULXAf5IitgR8XyD2ZXc/cU8jEHBUP9x
 EIMRs8wM3dEfUc+KYWxZRE1jO0OEfGdN2+lfz28Oo9+oBRBjX4Lek27vfgWPhTIEJb2O
 S7zYGDeSYQn2R4AwEdCsKOsAFXXWLfTvF3WSBWja5sGSb1UzeiuaL60jb+jkM9dQT3Ac
 2d/diFysqUllBCZN4aox43+7U4fNmx2nwtM8GAVOsp7nlHs0vqHGQ3k5ToQCUetFvEC1
 wNCw==
X-Gm-Message-State: AOJu0YzQSAPHKagv4ZqfYizJMH4zWN41bqKPV1jc1xiNijtobLvMOMzg
 vsi8Dl9IxLKsvCpbpA7rv65nW1lwQS8ZOlzOdDO53O5Up6o=
X-Google-Smtp-Source: AGHT+IHowBdCAoTyQQ/M0HKJKtpLnmKrtgZoqPBq3ezLYRB6sTPyqB8y4NSW0Dze5ByKFbUvrq7MEA==
X-Received: by 2002:a05:600c:1f90:b0:40d:206c:1e77 with SMTP id
 je16-20020a05600c1f9000b0040d206c1e77mr1035870wmb.104.1703279023124; 
 Fri, 22 Dec 2023 13:03:43 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:42 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v13 22/24] cli: modern_hush: Add upstream commits up to 2nd
 October 2023.
Date: Fri, 22 Dec 2023 22:02:42 +0100
Message-Id: <20231222210244.91830-23-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This commit adds the following hush busybox upstream commits:
791b222dd55d ("sleep: fix "sleep -- ARGS"")
5353df91cba7 ("Update applet size estimates")
e41e481fd571 ("hush: fix a compile failure")
07a95cfcabb0 ("ash: disable check for "good" function name, bash does not check this")
e5692e2342c6 ("hush: quote values in "readonly" output")
96769486e20f ("shell: move varcmp() to shell_common.h and use it in hush")
bab8828b0dad ("hush: fix expansion of space in "a=${a:+$a }c" construct")
b5be8da350b5 ("hush: make "false" built-in")
6824298ab4d3 ("hush: fix ELIF cmd1;cmd2 THEN ... not executing cmd2, closes 15571")
3a7f00eadcf4 ("hush: add comment about abort on syntax error %{^}")
acae889dd972 ("ash,hush: tab completion of functions and aliases")
90b607d79a13 ("hush: quote variable values printed by "set" (match ash behavior)")
6748e6494c22 ("hush (NOMMU): fix LINENO in execed children")
fd5fb2d2b596 ("hush: speed up "big heredoc" code")
1409432d072e ("hush: add TODO comment")
93ae7464e6e4 ("hush: restore SIGHUP handling, this time explain why we do what we do")
1fdb33bd07e5 ("hush: restore tty pgrp on SIGHUP")
6101b6d3eaa0 ("hush: remove special handling of SIGHUP")
93e0898c663a ("shell: fix SIGWINCH and SIGCHLD (in hush) interrupting line input, closes 15256")
969e00816835 ("hush: code shrink")
27be0e8cfeb6 ("shell: fix compile failures in some configs")
7d1c7d833785 ("ash,hush: use HOME for tab completion and prompts")
21afddefd258 ("hush: fix "error: invalid preprocessing directive ##"")
e53c7dbafc78 ("hush: fix set -n to act immediately, not just after run_list()")
574b9c446da1 ("hush: fix var_LINENO3.tests failure")
49bcf9f40cff ("hush: speed up ${x//\*/|} too")
53b2fdcdba4c ("*: add NOINLINEs where code noticeably shrinks")
7c3e96d4b3d4 ("shell: use more compact SHELL_ASH / HUSH config defines. no code changes")
62f1eed1e191 ("hush: in a comment, document what -i might be doing")
aaf3d5ba74c5 ("shell: tweak --help")
db5546ca1018 ("libbb: code shrink: introduce and use [_]exit_SUCCESS()")
931c55f9e2b4 ("libbb: invert the meaning of SETUP_ENV_NO_CHDIR -> SETUP_ENV_CHDIR")
12566e7f9b5e ("ash,hush: fix handling of SIGINT while waiting for interactive input")
987be932ed3c ("*: slap on a few ALIGN_PTR where appropriate")

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 common/cli_hush_modern.c   |  20 +-
 common/cli_hush_upstream.c | 407 ++++++++++++++++++++++++++-----------
 2 files changed, 304 insertions(+), 123 deletions(-)

diff --git a/common/cli_hush_modern.c b/common/cli_hush_modern.c
index fb578c3853..9a1bc977d5 100644
--- a/common/cli_hush_modern.c
+++ b/common/cli_hush_modern.c
@@ -26,7 +26,7 @@
 /*
  * BusyBox Version: UPDATE THIS WHEN PULLING NEW UPSTREAM REVISION!
  */
-#define BB_VER			"1.34.0.git37460f5daff9"
+#define BB_VER			"1.35.0.git7d1c7d833785"
 
 /*
  * Define hush features by the names used upstream.
@@ -236,6 +236,24 @@ static size_t list_size(char **list)
 	return size;
 }
 
+static int varcmp(const char *p, const char *q)
+{
+	int c, d;
+
+	while ((c = *p) == (d = *q)) {
+		if (c == '\0' || c == '=')
+			goto out;
+		p++;
+		q++;
+	}
+	if (c == '=')
+		c = '\0';
+	if (d == '=')
+		d = '\0';
+out:
+	return c - d;
+}
+
 struct in_str;
 static int u_boot_cli_readline(struct in_str *i);
 
diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index 748edc9d2f..ca40bbb2cd 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -91,7 +91,7 @@
  * in word = GLOB, quoting should be significant on char-by-char basis: a*cd"*"
  */
 //config:config HUSH
-//config:	bool "hush (68 kb)"
+//config:	bool "hush (70 kb)"
 //config:	default y
 //config:	select SHELL_HUSH
 //config:	help
@@ -339,7 +339,7 @@
  * therefore we don't show them either.
  */
 //usage:#define hush_trivial_usage
-//usage:	"[-enxl] [-c 'SCRIPT' [ARG0 ARGS] | FILE [ARGS] | -s [ARGS]]"
+//usage:	"[-enxl] [-c 'SCRIPT' [ARG0 ARGS] | FILE ARGS | -s ARGS]"
 //usage:#define hush_full_usage "\n\n"
 //usage:	"Unix shell interpreter"
 
@@ -374,7 +374,7 @@
 # define F_DUPFD_CLOEXEC F_DUPFD
 #endif
 
-#if ENABLE_FEATURE_SH_EMBEDDED_SCRIPTS && !(ENABLE_ASH || ENABLE_SH_IS_ASH || ENABLE_BASH_IS_ASH)
+#if ENABLE_FEATURE_SH_EMBEDDED_SCRIPTS && !ENABLE_SHELL_ASH
 # include "embedded_scripts.h"
 #else
 # define NUM_SCRIPTS 0
@@ -573,7 +573,7 @@ enum {
 #define NULL_O_STRING { NULL }
 
 #ifndef debug_printf_parse
-static const char *const assignment_flag[] = {
+static const char *const assignment_flag[] ALIGN_PTR = {
 	"MAYBE_ASSIGNMENT",
 	"DEFINITELY_ASSIGNMENT",
 	"NOT_ASSIGNMENT",
@@ -957,6 +957,7 @@ struct globals {
 #if ENABLE_HUSH_INTERACTIVE
 	smallint promptmode; /* 0: PS1, 1: PS2 */
 #endif
+	/* set by signal handler if SIGINT is received _and_ its trap is not set */
 	smallint flag_SIGINT;
 #ifndef __U_BOOT__
 #if ENABLE_HUSH_LOOPS
@@ -1133,6 +1134,7 @@ static int builtin_export(char **argv) FAST_FUNC;
 #if ENABLE_HUSH_READONLY
 static int builtin_readonly(char **argv) FAST_FUNC;
 #endif
+static int builtin_false(char **argv) FAST_FUNC;
 #if ENABLE_HUSH_JOB
 static int builtin_fg_bg(char **argv) FAST_FUNC;
 static int builtin_jobs(char **argv) FAST_FUNC;
@@ -1233,6 +1235,7 @@ static const struct built_in_command bltins1[] ALIGN_PTR = {
 #if ENABLE_HUSH_EXPORT
 	BLTIN("export"   , builtin_export  , "Set environment variables"),
 #endif
+	BLTIN("false"    , builtin_false   , NULL),
 #if ENABLE_HUSH_JOB
 	BLTIN("fg"       , builtin_fg_bg   , "Bring job to foreground"),
 #endif
@@ -1506,6 +1509,7 @@ static void syntax_error_unterm_str(unsigned lineno UNUSED_PARAM, const char *s)
 {
 	bb_error_msg("syntax error: unterminated %s", s);
 //? source4.tests fails: in bash, echo ${^} in script does not terminate the script
+// (but bash --posix, or if bash is run as "sh", does terminate in script, so maybe uncomment this?)
 //	die_if_script();
 }
 
@@ -1917,7 +1921,13 @@ static void restore_G_args(save_arg_t *sv, char **argv)
  * SIGQUIT: ignore
  * SIGTERM (interactive): ignore
  * SIGHUP (interactive):
- *    send SIGCONT to stopped jobs, send SIGHUP to all jobs and exit
+ *    Send SIGCONT to stopped jobs, send SIGHUP to all jobs and exit.
+ *    Kernel would do this for us ("orphaned process group" handling
+ *    according to POSIX) if we are a session leader and thus our death
+ *    frees the controlling tty, but to be bash-compatible, we also do it
+ *    for every interactive shell's death by SIGHUP.
+ *    (Also, we need to restore tty pgrp, otherwise e.g. Midnight Commander
+ *    backgrounds when hush started from it gets killed by SIGHUP).
  * SIGTTIN, SIGTTOU, SIGTSTP (if job control is on): ignore
  *    Note that ^Z is handled not by trapping SIGTSTP, but by seeing
  *    that all pipe members are stopped. Try this in bash:
@@ -2033,6 +2043,14 @@ enum {
 static void record_pending_signo(int sig)
 {
 	sigaddset(&G.pending_set, sig);
+#if ENABLE_FEATURE_EDITING
+	if (sig != SIGCHLD
+	 || (G_traps && G_traps[SIGCHLD] && G_traps[SIGCHLD][0])
+	 /* ^^^ if SIGCHLD, interrupt line reading only if it has a trap */
+	) {
+		bb_got_signal = sig; /* for read_line_input: "we got a signal" */
+	}
+#endif
 #if ENABLE_HUSH_FAST
 	if (sig == SIGCHLD) {
 		G.count_SIGCHLD++;
@@ -2264,20 +2282,27 @@ static int check_and_run_traps(void)
 			break;
 #if ENABLE_HUSH_JOB
 		case SIGHUP: {
-//TODO: why are we doing this? ash and dash don't do this,
-//they have no handler for SIGHUP at all,
-//they rely on kernel to send SIGHUP+SIGCONT to orphaned process groups
-			struct pipe *job;
-			debug_printf_exec("%s: sig:%d default SIGHUP handler\n", __func__, sig);
-			/* bash is observed to signal whole process groups,
-			 * not individual processes */
-			for (job = G.job_list; job; job = job->next) {
-				if (job->pgrp <= 0)
-					continue;
-				debug_printf_exec("HUPing pgrp %d\n", job->pgrp);
-				if (kill(- job->pgrp, SIGHUP) == 0)
-					kill(- job->pgrp, SIGCONT);
+			/* if (G_interactive_fd) - no need to check, the handler
+			 * is only installed if we *are* interactive */
+			{
+				/* bash compat: "Before exiting, an interactive
+				 * shell resends the SIGHUP to all jobs, running
+				 * or stopped.  Stopped jobs are sent SIGCONT
+				 * to ensure that they receive the SIGHUP."
+				 */
+				struct pipe *job;
+				debug_printf_exec("%s: sig:%d default SIGHUP handler\n", __func__, sig);
+				/* bash is observed to signal whole process groups,
+				 * not individual processes */
+				for (job = G.job_list; job; job = job->next) {
+					if (job->pgrp <= 0)
+						continue;
+					debug_printf_exec("HUPing pgrp %d\n", job->pgrp);
+					if (kill(- job->pgrp, SIGHUP) == 0)
+						kill(- job->pgrp, SIGCONT);
+				}
 			}
+			/* this restores tty pgrp, then kills us with SIGHUP */
 			sigexit(SIGHUP);
 		}
 #endif
@@ -2326,14 +2351,14 @@ static const char *get_cwd(int force)
 /*
  * Shell and environment variable support
  */
-static struct variable **get_ptr_to_local_var(const char *name, unsigned len)
+static struct variable **get_ptr_to_local_var(const char *name)
 {
 	struct variable **pp;
 	struct variable *cur;
 
 	pp = &G.top_var;
 	while ((cur = *pp) != NULL) {
-		if (strncmp(cur->varstr, name, len) == 0 && cur->varstr[len] == '=')
+		if (varcmp(cur->varstr, name) == 0)
 			return pp;
 		pp = &cur->next;
 	}
@@ -2343,21 +2368,20 @@ static struct variable **get_ptr_to_local_var(const char *name, unsigned len)
 static const char* FAST_FUNC get_local_var_value(const char *name)
 {
 	struct variable **vpp;
-	unsigned len = strlen(name);
 
 	if (G.expanded_assignments) {
 		char **cpp = G.expanded_assignments;
 		while (*cpp) {
 			char *cp = *cpp;
-			if (strncmp(cp, name, len) == 0 && cp[len] == '=')
-				return cp + len + 1;
+			if (varcmp(cp, name) == 0)
+				return strchr(cp, '=') + 1;
 			cpp++;
 		}
 	}
 
-	vpp = get_ptr_to_local_var(name, len);
+	vpp = get_ptr_to_local_var(name);
 	if (vpp)
-		return (*vpp)->varstr + len + 1;
+		return strchr((*vpp)->varstr, '=') + 1;
 
 #ifndef __U_BOOT__
 	if (strcmp(name, "PPID") == 0)
@@ -2393,13 +2417,11 @@ static const char* FAST_FUNC get_local_var_value(const char *name)
 
 #ifndef __U_BOOT__
 #if ENABLE_HUSH_GETOPTS
-static void handle_changed_special_names(const char *name, unsigned name_len)
+static void handle_changed_special_names(const char *name)
 {
-	if (name_len == 6) {
-		if (strncmp(name, "OPTIND", 6) == 0) {
-			G.getopt_count = 0;
-			return;
-		}
+	if (varcmp(name, "OPTIND") == 0) {
+		G.getopt_count = 0;
+		return;
 	}
 }
 #else
@@ -2574,16 +2596,21 @@ int set_local_var_modern(char *str, int flags)
 #endif /* !__U_BOOT__ */
 	free(free_me);
 
-	handle_changed_special_names(cur->varstr, name_len - 1);
+	handle_changed_special_names(cur->varstr);
 
 	return retval;
 }
 
 #ifndef __U_BOOT__
+static int set_local_var0(char *str)
+{
+	return set_local_var(str, 0);
+}
+
 static void FAST_FUNC set_local_var_from_halves(const char *name, const char *val)
 {
 	char *var = xasprintf("%s=%s", name, val);
-	set_local_var(var, /*flag:*/ 0);
+	set_local_var0(var);
 }
 
 /* Used at startup and after each cd */
@@ -2594,16 +2621,14 @@ static void set_pwd_var(unsigned flag)
 #endif /* !__U_BOOT__ */
 
 #if ENABLE_HUSH_UNSET || ENABLE_HUSH_GETOPTS
-static int unset_local_var_len(const char *name, int name_len)
+static int unset_local_var(const char *name)
 {
 	struct variable *cur;
 	struct variable **cur_pp;
 
 	cur_pp = &G.top_var;
 	while ((cur = *cur_pp) != NULL) {
-		if (strncmp(cur->varstr, name, name_len) == 0
-		 && cur->varstr[name_len] == '='
-		) {
+		if (varcmp(cur->varstr, name) == 0) {
 			if (cur->flg_read_only) {
 				bb_error_msg("%s: readonly variable", name);
 				return EXIT_FAILURE;
@@ -2622,15 +2647,10 @@ static int unset_local_var_len(const char *name, int name_len)
 	}
 
 	/* Handle "unset LINENO" et al even if did not find the variable to unset */
-	handle_changed_special_names(name, name_len);
+	handle_changed_special_names(name);
 
 	return EXIT_SUCCESS;
 }
-
-static int unset_local_var(const char *name)
-{
-	return unset_local_var_len(name, strlen(name));
-}
 #endif
 
 
@@ -2677,7 +2697,7 @@ static void set_vars_and_save_old(char **strings)
 		eq = strchr(*s, '=');
 		if (HUSH_DEBUG && !eq)
 			bb_simple_error_msg_and_die("BUG in varexp4");
-		var_pp = get_ptr_to_local_var(*s, eq - *s);
+		var_pp = get_ptr_to_local_var(*s);
 		if (var_pp) {
 			var_p = *var_pp;
 			if (var_p->flg_read_only) {
@@ -2787,30 +2807,54 @@ static void get_user_input(struct in_str *i)
 	for (;;) {
 		reinit_unicode_for_hush();
 		G.flag_SIGINT = 0;
-		/* buglet: SIGINT will not make new prompt to appear _at once_,
-		 * only after <Enter>. (^C works immediately) */
-		r = read_line_input(G.line_input_state, prompt_str,
+
+		bb_got_signal = 0;
+		if (!sigisemptyset(&G.pending_set)) {
+			/* Whoops, already got a signal, do not call read_line_input */
+			bb_got_signal = r = -1;
+		} else {
+			/* For shell, LI_INTERRUPTIBLE is set:
+			 * read_line_input will abort on either
+			 * getting EINTR in poll() and bb_got_signal became != 0,
+			 * or if it sees bb_got_signal != 0
+			 * (IOW: if signal arrives before poll() is reached).
+			 * Interactive testcases:
+			 * (while kill -INT $$; do sleep 1; done) &
+			 * #^^^ prints ^C, prints prompt, repeats
+			 * trap 'echo I' int; (while kill -INT $$; do sleep 1; done) &
+			 * #^^^ prints ^C, prints "I", prints prompt, repeats
+			 * trap 'echo T' term; (while kill $$; do sleep 1; done) &
+			 * #^^^ prints "T", prints prompt, repeats
+			 * #(bash 5.0.17 exits after first "T", looks like a bug)
+			 */
+			r = read_line_input(G.line_input_state, prompt_str,
 				G.user_input_buf, CONFIG_FEATURE_EDITING_MAX_LEN-1
-		);
-		/* read_line_input intercepts ^C, "convert" it to SIGINT */
-		if (r == 0) {
-			raise(SIGINT);
+			);
+			/* read_line_input intercepts ^C, "convert" it to SIGINT */
+			if (r == 0)
+				raise(SIGINT);
+		}
+		/* bash prints ^C (before running a trap, if any)
+		 * both on keyboard ^C and on real SIGINT (non-kbd generated).
+		 */
+		if (sigismember(&G.pending_set, SIGINT)) {
+			write(STDOUT_FILENO, "^C\n", 3);
+			G.last_exitcode = 128 | SIGINT;
 		}
 		check_and_run_traps();
-		if (r != 0 && !G.flag_SIGINT)
+		if (r == 0) /* keyboard ^C? */
+			continue; /* go back, read another input line */
+		if (r > 0) /* normal input? (no ^C, no ^D, no signals) */
 			break;
-		/* ^C or SIGINT: repeat */
-		/* bash prints ^C even on real SIGINT (non-kbd generated) */
-		write(STDOUT_FILENO, "^C\n", 3);
-		G.last_exitcode = 128 | SIGINT;
-	}
-	if (r < 0) {
-		/* EOF/error detected */
-		/* ^D on interactive input goes to next line before exiting: */
-		write(STDOUT_FILENO, "\n", 1);
-		i->p = NULL;
-		i->peek_buf[0] = r = EOF;
-		return r;
+		if (!bb_got_signal) {
+			/* r < 0: ^D/EOF/error detected (but not signal) */
+			/* ^D on interactive input goes to next line before exiting: */
+			write(STDOUT_FILENO, "\n", 1);
+			i->p = NULL;
+			i->peek_buf[0] = r = EOF;
+			return r;
+		}
+		/* it was a signal: go back, read another input line */
 	}
 	i->p = G.user_input_buf;
 	return (unsigned char)*i->p++;
@@ -2990,6 +3034,12 @@ static int i_getch(struct in_str *i)
 		if (ch != '\0') {
 			i->p++;
 			i->last_char = ch;
+#if ENABLE_HUSH_LINENO_VAR
+			if (ch == '\n') {
+				G.parse_lineno++;
+				debug_printf_parse("G.parse_lineno++ = %u\n", G.parse_lineno);
+			}
+#endif
 			return ch;
 		}
 		return EOF;
@@ -3637,7 +3687,7 @@ static int glob_brace(char *pattern, o_string *o, int n)
 	 * NEXT points past the terminator of the first element, and REST
 	 * points past the final }.  We will accumulate result names from
 	 * recursive runs for each brace alternative in the buffer using
-	 * GLOB_APPEND.  */
+	 * GLOB_APPEND. */
 
 	p = begin + 1;
 	while (1) {
@@ -3953,7 +4003,7 @@ static void free_pipe_list(struct pipe *pi)
 #ifndef debug_print_tree
 static void debug_print_tree(struct pipe *pi, int lvl)
 {
-	static const char *const PIPE[] = {
+	static const char *const PIPE[] ALIGN_PTR = {
 		[PIPE_SEQ] = "SEQ",
 		[PIPE_AND] = "AND",
 		[PIPE_OR ] = "OR" ,
@@ -3988,7 +4038,7 @@ static void debug_print_tree(struct pipe *pi, int lvl)
 		[RES_XXXX ] = "XXXX" ,
 		[RES_SNTX ] = "SNTX" ,
 	};
-	static const char *const CMDTYPE[] = {
+	static const char *const CMDTYPE[] ALIGN_PTR = {
 		"{}",
 		"()",
 		"[noglob]",
@@ -4575,7 +4625,7 @@ static int done_word(struct parse_context *ctx)
 		 || endofname(command->argv[0])[0] != '\0'
 		) {
 			/* bash says just "not a valid identifier" */
-			syntax_error("bad variable name in for");
+			syntax_error("bad for loop variable");
 			return 1;
 		}
 		/* Force FOR to have just one word (variable name) */
@@ -4966,6 +5016,11 @@ static int parse_group(struct parse_context *ctx,
 			syntax_error_unexpected_ch(ch);
 			return -1;
 		}
+//bash allows functions named "123", "..", "return"!
+//		if (endofname(command->argv[0])[0] != '\0') {
+//			syntax_error("bad function name");
+//			return -1;
+//		}
 		nommu_addchr(&ctx->as_string, ch);
 		command->cmd_type = CMD_FUNCDEF;
 		goto skip;
@@ -5353,7 +5408,7 @@ static int parse_dollar_squote(o_string *as_string, o_string *dest, struct in_st
 # undef as_string
 }
 #else
-# #define parse_dollar_squote(as_string, dest, input) 0
+# define parse_dollar_squote(as_string, dest, input) 0
 #endif /* BASH_DOLLAR_SQUOTE */
 #endif /* !__U_BOOT__ */
 
@@ -6720,7 +6775,7 @@ static char *encode_then_expand_vararg(const char *str, int handle_squotes, int
 
 /* Expanding ARG in ${var+ARG}, ${var-ARG}
  */
-static int encode_then_append_var_plusminus(o_string *output, int n,
+static NOINLINE int encode_then_append_var_plusminus(o_string *output, int n,
 		char *str, int dquoted)
 {
 	struct in_str input;
@@ -6753,7 +6808,7 @@ static int encode_then_append_var_plusminus(o_string *output, int n,
 		if (!dest.o_expflags) {
 			if (ch == EOF)
 				break;
-			if (!dquoted && strchr(G.ifs, ch)) {
+			if (!dquoted && !(output->o_expflags & EXP_FLAG_SINGLEWORD) && strchr(G.ifs, ch)) {
 				/* PREFIX${x:d${e}f ...} and we met space: expand "d${e}f" and start new word.
 				 * do not assume we are at the start of the word (PREFIX above).
 				 */
@@ -6885,16 +6940,21 @@ static arith_t expand_and_evaluate_arith(const char *arg, const char **errmsg_p)
 /* ${var/[/]pattern[/repl]} helpers */
 static char *strstr_pattern(char *val, const char *pattern, int *size)
 {
-	int sz = strcspn(pattern, "*?[\\");
-	if (pattern[sz] == '\0') {
+	int first_escaped = (pattern[0] == '\\' && pattern[1]);
+	/* "first_escaped" trick allows to treat e.g. "\*no_glob_chars"
+	 * as literal too (as it is semi-common, and easy to accomodate
+	 * by just using str + 1).
+	 */
+	int sz = strcspn(pattern + first_escaped * 2, "*?[\\");
+	if ((pattern + first_escaped * 2)[sz] == '\0') {
 		/* Optimization for trivial patterns.
 		 * Testcase for very slow replace (performs about 22k replaces):
 		 * x=::::::::::::::::::::::
 		 * x=$x$x;x=$x$x;x=$x$x;x=$x$x;x=$x$x;x=$x$x;x=$x$x;x=$x$x;x=$x$x;x=$x$x;echo ${#x}
 		 * echo "${x//:/|}"
 		 */
-		*size = sz;
-		return strstr(val, pattern);
+		*size = sz + first_escaped;
+		return strstr(val, pattern + first_escaped);
 	}
 
 	while (1) {
@@ -7370,7 +7430,7 @@ static NOINLINE int expand_one_var(o_string *output, int n,
 							val = NULL;
 						} else {
 							char *new_var = xasprintf("%s=%s", var, val);
-							set_local_var(new_var, /*flag:*/ 0);
+							set_local_var0(new_var);
 						}
 					}
 				}
@@ -7858,6 +7918,9 @@ static void re_execute_shell(char ***to_free, const char *s,
 		if (!cur->flg_export || cur->flg_read_only)
 			cnt += 2;
 	}
+# if ENABLE_HUSH_LINENO_VAR
+	cnt += 2;
+# endif
 # if ENABLE_HUSH_FUNCTIONS
 	for (funcp = G.top_func; funcp; funcp = funcp->next)
 		cnt += 3;
@@ -7879,6 +7942,10 @@ static void re_execute_shell(char ***to_free, const char *s,
 			*pp++ = cur->varstr;
 		}
 	}
+# if ENABLE_HUSH_LINENO_VAR
+	*pp++ = (char *) "-L";
+	*pp++ = utoa(G.execute_lineno);
+# endif
 # if ENABLE_HUSH_FUNCTIONS
 	for (funcp = G.top_func; funcp; funcp = funcp->next) {
 		*pp++ = (char *) "-F";
@@ -8025,7 +8092,11 @@ static int parse_and_run_string(const char *s)
 #endif /* __U_BOOT__ */
 {
 	struct in_str input;
+#ifndef __U_BOOT__
+	IF_HUSH_LINENO_VAR(unsigned sv = G.parse_lineno;)
+#else /* __U_BOOT__ */
 	//IF_HUSH_LINENO_VAR(unsigned sv = G.parse_lineno;)
+#endif /* __U_BOOT__ */
 
 	setup_string_in_str(&input, s);
 #ifndef __U_BOOT__
@@ -8033,7 +8104,11 @@ static int parse_and_run_string(const char *s)
 #else /* __U_BOOT__ */
 	return parse_and_run_stream(&input, '\0');
 #endif /* __U_BOOT__ */
-	//IF_HUSH_LINENO_VAR(G.parse_lineno = sv;)
+#ifndef __U_BOOT__
+	IF_HUSH_LINENO_VAR(unsigned sv = G.parse_lineno;)
+#else /* __U_BOOT__ */
+	//IF_HUSH_LINENO_VAR(unsigned sv = G.parse_lineno;)
+#endif /* __U_BOOT__ */
 }
 
 #ifdef __U_BOOT__
@@ -8141,7 +8216,7 @@ static int generate_stream_from_string(const char *s, pid_t *pid_p)
 		if (is_prefixed_with(s, "trap")
 		 && skip_whitespace(s + 4)[0] == '\0'
 		) {
-			static const char *const argv[] = { NULL, NULL };
+			static const char *const argv[] ALIGN_PTR = { NULL, NULL };
 			builtin_trap((char**)argv);
 			fflush_all(); /* important */
 			_exit(0);
@@ -8670,8 +8745,8 @@ static const struct built_in_command *find_builtin(const char *name)
 	return find_builtin_helper(name, bltins2, &bltins2[ARRAY_SIZE(bltins2)]);
 }
 
-#if ENABLE_HUSH_JOB && EDITING_HAS_get_exe_name
-static const char * FAST_FUNC get_builtin_name(int i)
+#if ENABLE_HUSH_JOB && ENABLE_FEATURE_TAB_COMPLETION
+static const char * FAST_FUNC hush_command_name(int i)
 {
 	if (/*i >= 0 && */ i < ARRAY_SIZE(bltins1)) {
 		return bltins1[i].b_cmd;
@@ -8680,6 +8755,16 @@ static const char * FAST_FUNC get_builtin_name(int i)
 	if (i < ARRAY_SIZE(bltins2)) {
 		return bltins2[i].b_cmd;
 	}
+# if ENABLE_HUSH_FUNCTIONS
+	{
+		struct function *funcp;
+		i -= ARRAY_SIZE(bltins2);
+		for (funcp = G.top_func; funcp; funcp = funcp->next) {
+			if (--i < 0)
+				return funcp->name;
+		}
+	}
+# endif
 	return NULL;
 }
 #endif
@@ -9106,7 +9191,7 @@ static NOINLINE void pseudo_exec_argv(nommu_save_t *nommu_save,
 		 * expand_assignments(): think about ... | var=`sleep 1` | ...
 		 */
 		free_strings(new_env);
-		_exit(EXIT_SUCCESS);
+		_exit_SUCCESS();
 	}
 
 	sv_shadowed = G.shadowed_vars_pp;
@@ -9287,7 +9372,7 @@ static void pseudo_exec(nommu_save_t *nommu_save,
 
 	/* Case when we are here: ... | >file */
 	debug_printf_exec("pseudo_exec'ed null command\n");
-	_exit(EXIT_SUCCESS);
+	_exit_SUCCESS();
 }
 
 #if ENABLE_HUSH_JOB
@@ -9894,7 +9979,7 @@ static NOINLINE int run_pipe(struct pipe *pi)
 #endif
 				debug_printf_env("set shell var:'%s'->'%s'\n", *argv, p);
 #ifndef __U_BOOT__
-				if (set_local_var(p, /*flag:*/ 0)) {
+				if (set_local_var0(p)) {
 #else /* __U_BOOT__ */
 				if (set_local_var_modern(p, /*flag:*/ 0)) {
 #endif
@@ -10295,7 +10380,7 @@ static int run_list(struct pipe *pi)
 #endif
 
 #ifndef __U_BOOT__
-	debug_printf_exec("run_list start lvl %d\n", G.run_list_level);
+	debug_printf_exec("run_list lvl %d start\n", G.run_list_level);
 	debug_enter();
 #endif /* !__U_BOOT__ */
 
@@ -10361,7 +10446,7 @@ static int run_list(struct pipe *pi)
 #endif /* !__U_BOOT__ */
 
 		IF_HAS_KEYWORDS(rword = pi->res_word;)
-		debug_printf_exec(": rword=%d cond_code=%d last_rword=%d\n",
+		debug_printf_exec(": rword:%d cond_code:%d last_rword:%d\n",
 				rword, cond_code, last_rword);
 
 		sv_errexit_depth = G.errexit_depth;
@@ -10395,23 +10480,29 @@ static int run_list(struct pipe *pi)
 			}
 		}
 		last_followup = pi->followup;
-		IF_HAS_KEYWORDS(last_rword = rword;)
 #if ENABLE_HUSH_IF
-		if (cond_code) {
+		if (cond_code != 0) {
 			if (rword == RES_THEN) {
 				/* if false; then ... fi has exitcode 0! */
 				G.last_exitcode = rcode = EXIT_SUCCESS;
 				/* "if <false> THEN cmd": skip cmd */
+				debug_printf_exec("skipped THEN cmd because IF condition was false\n");
+				last_rword = rword;
 				continue;
 			}
 		} else {
-			if (rword == RES_ELSE || rword == RES_ELIF) {
+			if (rword == RES_ELSE
+			 || (rword == RES_ELIF && last_rword != RES_ELIF)
+			) {
 				/* "if <true> then ... ELSE/ELIF cmd":
 				 * skip cmd and all following ones */
+				debug_printf_exec("skipped ELSE/ELIF branch because IF condition was true\n");
 				break;
 			}
+			//if (rword == RES_THEN): "if <true> THEN cmd", run cmd (fall through)
 		}
 #endif
+		IF_HAS_KEYWORDS(last_rword = rword;)
 #if ENABLE_HUSH_LOOPS
 		if (rword == RES_FOR) { /* && pi->num_cmds - always == 1 */
 			if (!for_lcur) {
@@ -10420,7 +10511,7 @@ static int run_list(struct pipe *pi)
 				static const char encoded_dollar_at[] ALIGN1 = {
 					SPECIAL_VAR_SYMBOL, '@' | 0x80, SPECIAL_VAR_SYMBOL, '\0'
 				}; /* encoded representation of "$@" */
-				static const char *const encoded_dollar_at_argv[] = {
+				static const char *const encoded_dollar_at_argv[] ALIGN_PTR = {
 					encoded_dollar_at, NULL
 				}; /* argv list with one element: "$@" */
 				char **vals;
@@ -10451,7 +10542,7 @@ static int run_list(struct pipe *pi)
 			/* Insert next value from for_lcur */
 			/* note: *for_lcur already has quotes removed, $var expanded, etc */
 #ifndef __U_BOOT__
-			set_local_var(xasprintf("%s=%s", pi->cmds[0].argv[0], *for_lcur++), /*flag:*/ 0);
+			set_local_var_from_halves(pi->cmds[0].argv[0], *for_lcur++);
 #else /* __U_BOOT__ */
 			/* We cannot use xasprintf, so we emulate it. */
 			char *full_var;
@@ -10500,7 +10591,7 @@ static int run_list(struct pipe *pi)
 				);
 				/* TODO: which FNM_xxx flags to use? */
 				cond_code = (fnmatch(pattern, case_word, /*flags:*/ 0) != 0);
-				debug_printf_exec("fnmatch(pattern:'%s',str:'%s'):%d\n",
+				debug_printf_exec("cond_code=fnmatch(pattern:'%s',str:'%s'):%d\n",
 						pattern, case_word, cond_code);
 				free(pattern);
 				if (cond_code == 0) {
@@ -10547,8 +10638,11 @@ static int run_list(struct pipe *pi)
 		G.flag_break_continue = 0;
 #endif
 #endif /* !__U_BOOT__ */
+#ifndef __U_BOOT__
+		rcode = r = G.o_opt[OPT_O_NOEXEC] ? 0 : run_pipe(pi);
+		/* NB: rcode is a smalluint, r is int */
+#else /* __U_BOOT__ */
 		rcode = r = run_pipe(pi); /* NB: rcode is a smalluint, r is int */
-#ifdef __U_BOOT__
 		if (r <= EXIT_RET_CODE) {
 			int previous_rcode = G.last_exitcode;
 			/*
@@ -10672,8 +10766,10 @@ static int run_list(struct pipe *pi)
 
 		/* Analyze how result affects subsequent commands */
 #if ENABLE_HUSH_IF
-		if (rword == RES_IF || rword == RES_ELIF)
+		if (rword == RES_IF || rword == RES_ELIF) {
+			debug_printf_exec("cond_code=rcode:%d\n", rcode);
 			cond_code = rcode;
+		}
 #endif
 #ifndef __U_BOOT__
  check_jobs_and_continue:
@@ -10717,7 +10813,7 @@ static int run_list(struct pipe *pi)
 #endif
 #ifndef __U_BOOT__
 	debug_leave();
-	debug_printf_exec("run_list lvl %d return %d\n", G.run_list_level + 1, rcode);
+	debug_printf_exec("run_list lvl %d return %d\n", G.run_list_level, rcode);
 #endif /* !__U_BOOT__ */
 	return rcode;
 }
@@ -10838,7 +10934,10 @@ static int set_mode(int state, char mode, const char *o_opt)
 	int idx;
 	switch (mode) {
 	case 'n':
-		G.o_opt[OPT_O_NOEXEC] = state;
+		/* set -n has no effect in interactive shell */
+		/* Try: while set -n; do echo $-; done */
+		if (!G_interactive_fd)
+			G.o_opt[OPT_O_NOEXEC] = state;
 		break;
 	case 'x':
 		IF_HUSH_MODE_X(G_x_mode = state;)
@@ -10895,6 +10994,20 @@ int hush_main(int argc, char **argv)
 	INIT_G();
 	if (EXIT_SUCCESS != 0) /* if EXIT_SUCCESS == 0, it is already done */
 		G.last_exitcode = EXIT_SUCCESS;
+#if !BB_MMU
+	/* "Big heredoc" support via "sh -< STRING" invocation.
+	 * Check it first (do not bother to run the usual init code,
+	 * it is not needed for this case).
+	 */
+	if (argv[1]
+	 && argv[1][0] == '-' && argv[1][1] == '<' /*&& !argv[1][2]*/
+	 /*&& argv[2] && !argv[3] - we don't check some conditions */
+	) {
+		full_write1_str(argv[2]);
+		_exit(0);
+	}
+	G.argv0_for_re_execing = argv[0];
+#endif
 #if ENABLE_HUSH_TRAP
 # if ENABLE_HUSH_FUNCTIONS
 	G.return_exitcode = -1;
@@ -10905,13 +11018,10 @@ int hush_main(int argc, char **argv)
 #if ENABLE_HUSH_FAST
 	G.count_SIGCHLD++; /* ensure it is != G.handled_SIGCHLD */
 #endif
-#if !BB_MMU
-	G.argv0_for_re_execing = argv[0];
-#endif
 
 	cached_getpid = getpid();   /* for tcsetpgrp() during init */
 	G.root_pid = cached_getpid; /* for $PID  (NOMMU can override via -$HEXPID:HEXPPID:...) */
-	G.root_ppid = getppid();    /* for $PPID (NOMMU can override)  */
+	G.root_ppid = getppid();    /* for $PPID (NOMMU can override) */
 
 	/* Deal with HUSH_VERSION */
 	debug_printf_env("unsetenv '%s'\n", "HUSH_VERSION");
@@ -11023,7 +11133,10 @@ int hush_main(int argc, char **argv)
 		int opt = getopt(argc, argv, "+" /* stop at 1st non-option */
 				"cexinsl"
 #if !BB_MMU
-				"<:$:R:V:"
+				"$:R:V:"
+# if ENABLE_HUSH_LINENO_VAR
+				"L:"
+# endif
 # if ENABLE_HUSH_FUNCTIONS
 				"F:"
 # endif
@@ -11042,6 +11155,29 @@ int hush_main(int argc, char **argv)
 			/* Well, we cannot just declare interactiveness,
 			 * we have to have some stuff (ctty, etc) */
 			/* G_interactive_fd++; */
+//There are a few cases where bash -i -c 'SCRIPT'
+//has visible effect (differs from bash -c 'SCRIPT'):
+//it ignores TERM:
+//	bash -i -c 'kill $$; echo ALIVE'
+//	ALIVE
+//it resets SIG_IGNed HUP to SIG_DFL:
+//	trap '' hup; bash -i -c 'kill -hup $$; echo ALIVE'
+//	Hangup   [the message is not printed by bash, it's the shell which started it]
+//is talkative about jobs and exiting:
+//	bash -i -c 'sleep 1 & exit'
+//	[1] 16170
+//	exit
+//includes $ENV file (only if run as "sh"):
+//	echo last >/tmp/ENV; ENV=/tmp/ENV sh -i -c 'echo HERE'
+//	last: cannot open /var/log/wtmp: No such file or directory
+//	HERE
+//(under "bash", it's the opposite: it runs $BASH_ENV file only *without* -i).
+//
+//ash -i -c 'sleep 3; sleep 3', on ^C, drops into a prompt instead of exiting
+//(this may be a bug, bash does not do this).
+//(ash -i -c 'sleep 3' won't show this, the last command gets auto-"exec"ed)
+//
+//None of the above feel like useful features people would rely on.
 			break;
 		case 's':
 			G.opt_s = 1;
@@ -11050,9 +11186,6 @@ int hush_main(int argc, char **argv)
 			flags |= OPT_login;
 			break;
 #if !BB_MMU
-		case '<': /* "big heredoc" support */
-			full_write1_str(optarg);
-			_exit(0);
 		case '$': {
 			unsigned long long empty_trap_mask;
 
@@ -11102,6 +11235,11 @@ int hush_main(int argc, char **argv)
 		case 'V':
 			set_local_var(xstrdup(optarg), opt == 'R' ? SETFLAG_MAKE_RO : 0);
 			break;
+# if ENABLE_HUSH_LINENO_VAR
+		case 'L':
+			G.parse_lineno = xatou(optarg);
+			break;
+# endif
 # if ENABLE_HUSH_FUNCTIONS
 		case 'F': {
 			struct function *funcp = new_function(optarg);
@@ -11306,8 +11444,11 @@ int hush_main(int argc, char **argv)
 
 # if ENABLE_FEATURE_EDITING
 		G.line_input_state = new_line_input_t(FOR_SHELL);
-#  if EDITING_HAS_get_exe_name
-		G.line_input_state->get_exe_name = get_builtin_name;
+#  if ENABLE_FEATURE_TAB_COMPLETION
+		G.line_input_state->get_exe_name = hush_command_name;
+#  endif
+#  if EDITING_HAS_sh_get_var
+		G.line_input_state->sh_get_var = get_local_var_value;
 #  endif
 # endif
 # if ENABLE_HUSH_SAVEHISTORY && MAX_HISTORY > 0
@@ -11393,6 +11534,11 @@ static int FAST_FUNC builtin_true(char **argv UNUSED_PARAM)
 	return 0;
 }
 
+static int FAST_FUNC builtin_false(char **argv UNUSED_PARAM)
+{
+	return 1;
+}
+
 #if ENABLE_HUSH_TEST || ENABLE_HUSH_ECHO || ENABLE_HUSH_PRINTF || ENABLE_HUSH_KILL
 static NOINLINE int run_applet_main(char **argv, int (*applet_main_func)(int argc, char **argv))
 {
@@ -11443,14 +11589,6 @@ static int FAST_FUNC builtin_history(char **argv UNUSED_PARAM)
 }
 #endif
 
-static char **skip_dash_dash(char **argv)
-{
-	argv++;
-	if (argv[0] && argv[0][0] == '-' && argv[0][1] == '-' && argv[0][2] == '\0')
-		argv++;
-	return argv;
-}
-
 static int FAST_FUNC builtin_cd(char **argv)
 {
 	const char *newdir;
@@ -11733,9 +11871,15 @@ static int FAST_FUNC builtin_umask(char **argv)
 }
 #endif
 
-#if ENABLE_HUSH_EXPORT || ENABLE_HUSH_TRAP
+#if ENABLE_HUSH_EXPORT || ENABLE_HUSH_READONLY || ENABLE_HUSH_SET || ENABLE_HUSH_TRAP
 static void print_escaped(const char *s)
 {
+//TODO? bash "set" does not quote variables which contain only alnums and "%+,-./:=@_~",
+// (but "export" quotes all variables, even with only these chars).
+// I think quoting strings with %+,=~ looks better
+// (example: "set" printing var== instead of var='=' looks strange)
+// IOW: do not quote "-./:@_": / is used in pathnames, : in PATH, -._ often in file names, @ in emails
+
 	if (*s == '\'')
 		goto squote;
 	do {
@@ -11764,7 +11908,7 @@ static int helper_export_local(char **argv, unsigned flags)
 		if (*name_end == '\0') {
 			struct variable *var, **vpp;
 
-			vpp = get_ptr_to_local_var(name, name_end - name);
+			vpp = get_ptr_to_local_var(name);
 			var = vpp ? *vpp : NULL;
 
 			if (flags & SETFLAG_UNEXPORT) {
@@ -11866,8 +12010,8 @@ static int FAST_FUNC builtin_export(char **argv)
 
 				if (!p) /* wtf? take next variable */
 					continue;
-				/* export var= */
-				printf("export %.*s", (int)(p - s) + 1, s);
+				/* "export VAR=" */
+				printf("%s %.*s", "export", (int)(p - s) + 1, s);
 				print_escaped(p + 1);
 				putchar('\n');
 # endif
@@ -11888,6 +12032,9 @@ static int FAST_FUNC builtin_local(char **argv)
 		bb_error_msg("%s: not in a function", argv[0]);
 		return EXIT_FAILURE; /* bash compat */
 	}
+//TODO? ash and bash support "local -" special form,
+//which saves/restores $- around function call (including async returns, such as ^C)
+//(IOW: it makes "set +/-..." effects local)
 	argv++;
 	/* Since all builtins run in a nested variable level,
 	 * need to use level - 1 here. Or else the variable will be removed at once
@@ -11908,8 +12055,15 @@ static int FAST_FUNC builtin_readonly(char **argv)
 		struct variable *e;
 		for (e = G.top_var; e; e = e->next) {
 			if (e->flg_read_only) {
-//TODO: quote value: readonly VAR='VAL'
-				printf("readonly %s\n", e->varstr);
+				const char *s = e->varstr;
+				const char *p = strchr(s, '=');
+
+				if (!p) /* wtf? take next variable */
+					continue;
+				/* "readonly VAR=" */
+				printf("%s %.*s", "readonly", (int)(p - s) + 1, s);
+				print_escaped(p + 1);
+				putchar('\n');
 			}
 		}
 		return EXIT_SUCCESS;
@@ -11987,8 +12141,17 @@ static int FAST_FUNC builtin_set(char **argv)
 
 	if (arg == NULL) {
 		struct variable *e;
-		for (e = G.top_var; e; e = e->next)
-			puts(e->varstr);
+		for (e = G.top_var; e; e = e->next) {
+			const char *s = e->varstr;
+			const char *p = strchr(s, '=');
+
+			if (!p) /* wtf? take next variable */
+				continue;
+			/* var= */
+			printf("%.*s", (int)(p - s) + 1, s);
+			print_escaped(p + 1);
+			putchar('\n');
+		}
 		return EXIT_SUCCESS;
 	}
 
@@ -12421,7 +12584,7 @@ static int FAST_FUNC builtin_fg_bg(char **argv)
 	/* TODO: bash prints a string representation
 	 * of job being foregrounded (like "sleep 1 | cat") */
 	if (argv[0][0] == 'f' && G_saved_tty_pgrp) {
-		/* Put the job into the foreground.  */
+		/* Put the job into the foreground. */
 		tcsetpgrp(G_interactive_fd, pi->pgrp);
 	}
 
-- 
2.34.1

