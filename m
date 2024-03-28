Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA17C47DD9
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 01:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D4C48808A;
	Thu, 28 Mar 2024 02:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lJPYhmIx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1672A880FA; Thu, 28 Mar 2024 02:27:09 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13BC688076
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 02:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMloDt0W7LQD6kZkmPS7GYP87QW3s8tnV+qZNN7Tn0xE60/+4xM1K3w/t3mArlhZ1PSJ0zq+huDvgutg7ut2uYWvtSG/O63N5OlMAXy8ZSbRWlkJim2UO0Zkpf616GeHdm4uqfqqH5WenUH8ZKqTE5RsKFHyE1iQ3FXS4GWSDffpsTRBm4C8Dfui5Norhr/PPkvRyeQ4JyzKTqmrr1h0vcX+u4EKnuNnfiovf9w/w65wQKqNzOKzBdAn1XcVCei708qJiplwEsoVzwh7C6NJ0nWW/Dyqbkx0xEVbXW66Xyj/mPbFTff7ytoEXvB/NuZnVfoa6G0UaFi61Rtm150/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8uywVCWzSDBR8KbSm+IX5BChg76x7ThD6Vi4g8Nfm0=;
 b=W/AoNwQYxyqfTyZppiQ32TjOBVvAjH6qPSWISOj85atr6IGnOQJZ86B59VURj0C5Ck555S2701XR2hQ5eJaoY//40WX+jeQQHilPQd27IvBAUrVJGNqxGiaQP75qK93Qy7hc+JMwEooFgTG1mxmUAw39PyY0iY2KiHbl5FCmOdIdAaj4SPHcQFgOfZsESKLcWn6LEqXCejGsh7jfSLqKjAUTASnB3wYKhJm1bJ0EWcy4q/x5hItr1fPEXFA+Z9SujaXTtrNIC/u+Uxjz7vg/EO8coeDeGIW8FUVJuWuk1JNRtrgaG9kFabfFqhkdEQr7DQBMXTDDncdmyDCP0WxZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8uywVCWzSDBR8KbSm+IX5BChg76x7ThD6Vi4g8Nfm0=;
 b=lJPYhmIxEL7MWUpkfvERf4jFJZmm62Uu+bfG/IeMDIvl0XBcGMrGE2++RQUB28uFkYdlQkcUjp8wBdPHy1E8fWNDN8vGEixqe86iqQiGJLHTP4wV9r+Du2djBrU6mGIi2glJn71hciXuq/Fbk0nqsSf8cgVEXQXe3caZmGKCzeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8763.eurprd04.prod.outlook.com (2603:10a6:20b:40a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Thu, 28 Mar
 2024 01:27:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 01:27:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 10:26:36 +0800
Subject: [PATCH 3/4] imx: imx8mn-evk: convert to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx8m-v1-3-2be5e6657a88@nxp.com>
References: <20240328-imx8m-v1-0-2be5e6657a88@nxp.com>
In-Reply-To: <20240328-imx8m-v1-0-2be5e6657a88@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbb3767-0a9c-429b-eb54-08dc4ec62d96
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LgPLr32kqDVKIlZegWnGKZsmfD0XDC7IHkw28w+5a2O9retPS/+IzSLW+OypgdSkKbVTnK2RpcaE4YPArF1diVa5EV9YXRJKeaPIbLoADJ76FbxgGvLmHcvJRsDTgMBMCg9JXl1elWpn1awS01K3pcTZAzMByd22xlYN5mO8ZNEQCH8GCVtXwnOC/Abj2RC0G7101xuiP7eYF1rjTCLLI7gg2D9Cku+bg1VnxlVq2a1C4RWGKAkC2ngkcFHnna8sfyyW+f+dRab89tWyQhx9EMHluy4sO0P470Q2qHKL/fRQvrZvM8JzRHwqKcqQO5qrkjGSM/7vtsj9xSpFrOIX8/OKuF4P7TPe5FKN0GBcCsvTibHxgu3LnY7iKzSdf80iruarngPPauKXUzXNovclyWqcfTvPZOKscF+FAdSm9nE/XbFHHo9KwFwqRyb9YQRuMA8NynZ8kZChOncrX8lXvivwE9jZSpwOSLxuE8eAxmddjQ3QoQXhV2pndJgX7NIqc6qwFBr7RHJF/1OSfgQJ3HdjznA/T4JPlQ7UJg9KFET77eD+rKtdBHXdFokIrFcNBMkRGaqpHxP0do2PqG1dxu7FY0kfQuEY/s4brB7Hagak112O4wBvxQtIOHli92BDfsx1oRO5nB4NEz4BX+aebFShB4dmv3rFr/Gpo9cY2ZyJeWPTZX9CAFlkwST0G0UCbgo0qEi+BCie/oELOfl0NAJKejxGauBBrBbDgHIn6d0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnZER0ZleVpvN3puOXo2U1dUOFM2eHNzWXF0SmhlblhjSE16YW5kTkN0ZVpi?=
 =?utf-8?B?cTlaSWtaekt5RWRhaWx2RzhyejZhYkpmV01hR245WVFFSjA5T3JpNWxSdjB2?=
 =?utf-8?B?NElYQWg3c0JHL1pZL1E4OUR3NlRkQVJFUkFFMXMwejJVZldjZFAxSzVVT2pV?=
 =?utf-8?B?ckQwbENxUTh2WW5RVjgwUXpwN2pMMFFSQTJNajhNdlZBZkZHc1pWNDQvWjBB?=
 =?utf-8?B?NWo1b3NKZFdtZk5sY1ozejF5dEYwTy9iTFNVbUhTV1hINTBlWmhiNUJmWDd6?=
 =?utf-8?B?YXB6ZnZBUG1NYlEyRTUwcFkzZlN3SzJRNkFoNE9JWjdIUC85YWtFZDNkcTlM?=
 =?utf-8?B?ZUtBMkNRcmFqU1hidEY5bGJPSHFhMFdzd2RkZjZndFpKNU9KSEdDaVdZY1Vj?=
 =?utf-8?B?bXNpZ21FT0RBNGMwRzZaNy9FSDk4UVRxckRqc1dYUC9Gb2NOdjBTOHpQbXVV?=
 =?utf-8?B?ZVRvT1ZuUHVnNk9xUmVXMjNiYXNkYzk5RTV4VmF2c3grSEhuYUswZVRWSlJT?=
 =?utf-8?B?Q3Y2YlpueEg5ZXpiRHVBdFRqQ0V2eEZLTEEyZUkrRDNreWFvWkI1UVpETTNn?=
 =?utf-8?B?eHF5emNRaFN4SHlZVXo4elJGTVoyY0FTaWVjQUFRWFBadTJHSjJ6NnlaOUhS?=
 =?utf-8?B?Vm1nWTJOVkt3OEFxdTRkMS84THRlQW05a2lBelBKR25PMlJYa28yVHlKQ01F?=
 =?utf-8?B?TklYV2JvNDBhMXpKUlhsMmF6RUE2c0RPcUVIV0dmNG5vK3Z0Z1JiUGNVTy9z?=
 =?utf-8?B?V05YZ0NmcWpYNnU2T1ZBcWxqckl3TnZGL21DZm0veDkwK2dha1ozQ2xKaFdO?=
 =?utf-8?B?aXcyNnlJMVFjYnIxRmpSdTQ4UDVSMUhQVWRNV0hCb1BRNXN5WlNPZjZEWGxo?=
 =?utf-8?B?am9seVNLTk41OWhabDV2Um4yR1hVUWllSmx1QzgxQ1premtQTVV4VEpZd2RC?=
 =?utf-8?B?RDQ4ZEFqcEtjQXJFbU12dTM5QXFOa3F6WFNPdU9HZW54cWZGbndqN3RLcnN6?=
 =?utf-8?B?Z1BNRGZBeS9sOFJkN1BJRlIraXE5YTFrWGtIMmhMZ1pGSXhBWHJBZlNJa1d6?=
 =?utf-8?B?M1lQaGlSb1dsK1FKUFZZdk9aSHUwNWkxMlpDbXZxQWxFNEllcUNIQWpFOTFj?=
 =?utf-8?B?aGZtMEFib1gzQzFmUE1rSXI3cWVnb2g0a3dwcXJKOHkxLzJrTGZoNUUxZ1or?=
 =?utf-8?B?YWcrdFAweFJTWTkramZzWW5rbTRZajNCRnd2dytEeS9pNFY1OTJ5NVBOcThr?=
 =?utf-8?B?ZEtyY2RHa1llUjBXcGh2WGkzT3ZSSWxsTVFJeXVQZG9NNnNuT3VnLzhKZXls?=
 =?utf-8?B?N3BUSVlabzRTL2Z6SUlqOHZwUllFMzlteW1qRDBvOWw0SW9iT3c5dmY1NkFu?=
 =?utf-8?B?RTlPSENLT2MyeWlBS0s0SFB2Y0NjaVdqZEIzK280TldXTzhLaXhFZE95b0Zm?=
 =?utf-8?B?OFFrY1BaK1VUc3hVZy82emFmQndVZHFpMFJVdHBocmlFMm5BOGU5UTB1Vm15?=
 =?utf-8?B?aVVHZklsUjZZUlhyY0VnS3hZeG5HS005eUc5Vm4ybkFGWEUvODdOYmo2Q21M?=
 =?utf-8?B?a0VTN0FBek50U3Q4UDB0SmN3NGdicGMzYWRwYmRhTkFoZkpiNVVvQ3BnM0FH?=
 =?utf-8?B?MkI4SjE1YjlJZUorL1dqb2pmRk9RMGFFTmRVRHltQ29QckZ6WnpBd3VIMkZt?=
 =?utf-8?B?Wk5OdnE3VFp4OUNKM2JiRFlkakNIRjA4eWpTaHhlelBtZzdiWitBc0gxb1Qy?=
 =?utf-8?B?Uy94bHBLY0FtYndnb01Nc3hvRDhRaTV1amY2L1gzMk1KZHZRVXBld1VLVE83?=
 =?utf-8?B?NkFiUFM1M0NUN3ZxcDBuc3d2SUVJSXBsSHQ0cGQzNWNXYVFpNjlDdUsyK2Mz?=
 =?utf-8?B?akdENm1sZEtqdjE2YzM4dmsvNXY5bWJqNDZCelNjNnc0Y2Z2OVQ0Z1dsd0hn?=
 =?utf-8?B?YnQ2OHlBQ3ZXa1RpOUtSUHdaOVVmcU1mNWZ6NXNGZjdMQUtaa1U5YWcxN0dn?=
 =?utf-8?B?bnZaS0VZOE92aklZQ3Q3cmZ0SU5nRHh3L1RwS2p6aTk5RmxVaXJkakJJNVQ5?=
 =?utf-8?B?bnBENXdVNVMwRnUyVXd0K3lwRHFEYmVkZkxER1BZNUFNSGt3MEV4LzNJckNa?=
 =?utf-8?Q?8Ij21F5y5T8EfTwW/O2nWJ88I?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbb3767-0a9c-429b-eb54-08dc4ec62d96
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 01:27:05.5885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzKcC/SC8f9HCTyX+NqeucIPXEz40kKxiUWza0cXQz4t9GnpXgIyNeUX3ebYXpqnADo2Iqt6UsxvEmpb9iwvoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8763
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
 arch/arm/dts/imx8mn-ddr4-evk.dts  | 160 --------------------------------------
 arch/arm/dts/imx8mn-evk.dts       | 128 ------------------------------
 arch/arm/mach-imx/imx8m/Kconfig   |   2 +
 configs/imx8mn_ddr4_evk_defconfig |   2 +-
 configs/imx8mn_evk_defconfig      |   2 +-
 5 files changed, 4 insertions(+), 290 deletions(-)

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

