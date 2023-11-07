Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A392EC4167D
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 22:58:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A30687692;
	Tue,  7 Nov 2023 23:58:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="B+OXSN2q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 559338767B; Tue,  7 Nov 2023 22:42:26 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F044487672
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4084de32db5so52994365e9.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393332; x=1699998132;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6dkpQ8pDDIwPZaI6DGKQvs3N0sVwBMmNFDkuz83mfE=;
 b=B+OXSN2qgui/hcoGNLC7QOY/Oph+CUDBXRhWz+60+ThKHncv3tiKO2eh4MBI1jjpeo
 iSqOHJtlmegpYjj15t7S76LWCx+xTJ/Fi2QSnfc2Iry0G7mQtiM+lJcvd+yRCS0K/2pp
 s8EouXNSd/C1K3TNCJ9OyOFWxRZO/ssgL3Tgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393332; x=1699998132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b6dkpQ8pDDIwPZaI6DGKQvs3N0sVwBMmNFDkuz83mfE=;
 b=QdUys0ka1m7VlP4OrAesjRcLuJlkFFOTrXXfNwRawpSdKCCMv0Rf97uehHttUFWCUf
 vWQogusGrHY60ezXBkf8PKmOJ9xEKflI0/kaSWV5WCgDw0jAapeTvazFoz4kGVJW6oHd
 XslDYznS3F+O2yEyENbqFgI4YZI3ZJYBe6p4X0Rzs3nRzcxP/qwSG2v3mpw+C07k+6Cv
 VIF0C40A23K3WqQkr4uIOkeebxW2DWY3sAmBSktgiadfrbb4+VCNmD1HhJUuJdut3rlj
 bwVr/TDgkrx/u4sWabhhQ0o5iypv3Tb7aBMggup1zPr5ZV8IBDsAr6oSCG52O8MmtpBR
 WzFQ==
X-Gm-Message-State: AOJu0YyGTOvfh7Jwov5HzvQBN+y2yW9TNxvTW5iBHjw77qbWnUNGSLtj
 1GxFgdu82LN/YN5aqqta7+3i2yaHNoNaSowxsVw=
X-Google-Smtp-Source: AGHT+IEJLA+NHOqpnENWW6iIycVr1EC/FcyYxR+5QEZXhKHcRszD0bn89nxj/Uk570l5r14RSnavdw==
X-Received: by 2002:adf:d1e1:0:b0:32d:a98c:aa1f with SMTP id
 g1-20020adfd1e1000000b0032da98caa1fmr7722wrd.1.1699393332405; 
 Tue, 07 Nov 2023 13:42:12 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:42:12 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ramon Fried <rfried.dev@gmail.com>,
 Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Michael Walle <michael@walle.cc>, John Keeping <john@metanate.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Marek Vasut <marex@denx.de>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Hector Palacios <hector.palacios@digi.com>, Stefan Roese <sr@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: [PATCH v11 12/24] cli: Enables using hush 2021 parser as command line
 parser
Date: Tue,  7 Nov 2023 23:41:09 +0200
Message-Id: <20231107214121.132079-13-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 07 Nov 2023 23:58:28 +0100
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

If one defines HUSH_2021_PARSER, it is then possible to use 2021 parser with:
=> cli get
old
=> cli set 2021
=> cli get
2021

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 cmd/Kconfig                       | 12 ++++++++
 cmd/Makefile                      |  2 +-
 cmd/cli.c                         | 28 ++++++++++++++---
 common/Makefile                   |  1 +
 common/cli.c                      | 38 +++++++++++++++++++----
 common/cli_hush_2021.c            |  3 ++
 common/cli_hush_upstream.c        | 46 +++++++++++++++++++++++++---
 doc/usage/cmd/cli.rst             | 17 ++++++++++-
 include/asm-generic/global_data.h |  4 +++
 include/cli_hush.h                | 51 +++++++++++++++++++++++++++++--
 10 files changed, 183 insertions(+), 19 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index f3a00ee59b..4641333809 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -34,6 +34,18 @@ menu "Hush flavor to use"
 		  2005.
 
 		  It is actually the default U-Boot shell when decided to use hush as shell.
+
+	config HUSH_2021_PARSER
+		bool "Use hush 2021 parser"
+		help
+		  This option enables the new flavor of hush based on hush Busybox from
+		  2021.
+
+		  This parser is experimental and not well tested.
+
+	config HUSH_SELECTABLE
+		bool
+		default y if HUSH_OLD_PARSER && HUSH_2021_PARSER
 endmenu
 
 config CMDLINE_EDITING
diff --git a/cmd/Makefile b/cmd/Makefile
index 620f69c1c5..e260c81405 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -227,7 +227,7 @@ obj-$(CONFIG_CMD_AVB) += avb.o
 # Foundries.IO SCP03
 obj-$(CONFIG_CMD_SCP03) += scp03.o
 
-obj-$(CONFIG_HUSH_PARSER) += cli.o
+obj-$(CONFIG_HUSH_SELECTABLE) += cli.o
 
 obj-$(CONFIG_ARM) += arm/
 obj-$(CONFIG_RISCV) += riscv/
diff --git a/cmd/cli.c b/cmd/cli.c
index 86c6471aa4..7da196186a 100644
--- a/cmd/cli.c
+++ b/cmd/cli.c
@@ -12,6 +12,8 @@ static const char *gd_flags_to_parser_name(void)
 {
 	if (gd->flags & GD_FLG_HUSH_OLD_PARSER)
 		return "old";
+	if (gd->flags & GD_FLG_HUSH_2021_PARSER)
+		return "2021";
 	return NULL;
 }
 
@@ -34,18 +36,31 @@ static int parser_string_to_gd_flags(const char *parser)
 {
 	if (!strcmp(parser, "old"))
 		return GD_FLG_HUSH_OLD_PARSER;
+	if (!strcmp(parser, "2021"))
+		return GD_FLG_HUSH_2021_PARSER;
+	return -1;
+}
+
+static int gd_flags_to_parser_config(int flag)
+{
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER)
+		return CONFIG_VAL(HUSH_OLD_PARSER);
+	if (gd->flags & GD_FLG_HUSH_2021_PARSER)
+		return CONFIG_VAL(HUSH_2021_PARSER);
 	return -1;
 }
 
 static void reset_parser_gd_flags(void)
 {
 	gd->flags &= ~GD_FLG_HUSH_OLD_PARSER;
+	gd->flags &= ~GD_FLG_HUSH_2021_PARSER;
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
+	"set - set the current cli, possible value are: old, 2021"
 	;
 #endif
 
diff --git a/common/Makefile b/common/Makefile
index 23851a68e2..b487421133 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -9,6 +9,7 @@ obj-y += init/
 obj-y += main.o
 obj-y += exports.o
 obj-$(CONFIG_HUSH_OLD_PARSER) += cli_hush.o
+obj-$(CONFIG_HUSH_2021_PARSER) += cli_hush_2021.o
 obj-$(CONFIG_AUTOBOOT) += autoboot.o
 
 # # boards
diff --git a/common/cli.c b/common/cli.c
index d419671e8c..e3e2bc7fe1 100644
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
+#else /* HUSH_2021_PARSER */
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
+#else /* HUSH_2021_PARSER */
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
+	if (gd->flags & GD_FLG_HUSH_2021_PARSER)
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
+		&& !(gd->flags & GD_FLG_HUSH_2021_PARSER)) {
+		if (CONFIG_IS_ENABLED(HUSH_OLD_PARSER))
+			gd->flags |= GD_FLG_HUSH_OLD_PARSER;
+		else if (CONFIG_IS_ENABLED(HUSH_2021_PARSER))
+			gd->flags |= GD_FLG_HUSH_2021_PARSER;
+	}
+
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		u_boot_hush_start();
+	} else if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
+		u_boot_hush_start_2021();
+	} else {
+		printf("No valid hush parser to use, cli will not initialized!\n");
+		return;
+	}
 #endif
 
 #if defined(CONFIG_HUSH_INIT_VAR)
diff --git a/common/cli_hush_2021.c b/common/cli_hush_2021.c
index 6d109933b8..653ea52929 100644
--- a/common/cli_hush_2021.c
+++ b/common/cli_hush_2021.c
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
index cc64af4e0c..84227a248e 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -7914,7 +7914,17 @@ static void parse_and_run_stream(struct in_str *inp, int end_trigger)
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
@@ -10369,13 +10379,39 @@ static int run_list(struct pipe *pi)
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
index 89ece3203d..bc600bf9e9 100644
--- a/doc/usage/cmd/cli.rst
+++ b/doc/usage/cmd/cli.rst
@@ -41,7 +41,14 @@ Get the current parser::
 
 Change the current parser::
 
+    => cli get
+    old
+    => cli set 2021
+    => cli get
+    2021
     => cli set old
+    => cli get
+    old
 
 Trying to set the current parser to an unknown value::
 
@@ -51,7 +58,15 @@ Trying to set the current parser to an unknown value::
 
     Usage:
     cli get - print current cli
-    set - set the current cli, possible value is: old
+    set - set the current cli, possible values are: old, 2021
+
+Trying to set the current parser to a correct value but its code was not
+compiled::
+
+    => cli get
+    2021
+    => cli set old
+    Want to set current parser to old, but its code was not compiled!
 
 Return value
 ------------
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 0a9b6bd92a..b9fbcfb8eb 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -701,6 +701,10 @@ enum gd_flags {
 	 * @GD_FLG_HUSH_OLD_PARSER: Use hush old parser.
 	 */
 	GD_FLG_HUSH_OLD_PARSER = 0x1000000,
+	/**
+	 * @GD_FLG_HUSH_2021_PARSER: Use hush 2021 parser.
+	 */
+	GD_FLG_HUSH_2021_PARSER = 0x2000000,
 };
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/cli_hush.h b/include/cli_hush.h
index 2bd35670c7..4ef79de53c 100644
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
+#if CONFIG_IS_ENABLED(HUSH_2021_PARSER)
+extern int u_boot_hush_start_2021(void);
+extern int parse_string_outer_2021(const char *str, int flag);
+extern void parse_and_run_file(void);
+int set_local_var_2021(char *s, int flg_export);
+#else
+static inline int u_boot_hush_start_2021(void)
+{
+	return 0;
+}
+
+static inline int parse_string_outer_2021(const char *str, int flag)
+{
+	return 1;
+}
+
+static inline void parse_and_run_file(void)
+{
+}
+
+static inline int set_local_var_2021(char *s, int flg_export)
+{
+	return 0;
+}
+#endif
+
 void unset_local_var(const char *name);
 char *get_local_var(const char *s);
 
-- 
2.34.1

