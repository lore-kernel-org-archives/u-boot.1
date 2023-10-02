Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF543E784BC
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B669E871B9;
	Mon,  2 Oct 2023 17:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FUgJo1fg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CADC0871B1; Mon,  2 Oct 2023 17:21:59 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D424F87166
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
Received: from arisu.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id BFDC46607312;
 Mon,  2 Oct 2023 16:21:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1696260117;
 bh=FP2a+a1Z9aUwZV6y4KjMh6D6/T7Afk0PYvV/OB9YyYg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FUgJo1fgaN5vbWAg82+IOv3LLSirULHvVenfNgxAPA76vOtJrZAeLlZS7GkZpQdZ1
 DGhAqUUoW5UzEo0d4xZiJfHlTf/M/SOgxGIgSb0d+yYXRUeD+q8McAsjkyeqGLLhN1
 8aZEhTihj4OCdUYtlk8RXarocS+MWLl2qNaYRYhtdylchCRQl+rq6I85c7lBmWJmPg
 NT4CEBr+hA1zoB0KLWQlNaTov9fwjzdeUVjj9yLrsUoIB7nBBaaj1WNFStFAjgTGhC
 cfp3OgNGuz7A8LNTua+aLcsw2TEvNT5Yi+l95bndPwYpLZfxzErW0vbLm33xPwWqX2
 vejn1g5CR4FJA==
From: Detlev Casanova <detlev.casanova@collabora.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Simon Glass <sjg@chromium.org>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v5 3/6] sysinfo: Add a test
Date: Mon,  2 Oct 2023 11:20:07 -0400
Message-ID: <20231002152142.76516-4-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002152142.76516-1-detlev.casanova@collabora.com>
References: <20231002152142.76516-1-detlev.casanova@collabora.com>
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

The test runs one of each subcommand and checks that the output matches
the values in the sandbox sysinfo driver.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 configs/sandbox_defconfig |  1 +
 drivers/sysinfo/sandbox.c | 17 +++++++++++++
 test/cmd/Makefile         |  1 +
 test/cmd/test_sysinfo.c   | 51 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+)
 create mode 100644 test/cmd/test_sysinfo.c

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 62bc182ca16..409e3d88012 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -129,6 +129,7 @@ CONFIG_CMD_EROFS=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_SYSINFO=y
 CONFIG_CMD_STACKPROTECTOR_TEST=y
 CONFIG_MAC_PARTITION=y
 CONFIG_AMIGA_PARTITION=y
diff --git a/drivers/sysinfo/sandbox.c b/drivers/sysinfo/sandbox.c
index d270a26aa43..cc7783907a9 100644
--- a/drivers/sysinfo/sandbox.c
+++ b/drivers/sysinfo/sandbox.c
@@ -7,9 +7,14 @@
 #include <common.h>
 #include <dm.h>
 #include <sysinfo.h>
+#include <version.h>
 
 #include "sandbox.h"
 
+#define SANDBOX_BOARD_ID	0x42
+#define SANDBOX_BOARD_REV_MAJOR	U_BOOT_VERSION_NUM
+#define SANDBOX_BOARD_REV_MINOR	U_BOOT_VERSION_NUM_PATCH
+
 struct sysinfo_sandbox_priv {
 	bool called_detect;
 	int test_i1;
@@ -48,6 +53,15 @@ int sysinfo_sandbox_get_int(struct udevice *dev, int id, int *val)
 	struct sysinfo_sandbox_priv *priv = dev_get_priv(dev);
 
 	switch (id) {
+	case SYSINFO_ID_BOARD_ID:
+		*val = SANDBOX_BOARD_ID;
+		return 0;
+	case SYSINFO_ID_BOARD_REV_MAJOR:
+		*val = SANDBOX_BOARD_REV_MAJOR;
+		return 0;
+	case SYSINFO_ID_BOARD_REV_MINOR:
+		*val = SANDBOX_BOARD_REV_MINOR;
+		return 0;
 	case INT_TEST1:
 		*val = priv->test_i1;
 		/* Increments with every call */
@@ -71,6 +85,9 @@ int sysinfo_sandbox_get_str(struct udevice *dev, int id, size_t size, char *val)
 	int index = (i1 * i2) % ARRAY_SIZE(vacation_spots);
 
 	switch (id) {
+	case SYSINFO_ID_BOARD_MODEL:
+		snprintf(val, size, "sandbox");
+		return 0;
 	case STR_VACATIONSPOT:
 		/* Picks a vacation spot depending on i1 and i2 */
 		snprintf(val, size, vacation_spots[index]);
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 6e3d7e919ef..dc8f59d87f2 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -26,6 +26,7 @@ ifdef CONFIG_SANDBOX
 obj-$(CONFIG_CMD_READ) += rw.o
 obj-$(CONFIG_CMD_SETEXPR) += setexpr.o
 obj-$(CONFIG_ARM_FFA_TRANSPORT) += armffa.o
+obj-$(CONFIG_CMD_SYSINFO) += test_sysinfo.o
 endif
 obj-$(CONFIG_CMD_TEMPERATURE) += temperature.o
 obj-$(CONFIG_CMD_WGET) += wget.o
diff --git a/test/cmd/test_sysinfo.c b/test/cmd/test_sysinfo.c
new file mode 100644
index 00000000000..7ba6dd0df89
--- /dev/null
+++ b/test/cmd/test_sysinfo.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for sysinfo command
+ *
+ * Copyright 2023, Detlev Casanova <detlev.casanova@collabora.com>
+ */
+
+#include <common.h>
+#include <command.h>
+#include <asm/global_data.h>
+#include <display_options.h>
+#include <test/lib.h>
+#include <test/test.h>
+#include <test/ut.h>
+#include <version.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define REV_(x, y) #x "." #y
+#define REV(x, y) REV_(x, y)
+
+struct test_data {
+	char *cmd;
+	char *expected;
+};
+
+static struct test_data sysinfo_data[] = {
+	{"sysinfo model", "sandbox"},
+	{"sysinfo id", "0x42"},
+	{"sysinfo revision", REV(U_BOOT_VERSION_NUM, U_BOOT_VERSION_NUM_PATCH)},
+};
+
+static int lib_test_sysinfo(struct unit_test_state *uts)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sysinfo_data); ++i) {
+		ut_silence_console(uts);
+		console_record_reset_enable();
+		ut_assertok(run_command(sysinfo_data[i].cmd, 0));
+		ut_unsilence_console(uts);
+		console_record_readline(uts->actual_str,
+					sizeof(uts->actual_str));
+		ut_asserteq_str(sysinfo_data[i].expected, uts->actual_str);
+		ut_assertok(ut_check_console_end(uts));
+	}
+
+	return 0;
+}
+
+LIB_TEST(lib_test_sysinfo, 0);
-- 
2.41.0

