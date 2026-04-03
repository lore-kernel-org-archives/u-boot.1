Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA3BE8536E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 13:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 070EA840D8;
	Fri,  3 Apr 2026 15:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pIetrC18";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0E31840D8; Fri,  3 Apr 2026 15:52:22 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B1E783642
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 15:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4887ca8e529so14799935e9.0
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 06:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775224340; x=1775829140; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z6Mrxc0p1neQThInt5c2sOaPmu9EcfhZTo/VHna9oN8=;
 b=pIetrC18HgAcjeDaA3VD/6u6zSoHdl8tOHnf6vgU5nUidzyBrW2XIq/cudQEVh657h
 YfxONNY10wRHkrCfhVkSrAJjQuABx2r5tL2zfVxcH8ap4sPyshpwVwIPicLL813Sasn4
 FIBuEvRw1YfpHXpNYYu7sTtVDuVcRKqJrXtFpweVNgiACLgiI6QdfdufWWARUII27jF7
 KIPXCRvIVvYuorkmLWIpHPS9NPexZwSXQbfz4SCeqRXfWLA6MebLjH76oHLtlj8yCsrC
 BFBHfjUGTmIAWso+LbbhxgJoDCJtTlpv3dX7Wh32/tPHFdU8XNAI9o55xaPjTs4XhLGp
 jCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775224340; x=1775829140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z6Mrxc0p1neQThInt5c2sOaPmu9EcfhZTo/VHna9oN8=;
 b=KEa7kBkHrUjQ2snunpwrUm6RvXqL54QovX++69lvBLF3Il5tEsGXWv2onAUGy6fj46
 t3RPFkxM6xfCnJuKMXZU91Gt2ef6prmI3M+7ZjqZ/1xN5+zlo5i/X7snte87iz7VzSD6
 ldHCMYzPhVuOVjBW2udWEkJxwuJN0gDVGG0sqwk6or/UoEVLsa0dqiijDMM33e307Fru
 6qLmdk2Bjs2sJUv+O7RVk0nOt7yfG5+DPZZtOU67akm+ywf5WVwt7oJQ2S0IBGqwLZyW
 dX5pyyafJHtodtbDj+y3sNeP+rPnl1cyHemnauFExu3EujeA+NFFZYtVcC8inFKkbeQZ
 WYjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0RdtSe+xU6QDXaER0iHK2jrlrziKMov0BEjbw/q4guZp0x49Id8UtluY4XRmlNTWa9XUEMnE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4gRUpFmRLEiJLK//+hDNWj+bdvaEYZvITz7Fci9/sLGJq6un9
 +tFVEEX6A86+Q6yDuLnLKbiquJy69bafB7ISwuCcf4UOQbPeKq8+oRZd
X-Gm-Gg: ATEYQzwB6kGpYgYKNMX39u1bnN/h0bdVzE/Q+1sJPG6ykxcSNKtIKzkrt/GA24yi7cw
 QZWab9/Dhp4Z6fF3IKQ+AkQdgY50mNvT/jcMBwXgF1p1WS9pkMEV9RAbSRNZaa6YilvqwPXMbaP
 dBYM6rMdrDxfMSpmF5b5mZ4Xk+sXEwEWg1E7BBmDesKCVMxlwlDRld179qAcH4aSSE3N6oACkI/
 FXd4qMaBWfzamOU4dlEsEmBHYl5fHhsSXeVJdX1mc/NNZWhve35DAlRTyYDEKkB+zlUTliQJr2j
 S4InhpNOTDsb3Tc4xvmO4vNOBbThzWuEJhdpTDV4mHz7UBB7k17WLpTHZI04fqWQ0sr2QUoSsKF
 QSxHHCnQVP0zQJhFCxOBbNOrcsU1NpSTXEJhKYqtg0FV0kJKbuAR1L7cGPsyg8/tmylfsYg+MWy
 GDnM5Ns9kzJhpaVVuMZTIQn40=
X-Received: by 2002:a05:600c:4f87:b0:486:faa8:9e4 with SMTP id
 5b1f17b1804b1-488994a77b1mr48255645e9.12.1775224339521; 
 Fri, 03 Apr 2026 06:52:19 -0700 (PDT)
Received: from Ansuel-XPS24 ([217.202.87.54])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4888a7162cesm196732895e9.13.2026.04.03.06.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 06:52:19 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Harsha Vardhan V M <h-vm@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v5 2/6] misc: fs_loader: reorganize and split to FS and FW
 loader
Date: Fri,  3 Apr 2026 15:51:59 +0200
Message-ID: <20260403135205.26979-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403135205.26979-1-ansuelsmth@gmail.com>
References: <20260403135205.26979-1-ansuelsmth@gmail.com>
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
 drivers/misc/{ => fw_loader}/fs_loader.c | 141 ++--------------------
 drivers/misc/fw_loader/fw_loader.c       | 144 +++++++++++++++++++++++
 drivers/misc/fw_loader/internal.h        |  61 ++++++++++
 include/fs_loader.h                      |  47 +-------
 include/fw_loader.h                      |  19 +++
 8 files changed, 247 insertions(+), 176 deletions(-)
 create mode 100644 drivers/misc/fw_loader/Makefile
 rename drivers/misc/{ => fw_loader}/fs_loader.c (58%)
 create mode 100644 drivers/misc/fw_loader/fw_loader.c
 create mode 100644 drivers/misc/fw_loader/internal.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index b2dfc7f5b663..58f1a4c07ff5 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -612,8 +612,12 @@ config MPC83XX_SERDES
 	help
 	  Support for serdes found on MPC83xx SoCs.
 
+config FW_LOADER_LIB
+	bool
+
 config FS_LOADER
 	bool "Enable loader driver for file system"
+	select FW_LOADER_DRV
 	help
 	  This is file system generic loader which can be used to load
 	  the file image from the storage into target such as memory.
@@ -623,6 +627,7 @@ config FS_LOADER
 
 config SPL_FS_LOADER
 	bool "Enable loader driver for file system in SPL"
+	select FW_LOADER_DRV
 	depends on SPL
 	help
 	  This is file system generic loader which can be used to load
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e2170212e5ad..b514d1351ca5 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_FSL_DEVICE_DISABLE) += fsl_devdis.o
 obj-$(CONFIG_FSL_IFC) += fsl_ifc.o
 obj-$(CONFIG_FSL_IIM) += fsl_iim.o
 obj-$(CONFIG_FSL_SEC_MON) += fsl_sec_mon.o
-obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o
+obj-$(CONFIG_FW_LOADER_DRV) += fw_loader/
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
similarity index 58%
rename from drivers/misc/fs_loader.c
rename to drivers/misc/fw_loader/fs_loader.c
index cd4695b08eea..2748d9f041e8 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fw_loader/fs_loader.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
- /*
+/*
  * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
  *
  */
@@ -24,33 +24,16 @@
 #include <ubi_uboot.h>
 #endif
 
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
+#include "internal.h"
 
 #ifdef CONFIG_CMD_UBIFS
 static int mount_ubifs(char *mtdpart, char *ubivol)
 {
-	int ret = ubi_part(mtdpart, NULL);
+	int ret;
 
-	if (ret) {
-		debug("Cannot find mtd partition %s\n", mtdpart);
+	ret = generic_fw_loader_ubi_select(mtdpart);
+	if (ret)
 		return ret;
-	}
 
 	return cmd_ubifs_mount(ubivol);
 }
@@ -106,37 +89,6 @@ static int select_fs_dev(struct device_plat *plat)
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
@@ -197,87 +149,16 @@ out:
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
@@ -292,7 +173,7 @@ U_BOOT_DRIVER(fs_loader) = {
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
index 000000000000..644b98de9f6c
--- /dev/null
+++ b/drivers/misc/fw_loader/fw_loader.c
@@ -0,0 +1,144 @@
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
+#ifdef CONFIG_CMD_UBIFS
+#include <ubi_uboot.h>
+#endif
+
+#include "internal.h"
+
+#ifdef CONFIG_CMD_UBIFS
+int generic_fw_loader_ubi_select(char *mtdpart)
+{
+	int ret;
+
+	ret = ubi_part(mtdpart, NULL);
+	if (ret)
+		debug("Cannot find mtd partition %s\n", mtdpart);
+
+	return ret;
+}
+#else
+int generic_fw_loader_ubi_select(char *mtdpart)
+{
+	debug("Error: Cannot select ubi partition: no UBIFS support\n");
+	return -ENOSYS;
+}
+#endif
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
+			struct udevice *blk_dev;
+
+			ret = blk_get_from_parent(parent_dev, &blk_dev);
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
index 000000000000..fa006b7e6077
--- /dev/null
+++ b/drivers/misc/fw_loader/internal.h
@@ -0,0 +1,61 @@
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
+ * struct device_plat - A place for storing all supported storage devices
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
+int generic_fw_loader_ubi_select(char *mtdpart);
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
2.53.0

