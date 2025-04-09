Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B39C369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 00:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60C1982977;
	Wed,  9 Apr 2025 02:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C797A827A6; Wed,  9 Apr 2025 02:21:47 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 77C398304D
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 02:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 875D1236D;
 Tue,  8 Apr 2025 17:21:44 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 088E43F6A8;
 Tue,  8 Apr 2025 17:21:39 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Hans de Goede <hdegoede@redhat.com>,
 Olliver Schinagl <oliver@schinagl.nl>, Iain Paton <ipaton0@gmail.com>,
 Marcus Cooper <codekipper@gmail.com>, Stefan Mavrodiev <stefan@olimex.com>,
 Paul Kocialkowski <contact@paulk.fr>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <mripard@kernel.org>, Ian Campbell <ijc@hellion.org.uk>,
 Adam Sampson <ats@offog.org>, Zoltan Herpai <wigyori@uid0.hu>,
 Siarhei Siamashka <siarhei.siamashka@gmail.com>,
 VishnuPatekar <vishnupatekar0510@gmail.com>,
 Rask Ingemann Lambertsen <rask@formelder.dk>,
 Aleksei Mamlin <mamlinav@gmail.com>, Peter Korsgaard <peter@korsgaard.com>,
 Michal Suchanek <hramrach@gmail.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 Stefan Roese <sr@denx.de>, Phil Han <pengphei@sina.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Quentin Schulz <quentin.schulz@free-electrons.com>,
 Jonas Smedegaard <dr@jones.dk>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heiko Schocher <hs@denx.de>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH v2 4/8] sunxi: Remove obsolete USBx_VBUS_PIN Kconfig symbols
Date: Wed,  9 Apr 2025 01:20:32 +0100
Message-ID: <20250409002036.12212-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250409002036.12212-1-andre.przywara@arm.com>
References: <20250409002036.12212-1-andre.przywara@arm.com>
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

From: Samuel Holland <samuel@sholland.org>

Now that the USB PHY driver uses the device tree to get VBUS supply
regulators, these Kconfig symbols are unused. Remove them.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/Kconfig                  | 29 --------------------
 configs/A10s-OLinuXino-M_defconfig           |  1 -
 configs/A13-OLinuXinoM_defconfig             |  1 -
 configs/A13-OLinuXino_defconfig              |  1 -
 configs/A20-OLinuXino-Lime2-eMMC_defconfig   |  1 -
 configs/A20-OLinuXino-Lime2_defconfig        |  1 -
 configs/A20-Olimex-SOM-EVB_defconfig         |  1 -
 configs/A20-Olimex-SOM204-EVB-eMMC_defconfig |  1 -
 configs/A20-Olimex-SOM204-EVB_defconfig      |  1 -
 configs/A33-OLinuXino_defconfig              |  1 -
 configs/Ainol_AW1_defconfig                  |  1 -
 configs/Ampe_A76_defconfig                   |  1 -
 configs/Auxtek-T003_defconfig                |  1 -
 configs/Auxtek-T004_defconfig                |  1 -
 configs/Bananapi_M2_Ultra_defconfig          |  2 --
 configs/Bananapro_defconfig                  |  2 --
 configs/CHIP_defconfig                       |  1 -
 configs/CHIP_pro_defconfig                   |  1 -
 configs/CSQ_CS908_defconfig                  |  2 --
 configs/Chuwi_V7_CW0825_defconfig            |  1 -
 configs/Colombus_defconfig                   |  1 -
 configs/Cubieboard4_defconfig                |  3 --
 configs/Cubietruck_defconfig                 |  1 -
 configs/Cubietruck_plus_defconfig            |  3 --
 configs/Empire_electronix_d709_defconfig     |  1 -
 configs/Empire_electronix_m712_defconfig     |  1 -
 configs/Hummingbird_A31_defconfig            |  2 --
 configs/Hyundai_A7HD_defconfig               |  3 --
 configs/Linksprite_pcDuino3_Nano_defconfig   |  1 -
 configs/Linksprite_pcDuino_defconfig         |  2 --
 configs/MSI_Primo81_defconfig                |  1 -
 configs/Mele_A1000G_quad_defconfig           |  2 --
 configs/Mele_I7_defconfig                    |  2 --
 configs/Mele_M9_defconfig                    |  2 --
 configs/Merrii_A80_Optimus_defconfig         |  3 --
 configs/Mini-X_defconfig                     |  1 -
 configs/Orangepi_defconfig                   |  2 --
 configs/Orangepi_mini_defconfig              |  2 --
 configs/Sinlinx_SinA31s_defconfig            |  2 --
 configs/Sinovoip_BPI_M2_defconfig            |  2 --
 configs/Sinovoip_BPI_M3_defconfig            |  2 --
 configs/Sunchip_CX-A99_defconfig             |  3 --
 configs/UTOO_P66_defconfig                   |  1 -
 configs/Wexler_TAB7200_defconfig             |  1 -
 configs/Wobo_i5_defconfig                    |  1 -
 configs/Yones_Toptech_BD1078_defconfig       |  1 -
 configs/Yones_Toptech_BS1078_V2_defconfig    |  1 -
 configs/ba10_tv_box_defconfig                |  2 --
 configs/bananapi_m2_berry_defconfig          |  1 -
 configs/colorfly_e708_q1_defconfig           |  1 -
 configs/difrnce_dit4350_defconfig            |  1 -
 configs/dserve_dsrv9703c_defconfig           |  1 -
 configs/ga10h_v1_1_defconfig                 |  1 -
 configs/gt90h_v4_defconfig                   |  1 -
 configs/h8_homlet_v2_defconfig               |  2 --
 configs/iNet_3F_defconfig                    |  1 -
 configs/iNet_3W_defconfig                    |  1 -
 configs/iNet_86VS_defconfig                  |  1 -
 configs/iNet_D978_rev2_defconfig             |  1 -
 configs/icnova-a20-swac_defconfig            |  2 --
 configs/inet1_defconfig                      |  1 -
 configs/inet86dz_defconfig                   |  1 -
 configs/inet97fv2_defconfig                  |  1 -
 configs/inet98v_rev2_defconfig               |  1 -
 configs/inet9f_rev03_defconfig               |  1 -
 configs/inet_q972_defconfig                  |  1 -
 configs/jesurun_q5_defconfig                 |  1 -
 configs/mixtile_loftq_defconfig              |  2 --
 configs/mk802_a10s_defconfig                 |  1 -
 configs/mk802_defconfig                      |  1 -
 configs/orangepi_2_defconfig                 |  1 -
 configs/orangepi_plus_defconfig              |  2 --
 configs/orangepi_zero2_defconfig             |  1 -
 configs/orangepi_zero3_defconfig             |  1 -
 configs/parrot_r16_defconfig                 |  1 -
 configs/pine_h64_defconfig                   |  1 -
 configs/polaroid_mid2407pxe03_defconfig      |  1 -
 configs/polaroid_mid2809pxe04_defconfig      |  1 -
 configs/pov_protab2_ips9_defconfig           |  1 -
 configs/q8_a13_tablet_defconfig              |  1 -
 configs/q8_a23_tablet_800x480_defconfig      |  1 -
 configs/q8_a33_tablet_1024x600_defconfig     |  1 -
 configs/q8_a33_tablet_800x480_defconfig      |  1 -
 configs/r7-tv-dongle_defconfig               |  1 -
 configs/sun8i_a23_evb_defconfig              |  2 --
 configs/tbs_a711_defconfig                   |  1 -
 configs/teres_i_defconfig                    |  1 -
 87 files changed, 144 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index ab432390d3c..8dc9aeb2e7b 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -782,13 +782,6 @@ config MMC_SUNXI_SLOT_EXTRA
 	slot or emmc on mmc1 - mmc3. Setting this to 1, 2 or 3 will enable
 	support for this.
 
-config USB0_VBUS_PIN
-	string "Vbus enable pin for usb0 (otg)"
-	default ""
-	---help---
-	Set the Vbus enable pin for usb0 (otg). This takes a string in the
-	format understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of port H.
-
 config USB0_VBUS_DET
 	string "Vbus detect pin for usb0 (otg)"
 	default ""
@@ -803,28 +796,6 @@ config USB0_ID_DET
 	Set the ID detect pin for usb0 (otg). This takes a string in the
 	format understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of port H.
 
-config USB1_VBUS_PIN
-	string "Vbus enable pin for usb1 (ehci0)"
-	default "PH6" if MACH_SUN4I || MACH_SUN7I
-	default "PH27" if MACH_SUN6I
-	---help---
-	Set the Vbus enable pin for usb1 (ehci0, usb0 is the otg). This takes
-	a string in the format understood by sunxi_name_to_gpio, e.g.
-	PH1 for pin 1 of port H.
-
-config USB2_VBUS_PIN
-	string "Vbus enable pin for usb2 (ehci1)"
-	default "PH3" if MACH_SUN4I || MACH_SUN7I
-	default "PH24" if MACH_SUN6I
-	---help---
-	See USB1_VBUS_PIN help text.
-
-config USB3_VBUS_PIN
-	string "Vbus enable pin for usb3 (ehci2)"
-	default ""
-	---help---
-	See USB1_VBUS_PIN help text.
-
 config I2C0_ENABLE
 	bool "Enable I2C/TWI controller 0"
 	default y if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I_R40
diff --git a/configs/A10s-OLinuXino-M_defconfig b/configs/A10s-OLinuXino-M_defconfig
index 5a10fce7273..20fa977504f 100644
--- a/configs/A10s-OLinuXino-M_defconfig
+++ b/configs/A10s-OLinuXino-M_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
 CONFIG_MMC_SUNXI_SLOT_EXTRA=1
-CONFIG_USB1_VBUS_PIN="PB10"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
diff --git a/configs/A13-OLinuXinoM_defconfig b/configs/A13-OLinuXinoM_defconfig
index 5001ce9ce52..4bb34d02fba 100644
--- a/configs/A13-OLinuXinoM_defconfig
+++ b/configs/A13-OLinuXinoM_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=408
 CONFIG_DRAM_EMR1=0
-CONFIG_USB1_VBUS_PIN="PG11"
 # CONFIG_VIDEO_HDMI is not set
 CONFIG_VIDEO_VGA_VIA_LCD=y
 CONFIG_VIDEO_VGA_VIA_LCD_FORCE_SYNC_ACTIVE_HIGH=y
diff --git a/configs/A13-OLinuXino_defconfig b/configs/A13-OLinuXino_defconfig
index bc0fc0efe0a..c368daf03b7 100644
--- a/configs/A13-OLinuXino_defconfig
+++ b/configs/A13-OLinuXino_defconfig
@@ -6,7 +6,6 @@ CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=408
 CONFIG_DRAM_EMR1=0
 CONFIG_USB0_VBUS_DET="PG1"
-CONFIG_USB1_VBUS_PIN="PG11"
 CONFIG_AXP_GPIO=y
 # CONFIG_VIDEO_HDMI is not set
 CONFIG_VIDEO_VGA_VIA_LCD=y
diff --git a/configs/A20-OLinuXino-Lime2-eMMC_defconfig b/configs/A20-OLinuXino-Lime2-eMMC_defconfig
index 22d80ca2c9c..7b1b73b5cef 100644
--- a/configs/A20-OLinuXino-Lime2-eMMC_defconfig
+++ b/configs/A20-OLinuXino-Lime2-eMMC_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=384
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_VBUS_PIN="PC17"
 CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_I2C1_ENABLE=y
 CONFIG_SPL_SPI_SUNXI=y
diff --git a/configs/A20-OLinuXino-Lime2_defconfig b/configs/A20-OLinuXino-Lime2_defconfig
index e10660c933c..2b91f3ea02f 100644
--- a/configs/A20-OLinuXino-Lime2_defconfig
+++ b/configs/A20-OLinuXino-Lime2_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-olinuxino-lime2"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=384
-CONFIG_USB0_VBUS_PIN="PC17"
 CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_I2C1_ENABLE=y
 CONFIG_AHCI=y
diff --git a/configs/A20-Olimex-SOM-EVB_defconfig b/configs/A20-Olimex-SOM-EVB_defconfig
index ac900477d1e..b9df35d1b98 100644
--- a/configs/A20-Olimex-SOM-EVB_defconfig
+++ b/configs/A20-Olimex-SOM-EVB_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=384
 CONFIG_MMC_SUNXI_SLOT_EXTRA=3
-CONFIG_USB0_VBUS_PIN="PB9"
 CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/A20-Olimex-SOM204-EVB-eMMC_defconfig b/configs/A20-Olimex-SOM204-EVB-eMMC_defconfig
index 00a98140b37..b1012c08631 100644
--- a/configs/A20-Olimex-SOM204-EVB-eMMC_defconfig
+++ b/configs/A20-Olimex-SOM204-EVB-eMMC_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=384
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_VBUS_PIN="PC17"
 CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_I2C1_ENABLE=y
 CONFIG_GMAC_TX_DELAY=4
diff --git a/configs/A20-Olimex-SOM204-EVB_defconfig b/configs/A20-Olimex-SOM204-EVB_defconfig
index f4ae3ae6d8b..2fc143680e2 100644
--- a/configs/A20-Olimex-SOM204-EVB_defconfig
+++ b/configs/A20-Olimex-SOM204-EVB_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-olimex-som204-evb"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=384
-CONFIG_USB0_VBUS_PIN="PC17"
 CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_I2C1_ENABLE=y
 CONFIG_GMAC_TX_DELAY=4
diff --git a/configs/A33-OLinuXino_defconfig b/configs/A33-OLinuXino_defconfig
index 705c869c19f..854918f4274 100644
--- a/configs/A33-OLinuXino_defconfig
+++ b/configs/A33-OLinuXino_defconfig
@@ -6,7 +6,6 @@ CONFIG_MACH_SUN8I_A33=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_ZQ=15291
 CONFIG_DRAM_ODT_EN=y
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PB3"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:18,pclk_khz:33000,le:16,ri:209,up:22,lo:22,hs:30,vs:1,sync:3,vmode:0"
diff --git a/configs/Ainol_AW1_defconfig b/configs/Ainol_AW1_defconfig
index 51f26f48b29..eda0c95584c 100644
--- a/configs/Ainol_AW1_defconfig
+++ b/configs/Ainol_AW1_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_ZQ=123
-CONFIG_USB0_VBUS_PIN="PB9"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:18,pclk_khz:40000,le:87,ri:112,up:38,lo:141,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_POWER="PH8"
diff --git a/configs/Ampe_A76_defconfig b/configs/Ampe_A76_defconfig
index 0f8e571efed..ca3e7d5efee 100644
--- a/configs/Ampe_A76_defconfig
+++ b/configs/Ampe_A76_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun5i-a13-ampe-a76"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
-CONFIG_USB0_VBUS_PIN="PG12"
 CONFIG_USB0_VBUS_DET="PG1"
 CONFIG_USB0_ID_DET="PG2"
 CONFIG_AXP_GPIO=y
diff --git a/configs/Auxtek-T003_defconfig b/configs/Auxtek-T003_defconfig
index 520939538f8..92e3016703e 100644
--- a/configs/Auxtek-T003_defconfig
+++ b/configs/Auxtek-T003_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=408
 CONFIG_DRAM_EMR1=0
-CONFIG_USB1_VBUS_PIN="PB10"
 CONFIG_VIDEO_COMPOSITE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/Auxtek-T004_defconfig b/configs/Auxtek-T004_defconfig
index 8b3a9eac788..2290a440fe5 100644
--- a/configs/Auxtek-T004_defconfig
+++ b/configs/Auxtek-T004_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a10s-auxtek-t004"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
-CONFIG_USB1_VBUS_PIN="PG13"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
diff --git a/configs/Bananapi_M2_Ultra_defconfig b/configs/Bananapi_M2_Ultra_defconfig
index 2cc7bbbd8b7..b1195afea20 100644
--- a/configs/Bananapi_M2_Ultra_defconfig
+++ b/configs/Bananapi_M2_Ultra_defconfig
@@ -5,8 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_R40=y
 CONFIG_DRAM_CLK=576
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB1_VBUS_PIN="PH23"
-CONFIG_USB2_VBUS_PIN="PH23"
 # CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/Bananapro_defconfig b/configs/Bananapro_defconfig
index 02be8971df9..46025e95fb8 100644
--- a/configs/Bananapro_defconfig
+++ b/configs/Bananapro_defconfig
@@ -4,8 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-bananapro"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=432
-CONFIG_USB1_VBUS_PIN="PH0"
-CONFIG_USB2_VBUS_PIN="PH1"
 CONFIG_VIDEO_COMPOSITE=y
 CONFIG_GMAC_TX_DELAY=3
 CONFIG_AHCI=y
diff --git a/configs/CHIP_defconfig b/configs/CHIP_defconfig
index c220d269ab6..70d2cfa563d 100644
--- a/configs/CHIP_defconfig
+++ b/configs/CHIP_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-r8-chip"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_TIMINGS_DDR3_800E_1066G_1333J=y
-CONFIG_USB0_VBUS_PIN="PB10"
 CONFIG_VIDEO_COMPOSITE=y
 CONFIG_CHIP_DIP_SCAN=y
 CONFIG_SPL_I2C=y
diff --git a/configs/CHIP_pro_defconfig b/configs/CHIP_pro_defconfig
index 05874125f4b..17737d86ded 100644
--- a/configs/CHIP_pro_defconfig
+++ b/configs/CHIP_pro_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-gr8-chip-pro"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_TIMINGS_DDR3_800E_1066G_1333J=y
-CONFIG_USB0_VBUS_PIN="PB10"
 CONFIG_SPL_I2C=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=sunxi-nand.0"
diff --git a/configs/CSQ_CS908_defconfig b/configs/CSQ_CS908_defconfig
index 1cd39d498f2..61fcb61cede 100644
--- a/configs/CSQ_CS908_defconfig
+++ b/configs/CSQ_CS908_defconfig
@@ -4,8 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun6i-a31s-cs908"
 CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_CLK=432
-CONFIG_USB1_VBUS_PIN=""
-CONFIG_USB2_VBUS_PIN=""
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/Chuwi_V7_CW0825_defconfig b/configs/Chuwi_V7_CW0825_defconfig
index 40f52d1a8d3..ce770153062 100644
--- a/configs/Chuwi_V7_CW0825_defconfig
+++ b/configs/Chuwi_V7_CW0825_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=408
 CONFIG_DRAM_EMR1=4
-CONFIG_USB0_VBUS_PIN="PB9"
 CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_USB0_ID_DET="PH4"
 CONFIG_VIDEO_LCD_MODE="x:1024,y:768,depth:24,pclk_khz:51000,le:19,ri:300,up:6,lo:31,hs:1,vs:1,sync:3,vmode:0"
diff --git a/configs/Colombus_defconfig b/configs/Colombus_defconfig
index 270bd7d351a..368919d6d15 100644
--- a/configs/Colombus_defconfig
+++ b/configs/Colombus_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_CLK=240
 CONFIG_DRAM_ZQ=251
-CONFIG_USB1_VBUS_PIN=""
 CONFIG_I2C0_ENABLE=y
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:2048,y:1536,depth:24,pclk_khz:208000,le:5,ri:150,up:9,lo:24,hs:5,vs:1,sync:3,vmode:0"
diff --git a/configs/Cubieboard4_defconfig b/configs/Cubieboard4_defconfig
index c8adabe0a0a..a6bc72daf52 100644
--- a/configs/Cubieboard4_defconfig
+++ b/configs/Cubieboard4_defconfig
@@ -5,10 +5,7 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN9I=y
 CONFIG_DRAM_CLK=672
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PH16"
-CONFIG_USB1_VBUS_PIN="PH14"
-CONFIG_USB3_VBUS_PIN="PH15"
 CONFIG_AXP_GPIO=y
 CONFIG_SYS_I2C_SUN8I_RSB=y
 CONFIG_REGULATOR_AXP_DRIVEVBUS=y
diff --git a/configs/Cubietruck_defconfig b/configs/Cubietruck_defconfig
index 184143d7086..f4829d38dbe 100644
--- a/configs/Cubietruck_defconfig
+++ b/configs/Cubietruck_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-cubietruck"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=432
-CONFIG_USB0_VBUS_PIN="PH17"
 CONFIG_USB0_VBUS_DET="PH22"
 CONFIG_USB0_ID_DET="PH19"
 CONFIG_VIDEO_VGA=y
diff --git a/configs/Cubietruck_plus_defconfig b/configs/Cubietruck_plus_defconfig
index f349d9bc49f..e24cf553e1c 100644
--- a/configs/Cubietruck_plus_defconfig
+++ b/configs/Cubietruck_plus_defconfig
@@ -7,10 +7,7 @@ CONFIG_DRAM_CLK=672
 CONFIG_DRAM_ZQ=15355
 CONFIG_DRAM_ODT_EN=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PH11"
-CONFIG_USB1_VBUS_PIN="PD29"
-CONFIG_USB2_VBUS_PIN="PL6"
 CONFIG_I2C0_ENABLE=y
 CONFIG_AXP_GPIO=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/Empire_electronix_d709_defconfig b/configs/Empire_electronix_d709_defconfig
index 18b1cfaa811..28b70ab0294 100644
--- a/configs/Empire_electronix_d709_defconfig
+++ b/configs/Empire_electronix_d709_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_EMR1=0
-CONFIG_USB0_VBUS_PIN="PG12"
 CONFIG_USB0_VBUS_DET="PG1"
 CONFIG_USB0_ID_DET="PG2"
 CONFIG_AXP_GPIO=y
diff --git a/configs/Empire_electronix_m712_defconfig b/configs/Empire_electronix_m712_defconfig
index abaf386563e..58b9300b241 100644
--- a/configs/Empire_electronix_m712_defconfig
+++ b/configs/Empire_electronix_m712_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a13-empire-electronix-m712"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=408
-CONFIG_USB0_VBUS_PIN="PG12"
 CONFIG_USB0_VBUS_DET="PG1"
 CONFIG_USB0_ID_DET="PG2"
 CONFIG_AXP_GPIO=y
diff --git a/configs/Hummingbird_A31_defconfig b/configs/Hummingbird_A31_defconfig
index 24e8b5be1b5..2bc9a0917c5 100644
--- a/configs/Hummingbird_A31_defconfig
+++ b/configs/Hummingbird_A31_defconfig
@@ -4,8 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun6i-a31-hummingbird"
 CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_ZQ=251
-CONFIG_USB1_VBUS_PIN="PH24"
-CONFIG_USB2_VBUS_PIN=""
 CONFIG_VIDEO_VGA_VIA_LCD=y
 CONFIG_VIDEO_VGA_EXTERNAL_DAC_EN="PH25"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/Hyundai_A7HD_defconfig b/configs/Hyundai_A7HD_defconfig
index 541f98db9e1..a689aee7145 100644
--- a/configs/Hyundai_A7HD_defconfig
+++ b/configs/Hyundai_A7HD_defconfig
@@ -4,10 +4,7 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-hyundai-a7hd"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_EMR1=4
-CONFIG_USB0_VBUS_PIN="PB09"
 CONFIG_USB0_VBUS_DET="PH5"
-CONFIG_USB1_VBUS_PIN=""
-CONFIG_USB2_VBUS_PIN="PH6"
 CONFIG_VIDEO_LCD_MODE="x:1024,y:600,depth:18,pclk_khz:51000,le:45,ri:274,up:22,lo:12,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_POWER="PH2"
 CONFIG_VIDEO_LCD_BL_EN="PH9"
diff --git a/configs/Linksprite_pcDuino3_Nano_defconfig b/configs/Linksprite_pcDuino3_Nano_defconfig
index 9eb9a918aee..3e6c28018b2 100644
--- a/configs/Linksprite_pcDuino3_Nano_defconfig
+++ b/configs/Linksprite_pcDuino3_Nano_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=408
 CONFIG_DRAM_ZQ=122
-CONFIG_USB1_VBUS_PIN="PH11"
 CONFIG_GMAC_TX_DELAY=3
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/Linksprite_pcDuino_defconfig b/configs/Linksprite_pcDuino_defconfig
index 0e1a7780c3d..4b0b0e3b845 100644
--- a/configs/Linksprite_pcDuino_defconfig
+++ b/configs/Linksprite_pcDuino_defconfig
@@ -3,8 +3,6 @@ CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-pcduino"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
-CONFIG_USB1_VBUS_PIN=""
-CONFIG_USB2_VBUS_PIN=""
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
diff --git a/configs/MSI_Primo81_defconfig b/configs/MSI_Primo81_defconfig
index 709d27d342e..9a7d80fce0d 100644
--- a/configs/MSI_Primo81_defconfig
+++ b/configs/MSI_Primo81_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_CLK=360
 CONFIG_DRAM_ZQ=122
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:768,y:1024,depth:18,pclk_khz:66000,le:56,ri:60,up:30,lo:36,hs:64,vs:50,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_BL_EN="PA25"
diff --git a/configs/Mele_A1000G_quad_defconfig b/configs/Mele_A1000G_quad_defconfig
index c697d286dc1..1f4739e0005 100644
--- a/configs/Mele_A1000G_quad_defconfig
+++ b/configs/Mele_A1000G_quad_defconfig
@@ -4,8 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun6i-a31-mele-a1000g-quad"
 CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_ZQ=120
-CONFIG_USB1_VBUS_PIN="PC27"
-CONFIG_USB2_VBUS_PIN=""
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/Mele_I7_defconfig b/configs/Mele_I7_defconfig
index 2b9bca13d08..be2e4d1809f 100644
--- a/configs/Mele_I7_defconfig
+++ b/configs/Mele_I7_defconfig
@@ -4,8 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun6i-a31-i7"
 CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_ZQ=120
-CONFIG_USB1_VBUS_PIN="PC27"
-CONFIG_USB2_VBUS_PIN=""
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/Mele_M9_defconfig b/configs/Mele_M9_defconfig
index be6dd417545..9b1bb97eedd 100644
--- a/configs/Mele_M9_defconfig
+++ b/configs/Mele_M9_defconfig
@@ -4,8 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun6i-a31-m9"
 CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_ZQ=120
-CONFIG_USB1_VBUS_PIN="PC27"
-CONFIG_USB2_VBUS_PIN=""
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/Merrii_A80_Optimus_defconfig b/configs/Merrii_A80_Optimus_defconfig
index c7a3af7a8d1..373dbf4bfb1 100644
--- a/configs/Merrii_A80_Optimus_defconfig
+++ b/configs/Merrii_A80_Optimus_defconfig
@@ -5,10 +5,7 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN9I=y
 CONFIG_DRAM_CLK=672
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PH3"
-CONFIG_USB1_VBUS_PIN="PH4"
-CONFIG_USB3_VBUS_PIN="PH5"
 CONFIG_AXP_GPIO=y
 CONFIG_SYS_I2C_SUN8I_RSB=y
 CONFIG_REGULATOR_AXP_DRIVEVBUS=y
diff --git a/configs/Mini-X_defconfig b/configs/Mini-X_defconfig
index e64352b4b6a..b1d8cdb0627 100644
--- a/configs/Mini-X_defconfig
+++ b/configs/Mini-X_defconfig
@@ -3,7 +3,6 @@ CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-mini-xplus"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
-CONFIG_USB0_VBUS_PIN="PB9"
 CONFIG_VIDEO_COMPOSITE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/Orangepi_defconfig b/configs/Orangepi_defconfig
index 53edf525ec0..2ca40fdf2a0 100644
--- a/configs/Orangepi_defconfig
+++ b/configs/Orangepi_defconfig
@@ -4,8 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-orangepi"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=432
-CONFIG_USB1_VBUS_PIN="PH26"
-CONFIG_USB2_VBUS_PIN="PH22"
 CONFIG_VIDEO_VGA=y
 CONFIG_VIDEO_COMPOSITE=y
 CONFIG_GMAC_TX_DELAY=3
diff --git a/configs/Orangepi_mini_defconfig b/configs/Orangepi_mini_defconfig
index ccf32670170..6b6e4025370 100644
--- a/configs/Orangepi_mini_defconfig
+++ b/configs/Orangepi_mini_defconfig
@@ -5,8 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=432
 CONFIG_MMC_SUNXI_SLOT_EXTRA=3
-CONFIG_USB1_VBUS_PIN="PH26"
-CONFIG_USB2_VBUS_PIN="PH22"
 CONFIG_VIDEO_COMPOSITE=y
 CONFIG_GMAC_TX_DELAY=3
 CONFIG_AHCI=y
diff --git a/configs/Sinlinx_SinA31s_defconfig b/configs/Sinlinx_SinA31s_defconfig
index 59869b74ac5..1c4c8519711 100644
--- a/configs/Sinlinx_SinA31s_defconfig
+++ b/configs/Sinlinx_SinA31s_defconfig
@@ -6,8 +6,6 @@ CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_ZQ=251
 CONFIG_MMC_SUNXI_SLOT_EXTRA=3
-CONFIG_USB1_VBUS_PIN=""
-CONFIG_USB2_VBUS_PIN=""
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/Sinovoip_BPI_M2_defconfig b/configs/Sinovoip_BPI_M2_defconfig
index aba95270eb2..d7ef265d213 100644
--- a/configs/Sinovoip_BPI_M2_defconfig
+++ b/configs/Sinovoip_BPI_M2_defconfig
@@ -4,8 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun6i-a31s-sinovoip-bpi-m2"
 CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_CLK=432
-CONFIG_USB1_VBUS_PIN=""
-CONFIG_USB2_VBUS_PIN=""
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/Sinovoip_BPI_M3_defconfig b/configs/Sinovoip_BPI_M3_defconfig
index fcdd7ded82d..d03e1ebb23e 100644
--- a/configs/Sinovoip_BPI_M3_defconfig
+++ b/configs/Sinovoip_BPI_M3_defconfig
@@ -8,9 +8,7 @@ CONFIG_DRAM_CLK=480
 CONFIG_DRAM_ZQ=15355
 CONFIG_DRAM_ODT_EN=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PH11"
-CONFIG_USB1_VBUS_PIN="PD24"
 CONFIG_AXP_GPIO=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_CONSOLE_MUX=y
diff --git a/configs/Sunchip_CX-A99_defconfig b/configs/Sunchip_CX-A99_defconfig
index 348140dcc0c..0d78a13bd71 100644
--- a/configs/Sunchip_CX-A99_defconfig
+++ b/configs/Sunchip_CX-A99_defconfig
@@ -7,7 +7,4 @@ CONFIG_DRAM_CLK=600
 CONFIG_DRAM_ZQ=3881915
 CONFIG_DRAM_ODT_EN=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_VBUS_PIN="PH15"
-CONFIG_USB1_VBUS_PIN="PL7"
-CONFIG_USB3_VBUS_PIN="PL8"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/UTOO_P66_defconfig b/configs/UTOO_P66_defconfig
index d74ef2127d9..a2ccdf584c8 100644
--- a/configs/UTOO_P66_defconfig
+++ b/configs/UTOO_P66_defconfig
@@ -6,7 +6,6 @@ CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_EMR1=0
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_VBUS_PIN="PB04"
 CONFIG_USB0_VBUS_DET="PG01"
 CONFIG_USB0_ID_DET="PG2"
 CONFIG_AXP_GPIO=y
diff --git a/configs/Wexler_TAB7200_defconfig b/configs/Wexler_TAB7200_defconfig
index 40aeb6680c2..bdbd48e2c08 100644
--- a/configs/Wexler_TAB7200_defconfig
+++ b/configs/Wexler_TAB7200_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-wexler-tab7200"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=384
-CONFIG_USB0_VBUS_PIN="PB9"
 CONFIG_USB0_ID_DET="PH4"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:24,pclk_khz:33000,le:45,ri:210,up:22,lo:22,hs:1,vs:1,sync:3,vmode:0"
diff --git a/configs/Wobo_i5_defconfig b/configs/Wobo_i5_defconfig
index 9f6d2a78f48..49c87c3311a 100644
--- a/configs/Wobo_i5_defconfig
+++ b/configs/Wobo_i5_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a10s-wobo-i5"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
-CONFIG_USB1_VBUS_PIN="PG12"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
diff --git a/configs/Yones_Toptech_BD1078_defconfig b/configs/Yones_Toptech_BD1078_defconfig
index 9b13659bccd..d7988616f6d 100644
--- a/configs/Yones_Toptech_BD1078_defconfig
+++ b/configs/Yones_Toptech_BD1078_defconfig
@@ -6,7 +6,6 @@ CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=408
 CONFIG_MMC1_PINS_PH=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=1
-CONFIG_USB0_VBUS_PIN="PB9"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:1024,y:600,depth:24,pclk_khz:63000,le:32,ri:287,up:22,lo:12,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_DCLK_PHASE=0
diff --git a/configs/Yones_Toptech_BS1078_V2_defconfig b/configs/Yones_Toptech_BS1078_V2_defconfig
index 67fef2a6202..e5196b78cf6 100644
--- a/configs/Yones_Toptech_BS1078_V2_defconfig
+++ b/configs/Yones_Toptech_BS1078_V2_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_CLK=420
 CONFIG_DRAM_ZQ=251
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PA15"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:1024,y:600,depth:24,pclk_khz:70000,le:120,ri:180,up:17,lo:15,hs:20,vs:3,sync:3,vmode:0"
diff --git a/configs/ba10_tv_box_defconfig b/configs/ba10_tv_box_defconfig
index c76f36ec37e..60b678ad09e 100644
--- a/configs/ba10_tv_box_defconfig
+++ b/configs/ba10_tv_box_defconfig
@@ -5,8 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=384
 CONFIG_DRAM_EMR1=4
-CONFIG_USB0_VBUS_PIN="PB9"
-CONFIG_USB2_VBUS_PIN="PH12"
 CONFIG_VIDEO_COMPOSITE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/bananapi_m2_berry_defconfig b/configs/bananapi_m2_berry_defconfig
index f4edcf43708..94d29a4743e 100644
--- a/configs/bananapi_m2_berry_defconfig
+++ b/configs/bananapi_m2_berry_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-v40-bananapi-m2-berry"
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_R40=y
 CONFIG_DRAM_CLK=576
-CONFIG_USB1_VBUS_PIN="PH23"
 # CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/colorfly_e708_q1_defconfig b/configs/colorfly_e708_q1_defconfig
index 201b7425573..2d95f23bf3f 100644
--- a/configs/colorfly_e708_q1_defconfig
+++ b/configs/colorfly_e708_q1_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_ZQ=251
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PA15"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:800,y:1280,depth:24,pclk_khz:64000,le:20,ri:34,up:1,lo:16,hs:10,vs:1,sync:3,vmode:0"
diff --git a/configs/difrnce_dit4350_defconfig b/configs/difrnce_dit4350_defconfig
index b0604302c97..6df8d4972bb 100644
--- a/configs/difrnce_dit4350_defconfig
+++ b/configs/difrnce_dit4350_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a13-difrnce-dit4350"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=408
-CONFIG_USB0_VBUS_PIN="PG12"
 CONFIG_USB0_VBUS_DET="PG1"
 CONFIG_USB0_ID_DET="PG2"
 CONFIG_AXP_GPIO=y
diff --git a/configs/dserve_dsrv9703c_defconfig b/configs/dserve_dsrv9703c_defconfig
index 06a79c935d7..91b9018a968 100644
--- a/configs/dserve_dsrv9703c_defconfig
+++ b/configs/dserve_dsrv9703c_defconfig
@@ -3,7 +3,6 @@ CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-dserve-dsrv9703c"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
-CONFIG_USB0_VBUS_PIN="PB9"
 CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_USB0_ID_DET="PH4"
 CONFIG_VIDEO_LCD_MODE="x:1024,y:768,depth:18,pclk_khz:80000,le:479,ri:544,up:5,lo:26,hs:1,vs:1,sync:3,vmode:0"
diff --git a/configs/ga10h_v1_1_defconfig b/configs/ga10h_v1_1_defconfig
index 5d083742f1f..44aeb859aa8 100644
--- a/configs/ga10h_v1_1_defconfig
+++ b/configs/ga10h_v1_1_defconfig
@@ -6,7 +6,6 @@ CONFIG_MACH_SUN8I_A33=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_ZQ=15291
 CONFIG_DRAM_ODT_EN=y
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PH8"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:1024,y:600,depth:18,pclk_khz:52000,le:138,ri:162,up:22,lo:10,hs:20,vs:3,sync:3,vmode:0"
diff --git a/configs/gt90h_v4_defconfig b/configs/gt90h_v4_defconfig
index 6502ac8cf43..527851d8e8e 100644
--- a/configs/gt90h_v4_defconfig
+++ b/configs/gt90h_v4_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_A23=y
 CONFIG_DRAM_CLK=480
 CONFIG_DRAM_ZQ=32767
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PH8"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:1024,y:600,depth:18,pclk_khz:55000,le:159,ri:160,up:22,lo:12,hs:1,vs:1,sync:3,vmode:0"
diff --git a/configs/h8_homlet_v2_defconfig b/configs/h8_homlet_v2_defconfig
index 29f965200e1..2fcae46e33e 100644
--- a/configs/h8_homlet_v2_defconfig
+++ b/configs/h8_homlet_v2_defconfig
@@ -6,8 +6,6 @@ CONFIG_MACH_SUN8I_A83T=y
 CONFIG_DRAM_CLK=480
 CONFIG_DRAM_ZQ=15355
 CONFIG_DRAM_ODT_EN=y
-CONFIG_USB0_VBUS_PIN="PL5"
-CONFIG_USB1_VBUS_PIN="PL6"
 CONFIG_AXP_GPIO=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_CONSOLE_MUX=y
diff --git a/configs/iNet_3F_defconfig b/configs/iNet_3F_defconfig
index c96336f74b3..2d21b5bb856 100644
--- a/configs/iNet_3F_defconfig
+++ b/configs/iNet_3F_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_EMR1=4
-CONFIG_USB0_VBUS_PIN="PB9"
 CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_VIDEO_LCD_MODE="x:1024,y:768,depth:18,pclk_khz:100000,le:799,ri:260,up:15,lo:16,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_POWER="PH8"
diff --git a/configs/iNet_3W_defconfig b/configs/iNet_3W_defconfig
index 76228f0cd13..76031c0df40 100644
--- a/configs/iNet_3W_defconfig
+++ b/configs/iNet_3W_defconfig
@@ -6,7 +6,6 @@ CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=408
 CONFIG_DRAM_ZQ=127
 CONFIG_DRAM_EMR1=4
-CONFIG_USB0_VBUS_PIN="PB9"
 CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_VIDEO_LCD_MODE="x:1024,y:768,depth:24,pclk_khz:65000,le:159,ri:160,up:22,lo:15,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_POWER="PH8"
diff --git a/configs/iNet_86VS_defconfig b/configs/iNet_86VS_defconfig
index afa530d1bd9..8db79778bd6 100644
--- a/configs/iNet_86VS_defconfig
+++ b/configs/iNet_86VS_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun5i-a13-inet-86vs"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=408
-CONFIG_USB0_VBUS_PIN="PG12"
 CONFIG_USB0_VBUS_DET="PG1"
 CONFIG_AXP_GPIO=y
 # CONFIG_VIDEO_HDMI is not set
diff --git a/configs/iNet_D978_rev2_defconfig b/configs/iNet_D978_rev2_defconfig
index 70be98030a0..2eb3e65a2e7 100644
--- a/configs/iNet_D978_rev2_defconfig
+++ b/configs/iNet_D978_rev2_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_A33=y
 CONFIG_DRAM_CLK=456
 CONFIG_DRAM_ZQ=15291
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PH8"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:1024,y:768,depth:18,pclk_khz:65000,le:120,ri:180,up:22,lo:13,hs:20,vs:3,sync:3,vmode:0"
diff --git a/configs/icnova-a20-swac_defconfig b/configs/icnova-a20-swac_defconfig
index 30c28f70857..f91db056065 100644
--- a/configs/icnova-a20-swac_defconfig
+++ b/configs/icnova-a20-swac_defconfig
@@ -9,9 +9,7 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=384
 CONFIG_OLD_SUNXI_KERNEL_COMPAT=y
-CONFIG_USB0_VBUS_PIN="PG11"
 CONFIG_USB0_VBUS_DET="PH7"
-CONFIG_USB1_VBUS_PIN="PG10"
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:24,pclk_khz:33000,le:45,ri:209,up:22,lo:22,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_POWER="PH22"
 CONFIG_VIDEO_LCD_PANEL_LVDS=y
diff --git a/configs/inet1_defconfig b/configs/inet1_defconfig
index 68a6df50e42..c15d02842ee 100644
--- a/configs/inet1_defconfig
+++ b/configs/inet1_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_EMR1=4
-CONFIG_USB0_VBUS_PIN="PB9"
 CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_USB0_ID_DET="PH4"
 CONFIG_VIDEO_LCD_MODE="x:1024,y:600,depth:24,pclk_khz:52000,le:32,ri:287,up:22,lo:12,hs:1,vs:1,sync:3,vmode:0"
diff --git a/configs/inet86dz_defconfig b/configs/inet86dz_defconfig
index 3405bc423a3..a0097bcc559 100644
--- a/configs/inet86dz_defconfig
+++ b/configs/inet86dz_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_A23=y
 CONFIG_DRAM_CLK=552
 CONFIG_DRAM_ZQ=63351
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PH8"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:1024,y:600,depth:18,pclk_khz:51000,le:138,ri:162,up:22,lo:10,hs:20,vs:3,sync:3,vmode:0"
diff --git a/configs/inet97fv2_defconfig b/configs/inet97fv2_defconfig
index a5414e2c502..01ee0347112 100644
--- a/configs/inet97fv2_defconfig
+++ b/configs/inet97fv2_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=408
 CONFIG_DRAM_EMR1=4
-CONFIG_USB0_VBUS_PIN="PB9"
 CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_USB0_ID_DET="PH4"
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:24,pclk_khz:33000,le:45,ri:209,up:22,lo:22,hs:1,vs:1,sync:3,vmode:0"
diff --git a/configs/inet98v_rev2_defconfig b/configs/inet98v_rev2_defconfig
index 48b20c0eefa..43697631606 100644
--- a/configs/inet98v_rev2_defconfig
+++ b/configs/inet98v_rev2_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a13-inet-98v-rev2"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
-CONFIG_USB0_VBUS_PIN="PG12"
 CONFIG_USB0_VBUS_DET="PG1"
 CONFIG_USB0_ID_DET="PG2"
 CONFIG_AXP_GPIO=y
diff --git a/configs/inet9f_rev03_defconfig b/configs/inet9f_rev03_defconfig
index 5b0cda10f3b..584f5eefb6f 100644
--- a/configs/inet9f_rev03_defconfig
+++ b/configs/inet9f_rev03_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=408
 CONFIG_DRAM_EMR1=4
-CONFIG_USB0_VBUS_PIN="PB9"
 CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_USB0_ID_DET="PH4"
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:24,pclk_khz:33000,le:45,ri:209,up:22,lo:22,hs:1,vs:1,sync:3,vmode:0"
diff --git a/configs/inet_q972_defconfig b/configs/inet_q972_defconfig
index a70a83ebcd0..f78f7ca6b60 100644
--- a/configs/inet_q972_defconfig
+++ b/configs/inet_q972_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_CLK=384
 CONFIG_DRAM_ZQ=251
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PA15"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:1024,y:768,depth:18,pclk_khz:65000,le:280,ri:20,up:22,lo:8,hs:20,vs:8,sync:3,vmode:0"
diff --git a/configs/jesurun_q5_defconfig b/configs/jesurun_q5_defconfig
index b41c2cf3c05..f8c38aa21f2 100644
--- a/configs/jesurun_q5_defconfig
+++ b/configs/jesurun_q5_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-jesurun-q5"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=312
-CONFIG_USB0_VBUS_PIN="PB9"
 CONFIG_VIDEO_COMPOSITE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/mixtile_loftq_defconfig b/configs/mixtile_loftq_defconfig
index 2f92228eb7b..11e7a3d30b7 100644
--- a/configs/mixtile_loftq_defconfig
+++ b/configs/mixtile_loftq_defconfig
@@ -5,8 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_ZQ=251
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB1_VBUS_PIN="PH24"
-CONFIG_USB2_VBUS_PIN=""
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/mk802_a10s_defconfig b/configs/mk802_a10s_defconfig
index d3d7402f828..f1812d68849 100644
--- a/configs/mk802_a10s_defconfig
+++ b/configs/mk802_a10s_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_EMR1=0
-CONFIG_USB1_VBUS_PIN="PB10"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
diff --git a/configs/mk802_defconfig b/configs/mk802_defconfig
index 8ebd5e9cbc3..edf64f8308e 100644
--- a/configs/mk802_defconfig
+++ b/configs/mk802_defconfig
@@ -3,7 +3,6 @@ CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-mk802"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
-CONFIG_USB2_VBUS_PIN="PH12"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x7f
diff --git a/configs/orangepi_2_defconfig b/configs/orangepi_2_defconfig
index 7aaa5190b3a..50047d9df64 100644
--- a/configs/orangepi_2_defconfig
+++ b/configs/orangepi_2_defconfig
@@ -5,7 +5,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun8i-h3-orangepi-2"
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
 CONFIG_DRAM_CLK=672
-CONFIG_USB1_VBUS_PIN="PG13"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
diff --git a/configs/orangepi_plus_defconfig b/configs/orangepi_plus_defconfig
index adffe389e9e..008c09d23c4 100644
--- a/configs/orangepi_plus_defconfig
+++ b/configs/orangepi_plus_defconfig
@@ -5,8 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_H3=y
 CONFIG_DRAM_CLK=672
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB1_VBUS_PIN="PG13"
-CONFIG_USB3_VBUS_PIN="PG11"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
diff --git a/configs/orangepi_zero2_defconfig b/configs/orangepi_zero2_defconfig
index f2265ea5179..831bfe66e25 100644
--- a/configs/orangepi_zero2_defconfig
+++ b/configs/orangepi_zero2_defconfig
@@ -8,7 +8,6 @@ CONFIG_DRAM_SUNXI_CA_DRI=0x0e0e
 CONFIG_DRAM_SUNXI_TPR10=0xf83438
 CONFIG_MACH_SUN50I_H616=y
 CONFIG_SUNXI_DRAM_H616_DDR3_1333=y
-CONFIG_USB1_VBUS_PIN="PC16"
 CONFIG_R_I2C_ENABLE=y
 CONFIG_SPL_SPI_SUNXI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/orangepi_zero3_defconfig b/configs/orangepi_zero3_defconfig
index 63f9a735378..8594924c7e9 100644
--- a/configs/orangepi_zero3_defconfig
+++ b/configs/orangepi_zero3_defconfig
@@ -13,7 +13,6 @@ CONFIG_DRAM_SUNXI_TPR12=0x0f0f100f
 CONFIG_MACH_SUN50I_H616=y
 CONFIG_SUNXI_DRAM_H616_LPDDR4=y
 CONFIG_DRAM_CLK=792
-CONFIG_USB1_VBUS_PIN="PC16"
 CONFIG_R_I2C_ENABLE=y
 CONFIG_SPL_SPI_SUNXI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/parrot_r16_defconfig b/configs/parrot_r16_defconfig
index 72235ccc071..3b07ee364b9 100644
--- a/configs/parrot_r16_defconfig
+++ b/configs/parrot_r16_defconfig
@@ -7,7 +7,6 @@ CONFIG_DRAM_CLK=600
 CONFIG_DRAM_ZQ=15291
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_USB0_ID_DET="PD10"
-CONFIG_USB1_VBUS_PIN="PD12"
 CONFIG_AXP_GPIO=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
diff --git a/configs/pine_h64_defconfig b/configs/pine_h64_defconfig
index 20a4a0a437a..3eaa9c8b532 100644
--- a/configs/pine_h64_defconfig
+++ b/configs/pine_h64_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN50I_H6=y
 CONFIG_SUNXI_DRAM_H6_LPDDR3=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB3_VBUS_PIN="PL5"
 CONFIG_SPL_SPI_SUNXI=y
 # CONFIG_PSCI_RESET is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/polaroid_mid2407pxe03_defconfig b/configs/polaroid_mid2407pxe03_defconfig
index 2155fe6646f..783e9c83c8d 100644
--- a/configs/polaroid_mid2407pxe03_defconfig
+++ b/configs/polaroid_mid2407pxe03_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_A23=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_ZQ=63351
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PH8"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:18,pclk_khz:33000,le:87,ri:40,up:31,lo:13,hs:1,vs:1,sync:3,vmode:0"
diff --git a/configs/polaroid_mid2809pxe04_defconfig b/configs/polaroid_mid2809pxe04_defconfig
index 1faf78f1b54..0e77f855b74 100644
--- a/configs/polaroid_mid2809pxe04_defconfig
+++ b/configs/polaroid_mid2809pxe04_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_A23=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_ZQ=63351
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PH8"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:18,pclk_khz:33000,le:36,ri:210,up:18,lo:22,hs:10,vs:5,sync:3,vmode:0"
diff --git a/configs/pov_protab2_ips9_defconfig b/configs/pov_protab2_ips9_defconfig
index 330c97fd6dc..cfeb6ff2bd5 100644
--- a/configs/pov_protab2_ips9_defconfig
+++ b/configs/pov_protab2_ips9_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-pov-protab2-ips9"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=432
-CONFIG_USB0_VBUS_PIN="PB9"
 CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_USB0_ID_DET="PH4"
 CONFIG_VIDEO_LCD_MODE="x:1024,y:768,depth:18,pclk_khz:100000,le:480,ri:260,up:6,lo:16,hs:320,vs:10,sync:3,vmode:0"
diff --git a/configs/q8_a13_tablet_defconfig b/configs/q8_a13_tablet_defconfig
index 93a257853b3..8f587787603 100644
--- a/configs/q8_a13_tablet_defconfig
+++ b/configs/q8_a13_tablet_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a13-q8-tablet"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=384
-CONFIG_USB0_VBUS_PIN="PG12"
 CONFIG_USB0_VBUS_DET="PG1"
 CONFIG_USB0_ID_DET="PG2"
 CONFIG_AXP_GPIO=y
diff --git a/configs/q8_a23_tablet_800x480_defconfig b/configs/q8_a23_tablet_800x480_defconfig
index 08ba34e08ee..1106079d7b9 100644
--- a/configs/q8_a23_tablet_800x480_defconfig
+++ b/configs/q8_a23_tablet_800x480_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_A23=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_ZQ=63306
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PH8"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:18,pclk_khz:33000,le:36,ri:210,up:18,lo:22,hs:10,vs:5,sync:3,vmode:0"
diff --git a/configs/q8_a33_tablet_1024x600_defconfig b/configs/q8_a33_tablet_1024x600_defconfig
index 6efbd84f7c3..7d3e5bb6b94 100644
--- a/configs/q8_a33_tablet_1024x600_defconfig
+++ b/configs/q8_a33_tablet_1024x600_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_A33=y
 CONFIG_DRAM_CLK=456
 CONFIG_DRAM_ZQ=15291
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PH8"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:1024,y:600,depth:18,pclk_khz:51000,le:159,ri:160,up:22,lo:12,hs:1,vs:1,sync:3,vmode:0"
diff --git a/configs/q8_a33_tablet_800x480_defconfig b/configs/q8_a33_tablet_800x480_defconfig
index bf5dcd0d018..0ad945da4ef 100644
--- a/configs/q8_a33_tablet_800x480_defconfig
+++ b/configs/q8_a33_tablet_800x480_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_A33=y
 CONFIG_DRAM_CLK=456
 CONFIG_DRAM_ZQ=15291
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PH8"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:18,pclk_khz:33000,le:87,ri:167,up:31,lo:13,hs:1,vs:1,sync:3,vmode:0"
diff --git a/configs/r7-tv-dongle_defconfig b/configs/r7-tv-dongle_defconfig
index 0c9f6197c2c..e90773f8ae3 100644
--- a/configs/r7-tv-dongle_defconfig
+++ b/configs/r7-tv-dongle_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a10s-r7-tv-dongle"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=384
-CONFIG_USB1_VBUS_PIN="PG13"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
diff --git a/configs/sun8i_a23_evb_defconfig b/configs/sun8i_a23_evb_defconfig
index a3b1d76d8bb..c3d15d41013 100644
--- a/configs/sun8i_a23_evb_defconfig
+++ b/configs/sun8i_a23_evb_defconfig
@@ -5,9 +5,7 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_A23=y
 CONFIG_DRAM_CLK=552
 CONFIG_DRAM_ZQ=63351
-CONFIG_USB0_VBUS_PIN="axp_drivebus"
 CONFIG_USB0_VBUS_DET="axp_vbus_detect"
-CONFIG_USB1_VBUS_PIN="PH7"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_CONS_INDEX=5
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/tbs_a711_defconfig b/configs/tbs_a711_defconfig
index c17815382ec..4c6727cd36c 100644
--- a/configs/tbs_a711_defconfig
+++ b/configs/tbs_a711_defconfig
@@ -8,7 +8,6 @@ CONFIG_DRAM_CLK=552
 CONFIG_DRAM_ZQ=15355
 CONFIG_DRAM_ODT_EN=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_VBUS_PIN="AXP0-VBUS-ENABLE"
 CONFIG_USB0_ID_DET="PH11"
 CONFIG_AXP_GPIO=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/teres_i_defconfig b/configs/teres_i_defconfig
index b9b22e77203..6a9261eeeba 100644
--- a/configs/teres_i_defconfig
+++ b/configs/teres_i_defconfig
@@ -6,7 +6,6 @@ CONFIG_MACH_SUN50I=y
 CONFIG_DRAM_CLK=552
 CONFIG_DRAM_ZQ=3881949
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB1_VBUS_PIN="PL7"
 CONFIG_I2C0_ENABLE=y
 CONFIG_PREBOOT="setenv usb_pgood_delay 2000; usb start"
 CONFIG_SPL_SYS_I2C_LEGACY=y
-- 
2.46.3

