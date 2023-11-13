Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF56C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 15:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CB7F871D7;
	Mon, 13 Nov 2023 15:59:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="w+WP4uqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46E0487154; Mon, 13 Nov 2023 15:59:39 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 263FF8714E
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:59:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADExRhr022836;
 Mon, 13 Nov 2023 08:59:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699887567;
 bh=sqmvULq0ayZzRbW0c8s01tKi62jwNGcVFWUxwp+tRtg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=w+WP4uqoEB8BOHNFYP7HAOm2jtuv8FEuJE9pZubARhjwvhyToAwr2ftiLjeKjgwMf
 62iTOfXuhKpF1ssmNW3WHiBC+X9w0vBxeWyujrkzQ1KTnfwHM+S6T1pOLdRI/dD1p7
 dRSpp1r9pQeHIJoyECWZl1Wb8Rt5lBblT/AYsalw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADExRV3103479
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Nov 2023 08:59:27 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 08:59:26 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 08:59:27 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADExQXn059855;
 Mon, 13 Nov 2023 08:59:26 -0600
From: Nishanth Menon <nm@ti.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, Tom Rini
 <trini@konsulko.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Jai Luthra <j-luthra@ti.com>, <u-boot@lists.denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Sjoerd Simons <sjoerd@collabora.com>, Robert
 Nelson <robertcnelson@gmail.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/4] arm: dts: k3-am625: Drop SoC provided bootph params from
 board u-boot/r5 dtsi
Date: Mon, 13 Nov 2023 08:59:17 -0600
Message-ID: <20231113145919.1928812-3-nm@ti.com>
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

k3-am62* SoC dtsi files now provide the following:

bootph-all: dmss secure_proxy_main dmsc k3_pds k3_clks k3_reset
   main_pmx0 main_timer0 mcu_pmx0 wkup_conf chipid

bootph-pre-ram: secure_proxy_sa3 main_esm mcu_esm

Drop these from board r5 and u-boot.dtsi files as these are duplicate in
them now.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  | 54 ------------------
 arch/arm/dts/k3-am625-r5-beagleplay.dts       |  9 ---
 arch/arm/dts/k3-am625-r5-sk.dts               |  9 ---
 arch/arm/dts/k3-am625-sk-u-boot.dtsi          | 53 ------------------
 arch/arm/dts/k3-am625-verdin-r5.dts           |  9 ---
 .../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi  | 55 +------------------
 6 files changed, 2 insertions(+), 187 deletions(-)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index d6c6baa5518b..6f3a31558b20 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -47,59 +47,17 @@
 	};
 };
 
-&cbass_main {
-	bootph-all;
-};
-
 &main_timer0 {
 	clock-frequency = <25000000>;
-	bootph-all;
-};
-
-&dmss {
-	bootph-all;
-};
-
-&secure_proxy_main {
-	bootph-all;
-};
-
-&dmsc {
-	bootph-all;
-};
-
-&k3_pds {
-	bootph-all;
-};
-
-&k3_clks {
-	bootph-all;
-};
-
-&k3_reset {
-	bootph-all;
 };
 
 &dmsc {
-	bootph-all;
 	k3_sysreset: sysreset-controller {
 		compatible = "ti,sci-sysreset";
 		bootph-all;
 	};
 };
 
-&wkup_conf {
-	bootph-all;
-};
-
-&chipid {
-	bootph-all;
-};
-
-&main_pmx0 {
-	bootph-all;
-};
-
 &main_uart0 {
 	bootph-all;
 };
@@ -108,18 +66,6 @@
 	bootph-all;
 };
 
-&cbass_mcu {
-	bootph-all;
-};
-
-&cbass_wakeup {
-	bootph-all;
-};
-
-&mcu_pmx0 {
-	bootph-all;
-};
-
 &main_i2c0 {
 	bootph-all;
 };
diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-am625-r5-beagleplay.dts
index 9c9d0570592a..1f450f55c1d2 100644
--- a/arch/arm/dts/k3-am625-r5-beagleplay.dts
+++ b/arch/arm/dts/k3-am625-r5-beagleplay.dts
@@ -54,12 +54,7 @@
 	ti,secure-host;
 };
 
-&mcu_esm {
-	bootph-pre-ram;
-};
-
 &secure_proxy_sa3 {
-	bootph-pre-ram;
 	/* We require this for boot handshake */
 	status = "okay";
 };
@@ -73,10 +68,6 @@
 	};
 };
 
-&main_esm {
-	bootph-pre-ram;
-};
-
 &main_pktdma {
 	ti,sci = <&dm_tifs>;
 };
diff --git a/arch/arm/dts/k3-am625-r5-sk.dts b/arch/arm/dts/k3-am625-r5-sk.dts
index bf219226b974..55420b2f2c15 100644
--- a/arch/arm/dts/k3-am625-r5-sk.dts
+++ b/arch/arm/dts/k3-am625-r5-sk.dts
@@ -55,20 +55,11 @@
 	ti,secure-host;
 };
 
-&mcu_esm {
-	bootph-pre-ram;
-};
-
 &secure_proxy_sa3 {
-	bootph-pre-ram;
 	/* We require this for boot handshake */
 	status = "okay";
 };
 
-&main_esm {
-	bootph-pre-ram;
-};
-
 &cbass_main {
 	sysctrler: sysctrler {
 		compatible = "ti,am654-system-controller";
diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
index 7ae5e01f7c7f..dcf7c7652d31 100644
--- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
@@ -25,49 +25,8 @@
 	bootph-all;
 };
 
-&cbass_main {
-	bootph-all;
-};
-
 &main_timer0 {
 	clock-frequency = <25000000>;
-	bootph-all;
-};
-
-&dmss {
-	bootph-all;
-};
-
-&secure_proxy_main {
-	bootph-all;
-};
-
-&dmsc {
-	bootph-all;
-};
-
-&k3_pds {
-	bootph-all;
-};
-
-&k3_clks {
-	bootph-all;
-};
-
-&k3_reset {
-	bootph-all;
-};
-
-&wkup_conf {
-	bootph-all;
-};
-
-&chipid {
-	bootph-all;
-};
-
-&main_pmx0 {
-	bootph-all;
 };
 
 &main_uart0 {
@@ -78,18 +37,6 @@
 	bootph-all;
 };
 
-&cbass_mcu {
-	bootph-all;
-};
-
-&cbass_wakeup {
-	bootph-all;
-};
-
-&mcu_pmx0 {
-	bootph-all;
-};
-
 &sdhci1 {
 	bootph-all;
 };
diff --git a/arch/arm/dts/k3-am625-verdin-r5.dts b/arch/arm/dts/k3-am625-verdin-r5.dts
index 0cae9c577732..305d199678b3 100644
--- a/arch/arm/dts/k3-am625-verdin-r5.dts
+++ b/arch/arm/dts/k3-am625-verdin-r5.dts
@@ -69,16 +69,7 @@
 	ti,secure-host;
 };
 
-&main_esm {
-	bootph-pre-ram;
-};
-
-&mcu_esm {
-	bootph-pre-ram;
-};
-
 &secure_proxy_sa3 {
-	bootph-pre-ram;
 	/* We require this for boot handshake */
 	status = "okay";
 };
diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
index 75cb60b57d79..86e2d111f541 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
@@ -21,25 +21,8 @@
 	};
 };
 
-&cbass_main {
-	bootph-all;
-
-	timer@2400000 {
-		clock-frequency = <25000000>;
-		bootph-all;
-	};
-};
-
-&cbass_mcu {
-	bootph-all;
-};
-
-&cbass_wakeup {
-	bootph-all;
-};
-
-&chipid {
-	bootph-all;
+&main_timer0 {
+	clock-frequency = <25000000>;
 };
 
 &main_bcdma {
@@ -98,34 +81,16 @@
 };
 
 &dmsc {
-	bootph-all;
-
 	k3_sysreset: sysreset-controller {
 		compatible = "ti,sci-sysreset";
 		bootph-all;
 	};
 };
 
-&dmss {
-	bootph-all;
-};
-
 &fss {
 	bootph-all;
 };
 
-&k3_clks {
-	bootph-all;
-};
-
-&k3_pds {
-	bootph-all;
-};
-
-&k3_reset {
-	bootph-all;
-};
-
 &main_gpio0 {
 	bootph-all;
 };
@@ -156,10 +121,6 @@
 	};
 };
 
-&main_pmx0 {
-	bootph-all;
-};
-
 /* Verdin UART_3, used as the Linux console */
 &main_uart0 {
 	bootph-all;
@@ -170,10 +131,6 @@
 	bootph-all;
 };
 
-&mcu_pmx0 {
-	bootph-all;
-};
-
 &pinctrl_ctrl_sleep_moci {
 	bootph-all;
 };
@@ -210,18 +167,10 @@
 	status = "disabled";
 };
 
-&secure_proxy_main {
-	bootph-all;
-};
-
 &verdin_ctrl_sleep_moci {
 	bootph-all;
 };
 
-&wkup_conf {
-	bootph-all;
-};
-
 /* Verdin UART_2 */
 &wkup_uart0 {
 	bootph-all;
-- 
2.40.0

