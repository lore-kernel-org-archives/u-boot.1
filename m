Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E702C83F0F
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 03:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C7C183678;
	Thu, 10 Jul 2025 05:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="TAiz/gKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB49E8367B; Thu, 10 Jul 2025 05:43:19 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A340883678
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 05:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 67EC723C95;
 Thu, 10 Jul 2025 05:43:17 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CYCEhb7eDvru; Thu, 10 Jul 2025 05:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1752118996; bh=TmA6mx6Nab4pWqfiSO5gBVMAXMeOgN6w0aH23gS24D0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TAiz/gKc0rNpZxVRhDejfMGCTT5dA/A/yK/oxMudhp9oRPnmKsL19Z78FiotiClAh
 LZxsx7/tVVXdufC749liMavCteBUNkF5NyAXp41h4hIeWPq3Zu51D1S1GMJiF08VH6
 ETl68822erAOKQMPhKzTFppyr/uP+dAKPUkOFPBNECT6bsnqO8uNvRQxtaTzZHSlOB
 LiQShJV0W/vUOawP4P6/y7gfi/hANYLH+WnT8TqG4sw4LPR2JaUIKD8Q1Bd+uvThnb
 GpDktyPBVK/kRGz08sNOl1CdJaOQ5GCMunTvN47pbfTXsp9rDrXzGjstOObWErix91
 kpwN0teQxDxAw==
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH 4/5] riscv: dts: th1520: Describe GMACs and enable them on
 Lichee Pi 4A
Date: Thu, 10 Jul 2025 03:42:00 +0000
Message-ID: <20250710034201.39901-5-ziyao@disroot.org>
In-Reply-To: <20250710034201.39901-1-ziyao@disroot.org>
References: <20250710034201.39901-1-ziyao@disroot.org>
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

TH1520 SoC ships two MAC controllers based on Designware Ethernet IP
that are capable of Gigabit operation. Describe them in SoC devicetree
and enable them for Lichee Pi 4A.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/dts/th1520-lichee-module-4a.dtsi | 119 ++++++++++++++++++++
 arch/riscv/dts/th1520.dtsi                  |  42 +++++++
 2 files changed, 161 insertions(+)

diff --git a/arch/riscv/dts/th1520-lichee-module-4a.dtsi b/arch/riscv/dts/th1520-lichee-module-4a.dtsi
index 9b255f8243c..eecd3e9832a 100644
--- a/arch/riscv/dts/th1520-lichee-module-4a.dtsi
+++ b/arch/riscv/dts/th1520-lichee-module-4a.dtsi
@@ -11,6 +11,11 @@
 	model = "Sipeed Lichee Module 4A";
 	compatible = "sipeed,lichee-module-4a", "thead,th1520";
 
+	aliases {
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+	};
+
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x00000000 0x2 0x00000000>;
@@ -38,6 +43,120 @@
 	status = "okay";
 };
 
+&gmac0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac0_pins>, <&mdio0_pins>;
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&gmac1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1_pins>;
+	phy-handle = <&phy1>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&mdio0 {
+	phy0: ethernet-phy@1 {
+		reg = <1>;
+	};
+
+	phy1: ethernet-phy@2 {
+		reg = <2>;
+	};
+};
+
+&padctrl0_apsys {
+	gmac0_pins: gmac0-0 {
+		tx-pins {
+			pins = "GMAC0_TX_CLK",
+			       "GMAC0_TXEN",
+			       "GMAC0_TXD0",
+			       "GMAC0_TXD1",
+			       "GMAC0_TXD2",
+			       "GMAC0_TXD3";
+			function = "gmac0";
+			bias-disable;
+			drive-strength = <25>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		rx-pins {
+			pins = "GMAC0_RX_CLK",
+			       "GMAC0_RXDV",
+			       "GMAC0_RXD0",
+			       "GMAC0_RXD1",
+			       "GMAC0_RXD2",
+			       "GMAC0_RXD3";
+			function = "gmac0";
+			bias-disable;
+			drive-strength = <1>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	gmac1_pins: gmac1-0 {
+		tx-pins {
+			pins = "GPIO2_18", /* GMAC1_TX_CLK */
+			       "GPIO2_20", /* GMAC1_TXEN */
+			       "GPIO2_21", /* GMAC1_TXD0 */
+			       "GPIO2_22", /* GMAC1_TXD1 */
+			       "GPIO2_23", /* GMAC1_TXD2 */
+			       "GPIO2_24"; /* GMAC1_TXD3 */
+			function = "gmac1";
+			bias-disable;
+			drive-strength = <25>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		rx-pins {
+			pins = "GPIO2_19", /* GMAC1_RX_CLK */
+			       "GPIO2_25", /* GMAC1_RXDV */
+			       "GPIO2_30", /* GMAC1_RXD0 */
+			       "GPIO2_31", /* GMAC1_RXD1 */
+			       "GPIO3_0",  /* GMAC1_RXD2 */
+			       "GPIO3_1";  /* GMAC1_RXD3 */
+			function = "gmac1";
+			bias-disable;
+			drive-strength = <1>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	mdio0_pins: mdio0-0 {
+		mdc-pins {
+			pins = "GMAC0_MDC";
+			function = "gmac0";
+			bias-disable;
+			drive-strength = <13>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		mdio-pins {
+			pins = "GMAC0_MDIO";
+			function = "gmac0";
+			bias-disable;
+			drive-strength = <13>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+	};
+};
+
 &sdio0 {
 	bus-width = <4>;
 	max-frequency = <198000000>;
diff --git a/arch/riscv/dts/th1520.dtsi b/arch/riscv/dts/th1520.dtsi
index 8306eda5521..c46925a132a 100644
--- a/arch/riscv/dts/th1520.dtsi
+++ b/arch/riscv/dts/th1520.dtsi
@@ -177,6 +177,48 @@
 			status = "disabled";
 		};
 
+		gmac1: ethernet@ffe7060000 {
+			compatible = "thead,th1520-gmac", "snps,dwmac-3.70a";
+			reg = <0xff 0xe7060000 0x0 0x2000>, <0xff 0xec004000 0x0 0x1000>;
+			reg-names = "dwmac", "apb";
+			interrupts = <67 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC1>;
+			clock-names = "stmmaceth", "pclk";
+			snps,pbl = <32>;
+			snps,fixed-burst;
+			snps,multicast-filter-bins = <64>;
+			snps,perfect-filter-entries = <32>;
+			status = "disabled";
+
+			mdio1: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		gmac0: ethernet@ffe7070000 {
+			compatible = "thead,th1520-gmac", "snps,dwmac-3.70a";
+			reg = <0xff 0xe7070000 0x0 0x2000>, <0xff 0xec003000 0x0 0x1000>;
+			reg-names = "dwmac", "apb";
+			interrupts = <66 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC0>;
+			clock-names = "stmmaceth", "pclk";
+			snps,pbl = <32>;
+			snps,fixed-burst;
+			snps,multicast-filter-bins = <64>;
+			snps,perfect-filter-entries = <32>;
+			status = "disabled";
+
+			mdio0: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		emmc: mmc@ffe7080000 {
 			compatible = "thead,th1520-dwcmshc";
 			reg = <0xff 0xe7080000 0x0 0x10000>;
-- 
2.50.0

