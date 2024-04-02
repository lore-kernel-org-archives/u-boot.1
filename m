Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AFDC6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 16:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C5CA8816E;
	Tue,  2 Apr 2024 18:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FOtr7v0X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4E6B8816E; Tue,  2 Apr 2024 18:09:16 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2384088164
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 18:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 432G9BHM023513;
 Tue, 2 Apr 2024 11:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712074151;
 bh=IMe3CX4G0oKcixQ+Q+EweMKzDqBVmfhzY9OdFzaxMzY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FOtr7v0XnQczGRbK47vebqOXdHHA8jhkHeMYnAfk7m268/WO3Csf/b5nC+ulIa2oL
 xzArDKXQ2uNhD4LXkMJUUlQWujnEkYuK2SR7RivynYV9TVm7Lp3cOkcq5WlZ58mQdh
 N7FZOMhVea1/wyvuSYPJXc6FpAGr8JHXPnlgzVbU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 432G9BBD007962
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 2 Apr 2024 11:09:11 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Apr 2024 11:09:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Apr 2024 11:09:10 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 432G99qT029595;
 Tue, 2 Apr 2024 11:09:10 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 2/2] arm: dts: k3: Remove unneeded ti,
 sci-sysreset binding and nodes
Date: Tue, 2 Apr 2024 11:09:08 -0500
Message-ID: <20240402160908.508974-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402160908.508974-1-afd@ti.com>
References: <20240402160908.508974-1-afd@ti.com>
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

This extra binding is non-standard and now unneeded as we bind the
sysreset driver automatically. This matches what is done in Linux
and allows us to more closely match the DTBs. Remove the binding
and all users.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  |  7 -----
 .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    |  7 -----
 .../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi  |  7 -----
 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi         |  4 ---
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi         |  5 ----
 arch/arm/dts/k3-am642-evm-u-boot.dtsi         |  7 -----
 .../k3-am642-phyboard-electra-rdk-u-boot.dtsi |  4 ---
 arch/arm/dts/k3-am642-sk-u-boot.dtsi          |  7 -----
 .../dts/k3-am65-iot2050-common-u-boot.dtsi    |  4 ---
 .../arm/dts/k3-am68-sk-base-board-u-boot.dtsi |  4 ---
 arch/arm/dts/k3-am69-sk-u-boot.dtsi           |  7 -----
 .../k3-j7200-common-proc-board-u-boot.dtsi    |  4 ---
 .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   |  4 ---
 .../k3-j721e-common-proc-board-u-boot.dtsi    |  4 ---
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |  4 ---
 .../k3-j721s2-common-proc-board-u-boot.dtsi   |  4 ---
 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi        |  7 -----
 .../sysreset/ti,sci-sysreset.txt              | 29 -------------------
 18 files changed, 119 deletions(-)
 delete mode 100644 doc/device-tree-bindings/sysreset/ti,sci-sysreset.txt

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index cca0f44b7d8..fb2032068d1 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -41,13 +41,6 @@
 	clock-frequency = <25000000>;
 };
 
-&dmsc {
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-all;
-	};
-};
-
 &sd_pins_default {
 	/* Force to use SDCD card detect pin */
 	pinctrl-single,pins = <
diff --git a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
index f6138f3058f..94162282068 100644
--- a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
@@ -42,13 +42,6 @@
 	bootph-all;
 };
 
-&dmsc {
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-all;
-	};
-};
-
 &fss {
 	bootph-all;
 };
diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
index 28b697b67ae..7fe7ae41543 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
@@ -85,13 +85,6 @@
 	bootph-all;
 };
 
-&dmsc {
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-all;
-	};
-};
-
 &fss {
 	bootph-all;
 };
diff --git a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
index 31b89b41748..c42dec16194 100644
--- a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
@@ -119,10 +119,6 @@
 
 &dmsc {
 	bootph-all;
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-all;
-	};
 };
 
 &vdd_mmc1 {
diff --git a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
index c166d655390..cf087c6e343 100644
--- a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
@@ -15,9 +15,4 @@
 
 &dmsc {
 	bootph-pre-ram;
-
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-pre-ram;
-	};
 };
diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
index ee6656774d6..705b3baa81c 100644
--- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
@@ -23,13 +23,6 @@
 	bootph-all;
 };
 
-&dmsc {
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-all;
-	};
-};
-
 &sdhci0 {
 	bootph-all;
 };
diff --git a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
index 5dfc40a843b..4677c35e2d9 100644
--- a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
@@ -29,10 +29,6 @@
 
 &dmsc {
 	bootph-all;
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-all;
-	};
 };
 
 &dmss {
diff --git a/arch/arm/dts/k3-am642-sk-u-boot.dtsi b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
index 7e6b2981346..6fcb11bd04d 100644
--- a/arch/arm/dts/k3-am642-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
@@ -15,13 +15,6 @@
 	clock-frequency = <200000000>;
 };
 
-&dmsc {
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-all;
-	};
-};
-
 &sdhci0 {
 	status = "disabled";
 };
diff --git a/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi b/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
index d53f133cd63..b6d2c816acc 100644
--- a/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
+++ b/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
@@ -99,10 +99,6 @@
 
 &dmsc {
 	bootph-all;
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-all;
-	};
 };
 
 &k3_pds {
diff --git a/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi b/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
index 4f34347586e..b8fc62f0dd1 100644
--- a/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
@@ -51,10 +51,6 @@
 
 &sms {
 	bootph-all;
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-all;
-	};
 };
 
 &main_pmx0 {
diff --git a/arch/arm/dts/k3-am69-sk-u-boot.dtsi b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
index bed330e6d4e..4a82d2fd222 100644
--- a/arch/arm/dts/k3-am69-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
@@ -23,13 +23,6 @@
 	bootph-pre-ram;
 };
 
-&sms {
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-pre-ram;
-	};
-};
-
 #ifdef CONFIG_TARGET_J784S4_A72_EVM
 
 #define SPL_AM69_SK_DTB "spl/dts/ti/k3-am69-sk.dtb"
diff --git a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
index c9fee0ea99b..485f17c5f06 100644
--- a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
@@ -57,10 +57,6 @@
 
 &dmsc {
 	bootph-all;
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-all;
-	};
 };
 
 &k3_pds {
diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
index 116ee373118..e202ae16644 100644
--- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
@@ -92,10 +92,6 @@
 
 &dmsc {
 	bootph-all;
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-all;
-	};
 };
 
 &k3_pds {
diff --git a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
index 9433f3bafae..aa919b40702 100644
--- a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
@@ -47,10 +47,6 @@
 
 &dmsc {
 	bootph-all;
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-all;
-	};
 };
 
 &k3_pds {
diff --git a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
index 8b205553cdf..8f4f944263e 100644
--- a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
@@ -47,10 +47,6 @@
 
 &dmsc {
 	bootph-all;
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-all;
-	};
 };
 
 &k3_pds {
diff --git a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
index a3ebf5996ea..19b2d48c7f8 100644
--- a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
@@ -51,10 +51,6 @@
 
 &sms {
 	bootph-all;
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-all;
-	};
 };
 
 &main_pmx0 {
diff --git a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
index ac749782bfc..8f0307321e8 100644
--- a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
@@ -22,10 +22,3 @@
 		    "tchanrt", "rflow";
 	bootph-pre-ram;
 };
-
-&sms {
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-pre-ram;
-	};
-};
diff --git a/doc/device-tree-bindings/sysreset/ti,sci-sysreset.txt b/doc/device-tree-bindings/sysreset/ti,sci-sysreset.txt
deleted file mode 100644
index 02704c6487e..00000000000
--- a/doc/device-tree-bindings/sysreset/ti,sci-sysreset.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Texas Instruments TI SCI System Reset Controller
-================================================
-
-Some TI SoCs contain a system controller (like the SYSFW, etc...) that is
-responsible for controlling the state of the IPs that are present.
-Communication between the host processor running an OS and the system
-controller happens through a protocol known as TI SCI [1].
-
-[1] http://processors.wiki.ti.com/index.php/TISCI
-
-System Reset Controller Node
-============================
-The sysreset controller node represents the reset for the overall SoC
-which is managed by the SYSFW. Because this relies on the TI SCI protocol
-to communicate with the SYSFW it must be a child of the sysfw node.
-
-Required Properties:
---------------------
- - compatible: Must be "ti,sci-sysreset"
-
-Example (AM65x):
-----------------
-	sysfw: sysfw {
-		compatible = "ti,am654-system-controller";
-		...
-		k3_sysreset: sysreset-controller {
-			compatible = "ti,sci-sysreset";
-		};
-	};
-- 
2.39.2

