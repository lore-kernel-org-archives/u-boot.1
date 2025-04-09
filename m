Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4808BC36010
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 00:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4C9983483;
	Wed,  9 Apr 2025 02:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B37AA8352B; Wed,  9 Apr 2025 02:22:03 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BA303834B6
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 02:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDC2A1C14;
 Tue,  8 Apr 2025 17:22:00 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4827C3F6A8;
 Tue,  8 Apr 2025 17:21:56 -0700 (PDT)
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
Subject: [PATCH v2 8/8] sunxi: Kconfig: Remove obsolete USBx_* pin symbols
Date: Wed,  9 Apr 2025 01:20:36 +0100
Message-ID: <20250409002036.12212-9-andre.przywara@arm.com>
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

Now that the USB PHY driver uses the device tree to get the VBUS detect
and USB ID GPIOs, these Kconfig symbols are unused. Remove them from
their Kconfig definition, and also from all defconfig files.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/Kconfig                  | 14 --------------
 configs/A13-OLinuXino_defconfig              |  1 -
 configs/A20-OLinuXino-Lime2-eMMC_defconfig   |  1 -
 configs/A20-OLinuXino-Lime2_defconfig        |  1 -
 configs/A20-Olimex-SOM-EVB_defconfig         |  1 -
 configs/A20-Olimex-SOM204-EVB-eMMC_defconfig |  1 -
 configs/A20-Olimex-SOM204-EVB_defconfig      |  1 -
 configs/A33-OLinuXino_defconfig              |  1 -
 configs/Ampe_A76_defconfig                   |  2 --
 configs/Bananapi_m2m_defconfig               |  1 -
 configs/Chuwi_V7_CW0825_defconfig            |  2 --
 configs/Cubieboard4_defconfig                |  1 -
 configs/Cubietruck_defconfig                 |  2 --
 configs/Cubietruck_plus_defconfig            |  1 -
 configs/Empire_electronix_d709_defconfig     |  2 --
 configs/Empire_electronix_m712_defconfig     |  2 --
 configs/Hyundai_A7HD_defconfig               |  1 -
 configs/Merrii_A80_Optimus_defconfig         |  1 -
 configs/Sinlinx_SinA33_defconfig             |  1 -
 configs/Sinovoip_BPI_M3_defconfig            |  1 -
 configs/UTOO_P66_defconfig                   |  2 --
 configs/Wexler_TAB7200_defconfig             |  1 -
 configs/Yones_Toptech_BS1078_V2_defconfig    |  1 -
 configs/colorfly_e708_q1_defconfig           |  1 -
 configs/difrnce_dit4350_defconfig            |  2 --
 configs/dserve_dsrv9703c_defconfig           |  2 --
 configs/ga10h_v1_1_defconfig                 |  1 -
 configs/gt90h_v4_defconfig                   |  1 -
 configs/iNet_3F_defconfig                    |  1 -
 configs/iNet_3W_defconfig                    |  1 -
 configs/iNet_86VS_defconfig                  |  1 -
 configs/iNet_D978_rev2_defconfig             |  1 -
 configs/icnova-a20-swac_defconfig            |  1 -
 configs/inet1_defconfig                      |  2 --
 configs/inet86dz_defconfig                   |  1 -
 configs/inet97fv2_defconfig                  |  2 --
 configs/inet98v_rev2_defconfig               |  2 --
 configs/inet9f_rev03_defconfig               |  2 --
 configs/inet_q972_defconfig                  |  1 -
 configs/parrot_r16_defconfig                 |  1 -
 configs/polaroid_mid2407pxe03_defconfig      |  1 -
 configs/polaroid_mid2809pxe04_defconfig      |  1 -
 configs/pov_protab2_ips9_defconfig           |  2 --
 configs/q8_a13_tablet_defconfig              |  2 --
 configs/q8_a23_tablet_800x480_defconfig      |  1 -
 configs/q8_a33_tablet_1024x600_defconfig     |  1 -
 configs/q8_a33_tablet_800x480_defconfig      |  1 -
 configs/sun8i_a23_evb_defconfig              |  1 -
 configs/tbs_a711_defconfig                   |  1 -
 49 files changed, 76 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 8dc9aeb2e7b..fce817c9d40 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -782,20 +782,6 @@ config MMC_SUNXI_SLOT_EXTRA
 	slot or emmc on mmc1 - mmc3. Setting this to 1, 2 or 3 will enable
 	support for this.
 
-config USB0_VBUS_DET
-	string "Vbus detect pin for usb0 (otg)"
-	default ""
-	---help---
-	Set the Vbus detect pin for usb0 (otg). This takes a string in the
-	format understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of port H.
-
-config USB0_ID_DET
-	string "ID detect pin for usb0 (otg)"
-	default ""
-	---help---
-	Set the ID detect pin for usb0 (otg). This takes a string in the
-	format understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of port H.
-
 config I2C0_ENABLE
 	bool "Enable I2C/TWI controller 0"
 	default y if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I_R40
diff --git a/configs/A13-OLinuXino_defconfig b/configs/A13-OLinuXino_defconfig
index c368daf03b7..5183ece0762 100644
--- a/configs/A13-OLinuXino_defconfig
+++ b/configs/A13-OLinuXino_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=408
 CONFIG_DRAM_EMR1=0
-CONFIG_USB0_VBUS_DET="PG1"
 CONFIG_AXP_GPIO=y
 # CONFIG_VIDEO_HDMI is not set
 CONFIG_VIDEO_VGA_VIA_LCD=y
diff --git a/configs/A20-OLinuXino-Lime2-eMMC_defconfig b/configs/A20-OLinuXino-Lime2-eMMC_defconfig
index 7b1b73b5cef..73b28455038 100644
--- a/configs/A20-OLinuXino-Lime2-eMMC_defconfig
+++ b/configs/A20-OLinuXino-Lime2-eMMC_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=384
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_I2C1_ENABLE=y
 CONFIG_SPL_SPI_SUNXI=y
 CONFIG_AHCI=y
diff --git a/configs/A20-OLinuXino-Lime2_defconfig b/configs/A20-OLinuXino-Lime2_defconfig
index 2b91f3ea02f..f885fc01e6e 100644
--- a/configs/A20-OLinuXino-Lime2_defconfig
+++ b/configs/A20-OLinuXino-Lime2_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-olinuxino-lime2"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=384
-CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_I2C1_ENABLE=y
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/A20-Olimex-SOM-EVB_defconfig b/configs/A20-Olimex-SOM-EVB_defconfig
index b9df35d1b98..34c1f5fd5ab 100644
--- a/configs/A20-Olimex-SOM-EVB_defconfig
+++ b/configs/A20-Olimex-SOM-EVB_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=384
 CONFIG_MMC_SUNXI_SLOT_EXTRA=3
-CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/A20-Olimex-SOM204-EVB-eMMC_defconfig b/configs/A20-Olimex-SOM204-EVB-eMMC_defconfig
index b1012c08631..5f44d3de4ea 100644
--- a/configs/A20-Olimex-SOM204-EVB-eMMC_defconfig
+++ b/configs/A20-Olimex-SOM204-EVB-eMMC_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=384
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_I2C1_ENABLE=y
 CONFIG_GMAC_TX_DELAY=4
 CONFIG_AHCI=y
diff --git a/configs/A20-Olimex-SOM204-EVB_defconfig b/configs/A20-Olimex-SOM204-EVB_defconfig
index 2fc143680e2..271d911bb8c 100644
--- a/configs/A20-Olimex-SOM204-EVB_defconfig
+++ b/configs/A20-Olimex-SOM204-EVB_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-olimex-som204-evb"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=384
-CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_I2C1_ENABLE=y
 CONFIG_GMAC_TX_DELAY=4
 CONFIG_AHCI=y
diff --git a/configs/A33-OLinuXino_defconfig b/configs/A33-OLinuXino_defconfig
index 854918f4274..e90cdda639e 100644
--- a/configs/A33-OLinuXino_defconfig
+++ b/configs/A33-OLinuXino_defconfig
@@ -6,7 +6,6 @@ CONFIG_MACH_SUN8I_A33=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_ZQ=15291
 CONFIG_DRAM_ODT_EN=y
-CONFIG_USB0_ID_DET="PB3"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:18,pclk_khz:33000,le:16,ri:209,up:22,lo:22,hs:30,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_DCLK_PHASE=0
diff --git a/configs/Ampe_A76_defconfig b/configs/Ampe_A76_defconfig
index ca3e7d5efee..32775a314ca 100644
--- a/configs/Ampe_A76_defconfig
+++ b/configs/Ampe_A76_defconfig
@@ -4,8 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun5i-a13-ampe-a76"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
-CONFIG_USB0_VBUS_DET="PG1"
-CONFIG_USB0_ID_DET="PG2"
 CONFIG_AXP_GPIO=y
 # CONFIG_VIDEO_HDMI is not set
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:18,pclk_khz:33000,le:45,ri:82,up:22,lo:22,hs:1,vs:1,sync:3,vmode:0"
diff --git a/configs/Bananapi_m2m_defconfig b/configs/Bananapi_m2m_defconfig
index d26aa0bb1b4..1e793f1cfc6 100644
--- a/configs/Bananapi_m2m_defconfig
+++ b/configs/Bananapi_m2m_defconfig
@@ -7,7 +7,6 @@ CONFIG_DRAM_CLK=600
 CONFIG_DRAM_ZQ=15291
 CONFIG_DRAM_ODT_EN=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_ID_DET="PH8"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/Chuwi_V7_CW0825_defconfig b/configs/Chuwi_V7_CW0825_defconfig
index ce770153062..4713fbea341 100644
--- a/configs/Chuwi_V7_CW0825_defconfig
+++ b/configs/Chuwi_V7_CW0825_defconfig
@@ -5,8 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=408
 CONFIG_DRAM_EMR1=4
-CONFIG_USB0_VBUS_DET="PH5"
-CONFIG_USB0_ID_DET="PH4"
 CONFIG_VIDEO_LCD_MODE="x:1024,y:768,depth:24,pclk_khz:51000,le:19,ri:300,up:6,lo:31,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_POWER="PH8"
 CONFIG_VIDEO_LCD_BL_EN="PH7"
diff --git a/configs/Cubieboard4_defconfig b/configs/Cubieboard4_defconfig
index a6bc72daf52..5b8428f2714 100644
--- a/configs/Cubieboard4_defconfig
+++ b/configs/Cubieboard4_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN9I=y
 CONFIG_DRAM_CLK=672
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_ID_DET="PH16"
 CONFIG_AXP_GPIO=y
 CONFIG_SYS_I2C_SUN8I_RSB=y
 CONFIG_REGULATOR_AXP_DRIVEVBUS=y
diff --git a/configs/Cubietruck_defconfig b/configs/Cubietruck_defconfig
index f4829d38dbe..5f117f30986 100644
--- a/configs/Cubietruck_defconfig
+++ b/configs/Cubietruck_defconfig
@@ -4,8 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-cubietruck"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=432
-CONFIG_USB0_VBUS_DET="PH22"
-CONFIG_USB0_ID_DET="PH19"
 CONFIG_VIDEO_VGA=y
 CONFIG_GMAC_TX_DELAY=1
 CONFIG_AHCI=y
diff --git a/configs/Cubietruck_plus_defconfig b/configs/Cubietruck_plus_defconfig
index e24cf553e1c..e02e70f1473 100644
--- a/configs/Cubietruck_plus_defconfig
+++ b/configs/Cubietruck_plus_defconfig
@@ -7,7 +7,6 @@ CONFIG_DRAM_CLK=672
 CONFIG_DRAM_ZQ=15355
 CONFIG_DRAM_ODT_EN=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_ID_DET="PH11"
 CONFIG_I2C0_ENABLE=y
 CONFIG_AXP_GPIO=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/Empire_electronix_d709_defconfig b/configs/Empire_electronix_d709_defconfig
index 28b70ab0294..5130f278816 100644
--- a/configs/Empire_electronix_d709_defconfig
+++ b/configs/Empire_electronix_d709_defconfig
@@ -5,8 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_EMR1=0
-CONFIG_USB0_VBUS_DET="PG1"
-CONFIG_USB0_ID_DET="PG2"
 CONFIG_AXP_GPIO=y
 # CONFIG_VIDEO_HDMI is not set
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:18,pclk_khz:33000,le:45,ri:210,up:22,lo:22,hs:1,vs:1,sync:3,vmode:0"
diff --git a/configs/Empire_electronix_m712_defconfig b/configs/Empire_electronix_m712_defconfig
index 58b9300b241..7d33a531ffb 100644
--- a/configs/Empire_electronix_m712_defconfig
+++ b/configs/Empire_electronix_m712_defconfig
@@ -4,8 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a13-empire-electronix-m712"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=408
-CONFIG_USB0_VBUS_DET="PG1"
-CONFIG_USB0_ID_DET="PG2"
 CONFIG_AXP_GPIO=y
 # CONFIG_VIDEO_HDMI is not set
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:18,pclk_khz:33000,le:45,ri:82,up:22,lo:22,hs:1,vs:1,sync:3,vmode:0"
diff --git a/configs/Hyundai_A7HD_defconfig b/configs/Hyundai_A7HD_defconfig
index a689aee7145..6789e6b2b7e 100644
--- a/configs/Hyundai_A7HD_defconfig
+++ b/configs/Hyundai_A7HD_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-hyundai-a7hd"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_EMR1=4
-CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_VIDEO_LCD_MODE="x:1024,y:600,depth:18,pclk_khz:51000,le:45,ri:274,up:22,lo:12,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_POWER="PH2"
 CONFIG_VIDEO_LCD_BL_EN="PH9"
diff --git a/configs/Merrii_A80_Optimus_defconfig b/configs/Merrii_A80_Optimus_defconfig
index 373dbf4bfb1..c47dc59399d 100644
--- a/configs/Merrii_A80_Optimus_defconfig
+++ b/configs/Merrii_A80_Optimus_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN9I=y
 CONFIG_DRAM_CLK=672
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_ID_DET="PH3"
 CONFIG_AXP_GPIO=y
 CONFIG_SYS_I2C_SUN8I_RSB=y
 CONFIG_REGULATOR_AXP_DRIVEVBUS=y
diff --git a/configs/Sinlinx_SinA33_defconfig b/configs/Sinlinx_SinA33_defconfig
index cfb432944df..a230599adf6 100644
--- a/configs/Sinlinx_SinA33_defconfig
+++ b/configs/Sinlinx_SinA33_defconfig
@@ -6,7 +6,6 @@ CONFIG_MACH_SUN8I_A33=y
 CONFIG_DRAM_CLK=552
 CONFIG_DRAM_ZQ=15291
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_ID_DET="PH8"
 CONFIG_VIDEO_LCD_MODE="x:1024,y:600,depth:18,pclk_khz:66000,le:90,ri:160,up:3,lo:127,hs:70,vs:20,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_DCLK_PHASE=0
 CONFIG_VIDEO_LCD_BL_EN="PH6"
diff --git a/configs/Sinovoip_BPI_M3_defconfig b/configs/Sinovoip_BPI_M3_defconfig
index d03e1ebb23e..98c533bbb86 100644
--- a/configs/Sinovoip_BPI_M3_defconfig
+++ b/configs/Sinovoip_BPI_M3_defconfig
@@ -8,7 +8,6 @@ CONFIG_DRAM_CLK=480
 CONFIG_DRAM_ZQ=15355
 CONFIG_DRAM_ODT_EN=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_ID_DET="PH11"
 CONFIG_AXP_GPIO=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_CONSOLE_MUX=y
diff --git a/configs/UTOO_P66_defconfig b/configs/UTOO_P66_defconfig
index a2ccdf584c8..fb2b20bea7b 100644
--- a/configs/UTOO_P66_defconfig
+++ b/configs/UTOO_P66_defconfig
@@ -6,8 +6,6 @@ CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_EMR1=0
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_VBUS_DET="PG01"
-CONFIG_USB0_ID_DET="PG2"
 CONFIG_AXP_GPIO=y
 # CONFIG_VIDEO_HDMI is not set
 CONFIG_VIDEO_LCD_MODE="x:480,y:800,depth:18,pclk_khz:25000,le:2,ri:93,up:2,lo:93,hs:1,vs:1,sync:3,vmode:0"
diff --git a/configs/Wexler_TAB7200_defconfig b/configs/Wexler_TAB7200_defconfig
index bdbd48e2c08..649e95bfc75 100644
--- a/configs/Wexler_TAB7200_defconfig
+++ b/configs/Wexler_TAB7200_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-wexler-tab7200"
 CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=384
-CONFIG_USB0_ID_DET="PH4"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:24,pclk_khz:33000,le:45,ri:210,up:22,lo:22,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_POWER="PH8"
diff --git a/configs/Yones_Toptech_BS1078_V2_defconfig b/configs/Yones_Toptech_BS1078_V2_defconfig
index e5196b78cf6..ae31b7f7499 100644
--- a/configs/Yones_Toptech_BS1078_V2_defconfig
+++ b/configs/Yones_Toptech_BS1078_V2_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_CLK=420
 CONFIG_DRAM_ZQ=251
-CONFIG_USB0_ID_DET="PA15"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:1024,y:600,depth:24,pclk_khz:70000,le:120,ri:180,up:17,lo:15,hs:20,vs:3,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_DCLK_PHASE=0
diff --git a/configs/colorfly_e708_q1_defconfig b/configs/colorfly_e708_q1_defconfig
index 2d95f23bf3f..bdabca2ab35 100644
--- a/configs/colorfly_e708_q1_defconfig
+++ b/configs/colorfly_e708_q1_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_ZQ=251
-CONFIG_USB0_ID_DET="PA15"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:800,y:1280,depth:24,pclk_khz:64000,le:20,ri:34,up:1,lo:16,hs:10,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_DCLK_PHASE=0
diff --git a/configs/difrnce_dit4350_defconfig b/configs/difrnce_dit4350_defconfig
index 6df8d4972bb..3b590913686 100644
--- a/configs/difrnce_dit4350_defconfig
+++ b/configs/difrnce_dit4350_defconfig
@@ -4,8 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a13-difrnce-dit4350"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=408
-CONFIG_USB0_VBUS_DET="PG1"
-CONFIG_USB0_ID_DET="PG2"
 CONFIG_AXP_GPIO=y
 # CONFIG_VIDEO_HDMI is not set
 CONFIG_VIDEO_LCD_MODE="x:480,y:272,depth:18,pclk_khz:12000,le:1,ri:43,up:1,lo:12,hs:1,vs:1,sync:3,vmode:0"
diff --git a/configs/dserve_dsrv9703c_defconfig b/configs/dserve_dsrv9703c_defconfig
index 91b9018a968..9060db4918b 100644
--- a/configs/dserve_dsrv9703c_defconfig
+++ b/configs/dserve_dsrv9703c_defconfig
@@ -3,8 +3,6 @@ CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-dserve-dsrv9703c"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
-CONFIG_USB0_VBUS_DET="PH5"
-CONFIG_USB0_ID_DET="PH4"
 CONFIG_VIDEO_LCD_MODE="x:1024,y:768,depth:18,pclk_khz:80000,le:479,ri:544,up:5,lo:26,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_DCLK_PHASE=0
 CONFIG_VIDEO_LCD_POWER="PH8"
diff --git a/configs/ga10h_v1_1_defconfig b/configs/ga10h_v1_1_defconfig
index 44aeb859aa8..a3fc34f3241 100644
--- a/configs/ga10h_v1_1_defconfig
+++ b/configs/ga10h_v1_1_defconfig
@@ -6,7 +6,6 @@ CONFIG_MACH_SUN8I_A33=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_ZQ=15291
 CONFIG_DRAM_ODT_EN=y
-CONFIG_USB0_ID_DET="PH8"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:1024,y:600,depth:18,pclk_khz:52000,le:138,ri:162,up:22,lo:10,hs:20,vs:3,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_DCLK_PHASE=0
diff --git a/configs/gt90h_v4_defconfig b/configs/gt90h_v4_defconfig
index 527851d8e8e..ba22a3ed94f 100644
--- a/configs/gt90h_v4_defconfig
+++ b/configs/gt90h_v4_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_A23=y
 CONFIG_DRAM_CLK=480
 CONFIG_DRAM_ZQ=32767
-CONFIG_USB0_ID_DET="PH8"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:1024,y:600,depth:18,pclk_khz:55000,le:159,ri:160,up:22,lo:12,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_DCLK_PHASE=0
diff --git a/configs/iNet_3F_defconfig b/configs/iNet_3F_defconfig
index 2d21b5bb856..6893b4a8f6f 100644
--- a/configs/iNet_3F_defconfig
+++ b/configs/iNet_3F_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_EMR1=4
-CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_VIDEO_LCD_MODE="x:1024,y:768,depth:18,pclk_khz:100000,le:799,ri:260,up:15,lo:16,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_POWER="PH8"
 CONFIG_VIDEO_LCD_BL_EN="PH7"
diff --git a/configs/iNet_3W_defconfig b/configs/iNet_3W_defconfig
index 76031c0df40..6cb55b635e2 100644
--- a/configs/iNet_3W_defconfig
+++ b/configs/iNet_3W_defconfig
@@ -6,7 +6,6 @@ CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=408
 CONFIG_DRAM_ZQ=127
 CONFIG_DRAM_EMR1=4
-CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_VIDEO_LCD_MODE="x:1024,y:768,depth:24,pclk_khz:65000,le:159,ri:160,up:22,lo:15,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_POWER="PH8"
 CONFIG_VIDEO_LCD_BL_EN="PH7"
diff --git a/configs/iNet_86VS_defconfig b/configs/iNet_86VS_defconfig
index 8db79778bd6..2acf11ddea7 100644
--- a/configs/iNet_86VS_defconfig
+++ b/configs/iNet_86VS_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun5i-a13-inet-86vs"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=408
-CONFIG_USB0_VBUS_DET="PG1"
 CONFIG_AXP_GPIO=y
 # CONFIG_VIDEO_HDMI is not set
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:18,pclk_khz:33000,le:45,ri:209,up:22,lo:22,hs:1,vs:1,sync:3,vmode:0"
diff --git a/configs/iNet_D978_rev2_defconfig b/configs/iNet_D978_rev2_defconfig
index 2eb3e65a2e7..00ed5d49029 100644
--- a/configs/iNet_D978_rev2_defconfig
+++ b/configs/iNet_D978_rev2_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_A33=y
 CONFIG_DRAM_CLK=456
 CONFIG_DRAM_ZQ=15291
-CONFIG_USB0_ID_DET="PH8"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:1024,y:768,depth:18,pclk_khz:65000,le:120,ri:180,up:22,lo:13,hs:20,vs:3,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_DCLK_PHASE=0
diff --git a/configs/icnova-a20-swac_defconfig b/configs/icnova-a20-swac_defconfig
index f91db056065..3812eed927d 100644
--- a/configs/icnova-a20-swac_defconfig
+++ b/configs/icnova-a20-swac_defconfig
@@ -9,7 +9,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=384
 CONFIG_OLD_SUNXI_KERNEL_COMPAT=y
-CONFIG_USB0_VBUS_DET="PH7"
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:24,pclk_khz:33000,le:45,ri:209,up:22,lo:22,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_POWER="PH22"
 CONFIG_VIDEO_LCD_PANEL_LVDS=y
diff --git a/configs/inet1_defconfig b/configs/inet1_defconfig
index c15d02842ee..0a50992c5f2 100644
--- a/configs/inet1_defconfig
+++ b/configs/inet1_defconfig
@@ -5,8 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_EMR1=4
-CONFIG_USB0_VBUS_DET="PH5"
-CONFIG_USB0_ID_DET="PH4"
 CONFIG_VIDEO_LCD_MODE="x:1024,y:600,depth:24,pclk_khz:52000,le:32,ri:287,up:22,lo:12,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_POWER="PH8"
 CONFIG_VIDEO_LCD_BL_EN="PH7"
diff --git a/configs/inet86dz_defconfig b/configs/inet86dz_defconfig
index a0097bcc559..da0fb74c88d 100644
--- a/configs/inet86dz_defconfig
+++ b/configs/inet86dz_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_A23=y
 CONFIG_DRAM_CLK=552
 CONFIG_DRAM_ZQ=63351
-CONFIG_USB0_ID_DET="PH8"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:1024,y:600,depth:18,pclk_khz:51000,le:138,ri:162,up:22,lo:10,hs:20,vs:3,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_DCLK_PHASE=0
diff --git a/configs/inet97fv2_defconfig b/configs/inet97fv2_defconfig
index 01ee0347112..826141ac6c3 100644
--- a/configs/inet97fv2_defconfig
+++ b/configs/inet97fv2_defconfig
@@ -5,8 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=408
 CONFIG_DRAM_EMR1=4
-CONFIG_USB0_VBUS_DET="PH5"
-CONFIG_USB0_ID_DET="PH4"
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:24,pclk_khz:33000,le:45,ri:209,up:22,lo:22,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_POWER="PH8"
 CONFIG_VIDEO_LCD_BL_EN="PH7"
diff --git a/configs/inet98v_rev2_defconfig b/configs/inet98v_rev2_defconfig
index 43697631606..7da29635a32 100644
--- a/configs/inet98v_rev2_defconfig
+++ b/configs/inet98v_rev2_defconfig
@@ -4,8 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a13-inet-98v-rev2"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
-CONFIG_USB0_VBUS_DET="PG1"
-CONFIG_USB0_ID_DET="PG2"
 CONFIG_AXP_GPIO=y
 # CONFIG_VIDEO_HDMI is not set
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:18,pclk_khz:33000,le:45,ri:209,up:22,lo:22,hs:1,vs:1,sync:3,vmode:0"
diff --git a/configs/inet9f_rev03_defconfig b/configs/inet9f_rev03_defconfig
index 584f5eefb6f..ffc35487279 100644
--- a/configs/inet9f_rev03_defconfig
+++ b/configs/inet9f_rev03_defconfig
@@ -5,8 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=408
 CONFIG_DRAM_EMR1=4
-CONFIG_USB0_VBUS_DET="PH5"
-CONFIG_USB0_ID_DET="PH4"
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:24,pclk_khz:33000,le:45,ri:209,up:22,lo:22,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_POWER="PH8"
 CONFIG_VIDEO_LCD_BL_EN="PH7"
diff --git a/configs/inet_q972_defconfig b/configs/inet_q972_defconfig
index f78f7ca6b60..5a48bd0c695 100644
--- a/configs/inet_q972_defconfig
+++ b/configs/inet_q972_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN6I=y
 CONFIG_DRAM_CLK=384
 CONFIG_DRAM_ZQ=251
-CONFIG_USB0_ID_DET="PA15"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:1024,y:768,depth:18,pclk_khz:65000,le:280,ri:20,up:22,lo:8,hs:20,vs:8,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_DCLK_PHASE=0
diff --git a/configs/parrot_r16_defconfig b/configs/parrot_r16_defconfig
index 3b07ee364b9..631cfd8ffa5 100644
--- a/configs/parrot_r16_defconfig
+++ b/configs/parrot_r16_defconfig
@@ -6,7 +6,6 @@ CONFIG_MACH_SUN8I_A33=y
 CONFIG_DRAM_CLK=600
 CONFIG_DRAM_ZQ=15291
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_ID_DET="PD10"
 CONFIG_AXP_GPIO=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
diff --git a/configs/polaroid_mid2407pxe03_defconfig b/configs/polaroid_mid2407pxe03_defconfig
index 783e9c83c8d..6c0d4f1ac8c 100644
--- a/configs/polaroid_mid2407pxe03_defconfig
+++ b/configs/polaroid_mid2407pxe03_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_A23=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_ZQ=63351
-CONFIG_USB0_ID_DET="PH8"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:18,pclk_khz:33000,le:87,ri:40,up:31,lo:13,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_DCLK_PHASE=0
diff --git a/configs/polaroid_mid2809pxe04_defconfig b/configs/polaroid_mid2809pxe04_defconfig
index 0e77f855b74..7b64c8b05e7 100644
--- a/configs/polaroid_mid2809pxe04_defconfig
+++ b/configs/polaroid_mid2809pxe04_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_A23=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_ZQ=63351
-CONFIG_USB0_ID_DET="PH8"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:18,pclk_khz:33000,le:36,ri:210,up:18,lo:22,hs:10,vs:5,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_DCLK_PHASE=0
diff --git a/configs/pov_protab2_ips9_defconfig b/configs/pov_protab2_ips9_defconfig
index cfeb6ff2bd5..21da05fc40a 100644
--- a/configs/pov_protab2_ips9_defconfig
+++ b/configs/pov_protab2_ips9_defconfig
@@ -4,8 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-pov-protab2-ips9"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=432
-CONFIG_USB0_VBUS_DET="PH5"
-CONFIG_USB0_ID_DET="PH4"
 CONFIG_VIDEO_LCD_MODE="x:1024,y:768,depth:18,pclk_khz:100000,le:480,ri:260,up:6,lo:16,hs:320,vs:10,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_DCLK_PHASE=0
 CONFIG_VIDEO_LCD_POWER="PH8"
diff --git a/configs/q8_a13_tablet_defconfig b/configs/q8_a13_tablet_defconfig
index 8f587787603..2c7bc20d4d7 100644
--- a/configs/q8_a13_tablet_defconfig
+++ b/configs/q8_a13_tablet_defconfig
@@ -4,8 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a13-q8-tablet"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=384
-CONFIG_USB0_VBUS_DET="PG1"
-CONFIG_USB0_ID_DET="PG2"
 CONFIG_AXP_GPIO=y
 # CONFIG_VIDEO_HDMI is not set
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:18,pclk_khz:33000,le:87,ri:40,up:31,lo:13,hs:1,vs:1,sync:3,vmode:0"
diff --git a/configs/q8_a23_tablet_800x480_defconfig b/configs/q8_a23_tablet_800x480_defconfig
index 1106079d7b9..fcf13f64ec0 100644
--- a/configs/q8_a23_tablet_800x480_defconfig
+++ b/configs/q8_a23_tablet_800x480_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_A23=y
 CONFIG_DRAM_CLK=432
 CONFIG_DRAM_ZQ=63306
-CONFIG_USB0_ID_DET="PH8"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:18,pclk_khz:33000,le:36,ri:210,up:18,lo:22,hs:10,vs:5,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_DCLK_PHASE=0
diff --git a/configs/q8_a33_tablet_1024x600_defconfig b/configs/q8_a33_tablet_1024x600_defconfig
index 7d3e5bb6b94..22e27abc515 100644
--- a/configs/q8_a33_tablet_1024x600_defconfig
+++ b/configs/q8_a33_tablet_1024x600_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_A33=y
 CONFIG_DRAM_CLK=456
 CONFIG_DRAM_ZQ=15291
-CONFIG_USB0_ID_DET="PH8"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:1024,y:600,depth:18,pclk_khz:51000,le:159,ri:160,up:22,lo:12,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_DCLK_PHASE=0
diff --git a/configs/q8_a33_tablet_800x480_defconfig b/configs/q8_a33_tablet_800x480_defconfig
index 0ad945da4ef..1d9d6fc7302 100644
--- a/configs/q8_a33_tablet_800x480_defconfig
+++ b/configs/q8_a33_tablet_800x480_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_A33=y
 CONFIG_DRAM_CLK=456
 CONFIG_DRAM_ZQ=15291
-CONFIG_USB0_ID_DET="PH8"
 CONFIG_AXP_GPIO=y
 CONFIG_VIDEO_LCD_MODE="x:800,y:480,depth:18,pclk_khz:33000,le:87,ri:167,up:31,lo:13,hs:1,vs:1,sync:3,vmode:0"
 CONFIG_VIDEO_LCD_DCLK_PHASE=0
diff --git a/configs/sun8i_a23_evb_defconfig b/configs/sun8i_a23_evb_defconfig
index c3d15d41013..3bafc4deeaa 100644
--- a/configs/sun8i_a23_evb_defconfig
+++ b/configs/sun8i_a23_evb_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_A23=y
 CONFIG_DRAM_CLK=552
 CONFIG_DRAM_ZQ=63351
-CONFIG_USB0_VBUS_DET="axp_vbus_detect"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_CONS_INDEX=5
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/tbs_a711_defconfig b/configs/tbs_a711_defconfig
index 4c6727cd36c..e56bbabfc95 100644
--- a/configs/tbs_a711_defconfig
+++ b/configs/tbs_a711_defconfig
@@ -8,7 +8,6 @@ CONFIG_DRAM_CLK=552
 CONFIG_DRAM_ZQ=15355
 CONFIG_DRAM_ODT_EN=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
-CONFIG_USB0_ID_DET="PH11"
 CONFIG_AXP_GPIO=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
-- 
2.46.3

