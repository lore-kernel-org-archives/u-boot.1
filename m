Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14058D5B16C
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 14:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3244980081;
	Mon, 15 Dec 2025 15:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qjpg+s59";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82FFC8042F; Mon, 15 Dec 2025 15:15:10 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E87680050
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 15:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/Mcc2I9T2ida4R3NLUT/uAv5XjjDKUUIYtmtWPNTkDLkj6rcbpy4C+S5p/a8E2kaU0g85s6o3VENcKyI2zd2z+1jf2XqGDdwJ7rmhPVsJZVyeLo6haS9SzxjAIyKYa8MkG1EyohIsZncQGHHudh7gs/sLl1VB0lWVCJ8kPem9EXfVqplxm6zqHLpdlp/Kg9N2oPu7na16k5krDbROYd4nswy3lQ952KdFZ/qXXp3VR/0A5lj7XfgG2G0BAhzRJR1sKvwVNuhe/gmvaAJnc1uqnTu+xtiw7LrFL0i3W3XKTZUlcbfmB4Z/EtgGjUhmgNfjlTBhHiGc8TeEOxLMN8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0S/6m1EpuiBp43Se3DEHGuqgfkZppVOqqf1oRRPGO/Y=;
 b=GHJGNuyOWOsxiKQ3444yn94hg9+hZf/Rwu/4PO/g1Ad8SEEwxo6TTBEYvAZ2C3D/+68EKnpbR57wn/exEQNggweCF6JSHpbkNlPgCG6/a2xPxTiT+vsQhZMTCcrNSWQKVvA40WrrX1dsUV66/Gf8Bp1Zl99tx3XhMBV/SqCbyNipm+oB/ej0XBgZtFIatl7Bc4T2HwY7J79We5qy9y2TDSvi2q2x/bSwc/jmbwMfsbnDvgOwdEI2p8yNrzbCUo/wsSQtrJaT56/HS6jNcfeG8raTHyij5lTZwqKtNkZyhSCVbxoHskEabi8Aw4Gra0l56GI8Fui6kAK4ujcJ3zFcVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S/6m1EpuiBp43Se3DEHGuqgfkZppVOqqf1oRRPGO/Y=;
 b=qjpg+s59w6siMr20YGZhx1Hv4Gbj1JEPe2guMdWCu1cZvNPdhLM2iFZAf3+7PVNi/9gwOhhYiuDGIQfi6lva6qoOOdHT8w0sh0Y41IryAGM+YDOEGeKOwNbtRJAcqzhI+AcTsbRRGGcXb78h3iNqtt0tlyawbuNjqDtOYegl8F45bFr/pJ23j0wsVgVXVp5fqAMm/5lTnYARI+r29fitYnHyrpdGE5kHou9Lw4xmUtoTQgY+ksNN9/pLVR4ms4/16BbkrqMzG7dFInXN6r6XMSDD+3lvppj1Kr84N/xCxtSvl5LnddlJuYruc8a/PMT/Qz/8avOIs21w5oO2VsyPPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AM8PR04MB7892.eurprd04.prod.outlook.com (2603:10a6:20b:235::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 14:15:06 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 14:15:06 +0000
Message-ID: <015fd20f-cddf-4c63-93e4-27227a72b795@oss.nxp.com>
Date: Mon, 15 Dec 2025 22:14:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: imx: imx8m: soc: Add support for 'boot_device'
 and 'boot_instance' environment variablesAdd setup_boot_mode for imx8m
To: Fabio Estevam <festevam@gmail.com>,
 William MARTIN <william.martin@muxen.fr>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>
Cc: herve codina <herve.codina@bootlin.com>,
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251203100212.78546-1-william.martin@muxen.fr>
 <CAOMZO5CnohMeGvxrVNhxdWQijd_LT8mNGvA8UDW1XMRwJ=Dwtg@mail.gmail.com>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <CAOMZO5CnohMeGvxrVNhxdWQijd_LT8mNGvA8UDW1XMRwJ=Dwtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4PR01CA0106.jpnprd01.prod.outlook.com
 (2603:1096:405:378::13) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AM8PR04MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f22a162-01d2-48aa-f052-08de3be457ff
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|42112799006|19092799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDdSbEJybko5bGdrRlBtVllIUnF4Nm5MaTdXS1JuUU5jSkxSV0N6SFo2NXNI?=
 =?utf-8?B?bTkzUFA5OER6TUNtTFd0eDlBckJqMU85dmlyY0RyRVkrT1hXQUhtRzBTTTJo?=
 =?utf-8?B?MERNMkJYTEFNREtma2oyR1J6dVRaWkZhUXFZN082K2Q2ZHMxODVvai81SkFN?=
 =?utf-8?B?VXRXV2s3UFlKekhXNnFsMXIrb3RMQll2RW5tdU1zWXR0OHBYaU1WVmpEVDVB?=
 =?utf-8?B?QWVPeVpzZUdtZ3k2NUQ4Mno2QkJESU4rNW95K3pWbTBJYm9ZbUJIblpGK3M5?=
 =?utf-8?B?bnFyTEpYdkNCSkxVTzYxUmZwQlM1ZzNmZEJMdGVORUlVSDhhR0I5cENsZ1Fm?=
 =?utf-8?B?Zit4SDk0TW9VL1dsaUNjdHN1VnV5d3Z5bTVROVlOT2pyN3J3dDgzV1ZzSUNu?=
 =?utf-8?B?VlF4RGtwbTM0NlE3cUZIakp1VlVSNmpPcmZNUng5STFldjFYWmZwRmM5YXk4?=
 =?utf-8?B?VERBMmVzVnIweVVQa3JrMUJ1dWQyVkY5WVVhWWZBTDh6Y2FDdnlHN2xmWHRy?=
 =?utf-8?B?QzkzdkJuVWdYVVlOcCtBdmJiR3UzU3ozaHZBK2FEdFF0UWV5QWJmeVlxdVFv?=
 =?utf-8?B?Z09wakZleWQ5dFVzMlNnNTYrOEFBeU1aSm5tcnhpMVpJbC9iZ3NnMjRwL2p1?=
 =?utf-8?B?c0RzTmVHV2lKeWtrTWd6TkViWG1HMU1XSVZJVHNYWG8wTUNxbCtWYlkvQ282?=
 =?utf-8?B?Z3krK2NKTlU3YzJKa1B5ajlVRW5ZMHpxTVJUL1BjTVFUbVB0aUJVSUMwc3Bk?=
 =?utf-8?B?VjlCazZXL09iZDZKOHVlMytFNUpUZ013UnU1MUNLZDRReDJNZS9wMjR6akw4?=
 =?utf-8?B?amZ2UnIvZkFnN2Q1QVk3WGpiOThyOGpvV0dqTzJLaWxBQzFhT2VQYlRiQ1hu?=
 =?utf-8?B?MmhNZVlJV1JaeDIyYXRKZ1V0M1l1U2tSUEtBTVFPTE5obWVTNUQ0dTE2S01E?=
 =?utf-8?B?QjhhczNQSU4yU3RpeW5na0E5d1ErbElacUR6SjczcHVsMEpmUiswcWl4SFRH?=
 =?utf-8?B?cEd5Zy9rcmpJYmtOYklzd3RPaXNLV0NHV2tzNGYwQ3hDWFlKRGxpSHVPTnMx?=
 =?utf-8?B?dzdaUHZmYllRRmZsYTBvdmZ4SGEwM3lVMWdWdFlBU3RMTmlOaGpsWXdrME90?=
 =?utf-8?B?VHFDc21KMXkwQ05oSU9BNGRvRkVhR0d6d09iNTRrZzBUZ0RPdzBsalFER1ZW?=
 =?utf-8?B?RkpiSk5oZlRkR04xdEtDaEY3dC95NExmR3A0Ny91NW1ITVJlVVpRRkp5MG1M?=
 =?utf-8?B?am5TMFo4bEhIVWRibVFwMkVjZ01ORGtXcnRFNWtFYnlYRWVPNjV2VzJzUENr?=
 =?utf-8?B?YU9laFFOOVJtNWIyZnBoMGtVWmxxZ2RjeUY5MkF2WjJmVEt2WHN4VTAyMldB?=
 =?utf-8?B?amFtL1k5RS8rSDZTOFF1ZmhUQTFWM2ttWTJxcHlhUmpvMzZPdUJlNjhDV1FT?=
 =?utf-8?B?cjV5RDZTMk5HbU40QklKb2lqNG9RYXFwNExGT2d5dmF6R3J0T3FUMTBWblcr?=
 =?utf-8?B?R0lhRzFEemFFaHlXZjlQdVdLTWY4NXRnSUtpbE9uVU5KS09iRFVqZTAzSDNJ?=
 =?utf-8?B?VXBZYkNDZ25TdlZRZHlFTFpvUWRObm44cFdZOGZ5VHBlNnhnZlYxYkNBODhV?=
 =?utf-8?B?dXJWVUpmdWtOcXc1ZnhvZ2pMd3c3RmkwZ0ZhVzNCWXF3SDdLRnY4UTZJTXpr?=
 =?utf-8?B?dDEvNjhzRlZ6c2QyL1Q2Mmw2amFkSzRjSXhSUWtXSG1tdkxzekNJWnVuWHB4?=
 =?utf-8?B?Rkc2TlYrZHIxZXo5a01jZC9XUzV2SGtxS3dRTFNFbkZjNkcwR0E5cktrL3Zz?=
 =?utf-8?B?Z2sreUZqd1pZcU8vUEVPOXZHZnh3TGZsYStjUDJLNHp6RTZkV242UnBrdnMv?=
 =?utf-8?B?VTN6V2plZUlwdW1RUzFFYktaVjNwVTBBTkhPdGplWTVzZkp0ajlBUGYvMXg4?=
 =?utf-8?Q?9c5cgZxk8SGVBl6B+vVZlemmZDXETDkd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(42112799006)(19092799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGc0Wk1vYTdNUlk2SHNzM2RXS01VeCtMQmN3aWU0c0phWXhGM3huWDNTWS9J?=
 =?utf-8?B?eUdhekZjNzh2NG1VWjc3VmZGUUNPZWVkbmt3Zkc4cEo1OFpRa0JFTzRlTmx0?=
 =?utf-8?B?MHBReDRmZkVGMVZDMWhVVHZDWktEeTYyQXBDQ1hZRDVpREtwb1h0RVJJL3BL?=
 =?utf-8?B?WXIxZkdoSFozZVFJajJFditCemZxQkN1bzM0U296SmZFTjgvaWIxSXhrVWJM?=
 =?utf-8?B?UFVHVDlOTGZINHcwelpmQVBaUXJsdFZtWm84aDE2d0FWUzZnYlBKRTlCYzQ3?=
 =?utf-8?B?Vnp2dVJsMnBBNU5iZFIraUQvOXVwSjZOMDU1eCtPb3pqNTh4b2V3aWRDT20x?=
 =?utf-8?B?TkFra0tiWTI1bG5waTZqdU1KRFpTbThwSmM3TGI3ZWtDdkRXeGNGa01vKzhz?=
 =?utf-8?B?OHdzYjFjbWZNbXVCajJEUlg0b2JLSTR5TEN6Q3pzb1NRYkJ3Rk9EbVg1QVlF?=
 =?utf-8?B?ZXZHK2Ixb0VocE1tK1FTNXZUSTgxU0NuQzJiekk0VWwxZGEwWGwzQUsvVExH?=
 =?utf-8?B?L1FUSm1ybzBsckc2TkwwT3Fkdk9rWm53TkNwZDV4Y2lKa1NSa0J5SDVFL1lo?=
 =?utf-8?B?dmp5SjdjN3B1TVAzUWRqVGp5SDc0V2dOZ1RsbER6SmtMRG1kakRMUUk3VkVh?=
 =?utf-8?B?c0tsLzhoMmRUYnEvTzlveGt0Rnd6SWUwODQzVlFnSVQvQWEra1pkcU4wVFo0?=
 =?utf-8?B?dHNvOW9zZllCMFBIVzlzUVJ1T2hVdTB3QmFNQmxwOUdOekNEMW5weFRNMlA1?=
 =?utf-8?B?OUd6MXZDU3U0WDE2czR4YzAzYWN2U3YrVnFYdnV5Z05TK0U3cmREbDJhQ1Yw?=
 =?utf-8?B?U3VoK0lpd3lnSWplbHBuY2ErVWtpUnE0cTA5MUQ2TlNaL3Fscm5qdHpkdnpa?=
 =?utf-8?B?ZzRZK2ZuQ05kejR3YW1PSzNlNjBxK0x6Y21lZkYxa01zdkZ5N2x4UW13T3E3?=
 =?utf-8?B?MlgxMnl4em5WN0lXMmc3ekF1THJoZkFoSlo0dG1hRXR3cUpTNDlmcHk3UHMw?=
 =?utf-8?B?MmFQbTRNb3lKcFpqOVVzbTd3M1VBZUtTYUlCekNjOVNLNkVLL0ZGNFZDb1lr?=
 =?utf-8?B?Tzd2QVRhL0xPc0loTENNN3NLRHVjbWNSTXM1cTczMnNBNEdxZjRwT3MvdEpB?=
 =?utf-8?B?aUJiZHRkUXROOU56UHpMYjRwanFRKzA3N1pGWWdOT3FGYjR5YXByN3JUVEow?=
 =?utf-8?B?Z3hINXlKOXlQY2FUUVc0OTVpYUhRa1Q1R1BoMSt1NTEzdGw2djVYelFIRldV?=
 =?utf-8?B?VUtxSllOUDRNUk9SVC9ieVplOVVXcnpTMlpBWFliaU16cDVVZFh0cFJkRk55?=
 =?utf-8?B?K3dYRmF1endrOXAwTTZUSFVxM01rNHhaZUlJRHA5NDhiSFVkR3NGNDBjWXNa?=
 =?utf-8?B?TGhRUlhiNEdpSUcvY1JRZG9XSGtyam1YMnlxUEp1UnI5RUN5dkJOUGFwS0Rr?=
 =?utf-8?B?UVhEVmZZSjNWUDlDanlXQm84TTB2d3RlUktRTXhDdWkxZUJJSkdHWUpTUFNR?=
 =?utf-8?B?MFVDVW1CMGxwNTIvVzdVNmhicTN3SXhpWFRIeWYwNFJwVzNIb1ZjK3hCaWgw?=
 =?utf-8?B?NVpST29IVU5MNHJyWVBtMno3bGFBWGZoWTdtVDRXck4wdCs0NjZ6M2JodlVq?=
 =?utf-8?B?L2Y5M2dOQ09KYXI2L282VENyN3BZWnR5blQwbFJ2dzV6em91SHFjbEI0Vjlm?=
 =?utf-8?B?ZHoxQ0xCeGUyelBHaEdlQ0RrYWN2d01XaTBMUmpxT1dQOEVCeHJ2UEFDTzNS?=
 =?utf-8?B?U092ZmMwMGdrM0hvanMvYVllNTN6Q0MxU1BJdllPUTR2ZTFTUkQxd2dMeG1s?=
 =?utf-8?B?eW80MkJUOXZyMDhHN3ZMUjJSRzdnUE1wOXNHdEhRYWN4WWNZSlUrOWUzMWZM?=
 =?utf-8?B?S05abUR1UFdTVzBBbFFtQlFiQURUbkR4bnAyRGpwRW9MQmxYMEdnd3Fqa1ZH?=
 =?utf-8?B?Y01QaDhPMERpby9DcGRnSVd4Q3drQjVnZlpWZVIyKzJUZ3FlSHYza29paE1v?=
 =?utf-8?B?U0NKQ2VncnBzUnRUeHNuNDhkQ3JwSnMzUVdycjlrTkVBN2ZTZUw0QTB4Q0Ja?=
 =?utf-8?B?MVpaNjlBaHJwRHF5RVJod3lacGtVYlJOOFZPSmxtVTU3bC94TzZEbnJvY2tF?=
 =?utf-8?Q?4WW3vSiKeHWo/vzQpSVhaqYpF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f22a162-01d2-48aa-f052-08de3be457ff
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 14:15:05.6479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OvTwAIgqcHFPe0YhFWdOeLReU5JDeuNp53q8qM8jEjDKS4+W4+a3LpGCjvIB3vk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7892
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



On 12/6/2025 5:16 AM, Fabio Estevam wrote:
> Hi William,
> 
> The Subject line ended up super long.
> 
> On Wed, Dec 3, 2025 at 7:02 AM William MARTIN <william.martin@muxen.fr> wrote:
>>
>> Some SoCs have supports for 'boot_device' and 'boot_instance' environment
>> variable. Those variables help to choose the right boot media during the
>> execution of the boot command.
>>
>> The i.MX8M SoC doesn't have support for those variables but provides
>> internally all the needed information to create those variables.
>>
>> Fill this lack adding support for those variables in the i.MX8M SoC.
> 
> 
> Peng/Ye Li,
> 
> Could you please help review this patch?
> 
> Thanks
> 
>>
>> Signed-off-by: William MARTIN <william.martin@muxen.fr>
>> ---
>>   arch/arm/mach-imx/imx8m/soc.c | 67 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>
>> diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
>> index 1fe083ae94f..f39f2e90e55 100644
>> --- a/arch/arm/mach-imx/imx8m/soc.c
>> +++ b/arch/arm/mach-imx/imx8m/soc.c
>> @@ -1472,6 +1472,71 @@ void reset_cpu(void)
>>   #endif
>>
>>   #if IS_ENABLED(CONFIG_ARCH_MISC_INIT)
>> +static void setup_boot_mode(void)
>> +{
>> +       enum boot_device dev = get_boot_device();
>> +
>> +       log_debug("setup_boot_mode = %u\n", dev);
>> +
>> +       switch (dev) {
>> +       case USB_BOOT:
>> +               env_set("boot_device", "usb");
>> +               env_set("boot_instance", "0");
>> +               break;
>> +
There are two instances.

>> +       case QSPI_BOOT:
>> +               env_set("boot_device", "spi-nand");
>> +               env_set("boot_instance", "0");
>> +               break;
>> +
iMX8M does not support SPI NAND boot.  QSPI_BOOT is for QSPI (8MM/MQ) or 
FlexSPI (8MP/MN) NOR flash boot.

>> +       case SPI_NOR_BOOT:
>> +               env_set("boot_device", "nor");
>> +               env_set("boot_instance", "0");
>> +               break;
>> +
The SPI_NOR_BOOT is for recovery boot using SPI controller from nor 
flash. This controller is different with above QSPI and FlexSPI.
Is there any naming rule for the boot_device? You need to distinguish them.

>> +       case NAND_BOOT:
>> +               env_set("boot_device", "nand");
>> +               env_set("boot_instance", "0");
>> +               break;
>> +
>> +       case SD1_BOOT:
>> +               env_set("boot_device", "sdcard");
>> +               env_set("boot_instance", "1");
>> +               break;
>> +
>> +       case SD2_BOOT:
>> +               env_set("boot_device", "sdcard");
>> +               env_set("boot_instance", "2");
>> +               break;
>> +
>> +       case SD3_BOOT:
>> +               env_set("boot_device", "sdcard");
>> +               env_set("boot_instance", "3");
>> +               break;
>> +
>> +       case MMC1_BOOT:
>> +               env_set("boot_device", "mmc");
>> +               env_set("boot_instance", "1");
>> +               break;
>> +
>> +       case MMC2_BOOT:
>> +               env_set("boot_device", "mmc");
>> +               env_set("boot_instance", "2");
>> +               break;
>> +
>> +       case MMC3_BOOT:
>> +               env_set("boot_device", "mmc");
>> +               env_set("boot_instance", "3");
>> +               break;
>> +
For SD and eMMC, shouldn't the instance index start from 0 not 1?

Best regards,
Ye Li>> +       default:
>> +               env_set("boot_device", "invalid");
>> +               env_set("boot_instance", "");
>> +               log_err("unexpected boot mode = %x\n", dev);
>> +               break;
>> +       }
>> +}
>> +
>>   int arch_misc_init(void)
>>   {
>>          if (IS_ENABLED(CONFIG_FSL_CAAM)) {
>> @@ -1483,6 +1548,8 @@ int arch_misc_init(void)
>>                          printf("Failed to initialize caam_jr: %d\n", ret);
>>          }
>>
>> +       setup_boot_mode();
>> +
>>          return 0;
>>   }
>>   #endif
>> --
>> 2.47.3
>>


