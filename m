Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660C1D3514A
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 07:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACF1C84020;
	Wed,  1 Apr 2026 09:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YpoYO4ZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 773918407B; Wed,  1 Apr 2026 09:23:17 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4C3883F5B
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 09:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orGbSckBO5FEw7bLP7yMQXlZakRGUunqfzOXPrQWCIQEgIFNj2uTW1B90KC5OPiN4qkc6GvLRWj4pUyRa6FRH6nRE9clHEItvqG3G1GqUOrF9MkxrO7kpHH9aEi9fm1baF1rL077WDYHgd49mw44TILNGMca8yHaSKks/3O8CbKj/M+RhGAsLR/wiGF/tinSeghuDdbzWFZZAFoGSWroz5vzXMFHBhuQJueq/B3QJZuCbrzpK8n/hvSR/TdJhFAc2JxI52TM9cMTPdhE8GCxcPlSjY+XlTMjDrQlOpENjlIZgCFIqMXmO3vbZi9CUeGq11uKE87ohnwu/Yg4CzNgRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/2uEIkM1EHJWZVBgMqTvMK8Rhq2Hqnsx5Z1ae4kw+c=;
 b=y0OmG0xxzEOqcAeHAXQDCuO4ccFYbAg4f3W0MW3h5z+KZk16Gu6o4Yp1G3tDq2Vt/Nje2wRiS3NbAVae++8wxY7qmdOX8P7SKqdXWeIfSOCE1OcoYEQybCGvtg4rP2CYTWVbJ8tbX1fITznVrM6GG0+PLIyEyXqG0juj5WmjWvnSfh5rQJTXqGTKKNQLeGSSdXHTOjcHyAEWNgdIQT75QEo48JqLV4YIUwJAAPVUYLHcvNa9JDYw52Y5cMXUtcCbNZcDFskYj415bP/O1dNAVvMIm7nrknZzQp5cBZprnndTYYFZ5dyukxWXxWo+3kWfhrj3VXFK9lpwtDpWfHSnow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/2uEIkM1EHJWZVBgMqTvMK8Rhq2Hqnsx5Z1ae4kw+c=;
 b=YpoYO4ZHl88xgAdE0HVKm7UqLOJhSHlAp+DicZpi72iMcOIVpBD+2v1/gNWLZxxTg/5ERPOWO4AReqo7nDL3GIiUbKN6ESmSkrJrFJwZQgdPD4AVVxX5wG1/JsG4bwMYODlsv4qV+1ih02gRBwY4mShWUFfSKM34ZvG++sp7qRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS0PR12MB8478.namprd12.prod.outlook.com (2603:10b6:8:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 07:23:06 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 07:23:06 +0000
Message-ID: <e096202a-17f5-4c0b-919a-45f2d232757b@amd.com>
Date: Wed, 1 Apr 2026 09:22:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .mailmap: Fix Jerome's entry
To: Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de,
 git@amd.com
Cc: Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Heiko Schocher <hs@nabladev.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Linus Walleij <linusw@kernel.org>, Sam Protsenko
 <semen.protsenko@linaro.org>, Stefan Roese <stefan.roese@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, nd@arm.com
References: <32f53e6008a389884ee406ebba1a206e73ac29af.1775023814.git.michal.simek@amd.com>
 <7d08e7ad-bd02-412a-a3d1-30a5edc27bbe@arm.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <7d08e7ad-bd02-412a-a3d1-30a5edc27bbe@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0287.eurprd07.prod.outlook.com
 (2603:10a6:800:130::15) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS0PR12MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e2fc21-9691-49bc-5d87-08de8fbf84ea
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: w5xmYRjRU/Tc4tc//I8QXUGNc3YB5IE0dBLLniaCzUKOFmxJMpgpNQtcb6rOURonXUSK3VBo47kLECXVPScXi7kESpZ5t7zcQAd8E2hiF9tgYUiygoSWOLDPd7pO+ffetNA3T6k2CpodNgY+iEvUmzkol9rrhcFEuVHvZrN7ILt5YBdrdite6y45EKXRYNBCUK1JlT0pcCbtGGW9YHp9IZ21vudQIICbIOxGalpAn3ibHVPxGGU92w/EPpLZ6RhtPPShOGNsEatRm7mFta58262kj83WnXGVpakwPWxaa1dTfmfqqps2jMYUAk3uvHLp/9vlRJ1KuLZsRQoPw89wvhrlP6c9oejhSjMV25RgKjLUcFxY0XE2dVwG9WQJOIy0pcGPLSxyV+tm4irWqS3KbaDqvmdBwNjdPTCLXymWIb2cQb6/uzXzktsKhxDwczrdPNRLdu/CtedEOq73FGQe6ayONnMI8dg//2FevWTbEYRzmskjKBa4vKYDnhZOXa2pos1tQh22rzKC7oBOFCHwvulihst2n4hI1Rp9G/7eq352us9m3pNdF+WXjU55hp2HZE8+B9piiOFBrbR8Kac9rtxfPNCGbXx16JRAQQn5PMD6qZ606k4PxHe+u4RcQ/LYw/ERrByg2f+4+e4GFn7lTqQBHkFG81R2qauTE/YoF2I37cY8oDmuUwBrygblmUBHgJIAHxObFiT9AyxAlIk13SOn8fo01Fu4xEMxYlreNF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGs0SWxIcy9VejRVQ0VvckFoUGtuRkRxdGl5NjVFbHk0NVpNeG5uNzNCNThN?=
 =?utf-8?B?SU9HK1VQYmkxbFVESXRtSThnMGdCc1FHRGIvbmZYeDJvNGhGSDVvdnJBVWc4?=
 =?utf-8?B?ZnR2VTNrOElIeFVLbkhNSDU0UnJEYTVrQ1ZncFhZMzYvZ2JWcGxOL0tkL3Nu?=
 =?utf-8?B?QWRKbFBXYjRDdFJXcEdtOTFTbzV4TEJwN1NRNXJZTXNiQjRVNmdUK1laNm5B?=
 =?utf-8?B?djFuOUlSazB4OVNQNUx4c3FVMVppd0h6emk5WURlbGhZSlovcS9YeHl6VFpo?=
 =?utf-8?B?cTZCaUpzMWVwdVNFT052bzR4MkU2YzRhck5NRWRJMFhWczdjSmhEK1FhL3dm?=
 =?utf-8?B?eFQxcEwvMXNiVy9yNU5GYVA3TG15NnRFQmRoazRxV2ZITDBrb0lsT1lLeURk?=
 =?utf-8?B?OGpVOEhheXM3ditLQU96eFZvSmNjZ0Y2YUZ2VVlrYUdQUzlVOGRkU0dqbWhk?=
 =?utf-8?B?c1h4MXl6MEtvTkxSNU9qYlp6Zys5U2FaMGNxSHdWUjB6UmlwQTAzeGxJSVdq?=
 =?utf-8?B?b2t5YVdrWTNlM2xQSFV3Q2pSbGhzZFMwVk5INDltZzhNaFRWaVZneU91RnVH?=
 =?utf-8?B?b0Y0Tmd1d0trWkJEczF5Q0lDdjV6ZFNqeW1yY0dEYjgxZkdDekRHNFlvOFlL?=
 =?utf-8?B?dldzVTF2WHVsWVpFbGxVZG53MTNYbWpZSzJPMlZDNUpRaEJWbTBYSGRuT0Vk?=
 =?utf-8?B?VUJ1Qm1XcGRob0owN3JzanVubjFaS0taUnRCODFNQTNiV0lZVUR4dHhKS2FN?=
 =?utf-8?B?Z1NWUzVFUm0zcjY3WVFkTGNCeTk3K0hQNUNXczNBNlVlazkxdnJLclRmR2Mr?=
 =?utf-8?B?VUlrclJDNnpVMDFJZ3IxSURXWG1oT3F4SitDL2ExWkxoUzlpVmJZT2Z4RHNw?=
 =?utf-8?B?aTNOaVd1YWRrMFhaNXdabzZITDhjSnU1S1ExRTJwa3gwR0RtUzlUVlNobVJl?=
 =?utf-8?B?VTBaWjFYQ2pGb1NhQ1FyMmFITEI2RlkzWCsvQmR5ZWpxTFVSeUtFSitVSGhz?=
 =?utf-8?B?anVPWVhnaktLWHhrZlhnWm9GcmJHY3dENlF1ZkFQTkNiTmo0aXZoeGFrQ0d1?=
 =?utf-8?B?VU9WSDYwRGM3K3JEOW5LbTBQNG9pV3N1K3NSR0Q5RElhZ3ExL3J2QXFEWWNN?=
 =?utf-8?B?cnVRMkdtcTlnWGM1WW4zM21VRkM5LzBCMHFZQjR5YlRSMXovUGtWWllFVm4z?=
 =?utf-8?B?eUszbS8ydEYxQktidmFZNktzNi9xb2F0QmFZREo1NVkxMW4zdnl2eG5rZWxZ?=
 =?utf-8?B?TDkyTnUvQ3ljS0VMSWdYTW90ZGljWlpqZjlXSlBlaFY5RElkaURTVXBTMVFa?=
 =?utf-8?B?Zk9ia0pvNWpSZTIrTlVRQm5kYVlKdjNqeTRmNUNaN0htSG9kYUd1eUxhVC81?=
 =?utf-8?B?R0UxTXgrVSt5NXFUMEF6SmYwS2t3dDl5QmNzVjJUb1hPeVZKc1J4Z2dLNUgz?=
 =?utf-8?B?alBzbHZRNlRTZnRvaVdNNzlXT1l6amJwa0ZNTkNuekdCQ0VLNHVXQlJ4TFdV?=
 =?utf-8?B?aEZhL200d0Fkb1dBeGxwaFUxa0JxcGVDRG9MSUVXL0JVWHJaT1hPdHBMenA2?=
 =?utf-8?B?SE1NaUFzNEl0aEl6YUczMTZHU2hlZ3hBRFgwQVA4THMvMFlqUGh5ZkRid1U2?=
 =?utf-8?B?ZEVyZ2hoWnoraFBMeWhJYjBLdFRHWmtENTVrZXlXNTFqc2pQdjIyQWdpanE3?=
 =?utf-8?B?RFpQUW5IR2UyRktJL2hLUUFqV1gxYWpKY0x6M0tmTkpnK2tDa3ZSYkc3dnl1?=
 =?utf-8?B?WG8zMXJkY1RtdjJVNHUzR1FSTHpWTTU1TFZ6NUpHQVFRMGI5WnNwOXdiVGNK?=
 =?utf-8?B?QnRHMExzQS9LaHduMmtXSEU0QTNrZTJVcDl5b04yRzdMZzB0dFVDYW9IQzJR?=
 =?utf-8?B?L2JxblNjcmZ1Q1RrMmZ4bCtGSnM3TUt4Slh1NEl6WTUvVGx6bE1VWlA0STdj?=
 =?utf-8?B?ZEIyc1lTREVWNGltTm9EdzNsU2FUSm5LMnRpT3JmUlI3ZWtWKzVxakRENnZD?=
 =?utf-8?B?Z3A2UldaNkI1cTFIckhSdjBTRFNHUTlZby9TSFFPVEFEVm9XcUxPN3RXbW8w?=
 =?utf-8?B?OHNqK05ZNDhRdDJjZUZ3RmJXWXhkMHBtaUlTY21zVDJOdDNoUjNKbzBuU1NZ?=
 =?utf-8?B?ckxKY3k4RUxEdG16VVcvOXpBck9kdTM4Y0hXM2hSK2RCK3JkSmFSVE5FS0ll?=
 =?utf-8?B?SHpaTHJ0M2l6WGVxbUhFWERReDZTVDJvK0dQci9SUlFUK0JQVzFSQzFhVi9s?=
 =?utf-8?B?NWoveTRNWmkxeTBxb01sU3Awd0NTUUFHYTBHZGtCdStBcENYSGFNZkhYakJO?=
 =?utf-8?B?dnRNdGliMy9pWCtiNEpTc3NEV2psaFZMN21Ga2hvQVFjSVUwcGtwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e2fc21-9691-49bc-5d87-08de8fbf84ea
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 07:23:06.6506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bT5YTtirK5aJGQ9Q5sHikAlX4AtLBEQlnTx5C60BLzrNizWBBTseiq3aE89EGmLi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8478
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



On 4/1/26 09:20, Jerome Forissier wrote:
> Hi Michal,
> 
> On 01/04/2026 08:10, Michal Simek wrote:
>> When patman is used email address is composed together with both email
>> address from .mailmal file. Having two commit emails is not proper format.
>>
>> Error:
>> error: unable to extract a valid address from: Jerome Forissier
>> <jerome.forissier@arm.comjerome@forissier.org>
>>
>> Fixes: f2566c3a71a5 ("MAINTAINERS: update my email address")
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   .mailmap | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/.mailmap b/.mailmap
>> index 31d4970fff77..6ac4b9b9e5ef 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -69,7 +69,8 @@ Jagan Teki <jagannadha.sutradharudu-teki@xilinx.com>
>>   Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de> <jakob.unterwurzacher@theobroma-systems.com>
>>   Jay Buddhabhatti <jay.buddhabhatti@amd.com> <jay.buddhabhatti@xilinx.com>
>>   Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
>> -Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org> <jerome.forissier@linaro.org>
>> +Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
>> +Jerome Forissier <jerome.forissier@arm.com> <jerome.forissier@linaro.org>
>>   John Linn <john.linn@amd.com> <john.linn@xilinx.com>
>>   Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <jyothee@xilinx.com>
>>   Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <jyotheeswar.reddy.mutthareddyvari@xilinx.com>
> 
> Thanks for fixing this.

Is this any official tag? :-)

Cheers,
Michal

