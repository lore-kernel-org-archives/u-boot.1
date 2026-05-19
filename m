Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DFFCD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5441E848B3;
	Wed, 20 May 2026 01:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YdwOyCvx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC0D58483C; Wed, 20 May 2026 01:32:44 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40BF5848B3
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-40423dbe98bso2049899fac.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779233561; x=1779838361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGu4IG/o+XYgpVMhYOPoxNRwzIYT7kwIzkIMY4r29nI=;
 b=YdwOyCvxFpGPSrWVbYMtc+FftoC/Vivk5CcU2fl/dVauEuymf0mWUhNSgcEIXzndBR
 zRrHCI+Pkmx2IpcIo1n/Bq+tPt62f6EdNNlfnyC6kB62N2sw6Ctw3yrj4VAq4pS7zfvW
 ZPqezYzKBE39moZIwHxXjKadwsZpODLjMiXHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233561; x=1779838361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iGu4IG/o+XYgpVMhYOPoxNRwzIYT7kwIzkIMY4r29nI=;
 b=P7EtuyQ3JLKSLOBg51QctqdNOvJVNBNJDUOFHB+4RJjvC+jGuK4PqO3L066mrr2TNd
 0+YN7GaXYBWE67pIIOvmI5MEeQ/dBpsJJ//dGEJ9hdnladt6d0AWh3TRikJf1/IJ7qED
 qfRbN1bW3TJFQUMf/9XIiijSpcW22yQC+HzUoUIK7wAah1w0+3wEGkX/JBTVzuNALTcD
 irsEoMKPRe1prZCFJhOH3uLnLh0vuH2Yr0gOZSs4F+uXeZdqxhxDDuQZ52GL8k2LbvJ+
 4oIsPuFjahkm2B3fUsETxCQqvEsOUytjmj/Vg3xCUGiCKw7vVFMLcBvK06LAXXXWUjnT
 HSmg==
X-Gm-Message-State: AOJu0Yyp4IBRXOf0odShJ2Br6qRrdW0kQ3qW2T8xz1Zic+jUAIwQEcas
 oqa42caqDE8/1TWFFOD6Zb8KhUNvlmJ5NG5JyBZ6il1J1HMUsHeaf4mEvp6LU8x60bjlbfbxPjq
 lGFqJv2QR
X-Gm-Gg: Acq92OExHyg1D2a7PheL2+bhhn2igiJV7pzddobazlRFELCuVVdkYAA9weVKgW9WqTa
 2TpmcZLQEuzjudp7U8szAX0tJSJEv02RAzI0smPpGjuGmD85UnAXCUvBUY9VsRm/QDrT4aBCcDe
 hfRWGzbK2RjObTFrjD/jbqhkKaNKOwLauTh3MfTINyOeXzH3RpJ6Ewav+Z2OaOlu6sUWA4I/E3g
 nWCDN57+ZgzpnXlhx5qktACov6kcix3fqfYpqUbcNu/Fy9BL9iiw7fkVZEuyzQok4Uzv5vMXbgw
 yWdxG19ASTcS6FhlVKtPjDFShUr76pC+p81kRY7q/eL2upcYk5sUdTTzQMjuibvNGVT0Ez3WL9y
 snLmFkvjoer3owtOpjdQuc8X+BalU0fWCwfDhZ6PmUPKnbLOzsWCcUwSVz4DGQGt/N8P5XwxYxU
 3XxLiRH7SsflNOQirDng==
X-Received: by 2002:a05:6820:629:b0:694:9175:9d47 with SMTP id
 006d021491bc7-69c942ffb16mr13551357eaf.18.1779233560700; 
 Tue, 19 May 2026 16:32:40 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d04911744sm7983725eaf.12.2026.05.19.16.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:32:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [RFC PATCH v2 05/17] lib: getopt: Permute by default with inline
 reorder
Date: Tue, 19 May 2026 17:31:31 -0600
Message-ID: <20260519233207.2765755-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519233207.2765755-1-sjg@chromium.org>
References: <20260519233207.2765755-1-sjg@chromium.org>
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

Currently getopt() does not reorder its argv: it stops at the first
non-option, which forces options to appear before positional
arguments. This is not the usual way that arguments work - people
expect options to be recognised wherever they appear on the command
line, although some U-Boot commands are hard-wired for particular
positions.

Restructure the parser to permute by default. Add argc and a writable
argv[CONFIG_SYS_MAXARGS + 1] buffer to struct getopt_state, plus a
nonopts counter. The init function getopt_init_state() takes argc and
argv, copies argv into the state's buffer, and resets the parse
position. Then getopt() and getopt_silent() take only the state and an
optstring; argc and argv are read from the state.

When getopt() encounters a non-option, it permutes that argv element
to the end of the buffer and increments nonopts, then keeps scanning.
The outer condition stops when index + nonopts reaches argc, so the
permuted non-options are never re-scanned. After parsing finishes,
gs.index points at the first non-option, with gs.nonopts of them
sitting at gs.argv[gs.index .. argc - 1]

Callers that need the previous POSIX-style 'stop at first non-option'
behaviour can prefix optstring with '+'. This matches GNU getopt's
convention and keeps to two public entry points (getopt() and
getopt_silent()) instead of doubling them up for in-order variants.

Update the two existing in-tree callers, cmd/bdinfo.c and cmd/log.c,
to the new signatures. bdinfo has no positional arguments so it works
the same either way; log filter-list/add/remove preserve their
original semantics with the '+' prefix. Update test helper in
test/lib/getopt.c too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Use "permute" terminology in docs and comments
- Move the working argv array to the top of struct getopt_state and
  rename it from @args to @argv (drops inter-field padding too)
- Refine kerneldoc for @index
- Restore the original worked example in getopt()'s kerneldoc
- Add tests for permuted argv, a required argument missing after a
  leading non-option, and the '+' prefix

 cmd/bdinfo.c      |  4 +--
 cmd/log.c         | 12 ++++-----
 include/getopt.h  | 68 ++++++++++++++++++++++++++++-------------------
 lib/getopt.c      | 67 +++++++++++++++++++++++++++++++++++-----------
 test/lib/getopt.c | 47 +++++++++++++++++++++++++++++---
 5 files changed, 143 insertions(+), 55 deletions(-)

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index ddf77303735..c46094c3ddf 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -188,8 +188,8 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (!CONFIG_IS_ENABLED(GETOPT) || argc == 1)
 		return bdinfo_print_all(bd);
 
-	getopt_init_state(&gs);
-	while ((opt = getopt(&gs, argc, argv, "aem")) > 0) {
+	getopt_init_state(&gs, argc, argv);
+	while ((opt = getopt(&gs, "aem")) > 0) {
 		switch (opt) {
 		case 'a':
 			return bdinfo_print_all(bd);
diff --git a/cmd/log.c b/cmd/log.c
index 64add6d8b5a..344f379d8cc 100644
--- a/cmd/log.c
+++ b/cmd/log.c
@@ -95,8 +95,8 @@ static int do_log_filter_list(struct cmd_tbl *cmdtp, int flag, int argc,
 	struct log_filter *filt;
 	struct log_device *ldev;
 
-	getopt_init_state(&gs);
-	while ((opt = getopt(&gs, argc, argv, "d:")) > 0) {
+	getopt_init_state(&gs, argc, argv);
+	while ((opt = getopt(&gs, "+d:")) > 0) {
 		switch (opt) {
 		case 'd':
 			drv_name = gs.arg;
@@ -157,8 +157,8 @@ static int do_log_filter_add(struct cmd_tbl *cmdtp, int flag, int argc,
 	enum log_level_t level = LOGL_MAX;
 	struct getopt_state gs;
 
-	getopt_init_state(&gs);
-	while ((opt = getopt(&gs, argc, argv, "Ac:d:Df:F:l:L:p")) > 0) {
+	getopt_init_state(&gs, argc, argv);
+	while ((opt = getopt(&gs, "+Ac:d:Df:F:l:L:p")) > 0) {
 		switch (opt) {
 		case 'A':
 #define do_type() do { \
@@ -250,8 +250,8 @@ static int do_log_filter_remove(struct cmd_tbl *cmdtp, int flag, int argc,
 	const char *drv_name = "console";
 	struct getopt_state gs;
 
-	getopt_init_state(&gs);
-	while ((opt = getopt(&gs, argc, argv, "ad:")) > 0) {
+	getopt_init_state(&gs, argc, argv);
+	while ((opt = getopt(&gs, "+ad:")) > 0) {
 		switch (opt) {
 		case 'a':
 			all = true;
diff --git a/include/getopt.h b/include/getopt.h
index 0cf7ee84d6f..d90bee2abdd 100644
--- a/include/getopt.h
+++ b/include/getopt.h
@@ -10,18 +10,29 @@
 #define __GETOPT_H
 
 #include <stdbool.h>
+#include <linux/kconfig.h>
 
 /**
  * struct getopt_state - Saved state across getopt() calls
  */
 struct getopt_state {
 	/**
-	 * @index: Index of the next unparsed argument of @argv. If getopt() has
-	 * parsed all of @argv, then @index will equal @argc.
+	 * @argv: Working copy of argv. getopt() reorders this in place: as
+	 * options are consumed, non-options are permuted to the end.
+	 */
+	char *argv[CONFIG_SYS_MAXARGS + 1];
+	/** @argc: Argument count, as passed to getopt_init_state() */
+	int argc;
+	/**
+	 * @index: Index of the next unparsed argument of @argv. If getopt()
+	 * has parsed all of @argv, then @index will be the first non-option
+	 * argument of @argv (or @argc if none).
 	 */
 	int index;
 	/** @arg_index: Index within the current argument */
 	int arg_index;
+	/** @nonopts: Number of non-option arguments in @argv. */
+	int nonopts;
 	union {
 		/**
 		 * @opt: Option being parsed when an error occurs. @opt is only
@@ -39,20 +50,22 @@ struct getopt_state {
 /**
  * getopt_init_state() - Initialize a &struct getopt_state
  * @gs: The state to initialize
+ * @argc: Argument count
+ * @argv: Source argv. Copied into @gs->argv; the original is not
+ *        modified. @argc must not exceed ``CONFIG_SYS_MAXARGS``;
+ *        excess arguments are silently dropped.
  *
  * This must be called before using @gs with getopt().
  */
-void getopt_init_state(struct getopt_state *gs);
+void getopt_init_state(struct getopt_state *gs, int argc,
+		       char *const argv[]);
 
-int __getopt(struct getopt_state *gs, int argc, char *const argv[],
-	     const char *optstring, bool silent);
+int __getopt(struct getopt_state *gs, const char *optstring, bool silent);
 
 /**
  * getopt() - Parse short command-line options
  * @gs: Internal state and out-of-band return arguments. This must be
- *      initialized with getopt_init_context() beforehand.
- * @argc: Number of arguments, not including the %NULL terminator
- * @argv: Argument list, terminated by %NULL
+ *      initialized with getopt_init_state() beforehand.
  * @optstring: Option specification, as described below
  *
  * getopt() parses short options. Short options are single characters. They may
@@ -67,11 +80,13 @@ int __getopt(struct getopt_state *gs, int argc, char *const argv[],
  * by ``::`` in @optstring, it expects an optional argument. @gs.arg points
  * to the argument, if one is parsed.
  *
- * getopt() stops parsing options when it encounters the first non-option
- * argument, when it encounters the argument ``--``, or when it runs out of
- * arguments. For example, in ``ls -l foo -R``, option parsing will stop when
- * getopt() encounters ``foo``, if ``l`` does not expect an argument. However,
- * the whole list of arguments would be parsed if ``l`` expects an argument.
+ * By default, getopt() permutes its argv: when it encounters a non-option,
+ * it moves that element to the end of @gs.argv and keeps scanning, so
+ * options can appear anywhere on the command line. After parsing finishes,
+ * @gs.index points at the first non-option, and there are @gs.nonopts of
+ * them at @gs.argv[gs.index..argc-1]. If @optstring begins with ``+``,
+ * getopt() instead stops at the first non-option (POSIX ``getopt``
+ * behaviour). An ``--`` argument terminates option scanning in either mode.
  *
  * An example invocation of getopt() might look like::
  *
@@ -79,16 +94,16 @@ int __getopt(struct getopt_state *gs, int argc, char *const argv[],
  *     int opt, argc = ARRAY_SIZE(argv) - 1;
  *     struct getopt_state gs;
  *
- *     getopt_init_state(&gs);
- *     while ((opt = getopt(&gs, argc, argv, "a::b:c")) != -1)
+ *     getopt_init_state(&gs, argc, argv);
+ *     while ((opt = getopt(&gs, "a::b:c")) != -1)
  *         printf("opt = %c, index = %d, arg = \"%s\"\n", opt, gs.index, gs.arg);
- *     printf("%d argument(s) left\n", argc - gs.index);
+ *     printf("%d argument(s) left\n", gs.nonopts);
  *
  * and would produce an output of::
  *
  *     opt = c, index = 1, arg = "<NULL>"
  *     opt = b, index = 2, arg = "x"
- *     opt = a, index = 4, arg = "foo"
+ *     opt = a, index = 3, arg = "foo"
  *     1 argument(s) left
  *
  * For further information, refer to the getopt(3) man page.
@@ -96,34 +111,31 @@ int __getopt(struct getopt_state *gs, int argc, char *const argv[],
  * Return:
  * * An option character if an option is found. @gs.arg is set to the
  *   argument if there is one, otherwise it is set to ``NULL``.
- * * ``-1`` if there are no more options, if a non-option argument is
- *   encountered, or if an ``--`` argument is encountered.
+ * * ``-1`` if there are no more options, or if an ``--`` argument is
+ *   encountered.
  * * ``'?'`` if we encounter an option not in @optstring. @gs.opt is set to
  *   the unknown option.
  * * ``':'`` if an argument is required, but no argument follows the
  *   option. @gs.opt is set to the option missing its argument.
  *
- * @gs.index is always set to the index of the next unparsed argument in @argv.
+ * @gs.index is always set to the index of the next unparsed argument in
+ * @gs.argv.
  */
-static inline int getopt(struct getopt_state *gs, int argc,
-			 char *const argv[], const char *optstring)
+static inline int getopt(struct getopt_state *gs, const char *optstring)
 {
-	return __getopt(gs, argc, argv, optstring, false);
+	return __getopt(gs, optstring, false);
 }
 
 /**
  * getopt_silent() - Parse short command-line options silently
  * @gs: State
- * @argc: Argument count
- * @argv: Argument list
  * @optstring: Option specification
  *
  * Same as getopt(), except no error messages are printed.
  */
-static inline int getopt_silent(struct getopt_state *gs, int argc,
-				char *const argv[], const char *optstring)
+static inline int getopt_silent(struct getopt_state *gs, const char *optstring)
 {
-	return __getopt(gs, argc, argv, optstring, true);
+	return __getopt(gs, optstring, true);
 }
 
 #endif /* __GETOPT_H */
diff --git a/lib/getopt.c b/lib/getopt.c
index e9175e2fff4..126427bb4ad 100644
--- a/lib/getopt.c
+++ b/lib/getopt.c
@@ -10,37 +10,71 @@
 
 #include <getopt.h>
 #include <log.h>
+#include <linux/kernel.h>
 #include <linux/string.h>
 
-void getopt_init_state(struct getopt_state *gs)
+void getopt_init_state(struct getopt_state *gs, int argc, char *const argv[])
 {
+	int max = ARRAY_SIZE(gs->argv) - 1;
+
+	if (argc > max)
+		argc = max;
+
+	gs->argc = argc;
+	memcpy(gs->argv, argv, (argc + 1) * sizeof(*gs->argv));
+	gs->argv[argc] = NULL;
 	gs->index = 1;
 	gs->arg_index = 1;
+	gs->nonopts = 0;
 }
 
-int __getopt(struct getopt_state *gs, int argc, char *const argv[],
-	     const char *optstring, bool silent)
+int __getopt(struct getopt_state *gs, const char *optstring, bool silent)
 {
-	char curopt;   /* current option character */
-	const char *curoptp; /* pointer to the current option in optstring */
+	char curopt;	/* current option character */
+	const char *curoptp;	/* pointer to the current option in optstring */
+	bool stop_nonopt = false;
+	char **argv = gs->argv;
+	int argc = gs->argc;
+
+	if (*optstring == '+') {
+		stop_nonopt = true;
+		optstring++;
+	}
 
 	while (1) {
-		log_debug("arg_index: %d index: %d\n", gs->arg_index,
-			  gs->index);
+		log_debug("arg_index: %d index: %d nonopts: %d\n",
+			  gs->arg_index, gs->index, gs->nonopts);
 
 		/* `--` indicates the end of options */
-		if (gs->arg_index == 1 && argv[gs->index] &&
+		if (gs->arg_index == 1 && gs->index < argc &&
 		    !strcmp(argv[gs->index], "--")) {
 			gs->index++;
 			return -1;
 		}
 
-		/* Out of arguments */
-		if (gs->index >= argc)
-			return -1;
+		/*
+		 * Permute non-options to the end so we can keep scanning
+		 * for options past them. In '+' mode (POSIX), stop at the
+		 * first non-option instead.
+		 */
+		while (gs->arg_index == 1 &&
+		       gs->index + gs->nonopts < argc) {
+			char *cur = argv[gs->index];
+			int i;
+
+			if (*cur == '-')
+				break;
+			if (stop_nonopt)
+				return -1;
+
+			gs->nonopts++;
+			for (i = gs->index; i + 1 < argc; i++)
+				argv[i] = argv[i + 1];
+			argv[argc - 1] = cur;
+		}
 
-		/* Can't parse non-options */
-		if (*argv[gs->index] != '-')
+		/* Out of options to scan */
+		if (gs->index + gs->nonopts >= argc)
 			return -1;
 
 		/* We have found an option */
@@ -48,7 +82,8 @@ int __getopt(struct getopt_state *gs, int argc, char *const argv[],
 		if (curopt)
 			break;
 		/*
-		 * no more options in current argv[] element; try the next one
+		 * No more options in current argv[] element; advance to the
+		 * next one
 		 */
 		gs->index++;
 		gs->arg_index = 1;
@@ -80,7 +115,7 @@ int __getopt(struct getopt_state *gs, int argc, char *const argv[],
 			gs->arg_index = 1;
 			return curopt;
 		}
-		if (gs->index + 1 == argc) {
+		if (gs->index + gs->nonopts + 1 == argc) {
 			/* We are at the last argv[] element */
 			gs->arg = NULL;
 			gs->index++;
@@ -113,7 +148,7 @@ int __getopt(struct getopt_state *gs, int argc, char *const argv[],
 	gs->index++;
 	gs->arg_index = 1;
 
-	if (gs->index >= argc || argv[gs->index][0] == '-') {
+	if (gs->index + gs->nonopts >= argc || argv[gs->index][0] == '-') {
 		if (!silent)
 			printf("option requires an argument -- %c\n", curopt);
 		gs->opt = curopt;
diff --git a/test/lib/getopt.c b/test/lib/getopt.c
index 388a076200b..ad4555d03ff 100644
--- a/test/lib/getopt.c
+++ b/test/lib/getopt.c
@@ -18,9 +18,9 @@ static int do_test_getopt(struct unit_test_state *uts, int line,
 {
 	int opt;
 
-	getopt_init_state(gs);
+	getopt_init_state(gs, args, argv);
 	for (int i = 0; i < expected_count; i++) {
-		opt = getopt_silent(gs, args, argv, optstring);
+		opt = getopt_silent(gs, optstring);
 		if (expected[i] != opt) {
 			/*
 			 * Fudge the line number so we can tell which test
@@ -34,7 +34,7 @@ static int do_test_getopt(struct unit_test_state *uts, int line,
 		}
 	}
 
-	opt = getopt_silent(gs, args, argv, optstring);
+	opt = getopt_silent(gs, optstring);
 	if (opt != -1) {
 		ut_failf(uts, __FILE__, line, __func__,
 			 "getopt() != -1",
@@ -56,6 +56,7 @@ static int do_test_getopt(struct unit_test_state *uts, int line,
 static int lib_test_getopt(struct unit_test_state *uts)
 {
 	struct getopt_state gs;
+	char *plus_argv[] = { "program", "foo", "-a", 0 };
 
 	/* Happy path */
 	test_getopt("ab:c",
@@ -117,6 +118,46 @@ static int lib_test_getopt(struct unit_test_state *uts)
 	ut_assertnonnull(gs.arg);
 	ut_asserteq_str("foo", gs.arg);
 
+	/*
+	 * Reordered (permuted) arguments: options interleaved with
+	 * non-options should be picked up in the order they appear, with
+	 * non-options moved to the end of @argv.
+	 */
+	test_getopt("ab",
+		    ((char *[]){ "program", "foo", "-a", "bar", "-b", 0 }),
+		    ((int []){ 'a', 'b' }));
+	ut_asserteq(3, gs.index);
+	ut_asserteq(2, gs.nonopts);
+	ut_asserteq_str("foo", gs.argv[3]);
+	ut_asserteq_str("bar", gs.argv[4]);
+
+	/*
+	 * A required argument with only a parked non-option to its right
+	 * must report ':' rather than consume the non-option
+	 */
+	test_getopt("a:",
+		    ((char *[]){ "program", "foo", "-a", 0 }),
+		    ((int []){ ':' }));
+	ut_asserteq('a', gs.opt);
+
+	/*
+	 * Required argument supplied after a leading non-option: the
+	 * non-option is permuted out of the way and the argument is
+	 * picked up correctly
+	 */
+	test_getopt("a:b",
+		    ((char *[]){ "program", "foo", "-a", "x", "-b", 0 }),
+		    ((int []){ 'a', 'b' }));
+	ut_asserteq(4, gs.index);
+	ut_asserteq(1, gs.nonopts);
+	ut_asserteq_str("foo", gs.argv[4]);
+
+	/* '+' prefix disables permutation: stop at the first non-option */
+	getopt_init_state(&gs, ARRAY_SIZE(plus_argv) - 1, plus_argv);
+	ut_asserteq(-1, getopt_silent(&gs, "+a"));
+	ut_asserteq(1, gs.index);
+	ut_asserteq(0, gs.nonopts);
+
 	return 0;
 }
 LIB_TEST(lib_test_getopt, 0);
-- 
2.43.0

