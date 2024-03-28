Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292E3C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 23:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69F90880DE;
	Thu, 28 Mar 2024 00:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Mq4jLB7G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DE488808F; Thu, 28 Mar 2024 00:47:31 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10C2988060
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtSxkSPKS8qQ6h/sd7hTwm6HWkqU9mFzjE0iSJS8vxJ2j90jHps0S0r2S/rW9rS+q3ClPLNm3S23N/hmvoihQLKtWSG6OHOoSssqswjc9Cog2XD3VteHmrkBqa2KMVe3OsyfkePQFfLLLGBKugxo/SGyUTDWjpGj785AUVrogNvefOz7cFnYsah+qNy/+1lha7vK3+peFFtttk2fFsm1LO5NxwSC0SSB++4/mSw3FSnJIh+giSuDMVA2yoZDj9TGBlsxLF7xXTZfB5Uo+e9bGOBF50pqALEMU54BsDukOAt5ueV2SDQgXjfCCwY2rfEcnFO/iYJT8i/vsR1BIzrknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1w44/hooWgr83H7C5AEowgjveNFaO9Mdghmn0XVTi+M=;
 b=UsJ4964WZE7p4fVqJ1Spe5HdU4CxmkeL5UdbIftA7hHoh06ZZ00j1t0l7YGoDXjELLXfo59DjkUkYpGLBPF97xELlCF0194+zfS/AlY1/FcEeTX0n4FNDyCBhIE39yk7de+93MgQFzDFFyYEkqo1+eTvQni16DJF1NON8Lmcwu97MId2YZu1IuALZV/Z8KDf9QBlNwzAXujbyVGXHkbXe8vC5NvJjwE0eUGEgQfcWMJQKWFabQVsKq0MHMIQKwDJn4qnBO19TRPsK0eYnHu8dXGKXv3aqrW6SLHz0GWmy2CQt1GjU2dKmlUoF+YbhwaYHj4TXeVH+HziHKOxjleXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w44/hooWgr83H7C5AEowgjveNFaO9Mdghmn0XVTi+M=;
 b=Mq4jLB7G4YF/I5Pxd5WhPACtBGVllvAylw9J4hcnRpeuHxQxCre8t9H7/B7f1Ib11R1Ckxz2d4/6xEN2ZKtEvwbg+ohAdtlcvWQNSeZkoIM0vRUpyR2XV/dip2W+DDsnYwj3ff7USJNHcbGQKB7sXIt/1s88wVVDCPLuqTTP5ws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB9999.eurprd04.prod.outlook.com (2603:10a6:20b:67f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 27 Mar
 2024 23:47:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 23:47:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 08:46:51 +0800
Subject: [PATCH v2 5/6] dt-bindings: imx93: sync clock header
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx93-of-v2-5-909f5d37da87@nxp.com>
References: <20240328-imx93-of-v2-0-909f5d37da87@nxp.com>
In-Reply-To: <20240328-imx93-of-v2-0-909f5d37da87@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS5PR04MB9999:EE_
X-MS-Office365-Filtering-Correlation-Id: abc3d792-b3c9-4f76-17a1-08dc4eb8424d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lHeMRj18nqIFq0Ejyaaf8mfijWqaoVjgPWbOYHqynV5YWcnxS5em3LzgAdEPB6h6NV4zPV67q3MNpuEotP5X/ZtdPRf19EaWNWk0qpwQRZhDhcfToxmV9D1IcXEr8kKFU4SM34Qyocw4FEW/n6AM5MYX4Jyx1P/Mg5jOCCo0HbCfrZmRk7WhIjlyxIUIECEmykv13R2HtBuDS1EP5L74MxEm9rIIO7OfvscWqD1OAnfBZDIiQG5P1TlrWnOukFfFsusJB/lITBNq9TIM130wYV6KbEt0WoU4xaol6ry7CH1SHO6d39SrpRk+nNkgH3tTI3xo8WygSBge6jr/jP73K40e4LNj8/Mvyys7KNDWkKaqrSTzQ5mNzQY6eskilhIWxD5e3NnWaaeTSKH5p8ILwHKbw59Za1HW/q/TSzHSXR3AjJ1U2LAE+07YWyFtsVEnEfOW/EymcljWT9NezpP5qPyNZRkYX6yGZ/IgSYvQaMQqI5QVhSyasQpJez8+weOGJKvfnUmzglSW8iu9fIomvPTPhiMK4eMZ2aU5qB8AqYNo2RzINLMntZzheaJ7sb6GE4x4YkJjktZcmVXfY0t0YYoTXRAH+BwQeARLw1eWhkjV62k2LYFGAeDG0n5Cca4T4FMHLhbUP1lOU8/xHDbx+CAzwoZnkKBq9/TnxxHRiTEwwF+iWUd/rYpKhIyq1SlVChZeVMqdXUpQtK0L+abxApgbzK7rNDp2W3eCy20sbcc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3FZOU9qVFlhV0tXUGs2NlN2WW9UYTBsSWdNUDcrNTVHb1hQNW4zM0ZOQThl?=
 =?utf-8?B?MGsxVVgxK0dwa0pWOGtTWXk2bjZPdEtRWkxVb3dWSjFFbVd5MWh5NndRRE9L?=
 =?utf-8?B?ZSt3clFHVHRSMW1WRnRrS3JNRWIyaGkxcFdlQjY2emkybENyRVhDTlRRUk5J?=
 =?utf-8?B?cWxlMzdVZWZmMHQrWjhkb3RxYVVzc3RuamdjbW1rNFRXYnl1RVVWSVNtTElU?=
 =?utf-8?B?SlhORkdabFlUOU5Fd3Q4M1NkMFA4a0pBSmdLcWJBRTJOVFk5Q09CYXR5eXlq?=
 =?utf-8?B?MW1MSERzdEs1cWZ0TXdwWDZWbSt0eWhoRnVlVDdua2NpcDMvWFBaSEw1Rm5s?=
 =?utf-8?B?RmduR0w1VHVHSzRiWnp0c3ZpQXdrdkY4cUNQdjlGSFlvZExiV08xRlYwbWE4?=
 =?utf-8?B?dXFMZklTeGU5ZzZiRVByZEFjak5adXpEUjJqbVppdDhvT0Zmb0lWQk1yczN3?=
 =?utf-8?B?T25lQ0crVkw3TUtnSWx2eHR4MjV4N1BJT016L09yTXBjQ2hKWFJPMHVuYTNF?=
 =?utf-8?B?VE1jYTdRVnlBM2RuY00zOXNkbG91dUJyWlJUTjJWdVRDUXBROFE0Zlp4NXRq?=
 =?utf-8?B?MnlJWjhnOEpjYjgyTnNvRTJySHZaODhJVis5QVYzWThvbmlmYnRya0g0aE90?=
 =?utf-8?B?TWlLVmtHbXpsZXZFZ1YwbzJwRHVhdVV2VXRJT1BDTENqQnVobm1JOWpMbktS?=
 =?utf-8?B?R3hSV1JzcnQzRWhWdzl3Tmd3cWhqcGxGVHNYcjdqcnNYeEJ3YnRkZ05lTjdL?=
 =?utf-8?B?OWx1cm5ZcGZ4OXFMb0hzT0d1N25ucEpFakpFMkF1dmxESHBzaXFabEFWT0x5?=
 =?utf-8?B?cDFJU2E0MjgxcDZEUGNYM1JrY0NpSGhybEx5VE9YeWN6cGE1dzEyTFlqdDlP?=
 =?utf-8?B?cmJodS9UTHpIV2NkTGFwcGJrRzJLNlNZUUk4MndhN1lWdUJtelU1RlFjMVdJ?=
 =?utf-8?B?U2Z2TUVOU1ZaOU53bjY1Q0thaEpNczVBbUc3RlppSyt5eTRTN24reHo5UFJI?=
 =?utf-8?B?NUVNZUJaTkViSE1YS3dNcG9ZNDdRMEpmbmZicnlDL2tPeUx6SDVyYkZ5dXpW?=
 =?utf-8?B?bUFmaXI4TXJIbGlkV3hvRVpnRDYzd0VVdXRTUElYcUszTG9oSFA0enI0MW42?=
 =?utf-8?B?ZVE0TXdVSVpIQmVWc3VoTUV5dW9ZSjAwcjlnUmpPZU0vZ3MweExWaWdJTHVr?=
 =?utf-8?B?dDFrMktnU1dnSWljNWdXc2JLcFAzK3prMUFVSytoZkYrU3Y4UWhsQmlTVVVn?=
 =?utf-8?B?OXE2ckVRMzdMbVNQS1g3VDl2SitXamNoamYyMzFRa2NIWUVISVhHbjh4K20x?=
 =?utf-8?B?eGVKZXpvOTRRSTBsZFZZcmR4ZkxmZjZoWC9XSVF0dFFxU3g2UHJVaEkrbExF?=
 =?utf-8?B?T0h4Z1FUOFhjZUtuUWdKNnJlNnpVZWdKM0VVVEpHT3orN09SdnR4R0g0Y2xB?=
 =?utf-8?B?U2VSUkU3aXZYcUVOYTRaa0FYTXpsbTVqV0ozT0N3VEsxdGYvZHlHcGtKQ0pN?=
 =?utf-8?B?dzRCaWIzSVdEb0lOd3pFaEFHdVdBb0FKUWx1eUFKdWhERjNDaTFGY29tdlZE?=
 =?utf-8?B?czRTM2hYNFVKRDM0bFVuN0ZSNGlBdStiM0QzQXp2TVlDQnRoV0NzaEgxc2hQ?=
 =?utf-8?B?cU9rL3VhK2lJYnNnazdVSTdOWS9sVWM5M2NYUGM1MmdGalVRUFo5TlVOZmRw?=
 =?utf-8?B?OHJqUDM2anZPRnpwYWM0cjM3VjVFeE52NG83V2JEUisxeVJnMy9uM1BYUWFx?=
 =?utf-8?B?ekZ1S01kbFMvWlJoSUNpa01IcFdBWis0TG51dzhFWGV2MG5XZFRudkJOajA1?=
 =?utf-8?B?azZKRytoTkJYU1hKTGFLYUJ1OTRQWkpjVmlXNWVlaDJKTGF5NVlDMGNIR1Z5?=
 =?utf-8?B?bllvdGhPYnp1MEFiOWNMZ2YzeVRRR05MQ1Rqc2NTYktRMHYzK3FTNCtVclpn?=
 =?utf-8?B?YXNHSTE4M2JpYnBWbXhJdStqbkMyNlJ3SGc0bXg5RjR0d0xjbW1jUk9PMEdP?=
 =?utf-8?B?Vk5SN3N2TDVKTFFQS3ZZQUxGdytZM3ZxdHJKMFd3c1lvNmFQQldBY3owQ2l1?=
 =?utf-8?B?SmpUTGdvbnYvTUNGWmJFVTlDOWxrdlhJdEJJR0V5M21DUmJFd2VWM0hTK0Na?=
 =?utf-8?Q?sdBrNYkZvr3H9luwGS0NLrxYq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc3d792-b3c9-4f76-17a1-08dc4eb8424d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 23:47:27.3875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2uTm7DwxL26udSJV8NkZlEN+VF5E3qNRgeTG1hrk7fCh1dwP6kvAOaAflxEu8a5pJqLTtq1Hc4GabEbCVFNvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9999
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

Sync clock header with kernel 6.8

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx8mp-evk.dts             | 684 --------------------------------
 include/dt-bindings/clock/imx93-clock.h |   3 +-
 2 files changed, 2 insertions(+), 685 deletions(-)

diff --git a/arch/arm/dts/imx8mp-evk.dts b/arch/arm/dts/imx8mp-evk.dts
deleted file mode 100644
index 9f1469db554..00000000000
--- a/arch/arm/dts/imx8mp-evk.dts
+++ /dev/null
@@ -1,684 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2019 NXP
- */
-
-/dts-v1/;
-
-#include <dt-bindings/phy/phy-imx8-pcie.h>
-#include "imx8mp.dtsi"
-
-/ {
-	model = "NXP i.MX8MPlus EVK board";
-	compatible = "fsl,imx8mp-evk", "fsl,imx8mp";
-
-	chosen {
-		stdout-path = &uart2;
-	};
-
-	gpio-leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_led>;
-
-		status {
-			label = "yellow:status";
-			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x0 0x40000000 0 0xc0000000>,
-		      <0x1 0x00000000 0 0xc0000000>;
-	};
-
-	pcie0_refclk: pcie0-refclk {
-		compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <100000000>;
-	};
-
-	reg_can1_stby: regulator-can1-stby {
-		compatible = "regulator-fixed";
-		regulator-name = "can1-stby";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_flexcan1_reg>;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio5 5 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_can2_stby: regulator-can2-stby {
-		compatible = "regulator-fixed";
-		regulator-name = "can2-stby";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_flexcan2_reg>;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_pcie0: regulator-pcie {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pcie0_reg>;
-		regulator-name = "MPCIE_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 6 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-};
-
-&A53_0 {
-	cpu-supply = <&reg_arm>;
-};
-
-&A53_1 {
-	cpu-supply = <&reg_arm>;
-};
-
-&A53_2 {
-	cpu-supply = <&reg_arm>;
-};
-
-&A53_3 {
-	cpu-supply = <&reg_arm>;
-};
-
-&eqos {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_eqos>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy0>;
-	snps,force_thresh_dma_mode;
-	snps,mtl-tx-config = <&mtl_tx_setup>;
-	snps,mtl-rx-config = <&mtl_rx_setup>;
-	status = "okay";
-
-	mdio {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@1 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <1>;
-			eee-broken-1000t;
-			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <80000>;
-			realtek,clkout-disable;
-		};
-	};
-
-	mtl_tx_setup: tx-queues-config {
-		snps,tx-queues-to-use = <5>;
-		snps,tx-sched-sp;
-
-		queue0 {
-			snps,dcb-algorithm;
-			snps,priority = <0x1>;
-		};
-
-		queue1 {
-			snps,dcb-algorithm;
-			snps,priority = <0x2>;
-		};
-
-		queue2 {
-			snps,dcb-algorithm;
-			snps,priority = <0x4>;
-		};
-
-		queue3 {
-			snps,dcb-algorithm;
-			snps,priority = <0x8>;
-		};
-
-		queue4 {
-			snps,dcb-algorithm;
-			snps,priority = <0xf0>;
-		};
-	};
-
-	mtl_rx_setup: rx-queues-config {
-		snps,rx-queues-to-use = <5>;
-		snps,rx-sched-sp;
-
-		queue0 {
-			snps,dcb-algorithm;
-			snps,priority = <0x1>;
-			snps,map-to-dma-channel = <0>;
-		};
-
-		queue1 {
-			snps,dcb-algorithm;
-			snps,priority = <0x2>;
-			snps,map-to-dma-channel = <1>;
-		};
-
-		queue2 {
-			snps,dcb-algorithm;
-			snps,priority = <0x4>;
-			snps,map-to-dma-channel = <2>;
-		};
-
-		queue3 {
-			snps,dcb-algorithm;
-			snps,priority = <0x8>;
-			snps,map-to-dma-channel = <3>;
-		};
-
-		queue4 {
-			snps,dcb-algorithm;
-			snps,priority = <0xf0>;
-			snps,map-to-dma-channel = <4>;
-		};
-	};
-};
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy1>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy1: ethernet-phy@1 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <1>;
-			eee-broken-1000t;
-			reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <80000>;
-			realtek,clkout-disable;
-		};
-	};
-};
-
-&flexcan1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan1>;
-	xceiver-supply = <&reg_can1_stby>;
-	status = "okay";
-};
-
-&flexcan2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan2>;
-	xceiver-supply = <&reg_can2_stby>;
-	status = "disabled";/* can2 pin conflict with pdm */
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	pmic@25 {
-		compatible = "nxp,pca9450c";
-		reg = <0x25>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-
-		regulators {
-			BUCK1 {
-				regulator-name = "BUCK1";
-				regulator-min-microvolt = <720000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			reg_arm: BUCK2 {
-				regulator-name = "BUCK2";
-				regulator-min-microvolt = <720000>;
-				regulator-max-microvolt = <1025000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-				nxp,dvs-run-voltage = <950000>;
-				nxp,dvs-standby-voltage = <850000>;
-			};
-
-			BUCK4 {
-				regulator-name = "BUCK4";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3600000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			BUCK5 {
-				regulator-name = "BUCK5";
-				regulator-min-microvolt = <1650000>;
-				regulator-max-microvolt = <1950000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			BUCK6 {
-				regulator-name = "BUCK6";
-				regulator-min-microvolt = <1045000>;
-				regulator-max-microvolt = <1155000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			LDO1 {
-				regulator-name = "LDO1";
-				regulator-min-microvolt = <1650000>;
-				regulator-max-microvolt = <1950000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			LDO3 {
-				regulator-name = "LDO3";
-				regulator-min-microvolt = <1710000>;
-				regulator-max-microvolt = <1890000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			LDO5 {
-				regulator-name = "LDO5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-};
-
-&i2c3 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	status = "okay";
-
-	pca6416: gpio@20 {
-		compatible = "ti,tca6416";
-		reg = <0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pca6416_int>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
-		gpio-line-names = "EXT_PWREN1",
-			"EXT_PWREN2",
-			"CAN1/I2C5_SEL",
-			"PDM/CAN2_SEL",
-			"FAN_EN",
-			"PWR_MEAS_IO1",
-			"PWR_MEAS_IO2",
-			"EXP_P0_7",
-			"EXP_P1_0",
-			"EXP_P1_1",
-			"EXP_P1_2",
-			"EXP_P1_3",
-			"EXP_P1_4",
-			"EXP_P1_5",
-			"EXP_P1_6",
-			"EXP_P1_7";
-	};
-};
-
-/* I2C on expansion connector J22. */
-&i2c5 {
-	clock-frequency = <100000>; /* Lower clock speed for external bus. */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c5>;
-	status = "disabled"; /* can1 pins conflict with i2c5 */
-
-	/* GPIO 2 of PCA6416 is used to switch between CAN1 and I2C5 functions:
-	 *     LOW:  CAN1 (default, pull-down)
-	 *     HIGH: I2C5
-	 * You need to set it to high to enable I2C5 (for example, add gpio-hog
-	 * in pca6416 node).
-	 */
-};
-
-&pcie_phy {
-	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
-	clocks = <&pcie0_refclk>;
-	clock-names = "ref";
-	status = "okay";
-};
-
-&pcie {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pcie0>;
-	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
-	clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
-		 <&clk IMX8MP_CLK_PCIE_ROOT>,
-		 <&clk IMX8MP_CLK_HSIO_AXI>;
-	clock-names = "pcie", "pcie_aux", "pcie_bus";
-	assigned-clocks = <&clk IMX8MP_CLK_PCIE_AUX>;
-	assigned-clock-rates = <10000000>;
-	assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_50M>;
-	vpcie-supply = <&reg_pcie0>;
-	status = "okay";
-};
-
-&snvs_pwrkey {
-	status = "okay";
-};
-
-&uart2 {
-	/* console */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&usb3_phy1 {
-	status = "okay";
-};
-
-&usb3_1 {
-	status = "okay";
-};
-
-&usb_dwc3_1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usb1_vbus>;
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usdhc2 {
-	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
-	assigned-clock-rates = <400000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	bus-width = <4>;
-	status = "okay";
-};
-
-&usdhc3 {
-	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
-	assigned-clock-rates = <400000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
-
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	fsl,ext-reset-output;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_eqos: eqosgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC				0x2
-			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO				0x2
-			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0			0x90
-			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1			0x90
-			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2			0x90
-			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3			0x90
-			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x90
-			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL			0x90
-			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0			0x16
-			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1			0x16
-			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2			0x16
-			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3			0x16
-			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL			0x16
-			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x16
-			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22				0x10
-		>;
-	};
-
-	pinctrl_fec: fecgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x2
-			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x2
-			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x90
-			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x90
-			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2		0x90
-			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3		0x90
-			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x90
-			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x90
-			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x16
-			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x16
-			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2		0x16
-			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3		0x16
-			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x16
-			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x16
-			MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02		0x10
-		>;
-	};
-
-	pinctrl_flexcan1: flexcan1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SPDIF_RX__CAN1_RX          0x154
-			MX8MP_IOMUXC_SPDIF_TX__CAN1_TX          0x154
-		>;
-	};
-
-	pinctrl_flexcan2: flexcan2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI5_MCLK__CAN2_RX         0x154
-			MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX         0x154
-		>;
-	};
-
-	pinctrl_flexcan1_reg: flexcan1reggrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05  0x154   /* CAN1_STBY */
-		>;
-	};
-
-	pinctrl_flexcan2_reg: flexcan2reggrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
-		>;
-	};
-
-	pinctrl_gpio_led: gpioledgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c2
-			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c2
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c2
-			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c2
-		>;
-	};
-
-	pinctrl_i2c5: i2c5grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SPDIF_RX__I2C5_SDA         0x400001c2
-			MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL         0x400001c2
-		>;
-	};
-
-	pinctrl_pcie0: pcie0grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B	0x61 /* open drain, pull up */
-			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07	0x41
-		>;
-	};
-
-	pinctrl_pcie0_reg: pcie0reggrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x41
-		>;
-	};
-
-	pinctrl_pmic: pmicgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03	0x000001c0
-		>;
-	};
-
-	pinctrl_pca6416_int: pca6416_int_grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x146 /* Input pull-up. */
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x140
-			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x140
-		>;
-	};
-
-	pinctrl_usb1_vbus: usb1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR	0x10
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d0
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x194
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d4
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc0
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x196
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d6
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d6
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d6
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d6
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d6
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc0
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12	0x1c4
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d6
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d6
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d6
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d6
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d6
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d6
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d6
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d6
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d6
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B	0x166
-		>;
-	};
-};
diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 35a1f62053a..787c9e74dc9 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -203,6 +203,7 @@
 #define IMX93_CLK_ARM_PLL		198
 #define IMX93_CLK_A55_SEL		199
 #define IMX93_CLK_A55_CORE		200
-#define IMX93_CLK_END			201
+#define IMX93_CLK_PDM_IPG		201
+#define IMX93_CLK_END			202
 
 #endif

-- 
2.35.3

