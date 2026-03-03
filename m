Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697DCEC1442
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 13:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEF5083F59;
	Tue,  3 Mar 2026 14:29:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eqhyuGHB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70E0D83F59; Tue,  3 Mar 2026 14:29:34 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF3FA83F59
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 14:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so51832155e9.1
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 05:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772544568; x=1773149368; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q5gITlxwf3bd6H6tocG2gLgYjzfgCFArA1NsgKv7HwA=;
 b=eqhyuGHBETJY1dF/WrVWbmdfE2JzKxWbzpQGfl4j6AE4qwUHRubYGGEa54eGqHFYgv
 xIfEihWsT76dZaXczUhqypHwMMdGI8nLfC1z8fpvGvcLb48ucN0TIYoAlOsnAaxchzIk
 f/riDASW9IQ7wds0Xnrg8S/dGdz7hArEgJvhqLzmjnjstuDKimhcCdTwXR2a88pCBj2N
 VEPE1gedL9Dy680pZhSoeafYpLxpWkr8o9MKs5ZguFOSXM5vhTVEHe4oB05hfe6tp8rk
 loF/zWIDuzWfKDBSlcmhXShaG/eUdaf7c7EX3Pirx2g5bv8eFxwH77x/tDNeqW6DnfHF
 UopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772544568; x=1773149368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q5gITlxwf3bd6H6tocG2gLgYjzfgCFArA1NsgKv7HwA=;
 b=kaQH/GA7IVwr5/287KGbmQqhuLd7lZkmT+rUDQqCp1p7haBDdtj5duMwjSNy37Cq21
 DyGa8mTLGQi4cJ5sdFuKbOUnW4CujUohWa+ri11g7uYzxfF7CyG6YXw7wDYv43EzS6gF
 7lpQ8Xd3+SC/63FHcroZxuEM2Ge98cq15k6ON9GU+ZkVSrfIKjKmiwJxWRDeF2rjEHmh
 qYM1qooxjyItAV+4N9uhS2sQwfmpF5xtJzQ/ePv7R+ia3y6Tt3FjAathk86f8t2Jx316
 mBR6F5ly9mREhoXe3I1CghNDwLwRm7vPm2zt6VIMtwHZbWwYxFcShJyH4gIDw+jkXNMp
 M7AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJV3hyivfQhY6YbO2buzDcl3vyymaFKZwzNKXdKB6Qsvh5Kdr52hKUrz9VncS3zjyp0L1qUsA=@lists.denx.de
X-Gm-Message-State: AOJu0YyQE9m/RzkUnNNRFMOFbDIx7ITRrn1RTOstuOxZjLCQEIxXxNpH
 LR0aQ1Nk7P4ccXovgs9Axo/0H2uGcd7UsX/Xpm+E+i6QjmU4VOdzpdMV
X-Gm-Gg: ATEYQzz+Lr89qHy/twk0UPLpu1EYAECJiav59EKdvSB5YoEOaIoFGAya5bzV1dncwgo
 L2xCaneECDvUt4QTYWbsVl+8SV9rVeF9b60uRs7Yy1NwTHiKz7mRuGET1VDOAYsmaVIV3ZVGqKm
 DJzb+RDjFgAMSploGIf+bxEsW7XdnSyOxlD3/ozQXGa++HxX4XvyqHjFPwDYMTa8UCOh3lUsN8x
 SMflJxeuN2HVTg6THUAo2b3ODZVCDFluXHfX3LjPFyd3ZdP/UWgsfksCY4BTOFxHl7L97a1Yo6f
 w0vIQNCF7bUIDifK+gEC02z1NrvvLdeyes4A5BBcAx49+BBoY3iEhK6SVYQcsY+ZvQn6RywQvDs
 AWo4/bXdzsEfdrsvks6HSA3nhZK1UqGQnbzLWb+7AzmLjJeJzJtkM5K87/JgMEEbgE0zGd8LQ4d
 mynupMkjuXvOrkoGPmGbI20mRzPyzK++FuRsuTHzRA/9tIuK8xTHRyo7Q=
X-Received: by 2002:a05:600c:3ba0:b0:483:4b37:8620 with SMTP id
 5b1f17b1804b1-48513a74e6amr41669615e9.10.1772544568029; 
 Tue, 03 Mar 2026 05:29:28 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-483bd68826asm772625095e9.0.2026.03.03.05.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 05:29:27 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Harsha Vardhan V M <h-vm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Chen-Yu Tsai <wens@kernel.org>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 u-boot@lists.denx.de
Subject: [PATCH 2/5] misc: fs_loader: reorganize and split to FS and FW loader
Date: Tue,  3 Mar 2026 14:29:09 +0100
Message-ID: <20260303132916.5502-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303132916.5502-1-ansuelsmth@gmail.com>
References: <20260303132916.5502-1-ansuelsmth@gmail.com>
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

In preparation to the introduction of variant of the FS loader,
reorganize and split the driver to generic fw_loader function and
specific fs_loader function. Create a dedicated directory for the loader
and move the internal structs and functions to a dedicated header file.

This will permit to reuse all the property and logic of FS loader
with container that are not exactly a readable filesystem.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/Kconfig                     |   5 +
 drivers/misc/Makefile                    |   2 +-
 drivers/misc/fw_loader/Makefile          |   4 +
 drivers/misc/{ => fw_loader}/fs_loader.c | 134 ++---------------------
 drivers/misc/fw_loader/fw_loader.c       | 121 ++++++++++++++++++++
 drivers/misc/fw_loader/internal.h        |  60 ++++++++++
 include/fs_loader.h                      |  47 +-------
 include/fw_loader.h                      |  19 ++++
 8 files changed, 220 insertions(+), 172 deletions(-)
 create mode 100644 drivers/misc/fw_loader/Makefile
 rename drivers/misc/{ => fw_loader}/fs_loader.c (60%)
 create mode 100644 drivers/misc/fw_loader/fw_loader.c
 create mode 100644 drivers/misc/fw_loader/internal.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index a0aa290480eb..9d332230b1f9 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -610,8 +610,12 @@ config MPC83XX_SERDES
 	help
 	  Support for serdes found on MPC83xx SoCs.
 
+config FW_LOADER
+	bool
+
 config FS_LOADER
 	bool "Enable loader driver for file system"
+	select FW_LOADER
 	help
 	  This is file system generic loader which can be used to load
 	  the file image from the storage into target such as memory.
@@ -621,6 +625,7 @@ config FS_LOADER
 
 config SPL_FS_LOADER
 	bool "Enable loader driver for file system in SPL"
+	select FW_LOADER
 	depends on SPL
 	help
 	  This is file system generic loader which can be used to load
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 1d950f7a0ab2..c1b83d576bbb 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_FSL_DEVICE_DISABLE) += fsl_devdis.o
 obj-$(CONFIG_FSL_IFC) += fsl_ifc.o
 obj-$(CONFIG_FSL_IIM) += fsl_iim.o
 obj-$(CONFIG_FSL_SEC_MON) += fsl_sec_mon.o
-obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o
+obj-$(CONFIG_FW_LOADER) += fw_loader/
 obj-$(CONFIG_GATEWORKS_SC) += gsc.o
 obj-$(CONFIG_GDSYS_IOEP) += gdsys_ioep.o
 obj-$(CONFIG_GDSYS_RXAUI_CTRL) += gdsys_rxaui_ctrl.o
diff --git a/drivers/misc/fw_loader/Makefile b/drivers/misc/fw_loader/Makefile
new file mode 100644
index 000000000000..96baebede788
--- /dev/null
+++ b/drivers/misc/fw_loader/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y += fw_loader.o
+obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o
diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
similarity index 60%
rename from drivers/misc/fs_loader.c
rename to drivers/misc/fw_loader/fs_loader.c
index 7e432a7ebd62..4ae01b9c8f0d 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fw_loader/fs_loader.c
@@ -25,25 +25,9 @@
 #include <ubi_uboot.h>
 #endif
 
-DECLARE_GLOBAL_DATA_PTR;
+#include "internal.h"
 
-/**
- * struct firmware - A place for storing firmware and its attribute data.
- *
- * This holds information about a firmware and its content.
- *
- * @size: Size of a file
- * @data: Buffer for file
- * @priv: Firmware loader private fields
- * @name: Filename
- * @offset: Offset of reading a file
- */
-struct firmware {
-	size_t size;
-	const u8 *data;
-	const char *name;
-	u32 offset;
-};
+DECLARE_GLOBAL_DATA_PTR;
 
 #ifdef CONFIG_CMD_UBIFS
 static int mount_ubifs(char *mtdpart, char *ubivol)
@@ -109,37 +93,6 @@ static int select_fs_dev(struct device_plat *plat)
 	return ret;
 }
 
-/**
- * _request_firmware_prepare - Prepare firmware struct.
- *
- * @dev: An instance of a driver.
- * @name: Name of firmware file.
- * @dbuf: Address of buffer to load firmware into.
- * @size: Size of buffer.
- * @offset: Offset of a file for start reading into buffer.
- *
- * Return: Negative value if fail, 0 for successful.
- */
-static int _request_firmware_prepare(struct udevice *dev,
-				    const char *name, void *dbuf,
-				    size_t size, u32 offset)
-{
-	if (!name || name[0] == '\0')
-		return -EINVAL;
-
-	struct firmware *firmwarep = dev_get_priv(dev);
-
-	if (!firmwarep)
-		return -ENOMEM;
-
-	firmwarep->name = name;
-	firmwarep->offset = offset;
-	firmwarep->data = dbuf;
-	firmwarep->size = size;
-
-	return 0;
-}
-
 /**
  * fw_get_filesystem_firmware - load firmware into an allocated buffer.
  * @dev: An instance of a driver.
@@ -200,87 +153,16 @@ out:
 	return ret;
 }
 
-/**
- * request_firmware_into_buf - Load firmware into a previously allocated buffer.
- * @dev: An instance of a driver.
- * @name: Name of firmware file.
- * @buf: Address of buffer to load firmware into.
- * @size: Size of buffer.
- * @offset: Offset of a file for start reading into buffer.
- *
- * The firmware is loaded directly into the buffer pointed to by @buf.
- *
- * Return: Size of total read, negative value when error.
- */
-int request_firmware_into_buf(struct udevice *dev,
-			      const char *name,
-			      void *buf, size_t size, u32 offset)
-{
-	int ret;
-
-	if (!dev)
-		return -EINVAL;
-
-	ret = _request_firmware_prepare(dev, name, buf, size, offset);
-	if (ret < 0) /* error */
-		return ret;
-
-	ret = fw_get_filesystem_firmware(dev);
-
-	return ret;
-}
-
-static int fs_loader_of_to_plat(struct udevice *dev)
-{
-	u32 phandlepart[2];
-
-	ofnode fs_loader_node = dev_ofnode(dev);
-
-	if (ofnode_valid(fs_loader_node)) {
-		struct device_plat *plat;
-
-		plat = dev_get_plat(dev);
-		if (!ofnode_read_u32_array(fs_loader_node,
-					  "phandlepart",
-					  phandlepart, 2)) {
-			plat->phandlepart.phandle = phandlepart[0];
-			plat->phandlepart.partition = phandlepart[1];
-		}
-
-		plat->mtdpart = (char *)ofnode_read_string(
-				 fs_loader_node, "mtdpart");
-
-		plat->ubivol = (char *)ofnode_read_string(
-				 fs_loader_node, "ubivol");
-	}
-
-	return 0;
-}
-
 static int fs_loader_probe(struct udevice *dev)
 {
-#if CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(BLK)
-	int ret;
 	struct device_plat *plat = dev_get_plat(dev);
+	int ret;
 
-	if (plat->phandlepart.phandle) {
-		ofnode node = ofnode_get_by_phandle(plat->phandlepart.phandle);
-		struct udevice *parent_dev = NULL;
-
-		ret = device_get_global_by_ofnode(node, &parent_dev);
-		if (!ret) {
-			struct udevice *dev;
-
-			ret = blk_get_from_parent(parent_dev, &dev);
-			if (ret) {
-				debug("fs_loader: No block device: %d\n",
-					ret);
+	ret = generic_fw_loader_probe(dev);
+	if (ret)
+		return ret;
 
-				return ret;
-			}
-		}
-	}
-#endif
+	plat->get_firmware = fw_get_filesystem_firmware;
 
 	return 0;
 };
@@ -295,7 +177,7 @@ U_BOOT_DRIVER(fs_loader) = {
 	.id			= UCLASS_FS_FIRMWARE_LOADER,
 	.of_match		= fs_loader_ids,
 	.probe			= fs_loader_probe,
-	.of_to_plat	= fs_loader_of_to_plat,
+	.of_to_plat	= generic_fw_loader_of_to_plat,
 	.plat_auto	= sizeof(struct device_plat),
 	.priv_auto	= sizeof(struct firmware),
 };
diff --git a/drivers/misc/fw_loader/fw_loader.c b/drivers/misc/fw_loader/fw_loader.c
new file mode 100644
index 000000000000..6459ba23a15b
--- /dev/null
+++ b/drivers/misc/fw_loader/fw_loader.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
+ *
+ */
+
+#include <errno.h>
+#include <blk.h>
+#include <linux/types.h>
+#include <dm/device.h>
+#include <fw_loader.h>
+
+#include "internal.h"
+
+int generic_fw_loader_of_to_plat(struct udevice *dev)
+{
+	u32 phandlepart[2];
+
+	ofnode fw_loader_node = dev_ofnode(dev);
+
+	if (ofnode_valid(fw_loader_node)) {
+		struct device_plat *plat;
+
+		plat = dev_get_plat(dev);
+		if (!ofnode_read_u32_array(fw_loader_node,
+					   "phandlepart",
+					   phandlepart, 2)) {
+			plat->phandlepart.phandle = phandlepart[0];
+			plat->phandlepart.partition = phandlepart[1];
+		}
+
+		plat->mtdpart = (char *)ofnode_read_string(fw_loader_node,
+							   "mtdpart");
+
+		plat->ubivol = (char *)ofnode_read_string(fw_loader_node,
+							  "ubivol");
+	}
+
+	return 0;
+}
+
+int generic_fw_loader_probe(struct udevice *dev)
+{
+#if CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(BLK)
+	int ret;
+	struct device_plat *plat = dev_get_plat(dev);
+
+	if (plat->phandlepart.phandle) {
+		ofnode node = ofnode_get_by_phandle(plat->phandlepart.phandle);
+		struct udevice *parent_dev = NULL;
+
+		ret = device_get_global_by_ofnode(node, &parent_dev);
+		if (!ret) {
+			struct udevice *dev;
+
+			ret = blk_get_from_parent(parent_dev, &dev);
+			if (ret) {
+				debug("fw_loader: No block device: %d\n",
+				      ret);
+
+				return ret;
+			}
+		}
+	}
+#endif
+
+	return 0;
+}
+
+/**
+ * _request_firmware_prepare - Prepare firmware struct.
+ *
+ * @dev: An instance of a driver.
+ * @name: Name of firmware file.
+ * @dbuf: Address of buffer to load firmware into.
+ * @size: Size of buffer.
+ * @offset: Offset of a file for start reading into buffer.
+ *
+ * Return: Negative value if fail, 0 for successful.
+ */
+static int _request_firmware_prepare(struct udevice *dev,
+				     const char *name, void *dbuf,
+				     size_t size, u32 offset)
+{
+	if (!name || name[0] == '\0')
+		return -EINVAL;
+
+	struct firmware *firmwarep = dev_get_priv(dev);
+
+	if (!firmwarep)
+		return -ENOMEM;
+
+	firmwarep->name = name;
+	firmwarep->offset = offset;
+	firmwarep->data = dbuf;
+	firmwarep->size = size;
+
+	return 0;
+}
+
+int request_firmware_into_buf(struct udevice *dev,
+			      const char *name,
+			      void *buf, size_t size, u32 offset)
+{
+	struct device_plat *plat;
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	ret = _request_firmware_prepare(dev, name, buf, size, offset);
+	if (ret < 0) /* error */
+		return ret;
+
+	plat = dev_get_plat(dev);
+
+	if (!plat->get_firmware)
+		return -EOPNOTSUPP;
+
+	return plat->get_firmware(dev);
+}
diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
new file mode 100644
index 000000000000..fc78a4add59d
--- /dev/null
+++ b/drivers/misc/fw_loader/internal.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
+ */
+#ifndef _FW_LOADER_INTERNAL_H_
+#define _FW_LOADER_INTERNAL_H_
+
+/**
+ * struct phandle_part - A place for storing phandle of node and its partition
+ *
+ * This holds information about a phandle of the block device, and its
+ * partition where the firmware would be loaded from.
+ *
+ * @phandle: Phandle of storage device node
+ * @partition: Partition of block device
+ */
+struct phandle_part {
+	u32 phandle;
+	u32 partition;
+};
+
+/**
+ * struct phandle_part - A place for storing all supported storage devices
+ *
+ * This holds information about all supported storage devices for driver use.
+ *
+ * @phandlepart: Attribute data for block device.
+ * @mtdpart: MTD partition for ubi partition.
+ * @ubivol: UBI volume-name for ubifsmount.
+ */
+struct device_plat {
+	struct phandle_part phandlepart;
+	char *mtdpart;
+	char *ubivol;
+
+	int (*get_firmware)(struct udevice *dev);
+};
+
+/**
+ * struct firmware - A place for storing firmware and its attribute data.
+ *
+ * This holds information about a firmware and its content.
+ *
+ * @size: Size of a file
+ * @data: Buffer for file
+ * @priv: Firmware loader private fields
+ * @name: Filename
+ * @offset: Offset of reading a file
+ */
+struct firmware {
+	size_t size;
+	const u8 *data;
+	const char *name;
+	u32 offset;
+};
+
+int generic_fw_loader_probe(struct udevice *dev);
+int generic_fw_loader_of_to_plat(struct udevice *dev);
+
+#endif
diff --git a/include/fs_loader.h b/include/fs_loader.h
index 7e16e0f70309..3c64efe1b439 100644
--- a/include/fs_loader.h
+++ b/include/fs_loader.h
@@ -6,52 +6,9 @@
 #ifndef _FS_LOADER_H_
 #define _FS_LOADER_H_
 
-struct udevice;
-
-/**
- * struct phandle_part - A place for storing phandle of node and its partition
- *
- * This holds information about a phandle of the block device, and its
- * partition where the firmware would be loaded from.
- *
- * @phandle: Phandle of storage device node
- * @partition: Partition of block device
- */
-struct phandle_part {
-	u32 phandle;
-	u32 partition;
-};
-
-/**
- * struct phandle_part - A place for storing all supported storage devices
- *
- * This holds information about all supported storage devices for driver use.
- *
- * @phandlepart: Attribute data for block device.
- * @mtdpart: MTD partition for ubi partition.
- * @ubivol: UBI volume-name for ubifsmount.
- */
-struct device_plat {
-	struct phandle_part phandlepart;
-	char *mtdpart;
-	char *ubivol;
-};
+#include <fw_loader.h>
 
-/**
- * request_firmware_into_buf - Load firmware into a previously allocated buffer.
- * @dev: An instance of a driver.
- * @name: Name of firmware file.
- * @buf: Address of buffer to load firmware into.
- * @size: Size of buffer.
- * @offset: Offset of a file for start reading into buffer.
- *
- * The firmware is loaded directly into the buffer pointed to by @buf.
- *
- * Return: Size of total read, negative value when error.
- */
-int request_firmware_into_buf(struct udevice *dev,
-			      const char *name,
-			      void *buf, size_t size, u32 offset);
+struct udevice;
 
 /**
  * get_fs_loader() - Get the chosen filesystem loader
diff --git a/include/fw_loader.h b/include/fw_loader.h
index 35574482b2b9..56f5e3be6195 100644
--- a/include/fw_loader.h
+++ b/include/fw_loader.h
@@ -1,10 +1,29 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
  * Copyright (C) 2025 Lucien Jheng <lucienzx159@gmail.com>
  */
 #ifndef _FW_LOADER_H_
 #define _FW_LOADER_H_
 
+struct udevice;
+
+/**
+ * request_firmware_into_buf - Load firmware into a previously allocated buffer.
+ * @dev: An instance of a driver.
+ * @name: Name of firmware file.
+ * @buf: Address of buffer to load firmware into.
+ * @size: Size of buffer.
+ * @offset: Offset of a file for start reading into buffer.
+ *
+ * The firmware is loaded directly into the buffer pointed to by @buf.
+ *
+ * Return: Size of total read, negative value when error.
+ */
+int request_firmware_into_buf(struct udevice *dev,
+			      const char *name,
+			      void *buf, size_t size, u32 offset);
+
 /**
  * request_firmware_into_buf_via_script() -
  * Load firmware using a U-Boot script and copy to buffer
-- 
2.51.0

