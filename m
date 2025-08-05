Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC0DC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 17:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3DA68390D;
	Tue,  5 Aug 2025 19:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A88F8391B; Tue,  5 Aug 2025 19:50:22 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C88483885
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 19:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 9A5461F00036
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 17:50:19 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id DED10B011F4; Tue,  5 Aug 2025 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 38CCFB011E9;
 Tue,  5 Aug 2025 17:48:29 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 03/11] sunxi: Disable secure SRAM on sun8i platforms
 missing it
Date: Tue,  5 Aug 2025 19:48:19 +0200
Message-ID: <20250805174827.3696191-4-paulk@sys-base.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805174827.3696191-1-paulk@sys-base.io>
References: <20250805174827.3696191-1-paulk@sys-base.io>
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

Add the exceptions to the Kconfig default and clean up its align.
Update affected defconfigs to reflect the new default.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/cpu/armv7/Kconfig          | 6 ++++--
 configs/Bananapi_M2_Ultra_defconfig | 1 -
 configs/LicheePi_Zero_defconfig     | 1 -
 configs/bananapi_m2_berry_defconfig | 1 -
 configs/pinecube_defconfig          | 1 -
 5 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/cpu/armv7/Kconfig b/arch/arm/cpu/armv7/Kconfig
index ab86d642eeeb..769e5e1a4a53 100644
--- a/arch/arm/cpu/armv7/Kconfig
+++ b/arch/arm/cpu/armv7/Kconfig
@@ -29,8 +29,10 @@ config ARMV7_BOOT_SEC_DEFAULT
 
 config HAS_ARMV7_SECURE_BASE
 	bool "Enable support for a ahardware secure memory area"
-	default y if ARCH_LS1021A || ARCH_MX7 || ARCH_MX7ULP || ARCH_STM32MP \
-			|| MACH_SUN6I || MACH_SUN7I || MACH_SUN8I || TEGRA124
+	default y if ARCH_LS1021A || ARCH_MX7 || ARCH_MX7ULP || \
+		     ARCH_STM32MP || MACH_SUN6I || MACH_SUN7I || \
+		     (MACH_SUN8I && !MACH_SUN8I_R40 && !MACH_SUN8I_V3_V3S) || \
+		     TEGRA124
 
 config ARMV7_SECURE_BASE
 	hex "Base address for secure mode memory"
diff --git a/configs/Bananapi_M2_Ultra_defconfig b/configs/Bananapi_M2_Ultra_defconfig
index b1195afea20c..97570fa7b47b 100644
--- a/configs/Bananapi_M2_Ultra_defconfig
+++ b/configs/Bananapi_M2_Ultra_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_R40=y
 CONFIG_DRAM_CLK=576
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-# CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/LicheePi_Zero_defconfig b/configs/LicheePi_Zero_defconfig
index b2cf0a018c7f..299deb0195a2 100644
--- a/configs/LicheePi_Zero_defconfig
+++ b/configs/LicheePi_Zero_defconfig
@@ -3,5 +3,4 @@ CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="sun8i-v3s-licheepi-zero"
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_V3S=y
-# CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_NO_NET=y
diff --git a/configs/bananapi_m2_berry_defconfig b/configs/bananapi_m2_berry_defconfig
index 94d29a4743e1..6bbdcdd7e7eb 100644
--- a/configs/bananapi_m2_berry_defconfig
+++ b/configs/bananapi_m2_berry_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-v40-bananapi-m2-berry"
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_R40=y
 CONFIG_DRAM_CLK=576
-# CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/pinecube_defconfig b/configs/pinecube_defconfig
index 088dd6f8630a..7c68fff2ea22 100644
--- a/configs/pinecube_defconfig
+++ b/configs/pinecube_defconfig
@@ -6,7 +6,6 @@ CONFIG_MACH_SUN8I_V3=y
 CONFIG_DRAM_CLK=504
 CONFIG_DRAM_ODT_EN=y
 CONFIG_I2C0_ENABLE=y
-# CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_SPL_I2C=y
 CONFIG_NO_NET=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
-- 
2.49.0

