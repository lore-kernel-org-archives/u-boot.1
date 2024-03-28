Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216D6C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 23:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF36F8808F;
	Thu, 28 Mar 2024 00:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="A4C+XiT6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DFC68808F; Thu, 28 Mar 2024 00:53:43 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E282188141
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:53:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJSvc4D7OIkRg/PhCEfeX3rmdbw6Il7S0m1PCLE7SgxrI3hN1wU2XhYfcoM2vJDe22PsgIjFoYG2L0+UYvNCF/2Whx7XhJqRnF9KC0PD8yDuGVNSmsK3h45UObgIkZQj77UHCUjYphQk9fslmurTahzIZLLPFu+KvsYOYKCxNT6SoEhdw3Hpk6rCDJwoz+dk2+jqiNfzaTTHloGaoDQYv2DBItnb2drgiildzJzfU9SJJ97JkzCeYy1cfzaq48AjDL8sCMNKb8BOadQCsqOPxjF3QlvxnE+wgSpR+URqtXmQL4NrtnyzXas++pES9e3s+qJzH+WM2vwSQXww0tKyfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDBYFeelG2pxJFQyVkxYDijXU4QusAKDKkS2RdcIdls=;
 b=J+WKHRr3gUkiMZ1QediHTq8VpM5qXWszIa1JWINg+0gTG0MQDjnVN3tOa1da8vxnriEPSD/1/D/G6TBqsz8lTI3lVUtbMePhxE0oW2t2LEqVT+SkN8qgB0TVRtDTlFw9RqxCsUfHZiOZjobDwgUmBb9jsKItubGkyRBzoUbggfTWrOOiI2MTVVy3h0NOnWo17UamEies06v/W1HUGSuEMVNSbGhQfpNGGyjggHZQ9JzwnJMAjuF1u3NIW2m+KGoCXTR+KuWvq6TBmzKdWZjyjYveLQx5v8wHmPl9h+jfoCLGBVnzmH9igspoCuM8KkgrjG9O4EhiLnX4abtdxN/HzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDBYFeelG2pxJFQyVkxYDijXU4QusAKDKkS2RdcIdls=;
 b=A4C+XiT6TowBdLP8wweZh4GHf10BmwQUTzNxn3dMzkV5DROE6x3xctogTlFEbM9HIvKBUOlhE29ZJccPJonVjldtM4YyHh0k1Mw3nyZd43OYAFFI9OUXEzptzUOsb3PGJgxcPY676ZAy5TQEalCb0BV0mA5xpn+OsyCYdtmgCMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB10064.eurprd04.prod.outlook.com (2603:10a6:10:4d3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 23:53:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 23:53:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 08:53:03 +0800
Subject: [PATCH v3 6/6] imx: imx93-11x11-evk: convert to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx93-of-v3-6-4e7f341ed7ea@nxp.com>
References: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
In-Reply-To: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB10064:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b94d13-38fe-4220-b33a-08dc4eb91f6c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nInaH6W2wUf8ii0v4AS7TQsVa8Us4XFYdYtCf9wwB+ZVMtq3fDOoeFSrtY6GFdCr4xrx0sJBbXjfNNLIzUAXONBdiMxCUakJnTdHXSmYJPGzhKVSWL8/0GCzXlNL6Dc8SEEAd1H3aogbmtNpnjzMN1bcs4PVWGvtUyri/C5ngtyXG595EsK7mifo+gOrUJuwHRlxFYI2Md4tzeMniQ0QQlxJGZbqlBLgODVhEDNJyT4uDf4x6ly/ReiLViOebPjHy/Fh1lpv3BYP17+CaOnEuCN4cc4TV2Ibozs0b5CUvSMpDOXp4rsSppWuUIDrDBrNYTb89Tt4aGDOngOwmIXX08ItvJ3ALcAO89Ym1nxuAzUj/gZBhqhsZroR9z8/RMjxZ+wjMFuK+xS9sRFh8W9GrsIca8DLWTBElvylKAIm5HQx6cDE2DwYTz5UaawFI7OVTchdW2sOi6Pe0mymRtvRhk290X3+ejWSO2L1RZAFZl19QzgCoP0Vbshjppvnw3nLaqwE6AIA47h38FSaZ4gU25haWI98TWM9INNWFcWtVcHr1O6Wrvwqfne2sNfICLl1mlhT+S/WYnLPrJRkbg5MtZqePMYNrsVPTHJtxyiNB1SfjpX0/kolkSVxBbSGlAhuysKf3bvjEfsJbDSD1bhg/Xm+RZJu01ZUfbkgH0tizWlvKw82tvbzwW1MRf8zwkcKNH/tZcAvaxoT1pKVLNimKTgweOCLcmlSKJkt4pa9DI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0krdEw1YWtoNmtuYTArRkpZM3llbWJnZ012N0lZT1Z6S3pkeTJFSjNtZmJj?=
 =?utf-8?B?Ym9YRW11OThGNlhibzdLSkVPa3dhQ29xNnhEY2pVTE95dzhuV3VMS2JHL2ND?=
 =?utf-8?B?ck1WVzJaQWxqRVJ2bFRXbnkwcW5zNVVjTmxvUUJuSGo1RWMwTyt1VHJIYkds?=
 =?utf-8?B?OXZEM0NMdHB0d2xkYVpXN05ycFpuVUYzaVloU2dXVHcvK1dVMXlyYVRkRCtI?=
 =?utf-8?B?RmVjWkpzZXVZbm1VSnpqVlZ2SFhXTTZQaXVBLzk0NW5NcmgrckJIUjdPWGtt?=
 =?utf-8?B?M0psMllGL3hwSjNHTkxjdEpPQk16UENYVGZ6WnNtSkw2SkhNRmlZT1NGaHNT?=
 =?utf-8?B?dzRmRmkzL3R5TlNvelZzR0oyaWUwQjRBVllsOUNnc0w4RWY0UTVUME5Uc0VH?=
 =?utf-8?B?RHFUem1venVheW95NFdJVjdYL1czYVZCRkRDRi9SbGp2NDk2SThEb3h0QWc3?=
 =?utf-8?B?SWZXZFNzRktDcmUwcVEybksweDZub2QxQTB1d3J6Y3JJbkd3M1F1Qk5MV0cx?=
 =?utf-8?B?bFlzckRYYWNBTFhwb3lVcTAyUHNSR0FHTHZsWlhwY3hqeVVrZDhFNFRWeGxH?=
 =?utf-8?B?cFdpRHpnZnJzSEdqVHBzL1piMURJbU9FblB0cnIwb05FMnZDVWJXR0syWlRG?=
 =?utf-8?B?bHlEOTFQS2Y2ekVTa3IwaStqclFoNXJ0N05GVkltSktYUUlMK3lUQW9ZOStI?=
 =?utf-8?B?R0xaWnp6Y0Q2VHRJVkloVWd1aVBld1prNzZzd0FRZ01mZlJVSzBPSEhXbTV4?=
 =?utf-8?B?VlluNlVGUmt2c3pZWFdkV2VDK0VyRW1qTWRId002Z1RFRGNvK1A0YWt3KzZo?=
 =?utf-8?B?bmEzMDVzVkNDcnFCQlhCcjRUL3c4bTFyTDNiYi9EbEpNWG15T1J0RlU0b0RU?=
 =?utf-8?B?eHU2MGdWQWlIWVZYbExGTFlsOE94NUI5K2JheVFqd0sxaWpwUVhIbzhmUTZz?=
 =?utf-8?B?NEpETE5ua2dDU01DMWlRM0s0dEo3a2NTYkZRUzlFeHNjOHZVTjBXYkxJQjA4?=
 =?utf-8?B?d1c3ejdJUlFST1BnZ0ZPQ1IyMDQ5NmNoUVkyNXhIbWVvZ3JmMGV3VmRBV28y?=
 =?utf-8?B?MzBac2xUWXRyTnRZTVMzRjZJZHFpbit1QkJ1Y2RXcXlBRnNTY3VDWGdXcmQv?=
 =?utf-8?B?bVdJN01ndWlZempUKzNqaVpQelRjZmhieG1QcjNLZXkyeTVneTE1L2tHRmxp?=
 =?utf-8?B?b3NnUDYrQzJ3bnNSeEk2c0hra09OV1dEVFhpZ29LNXc0U0tmSTYzcHFZbTRi?=
 =?utf-8?B?QldYMHhtbEUwR3lldE9QK0d4SzdESVdVcnBsT3hjZ0RDN05TZ1pIb1hvU2t4?=
 =?utf-8?B?U0JLQlJRYVpEdkcvMy9mRDljcHhBSHhQSkhGd3lQdCtiM1VWMUN5bkk2SFNj?=
 =?utf-8?B?LzNOTlNDVUtGU0F4RkgxTlVqNHlST0Y0dnNoZmp0NWlpL0luYVVkc3grQ0Yr?=
 =?utf-8?B?SGlqeWMvUlJ1bFpkVXdFQVE4T2R3R0NOQ2s4RGYwTWJ6c1VBK3k1UldrdFYv?=
 =?utf-8?B?WGpqQjZQaHFzVzVuS1NQMy9pR2h3OWxORXJ4SDR1K08wWGM2Vkd0YUpLRGd3?=
 =?utf-8?B?T2xaZzNCdTNvc2Exa0RGRVhEeVZIcEVWMlZWKzYyQXZZREdsSWRMWmdidUUy?=
 =?utf-8?B?d0NXYUJ1eGl6SVZqSk9CSWI4Mk9pc2NFa202TVl3YkpIbmo2Rk1uem1RMGtZ?=
 =?utf-8?B?UG1SRnVSZnd4VUg0MmFVUDV0ZEMvMkhJQzRhUzJkKzYyTzYreGpqZnFEN2R5?=
 =?utf-8?B?OGpraGJBV2xhUUd2ME5xbFpBQ1lVcjcrazFvNEc3TlJNSlUwSTZ0Tzc5bjE1?=
 =?utf-8?B?bGEvcHhTYVpLUENVc0JaYk53VlZ2MGpGUnZuMEQ1NGUycVdSM0pMTEpuZFpM?=
 =?utf-8?B?T3ZNNXhLVG1XbGVoRFNtQ0tmSzNEeDdNY1pwWEFoYklvUFZsUE9lOFpTSTVX?=
 =?utf-8?B?SkxxNW5OMTJrMEd2MFZadXhJWFZBd2hOVWFqNU9VYmxyc0FrREdGV2x0K3F3?=
 =?utf-8?B?OVMrdmVtVzhZTGprTTFxUlQ4a3ZvMWpMKzkwSCtsVzVSOHFtOUZMUkhJbDVm?=
 =?utf-8?B?V0VKdWYzQzhFR2g4TFpIUDc1TDdHWXU2MmxFeHI1dmVMd01zYzNMWUxoc1Rw?=
 =?utf-8?Q?cIBhUnsyj/ubkPkcqy6e+WQiv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b94d13-38fe-4220-b33a-08dc4eb91f6c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 23:53:38.3923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXOid2sZJH9EbcqFW+QsTAkH7x7APuvbknar7yDarFNK96RtDNLnZMCXbDBsjq9uek9xGF8eLTR17JILsgR7sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10064
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

Convert to OF_UPSTREAM for i.MX93 11x11 EVK.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile                    |   1 -
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi | 118 +++++++++++
 arch/arm/dts/imx93-11x11-evk.dts         | 322 -------------------------------
 arch/arm/dts/imx93-u-boot.dtsi           |  15 ++
 arch/arm/mach-imx/imx9/Kconfig           |   1 +
 configs/imx93_11x11_evk_defconfig        |   2 +-
 configs/imx93_11x11_evk_ld_defconfig     |   2 +-
 7 files changed, 136 insertions(+), 325 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index d85a33055c9..71c2facfb5e 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1115,7 +1115,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mq-librem5-r4.dtb
 
 dtb-$(CONFIG_ARCH_IMX9) += \
-	imx93-11x11-evk.dtb \
 	imx93-var-som-symphony.dtb \
 	imx93-phyboard-segin.dtb
 
diff --git a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
index a99ba99bfb4..408e601bc90 100644
--- a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
@@ -26,6 +26,111 @@
 	bootph-pre-ram;
 };
 
+&lpi2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-1 = <&pinctrl_lpi2c2>;
+	status = "okay";
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2237500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6524>;
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	adp5585gpio: gpio@34 {
+		compatible = "adp5585";
+		reg = <0x34>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
 &aips1 {
 	bootph-pre-ram;
 	bootph-all;
@@ -44,6 +149,19 @@
 &iomuxc {
 	bootph-pre-ram;
 	bootph-some-ram;
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
+			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
+		>;
+	};
 };
 
 &reg_usdhc2_vmmc {
diff --git a/arch/arm/dts/imx93-11x11-evk.dts b/arch/arm/dts/imx93-11x11-evk.dts
deleted file mode 100644
index 4322cc3e11b..00000000000
--- a/arch/arm/dts/imx93-11x11-evk.dts
+++ /dev/null
@@ -1,322 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 NXP
- */
-
-/dts-v1/;
-
-#include "imx93.dtsi"
-
-/ {
-	model = "NXP i.MX93 11X11 EVK board";
-	compatible = "fsl,imx93-11x11-evk", "fsl,imx93";
-
-	chosen {
-		stdout-path = &lpuart1;
-	};
-
-	reg_vref_1v8: regulator-adc-vref {
-		compatible = "regulator-fixed";
-		regulator-name = "vref_1v8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-};
-
-&adc1 {
-	vref-supply = <&reg_vref_1v8>;
-	status = "okay";
-};
-
-&mu1 {
-	status = "okay";
-};
-
-&mu2 {
-	status = "okay";
-};
-
-&eqos {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_eqos>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy1>;
-	status = "okay";
-
-	mdio {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-frequency = <5000000>;
-
-		ethphy1: ethernet-phy@1 {
-			reg = <1>;
-			eee-broken-1000t;
-		};
-	};
-};
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy2>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-frequency = <5000000>;
-
-		ethphy2: ethernet-phy@2 {
-			reg = <2>;
-			eee-broken-1000t;
-		};
-	};
-};
-
-&lpi2c2 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-frequency = <400000>;
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_lpi2c2>;
-	pinctrl-1 = <&pinctrl_lpi2c2>;
-	status = "okay";
-
-	pmic@25 {
-		compatible = "nxp,pca9451a";
-		reg = <0x25>;
-		interrupt-parent = <&pcal6524>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-
-		regulators {
-			buck1: BUCK1 {
-				regulator-name = "BUCK1";
-				regulator-min-microvolt = <650000>;
-				regulator-max-microvolt = <2237500>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck2: BUCK2 {
-				regulator-name = "BUCK2";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <2187500>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck4: BUCK4{
-				regulator-name = "BUCK4";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck5: BUCK5{
-				regulator-name = "BUCK5";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6: BUCK6 {
-				regulator-name = "BUCK6";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1: LDO1 {
-				regulator-name = "LDO1";
-				regulator-min-microvolt = <1600000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4: LDO4 {
-				regulator-name = "LDO4";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo5: LDO5 {
-				regulator-name = "LDO5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-
-	pcal6524: gpio@22 {
-		compatible = "nxp,pcal6524";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pcal6524>;
-		reg = <0x22>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	adp5585gpio: gpio@34 {
-		compatible = "adp5585";
-		reg = <0x34>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-};
-
-&lpuart1 { /* console */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&usdhc1 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1>;
-	pinctrl-2 = <&pinctrl_usdhc1>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
-
-&usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	bus-width = <4>;
-	status = "okay";
-	no-sdio;
-	no-mmc;
-};
-
-&iomuxc {
-	pinctrl_lpi2c2: lpi2c2grp {
-		fsl,pins = <
-			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
-			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
-		>;
-	};
-
-	pinctrl_pcal6524: pcal6524grp {
-		fsl,pins = <
-			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
-		>;
-	};
-
-	pinctrl_eqos: eqosgrp {
-		fsl,pins = <
-			MX93_PAD_ENET1_MDC__ENET_QOS_MDC			0x57e
-			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
-			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
-			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
-			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
-			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
-			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x5fe
-			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
-			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
-			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1			0x57e
-			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
-			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
-			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x5fe
-			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
-		>;
-	};
-
-	pinctrl_fec: fecgrp {
-		fsl,pins = <
-			MX93_PAD_ENET2_MDC__ENET1_MDC			0x57e
-			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x57e
-			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
-			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
-			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2		0x57e
-			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3		0x57e
-			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC		0x5fe
-			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
-			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x57e
-			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x57e
-			MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2		0x57e
-			MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3		0x57e
-			MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x5fe
-			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
-			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
-			MX93_PAD_SD1_CMD__USDHC1_CMD		0x13fe
-			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
-			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
-			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
-			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
-			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
-			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
-			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
-			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
-			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX93_PAD_SD2_CLK__USDHC2_CLK		0x15fe
-			MX93_PAD_SD2_CMD__USDHC2_CMD		0x13fe
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
-			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.dtsi
index 40e17bbc5ae..289aba17584 100644
--- a/arch/arm/dts/imx93-u-boot.dtsi
+++ b/arch/arm/dts/imx93-u-boot.dtsi
@@ -86,3 +86,18 @@
 		};
 	};
 };
+
+&tmu {
+	compatible = "fsl,imx93-tmu";
+	reg = <0x44482000 0x1000>;
+	clocks = <&clk IMX93_CLK_TMC_GATE>;
+	little-endian;
+	fsl,tmu-calibration = <0x0000000e 0x800000da
+			       0x00000029 0x800000e9
+			       0x00000056 0x80000102
+			       0x000000a2 0x8000012a
+			       0x00000116 0x80000166
+			       0x00000195 0x800001a7
+			       0x000001b2 0x800001b6>;
+	#thermal-sensor-cells = <1>;
+};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index b79485f1f75..e892da80fe8 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -31,6 +31,7 @@ choice
 config TARGET_IMX93_11X11_EVK
 	bool "imx93_11x11_evk"
 	select IMX93
+	imply OF_UPSTREAM
 
 config TARGET_IMX93_VAR_SOM
 	bool "imx93_var_som"
diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index 63613477c7f..a671de7ca40 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -10,7 +10,7 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx93-11x11-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93-11x11-evk"
 CONFIG_SPL_TEXT_BASE=0x2049A000
 CONFIG_TARGET_IMX93_11X11_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288
diff --git a/configs/imx93_11x11_evk_ld_defconfig b/configs/imx93_11x11_evk_ld_defconfig
index 4e3bbdd0cf5..4e1f162e35a 100644
--- a/configs/imx93_11x11_evk_ld_defconfig
+++ b/configs/imx93_11x11_evk_ld_defconfig
@@ -10,7 +10,7 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx93-11x11-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93-11x11-evk"
 CONFIG_SPL_TEXT_BASE=0x2049A000
 CONFIG_IMX9_LOW_DRIVE_MODE=y
 CONFIG_TARGET_IMX93_11X11_EVK=y

-- 
2.35.3

