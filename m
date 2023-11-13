Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB341C4167B
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 14:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41B47871BE;
	Mon, 13 Nov 2023 15:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eHlz288P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A433871AB; Mon, 13 Nov 2023 15:59:37 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F284886689
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADExRel002142;
 Mon, 13 Nov 2023 08:59:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699887567;
 bh=mKkuwLJQ+6uM6vBaHJHfwIzU2WTRZrm9Hn3JEtk+cFM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=eHlz288PGXxZRtnwMHUh6G+ZxDTDhnLczlJZ9az37Vh/rkd/L/wvGVGYH+QAgTSR0
 Qw3EuoXmNJYr34/+iuqgeYe6PwdiKdLUBm4kzVxeNeb1xSnk5V3jurZUUks/QB/awN
 A4Eff3NSM/dwPZnGwQ71yzfBGJ3ZG4oId59Hpfr0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADExRLU030039
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Nov 2023 08:59:27 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 08:59:27 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 08:59:27 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADExRfV080221;
 Mon, 13 Nov 2023 08:59:27 -0600
From: Nishanth Menon <nm@ti.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, Tom Rini
 <trini@konsulko.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Jai Luthra <j-luthra@ti.com>, <u-boot@lists.denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Sjoerd Simons <sjoerd@collabora.com>, Robert
 Nelson <robertcnelson@gmail.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 4/4] arm: dts: k3-am625-sk-r5/u-boot: Drop duplicate
 bootph-nodes
Date: Mon, 13 Nov 2023 08:59:19 -0600
Message-ID: <20231113145919.1928812-5-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231113145919.1928812-1-nm@ti.com>
References: <20231113145919.1928812-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Kernel dts import now provides bootph-all and bootph-pre-ram properties
for the properties we have been overriding so far. Drop the same.

While at this enable the DM and tifs uarts for programming pinmux
since they are marked reserved by board.dts

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/dts/k3-am625-r5-sk.dts      | 12 +---
 arch/arm/dts/k3-am625-sk-u-boot.dtsi | 92 ----------------------------
 2 files changed, 2 insertions(+), 102 deletions(-)

diff --git a/arch/arm/dts/k3-am625-r5-sk.dts b/arch/arm/dts/k3-am625-r5-sk.dts
index 55420b2f2c15..6b9f40e55581 100644
--- a/arch/arm/dts/k3-am625-r5-sk.dts
+++ b/arch/arm/dts/k3-am625-r5-sk.dts
@@ -69,22 +69,14 @@
 	};
 };
 
-&wkup_uart0_pins_default {
-	bootph-pre-ram;
-};
-
-&main_uart1_pins_default {
-	bootph-pre-ram;
-};
-
 /* WKUP UART0 is used for DM firmware logs */
 &wkup_uart0 {
-	bootph-pre-ram;
+	status = "okay";
 };
 
 /* Main UART1 is used for TIFS firmware logs */
 &main_uart1 {
-	bootph-pre-ram;
+	status = "okay";
 };
 
 &ospi0 {
diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
index dcf7c7652d31..fa778b0ff4c1 100644
--- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
@@ -8,71 +8,14 @@
 
 / {
 	chosen {
-		stdout-path = "serial2:115200n8";
 		tick-timer = &main_timer0;
 	};
-
-	aliases {
-		mmc1 = &sdhci1;
-	};
-
-	memory@80000000 {
-		bootph-all;
-	};
-};
-
-&main_conf {
-	bootph-all;
 };
 
 &main_timer0 {
 	clock-frequency = <25000000>;
 };
 
-&main_uart0 {
-	bootph-all;
-};
-
-&main_uart0_pins_default {
-	bootph-all;
-};
-
-&sdhci1 {
-	bootph-all;
-};
-
-&main_mmc1_pins_default {
-	bootph-all;
-};
-
-&fss {
-	bootph-all;
-};
-
-&ospi0_pins_default {
-	bootph-all;
-};
-
-&ospi0 {
-	bootph-all;
-
-	flash@0 {
-		bootph-all;
-
-		partitions {
-			bootph-all;
-
-			partition@3fc0000 {
-				bootph-all;
-			};
-		};
-	};
-};
-
-&inta_main_dmss {
-	bootph-all;
-};
-
 &main_bcdma {
 	reg = <0x00 0x485c0100 0x00 0x100>,
 	      <0x00 0x4c000000 0x00 0x20000>,
@@ -100,41 +43,6 @@
 	bootph-all;
 };
 
-&cpsw3g_mdio {
-	bootph-all;
-};
-
-&cpsw3g_phy0 {
-	bootph-all;
-};
-
-&cpsw3g_phy1 {
-	bootph-all;
-};
-
-&main_rgmii1_pins_default {
-	bootph-all;
-};
-
-&main_rgmii2_pins_default {
-	bootph-all;
-};
-
-&phy_gmii_sel {
-	bootph-all;
-};
-
-&cpsw3g {
-	bootph-all;
-	ethernet-ports {
-		bootph-all;
-	};
-};
-
-&cpsw_port1 {
-	bootph-all;
-};
-
 &cpsw_port2 {
 	status = "disabled";
 };
-- 
2.40.0

