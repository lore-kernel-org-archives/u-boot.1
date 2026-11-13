Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358E606A321
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SWnpVktM;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=NNtYXGoy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C95260ED3;
	Fri, 13 Nov 2026 02:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QC6FWIJhZsGB; Fri, 13 Nov 2026 02:35:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7480460ED9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537308;
	b=qbBf0gBuG4AjAXjYhp0YNjnZa1cr+BtG8Z9TS3cam4Pq3PQnXhMQl+02DrgAnOpZX1WY
	 SeFifMllXtVTm+XjtmcY3Viegwdsk+UT5nYhgDSPS+RzPlYM8+2DDepKEja1fc32taXPi
	 xL4yYvGjVDMAeV/zXJ45/wwphrsHVFzuJjNbBHSYNDEf3US1GOVtOAv/P+L8ZRvLvMCGD
	 nJaG55Za4D12Nql0T2QQOzhELKc7qyi+IYRxuJqtGqSckQO6KDaeP4VIXAFxsy0dYWEPo
	 W40/CQGQbEDfF1FFHRvT34I1HNhjO+gnenheI02BoEfluPMhDMxLFMULY+9ddGDz65Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537308;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MeNt44g1y1QM4XHEnKgnBoQVNa08rw5d8BKYUmWLltw=;
	b=fwrl2koTLzKe2bgXRk75dSnEHBvGkxh606XvTX8IEW6e6U898kHEE3FqNGRjiGuq8yH+
	 DlTMJkyfWN2bwHrwUM5N+huR8XhQFuBlAf1kpZr7cY/Q3FOHveD7QffYQbQT5LvqMqyGH
	 2Z+cnWVaoqHn5e0YeF/Emgu9cdDIXv70uyDGYpvgfzOQqoK5qSJq/wlU11XGTUTbG3G6W
	 /gVDeSHq9obQxEM6T1jzJI+f+ATZGyK/TTnLgk/I6QKWV3cawN8tynUpJlFwWHLw4Axuk
	 /edA8aTnomv/i7akp0OHbzkh0JKH/fBwC+OZ/5C9ohBG96+1uV6XGmisbN9NTXM1Ftg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537308;
	bh=MeNt44g1y1QM4XHEnKgnBoQVNa08rw5d8BKYUmWLltw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SWnpVktMERAQI2QfARLS35Rv0tL/lY7qgvAF1tC4BwjG4/OS2MXlZukjybaE+a7Nb
	 CwvJ8Rm7UmMjLPpeegUDHt40k6ZGrSfkItBDwmqtc2ItxhWHvVq4oXYYlqRZjeCfus
	 8EZTOuDMMnD2luL9w/fslo0FSorxYETD71QxyK6xEXhz99C9ckgQCDmjnfv/gmCR4w
	 DGPfRaLj0ns7p8x5p24Jxams1Gsw97UboTzu+I1dfSiaC/fVTxulNxbkOvONStR81x
	 SR3iPLhD8DSZ6AtD5NdqPU0dkl10jdH3RLHoXovQjiniGOrlaTEm2dh/1/G0xNJkMf
	 x2nwJnf3SNAEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7480460ED9;
	Fri, 13 Nov 2026 02:35:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 04E7F1790
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF02940082
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:35:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8AGOdxGzps6k for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:35:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E2B39401BE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=NNtYXGoy
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E2B39401BE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:35:04 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id BA5244C8CD;
 Fri, 13 Nov 2026 13:34:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MeNt44g1y1QM4XHEnKgnBoQVNa08rw5d8BKYUmWLltw=;
 b=NNtYXGoyw/4iO2xF4Vo7HcWvG7sNNNrLoR650fWkQEtwnV5cWDsu3d2rXOCOL9CwBnAf9t
 X+3+5F1XQMl4It2twhkFeGhy0BU+ZAQpnBAsBUtnO6Yvr9YZZJKJD43bgn4Db9noKDPTBm
 h9rDbg4O0nZ9TQ0zpduPGlEZ+eNsQBIGrpl495bIg6Tf/X2DAPomDjxesywZ9z/LmGpPlk
 uOrLNH2z51SjwkbDbOMfhNK1Sqf6VyLhwfqai103WliyUfEJoHVftX3YjyZ0SIwOatSK56
 W3SkElx8bakqGW79cFAHnqvRiinaVzO9w15jMEu8KFdDMayw5Yuys3fHsdkuDg==
X-GPT-Reason: The email is classified as legitimate, personal/professional
 correspondence. (a) The mailbox (alastair@d-silva.org) aligns
 perfectly with the sender (alastair@d-silva.org), establishing
 a high-confidence identity match. (b) The content is a technical
 patch for a Linux kernel/U-Boot project regarding Orange Pi board
 support, which is consistent with a developer's professional activities.
 (c) The From domain matches the recipient's domain, and there are
 no phishing red flags, such as urgency, suspicious links, or requests
 for credentials.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 26/26] sunxi: Add Xunlong Orange Pi 4 Pro board support
Date: Fri, 13 Nov 2026 13:32:36 +1100
Message-ID: <20261113023236.569054-27-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add initial U-Boot board support and defconfig for the Xunlong Orange Pi 4
Pro single-board computer based on the Allwinner A733 SoC:

- Allwinner A733 octa-core SoC (6x Cortex-A55 + 2x Cortex-A76)
- 4 GiB / 6 GiB / 8 GiB / 16 GiB LPDDR5 at 3600 MT/s
- X-Powers AXP318W PMIC on R-I2C0 (PL0/PL1)
- MicroSD slot on MMC0 and optional eMMC module on MMC2 (HS200)
- USB 2.0 host port on EHCI1/OHCI1
- Debug UART0 console on PB0/PB1 (115200 8N1)
- M.2 Key-M PCIe Gen3 x1 NVMe slot via Combo PHY 1 and 3.3V regulator

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/arm/dts/Makefile                       |   2 +
 arch/arm/dts/sun60i-a733-orangepi-4-pro.dts | 237 ++++++++++++++++++++
 board/sunxi/MAINTAINERS                     |   6 +
 configs/orangepi_4_pro_defconfig            |  36 +++
 4 files changed, 281 insertions(+)
 create mode 100644 arch/arm/dts/sun60i-a733-orangepi-4-pro.dts
 create mode 100644 configs/orangepi_4_pro_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index cf4674042a2..a89021b6b79 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -657,6 +657,8 @@ dtb-$(CONFIG_MACH_SUN50I) += \
 	sun50i-a64-pinetab.dtb \
 	sun50i-a64-sopine-baseboard.dtb \
 	sun50i-a64-teres-i.dtb
+dtb-$(CONFIG_MACH_SUN60I_A733) += \
+	sun60i-a733-orangepi-4-pro.dtb
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-cx-a99.dtb
 
diff --git a/arch/arm/dts/sun60i-a733-orangepi-4-pro.dts b/arch/arm/dts/sun60i-a733-orangepi-4-pro.dts
new file mode 100644
index 00000000000..819d3b1c4c3
--- /dev/null
+++ b/arch/arm/dts/sun60i-a733-orangepi-4-pro.dts
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (C) 2026 Alastair D'Silva <alastair@d-silva.org>
+ */
+
+/dts-v1/;
+
+#include "sun60i-a733.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Xunlong Orange Pi 4 Pro";
+	compatible = "xunlong,orangepi-4-pro", "allwinner,sun60i-a733";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reg_vcc5v: regulator-vcc5v {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_usb1_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&reg_vcc5v>;
+		gpios = <&pio 1 8 GPIO_ACTIVE_HIGH>; /* PB8 */
+		enable-active-high;
+	};
+
+	reg_vcc3v3_pcie: regulator-vcc3v3-pcie {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3-pcie";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&r_pio 0 3 GPIO_ACTIVE_HIGH>; /* PL3 */
+		enable-active-high;
+	};
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&combophy1 {
+	status = "okay";
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_swout2>;
+	cd-gpios = <&pio 5 6 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PF6 */
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>, <&mmc2_rst_pin>;
+	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_bldo1>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&osc {
+	clock-frequency = <24000000>;
+};
+
+&pcie_rc {
+	vpcie3v3-supply = <&reg_vcc3v3_pcie>;
+	reset-gpios = <&pio 3 22 GPIO_ACTIVE_LOW>; /* PD22 */
+	status = "okay";
+};
+
+&pio {
+	vcc-pb-supply = <&reg_dcdc1>;
+	vcc-pc-supply = <&reg_bldo1>;
+	vcc-pf-supply = <&reg_dcdc1>;
+	vcc-pg-supply = <&reg_bldo1>;
+	vcc-pj-supply = <&reg_bldo2>;
+	vcc-pk-supply = <&reg_bldo1>;
+};
+
+&r_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&r_i2c0_pl_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	axp318w: pmic@36 {
+		compatible = "x-powers,axp318w";
+		reg = <0x36>;
+
+		regulators {
+			reg_dcdc1: dcdc1 {
+				regulator-name = "vcc-io";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			reg_dcdc2: dcdc2 {
+				regulator-name = "vdd-cpul";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-always-on;
+			};
+
+			reg_dcdc3: dcdc3 {
+				regulator-name = "vdd-cpub";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-always-on;
+			};
+
+			reg_dcdc4: dcdc4 {
+				regulator-name = "vdd-gpu";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+			};
+
+			reg_dcdc5: dcdc5 {
+				regulator-name = "vdd-sys";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+			};
+
+			reg_dcdc6: dcdc6 {
+				regulator-name = "vddq-lpddr5";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <600000>;
+				regulator-always-on;
+			};
+
+			reg_dcdc7: dcdc7 {
+				regulator-name = "vdd2-lpddr5";
+				regulator-min-microvolt = <1050000>;
+				regulator-max-microvolt = <1120000>;
+				regulator-always-on;
+			};
+
+			reg_bldo1: bldo1 {
+				regulator-name = "vcc-1v8-io";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			reg_bldo2: bldo2 {
+				regulator-name = "vdd1-lpddr5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			reg_bldo4: bldo4 {
+				regulator-name = "vcc-1v8-audio";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			reg_dldo1: dldo1 {
+				regulator-name = "vcc-sd";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			reg_eldo1: eldo1 {
+				regulator-name = "vdd2h-lpddr5";
+				regulator-min-microvolt = <1050000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+			};
+
+			reg_swout1: swout1 {
+				regulator-name = "vcc-ephy";
+				regulator-always-on;
+			};
+
+			reg_swout2: swout2 {
+				regulator-name = "vcc-gmac-io";
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&r_pio {
+	vcc-pm-supply = <&reg_bldo1>;
+};
+
+/* Optional onboard SPI NOR flash footprint; unpopulated on standard SKUs. */
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pc_pins>;
+	status = "disabled";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb0_pins>;
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index 344f52ea325..a42c89c1304 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -443,6 +443,12 @@ M:	Andre Heider <a.heider@gmail.com>
 S:	Maintained
 F:	configs/orangepi_3_defconfig
 
+ORANGEPI 4 PRO BOARD
+M:	Alastair D'Silva <alastair@d-silva.org>
+S:	Maintained
+F:	arch/arm/dts/sun60i-a733-orangepi-4-pro.dts
+F:	configs/orangepi_4_pro_defconfig
+
 ORANGEPI 4A BOARD
 M:	Chen-Yu Tsai <wens@kernel.org>
 S:	Maintained
diff --git a/configs/orangepi_4_pro_defconfig b/configs/orangepi_4_pro_defconfig
new file mode 100644
index 00000000000..5f620a533a0
--- /dev/null
+++ b/configs/orangepi_4_pro_defconfig
@@ -0,0 +1,36 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun60i-a733-orangepi-4-pro"
+CONFIG_SPL=y
+CONFIG_DRAM_SUN60I_A733_PIN_SWIZZLE=y
+CONFIG_MACH_SUN60I_A733=y
+CONFIG_UART0_PORT_B0=y
+CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_R_I2C_ENABLE=y
+CONFIG_PCI=y
+CONFIG_SPL_I2C=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_SYS_I2C_SLAVE=0x7f
+CONFIG_SYS_I2C_SPEED=400000
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_SUNXI=y
+CONFIG_PHY_SUN60I_COMBOPHY=y
+CONFIG_REGULATOR_AXP=y
+CONFIG_AXP_DCDC1_VOLT=3300
+CONFIG_AXP_DCDC2_VOLT=800
+CONFIG_AXP_DCDC3_VOLT=1050
+CONFIG_AXP_DCDC4_VOLT=800
+CONFIG_AXP_DCDC5_VOLT=1000
+CONFIG_AXP_DCDC6_VOLT=560
+CONFIG_AXP_DCDC7_VOLT=1080
+CONFIG_AXP_BLDO1_VOLT=1800
+CONFIG_AXP_BLDO2_VOLT=1800
+CONFIG_AXP_BLDO4_VOLT=1800
+CONFIG_AXP_DLDO1_VOLT=3300
+CONFIG_AXP_ELDO1_VOLT=1075
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
-- 
2.53.0

