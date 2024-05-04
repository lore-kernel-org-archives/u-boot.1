Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693FDC4345F
	for <u-boot@archiver.kernel.org>; Sat,  4 May 2024 19:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2CC9885BC;
	Sat,  4 May 2024 21:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="cz2Fs4Jr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7926F88599; Sat,  4 May 2024 21:45:32 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C92B885B3
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 21:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=fdac=MI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714851910; bh=CGmG9abM7MFD4Pqj5HRyVNnPGjenrGtRx1XrfIX7S/s=;
 b=cz2Fs4JrQw6hEIcLifYbhFVb15GUaIWii+l+1NOX+MukZvHoKqQSlzC44S7Xd3bhuCOCoPOwG
 /88jsYhhi0LthkCGTusZIyqeWhZ6qtNUOiLXmk12Ta2k8GHuoJ6W4jQ4RnAoTSB6YvCwYa5OEj3
 AXmSaUvR0cC58IKk9bHV13/pg6ORudFWiGug4j0IPIt1JQz1jhykxRSdrQpzJT6NdPbzKu+Ty87
 JfSIQOnpQ6yxwhybYRpecFoK3GLX9/INHvjZkUJetbjhsk7tMNNcyg0UVBeNbvODTjvzoEM0buq
 rPQ1VHsTt3AGuqACpwIvDPnlnwmwp1apPp4qt2rK4Elg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Jonas Karlman
 <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 13/16] rockchip: rk3588-rock-5b: Drop usb-typec node from
 u-boot.dtsi
Date: Sat,  4 May 2024 19:43:05 +0000
Message-ID: <20240504194346.2462489-14-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240504194346.2462489-1-jonas@kwiboo.se>
References: <20240504194346.2462489-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 663690412b8e4dad13276e57
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

The usb-typec related nodes and props added in the board u-boot.dtsi
file has not yet landed in upstream Linux kernel DT, and they are not
needed for U-Boot to use the USB Type-C port in peripheral mode.

Remove superfluous usb-typec related nodes and props and replace them
with a simple dr_mode and maximum-speed prop to cleanup the board
u-boot.dtsi file.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi | 106 +-----------------------
 1 file changed, 2 insertions(+), 104 deletions(-)

diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
index d6020ca790f6..69914f4ce183 100644
--- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
@@ -4,32 +4,12 @@
  */
 
 #include "rk3588-u-boot.dtsi"
-#include <dt-bindings/usb/pd.h>
-
-/ {
-	vcc12v_dcin: vcc12v-dcin-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc12v_dcin";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <12000000>;
-		regulator-max-microvolt = <12000000>;
-	};
-};
 
 &fspim2_pins {
 	bootph-pre-ram;
 	bootph-some-ram;
 };
 
-&pinctrl {
-	usb {
-		usbc0_int: usbc0-int {
-			rockchip,pins = <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
 &sdhci {
 	cap-mmc-highspeed;
 	mmc-hs200-1_8v;
@@ -76,26 +56,7 @@
 };
 
 &usbdp_phy0 {
-	orientation-switch;
-	mode-switch;
-	sbu1-dc-gpios = <&gpio4 RK_PA6 GPIO_ACTIVE_HIGH>;
-	sbu2-dc-gpios = <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
 	status = "okay";
-
-	port {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		usbdp_phy0_typec_ss: endpoint@0 {
-			reg = <0>;
-			remote-endpoint = <&usbc0_ss>;
-		};
-
-		usbdp_phy0_typec_sbu: endpoint@1 {
-			reg = <1>;
-			remote-endpoint = <&usbc0_sbu>;
-		};
-	};
 };
 
 &usbdp_phy0_u3 {
@@ -103,74 +64,11 @@
 };
 
 &usb_host0_xhci {
-	usb-role-switch;
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
 	status = "okay";
-
-	port {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		usb_host0_xhci_drd_sw: endpoint {
-			remote-endpoint = <&usbc0_hs>;
-		};
-	};
 };
 
 &usb_host1_xhci {
 	status = "okay";
 };
-
-&i2c4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c4m1_xfer>;
-	status = "okay";
-
-	usbc0: usb-typec@22 {
-		compatible = "fcs,fusb302";
-		reg = <0x22>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&usbc0_int>;
-		vbus-supply = <&vcc12v_dcin>;
-		status = "okay";
-
-		usb_con: connector {
-			compatible = "usb-c-connector";
-			label = "USB-C";
-			data-role = "dual";
-			power-role = "sink";
-			try-power-role = "sink";
-			op-sink-microwatt = <1000000>;
-			sink-pdos =
-				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>,
-				<PDO_VAR(5000, 20000, 5000)>;
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-					usbc0_hs: endpoint {
-						remote-endpoint = <&usb_host0_xhci_drd_sw>;
-					};
-				};
-
-				port@1 {
-					reg = <1>;
-					usbc0_ss: endpoint {
-						remote-endpoint = <&usbdp_phy0_typec_ss>;
-					};
-				};
-
-				port@2 {
-					reg = <2>;
-					usbc0_sbu: endpoint {
-						remote-endpoint = <&usbdp_phy0_typec_sbu>;
-					};
-				};
-			};
-		};
-	};
-};
-- 
2.43.2

