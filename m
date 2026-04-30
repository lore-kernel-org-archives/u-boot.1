Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4620FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E446084612;
	Thu, 30 Apr 2026 10:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="W6zm/H6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A3098464D; Thu, 30 Apr 2026 10:37:35 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D79D88460D
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:37:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmyGwQbe0zvLhaHJOymetKXGLsb0UneYuk5hfkrNVgOx2DBlKmsdHYEhP1J2F15y3tgN3GwpX+QEeS1Qx334OQUb7oHNeL0PWEA9zq4Q2tnGd9qte2CNJD2sy8FZkx0OWmp2gff9aIDzV+vUf8SSNS9mZgRXLtLjW0l6Pif8TojV+yemR6G5NJ4xqth+jVWbqECoGf5rJdP8WMwQn9F6Nu6/Sa7p5w3pk/VCWf2HMeTI88OU5eI0dCR5Bvp/5agp/mjwiNn2hAwLXfAa0LdbTIJ83SLowsOHX0VrAGHHDdYuDehS1N+pLC7NqjOQnHD4Pk6RA5ggiPko3VWrTk+bsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7XsX2Tbd0OcPdhj0LaiBV48XvCwyUmzxcsT+shZU0k=;
 b=ClDIrGdqBsW9Vzl2MxSlaCgbntuYCjduCD+Hix3E1CxY5eW79J8fUbCT4CE2NtFiGWR8Lq85Rmu7rAM4Sw3VginvS64ed8zfKdfCnC4HHVnK7JBCWSsfhR59VO4Wqwvnv+w5WsHpWVdQto6gFZPCl27wbfhfrtoY/1/cdHUI6226g2yZ/tNVtT4rLcQ7cOOhajwP0N72ml/2kyKBiqi0+wavSCGyW7Wias9a7XwRBbo0s/K/XaEHBMMUcAGS1LF7Xh9DL9vNoN1DTkdCCM/ww7zYMXUViaHGXqUNODTSv0RYoXRHCCMK0YsN6/ktFw7SUqDUYnJ4QAdc+yYdak4IOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7XsX2Tbd0OcPdhj0LaiBV48XvCwyUmzxcsT+shZU0k=;
 b=W6zm/H6d24FJTM9u7OBq5vKSReGU4nGXhXwMqBI+gX69EIlaiNxXp3XRfEfCA5A07D8yUYJIYQ23tI5DcXaYZ6lnbHrFO82xqvmLVCQCgwNjw1YYcyqDtweFz0vfr6rZFNaoNgXi34CTcNMt1ry256PKHWqsxPpXTw2jH1558PKTi/uQV/hGH+RlRkjPYorXzERiyNsOSd6upVlCoAsXaz9fcn7oO8CYwBYYxUnsN56YMPgNrZklxhAW+vMXq3OgzyzbPFft+e6/hvvQBeXaTT8iz8PhbeaqBzZkUEmmfoN3HYkdY78p6sQDio5egk3Gv414TWnXK2nHmSpbD4SJkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DBBPR04MB7820.eurprd04.prod.outlook.com (2603:10a6:10:1ec::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 08:37:26 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 08:37:25 +0000
From: alice.guo@oss.nxp.com
Date: Thu, 30 Apr 2026 16:39:56 +0800
Subject: [PATCH v1] imx7ulp: Switch to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-7ulp-v1-1-f54e8c481f54@nxp.com>
X-B4-Tracking: v=1; b=H4sIAFsV82kC/yWMyw5AMBREf0VmrUmrXvErYkFdXBGkRSTi3xXLM
 zlzLjiyTA5FcMHSwY6X2YMKA5ihnnsS3HpGJKNUxlqKbJ9WoXSSakOxyXOCV1dLHZ9fpsShUP2
 b25uRzPb+cd8P3h0tdmwAAAA=
X-Change-ID: 20260430-7ulp-13563ce4c88e
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DBBPR04MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: a4da6101-3721-4731-ab26-08dea693b455
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|52116014|376014|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: LIGgBhUGEjZfLx+J/fB9/HGLGej7SdDVJEpyOC79p2i9maJ8HFHX789TqCQ7JQ86FQberDfUc4QKI6tGpGBUE4EC1RAXq7PNP5zYBn4N2RCPIjO2mjBhZVFx8iQoam8ROUmEg9BDZOOPrBTdK72ogSPUl4qMDn3lAA8ytnNv1Z+xpRR0X4GkEw52b23/DyN7RAKz5P1lULrccCphuPzISoFKwOCR4Jcp/E0iexwpxE+OfQHvx4vuGVvC/e/a1CdIpLAY0tQ+kbqt6CMAUpCg4rFLAvb/YPuPD+8GdBrrwgTVVBfheyXfFZUHSoYO0J14yskPtBxi7cWIzPg+1wh0qc6vld/cXwiZ12V1ASOJthsWX7Ti/xBLcXMQTEdHg/epIMLbDzIsWmZQl9OO2oQFJHcFbuLnuMtIXWOvLe2rxBMGsY0mB+Ri0FplnGm9suBXviblYEse7m+z4pglu999R/xlOcgfBuWE1oUYuBSVdTe6D4XZ6jRadSKhLreNMzylJ4uuU/Q0yeor/Mgcop+klHSnw0g1fi06IWOcFeZm7ZLdApG/GQ+ukDm+moZwjuoXuLWHph25oqWu+8truqRfjmJfWJm+qdRqg64s6jdFEfXxGv9VyXVh6pu4eZvxf3MmOgmun4NEvDOXDsHp/iewFShDTu2+M7vKTM0UCbqM76TimazaYB4fTiuEOxmjoO9pZCjakNFv0CX89QUDbf5PMcpTh/0vVG55gqBfc7bJS9azwVrRVZfhXcBduZWc5uqkfFzJm7isl5bMFOGhokejbx1TJUK/AELqTSKoEVH/U5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(56012099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEt4ZVVNSW95R0dvUWFQbnhaN2NUUGV4Q1RXUUJOeE9nbmFOMWZpaExxelVS?=
 =?utf-8?B?dGVTZXhYQThJU1k0dXhwY2orQmFma0NHbkEzOFNXS1o3amRvRmtwa0xRMXdk?=
 =?utf-8?B?QkNjeVJ3RlBSSURMQlZmd2ZGd3JIaGl4OVA1QjRUdnVuVkZIbUtOSmJjcDVP?=
 =?utf-8?B?WjJ4ZDdVZkNQRStBR1FYdUVqWGJJRmd2UDNHWERPdUZqb3dHaXJKVXAwOVZh?=
 =?utf-8?B?RDlZb2tVQnMxTFBFRmVDVk9YTnJEOFJtZFBqTExpZklJRFBEcmdIdzhyUnJG?=
 =?utf-8?B?U1JmcFZqdkd5ZWIyb3ZCTlRNcjZQSmpPbDExVEc1eWw1NHpUOVFpQXlWNXBX?=
 =?utf-8?B?LzZsQXJBK3RpL3FmeU9COFlCRDIzK3puSUVBdC9mUW9uVjRKY0J0VjZ3ZmVt?=
 =?utf-8?B?cldTL09JYzZNM1RBVXZRYlNQN2E4am1tdHhENEoxRkVrRFlKVWlPNDYrcTYr?=
 =?utf-8?B?TmZnV1VPU3VSb2liTXBVTnA0NGRCRXY4ODlPTWxkSHhYUmF6dWlpYXJvR0s1?=
 =?utf-8?B?OXZidGNFSmZZcng5eHBQY3RjbXo1K05MZkVNdXNjZ3k1RlpTekxVRTZUVlpk?=
 =?utf-8?B?dmxFMm51Y3d0bWtyZm5JTmhycmlDMVF5bFdRVXppZFh3S2lQNERpZW1jNFFu?=
 =?utf-8?B?R1JuT0YzVlYwcm51WmhpUlEwaUpzWG1HYjVZYzVtZDNJbmVzRXFxYmpMOUlQ?=
 =?utf-8?B?WWkyUkQ5WWl4MndZemJkeVdmeXFWVmhjUFd2V09EbUpSSG1EMzRrWWg3VTVh?=
 =?utf-8?B?OUVOaXcraGd0dk5nRlZvTTVpdGd4ZzEwNkU4dFlWeE5FVzhhU2dBb3gzNTd6?=
 =?utf-8?B?YnZkQ3dXOEpkZWdSREdvS3pYR2NvNk1RcnNOamRUWC9jdGVnb1M2dHRRUGNH?=
 =?utf-8?B?UHFCMmFxNVk4TVZ1MGdCazAwRTdNQlJKc3RzNGlMVFdzNUw0WFZrcnZhR3Fs?=
 =?utf-8?B?R0lQSmpqaTA5WUV4TytKMGRBRCtOblJDMnF2bUdKYU05cmNVUktLWEE4NG1N?=
 =?utf-8?B?KzRUbkVQcEc0Ym1NdGxHUXN1cG5pZm8rWkpJd0dkSnc2ZWRvd09GNXAyMkw3?=
 =?utf-8?B?Vll3NDZXZ0FVN3J5dE9WazdTOU1tOWE0UFE2bGpDWWltMGo1dzZPRzFNTmJS?=
 =?utf-8?B?MGlWSVV3Mk43dm1oOWs4bFpMbHVRY25vN2ovWDY4QnQvNit4Y2V6Y1BDc0NW?=
 =?utf-8?B?NUVkM2l4cFkwTTh4K2l3aG4wdTM0NjRCeUJrdVhaK0I4OW9yMkUxb3VOWndu?=
 =?utf-8?B?allBYmN0Z2wyZVFPN0FzeTZmY2V3VHUrdzN4ektmU3pSRHhmQ3I1U0RaY1Yw?=
 =?utf-8?B?ZUVrblJ3elBNOFJXUmlmSmQyYXlDNjIyYWFlQ3pGZ1Nybkw1QzcvYk0xdjRP?=
 =?utf-8?B?dSt5NXloVVViMFpEdGVDdTJZZTlZRlRMN0JnYzMyZXZFMVRHelNwYkJ4ZG1j?=
 =?utf-8?B?a01mSjl1ZHBtTmJxVXBMdSswZFgxVTI4cnNLNWhwdDVsWHZpcHhBdEdxRkFo?=
 =?utf-8?B?dERyUTBBMFJEWGQ0VmlKQndFZzFSSFFZWUpPYTlZVi9NbVplNnh5cEJ2bXRz?=
 =?utf-8?B?a0huckZJUUJmWWM1aHhGTE9udVVjeUVXWjZHTFJxMkNVTHBVZHpFY3Ara21y?=
 =?utf-8?B?LzBMWFNYQjhWU3dIeUpxN1dWaFdRUHdBOHBncjJtaTBsdFowR010U3NIUndC?=
 =?utf-8?B?MTRuMXFjaFBzd3JXODdvakdIcHhTbDJBWUp5M2JSbGVZeWFGR0ZRbGRRVEI2?=
 =?utf-8?B?akxLUGlvR21TZXF2d3BTc2Zwb3Mwd0kvRTNQSTRHU0o2aHNxbG1mR05IbCsy?=
 =?utf-8?B?UlVzSFp1M2xPVkE4WUNFMTB3Y0tNNFh5VnYybE82aFJBajRmSlA0RGVCTDhJ?=
 =?utf-8?B?VG5KTVFIQy9GQkxzUXdlUVJKQnBPQWlKTWNCUzVFQ1cwV09TeUVlT0xVNnJL?=
 =?utf-8?B?RmcwS2FodVV4clMwNHFXSTFidW55VDZFOXBEQUREdEw4TS8ySUxLSGpyTDZM?=
 =?utf-8?B?dk1TM29Ba0FJRzVFSlpnVUlLaUJtQ0MzT1A1YmxCNUZYMnFmcTI1Q2FyZmFa?=
 =?utf-8?B?MzVEM2VzZFlMTkRKNFZ4WS9BRjBmYXFQczFaQ1JSOTFvVUdLWVBNdGQzbEVN?=
 =?utf-8?B?SFZZbzNoeHRSalArUFBPUWxxNzhHVHpvUnZMQmViZTk0V052Kzltc2c2cTl6?=
 =?utf-8?B?Q3RXemc0VitONHBhM1NGdnFtSzRGaWlFemc1NWRBRU5NdDBPUHNsOWpyRGNy?=
 =?utf-8?B?TnNIcFdyU2puQmhUSFpUaVI3Rng5VmpiWkhKZXlkdVoyYWFsSkxMWklUVjc5?=
 =?utf-8?B?RlJNQmkwMkNlQWhCNnJra1luWE9nS1NuUjJPdCt1U1JDVUVySnlyQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4da6101-3721-4731-ab26-08dea693b455
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 08:37:25.6464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7SLSP3JFRiRxzHBqQ5bhrmlltSdrzkK7tamADXTHDVvcZEoQx3bxnbvjJjLw6FuCWDR6v+h/Y97VIPu9Dhjtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7820
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

From: Alice Guo <alice.guo@nxp.com>

Migrate i.MX7ULP boards to use OF_UPSTREAM feature, which allows U-Boot
to directly use device trees from the Linux kernel upstream.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx7ulp-com.dts        |  79 ------
 arch/arm/dts/imx7ulp-evk.dts        | 133 -----------
 arch/arm/dts/imx7ulp.dtsi           | 461 ------------------------------------
 arch/arm/mach-imx/mx7ulp/Kconfig    |   2 +
 configs/mx7ulp_com_defconfig        |   2 +-
 configs/mx7ulp_evk_defconfig        |   2 +-
 configs/mx7ulp_evk_plugin_defconfig |   2 +-
 7 files changed, 5 insertions(+), 676 deletions(-)

diff --git a/arch/arm/dts/imx7ulp-com.dts b/arch/arm/dts/imx7ulp-com.dts
deleted file mode 100644
index d76fea3b35c..00000000000
--- a/arch/arm/dts/imx7ulp-com.dts
+++ /dev/null
@@ -1,79 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-//
-// Copyright 2019 NXP
-
-/dts-v1/;
-
-#include "imx7ulp.dtsi"
-#include <dt-bindings/input/input.h>
-
-/ {
-	model = "Embedded Artists i.MX7ULP COM";
-	compatible = "ea,imx7ulp-com", "fsl,imx7ulp";
-
-	chosen {
-		stdout-path = &lpuart4;
-	};
-
-	memory@60000000 {
-		device_type = "memory";
-		reg = <0x60000000 0x4000000>;
-	};
-};
-
-&lpuart4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpuart4>;
-	status = "okay";
-};
-
-&usbotg1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg1_id>;
-	srp-disable;
-	hnp-disable;
-	adp-disable;
-	status = "okay";
-};
-
-&usdhc0 {
-	assigned-clocks = <&pcc2 IMX7ULP_CLK_USDHC0>;
-	assigned-clock-parents = <&scg1 IMX7ULP_CLK_APLL_PFD1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc0>;
-	non-removable;
-	bus-width = <8>;
-	no-1-8-v;
-	status = "okay";
-};
-
-&iomuxc1 {
-	pinctrl_lpuart4: lpuart4grp {
-		fsl,pins = <
-			IMX7ULP_PAD_PTC3__LPUART4_RX	0x3
-			IMX7ULP_PAD_PTC2__LPUART4_TX	0x3
-		>;
-	};
-
-	pinctrl_usbotg1_id: otg1idgrp {
-		fsl,pins = <
-			IMX7ULP_PAD_PTC13__USB0_ID	0x10003
-		>;
-	};
-
-	pinctrl_usdhc0: usdhc0grp {
-		fsl,pins = <
-			IMX7ULP_PAD_PTD1__SDHC0_CMD	0x43
-			IMX7ULP_PAD_PTD2__SDHC0_CLK	0x10042
-			IMX7ULP_PAD_PTD3__SDHC0_D7	0x43
-			IMX7ULP_PAD_PTD4__SDHC0_D6	0x43
-			IMX7ULP_PAD_PTD5__SDHC0_D5	0x43
-			IMX7ULP_PAD_PTD6__SDHC0_D4	0x43
-			IMX7ULP_PAD_PTD7__SDHC0_D3	0x43
-			IMX7ULP_PAD_PTD8__SDHC0_D2	0x43
-			IMX7ULP_PAD_PTD9__SDHC0_D1	0x43
-			IMX7ULP_PAD_PTD10__SDHC0_D0	0x43
-			IMX7ULP_PAD_PTD11__SDHC0_DQS	0x42
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx7ulp-evk.dts b/arch/arm/dts/imx7ulp-evk.dts
deleted file mode 100644
index eff51e113db..00000000000
--- a/arch/arm/dts/imx7ulp-evk.dts
+++ /dev/null
@@ -1,133 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2016 Freescale Semiconductor, Inc.
- * Copyright 2017-2018 NXP
- *   Dong Aisheng <aisheng.dong@nxp.com>
- */
-
-/dts-v1/;
-
-#include "imx7ulp.dtsi"
-
-/ {
-	model = "NXP i.MX7ULP EVK";
-	compatible = "fsl,imx7ulp-evk", "fsl,imx7ulp";
-
-	chosen {
-		stdout-path = &lpuart4;
-	};
-
-	memory@60000000 {
-		device_type = "memory";
-		reg = <0x60000000 0x40000000>;
-	};
-
-	backlight {
-		compatible = "pwm-backlight";
-		pwms = <&tpm4 1 50000 0>;
-		brightness-levels = <0 20 25 30 35 40 100>;
-		default-brightness-level = <6>;
-		status = "okay";
-	};
-
-	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usbotg1_vbus>;
-		regulator-name = "usb_otg1_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio_ptc 0 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_vsd_3v3: regulator-vsd-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usdhc0_rst>;
-		gpio = <&gpio_ptd 0 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-};
-
-&lpuart4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpuart4>;
-	status = "okay";
-};
-
-&tpm4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm0>;
-	status = "okay";
-};
-
-&usbotg1 {
-	vbus-supply = <&reg_usb_otg1_vbus>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg1_id>;
-	srp-disable;
-	hnp-disable;
-	adp-disable;
-	disable-over-current;
-	status = "okay";
-};
-
-&usdhc0 {
-	assigned-clocks = <&pcc2 IMX7ULP_CLK_USDHC0>;
-	assigned-clock-parents = <&scg1 IMX7ULP_CLK_APLL_PFD1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc0>;
-	cd-gpios = <&gpio_ptc 10 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_vsd_3v3>;
-	status = "okay";
-};
-
-&iomuxc1 {
-	pinctrl_lpuart4: lpuart4grp {
-		fsl,pins = <
-			IMX7ULP_PAD_PTC3__LPUART4_RX	0x3
-			IMX7ULP_PAD_PTC2__LPUART4_TX	0x3
-		>;
-		bias-pull-up;
-	};
-
-	pinctrl_pwm0: pwm0grp {
-		fsl,pins = <
-			IMX7ULP_PAD_PTF2__TPM4_CH1	0x2
-		>;
-	};
-
-	pinctrl_usbotg1_vbus: otg1vbusgrp {
-		fsl,pins = <
-			IMX7ULP_PAD_PTC0__PTC0		0x20000
-		>;
-	};
-
-	pinctrl_usbotg1_id: otg1idgrp {
-		fsl,pins = <
-			IMX7ULP_PAD_PTC13__USB0_ID	0x10003
-		>;
-	};
-
-	pinctrl_usdhc0: usdhc0grp {
-		fsl,pins = <
-			IMX7ULP_PAD_PTD1__SDHC0_CMD	0x43
-			IMX7ULP_PAD_PTD2__SDHC0_CLK	0x40
-			IMX7ULP_PAD_PTD7__SDHC0_D3	0x43
-			IMX7ULP_PAD_PTD8__SDHC0_D2	0x43
-			IMX7ULP_PAD_PTD9__SDHC0_D1	0x43
-			IMX7ULP_PAD_PTD10__SDHC0_D0	0x43
-			IMX7ULP_PAD_PTC10__PTC10	0x3	/* CD */
-		>;
-	};
-
-	pinctrl_usdhc0_rst: usdhc0-gpio-rst-grp {
-		fsl,pins = <
-			IMX7ULP_PAD_PTD0__PTD0		0x3
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx7ulp.dtsi b/arch/arm/dts/imx7ulp.dtsi
deleted file mode 100644
index bcec98b9641..00000000000
--- a/arch/arm/dts/imx7ulp.dtsi
+++ /dev/null
@@ -1,461 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2016 Freescale Semiconductor, Inc.
- * Copyright 2017-2018 NXP
- *   Dong Aisheng <aisheng.dong@nxp.com>
- */
-
-#include <dt-bindings/clock/imx7ulp-clock.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-
-#include "imx7ulp-pinfunc.h"
-
-/ {
-	interrupt-parent = <&intc>;
-
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	aliases {
-		gpio0 = &gpio_ptc;
-		gpio1 = &gpio_ptd;
-		gpio2 = &gpio_pte;
-		gpio3 = &gpio_ptf;
-		i2c0 = &lpi2c6;
-		i2c1 = &lpi2c7;
-		mmc0 = &usdhc0;
-		mmc1 = &usdhc1;
-		serial0 = &lpuart4;
-		serial1 = &lpuart5;
-		serial2 = &lpuart6;
-		serial3 = &lpuart7;
-		usbphy0 = &usbphy1;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu@f00 {
-			compatible = "arm,cortex-a7";
-			device_type = "cpu";
-			reg = <0xf00>;
-		};
-	};
-
-	intc: interrupt-controller@40021000 {
-		compatible = "arm,cortex-a7-gic";
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		reg = <0x40021000 0x1000>,
-		      <0x40022000 0x1000>;
-	};
-
-	rosc: clock-rosc {
-		compatible = "fixed-clock";
-		clock-frequency = <32768>;
-		clock-output-names = "rosc";
-		#clock-cells = <0>;
-	};
-
-	sosc: clock-sosc {
-		compatible = "fixed-clock";
-		clock-frequency = <24000000>;
-		clock-output-names = "sosc";
-		#clock-cells = <0>;
-	};
-
-	sirc: clock-sirc {
-		compatible = "fixed-clock";
-		clock-frequency = <16000000>;
-		clock-output-names = "sirc";
-		#clock-cells = <0>;
-	};
-
-	firc: clock-firc {
-		compatible = "fixed-clock";
-		clock-frequency = <48000000>;
-		clock-output-names = "firc";
-		#clock-cells = <0>;
-	};
-
-	upll: clock-upll {
-		compatible = "fixed-clock";
-		clock-frequency = <480000000>;
-		clock-output-names = "upll";
-		#clock-cells = <0>;
-	};
-
-	ahbbridge0: bus@40000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0x40000000 0x800000>;
-		ranges;
-
-		edma1: dma-controller@40080000 {
-			#dma-cells = <2>;
-			compatible = "fsl,imx7ulp-edma";
-			reg = <0x40080000 0x2000>,
-				<0x40210000 0x1000>;
-			dma-channels = <32>;
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "dma", "dmamux0";
-			clocks = <&pcc2 IMX7ULP_CLK_DMA1>,
-				 <&pcc2 IMX7ULP_CLK_DMA_MUX1>;
-		};
-
-		crypto: crypto@40240000 {
-			compatible = "fsl,sec-v4.0";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x40240000 0x10000>;
-			ranges = <0 0x40240000 0x10000>;
-			clocks = <&pcc2 IMX7ULP_CLK_CAAM>,
-				 <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>;
-			clock-names = "aclk", "ipg";
-
-			sec_jr0: jr@1000 {
-				compatible = "fsl,sec-v4.0-job-ring";
-				reg = <0x1000 0x1000>;
-				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-			};
-
-			sec_jr1: jr@2000 {
-				compatible = "fsl,sec-v4.0-job-ring";
-				reg = <0x2000 0x1000>;
-				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-			};
-		};
-
-		lpuart4: serial@402d0000 {
-			compatible = "fsl,imx7ulp-lpuart";
-			reg = <0x402d0000 0x1000>;
-			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pcc2 IMX7ULP_CLK_LPUART4>;
-			clock-names = "ipg";
-			assigned-clocks = <&pcc2 IMX7ULP_CLK_LPUART4>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>;
-			assigned-clock-rates = <24000000>;
-			status = "disabled";
-		};
-
-		lpuart5: serial@402e0000 {
-			compatible = "fsl,imx7ulp-lpuart";
-			reg = <0x402e0000 0x1000>;
-			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pcc2 IMX7ULP_CLK_LPUART5>;
-			clock-names = "ipg";
-			assigned-clocks = <&pcc2 IMX7ULP_CLK_LPUART5>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_FIRC>;
-			assigned-clock-rates = <48000000>;
-			status = "disabled";
-		};
-
-		tpm4: pwm@40250000 {
-			compatible = "fsl,imx7ulp-pwm";
-			reg = <0x40250000 0x1000>;
-			assigned-clocks = <&pcc2 IMX7ULP_CLK_LPTPM4>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>;
-			clocks = <&pcc2 IMX7ULP_CLK_LPTPM4>;
-			#pwm-cells = <3>;
-			status = "disabled";
-		};
-
-		tpm5: tpm@40260000 {
-			compatible = "fsl,imx7ulp-tpm";
-			reg = <0x40260000 0x1000>;
-			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
-				 <&pcc2 IMX7ULP_CLK_LPTPM5>;
-			clock-names = "ipg", "per";
-		};
-
-		usbotg1: usb@40330000 {
-			compatible = "fsl,imx7ulp-usb", "fsl,imx6ul-usb";
-			reg = <0x40330000 0x200>;
-			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pcc2 IMX7ULP_CLK_USB0>;
-			phys = <&usbphy1>;
-			fsl,usbmisc = <&usbmisc1 0>;
-			ahb-burst-config = <0x0>;
-			tx-burst-size-dword = <0x8>;
-			rx-burst-size-dword = <0x8>;
-			status = "disabled";
-		};
-
-		usbmisc1: usbmisc@40330200 {
-			compatible = "fsl,imx7ulp-usbmisc", "fsl,imx7d-usbmisc";
-			#index-cells = <1>;
-			reg = <0x40330200 0x200>;
-		};
-
-		usbphy1: usb-phy@40350000 {
-			compatible = "fsl,imx7ulp-usbphy", "fsl,imx6ul-usbphy";
-			reg = <0x40350000 0x1000>;
-			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pcc2 IMX7ULP_CLK_USB_PHY>;
-			#phy-cells = <0>;
-		};
-
-		usdhc0: mmc@40370000 {
-			compatible = "fsl,imx7ulp-usdhc", "fsl,imx6sx-usdhc";
-			reg = <0x40370000 0x10000>;
-			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
-				 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
-				 <&pcc2 IMX7ULP_CLK_USDHC0>;
-			clock-names = "ipg", "ahb", "per";
-			bus-width = <4>;
-			fsl,tuning-start-tap = <20>;
-			fsl,tuning-step = <2>;
-			status = "disabled";
-		};
-
-		usdhc1: mmc@40380000 {
-			compatible = "fsl,imx7ulp-usdhc", "fsl,imx6sx-usdhc";
-			reg = <0x40380000 0x10000>;
-			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
-				 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
-				 <&pcc2 IMX7ULP_CLK_USDHC1>;
-			clock-names = "ipg", "ahb", "per";
-			bus-width = <4>;
-			fsl,tuning-start-tap = <20>;
-			fsl,tuning-step = <2>;
-			status = "disabled";
-		};
-
-		scg1: clock-controller@403e0000 {
-			compatible = "fsl,imx7ulp-scg1";
-			reg = <0x403e0000 0x10000>;
-			clocks = <&rosc>, <&sosc>, <&sirc>,
-				 <&firc>, <&upll>;
-			clock-names = "rosc", "sosc", "sirc",
-				      "firc", "upll";
-			#clock-cells = <1>;
-		};
-
-		wdog1: watchdog@403d0000 {
-			compatible = "fsl,imx7ulp-wdt";
-			reg = <0x403d0000 0x10000>;
-			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pcc2 IMX7ULP_CLK_WDG1>;
-			assigned-clocks = <&pcc2 IMX7ULP_CLK_WDG1>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>;
-			timeout-sec = <40>;
-		};
-
-		pcc2: clock-controller@403f0000 {
-			compatible = "fsl,imx7ulp-pcc2";
-			reg = <0x403f0000 0x10000>;
-			#clock-cells = <1>;
-			clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
-				 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
-				 <&scg1 IMX7ULP_CLK_DDR_DIV>,
-				 <&scg1 IMX7ULP_CLK_APLL_PFD2>,
-				 <&scg1 IMX7ULP_CLK_APLL_PFD1>,
-				 <&scg1 IMX7ULP_CLK_APLL_PFD0>,
-				 <&scg1 IMX7ULP_CLK_UPLL>,
-				 <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>,
-				 <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>,
-				 <&scg1 IMX7ULP_CLK_ROSC>,
-				 <&scg1 IMX7ULP_CLK_SPLL_BUS_CLK>;
-			clock-names = "nic1_bus_clk", "nic1_clk", "ddr_clk",
-				      "apll_pfd2", "apll_pfd1", "apll_pfd0",
-				      "upll", "sosc_bus_clk",
-				      "firc_bus_clk", "rosc", "spll_bus_clk";
-			assigned-clocks = <&pcc2 IMX7ULP_CLK_LPTPM5>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>;
-		};
-
-		smc1: clock-controller@40410000 {
-			compatible = "fsl,imx7ulp-smc1";
-			reg = <0x40410000 0x1000>;
-			#clock-cells = <1>;
-			clocks = <&scg1 IMX7ULP_CLK_CORE_DIV>,
-				 <&scg1 IMX7ULP_CLK_HSRUN_CORE_DIV>;
-			clock-names = "divcore", "hsrun_divcore";
-		};
-
-		pcc3: clock-controller@40b30000 {
-			compatible = "fsl,imx7ulp-pcc3";
-			reg = <0x40b30000 0x10000>;
-			#clock-cells = <1>;
-			clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
-				 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
-				 <&scg1 IMX7ULP_CLK_DDR_DIV>,
-				 <&scg1 IMX7ULP_CLK_APLL_PFD2>,
-				 <&scg1 IMX7ULP_CLK_APLL_PFD1>,
-				 <&scg1 IMX7ULP_CLK_APLL_PFD0>,
-				 <&scg1 IMX7ULP_CLK_UPLL>,
-				 <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>,
-				 <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>,
-				 <&scg1 IMX7ULP_CLK_ROSC>,
-				 <&scg1 IMX7ULP_CLK_SPLL_BUS_CLK>;
-			clock-names = "nic1_bus_clk", "nic1_clk", "ddr_clk",
-				      "apll_pfd2", "apll_pfd1", "apll_pfd0",
-				      "upll", "sosc_bus_clk",
-				      "firc_bus_clk", "rosc", "spll_bus_clk";
-		};
-	};
-
-	ahbbridge1: bus@40800000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0x40800000 0x800000>;
-		ranges;
-
-		lpi2c6: i2c@40a40000 {
-			compatible = "fsl,imx7ulp-lpi2c";
-			reg = <0x40a40000 0x10000>;
-			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pcc3 IMX7ULP_CLK_LPI2C6>;
-			clock-names = "ipg";
-			assigned-clocks = <&pcc3 IMX7ULP_CLK_LPI2C6>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_FIRC>;
-			assigned-clock-rates = <48000000>;
-			status = "disabled";
-		};
-
-		lpi2c7: i2c@40a50000 {
-			compatible = "fsl,imx7ulp-lpi2c";
-			reg = <0x40a50000 0x10000>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pcc3 IMX7ULP_CLK_LPI2C7>;
-			clock-names = "ipg";
-			assigned-clocks = <&pcc3 IMX7ULP_CLK_LPI2C7>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_FIRC>;
-			assigned-clock-rates = <48000000>;
-			status = "disabled";
-		};
-
-		lpuart6: serial@40a60000 {
-			compatible = "fsl,imx7ulp-lpuart";
-			reg = <0x40a60000 0x1000>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pcc3 IMX7ULP_CLK_LPUART6>;
-			clock-names = "ipg";
-			assigned-clocks = <&pcc3 IMX7ULP_CLK_LPUART6>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_FIRC>;
-			assigned-clock-rates = <48000000>;
-			status = "disabled";
-		};
-
-		lpuart7: serial@40a70000 {
-			compatible = "fsl,imx7ulp-lpuart";
-			reg = <0x40a70000 0x1000>;
-			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&pcc3  IMX7ULP_CLK_LPUART7>;
-			clock-names = "ipg";
-			assigned-clocks = <&pcc3 IMX7ULP_CLK_LPUART7>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_FIRC>;
-			assigned-clock-rates = <48000000>;
-			status = "disabled";
-		};
-
-		memory-controller@40ab0000 {
-			compatible = "fsl,imx7ulp-mmdc", "fsl,imx6q-mmdc";
-			reg = <0x40ab0000 0x1000>;
-			clocks = <&pcc3 IMX7ULP_CLK_MMDC>;
-		};
-
-		iomuxc1: pinctrl@40ac0000 {
-			compatible = "fsl,imx7ulp-iomuxc1";
-			reg = <0x40ac0000 0x1000>;
-		};
-
-		gpio_ptc: gpio@40ae0000 {
-			compatible = "fsl,imx7ulp-gpio", "fsl,vf610-gpio";
-			reg = <0x40ae0000 0x1000 0x400f0000 0x40>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&pcc2 IMX7ULP_CLK_RGPIO2P1>,
-				 <&pcc3 IMX7ULP_CLK_PCTLC>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc1 0 0 20>;
-		};
-
-		gpio_ptd: gpio@40af0000 {
-			compatible = "fsl,imx7ulp-gpio", "fsl,vf610-gpio";
-			reg = <0x40af0000 0x1000 0x400f0040 0x40>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&pcc2 IMX7ULP_CLK_RGPIO2P1>,
-				 <&pcc3 IMX7ULP_CLK_PCTLD>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc1 0 32 12>;
-		};
-
-		gpio_pte: gpio@40b00000 {
-			compatible = "fsl,imx7ulp-gpio", "fsl,vf610-gpio";
-			reg = <0x40b00000 0x1000 0x400f0080 0x40>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&pcc2 IMX7ULP_CLK_RGPIO2P1>,
-				 <&pcc3 IMX7ULP_CLK_PCTLE>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc1 0 64 16>;
-		};
-
-		gpio_ptf: gpio@40b10000 {
-			compatible = "fsl,imx7ulp-gpio", "fsl,vf610-gpio";
-			reg = <0x40b10000 0x1000 0x400f00c0 0x40>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&pcc2 IMX7ULP_CLK_RGPIO2P1>,
-				 <&pcc3 IMX7ULP_CLK_PCTLF>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc1 0 96 20>;
-		};
-	};
-
-	m4aips1: bus@41080000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0x41080000 0x80000>;
-		ranges;
-
-		sim: sim@410a3000 {
-			compatible = "fsl,imx7ulp-sim", "syscon";
-			reg = <0x410a3000 0x1000>;
-		};
-
-		ocotp: efuse@410a6000 {
-			compatible = "fsl,imx7ulp-ocotp", "syscon";
-			reg = <0x410a6000 0x4000>;
-			clocks = <&scg1 IMX7ULP_CLK_DUMMY>;
-		};
-	};
-};
diff --git a/arch/arm/mach-imx/mx7ulp/Kconfig b/arch/arm/mach-imx/mx7ulp/Kconfig
index e8cb58bc89f..eac3a2ad6af 100644
--- a/arch/arm/mach-imx/mx7ulp/Kconfig
+++ b/arch/arm/mach-imx/mx7ulp/Kconfig
@@ -35,6 +35,7 @@ config TARGET_MX7ULP_COM
 	select SPL_SEPARATE_BSS if SPL
 	select SPL_SERIAL if SPL
 	select SUPPORT_SPL
+	imply OF_UPSTREAM
 
 config TARGET_MX7ULP_EVK
 	bool "Support mx7ulp EVK board"
@@ -42,6 +43,7 @@ config TARGET_MX7ULP_EVK
 	select SYS_ARCH_TIMER
 	select FSL_CAAM
 	select ARCH_MISC_INIT
+	imply OF_UPSTREAM
 
 endchoice
 
diff --git a/configs/mx7ulp_com_defconfig b/configs/mx7ulp_com_defconfig
index a49cb2a728f..d63168fe886 100644
--- a/configs/mx7ulp_com_defconfig
+++ b/configs/mx7ulp_com_defconfig
@@ -7,7 +7,7 @@ CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx7ulp-com"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx7ulp-com"
 CONFIG_LDO_ENABLED_MODE=y
 CONFIG_TARGET_MX7ULP_COM=y
 CONFIG_SYS_BOOTM_LEN=0x1000000
diff --git a/configs/mx7ulp_evk_defconfig b/configs/mx7ulp_evk_defconfig
index 98b99dd78e1..6a42acc16ef 100644
--- a/configs/mx7ulp_evk_defconfig
+++ b/configs/mx7ulp_evk_defconfig
@@ -6,7 +6,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx7ulp-evk"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx7ulp-evk"
 CONFIG_TARGET_MX7ULP_EVK=y
 CONFIG_SYS_BOOTM_LEN=0x1000000
 CONFIG_SYS_LOAD_ADDR=0x60800000
diff --git a/configs/mx7ulp_evk_plugin_defconfig b/configs/mx7ulp_evk_plugin_defconfig
index af0efbd3ebf..148b706d17a 100644
--- a/configs/mx7ulp_evk_plugin_defconfig
+++ b/configs/mx7ulp_evk_plugin_defconfig
@@ -6,7 +6,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx7ulp-evk"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx7ulp-evk"
 CONFIG_TARGET_MX7ULP_EVK=y
 CONFIG_SYS_BOOTM_LEN=0x1000000
 CONFIG_SYS_LOAD_ADDR=0x60800000

---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260430-7ulp-13563ce4c88e

Best regards,
--  
Alice Guo <alice.guo@nxp.com>

