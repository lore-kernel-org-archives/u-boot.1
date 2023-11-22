Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C255C27C40
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 21:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0301B875AA;
	Wed, 22 Nov 2023 22:30:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oeIezxBp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A724387641; Wed, 22 Nov 2023 22:30:14 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 728F3875A4
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 22:30:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AMLU8Rn117188;
 Wed, 22 Nov 2023 15:30:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700688608;
 bh=W4cS4n2yQeulPNukFfV387QQxaf57qIw12anZrKbF4A=;
 h=From:To:CC:Subject:Date;
 b=oeIezxBp7nCsdMU9CPRsiEkrtnWcVPpSkNc39Z28dH5JNKP8KfltdPVH27MEYhiRA
 KlseNtje2APxL40Oki0gHktXGKzwvBlezfjyiv85wcvhi68u61y+g7nh2aiNTdlOL3
 SE209doU2asF01uBJkdP0s+qGPX44AWCrxgz59Rw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AMLU8CH020828
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Nov 2023 15:30:08 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 15:30:07 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 15:30:07 -0600
Received: from fllv0040.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AMLU6Xf004073;
 Wed, 22 Nov 2023 15:30:07 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nishanth Menon <nm@ti.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2] arm: mach-k3: Move K3 common schema.yaml out of board
 directory
Date: Wed, 22 Nov 2023 15:30:05 -0600
Message-ID: <20231122213005.680781-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
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

This file is common for all K3, move it out of board/ directory and
into mach-k3. As we need to change the path in k3-binman.dtsi let's
take this opportunity to switch to absolute paths which makes adding
non-TI boards (like Toradex Verdin) not need to override these paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes for v2:
 - Rebased on -next

 .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 66 -------------------
 arch/arm/dts/k3-binman.dtsi                   | 28 ++++----
 .../common => arch/arm/mach-k3}/schema.yaml   |  0
 3 files changed, 14 insertions(+), 80 deletions(-)
 rename {board/ti/common => arch/arm/mach-k3}/schema.yaml (100%)

diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index ed2c4482ef0..dd832ee1f3d 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -5,72 +5,6 @@
 
 #include "k3-binman.dtsi"
 
-#ifndef CONFIG_ARM64
-
-&bcfg_yaml {
-	schema = "../../ti/common/schema.yaml";
-};
-
-&pcfg_yaml {
-	schema = "../../ti/common/schema.yaml";
-};
-
-&rcfg_yaml {
-	schema = "../../ti/common/schema.yaml";
-};
-
-&scfg_yaml {
-	schema = "../../ti/common/schema.yaml";
-};
-
-/* combined-tifs-cfg */
-
-&bcfg_yaml_tifs {
-	schema = "../../ti/common/schema.yaml";
-};
-
-&pcfg_yaml_tifs {
-	schema = "../../ti/common/schema.yaml";
-};
-
-&rcfg_yaml_tifs {
-	schema = "../../ti/common/schema.yaml";
-};
-
-&scfg_yaml_tifs {
-	schema = "../../ti/common/schema.yaml";
-};
-
-/* combined-dm-cfg */
-
-&pcfg_yaml_dm {
-	schema = "../../ti/common/schema.yaml";
-};
-
-&rcfg_yaml_dm {
-	schema = "../../ti/common/schema.yaml";
-};
-
-/* combined-sysfw-cfg */
-
-&bcfg_yaml_sysfw {
-	schema = "../../ti/common/schema.yaml";
-};
-
-&pcfg_yaml_sysfw {
-	schema = "../../ti/common/schema.yaml";
-};
-
-&rcfg_yaml_sysfw {
-	schema = "../../ti/common/schema.yaml";
-};
-
-&scfg_yaml_sysfw {
-	schema = "../../ti/common/schema.yaml";
-};
-
-#endif /* CONFIG_ARM64 */
-
 #ifdef CONFIG_TARGET_VERDIN_AM62_R5
 
 &binman {
diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index c7513e1a5dd..cd9926a0169 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -32,28 +32,28 @@
 		filename = "board-cfg.bin";
 		bcfg_yaml: ti-board-config {
 			config = "board-cfg.yaml";
-			schema = "board/ti/common/schema.yaml";
+			schema = "arch/arm/mach-k3/schema.yaml";
 		};
 	};
 	pm-cfg {
 		filename = "pm-cfg.bin";
 		pcfg_yaml: ti-board-config {
 			config = "pm-cfg.yaml";
-			schema = "board/ti/common/schema.yaml";
+			schema = "arch/arm/mach-k3/schema.yaml";
 		};
 	};
 	rm-cfg {
 		filename = "rm-cfg.bin";
 		rcfg_yaml: ti-board-config {
 			config = "rm-cfg.yaml";
-			schema = "board/ti/common/schema.yaml";
+			schema = "arch/arm/mach-k3/schema.yaml";
 		};
 	};
 	sec-cfg {
 		filename = "sec-cfg.bin";
 		scfg_yaml: ti-board-config {
 			config = "sec-cfg.yaml";
-			schema = "board/ti/common/schema.yaml";
+			schema = "arch/arm/mach-k3/schema.yaml";
 		};
 	};
 	combined-tifs-cfg {
@@ -61,19 +61,19 @@
 		ti-board-config {
 			bcfg_yaml_tifs: board-cfg {
 				config = "board-cfg.yaml";
-				schema = "board/ti/common/schema.yaml";
+				schema = "arch/arm/mach-k3/schema.yaml";
 			};
 			scfg_yaml_tifs: sec-cfg {
 				config = "sec-cfg.yaml";
-				schema = "board/ti/common/schema.yaml";
+				schema = "arch/arm/mach-k3/schema.yaml";
 			};
 			pcfg_yaml_tifs: pm-cfg {
 				config = "pm-cfg.yaml";
-				schema = "board/ti/common/schema.yaml";
+				schema = "arch/arm/mach-k3/schema.yaml";
 			};
 			rcfg_yaml_tifs: rm-cfg {
 				config = "rm-cfg.yaml";
-				schema = "board/ti/common/schema.yaml";
+				schema = "arch/arm/mach-k3/schema.yaml";
 			};
 		};
 	};
@@ -82,11 +82,11 @@
 		ti-board-config {
 			pcfg_yaml_dm: pm-cfg {
 				config = "pm-cfg.yaml";
-				schema = "board/ti/common/schema.yaml";
+				schema = "arch/arm/mach-k3/schema.yaml";
 			};
 			rcfg_yaml_dm: rm-cfg {
 				config = "rm-cfg.yaml";
-				schema = "board/ti/common/schema.yaml";
+				schema = "arch/arm/mach-k3/schema.yaml";
 			};
 		};
 	};
@@ -95,19 +95,19 @@
 		ti-board-config {
 			bcfg_yaml_sysfw: board-cfg {
 				config = "board-cfg.yaml";
-				schema = "board/ti/common/schema.yaml";
+				schema = "arch/arm/mach-k3/schema.yaml";
 			};
 			scfg_yaml_sysfw: sec-cfg {
 				config = "sec-cfg.yaml";
-				schema = "board/ti/common/schema.yaml";
+				schema = "arch/arm/mach-k3/schema.yaml";
 			};
 			pcfg_yaml_sysfw: pm-cfg {
 				config = "pm-cfg.yaml";
-				schema = "board/ti/common/schema.yaml";
+				schema = "arch/arm/mach-k3/schema.yaml";
 			};
 			rcfg_yaml_sysfw: rm-cfg {
 				config = "rm-cfg.yaml";
-				schema = "board/ti/common/schema.yaml";
+				schema = "arch/arm/mach-k3/schema.yaml";
 			};
 		};
 	};
diff --git a/board/ti/common/schema.yaml b/arch/arm/mach-k3/schema.yaml
similarity index 100%
rename from board/ti/common/schema.yaml
rename to arch/arm/mach-k3/schema.yaml
-- 
2.39.2

