Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65CDE77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 03:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 148368043F;
	Sat,  4 Jan 2025 04:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AjlmdVG/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64BED8043F; Sat,  4 Jan 2025 04:19:55 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 658AD8034E
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 04:19:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pS7ALRe40aEIMRLm8ZONj8VEOM++NxKyGYYLtTAu6wxFtYcSW6vxCwBfVJhHMYtvQHasF8UrS9dMqxoIxemneW6vQeWXGi2k/XCeBtEchZ1bdv0QLGdhMU/y+99sfRAFGxholsxbBW103H2+NudFXiu1nMwa7nPmSqt0/SRtQjvjW90u0dOYmHQh6Gjad0ifTiLkTNgxHayZFj97bDli+eHDqnBA55uCTAUZC3ghz4hkpRi7LKeGmuBqW37M8Z3Bo4tOr+atrKiHNc6xD3YNz1hX0xx7prN/KOSIQAbDAmzMzad+KajLAGBHBumTGw3AqMbXhdwYcMYIMYd1MIrZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsfWknPhM1M9FIaZDUYCI79qKnkR5sMrzfm1EaPMuoY=;
 b=TczKd+7dpEBHrt0/drUw7gPsxcbdwAcWKD9qY/Z4DvT1riIaRxxE1UVYYFsHBwueUSPShWCjlP3ym/x2I/mtSOVqWDpdB31Ru2g/4/Z9bpmYOROU1JcSnp9XZ0HXY9YqSyGQBCXXoYnqRLVMRVGM/KFHzKD+gPIFwBB88PnPUA97qfYHIxTo8YZxnvP/QS9bRXg/SzJgc/XCRyDSXjyNtq940x1abu0c+fB7YMEMZLuK48C64/fYvKuZF7wuJ4kI2ePIQSWp2ib6LIXxIDVxNC2ZYJzWOzB72yUOyk5thoZ8V/P6C9s+eZvfdZ/4O7jKcvVE2bJTx5/yu1XMr551hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsfWknPhM1M9FIaZDUYCI79qKnkR5sMrzfm1EaPMuoY=;
 b=AjlmdVG/vwfGBuQN+eRJeKQ4wAI8HNkvJwUviPS3bdwVdnUEX6OREp1ggvViWhw2SvXz+2AJTHDH+QWDedYb/e9X2docfPzd6UvNftx8TIDVEhCXFnOyknMKwopqBSt14ofLwIxkgTRUETs/z5+gHtOnuc74DuuDTuzfqBsvNlRqTSr55irVo//Ke2SGYpR8YPR0Kv0Edqx7K6qbzdMZa2Co9F/FKyjBHsKwAr2H0JyMVOi3OFOaWu9RB4xWLUIt5VtMcgusGG9CnSXECBFM8pceqJP2q38dr8ff+gnBL1Np6MfjWRbeSuXS7vVgeef+s5EKITjF8S2rKlRibt23BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Sat, 4 Jan
 2025 03:19:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.015; Sat, 4 Jan 2025
 03:19:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 Jan 2025 12:25:40 +0800
Subject: [PATCH 06/12] imx: imx8mn_evk: Enable dynamic settings to mmcdev
 and mmcroot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-imx-bootstd-v1-6-e09618cc1d65@nxp.com>
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
In-Reply-To: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: e8742c6b-7542-46c0-c7e7-08dd2c6ea4b9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0tHZ2R6eGRHUk5jcHM1SWVJaXJETERydjAxYXhpejV3Nk5LVFpDekR2dFhH?=
 =?utf-8?B?ZHZQUENFaTNKUnR5WTlHMDZxMFVPOHBVMlJXN3Z4azFFRk5rYlJGRklrV0Qr?=
 =?utf-8?B?SGl3dm9QbEVVV0cxTlNHNGdtekRycERadm41QmdrSkFSSUwxL1Brc0JveWFy?=
 =?utf-8?B?VmN5SDZjcnI4ZHJLZ0hGOWUxNDJlOUpmSUxmYUNPWEduQ2QzVkp3Z2dnMnVC?=
 =?utf-8?B?a2pEVXY2SVFQVXB5cHdOR2xlQ3hCUUcyc3hxQlRlLzZNUzIrMXgrQXA2Wkcx?=
 =?utf-8?B?V3NVeDh6NDFwSTl0QU9KMWVNay8wT0lJVWIyWjRLU2Q2dEJNSzZTRFNmYVJV?=
 =?utf-8?B?TWRSbFpEUG9wYVNyRmV6L0FIVWRGbldrcGhJT2RCbVQ2aUFmYmR5emJ6R1Y5?=
 =?utf-8?B?NlJuZm5ubTJwRzZWM09HdHc5MFdBeFV5MFY2WStHVnVoSDVEYS9zeGxBQ1Ny?=
 =?utf-8?B?c3IzWXJLN3F6bTNvN3ZSUUZUNXlIUGdOc1lsNm1zWG1kZ3FoYnR6UXphK2V1?=
 =?utf-8?B?anZYUGpYc0xvMFUzaUwwUGI0U1pOOFBId0w5azVSQTU2VDlXb3lyNnk5VWh6?=
 =?utf-8?B?VlVPaFMyL1h2MitvakVoNWQ1cWhLdWVkN0gwZzFnVmxqeG83ckhTaE5wVDNC?=
 =?utf-8?B?a0FpVjJIWkplc0duMGkrR0JHdE5Rbk9McWdSVmxwTCtzT3hpMFFtNzlsM1BW?=
 =?utf-8?B?NWdCeDFna2lZQ0N1U3Zrb3NwR0Zkclp4bGVkY0hQWjVKM0hSWFNtRGlSMDhJ?=
 =?utf-8?B?R1NQSTVtUy83OWlqM2RSb1M4MUsyQlJ6dTJmZWJoUzNIbTVIVkVaaGNnQis0?=
 =?utf-8?B?VjBVcEdESXJNNEROOW12cmw5ZmRPZFowdVhkM3grSFc3b0JVMmV5ZVhoYTA0?=
 =?utf-8?B?dUJzNm53aGRKQThjbDRHSCtySEpSa243L1I2RkVpWjlZTGc5NlMrMUozSHV2?=
 =?utf-8?B?YmNmVXo2bzhiSzE1bmkxZHZMeHYyQWpMVTVRVU1KK1lXa2N2a2VTSlo1MEV4?=
 =?utf-8?B?RGxZTjJoU0ljemt2MW53dCtuNFUxN2FDUVhBOWlwYU9ocmJWeVhJR2NtZnJi?=
 =?utf-8?B?ZmhMb2xyNncvWnZKc1pFQlZQancyT1VrT0hFcExWT2hVZDk4K1dPZSthdDMr?=
 =?utf-8?B?VmpnTEZjOXBOWXZzTDFlNU9FSE5nVmVtNnR0K3oxWmdEME0yWDNVdTRDelha?=
 =?utf-8?B?dUVvejRGVVdZbFlTUDFtRXdBOVBVSzkwMVA3R1ZVcVB4K1RXVFpUWCtKWm5P?=
 =?utf-8?B?OWJvOWZtNFk3RnRUdG43UzRES1hxNDZwWEpmdE11RXo5WEl1cFk4RnZkQUNy?=
 =?utf-8?B?a0FlYU52MjVna3QrbW8wejgwSFNkTkx5OE93OWw1MWdvRm5HVkcxTG1TTE1w?=
 =?utf-8?B?VDVBYitRL2pud3BrZFZVSm5OSlRRa2FDSTdQcFM3L1VMdmxxbGR0VThYVmpn?=
 =?utf-8?B?cC9zbU13Q1JXRW5rMlJZR1BvRFgyN3Q1dzc4clNVdzNzOW9xVkNMV3E5L3RE?=
 =?utf-8?B?S091VHk3MXZVR1h2bUVRT243VVZuM0E2NnRYL0xnbS9DazVNWTNabzBsckZ0?=
 =?utf-8?B?MlJUc1JjK0tjdDg1K1VRcEc5NG9qL00wS1drZU5FeGJzbFlVUnMyK3FKS1c0?=
 =?utf-8?B?NkxEVWZxTDNOL1lSejE2NXF0blAzajJEUUhvaVZMTUVzcTBlUXRVN2xqdDE5?=
 =?utf-8?B?bFhCbkFxcTVheENtak84ZWREM3ExMEVvVTc4UXJpRHB6NFRzOThIL2RQekZZ?=
 =?utf-8?B?VUJJQnZHdHdZOEw5bms5UWhOZmRMUzJocW1YNjYwR0F5R3ZwdXpldGNzU3VS?=
 =?utf-8?B?MENJZmZBY1JMZ2tJQUYrZlhqTUl3MkhLSlFteVRQZ3RLcXowNVVMSkhEQW50?=
 =?utf-8?B?Vjd6aVlRMnVubDliWXZ0c29HUVdRTWcxZUdTeEp5MUI2dEdPUHhLbmlMZmla?=
 =?utf-8?Q?jW7TJScQh+gpWm3wpjm2Rp3G3bFYBswS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2hYVFRxQ1gzRWhRd3RiOWpZNkhxY24rWFcxcmtqcVVwYUxhaDlLbU5MMDl5?=
 =?utf-8?B?aEwxa1hoZ0hKZkUrK21MLzM3elFaQ0ZYY21QWndvNjVmVnFQRkExVFlyQmtj?=
 =?utf-8?B?NU5PTnJhVkpmaWI4alh0alRWVVFKbzBacksySnNWdExtWk5RU2dQRU5nL0o1?=
 =?utf-8?B?VnBiaDBMNUFwaWJrb3Y2d0tqVW5iMWZVYjFNZHNrYUpsSWZHQW1TZWRKcHBM?=
 =?utf-8?B?VTdTR0doUjNhNGlCT3l2a0ppNGdSTmt5VzhFaUliMkRTSStpU2xhUEFGcnVj?=
 =?utf-8?B?NGpLdlZOajNuVkxaS0lKOTU2SzNCVGY0dHYvT3RqUWlPUHVvc0FBeUFjVDBh?=
 =?utf-8?B?KzBDRlpvY2pyUW0ydDFWVmd5QXhaeTZhcDBxdTRuT2wwWGFRRkhxMEdvbHVt?=
 =?utf-8?B?aUtxbmp3YTh4emR6M0c4WkJjZi8wMUR4a0hZTHdVQXVqa3dJVlUvRlBhSlNE?=
 =?utf-8?B?NEQ4Q2wzNFdHVUxQR2xPaWpqZXEzOXdyWnpTdk9JYlIwcWtybm9FMktIbE5D?=
 =?utf-8?B?c3RnZmllcnlBdTlhY0FwRFRTVFJhRDY1YzlVK2xqU1JvSE5FNFlsSWxUT0Jh?=
 =?utf-8?B?aitOUVJKZ0d4UWdteUp1dUV4TXI4ZXQwenhMYjlZbFpXM0NUZ2NJN05ldkpO?=
 =?utf-8?B?NDFkN0NENGc2d09IUVdyck9JWjZyL0tPSTVoa1haYWdiNlVtdkQzcVFFM0hx?=
 =?utf-8?B?dEdSOE8zOWxjd0ZuRE4yTXVYM29oZGRWSyszbEV4MVFqMEtxNUJPSEpMSVNF?=
 =?utf-8?B?cXFiUzJrSXBUY0VEN1kvcmdXNHBmanB6K2hOT3JEWGNLWjV2N1pDRE5LdlVN?=
 =?utf-8?B?OVFHMW1vN1JKY2RTeFg0UFdiUWxGS2l4Zk1ycFV1MnNKYVBBQXJQc1lCVFB2?=
 =?utf-8?B?WjVBSjcvaVVtZEpycUlPNjJpeUQrQXdJYVU0b2NQcWpNTVdIZFdPZFhsQlRs?=
 =?utf-8?B?TkMwNW9JTCtObCtLamFVdE03TVM2Rm1XY1Q2MERMTmFlTGVxMi9kRHEyS3pp?=
 =?utf-8?B?Rkh2cldnVDFIRFphV2lVWGVmWEdsYTlhZEk4eGNiSzJicHdZRG5Odjdvc2VL?=
 =?utf-8?B?NGluNm5odytSay9Lb21sYXBsWWFaakZyQzc4TGwyL2dRSGdGODUrL0NsckFK?=
 =?utf-8?B?MXVndUVmSFI3cmNKMGNJYjRNNTQwbXVHT3NWeUZDTUM2cG9qY040Yk01bVVz?=
 =?utf-8?B?VzNleENoL1QyQkxkSGdjV0lFVWZEcjY0V2t3WFc0UjZkNlBMRTk4a0wydWVS?=
 =?utf-8?B?Q3ludU8wajZxWG15L0ZhelJXdnMyUFNxdnVvSG15OW9SSFpWQXdlUFhlUGRR?=
 =?utf-8?B?T2RXbHJab2k5Mmx2cTlaUmVFWjAycC9aS0pZT1g5OUpVdlFleElwU09BdSth?=
 =?utf-8?B?RU9VZGF1d3BZeU1Ya2VNbkVvQUVTR1F6RDIyWHNGTmp1N1VDeXpCYWRaeVlX?=
 =?utf-8?B?Z2NSd3lkcHNBZGxCN0VsYlZXU3gwd3RtQTRMeEdlUUxRWk5Wb3RtSzlIY0N0?=
 =?utf-8?B?N015dGtYWjBmRGdHaWY0WHB0U3N2OTd3RWdYZnhIUzZISnlFaGc0cjdVbmxM?=
 =?utf-8?B?K3JZaFNxWFJCRnErbzV1TGZLUkxlUS9QTG1Lem53dlpNNDhmTjdQWEk1Q2dx?=
 =?utf-8?B?NVh2QXpEQnJIVjhBRUJMZTJpOGcvZjEwSjR1aXROVld2eDA4Y2FialFLZ2xO?=
 =?utf-8?B?em1nRVpWdlJUV0UxTTFDeXlveFBzTTVUY3NQQ215Y0NmaWRFSHRFSFJHNFF0?=
 =?utf-8?B?a2htQVR3bzVuNTJSRHhjZHNQSlM4Z1ZsTzJmVnZjOENCQXcyU1NtY0tQejVk?=
 =?utf-8?B?YmhXSDJXUTRUSU5CQjB0MWtkcXJGYkFGM3MyWUx3N0V4VGdEaVFIWVVaMUJk?=
 =?utf-8?B?MTlCck5FNnBkOVZhNTRjZFdhUHVMSHFQVHVKK2xXSmxtN1pyaXJSNjMwcUhj?=
 =?utf-8?B?V1V6MzhPUDZQM2dsQlNQNmJxREJJZWMvYUJ5ZVo5eFg4VzcxMGVKRlRpbnFX?=
 =?utf-8?B?VE41VVNoQ1VPbFZ4cjFoNEZSODh1T081MEhJdWdFZERlV0JKajVRMXNwbkVO?=
 =?utf-8?B?eklXOTRiV0kyaTUxdnJvRU5FenVCT3BGT3E1S3NxclJHRENuSU02MFNCeHVQ?=
 =?utf-8?Q?RuPmyaHASxaX5jeIqgITK0HMD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8742c6b-7542-46c0-c7e7-08dd2c6ea4b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 03:19:47.9300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqENs+muCi58AQQGYdQZ0r7d7kqASeKB4tgvm27U8h/mcw62u5yO6S/H/HrDL+Z9FA5YJNl1XmmDgbKws9G0Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9566
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

Enable dynamic settings to mmcdev and mmcroot for i.MX8MN-EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mn_evk/imx8mn_evk.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/board/freescale/imx8mn_evk/imx8mn_evk.c b/board/freescale/imx8mn_evk/imx8mn_evk.c
index 6b6fb0a7dd2178a20d9869a1b478d5a8b5124ad8..da91d81ebd273163fc042924c77c0a23b77f7e4e 100644
--- a/board/freescale/imx8mn_evk/imx8mn_evk.c
+++ b/board/freescale/imx8mn_evk/imx8mn_evk.c
@@ -3,12 +3,13 @@
  * Copyright 2019 NXP
  */
 
+#include <asm/arch/sys_proto.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
 #include <env.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <miiphy.h>
 #include <netdev.h>
-#include <asm/io.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -35,6 +36,10 @@ int board_init(void)
 
 int board_late_init(void)
 {
+#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC)
+	board_late_mmc_env_init();
+#endif
+
 #ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
 	env_set("board_name", "DDR4 EVK");
 	env_set("board_rev", "iMX8MN");

-- 
2.35.3

