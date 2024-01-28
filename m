Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BBBC47DA9
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 15:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C22A28800F;
	Sun, 28 Jan 2024 16:56:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TUZXlqZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6290A87F05; Sun, 28 Jan 2024 16:55:59 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FC3587DED
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 16:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TNGHZ1lsNz9stm;
 Sun, 28 Jan 2024 16:55:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1706457354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5c8moh8EqSTYClNiZkFWQomZxlFAWrC1vCoo+fok1fA=;
 b=TUZXlqZgIN6ZllS7hUezpX+Pc/dhhRUYr8rsspJ9g+5N51qVnOmlbLiitSjbBHD3M6Vimy
 r/xDh/srtKrgknQrXxtJ+ItLS8ObEOvvSdFKrsk5mtpa2BnEYV79G/MDKb8J9mcDntScRy
 ANcKC5292oifHqo9blSpWZ3x1IiyPtZtlTHyjK9tQrgj4Z7arCurYLZyZNkfTLeGKctKhx
 oQJAU9qTmCWCXbs2Cnam79hoBsZHg7wodzBq4tt8ZAUThd1Qq3X2MeTnHwRpLJw4d9YsDP
 2iqUqvbeSbbpOQpLiJNDQ4V2h2v8ZIs6M9jwzqpA8bBcGT7D7tsNDBcdJ3imVg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH v2 10/11] ARM: dts: renesas: Add Renesas Gray Hawk boards
 support
Date: Sun, 28 Jan 2024 16:52:08 +0100
Message-ID: <20240128155458.56712-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
References: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d057cb519b6eabb032f
X-MBO-RS-META: 4ra7ua6i8tje8k64jatcgzfz77zottyg
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

From: Hai Pham <hai.pham.ud@renesas.com>

Initial support for the Renesas Gray Hawk CPU and BreakOut boards.

The arch/arm/dts/r8a779h0-gray-hawk-cpu.dtsi is extended version of:
https://lore.kernel.org/linux-renesas-soc/b657402113267acd57aece0b4c681b707e704455.1706194617.git.geert+renesas@glider.be/
The version currenty submitted upstream lacks functionality which is
present in this series. Once the upstream support implements that
missing functionality, these DTs will be updated to match.

Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
---
V2: Update to version submitted to Linux kernel upstream
---
 arch/arm/dts/r8a779h0-gray-hawk-cpu.dtsi      | 166 ++++++++++++++++++
 arch/arm/dts/r8a779h0-gray-hawk-csi-dsi.dtsi  |  15 ++
 arch/arm/dts/r8a779h0-gray-hawk-ethernet.dtsi |  15 ++
 arch/arm/dts/r8a779h0-gray-hawk.dts           |  25 +++
 4 files changed, 221 insertions(+)
 create mode 100644 arch/arm/dts/r8a779h0-gray-hawk-cpu.dtsi
 create mode 100644 arch/arm/dts/r8a779h0-gray-hawk-csi-dsi.dtsi
 create mode 100644 arch/arm/dts/r8a779h0-gray-hawk-ethernet.dtsi
 create mode 100644 arch/arm/dts/r8a779h0-gray-hawk.dts

diff --git a/arch/arm/dts/r8a779h0-gray-hawk-cpu.dtsi b/arch/arm/dts/r8a779h0-gray-hawk-cpu.dtsi
new file mode 100644
index 00000000000..c8a46219826
--- /dev/null
+++ b/arch/arm/dts/r8a779h0-gray-hawk-cpu.dtsi
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the Gray Hawk CPU board
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+#include "r8a779h0.dtsi"
+
+/ {
+	model = "Renesas Gray Hawk CPU board";
+	compatible = "renesas,grayhawk-cpu", "renesas,r8a779h0";
+
+	aliases {
+		ethernet0 = &avb0;
+		serial0 = &hscif0;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial0:921600n8";
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
+		reg = <0x4 0x80000000 0x1 0x80000000>;
+	};
+
+	reg_1p8v: regulator-1p8v {
+			compatible = "regulator-fixed";
+			regulator-name = "fixed-1.8V";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
+			regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "fixed-3.3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+			regulator-always-on;
+	};
+};
+
+&avb0 {
+	pinctrl-0 = <&avb0_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&phy0>;
+	tx-internal-delay-ps = <2000>;
+	status = "okay";
+
+	phy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-id0022.1622",
+			     "ethernet-phy-ieee802.3-c22";
+		rxc-skew-ps = <1500>;
+		reg = <0>;
+		interrupt-parent = <&gpio7>;
+		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&gpio7 10 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <16666666>;
+};
+
+&extalr_clk {
+	clock-frequency = <32768>;
+};
+
+&hscif0 {
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom@50 {
+		compatible = "rohm,br24g01", "atmel,24c01";
+		label = "cpu-board";
+		reg = <0x50>;
+		pagesize = <8>;
+	};
+};
+
+&mmc0 {
+	pinctrl-0 = <&mmc_pins>;
+	pinctrl-1 = <&mmc_pins>;
+	pinctrl-names = "default", "state_uhs";
+
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	bus-width = <8>;
+	no-sd;
+	no-sdio;
+	non-removable;
+	full-pwr-cycle-in-suspend;
+	status = "okay";
+};
+
+&pfc {
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
+
+	avb0_pins: avb0 {
+		mux {
+			groups = "avb0_link", "avb0_mdio", "avb0_rgmii",
+				 "avb0_txcrefclk";
+			function = "avb0";
+		};
+
+		pins_mdio {
+			groups = "avb0_mdio";
+			drive-strength = <21>;
+		};
+
+		pins_mii {
+			groups = "avb0_rgmii";
+			drive-strength = <21>;
+		};
+	};
+
+	hscif0_pins: hscif0 {
+		groups = "hscif0_data", "hscif0_ctrl";
+		function = "hscif0";
+	};
+
+	i2c0_pins: i2c0 {
+		groups = "i2c0";
+		function = "i2c0";
+	};
+
+	mmc_pins: mmc {
+		groups = "mmc_data8", "mmc_ctrl", "mmc_ds";
+		function = "mmc";
+		power-source = <1800>;
+	};
+
+	scif_clk_pins: scif_clk {
+		groups = "scif_clk";
+		function = "scif_clk";
+	};
+};
+
+&scif_clk {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm/dts/r8a779h0-gray-hawk-csi-dsi.dtsi b/arch/arm/dts/r8a779h0-gray-hawk-csi-dsi.dtsi
new file mode 100644
index 00000000000..fcdd8eb8d54
--- /dev/null
+++ b/arch/arm/dts/r8a779h0-gray-hawk-csi-dsi.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the R-Car V4M Gray Hawk CSI/DSI sub-board
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+&i2c0 {
+	eeprom@52 {
+		compatible = "rohm,br24g01", "atmel,24c01";
+		label = "csi-dsi-sub-board-id";
+		reg = <0x52>;
+		pagesize = <8>;
+	};
+};
diff --git a/arch/arm/dts/r8a779h0-gray-hawk-ethernet.dtsi b/arch/arm/dts/r8a779h0-gray-hawk-ethernet.dtsi
new file mode 100644
index 00000000000..5a8e598c986
--- /dev/null
+++ b/arch/arm/dts/r8a779h0-gray-hawk-ethernet.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the R-Car V4M Gray Hawk Ethernet sub-board
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+&i2c0 {
+	eeprom@53 {
+		compatible = "rohm,br24g01", "atmel,24c01";
+		label = "ethernet-sub-board-id";
+		reg = <0x53>;
+		pagesize = <8>;
+	};
+};
diff --git a/arch/arm/dts/r8a779h0-gray-hawk.dts b/arch/arm/dts/r8a779h0-gray-hawk.dts
new file mode 100644
index 00000000000..59e5e493ad1
--- /dev/null
+++ b/arch/arm/dts/r8a779h0-gray-hawk.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the Gray Hawk CPU and BreakOut boards
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a779h0-gray-hawk-cpu.dtsi"
+#include "r8a779h0-gray-hawk-csi-dsi.dtsi"
+#include "r8a779h0-gray-hawk-ethernet.dtsi"
+
+/ {
+	model = "Renesas Gray Hawk CPU and Breakout boards based on r8a779h0";
+	compatible = "renesas,gray-hawk-breakout", "renesas,gray-hawk-cpu", "renesas,r8a779h0";
+};
+
+&i2c0 {
+	eeprom@51 {
+		compatible = "rohm,br24g01", "atmel,24c01";
+		label = "breakout-board";
+		reg = <0x51>;
+		pagesize = <8>;
+	};
+};
-- 
2.43.0

