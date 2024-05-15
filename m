Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4154C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 20:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 154748717A;
	Wed, 15 May 2024 22:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9C5A870AB; Wed, 15 May 2024 22:50:57 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FEAB8717A
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 22:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1s7LaO-00H3UX-8G;
 Wed, 15 May 2024 20:50:52 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
Date: Wed, 15 May 2024 13:50:49 -0700
Message-Id: <20240515205049.3005256-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
randomize the virtual address at which the kernel image is loaded, it
expects entropy to be provided by the bootloader by populating
/chosen/kaslr-seed with a 64-bit value from source of entropy at boot.

If we have DM_RNG enabled populate this value automatically when
fdt_chosen is called unless ARMV8_SEC_FIRMWARE_SUPPORT is enabled as
it's implementation uses a different source of entropy.

As this fdt node is added elsewhere create a library function and
use it to deduplicate code.

Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless now
but left in place in case boot scripts exist that rely on this command
existing and returning success. An informational message is printed to
alert users of this command that it is likely no longer needed.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2:
 - fix typo in commit msg
 - use stack for seed to avoid unecessary malloc/free
 - move to a library function and deduplicate code by using it elsewhere
---
 board/xilinx/common/board.c | 35 -----------------------------
 boot/fdt_support.c          | 10 +++++++++
 boot/pxe_utils.c            | 35 +++--------------------------
 cmd/kaslrseed.c             | 45 ++++++-------------------------------
 include/kaslrseed.h         | 17 ++++++++++++++
 lib/Makefile                |  1 +
 lib/kaslrseed.c             | 34 ++++++++++++++++++++++++++++
 7 files changed, 72 insertions(+), 105 deletions(-)
 create mode 100644 include/kaslrseed.h
 create mode 100644 lib/kaslrseed.c

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 30a81376ac41..f741e8957818 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -713,41 +713,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CONFIG_NAND_ZYNQ))
 		fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
 
-	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
-		debug("No RNG device\n");
-		return 0;
-	}
-
-	if (dm_rng_read(dev, buf, n)) {
-		debug("Reading RNG failed\n");
-		return 0;
-	}
-
-	if (!blob) {
-		debug("No FDT memory address configured. Please configure\n"
-		      "the FDT address via \"fdt addr <address>\" command.\n"
-		      "Aborting!\n");
-		return 0;
-	}
-
-	ret = fdt_check_header(blob);
-	if (ret < 0) {
-		debug("fdt_chosen: %s\n", fdt_strerror(ret));
-		return ret;
-	}
-
-	nodeoffset = fdt_find_or_add_subnode(blob, 0, "chosen");
-	if (nodeoffset < 0) {
-		debug("Reading chosen node failed\n");
-		return nodeoffset;
-	}
-
-	ret = fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, sizeof(buf));
-	if (ret < 0) {
-		debug("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
-		return ret;
-	}
-
 	return 0;
 }
 #endif
diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 874ca4d6f5af..3455d60d69dc 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -8,6 +8,7 @@
 
 #include <abuf.h>
 #include <env.h>
+#include <kaslrseed.h>
 #include <log.h>
 #include <mapmem.h>
 #include <net.h>
@@ -300,6 +301,15 @@ int fdt_chosen(void *fdt)
 	if (nodeoffset < 0)
 		return nodeoffset;
 
+	if (IS_ENABLED(CONFIG_DM_RNG) && !IS_ENABLED(ARMV8_SEC_FIRMWARE_SUPPORT)) {
+		err = fdt_kaslrseed(fdt);
+		if (err) {
+			printf("WARNING: could not set kaslr-seed %s.\n",
+			       fdt_strerror(err));
+			return err;
+		}
+	}
+
 	if (IS_ENABLED(CONFIG_BOARD_RNG_SEED) && !board_rng_seed(&buf)) {
 		err = fdt_setprop(fdt, nodeoffset, "rng-seed",
 				  abuf_data(&buf), abuf_size(&buf));
diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 4b22bb6f525a..8d70233fc08d 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <env.h>
 #include <image.h>
+#include <kaslrseed.h>
 #include <log.h>
 #include <malloc.h>
 #include <mapmem.h>
@@ -323,10 +324,6 @@ static void label_boot_kaslrseed(void)
 #if CONFIG_IS_ENABLED(DM_RNG)
 	ulong fdt_addr;
 	struct fdt_header *working_fdt;
-	size_t n = 0x8;
-	struct udevice *dev;
-	u64 *buf;
-	int nodeoffset;
 	int err;
 
 	/* Get the main fdt and map it */
@@ -342,35 +339,9 @@ static void label_boot_kaslrseed(void)
 	if (err <= 0)
 		return;
 
-	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
-		printf("No RNG device\n");
-		return;
-	}
-
-	nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
-	if (nodeoffset < 0) {
-		printf("Reading chosen node failed\n");
-		return;
-	}
-
-	buf = malloc(n);
-	if (!buf) {
-		printf("Out of memory\n");
-		return;
-	}
-
-	if (dm_rng_read(dev, buf, n)) {
-		printf("Reading RNG failed\n");
-		goto err;
-	}
-
-	err = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
-	if (err < 0) {
+	err = fdt_kaslrseed(working_fdt);
+	if (err < 0)
 		printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(err));
-		goto err;
-	}
-err:
-	free(buf);
 #endif
 	return;
 }
diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
index e0d3c7fe7489..ea5c07d729cf 100644
--- a/cmd/kaslrseed.c
+++ b/cmd/kaslrseed.c
@@ -9,33 +9,16 @@
 #include <command.h>
 #include <dm.h>
 #include <hexdump.h>
+#include <kaslrseed.h>
 #include <malloc.h>
 #include <rng.h>
 #include <fdt_support.h>
 
 static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	size_t n = 0x8;
-	struct udevice *dev;
-	u64 *buf;
-	int nodeoffset;
-	int ret = CMD_RET_SUCCESS;
+	int err;
 
-	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
-		printf("No RNG device\n");
-		return CMD_RET_FAILURE;
-	}
-
-	buf = malloc(n);
-	if (!buf) {
-		printf("Out of memory\n");
-		return CMD_RET_FAILURE;
-	}
-
-	if (dm_rng_read(dev, buf, n)) {
-		printf("Reading RNG failed\n");
-		return CMD_RET_FAILURE;
-	}
+	printf("Notice: a /chosen/kaslr-seed is automatically added to the device-tree when booted via booti/bootm/bootz therefore using this command is likely no longer needed");
 
 	if (!working_fdt) {
 		printf("No FDT memory address configured. Please configure\n"
@@ -44,27 +27,13 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const
 		return CMD_RET_FAILURE;
 	}
 
-	ret = fdt_check_header(working_fdt);
-	if (ret < 0) {
-		printf("fdt_chosen: %s\n", fdt_strerror(ret));
+	err = fdt_kaslrseed(working_fdt);
+	if (err < 0) {
+		printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(err));
 		return CMD_RET_FAILURE;
 	}
 
-	nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
-	if (nodeoffset < 0) {
-		printf("Reading chosen node failed\n");
-		return CMD_RET_FAILURE;
-	}
-
-	ret = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
-	if (ret < 0) {
-		printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
-		return CMD_RET_FAILURE;
-	}
-
-	free(buf);
-
-	return ret;
+	return CMD_RET_SUCCESS;
 }
 
 U_BOOT_LONGHELP(kaslrseed,
diff --git a/include/kaslrseed.h b/include/kaslrseed.h
new file mode 100644
index 000000000000..3fe82f418acf
--- /dev/null
+++ b/include/kaslrseed.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
+ */
+
+#if !defined _KASLRSEED_H_
+#define _KASLRSEED_H_
+
+/**
+ * fdt_kaslrseed() - create a 'kaslr-seed' node in chosen
+ *
+ * @blob:	fdt blob
+ * Return:	0 if OK, -ve on error
+ */
+int fdt_kaslrseed(void *blob);
+
+#endif /* _KASLRSEED_H_ */
diff --git a/lib/Makefile b/lib/Makefile
index 2a76acf100d0..20a0242055fa 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -149,6 +149,7 @@ obj-y += date.o
 obj-y += rtc-lib.o
 obj-$(CONFIG_LIB_ELF) += elf.o
 
+obj-$(CONFIG_DM_RNG) += kaslrseed.o
 obj-$(CONFIG_$(SPL_TPL_)SEMIHOSTING) += semihosting.o
 
 #
diff --git a/lib/kaslrseed.c b/lib/kaslrseed.c
new file mode 100644
index 000000000000..ad06bee2b88d
--- /dev/null
+++ b/lib/kaslrseed.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
+ */
+#include <dm.h>
+#include <rng.h>
+#include <fdt_support.h>
+
+int fdt_kaslrseed(void *fdt)
+{
+	struct udevice *dev;
+	int nodeoffset;
+	u64 data;
+	int err;
+
+	err = fdt_check_header(fdt);
+	if (err < 0)
+		return err;
+
+	/* find or create "/chosen" node. */
+	nodeoffset = fdt_find_or_add_subnode(fdt, 0, "chosen");
+	if (nodeoffset < 0)
+		return nodeoffset;
+
+	err = uclass_get_device(UCLASS_RNG, 0, &dev);
+	if (!err)
+		err = dm_rng_read(dev, &data, sizeof(data));
+	if (!err)
+		err = fdt_setprop(fdt, nodeoffset, "kaslr-seed", &data, sizeof(data));
+	if (err < 0)
+		printf("WARNING: could not set kaslr-seed %s.\n", fdt_strerror(err));
+
+	return err;
+}
-- 
2.25.1

