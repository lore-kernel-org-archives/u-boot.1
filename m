Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBA0E7C4E8
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 350E3875E8;
	Wed,  4 Oct 2023 18:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UPVxRXXd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93CD8875CF; Wed,  4 Oct 2023 18:43:26 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDA37875B7
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52fe27898e9so4505699a12.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437789; x=1697042589;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJQWHp8wRve10qEbqVcNdyurAuWRqeCxfLgrKM46+xQ=;
 b=UPVxRXXdiwZxJwPsSUsKGt2ZHk/snJss1H5+I1S2+SQngNXueuCJU1c0oAbXtKD4oV
 Mcr7rT6t/jM9YcW583um6vQchlcUM0VJo91D1Q8kjQ+UJAH7P5JCOqOv/AY10oMiTCET
 GkvCYP/Kf8RGqY+RgxJKwzAaCjKqmq4caMSog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437789; x=1697042589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJQWHp8wRve10qEbqVcNdyurAuWRqeCxfLgrKM46+xQ=;
 b=ij6dRMqwgESsINZA5FmEBRsqeUvR3f+QM7gJDttLsYGQ+v0DGp7ghN+6njNxj6HruE
 OaBDDP+95jpOcDcm166VDqAQlpEKkTfadesIvv+85kM2uLgGf7HrXSrVgwZg2AZhDVo8
 4NdIZPNxAEU/Geq9zCJ/KlOad6YGY8EmKcU/kZ/fdAe/M73mDJpy8M7Ax8gchTca02eC
 4/eM1HeZ8yzQL3qzM08bzwt7ObUWFK2d3Nn3hxEGMEhJN4rBaVfqyY1kMk/R05jkXrh8
 nRz/0xJGGaWCcFhEIjUu7ccYSyG4+5ovUZuAU51aFUI7nWjS8LYD0xm8UelFdbvAAiqX
 zZfg==
X-Gm-Message-State: AOJu0YyFC4h0c5/fe4ls8gI8WSNkc1Los5Y8FO5yNy8BEOzlDljabymR
 n+VAhXJxOpysolxEH0QPYSWPkNHMy6cxYAYlxoQ=
X-Google-Smtp-Source: AGHT+IFNVeGorumhbBmFuEGjSpUqxdT74e3QFYC4nyM/dTx3EKPUZm+vcnPs2gt8XQ4f2chJ+lXEDA==
X-Received: by 2002:aa7:c245:0:b0:522:2111:1063 with SMTP id
 y5-20020aa7c245000000b0052221111063mr2502327edo.18.1696437789479; 
 Wed, 04 Oct 2023 09:43:09 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:43:09 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Roger Knecht <rknecht@pm.me>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Hector Palacios <hector.palacios@digi.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC PATCH v10 11/24] cmd: Add new cli command
Date: Wed,  4 Oct 2023 19:42:07 +0300
Message-Id: <20231004164220.15738-12-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
References: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
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

This command can be used to print the current parser with 'cli print'.
It can also be used to set the current parser with 'cli set'.
For the moment, only one value is valid for set: old.

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 cmd/Makefile          |   2 +
 cmd/cli.c             | 120 ++++++++++++++++++++++++++++++++++++++++++
 common/cli.c          |   3 +-
 doc/usage/cmd/cli.rst |  59 +++++++++++++++++++++
 doc/usage/index.rst   |   1 +
 5 files changed, 184 insertions(+), 1 deletion(-)
 create mode 100644 cmd/cli.c
 create mode 100644 doc/usage/cmd/cli.rst

diff --git a/cmd/Makefile b/cmd/Makefile
index 9bebf321c3..d468cc5065 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -226,6 +226,8 @@ obj-$(CONFIG_CMD_AVB) += avb.o
 # Foundries.IO SCP03
 obj-$(CONFIG_CMD_SCP03) += scp03.o
 
+obj-$(CONFIG_HUSH_PARSER) += cli.o
+
 obj-$(CONFIG_ARM) += arm/
 obj-$(CONFIG_RISCV) += riscv/
 obj-$(CONFIG_SANDBOX) += sandbox/
diff --git a/cmd/cli.c b/cmd/cli.c
new file mode 100644
index 0000000000..7671785b83
--- /dev/null
+++ b/cmd/cli.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <common.h>
+#include <cli.h>
+#include <command.h>
+#include <string.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static const char *gd_flags_to_parser(void)
+{
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER)
+		return "old";
+	return NULL;
+}
+
+static int do_cli_get(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
+{
+	const char *current = gd_flags_to_parser();
+
+	if (!current) {
+		printf("current cli value is not valid, this should not happen!\n");
+		return CMD_RET_FAILURE;
+	}
+
+	printf("%s\n", current);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int parser_string_to_gd_flags(const char *parser)
+{
+	if (!strcmp(parser, "old"))
+		return GD_FLG_HUSH_OLD_PARSER;
+	return -1;
+}
+
+static void reset_parser_gd_flags(void)
+{
+	gd->flags &= ~GD_FLG_HUSH_OLD_PARSER;
+}
+
+static int do_cli_set(struct cmd_tbl *cmdtp, int flag, int argc,
+		      char *const argv[])
+{
+	char *parser_name;
+	int parser_flag;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	parser_name = argv[1];
+
+	parser_flag = parser_string_to_gd_flags(parser_name);
+	if (parser_flag == -1) {
+		printf("Bad value for parser name: %s\n", parser_name);
+		return CMD_RET_USAGE;
+	}
+
+	if (parser_flag == GD_FLG_HUSH_OLD_PARSER &&
+		!CONFIG_IS_ENABLED(HUSH_OLD_PARSER)) {
+		printf("Want to set current parser to old, but its code was not compiled!\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (parser_flag == GD_FLG_HUSH_2021_PARSER &&
+		!CONFIG_IS_ENABLED(HUSH_2021_PARSER)) {
+		printf("Want to set current parser to 2021, but its code was not compiled!\n");
+		return CMD_RET_FAILURE;
+	}
+
+	reset_parser_gd_flags();
+	gd->flags |= parser_flag;
+
+	cli_init();
+	cli_loop();
+
+	/* cli_loop() should never return. */
+	return CMD_RET_FAILURE;
+}
+
+static struct cmd_tbl parser_sub[] = {
+	U_BOOT_CMD_MKENT(get, 1, 1, do_cli_get, "", ""),
+	U_BOOT_CMD_MKENT(set, 2, 1, do_cli_set, "", ""),
+};
+
+static int do_cli(struct cmd_tbl *cmdtp, int flag, int argc,
+		  char *const argv[])
+{
+	struct cmd_tbl *cp;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	/* drop initial "parser" arg */
+	argc--;
+	argv++;
+
+	cp = find_cmd_tbl(argv[0], parser_sub, ARRAY_SIZE(parser_sub));
+	if (cp)
+		return cp->cmd(cmdtp, flag, argc, argv);
+
+	return CMD_RET_USAGE;
+}
+
+#if CONFIG_IS_ENABLED(SYS_LONGHELP)
+static char cli_help_text[] =
+	"get - print current cli\n"
+	"set - set the current cli, possible value is: old"
+	;
+#endif
+
+U_BOOT_CMD(cli, 3, 1, do_cli,
+	   "cli",
+#if CONFIG_IS_ENABLED(SYS_LONGHELP)
+	   cli_help_text
+#endif
+);
diff --git a/common/cli.c b/common/cli.c
index e5fe1060d0..d419671e8c 100644
--- a/common/cli.c
+++ b/common/cli.c
@@ -268,7 +268,8 @@ void cli_loop(void)
 void cli_init(void)
 {
 #ifdef CONFIG_HUSH_PARSER
-	if (!(gd->flags & GD_FLG_HUSH_OLD_PARSER))
+	if (!(gd->flags & GD_FLG_HUSH_OLD_PARSER)
+		&& CONFIG_IS_ENABLED(HUSH_OLD_PARSER))
 		gd->flags |= GD_FLG_HUSH_OLD_PARSER;
 	u_boot_hush_start();
 #endif
diff --git a/doc/usage/cmd/cli.rst b/doc/usage/cmd/cli.rst
new file mode 100644
index 0000000000..89ece3203d
--- /dev/null
+++ b/doc/usage/cmd/cli.rst
@@ -0,0 +1,59 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+cli command
+===========
+
+Synopis
+-------
+
+::
+
+    cli get
+    cli set cli_flavor
+
+Description
+-----------
+
+The cli command permits getting and changing the current parser at runtime.
+
+cli get
+~~~~~~~
+
+It shows the current value of the parser used by the CLI.
+
+cli set
+~~~~~~~
+
+It permits setting the value of the parser used by the CLI.
+
+Possible values are old and 2021.
+Note that, to use a specific parser its code should have been compiled, that
+is to say you need to enable the corresponding CONFIG_HUSH*.
+Otherwise, an error message is printed.
+
+Examples
+--------
+
+Get the current parser::
+
+    => cli get
+    old
+
+Change the current parser::
+
+    => cli set old
+
+Trying to set the current parser to an unknown value::
+
+    => cli set foo
+    Bad value for parser name: foo
+    cli - cli
+
+    Usage:
+    cli get - print current cli
+    set - set the current cli, possible value is: old
+
+Return value
+------------
+
+The return value $? indicates whether the command succeeded.
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index fa702920fa..90a38c5713 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -42,6 +42,7 @@ Shell commands
    cmd/cat
    cmd/cbsysinfo
    cmd/cedit
+   cmd/cli
    cmd/cls
    cmd/cmp
    cmd/coninfo
-- 
2.34.1

