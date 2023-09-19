Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2914CE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A92D486BC0;
	Tue, 19 Sep 2023 20:09:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hevnYf9O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2DB786AEB; Tue, 19 Sep 2023 20:09:32 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F3CF86B7E
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-34fc96995ddso12456485ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146969; x=1695751769; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7DWMPMqd9cNWl1va5TMyM+BuJWLnNlmhwg/xb67BhE=;
 b=hevnYf9OgI7PYJzo2Rr8/sexmXa84itj36vx8ouSvbi259yiBMvdUqb2n9QHXdg6Ii
 KkqE104v0hppXLOVKCMNwOOuK1Ylb4WqV6x49zw2sHjFXsBgBiRpFN42z9Y2Q+HO7PIE
 LL7X3QngQ+nvuUvbc+EWJMIqCyPxVgjiLZHXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146969; x=1695751769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7DWMPMqd9cNWl1va5TMyM+BuJWLnNlmhwg/xb67BhE=;
 b=ABW7RQqQlQ7JtMPF7LII5HpkAbPnmF2OHCWZ6dJPEVmBPeztRsX1QVFRUyxFs1W823
 TrnszZdo1GxYhBEwe2v/ofHIrJ53jk8aAhV12DzlhLsBlegmsbipWGme8JBX0YXps6+X
 4gHSY/MY5TR8dPMeYkk92+hYEG/fBHTq3TChzVt7ynXqKqpY+/ezEGLMqBAJfZ+U7PC7
 RELjTlgMSIYt8N87kDtUiqpyg+w82vXq+EvXEEMkL2dKijCRHddA9kxfAOv8Zl1OPs9C
 p5LovARPwFzYWB92mLMSkkf/bH1lDuvUUNgOandufnI1LzFUWC6reozaluTCL7O4LZHe
 tgsQ==
X-Gm-Message-State: AOJu0Yw//nAehLwOr+tSlXHxtoz2ovmcm4ZZrnr9bzqdemW1JeroexuE
 KeIBExP17HC5jmgWwVzdS36eW1fnYB041fhHYGc=
X-Google-Smtp-Source: AGHT+IEdxQA5XTKEboLjcuua3db85xvjM6YpVQiFMVxbQE3cSozfqCRjHDc3ggHobLzENodyNtfenA==
X-Received: by 2002:a05:6e02:b4d:b0:34b:ad7a:384f with SMTP id
 f13-20020a056e020b4d00b0034bad7a384fmr733501ilu.20.1695146969064; 
 Tue, 19 Sep 2023 11:09:29 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Masahisa Kojima <masahisa.kojima@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robimarko@gmail.com>,
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 02/36] cli: Add a command to show cmdline history
Date: Tue, 19 Sep 2023 12:08:32 -0600
Message-ID: <20230919180918.2904313-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919180918.2904313-1-sjg@chromium.org>
References: <20230919180918.2904313-1-sjg@chromium.org>
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

There is a function for this but it is never used. Showing the history is
a useful feature, so add a new 'history' command.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/Kconfig               |  7 ++++
 cmd/Makefile              |  1 +
 cmd/history.c             | 23 +++++++++++++
 common/cli_readline.c     |  4 +--
 doc/usage/cmd/history.rst | 68 +++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst       |  1 +
 include/cli.h             |  3 ++
 test/cmd/Makefile         |  1 +
 test/cmd/history.c        | 49 ++++++++++++++++++++++++++++
 9 files changed, 154 insertions(+), 3 deletions(-)
 create mode 100644 cmd/history.c
 create mode 100644 doc/usage/cmd/history.rst
 create mode 100644 test/cmd/history.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 3f14923b5ef..0f35f7f6ec6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -176,6 +176,13 @@ config CMD_FWU_METADATA
 	help
 	  Command to read the metadata and dump it's contents
 
+config CMD_HISTORY
+	bool "history"
+	depends on CMDLINE_EDITING
+	help
+	  Show the command-line history, i.e. a list of commands that are in
+	  the history buffer.
+
 config CMD_LICENSE
 	bool "license"
 	select BUILD_BIN2C
diff --git a/cmd/Makefile b/cmd/Makefile
index 9bebf321c39..971f78a7fbd 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_CMD_FUSE) += fuse.o
 obj-$(CONFIG_CMD_FWU_METADATA) += fwu_mdata.o
 obj-$(CONFIG_CMD_GETTIME) += gettime.o
 obj-$(CONFIG_CMD_GPIO) += gpio.o
+obj-$(CONFIG_CMD_HISTORY) += history.o
 obj-$(CONFIG_CMD_HVC) += smccc.o
 obj-$(CONFIG_CMD_I2C) += i2c.o
 obj-$(CONFIG_CMD_IOTRACE) += iotrace.o
diff --git a/cmd/history.c b/cmd/history.c
new file mode 100644
index 00000000000..b6bf4670b1c
--- /dev/null
+++ b/cmd/history.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <common.h>
+#include <command.h>
+#include <cli.h>
+
+static int do_history(struct cmd_tbl *cmdtp, int flag, int argc,
+		      char *const argv[])
+{
+	cread_print_hist_list();
+
+	return 0;
+}
+
+U_BOOT_CMD(
+	history,	CONFIG_SYS_MAXARGS,	1,	do_history,
+	"print command history",
+	""
+);
diff --git a/common/cli_readline.c b/common/cli_readline.c
index 9a7c268719d..f3ba76a62ec 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -160,8 +160,7 @@ static char *hist_next(void)
 	return ret;
 }
 
-#ifndef CONFIG_CMDLINE_EDITING
-static void cread_print_hist_list(void)
+void cread_print_hist_list(void)
 {
 	int i;
 	unsigned long n;
@@ -179,7 +178,6 @@ static void cread_print_hist_list(void)
 		i++;
 	}
 }
-#endif /* CONFIG_CMDLINE_EDITING */
 
 #define BEGINNING_OF_LINE() {			\
 	while (num) {				\
diff --git a/doc/usage/cmd/history.rst b/doc/usage/cmd/history.rst
new file mode 100644
index 00000000000..7d5a87babb2
--- /dev/null
+++ b/doc/usage/cmd/history.rst
@@ -0,0 +1,68 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+history command
+===============
+
+Synopis
+-------
+
+::
+
+    history
+
+Description
+-----------
+
+The *history* command shows a list of previously entered commands on the
+command line. When U-Boot starts, this it is initially empty. Each new command
+entered is added to the list.
+
+Normally these commands can be accessed by pressing the `up arrow` and
+`down arrow` keys, which cycle through the list. The `history` command provides
+a simple way to view the list.
+
+Example
+-------
+
+This example shows entering three commands, then `history`. Note that `history`
+itself is added to the list.
+
+::
+
+    => bootflow scan -l
+    Scanning for bootflows in all bootdevs
+    Seq  Method       State   Uclass    Part  Name                      Filename
+    ---  -----------  ------  --------  ----  ------------------------  ----------------
+    Scanning global bootmeth 'firmware0':
+    Hunting with: simple_bus
+    Found 2 extension board(s).
+    Scanning bootdev 'mmc2.bootdev':
+    Scanning bootdev 'mmc1.bootdev':
+      0  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf
+    No more bootdevs
+    ---  -----------  ------  --------  ----  ------------------------  ----------------
+    (1 bootflow, 1 valid)
+    => bootflow select 0
+    => bootflow info
+    Name:      mmc1.bootdev.part_1
+    Device:    mmc1.bootdev
+    Block dev: mmc1.blk
+    Method:    extlinux
+    State:     ready
+    Partition: 1
+    Subdir:    (none)
+    Filename:  /extlinux/extlinux.conf
+    Buffer:    aebdea0
+    Size:      253 (595 bytes)
+    OS:        Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
+    Cmdline:   (none)
+    Logo:      (none)
+    FDT:       <NULL>
+    Error:     0
+    => history
+    bootflow scan -l
+    bootflow select 0
+    bootflow info
+    history
+    =>
+
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index fa702920faa..98b4719c408 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -67,6 +67,7 @@ Shell commands
    cmd/fwu_mdata
    cmd/gpio
    cmd/gpt
+   cmd/history
    cmd/host
    cmd/imxtract
    cmd/load
diff --git a/include/cli.h b/include/cli.h
index 094a6602d70..ac09c80c784 100644
--- a/include/cli.h
+++ b/include/cli.h
@@ -229,4 +229,7 @@ void cli_ch_init(struct cli_ch_state *cch);
  */
 int cli_ch_process(struct cli_ch_state *cch, int ichar);
 
+/** cread_print_hist_list() - Print the command-line history list */
+void cread_print_hist_list(void);
+
 #endif
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 6e3d7e919ef..8d70ac510a5 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_CMD_ADDRMAP) += addrmap.o
 obj-$(CONFIG_CMD_BDI) += bdinfo.o
 obj-$(CONFIG_CMD_FDT) += fdt.o
 obj-$(CONFIG_CONSOLE_TRUETYPE) += font.o
+obj-$(CONFIG_CMD_HISTORY) += history.o
 obj-$(CONFIG_CMD_LOADM) += loadm.o
 obj-$(CONFIG_CMD_MEM_SEARCH) += mem_search.o
 ifdef CONFIG_CMD_PCI
diff --git a/test/cmd/history.c b/test/cmd/history.c
new file mode 100644
index 00000000000..06517fcdbb5
--- /dev/null
+++ b/test/cmd/history.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for history command
+ *
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <common.h>
+#include <cli.h>
+#include <command.h>
+#include <test/lib.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int lib_test_history(struct unit_test_state *uts)
+{
+	static const char cmd1[] = "setenv fred hello";
+	static const char cmd2[] = "print fred";
+
+	/* running commands directly does not add to history */
+	ut_assertok(run_command(cmd1, 0));
+	ut_assert_console_end();
+	ut_assertok(run_command("history", 0));
+	ut_assert_console_end();
+
+	/* enter commands via the console */
+	console_in_puts(cmd1);
+	console_in_puts("\n");
+	ut_asserteq(strlen(cmd1), cli_readline(""));
+	ut_assert_nextline(cmd1);
+
+	console_in_puts(cmd2);
+	console_in_puts("\n");
+	ut_asserteq(strlen(cmd2), cli_readline(""));
+	ut_assert_nextline(cmd2);
+
+	ut_assertok(run_command("print fred", 0));
+	ut_assert_nextline("fred=hello");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("history", 0));
+	ut_assert_nextline(cmd1);
+	ut_assert_nextline(cmd2);
+	ut_assert_console_end();
+
+	return 0;
+}
+LIB_TEST(lib_test_history, UT_TESTF_CONSOLE_REC);
-- 
2.42.0.459.ge4e396fd5e-goog

