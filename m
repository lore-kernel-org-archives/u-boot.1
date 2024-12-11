Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136BEE7717F
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 03:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36F84801FD;
	Wed, 11 Dec 2024 04:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="qfXElyVH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D611E801FE; Wed, 11 Dec 2024 04:18:13 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BD23801F5
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 04:18:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1733887088; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eaniR9nEYJO9Ci4oLFyBGC+CsCpm+sOQBlYzaN+KbIHi+qMDTDtXnQlDMhWpWgeTRR3joeIm2VLftsnj+qPdAe/3QlRiWxZp8hwuM88WlvKKj5/DZw/8kCCD6588Ym2AnQYOKzZGZMbR0MuTsXRPDrEvWJA3DgjJCpX2pubm0qg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1733887088;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=TePoxus+/Kpu2D473MjP7vM/VESflTSFA+hIII/geNI=; 
 b=k1lTguwR9L1Q7bgTlCGwlWNEnuRf7LLO7UR9GKLC4DzpwdU2+YSbeQGfBED2tbedh5etraHguX93+eE33CYhbZMZqImdzNrafKZGmdexx3s+rJCvPknhR7MEDDnTaqjn1m3C0qNysQF81chvs/tCvoBg6Iy92AsCmN9Po74jkMw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733887087; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=TePoxus+/Kpu2D473MjP7vM/VESflTSFA+hIII/geNI=;
 b=qfXElyVHYewsavFeOzql1EhLrmVPgHv5UgnxI156y21ceeYzmHo3O5GieV5tK5jD
 aOhcENpIMIrMwUZfri3Ij23+lXM/57B5Mcn5ko9xIKSv8aI2ResSHN20gNAjTKvJeD1
 GAc2oLoDPrUgESknZxTj30N3uJPr8if3v//Mwg03jozbWWAFIujWjbB13t1HpYPKyUq
 e4snzZCmSnEAtc9z3KYOTOT5HeQxwIBWuvqmr99TW4Uw0//NF7hbRn1rIs38fQ3n5PA
 TsAZI5BcKLi1oYIYZIAN/LzkxIZGQ0uolhN4GcWa5lizad8du3K5MgYy6Td3/bX/GW2
 6YBlWlg+9Q==
Received: by mx.zohomail.com with SMTPS id 1733887085723855.2639203126568;
 Tue, 10 Dec 2024 19:18:05 -0800 (PST)
From: Icenowy Zheng <uwu@icenowy.me>
To: Hans de Goede <hdegoede@redhat.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev, Icenowy Zheng <uwu@icenowy.me>
Subject: [U-BOOT PATCH] sunxi: add support for Rervision A33-Vstar board
Date: Wed, 11 Dec 2024 11:17:52 +0800
Message-ID: <20241211031752.355509-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

Rervision A33-Vstar is an evaluation board for their A33-Core1 A33-based
SoM.

Add support for it.

Fastboot support is enabled for flashing the eMMC included within the
SoM, and R8152 Ethernet is enabled for the evaluation board's onboard
USB-to-Ethernet.

The device tree files are from Linux v6.13-rc1, with PMIC interrupt
patched to match the r_intc node in U-Boot.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 arch/arm/dts/Makefile                   |   1 +
 arch/arm/dts/sun8i-a33-vstar-core1.dtsi |  96 +++++++++++
 arch/arm/dts/sun8i-a33-vstar.dts        | 205 ++++++++++++++++++++++++
 board/sunxi/MAINTAINERS                 |   5 +
 configs/A33-Vstar_defconfig             |  23 +++
 5 files changed, 330 insertions(+)
 create mode 100644 arch/arm/dts/sun8i-a33-vstar-core1.dtsi
 create mode 100644 arch/arm/dts/sun8i-a33-vstar.dts
 create mode 100644 configs/A33-Vstar_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 6ad59aeed5f..55dde416d71 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -654,6 +654,7 @@ dtb-$(CONFIG_MACH_SUN8I_A33) += \
 	sun8i-a33-olinuxino.dtb \
 	sun8i-a33-q8-tablet.dtb \
 	sun8i-a33-sinlinx-sina33.dtb \
+	sun8i-a33-vstar.dtb \
 	sun8i-r16-bananapi-m2m.dtb \
 	sun8i-r16-nintendo-nes-classic.dtb \
 	sun8i-r16-nintendo-super-nes-classic.dtb \
diff --git a/arch/arm/dts/sun8i-a33-vstar-core1.dtsi b/arch/arm/dts/sun8i-a33-vstar-core1.dtsi
new file mode 100644
index 00000000000..5b7057015cc
--- /dev/null
+++ b/arch/arm/dts/sun8i-a33-vstar-core1.dtsi
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Icenowy Zheng <uwu@icenowy.me>
+ */
+
+#include "sun8i-a33.dtsi"
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_pins>;
+	vmmc-supply = <&reg_dcdc1>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
+
+&mmc2_8bit_pins {
+	/* Increase drive strength for DDR modes */
+	drive-strength = <40>;
+};
+
+&r_rsb {
+	status = "okay";
+
+	axp22x: pmic@3a3 {
+		compatible = "x-powers,axp223";
+		reg = <0x3a3>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		eldoin-supply = <&reg_dcdc1>;
+		x-powers,drive-vbus-en;
+	};
+};
+
+#include "axp223.dtsi"
+
+&reg_aldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-io";
+};
+
+&reg_aldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <2350000>;
+	regulator-max-microvolt = <2650000>;
+	regulator-name = "vdd-dll";
+};
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-avcc";
+};
+
+&reg_dc5ldo {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpus";
+};
+
+&reg_dcdc1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-sys";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc5 {
+	regulator-always-on;
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-name = "vcc-dram";
+};
+
+&reg_rtc_ldo {
+	regulator-name = "vcc-rtc";
+};
diff --git a/arch/arm/dts/sun8i-a33-vstar.dts b/arch/arm/dts/sun8i-a33-vstar.dts
new file mode 100644
index 00000000000..9f5c29b3df4
--- /dev/null
+++ b/arch/arm/dts/sun8i-a33-vstar.dts
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Icenowy Zheng <uwu@icenowy.me>
+ */
+
+/dts-v1/;
+#include "sun8i-a33-vstar-core1.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Rervision A33-Vstar";
+	compatible = "rervision,a33-vstar",
+		     "rervision,a33-core1",
+		     "allwinner,sun8i-a33";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet0 = &r8152;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reg_usb1_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&pio 1 2 GPIO_ACTIVE_HIGH>; /* PB2 */
+	};
+
+	wifi_pwrseq: pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL6 */
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
+		clock-names = "ext_clock";
+	};
+};
+
+&ac_power_supply {
+	status = "okay";
+};
+
+&codec {
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
+};
+
+&ehci0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	hub@1 {
+		/* Onboard GL850G hub which needs no extra power sequence */
+		compatible = "usb5e3,608";
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		r8152: ethernet@4 {
+			/*
+			 * Onboard Realtek RTL8152 USB Ethernet,
+			 * with no MAC address programmed
+			 */
+			compatible = "usbbda,8152";
+			reg = <4>;
+		};
+	};
+};
+
+&lradc {
+	vref-supply = <&reg_aldo3>;
+	status = "okay";
+
+	button-191 {
+		label = "V+";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <191011>;
+	};
+
+	button-391 {
+		label = "V-";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <391304>;
+	};
+
+	button-600 {
+		label = "BACK";
+		linux,code = <KEY_BACK>;
+		channel = <0>;
+		voltage = <600000>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_dcdc1>;
+	bus-width = <4>;
+	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
+	status = "okay";
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pg_pins>;
+	vmmc-supply = <&reg_dldo1>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 7 IRQ_TYPE_LEVEL_LOW>; /* PL7 */
+		interrupt-names = "host-wake";
+	};
+};
+
+/*
+ * Our WiFi chip needs both DLDO1 and DLDO2 to be powered at the same
+ * time, with the two being in sync. Since this is not really
+ * supported right now, just use the two as always on, and we will fix
+ * it later.
+ */
+&reg_dldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi0";
+};
+
+&reg_dldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi1";
+};
+
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
+	status = "okay";
+};
+
+&sound {
+	/* TODO: on-board microphone */
+
+	simple-audio-card,widgets = "Headphone", "Headphone Jack";
+	simple-audio-card,routing =
+		"Left DAC", "DACL",
+		"Right DAC", "DACR",
+		"Headphone Jack", "HP";
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pg_pins>, <&uart1_cts_rts_pg_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
+		clock-names = "lpo";
+		vbat-supply = <&reg_dldo1>;
+		device-wakeup-gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
+		host-wakeup-gpios = <&r_pio 0 9 GPIO_ACTIVE_HIGH>; /* PL9 */
+		shutdown-gpios = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+	};
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
+	usb0_vbus-supply = <&reg_drivevbus>;
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index 84799879e85..5592d366600 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -526,6 +526,11 @@ M:	Quentin Schulz <quentin.schulz@free-electrons.com>
 S:	Maintained
 F:	configs/parrot_r16_defconfig
 
+RERVISION A33-VSTAR BOARD
+M:	Icenowy Zheng <uwu@icenowy.me>
+S:	Maintained
+F:	configs/A33-Vstar_defconfig
+
 SINLINX SINA31s BOARD
 M:	Chen-Yu Tsai <wens@csie.org>
 S:	Maintained
diff --git a/configs/A33-Vstar_defconfig b/configs/A33-Vstar_defconfig
new file mode 100644
index 00000000000..0053c243444
--- /dev/null
+++ b/configs/A33-Vstar_defconfig
@@ -0,0 +1,23 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun8i-a33-vstar"
+CONFIG_SPL=y
+CONFIG_MACH_SUN8I_A33=y
+CONFIG_DRAM_CLK=552
+CONFIG_DRAM_ZQ=15291
+CONFIG_DRAM_ODT_EN=y
+CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_USB0_ID_DET="PH8"
+CONFIG_USB1_VBUS_PIN="PB2"
+# CONFIG_VIDEO_SUNXI is not set
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_CMD_DFU=y
+CONFIG_DFU_RAM=y
+CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
+CONFIG_AXP_DCDC1_VOLT=3300
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_MUSB_GADGET=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_FUNCTION_MASS_STORAGE=y
+# CONFIG_USB_ETHER is not set
-- 
2.47.1

