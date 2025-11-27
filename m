Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766E2CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 07:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A304842F3;
	Thu, 27 Nov 2025 08:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="lvJlG/vm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6E9A842FD; Thu, 27 Nov 2025 08:06:00 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F711842C4
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 08:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QaAJO3aMwcUhXe++oZZQFSYkcPQGPpif7C+Mc4dH7gd//FnNYSErrxtv5RCyOPZxd03qCODYevt8f051CE/oxr7CWIlTLltS/rDZiJjnF1/Mw6/fXxD9povCUlAM7F+wU6cfQK78WjTR9QrBTqUXuyMv5Otue0Jl/qCXLpd0eXaRQfLnCWhvC05/QWtbNWxtwyRYs4BR+NctHFPstMv5shOc4r0nMRgCvSuAhpDoRwgqhnfUAYdK704oz71BvlFRvx1gi0U6uHr/82o0HOG+vUJmMPXQSrDv4Hv9vt5pVITRMJHlMzyNtX6vqsjFsMrY7AqeCUDfCGo/RJaYs9sA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N345o/AXH4xqXiPTwjXbkWOHSiytR+5dXMcu7It/UVA=;
 b=VxZrYe10JaZQ5g37ONZSS9CHp8CLf2t/+yxQEfZblji1yg+OQ7hPTYg9kWJpr5A66rb9tndBEG6vaVX8I7aFWu+6RaSD8w34YIphGMWdN8exl+kB3lKWaYkBrJFE9sPGalxcS0J6zRkDGBpKn/KkaG4VaMdQqGol53fbpcpabzSn0FncTIlcBi5tzPb2qTJcUhBZCLcUtJSgr6ZcfL4s2Oyq2wDohQsM6BPmvQER14CULiTBsBtyRTYJXZo5i4igVWjHccgJtWxY/kJNOU7MGwOzqVN9tasfW44LFyN24B0W+brA/CHVRyhEsE1xyV9xv47sedJTE+glpyhYbtmKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N345o/AXH4xqXiPTwjXbkWOHSiytR+5dXMcu7It/UVA=;
 b=lvJlG/vmZ9+Co2zvgtLLCfDanGiyzl0NouaxGa1f5Vv+tM6iUuJTGJQDBYnQrbaVMQCZoGjhkJyW8aqE1hgE2YwDMlzCqHExrM3uT4HEFTI9zUn1gkxTeMcrnBHCZYleQ7pQPdYpyzZEdQMl04TMjdksMxGdRI1s7wvyUIu4oEFidEZZZMF4+mo697cvLXof4LGbSH0kHR+XkRNeGkcotU9UvGq4E1a3HxNMNecmAf3nVsM97NUBQpu+70N/zHWgFdHY2Mw5QI44mHFg8qUIWkaWLRJrqwRDgGfDnKGgI/6r8EaM9drbCD71175Z03Nz+IIdAwijNAhe1yUNWT4M3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AMBPR10MB9307.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 07:05:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 07:05:56 +0000
Message-ID: <75a890fd-48c0-439e-962d-6fa85fe67953@siemens.com>
Date: Thu, 27 Nov 2025 08:05:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] configs: cyclone5: Enable SPL FAT support
To: Sune Brian <briansune@gmail.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
 <896ecbf4-d85b-4c09-b8d0-9730be370673@siemens.com>
 <e2f1c154-573e-4326-ae8c-ee9ded46c71d@altera.com>
 <dbe16e20-ae32-441e-b987-6cb5feaeeb93@siemens.com>
 <CAN7C2SCmt1z_rtQBpoBwpDJBCcXWAX7eZTz=mxQ1SqPR=rqWfw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAN7C2SCmt1z_rtQBpoBwpDJBCcXWAX7eZTz=mxQ1SqPR=rqWfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0444.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AMBPR10MB9307:EE_
X-MS-Office365-Filtering-Correlation-Id: c572ce98-2331-44da-1381-08de2d836985
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dU1mY0dadHlNRHhsWjl0WTlmOS95UnVLR0d1aWhUanlNbkVkZ1JXNVhwbXNC?=
 =?utf-8?B?WVhzY0NrT1lRdEY3M25ldi9JUnd2R0dzUzFER1BXRXlibHF5NjRCMG83Q29Q?=
 =?utf-8?B?ZUdLNVhEZXpqbEtGQzZsQmFHc0xld0t1K0hlUE9TcTVmR3MwcFBnRTM1MWFz?=
 =?utf-8?B?WEkzWi95ZlpUSkRaNllTQlVTblBHQ1Fsa3VDVUtmaHhhaytldWlEbEI5aVhE?=
 =?utf-8?B?SDVxN0pyZVdCWHMrU2dHUGVoZkUzcWdjcXdSb0loc3BGaEUwemMwRzhESG83?=
 =?utf-8?B?VVN3ekFQbU9HQTNJdVdobzE0V0o3cnlIVkVQblJUNFF2bW4rQVJvVTBGcjB6?=
 =?utf-8?B?cDhGbnFyeDByd0hjV0cyMkJQY083SWZPRXlyNFlYdzNaa2NnS1JzOVNyU01v?=
 =?utf-8?B?eXBpZWcrUFZYUTZaeGhyYmhxYlZuQTlidnpaUHI4Y0xoZlROaGlhdXZmSFE0?=
 =?utf-8?B?ZUNtZmRVbzlBbzRxOVdaNGtLL3c3YnorNmtvSEVvdnRiTUJKZG1oSFV5cnRB?=
 =?utf-8?B?eUpOcWRrVFJBRnpHL20wT25IUjcyMkY1N2lkZis2WUZEaHNEdm5OR3RQc1cw?=
 =?utf-8?B?cmdSMTRrOFVZeUpuQVpGZytYOHhQM0UyWlJ2cGxUeXhpR1I3WkIwUVI2MVN4?=
 =?utf-8?B?MXJKcTRXQ1prTVYrRUlFaUtPRjVuYlA4NzhhWmlPTmptR25rRkNubHhTNWlO?=
 =?utf-8?B?Z0d3eVloN0FOVUFPV2EwQWRPanMxMkYwM1M5c0lCd09VWlhJaUpjekEvN1pi?=
 =?utf-8?B?WkhLY2p5OFpqbUl6RkpwYlN1dmF5OEdWb1l4Z1BIVzJFT0ZpencrK0VMVTRy?=
 =?utf-8?B?dWVzWDA2aFYwRG1kZGFqMmFvSDJLYUxLWDM1L2FHZStvampzNmg3VUNZMDZT?=
 =?utf-8?B?dWt6ZnJDbUJ0U24vYkJGNjVCTEVGUnVEWVZLa3N4c3hKV1Y0bmRTUWwxL0ZS?=
 =?utf-8?B?eWtrVGI5QVlhZmVXL2xHemtDSjZvc1F5M0QrWm4yQUJpUWE3aXRrV2NlYzdu?=
 =?utf-8?B?YVZrbFcvdFFPSVd0SXF4Qko4OWxWR1BrRTR0dmtKc2FsSEtoUjNCVlR0c0Nu?=
 =?utf-8?B?ajZLeFZJVStuUTJnQUhvcnJjNFYvZU93RnhjaDc1SVAyUytSa2trNEhOeXFS?=
 =?utf-8?B?TjMwLzBnTnV5dU1pZjBNUlNSRGRTWmtDc2VyWlpjcExJTDlwR3dQKytsSVQ3?=
 =?utf-8?B?L0p0UlFtUkJybWVNVGZPU3U1UjU3QzR1T2NuSTVwL3l1OEhFTUMrQTZpZG93?=
 =?utf-8?B?TmhYakttbTBtSHcxT1I0L3NBQWczNkVwRUwxdlZOd1pSV0Z2Y253ME1tK1d6?=
 =?utf-8?B?WE5BZEU2R2VZeTNGamRLM1RWYXJPWlRnRHliRDBFR0FsVk9Bb3VaMjN6bVRE?=
 =?utf-8?B?M3cyNm1lRys5TGJZQU9RR1RKK042TlZHNTNCay9oQ1UvVlFFdVVTZHl0YklY?=
 =?utf-8?B?SUdKbXEzWHFMb3JrRmcwOVduUXp1R21ESkp1QXA5SEMrUGRNWVNzRHZjRGhm?=
 =?utf-8?B?U3J2NW53UTAwSjVMZm4rMnh6VmJqSC9ZQWJnU1FYYXJWWWNscmRiUzgwREFk?=
 =?utf-8?B?S0lta3c3ejljV2JyeTZXcWM2Q2hycDlnR0FTanA3YXdNcXZYN0U4RjdQUjJn?=
 =?utf-8?B?MWVaQVBHZjJweGJDZG1ZRUw2Z1V2bVg4UXFVWC9oNjFKNGFJYVZ4NHhGUzVQ?=
 =?utf-8?B?OUZkbnN3cUJOMEhKWFd3ZmxjMjJRMHhiTmUyK3dGU09xRHJENWhoN002anJS?=
 =?utf-8?B?U2Z4dWpRZHdUeDZ1dHVTbVBuM3dic3R3NnBNcVZjMEk0SmF5QW45bFVIRWxJ?=
 =?utf-8?B?NmdyRCtINHRlU0xyWDF6R2xmWXV5dVdtbHVCTDlVK2s3dFdjQkhadU5zNWc2?=
 =?utf-8?B?d25nb3NEeUJYZGFOUHJRODd1bFQ1TCtPR0Q3aGp0Z1p4cnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkdMZVZJK0JvWC9wYkZmUDFBMWt6RTNZMnpockZ1SlFlY1N0NGxXRCtvaFhi?=
 =?utf-8?B?cnZNclN5NmIyMzFwY0Vvbko4bWVjNWR2VktSU2FRMjlEUW5NU0xGZHdFeDBD?=
 =?utf-8?B?WkRZclRraWhPQmZzZFVTMkdTSEh2Mm43N3RYUUdFYkZMaWpoSnNndDBQbkZE?=
 =?utf-8?B?bC9zM3YxNi9oa1A5MW9ONkd5MFF3WlBXNXlsQ3JzYlFwUUhUNU8wT1UyRE1r?=
 =?utf-8?B?QzF3SlpLL3dhYzFmZE5Cdk14cXdrVWpCb0k4UHdBNUt1OGdTdk5QVUIvMm90?=
 =?utf-8?B?Nzkwa0Z1eTZrNCtBKzY1anI0cmUvRWZjU0U2a3cyZUUrMXhodTRMcjY3cTd0?=
 =?utf-8?B?OXBuTlUvVkwrcGc3NlpGYWZMMDVPbU5NWjlMWmU1c3NGNm1lWnY3ZENQbk9B?=
 =?utf-8?B?U0tNTDRua2RTbll0NHJmVlhNcTNIZUFCcEhKKzFOMFI0TXJlNDRBWnJTRzl1?=
 =?utf-8?B?TnlZT1R6TFBsQzRkcEN3SFRxZ3huZVpUczU5WE9VK1pqbzRmNHJIMDBNK0Jn?=
 =?utf-8?B?aGE0MXBwRnd6MUhCZ1JIMDVJeHRGNStpQ2w1RjJ3YXAyU3BxdlJXdDJIUnVQ?=
 =?utf-8?B?dlVqWmNuK2VESnZVVW9ESWllVkxaK05xOGZBeEcxNkl0cG4wY3NBVThvS29u?=
 =?utf-8?B?TzBHL2xiZnlJQWU3ZFNtb0V6MFJ5N04wajN6V01TM3RoMTA5U01JbFVOT2Fm?=
 =?utf-8?B?MlpXYmFWR0ljREZwTkFFWDdHRmtmUllkRkVrR3NZWnlNWlN6bWpCUnVFRjJz?=
 =?utf-8?B?WnBHU1ZWTVM4d3d4TzF5WnBXbXdjQU1NYVVXTDAyZ1lLQmRCVldhYzdxaUxU?=
 =?utf-8?B?M3U0VFVKMWdJeTBuVHVsajl2djU2cUswVStGTlI3ZGxMRmVpeWFiZjR1QWg3?=
 =?utf-8?B?SUZNcWduRnVEdmh6NHZvZWx0dDVHcUhEeUc2WlYwajhWWTBGaDF3K0VZdVdR?=
 =?utf-8?B?eWZPWnlhbnp2eTY1YUk4SGlCZFowNTVwMWVkVUNHWlNWNHNTZmZhaS9Lengw?=
 =?utf-8?B?WkxhYWdhYzBXN0daTkFteWpHY1krcDdVUlh1WmNLdWc4NCtxeTAxVHVVcGxZ?=
 =?utf-8?B?Um5DUEFlclRBalVFczZzTGYrTmtWNllwSFVybCtYbFhMK0kxLzlNL3RQK0FH?=
 =?utf-8?B?WWlScG9KeE8yRWlPbitZWXpsYWxOb1hhQUgrc3BycFpaN2pEVngraFBKaWhm?=
 =?utf-8?B?dzNkblRZWmtTWG1GSzdrUVEzUW5Ua0ZFVmVmTUpSTXkrMGtSTi96SW5NMTAz?=
 =?utf-8?B?RkpQa0NjUkx0TmpTSWVjWmZOWlB1NXNxeXkwN0J5VVBFempvRW9KYmF2MjAr?=
 =?utf-8?B?Zno4YXpVWWpOcThndXB6OHdZK0FsNGsrWnN0azZmaytxVWhqVWVKdDlabUVB?=
 =?utf-8?B?ZzUyQWxTVGJXRHpTTXRFM0NodG01V0xvMlNGOWhoaTBleHhmbHAzYkRGMFBn?=
 =?utf-8?B?MVU1bDhQcWJQcXBoSy9ZdnVIZFZRdVhONXpKVkNMeFVzd2VSV0ZQS1Baa1BB?=
 =?utf-8?B?S0FuQXF5eWpwYmo2YktDMm9oZzk2TDdPSERGVVJJc1VDQXU2SFBCdXNGVXBz?=
 =?utf-8?B?UFJYVjdVQ05BeFZyc0RQV3lSQU9CVGFza0tDZWYwd3dGc2E4UkppbmRuRzND?=
 =?utf-8?B?T3JLMmpvT04vVHlhNDFKRkVFWlpzR3RsOGZJOEZSeXRsVVg0V2EwVFYvTStx?=
 =?utf-8?B?Rzc3QWw0Q0FpblNRa001eUwzOGdYVEpmZUlQcTdLWmYrTnd0RkJqTDB0RGUw?=
 =?utf-8?B?eEMrSHlmdGJIRnhrcHplOXZndkx2d2dPd1d4eWNyNnRkcDVHaDJScU9YN3Nn?=
 =?utf-8?B?Y3NTd3Y0eWdJRnRoODR0VjFPZmNUWHZ6SmRZNjgvSjU2emltaitJc1pnL3hQ?=
 =?utf-8?B?WkQ5c2gvM0RTdG1XMlgvcTJSV2ZmTHh4dHJLTDg3eW1Zd3BWZWtkNVNYNGE0?=
 =?utf-8?B?ZXQxSGhSRmhCdjVBb3BERVR1a2h6T0R6V1ordTgyM3hrS2t1TFV4ajR2d2pP?=
 =?utf-8?B?WWV4SUdZcWxlSnZlTngwOTZwT3NMeGJtbklDNGFNL2t4LzJzN2dpS2FVOGVN?=
 =?utf-8?B?NFJKTlNoNkFid3JyUlFQb2UyT3ZucDlTMkpTNE5QVkl1cFJ2NTFRb0ZvbXdX?=
 =?utf-8?Q?8jI9iLYExeGMbyBZLoJgA42Xa?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c572ce98-2331-44da-1381-08de2d836985
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 07:05:56.8278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JipLWyyNakjFUAhfZtuI77fr80r6VF8yjUJNudlCyeg7yma5PiddA+qm2zm7mrFl0rcL2VPh4xPg/tzMN+2R5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9307
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

On 27.11.25 07:48, Sune Brian wrote:
>> But - as you introduced yourself - raw mode loading is broken for most
>> boards, specifically the DE0 Nano SoC. It uses sector-based raw mode by
>> default with an offset which only works by chance (if at all). If you
>> switch to partition ID mode (like the romloader), everything falls
>> apart. That's why I sent the other series. It may not yet be correct in
>> all details, though.
> 
> Hi Jan,
> 
> No additional trouble on here but just want to
> confirm how you run your DE0 board.
> 
> 1) Do you use a pure MMC boot? (no NOR Flash)

Yes.

> 2) You follow old boot flash method write
> aka placing "u-boot-with-spl.sfp" to A2.
> The "boot+rootfs" partition can be empty or
> not exist.
> So simply the entire sdmmc just contains A2 and
> u-boot can't pass SPL phase enter U-Boot phase?
> Are you having this trouble in the first place?

I shared our wks file [1]: We create a raw partition in a legacy msdos
table, set its system ID to 0xa2 (via [2] when we use a hybrid partition
table, or classically [3] before that), and put u-boot-with-spl.sfp into
it. SPL is picked up by the romloader, but SPL in upstream completely
fails to find u-boot proper in that partition. And that is first of all
because SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is enabled by default which
ignores any partitioning and only uses a hard-coded sector. If one
switches to SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE mode, other
bugs after 2a00d73d081a surface like no longer built code or wrong
offsets inside the partition, and you also end up without u-boot proper
being found. Whatever other partitions or partition tables exist on the
SD card does not matter for SPL loading u-boot proper.

Jan

[1]
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/fa81b7aa856049af984f404047a2005d251b6072/wic/de0-nano-soc.wks
[2]
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/fa81b7aa856049af984f404047a2005d251b6072/scripts/lib/wic/plugins/source/de0-nano-soc-firmware.py
[3]
https://github.com/ilbers/isar/blob/master/meta-isar/scripts/lib/wic/canned-wks/de0-nano-soc.wks.in

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
