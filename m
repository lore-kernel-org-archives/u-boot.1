Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FF0CD6E79
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 01:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4CF78489E;
	Tue,  9 Jun 2026 03:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AY7ZiZw3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA3198489F; Tue,  9 Jun 2026 03:26:10 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BA998488A
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 03:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-68d22a95815so996574a12.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 18:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780968366; x=1781573166; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wy69ncdXTSdwK69U7wqCvSto9P5TIOQSAc3BawVdxnw=;
 b=AY7ZiZw3lhvmOze9J8bIHCk5j+6qKedOZbGso+TvdK+LnYO7vfWaR4O9i8gIncRi/W
 7OJWEb185MzbNtcqS6BLKTe7wTaywZo14nVWbOe2ypXqZ7Lx5m+zoPUnXPycgzUpyQOi
 ghXSUfOTyywiN4yAkksHhXJRmexbXGXDKwnCLwUfNmaLDn6u7r+mbWZPjy4I65c6sR4m
 WjfVIwDoaafr3DPegLkHO/nEGnotnEJYgFC9p97XuDRr9eJ8b1Sz/7oen15OJsFUr1i3
 AB4DCW7FmqhG4UNzlRIArZsG6bNCeHAD79+qPxWqlbwOosloRUhcSjgbrJz+NenKBqxS
 CVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780968366; x=1781573166;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wy69ncdXTSdwK69U7wqCvSto9P5TIOQSAc3BawVdxnw=;
 b=o0HsPm1gxmiOgncG/Jovt6wbvIOnXeETA/7pA4rXvd959oNhzYDKEPKaWGZ265Wxx3
 pQc1/AhdqI7C5Nbm37nHuSI2UX+0ZpgzESWC3WSAgpw3Ac0PXbYNTOw2DEWSIYwDe7NC
 ZbzkjAfyZN1oqXBmHHvz2xsysHOpWEb0TH7Zzhu2F6A9qMvysEthLisrPhsPDekA4Qv+
 26MhI+HaZTGi7u32dHBR6yObhWrN67s5KjQsOpiGY2MN7xSrZYlZ0rTPUGclXEAbFt4d
 ve+Igz2txN4qURPrgkf7cZJe2qZ6EVXhu0G4AmpOoVYQmzZqXz5OELrhPjk7CBlA0wC4
 nzjQ==
X-Gm-Message-State: AOJu0YxRrE/7nUKnAzWsMWSjZJkWgCucAkvN+UsJtPnR4m4CVllB48oS
 9H3mNBS1hXIxuwbueqjXrMphIf3kOLpVqLNWZtMurCSvywzg8R4/cTcVX+bd4A==
X-Gm-Gg: Acq92OFUHpZHkWRW6dYvzJdFCHD9uxG0/O5/ZZMxzLrqaY01KEhn96LVlJHwvvKvd+1
 ZaUus/pI1NmVPlRnWYCWfJoUdY4dAtdVW9kRSynkrzLl7VB0IQvWcwg53fjOlAmbUnWF9InYYkm
 nwpGC0OpbAdZ/G/D0IlZAT9R14ZGaWL/hYHIOGML+g6SzG1i9vMoM/OU9ipABmvozE9AxjclkyE
 bQKq23+oNW8bcGkN14L2TEXI5zhoi+UXE5Hwfgtw7DBxrPgQygMDJt1/vgtYn1RcgUGWsPtmlkJ
 Scg6VxM7NcdNtMAp9T98bT+5xkhScfypv6t3mGkOfdh+j33sCSzPiSOLV1/SM2nUf2m9KRJEHo2
 mH/onD4Bzq5uQeDDfF+jGtwBlQZ+QvsG76RCquQ/nJPrBxQeEzDHBUW4uB+XYV9gEZf3SeIZ3VM
 KBvNxxOGTT1uHWT3CLhaciLhH3Q9IzPuYcg6hzDdJQe1KgPGeWCtD6yoCp1DFOO/XqqfpeY4PF
X-Received: by 2002:a17:907:7f89:b0:beb:8aa7:61d4 with SMTP id
 a640c23a62f3a-bf372933273mr435691566b.5.1780968365222; 
 Mon, 08 Jun 2026 18:26:05 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf05228a16csm950722266b.28.2026.06.08.18.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 18:26:03 -0700 (PDT)
Message-ID: <763728a5-f789-4254-b7ad-67a8950f0522@gmail.com>
Date: Tue, 9 Jun 2026 03:26:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 6/8] Kconfig: arm: restyle
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
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

Restyle all Kconfigs for "arm":
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/Kconfig                            |  54 +--
 arch/arm/cpu/armv7/Kconfig                  |  26 +-
 arch/arm/cpu/armv7/ls102xa/Kconfig          |   8 +-
 arch/arm/cpu/armv8/Kconfig                  |  18 +-
 arch/arm/cpu/armv8/fsl-layerscape/Kconfig   |   6 +-
 arch/arm/mach-at91/Kconfig                  |  12 +-
 arch/arm/mach-imx/Kconfig                   |   2 +-
 arch/arm/mach-imx/imx9/Kconfig              |   6 +-
 arch/arm/mach-imx/mx6/Kconfig               |  16 +-
 arch/arm/mach-keystone/Kconfig              |   4 +-
 arch/arm/mach-kirkwood/Kconfig              |  10 +-
 arch/arm/mach-mediatek/Kconfig              |  28 +-
 arch/arm/mach-omap2/omap5/Kconfig           |  10 +-
 arch/arm/mach-owl/Kconfig                   |  12 +-
 arch/arm/mach-rockchip/Kconfig              |  16 +-
 arch/arm/mach-rockchip/px30/Kconfig         |   4 +-
 arch/arm/mach-rockchip/rk322x/Kconfig       |   4 +-
 arch/arm/mach-rockchip/rk3288/Kconfig       |   6 +-
 arch/arm/mach-rockchip/rk3308/Kconfig       |   2 +-
 arch/arm/mach-rockchip/rk3368/Kconfig       |  18 +-
 arch/arm/mach-rockchip/rk3399/Kconfig       |   4 +-
 arch/arm/mach-rockchip/rv1126/Kconfig       |   2 +-
 arch/arm/mach-socfpga/Kconfig               |   4 +-
 arch/arm/mach-sti/Kconfig                   |   2 +-
 arch/arm/mach-stm32mp/Kconfig               |  54 +--
 arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig |  22 +-
 arch/arm/mach-sunxi/Kconfig                 | 450 ++++++++++----------
 arch/arm/mach-uniphier/Kconfig              |   2 +-
 28 files changed, 401 insertions(+), 401 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 514bf2000b4d..f8cfa3ff948e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -477,30 +477,30 @@ config SYS_THUMB_BUILD
 	bool "Build U-Boot using the Thumb instruction set"
 	depends on !ARM64
 	help
-	   Use this flag to build U-Boot using the Thumb instruction set for
-	   ARM architectures. Thumb instruction set provides better code
-	   density. For ARM architectures that support Thumb2 this flag will
-	   result in Thumb2 code generated by GCC.
+	  Use this flag to build U-Boot using the Thumb instruction set for
+	  ARM architectures. Thumb instruction set provides better code
+	  density. For ARM architectures that support Thumb2 this flag will
+	  result in Thumb2 code generated by GCC.

 config SPL_SYS_THUMB_BUILD
 	bool "Build SPL using the Thumb instruction set"
 	default y if SYS_THUMB_BUILD
 	depends on !ARM64 && SPL
 	help
-	   Use this flag to build SPL using the Thumb instruction set for
-	   ARM architectures. Thumb instruction set provides better code
-	   density. For ARM architectures that support Thumb2 this flag will
-	   result in Thumb2 code generated by GCC.
+	  Use this flag to build SPL using the Thumb instruction set for
+	  ARM architectures. Thumb instruction set provides better code
+	  density. For ARM architectures that support Thumb2 this flag will
+	  result in Thumb2 code generated by GCC.

 config TPL_SYS_THUMB_BUILD
 	bool "Build TPL using the Thumb instruction set"
 	default y if SYS_THUMB_BUILD
 	depends on TPL && !ARM64
 	help
-	   Use this flag to build TPL using the Thumb instruction set for
-	   ARM architectures. Thumb instruction set provides better code
-	   density. For ARM architectures that support Thumb2 this flag will
-	   result in Thumb2 code generated by GCC.
+	  Use this flag to build TPL using the Thumb instruction set for
+	  ARM architectures. Thumb instruction set provides better code
+	  density. For ARM architectures that support Thumb2 this flag will
+	  result in Thumb2 code generated by GCC.

 config SYS_L2_PL310
 	bool "ARM PL310 L2 cache controller"
@@ -1583,7 +1583,7 @@ config TARGET_HIKEY
 	select PL01X_SERIAL
 	select SPECIFY_CONSOLE_INDEX
 	imply CMD_DM
-	  help
+	help
 	  Support for HiKey 96boards platform. It features a HI6220
 	  SoC, with 8xA53 CPU, mali450 gpu, and 1GB RAM.

@@ -1596,7 +1596,7 @@ config TARGET_HIKEY960
 	select OF_CONTROL
 	select PL01X_SERIAL
 	imply CMD_DM
-	  help
+	help
 	  Support for HiKey960 96boards platform. It features a HI3660
 	  SoC, with 4xA73 CPU, 4xA53 CPU, MALI-G71 GPU, and 3GB RAM.

@@ -1609,7 +1609,7 @@ config TARGET_POPLAR
 	select OF_CONTROL
 	select PL01X_SERIAL
 	imply CMD_DM
-	  help
+	help
 	  Support for Poplar 96boards EE platform. It features a HI3798cv200
 	  SoC, with 4xA53 CPU, 1GB RAM and the high performance Mali T720 GPU
 	  making it capable of running any commercial set-top solution based on
@@ -1667,10 +1667,10 @@ config TARGET_LS1012AFRWY
 	imply SCSI
 	imply SCSI_AHCI
 	help
-	 Support for Freescale LS1012AFRWY platform.
-	 The LS1012A FRWY board (FRWY) is a high-performance
-	 development platform that supports the QorIQ LS1012A
-	 Layerscape Architecture processor.
+	  Support for Freescale LS1012AFRWY platform.
+	  The LS1012A FRWY board (FRWY) is a high-performance
+	  development platform that supports the QorIQ LS1012A
+	  Layerscape Architecture processor.

 config TARGET_LS1012AFRDM
 	bool "Support ls1012afrdm"
@@ -1778,9 +1778,9 @@ config TARGET_PG_WCOM_SELI8
 	select VENDOR_KM
 	imply SCSI
 	help
-	 Support for Hitachi-Powergrids SELI8 service unit card.
-	 SELI8 is a QorIQ LS1021a based service unit card used
-	 in XMC20 and FOX615 product families.
+	  Support for Hitachi-Powergrids SELI8 service unit card.
+	  SELI8 is a QorIQ LS1021a based service unit card used
+	  in XMC20 and FOX615 product families.

 config TARGET_PG_WCOM_EXPU1
 	bool "Support Hitachi-Powergrids EXPU1 service unit card"
@@ -1796,9 +1796,9 @@ config TARGET_PG_WCOM_EXPU1
 	select VENDOR_KM
 	imply SCSI
 	help
-	 Support for Hitachi-Powergrids EXPU1 service unit card.
-	 EXPU1 is a QorIQ LS1021a based service unit card used
-	 in XMC20 and FOX615 product families.
+	  Support for Hitachi-Powergrids EXPU1 service unit card.
+	  EXPU1 is a QorIQ LS1021a based service unit card used
+	  in XMC20 and FOX615 product families.

 config TARGET_LS1021ATSN
 	bool "Support ls1021atsn"
@@ -2173,8 +2173,8 @@ config TARGET_POMELO
 	select DM_SERIAL
 	imply CMD_PCI
 	help
-	   Support for pomelo platform.
-	   It has 8GB Sdram, uart and pcie.
+	  Support for pomelo platform.
+	  It has 8GB Sdram, uart and pcie.

 config TARGET_PE2201
 	bool "Support Phytium PE2201 Platform"
diff --git a/arch/arm/cpu/armv7/Kconfig b/arch/arm/cpu/armv7/Kconfig
index 1b72fa927721..18e7aed94d93 100644
--- a/arch/arm/cpu/armv7/Kconfig
+++ b/arch/arm/cpu/armv7/Kconfig
@@ -13,19 +13,19 @@ config ARMV7_NONSEC
 	bool "Enable support for booting in non-secure mode" if EXPERT
 	depends on CPU_V7_HAS_NONSEC
 	default y
-	---help---
-	Say Y here to enable support for booting in non-secure / SVC mode.
+	help
+	  Say Y here to enable support for booting in non-secure / SVC mode.

 config ARMV7_BOOT_SEC_DEFAULT
 	bool "Boot in secure mode by default" if EXPERT
 	depends on ARMV7_NONSEC
 	default y if ARCH_TEGRA
-	---help---
-	Say Y here to boot in secure mode by default even if non-secure mode
-	is supported. This option is useful to boot kernels which do not
-	support booting in non-secure mode. Only set this if you need it.
-	This can be overridden at run-time by setting the bootm_boot_mode env.
-	variable to "sec" or "nonsec".
+	help
+	  Say Y here to boot in secure mode by default even if non-secure mode
+	  is supported. This option is useful to boot kernels which do not
+	  support booting in non-secure mode. Only set this if you need it.
+	  This can be overridden at run-time by setting the bootm_boot_mode env.
+	  variable to "sec" or "nonsec".

 config HAS_ARMV7_SECURE_BASE
 	bool "Enable support for a hardware secure memory area"
@@ -74,8 +74,8 @@ config ARMV7_VIRT
 	bool "Enable support for hardware virtualization" if EXPERT
 	depends on CPU_V7_HAS_VIRT && ARMV7_NONSEC
 	default y
-	---help---
-	Say Y here to boot in hypervisor (HYP) mode when booting non-secure.
+	help
+	  Say Y here to boot in hypervisor (HYP) mode when booting non-secure.

 config ARMV7_PSCI
 	bool "Enable PSCI support" if EXPERT
@@ -115,9 +115,9 @@ config ARMV7_LPAE
 	bool "Use LPAE page table format" if EXPERT
 	depends on CPU_V7A
 	default y if ARMV7_VIRT
-	---help---
-	Say Y here to use the long descriptor page table format. This is
-	required if U-Boot runs in HYP mode.
+	help
+	  Say Y here to use the long descriptor page table format. This is
+	  required if U-Boot runs in HYP mode.

 config ARMV7_SET_CORTEX_SMPEN
 	bool
diff --git a/arch/arm/cpu/armv7/ls102xa/Kconfig b/arch/arm/cpu/armv7/ls102xa/Kconfig
index 5c8839583aa6..9ce94555ed05 100644
--- a/arch/arm/cpu/armv7/ls102xa/Kconfig
+++ b/arch/arm/cpu/armv7/ls102xa/Kconfig
@@ -100,9 +100,9 @@ config SYS_FSL_ERRATUM_A008407
 config SYS_FSL_QSPI_SKIP_CLKSEL
 	bool "Skip setting QSPI clock during SoC init"
 	help
-	   To improve startup times when booting from QSPI flash, the QSPI
-	   frequency can be set very early in the boot process. If this option
-	   is enabled, the QSPI frequency will not be changed by U-Boot during
-	   SoC initialization.
+	  To improve startup times when booting from QSPI flash, the QSPI
+	  frequency can be set very early in the boot process. If this option
+	  is enabled, the QSPI frequency will not be changed by U-Boot during
+	  SoC initialization.

 endmenu
diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
index dfc4ce851c3a..7e4e3bdd66c9 100644
--- a/arch/arm/cpu/armv8/Kconfig
+++ b/arch/arm/cpu/armv8/Kconfig
@@ -23,11 +23,11 @@ config ARMV8_SPL_EXCEPTION_VECTORS
 	  and want to save some space at the cost of less debugging info.

 config ARMV8_MULTIENTRY
-        bool "Enable multiple CPUs to enter into U-Boot"
+	bool "Enable multiple CPUs to enter into U-Boot"

 config ARMV8_SET_SMPEN
-        bool "Enable data coherency with other cores in cluster"
-        help
+	bool "Enable data coherency with other cores in cluster"
+	help
 	  Say Y here if there is not any trust firmware to set
 	  CPUECTLR_EL1.SMPEN bit before U-Boot.

@@ -79,12 +79,12 @@ config ARMV8_SEC_FIRMWARE_SUPPORT
 	  process brief.
 	  Note: Only FIT format image is supported.
 	  You should prepare and provide the below information:
-	    - Address of secure firmware.
-	    - Address to hold the return address from secure firmware.
-	    - Secure firmware FIT image related information.
-	      Such as: SEC_FIRMWARE_FIT_IMAGE and SEC_FIRMWARE_FIT_CNF_NAME
-	    - The target exception level that secure monitor firmware will
-	      return to.
+	  - Address of secure firmware.
+	  - Address to hold the return address from secure firmware.
+	  - Secure firmware FIT image related information.
+	  Such as: SEC_FIRMWARE_FIT_IMAGE and SEC_FIRMWARE_FIT_CNF_NAME
+	  - The target exception level that secure monitor firmware will
+	  return to.

 config SPL_ARMV8_SEC_FIRMWARE_SUPPORT
 	bool "Enable ARMv8 secure monitor firmware framework support for SPL"
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/Kconfig b/arch/arm/cpu/armv8/fsl-layerscape/Kconfig
index 4c5b38e3b659..2335c776c2ef 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/Kconfig
+++ b/arch/arm/cpu/armv8/fsl-layerscape/Kconfig
@@ -440,8 +440,8 @@ config MAX_CPUS
 config EMC2305
 	bool "Fan controller"
 	help
-	 Enable the EMC2305 fan controller for configuration of fan
-	 speed.
+	  Enable the EMC2305 fan controller for configuration of fan
+	  speed.

 config QSPI_AHB_INIT
 	bool "Init the QSPI AHB bus"
@@ -548,7 +548,7 @@ config SYS_FSL_PCLK_DIV
 	help
 	  This is the divider that is used to derive Platform clock from
 	  Platform PLL, in another word:
-		Platform_clk = Platform_PLL_freq / this_divider
+	  Platform_clk = Platform_PLL_freq / this_divider

 config SYS_FSL_DSPI_CLK_DIV
 	int "DSPI clock divider"
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 65e9d70f0840..19e3ac360dde 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -150,9 +150,9 @@ config TARGET_SAM9X60EK
 	select BOARD_LATE_INIT

 config TARGET_SAM9X60_CURIOSITY
-        bool "SAM9X60 CURIOSITY board"
-        select SAM9X60
-        select BOARD_LATE_INIT
+	bool "SAM9X60 CURIOSITY board"
+	select SAM9X60
+	select BOARD_LATE_INIT

 config TARGET_SAM9X75_CURIOSITY
 	bool "SAM9X75 CURIOSITY board"
@@ -270,9 +270,9 @@ config TARGET_CORVUS
 	imply CMD_DM

 config TARGET_SAMA7G5EK
-       bool "SAMA7G5 EK board"
-       select SAMA7G5
-       select BOARD_LATE_INIT
+	bool "SAMA7G5 EK board"
+	select SAMA7G5
+	select BOARD_LATE_INIT

 config TARGET_SAMA7G54_CURIOSITY
 	bool "SAMA7G54 CURIOSITY board"
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index e40142265826..de91926fb03a 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -129,7 +129,7 @@ config CMD_PRIBLOB
 	depends on HAS_CAAM && IMX_HAB
 	help
 	  This option enables the priblob command which can be used
-		to set the priblob setting to 0x3.
+	  to set the priblob setting to 0x3.

 config CMD_HDMIDETECT
 	bool "Support the 'hdmidet' command"
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index f072e6a9e3d1..7947a0a23f13 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -1,9 +1,9 @@
 if ARCH_IMX9

 config AHAB_BOOT
-    bool "Support i.MX9 AHAB features"
-    help
-    This option enables the support for AHAB secure boot.
+	bool "Support i.MX9 AHAB features"
+	help
+	  This option enables the support for AHAB secure boot.

 config IMX9
 	bool
diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
index d198d9932f45..8c112fae173b 100644
--- a/arch/arm/mach-imx/mx6/Kconfig
+++ b/arch/arm/mach-imx/mx6/Kconfig
@@ -95,10 +95,10 @@ config MX6_OCRAM_256KB
 	bool "Support 256KB OCRAM"
 	depends on MX6D || MX6Q
 	help
-	 Allows using the full 256KB size of the OCRAM on the MX6Q/MX6D series
-	 of chips, such as for SPL. The OCRAM of the Lite series of chips is
-	 only 128KB, so using this option will prevent the resulting code from
-	 working on those chips.
+	  Allows using the full 256KB size of the OCRAM on the MX6Q/MX6D series
+	  of chips, such as for SPL. The OCRAM of the Lite series of chips is
+	  only 128KB, so using this option will prevent the resulting code from
+	  working on those chips.

 config MX6_DDRCAL
 	bool "Include dynamic DDR calibration routines"
@@ -678,10 +678,10 @@ config TARGET_BRPPT2
 	select SUPPORT_SPL
 	select SPL_DM if SPL
 	select SPL_OF_CONTROL if SPL
-        help
-          Support
-          B&R BRPPT2 platform
-          based on Freescale's iMX6 SoC
+	help
+	  Support
+	  B&R BRPPT2 platform
+	  based on Freescale's iMX6 SoC

 config TARGET_O4_IMX6ULL_NANO
 	bool "O4-iMX6ULL-NANO"
diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index 9bf71a9b4530..82efc9f7c40f 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -18,9 +18,9 @@ config TARGET_K2L_EVM

 config TARGET_K2G_EVM
 	bool "TI Keystone 2 Galileo EVM"
-        select BOARD_LATE_INIT
+	select BOARD_LATE_INIT
 	select SOC_K2G
-        select TI_I2C_BOARD_DETECT
+	select TI_I2C_BOARD_DETECT

 endchoice

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index f1ccedba5d74..8d56ca1a6e33 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -22,13 +22,13 @@ config KIRKWOOD_COMMON
 	select SYS_NS16550

 config HAS_CUSTOM_SYS_INIT_SP_ADDR
-        bool "Use a custom location for the initial stack pointer address"
-        default y
+	bool "Use a custom location for the initial stack pointer address"
+	default y

 config CUSTOM_SYS_INIT_SP_ADDR
-        hex "Static location for the initial stack pointer"
-        depends on HAS_CUSTOM_SYS_INIT_SP_ADDR
-        default 0x5ff000
+	hex "Static location for the initial stack pointer"
+	depends on HAS_CUSTOM_SYS_INIT_SP_ADDR
+	default 0x5ff000

 choice
 	prompt "Marvell Kirkwood board select"
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 80f7185e929e..d6dcd080a9a1 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -45,7 +45,7 @@ config TARGET_MT7981
 	help
 	  The MediaTek MT7981 is a ARM64-based SoC with a dual-core Cortex-A53.
 	  including UART, SPI, USB, NAND, SNFI, PWM, Gigabit Ethernet, I2C,
-          built-in Wi-Fi, and PCIe.
+	  built-in Wi-Fi, and PCIe.

 config TARGET_MT7986
 	bool "MediaTek MT7986 SoC"
@@ -89,9 +89,9 @@ config TARGET_MT8188
 	select ARM64
 	help
 	  The MediaTek MT8188 is a ARM64-based SoC with a dual-core Cortex-A78
-          cluster and a six-core Cortex-A55 cluster. It includes UART, SPI,
-          USB3.0 dual role, SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and
-          several LPDDR3 and LPDDR4 options.
+	  cluster and a six-core Cortex-A55 cluster. It includes UART, SPI,
+	  USB3.0 dual role, SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and
+	  several LPDDR3 and LPDDR4 options.

 config TARGET_MT8189
 	bool "MediaTek MT8189 SoC"
@@ -120,13 +120,13 @@ config TARGET_MT8365
 	  I2C, I2S, S/PDIF, and several LPDDR3 and LPDDR4 options.

 config TARGET_MT8512
-        bool "MediaTek MT8512 SoC"
-        select ARM64
-        help
-          The MediaTek MT8512 is a ARM64-based SoC with a dual-core Cortex-A53.
-          including UART, SPI, USB2.0 and OTG, SD and MMC cards, NAND, PWM,
-          IR RX, I2C, I2S, S/PDIF, and built-in Wi-Fi / Bluetooth digital
-          and several LPDDR3 and LPDDR4 options.
+	bool "MediaTek MT8512 SoC"
+	select ARM64
+	help
+	  The MediaTek MT8512 is a ARM64-based SoC with a dual-core Cortex-A53.
+	  including UART, SPI, USB2.0 and OTG, SD and MMC cards, NAND, PWM,
+	  IR RX, I2C, I2S, S/PDIF, and built-in Wi-Fi / Bluetooth digital
+	  and several LPDDR3 and LPDDR4 options.

 config TARGET_MT8516
 	bool "MediaTek MT8516 SoC"
@@ -154,7 +154,7 @@ config MTK_MEM_MAP_DDR_BASE_PHY
 	hex "DDR physical base address"
 	default 0x40000000
 	help
-		Target-specific DDR physical base address.
+	  Target-specific DDR physical base address.

 config MTK_MEM_MAP_DDR_SIZE
 	hex "DDR .size in mem_map"
@@ -164,14 +164,14 @@ config MTK_MEM_MAP_DDR_SIZE
 	default 0x40000000 if TARGET_MT7622 || TARGET_MT8512
 	default 0x20000000
 	help
-		Target-specific DDR region size in mem_map.
+	  Target-specific DDR region size in mem_map.

 config MTK_MEM_MAP_MMIO_SIZE
 	hex "MMIO .size in mem_map"
 	default 0x40000000 if TARGET_MT7622 || TARGET_MT7981 || TARGET_MT7986 || TARGET_MT7987 || TARGET_MT7988 || TARGET_MT8512
 	default 0x20000000
 	help
-		Target-specific MMIO region size in mem_map.
+	  Target-specific MMIO region size in mem_map.

 endif

diff --git a/arch/arm/mach-omap2/omap5/Kconfig b/arch/arm/mach-omap2/omap5/Kconfig
index 5394529658bc..2a96a8418e25 100644
--- a/arch/arm/mach-omap2/omap5/Kconfig
+++ b/arch/arm/mach-omap2/omap5/Kconfig
@@ -64,7 +64,7 @@ config OMAP_PLATFORM_RESET_TIME_MAX_USEC
 	  1: Time taken by the Osciallator to stop and restart
 	  2: PMIC OTP time
 	  3: Voltage ramp time, which can be derived using the PMIC slew rate
-	     and value of voltage ramp needed.
+	  and value of voltage ramp needed.

 if TARGET_DRA7XX_EVM || TARGET_AM57XX_EVM
 menu "Voltage Domain OPP selections"
@@ -72,7 +72,7 @@ menu "Voltage Domain OPP selections"
 choice
 	prompt "MPU Voltage Domain"
 	default DRA7_MPU_OPP_NOM
-        help
+	help
 	  Select the Operating Performance Point(OPP) for the MPU voltage
 	  domain on DRA7xx & AM57xx SoCs.

@@ -86,7 +86,7 @@ endchoice

 choice
 	prompt "DSPEVE Voltage Domain"
-        help
+	help
 	  Select the Operating Performance Point(OPP) for the DSPEVE voltage
 	  domain on DRA7xx & AM57xx SoCs.

@@ -110,7 +110,7 @@ endchoice

 choice
 	prompt "IVA Voltage Domain"
-        help
+	help
 	  Select the Operating Performance Point(OPP) for the IVA voltage
 	  domain on DRA7xx & AM57xx SoCs.

@@ -134,7 +134,7 @@ endchoice

 choice
 	prompt "GPU Voltage Domain"
-        help
+	help
 	  Select the Operating Performance Point(OPP) for the GPU voltage
 	  domain on DRA7xx & AM57xx SoCs.

diff --git a/arch/arm/mach-owl/Kconfig b/arch/arm/mach-owl/Kconfig
index 76d3998884d5..4d1bfb778ee1 100644
--- a/arch/arm/mach-owl/Kconfig
+++ b/arch/arm/mach-owl/Kconfig
@@ -1,21 +1,21 @@
 if ARCH_OWL

 choice
-        prompt "Actions Semi Owl SoC Variant"
+	prompt "Actions Semi Owl SoC Variant"
         optional

 config MACH_S900
-        bool "Actions Semi S900 SoC"
-        select ARM64
+	bool "Actions Semi S900 SoC"
+	select ARM64

 config MACH_S700
-        bool "Actions Semi S700 SoC"
-        select ARM64
+	bool "Actions Semi S700 SoC"
+	select ARM64

 endchoice

 config TEXT_BASE
-        default 0x11000000
+	default 0x11000000

 config SYS_CONFIG_NAME
         default "owl-common"
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 108713488af1..a3c2774b3785 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -605,8 +605,8 @@ config SPL_ROCKCHIP_BACK_TO_BROM
 	depends on SPL
 	help
 	  Rockchip SoCs have ability to load SPL & U-Boot binary. If enabled,
-          SPL will return to the boot rom, which will then load the U-Boot
-          binary to keep going on.
+	  SPL will return to the boot rom, which will then load the U-Boot
+	  binary to keep going on.

 config TPL_ROCKCHIP_BACK_TO_BROM
 	bool "TPL returns to bootrom"
@@ -616,8 +616,8 @@ config TPL_ROCKCHIP_BACK_TO_BROM
 	depends on TPL
 	help
 	  Rockchip SoCs have ability to load SPL & U-Boot binary. If enabled,
-          SPL will return to the boot rom, which will then load the U-Boot
-          binary to keep going on.
+	  SPL will return to the boot rom, which will then load the U-Boot
+	  binary to keep going on.

 config ROCKCHIP_COMMON_BOARD
 	bool "Rockchip common board file"
@@ -659,7 +659,7 @@ config ROCKCHIP_BOOT_MODE_REG
 config ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON
 	bool "Disable device boot on power plug-in"
 	depends on PMIC_RK8XX
-	---help---
+	help
 	  Say Y here to prevent the device from booting up because of a plug-in
 	  event. When set, the device will boot briefly to determine why it was
 	  powered on, and if it was determined because of a plug-in event
@@ -687,7 +687,7 @@ config ROCKCHIP_BROM_HELPER
 	bool

 config SPL_ROCKCHIP_EARLYRETURN_TO_BROM
-        bool "SPL requires early-return (for RK3188-style BROM) to BROM"
+	bool "SPL requires early-return (for RK3188-style BROM) to BROM"
 	depends on SPL && ENABLE_ARM_SOC_BOOT0_HOOK
 	help
 	  Some Rockchip BROM variants (e.g. on the RK3188) load the
@@ -708,7 +708,7 @@ config ROCKCHIP_DISABLE_FORCE_JTAG
 	  Rockchip SoCs can automatically switch between jtag and sdmmc based
 	  on the following rules:
 	  - all the SDMMC pins including SDMMC_DET set as SDMMC function in
-	    GRF,
+	  GRF,
 	  - force_jtag bit in GRF is 1,
 	  - SDMMC_DET is low (no card detected),

@@ -725,7 +725,7 @@ config ROCKCHIP_DISABLE_FORCE_JTAG
 	  If unsure, say Y.

 config TPL_ROCKCHIP_EARLYRETURN_TO_BROM
-        bool "TPL requires early-return (for RK3188-style BROM) to BROM"
+	bool "TPL requires early-return (for RK3188-style BROM) to BROM"
 	depends on TPL && ENABLE_ARM_SOC_BOOT0_HOOK
 	help
 	  Some Rockchip BROM variants (e.g. on the RK3188) load the
diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/px30/Kconfig
index 2b57b1668942..adba1b49a52b 100644
--- a/arch/arm/mach-rockchip/px30/Kconfig
+++ b/arch/arm/mach-rockchip/px30/Kconfig
@@ -18,7 +18,7 @@ config TARGET_PX30_CORE
 	  * PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.
 	  * EDIMM2.2 is a Form Factor Capacitive Evaluation Board from Engicam.
 	  * PX30.Core needs to mount on top of EDIMM2.2 for creating complete
-	    PX30.Core EDIMM2.2 Starter Kit.
+	  PX30.Core EDIMM2.2 Starter Kit.

 	  PX30.Core CTOUCH2:
 	  * PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.
@@ -39,7 +39,7 @@ config TARGET_RINGNECK_PX30
 	bool "Theobroma Systems PX30-uQ7 (Ringneck)"
 	help
 	  The PX30-uQ7 (Ringneck) SoM is a uQseven-compatible (40mmx70mm,
-          MXM-230 connector) system-on-module from Theobroma Systems[1],
+	  MXM-230 connector) system-on-module from Theobroma Systems[1],
 	  featuring the Rockchip PX30.

 	  It provides the following feature set:
diff --git a/arch/arm/mach-rockchip/rk322x/Kconfig b/arch/arm/mach-rockchip/rk322x/Kconfig
index 9ad1f54055b3..ba6940939907 100644
--- a/arch/arm/mach-rockchip/rk322x/Kconfig
+++ b/arch/arm/mach-rockchip/rk322x/Kconfig
@@ -27,10 +27,10 @@ config SPL_SERIAL
 	default y

 config TPL_STACK
-        default 0x10088000
+	default 0x10088000

 config TPL_TEXT_BASE
-        default 0x10081000
+	default 0x10081000

 source "board/rockchip/evb_rk3229/Kconfig"

diff --git a/arch/arm/mach-rockchip/rk3288/Kconfig b/arch/arm/mach-rockchip/rk3288/Kconfig
index 128ee362f8a8..91e119108769 100644
--- a/arch/arm/mach-rockchip/rk3288/Kconfig
+++ b/arch/arm/mach-rockchip/rk3288/Kconfig
@@ -91,7 +91,7 @@ config TARGET_MIQI_RK3288

 config TARGET_PHYCORE_RK3288
 	bool "phyCORE-RK3288"
-        select BOARD_LATE_INIT
+	select BOARD_LATE_INIT
 	help
 	  Add basic support for the PCM-947 carrier board, a RK3288 based
 	  development board made by PHYTEC. This board works in a combination
@@ -128,7 +128,7 @@ config TARGET_ROCK2

 config TARGET_TINKER_RK3288
 	bool "Tinker-RK3288"
-        select BOARD_LATE_INIT
+	select BOARD_LATE_INIT
 	select ROCKCHIP_COMMON_STACK_ADDR
 	select TPL
 	help
@@ -173,7 +173,7 @@ config SPL_SERIAL
 	default y

 config TPL_STACK
-        default 0xff718000
+	default 0xff718000

 config TPL_SYS_MALLOC_F_LEN
 	default 0x2000
diff --git a/arch/arm/mach-rockchip/rk3308/Kconfig b/arch/arm/mach-rockchip/rk3308/Kconfig
index b8d25c525424..540ddc93cd0c 100644
--- a/arch/arm/mach-rockchip/rk3308/Kconfig
+++ b/arch/arm/mach-rockchip/rk3308/Kconfig
@@ -5,7 +5,7 @@ config TARGET_EVB_RK3308
 	select BOARD_LATE_INIT

 config TARGET_ROC_RK3308_CC
-       bool "Firefly roc-rk3308-cc"
+	bool "Firefly roc-rk3308-cc"
 	select BOARD_LATE_INIT

 config ROCKCHIP_BOOT_MODE_REG
diff --git a/arch/arm/mach-rockchip/rk3368/Kconfig b/arch/arm/mach-rockchip/rk3368/Kconfig
index a7be30bbd897..6c6ca02c3091 100644
--- a/arch/arm/mach-rockchip/rk3368/Kconfig
+++ b/arch/arm/mach-rockchip/rk3368/Kconfig
@@ -13,14 +13,14 @@ config TARGET_GEEKBOX
 	bool "GeekBox"

 config TARGET_EVB_PX5
-        bool "Evb-PX5"
+	bool "Evb-PX5"
 	select ARCH_EARLY_INIT_R
-        help
-	 PX5 EVB is designed by Rockchip for automotive field
-         with integrated CVBS (TP2825) / MIPI DSI / CSI / LVDS
-         HDMI video input/output interface, audio codec ES8396,
-         WIFI/BT (on RTL8723BS), Gsensor BMA250E and light&proximity
-         sensor STK3410.
+	help
+	  PX5 EVB is designed by Rockchip for automotive field
+	  with integrated CVBS (TP2825) / MIPI DSI / CSI / LVDS
+	  HDMI video input/output interface, audio codec ES8396,
+	  WIFI/BT (on RTL8723BS), Gsensor BMA250E and light&proximity
+	  sensor STK3410.
 endchoice

 config ROCKCHIP_BOOT_MODE_REG
@@ -49,9 +49,9 @@ config SPL_STACK_R_ADDR
 	default 0x04000000

 config TPL_STACK
-        default 0xff8cffff
+	default 0xff8cffff

 config TPL_TEXT_BASE
-        default 0xff8c1000
+	default 0xff8c1000

 endif
diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
index 5c21b08a5ae2..d84a9da8ed58 100644
--- a/arch/arm/mach-rockchip/rk3399/Kconfig
+++ b/arch/arm/mach-rockchip/rk3399/Kconfig
@@ -145,10 +145,10 @@ config TPL_LDSCRIPT
 	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"

 config TPL_STACK
-        default 0xff8effff
+	default 0xff8effff

 config TPL_TEXT_BASE
-        default 0xff8c2000
+	default 0xff8c2000

 if BOOTCOUNT_LIMIT

diff --git a/arch/arm/mach-rockchip/rv1126/Kconfig b/arch/arm/mach-rockchip/rv1126/Kconfig
index 43eeaa9c4493..d066df9a86e9 100644
--- a/arch/arm/mach-rockchip/rv1126/Kconfig
+++ b/arch/arm/mach-rockchip/rv1126/Kconfig
@@ -47,7 +47,7 @@ config TPL_LDSCRIPT
 	default "arch/arm/mach-rockchip/u-boot-tpl.lds"

 config TPL_STACK
-        default 0xff718000
+	default 0xff718000

 config TPL_SYS_MALLOC_F_LEN
 	default 0x2000
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index fb98b6474425..a9b639a5ed99 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -15,8 +15,8 @@ config SOCFPGA_SECURE_VAB_AUTH
 	select SHA512
 	select SPL_FIT_IMAGE_POST_PROCESS
 	help
-	 All images loaded from FIT will be authenticated by Secure Device
-	 Manager.
+	  All images loaded from FIT will be authenticated by Secure Device
+	  Manager.

 config SOCFPGA_SECURE_VAB_AUTH_ALLOW_NON_FIT_IMAGE
 	bool "Allow non-FIT VAB signed images"
diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index d9e264024c8e..df26e7b8ef2c 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -14,7 +14,7 @@ config TARGET_STIH410_B2260
 	  Specifications. Features:
 	  - 1GB DDR
 	  - On-Board USB combo WiFi/Bluetooth RTL8723BU
-	    with PCB soldered antenna
+	  with PCB soldered antenna
 	  - Ethernet 1000-BaseT
 	  - Sata
 	  - HDMI
diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfig
index 39f25869c1d5..f45010ddbd01 100644
--- a/arch/arm/mach-stm32mp/Kconfig
+++ b/arch/arm/mach-stm32mp/Kconfig
@@ -56,8 +56,8 @@ config STM32MP13X
 	imply CMD_NVEDIT_INFO
 	imply OF_UPSTREAM
 	help
-		support of STMicroelectronics SOC STM32MP13x family
-		STMicroelectronics MPU with core ARMv7
+	  support of STMicroelectronics SOC STM32MP13x family
+	  STMicroelectronics MPU with core ARMv7

 config STM32MP15X
 	bool "Support STMicroelectronics STM32MP15x Soc"
@@ -77,10 +77,10 @@ config STM32MP15X
 	imply CMD_NVEDIT_INFO
 	imply OF_UPSTREAM
 	help
-		support of STMicroelectronics SOC STM32MP15x family
-		STM32MP157, STM32MP153 or STM32MP151
-		STMicroelectronics MPU with core ARMv7
-		dual core A7 for STM32MP157/3, monocore for STM32MP151
+	  support of STMicroelectronics SOC STM32MP15x family
+	  STM32MP157, STM32MP153 or STM32MP151
+	  STMicroelectronics MPU with core ARMv7
+	  dual core A7 for STM32MP157/3, monocore for STM32MP151

 config STM32MP21X
 	bool "Support STMicroelectronics STM32MP21x Soc"
@@ -104,8 +104,8 @@ config STM32MP21X
 	imply TEE
 	imply VERSION_VARIABLE
 	help
-		Support of STMicroelectronics SOC STM32MP21X family
-		STMicroelectronics MPU with 1 A35 core and 1 M33 core
+	  Support of STMicroelectronics SOC STM32MP21X family
+	  STMicroelectronics MPU with 1 A35 core and 1 M33 core

 config STM32MP23X
 	bool "Support STMicroelectronics STM32MP23x Soc"
@@ -129,8 +129,8 @@ config STM32MP23X
 	imply TEE
 	imply VERSION_VARIABLE
 	help
-		Support of STMicroelectronics SOC STM32MP23x family
-		STMicroelectronics MPU with 2 * A53 core and 1 M33 core
+	  Support of STMicroelectronics SOC STM32MP23x family
+	  STMicroelectronics MPU with 2 * A53 core and 1 M33 core

 config STM32MP25X
 	bool "Support STMicroelectronics STM32MP25x Soc"
@@ -153,8 +153,8 @@ config STM32MP25X
 	imply TEE
 	imply VERSION_VARIABLE
 	help
-		Support of STMicroelectronics SOC STM32MP25x family
-		STMicroelectronics MPU with 2 * A53 core and 1 M33 core
+	  Support of STMicroelectronics SOC STM32MP25x family
+	  STMicroelectronics MPU with 2 * A53 core and 1 M33 core
 endchoice

 config NR_DRAM_BANKS
@@ -164,13 +164,13 @@ config DDR_CACHEABLE_SIZE
 	hex "Size of the DDR marked cacheable in pre-reloc stage"
 	default 0x40000000
 	help
-		Define the size of the DDR marked as cacheable in U-Boot
-		pre-reloc stage.
-		This option can be useful to avoid speculatif access
-		to secured area of DDR used by TF-A or OP-TEE before U-Boot
-		initialization.
-		The areas marked "no-map" in device tree should be located
-		before this limit: STM32_DDR_BASE + DDR_CACHEABLE_SIZE.
+	  Define the size of the DDR marked as cacheable in U-Boot
+	  pre-reloc stage.
+	  This option can be useful to avoid speculatif access
+	  to secured area of DDR used by TF-A or OP-TEE before U-Boot
+	  initialization.
+	  The areas marked "no-map" in device tree should be located
+	  before this limit: STM32_DDR_BASE + DDR_CACHEABLE_SIZE.

 config SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_MMC2
 	hex "Partition on MMC2 to use to load U-Boot from"
@@ -203,10 +203,10 @@ config CMD_STM32KEY
 	bool "command stm32key to fuse public key hash"
 	depends on CMDLINE
 	help
-		fuse public key hash in corresponding fuse used to authenticate
-		binary.
-		This command is used to evaluate the secure boot on stm32mp SOC,
-		it is deactivated by default in real products.
+	  fuse public key hash in corresponding fuse used to authenticate
+	  binary.
+	  This command is used to evaluate the secure boot on stm32mp SOC,
+	  it is deactivated by default in real products.

 config MFD_STM32_TIMERS
 	bool "STM32 multifonction timer support"
@@ -226,15 +226,15 @@ config STM32MP15_PWR
 	depends on DM_REGULATOR && DM_PMIC && (STM32MP13X || STM32MP15X)
 	default y if STM32MP15X
 	help
-		This config enables implementation of driver-model pmic and
-		regulator uclass features for access to STM32MP15x PWR.
+	  This config enables implementation of driver-model pmic and
+	  regulator uclass features for access to STM32MP15x PWR.

 config SPL_STM32MP15_PWR
 	bool "Enable driver for STM32MP15x PWR in SPL"
 	depends on SPL && SPL_DM_REGULATOR && SPL_DM_PMIC && (STM32MP13X || STM32MP15X)
 	default y if STM32MP15X
 	help
-		This config enables implementation of driver-model pmic and
-		regulator uclass features for access to STM32MP15x PWR in SPL.
+	  This config enables implementation of driver-model pmic and
+	  regulator uclass features for access to STM32MP15x PWR in SPL.

 endif
diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig b/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
index 647e0a4c2bf4..5ae57d133400 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
@@ -10,10 +10,10 @@ config CMD_STM32PROG
 	imply DFU_MMC if MMC
 	imply DFU_MTD if MTD
 	help
-		activate a specific command stm32prog for STM32MP soc family
-		witch update the device with the tools STM32CubeProgrammer
-		NB: access to not volatile memory (NOR/NAND/SD/eMMC) is based
-		    on U-Boot DFU framework
+	  activate a specific command stm32prog for STM32MP soc family
+	  witch update the device with the tools STM32CubeProgrammer
+	  NB: access to not volatile memory (NOR/NAND/SD/eMMC) is based
+	  on U-Boot DFU framework

 config CMD_STM32PROG_USB
 	bool "support stm32prog over USB"
@@ -21,9 +21,9 @@ config CMD_STM32PROG_USB
 	depends on USB_GADGET_DOWNLOAD
 	default y
 	help
-		activate the command "stm32prog usb" for STM32MP soc family
-		witch update the device with the tools STM32CubeProgrammer,
-		using USB with DFU protocol
+	  activate the command "stm32prog usb" for STM32MP soc family
+	  witch update the device with the tools STM32CubeProgrammer,
+	  using USB with DFU protocol

 config CMD_STM32PROG_SERIAL
 	bool "support stm32prog over UART"
@@ -32,13 +32,13 @@ config CMD_STM32PROG_SERIAL
 	imply SILENT_CONSOLE
 	default y
 	help
-		activate the command "stm32prog serial" for STM32MP soc family
-		with the tools STM32CubeProgrammer using U-Boot serial device
-		and UART protocol.
+	  activate the command "stm32prog serial" for STM32MP soc family
+	  with the tools STM32CubeProgrammer using U-Boot serial device
+	  and UART protocol.

 config CMD_STM32PROG_OTP
 	bool "support stm32prog for OTP update"
 	depends on CMD_STM32PROG
 	default y if ARM_SMCCC || OPTEE
 	help
-		Support the OTP update with the command "stm32prog" for STM32MP
+	  Support the OTP update with the command "stm32prog" for STM32MP
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index ceba96b61a5c..5ace74567dd5 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -223,11 +223,11 @@ config SUNXI_SRAM_ADDRESS
 	default 0x44000 if MACH_SUN55I_A523
 	default 0x20000 if SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
 	default 0x0
-	---help---
-	Older Allwinner SoCs have their mask boot ROM mapped just below 4GB,
-	with the first SRAM region being located at address 0.
-	Some newer SoCs map the boot ROM at address 0 instead and move the
-	SRAM to a different address.
+	help
+	  Older Allwinner SoCs have their mask boot ROM mapped just below 4GB,
+	  with the first SRAM region being located at address 0.
+	  Some newer SoCs map the boot ROM at address 0 instead and move the
+	  SRAM to a different address.

 config SUNXI_RVBAR_ADDRESS
 	hex
@@ -236,26 +236,26 @@ config SUNXI_RVBAR_ADDRESS
 	default 0x08000040 if MACH_SUN55I_A523
 	default 0x09010040 if SUN50I_GEN_H6
 	default 0x017000a0
-	---help---
-	The read-only RVBAR system register holds the address of the first
-	instruction to execute after a reset. Allwinner cores provide a
-	writable MMIO backing store for this register, to allow to set the
-	entry point when switching to AArch64. This store is on different
-	addresses, depending on the SoC.
+	help
+	  The read-only RVBAR system register holds the address of the first
+	  instruction to execute after a reset. Allwinner cores provide a
+	  writable MMIO backing store for this register, to allow to set the
+	  entry point when switching to AArch64. This store is on different
+	  addresses, depending on the SoC.

 config SUNXI_RVBAR_ALTERNATIVE
 	hex
 	depends on ARM64
 	default 0x08100040 if MACH_SUN50I_H616
 	default SUNXI_RVBAR_ADDRESS
-	---help---
-	The H616 die exists in at least two variants, with one having the
-	RVBAR registers at a different address. If the SoC variant ID
-	(stored in SRAM_VER_REG[7:0]) is not 0, we need to use the
-	other address.
-	Set this alternative address to the same as the normal address
-	for all other SoCs, so the content of the SRAM_VER_REG becomes
-	irrelevant there, and we can use the same code.
+	help
+	  The H616 die exists in at least two variants, with one having the
+	  RVBAR registers at a different address. If the SoC variant ID
+	  (stored in SRAM_VER_REG[7:0]) is not 0, we need to use the
+	  other address.
+	  Set this alternative address to the same as the normal address
+	  for all other SoCs, so the content of the SRAM_VER_REG becomes
+	  irrelevant there, and we can use the same code.

 config SUNXI_BL31_BASE
 	hex
@@ -282,16 +282,16 @@ config SUNXI_A64_TIMER_ERRATUM
 # not supported by Kconfig
 config SUNXI_GEN_SUN4I
 	bool
-	---help---
-	Select this for sunxi SoCs which have resets and clocks set up
-	as the original A10 (mach-sun4i).
+	help
+	  Select this for sunxi SoCs which have resets and clocks set up
+	  as the original A10 (mach-sun4i).

 config SUNXI_GEN_SUN6I
 	bool
-	---help---
-	Select this for sunxi SoCs which have sun6i like periphery, like
-	separate ahb reset control registers, custom pmic bus, new style
-	watchdog, etc.
+	help
+	  Select this for sunxi SoCs which have sun6i like periphery, like
+	  separate ahb reset control registers, custom pmic bus, new style
+	  watchdog, etc.

 config SUN50I_GEN_H6
 	bool
@@ -299,38 +299,38 @@ config SUN50I_GEN_H6
 	select SPL_LOAD_FIT if SPL
 	select MMC_SUNXI_HAS_NEW_MODE
 	select SUPPORT_SPL
-	---help---
-	Select this for sunxi SoCs which have H6 like peripherals, clocks
-	and memory map.
+	help
+	  Select this for sunxi SoCs which have H6 like peripherals, clocks
+	  and memory map.

 config SUNXI_GEN_NCAT2
 	bool
 	select MMC_SUNXI_HAS_NEW_MODE
 	select SUPPORT_SPL
-	---help---
-	Select this for sunxi SoCs which have D1 like peripherals, clocks
-	and memory map.
+	help
+	  Select this for sunxi SoCs which have D1 like peripherals, clocks
+	  and memory map.

 config SUNXI_DRAM_DW
 	bool
-	---help---
-	Select this for sunxi SoCs which uses a DRAM controller like the
-	DesignWare controller used in H3, mainly SoCs after H3, which do
-	not have official open-source DRAM initialization code, but can
-	use modified H3 DRAM initialization code.
+	help
+	  Select this for sunxi SoCs which uses a DRAM controller like the
+	  DesignWare controller used in H3, mainly SoCs after H3, which do
+	  not have official open-source DRAM initialization code, but can
+	  use modified H3 DRAM initialization code.

 if SUNXI_DRAM_DW
 config SUNXI_DRAM_DW_16BIT
 	bool
-	---help---
-	Select this for sunxi SoCs with DesignWare DRAM controller and
-	have only 16-bit memory buswidth.
+	help
+	  Select this for sunxi SoCs with DesignWare DRAM controller and
+	  have only 16-bit memory buswidth.

 config SUNXI_DRAM_DW_32BIT
 	bool
-	---help---
-	Select this for sunxi SoCs with DesignWare DRAM controller with
-	32-bit memory buswidth.
+	help
+	  Select this for sunxi SoCs with DesignWare DRAM controller with
+	  32-bit memory buswidth.
 endif

 config MACH_SUNXI_H3_H5
@@ -576,25 +576,25 @@ config MACH_SUN8I
 config RESERVE_ALLWINNER_BOOT0_HEADER
 	bool "reserve space for Allwinner boot0 header"
 	select ENABLE_ARM_SOC_BOOT0_HOOK
-	---help---
-	Prepend a 1536 byte (empty) header to the U-Boot image file, to be
-	filled with magic values post build. The Allwinner provided boot0
-	blob relies on this information to load and execute U-Boot.
-	Only needed on 64-bit Allwinner boards so far when using boot0.
+	help
+	  Prepend a 1536 byte (empty) header to the U-Boot image file, to be
+	  filled with magic values post build. The Allwinner provided boot0
+	  blob relies on this information to load and execute U-Boot.
+	  Only needed on 64-bit Allwinner boards so far when using boot0.

 config ARM_BOOT_HOOK_RMR
 	bool
 	depends on ARM64
 	default y
 	select ENABLE_ARM_SOC_BOOT0_HOOK
-	---help---
-	Insert some ARM32 code at the very beginning of the U-Boot binary
-	which uses an RMR register write to bring the core into AArch64 mode.
-	The very first instruction acts as a switch, since it's carefully
-	chosen to be a NOP in one mode and a branch in the other, so the
-	code would only be executed if not already in AArch64.
-	This allows both the SPL and the U-Boot proper to be entered in
-	either mode and switch to AArch64 if needed.
+	help
+	  Insert some ARM32 code at the very beginning of the U-Boot binary
+	  which uses an RMR register write to bring the core into AArch64 mode.
+	  The very first instruction acts as a switch, since it's carefully
+	  chosen to be a NOP in one mode and a branch in the other, so the
+	  code would only be executed if not already in AArch64.
+	  This allows both the SPL and the U-Boot proper to be entered in
+	  either mode and switch to AArch64 if needed.

 if SUNXI_DRAM_DW || DRAM_SUN50I_H6 || DRAM_SUN50I_H616 || DRAM_SUN50I_A133 || DRAM_SUN55I_A523
 config SUNXI_DRAM_DDR3
@@ -622,33 +622,33 @@ config SUNXI_DRAM_DDR3_1333
 	bool "DDR3 1333"
 	select SUNXI_DRAM_DDR3
 	depends on !DRAM_SUN50I_A133
-	---help---
-	This option is the original only supported memory type, which suits
-	many H3/H5/A64 boards available now.
+	help
+	  This option is the original only supported memory type, which suits
+	  many H3/H5/A64 boards available now.

 config SUNXI_DRAM_LPDDR3_STOCK
 	bool "LPDDR3 with Allwinner stock configuration"
 	select SUNXI_DRAM_LPDDR3
 	depends on !DRAM_SUN50I_A133
-	---help---
-	This option is the LPDDR3 timing used by the stock boot0 by
-	Allwinner.
+	help
+	  This option is the LPDDR3 timing used by the stock boot0 by
+	  Allwinner.

 config SUNXI_DRAM_H6_LPDDR3
 	bool "LPDDR3 DRAM chips on the H6 DRAM controller"
 	select SUNXI_DRAM_LPDDR3
 	depends on DRAM_SUN50I_H6
-	---help---
-	This option is the LPDDR3 timing used by the stock boot0 by
-	Allwinner.
+	help
+	  This option is the LPDDR3 timing used by the stock boot0 by
+	  Allwinner.

 config SUNXI_DRAM_H6_DDR3_1333
 	bool "DDR3-1333 boot0 timings on the H6 DRAM controller"
 	select SUNXI_DRAM_DDR3
 	depends on DRAM_SUN50I_H6
-	---help---
-	This option is the DDR3 timing used by the boot0 on H6 TV boxes
-	which use a DDR3-1333 timing.
+	help
+	  This option is the DDR3 timing used by the boot0 on H6 TV boxes
+	  which use a DDR3-1333 timing.

 config SUNXI_DRAM_H616_LPDDR3
 	bool "LPDDR3 DRAM chips on the H616 DRAM controller"
@@ -694,9 +694,9 @@ config SUNXI_DRAM_DDR2_V3S
 	bool "DDR2 found in V3s chip"
 	select SUNXI_DRAM_DDR2
 	depends on MACH_SUN8I_V3S
-	---help---
-	This option is only for the DDR2 memory chip which is co-packaged in
-	Allwinner V3s SoC.
+	help
+	  This option is only for the DDR2 memory chip which is co-packaged in
+	  Allwinner V3s SoC.

 config SUNXI_DRAM_A523_DDR3
 	bool "DDR3 DRAM chips on the A523/T527 DRAM controller"
@@ -720,8 +720,8 @@ config DRAM_TYPE
 	int "sunxi dram type"
 	depends on MACH_SUN8I_A83T
 	default 3
-	---help---
-	Set the dram type, 3: DDR3, 7: LPDDR3
+	help
+	  Set the dram type, 3: DDR3, 7: LPDDR3

 config DRAM_CLK
 	int "sunxi dram clock speed"
@@ -734,17 +734,17 @@ config DRAM_CLK
 	default 744 if MACH_SUN50I_H6
 	default 720 if MACH_SUN50I_H616 || MACH_SUN50I_A133
 	default 1200 if MACH_SUN55I_A523
-	---help---
-	Set the dram clock speed, valid range 240 - 480 (prior to sun9i),
-	must be a multiple of 24. For the sun9i (A80), the tested values
-	(for DDR3-1600) are 312 to 792.
+	help
+	  Set the dram clock speed, valid range 240 - 480 (prior to sun9i),
+	  must be a multiple of 24. For the sun9i (A80), the tested values
+	  (for DDR3-1600) are 312 to 792.

 if MACH_SUN5I || MACH_SUN7I
 config DRAM_MBUS_CLK
 	int "sunxi mbus clock speed"
 	default 300
-	---help---
-	Set the mbus clock speed. The maximum on sun5i hardware is 300MHz.
+	help
+	  Set the mbus clock speed. The maximum on sun5i hardware is 300MHz.

 endif

@@ -760,8 +760,8 @@ config DRAM_ZQ
 	default 3881979 if MACH_SUNXI_H3_H5 || MACH_SUN8I_R40 || MACH_SUN50I_H6
 	default 4145117 if MACH_SUN9I
 	default 3881915 if MACH_SUN50I
-	---help---
-	Set the dram zq value.
+	help
+	  Set the dram zq value.

 config DRAM_ODT_EN
 	bool "sunxi dram odt enable"
@@ -772,72 +772,72 @@ config DRAM_ODT_EN
 	default y if MACH_SUN8I_R40
 	default y if MACH_SUN50I
 	default y if MACH_SUN50I_H6
-	---help---
-	Select this to enable dram odt (on die termination).
+	help
+	  Select this to enable dram odt (on die termination).

 if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I
 config DRAM_EMR1
 	int "sunxi dram emr1 value"
 	default 0 if MACH_SUN4I
 	default 4 if MACH_SUN5I || MACH_SUN7I
-	---help---
-	Set the dram controller emr1 value.
+	help
+	  Set the dram controller emr1 value.

 config DRAM_TPR3
 	hex "sunxi dram tpr3 value"
 	default 0x0
-	---help---
-	Set the dram controller tpr3 parameter. This parameter configures
-	the delay on the command lane and also phase shifts, which are
-	applied for sampling incoming read data. The default value 0
-	means that no phase/delay adjustments are necessary. Properly
-	configuring this parameter increases reliability at high DRAM
-	clock speeds.
+	help
+	  Set the dram controller tpr3 parameter. This parameter configures
+	  the delay on the command lane and also phase shifts, which are
+	  applied for sampling incoming read data. The default value 0
+	  means that no phase/delay adjustments are necessary. Properly
+	  configuring this parameter increases reliability at high DRAM
+	  clock speeds.

 config DRAM_DQS_GATING_DELAY
 	hex "sunxi dram dqs_gating_delay value"
 	default 0x0
-	---help---
-	Set the dram controller dqs_gating_delay parmeter. Each byte
-	encodes the DQS gating delay for each byte lane. The delay
-	granularity is 1/4 cycle. For example, the value 0x05060606
-	means that the delay is 5 quarter-cycles for one lane (1.25
-	cycles) and 6 quarter-cycles (1.5 cycles) for 3 other lanes.
-	The default value 0 means autodetection. The results of hardware
-	autodetection are not very reliable and depend on the chip
-	temperature (sometimes producing different results on cold start
-	and warm reboot). But the accuracy of hardware autodetection
-	is usually good enough, unless running at really high DRAM
-	clocks speeds (up to 600MHz). If unsure, keep as 0.
+	help
+	  Set the dram controller dqs_gating_delay parmeter. Each byte
+	  encodes the DQS gating delay for each byte lane. The delay
+	  granularity is 1/4 cycle. For example, the value 0x05060606
+	  means that the delay is 5 quarter-cycles for one lane (1.25
+	  cycles) and 6 quarter-cycles (1.5 cycles) for 3 other lanes.
+	  The default value 0 means autodetection. The results of hardware
+	  autodetection are not very reliable and depend on the chip
+	  temperature (sometimes producing different results on cold start
+	  and warm reboot). But the accuracy of hardware autodetection
+	  is usually good enough, unless running at really high DRAM
+	  clocks speeds (up to 600MHz). If unsure, keep as 0.

 choice
 	prompt "sunxi dram timings"
 	default DRAM_TIMINGS_VENDOR_MAGIC
-	---help---
-	Select the timings of the DDR3 chips.
+	help
+	  Select the timings of the DDR3 chips.

 config DRAM_TIMINGS_VENDOR_MAGIC
 	bool "Magic vendor timings from Android"
-	---help---
-	The same DRAM timings as in the Allwinner boot0 bootloader.
+	help
+	  The same DRAM timings as in the Allwinner boot0 bootloader.

 config DRAM_TIMINGS_DDR3_1066F_1333H
 	bool "JEDEC DDR3-1333H with down binning to DDR3-1066F"
-	---help---
-	Use the timings of the standard JEDEC DDR3-1066F speed bin for
-	DRAM_CLK <= 533MHz and the timings of the DDR3-1333H speed bin
-	for DRAM_CLK > 533MHz. This covers the majority of DDR3 chips
-	used in Allwinner A10/A13/A20 devices. In the case of DDR3-1333
-	or DDR3-1600 chips, be sure to check the DRAM datasheet to confirm
-	that down binning to DDR3-1066F is supported (because DDR3-1066F
-	uses a bit faster timings than DDR3-1333H).
+	help
+	  Use the timings of the standard JEDEC DDR3-1066F speed bin for
+	  DRAM_CLK <= 533MHz and the timings of the DDR3-1333H speed bin
+	  for DRAM_CLK > 533MHz. This covers the majority of DDR3 chips
+	  used in Allwinner A10/A13/A20 devices. In the case of DDR3-1333
+	  or DDR3-1600 chips, be sure to check the DRAM datasheet to confirm
+	  that down binning to DDR3-1066F is supported (because DDR3-1066F
+	  uses a bit faster timings than DDR3-1333H).

 config DRAM_TIMINGS_DDR3_800E_1066G_1333J
 	bool "JEDEC DDR3-800E / DDR3-1066G / DDR3-1333J"
-	---help---
-	Use the timings of the slowest possible JEDEC speed bin for the
-	selected DRAM_CLK. Depending on the DRAM_CLK value, it may be
-	DDR3-800E, DDR3-1066G or DDR3-1333J.
+	help
+	  Use the timings of the slowest possible JEDEC speed bin for the
+	  selected DRAM_CLK. Depending on the DRAM_CLK value, it may be
+	  DDR3-800E, DDR3-1066G or DDR3-1333J.

 endchoice

@@ -847,11 +847,11 @@ if MACH_SUN8I_A23
 config DRAM_ODT_CORRECTION
 	int "sunxi dram odt correction value"
 	default 0
-	---help---
-	Set the dram odt correction value (range -255 - 255). In allwinner
-	fex files, this option is found in bits 8-15 of the u32 odt_en variable
-	in the [dram] section. When bit 31 of the odt_en variable is set
-	then the correction is negative. Usually the value for this is 0.
+	help
+	  Set the dram odt correction value (range -255 - 255). In allwinner
+	  fex files, this option is found in bits 8-15 of the u32 odt_en variable
+	  in the [dram] section. When bit 31 of the odt_en variable is set
+	  then the correction is negative. Usually the value for this is 0.
 endif

 config SYS_CLK_FREQ
@@ -888,59 +888,59 @@ config SUNXI_MINIMUM_DRAM_MB
 	default 32 if MACH_SUNIV
 	default 64 if MACH_SUN8I_V3S
 	default 256
-	---help---
-	Minimum DRAM size expected on the board. Traditionally we assumed
-	256 MB, so that U-Boot would load at 160MB. With co-packaged DRAM
-	we have smaller sizes, though, so that U-Boot's own load address and
-	the default payload addresses must be shifted down.
-	This is expected to be fixed by the SoC selection.
+	help
+	  Minimum DRAM size expected on the board. Traditionally we assumed
+	  256 MB, so that U-Boot would load at 160MB. With co-packaged DRAM
+	  we have smaller sizes, though, so that U-Boot's own load address and
+	  the default payload addresses must be shifted down.
+	  This is expected to be fixed by the SoC selection.

 config UART0_PORT_F
 	bool "UART0 on MicroSD breakout board"
-	---help---
-	Repurpose the SD card slot for getting access to the UART0 serial
-	console. Primarily useful only for low level u-boot debugging on
-	tablets, where normal UART0 is difficult to access and requires
-	device disassembly and/or soldering. As the SD card can't be used
-	at the same time, the system can be only booted in the FEL mode.
-	Only enable this if you really know what you are doing.
+	help
+	  Repurpose the SD card slot for getting access to the UART0 serial
+	  console. Primarily useful only for low level u-boot debugging on
+	  tablets, where normal UART0 is difficult to access and requires
+	  device disassembly and/or soldering. As the SD card can't be used
+	  at the same time, the system can be only booted in the FEL mode.
+	  Only enable this if you really know what you are doing.

 config OLD_SUNXI_KERNEL_COMPAT
 	bool "Enable workarounds for booting old kernels"
-	---help---
-	Set this to enable various workarounds for old kernels, this results in
-	sub-optimal settings for newer kernels, only enable if needed.
+	help
+	  Set this to enable various workarounds for old kernels, this results in
+	  sub-optimal settings for newer kernels, only enable if needed.

 config MMC1_PINS_PH
 	bool "Pins for mmc1 are on Port H"
 	depends on MACH_SUN4I || MACH_SUN7I || MACH_SUN8I_R40
-	---help---
-	Select this option for boards where mmc1 uses the Port H pinmux.
+	help
+	  Select this option for boards where mmc1 uses the Port H pinmux.

 config MMC_SUNXI_SLOT_EXTRA
 	int "mmc extra slot number"
 	default -1
-	---help---
-	sunxi builds always enable mmc0, some boards also have a second sdcard
-	slot or emmc on mmc1 - mmc3. Setting this to 1, 2 or 3 will enable
-	support for this.
+	help
+	  sunxi builds always enable mmc0, some boards also have a second sdcard
+	  slot or emmc on mmc1 - mmc3. Setting this to 1, 2 or 3 will enable
+	  support for this.

 config I2C0_ENABLE
 	bool "Enable I2C/TWI controller 0"
 	default y if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I_R40
 	default n if MACH_SUN6I || MACH_SUN8I
 	select CMD_I2C
-	---help---
-	This allows enabling I2C/TWI controller 0 by muxing its pins, enabling
-	its clock and setting up the bus. This is especially useful on devices
-	with slaves connected to the bus or with pins exposed through e.g. an
-	expansion port/header.
+	help
+	  This allows enabling I2C/TWI controller 0 by muxing its pins, enabling
+	  its clock and setting up the bus. This is especially useful on devices
+	  with slaves connected to the bus or with pins exposed through e.g. an
+	  expansion port/header.

 config I2C1_ENABLE
 	bool "Enable I2C/TWI controller 1"
 	select CMD_I2C
-	---help---
-	See I2C0_ENABLE help text.
+	help
+	  See I2C0_ENABLE help text.

 if SUNXI_GEN_SUN6I || SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
 config R_I2C_ENABLE
@@ -948,20 +948,20 @@ config R_I2C_ENABLE
 	# This is used for the pmic on H3
 	default y if SY8106A_POWER
 	select CMD_I2C
-	---help---
-	Set this to y to enable the I2C controller which is part of the PRCM.
+	help
+	  Set this to y to enable the I2C controller which is part of the PRCM.
 endif

 config AXP_GPIO
 	bool "Enable support for gpio-s on axp PMICs"
 	depends on AXP_PMIC_BUS
-	---help---
-	Say Y here to enable support for the gpio pins of the axp PMIC ICs.
+	help
+	  Say Y here to enable support for the gpio pins of the axp PMIC ICs.

 config AXP_DISABLE_BOOT_ON_POWERON
 	bool "Disable device boot on power plug-in"
 	depends on AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER
-	---help---
+	help
 	  Say Y here to prevent the device from booting up because of a plug-in
 	  event. When set, the device will boot into the SPL briefly to
 	  determine why it was powered on, and if it was determined because of
@@ -982,127 +982,127 @@ config VIDEO_SUNXI
 	imply VIDEO_DAMAGE
 	imply VIDEO_DT_SIMPLEFB
 	default y
-	---help---
-	Say Y here to add support for using a graphical console on the HDMI,
-	LCD or VGA output found on older sunxi devices. This will also provide
-	a simple_framebuffer device for Linux.
+	help
+	  Say Y here to add support for using a graphical console on the HDMI,
+	  LCD or VGA output found on older sunxi devices. This will also provide
+	  a simple_framebuffer device for Linux.

 config VIDEO_HDMI
 	bool "HDMI output support"
 	depends on VIDEO_SUNXI && !MACH_SUN8I && !MACH_SUNIV
 	default y
-	---help---
-	Say Y here to add support for outputting video over HDMI.
+	help
+	  Say Y here to add support for outputting video over HDMI.

 config VIDEO_VGA
 	bool "VGA output support"
 	depends on VIDEO_SUNXI && (MACH_SUN4I || MACH_SUN7I)
-	---help---
-	Say Y here to add support for outputting video over VGA.
+	help
+	  Say Y here to add support for outputting video over VGA.

 config VIDEO_VGA_VIA_LCD
 	bool "VGA via LCD controller support"
 	depends on VIDEO_SUNXI && (MACH_SUN5I || MACH_SUN6I || MACH_SUN8I)
-	---help---
-	Say Y here to add support for external DACs connected to the parallel
-	LCD interface driving a VGA connector, such as found on the
-	Olimex A13 boards.
+	help
+	  Say Y here to add support for external DACs connected to the parallel
+	  LCD interface driving a VGA connector, such as found on the
+	  Olimex A13 boards.

 config VIDEO_VGA_VIA_LCD_FORCE_SYNC_ACTIVE_HIGH
 	bool "Force sync active high for VGA via LCD controller support"
 	depends on VIDEO_VGA_VIA_LCD
-	---help---
-	Say Y here if you've a board which uses opendrain drivers for the vga
-	hsync and vsync signals. Opendrain drivers cannot generate steep enough
-	positive edges for a stable video output, so on boards with opendrain
-	drivers the sync signals must always be active high.
+	help
+	  Say Y here if you've a board which uses opendrain drivers for the vga
+	  hsync and vsync signals. Opendrain drivers cannot generate steep enough
+	  positive edges for a stable video output, so on boards with opendrain
+	  drivers the sync signals must always be active high.

 config VIDEO_VGA_EXTERNAL_DAC_EN
 	string "LCD panel power enable pin"
 	depends on VIDEO_VGA_VIA_LCD
 	default ""
-	---help---
-	Set the enable pin for the external VGA DAC. This takes a string in the
-	format understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of port H.
+	help
+	  Set the enable pin for the external VGA DAC. This takes a string in the
+	  format understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of port H.

 config VIDEO_COMPOSITE
 	bool "Composite video output support"
 	depends on VIDEO_SUNXI && (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I)
-	---help---
-	Say Y here to add support for outputting composite video.
+	help
+	  Say Y here to add support for outputting composite video.

 config VIDEO_LCD_MODE
 	string "LCD panel timing details"
 	depends on VIDEO_SUNXI
 	default ""
-	---help---
-	LCD panel timing details string, leave empty if there is no LCD panel.
-	This is in drivers/video/videomodes.c: video_get_params() format, e.g.
-	x:800,y:480,depth:18,pclk_khz:33000,le:16,ri:209,up:22,lo:22,hs:30,vs:1,sync:0,vmode:0
-	Also see: http://linux-sunxi.org/LCD
+	help
+	  LCD panel timing details string, leave empty if there is no LCD panel.
+	  This is in drivers/video/videomodes.c: video_get_params() format, e.g.
+	  x:800,y:480,depth:18,pclk_khz:33000,le:16,ri:209,up:22,lo:22,hs:30,vs:1,sync:0,vmode:0
+	  Also see: http://linux-sunxi.org/LCD

 config VIDEO_LCD_DCLK_PHASE
 	int "LCD panel display clock phase"
 	depends on VIDEO_SUNXI || VIDEO
 	default 1
 	range 0 3
-	---help---
-	Select LCD panel display clock phase shift
+	help
+	  Select LCD panel display clock phase shift

 config VIDEO_LCD_POWER
 	string "LCD panel power enable pin"
 	depends on VIDEO_SUNXI
 	default ""
-	---help---
-	Set the power enable pin for the LCD panel. This takes a string in the
-	format understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of port H.
+	help
+	  Set the power enable pin for the LCD panel. This takes a string in the
+	  format understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of port H.

 config VIDEO_LCD_RESET
 	string "LCD panel reset pin"
 	depends on VIDEO_SUNXI
 	default ""
-	---help---
-	Set the reset pin for the LCD panel. This takes a string in the format
-	understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of port H.
+	help
+	  Set the reset pin for the LCD panel. This takes a string in the format
+	  understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of port H.

 config VIDEO_LCD_BL_EN
 	string "LCD panel backlight enable pin"
 	depends on VIDEO_SUNXI
 	default ""
-	---help---
-	Set the backlight enable pin for the LCD panel. This takes a string in the
-	the format understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of
-	port H.
+	help
+	  Set the backlight enable pin for the LCD panel. This takes a string in the
+	  the format understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of
+	  port H.

 config VIDEO_LCD_BL_PWM
 	string "LCD panel backlight pwm pin"
 	depends on VIDEO_SUNXI
 	default ""
-	---help---
-	Set the backlight pwm pin for the LCD panel. This takes a string in the
-	format understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of port H.
+	help
+	  Set the backlight pwm pin for the LCD panel. This takes a string in the
+	  format understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of port H.

 config VIDEO_LCD_BL_PWM_ACTIVE_LOW
 	bool "LCD panel backlight pwm is inverted"
 	depends on VIDEO_SUNXI
 	default y
-	---help---
-	Set this if the backlight pwm output is active low.
+	help
+	  Set this if the backlight pwm output is active low.

 config VIDEO_LCD_PANEL_I2C
 	bool "LCD panel needs to be configured via i2c"
 	depends on VIDEO_SUNXI
 	select DM_I2C_GPIO
-	---help---
-	Say y here if the LCD panel needs to be configured via i2c. This
-	will add a bitbang i2c controller using gpios to talk to the LCD.
+	help
+	  Say y here if the LCD panel needs to be configured via i2c. This
+	  will add a bitbang i2c controller using gpios to talk to the LCD.

 config VIDEO_LCD_PANEL_I2C_NAME
 	string "LCD panel i2c interface node name"
 	depends on VIDEO_LCD_PANEL_I2C
 	default "i2c"
-	---help---
-	Set the device tree node name for the LCD i2c interface.
+	help
+	  Set the device tree node name for the LCD i2c interface.

 # Note only one of these may be selected at a time! But hidden choices are
 # not supported by Kconfig
@@ -1123,16 +1123,16 @@ config VIDEO_DE2
 	select VIDEO_DW_HDMI
 	imply VIDEO_DT_SIMPLEFB
 	default y
-	---help---
-	Say y here if you want to build DE2 video driver which is present on
-	newer SoCs. Currently only HDMI output is supported.
+	help
+	  Say y here if you want to build DE2 video driver which is present on
+	  newer SoCs. Currently only HDMI output is supported.


 choice
 	prompt "LCD panel support"
 	depends on VIDEO_SUNXI
-	---help---
-	Select which type of LCD panel to support.
+	help
+	  Select which type of LCD panel to support.

 config VIDEO_LCD_PANEL_PARALLEL
 	bool "Generic parallel interface LCD panel"
@@ -1146,40 +1146,40 @@ config VIDEO_LCD_PANEL_MIPI_4_LANE_513_MBPS_VIA_SSD2828
 	bool "MIPI 4-lane, 513Mbps LCD panel via SSD2828 bridge chip"
 	select VIDEO_LCD_SSD2828
 	select VIDEO_LCD_IF_PARALLEL
-	---help---
-	7.85" 768x1024 LCD panels, such as LG LP079X01 or AUO B079XAN01.0
+	help
+	  7.85" 768x1024 LCD panels, such as LG LP079X01 or AUO B079XAN01.0

 config VIDEO_LCD_PANEL_EDP_4_LANE_1620M_VIA_ANX9804
 	bool "eDP 4-lane, 1.62G LCD panel via ANX9804 bridge chip"
 	select VIDEO_LCD_ANX9804
 	select VIDEO_LCD_IF_PARALLEL
 	select VIDEO_LCD_PANEL_I2C
-	---help---
-	Select this for eDP LCD panels with 4 lanes running at 1.62G,
-	connected via an ANX9804 bridge chip.
+	help
+	  Select this for eDP LCD panels with 4 lanes running at 1.62G,
+	  connected via an ANX9804 bridge chip.

 config VIDEO_LCD_PANEL_HITACHI_TX18D42VM
 	bool "Hitachi tx18d42vm LCD panel"
 	select VIDEO_LCD_HITACHI_TX18D42VM
 	select VIDEO_LCD_IF_LVDS
-	---help---
-	7.85" 1024x768 Hitachi tx18d42vm LCD panel support
+	help
+	  7.85" 1024x768 Hitachi tx18d42vm LCD panel support

 config VIDEO_LCD_TL059WV5C0
 	bool "tl059wv5c0 LCD panel"
 	select VIDEO_LCD_PANEL_I2C
 	select VIDEO_LCD_IF_PARALLEL
-	---help---
-	6" 480x800 tl059wv5c0 panel support, as used on the Utoo P66 and
-	Aigo M60/M608/M606 tablets.
+	help
+	  6" 480x800 tl059wv5c0 panel support, as used on the Utoo P66 and
+	  Aigo M60/M608/M606 tablets.

 endchoice

 config GMAC_TX_DELAY
 	int "GMAC Transmit Clock Delay Chain"
 	default 0
-	---help---
-	Set the GMAC Transmit Clock Delay Chain value.
+	help
+	  Set the GMAC Transmit Clock Delay Chain value.

 config SPL_STACK_R_ADDR
 	default 0x81e00000 if MACH_SUNIV
diff --git a/arch/arm/mach-uniphier/Kconfig b/arch/arm/mach-uniphier/Kconfig
index c570fb3294d0..d2fa72f47244 100644
--- a/arch/arm/mach-uniphier/Kconfig
+++ b/arch/arm/mach-uniphier/Kconfig
@@ -4,7 +4,7 @@ config SYS_CONFIG_NAME
 	default "uniphier"

 choice
-        prompt "UniPhier SoC select"
+	prompt "UniPhier SoC select"

 config ARCH_UNIPHIER_V7_MULTI
 	bool "UniPhier V7 SoCs"
--
2.39.5

