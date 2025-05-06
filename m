Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF36DC3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 10:42:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 640FD82757;
	Tue,  6 May 2025 12:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VC/Vo0Id";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F0848283E; Tue,  6 May 2025 12:42:38 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2C6C800C1
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 12:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 546AgUr3501747
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 May 2025 05:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746528150;
 bh=JWrSOCCnNBajDK4id/tZ0ZkxYAVI4bW5Q/+P67ZJxck=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=VC/Vo0IdgvmahH3Ih9JAzBiz12eGHwtzUuzeJsHdi6cxzxAOfbHrNI6kjwKSJeHNj
 aXCtmja2t+y2Eb3Ps6lbqAgnjpIuJ92UNFZEOPIRe6yo8VcAWnPZTHh2OEUyTq99EW
 zhVCDqWStUlJl4h2SAi6ckNsilLLXd3kmOgn/7VE=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 546AgUD6018645
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 May 2025 05:42:30 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 May 2025 05:42:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 May 2025 05:42:30 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 546Ag2uX103095;
 Tue, 6 May 2025 05:42:25 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <afd@ti.com>
CC: <sjg@chromium.org>, <xypron.glpk@gmx.de>, <cfsworks@gmail.com>,
 <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>, <kamlesh@ti.com>, <bb@ti.com>,
 <j-humphreys@ti.com>, <s-k6@ti.com>, <j-choudhary@ti.com>,
 <d-gole@ti.com>, <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v2 4/7] arm: dts: k3-{j721s2/j784s4}-binman: Pack HSM firmware
 inside tispl.bin
Date: Tue, 6 May 2025 16:11:59 +0530
Message-ID: <20250506104202.16741-5-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506104202.16741-1-b-padhi@ti.com>
References: <20250506104202.16741-1-b-padhi@ti.com>
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
v2: Changelog:
None to this patch.

Link to v1:
https://lore.kernel.org/all/20250422095430.363792-4-b-padhi@ti.com/

 arch/arm/dts/k3-j721s2-binman.dtsi | 12 ++++++++++++
 arch/arm/dts/k3-j784s4-binman.dtsi | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
index 73af184d27e..9c8b29f53bb 100644
--- a/arch/arm/dts/k3-j721s2-binman.dtsi
+++ b/arch/arm/dts/k3-j721s2-binman.dtsi
@@ -273,6 +273,14 @@
 
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
@@ -306,7 +314,11 @@
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
index cb1fbc65923..7c8e580a8a3 100644
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

