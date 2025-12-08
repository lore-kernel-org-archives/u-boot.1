Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBEBD3ABEF
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 09:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B403383ABA;
	Mon,  8 Dec 2025 10:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="t5heGYfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9783883B03; Mon,  8 Dec 2025 10:25:53 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8897383AB0
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 10:25:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaH4fGRIkj45Sf4EMiN0b5/BvSeKsSfPc3NPKfVGk59gAUgK7a0t0pgFLUgUCZC0AVU0jUYIJrGZXBbOBjSyIHwjMIpCDQ8blp3QtI7CazpA4n1m8aUUn+J5RXf5QOujfPREiNfmCyO422I7Y6Sx37o9s4VDKczcwkfeC5hH34TfswynV8ae5yoCg5Nf+rGFCGH5fKq98RBWwcbsePcLgFwkdeHoNkBMceTN75hl0YSepJlEM7K0dxepZ5asKnqQIh8edZyOgC1Vnzam9CDObXs0N2eGI7zK0+1Jcmpa0i1NB88ocyOGRUZd0RGvbDBa7RIHc2/jWY6RfIgM06qU0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6e4xwor183slVtLas9+A20XwDUotQpSIwh6h3NAbFqQ=;
 b=vsq00irwslyRBYX4MFTCaK/032+XeVAH98Itiv6gVhGhcaDL3xM4PGUUHL9pxYP9MUihZXZcQeU1MVYoMTU35WmY9xD0ZlGBtEOApxIGOD65jIc8J4OKOTSrrHM1jJXzQc60EKbJ2s6FMl2/78CB+8VfQYPe+IKyVdCwclz36O25iYshoAOu4BNUZBvEBZGWG+vWXbXRl5ykomff7FriosJO2AaeA8q3IT+H7/Nbonow9C7LC1n1HzzEzAKkMVTyk1LrPKxxYJbaIJfr/q78V5IpUEkRRjIUrEHFGjyMxQbuqBKAgOP8fKO5uywEeh7DyLO3opsnwMMdM42nOl7+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e4xwor183slVtLas9+A20XwDUotQpSIwh6h3NAbFqQ=;
 b=t5heGYfkOXGh6dw2ppby2vCvIEGpNte6B38vQsxHeF38qbzYIXrUlvCgZ61LmGHHIUP4G0/sXbdNbs4UPO8Ku2xvkkWOHWDwKAbCXsscMoM21zTjxyswAqL9fTzFSzErkn98ZBpx5AnZ9/BMogq8dSOxFJiTwVS6WNlqNaKgWZE=
Received: from CY5PR15CA0234.namprd15.prod.outlook.com (2603:10b6:930:88::24)
 by LV8PR10MB7749.namprd10.prod.outlook.com (2603:10b6:408:1e8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 09:25:46 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::12) by CY5PR15CA0234.outlook.office365.com
 (2603:10b6:930:88::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 09:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 09:25:46 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 03:25:45 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 03:25:45 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Dec 2025 03:25:45 -0600
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B89Pgu43399097;
 Mon, 8 Dec 2025 03:25:43 -0600
Message-ID: <8934e095-d694-4d47-b8e2-6fca9e164646@ti.com>
Date: Mon, 8 Dec 2025 14:55:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: am571x_hs_evm_defconfig: Reserve EMIF memory
 used by PPA
To: Andrew Davis <afd@ti.com>, <trini@konsulko.com>
CC: <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20251128150455.3279166-1-b-padhi@ti.com>
 <c5f858f8-0eb3-4ff0-bc7b-6286a43c93da@ti.com>
 <52e73f71-6c4d-4630-88f4-81de3fedaf83@ti.com>
 <1e980f3c-5955-47c1-81d4-f758dfa2d09c@ti.com>
 <0a4d1065-24ce-4806-9696-b300717a672f@ti.com>
 <ba834c1f-2e64-4e60-8ce7-d249cfbd11fb@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <ba834c1f-2e64-4e60-8ce7-d249cfbd11fb@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|LV8PR10MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ee6ee0-db7a-43ce-b972-08de363bc48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFpsdC84dThUOVNucEM3TlZwdnMzK2JHbXF0Z1Rhd25qMXZVeEJwcXI2OUFF?=
 =?utf-8?B?WjNRVFNkbEM5VFl6TWwvOEJJTTFKK2JadGVpUEtwcFQ0T3VncklQbjdrYXhY?=
 =?utf-8?B?c2EwZjRDeUhWeEIwa3NGZ1laeDh4RXBzNkdjLzVreThJMkM4aGZZWTNIcFUw?=
 =?utf-8?B?MERuMEtDQnBnM1NJbStGYWxEVitoR29Ra2ExSndqQk8zNnk2Q2tCNkorc0di?=
 =?utf-8?B?cFB3c1R0M2VhcnhhWCtwWFAxVTJZdmx3L3dBeVA1dCtvRVoyQmVLcG9FdUR6?=
 =?utf-8?B?bmxpQlNjY2NscHpBQmV3clI1Qi9Hb3ZvbjNDL29XL3JCWWhBMjlNQnZnT1NQ?=
 =?utf-8?B?aXgwVzhySDB2cVNreWlqRmN5Uko3bENTMnRCcHhrUFVVV3Bya0RlUUtZSURI?=
 =?utf-8?B?WXEzUXRqYUhUa3ZQNlo3UXB6V25QNE1jYXU4YWtzUExnT2gzekErRitLODZF?=
 =?utf-8?B?SUlDdy9uaWVEVExLdjRUSFA1R3ExNE1NOStIS1FwYWxqZ05KNlZ6Q2FsSGt4?=
 =?utf-8?B?LzJOejFWdEc3L3J3Z0t3V0VrZEZrU0JpcWNlalNONVhsNmR1OUNEV2VhVTFR?=
 =?utf-8?B?NUJGU3hyUk9ZcitRQVp4aUY3aGY5RTZjOVFmZ2tZRno4dXBBczNiNDNNS0dI?=
 =?utf-8?B?UzQ2cHZ0eFpnUXFYS3VHaHF3d2c0MEl3L1FDY1RCd1M3VkNvYzN2SUhHZStN?=
 =?utf-8?B?bVV3T2ZaYTQvUm1UWDdmWXFDL2k0c1IvWGZ4NVhDcHlNUWdGWHc0TlJuZUFi?=
 =?utf-8?B?cjdYN0lKUkhwLzBsUloxZzJSYTA0QWs1cU9Fc2lDenNpT2hpa25RSGMrQlFX?=
 =?utf-8?B?SDVwVHA3L2JKS2d4RkcvVlJxL0hxNjk4RHJKZHZNU0k5aVRnNjZCS0JNbEFn?=
 =?utf-8?B?U3k0bW41eFJEdStIbTg5T0dMMDJJMjI0Syt2RytVWHFmdFNkbGFkM1NPR0hZ?=
 =?utf-8?B?aUJEYmpnVlZlWGFEbzMveTY4RktZZGZjcWc4SlJmTENkdVR5YThQaUxSOUFs?=
 =?utf-8?B?RnlGMXJaYnZnOE5KSmgzelY0aTJFOW8zQXpKY0dHOWw3WHE4RUxveEJLSU1u?=
 =?utf-8?B?ak9nZDQ1S2tWcmNHQktZbVFVY05jYThqNllGQjJnd1RWZHloTUxMMHRFSEN6?=
 =?utf-8?B?TUdPaERMUHoxVURidnRFOWMvQ21jTDM4aHhmQTdlQXkzeWtiV0lQN0g4aElw?=
 =?utf-8?B?RzZBcG13VUFYSUZCU3dncWY1Q0diZTh5RVJNNC8reHRXVmxNUUgrVERYemFC?=
 =?utf-8?B?Zml6cDg1S1YzZUpEM01zWHg1SHRQVE5xZFRpUUlWd1JHeDQ4U2E3MXBTRnYw?=
 =?utf-8?B?Mkh5WHhpWnp0bFR0RnVVeC9SMHZaNDRqOGo1ckJ1SjFVWnJKeG1nTlhnWE9u?=
 =?utf-8?B?bUNGUmFBREc1OWR2WlJ4Y1hualpEak41RERqN1ZCZ3RPZGt4UUVZdVZEY1FC?=
 =?utf-8?B?M0FROWpaNlZvcHdOejRlMXd0M1VQbHZrQytoSUFRZ2ZpMVhrVU56MUN1Wi9U?=
 =?utf-8?B?RmlvTUt1YTlsdFRVcVdZN2ZDd1BCaWRvQzVxMXBQU1RMeG9USnBDcDhlRnhE?=
 =?utf-8?B?MGExSC9hTTNnMWZMUDNBMVJVeEhxQnRXUWJ5OHZuek02dlhDb1k5TnhpaFJy?=
 =?utf-8?B?SFlpWERmNkExdU8wN1dnUWNESU1rUFBQaEZ0cjMrenc0Uk1CUGVTZjk3dU1o?=
 =?utf-8?B?YTh1ZkJGb3F2NGNNWERoWXdKOVA2bklZeTVudUZ1eFpqWCtncStIZC9EUWNQ?=
 =?utf-8?B?bTd3eXNTTlFCRzVRYXFydWF2QkdQWlg4a1VNSG1NK2NCOG44VUpvMXFYczNt?=
 =?utf-8?B?SnErMHpLcmt3SHQwTWo4MWQ4VXlrMElzdDNYTUI3UHVVcHQ3QW1JazNBamV4?=
 =?utf-8?B?eGoyRXQvdEVPRDNIMWRLN0g4M1o1YVg3V3N1Q0ZYMERmdExTNDFqZGRiSStI?=
 =?utf-8?B?cUd0MkZLMklSK0xsY3ZuYXVPMkRYNEt4SEg3Nmc3eGdDMFhVR0g4Vm43UnQ0?=
 =?utf-8?B?MkMzZW1ES1VWcHB3MlRWKzc3djh3dS9qRG5QMUVuTk1xYjZMbXF1K2RRci9B?=
 =?utf-8?Q?5ExuDe?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 09:25:46.1442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ee6ee0-db7a-43ce-b972-08de363bc48f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7749
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


On 05/12/25 20:12, Andrew Davis wrote:
>
>
> On 12/5/25 1:32 AM, Beleswar Prasad Padhi wrote:
>>
>> On 02/12/25 18:47, Andrew Davis wrote:
>>> On 12/1/25 11:56 PM, Beleswar Prasad Padhi wrote:
>>>>
>>>> On 02/12/25 00:58, Andrew Davis wrote:
>>>>> On 11/28/25 9:04 AM, Beleswar Padhi wrote:
>>>>>> The AM571x SoC has 1 GB DDR space. As part of normal re-location process
>>>>>> U-Boot copies itself to the top of DDR bank. However, on HS devices, the
>>>>>> top 37 MB is used by PPA and is firewalled. This results in an exception
>>>>>> and the boot fails.
>>>>>>
>>>>>> Introduce a new defconfig for AM571x HS platforms and set
>>>>>> CONFIG_SYS_MEM_TOP_HIDE to reserve the top 38 MB memory (aligned to 2MB
>>>>>> as per page size for ARM32) for the same.
>>>>>>
>>>>>
>>>>> This "SYS_MEM_TOP_HIDE" looks new, for other OMAP-class HS devices we
>>>>> use "CFG_PRAM"[0], seems these two configs do the same thing, could probably
>>>>> combine them in some way..
>>>>>
>>>>> As CFG_PRAM is set based on TI_SECURE_EMIF_TOTAL_REGION_SIZE which is 32MB
>>>>
>>>>
>>>> CFG_PRAM is only set if TI_SECURE_EMIF_REGION_START is not set, but we
>>>> have it set it to 0xbdb00000 in the am57xx_hs_evm_defconfig.
>>>>
>>>> https://github.com/u-boot/u-boot/blob/master/include/configs/ti_omap5_common.h#L75-L81
>>>>
>>>>> for all other AM57x, why is this needed only for AM571?
>>>>
>>>>
>>>> Other AM57x boards have >1 GiB DDR. So, the top of DDR space does not
>>>> intersect with the firewalled EMIF region (0xbdb00000). Only in case of
>>>> AM571x, the top of DDR collides with firewalled region, so boot fails while
>>>> doing reloc.
>>>>
>>>
>>> Is there some way to detect this at runtime? Nothing prevents any of the
>>> AM57x SoCs being used on boards with 1GB DDR (although they also might use
>>> a different defconfig). How do we deal with this for K3 devices? Some use
>>> an OP-TEE address aligned at 512MB and I'm sure one of them have that amount
>>> of DDR.
>>
>>
>> Well, actually not...
>> It's the AM62 SIP platform. From DT, it would look like OPTEE is at the top of the
>> DDR[1], but we do a FDT fixup here in u-boot to replace the OPTEE to the start
>> of DDR[2]
>>
>> [1]: https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi#L71
>> [2]: https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-k3/am62x/am625_fdt.c#L84
>>
>> I am not sure if we can do such a thing here for mem used by PPA/firmware
>> as it could assume it has that memory hardcoded.
>>
>>>
>>>>> We build for all
>>>>> the AM57x with one defconfig, so this new defconfig will go unused. Just set
>>>>> the default CFG_PRAM size to 64MB (same as AM43x),
>>>>
>>>>
>>>> I am guessing all AM43x devices have the same amount of memory unlike
>>>> AM57x devices? If we set CFG_PRAM to 38MB by default, won't we lose out
>>>> that memory on other devices which do not face this limitation?
>>>>
>>>
>>> We only really supported "officially" the AM437x-EVM. But our over-focus
>>> on just our EVMs caused us to make assumptions that would later make
>>> it difficult to add support for customer boards. Assuming DDR size was
>>> one such assumption, and should a customer board have the "wrong" DDR
>>> size things like this would break.
>>>
>>> So instead of making another one-off fix to get one of our EVMs working,
>>> I'm trying to think of a way we can make this work automatically for any
>>> combination of DDR size and firewalled region.
>>
>> TL;DR
>> I think adding that dynamic support would be tied up only for TI usecase?
>>
>> Hmm yes, I get your point. But to be able to do this dynamically, we
>> would want to see if gd->relocaddr intersects with CFG_PRAM:
>>
>> Case 1:
>> gd->relocaddr > (SECURE_REGION_START + SECURE_REGION_SIZE)
>> = Best case. U-Boot relocates to an address higher than firewalled addr
>>
>> Case 2:
>> gd->relocaddr <= (SECURE_REGION_START + SECURE_REGION_SIZE)
>> = Fixup needed. U-Boot relocates to an address which could overlap
>> with secure region. Update the gd->relocaddr to a lower address range
>> which won't overlap with secure region:
>>
>>      reloc_text_size = (RAM_TOP - gd->relocaddr);
>>      gd->relocaddr = SECURE_REGION_START - reloc_text_size;
>>
>>
>> And ofcourse, we can't put this logic in the existing 'reserve_pram'[3]
>> INITCALL because gd->relocaddr gets modified in the subsequent
>> initcalls like 'reserve_trace'. We would want to introduce a new
>> INITCALL which would be invoked after all reserve_* initcalls and
>> before the reloc_* initcalls; where we can put this logic.
>>
>> Let me know if you think this is worth adding, or is an overkill and
>> we can live happily with CFG_PRAM = 38 MB for all AM57x devices :)
>
> Thanks for doing all this evaluation. I don't think this will be
> the last time we run into this issue, but for now let's just make
> CFG_PRAM = 64 MB for all AM57x devices and create the perfect solution
> later.


Thanks, I tried setting CFG_PRAM but it still ended up in a firewall
exception. I guess this is because CFG_PRAM only ensures U-Boot doesn't
relocate to that protected address[4], however that memory is still open
for access by anything else if needed. Whereas, SYS_MEM_TOP_HIDE reduces
the ram size itself[5], which ensures that memory is not visible to
U-Boot at all (either for reloc, or general usage).

[4]: https://github.com/u-boot/u-boot/blob/master/common/board_f.c#L391
[5]: https://github.com/u-boot/u-boot/blob/master/common/board_f.c#L371

Thanks,
Beleswar

>
> Andrew
>
>>
>> [3]: https://github.com/u-boot/u-boot/blob/master/common/board_f.c#L990
>>
>> Thanks,
>> Beleswar
>>
>>>
>>> Andrew
>>>
>>>> Thanks,
>>>> Beleswar
>>>>
>>>>> should be enough for all
>>>>> and doesn't hurt to have more than needed reserved to be safe.
>>>>>
>>>>> Andrew
>>>>>
>>>>> [0] https://github.com/u-boot/u-boot/blob/master/include/configs/am43xx_evm.h#L153
>>>>>
>>>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>>>> ---
>>>>>> Fix boot for TI AM571x HS EVM board
>>>>>> v2: Changelog:
>>>>>> 1. Drop [PATCH v1 2/2] in v2 series. There is no need to add reserved
>>>>>> memory node in DT as it is done by U-Boot as part of FDT fixups
>>>>>> https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-omap2/fdt-common.c#L72-L107
>>>>>> 2. Add entry in MAINTAINERS for new config.
>>>>>> 3. Update commit message to use memory size in MB than raw hex bytes
>>>>>>
>>>>>> Link to v1:
>>>>>> https://lore.kernel.org/all/20251128064353.1295063-1-b-padhi@ti.com/
>>>>>>
>>>>>> Test logs:
>>>>>> https://gist.github.com/3V3RYONE/e86b3f4551986b0400d0e0f66d6ecc66
>>>>>>
>>>>>>     MAINTAINERS                     | 1 +
>>>>>>     configs/am571x_hs_evm_defconfig | 3 +++
>>>>>>     2 files changed, 4 insertions(+)
>>>>>>     create mode 100644 configs/am571x_hs_evm_defconfig
>>>>>>
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index b43dae882b3..e5d564cd760 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -1780,6 +1780,7 @@ F:    configs/am335x_hs_evm_spi_defconfig
>>>>>>     F:    configs/am335x_hs_evm_uart_defconfig
>>>>>>     F:    configs/am43xx_hs_evm_defconfig
>>>>>>     F:    configs/am43xx_hs_evm_qspi_defconfig
>>>>>> +F:    configs/am571x_hs_evm_defconfig
>>>>>>     F:    configs/am57xx_hs_evm_defconfig
>>>>>>     F:    configs/am57xx_hs_evm_usb_defconfig
>>>>>>     F:    configs/dra7xx_hs_evm_defconfig
>>>>>> diff --git a/configs/am571x_hs_evm_defconfig b/configs/am571x_hs_evm_defconfig
>>>>>> new file mode 100644
>>>>>> index 00000000000..7e44ee5221a
>>>>>> --- /dev/null
>>>>>> +++ b/configs/am571x_hs_evm_defconfig
>>>>>> @@ -0,0 +1,3 @@
>>>>>> +#include <configs/am57xx_hs_evm_defconfig>
>>>>>> +
>>>>>> +CONFIG_SYS_MEM_TOP_HIDE=0x2600000
>>>>>
>>>
>
