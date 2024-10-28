Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DA0D3E2A2
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 19:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE99289159;
	Mon, 28 Oct 2024 20:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="fi3xe1OV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EDCC890F6; Mon, 28 Oct 2024 20:00:47 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09759890F6
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 20:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8XFYh1mFlM77TNVpsKjoEaHGzrkMhPCtuGvlMIr/pAQ=; b=fi3xe1OVViKp/XcdZ4F+3pam/6
 bjLKgtgSGRx1PCuOQTgsSl0J1w5N1KDq5tR3OJLpjz/RSNNObl6esWCLHrn/BKfcyLfUcX/7PL9UI
 x7+MFRJ3akzak2CpH98+r9+1rZApcuBNrCa9+tAxWkwCseqhyCewqvUYhlx4ynrlgKhO5n4il73Ra
 gwX12yFwvt3Kf9bindIdCD0fv2JQ2A6eOnOtoetlDO96zSrZ3nk0Z9ELzsi4/Ca9P+5ib8M5x1LWU
 dnjRdjjBZ/Ebr0Vk6p+Zu8waS5brX966uuKDFMZAMCQe1WYaG0aqfiHEvkNSZG2aqgZTnXdahwRgi
 I+Utqj+w==;
Received: from [185.156.123.69] (helo=phil.sntech)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1t5Uyo-0000Gm-Fp; Mon, 28 Oct 2024 20:00:42 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org
Cc: heiko@sntech.de,
	ukleinek@debian.org
Subject: [PATCH v3 04/18] arm64: dts: rockchip: enable usb ports on Qnap-TS433
Date: Mon, 28 Oct 2024 20:00:20 +0100
Message-ID: <20241028190034.143122-5-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028190034.143122-1-heiko@sntech.de>
References: <20241028190034.143122-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Enable usb controllers and phys and add regulator infrastructure for the
usb ports on the TS433.

Of course there are no schematics available for the device, so the
regulator information comes from the vendor-devicetree with unknown
accuracy.

Tested-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20240723195538.1133436-5-heiko@sntech.de

[ upstream commit: d992203f57c5caad0dbd4a9c669d79b315873c81 ]

(cherry picked from commit bb745ef13efb9f6589f9eda8f66664bf263a13f3)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
 .../src/arm64/rockchip/rk3568-qnap-ts433.dts  | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
index bc26f2e98c1..da735c4764f 100644
--- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
@@ -31,6 +31,49 @@
 		gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
 		vin-supply = <&dc_12v>;
 	};
+
+	vcc5v0_host: regulator-vcc5v0-host {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_host_en>;
+		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
+		regulator-name = "vcc5v0_host";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+
+	vcc5v0_otg: regulator-vcc5v0-otg {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_otg_en>;
+		regulator-name = "vcc5v0_otg";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+
+	vcc5v0_usb: regulator-vcc5v0-usb {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+};
+
+/* connected to usb_host0_xhci */
+&combphy0 {
+	status = "okay";
 };
 
 &gmac0 {
@@ -97,6 +140,18 @@
 	status = "okay";
 };
 
+&pinctrl {
+	usb {
+		vcc5v0_host_en: vcc5v0-host-en {
+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		vcc5v0_otg_en: vcc5v0-otg-en {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
 &sdhci {
 	bus-width = <8>;
 	max-frequency = <200000000>;
@@ -121,3 +176,53 @@
 &uart2 {
 	status = "okay";
 };
+
+&usb2phy0 {
+	status = "okay";
+};
+
+/* connected to usb_host0_xhci */
+&usb2phy0_otg {
+	phy-supply = <&vcc5v0_otg>;
+	status = "okay";
+};
+
+&usb2phy1 {
+	status = "okay";
+};
+
+/* connected to usb_host1_ehci/ohci */
+&usb2phy1_host {
+	phy-supply = <&vcc5v0_host>;
+	status = "okay";
+};
+
+/* connected to usb_host0_ehci/ohci */
+&usb2phy1_otg {
+	phy-supply = <&vcc5v0_host>;
+	status = "okay";
+};
+
+/* right port backside */
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+/* front port */
+&usb_host0_xhci {
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* left port backside */
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
-- 
2.45.2

