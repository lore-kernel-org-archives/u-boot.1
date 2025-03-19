Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C452EC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54F5B81F44;
	Wed, 19 Mar 2025 16:15:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Yqjm06GC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BED481F0D; Wed, 19 Mar 2025 16:15:58 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 022868198A
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52JFFqsQ357008
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 10:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742397352;
 bh=CjwmE1W0PdwnfntciOJ2ujlo9L2T5p/lbC/9/72yM/w=;
 h=From:To:CC:Subject:Date;
 b=Yqjm06GC1L/MSnIxh9XJI7B+AYWTMAdcDfsiCm8tU4V1ZGz2MnwqGuDhiewWsnulk
 4R9ZhKGtyugcBHnFGkvsudwKAEedIFKDS49AJvRBP7UrMpR2Kwc+Q33klZ+PlmC1F/
 nB0DWYp52sl4kpIAhgXL/nKtjk1yPwka+GlyKFU4=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52JFFq2k011582
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Mar 2025 10:15:52 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Mar 2025 10:15:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Mar 2025 10:15:52 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52JFFpML123058;
 Wed, 19 Mar 2025 10:15:51 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH] arm: dts: k3: Remove leftover file after OF_UPSTREAM
Date: Wed, 19 Mar 2025 10:15:50 -0500
Message-ID: <20250319151550.163275-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
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

The file k3-am62a7.dtsi is part of upstream DT and should
have been removed when migrating to OF_UPSTREAM but must
have been missed. Do this here.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/dts/k3-am62a7.dtsi | 104 ------------------------------------
 1 file changed, 104 deletions(-)
 delete mode 100644 arch/arm/dts/k3-am62a7.dtsi

diff --git a/arch/arm/dts/k3-am62a7.dtsi b/arch/arm/dts/k3-am62a7.dtsi
deleted file mode 100644
index f86a23404e6..00000000000
--- a/arch/arm/dts/k3-am62a7.dtsi
+++ /dev/null
@@ -1,104 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only OR MIT
-/*
- * Device Tree Source for AM62A7 SoC family in Quad core configuration
- *
- * TRM: https://www.ti.com/lit/zip/spruj16
- *
- * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-/dts-v1/;
-
-#include "k3-am62a.dtsi"
-
-/ {
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu-map {
-			cluster0: cluster0 {
-				core0 {
-					cpu = <&cpu0>;
-				};
-
-				core1 {
-					cpu = <&cpu1>;
-				};
-
-				core2 {
-					cpu = <&cpu2>;
-				};
-
-				core3 {
-					cpu = <&cpu3>;
-				};
-			};
-		};
-
-		cpu0: cpu@0 {
-			compatible = "arm,cortex-a53";
-			reg = <0x000>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0x8000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
-			next-level-cache = <&L2_0>;
-		};
-
-		cpu1: cpu@1 {
-			compatible = "arm,cortex-a53";
-			reg = <0x001>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0x8000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
-			next-level-cache = <&L2_0>;
-		};
-
-		cpu2: cpu@2 {
-			compatible = "arm,cortex-a53";
-			reg = <0x002>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0x8000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
-			next-level-cache = <&L2_0>;
-		};
-
-		cpu3: cpu@3 {
-			compatible = "arm,cortex-a53";
-			reg = <0x003>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0x8000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
-			next-level-cache = <&L2_0>;
-		};
-	};
-
-	L2_0: l2-cache0 {
-		compatible = "cache";
-		cache-unified;
-		cache-level = <2>;
-		cache-size = <0x80000>;
-		cache-line-size = <64>;
-		cache-sets = <512>;
-	};
-};
-- 
2.39.2

