Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B349EC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 01:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58140880E5;
	Thu, 28 Mar 2024 02:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BlPeaK+f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E43087FD7; Thu, 28 Mar 2024 02:46:55 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41909880AC
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 02:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGaMP6vPNBwYOV/C/R1tceVwrghwmwZHByZr96af4ddEeIDp6peFwMFjYRQRuUViYZ23rdYnTmzBk/u3Ecuqes+MOzXbzOZnTceb/FzL2IRoKq8QTlELmvw5YZcJGq/wFGccsL6UVCWlgsJChwK7crXZdSO21MAVr1W6H56cBcIg+eXPRuQ/133Syr4eixap9Cjx/ezn3HDevDe8W98tGL75JDwI1NqAh4DcFBgyV4gstsUVBrPQxuQ5HO4Pyc8oJaTj3auq5N63aVrLLvq3U7bniiqus+ET5psznqRuwejoXHyrwJ6uDQABLizU/xXop7VDm/MiZC5CGkW/fJnV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDt2Ze7guoJX8D5eoXXjYgHzXku5qxg24fTqzVnHX7Q=;
 b=gcorjEUDEtVwysr0eOuEJNv47hAWSBGc2EEk8pOF/euQdoTiaAoryuJ6lFOcoEHGcPPD8Z10ZCnEsiJXQk57XJZD+t5eeBHDRqpVKbEe4YVRNvqGI2Yn0kHNcOuRSlxp9HKl0EoEv1HJl6ZxWmOhz1OYGYcyN5nMbm1dTR/8XDb6QvdcWvampjxZrKpeGNIjJiKMsK2CJRlwTO7+/83yca4QIISN6XKQ1XnRee0lECBZntWl3vZwUsXLMroK58qCPScwbIw3Ztwax8byfiTlt0e2KJ13zN6ZHFU3Y6N5sV7Ief5XAOxjfcXolTJEVh3OxjML/AaCVO0+ct76v2L5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDt2Ze7guoJX8D5eoXXjYgHzXku5qxg24fTqzVnHX7Q=;
 b=BlPeaK+fEHVQOJty5QTPtnCEez1zURxH7vaWkfh+H2Tp2yxvoJo/XUHUbo8gzaAly8iA9bNj4G4+S9CmVbUqquVWvYfvypAiwI9JDlsz3RlZKj74Aj6djLEWUl2v3oO35Hettb8jFR2T/QU59gDbN8Ns1oACr2ZiYoXHa7hNP1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8496.eurprd04.prod.outlook.com (2603:10a6:10:2c8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 01:46:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 01:46:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 10:45:10 +0800
Subject: [PATCH v2 3/4] imx: imx8mn-evk: convert to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx8m-v2-3-7656998cc8b0@nxp.com>
References: <20240328-imx8m-v2-0-7656998cc8b0@nxp.com>
In-Reply-To: <20240328-imx8m-v2-0-7656998cc8b0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: aec2e5ad-a775-4812-88a5-08dc4ec8f09d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VvYzFLmF1cwV/R6omNJdu//vE8Sxn4ALJt/jmtLi3n7LzVgtxNWfAVLOYhdEremjTCWsUpBh1VXsnz/fSoNBoicgsWxjkdNwa3C+4JvIc2n4EwNi8m6YjceeQCkbk+s5l/T/1GUjkWaMihs76vYelGx4DOfORKLa5/0Pfzm5JqzgRl29tbj+IiU2MltlhCh+1ZbN1jbfymVzR84uiIjl9nR6va+yWuRAy5JCJIi1Me7ryZSzmI92FYn6NZ7Z/uHM1Y62+St5nlc6uiOud67heBXgpCEL5BamVPWpCfRe68vkOV1IZrgdeAPAaC49QrdFcjMY5oy/fWopvakNR3KBH39ZNE1Nex8cskbD3InKTcOpGoBHGhLOMHmQge9kBm6bf8lhEn0viwuwh0i1jTHF7QeR8WZT/vcSca5o2yA7vsIrlkOTDAvfdRHW1LOPcdC3a3b4RFwOqCRClJHofZlo9RDCbDipGaSG0o8d7f46plra4nyGyrf9XncWqW+O8sMoEZ5n1oE5bFJFJra7h6K5QyG7Un0Bc6RBxrYUfhpxju2X1ZtO8YBldJflJp+QUtuGpJmk8lxNzOcdX+rE3s1hRKTZ3L9XIN3iy9MoLNjWjjrRLoXfzT9FqLP2a8FIHFpOtIwI4m+25wRW1Kpt2A2PRLCIFrn7+uxyouAhiNhr3X+KaNpXzPcR33o2Lm1wMyqJuWQGgw8GNgFSADDe3Sp+hVi//w1ExdKqn3uFjy7OLzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXRVb0U2NDJKeUphSEtxbTdiRmptb3Y1YlNDUHh1YmtiVm84cVJoYWVFRnhj?=
 =?utf-8?B?YzBJTFBwYk5OdUZKdGxMM2RlWXNqclN1N2MyWVA5MjR0eWVLaFVjQVJ3MEFJ?=
 =?utf-8?B?REsxc1NqQmRBQzhodHd1VkZPa0NzcmhzUldhbFpIa3U0WDlFSzNEdzhoSDN1?=
 =?utf-8?B?anI1SkdDSFJHNFQ0ZFlBUmFnc3krOHNVVDhyTzZtUVczajRrS05Db3hvdmhH?=
 =?utf-8?B?cG1XSnZTdkxNNDNIT3dEYytLa3R0RHBTR1JYRmFsUXFPcVlrZmorbzg4YUk1?=
 =?utf-8?B?cVdINzdLNnVLUk9VckQ5Mnp2MHVlY2w1bndTK1VLZlVPTHBtU1dRWDVkR1J3?=
 =?utf-8?B?NjZLNE5CN1FpbmlZZVdadHg5dlJjNExhUmNrUng0V0p0cm5mQ0YvT0E5RHhW?=
 =?utf-8?B?SXFXbVRUbEdvUDdzOE04UjZZNFpxeEJNS2hHV25iWEluY3dIUkx0U0hhcmhW?=
 =?utf-8?B?dzcrM1R6Q2FWYzBGZHM0N1Q3OGR6VFdraUNLU0NocXV0cGVac1VndzY5K3lV?=
 =?utf-8?B?RnBQL0ltQUlMbml5c0tLYVpTZWt4UnVnV3kzcW1KTG11ZzVQaHFTaWQ0VjFp?=
 =?utf-8?B?VzJKZVR6aGZlbitGMVpuaXZkdWRuc1BUbWhFRVVqMmtXOXJNaXlHenJpckVG?=
 =?utf-8?B?VkJiQkFiSnF5OWRMWElOMitFdjNuaG5oWmd0cnFlcTI2MGZMcGM3ZzA4cTd4?=
 =?utf-8?B?dmI1U3QyQWg2ek9IQkNTNTZSWjRuTVd3K1hobkE3bC9MaGFQUVlIWEtMb2Fl?=
 =?utf-8?B?NXJtcXhzdi93V1EvSnVjZ201YUM3OFlDbmk2UStsczVYNFgvZzZtalM4TVQr?=
 =?utf-8?B?NEY3OHdYR2F2T0ZVVDB3alprMVRjUm9PZ3FkWXBkQkRLMjVXR0hsQytwL3Jt?=
 =?utf-8?B?bm16cnd2ZGdQWUhDdkNudjE3QXJGaUsyMEZsamxLeEs4VnVzaTM5bTY4alFn?=
 =?utf-8?B?KzlLcGxqOXFObHRxQWJNcnFmRTNaWUg3anVpbTF6QTRtNUlJUGJISFI4cFhy?=
 =?utf-8?B?ZXY1MEdna3lRQWtaM1QzeDZ0UzdHVys5blZzaXFldXZMNGhkYUxlc1pDMHpq?=
 =?utf-8?B?dGZ0a1BTMXFZUHVRM3ZVVzJaODdlZkp0bndHZHhiZDVFYU9ZZkxaeVRoTVZi?=
 =?utf-8?B?REdJWXFnakx0VDFTN3RoY0tNc3VYSEF5WTBHaFVqZVhUYXB0VUJMaXlUVm83?=
 =?utf-8?B?T1Bad29vRFlUM0kvcE1ZNElJdUcxSklrM2MwRklKdnZzTzRpM2tCZUx3MTUx?=
 =?utf-8?B?RVpobC8ySlpCbE1QaGwvUHlreXhUVDdZelJZakVXRjRFL1lVWDdVMm5aR1pa?=
 =?utf-8?B?MFU4cVNpYWtUWGJQSHhzNXhwNy9NOUgwQW1zZGNyeXBmWkJLOHpRV2lRU0Yw?=
 =?utf-8?B?eUZNSHdzNVp2RUVRbCthbDQxcWdCME9Ga2l1dktZMzNBNEhpdTNYODRyWFdL?=
 =?utf-8?B?cnJ3VFhOWFZlMjRuVkpaOGJ1eldiTTVaTjFYNER0LzhvazVPZEVleStJYnlY?=
 =?utf-8?B?UnppN2UwOHBSNzFsQm1mNGQ3akc2eDc0eEVXQUViR0N4dGg1QTFHQ3lBYVFH?=
 =?utf-8?B?bDQzbFFleXBvTUU1eCs2aGVsS2hZc2tDSnp5NVdyaitoRklQeElwUlZMV3BD?=
 =?utf-8?B?OGJlUUFWLzhBa2dyazBmUHB6WU56WUJnNno2RWpjKy9mVkVnNjMwMEhlYnV3?=
 =?utf-8?B?SUFlclg3ZXBFV0JZRFFObEp0TFBNYzRsSnhOQlpqbDNjVnpST25PUmFsMGpu?=
 =?utf-8?B?dWRDcTlVRVUvcXl3Q0d2eWh6UnBhSy82QmNBQWJPalFyeFNpdXQ0c0ZxYWdC?=
 =?utf-8?B?SzRYRk41UXpJblFOYTM2bnlkR0xYbHFaUzRTRzkvS0U4VVE5OTd1NUhUUkZB?=
 =?utf-8?B?cDJGSE9YdE5EUXVrdWQwazJhRk1UMitKbXpGbFpISUUydjZUeWpuVCtzZG5R?=
 =?utf-8?B?bDF0eXdxcDJaQkhDM0pDdzNVUnlxRnMxKzg2VElXeEtPajBvZjM3UEJwdTJw?=
 =?utf-8?B?c3Q4RW8zanNpY0pyYWY3TDZacVJYVjhUQmE0SUJpTlI0aUFBNytDT2o5MVdF?=
 =?utf-8?B?TE1IekFQT1VRODZuZGovMTBSZmE0WXNFWTNpZkt4eFJSTXRpK1NaOGVTcnlq?=
 =?utf-8?Q?MYYLdM/l0WFf+ekiJB7lXsXUd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec2e5ad-a775-4812-88a5-08dc4ec8f09d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 01:46:51.7932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3HbE4L08NvP9+KaCfX//V0Ruki59InTKGcwCL2KqU9ov0seDOYLL8AytPMGvZXsdHs7OEO2pU9sex7T0SB5wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8496
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

From: Peng Fan <peng.fan@nxp.com>

Convert i.MX8MN-EVK and i.MX8MN-DDR4-EVK to OF_UPSTREAM

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile             |   2 -
 arch/arm/dts/imx8mn-ddr4-evk.dts  | 160 --------------------------------------
 arch/arm/dts/imx8mn-evk.dts       | 128 ------------------------------
 arch/arm/mach-imx/imx8m/Kconfig   |   2 +
 configs/imx8mn_ddr4_evk_defconfig |   2 +-
 configs/imx8mn_evk_defconfig      |   2 +-
 6 files changed, 4 insertions(+), 292 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index b7992491389..56623d01240 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1085,9 +1085,7 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mm-verdin-wifi-dev.dtb \
 	imx8mn-bsh-smm-s2.dtb \
 	imx8mn-bsh-smm-s2pro.dtb \
-	imx8mn-ddr4-evk.dtb \
 	imx8mq-cm.dtb \
-	imx8mn-evk.dtb \
 	imx8mn-var-som-symphony.dtb \
 	imx8mm-beacon-kit.dtb \
 	imx8mn-beacon-kit.dtb \
diff --git a/arch/arm/dts/imx8mn-ddr4-evk.dts b/arch/arm/dts/imx8mn-ddr4-evk.dts
deleted file mode 100644
index d8ce217c601..00000000000
--- a/arch/arm/dts/imx8mn-ddr4-evk.dts
+++ /dev/null
@@ -1,160 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2019 NXP
- */
-
-/dts-v1/;
-
-#include "imx8mn.dtsi"
-#include "imx8mn-evk.dtsi"
-
-/ {
-	model = "NXP i.MX8MNano DDR4 EVK board";
-	compatible = "fsl,imx8mn-ddr4-evk", "fsl,imx8mn";
-};
-
-&A53_0 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_1 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_2 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_3 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&ddrc {
-	operating-points-v2 = <&ddrc_opp_table>;
-
-	ddrc_opp_table: opp-table {
-		compatible = "operating-points-v2";
-
-		opp-25M {
-			opp-hz = /bits/ 64 <25000000>;
-		};
-
-		opp-100M {
-			opp-hz = /bits/ 64 <100000000>;
-		};
-
-		opp-600M {
-			opp-hz = /bits/ 64 <600000000>;
-		};
-	};
-};
-
-&i2c1 {
-	pmic@4b {
-		compatible = "rohm,bd71847";
-		reg = <0x4b>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-		rohm,reset-snvs-powered;
-
-		#clock-cells = <0>;
-		clocks = <&osc_32k 0>;
-		clock-output-names = "clk-32k-out";
-
-		regulators {
-			buck1_reg: BUCK1 {
-				regulator-name = "buck1";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <1250>;
-			};
-
-			buck2_reg: BUCK2 {
-				regulator-name = "buck2";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <1250>;
-			};
-
-			buck3_reg: BUCK3 {
-				// BUCK5 in datasheet
-				regulator-name = "buck3";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1350000>;
-			};
-
-			buck4_reg: BUCK4 {
-				// BUCK6 in datasheet
-				regulator-name = "buck4";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck5_reg: BUCK5 {
-				// BUCK7 in datasheet
-				regulator-name = "buck5";
-				regulator-min-microvolt = <1605000>;
-				regulator-max-microvolt = <1995000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6_reg: BUCK6 {
-				// BUCK8 in datasheet
-				regulator-name = "buck6";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1_reg: LDO1 {
-				regulator-name = "ldo1";
-				regulator-min-microvolt = <1600000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo2_reg: LDO2 {
-				regulator-name = "ldo2";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <900000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo3_reg: LDO3 {
-				regulator-name = "ldo3";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4_reg: LDO4 {
-				regulator-name = "ldo4";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo6_reg: LDO6 {
-				regulator-name = "ldo6";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-};
diff --git a/arch/arm/dts/imx8mn-evk.dts b/arch/arm/dts/imx8mn-evk.dts
deleted file mode 100644
index 4eb467df5ba..00000000000
--- a/arch/arm/dts/imx8mn-evk.dts
+++ /dev/null
@@ -1,128 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2019 NXP
- */
-
-/dts-v1/;
-
-#include "imx8mn.dtsi"
-#include "imx8mn-evk.dtsi"
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	model = "NXP i.MX8MNano EVK board";
-	compatible = "fsl,imx8mn-evk", "fsl,imx8mn";
-};
-
-&A53_0 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_1 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_2 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_3 {
-	cpu-supply = <&buck2>;
-};
-
-&i2c1 {
-	pmic: pmic@25 {
-		compatible = "nxp,pca9450b";
-		reg = <0x25>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-
-		regulators {
-			buck1: BUCK1{
-				regulator-name = "VDD_SOC";
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <950000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck2: BUCK2 {
-				regulator-name = "VDD_ARM_0V9";
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-				nxp,dvs-run-voltage = <950000>;
-				nxp,dvs-standby-voltage = <850000>;
-			};
-
-			buck4: BUCK4{
-				regulator-name = "VDD_3V3";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck5: BUCK5{
-				regulator-name = "VDD_1V8";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6: BUCK6 {
-				regulator-name = "NVCC_DRAM_1V1";
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1: LDO1 {
-				regulator-name = "NVCC_SNVS_1V8";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo2: LDO2 {
-				regulator-name = "VDD_SNVS_0V8";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo3: LDO3 {
-				regulator-name = "VDDA_1V8";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4: LDO4 {
-				regulator-name = "VDD_PHY_1V2";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo5: LDO5 {
-				regulator-name = "NVCC_SD2";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index dd139c1b223..cb8afce241d 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -151,6 +151,7 @@ config TARGET_IMX8MN_EVK
 	select IMX8M_LPDDR4
 	select FSL_CAAM
 	select SPL_CRYPTO if SPL
+	imply OF_UPSTREAM
 
 config TARGET_IMX8MN_DDR4_EVK
 	bool "imx8mn DDR4 EVK board"
@@ -159,6 +160,7 @@ config TARGET_IMX8MN_DDR4_EVK
 	select IMX8M_DDR4
 	select FSL_CAAM
 	select SPL_CRYPTO if SPL
+	imply OF_UPSTREAM
 
 config TARGET_IMX8MN_VENICE
 	bool "Support Gateworks Venice iMX8M Nano module"
diff --git a/configs/imx8mn_ddr4_evk_defconfig b/configs/imx8mn_ddr4_evk_defconfig
index 743dea5c6c1..56b88808ebd 100644
--- a/configs/imx8mn_ddr4_evk_defconfig
+++ b/configs/imx8mn_ddr4_evk_defconfig
@@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mn-ddr4-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mn-ddr4-evk"
 CONFIG_SPL_TEXT_BASE=0x912000
 CONFIG_TARGET_IMX8MN_DDR4_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288
diff --git a/configs/imx8mn_evk_defconfig b/configs/imx8mn_evk_defconfig
index 5098fe527d8..91b7586a657 100644
--- a/configs/imx8mn_evk_defconfig
+++ b/configs/imx8mn_evk_defconfig
@@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mn-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mn-evk"
 CONFIG_SPL_TEXT_BASE=0x912000
 CONFIG_TARGET_IMX8MN_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288

-- 
2.35.3

