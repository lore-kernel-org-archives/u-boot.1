Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635AFCCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 11:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DB4583D46;
	Wed,  8 Oct 2025 13:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WPf9LTRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEF3C83A36; Wed,  8 Oct 2025 13:36:16 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82A6283A36
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 13:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 598BaAf93966321;
 Wed, 8 Oct 2025 06:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759923370;
 bh=kVtVqFiCQVEYMK5/sy6LW8wQWPJIJgMDnAa7euFSES8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=WPf9LTRRbWd6NarvCMu046FMdG8S6VWQ+gatT1djPI0SgmjwnjBy15XGPli0QXwhy
 /SorKL1j9PCETfn8Rb3VB6qBbgW1vRbHLrpqLMaiGBInDdPSxalzs16lLcQASssksG
 3/ddB4Orc62Ahp3uK7xwl7OHj91RGK2TGG01PrY4=
Received: from DFLE206.ent.ti.com (dfle206.ent.ti.com [10.64.6.64])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 598BaA5x117387
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 8 Oct 2025 06:36:10 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Oct
 2025 06:36:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 06:36:10 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 598Ba9r32706317;
 Wed, 8 Oct 2025 06:36:09 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v1 1/2] spl: make args file optional in falcon mode
Date: Wed, 8 Oct 2025 17:06:03 +0530
Message-ID: <20251008113605.1055826-2-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008113605.1055826-1-anshuld@ti.com>
References: <20251008113605.1055826-1-anshuld@ti.com>
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

Falcon mode loads a kernel file and an args file which is the
device-tree. However in the case of kernel file being a FIT that
contains the device-tree within it, loading the args file is not
required.

Therefore, this patch introduces a new SPL_OS_BOOT_ARGS config options
that allows us to enable or disable loading of the args file in falcon
mode.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/Kconfig         | 22 +++++++++++++++-------
 common/spl/spl_ext.c       |  4 ++++
 common/spl/spl_fat.c       |  5 +++++
 common/spl/spl_nand.c      |  4 +++-
 common/spl/spl_nor.c       |  2 +-
 common/spl/spl_spi.c       |  5 +++++
 common/spl/spl_ubi.c       |  4 ++++
 include/system-constants.h |  2 +-
 8 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index f20651c3769..475ddacbbc4 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -803,7 +803,7 @@ config SPL_FS_LOAD_KERNEL_NAME
 
 config SPL_FS_LOAD_ARGS_NAME
 	string "File to load for the OS kernel argument parameters from the filesystem"
-	depends on (SPL_FS_EXT4 || SPL_FS_FAT || SPL_FS_SQUASHFS) && SPL_OS_BOOT
+	depends on (SPL_FS_EXT4 || SPL_FS_FAT || SPL_FS_SQUASHFS) && SPL_OS_BOOT_ARGS
 	default "args"
 	help
 	  Filename to read to load for the OS kernel argument parameters from
@@ -1121,7 +1121,7 @@ config SPL_UBI_LOAD_KERNEL_ID
 
 config SPL_UBI_LOAD_ARGS_ID
 	int "id of kernel args volume"
-	depends on SPL_OS_BOOT
+	depends on SPL_OS_BOOT_ARGS
 	help
 	  The UBI volume id from which to load the device tree
 
@@ -1214,9 +1214,16 @@ config SPL_OS_BOOT_SECURE
 	  to use falcon mode by disabling certain inherently non-securable options
 	  in the SPL boot flow.
 
+config SPL_OS_BOOT_ARGS
+	bool "Allow SPL to load args for kernel in falcon mode"
+	depends on SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT
+	help
+	  This option enables the SPL to load an args file (usually the FDT)
+	  alongside the kernel image in falcon boot mode.
+
 config SPL_PAYLOAD_ARGS_ADDR
 	hex "Address in memory to load 'args' file for Falcon Mode to"
-	depends on SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT
+	depends on SPL_OS_BOOT_ARGS
 	default 0x88000000 if ARCH_OMAP2PLUS
 	default 0x99000000 if ARCH_SC5XX && SC59X_64
 	default 0xA0000000 if ARCH_SC5XX && TARGET_SC594_SOM_EZKIT
@@ -1256,7 +1263,7 @@ config SYS_MMCSD_RAW_MODE_KERNEL_SECTOR
 
 config SYS_MMCSD_RAW_MODE_ARGS_SECTOR
 	hex "Falcon mode: Sector to load 'args' from MMC"
-	depends on SPL_FALCON_BOOT_MMCSD
+	depends on SPL_FALCON_BOOT_MMCSD && SPL_OS_BOOT_ARGS
 	help
 	  When Falcon mode is used with an MMC or SD media, SPL needs to know
 	  where to look for the OS 'args', typically a device tree. The
@@ -1266,7 +1273,8 @@ config SYS_MMCSD_RAW_MODE_ARGS_SECTOR
 
 config SYS_MMCSD_RAW_MODE_ARGS_SECTORS
 	hex "Falcon mode: Number of sectors to load for 'args' from MMC"
-	depends on SPL_FALCON_BOOT_MMCSD && SYS_MMCSD_RAW_MODE_ARGS_SECTOR != 0x0
+	depends on SPL_FALCON_BOOT_MMCSD && SYS_MMCSD_RAW_MODE_ARGS_SECTOR != 0x0 \
+		&& SPL_OS_BOOT_ARGS
 
 config SPL_PAYLOAD
 	string "SPL payload"
@@ -1502,14 +1510,14 @@ config SYS_SPI_KERNEL_OFFS
 
 config SYS_SPI_ARGS_OFFS
 	hex "Falcon mode: address of args payload in SPI flash"
-	depends on SPL_SPI_FLASH_SUPPORT && SPL_OS_BOOT
+	depends on SPL_SPI_FLASH_SUPPORT && SPL_OS_BOOT_ARGS
 	help
 	 Address within SPI-Flash from where the args payload (usually the
 	 dtb) is fetched in falcon boot.
 
 config SYS_SPI_ARGS_SIZE
 	hex "Falcon mode: size of args payload in SPI flash"
-	depends on SPL_SPI_FLASH_SUPPORT && SPL_OS_BOOT
+	depends on SPL_SPI_FLASH_SUPPORT && SPL_OS_BOOT_ARGS
 
 config SPL_THERMAL
 	bool "Driver support for thermal devices"
diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
index a3925d38d52..834977f82f5 100644
--- a/common/spl/spl_ext.c
+++ b/common/spl/spl_ext.c
@@ -105,6 +105,7 @@ int spl_load_image_ext_os(struct spl_image_info *spl_image,
 			goto defaults;
 		}
 
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_ARGS)
 		ext4fs_set_blk_dev(block_dev, &part_info);
 		ext4fs_mount();
 		file = env_get("falcon_args_file");
@@ -125,6 +126,7 @@ int spl_load_image_ext_os(struct spl_image_info *spl_image,
 		} else {
 			puts("spl: falcon_args_file not set in environment, falling back to default\n");
 		}
+#endif
 	} else {
 		puts("spl: falcon_image_file not set in environment, falling back to default\n");
 	}
@@ -137,6 +139,7 @@ defaults:
 	if (err)
 		return err;
 
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_ARGS)
 	ext4fs_set_blk_dev(block_dev, &part_info);
 	ext4fs_mount();
 	err = ext4fs_open(CONFIG_SPL_FS_LOAD_ARGS_NAME, &filelen);
@@ -153,6 +156,7 @@ defaults:
 #endif
 		return -1;
 	}
+#endif
 
 	return 0;
 }
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index 80e800b4755..d66b2f7d5e7 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -131,6 +131,7 @@ int spl_load_image_fat_os(struct spl_image_info *spl_image,
 			goto defaults;
 		}
 
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_ARGS)
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
 
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_ARGS)
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
index 93ef2d1c02c..f1cdbb6dbc4 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -79,7 +79,7 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 static int spl_nand_load_image_os(struct spl_image_info *spl_image,
 				  struct spl_boot_device *bootdev)
 {
-	int *src, *dst, err;
+	__maybe_unused int *src, *dst, err;
 	struct legacy_img_hdr *header = spl_get_load_buffer(0, sizeof(*header));
 
 	/* load linux */
@@ -101,6 +101,7 @@ static int spl_nand_load_image_os(struct spl_image_info *spl_image,
 	if (err)
 		return err;
 
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_ARGS)
 	/*
 	 * load parameter image load to temp position since nand_spl_load_image
 	 * reads a whole block which is typically larger than
@@ -116,6 +117,7 @@ static int spl_nand_load_image_os(struct spl_image_info *spl_image,
 	     src++, dst++) {
 		writel(readl(src), dst);
 	}
+#endif
 
 	return 0;
 }
diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
index 6f9ff91bef7..77c77ce6809 100644
--- a/common/spl/spl_nor.c
+++ b/common/spl/spl_nor.c
@@ -69,7 +69,7 @@ static int spl_nor_load_image_os(struct spl_image_info *spl_image,
 	       (void *)(CONFIG_SYS_OS_BASE + sizeof(struct legacy_img_hdr)),
 	       spl_image->size);
 
-#ifdef CONFIG_SPL_PAYLOAD_ARGS_ADDR
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_ARGS)
 	spl_image->arg = (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR;
 #endif
 
diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index cbc864809fe..e3b2074b527 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -61,10 +61,15 @@ static int spl_spi_load_image_os(struct spl_image_info *spl_image,
 	if (err)
 		return err;
 
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_ARGS)
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
index 3c6f80de7d9..a66ada2166c 100644
--- a/common/spl/spl_ubi.c
+++ b/common/spl/spl_ubi.c
@@ -22,10 +22,14 @@ int spl_ubi_load_image_os(struct spl_image_info *spl_image,
 
 	volumes[0].vol_id = CONFIG_SPL_UBI_LOAD_KERNEL_ID;
 	volumes[0].load_addr = (void *)CONFIG_SYS_LOAD_ADDR;
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_ARGS)
 	volumes[1].vol_id = CONFIG_SPL_UBI_LOAD_ARGS_ID;
 	volumes[1].load_addr = (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR;
 
 	err = ubispl_load_volumes(info, volumes, 2);
+#else
+	err = ubispl_load_volumes(info, volumes, 1);
+#endif
 	if (err)
 		return err;
 
diff --git a/include/system-constants.h b/include/system-constants.h
index e09fc418a47..908bf16d0b4 100644
--- a/include/system-constants.h
+++ b/include/system-constants.h
@@ -37,7 +37,7 @@
 	IF_ENABLED_INT(CONFIG_SPL_SYS_MALLOC, CONFIG_SPL_SYS_MALLOC_SIZE)
 
 /* deal with an optional value */
-#ifdef CONFIG_SPL_OS_BOOT
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_ARGS)
 #define SPL_PAYLOAD_ARGS_ADDR	CONFIG_SPL_PAYLOAD_ARGS_ADDR
 #else
 #define SPL_PAYLOAD_ARGS_ADDR	0
-- 
2.51.0

