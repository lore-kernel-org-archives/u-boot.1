Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C03FCFA74A
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 06:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3C388904A;
	Fri,  4 Oct 2024 08:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XYYPCT9a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A05FA882B7; Fri,  4 Oct 2024 08:24:49 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BECB88CE5
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 08:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4946Oj2Z074816;
 Fri, 4 Oct 2024 01:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728023085;
 bh=/bq2PlDJaPikkPRClnekFqki6lOXvCisKTyjAM7yzyM=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=XYYPCT9aooSgCVWQPW0X9wC+gf59BmlksaM4Y2LrrQvm4IQ3MfTmhUq/KlNS2LBQm
 cEwRkRFYfSTnL075hCLf6wAyNM9FNc5Hpq1SGH+MIq9uSYfG+DeRPdDopr8E38BPm9
 U4xeCWbgfyZCJCUj/TZrLCGL/WYAH1MeUKZkrmF8=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4946OjC9020351
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 4 Oct 2024 01:24:45 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Oct 2024 01:24:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Oct 2024 01:24:44 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4946OVZ0100112;
 Fri, 4 Oct 2024 01:24:42 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 4 Oct 2024 11:54:31 +0530
Subject: [PATCH v4 3/7] arm: dts: k3-j7*-r5: Add MPU clock in clocks property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241004-b4-upstream-j721s2-avs-v4-3-6d71c6bab9f4@ti.com>
References: <20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com>
In-Reply-To: <20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728023071; l=3592;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=kP7APbwX3L6xYjiyLH7gx2qOtLBCFUfMjUTjXqWZQJg=;
 b=wDY2dYuHUL+xCBBS5lx8Kn9UIXtwYLN/fXAW+UrAWcuSOQVyDjMvVen3mOb9GPMwYBUJcoIWc
 E5ySA7ZDi8bBVYnrIAV0W9uqJA+ttLu0gfrDcML8KdVOupVynb6gThe
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

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-am69-r5-sk.dts                 | 3 ++-
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 3 ++-
 arch/arm/dts/k3-j721e-r5.dtsi                  | 3 ++-
 arch/arm/dts/k3-j721s2-r5.dtsi                 | 3 ++-
 arch/arm/dts/k3-j784s4-r5-evm.dts              | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

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

