Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4218CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 11:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F7D83280;
	Mon, 22 Sep 2025 13:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZinBfzui";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="a9qbdMfw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B42F0833E9; Mon, 22 Sep 2025 13:49:53 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5122983211
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 13:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cVhHM0YNWz9sX2;
 Mon, 22 Sep 2025 13:49:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758541791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mfAIXS55w72pPX+dbRT4KeuO7USmiTo+zB7HuDmSXRA=;
 b=ZinBfzui0OP2VZnkxTaTc5Ux95R02+A+g9RM6KdCh0ZbsycnR5wcvBbitHOTr8+1AU3ZFQ
 EYX10fZNHVJkNqCIrVwXEHfkdTVVgMJzgWwVrCsp6Kp5aO36eiYhG6Vn8dSuCuReVlvXGZ
 eAfEP7avK8CcZp/5ty6Iac0nh5sMo1E0b9u8FaMwUlGZ/xk6ZxjfWng4Lz4w1zpr7gyMJ6
 CAr7c2Tg+K9/SGFd/n9WvkALD6t78UqalRQqsL2mbgJsqrusr5Qri3E7auESkOd0LwcZ4i
 XfGnfeW3iVCkT5mZhqFb81teOK4R8SyLUmqAEsm8c9R3Mv70vaT3YImvHMvF9A==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=a9qbdMfw;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758541789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mfAIXS55w72pPX+dbRT4KeuO7USmiTo+zB7HuDmSXRA=;
 b=a9qbdMfwcD23dYSj+5cQUojl3My/7JXTomLuvZT8KZCHgbL/eXePOrshp2at7tCubrNMoI
 148hz3C58lYktta5yS5uEFio2qXELOi6+DXJoUBHWoMFGvFSHWOBSq1pxHCX5XCrcttaJG
 /pNgTnjEkmYbSEev3giR3TSPPA9hjbGSXfRQpn1zFHPdGKJ7rwXxwuoppxV4efdYxVIV5M
 BljKsM+BGZCnF/BbrM2M1Wg4sLfIfb+6Ls1BRBXlwd/vglfhX9FFh6H1qC1Rh4gtk0yBOG
 cEDAjRIRxHWs0ZXEISA575tnaV+hiUyJsIh+x3ES7XJpbcVPnyY010Ldv8Bq9w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 1/2] fw_loader: Split from fs_loader into separate library file
Date: Mon, 22 Sep 2025 13:48:27 +0200
Message-ID: <20250922114926.51984-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qhjeuiqapy7s4tu13oq1y8wwpwurajbi
X-MBO-RS-ID: ce755b9cb1f5f0e746d
X-Rspamd-Queue-Id: 4cVhHM0YNWz9sX2
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

The script based firmware loader does not use anything from the
fs_loader implementation. Separate it into its own library source
file and convert the mediatek PHY to use this separate code. This
should reduce the amount of code that is pulled in alongside the
firmware loader, as the FS loader is no longer included.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de
---
 drivers/misc/fs_loader.c             | 47 -----------------------
 drivers/net/phy/mediatek/Kconfig     |  2 +-
 drivers/net/phy/mediatek/mtk-2p5ge.c |  2 +-
 include/fs_loader.h                  | 25 ------------
 include/fw_loader.h                  | 34 +++++++++++++++++
 lib/Kconfig                          |  8 ++++
 lib/Makefile                         |  2 +
 lib/fw_loader.c                      | 57 ++++++++++++++++++++++++++++
 8 files changed, 103 insertions(+), 74 deletions(-)
 create mode 100644 include/fw_loader.h
 create mode 100644 lib/fw_loader.c

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index d641647e040..2928cf75f89 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -228,53 +228,6 @@ int request_firmware_into_buf(struct udevice *dev,
 	return ret;
 }
 
-int request_firmware_into_buf_via_script(void *buf, size_t max_size,
-					 const char *script_name,
-					 size_t *retsize)
-{
-	char *args[2] = { "run", (char *)script_name };
-	int ret, repeatable;
-	ulong addr, size;
-
-	if (!buf || !script_name || !max_size)
-		return -EINVAL;
-
-	/* Run the firmware loading script */
-	ret = cmd_process(0, 2, args, &repeatable, NULL);
-	if (ret) {
-		log_err("Firmware loading script '%s' not defined or failed.\n",
-			script_name);
-		return -EINVAL;
-	}
-
-	/* Find out where the firmware got loaded and how long it is */
-	addr = env_get_hex("fw_addr", 0);
-	size = env_get_hex("fw_size", 0);
-
-	/* Clear the variables set by the firmware loading script */
-	env_set("fw_addr", NULL);
-	env_set("fw_size", NULL);
-
-	if (!addr || !size) {
-		log_err("Firmware address (0x%lx) or size (0x%lx) are invalid.\n",
-			addr, size);
-		return -EINVAL;
-	}
-
-	if (size > max_size) {
-		log_err("Loaded firmware size 0x%lx exceeded maximum allowed size 0x%zx.\n",
-			size, max_size);
-		return -E2BIG;
-	}
-
-	if (retsize)
-		*retsize = size;
-
-	memcpy(buf, (void *)addr, size);
-
-	return 0;
-}
-
 static int fs_loader_of_to_plat(struct udevice *dev)
 {
 	u32 phandlepart[2];
diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
index bbda951e7d9..933271f01fa 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -6,8 +6,8 @@ config MTK_NET_PHYLIB
 config PHY_MEDIATEK_2P5GE
 	bool "MediaTek built-in 2.5Gb ethernet PHYs"
 	depends on OF_CONTROL && (TARGET_MT7987 || TARGET_MT7988)
+	select FW_LOADER
 	select MTK_NET_PHYLIB
-	select FS_LOADER
 	help
 	  Supports MediaTek SoC built-in 2.5Gb ethernet PHYs.
 
diff --git a/drivers/net/phy/mediatek/mtk-2p5ge.c b/drivers/net/phy/mediatek/mtk-2p5ge.c
index 0e704bdb04d..4090db0b474 100644
--- a/drivers/net/phy/mediatek/mtk-2p5ge.c
+++ b/drivers/net/phy/mediatek/mtk-2p5ge.c
@@ -10,7 +10,7 @@
 #include <dm/of_access.h>
 #include <dm/pinctrl.h>
 #include <dm/ofnode.h>
-#include <fs_loader.h>
+#include <fw_loader.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
diff --git a/include/fs_loader.h b/include/fs_loader.h
index 3afd9e62b4a..7e16e0f7030 100644
--- a/include/fs_loader.h
+++ b/include/fs_loader.h
@@ -65,29 +65,4 @@ int request_firmware_into_buf(struct udevice *dev,
  */
 int get_fs_loader(struct udevice **dev);
 
-/**
- * request_firmware_into_buf_via_script() -
- * Load firmware using a U-Boot script and copy to buffer
- * @buf: Pointer to a pointer where the firmware buffer will be stored.
- * @max_size: Maximum allowed size for the firmware to be loaded.
- * @script_name: Name of the U-Boot script to execute for firmware loading.
- * @retsize: Return the actual firmware data size (optional).
- *
- * Executes a U-Boot script (@script_name) that loads firmware into
- * memory and sets the environment variables 'fw_addr' (address) and
- * 'fw_size' (size in bytes). On success, copies the firmware
- * from the given address to user buffer @buf.
- *
- * The script must set these environment variables:
- *   fw_addr - Address where firmware is loaded in memory
- *   fw_size - Size of the firmware in bytes
- *
- * The script should be defined in the U-Boot environment, for example:
- *   env set script_name 'load mmc 0:1 ${loadaddr} firmware.bin &&
- *   env set fw_addr ${loadaddr} && env set fw_size ${filesize}
- * Return: 0 on success, negative value on error.
- */
-int request_firmware_into_buf_via_script(void *buf, size_t max_size,
-					 const char *script_name,
-					 size_t *retsize);
 #endif
diff --git a/include/fw_loader.h b/include/fw_loader.h
new file mode 100644
index 00000000000..35574482b2b
--- /dev/null
+++ b/include/fw_loader.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Lucien Jheng <lucienzx159@gmail.com>
+ */
+#ifndef _FW_LOADER_H_
+#define _FW_LOADER_H_
+
+/**
+ * request_firmware_into_buf_via_script() -
+ * Load firmware using a U-Boot script and copy to buffer
+ * @buf: Pointer to a pointer where the firmware buffer will be stored.
+ * @max_size: Maximum allowed size for the firmware to be loaded.
+ * @script_name: Name of the U-Boot script to execute for firmware loading.
+ * @retsize: Return the actual firmware data size (optional).
+ *
+ * Executes a U-Boot script (@script_name) that loads firmware into
+ * memory and sets the environment variables 'fw_addr' (address) and
+ * 'fw_size' (size in bytes). On success, copies the firmware
+ * from the given address to user buffer @buf.
+ *
+ * The script must set these environment variables:
+ *   fw_addr - Address where firmware is loaded in memory
+ *   fw_size - Size of the firmware in bytes
+ *
+ * The script should be defined in the U-Boot environment, for example:
+ *   env set script_name 'load mmc 0:1 ${loadaddr} firmware.bin &&
+ *   env set fw_addr ${loadaddr} && env set fw_size ${filesize}
+ * Return: 0 on success, negative value on error.
+ */
+int request_firmware_into_buf_via_script(void *buf, size_t max_size,
+					 const char *script_name,
+					 size_t *retsize);
+
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index fbc9de90669..d6feee38ed3 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -71,6 +71,14 @@ config DYNAMIC_CRC_TABLE
 	  Enable this option to calculate entries for CRC tables at runtime.
 	  This can be helpful when reducing the size of the build image
 
+config FW_LOADER
+	bool "Enable firmware loader using environment script"
+	depends on CMDLINE
+	depends on ENV_SUPPORT
+	help
+	  Enable this option to make firmware loading using user-provided
+	  U-Boot environment script functionality accessible to U-Boot code.
+
 config HAVE_ARCH_IOMAP
 	bool
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 2643bfc867c..a2e60668864 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -22,6 +22,8 @@ obj-$(CONFIG_AES) += aes.o
 obj-$(CONFIG_AES) += aes/
 obj-$(CONFIG_$(PHASE_)BINMAN_FDT) += binman.o
 
+obj-$(CONFIG_FW_LOADER) += fw_loader.o
+
 ifndef API_BUILD
 ifneq ($(CONFIG_CHARSET),)
 obj-y += charset.o
diff --git a/lib/fw_loader.c b/lib/fw_loader.c
new file mode 100644
index 00000000000..207f5fadd1e
--- /dev/null
+++ b/lib/fw_loader.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Lucien Jheng <lucienzx159@gmail.com>
+ */
+
+#include <command.h>
+#include <env.h>
+#include <errno.h>
+#include <linux/types.h>
+#include <log.h>
+
+int request_firmware_into_buf_via_script(void *buf, size_t max_size,
+					 const char *script_name,
+					 size_t *retsize)
+{
+	char *args[2] = { "run", (char *)script_name };
+	int ret, repeatable;
+	ulong addr, size;
+
+	if (!buf || !script_name || !max_size)
+		return -EINVAL;
+
+	/* Run the firmware loading script */
+	ret = cmd_process(0, 2, args, &repeatable, NULL);
+	if (ret) {
+		log_err("Firmware loading script '%s' not defined or failed.\n",
+			script_name);
+		return -EINVAL;
+	}
+
+	/* Find out where the firmware got loaded and how long it is */
+	addr = env_get_hex("fw_addr", 0);
+	size = env_get_hex("fw_size", 0);
+
+	/* Clear the variables set by the firmware loading script */
+	env_set("fw_addr", NULL);
+	env_set("fw_size", NULL);
+
+	if (!addr || !size) {
+		log_err("Firmware address (0x%lx) or size (0x%lx) are invalid.\n",
+			addr, size);
+		return -EINVAL;
+	}
+
+	if (size > max_size) {
+		log_err("Loaded firmware size 0x%lx exceeded maximum allowed size 0x%zx.\n",
+			size, max_size);
+		return -E2BIG;
+	}
+
+	if (retsize)
+		*retsize = size;
+
+	memcpy(buf, (void *)addr, size);
+
+	return 0;
+}
-- 
2.51.0

