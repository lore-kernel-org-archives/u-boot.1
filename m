Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A4BC3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 13:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C548588A29;
	Thu, 22 Aug 2024 15:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="evYMx1Xq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1274488A99; Thu, 22 Aug 2024 15:55:39 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7D2788A75
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-39d34be8b64so2631455ab.1
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724334934; x=1724939734; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NBCyqJg89eVZkHUFFMhLXFLV55WjYE8r87Upkjx08Ac=;
 b=evYMx1Xqh9+4Y6UtOHE10Q0Lc+WzUfmalRmMSn3jfxoUa51QLPYmDQF2guHZGAESg0
 4ziL9NWPLxTqvS49QW0cgxaothILRhNp4rMvMHLIGJkjOtLX2cfFgeyrybBMDK6nzD9r
 BUd01/d3mkiqd74xki7BT7DwFt//UIPsuNCF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724334934; x=1724939734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NBCyqJg89eVZkHUFFMhLXFLV55WjYE8r87Upkjx08Ac=;
 b=Q5BbDodm/n4/FPCQNJ+6ZpOz0x5HKBHwdQoCa6eVBD1tj1xcc/EjY1jGkTMmx8at0E
 pq2P/8w183cXEP1jux6wLiyFAxx8B3PMu8ObNm0IdgQ2Z4PEgSCumm+ApWqHk+gXQLdZ
 zvtHlsnPmBKcWa/fgmux2sy/siR3ECGFtTvd7+brFKHsc4VdH/SdKzjYDWGP5/qNq/Xk
 p7hg6NnGbmKHjbBmOH7xV+PD49FkIH2K9VeetnFbeHCiloK3TFy/tnkgpGIQDuYrcZ6h
 YCZ/z/UCd6Gt+gFtZOuAuetkYhKRUrYS0Rw3Gc/HI44dQBA0Wgm+U8GhY7B55uCYXwsZ
 EewQ==
X-Gm-Message-State: AOJu0YwCsq3n7zAhBUmGjHa3QJX/NFXo03dstVaaL24UQXLGqDrYiB4/
 KuB5D2iZY2IXMKvb+QBpseaNgj8yODkVNrwe3/Jv1oxorMGDrQaxGAKp+EV4m5iXFm0VMTiABwQ
 =
X-Google-Smtp-Source: AGHT+IEHeKgqBHU8m7ywx26H9nO9kjq6VDBrHWM9hr/nnhs5EMKrE7SiSkDQ58iG8znm8SYpNy3l4Q==
X-Received: by 2002:a05:6e02:1a48:b0:39d:590b:13b2 with SMTP id
 e9e14a558f8ab-39d6c37ce82mr60863105ab.7.1724334934499; 
 Thu, 22 Aug 2024 06:55:34 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c1eesm6692585ab.39.2024.08.22.06.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:55:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v4 09/14] spl: mmc: Handle error codes consistently
Date: Thu, 22 Aug 2024 07:54:58 -0600
Message-Id: <20240822135503.2363706-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135503.2363706-1-sjg@chromium.org>
References: <20240822135503.2363706-1-sjg@chromium.org>
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

Use 'ret' as the return code, since it may not be an error and this is
the common name in U-Boot. Make sure to return the error code when
given, rather than transforming it into -1 (-EPERM).

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Update 'return ret' to 'return 0' when ret is known to be 0

 common/spl/spl_mmc.c | 129 ++++++++++++++++++++++---------------------
 1 file changed, 65 insertions(+), 64 deletions(-)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index ddc85aaeda7..bc6087e88cd 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -52,7 +52,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 	ret = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
 	if (ret) {
 		puts("mmc_load_image_raw_sector: mmc block read error\n");
-		return -1;
+		return ret;
 	}
 
 	return 0;
@@ -75,27 +75,27 @@ static int spl_mmc_get_device_index(u32 boot_device)
 
 static int spl_mmc_find_device(struct mmc **mmcp, u32 boot_device)
 {
-	int err, mmc_dev;
+	int ret, mmc_dev;
 
 	mmc_dev = spl_mmc_get_device_index(boot_device);
 	if (mmc_dev < 0)
 		return mmc_dev;
 
 #if CONFIG_IS_ENABLED(DM_MMC)
-	err = mmc_init_device(mmc_dev);
+	ret = mmc_init_device(mmc_dev);
 #else
-	err = mmc_initialize(NULL);
+	ret = mmc_initialize(NULL);
 #endif /* DM_MMC */
-	if (err) {
-		printf("spl: could not initialize mmc. error: %d\n", err);
-		return err;
+	if (ret) {
+		printf("spl: could not initialize mmc. error: %d\n", ret);
+		return ret;
 	}
 	*mmcp = find_mmc_device(mmc_dev);
-	err = *mmcp ? 0 : -ENODEV;
-	if (err) {
+	ret = *mmcp ? 0 : -ENODEV;
+	if (ret) {
 		printf("spl: could not find mmc device %d. error: %d\n",
-		       mmc_dev, err);
-		return err;
+		       mmc_dev, ret);
+		return ret;
 	}
 
 	return 0;
@@ -108,14 +108,14 @@ static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
 					unsigned long sector)
 {
 	struct disk_partition info;
-	int err;
+	int ret;
 
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
 	int type_part;
 	/* Only support MBR so DOS_ENTRY_NUMBERS */
 	for (type_part = 1; type_part <= DOS_ENTRY_NUMBERS; type_part++) {
-		err = part_get_info(mmc_get_blk_desc(mmc), type_part, &info);
-		if (err)
+		ret = part_get_info(mmc_get_blk_desc(mmc), type_part, &info);
+		if (ret)
 			continue;
 		if (info.sys_ind ==
 			CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE) {
@@ -125,10 +125,10 @@ static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
 	}
 #endif
 
-	err = part_get_info(mmc_get_blk_desc(mmc), partition, &info);
-	if (err) {
+	ret = part_get_info(mmc_get_blk_desc(mmc), partition, &info);
+	if (ret) {
 		puts("spl: partition error\n");
-		return -err;
+		return ret;
 	}
 
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
@@ -155,7 +155,7 @@ static int mmc_load_image_raw_os(struct spl_image_info *spl_image,
 		(void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR);
 	if (count != CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS) {
 		puts("mmc_load_image_raw_os: mmc block read error\n");
-		return -1;
+		return -EIO;
 	}
 #endif	/* CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR */
 
@@ -193,7 +193,7 @@ static int spl_mmc_do_fs_boot(struct spl_image_info *spl_image,
 			      struct mmc *mmc,
 			      const char *filename)
 {
-	int err = -ENOSYS;
+	int ret = -ENOSYS;
 
 	__maybe_unused int partition = CONFIG_SYS_MMCSD_FS_BOOT_PARTITION;
 
@@ -202,8 +202,8 @@ static int spl_mmc_do_fs_boot(struct spl_image_info *spl_image,
 		struct disk_partition info;
 		debug("Checking for the first MBR bootable partition\n");
 		for (int type_part = 1; type_part <= DOS_ENTRY_NUMBERS; type_part++) {
-			err = part_get_info(mmc_get_blk_desc(mmc), type_part, &info);
-			if (err)
+			ret = part_get_info(mmc_get_blk_desc(mmc), type_part, &info);
+			if (ret)
 				continue;
 			debug("Partition %d is of type %d and bootable=%d\n", type_part, info.sys_ind, info.bootable);
 			if (info.bootable != 0) {
@@ -221,40 +221,40 @@ static int spl_mmc_do_fs_boot(struct spl_image_info *spl_image,
 
 #ifdef CONFIG_SPL_FS_FAT
 	if (!spl_start_uboot()) {
-		err = spl_load_image_fat_os(spl_image, bootdev, mmc_get_blk_desc(mmc),
-			partition);
-		if (!err)
-			return err;
+		ret = spl_load_image_fat_os(spl_image, bootdev, mmc_get_blk_desc(mmc),
+					    partition);
+		if (!ret)
+			return 0;
 	}
 #ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
-	err = spl_load_image_fat(spl_image, bootdev, mmc_get_blk_desc(mmc),
+	ret = spl_load_image_fat(spl_image, bootdev, mmc_get_blk_desc(mmc),
 				 partition,
 				 filename);
-	if (!err)
-		return err;
+	if (!ret)
+		return ret;
 #endif
 #endif
 #ifdef CONFIG_SPL_FS_EXT4
 	if (!spl_start_uboot()) {
-		err = spl_load_image_ext_os(spl_image, bootdev, mmc_get_blk_desc(mmc),
-			partition);
-		if (!err)
-			return err;
+		ret = spl_load_image_ext_os(spl_image, bootdev, mmc_get_blk_desc(mmc),
+					    partition);
+		if (!ret)
+			return 0;
 	}
 #ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
-	err = spl_load_image_ext(spl_image, bootdev, mmc_get_blk_desc(mmc),
+	ret = spl_load_image_ext(spl_image, bootdev, mmc_get_blk_desc(mmc),
 				 partition,
 				 filename);
-	if (!err)
-		return err;
+	if (!ret)
+		return 0;
 #endif
 #endif
 
 #if defined(CONFIG_SPL_FS_FAT) || defined(CONFIG_SPL_FS_EXT4)
-	err = -ENOENT;
+	ret = -ENOENT;
 #endif
 
-	return err;
+	return ret;
 }
 #endif
 
@@ -342,73 +342,74 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 		 unsigned long raw_sect)
 {
 	u32 boot_mode;
-	int err = 0;
+	int ret = 0;
 	__maybe_unused int part = 0;
 	int mmc_dev;
 
 	/* Perform peripheral init only once for an mmc device */
 	mmc_dev = spl_mmc_get_device_index(bootdev->boot_device);
 	if (!mmc || spl_mmc_get_mmc_devnum(mmc) != mmc_dev) {
-		err = spl_mmc_find_device(&mmc, bootdev->boot_device);
-		if (err)
-			return err;
+		ret = spl_mmc_find_device(&mmc, bootdev->boot_device);
+		if (ret)
+			return ret;
 
-		err = mmc_init(mmc);
-		if (err) {
+		ret = mmc_init(mmc);
+		if (ret) {
 			mmc = NULL;
-			printf("spl: mmc init failed with error: %d\n", err);
-			return err;
+			printf("spl: mmc init failed with error: %d\n", ret);
+			return ret;
 		}
 	}
 
 	boot_mode = spl_mmc_boot_mode(mmc, bootdev->boot_device);
-	err = -EINVAL;
+	ret = -EINVAL;
 	switch (boot_mode) {
 	case MMCSD_MODE_EMMCBOOT:
 		part = spl_mmc_emmc_boot_partition(mmc);
 
 		if (CONFIG_IS_ENABLED(MMC_TINY))
-			err = mmc_switch_part(mmc, part);
+			ret = mmc_switch_part(mmc, part);
 		else
-			err = blk_dselect_hwpart(mmc_get_blk_desc(mmc), part);
+			ret = blk_dselect_hwpart(mmc_get_blk_desc(mmc), part);
 
-		if (err) {
+		if (ret) {
 			puts("spl: mmc partition switch failed\n");
-			return err;
+			return ret;
 		}
 		/* Fall through */
 	case MMCSD_MODE_RAW:
 		debug("spl: mmc boot mode: raw\n");
 
 		if (!spl_start_uboot()) {
-			err = mmc_load_image_raw_os(spl_image, bootdev, mmc);
-			if (!err)
-				return err;
+			ret = mmc_load_image_raw_os(spl_image, bootdev, mmc);
+			if (!ret)
+				return 0;
 		}
 
 		raw_sect = spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
 
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
-		err = mmc_load_image_raw_partition(spl_image, bootdev,
+		ret = mmc_load_image_raw_partition(spl_image, bootdev,
 						   mmc, raw_part,
 						   raw_sect);
-		if (!err)
-			return err;
+		if (!ret)
+			return 0;
 #endif
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
-		err = mmc_load_image_raw_sector(spl_image, bootdev, mmc,
-				raw_sect + spl_mmc_raw_uboot_offset(part));
-		if (!err)
-			return err;
+		ret = mmc_load_image_raw_sector(spl_image, bootdev, mmc,
+						raw_sect +
+						spl_mmc_raw_uboot_offset(part));
+		if (!ret)
+			return 0;
 #endif
 		/* If RAW mode fails, try FS mode. */
 #ifdef CONFIG_SYS_MMCSD_FS_BOOT
 	case MMCSD_MODE_FS:
 		debug("spl: mmc boot mode: fs\n");
 
-		err = spl_mmc_do_fs_boot(spl_image, bootdev, mmc, filename);
-		if (!err)
-			return err;
+		ret = spl_mmc_do_fs_boot(spl_image, bootdev, mmc, filename);
+		if (!ret)
+			return 0;
 
 		break;
 #endif
@@ -416,7 +417,7 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 		puts("spl: mmc: wrong boot mode\n");
 	}
 
-	return err;
+	return ret;
 }
 
 int spl_mmc_load_image(struct spl_image_info *spl_image,
-- 
2.34.1

