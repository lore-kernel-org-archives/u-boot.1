Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284E5CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 11:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61F8B844F0;
	Thu,  9 Oct 2025 13:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WwUWQsFa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFFD8844D2; Thu,  9 Oct 2025 13:58:58 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93AF284480
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 13:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 599Bwq01453786;
 Thu, 9 Oct 2025 06:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760011132;
 bh=Y1YaG8bV7maXR2Td5R/QAq6aKdDlrZunTF+AsIOrWCY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=WwUWQsFapK9RQxQ0h8CNA7Al9a+LmFuwv/sc9rHwkl1047ExjUwWkr8cOxYU7mvvj
 OXfsVtC/CnxFTH8CLbHDGP+qoBM4OR+TLYTcdbb3HYIIS2BNyEvsQT6TivCj5gDyP5
 LrQDjAL9eCCY+50qBsHPLyTxpELJTL5BiVRx6K44=
Received: from DFLE204.ent.ti.com (dfle204.ent.ti.com [10.64.6.62])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 599BwqM4281690
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 Oct 2025 06:58:52 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Oct
 2025 06:58:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Oct 2025 06:58:51 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 599BwoOh210010;
 Thu, 9 Oct 2025 06:58:51 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 1/3] spl: make args file optional in falcon mode
Date: Thu, 9 Oct 2025 17:28:43 +0530
Message-ID: <20251009115846.897186-2-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009115846.897186-1-anshuld@ti.com>
References: <20251009115846.897186-1-anshuld@ti.com>
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
 common/spl/Kconfig         | 21 ++++++++++++++-------
 common/spl/spl.c           |  8 ++++++--
 common/spl/spl_ext.c       |  4 ++++
 common/spl/spl_fat.c       |  5 +++++
 common/spl/spl_nand.c      |  5 ++++-
 common/spl/spl_spi.c       |  5 +++++
 common/spl/spl_ubi.c       |  4 ++++
 include/system-constants.h |  2 +-
 8 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index f20651c3769..22ef43c3a6e 100644
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
@@ -1266,7 +1273,7 @@ config SYS_MMCSD_RAW_MODE_ARGS_SECTOR
 
 config SYS_MMCSD_RAW_MODE_ARGS_SECTORS
 	hex "Falcon mode: Number of sectors to load for 'args' from MMC"
-	depends on SPL_FALCON_BOOT_MMCSD && SYS_MMCSD_RAW_MODE_ARGS_SECTOR != 0x0
+	depends on SPL_FALCON_BOOT_MMCSD && SPL_OS_BOOT_ARGS
 
 config SPL_PAYLOAD
 	string "SPL payload"
@@ -1502,14 +1509,14 @@ config SYS_SPI_KERNEL_OFFS
 
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
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 55ad497c86d..f1a1785beef 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -692,6 +692,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	spl_jump_to_image_t jumper = &jump_to_image;
 	struct spl_image_info spl_image;
 	int ret, os;
+	void *fdt;
 
 	debug(">>" PHASE_PROMPT "board_init_r()\n");
 
@@ -793,8 +794,11 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		jumper = &spl_invoke_opensbi;
 	} else if (CONFIG_IS_ENABLED(OS_BOOT) && os == IH_OS_LINUX) {
 		debug("Jumping to Linux\n");
-		if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
-			spl_fixup_fdt((void *)SPL_PAYLOAD_ARGS_ADDR);
+		if (CONFIG_IS_ENABLED(OS_BOOT_ARGS))
+			fdt = (void *)SPL_PAYLOAD_ARGS_ADDR;
+		else
+			fdt = spl_image_fdt_addr(&spl_image);
+		spl_fixup_fdt(fdt);
 		spl_board_prepare_for_linux();
 		jumper = &jump_to_image_linux;
 	} else {
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
index 93ef2d1c02c..1e5c0fd5be9 100644
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
@@ -101,12 +101,14 @@ static int spl_nand_load_image_os(struct spl_image_info *spl_image,
 	if (err)
 		return err;
 
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_ARGS)
 	/*
 	 * load parameter image load to temp position since nand_spl_load_image
 	 * reads a whole block which is typically larger than
 	 * CONFIG_CMD_SPL_WRITE_SIZE therefore may overwrite following sections
 	 * like BSS
 	 */
+	int *src, *dst;
 	nand_spl_load_image(CONFIG_CMD_SPL_NAND_OFS, CONFIG_CMD_SPL_WRITE_SIZE,
 			    (void *)CONFIG_TEXT_BASE);
 	/* copy to destintion */
@@ -116,6 +118,7 @@ static int spl_nand_load_image_os(struct spl_image_info *spl_image,
 	     src++, dst++) {
 		writel(readl(src), dst);
 	}
+#endif
 
 	return 0;
 }
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

