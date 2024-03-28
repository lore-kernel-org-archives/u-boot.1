Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E11C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 01:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEB5B880AC;
	Thu, 28 Mar 2024 02:46:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aFbLpxLJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBFA9880BB; Thu, 28 Mar 2024 02:46:54 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8CA088103
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 02:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mgxn7hbAMydO7U7ZN7ftXPb2lVAW6wGR7B6qfaokPMwpSOBc0cEo40bB5OTwBvFK6dvE9lSo+75lRgwPrXHHVn/MGws71tCwijbW866iBHHamUX4pFl9Cm5giw4eTtLxCaWfxmUPXsnjBtZSgjFb5Cp2ZsFfuYHR2PY3IhutjV/GjJued+epXe28/C5vrypEi28dz+vmg3qByYhyimCuo6jcc+ddHgzm2RHnzyxCHU4CtBRli/e8o4LXhy2QJ3qxHpLJeyWdvTNHwyBJpwf6I5ZHWPb8YvRYOZVr4Yzsck2U4/FSCPapijxTuXwXixnpc5btJDrpCQg5Ot5LIz0EWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGnVcIZnjJLMebrzifzo/ywQRDi7vqOtsrGmMP1b1iQ=;
 b=HvfstEqjur+KGGKbyX3ehFs6HjNEjJpLehNusqxXFe1stJWLRSIIDaA1Cn1a0Wyqm1KfoSqpDtIdgEaKc20E9TeO85SxEtwCsO269HMDSUNZFJgdXTFYVLVQjk0Na9T6zFCMWjGlcERCSLpPCYDIUT/CI0dIq0QB2wLDI7xMVUz/t6wIIWUmDkmmJ/cel9rr5AaLEwPSYTj+trMB5Bf9QBwF8FN4sdTw1E6BEnbHv4Yc7T5BhyBFr/mJvJmu77cQkDmGnx4GsUTydYdjiHcFgOj+pbOLVHeCGmZVTGNbKExDMcoRQ/lvzVXEEBG7HmPeXNK8pLFQ6qfgjxvjG3FsDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGnVcIZnjJLMebrzifzo/ywQRDi7vqOtsrGmMP1b1iQ=;
 b=aFbLpxLJUZHkxBG1GYC64HO1YgNEqk8rS2w9iFkLPMhckEoi79x3buOpmG6jquMlBYL+q9ublAV55gLrDqF3+xlkzPO/7Ut1vZN2ImrTlcVItQRxMfmkZk7vkFnuFWHesR2MUxU69E5ZpBjNFn835ftau7nAT9dIJ5xzMnMj6MI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8496.eurprd04.prod.outlook.com (2603:10a6:10:2c8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 01:46:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 01:46:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 10:45:09 +0800
Subject: [PATCH v2 2/4] imx: imx8mm_evk: convert to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx8m-v2-2-7656998cc8b0@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 922e69a9-90ff-4569-fc22-08dc4ec8ef10
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RsnOa43N/fvYcPYTnxJHMQpmUZBDfBWYZAdDuLdArRYAsq8DqR0knNQVaDC5hb15FSQoqPyelFS5K5KuwJm5rpwn/IQoyzpNW1pULAsBsvJqdg2o/0QPYb6g+cy3WeQIsHl8S0ohyehsKDZiJrehuiAAL1iFdDo3cMrsOL1FEWx0EdfSUPqXnEus677AG1e+Ayk/yrxr/x0CLtTVQRmStLcIQNHG/EyWlhvrDceYZIWJO8qIcjp1+ts8Ryq3JOnpfNjZZkxSUGrVK/yN8TzZFpqnGf+/XgRX97bLA6dBVHeOlm2wxXnmoWH6Z3icrG19lsxrXBbD5FTWqdt/iZhBO9BchAe0STxpWOB4g6r/7DK8aCuVDQhnUTTlGOc6YUBTBPMzjC/1q/GQqiOoELG10Gh6ofYUI5fH6fiabk4m6/7MEr0TjaIB0VoFxjwjoKgjLENZpvbv9sFZ1kq0NYD0VsT5h0g+6LVhuYhud9lJaYkRLNFxvgA3OhrH5LgIPPq205PEZj0akmdA/SVWIWo950Nd30JmCItGJoMfGJySb4g4fgqGE2a2NpESto2qnbrg7aae6TOnBao1P62JsQ0nu/b9NbILyvxdd60vKEuMcfXsMn4FQUb3x3+lMQ6VH9c7g4gDSnOjO1aE9AwxUStVW2DE7qQqLEYK/R6yxFg8TIDKmMN2EdWacWoJecgLZlzsY5255+B/WzBp+6/ir5FS/g63VByIBV4CYjp+BG1+Jmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFFHZWJIUS9ObWxZLzBVWmdFVTlaNHVVb1RmZkJtSzdvUkM4bkx2UFFIaTJY?=
 =?utf-8?B?VmtsaVd3MG1DN0d6SUhnVnJpR3R1Z3pPU1YxRGhWSjVpMk5zUUV1RGNxM2FC?=
 =?utf-8?B?Q1ljRDBxbVcwQVVDWldPZk9LRnAwa2VEOHcyekpYTlFraDhSdHlWSVkwN3hx?=
 =?utf-8?B?d2dzd0pVS3dKSko5VHpobUNSOVR3cHl6NHd3OUxCaXQ1UkNSb3hJV1RTQWRa?=
 =?utf-8?B?QnlPM0VtRk1nWlozYVUzOXp1dE5TVnRuM2dHQWZXNnByckx2bkVQSDU5UUti?=
 =?utf-8?B?TDVhYlM5ZjRpNFlwdUxQWk8zYTJnYS9vcGhLMTMySndvUEtFT3pNRGJjT1VX?=
 =?utf-8?B?MEJTNEIxOWxuVjF3eURpMVVoWmRuQ1BYbUpHVi9ZNDZsR0ljcHhSUmYzd1lS?=
 =?utf-8?B?YXltSmovSkt2M3JVdTFwN3AwcUl3ZnZ1RDIxa3dyVEVjbFdjazQrVTNnQnVD?=
 =?utf-8?B?Z0RiQ3QrcUw0TWNXNG01Zmh3UTAvbGVQWTR5U1d4WWtPRkR3OTRYR252WEtt?=
 =?utf-8?B?cWtoOXNuVHpaWU5wbk9UUjVOUW1RUnYvVHlrZHVuRGltN3JNZ3JMakwyY2Vi?=
 =?utf-8?B?MUxYVmM1eFRaUzNGT0FkSDNVMklrbDNrSTMxQ0JHNFcxcE1oQWJodE5aQmJB?=
 =?utf-8?B?a3F5c1VmellnRkc2K1Z5TWpnbkU5ejFHMng5a1RtWDg0bUFRMzg4aiswY1Nr?=
 =?utf-8?B?OWZ0eUlERVhOdmdUTGp1Z04yR1k4a1ZadndvUW52bVl5WDRqRGpVN3dGNlJp?=
 =?utf-8?B?Y1d5Y0pyM0M2aFoyMjN5Y2lYQmJOL3BHZENnQ3VuNHVJQ1V6NE1oQ1RCLzQz?=
 =?utf-8?B?NjZaWlZOU2VKMUpndEppV0h0WTFqQ3hsdVpMS3lyWnVheXNVU2w2Y2NnNjNX?=
 =?utf-8?B?Q1h5MkEzd0p0QkNZV2JOM0U5eXdUcGhEZnJXeHozWkdDcXJaUGg2NktmalZt?=
 =?utf-8?B?R0FVVnNjb2xLNU9uNXJuNzY5U3B3WTljNVAxR0U1RkRUN3lhQ0hRUkhEYWx5?=
 =?utf-8?B?SDFxK3hVUTJ2K1pIZHJnaU9kT1BPQkdGK1k4OWRlaHMwVEZTSEJTaFFzUnJC?=
 =?utf-8?B?OG8rZEtWVzF5VE1oQnE3MUYveDFseWlQQkVRRFZESDhlb3hvRUpkbHRNamx6?=
 =?utf-8?B?ZkRZT3dwQ3hlK3Z0a0hwQkhFcGxkV3pnU2pPdGVTZ1hBVXlLQXJQR2kvaEk1?=
 =?utf-8?B?VVBUZ09lSkh3b0ZEeUk3UG9lM1E4Mm5XSUh3NE1GWTNkTm02V1RZNkJpZ3Z3?=
 =?utf-8?B?aFgyTTJJSm5UdUZEYTBEMmtEMjhqMGtUZ21wWWI4Y01qUW10Qnd1b3BZRmg2?=
 =?utf-8?B?SlkxRnIvQ09LM21mZXVqSWVmUnJMZ2svU29McG9XdGY5ejVNS3VxOG45dU5l?=
 =?utf-8?B?cXB3T2R5SFlMOWpkT1Q2RUR4U0U5cXJiYkhTL3Nxd29tNytURXlrSU9aazgx?=
 =?utf-8?B?WVZIeVBFRFJJWUgrZ3RjNTVjRnVzWmNFQURDMnhMbkFra3pwQ3k3a3BMMlV3?=
 =?utf-8?B?aDJwV1l5V0tSMFdTQ1hPRHNEdmJTeDBsZ2plNXFXcEFrakVScXhyc2hrbVB5?=
 =?utf-8?B?djh0MklHVzVDV3ZVRXVwUUNVYVQzMFVhNUprTmRyRzlvSnM2U0hJcGJYK3Fi?=
 =?utf-8?B?V0tkRmJSdG5MNXFWVllPTVJ5aWNRRjk0cFZNeWd0QXp3ZGZZMk1rNHgxN29S?=
 =?utf-8?B?Sk91aEsycDllMVhDR3JESEpZeGwzblRtZ2VBc1RON1F6cUl3eHRSU1VGZTlO?=
 =?utf-8?B?S2pqa1VjdmhFVU9kQUIrVGY3L2pmSStmWG1jekdGOHBXL0w0aWdvWnE4Z3g3?=
 =?utf-8?B?ZVZjbldHRElHY1JEcnRkSHg2RkV5MThnUDNPcncybmQzWThKczZvVUkwOHVO?=
 =?utf-8?B?eTVyNnM0OHFYV0gxMDJGMlR0dnNnc2ZrOHAvZkFoMkRkNXVIWmRtekFmMnpw?=
 =?utf-8?B?eFY5cGYwbXIxSVkrWnJQZHN0ZmtrQ0xVNndBTUtFTjFFZUp5UjlsaGN5MFJt?=
 =?utf-8?B?NUFmWmtLZHBPZ2phMWNxQkU2bUpmUXdYWGlOSDgwN1QwaEY0TUY3dndpeHJ2?=
 =?utf-8?B?NUJUNldVb29JNVVTeTRFaGg2alBpRTY2ZzRkb2p3eG9wbVl4U3AxaEJvZkFF?=
 =?utf-8?Q?sx6IQyzaAHlVlyJNvCYWZArC6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922e69a9-90ff-4569-fc22-08dc4ec8ef10
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 01:46:49.2384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZWu3h2byekI+lO0qEYngsKCC3WnL8fBDk/3oFgUFLDrRvyd7sMPZ0XtBHut6kncd4U8QrFa6gyvA8EOwxxRhA==
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

Convert i.MX8MM EVK to OF_UPSTREAM

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile             |   1 -
 arch/arm/dts/imx8mm-evk.dts       | 128 --------
 arch/arm/dts/imx8mm-evk.dtsi      | 615 --------------------------------------
 arch/arm/mach-imx/imx8m/Kconfig   |   1 +
 configs/imx8mm_evk_defconfig      |   2 +-
 configs/imx8mm_evk_fspi_defconfig |   2 +-
 6 files changed, 3 insertions(+), 746 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index b76ee4d609b..b7992491389 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1074,7 +1074,6 @@ dtb-$(CONFIG_ARCH_IMX8ULP) += \
 
 dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mm-data-modul-edm-sbc.dtb \
-	imx8mm-evk.dtb \
 	imx8mm-icore-mx8mm-ctouch2.dtb \
 	imx8mm-icore-mx8mm-edimm2.2.dtb \
 	imx8mm-kontron-bl.dtb \
diff --git a/arch/arm/dts/imx8mm-evk.dts b/arch/arm/dts/imx8mm-evk.dts
deleted file mode 100644
index a2b24d4d4e3..00000000000
--- a/arch/arm/dts/imx8mm-evk.dts
+++ /dev/null
@@ -1,128 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2019-2020 NXP
- */
-
-/dts-v1/;
-
-#include <dt-bindings/usb/pd.h>
-#include "imx8mm-evk.dtsi"
-
-/ {
-	model = "FSL i.MX8MM EVK board";
-	compatible = "fsl,imx8mm-evk", "fsl,imx8mm";
-
-	aliases {
-		spi0 = &flexspi;
-	};
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
-		opp-750M {
-			opp-hz = /bits/ 64 <750000000>;
-		};
-	};
-};
-
-&flexspi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexspi>;
-	status = "okay";
-
-	flash@0 {
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <80000000>;
-		spi-tx-bus-width = <1>;
-		spi-rx-bus-width = <4>;
-	};
-};
-
-&usdhc3 {
-	assigned-clocks = <&clk IMX8MM_CLK_USDHC3_ROOT>;
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
-&iomuxc {
-	pinctrl_flexspi: flexspigrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_ALE_QSPI_A_SCLK               0x1c2
-			MX8MM_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B            0x82
-			MX8MM_IOMUXC_NAND_DATA00_QSPI_A_DATA0           0x82
-			MX8MM_IOMUXC_NAND_DATA01_QSPI_A_DATA1           0x82
-			MX8MM_IOMUXC_NAND_DATA02_QSPI_A_DATA2           0x82
-			MX8MM_IOMUXC_NAND_DATA03_QSPI_A_DATA3           0x82
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK               0x190
-			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD               0x1d0
-			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0           0x1d0
-			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1           0x1d0
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d0
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d0
-			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3           0x1d0
-			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4             0x1d0
-			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5            0x1d0
-			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6            0x1d0
-			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7              0x1d0
-			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE           0x190
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK               0x194
-			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD               0x1d4
-			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0           0x1d4
-			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1           0x1d4
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d4
-			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3           0x1d4
-			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4             0x1d4
-			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5            0x1d4
-			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6            0x1d4
-			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7              0x1d4
-			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE           0x194
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK               0x196
-			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD               0x1d6
-			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0           0x1d6
-			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1           0x1d6
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d6
-			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3           0x1d6
-			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4             0x1d6
-			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5            0x1d6
-			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6            0x1d6
-			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7              0x1d6
-			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE           0x196
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx8mm-evk.dtsi b/arch/arm/dts/imx8mm-evk.dtsi
deleted file mode 100644
index 7d6317d95b1..00000000000
--- a/arch/arm/dts/imx8mm-evk.dtsi
+++ /dev/null
@@ -1,615 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2020 NXP
- */
-
-/dts-v1/;
-
-#include <dt-bindings/phy/phy-imx8-pcie.h>
-#include <dt-bindings/usb/pd.h>
-#include "imx8mm.dtsi"
-
-/ {
-	chosen {
-		stdout-path = &uart2;
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x0 0x40000000 0 0x80000000>;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_led>;
-
-		status {
-			label = "status";
-			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
-
-	pcie0_refclk: pcie0-refclk {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-	};
-
-	reg_pcie0: regulator-pcie {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pcie0_reg>;
-		regulator-name = "MPCIE_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
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
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000 0>;
-		brightness-levels = <0 255>;
-		num-interpolated-steps = <255>;
-		default-brightness-level = <250>;
-	};
-
-	ir-receiver {
-		compatible = "gpio-ir-receiver";
-		gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ir>;
-		linux,autosuspend-period = <125>;
-	};
-
-	audio_codec_bt_sco: audio-codec-bt-sco {
-		compatible = "linux,bt-sco";
-		#sound-dai-cells = <1>;
-	};
-
-	wm8524: audio-codec {
-		#sound-dai-cells = <0>;
-		compatible = "wlf,wm8524";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_wlf>;
-		wlf,mute-gpios = <&gpio5 21 GPIO_ACTIVE_LOW>;
-	};
-
-	sound-bt-sco {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "bt-sco-audio";
-		simple-audio-card,format = "dsp_a";
-		simple-audio-card,bitclock-inversion;
-		simple-audio-card,frame-master = <&btcpu>;
-		simple-audio-card,bitclock-master = <&btcpu>;
-
-		btcpu: simple-audio-card,cpu {
-			sound-dai = <&sai2>;
-			dai-tdm-slot-num = <2>;
-			dai-tdm-slot-width = <16>;
-		};
-
-		simple-audio-card,codec {
-			sound-dai = <&audio_codec_bt_sco 1>;
-		};
-	};
-
-	sound-wm8524 {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "wm8524-audio";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,frame-master = <&cpudai>;
-		simple-audio-card,bitclock-master = <&cpudai>;
-		simple-audio-card,widgets =
-			"Line", "Left Line Out Jack",
-			"Line", "Right Line Out Jack";
-		simple-audio-card,routing =
-			"Left Line Out Jack", "LINEVOUTL",
-			"Right Line Out Jack", "LINEVOUTR";
-
-		cpudai: simple-audio-card,cpu {
-			sound-dai = <&sai3>;
-			dai-tdm-slot-num = <2>;
-			dai-tdm-slot-width = <32>;
-		};
-
-		simple-audio-card,codec {
-			sound-dai = <&wm8524>;
-			clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
-		};
-	};
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
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy0>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			qca,disable-smarteee;
-			vddio-supply = <&vddio>;
-
-			vddio: vddio-regulator {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-		};
-	};
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
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
-				rohm,dvs-run-voltage = <1000000>;
-				rohm,dvs-idle-voltage = <900000>;
-			};
-
-			buck3_reg: BUCK3 {
-				// BUCK5 in datasheet
-				regulator-name = "buck3";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-boot-on;
-				regulator-always-on;
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
-
-&i2c2 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-
-	ptn5110: tcpc@50 {
-		compatible = "nxp,ptn5110";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_typec1>;
-		reg = <0x50>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <11 8>;
-		status = "okay";
-
-		port {
-			typec1_dr_sw: endpoint {
-				remote-endpoint = <&usb1_drd_sw>;
-			};
-		};
-
-		typec1_con: connector {
-			compatible = "usb-c-connector";
-			label = "USB-C";
-			power-role = "dual";
-			data-role = "dual";
-			try-power-role = "sink";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-				     PDO_VAR(5000, 20000, 3000)>;
-			op-sink-microwatt = <15000000>;
-			self-powered;
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
-	};
-};
-
-&pcie_phy {
-	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
-	fsl,tx-deemph-gen1 = <0x2d>;
-	fsl,tx-deemph-gen2 = <0xf>;
-	clocks = <&pcie0_refclk>;
-	status = "okay";
-};
-
-&pcie0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pcie0>;
-	reset-gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
-	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk IMX8MM_CLK_PCIE1_AUX>,
-		 <&pcie0_refclk>;
-	clock-names = "pcie", "pcie_aux", "pcie_bus";
-	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
-			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
-	assigned-clock-rates = <10000000>, <250000000>;
-	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
-				 <&clk IMX8MM_SYS_PLL2_250M>;
-	vpcie-supply = <&reg_pcie0>;
-	status = "okay";
-};
-
-&sai2 {
-	#sound-dai-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai2>;
-	assigned-clocks = <&clk IMX8MM_CLK_SAI2>;
-	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
-	status = "okay";
-};
-
-&sai3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai3>;
-	assigned-clocks = <&clk IMX8MM_CLK_SAI3>;
-	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
-	status = "okay";
-};
-
-&snvs_pwrkey {
-	status = "okay";
-};
-
-&uart2 { /* console */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&usbotg1 {
-	dr_mode = "otg";
-	hnp-disable;
-	srp-disable;
-	adp-disable;
-	usb-role-switch;
-	disable-over-current;
-	samsung,picophy-pre-emp-curr-control = <3>;
-	samsung,picophy-dc-vol-level-adjust = <7>;
-	status = "okay";
-
-	port {
-		usb1_drd_sw: endpoint {
-			remote-endpoint = <&typec1_dr_sw>;
-		};
-	};
-};
-
-&usdhc2 {
-	assigned-clocks = <&clk IMX8MM_CLK_USDHC2>;
-	assigned-clock-rates = <200000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	cd-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
-	bus-width = <4>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
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
-&pwm1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_backlight>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_fec1: fec1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
-			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
-			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
-			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
-			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
-			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
-			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
-			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
-			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
-			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
-			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
-			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
-			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
-			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-			MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22		0x19
-		>;
-	};
-
-	pinctrl_gpio_led: gpioledgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16	0x19
-		>;
-	};
-
-	pinctrl_ir: irgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO13_GPIO1_IO13              0x4f
-		>;
-	};
-
-	pinctrl_gpio_wlf: gpiowlfgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SDA_GPIO5_IO21	0xd6
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c3
-		>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA			0x400001c3
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL			0x400001c3
-			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA			0x400001c3
-		>;
-	};
-
-	pinctrl_pcie0: pcie0grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B    0x61
-			MX8MM_IOMUXC_SAI2_RXFS_GPIO4_IO21       0x41
-		>;
-	};
-
-	pinctrl_pcie0_reg: pcie0reggrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5       0x41
-		>;
-	};
-
-	pinctrl_pmic: pmicirqgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x141
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
-		>;
-	};
-
-	pinctrl_sai2: sai2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI2_TXC_SAI2_TX_BCLK      0xd6
-			MX8MM_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC     0xd6
-			MX8MM_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0    0xd6
-			MX8MM_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0    0xd6
-		>;
-	};
-
-	pinctrl_sai3: sai3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
-			MX8MM_IOMUXC_SAI3_TXC_SAI3_TX_BCLK      0xd6
-			MX8MM_IOMUXC_SAI3_MCLK_SAI3_MCLK        0xd6
-			MX8MM_IOMUXC_SAI3_TXD_SAI3_TX_DATA0     0xd6
-		>;
-	};
-
-	pinctrl_typec1: typec1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD1_STROBE_GPIO2_IO11	0x159
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
-			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2grpgpiogrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x1c4
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x190
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d0
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d0
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d0
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d0
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d0
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0x166
-		>;
-	};
-
-	pinctrl_backlight: backlightgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO01_PWM1_OUT	0x06
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 6f68ee2c27d..dd139c1b223 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -79,6 +79,7 @@ config TARGET_IMX8MM_EVK
 	select FSL_CAAM
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
+	imply OF_UPSTREAM
 
 config TARGET_IMX8MM_ICORE_MX8MM
 	bool "Engicam i.Core MX8M Mini SOM"
diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index b51e3931d24..e41facd8513 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mm-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-evk"
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_TARGET_IMX8MM_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288
diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_defconfig
index 34e8071611b..3aaf7a4d0d5 100644
--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -11,7 +11,7 @@ CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_IMX_CONFIG="board/freescale/imx8mm_evk/imximage-8mm-lpddr4-fspi.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mm-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-evk"
 CONFIG_SPL_TEXT_BASE=0x7E2000
 CONFIG_TARGET_IMX8MM_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288

-- 
2.35.3

