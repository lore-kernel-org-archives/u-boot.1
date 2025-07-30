Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3108AC87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 23:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED1ED8328F;
	Thu, 31 Jul 2025 01:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="xnNrurlf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDE5B8313F; Thu, 31 Jul 2025 01:53:59 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D57598319C
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 01:53:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5dd1=2M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753919635; bh=wBpVs+tydm006YV1VCL1CCsUBwdKHQVhjouW/cTChXc=;
 b=xnNrurlf0zkq9PfI5YXqQ1oNXVqTt3SQWxsSXubZH2a2UebxKYnjZyR9eHVzy73XJpGRus55+
 uQTJBxaFyO8XVFIaZTCcdZkMjCOUD1gevn2EBVSmzpRyyReOJx7xg5wOnfnasjX9BrCRyPTHWpK
 3+8zo9ZUOS2HFwZhU3cfsCbtO9E2iGrdY2om0fEIIUYwn1v8q+JOdBBpu7mxw1+uJ1280vOUJsU
 kGYJeGCmmrz35d8MqRyrEJmdkjeLuXCiYhdzvYgGvmiNjS23h53fy+DqYDZXP3RFBp7DHqoskJ6
 d4Q5n4MbVPFc+3GTOH1PKGYlI4sDyuF6pzTV4mwEDZTA==
X-Forward-Email-ID: 688ab0691851584377f620a8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
Subject: [PATCH 2/8] arm: dts: rockchip: Use sdmmc node from dts/upstream on
 RK3528
Date: Wed, 30 Jul 2025 23:52:43 +0000
Message-ID: <20250730235301.1774089-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730235301.1774089-1-jonas@kwiboo.se>
References: <20250730235301.1774089-1-jonas@kwiboo.se>
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

Drop the sdmmc node from soc u-boot.dtsi and instead use the sdmmc node
from rk3528.dtsi with v6.16-dts now merged to dts/upstream.

This cleanup has no intended functional change.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3528-generic-u-boot.dtsi    |  9 ---------
 arch/arm/dts/rk3528-generic.dts            | 12 +++++++++++-
 arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi |  9 ---------
 arch/arm/dts/rk3528-u-boot.dtsi            | 18 ------------------
 4 files changed, 11 insertions(+), 37 deletions(-)

diff --git a/arch/arm/dts/rk3528-generic-u-boot.dtsi b/arch/arm/dts/rk3528-generic-u-boot.dtsi
index cc830b514567..9e1fb2a7eef6 100644
--- a/arch/arm/dts/rk3528-generic-u-boot.dtsi
+++ b/arch/arm/dts/rk3528-generic-u-boot.dtsi
@@ -1,12 +1,3 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
 #include "rk3528-u-boot.dtsi"
-
-&sdmmc {
-	bus-width = <4>;
-	cap-sd-highspeed;
-	disable-wp;
-	no-mmc;
-	no-sdio;
-	status = "okay";
-};
diff --git a/arch/arm/dts/rk3528-generic.dts b/arch/arm/dts/rk3528-generic.dts
index fe9e72c41cd7..637ca03325ed 100644
--- a/arch/arm/dts/rk3528-generic.dts
+++ b/arch/arm/dts/rk3528-generic.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Minimal generic DT for RK3528 with eMMC enabled
+ * Minimal generic DT for RK3528 with eMMC and SD-card enabled
  */
 
 /dts-v1/;
@@ -12,6 +12,7 @@
 
 	aliases {
 		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
 		serial0 = &uart0;
 	};
 
@@ -30,6 +31,15 @@
 	status = "okay";
 };
 
+&sdmmc {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	no-mmc;
+	no-sdio;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0m0_xfer>;
diff --git a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
index 1372d8f1e38a..05a58c136bcd 100644
--- a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
+++ b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
@@ -5,12 +5,3 @@
 &sdhci {
 	mmc-hs200-1_8v;
 };
-
-&sdmmc {
-	bus-width = <4>;
-	cap-mmc-highspeed;
-	cap-sd-highspeed;
-	disable-wp;
-	vmmc-supply = <&vcc_3v3>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/rk3528-u-boot.dtsi b/arch/arm/dts/rk3528-u-boot.dtsi
index eb6a55cd5c93..a18d33b3d369 100644
--- a/arch/arm/dts/rk3528-u-boot.dtsi
+++ b/arch/arm/dts/rk3528-u-boot.dtsi
@@ -27,24 +27,6 @@
 			compatible = "rockchip,rk3528-otp";
 			reg = <0x0 0xffce0000 0x0 0x4000>;
 		};
-
-		sdmmc: mmc@ffc30000 {
-			compatible = "rockchip,rk3528-dw-mshc",
-				     "rockchip,rk3288-dw-mshc";
-			reg = <0x0 0xffc30000 0x0 0x4000>;
-			clocks = <&cru HCLK_SDMMC0>, <&cru CCLK_SRC_SDMMC0>;
-			clock-names = "biu", "ciu";
-			fifo-depth = <0x100>;
-			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
-			max-frequency = <150000000>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&sdmmc_bus4>, <&sdmmc_clk>, <&sdmmc_cmd>,
-				    <&sdmmc_det>;
-			resets = <&cru SRST_H_SDMMC0>;
-			reset-names = "reset";
-			rockchip,default-sample-phase = <90>;
-			status = "disabled";
-		};
 	};
 };
 
-- 
2.50.1

