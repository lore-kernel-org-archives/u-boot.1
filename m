Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA40CFD364
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 08:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 463BA83FBD;
	Tue, 25 Nov 2025 09:48:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="rVzxu3kQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF2D883F37; Tue, 25 Nov 2025 04:02:18 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D5D83EAE
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 04:02:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glgwHW5Jn/8pGrf2OkDhdhKJyFSXFDtUy+poln6KaOOam1l5wLSF7Mo00Lcyrrk/+oNIAFsioQhOhQ1Bvrk31T0wQkRiB66BA6vIpUxsGRICOe2nZp0ZJk3TrHSePAqbPesI91i8KigszOsLgHxPfvjA3LK/1FRJ095BWVKCwTG50yy71zb/ihRLlsZZIWXrdoxY/6C3VOSeLTJ6jmZJ22dW3nH2NWnL6xAwACu11hvHpQpb/nGpexwXE7wShAYKVQRkRe34S8VhqAasSfnxcjlhg5+k9UJezYGDxgamBG1KRYtod7XFOUxLm62ONR6ehnR3JJvbKaPAfD6y/qveOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJy2L79/+tVJ+6lRVVWwWLL2Nc/LlDRlr3DAz6X6s6s=;
 b=CXZtlZhPtUxvHF9Ytyt6CC0C2SDLOSvuh2zJvGgxPJbYNLnrAPfRgtzUBW19DbWHEwEhUK22uFlpMGCVpSAqJrD/skAQnppwTkp7AijZ47UIjkQFby2Ap+tCHMvh9eSMNUAFPvCBhRAHBf0Mw+/3/WtYYS1TrOOaGbA+AdSlw3Nl/GL9bC6qKttyF9zLYbW5sTDxPxHFKpRIjwF7nT7EHo9FUYrA7Btd/OdyakQ2Spj7hY5vOmoA+hO3BGMMH10nG34rSWvoeoxhlGfewLFng+VTtywOOVd4NJl4/IrQ5vStLhze4r0U197ACjhE4c+jCsfAksnjXk5lG1tdu/8vxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJy2L79/+tVJ+6lRVVWwWLL2Nc/LlDRlr3DAz6X6s6s=;
 b=rVzxu3kQ15UMEpVwaIfvkw6knYCTtkYb7bQzxCW2OiNeYpoMS0aai6p/hTnXG+eQwo2hHeLm/l1KmiV7ujw3Jyk10jWW6AtAg22neIBLRH/w4apu1XvbdyFpuMWsimfSH+AnDxuTFzT7X29lrbC+g6DgWJZymex0/G6XgRQos2iRYa5cLmKqcBFniJ4y4ad9ephbij5Cg589v7JcypZg3wDCGByRSPVF+0lWMDgqalxxXnOQuk6z+uqYDAsH0ZaskvWWjsFAa9z8x8OB7wJyNWCKGGeoisuqvks8MmHwi95d32WPMfwCiMH2aNaH1Tmcqw7JBoJOqPftPUjJ58DN7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH7PR03MB7438.namprd03.prod.outlook.com (2603:10b6:510:2ef::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 03:02:12 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%7]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 03:02:12 +0000
Message-ID: <2f8f86c3-8290-41d4-946b-eda747c707b4@altera.com>
Date: Tue, 25 Nov 2025 11:02:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver: nand: skip BBT scan during SPL to reduce size and
 complexity
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>,
 u-boot@lists.denx.de
References: <20251113030357.15397-1-dinesh.maniyam@altera.com>
 <e7e19789-6c0b-4ede-b7a3-ad5002a7b9ed@gmx.de>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <e7e19789-6c0b-4ede-b7a3-ad5002a7b9ed@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:4:188::7) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH7PR03MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c6683b-d848-416c-8046-08de2bcf078a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzZvMTg0TjJHV1EvUG5OTWJxMnZIU1FVYmlDZGZmVm4zWXV1NUFvUW1wOXgw?=
 =?utf-8?B?RHNUREtJRFpxWVB6OHpXTk9qUGtoOXEvM0FVVnhzeGRIWlVsTG5LOTJ5eVcx?=
 =?utf-8?B?ektNOUIxbWVRRm9DSi9JUkczemdTa0wra2N1ckxhUVFSeGl0Qm1yaFozU3Ay?=
 =?utf-8?B?S0I4NlkxcVZmWkxDMFBFU0hzZmk5QzlDMVVJUGhEb0p2NVJXbzR5U2Q3SGVk?=
 =?utf-8?B?TUNYcmwxRVAxdGxFejVJcVlTZ1p1TXRleENjSUZIRm1zWHFpSk8vVlhZY2sw?=
 =?utf-8?B?TXAzZEczcDl5djJIR1V6eDV3Y05wUEFMaXdVb0xzKy9vRDJKdUtpYUFjdmkv?=
 =?utf-8?B?c2EyenRVNzdMaGZYdlBwS1FSaFNGQ2RtaXhyNVpRcllveGRvYmZETC82VTZG?=
 =?utf-8?B?Ukt4R0JpTGtva0VKK3BRaS9yQUN6bzZQYWFJc0c4YlkrczBhbksvRDNlUkIr?=
 =?utf-8?B?U04wUWhGK1RMOVpRYmdETE1oUVhMSktCUjVaZ1pWRnhISExDM0dTdzJOcGxs?=
 =?utf-8?B?TlZocUNxanpNbEhDWXdiSmZWMnRHZ280V2NFeFRlRGpxcmh2QlpPV0xxdjFO?=
 =?utf-8?B?K3laZnk1RFpiSWs3K3lqdWxNTXZONTJMUy9WcStSZ1h4M0xwWTNpWld4VFRL?=
 =?utf-8?B?dldnWlR3SkgvbWNaKy9OaWFmS1kvVUYxMFRQdnVaQVZ4UC8rOHB2ZzdJVEJB?=
 =?utf-8?B?amZnT2hGQ0NYS0pFZncraklYaFFLNFNVNW1YL2RVYjIySUlrK3RxMWV0MnZn?=
 =?utf-8?B?bkxSL0d2U2J0aGV6Z3VSY2ltTHZ4eWhncjVVTkgwY3FrNEhiVEg5R05tY2Nh?=
 =?utf-8?B?MnYzU3NROWR5QmJCR01qbEFwaEZaQWV2MGcyUEVlaWhUM2dRU0V6c3VvSzZ1?=
 =?utf-8?B?NkVVVHdKRG8xMXUvT0ttbzVaMGhkQkpVYzhYL3pXQ1lkRkNnYjdhZGtDa05s?=
 =?utf-8?B?eTN4U1JhOVp6Q2cxSWE1UHlvbTdvWWJZZDNlUDgzL2QxaVVPSzVJeFRmWk1t?=
 =?utf-8?B?cDlYVU5MNnBWN2tuS3VDMVlBdEJlR0x0eS8vS0xIM0xwN3RWdWhDRlAvY3JT?=
 =?utf-8?B?MXRCWE5vdE1rOEVEc3ZDNS9zVnFCMXkvTTJCWlBxejhvVThIR0JJWm5SOXdl?=
 =?utf-8?B?YU5ibTFxdHZNTElnUXcyWDdsenBZZW5lallKa080WXNFM1V5eUltZUNWMzFw?=
 =?utf-8?B?L3h1em80UW1hQktiTTFTOHhQUzluZFJ4aXRTSTdKWGxMVnR2ZVBCVk5RYmtr?=
 =?utf-8?B?YmZSbGp0TlUvdDhRbVdHS0EyOWMwdktnSm9ReFduU29NeFZxcFljYUN1OE05?=
 =?utf-8?B?Z21CRE9nMUltTjlPZG12K3A0WUljR3ZRbXE0T0ZZdVczMkVyNXV0Z21xQmFW?=
 =?utf-8?B?UmYzMG5ZSnRTQWhiTjE0SVd4V2wySjZBakY2dzg5ZjFTUXBadnVqaUIwN0lX?=
 =?utf-8?B?Qi9XcFcwcCtPMFBPNGgzdGRTMDd3d0kzZ2dqSEJGc0xFRExMeVhiR1gxRFls?=
 =?utf-8?B?Z2hpR1FUMis1L2xaNXkvZVdMQ2xyWWc1NFlMRERJNVhrOEpnQ0h5a0Q4MURV?=
 =?utf-8?B?Zk0wTURXS21EWEpZMjVGRW9PS2ZJT0s1aVlFbTUxTk56c2daMWZJUlhZTUVs?=
 =?utf-8?B?R2ZHSGRHY0hTQm1uMGtadEdTTFJSV2x0Ui8yQS8zdThtTCtySFNqdVJBWm5F?=
 =?utf-8?B?WHRxNkRYZmVaaXJJWnBjUFpNWXBLRUR3UnBPUjZ4Yzl2cFJhNXpUMXF3Wkdt?=
 =?utf-8?B?ejNPZTZLNWFnMTlaTWg3dnUwNHJ2M2RPLzVFWkpiV2xwQTdVa0NCUDlkYmxO?=
 =?utf-8?B?clpVSnphdWdMY0NTRmRGanM5elJlREkrbzcyeUdnRjRXSzlSRFliVlRyWWNl?=
 =?utf-8?B?WVAyb1R3QWR5aWFtam1mUWdRckMyQlJ2NldiOEhRekl0TnhwQm9SSVhVYklj?=
 =?utf-8?Q?/pwsfZwuDYAIrIGiIG6E2gTYy8jig64o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlA5ZUxJZUNSZVIzT1RONjlkSTRoZUVOd1NUZWZ2MERPdW5Cc3phdHdockF2?=
 =?utf-8?B?enN5aGlVRHpOSEZPWm9iTjlMdVdtMjNFaE5vZmRSclRhVkMvazRLdG5RMnd5?=
 =?utf-8?B?d3lYdFZWMEp5aE1BSXhIT0t5cFYzdkpEbDl0NldkbHU2anRIMnFVYkhZajFX?=
 =?utf-8?B?NE04aThoZHI3aU04eE9Lcys4ZHlUM3JHQXRsbTVHN0pRaVhMTldIQytYUEdu?=
 =?utf-8?B?ZHZzcWQxbU1kMTdzdjcyZ2ZGM0UvcFk5S3FVd21wWXhoK1QwdWhTYnYxQ2lU?=
 =?utf-8?B?SEN4QytVZ0l1QUJsa0lSUFFBbzZOUCtlN2tiQ2ZZMWxFS3gxTFNLVjY1N0lI?=
 =?utf-8?B?VVpFaHVDRzNuZHNJTkJPeTVZLzJzMm9aUTdyb2RLeTllU2RKZjNoeDZKWGNQ?=
 =?utf-8?B?cWNrYmJVbklhcTdtbDFRQU1sbHI0c2ErRGJ1MzNvMFlwN2ZxU3E5TjQ1T0dy?=
 =?utf-8?B?Sll4R0hCVVBhTVo3QllGbkQ3RjNzWHVaTm42eE5NbktjWDBPNzhjZCtQU1E2?=
 =?utf-8?B?amtZUHFqTUwwemhjVVZhNFdEQ0ZHNjRJcE1YZHRoQ2UydWdhQjFTOWpwckdI?=
 =?utf-8?B?SVhKdXdwQ3ZGTHd2cDU1NlYwTUJQc0Y0cXdhM1M0My9haExxclBkcTZnbmtE?=
 =?utf-8?B?YXNEWkc4VXJQdW9VVFo2bjFYZkdLTWZLQWk5OFF4bFBkUGxuZXZqTmpjRk5B?=
 =?utf-8?B?OWNWa0hvbFNmSjlZb0NuOGlYYmtyQkttNTB4NFdLS3pIY0tnVHlKWGFWcDhI?=
 =?utf-8?B?MXVieGZ4WlJxSFA4RkRxS2FmZTJ4L1Z5WktVS3VyTXBuRnBtczVubFZkYkt2?=
 =?utf-8?B?cmNSbG1xT1o2REdWTnVSN1B4cjdZVWFlbHg1TUhPeDNHeUNUeE54c0VsREcr?=
 =?utf-8?B?WVZBMnV2ZDFrd0VtSjZVKzBlQStxR2NtWUZJdHZ0MXZ6cHBQL2d2Zk1iZmNn?=
 =?utf-8?B?VVpHVXNMU1k1ODJ6eEdyTmlJQ0p4R1Q2ZTFYTE5Ra0tIb0lXbEp1cmRiTGdT?=
 =?utf-8?B?WEpIalBpR21RaVZha2ppalR4bGhZa1B0TWE2a1ExZHQ5a1pDM3lSTFkwd3Nr?=
 =?utf-8?B?L2hmS0c4L2FHSFRHV1RTZkhVOG51UytVWlNPU1JZTkFzTGEwQlFmODJPV3I1?=
 =?utf-8?B?OEhOMEUwSm5oOVdXL3FLTnRvRHM3MHFUTlYvd0pIWjJQSTZ6V2hqMkxGT0RT?=
 =?utf-8?B?Tms3TmtzZGtYaDBGclBIRWJ4aHdnb05SQVRGTlU1NjFJdC9BTmxwVnhsempn?=
 =?utf-8?B?alBIUGRRZ1lCR29yTnJHS3Uwb1pWblVzQzVDSHVIS2dNeEVPcEQ4U2xtZ0tU?=
 =?utf-8?B?UjNMSmpDSjdrL05PM2lBNzdBaHZtT25BTCtWSWRUeVJJY1k1SXRuM01PRjFj?=
 =?utf-8?B?WXE1eFNvNHczSHhtTDRxTCt0bzNqSm83U1p2YUpVUkh4NEQvalJ3M3g1aFV1?=
 =?utf-8?B?clgremtBV1dUNW1pYi9hZDg0cVpTa1ZFdWVHYk0zcVRoOXVKYThsSFVWQTRm?=
 =?utf-8?B?aUY3bEIzaTBDYVJmVlpVTjhFV1hEbjFNZmNRZFRhdzR5aDhRUmRBaXpMM2Qw?=
 =?utf-8?B?aVdHSWpBOXMyTERUREVBdnMzRDFjeXlmQVNZU1owa0xnaU5LYkF2Q0srOVlk?=
 =?utf-8?B?VVRJOHhUVGNubytKcGNwQ0drNHh1YVd4ZjFTNVJraWZKVG0vYWRDVTY0b283?=
 =?utf-8?B?UUJYaS9tVTRYaDRKL1VhRmVGR2FqNWUwcDNGZGpnaWRFbFVHZkRONVRscGNL?=
 =?utf-8?B?a1BUajRtT2NnbWUyWFNUaWFqS1hLZW5ya2xyYm5nS3ZiWHRQNWc5cWdFZW53?=
 =?utf-8?B?bi9PNVVES2NHWEtQVlhPTUhURjlCWDV5Y3ByUS9kbjRDSWZiaDBzNjNYUDUv?=
 =?utf-8?B?T050RktNYXZ6eUM2cGYzQlliZmhSeXVJSDk3aTIvM3cyaUtwRmlFZkhCZ2ZP?=
 =?utf-8?B?Y3dYamFFcHpvR2ZLV0VrdUNhTTNJa2R5VFNjcHdXTHk1WmxraHV2TVZUZE9B?=
 =?utf-8?B?UG9lZVVVYlpOSHlRS2I1TlAzajYrQUduQ05lanhCRkpaQTJBanEwbjJCRG50?=
 =?utf-8?B?cWMvUmpCTUZaT01ENnpKZHhIT3R4cWtQWkxUWjAwTkFmRThvT2dvYS9INk9Q?=
 =?utf-8?B?UHcxc2lIWDkxNDQzNEtad0V6Z1RxcW1MdkJFS09tRUJtT2VuV2hSOGxlYmJl?=
 =?utf-8?B?blE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c6683b-d848-416c-8046-08de2bcf078a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 03:02:12.1204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gf0Kr0bMUGfoLNQZo9YfYKhkMJqukSmihC3Vfm6Z3Zwl4YJHsuEyzL6MoGb0kKlFfBrAu0mS0wdeo1Fb+IFSDdUiM4RhggM/8TYt7VAtYok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7438
X-Mailman-Approved-At: Tue, 25 Nov 2025 09:47:59 +0100
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

Hi

On 25/11/2025 8:00 am, Heinrich Schuchardt wrote:
> [CAUTION: This email is from outside your organization. Unless you 
> trust the sender, do not click on links or open attachments as it may 
> be a fraudulent email attempting to steal your information and/or 
> compromise your computer.]
>
> On 11/13/25 04:03, dinesh.maniyam@altera.com wrote:
>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>>
>> Guard the Bad Block Table (BBT) scanning with `#ifndef CONFIG_SPL_BUILD`
>
> Thank you for looking into this issue.
>
> In the patch you use CONFIG_XPL_BUILD not CONFIG_SPL_BUILD.
>
> Overlooked. I will make changes to the commit message.
>
>> to prevent running `chip->scan_bbt()` in SPL builds.
>>
>> The SPL only requires basic NAND read functionality to load the next
>> stage and does not need full BBT management. Running the BBT scan in
>> SPL unnecessarily increases code size, memory usage, and boot time.
>>
>> This change ensures the BBT is scanned only in U-Boot proper, where the
>> full NAND subsystem and dynamic memory are available.
>>
>> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>> ---
>>   drivers/mtd/nand/raw/nand_base.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/nand_base.c 
>> b/drivers/mtd/nand/raw/nand_base.c
>> index 48e3685d995..4dc2a19b8f6 100644
>> --- a/drivers/mtd/nand/raw/nand_base.c
>> +++ b/drivers/mtd/nand/raw/nand_base.c
>> @@ -532,7 +532,9 @@ static int nand_block_checkbad(struct mtd_info 
>> *mtd, loff_t ofs, int allowbbt)
>>       if (!(chip->options & NAND_SKIP_BBTSCAN) &&
>>           !(chip->options & NAND_BBT_SCANNED)) {
>>               chip->options |= NAND_BBT_SCANNED;
>> +#ifndef CONFIG_XPL_BUILD
>
> Running scripts/checkpatch.pl creates a warning because you use #ifdef
> instead of preferred
>
>     if (IS_ENABLED(CONFIG_XPL_BUILD))
>
> Best regards
>
> Heinrich
>
> I will use the preferred. 
>
> Thanks
> Dinesh
>
>>               chip->scan_bbt(mtd);
>> +#endif
>>       }
>>
>>       if (!chip->bbt)
>
