Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F071048922
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 01:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37FC483F20;
	Sat, 28 Feb 2026 02:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gALGbJrf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8853B83F20; Sat, 28 Feb 2026 02:43:57 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5883683F64
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 02:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrxT7hS2eAuRjbU7rNCzkysH5vPxcI7f55OaZvXVFePvqiCCsHU+dY6qqViletXgU6iGrfkUT9EajA/MY+O+aL2z2IpwImydSMYt2l/uaHLBiqcYfvr3pt6zZESp1I6psjLxdymALYF36ApzgHzX1ew2hUxIRBB89w9IVWB8L8ec/4g5W6T3m5xKR+0U2EsThbAKwV03IuGi9fceWBRvPqq8zfaeg1brLVlJKUNuuA5u8IYuVIMBZYyhK/k7/0vwKsQTp2Fh5jfcVy7maPgto6IWvuP7O+T5xnVeYoUHqfSpb5P8bQbXRgR08rit/kVFFMzYiUeJedrpPP/BrfSMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6mZFsTDkOmWw5ZXKLEd3Dc82106Ug9mOfgKUSzt5cE=;
 b=vVB7hSAKQH3gxoOmtcWEURqsHGW6Jwslb5Dn/+4Hqd64pVFwrV6O1NQtU7UyKePwZKh2LnkzhSIAy8K9bvQkSVhuDFexjDyzz1Y5LkXq/zjE0QS5wNB0ItkAGpML0cZaVHI1Fg4gfqcZxi3BnP/5bJ9zRo8u6q8OVsVrXsWPaDbiBqD7LkjfvMIuwnu/DJWBuIpnmEAA3yVAJJ70M3uBhXQIF0YdBNVBfxU0ePDW9G5wMjfbSoopKY8DM0oDQkVYt8HusWVFnGRymyKcpaJZfoTofUJeWc/TEU4gIznMuRztfzP0du31YKNHgieD90bI3bXua0lRpynVJ9H47c+8wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6mZFsTDkOmWw5ZXKLEd3Dc82106Ug9mOfgKUSzt5cE=;
 b=gALGbJrfmiBHOn2i+GOEcxWtAOVIEaOUuWUtGEs+iPyPchcOxsJ4NrrXIPF/xA+dzAqCjqenrW9RfrVX9HjeaIACJ0Uw/JIhgRe/Ze50PcAqj71foaxn42FbGOwh0PHorLlPgdxG96a4RABQCp7Z8PcE4TueIWQ+Cxm43miiYZ/QmObBDEHdxbB5PISeP/oqL0JWf7OiEs92qP1hljug/nQZpFVB1rK1mf3hpuNsx8M9rJ3YnMpXr/3pFh635mKMbMPem997zbcoO0pYmYYtlRTH3OoSWxvQWRQo+ARBRv343x+9WWIyN7TBYWT3jilJh5KkcDcG87sI5WMMDmJ7lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by MI3PR04MB12440.eurprd04.prod.outlook.com (2603:10a6:290:75::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 01:43:51 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 01:43:51 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 28 Feb 2026 08:22:27 +0800
Subject: [PATCH v2 09/13] arm: imx9: Skip WDG3/WDG4 disable on i.MX952
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-imx952-v1-9-0a360e7e8cb7@nxp.com>
References: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
In-Reply-To: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jacky Bai <ping.bai@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Jindong Yue <jindong.yue@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|MI3PR04MB12440:EE_
X-MS-Office365-Filtering-Correlation-Id: f56cf726-f8e0-41f7-8059-08de766ad2d9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: dwqbbtX4zOvkWtCTNA+SX9XHrZEngVgA63fqTRzOoh6qOAAqtyKgedvWSWhJHTiSsjstm8Nm8M91HFALiEUc4s88n5ipPOudBeJ+ImR+X2uhwW1GBmbhZbcp16VHSWKTUWJbqcejV0UihDFQCla4L85YnqNs9zaPlJqohVxlyV9kqT2FCVsTFmA8CklvzFuY2RR4vI2AR8e6QhpUZulsXjF7OnbIJXbZBb5JFWhIRWEfMIksv5U0sV+pwAisbpY7wiC2DbDKvJtFbaJMLycuJSnqytErkASHWKSdOFvgVwQVaiJw3N84/7TAAh6rC/xbGGRYiB+CAlmtVAs7/yroHK9Y9T6w4j1hgsjZJ6auKdLPpyY2uRj5S38JqBMzQQd+Y3NqxzyDBn04jcUO+iCK1n/BXZ+owpf2T7x3yvV891VSlM7cAI28VbLmQ0Fs7dp/AHGRR82pGFuntiOQ7ovv4PcUxghlQ6IQDjvsxnMO9VtQHwapQ02mG6Ik2LeDsnm1AEe0uHWk+g0AFkvkAVN2+0Aw1u09R42fXmhKybDrEHCNiA8qmsUny86nm92e4aotfZ+rPkkxl1ZuzT6Kl8TKhvBxOBIoBWSoEWv04uQiAemw66Ne91VENOqxc9wrov1okBWW3MDmCddApilnX25u8gzJhgisxT8bH2o5RRcOQBY1wtijW5sqi04Ca6nz5E2XZKr1tDnw5R76h3xSOLcmIYZBLbATfwMJ46IeKbwivc9EwARZti58UHv3wwqQxermNHH/FXvKe6wnnCD+6OnTngY+xKb/ezz3r/trp08kncY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVRBcm1oQ29aREdVZE1PR1krYm14NXNCNFpLZXgyU0pqVmZHc0VxeUxIR1h4?=
 =?utf-8?B?THV4ZGNDRHBWMTdkT3dpb3hWamlYT1d5RTI0RHR5WVlJRXNndVhVamY0YWJa?=
 =?utf-8?B?TW1pYzJ3RmZvcmxFeFRKUDlqdHBWZC9qRzB5eVNwVG9MRm15S05qZGFIYnhy?=
 =?utf-8?B?MjNPTy9Oa1A3Zkp5T3NSaVVBenBtUmlMYlovb2tLQWVtd3dQaE1YM2dQNUxx?=
 =?utf-8?B?d0g0ZEZpdC9jSi9aL1JHZyszTzcvanh3cW10aVVBSXNMR213T21wWnZtSUpa?=
 =?utf-8?B?cXExRVE3bGVsZlRoNWR0TDdzSkUyeGJmenJhMHVTWklocVZUN2txSE16enVt?=
 =?utf-8?B?Nk1ETlFHQUtqc3Nvd3ZzazVGbkdBcXhTVHBmOGZpVW9KcGxnNUljeWNEUFIx?=
 =?utf-8?B?dHhiWTUzK3I0L1poQ0wvQXNVV3YwMGVaeVp4L2QrNVFna0RjWlpLYkJqcjc5?=
 =?utf-8?B?YitBNnRYaFBFb241STVQVzA2YVlwYlRjNjFScUlnOGhMSG9DbVJuUDh3bGdy?=
 =?utf-8?B?a2J2b0tBRnl0bW9HZkU0V1RCeSszczc3cDdwazdpNDg5WGlxNDBMOHhBTHRD?=
 =?utf-8?B?UG56YTVjaEgvZUdFN2VJeTIzczFKQmkyQkdDeHYvZGwwbndaZzA3UkRVZ3lx?=
 =?utf-8?B?V21ubGE5SGVFRy9UR3dKVU5RektoQktEVUlvUWliZlpmQ0VBOVJRa1ptYU9R?=
 =?utf-8?B?eS94S2cwZ29qRmt3MHMxOXpETVRYMUpCOCtnSUdBQXhhK2dHWHhSODREenVw?=
 =?utf-8?B?eVp1YmxWeXV2bG1oZitRQzVZUVpMclNLUkpHUk5DWDZZVnFDdThQWTl5bUpH?=
 =?utf-8?B?d25iMmlXcE1hekJSMlAxcW9pT2RTSXJHQ3N6NzFCdTdnWVUwbnZicU9LZEpk?=
 =?utf-8?B?Y3IzWDBVU3d0S3cvTGVReTdTSEQ3QTRuSjQ5djJlNlNUckx5elFDTXlXb0ZD?=
 =?utf-8?B?QUpkMUFScXZoM0JjSXFHVUVxcUR4MkRRSWRRb2JzVjlTNGw2QVV2NFUvMSt2?=
 =?utf-8?B?MzAzNUpEVy9FdlVEZ0dJZ2x2Mk0wSWg3WGRPNGp3Tk5laWVDR1hVR2JhSk9T?=
 =?utf-8?B?SDFzTGZrbHFqOEZQVnNsNnNjUERBeHgwZlRVN2dGeTdxYnVmNVdiUkVMQTh4?=
 =?utf-8?B?cG8wRzllOVg2Z1gxOGdjenhwNkVUVkJIOCtwN3p1M2FxVmYzaE8wUFQyMWVJ?=
 =?utf-8?B?YnRJY1RqZVlUTmpnWGhIYytjVGxWUlphVzZWOFZDRUs4QVBuak5nazR6UnBK?=
 =?utf-8?B?ZVQ4ZjVEalZLK3JVYlRDZVRxYmY0dlZia3VxVC9ZSFBha1pkRjlDUmZVeXhK?=
 =?utf-8?B?azRaSzFEK203RElsMnBqdGQ0UzhLRWNQSWZGYlVKTG5ZclZBMmhLdEJpbDVG?=
 =?utf-8?B?dkpvUFJTYktZQnQzOVpPcjFYaE54eXdhTGk1Zkt1Z1Zod2lxZEJlSXphRWVL?=
 =?utf-8?B?am0velpPSFV4WmFRNjdJYmtOUjBQck93bEk1ck8zcjRGQnBsVEdYZmwrMkdC?=
 =?utf-8?B?K2dRYzQvVnBjK3I5MnBCbDNLQnBQRHNtbVBGY3hwNjBnY1Q2YlloN3J4MXNR?=
 =?utf-8?B?Um9TcjZYZjRVK1JuaDVpeU9wNHZ0MmZSN2VFamlEUkdKQzRFQThsajN6RytT?=
 =?utf-8?B?L21UYUFKODZWTFpERDR3YklkcE5LVVkvcmVQT0M2b2NLdXpwTitJUGxBVEpI?=
 =?utf-8?B?OVY5UDhQa0FXSUY0azN1VEFlTFFMZDg5MmVDcElGTkFKSUhSb01ISUw0VmNt?=
 =?utf-8?B?a1BhZ0t4TjZyU0NWL1RqREdpZjRuR0RSY1lEait1S3dJK1RZeDgwdlV3MCtP?=
 =?utf-8?B?Y0dNZHB0NHFLQzdEeFBMYmJsUUlGZWl4UlJPMlZOR0JtVEo0M2dyVFVrZFIz?=
 =?utf-8?B?ald0SXZMWXdTNjViRkxBY1VQeStiR0dqK3lhOFhPTU9ZZXA0ZDRHWDU2YWF4?=
 =?utf-8?B?MmNRejl1TGdIb0NsYTF5NVphSnhtM29XSTVZckl4OWxQSm1jQUJRZEhYQmtr?=
 =?utf-8?B?WmRBNldtdkh0SnQ4ZzZlRkJuY2hmNnM2djBHU0lwNWJvTWJBTnhiWnpEbmpj?=
 =?utf-8?B?VGJPTm1Ya0RVU2pBN1FUamUrOUZVNDNqMGx4VmF6YTRkTk1tMmozVTlpVlU1?=
 =?utf-8?B?aUNkR1RPTnJOKzdtQ2FHYTQ1cVRRaGhKeElnQWs3VStiVnJNaVlYdjIwK3Jw?=
 =?utf-8?B?ckcvdDV6Tno0OUVhV1phbk9zRUlBTEFXS3l0RVNtb2tBeENLQ0RHYVJpVFJG?=
 =?utf-8?B?YlJRbXBhR3U0VDFsanFoSEd2MnNQVEhyeS9INW40NTRoNlllcjhwV1MxbkJK?=
 =?utf-8?B?b3ZYSDkzSE1YVTZEbHpTbEE2SXVqQXZkMEJRWkpPK3JjVWpTd3ZaQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56cf726-f8e0-41f7-8059-08de766ad2d9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 01:43:51.1193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGLtO+dntVBqGWdbN2KeOIb8QkJEykUrmDH1X9EWu0/1UMeRrYbMh6TuYS8YRlLs+kNrJM6AHDALQNBZFF+5MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12440
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

The i.MX952 uses PSCI for system reset (sysreset_psci) rather than
watchdog-based reset, therefore watchdog configuration is unnecessary.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 538190e23b7..67898012618 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -786,8 +786,10 @@ static void gpio_reset(ulong gpio_base)
 int arch_cpu_init(void)
 {
 	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
-		disable_wdog((void __iomem *)WDG3_BASE_ADDR);
-		disable_wdog((void __iomem *)WDG4_BASE_ADDR);
+		if (!IS_ENABLED(CONFIG_IMX952)) {
+			disable_wdog((void __iomem *)WDG3_BASE_ADDR);
+			disable_wdog((void __iomem *)WDG4_BASE_ADDR);
+		}
 
 		gpio_reset(GPIO2_BASE_ADDR);
 		gpio_reset(GPIO3_BASE_ADDR);

-- 
2.43.0

