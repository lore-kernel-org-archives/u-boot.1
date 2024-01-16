Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7051EC47258
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 12:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A493F879BA;
	Tue, 16 Jan 2024 13:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="K1bCMG5N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2630B879A3; Tue, 16 Jan 2024 13:37:07 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B2D1879AB
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 13:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6db786df38dso1828179b3a.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 04:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705408622; x=1706013422; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSSArfWqZ9DhlL8jl+jomxbhTSvqDyz3KzsnPIvNCTg=;
 b=K1bCMG5NDSxdmEadGTQNPzoC64wc2pujYkPyyEexVac1eD4vB1hfXaHvtg9Go92J3w
 Hx4zvHTrHXwwAPFXtRoUef3veXZ8mJLtErPzxLeuG3QD3od3UJsd8/99nDATb6+fQB8S
 /oSg9iRPnj+/g3xfFGq4U/8nZ4fNVyS/bo4PtgKmRpN/DKB1I8RNm56sVPCW3syrwMAz
 tbUp7yrbmOXYEgiW3d32CMFZYFeu0zO0WPG1Rq+bTG6LB3ASZv9S9vGmmqn3C/pbhssD
 56ZW+2FDbBYj8UsiH7QGhCwOhzMa6XKiXUmXhnRjSR5u6k3a0jC+3syJQc8t2tnWVKF9
 1ITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705408622; x=1706013422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wSSArfWqZ9DhlL8jl+jomxbhTSvqDyz3KzsnPIvNCTg=;
 b=VKakD2dgl0qBXVfrkdxe6MBCGEZXgthBupYeqqyTMHGa0IgTW6f4G+8aoh5ngmIgRv
 g5/FRYxB+Nbrnti+HpbXux2UQ0410oFBonRWMRl400ES3Nnf+XSQuSBi7YSKnR19Hbt7
 LraaW/532w+ZnMqtPo29+BjJoySpSNH7f7lopI1CVYEM6kuSiypURXu5H+6s2psUTqxU
 lRpYb3hTT7joe6d7JuFgn8VL8LYxxFu5BgxluHKGak00J72NSrYCVIjxCAtb6+dNP+t2
 3nMxlomnB1W3qh8GaYbowNl6uiBImB9leirNKRu9z/f241ExveV/PgdUFeV42VgTGGSU
 9JwA==
X-Gm-Message-State: AOJu0Ywd3t5eymt1bNS7QTCAz48Pb/5WZi7SIKzbI5zFn1wW8lLY45sU
 3wu6VDi+TuzN2LQD/WfzZS1uwyznO/jy5ZXL1FY9kKfooOJu50Dq
X-Google-Smtp-Source: AGHT+IEr/+72awOLR/UwAzMS9kpEUSifOyoprnI54zm+o0UdA5xmyDdo02G3/fT0VwUz0EepqIuT3A==
X-Received: by 2002:a05:6a20:2d28:b0:19b:56d6:dd19 with SMTP id
 g40-20020a056a202d2800b0019b56d6dd19mr11687pzl.10.1705408621629; 
 Tue, 16 Jan 2024 04:37:01 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:562a:8545:ac:19eb:49f7:baa8])
 by smtp.googlemail.com with ESMTPSA id
 mt1-20020a17090b230100b0028e8160327esm449544pjb.0.2024.01.16.04.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 04:37:01 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Marek Vasut <marex@denx.de>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 2/2] spl: Add support for booting from ESP
Date: Tue, 16 Jan 2024 18:06:43 +0530
Message-Id: <20240116123643.563412-3-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116123643.563412-1-mchitale@ventanamicro.com>
References: <20240116123643.563412-1-mchitale@ventanamicro.com>
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
 common/spl/Kconfig      |  8 +++++++
 common/spl/spl_blk_fs.c | 51 ++++++++++++++++++++++++++++++-----------
 common/spl/spl_fat.c    | 34 +++++++++++++++++++++++----
 3 files changed, 75 insertions(+), 18 deletions(-)

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
index 04eac6f306b..a2e8c2ce910 100644
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
 
@@ -44,6 +47,29 @@ static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
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
@@ -53,7 +79,7 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 	loff_t filesize;
 	struct blk_dev dev;
 	struct spl_load_info load;
-	int ret;
+	int ret, part;
 
 	blk_desc = blk_get_devnum_by_uclass_id(uclass_id, devnum);
 	if (!blk_desc) {
@@ -65,21 +91,18 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 
 	dev.filename = filename;
 	dev.ifname = blk_get_uclass_name(uclass_id);
-	snprintf(dev.dev_part_str, sizeof(dev.dev_part_str) - 1, "%x:%x",
-		 devnum, partnum);
-	ret = fs_set_blk_dev(dev.ifname, dev.dev_part_str, FS_TYPE_ANY);
-	if (ret) {
-		printf("spl: unable to set blk_dev %s %s. Err - %d\n",
-		       dev.ifname, dev.dev_part_str, ret);
-		return ret;
+	dev.devnum = devnum;
+	dev.partnum = partnum;
+	if (IS_ENABLED(CONFIG_SPL_ESP_BOOT)) {
+		part = part_get_esp(blk_desc);
+		if (part)
+			dev.partnum = part;
+		else
+			return -ENODEV;
 	}
-
-	ret = fs_size(filename, &filesize);
-	if (ret) {
-		printf("spl: unable to get file size: %s. Err - %d\n",
-		       filename, ret);
+	ret = spl_blk_file_size(&dev, filename, &filesize);
+	if (ret)
 		return ret;
-	}
 
 	load.read = spl_fit_read;
 	if (IS_ENABLED(CONFIG_SPL_FS_FAT_DMA_ALIGN))
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

