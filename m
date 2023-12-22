Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22C9C47072
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:05:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF212877BA;
	Fri, 22 Dec 2023 22:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cr6Kx8aC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB5BA8783D; Fri, 22 Dec 2023 22:03:38 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9F9787830
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40d3352b525so21740885e9.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703279007; x=1703883807;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgi4RIHNVbOhpM7Dp9bFz0bQZcVcVSIu23wBCcA8DBs=;
 b=cr6Kx8aCmtIvkp5wuwMKbVUjjrbBg889xFYOEQ+BN9VH1R5cvN3y5A/DVNOpD1Q0JZ
 Wc6sCr0eKtTPPbsO+ZplumxGyUtTU0/XV9YCkBCwjEmOIIjeiEJBdMzjvX779gc67W9a
 3jad6fxRW1T7dqd+MEanCsnggGU4D1wD3PB6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703279007; x=1703883807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgi4RIHNVbOhpM7Dp9bFz0bQZcVcVSIu23wBCcA8DBs=;
 b=NtBuRppfJ32ENGzhm6S62uYxRphGPjLuAlieUox82gtfWfVU6i0dOL6+u/KFJN9dNi
 FD31rq0zek6bMcyDmdcfJzudvFtj0xKp8quX5tvou0ngISSVCwksRyiNFUC8FIvhfEyk
 hSi7iwKT+z0ffmU733rWJF7XOkD2+0eQOm6PwXkHjvsTB9aug65deddmIr6i2LFYEQ21
 t5XM1nr3uS+1KfQKyB3Xmge0M+aeI5FN/IpUKmRi0ensFhI1wX/VnwGh0LIkmUVkV9B+
 aRVC3RfucDz//0qfRseciBsj925Znr0lc0Tvbo9wzETCIIsgGfXiEjOVqwF+5zcL6gNN
 CMfQ==
X-Gm-Message-State: AOJu0YzTmaJL9CXoYQ+Gr2bWez0R9s0pnqDTnOyjp1C1BPKSeL9MupuK
 YP7inI5OX66BuonP1TRr8wMSNcD5m4GWesZkFO52+U4i80M=
X-Google-Smtp-Source: AGHT+IGSVGhfh50xzaYGAmcK/lCBgf6atq54J0aKVY9pot2QgG4ERTnyhDSPzMS7aTQf6EMrT6vuuA==
X-Received: by 2002:a05:600c:a49:b0:40d:35a5:b9dd with SMTP id
 c9-20020a05600c0a4900b0040d35a5b9ddmr1083034wmq.22.1703279007335; 
 Fri, 22 Dec 2023 13:03:27 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:27 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Edmond <seanedmond@microsoft.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Roger Knecht <rknecht@pm.me>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Hector Palacios <hector.palacios@digi.com>, Marek Vasut <marex@denx.de>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v13 12/24] cli: Enables using modern hush parser as command
 line parser
Date: Fri, 22 Dec 2023 22:02:32 +0100
Message-Id: <20231222210244.91830-13-francis.laniel@amarulasolutions.com>
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

If one defines HUSH_MODERN_PARSER, it is then possible to use modern parser with:
=> cli get
old
=> cli set modern
=> cli get
modern

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 cmd/Kconfig                       | 12 ++++++++
 cmd/Makefile                      |  2 +-
 cmd/cli.c                         | 28 ++++++++++++++---
 common/Makefile                   |  1 +
 common/cli.c                      | 38 +++++++++++++++++++----
 common/cli_hush_modern.c          |  3 ++
 common/cli_hush_upstream.c        | 46 +++++++++++++++++++++++++---
 doc/usage/cmd/cli.rst             | 19 ++++++++++--
 include/asm-generic/global_data.h |  4 +++
 include/cli_hush.h                | 51 +++++++++++++++++++++++++++++--
 10 files changed, 184 insertions(+), 20 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 15715ac6ad..e25578cde3 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -33,6 +33,18 @@ config HUSH_OLD_PARSER
 	  2005.
 
 	  It is actually the default U-Boot shell when decided to use hush as shell.
+
+config HUSH_MODERN_PARSER
+	bool "Use hush modern parser"
+	help
+	  This option enables the new flavor of hush based on hush upstream
+	  Busybox.
+
+	  This parser is experimental and not well tested.
+
+config HUSH_SELECTABLE
+	bool
+	default y if HUSH_OLD_PARSER && HUSH_MODERN_PARSER
 endmenu
 
 config CMDLINE_EDITING
diff --git a/cmd/Makefile b/cmd/Makefile
index 477b86cf23..e2a2b16ab2 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -229,7 +229,7 @@ obj-$(CONFIG_CMD_AVB) += avb.o
 # Foundries.IO SCP03
 obj-$(CONFIG_CMD_SCP03) += scp03.o
 
-obj-$(CONFIG_HUSH_PARSER) += cli.o
+obj-$(CONFIG_HUSH_SELECTABLE) += cli.o
 
 obj-$(CONFIG_ARM) += arm/
 obj-$(CONFIG_RISCV) += riscv/
diff --git a/cmd/cli.c b/cmd/cli.c
index 86c6471aa4..b93cc952ed 100644
--- a/cmd/cli.c
+++ b/cmd/cli.c
@@ -12,6 +12,8 @@ static const char *gd_flags_to_parser_name(void)
 {
 	if (gd->flags & GD_FLG_HUSH_OLD_PARSER)
 		return "old";
+	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER)
+		return "modern";
 	return NULL;
 }
 
@@ -34,18 +36,31 @@ static int parser_string_to_gd_flags(const char *parser)
 {
 	if (!strcmp(parser, "old"))
 		return GD_FLG_HUSH_OLD_PARSER;
+	if (!strcmp(parser, "modern"))
+		return GD_FLG_HUSH_MODERN_PARSER;
+	return -1;
+}
+
+static int gd_flags_to_parser_config(int flag)
+{
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER)
+		return CONFIG_VAL(HUSH_OLD_PARSER);
+	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER)
+		return CONFIG_VAL(HUSH_MODERN_PARSER);
 	return -1;
 }
 
 static void reset_parser_gd_flags(void)
 {
 	gd->flags &= ~GD_FLG_HUSH_OLD_PARSER;
+	gd->flags &= ~GD_FLG_HUSH_MODERN_PARSER;
 }
 
 static int do_cli_set(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
 	char *parser_name;
+	int parser_config;
 	int parser_flag;
 
 	if (argc < 2)
@@ -59,9 +74,14 @@ static int do_cli_set(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_USAGE;
 	}
 
-	if (parser_flag == GD_FLG_HUSH_OLD_PARSER &&
-		!CONFIG_IS_ENABLED(HUSH_OLD_PARSER)) {
-		printf("Want to set current parser to old, but its code was not compiled!\n");
+	parser_config = gd_flags_to_parser_config(parser_flag);
+	switch (parser_config) {
+	case -1:
+		printf("Bad value for parser flags: %d\n", parser_flag);
+		return CMD_RET_FAILURE;
+	case 0:
+		printf("Want to set current parser to %s, but its code was not compiled!\n",
+			parser_name);
 		return CMD_RET_FAILURE;
 	}
 
@@ -102,7 +122,7 @@ static int do_cli(struct cmd_tbl *cmdtp, int flag, int argc,
 #if CONFIG_IS_ENABLED(SYS_LONGHELP)
 static char cli_help_text[] =
 	"get - print current cli\n"
-	"set - set the current cli, possible value is: old"
+	"set - set the current cli, possible value are: old, modern"
 	;
 #endif
 
diff --git a/common/Makefile b/common/Makefile
index 3bb33b4e36..f010c2a1b9 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -10,6 +10,7 @@ obj-y += main.o
 obj-y += exports.o
 obj-y += cli_getch.o cli_simple.o cli_readline.o
 obj-$(CONFIG_HUSH_OLD_PARSER) += cli_hush.o
+obj-$(CONFIG_HUSH_MODERN_PARSER) += cli_hush_modern.o
 obj-$(CONFIG_AUTOBOOT) += autoboot.o
 obj-y += version.o
 
diff --git a/common/cli.c b/common/cli.c
index d419671e8c..b3eb512b62 100644
--- a/common/cli.c
+++ b/common/cli.c
@@ -43,12 +43,15 @@ int run_command(const char *cmd, int flag)
 		return 1;
 
 	return 0;
-#else
+#elif CONFIG_IS_ENABLED(HUSH_OLD_PARSER)
 	int hush_flags = FLAG_PARSE_SEMICOLON | FLAG_EXIT_FROM_LOOP;
 
 	if (flag & CMD_FLAG_ENV)
 		hush_flags |= FLAG_CONT_ON_NEWLINE;
 	return parse_string_outer(cmd, hush_flags);
+#else /* HUSH_MODERN_PARSER */
+	/* Not yet implemented. */
+	return 1;
 #endif
 }
 
@@ -108,7 +111,12 @@ int run_command_list(const char *cmd, int len, int flag)
 		buff[len] = '\0';
 	}
 #ifdef CONFIG_HUSH_PARSER
+#if CONFIG_IS_ENABLED(HUSH_OLD_PARSER)
 	rcode = parse_string_outer(buff, FLAG_PARSE_SEMICOLON);
+#else /* HUSH_MODERN_PARSER */
+	/* Not yet implemented. */
+	rcode = 1;
+#endif
 #else
 	/*
 	 * This function will overwrite any \n it sees with a \0, which
@@ -254,8 +262,13 @@ err:
 void cli_loop(void)
 {
 	bootstage_mark(BOOTSTAGE_ID_ENTER_CLI_LOOP);
-#ifdef CONFIG_HUSH_PARSER
-	parse_file_outer();
+#if CONFIG_IS_ENABLED(HUSH_PARSER)
+	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER)
+		parse_and_run_file();
+	else if (gd->flags & GD_FLG_HUSH_OLD_PARSER)
+		parse_file_outer();
+
+	printf("Problem\n");
 	/* This point is never reached */
 	for (;;);
 #elif defined(CONFIG_CMDLINE)
@@ -268,10 +281,23 @@ void cli_loop(void)
 void cli_init(void)
 {
 #ifdef CONFIG_HUSH_PARSER
+	/* This if block is used to initialize hush parser gd flag. */
 	if (!(gd->flags & GD_FLG_HUSH_OLD_PARSER)
-		&& CONFIG_IS_ENABLED(HUSH_OLD_PARSER))
-		gd->flags |= GD_FLG_HUSH_OLD_PARSER;
-	u_boot_hush_start();
+		&& !(gd->flags & GD_FLG_HUSH_MODERN_PARSER)) {
+		if (CONFIG_IS_ENABLED(HUSH_OLD_PARSER))
+			gd->flags |= GD_FLG_HUSH_OLD_PARSER;
+		else if (CONFIG_IS_ENABLED(HUSH_MODERN_PARSER))
+			gd->flags |= GD_FLG_HUSH_MODERN_PARSER;
+	}
+
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		u_boot_hush_start();
+	} else if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
+		u_boot_hush_start_modern();
+	} else {
+		printf("No valid hush parser to use, cli will not initialized!\n");
+		return;
+	}
 #endif
 
 #if defined(CONFIG_HUSH_INIT_VAR)
diff --git a/common/cli_hush_modern.c b/common/cli_hush_modern.c
index 34278fdca2..626fed089b 100644
--- a/common/cli_hush_modern.c
+++ b/common/cli_hush_modern.c
@@ -221,6 +221,9 @@ static uint8_t xfunc_error_retval;
 static const char defifsvar[] __aligned(1) = "IFS= \t\n";
 #define defifs (defifsvar + 4)
 
+/* This define is used to check if exit command was called. */
+#define EXIT_RET_CODE -2
+
 /*
  * This define is used for changes that need be done directly in the upstream
  * sources still. Ideally, its use should be minimized as much as possible.
diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index 3f2e4a5495..4b6ab20f3b 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -7913,7 +7913,17 @@ static void parse_and_run_stream(struct in_str *inp, int end_trigger)
 		}
 		debug_print_tree(pipe_list, 0);
 		debug_printf_exec("parse_and_run_stream: run_and_free_list\n");
+#ifndef __U_BOOT__
 		run_and_free_list(pipe_list);
+#else /* __U_BOOT__ */
+		int rcode = run_and_free_list(pipe_list);
+		/*
+		 * We reset input string to not run the following command, so running
+		 * 'exit; echo foo' does not print foo.
+		 */
+		if (rcode <= EXIT_RET_CODE)
+			setup_file_in_str(inp);
+#endif /* __U_BOOT__ */
 		empty = 0;
 		if (G_flag_return_in_progress == 1)
 			break;
@@ -10368,13 +10378,39 @@ static int run_list(struct pipe *pi)
 #endif /* !__U_BOOT__ */
 		rcode = r = run_pipe(pi); /* NB: rcode is a smalluint, r is int */
 #ifdef __U_BOOT__
-		if (r == -2) {
-			/* -2 indicates exit was called, so we need to quit now. */
-			G.last_exitcode = rcode;
+		if (r <= EXIT_RET_CODE) {
+			int previous_rcode = G.last_exitcode;
+			/*
+			 * This magic is to get the exit code given by the user.
+			 * Contrary to old shell code, we use + EXIT_RET_CODE as EXIT_RET_CODE
+			 * equals -2.
+			 */
+			G.last_exitcode = -r + EXIT_RET_CODE;
 
-			break;
+			/*
+			 * This case deals with the following:
+			 * => setenv inner 'echo entry inner; exit; echo inner done'
+			 * => setenv outer 'echo entry outer; run inner; echo outer done'
+			 * => run outer
+			 * So, if we are in inner, we need to break and not run the other
+			 * commands.
+			 * Otherwise, we just continue in outer.
+			 * As return code are propagated, we use the previous value to check if
+			 * exit was just called or was propagated.
+			 */
+			if (previous_rcode != r) {
+				/*
+				 * If run from run_command, run_command_flags will be set, so we check
+				 * this to know if we are in main input shell.
+				 */
+				if (!G.run_command_flags)
+					printf("exit not allowed from main input shell.\n");
+
+				break;
+			}
+			continue;
 		}
-#endif
+#endif /* __U_BOOT__ */
 		if (r != -1) {
 			/* We ran a builtin, function, or group.
 			 * rcode is already known
diff --git a/doc/usage/cmd/cli.rst b/doc/usage/cmd/cli.rst
index 89ece3203d..a0cf5958fb 100644
--- a/doc/usage/cmd/cli.rst
+++ b/doc/usage/cmd/cli.rst
@@ -26,7 +26,7 @@ cli set
 
 It permits setting the value of the parser used by the CLI.
 
-Possible values are old and 2021.
+Possible values are old and modern.
 Note that, to use a specific parser its code should have been compiled, that
 is to say you need to enable the corresponding CONFIG_HUSH*.
 Otherwise, an error message is printed.
@@ -41,7 +41,14 @@ Get the current parser::
 
 Change the current parser::
 
+    => cli get
+    old
+    => cli set modern
+    => cli get
+    modern
     => cli set old
+    => cli get
+    old
 
 Trying to set the current parser to an unknown value::
 
@@ -51,7 +58,15 @@ Trying to set the current parser to an unknown value::
 
     Usage:
     cli get - print current cli
-    set - set the current cli, possible value is: old
+    set - set the current cli, possible values are: old, modern
+
+Trying to set the current parser to a correct value but its code was not
+compiled::
+
+    => cli get
+    modern
+    => cli set old
+    Want to set current parser to old, but its code was not compiled!
 
 Return value
 ------------
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 0a9b6bd92a..99bde9ec7e 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -701,6 +701,10 @@ enum gd_flags {
 	 * @GD_FLG_HUSH_OLD_PARSER: Use hush old parser.
 	 */
 	GD_FLG_HUSH_OLD_PARSER = 0x1000000,
+	/**
+	 * @GD_FLG_HUSH_MODERN_PARSER: Use hush 2021 parser.
+	 */
+	GD_FLG_HUSH_MODERN_PARSER = 0x2000000,
 };
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/cli_hush.h b/include/cli_hush.h
index 2bd35670c7..007b8d6372 100644
--- a/include/cli_hush.h
+++ b/include/cli_hush.h
@@ -12,11 +12,58 @@
 #define FLAG_REPARSING       (1 << 2)	  /* >=2nd pass */
 #define FLAG_CONT_ON_NEWLINE (1 << 3)	  /* continue when we see \n */
 
+#if CONFIG_IS_ENABLED(HUSH_OLD_PARSER)
 extern int u_boot_hush_start(void);
-extern int parse_string_outer(const char *, int);
+extern int parse_string_outer(const char *str, int flag);
 extern int parse_file_outer(void);
-
 int set_local_var(const char *s, int flg_export);
+#else
+static inline int u_boot_hush_start(void)
+{
+	return 0;
+}
+
+static inline int parse_string_outer(const char *str, int flag)
+{
+	return 1;
+}
+
+static inline int parse_file_outer(void)
+{
+	return 0;
+}
+
+static inline int set_local_var(const char *s, int flg_export)
+{
+	return 0;
+}
+#endif
+#if CONFIG_IS_ENABLED(HUSH_MODERN_PARSER)
+extern int u_boot_hush_start_modern(void);
+extern int parse_string_outer_modern(const char *str, int flag);
+extern void parse_and_run_file(void);
+int set_local_var_modern(char *s, int flg_export);
+#else
+static inline int u_boot_hush_start_modern(void)
+{
+	return 0;
+}
+
+static inline int parse_string_outer_modern(const char *str, int flag)
+{
+	return 1;
+}
+
+static inline void parse_and_run_file(void)
+{
+}
+
+static inline int set_local_var_modern(char *s, int flg_export)
+{
+	return 0;
+}
+#endif
+
 void unset_local_var(const char *name);
 char *get_local_var(const char *s);
 
-- 
2.34.1

