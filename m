Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEA7D3C530
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 20:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CEA7890AE;
	Thu, 17 Oct 2024 22:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="D7BVFOBf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2809D89093; Thu, 17 Oct 2024 22:01:07 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90E6D89078
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 22:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a54c=RO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1729195253; bh=bcmJyWG+2xaL+/AZRtDjUmJ6AYfcqpU3tVl0BuzCnxs=;
 b=D7BVFOBfxZvNJfUICL5sU2A/CqNxhqZmtryAqQEX54TA+47aRsNbDT8HznHL+PzZLB76mtq8J
 N35M38dZ2EzkC8ijDU52J0KnoH2QSd83/XJd9yJY1gSm7yB19p2xtDX0zCYD3M3A2BL4d6BE3Ki
 uR9BpqM0PRKeE7U88AUkzKVd11YC/aXsnDGZVO40PZs9gaeFDbvZRFl7syXDdwywwmVf+jiWZtm
 df5NA/FudWYik4mK5qp2hrUC0ubybJIcRk5gt4UnMUp/irl4j2YSFW5AADMbh0ZCFSCBNHNJ6da
 TLGqLsjHiokzj0rgpCfiBhQJjjrLVDBlfsVB4bVJUCzg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/8] arm64: dts: rockchip: move NanoPC-T6 parts to DTS
Date: Thu, 17 Oct 2024 20:00:21 +0000
Message-ID: <20241017200039.1235524-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017200039.1235524-1-jonas@kwiboo.se>
References: <20241017200039.1235524-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 67116cf46385e073f5ab13b5
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

MiniPCIe slot is present only in first version of NanoPC-T6 (2301).

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Link: https://lore.kernel.org/r/20240829-friendlyelec-nanopc-t6-lts-v6-3-edff247e8c02@linaro.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: aea8d84070fe0846961deb23228d9dd3f8caefb3 ]

(cherry picked from commit 697963b1c22336a44ac2e33536c652aae1671b3d)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../src/arm64/rockchip/rk3588-nanopc-t6.dts   | 23 +++++++++++++++++++
 .../src/arm64/rockchip/rk3588-nanopc-t6.dtsi  | 17 --------------
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dts b/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dts
index 3f8fbec65098..92321c1d3ff1 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dts
@@ -14,4 +14,27 @@
 	model = "FriendlyElec NanoPC-T6";
 	compatible = "friendlyarm,nanopc-t6", "rockchip,rk3588";
 
+	vdd_4g_3v3: vdd-4g-3v3-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pin_4g_lte_pwren>;
+		regulator-name = "vdd_4g_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+};
+
+&pinctrl {
+	usb {
+		pin_4g_lte_pwren: 4g-lte-pwren {
+			rockchip,pins = <4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&u2phy2_host {
+	phy-supply = <&vdd_4g_3v3>;
 };
diff --git a/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi
index ad8e36a339dc..d199f51a220c 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi
@@ -170,18 +170,6 @@
 		regulator-name = "vcc3v3_sd_s0";
 		vin-supply = <&vcc_3v3_s3>;
 	};
-
-	vdd_4g_3v3: vdd-4g-3v3-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pin_4g_lte_pwren>;
-		regulator-name = "vdd_4g_3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vcc5v0_sys>;
-	};
 };
 
 &combphy0_ps {
@@ -527,10 +515,6 @@
 	};
 
 	usb {
-		pin_4g_lte_pwren: 4g-lte-pwren {
-			rockchip,pins = <4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
 		typec5v_pwren: typec5v-pwren {
 			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
@@ -912,7 +896,6 @@
 };
 
 &u2phy2_host {
-	phy-supply = <&vdd_4g_3v3>;
 	status = "okay";
 };
 
-- 
2.46.2

