Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC8ACA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 16:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 134D5839A9;
	Thu, 14 Aug 2025 18:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CKHgjipN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37D77839AC; Thu, 14 Aug 2025 18:10:49 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95D6B8399D
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 18:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EFPXEf1961008;
 Thu, 14 Aug 2025 10:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755185133;
 bh=nIu5O95qWt1VGKQELx51MINJtY5Tk7URJus9zXRkkjY=;
 h=From:To:CC:Subject:Date;
 b=CKHgjipNQ2Ni9M+7LvI5yDiR5GKDyi/lkMktKYk7qTllzidn4fE1bL5p2h8QQT3e9
 EOvMzaAV//W/6DlWf8D/V418+cUhXSU1OjvUNyUA6pA7MTYzoBY3RzrBFsS4SSE++C
 /3GNybYHb0nWD4et/AdoKvRe2JYp0tDJt38mz8bI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EFPXo71799625
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 14 Aug 2025 10:25:33 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 10:25:33 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 10:25:33 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EFPVKT4116390;
 Thu, 14 Aug 2025 10:25:32 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <praneeth@ti.com>
Subject: [PATCH v1] remoteproc: k3: update compatible for am654 syscon
Date: Thu, 14 Aug 2025 20:51:43 +0530
Message-ID: <20250814152145.2853307-1-anshuld@ti.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

The existing compatible name for U-Boot's k3 system controller driver
i.e "ti,am625-system-controller" has been added to linux[1] device-tree.
This compatible in kernel is meant for configuring the Control Module
registers (CTRL_MMR0).

However in U-Boot, the matching driver was being used to load the system
firmware on the secure M-cores by the R5 SPL and therefore must be
updated to a different compatible to avoid conflicts.

Therefore, this patch renames all references of the compatible to
"ti,am654-tisci-rproc-r5". The "-r5" is appended so as to avoid any
future conflicts since r5 specific compatibles should only be useful for
U-Boot.

[1]: 5959618631fe ("dt-bindings: mfd: ti,j721e-system-controller: Add compatible string for AM654")
     https://lore.kernel.org/r/20250421214620.3770172-2-afd@ti.com
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/dts/k3-am62-r5-lp-sk.dts                            | 2 +-
 arch/arm/dts/k3-am625-r5-beagleplay.dts                      | 2 +-
 arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts                 | 2 +-
 arch/arm/dts/k3-am625-r5-sk.dts                              | 2 +-
 arch/arm/dts/k3-am625-verdin-r5.dts                          | 2 +-
 arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts                | 2 +-
 arch/arm/dts/k3-am62a7-r5-sk.dts                             | 2 +-
 arch/arm/dts/k3-am62p5-r5-sk.dts                             | 2 +-
 arch/arm/dts/k3-am62p5-verdin-r5.dts                         | 2 +-
 arch/arm/dts/k3-am642-r5-evm.dts                             | 2 +-
 arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts                 | 2 +-
 arch/arm/dts/k3-am642-r5-sk.dts                              | 2 +-
 arch/arm/dts/k3-am654-r5-base-board.dts                      | 2 +-
 arch/arm/dts/k3-am67a-r5-beagley-ai.dts                      | 2 +-
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts               | 2 +-
 arch/arm/dts/k3-j721e-r5.dtsi                                | 2 +-
 arch/arm/dts/k3-j721s2-r5.dtsi                               | 2 +-
 arch/arm/dts/k3-j722s-r5-evm.dts                             | 2 +-
 arch/arm/dts/k3-j784s4-r5.dtsi                               | 2 +-
 doc/device-tree-bindings/power/ti,sci-pm-domain.txt          | 2 +-
 doc/device-tree-bindings/remoteproc/k3-system-controller.txt | 4 ++--
 doc/device-tree-bindings/reset/ti,sci-reset.txt              | 2 +-
 drivers/remoteproc/k3_system_controller.c                    | 2 +-
 23 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/dts/k3-am62-r5-lp-sk.dts b/arch/arm/dts/k3-am62-r5-lp-sk.dts
index 135e8d49b91..95cd9b707c7 100644
--- a/arch/arm/dts/k3-am62-r5-lp-sk.dts
+++ b/arch/arm/dts/k3-am62-r5-lp-sk.dts
@@ -64,7 +64,7 @@
 
 &cbass_main {
 	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_main 1>,
 			<&secure_proxy_main 0>,
 			<&secure_proxy_sa3 0>;
diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-am625-r5-beagleplay.dts
index f4b2cd8904e..bba69871fd2 100644
--- a/arch/arm/dts/k3-am625-r5-beagleplay.dts
+++ b/arch/arm/dts/k3-am625-r5-beagleplay.dts
@@ -70,7 +70,7 @@
 
 &cbass_main {
 	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
 		mbox-names = "tx", "rx", "boot_notify";
 		bootph-pre-ram;
diff --git a/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
index 7132fae36fa..03dc81a4afa 100644
--- a/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
+++ b/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
@@ -69,7 +69,7 @@
 
 &cbass_main {
 	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
 		mbox-names = "tx", "rx", "boot_notify";
 		bootph-pre-ram;
diff --git a/arch/arm/dts/k3-am625-r5-sk.dts b/arch/arm/dts/k3-am625-r5-sk.dts
index 34c501dd51b..67589f941ba 100644
--- a/arch/arm/dts/k3-am625-r5-sk.dts
+++ b/arch/arm/dts/k3-am625-r5-sk.dts
@@ -64,7 +64,7 @@
 
 &cbass_main {
 	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
 		mbox-names = "tx", "rx", "boot_notify";
 		bootph-pre-ram;
diff --git a/arch/arm/dts/k3-am625-verdin-r5.dts b/arch/arm/dts/k3-am625-verdin-r5.dts
index 39e8ab8158e..fb431c96337 100644
--- a/arch/arm/dts/k3-am625-verdin-r5.dts
+++ b/arch/arm/dts/k3-am625-verdin-r5.dts
@@ -53,7 +53,7 @@
 
 &cbass_main {
 	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
 		mbox-names = "tx", "rx", "boot_notify";
 		bootph-pre-ram;
diff --git a/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
index 63b7864a469..96860e80e9a 100644
--- a/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
+++ b/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
@@ -70,7 +70,7 @@
 	};
 
 	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_main 1>,
 			<&secure_proxy_main 0>,
 			<&sa3_secproxy 0>;
diff --git a/arch/arm/dts/k3-am62a7-r5-sk.dts b/arch/arm/dts/k3-am62a7-r5-sk.dts
index 49e62533a95..64923c2c710 100644
--- a/arch/arm/dts/k3-am62a7-r5-sk.dts
+++ b/arch/arm/dts/k3-am62a7-r5-sk.dts
@@ -63,7 +63,7 @@
 
 &cbass_main {
 	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_main 1>,
 			<&secure_proxy_main 0>,
 			<&secure_proxy_sa3 0>;
diff --git a/arch/arm/dts/k3-am62p5-r5-sk.dts b/arch/arm/dts/k3-am62p5-r5-sk.dts
index b18b4ce1272..e45d2bf6a0b 100644
--- a/arch/arm/dts/k3-am62p5-r5-sk.dts
+++ b/arch/arm/dts/k3-am62p5-r5-sk.dts
@@ -69,7 +69,7 @@
 	};
 
 	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_main 1>,
 			<&secure_proxy_main 0>,
 			<&sa3_secproxy 0>;
diff --git a/arch/arm/dts/k3-am62p5-verdin-r5.dts b/arch/arm/dts/k3-am62p5-verdin-r5.dts
index 983a3bfe670..17739086935 100644
--- a/arch/arm/dts/k3-am62p5-verdin-r5.dts
+++ b/arch/arm/dts/k3-am62p5-verdin-r5.dts
@@ -57,7 +57,7 @@
 	};
 
 	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_main 1>,
 			<&secure_proxy_main 0>,
 			<&sa3_secproxy 0>;
diff --git a/arch/arm/dts/k3-am642-r5-evm.dts b/arch/arm/dts/k3-am642-r5-evm.dts
index 933f75095b1..67b8587d3b2 100644
--- a/arch/arm/dts/k3-am642-r5-evm.dts
+++ b/arch/arm/dts/k3-am642-r5-evm.dts
@@ -43,7 +43,7 @@
 
 &cbass_main {
 	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>;
 		mbox-names = "tx", "rx";
 		bootph-pre-ram;
diff --git a/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
index 40c25d5dbb6..32a10b24327 100644
--- a/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
+++ b/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
@@ -63,7 +63,7 @@
 
 &cbass_main {
 	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>;
 		mbox-names = "tx", "rx";
 		bootph-pre-ram;
diff --git a/arch/arm/dts/k3-am642-r5-sk.dts b/arch/arm/dts/k3-am642-r5-sk.dts
index 6e31dfd97c5..cfc548a1cea 100644
--- a/arch/arm/dts/k3-am642-r5-sk.dts
+++ b/arch/arm/dts/k3-am642-r5-sk.dts
@@ -43,7 +43,7 @@
 
 &cbass_main {
 	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>;
 		mbox-names = "tx", "rx";
 		bootph-pre-ram;
diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index ab5195eb15c..99eb8a2d442 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -47,7 +47,7 @@
 
 &cbass_wakeup {
 	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>;
 		mbox-names = "tx", "rx";
 		bootph-pre-ram;
diff --git a/arch/arm/dts/k3-am67a-r5-beagley-ai.dts b/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
index 664be358a97..45d104e8e3f 100644
--- a/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
+++ b/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
@@ -69,7 +69,7 @@
 	};
 
 	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_main 1>,
 			<&secure_proxy_main 0>,
 			<&sa3_secproxy 0>;
diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index 9ac29110324..e35b767a7e3 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -69,7 +69,7 @@
 
 &cbass_mcu_wakeup {
 	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_mcu 4>,
 			<&secure_proxy_mcu 5>;
 		mbox-names = "tx", "rx";
diff --git a/arch/arm/dts/k3-j721e-r5.dtsi b/arch/arm/dts/k3-j721e-r5.dtsi
index 786a41c5e90..7398f9b05ec 100644
--- a/arch/arm/dts/k3-j721e-r5.dtsi
+++ b/arch/arm/dts/k3-j721e-r5.dtsi
@@ -66,7 +66,7 @@
 &cbass_mcu_wakeup {
 	sysctrler: sysctrler {
 		bootph-pre-ram;
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>;
 		mbox-names = "tx", "rx";
 	};
diff --git a/arch/arm/dts/k3-j721s2-r5.dtsi b/arch/arm/dts/k3-j721s2-r5.dtsi
index a820f516015..c1c12e217d2 100644
--- a/arch/arm/dts/k3-j721s2-r5.dtsi
+++ b/arch/arm/dts/k3-j721s2-r5.dtsi
@@ -63,7 +63,7 @@
 
 &cbass_mcu_wakeup {
 	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>, <&secure_proxy_sa3 5>;
 		mbox-names = "tx", "rx", "boot_notify";
 		bootph-pre-ram;
diff --git a/arch/arm/dts/k3-j722s-r5-evm.dts b/arch/arm/dts/k3-j722s-r5-evm.dts
index 286ab50d3da..02a3494a877 100644
--- a/arch/arm/dts/k3-j722s-r5-evm.dts
+++ b/arch/arm/dts/k3-j722s-r5-evm.dts
@@ -68,7 +68,7 @@
 	};
 
 	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_main 1>,
 			<&secure_proxy_main 0>,
 			<&sa3_secproxy 0>;
diff --git a/arch/arm/dts/k3-j784s4-r5.dtsi b/arch/arm/dts/k3-j784s4-r5.dtsi
index a1394115b8b..78444dc4e14 100644
--- a/arch/arm/dts/k3-j784s4-r5.dtsi
+++ b/arch/arm/dts/k3-j784s4-r5.dtsi
@@ -61,7 +61,7 @@
 
 &cbass_mcu_wakeup {
 	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		mboxes= <&secure_proxy_mcu 4>,
 			<&secure_proxy_mcu 5>,
 			<&secure_proxy_sa3 5>;
diff --git a/doc/device-tree-bindings/power/ti,sci-pm-domain.txt b/doc/device-tree-bindings/power/ti,sci-pm-domain.txt
index 72d9fbc833c..81f6314230f 100644
--- a/doc/device-tree-bindings/power/ti,sci-pm-domain.txt
+++ b/doc/device-tree-bindings/power/ti,sci-pm-domain.txt
@@ -30,7 +30,7 @@ Required Properties:
 Example (AM65x):
 ----------------
 	sysfw: sysfw {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		...
 		k3_pds: power-controller {
 			compatible = "ti,sci-pm-domain";
diff --git a/doc/device-tree-bindings/remoteproc/k3-system-controller.txt b/doc/device-tree-bindings/remoteproc/k3-system-controller.txt
index 33dc46812ed..7de57ad4f00 100644
--- a/doc/device-tree-bindings/remoteproc/k3-system-controller.txt
+++ b/doc/device-tree-bindings/remoteproc/k3-system-controller.txt
@@ -8,7 +8,7 @@ This driver communicates with ROM for loading this firmware.
 
 Required properties:
 --------------------
-- compatible:		Shall be: "ti,am654-system-controller"
+- compatible:		Shall be: "ti,am654-tisci-rproc-r5-r5"
 - mbox-names:		"tx" for Transfer channel
 			"rx" for Receive channel
 - mboxes:		Corresponding phandles to mailbox channels.
@@ -21,7 +21,7 @@ Example:
 --------
 
 system-controller: system-controller {
-	compatible = "ti,am654-system-controller";
+	compatible = "ti,am654-tisci-rproc-r5-r5";
 	mboxes= <&secproxy 4>, <&secproxy 5>;
 	mbox-names = "tx", "rx";
 };
diff --git a/doc/device-tree-bindings/reset/ti,sci-reset.txt b/doc/device-tree-bindings/reset/ti,sci-reset.txt
index e7e2d13f9fb..740b2dfea64 100644
--- a/doc/device-tree-bindings/reset/ti,sci-reset.txt
+++ b/doc/device-tree-bindings/reset/ti,sci-reset.txt
@@ -23,7 +23,7 @@ Required Properties:
 Example (AM65x):
 ----------------
 	sysfw: sysfw {
-		compatible = "ti,am654-system-controller";
+		compatible = "ti,am654-tisci-rproc-r5";
 		...
 		k3_reset: reset-controller {
 			compatible = "ti,sci-reset";
diff --git a/drivers/remoteproc/k3_system_controller.c b/drivers/remoteproc/k3_system_controller.c
index 71238a6058a..e59c010de7e 100644
--- a/drivers/remoteproc/k3_system_controller.c
+++ b/drivers/remoteproc/k3_system_controller.c
@@ -327,7 +327,7 @@ static const struct k3_sysctrler_desc k3_sysctrler_am654_desc = {
 
 static const struct udevice_id k3_sysctrler_ids[] = {
 	{
-		.compatible = "ti,am654-system-controller",
+		.compatible = "ti,am654-tisci-rproc-r5",
 		.data = (ulong)&k3_sysctrler_am654_desc,
 	},
 	{}
-- 
2.50.1

