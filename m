Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A43AC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 02:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8960687092;
	Sat,  4 Nov 2023 03:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GSjXsXo6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A646486FE8; Sat,  4 Nov 2023 03:45:53 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD867870AB
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 03:45:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A42jDaL081650;
 Fri, 3 Nov 2023 21:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699065913;
 bh=p2npls1FcqGl6aVucxhpEqIDAvAwRO/d3YE9LSDGVdM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=GSjXsXo6BtcR3cB9A1tL4sLub7vowBCVxDXoHh0OlpC6zV0wmlPCXzhrydvQNk4uj
 qjo0XYmtXTPO0OfBO/aXsvBmKOwcRBHV/9SxFvIeAbRTgzQ9/SugELAtHgS6qZT6iB
 yd4dGnz54luDehCPoeF+kWSJEX1amBlfUi3PGiJc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A42jDqY013652
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 3 Nov 2023 21:45:13 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 Nov 2023 21:45:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 Nov 2023 21:45:12 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A42jCrT103159;
 Fri, 3 Nov 2023 21:45:12 -0500
From: Nishanth Menon <nm@ti.com>
To: <trini@konsulko.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Francesco Dolcini <francesco@dolcini.it>, Andrew Davis
 <afd@ti.com>, <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 2/2] arm: mach-k3: Move TI dummy keys out of board folder
Date: Fri, 3 Nov 2023 21:45:11 -0500
Message-ID: <20231104024511.3597476-3-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231104024511.3597476-1-nm@ti.com>
References: <20231104024511.3597476-1-nm@ti.com>
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

This file is used to emulate customer keys on TI development board
ecosystems, move it out of board/ directory and into mach-k3. And
change the relative paths to absolute paths in the binman paths.

While at it, drop the reference in verdin-binman file which is
redundant.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
New patch in series.

 arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi | 4 ----
 arch/arm/dts/k3-binman.dtsi                       | 2 +-
 {board/ti => arch/arm/mach-k3}/keys/custMpk.crt   | 0
 {board/ti => arch/arm/mach-k3}/keys/custMpk.key   | 0
 {board/ti => arch/arm/mach-k3}/keys/custMpk.pem   | 0
 5 files changed, 1 insertion(+), 5 deletions(-)
 rename {board/ti => arch/arm/mach-k3}/keys/custMpk.crt (100%)
 rename {board/ti => arch/arm/mach-k3}/keys/custMpk.key (100%)
 rename {board/ti => arch/arm/mach-k3}/keys/custMpk.pem (100%)

diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index ea22bfb9bad6..58fde95adf67 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -5,10 +5,6 @@
 
 #include "k3-binman.dtsi"
 
-&custmpk_pem {
-	filename = "../../ti/keys/custMpk.pem";
-};
-
 #ifdef CONFIG_TARGET_VERDIN_AM62_R5
 
 &binman {
diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index b941726e6246..8d4b0b2454f6 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -13,7 +13,7 @@
 	custMpk {
 		filename = "custMpk.pem";
 		custmpk_pem: blob-ext {
-			filename = "../keys/custMpk.pem";
+			filename = "arch/arm/mach-k3/keys/custMpk.pem";
 		};
 	};
 
diff --git a/board/ti/keys/custMpk.crt b/arch/arm/mach-k3/keys/custMpk.crt
similarity index 100%
rename from board/ti/keys/custMpk.crt
rename to arch/arm/mach-k3/keys/custMpk.crt
diff --git a/board/ti/keys/custMpk.key b/arch/arm/mach-k3/keys/custMpk.key
similarity index 100%
rename from board/ti/keys/custMpk.key
rename to arch/arm/mach-k3/keys/custMpk.key
diff --git a/board/ti/keys/custMpk.pem b/arch/arm/mach-k3/keys/custMpk.pem
similarity index 100%
rename from board/ti/keys/custMpk.pem
rename to arch/arm/mach-k3/keys/custMpk.pem
-- 
2.40.0

