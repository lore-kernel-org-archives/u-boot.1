Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F327C3ABD8
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 16:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E80A1829E4;
	Wed, 14 May 2025 18:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FLeAVNa7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7191582A0A; Wed, 14 May 2025 18:12:19 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3877982162
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 18:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvdcIRJd/fyuHQuRO9Bs/Ed6kKNimYUOdjlOAerYacZjnCNV29CnoKLzgRKRgDUhe2Gk1W1PPaa/YFZVYmxf1S8CtiEjCHm0Pxw7EJLYWTmiueyxHRNo7e8K5TPRdfaSTIE9Bgg4SKBnpyJwKA7gn/shpIRLRVU4TSTIznL5HaIm9chCJx8QXP/ok0V3wjAQU8dcOSDGakmK1I+/8j7AVoit5gsiaIp3Mj5lPcuyxJR4vNcBn2p/lvS5/ZyUyi4tQDmDPo30MnAnslYSUEJs053yYu4a0ueO3L8a4VCXOE6K44RpX0c7NwKKOM/mJ/FP0CKpdcAgkSBJ9k0vDm6KGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nn4V8LQhrwaNmawGfcYHGRh8X7Mia4La2sU/KDUpYU=;
 b=oEBS46EMiR+zLV4knkRoYOUt+vciUEbMxN1rigPIbt1U3txL9WFHSzT1DiR8X/ufuXfne3tRSkyDsf2mr8efvdfcQ0pTmYicue2B1+vQgRPi3EUEO8pcaP8a396yjLzc9E6BYKWJV2/dUVaGd6ytI35BUMwGVSJ021Uwiv4MsgHyX6SXj0MINC7XMxdMhtZ8ioGtn+OZzl3D747/OP1zGpbYFlYFirx/xAGFyvFY52ksAYY+jiRmGt3ZapMCoaxlL3kmPzPQ31YxvilwYO1wulT1SUXKkbkJv/ciqLLXkgvNkzYRCLRBAROdoOK3ruQ5B9G8dGQ4byzplW5bVdi7/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nn4V8LQhrwaNmawGfcYHGRh8X7Mia4La2sU/KDUpYU=;
 b=FLeAVNa77kNxRcrOkhZgt/KxmLX6gcw8Yk1/FsKjqNMBGqa1v+W7Rkgiml06TYPYZO3RA4r7fF5kGa4LyHe3/kolO25azkf5JoPQFzoVWl3PxgvjojwgO8rTERNsSOTSZo+WtSa0AEfW9/nQUnyb648j8zeATzOhoM3DGifPsqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10562.eurprd04.prod.outlook.com (2603:10a6:150:214::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 16:12:13 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 16:12:12 +0000
Message-ID: <b95911a4-bb5e-4b36-ba6d-0f57dc0a06e3@cherry.de>
Date: Wed, 14 May 2025 18:12:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tools: binman: control.py: Propagate bootph-*
 properties to supernodes
To: Moteen Shah <m-shah@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 m-chawdhry@ti.com, n-francis@ti.com, vigneshr@ti.com, u-kumar1@ti.com
References: <20250512115028.1783305-1-m-shah@ti.com>
 <20250512115028.1783305-2-m-shah@ti.com>
 <a3940636-92c2-4b7e-abe2-8357580c9f48@cherry.de>
 <f25f3091-43f1-45e0-b5b3-6c35989554cd@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <f25f3091-43f1-45e0-b5b3-6c35989554cd@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10562:EE_
X-MS-Office365-Filtering-Correlation-Id: 7867654a-d239-42fb-739d-08dd93021628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejdYMXUwRGoyYmtVQjdleHRiTGEwaFBzSXJQaDRDRVJHZTJNWEIvcTk2T0w3?=
 =?utf-8?B?a0dTUktDcWR5a3BTU1R1SmFneStKSStnZHdGMDQ2NVk2N1grTzJXZ2xmdUNW?=
 =?utf-8?B?WldSOTBpdmpzWGkvcGlMRlZpL1gvbC9rTVlXcWVZMFZrbFErRGNKM1BPTEpL?=
 =?utf-8?B?c0NBYWZZN2xJSW9tQ2xqYzZURXJjSTZ2RjE1aU9nVHRwdWFCc3hOaEphcDUw?=
 =?utf-8?B?dEMzNzd0SzBSV0dTVC9KSnlMNGlaV1dRbUE3b0ZDcG9rYnVpSkpRdENRMlY1?=
 =?utf-8?B?WDZ5bFVoVTFhQ0RBWjFBVWdFNGptblUzMnJwWnNMZGdjaWpHYnJ0eXA5S2Rk?=
 =?utf-8?B?YWNIQWRwdjdkRGxWWEpVMG12UUtXZ3grUytYMUFCcXh0aXB3aHNRYXhGU1BV?=
 =?utf-8?B?MVZ5Zko5bDBKNUZDMVZYWG41TE8yaGZSZWZpa0JuUVpEWjlZRTFxcW1ROWdI?=
 =?utf-8?B?cVN6ZGpNaU41ZlFtUTh2b2ZGNlYzQm5PdGZIR0Q1MnRpbG9EcTFzVnl5S0xE?=
 =?utf-8?B?NVJkQmZEZS81SVh1bDIyaklwRzJ2SlgwTXdMZHF0U1UzYzczNjRtaGhKRnVq?=
 =?utf-8?B?ZSs1ZzdOMDVkZnc3cmZRYnAyOWc3ZTZGR3FsSS8xYldVMC9JK0JUM1NlcXRN?=
 =?utf-8?B?OHVuWGdMaDM1SDhoVUlrNW15VGsvb1hLL2tYS2dCWFh1bzRaL3Z1dlNlSmpx?=
 =?utf-8?B?WFdwVE05Z2ovUG5EaXJ0elFQMXVIQlk2ckJFZnFETitRbnp3ZW1sbG5MWExn?=
 =?utf-8?B?Qm5GMkx6c3RKK1g5cWVWa2xFbDB1M24wSmJ4c2k1bVRKQzR6aWMwUnlJaE85?=
 =?utf-8?B?L01iMlQxb1MxMHFwNkc0NjY5Q3dtcTJROFlLN0Q5MnVENHZpMkNaWDRZdXJL?=
 =?utf-8?B?TzROUFhOZWIrT0pyc2lVMUxEZFBhVStEWUtUaVl2R3BjZkFad08rTkx0Qktr?=
 =?utf-8?B?T1RjaDJaOXRuR1krMW9XMzdaZG9USWlERWhuMXVDN0xCelg2YlpoL0wrMDZ0?=
 =?utf-8?B?NzBCdUZ6TjkxYUF6QmtGUWVRUSs5b2VVMkZzZmY5VGhHNWtROHRkTDZqRG14?=
 =?utf-8?B?aW5ZN3VOcXBJMzV3eXluckFUZmc2b2dtRXlvTkU0MkoxQnJ3NGtsUVVMOHpM?=
 =?utf-8?B?TkV4L1pXaENWc1BYeUdOKzRtVkN6bUFBYi9rNjNOMEEvdkVMSXFzWkJNcVp0?=
 =?utf-8?B?akpNSGdMRG1XYXQ0TGxlZG9JQXoyS0N0L0Zkd3RWQ0NWem81TXd6a3VOajIr?=
 =?utf-8?B?cWxCNnRzTnRBSnY1ZHlvNnFnSkVMR3R3N3VYWnBPcEtLTzBWT25MQ216a3oz?=
 =?utf-8?B?V2dXNjBSRXQ2VUgra3l3eXczVUZnWm1nRFB3Q1JtVWNBN3QrZTdBSC9oTTZW?=
 =?utf-8?B?L0ZBaWhlUVp5MXF3ZXFyUFEraEpMQVFJbzY3amhoQk5qVnJueVQ3NkZxZ3lE?=
 =?utf-8?B?eXVibm1lb2ZXWFVoRG1HMUlGbzRDZXJOdlpVY0Q5NGNYZndPcXpLSHpZaUxn?=
 =?utf-8?B?NzdYOWtadkpvZGhQUUEyYXEycWtjOUZEQ2hOM0grTWFkV0dDQVkyTE5MM2F0?=
 =?utf-8?B?bXl3MnF0cnI5dTJnd0VJczNOamlYQ2VzKzIvQ045OWVFZlNOaVg1RS82a3Iy?=
 =?utf-8?B?TEs2d2NqdnFhK3NKWmMxN1RHRUloWTlLRGZveXNzT0tTMTkwc2U5dU5PdXov?=
 =?utf-8?B?NVV5WEhndVVtUyt4OGd1YXVRdmxQRFhwd1h4bTlnTUpDVUQ5VFlHWC9IdEJK?=
 =?utf-8?B?MkVpWEdZYkc3R0loenhTaGJMcDFlM1NaeGJXVkRHL2cvZXZDbi9iWHRpamhB?=
 =?utf-8?B?QllnTS9JQTlnY1o1TlRtczFpREVjWWNWQ0JsSGVBaHl6dzg3a1FqTTVEclB3?=
 =?utf-8?B?VVUxVkc1TGRPN2twN1liQVFwZnZKdGlmQ2FQNDc4U2EwS0Vna2FtaCs4OG1q?=
 =?utf-8?Q?nOzB5H8UNhw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnkvMktMNVdNTUIrTGsrREVZYVE4Mm1hcjFobTV1RDlxVmlDVDZ6M3hDM3Zz?=
 =?utf-8?B?QlVJVFVBUy9HK2pNcWlKUHhNQzR4SWJFUE8vY29JZzAwZmZXMWQ3NkpZUGsx?=
 =?utf-8?B?WUQvSzFsZzlaYUtScjRvN3BhUk9yQmVBSVJHV2VzNlJlQ05KN2d3anJka1Vv?=
 =?utf-8?B?OEVKTTdBZlpsZmJnMHplaEtWWkZTcFA3WHhDQStCcDQwQlhTWUlJUVVIZHdk?=
 =?utf-8?B?L3F5WjdzNC9sQ0NrVnY1TndIV0Rhc0VEaks4MmhKVElmaHZEdU9uSWJ6YlBF?=
 =?utf-8?B?L3VnUEd5OWNBSExzTklIUEx6UGJEWmZHTk5oRy84ZDNZVmNxeXlDaWtXWmpB?=
 =?utf-8?B?VFhtbGdrK04rbElKc1Q2ajNzWFBHWEJQR1c5YzFkRGFwUGtnNm16M2dtK0NL?=
 =?utf-8?B?ckk5ZTJWVlk1TW80V0NIYlB5TTdVRlpWZHhKd0gzazZadGdHak9rdERTYk5D?=
 =?utf-8?B?cElrYXBMWEovNmZHUmQ0ZzRaS3Vza29TWXZkMHVEZVNLbFFCMVNFN1prb2ps?=
 =?utf-8?B?RkVSUmdEeTVYcVpxSi9MVlo4b1lvOE9JdVlxb0p5NFBMbDhLalRwMUJ5T3NR?=
 =?utf-8?B?WFdHYkxEejYraHMxbUp1RTJzdWxqb0N0WWwvUkpyT2I1Rkt5Vkk5VVo4NnZK?=
 =?utf-8?B?eGFoVlBhTk1zZWZYY1B5Rmgva2hBUUxSVjhKSnZmR0RpUmIwSExHWUticjU4?=
 =?utf-8?B?WGtOUS9RUzdVdktzY0RNL1hTQ3RpcnBzRkJUVHgwKzZSRVlOaWFYcGIxWENC?=
 =?utf-8?B?MERsL3VoT0hmOFpPbGZBQ0ozZzhKYnhKWVQyT2NDNE1FeDRHQ3A2TXdVYmtS?=
 =?utf-8?B?R0t1WTZ2ZFFhMXA3UmNWZGhNa0VETVhGWG9uVEF2M2hCUWhOZklHdnUwdTRh?=
 =?utf-8?B?SGVqK1hONmk2dlVNMUpTTDRIYlYwOUhFMjBnNUg4MEgrNkdXajYzdnJscGQ2?=
 =?utf-8?B?c3l4bGdSYldTOW9WNU0zc28rL2ZTOTAxTzFtS1BDbGVxaGdXa0daazNzUmJp?=
 =?utf-8?B?a0lPY05TYm1EZDR6a3lyMUlMTFpCRjZVamxKRE1TTkdsbVVTaDdwRERXT3Bh?=
 =?utf-8?B?YkJNcEhCVVJSdnNDdEc3WXIreG01ODdCeVZqbmFXMzNtRGtaS2prME5PM210?=
 =?utf-8?B?UVBobk54SUNrNUZROU5RU1p2dHhhd3dBbVhVVUo2T0dPYU9IUVlZN28waGpi?=
 =?utf-8?B?Z0tFaWVWdFhGZU9kWVNLd3M4Zng0ZlJFUHZJd3Z3ZnR0eFVIUjhTM3VidGI3?=
 =?utf-8?B?QXUvNHlEODNOYnpYSU1USzBVa3FkdkR4Q3JXNDZZZHVjQUJ4NFBNaFR3OGEx?=
 =?utf-8?B?OVFCQmVSUCtoeHJHb244STZ1VlVPWDFOR1JuTC9jQkJ2N3ZIeHZCMUpoMjFr?=
 =?utf-8?B?OWFQVms1RG44MzRicEZrd3I1RzNsT1pMZUxFRHArblJ4d3ZQY0g1c2FsNnpk?=
 =?utf-8?B?OHVZY3dmV0FCbVZMeVdCRkRKTzlvaW1pZkNhS2w0YUx6TWxpMmt1RUFQUFlt?=
 =?utf-8?B?cVEvUzd3alJOV3NldkVweE9sa1p0MDRpeStzNzRWcVNJN29tYVBvOHpralZl?=
 =?utf-8?B?eWFTajNELzZrMC9JVFdLQmlpOVJtM2tuWXZkdkpmeXhYRkplQ1UyQ2NnRk12?=
 =?utf-8?B?QXFwOXlwOGU2bXBkam5CVndqd3ZqaDJUaGpHNVQ3dmEyNk9rbm5ObDE3OWRZ?=
 =?utf-8?B?Rm5EdERndGcyZGhFVGNCTWdLc2xCWE5LSXg2Z0U5RlBvSlAydTkyNzBwWWc5?=
 =?utf-8?B?UDg2d3dIQUluZFkwNENBckVFbWFlTytxNlNPSk9ZbWxZc3pLVmZad0xpL0pU?=
 =?utf-8?B?b0lnditKZGNUUzVWYmYwWk5vckx5czNjTDVZWk51U0N6ZFRLZkZBb2lVeEx5?=
 =?utf-8?B?NGQvamd4cXlhL29SNmlrV2lxYjY3em5qMWVrTyszYXRWeFlqVzVrZnVxdThY?=
 =?utf-8?B?eXZad1E1TllJQjNLOHk3cmM5ZnY0aDVENzBEd3VqOVpjeTVMZkNQTGhDMVBt?=
 =?utf-8?B?Zy8yVTNyS2tDSWVyd0RUSDhkMEx5WHZ5MkMySmFEblRDKzAvekVITDlEQ25w?=
 =?utf-8?B?Y01kZHYwMUZDZ2xnL1pHWTcwQTlBYk1WUVA2UktZME5pZnZVRHV4c3p6MUVY?=
 =?utf-8?B?THpLU0Z0VDY0QkQ3STRERlhVd0JVSDB0OXg0S0Y0YTNZVG9Pbk1iaUNrZ3lm?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7867654a-d239-42fb-739d-08dd93021628
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 16:12:12.8780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3pfOy4SstHoixNPFAIa/B5Ay8Hzh3cuFl/ugOmNlUhlQH7g6lOnvKcCaNmdBll2NnA1Vkrm0YWz9b480k9m46N0+cJmM1vsWoDPKfKw19k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10562
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

Hi Moteen,

On 5/14/25 8:05 AM, Moteen Shah wrote:
> Hey Quentin,
> Thanks for the review.
> 
> On 13/05/25 16:10, Quentin Schulz wrote:
>> Hi Moteen,
>>
>> On 5/12/25 1:50 PM, Moteen Shah wrote:
>>> Add a function to scan through all the nodes in the device-tree
>>> for bootph-* property. If found, propagate it to all of its parent
>>
>> It's not scanning for bootph-* properties. It's scanning for two 
>> specific bootph properties, so try to update the commit log and 
>> comments so it's not misleading.
>>
> 
> I will update the commit message in the revision.
> 
>> The commit log is lacking information as to why we need to do this, 
>> what this helps with and why this is specific to bootph-all and 
>> bootph-some-ram.
> 
>  > Why this is specific to bootph-all and bootph-some-ram
> 
> The other ones are handled by fdtgrep as those are for the SPL stage.
> 

Yup, the issue is that the non-proper stages do not actually read the 
bootph nodes as they are stripped by fdtgrep. The DTB for the stage is 
of everything relevant to the stage, without the bootph nodes. This is 
done to save precious space (instead of having a full DTB with 
appropriate bootph nodes, we only keep the bootph nodes and we strip the 
bootph properties from them as they are now implied). However, the 
proper stage (and specifically the pre-relocation part of the proper 
stage) uses the full DTB, with bootph properties. So we need to 
propagate them so that pre-relocation works as expected since it'll 
check whether bootph-all/bootph-some-ram property is part of the node 
before probing the device.

[...]

>>> +    Args:
>>> +        node (fdt.Node): Node to propagate the property to
>>
>> Specify that all its parents (recursively) will have this property 
>> propagated to.
> 
> It is iterative not recursive. How about: "Node and all its parent nodes 
> above it to propagate the property to iteratively"
> 

Mmmm, true, I had in mind that recursive also works for defining "parent 
of parent" and "parent of parent of parent", etc, but it really seems 
the term is specific to recursion, which we don't use here.

Can suggest something like:

Node to propagate the property to. Its parents (and their parents, and 
so on until the root node) are also propagated the property.

[...]

>>> +    changed = False
>>> +    for prop in bootph_prop:
>>> +        if prop in node.props:
>>> +            changed |= propagate_bootph(node.parent, prop)
>>> +
>>> +    for subnode in node.subnodes:
>>> +        changed |= scan_and_prop_bootph(subnode)
>>> +    return changed
>>> +
>>
>> I have a gut feeling this is suboptimal, though simple and easy to 
>> maintain.
>> We currently go up to the root node for each and every found bootph- 
>> {all,some-ram} property. We could simply divide this by half (or more 
>> if there are more properties to propagate in the future) by passing 
>> the props to propagate instead of just one. We can keep track of which 
>> node has propagated the property already and, for its children, stop 
>> the propagation at that level instead of going up to the root node all 
>> the time. I'm not sure typical Device Trees are deep enough for us to 
>> care about that kind of optimization for now, especially since it'll 
>> be running at build time only?
>>
> 
>  > passing the props to propagate instead of just one
> 
> Since we are only concerned with the post SPL stage with this patch 
> since the SPL stages are handled by fdtgrep, I am not sure if adding 
> this optimization would result in gains assuming that bootph-all is the 
> superset of all bootph-* properties(this patch concerns only with some- 
> ram and all) and adding anything with bootph-all in the same node will 
> be redundant?
> 

Something like: (not tested)

def propagate_bootph(node, props):
     changed = False
     while node:
         to_write = props - set(node.props)
         for prop in to_write:
             node.AddEmptyProp(prop, 0)
             changed = True
         node = node.parent
     return changed

def scan_and_prop_bootph(node):
     bootph_prop = {'bootph-all', 'bootph-some-ram'}

     changed = False
     to_propagate = bootph_prop & set(node.props)
     if to_propagate:
         changed |= propagate_bootph(node.parent, to_propagate)
[...]

> 
>  > stop the propagation at that level instead of going up to the root 
> node all the time
> 
> This optimization will surely result in gains of about few microseconds 
> I would assume, since we are running this on host PC.
> I am not sure if we require such optimizations in build time. It would 

require? No :)

We can optimize later on if it really becomes annoying for build time 
but I'm sure there are other places in code where optimizing would be 
more beneficial :)

So no worries about the optimization ;) (also not sure it is necessarily 
more optimized what I'm suggesting, just a gut feeling).

Cheers,
Quentin
