Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CBBCD1288
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 18:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 432828831E;
	Mon,  1 Apr 2024 20:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mkH5AFGF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6F7C88311; Mon,  1 Apr 2024 20:18:02 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 998FF88328
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 20:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6e2c45b81d8so1406166a34.0
 for <u-boot@lists.denx.de>; Mon, 01 Apr 2024 11:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711995475; x=1712600275; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M3eBYHoXVkBQXTi4L1QMNz8dOnDZ+iHdukw3DNljlOs=;
 b=mkH5AFGFJn1d2W0XZ9X3qOEjY4f2gFR5uGQL8MhiH4B3k3SAYwPvEQmAmYMuD+ZeiY
 f5HskpeSSCvmNHJB9fnudFlE1Qwbl05Yxtg+IwxGhoejwHSC3hNdkeWiZJDYK7p/vfEX
 5RQ/JJg9xEWr0yNjfhPG0tT+3/zk8oGyarod9kunqcCJ3CHkZhyW49mmt81R1bLMYBVm
 JSNTwodRMDrvjfHyRKmBLYxlsDTCx3Cik2doqzXtOiXT9H1WUboH/fp1fLSfL88zLH63
 3MmHW7/3qaOoKLk5jftQ5pX/h1uNZlZxRlFee3+UcDVj9cN9aT+fFhw+icqh70OGqAHZ
 F3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711995475; x=1712600275;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M3eBYHoXVkBQXTi4L1QMNz8dOnDZ+iHdukw3DNljlOs=;
 b=jh29WpxNwB1saFZ8vE78t8nzdfIb7SweDnp8/WFFqrk24GHdr0vckIf67B+xIrFQRe
 pE0IL9Kn422HaMmjwGiuFcYlFOPIdJPTNK2TkxfWCD06HWCTvZdauUQrv8hd7FZEWPsS
 ZIAZ9G+nx/nl0OfFtMhwcsCUOPzRugjAW3U0w4Crf8gK2KItQtaiBcgMuYPaEEpSuJ2R
 B1eSaQdAHcYLQq2l+W7+WzNaxATKBCToBqLIxx9ZjfmaQTDyYpnBiITF1uGzV91PZ+jX
 1npFjSezHX4aYfhqRMyGowWzyyJRVAKE3RlHasb10RIvZjR8B+jMiDWztbO/CzMqnRds
 qwaw==
X-Gm-Message-State: AOJu0YwsqzmBtwkT8cc4SYSBq+C8+TkwqxmFWOstK15LIFZZAId1siga
 jY8Pvq78wukrX6IHgT/IPabe8EqEhzlVFqQz5e5lMLP9I3dX/rAtXutOxEU9
X-Google-Smtp-Source: AGHT+IEzWjjYuWr3y6oQUaPsoahJqN1bjiE2b9jywis6L4iD2Fzso1NuPCUfhV6AIw0tPz3AAEv1pQ==
X-Received: by 2002:a9d:7d98:0:b0:6e8:9ad3:1e67 with SMTP id
 j24-20020a9d7d98000000b006e89ad31e67mr1596459otn.19.1711995474919; 
 Mon, 01 Apr 2024 11:17:54 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 bm8-20020a056820188800b005a13ead482bsm2425190oob.12.2024.04.01.11.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Apr 2024 11:17:54 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: jonas@kwiboo.se, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH] board: rockchip: Add Indiedroid Nova
Date: Mon,  1 Apr 2024 13:17:50 -0500
Message-Id: <20240401181750.553682-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Chris Morgan <macromorgan@hotmail.com>

The Indiedroid Nova is a Rockchip RK3588S based SBC from Indiedroid.

Specifications:

    Rockchip RK3588S SoC
    4x ARM Cortex-A76, 4x ARM Cortex-A55
    4/8/16GB memory LPDDR4x
    Mali G610MC4 GPU
    Optional eMMC
    2x USB 2.0, 2x USB 3.0, 1x USB 3.0 C port with DP Alt
    1x MIPI-CSI Port (4-lane or 2x 2-lane)
    1x MIPI-DSI 4-lane connector
    1x Micro HDMI 2.1 output, 1x DP 1.4 output
    Gigabit Ethernet
    Realtek RTL8821CS WiFi
    4 pin debug UART connector
    40 pin GPIO header
    Size: 85mm x 56mm (Raspberry Pi Form Factor)

Kernel commit:
3900160e164b ("arm64: dts: rockchip: Add Indiedroid Nova board")

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/dts/Makefile                         |   1 +
 .../dts/rk3588s-indiedroid-nova-u-boot.dtsi   |  11 +
 arch/arm/dts/rk3588s-indiedroid-nova.dts      | 853 ++++++++++++++++++
 arch/arm/mach-rockchip/rk3588/Kconfig         |   7 +
 board/indiedroid/nova/Kconfig                 |  15 +
 board/indiedroid/nova/MAINTAINERS             |   8 +
 configs/indiedroid-nova-rk3588s_defconfig     | 106 +++
 include/configs/indiedroid-nova.h             |  15 +
 8 files changed, 1016 insertions(+)
 create mode 100644 arch/arm/dts/rk3588s-indiedroid-nova-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588s-indiedroid-nova.dts
 create mode 100644 board/indiedroid/nova/Kconfig
 create mode 100644 board/indiedroid/nova/MAINTAINERS
 create mode 100644 configs/indiedroid-nova-rk3588s_defconfig
 create mode 100644 include/configs/indiedroid-nova.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index b102ffb5f6..0af2986610 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -194,6 +194,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3588) += \
 	rk3588-edgeble-neu6a-io.dtb \
 	rk3588-edgeble-neu6b-io.dtb \
 	rk3588-evb1-v10.dtb \
+	rk3588s-indiedroid-nova.dtb \
 	rk3588-nanopc-t6.dtb \
 	rk3588s-orangepi-5.dtb \
 	rk3588-orangepi-5-plus.dtb \
diff --git a/arch/arm/dts/rk3588s-indiedroid-nova-u-boot.dtsi b/arch/arm/dts/rk3588s-indiedroid-nova-u-boot.dtsi
new file mode 100644
index 0000000000..16ded31fa5
--- /dev/null
+++ b/arch/arm/dts/rk3588s-indiedroid-nova-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Collabora Ltd.
+ */
+
+#include "rk3588-u-boot.dtsi"
+#include <dt-bindings/usb/pd.h>
+
+&rng {
+	status = "okay";
+};
diff --git a/arch/arm/dts/rk3588s-indiedroid-nova.dts b/arch/arm/dts/rk3588s-indiedroid-nova.dts
new file mode 100644
index 0000000000..253f163960
--- /dev/null
+++ b/arch/arm/dts/rk3588s-indiedroid-nova.dts
@@ -0,0 +1,853 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/usb/pd.h>
+#include "rk3588s.dtsi"
+
+/ {
+	model = "Indiedroid Nova";
+	compatible = "indiedroid,nova", "rockchip,rk3588s";
+
+	adc-keys-0 {
+		compatible = "adc-keys";
+		io-channel-names = "buttons";
+		io-channels = <&saradc 0>;
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		button-boot {
+			label = "boot";
+			linux,code = <KEY_PROG1>;
+			press-threshold-microvolt = <18000>;
+		};
+	};
+
+	adc-keys-1 {
+		compatible = "adc-keys";
+		io-channel-names = "buttons";
+		io-channels = <&saradc 1>;
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		button-recovery {
+			label = "recovery";
+			linux,code = <KEY_PROG2>;
+			press-threshold-microvolt = <18000>;
+		};
+	};
+
+	aliases {
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
+		mmc2 = &sdio;
+	};
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clock-names = "ext_clock";
+		clocks = <&rtc_hym8563>;
+		pinctrl-0 = <&wifi_enable_h>;
+		pinctrl-names = "default";
+		post-power-on-delay-ms = <200>;
+		reset-gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_LOW>;
+	};
+
+	sound {
+		compatible = "audio-graph-card";
+		label = "rockchip,es8388-codec";
+		widgets = "Microphone", "Mic Jack",
+			  "Headphone", "Headphones";
+		routing = "LINPUT2", "Mic Jack",
+			  "Headphones", "LOUT1",
+			  "Headphones", "ROUT1";
+		dais = <&i2s0_8ch_p0>;
+	};
+
+	vbus5v0_typec: vbus5v0-typec-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&typec5v_pwren>;
+		pinctrl-names = "default";
+		regulator-name = "vbus5v0_typec";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+
+	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <1100000>;
+		regulator-min-microvolt = <1100000>;
+		regulator-name = "vcc_1v1_nldo_s3";
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	/* Regulator is enabled whenever vcc_1v8_s0 is above 1.6v */
+	vcc_3v3_s0: vcc-3v3-s0-regulator {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "vcc_3v3_s0";
+		vin-supply = <&vcc_3v3_s3>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vcc5v0_sys: vcc5v0-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "vcc5v0_sys";
+	};
+
+	vcc5v0_usb: vcc5v0-usb-regulator {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "vcc5v0_usb";
+		vin-supply = <&vcc5v0_usbdcin>;
+	};
+
+	vcc5v0_usbdcin: vcc5v0-usbdcin-regulator {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "vcc5v0_usbdcin";
+	};
+};
+
+&combphy0_ps {
+	status = "okay";
+};
+
+&combphy2_psu {
+	status = "okay";
+};
+
+&cpu_l0 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l1 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l2 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l3 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_b0 {
+	cpu-supply = <&vdd_cpu_big0_s0>;
+};
+
+&cpu_b1 {
+	cpu-supply = <&vdd_cpu_big0_s0>;
+};
+
+&cpu_b2 {
+	cpu-supply = <&vdd_cpu_big1_s0>;
+};
+
+&cpu_b3 {
+	cpu-supply = <&vdd_cpu_big1_s0>;
+};
+
+/*
+ * Add labels for each GPIO pin exposed on the 40 pin header. Note that
+ * voltage of each GPIO pin could be either 3.3v or 1.8v (as noted by
+ * label).
+ */
+&gpio0 {
+	gpio-line-names = /* GPIO0 A0-A7 */
+			  "", "", "", "",
+			  "", "", "", "",
+			  /* GPIO0 B0-B7 */
+			  "", "", "", "",
+			  "", "", "", "",
+			  /* GPIO0 C0-C7 */
+			  "", "", "", "",
+			  "", "", "", "",
+			  /* GPIO0 D0-D7 */
+			  "HEADER_12_1v8", "", "", "HEADER_24_1v8",
+			  "", "", "", "";
+};
+
+&gpio1 {
+	gpio-line-names = /* GPIO1 A0-A7 */
+			  "HEADER_27_3v3", "", "", "",
+			  "HEADER_29_1v8", "", "HEADER_7_1v8", "",
+			  /* GPIO1 B0-B7 */
+			  "", "HEADER_31_1v8", "HEADER_33_1v8", "",
+			  "HEADER_11_1v8", "HEADER_13_1v8", "", "",
+			  /* GPIO1 C0-C7 */
+			  "", "HEADER_28_3v3", "", "",
+			  "", "", "", "",
+			  /* GPIO1 D0-D7 */
+			  "", "", "", "",
+			  "", "", "HEADER_5_3v3", "HEADER_3_3v3";
+};
+
+&gpio3 {
+	gpio-line-names = /* GPIO3 A0-A7 */
+			  "", "", "", "",
+			  "", "", "", "",
+			  /* GPIO3 B0-B7 */
+			  "HEADER_16_1v8", "HEADER_18_1v8", "", "",
+			  "", "", "", "HEADER_19_1v8",
+			  /* GPIO3 C0-C7 */
+			  "HEADER_21_1v8", "HEADER_23_1v8", "", "HEADER_26_1v8",
+			  "HEADER_15_1v8", "HEADER_22_1v8", "", "",
+			  /* GPIO3 D0-D7 */
+			  "", "", "", "",
+			  "", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names = /* GPIO4 A0-A7 */
+			  "", "", "HEADER_37_3v3", "HEADER_8_3v3",
+			  "HEADER_10_3v3", "", "HEADER_32_3v3", "HEADER_35_3v3",
+			  /* GPIO4 B0-B7 */
+			  "", "", "", "HEADER_40_3v3",
+			  "HEADER_38_3v3", "HEADER_36_3v3", "", "",
+			  /* GPIO4 C0-C7 */
+			  "", "", "", "",
+			  "", "", "", "",
+			  /* GPIO4 D0-D7 */
+			  "", "", "", "",
+			  "", "", "", "";
+};
+
+&i2c0 {
+	pinctrl-0 = <&i2c0m2_xfer>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	vdd_cpu_big0_s0: regulator@42 {
+		compatible = "rockchip,rk8602";
+		reg = <0x42>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <1050000>;
+		regulator-min-microvolt = <550000>;
+		regulator-name = "vdd_cpu_big0_s0";
+		regulator-ramp-delay = <2300>;
+		fcs,suspend-voltage-selector = <1>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vdd_cpu_big1_s0: regulator@43 {
+		compatible = "rockchip,rk8603", "rockchip,rk8602";
+		reg = <0x43>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <1050000>;
+		regulator-min-microvolt = <550000>;
+		regulator-name = "vdd_cpu_big1_s0";
+		regulator-ramp-delay = <2300>;
+		fcs,suspend-voltage-selector = <1>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	vdd_npu_s0: regulator@42 {
+		compatible = "rockchip,rk8602";
+		reg = <0x42>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <950000>;
+		regulator-min-microvolt = <550000>;
+		regulator-name = "vdd_npu_s0";
+		regulator-ramp-delay = <2300>;
+		fcs,suspend-voltage-selector = <1>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+};
+
+&i2c6 {
+	pinctrl-0 = <&i2c6m3_xfer>;
+	status = "okay";
+
+	fusb302: typec-portc@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PC4 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&usbc0_int>;
+		pinctrl-names = "default";
+		vbus-supply = <&vbus5v0_typec>;
+
+		connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USB-C";
+			power-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 1000, PDO_FIXED_USB_COMM)>;
+			op-sink-microwatt = <1000000>;
+		};
+	};
+
+	rtc_hym8563: rtc@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		clock-output-names = "hym8563";
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&hym8563_int>;
+		pinctrl-names = "default";
+		wakeup-source;
+	};
+};
+
+&i2c7 {
+	pinctrl-0 = <&i2c7m0_xfer>;
+	status = "okay";
+
+	es8388: audio-codec@11 {
+		compatible = "everest,es8388";
+		reg = <0x11>;
+		assigned-clock-rates = <12288000>;
+		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
+		AVDD-supply = <&vcc_3v3_s3>;
+		clock-names = "mclk";
+		clocks = <&cru I2S0_8CH_MCLKOUT>;
+		DVDD-supply = <&vcc_1v8_s3>;
+		HPVDD-supply = <&vcc_3v3_s3>;
+		PVDD-supply = <&vcc_1v8_s3>;
+		#sound-dai-cells = <0>;
+
+		port {
+			es8388_p0_0: endpoint {
+				remote-endpoint = <&i2s0_8ch_p0_0>;
+			};
+		};
+	};
+};
+
+&i2s0_8ch {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s0_lrck
+		     &i2s0_mclk
+		     &i2s0_sclk
+		     &i2s0_sdi0
+		     &i2s0_sdo0>;
+	status = "okay";
+
+	i2s0_8ch_p0: port {
+		i2s0_8ch_p0_0: endpoint {
+			dai-format = "i2s";
+			mclk-fs = <256>;
+			remote-endpoint = <&es8388_p0_0>;
+		};
+	};
+};
+
+&pcie2x1l2 {
+	pinctrl-0 = <&rtl8111_perstb>;
+	pinctrl-names = "default";
+	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&pinctrl {
+	bluetooth-pins {
+		bt_reset: bt-reset {
+			rockchip,pins =
+				<0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_wake_dev: bt-wake-dev {
+			rockchip,pins =
+				<0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_wake_host: bt-wake-host {
+			rockchip,pins =
+				<0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	ethernet-pins {
+		rtl8111_perstb: rtl8111-perstb {
+			rockchip,pins = <3 RK_PD1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	hym8563 {
+
+		hym8563_int: hym8563-int {
+			rockchip,pins =
+				<0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins =
+				<0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb-typec {
+		usbc0_int: usbc0-int {
+			rockchip,pins =
+				<0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		typec5v_pwren: typec5v-pwren {
+			rockchip,pins =
+				<4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&saradc {
+	vref-supply = <&vcca_1v8_s0>;
+	status = "okay";
+};
+
+/* HS400 modes seemed to cause io errors. */
+&sdhci {
+	bus-width = <8>;
+	no-mmc-hs400;
+	no-sd;
+	no-sdio;
+	non-removable;
+	vmmc-supply = <&vcc_3v3_s0>;
+	vqmmc-supply = <&vcc_1v8_s3>;
+	status = "okay";
+};
+
+&sdio {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	disable-wp;
+	keep-power-in-suspend;
+	max-frequency = <100000000>;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	no-mmc;
+	no-sd;
+	non-removable;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc_3v3_s3>;
+	vqmmc-supply = <&vcc_1v8_s3>;
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	no-sdio;
+	no-mmc;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc_3v3_s3>;
+	vqmmc-supply = <&vccio_sd_s0>;
+	status = "okay";
+};
+
+&spi2 {
+	#address-cells = <1>;
+	assigned-clocks = <&cru CLK_SPI2>;
+	assigned-clock-rates = <200000000>;
+	num-cs = <1>;
+	pinctrl-0 = <&spi2m2_pins>, <&spi2m2_cs0>;
+	pinctrl-names = "default";
+	#size-cells = <0>;
+	status = "okay";
+
+	pmic@0 {
+		compatible = "rockchip,rk806";
+		reg = <0x0>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA7 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
+			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
+		pinctrl-names = "default";
+		spi-max-frequency = <1000000>;
+
+		vcc1-supply = <&vcc5v0_sys>;
+		vcc2-supply = <&vcc5v0_sys>;
+		vcc3-supply = <&vcc5v0_sys>;
+		vcc4-supply = <&vcc5v0_sys>;
+		vcc5-supply = <&vcc5v0_sys>;
+		vcc6-supply = <&vcc5v0_sys>;
+		vcc7-supply = <&vcc5v0_sys>;
+		vcc8-supply = <&vcc5v0_sys>;
+		vcc9-supply = <&vcc5v0_sys>;
+		vcc10-supply = <&vcc5v0_sys>;
+		vcc11-supply = <&vcc_2v0_pldo_s3>;
+		vcc12-supply = <&vcc5v0_sys>;
+		vcc13-supply = <&vcc_1v1_nldo_s3>;
+		vcc14-supply = <&vcc_1v1_nldo_s3>;
+		vcca-supply = <&vcc5v0_sys>;
+
+		rk806_dvs1_null: dvs1-null-pins {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun0";
+		};
+
+		rk806_dvs2_null: dvs2-null-pins {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun0";
+		};
+
+		rk806_dvs3_null: dvs3-null-pins {
+			pins = "gpio_pwrctrl3";
+			function = "pin_fun0";
+		};
+
+		regulators {
+			vdd_gpu_s0: dcdc-reg1 {
+				regulator-boot-on;
+				regulator-enable-ramp-delay = <400>;
+				regulator-max-microvolt = <950000>;
+				regulator-min-microvolt = <550000>;
+				regulator-name = "vdd_gpu_s0";
+				regulator-ramp-delay = <12500>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_cpu_lit_s0: dcdc-reg2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <950000>;
+				regulator-min-microvolt = <550000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_cpu_lit_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_logic_s0: dcdc-reg3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <750000>;
+				regulator-min-microvolt = <675000>;
+				regulator-name = "vdd_logic_s0";
+				regulator-ramp-delay = <12500>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <750000>;
+				};
+			};
+
+			vdd_vdenc_s0: dcdc-reg4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <950000>;
+				regulator-min-microvolt = <550000>;
+				regulator-name = "vdd_vdenc_s0";
+				regulator-ramp-delay = <12500>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_ddr_s0: dcdc-reg5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <850000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_ddr_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <850000>;
+				};
+			};
+
+			vdd2_ddr_s3: dcdc-reg6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1100000>;
+				regulator-min-microvolt = <1100000>;
+				regulator-name = "vdd2_ddr_s3";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_2v0_pldo_s3: dcdc-reg7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <2000000>;
+				regulator-min-microvolt = <2000000>;
+				regulator-name = "vdd_2v0_pldo_s3";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <2000000>;
+				};
+			};
+
+			vcc_3v3_s3: dcdc-reg8 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-name = "vcc_3v3_s3";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vddq_ddr_s0: dcdc-reg9 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <600000>;
+				regulator-min-microvolt = <600000>;
+				regulator-name = "vddq_ddr_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8_s3: dcdc-reg10 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "vcc_1v8_s3";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcc_1v8_s0: pldo-reg1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "vcc_1v8_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca_1v8_s0: pldo-reg2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "vcca_1v8_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdda_1v2_s0: pldo-reg3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1200000>;
+				regulator-min-microvolt = <1200000>;
+				regulator-name = "vdda_1v2_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca_3v3_s0: pldo-reg4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-name = "vcca_3v3_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd_s0: pldo-reg5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "vccio_sd_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8_s3_pldo6: pldo-reg6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "vcc_1v8_s3_pldo6";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdd_0v75_s3: nldo-reg1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <750000>;
+				regulator-min-microvolt = <750000>;
+				regulator-name = "vdd_0v75_s3";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <750000>;
+				};
+			};
+
+			vdda_ddr_pll_s0: nldo-reg2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <850000>;
+				regulator-min-microvolt = <850000>;
+				regulator-name = "vdda_ddr_pll_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <850000>;
+				};
+			};
+
+			avdd_0v75_s0: nldo-reg3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <750000>;
+				regulator-min-microvolt = <750000>;
+				regulator-name = "avdd_0v75_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_0v85_s0: nldo-reg4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-name = "vdda_0v85_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			/* Schematics show not in use */
+			nldo-reg5 {
+			};
+		};
+	};
+};
+
+&tsadc {
+	status = "okay";
+};
+
+&u2phy2 {
+	status = "okay";
+};
+
+&u2phy2_host {
+	phy-supply = <&vcc5v0_usb>;
+	status = "okay";
+};
+
+&u2phy3 {
+	status = "okay";
+};
+
+&u2phy3_host {
+	phy-supply = <&vcc5v0_usb>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-0 = <&uart2m0_xfer>;
+	status = "okay";
+};
+
+/* DMA seems to interfere with bluetooth device normal operation. */
+&uart9 {
+	pinctrl-0 = <&uart9m2_xfer>, <&uart9m2_ctsn>, <&uart9m2_rtsn>;
+	pinctrl-names = "default";
+	/delete-property/ dma-names;
+	/delete-property/ dmas;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8821cs-bt",
+			     "realtek,rtl8723bs-bt";
+		device-wake-gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
+		host-wake-gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&bt_reset>, <&bt_wake_dev>, <&bt_wake_host>;
+		pinctrl-names = "default";
+	};
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usb_host2_xhci {
+	status = "okay";
+};
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index a2193fbd41..d8aad0ea54 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -51,6 +51,12 @@ config TARGET_NANOPCT6_RK3588
 	  Power: 5.5*2.1mm DC Jack, 12VDC input
 	  Dimensions: 110x80x1.6mm (without case) / 86x114.5x30mm (with case)
 
+config TARGET_RK3588_INDIEDROID_NOVA
+	bool "Indiedroid Nova RK3588"
+	select BOARD_LATE_INIT
+	help
+	  Indiedroid Nova is a Rockchip RK3588s based SBC by Indiedroid.
+
 config TARGET_RK3588_NEU6
 	bool "Edgeble Neural Compute Module 6(Neu6) SoM"
 	select BOARD_LATE_INIT
@@ -169,6 +175,7 @@ config SYS_MALLOC_F_LEN
 
 source board/edgeble/neural-compute-module-6/Kconfig
 source board/friendlyelec/nanopc-t6-rk3588/Kconfig
+source board/indiedroid/nova/Kconfig
 source board/pine64/quartzpro64-rk3588/Kconfig
 source board/turing/turing-rk1-rk3588/Kconfig
 source board/rockchip/evb_rk3588/Kconfig
diff --git a/board/indiedroid/nova/Kconfig b/board/indiedroid/nova/Kconfig
new file mode 100644
index 0000000000..d652eec46f
--- /dev/null
+++ b/board/indiedroid/nova/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_RK3588_INDIEDROID_NOVA
+
+config SYS_BOARD
+	default "nova"
+
+config SYS_VENDOR
+	default "indiedroid"
+
+config SYS_CONFIG_NAME
+	default "indiedroid-nova"
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+
+endif
diff --git a/board/indiedroid/nova/MAINTAINERS b/board/indiedroid/nova/MAINTAINERS
new file mode 100644
index 0000000000..4adc6ee1a9
--- /dev/null
+++ b/board/indiedroid/nova/MAINTAINERS
@@ -0,0 +1,8 @@
+INDIEDROID-NOVA-RK3588
+M:	Chris Morgan <macromorgan@hotmail.com>
+S:	Maintained
+F:	board/indiedroid/nova
+F:	include/configs/indiedroid-nova.h
+F:	configs/indiedroid-nova-rk3588_defconfig
+F:	arch/arm/dts/rk3588s-indiedroid-nova.dts
+F:	arch/arm/dts/rk3588s-indiedroid-nova-u-boot.dtsi
diff --git a/configs/indiedroid-nova-rk3588s_defconfig b/configs/indiedroid-nova-rk3588s_defconfig
new file mode 100644
index 0000000000..efcca7b49e
--- /dev/null
+++ b/configs/indiedroid-nova-rk3588s_defconfig
@@ -0,0 +1,106 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_TEXT_BASE=0x00a00000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=10
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
+CONFIG_SF_DEFAULT_SPEED=24000000
+CONFIG_SF_DEFAULT_MODE=0x2000
+CONFIG_DEFAULT_DEVICE_TREE="rk3588s-indiedroid-nova"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK_R_ADDR=0x600000
+CONFIG_TARGET_RK3588_INDIEDROID_NOVA=y
+CONFIG_SPL_STACK=0x400000
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-indiedroid-nova.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x4000000
+CONFIG_SPL_BSS_MAX_SIZE=0x4000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+# CONFIG_SPI_FLASH is not set
+CONFIG_SF_DEFAULT_BUS=5
+CONFIG_PHYLIB=y
+CONFIG_RTL8169=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_ASIX88179=y
+CONFIG_USB_ETHER_LAN75XX=y
+CONFIG_USB_ETHER_LAN78XX=y
+CONFIG_USB_ETHER_MCS7830=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_PRODUCT_NUM=0x350b
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_ERRNO_STR=y
diff --git a/include/configs/indiedroid-nova.h b/include/configs/indiedroid-nova.h
new file mode 100644
index 0000000000..c74e5022f6
--- /dev/null
+++ b/include/configs/indiedroid-nova.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2022 Collabora Ltd.
+ */
+
+#ifndef __INDIEDROID_NOVA_H
+#define __INDIEDROID_NOVA_H
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
+#include <configs/rk3588_common.h>
+
+#endif /* __INDIEDROID_NOVA_H */
-- 
2.34.1

