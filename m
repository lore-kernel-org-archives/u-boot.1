Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DA6C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 20:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7D2E88AF4;
	Wed,  7 Aug 2024 22:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ltGPdZbF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BF6588BDF; Wed,  7 Aug 2024 22:50:44 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CB3488C07
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 22:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-81fd1e1d38bso10208039f.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723063841; x=1723668641; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xILah0lmhsF+ZHDu7uGMO1VILUukDppOa9LxMiMgqyA=;
 b=ltGPdZbFgomyQ3i9sNDoJDmbEsBxGqiYdclZ/oS6PUEOF46festryQJaZ9Ix369vGN
 UmI6M0CrervTUjFo2L3Vgktgf8awGtRzTReIPQ8qssbfG2hEaVWIDCdD1ViXIq50Gmee
 AC4vNC0lfS57y+7qZSrP6pT+bgqb0MncLhr8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723063841; x=1723668641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xILah0lmhsF+ZHDu7uGMO1VILUukDppOa9LxMiMgqyA=;
 b=nvZ6XEQQxfyAV1GZN/prSK/my9fVFBXo3N84Rq7TLmKA+zNP5Y7WzqQ+QoJwbJyJlT
 0d/CUQhbr4JblcrjuqlQHA4wjx94bCr5wRnniSgb4IrT4HIH+tMds/Dw4hdnedpG/bLx
 JcLsBmkhqjIB5tiKYNLrGLdJffcCCoM4aV04SEzosry+PqXpjqzAvZuw3VJ6e8flBfcX
 9NA3BJH0KIOjHlWJhhigYs9M5tk0qAzvcd9AsfVOIqz+wABc2moI3FznA8dhb+1X7upf
 i40I7fvsbrN/HBB4leR5FVxwBOQc7f6x3IcDAyOV6IAlke3OQia6fL0571wxShXcoigh
 sY4A==
X-Gm-Message-State: AOJu0Yy0gZKPoCV1Jx1qrMcuaJRPpepNCzEn0XwgMrP2G94f+4y8dSFv
 5NubtwdlU0DIQpCHo3vHPrOEvC0g7z6BvnLAVdnEfS+wVctCoqRRkIAG6LEKiz0E9noTdyAmJ70
 =
X-Google-Smtp-Source: AGHT+IHobhH4hrmXIJIZcqEuxm0zNdAYs0EctF60ItYHR9wY3eM1SPKCClgDRMGC5M0TG0h2j3IvyA==
X-Received: by 2002:a05:6e02:6c7:b0:39a:ea89:22ec with SMTP id
 e9e14a558f8ab-39b1fb9ba48mr199985175ab.9.1723063840826; 
 Wed, 07 Aug 2024 13:50:40 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d6988421sm2912581173.32.2024.08.07.13.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 13:50:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maksim Kiselev <bigunclemax@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Stefan Roese <sr@denx.de>
Subject: [PATCH 1/6] sunxi: Drop BOOTCMD_SUNXI_COMPAT
Date: Wed,  7 Aug 2024 14:50:27 -0600
Message-Id: <20240807205032.3745680-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807205032.3745680-1-sjg@chromium.org>
References: <20240807205032.3745680-1-sjg@chromium.org>
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

This dates from 2015 and talks about 'old' 3.x kernels. Perhaps we can
drop this functionality now?

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/include/asm/arch-sunxi/clock_sun4i.h | 10 ----------
 arch/arm/mach-sunxi/Kconfig                   | 12 ------------
 arch/arm/mach-sunxi/dram_sun4i.c              |  4 ----
 configs/icnova-a20-swac_defconfig             |  1 -
 include/configs/sunxi-common.h                | 17 -----------------
 5 files changed, 44 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h b/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
index 2cec91cb20e..c0a438dee53 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
@@ -142,17 +142,7 @@ struct sunxi_ccm_reg {
 #define CCM_PLL1_CFG_FACTOR_M_SHIFT		0
 
 #define PLL1_CFG_DEFAULT	0xa1005000
-
-#if defined CONFIG_OLD_SUNXI_KERNEL_COMPAT && defined CONFIG_MACH_SUN5I
-/*
- * Older linux-sunxi-3.4 kernels override our PLL6 setting with 300 MHz,
- * halving the mbus frequency, so set it to 300 MHz ourselves and base the
- * mbus divider on that.
- */
-#define PLL6_CFG_DEFAULT	0xa1009900
-#else
 #define PLL6_CFG_DEFAULT	0xa1009911
-#endif
 
 /* nand clock */
 #define NAND_CLK_SRC_OSC24		0
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 17666814c52..67c141ced80 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -294,7 +294,6 @@ config MACH_SUN6I
 	select SUNXI_GEN_SUN6I
 	select SUPPORT_SPL
 	select SYS_I2C_SUN6I_P2WI
-	select ARMV7_BOOT_SEC_DEFAULT if OLD_SUNXI_KERNEL_COMPAT
 
 config MACH_SUN7I
 	bool "sun7i (Allwinner A20)"
@@ -306,7 +305,6 @@ config MACH_SUN7I
 	select DRAM_SUN4I
 	select SUNXI_GEN_SUN4I
 	select SUPPORT_SPL
-	select ARMV7_BOOT_SEC_DEFAULT if OLD_SUNXI_KERNEL_COMPAT
 	imply SPL_SYS_I2C_LEGACY
 	imply SYS_I2C_LEGACY
 
@@ -321,7 +319,6 @@ config MACH_SUN8I_A23
 	select SUNXI_GEN_SUN6I
 	select SUPPORT_SPL
 	select SYS_I2C_SUN8I_RSB
-	select ARMV7_BOOT_SEC_DEFAULT if OLD_SUNXI_KERNEL_COMPAT
 
 config MACH_SUN8I_A33
 	bool "sun8i (Allwinner A33)"
@@ -334,7 +331,6 @@ config MACH_SUN8I_A33
 	select SUNXI_GEN_SUN6I
 	select SUPPORT_SPL
 	select SYS_I2C_SUN8I_RSB
-	select ARMV7_BOOT_SEC_DEFAULT if OLD_SUNXI_KERNEL_COMPAT
 
 config MACH_SUN8I_A83T
 	bool "sun8i (Allwinner A83T)"
@@ -354,7 +350,6 @@ config MACH_SUN8I_H3
 	select CPU_V7_HAS_VIRT
 	select ARCH_SUPPORT_PSCI
 	select MACH_SUNXI_H3_H5
-	select ARMV7_BOOT_SEC_DEFAULT if OLD_SUNXI_KERNEL_COMPAT
 
 config MACH_SUN8I_R40
 	bool "sun8i (Allwinner R40)"
@@ -392,7 +387,6 @@ config MACH_SUN8I_V3S
 	select SUNXI_DRAM_DW
 	select SUNXI_DRAM_DW_16BIT
 	select SUPPORT_SPL
-	select ARMV7_BOOT_SEC_DEFAULT if OLD_SUNXI_KERNEL_COMPAT
 
 config MACH_SUN9I
 	bool "sun9i (Allwinner A80)"
@@ -746,12 +740,6 @@ config UART0_PORT_F
 	at the same time, the system can be only booted in the FEL mode.
 	Only enable this if you really know what you are doing.
 
-config OLD_SUNXI_KERNEL_COMPAT
-	bool "Enable workarounds for booting old kernels"
-	---help---
-	Set this to enable various workarounds for old kernels, this results in
-	sub-optimal settings for newer kernels, only enable if needed.
-
 config MMC1_PINS_PH
 	bool "Pins for mmc1 are on Port H"
 	depends on MACH_SUN4I || MACH_SUN7I || MACH_SUN8I_R40
diff --git a/arch/arm/mach-sunxi/dram_sun4i.c b/arch/arm/mach-sunxi/dram_sun4i.c
index 2cce381c9df..dfdb32111b4 100644
--- a/arch/arm/mach-sunxi/dram_sun4i.c
+++ b/arch/arm/mach-sunxi/dram_sun4i.c
@@ -249,10 +249,6 @@ static void mctl_setup_dram_clock(u32 clk, u32 mbus_clk)
 	reg_val &= ~CCM_PLL5_CTRL_K_MASK;		/* set K to 0 (x1) */
 	reg_val &= ~CCM_PLL5_CTRL_N_MASK;		/* set N to 0 (x0) */
 	reg_val &= ~CCM_PLL5_CTRL_P_MASK;		/* set P to 0 (x1) */
-#ifdef CONFIG_OLD_SUNXI_KERNEL_COMPAT
-	/* Old kernels are hardcoded to P=1 (divide by 2) */
-	reg_val |= CCM_PLL5_CTRL_P(1);
-#endif
 	if (clk >= 540 && clk < 552) {
 		/* dram = 540MHz */
 		reg_val |= CCM_PLL5_CTRL_M(CCM_PLL5_CTRL_M_X(2));
diff --git a/configs/icnova-a20-swac_defconfig b/configs/icnova-a20-swac_defconfig
index 30c28f70857..b942fab2bc7 100644
--- a/configs/icnova-a20-swac_defconfig
+++ b/configs/icnova-a20-swac_defconfig
@@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-icnova-swac"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=384
-CONFIG_OLD_SUNXI_KERNEL_COMPAT=y
 CONFIG_USB0_VBUS_PIN="PG11"
 CONFIG_USB0_VBUS_DET="PH7"
 CONFIG_USB1_VBUS_PIN="PG10"
diff --git a/include/configs/sunxi-common.h b/include/configs/sunxi-common.h
index b29a25d5617..6ae6ef1b19c 100644
--- a/include/configs/sunxi-common.h
+++ b/include/configs/sunxi-common.h
@@ -226,22 +226,6 @@
 	BOOT_TARGET_DEVICES_PXE(func) \
 	BOOT_TARGET_DEVICES_DHCP(func)
 
-#ifdef CONFIG_OLD_SUNXI_KERNEL_COMPAT
-#define BOOTCMD_SUNXI_COMPAT \
-	"bootcmd_sunxi_compat=" \
-		"setenv root /dev/mmcblk0p3 rootwait; " \
-		"if ext2load mmc 0 0x44000000 uEnv.txt; then " \
-			"echo Loaded environment from uEnv.txt; " \
-			"env import -t 0x44000000 ${filesize}; " \
-		"fi; " \
-		"setenv bootargs console=${console} root=${root} ${extraargs}; " \
-		"ext2load mmc 0 0x43000000 script.bin && " \
-		"ext2load mmc 0 0x48000000 uImage && " \
-		"bootm 0x48000000\0"
-#else
-#define BOOTCMD_SUNXI_COMPAT
-#endif
-
 #include <config_distro_bootcmd.h>
 
 #ifdef CONFIG_USB_KEYBOARD
@@ -296,7 +280,6 @@
 	"uuid_gpt_esp=" UUID_GPT_ESP "\0" \
 	"uuid_gpt_system=" UUID_GPT_SYSTEM "\0" \
 	"partitions=" PARTS_DEFAULT "\0" \
-	BOOTCMD_SUNXI_COMPAT \
 	BOOTENV
 
 #endif /* _SUNXI_COMMON_CONFIG_H */
-- 
2.34.1

