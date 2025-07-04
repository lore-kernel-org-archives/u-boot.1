Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36166C8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 21:46:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A06782CFA;
	Fri,  4 Jul 2025 23:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZtyjLKXI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 934C582F30; Fri,  4 Jul 2025 23:45:50 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 457C882A76
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 23:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2eacb421554so455415fac.1
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 14:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751665547; x=1752270347; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CaPAqg8cBE7RrpYJpw848yxL5SboeJPjltSjVUpMf20=;
 b=ZtyjLKXIBdV/OwrHtWyTYKei8gwa0r0zz3cloGP29FHScy8xFLDGxXYHmvva6ChBur
 ZxSDF+HpHp/+jxWU8vR7Rli4Cr1ULy5T+8qSV3T8FB8OYypUKHgGWj+XmCy843u5ilB7
 SB00119puwc85w5DOnU+Ah7S6kTRPJjaJAxfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751665547; x=1752270347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CaPAqg8cBE7RrpYJpw848yxL5SboeJPjltSjVUpMf20=;
 b=PFUlwZDsEvdNN4MSOUJLP6etJdtJNNMM0IXZ9n7Q4r54tZwBR4OuNr45QsP7aEF+D9
 hkItP8krRyruvd2XXWqaNopyGqBuBojA17sn4sIYJndXqZB6Jzjz5NJ5JmW6EAtfMYnu
 0sNX0AdVmZzNw8VNVFAJnvroi/q+jpsj0IUUrR1WZqTB3+U3ZxrmtzLfR72bqmMo3CbL
 QO3ZzKjCZgLPaC75ijJFYZA215UKzflCYzIAYDiiq3FkiuMtvBnJg4c1CT7KjQlJe5bF
 4movZkooYA7Cpp0dL/xoWzfzMO1BP1XYeIs98N17XCq+vsPQhQw3NPx32oEw0iBQfTrm
 g3og==
X-Gm-Message-State: AOJu0YzhZFvJO7Gpq3G7QuOJx/FjKnt7O49/aUuU7aw47ZacsMNRxf0Y
 6QUcp/iMiY3ww8Cn4Arvb5J2yHnCJMmzPBPMq4VmqtoMEBjxmgqEKBKvJer7Pk7OGuQ0n1BYac0
 ezguvHwk=
X-Gm-Gg: ASbGncuYk3vi4PnZP7MPxtbxilHtUCsGq8NGnIj0RNZmA9oRoMKqs8kHZPi7dR+VnRA
 VUqqiO23erKglszFdutY8MN6yGs3dUNXvUgZ2dHyB9g+JEFZ5x+2hjrupig1as3o6AryCbjSQGD
 EydNGVbKXMWWEONGQy/zczrqMgeQ/ZIoiLGmLFLdMf4iV1svydbntS3gAdjX1gcdLF/vp3hMf16
 hJyRARKTpTzfp6ekByGro7Bh1ZedkBR89EnJZR9wnsRgv7Hn0mvXA94PnLZxq39kmDO/d10GJBf
 Rxpq7lhmbqmNFTjkhXfruwHAJkVVxGge9T6leMYVav41Q2cNcg/iA3CJb7JrPxD/60zf3F00rgk
 fZnvP3tf0CM+U5NhsEQFUKH0=
X-Google-Smtp-Source: AGHT+IGA/0yTQQCBBkCwDtNUinmM85d4WNbdfPCkkifXGhlQt0WfLMe1HZgL7cwqzYvaJuEmy6uj/g==
X-Received: by 2002:a05:6808:3090:b0:401:16e:918e with SMTP id
 5614622812f47-40d04198f44mr3512625b6e.8.1751665546771; 
 Fri, 04 Jul 2025 14:45:46 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f9628d8sm519370a34.60.2025.07.04.14.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 14:45:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Subject: [PATCH 2/2] global: Make ARCH_MISC_INIT a selected symbol
Date: Fri,  4 Jul 2025 15:45:42 -0600
Message-ID: <20250704214542.3418805-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704214542.3418805-1-trini@konsulko.com>
References: <20250704214542.3418805-1-trini@konsulko.com>
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

This symbol is not something that the user should be enabling or
disabling but rather the developer for a particular board should select
it when required.

This is mostly size neutral, however a few places do have changes. In
the case of i.MX6ULL systems, it is always the case that
arch_misc_init() could call setup_serial_number() and do useful work,
but was not enabled widely, but now is. In the case of i.MX23/28
systems, we should be able to call mx28_fixup_vt() again here, so do so.
Finally, some platforms were calling arch_misc_init() and then not doing
anything and this results in removing the option.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
---
 arch/arm/Kconfig                          | 7 ++++---
 arch/arm/cpu/armv7/ls102xa/Kconfig        | 1 +
 arch/arm/cpu/armv8/fsl-layerscape/Kconfig | 1 +
 arch/arm/mach-imx/imx9/Kconfig            | 2 ++
 arch/arm/mach-imx/mx6/Kconfig             | 1 +
 arch/arm/mach-omap2/am33xx/Kconfig        | 6 ++++++
 arch/mips/mach-octeon/Kconfig             | 1 +
 board/toradex/verdin-imx8mm/spl.c         | 2 ++
 common/Kconfig                            | 3 ++-
 9 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index be0819a9c9d6..a10d1bb32b63 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -905,6 +905,7 @@ config ARCH_IMX8
 
 config ARCH_IMX8M
 	bool "NXP i.MX8M platform"
+	select ARCH_MISC_INIT if FSL_CAAM
 	select ARM64
 	select GPIO_EXTRA_HEADER
 	select MACH_IMX
@@ -954,6 +955,7 @@ config ARCH_IMXRT
 
 config ARCH_MX23
 	bool "NXP i.MX23 family"
+	select ARCH_MISC_INIT
 	select CPU_ARM926EJS
 	select GPIO_EXTRA_HEADER
 	select MACH_IMX
@@ -961,6 +963,7 @@ config ARCH_MX23
 
 config ARCH_MX28
 	bool "NXP i.MX28 family"
+	select ARCH_MISC_INIT
 	select CPU_ARM926EJS
 	select GPIO_EXTRA_HEADER
 	select MACH_IMX
@@ -1102,6 +1105,7 @@ config ARCH_QEMU
 
 config ARCH_RENESAS
 	bool "Renesas ARM SoCs"
+	select ARCH_MISC_INIT if DISPLAY_CPUINFO && !(RZA1 || RZN1)
 	select DM
 	select DM_SERIAL
 	select GPIO_EXTRA_HEADER
@@ -1111,7 +1115,6 @@ config ARCH_RENESAS
 	imply FAT_WRITE
 	imply OF_UPSTREAM
 	imply SYS_THUMB_BUILD
-	imply ARCH_MISC_INIT if DISPLAY_CPUINFO
 
 config ARCH_SNAPDRAGON
 	bool "Qualcomm Snapdragon SoCs"
@@ -1540,7 +1543,6 @@ config TARGET_LX2160AQDS
 config TARGET_LX2162AQDS
 	bool "Support lx2162aqds"
 	select ARCH_LX2162A
-	select ARCH_MISC_INIT
 	select ARM64
 	select ARMV8_MULTIENTRY
 	select ARCH_SUPPORT_TFABOOT
@@ -1953,7 +1955,6 @@ config TARGET_SL28
 config TARGET_TEN64
 	bool "Support ten64"
 	select ARCH_LS1088A
-	select ARCH_MISC_INIT
 	select ARM64
 	select ARMV8_MULTIENTRY
 	select ARCH_SUPPORT_TFABOOT
diff --git a/arch/arm/cpu/armv7/ls102xa/Kconfig b/arch/arm/cpu/armv7/ls102xa/Kconfig
index 46ace7e5fd68..5c8839583aa6 100644
--- a/arch/arm/cpu/armv7/ls102xa/Kconfig
+++ b/arch/arm/cpu/armv7/ls102xa/Kconfig
@@ -1,5 +1,6 @@
 config ARCH_LS1021A
 	bool
+	select ARCH_MISC_INIT if FSL_CAAM
 	select FSL_DEVICE_DISABLE
 	select FSL_IFC if !QSPI_BOOT && !SD_BOOT_QSPI
 	select LS102XA_STREAM_ID
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/Kconfig b/arch/arm/cpu/armv8/fsl-layerscape/Kconfig
index 080fe3fc327d..787c7a7c1da6 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/Kconfig
+++ b/arch/arm/cpu/armv8/fsl-layerscape/Kconfig
@@ -328,6 +328,7 @@ config ARCH_LX2160A
 
 config FSL_LSCH2
 	bool
+	select ARCH_MISC_INIT if FSL_CAAM
 	select SKIP_LOWLEVEL_INIT
 	select SYS_FSL_CCSR_GUR_BE
 	select SYS_FSL_CCSR_SCFG_BE
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 280d255c0864..6af45938edb3 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -22,10 +22,12 @@ config IMX93
 config IMX91
 	bool
 	select IMX9
+	select ARCH_MISC_INIT
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
 config IMX95
 	bool
+	select ARCH_MISC_INIT
 	select ARMV8_SPL_EXCEPTION_VECTORS
 	select IMX9
 	select DM_MAILBOX
diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
index 2f873ed6ddf1..3f5e91da204f 100644
--- a/arch/arm/mach-imx/mx6/Kconfig
+++ b/arch/arm/mach-imx/mx6/Kconfig
@@ -63,6 +63,7 @@ config MX6UL
 
 config MX6ULL
 	bool "i.MX 6ULL SoC support"
+	select ARCH_MISC_INIT
 	select ROM_UNIFIED_SECTIONS
 	select SYSCOUNTER_TIMER
 	select SYS_L2CACHE_OFF
diff --git a/arch/arm/mach-omap2/am33xx/Kconfig b/arch/arm/mach-omap2/am33xx/Kconfig
index 46abf070f9d5..dff4f1cf202f 100644
--- a/arch/arm/mach-omap2/am33xx/Kconfig
+++ b/arch/arm/mach-omap2/am33xx/Kconfig
@@ -9,6 +9,7 @@ choice
 
 config TARGET_AM335X_EVM
 	bool "Support am335x_evm"
+	select ARCH_MISC_INIT
 	select BOARD_LATE_INIT
 	select DM
 	select DM_GPIO
@@ -70,6 +71,7 @@ config TARGET_AM335X_SHC
 
 config TARGET_AM335X_GUARDIAN
 	bool "Support am335x based guardian board from bosch"
+	select ARCH_MISC_INIT
 	select BOARD_LATE_INIT
 	select DM
 	select DM_SERIAL
@@ -116,6 +118,7 @@ config TARGET_ETAMIN
 
 config TARGET_PCM051
 	bool "Support pcm051"
+	select ARCH_MISC_INIT
 	select DM
 	select DM_GPIO
 	select DM_SERIAL
@@ -123,6 +126,7 @@ config TARGET_PCM051
 
 config TARGET_PHYCORE_AM335X_R2
 	bool "Support phyCORE AM335X R2"
+	select ARCH_MISC_INIT
 	select DM
 	select DM_GPIO
 	select DM_SERIAL
@@ -130,6 +134,7 @@ config TARGET_PHYCORE_AM335X_R2
 
 config TARGET_PXM2
 	bool "Support pxm2"
+	select ARCH_MISC_INIT
 	select BOARD_LATE_INIT
 	select DM
 	select DM_GPIO
@@ -148,6 +153,7 @@ config TARGET_RASTABAN
 
 config TARGET_RUT
 	bool "Support rut"
+	select ARCH_MISC_INIT
 	select BOARD_LATE_INIT
 	select DM
 	select DM_GPIO
diff --git a/arch/mips/mach-octeon/Kconfig b/arch/mips/mach-octeon/Kconfig
index 5d2186bba551..6105cdcf96ea 100644
--- a/arch/mips/mach-octeon/Kconfig
+++ b/arch/mips/mach-octeon/Kconfig
@@ -42,6 +42,7 @@ config TARGET_OCTEON_EBB7304
 
 config TARGET_OCTEON_NIC23
 	bool "Marvell Octeon NIC23"
+	select ARCH_MISC_INIT
 	select OCTEON_CN73XX
 	help
 	 Choose this for the Octeon NIC23 board
diff --git a/board/toradex/verdin-imx8mm/spl.c b/board/toradex/verdin-imx8mm/spl.c
index 1020078afea2..3c2d0ba1dd46 100644
--- a/board/toradex/verdin-imx8mm/spl.c
+++ b/board/toradex/verdin-imx8mm/spl.c
@@ -53,7 +53,9 @@ void spl_dram_init(void)
 
 void spl_board_init(void)
 {
+#if IS_ENABLED(CONFIG_ARCH_MISC_INIT)
 	arch_misc_init();
+#endif
 }
 
 #ifdef CONFIG_SPL_LOAD_FIT
diff --git a/common/Kconfig b/common/Kconfig
index 17539079f90f..a2f653f7e722 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -704,8 +704,9 @@ config ARCH_EARLY_INIT_R
 	  enabled. This can be used to set up architecture-specific devices.
 
 config ARCH_MISC_INIT
-	bool "Call arch-specific init after relocation, when console is ready"
+	bool
 	help
+	  Call arch-specific init after relocation, when console is ready.
 	  With this option U-Boot will call arch_misc_init() after
 	  relocation to allow miscellaneous arch-dependent initialisation
 	  to be performed. This function should be defined by the board
-- 
2.43.0

