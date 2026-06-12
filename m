Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EA0CD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B90A484878;
	Fri, 12 Jun 2026 20:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="w3Fbhlj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F51C8488A; Fri, 12 Jun 2026 20:59:18 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 725B984717
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGiZEMp9BBNI+Gobj3nrEw9axILDY8cCcDpgn17UiUyTbzkhtMqwUd9NBkRfmvhIlQwUAxH9fbQAgZXZOGrujo/8XiLxTOH8zNHbVuk+io7x8xQPnM3KSdW2fLruJ5mkaXvggEbUh5opHiuOiv2yvolpoBPDewH8ZxmRzNIeK0B82+ncTAOfZs1YTslwR0XwLAoSED9H+oWyGYHG/EKrGBPO4JyrUfLaW4XpuyOgjs/6Rd5kYRyFFsLxax2WWhjBWG1T9Iy6eAAeAtqBzRVQ61Xar/miUsf9ZySYJ9KwnrDQNB1sjB5/OQk4rPI7iY1Qsh0NV/+mXucB0UMfxPdDyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BpxKnok+UvUWx+ndolm2CDx9sgkAFshDwStga9AdNI=;
 b=lxyAKWZhLRqHjUE57NE/YBMhBqFpNN25qrv8UkzONm5ZBLaqXKeAaI09EGhTw6edZ27kmZFmwsGZHfpplPCn/8XRQI3uAFUPkwkgYBjRp79NlMMxLDMXKaz7eAybT6O3SGFMYlofEKo86ss7Gt39y5eD0B/XvRtDuh56FQ9rq1ZsVk8XZpc0SW7Ixe/UIFCjVXynchjZUAttM0XBkE63gVyleTOrUwIlo3JuRu4fugNRWzZpZteBQlvp3yBAmmvAwNQW6PRLEsQzqePPb/4T9n5jmRaXGlPYcVWjkOhcEY3w3wrLfKfIKBt6cgk7RG2yk3ssnDUPjBIao9CHNhAFng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BpxKnok+UvUWx+ndolm2CDx9sgkAFshDwStga9AdNI=;
 b=w3Fbhlj3dwyg+ozRO+bHKmDQyVTseuqMr/Vvu1SLtCHGSnBJjjoJ94pwpYUgdZ5vtUHzsdhM0mRg+RuVkd2Cfk87g3I2bfWSqRMbcE4xAda+Yoq1QwyI/VB9jS/7yOCCejeZZIuaA3m0xJzDeHGlyDOV43s25/IqVohnsdkTsv+DtLlzqCntmePQgBoq3UrYNG+wb9u/jXiE19f24OKWtl5JayGEZGYGD3R6cZ2WHxLoRitgUDUb8tCMcexs8WW7yU4ZLO8VQgk4iTxkqSW9OHgE44epHpUF10ctaZdHq/4xoXJiFCGMwJFBfY17yD9iRSA45IY5wm/dxkTgYFYXFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6204.namprd03.prod.outlook.com (2603:10b6:408:101::21)
 by DS1PR03MB7895.namprd03.prod.outlook.com (2603:10b6:8:21d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 18:59:13 +0000
Received: from BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::47fd:71fd:88fe:6fe4]) by BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::47fd:71fd:88fe:6fe4%5]) with mapi id 15.21.0092.016; Fri, 12 Jun 2026
 18:59:12 +0000
Message-ID: <244faf7e-d02e-40ef-b196-7bad115faca2@altera.com>
Date: Sat, 13 Jun 2026 00:29:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mmc: sd: fix redundant 1.8V voltage switch on cold
 boot with UHS card
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 trini@konsulko.com, marex@denx.de, Judith Mendez <jm@ti.com>
References: <20260514185411.20884-1-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260514185411.20884-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0290.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:221::17) To BN9PR03MB6204.namprd03.prod.outlook.com
 (2603:10b6:408:101::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB6204:EE_|DS1PR03MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b4c570-3fb7-49b0-6b34-08dec8b4b10e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|55112099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: p36dXnf14ir45mrzZVDX2Y7IMnyEIEBa4F7FfWAjjcB1gTLBO1hwSOS9CKgwNVnJ1d/Us7arU318+igjdQIiFnDnwiCehrdHZNrVCUhvXHX1+XMWgZ3+/T9f/ayXmqyKGmb2YULo22fSztzG0UGOrlJ7U/3QOQzpFxCnUYEQANIAANnYfv594SNe0lpcfZYzErIRWlWKKZwDGyx24b70Ct5qRnLLTfR7ejC+wC32wx7aSqxdf7F7izAF8a1x2r5qS7XDelS6NLZgia3FXN7gafgk3i91WmaEoHW9+EbecBFU9SYKIk84dzeYOwNQ2lZRAYc56qmh6P/o4vuvjP/rAUyVE3fzVnXSpd0P2ueBvdbA6g9IfRd6SHh1JNsJ7yZ/hzpz7uohoTNpYcAnmOiDedrXU3yqovw23TAzxu1cie47Aj4essOkQsh3ECA1A+c7sGMBxHbmGb2jACspiwJUWoPisDI+R9vmnyHG3KRUjvGzkL29KRwlyNlWUkvkjZsIlJA42GSeO8BX3n3aqfESo9dubUDnZHgYz0x4x5BbX2CR1SYwlw8C4pVv4cAH/owqfIeUEfN0rUMu7a+1uYJJan/n/C6stICiyYXYk0bE5ObGVOBqVbMJViki5A4ZhjikIhB/JNnWg8rCq1NUSqsCvXfPPeTmgVh190TB/bdMbGp1NQdNudbyvrS2z9dviYyL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR03MB6204.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(55112099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkdhMjdNQzk2cmVjREx1L3RULzZNaEIrNUk1TVlyUXRXZzdkcUJiSnZTSW5x?=
 =?utf-8?B?Sks0RkU0Vmp4Tnpaa1NEVDVWMWo3TUxjRmUzZHBoUythN2wrdVhGSnZuSk5a?=
 =?utf-8?B?azRPSGxMU3dpNGhWV2JNUmRDOWVIek1mOU05K3prdUdJK3o4bGt1bnZkeGhY?=
 =?utf-8?B?aEp2TjdpKys2NWtsd0NpVk02bE5NZXlrcCt1ZUxWRmpRNjRQQklKTnIvWk9q?=
 =?utf-8?B?YU5VQ3o2WE9IWWc4K3gvWTRGNjV1WEhmWWkrM2x5eDc3TVF1ZDRNRkdNMmRx?=
 =?utf-8?B?cXpqUmRDVm44ZVVVaW5NbnhzSG1jYkJ5THVMbkwxaHRJUW5PUTZkZzd4VVBj?=
 =?utf-8?B?UUVjMFExMldITFlKQXNKdy85MlovajJUZEhsQmlIN2d5WVhSWVJuVFZRbHhE?=
 =?utf-8?B?SXRQUzFaUUZLeGRrS25JSFJ1VzNZZ3l1WXNkcXREaloxZDRMWTZmS0lXRjlo?=
 =?utf-8?B?anhabXUwZU5kSWJmdjhXbUFrY3RmNEhWUGY0eFNzdkdyb1FZOGQvSDU2Y1hu?=
 =?utf-8?B?aU9TUml2RFJEbUtLRFNUcTJFNUduOUx5c3dMVmxHbGI4TGlqemhxUEVzZUR2?=
 =?utf-8?B?LzZySGRHWTJSa2tDMCtoTUgwKzV4VjExcGhIUVlMYnRqTXFMNWdqQzhoZ0hG?=
 =?utf-8?B?Y0dpa1dINmRrQjlCa3NvbXlUb2VZUUhPU1RqcG1mOUxuQ1c3RnkyRkVTOVQw?=
 =?utf-8?B?UWJHTHpoNVNtOHZVYUdrQ1cyeTVuOHd2NXlYMXhmRnAzeUVvVkZlZGZXSnls?=
 =?utf-8?B?WUFWRUhOVXJSQlpwNWxNdWVhY0NwZ3d2LzZWYWNZTEZ1L2FnbkFDQTRSa1l1?=
 =?utf-8?B?a25Zdjc2Y3RUY0RQQldacFBFTlpITHBRN2h0VVhza241ckVNNFNGZW1xSHFz?=
 =?utf-8?B?ZjgweUE2NHl6ZlJQcFpCZmUrdWoxcE85WGZFcXhwUUc5Zk4veFkzc0ZNUWkx?=
 =?utf-8?B?V3hWL0xGK05TbDRyNG5ycUFPTDBQTXU0anlJUFhsdEczQ2hFVVp1SXI3Y2xR?=
 =?utf-8?B?blVjYnFBQU94TlpneTd1aXNEMEs0Ui9tbFYwYnRDUmRjVVZTdW40OWhzRzR2?=
 =?utf-8?B?eFd1UVlZRm5uRVVZOHEzdExKMnpUN0NTMW9zcVZUV0hZUVlvVER0cU1PZTZN?=
 =?utf-8?B?YTNJQzlBN0JVaUtnMkFQQ2xGRjhSME16TWJWTmdMclU5ZXMyVHg4ZUlHNWhM?=
 =?utf-8?B?OHlFY3VYWVEzejFWV0JySVdmLzgvOEwzUm41RjdETkVwSW9kd2NuRkc0RFM1?=
 =?utf-8?B?WkVjUGhiK2M0MGxQeHBvWWhpdUsrWXVQT2Iwc1ZJZjZqZSsvTVp2ZVl1L1Rn?=
 =?utf-8?B?aUo5T1QvbjhKTXNIQmdtNTM4RlhYZkZ2ZUNRSDI0YzFSVWhjTDNveFE3QkY4?=
 =?utf-8?B?WUlObjU5aHBGb3BKM2Q1OXlmTCs0NWxrYWRGQ3pKTkxvSUlmTW9DUW5VZTJx?=
 =?utf-8?B?b1h6TFlpZEFub2tsWTZ4VFNXRUc1ZjB4dWdtZjdzU2dPdUM0Ui82YlFRYW9Q?=
 =?utf-8?B?TWZCZjhxaUo1Nkp1M3ZzVlQwRld1V2RZTll6U3oyZWRCdjd3dUJrMlNzdGpG?=
 =?utf-8?B?K3oyenNVNlloNVQ4OHVrS2JldzcwMmFDVGRLR0YyWjdyM0RGMEpZYStZVEY0?=
 =?utf-8?B?SGtwMEJEUUdqdENTNG5RdlBRQ2RkVlMxSHBKTTRBUS9NT01pSDZkcGRKaEdI?=
 =?utf-8?B?bnNXdE1XSVVQTkZFNHIzQjU5aGt1bWxxVHBKU0prRmhUMnYyRnhESGIyZndF?=
 =?utf-8?B?VW9rcGhuVUhtK0RRWksxY3E3THJrZUowdlBWQUJSTG1GTmQzWGxwYzNHRU5u?=
 =?utf-8?B?TXdRT1E0WkNQYkdCQi96MFc0c2w3TE1TUi90MjJhK20zYTI5TkZWbGdGR3dP?=
 =?utf-8?B?YUlHVlpzQUMxSmJnYjdTakkzditmckxqOE1RZFJra043YWt1eXh6d2xNOTRO?=
 =?utf-8?B?TTdmaGFKeHdoTFpFUGh1YjFCMk9XY0p6MUlUc2trd0pzNjRBMWNqeE5yeDRE?=
 =?utf-8?B?M1F2bGlRWWwwTkxKeDNETU5Va0V0ejFaNVVXeWNzcVgzM0ExUm9JRHZnQkhG?=
 =?utf-8?B?T0VERTVQeTVtdXZJeWpHR2NadzNXc2FES1FvRWl6SCtuN3NaK250OUFzTUZZ?=
 =?utf-8?B?K3U4Y29OeHg3aDg4QkJOTHQwK2RTRnFJamhJcGp2UVkrSHlBNWs3L0grT0Jz?=
 =?utf-8?B?TFN5bFo5bTlOeFlKbE53K1hkNnFBdWg1dGRkTVBORG9XVFRCNFNPZ25tRVlX?=
 =?utf-8?B?WmZIck9oUjF1a3V5WUIyRFZsQ0pXb0NKbkN4Sm5ySU9hdkREQmdadGFoRVl3?=
 =?utf-8?B?Q2p2ZGthZHZmN1JCNUNlVHoxYUxnWGJtVWRwTElUcEhsOHRsZm5pNkg2ZEs0?=
 =?utf-8?Q?JzHoJn5+t/YFiCzg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b4c570-3fb7-49b0-6b34-08dec8b4b10e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6204.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 18:59:12.8173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rqpnq1b7hP/MKny7dhh7ljl+IPRJCf088Q9FTFFLeIHTow34irKAhF0IxVf7kV9iWQF9OEhUPgxtex4J3reVYm6z5KNyTQ4CU8rnavQxHxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR03MB7895
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

Hi All,

Friendly ping on the patch below - it has been about a month with
no feedback. Would appreciate any review at your earliest
convenience.

Thanks,
Tanmay

On 5/15/2026 12:24 AM, Tanmay Kathpalia wrote:
> When a UHS card successfully negotiates 1.8V signaling during normal
> initialization, the host voltage switch is performed as part of the
> ACMD41 handshake. Without this fix, the warm-reboot recovery path
> would fire again immediately after, switching the host voltage a
> second time unnecessarily.
>
> Add a check so the recovery path is only entered when the voltage
> switch was not already performed during the current initialization
> session.
>
> Fixes: 906ee6785b1c ("mmc: sd: Handle UHS-I voltage signaling without power cycle")
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>   drivers/mmc/mmc.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index 7dadff27abe..10d8a37d2a8 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -2720,10 +2720,11 @@ static int mmc_startup(struct mmc *mmc)
>   
>   #if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>   		/*
> -		 * If the card has already switched to 1.8V signaling, then
> -		 * set the signal voltage to 1.8V.
> +		 * If voltage switch was skipped during ACMD41 but the card is
> +		 * already at 1.8V (retained from a previous session, e.g. warm
> +		 * reboot), re-configure the host to match.
>   		 */
> -		if (mmc_sd_card_using_v18(mmc)) {
> +		if (!(mmc->ocr & OCR_S18R) && mmc_sd_card_using_v18(mmc)) {
>   			/*
>   			 * During a signal voltage level switch, the clock must be gated
>   			 * for 5 ms according to the SD spec.
