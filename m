Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6D3C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 12:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB03681951;
	Wed, 19 Mar 2025 13:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Ry204Fm2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDDD081101; Wed, 19 Mar 2025 13:04:36 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F91281DCD
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 13:04:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVICpvfuJ3iQb86zT639BohBoZODTteiRxNgIyw5Irlv9bMIOHj8JCsDHXns2dgFhGZqoDNHb2YHO0PSbeIQVXGtsYV2NcfYW7HfijklBGYNgqPBF+sSIKdPSgDx8VXyrNJhPJB3Ef8l1a0sIhrCAs6n4Hh8MLBElhCz6IvzrmzNvyDRkBdZowRilYren/JBGqZQ2OkyziTXweLOLSvJtkckEh7T9cMkVwbzhm4dhRUc++6vWCQNEPDodlHmzwliktcGeRft8zaFTQgsEaqlbEIEphPQZDyYCEGNBszVGzWdoY/elBJVOYBpl3Vsf1fsv8bdswTRsKbcV81r9rWBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJoBqWAMCww2wGgmRaVEf49bm2xoWqq6qVHskTGw6pc=;
 b=GRQapSugxGCgXuSRz9D8Q8VBowTLw1+3jhAbLxFWB4bEX3VgQrg3XQ3fV73LykEWz3VPnCsuPzFYdThwiQNvmxy3+g6hqMijJ3jOzDyVJvAynIDjgN41TihGv2Nb7FG3menmRV/gElzQhrlp0dQawMpkvMd9YEVNYpt8ZMW2ydTpLgykKKIlbJvkTonGsNFBEDH72Q+9Jhew8sBuAUOQ3kCQOndSuV8V8m6AmwCcqPE6Y3pi4xPGt61NjOf4e5WnNx2/myrI5+K2H/6knVxkrKE7kbjRnlXOOsHWPFDhfQI30F9ql4u6WcKMGHgpejn5qsJmZslKPyos5DvsqQyseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJoBqWAMCww2wGgmRaVEf49bm2xoWqq6qVHskTGw6pc=;
 b=Ry204Fm2B1ElK3r9uRhHMyKYhtajqxfw0sZAhHKEJPGOPUoBvdr+UzhJXBJ3kNppwiL5yAhjAjX651sLtnWRANn4biAUkFeR2ytw1xzm/wfLcFrr+5biihJhKDvORtp33RBZQhXW9qGA1b4ShJQmLbIp0brKCXUAgOhVwPLYQfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB9555.eurprd04.prod.outlook.com (2603:10a6:10:303::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 12:04:31 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 12:04:30 +0000
Message-ID: <0bdf2e32-80f3-415f-a3b8-eecf5a4edd5f@cherry.de>
Date: Wed, 19 Mar 2025 13:04:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] log: Add helpers for calling log_msg_ret() et al
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20250319114947.2188805-1-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250319114947.2188805-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB9555:EE_
X-MS-Office365-Filtering-Correlation-Id: 8317261c-12fe-4b87-2161-08dd66de3458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTVXM0tHUTF3eXFFWW4waWpkOENURXh4WmVTN0ZSWlpqM3J6M2psYTRORlAw?=
 =?utf-8?B?a0hONGwvLzZ4UGN6VEY5M1ozdFlIekxnVzgxZ2dvYkI4UC94UmVxZE5pbUx0?=
 =?utf-8?B?Q3NiL0U5bDRucU1hejd6SEpVLzVWYnkwN0M4UlhsZEcyNWJzQkRnZkppT1hO?=
 =?utf-8?B?ZC9MRmdTa2R6M3NNb3YrcVdDYlBKM2UzV21oQlNWYkRUMmhYYnN1bTFUWDhJ?=
 =?utf-8?B?aFhzd3pQaURyL2N3a2RqTm85Q1NpbkZUNmR4T2FaYjlFLzdjSEk0MUNYcVdp?=
 =?utf-8?B?YVpOaXRWc0lCbjJ1bGxBdzBIcUZsaEwvSWY2WkdBSnNTZ2RCUmFHU0xNNG5T?=
 =?utf-8?B?WDVLMFlkNWExZlg2ZDViZHdUN3ZQdk1OVnNsK3hRN3lBN29VSUEzaHRMME8r?=
 =?utf-8?B?T0RWM3k1VVVrc3cveGVkYlB3NUt1UUJhNmNKRjdWeXVJSFZjTEkxejlFV1Bh?=
 =?utf-8?B?NWJLNmlCUjBNbjBtRGk1ODVUcWRibUZUZi9GZkdGQnd6NlRLejBxZ2VVemJz?=
 =?utf-8?B?RGxlS2FmUy9YUDlXNEtITGx0MFFOU2N0eDdaT3BvZG90ZkZxUUd0cUFLZjFp?=
 =?utf-8?B?RlBrQXBnQlVSYjNEaFd0WG9zMkx4RWxJN0RPMXU5NUlVUldsRExKWHpXM29i?=
 =?utf-8?B?d3I2bU1vR2taaCtUYSt4ZXVXTGpvMGM4d3M4aVdKK2ZhYmFwb1NOV3kzYjFG?=
 =?utf-8?B?aWQ4Z0k0a2FNUGFUQjg5Ny9uZTVDMmVCWTMyRVRFdEpCQ2dDelg1NW5oMG1w?=
 =?utf-8?B?U3JTMlU3ODNDK0RzeHdYT21oT1JvQlVOcFFSM0pOazhYWmx2RDQvNzFxcm5Z?=
 =?utf-8?B?c2R6QlczZjVNRjdPKzBSQVBHRldLU3k2Y29vOFlvREJTd2xNQndMQURhcWJG?=
 =?utf-8?B?TXZLZ1R0MUlBM2Eyc09NbVFMa2ZYQmdRcTBkRWxLenByd3QzdFR6eFJVMjNm?=
 =?utf-8?B?Q0EycHFVU09Eb2pRbXVEczg5WDRLQ21obGsxNGZlKzdITkYrTUxwQ0xmYjcv?=
 =?utf-8?B?R1RTNEQyMldvVUcxeFh6U3JGOUJrWU1UMFNyMVcxdTNaWGlITEtPeFFyT0Q3?=
 =?utf-8?B?bHo3VlhoUUVSTFFOZzY2aXE4eTZMTjU1RWJ1RHNuOFhwalVwdU5JZEVpWjVM?=
 =?utf-8?B?bTUzMlVTL05FcUZiNDBNZTdaUXVIUmYybFFSL0w3TE55RXdtemtkaWg5aXBQ?=
 =?utf-8?B?cE9BQ1VpT05ZUXlsbjAzVVFYTkhVa21jS2xPMWdMMk1FOTEreVU0NFlET2I4?=
 =?utf-8?B?STFpYk8xWUpTV2hPWVJQamlJVHIrQ0RGeE9mYXIxUXRwaEg1RjBIQTlSQ0Jl?=
 =?utf-8?B?TS9rU0t6OUQvdldWYUcyMWZid0QvSWxZeENkdXdtc21OSVFmODFCWVl0dFpn?=
 =?utf-8?B?YkVleXZFQWs1cng3d2dJQXFTWDZRdVU1WVd1UGV6Q202RTFvVy9hTGFmSTBj?=
 =?utf-8?B?QXN0T25aMEZSY0hYR0Y5c3hteHNYN1I3WmJqSmk4ZXV5L0FLR015ZTZRbDZI?=
 =?utf-8?B?bEF4UWQ0dndHTzRFNEFNSWR4M0VuYVFOeTJES2x0OURVWDU3ejZYdXc5NTlh?=
 =?utf-8?B?RC9abE94dEo5Z2NCZDAya2NXck9sTi9CbzkwR25ETFhwd1lkdkFOSXI3ankx?=
 =?utf-8?B?VGQ1Q3VweENDNEJWNE5kK2JHV21kK1N5dDVsS0drdHBrNFNRUGhwV2tTMDl0?=
 =?utf-8?B?T2RyaHV6NFpkNmdPcDlVYThKOGRRbldSWDBlQ0hrb2dCSFEvbTNJdGZ4dGNM?=
 =?utf-8?B?K0JHMnNmdlJXOXFscktKZTRKMEIyNExoTzh6SGZEZXFFNzlDUFh5Z2grcFd1?=
 =?utf-8?B?T0hXRGtkVjVxQ25iUXVxaks5d1dlUEIwb0owSDRITEJ5cUQraS9xYnNaU2w1?=
 =?utf-8?Q?c2pJMuabqWQt6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlBiS1FHakFPWGozV3JCYmFscVhSbjdJN2JFd0dqSGh5RUlVampCa3o1clBq?=
 =?utf-8?B?cE56SzFDemFZV29OY3NyQVAyR2JtSjhZakM2RDVwTWY0K0toUEEvS0VsaDVN?=
 =?utf-8?B?UHY5Sld5WmhsS2p1R21FOWpCMEZIUklGWHYrQ2YreUp0QXlYR0dOVlF1OGll?=
 =?utf-8?B?RWVNUGFHNGg2eEF4RG9IUEVuM3ZTck9tVXlibHdTZEtseU41ZXBMS0lXVno2?=
 =?utf-8?B?WlZGMlUrM0hIQ1poVGtYNGU3VU13MGJSZEtCdC9LUkxuMStSZkljRzJOS2xV?=
 =?utf-8?B?K3BKVlcvOFI1RDBiN01sRVZsUXZQKzJxd0NGQWpDamVPeWt0bWt6V0piWTBK?=
 =?utf-8?B?U096eS84Z2gyY0l6aTVNL2dnS1dGK3Mwd0thK2dhODVHSzAwTStFTVBUUldI?=
 =?utf-8?B?RWdObHBnTm1hR2VOMnRBWUV6VGV4TDVReTZIMmZtWWtSWVBBeFRDMk1CY3lW?=
 =?utf-8?B?allPY0lhclVwSk5MNVlwUDEvbFp5TjZPeXhjT21JSG94Zmh3eUp1cnl0TTh6?=
 =?utf-8?B?OTBjdHlzOHErNHRuNEVHUksxWWpwelJGK0hBZVhvbG50M2NUTmhvNkVXSE56?=
 =?utf-8?B?T24wR21NVDlabWJyblZyODd4dStTTCtsY0VIcDVJQVlPcGFvSU5PbGRIOTV1?=
 =?utf-8?B?ZUhoc1RLYUZYN1k4VlA5QzcxRHl0a2MzakZ2bitTQU9wZlJ3MWpUWkxYaUlV?=
 =?utf-8?B?Vk1xRUxCaWhZdFFCWk1HZ09NOHE4ZDMrMFd4NGlzVERnbTlINGRrVjJjOCtN?=
 =?utf-8?B?bFBqSlc2QnIrRFh3NEhLcTB4S1FpZEFHMCtXMUNvL1BtazNBNVV1b1A2aEZ1?=
 =?utf-8?B?R09CTm5CRUNDZEpBcVdkVHRSSjFVb0xuTzgxSkZTeE5sZDdkZVZhRWJ2M1U1?=
 =?utf-8?B?VzlhbWIvT0U1bVg3YTVBMW1HRjZsNWhHKzUwdmhhWDNDcmsrcGU4Ynh4dkZO?=
 =?utf-8?B?ZlpLRXBVZEJjMTBQTWRSNlhNNWNXVC9NUUcyR1MrZ0NHQ0RnTUFqaE81TFNx?=
 =?utf-8?B?RzRYMW1HOGMyTTQvMWZtQThRd3BDVkVxMWcyNVBVOENnQVEvbVpFd3UvRmdx?=
 =?utf-8?B?OU5sM2xXRHgwVjkrN040R2M3L3VnOGk1VHBjcDJQaHZnd3FoWGJWWkJqUDZM?=
 =?utf-8?B?RCtjR0ZWMmtZVUVQQ0d3RXBpUnk1dVpEeVh3LzhsaDgweWNpaFhaNkdmeTJk?=
 =?utf-8?B?N1lreGZ0eUx4ZkI4RkJ1RC9ScHFrZXRlTyt2dUNKL2ZyTmJUT3BqN2dvNGJN?=
 =?utf-8?B?cnJ6YXZTUVhoa2RUbzBXTDZPanNYeVhMWkEyczg4ekNhZkRBQnM0OHdRL3VW?=
 =?utf-8?B?SklLM0diRXYyQUcwa0h2Q21IOHEyaTVYdituM1pUa3dQN0tQaXdKNzh1SldF?=
 =?utf-8?B?WFNMMytSTGxNdVgxekpNM1ljZHltSXVHQkt5ZTVDZEZ0bWYrT1lKUDNLYnRl?=
 =?utf-8?B?NGJ1YTVTN0FuQk45RVRtZ082QXZiWW1hSlVjMys2M2RZbHIwbGo4L1VSa2o3?=
 =?utf-8?B?WnliOGdOdlNZMDMwenlvVjhkenVPWDJYNGt0azRUQVRDckM4T2FvQjNUVlRm?=
 =?utf-8?B?SmpObmxjV0xtUUxLOEZjZCt5b2VEaGFwNHNWMytzdkl5QlVzeHo0T1l0TEl0?=
 =?utf-8?B?TWVUT3ExUFVJNWpFTU9IWXdsa2VsTkVDenh2SHZMMnN5bVVrWE1FNkpFL0cx?=
 =?utf-8?B?NHh6SkpkTzEzbS9lUUdkRjlWeEt1K3Y0SG91K3A5WE9OU1lRL0IrTW95WkhD?=
 =?utf-8?B?NENGVFRaNGlkYWpFcVJSWUVEK2xqSi9ZTGUwcGZtMmJwMFFCSFFDMDBxMmM3?=
 =?utf-8?B?SmRPekZBWmlBdTNSWEJodWdoL0JvaVJSR3NQL3JYbUFvTlpUM2s1RjZmeFAx?=
 =?utf-8?B?LzhoNnVNRjNEbHEybnhWVW4wcmdSblcvL1FJNWIrREp6TjB3YVlIRTRGRDk0?=
 =?utf-8?B?SDVsczN1SkRTMW5OUWEvQWFOTzFmMlBIVW1EVVQrTzA1cVNvVWtwdkxVbms2?=
 =?utf-8?B?QXFCNE9WSDBzcFB0ZXRvbm85VmJXdGNyWnBxUW5xZ1hXZkxrVWd4aUVrZys4?=
 =?utf-8?B?UkZYNWpObEFlOFJiR1BScW9WaFdwZ045OUdacFBhMDdHeUs5bGdHeHJ5TnN2?=
 =?utf-8?B?SUJtOXVja2pwSHpmdjk5TDBXNTJDTG85VGlqV3ZlZEt4MEkrdXZ5aUZKaW5M?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8317261c-12fe-4b87-2161-08dd66de3458
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:04:30.9064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWfRKfRrISkEu+6GW25l4skVWeKmAywCdzZjwIu/Wf3mh5Is+tRFM/AaYX8t1wsN8yNUdvIgNtd/i8IXxWkO7fYdOz6c9Cv052XW704G41o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9555
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

Hi Simon,

On 3/19/25 12:49 PM, Simon Glass wrote:
> Logging of function return-values is used very frequently in U-Boot now.
> Add a few helper macros to make it less verbose to use.
> 
> It turns out that the log_ret() variants are not so useful, since it is
> not obviously where the error is coming from. So only the log_msg_ret()
> variants are worthy of these macros.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   include/log.h | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/include/log.h b/include/log.h
> index 4f6d6a2c2cf..bdda7af570c 100644
> --- a/include/log.h
> +++ b/include/log.h
> @@ -380,6 +380,32 @@ void __assert_fail(const char *assertion, const char *file, unsigned int line,
>   #define log_msg_retz(_msg, _ret) ((void)(_msg), _ret)
>   #endif
>   
> +/*
> + * LOGR() - helper macro for calling a function and logging error returns
> + *
> + * Logs if the function returns a negative value
> + *
> + * Usage:   LOGR("abc", my_function(...));
> + */
> +#define LOGR(_msg, _expr)	do {		\
> +	int _ret = _expr;			\
> +	if (_ret < 0)				\
> +		return log_msg_ret(_msg, _ret);	\
> +	} while (0)
> +
> +/*
> + * LOGZ() - helper macro for calling a function and logging error returns
> + *
> + * Logs if the function returns a non-zero value
> + *
> + * Usage:   LOGZ("abc", my_function(...));
> + */
> +#define LOGZ(_msg, _expr)	do {		\
> +	int _ret = _expr;			\
> +	if (_ret)				\
> +		return log_msg_retz(_msg, _ret);	\
> +	} while (0)
> +

Mmmm not sure this forced return call is a good idea, this would forbid 
us from performing some unwinding for example.

I don't really see how that is better than simply calling

return log_msg_retz("abc", my_function());

?

If we were to keep this, I would recommend to rename the macro and fix 
the docstring because it does not only log if the function returns a 
non-zero value. It does actually return.

So something like

LOGZ_AND_RETURN(_msg, _expr)

maybe?

Cheers,
Quentin
