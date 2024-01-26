Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B75DC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 22:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1813287D49;
	Fri, 26 Jan 2024 23:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="GfACnOw1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C20B87D48; Fri, 26 Jan 2024 23:15:43 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0BB287D48
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 23:15:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0bb9=JF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1706307333; bh=mFO7hypQELWRUhvcskJczFCbCGyTwEtwAzDhHpl7HYY=;
 b=GfACnOw1yP0pGPQLxZx07ccABqMmWllUU+izcsl0nn7sHKej0l233jRNhstQIBBT0jLIu8Pdj
 KJYuSXHintayQijK1oVtBmKC6UH2coygTydiVhZcg/4xg8IssGo0uhnzYCvDH834Ea6k5h2OLx4
 De2zP9eNE/cnpeje4D+g8gx1MQvirsSFpbS/5QPl1vK5YZIAIZX/lobUYwNdNtgpGFzlA+S55qF
 bHGGlFWJPYDJfwKdaxZNS367Yg9b8gyuFUaV5WOkj3yUUrrdtI++nlPRd96FmP6ef5DkNDPmVj6
 WpcI0qprePHPBGNSmblph0eQugAcBPmqG4uIgV54QNzg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Joshua Riek <jjriek@verizon.net>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 4/7] rockchip: rk3588: Sync device tree with linux v6.7
Date: Fri, 26 Jan 2024 22:14:52 +0000
Message-ID: <20240126221508.4093334-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126221508.4093334-1-jonas@kwiboo.se>
References: <20240126221508.4093334-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65b42f040365e20062645613
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

Sync rk3588 device tree from linux v6.7.

Also drop the rockchip,rk3568-dwc3 compatible now that dwc3-generic
driver support the rockchip,rk3588-dwc3 compatible.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3588-turing-rk1.dtsi           |  4 +--
 arch/arm/dts/rk3588-u-boot.dtsi               |  2 +-
 arch/arm/dts/rk3588s-orangepi-5.dts           |  2 +-
 arch/arm/dts/rk3588s-pinctrl.dtsi             |  2 +-
 arch/arm/dts/rk3588s-u-boot.dtsi              | 33 +++--------------
 arch/arm/dts/rk3588s.dtsi                     | 36 +++++++++++++++++++
 arch/arm/mach-rockchip/rk3588/syscon_rk3588.c |  2 +-
 7 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/arch/arm/dts/rk3588-turing-rk1.dtsi b/arch/arm/dts/rk3588-turing-rk1.dtsi
index 9570b34aca2e..d88c0e852356 100644
--- a/arch/arm/dts/rk3588-turing-rk1.dtsi
+++ b/arch/arm/dts/rk3588-turing-rk1.dtsi
@@ -235,13 +235,13 @@
 &pinctrl {
 	fan {
 		fan_int: fan-int {
-			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 
 	hym8563 {
 		hym8563_int: hym8563-int {
-			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 
diff --git a/arch/arm/dts/rk3588-u-boot.dtsi b/arch/arm/dts/rk3588-u-boot.dtsi
index 31046fc7febb..992f7b5d6637 100644
--- a/arch/arm/dts/rk3588-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-u-boot.dtsi
@@ -7,7 +7,7 @@
 
 / {
 	usb_host1_xhci: usb@fc400000 {
-		compatible = "rockchip,rk3588-dwc3", "rockchip,rk3568-dwc3", "snps,dwc3";
+		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
 		reg = <0x0 0xfc400000 0x0 0x400000>;
 		interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru REF_CLK_USB3OTG1>, <&cru SUSPEND_CLK_USB3OTG1>,
diff --git a/arch/arm/dts/rk3588s-orangepi-5.dts b/arch/arm/dts/rk3588s-orangepi-5.dts
index 8f399c4317bd..e3a839a12dc6 100644
--- a/arch/arm/dts/rk3588s-orangepi-5.dts
+++ b/arch/arm/dts/rk3588s-orangepi-5.dts
@@ -38,7 +38,7 @@
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-		pinctrl-0 =<&leds_gpio>;
+		pinctrl-0 = <&leds_gpio>;
 
 		led-1 {
 			gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/dts/rk3588s-pinctrl.dtsi b/arch/arm/dts/rk3588s-pinctrl.dtsi
index 63151d9d2377..30db12c4fc82 100644
--- a/arch/arm/dts/rk3588s-pinctrl.dtsi
+++ b/arch/arm/dts/rk3588s-pinctrl.dtsi
@@ -369,7 +369,7 @@
 		emmc_data_strobe: emmc-data-strobe {
 			rockchip,pins =
 				/* emmc_data_strobe */
-				<2 RK_PA2 1 &pcfg_pull_none>;
+				<2 RK_PA2 1 &pcfg_pull_down>;
 		};
 	};
 
diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index c0fd16c4022b..ebee2131ceeb 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -22,7 +22,7 @@
 	};
 
 	usb_host0_xhci: usb@fc000000 {
-		compatible = "rockchip,rk3588-dwc3", "rockchip,rk3568-dwc3", "snps,dwc3";
+		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
 		reg = <0x0 0xfc000000 0x0 0x400000>;
 		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru REF_CLK_USB3OTG0>, <&cru SUSPEND_CLK_USB3OTG0>,
@@ -43,33 +43,6 @@
 		status = "disabled";
 	};
 
-	usb_host2_xhci: usb@fcd00000 {
-		compatible = "rockchip,rk3588-dwc3", "rockchip,rk3568-dwc3", "snps,dwc3";
-		reg = <0x0 0xfcd00000 0x0 0x400000>;
-		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH 0>;
-		clocks = <&cru REF_CLK_USB3OTG2>, <&cru SUSPEND_CLK_USB3OTG2>,
-			 <&cru ACLK_USB3OTG2>, <&cru CLK_UTMI_OTG2>,
-			 <&cru CLK_PIPEPHY2_PIPE_U3_G>;
-		clock-names = "ref_clk", "suspend_clk", "bus_clk", "utmi", "pipe";
-		dr_mode = "host";
-		phys = <&combphy2_psu PHY_TYPE_USB3>;
-		phy-names = "usb3-phy";
-		phy_type = "utmi_wide";
-		resets = <&cru SRST_A_USB3OTG2>;
-		snps,dis_enblslpm_quirk;
-		snps,dis-u2-freeclk-exists-quirk;
-		snps,dis-del-phy-power-chg-quirk;
-		snps,dis-tx-ipgap-linecheck-quirk;
-		snps,dis_rxdet_inp3_quirk;
-		status = "disabled";
-	};
-
-	pmu1_grf: syscon@fd58a000 {
-		bootph-all;
-		compatible = "rockchip,rk3588-pmu1-grf", "syscon";
-		reg = <0x0 0xfd58a000 0x0 0x2000>;
-	};
-
 	usbdpphy0_grf: syscon@fd5c8000 {
 		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
 		reg = <0x0 0xfd5c8000 0x0 0x4000>;
@@ -206,6 +179,10 @@
 	status = "okay";
 };
 
+&pmu1grf {
+	bootph-all;
+};
+
 &scmi {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3588s.dtsi b/arch/arm/dts/rk3588s.dtsi
index 61a9a11c3bb0..8aa0499f9b03 100644
--- a/arch/arm/dts/rk3588s.dtsi
+++ b/arch/arm/dts/rk3588s.dtsi
@@ -443,6 +443,32 @@
 		status = "disabled";
 	};
 
+	usb_host2_xhci: usb@fcd00000 {
+		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
+		reg = <0x0 0xfcd00000 0x0 0x400000>;
+		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru REF_CLK_USB3OTG2>, <&cru SUSPEND_CLK_USB3OTG2>,
+			 <&cru ACLK_USB3OTG2>, <&cru CLK_UTMI_OTG2>,
+			 <&cru CLK_PIPEPHY2_PIPE_U3_G>;
+		clock-names = "ref_clk", "suspend_clk", "bus_clk", "utmi", "pipe";
+		dr_mode = "host";
+		phys = <&combphy2_psu PHY_TYPE_USB3>;
+		phy-names = "usb3-phy";
+		phy_type = "utmi_wide";
+		resets = <&cru SRST_A_USB3OTG2>;
+		snps,dis_enblslpm_quirk;
+		snps,dis-u2-freeclk-exists-quirk;
+		snps,dis-del-phy-power-chg-quirk;
+		snps,dis-tx-ipgap-linecheck-quirk;
+		snps,dis_rxdet_inp3_quirk;
+		status = "disabled";
+	};
+
+	pmu1grf: syscon@fd58a000 {
+		compatible = "rockchip,rk3588-pmugrf", "syscon", "simple-mfd";
+		reg = <0x0 0xfd58a000 0x0 0x10000>;
+	};
+
 	sys_grf: syscon@fd58c000 {
 		compatible = "rockchip,rk3588-sys-grf", "syscon";
 		reg = <0x0 0xfd58c000 0x0 0x1000>;
@@ -1329,6 +1355,16 @@
 		};
 	};
 
+	dfi: dfi@fe060000 {
+		reg = <0x00 0xfe060000 0x00 0x10000>;
+		compatible = "rockchip,rk3588-dfi";
+		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH 0>;
+		rockchip,pmu = <&pmu1grf>;
+	};
+
 	gmac1: ethernet@fe1c0000 {
 		compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
 		reg = <0x0 0xfe1c0000 0x0 0x10000>;
diff --git a/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c b/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
index e8772d3a3824..7b2cf37d9da1 100644
--- a/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
@@ -10,7 +10,7 @@
 
 static const struct udevice_id rk3588_syscon_ids[] = {
 	{ .compatible = "rockchip,rk3588-sys-grf", .data = ROCKCHIP_SYSCON_GRF },
-	{ .compatible = "rockchip,rk3588-pmu1-grf", .data = ROCKCHIP_SYSCON_PMUGRF },
+	{ .compatible = "rockchip,rk3588-pmugrf",  .data = ROCKCHIP_SYSCON_PMUGRF },
 	{ .compatible = "rockchip,rk3588-vop-grf", .data = ROCKCHIP_SYSCON_VOP_GRF },
 	{ .compatible = "rockchip,rk3588-vo-grf",  .data = ROCKCHIP_SYSCON_VO_GRF },
 	{ .compatible = "rockchip,pcie30-phy-grf", .data = ROCKCHIP_SYSCON_PCIE30_PHY_GRF },
-- 
2.43.0

