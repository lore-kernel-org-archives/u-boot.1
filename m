Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7796CD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 20:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FCC48486B;
	Fri, 15 May 2026 22:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UPTTI+41";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 072E984867; Fri, 15 May 2026 22:33:45 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AFEE84843
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 22:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7de4a9cb8eeso310856a34.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778877220; x=1779482020; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0KSFjgFHpXtax9v2CGVm01+NO2CX/nNm5wflX/y2BE=;
 b=UPTTI+41lgF6mf9tw7myA2l1yRmT1BnvuFxsjfcPHyZSiVe0z71IKs/Eny6wBdVicX
 trt4QqMdKgefNHp4s2UQ6Lz715wLoIuFCT1ud0C/9C+kRM0CklPyYnqTgNs4S14uWEtA
 kTMendNBkdreN3W/Qiwxk3yTABWBIqx9IRueU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778877220; x=1779482020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g0KSFjgFHpXtax9v2CGVm01+NO2CX/nNm5wflX/y2BE=;
 b=GpCrEx6nExJNXuHBmKu82QNF6YD7HamgLj9TIigi5sIZpNcXLlwr8TzEE9vRgqGI8B
 +lM8PU3BN+cetoxdPUJAGSRQUnR0HJTm5OhYzzHKsTL3oAUgEHQpbn9t2PrcryCQIpyt
 5mqIgQdbwKNCldVJQVYap2btZxXJv1Wdzajzj9RTlEmjFvTYOGCw+eqdJ7LL9XREA8bJ
 HT9mH/uYZaa6T967OY16PZfxDJMQYaJCIr/eHeRZG2i67AtouT86ioEjiLojGE6I+cg9
 Jp1hjncwVwcKuYzritnEVslcrRuXiKk3eI8SZpk/Pq8en50qL5rhVfy48oitWA3DS2FA
 U1fw==
X-Gm-Message-State: AOJu0Yx/ix0kjcmq6usNO4oiAKXywYX2Na6J+Zpev2WKZcngYpgKbBJU
 N8Wqt9OmlSTEw0UNnVZhezBVmUm8vmvOFBhCXrGfYA+aOItqQV78wAaQN4BPRXzb09uZSlts1le
 8lHAePw==
X-Gm-Gg: Acq92OEf3m6VMS1UAsS/ytge/kQHiKPM3YgUHnl1qtM07Y7a9UG+rP3nkVuLGrzirvV
 +rkoKRD8+DcWvs3dDYPvRc/CA0GfOX3EBWCNMaEhTmryl3HeBgvvMfcEH54yvN29UFYvS9Dr1Dy
 W9N85Zu2a5xUrsuvACGeeqJ/FcCsqKR6hpM2rOGMA3akrOoh0sV0xfT8J77oKw8cDljAc57+LIB
 9JTP/s+9Osf/gUoB0c50quAcSt3SgFihHD0bWH6CpgopNqQPwYnt92PUmTB23/eKKWPK57SxsMO
 x4pe9aZwv0IjnMMJ9NquqThPwDj+HvVoKM00arobls9WknGQ675SOhuC2vYceYTq77B5CjpH66W
 eA+CBs3GkGITRZxtT9NGhHGp28GbFxb7tss9RYhgOSHrENyjmY1ZKc3IJIbGp0sjXwpZz4wMX0Z
 oqjBPJvnitEzO5s+PPmg==
X-Received: by 2002:a05:6830:2801:b0:7dc:cd0b:58bc with SMTP id
 46e09a7af769-7e4ea04a33fmr3901965a34.7.1778877220368; 
 Fri, 15 May 2026 13:33:40 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b95b82fsm2414906a34.12.2026.05.15.13.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 13:33:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 05/11] lib: getopt: Permute by default with inline reorder
Date: Fri, 15 May 2026 14:32:56 -0600
Message-ID: <20260515203311.2555651-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515203311.2555651-1-sjg@chromium.org>
References: <20260515203311.2555651-1-sjg@chromium.org>
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
U-Boot commands are hard-wires for particular positions.

Restructure the parser to permute by default. Add argc and a writable
args[CONFIG_SYS_MAXARGS + 1] buffer to struct getopt_state, plus a
nonopts counter. The init function getopt_init_state() takes argc and
argv, copies argv into args, and resets the parse position. Then
getopt() and getopt_silent() take only the state and an optstring; argc
and argv are read from the state.

When getopt() encounters a non-option, it bubbles that argv element to
the end of args and increments nonopts, then keeps scanning. The outer
condition stops when index + nonopts reaches argc, so the parked
non-options are never re-scanned. After parsing finishes, gs.index
points at the first parked non-option, with gs.nonopts of them sitting
at gs.args[gs.index .. argc - 1]

Callers that need the previous POSIX-style 'stop at first non-option'
behaviour can prefix optstring with '+'. This matches GNU getopt's
convention and keeps to two public entry points (getopt() and
getopt_silent()) instead of doubling them up for in-order variants.

Update the two existing in-tree callers, cmd/bdinfo.c and cmd/log.c, to
the new signatures. bdinfo has no positional arguments so it works the
same either way; log filter-list/add/remove preserve their original
semantics with the '+' prefix. Update test helper in test/lib/getopt.c
too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/bdinfo.c      |   4 +-
 cmd/log.c         |  12 ++--
 include/getopt.h  | 146 +++++++++++++++++++++++-----------------------
 lib/getopt.c      |  67 ++++++++++++++++-----
 test/lib/getopt.c |   6 +-
 5 files changed, 135 insertions(+), 100 deletions(-)

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
index 0cf7ee84d6f..5a9e7802e65 100644
--- a/include/getopt.h
+++ b/include/getopt.h
@@ -10,120 +10,120 @@
 #define __GETOPT_H
 
 #include <stdbool.h>
+#include <linux/kconfig.h>
 
 /**
  * struct getopt_state - Saved state across getopt() calls
+ *
+ * Initialise with getopt_init_state(); the embedded @args buffer holds a
+ * working copy of the argv passed to that initialiser.
  */
 struct getopt_state {
+	/** @argc: Argument count, as passed to getopt_init_state() */
+	int argc;
+	/**
+	 * @args: Working copy of argv. getopt() reorders this in place: as
+	 * options are consumed, non-options are bubbled to the end.
+	 */
+	char *args[CONFIG_SYS_MAXARGS + 1];
 	/**
-	 * @index: Index of the next unparsed argument of @argv. If getopt() has
-	 * parsed all of @argv, then @index will equal @argc.
+	 * @index: Index of the next unparsed argument of @args. When
+	 * parsing has finished, @index sits at the first parked
+	 * non-option (or @argc if none).
 	 */
 	int index;
-	/** @arg_index: Index within the current argument */
+	/**
+	 * @arg_index: Offset of the next unparsed character within
+	 * ``args[index]``. Lets the parser step through grouped short
+	 * options like ``-abc`` (1, 2, 3...). Reset to 1 each time
+	 * @index advances to the next argv slot.
+	 */
 	int arg_index;
+	/**
+	 * @nonopts: Number of non-option arguments parked at the tail
+	 * of @args. The parser bubbles them down so it can keep scanning
+	 * for options past them.
+	 */
+	int nonopts;
 	union {
 		/**
-		 * @opt: Option being parsed when an error occurs. @opt is only
-		 * valid when getopt() returns ``?`` or ``:``.
+		 * @opt: Option being parsed when an error occurs. @opt is
+		 * only valid when getopt() returns ``?`` or ``:``.
 		 */
 		int opt;
 		/**
-		 * @arg: The argument to an option, NULL if there is none. @arg
-		 * is only valid when getopt() returns an option character.
+		 * @arg: The argument to an option, NULL if there is none.
+		 * @arg is only valid when getopt() returns an option
+		 * character.
 		 */
 		char *arg;
 	};
 };
 
 /**
- * getopt_init_state() - Initialize a &struct getopt_state
- * @gs: The state to initialize
- *
- * This must be called before using @gs with getopt().
+ * getopt_init_state() - Initialise a &struct getopt_state from an argv
+ * @gs: The state to initialise
+ * @argc: Argument count
+ * @argv: Source argv. Copied into @gs->args; the original is not
+ *        modified. @argc must not exceed ``CONFIG_SYS_MAXARGS``;
+ *        excess arguments are silently dropped.
  */
-void getopt_init_state(struct getopt_state *gs);
+void getopt_init_state(struct getopt_state *gs, int argc,
+		       char *const argv[]);
 
-int __getopt(struct getopt_state *gs, int argc, char *const argv[],
-	     const char *optstring, bool silent);
+int __getopt(struct getopt_state *gs, const char *optstring, bool silent);
 
 /**
  * getopt() - Parse short command-line options
- * @gs: Internal state and out-of-band return arguments. This must be
- *      initialized with getopt_init_context() beforehand.
- * @argc: Number of arguments, not including the %NULL terminator
- * @argv: Argument list, terminated by %NULL
- * @optstring: Option specification, as described below
- *
- * getopt() parses short options. Short options are single characters. They may
- * be followed by a required argument or an optional argument. Arguments to
- * options may occur in the same argument as an option (like ``-larg``), or
- * in the following argument (like ``-l arg``). An argument containing
- * options begins with a ``-``. If an option expects no arguments, then it may
- * be immediately followed by another option (like ``ls -alR``).
- *
- * @optstring is a list of accepted options. If an option is followed by ``:``
- * in @optstring, then it expects a mandatory argument. If an option is followed
- * by ``::`` in @optstring, it expects an optional argument. @gs.arg points
- * to the argument, if one is parsed.
- *
- * getopt() stops parsing options when it encounters the first non-option
- * argument, when it encounters the argument ``--``, or when it runs out of
- * arguments. For example, in ``ls -l foo -R``, option parsing will stop when
- * getopt() encounters ``foo``, if ``l`` does not expect an argument. However,
- * the whole list of arguments would be parsed if ``l`` expects an argument.
+ * @gs: State, initialised with getopt_init_state()
+ * @optstring: Option specification (see getopt(3))
  *
- * An example invocation of getopt() might look like::
+ * Parses the next short option from @gs. By default, getopt() permutes
+ * the working argv: when it hits a non-option, it bubbles that argv
+ * element to the end and keeps scanning, so options can appear
+ * anywhere on the command line. After parsing finishes (returns -1),
+ * @gs.index sits at the first parked non-option, and there are
+ * @gs.nonopts of them at @gs.args[gs.index..argc-1].
  *
- *     char *argv[] = { "program", "-cbx", "-a", "foo", "bar", 0 };
- *     int opt, argc = ARRAY_SIZE(argv) - 1;
- *     struct getopt_state gs;
+ * If @optstring begins with ``+``, getopt() instead stops at the
+ * first non-option (POSIX ``getopt`` behaviour). Use this when the
+ * command's grammar requires options before positionals, or when the
+ * option string includes optional arguments (``::``) whose adjacency
+ * to a following positional would be ambiguous under permutation.
  *
- *     getopt_init_state(&gs);
- *     while ((opt = getopt(&gs, argc, argv, "a::b:c")) != -1)
- *         printf("opt = %c, index = %d, arg = \"%s\"\n", opt, gs.index, gs.arg);
- *     printf("%d argument(s) left\n", argc - gs.index);
+ * In @optstring proper, ``x`` is a flag, ``x:`` requires an argument,
+ * and ``x::`` takes an optional argument. The argument is delivered
+ * in @gs.arg.
  *
- * and would produce an output of::
- *
- *     opt = c, index = 1, arg = "<NULL>"
- *     opt = b, index = 2, arg = "x"
- *     opt = a, index = 4, arg = "foo"
- *     1 argument(s) left
- *
- * For further information, refer to the getopt(3) man page.
+ * A literal ``--`` argument terminates option scanning; the parser
+ * advances past it and returns -1.
  *
  * Return:
- * * An option character if an option is found. @gs.arg is set to the
- *   argument if there is one, otherwise it is set to ``NULL``.
- * * ``-1`` if there are no more options, if a non-option argument is
- *   encountered, or if an ``--`` argument is encountered.
- * * ``'?'`` if we encounter an option not in @optstring. @gs.opt is set to
- *   the unknown option.
- * * ``':'`` if an argument is required, but no argument follows the
- *   option. @gs.opt is set to the option missing its argument.
- *
- * @gs.index is always set to the index of the next unparsed argument in @argv.
+ * * An option character if an option is found. @gs.arg is set to
+ *   the argument if there is one, otherwise NULL.
+ * * ``-1`` if there are no more options.
+ * * ``'?'`` for an option not in @optstring; @gs.opt is the unknown
+ *   option character.
+ * * ``':'`` for an option missing its required argument; @gs.opt is
+ *   the option character.
  */
-static inline int getopt(struct getopt_state *gs, int argc,
-			 char *const argv[], const char *optstring)
+static inline int getopt(struct getopt_state *gs, const char *optstring)
 {
-	return __getopt(gs, argc, argv, optstring, false);
+	return __getopt(gs, optstring, false);
 }
 
 /**
- * getopt_silent() - Parse short command-line options silently
+ * getopt_silent() - Parse short command-line options without errors
  * @gs: State
- * @argc: Argument count
- * @argv: Argument list
  * @optstring: Option specification
  *
- * Same as getopt(), except no error messages are printed.
+ * Same as getopt() but does not print error messages for unknown
+ * options or missing arguments.
  */
-static inline int getopt_silent(struct getopt_state *gs, int argc,
-				char *const argv[], const char *optstring)
+static inline int getopt_silent(struct getopt_state *gs,
+				const char *optstring)
 {
-	return __getopt(gs, argc, argv, optstring, true);
+	return __getopt(gs, optstring, true);
 }
 
 #endif /* __GETOPT_H */
diff --git a/lib/getopt.c b/lib/getopt.c
index e9175e2fff4..70adb2d0faf 100644
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
+	int max = ARRAY_SIZE(gs->args) - 1;
+
+	if (argc > max)
+		argc = max;
+
+	gs->argc = argc;
+	memcpy(gs->args, argv, (argc + 1) * sizeof(*gs->args));
+	gs->args[argc] = NULL;
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
+	char **argv = gs->args;
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
+		 * Bubble non-options to the end so we can keep scanning for
+		 * options past them. In '+' mode (POSIX), stop at the first
+		 * non-option instead.
+		 */
+		while (gs->arg_index == 1 &&
+		       gs->index + gs->nonopts < argc &&
+		       *argv[gs->index] != '-') {
+			char *tmp;
+			int i;
+
+			if (stop_nonopt)
+				return -1;
+
+			tmp = argv[gs->index];
+			gs->nonopts++;
+			for (i = gs->index; i + 1 < argc; i++)
+				argv[i] = argv[i + 1];
+			argv[argc - 1] = tmp;
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
index 388a076200b..6b384eb016a 100644
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
-- 
2.43.0

