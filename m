Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E77C83F1A
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 17:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4E0F83564;
	Wed, 23 Jul 2025 19:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PL/wk6ux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00D5383577; Wed, 23 Jul 2025 19:03:50 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5359833D0
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 19:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obkxpZCszdo5/1GfIS9hd9QxMo/XPVYRijLCgwdxyE28q1K6xgpw1XTqqz92+59v/CYODQ91XlYuWNLsX7cOgBEBPy0F6HwwjoYMbuGe/tSfPZbW3unPU4ckh5nOQ/Vy9Mwoy2/abuprejc+xyhPo0w6U7iXPArR7hdj+wi4Mh2tNyHsF46p0JW+Ftp3qH1cmFdJdvNxGgaMjG63wEr4ZQGqgohHMBySLtnbkTZUn3Sdj1Z77duxr1jnaUP4QpRLqegkbhFO0ytvkPvmO9d4UyMu/zkM8yyX/NYKyH+kQf6yZ3k5/MPZDBOSTaFoBtwuJHo2GCRZr4nIqvZ6xwZofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItKcQtAPfCupq9mMv6+eRIkQc9Nw81pygphVLwVC1T4=;
 b=eC9vEoQ9MrLEGGAwFwJsPCaCVKpY6OHODqUqtzgpmKdtgzdoPdu0Hu/a+Fu2lnogGa5sMYsS5KC8nmja1zCbn6wv8I9nBIzpmBFyKbIR6j3URkOU7M44HqEKQ5QM6acC5BrnUyBrvxQFDUe4LMEaif4brhiz548QvBATm5BpVzB+EWPiNUCSotAtLcgTdGVbTfFTFIz93sRrScJuQAZkc0QB2D/qEg+XEtoah39wyjI2yn4LXL8JAJ02ncXlf/7i/b/8r1XbavVeFVmhnCvwYvZfNCPG+tBtdY29yxy64+3+CsGsACQnsiTqgXj19MPLnOrtSen6j62hB5/vz+rqCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItKcQtAPfCupq9mMv6+eRIkQc9Nw81pygphVLwVC1T4=;
 b=PL/wk6uxaq4MwxfT8x8O6kEbTCFAXRAum7+Th3qYJO4EKpgqTHPmWZg0ut+c2+0kjfXmqTu2Zwd4KsOoLcWaO5kanergdxKPWeOHnAIvzlxFJQFSDEtFtarKH41rRqOXMaKOv3tlrBZLtbUF+un085r/YO+46bkpXS8N+lgZ5eI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7460.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 17:03:45 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 17:03:45 +0000
Message-ID: <cebada69-7792-4792-b603-19fa6ed8df94@cherry.de>
Date: Wed, 23 Jul 2025 19:03:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: cdce9xx: Remove always true test
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250723-cdce9xx_clk-v1-1-9cb1f734637b@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250723-cdce9xx_clk-v1-1-9cb1f734637b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0038.eurprd03.prod.outlook.com
 (2603:10a6:803:118::27) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 39969cc9-906c-42cd-9588-08ddca0ae274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTdkeCtPM2c0RFkrU0YyWmRBeXpRQVhLZWpObnJPT1kvK3FuZ3pGSThSZnVi?=
 =?utf-8?B?OTd6T0FTODVVeTBtMjN5WmdBOENYMTZFem5hNUY0Q2Zsblh4ZVUwUmlLVGs5?=
 =?utf-8?B?U3kySHRibXYxSU1XeXh5TTdBaWxZVExjZ1VuRGJna1VMMXNQMzhNL3pCZHlh?=
 =?utf-8?B?S0VCdC9idHZLdnNwVUtSQVFuNXp6d09QNlJBTmtBS2doL0dwUUtaWWRicC9H?=
 =?utf-8?B?ZEVIOENOU1pCbTZHQ2dFYWNPWm1SclozYjJRd0U1L2htZG1pNWQrTGNkL1o1?=
 =?utf-8?B?amh5a0FQRzhvS0lMVHg1c2F0d2VvZHNQWjNKaGlvZFFacllFbFVEbTNMbDVP?=
 =?utf-8?B?Mnc4VDhIUWp1Rk1RbEk0RlUrYUljcTJyVVh0eS9HdmxWeFZ5Ukw2QWhIN0Jz?=
 =?utf-8?B?aGdCMmRORWVvbG5xTGN0YW0wL0V0MXR4dVdKT0FVUUR2N21sZmplMW9ZMlFm?=
 =?utf-8?B?aTVWdlhFNWdFenY2Z1Zja3A0bjhCU05takxRRlVjQlViS1J2bkEwUzZpdFFG?=
 =?utf-8?B?ZU84V2UwaTZWTFRDRzdsOTN1NmZxZHpJQXkvNnVnUWp6Ykt4QTJRTk9DVDNk?=
 =?utf-8?B?MFlsck56Z3NqaWNKWm1QbUpXOVdPZ0VpWTZtNmhxYU1IN2wxTE5IbXl5UE1R?=
 =?utf-8?B?WmtYb1ZCZ0tKRUx1a0swZHFtWEdXd2lDNXdHTHZyU1V3d0krMWdZWERQc0t1?=
 =?utf-8?B?QW4vVitPZVBPOXdnekVkS2xGYmxXdysyZndWcXluVkJyS1JSVGN3TXBkSzVv?=
 =?utf-8?B?YlhvZFYwMllzM3paWU1DMXpGcWt5OUllcXhTOUJRL1N5UlpaYWFudGhHSXpF?=
 =?utf-8?B?MUh6K1lvYWZTRVViSE5iNWhyU3Z2SWprbld5MnpQU1ZOUGJ6VDdzM2F5M2pr?=
 =?utf-8?B?Ym5WUHhqckpHUnJ5M1IzTHpUbGM5WkNvSzV3elpWcVZQV2pITWZWdDFBRjVo?=
 =?utf-8?B?L21wYStGeWZNQkEwUXZZaS9YR2gvRVF5L2Jmd3pJQmp6RHo5OEZJVkI0TGlo?=
 =?utf-8?B?cGJ5VFc0QkgxNWhzT3dDanVwQTZMN2UyUFh3aUMwdUlIWWFtYzYxZHlmOU5M?=
 =?utf-8?B?TUxOWDRCRHVNZmYvSnhROUlXSjJHMmxuTHpwQVd0dFI2NnR4YjFiZDZqT2NW?=
 =?utf-8?B?eHMxU2tLdlk2VmdLdlNUb3JWSVZwbXJibXBHQ1V4cGhOSDJhZXpNMVFmNHZx?=
 =?utf-8?B?V3BabkgyK0JOeTJyNFFWVGVKdjUrVXdHQ2JNbTRaQWMxZEgzVzY1T294NEpm?=
 =?utf-8?B?eWZBRG9sUUYrblF4ZytzajNuVVNNQVhqMFV5TGNTNGgvdk5pQ0VJdHdkVXJy?=
 =?utf-8?B?amEvdmJNOGxHdDM4NHlqM0wyQmo2YmR1TGtjdDRFY0RGZ01VRDdQclpZMmJS?=
 =?utf-8?B?VUhnMk5GZ3lkNmxEVHVGbElyM202TFVVc3NQaFljMlBTcTNjQ1oxbXdLRE4w?=
 =?utf-8?B?MXhvUTl4RnAwQ3BIeStjY0J5NGtFeEpPT040cGphQ0VtKzhkei92WTJPWFNE?=
 =?utf-8?B?bTA4OThKSHdzQ3BUV3k3dEZWUDdTS0J1bDA4Zm5HZEFGM3JxbTZ5Z0Rvamt6?=
 =?utf-8?B?MUFjUE4vZGRmL1BJd3NVU1h0aFZ2MFFVQk1sUFJnVGNPdE5QOEtrME1pSzJt?=
 =?utf-8?B?Ym5yZlRVL3pjUnNnWk9Md1V3SUh2ZXA1NWI1N213YS83UUJXLzA5bjNocktE?=
 =?utf-8?B?MFp5ZllkbmlqU3hBUFlqd00yakhHVG9YbjNHTDh6T1gzNDE5dW80cGhJMHE0?=
 =?utf-8?B?SjF2UHJFcDZGSWxIK3BiWmszY0tLSzdxWFRtVGxNNnRKOHREVlhJSUpRSEl3?=
 =?utf-8?B?UGZxbnh6bHhYcUFrVzZMK3NJWHFUL2U4dFNqK2o5TjNBbzl6YlFpTGIyWlh5?=
 =?utf-8?B?R1pyOVZzaTJYMlNab0pBaHJvVDhQclowMTFNZm8rdyt3dUZhYkl4ZlpZTGkr?=
 =?utf-8?Q?qVLUA4kvQWM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVFjS1JUSHY0M091amlLeXFVUVI5dzdQMFdUcFEzMzNVaWlKcUMwL2lMQjNT?=
 =?utf-8?B?RTcvZHRSNG0wcHcwd3F6SHVVOU93a2lpa3VPa3RSTGgwdTFvaEw0RUdiQkdy?=
 =?utf-8?B?aU9RaGJtZVNiOE91TkZ6WG5zUFlhd0FPeFcxU2V3c0c1VGc0ODJFNEpSR2px?=
 =?utf-8?B?cW00WklLMlVMVEM4NU1XcnhSSFpzamQzdHlrdW1oZFRVeVB3K1RLRE9xY1dY?=
 =?utf-8?B?ZytYMHA2b2NaTlBDb0lRM3d0SWltdWlLYWxEQWVZRzNMbjdGTXhGQ09VejN0?=
 =?utf-8?B?N0tZd1ZJNmNsaUVYc3hKU2dNNzJGVHJFYjhWOXFseUJ0cE1WcXMwQUJhTWMy?=
 =?utf-8?B?emJGb1VsR1NNTTN2Vkh4Zkc3L09yaEhrWU5pNFErWVB1TmtrT2srVThCMkpN?=
 =?utf-8?B?UjhNYkhCa3lPSVViUE5Fald5V3lTRUk5WDBQV09QQXNYQmxYcXlWRTRubVFu?=
 =?utf-8?B?SHAxaFoxSXFqVk9nVGpQb0U1Y0xORGlSWE9LeWhGOXpMVytvV2xLbnZ3WFE2?=
 =?utf-8?B?VngvVkU1SEw3a0ozU3BFcVlMWk9WRk4yMWdkWDZKbm85WC9GWnlJZmFTOGha?=
 =?utf-8?B?c0hjdlI3YkhiS0NFVCtjYldyYWNLbVVHb1I5NVVmNVQxd3UrT1d0OW9aQTU0?=
 =?utf-8?B?WksvNExUd201OHl5Sk1xb2doSnNZUDhwNmFlSFVpZmt5WHNzaitaMnNHUVp2?=
 =?utf-8?B?WWY0Mkl3NjBOcmcrTTZDaktRV1ZBNjUxYVlFcUdCUUVITUtydWhNV2lKdURW?=
 =?utf-8?B?ZHNjWmh6TGJaZ3JxSmxDK0YyaHlua3hDQ3IvbmFsTTRPVG5Jb3A3SHBlS2R2?=
 =?utf-8?B?SkJDL2pmSEZNdmIxdExjRlI3RWtzT1BjK29FaFo4U3FQTUJEd0JiT1QwNjUx?=
 =?utf-8?B?WGdkdklhQm1VbkhBeUpwK2k5a3FQVDI5QjJKUTFUMk1HcExXN0QrMGlUMGlO?=
 =?utf-8?B?MzBXMzl6S0ZsUmpGNU80TjVOazdoSTltUEdtUzJxaWlpUHJOSklsQVhIR1JM?=
 =?utf-8?B?ZzJxR1lzSWEyREJCcWRSK05LL2crVHgxWTNZczFoaEJya0tRVzZqSDBheWQv?=
 =?utf-8?B?Yk1vWXlrMFdoOURUclhHSmtFTGpFRXpGVkpBSm1DWWc1djZ2eW1pS1VEQUIv?=
 =?utf-8?B?dDFwam9zMlM2dXVzaWRGcTI5V3ozc090UEVENk9rRDY2QXBPK1FEQUlYOW13?=
 =?utf-8?B?QTMwalF4NWEzaDgwRU5VY0JiMXhreDNNQXdpOURYZDRqRWpBblZPOTBiUUV0?=
 =?utf-8?B?UjVRNU5udS9vZ3RSM09RM0VJNGVFRUh3TXFYcUxEOGRLQXVaWlpRQ1k5NUlD?=
 =?utf-8?B?RE85M0cvSXljKzRkMnMxQW9BancwUmcybkhhZTVGQm1vU0RxNGo1bDFDR2ll?=
 =?utf-8?B?MGdGMHVKYmxXMHFnLzRUYXlCVk81UlNRQ3hYaDh1VXo2b3VJUXVpZHkyb2po?=
 =?utf-8?B?Nll5aXFhb2tZQVZhUEJZZ0ZLZ2VISTh1MndlMm5hNjhOK0FMUHdxcktBOUli?=
 =?utf-8?B?WEtieGFXeWtFbklPeDFmbWJySmJoVGpob0xoVkFJT0hielNGS0Nrc09VZzh4?=
 =?utf-8?B?NU81RDhsOEs2U1pPL1g2WUZHRWtwcVFLcWFyUlg2TEYyTDlWbTBmeVU4ZThi?=
 =?utf-8?B?b1hadzlqaVpxMjMxUnl4RXJxNkhyTTdQQ2M5UThDWS92MWIwWUdLa2RNeWZP?=
 =?utf-8?B?b0UvTzBHMGFTMGJsVWlqQnZobysrVmdrYm5aYkMyOXhjNlZFRUtNT2dVbDNq?=
 =?utf-8?B?Zjl5aEJtWW5kU0FiS1pxdUoyd1NTTTRCRS9GdldUVDBlKzdhVTVoRkljWHlo?=
 =?utf-8?B?UGhiZ0JEaE9zbDV1NGJGUDVPc3BBK243N3FSejNUcTk2djgxbXlOc3VqWHY2?=
 =?utf-8?B?MnRVZktwWHY0YnkyZ0ZZZE1pRUoyREhnMDM4S0o0SkZud1htcTFseHZaSHZh?=
 =?utf-8?B?SlBLOHhibmc2R2VwWVZKbFRHZFFTVGljcXVYWlF2dXNEVkEyUGxzalNmelVV?=
 =?utf-8?B?NGNiWEN0QXY0Qmh2Rzg2VlhRWWZrTGV5Q3NOZktucGtXQS9EZDMyVjNJcG1O?=
 =?utf-8?B?UzZaVmJKMFNmODNLZ1lOSnVDNGljY1NBdm1SSTlLbTNoY0M4WlZFNlR3WnFW?=
 =?utf-8?B?eWwvM0dETXRtS1hTRWdPNzYxcjkxVGUrUVdjYW1ZaVNxSUhVNnZNQjZnUWpP?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 39969cc9-906c-42cd-9588-08ddca0ae274
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:03:45.6393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GV/RCz6egtwRrGLlMviTd8MjS7WvOTKppTVHL5DE0f+4KShLVH2yoU6O95LbLE/b4UCiHRrSD33DGvS1H3sutiFpx964Hi+P7e9Us6huLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7460
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

Hi Andrew,

On 7/23/25 5:17 PM, Andrew Goodbody wrote:
> The function dev_read_u32_default does not return an error and the
> variable 'val' is unsigned so testing for >= 0 will always be true so
> remove this test.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/clk/clk-cdce9xx.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk-cdce9xx.c b/drivers/clk/clk-cdce9xx.c
> index e5f74e714d5..492a196604a 100644
> --- a/drivers/clk/clk-cdce9xx.c
> +++ b/drivers/clk/clk-cdce9xx.c
> @@ -117,8 +117,7 @@ static int cdce9xx_clk_probe(struct udevice *dev)
>   	data->xtal_rate = clk_get_rate(&clk);
>   
>   	val = dev_read_u32_default(dev, "xtal-load-pf", -1);
> -	if (val >= 0)
> -		cdce9xx_reg_write(dev, CDCE9XX_REG_XCSEL, val << 3);
> +	cdce9xx_reg_write(dev, CDCE9XX_REG_XCSEL, val << 3);

I think the original code was broken?

I assume the intended behavior was to return -1 if the property isn't 
present. Obviously, dev_read_u32_default having a -1 as default won't 
return a -1...

So I think we should migrate to dev_read_u32 instead and check the 
return code and do the write based on that?

Something like:

if (!dev_read_u32(dev, "xtal-load-pf", &val))
     cdce9xx_reg_write(dev, CDCE9XX_REG_XCSEL, val << 3);

maybe? (Not tested nor compiled)

Cheers,
Quentin
