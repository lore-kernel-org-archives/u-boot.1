Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB2DFCD0A7
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 04:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EF25842EF;
	Wed, 18 Mar 2026 05:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="mnLsNHYW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A10D38415D; Wed, 18 Mar 2026 04:17:27 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74321840F1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 04:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwoWBcTJm+i4PdXs+sM293W4/Nzfpu3VWV6o13fC51CVyHaLebbA6a6OvixLhHmcAkQamleRSQ0zzrV0K2d3WTrm8IZv66ynpqEaiDH4sX0Jlp3jmHGuiUXUw8gP7qMCrozoHwBof+v8m1ZuH0gbTHRBmwF9gCa55+iytlIgxibRS1R1v67RhkzIwspPhee4q2Zj2mUWKZqh+ZX0gqaJKGk/S0Bccu97aDCKpsSoBBGFh3wSGAVSLnnRfYLQJX2mxE9ADT0jB3naErsJOow5Nf4XMo3lbdC1DNIQbwwd2TZuHzkMFySmRZ89gECy8rQv/s2Gy3tCMWHfp8Jr/neJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aDdMCP5kg3lcQaMTUJQ/z0vbV+/yHwJ3hYINlQt6ak=;
 b=U64bk6Dt11zmp54iDldIclX0CWDpFcKGPH/81gEZxNZqMEi8uMOq9HkXXm+3FKFHe0Xom0/artVtp4ppNTJ+UJ2qQRWwIgg8BRE+3qVhAwfuSKqFkEC5XCT+tnJXzd4MzFb8KwJPIJ8NpcEHef70DtzwSRBKqPJVDOmv+/9B1y8R25pWgKm1lLpDTi1gSUDib6bmV7FXZnM7kJHJEoDJhK5XmxYCWSP7f6noljkkfDCQ1JZWwxgsRQrZ5+6kvuf7Soer1MEw4M6J9zI9MO10fmBmj5Y+uS9GSjaGiZsXjfBVZ6lIfdmWQDGuJpeR3MZeq2gyMP4Z70Dev9NVdAml6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aDdMCP5kg3lcQaMTUJQ/z0vbV+/yHwJ3hYINlQt6ak=;
 b=mnLsNHYWRwZDqXhMwkF622jhHRQL5fiHyD2chCNeHlsMl/Fji2OHhV0bbgns55kUJideeUQW8VoEjnyAXA/NUtBgZKDelWdLKXp1d2o35nlLZ7yu8YWf7YMIgw9YPXcmONGCohOlcOqfPXaETaBFBjP9ST5o8Z1WkliCVxh1FD1BnPSZYBGPT1Mt4NywwWQWFHDNrKx9JeNrxCDiJlx64r25v/+3VeW498hGE3F5GV+5td9sBdxg9VVVMYHP5qamfUwx9lWelZuwD4g46mEPQVr9rv7WAttjF8yjPNXLN1es6pTZbw9oBVgqlJqQFv2vaUpAGc881abrZgbreoDUuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SA1PR03MB6578.namprd03.prod.outlook.com (2603:10b6:806:1c9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 03:17:21 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 03:17:21 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1 7/8] arch: arm: dts: n5x : Switch to using upstream Linux
 DT config
Date: Wed, 18 Mar 2026 11:17:07 +0800
Message-ID: <20260318031708.9418-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::21) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SA1PR03MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 7281486b-0b00-4681-0fac-08de849cde28
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|55112099003|56012099003; 
X-Microsoft-Antispam-Message-Info: /D3KsJS64DZwWAUVGDrw+zJxkGv1Zzlf52LRY6iLLv6pBXm5MZR0hpDY8LT8NlzWFL4jhM5U52tLGc0+2SWQArUEMMT5NlNU5d5czPtaaSLdO0pwJGrewn0ULJaSOfAhWzN6OrZpa+I1xuIroUwo/rs7/0qlDSWa4WcQJC6t5bZKqRCDpgjMNZjb+N0y0Y8WfbzrGDdreTob8s1eVXSkVEyW3OKlakBTjXDzvB4r7IwsRd+Jh6JvBmJRi0tQ+1uUaTbNGZMLR7basAGrG428zjbNo+SKS3O4salfDGyC68NhtjRXnv4mn2jZymXfwV/Dk6DEZfTdzOVjOfzJMnU5nvNCE5WYwvB7PXlmxYUcaT6h8/GAiKGfQL1TS2VPhVoixIvUELzua9vIJitX08NRB15K6d8xcql9ysyR7qEWX4sjKeQ0R/gL4tXTK6qp7qyL8boIjoL2kxrsbm7JUFxXyIdUMbIXfPiYpq9NxYQMsNoUh2H0BU2I9ty6UOhi0BFMIysWdAV+07/D69qy9/CyUat9Gq/lHhfus4/trhHpIK3zlDiDl3HTX/FcaD48RTZ3aMXj9zu5zOdXalrBPD2CYd4DbZ/Lm8d6upglBeaNgKUOrmPaUGhuGTU+hprZOYi/lIGq6eRsqTikg8GmcKpnItB3ONrqMKXfpV92OzoZaS4eBLL2ieceTg/+51cjEChCDOleRJXzpKvFs+PjNkBNJoLhJfilE73FIJrdS2ModU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(55112099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q5/+SYn1xOFuJY+n5pUm2WFVJhP1Q3hlGnkPInF/IFd3Wx7/yJ9keWTouQJz?=
 =?us-ascii?Q?HubZqEHJ7lcFv2bgzh1rY6+sJm95I5RpE2cOxN5/BdoC1krtO15Uhd+m+14m?=
 =?us-ascii?Q?vEwuNG4kWpZ5VkN5NoV9+VE5vsKlGI4bS8SMuRM4+wryE8XAe+mGdUpGQP6A?=
 =?us-ascii?Q?sMWTtNrVHj+medt/idtJttcoSyEZwoPDvRxQEk3Lwkk6ioJxVQpPpUJx+Wn5?=
 =?us-ascii?Q?5MCPkvSq6SMvD5MeE25rKfGWWx2MLROgPV+5YltBGh+Hr5WB+N45ChDlfSWG?=
 =?us-ascii?Q?SSGuSvNrdTBrCeHTNT/XtBpvwOXIonlWoERMgV+B2lqVlREkl2au+x/lVxi2?=
 =?us-ascii?Q?WLL+ICSOYi8SwvihPeGMaH27p36yepVdNuWe+Nz5C9Sr5qz/PsQaNHsfi0KV?=
 =?us-ascii?Q?PCl57yXoDHfjzLzizlvuC/Xr6999pGiA1dKbfaKh3LAsCrmPnNgMWQqrOdMs?=
 =?us-ascii?Q?9322FEO8yK2AszhnMFEOWL/aORyMxkrBDwGqbg6PR2Fk00JYeXc1VNT0wrUe?=
 =?us-ascii?Q?Hr/1FjWg4ArM3stDy9/tuWrpnOlzb8fU7SuqpW/bMUOVNFt3L8BbsJuXyEt6?=
 =?us-ascii?Q?HjqujEOWgjIkFnoL0bRqOj5P7FFHn5ADRnL5CP2P8+Um+Tb+oGMHw33TKnJQ?=
 =?us-ascii?Q?4CSsVYcFBzCQjaLp8C2PESwTlNsNYqaCW3tt7rFovrXV8F39QyfNs5ZYi5ZM?=
 =?us-ascii?Q?6GRsfzvQXoz4z03iB93qkgykBtQBNjTWpHFVXJrk/kma3qjsmjtq7hgq/Muz?=
 =?us-ascii?Q?1jyeQC7zBhEQZE5SP5lGXRG69TLx6cMgxcGFX/c3jzmTw06ZoI6JyxDLyP/F?=
 =?us-ascii?Q?dXeScOGjYcH3Uh6bxAwRxMe4bQtcxZaEJ9pyhHsxCx3OQEO6JEbDt1Btgyrz?=
 =?us-ascii?Q?/76MyoOf/uLGpzXYYDytyCclj7pTF9godYwnB6i4qp2P8l16TI31Zb8UF/qQ?=
 =?us-ascii?Q?J+GcqkY7+bIAA9juSDyxylm+SagHuox/s/V3abXl5RdUdyes0YKOZlmXfp/t?=
 =?us-ascii?Q?KIO5D4RVAOD/0EXeM3CsQnDrb6NQrvIQWlashp9Ppwja/JBZzswSYscneise?=
 =?us-ascii?Q?MKBQ4ZitJmv7UjKkHNgV+lu15jJ0C75glEJAI0258xW6UwNy5GhxpIXRyIor?=
 =?us-ascii?Q?8sx4zpGagLN5CIg0aunYHRnelZUr/P1NoMZWt+68RBRSOr/auCU8D95pYFaP?=
 =?us-ascii?Q?okuH8u2WjVp+usjYQxwSmEUNPiDDk2UAubFgn72Cy75vV6bsfT6jpv2eISYK?=
 =?us-ascii?Q?ZpXO3z/ToMN/CDHl9guave2QWTIG+TfK65swX6fntVTNn9Lwdl8Vsk9F6ewB?=
 =?us-ascii?Q?ZOBKEyiBM18W3BChx72Z9Pwh6WXTBRX9KV9b/UsVaQxhDI2mZFdNZ4H11uKJ?=
 =?us-ascii?Q?GFG6FZu/UDWulzRNyfSi6XMPQ28LTmGEB+tcYNLCLnAfkwWaRqiAJKdoFSJn?=
 =?us-ascii?Q?XsIauYSOTyFtanbW+zVPvKW56zdUjSgRRe411H4R0d/SsPk0lfJ3f6kcTmQZ?=
 =?us-ascii?Q?h4MSoIE1YvhyHM1cKCD9WyNK7bKv0Pz1295iJNoqDDWAUBQG9ZqiGvG2GHiN?=
 =?us-ascii?Q?C1q+9izeDwnLdW2ywdUezey+47UcdWkPNkXw7mmTp8hPe4keF9HYHZYzGVGc?=
 =?us-ascii?Q?OMyNRh8vYJYmHwIwKe29W78v+he97f7faCEDTTQFVG1Q0BkoMiSukuqw8Id4?=
 =?us-ascii?Q?Xh9nFP6K5BA1UoBOUa6RrEaBaNHOjg6hfeePppKNJ53kdjcprV/qOSXsQFHs?=
 =?us-ascii?Q?TTOk0XhabfqKjhnWv4Kdo4VE9yXG5yY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7281486b-0b00-4681-0fac-08de849cde28
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 03:17:21.4040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0c6udCwmxokhZziSd+/nD9GBd7yjn/tse3rFtr5Zy+EwaWxNLxrh2K7GQZt/dlzPUxRqxx1ok7WUoPfxQLh9jE1m1x3dPBOWvzT28ut9Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6578
X-Mailman-Approved-At: Wed, 18 Mar 2026 05:11:17 +0100
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

Migrate the legacy n5x platform to use the upstream Linux device tree
configuration. This helps reduce maintenance overhead and aligns U-Boot
with the Linux kernel's DTS hierarchy and naming conventions.

This change improves consistency between U-Boot and Linux by removing
custom/legacy DTS handling and instead relying on the standardized
definitions provided by the upstream Linux DTS.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 arch/arm/dts/Makefile                      |   1 -
 arch/arm/dts/socfpga_n5x-u-boot.dtsi       |  18 ++-
 arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi |  20 +++-
 arch/arm/dts/socfpga_n5x_socdk.dts         | 122 ---------------------
 configs/socfpga_n5x_defconfig              |   3 +-
 5 files changed, 33 insertions(+), 131 deletions(-)
 delete mode 100644 arch/arm/dts/socfpga_n5x_socdk.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 82ad3035308..3c62b784ffe 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -469,7 +469,6 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
 	socfpga_cyclone5_socrates.dtb			\
 	socfpga_cyclone5_sr1500.dtb			\
 	socfpga_cyclone5_vining_fpga.dtb		\
-	socfpga_n5x_socdk.dtb				\
 	socfpga_stratix10_socdk.dtb

 dtb-$(CONFIG_TARGET_DRA7XX_EVM) += dra72-evm.dtb dra7-evm.dtb	\
diff --git a/arch/arm/dts/socfpga_n5x-u-boot.dtsi b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
index 326ba722a25..477af977f78 100644
--- a/arch/arm/dts/socfpga_n5x-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
@@ -10,7 +10,13 @@
 #include <dt-bindings/clock/n5x-clock.h>

 /{
-	memory {
+	aliases {
+		spi0 = &qspi;
+		i2c0 = &i2c1;
+	};
+
+	memory@0 {
+		device_type = "memory";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		bootph-all;
@@ -121,6 +127,15 @@

 &qspi {
 	bootph-all;
+	compatible = "cdns,qspi-nor";
+	flash0: flash@0 {
+	};
+};
+
+&flash0 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "jedec,spi-nor";
 };

 &rst {
@@ -200,7 +215,6 @@

 &usb0 {
 	clocks = <&clkmgr N5X_USB_CLK>;
-	disable-over-current;
 	bootph-all;
 };

diff --git a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
index bc2fb91dfb5..f013ed49cd3 100644
--- a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
@@ -8,12 +8,11 @@
 #include "socfpga_n5x-u-boot.dtsi"

 /{
-	aliases {
-		spi0 = &qspi;
-		i2c0 = &i2c1;
+	chosen {
+		u-boot,spl-boot-order = &mmc;
 	};

-	memory {
+	memory@0 {
 		/*
 		 * Memory type: DDR4 (non-interleaving mode)
 		 * 16GB
@@ -38,10 +37,21 @@
 };

 &flash0 {
-	compatible = "jedec,spi-nor";
+	reg = <0>;
 	spi-tx-bus-width = <4>;
 	spi-rx-bus-width = <4>;
+	spi-max-frequency = <100000000>;
 	bootph-all;
+
+	m25p,fast-read;
+	cdns,page-size = <256>;
+	cdns,block-size = <16>;
+	cdns,read-delay = <1>;
+	cdns,tshsl-ns = <50>;
+	cdns,tsd2d-ns = <50>;
+	cdns,tchsh-ns = <4>;
+	cdns,tslch-ns = <4>;
+	/delete-property/ cdns,read-delay;
 };

 &i2c1 {
diff --git a/arch/arm/dts/socfpga_n5x_socdk.dts b/arch/arm/dts/socfpga_n5x_socdk.dts
deleted file mode 100644
index fe5462aff43..00000000000
--- a/arch/arm/dts/socfpga_n5x_socdk.dts
+++ /dev/null
@@ -1,122 +0,0 @@
-// SPDX-License-Identifier:     GPL-2.0
-/*
- * Copyright (C) 2020-2021, Intel Corporation
- */
-#include "socfpga_agilex.dtsi"
-
-/ {
-	model = "eASIC N5X SoCDK";
-
-	aliases {
-		serial0 = &uart0;
-		ethernet0 = &gmac0;
-		ethernet1 = &gmac1;
-		ethernet2 = &gmac2;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory {
-		device_type = "memory";
-		/* We expect the bootloader to fill in the reg */
-		reg = <0 0 0 0>;
-	};
-
-	soc@0 {
-		clocks {
-			osc1 {
-				clock-frequency = <25000000>;
-			};
-		};
-	};
-};
-
-&gmac0 {
-	status = "okay";
-	phy-mode = "rgmii";
-	phy-handle = <&phy0>;
-	max-frame-size = <9000>;
-
-	mdio0 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "snps,dwmac-mdio";
-		phy0: ethernet-phy@0 {
-			reg = <4>;
-
-			txd0-skew-ps = <0>; /* -420ps */
-			txd1-skew-ps = <0>; /* -420ps */
-			txd2-skew-ps = <0>; /* -420ps */
-			txd3-skew-ps = <0>; /* -420ps */
-			rxd0-skew-ps = <420>; /* 0ps */
-			rxd1-skew-ps = <420>; /* 0ps */
-			rxd2-skew-ps = <420>; /* 0ps */
-			rxd3-skew-ps = <420>; /* 0ps */
-			txen-skew-ps = <0>; /* -420ps */
-			txc-skew-ps = <900>; /* 0ps */
-			rxdv-skew-ps = <420>; /* 0ps */
-			rxc-skew-ps = <1680>; /* 780ps */
-		};
-	};
-};
-
-&gpio1 {
-	status = "okay";
-};
-
-&mmc {
-	status = "okay";
-	cap-sd-highspeed;
-	broken-cd;
-	bus-width = <4>;
-};
-
-&qspi {
-	status = "okay";
-	flash0: flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "mt25qu02g";
-		reg = <0>;
-		spi-max-frequency = <100000000>;
-
-		m25p,fast-read;
-		cdns,page-size = <256>;
-		cdns,block-size = <16>;
-		cdns,read-delay = <3>;
-		cdns,tshsl-ns = <50>;
-		cdns,tsd2d-ns = <50>;
-		cdns,tchsh-ns = <4>;
-		cdns,tslch-ns = <4>;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			qspi_boot: partition@0 {
-				label = "Boot and fpga data";
-				reg = <0x0 0x034B0000>;
-			};
-
-			qspi_rootfs: partition@34B0000 {
-				label = "Root Filesystem - JFFS2";
-				reg = <0x034B0000 0x0EB50000>;
-			};
-		};
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
-
-&usb0 {
-	status = "okay";
-};
-
-&usb1 {
-	status = "okay";
-};
diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index 6e55987d310..db43046a9f3 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -11,7 +11,8 @@ CONFIG_SF_DEFAULT_MODE=0x2003
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x200
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="socfpga_n5x_socdk"
+CONFIG_DEFAULT_DEVICE_TREE="intel/socfpga_n5x_socdk"
+CONFIG_OF_UPSTREAM=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0xffe3f000
 CONFIG_SPL_TEXT_BASE=0xFFE00000
--
2.19.0

