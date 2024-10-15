Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B7FCFC288
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 10:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41C3E89166;
	Tue, 15 Oct 2024 12:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="afpEgRg2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78F7E891B0; Tue, 15 Oct 2024 12:52:39 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFB6789160
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49FAqYiO050565;
 Tue, 15 Oct 2024 05:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728989554;
 bh=Ti17LzHQC1PZ07DmHrC6G1UlcgDZLK4PMIox09WpIH0=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=afpEgRg2KuvhFYqV04ZCMDXHXkc21VMw50JYodrHoyG8DHJslQnImdRkEy1Ud3qHg
 Ivk0J5Fx9Bpvb1Ng3SOkgAKQQXYa6OKYYXcF3ieW07TveWquE0Z1J5mCbH9wn3fvbd
 DbITrj0wubHPlyd5V3AmcCkHEGZqV6eDT3bhlLPs=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49FAqYaZ019970
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Oct 2024 05:52:34 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Oct 2024 05:52:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Oct 2024 05:52:34 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49FAqJbh044559;
 Tue, 15 Oct 2024 05:52:31 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 15 Oct 2024 16:22:19 +0530
Subject: [PATCH v5 3/7] arm: dts: k3-*-r5: Add MPU clock in clocks property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241015-b4-upstream-j721s2-avs-v5-3-5c8087387dc5@ti.com>
References: <20241015-b4-upstream-j721s2-avs-v5-0-5c8087387dc5@ti.com>
In-Reply-To: <20241015-b4-upstream-j721s2-avs-v5-0-5c8087387dc5@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728989539; l=9673;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=D7wjM941qms37LNoK6UOO1FlWDz30bKnzCgTgkaWeuk=;
 b=YVI5ZS7tniobfdz6ioentugYj+2gYDvXDWGu9diJQPoHHvcrtY8VabezDEkilgKiY+QEh3YFO
 TxTn/vhwZOaCLxNHX6R5Fyj9Ybls6oCgIOnod7m0fFhIpkCeTxhdSKm
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

MPU clock had been missing. Distinguish multiple clocks with clock-names
and add MPU clock as well.

Link: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j721s2/clocks.html#clocks-for-a72ss0-core0-device
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-am62-r5-lp-sk.dts              | 3 ++-
 arch/arm/dts/k3-am625-r5-beagleplay.dts        | 3 ++-
 arch/arm/dts/k3-am625-r5-sk.dts                | 3 ++-
 arch/arm/dts/k3-am62a7-r5-sk.dts               | 3 ++-
 arch/arm/dts/k3-am62p5-r5-sk.dts               | 3 ++-
 arch/arm/dts/k3-am642-r5-evm.dts               | 3 ++-
 arch/arm/dts/k3-am642-r5-sk.dts                | 3 ++-
 arch/arm/dts/k3-am654-r5-base-board.dts        | 3 ++-
 arch/arm/dts/k3-am69-r5-sk.dts                 | 3 ++-
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 3 ++-
 arch/arm/dts/k3-j721e-r5.dtsi                  | 3 ++-
 arch/arm/dts/k3-j721s2-r5.dtsi                 | 3 ++-
 arch/arm/dts/k3-j722s-r5-evm.dts               | 3 ++-
 arch/arm/dts/k3-j784s4-r5-evm.dts              | 3 ++-
 14 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/arm/dts/k3-am62-r5-lp-sk.dts b/arch/arm/dts/k3-am62-r5-lp-sk.dts
index ec5d3f4ba2cb..b8e5f49a1fc7 100644
--- a/arch/arm/dts/k3-am62-r5-lp-sk.dts
+++ b/arch/arm/dts/k3-am62-r5-lp-sk.dts
@@ -25,7 +25,8 @@
 				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
 				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		clock-names = "gtc", "core";
 		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
 		assigned-clock-parents = <&k3_clks 61 2>;
 		assigned-clock-rates = <200000000>, <1200000000>;
diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-am625-r5-beagleplay.dts
index f0b66f0cb945..9e0a6ed67844 100644
--- a/arch/arm/dts/k3-am625-r5-beagleplay.dts
+++ b/arch/arm/dts/k3-am625-r5-beagleplay.dts
@@ -24,7 +24,8 @@
 		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
 				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		clock-names = "gtc", "core";
 		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
 		assigned-clock-parents = <&k3_clks 61 2>;
 		assigned-clock-rates = <200000000>, <1250000000>;
diff --git a/arch/arm/dts/k3-am625-r5-sk.dts b/arch/arm/dts/k3-am625-r5-sk.dts
index 0912b953db07..d2dd75469c1a 100644
--- a/arch/arm/dts/k3-am625-r5-sk.dts
+++ b/arch/arm/dts/k3-am625-r5-sk.dts
@@ -25,7 +25,8 @@
 				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
 				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		clock-names = "gtc", "core";
 		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
 		assigned-clock-parents = <&k3_clks 61 2>;
 		assigned-clock-rates = <200000000>, <1200000000>;
diff --git a/arch/arm/dts/k3-am62a7-r5-sk.dts b/arch/arm/dts/k3-am62a7-r5-sk.dts
index bc05dcb5efbe..464227b3b25d 100644
--- a/arch/arm/dts/k3-am62a7-r5-sk.dts
+++ b/arch/arm/dts/k3-am62a7-r5-sk.dts
@@ -23,7 +23,8 @@
 				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
 				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		clock-names = "gtc", "core";
 		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
 		assigned-clock-parents = <&k3_clks 61 2>;
 		assigned-clock-rates = <200000000>, <1200000000>;
diff --git a/arch/arm/dts/k3-am62p5-r5-sk.dts b/arch/arm/dts/k3-am62p5-r5-sk.dts
index 658f2cf730a7..baf1a83dc124 100644
--- a/arch/arm/dts/k3-am62p5-r5-sk.dts
+++ b/arch/arm/dts/k3-am62p5-r5-sk.dts
@@ -26,7 +26,8 @@
 			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
 			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		clock-names = "gtc", "core";
 		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
 		assigned-clock-parents = <&k3_clks 61 2>;
 		assigned-clock-rates = <200000000>, <1200000000>;
diff --git a/arch/arm/dts/k3-am642-r5-evm.dts b/arch/arm/dts/k3-am642-r5-evm.dts
index be8596987bab..933f75095b11 100644
--- a/arch/arm/dts/k3-am642-r5-evm.dts
+++ b/arch/arm/dts/k3-am642-r5-evm.dts
@@ -22,7 +22,8 @@
 				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
 				<&k3_pds 137 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		clock-names = "gtc", "core";
 		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
 		assigned-clock-parents = <&k3_clks 61 2>;
 		assigned-clock-rates = <200000000>, <1000000000>;
diff --git a/arch/arm/dts/k3-am642-r5-sk.dts b/arch/arm/dts/k3-am642-r5-sk.dts
index 2186152a0b8e..6e31dfd97c5e 100644
--- a/arch/arm/dts/k3-am642-r5-sk.dts
+++ b/arch/arm/dts/k3-am642-r5-sk.dts
@@ -22,7 +22,8 @@
 				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
 				<&k3_pds 137 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		clock-names = "gtc", "core";
 		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
 		assigned-clock-parents = <&k3_clks 61 2>;
 		assigned-clock-rates = <200000000>, <1000000000>;
diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index dea2ba85dcb3..ab5195eb15c5 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -22,7 +22,8 @@
 		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
 				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 202 0>;
-		clocks = <&k3_clks 61 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
+		clock-names = "gtc", "core";
 		assigned-clocks = <&k3_clks 202 0>;
 		assigned-clock-rates = <800000000>;
 		ti,sci = <&dmsc>;
diff --git a/arch/arm/dts/k3-am69-r5-sk.dts b/arch/arm/dts/k3-am69-r5-sk.dts
index 4d6aab5ccc38..13809f82d99a 100644
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
index 94760c78dd35..f8df14935dbc 100644
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
diff --git a/arch/arm/dts/k3-j722s-r5-evm.dts b/arch/arm/dts/k3-j722s-r5-evm.dts
index aff83cd5d914..69785ec78e94 100644
--- a/arch/arm/dts/k3-j722s-r5-evm.dts
+++ b/arch/arm/dts/k3-j722s-r5-evm.dts
@@ -25,7 +25,8 @@
 			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
 			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		clock-names = "gtc", "core";
 		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
 		assigned-clock-parents = <&k3_clks 61 2>;
 		assigned-clock-rates = <200000000>, <1200000000>;
diff --git a/arch/arm/dts/k3-j784s4-r5-evm.dts b/arch/arm/dts/k3-j784s4-r5-evm.dts
index d2c752293630..8b8b0e70047e 100644
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

