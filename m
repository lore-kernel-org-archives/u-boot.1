Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50797C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 15:28:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8EA588297;
	Sun, 21 Jul 2024 17:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Of2UZl3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17DEB87ED1; Sun, 21 Jul 2024 17:26:47 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2D7C87F9F
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 17:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4267345e746so25960545e9.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721575604; x=1722180404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l+QDhX/l5EJIpwF7rSMi4gYR1jwCxk+Kd8PgvLXMYnM=;
 b=Of2UZl3iZnjwJlqSCs1U7VAXQEPBj5uUvAOx1tNvRYyVEOMkPHriSAQbU22F9PwQIh
 93pLkdBsRmv1AAXibqUMi4ecZXeu3EZlo5vTrksEiqHf8eVFCrHISDNOc+ClOkznT0dJ
 7QuN2/9772OdnCNINdIayZlcsYJRhb9jA4VaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721575604; x=1722180404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l+QDhX/l5EJIpwF7rSMi4gYR1jwCxk+Kd8PgvLXMYnM=;
 b=HsqM2e2D2uo8ydCSFbDnuAemvT3faDBfbh/FByASlRaVpw0hPV0YVOFOn+DkFSxRJq
 wu2tV16EifYRhVY7XY0kL2qfHZETgyr24K7y/92f+oyfJ0KECSaQUbVRaNx0CqxfUYQF
 xk0+zbE7Z/Z0gdXxBtV3JFFpKIpRCLmNHwY/lFKfzUrEYnv1lfXuD+5ueLH+Zk090lXL
 G7IUbVi6cMcNFdrrRZ88BLc61baX+SPtlY57gzZVIddhnwxEBpOs7rRgdAxqAKBsEnJ2
 iPkDehzB4jMP7UEz5ULUAUpHmYa6DqiWwPl7Wm+ssSzMpwE9sCfvbEC+lTNi+yxE26l4
 /H3A==
X-Gm-Message-State: AOJu0YwV5yv8wPIuAdz61dyJ1SvL8qBWEf6FEwpSRTxoGr8lgkJ79GUL
 7Xo2s/ePLHiUSw2GVJB9ckeztYi/du2TMHv2leB80v2/umQYb7LFjs+trwbu7I9XYcJS6LpJDkI
 =
X-Google-Smtp-Source: AGHT+IGnjapHqbflHvnCe8beKPvzZfKvSt8kKwFUoUxlzPrSqWVdKLgGUMHlRDd/9DzVWFmeE+4xaA==
X-Received: by 2002:a05:600c:3148:b0:426:6eb9:db07 with SMTP id
 5b1f17b1804b1-427dc51d3ecmr27816685e9.13.1721575603908; 
 Sun, 21 Jul 2024 08:26:43 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427e5803bb0sm8702255e9.45.2024.07.21.08.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 08:26:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 09/14] spl: mmc: Handle error codes consistently
Date: Sun, 21 Jul 2024 16:25:54 +0100
Message-Id: <20240721152600.3212917-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721152600.3212917-1-sjg@chromium.org>
References: <20240721152600.3212917-1-sjg@chromium.org>
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

