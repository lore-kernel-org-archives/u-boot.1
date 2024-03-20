Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4D5C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 09:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC935880E5;
	Wed, 20 Mar 2024 10:02:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="jgZLnswB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85AF388101; Wed, 20 Mar 2024 10:02:21 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8300087E39
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 10:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1710925337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJl2jL0Qdp0SuyB/V0tgEcjTMG3JadbVaXcVOp1O8yE=;
 b=jgZLnswBtQK6TAo/YEWWqiiota1HxDWHPQcbQY1S6mSvNjw6uZU/eOlL+DAfW1GI/yTe1v
 z55qtd2tgt7I21icQzE+hWBd4dSjJ9DMoG/0jI44bz8CDNzrFB3UrMmjJsQwPL5Q0crhWF
 hkjDM+7d/Kq9Asy74Cw0rZIo/5m9wJ6z+hoLc175p7kmIRDzAHlvXe4h3T/AJQ7U5rW0xu
 OpWRr4xn/WckJh4h2/5uYGyaT5UlvL0gUhT5MT8W+ARiBpC3os3hppBR//JAq4mNm+cWKx
 x/mjTFq8UuOjgGczIFfpx3xVSAAsGzlHaatsI9M4R/RwYyAcx3HLiGeSJ/uALg==
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Mihai Sain <mihai.sain@microchip.com>, Li Bin <bin.li@microchip.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 3/6] mtd: nand: raw: Fix (most) Kconfig indentation
Date: Wed, 20 Mar 2024 10:02:11 +0100
Message-Id: <20240320090214.40465-4-ada@thorsis.com>
In-Reply-To: <20240320090214.40465-1-ada@thorsis.com>
References: <20240320090214.40465-1-ada@thorsis.com>
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

One tab in general.  One tab plus two spaces for help text.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
---

Notes:
    v1:
    - initial patch version
    
    v2:
    - collected tags

 drivers/mtd/nand/raw/Kconfig | 106 +++++++++++++++++------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index bb9994b8626..f6644899b0a 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -1,6 +1,6 @@
-
 menuconfig MTD_RAW_NAND
 	bool "Raw NAND Device Support"
+
 if MTD_RAW_NAND
 
 config SYS_NAND_SELF_INIT
@@ -49,12 +49,12 @@ config SYS_NAND_NO_SUBPAGE_WRITE
 	depends on NAND_ARASAN || NAND_DAVINCI || NAND_KIRKWOOD
 
 config DM_NAND_ATMEL
-       bool "Support Atmel NAND controller with DM support"
-       select SYS_NAND_SELF_INIT
-       imply SYS_NAND_USE_FLASH_BBT
-       help
-         Enable this driver for NAND flash platforms using an Atmel NAND
-         controller.
+	bool "Support Atmel NAND controller with DM support"
+	select SYS_NAND_SELF_INIT
+	imply SYS_NAND_USE_FLASH_BBT
+	help
+	  Enable this driver for NAND flash platforms using an Atmel NAND
+	  controller.
 
 config NAND_ATMEL
 	bool "Support Atmel NAND controller"
@@ -133,35 +133,35 @@ config NAND_BRCMNAND_6753
 	  Enable support for broadcom nand driver on bcm6753.
 
 config NAND_BRCMNAND_68360
-       bool "Support Broadcom NAND controller on bcm68360"
-       depends on NAND_BRCMNAND && BCM6856
-       help
-         Enable support for broadcom nand driver on bcm68360.
+	bool "Support Broadcom NAND controller on bcm68360"
+	depends on NAND_BRCMNAND && BCM6856
+	help
+	  Enable support for broadcom nand driver on bcm68360.
 
 config NAND_BRCMNAND_6838
-       bool "Support Broadcom NAND controller on bcm6838"
-       depends on NAND_BRCMNAND && ARCH_BMIPS && SOC_BMIPS_BCM6838
-       help
-         Enable support for broadcom nand driver on bcm6838.
+	bool "Support Broadcom NAND controller on bcm6838"
+	depends on NAND_BRCMNAND && ARCH_BMIPS && SOC_BMIPS_BCM6838
+	help
+	  Enable support for broadcom nand driver on bcm6838.
 
 config NAND_BRCMNAND_6858
-       bool "Support Broadcom NAND controller on bcm6858"
-       depends on NAND_BRCMNAND && BCM6858
-       help
-         Enable support for broadcom nand driver on bcm6858.
+	bool "Support Broadcom NAND controller on bcm6858"
+	depends on NAND_BRCMNAND && BCM6858
+	help
+	  Enable support for broadcom nand driver on bcm6858.
 
 config NAND_BRCMNAND_63158
-       bool "Support Broadcom NAND controller on bcm63158"
-       depends on NAND_BRCMNAND && BCM63158
-       help
-         Enable support for broadcom nand driver on bcm63158.
+	bool "Support Broadcom NAND controller on bcm63158"
+	depends on NAND_BRCMNAND && BCM63158
+	help
+	  Enable support for broadcom nand driver on bcm63158.
 
 config NAND_BRCMNAND_IPROC
-       bool "Support Broadcom NAND controller on the iproc family"
-       depends on NAND_BRCMNAND
-       help
-         Enable support for broadcom nand driver on the Broadcom
-         iproc family such as Northstar (BCM5301x, BCM4708...)
+	bool "Support Broadcom NAND controller on the iproc family"
+	depends on NAND_BRCMNAND
+	help
+	  Enable support for broadcom nand driver on the Broadcom
+	  iproc family such as Northstar (BCM5301x, BCM4708...)
 
 config NAND_DAVINCI
 	bool "Support TI Davinci NAND controller"
@@ -413,10 +413,10 @@ config NAND_VF610_NFC
 if NAND_VF610_NFC
 
 config NAND_VF610_NFC_DT
-        bool "Support Vybrid's vf610 NAND controller as a DT device"
-        depends on OF_CONTROL && DM_MTD
-        help
-          Enable the driver for Vybrid's vf610 NAND flash on platforms
+	bool "Support Vybrid's vf610 NAND controller as a DT device"
+	depends on OF_CONTROL && DM_MTD
+	help
+	  Enable the driver for Vybrid's vf610 NAND flash on platforms
 	  using device tree.
 
 choice
@@ -472,11 +472,11 @@ config NAND_SUNXI
 	select SPL_NAND_SUPPORT
 	select SPL_SYS_NAND_SELF_INIT
 	imply CMD_NAND
-	---help---
-	Enable support for NAND. This option enables the standard and
-	SPL drivers.
-	The SPL driver only supports reading from the NAND using DMA
-	transfers.
+	help
+	  Enable support for NAND. This option enables the standard and
+	  SPL drivers.
+	  The SPL driver only supports reading from the NAND using DMA
+	  transfers.
 
 if NAND_SUNXI
 
@@ -577,16 +577,16 @@ config NAND_OCTEONTX
 	select SYS_NAND_SELF_INIT
 	imply CMD_NAND
 	help
-	 This enables Nand flash controller hardware found on the OcteonTX
-	 processors.
+	  This enables Nand flash controller hardware found on the OcteonTX
+	  processors.
 
 config NAND_OCTEONTX_HW_ECC
 	bool "Support Hardware ECC for OcteonTX NAND controller"
 	depends on NAND_OCTEONTX
 	default y
 	help
-	 This enables Hardware BCH engine found on the OcteonTX processors to
-	 support ECC for NAND flash controller.
+	  This enables Hardware BCH engine found on the OcteonTX processors to
+	  support ECC for NAND flash controller.
 
 config NAND_STM32_FMC2
 	bool "Support for NAND controller on STM32MP SoCs"
@@ -751,37 +751,37 @@ config SYS_NAND_BAD_BLOCK_POS
 config SYS_NAND_U_BOOT_LOCATIONS
 	bool "Define U-Boot binaries locations in NAND"
 	help
-	Enable CONFIG_SYS_NAND_U_BOOT_OFFS though Kconfig.
-	This option should not be enabled when compiling U-Boot for boards
-	defining CONFIG_SYS_NAND_U_BOOT_OFFS in their include/configs/<board>.h
-	file.
+	  Enable CONFIG_SYS_NAND_U_BOOT_OFFS though Kconfig.
+	  This option should not be enabled when compiling U-Boot for boards
+	  defining CONFIG_SYS_NAND_U_BOOT_OFFS in their include/configs/<board>.h
+	  file.
 
 config SYS_NAND_U_BOOT_OFFS
 	hex "Location in NAND to read U-Boot from"
 	default 0x800000 if NAND_SUNXI
 	depends on SYS_NAND_U_BOOT_LOCATIONS
 	help
-	Set the offset from the start of the nand where u-boot should be
-	loaded from.
+	  Set the offset from the start of the nand where u-boot should be
+	  loaded from.
 
 config SYS_NAND_U_BOOT_OFFS_REDUND
 	hex "Location in NAND to read U-Boot from"
 	default SYS_NAND_U_BOOT_OFFS
 	depends on SYS_NAND_U_BOOT_LOCATIONS
 	help
-	Set the offset from the start of the nand where the redundant u-boot
-	should be loaded from.
+	  Set the offset from the start of the nand where the redundant u-boot
+	  should be loaded from.
 
 config SPL_NAND_AM33XX_BCH
 	bool "Enables SPL-NAND driver which supports ELM based"
 	depends on SPL_NAND_SUPPORT && NAND_OMAP_GPMC && !OMAP34XX
 	default y
-        help
+	help
 	  Hardware ECC correction. This is useful for platforms which have ELM
 	  hardware engine and use NAND boot mode.
 	  Some legacy platforms like OMAP3xx do not have in-built ELM h/w engine,
 	  so those platforms should use CONFIG_SPL_NAND_SIMPLE for enabling
-          SPL-NAND driver with software ECC correction support.
+	  SPL-NAND driver with software ECC correction support.
 
 config SPL_NAND_DENALI
 	bool "Support Denali NAND controller for SPL"
@@ -810,6 +810,6 @@ config SYS_NAND_HW_ECC_OOBFIRST
 	bool "In SPL, read the OOB first and then the data from NAND"
 	depends on SPL_NAND_SIMPLE
 
-endif
+endif	# if SPL
 
-endif   # if NAND
+endif	# if MTD_RAW_NAND
-- 
2.39.2

