Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6C8C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 06:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BC5687B0D;
	Tue, 31 Oct 2023 07:41:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="G33vZJHd";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="eN6jSuT1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3612287B0E; Tue, 31 Oct 2023 07:40:59 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D2C287AE7
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 42B793200A61;
 Tue, 31 Oct 2023 02:40:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 31 Oct 2023 02:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1698734452; x=
 1698820852; bh=yXUZ+uWDg09FQhOj1CvQ1SGmsBPFHvGW0s9CuutZhes=; b=G
 33vZJHdzOXZ0DaHfiXiRoxovNc197i+xZBhi225vFwwCgnmJhMQV+9/7FrfRgZra
 HNKRT2JWJ1Dh5ObuE8l1HFz0Yp78tJP2+krlv53UGMPkckjng6a3P2CXzMwvuTsp
 AAFdXpDRCWFawzDiYMidxmOGpnMniaozoNPI6zoZ3MIzSDrK9UUJAgdUfLtLnGlo
 DEXScHDcRjJlgVdPQrjOGguKVHkjozFHsXyE5oADPn2QZAmGTkMtm6POFmlqFjc3
 EFW2NuRNf7p2O/JAghAeMCbFlvWyD05GSB3G4igE8YBKx2I0c2HRtuvsG+3WqoSz
 V1OyeN0ZOVBju+lHvEOxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698734452; x=
 1698820852; bh=yXUZ+uWDg09FQhOj1CvQ1SGmsBPFHvGW0s9CuutZhes=; b=e
 N6jSuT111OFJzb0QqC/Z5/1MQvyUoK0n+XtBAZap5gYtjnEffSTLmQFWL5/3Xtyk
 eXt6voWRf1uFoNOAnfsgyEYFKO8cRWJX8esAnFsjztI8fUzbDlmY9QRZueEST+AY
 6G1Zsc8+7feDb69x0qGMwobNJ5KO+CFgBV4t7+WDNqLUMGi+MdVKRB/O9nE2fB+r
 Bwjkj91qbXHQHZ1SC632bzANDSzKEucgNGRgN3cW53coS8Ha0zucMVOpP89aUqFf
 o/xqMRxR5eelSNFPGvw74oIxdbIduoEXLzkQl8Gga7DsX0xkcsXBrKpHgMLD/v+L
 mDFbC1qZJvF8U25xEANew==
X-ME-Sender: <xms:dKFAZTzob-6ClM2D2tqYCAC7VXb7SyYhKJHFZNRC8WODIDh8WdrLLA>
 <xme:dKFAZbTlkXfxCIakaJJ_tW4V_GtaRgZK8q0Lq7Tfn7d2yCZVd96QjvUUTXzE86tKf
 tq9YSqp4HSGfbs6mA>
X-ME-Received: <xmr:dKFAZdXdzs6Uu86i2e6O3ucGDlWfMdvzddtx0Lcvja0itOMPcuc0jUzh5x-0obg1HsrFGaCr16xGbpC4VJYDThc4d0C1AAmkuBy2s2d_70Y2ZAIxgAIrm9kqqYXalZRfBpXUew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgleeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
 udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:dKFAZdg9oWSNTEnpqJzPXTk5GlDiCranTg2LQA5p3jn97GxYr6ZJDg>
 <xmx:dKFAZVApm0XmORf-rPzbIid7HkKsUyRRRRn-afR1aAShiyVt5PTs4w>
 <xmx:dKFAZWIT1QC4Vp1k2RtX9tFOpPIT2pQ5zPdfjfofGgTwk7CpdJZyPA>
 <xmx:dKFAZZuEYfK6t8mRV_sgRoW-YsXP24qC70hIIgxjSuqN8uZaYXZIfw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 02:40:52 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Icenowy Zheng <icenowy@aosc.xyz>, Hans de Goede <hdegoede@redhat.com>,
 Chen-Yu Tsai <wens@csie.org>, Adam Sampson <ats@offog.org>,
 Stefan Roese <sr@denx.de>, Maxime Ripard <mripard@kernel.org>,
 u-boot@lists.denx.de, Samuel Holland <samuel@sholland.org>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH 4/5] sunxi: Remove obsolete USBx_VBUS_PIN Kconfig symbols
Date: Tue, 31 Oct 2023 01:39:54 -0500
Message-ID: <20231031064039.50942-5-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031064039.50942-1-samuel@sholland.org>
References: <20231031064039.50942-1-samuel@sholland.org>
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

Now that the USB PHY driver uses the device tree to get VBUS supply
regulators, these Kconfig symbols are unused. Remove them.

Signed-off-by: Samuel Holland <samuel@sholland.org>
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
 85 files changed, 142 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index a10e4c06b6a..e3184ccdb3d 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -732,13 +732,6 @@ config MMC_SUNXI_SLOT_EXTRA
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
@@ -753,28 +746,6 @@ config USB0_ID_DET
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
index 841fe0d3f09..ddc2a2e2089 100644
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
index befe6d86b25..7e58ac112f3 100644
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
index 689ea533ee9..78e7233ca97 100644
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
index 44770ffb048..079e4dd9203 100644
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
index 1087512235a..6ca73e78e51 100644
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
index 7d81f12f766..d2abb14512a 100644
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
index 4c7154b04c4..b121f8c0f01 100644
--- a/configs/Auxtek-T004_defconfig
+++ b/configs/Auxtek-T004_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun5i-a10s-auxtek-t004"
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
index cd9bdbfd36f..b013c97839f 100644
--- a/configs/CHIP_defconfig
+++ b/configs/CHIP_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun5i-r8-chip"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_TIMINGS_DDR3_800E_1066G_1333J=y
-CONFIG_USB0_VBUS_PIN="PB10"
 CONFIG_VIDEO_COMPOSITE=y
 CONFIG_CHIP_DIP_SCAN=y
 CONFIG_SPL_I2C=y
diff --git a/configs/CHIP_pro_defconfig b/configs/CHIP_pro_defconfig
index b7089bced2c..2ad1d3d54f3 100644
--- a/configs/CHIP_pro_defconfig
+++ b/configs/CHIP_pro_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun5i-gr8-chip-pro"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_TIMINGS_DDR3_800E_1066G_1333J=y
-CONFIG_USB0_VBUS_PIN="PB10"
 CONFIG_SPL_I2C=y
 # CONFIG_CMD_FLASH is not set
 CONFIG_CMD_MTDPARTS=y
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
index 02b3e69584f..c76c07e2d9d 100644
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
index 4bd3b569392..26f3ee03c26 100644
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
index 18873dba340..4745329e33f 100644
--- a/configs/Empire_electronix_m712_defconfig
+++ b/configs/Empire_electronix_m712_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun5i-a13-empire-electronix-m712"
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
index 482e0fb7a83..03e9fdca66f 100644
--- a/configs/Hyundai_A7HD_defconfig
+++ b/configs/Hyundai_A7HD_defconfig
@@ -4,10 +4,7 @@ CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-hyundai-a7hd"
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
index 49dcfa098ee..222fbc5e4ef 100644
--- a/configs/Linksprite_pcDuino_defconfig
+++ b/configs/Linksprite_pcDuino_defconfig
@@ -3,8 +3,6 @@ CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-pcduino"
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
index e8bc1485766..b6ae6f643fe 100644
--- a/configs/Mini-X_defconfig
+++ b/configs/Mini-X_defconfig
@@ -3,7 +3,6 @@ CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-mini-xplus"
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
index 88a082c0567..7c88d237324 100644
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
index 9e9bddb7649..97939200146 100644
--- a/configs/Wobo_i5_defconfig
+++ b/configs/Wobo_i5_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun5i-a10s-wobo-i5"
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
index b89dd8ea62b..cde8bf1f89d 100644
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
index f54a83d929d..347a85f18a5 100644
--- a/configs/difrnce_dit4350_defconfig
+++ b/configs/difrnce_dit4350_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun5i-a13-difrnce-dit4350"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=408
-CONFIG_USB0_VBUS_PIN="PG12"
 CONFIG_USB0_VBUS_DET="PG1"
 CONFIG_USB0_ID_DET="PG2"
 CONFIG_AXP_GPIO=y
diff --git a/configs/dserve_dsrv9703c_defconfig b/configs/dserve_dsrv9703c_defconfig
index f5ff69d7d63..6442998ba20 100644
--- a/configs/dserve_dsrv9703c_defconfig
+++ b/configs/dserve_dsrv9703c_defconfig
@@ -3,7 +3,6 @@ CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-dserve-dsrv9703c"
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
index 5cc1a1d57f4..aa6d6f81175 100644
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
index 38b20109a57..da103a6b1f3 100644
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
index 2c8ecb51de0..d5fb50fded3 100644
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
index f81120b1197..77176320132 100644
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
index d5d2dc32c93..7d14d2e1a6c 100644
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
index e4da6c14d04..e3724e71a4c 100644
--- a/configs/inet98v_rev2_defconfig
+++ b/configs/inet98v_rev2_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun5i-a13-inet-98v-rev2"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
-CONFIG_USB0_VBUS_PIN="PG12"
 CONFIG_USB0_VBUS_DET="PG1"
 CONFIG_USB0_ID_DET="PG2"
 CONFIG_AXP_GPIO=y
diff --git a/configs/inet9f_rev03_defconfig b/configs/inet9f_rev03_defconfig
index 4485f930236..5e2cb3fad21 100644
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
index c99be7cea4e..e3d8122763a 100644
--- a/configs/jesurun_q5_defconfig
+++ b/configs/jesurun_q5_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-jesurun-q5"
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
index 21f7a6e535d..9ac715339c5 100644
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
index 416565e5af2..f23993382b4 100644
--- a/configs/mk802_defconfig
+++ b/configs/mk802_defconfig
@@ -3,7 +3,6 @@ CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-mk802"
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
index 4712b8e4694..3937ad10a25 100644
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
index a62c9f8fa37..0e82c9f5b00 100644
--- a/configs/pov_protab2_ips9_defconfig
+++ b/configs/pov_protab2_ips9_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-pov-protab2-ips9"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=432
-CONFIG_USB0_VBUS_PIN="PB9"
 CONFIG_USB0_VBUS_DET="PH5"
 CONFIG_USB0_ID_DET="PH4"
 CONFIG_VIDEO_LCD_MODE="x:1024,y:768,depth:18,pclk_khz:100000,le:480,ri:260,up:6,lo:16,hs:320,vs:10,sync:3,vmode:0"
diff --git a/configs/q8_a13_tablet_defconfig b/configs/q8_a13_tablet_defconfig
index 36252e5f89a..5c3df6c2589 100644
--- a/configs/q8_a13_tablet_defconfig
+++ b/configs/q8_a13_tablet_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun5i-a13-q8-tablet"
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
index 8875a09b2c9..4a207133766 100644
--- a/configs/r7-tv-dongle_defconfig
+++ b/configs/r7-tv-dongle_defconfig
@@ -4,7 +4,6 @@ CONFIG_DEFAULT_DEVICE_TREE="sun5i-a10s-r7-tv-dongle"
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
2.41.0

