Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DBACCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 10:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C880183F6A;
	Tue, 11 Nov 2025 11:31:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="G0BWUG/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CD1683F72; Tue, 11 Nov 2025 11:31:52 +0100 (CET)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F98E83F6C
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 11:31:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C5E27C9EE9; Tue, 11 Nov 2025 11:31:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1762857110; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=lwICyXPgYdBDDT2hxmJFz6AygCjGEMTJGVSiYP/zqFg=;
 b=G0BWUG/fSOoc6dRzjASUBxq307UZoiZXOzenfCWuFCc0BNJ055FNYO0h15CHZ4X2+CgxFP
 K7Lozp/j+vgv+U+G+IklytbvB8Uetjf6Vk4MoUbK4zDAq0duBNRPGDJDba8gbI9lb8paMi
 9dlSXGO09sAvJt24pw0hZ+CV6tHQzvMcmtsXh5HTWO2jCJa01ljsNbX3vUYWW6fQtemqC+
 DpI1W7p8bHmKi5XuvhqtgmWtocKumNMFJul6T+q/ybk2lykg6B6IKil1/HhxdEbL6FIfsa
 7WsYI9FgRInKO1T3MBg91pjgW6V33ddjGExZ57/wtLDDa8/4L3PoZDUTHer0dg==
From: Frieder Schrempf <frieder@fris.de>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 2/4] arm64: dts: imx8mp-kontron: Fix USB OTG role switching
Date: Tue, 11 Nov 2025 11:28:11 +0100
Message-ID: <20251111102904.157931-3-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111102904.157931-1-frieder@fris.de>
References: <20251111102904.157931-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The VBUS supply regulator is currently assigned to the PHY node.
This causes the VBUS to be always on, even when the controller
needs to be switched to peripheral mode.

Fix the OTG role switching by adding a connector node and moving
the VBUS supply regulator to that node. This way the VBUS gets
correctly switched according to the current role.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 .../freescale/imx8mp-kontron-bl-osm-s.dts     | 24 +++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/dts/upstream/src/arm64/freescale/imx8mp-kontron-bl-osm-s.dts b/dts/upstream/src/arm64/freescale/imx8mp-kontron-bl-osm-s.dts
index 0eb9e726a9b..6c63f0a5fa9 100644
--- a/dts/upstream/src/arm64/freescale/imx8mp-kontron-bl-osm-s.dts
+++ b/dts/upstream/src/arm64/freescale/imx8mp-kontron-bl-osm-s.dts
@@ -16,11 +16,20 @@
 		ethernet1 = &eqos;
 	};
 
-	extcon_usbc: usbc {
-		compatible = "linux,extcon-usb-gpio";
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		id-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+		label = "Type-C";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_usb1_id>;
-		id-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+		type = "micro";
+		vbus-supply = <&reg_usb1_vbus>;
+
+		port {
+			usb_dr_connector: endpoint {
+				remote-endpoint = <&usb3_dwc>;
+			};
+		};
 	};
 
 	leds {
@@ -230,9 +239,15 @@
 	hnp-disable;
 	srp-disable;
 	dr_mode = "otg";
-	extcon = <&extcon_usbc>;
 	usb-role-switch;
+	role-switch-default-mode = "peripheral";
 	status = "okay";
+
+	port {
+		usb3_dwc: endpoint {
+			remote-endpoint = <&usb_dr_connector>;
+		};
+	};
 };
 
 &usb_dwc3_1 {
@@ -261,7 +276,6 @@
 };
 
 &usb3_phy0 {
-	vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
 };
 
-- 
2.51.0

