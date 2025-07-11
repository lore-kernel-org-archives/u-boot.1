Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D24C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 22:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B0908277D;
	Sat, 12 Jul 2025 00:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="g4A+UsQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4757682F8F; Sat, 12 Jul 2025 00:45:10 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DCA98277D
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 00:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2656=ZZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752273906; bh=o2TgYxoMm1UlZLq/H3GIOk81VB1eFV3YyYBzkHLjZbc=;
 b=g4A+UsQrY8fdBX/lhUDrQM9NJWiP8khDgEG40Nf9Ymj64ey2H2JHJMOaneMwYl+4/QxgzXGxK
 BYInbd/AW23bHLSuoFB8vZGyjpqa8JGZ+BsDGKgCYY0Ab4XpibpviWfYeNr5r1SVj1x9IeyzAH9
 NkNNiFSGLXDU3qMs3vzVgrakImQ6weo3TCLByLRO9DmMeEnYGRpN3EnXZIaH50ATzMpyxnc1LV+
 cwLJdWscNiganUkr5eC64jT/Lqagm1uXppmdKB1UalyuWea4ogioCVvlocqu3QYSCaidSnc4NSQ
 Yod4p+aHN/MbwZMzMXZFkwgaKClmaWphCR/0+0i7Myjg==
X-Forward-Email-ID: 687193ee26dc7c4d2556116d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 3/6] arm64: dts: rockchip: enable pcie on Sige5
Date: Fri, 11 Jul 2025 22:44:33 +0000
Message-ID: <20250711224446.211511-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711224446.211511-1-jonas@kwiboo.se>
References: <20250711224446.211511-1-jonas@kwiboo.se>
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

The ArmSoM Sige5 board exposes PCIe controller 0 on its M.2 slot on the
bottom of the board. Enable the necessary nodes for it, and also add the
correct pins for both the power enable GPIO and the PCIe reset GPIO.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Link: https://lore.kernel.org/r/20250414-rk3576-sige5-pcie-v1-1-0e950a96f392@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 34b69113ab975e8718b24b9b2cd4b1ea8dc107d8 ]

(cherry picked from commit c88c9d3b42f790289d95ecfa73d196e641de30bd)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 .../arm64/rockchip/rk3576-armsom-sige5.dts    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3576-armsom-sige5.dts b/dts/upstream/src/arm64/rockchip/rk3576-armsom-sige5.dts
index 314067ba6f3c..570252c4c0bf 100644
--- a/dts/upstream/src/arm64/rockchip/rk3576-armsom-sige5.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3576-armsom-sige5.dts
@@ -117,6 +117,8 @@
 
 	vcc_3v3_pcie: regulator-vcc-3v3-pcie {
 		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_pwr_en>;
 		regulator-name = "vcc_3v3_pcie";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -177,6 +179,10 @@
 	};
 };
 
+&combphy0_ps {
+	status = "okay";
+};
+
 &cpu_l0 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
 };
@@ -634,6 +640,14 @@
 	};
 };
 
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_reset>;
+	reset-gpios = <&gpio2 RK_PB4 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc_3v3_pcie>;
+	status = "okay";
+};
+
 &pinctrl {
 	headphone {
 		hp_det: hp-det {
@@ -655,6 +669,15 @@
 			rockchip,pins = <4 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	pcie {
+		pcie_pwr_en: pcie-pwr-en {
+			rockchip,pins = <3 RK_PD6 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+		pcie_reset: pcie-reset {
+			rockchip,pins = <2 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
 };
 
 &sdhci {
-- 
2.49.0

