Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0EDEDE9B8
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 12:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D528387042;
	Thu, 14 Sep 2023 14:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oHio0koq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C62787035; Thu, 14 Sep 2023 14:21:15 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C79A87061
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 14:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c3887039d4so7164865ad.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694694071; x=1695298871; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0Q1k1hjVuP4uNe3nuik+u2ceWQQ/DZ+SNAp5yPQUeo=;
 b=oHio0koqnN0QqUTHdpK0PlD+SVCHDuFhxxNWFBiim4nyLtisbo6EM3atF7mteZAH3K
 0m4FxLfoDaBlJOgbRfd7l3b3QvuQfT0qex9+jDVZcCJE9SlNfSx7NjXMm4CLmPUuAr/q
 gTDNhYxHBbmGJE+FxCkFm1nPInjmuJTWHb7E9oZ9ocrmPqYxPXvvSjl+JiZb9RO0ociM
 UoHIo6FHneTSs9ekrXvYtWUg1rJCiTBKvjXsSLVOY/4VV+dnF7CH10W9vz5gzG6/Bbdb
 8y9Nx/x0pjT06oIUyp4HnWZwtmH9l7qqxMDE6OKXVV+ii0AT2udl8IoWjhhv449IYooA
 0fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694694071; x=1695298871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0Q1k1hjVuP4uNe3nuik+u2ceWQQ/DZ+SNAp5yPQUeo=;
 b=Fp6tQQ6Wdb7QaRXsI9dVFXdoUvBcHj5hjPrjmVP2I6/AHINzhuYrG8eRZlBeRWn+DP
 423ZtybE9Y0BF+mGUy55qb1I5qX96x+aJg99yD/SCr9abVLT/fUrGMrqJsh1beEbbijC
 iemIQt15j3KfKQfLPhmtd1LBAg0QDikbf9khdb5G/KiuGKP4esGtXCxf1DkobXFdTmMh
 cKFBWum/21f67edbj7Pmo9bm/Mkv535q0CEeofQW5okYFed+8arxVJ5mpoulDQLOHMDl
 fsKyogFU+fYDIdV7zogyrkRj7+04aFlGaLwsszX+wiJM1aD3lQ/tXKR3hjRx/s7iKFIV
 ojNw==
X-Gm-Message-State: AOJu0YwBMdS/TBjMsC8++/n5NTiSah++la1/SUV6GORAC0zttrIWqUYk
 5qIw1SnF1l1TZbkACpWPGj4VAUFx7Yc0ExREM6HZtQ==
X-Google-Smtp-Source: AGHT+IF9CjggqtHhgyx3XnIaFF5AcyeWlE81K6kM32xbXYmRlNDj/tpJ/oBn7jPoZnR/+fLdjFg0Wg==
X-Received: by 2002:a17:902:db03:b0:1bd:f314:7896 with SMTP id
 m3-20020a170902db0300b001bdf3147896mr6011787plx.25.1694694070594; 
 Thu, 14 Sep 2023 05:21:10 -0700 (PDT)
Received: from mchitale-vm.. ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 t17-20020a1709028c9100b001bdb85291casm1447796plo.208.2023.09.14.05.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 05:21:10 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/2] spl: Add support for booting from ESP
Date: Thu, 14 Sep 2023 15:38:21 +0530
Message-Id: <20230914100821.755904-3-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914100821.755904-1-mchitale@ventanamicro.com>
References: <20230914100821.755904-1-mchitale@ventanamicro.com>
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
---
 common/spl/Kconfig      |  7 +++++
 common/spl/spl_blk_fs.c | 61 +++++++++++++++++++++++++++++------------
 common/spl/spl_fat.c    | 34 ++++++++++++++++++++---
 3 files changed, 81 insertions(+), 21 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 76bde18515..92984b19da 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1241,6 +1241,13 @@ config SPL_SATA_RAW_U_BOOT_SECTOR
 	  Sector on the SATA disk to load U-Boot from, when the SATA disk is being
 	  used in raw mode. Units: SATA disk sectors (1 sector = 512 bytes).
 
+config SPL_ESP_BOOT
+	bool "Load next stage boot image from the UEFI system partition"
+	select SPL_PARTITION_TYPE_GUID
+	help
+	  When enabled, first try to boot from the UEFI system partition as
+	  described in the Ch.4 of the EBBR specification.
+
 config SPL_NVME
 	bool "NVM Express device support"
 	depends on BLK
diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
index 5268daaaff..78d1478426 100644
--- a/common/spl/spl_blk_fs.c
+++ b/common/spl/spl_blk_fs.c
@@ -9,9 +9,12 @@
 #include <spl.h>
 #include <image.h>
 #include <fs.h>
+#include <part.h>
 
 struct blk_dev {
 	const char *ifname;
+	int devnum;
+	int partnum;
 	char dev_part_str[8];
 };
 
@@ -39,16 +42,38 @@ static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
 	return actlen;
 }
 
+static int spl_blk_file_size(struct blk_dev *dev, const char *filename,
+			     loff_t *filesize)
+{
+	int ret;
+
+	snprintf(dev->dev_part_str, sizeof(dev->dev_part_str) - 1, "%x:%x",
+		 dev->devnum, dev->partnum);
+	debug("Loading file %s from %s %s\n", filename, dev->ifname,
+	      dev->dev_part_str);
+	ret = fs_set_blk_dev(dev->ifname, dev->dev_part_str, FS_TYPE_ANY);
+	if (ret) {
+		printf("spl: unable to set blk_dev %s %s. Err - %d\n",
+		       dev->ifname, dev->dev_part_str, ret);
+		return ret;
+	}
+
+	ret = fs_size(filename, filesize);
+	if (ret)
+		printf("spl: unable to get size, file: %s. Err - %d\n",
+		       filename, ret);
+	return ret;
+}
+
 int spl_blk_load_image(struct spl_image_info *spl_image,
 		       struct spl_boot_device *bootdev,
 		       enum uclass_id uclass_id, int devnum, int partnum)
 {
 	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
-	struct legacy_img_hdr *header;
 	struct blk_desc *blk_desc;
 	loff_t filesize;
 	struct blk_dev dev;
-	int ret;
+	int ret, part;
 	struct spl_load_info load = {
 		.read = spl_fit_read,
 		.bl_len = 1,
@@ -63,24 +88,26 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 	}
 
 	blk_show_device(uclass_id, devnum);
-	header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
-
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
+			ret = spl_blk_file_size(&dev, filename, &filesize);
+			if (!ret)
+				goto out;
+		}
 	}
 
-	ret = fs_size(filename, &filesize);
-	if (ret) {
-		printf("spl: unable to get file size: %s. Err - %d\n",
-		       filename, ret);
+	dev.partnum = partnum;
+	ret = spl_blk_file_size(&dev, filename, &filesize);
+	if (ret)
 		return ret;
-	}
-
+out:
 	return spl_load(spl_image, bootdev, &load, filesize, 0);
 }
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index 6530bcd5a7..63091f2bd6 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -54,10 +54,10 @@ static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
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
@@ -96,6 +96,32 @@ end:
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

