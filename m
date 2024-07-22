Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3A3C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 13:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A86087D74;
	Mon, 22 Jul 2024 15:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="HgPd+G3v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 740498837D; Mon, 22 Jul 2024 15:11:42 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BAC287C86
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 15:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/Xy5GbdThPjeYayB0QxlqVewIHDLx5I3tlF35mbWTQscTU7Fv4nmBABaYrQkGg6AZuklyzmau0njXXwmQwnKO9z+1MH9AyZgPXIqTZgdNgsTG1Q/UeqT2Tf6E7GXzNI3kjyHdfpOZ/CktlmHSCRs5tKw52RyfxY1QufbDDzt/4fximW9i9HnOBj7ejCE4SR75Y973n3QdmiH6kR7fG1qVdYyaoZmDuxkN+cmxcRz8u6xa22zHLNsQa8m15v0O3BcWLIrTIrqQrndc5oEDwpkWxWqrsmZZNG6gEObyhSgLBX5atKbobIg9XmUJfkPOuyATogveFiDwUK91jilBptgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DLTrhr6J02PbZ2t/OwWkn0b19MgWsQZ9UNieLJ21XI=;
 b=PTlHl5lf2KGs7fxBwtdFQTKQtfzTL8Vc5Xn/nRvPqvOBllee/KUOicKINtGfsC2iY/pMzJKVySocvZLCH+wHhu8tX2LT6UDepinZZ+F652O5bv+cvSJtEDjq+ABV2UH583rQi3d8qnEU/O/LjHSK9dkLYZnX8j8I6pwY3l1H2O48d56R57LkEDcg57LY7F/fDjipD+sCyvxNbslEtORWd4o+c3FXJX4L1cxcgaj1pB9NAunTCvjf/ERjfmBRqXn9244htLv0ETVfFFYuGYUKJoYyPxtocqpnhD6X25OoI3+MPKSWqK8VyriccB93+tvpnl0coNLHBNhxQUD/dKX1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DLTrhr6J02PbZ2t/OwWkn0b19MgWsQZ9UNieLJ21XI=;
 b=HgPd+G3vyC9zEmGv2bmG7nmT8pY9iG3sqqxPcaQn3P/bhBUilohz1BgJiKwrvBvQffKWfi24QDYgCuuclYBJwJiDw1YUoLx8HvwGDnRC18WkKW9lFOKttSKOpAaHZSH63bw9y2JDn6KUm8Ow+UAhUO+ZEJqobC9xIoJKhliG3Ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AM7PR04MB6789.eurprd04.prod.outlook.com (2603:10a6:20b:107::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Mon, 22 Jul
 2024 13:11:36 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 13:11:35 +0000
Message-ID: <68cb1acb-fa61-4bdb-b109-2fad64726158@cherry.de>
Date: Mon, 22 Jul 2024 15:11:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] spl: Correct use of CMD_BOOTI and CMD_BOOTZ
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-3-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240721152600.3212917-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::8) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AM7PR04MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d2c908-a960-489c-41c5-08dcaa4fd069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LysvZWxiT3QrMk1uVjFON2I5L0ZUQ2pBeWQzZjhMQzJrNUNOcEFRc0dqMlUw?=
 =?utf-8?B?Z29FcmxnZFNScmNGWUdQb09NeThDbVdMamhJd1NtZUtzYU8zSHVJa0tVR1FE?=
 =?utf-8?B?cURRT20rRnF0aTdWM2JhbWpsL3hwZVpaMVcxWmtORW1kU0p4UWpEMDgvVFdH?=
 =?utf-8?B?amd1cEdCUnhBYnhaK3pobHlyK3Q4eTVDZ1F3UFo5cWNXKzN1MVhsVStYcEdV?=
 =?utf-8?B?UWlEWURtNDRtWTRXcHc5cDRKRjNJNXhpb0xuSFppOHkvczdQdjJmYU1yTlVH?=
 =?utf-8?B?OWJWTkZoRWtJR2pjVllndEYwTFlNU0htN04wZWJZSDdOdGdZMlVTRmdKVTFT?=
 =?utf-8?B?VmUyc1djeGppVHQzbVNUNHRxWENhT1R3bGZBOEt0TFN2eHU1QUZSL0NyMU1U?=
 =?utf-8?B?b3hva1NsRDRkajJkUEtOUFNkVU1aeWlCSUtGOXN5eGFxaG5CMHNVQnY4M1g4?=
 =?utf-8?B?U2IzYTdmQUlpL012NUlLOGRJQk50Yi9Cd3ZjTzh5aVh0RGIwTk8vd0pWbVpT?=
 =?utf-8?B?Y1poQXV6ZncrcGEzZlYwSmJRaFFHNXB5bkozVnR4dzBWZWVvcmp1Qi9wTjgz?=
 =?utf-8?B?S3d5TUhtdEVSdHRDTUhWVzlMZ2dxMkUvSnBhU3c4RU9DaW9ManlFUEthMDJB?=
 =?utf-8?B?WnpVdkkzMTd1UzZRbTM4dU9scUFSYXpwNUxoUkVpUXFjQUZhQll6VUVCUG5Y?=
 =?utf-8?B?Qy9ZaEswaXZRNHRTQWN4SmhneVp5bThhcklpQVFHVkpNSCtRZjYwekRiSkdV?=
 =?utf-8?B?ejRRbzRJMEVramp5VERUZWI0Q3lHNk1zOGdicDdLZHlEY2FpcUVUTGduQXdL?=
 =?utf-8?B?bzN3NVhnRFJBZk8ra0dMNHBiMGFaUzNzbkJITXd2Y3FGQWhVb1g5dGVvRVVa?=
 =?utf-8?B?Vzg3SWpoSmQ4R214WDR1SzI0QVZPczltUWl4d1NtbGF5a2p5bjZrSVdvOWJ2?=
 =?utf-8?B?ZVJwSjh5dklHc2xUQ1ZZRldHS0NUU2dXSzNHa2ZPb2dXQVJVODBLbm51a20y?=
 =?utf-8?B?REQrUkdtWUpmbXU3Y3JUR0RNUHVTTm5YTjJNWG43VkJyQWxwK25WWlBpUEhj?=
 =?utf-8?B?V0VzdWtFeGxrZFVXVFBFMXl0SXpVWGRxSzRjU05QMkZpNTFXMjdrZ0h2bEtm?=
 =?utf-8?B?Rk42dHVOWFcvc3ZTU0VQVHVxdVcwb3lpUG1HNmMvc1ZUYWxpS1REaithRzJt?=
 =?utf-8?B?T09UV1JjeXFlaDVHaStIWmxpamYrMzhBSVdOK1U3MEFoYUE3UjNkL0ZrdnlC?=
 =?utf-8?B?enFxOHlxdndHMFF6RC9iTjR0MUlxbk9wRS95blMyMHFvc0ZRZTBMSk9qWkpi?=
 =?utf-8?B?Ny83MmVETHlBc1pGV0hwcHhXQTUwZTlaYTZ0MDdHTnoyV2hXbXZFV2E4R0w3?=
 =?utf-8?B?THRyQmtsV1RnVTNoRmJ4dXJLSkcvT1ErSFZqbEF5akNRNyt0c3hzTzFSOFl3?=
 =?utf-8?B?M2VkUC85a2gvc1NnRmtsa3R3eG9zc2IvUXQvdDg0ZVpzQjNmYUFJZCtzMHJr?=
 =?utf-8?B?anhjdHpkMm1EVlYwbUxkOUhsTHl5KzhaMHpEM05TdTMzcG5QTTdrRnp6SjEv?=
 =?utf-8?B?cnRzT1hjeVFaYjZDTXdpL2w1NG9uVmZORGZXQ1dBNDNOMjZGazlaMmhXUW5s?=
 =?utf-8?B?ZjlVWlpnRUJEaUVCUnE1VDZJcUZCNVNCNXZ3eDdLaTlYb0hOOWhJZkNrbEgr?=
 =?utf-8?B?V295N29wRkNrUWNPWHlKeUhCZmVkNFpMR09uOXA2MXNOei9Oa2xBUTdlcU9H?=
 =?utf-8?B?bTdYdUZqaDhjemdidGszYSs3eGpQVFJyVGF6VTdYUmZNVzJTSTkwTi9YdWRi?=
 =?utf-8?B?WGI1WU1UTUVjdE9PM0I5Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3ovSy9xbWVpUE1FZ2ZPY1VFZnR3TlRjRFF0V09aS0NreVVsOVR6SnhlZEdM?=
 =?utf-8?B?NGd1Ync4d0ZCanE3T2pIWHUvYVdoVzh3SUhqMXJlWXFkRDdseTV3TmxPNXdr?=
 =?utf-8?B?S216STl0anJGbVkyT2tHS0Z0b0hsQUVMRjM3b3cwV3dGc2NXWHE5NDdwUGdP?=
 =?utf-8?B?Lyt3UzRKNVN1b1JPMTRDL05iQjR6cmJ4NVEzcUk4dk56TjlxR1pKSjRndWt0?=
 =?utf-8?B?cGtNT01iSS93UzUxVlNBWlFzZkNxSS9tUS94WGZBdVVGcE9GU1FhQTZMMk0x?=
 =?utf-8?B?TkdzZ0UyNEhiUFJLbG82WnU2MkIrODFWV2l2dUtWTUR6UVFQL1J4clcxeFVE?=
 =?utf-8?B?TW04QXlsRkpvSHBISXZaT2U5Q0VHc25ZaVBHQmMreGtjaG9QaHl4dW9Cell2?=
 =?utf-8?B?YksyMTBHL1V0WGYxN2IzS1ZBNDl3NXoxS2VXY1N1U1Ezb2p2SGFhSTdMLzZl?=
 =?utf-8?B?eFZYWTVQWFczVmJHZVNwakdjdVNHOUJ6VndsWSsvbTNYbTMvcVYzaHFpT3Fm?=
 =?utf-8?B?NzJIUWYzWTlFWmlPR1doZ0ZnSlJPV2h5Y3BWajZLcE4zY1NtUy9WTzZlelp0?=
 =?utf-8?B?ZDVSQjB2Z0JtZzYzS2NQeXB4VUtnQWphNURMNEpiTEd1UFo3VlRERTlDSUdt?=
 =?utf-8?B?Zm1LdFNmVm5EVzdFcjI0NlNUZE5qVXBvOTk4TWNsZXRUdnlwNGdWZmNSYjBu?=
 =?utf-8?B?TGV4L3JITjFSbm9yNm0vRnk0Q05RaTE4WXRRZWVxNlVJZ3Q3VkdRRjR0WVJU?=
 =?utf-8?B?TnRJYXkyc21ZVklJeWVMbGNrVW8yOG9QVVlIR1lNNExpeDUyS2dzZk15dEE0?=
 =?utf-8?B?M1IxQlRlTE1ZRG9pMVZqNk1YQUxWYjN6eEdockFTUGhzclBUcy9KRDZITG5q?=
 =?utf-8?B?bTM2T3NJYWxxdHJiRU5WM3lxcTZMaVRPYXI3MldZZE82dmsrMEl0RW5BNXg2?=
 =?utf-8?B?U1RVVUp4VndjZDNxejJ0UVdYdEczajlwSDN3UUZabkUzcGJZRzUwN0YvVG54?=
 =?utf-8?B?WUpmTndCWXhhOExsN01kN05yR09aMUNTR3ZydXhBUERLSW1WbTk1UFBJUWty?=
 =?utf-8?B?MUIzQnFiWmxpbUIzaStKYngrNTQ4R25pTjc0WDFtSE1tdzd0Y3NlaVJkSjVH?=
 =?utf-8?B?WGliV0pvbHJDemduMkFNdWxkZHF2VDIzTFVHUjBxb1Z0OXJMVVF2Q09rTVBB?=
 =?utf-8?B?K3QxWEdVWTI3ZVhKWkJsMHVJQlQ0RHJZeEthcTFLdFZOOWRCbklhOFIvaGJE?=
 =?utf-8?B?b3hicS9ESHkyY2lQeU4rVVRUaWhrOHFxM0lNM1JnSEc0UnRpTDN1b3Z6S3Zs?=
 =?utf-8?B?WC84SlFQQlllVVNjQ3Q5NzdrdHdwU0diMWRKQ2REUWhWa25sV2RiSHFnS1VU?=
 =?utf-8?B?SElOdHp0R2pQL0dRUW5pdElyRUJGTjE1K20vbFVZNk13alpWV2lCUjlBekFQ?=
 =?utf-8?B?YXhPdzI4ZDJUdTY3bVJvWHpDMno4cVcwRzVMQy93VnlyU2crTm5BZm43dFBE?=
 =?utf-8?B?WWJqd0RPd0RhVmVvVy85NkVXQlVtVnVLYTRLQXZtOXY1bzBXV1RXYjY1MVQv?=
 =?utf-8?B?a3ZCQ08yazZ5cmlLQ1UvWi9EM2k4Wjk1VFA1RzVENE1WS0JwaUdsUEZBWFJX?=
 =?utf-8?B?R2dEdXk0dFBvNHB0cHlYNjZJNzRsbkpieUpBWitxUHFZMTRXTk1jQkF4R1kv?=
 =?utf-8?B?UVIwRTUvdFZyWXBxV212N3YrMEJJdnFYSDBLOXZzc3NTZVo2bUE2M2x6K010?=
 =?utf-8?B?S1MvNEoxUElzVHh3enNpL3k2a1VGNFMrRzAvNE8zZEg4UFhPMnhod21tZ3lN?=
 =?utf-8?B?TEZYd2lwUmVvQmJwZm5vWGl5TnAxaUJxQXdBRjZ3bEM3VUkrMHVqRUE2OTBJ?=
 =?utf-8?B?QjIrdVQra0xvd254YWVpc2hya3daQTQvQjdLQVQxQzNzejhUdFFqK2pXYldV?=
 =?utf-8?B?VDRDVnhlcnFkS3ZiWG5tMUVIc0hvQTE1T3JUYlc4dHJuTFl0cGhPS0h2aXVl?=
 =?utf-8?B?VWpYa3F3dlRIejBCa0hIN29reUNBdDVtKzBWSnJQbC9VeEgwWmRlTXc4dWhB?=
 =?utf-8?B?Y2l4ckhCWDBXMlBHUk53eXRybUI5WWtSVzBmOVJYQWovbTlxT0J1TVZkZTht?=
 =?utf-8?B?MmJnaFhZVm9ORXlBZ2gzUGV0ZDM3UkpVYUpzSVNjM2tvKzBNQ3BXWHd4WFFJ?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d2c908-a960-489c-41c5-08dcaa4fd069
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 13:11:35.6503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtsR7zJ9CoKLlwgs2RlqpQJQRrfPYJxneVi2bY3I9+DLETb222r9ZJmGnmuZVUUKGWH2kyccO3bhrUWb+C/7P/BM6fHofZtwIgZqJvL9f/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6789
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

On 7/21/24 5:25 PM, Simon Glass wrote:
> These should have a CONFIG_ prefix. Add it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 7a0d88076b9 ("Add in the ability to load and boot an uncompr...")
> Reviewed-by: Sean Anderson <seanga2@gmail.com>
> ---
> 
> (no changes since v1)
> 
>   common/spl/spl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 7794ddccade..6f4a8bfb3f4 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -322,7 +322,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
>   #endif
>   
>   #if CONFIG_IS_ENABLED(OS_BOOT)
> -#if defined(CMD_BOOTI)
> +#if defined(CONFIG_CMD_BOOTI)

Maybe use IS_ENABLED(CMD_BOOTI) instead?

>   		ulong start, size;
>   
>   		if (!booti_setup((ulong)header, &start, &size, 0)) {
> @@ -336,7 +336,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
>   			      spl_image->load_addr, spl_image->size);
>   			return 0;
>   		}
> -#elif defined(CMD_BOOTZ)
> +#elif defined(CONFIG_CMD_BOOTZ)

Ditto?

In any case,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Though.... i'm wondering why we are checking for CMD_BOOTI in SPL in the 
first place?

Cheers,
Quentin

>   		ulong start, end;
>   
>   		if (!bootz_setup((ulong)header, &start, &end)) {
