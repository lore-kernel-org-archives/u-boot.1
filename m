Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08D8C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 10:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51F978827D;
	Thu,  1 Aug 2024 12:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dhu1KIQ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5247788AF9; Thu,  1 Aug 2024 12:32:53 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB65388210
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 12:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrTKHxkpG7rkqEmPZCvv7rHcxt8Odxjh7v3iJ7UtAgmYIjzUpg7pbhc/cUIscoHGCHhwl3/RTxS9DE917W+WJWC5b6z+asLvbHDFfkZvdekInQxv7SgDWbrFVC8e7w6rPEpwASlqyO+tzU31kP9sKcOoNDX5WIM9qLa4K/+4fcY2ccwJngfYOgK6LiyvbXwgDFaemC2bYynAGWvwIUJVAxQGNHm9D1iyJIgO1ZltcK7k6d2yo86U378vvUQ6wDpB1faFlI3XrGEKLpIbGaQxm20de8YPbj2mm9Lq1E9A4gEPT/CL029L5lqh007e/el94vETjmJAd8NLr7quujg2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usIed+Mu5kYtRmKAapZ2QhQXgjnhoZB8CsXlDBjE10o=;
 b=JNokZ9LdBbdm0tyUI9ZLIxB+aXkTJ8tWLy7Vy3ASMiwjYCX+KDnZ06dCt33tMzwDpcIZwu0kXXIRx5mW0OuNjiTS/PnWsb4ORLXvIj4iFxP7aCrTch4/XcHzqBKlEzvExzr2FWZiw/t8CXzrEfG8ulHkSg5w/XuaT22nWEB1wfkS+Qb3IvSwI+QC3QRKiSi9prpM6ETJxt7PAbMzx/b/e/QjuDJEHvUja1CUXng7j4laGgaa29SvJALMeeMby0ZRjNPNUeLMHZrBDrf8XinfvyLefQmErLkelQPxJUW/98EcvJfk1l1VRMiPPQapuZXn6v+TM+UKiFnHn6EDEOVKaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usIed+Mu5kYtRmKAapZ2QhQXgjnhoZB8CsXlDBjE10o=;
 b=dhu1KIQ34/fwlj6xsls1ES7i8Upb0TiGzqYVK2ZyQZM+GdfY4tfUZcU4nY79uEt78QRw3zmPeDBHTpkE0gx9I0SwpT4SXR4bgJgS7GuDD6vS9VJl1QlR+g8qZmoeIIkfZ/d0vp1nIlDB7GjBgvODD7Mk3lILgTQpzvXD0g6ybLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 10:32:48 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 10:32:48 +0000
Message-ID: <7401bb14-a5d6-4c5f-98a9-e869373e4aa9@amd.com>
Date: Thu, 1 Aug 2024 12:32:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: mux: Fix error path in i2c-arb-gpio
To: hs@denx.de, u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>
References: <b526d573c09b940d7bb234f3e96c47753844c949.1722499288.git.michal.simek@amd.com>
 <9cbf52df-2ab6-2445-fb6a-7105c583da98@denx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <9cbf52df-2ab6-2445-fb6a-7105c583da98@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0030.eurprd03.prod.outlook.com
 (2603:10a6:803:118::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: 361fc80d-b1de-4f2d-41bd-08dcb21549bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXZ1R3RaZEt1dEJmVUdOZkg4ZGdmUG84WVJ1QlM5WmxRK0dFUWhmajcvOTFy?=
 =?utf-8?B?QmdYdjhKV0xEL0YxMEdwMnJDdFpZcHJGR3J1Rm00Qy9IYVpnSGVDZlo5UHRo?=
 =?utf-8?B?MmtWaCtYOWxudHBHY01GOG05QWFLZmU2dXREb0VZOWJ6WngzWU9IU3hEQVNm?=
 =?utf-8?B?QVFGdHZxTzF2NUJPOUlZMVJFTmJCRExyY25rUk04cERHUldJS2hDbjRzSy85?=
 =?utf-8?B?VklrdGFZaHczT3Bpa1ovQm54YzFVbGlQQnlaVDNKb2hWajk5cW9uZWxPTDhX?=
 =?utf-8?B?Vmlyd2h3ZXVtTWJpZm1yOEVvOTAweUFOSXBTdGhsUXowRVE1QUMrUHdjaXZm?=
 =?utf-8?B?eXlmNXczaC9DTVNxY250Uk51UHRRakZjTmQvUjRZTFJ3MUNzTG9IeFZxa0k2?=
 =?utf-8?B?YWRiQ3d4RUdtQlVSZnJwaUg5clRrMjgxMVJUOVVoUGdJZEFzTTAzZzliSjJF?=
 =?utf-8?B?YkhOb1ZuQmdwOXA3NzcyMGZaMG1EZ0xPN3V0a3FDeU5qK041dDZqUkkrNzVL?=
 =?utf-8?B?bjFjM09LRnJLalg3eFVDejhsdFpFaXZETmM1ZHcyVzI1UlFFOE5Kd0FzN01L?=
 =?utf-8?B?azkzQUlvSVlZQXVsRDZ1U3YwdlhjUVBYWno1Y3c1MTVFS1JFdXdvdC9HandT?=
 =?utf-8?B?WDV2NUVReFhxc1NPU3Yzay9kRG1IYUd6UmY1N2FsVkszRzg2MFlnanRHTkl2?=
 =?utf-8?B?bTZYa3FqZWcvVFZWYzBkTmxRdWVpekZqcDF2OFk2NlUrV3hTMXBIV21pREhi?=
 =?utf-8?B?aEh1b1NTOU4wekR0MDYzckJKdVdBN0UyRGtrbHBQT3VqTkRLWEhLMWlOUjZW?=
 =?utf-8?B?QTQ0SE9GNDdjTEFpMEs4azA4ajhFdTcrUlc1NENyM0xYc0QyREVtTm9CZnYr?=
 =?utf-8?B?M3pZVFoxeDZudUxMUlk2U0t3RHkxMnZyRkk0N1lvUmJpMGQ5dXVVZWZEK1hR?=
 =?utf-8?B?RCtza3lqL1hpNkZudStsWmQzT3FJQjFBZmdVNzlpbkI5d3FvaG9mK2o0OW82?=
 =?utf-8?B?ZHgvYjVxQjNrdU1CQm4zbk41UUtrN1k4aERmM3RHcHJoeWlMWDloZjl6Vi9Z?=
 =?utf-8?B?d3IzekpUN0pSU094eWJlVFlKNUFhbW01VzA1TWJqanhsbG1nS2xkUFJZSG1p?=
 =?utf-8?B?TlM3Q2YrS3JHSlFCTmRxbEhxeWQrMHg3NG1JbzE4eEhQaXdvL251eEFTdlpT?=
 =?utf-8?B?WmVpSGx3SHBRYVVyNENrNHp1RHcyTVVVbTdVdzVuUldrVUFQZFpxbnh3Rkl2?=
 =?utf-8?B?QXV1YXQwUFZ5QjQwNlhnYmczR1BPQWhoUU8zaCtQeXd6Y1JhNUVYd2MyWFhu?=
 =?utf-8?B?cmpnQWQ5MUtYYzAvMEFJNVlUTDhZRTJwemNQcm9IMk1oYUhhWDdtb3crQkY4?=
 =?utf-8?B?Tml1NG5xQVI3Qld4RXgxWXNhNnU3WGJqYkFMVlhjdy9QSXUwa2VVN0thaFdi?=
 =?utf-8?B?VFpaUEt6UXNLNGFETDZnOVlqQmxFZWtsZXRka3Q0VTRSbTF2bVNQczhjeDEz?=
 =?utf-8?B?OVV4S3ZrcXExaFJuZjdjY3RhWVhlb0RTbjNGRnYrTVU5Q29scVZQc1F6NXhj?=
 =?utf-8?B?TzRGbWtuRzM1cFBpb0NVMUVmUDZRNHNqWlNGWFFrSThDQ0lVSFRQZVhCQWNF?=
 =?utf-8?B?WXpGeWc1d09RTTY5TFM1eExtaDEzSThRWWRUZmVBcFo2WWl2RXlTVmJqays1?=
 =?utf-8?B?bnpISHRXVklGd2JxeVNjL2xmM0hvajlqdlB1MDVTMklhRjUwaFJxeFZYZ1J3?=
 =?utf-8?B?QlFoQUpNV1JCQzY1bitlMGFnYlJrUEpNNEI0d1NiZjRjU2sxS29DZTJOajRz?=
 =?utf-8?B?eVExM0tIa3dOVE45bmtvQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFE3a2hDQlNpeVJKczllT3ZOK3FwdUw2ZElScXBxZTc0aVUyT0RtTTl4bU9S?=
 =?utf-8?B?OUJDY3RRTFVhWFpkQ0JBaEtDbTdYdDM5dHN1cGNyWlFPdW85UUZMeGp0bThT?=
 =?utf-8?B?Q01XejYvejhuYXQ1MWY5WmwyTGhocWlldDRFY05HdGFJN1JtQUl0Y1BIUUha?=
 =?utf-8?B?dk1UaDNZRGNGcEtSY2E1dXpFYnYydjhWMzBleXQvSjY4cDg1NUxhOGhzUCt0?=
 =?utf-8?B?Tld6RC9MSjNsZnFFVTFSbFBiQ2dxTmlNTmQ2N1J4RzgyQ0YrZ25jbFVZQWhU?=
 =?utf-8?B?OUVnRW9JKzVhUlp4U3V6OVA0VHNxeTRVd0s2UG9SN2dlZVZWTFQwb3IzVGI0?=
 =?utf-8?B?NHJsWFhpc1pxaVA4NE8rYk1WWnByS09oZmxzMGZZTC9rMU5hekNGYXFvV0pl?=
 =?utf-8?B?Q2VXK3JHdHRQc05TZjFQUmIwVlNVVkNkcURsWFBESW5WeTYzZnZobFJrSjlT?=
 =?utf-8?B?OGNNRG1xRlFWemdjL1UzNzIvdzNxbmhpN2VhMWtIQXF2aUhKOU9qR29KYVd5?=
 =?utf-8?B?WDQ0V2s4U0p6WXNPVkVHZVdDOHRzTENrUWlaNkE2TUVzS1pvU1RoL3ZiTFpi?=
 =?utf-8?B?MTRBWGVvclZFbkRPR0dCSkp5Q3FTdVVTRkxJaGUya1VvKzV5Zjd3QWd4SGtj?=
 =?utf-8?B?UC9vS0pycmMwU0dWUFU5ZzkyV3NzMWJuQUFOdGxYbWN5SWJpNXM4WmFBSWJ2?=
 =?utf-8?B?eVZMYmpyeEh1THoxeXhEVG9MREluaC85N2FmeStEQ1RENkZPdVlqZmhZaGhM?=
 =?utf-8?B?Mk9hdzhnTy9lWjd1NkVvc283LzFGU2dmcGFQRnptWTVuejNZTm05c3FEa09W?=
 =?utf-8?B?YUFaZGNVZHd0WGZMNUNQM1lnMkQzdmJia01ZMlFDdCt3cDZpcVRSdGw2MHJD?=
 =?utf-8?B?VmdaWGF5Q2ZqQ3NhSmJPcWNySlN2eFYwaG5hdVh4RGVDSWkxRGs4Rm9GWGZ3?=
 =?utf-8?B?V1hxa280L2kvRmw2SFZZMTNBL0xsYWU5WHdoUk5iL2lXWDZJWm0wV0l6Y01u?=
 =?utf-8?B?SmlneEw3ZEdqUFc2RmhpY2ZZc1IrR09STzFiQ2hyLzhHeXlsYlVydGtHT0xG?=
 =?utf-8?B?ZkFvd0R4RkVIV2ozRllDangzOXBZcUpUUFphenR0RDJtaEJJSFhHaWs5NlU1?=
 =?utf-8?B?SU95cWlBZG1rRHZzUHhOaEpoTzlIWTJWRjAyME03Sndta3hHcVc4TldFSE9W?=
 =?utf-8?B?NzJaUElYS3J5WnlmaGtjb3JPamhCT3ZHWU1HOHJvVUtPWjJmaEFDUzdoL1o1?=
 =?utf-8?B?eVA0aWVnNDFvNU9Ec3kybnUvYUMybHZ2YVNidmpVczd5ODlmYlZqNkRqd0Jz?=
 =?utf-8?B?UDh4dWZLQ3BKeW9ncGQrUkxWUnZSV2Rjb216TGdNZFFtR3lsQTExRjMzZytT?=
 =?utf-8?B?RDRYOEF5b3U2eVBlWGpZdXFpT0VranQ2NnFFbEdHdElyZExka3VuWWJFcjVl?=
 =?utf-8?B?bmNQRCs3dDQ5RWxINngvNTIzMDI5VEh0VmJIZzg4VHdxYzM5SC9uNVc4c08y?=
 =?utf-8?B?Rm4rVnFEczNJVm9STjg1K2llZ1R6elBhK0h5cEtaMGk4T25LS3NzMnRueS9X?=
 =?utf-8?B?Q3JqbTM2NXc4TSt1N1M0cFNLNWhqY0pjK3FwTXU5OTVvWjdnakNkNWNZdW93?=
 =?utf-8?B?ZWNYTWJhTzA3ZjU3aUk2SkVFV3F1RVo3U293WFlmWnZ1QlRjM3VhZjA4cy83?=
 =?utf-8?B?YllrS01EWDRoWVZnc05IZ0RKSTRHQTFOVFcyUkZoOElmLytFYzZrMlhhOXc0?=
 =?utf-8?B?VjVhbEVzRlNQWUpCekVySWxWMXZ6YVVGQTBlVklLUDFzUWNvWFFwaE9CZHYz?=
 =?utf-8?B?Y0MrUm1JOVR4cHEyeTIzSWpjRXJjTmlFWFpvK3lSbHBYMmhkWXJPMGlLem0r?=
 =?utf-8?B?dUxXWU5aYXJWeDVvS3Y0RzdScWlraEhZUzdZb00vcmxNbmVaOFhFNXdyY1VF?=
 =?utf-8?B?cmxWd0RleEc2TGFZS0x0cjUrOUUxWEI1V041SHZsZEVGdm0rSjBFQlhRcmln?=
 =?utf-8?B?RkZxUzhyMTBGcm85MDJBamFTa3lWSUQ0VkcvYm1RSG9xczVjUi9pWDk4b1dk?=
 =?utf-8?B?NzliVjQ0VnV0S2tjUUoyRnd2czhMTzZVNm1vWkxaUDhpcHhsT1NpcXVqcHlX?=
 =?utf-8?Q?sssGk9M/cXd3X3n3A18xptU5N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361fc80d-b1de-4f2d-41bd-08dcb21549bb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 10:32:48.1399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rk4t8ao0QE/fQUS77W6FvJ9A83SCA6I2v4H4JyiKFlFhQMhpMbYQIgd0+X3vnOl9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
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



On 8/1/24 12:27, Heiko Schocher wrote:
> Hello Michal,
> 
> On 01.08.24 10:01, Michal Simek wrote:
>> There is no reason to use goto and just call return. Better is to call
>> return directly which is done for some if/else parts.
>>
>> Also make no sense to setup ret to -ETIMEDOUT and then to 0.
>> Return timeout directly.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   drivers/i2c/muxes/i2c-arb-gpio-challenge.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c 
>> b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
>> index a83d7cb0829d..3d2ce0ca705d 100644
>> --- a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
>> +++ b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
>> @@ -54,7 +54,7 @@ int i2c_arbitrator_select(struct udevice *mux, struct 
>> udevice *bus,
>>           /* Indicate that we want to claim the bus */
>>           ret = dm_gpio_set_value(&priv->ap_claim, 1);
>>           if (ret)
>> -            goto err;
>> +            return ret;
>>           udelay(priv->slew_delay_us);
>>           /* Wait for the EC to release it */
>> @@ -62,7 +62,7 @@ int i2c_arbitrator_select(struct udevice *mux, struct 
>> udevice *bus,
>>           while (get_timer(start_retry) < priv->wait_retry_ms) {
>>               ret = dm_gpio_get_value(&priv->ec_claim);
>>               if (ret < 0) {
>> -                goto err;
>> +                return ret;
>>               } else if (!ret) {
>>                   /* We got it, so return */
>>                   return 0;
>> @@ -75,17 +75,14 @@ int i2c_arbitrator_select(struct udevice *mux, struct 
>> udevice *bus,
>>           /* It didn't release, so give up, wait, and try again */
>>           ret = dm_gpio_set_value(&priv->ap_claim, 0);
>>           if (ret)
>> -            goto err;
>> +            return ret;
>>           mdelay(priv->wait_retry_ms);
>>       } while (get_timer(start) < priv->wait_free_ms);
>>       /* Give up, release our claim */
>>       printf("I2C: Could not claim bus, timeout %lu\n", get_timer(start));
>> -    ret = -ETIMEDOUT;
>> -    ret = 0;
> 
> I wonder here ...
> 
> It seems to me current driver returns 0 instead -ETIMEDOUT in this case?
> 
> So it is also a bugfix ... ?

Correct but no idea why. I haven't seen any description in commit message.
And yes we can also add

Fixes: b725dc458f9d ("i2c: Add a mux for GPIO-based I2C bus arbitration")

Thanks,
Michal

