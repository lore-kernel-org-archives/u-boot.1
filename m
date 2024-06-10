Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE76C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59AC98857D;
	Mon, 10 Jun 2024 15:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BAE98856D; Mon, 10 Jun 2024 15:14:05 +0200 (CEST)
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42a9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3045D88549
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VyXLy54m7zpr8;
 Mon, 10 Jun 2024 15:14:02 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VyXLy0KTszFqk; Mon, 10 Jun 2024 15:14:02 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 10 Jun 2024 15:13:36 +0200
Subject: [PATCH next v3 6/8] arm64: dts: rockchip: add usb-id extcon on
 rk3588 tiger
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-tiger-v3-6-2b4731f95757@cherry.de>
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

The Q7 standard specifies a usb-id pin on the connector to distiuish
between host and device mode. Model this via the usb-id extcon binding.

While the pin is part of the Q7 standard, so part of the module, the
extcon stays disabled in the som dtsi and will only be enabled in a
baseboard using it.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Link: https://lore.kernel.org/r/20240422163951.2604273-3-heiko@sntech.de
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: eabb53f5dacfd643b5255f35bad30b8f914decdc ]

(cherry picked from commit 4843cec4092318ef7feb0999b0d34ef817465b33)
---
 dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi
index a8565720cf5..aebe1fedd2d 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi
@@ -23,6 +23,14 @@
 		reset-gpios = <&gpio2 RK_PA3 GPIO_ACTIVE_HIGH>;
 	};
 
+	extcon_usb3: extcon-usb3 {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpios = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb3_id>;
+		status = "disabled";
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -327,6 +335,13 @@
 			rockchip,pins = <1 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	usb3 {
+		usb3_id: usb3-id {
+			rockchip,pins =
+			  <3 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &saradc {

-- 
2.45.2

