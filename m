Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA0BC4706F
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EB25877FA;
	Fri, 22 Dec 2023 22:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Tp3fCt+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 109BF8772E; Fri, 22 Dec 2023 22:03:36 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAACB87800
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c2bb872e2so22562735e9.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703279003; x=1703883803;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/bX9fFyt7wHseJxt7Q9triclWjAXHgcHNbyCGt+kC4=;
 b=Tp3fCt+ohK9OjQp+wp4HIfwvw7X/4BQTjHDYwmuuMuoc8PkWePfol5rTTejeYoY+Na
 IzXw/8mGcTd1V4PGJi7FfspNK0fpsRn1Ut1WarbFOp6ZLr2X98bw/KjOke+6RWaKqcXL
 TJqUB/xJnsPUsKizCxQnnHdDpRykJnJRU1eKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703279003; x=1703883803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y/bX9fFyt7wHseJxt7Q9triclWjAXHgcHNbyCGt+kC4=;
 b=I3sCzJcHbRlLOaRpawGQy98k52v9IviknyBt1lHIEQXD6jZW6vB3e3Eg0q2fd4qGsl
 j7VYNMTioY5xR5RF5vhfoL6YkgQzUFOQnM31WUV75KZ96aEi0EHXXz8dQxHKct0wF1Sv
 9g2hhxUkMumg6BQgkSHe0/nAovJ2OmCoOCpz8MYcAwwuXXdrY1yQSG2tFiZPICN/e9D2
 TqvHbMcNEhmH4IsZ2FUQ219MOZpHwrOPB7nQxoNjMxdR6Dbgy/NA/MQohjLct8oytbaY
 GiysE4JoIeEPVLF5AiKFETbsHhewQf5L1tX73/kULD4PTqKGcFEtEZPtlPndXMTna4xm
 bP/w==
X-Gm-Message-State: AOJu0YzdGLxE3ln2JzJdezIwQ+Pv8QbhLgebDcksLByax7ehlsbVmQI/
 qxMl742hTgLKU7F3HvjYoXkoSuHCK3tXCgJ/EgWrYDcvP/I=
X-Google-Smtp-Source: AGHT+IF+AXGuGHXXxdOxQAz2tTxLJBx1E9AxB5wm/Q5kQ6wgc13cQ5IKjPAGVlYz/m2QUVGyuxuMGg==
X-Received: by 2002:a05:600c:4ecb:b0:40d:15fe:68ff with SMTP id
 g11-20020a05600c4ecb00b0040d15fe68ffmr554693wmq.107.1703279003482; 
 Fri, 22 Dec 2023 13:03:23 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:23 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Hector Palacios <hector.palacios@digi.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v13 11/24] cmd: Add new cli command
Date: Fri, 22 Dec 2023 22:02:31 +0100
Message-Id: <20231222210244.91830-12-francis.laniel@amarulasolutions.com>
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

This command can be used to print the current parser with 'cli get'.
It can also be used to set the current parser with 'cli set'.
For the moment, only one value is valid for set: old.

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 cmd/Makefile          |   2 +
 cmd/cli.c             | 114 ++++++++++++++++++++++++++++++++++++++++++
 common/cli.c          |   3 +-
 doc/usage/cmd/cli.rst |  59 ++++++++++++++++++++++
 doc/usage/index.rst   |   1 +
 5 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 cmd/cli.c
 create mode 100644 doc/usage/cmd/cli.rst

diff --git a/cmd/Makefile b/cmd/Makefile
index 5ed0e4011d..477b86cf23 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -229,6 +229,8 @@ obj-$(CONFIG_CMD_AVB) += avb.o
 # Foundries.IO SCP03
 obj-$(CONFIG_CMD_SCP03) += scp03.o
 
+obj-$(CONFIG_HUSH_PARSER) += cli.o
+
 obj-$(CONFIG_ARM) += arm/
 obj-$(CONFIG_RISCV) += riscv/
 obj-$(CONFIG_SANDBOX) += sandbox/
diff --git a/cmd/cli.c b/cmd/cli.c
new file mode 100644
index 0000000000..86c6471aa4
--- /dev/null
+++ b/cmd/cli.c
@@ -0,0 +1,114 @@
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
+static const char *gd_flags_to_parser_name(void)
+{
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER)
+		return "old";
+	return NULL;
+}
+
+static int do_cli_get(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
+{
+	const char *current = gd_flags_to_parser_name();
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
index 1a626c03c2..c171c029b8 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -43,6 +43,7 @@ Shell commands
    cmd/cat
    cmd/cbsysinfo
    cmd/cedit
+   cmd/cli
    cmd/cls
    cmd/cmp
    cmd/coninfo
-- 
2.34.1

