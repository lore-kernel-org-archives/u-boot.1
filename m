Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0856FD31A28
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 08:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFC92830A0;
	Wed, 14 Jan 2026 09:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="0iRq+Teq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22E2383979; Wed, 14 Jan 2026 09:28:37 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EE2F836C8
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 09:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
 bh=2eNv4JjXSsAAiq37qDVh6HIhomYdZuj5HTFNVPz231Q=; b=0iRq+TeqvFOj2o/rxYcIFFlnHn
 e7ukO43jFSXOpQ0Vn3sDgrcSTUzBS1japfEElR13XM3K5/g9st4Pxk02KOH1YWbiH0EIpUb7YK+JG
 Rh1pO8n/U4NwforyvVvE04KWNkYICIfjh5+KivIeAevaqnspIB4s+PdjDrYdqEK51NQj3bPOp9hxG
 Cshbvi8U37uHEgB/NtCMIsXsOWrPywdcTPPR995yvuV9jHg/XmR1ykIE7fGDKa9CXgPSdg/cnScdq
 2+8AZTeIVf68W6gNu8x8N56b9uBEUwpzjiiuWrVMMve0hDy9x6SAfpfkHJnPThpZLmVblDnpazOFs
 br751bnA==;
Received: from i53875b96.versanet.de ([83.135.91.150] helo=phil..)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1vfwEw-002G0M-O9; Wed, 14 Jan 2026 09:28:31 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de,
	trini@konsulko.com,
	u-boot@lists.denx.de
Subject: [PATCH v2 07/12] arm64: dts: rockchip: move cpu_thermal node to the
 correct position
Date: Wed, 14 Jan 2026 09:28:17 +0100
Message-ID: <20260114082822.4007128-8-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20260114082822.4007128-1-heiko@sntech.de>
References: <20260114082822.4007128-1-heiko@sntech.de>
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

The &cpu_thermal node was added at the wrong position, move it to
the correctly sorted one.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20251112214206.423244-2-heiko@sntech.de

[ upstream commit: 15efa2414602ad4c411ea8d4113b87656ebe0737 ]

(cherry picked from commit 0ac36d180d89464e8dda0287cee633ad71c43211)
---
 .../src/arm64/rockchip/rk3568-qnap-ts433.dts  | 96 +++++++++----------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
index 6ae4316761c..5656554ca28 100644
--- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
@@ -196,6 +196,54 @@
 	cpu-supply = <&vdd_cpu>;
 };
 
+/*
+ * The MCU can provide system temperature too, but only by polling and of
+ * course also cannot set trip points. So attach to the cpu thermal-zone
+ * instead to control the fan.
+ */
+&cpu_thermal {
+	trips {
+		case_fan0: case-fan0 {
+			hysteresis = <2000>;
+			temperature = <35000>;
+			type = "active";
+		};
+
+		case_fan1: case-fan1 {
+			hysteresis = <2000>;
+			temperature = <45000>;
+			type = "active";
+		};
+
+		case_fan2: case-fan2 {
+			hysteresis = <2000>;
+			temperature = <65000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		/*
+		 * Always provide some air movement, due to small case
+		 * full of harddrives.
+		 */
+		map1 {
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+			trip = <&case_fan0>;
+		};
+
+		map2 {
+			cooling-device = <&fan 2 3>;
+			trip = <&case_fan1>;
+		};
+
+		map3 {
+			cooling-device = <&fan 4 THERMAL_NO_LIMIT>;
+			trip = <&case_fan2>;
+		};
+	};
+};
+
 &gmac0 {
 	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
 	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>, <&cru CLK_MAC0_2TOP>;
@@ -492,54 +540,6 @@
 	};
 };
 
-/*
- * The MCU can provide system temperature too, but only by polling and of
- * course also cannot set trip points. So attach to the cpu thermal-zone
- * instead to control the fan.
- */
-&cpu_thermal {
-	trips {
-		case_fan0: case-fan0 {
-			hysteresis = <2000>;
-			temperature = <35000>;
-			type = "active";
-		};
-
-		case_fan1: case-fan1 {
-			hysteresis = <2000>;
-			temperature = <45000>;
-			type = "active";
-		};
-
-		case_fan2: case-fan2 {
-			hysteresis = <2000>;
-			temperature = <65000>;
-			type = "active";
-		};
-	};
-
-	cooling-maps {
-		/*
-		 * Always provide some air movement, due to small case
-		 * full of harddrives.
-		 */
-		map1 {
-			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
-			trip = <&case_fan0>;
-		};
-
-		map2 {
-			cooling-device = <&fan 2 3>;
-			trip = <&case_fan1>;
-		};
-
-		map3 {
-			cooling-device = <&fan 4 THERMAL_NO_LIMIT>;
-			trip = <&case_fan2>;
-		};
-	};
-};
-
 &pcie30phy {
 	data-lanes = <1 2>;
 	status = "okay";
-- 
2.47.2

