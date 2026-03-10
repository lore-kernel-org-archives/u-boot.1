Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E59FD2D79
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E034884082;
	Tue, 10 Mar 2026 14:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Wyz8xari";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 524ED83F9B; Tue, 10 Mar 2026 10:14:28 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0B083981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 10:14:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWvdJB0ZCxcGea/22on8SmHpGt9AcPclPXNeAsR2ILtC2JKhHMmU5ydhrT7sKQGpCVo9xG4GLXCFs9SeVIKUWwnJ7FjUoQiHZE0VcJ6QeP9yRxjFnbwcLxBF5Is6SRuLLm1SJNcYk8NqGyeTtAUIR6OJPydYMuaocupugX4FT8W+XX2grxbARjWxpfMlmKUGmIQ/wbvlC2ToKq8Gl2/sHkt4fT8HtzuEJpUa0r8NxPTIdn2O247oayIawsHJrF7l6aCgeZU0QelH4lcbM/c7rLfat3Xy+MZ0dGco1NTbs0ls8qPU1Q2uBWj7clef5DKWmvyzWWzXJTOowYBzxpmcyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKR8xuVtqEqHgOSjTARIG9BxnykJkARg93GzXQ4l2vg=;
 b=aD2qe4GHSBLqti+gQYyq4tDkHXaYLIvTYZ16ARmhCYnq/bRVDS87XvS9fA6YlUIkZlVgnnvP4SCEY44RTdidMAkdU7Cv6WVUrrT6R/lyVndohukSGjDdYyr3m5BpoGhKeh34Yjojau23I6yp2tcuOAqAFcnnVa7Y+KcSaFQUUYBTHQAYDXzLmyAZhVszPxLPZPAcZTzNEo1Zpi8JSZ0uK9YByLosVvVYR+z3GGakcaByoK4+IuKTWo9Sh+nQ3c4Qhf0co9g9I+pTnSQyqjh6L1ugegfvno5ubWp0MUyOKhld4PUZ15hTHu+reJ0zKabmfWMGtzBVz362lwIjmwfR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKR8xuVtqEqHgOSjTARIG9BxnykJkARg93GzXQ4l2vg=;
 b=Wyz8xariFygrRdSqyoAruApmCjQDv4bGwHKIJ0WpqJNnNeRsS8FttFtJ6X/jp24V3msMl7wshdubu2VYhRIMx6nCGgTDwgvwjKaQZaHcYOj1lb8qlq+1/xVwRj1V4s6NFzyILYF1O2Ddk+UeemuItA/X1LJdrYB0nDEaUKeZ4h//RC1g7s6DKQjRupuYTWsCizs7o1Ybb+G+hkbwJtg3JdUc8oRi6hyU90mxcbAmA2zTrKTmVpnCU7l7igd7BYmigRO8CgCTTxaxVZtmD3ifhmVadqOZcDVZu/rwPZ15xd45fq2DDjuw7CGr3Ciwtlb/qF6bpzanysZQ3pmKpHi+CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV2PR04MB11192.eurprd04.prod.outlook.com (2603:10a6:150:279::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 09:14:20 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 09:14:20 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 10 Mar 2026 15:53:38 +0800
Subject: [PATCH v1 04/10] imx7ulp: dtsi: Add wdog1 and wdog2 nodes with aliases
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-wdog-v1-4-2ee21e890634@nxp.com>
References: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
In-Reply-To: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Joseph Guo <qijian.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Jacky Bai <ping.bai@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Primoz Fiser <primoz.fiser@norik.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Mathieu Othacehe <m.othacehe@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Jindong Yue <jindong.yue@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR02CA0071.apcprd02.prod.outlook.com
 (2603:1096:4:54::35) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV2PR04MB11192:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3e2793-f01f-468a-fbd3-08de7e8569aa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: dQEmGR93Ssxw3gk3oluXhIgVuOC0xN0sHSn478y+InsYhe8x9czW9fIixZjW5E7P7HytMlNVYSqYSvVVkQlNvNVFiTTVg4kSMCAFAdv7+RafcYuH9Um4Qb6XHRE0HCedIEIS4S7d4HsVIwIcaKaSh/cTrrZBcPCjb8MV1WpBZ318EKO30yJkFTMjknQn2G0HQyXANAAIsgwp9uoe603k5WOlGdvwqsDeWyGB6y73roLPH/qagyJ1Hb3VB0IbZIo9hVqVgv5aQKgmagHI8FF/0siVRajQoZW6byY3wioikyYEm1ObaXLqYrj4tzUbuxTtJggvRWKttYCsOP/gyJSCDZN/h9dc55QiKrtY5xPmH2UsuFWHLFWGq4+B1G67C9tta3ISPXhdzesXdRywWJcxRuuEYgoP+//GLI45Z8EHBoRX1u7VX2/qwvvCF90KIRXz95Wh0+mHBI7RalRakJcW+d18Ihkkd96bE5X/16+KQbfQ3TUe2qV031MUEAv+r1HjHtcrIzAXJWHTGyXyd7qORxI882ABErhVgeOynnPDiyvAYEMhT7x+48HprT/uxIHfL03V2FUDkbzbTwImuR9ZYgGppP2u4UHodwAkIuqVoA5ZOglo2Gv6KyAHzS10sNmaYdVmigYr6HqpPVEKwhxE56ImNIqsxr81BVfGt+1ipNGMmAvsvc841LzcD5mxjzBAZray7skbFROu+DDSR/NaaOnB0cfKVDGoKKV2fYVETj4x6g+MU2MJCLjHHBpR59qBpR91XOZSk97F461WZT2vV/1fCFg7EQkA7pu3wrX5xSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWUxZFJEYzk5ZVliQi9aRTQxUjkyaThQajVGMENPMVJGYy9lZ2ttMVo3T2J3?=
 =?utf-8?B?NG1idEErUEMwZHhEdU5mbytTMDdGTlZ4R0g0aXRsZjN5bW1iM3Q3WjJqWm0r?=
 =?utf-8?B?b0JyZ0srT3N1bUlpZGxMRzJZZDVLTFFGNnBJWitGcjgzRGI4eENGRGo5VjNS?=
 =?utf-8?B?U1B6dENtM3d3b2pBOWFCQ1c5bEl5OUNSZExqYWZoeWEwaEVDS1R4NHYwdHRI?=
 =?utf-8?B?U3NUSFp6ak15citaM0RFanl5QlNxZWZGbExPSE9FcjlCZXNFZGYvOVdKM0tG?=
 =?utf-8?B?R29pTFprOWdmclhYdnVWdldHVWFiTnR6QU02eEw5amxqYjNrcVgyN29zREtN?=
 =?utf-8?B?RmZwc2plK3dkL0NsUGJYN0J4WW1WTjFMNTY0UWFaVDM0cFlYZmw4Z2RJM0hM?=
 =?utf-8?B?NjFvRFFYWGpBL2VYbjlRcENCa3VMcTVYTUQxbk5mcU8wVnBhT1M2dER1UFZn?=
 =?utf-8?B?d0ZCNTJBU1VVZVRva2xPR3NEdEJheUNLTU0xVldkQy9ZNDZFR3hMLy9wdXhC?=
 =?utf-8?B?TndldnBtRnRxaUNkM2duOEVxR1M2Zzl6UWRFU29jcmpUVWx2Nm5zaVBiNThQ?=
 =?utf-8?B?MEJ4aldCL3lLNmJMTjRvSzJLWFk2VG1Jei9zNjVYaWFySFZNVFlRSEtiaXJk?=
 =?utf-8?B?MmR6SlE0aHdTLzlzKzloSmJKR1ArWi9zZnp2c1U5R3JJYTNRby9CbjBkTUJ3?=
 =?utf-8?B?S2ZZSTFZOUFGRUJwNXZzZ2I3UklnakRDNGVJc1BSdFlHbUZTenBnaEtYbFVK?=
 =?utf-8?B?enNuTnI4eThTeExNNmh4U3E2emVxSWlHcG1laHFaTjFYb0dMdlcrUEpqUnYw?=
 =?utf-8?B?cHRvYWZoSkNqSk5yajIwMUxqM1YxVkRLaTFQS3IvUzk0MVdOVXJQOUlUV0tO?=
 =?utf-8?B?bU9wZ215ckY3OVNRV3lZU25raU82M05rRXlVL0szUGphZUJpOTBTZVo5R0FW?=
 =?utf-8?B?NUV4WWZZWVZCK1oxb2RCbXoyUmRWNUZBN1FtZzg1eGpYS0tRNnlPNFcxenh3?=
 =?utf-8?B?SnA2bmJCK3BSRVp6TFZDU05BdFhTanFBL2FoWGxiYlNIakYzWjRUWE16Q2hS?=
 =?utf-8?B?cWphTlE5bzVBcXF1dkVtWFh6amE1OWR4eUtTVUY4Q294RHp3ckU2Y3RPWnFU?=
 =?utf-8?B?UW1zdDBjRC94R0RIWGNIeHhHWkZOQ2lrTG04dzQvSFg5Sm16ZWFtOFFpTXFn?=
 =?utf-8?B?TUUxQ09ZL255UkE5elFyZnBXVE5sL3p0VEEyUDRka2IyWDRYS2d5SWptY2VD?=
 =?utf-8?B?Uk9KTklXMjd3TXplZnNLTDgvc3AvUXlQM2pPd1laRkhZL2t5Nmoza25RY3JO?=
 =?utf-8?B?QU9Db0VsWkM2YnZ3aXg0cDB2UklkeXliZ3lnMHd0SitNaHNkKzVWZWlpZkNY?=
 =?utf-8?B?MjZ0eUM3aWZBenZZMTkwOVF1eGhKdWJzeHpHU3JFZXpFTHlOSzdaK05vZVBr?=
 =?utf-8?B?WlJGbEJHOVI5Z0J1YmdyczVzaUJaNTdDQkxQbFVCbWZKYzgxSllNdldVR0ll?=
 =?utf-8?B?T1pxNFpRWklkUHJKNFg2U3Fhczl3ZGhoeHZneWxob04zTEFsbzQ0M1I2Mm8r?=
 =?utf-8?B?WjdtQi8rL1IyNEJ1WmJOazBjNTdOZjNRVWhYS1gxNktyRnI3aGg2Q0svUVZw?=
 =?utf-8?B?L1h0WmFZc256WUJRUGcvc0ppM08wQUxWZ0traVM3TWRDZFE2RWoweDB6VWsz?=
 =?utf-8?B?emtNTU1RejlhRC9PWTRUdXpxN3dQVlYxSjBaTmZtUFBBbXZDN3ZOYkdmV0Jh?=
 =?utf-8?B?UEt2VWlEaVp3dFFrY3VDQm1EOHoxYk1YQXdDSnltRGlQdFdyaHJKdXJ4d0Ns?=
 =?utf-8?B?dFNNZ2Q5VGZrWWZOWWI2SmJ1Myt6M0dMa1czK3lUclNoVTBGSXNmNU9adnh1?=
 =?utf-8?B?UW1qUGdheTk2S2c2MzVnNEJjWE5lWmhSRDhvWjFnTXNEY0dBZlp4RUNQU2h0?=
 =?utf-8?B?VzlSeXZncldaMmFTQlRUNzY2Vno1Tnd1V2JLN2ZGc21ldEpyTkw5TGxPNFdW?=
 =?utf-8?B?a2kwZ1NHT1ZPWFg0OVFUR0RwN0lSdWxoVkthVDhzRW5CVnFzazFBZ3ozRHBx?=
 =?utf-8?B?bEVCMnZ0NmlQeUhrOXJ3N0NJaUxSMWxuYklyZWlRbmZZMWFWUk0wRUxlSGh3?=
 =?utf-8?B?bGphcEROaU9EYytCUlJYVm43WWxiM1kxbGZnREVic2ZJMTR4Q3lhVWhiMFBm?=
 =?utf-8?B?aVZweWNGbmxUQmpYOWplMDFlQ25FOEpDMGV1SXRGYWh3OEpCYnAyODMzTDUr?=
 =?utf-8?B?a0tGS2VUdk9lWVVINVFaOU1ZeFdOdkRBam40bTA3TTdsSHN5ZFpRV203VXpy?=
 =?utf-8?B?QTlLSWJOczBhdVpSQkVoWThQUDVuUnVmUWE2R0pPT0VDdW11K3JRQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3e2793-f01f-468a-fbd3-08de7e8569aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:14:20.3251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lO89G36rx6Bka9wErSSYsXUrbNrAOcgEzPHMZZvw7TVWymdNTgGRn7B6vqDxgETkeBbp2MOVVobwld+VuVkq/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11192
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:11 +0100
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

Add wdog1 and wdog2 alias entries and introduce the wdog2 device node,
allowing the watchdog register base addresses to be obtained through
imx_wdog_alias_to_addr().

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx7ulp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/imx7ulp.dtsi b/arch/arm/dts/imx7ulp.dtsi
index bcec98b9641..8795e3ae7e9 100644
--- a/arch/arm/dts/imx7ulp.dtsi
+++ b/arch/arm/dts/imx7ulp.dtsi
@@ -31,6 +31,8 @@
 		serial2 = &lpuart6;
 		serial3 = &lpuart7;
 		usbphy0 = &usbphy1;
+		wdog1 = &wdog1;
+		wdog2 = &wdog2;
 	};
 
 	cpus {
@@ -295,6 +297,12 @@
 			clock-names = "divcore", "hsrun_divcore";
 		};
 
+		wdog2: watchdog@40430000 {
+			compatible = "fsl,imx7ulp-wdt";
+			reg = <0x40430000 0x10000>;
+			timeout-sec = <40>;
+		};
+
 		pcc3: clock-controller@40b30000 {
 			compatible = "fsl,imx7ulp-pcc3";
 			reg = <0x40b30000 0x10000>;

-- 
2.43.0

