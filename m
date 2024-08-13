Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9E2C52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 06:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E3CF889B3;
	Tue, 13 Aug 2024 08:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b36DBAnC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25DA888997; Tue, 13 Aug 2024 08:11:01 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6368889AA
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 08:10:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47D6Aukc097467;
 Tue, 13 Aug 2024 01:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723529456;
 bh=f9EBRNxq7bESd0vWbqQz6ewF8sl8QbR9ZpBl5+Zuyk4=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=b36DBAnCQEllqFRP1+w9JISKOUAQgxrMIu1++4dMpReWpXqsIBAkc0D2HSO65oZ2P
 su+1yLr0WTFnaG6vAss3my4nbJVgS9HAnwlpAu6yaxlNjb38BL1flw0k5p+iQVZYyK
 gbhL8hHX0ld8SUOPD57XR5pxXHjinwhVGLOiBnhc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47D6AulE007500
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Aug 2024 01:10:56 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 01:10:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 01:10:56 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47D6AgHj016562;
 Tue, 13 Aug 2024 01:10:53 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 13 Aug 2024 11:40:43 +0530
Subject: [PATCH v3 3/7] arm: dts: k3-j7*-r5: Add MPU clock in clocks property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240813-b4-upstream-j721s2-avs-v3-3-5115d93cdeb2@ti.com>
References: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
In-Reply-To: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723529443; l=3592;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=jJfsKmhpoDcMFOAsSw0Jfntb4iGdFVScljC1wN/NLIU=;
 b=j0FmSAY3T2o1ivC356wYydjJkIwyh9x/1ku+TLpkNnyRdez/CrKjVCjrDsBOQIDt+4Hjsn7Au
 AtqqZpzQBq5BK7/xVWgAalQ5IGDxnSKBJ878QiodxSaIzId/PV7G9L8
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

MPU clock had been missing. Distinguish multiple clocks with clock-names
and add MPU clock as well.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-am69-r5-sk.dts                 | 3 ++-
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 3 ++-
 arch/arm/dts/k3-j721e-r5.dtsi                  | 3 ++-
 arch/arm/dts/k3-j721s2-r5.dtsi                 | 3 ++-
 arch/arm/dts/k3-j784s4-r5-evm.dts              | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/k3-am69-r5-sk.dts b/arch/arm/dts/k3-am69-r5-sk.dts
index f177f563527f..9bbf76d8bf35 100644
--- a/arch/arm/dts/k3-am69-r5-sk.dts
+++ b/arch/arm/dts/k3-am69-r5-sk.dts
@@ -26,7 +26,8 @@
 		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
 				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 202 0>;
-		clocks = <&k3_clks 61 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
+		clock-names = "gtc", "core";
 		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
 		assigned-clock-parents = <&k3_clks 61 2>;
 		assigned-clock-rates = <200000000>, <2000000000>;
diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index fb7e2e502392..e6da86f3cd10 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -23,7 +23,8 @@
 				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
 				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 202 0>;
-		clocks = <&k3_clks 61 1>;
+		clocks = <&k3_clks 61 1>, <&k3_clks 202 2>;
+		clock-names = "gtc", "core";
 		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 323 0>;
 		assigned-clock-parents= <0>, <0>, <&k3_clks 323 2>;
 		assigned-clock-rates = <2000000000>, <200000000>;
diff --git a/arch/arm/dts/k3-j721e-r5.dtsi b/arch/arm/dts/k3-j721e-r5.dtsi
index fd0d921272c5..688a6cf40892 100644
--- a/arch/arm/dts/k3-j721e-r5.dtsi
+++ b/arch/arm/dts/k3-j721e-r5.dtsi
@@ -20,7 +20,8 @@
 				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
 				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 202 0>;
-		clocks = <&k3_clks 61 1>;
+		clocks = <&k3_clks 61 1>, <&k3_clks 202 2>;
+		clock-names = "gtc", "core";
 		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>;
 		assigned-clock-rates = <2000000000>, <200000000>;
 		ti,sci = <&dmsc>;
diff --git a/arch/arm/dts/k3-j721s2-r5.dtsi b/arch/arm/dts/k3-j721s2-r5.dtsi
index caf696c2d960..634676c8491e 100644
--- a/arch/arm/dts/k3-j721s2-r5.dtsi
+++ b/arch/arm/dts/k3-j721s2-r5.dtsi
@@ -20,7 +20,8 @@
 				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
 				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 202 0>;
-		clocks = <&k3_clks 61 1>;
+		clocks = <&k3_clks 61 1>, <&k3_clks 202 0>;
+		clock-names = "gtc", "core";
 		assigned-clocks = <&k3_clks 61 1>, <&k3_clks 202 0>;
 		assigned-clock-parents = <&k3_clks 61 3>;
 		assigned-clock-rates = <200000000>, <2000000000>;
diff --git a/arch/arm/dts/k3-j784s4-r5-evm.dts b/arch/arm/dts/k3-j784s4-r5-evm.dts
index bef4573d3d20..306d2007f89e 100644
--- a/arch/arm/dts/k3-j784s4-r5-evm.dts
+++ b/arch/arm/dts/k3-j784s4-r5-evm.dts
@@ -26,7 +26,8 @@
 		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
 				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 202 0>;
-		clocks = <&k3_clks 61 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
+		clock-names = "gtc", "core";
 		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
 		assigned-clock-parents = <&k3_clks 61 2>;
 		assigned-clock-rates = <200000000>, <2000000000>;

-- 
2.46.0

