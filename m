Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4D3CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 19:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05C5C8449C;
	Thu, 27 Nov 2025 20:21:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dId1zSrx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 044AD844BA; Thu, 27 Nov 2025 20:21:56 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DD078444D
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 20:21:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3436cbb723fso912821a91.2
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 11:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764271312; x=1764876112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=pohiPlplcytX5AqlSiGwtZPeJAEMMzPVKAT5ARZJE/s=;
 b=dId1zSrxLF2C8xfM3aGtxpH0QFDiVWxrOMdGGyANLy2kfgW8xkcxzP5mFrm4dBsDz8
 AbdgYTq0QOtzpynEYYa73Mmp7wwNDIzSHPafCQGEVdNsFgi638XtPoJjOUgWmjmSVqdo
 HDUZcd8DS2vbTgciklliQkAcHLlU0z0qYtrvZ4ATBgroXGNeKKn8NtIGzJOlLRs8CNpP
 87E2Kb35KJVfK3h+xmnqOpZocKVRrWGctasro6L8dVtHhX9g7vFr4MRdAZWWSpSD+0St
 HF5Phz9p8UUUblclclANjTsFWd7TTgFmD71mzd52/RW2MumkAl0IS+fpma4da5HnKm/1
 8Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764271312; x=1764876112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pohiPlplcytX5AqlSiGwtZPeJAEMMzPVKAT5ARZJE/s=;
 b=Z1yiPPH/AUwyy7PTYYuVtSlZT32umOJNX02XPiGcy2SWAna5tmCwOd/8YDIf8BaaDU
 TI52CSOe1SJ4WKvjh+8iCvuIM0mhiz0YugXFTKIjahQe0rIINKAdvcslsRuqnzDUsI6g
 QigTe3FYLBEaaEtlnjy2ex9h0y3ttjdz3ZrhbxCMtBGhLZvNAhdUC/ja0LHzkHYSdybl
 7TcTWQ2js++vPsEiiy89NW6PcqtWbekAau2nvg0xPkz3MCo2ZhMlP9YigJ0RCEdWdwhM
 MtAdUjHIWraIlJw7c2Tub800d13BqpansStCJqS8t+VNxhVvsbHC1Oi87n4EOa96ZBsq
 Jzbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP+G3S40LZFfaq5RodGRUnQkKDiqsGiFY+a0uOwu+jEj4XFsVw2B8ekm/C65qW4vpz5LfT8k4=@lists.denx.de
X-Gm-Message-State: AOJu0Yxe5MAOg0p6abVX1qmp0DgT2QlWD02Cj1a4P8M1bwwkSxICaSO0
 H+/BGoXbc3Ijtkm2K2kmSq22gwma2ETYrnYHGRGm+oacpoIkkQK/Z7T4
X-Gm-Gg: ASbGncv4wqFjd3w3+AQYyGDH//PUD+oaNKhMT2lS5Dg/oonAjmG7YKBTjNHvgRdyH5j
 /IJmqDtj16z0jEvEkvObUDubutpwiUix9EHm+OjKd4I8clpeHeb+Xl12wHaAX0WPc7sn3MQG6sW
 DUyWqSo4Yln2iPav9R29Hac1rtVIpS/xJ27ZhWNCr1WWkgiEbsxM0Rg8Tnrqf84SsWj74tO9ezH
 tjLyiOBEsgIvpZdMN9eLDv9dP6eXtKTsbw0hCcllozuUtwWLnt/4qMmQIYL1yuKd2KAdpjEOcsm
 dmCn2R2Ms4eW6dDOXxb9OrULwH+4Kt57yr9nBebGF58OPZP82kVKsjbnUSPQnPyYUvc1Dmy8qz4
 qejY7faf8ZNAIoO8KFzBm2m9Z1tDNj2nHPiBdwvTfW5Is5T17HEyuF600R164WE0C+ujsarZCl+
 zYFeG+jT7x1tp+p6uXUxODUR6bQZ3ICRTqnxKN
X-Google-Smtp-Source: AGHT+IHsAciKz6Fi5sCoKO7iPFol1t5t4aWcQ3IeGuBfbEaktVd8YOjLuC07UuYyzvRvwjtrCbsyyg==
X-Received: by 2002:a17:90b:2547:b0:341:88c9:ca62 with SMTP id
 98e67ed59e1d1-3475ed6a904mr12197193a91.31.1764271311984; 
 Thu, 27 Nov 2025 11:21:51 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7d151ad4d6esm2662125b3a.26.2025.11.27.11.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 11:21:51 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Chee Tien Fong <tienfong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v1] Fix socfpga GEN5 boot by spl+u-boot sfp on RAW
Date: Fri, 28 Nov 2025 03:21:36 +0800
Message-ID: <20251127192136.168-1-briansune@gmail.com>
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
All three TYPE, #, OFFSET mode methods are
nonfunctionable on combined raw boot.
Explain a bit on the cause and solutions.
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
 common/spl/spl_mmc.c | 17 ++++++++++++-----
 include/part.h       |  3 ++-
 3 files changed, 21 insertions(+), 7 deletions(-)

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
index d8ce3a84614..e50391e49e5 100644
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
@@ -106,7 +109,8 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
 	return 0;
 }
 
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
+    defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
 static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
 					struct spl_boot_device *bootdev,
 					struct mmc *mmc, int partition,
@@ -136,7 +140,9 @@ static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
 		return ret;
 	}
 
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
+#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR) || \
+    defined(CONFIG_TARGET_SOCFPGA_CYCLONE5) || \
+    defined(CONFIG_TARGET_SOCFPGA_ARRIA5)
 	return mmc_load_image_raw_sector(spl_image, bootdev, mmc, info.start + sector);
 #else
 	return mmc_load_image_raw_sector(spl_image, bootdev, mmc, info.start);
@@ -419,10 +425,11 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 
 		raw_sect = spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
 
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
+    defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
 		ret = mmc_load_image_raw_partition(spl_image, bootdev,
 						   mmc, raw_part,
-						   raw_sect);
+						   raw_sect + spl_mmc_raw_uboot_offset(part));
 		if (!ret)
 			return 0;
 #endif
diff --git a/include/part.h b/include/part.h
index 6caaa6526aa..378769b6bef 100644
--- a/include/part.h
+++ b/include/part.h
@@ -461,7 +461,8 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
 #ifdef CONFIG_XPL_BUILD
 # define part_print_ptr(x)	NULL
 # if defined(CONFIG_SPL_FS_EXT4) || defined(CONFIG_SPL_FS_FAT) || \
-	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION)
+     defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
+     defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
 #  define part_get_info_ptr(x)	x
 # else
 #  define part_get_info_ptr(x)	NULL
-- 
2.34.1

