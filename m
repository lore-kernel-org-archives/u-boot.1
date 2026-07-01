Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF91EC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FA5284BC8;
	Wed,  1 Jul 2026 13:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fSOaGqTW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF87C84BC8; Wed,  1 Jul 2026 13:47:02 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAE8684BBD
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4876d5335b2so352016b6e.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782906418; x=1783511218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DB871jIyLum97vVXwaSxdI+dAxu7qj2UYpQADUTzfk=;
 b=fSOaGqTWOsjcnZtfnElGSd9BV7KgLHNsBmCPsVi0Un44ePsnfO73uOr/upxYMaM2si
 NVdGttj+KkY3rE4opaTQnO7popmoYK6x6YZstr7zqetGmMHVrTxsjoh2y+3ChBClWUMB
 vhXJk+s4G+uS7L7OgSAy9bRPksSfc2LzBOt/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782906418; x=1783511218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4DB871jIyLum97vVXwaSxdI+dAxu7qj2UYpQADUTzfk=;
 b=GdOcyLwSXSms5X7ciJ7DVLVg/+5ZNRxwGS6+fdHJ7JOmv95RciUqS7XpfKK+6a4Rg0
 gBwbqXCChjmD1ToJ5haGmePyrL4hWaMxZ1NQ7Ts01xY8h5mcw7lc1In/BVx0JoPMDuB7
 ADj4F5sy5gvbG0RBsoC1ccKgC+O35SN4rx0BtX2soT9yTXXNnIws7fjk2x43NHdkY65q
 IU1uKUPWvuWQ6sUTQEf8NO7vywuEOb2geMkiiTwn8nILIUI1SwHrZYuNUJoS4FyDPLdx
 7wU0jkfjOiTRYXx+JtMpmrCHYs0pbzHpUtb79HvUwIe9YyV6cgaGwEqGont3n5+yrBA1
 9FWg==
X-Gm-Message-State: AOJu0Ywo3ef4LTcGOUQXIYu/Atyr7D2ezPlRStLCdraU98Mq+ntZZ/US
 dJfwABzVxWarPI1NIrMW39rBD5fsUxWVq/KWZCn9EGh4Cfc/pHjlLw9ex9hOutCDZRbFw69YJVl
 kQNE=
X-Gm-Gg: AfdE7cnCYWnY53L6abfSnyPa4P8bwqzEq67nWRZ6IwnsBbU/ug5Ew3bXscyh/IJZN8D
 IH0vWENwLLmvSQ1P2zCjjiBFpsSi5wwcjXMWes4pTpcvCOdLxCUcbIp//LfeVJF/3FDFizPQoCM
 bkoaepPs3SVUy/v1NFAOUeJr9v1N+0M4hpEYZlmti36YmDJm9FI1XlmjjZAhrgYtOQ06L6iyxV3
 i9JPdSeeRRFt0k2OOcv4P9KOltdnr2GC+s7ndYqY7BV0J869xHA0J+bPg+H8mnDstel3Pj2OlOL
 dUPPBx85oCsRHPzE/FlI/4O46nKN3K0Xk/YNkTXndHgGmb8jONhILw6fvCXj+SwlpNL0+YrH3Tn
 /irO1X7rFYcb2yQ8NUmtYea9PTNyQv1FvkW57KCudDn/QvP9+7qMDYVL1C6LAlPWsC/hz1ljKvN
 qR/Azy07Q=
X-Received: by 2002:a05:6808:1814:b0:496:fde:ca15 with SMTP id
 5614622812f47-49636a36c91mr161991b6e.38.1782906418136; 
 Wed, 01 Jul 2026 04:46:58 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4960655e3e2sm1199823b6e.0.2026.07.01.04.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:46:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Heiko Schocher <hs@nabladev.com>, Heiko Stuebner <heiko@sntech.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 01/14] lib: getopt: Add optional argv permutation with
 inline reorder
Date: Wed,  1 Jul 2026 05:42:21 -0600
Message-ID: <20260701114248.1396125-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701114248.1396125-1-sjg@chromium.org>
References: <20260701114248.1396125-1-sjg@chromium.org>
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
non-option, which forces options to appear before positional arguments.
This is not the usual way that arguments work - people expect options to
be recognised wherever they appear on the command line, although some
U-Boot commands are hard-wired for particular positions.

Add permutation, gated by CONFIG_GETOPT_PERMUTE (default n so the
smaller POSIX behaviour is the baseline). getopt() and getopt_silent()
take only the state and an optstring; argc and argv are read from the
state, which getopt_init_state() now fills in.

When CONFIG_GETOPT_PERMUTE is enabled, struct getopt_state holds a
writable argv[CONFIG_SYS_MAXARGS + 1] copy plus a nonopts counter.
getopt() permutes each non-option to the end of the buffer and keeps
scanning; the outer condition stops when index + nonopts reaches argc.
After parsing, gs.index points at the first non-option, with gs.nonopts
of them at gs.argv[gs.index .. argc - 1]. Callers that want the POSIX
'stop at first non-option' behaviour prefix optstring with '+'.

When it is disabled the permute loop is compiled out (getopt() always
stops at the first non-option, so '+' is a no-op), struct getopt_state
borrows the caller's argv instead of copying it - dropping the large
in-struct buffer and the memcpy() - and the nonopts field disappears.
The NONOPTS() helper folds the remaining 'index + nonopts' expressions
to plain 'index'.

Update bdinfo and log to the new signatures, and the test helper in
test/lib/getopt.c, whose permute-specific cases are guarded and which
now has a POSIX-mode check.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add a Kconfig to control permuting

Changes in v2:
- Use "permute" terminology in docs and comments
- Move the working argv array to the top of struct getopt_state and
  rename it from @args to @argv (drops inter-field padding too)
- Refine kerneldoc for @index
- Restore the original worked example in getopt()'s kerneldoc
- Add tests for permuted argv, a required argument missing after a
  leading non-option, and the '+' prefix

 cmd/bdinfo.c      |  4 +--
 cmd/log.c         | 12 +++----
 include/getopt.h  | 78 ++++++++++++++++++++++++++---------------
 lib/Kconfig       | 17 +++++++++
 lib/getopt.c      | 89 +++++++++++++++++++++++++++++++++++++++--------
 test/lib/getopt.c | 54 ++++++++++++++++++++++++++--
 6 files changed, 200 insertions(+), 54 deletions(-)

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index bf1eca75904..e3d567492bc 100644
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
index 0cf7ee84d6f..87851242659 100644
--- a/include/getopt.h
+++ b/include/getopt.h
@@ -10,18 +10,39 @@
 #define __GETOPT_H
 
 #include <stdbool.h>
+#include <linux/kconfig.h>
 
 /**
  * struct getopt_state - Saved state across getopt() calls
  */
 struct getopt_state {
+#ifdef CONFIG_GETOPT_PERMUTE
 	/**
-	 * @index: Index of the next unparsed argument of @argv. If getopt() has
-	 * parsed all of @argv, then @index will equal @argc.
+	 * @argv: Working copy of argv. getopt() reorders this in place: as
+	 * options are consumed, non-options are permuted to the end.
+	 */
+	char *argv[CONFIG_SYS_MAXARGS + 1];
+#else
+	/**
+	 * @argv: Borrowed pointer to the caller's argv. In POSIX mode
+	 * getopt() never reorders, so no writable copy is needed.
+	 */
+	char *const *argv;
+#endif
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
+#ifdef CONFIG_GETOPT_PERMUTE
+	/** @nonopts: Number of non-option arguments in @argv. */
+	int nonopts;
+#endif
 	union {
 		/**
 		 * @opt: Option being parsed when an error occurs. @opt is only
@@ -39,20 +60,22 @@ struct getopt_state {
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
@@ -67,11 +90,13 @@ int __getopt(struct getopt_state *gs, int argc, char *const argv[],
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
@@ -79,16 +104,16 @@ int __getopt(struct getopt_state *gs, int argc, char *const argv[],
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
@@ -96,34 +121,31 @@ int __getopt(struct getopt_state *gs, int argc, char *const argv[],
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
diff --git a/lib/Kconfig b/lib/Kconfig
index 9e0f0ad7d06..ea75ded18e2 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1026,6 +1026,23 @@ config GETOPT
 	help
 	  This enables functions for parsing command-line options.
 
+config GETOPT_PERMUTE
+	bool "Permute non-option arguments to the end"
+	depends on GETOPT
+	help
+	  When enabled, getopt() permutes non-option arguments to the end
+	  of the argv list so options can appear anywhere on the command
+	  line; this matches GNU getopt behaviour. To support this getopt()
+	  keeps a writable copy of argv in struct getopt_state and tracks
+	  the number of non-options seen so far.
+
+	  When disabled, getopt() stops at the first non-option (POSIX
+	  behaviour), which produces smaller code and a much smaller
+	  struct getopt_state (it borrows the caller's argv rather than
+	  copying it), at the cost of forcing callers to put all options
+	  before any positional arguments. The '+' prefix on an optstring
+	  becomes a no-op since that is already the only mode.
+
 config OF_LIBFDT
 	bool "Enable the FDT library"
 	default y if OF_CONTROL
diff --git a/lib/getopt.c b/lib/getopt.c
index e9175e2fff4..1b3dfa5f949 100644
--- a/lib/getopt.c
+++ b/lib/getopt.c
@@ -10,37 +10,95 @@
 
 #include <getopt.h>
 #include <log.h>
+#include <linux/kernel.h>
 #include <linux/string.h>
 
-void getopt_init_state(struct getopt_state *gs)
+#ifdef CONFIG_GETOPT_PERMUTE
+#define NONOPTS(gs)	((gs)->nonopts)
+#else
+#define NONOPTS(gs)	0
+#endif
+
+void getopt_init_state(struct getopt_state *gs, int argc, char *const argv[])
 {
+#ifdef CONFIG_GETOPT_PERMUTE
+	int max = ARRAY_SIZE(gs->argv) - 1;
+
+	if (argc > max)
+		argc = max;
+
+	memcpy(gs->argv, argv, (argc + 1) * sizeof(*gs->argv));
+	gs->argv[argc] = NULL;
+	gs->nonopts = 0;
+#else
+	/* POSIX mode never reorders, so borrow the caller's argv */
+	gs->argv = argv;
+#endif
+	gs->argc = argc;
 	gs->index = 1;
 	gs->arg_index = 1;
 }
 
-int __getopt(struct getopt_state *gs, int argc, char *const argv[],
-	     const char *optstring, bool silent)
+int __getopt(struct getopt_state *gs, const char *optstring, bool silent)
 {
-	char curopt;   /* current option character */
-	const char *curoptp; /* pointer to the current option in optstring */
+	char curopt;	/* current option character */
+	const char *curoptp;	/* pointer to the current option in optstring */
+	int argc = gs->argc;
+#ifdef CONFIG_GETOPT_PERMUTE
+	char **argv = gs->argv;
+	bool stop_nonopt = false;
+#else
+	char *const *argv = gs->argv;
+#endif
+
+	if (*optstring == '+') {
+#ifdef CONFIG_GETOPT_PERMUTE
+		stop_nonopt = true;
+#endif
+		optstring++;
+	}
 
 	while (1) {
-		log_debug("arg_index: %d index: %d\n", gs->arg_index,
-			  gs->index);
+		log_content("arg_index: %d index: %d nonopts: %d\n",
+			    gs->arg_index, gs->index, NONOPTS(gs));
 
 		/* `--` indicates the end of options */
-		if (gs->arg_index == 1 && argv[gs->index] &&
+		if (gs->arg_index == 1 && gs->index < argc &&
 		    !strcmp(argv[gs->index], "--")) {
 			gs->index++;
 			return -1;
 		}
 
-		/* Out of arguments */
-		if (gs->index >= argc)
+#ifdef CONFIG_GETOPT_PERMUTE
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
+#else
+		/* POSIX mode: stop at the first non-option */
+		if (gs->arg_index == 1 && gs->index < argc &&
+		    *argv[gs->index] != '-')
 			return -1;
+#endif
 
-		/* Can't parse non-options */
-		if (*argv[gs->index] != '-')
+		/* Out of options to scan */
+		if (gs->index + NONOPTS(gs) >= argc)
 			return -1;
 
 		/* We have found an option */
@@ -48,7 +106,8 @@ int __getopt(struct getopt_state *gs, int argc, char *const argv[],
 		if (curopt)
 			break;
 		/*
-		 * no more options in current argv[] element; try the next one
+		 * No more options in current argv[] element; advance to the
+		 * next one
 		 */
 		gs->index++;
 		gs->arg_index = 1;
@@ -80,7 +139,7 @@ int __getopt(struct getopt_state *gs, int argc, char *const argv[],
 			gs->arg_index = 1;
 			return curopt;
 		}
-		if (gs->index + 1 == argc) {
+		if (gs->index + NONOPTS(gs) + 1 == argc) {
 			/* We are at the last argv[] element */
 			gs->arg = NULL;
 			gs->index++;
@@ -113,7 +172,7 @@ int __getopt(struct getopt_state *gs, int argc, char *const argv[],
 	gs->index++;
 	gs->arg_index = 1;
 
-	if (gs->index >= argc || argv[gs->index][0] == '-') {
+	if (gs->index + NONOPTS(gs) >= argc || argv[gs->index][0] == '-') {
 		if (!silent)
 			printf("option requires an argument -- %c\n", curopt);
 		gs->opt = curopt;
diff --git a/test/lib/getopt.c b/test/lib/getopt.c
index 388a076200b..d10b23ac44b 100644
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
@@ -117,6 +118,53 @@ static int lib_test_getopt(struct unit_test_state *uts)
 	ut_assertnonnull(gs.arg);
 	ut_asserteq_str("foo", gs.arg);
 
+#ifdef CONFIG_GETOPT_PERMUTE
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
+#else
+	/* POSIX-only mode: getopt() always stops at the first non-option */
+	getopt_init_state(&gs, ARRAY_SIZE(plus_argv) - 1, plus_argv);
+	ut_asserteq(-1, getopt_silent(&gs, "a"));
+	ut_asserteq(1, gs.index);
+#endif
+
 	return 0;
 }
 LIB_TEST(lib_test_getopt, 0);
-- 
2.43.0

