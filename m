Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9B0E9B37D
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 851D083F8F;
	Mon,  2 Mar 2026 14:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OzgXue1p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D035D83F14; Mon,  2 Mar 2026 07:41:31 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD4C83D17
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 07:41:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLrE15wg39CGxX8I7gNXaaCJZgaz1isCkgAYBaav2n7EeYw7u1RIc6NLOTNY7hjPac1xlgWYgAWEPqVnWznjj53K4eoGoOZ5h1E43jduyN6bfZmA4d64JoUkc8UYfV61clmXbDyLgNcFLpdwAVBit5wEPwwalpprnC9ljZErYjtzwOPZg8c3LHWkI76KUmSPF5OiC4aQelqv1QLGN+wrug07DZ5qF57kH+wQFvzUp4GSvYpDPDIC/e1Shv1OnUihpCd2GQU/9posfUar6SpGPZzcG4gn8ldPR6QlG/CjYyZhxpYyUhwkba9dnsValy7iuBHM6YGL+glEZEIHPMWXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0YTbHFx+t3Aln3X05q+F06gIZ5DiXidlU1jW5Yo0SI=;
 b=EfCXSDDfJrTu4oKdRMEsIj9LBzeVXXcGkLoqcEfMSWVenICOyaH4oA/yT+2iS4IBPJXvuujAUreKdLVCRiq2yOCQc+uTgQ49cmmTpwTl4lCQ24sn0GBppZNN1NSJHiB5HIbAoJcZpT/a1nAhHPzpEnlEkWLDtttCNUu5a77Pq+yZBAF2u6joav72GRgvK0Wrbs22RvzyMsOqzTOLeTj+PWPD572SuMR5ADXxOdy/OA4i2fm7Y0d4sjKLXsZbMS28mCvziZ0TyVJruothjX+VjnyzE4cWQG6SyITy0Nkf0Meknf0YJcx63pU3Ghi18pqMpvRtq5TwdZk2jgCFrZ8mjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0YTbHFx+t3Aln3X05q+F06gIZ5DiXidlU1jW5Yo0SI=;
 b=OzgXue1pBxW8KG/WT25tYqMI1esjIHA8+toVTDIyPGvVsHhhL9UMLM5IfGQCs5b/G+c3Q2jBo4KSNAafAuPVa0LDR8YlEx5CpH9bjo6GN6VT0S36KEIjL6BkRzQiixp+BqpAwE3t9ccED3EmZxHhiNV3gY8Vkhp0P+rBF3Y/M11c2jUJ2iMnluKQHRv1O8LfB18/genELfgWk0J0P1E/TecYeIAYAwuvnwGgbbuVZgI64YFSH01tbXjI63+zu/P/xKg22XQRcH/9ZsixBYuNTyRvTHLcs3mHwLQHYvEKawmNa2aNmwLSfAQSSZm+VUFgZ4PWs8swwzCadsP6Vood3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11728.eurprd04.prod.outlook.com (2603:10a6:10:624::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 06:41:25 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 06:41:25 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 02 Mar 2026 13:20:09 +0800
Subject: [PATCH v3 08/13] cpu: imx952: Add i.MX952 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-imx952-v1-8-069d6167c0cb@nxp.com>
References: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
In-Reply-To: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Jacky Bai <ping.bai@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, Adam Ford <aford173@gmail.com>, 
 Joseph Guo <qijian.guo@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Fedor Ross <fedor.ross@ifm.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Simon Glass <sjg@chromium.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB11728:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d3ec1e-c039-4f07-ee8e-08de7826b955
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: /+RBzgGROIP9ID76VRRU/XAnI8voibVhOvNoNjunBMdHqw/vmd2QRFQ429EgjIjSw/gSWDJeycCCeC/TWWJnktr/dXzNOiODKqisSQplpE8Dd4c/Qqi1WMP807nPN++5OskjRogkYcr+KuEiM9S/wIzqeU7om/QZGBzCa3sa3pKjZ3WHRGVHsxQM9+p5oYk9lczabtl0ThwBY1L3ybHzz0YzhD1xu7y9UChG94C3SEu/MV6ccMboWcY2UosFXQMrya+I4E/qqW8sTl5D/D0NVOvpwN1381zLH8nrUVsKSid0G1jTIXH5AoVOl9kquqtr43iz5y2Swi1N3Lq64JIGVLOlXSjqjTrf0gEAzCDwAjL1SG/oHwP5RTRcUFgC5QGvY4ICA9cF3J8LbsKCdvxM8UYkFEO04kiIS6Sw+xcyzS1qDahmKM99Z5goOwWgWnLw2+3g0MKoZ3IY3oHhxr+N0Na1FbalLiIdpCbCtLM1RHGRJRdv+PR4iV363wdE4axJfB0WOpgTysUKfepXSwf1uVL2XDS1EoH+DmnOgK4aPR3w4+e/3UZ5+inhkhaOsoUQTf8PImbl8CD7a2uqkXnxyIy0oL5THPyZxR3ZvhBPC5tv2wvmiZtzwxJrlY8GCoYyX/z+rE5H7DeWsvnWTKN4jeh4H/fpHeRVEDYyCLxks+aAx7MGggN7xOh6b631ck5D3C41uwQpMCLyJjHL7bv5b86CfchfR/aQtcm61WBq1H/4Ak3nG/gsSUrh679BkIU9DxKWLPap+FEg/s1OPcI6xqfSJC1iCUXSvVqKPKpWwGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkFZdTMvM2NFc21vUG5ocytFWUxqa2hxYTF5bEVIVWlLQkxlT1dQdmhyN2VW?=
 =?utf-8?B?UVo2NHBwTmZBMVhBZFZSZ3drL3VGejlYUGo1MjZ3MjhabUQ1b3JQaytkYW42?=
 =?utf-8?B?YXZqUStYTk9jQzhEWGR6VzI3dWc4bUp4N2dRYUF1cGN5SnY4UjRXTVovcVhT?=
 =?utf-8?B?VXFCWDdveENzR2N0SzBhQlgvT01jT1A4L3N4NHI5S0xRV3lqT2RuTWdnc1dn?=
 =?utf-8?B?OWVpRStjVWpTRW5xL3V1SExEYng4NmhjN29hekhQM3hrbWc4VzJML0lieHpJ?=
 =?utf-8?B?TXJvaDNBK3laQ3NnMG1QT3dVd3hPTFhYRVZ4Q2w1eHFSRmFWKzUwbzY1ZHZa?=
 =?utf-8?B?STBYa29sWHYvaExMQUdTM29jV0Y2MUhMck1RRStVUlFiWDZvd3d4SXN2R2VE?=
 =?utf-8?B?NXNrR2o0ZnMrL0JreUNkaHQ3ejkzTFBKNVE4c1VuM0dKWG9OeEFEZ0JMaXkw?=
 =?utf-8?B?VElqWWtVL0luTHZXZlRveDNIZGJhSk5yemxrZlNpVzZVdlhjbkE4cGNJWVQz?=
 =?utf-8?B?blI2cTUrRElSOXlyVjNUZ1NzSG9EcXRvZzhLUXFWZG94T21BblQzb1Y5Wk1q?=
 =?utf-8?B?clpONjQ2RWU3ZzFMSExvRldpR1kyQzdFTFlTNm9hbGtYaGhzRXB4Y1dnNW5K?=
 =?utf-8?B?dGw0bzVFTHZtdXdzcXlYY3ErNmNSZjJsbDI4MWpWZnRkT3VjNkpXNHNhVUFJ?=
 =?utf-8?B?Y0pHc3AwT0RNdUNYMDh6eFlBR2pIL3lTbysxK0RDSHRQSG8xQzdTaW1jYjZN?=
 =?utf-8?B?cU1KRk1uMTRnSjQ4Y24rYzlpYmlhSmVSb2RmaEhERHFpL0d4dmRQcjlkWnd0?=
 =?utf-8?B?bExGZDNxbDQ5VkIrTHZRNjhTb2dtTGtGU2VQN3Zmdm9CV0l1QUcrUmY4SHYr?=
 =?utf-8?B?Y1VJb29yeG9CYnBweWgwN2xuK2hid3pEZytXY1lISEtVTWhLY0FrellWNUtG?=
 =?utf-8?B?R2NsYkt4YUlGMjVLQ25RMXJZeWc5Vzc3R3NJTUVweTJRS0xYUDQ3blFSMDUv?=
 =?utf-8?B?RFlmenoza1dKUzFkZzZ4OFRKQ3lFNDF3VUpQK3A0U0ZFbTNRd0ZJZ0xCRkVo?=
 =?utf-8?B?UW5ZMHRyaXpqWXM3OVlFdUcxSVBBOEVQZXdSTlppQ0cwSTFXUVRWRE90RTJV?=
 =?utf-8?B?blFESExQQjdkdFNyWXE5MTZPM1NGWS9STEo5T29IZDJIcUgzZnhlUVdRRDJp?=
 =?utf-8?B?cGtRV2RpVURYam1MOWYrQVoyQ29aQTdPNTFmNkhKVmhVamRpT2R2Umo2SGQr?=
 =?utf-8?B?VVhKK3FyYXJyT1hidndOWEtlbU5Zdks1VW1LL3B2Q2J1QUw3aGRHUFdzMi85?=
 =?utf-8?B?OXY1L3dILzBMZk1UckJPcUlSeWt4N0h3NXVMdTcwVWZJZG90eForNW5BWEI5?=
 =?utf-8?B?c1pwUHoxQ2t5OE5jcFc0ekpDQWd5QWVpU3A2Y2tUM2N1am54L2tmSFVoZlJv?=
 =?utf-8?B?YnIvckk1dlBwYzNSV0YrQWtZTWU4dmg5dlhKa3pieGczeHROUklaQWNGaE43?=
 =?utf-8?B?RmdNLyt0UnhRN0h4aEJpaWZSUnBGS2FIWmNzL2dnZ29Rcmhpd2xXVUIrZHpL?=
 =?utf-8?B?ZDFUelpJTENzb1crdndVTTlHS3RSWUlmQ1ZGeXRqa1QvZVFCU3ozWVh6Q2Ex?=
 =?utf-8?B?V01mNy9PMytBVCs3Wm1qR1RFeUwyL1RUaGV3c3dTWExEc2dudVhmSnEwdGFz?=
 =?utf-8?B?K05BdVZZWWV5KzgwNE9tVE9OaGlBdlBkYnFPbkFvVGlOcEIxWUROZ0ZXTFRo?=
 =?utf-8?B?dzd5K1VsSkNhbC9lR0R4aWNQcVdTTmhCekVrYTRMVWFLUXdWd3BUd2hvZmlm?=
 =?utf-8?B?NTRKUTNlZEtPV1c1TTZrdDF0VENySHpKNmtER3pnL2hOMFIxVi92a1BjUVRx?=
 =?utf-8?B?ek5oWkxFM2tqWXdIMXZGZVZabUxTZWhmUEovenljZkhhL3Y2TmxtZUpwK256?=
 =?utf-8?B?Wjk4QWc2dW1aeVFadnR5OU5iQ0NOUVFZT3kzdzIwV0RKN1B4UFo3MDVac215?=
 =?utf-8?B?Z0RhTUtKMlVtY1JyckN6eStLeHpYaW9Sc3dmQkhLWjF6QzArOFZVVDc3SzU3?=
 =?utf-8?B?N0NILzFPMjZFY1VFYUFRM29CMDZXZEJ0Zlc0YmsyVTdKUmJjMHlHZXBNWVpD?=
 =?utf-8?B?NHlSTmJwWkYrMEJCWUlUcllDZnIrSExqWUZnM2FTaFdNb0thSHBTaTZpU1Y5?=
 =?utf-8?B?eUg1dGRMMUp0WXhISTdMZ0k0WFFFckR0ODB6V25kdmxHL2gvYldEcDNCVTYv?=
 =?utf-8?B?Ry84NEFXdUFVN1U0VUxFeGxTQXJXUy96VzFSeGlMTHNnTEJDazVVMXQ2eS9N?=
 =?utf-8?B?aGxHQTdlbUI1UW1MRElzRXlOVjl3WVRDNVlyMmg5VU9nZzNQNmgzQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d3ec1e-c039-4f07-ee8e-08de7826b955
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 06:41:24.9507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZRpH/h1HIHt1DDNFpr8GqrQVmxY5AJWMSMKKHhb/QBi2EUruz4P2lI/RaoDV8jkgTThf4DC/zYP02YwzUX0ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11728
X-Mailman-Approved-At: Mon, 02 Mar 2026 14:22:38 +0100
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

This patch is used to add the imx type string of i.MX952 so that the
i.MX952 CPU info can be printed.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/cpu/imx8_cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 5f17122c36c..1c78f882775 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -115,6 +115,8 @@ static const char *get_imx_type_str(u32 imxtype)
 		return "95";
 	case MXC_CPU_IMX94:
 		return "94";
+	case MXC_CPU_IMX952:
+		return "952";
 	default:
 		return "??";
 	}

-- 
2.43.0

