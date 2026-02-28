Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7691048925
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 01:44:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3BE983F7D;
	Sat, 28 Feb 2026 02:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wlKSivUN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EA0883A1B; Sat, 28 Feb 2026 02:43:49 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3805A83A1B
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 02:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jf3AvVCmVjyWLMYaQNwRkAU/H3cwdVI2MszvCQfo55yI9C/C73wPPXfCejePJKnGmXpuWTJRIQ5S+x4c30XUmhV/kKfqw/H6q8ExOy14YtLuq42Zn840oZdOVxYG5pxppdrACJ0o7p7Y7sctlc30qYgfHqzAeSKV2+d7F8Ro8GYKl1BSAB4p91z+yTgKNrYSm6S3RY9CC4J1jtEJJ3t2fICkeYiLstgjIulL1zpA+3jy/NGG9VfAIRcZpiH2G/SrtsJv2TQVDMRje1P05nA4CziSRQ1CdcdsPO+0cpurE3FDkbAkxhmAJxhasH9bzxb+j5+KfbZ8Zr9uuxhiR4gQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70R026pjg9KDpv7YaQ6w0oh76PheSiNKtKL0pfULh34=;
 b=WT6D/85OdkooCMQLdHd3MWT3Mlxposyu1BIVRwz2kv36kHOeYMGhbx6Njn8OnpJ2UXD/OisXzSLtSyCLgVrHyz49aSjiawAeDzg5j6FXiiJo3hPWhZzEs0MfK5EPQ15newGvPLXlTD07VnPIS+KEW9TSo7ERINy+TOxNjuLoUnlvyQPomHXw8/keA7YcChGjCfYSRTj179wy2f6cF6qhaDt2hJOVdXwwBQPwXYlyItjWUMtfLuvVd61mZ6dj1SPnYsJJvbEqryuLwe6eoMEgLdOII3Wx+nVYgdy62/u10uedZE+ympWWWmekYPwjH/Ufg8h3aFKzWZ3/iQnvxWlDQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70R026pjg9KDpv7YaQ6w0oh76PheSiNKtKL0pfULh34=;
 b=wlKSivUN+l9uoL/8QnnxYzi5lwigFR71hgLyW5HSabWEnucQPYAVTyvlMtDOnOCCucl4nypW5U/Vb0Mqo6tnR16dvD42dTh8pPkcr/JT3j8yXoTQxMRAX/G9YwBWKOtWowbfND08HYHp6HSqhDLwCxOC5N0LqCck4YZmYEilccvljBouhM+ZLkmdVMina0Jj4g2fQLJyaV1ibNmeO7wzUG9nFimk4V9b3rGOL7zqd7RCHoWuizCRESn3trzvv7xvxs1MuNDxbhGUpUVWaun/AQTD8IWX9dPMUWx85uAJhp1VS/k/72Abt972i2w4rNFwmCWEVsLwUnB2WWDH39JRaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by MI3PR04MB12440.eurprd04.prod.outlook.com (2603:10a6:290:75::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 01:43:43 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 01:43:43 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 28 Feb 2026 08:22:26 +0800
Subject: [PATCH v2 08/13] cpu: imx952: Add i.MX952 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-imx952-v1-8-0a360e7e8cb7@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 659f301f-8b48-49be-1c80-08de766acdf6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: 4EmiZp1GT7EX6ILmuIKm3qsyuHKw23APK43pU9LR+a1MTTzvgguSoWJvTFQZlEMcCZaPN2mxNQHPCWJAPrZt/Q5ATXYb+lKxqQbXIdGSK7oht8w7c3UdkQcIQ6Kx1q3q4WqR8wpwSE5MmBX/pZungv0x4hZb5gAkd+vHQ81J0r+Ndmjqb6kxkFXam8hFOo8/upGZy7jW0xLob+Q7OZgFAlEvegsWt1xNtXrf3dL/b/kv3TuKSKs02TRvkAFgxtxfsCG39b/dXQyDXx2IJOcTVa60oCwDz1AO0iNRYEkaQFQE2k3AwizbRCx2r0jnI4czyzOJSBHPHXhXwz11Qo/LJLSCWHRt3EYzk31cjNKjx8waq4d3y28j9Y6/52+FK2Fm26o8vRF4WQzRQt6RsDr1Ec2rlbweUkLBhUZE6l3TceiN8RaHqO9Eyuhszw7V//TUxzMOTmeY03/pUtTGHyZtSYZ7C1nuD7iF4dYg2fisjBwLDpiAyM9YHd3hpi8TN9NQw3EKxoJxhQxeF90X6va5zoBdiYVmkqftYkplHiCs0n6a+M3hWRWNYQXH+Yq7PUNDGMkxLly5+fkxPyM5RRj1iRDY2HkHLSrqs10hsTcn3jOOgpvEL/8SKEVw3GJ6z7duR2xHgjS6c/+UOhfGVOQpto32Lxt7tkby63hJYoN1dL1kdTJGhIHDpLh7cqy45lB2QCMMAf9Q/s5xFbBeSSdVSbJDPZAXVBsInp7ZCQfrb/XW4nH9gTuQIM8sMXBq1QgBFFWaYLPCaDjjsHoqYYzHRMwOwehMHWfhnds8vGUbKsY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnVkYjRmc0hFUlcwT0lGNEVGL3J2VkFRU2YwcmVPblh6Uyt2VERUZ1RwUFRO?=
 =?utf-8?B?cklBQm1Qb0ZhRmo0YUxaQVlvVVNLWmZIelBJbEJqNkV1UFJJdjZQL1V6VG01?=
 =?utf-8?B?WXF0YkNZZGlNNEJJWEJ3SG91dnU5OVVDa2cyelI5bjc3SnVxd2VRYkhoNlYx?=
 =?utf-8?B?aGVtWEd4ZUFVbmhqUFNSS2NyMWVBQ0hBNk12d0VRNjY4NXBWVXliU1RQbjJx?=
 =?utf-8?B?TlU1dm9MZkJwc3pvTklXamRjWTRUK2s5MzcyaUxGRFFKdWFWLzFYREVuSzh6?=
 =?utf-8?B?L2dRQ2NnL2VSL0ViYkNXMnY3T3AzVFpMWHp2cDRvcUJjZ3YrT0FZTm95Q0RX?=
 =?utf-8?B?bTZTd3VIcVEzNC83cmQ5WFBuZ00vcXNBUTZIdjlpclNCdlEzQVVkOVpJajZk?=
 =?utf-8?B?a3VSL0MwanVWTExGR2hsVFBQQmFUQnJaTGFOYzl5ckJyZjliYUJDTnQ5OW1i?=
 =?utf-8?B?dThDNDhGRGk2dFdtNmVDSkZtTktQSUJtMitickVEamxaU1BGakZhbHluWVlI?=
 =?utf-8?B?SnV0dG1MR3Y1L2k0TFhkMTFDaExxcUZiQ2JOMkNidHJWSkUzODFXNU9vTjdp?=
 =?utf-8?B?aEZYRm1TUVl5Nzk0a3h4dkZyaXpyMWhzblBtdEgzTXpLaVFZZVVEay92V0Uw?=
 =?utf-8?B?MjlEZ0xNZjI5KzlRZEFYeEZZVFNqUEZ1a0NhV3NiZ1lBcFhBM01uZ2owL0NR?=
 =?utf-8?B?SG5xVGdKV0kzUlBneTc4dHJoTHh3Mmo1OW93a3g3Q3cyZEk0MnZ3VzNYQ0V3?=
 =?utf-8?B?TGtwZFdyVEtFTGVxdGhlSnMrcUd0N0tmNVIybnNTVGM4U0d1Z2gxQTlVT2dr?=
 =?utf-8?B?M1ROSjlxRWJMZ1ZpOEdGelVIQklrVE1wdWtsbFZBRHVzbzl2YUlwVzdBZWRV?=
 =?utf-8?B?K3dpWDUycEw1TEU2RlJXRlc2bVVwYVg5dzNQTnloTHFUSWczalFvMThreVFp?=
 =?utf-8?B?L2ZnMlZCbFN3TGZnVnRKSmJIeW5QVFRnQnM1em9jb0dDMElzSDhzUklLM2NW?=
 =?utf-8?B?RlJ0SjlJVExkRUJlSlpsNDFhTFlIdUQzSFRYUU9aRkpMU1RMNTJiNGlyamVP?=
 =?utf-8?B?d25makZiSit3MDVvSG5DOWQyd080aWxqK0VjMkpVT3A1OWlKK2RaSFI2QS9h?=
 =?utf-8?B?K1I3Yy93L1A1Zi9iTnlSYjY5ZTFEWklWTTZzTjkyOGh6TzlVKzQ1NDZKY1Z2?=
 =?utf-8?B?N0JFNXhNNWppdGxGMHlsUk4vNmtkSWptUDVTRFp4VEloNE5Pb3REMzFGMUhr?=
 =?utf-8?B?ZkJzY1FnSStSTEVIYmdURGxMZ0VKSnljSkRVWXBDZHdFdzZlNTg3OWVaQjc1?=
 =?utf-8?B?MFhyYmtSRmgyNkJueWVrTDZ3OHMxY0JsNllxRjZLL0hSSzEzYThJajBUOWJx?=
 =?utf-8?B?R2tDWS9SOGM4bjVQT2o2R0FKalRwVElNbFk2M2ZuV1NRcXV5elduR2RWclZ4?=
 =?utf-8?B?TnVnRlFXQjBrRk02Wi9sTUt1bm9haUMwVERGUmNrM1lpZS9ZMEE1K0tqR3Nw?=
 =?utf-8?B?WFdxR045UjFlSzVaT3Q4V01xSGNoVmYwVWpXWjkwTnMwZ2JoQlV4eitsVThx?=
 =?utf-8?B?VHg4dUw4d2FVaTZvNXlUcFF3a21pblk0SWJGNTRockpWZElPdTVuQjdUZTV6?=
 =?utf-8?B?aHo5bS9iVzFEc1A0UFBiNjFuU3ZhQ3hGM1hpSGpnei9IQnhBWmJIbkNROVV4?=
 =?utf-8?B?M2F3N1NqeTdMNWI3UmlnOHhNeTljODRMeGJGaVpkN3hmdmJyczMwaXl1SjAy?=
 =?utf-8?B?bTNiVkJaK2xvTjZJOTFuMCs2d1RqMFppYW1keUU2VzNoMHliVkJXaC9NRDhD?=
 =?utf-8?B?aEwwL2swd29DSFlFTzFQTHREQzBZNjBlRDArQWF2THVmYnh0OGtaWHVCMHFR?=
 =?utf-8?B?R2FPdXl5c3VxeEV6RDFZODBDd0x2ZGNDY0djWFlwS1VENkZydzFRblMrMDRj?=
 =?utf-8?B?SUxZcXY1VWQ4UHRNRVZzNGM5ZVJnZE9XQUlGOVR1V1N3UDV1ZDh3bEFpRXFD?=
 =?utf-8?B?SzUwRGlrUzZNdVMyeTZ3ZVdreHBhNk1nQWVwaHRNQ2RYRmdjZE9kRy9OQkJI?=
 =?utf-8?B?T0pVY1pMSU83NXg2ZGFBOSs0WHV3SE00bmZZMzB4azkrZTVWSWlqc2hFRytJ?=
 =?utf-8?B?dVFJRjlUendOc3JGVnBPZzJUaFJzYXlMeWJWVi94bUkzeFd0azhlQ0hXYlRO?=
 =?utf-8?B?eG9GZlpTTEJKRVRCV0FTMXpiakxyUnFpSEh6d1ZlNGhrYklVdTl6NkpVckFv?=
 =?utf-8?B?c3BUdTcrTUIyVTB0OU5jck9oVEJsQkJ2L21OMVhzQXIxbGxCNHYyL3VtUU00?=
 =?utf-8?B?Q2JUYnJwai9SU3UwS3pPTVk4VUVGaEcyVE9Bc0VoVkFVN201Y1R6dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659f301f-8b48-49be-1c80-08de766acdf6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 01:43:42.9763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCkQ//7oCM4iwP9674BorZBReBeKmRlestCr71afpkCgWBpdNI6ubVyWyNQrCPUnHMnG9GP+3YQGHaASUIbyqQ==
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

This patch is used to add the imx type string of i.MX952 so that the
i.MX952 CPU info can be printed.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
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

