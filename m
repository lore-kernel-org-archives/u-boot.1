Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA5DC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 10:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC4F184119;
	Fri, 10 Jul 2026 12:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Qcc5ksAO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A06BF84A30; Fri, 10 Jul 2026 12:05:39 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10FBE84119
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 12:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4682=FE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783677935; bh=7sCi9dJWYbOK3XiWupMi0xFEkz0oOpZ4VZam3d3FilQ=;
 b=Qcc5ksAOTvGl/IiAvBzD7DH/Owqn43C9Od/ofgZqHI69dgX1RXvo4vFrWlRiolqK77f/xcHhk
 YAAaE8RPqjYWlB9KxO4ld+dPIuq7TRzj/ZlaRysXI+NSuO/apravu7X3v/gPeTjoZi50hhTsxHN
 IoU0NghGN10KCotW381tiIEVkYuWNiEK5JlKzpUakeupO3Bi7KtYz6eRXKQGfHMfKSGHB8vXKRp
 m1k4dnfdUFvSz2ome93aLHTcXcxg7l6AGwZxXtMkCbsvSHcDcgC1ugbtBVmuOXBrzo8rZWJBkRE
 ftBQEyKM3FWbpXugjKbdb+1HhGoufw5TJtlBphlSbrtg==
X-Forward-Email-ID: 6a50c3ed28378fa077a39557
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 3/7] arm64: dts: rockchip: Enable USB 2.0 ports on Radxa E20C
Date: Fri, 10 Jul 2026 10:05:15 +0000
Message-ID: <20260710100521.3677247-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710100521.3677247-1-jonas@kwiboo.se>
References: <20260710100521.3677247-1-jonas@kwiboo.se>
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

The Radxa E20C has one USB2.0 Type-A HOST port and one USB2.0 Type-C port.

The Type-C port is conneced to a FE1.1s_QFN USB hub on the board, with its
ports being connected to the XHCI usb controller and an usb-uart bridge.

This also means, the XHCI controller can only be used in device-mode.

Add support for using the USB 2.0 ports on Radxa E20C.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
[set xhci to peripheral and add comment about the outward-facing hub]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20260529190355.4148175-3-heiko@sntech.de

[ upstream commit: e897bcf81dd920bf80ace6d98ec6f9645c5b50f2 ]

(cherry picked from commit 2e01d9a6eb75fa4c704e421e766b2715000d1a29)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../src/arm64/rockchip/rk3528-radxa-e20c.dts  | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts b/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
index b32452756155..f872b8d20ebc 100644
--- a/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
@@ -134,6 +134,18 @@
 		regulator-max-microvolt = <5000000>;
 	};
 
+	vcc5v0_usb20: regulator-5v0-vcc-usb20 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_host_en>;
+		regulator-name = "vcc5v0_usb20";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
 	vccio_sd: regulator-vccio-sd {
 		compatible = "regulator-gpio";
 		gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
@@ -273,6 +285,12 @@
 			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	usb {
+		usb_host_en: usb-host-en {
+			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &pwm1 {
@@ -320,3 +338,45 @@
 	pinctrl-0 = <&uart0m0_xfer>;
 	status = "okay";
 };
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+/*
+ * The usb controller can only work in peripheral mode, as it is
+ * connected to one of the ports of an outward-facing usb hub.
+ *
+ * type_c-port (hub-input)
+ *          |
+ *       usb-hub
+ *     |         |
+ * uart-usb   usb-host0
+ *     |
+ *   uart0
+ */
+&usb_host0_xhci {
+	dr_mode = "peripheral";
+	extcon = <&usb2phy>;
+	maximum-speed = "high-speed";
+	phys = <&usb2phy_otg>;
+	phy-names = "usb2-phy";
+	status = "okay";
+};
+
+&usb2phy {
+	status = "okay";
+};
+
+&usb2phy_host {
+	phy-supply = <&vcc5v0_usb20>;
+	status = "okay";
+};
+
+&usb2phy_otg {
+	status = "okay";
+};
-- 
2.54.0

