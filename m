Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510F2CF2579
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 19:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A0D88FCF;
	Sun, 13 Oct 2024 21:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="AOHjmlA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66C6888FC8; Sun, 13 Oct 2024 21:24:35 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 332BF88EE3
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 21:24:33 +0200 (CEST)
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
 bh=EoR6RMzF1LZAy1O32ZhhZLnTnY8b8A64rENRudgnRaU=; b=AOHjmlA7jVF0SXll/CzT4Vkg1t
 YpEDnxh9hptTS6MMHTz9nCueGweG+18G1SAfjKivrn/E6D/zHqiEcNddwYDJSWXOS9IkL9HgK443B
 2ksABKYmQBtSE+t4GgyyRdpWMG+eVYgP8+4VAOH59tfiV8V5xCN1O2dlvpZoWbqst4eI/g7u08OR1
 KtFICJrglneQ4jPQxMkaNOIxfqgbDrcIui4NEFhK8DpRTvqF1UyS+nWpZIKAZ9h6e8jRj6a0fA+2M
 giJh9U8BUe04xbOl9KNei/+/fqE7q9lXneDu4IctBkwE8QeiIPhkwtIJWoSFLZ2pFZ8G9Nk4Rl6XH
 Q4XkfvyQ==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1t04Ca-000129-55; Sun, 13 Oct 2024 21:24:28 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org
Cc: heiko@sntech.de,
	ukleinek@debian.org
Subject: [PATCH v2 04/18] arm64: dts: rockchip: enable usb ports on Qnap-TS433
Date: Sun, 13 Oct 2024 21:24:10 +0200
Message-ID: <20241013192424.84280-5-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241013192424.84280-1-heiko@sntech.de>
References: <20241013192424.84280-1-heiko@sntech.de>
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

