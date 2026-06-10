Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E132CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 314D78494B;
	Wed, 10 Jun 2026 16:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P76Mw9z4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48893849B4; Wed, 10 Jun 2026 16:39:24 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16A0A8494B
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68d05f6b3cbso1274978a12.1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102361; x=1781707161; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tEgUvvtEMw6MyDdqXDxyyeldR3zlXqvcjLlUMOeqTos=;
 b=P76Mw9z4Yi9Qz5XjDQNdHNMHFTltatuZYLiYdLMtEjt079do8MoOE/yZjBeuMqVCio
 wl/hMiR/C//fqWsBdIfLUFpd/C6659S1+bk7hhj8upZ2I5AMbtXhb1LGdMA3gfyYf3pc
 fjEgWhB3Ly0nG2AUrKJKqmEC0i/1li7/31ALI5F7e9HS/BMQdq4777nSPauMsU5kqVos
 Zb5dH2OZqRtIupqfd8ZLVD5ryNm+z1t1Ju40jDxzA2BxnRVmaavThYQfFdceCBLQBHbp
 cI03AZranEDULwS5HRwbVuvPDtRysy+mAl50JA03/Yo17qevn0phQ557lfwj5fJvatNj
 RNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102361; x=1781707161;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tEgUvvtEMw6MyDdqXDxyyeldR3zlXqvcjLlUMOeqTos=;
 b=UF63NM1xYvCXJfmZBj8alfBhUrj3JA/4r5EpDeO/R3DOF4efeN63l+BkkdBaNSd8Vl
 pdw+yByIpKVZCRgfrJxP3e0udPDB0DTuY+U1UrFOtClcX0p+h3NzCuukbT+OMe/AOxPw
 FW8eHf4drwPFzdXITtJieiQI1DBlKhghtqbTGetDkCCgIt27DfcVBzMRy2F6zQnGNgdo
 d1TmF+Byjq/BuZWwh77dZWOHYC3I8v7nTugwtFNsCDp9K8CWTf2ThoM6jyOintUIjcSR
 DwQqFBJgLBUm4nPDvLUobeXjkal0hcAgphD/xFNLPcZXC0a2bv7ufnCFmpRbAqaegehn
 +fkw==
X-Gm-Message-State: AOJu0YzALALM7IqAIPrYDVpKoHI9R0LpApR8PTHU2xfsr12mhupnizKK
 /DdJOg7ETXtnexkFWjf2WVwPWhuZqqNR3VrN8Evzx0CCQLTecXrAA+7zmo340g==
X-Gm-Gg: Acq92OFYCs6L7C19eLLcSzgCwT2uxZvQ/a3eBw5e46JOsGk5zdXLmnCoqRpzAQereML
 NJweWDt7d8WUjZCh8CCD5uLNWljbFMKIyRmB0oL3lyrrXDzoeJ1tuDj43LG2gLs0+tFq9SoO+Rl
 uwlDuj0kG+ebo7C0tWvNDXtlySbpS/HrV+rwwq9JIaRTyg7YX5pc3YZ7IIYpIZpl2HrFA1ywIa2
 M1O+6nVyYwSUptOb9gvp0J8JgSyEibCiuJn0owGTzxKKYRCCS4fbk9MeciRXdgp/yTaqBh6tIxz
 aGsWZJLZpxL3EQEMM+0ifTOnSB+3Wb5CrrmHgl2yTb52Vtt3T25i9/SB/bRmDAXqhIj/qS2qLpF
 tzVWZ8dZSGop84toSt7UstFOeS8g32EVFFeayHYAS5UQ/Clllw0NnLd61/kPpK2VaL275J4s+8D
 qrH2M3Ns47JCqR7++3MgGK6bN/sFiKt9cZ57GxJwZEtn0f7Ec0OG6GA3jPSg4kd6uPcw/6Ov2M
X-Received: by 2002:a05:6402:3609:b0:688:1d01:407b with SMTP id
 4fb4d7f45d1cf-68fa503aea8mr5502018a12.4.1781102361301; 
 Wed, 10 Jun 2026 07:39:21 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e6595c722sm9998515a12.22.2026.06.10.07.39.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:39:20 -0700 (PDT)
Message-ID: <a8b1a835-e7d1-4e96-ba87-80d604e7d529@gmail.com>
Date: Wed, 10 Jun 2026 16:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 10/18] Kconfig: mtd: restyle
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Restyle all Kconfigs for "mtd":
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/mtd/Kconfig          | 20 +++++------
 drivers/mtd/nand/raw/Kconfig | 70 ++++++++++++++++++------------------
 drivers/mtd/spi/Kconfig      | 54 ++++++++++++++--------------
 drivers/mtd/ubi/Kconfig      |  4 +--
 4 files changed, 74 insertions(+), 74 deletions(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 21b8b21f6b22..38d6dd142ddc 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -205,16 +205,16 @@ config HBMC_AM654
 	bool "HyperBus controller driver for AM65x SoC"
 	depends on MULTIPLEXER && (MUX_MMIO || SPL_MUX_MMIO)
 	help
-	 This is the driver for HyperBus controller on TI's AM65x and
-	 other SoCs
+	  This is the driver for HyperBus controller on TI's AM65x and
+	  other SoCs

 config STM32_FLASH
 	bool "STM32 MCU Flash driver"
 	depends on ARCH_STM32
 	select USE_SYS_MAX_FLASH_BANKS
 	help
-	 This is the driver of embedded flash for some STMicroelectronics
-	 STM32 MCU.
+	  This is the driver of embedded flash for some STMicroelectronics
+	  STM32 MCU.

 config SYS_MAX_FLASH_SECT
 	int "Maximum number of sectors on a flash chip"
@@ -236,17 +236,17 @@ config SYS_MAX_FLASH_BANKS
 	depends on USE_SYS_MAX_FLASH_BANKS
 	default 1
 	help
-	 Max number of Flash memory banks using by the MTD framework, in the
-	 flash CFI driver and in some other driver to define the flash_info
-	 struct declaration.
+	  Max number of Flash memory banks using by the MTD framework, in the
+	  flash CFI driver and in some other driver to define the flash_info
+	  struct declaration.

 config SYS_MAX_FLASH_BANKS_DETECT
 	bool "Detection of flash banks number in CFI driver"
 	depends on CFI_FLASH && FLASH_CFI_DRIVER
 	help
-	 This enables detection of number of flash banks in CFI driver,
-	 to reduce the effective number of flash bank, between 0 and
-	 CONFIG_SYS_MAX_FLASH_BANKS
+	  This enables detection of number of flash banks in CFI driver,
+	  to reduce the effective number of flash bank, between 0 and
+	  CONFIG_SYS_MAX_FLASH_BANKS

 source "drivers/mtd/nand/Kconfig"

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 2999e6b1710c..d00ba27c324f 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -310,32 +310,32 @@ choice
 	prompt "ECC scheme"
 	default NAND_OMAP_ECCSCHEME_BCH8_CODE_HW
 	help
-	On OMAP platforms, this CONFIG specifies NAND ECC scheme.
-	It can take following values:
-	OMAP_ECC_HAM1_CODE_SW
-		1-bit Hamming code using software lib.
-		(for legacy devices only)
-	OMAP_ECC_HAM1_CODE_HW
-		1-bit Hamming code using GPMC hardware.
-		(for legacy devices only)
-	OMAP_ECC_BCH4_CODE_HW_DETECTION_SW
-		4-bit BCH code (unsupported)
-	OMAP_ECC_BCH4_CODE_HW
-		4-bit BCH code (unsupported)
-	OMAP_ECC_BCH8_CODE_HW_DETECTION_SW
-		8-bit BCH code with
-		- ecc calculation using GPMC hardware engine,
-		- error detection using software library.
-		- requires CONFIG_BCH to enable software BCH library
-		(For legacy device which do not have ELM h/w engine)
-	OMAP_ECC_BCH8_CODE_HW
-		8-bit BCH code with
-		- ecc calculation using GPMC hardware engine,
-		- error detection using ELM hardware engine.
-	OMAP_ECC_BCH16_CODE_HW
-		16-bit BCH code with
-		- ecc calculation using GPMC hardware engine,
-		- error detection using ELM hardware engine.
+	  On OMAP platforms, this CONFIG specifies NAND ECC scheme.
+	  It can take following values:
+	  OMAP_ECC_HAM1_CODE_SW
+	  1-bit Hamming code using software lib.
+	  (for legacy devices only)
+	  OMAP_ECC_HAM1_CODE_HW
+	  1-bit Hamming code using GPMC hardware.
+	  (for legacy devices only)
+	  OMAP_ECC_BCH4_CODE_HW_DETECTION_SW
+	  4-bit BCH code (unsupported)
+	  OMAP_ECC_BCH4_CODE_HW
+	  4-bit BCH code (unsupported)
+	  OMAP_ECC_BCH8_CODE_HW_DETECTION_SW
+	  8-bit BCH code with
+	  - ecc calculation using GPMC hardware engine,
+	  - error detection using software library.
+	  - requires CONFIG_BCH to enable software BCH library
+	  (For legacy device which do not have ELM h/w engine)
+	  OMAP_ECC_BCH8_CODE_HW
+	  8-bit BCH code with
+	  - ecc calculation using GPMC hardware engine,
+	  - error detection using ELM hardware engine.
+	  OMAP_ECC_BCH16_CODE_HW
+	  16-bit BCH code with
+	  - ecc calculation using GPMC hardware engine,
+	  - error detection using ELM hardware engine.

 	How to select ECC scheme on OMAP and AMxx platforms ?
 	-----------------------------------------------------
@@ -618,10 +618,10 @@ config ROCKCHIP_NAND
 	  This controller is found on Rockchip SoCs.
 	  There are four different versions of NAND FLASH Controllers,
 	  including:
-	    NFC v600: RK2928, RK3066, RK3188
-	    NFC v622: RK3036, RK3128
-	    NFC v800: RK3308, RV1108
-	    NFC v900: PX30, RK3326
+	  NFC v600: RK2928, RK3066, RK3188
+	  NFC v622: RK3036, RK3128
+	  NFC v800: RK3308, RV1108
+	  NFC v900: PX30, RK3326

 config ROCKCHIP_NAND_SKIP_BBTSCAN
 	bool "Skip the automatic BBT scan with Rockchip NAND controllers"
@@ -703,12 +703,12 @@ config SYS_NAND_BUSWIDTH_16BIT
 	  Above config is useful when NAND device's bus-width information cannot
 	  be determined from on-chip ONFI params, like in following scenarios:
 	  - SPL boot does not support reading of ONFI parameters. This is done to
-	    keep SPL code foot-print small.
+	  keep SPL code foot-print small.
 	  - In current U-Boot flow using nand_init(), driver initialization
-	    happens in board_nand_init() which is called before any device probe
-	    (nand_scan_ident + nand_scan_tail), thus device's ONFI parameters are
-	    not available while configuring controller. So a static CONFIG_NAND_xx
-	    is needed to know the device's bus-width in advance.
+	  happens in board_nand_init() which is called before any device probe
+	  (nand_scan_ident + nand_scan_tail), thus device's ONFI parameters are
+	  not available while configuring controller. So a static CONFIG_NAND_xx
+	  is needed to know the device's bus-width in advance.

 if SPL

diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
index de78a6cb707e..c10dc299d23d 100644
--- a/drivers/mtd/spi/Kconfig
+++ b/drivers/mtd/spi/Kconfig
@@ -94,39 +94,39 @@ config SPI_FLASH_SFDP_SUPPORT
 	bool "SFDP table parsing support for SPI NOR flashes"
 	depends on !SPI_FLASH_BAR
 	help
-	 Enable support for parsing and auto discovery of parameters for
-	 SPI NOR flashes using Serial Flash Discoverable Parameters (SFDP)
-	 tables as per JESD216 standard.
+	  Enable support for parsing and auto discovery of parameters for
+	  SPI NOR flashes using Serial Flash Discoverable Parameters (SFDP)
+	  tables as per JESD216 standard.

 config SPI_FLASH_SMART_HWCAPS
 	bool "Smart hardware capability detection based on SPI MEM supports_op() hook"
 	default y
 	help
-	 Enable support for smart hardware capability detection based on SPI
-	 MEM supports_op() hook that lets controllers express whether they
-	 can support a type of operation in a much more refined way compared
-	 to using flags like SPI_RX_DUAL, SPI_TX_QUAD, etc.
+	  Enable support for smart hardware capability detection based on SPI
+	  MEM supports_op() hook that lets controllers express whether they
+	  can support a type of operation in a much more refined way compared
+	  to using flags like SPI_RX_DUAL, SPI_TX_QUAD, etc.

 config SPI_NOR_BOOT_SOFT_RESET_EXT_INVERT
 	bool "Command extension type is INVERT for Software Reset on boot"
 	help
-	 Because of SFDP information can not be get before boot.
-	 So define command extension type is INVERT when Software Reset on boot only.
+	  Because of SFDP information can not be get before boot.
+	  So define command extension type is INVERT when Software Reset on boot only.

 config SPI_FLASH_SOFT_RESET
 	bool "Software Reset support for SPI NOR flashes"
 	help
-	 Enable support for xSPI Software Reset. It will be used to switch from
-	 Octal DTR mode to legacy mode on shutdown and boot (if enabled).
+	  Enable support for xSPI Software Reset. It will be used to switch from
+	  Octal DTR mode to legacy mode on shutdown and boot (if enabled).

 config SPI_FLASH_SOFT_RESET_ON_BOOT
 	bool "Perform a Software Reset on boot on flashes that boot in stateful mode"
 	depends on SPI_FLASH_SOFT_RESET
 	help
-	 Perform a Software Reset on boot to allow detecting flashes that are
-	 handed to us in Octal DTR mode. Do not enable this config on flashes
-	 that are not supposed to be handed to U-Boot in Octal DTR mode, even
-	 if they _do_ support the Soft Reset sequence.
+	  Perform a Software Reset on boot to allow detecting flashes that are
+	  handed to us in Octal DTR mode. Do not enable this config on flashes
+	  that are not supposed to be handed to U-Boot in Octal DTR mode, even
+	  if they _do_ support the Soft Reset sequence.

 config SPI_FLASH_BAR
 	bool "SPI flash Bank/Extended address register support"
@@ -139,15 +139,15 @@ config SPI_FLASH_LOCK
 	bool "Enable the Locking feature"
 	default y
 	help
-	 Enable the SPI flash lock support. By default this is set to y.
-	 If you intend not to use the lock support you should say n here.
+	  Enable the SPI flash lock support. By default this is set to y.
+	  If you intend not to use the lock support you should say n here.

 config SPI_FLASH_UNLOCK_ALL
 	bool "Unlock the entire SPI flash on u-boot startup"
 	default y
 	help
-	 Some flashes tend to power up with the software write protection
-	 bits set. If this option is set, the whole flash will be unlocked.
+	  Some flashes tend to power up with the software write protection
+	  bits set. If this option is set, the whole flash will be unlocked.

 	 For legacy reasons, this option default to y. But if you intend to
 	 actually use the software protection bits you should say n here.
@@ -201,9 +201,9 @@ config SPI_FLASH_S28HX_T
 	bool "Cypress SEMPER Octal (S28) chip support"
 	depends on SPI_FLASH_SPANSION
 	help
-	 Add support for the Cypress S28HL-T and S28HS-T chip. This is a separate
-	 config because the fixup hooks for this flash add extra size overhead.
-	 Boards that don't use the flash can disable this to save space.
+	  Add support for the Cypress S28HL-T and S28HS-T chip. This is a separate
+	  config because the fixup hooks for this flash add extra size overhead.
+	  Boards that don't use the flash can disable this to save space.

 config SPI_FLASH_STMICRO
 	bool "STMicro SPI flash support"
@@ -214,9 +214,9 @@ config SPI_FLASH_MT35XU
 	bool "Micron MT35XU chip support"
 	depends on SPI_FLASH_STMICRO
 	help
-	 Add support for the Micron MT35XU chip. This is a separate config
-	 because the fixup hooks for this flash add extra size overhead. Boards
-	 that don't use the flash can disable this to save space.
+	  Add support for the Micron MT35XU chip. This is a separate config
+	  because the fixup hooks for this flash add extra size overhead. Boards
+	  that don't use the flash can disable this to save space.

 config SPI_FLASH_SST
 	bool "SST SPI flash support"
@@ -282,7 +282,7 @@ config SPI_FLASH_MTD
 	bool "SPI Flash MTD support"
 	depends on SPI_FLASH && MTD
 	help
-          Enable the MTD support for spi flash layer, this adapter is for
+	  Enable the MTD support for spi flash layer, this adapter is for
 	  translating mtd_read/mtd_write commands into spi_flash_read/write
 	  commands. It is not intended to use it within sf_cmd or the SPI
 	  flash subsystem. Such an adapter is needed for subsystems like
@@ -294,7 +294,7 @@ config SPL_SPI_FLASH_MTD
 	bool "SPI flash MTD support for SPL"
 	depends on SPI_FLASH && SPL
 	help
-          Enable the MTD support for the SPI flash layer in SPL.
+	  Enable the MTD support for the SPI flash layer in SPL.

 	  If unsure, say N

diff --git a/drivers/mtd/ubi/Kconfig b/drivers/mtd/ubi/Kconfig
index ba77c0347365..e523a4c47078 100644
--- a/drivers/mtd/ubi/Kconfig
+++ b/drivers/mtd/ubi/Kconfig
@@ -82,8 +82,8 @@ config MTD_UBI_BEB_LIMIT
 config MTD_UBI_FASTMAP
 	bool "UBI Fastmap (Experimental feature)"
 	help
-	   Important: this feature is experimental so far and the on-flash
-	   format for fastmap may change in the next kernel versions
+	  Important: this feature is experimental so far and the on-flash
+	  format for fastmap may change in the next kernel versions

 	   Fastmap is a mechanism which allows attaching an UBI device
 	   in nearly constant time. Instead of scanning the whole MTD device it
--
2.39.5

