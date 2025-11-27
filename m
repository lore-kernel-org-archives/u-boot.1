Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D982ECFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 04:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19189842C4;
	Thu, 27 Nov 2025 05:26:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="op/yY7fM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BD0A842CE; Thu, 27 Nov 2025 05:26:55 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFF0D842BF
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 05:26:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxF50jP5qMGb0xuOc01rIsYuVHT4zQBPeoZwHB8RcdQNtz4e+ACYActkQ9s+E15o9XVk/zYceyemn1q4KdroaLwTSxMW9uURcm1yBaSiNpdwGuTRe9kFedsfL8OaGCN2vn+2bGGlG7+Z5vMNRIbq1ojmoABj0iAz/pvfQdJi3VCTjgANjoHxIBjr28EdEVrqyZoucsG1tIgFZs0L7tG5hKOvJhX01ZIt575z3JUw40TXj3ZwBHLydulHSsrzdtmZ5F58IKVINT4aq8GaHbgbWPxHPlHKUcesdiplRqTZFw07x3wM3E5qAuCX/GqyBrCU1FXoLS93Rbx25CRtVV8U+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bG+dqSY5iMszwPJWKK9WvKCA5zsl6yDj0vf8KWNkWNE=;
 b=psKQdteJJMoYSGMUYojV88z/tQpGRc9Lzxuog+QGobghLLJ+otnMm02fZKCEmJu4upOmA5o0RiEtcCB05lvo3m5XJnyudHjfZe5c/0DNhAZr1z7IojjPbAXE73lam0aAh/ZdIGT1qr68yZTvJ9jcZkE0Qfrj9hcxXuIUkjiEdKNA7wpEL4DFHTl5zXMjJVUezafC7QI2lawxaNVAxHxdX5Ya8a6On+UZu7+68kB8FwwfPbnaDdm2Al9MX7/3ZNtZMKJa0aBQqc/Y2uW6/+qAW3HmEet8GNyS9baXtHxWs3qAxWG4dt+y7C07p5iQZHv0OyN9pOzbYsTWrGRU/YMWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bG+dqSY5iMszwPJWKK9WvKCA5zsl6yDj0vf8KWNkWNE=;
 b=op/yY7fMZwjFXeInpG7a5uNbvhdtPG8Ix+ybDPgb2uoFAmM9PGVwyZsxOi2bSd+CWxIBUaw6Ry+nVb+iLDLToVVFVCpq1g6cGT8sg6nZ1bJ4bjcYvaH2KVNrtqpSnc7dxN/Ja0yyfSirVtTqTDTh6xf7Jdunb52yEX5SGOgCHYnxnjTXqdJ+vZnk/u8T+yNoGxNLO/0irIR8ythsyQJks71vEcI3FY7jCUVRbL+dBmNruqG0GdZisvQuwSAb6vZI7Wr5yeurNBgm3Lpx9X+kFphB/P8RmDJMgncjqywlvOpB3xKsk6C9VVHG5AG2NvAFQrov/JDBkWEFvfyqaMVKRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by LV8PR03MB7373.namprd03.prod.outlook.com (2603:10b6:408:189::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 27 Nov
 2025 04:26:47 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 04:26:47 +0000
Message-ID: <5412215a-c73d-4f8e-ae91-a254e68f3240@altera.com>
Date: Thu, 27 Nov 2025 12:26:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] spl: mmc: Account for
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE being a choice
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <2a3e21ea1dd00565857793228cf1a0ee27d550db.1763140421.git.jan.kiszka@siemens.com>
 <93c1f877-ac83-4802-bfc4-4338658d8e5e@altera.com>
 <a27e5bb7-dea7-4659-be32-4111bf8a5f9d@siemens.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <a27e5bb7-dea7-4659-be32-4111bf8a5f9d@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|LV8PR03MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: f00c4ea5-dc2d-4f24-fec7-08de2d6d2d6b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVlxa1BJeUMxelpGbTEwTVlpL1lyYkVXZm9UVDRuWG94Qnh0T3hNN0Z5bFdE?=
 =?utf-8?B?NjBKL2pBcklFR0RrZ205T24rczB6ZUxEN2FER1V4RWpMUzJldnp2VUh4QWk3?=
 =?utf-8?B?Tmg4dWJzcExVVmE0bGNKbnJzcW9BZDc4YWpSREtBVzhkN3phZDh6NU1GbVo1?=
 =?utf-8?B?aHJOUkxuSjJyZmdFOHNXUFlSUXR3N0VZMEdMUHlDZHlEUkVsL0lWTFYzcmNi?=
 =?utf-8?B?d3E2TW1Zc08rQTlNVEV2QU9UUkNuOG9ZQUszc2NFZXdPaUZ4QWpwVzV0MlRD?=
 =?utf-8?B?UWZZUlVuUmZqR3BOR2lkZm9NQTcwZFRnK1l1S2VqRkVtUWJmazUzY2pDWTM5?=
 =?utf-8?B?YlErK1FZSHhQckU5d3RpaUc0SDNsWlpQRkUyS1hlc2FReGpwRi9NVUltWDRW?=
 =?utf-8?B?dU5rU0pyZCtqS04yYzRuaEluNjFuSDdxcXpJRzlqUFh4TmViNDFWcXJKQXZl?=
 =?utf-8?B?eGFVWkd2cTREUWE1eWI3QmZBQ2FOSjhIbldXYnc3VEh6Q2haNllvKzVLNGJ5?=
 =?utf-8?B?bG5RRmk2MVhML0s4NWtzUmZGbWxkTmw5VEUrSHlKYXZHQlhUai96TzhydHln?=
 =?utf-8?B?TTJwWTRyMXdWK091alJyRWhIK2t1ak8vUVlUaVAzMHJIeVRxeWRSOGRvSURk?=
 =?utf-8?B?NFZ5RW1qMGZnS0t0bDduSkpIY0RaYzhFSkFMT2ZMVHZDa1cvL3dTVG4vVyt5?=
 =?utf-8?B?bXd3UWpzbGFCa2UzdzdLZzNwQW9wbXBoUWNrakRQWDQ4T1BRMWx2eHA5Wnl1?=
 =?utf-8?B?Slkra2VtcEFKdy9NelFQUURsN1N1eFNlQ2ZNVzBaaE9jS2U2c05tUjZiMUFu?=
 =?utf-8?B?RjBPSS9CaEF1K3psbXBsYnE5ei9TTDdQUnZtTWV1a0VkZDB3NmM5MVBCYWNQ?=
 =?utf-8?B?REtsd3hNYlBjNEk5bkZZbmZSQjYwellnVGpoTXNEYlppeklQMnM0SjRGQjdt?=
 =?utf-8?B?VUpXemVzVklrSGVseXk3RVpNY3ZFRjY2dDA2RkpzSi9wUGR4WVQxc2dpMVZj?=
 =?utf-8?B?T3ZPakZuQ3pwUTYreGM0OVVTdTd1R1RVWjJMbXJNZXNDUEtjUTNjNDNhY2ZP?=
 =?utf-8?B?NXA2OFpmcGlJSmEzQ1NiZ0RzamdITkY1M25hSGxxRXFDTWs3UE84cXVZSHRi?=
 =?utf-8?B?RDlkaExvcGUzR1d0QzFSaDVqeVgzeU1uNjNXOVgvWEFwV2dXY0M4UGxrRkVy?=
 =?utf-8?B?aTRjUDY3S2l3ZUR3ZHNSRDlHdVR5bHpxR1RnNWw1aGpMVWtEU1JwSWhYY2Nq?=
 =?utf-8?B?djU0Z3FTcytjcm4zdXZoblRUSUF4N2lXUkx5bFYrZUFYRW91SktYOUNjY05s?=
 =?utf-8?B?c250MEQ4UGtXdTZTRjRMaVJQZFhLbFRDUVdIeklkc2kvQTRjTno2aGdveFB5?=
 =?utf-8?B?MFI0d0pFd0ljT3B6bHRGS3pBUjZsRDBMbDJQZ1pya0RqM04rVkxKaTZFZG8r?=
 =?utf-8?B?Tk9LcVZaYXRRQ0ZNRmNKYWtuczgwaXNsMnVpUFFKeTBwdjJKK0RTZmF2bXFW?=
 =?utf-8?B?dmx6N3BaY0dQbk9oZUdaSlMyYXJLNlZPd0d4VkF4RFB5NngrSmkwejN4SUhm?=
 =?utf-8?B?RXNvR2UrT2JnTDJjR090RnBXSHc1b0diaEtEWHdZOGJjRlp5OWxZcXY1S0hy?=
 =?utf-8?B?L2cvaHpJMURaRHF0dURyWmp4alNpaXN2SVpkaDRMSkNmbzRNV0F0dGVWWWVu?=
 =?utf-8?B?UlAyZFlzVHFXOWljRzhraXR6MnNGQU9MeEJDbis3b0g1ZHJGMFYyeThRQ0tH?=
 =?utf-8?B?T2lJei94YkE1Qk4rdHl1V082cmZCK0IraElsL2lnWkFndVlneTM2WFhDQ3M4?=
 =?utf-8?B?ZC9vdkgremQ3TnY4aFV3dDhVR0c4TTRKWHhRd2NtV3hMNWN6VEV4YW0vSm5k?=
 =?utf-8?B?ZXZwOEYxOTFFWXIzWUtPeGh2ZnlwZzZKM05CTEhxeFlxeitGSFVUTCtVM20z?=
 =?utf-8?Q?NqsHhKGLEGYt9oEh+7rOHnCh22+4UK/w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGsxVjJCRGV0ZmIvaUhibHNoaHNaZ0pMSjVFZWhzOVNLejNnREY5S1RDR2xq?=
 =?utf-8?B?cVFyQnZDK2lSMHRoK2tieTFZSUl0RjlyNlBsTVVFS01wTG1SRWFlQk1RSm9j?=
 =?utf-8?B?bGVybUUxbEcxWFZWRnVXb0Q0TWVaRWsxT3Q3eE1UbmpyRDF5elZMVmgvRU9F?=
 =?utf-8?B?NWFhSGxyL09XTk1Qd25UWTZ3UCtIZ3BtNHUvMEIzRDZnWStIOFJvOVhyT1pL?=
 =?utf-8?B?TDBTQmVZcjNhRU1RZTBsTVVBbitlOFVkbGUyTnl5TjMraENoVjBEcER5akNa?=
 =?utf-8?B?d3FNWmlvUGh4cEF6bUZiS3pkUllVSDRoQ2RYd2lxK1p4MDljZFhTK2toY05a?=
 =?utf-8?B?WlRBWnhMaldicnlka2pNQUxNMVowWnlXUUxodHNoYXFwZXJpZ0xobEdnb0VF?=
 =?utf-8?B?c2NGZ0UwN2NXNkRKZmFlNm81bHl0NDE3dHRKVXZnWTJCMkp1MVY1WFRJbHFh?=
 =?utf-8?B?U0FSY2lSZWZMWHZYSHhmdzBXOWp3cUpPb2gxUXBCSFVVa0RvR0JqUHBUa004?=
 =?utf-8?B?eWZjTlNwWnJwYzZGMmRUSVF4SExjUUl3M2c5Vm1iSWc0eEpHd3BtQmVLU3dF?=
 =?utf-8?B?S1ppV2tXRmM1VlpXbjZzY2k0RlhvajBiUlpVZFYwWFZtbTZjcXA0QlExUE4v?=
 =?utf-8?B?MFNEaGNIYUhmWG5nNEx1RmNuekJEMTlHTFF0TVM3cGhsSFo2b1JMWkhQWWcv?=
 =?utf-8?B?Y2tNa2VNb29DclBGOVNzMmpjY1pPVFVsWGk1dDc5S01Bc1h1NEdiNGNGcTU2?=
 =?utf-8?B?dHI3aEc4REtlZ2lrODhUMHF4SHpwZDRDWjZXYVFmdXVwUXB3MmxtUGJ1dCtB?=
 =?utf-8?B?MnZVMVpuTkF2dkVnSFp2dVIwVTVMVE1FbFg5VTJUZ25EdTZNTVZncnlZSkpV?=
 =?utf-8?B?Q3JoR3p0b0NsS3NiZ0xZSHVwQVE3N0VxaDRKejJnOGlyWWNNRlVhcVJ2OWM5?=
 =?utf-8?B?Z1RWYzVoblJlWUNmMlBGT2ZKeGkrVUtjWC9XUlF3cFRTTnNOUnZIOWh5QjRL?=
 =?utf-8?B?WjNSejVTZnVkNjJOeGtFOFV0SzdTM00vOE9TemZpSG9RNGtvTmFMQlI2VU00?=
 =?utf-8?B?MUZyUDZIbjhwa0ZpT0RuSUZ1bnJuVzhSMmhhbTBLSlpxWGN0R0w0ckV0VmJM?=
 =?utf-8?B?YlNlQTNkcnQ3OS9EOHBQdXBRakNva291OVZ3cTgyWUx0c2dMc21Hc0cvV3RQ?=
 =?utf-8?B?SmJVc2ZEdjI1bUp4Tk1EcDRMUWpwYThyaVllaEYvVk1WRGFRd011TUNoSXNo?=
 =?utf-8?B?YU1RcEZhcHd0czBFaVVDam5ycTRUZlFqT1I5VmlCdDFDSVV6cmpvWnMwMnNE?=
 =?utf-8?B?dTVtYkFDVHVBVjlCOEkyZTQ4UTRuV2RuV3VqaTN0RU8vRTZLcTlnWjV0U0Nm?=
 =?utf-8?B?d2FrOE9kMHp1VmZBbUhvYjhmdUU0WVZsQzdDZFhhRmhhY2FISVI0Z0tLVDNv?=
 =?utf-8?B?RFJGbStIaURTN1hGL1ZLcHZ2WjJhdWljUmhQZitzeDlwdzkvRVVWZm9zNG13?=
 =?utf-8?B?cldQVUpFTVE5NFZ2Q3VxdVlSZ2wwcTdyUU9UQlpnWlN0dVFSRVRyVENUWWl5?=
 =?utf-8?B?N2c1NmVwMk1ROGQrM1pmUzh1TmpUUUxLRElyQWk5K0lTUVh2ZUIzSkltdmdY?=
 =?utf-8?B?SWt0NmorYTdnblY5U1RuWUt1ZmhBS3hVWGtQS1didW0ydmt2YVlObkMyekpt?=
 =?utf-8?B?bElVZktFSGZrRXBZOTN6R1lJMDJoRzBGRWUwcVY3aGpwSGU2NWdiVEtvYi9v?=
 =?utf-8?B?NnhlSE9oS2JmdHRMdlRhS2RocjJHS1lIV0tSeEVIemtjWG11ZEdmVTFZSldX?=
 =?utf-8?B?VVVUZTFoOG9qQjJmT2JqZVZ2aXpaQUs5d0xndGZMNnpXUVd1US9WNEgxUGVK?=
 =?utf-8?B?UVRGRXRYbSs5aFlocWJPNFY3OWNyMFpEWCt2MU9Zc01uQVQ0RXcyVlcwZDdH?=
 =?utf-8?B?TjJWSDJJa3FwM0N3MGtvNmZ2M3NsVWt5aXlUY3V1eUNpZlJWWHV2NVM4aU9I?=
 =?utf-8?B?YWhnUjV5eUxxMU1HNi9WeGNLMzZ0bTNPS3VXRC81WEYvWXpScG9rMzRRQVZs?=
 =?utf-8?B?NnJzcDVZZVpwQ1pGMy96N1p5eC8yaElOQ0ZyL2hxTjlOUHBTMys2UjU4UTNz?=
 =?utf-8?B?QThKaGhiUW5OQk5FMUk2RXVsd2ptZFlFUE1xaExkc2FXdG5weWhHdFhleVEx?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00c4ea5-dc2d-4f24-fec7-08de2d6d2d6b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 04:26:47.3531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3IdjxOFnInqyRZ3N9ny1cTZmHjcF0AsZoNVxVnYW3EEnGOR7LC6H+HIJR/VAhru3oVBujwqNwcdMwD2vYGhE57UIBaLcLcw2xNAWbaWIBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7373
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

Hi Jan,

On 25/11/2025 2:48 pm, Jan Kiszka wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> On 25.11.25 04:58, Chee, Tien Fong wrote:
>> Hi Jan,
>>
>> On 15/11/2025 1:13 am, Jan Kiszka wrote:
>>> [CAUTION: This email is from outside your organization. Unless you
>>> trust the sender, do not click on links or open attachments as it may
>>> be a fraudulent email attempting to steal your information and/or
>>> compromise your computer.]
>>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Add SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE as condition where so
>>> far SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION was enough - though often
>>> by chance as both options were enabled.
>>>
>>> We also need to explicitly select SPL_LOAD_BLOCK when UES_PARTITION_TYPE
>>> is enabled, just like the other choices do.
>>>
>>> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>    common/spl/Kconfig   |  1 +
>>>    common/spl/spl_mmc.c | 16 ++++++++--------
>>>    include/part.h       |  3 ++-
>>>    3 files changed, 11 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>>> index 8dade2b501e..d24466b0c66 100644
>>> --- a/common/spl/Kconfig
>>> +++ b/common/spl/Kconfig
>>> @@ -573,6 +573,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
>>>
>>>    config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
>>>           bool "MMC raw mode: by partition type"
>>> +       select SPL_LOAD_BLOCK
>>>           depends on DOS_PARTITION
>>>           help
>>>             Use partition type for specifying U-Boot partition on MMC/
>>> SD in
>>> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
>>> index 467114f8d9a..09e881c464c 100644
>>> --- a/common/spl/spl_mmc.c
>>> +++ b/common/spl/spl_mmc.c
>>> @@ -106,7 +106,8 @@ static int spl_mmc_find_device(struct mmc **mmcp,
>>> int mmc_dev)
>>>           return 0;
>>>    }
>>>
>>> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
>>> +#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
>>> +    defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
>>>    static int mmc_load_image_raw_partition(struct spl_image_info
>>> *spl_image,
>>>                                           struct spl_boot_device *bootdev,
>>>                                           struct mmc *mmc, int partition,
>>> @@ -415,19 +416,18 @@ int spl_mmc_load(struct spl_image_info *spl_image,
>>>
>>>                   raw_sect = spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
>>>
>>> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
>>> -               ret = mmc_load_image_raw_partition(spl_image, bootdev,
>>> -                                                  mmc, raw_part,
>>> -                                                  raw_sect);
>>> -               if (!ret)
>>> -                       return 0;
>>> -#endif
>>>    #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>>>                   ret = mmc_load_image_raw_sector(spl_image, bootdev, mmc,
>>>                                                   raw_sect +
>>>
>>> spl_mmc_raw_uboot_offset(part));
>>>                   if (!ret)
>>>                           return 0;
>>> +#else
>>
>> There is a build issue when CONFIG_SYS_MMCSD_RAW_MODE is disabled.
>>
> Let me check, but if you can disable CONFIG_SYS_MMCSD_RAW_MODE but leave
> any of CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_* enabled, we had more
> problems here.

We discovered this compilation issue when we disabled 
CONFIG_SYS_MMCSD_RAW_MODE while testing U-Boot proper loading from FAT32 
on Cyclone V. In this setup, none of the sub-options -> _USE_PARTITION, 
_USE_PARTITION_TYPE, or _USE_SECTOR, should be used or enabled, as SPL 
simply loads U-Boot proper from FAT32. The raw/partition offsets are not 
relevant in this case, ensuring a clean, consistent MMC layout across 
our devkits.


Thanks.

Tien Fong


