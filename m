Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5788BC369CB
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 09:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8D5181E25;
	Tue, 22 Apr 2025 11:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wMYh8f0d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 274CE81E1F; Tue, 22 Apr 2025 11:54:48 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 107688171B
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 11:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53M9sgoG1182424
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 04:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745315682;
 bh=v6aA1huVxo9LXZqQFps2YYMO+r//yEqKY/fc6F11Qns=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=wMYh8f0dBX3oIs1QgvDYxkMYIcsk5cZNVgqf352ATr21EOyLhZscs7UVrruul4Xqh
 G0EW96wUpTLbgBOLv48vIDKmc+0ZVKmRW5s0uSIdJtBA2J66aWMvCYc+SjimDMdTzk
 VQ47vvhFyV2AxtQaE6ie96kulfplJ7SaE6RthGv8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53M9sgBI050841
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Apr 2025 04:54:42 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 04:54:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 04:54:42 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53M9sVGW088247;
 Tue, 22 Apr 2025 04:54:39 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>,
 <jm@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 3/4] arm: dts: k3-{j721s2/j784s4}-binman: Pack HSM firmware
 inside tispl.bin
Date: Tue, 22 Apr 2025 15:24:29 +0530
Message-ID: <20250422095430.363792-4-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422095430.363792-1-b-padhi@ti.com>
References: <20250422095430.363792-1-b-padhi@ti.com>
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

Pack the HSM firmware in tispl.bin fit image so that it can be unloaded
and used by R5 SPL to boot the HSM core. By default, point to the
firmware for HS-SE device type. This needs to be changed to point to
appropriate firmware when using a different device type.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm/dts/k3-j721s2-binman.dtsi | 12 ++++++++++++
 arch/arm/dts/k3-j784s4-binman.dtsi | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
index d121d8c0c54..1e6cdf92421 100644
--- a/arch/arm/dts/k3-j721s2-binman.dtsi
+++ b/arch/arm/dts/k3-j721s2-binman.dtsi
@@ -280,6 +280,14 @@
 
 					};
 				};
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					hsm: blob-ext {
+						filename = "ti-hsm/hsm-demo-firmware-j721s2-hs.bin";
+					};
+				};
+#endif
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -312,7 +320,11 @@
 				conf-0 {
 					description = "k3-j721s2-common-proc-board";
 					firmware = "atf";
+#ifdef CONFIG_K3_HSM_FW
+					loadables = "hsm", "tee", "dm", "spl";
+#else
 					loadables = "tee", "dm", "spl";
+#endif
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index 0553825b383..ab417a47034 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -159,6 +159,16 @@
 
 		fit {
 			images {
+
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					hsm: blob-ext {
+						filename = "ti-hsm/hsm-demo-firmware-j784s4-hs.bin";
+					};
+				};
+
+#endif
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -194,7 +204,11 @@
 				conf-0 {
 					description = BOARD_DESCRIPTION;
 					firmware = "atf";
+#ifdef CONFIG_K3_HSM_FW
+					loadables = "hsm", "tee", "dm", "spl";
+#else
 					loadables = "tee", "dm", "spl";
+#endif
 					fdt = "fdt-0";
 				};
 			};
-- 
2.34.1

