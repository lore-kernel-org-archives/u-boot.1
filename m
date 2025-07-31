Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BCEC87FD2
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 21:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C8C38398B;
	Thu, 31 Jul 2025 23:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=agorria.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=agorria.com header.i=@agorria.com header.b="NIcifw/O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ECBA8380F; Thu, 31 Jul 2025 21:47:45 +0200 (CEST)
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 943EA83937
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 21:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=agorria.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ion@agorria.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4btKP84VnDzB0Tp;
 Thu, 31 Jul 2025 21:47:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agorria.com; s=MBO0001;
 t=1753991260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KsDQytWBj47cRbqsk/jsjACkgIi/KwqM9L3zho41ENw=;
 b=NIcifw/OIdS4Zp13xPPeuaBnhRR2exJf6J509d06pau2Vm+uH+ZebWSHqLvJ7ByEfgTrCR
 qf4zjTJG/I0v3VBWs9hG2EjxYxcA8sB7d2JtdbaRjSRC68WBh9XT9LQX+G2Iclzs3GX/xj
 eHDWR3ti5DzErZlfjz2jTGTsLyQqzshGQZXbyDru/J3S+UC8Msbv+14pk7ANXX0Fky8k78
 3QdUGXfxKT51Mv/WP4ntz4nYgQDeMEJ8uOThn1Q1q3ng9qqZjgJ3C1vLykPQ2aW43GZK+3
 SBC9Fknkwdp9POEEZrkb0HOZ4bDf5lkcbFQRrH569mlF3w35tVP6QDnm67WLjg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ion@agorria.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ion@agorria.com
From: Ion Agorria <ion@agorria.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] board: samsung: add Samsung Galaxy R (GT-I9103) and
 Captivate Glide (SGH-i927) support
Date: Thu, 31 Jul 2025 21:47:31 +0200
Message-ID: <20250731194731.287715-2-ion@agorria.com>
In-Reply-To: <20250731194731.287715-1-ion@agorria.com>
References: <20250731194731.287715-1-ion@agorria.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4btKP84VnDzB0Tp
X-Mailman-Approved-At: Thu, 31 Jul 2025 23:50:52 +0200
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

The Galaxy R (GT-I9103) and Captivate Glide (SGH-i927) are both Tegra 2
based Samsung smartphones released in 2011. They both feature 1 GB of RAM
and 8 GB of expandable flash memory. The key difference is that the
Captivate Glide has an OLED panel (contrary to LCD in Galaxy R) and a
QWERTY keyboard in form factor of a slider.

Signed-off-by: Ion Agorria <ion@agorria.com>
---
 arch/arm/dts/Makefile                       |   2 +
 arch/arm/dts/tegra20-samsung-bose.dts       | 119 ++++++
 arch/arm/dts/tegra20-samsung-n1-common.dtsi | 428 ++++++++++++++++++++
 arch/arm/dts/tegra20-samsung-n1.dts         | 184 +++++++++
 arch/arm/mach-tegra/tegra20/Kconfig         |   5 +
 board/samsung/n1/Kconfig                    |  13 +
 board/samsung/n1/MAINTAINERS                |   9 +
 board/samsung/n1/bose.config                |   6 +
 board/samsung/n1/n1.env                     |  16 +
 configs/n1_defconfig                        |  92 +++++
 doc/board/samsung/index.rst                 |   1 +
 doc/board/samsung/n1.rst                    |  51 +++
 12 files changed, 926 insertions(+)
 create mode 100644 arch/arm/dts/tegra20-samsung-bose.dts
 create mode 100644 arch/arm/dts/tegra20-samsung-n1-common.dtsi
 create mode 100644 arch/arm/dts/tegra20-samsung-n1.dts
 create mode 100644 board/samsung/n1/Kconfig
 create mode 100644 board/samsung/n1/MAINTAINERS
 create mode 100644 board/samsung/n1/bose.config
 create mode 100644 board/samsung/n1/n1.env
 create mode 100644 configs/n1_defconfig
 create mode 100644 doc/board/samsung/n1.rst

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 2efd866470f..ae05300bf34 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -92,6 +92,8 @@ dtb-$(CONFIG_ARCH_TEGRA) += \
 	tegra20-motorola-olympus.dtb \
 	tegra20-paz00.dtb \
 	tegra20-plutux.dtb \
+	tegra20-samsung-bose.dtb \
+	tegra20-samsung-n1.dtb \
 	tegra20-seaboard.dtb \
 	tegra20-tec.dtb \
 	tegra20-trimslice.dtb \
diff --git a/arch/arm/dts/tegra20-samsung-bose.dts b/arch/arm/dts/tegra20-samsung-bose.dts
new file mode 100644
index 00000000000..5bb9a33adf2
--- /dev/null
+++ b/arch/arm/dts/tegra20-samsung-bose.dts
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra20-samsung-n1-common.dtsi"
+
+/ {
+	model = "Samsung Captivate Glide (SGH-i927)";
+	compatible = "samsung,bose", "nvidia,tegra20";
+
+	aliases {
+		spi0 = &panel_spi;
+	};
+
+	host1x@50000000 {
+		dc@54200000 {
+			rgb {
+				status = "okay";
+
+				port {
+					dpi_output: endpoint {
+						remote-endpoint = <&panel_input>;
+						bus-width = <24>;
+					};
+				};
+			};
+		};
+	};
+
+	pinmux@70000014 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			conf-dtf {
+				nvidia,pins = "dtf", "spdi", "spib", "spih";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			conf-gpv {
+				nvidia,pins = "gpv";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			conf-kbcd {
+				nvidia,pins = "kbcd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			drive-dap {
+				nvidia,pins = "drive_dap2", "drive_dap3";
+				nvidia,high-speed-mode = <TEGRA_PIN_ENABLE>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+			};
+		};
+	};
+
+	panel_spi: spi@7000d800 {
+		status = "okay";
+		spi-max-frequency = <1000000>;
+
+		panel: panel@2 {
+			/* 480x800 AMOLED panel */
+			compatible = "samsung,bose-panel", "samsung,s6e63m0";
+			reg = <2>;
+
+			spi-max-frequency = <1000000>;
+
+			spi-cpol;
+			spi-cpha;
+
+			reset-gpios = <&gpio TEGRA_GPIO(C, 1) GPIO_ACTIVE_LOW>;
+
+			vdd3-supply = <&vlcd_1v8_reg>;
+			vci-supply = <&vlcd_3v0_reg>;
+
+			panel-width-mm = <52>;
+			panel-height-mm = <87>;
+
+			port {
+				panel_input: endpoint {
+					remote-endpoint = <&dpi_output>;
+				};
+			};
+		};
+	};
+
+	sdhci@c8000400 {
+		broken-cd;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		switch-hall {
+			label = "Keyboard Slide";
+			gpios = <&gpio TEGRA_GPIO(W, 3) GPIO_ACTIVE_HIGH>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_KEYPAD_SLIDE>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-kbd {
+			label = "Keyboard backlight";
+			gpios = <&gpio TEGRA_GPIO(L, 5) GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+};
diff --git a/arch/arm/dts/tegra20-samsung-n1-common.dtsi b/arch/arm/dts/tegra20-samsung-n1-common.dtsi
new file mode 100644
index 00000000000..8223c5ece54
--- /dev/null
+++ b/arch/arm/dts/tegra20-samsung-n1-common.dtsi
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/input/input.h>
+#include "tegra20.dtsi"
+
+/ {
+	chosen {
+		stdout-path = &uartb;
+	};
+
+	aliases {
+		i2c0 = &pwr_i2c;
+
+		mmc0 = &sdmmc4; /* eMMC */
+		mmc1 = &sdmmc3; /* uSD slot */
+
+		rtc0 = &pmic;
+		rtc1 = "/rtc@7000e000";
+
+		usb0 = &micro_usb;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x40000000>; /* 1 GB */
+	};
+
+	pinmux@70000014 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			ata {
+				nvidia,pins = "ata", "atc", "atd", "ate",
+					      "gmb", "gmd", "irrx", "irtx",
+					      "spid", "spie";
+				nvidia,function = "gmi";
+			};
+
+			atb {
+				nvidia,pins = "atb", "gma", "gme";
+				nvidia,function = "sdio4";
+			};
+
+			cdev1 {
+				nvidia,pins = "cdev1";
+				nvidia,function = "plla_out";
+			};
+
+			cdev2 {
+				nvidia,pins = "cdev2";
+				nvidia,function = "pllp_out4";
+			};
+
+			crtp {
+				nvidia,pins = "crtp";
+				nvidia,function = "crt";
+			};
+
+			csus {
+				nvidia,pins = "csus";
+				nvidia,function = "vi_sensor_clk";
+			};
+
+			dap1 {
+				nvidia,pins = "dap1";
+				nvidia,function = "dap1";
+			};
+
+			dap2 {
+				nvidia,pins = "dap2";
+				nvidia,function = "dap2";
+			};
+
+			dap3 {
+				nvidia,pins = "dap3";
+				nvidia,function = "dap3";
+			};
+
+			dap4 {
+				nvidia,pins = "dap4";
+				nvidia,function = "dap4";
+			};
+
+			ddc {
+				nvidia,pins = "ddc";
+				nvidia,function = "rsvd4";
+			};
+
+			pta {
+				nvidia,pins = "pta";
+				nvidia,function = "i2c2";
+			};
+
+			spif {
+				nvidia,pins = "spif", "uac";
+				nvidia,function = "rsvd4";
+			};
+
+			dta {
+				nvidia,pins = "dta", "dtb", "dtc", "dtd", "dte";
+				nvidia,function = "vi";
+			};
+
+			dtf {
+				nvidia,pins = "dtf";
+				nvidia,function = "i2c3";
+			};
+
+			gmc {
+				nvidia,pins = "gmc";
+				nvidia,function = "uartd";
+			};
+
+			gpu {
+				nvidia,pins = "gpu", "uaa", "uab";
+				nvidia,function = "uarta";
+			};
+
+			gpu7 {
+				nvidia,pins = "gpu7";
+				nvidia,function = "rtck";
+			};
+
+			gpv {
+				nvidia,pins = "gpv", "slxa", "slxk";
+				nvidia,function = "pcie";
+			};
+
+			hdint {
+				nvidia,pins = "hdint", "spdi", "spdo";
+				nvidia,function = "rsvd2";
+			};
+
+			i2cp {
+				nvidia,pins = "i2cp";
+				nvidia,function = "i2cp";
+			};
+
+			kbca {
+				nvidia,pins = "kbca", "kbcb", "kbcc", "kbcd",
+					      "kbce", "kbcf";
+				nvidia,function = "kbc";
+			};
+
+			lcsn {
+				nvidia,pins = "lcsn", "lsck", "lsda", "lsdi";
+				nvidia,function = "spi3";
+			};
+
+			ld0 {
+				nvidia,pins = "ld0", "ld1", "ld2", "ld3", "ld4",
+					      "ld5", "ld6", "ld7", "ld8", "ld9",
+					      "ld10", "ld11", "ld12", "ld13", "ld14",
+					      "ld15", "ld16", "ld17", "ldc", "ldi",
+					      "lhp0", "lhp1", "lhp2", "lhs", "lm0",
+					      "lm1", "lpp", "lpw0", "lpw1", "lpw2",
+					      "lsc0", "lsc1", "lspi", "lvp0", "lvp1",
+					      "lvs";
+				nvidia,function = "displaya";
+			};
+
+			owc {
+				nvidia,pins = "owc";
+				nvidia,function = "owr";
+			};
+
+			pmc {
+				nvidia,pins = "pmc";
+				nvidia,function = "pwr_on";
+			};
+
+			rm {
+				nvidia,pins = "rm";
+				nvidia,function = "i2c1";
+			};
+
+			sdb {
+				nvidia,pins = "sdb", "sdc", "sdd";
+				nvidia,function = "sdio3";
+			};
+
+			sdio1 {
+				nvidia,pins = "sdio1";
+				nvidia,function = "sdio1";
+			};
+
+			slxc {
+				nvidia,pins = "slxc", "slxd";
+				nvidia,function = "spi4";
+			};
+
+			spig {
+				nvidia,pins = "spig", "spih";
+				nvidia,function = "spi2_alt";
+			};
+
+			uad {
+				nvidia,pins = "uad";
+				nvidia,function = "irda";
+			};
+
+			uca {
+				nvidia,pins = "uca", "ucb";
+				nvidia,function = "uartc";
+			};
+
+			uda {
+				nvidia,pins = "uda";
+				nvidia,function = "spi1";
+			};
+
+			spia {
+				nvidia,pins = "spia", "spib", "spic";
+				nvidia,function = "spi2";
+			};
+
+			conf-cdev1 {
+				nvidia,pins = "cdev1", "cdev2", "dap1", "dap2",
+					      "dap3", "dap4", "ddc", "dte", "gma",
+					      "gmc", "gmd", "gme", "gpu7", "hdint",
+					      "i2cp", "lcsn", "lhs", "lm0", "lm1",
+					      "lpw1", "lsc0", "lsck", "lsda", "lsdi",
+					      "lspi", "lvs", "pmc", "pta", "rm",
+					      "sdb", "sdio1", "uac", "uda", "ck32",
+					      "ddrc", "pmca", "pmcb", "pmcc", "pmcd",
+					      "xm2c", "xm2d";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			conf-crtp {
+				nvidia,pins = "crtp", "lvp0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
+			conf-csus {
+				nvidia,pins = "csus", "spid";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
+			conf-ata {
+				nvidia,pins = "ata", "atb", "atc", "ate",
+					      "gmb", "gpu", "irrx", "irtx",
+					      "kbca", "kbcc", "kbce", "kbcf",
+					      "ldc", "lpw0", "lpw2", "lsc1", "sdc",
+					      "sdd", "spig", "uaa", "uab",
+					      "uad", "uca", "ucb", "pmce";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			conf-owc {
+				nvidia,pins = "owc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
+			conf-atd {
+				nvidia,pins = "atd", "dta", "dtb", "dtc", "dtd",
+					      "kbcb", "ld0", "ld1", "ld10", "ld11",
+					      "ld12", "ld13", "ld14", "ld15", "ld16",
+					      "ld17", "ld2", "ld3", "ld4", "ld5",
+					      "ld6", "ld7", "ld8", "ld9", "ldi",
+					      "lhp0", "lhp1", "lhp2", "lpp", "lvp1",
+					      "slxa", "slxc", "slxd", "slxk", "spdo",
+					      "spia", "spic", "spie", "spif";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			drive-ao1 {
+				nvidia,pins = "drive_ao1", "drive_at1", "drive_dbg",
+					      "drive_vi1", "drive_vi2";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+			};
+
+			drive-sdio1 {
+				nvidia,pins = "drive_sdio1";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+			};
+
+			drive-ddc {
+				nvidia,pins = "drive_ddc";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+			};
+		};
+	};
+
+	uartb: serial@70006040 {
+		clocks = <&tegra_car 7>;
+		status = "okay";
+	};
+
+	pwr_i2c: i2c@7000d000 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		pmic: max8907@3c {
+			compatible = "maxim,max8907";
+			reg = <0x3c>;
+
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			maxim,system-power-controller;
+
+			regulators {
+				vlcd_1v8_reg: ldo3 {
+					regulator-name = "vlcd_1v8";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				usb_phy_reg: ldo4 {
+					regulator-name = "vap_usb_3v3";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				vlcd_3v0_reg: ldo12 {
+					regulator-name = "vlcd_3v0";
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
+				};
+
+				vmmc_usd_reg: ldo16 {
+					regulator-name = "vmmc_usd";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+				};
+			};
+		};
+	};
+
+	micro_usb: usb@c5000000 {
+		status = "okay";
+		dr_mode = "otg";
+	};
+
+	usb-phy@c5000000 {
+		status = "okay";
+		vbus-supply = <&usb_phy_reg>;
+	};
+
+	sdmmc3: sdhci@c8000400 {
+		status = "okay";
+		bus-width = <4>;
+
+		vmmc-supply = <&vmmc_usd_reg>;
+		vqmmc-supply = <&vdd_3v3_sys>;
+	};
+
+	sdmmc4: sdhci@c8000600 {
+		status = "okay";
+		bus-width = <8>;
+		non-removable;
+
+		vmmc-supply = <&vdd_3v3_sys>;
+		vqmmc-supply = <&vdd_3v3_sys>;
+	};
+
+	/* 32KHz oscillator which is used by PMC */
+	clk32k_in: clock-32k-in {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "ref-oscillator";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-power {
+			label = "Power";
+			gpios = <&gpio TEGRA_GPIO(U, 5) GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_ENTER>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(Q, 1) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&gpio TEGRA_GPIO(Q, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+		};
+	};
+
+	vdd_3v3_sys: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_3v3_vs";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
diff --git a/arch/arm/dts/tegra20-samsung-n1.dts b/arch/arm/dts/tegra20-samsung-n1.dts
new file mode 100644
index 00000000000..930a3195aa0
--- /dev/null
+++ b/arch/arm/dts/tegra20-samsung-n1.dts
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra20-samsung-n1-common.dtsi"
+
+/ {
+	model = "Samsung Galaxy R (GT-I9103)";
+	compatible = "samsung,n1", "nvidia,tegra20";
+
+	aliases {
+		i2c10 = &cmc_i2c;
+		spi0 = &panel_spi;
+	};
+
+	host1x@50000000 {
+		dc@54200000 {
+			rgb {
+				status = "okay";
+
+				port {
+					dpi_output: endpoint {
+						remote-endpoint = <&bridge_input>;
+						bus-width = <24>;
+					};
+				};
+			};
+		};
+	};
+
+	pinmux@70000014 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			conf-dtf {
+				nvidia,pins = "dtf", "spdi", "spih";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			conf-gpv {
+				nvidia,pins = "gpv", "spib";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			conf-kbcd {
+				nvidia,pins = "kbcd";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+		};
+	};
+
+	i2c@7000d000 {
+		max8907@3c {
+			regulators {
+				vcmc623_io_1v8: ldo15 {
+					regulator-name = "vcmc623_io_1v8";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+			};
+		};
+	};
+
+	cmc_i2c: i2c-10 {
+		compatible = "i2c-gpio";
+
+		sda-gpios = <&gpio TEGRA_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		scl-gpios = <&gpio TEGRA_GPIO(C, 6) GPIO_ACTIVE_HIGH>;
+
+		i2c-gpio,scl-output-only;
+		i2c-gpio,delay-us = <1>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cmc623: bridge@38 {
+			compatible = "samsung,cmc623";
+			reg = <0x38>;
+
+			enable-gpios = <&gpio TEGRA_GPIO(Q, 4) GPIO_ACTIVE_HIGH>;
+			reset-gpios = <&gpio TEGRA_GPIO(J, 6) GPIO_ACTIVE_HIGH>;
+
+			bypass-gpios = <&gpio TEGRA_GPIO(BB, 5) GPIO_ACTIVE_LOW>;
+			sleep-gpios = <&gpio TEGRA_GPIO(W, 0) GPIO_ACTIVE_HIGH>;
+
+			vdd3v0-supply = <&vcmc623_3v0>;
+			vdd1v2-supply = <&vcmc623_1v2>;
+			vddio1v8-supply = <&vcmc623_io_1v8>;
+
+			cmc623_backlight: backlight {
+				compatible = "samsung,cmc623-backlight";
+
+				enable-gpios = <&gpio TEGRA_GPIO(R, 3) GPIO_ACTIVE_HIGH>;
+			};
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					bridge_input: endpoint {
+						remote-endpoint = <&dpi_output>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					bridge_output: endpoint {
+						remote-endpoint = <&panel_input>;
+					};
+				};
+			};
+		};
+	};
+
+	panel_spi: spi@7000d800 {
+		status = "okay";
+		spi-max-frequency = <1000000>;
+
+		panel: panel@2 {
+			/* 480x800 TFT LCD panel */
+			compatible = "sony,l4f00430t01";
+			reg = <2>;
+
+			spi-max-frequency = <1000000>;
+
+			spi-cpol;
+			spi-cpha;
+
+			reset-gpios = <&gpio TEGRA_GPIO(C, 1) GPIO_ACTIVE_LOW>;
+
+			vdd1v8-supply = <&vlcd_1v8_reg>;
+			vdd3v0-supply = <&vlcd_3v0_reg>;
+
+			panel-width-mm = <55>;
+			panel-height-mm = <91>;
+
+			backlight = <&cmc623_backlight>;
+
+			port {
+				panel_input: endpoint {
+					remote-endpoint = <&bridge_output>;
+				};
+			};
+		};
+	};
+
+	sdhci@c8000400 {
+		/* battery blocks the sdcard slot and the device lacks CD pin */
+		non-removable;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-home {
+			label = "Home";
+			gpios = <&gpio TEGRA_GPIO(O, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ENTER>;
+		};
+	};
+
+	vcmc623_3v0: regulator-cmc623-3v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcmc623_3v0";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	vcmc623_1v2: regulator-cmc623-1v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcmc623_1v2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		gpio = <&gpio TEGRA_GPIO(L, 5) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
diff --git a/arch/arm/mach-tegra/tegra20/Kconfig b/arch/arm/mach-tegra/tegra20/Kconfig
index bedbedade7b..b07b5a15585 100644
--- a/arch/arm/mach-tegra/tegra20/Kconfig
+++ b/arch/arm/mach-tegra/tegra20/Kconfig
@@ -54,6 +54,10 @@ config TARGET_SEABOARD
 	select TEGRA_LP0
 	select TEGRA_PMU
 
+config TARGET_SAMSUNG_N1
+	bool "Samsung Tegra20 N1 board"
+	select BOARD_LATE_INIT
+
 config TARGET_STAR
 	bool "LG Tegra20 Star board"
 	select BOARD_LATE_INIT
@@ -92,6 +96,7 @@ source "board/compal/paz00/Kconfig"
 source "board/acer/picasso/Kconfig"
 source "board/avionic-design/plutux/Kconfig"
 source "board/nvidia/seaboard/Kconfig"
+source "board/samsung/n1/Kconfig"
 source "board/lg/star/Kconfig"
 source "board/avionic-design/tec/Kconfig"
 source "board/asus/transformer-t20/Kconfig"
diff --git a/board/samsung/n1/Kconfig b/board/samsung/n1/Kconfig
new file mode 100644
index 00000000000..a5e5edda9e2
--- /dev/null
+++ b/board/samsung/n1/Kconfig
@@ -0,0 +1,13 @@
+if TARGET_SAMSUNG_N1
+
+config SYS_BOARD
+	default "n1"
+
+config SYS_VENDOR
+	default "samsung"
+
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "Samsung N1"
+
+endif
diff --git a/board/samsung/n1/MAINTAINERS b/board/samsung/n1/MAINTAINERS
new file mode 100644
index 00000000000..798cb56cd37
--- /dev/null
+++ b/board/samsung/n1/MAINTAINERS
@@ -0,0 +1,9 @@
+N1 BOARD
+M:	Ion Agorria <ion@agorria.com>
+M:	Svyatoslav Ryhel <clamor95@gmail.com>
+S:	Maintained
+F:	arch/arm/dts/tegra20-samsung-bose.dts
+F:	arch/arm/dts/tegra20-samsung-n1.dts
+F:	board/samsung/n1/
+F:	configs/n1_defconfig
+F:	doc/board/samsung/n1.rst
diff --git a/board/samsung/n1/bose.config b/board/samsung/n1/bose.config
new file mode 100644
index 00000000000..6d6d9d3f2ce
--- /dev/null
+++ b/board/samsung/n1/bose.config
@@ -0,0 +1,6 @@
+CONFIG_DEFAULT_DEVICE_TREE="tegra20-samsung-bose"
+CONFIG_SYS_PROMPT="Tegra20 (Bose) # "
+# CONFIG_VIDEO_BRIDGE_SAMSUNG_CMC623 is not set
+# CONFIG_BACKLIGHT_SAMSUNG_CMC623 is not set
+# CONFIG_VIDEO_LCD_SONY_L4F00430T01 is not set
+CONFIG_VIDEO_LCD_SAMSUNG_S6E63M0=y
diff --git a/board/samsung/n1/n1.env b/board/samsung/n1/n1.env
new file mode 100644
index 00000000000..e2b883dbc10
--- /dev/null
+++ b/board/samsung/n1/n1.env
@@ -0,0 +1,16 @@
+#include <env/nvidia/prod_upd.env>
+
+button_cmd_0_name=Volume Down
+button_cmd_0=bootmenu
+
+boot_block_size_r=0x80000
+boot_block_size=0x400
+boot_dev=1
+
+bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu
+bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu
+bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu
+bootmenu_3=reboot RCM=enterrcm
+bootmenu_4=reboot=reset
+bootmenu_5=power off=poweroff
+bootmenu_delay=-1
diff --git a/configs/n1_defconfig b/configs/n1_defconfig
new file mode 100644
index 00000000000..da76c59412d
--- /dev/null
+++ b/configs/n1_defconfig
@@ -0,0 +1,92 @@
+CONFIG_ARM=y
+CONFIG_ARCH_TEGRA=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_INITRD_TAG=y
+CONFIG_TEXT_BASE=0x00110000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="n1"
+CONFIG_ENV_SIZE=0x3000
+CONFIG_ENV_OFFSET=0xFFFFD000
+CONFIG_DEFAULT_DEVICE_TREE="tegra20-samsung-n1"
+CONFIG_SPL_STACK=0xffffc
+CONFIG_SPL_TEXT_BASE=0x00108000
+CONFIG_SYS_LOAD_ADDR=0x2000000
+CONFIG_TEGRA20=y
+CONFIG_TARGET_SAMSUNG_N1=y
+CONFIG_TEGRA_ENABLE_UARTB=y
+CONFIG_CMD_EBTUPDATE=y
+CONFIG_BUTTON_CMD=y
+CONFIG_BOOTDELAY=0
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_KEYED_CTRLC=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan; echo 'Boot configuration not found... Power off in 3 sec'; sleep 3; poweroff"
+CONFIG_SYS_PBSIZE=2085
+CONFIG_SPL_FOOTPRINT_LIMIT=y
+CONFIG_SPL_MAX_FOOTPRINT=0x8000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x90000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
+CONFIG_SYS_PROMPT="Tegra20 (N1) # "
+# CONFIG_CMD_BOOTEFI_BOOTMGR is not set
+CONFIG_CMD_BOOTMENU=y
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_GPT_RENAME=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_UMS_ABORT_KEYED=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_PAUSE=y
+CONFIG_CMD_EXT4_WRITE=y
+# CONFIG_SPL_DOS_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_BUTTON=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x11000000
+CONFIG_FASTBOOT_BUF_SIZE=0x5000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
+CONFIG_DM_I2C_GPIO=y
+CONFIG_SYS_I2C_TEGRA=y
+CONFIG_BUTTON_KEYBOARD=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_MAX8907=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_MAX8907=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SYS_NS16550=y
+CONFIG_TEGRA20_SLINK=y
+CONFIG_SYSRESET_MAX8907=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_TEGRA=y
+CONFIG_USB_ULPI_VIEWPORT=y
+CONFIG_USB_ULPI=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Samsung"
+CONFIG_USB_GADGET_VENDOR_NUM=0x04e8
+CONFIG_USB_GADGET_PRODUCT_NUM=0x685F
+CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_LOGO is not set
+# CONFIG_VIDEO_BPP8 is not set
+CONFIG_VIDEO_BRIDGE=y
+CONFIG_VIDEO_TEGRA=y
+CONFIG_VIDEO_BRIDGE_SAMSUNG_CMC623=y
+CONFIG_BACKLIGHT_SAMSUNG_CMC623=y
+CONFIG_VIDEO_LCD_SONY_L4F00430T01=y
diff --git a/doc/board/samsung/index.rst b/doc/board/samsung/index.rst
index a1c9636b050..1b92c9518a5 100644
--- a/doc/board/samsung/index.rst
+++ b/doc/board/samsung/index.rst
@@ -8,3 +8,4 @@ Samsung
 
    axy17lte
    e850-96
+   n1
diff --git a/doc/board/samsung/n1.rst b/doc/board/samsung/n1.rst
new file mode 100644
index 00000000000..4dbb3141774
--- /dev/null
+++ b/doc/board/samsung/n1.rst
@@ -0,0 +1,51 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for the Samsung N1 device family
+=======================================
+
+``DISCLAMER!`` Moving your Samsung Galaxy R (GT-I9103) or Samsung Captivate Glide
+(SGH-i927) to use U-Boot assumes replacement of the sboot. Vendor android firmwares
+will no longer be able to run on the device. This replacement IS reversible.
+
+Quick Start
+-----------
+
+- Build U-Boot
+- Boot
+
+Build U-Boot
+------------
+
+Device support is implemented by applying config fragment to a generic board
+defconfig. Generic board defconfig is suitable for Samsung Galaxy R (GT-I9103)
+while Samsung Captivate Glide (SGH-i927) support is provided by applying
+``bose.config`` fragment.
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=arm-none-eabi-
+    $ make n1_defconfig bose.config # For Captivate Glide
+    $ make
+
+After the build succeeds, you will obtain the final ``u-boot-dtb-tegra.bin``
+image, ready for further processing.
+
+Boot
+----
+
+Currently, U-Boot can be preloaded into RAM via the NvFlash. To enter
+RCM protocol use ``home`` and ``volume up`` for Galaxy R and ``volume down``
+and ``volume up`` Captivate Glide key combination plus plugging usb in.
+The host PC should recognize an APX device.
+
+Built U-Boot ``u-boot-dtb-tegra.bin`` can be loaded from fusee-tools
+directory with
+
+.. code-block:: bash
+
+    $ ./utils/nvflash_t20 --setbct --bct ./bct/i927.bct --configfile ./utils/flash.cfg --bl u-boot-dtb-tegra.bin --sbk (in form of 0xABCDABCD 4 times) --sync # For Captivate Glide
+
+To boot Linux, U-Boot will look for an ``extlinux.conf`` on MicroSD and then on
+eMMC. Additionally, if the Volume Down button is pressed while loading, the
+device will enter bootmenu. Bootmenu contains entries to mount MicroSD and eMMC
+as mass storage, fastboot, reboot, reboot RCM and poweroff.
-- 
2.50.0

