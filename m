Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA4CE743C8
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 21:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 270C186ED3;
	Thu, 28 Sep 2023 23:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A25886EDF; Thu, 28 Sep 2023 23:56:46 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CF7EA86E22
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 23:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFD64DA7;
 Thu, 28 Sep 2023 14:57:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C93583F59C;
 Thu, 28 Sep 2023 14:56:41 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	u-boot@lists.denx.de
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@arm.com, andre.przywara@foss.arm.com
Subject: [PATCH v2 22/22] sunxi: add MangoPi MQ-R board support
Date: Thu, 28 Sep 2023 22:54:55 +0100
Message-Id: <20230928215455.28094-23-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20230928215455.28094-1-andre.przywara@arm.com>
References: <20230928215455.28094-1-andre.przywara@arm.com>
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

This copies the T113s specific DTs from the Linux kernel tree
(v6.4-rc1), and adds a defconfig to get the board booted.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/dts/Makefile                         |   2 +
 .../arm/dts/sun8i-t113s-mangopi-mq-r-t113.dts |  35 +++++
 arch/arm/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi | 126 ++++++++++++++++++
 configs/mangopi_mq_r_defconfig                |  15 +++
 4 files changed, 178 insertions(+)
 create mode 100644 arch/arm/dts/sun8i-t113s-mangopi-mq-r-t113.dts
 create mode 100644 arch/arm/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi
 create mode 100644 configs/mangopi_mq_r_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index bde2176ec7f..0919cea55ef 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -754,6 +754,8 @@ dtb-$(CONFIG_MACH_SUN8I_V3S) += \
 	sun8i-s3-pinecube.dtb \
 	sun8i-v3-sl631-imx179.dtb \
 	sun8i-v3s-licheepi-zero.dtb
+dtb-$(CONFIG_MACH_SUN8I_R528) += \
+	sun8i-t113s-mangopi-mq-r-t113.dtb
 dtb-$(CONFIG_MACH_SUN50I_H5) += \
 	sun50i-h5-bananapi-m2-plus.dtb \
 	sun50i-h5-emlid-neutis-n5-devboard.dtb \
diff --git a/arch/arm/dts/sun8i-t113s-mangopi-mq-r-t113.dts b/arch/arm/dts/sun8i-t113s-mangopi-mq-r-t113.dts
new file mode 100644
index 00000000000..8b3a7538381
--- /dev/null
+++ b/arch/arm/dts/sun8i-t113s-mangopi-mq-r-t113.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2022 Arm Ltd.
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/dts-v1/;
+
+#include "sun8i-t113s.dtsi"
+#include "sunxi-d1s-t113-mangopi-mq-r.dtsi"
+
+/ {
+	model = "MangoPi MQ-R-T113";
+	compatible = "widora,mangopi-mq-r-t113", "allwinner,sun8i-t113s";
+
+	aliases {
+		ethernet0 = &rtl8189ftv;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_vcc_core>;
+};
+
+&cpu1 {
+	cpu-supply = <&reg_vcc_core>;
+};
+
+&mmc1 {
+	rtl8189ftv: wifi@1 {
+		reg = <1>;
+		interrupt-parent = <&pio>;
+		interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 = WL_WAKE_AP */
+		interrupt-names = "host-wake";
+	};
+};
diff --git a/arch/arm/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi b/arch/arm/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi
new file mode 100644
index 00000000000..a415c4a78a7
--- /dev/null
+++ b/arch/arm/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2022 Arm Ltd.
+/*
+ * Common peripherals and configurations for MangoPi MQ-R boards.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	aliases {
+		serial3 = &uart3;
+	};
+
+	chosen {
+		stdout-path = "serial3:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&pio 3 22 GPIO_ACTIVE_LOW>; /* PD22 */
+		};
+	};
+
+	/* board wide 5V supply directly from the USB-C socket */
+	reg_vcc5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	/* SY8008 DC/DC regulator on the board */
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_vcc5v>;
+	};
+
+	/* SY8008 DC/DC regulator on the board, also supplying VDD-SYS */
+	reg_vcc_core: regulator-core {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-core";
+		regulator-min-microvolt = <880000>;
+		regulator-max-microvolt = <880000>;
+		vin-supply = <&reg_vcc5v>;
+	};
+
+	/* XC6206 LDO on the board */
+	reg_avdd2v8: regulator-avdd {
+		compatible = "regulator-fixed";
+		regulator-name = "avdd2v8";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&reg_3v3>;
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&pio 6 12 GPIO_ACTIVE_LOW>; /* PG12 */
+	};
+};
+
+&dcxo {
+	clock-frequency = <24000000>;
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-0 = <&mmc0_pins>;
+	pinctrl-names = "default";
+	vmmc-supply = <&reg_3v3>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc1 {
+	pinctrl-0 = <&mmc1_pins>;
+	pinctrl-names = "default";
+	vmmc-supply = <&reg_3v3>;
+	non-removable;
+	bus-width = <4>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&pio {
+	vcc-pb-supply = <&reg_3v3>;
+	vcc-pd-supply = <&reg_3v3>;
+	vcc-pe-supply = <&reg_avdd2v8>;
+	vcc-pf-supply = <&reg_3v3>;
+	vcc-pg-supply = <&reg_3v3>;
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pb_pins>;
+	status = "okay";
+};
+
+/* The USB-C socket has its CC pins pulled to GND, so is hardwired as a UFP. */
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_vcc5v>;
+	status = "okay";
+};
diff --git a/configs/mangopi_mq_r_defconfig b/configs/mangopi_mq_r_defconfig
new file mode 100644
index 00000000000..66ae639326f
--- /dev/null
+++ b/configs/mangopi_mq_r_defconfig
@@ -0,0 +1,15 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun8i-t113s-mangopi-mq-r-t113"
+CONFIG_SPL=y
+CONFIG_MACH_SUN8I_R528=y
+CONFIG_DRAM_CLK=792
+CONFIG_DRAM_ZQ=8092667
+CONFIG_SUNXI_MINIMUM_DRAM_MB=128
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_DRAM_SUNXI_ODT_EN=0
+CONFIG_DRAM_SUNXI_TPR0=0x004a2195
+CONFIG_DRAM_SUNXI_TPR11=0x340000
+CONFIG_DRAM_SUNXI_TPR12=0x46
+CONFIG_DRAM_SUNXI_TPR13=0x34000100
+CONFIG_CONS_INDEX=4
-- 
2.35.8

