Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B147EC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 01:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBE238810E;
	Thu, 28 Mar 2024 02:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MVP+JqSI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4435C87FD7; Thu, 28 Mar 2024 02:46:58 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D2A8880C0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 02:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvabmZ9FM/DmQsG+shgXdGskbrmsu9swCK7hfJ90Nrt5LomAlko8kVJ9P+Bo3cRPzndaJ+k9D5Z4ZE82j4RAgqZtzNf/i4oXJx17KVNgLVEu0pVW9dfKEu3qi9nay8taOKTNJSTj46tHW3Ps1KyYgNOgez8NOBbaAQlR80NE7sAfbxTfAIssBY+OpCruym10mKzmE1bmZrclGUIxVIgJKJaxj/fIWhvgL5xGXHB0YFfOIp5wKKPb2J1UOTxD64xu0rN5VoR3hV6h0eYQonK8lxhOviWn+Cbp7JXOGTsnQw5Gkwj0XH+tu5B/mVcHhqtJeewBl2TB7GCW7VcDI/pHUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtYc/IYvxf9Bck2lBPB3Azy5vHU2w/ehie0HWuefha4=;
 b=CRXjNlqHuZnrCl8krz0QLo3eh7FYpPPwRr7cMV2xhTVpmLWJ6SKWTcjHbLphIbxNTw1EmdUVcaCwZ8Ock54R19QAixmKrkJ/VwiZH1wX9yTG4Sz18BsHpda9ss2xPO/4BdWUfN8RaE/j4M0uPcykyyoJU8DWQ5wlqPnVJuyrps15HqPGs670IkoA3ZHgMifo+k0Pab6ic3fioqqIOAYMj+9hS0k4d1NfPt4RNY7fkgdJwZU0cI19NLI6ea1pBzaJUyt+1/XrP7/rn1thLK+SOC0e8uc0fvz86O9s9Iom5RzJjiEKPDUWgcmzo7vB1TI4rOb68Ju+NLf5y94fbIxVYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtYc/IYvxf9Bck2lBPB3Azy5vHU2w/ehie0HWuefha4=;
 b=MVP+JqSIn2WpG1S6Kb3kf5xxdzgwpwJCNZmFmt5dumweta89rNhgQrC3oLeoj/3Ss5FpJ/ToDNerc5TvjOgatKBd4X5xgX2XWSgIUtcwWfSVOlnLy+Qilqg8i2anCvcu3Na/oXfXIIRy0U1g3ArpVoJDq0klXJ+RhEgjphD5JZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8496.eurprd04.prod.outlook.com (2603:10a6:10:2c8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 01:46:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 01:46:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 10:45:11 +0800
Subject: [PATCH v2 4/4] imx: imx8mp_evk: convert to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx8m-v2-4-7656998cc8b0@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5b924e48-af16-42b3-888e-08dc4ec8f227
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ytguW1GDuPPBTBXPVAwaOBy+4P0YvoY1bAgJnBVCWqVSUBE26eb52427gNrgwn6EQuyOdu3kl7mpzSpF0QXaMaGNma4M+JsI9chw1rEfcNrAW+DgyJrxUQ6r8sFRZiK20KpZy2uKy6iv5TaJpZexBaxLK1tJJ5hyryki5C3hkW0cpeqET5JxD+fwjW5INcRU4yBmF8rx0MDpV3yqnOS7sbC6nmcLtUPwsJ8PydDPb1GcQfUrsDOw+5Gwvgfqrj1+L0PLDRjp8071eHtTlh5qFywpBweykMScOVBf8Ww9yM/Bxlhy+K7FTFfzBFbJ285uzl4MLh9fbTO1EDQFiXYYAvfiuVlCh8gNaI9BjtqhnGvBXWwdjfssQ8UkBpyy0Qcic0rvV77G5/vwPyb89M6a79sxJAbcvrOsgfeNbxxKxYFRxsb3JNE++uhHv51QPbFoylHdihhgH8tUqv6wQe08shPw48x8QYLMa/IZ1ZJlYEw7vfGW6coRU+dbK4TohHuKZ9rikkshsLCN5ExsCJUUjYEbp/aVqWYraFbtDYPUm4//r3Ceol3AIO8nlH56vsbFRVFWBCVNQgcJioa2RsZcbpK5VKw/4v/DEevysGhHkwHaKAFKeSDPL6lsQjIu/Ouso1R6lhCgHUCQWtDD8Qyb4AkqJqGgFel5NcNfucG/4K2esA8lrMlnw2/yk4t9oi9HwH6Q8Cd/AQR8U0IxqktRxkTia426G4WIgteWbmZkyDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXdwWnEyV0hpQWxxb0lSTjArZjlEN3lBTU9mdDVpNGRQQ3FUck9YbUtNbm14?=
 =?utf-8?B?ZDVyL0p0VnFBSkQ5L2tRVDdadndCQUdMeVlzOTl4YzRjeDdUcWlLaTErTkd0?=
 =?utf-8?B?ZUdpUUZ1ck1kM2M0SzlaRGZYenNacWNiSVprbHdwcTlNWDJWSXZleExhYUhE?=
 =?utf-8?B?MXlNUFFQeHpGYmg2QkF6NXFzT3pycFpGNGVkbFM5Uit5RVk2akVLOHNVOHJQ?=
 =?utf-8?B?TXJrZTBsd1k5akY0SFFBdXdGQUNsVDlWSWF4MXJwU0RrNzNjcmY5Wkw4NThJ?=
 =?utf-8?B?eGgrMVlCRHJsWnhzTHJPVlZWUkhML29DcysybVVHT2V3K3c1REJvS3gxSXVw?=
 =?utf-8?B?MHk4SWE2d0NiajMrMFptMnpyYnRyRDRoVnZiK21aeVFiT3Nucmk2cURteVh1?=
 =?utf-8?B?QkNpdk9ySGtsdUhXTVBEQnlkUGliL2I5QVdKNmxma3MyYWlhaEsvWGxWcldV?=
 =?utf-8?B?TzA5YSsyWm5Td2ZxdkZzbGRIWWRUMUUrcjBkNUNuZFY4eEtnU0JkdUFyMCtw?=
 =?utf-8?B?UU1IaW5wTGllLzJyQyttVklFQmsvaWx2WEVLUlJqV1Y5MVJRelNlODMweHRH?=
 =?utf-8?B?aDNoZUdRQm5TYlFvdVRSQU14WXBYTmNxQlEyM2lkMnBVY1VTSDhRNldBWVly?=
 =?utf-8?B?bVRPTjB0Q09FdzYzYjhtanRXY2tPQlhXMUJmT0VlNjhzaGZWelZrSG9nQS9J?=
 =?utf-8?B?OFVBdmd2c25peHRIUy9pMHpYRXZWUmZtZDl6SE53eTRTdkFJMndkRG5EK1RS?=
 =?utf-8?B?Y2lDb0dhQVJwMSsrY1BtK3U4UlNqL0taN1VYZ3pTSHVISGdpZWI5WFpQN0lE?=
 =?utf-8?B?cFR1RGRLdkVKZWM0QkdQZ01VN3h1NXorMndUaEdnVHFYdWxOVHVIeGN2UVI0?=
 =?utf-8?B?OFFscmc1Q3J5eEtiNmsyUU1uci95RmE4R080amE5TFltbmRSbjVHclVvVEFp?=
 =?utf-8?B?dFdSVFlvS2FHRHQ4RHFaWEQ3dWovaVc4WHFQdUJYWXl4VUtQTTVOeW1vbkR6?=
 =?utf-8?B?R2hucFBqclVsMHB4eVVvb1BpYWFPa0R3R3VZeURpTHpteUdCNlhxUmVCajl5?=
 =?utf-8?B?Uml0NEF4d1JaNWs0ZWdkbTRRUS9uZUUrNEV0elhTT2o1TUtTTFZMRkN0RXB5?=
 =?utf-8?B?bmt5Sm54NHoxNUpOaGRMek1SYTlJSGVEcGdPUUhIQThHWnRGWTFUUnRtcmow?=
 =?utf-8?B?dnhMKzJLVmxsbzlNTzVqUi9WMXBkSEoyb0RaNFFSbGtyUkNoUlkxd0tvQTJo?=
 =?utf-8?B?NDVGR2hhMU4vZk5EUjNtbGlTSmQ4MU5mOWQ4QjNUczM0NldCUXZZL2FJY3Nr?=
 =?utf-8?B?ZFJVVW5CU0FMYS9jeWQxL0oyeTlQa3dwdkFLMTFpTGxEbFRMM2FNNkpKUVh3?=
 =?utf-8?B?Ykd6WVBoZnNrOURQcko2SWZ1MytJYm1takJhVHA0NFBrRVE1ajRYbWtkMXo2?=
 =?utf-8?B?K1dISEo5amZIc0JmM2kzNkNUNmxWVnY4YU9sVTV5Mm1XMmlnZnovMmg1dXFQ?=
 =?utf-8?B?N3BPQUhHRGFvMjUvdDdNLzNRUzBLVVB0Q0FOblF2bHVDY2RIcjIwOGQ5RFAv?=
 =?utf-8?B?R29tZVJwaHVqaFAzNk1OWmd4bytnTExqb25xNFhyM0kzYjlsMy9GRkRZRzY1?=
 =?utf-8?B?SWRxbGFWMlhaaWwyeUNxNFBWTHo0ZGxjbGpOeWIxSXUzK2JkcHV4OG5XcWtm?=
 =?utf-8?B?bkpQK2dGM2hSZ2t3YkhhREg3VWV6QjZidi9FVzBEWCtCKzB1M0tOeEErd0FH?=
 =?utf-8?B?dFlDdFFJaGgrc0RxSy9DVmJOZWhVbnpnVEo3M3hIa3lsQVJUMDRHWDkrSXd5?=
 =?utf-8?B?dlNpYWl4dy8wMlFZKzJqVUk0RHk3UVpTckwvcWwyWTVCOGRDWFpTUHNGT3Bs?=
 =?utf-8?B?enpxWm5wV094ZFJaQWlOUVFtKzlhVFVzL2piUTlEVXBHT2VXUncvclZaOVFs?=
 =?utf-8?B?N1hmaSt6OEpyWHJSb1JDSEcxUlU2bkJ3VE1ZNDhtMGxIOURTY2wxYkxRZkl4?=
 =?utf-8?B?aTljYlBNQjdnNktzT2FRQ05vamk5MWNFRWRSeFR1VlZEQWNzV3dCRENSeDMz?=
 =?utf-8?B?Qi9saU5GMVNpUko5N3BWMTdFSk41a0dRdkt1akJNUVFkdFFFYytOWTlScDgv?=
 =?utf-8?Q?1TIQ37bcajfa3qA3tcymbXiTw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b924e48-af16-42b3-888e-08dc4ec8f227
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 01:46:54.3681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvFiiNPxEe1OkKpOuz8bI+eeORMrZEekADyMn2Xw+zWQfS3UsCh4M8wrAFwvkoFq8bVFCojtoy910XD3/LTITg==
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

Convert to OF_UPSTREAM for i.MX8MP EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile           |   1 -
 arch/arm/dts/imx8mp-evk.dts     | 684 ----------------------------------------
 arch/arm/mach-imx/imx8m/Kconfig |   1 +
 configs/imx8mp_evk_defconfig    |   2 +-
 4 files changed, 2 insertions(+), 686 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 56623d01240..7b7788f7550 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1101,7 +1101,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mp-dhcom-pdk2.dtb \
 	imx8mp-dhcom-pdk3.dtb \
 	imx8mp-dhcom-pdk3-overlay-rev100.dtbo \
-	imx8mp-evk.dtb \
 	imx8mp-icore-mx8mp-edimm2.2.dtb \
 	imx8mp-msc-sm2s.dtb \
 	imx8mp-phyboard-pollux-rdk.dtb \
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
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index cb8afce241d..fbde476a7f1 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -222,6 +222,7 @@ config TARGET_IMX8MP_EVK
 	select FSL_CAAM
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
+	imply OF_UPSTREAM
 
 config TARGET_IMX8MP_VENICE
 	bool "Support Gateworks Venice iMX8M Plus module"
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 2846faa8352..7e5dfce2ab6 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mp-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-evk"
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_TARGET_IMX8MP_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288

-- 
2.35.3

