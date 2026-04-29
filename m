Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13BDFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 09:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 015D584841;
	Wed, 29 Apr 2026 11:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ap31FTdg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B87428482E; Wed, 29 Apr 2026 11:28:48 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E1EC48484A
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 11:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7A40328D;
 Wed, 29 Apr 2026 02:28:35 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.154])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E47C13F62B;
 Wed, 29 Apr 2026 02:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777454921; bh=4xKaUW/cR+tIzAcEko+EPU4IGlXFsNsZznglfEQF6Dg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ap31FTdgVPhLzfHuepu3IotZyWsWulZO4gw3dmhLMYl4o2G/KOTLiVnRo+oTJgbgY
 nMcnBBLJxXND/MJWks/n+s1g3DmWAel4OARTGOMXW+l9YpKfZE+ddfQcaHGs3+KiYh
 CCg0k2sgjKf4GpJ4hxcWhGXiHH0A9Z51lEJBlGz8=
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 2/3] sunxi: configs: enable power LEDs on 32-bit boards
Date: Wed, 29 Apr 2026 11:28:27 +0200
Message-ID: <20260429092828.3076719-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429092828.3076719-1-andre.przywara@arm.com>
References: <20260429092828.3076719-1-andre.przywara@arm.com>
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
an active low setup means CONFIG_SPL_SUNXI_LED_STATUS_ACTIVE_HIGH must be
undefined. Since its default is "high", we can skip the symbol in the
defconfig in this case.

This will light up the power LED very early in the (SPL) boot phase on
those 32-bit boards.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 configs/A13-OLinuXinoM_defconfig         | 2 ++
 configs/Bananapi_M2_Ultra_defconfig      | 2 ++
 configs/Bananapi_m2m_defconfig           | 3 +++
 configs/Mele_A1000G_quad_defconfig       | 2 ++
 configs/Mele_A1000_defconfig             | 2 ++
 configs/Mele_M9_defconfig                | 2 ++
 configs/bananapi_m1_plus_defconfig       | 2 ++
 configs/bananapi_m2_berry_defconfig      | 2 ++
 configs/bananapi_m2_zero_defconfig       | 3 +++
 configs/beelink_x2_defconfig             | 2 ++
 configs/icnova-a20-adb4006_defconfig     | 2 ++
 configs/nanopi_duo2_defconfig            | 2 ++
 configs/nanopi_neo_air_defconfig         | 2 ++
 configs/orangepi_2_defconfig             | 2 ++
 configs/orangepi_lite_defconfig          | 2 ++
 configs/orangepi_one_defconfig           | 2 ++
 configs/orangepi_pc_defconfig            | 2 ++
 configs/orangepi_zero_defconfig          | 2 ++
 configs/orangepi_zero_plus2_h3_defconfig | 2 ++
 19 files changed, 40 insertions(+)

diff --git a/configs/A13-OLinuXinoM_defconfig b/configs/A13-OLinuXinoM_defconfig
index f547635302f..6c5a1b33194 100644
--- a/configs/A13-OLinuXinoM_defconfig
+++ b/configs/A13-OLinuXinoM_defconfig
@@ -10,6 +10,8 @@ CONFIG_VIDEO_VGA_VIA_LCD=y
 CONFIG_VIDEO_VGA_VIA_LCD_FORCE_SYNC_ACTIVE_HIGH=y
 CONFIG_VIDEO_LCD_POWER="PB10"
 CONFIG_VIDEO_LCD_BL_PWM="PB2"
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=201
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x7f
diff --git a/configs/Bananapi_M2_Ultra_defconfig b/configs/Bananapi_M2_Ultra_defconfig
index 375b0063c1a..750868033be 100644
--- a/configs/Bananapi_M2_Ultra_defconfig
+++ b/configs/Bananapi_M2_Ultra_defconfig
@@ -5,6 +5,8 @@ CONFIG_DRAM_CLK=576
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_R40=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=244
 # CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/Bananapi_m2m_defconfig b/configs/Bananapi_m2m_defconfig
index 0c20cce49ea..f75e3e09d03 100644
--- a/configs/Bananapi_m2m_defconfig
+++ b/configs/Bananapi_m2m_defconfig
@@ -7,6 +7,9 @@ CONFIG_MACH_SUN8I_A33=y
 CONFIG_DRAM_ZQ=15291
 CONFIG_DRAM_ODT_EN=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=355
+# CONFIG_SPL_SUNXI_LED_STATUS_ACTIVE_HIGH is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/Mele_A1000G_quad_defconfig b/configs/Mele_A1000G_quad_defconfig
index 1f4739e0005..ee6c902970a 100644
--- a/configs/Mele_A1000G_quad_defconfig
+++ b/configs/Mele_A1000G_quad_defconfig
@@ -4,6 +4,8 @@ CONFIG_DEFAULT_DEVICE_TREE="sun6i-a31-mele-a1000g-quad"
 CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_ZQ=120
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=237
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/Mele_A1000_defconfig b/configs/Mele_A1000_defconfig
index 93e73ebe3f1..48679265650 100644
--- a/configs/Mele_A1000_defconfig
+++ b/configs/Mele_A1000_defconfig
@@ -5,6 +5,8 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_VIDEO_VGA=y
 CONFIG_VIDEO_COMPOSITE=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=244
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/Mele_M9_defconfig b/configs/Mele_M9_defconfig
index 9b1bb97eedd..293e00db1b0 100644
--- a/configs/Mele_M9_defconfig
+++ b/configs/Mele_M9_defconfig
@@ -4,6 +4,8 @@ CONFIG_DEFAULT_DEVICE_TREE="sun6i-a31-m9"
 CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_ZQ=120
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=237
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/bananapi_m1_plus_defconfig b/configs/bananapi_m1_plus_defconfig
index 22b69aa88cb..14ecaf759b5 100644
--- a/configs/bananapi_m1_plus_defconfig
+++ b/configs/bananapi_m1_plus_defconfig
@@ -6,6 +6,8 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_VIDEO_COMPOSITE=y
 CONFIG_GMAC_TX_DELAY=3
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=249
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/bananapi_m2_berry_defconfig b/configs/bananapi_m2_berry_defconfig
index b406d519684..b9975211362 100644
--- a/configs/bananapi_m2_berry_defconfig
+++ b/configs/bananapi_m2_berry_defconfig
@@ -4,6 +4,8 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-v40-bananapi-m2-berry"
 CONFIG_DRAM_CLK=576
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_R40=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=244
 # CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/bananapi_m2_zero_defconfig b/configs/bananapi_m2_zero_defconfig
index 337bafecd47..5041802ea8c 100644
--- a/configs/bananapi_m2_zero_defconfig
+++ b/configs/bananapi_m2_zero_defconfig
@@ -4,4 +4,7 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-h2-plus-bananapi-m2-zero"
 CONFIG_DRAM_CLK=408
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=362
+# CONFIG_SPL_SUNXI_LED_STATUS_ACTIVE_HIGH is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/beelink_x2_defconfig b/configs/beelink_x2_defconfig
index 3b0be26f063..16a37da521d 100644
--- a/configs/beelink_x2_defconfig
+++ b/configs/beelink_x2_defconfig
@@ -5,6 +5,8 @@ CONFIG_DRAM_CLK=567
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=362
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUN8I_EMAC=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/icnova-a20-adb4006_defconfig b/configs/icnova-a20-adb4006_defconfig
index 507e330612e..dcb6457fe71 100644
--- a/configs/icnova-a20-adb4006_defconfig
+++ b/configs/icnova-a20-adb4006_defconfig
@@ -4,6 +4,8 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-icnova-a20-adb4006"
 CONFIG_DRAM_CLK=384
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=245
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/nanopi_duo2_defconfig b/configs/nanopi_duo2_defconfig
index 41b5502d24e..9b0fbecff60 100644
--- a/configs/nanopi_duo2_defconfig
+++ b/configs/nanopi_duo2_defconfig
@@ -5,6 +5,8 @@ CONFIG_DRAM_CLK=408
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
 # CONFIG_VIDEO_DE2 is not set
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=362
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_CONSOLE_MUX=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/nanopi_neo_air_defconfig b/configs/nanopi_neo_air_defconfig
index 3b8cbbfcdba..110bb1e864c 100644
--- a/configs/nanopi_neo_air_defconfig
+++ b/configs/nanopi_neo_air_defconfig
@@ -5,6 +5,8 @@ CONFIG_DRAM_CLK=408
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
 # CONFIG_VIDEO_DE2 is not set
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=362
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_CONSOLE_MUX=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/orangepi_2_defconfig b/configs/orangepi_2_defconfig
index 88433808538..43f3ab512f1 100644
--- a/configs/orangepi_2_defconfig
+++ b/configs/orangepi_2_defconfig
@@ -5,6 +5,8 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-h3-orangepi-2"
 CONFIG_DRAM_CLK=672
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=362
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
diff --git a/configs/orangepi_lite_defconfig b/configs/orangepi_lite_defconfig
index ea1548f0fcd..499ffd8ace5 100644
--- a/configs/orangepi_lite_defconfig
+++ b/configs/orangepi_lite_defconfig
@@ -4,6 +4,8 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-h3-orangepi-lite"
 CONFIG_DRAM_CLK=672
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=362
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
diff --git a/configs/orangepi_one_defconfig b/configs/orangepi_one_defconfig
index e4de13de26b..637eb41207e 100644
--- a/configs/orangepi_one_defconfig
+++ b/configs/orangepi_one_defconfig
@@ -4,6 +4,8 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-h3-orangepi-one"
 CONFIG_DRAM_CLK=672
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=362
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUN8I_EMAC=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/orangepi_pc_defconfig b/configs/orangepi_pc_defconfig
index f857d7fa203..01195b68621 100644
--- a/configs/orangepi_pc_defconfig
+++ b/configs/orangepi_pc_defconfig
@@ -4,6 +4,8 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-h3-orangepi-pc"
 CONFIG_DRAM_CLK=624
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=362
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
diff --git a/configs/orangepi_zero_defconfig b/configs/orangepi_zero_defconfig
index e128f5fcdb3..49a1f4d03da 100644
--- a/configs/orangepi_zero_defconfig
+++ b/configs/orangepi_zero_defconfig
@@ -6,6 +6,8 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
 # CONFIG_VIDEO_DE2 is not set
 CONFIG_SPL_SPI_SUNXI=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=362
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_CONSOLE_MUX=y
 CONFIG_MTD=y
diff --git a/configs/orangepi_zero_plus2_h3_defconfig b/configs/orangepi_zero_plus2_h3_defconfig
index caf515c7026..63335b404da 100644
--- a/configs/orangepi_zero_plus2_h3_defconfig
+++ b/configs/orangepi_zero_plus2_h3_defconfig
@@ -6,6 +6,8 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
 # CONFIG_DRAM_ODT_EN is not set
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=362
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUN8I_EMAC=y
 CONFIG_USB_EHCI_HCD=y
-- 
2.43.0

