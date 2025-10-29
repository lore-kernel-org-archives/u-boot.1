Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1274CCF9E9
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 14:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20CD58004F;
	Wed, 29 Oct 2025 15:14:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qx8TpI+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66B138003E; Wed, 29 Oct 2025 15:14:42 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B45E8006D
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 15:14:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A017240965; 
 Wed, 29 Oct 2025 14:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761747276;
 bh=AfTu4tOEOeHZPfVLAavD1QxG5KhiCA26WLYcNKAwiuc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=qx8TpI+90sJ21a6F5iR1lteFSshFbotqKY7MHPgCOfGEzmgKFsmwqR5iHAnr4TLRw
 CCCjzuIp5820hXuwMAcpOeplM1BGYk766mba4HMr/3DPJRglE2Y3y0W15LWHBPk6GE
 lVzlze0IbJ6Fz0Yl8c9sgOppSuegwd6JBp+zOKQ6X+aUb08X1NcJhRxB5HO7QBfBgV
 j6eMJaalru8JcbMgb74ui1H6xffBGmFfXyp+CLgH9YpS7fzkDGu/RdLS4dQ63bScZ2
 G2GQmm0YZXU30rBhD53ARSIyVpEXPM4ENusp7mHguE95P7dZHRal0g3ApI3uffvS7O
 PngvjX5/CpaU7fu4GZQ1ePDFQawKNcI9lVMosAbBDreRhS27bB25CN4a0rIIQSqaKF
 f0vptRxhAi/CxMhEJIt3svOlHfAqX9xS6E1Nn1hVkKg3mJ0X2tID/6VjGOwQOERQMp
 sLshpvlhYcnD5Xd4PHOfyLsDsB+K+cQcRqIT3M2cat4fLe0z9nT3d+woG8+IdZQb/+
 47SzV/o6ynAsf6DYIiG5+laNFRsjDfB4lxZfRg31EHIEuuoZDfN1cxKJVOTnH1WRvN
 EiDjl6/ZmcIVcXIR3rmEeVL0d8/wp4f4wyJRLL881IWKV/WYBRYxRaBF50NHCA+vZr
 xRDor4TgDrDO4m794GP/KpE8=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] qfw: Add more fields and a heading to qfw list
Date: Wed, 29 Oct 2025 15:14:32 +0100
Message-ID: <20251029141432.276238-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

From: Simon Glass <sjg@chromium.org>

Update the command to show the size and selected file, since this is
useful information at times. Add a heading so it is clear what each
field refers to.

Add a simple test as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/qfw.c             |  6 +++++-
 doc/usage/cmd/qfw.rst | 27 +++++++++++++++------------
 test/cmd/Makefile     |  1 +
 test/cmd/qfw.c        | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 13 deletions(-)
 create mode 100644 test/cmd/qfw.c

diff --git a/cmd/qfw.c b/cmd/qfw.c
index 1b108118658..09bd7d9849d 100644
--- a/cmd/qfw.c
+++ b/cmd/qfw.c
@@ -22,10 +22,14 @@ static int qemu_fwcfg_cmd_list_firmware(void)
 	if (ret)
 		return ret;
 
+	printf("            Addr     Size Sel Name\n");
+	printf("---------------- -------- --- ------------\n");
 	for (file = qfw_file_iter_init(qfw_dev, &iter);
 	     !qfw_file_iter_end(&iter);
 	     file = qfw_file_iter_next(&iter)) {
-		printf("%08lx %-56s\n", file->addr, file->cfg.name);
+		printf("%16lx %8x %3x %-48s\n", file->addr,
+		       be32_to_cpu(file->cfg.size),
+		       be16_to_cpu(file->cfg.select), file->cfg.name);
 	}
 
 	return 0;
diff --git a/doc/usage/cmd/qfw.rst b/doc/usage/cmd/qfw.rst
index 40770acb3c0..0a65a247b44 100644
--- a/doc/usage/cmd/qfw.rst
+++ b/doc/usage/cmd/qfw.rst
@@ -44,18 +44,21 @@ QEMU firmware files are listed via the *qfw list* command:
 ::
 
     => qfw list
-    00000000 bios-geometry
-    00000000 bootorder
-    000f0060 etc/acpi/rsdp
-    bed14040 etc/acpi/tables
-    00000000 etc/boot-fail-wait
-    00000000 etc/e820
-    00000000 etc/smbios/smbios-anchor
-    00000000 etc/smbios/smbios-tables
-    00000000 etc/system-states
-    00000000 etc/table-loader
-    00000000 etc/tpm/log
-    00000000 genroms/kvmvapic.bin
+                Addr     Size Sel Name
+    ---------------- -------- --- ------------
+                   0        0  20 bios-geometry
+                   0        0  21 bootorder
+            1fc6c000       14  22 etc/acpi/rsdp
+            1fc6c040    20000  23 etc/acpi/tables
+                   0        4  24 etc/boot-fail-wait
+                   0       28  25 etc/e820
+                   0        8  26 etc/msr_feature_control
+                   0       18  27 etc/smbios/smbios-anchor
+                   0      151  28 etc/smbios/smbios-tables
+                   0        6  29 etc/system-states
+                   0     1000  2a etc/table-loader
+                   0        0  2b etc/tpm/log
+                   0     2400  2c genroms/kvmvapic.bin
 
 Where an address is shown, it indicates where the data is available for
 inspection, e.g. using the :doc:`md`.
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index e71c80a5b2e..98731d9bdff 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_CMD_MEM_SEARCH) += mem_search.o
 ifdef CONFIG_CMD_PCI
 obj-$(CONFIG_CMD_PCI_MPS) += pci_mps.o
 endif
+obj-$(CONFIG_CMD_QFW) += qfw.o
 obj-$(CONFIG_CMD_SEAMA) += seama.o
 ifdef CONFIG_SANDBOX
 obj-$(CONFIG_CMD_MBR) += mbr.o
diff --git a/test/cmd/qfw.c b/test/cmd/qfw.c
new file mode 100644
index 00000000000..e615a82b31a
--- /dev/null
+++ b/test/cmd/qfw.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for qfw command
+ *
+ * Copyright 2025 Simon Glass <sjg@chromium.org>
+ */
+
+#include <console.h>
+#include <dm.h>
+#include <mapmem.h>
+#include <qfw.h>
+#include <dm/test.h>
+#include <test/cmd.h>
+#include <test/ut.h>
+
+/* Test 'qfw list' command */
+static int cmd_test_qfw_list(struct unit_test_state *uts)
+{
+	struct fw_cfg_file_iter iter;
+	struct fw_file *file;
+	struct udevice *dev;
+
+	ut_assertok(uclass_first_device_err(UCLASS_QFW, &dev));
+
+	ut_assertok(run_command("qfw list", 0));
+	ut_assert_nextline("            Addr     Size Sel Name");
+	ut_assert_nextlinen("--");
+
+	for (file = qfw_file_iter_init(dev, &iter); !qfw_file_iter_end(&iter);
+	     file = qfw_file_iter_next(&iter)) {
+		ut_assert_nextline("%16lx %8x %3x %-48s", file->addr,
+				   be32_to_cpu(file->cfg.size),
+				   be16_to_cpu(file->cfg.select),
+				   file->cfg.name);
+	}
+	ut_assert_console_end();
+
+	return 0;
+}
+CMD_TEST(cmd_test_qfw_list, UTF_CONSOLE);
-- 
2.51.0

