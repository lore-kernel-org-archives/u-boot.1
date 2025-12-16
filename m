Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D818DD609C2
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 16:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45C7983106;
	Tue, 16 Dec 2025 17:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="QNCF4ywx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6CAE83106; Tue, 16 Dec 2025 17:35:15 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2712B80433
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 17:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFkbUGzRxFSDGZU9hufQMXbgYe2WY0VZaBHI5wnvI7TJvI+p5bl8oZHkMHQrE53vYx7dm9pahMaCrhkN6dnapfYrLFdgguW+EA2RtXWFpz3As7rfyb1M13HrhPuQO4naBQ8IfuyuMQ+GEIrCuwaCS5DkhS27XCK8bGwx6TiS/v1LYKTQAcBspe4zVcGrp5vmsJ5Qn8lKGmFb5ZsHJqojXSG6I/e2RahKc9BXgRha1plXNLfCweSNTP4oFBDG7VzoV3zrXxe/GbpVGJqa+pC/kJYnvy4oEbFa0uPHI7+yiGeO0jC792yDipgmO6bl6K8KACJiGSzKTibJSnjCupkhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9U9cdfK2FGWzbyCBXRr41K7gMnoJCwxJ7j9dlkXN4dM=;
 b=dYlIYGSjMlLBXE0rS4qNS1inDOBdualaH7/CTTciUkgC0ZHJEdclEbgYMkLheNYp3kyekE/FhGuRGFci3+ai0YiR0+oFsuuXkfgui1IhyY76kB4EyhhYDJnijuD95UV/4NzBikbZjH+y8WRBUEqrrMLIFjqHb64eF9+aQV/lf0SlCuN1rDRpjXl7LxxXqWyrlFOmAPkHDWiSHwryc2TTBdzGTxgryjVURgrT0KZEB7sdjA8Pfljg24gTWmxMv5FvoaYaNGbx9Q8VL9exrmgXGU0XhH7sI7eH5WWZELJ6AQ5ahRS8b3jmTyGC2tN2aZR9b0fYnxT3vr0Xf/gnNrEl5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U9cdfK2FGWzbyCBXRr41K7gMnoJCwxJ7j9dlkXN4dM=;
 b=QNCF4ywxwtr90MJ+u0Hb2Fj1mEV8pyHrh176S8SzodIKCbb1WBiZzJUwvRJFq3GzNKEEBOow0scKTYV5X5Ej03j+sJid41Ur4YyHLJhUjUS27AWMLPwO7hRKJSB3R30yV2IBUgKzeR/hfrI1qdpjR6rFX8/qfy/uV+eqmjXzoAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DBBPR04MB7884.eurprd04.prod.outlook.com (2603:10a6:10:1f2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 16:35:10 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 16:35:10 +0000
Message-ID: <7286807c-3846-4b15-bf20-deaae13d25ce@cherry.de>
Date: Tue, 16 Dec 2025 17:35:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rockchip: make rksd the default format for SPI
 images
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20251216-rockchip-more-template-v2-0-6372e27fc689@cherry.de>
 <20251216-rockchip-more-template-v2-2-6372e27fc689@cherry.de>
 <b729be6e-3091-4aa1-af7b-266a94bbcc66@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <b729be6e-3091-4aa1-af7b-266a94bbcc66@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DBBPR04MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: f78af98a-f79e-4e59-3126-08de3cc11466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2s4Y21uR0prT0dWSStMWnN2cndHM3BQdUVzQzBmWHJoN3VwOFNRc2NUYjJI?=
 =?utf-8?B?OWpnWU92Y0o1elB5ek5tVjFPczJZTmxkMzBwbCtQWE12dEJFS3VaOFc1SWtx?=
 =?utf-8?B?WHdyZEV1ajN3RVVuN3dPbkxabzRSRWVvSXRUZ3VqdUQxT3pjUzJzUS9SQVhk?=
 =?utf-8?B?RU83WkNsdWcweHBHSW9ZTHlvcHg4SVdsd0JzRGg4ZFR6N2x1ejEvaGdSdVVk?=
 =?utf-8?B?R1VvTk5OSXZYK3R2VDNTSCt0K3BUM1FBd0paTVkyTi9EZlEzemZqRkJRcENQ?=
 =?utf-8?B?YTB0K2dyNzN4bURab2w0WU8wSFRQQ1ppb0xtUUo3MjE3aUIwZ2t5NmhsWU4w?=
 =?utf-8?B?WThTZldWSGZwQ0RqamhqM0dTZytZcHNabnlySitYT3NGQjBRMno0eDFGODJU?=
 =?utf-8?B?Z2JFSE5XakR5a05jM2VSSWJrZE1TNlBCdGU3S2JXbThNTVp4VWRRNFNHdDZu?=
 =?utf-8?B?S3NiMVU5M3FWa1Q2dFBpN1UxQVlYYVpMelFuLzV3VzUyYjNLSUt2aUVJUE52?=
 =?utf-8?B?dEE5V3ExalQ5aVdoNlo2Q1gzdjBxOVVTUzdidndqTFAyU1dOR1FDaFBVZGl3?=
 =?utf-8?B?OHN1Y0h3Y2xYWmZRcGN2L29DdW1TK1NxYS9CWTBLcW9ua3R1d2swRXpSWE9N?=
 =?utf-8?B?QlN4QVdXb2ZpbHhjdjFrcm9CMkZ6enRUY0c1VDJvMlo2RFNPTjI5eUhLQld5?=
 =?utf-8?B?aVJKb2djVzQ2U01LaS92SEdCa0NpakFIQjRrRGRyOWpnQmpjd2NpbU95Qlhw?=
 =?utf-8?B?RS9rdXhJSnBWb0J3NVpsT3IvWXhTcTJhb2F1elRYMFhqZnhYQmNLcHQxaGlO?=
 =?utf-8?B?bmc3MFNzYVd0VXllaTNtS1BlTkI4dHhzMDhRNFRaYlR0M05oRHJ3dnVRNXN3?=
 =?utf-8?B?NGZhRHdnbnd0SkhWdFo4QWlJNXpMM0NWazRoQXEvUVoraFF0OXphT045b3BB?=
 =?utf-8?B?WUhmdHFacnh3aGpua3Q4N3NicjU3Njg3UGdKQ3BzZHhMYmprZy80dlRJSFBI?=
 =?utf-8?B?ZUVnbVRWcG55c29aUVo3WTdmME1zc2NTVm9GS2Q2L0ZlUEQ2MlpiNFJ3Qkp5?=
 =?utf-8?B?K1BDelZWZmlqT3RQV00zay93aHlwSjE2U21NaTVxaHNEN01aZ0c3NHc5alZm?=
 =?utf-8?B?a21ERG9mRFBSUlRQeGRwSjZFVmZKTVd6YmMwRHpQcVhPZitFQ0k4ckkrWXAr?=
 =?utf-8?B?bFdqdFFNVTR2NHNIYnUvVTdrNTNUa2FrbjkvbWQzU0VtVzhDS1JPc1oyRndt?=
 =?utf-8?B?b1JsU3cwdTJJTDBONjJkclJUcUJOT0FHcitsb1BGVWFhNitXcVlDZUlVMG13?=
 =?utf-8?B?bjZjaUdrM21jWHlzUVI2UTlCRzNXNmZDM1A2aVc0Sk84bE5maTZNUkx5eGhC?=
 =?utf-8?B?b0tKYzQwaml3ZThZWXB6UG5FWEJENis4N0I0S3VCS1VoWVRJbnRUQW9NOUQy?=
 =?utf-8?B?SlpjWCt6WGlCNDI1VXh5bGtDbkZZamM0VEV4ZG5pdGNldG9USFdlc3F0dHZk?=
 =?utf-8?B?dTNVS0hCTjV6WTlFeHJSRW5pMTY1b0dvL1ZUNUhoNmxaOURMcE1pT2h6c1RR?=
 =?utf-8?B?dDRmQm5hc2JuUEhFNFUwYlA5eWlyWWQzcStaY3N6V3MwWXM2M2dXY285aW5F?=
 =?utf-8?B?UU02MlRNS3dCdmo4MjIwWENWSlpBak50YXBHODVVMk1CamF3Wkx1eXdvWmxW?=
 =?utf-8?B?cVo1c2lQeStEUUtjbW1vK3N6R1U1TjVxZFNRYTZVS2R5eW83L3JxenFDL1kz?=
 =?utf-8?B?eitkL0xDS2llbzMyeHcyVUdNWHNKN3pPSS94dDhZb1hzYUJ2RjBheTRNMlF2?=
 =?utf-8?B?ayt4ZzFSVGN3N1hvcUVHZ3R4blJERnE0aWxOQklRVVk3VGZtb0c5YkFDOGM3?=
 =?utf-8?B?ZHdqUmZsc0dvL1ZVQWV3QXY4Y0ZLQk1JdExPNDhWQkRUQjNNd3BHWUh2bUg1?=
 =?utf-8?B?cTBCQU1RZkRSczZCc0sycm1JYXhyb0tHM1ZMMGZCb2c0NXVIZVp0NEl4ckxw?=
 =?utf-8?B?d3ZsME5qa1FBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2UxR0JIODBlNk4yMXBYZ1JoUUxRU1FMbDdYU3VmSzlhbUdHMXQrSFZzUitO?=
 =?utf-8?B?WWJYWTJEeVZtYnFEMGpXLzd0NUR0MEZwY2Z6MHpoaDIxdzNmejAyZjc5QWdv?=
 =?utf-8?B?clNiWWFhQnFzTXY2c2MwUmNqMXBTK0YyK3dCUlgrLzBmVFpLTVJycmQ3Rk00?=
 =?utf-8?B?QXg2M1NnT0laWlBPK0pLZHFndzQyQmdYSzkvOEhIb0pZMThKNHN6RElyQTU4?=
 =?utf-8?B?MmdPZ3NOTm0xM0ErTkxRWnVtUjhkenIzeEFnc0RkN3ZPZlNydW5QZ0Z6VkRr?=
 =?utf-8?B?SEhRREYzVVY0UFVabWlNcElYUnRlWjFNdEtSVDdBY0l3ZWI1OEpScC9UUm55?=
 =?utf-8?B?STdXRW1UQjA3dUxjNHVNK0doTC9nL0ZVb0lKSUZFWTZ2R3dlUW5jSXJZK3lK?=
 =?utf-8?B?K3dhNEtEb1VIOEhuZ2lrR2pmUFZjNUk5L0Noem1jeG1KV0JYcFA3b3JBdEE4?=
 =?utf-8?B?Z3FlVXNWeEM0MXF0QlJuZE10OG1ONHd4Vjg2QjFPZFhlNW43L3BsbzJJQ29C?=
 =?utf-8?B?YW1aa05MN3IwQ3VxalJNaytNQmhwSzFsd0FTenpqa0lSTkkrQWIzQ0g1QzI0?=
 =?utf-8?B?QzJsaDlQb3QwNjE3eGxIZE5QMGZQV1B2d0NBT3BxOGNyc3FkZUFsdzRDSy83?=
 =?utf-8?B?UW5rWEdrY0VJekREOFpqQy8xamM5U1laeFlIVnpXY2JVeTA0RXBKMVRLdTA2?=
 =?utf-8?B?STNNNU5ndERJKzVlU01rdFBaYk80TUVpT1doQW4zelQrelJQT0Q5Y3Z4MmdU?=
 =?utf-8?B?aklWaE1aaGJJbVFGR3pPc1d3dThpam5iclhUVEF2bHE2VEhwMlBYOVVVelM2?=
 =?utf-8?B?Y3ZiYU9WQ2pkNUxSNHpPNzdvOEErRUVseFhxdUJYWUd5cEJ0S3dpWEtLblJY?=
 =?utf-8?B?NnJQbTBjWUE2eXBUTGhDbzJEVjlqOHA2Vk9sYzVnS1ZSTjREa3pXRHUxNE14?=
 =?utf-8?B?dHFsbE8za1E1OGFkWVlUTUNSYm15ZG9XOUVLT2hBRWZ1TnBRelQwWkxPc1dV?=
 =?utf-8?B?OFlIZnFLZnVFMzA1MWRQZVRxWi94N0pJT29wRHA1bjFnVnpYR0Rjc29BaHJn?=
 =?utf-8?B?elBIM1FqYXZiNzRDeU9HNW1PZmkxSktsU0RsaVVleWNDUXpJcWJjaXB1cUFM?=
 =?utf-8?B?M241eW5Ob0tSWm1WUnFsdS9Gb2VCYnVka0RLSnBRUUNGenY0R2NqamhVbUhH?=
 =?utf-8?B?OGo5QlZVR3MvNlhPVmlmYUd4M1JESDNrMEQ3Rys0RW1FT2xicHJHK2dxUzRQ?=
 =?utf-8?B?OWV1TjBwV3liNlczTUphZHhETjB5bEFsMkpVMkJwZ2M0N05PNERCM2p4dytC?=
 =?utf-8?B?QTUyN25GUGEyN2NtaG5kaHM4b1R3dUx2d3NuVmlWNm1XRDNYT1I1NytaWnY3?=
 =?utf-8?B?SGZ3b1dsc0VyQVhmTzZZZ2pyaTRCZk5hK09kN055OXZEdkErNlRjOVJxaWgy?=
 =?utf-8?B?dDlHMkFiQWVyTzJ1Z0N0MzFsa0piQVNTbno5RWF5VStFV2JnVVJWWFRGb1Ev?=
 =?utf-8?B?aWJzVk16V3Q5WFI1WGk5SUdrcjRHc0FkUnNZVTZ0S0lPWVBJb09kY05aYUl6?=
 =?utf-8?B?WlY5UU5tcVgxR0E1RVNuQUoxMm03SElxQi9TVmQ4bEhwKzAvdXJqL1lPc2NU?=
 =?utf-8?B?cUc4dm9id3BOc3lHcG45ZUgweEViMjBpa1dPSlR3ZXdhODNsRnFQcWhUUmpY?=
 =?utf-8?B?MnJzcGRWRkNZQWxCZTRDbDZVUHJQL2kwWHJ1eGcvN0JRVnNQb3JLYStKMEVG?=
 =?utf-8?B?R2FNNm9ZZi9HclhaU21SOHVKRWRXNmV6RVQyWjFPcFVKUkJWTWtxMGJpdGx0?=
 =?utf-8?B?bm1qbjVFTkhoTnZWOHRyUUp2L1lkclA1REg1Y2pUNVlLYzdnOW9veEtic1JE?=
 =?utf-8?B?alhKY3hHalYxVkZyaUJaVU9MTG9raXFWLzZzVXRnSnBhSlY1WTBNYW1vdXNH?=
 =?utf-8?B?NHJicXk1RXBpbU9majlOaUxYUHBpVU1HKzB6UXp6RWpZVnlyYklnUnZrZGtG?=
 =?utf-8?B?K0NTYXgwd2tENFhVdlBzYktjcStPQ3Jldkh5ckNhM3RzajRQQi8yNWdNY3pr?=
 =?utf-8?B?Q00zTnBQMC9aRDBhL3hNcjFsTExWV3lZMUNURm9TbmtOT3hEYWNGQldmcDBV?=
 =?utf-8?B?NGRpemtNdG9oRG8wTHE2Qk5sc1IvZkZqalVkaDhsZlJ3Q2lEbUw0QVBRV21D?=
 =?utf-8?Q?XM+rA3Vp1LXwsJ23fWHK8DY=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f78af98a-f79e-4e59-3126-08de3cc11466
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 16:35:10.5182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNbedVwBJC7BgeZgseZtXtAB2d0KIZZhG5q/XMCfiWe2i9HzWBuH7TmqRPFtoN6/EE93L3k/Zu2pcYeljU7zWXZVQfj+E+WBGxyMnQNnPb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7884
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

Hi Jonas,

On 12/16/25 5:11 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 12/16/2025 12:26 PM, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> I believe (hope) that the new SoCs should now have this fixed and not
>> require the "hack" implemented in rkspi format which almost doubles the
>> size of TPL+SPL (idbloader.img).
>>
>> It's known to be fixed on RK3566/RK3568, RK3576 and RK3588(S) (according
>> to the DTS setting the mkimage format for the SPI's idbloader.img to
>> rksd explicitly).
>>
>> Since I do not have any board with a bootable SPI flash except on RK3399
>> where this work-around is required, I simply invert the logic by having
>> rkspi explicitly set for all SoCs that didn't and remove rksd from SoCs
>> that did. It doesn't mean that the SoC actually requires rkspi format,
>> just that it's been the case until now (maybe because nobody tested).
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   arch/arm/dts/px30-u-boot.dtsi     | 12 ++++++++++++
>>   arch/arm/dts/rk3036-u-boot.dtsi   | 13 +++++++++++++
>>   arch/arm/dts/rk3066a-u-boot.dtsi  | 12 ++++++++++++
>>   arch/arm/dts/rk3128-u-boot.dtsi   | 12 ++++++++++++
>>   arch/arm/dts/rk3188-u-boot.dtsi   | 12 ++++++++++++
>>   arch/arm/dts/rk322x-u-boot.dtsi   | 12 ++++++++++++
>>   arch/arm/dts/rk3288-u-boot.dtsi   | 12 ++++++++++++
>>   arch/arm/dts/rk3308-u-boot.dtsi   | 12 ++++++++++++
>>   arch/arm/dts/rk3326-u-boot.dtsi   |  1 -
>>   arch/arm/dts/rk3328-u-boot.dtsi   |  1 -
>>   arch/arm/dts/rk3368-u-boot.dtsi   | 12 ++++++++++++
>>   arch/arm/dts/rk3399-u-boot.dtsi   | 12 ++++++++++++
>>   arch/arm/dts/rk3528-u-boot.dtsi   | 12 ++++++++++++
>>   arch/arm/dts/rk356x-u-boot.dtsi   |  1 -
>>   arch/arm/dts/rk3576-u-boot.dtsi   |  1 -
>>   arch/arm/dts/rk3588s-u-boot.dtsi  |  1 -
>>   arch/arm/dts/rockchip-u-boot.dtsi |  1 -
>>   arch/arm/dts/rv1108-u-boot.dtsi   | 12 ++++++++++++
>>   arch/arm/dts/rv1126-u-boot.dtsi   | 12 ++++++++++++
>>   19 files changed, 157 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/dts/px30-u-boot.dtsi b/arch/arm/dts/px30-u-boot.dtsi
>> index 2f726b0aaba..7385de7d6ae 100644
>> --- a/arch/arm/dts/px30-u-boot.dtsi
>> +++ b/arch/arm/dts/px30-u-boot.dtsi
>> @@ -27,6 +27,18 @@
>>   	};
>>   };
>>   
>> +#ifdef CONFIG_SPL
>> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>> +&binman {
>> +	simple-bin-spi {
>> +		mkimage {
>> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
>> +		};
>> +	};
>> +};
>> +#endif
>> +#endif
> 
> This is probably wrong, rk3326 use rksd format.
> 

Yes, in v1 I said[1] they probably are the same, but I cannot test it so 
I leave it as it is today. This patch does NOT aim at fixing anything, 
it is simply inverting the logic such that for any *newly* supported 
SoC, the default will be rksd format for SPI booting, and not rkspi. For 
current support, nothing is changed in this commit, if it currently uses 
rkspi (as is the default if unspecified in SoC DTSI), then it'll 
explicitly specify rkspi in the SoC DTSI now that rksd will be the 
default. If it is using the wrong format, it already is and thus can be 
changed in a separate commit. This is intended to be a zero-sum change!

[1] 
https://lore.kernel.org/u-boot/5f45b4ed-d01e-41f8-a05e-c617039228e0@cherry.de/

> Also seeing how the rk3308 has a later model number than PX30/RK3326
> I would guess that this also applies to RK3308.
> 

/me shrugs. Not tested, won't guess, not worth it.

[...]

>> diff --git a/arch/arm/dts/rk3528-u-boot.dtsi b/arch/arm/dts/rk3528-u-boot.dtsi
>> index a18d33b3d36..f21d76b0e6e 100644
>> --- a/arch/arm/dts/rk3528-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3528-u-boot.dtsi
>> @@ -30,6 +30,18 @@
>>   	};
>>   };
>>   
>> +#ifdef CONFIG_SPL
>> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>> +&binman {
>> +	simple-bin-spi {
>> +		mkimage {
>> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
>> +		};
>> +	};
>> +};
>> +#endif
>> +#endif
> 
> This is wrong, please drop for rk3528. I have commits pending for adding
> proper SPI flash boot support on RK3528 once the E24C model lands in
> upstream linux, see commits at [1].
> 

Maybe it is wrong, but it is the **current** value. If this series is 
merged after your (yet-to-be-sent?) series, you'll need to rebase to 
remove the args line. If it's the other way around, I'll rebase like I 
did for this one after the RAMBoot series got merged and remove the args 
line (see what I did for rk3576 between v1 and v2), no biggie :)

Cheers,
Quentin
