Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDE8C369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 07:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1D5182D2A;
	Wed, 16 Apr 2025 09:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JHmciOOO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6451282D2A; Wed, 16 Apr 2025 09:31:26 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC40481E14
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 09:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7VK0c2595812
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 02:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744788680;
 bh=uoCPUR6hXRcLYjDFQshbgY/SKD9nR1Vfk8mvUHkvW2E=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=JHmciOOOTlVwP6ZlN8Fe4gEVmXM8qrLYCM5WrD8qnIIOzhgx5BxEsmKcNGvP4TIXV
 hwucrlxgVnujychOJwR6rhV9Err8Zv9fLKRu3Yz63GF8DNGhIOAZBFhDvOVzWgKUSC
 Sa0Mz3de070LKnIaVapGGM/3ORFTlOZgNDNLz90s=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7VKqQ003390
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 02:31:20 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 02:31:19 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 02:31:20 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53G7VJq9058004;
 Wed, 16 Apr 2025 02:31:19 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <nm@ti.com>, <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>
Subject: [PATCH v1 4/4] binman: k3: add jump-stub as loadable
Date: Wed, 16 Apr 2025 13:00:57 +0530
Message-ID: <20250416073058.1441001-5-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416073058.1441001-1-anshuld@ti.com>
References: <20250416073058.1441001-1-anshuld@ti.com>
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

Since all k3 platforms use the same ATF build, the jump-stub is required
for each to preserve backwards compatibility.

This patch adds jump-stub as a loadable for each platform's binman dts
which enables the R5 SPL to load the jump stub where older ATF build
would expect main domain SPL to be.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi      | 2 +-
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi     | 4 ++--
 arch/arm/dts/k3-am625-sk-binman.dtsi              | 4 ++--
 arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi | 4 ++--
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi     | 4 ++--
 arch/arm/dts/k3-am62a-sk-binman.dtsi              | 4 ++--
 arch/arm/dts/k3-am62p-sk-binman.dtsi              | 2 +-
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi     | 8 ++++----
 arch/arm/dts/k3-am64x-binman.dtsi                 | 8 ++++----
 arch/arm/dts/k3-am65-iot2050-boot-image.dtsi      | 2 +-
 arch/arm/dts/k3-am65x-binman.dtsi                 | 4 ++--
 arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi      | 2 +-
 arch/arm/dts/k3-j7200-binman.dtsi                 | 4 ++--
 arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi  | 2 +-
 arch/arm/dts/k3-j721e-binman.dtsi                 | 4 ++--
 arch/arm/dts/k3-j721s2-binman.dtsi                | 4 ++--
 arch/arm/dts/k3-j722s-binman.dtsi                 | 2 +-
 arch/arm/dts/k3-j784s4-binman.dtsi                | 4 ++--
 18 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index a067b0ba354..d0ce7259334 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -188,7 +188,7 @@
 				conf-0 {
 					description = "k3-am625-beagleplay";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl",
+					loadables = "tee", "dm", "spl", "jump-stub",
 					"tifsstub-gp";
 					fdt = "fdt-0";
 				};
diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index 4a65427e877..2110cf47598 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -297,7 +297,7 @@
 					description = "k3-am625-phyboard-lyra-rdk";
 					firmware = "atf";
 					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
-						    "tifsstub-gp", "dm", "spl";
+						    "tifsstub-gp", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
@@ -441,7 +441,7 @@
 					description = "k3-am625-phyboard-lyra-rdk";
 					firmware = "atf";
 					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
-						    "tifsstub-gp", "dm", "spl";
+						    "tifsstub-gp", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index 534eb14795b..bb5ad83b168 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -298,7 +298,7 @@
 					description = "k3-am625-sk";
 					firmware = "atf";
 					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
-					"tifsstub-gp", "dm", "spl";
+					"tifsstub-gp", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
@@ -419,7 +419,7 @@
 					description = "k3-am625-sk";
 					firmware = "atf";
 					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
-						  "tifsstub-gp", "dm", "spl";
+						  "tifsstub-gp", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index 0e6188907e4..bc340311055 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -283,7 +283,7 @@
 					description = "k3-am625-verdin-wifi-dev";
 					firmware = "atf";
 					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
-						    "tifsstub-gp", "dm", "spl";
+						    "tifsstub-gp", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
@@ -402,7 +402,7 @@
 					description = "k3-am625-verdin-wifi-dev";
 					firmware = "atf";
 					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
-						    "tifsstub-gp", "dm", "spl";
+						    "tifsstub-gp", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
index 325702ed6e0..f88f18ece1d 100644
--- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
@@ -302,7 +302,7 @@
 					description = "k3-am62a7-phyboard-lyra-rdk";
 					firmware = "atf";
 					loadables = "tee", "dm", "spl",
-					"tifsstub-hs", "tifsstub-fs", "tifsstub-gp";
+					"tifsstub-hs", "tifsstub-fs", "tifsstub-gp", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
@@ -483,7 +483,7 @@
 				conf-0 {
 					description = "k3-am62a7-phyboard-lyra-rdk";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl",
+					loadables = "tee", "dm", "spl", "jump-stub",
 					"tifsstub-hs", "tifsstub-fs", "tifsstub-gp";
 					fdt = "fdt-0";
 				};
diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index 2a8c260387b..09b93ce96a9 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -287,7 +287,7 @@
 				conf-0 {
 					description = "k3-am62a7-sk";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl",
+					loadables = "tee", "dm", "spl", "jump-stub",
 					"tifsstub-hs", "tifsstub-fs", "tifsstub-gp";
 					fdt = "fdt-0";
 				};
@@ -407,7 +407,7 @@
 					description = "k3-am62a7-sk";
 					firmware = "atf";
 					loadables = "tee", "dm", "spl",
-					"tifsstub-hs", "tifsstub-fs", "tifsstub-gp";
+					"tifsstub-hs", "tifsstub-fs", "tifsstub-gp", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index 797644a7e0d..66bcef55653 100644
--- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
@@ -239,7 +239,7 @@
 				conf-0 {
 					description = "k3-am62px-sk";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl",
+					loadables = "tee", "dm", "spl", "jump-stub",
 					"tifsstub-hs", "tifsstub-fs";
 					fdt = "fdt-0";
 				};
diff --git a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
index 5228eed19bf..2db9239ecd7 100644
--- a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
@@ -174,7 +174,7 @@
 				conf-0 {
 					description = "k3-am642-phyboard-electra-rdk";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
@@ -253,7 +253,7 @@
 				conf-0 {
 					description = "k3-am642-phyboard-electra-rdk";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
@@ -339,7 +339,7 @@
 				conf-0 {
 					description = "k3-am642-phyboard-electra-rdk";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
@@ -482,7 +482,7 @@
 				conf-0 {
 					description = "k3-am642-phyboard-electra-rdk";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-am64x-binman.dtsi b/arch/arm/dts/k3-am64x-binman.dtsi
index f768c4d946d..4ddcc50df7a 100644
--- a/arch/arm/dts/k3-am64x-binman.dtsi
+++ b/arch/arm/dts/k3-am64x-binman.dtsi
@@ -188,14 +188,14 @@
 				conf-0 {
 					description = "k3-am642-evm";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 
 				conf-1 {
 					description = "k3-am642-sk";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-1";
 				};
 			};
@@ -312,14 +312,14 @@
 				conf-0 {
 					description = "k3-am642-evm";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 
 				conf-1 {
 					description = "k3-am642-sk";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-1";
 				};
 			};
diff --git a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
index f49d6f262f2..4e7702b58df 100644
--- a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
+++ b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
@@ -99,7 +99,7 @@
 				spl {
 					fdt = "fdt-0";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 				};
 			};
 		};
diff --git a/arch/arm/dts/k3-am65x-binman.dtsi b/arch/arm/dts/k3-am65x-binman.dtsi
index 350775e42c2..06b161a4ec5 100644
--- a/arch/arm/dts/k3-am65x-binman.dtsi
+++ b/arch/arm/dts/k3-am65x-binman.dtsi
@@ -148,7 +148,7 @@
 				conf-0 {
 					description = "k3-am654-base-board";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-0", "fdt-1";
 				};
 			};
@@ -257,7 +257,7 @@
 				conf-0 {
 					description = "k3-am654-base-board";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-0", "fdt-1";
 				};
 			};
diff --git a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
index 6c52038cdca..4619856ac49 100644
--- a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
+++ b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
@@ -214,7 +214,7 @@
 				conf-0 {
 					description = "k3-am67a-beagley-ai";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index 423badd7cb5..632a3df5270 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -371,7 +371,7 @@
 				conf-0 {
 					description = "k3-j7200-common-proc-board";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
@@ -451,7 +451,7 @@
 				conf-1 {
 					description = "k3-j7200-common-proc-board";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-1";
 				};
 			};
diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
index 8cefa39290d..f57b7b51143 100644
--- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
@@ -298,7 +298,7 @@
 				conf-0 {
 					description = "k3-j721e-beagleboneai64";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index 0d607296f0e..4e2aa645255 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -492,7 +492,7 @@
 				conf-0 {
 					description = "k3-j721e-common-proc-board";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
@@ -572,7 +572,7 @@
 				conf-0 {
 					description = "k3-j721e-common-proc-board";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
index d121d8c0c54..edf89ad57a9 100644
--- a/arch/arm/dts/k3-j721s2-binman.dtsi
+++ b/arch/arm/dts/k3-j721s2-binman.dtsi
@@ -312,7 +312,7 @@
 				conf-0 {
 					description = "k3-j721s2-common-proc-board";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
@@ -392,7 +392,7 @@
 				conf-0 {
 					description = "k3-j721s2-common-proc-board";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-j722s-binman.dtsi b/arch/arm/dts/k3-j722s-binman.dtsi
index 6b521166575..bd617f92727 100644
--- a/arch/arm/dts/k3-j722s-binman.dtsi
+++ b/arch/arm/dts/k3-j722s-binman.dtsi
@@ -166,7 +166,7 @@
 				conf-0 {
 					description = "k3-j722s-evm";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index 0553825b383..8505afd38e5 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -194,7 +194,7 @@
 				conf-0 {
 					description = BOARD_DESCRIPTION;
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
@@ -277,7 +277,7 @@
 				conf-0 {
 					description = BOARD_DESCRIPTION;
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl", "jump-stub";
 					fdt = "fdt-0";
 				};
 			};
-- 
2.49.0

