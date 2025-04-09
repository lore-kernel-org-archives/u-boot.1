Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EE4C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 09:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A7128352F;
	Wed,  9 Apr 2025 11:39:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fUQvB/MG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F4A283531; Wed,  9 Apr 2025 11:39:40 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C3EF83061
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 11:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J32USHqxbK8Hzovpbdh90HriyHB944VFJwUf13vDfd32v0GEep0YGqCn0YbM4TVgUlLcfhKpTJVsfD5eHy1cr59pdkFxN1kouIxcyFSLh0tg+ah/f9ja7yeLj6pqAIfR39lfZDsLsZvM3e5fDmGYFvey6x6UxLk8yN1jkTVVarSgP1yT0JAo/ABKOFTtF2CZ/Bvr7Qkm7w5Cs1gzrMibQGfCm6AWLkkAqpdU8pGIDVsc1lGida2pDR0eWKSmB0BXfyiJtMEPq46Ar2jqN/wpkdQ1dGLtr2gka9TMxhMYn/Q42uHAR1UlHfX6ux6Umn3STDyoIuAz3qDEmSk7FB7xXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYrlLF/Y7LRsVyUIX77LXPx9W1JHhU31Y0IRJh0W4W4=;
 b=dvi8i75txuhmI3YCzs3UCo/3S/Van2O3iRkYfPhqjlpSe7tDd9WeQDmo0fpwZk+vvpdVRBiHDdxbVGgcIqtnhX6TAe8UDjKz0MYRW+vml0RUXNK7mMwW0mknbm3yhXhmEkXWbdilIC5osz1JDi7pnDGVpVvEWVuiIAdHOicNiO/UBuwdjuGjTDn5p86CgzMkks118r3AYU7F0uhEuLM0cn/vIecjlYub1aicNOQgXfg52zSploqReYXC48RzTGgA0v3TVhZ0rTFCZcldzyR1cb5biHo1IviFy1cMAFdy421B8YI5pg7EK0ojdeCl5JPLoUogLAtQSRa8ix+sgHi7Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYrlLF/Y7LRsVyUIX77LXPx9W1JHhU31Y0IRJh0W4W4=;
 b=fUQvB/MG1Y+fNPfPAIPYy6uxSbnUcRaLiHZ0hhCg5Uwr5BTd1SHkt7WUzQG781T9kGkxEnI3gVFodbIB82w73njIR9Hxmg17d8Aoc3BACooOqSGhM4MHpm0gY1hkCmVqUtiIaD7SPFauJHviyGczM1v4N9hrO62pjTiv5UsBJ5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10137.eurprd04.prod.outlook.com (2603:10a6:800:244::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 09:39:35 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 09:39:35 +0000
Message-ID: <d7bd61f0-40a5-4fde-9e47-529cbac28a94@cherry.de>
Date: Wed, 9 Apr 2025 11:39:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] rockchip: binman: Create a template for the FIT
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-5-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250329150626.2879942-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0035.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10137:EE_
X-MS-Office365-Filtering-Correlation-Id: cd226e5a-7ca3-4df5-c518-08dd774a702f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUgrdUpHZ2RNQmMyNmRZN2xhamJIRkV6L1l5V3M0NUFRUW5sVEhSbmg2VnFi?=
 =?utf-8?B?VkN1Y01Ranh4czdOUnVJaUg3NG5YRmI2alNBNHcrL1dOS1VMdVBGSHpHeDJM?=
 =?utf-8?B?KzVXUmZ4TzN4dGlydlZncVZDYW85Y1QyN2dyTnZVNFdxWGFyL2l2YjhGcVFp?=
 =?utf-8?B?cGhxWlR4a2swWkZYWEdFajk4ZHd5bzdYNUtubEhlYlJ6SEJiUkhEQTI0N2ts?=
 =?utf-8?B?RmdabXhDUXRWNFFqeWQvQktGWnJzeG1rcU5ENTdOcU91ZVQwbkl4dXQ0RmdP?=
 =?utf-8?B?WnM5NEcvUU1kb0UzMEdUVkJhdFg3M3BJV0NvWkRVWmlOYS8zM2hpUmVOR05l?=
 =?utf-8?B?TTIyRXZNTnpvMVVYcW9VRHBsREI0Mk5zSURXek1acldUUGxkeGMwbkx4dkpi?=
 =?utf-8?B?SXIzVVdZQ1ZlTFhEcDliM05XSXMwMERHUDZQRUoyTE5zRUlSQmVlWXVOd1lw?=
 =?utf-8?B?MVA2enFNdUhMQTYxS3p6bHY1RE1JWVRhOW1mQnErOUxOZGV0aFVabUxmakRq?=
 =?utf-8?B?U3JTK096WVY4aC9JYk42ZG43REl0U1VwRDFic0RDTUdHcU41bFZKMEwzN1dR?=
 =?utf-8?B?a3YxcWxqcXlIRnhQQ1pkZHZzbjlSZzRzQjBjd0J6MFdEQWt6V09NSStGWmhC?=
 =?utf-8?B?RnJDNlVSNERsb2gwVTBKVGM1alJXYWM0L0t5UWFoM0dLa1d2Ym4xSGFtQ3U5?=
 =?utf-8?B?U0NIV3JNVnN5cGJ2Sjhsc05Ea2wybnoxdU5TRWdjdmwvNkUrUDVISVVyODlW?=
 =?utf-8?B?Zjl3MWUzY3hqQlJmRmxLRFhHRVZLb1dqSmpCcEpxRmV5cFZMSkFvU3hnanAv?=
 =?utf-8?B?S3F4eWJLbHBya0IwM3VBWmh1Wk5wdmxDWFVWRGpTL2NWUU14WDh3cXIyVHcw?=
 =?utf-8?B?ZWVURjN5cE80NWg1ZGpPVkhKdnh3K1gwQWg4VVZCUy9NSWpkaGhFQlAyN0xL?=
 =?utf-8?B?Tm1tK3NWS0s4azZhYS9VTm9wNGpBWkdTY2Q2U0JPUVFham1VQXhHcEFxc1lJ?=
 =?utf-8?B?bXhzUFRwYUdVa0VCdTJsY1UzVlBEWmprMlZ1NFUzaUZZRExLZVdEeXlTYXBB?=
 =?utf-8?B?NzE4RjhtY0gwR3RHQ0YzUzZqMFdLMEtadVdLeUF6OURjUXAwR2lKSjRXL0V5?=
 =?utf-8?B?SDduTVVldVMvQ3ZXbnlPTENjWVN1Q1FrQmJWZEU3bUQvUVBaOGVTMUYzSzdE?=
 =?utf-8?B?dHJVSUJmQ2JuRXpNeGVOZ0tIVS9ZZloyVUZ3dWRieTQ3Mm52VGNCNjIzbWI3?=
 =?utf-8?B?RFdQWXZZK0V3MUFGU1RHZXVQejdsdElNVHFxdU4zdEFJelBmeDcwK20rZGNR?=
 =?utf-8?B?a2pJTG5OejVMYmdRcGFYbEN0WjBUc2IvdmJOSGxEMS8zS0pWMS9RV2J2Zldv?=
 =?utf-8?B?c2ZtTWJUaUM2NlBqMThiTmt1NzBkdHhBUThqbzZOT3RkN09vY2Q4dmFYNVhW?=
 =?utf-8?B?UlBtTG04SCtNWEVrM0xlSEJGSkgzNm1VUDZwOUlWWnd6SFRxZmM5bGdtOWNs?=
 =?utf-8?B?UmplUzZuVStxRG0xUGJNeGRBL1dYSTZEekpGVE1OcnY3NktoVmk5N21QUmhT?=
 =?utf-8?B?OWd2d1pSd09mK0NqTzdLek5OaWtkSGtjellZNGFjQjZKQzVFVE5sd0FiS0dr?=
 =?utf-8?B?ZnpYb0ovMHFINjJONURPMmxhT0JybVh5WmpzTktEdU8xSDJtYzd3R0h6bFVM?=
 =?utf-8?B?NmkrM0t2NjR6L3FwNWRUREVxYUZFdHBjRnNnSFQ1R284MGx2VC9YMTBlUERR?=
 =?utf-8?B?d09hc0tjSWVpZ3M5WHNVK0FnUWdHSjBzNEp1d1d2M2dFOW5rM3RScDJyZERw?=
 =?utf-8?B?UTBjcEhydFNFbElOdFZEV3l0Ym1qdTg1MmIyd0JOa3Nwb1owejk1cWoraVhz?=
 =?utf-8?Q?NtKgb0J8Zd6Rf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azJ1bUN2citTTHRIdWxsZ2JXSjQwK0pQdWZOWHNqdFNhenYxQzVGSFZwVTNZ?=
 =?utf-8?B?QXFuZEU5OVdPMGpwZ01uTThrT1RoQ0t4SDY5Z1dJOFNHZG94WVVkMEdiM2dL?=
 =?utf-8?B?eWdmdGVKcDhEWVJFUDRsOVpIMkkrb1IrQXhROUZJd095R2FQeGdnSTlNZWRN?=
 =?utf-8?B?am8ySkVoeVY1cmdsOE5rbkY4cHZhYzNaSUphQjdxVm0xVXZ0d0FJdzRaVWo4?=
 =?utf-8?B?OWhtWkxQUWxiVkVJdFRMOTZKZDFnN2RHZUJFa1A4bEN4V01Bd1h4R3dZL1Jh?=
 =?utf-8?B?Y3grRWFQMXdBbzJpcG5CL1h3YkNXblBhWlA0STFRSFhSaWpSMWVUUkhxckRx?=
 =?utf-8?B?MGIzUW91VWRJSXdYT0hLRGNFYjhSVkRneEFTRUs3NXdzUFlZU1JmOVF5Ky83?=
 =?utf-8?B?QkFMMVRrTS9vaVRjaW5ibzZST1hNZW1qOUswaU45ek5VOS82aXQ5WDl3aXAx?=
 =?utf-8?B?eDBYcTNkakJNM2drZTJ1VW1USjVFMW5TRVQ1QmIxVHFKM1FEeERnSVl1R09V?=
 =?utf-8?B?Z3I1dC9yZGV5bmZkZkQzMU9OeTI2ZDFFZ2cvUmhrcGVQVjhDd1p1WmdVeldr?=
 =?utf-8?B?bzVYUTB0M0dXVEVhRXBOWHRzUDRNNzJ1aCs4QTFSR1krbmJJbEh2RXgxWFU1?=
 =?utf-8?B?dUYvV2RURzkyb3VKYjZLb3JRKzgveDJBSUlyaUQrSEdiSmhDVTJnVnJlSXBr?=
 =?utf-8?B?SHZnY1NHSGs0bUcxTnBqM2huaHdQMFloVnBtd1dxZXR5amI5VW5vMVRCTkpp?=
 =?utf-8?B?cFFObGY0VTV1Y2RGQ0dkc3Y1OTJsWTZIT3QzL2djdFpncHN0SnRSem0rVWVi?=
 =?utf-8?B?anNiaVBNcGJ5NWxNUzdtNTdFeUd1dUNWUERSUlhOQ3RNNnVHMjh4NUlaZk83?=
 =?utf-8?B?ZWhiYnJXRnBNN3dsMFJpbE9Fd2p1SjlzbUpzS0pjNkJVVmlUZ0pkN2hPSHJZ?=
 =?utf-8?B?bkF1eXdnd09uMjhSeWFaRWR5YjJjMzZVdytwU3AvVzJYQVNlbEtwQkdpWmJG?=
 =?utf-8?B?V1IyeHhubGhONzZJclA1am4wekNtYTF1LzB2ZnVqVC9OK3dVeUI2WVhlMEVI?=
 =?utf-8?B?WmVrT1dtQzRHTlRoZXFlU1dxRFdyd1Y4M1RlMDcrdy81QXJmcnN0NmNuZXNZ?=
 =?utf-8?B?bWIyTnZYTkVpWTZyTkxwR0RwZERFM3ZncjFJN0g1Zng2bkJQWDNPYksvWlVW?=
 =?utf-8?B?dWYyeGRRNnVVYlVmQkpidnRFNFlka3BuSXQ5Ry9HSlhIOXoxRWNEd3c1eVR0?=
 =?utf-8?B?ak42eGQ1b2NmaFIwYXQ2a3JPbklmKzlkb3ROcHBrZ0VMTTlaNUMvTFdFRHNW?=
 =?utf-8?B?bnZRMFpzZ0o3bzdtcG9qRG1lL0RZQUZNRTgzbGd3b1laRDVUeFcxVE5VNml0?=
 =?utf-8?B?UjY5RjgwdkFYTC94eFhGVmU1V2l4c0ZTWUdzNjBlS0RaTjhhelA0ell2bGJL?=
 =?utf-8?B?WU80dExhY1NFSXkrdVk0Rnp5MHg0SzM1RldkV0tkU3hWa0JlVFlMOE5OK2hy?=
 =?utf-8?B?cHFHM1NwOG5JcHhGUVJyL2tNbFV4Y2Z5UE5sS1RzV1N0Y1lCYUdYN3hobVhi?=
 =?utf-8?B?ajNKQzd3UXBWbXdYTkVaMExYZjJmNEZQTGd0dUFSa0xNVTJ4emF0bkVETUpF?=
 =?utf-8?B?Y085eE1PQkJlWU9XQjltUkN4REJzaTVHbWRCdXI1YWYxZmFsZlRWUmFzRFJn?=
 =?utf-8?B?LzVtZG9OVXd1dVlHZjBtWmhqSHpoYlE5Z0pENXQ0bE5RbkJZTVlQd2hsZnFq?=
 =?utf-8?B?a3lqVU5CNUpQNHE0K0dmV2J1QTlOOHYrdHM2RkpYREUvS0R3dU4ra3I1WEI0?=
 =?utf-8?B?aXdMVmkzR0tjdm0yS1BVRUR6ZlVuM0w2MExTWXloSXJIbGVtVk5nYjZkVVcw?=
 =?utf-8?B?SWlLZi9MVUc3S3RvcGtNMXQ0bmdTYkdwQTlSNkFhSFhZTGtTV2FabXBZNUNz?=
 =?utf-8?B?T1VldGlOamI3V3BTQUVxSGJ5UzJCTTJpdzlPZU9TUU53UjRmODI2Mm1CUUg3?=
 =?utf-8?B?cVJJOUlNWmFBVWFFM3pSZGtSc1VLU1FLejk1RERnZ3d0SWJCSnUyMWV3Ylhj?=
 =?utf-8?B?OG5wc2FUdmg3Z1lnUU1BV0lMNkxEY292ZEJ1K2Z6ay9XbC9pUVZlT3ZkKzMz?=
 =?utf-8?B?OWlRNnorcDJhZEFiMzV5ZXFtWUNrZTdESzlKNWJUTERkeWgwcUhDV2h5UnF6?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cd226e5a-7ca3-4df5-c518-08dd774a702f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 09:39:35.1837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJjr+ddlYBu+6EH9YOz6GFRT9IaMdsCCqh7GUCHu9P3hWvqSO4ItnQDiGrRD/7FugAQDyeVUUWMqTLAwJE/4El+zqJGg6N5ShJ1q9LSZPO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10137
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

Hi Jonas, Simon,

On 3/29/25 4:06 PM, Jonas Karlman wrote:
[...]
> -#if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)
> +#ifdef HAS_FIT
>   		fit {
>   			type = "blob";
>   			filename = "u-boot.itb";

Use the template for the SPI here already instead of splitting it in a 
separate commit?

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

