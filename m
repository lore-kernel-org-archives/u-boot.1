Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F50CA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 11:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F35CA83957;
	Sun, 31 Aug 2025 13:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="nMOgF7fd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35D528395B; Sun, 31 Aug 2025 13:21:41 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87F0483957
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 13:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0b89=3L=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1756639297; bh=9qeRAL5FD/m9DXj2cUzK5T50sHn+ls+RZp5j/tgrtGI=;
 b=nMOgF7fdkpadJOpwzVl9p5TtCSSLpk9ZhQNFhh1QyvMd/h0tO6RtHW0qz8SgZ+O2W/BZYcmsd
 dU8mhNxguLYW3ZL+r4zlylGSjQP25Ch2MxlAr41bSf4qFbpkq87PRnOefGbpo81GHmH+OT3LL7c
 Y+cC+4kyopln8fo5g50ESrse05KU5jYqezfgeY9tDB2PJt9fwEBIgiUE7sKAHEx6DhDQmp9/ZQw
 /kvoN7YK9OA+9VIudO5FwnW5QZrATb/N1YwdtMw92DLdhkPZY7qRpC3tJtA0bL+cD/d2INkGQA/
 tHnQfjXtb8BttQBhXdL5x7WDk4FIpOV1ULf/x5dLkm5g==
X-Forward-Email-ID: 68b4303e32f03f9a5e9086fc
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v3 09/10] arm64: dts: rockchip: complete USB nodes on ROCK 4D
Date: Sun, 31 Aug 2025 11:20:30 +0000
Message-ID: <20250831112046.2642363-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831112046.2642363-1-jonas@kwiboo.se>
References: <20250831112046.2642363-1-jonas@kwiboo.se>
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

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

The ROCK 4D uses both USB controllers, and both of which in host mode.
However, it still names one of the supplies for them "OTG" in the
schematic.

Fix the "host" supply's input, and add the "otg" supply. Enable the
remaining USB PHY nodes, and the first controller node as well.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Link: https://lore.kernel.org/r/20250630-rock4d-reg-usb-wifi-v1-2-1057f412d98c@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 787595b423d855bfcbf724822fd1e663ad368d08 ]

(cherry picked from commit 7200ec33cb5697124c76de28535354f0eef6a28a)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: New patch
---
 .../src/arm64/rockchip/rk3576-rock-4d.dts     | 41 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts b/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts
index ee0822cd4f35..87bc9004fca1 100644
--- a/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts
@@ -180,7 +180,21 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		regulator-name = "vcc5v0_host";
-		vin-supply = <&vcc_5v0_device>;
+		vin-supply = <&vcc_5v0_sys>;
+	};
+
+	vcc_5v0_otg: regulator-vcc-5v0-otg {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_otg_pwren>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc5v0_otg";
+		vin-supply = <&vcc_5v0_sys>;
 	};
 
 	vcc_5v0_sys: regulator-vcc-5v0-sys {
@@ -699,7 +713,11 @@
 
 	usb {
 		usb_host_pwren: usb-host-pwren {
-			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+		usb_otg_pwren: usb-otg-pwren {
+			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_down>;
+
 		};
 	};
 };
@@ -738,10 +756,20 @@
 	status = "okay";
 };
 
+&u2phy0_otg {
+	phy-supply = <&vcc_5v0_otg>;
+	status = "okay";
+};
+
 &u2phy1 {
 	status = "okay";
 };
 
+&u2phy1_otg {
+	phy-supply = <&vcc_5v0_host>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0m0_xfer>;
 	status = "okay";
@@ -751,6 +779,15 @@
 	status = "okay";
 };
 
+&usbdp_phy {
+	status = "okay";
+};
+
+&usb_drd0_dwc3 {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usb_drd1_dwc3 {
 	dr_mode = "host";
 	status = "okay";
-- 
2.51.0

