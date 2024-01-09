Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC83C47073
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 12:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54F30878FB;
	Tue,  9 Jan 2024 13:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jq+rHwb1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3EB2878CD; Tue,  9 Jan 2024 13:26:28 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BF00878EC
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 13:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E300861209;
 Tue,  9 Jan 2024 12:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053A7C433C7;
 Tue,  9 Jan 2024 12:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704803185;
 bh=ZfiMuWZMEMMpCFGCxvOdnk2Co2X1o61llc87Cip1VEs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jq+rHwb15ye6B2UYyDBd4H8+oVbDdW4Y5iuiky8M/cKAxFPZb1J+NkvvhN3MXuKC7
 AqRpSXy9kbqwUjqUSml0H4ODGjkWuJOQ/+IJiDx60j4dIStT4AKzTpuXWPrhQqsffD
 mOWm7ypA4vcL4f2l4A4Wz0xQho8PfLG5wzhxzflDPaomUGeTyiO2XGdZoJ3cO66a1k
 FXkbX58UETqdw0gDbiK4nOosLqRU59bmCg5WPogOpiCV9JjV25CQe0AphAawSb+3iR
 4IkNhe4vEB0uqXbZ+ilADRfiL7/YKc5Gp37lwboBnb6PnUXcDSyInkrGZnBZj2b9VN
 DqSiGz1iray9w==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com
Cc: nm@ti.com, afd@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
 r-gunasekaran@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 4/4] configs: am64x_evm_a53_defconfig: Enable NAND
Date: Tue,  9 Jan 2024 14:26:05 +0200
Message-Id: <20240109122605.51951-5-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240109122605.51951-1-rogerq@kernel.org>
References: <20240109122605.51951-1-rogerq@kernel.org>
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

Enables configuration required for NAND in SPL and u-boot.

Enable MTD Driver model and MTD + UBI command line utilities.

Add mtdids/mtdparts for NAND as it is required for u-boot's
MTD subsystem commands to recognize NAND partitions.

Add u-boot partition location.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 configs/am64x_evm_a53_defconfig | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index 05e35a8db6..e22153a958 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -66,10 +66,15 @@ CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_MTDIDS_DEFAULT="nand0=omap2-nand.0"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:2m(NAND.tiboot3),2m(NAND.tispl),2m(NAND.tiboot3.backup),4m(NAND.u-boot),256k(NAND.u-boot-env),256k(NAND.u-boot-env.backup),-(NAND.file-system)"
+CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="k3-am642-evm k3-am642-sk"
@@ -107,6 +112,9 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
+CONFIG_MTD=y
+CONFIG_SPL_MTD=y
+CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
@@ -161,3 +169,27 @@ CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_MASS_STORAGE=y
 CONFIG_SPL_DFU=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+CONFIG_MEMORY=y
+CONFIG_SPL_MEMORY=y
+CONFIG_TI_GPMC=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_OMAP_GPMC=y
+CONFIG_CMD_NAND=y
+CONFIG_NAND_OMAP_ELM=y
+CONFIG_NAND_OMAP_ECCSCHEME_BCH8_CODE_HW=y
+CONFIG_SYS_NAND_BLOCK_SIZE=0x40000
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_SYS_NAND_PAGE_SIZE=0x1000
+CONFIG_SYS_NAND_PAGE_COUNT=0x40
+CONFIG_SYS_NAND_OOBSIZE=0x100
+CONFIG_SPL_NAND_SUPPORT=y
+CONFIG_SPL_NAND_DRIVERS=y
+CONFIG_SPL_NAND_BASE=y
+CONFIG_SPL_NAND_IDENT=y
+CONFIG_SPL_NAND_ECC=y
+CONFIG_SYS_NAND_MAX_CHIPS=1
+CONFIG_SYS_MAX_NAND_DEVICE=1
+# CONFIG_SPL_NAND_AM33XX_BCH is not set
+CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
+CONFIG_SYS_NAND_U_BOOT_OFFS=0x600000
-- 
2.34.1

