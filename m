Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB07D32D8A
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 14:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4647784051;
	Fri,  5 Dec 2025 15:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rXvk29sv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7189784056; Fri,  5 Dec 2025 15:42:45 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 848DC8404A
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 15:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/nFHtLOLGlQX+kEKJKPx7uc1YCrrUFvRBtITz6ols7r2fowvk/pvWv0Tfn7VvHXDADV21yjZDgEn+kdaIXJ7FMYQT925kEM7M6Xa7zOP8t7FUXkNFrgmgw33Umbiqhcf7Vmyb5CMB4sMTxNXyHiuGuyKHWQ0iSEdpOURyk8dPf9iJfH3Sb9GT0a0X0iiN0XI0rhPIxmuyxfWkXgEiIz9+UZxiFlm7XugRao2fQTyNm6fq6M1tq06rPJUEd1CcfXRLb8clCrG0JPKICkWDndrPXndkSaF/hJ+swR+UrGJl8kogt1p7dfb3aF3k2Q++FBlC9Et38dgWR3AivvpZrtew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhvcDAHximGnecLk+CyXq75mNlhL/CiA4bObiskBH18=;
 b=sRKdGiSeS3ho0q6O2qhARYpuD4OX5MUF4phomSZcZNXqXqNlFvQb9RACe2tqH13ucUmMehYQAiHiOrQfXKdquqjYjg+C9/D5vOGBZkYCWcFt+HOOYBeSGGgxyTejZoeY/3f29aBfm5wwSEaKNY57L6FOi9MVD/iO/9B2XQL//HccTpwx3gwvZbNc+mLwTmfyBqulDYsSajhDVxM+tV6Sff4d8vMb5vIV50yMT3lN0B+0L5sWOof0P+cL929+FmKhZXrfQTV5o15NsHKXHF9vNHnrKPwyxyoVJf5c3Ag71aWz04jknCFcpKeLUeajLZEjpyzrZTVK8+ZqH6cWb2bHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhvcDAHximGnecLk+CyXq75mNlhL/CiA4bObiskBH18=;
 b=rXvk29svQQOENJbw1fStXpSBPlk8twszGWY/L6DvbG9+JdlILulYjIVhzwMUf6WDDEu2bPVZdacKWiut2dxlu0J9okYRmd2IQ2dSyAmoc+wwzKW3b6xsS6EZXaK/73WGpLDSw6LkZbXpbpY/s2Mq/heoChxvlhI64ovJ3Vz9Qzk=
Received: from SA9PR13CA0088.namprd13.prod.outlook.com (2603:10b6:806:23::33)
 by CH3PR10MB6691.namprd10.prod.outlook.com (2603:10b6:610:142::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 14:42:37 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:806:23:cafe::d2) by SA9PR13CA0088.outlook.office365.com
 (2603:10b6:806:23::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Fri, 5
 Dec 2025 14:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 14:42:36 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Dec
 2025 08:42:33 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Dec
 2025 08:42:33 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Dec 2025 08:42:33 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B5EgWQs3443238;
 Fri, 5 Dec 2025 08:42:33 -0600
Message-ID: <ba834c1f-2e64-4e60-8ce7-d249cfbd11fb@ti.com>
Date: Fri, 5 Dec 2025 08:42:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: am571x_hs_evm_defconfig: Reserve EMIF memory
 used by PPA
To: Beleswar Prasad Padhi <b-padhi@ti.com>, <trini@konsulko.com>
CC: <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20251128150455.3279166-1-b-padhi@ti.com>
 <c5f858f8-0eb3-4ff0-bc7b-6286a43c93da@ti.com>
 <52e73f71-6c4d-4630-88f4-81de3fedaf83@ti.com>
 <1e980f3c-5955-47c1-81d4-f758dfa2d09c@ti.com>
 <0a4d1065-24ce-4806-9696-b300717a672f@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <0a4d1065-24ce-4806-9696-b300717a672f@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|CH3PR10MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b7de06-77c3-4a09-4a56-08de340c8885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L28zZGhBYUVtUkxUV2lua2VTUDE4RElDeHZPdGxtRy9XYVJxeS9LNW12M1Vx?=
 =?utf-8?B?cUFBcndsNi9wSCtwN3ZtTmpoSktGT3p0Q3g1WHZvaENKY2hOSDhqMUZBQ0Rw?=
 =?utf-8?B?UWFBNjU3Z0tIalo5NTFabWpYY2Q3bUlqRmRsamFRRWxlKy8wL0t1eGtrbHBy?=
 =?utf-8?B?amRoN1A0aVpLQVJIS3I5WFpJOTVCcEgwaDNib0xldk5Oam5yVXk2a2dmK2tD?=
 =?utf-8?B?akJRODFncURwakgzeDY3LytvaTVLYVNwR28zQS9DVURRSy9neHp1cm1tTWpE?=
 =?utf-8?B?Qlh0R2U1WGJvcUZkbzVFbE9CSjQ4NnlheGpjV015VXlXZjk5OFNXWVNpTFk2?=
 =?utf-8?B?RjFQQmxpMUljbCs1RmZrYkVXRmEyUlVObld3c1lMTzFUSFBVMFdheEtrVUNE?=
 =?utf-8?B?R3FqWmdJOFc0N3Q3M08yditkS215WkVXN2JDS0VlbHdWeEx1aWJqU0FsWnR4?=
 =?utf-8?B?amNyN21jM0hiTTdwY2NTamVUOTJMOWtJdlR0REFqM3BzWnJMOG5EbzNBcU9p?=
 =?utf-8?B?U1ZCMHdtc20xUUpxOS9PT1lNLzJhc1hhYnlablk3L290aWlZQmhqTTkyQmpG?=
 =?utf-8?B?alJ0R0txSkFyMUt3V0Q4a3RvVW84SFZTdUwwNWhLNHRFZGE0SG5pa05aYlRp?=
 =?utf-8?B?UVFVQURtNXJlWDYvSzRYNStHZnB5T3lDeGJWQUdIWmFrV0NpZXYveDM0QmVL?=
 =?utf-8?B?L09FQmRTNXd0VDlKbWVsTzhqcnAwUkUrdmVob09XS1diTmcrMjcwQXhiVXh4?=
 =?utf-8?B?cVRINmtHUWsrdDNrdFlQVTRDVnZxMFlRM1hhMUUwUkxNVVQ1TkV4dldGWUR6?=
 =?utf-8?B?dU94dGIyVGs2TEU2UWRaUjdIb0xPYS9OdDFDelV6NzdiL00xLytzVlk2cHUx?=
 =?utf-8?B?N2I0cXFDNzlxb0wyMXVpV1VnWk5rckJjc0gyaUtiNkxnTlN4NllzYjlQa0lk?=
 =?utf-8?B?WXBlOXpEcUNzaVdBY2VZYSt5ckI3RWVrd2RvWFhmNSt5M2NjVGttU2wrZ1Bt?=
 =?utf-8?B?ZDYxM2NHelVMSFdCS1ZENy9BbGFXM2MyZjd1d0RPWVhYT0JjMndBUkNBVHN2?=
 =?utf-8?B?cGdKOWVETGVJM2xKWGNLSFBvSThjWjRqczBBU2cwTmFxb0JMemJpVkZHTjRH?=
 =?utf-8?B?bHZQQ3IvamkxcEdVdlkrMkZuYXIvY21GN1pRU05TblFPcWdURmhXdUpYM3Y5?=
 =?utf-8?B?QWxqMHZLU0VHektNMWUwTDIwN1RXUDBackNHT0tjZ3hEWm11WVppZWpUc3Vm?=
 =?utf-8?B?UGNLUFkvWi9LVC96L201bW45UGw1clBwZCtXTW00cmFKb0Z3MzhlM01jMmZX?=
 =?utf-8?B?V0tMemp5T3gwWDhFOXhzRFgxWkNBS05WYndKV2NzUXBEVUh4RmphbDlQOWcv?=
 =?utf-8?B?QU1ad3BDSmp6Y21NbG54bll2TGdVNDkzbGI1T3FlcEk3aUJhZGoxUFB4elZU?=
 =?utf-8?B?TWsvQjR0Y2Q3L1dMd2kwUjZ3WDR5V1hYQm5mU0J4dVFPd20ycFJNSUxZVWtM?=
 =?utf-8?B?aFJQSGU2ZXVKVUlXMHYyOXJHU1ZTdnpqY0VxNzdqVXRvK1QxSzZkZ3UzQldy?=
 =?utf-8?B?YUFxOWM1TjV1ajdLNnVqWkNzOHpua2V2bGZXZURYTjlsdnVMMjMwcFpVTHZX?=
 =?utf-8?B?UEtwYkM2Q1k1V3JoRGFLVDZiTVBIQldzSEFpQ0grRHJVZm5lVTRzOU9yM0tR?=
 =?utf-8?B?ZVo5aGtGbkxlVVlWNTZhVHlURlVIV2ZRZ3I4Y0JJY2FEYVlkMk1FelpDSzdr?=
 =?utf-8?B?SDRMVnR0UWZORjRQZ2N0QWQ2aWM2WGkvNHgwdnRjeFRqSnFQSlJDT3JBTHpY?=
 =?utf-8?B?TWk4bm1pZDlmLzZoOVdTMlRxcmRmaWlMSkU0WE9pNFhRVE9TV2tSVkhubXhm?=
 =?utf-8?B?SnNLaEpZdnhUcDN2cHArT1lka09uak03ZnZZNWN0anlHUTNWb2JtUkRuUElj?=
 =?utf-8?B?cWdPaHFQdUZ1WC9VSUxhSkpvLzVUUEJmL2gxbk1oWDRMTVlhbDYzQXFPMmhi?=
 =?utf-8?B?ZDNkNzFLMkw4NjFldWV5RXJ0YmJGY0svdkZRc3dNN3p4Y0RlM0htVkJPYS84?=
 =?utf-8?Q?jgoNVj?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 14:42:36.7366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b7de06-77c3-4a09-4a56-08de340c8885
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6691
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



On 12/5/25 1:32 AM, Beleswar Prasad Padhi wrote:
> 
> On 02/12/25 18:47, Andrew Davis wrote:
>> On 12/1/25 11:56 PM, Beleswar Prasad Padhi wrote:
>>>
>>> On 02/12/25 00:58, Andrew Davis wrote:
>>>> On 11/28/25 9:04 AM, Beleswar Padhi wrote:
>>>>> The AM571x SoC has 1 GB DDR space. As part of normal re-location process
>>>>> U-Boot copies itself to the top of DDR bank. However, on HS devices, the
>>>>> top 37 MB is used by PPA and is firewalled. This results in an exception
>>>>> and the boot fails.
>>>>>
>>>>> Introduce a new defconfig for AM571x HS platforms and set
>>>>> CONFIG_SYS_MEM_TOP_HIDE to reserve the top 38 MB memory (aligned to 2MB
>>>>> as per page size for ARM32) for the same.
>>>>>
>>>>
>>>> This "SYS_MEM_TOP_HIDE" looks new, for other OMAP-class HS devices we
>>>> use "CFG_PRAM"[0], seems these two configs do the same thing, could probably
>>>> combine them in some way..
>>>>
>>>> As CFG_PRAM is set based on TI_SECURE_EMIF_TOTAL_REGION_SIZE which is 32MB
>>>
>>>
>>> CFG_PRAM is only set if TI_SECURE_EMIF_REGION_START is not set, but we
>>> have it set it to 0xbdb00000 in the am57xx_hs_evm_defconfig.
>>>
>>> https://github.com/u-boot/u-boot/blob/master/include/configs/ti_omap5_common.h#L75-L81
>>>
>>>> for all other AM57x, why is this needed only for AM571?
>>>
>>>
>>> Other AM57x boards have >1 GiB DDR. So, the top of DDR space does not
>>> intersect with the firewalled EMIF region (0xbdb00000). Only in case of
>>> AM571x, the top of DDR collides with firewalled region, so boot fails while
>>> doing reloc.
>>>
>>
>> Is there some way to detect this at runtime? Nothing prevents any of the
>> AM57x SoCs being used on boards with 1GB DDR (although they also might use
>> a different defconfig). How do we deal with this for K3 devices? Some use
>> an OP-TEE address aligned at 512MB and I'm sure one of them have that amount
>> of DDR.
> 
> 
> Well, actually not...
> It's the AM62 SIP platform. From DT, it would look like OPTEE is at the top of the
> DDR[1], but we do a FDT fixup here in u-boot to replace the OPTEE to the start
> of DDR[2]
> 
> [1]: https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi#L71
> [2]: https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-k3/am62x/am625_fdt.c#L84
> 
> I am not sure if we can do such a thing here for mem used by PPA/firmware
> as it could assume it has that memory hardcoded.
> 
>>
>>>> We build for all
>>>> the AM57x with one defconfig, so this new defconfig will go unused. Just set
>>>> the default CFG_PRAM size to 64MB (same as AM43x),
>>>
>>>
>>> I am guessing all AM43x devices have the same amount of memory unlike
>>> AM57x devices? If we set CFG_PRAM to 38MB by default, won't we lose out
>>> that memory on other devices which do not face this limitation?
>>>
>>
>> We only really supported "officially" the AM437x-EVM. But our over-focus
>> on just our EVMs caused us to make assumptions that would later make
>> it difficult to add support for customer boards. Assuming DDR size was
>> one such assumption, and should a customer board have the "wrong" DDR
>> size things like this would break.
>>
>> So instead of making another one-off fix to get one of our EVMs working,
>> I'm trying to think of a way we can make this work automatically for any
>> combination of DDR size and firewalled region.
> 
> TL;DR
> I think adding that dynamic support would be tied up only for TI usecase?
> 
> Hmm yes, I get your point. But to be able to do this dynamically, we
> would want to see if gd->relocaddr intersects with CFG_PRAM:
> 
> Case 1:
> gd->relocaddr > (SECURE_REGION_START + SECURE_REGION_SIZE)
> = Best case. U-Boot relocates to an address higher than firewalled addr
> 
> Case 2:
> gd->relocaddr <= (SECURE_REGION_START + SECURE_REGION_SIZE)
> = Fixup needed. U-Boot relocates to an address which could overlap
> with secure region. Update the gd->relocaddr to a lower address range
> which won't overlap with secure region:
> 
>      reloc_text_size = (RAM_TOP - gd->relocaddr);
>      gd->relocaddr = SECURE_REGION_START - reloc_text_size;
> 
> 
> And ofcourse, we can't put this logic in the existing 'reserve_pram'[3]
> INITCALL because gd->relocaddr gets modified in the subsequent
> initcalls like 'reserve_trace'. We would want to introduce a new
> INITCALL which would be invoked after all reserve_* initcalls and
> before the reloc_* initcalls; where we can put this logic.
> 
> Let me know if you think this is worth adding, or is an overkill and
> we can live happily with CFG_PRAM = 38 MB for all AM57x devices :)

Thanks for doing all this evaluation. I don't think this will be
the last time we run into this issue, but for now let's just make
CFG_PRAM = 64 MB for all AM57x devices and create the perfect solution
later.

Andrew

> 
> [3]: https://github.com/u-boot/u-boot/blob/master/common/board_f.c#L990
> 
> Thanks,
> Beleswar
> 
>>
>> Andrew
>>
>>> Thanks,
>>> Beleswar
>>>
>>>> should be enough for all
>>>> and doesn't hurt to have more than needed reserved to be safe.
>>>>
>>>> Andrew
>>>>
>>>> [0] https://github.com/u-boot/u-boot/blob/master/include/configs/am43xx_evm.h#L153
>>>>
>>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>>> ---
>>>>> Fix boot for TI AM571x HS EVM board
>>>>> v2: Changelog:
>>>>> 1. Drop [PATCH v1 2/2] in v2 series. There is no need to add reserved
>>>>> memory node in DT as it is done by U-Boot as part of FDT fixups
>>>>> https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-omap2/fdt-common.c#L72-L107
>>>>> 2. Add entry in MAINTAINERS for new config.
>>>>> 3. Update commit message to use memory size in MB than raw hex bytes
>>>>>
>>>>> Link to v1:
>>>>> https://lore.kernel.org/all/20251128064353.1295063-1-b-padhi@ti.com/
>>>>>
>>>>> Test logs:
>>>>> https://gist.github.com/3V3RYONE/e86b3f4551986b0400d0e0f66d6ecc66
>>>>>
>>>>>     MAINTAINERS                     | 1 +
>>>>>     configs/am571x_hs_evm_defconfig | 3 +++
>>>>>     2 files changed, 4 insertions(+)
>>>>>     create mode 100644 configs/am571x_hs_evm_defconfig
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index b43dae882b3..e5d564cd760 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -1780,6 +1780,7 @@ F:    configs/am335x_hs_evm_spi_defconfig
>>>>>     F:    configs/am335x_hs_evm_uart_defconfig
>>>>>     F:    configs/am43xx_hs_evm_defconfig
>>>>>     F:    configs/am43xx_hs_evm_qspi_defconfig
>>>>> +F:    configs/am571x_hs_evm_defconfig
>>>>>     F:    configs/am57xx_hs_evm_defconfig
>>>>>     F:    configs/am57xx_hs_evm_usb_defconfig
>>>>>     F:    configs/dra7xx_hs_evm_defconfig
>>>>> diff --git a/configs/am571x_hs_evm_defconfig b/configs/am571x_hs_evm_defconfig
>>>>> new file mode 100644
>>>>> index 00000000000..7e44ee5221a
>>>>> --- /dev/null
>>>>> +++ b/configs/am571x_hs_evm_defconfig
>>>>> @@ -0,0 +1,3 @@
>>>>> +#include <configs/am57xx_hs_evm_defconfig>
>>>>> +
>>>>> +CONFIG_SYS_MEM_TOP_HIDE=0x2600000
>>>>
>>

