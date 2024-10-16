Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B37D206A4
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96D9488DC7;
	Wed, 16 Oct 2024 09:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="soIQArEq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54F2C88DE8; Wed, 16 Oct 2024 09:19:25 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AF1288D3A
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBs8jC+iLHm4Y1/tepegUnXi6LocrbXNKg2p+k9U7A7DQi55dGxAsNJggc4qhL4z8w8FkPfZdnX+dmpFeQGBDIzNiPW7tSqVE8aUfLVTqmX5WkMpx0ZXN+/gp7uwY2iFsYtXLs39PAO3XZ9I9mhTJpi6X8OUyOMbIQp5zIbCBlDdy+4D9L75ki+6X+Lxc1+gQZcFoAzsSvDScIcVirXTeY3B3MRMbGnarmAbamEcivq321qQudRtCpPTqbHLlbyIxzEWUSGsXY6M1mMt5QotzCTCwZXg0B9NbJUcrl0yJSOYu0XJv2WkyfgwLlzx6PpBbi9CPIpY1nltRbjb2LuAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gsKhsohElbbGo6eurhrhnAhb1W66FkKf/flOs8ZIm0=;
 b=wGfTqY9d+duRGaX6Brgv37wsJ5g79zghUWZsCpZFWlCxiyr6ug3XUTvb7Pf7reiim4mvmBG4QlDvFRRRASRMN+5V4v/nYsAdl4Sy59+dFLB8LfcnHdiEJSiKpEAXiKqBAUGMUkQaReO9XwbPnBGDRojWwTmEdhT25j3VtQe0NB7SUlN4gdDa1swQElzEysNa+9wxL+auhkuYcVsM3wR3LPDckAln8XY3KKkW6F7ZWRMVO8RHA8Hv+ha2nU+wFzTusTOVxhiWdXF0B9767FPugDEhgsxm6d645S/EQeLlcC+F+Uzg7gMJi1iGtloh8o640NvR/mQAQOWcJ2FOLYgS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gsKhsohElbbGo6eurhrhnAhb1W66FkKf/flOs8ZIm0=;
 b=soIQArEq7pHkauGxdMzAdAhK5NE/PNX6fxI90y2G/ZtW2erXjo5cJ7pvJCSDDJ5cEb2Uq9cBtAjrcTOjVLfImS1fkBdLTrPCMTg4oS+WP/AFoIPsKOLX68OdfOdiE0lNinm1oAdCjWcgXX3Hv6Uu5msmnk3HbB7FpUfU3Oe/KkXxRwimbBoJAK5hVPtVeXgmdYwP+u1uZ0VAccqhBESOeoFB8hiS8vbuVLlLazauGyxqIxrCVXK9gKYvNNGUwmEjNBFkz7SbmZCWTqvxLTUGt2lcl/iwj1KpoC+MYUd8XyAwDDT8DxYbxZyeX8xuHApnb/9lshC0PxmLfQQ5x9ABRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GVXPR04MB10235.eurprd04.prod.outlook.com (2603:10a6:150:1be::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 07:19:21 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:19:21 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 16 Oct 2024 15:17:59 +0800
Subject: [PATCH 06/17] clk: scmi: add the command CLOCK_PARENT_SET
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95-v1-6-f640c8f3bc1b@oss.nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
In-Reply-To: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Alice Guo <alice.guo@oss.nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GVXPR04MB10235:EE_
X-MS-Office365-Filtering-Correlation-Id: ef14c09c-6751-41b4-3c96-08dcedb2daf2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S056L1EwQ1VSYkZpU050Z3RqRnQwNXFDMU0rR241eHlhNE8vWXIvTnFDSHl1?=
 =?utf-8?B?alZ3d09MblBzYTcxQ21EZjFHb05MUW1xUXlwSjFwcStsMVpSNFVZZmRxam53?=
 =?utf-8?B?eXFKL1V1NXdySkpJcDVsNDByUDBqQTR3c0JFcUNxRytESzBXMDlFNTlsVDV3?=
 =?utf-8?B?VDhDNGRleHJmODloTmdNUVJCWi9LQVJXMlhsTVIrUHZwSHhoS0EwTStlalBE?=
 =?utf-8?B?TS9mdWlLTGoxTzVLWTZaNFNIVDgvck9HY3ZhcnFUZXJwMHIzZDFpMHRNUEtm?=
 =?utf-8?B?Wnl2TXNBcmZ6dmFzQWN0ZzMzTEc3MnF6L0RDRDJaOWgwY1RNN010cE9zUUk3?=
 =?utf-8?B?SU1Ud1NYWEErOVErcGZXeXc5TmZoRnQ3RnRpWkxTUnpsNXZtM0MvRnZyTzU5?=
 =?utf-8?B?dW5Pb3kxMFI2dVFtb3ZpbWNlR1dsUy9SbmNPd09tcFdwQUVlNmI1eXNvZTEr?=
 =?utf-8?B?c3czUXVzb1MvTVZoNWlLNEZIeDdUNnNiWXdodmpJZEpQd1BEdmVYZ3lxUUJr?=
 =?utf-8?B?VXB4aWhGTnFDVFVFdXRMQ09PcDRXZmJqb010OFlJSXRlcmRqL0pvRXo4L001?=
 =?utf-8?B?RjFGempqekVvSUdoZjFhanJJdis2R2l2Rjdncld4RXo0WWU5UVhjd1Q4VnBj?=
 =?utf-8?B?MXZsZm1rRmhpdnlmZUNKUUY5R2VMSk9EblNVbmsreWNVN3NVSy9lbVRaSy9W?=
 =?utf-8?B?MG5hc3JoVzNSVFpzdjhaT1VjY1pIbVp5bnBQdlRiMDJKQmYxT1l0b3JMS0Rv?=
 =?utf-8?B?QW5OMGpnbU4vcWZBL1VqR1NEdXJlbElSTWdjZk0xTVpyakk1K2xDM3JXNUkz?=
 =?utf-8?B?TEhhQjQyTTVSSjRtWnVGKzZIYmF3M2ROVDVIQlIwalhsRy9tQVVpOUhWN2Zn?=
 =?utf-8?B?cUlodXRCSUswZnVKMEx1NDY0aXFPTEJaQk1wOEQzcWx0clk2SkYrNENmSEZo?=
 =?utf-8?B?YXAvaStaNTFabkZNL2g1QlR5ZmxSQkZFNUhCQ2dzUFFZVFZFUjdYZG5NaFVh?=
 =?utf-8?B?WlZnVFhZT2ExT0c0SDZhMkFkRllZcXJ5QXZtenZCYnNMd2g4NVRPRXQ2UVI2?=
 =?utf-8?B?czM4bEtZOHFIbGs5RS8xWnRkcTY5Q1BWeThqSFZVWDVGTGVhMlRWUzUzdnh4?=
 =?utf-8?B?Q1RmV1NiN0YwM0hoc1JlMEkyMjNhRGljWGJTZ0VhKzc1cFM4ZWNHWEIvelBV?=
 =?utf-8?B?bmtVOEdldnl1SWxrMmc3VndiRUs1RGNCNTJLNUVvdzlScDY3bTYwNTJLRWln?=
 =?utf-8?B?QVVIWVg1ZlBWYXFObTBGLzJNcHUzUDBsR2tRb00xTFEvVmUxWkFBaEdZMnp5?=
 =?utf-8?B?R0pyMEwxOW0vcDBxSnhJQlJMWWZINjRkWDBPQzYxVzVXTmJIcUhzeVF4YmxV?=
 =?utf-8?B?RmRwaXNsY01TanZyRFlvb0h0aEszakdLUHhiYVRCNC8vQzNIektTTVdFNDQ3?=
 =?utf-8?B?eVpPV2ozditxUm1pTE9MaXdqUHJldi8vMFZTeDVja0E1WGEvbDl0dnlmei9l?=
 =?utf-8?B?R3hsZjRjZXVISHcrODVNM3lPd1pVaFdtRHhiN2RKNERpcFM2TUJWQU1rVGdP?=
 =?utf-8?B?WGkyZ0ZDUU40OHh3am5XTFF3NnhXN2hpUG4xRVE4VEJ2aTBpV05LZGVEcDhx?=
 =?utf-8?B?YU1PSFdXK0YrbWdqZE0rNzVVcHBhRk16Q0lVRi82djI4YkkvYTZmd1U3a0pR?=
 =?utf-8?B?VDJqaTBmY2wrOUt3RUJtVi8vZDhaSERjTmh0a2g0S3lhOCtNTThoTStDQ1Ju?=
 =?utf-8?B?NFVyVkVNOTdKN3AxOEpFWXIxRTAyNmdlZHY0N3ZLcHlDcUhpNjRrNEZFSXF5?=
 =?utf-8?B?OGkvYVZrMjhpUnR2ZjZLdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjlQZHJHUyt0YndJNDRNS2o2RVdUTyt6MXdUV0hyN2VoY2wvc3JTNW00Yjlo?=
 =?utf-8?B?d3JaSUFaSzN6SEZFWG9zZXZSNHB0YWsycU1QZFBFWDVqbC9OV1FVV1dNTG8v?=
 =?utf-8?B?VVRxcFNieTFaNmwwd3lqc1ZCUk9kbkdidHZ0cDVpaGRWQ0tmVFhIWmhkam1n?=
 =?utf-8?B?TVREY0ZoOUhpcExvME4zc1FqMmRtUlJvaGR5VVJhZkdVL3Q2MWlVNWw4aWU3?=
 =?utf-8?B?UWpBNEpyc0RYUmJrbjZlSFdaRUd3UXZQcGdGVzdxd0RvV0dGWFRPUnlWTzV5?=
 =?utf-8?B?bVExeC9uYUNHOW5aSXUxYTVPaVg1STdZSXNiNEN5VnJyWHZtc09PY3FvNWpT?=
 =?utf-8?B?cnJXVFNnY2d2cldHM1FUeHJZdDdKOS9OQkE3c05veEs5YW51S1JGelZlUkR5?=
 =?utf-8?B?cGw5VDQ5dGl5NXdxTHorQ29PWlY5My85aElLSXI1NlBIYmROMzBnd0FubnFT?=
 =?utf-8?B?dWFLeExFU09Db0xPZ0pDUGdjZlozY0wwRU9leXlGUkhPZFhEUW1GWVJQQ2xp?=
 =?utf-8?B?Zy9ONVJWM2FodThRZUYrdWM0bGVLMUgvSS8vaHhaUVAzd01tMUtVS1Qwek1N?=
 =?utf-8?B?VUF4N0RkZHQ1dk83TVNaZWZoTWwySmFnbmtJVi9PQ1Y5T1lRRTFhQWpMcEE2?=
 =?utf-8?B?bzZWODNDZHF5V0t0cGRVUllJVXNyNi9XU2hnclpyZitMcEkrWmY1VkJIb3N2?=
 =?utf-8?B?WGVLc2o5ZUdwRTdRU2xlSnJqVnM5bGxVdWdzU2xUVHJZY1hMM0MwdWhiRTBX?=
 =?utf-8?B?ZW4vclVUM3A2MGRUajM2TU9wMVh6MlYySTJZOTdxSkNNb0pMSzVFUGNIMVFC?=
 =?utf-8?B?SFA4Znl0enprV3F1TmVTMFJMMXptMnZ5Mmh4S0hnSnB6MGQyQ1hRWlJjMFh3?=
 =?utf-8?B?QXpFNXJJREJBRHlzS2piRThHZTlha0hRUzIycHR0YWlJcTBWZERUTlh1Z1Vj?=
 =?utf-8?B?a1hDMk5jN3BzZmRLSEZXaVdFOFg5L0NHVElPNUJibXM5V05FMTlWNDJOQ1Av?=
 =?utf-8?B?RGtXa3ZDTlVTMDVNV1B4bXgzTm1OZ3hRbGY4WHYxWHdjK3VVdW9FMUlXdTJN?=
 =?utf-8?B?OGR2cFUwYkdUOWZRZHhDaCtCeGdYdThXQXk4UVBMR2N3eDdKckdQbTY2emVI?=
 =?utf-8?B?czBZMmpHQytJQUxYcy9TM1FJWUdJRlhYU3BoVkJwWU9sQkoxQnRKN281MHll?=
 =?utf-8?B?d0NUZ3NodWZBVkltNGFrRVRwYUY5V3E4aDMzcjBtK1VSMDdpZml3S2tGS0ZF?=
 =?utf-8?B?Y2JaOFdQaDVGWTk0c2NaQXkva2U0WXVkMWtnaDlZV0luWGtvekdnSHIxcDli?=
 =?utf-8?B?bllWUmVJMVVIOXRPeGlIdjJaR1dPM3VXY3BleUoxT1k3UWlLMWdvTC9yQUZW?=
 =?utf-8?B?c0dHUTc5SE9Pb1g5ekZnU3NxY1pHUFJXVkpINUM3aXdtRDRIWk1YZitMYXMw?=
 =?utf-8?B?ZkJ3ay93QUhVaUhIbXBudk9COENYTWZ2ZWRqRjR3LzVkQUVMUkt3MzJUUnBM?=
 =?utf-8?B?YlVMTENzOGdMWUt2aVR5bzVJMno5TG01VjR3RFQrczAwNGt5bGIzTkNUbjFR?=
 =?utf-8?B?ZkZaZjkzUGIyTmtaR0ZXbkg5S1pwRlNpYWhDODBZUFB4eERzREh0eFU0a3A5?=
 =?utf-8?B?aHh2NTIrOVdaUitzY0h4OXVERWg3bENCUGQ0VUpyMFMvQ3k4bW1nay84V1FS?=
 =?utf-8?B?ZGpGeHZxZnZydHVweHFqNzR5V1lqa2lJWVNxYW1sWGR6bmoxYUh5VG01M2hJ?=
 =?utf-8?B?d1o1Lzk4YWhjVUUrV3grVy9FMUY4WjNBT3p3TG85eXlsY1BqRU5VMHlaQ0tR?=
 =?utf-8?B?eUJPc2E4UEtPTWNuRmNUMVAyQWlqNGR4M0RRaEpVUWQ0YldTSG5jeFovTmov?=
 =?utf-8?B?QmFTYUx5RllUR1V0ZU95MldTMUJZSEY1KzlBQWZHNTVETDZEeTg1ck5OeEJF?=
 =?utf-8?B?c0hrTFZ6Q0hTekpVWWdXMHJuYkwzUHcyNDFQTnlveExjdGRZbE5PWXhtdjJo?=
 =?utf-8?B?MDFCR3pheTBqMWEyNUJhOW0zT21SZ0dJMk1abERqenRTQWc5R0RpMzQ3a3hT?=
 =?utf-8?B?ZjR5cnl5V2ErenByV3RPOVVGK2dzdE80UUJwVzNiTENvUk11SUxlSWRPWE1m?=
 =?utf-8?Q?+VfFAsXwPXntW9wCJQ+Z7B/a8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef14c09c-6751-41b4-3c96-08dcedb2daf2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:19:21.4273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+iKkSrt8FpEeRGaWwQr8tUEWMl1HmWhp57R6jW24vXSod0q70jxA3sOJ7D+kG1PxjKrefLOsdmo95R0YEkAPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10235
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

This patch adds the command CLOCK_PARENT_SET that can be used to set the
parent of a clock. ARM SCMI Version 3.2 supports to change the parent of
a clock device.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/clk/clk_scmi.c   | 20 ++++++++++++++++++++
 include/scmi_protocols.h | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index e42d2032d45e011b751c19b395b6f99d5c54e78e..84333cdd0ccfe566c269f776f39725c69883c25c 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -178,11 +178,31 @@ static int scmi_clk_probe(struct udevice *dev)
 	return 0;
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct scmi_clk_parent_set_in in = {
+		.clock_id = clk->id,
+		.parent_clk = parent->id,
+	};
+	struct scmi_clk_parent_set_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_PARENT_SET,
+					  in, out);
+	int ret;
+
+	ret = devm_scmi_process_msg(clk->dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	return scmi_to_linux_errno(out.status);
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
 	.get_rate = scmi_clk_get_rate,
 	.set_rate = scmi_clk_set_rate,
+	.set_parent = scmi_clk_set_parent,
 };
 
 U_BOOT_DRIVER(scmi_clock) = {
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 08c86a642844570424dddbfcf9670d1e6757d8d1..d529f8e2697472e60d0cb9c275f34ef0ecaed3ca 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -737,6 +737,7 @@ enum scmi_clock_message_id {
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
+	SCMI_CLOCK_PARENT_SET = 0xD
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -839,6 +840,24 @@ struct scmi_clk_rate_set_out {
 	s32 status;
 };
 
+/**
+ * struct scmi_clk_parent_state_in - Message payload for CLOCK_PARENT_SET command
+ * @clock_id:		SCMI clock ID
+ * @parent_clk:		SCMI clock ID
+ */
+struct scmi_clk_parent_set_in {
+	u32 clock_id;
+	u32 parent_clk;
+};
+
+/**
+ * struct scmi_clk_parent_set_out - Response payload for CLOCK_PARENT_SET command
+ * @status:	SCMI command status
+ */
+struct scmi_clk_parent_set_out {
+	s32 status;
+};
+
 /*
  * SCMI Reset Domain Protocol
  */

-- 
2.34.1

