Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A43C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 11:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F71D8793C;
	Mon, 22 Jan 2024 12:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GoqRH2Iq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CEBF8780E; Mon, 22 Jan 2024 12:10:55 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B67487966
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 12:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7bf2ab2c4caso123276139f.3
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 03:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705921848; x=1706526648; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7bOhoxlKmVmgksI9eIeZAoLK+opWh86XSN8ugOgLwc=;
 b=GoqRH2IqBxskLDqOCedbZ6saShy3y0EadmYfUXlnbLunR2XqKoeOnwAD+HVBOXG9Fy
 hwvwaat5YUHCTuzdUNgzNleGjdBOqLSd3VYHCNOKZ6qlKHQBiMzbwLF9eVmoyGCNcWg1
 kZPKFcJiHiubFr7S2IrbxQxQqpMFCP2clXwQFIiuXMpSYG/ECXoWEIKoTcJpaxMYw4+h
 9DMNDW0ImPwbFTC9Lb0b4IrzaHvlmtnqgnT9oPmNbVfajvbwLl1ExbVuWMjl6qpoNrEG
 Mty98huINbTbsk59yHLfTIHxTa525TB/nZpJscEgKjNhBpXWySiiPz3j6CHroWBPLhmH
 Sl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705921848; x=1706526648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l7bOhoxlKmVmgksI9eIeZAoLK+opWh86XSN8ugOgLwc=;
 b=SpkcOxrbRBawruWm/Bd9hGK7JtBHRRu6ru/nBnBjZejYTmcJaApT++uSDjWwPfCG1d
 eti7+3IV16xrkTH73Hr0i5Ojo6BGN4TuHi9GUuH9Bv/IhzE9iPT3LBevK+ZfCfO9uEA+
 +bbuliyzTMvndgPg/2qhZAWMU8vqaK1PttjS/rYwawWrwJ+npl/UbYyy1frzL0Zf7L8i
 etHRX/V4BvmJO4Li7hymd/VJLWZ2P9Yu4rUZBP+QTuKMh5IbMFUACzesLyV0CgweG/ah
 +j8pZ1zFzZ+vokap7ZOGF+ZYgbkrWGZcKNuW5YZXEd9aIHtZ3ZITgJKjS7/CoI9Guhvz
 uLFw==
X-Gm-Message-State: AOJu0YzLL+JI2+mZQsDf5uMjnO5/b1KMqjkvn6i1mFBskKlfwfd/51d4
 ZszuewD4AnPvNlzGLagUWj3BVFCVMy2Zatn0w/6y14qdFaU6ssIs0dyKOwl8dv9WI3PkbMtgwFx
 2uQNV4g==
X-Google-Smtp-Source: AGHT+IGSf0kQuO/N53j/7Z/AP7l5sijC4RTKwfpwJrC5hg1WQDYfxvPb7jfWGda/ZKh/pZGYev2CRA==
X-Received: by 2002:a05:6602:1c2:b0:7ba:a93a:db4e with SMTP id
 w2-20020a05660201c200b007baa93adb4emr6707156iot.2.1705921847850; 
 Mon, 22 Jan 2024 03:10:47 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:5306:c1c1:3bc5:9efa:4b71:9731])
 by smtp.googlemail.com with ESMTPSA id
 z16-20020a6b5c10000000b007bf2bfd2da7sm5206365ioh.28.2024.01.22.03.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 03:10:47 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marex@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 2/2] spl: Add support for booting from ESP
Date: Mon, 22 Jan 2024 16:40:22 +0530
Message-Id: <20240122111022.229805-3-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122111022.229805-1-mchitale@ventanamicro.com>
References: <20240122111022.229805-1-mchitale@ventanamicro.com>
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

Some platforms as described by EBBR specification may store images in
the FIRMWARE directory of the UEFI system partition(ESP). Add support
to boot from the EFI system partition if it is enabled for a platform.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
Changes in v3:
- Revert fallback change from v2
- Add RB tag

 common/spl/Kconfig      |  8 ++++++
 common/spl/spl_blk_fs.c | 60 ++++++++++++++++++++++++++++++-----------
 common/spl/spl_fat.c    | 34 ++++++++++++++++++++---
 3 files changed, 82 insertions(+), 20 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index cf7ffc9b112..48e4e43196a 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1292,6 +1292,14 @@ config SPL_SATA_RAW_U_BOOT_SECTOR
 	  Sector on the SATA disk to load U-Boot from, when the SATA disk is being
 	  used in raw mode. Units: SATA disk sectors (1 sector = 512 bytes).
 
+config SPL_ESP_BOOT
+	bool "Load next stage boot image from the UEFI system partition"
+	default y if BOOT_DEFAULTS
+	select SPL_PARTITION_TYPE_GUID
+	help
+	  When enabled, first try to boot from the UEFI system partition as
+	  described in the Ch.4 of the EBBR specification.
+
 config SPL_NVME
 	bool "NVM Express device support"
 	depends on BLK
diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
index 04eac6f306b..ff48285653c 100644
--- a/common/spl/spl_blk_fs.c
+++ b/common/spl/spl_blk_fs.c
@@ -10,12 +10,15 @@
 #include <spl_load.h>
 #include <image.h>
 #include <fs.h>
+#include <part.h>
 #include <asm/cache.h>
 #include <asm/io.h>
 
 struct blk_dev {
 	const char *ifname;
 	const char *filename;
+	int devnum;
+	int partnum;
 	char dev_part_str[8];
 };
 
@@ -44,16 +47,37 @@ static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
 	return actlen;
 }
 
+static int spl_blk_file_size(struct blk_dev *dev, loff_t *filesize)
+{
+	int ret;
+
+	snprintf(dev->dev_part_str, sizeof(dev->dev_part_str) - 1, "%x:%x",
+		 dev->devnum, dev->partnum);
+	debug("Loading file %s from %s %s\n", dev->filename, dev->ifname,
+	      dev->dev_part_str);
+	ret = fs_set_blk_dev(dev->ifname, dev->dev_part_str, FS_TYPE_ANY);
+	if (ret) {
+		printf("spl: unable to set blk_dev %s %s. Err - %d\n",
+		       dev->ifname, dev->dev_part_str, ret);
+		return ret;
+	}
+
+	ret = fs_size(dev->filename, filesize);
+	if (ret)
+		printf("spl: unable to get size, file: %s. Err - %d\n",
+		       dev->filename, ret);
+	return ret;
+}
+
 int spl_blk_load_image(struct spl_image_info *spl_image,
 		       struct spl_boot_device *bootdev,
 		       enum uclass_id uclass_id, int devnum, int partnum)
 {
-	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
 	struct blk_desc *blk_desc;
 	loff_t filesize;
 	struct blk_dev dev;
 	struct spl_load_info load;
-	int ret;
+	int ret, part;
 
 	blk_desc = blk_get_devnum_by_uclass_id(uclass_id, devnum);
 	if (!blk_desc) {
@@ -63,24 +87,28 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 
 	blk_show_device(uclass_id, devnum);
 
-	dev.filename = filename;
+	dev.filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
 	dev.ifname = blk_get_uclass_name(uclass_id);
-	snprintf(dev.dev_part_str, sizeof(dev.dev_part_str) - 1, "%x:%x",
-		 devnum, partnum);
-	ret = fs_set_blk_dev(dev.ifname, dev.dev_part_str, FS_TYPE_ANY);
-	if (ret) {
-		printf("spl: unable to set blk_dev %s %s. Err - %d\n",
-		       dev.ifname, dev.dev_part_str, ret);
-		return ret;
+	dev.devnum = devnum;
+	/*
+	 * First try to boot from EFI System partition. In case of failure,
+	 * fall back to the configured partition.
+	 */
+	if (IS_ENABLED(CONFIG_SPL_ESP_BOOT)) {
+		part = part_get_esp(blk_desc);
+		if (part) {
+			dev.partnum = part;
+			ret = spl_blk_file_size(&dev, &filesize);
+			if (!ret)
+				goto out;
+		}
 	}
 
-	ret = fs_size(filename, &filesize);
-	if (ret) {
-		printf("spl: unable to get file size: %s. Err - %d\n",
-		       filename, ret);
+	dev.partnum = partnum;
+	ret = spl_blk_file_size(&dev, &filesize);
+	if (ret)
 		return ret;
-	}
-
+out:
 	load.read = spl_fit_read;
 	if (IS_ENABLED(CONFIG_SPL_FS_FAT_DMA_ALIGN))
 		spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index a52f9e178e6..8c426a3f3e7 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -60,10 +60,10 @@ static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
 	return actread;
 }
 
-int spl_load_image_fat(struct spl_image_info *spl_image,
-		       struct spl_boot_device *bootdev,
-		       struct blk_desc *block_dev, int partition,
-		       const char *filename)
+int spl_load_image_fat_one(struct spl_image_info *spl_image,
+			   struct spl_boot_device *bootdev,
+			   struct blk_desc *block_dev, int partition,
+			   const char *filename)
 {
 	int err;
 	loff_t size;
@@ -103,6 +103,32 @@ end:
 	return err;
 }
 
+int spl_load_image_fat(struct spl_image_info *spl_image,
+		       struct spl_boot_device *bootdev,
+		       struct blk_desc *block_dev, int partition,
+		       const char *filename)
+{
+	int err, part;
+
+	/*
+	 * First try to boot from EFI System partition. In case of failure,
+	 * fall back to the configured partition.
+	 */
+	if (IS_ENABLED(CONFIG_SPL_ESP_BOOT)) {
+		part = part_get_esp(block_dev);
+		if (part) {
+			err = spl_load_image_fat_one(spl_image, bootdev,
+						     block_dev, part,
+						     filename);
+			if (!err)
+				return err;
+		}
+	}
+
+	return spl_load_image_fat_one(spl_image, bootdev, block_dev,
+				      partition, filename);
+}
+
 #if CONFIG_IS_ENABLED(OS_BOOT)
 int spl_load_image_fat_os(struct spl_image_info *spl_image,
 			  struct spl_boot_device *bootdev,
-- 
2.34.1

