Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B91C49EA1
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 13:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14C2088C8C;
	Sat,  3 Aug 2024 15:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B91D488BFF; Sat,  3 Aug 2024 15:57:22 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 970BD88CD1
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 15:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=phil.lan)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1saFEb-000691-9O; Sat, 03 Aug 2024 15:55:49 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de
Cc: heiko@sntech.de,
	ukleinek@debian.org
Subject: [PATCH 10/15] DONOTMERGE: arm64: dts: rockchip: add gpio-keys to
 Qnap-TS433
Date: Sat,  3 Aug 2024 15:55:37 +0200
Message-Id: <20240803135542.3124517-11-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240803135542.3124517-1-heiko@sntech.de>
References: <20240803135542.3124517-1-heiko@sntech.de>
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

The TS433 has 3 buttons, power and copy in the front as well as a reset
pinhole button on the back. The power-button is connected to the embedded
controller while the other two buttons are just gpio connected.

Add the gpio-keys definition for the two buttons we can handle right now.

Tested-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20240723195538.1133436-11-heiko@sntech.de

[this needs to be replaced, once the patch hits the devicetree-rebasing repo]

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../src/arm64/rockchip/rk3568-qnap-ts433.dts  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
index 34fc31ea9a3..9f964b6f411 100644
--- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/gpio/gpio.h>
 #include "rk3568.dtsi"
@@ -24,6 +25,24 @@
 		stdout-path = "serial2:115200n8";
 	};
 
+	keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&copy_button_pin>, <&reset_button_pin>;
+		pinctrl-names = "default";
+
+		key-copy {
+			label = "copy";
+			gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_COPY>;
+		};
+
+		key-reset {
+			label = "reset";
+			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_RESTART>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -202,6 +221,16 @@
 };
 
 &pinctrl {
+	keys {
+		copy_button_pin: copy-button-pin {
+			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		reset_button_pin: reset-button-pin {
+			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	leds {
 		hdd1_led_pin: hdd1-led-pin {
 			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
-- 
2.39.2

