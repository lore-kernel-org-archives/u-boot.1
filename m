Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C20C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 15:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 125D3801BE;
	Wed,  5 Feb 2025 16:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mjlEII0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4347A8033D; Wed,  5 Feb 2025 16:57:21 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F1B080104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 16:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZocunZ/tfCyUSd6QbMMMpb/oqqfU+wxYN/Qp7Ghj6bmBtbf1ZbXdVKTcYGzSP0HsoHaenHDXNlEXzdAkkK5O/Xh0BMb7UH/eS+N9TuowokiUuohjwy3e5hIBrVHbRmrrw9eQTkDaowlmRvQgzKf2ESfek8ysqw/2c181KVSBg+4q880kKttphU3XH/es2PqZjBpBOyUTsrjhIlBhMTPvcjcXkWD4KU8RrjMzV5bVnppNtZM5r8fvyx2uaJOBPd5IB2E0nxqUuHm+1jaVA9uFDudd7tOQpu62UN636CzvA/I0SJu5HV9DaBB/paDMAtrFC7Ee8cKpaUdC28rLtFK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYWAVteIgoE69dS+mLpT/XzOSuUY6h9VZEf51tf1g1I=;
 b=O6wN4X72OMuv6mmqrA8njTbvoh7Ncv8s7wSOBjXeHn9omlOgRNaeZaToTDbYS2ofh4JqB6ogmQ7U1VjGvwKBvPiR94Y8adBYQFwuX5KD1cV+jPLS4y37DmR6Q5TSsUaq0FrTql8ZJ6fxMTQspyMXlfuYj5QsEiHcEmMitRGrxx+UlwqSx1ellVmZKLQK0/6UWzKab7HA8QQnwDLQky5gttV7xWu6QvGFWPkrfqEOGhXE+WhzsyWrfN9ORYuX6xYkS6sXvlna/6jBz/TxuvbibuOt/YiaL+cjqNr4V8N+k89lKg8jo+oYsC06gce+CRKiGEv/jg3l+CRM2BWB0GrT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYWAVteIgoE69dS+mLpT/XzOSuUY6h9VZEf51tf1g1I=;
 b=mjlEII0eGjrb8HpkEQlCSiqqSJ4bnS+kDsXpeGHWValfW0WzvMWAE854h/UzdB9So4YnsQnnwjipNTDSzdsuFc42y4SyX8VG47fiK+wnt2yxJt67PIDfFqpPEbJbRCZUDgxAOog9/ufRCcDPoMlQYvSDn1k+4x3R5c7xubdiKOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB7909.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 15:57:16 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 15:57:16 +0000
Message-ID: <6827e64d-a7a5-4dfb-9a90-800aa1bd40be@cherry.de>
Date: Wed, 5 Feb 2025 16:57:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] rockchip: mkimage: Print image information for all
 embedded images
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250129223641.1888833-1-jonas@kwiboo.se>
 <20250129223641.1888833-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250129223641.1888833-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5fb725-2007-412f-c251-08dd45fdc314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODdvZzJqWHF1VnVUbGdmYkxJNU54ampkM0Y0V3QxVEltUEZBZDl3SnQ1eUNq?=
 =?utf-8?B?WHgwUUJkUTNsVGFIRXFQT1JvZU9JRTZVQmRWYUQwbWlQbTBqeW1zNjhvZEt2?=
 =?utf-8?B?SVY1a2VQTy9kMFlPTk1HZDVueXl2bFdHUCtoUFRnMWx5bkJmem5UQ251YTZq?=
 =?utf-8?B?Ny80R1VMaVZ2QUJLWWhkSkVqYkdyUUZ4ZnRERTdTMDltQ0dXQUhiTXlVWGcr?=
 =?utf-8?B?S1ZESm5qZCtpRG1iMnhmRFpXSC9KWElYcjFybmpWcHNiZ0szQkdEaHVzK0E3?=
 =?utf-8?B?T0RycVpCaSsxNVZpVmtZVEJTVmExeE1Yd044RUNLS0o3amo0WHZjZG9UQmdr?=
 =?utf-8?B?Y2NzV3hBdTR1dWovcUt0Sjl6WVA4MUNycWMvRXVuZEVUV0hCb1NkWWxLcjBt?=
 =?utf-8?B?VGtKZUdHNmV1cWE3cW9SSkNsaVBxbUZ3eUs5MGtlNzJxd2d2K3NDVWFkOTFk?=
 =?utf-8?B?Y29CMDdvTmJsN1VjWWg2K1gvMk50RVBGdnVvRWFlYkZJQkZMSlZYNG9uM0Rp?=
 =?utf-8?B?SEV4NVZZbWtmRE9yRVRFMDZZeW9OTVJZWlVSNC8wSUNSYjYzdFk5S29PVUV4?=
 =?utf-8?B?MnJxOW92dlVtN1AzRGxYMVVMWGEzdkxubXgyK2FUbXdwY0dZOFpsbGVrKzZa?=
 =?utf-8?B?SUpTcnJKc0NBNVdUdkJ4ckkyY2djdUpGV1AxN3o2RUs0ZTdzOFBaN0Vob2NS?=
 =?utf-8?B?bFVPdGloL29Ncy9HQ0xRalBrVXJkQ3p3a0VZV0R2bmRyMm1rc1lEZGIrcnlu?=
 =?utf-8?B?MnRvSmpFWDRlZGNoNURqMkVhbHBidkkrWkVJQU13eDBFL2xFdGFOdnhsSWww?=
 =?utf-8?B?UkdnaFZ5SDM4Z2FvNWZwTDUxVUdlRzZsU1lNeWJrY2hDSGMxQlBmZUJiNkdj?=
 =?utf-8?B?RHAxY0FDNkV5UUVPUzFWb0IrWmJpODhUZTV5MzJWSUN4THhzUllLSnVCZkts?=
 =?utf-8?B?VlRCa3IyTXNpYzZTTlBrUFBNRVhJZVo1dGozbGw5UWovVHFiZXVYZGVGQXY2?=
 =?utf-8?B?djdGKzVwNDRYanB1d0NwK210WVd5ekZ0ZWdEWFNINlBSM0ZZcEVzeHhCei93?=
 =?utf-8?B?L2EwOEUxeU9VUWpzVjdnRnN5YUtjZ3hEQ3NZemJOZS8veTQ5SGN3c1RXcHdj?=
 =?utf-8?B?REg3Q2RRcTR3OStweFIwbEhKQ0tkSGpDM0VBeGFGdWl6NVpkMlZ2MTJmUGtC?=
 =?utf-8?B?MmJWUW9CR05LRnFKalJPT3BwUWQ5UmJXMDhIeTZ4U0tHdkV3T2p3d3FVd1Bh?=
 =?utf-8?B?eEpjRHJlZVhaUnB4Ry9zNzN5cFB3akdZeGpJNW1qb09yM2lKVlhEaTFHQS9s?=
 =?utf-8?B?bXlLMDB0d0wyZ0lmTWVqSi9JUE5QanZIZElBMUFlclJibjRhaDRxUnZubGpX?=
 =?utf-8?B?bzdWMlAxdjZLNlRyb1diY3RNV0huakxpTUF0VjltK1dMa3BTN2pZVlI3Vm1Z?=
 =?utf-8?B?TlVTSVduS1N6TnRuUG11S1JHWm1HRC84R3hLT3BpbGc3bXdFSmpZeERrSHJw?=
 =?utf-8?B?RXh4dTJjNzFlbjVpQVdiVW5uTlRUbU5oVXBKKzJSRitWZ0FNSVJKUS9weFk4?=
 =?utf-8?B?MzBRZWFkZnU4Z2dIc0NWSC82QjNtdklaWktwbmo2by80blpSeFdsS21HaWVU?=
 =?utf-8?B?U0lFbDNkZ3hKbWxNNXp2U3dZV0JSR3hlcHVnTnl5dzZydHVhTXRPL1FRd1k2?=
 =?utf-8?B?Z01lc1EwaXA3bzRQTmlKU0FwSEJHMjUrcGFBUHdUWXBPV0VYdEVyWnArK1Zn?=
 =?utf-8?B?dE1POTFMdE1LeG94TUxYQ0FtdUxDc1o2OVdKeldxRmUwNU94Z0hmSTY5anVT?=
 =?utf-8?B?TjRCNERwM0xJUXhXR1U0L1p0YkYrQ2FpTFo3S2dLSFJBTExJeGg1SFBWVUJm?=
 =?utf-8?Q?9rjQbbxaJnIAW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzIwa21Ba3VBWFNEQmttVWZubWJMNkNVRDZtWjVJVjNNcVB0TGl6OXFRWnRi?=
 =?utf-8?B?YXIrUWFQRG9jNG5kSmUydFlEMjNDdU1xSGtNN3VGRXo4WEJJdThOaitCMm80?=
 =?utf-8?B?U1MvdExOV0tHREJwSWRER3NSL2ZyaEZWVmUvRUVacE9xZVhBK3V3b04wN0RI?=
 =?utf-8?B?OW1VK3JvL29EM0pOTUJrTStSVHl0LzJ6M2ZNODFZU1A3NHZOQWtkSlp0QTR6?=
 =?utf-8?B?SHpLa0FodFpvZGc5YUlML2JiQzQ0RVhFaTNGbVA2N2RkbU56eUdueTBwYWE0?=
 =?utf-8?B?a3NYVk05OWRqZzBqSlljd1BSMjR6ZWYvSmlRbDhzQnE3OHJPSjd1azYyZ29E?=
 =?utf-8?B?dlppVEJ4UkFsbXVtdC9hMWllSDQ2UjhranMzWkN2Q1JQMXJQOThWamhwQjhP?=
 =?utf-8?B?ZjEyUnFQNWRtc0RqdDdZT3pNdVJKd0dyeUFDanMwZitrM2drUElrdWZDVUNT?=
 =?utf-8?B?NGoyMWtWSVZhWTJHKzc0Q05qSDJOTDZaTkpiY29kakNjdG5NbXF6K0NROVBs?=
 =?utf-8?B?UDhtNE9RZFM4SzBVdHV6RmVxaC9HbUNKUy82YTU3ZGpucW9JemtyVHo1RmEr?=
 =?utf-8?B?dTFhNkxWNU9aMHlzaWtHK2pUUUlJSnk3R0kyL1I1ck51VGhUNi9sTVl5UUcr?=
 =?utf-8?B?MWxpYlE5MElZcm9RSVJxYXIyQjBTdjZYaUh2UDZlbS9XcCtDdmlEc0pXYnRJ?=
 =?utf-8?B?K24vRlVrOUVaZ2ZQTUlHSkNNNFpCajBWYjd2dkVHUE1kWjNJVnNHRGVNWEUv?=
 =?utf-8?B?ckZUYkVBdmpJSHAyek5ocE4rSW9TUC9pY2FzZkUwZFhwbzFlcnN3b1duQVl6?=
 =?utf-8?B?MEh0REJ4d0kxMUQ2dHhQNlhRdUJxVXo5YUpUcStORkZVMkxnQitGdnJpYXFM?=
 =?utf-8?B?c0JFZ2x3VUp4clpmUWFkSThDQUxpZW5VbWJpeC92dzBvRHVRZnRnMTN3OCtq?=
 =?utf-8?B?VDdFeEJYY0NTelV1bkRkYjd2UEN4SUl2NkhxM21XZ29CVkpHQWlCK29keXA4?=
 =?utf-8?B?ZERCaWYwaUNMaWE3Yy9FVVUzQk9WMWF1UTFta0R0LzFTV0lVMGFMaXY5WmRw?=
 =?utf-8?B?NG9IMW5MZWpoazFoeGt5Q0lCMmROWndxb1BKclFmRnlUajZRdUFTWVlENFJH?=
 =?utf-8?B?c1lXS3N1R0dqWm05ZExCSWtZVWNqeTBnZmtvcmcvK1JNY2NENUpkRkJ5VmhY?=
 =?utf-8?B?MHVkN2hhWVQzUFRUcmtseGNKSHkxYTJEaUNWbFR2d0h4UjVEZDF2bWFya3Z2?=
 =?utf-8?B?ZFYwUC9sN1RxT2RnYlRKRWZaampWVkV6bXhTMDd2TkRrWTdnd3hNRWxaVUhY?=
 =?utf-8?B?NXhZTGdjSVc2bDhtQ24wN01mWTBQRm5mUzRqb0pwUTBxR0cwZGZCZG5vbTRV?=
 =?utf-8?B?YlZYZndMZlhnYXpaWnNrREZGZDIweHl5RVRSNCtHc2FLbHZTQzkrVkZpeWtu?=
 =?utf-8?B?YTVHMktleERRN1pzbVd0ZW55NXEyRE1sRHNURjJGWFloY0loM3laZnF1WStn?=
 =?utf-8?B?QWsxUFNrSThmK0YrdHh6Y3U3K0xPREkyZWdXTHMxeHd2R1lHblJMOXJRak0w?=
 =?utf-8?B?VGJickxTaHQvQUxZUTlRTmM0cDQ3L25nRTFkcFRRM3pLdVJjUHMxYUpSYXEz?=
 =?utf-8?B?UTFZZk03cEFYVlZUd2lUNTg5b1FkekdHNjVyMlhzMDdEeVQvNXJ0OHRUaTVY?=
 =?utf-8?B?aldNUVZ4UDBSMS8rN2IwRDh4d3BhZWZmbGExVlgzc1pLNXZXaXJoMGU1ZnNa?=
 =?utf-8?B?bmlXMFNtS1pURmtoNE4zTThtNTFHVFJROGJHeXdXcUgydExZQzFGMkhzN0wx?=
 =?utf-8?B?WjZZT3dPOW50V29vbk10YS85aUUyZ2V1SVpHTHgzTmJVVE54aXB6NS9yTzQy?=
 =?utf-8?B?dGJxQkVrRkpPQzRTSWdFL3VNcEoxdWREemRBMlhiNVFrSHFJSzl6Rk5OT2lz?=
 =?utf-8?B?ZHh5ZEppYWpPOFNCTUtFTzF3bDZZWW1YZitva2k1bTlEMDg3OVl3TSswS1RG?=
 =?utf-8?B?SVRTeFBhMklWY3JRR0k5UnFHMEVzenVMcy9IdzFpRnp3YkVGTitKTms1YVNX?=
 =?utf-8?B?UW55L2lLOCswSjgyb0RjOUplY0FwbGRqdlY3VHlJVFJ4N2NQTlZXUDg3RWdV?=
 =?utf-8?B?dTRRWFNDMHRzamppOFNkSzBUQ0I2d2EzZzc4a2JXaURCMnJLOWV4OEJsc3lp?=
 =?utf-8?Q?Xc9Wlzp+IPzhaMAh6isyGw8=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5fb725-2007-412f-c251-08dd45fdc314
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:57:16.0365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxT/sHZrZfio6HbhYFVgmrk7MTC5TGQI9h8vZ0SpjR2RC6q0iz6MxXTrl998MJzfQD0Zp5TsPULJEG14c1/jOIlJT39R3m/fGU3pdUjGJFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7909
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

On 1/29/25 11:36 PM, Jonas Karlman wrote:
> The v2 image format can embed up to 4 data files compared to the two
> init and boot data files using the older image format.
> 
> Add support for displaying more of the image header information that
> exists in the v2 image format, e.g. image load address and flag.
> 
> Example for v2 image format:
> 
>    > tools/mkimage -l rk3576_idblock_v1.09.107.img
>    Rockchip Boot Image (v2)
>    Image 1: 4096 @ 0x1000
>    - Load address: 0x3ffc0000
>    Image 2: 77824 @ 0x2000
>    - Load address: 0x3ff81000
>    Image 3: 262144 @ 0x15000
> 
> Example for older image format:
> 
>    > tools/mkimage -l u-boot-rockchip.bin
>    Rockchip RK32 (SD/MMC) Boot Image
>    Init Data: 20480 @ 0x800
>    Boot Data: 112640 @ 0x5800
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   tools/rkcommon.c | 41 +++++++++++++++++++++++++++++++----------
>   1 file changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> index de3fd2d3f3c2..ad239917d2bd 100644
> --- a/tools/rkcommon.c
> +++ b/tools/rkcommon.c
> @@ -331,8 +331,6 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
>   	uint8_t *image_ptr = NULL;
>   	int i;
>   
> -	printf("Image Type:   Rockchip %s boot image\n",
> -		rkcommon_get_spl_hdr(params));

Not sure this change is related? It's also not replaced by anything if 
I'm not mistaken, hence why I'm wondering why it's in this patch.

>   	memset(buf, '\0', RK_INIT_OFFSET * RK_BLK_SIZE);
>   	hdr->magic = cpu_to_le32(RK_MAGIC_V2);
>   	hdr->boot_flag = cpu_to_le32(HASH_SHA256);
> @@ -486,6 +484,29 @@ int rkcommon_verify_header(unsigned char *buf, int size,
>   	return -ENOENT;
>   }
>   
> +static void rkcommon_print_header_v2(const struct header0_info_v2 *hdr)
> +{
> +	uint32_t val;
> +	int i;
> +
> +	printf("Rockchip Boot Image (v2)\n");
> +
> +	for (i = 0; i < le16_to_cpu(hdr->num_images); i++) {
> +		printf("Image %u: %u @ 0x%x\n",
> +		       le32_to_cpu(hdr->images[i].counter),
> +		       le16_to_cpu(hdr->images[i].size) * RK_BLK_SIZE,
> +		       le16_to_cpu(hdr->images[i].offset) * RK_BLK_SIZE);
> +
> +		val = le32_to_cpu(hdr->images[i].address);
> +		if (val != 0xFFFFFFFF)

Can you explain why this value is explicitly excluded? I know this is 
the 4GiB boundary but why does it matter?

> +			printf("- Load address: 0x%x\n", val);
> +
> +		val = le32_to_cpu(hdr->images[i].flag);
> +		if (val)
> +			printf("- Flag: 0x%x\n", val);

Matter of taste but the dashes were bothering me when parsing the output 
with my eyes, two spaces could work better. In any case, not a big deal 
to me.

> +	}
> +}
> +
>   void rkcommon_print_header(const void *buf, struct image_tool_params *params)
>   {
>   	struct header0_info header0;
> @@ -502,8 +523,7 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
>   			return;
>   		}
>   
> -		init_size = le16_to_cpu(header0_v2.images[0].size) * RK_BLK_SIZE;
> -		boot_size = le16_to_cpu(header0_v2.images[1].size) * RK_BLK_SIZE;
> +		rkcommon_print_header_v2(&header0_v2);
>   	} else {
>   		ret = rkcommon_parse_header(buf, &header0, &spl_info);
>   
> @@ -521,15 +541,16 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
>   		boot_size = le16_to_cpu(header0.init_boot_size) * RK_BLK_SIZE -
>   			    init_size;
>   
> -		printf("Image Type:   Rockchip %s (%s) boot image\n",
> -		       spl_info->spl_hdr,
> +		printf("Rockchip %s (%s) Boot Image\n", spl_info->spl_hdr,
>   		       (image_type == IH_TYPE_RKSD) ? "SD/MMC" : "SPI");

Please keep "Image Type:" this is what's used for other SoC vendors 
also, I assume some tooling could be parsing it.

Looking good otherwise,
Cheers,
Quentin
