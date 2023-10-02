Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289D8E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89D4B870D5;
	Mon,  2 Oct 2023 03:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iVrSo9D0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AD03870C4; Mon,  2 Oct 2023 03:14:05 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0544870BD
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3af604c3f8fso3308150b6e.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209235; x=1696814035; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=byCoNuOmACVPX20qZC5WcJNIy0hJ0fADAeyP7oYo3cs=;
 b=iVrSo9D0ABEYLYJD0/sMsdObf+7biytQGesN4YNIyYhlMYeL8ojSUGn0N9ONsry1N2
 BN45sF/ApReRxEuD1uVYLDHDeLmWHBog02v0MYyoifScbQd+AbcMIN8K1NsXeAro1Zkx
 c6kZomd14GVi4l3yfCqQ5MdrgEn3HU74/xoHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209235; x=1696814035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=byCoNuOmACVPX20qZC5WcJNIy0hJ0fADAeyP7oYo3cs=;
 b=gZNA9/yNEG4ZKdaaEtCHtcztKaD1C3fEJ/ykhhDRyZYbye5p49L8gRNRBbbcOVPS07
 V5zFYhLWyuAu1HUj8LDnk/bZ2LBKM4iUTwqs9glT2G1CRwao0vswmLCn99yo1OfO1Sra
 oOBY/je0DEGEQwyiWeuIqWl49X2ihwgO5l578qAq56BffY8lyik6HheQGn2g2x8JxALq
 pyPsY7xmxUruDbrlv/x5Rad1SWHupndJb/vJBLKmLqP7Hd3Tz4wqntmZ7g+vcXPBQcXZ
 3IRtUZyWgWtnilTzuIddgK4uWtrMGkdKWkFlYDMKDx0oS58JsU3kDnRHPIMnkACGdEAV
 Kb3w==
X-Gm-Message-State: AOJu0YwaB3ca8G4VrUaNg8cjmgMbpXHOruTvcjVnqobkI/saGKE6OE+I
 DBSxI0lBwKq2HUicYBtJ/vq5tCLfCMVEMLcDW8U=
X-Google-Smtp-Source: AGHT+IE8jIf3WpPeHzmx22QSxwzbIxx+ltFk3PxCruVcnAAVvdKXlnzZY5QuF0RTwTfJFHpYSKJIOA==
X-Received: by 2002:a05:6808:493:b0:3ab:7adb:7b35 with SMTP id
 z19-20020a056808049300b003ab7adb7b35mr10700662oid.50.1696209235352; 
 Sun, 01 Oct 2023 18:13:55 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:13:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 02/36] cli: Add a command to show cmdline history
Date: Sun,  1 Oct 2023 19:13:06 -0600
Message-ID: <20231002011349.461284-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011349.461284-1-sjg@chromium.org>
References: <20231002011349.461284-1-sjg@chromium.org>
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

Changes in v2:
- Drop blank line at end of help

 cmd/Kconfig               |  7 ++++
 cmd/Makefile              |  1 +
 cmd/history.c             | 23 ++++++++++++++
 common/cli_readline.c     |  4 +--
 doc/usage/cmd/history.rst | 67 +++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst       |  1 +
 include/cli.h             |  3 ++
 test/cmd/Makefile         |  1 +
 test/cmd/history.c        | 49 ++++++++++++++++++++++++++++
 9 files changed, 153 insertions(+), 3 deletions(-)
 create mode 100644 cmd/history.c
 create mode 100644 doc/usage/cmd/history.rst
 create mode 100644 test/cmd/history.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 64d723bd483b..34e1c91a15a9 100644
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
index 9bebf321c397..971f78a7fbd4 100644
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
index 000000000000..b6bf4670b1ce
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
index 9a7c268719da..f3ba76a62ec8 100644
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
index 000000000000..33d3fcd6247f
--- /dev/null
+++ b/doc/usage/cmd/history.rst
@@ -0,0 +1,67 @@
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
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index fa702920faa7..98b4719c4088 100644
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
index 094a6602d70e..ac09c80c784c 100644
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
index 6e3d7e919ef2..8d70ac510a53 100644
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
index 000000000000..06517fcdbb51
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
2.42.0.582.g8ccd20d70d-goog

