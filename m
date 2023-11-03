Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC38C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 00:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1E968771C;
	Fri,  3 Nov 2023 01:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FpeaJfBe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B115A8757C; Fri,  3 Nov 2023 01:38:54 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 709FF8770B
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 01:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A30cBLB003509;
 Thu, 2 Nov 2023 19:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698971891;
 bh=I4Tgw0OpF6Isj0qwCiw5tNmOnxdG3QFWmh08n79AgPU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FpeaJfBeIz26xKG433QFETGVqPsLDBDh8YIfMUdnhS/Q171zp/xUzhujWf88zs9X/
 X9Pdp/Fa3s3y+jIRYq/IDNQ520dKiKAid7MWMTIGR39SH9+TNvJS6mcrX1QugA5CBa
 GYN/5V3SE1mDOj5Q86RjUNeKuaxxIM77+bbYudPc=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A30cBGI124967
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Nov 2023 19:38:11 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 19:38:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 19:38:10 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A30cAaN043238;
 Thu, 2 Nov 2023 19:38:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 11/15] arm: dts: k3-j721e-binman: Allow a single board
 configuration
Date: Thu, 2 Nov 2023 19:38:01 -0500
Message-ID: <20231103003805.2420005-12-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231103003805.2420005-1-nm@ti.com>
References: <20231103003805.2420005-1-nm@ti.com>
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

Allow the reuse of k3-j721e-binman for other platforms such as
BeagleBone-AI64. We don't need to build SK device tree blobs in-order
to be able to build dtbs for single configuration platforms.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/dts/k3-j721e-binman.dtsi             | 21 ++++++++++++++++++-
 .../k3-j721e-common-proc-board-u-boot.dtsi    |  2 ++
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |  2 ++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index 4f566c21a9af..d9c4fbf593af 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -296,11 +296,14 @@
 
 #define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
 #define SPL_J721E_EVM_DTB "spl/dts/k3-j721e-common-proc-board.dtb"
-#define SPL_J721E_SK_DTB "spl/dts/k3-j721e-sk.dtb"
 
 #define UBOOT_NODTB "u-boot-nodtb.bin"
 #define J721E_EVM_DTB "u-boot.dtb"
+
+#ifdef DUAL_DTB_BINMAN
+#define SPL_J721E_SK_DTB "spl/dts/k3-j721e-sk.dtb"
 #define J721E_SK_DTB "arch/arm/dts/k3-j721e-sk.dtb"
+#endif
 
 &binman {
 	ti-dm {
@@ -400,6 +403,7 @@
 					};
 				};
 
+#ifdef DUAL_DTB_BINMAN
 				fdt-1 {
 					description = "k3-j721e-sk";
 					type = "flat_dt";
@@ -414,6 +418,7 @@
 						filename = SPL_J721E_SK_DTB;
 					};
 				};
+#endif
 			};
 
 			configurations {
@@ -426,12 +431,14 @@
 					fdt = "fdt-0";
 				};
 
+#ifdef DUAL_DTB_BINMAN
 				conf-1 {
 					description = "k3-j721e-sk";
 					firmware = "atf";
 					loadables = "tee", "dm", "spl";
 					fdt = "fdt-1";
 				};
+#endif
 			};
 		};
 	};
@@ -482,6 +489,7 @@
 					};
 				};
 
+#ifdef DUAL_DTB_BINMAN
 				fdt-1 {
 					description = "k3-j721e-sk";
 					type = "flat_dt";
@@ -499,6 +507,7 @@
 						algo = "crc32";
 					};
 				};
+#endif
 			};
 
 			configurations {
@@ -511,12 +520,14 @@
 					fdt = "fdt-0";
 				};
 
+#ifdef DUAL_DTB_BINMAN
 				conf-1 {
 					description = "k3-j721e-sk";
 					firmware = "uboot";
 					loadables = "uboot";
 					fdt = "fdt-1";
 				};
+#endif
 			};
 		};
 	};
@@ -595,6 +606,7 @@
 					};
 				};
 
+#ifdef DUAL_DTB_BINMAN
 				fdt-1 {
 					description = "k3-j721e-sk";
 					type = "flat_dt";
@@ -604,6 +616,7 @@
 						filename = SPL_J721E_SK_DTB;
 					};
 				};
+#endif
 			};
 
 			configurations {
@@ -616,12 +629,14 @@
 					fdt = "fdt-0";
 				};
 
+#ifdef DUAL_DTB_BINMAN
 				conf-1 {
 					description = "k3-j721e-sk";
 					firmware = "atf";
 					loadables = "tee", "dm", "spl";
 					fdt = "fdt-1";
 				};
+#endif
 			};
 		};
 	};
@@ -664,6 +679,7 @@
 					};
 				};
 
+#ifdef DUAL_DTB_BINMAN
 				fdt-1 {
 					description = "k3-j721e-sk";
 					type = "flat_dt";
@@ -676,6 +692,7 @@
 						algo = "crc32";
 					};
 				};
+#endif
 			};
 
 			configurations {
@@ -688,12 +705,14 @@
 					fdt = "fdt-0";
 				};
 
+#ifdef DUAL_DTB_BINMAN
 				conf-1 {
 					description = "k3-j721e-sk";
 					firmware = "uboot";
 					loadables = "uboot";
 					fdt = "fdt-1";
 				};
+#endif
 			};
 		};
 	};
diff --git a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
index cd95907b981b..3317e902d677 100644
--- a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
@@ -3,6 +3,8 @@
  * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
  */
 
+#define DUAL_DTB_BINMAN 1
+
 #include "k3-j721e-binman.dtsi"
 
 &cbass_main {
diff --git a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
index 370fe5190b2d..507964827547 100644
--- a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
@@ -3,6 +3,8 @@
  * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#define DUAL_DTB_BINMAN 1
+
 #include "k3-j721e-binman.dtsi"
 
 &cbass_main {
-- 
2.40.0

