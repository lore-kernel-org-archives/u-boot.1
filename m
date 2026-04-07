Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551FAEDB7D0
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 22:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0632584120;
	Wed,  8 Apr 2026 00:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="sa507Fz8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B871D80398; Wed,  8 Apr 2026 00:35:05 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B1879840BE
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 00:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D76E139D7;
 Tue,  7 Apr 2026 15:34:55 -0700 (PDT)
Received: from ryzen.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 60AAC3F632; Tue,  7 Apr 2026 15:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775601301; bh=6nBqkMZ2XRd4ASoDi9zBv2fvk8FpZxL3zJf07317qtg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sa507Fz8P2kaqYuNfv1NaPlIY9RniCBZOdSuCs2yAWNGrwiOHFCaM8TddOiWW6cYn
 svGRJGQlRH4fmHkEM32+cRRdwZh2Mp9x7rS/Mtp2tckqFzLJXhVUxIpQbgJp4o6CpP
 miZka/MnYTRu29R62CYIR/5uOHAosrR2SyABjCBk=
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <contact@paulk.fr>, linux-sunxi@lists.linux.dev
Subject: [PATCH 2/3] sunxi: configs: enable power LEDs on 32-bit boards
Date: Wed,  8 Apr 2026 00:34:46 +0200
Message-ID: <20260407223447.4956-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
In-Reply-To: <20260407223447.4956-1-andre.przywara@arm.com>
References: <20260407223447.4956-1-andre.przywara@arm.com>
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

We recently gained a simple way to enable a power LED very early in the
SPL boot, through simple Kconfig variables.

Add those symbols to those boards' defconfigs where the DT indicates a
default-on power LED. The number used is <port bank> * 32 + <pin no>,
an active low setup means CONFIG_SPL_SUNXI_LED_STATUS_STATE must be
undefined.

This will light up the power LED very early in the (SPL) boot phase on
those 32-bit boards.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 configs/A13-OLinuXinoM_defconfig         | 3 +++
 configs/Bananapi_M2_Ultra_defconfig      | 3 +++
 configs/Bananapi_m2m_defconfig           | 3 +++
 configs/Mele_A1000G_quad_defconfig       | 3 +++
 configs/Mele_A1000_defconfig             | 3 +++
 configs/Mele_M9_defconfig                | 3 +++
 configs/bananapi_m1_plus_defconfig       | 3 +++
 configs/bananapi_m2_berry_defconfig      | 3 +++
 configs/bananapi_m2_zero_defconfig       | 3 +++
 configs/beelink_x2_defconfig             | 3 +++
 configs/icnova-a20-adb4006_defconfig     | 3 +++
 configs/nanopi_duo2_defconfig            | 3 +++
 configs/nanopi_neo_air_defconfig         | 3 +++
 configs/orangepi_2_defconfig             | 3 +++
 configs/orangepi_lite_defconfig          | 3 +++
 configs/orangepi_one_defconfig           | 3 +++
 configs/orangepi_pc_defconfig            | 3 +++
 configs/orangepi_zero_defconfig          | 3 +++
 configs/orangepi_zero_plus2_h3_defconfig | 3 +++
 19 files changed, 57 insertions(+)

diff --git a/configs/A13-OLinuXinoM_defconfig b/configs/A13-OLinuXinoM_defconfig
index f547635302f..7fbce4b6dd2 100644
--- a/configs/A13-OLinuXinoM_defconfig
+++ b/configs/A13-OLinuXinoM_defconfig
@@ -10,6 +10,9 @@ CONFIG_VIDEO_VGA_VIA_LCD=y
 CONFIG_VIDEO_VGA_VIA_LCD_FORCE_SYNC_ACTIVE_HIGH=y
 CONFIG_VIDEO_LCD_POWER="PB10"
 CONFIG_VIDEO_LCD_BL_PWM="PB2"
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=201
+CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x7f
diff --git a/configs/Bananapi_M2_Ultra_defconfig b/configs/Bananapi_M2_Ultra_defconfig
index 375b0063c1a..6e1b5b8c921 100644
--- a/configs/Bananapi_M2_Ultra_defconfig
+++ b/configs/Bananapi_M2_Ultra_defconfig
@@ -5,6 +5,9 @@ CONFIG_DRAM_CLK=576
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_R40=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=244
+CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
 # CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/Bananapi_m2m_defconfig b/configs/Bananapi_m2m_defconfig
index 0c20cce49ea..d8f99d0c70e 100644
--- a/configs/Bananapi_m2m_defconfig
+++ b/configs/Bananapi_m2m_defconfig
@@ -7,6 +7,9 @@ CONFIG_MACH_SUN8I_A33=y
 CONFIG_DRAM_ZQ=15291
 CONFIG_DRAM_ODT_EN=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=355
+# CONFIG_SPL_SUNXI_LED_STATUS_STATE is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/Mele_A1000G_quad_defconfig b/configs/Mele_A1000G_quad_defconfig
index 1f4739e0005..320856bda4e 100644
--- a/configs/Mele_A1000G_quad_defconfig
+++ b/configs/Mele_A1000G_quad_defconfig
@@ -4,6 +4,9 @@ CONFIG_DEFAULT_DEVICE_TREE="sun6i-a31-mele-a1000g-quad"
 CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_ZQ=120
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=237
+CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/Mele_A1000_defconfig b/configs/Mele_A1000_defconfig
index 93e73ebe3f1..7bfe9afb35c 100644
--- a/configs/Mele_A1000_defconfig
+++ b/configs/Mele_A1000_defconfig
@@ -5,6 +5,9 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_VIDEO_VGA=y
 CONFIG_VIDEO_COMPOSITE=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=244
+CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/Mele_M9_defconfig b/configs/Mele_M9_defconfig
index 9b1bb97eedd..a3dcbd21f8f 100644
--- a/configs/Mele_M9_defconfig
+++ b/configs/Mele_M9_defconfig
@@ -4,6 +4,9 @@ CONFIG_DEFAULT_DEVICE_TREE="sun6i-a31-m9"
 CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_ZQ=120
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=237
+CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/bananapi_m1_plus_defconfig b/configs/bananapi_m1_plus_defconfig
index 22b69aa88cb..49dcd679789 100644
--- a/configs/bananapi_m1_plus_defconfig
+++ b/configs/bananapi_m1_plus_defconfig
@@ -6,6 +6,9 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_VIDEO_COMPOSITE=y
 CONFIG_GMAC_TX_DELAY=3
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=249
+CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/bananapi_m2_berry_defconfig b/configs/bananapi_m2_berry_defconfig
index b406d519684..3d03b5fc596 100644
--- a/configs/bananapi_m2_berry_defconfig
+++ b/configs/bananapi_m2_berry_defconfig
@@ -4,6 +4,9 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-v40-bananapi-m2-berry"
 CONFIG_DRAM_CLK=576
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_R40=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=244
+CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
 # CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/bananapi_m2_zero_defconfig b/configs/bananapi_m2_zero_defconfig
index 337bafecd47..fcde63441b5 100644
--- a/configs/bananapi_m2_zero_defconfig
+++ b/configs/bananapi_m2_zero_defconfig
@@ -4,4 +4,7 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-h2-plus-bananapi-m2-zero"
 CONFIG_DRAM_CLK=408
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=362
+# CONFIG_SPL_SUNXI_LED_STATUS_STATE is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/beelink_x2_defconfig b/configs/beelink_x2_defconfig
index 3b0be26f063..1435ebc667d 100644
--- a/configs/beelink_x2_defconfig
+++ b/configs/beelink_x2_defconfig
@@ -5,6 +5,9 @@ CONFIG_DRAM_CLK=567
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=362
+CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUN8I_EMAC=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/icnova-a20-adb4006_defconfig b/configs/icnova-a20-adb4006_defconfig
index 507e330612e..9aed628d294 100644
--- a/configs/icnova-a20-adb4006_defconfig
+++ b/configs/icnova-a20-adb4006_defconfig
@@ -4,6 +4,9 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-icnova-a20-adb4006"
 CONFIG_DRAM_CLK=384
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=245
+CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/nanopi_duo2_defconfig b/configs/nanopi_duo2_defconfig
index 41b5502d24e..3f59b2f0071 100644
--- a/configs/nanopi_duo2_defconfig
+++ b/configs/nanopi_duo2_defconfig
@@ -5,6 +5,9 @@ CONFIG_DRAM_CLK=408
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
 # CONFIG_VIDEO_DE2 is not set
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=362
+CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_CONSOLE_MUX=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/nanopi_neo_air_defconfig b/configs/nanopi_neo_air_defconfig
index 3b8cbbfcdba..c91a7f79b5e 100644
--- a/configs/nanopi_neo_air_defconfig
+++ b/configs/nanopi_neo_air_defconfig
@@ -5,6 +5,9 @@ CONFIG_DRAM_CLK=408
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
 # CONFIG_VIDEO_DE2 is not set
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=362
+CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_CONSOLE_MUX=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/orangepi_2_defconfig b/configs/orangepi_2_defconfig
index 88433808538..e12b98161fd 100644
--- a/configs/orangepi_2_defconfig
+++ b/configs/orangepi_2_defconfig
@@ -5,6 +5,9 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-h3-orangepi-2"
 CONFIG_DRAM_CLK=672
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=362
+CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
diff --git a/configs/orangepi_lite_defconfig b/configs/orangepi_lite_defconfig
index ea1548f0fcd..08a7c516f89 100644
--- a/configs/orangepi_lite_defconfig
+++ b/configs/orangepi_lite_defconfig
@@ -4,6 +4,9 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-h3-orangepi-lite"
 CONFIG_DRAM_CLK=672
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=362
+CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
diff --git a/configs/orangepi_one_defconfig b/configs/orangepi_one_defconfig
index e4de13de26b..7ee16c2dcb7 100644
--- a/configs/orangepi_one_defconfig
+++ b/configs/orangepi_one_defconfig
@@ -4,6 +4,9 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-h3-orangepi-one"
 CONFIG_DRAM_CLK=672
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=362
+CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUN8I_EMAC=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/orangepi_pc_defconfig b/configs/orangepi_pc_defconfig
index f857d7fa203..12903541a84 100644
--- a/configs/orangepi_pc_defconfig
+++ b/configs/orangepi_pc_defconfig
@@ -4,6 +4,9 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-h3-orangepi-pc"
 CONFIG_DRAM_CLK=624
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=362
+CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
diff --git a/configs/orangepi_zero_defconfig b/configs/orangepi_zero_defconfig
index e128f5fcdb3..9a11154c9f9 100644
--- a/configs/orangepi_zero_defconfig
+++ b/configs/orangepi_zero_defconfig
@@ -6,6 +6,9 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
 # CONFIG_VIDEO_DE2 is not set
 CONFIG_SPL_SPI_SUNXI=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=362
+CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_CONSOLE_MUX=y
 CONFIG_MTD=y
diff --git a/configs/orangepi_zero_plus2_h3_defconfig b/configs/orangepi_zero_plus2_h3_defconfig
index caf515c7026..dd37b1a3fff 100644
--- a/configs/orangepi_zero_plus2_h3_defconfig
+++ b/configs/orangepi_zero_plus2_h3_defconfig
@@ -6,6 +6,9 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
 # CONFIG_DRAM_ODT_EN is not set
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_BIT=362
+CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUN8I_EMAC=y
 CONFIG_USB_EHCI_HCD=y
-- 
2.46.4

