Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CF0C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 20:28:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F5EF8311B;
	Tue, 15 Jul 2025 22:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="GmOmijOI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14CAE830C8; Tue, 15 Jul 2025 21:11:25 +0200 (CEST)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6645B830B5
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 21:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ariel.dalessandro@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752606679; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AGUxzr7G5YQgCfbsvxqzZF8FeSAmXBy3BBXgJt3SAyYyfKymsMsfF4ZrHYb7VsenoFFRR2Z6fNu754lotYaegdg76Jrlofdibs4zWuHxsfH1t2xyKkb7t0PeMp+TZ4OrCWSa1fIL7DahUPWbaer6u0gB5+kkSL6lv/ION9WBnwA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1752606679;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Kjv64YRQqrzdgEwCYF9u/xU7VuOBcI1JleBR+d/Z2Uc=; 
 b=Chuvvm2GEDQkydgTgldo3qJLie/rOac+cru/mDi0XQY6aBMf1HsJK2mQTr0onYhcwApRK2SiIl+gMvVzblwAJ7MGbxCasJ97c3A2LllPGf4lz8FhAM7qIP1SoMVd5xqFK1wK+3oUaeAxJQuRBvIShzTpszgZsPb8/bE+RptdHF4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
 dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752606679; 
 s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Kjv64YRQqrzdgEwCYF9u/xU7VuOBcI1JleBR+d/Z2Uc=;
 b=GmOmijOIDlWRjTS+k8VdmUnOg/bJ4sdOgxDAR5iJ9neeAwzgk5GRCrkBuLgJ09W8
 iy3Igm1O/AYFh/OrjSeNTDsUJ9yS7EH138khP2mXakg93ewGbelrejroBS+2RUk74R3
 KmUi/cK0CuITUZO3psRz+TJo8DMdAQzxXHmDlF8k=
Received: by mx.zohomail.com with SMTPS id 1752606676773645.5202170302231;
 Tue, 15 Jul 2025 12:11:16 -0700 (PDT)
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: u-boot@lists.denx.de
Cc: mkorpershoek@kernel.org, trini@konsulko.com, jerome.forissier@linaro.org,
 patrice.chotard@foss.st.com, ilias.apalodimas@linaro.org,
 andre.przywara@arm.com, casey.connolly@linaro.org, mwalle@kernel.org,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: [PATCH v2] drivers: fastboot: Add support for SPI flash memory
Date: Tue, 15 Jul 2025 16:11:09 -0300
Message-ID: <20250715191109.329588-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 15 Jul 2025 22:27:46 +0200
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

Fastboot currently supports MMC and NAND flash devices. Similarly,
extend the support to SPI flash memories.

Note that in this initial implementation, partitions on the device are
not supported yet, but raw partitions can be set in u-boot environment.

To define a raw partition descriptor, add an environment variable
similar to the MMC case:

```
fastboot_raw_partition_<raw partition name>=<offset> <size>
```

for example:

```
fastboot_raw_partition_boot=0x0 0x1000000
```

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 drivers/fastboot/Kconfig        |   6 +-
 drivers/fastboot/Makefile       |   1 +
 drivers/fastboot/fb_command.c   |   8 +
 drivers/fastboot/fb_getvar.c    |   6 +
 drivers/fastboot/fb_spi_flash.c | 249 ++++++++++++++++++++++++++++++++
 include/fb_spi_flash.h          |  40 +++++
 6 files changed, 309 insertions(+), 1 deletion(-)
 create mode 100644 drivers/fastboot/fb_spi_flash.c
 create mode 100644 include/fb_spi_flash.h

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 70207573de2..843171902ae 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -91,7 +91,7 @@ config FASTBOOT_USB_DEV
 config FASTBOOT_FLASH
 	bool "Enable FASTBOOT FLASH command"
 	default y if ARCH_SUNXI || ARCH_ROCKCHIP
-	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
+	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || DM_SPI_FLASH
 	select IMAGE_SPARSE
 	help
 	  The fastboot protocol includes a "flash" command for writing
@@ -119,6 +119,10 @@ config FASTBOOT_FLASH_NAND
 	bool "FASTBOOT on NAND"
 	depends on MTD_RAW_NAND && CMD_MTDPARTS
 
+config FASTBOOT_FLASH_SPI
+	bool "FASTBOOT on SPI flash"
+	depends on DM_SPI_FLASH
+
 endchoice
 
 config FASTBOOT_FLASH_MMC_DEV
diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
index 048af5aa823..adedba0bf24 100644
--- a/drivers/fastboot/Makefile
+++ b/drivers/fastboot/Makefile
@@ -5,3 +5,4 @@ obj-y += fb_getvar.o
 obj-y += fb_command.o
 obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_mmc.o
 obj-$(CONFIG_FASTBOOT_FLASH_NAND) += fb_nand.o
+obj-$(CONFIG_FASTBOOT_FLASH_SPI) += fb_spi_flash.o
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 2cdbac50ac4..7697139b622 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -10,6 +10,7 @@
 #include <fastboot-internal.h>
 #include <fb_mmc.h>
 #include <fb_nand.h>
+#include <fb_spi_flash.h>
 #include <part.h>
 #include <stdlib.h>
 #include <vsprintf.h>
@@ -344,6 +345,10 @@ static void __maybe_unused flash(char *cmd_parameter, char *response)
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
 		fastboot_nand_flash_write(cmd_parameter, fastboot_buf_addr,
 					  image_size, response);
+
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI))
+		fastboot_spi_flash_write(cmd_parameter, fastboot_buf_addr,
+					 image_size, response);
 }
 
 /**
@@ -362,6 +367,9 @@ static void __maybe_unused erase(char *cmd_parameter, char *response)
 
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
 		fastboot_nand_erase(cmd_parameter, response);
+
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI))
+		fastboot_spi_flash_erase(cmd_parameter, response);
 }
 
 /**
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index 9c2ce65a4e5..6775ea397ab 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -8,6 +8,7 @@
 #include <fastboot-internal.h>
 #include <fb_mmc.h>
 #include <fb_nand.h>
+#include <fb_spi_flash.h>
 #include <fs.h>
 #include <part.h>
 #include <version.h>
@@ -123,6 +124,11 @@ static int getvar_get_part_info(const char *part_name, char *response,
 		r = fastboot_nand_get_part_info(part_name, &part_info, response);
 		if (r >= 0 && size)
 			*size = part_info->size;
+	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI)) {
+		r = fastboot_spi_flash_get_part_info(part_name, &disk_part,
+						     response);
+		if (r >= 0 && size)
+			*size = disk_part.size * disk_part.blksz;
 	} else {
 		fastboot_fail("this storage is not supported in bootloader", response);
 		r = -ENODEV;
diff --git a/drivers/fastboot/fb_spi_flash.c b/drivers/fastboot/fb_spi_flash.c
new file mode 100644
index 00000000000..f3fb30a7c80
--- /dev/null
+++ b/drivers/fastboot/fb_spi_flash.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 Collabora Ltd.
+ */
+
+#include <blk.h>
+#include <config.h>
+#include <env.h>
+#include <fastboot.h>
+#include <image-sparse.h>
+#include <spi.h>
+#include <spi_flash.h>
+#include <dm.h>
+#include <dm/device-internal.h>
+
+static struct spi_flash *flash;
+
+__weak int board_fastboot_spi_flash_write_setup(void)
+{
+	return 0;
+}
+
+__weak int board_fastboot_spi_flash_erase_setup(void)
+{
+	return 0;
+}
+
+static int raw_part_get_info_by_name(const char *name,
+				     struct disk_partition *part_info)
+{
+	/* strlen("fastboot_raw_partition_") + PART_NAME_LEN + 1 */
+	char env_desc_name[23 + PART_NAME_LEN + 1];
+	char *raw_part_desc;
+	const char *argv[2];
+	const char **parg = argv;
+
+	/* check for raw partition descriptor */
+	strcpy(env_desc_name, "fastboot_raw_partition_");
+	strlcat(env_desc_name, name, sizeof(env_desc_name));
+	raw_part_desc = strdup(env_get(env_desc_name));
+	if (!raw_part_desc)
+		return -ENODEV;
+
+	/* parse partition descriptor: <start> <size> */
+	for (; parg < argv + sizeof(argv) / sizeof(*argv); ++parg) {
+		*parg = strsep(&raw_part_desc, " ");
+		if (!*parg) {
+			pr_err("Invalid number of arguments.\n");
+			return -ENODEV;
+		}
+	}
+
+	part_info->start = simple_strtoul(argv[0], NULL, 0);
+	part_info->size = simple_strtoul(argv[1], NULL, 0);
+	strlcpy((char *)part_info->name, name, PART_NAME_LEN);
+
+	return 0;
+}
+
+static int fastboot_spi_flash_probe(void)
+{
+	unsigned int bus = CONFIG_SF_DEFAULT_BUS;
+	unsigned int cs = CONFIG_SF_DEFAULT_CS;
+	struct udevice *new, *bus_dev;
+	int ret;
+
+	/* Remove the old device, otherwise probe will just be a nop */
+	ret = spi_find_bus_and_cs(bus, cs, &bus_dev, &new);
+	if (!ret)
+		device_remove(new, DM_REMOVE_NORMAL);
+
+	spi_flash_probe_bus_cs(bus, cs, &new);
+	flash = dev_get_uclass_priv(new);
+	if (!flash) {
+		printf("Failed to initialize SPI flash at %u:%u (error %d)\n",
+		       bus, cs, ret);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int fastboot_spi_flash_unlock(struct spi_flash *flash,
+				     struct disk_partition *part_info)
+{
+	int ret = spi_flash_protect(flash, part_info->start, part_info->size,
+				    false);
+
+	if (ret && ret != -EOPNOTSUPP) {
+		printf("Failed to unlock SPI flash (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static lbaint_t fb_spi_flash_sparse_write(struct sparse_storage *info,
+					  lbaint_t blk, lbaint_t blkcnt,
+					  const void *buffer)
+{
+	size_t len = blkcnt * info->blksz;
+	u32 offset = blk * info->blksz;
+	int ret;
+
+	ret = spi_flash_erase(flash, offset, ROUND(len, flash->erase_size));
+	if (ret < 0) {
+		printf("Failed to erase sparse chunk (%d)\n", ret);
+		return ret;
+	}
+
+	ret = spi_flash_write(flash, offset, len, buffer);
+	if (ret < 0) {
+		printf("Failed to write sparse chunk (%d)\n", ret);
+		return ret;
+	}
+
+	return blkcnt;
+}
+
+static lbaint_t fb_spi_flash_sparse_reserve(struct sparse_storage *info,
+					    lbaint_t blk, lbaint_t blkcnt)
+{
+	return blkcnt;
+}
+
+/**
+ * fastboot_spi_flash_get_part_info() - Lookup SPI partition by name
+ *
+ * @part_name: Named device to lookup
+ * @part_info: Pointer to returned struct disk_partition
+ * @response: Pointer to fastboot response buffer
+ */
+int fastboot_spi_flash_get_part_info(const char *part_name,
+				     struct disk_partition *part_info,
+				     char *response)
+{
+	int ret;
+
+	if (!part_name || !strcmp(part_name, "")) {
+		fastboot_fail("partition not given", response);
+		return -ENOENT;
+	}
+
+	/* TODO: Support partitions on the device */
+	ret = raw_part_get_info_by_name(part_name, part_info);
+	if (ret < 0)
+		fastboot_fail("invalid partition or device", response);
+
+	return ret;
+}
+
+/**
+ * fastboot_spi_flash_write() - Write image to SPI for fastboot
+ *
+ * @cmd: Named device to write image to
+ * @download_buffer: Pointer to image data
+ * @download_bytes: Size of image data
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_spi_flash_write(const char *cmd, void *download_buffer,
+			      u32 download_bytes, char *response)
+{
+	struct disk_partition part_info;
+	int ret;
+
+	if (fastboot_spi_flash_get_part_info(cmd, &part_info, response))
+		return;
+
+	if (fastboot_spi_flash_probe())
+		return;
+
+	if (board_fastboot_spi_flash_write_setup())
+		return;
+
+	if (fastboot_spi_flash_unlock(flash, &part_info))
+		return;
+
+	if (is_sparse_image(download_buffer)) {
+		struct sparse_storage sparse;
+
+		sparse.blksz = flash->sector_size;
+		sparse.start = part_info.start / sparse.blksz;
+		sparse.size = part_info.size / sparse.blksz;
+		sparse.write = fb_spi_flash_sparse_write;
+		sparse.reserve = fb_spi_flash_sparse_reserve;
+		sparse.mssg = fastboot_fail;
+
+		printf("Flashing sparse image at offset " LBAFU "\n",
+		       sparse.start);
+
+		ret = write_sparse_image(&sparse, cmd, download_buffer,
+					 response);
+	} else {
+		printf("Flashing raw image at offset " LBAFU "\n",
+		       part_info.start);
+
+		ret = spi_flash_erase(flash, part_info.start,
+				      ROUND(download_bytes, flash->erase_size));
+		if (ret < 0) {
+			printf("Failed to erase raw image (%d)\n", ret);
+			return;
+		}
+		ret = spi_flash_write(flash, part_info.start, download_bytes,
+				      download_buffer);
+		if (ret < 0) {
+			printf("Failed to write raw image (%d)\n", ret);
+			return;
+		}
+		printf("........ wrote %u bytes\n", download_bytes);
+	}
+
+	if (ret)
+		fastboot_fail("error writing the image", response);
+	else
+		fastboot_okay(NULL, response);
+}
+
+/**
+ * fastboot_spi_flash_erase() - Erase SPI for fastboot
+ *
+ * @cmd: Named device to erase
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_spi_flash_erase(const char *cmd, char *response)
+{
+	struct disk_partition part_info;
+	int ret;
+
+	if (fastboot_spi_flash_get_part_info(cmd, &part_info, response))
+		return;
+
+	if (fastboot_spi_flash_probe())
+		return;
+
+	if (board_fastboot_spi_flash_erase_setup())
+		return;
+
+	if (fastboot_spi_flash_unlock(flash, &part_info))
+		return;
+
+	ret = spi_flash_erase(flash, part_info.start, part_info.size);
+	if (ret < 0) {
+		pr_err("failed erasing from SPI flash");
+		fastboot_fail("failed erasing from SPI flash", response);
+		return;
+	}
+
+	fastboot_okay(NULL, response);
+}
diff --git a/include/fb_spi_flash.h b/include/fb_spi_flash.h
new file mode 100644
index 00000000000..d840166e37b
--- /dev/null
+++ b/include/fb_spi_flash.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 Collabora Ltd.
+ */
+
+#ifndef _FB_SPI_FLASH_H_
+#define _FB_SPI_FLASH_H_
+
+#include <part.h>
+
+/**
+ * fastboot_spi_flash_get_part_info() - Lookup SPI flash partition by name
+ *
+ * @part_name: Named device to lookup
+ * @part_info: Pointer to returned struct disk_partition
+ * @response: Pointer to fastboot response buffer
+ */
+int fastboot_spi_flash_get_part_info(const char *part_name,
+				     struct disk_partition *part_info,
+				     char *response);
+
+/**
+ * fastboot_spi_flash_write() - Write image to SPI flash for fastboot
+ *
+ * @cmd: Named device to write image to
+ * @download_buffer: Pointer to image data
+ * @download_bytes: Size of image data
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_spi_flash_write(const char *cmd, void *download_buffer,
+			      u32 download_bytes, char *response);
+
+/**
+ * fastboot_spi_flash_erase() - Erase SPI flash for fastboot
+ *
+ * @cmd: Named device to erase
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_spi_flash_erase(const char *cmd, char *response);
+#endif
-- 
2.50.0

