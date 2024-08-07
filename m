Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEABC52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 10:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A02A88AFF;
	Wed,  7 Aug 2024 12:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KZqMe2Lz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83AF088B9C; Wed,  7 Aug 2024 12:02:15 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35FEA88A7F
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 12:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xws+sA7AL4gcDzBaAlW/9fljYNMJiQg/bMWQoHZWjcQlc99VENO+nHYQ0PsBLqH2ku6mHgowH+RLUQjQCRcj+4/I2hjMyHQo37jUMjCmkhV/PnM70yrOsqLaSzJ5oQW9xJXeDWh7L7UzBQnVFw/29I+id8dH1zuYy48R9KwOArjeTxuaYi9tSxh5qB2rnrm2j8ngrYiRx1vQXIlA3vgEtKTpnFgL+wlTId52avunXIWbgYjsxkM60egvXcymNEXIXRiF/cnKk6zlbKvkSHOj1dyTP9uHTM1wMqkSEZ2LIvdZKVbglDXaIo7t1S3fAkPa5wMGJzY/Fvmim0pMUgTIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqgbJSkrvoKoUHbRY4YJtJzKBV44kXlsQg+ZpPQfk7Y=;
 b=eTI77OTbXHOPAcf3DigLZG6tERa7D1kTWvrU5WLpYUdg6KAGfMBhgMq/CYMhVA2GuXxum7aQz3yQuyrxPoTEdY00mi+d3nkJWxorqATek+CZS/E3QdfePuH16tXIZ439P9fARFHzqRYeXfopHRMjDzkb3/D46Cb98GAhAN5qmH2Pbp9fOZQ3axaefTrxjzo7XDm/4UkkIpcVQhCZejeEUmTYUVIxQGhlAChyEwPWw2mWOp1lfBIrFiZHSYU9gGXCy4Uhb9Jn31eZE/YNAVxIYJ8KRHkObmO7DKnH9/2iYfeJ018M44cDunAeLC3sJFrYwwz8icUlaWWnvKs+aMqg8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqgbJSkrvoKoUHbRY4YJtJzKBV44kXlsQg+ZpPQfk7Y=;
 b=KZqMe2LzBHrWq6Sub44bcxG5PSJURUaGNacYCJcJNLn+gpzBlmm0tqY53koqxduRjk8PX+1pCfej7M6pNr/XB6E/p9x3E9dUK3sGuAIOeD6ERl685OWSw9PDiTd21U4mN/SlPjr3t/dXRltKncXoUoZLmk2sGk9m0vuZyEzKVQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 10:02:11 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 10:02:11 +0000
Message-ID: <310b0c48-ca9c-4444-a7a2-d98344cd55f8@cherry.de>
Date: Wed, 7 Aug 2024 12:02:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] gpio: rockchip: Use pinctrl pin offset to
 get_gpio_mux()
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240802225705.2640999-1-jonas@kwiboo.se>
 <20240802225705.2640999-8-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240802225705.2640999-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0493.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7e::19) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AS8PR04MB8676:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a40f73-8bf2-457d-7344-08dcb6c80179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUlkOGV6NnJLTkVsdGN2VG9nWFI4N2ptdDJtY0ozQ1U2d1BtdEZ5ZS9MK1R4?=
 =?utf-8?B?RG9rOC81Mi9laFAxQzdDY2lEWVUzOWxyZXBOcG1XNXYrYmVzNHBVSEY1L3g1?=
 =?utf-8?B?NVVRRkV6eDNNM3NzYVdvN0R1OWtHbUZqb3hob3E0aHM1MS9MdGpRYWxsVHJE?=
 =?utf-8?B?eWl0cWhQMDdLdGtKekh1elNxcTRLN2x2eVRmRzhxKzl4dk1pQkdWQ0xsSndF?=
 =?utf-8?B?MXp0WVB2MmZOKzNpbk5xNnc5NlJUZmZCZWoxSEE2MkhOWlpNN1gwZXJPMkNt?=
 =?utf-8?B?WmVRRzlxblhhdmtsUU5BYmZUV2puakJxeVZFRVUxSEV2OHZ3TzNEdHdEV2Vn?=
 =?utf-8?B?SE1yS0JBQ1dnZmdaUzEzQmdkc05DRno4RlQ1dnNzY2w2S21tK2dhN0RHNHNu?=
 =?utf-8?B?aXB5NEppd01TMlBFQUJGOTg4OFhnSHRxR2dMbHc2Q2F0bkpiQk9RR01MV0JG?=
 =?utf-8?B?cjVlNUoyRTlpUEZyY1UrZUVMOEhtNndzZFZYNmVsanYzMTVjeXZsc0lLZHhR?=
 =?utf-8?B?OHJSM2pWdnBaWXFOTGt3ZkdUcEJYbEg5MUJOS3JDbEN0a2U1elRVSlBtN0ly?=
 =?utf-8?B?VjczOEhnNG1jVHRDT0p1SHZjUDVhZTBBcStTR0tra3hDOUJPbklhOVl0a1JD?=
 =?utf-8?B?ajZWWE42K0xkbU5VU1dWYlBBcDN4eFV3aS81cjVtaWJlNjRGcGtSWnViMFJq?=
 =?utf-8?B?amJSZUkyd1NTM3hSUjhWM3MrYWVyQzRWVGNEWHRUMEtVRnhjU2tWaCs1Zk1D?=
 =?utf-8?B?L0lybjVHcm8xbis4L1NHSmg2M0Qwb2tqY042dGN6MDI3bm5xQVFyNHRDRnVM?=
 =?utf-8?B?MXU2QjB4Q3c5aWV6Nk5hNitrd1JHclg2MjFrN1ppTnlSWUdJRTlJa1ZUd3Ey?=
 =?utf-8?B?MmZzWlFRR2VaekFFaWs1bTA5VnB4T3k0REhXRHl4RURQRE1zamdPT0RaL3Fv?=
 =?utf-8?B?MVlPaGdxVGl4N05kQW9mSjQ1V0phQkFoM3VXY0RtNFhGS2oycHM0S1g0ZHUw?=
 =?utf-8?B?NzFsU2ZtMHoxV3hQYmNKQkVmTWpuVnRHRUZ2ZmIwd2J0WGIwUm5xR3J3RUZ6?=
 =?utf-8?B?Uy9PdGpZU2ttZHNRYzRqdmpCT1IvcnlRL2lRa0F6bm1xUG56SDJiUlhJdDZ5?=
 =?utf-8?B?ZEk5RUk3elhXR0l4OWlLampqNFVOU2pPemt3SThGOG41WXFZU2VaRHZiVUxG?=
 =?utf-8?B?K2xPMWJxNVpKVGxMWDFDN2ZTaTBLQlJCVkZkSlA0d1VVVzZaeDZrVHBMb3RH?=
 =?utf-8?B?TWNLMkxKWmlDblQyZ2dSa0trMkwvNXN0V2R1bUhXNlN1dkN5dHgyLytwYkFS?=
 =?utf-8?B?bWFCWjYvLzBPNkhMWHRZVmcrRVhGRGd1bGV2bmpWNHpsSjkrRktQT05YSnZ0?=
 =?utf-8?B?OGZGZURtS1ZGdnBqM1loQ011cFpTYU9KYWVIblhSeERZaXdNdmcxbUtzaStF?=
 =?utf-8?B?YUZFZTB5YUJsR3lNUEUwS2pjL1paOUZGek1UMFpycThOckE1cnZQK3ZlOVMz?=
 =?utf-8?B?TytNSDVSZlRsS3ZPUzNOTExTYTJLSGZ4alA1YnQ4ZEVZV1RkdHdRMWVqSDVB?=
 =?utf-8?B?V1NmZHFIU252Uk1mMTQ0T1JkNUh0c1NPOW9hMHNJdFdDKzRidDUxU0xJNzFR?=
 =?utf-8?B?eEdEYVU4Wjk4NWsrYnBrNVBTZDJpNmk0d2VFWjNNd0ZUUUFkWGVDZUtpcHBW?=
 =?utf-8?B?U2tYbkhUakIrNEN5d1dvNmkxRmVjVXhYZWdsbUo3aktCMGN1d3h2aFhWN1dM?=
 =?utf-8?B?SDBydXAwQjBYM0VtR1R2cDR1V0REOEFPdjcwVlM1VTBhVjc2SnZncTVEV0ZR?=
 =?utf-8?B?TW5kdFhhNU9Vdk84RGcrQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGhCNFZGTFlNenNoWWxNQ3ViL2VBVjByZjVyeVlrZmY3K082STJqZmhTdHQv?=
 =?utf-8?B?UGZ4WFM1amo4aWFYcDNoZXl3WVFSVzlCNjlqYUg0UjBncGlpSEt4dWhwTUJL?=
 =?utf-8?B?WWZ4c2p1TWN4aWFJdEVBQmFYSDFaRllZeXJZeE8raEtxL0tFRDlMQlFUQ0x0?=
 =?utf-8?B?ZU9EVlk4R1d0aURrajhDM0hxdjM4bklTWVRTVGxpbjdtRGN3eEhnNnlMdW4v?=
 =?utf-8?B?UVJjTkVLbXhtelFTS2JrOWV6VHhJVno0VTZiK056ZEFLRkpGdVRWeElMYUFx?=
 =?utf-8?B?K1FoM0NOb2JkTzdoNkh4L2ZVS09NNzhEMFhBL2xOdHNIeW9kcXd2dzVxQ2NP?=
 =?utf-8?B?VTJTU0hhQWJsT1hzT0d4VDlJcnNQVmJVSDRqMUtrVFVtaXAzb09vQWllV2VV?=
 =?utf-8?B?NXd1b0NkUnVUYUdQL3Yvak5CdmxxS3E1WFhEVzBTbGJMUENkOStOa1NwbzFF?=
 =?utf-8?B?d2dJRXVIVU5malR2Nk9IblJvWVE0RTREZjVMa213aGtHdnFoV2tmTWhvQURD?=
 =?utf-8?B?REpNVUR6em1BcjdiSzFlbllDVjB4c05wMlBxL295bUxCc2w2YytQYTdBbkFl?=
 =?utf-8?B?RkcwUjdXSUdPLzBydXRWUUlwSHEzVzM4OEo1Y2dFVTNtMTdTVnV4cFBZaGxX?=
 =?utf-8?B?WkVnUzNUbW5UVWZZU3RGVEx4ZkcwTHk1NEFaWEVRMzN4K0NBamhaQ1pvZEZY?=
 =?utf-8?B?RmxBYmF5MGFqZy9wU3M5elpVMExFK3FyUzdKUVFvR1ZOaXBtQnI0SlpJdUxD?=
 =?utf-8?B?VVUrQ1JUTHBtOXB1UjdVcDYrSG1BUE5PZDU3RHIwTlMvZUNKLzlHZFdxK1pO?=
 =?utf-8?B?ei9mTTBQNUgvdFZhMWpjdUIzV2hlcVkzMC9BaU9nZ2JIRWZ0YmszNDArNTlj?=
 =?utf-8?B?WEtHbmc1SGs4QjhwSzhvMEowdzNGQjNjbmdKdVFPdXd6U1V3WENWNElObnJu?=
 =?utf-8?B?eEpMR1h1b1E0NGpwNlhLb1M3MjZhZ3NucHlXY0V1ZkJiSWdwWktUcVk1cWRk?=
 =?utf-8?B?UExZbUtkcW16L2pzNDdlWnNHMHBQMFlSTmY3V0xSNnhrMGxKUitCN0Q2djlS?=
 =?utf-8?B?MFpxR05vaXN5Uy80R1R1RDhocXJ5VGNBUXkxTS9UUncwWFgzY1ZQYU1IdDc4?=
 =?utf-8?B?MWJiYWpLZTl6RlY3NXlCclNhUExybTVadG44Q2dWS3RXUVRGbnFEUFg1SFJP?=
 =?utf-8?B?RVpPeStEVitpV0NOKzJKT25ZM2ZyTnQrR2RqVTdVZVQ4bnUybW1lbCt2TUg5?=
 =?utf-8?B?VWlkZC92TGNaVGpXczRjcjNWeGM2aVJMeUJCZHRkb3l1bzdUOHVhUnA2SzZt?=
 =?utf-8?B?WmlJeFZNUWlNMEpYM25OcFFiSndVeHNJUTliUjZaaWtlSWJMbVVWVXZkV1FY?=
 =?utf-8?B?TWxpMVJ2aVdiUys4aGtPOXJwaElLTlF6QXF4YjNYcTBqSnBlK1F5RUxoc2RE?=
 =?utf-8?B?USttenpDYUxDakI3bVdBNXAxZHFGcmVLOUgrck80cUhEMzdGUU5DdFhla3Ri?=
 =?utf-8?B?NHJKTVBYMktCNGZUZDBBQ3VkRVk2N25xR01XdzNmaEhpUG4zc0xRaXJUL2xx?=
 =?utf-8?B?OVk4RkJGbFZNZ2FjWGZ5SDR2MGJiM0g1Z2hEOEJMZTMrRzZWcXNSbzBxK2t0?=
 =?utf-8?B?elNLMFk2dmJKVnZuSWRteGhaeWM1TGUwNWZydVN5T2lVZTRQMUM4NlF3dVVD?=
 =?utf-8?B?RlRrQnhPamRRYWIyaU9nYVVSbmFLN0Vnd1JPVDgzZFlEZWZGSElDbkNuVWdM?=
 =?utf-8?B?cUcrU2R4SEM0K200VGpZRTJlRkdUUE1iNHRsbWcxdzBpRXhGNzhFRFptWFdX?=
 =?utf-8?B?UGt0dGw3akI4MXFXZU1qQVRaSGxacm9WbGkwcG1hMWZsVWRxbmJZZnd4NTBQ?=
 =?utf-8?B?OSszMGFQMWxPcFdtOVo4QnV3UkFYMTE1eDRRM2pZT1FiN3BMU3F6OW5RSHFX?=
 =?utf-8?B?dnZwS2VXZ21zYXU2dVNWaFUyaGJhOXkrdVUyWnFhUVRFTDJGeWZBdFFDaFAz?=
 =?utf-8?B?Q01mT3p6OWp5SXFNN3FuUHlnUExWeVBDMWZDbWd6QWprd1YxTzc2UlNLSzFF?=
 =?utf-8?B?TnZOMGJuZEl5Q1A5QjFqbDBVeDk0eTBWRVVFQ0VtZ2FvU2FVdEl6OTNMeVVr?=
 =?utf-8?B?WnpLWjlIV3ByQ01qNE1oWDdmZHNpajgxUEVObVJGS004NXl4WU9IcmdnRDZq?=
 =?utf-8?B?ekE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a40f73-8bf2-457d-7344-08dcb6c80179
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 10:02:11.5277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8BCuZZ1RLIYirLy9JEdTnlMQ4xAi/4AgJFo8VZxD5+kP7oSWncUwehF2S3SbsrWTMyL28+z+pmW7OdzkE2JTC7NEymwWS0ZQW1SmpOG4rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8676
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

On 8/3/24 12:56 AM, Jonas Karlman wrote:
> Use the pinctrl pin offset to get_gpio_mux() to remove the bank num
> dependency and instead only use the bank num to assign a bank name.
> 
> Most Rockchip SoCs use all 32 pins of each gpio controller, meaning the
> pinctrl pin offset typically is aligned to 32.
> 
> However, for gpio0 on RK3288 only 24 pins are used meaning the pinctrl
> pin offset start at pin 24 for gpio1. Use DIV_ROUND_UP to get the 32 pin
> aligned bank num.
> 

I now see that someone had already opened the can of worms :)

> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
