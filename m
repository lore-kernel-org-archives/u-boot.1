Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958CEC61CE7
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 09:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2DAA82C49;
	Wed, 11 Jun 2025 10:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28B8082B20; Wed, 11 Jun 2025 10:59:52 +0200 (CEST)
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::190f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BA3482B97
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 10:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bHKNd0HJjzpL4;
 Wed, 11 Jun 2025 10:59:45 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4bHKNc1G4LzdxS; Wed, 11 Jun 2025 10:59:44 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 11 Jun 2025 10:59:32 +0200
Subject: [PATCH 2/3] arm64: dts: rockchip: move reset to dedicated eth-phy
 node on ringneck
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-ringneck-mdio-v1-2-529a40a0f966@cherry.de>
References: <20250611-ringneck-mdio-v1-0-529a40a0f966@cherry.de>
In-Reply-To: <20250611-ringneck-mdio-v1-0-529a40a0f966@cherry.de>
To: Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Klaus Goger <klaus.goger@cherry.de>
Cc: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
X-Mailer: b4 0.14.2
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

Using snps,reset-* properties to handle the ethernet-phy resets is
deprecated and instead a real phy node should be used.

Move the Ringneck phy-reset properties to such a node

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
Link: https://lore.kernel.org/r/20250514150745.2437804-3-heiko@sntech.de
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: e463625af7f92c4a9f097f7fb87f6baaad6e762a ]

(cherry picked from commit 76d0d8e00c9ac845ca8d6cbe191cf015ca3a8c16)
---
 dts/upstream/src/arm64/rockchip/px30-ringneck.dtsi | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/px30-ringneck.dtsi b/dts/upstream/src/arm64/rockchip/px30-ringneck.dtsi
index e80412abec081f131271be933ee5805ee237b5af..185d5ba22fd5022a94de7a5a8d10bfe05f40ecf2 100644
--- a/dts/upstream/src/arm64/rockchip/px30-ringneck.dtsi
+++ b/dts/upstream/src/arm64/rockchip/px30-ringneck.dtsi
@@ -83,9 +83,7 @@
 
 /* On-module TI DP83825I PHY but no connector, enable in carrierboard */
 &gmac {
-	snps,reset-gpio = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 50000 50000>;
+	phy-handle = <&dp83825>;
 	phy-supply = <&vcc_3v3>;
 	clock_in_out = "output";
 };
@@ -348,6 +346,18 @@
 	status = "okay";
 };
 
+&mdio {
+	dp83825: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&phy_rst>;
+		reset-assert-us = <50000>;
+		reset-deassert-us = <50000>;
+		reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
+	};
+};
+
 &pinctrl {
 	emmc {
 		emmc_reset: emmc-reset {
@@ -355,6 +365,12 @@
 		};
 	};
 
+	ethernet {
+		phy_rst: phy-rst {
+			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	leds {
 		module_led_pin: module-led-pin {
 			rockchip,pins = <1 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;

-- 
2.49.0

