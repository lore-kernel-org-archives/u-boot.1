Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89A6CAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 13:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6C4D8340C;
	Thu, 11 Sep 2025 15:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F/E6oMqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B534D833C0; Thu, 11 Sep 2025 15:14:50 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 705A78340C
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 15:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BDEkGC297110;
 Thu, 11 Sep 2025 08:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757596486;
 bh=6dOyNqLYHHJE2RWK/CFPBAabcmjdl+0M5C3rcasjvVo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=F/E6oMqbQPxjtBppLfo35ouGjcXnNTfk/0NEbtR8Bwx6b2h2ijm1hvwR2Zmx/iAZc
 257cxkF82WulK/jE52CX5P/rBBPnd0KSRPe4BCMU8ZwranbOcm/tLtGwDw8C2GQQrt
 7gfcBFgmFMbvQKY795gTSmUXQbcFY9jE3qyR3bG8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BDEk3E1179255
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 08:14:46 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 08:14:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 08:14:45 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BDEioe2169044;
 Thu, 11 Sep 2025 08:14:45 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH RFT v1 14/17] spl: falcon: prevent loading args file in secure
 os boot
Date: Thu, 11 Sep 2025 18:44:10 +0530
Message-ID: <20250911131414.3296697-15-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911131414.3296697-1-anshuld@ti.com>
References: <20250911131414.3296697-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

The expected payload for the SPL in secure falcon mode is a fitImage
that contains the kernel image and the DT. This removes the need to load
an additional args file, which exposes an additional attack vector since
it can not be verified.

Therefore this patch disables loading of the arg file when
SPL_OS_BOOT_SECURE is set.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/Kconfig         | 18 +++++++++++-------
 common/spl/spl_ext.c       |  4 ++++
 common/spl/spl_fat.c       |  5 +++++
 common/spl/spl_nand.c      |  5 ++++-
 common/spl/spl_spi.c       |  5 +++++
 common/spl/spl_ubi.c       |  4 ++++
 include/system-constants.h |  2 +-
 7 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 4f817fd31c5..34e60a224ef 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -796,6 +796,7 @@ config SPL_FS_LOAD_PAYLOAD_NAME
 config SPL_FS_LOAD_KERNEL_NAME
 	string "File to load for the OS kernel from the filesystem"
 	depends on (SPL_FS_EXT4 || SPL_FS_FAT || SPL_FS_SQUASHFS) && SPL_OS_BOOT
+	default "fitImage" if SPL_OS_BOOT_SECURE
 	default "uImage"
 	help
 	  Filename to read to load for the OS kernel when reading from the
@@ -803,7 +804,8 @@ config SPL_FS_LOAD_KERNEL_NAME
 
 config SPL_FS_LOAD_ARGS_NAME
 	string "File to load for the OS kernel argument parameters from the filesystem"
-	depends on (SPL_FS_EXT4 || SPL_FS_FAT || SPL_FS_SQUASHFS) && SPL_OS_BOOT
+	depends on (SPL_FS_EXT4 || SPL_FS_FAT || SPL_FS_SQUASHFS) && SPL_OS_BOOT \
+		&& !(SPL_OS_BOOT_SECURE)
 	default "args"
 	help
 	  Filename to read to load for the OS kernel argument parameters from
@@ -1121,7 +1123,7 @@ config SPL_UBI_LOAD_KERNEL_ID
 
 config SPL_UBI_LOAD_ARGS_ID
 	int "id of kernel args volume"
-	depends on SPL_OS_BOOT
+	depends on SPL_OS_BOOT && !SPL_OS_BOOT_SECURE
 	help
 	  The UBI volume id from which to load the device tree
 
@@ -1217,7 +1219,8 @@ config SPL_OS_BOOT_SECURE
 
 config SPL_PAYLOAD_ARGS_ADDR
 	hex "Address in memory to load 'args' file for Falcon Mode to"
-	depends on SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT
+	depends on (SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT) \
+		&& !SPL_OS_BOOT_SECURE
 	default 0x88000000 if ARCH_OMAP2PLUS
 	default 0x99000000 if ARCH_SC5XX && SC59X_64
 	default 0xA0000000 if ARCH_SC5XX && TARGET_SC594_SOM_EZKIT
@@ -1257,7 +1260,7 @@ config SYS_MMCSD_RAW_MODE_KERNEL_SECTOR
 
 config SYS_MMCSD_RAW_MODE_ARGS_SECTOR
 	hex "Falcon mode: Sector to load 'args' from MMC"
-	depends on SPL_FALCON_BOOT_MMCSD
+	depends on SPL_FALCON_BOOT_MMCSD && !SPL_OS_BOOT_SECURE
 	help
 	  When Falcon mode is used with an MMC or SD media, SPL needs to know
 	  where to look for the OS 'args', typically a device tree. The
@@ -1267,7 +1270,8 @@ config SYS_MMCSD_RAW_MODE_ARGS_SECTOR
 
 config SYS_MMCSD_RAW_MODE_ARGS_SECTORS
 	hex "Falcon mode: Number of sectors to load for 'args' from MMC"
-	depends on SPL_FALCON_BOOT_MMCSD && SYS_MMCSD_RAW_MODE_ARGS_SECTOR != 0x0
+	depends on SPL_FALCON_BOOT_MMCSD && SYS_MMCSD_RAW_MODE_ARGS_SECTOR != 0x0 \
+		&& !SPL_OS_BOOT_SECURE
 
 config SPL_PAYLOAD
 	string "SPL payload"
@@ -1503,14 +1507,14 @@ config SYS_SPI_KERNEL_OFFS
 
 config SYS_SPI_ARGS_OFFS
 	hex "Falcon mode: address of args payload in SPI flash"
-	depends on SPL_SPI_FLASH_SUPPORT && SPL_OS_BOOT
+	depends on SPL_SPI_FLASH_SUPPORT && SPL_OS_BOOT && !SPL_OS_BOOT_SECURE
 	help
 	 Address within SPI-Flash from where the args payload (usually the
 	 dtb) is fetched in falcon boot.
 
 config SYS_SPI_ARGS_SIZE
 	hex "Falcon mode: size of args payload in SPI flash"
-	depends on SPL_SPI_FLASH_SUPPORT && SPL_OS_BOOT
+	depends on SPL_SPI_FLASH_SUPPORT && SPL_OS_BOOT && !SPL_OS_BOOT_SECURE
 
 config SPL_THERMAL
 	bool "Driver support for thermal devices"
diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
index f556986bf5a..001060afe96 100644
--- a/common/spl/spl_ext.c
+++ b/common/spl/spl_ext.c
@@ -104,6 +104,7 @@ int spl_load_image_ext_os(struct spl_image_info *spl_image,
 			puts("spl: falling back to default\n");
 			goto defaults;
 		}
+#ifdef CONFIG_SPL_PAYLOAD_ARGS_ADDR
 		file = env_get("falcon_args_file");
 		if (file) {
 			err = ext4fs_open(file, &filelen);
@@ -122,6 +123,7 @@ int spl_load_image_ext_os(struct spl_image_info *spl_image,
 		} else {
 			puts("spl: falcon_args_file not set in environment, falling back to default\n");
 		}
+#endif
 	} else {
 		puts("spl: falcon_image_file not set in environment, falling back to default\n");
 	}
@@ -134,6 +136,7 @@ defaults:
 	if (err)
 		return err;
 
+#ifdef CONFIG_SPL_PAYLOAD_ARGS_ADDR
 	err = ext4fs_open(CONFIG_SPL_FS_LOAD_ARGS_NAME, &filelen);
 	if (err < 0) {
 		puts("spl: ext4fs_open failed\n");
@@ -148,6 +151,7 @@ defaults:
 #endif
 		return -1;
 	}
+#endif
 
 	return 0;
 }
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index 80e800b4755..8a724aa8acb 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -131,6 +131,7 @@ int spl_load_image_fat_os(struct spl_image_info *spl_image,
 			goto defaults;
 		}
 
+#ifdef CONFIG_SPL_PAYLOAD_ARGS_ADDR
 		file = env_get("falcon_args_file");
 		if (file) {
 			err = file_fat_read(
@@ -143,6 +144,8 @@ int spl_load_image_fat_os(struct spl_image_info *spl_image,
 			return 0;
 		} else
 			puts("spl: falcon_args_file not set in environment, falling back to default\n");
+#endif
+
 	} else
 		puts("spl: falcon_image_file not set in environment, falling back to default\n");
 
@@ -154,6 +157,7 @@ defaults:
 	if (err)
 		return err;
 
+#ifdef CONFIG_SPL_PAYLOAD_ARGS_ADDR
 	err = file_fat_read(CONFIG_SPL_FS_LOAD_ARGS_NAME,
 			    (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR, 0);
 	if (err <= 0) {
@@ -161,6 +165,7 @@ defaults:
 		       CONFIG_SPL_FS_LOAD_ARGS_NAME, err);
 		return err;
 	}
+#endif
 
 	return 0;
 }
diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index ff7087da1df..6c58a41ceef 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -79,7 +79,7 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 static int spl_nand_load_image_os(struct spl_image_info *spl_image,
 				  struct spl_boot_device *bootdev)
 {
-	int *src, *dst, err;
+	int err;
 	struct legacy_img_hdr *header = spl_get_load_buffer(0, sizeof(*header));
 
 	/* load linux */
@@ -102,6 +102,8 @@ static int spl_nand_load_image_os(struct spl_image_info *spl_image,
 	if (err)
 		return err;
 
+#ifdef CONFIG_SPL_PAYLOAD_ARGS_ADDR
+	int *src, *dst;
 	/*
 	 * load parameter image load to temp position since nand_spl_load_image
 	 * reads a whole block which is typically larger than
@@ -117,6 +119,7 @@ static int spl_nand_load_image_os(struct spl_image_info *spl_image,
 	     src++, dst++) {
 		writel(readl(src), dst);
 	}
+#endif
 
 	return 0;
 }
diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index cbc864809fe..5fe21f0bf0f 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -61,10 +61,15 @@ static int spl_spi_load_image_os(struct spl_image_info *spl_image,
 	if (err)
 		return err;
 
+#ifdef CONFIG_SPL_PAYLOAD_ARGS_ADDR
 	/* Read device tree. */
 	return spi_flash_read(flash, CONFIG_SYS_SPI_ARGS_OFFS,
 			      CONFIG_SYS_SPI_ARGS_SIZE,
 			      (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR);
+#else
+	return 0;
+#endif
+
 }
 #endif
 
diff --git a/common/spl/spl_ubi.c b/common/spl/spl_ubi.c
index 3c6f80de7d9..c43182c6415 100644
--- a/common/spl/spl_ubi.c
+++ b/common/spl/spl_ubi.c
@@ -22,10 +22,14 @@ int spl_ubi_load_image_os(struct spl_image_info *spl_image,
 
 	volumes[0].vol_id = CONFIG_SPL_UBI_LOAD_KERNEL_ID;
 	volumes[0].load_addr = (void *)CONFIG_SYS_LOAD_ADDR;
+#ifdef CONFIG_SPL_PAYLOAD_ARGS_ADDR
 	volumes[1].vol_id = CONFIG_SPL_UBI_LOAD_ARGS_ID;
 	volumes[1].load_addr = (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR;
 
 	err = ubispl_load_volumes(info, volumes, 2);
+#else
+	err = ubispl_load_volumes(info, volumes, 1);
+#endif
 	if (err)
 		return err;
 
diff --git a/include/system-constants.h b/include/system-constants.h
index e09fc418a47..d5300428a39 100644
--- a/include/system-constants.h
+++ b/include/system-constants.h
@@ -37,7 +37,7 @@
 	IF_ENABLED_INT(CONFIG_SPL_SYS_MALLOC, CONFIG_SPL_SYS_MALLOC_SIZE)
 
 /* deal with an optional value */
-#ifdef CONFIG_SPL_OS_BOOT
+#ifdef CONFIG_SPL_PAYLOAD_ARGS_ADDR
 #define SPL_PAYLOAD_ARGS_ADDR	CONFIG_SPL_PAYLOAD_ARGS_ADDR
 #else
 #define SPL_PAYLOAD_ARGS_ADDR	0
-- 
2.51.0

