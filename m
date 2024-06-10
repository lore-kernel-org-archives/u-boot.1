Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A37C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4DB888550;
	Mon, 10 Jun 2024 15:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2FD38856F; Mon, 10 Jun 2024 15:14:05 +0200 (CEST)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [83.166.143.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B45F286EB5
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VyXLz3fnszgS4;
 Mon, 10 Jun 2024 15:14:03 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VyXLy5TJNzDck; Mon, 10 Jun 2024 15:14:02 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 10 Jun 2024 15:13:37 +0200
Subject: [PATCH next v3 7/8] arm64: dts: rockchip: add dual-role usb3 hosts
 to rk3588 Tiger-Haikou
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-tiger-v3-7-2b4731f95757@cherry.de>
References: <20240610-tiger-v3-0-2b4731f95757@cherry.de>
In-Reply-To: <20240610-tiger-v3-0-2b4731f95757@cherry.de>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14-dev-a6ee3
X-Infomaniak-Routing: alpha
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

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Apart from the host-only usb3 controller (host2) the rk3588 also provides
two dual-role controllers. On the Tiger-Haikou combination these are
connected to the lower usb3-host port in host-only mode and the micro-usb3
port for dual-role operation.

Add the necessary controllers, phys to the Tiger-Haikou board and enable
the usb-id extcon.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Link: https://lore.kernel.org/r/20240422163951.2604273-4-heiko@sntech.de
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: d7b83921d098bd76623381f75f5cd2296f1315cc ]

(cherry picked from commit 193d3b2a0a98f2dcd8c43bcbf8a766098a9fa75d)
---
 .../src/arm64/rockchip/rk3588-tiger-haikou.dts     | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588-tiger-haikou.dts b/dts/upstream/src/arm64/rockchip/rk3588-tiger-haikou.dts
index 2aa43e7430e..e4b7a0a4444 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588-tiger-haikou.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3588-tiger-haikou.dts
@@ -113,6 +113,16 @@
 		vin-supply = <&dc_12v>;
 	};
 
+	vcc5v0_otg: vcc5v0-otg-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&otg_vbus_drv>;
+		regulator-name = "vcc5v0_otg";
+		regulator-always-on;
+	};
+
 	vcc5v0_usb: vcc5v0-usb-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
@@ -137,6 +147,10 @@
 	status = "okay";
 };
 
+&extcon_usb3 {
+	status = "okay";
+};
+
 &gmac0 {
 	status = "okay";
 };
@@ -199,6 +213,13 @@
 				<3 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
+
+	usb2 {
+		otg_vbus_drv: otg-vbus-drv {
+			rockchip,pins =
+			  <1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &sdmmc {
@@ -214,6 +235,23 @@
 	status = "okay";
 };
 
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	phy-supply = <&vcc5v0_otg>;
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	status = "okay";
+};
+
 &u2phy2 {
 	status = "okay";
 };
@@ -236,6 +274,13 @@
 
 &uart5 {
 	rts-gpios = <&gpio3 RK_PB3 GPIO_ACTIVE_HIGH>;
+};
+
+&usbdp_phy0 {
+	status = "okay";
+};
+
+&usbdp_phy1 {
 	status = "okay";
 };
 
@@ -249,6 +294,13 @@
 	status = "okay";
 };
 
+/* host0_xhci on Q7_USB_P1, usb3-otg port */
+&usb_host0_xhci {
+	dr_mode = "otg";
+	extcon = <&extcon_usb3>;
+	status = "okay";
+};
+
 /* host1 on Q7_USB_P3, usb2 port */
 &usb_host1_ehci {
 	status = "okay";
@@ -259,6 +311,12 @@
 	status = "okay";
 };
 
+/* host1_xhci on Q7_USB_P0, lower usb3 port */
+&usb_host1_xhci {
+	dr_mode = "host";
+	status = "okay";
+};
+
 /* host2 on Q7_USB_P2, upper usb3 port */
 &usb_host2_xhci {
 	status = "okay";

-- 
2.45.2

