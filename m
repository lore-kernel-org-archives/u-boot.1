Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47638CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 17:52:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA4EA84903;
	Wed,  6 May 2026 19:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A229849CA; Wed,  6 May 2026 19:51:57 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3697C84903
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 19:51:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 5FDD61F80041
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:51:54 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 6D0CEB405E2; Wed,  6 May 2026 17:51:53 +0000 (UTC)
Received: from collins (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id B5A66B405E3;
 Wed,  6 May 2026 17:51:10 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>, Paul Kocialkowski <paulk@sys-base.io>,
 Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v3 1/3] sunxi: Disable secure SRAM on sun8i platforms missing
 it
Date: Wed,  6 May 2026 19:50:55 +0200
Message-ID: <20260506175057.3374586-2-paulk@sys-base.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506175057.3374586-1-paulk@sys-base.io>
References: <20260506175057.3374586-1-paulk@sys-base.io>
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

From: Paul Kocialkowski <contact@paulk.fr>

While most sun8i platforms have secure SRAM available, some do not.
This is the case for the R40/V40 (based on sun7i) and V3/V3s.

Add the exceptions to the Kconfig default and update affected defconfigs
to reflect the new default.

Also cleanup indent and breaking for related options.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/cpu/armv7/Kconfig          | 10 ++++++----
 configs/Bananapi_M2_Ultra_defconfig |  1 -
 configs/LicheePi_Zero_defconfig     |  1 -
 configs/bananapi_m2_berry_defconfig |  1 -
 configs/netcube_kumquat_defconfig   |  1 -
 configs/pinecube_defconfig          |  1 -
 6 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/cpu/armv7/Kconfig b/arch/arm/cpu/armv7/Kconfig
index 3a3c1784e188..156b2b76fe18 100644
--- a/arch/arm/cpu/armv7/Kconfig
+++ b/arch/arm/cpu/armv7/Kconfig
@@ -29,8 +29,10 @@ config ARMV7_BOOT_SEC_DEFAULT
 
 config HAS_ARMV7_SECURE_BASE
 	bool "Enable support for a hardware secure memory area"
-	default y if ARCH_LS1021A || ARCH_MX7 || ARCH_MX7ULP || ARCH_STM32MP \
-			|| MACH_SUN6I || MACH_SUN7I || MACH_SUN8I || TEGRA124
+	default y if ARCH_LS1021A || ARCH_MX7 || ARCH_MX7ULP || \
+		     ARCH_STM32MP || MACH_SUN6I || MACH_SUN7I || \
+		     (MACH_SUN8I && !MACH_SUN8I_R40 && !MACH_SUN8I_V3S) || \
+		     TEGRA124
 
 config ARMV7_SECURE_BASE
 	hex "Base address for secure mode memory"
@@ -53,8 +55,8 @@ config ARMV7_SECURE_RESERVE_SIZE
 
 config ARMV7_SECURE_MAX_SIZE
 	hex
-	depends on ARMV7_SECURE_BASE && ARCH_STM32MP || MACH_SUN6I \
-			|| MACH_SUN7I || MACH_SUN8I
+	depends on ARMV7_SECURE_BASE && \
+		   (ARCH_STM32MP || MACH_SUN6I || MACH_SUN7I || MACH_SUN8I)
 	default 0xbc00 if MACH_SUN8I && !MACH_SUN8I_H3
 	default 0x3c00 if MACH_SUN8I && MACH_SUN8I_H3
 	default 0x10000
diff --git a/configs/Bananapi_M2_Ultra_defconfig b/configs/Bananapi_M2_Ultra_defconfig
index 750868033be4..c1ffbc3fba61 100644
--- a/configs/Bananapi_M2_Ultra_defconfig
+++ b/configs/Bananapi_M2_Ultra_defconfig
@@ -7,7 +7,6 @@ CONFIG_MACH_SUN8I_R40=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_SPL_SUNXI_LED_STATUS=y
 CONFIG_SPL_SUNXI_LED_STATUS_GPIO=244
-# CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/LicheePi_Zero_defconfig b/configs/LicheePi_Zero_defconfig
index 7460548461d2..de695b362b44 100644
--- a/configs/LicheePi_Zero_defconfig
+++ b/configs/LicheePi_Zero_defconfig
@@ -3,5 +3,4 @@ CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun8i-v3s-licheepi-zero"
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_V3S=y
-# CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_NO_NET=y
diff --git a/configs/bananapi_m2_berry_defconfig b/configs/bananapi_m2_berry_defconfig
index b99752113621..d9602f19e1c6 100644
--- a/configs/bananapi_m2_berry_defconfig
+++ b/configs/bananapi_m2_berry_defconfig
@@ -6,7 +6,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_R40=y
 CONFIG_SPL_SUNXI_LED_STATUS=y
 CONFIG_SPL_SUNXI_LED_STATUS_GPIO=244
-# CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/netcube_kumquat_defconfig b/configs/netcube_kumquat_defconfig
index 292693696184..f5002f3c323e 100644
--- a/configs/netcube_kumquat_defconfig
+++ b/configs/netcube_kumquat_defconfig
@@ -5,7 +5,6 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun8i-v3s-netcube-kumquat"
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_V3S=y
 CONFIG_SPL_SPI_SUNXI=y
-# CONFIG_HAS_ARMV7_SECURE_BASE is not set
 # CONFIG_TIMESTAMP is not set
 CONFIG_BOOTDELAY=1
 CONFIG_PREBOOT=""
diff --git a/configs/pinecube_defconfig b/configs/pinecube_defconfig
index ff9f5682fb51..767b18b1e42e 100644
--- a/configs/pinecube_defconfig
+++ b/configs/pinecube_defconfig
@@ -7,7 +7,6 @@ CONFIG_MACH_SUN8I_V3S=y
 CONFIG_SUNXI_DRAM_DDR3_1333=y
 CONFIG_DRAM_ODT_EN=y
 CONFIG_I2C0_ENABLE=y
-# CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MVTWSI=y
-- 
2.54.0

