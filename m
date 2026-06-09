Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B11CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:20:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9958C84894;
	Tue,  9 Jun 2026 09:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eoiW2tXA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E020380087; Tue,  9 Jun 2026 09:19:28 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F043F84825
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8l9tPlp3v5OCRwOmsgNKpoknL+hk1SUdl/VrqLJ/ZGWsO9rfSYLtbNJjx8q+ixLVUF4IoXm7rV2Q4JH/dDv+YC/HXxODpzlXDwDgrsZAsxkwjZdfkcU7p0soGMl0d0+ZnDQ7j63s1ElUtbPAT3qGQ2Fyappe8W6rtSCFzIDLZMTjWVO2Oyga4toM/LXjkdRT2JaMqrMZqZNJ17fW3HFMSpWTleVy5cWPu3p6/5VDTn7oAiaAD78AwF8Aei1D1EzcIrDWrlOwGEtoVtyBA7Z9Z470UHtzOlIqaQ1UlG+h1j3YfgMrvu9yz2LQRicWvRNp3OSiprgaR9sh/gDB48W4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jj4fyBX4Yqnd4NJjAvrNv1q7CMrhCxdMVgbKj6176Ak=;
 b=ha6uQ3KytIEalR9+X0auNhd3RuoIDITCwhdBQU8GbYpIBN9SfJJIkHs095dm7vdRGb8r+ZDscH+mM+uLE6Nt9IR764wZDnEGsguez+D46RzxnJ61b+3RRmEB/opAoDWmyt1CvE6Bev9DJDX8St4vcVP76EMYB5fBhTjp/qD1uNa1Nae+bxGOA3zH0HzVKVkzORlWtpHlV+L44jv9RyP0tpG/wCXeSuWDxUvRRrHn4IGUxdAjabv81B7PUAFdS/N3PLi2hLHMiey1mAxRH78aZzcqPjtocliqW/hHQKHJNQCM3kaIH1Ixak+j4NZjI3Q8xflB4CrPNhC8kBnlJtYNZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj4fyBX4Yqnd4NJjAvrNv1q7CMrhCxdMVgbKj6176Ak=;
 b=eoiW2tXAaPwluQsK5RDBfPyON350EHGQCjFvFt+u5nlg3NOLVfExCW1ubthZuSqAKMLIBjvrFiL02kLaYI2OIODSkV1FWjXjdNX/yl14cnHEyKTgAnxTGgIygZeAKeflrj5NCLmtDs3EWL58enscJUBvRizoTKLnxU+q63SE1mrvBvI5yoBVA62Msp6JNqZ6uWg1I7Pf5UmeVZBWCAjmqi8v5xgJOsPBE1PWc16frTUTHr/Phu9GmfpNdyXsB738J6SUxw1I5Nbzk7f5d8CQwMS/GlLJtlwnUWzDkoRtYIDRPvMP7BmoJyQZAm8YKnORXYIVoNOrZ8MvDlaC8TQ8Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB8755.eurprd04.prod.outlook.com (2603:10a6:20b:42e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 9 Jun
 2026 07:19:23 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 07:19:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 09 Jun 2026 16:36:22 +0800
Subject: [PATCH v2 05/13] imx7ulp: cleanup get_imx_type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-imx-misc-v2-5-58e1665d55ae@nxp.com>
References: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
In-Reply-To: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::10) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS8PR04MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bfef142-6cac-4155-d27d-08dec5f76e6d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|19092799006|366016|376014|1800799024|22082099003|18002099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: VRYayLZNziD73tDLCky2QQi329fprFymA42YLkuv3UPR9QAHloSTJMVVb/nYWr02zDbG26wXWf0JARR2P03qK2bgHOTYBpOnEY0EoborFnZVs66pP+c77Rfqt615hq9ajTMIClaFe9yzl3YO2zny4CPIa5Fxh6GmEvPbigRTVvK40qlv8H4hlcBOghM9it/XDlNR/b2XEOpx6yLJ3Gai5gXg+nVVpRIW2vJPbeVDh5a/mdzVtwiTfA92AtxWt2ujpo/Fa/s4M2JiQAOu/BBXJ0uDeGHuzjQRMdquIqtB9F9Fp3TV9pr1JAiIvzAFREYxGVgWBjQd+DYe6xqWZ0hZ3aVS9VgjSiT1OQGvIOGNk1hASjcQpsdthH1Rwhz8IzYfzPHY8F/DdT9Bwn4N2JjvVIZJxNxLscRAZEzYCqmk3Qhfyn0s1z2pheYCR6E2zXpbjhmcNHev86mMvUM0aYHJW6Fviz4Z2ZimXAE0H520IScEI/LDTfbXMUy6OiFNN4KoF228H0ZQM6D6avpIkpOduhWKDFeAuz0E0jmM/HPys6DWIJfI3w2JejZUs9AakZIJYDvt2zCy30j8En97WEK/jI5m3E9gcIV7QZfa+uP4V9nE/9CeQqZOUN1BVyTnmcdMv8j7MS78+RdP2DAGKAbKoMAH4+wE29THwK+CuCAFhT9a/bWmKnCGadgw9f+elYNhFVzGYpgqOYXRjE2BqEueySEjvx/wzaDIdimjAyMTOpMRdeYh3fyNJTxj7WdSBJnI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(19092799006)(366016)(376014)(1800799024)(22082099003)(18002099003)(38350700014)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek8wa0lCSnZiTGdLZ0ljRktzdEJtTytaTFRRb2V0ZktJS3hCclUrYytZTDVx?=
 =?utf-8?B?TDN3M1krVklCelROY3FGQWhSZkpEd1h5OHE2b0V0ajlwQTRzSjFPNGl3TG9j?=
 =?utf-8?B?cmtBRXlhbTFPd1hiTXNnS2RPNi9OUkk3UmVTcjJXUFJ3STZ6ODdNZDEvcUln?=
 =?utf-8?B?S1RpQzltdFVIUU1hL3FPZXk2ajlaa1dUbWJWSEl0ZytyekhMd0dtencrU1pY?=
 =?utf-8?B?ZU90N2F5elI5eHFiUzFSWDJtUTBrUThLVFVEbjhQWEZ1TTdDaERuL0FIZWxV?=
 =?utf-8?B?dXFIZ01WTGFOOHlMQlJNanBZbDZJMFd0QWp6M09ZaE9UVTR0ZGt2ZU1JbHMy?=
 =?utf-8?B?bDBFUmRXajZGLzM2NFBFTWRTYnBDVjhablh1NVNHcDhxcm5BOVRINFluUU90?=
 =?utf-8?B?VHE4SUVYWmw5NW5lRWxDekpYVm1oSVZoTjRneWJhYVhISWhINXlnTE9LZ1R6?=
 =?utf-8?B?Q00vY25UYlBsTVdFdnJGMklzQ2E3anVmU0pRREhtb0swaW16eEJIR0RsYzlk?=
 =?utf-8?B?NXVLenN3ZXQ5L2hIVEV0UGo5Qi9CNG90R2NPSXZnNFpEVUY5M3hPdFhxY1hr?=
 =?utf-8?B?RzRVNnYzTWNlcFpzOURKemNkalBRbE1RNVdKcTdmMERGbXRjNzN1ZWFqQmlZ?=
 =?utf-8?B?dDlUT1dCSFR5NUV1U3dGUTUxYXVwV2JUbis1VjVKY1RLSnBrR256ZVNZNXB0?=
 =?utf-8?B?MHNPKzNsNWkzUW9iNHNsWlRGNWlzTDkwRHZvK1huYnJXeXFSSjdqb2hTSkF5?=
 =?utf-8?B?ZFNNVWV4alNSdWh4bkk2d1RhSytlRDQrZmE3UllVNkVXb1Z6Ri81NjNmaTlV?=
 =?utf-8?B?SW55WmpETjVMQ3d5Sk0yWHZhdVhvQVg3QUNIR3QyRlZxL0d6SGs4Z0wyRDlv?=
 =?utf-8?B?em5GUmIydVNzb2Z1ZEdqaG0wSmszS0o1cE03bkkvOStVTnRMWjBaTHNobnU4?=
 =?utf-8?B?L1R2aFdSRE9vM0V0aUxENXRISnRCOUxmSjREYThZWVRBbGpJMWhxb3N6SUN0?=
 =?utf-8?B?anh3bEIyVFd4OWp5d3hodndQVmpDVkpiTmJsakVQanY2Ym02Q0diMmVzRjBJ?=
 =?utf-8?B?WjdpbDNDd3F3NWM0eFdjS05aVjB0YzZTYU9ZYWxjanNTNUY4UVpRLzVZN0JG?=
 =?utf-8?B?TE1OMzV4aXVXY0lhWnNMVGlrTVNnNmlmUXlHeDdaVFJZVXlLeG5tWTBaakNs?=
 =?utf-8?B?NFlnc3NGd1VVaGN3YzNiZHNSOFNPaGVZbC9QSUllTWhFNktvazk0Sjg1QWxs?=
 =?utf-8?B?ZDA1Z2dwaVZHaDI0WDVqODgzS1JKVGtOMEY4VnZ0UGpJekdRUTB4QWs4aWFi?=
 =?utf-8?B?SFprZXR2QkQ4bWRiWklvNmtDL2dWUit0eFhnVnc4dlhiZW1Ua1d3NjV0cTM4?=
 =?utf-8?B?NVlrYkpzZUlCVFN0dFkvUHE5c0RncWZ0T2hGS1F4Zk00NlpqM3JkbFBTUHdR?=
 =?utf-8?B?MlZMSmhnVnVpa09sOFZTNTBNMWhlMFdSTUpVQUNzLzJDY3hqL1g3VnpZYnFJ?=
 =?utf-8?B?dkwrelZMMGtRbnNxSHNVTGhidU0wbWYxNXYwVDB1WUFFamVha2RsYTFxSDd5?=
 =?utf-8?B?MmFRZ2pKYXlrWm1DaWdER1MyY3lGNFc5S1huL2p5UjRuMFlCTktINmxnc0NP?=
 =?utf-8?B?SVMraEk2UmUyVGx6cXFaWVI0QkpVUFAvSFNreEtXQmxhU3U0c2ZnbFNyL2xY?=
 =?utf-8?B?WlQxUHY3QWdadWg2NXVyYnNDWjVsTVFDUVNuZFJXaHRSVm43b0d5Z0ZyOFgx?=
 =?utf-8?B?OHJnRVFwWDNiQm1uRzk1NWlTbmdzaVFsRmFMcW9GcGR2K3c2RHcxUUlpcFpU?=
 =?utf-8?B?RXNQUTJGSkx3bmEzUDdNRG5Ta0FUZlBWNHMwVHc1STN4bDhPRVZtQU50VENX?=
 =?utf-8?B?MEcrZzEyUTY2cEc5VnN4bFdWMHIwSE82Y01VVzVhRE52TksxcEw0bWZqVTVz?=
 =?utf-8?B?dWwreXVRSHhUV2IyZmcrSGMzUDRzcFhOMTNxb2lmWENkVlRtMk5QU0hzWXl3?=
 =?utf-8?B?cWx0V2tROFRZcGJnalBGdTQ3cXVJa3A1YU1uZ1AzSHZKMzB0eXFvcmYvc0hy?=
 =?utf-8?B?bzRaVm9jdU9RWVpXS3dvMEo2UTZuakZuc2hIeDI2bUZTRWhJVm4zSXIwQlQv?=
 =?utf-8?B?aUZoc0FLb3RabVViNGJIOGdhTnJqalNVZmEzVmlqVkdKUTdBbGNtdHNrcXdy?=
 =?utf-8?B?THJwOEhCbVlUK0F0eVQzRThKTElxam5TU2ZvN2lYS0tpbEJzdzFLSiszcS8z?=
 =?utf-8?B?SVJSazhUekpmZGpSczNVNjlTMk5zcWFROHBWWUVwUGFSZDdFU0pvTUY2MzNC?=
 =?utf-8?B?bEdweExNdVNVSS8xTVF0RTl5Vk0xWUNqWndCK1ZrQUp4SnBQTFR3QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfef142-6cac-4155-d27d-08dec5f76e6d
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:19:23.4025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzbNzUT+ofrVhOace4dpFpZru0IvCtftIAJFsh7qADp5Z2C8qN3a84sUZCBKrYhJCC05X/W2kTPcx+pVw+JC9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8755
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

There is only one SoC and no external user of get_imx_type for i.MX7ULP,
so directly embed the string in print_cpuinfo and drop get_imx_type().

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/mx7ulp/soc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-imx/mx7ulp/soc.c b/arch/arm/mach-imx/mx7ulp/soc.c
index ca1cf759fe1..1dd350cf50e 100644
--- a/arch/arm/mach-imx/mx7ulp/soc.c
+++ b/arch/arm/mach-imx/mx7ulp/soc.c
@@ -259,11 +259,6 @@ void reset_cpu(void)
 #endif
 
 #if defined(CONFIG_DISPLAY_CPUINFO)
-const char *get_imx_type(u32 imxtype)
-{
-	return "7ULP";
-}
-
 int print_cpuinfo(void)
 {
 	u32 cpurev;
@@ -271,8 +266,7 @@ int print_cpuinfo(void)
 
 	cpurev = get_cpu_rev();
 
-	printf("CPU:   Freescale i.MX%s rev%d.%d at %d MHz\n",
-	       get_imx_type((cpurev & 0xFF000) >> 12),
+	printf("CPU:   Freescale i.MX7ULP rev%d.%d at %d MHz\n",
 	       (cpurev & 0x000F0) >> 4, (cpurev & 0x0000F) >> 0,
 	       mxc_get_clock(MXC_ARM_CLK) / 1000000);
 

-- 
2.51.0

