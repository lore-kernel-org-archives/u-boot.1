Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF7FEA3C4E
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1E0D84198;
	Thu,  9 Apr 2026 15:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gnJ6Plcj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1308384198; Thu,  9 Apr 2026 15:33:25 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 854FE8414B
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 15:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b0046078so9822995e9.1
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 06:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775741602; x=1776346402; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XPT2Y0qazd2UuWADhhKiUUlwa+WZ1JjO9WZObS3sdz8=;
 b=gnJ6Plcj2nqadJmiI8ZUjNHBPmF/7R7W2qAAUWenOzbdz9c4Da0dUhN62o43omj0zW
 xZk2rKuxSuEnLm2cSHG6DRBVTHIZMR9JrutfhOHPMFCWbLVCqx3+tRgO8TjazH/tkROB
 mVU3/EpROaqiO66/oWMiK36uUELYf6kbSc/IePKzMyVlymq/8XEvhA8jny8Qa+TXDmL+
 a4a0Lo8m3oSOD31JatApaz0PKdgsxPoHP7Xzb/NwhIKt0LRfoVcK2OnGbDscZf8UVZ/q
 WrUAaX4tZrM62rtzSxf1+tq5zT6xgY5XznRs25Fn6x1aJIRtaYV1/KoG+zTKaYogDO0z
 T0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775741602; x=1776346402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XPT2Y0qazd2UuWADhhKiUUlwa+WZ1JjO9WZObS3sdz8=;
 b=hXUySMmi6M/q6GFyp/TcmrgKWuHRi6NukfLV4AzpdaROq/VdrPfoM6M4/dpCIJOjbF
 4OWIJCxf/RZezdS0gcHO3RzGBbyElD4fSe88R1gnKFsgcEl/mLAnfiExFNex7m5eNvIN
 As2BhNOtMynraONywLjhV/oDwY3REvcSLKecKntf6Lc9uGg6p79fvzAiQlJG0ayctIrM
 WuBd3dkgykn45Mw7NJKL0SlSeC+M3fZk9RP4Br6emyb6mX09xNIgtc413klQfAVogWRl
 aecCCRjKKzfTb9juZMBkQP8KQlvagxCdRRMth372GuZxJI1mr4D8bmTvFC7jBlibMURR
 P13Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBYbPHKXowj3LwGWJy8cE1RmEty0xbVAx1HLz6XJIUU9V6JjUvn0LJY5V9A0r07HM9rrUNKNs=@lists.denx.de
X-Gm-Message-State: AOJu0Yykf8QM6b0Vvdq7+s42sSr2uyNLMXo/63AeOjclHZwROp5uHDQb
 NqTF3sY73lLi8r+ARsP3oqefwh1VGkUDcI0+N0RyfvdJ6dDOU6oXZhtC
X-Gm-Gg: AeBDietaogUg41wtt6BOBisod60fXEgosEjYBT4FlEX+9qVPYoe+L3xYZWLcIj0zDlR
 DO/o2XFqJBtLOuT6cFmoj1XDMReRg+9UMgYO7U671vTODykz3WFa2o0UjmQh7CbRD7N3VissO9E
 4O6oS5wQY/RdUflRe8/JgfINpHnbUB3e409IJdvUe3SfTZPwEHM+W5G1CBa+79vaiT44JZGJR9a
 ONuF0TzMkpcvqYy0lSWDNfheJNQQVKI99Zbng+/4PlBweqNI1TnhEfluDPPzt80Uz0ql9x3DEMR
 jLH6WdFxvVwoQ8ocVu6mmcct/SLvxOdRmxfwHlZdbvl8DLgDPem6/LFOY6JfX6ffbiJSgGEzpp2
 DcZPLyEA7bNHG1UK+Hm15xPtezB9qy4dB/E2WrP0ESFUgmMp4CoFhUQDp/HqLzvS7Ho73in60Nj
 zrm5sMT3Puoaqsa1K1iDFxjDGS1EpLmFPLsPN+l6PEAxS5o5gjjfuzPQesMfAJKd+LkG9Wfew8n
 BTiXfp7iw==
X-Received: by 2002:a05:600c:3b23:b0:485:17a7:b9c7 with SMTP id
 5b1f17b1804b1-488996ecd50mr328962855e9.10.1775741601490; 
 Thu, 09 Apr 2026 06:33:21 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-61-192-155.retail.telecomitalia.it.
 [82.61.192.155]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-488ccf9b919sm52876215e9.0.2026.04.09.06.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 06:33:21 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v6 2/6] misc: fs_loader: reorganize and split to FS loader and
 FW UCLASS
Date: Thu,  9 Apr 2026 15:32:58 +0200
Message-ID: <20260409133303.31875-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409133303.31875-1-ansuelsmth@gmail.com>
References: <20260409133303.31875-1-ansuelsmth@gmail.com>
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
reorganize and split the driver to generic fw_loader UCLASS and
specific fs_loader function. Create a dedicated directory for the loader
and move the internal structs and functions to a dedicated header file.
While at it also drop some redundant check and rename some variables as we
are updating the code for the UCLASS rework.

This will permit to reuse all the property and logic of FS loader
with container that are not exactly a readable filesystem.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/Kconfig                      |   5 +
 drivers/misc/Makefile                     |   2 +-
 drivers/misc/fs_loader.c                  | 328 ----------------------
 drivers/misc/fw_loader/Makefile           |   4 +
 drivers/misc/fw_loader/fs_loader.c        | 186 ++++++++++++
 drivers/misc/fw_loader/fw_loader-uclass.c | 147 ++++++++++
 drivers/misc/fw_loader/internal.h         |  73 +++++
 include/dm/uclass-id.h                    |   2 +-
 include/fs_loader.h                       |  47 +---
 include/fw_loader.h                       |  19 ++
 10 files changed, 438 insertions(+), 375 deletions(-)
 delete mode 100644 drivers/misc/fs_loader.c
 create mode 100644 drivers/misc/fw_loader/Makefile
 create mode 100644 drivers/misc/fw_loader/fs_loader.c
 create mode 100644 drivers/misc/fw_loader/fw_loader-uclass.c
 create mode 100644 drivers/misc/fw_loader/internal.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index b2dfc7f5b663..9b181339c468 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -612,8 +612,12 @@ config MPC83XX_SERDES
 	help
 	  Support for serdes found on MPC83xx SoCs.
 
+config FW_LOADER_UCLASS
+	bool
+
 config FS_LOADER
 	bool "Enable loader driver for file system"
+	select FW_LOADER_UCLASS
 	help
 	  This is file system generic loader which can be used to load
 	  the file image from the storage into target such as memory.
@@ -623,6 +627,7 @@ config FS_LOADER
 
 config SPL_FS_LOADER
 	bool "Enable loader driver for file system in SPL"
+	select FW_LOADER_UCLASS
 	depends on SPL
 	help
 	  This is file system generic loader which can be used to load
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e2170212e5ad..5a3e368767c2 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_FSL_DEVICE_DISABLE) += fsl_devdis.o
 obj-$(CONFIG_FSL_IFC) += fsl_ifc.o
 obj-$(CONFIG_FSL_IIM) += fsl_iim.o
 obj-$(CONFIG_FSL_SEC_MON) += fsl_sec_mon.o
-obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o
+obj-$(CONFIG_FW_LOADER_UCLASS) += fw_loader/
 obj-$(CONFIG_GATEWORKS_SC) += gsc.o
 obj-$(CONFIG_GDSYS_IOEP) += gdsys_ioep.o
 obj-$(CONFIG_GDSYS_RXAUI_CTRL) += gdsys_rxaui_ctrl.o
diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
deleted file mode 100644
index cd4695b08eea..000000000000
--- a/drivers/misc/fs_loader.c
+++ /dev/null
@@ -1,328 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
- /*
- * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
- *
- */
-
-#define LOG_CATEGORY UCLASS_FS_FIRMWARE_LOADER
-
-#include <dm.h>
-#include <env.h>
-#include <errno.h>
-#include <blk.h>
-#include <fs.h>
-#include <fs_loader.h>
-#include <log.h>
-#include <dm/device-internal.h>
-#include <dm/root.h>
-#include <linux/string.h>
-#include <mapmem.h>
-#include <malloc.h>
-#include <spl.h>
-
-#ifdef CONFIG_CMD_UBIFS
-#include <ubi_uboot.h>
-#endif
-
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
-
-#ifdef CONFIG_CMD_UBIFS
-static int mount_ubifs(char *mtdpart, char *ubivol)
-{
-	int ret = ubi_part(mtdpart, NULL);
-
-	if (ret) {
-		debug("Cannot find mtd partition %s\n", mtdpart);
-		return ret;
-	}
-
-	return cmd_ubifs_mount(ubivol);
-}
-
-static int umount_ubifs(void)
-{
-	return cmd_ubifs_umount();
-}
-#else
-static int mount_ubifs(char *mtdpart, char *ubivol)
-{
-	debug("Error: Cannot load image: no UBIFS support\n");
-	return -ENOSYS;
-}
-#endif
-
-static int select_fs_dev(struct device_plat *plat)
-{
-	int ret;
-
-	if (plat->phandlepart.phandle) {
-		ofnode node;
-
-		node = ofnode_get_by_phandle(plat->phandlepart.phandle);
-
-		struct udevice *dev;
-
-		ret = device_get_global_by_ofnode(node, &dev);
-		if (!ret) {
-			struct blk_desc *desc = blk_get_by_device(dev);
-			if (desc) {
-				ret = fs_set_blk_dev_with_part(desc,
-					plat->phandlepart.partition);
-			} else {
-				debug("%s: No device found\n", __func__);
-				return -ENODEV;
-			}
-		}
-	} else if (plat->mtdpart && plat->ubivol) {
-		ret = mount_ubifs(plat->mtdpart, plat->ubivol);
-		if (ret)
-			return ret;
-
-		ret = fs_set_blk_dev("ubi", NULL, FS_TYPE_UBIFS);
-	} else {
-		debug("Error: unsupported storage device.\n");
-		return -ENODEV;
-	}
-
-	if (ret)
-		debug("Error: could not access storage.\n");
-
-	return ret;
-}
-
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
-/**
- * fw_get_filesystem_firmware - load firmware into an allocated buffer.
- * @dev: An instance of a driver.
- *
- * Return: Size of total read, negative value when error.
- */
-static int fw_get_filesystem_firmware(struct udevice *dev)
-{
-	loff_t actread = 0;
-	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
-	int ret;
-
-	storage_interface = env_get("storage_interface");
-	dev_part = env_get("fw_dev_part");
-	ubi_mtdpart = env_get("fw_ubi_mtdpart");
-	ubi_volume = env_get("fw_ubi_volume");
-
-	if (storage_interface && dev_part) {
-		ret = fs_set_blk_dev(storage_interface, dev_part, FS_TYPE_ANY);
-	} else if (storage_interface && ubi_mtdpart && ubi_volume) {
-		ret = mount_ubifs(ubi_mtdpart, ubi_volume);
-		if (ret)
-			return ret;
-
-		if (!strcmp("ubi", storage_interface))
-			ret = fs_set_blk_dev(storage_interface, NULL,
-				FS_TYPE_UBIFS);
-		else
-			ret = -ENODEV;
-	} else {
-		ret = select_fs_dev(dev_get_plat(dev));
-	}
-
-	if (ret)
-		goto out;
-
-	struct firmware *firmwarep = dev_get_priv(dev);
-
-	if (!firmwarep) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = fs_read(firmwarep->name, (ulong)map_to_sysmem(firmwarep->data),
-			firmwarep->offset, firmwarep->size, &actread);
-
-	if (ret) {
-		debug("Error: %d Failed to read %s from flash %lld != %zu.\n",
-		      ret, firmwarep->name, actread, firmwarep->size);
-	} else {
-		ret = actread;
-	}
-
-out:
-#ifdef CONFIG_CMD_UBIFS
-	umount_ubifs();
-#endif
-	return ret;
-}
-
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
-static int fs_loader_probe(struct udevice *dev)
-{
-#if CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(BLK)
-	int ret;
-	struct device_plat *plat = dev_get_plat(dev);
-
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
-
-				return ret;
-			}
-		}
-	}
-#endif
-
-	return 0;
-};
-
-static const struct udevice_id fs_loader_ids[] = {
-	{ .compatible = "u-boot,fs-loader"},
-	{ }
-};
-
-U_BOOT_DRIVER(fs_loader) = {
-	.name			= "fs-loader",
-	.id			= UCLASS_FS_FIRMWARE_LOADER,
-	.of_match		= fs_loader_ids,
-	.probe			= fs_loader_probe,
-	.of_to_plat	= fs_loader_of_to_plat,
-	.plat_auto	= sizeof(struct device_plat),
-	.priv_auto	= sizeof(struct firmware),
-};
-
-static struct device_plat default_plat = { 0 };
-
-int get_fs_loader(struct udevice **dev)
-{
-	int ret;
-	ofnode node = ofnode_get_chosen_node("firmware-loader");
-
-	if (ofnode_valid(node))
-		return uclass_get_device_by_ofnode(UCLASS_FS_FIRMWARE_LOADER,
-						   node, dev);
-
-	/* Try the first device if none was chosen */
-	ret = uclass_first_device_err(UCLASS_FS_FIRMWARE_LOADER, dev);
-	if (ret != -ENODEV)
-		return ret;
-
-	/* Just create a new device */
-	ret = device_bind(dm_root(), DM_DRIVER_REF(fs_loader), "default-loader",
-			  &default_plat, ofnode_null(), dev);
-	if (ret)
-		return ret;
-
-	return device_probe(*dev);
-}
-
-UCLASS_DRIVER(fs_loader) = {
-	.id		= UCLASS_FS_FIRMWARE_LOADER,
-	.name		= "fs-loader",
-};
diff --git a/drivers/misc/fw_loader/Makefile b/drivers/misc/fw_loader/Makefile
new file mode 100644
index 000000000000..3d5e9f5b338e
--- /dev/null
+++ b/drivers/misc/fw_loader/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y += fw_loader-uclass.o
+obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o
diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
new file mode 100644
index 000000000000..2694111d8396
--- /dev/null
+++ b/drivers/misc/fw_loader/fs_loader.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
+ *
+ */
+
+#define LOG_CATEGORY UCLASS_FIRMWARE_LOADER
+
+#include <dm.h>
+#include <env.h>
+#include <errno.h>
+#include <blk.h>
+#include <fs.h>
+#include <fs_loader.h>
+#include <log.h>
+#include <dm/device-internal.h>
+#include <dm/root.h>
+#include <linux/string.h>
+#include <mapmem.h>
+#include <malloc.h>
+#include <spl.h>
+
+#ifdef CONFIG_CMD_UBIFS
+#include <ubi_uboot.h>
+#endif
+
+#include "internal.h"
+
+#ifdef CONFIG_CMD_UBIFS
+static int mount_ubifs(char *mtdpart, char *ubivol)
+{
+	int ret;
+
+	ret = generic_fw_loader_ubi_select(mtdpart);
+	if (ret)
+		return ret;
+
+	return cmd_ubifs_mount(ubivol);
+}
+
+static int umount_ubifs(void)
+{
+	return cmd_ubifs_umount();
+}
+#else
+static int mount_ubifs(char *mtdpart, char *ubivol)
+{
+	debug("Error: Cannot load image: no UBIFS support\n");
+	return -ENOSYS;
+}
+#endif
+
+static int select_fs_dev(struct device_plat *plat)
+{
+	int ret;
+
+	if (plat->phandlepart.phandle) {
+		ofnode node;
+
+		node = ofnode_get_by_phandle(plat->phandlepart.phandle);
+
+		struct udevice *dev;
+
+		ret = device_get_global_by_ofnode(node, &dev);
+		if (!ret) {
+			struct blk_desc *desc = blk_get_by_device(dev);
+			if (desc) {
+				ret = fs_set_blk_dev_with_part(desc,
+					plat->phandlepart.partition);
+			} else {
+				debug("%s: No device found\n", __func__);
+				return -ENODEV;
+			}
+		}
+	} else if (plat->mtdpart && plat->ubivol) {
+		ret = mount_ubifs(plat->mtdpart, plat->ubivol);
+		if (ret)
+			return ret;
+
+		ret = fs_set_blk_dev("ubi", NULL, FS_TYPE_UBIFS);
+	} else {
+		debug("Error: unsupported storage device.\n");
+		return -ENODEV;
+	}
+
+	if (ret)
+		debug("Error: could not access storage.\n");
+
+	return ret;
+}
+
+/**
+ * fw_get_filesystem_firmware - load firmware into an allocated buffer.
+ * @dev: An instance of a driver.
+ *
+ * Return: Size of total read, negative value when error.
+ */
+static int fw_get_filesystem_firmware(struct udevice *dev)
+{
+	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
+	struct firmware *upriv = dev_get_uclass_priv(dev);
+	struct device_plat *plat = dev_get_uclass_plat(dev);
+	loff_t actread = 0;
+	int ret;
+
+	storage_interface = env_get("storage_interface");
+	dev_part = env_get("fw_dev_part");
+	ubi_mtdpart = env_get("fw_ubi_mtdpart");
+	ubi_volume = env_get("fw_ubi_volume");
+
+	if (storage_interface && dev_part) {
+		ret = fs_set_blk_dev(storage_interface, dev_part, FS_TYPE_ANY);
+	} else if (storage_interface && ubi_mtdpart && ubi_volume) {
+		ret = mount_ubifs(ubi_mtdpart, ubi_volume);
+		if (ret)
+			return ret;
+
+		if (!strcmp("ubi", storage_interface))
+			ret = fs_set_blk_dev(storage_interface, NULL,
+					     FS_TYPE_UBIFS);
+		else
+			ret = -ENODEV;
+	} else {
+		ret = select_fs_dev(plat);
+	}
+
+	if (ret)
+		goto out;
+
+	ret = fs_read(upriv->name, (ulong)map_to_sysmem(upriv->data),
+		      upriv->offset, upriv->size, &actread);
+
+	if (ret) {
+		debug("Error: %d Failed to read %s from flash %lld != %zu.\n",
+		      ret, upriv->name, actread, upriv->size);
+	} else {
+		ret = actread;
+	}
+
+out:
+#ifdef CONFIG_CMD_UBIFS
+	umount_ubifs();
+#endif
+	return ret;
+}
+
+static const struct fw_loader_ops fs_loader_ops = {
+	.get_firmware = fw_get_filesystem_firmware,
+};
+
+static const struct udevice_id fs_loader_ids[] = {
+	{ .compatible = "u-boot,fs-loader"},
+	{ }
+};
+
+U_BOOT_DRIVER(fs_loader) = {
+	.name			= "fs-loader",
+	.id			= UCLASS_FIRMWARE_LOADER,
+	.of_match		= fs_loader_ids,
+	.ops			= &fs_loader_ops,
+};
+
+static struct device_plat default_plat = { 0 };
+
+int get_fs_loader(struct udevice **dev)
+{
+	int ret;
+	ofnode node = ofnode_get_chosen_node("firmware-loader");
+
+	if (ofnode_valid(node))
+		return uclass_get_device_by_ofnode(UCLASS_FIRMWARE_LOADER,
+						   node, dev);
+
+	/* Try the first device if none was chosen */
+	ret = uclass_first_device_err(UCLASS_FIRMWARE_LOADER, dev);
+	if (ret != -ENODEV)
+		return ret;
+
+	/* Just create a new device */
+	ret = device_bind(dm_root(), DM_DRIVER_REF(fs_loader), "default-loader",
+			  &default_plat, ofnode_null(), dev);
+	if (ret)
+		return ret;
+
+	return device_probe(*dev);
+}
diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
new file mode 100644
index 000000000000..16a1fe2d4a65
--- /dev/null
+++ b/drivers/misc/fw_loader/fw_loader-uclass.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
+ *
+ */
+
+#include <errno.h>
+#include <blk.h>
+#include <linux/types.h>
+#include <dm.h>
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
+static int fw_loader_pre_probe(struct udevice *dev)
+{
+	struct device_plat *plat = dev_get_uclass_plat(dev);
+	ofnode fw_loader_node;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_DM))
+		return 0;
+
+	fw_loader_node = dev_ofnode(dev);
+	if (ofnode_valid(fw_loader_node)) {
+		u32 phandlepart[2];
+
+		if (!ofnode_read_u32_array(fw_loader_node, "phandlepart",
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
+	if (plat->phandlepart.phandle) {
+		ofnode node = ofnode_get_by_phandle(plat->phandlepart.phandle);
+		struct udevice *parent_dev = NULL;
+
+		if (!IS_ENABLED(CONFIG_BLK)) {
+			debug("fw_loader: No block device support\n");
+			return -EINVAL;
+		}
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
+
+	return 0;
+}
+
+UCLASS_DRIVER(fw_loader) = {
+	.id		= UCLASS_FIRMWARE_LOADER,
+	.name		= "fw_loader",
+	.pre_probe	= fw_loader_pre_probe,
+	.per_device_plat_auto = sizeof(struct device_plat),
+	.per_device_auto = sizeof(struct firmware),
+};
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
+	struct firmware *upriv = dev_get_uclass_priv(dev);
+
+	if (!name || name[0] == '\0')
+		return -EINVAL;
+
+	upriv->name = name;
+	upriv->offset = offset;
+	upriv->data = dbuf;
+	upriv->size = size;
+
+	return 0;
+}
+
+int request_firmware_into_buf(struct udevice *dev,
+			      const char *name,
+			      void *buf, size_t size, u32 offset)
+{
+	struct fw_loader_ops *ops;
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	ret = _request_firmware_prepare(dev, name, buf, size, offset);
+	if (ret < 0) /* error */
+		return ret;
+
+	ops = fw_loader_get_ops(dev);
+
+	if (!ops->get_firmware)
+		return -EOPNOTSUPP;
+
+	return ops->get_firmware(dev);
+}
diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
new file mode 100644
index 000000000000..2f93d0c706b6
--- /dev/null
+++ b/drivers/misc/fw_loader/internal.h
@@ -0,0 +1,73 @@
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
+ * struct fw_loader_ops - driver operations for Firmware Loader uclass
+ *
+ * Drivers MUST support these operation. These operations are intended
+ * to be used by uclass code, not directly from other code.
+ */
+struct fw_loader_ops {
+	/**
+	 * get_firmware() - get firmware from Firmware Loader driver
+	 *
+	 * @dev:	Firmware Loader device to read firmware from
+	 */
+	int (*get_firmware)(struct udevice *dev);
+};
+
+#define fw_loader_get_ops(dev)	((struct fw_loader_ops *)(dev)->driver->ops)
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
+};
+
+/**
+ * struct firmware - A place for storing firmware and its attribute data.
+ *
+ * This holds information about a firmware and its content.
+ *
+ * @size: Size of a file
+ * @data: Buffer for file
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
+
+#endif
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 36b5d87c304f..5ef3138e6ac7 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -69,7 +69,7 @@ enum uclass_id {
 	UCLASS_FIRMWARE,	/* Firmware */
 	UCLASS_FPGA,		/* FPGA device */
 	UCLASS_FUZZING_ENGINE,	/* Fuzzing engine */
-	UCLASS_FS_FIRMWARE_LOADER,		/* Generic loader */
+	UCLASS_FIRMWARE_LOADER,	/* Firmware loader */
 	UCLASS_FWU_MDATA,	/* FWU Metadata Access */
 	UCLASS_GPIO,		/* Bank of general-purpose I/O pins */
 	UCLASS_HASH,		/* Hash device */
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

