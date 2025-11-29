Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478D3D116EA
	for <u-boot@archiver.kernel.org>; Sat, 29 Nov 2025 06:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CA0D835FD;
	Sat, 29 Nov 2025 07:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HHRpJ7xg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FBB183642; Sat, 29 Nov 2025 07:48:37 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F05738334F
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 07:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7b8e49d8b35so2880948b3a.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 22:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764398913; x=1765003713; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=pstg9auBDEHmjuwvrl5aqtcrBvZyZs8Sk3de4qKZTLM=;
 b=HHRpJ7xgymaxLxxO0cK28q59Stqmvgh3MTG1OLItZfBGCLthlQHMZT3+LBUljs3QbI
 qIrPw+CyIhMRdxu2hx4PY8OCHqbSFKW2uodHruhWB3s3ZWScjSCgfeKbVrcqOvKmr0Et
 NCv+RtAXJ44eB5/nTv7KYBo9KKTOaGVsru057JHYzzPOihjtPkhZiagdTgmg/usi2NSo
 3anz2hAYnq6Sh+IERzt9/91QiureP/YXF1UNcX/8QBCzzoGLk9mkm2Zit/1PJyUadaNH
 1TBpvWRsbMZLy1uLTdhBQAG+8pJWQTWqmwXE5icuWscpQYpwfZkl36vAwf5VqNiowC5T
 f0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764398913; x=1765003713;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pstg9auBDEHmjuwvrl5aqtcrBvZyZs8Sk3de4qKZTLM=;
 b=PNhpZ5kn6o2L4GgZfyf8xIQxPoAW8aUAqLQKpJrEICxJNeQ9edz7do8b/ADuF6XvOp
 KIPe7cgfb9ycfQKP4r6WAAlJnYtmxGc2Bng2xCz+XSJAoBEwy8Y8D/H3ePmV+mSxhhnD
 DQbChA3g3yGiH/cAUDy/h+Ha1aXfvtl+ahTd7U02A3v50QvWXlKa7xQAs2ec9at6OWi8
 +x7ntiTsS4bpGoetBQaDh8LHMZoMfUEMiJVdQWNHEWAFdYBhjk8BGu7Lc77FGEIPRFX9
 KDItc/MVSfJJgEWAKQH1m7Ak4bQ/v1FDCGmuDo0w5oMqIUSS9V86B936Qlojn4FWgBo6
 M+og==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH7eGqKswAEfjdq5mNIpZOvT02MdWo8x/n8ZQjMQmanOUNoSxBKkSInHF2up2wVdioaPVLhRY=@lists.denx.de
X-Gm-Message-State: AOJu0YwpVu5nNw0cYkq14VKrbUuyWpGSivq2NQjJ3oYRTPQbxIUGOZSb
 KXuAj6zqT6oty8430aZYySHLfEdbiA6rIVxxYBBVMojvOCGZKaho9aVL
X-Gm-Gg: ASbGncs2y8AzLWsAD1ZisBX6RflrWSCXQKjWYwfnJZIGdZ5UUYgklUALPRCjA334YYt
 SPuALnHTfJDXrRqkyGXnI0r42ijIqVrC/Sov30sXuV21WiAMgydUIpx2I/Y86fR8hocnFIl0k1B
 AVm2S5gBWjS32XUXceOxkgEeJPZqY3DRQx/U6hX5bPiPYbPJn5TpH5v6MIg3CvxONUk/rhevwUJ
 EJcVc6lTjNg4c70lOITBJ5roRROX86Qr8hT9/1ynVIJy/XoDZpaieA8hSateEvLu7y0S3D0G+g7
 KWTFUFa/dXgcCBv9p/5DiEQxHRCoxOVg9ZSRosyrmVOKCXfwzzDu7yDdkSL1/HOCSIpey2t9gFM
 +LHy7VmkhdjWI8FP2UfZy3jECiil7FXgMX31DheWPuE+EHly5WdvkYiXokjCUapmdwOy276Za7g
 4UaEMrOpR1+Q+rqCiPdLMvIj2O5plAiTldDbhE
X-Google-Smtp-Source: AGHT+IEqXfWMD/weECBANY41F9oFHWDpnGAKsn5y4UqrvCQdKw2RfdN6HiBeTT/Dj56+2ud4cVTm/Q==
X-Received: by 2002:a05:6a20:3d1c:b0:361:3bda:43aa with SMTP id
 adf61e73a8af0-36150e27b7emr37706418637.1.1764398913334; 
 Fri, 28 Nov 2025 22:48:33 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7d15f080beasm6918614b3a.47.2025.11.28.22.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 22:48:32 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Chee Tien Fong <tienfong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2] Fix socfpga GEN5 boot by spl+u-boot sfp on RAW
Date: Sat, 29 Nov 2025 14:48:18 +0800
Message-ID: <20251129064818.1587-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
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

Thanks to Jan Kiszka had provided info on
u-boot is not able to boot by u-boot-with-spl.sfp.

All three TYPE, NUM, OFFSET mode methods
are nonfunctional on combined raw boot.

The major cause is spl+u-boot structure is
defined as 4x[spl+zero_pad] + u-boot.img.
Deal to this configuration since GEN5 is used,
the spl would require to seek by an offset
on top of the spl offset. This means for
each spl=0x10000 the offset is 0x40000.

However latest u-boot do not consider this
major structure on GEN5 socfpga.
Meanwhile, the default include file as Jan
pointed out is completely wrong syntax and
caused issue.

Combining both concepts, the minimum fix
patch is provide as follows.

1) Offset is control and default set to a
proper offset under:
SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET

2) Only GEN5 socfpga will be affected and
minimized contamination on other devices.

3) Only one compuatation adjustment is made
on spl_mmc_load. And simply introduce the
offset adding by the kconfig offset control.
It should be 0 by default and gate as well.
So no possible harm should be done.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 common/spl/Kconfig   |  8 +++++++-
 common/spl/spl_mmc.c | 19 ++++++++++++++-----
 include/part.h       |  4 +++-
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 8dade2b501e..554509146d8 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -574,6 +574,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
 config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
 	bool "MMC raw mode: by partition type"
 	depends on DOS_PARTITION
+	select SPL_LOAD_BLOCK
 	help
 	  Use partition type for specifying U-Boot partition on MMC/SD in
 	  raw mode. U-Boot will be loaded from the first partition of this
@@ -600,8 +601,13 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
 
 config SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET
 	hex "U-Boot main hardware partition image offset"
-	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
+	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR || \
+	(SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION && \
+	(TARGET_SOCFPGA_CYCLONE5 || TARGET_SOCFPGA_ARRIA5)) || \
+	(SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE && \
+	(TARGET_SOCFPGA_CYCLONE5 || TARGET_SOCFPGA_ARRIA5))
 	default 0x10 if ARCH_SUNXI
+	default 0x200 if TARGET_SOCFPGA_CYCLONE5 || TARGET_SOCFPGA_ARRIA5
 	default 0x0
 	help
 	  On some platforms SPL location depends on hardware partition. The ROM
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index d8ce3a84614..6904ea3edb7 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -5,6 +5,7 @@
  *
  * Aneesh V <aneesh@ti.com>
  */
+
 #include <dm.h>
 #include <log.h>
 #include <part.h>
@@ -28,7 +29,9 @@ static ulong h_spl_load_read(struct spl_load_info *load, ulong off,
 
 static __maybe_unused unsigned long spl_mmc_raw_uboot_offset(int part)
 {
-#if IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR)
+#if IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR) || \
+    IS_ENABLED(CONFIG_TARGET_SOCFPGA_CYCLONE5) || \
+    IS_ENABLED(CONFIG_TARGET_SOCFPGA_ARRIA5)
 	if (part == 0)
 		return CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET;
 #endif
@@ -106,7 +109,9 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
 	return 0;
 }
 
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
+    (defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE) && \
+    (defined(CONFIG_TARGET_SOCFPGA_CYCLONE5) || defined(CONFIG_TARGET_SOCFPGA_ARRIA5)))
 static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
 					struct spl_boot_device *bootdev,
 					struct mmc *mmc, int partition,
@@ -136,7 +141,9 @@ static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
 		return ret;
 	}
 
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
+#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR) || \
+    defined(CONFIG_TARGET_SOCFPGA_CYCLONE5) || \
+    defined(CONFIG_TARGET_SOCFPGA_ARRIA5)
 	return mmc_load_image_raw_sector(spl_image, bootdev, mmc, info.start + sector);
 #else
 	return mmc_load_image_raw_sector(spl_image, bootdev, mmc, info.start);
@@ -419,10 +426,12 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 
 		raw_sect = spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
 
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
+    (defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE) && \
+    (defined(CONFIG_TARGET_SOCFPGA_CYCLONE5) || defined(CONFIG_TARGET_SOCFPGA_ARRIA5)))
 		ret = mmc_load_image_raw_partition(spl_image, bootdev,
 						   mmc, raw_part,
-						   raw_sect);
+						   raw_sect + spl_mmc_raw_uboot_offset(part));
 		if (!ret)
 			return 0;
 #endif
diff --git a/include/part.h b/include/part.h
index 6caaa6526aa..91e49012e2f 100644
--- a/include/part.h
+++ b/include/part.h
@@ -461,7 +461,9 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
 #ifdef CONFIG_XPL_BUILD
 # define part_print_ptr(x)	NULL
 # if defined(CONFIG_SPL_FS_EXT4) || defined(CONFIG_SPL_FS_FAT) || \
-	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION)
+     defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION) || \
+     (defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE) && \
+     (defined(CONFIG_TARGET_SOCFPGA_CYCLONE5) || defined(CONFIG_TARGET_SOCFPGA_ARRIA5)))
 #  define part_get_info_ptr(x)	x
 # else
 #  define part_get_info_ptr(x)	NULL
-- 
2.34.1

