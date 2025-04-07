Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6427EC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB39083032;
	Tue,  8 Apr 2025 00:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LmIaEp/P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1FFD82EA3; Tue,  8 Apr 2025 00:48:32 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2506183125
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066108; bh=sVpqv0AWwpRLGsu0RoH8dIoc9W4jAN+ysJZ9UHd3Lsw=;
 b=LmIaEp/PQbpGAT1XM4EsivhaEFr0Tv/vUT2OxHjpGY466/0IKtBB63/g2WSIDTGyhgMYsJOAD
 RnxuRsqD2miOFXq/Szfjukg9IyOtVspSVAhiiZJG9AA7QnmZy2YmsPbBwe67tvvQwnuOQIBmNxE
 fdkxVYJPUPDFpLJ1lfoGXXL9agv272wCCssVoBI1kutHFvpslYQnUb8hasO0iqO5JEyi2Z3fsUo
 3b17uhxbrRqR1bUP3p553mQzACP6Vz7JRP8myQ0z1bE6hxPsD8zZZC2pgCV/RjaA+ODEbDbQx/k
 I3y1zwr0IKY1HAEJUfZ7CC4pe5isHarOkl5kJmuAZS4Q==
X-Forward-Email-ID: 67f456399fd75b9b96512810
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 10/30] arm64: dts: rockchip: Add leds node to Radxa E20C
Date: Mon,  7 Apr 2025 22:46:43 +0000
Message-ID: <20250407224743.2423921-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407224743.2423921-1-jonas@kwiboo.se>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
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

Radxa E20C has three gpio controlled leds (sys, wan and lan).

Add led nodes and set default trigger to heartbeat for the sys led and
netdev for the lan and wan leds.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Link: https://lore.kernel.org/r/20250304201642.831218-2-jonas@kwiboo.se
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 6a709e003492e9878d5f1357be0b2e1162e1e6a6 ]

(cherry picked from commit a3556ede6b48c7760ac3608ad77601fca26d2ce0)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../src/arm64/rockchip/rk3528-radxa-e20c.dts  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts b/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
index 5161d22330ab..7f0237206405 100644
--- a/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
@@ -6,6 +6,8 @@
  */
 
 /dts-v1/;
+
+#include <dt-bindings/leds/common.h>
 #include "rk3528.dtsi"
 
 / {
@@ -15,6 +17,52 @@
 	chosen {
 		stdout-path = "serial0:1500000n8";
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&lan_led_g>, <&sys_led_g>, <&wan_led_g>;
+
+		led-lan {
+			color = <LED_COLOR_ID_GREEN>;
+			default-state = "off";
+			function = LED_FUNCTION_LAN;
+			gpios = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "netdev";
+		};
+
+		led-sys {
+			color = <LED_COLOR_ID_GREEN>;
+			default-state = "on";
+			function = LED_FUNCTION_HEARTBEAT;
+			gpios = <&gpio4 RK_PC1 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-wan {
+			color = <LED_COLOR_ID_GREEN>;
+			default-state = "off";
+			function = LED_FUNCTION_WAN;
+			gpios = <&gpio4 RK_PC0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "netdev";
+		};
+	};
+};
+
+&pinctrl {
+	leds {
+		lan_led_g: lan-led-g {
+			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		sys_led_g: sys-led-g {
+			rockchip,pins = <4 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wan_led_g: wan-led-g {
+			rockchip,pins = <4 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &uart0 {
-- 
2.49.0

