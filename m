Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA13C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 11:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3D2A86E73;
	Mon,  4 Dec 2023 12:22:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lKs6xH6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C4883CF3; Mon,  4 Dec 2023 12:22:02 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516DA875EA
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 12:22:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B4BLrtb103635;
 Mon, 4 Dec 2023 05:21:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701688913;
 bh=1uh2TzAVzCtsbe6rytuxkzg8nGKpTkr7KF9+aTaLszE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=lKs6xH6vTG3o7ojG5U49sQp0zEoreRMTI7mno9SJ/2n3nq+wTSdoN/licNUc+CAS5
 80G1WoVgejMLSj26mz7XGpXKGL3CAw1Z2CzXxE3tAqg8ZStrr4yOQ++D83t0zhCjLQ
 nYgZVpZgxlLOUIlTLxu3Ta43sWyxffztpHoF7Fmc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B4BLrjb073470
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 4 Dec 2023 05:21:53 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Dec 2023 05:21:53 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Dec 2023 05:21:53 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B4BLfiv002315;
 Mon, 4 Dec 2023 05:21:50 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <marcel.ziswiler@toradex.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <hs@denx.de>, <christophe.leroy@csgroup.eu>,
 <mr.bossman075@gmail.com>, <afd@ti.com>, <m-chawdhry@ti.com>,
 <kamlesh@ti.com>, <nm@ti.com>, <c-shilwant@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>
Subject: [PATCH 2/3] arm: dts: k3-*-binman: Move to using ti-dm entry type
Date: Mon, 4 Dec 2023 16:51:40 +0530
Message-ID: <20231204112141.2036907-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204112141.2036907-1-n-francis@ti.com>
References: <20231204112141.2036907-1-n-francis@ti.com>
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

Move the DM entry in tispl.bin FIT image from default fetching an
external blob entry to fetching using ti-dm entry type. This way, the
DM entry will be populated by the TI_DM pathname if provided. Else it
will resort to the ti-dm.bin file.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/dts/k3-am625-sk-binman.dtsi              | 4 ++--
 arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi | 4 ++--
 arch/arm/dts/k3-am62a-sk-binman.dtsi              | 4 ++--
 arch/arm/dts/k3-j7200-binman.dtsi                 | 4 ++--
 arch/arm/dts/k3-j721e-binman.dtsi                 | 4 ++--
 arch/arm/dts/k3-j721s2-binman.dtsi                | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index b7b5368886..5b058bd03a 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -161,7 +161,7 @@
 						content = <&dm>;
 						keyfile = "custMpk.pem";
 					};
-					dm: blob-ext {
+					dm: ti-dm {
 						filename = "ti-dm.bin";
 					};
 				};
@@ -248,7 +248,7 @@
 			images {
 
 				dm {
-					blob-ext {
+					ti-dm {
 						filename = "ti-dm.bin";
 					};
 				};
diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index ed2c4482ef..78c371529a 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -227,7 +227,7 @@
 						content = <&dm>;
 						keyfile = "custMpk.pem";
 					};
-					dm: blob-ext {
+					dm: ti-dm {
 						filename = "ti-dm.bin";
 					};
 				};
@@ -310,7 +310,7 @@
 		fit {
 			images {
 				dm {
-					blob-ext {
+					ti-dm {
 						filename = "ti-dm.bin";
 					};
 				};
diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index c5e027d44d..ec3bf7ce91 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -164,7 +164,7 @@
 						content = <&dm>;
 						keyfile = "custMpk.pem";
 					};
-					dm: blob-ext {
+					dm: ti-dm {
 						filename = "ti-dm.bin";
 					};
 				};
@@ -250,7 +250,7 @@
 		fit {
 			images {
 				dm {
-					blob-ext {
+					ti-dm {
 						filename = "ti-dm.bin";
 					};
 				};
diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index 10c9d6cba7..38cccabaa7 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -200,7 +200,7 @@
 						content = <&dm>;
 						keyfile = "custMpk.pem";
 					};
-					dm: blob-ext {
+					dm: ti-dm {
 						filename = "ti-dm.bin";
 					};
 				};
@@ -285,7 +285,7 @@
 		fit {
 			images {
 				dm {
-					blob-ext {
+					ti-dm {
 						filename = "ti-dm.bin";
 					};
 				};
diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index 5ddb474e3a..dbc385a852 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -151,7 +151,7 @@
 						content = <&dm>;
 						keyfile = "custMpk.pem";
 					};
-					dm: blob-ext {
+					dm: ti-dm {
 						filename = "ti-dm.bin";
 					};
 				};
@@ -282,7 +282,7 @@
 		fit {
 			images {
 				dm {
-					blob-ext {
+					ti-dm {
 						filename = "ti-dm.bin";
 					};
 				};
diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
index 3922007b3b..f17dd8e04c 100644
--- a/arch/arm/dts/k3-j721s2-binman.dtsi
+++ b/arch/arm/dts/k3-j721s2-binman.dtsi
@@ -164,7 +164,7 @@
 						content = <&dm>;
 						keyfile = "custMpk.pem";
 					};
-					dm: blob-ext {
+					dm: ti-dm {
 						filename = "ti-dm.bin";
 					};
 				};
@@ -296,7 +296,7 @@
 		fit {
 			images {
 				dm {
-					blob-ext {
+					ti-dm {
 						filename = "ti-dm.bin";
 					};
 				};
-- 
2.34.1

