Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2CACD5BAB
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 22:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D56188404D;
	Mon, 25 May 2026 00:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YK4WDljz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oBVzliSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F1B841D7; Mon, 25 May 2026 00:07:28 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F0B083FF5
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 00:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gNtRK2XgPz9t2T;
 Mon, 25 May 2026 00:07:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779660445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1iZA2qn3jwTm+oAsxX/NHGsqiMOY62oocAliNr/rSoA=;
 b=YK4WDljzBu/mgkAA9+N/9elS4UAHdzqTSa4V/jDu21ACUKZjzb+2zr7EDaRLDozoi6d8oF
 AfYhgLvg1Wfc9XCKVip2KWeyK7TCKBAThST9861LCdwgIHW9VPm37LaaaBJfQXgvfVN7qi
 OPXNKme1Cgxas4dnnSb4C7hC2K+n0kTU7HPQuXi9Cf8JjOi6FmT3o/WfrjfQsDMFtat26d
 GVrm4hDUwdnmjCEaC8h25L6GjZtONfdtAVjlBIklyVfZAvQht+xVZB5IvogVS/EAmtAAb8
 zeQ6FLHBvvCUzPmUA7tn7YGQMr/KUZjBe1J5twPeOGoEPxvSXh3wVX3WEaMxQg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779660443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1iZA2qn3jwTm+oAsxX/NHGsqiMOY62oocAliNr/rSoA=;
 b=oBVzliSFPYYFSkvG8qKzWZ30RfE/4LTHo7osgGEmkFqbKtSCPoi96LYmeXTzlucVRjChrV
 6ax9qKnV2h4UKMTniRgCalBO6xp61/KKMRt5f1LsyWYsFqDxko040bs/6/JNMj2kq+EdXA
 ohDID0ndRTmPktMy6Qq4aCw4pjv1xfoNCariS09+fkjt8PT+kt7uwVs8VTVq30nT36IOLS
 PbDQBHsWIsxVTHpwp/OZ4DLd31TEEoO5eryMdhLaZtCYChno1NsJOiGnu2JcF1owrS+8yy
 QxkWWl3z+qZhI/ly5GuDvBZBHh/QU/37ESzSJSeoB6/eziaiKaJmxBqPzlk+mA==
To: u-boot@lists.denx.de
Cc: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>,
 Huy Bui <huy.bui.pz@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] arm64: dts: renesas: r8a779md: Add support for R-Car M3Le
 R8A779MD Geist
Date: Mon, 25 May 2026 00:06:19 +0200
Message-ID: <20260524220719.711310-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 74p8537mjob4bins5nnnp8iw6uj93qii
X-MBO-RS-ID: e82c0b78e4e1575fd16
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

From: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>

Add support for the Geist board based on the Renesas R8A779MD (M3Le) SoC, a
register-compatible variant of the R8A77965 (M3N) with reduced peripherals.
The Geist board design references the Renesas Salvator-X/XS boards, adapting
their configuration for the R8A779MD SoC.

The board will be switched to OF_UPSTREAM once the DTs land in upstream.

Signed-off-by: Huy Bui <huy.bui.pz@bp.renesas.com>
Signed-off-by: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Huy Bui <huy.bui.pz@bp.renesas.com>
Cc: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Update DTs to latest submitted to Linux kernel ML
---
NOTE: DTs are also submitted to Linux kernel ML:
      https://lore.kernel.org/linux-arm-kernel/20260504144534.43745-7-marek.vasut+renesas@mailbox.org/
      https://lore.kernel.org/linux-arm-kernel/20260522172000.15096-1-marek.vasut+renesas@mailbox.org/
      The DTs in this MR match the Linux ones, except for pciec0_rp
      node which was added to Linux r8a77965.dtsi only very recently
      and will be synced together with Linux DTs at a future date.
      Until the sync happens, the PCIe is described using fixed clock.
---
 arch/arm/dts/Makefile                   |   3 +
 arch/arm/dts/r8a779md-geist-u-boot.dtsi |  59 ++
 arch/arm/dts/r8a779md-geist.dts         | 717 ++++++++++++++++++++++++
 arch/arm/dts/r8a779md.dtsi              |  59 ++
 arch/arm/mach-renesas/Kconfig.rcar3     |   8 +
 arch/arm/mach-renesas/cpu_info.c        |  13 +
 board/renesas/geist/Kconfig             |  15 +
 board/renesas/geist/Makefile            |   9 +
 board/renesas/geist/geist.c             |  36 ++
 configs/r8a779md_geist_defconfig        |  75 +++
 include/configs/geist.h                 |  18 +
 11 files changed, 1012 insertions(+)
 create mode 100644 arch/arm/dts/r8a779md-geist-u-boot.dtsi
 create mode 100644 arch/arm/dts/r8a779md-geist.dts
 create mode 100644 arch/arm/dts/r8a779md.dtsi
 create mode 100644 board/renesas/geist/Kconfig
 create mode 100644 board/renesas/geist/Makefile
 create mode 100644 board/renesas/geist/geist.c
 create mode 100644 configs/r8a779md_geist_defconfig
 create mode 100644 include/configs/geist.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 3cbb1f14d25..cf9046f6056 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -899,6 +899,9 @@ dtb-$(CONFIG_RZA1) += \
 	r7s72100-genmai.dtb \
 	r7s72100-gr-peach.dtb
 
+dtb-$(CONFIG_RCAR_GEN3) += \
+	r8a779md-geist.dtb
+
 dtb-$(CONFIG_RCAR_GEN5) += \
 	r8a78000-ironhide-cm33.dtb
 
diff --git a/arch/arm/dts/r8a779md-geist-u-boot.dtsi b/arch/arm/dts/r8a779md-geist-u-boot.dtsi
new file mode 100644
index 00000000000..fbda218002a
--- /dev/null
+++ b/arch/arm/dts/r8a779md-geist-u-boot.dtsi
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source extras for U-Boot for the Geist board with r8a779md
+ *
+ * Copyright (C) 2025-2026 Renesas Electronics Corp.
+ */
+
+/ {
+	aliases {
+		spi0 = &rpc;
+	};
+};
+
+&pfc {
+	qspi0_pins: qspi0 {
+		groups = "qspi0_ctrl", "qspi0_data4";
+		function = "qspi0";
+	};
+};
+
+/*
+ * SPI access works only if TFA is built with RCAR_RPC_HYPERFLASH_LOCKED=0
+ * and SPD=none , otherwise the RPC access is blocked either by TFA in case
+ * the former is set to 1, or by OPTEE-OS in case SPD=opteed .
+ */
+&rpc {
+	pinctrl-0 = <&qspi0_pins>;
+	pinctrl-names = "default";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	spi-max-frequency = <40000000>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+	};
+};
+
+&sdhi0 {
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr104;
+	max-frequency = <208000000>;
+};
+
+&sdhi2 {
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	max-frequency = <200000000>;
+};
+
+&vcc_sdhi0 {
+	u-boot,off-on-delay-us = <20000>;
+};
diff --git a/arch/arm/dts/r8a779md-geist.dts b/arch/arm/dts/r8a779md-geist.dts
new file mode 100644
index 00000000000..2921aba92a5
--- /dev/null
+++ b/arch/arm/dts/r8a779md-geist.dts
@@ -0,0 +1,717 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the Geist board with R-Car M3Le
+ *
+ * Copyright (C) 2025-2026 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "r8a779md.dtsi"
+
+/ {
+	model = "Renesas Geist board based on r8a779md";
+	compatible = "renesas,geist", "renesas,r8a779md", "renesas,r8a77965";
+
+	aliases {
+		serial0 = &scif2;
+		serial1 = &hscif1;
+		ethernet0 = &avb;
+		mmc0 = &sdhi2;
+		mmc1 = &sdhi0;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=on";
+		stdout-path = "serial0:115200n8";
+	};
+
+	audio_clkout: audio-clkout {
+		/*
+		 * This is same as <&rcar_sound 0>
+		 * but needed to avoid cs2500/rcar_sound probe dead-lock
+		 */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12288000>;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 50000>;
+
+		brightness-levels = <256 128 64 16 8 4 0>;
+		default-brightness-level = <6>;
+
+		power-supply = <&reg_12v>;
+		enable-gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
+	};
+
+	cvbs-in {
+		compatible = "composite-video-connector";
+		label = "CVBS IN";
+
+		port {
+			cvbs_con: endpoint {
+				remote-endpoint = <&adv7482_ain7>;
+			};
+		};
+	};
+
+	hdmi-in {
+		compatible = "hdmi-connector";
+		label = "HDMI IN";
+		type = "a";
+
+		port {
+			hdmi_in_con: endpoint {
+				remote-endpoint = <&adv7482_hdmi>;
+			};
+		};
+	};
+
+	keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&keys_pins>;
+		pinctrl-names = "default";
+
+		key-1 {
+			gpios = <&gpio5 17 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_1>;
+			label = "SW4-1";
+			wakeup-source;
+			debounce-interval = <20>;
+		};
+
+		key-2 {
+			gpios = <&gpio5 20 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_2>;
+			label = "SW4-2";
+			wakeup-source;
+			debounce-interval = <20>;
+		};
+
+		key-3 {
+			gpios = <&gpio5 22 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_3>;
+			label = "SW4-3";
+			wakeup-source;
+			debounce-interval = <20>;
+		};
+
+		key-4 {
+			gpios = <&gpio5 23 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_4>;
+			label = "SW4-4";
+			wakeup-source;
+			debounce-interval = <20>;
+		};
+
+		key-a {
+			gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_A>;
+			label = "TSW0";
+			wakeup-source;
+			debounce-interval = <20>;
+		};
+
+		key-b {
+			gpios = <&gpio6 12 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_B>;
+			label = "TSW1";
+			wakeup-source;
+			debounce-interval = <20>;
+		};
+
+		key-c {
+			gpios = <&gpio6 13 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_C>;
+			label = "TSW2";
+			wakeup-source;
+			debounce-interval = <20>;
+		};
+	};
+
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x78000000>;
+	};
+
+	memory@480000000 {
+		device_type = "memory";
+		reg = <0x4 0x80000000 0x0 0x80000000>;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_12v: regulator-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vbus0_usb2: regulator-vbus0-usb2 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "USB20_VBUS0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		gpio = <&gpio6 16 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vcc_sdhi0: regulator-vcc-sdhi0 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhi0: regulator-vccq-sdhi0 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1>, <1800000 0>;
+	};
+
+	sound_card: sound {
+		compatible = "audio-graph-card";
+
+		label = "rcar-sound";
+		dais = <&rsnd_port0>; /* AK4619 Audio Codec */
+	};
+
+	x12_clk: x12-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24576000>;
+	};
+
+	/* External DU dot clocks */
+	x21_clk: x21-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <33000000>;
+	};
+
+	x22_clk: x22-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <33000000>;
+	};
+
+	x23_clk: x23-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	x3013_clk: x3013-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+};
+
+&audio_clk_a {
+	clock-frequency = <22579200>;
+};
+
+&avb {
+	pinctrl-0 = <&avb_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&phy0>;
+	tx-internal-delay-ps = <2000>;
+	status = "okay";
+
+	phy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-id0022.1622";
+		rxc-skew-ps = <1500>;
+		reg = <0>;
+		interrupts-extended = <&gpio2 11 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <300>;
+	};
+};
+
+&csi40 {
+	status = "okay";
+
+	ports {
+		port@0 {
+			csi40_in: endpoint {
+				clock-lanes = <0>;
+				data-lanes = <1 2 3 4>;
+				remote-endpoint = <&adv7482_txa>;
+			};
+		};
+	};
+};
+
+&ehci0 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&extalr_clk {
+	clock-frequency = <32768>;
+};
+
+&extal_clk {
+	clock-frequency = <16666666>;
+};
+
+&hscif1 {
+	pinctrl-0 = <&hscif1_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+	/* Please only enable hscif1 or scif1 */
+	status = "okay";
+};
+
+&hsusb {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <100000>;
+	status = "okay";
+
+	ak4619: codec@10 {
+		compatible = "asahi-kasei,ak4619";
+		reg = <0x10>;
+		clocks = <&rcar_sound 3>;
+		clock-names = "mclk";
+		#sound-dai-cells = <0>;
+
+		port {
+			ak4619_endpoint: endpoint {
+				remote-endpoint = <&rsnd_endpoint0>;
+			};
+		};
+	};
+
+	/* Pin-to-pin, register map, and control compatible with CS2000 and CS2200 */
+	cs2500: clock-controller@4f {
+		#clock-cells = <0>;
+		compatible = "cirrus,cs2500", "cirrus,cs2000-cp";
+		reg = <0x4f>;
+		clocks = <&audio_clkout>, <&x12_clk>;
+		clock-names = "clk_in", "ref_clk";
+
+		assigned-clocks = <&cs2500>;
+		assigned-clock-rates = <24576000>; /* 1/1 divide */
+	};
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	versaclock3: clock-controller@68 {
+		compatible = "renesas,5p35023";
+		reg = <0x68>;
+		#clock-cells = <1>;
+		clocks = <&x3013_clk>;
+		assigned-clocks = <&versaclock3 4>, <&versaclock3 5>;
+		assigned-clock-rates = <100000000>, <100000000>;
+	};
+
+	versaclock5: clock-controller@6a {
+		compatible = "idt,5p49v5923";
+		reg = <0x6a>;
+		#clock-cells = <1>;
+		clocks = <&x23_clk>;
+		clock-names = "xin";
+	};
+
+	video-receiver@70 {
+		compatible = "adi,adv7482";
+		reg = <0x70 0x71 0x72 0x73 0x74 0x75
+		       0x60 0x61 0x62 0x63 0x64 0x65>;
+		reg-names = "main", "dpll", "cp", "hdmi", "edid", "repeater",
+			    "infoframe", "cbus", "cec", "sdp", "txa", "txb" ;
+
+		interrupts-extended = <&gpio6 30 IRQ_TYPE_LEVEL_LOW>,
+				      <&gpio6 31 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "intrq1", "intrq2";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@7 {
+				reg = <7>;
+
+				adv7482_ain7: endpoint {
+					remote-endpoint = <&cvbs_con>;
+				};
+			};
+
+			port@8 {
+				reg = <8>;
+
+				adv7482_hdmi: endpoint {
+					remote-endpoint = <&hdmi_in_con>;
+				};
+			};
+
+			port@a {
+				reg = <10>;
+
+				adv7482_txa: endpoint {
+					clock-lanes = <0>;
+					data-lanes = <1 2 3 4>;
+					remote-endpoint = <&csi40_in>;
+				};
+			};
+		};
+	};
+
+	csa_vdd: adc@7c {
+		compatible = "maxim,max9611";
+		reg = <0x7c>;
+
+		shunt-resistor-micro-ohms = <5000>;
+	};
+
+	csa_dvfs: adc@7f {
+		compatible = "maxim,max9611";
+		reg = <0x7f>;
+
+		shunt-resistor-micro-ohms = <5000>;
+	};
+};
+
+&i2c_dvfs {
+	status = "okay";
+
+	clock-frequency = <400000>;
+
+	eeprom@50 {
+		compatible = "rohm,br24t01", "atmel,24c01";
+		reg = <0x50>;
+		pagesize = <8>;
+	};
+};
+
+&ohci0 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&pcie_bus_clk {
+	clock-frequency = <100000000>;
+	status = "disabled";
+};
+
+&pciec0 {
+	clocks = <&cpg CPG_MOD 319>, <&versaclock3 4>;
+	status = "okay";
+};
+
+&pfc {
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
+
+	avb_pins: avb {
+		mux {
+			groups = "avb_link", "avb_mdio", "avb_mii";
+			function = "avb";
+		};
+
+		pins_mdio {
+			groups = "avb_mdio";
+			drive-strength = <24>;
+		};
+
+		pins_mii_tx {
+			pins = "PIN_AVB_TX_CTL", "PIN_AVB_TXC", "PIN_AVB_TD0",
+			       "PIN_AVB_TD1", "PIN_AVB_TD2", "PIN_AVB_TD3";
+			drive-strength = <12>;
+		};
+	};
+
+	hscif1_pins: hscif1 {
+		groups = "hscif1_data_a", "hscif1_ctrl_a";
+		function = "hscif1";
+	};
+
+	i2c2_pins: i2c2 {
+		groups = "i2c2_a";
+		function = "i2c2";
+	};
+
+	irq0_pins: irq0 {
+		groups = "intc_ex_irq0";
+		function = "intc_ex";
+	};
+
+	keys_pins: keys {
+		pins = "GP_5_17", "GP_5_20", "GP_5_22";
+		bias-pull-up;
+	};
+
+	pwm1_pins: pwm1 {
+		groups = "pwm1_a";
+		function = "pwm1";
+	};
+
+	scif1_pins: scif1 {
+		groups = "scif1_data_a", "scif1_ctrl";
+		function = "scif1";
+	};
+
+	scif2_pins: scif2 {
+		groups = "scif2_data_a";
+		function = "scif2";
+	};
+
+	scif_clk_pins: scif_clk {
+		groups = "scif_clk_a";
+		function = "scif_clk";
+	};
+
+	sdhi0_pins: sd0 {
+		groups = "sdhi0_data4", "sdhi0_ctrl";
+		function = "sdhi0";
+		power-source = <3300>;
+	};
+
+	sdhi0_pins_uhs: sd0_uhs {
+		groups = "sdhi0_data4", "sdhi0_ctrl";
+		function = "sdhi0";
+		power-source = <1800>;
+	};
+
+	sdhi2_pins: sd2 {
+		groups = "sdhi2_data8", "sdhi2_ctrl", "sdhi2_ds";
+		function = "sdhi2";
+		power-source = <1800>;
+	};
+
+	sound_pins: sound {
+		groups = "ssi01239_ctrl", "ssi0_data", "ssi1_data_a";
+		function = "ssi";
+	};
+
+	sound_clk_pins: sound_clk {
+		groups = "audio_clk_a_a", "audio_clk_b_a", "audio_clk_c_a",
+			 "audio_clkout_a", "audio_clkout3_a";
+		function = "audio_clk";
+	};
+
+	usb0_pins: usb0 {
+		groups = "usb0";
+		function = "usb0";
+	};
+};
+
+&pwm1 {
+	pinctrl-0 = <&pwm1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&rcar_sound {
+	pinctrl-0 = <&sound_pins>, <&sound_clk_pins>;
+	pinctrl-names = "default";
+
+	/* Single DAI */
+	#sound-dai-cells = <0>;
+
+	/* audio_clkout0/1/2/3 */
+	#clock-cells = <1>;
+	clock-frequency = <12288000 11289600>;
+
+	status = "okay";
+
+	/* update <audio_clk_b> to <cs2500> */
+	clocks = <&cpg CPG_MOD 1005>,
+		 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
+		 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
+		 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
+		 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
+		 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
+		 <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
+		 <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
+		 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
+		 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
+		 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
+		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
+		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
+		 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
+		 <&audio_clk_a>, <&cs2500>,
+		 <&audio_clk_c>,
+		 <&cpg CPG_MOD 922>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rsnd_port0: port@0 {
+			reg = <0>;
+
+			rsnd_endpoint0: endpoint {
+				remote-endpoint = <&ak4619_endpoint>;
+				dai-format = "left_j";
+				bitclock-master = <&rsnd_endpoint0>;
+				frame-master = <&rsnd_endpoint0>;
+				playback = <&ssi0>, <&src0>, <&dvc0>;
+				capture = <&ssi1>, <&src1>, <&dvc1>;
+			};
+		};
+	};
+};
+
+&rwdt {
+	timeout-sec = <60>;
+	status = "okay";
+};
+
+&scif1 {
+	pinctrl-0 = <&scif1_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+	/* Please only enable hscif1 or scif1 */
+	/* status = "okay"; */
+};
+
+&scif2 {
+	pinctrl-0 = <&scif2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&scif_clk {
+	clock-frequency = <14745600>;
+};
+
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-1 = <&sdhi0_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
+
+	vmmc-supply = <&vcc_sdhi0>;
+	vqmmc-supply = <&vccq_sdhi0>;
+	cd-gpios = <&gpio3 12 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
+	bus-width = <4>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
+&sdhi2 {
+	/* used for on-board 8bit eMMC */
+	pinctrl-0 = <&sdhi2_pins>;
+	pinctrl-1 = <&sdhi2_pins>;
+	pinctrl-names = "default", "state_uhs";
+
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	bus-width = <8>;
+	mmc-hs200-1_8v;
+	no-sd;
+	no-sdio;
+	non-removable;
+	fixed-emmc-driver-type = <1>;
+	full-pwr-cycle-in-suspend;
+	status = "okay";
+};
+
+&ssi1 {
+	shared-pin;
+};
+
+&usb_extal_clk {
+	clock-frequency = <50000000>;
+};
+
+&usb2_phy0 {
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+
+	vbus-supply = <&vbus0_usb2>;
+	status = "okay";
+};
+
+&vin0 {
+	status = "okay";
+};
+
+&vin1 {
+	status = "okay";
+};
+
+&vin2 {
+	status = "okay";
+};
+
+&vin3 {
+	status = "okay";
+};
+
+&vin4 {
+	status = "okay";
+};
+
+&vin5 {
+	status = "okay";
+};
+
+&vin6 {
+	status = "okay";
+};
+
+&vin7 {
+	status = "okay";
+};
+
+&vspb {
+	status = "okay";
+};
+
+&vspi0 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/r8a779md.dtsi b/arch/arm/dts/r8a779md.dtsi
new file mode 100644
index 00000000000..f3065414134
--- /dev/null
+++ b/arch/arm/dts/r8a779md.dtsi
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the R-Car M3Le (R8A779MD) SoC
+ *
+ * Copyright (C) 2025-2026 Renesas Electronics Corp.
+ */
+
+#include "r8a77965.dtsi"
+
+/ {
+	compatible = "renesas,r8a779md", "renesas,r8a77965";
+};
+
+/delete-node/ &csi20;
+/delete-node/ &drif00;
+/delete-node/ &drif01;
+/delete-node/ &drif10;
+/delete-node/ &drif11;
+/delete-node/ &drif20;
+/delete-node/ &drif21;
+/delete-node/ &drif30;
+/delete-node/ &drif31;
+/delete-node/ &du;
+/delete-node/ &ehci1;
+/delete-node/ &hdmi0;
+/delete-node/ &lvds0;
+/delete-node/ &mlp;
+/delete-node/ &ohci1;
+/delete-node/ &pciec1;
+/delete-node/ &sata;
+/delete-node/ &usb2_phy1;
+/delete-node/ &usb3_peri0;
+/delete-node/ &usb3_phy0;
+/delete-node/ &vin0csi20;
+/delete-node/ &vin1csi20;
+/delete-node/ &vin2csi20;
+/delete-node/ &vin3csi20;
+/delete-node/ &vin4csi20;
+/delete-node/ &vin5csi20;
+/delete-node/ &vin6csi20;
+/delete-node/ &vin7csi20;
+/delete-node/ &xhci0;
+
+&sdhi0 {
+	compatible = "renesas,sdhi-r8a779md", "renesas,rcar-gen3-sdhi";
+};
+
+&sdhi1 {
+	compatible = "renesas,sdhi-r8a779md", "renesas,rcar-gen3-sdhi";
+};
+
+&sdhi2 {
+	compatible = "renesas,sdhi-r8a779md", "renesas,rcar-gen3-sdhi";
+};
+
+&sdhi3 {
+	compatible = "renesas,sdhi-r8a779md", "renesas,rcar-gen3-sdhi";
+	no-mmc;
+};
diff --git a/arch/arm/mach-renesas/Kconfig.rcar3 b/arch/arm/mach-renesas/Kconfig.rcar3
index 8479875178d..6bed7684fb8 100644
--- a/arch/arm/mach-renesas/Kconfig.rcar3
+++ b/arch/arm/mach-renesas/Kconfig.rcar3
@@ -164,12 +164,20 @@ config TARGET_ULCB
 	help
 	  Support for Renesas R-Car Gen3 ULCB platform
 
+config TARGET_GEIST
+	bool "Geist board"
+	imply R8A77965
+	imply SYS_MALLOC_F
+	help
+	  Support for Renesas R-Car Gen3 Geist platform
+
 endchoice
 
 source "board/renesas/condor/Kconfig"
 source "board/renesas/draak/Kconfig"
 source "board/renesas/eagle/Kconfig"
 source "board/renesas/ebisu/Kconfig"
+source "board/renesas/geist/Kconfig"
 source "board/renesas/salvator-x/Kconfig"
 source "board/renesas/ulcb/Kconfig"
 source "board/renesas/v3hsk/Kconfig"
diff --git a/arch/arm/mach-renesas/cpu_info.c b/arch/arm/mach-renesas/cpu_info.c
index f040d732a51..42183e2daa5 100644
--- a/arch/arm/mach-renesas/cpu_info.c
+++ b/arch/arm/mach-renesas/cpu_info.c
@@ -114,6 +114,8 @@ int arch_misc_init(void)
 
 int print_cpuinfo(void)
 {
+	const uintptr_t pfc_base = 0xe6060000;
+	void __iomem *rcar_m3nm3l_ident = (void __iomem *)pfc_base + 0x800;
 	int i = renesas_cpuinfo_idx();
 
 	if (renesas_cpuinfo[i].cpu_type == RENESAS_CPU_TYPE_R8A7796 &&
@@ -123,6 +125,17 @@ int print_cpuinfo(void)
 		return 0;
 	}
 
+	/*
+	 * M3Le PRR ID is the same as M3N , but PFC register 0x800 reads 0
+	 * on M3N and 1 on M3Le. Use this to discern M3Le from M3N .
+	 */
+	if (renesas_cpuinfo[i].cpu_type == RENESAS_CPU_TYPE_R8A77965 &&
+	    readl(rcar_m3nm3l_ident) == 1) {
+		printf("CPU:   Renesas Electronics R8A779MD rev %d.%d\n",
+		       renesas_get_cpu_rev_integer(), renesas_get_cpu_rev_fraction());
+		return 0;
+	}
+
 	printf("CPU:   Renesas Electronics %s rev %d.%d\n",
 		get_cpu_name(i), renesas_get_cpu_rev_integer(),
 		renesas_get_cpu_rev_fraction());
diff --git a/board/renesas/geist/Kconfig b/board/renesas/geist/Kconfig
new file mode 100644
index 00000000000..da36be0942f
--- /dev/null
+++ b/board/renesas/geist/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_GEIST
+
+config SYS_SOC
+	default "renesas"
+
+config SYS_BOARD
+	default "geist"
+
+config SYS_VENDOR
+	default "renesas"
+
+config SYS_CONFIG_NAME
+	default "geist"
+
+endif
diff --git a/board/renesas/geist/Makefile b/board/renesas/geist/Makefile
new file mode 100644
index 00000000000..3e33c91e9e7
--- /dev/null
+++ b/board/renesas/geist/Makefile
@@ -0,0 +1,9 @@
+#
+# Copyright (C) 2025-2026 Renesas Electronics Corporation
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+ifndef CONFIG_XPL_BUILD
+obj-y	+= geist.o
+endif
diff --git a/board/renesas/geist/geist.c b/board/renesas/geist/geist.c
new file mode 100644
index 00000000000..09241aed14c
--- /dev/null
+++ b/board/renesas/geist/geist.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file is Geist board support.
+ *
+ * Copyright (C) 2025-2026 Renesas Electronics Corporation
+ */
+
+#include <asm/io.h>
+#include <asm/arch/rcar-mstp.h>
+#include <asm/arch/renesas.h>
+#include <init.h>
+
+#define HSUSB_MSTP704		BIT(4)	/* HSUSB */
+
+/* HSUSB block registers */
+#define HSUSB_REG_LPSTS			0xE6590102
+#define HSUSB_REG_LPSTS_SUSPM_NORMAL	BIT(14)
+#define HSUSB_REG_UGCTRL2		0xE6590184
+#define HSUSB_REG_UGCTRL2_USB0SEL	0x30
+#define HSUSB_REG_UGCTRL2_USB0SEL_EHCI	0x10
+
+int board_init(void)
+{
+	/* USB1 pull-up */
+	setbits_le32(PFC_PUEN6, PUEN_USB1_OVC | PUEN_USB1_PWEN);
+
+	/* Configure the HSUSB block */
+	mstp_clrbits_le32(SMSTPCR7, SMSTPCR7, HSUSB_MSTP704);
+	/* Choice USB0SEL */
+	clrsetbits_le32(HSUSB_REG_UGCTRL2, HSUSB_REG_UGCTRL2_USB0SEL,
+			HSUSB_REG_UGCTRL2_USB0SEL_EHCI);
+	/* low power status */
+	setbits_le16(HSUSB_REG_LPSTS, HSUSB_REG_LPSTS_SUSPM_NORMAL);
+
+	return 0;
+}
diff --git a/configs/r8a779md_geist_defconfig b/configs/r8a779md_geist_defconfig
new file mode 100644
index 00000000000..2d25690354b
--- /dev/null
+++ b/configs/r8a779md_geist_defconfig
@@ -0,0 +1,75 @@
+#include <configs/renesas_rcar3.config>
+
+# CONFIG_OF_UPSTREAM is not set
+
+CONFIG_ARM=y
+CONFIG_ARCH_RENESAS=y
+CONFIG_RCAR_GEN3=y
+CONFIG_COUNTER_FREQUENCY=16666666
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_ENV_SIZE=0x20000
+CONFIG_ENV_OFFSET=0xFFFE0000
+CONFIG_DEFAULT_DEVICE_TREE="r8a779md-geist"
+CONFIG_SPL_TEXT_BASE=0xe6338000
+CONFIG_TARGET_GEIST=y
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_STACK=0xe6304000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0xe633f000
+CONFIG_SPL_BSS_MAX_SIZE=0x1000
+CONFIG_PCI=y
+CONFIG_SYS_MONITOR_BASE=0x00000000
+# CONFIG_EFI_UNICODE_CAPITALIZATION is not set
+# CONFIG_BOOTSTD is not set
+CONFIG_USE_BOOTARGS=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} Image-r8a779md-geist.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
+CONFIG_DEFAULT_FDT_FILE="r8a779md-geist.dtb"
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=10
+CONFIG_CMD_DFU=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_MULTI_DTB_FIT_LZO=y
+CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
+CONFIG_OF_DTB_PROPS_REMOVE=y
+CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask iommus"
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
+CONFIG_DFU_TFTP=y
+CONFIG_DFU_RAM=y
+CONFIG_DFU_SF=y
+CONFIG_SYS_I2C_RCAR_IIC=y
+CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x70
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_RENESAS_SDHI=y
+CONFIG_DM_MTD=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_RENESAS_RAVB=y
+CONFIG_NVME_PCI=y
+CONFIG_PCI_REGION_MULTI_ENTRY=y
+CONFIG_PCI_RCAR_GEN3=y
+CONFIG_SYSINFO=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Renesas"
+CONFIG_USB_GADGET_VENDOR_NUM=0x045b
+CONFIG_USB_GADGET_PRODUCT_NUM=0x023c
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_RENESAS_USBHS=y
+CONFIG_USB_STORAGE=y
diff --git a/include/configs/geist.h b/include/configs/geist.h
new file mode 100644
index 00000000000..3f7e2e913ed
--- /dev/null
+++ b/include/configs/geist.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * This file is Geist board configuration.
+ *
+ * Copyright (C) 2025-2026 Renesas Electronics Corporation
+ */
+
+#ifndef __GEIST_H
+#define __GEIST_H
+
+#include "rcar-gen3-common.h"
+
+/* Environment in eMMC, at the end of 2nd "boot sector" */
+
+#define CFG_SYS_FLASH_BANKS_LIST	{ 0x08000000 }
+#define CFG_SYS_WRITE_SWAPPED_DATA
+
+#endif /* __GEIST_H */
-- 
2.53.0

