Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931D2C47077
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 01:31:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8A1787509;
	Wed, 10 Jan 2024 02:30:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=verizon.net header.i=@verizon.net header.b="qMyLC445";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3790C87463; Wed, 10 Jan 2024 02:30:58 +0100 (CET)
Received: from sonic317-21.consmr.mail.gq1.yahoo.com
 (sonic317-21.consmr.mail.gq1.yahoo.com [98.137.66.147])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8F6E87729
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 02:30:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jjriek@verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048;
 t=1704850248; bh=3cb0eFa5EMBH6hj4Xxg9HnuEkBjPoja0Q1P1jySBdiM=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=qMyLC445oeP8lCV12Yp7XNyuwTqo7LHsifzj0uTbWbUoqqy8FTiNcZtibXAicWSZL2tPEwiKAdFEOpNlYqlS98eB/+hO0i3xrwbApS8iHenwZJNtO5Y5Qi/5qPnRsqrmaMtdsxnY8juD/mVyOo/ufwM/hriBHD1m+M2UsIQoKfDUbiSWOmMZibaRIbAtlIFMgUzyL6/YLeL8L0dYala8bmZGvEGSxiuV82nsmTPZwCQH1SJKE5FPMxiwsgHBL2z/AmbK+0d2pxLOX48izwC0Adp1Q6Airt/OFSGxVNqBQGiNI6Veby3G9r/hVUzkcMTMukO4YUKkrqiSRjaD5Ekf+Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1704850248; bh=abqeMlfZI9nPTCVbOyid7DiNccmIHQU8txAAgpy39a4=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=lrxEMHc5ga7fC5SjoLAMwp5YKxnh3GNbYqwUkDgxGDNCUzZ9vDPGMW8qOcLh4MHD2s1gdBiSg+LiYa15v/hE5Hv8ZY24c0LLDBI7K3LHlcwG1+4zQxi4WfmzCeslu3XZXiL4EjtqG3lqjCi2MhyWX2fhH6aF1ts92Jj9h4CL8VU9XoYOVkP1v8WWwPBOCx547gzolhjMZ/q+Fa7J9FOtIExXbe1ICW6BFz+xbDTQdeCuFRGbCnLjqLQu4jIxurstksVPFS1Cliw4q6zQvTw/OIddc9f8ghm9b+J/0RwFLi/fNj9TN/mt9TkDo5VmyxxHy+KfOPAblzKWpywoqlVXpA==
X-YMail-OSG: d4XSmsQVM1mbSkbrWaTQ95A4ZOtRj39ZeaVI0nHDhh.xp3eltwzEKPvEzO5zfZN
 cTKyJ.1R7IPegbFLLEMn1LISKStNWuXI5gPh6wRvSUDDD9fE3y42Lfl6DZJ9CUdZBwBpez8kh7MD
 2HEGFaekznii1h79lIapzv8KDtdp_hQmphakMryu0yybvO7tbzzvNfZFum9WVHfDiB8wu7r0P4st
 4ILEY8TocixGQMYBvgVvPyFrGqQ3S_qVB.kZJT5XAP5YJ096sJjFPRp1BeCkU948_qcYG296M15A
 dql9HQUdLossnkQsTPWabsN18eklh2fIluWtqxqJa8Rpep7geELplbMowYGYIOn00CFz7DFHgvmk
 kpGaA56mdjernuEc0v15q0_Y0ssOMmZNtDljBWyST5zTO6HqdJ4L1CjXIo8TDxCgAkaq0W7CEt6k
 a8fHgO_tgw1BHoVFrch6vEYTvD5fTPrrUs_kKNlmkxllI4ZSwsavXtJz4lhE1xo_inHe3ABBSXFF
 7bfdG4sTyxeDevUEtiK0HguBroQBDiNwe534zFoEtAqSKujR1wdPdDJjrEMLuFmP1afSIkZRvf3D
 rab575cpAastKAPxaONwKqYQkZOz9DLwc0IFtnDGuVls60U0bE3U13wefOxR6ZByMFw3yw0.6rlb
 4cRR888w5PuMDyJmpGRnnuOqyWywTqwQ_jz_.zsYot8n6nJLwGCgd_f7GY15VxwOz6ZS0dmKRl8H
 ccOrmVXm3kpu2es444idFdu8W9nMHi7JhgjdAW689aTcYXXN1cSdcgbVN3wun0VRLuCCQlx1gxDj
 MSeni9RN6f2oh196mUbYbg2GC9kVd5C6KaV4xpjwWo8yTQ0huW_efpqLpsELuljvVeuBbyxKPWQL
 ioB_7HGYR9bnGkOFasT7.7bj1zmD7W7rBjP50nScD_HDuy_t4d1JqDgOmoTXr6VJXS6OffUiIl27
 GUVMfddaVxZ6JpSPve6y3q5CUhzAb37rnnIZ1zxctsPi8siEBBDfEskve6snvFPT94sZ_ftr7Psm
 CSPEBEchbRipjYsvzIda0BS3173lWmoyNArXDknu4lazgAIEV3SgPidmstuHzbS9GwmAxpFe4yAJ
 10oqcw6ufi7Pb5PfCYpLunAHBUiSvAD9JqvfAqDshs93D2Jg1YENa.07OaRmgVHZ1yFucMg.JgGA
 z7utfTBArFrgGTYP6f5hNDQ5yZk_g0dijcxNQuLeKdV2LDrV5HdMygcyLDUF21m09Mlxcy7PvmRz
 Dl3.tQ9.buzQivbZL1FMYIn90BtJwPo2ict2WzpbUeZ3VNY8Ijnj84_XHGi6DzGj4WcN7M9ErsaR
 CLUTl4T4U8jHtpoQZKtFX71bWdQGL_rXWXdNByh1Lk2MTKJbq6XPkQ71oEoz2Hgnkne.xc6UVIXI
 ds5qMI9dvBKyuYDLHx.cvq.JuG4mA3HNG5s1KQ3GTIOvaH6S0uthsZDtdsZiVdnCB8DBYX3bRB9a
 km4SJf3FRrLfouoY9UFXjTCzLgETjUlGN6Zh.e_BneojML73JmPvQpc2dSBjBvJsV6W7zhP2kE6e
 EUTkTqGg7nzK4EHwMhLi6pp52iR7Etw8lfFiTLPHbBKdI.nafbvtzg6l3PgtM_tsm89mzm8kLLpg
 ACyUj64hTc4T6thCOT86hSrGjGA9C19AgMzzfGyhgRYQVPshoTFbpPAmZb3pAx0sHVn99LSjttGx
 DK1sNYL10Ax3zoIDRh6ZNO_GwIuKjqyn0y6N598yASK1wx4ZjxJqTm_JxIyFY2Uspaim4YxppjwN
 YKzuEylxpwitg3.wmMUzdDx9swQySaBHJCzpK7Z18nXsnmlQXGTejxIEX2gxTCmNC9UFjZMhYk.n
 OYt0saK4eJaxpaL8Raoy0vCZVnJzNB5m2svhO_dx0d2pyRVHxAo_mJ0ZSRQiSiIM7O7APF5HCO8S
 LHJsviBEHk5xvk0SWzmqggCxl.PodeT.XNVJPyq.aJJGYLGzQ28eyFMigoA3qqGBNh8hEPimN09q
 Lu5ZdtPwWcp2IzDYdJ6oMz7Rly0o.5zvrD4P3BAB0Lbdfz78YN.YHC_bm4GdBBPbnfXrztAScdg2
 QE5GEhyqTaB_KYz3j_I6hTB1pJ8_VBitLLpEFek0_dfVQe0cIg0Gw05MA.WYfSNK9UiXfVUjPPkp
 4Bob7CwY_oBgSL3mOp3BY4FxA7t2Xjsc3XR3M.7Hqo9TxhHKX6IfSFh5FkJGfrpETlNEdai5IGAp
 iu3eEsTkyUIv1csvP_Qr9FeLEHnayRe_dYAWDddsHDTyRwaYseWM0hhUVVtffYWnWpXJjXo9OrjN
 0eUXb
X-Sonic-MF: <jjriek@verizon.net>
X-Sonic-ID: 07e23a58-8fb4-40b4-936d-9b430c396f84
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Wed, 10 Jan 2024 01:30:48 +0000
Received: by hermes--production-bf1-6745f7c55c-6hpmf (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 1b7fec7786c196761e7bbace80c4cfdc; 
 Wed, 10 Jan 2024 01:30:44 +0000 (UTC)
From: Joshua Riek <jjriek@verizon.net>
To: Joshua Riek <jjriek@verizon.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Sam Edwards <CFSworks@gmail.com>, Jagan Teki <jagan@edgeble.ai>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de
Subject: [RESEND PATCH v2] board: rockchip: Add the Turing RK1 SoM
Date: Tue,  9 Jan 2024 20:30:24 -0500
Message-Id: <20240110013025.2406007-1-jjriek@verizon.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20240110013025.2406007-1-jjriek.ref@verizon.net>
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

The Turing RK1 is a Rockchip RK3588 based SoM from Turing Machines.

Specifications:

    Rockchip RK3588 SoC
    4x ARM Cortex-A76, 4x ARM Cortex-A55
    8/16/32GB memory LPDDR4x
    Mali G610MC4 GPU
    32GB eMMC HS400
    2x USB 2.0, 2x USB 3.0
    2x MIPI CSI 4x lanes
    1x MIPI-DSI DPHY 2x lanes
    PCIe 2.0 x1, PCIe 3.0 x4
    1x HDMI 2.1 output, 1x DP 1.4 output
    Gigabit Ethernet
    Size: 69.6mm x 45mm (260-pin SO-DIMM connector)

Kernel commit:
2806a69f3fef ("arm64: dts: rockchip: Add Turing RK1 SoM support")

Signed-off-by: Joshua Riek <jjriek@verizon.net>
Tested-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
Changes in v2:
- removed BOOT_TARGET #ifdef ... #endif in the RK1 header file
---
 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi    |  25 +
 arch/arm/dts/rk3588-turing-rk1.dts            |  21 +
 arch/arm/dts/rk3588-turing-rk1.dtsi           | 614 ++++++++++++++++++
 arch/arm/mach-rockchip/rk3588/Kconfig         |  24 +
 board/turing/turing-rk1-rk3588/Kconfig        |  15 +
 board/turing/turing-rk1-rk3588/MAINTAINERS    |   9 +
 board/turing/turing-rk1-rk3588/Makefile       |   6 +
 .../turing-rk1-rk3588/turing-rk1-rk3588.c     |  39 ++
 configs/turing-rk1-rk3588_defconfig           | 133 ++++
 doc/board/rockchip/rockchip.rst               |   1 +
 include/configs/turing-rk1-rk3588.h           |  15 +
 12 files changed, 903 insertions(+)
 create mode 100644 arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-turing-rk1.dts
 create mode 100644 arch/arm/dts/rk3588-turing-rk1.dtsi
 create mode 100644 board/turing/turing-rk1-rk3588/Kconfig
 create mode 100644 board/turing/turing-rk1-rk3588/MAINTAINERS
 create mode 100644 board/turing/turing-rk1-rk3588/Makefile
 create mode 100644 board/turing/turing-rk1-rk3588/turing-rk1-rk3588.c
 create mode 100644 configs/turing-rk1-rk3588_defconfig
 create mode 100644 include/configs/turing-rk1-rk3588.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 1be08c5fdc..97355d84de 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -195,6 +195,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3588) += \
 	rk3588s-orangepi-5.dtb \
 	rk3588-orangepi-5-plus.dtb \
 	rk3588-quartzpro64.dtb \
+	rk3588-turing-rk1.dtb \
 	rk3588s-rock-5a.dtb \
 	rk3588-rock-5b.dtb
 
diff --git a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
new file mode 100644
index 0000000000..06c6f327c1
--- /dev/null
+++ b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Joshua Riek <jjriek@verizon.net>
+ *
+ */
+
+#include "rk3588-u-boot.dtsi"
+
+/ {
+	chosen {
+		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
+	};
+};
+
+&sdhci {
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+};
+
+&uart9 {
+	bootph-pre-ram;
+	clock-frequency = <24000000>;
+	status = "okay";
+};
diff --git a/arch/arm/dts/rk3588-turing-rk1.dts b/arch/arm/dts/rk3588-turing-rk1.dts
new file mode 100644
index 0000000000..7bcad28d73
--- /dev/null
+++ b/arch/arm/dts/rk3588-turing-rk1.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * This device tree covers the common case where the RK1 is used as a
+ * "compute node" system, where the carrier board is functioning more like a
+ * generic backplane (with no non-autoenumerable peripherals of its own) than
+ * like a device that the SoM is meant to enable.
+ *
+ * Copyright (c) 2023 Sam Edwards <CFSworks@gmail.com>
+ */
+
+/dts-v1/;
+#include "rk3588-turing-rk1.dtsi"
+
+/ {
+	model = "Turing Machines RK1";
+	compatible = "turing,rk1", "rockchip,rk3588";
+
+	chosen {
+		stdout-path = "serial9:115200n8";
+	};
+};
diff --git a/arch/arm/dts/rk3588-turing-rk1.dtsi b/arch/arm/dts/rk3588-turing-rk1.dtsi
new file mode 100644
index 0000000000..9570b34aca
--- /dev/null
+++ b/arch/arm/dts/rk3588-turing-rk1.dtsi
@@ -0,0 +1,614 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device tree definitions for the Turing RK1 SoM.
+ *
+ * Copyright (c) 2023 Sam Edwards <CFSworks@gmail.com>
+ *
+ * Based on RK3588-EVB1 devicetree
+ * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
+ */
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include "rk3588.dtsi"
+
+/ {
+	compatible = "turing,rk1", "rockchip,rk3588";
+
+	aliases {
+		ethernet0 = &gmac1;
+		mmc0 = &sdhci;
+		serial2 = &uart2;
+		serial9 = &uart9;
+	};
+
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		cooling-levels = <0 25 95 145 195 255>;
+		fan-supply = <&vcc5v0_sys>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm0m2_pins &fan_int>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA4 IRQ_TYPE_EDGE_FALLING>;
+		pwms = <&pwm0 0 50000 0>;
+		#cooling-cells = <2>;
+	};
+
+	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pcie30";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpios = <&gpio2 RK_PC5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc3v3_pcie30_en>;
+		startup-delay-us = <5000>;
+	};
+
+	vcc5v0_sys: vcc5v0-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v1_nldo_s3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+};
+
+&combphy2_psu {
+	status = "okay";
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
+&gmac1 {
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy>;
+	phy-mode = "rgmii-rxid";
+	pinctrl-0 = <&gmac1_miim
+		     &gmac1_tx_bus2
+		     &gmac1_rx_bus2
+		     &gmac1_rgmii_clk
+		     &gmac1_rgmii_bus>;
+	pinctrl-names = "default";
+	rx_delay = <0x00>;
+	tx_delay = <0x43>;
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0m2_xfer>;
+	status = "okay";
+
+	vdd_cpu_big0_s0: regulator@42 {
+		compatible = "rockchip,rk8602";
+		reg = <0x42>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu_big0_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <1050000>;
+		regulator-ramp-delay = <2300>;
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
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu_big1_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <1050000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1m2_xfer>;
+	status = "okay";
+
+	vdd_npu_s0: regulator@42 {
+		compatible = "rockchip,rk8602";
+		reg = <0x42>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_npu_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <950000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	hym8563: rtc@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		clock-output-names = "hym8563";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hym8563_int>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
+		wakeup-source;
+	};
+};
+
+&mdio1 {
+	rgmii_phy: ethernet-phy@1 {
+		/* RTL8211F */
+		compatible = "ethernet-phy-id001c.c916",
+			     "ethernet-phy-ieee802.3-c22";
+		reg = <0x1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtl8211f_rst>;
+		reset-assert-us = <15000>;
+		reset-deassert-us = <50000>;
+		reset-gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pcie2x1l1 {
+	linux,pci-domain = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_reset>;
+	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&pcie30phy {
+	status = "okay";
+};
+
+&pcie3x4 {
+	linux,pci-domain = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie3_reset>;
+	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie30>;
+	status = "okay";
+};
+
+&pinctrl {
+	fan {
+		fan_int: fan-int {
+			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pcie2 {
+		pcie2_reset: pcie2-reset {
+			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pcie3 {
+		pcie3_reset: pcie3-reset {
+			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		vcc3v3_pcie30_en: pcie3-reg {
+			rockchip,pins = <2 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	rtl8211f {
+		rtl8211f_rst: rtl8211f-rst {
+			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pwm0 {
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	no-sdio;
+	no-sd;
+	non-removable;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	status = "okay";
+};
+
+&spi2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
+	num-cs = <1>;
+
+	pmic@0 {
+		compatible = "rockchip,rk806";
+		spi-max-frequency = <1000000>;
+		reg = <0x0>;
+
+		interrupt-parent = <&gpio0>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
+			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
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
+		gpio-controller;
+		#gpio-cells = <2>;
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
+			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_gpu_s0";
+				regulator-enable-ramp-delay = <400>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_cpu_lit_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_log_s0: dcdc-reg3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <675000>;
+				regulator-max-microvolt = <750000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_log_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <750000>;
+				};
+			};
+
+			vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_vdenc_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_ddr_s0: dcdc-reg5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <675000>;
+				regulator-max-microvolt = <900000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_ddr_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <850000>;
+				};
+			};
+
+			vdd2_ddr_s3: dcdc-reg6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vdd2_ddr_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_2v0_pldo_s3: dcdc-reg7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <2000000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_2v0_pldo_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <2000000>;
+				};
+			};
+
+			vcc_3v3_s3: dcdc-reg8 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc_3v3_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vddq_ddr_s0: dcdc-reg9 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vddq_ddr_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8_s3: dcdc-reg10 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_1v8_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			avcc_1v8_s0: pldo-reg1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "avcc_1v8_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8_s0: pldo-reg2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_1v8_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			avdd_1v2_s0: pldo-reg3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-name = "avdd_1v2_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_3v3_s0: pldo-reg4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vcc_3v3_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd_s0: pldo-reg5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vccio_sd_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			pldo6_s3: pldo-reg6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "pldo6_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdd_0v75_s3: nldo-reg1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+				regulator-name = "vdd_0v75_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <750000>;
+				};
+			};
+
+			vdd_ddr_pll_s0: nldo-reg2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-name = "vdd_ddr_pll_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <850000>;
+				};
+			};
+
+			avdd_0v75_s0: nldo-reg3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+				regulator-name = "avdd_0v75_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_0v85_s0: nldo-reg4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-name = "vdd_0v85_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_0v75_s0: nldo-reg5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+				regulator-name = "vdd_0v75_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&uart2 {
+	pinctrl-0 = <&uart2m0_xfer>;
+	status = "okay";
+};
+
+&uart9 {
+	pinctrl-0 = <&uart9m0_xfer>;
+	status = "okay";
+};
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index e5282dd112..a2193fbd41 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -132,6 +132,29 @@ config TARGET_QUARTZPRO64_RK3588
 	  Pine64 QuartzPro64 is a Rockchip RK3588 based SBC (Single Board
 	  Computer) by Pine64.
 
+config TARGET_TURINGRK1_RK3588
+	bool "Turing Machines RK1 RK3588 board"
+	select BOARD_LATE_INIT
+	help
+	  The Turing RK1 is a Rockchip RK3588 based SoM from Turing Machines.
+
+	  There are three variants depending on the DRAM size : 8G, 16G and 32G.
+
+	  Specifications:
+
+	  Rockchip RK3588 SoC
+	  4x ARM Cortex-A76, 4x ARM Cortex-A55
+	  8/16/32GB memory LPDDR4x
+	  Mali G610MC4 GPU
+	  32GB eMMC HS400
+	  2x USB 2.0, 2x USB 3.0
+	  2x MIPI CSI 4x lanes
+	  1x MIPI-DSI DPHY 2x lanes
+	  PCIe 2.0 x1, PCIe 3.0 x4
+	  1x HDMI 2.1 output, 1x DP 1.4 output
+	  Gigabit Ethernet
+	  Size: 69.6mm x 45mm (260-pin SO-DIMM connector)
+
 config ROCKCHIP_BOOT_MODE_REG
 	default 0xfd588080
 
@@ -147,6 +170,7 @@ config SYS_MALLOC_F_LEN
 source board/edgeble/neural-compute-module-6/Kconfig
 source board/friendlyelec/nanopc-t6-rk3588/Kconfig
 source board/pine64/quartzpro64-rk3588/Kconfig
+source board/turing/turing-rk1-rk3588/Kconfig
 source board/rockchip/evb_rk3588/Kconfig
 source board/radxa/rock5a-rk3588s/Kconfig
 source board/radxa/rock5b-rk3588/Kconfig
diff --git a/board/turing/turing-rk1-rk3588/Kconfig b/board/turing/turing-rk1-rk3588/Kconfig
new file mode 100644
index 0000000000..4c6cd6af34
--- /dev/null
+++ b/board/turing/turing-rk1-rk3588/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_TURINGRK1_RK3588
+
+config SYS_BOARD
+	default "turing-rk1-rk3588"
+
+config SYS_VENDOR
+	default "turing"
+
+config SYS_CONFIG_NAME
+	default "turing-rk1-rk3588"
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+
+endif
diff --git a/board/turing/turing-rk1-rk3588/MAINTAINERS b/board/turing/turing-rk1-rk3588/MAINTAINERS
new file mode 100644
index 0000000000..4f313732fa
--- /dev/null
+++ b/board/turing/turing-rk1-rk3588/MAINTAINERS
@@ -0,0 +1,9 @@
+TURINGRK1-RK3588
+M:	Joshua Riek <jjriek@verizon.net>
+S:	Maintained
+F:	board/turing/turing-rk1-rk3588
+F:	include/configs/turing-rk1-rk3588.h
+F:	configs/turing-rk1-rk3588_defconfig
+F:	arch/arm/dts/rk3588-turing-rk1.dts
+F:	arch/arm/dts/rk3588-turing-rk1.dtsi
+F:	arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
diff --git a/board/turing/turing-rk1-rk3588/Makefile b/board/turing/turing-rk1-rk3588/Makefile
new file mode 100644
index 0000000000..a979d8023a
--- /dev/null
+++ b/board/turing/turing-rk1-rk3588/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier:     GPL-2.0+
+#
+# Copyright (c) 2023 Rockchip Electronics Co,. Ltd.
+#
+
+obj-y += turing-rk1-rk3588.o
diff --git a/board/turing/turing-rk1-rk3588/turing-rk1-rk3588.c b/board/turing/turing-rk1-rk3588/turing-rk1-rk3588.c
new file mode 100644
index 0000000000..e2338a2a35
--- /dev/null
+++ b/board/turing/turing-rk1-rk3588/turing-rk1-rk3588.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 Rockchip Electronics Co,. Ltd.
+ */
+
+#include <fdtdec.h>
+#include <fdt_support.h>
+
+#ifdef CONFIG_OF_BOARD_SETUP
+int turing_rk1_add_reserved_memory_fdt_nodes(void *new_blob)
+{
+	struct fdt_memory gap1 = {
+		.start = 0x3fc000000,
+		.end = 0x3fc4fffff,
+	};
+	struct fdt_memory gap2 = {
+		.start = 0x3fff00000,
+		.end = 0x3ffffffff,
+	};
+	unsigned long flags = FDTDEC_RESERVED_MEMORY_NO_MAP;
+	unsigned int ret;
+
+	/*
+	 * Inject the reserved-memory nodes into the DTS
+	 */
+	ret = fdtdec_add_reserved_memory(new_blob, "gap1", &gap1,  NULL, 0,
+					 NULL, flags);
+	if (ret)
+		return ret;
+
+	return fdtdec_add_reserved_memory(new_blob, "gap2", &gap2,  NULL, 0,
+					  NULL, flags);
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return turing_rk1_add_reserved_memory_fdt_nodes(blob);
+}
+#endif
diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
new file mode 100644
index 0000000000..289f2da775
--- /dev/null
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -0,0 +1,133 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_TEXT_BASE=0x00a00000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
+CONFIG_SF_DEFAULT_SPEED=24000000
+CONFIG_SF_DEFAULT_MODE=0x2000
+CONFIG_DEFAULT_DEVICE_TREE="rk3588-turing-rk1"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK_R_ADDR=0x600000
+CONFIG_TARGET_TURINGRK1_RK3588=y
+CONFIG_SPL_STACK=0x400000
+CONFIG_DEBUG_UART_BASE=0xFEBC0000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-turing-rk1.dtb"
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
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_SCSI=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_TFTPSRV=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SATA=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
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
+CONFIG_SF_DEFAULT_BUS=5
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_XTX=y
+CONFIG_SPI_FLASH_XMC=y
+CONFIG_PHYLIB=y
+CONFIG_RTL8169=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_SCSI=y
+CONFIG_DM_SCSI=y
+CONFIG_BAUDRATE=115200
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SFC=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_XHCI_PCI=y
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
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 18d0b6f089..9fe69fc942 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -117,6 +117,7 @@ List of mainline supported Rockchip boards:
      - Edgeble Neural Compute Module 6B SoM - Neu6b (neu6b-io-rk3588)
      - FriendlyElec NanoPC-T6 (nanopc-t6-rk3588)
      - Pine64 QuartzPro64 (quartzpro64-rk3588)
+     - Turing Machines RK1 (turing-rk1-rk3588)
      - Radxa ROCK 5A (rock5a-rk3588s)
      - Radxa ROCK 5B (rock5b-rk3588)
      - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
diff --git a/include/configs/turing-rk1-rk3588.h b/include/configs/turing-rk1-rk3588.h
new file mode 100644
index 0000000000..760f3c6ab3
--- /dev/null
+++ b/include/configs/turing-rk1-rk3588.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 Rockchip Electronics Co., Ltd.
+ */
+
+#ifndef __TURINGRK1_RK3588_H
+#define __TURINGRK1_RK3588_H
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
+#include <configs/rk3588_common.h>
+
+#endif /* __TURINGRK1_RK3588_H */
