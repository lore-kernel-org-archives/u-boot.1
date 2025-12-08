Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F7BD3B7F2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 14:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4F8D838E6;
	Mon,  8 Dec 2025 15:21:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G070MHlD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9057A838FA; Mon,  8 Dec 2025 15:21:24 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FD2583885
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 15:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9qMYH4PHaAypdcGDNrf8oMo0WTe6PL4IaPNwJx0ijNAnuGxhQx3KbjstDXTV6Sk3Lvzj79TrWpMzOY7GzzoLagGtCfyoUxy120ro3TQXehRGcLa1fEtsiDOFpngaSy7BxLtyx8eEO7DEN39I0qaRRD5J/JYI92BapSEj+LgFGYsj7AMQLDDHQILH2ROxWw4cX6RVXe0JoVv/Ypy7z71kIsiNnyNGfqfqK5amBokFxOadEWYsz98wOApWQmReUzO8RZsv/e3hJ4SntlUZrh28BruhyaLnTFzawlvwkLDgKS24zswTMzhTYnwfT3nlKrvl+eaylo3ubxsni7TwGjjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=na618tK9552YelA3Ufv9OOm1oVfEPLJFF+AS5MQfF1A=;
 b=Kk5X6i0H8UVKgGCVi8mfgu332YbIgJxaDEr79SNn2YRIM1ju+gjJtFBwCess+8LjasSY7jJdu03bNhFWFgoUMsXIURb3UHGwj9jULOKc5GrBsQuPTBGx9+bkr6PAEir1ybW+kfQDt98lE5wz8LPFNH9M7ArCF9Rf9SAneEYvLVHRgMUH0P2E7shfQinLJqzwtegEPaSTuKwNfIYTYlBq8IlqwINfhTPeLxrWQsBWwzs76XkQdU2B18RHZSybXPOZ1VORbimrbnHyN7jez7xCZwjDSo7IO3hkdKp8O0N059PJ5v5FntNTRO6MlSXdEkrOUTD4kE3FU499VO1sIdEz3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=na618tK9552YelA3Ufv9OOm1oVfEPLJFF+AS5MQfF1A=;
 b=G070MHlDdIL1NQ8X+qQ2JrUrd8RRLpk6fPXLdMwRZWSfPWXCmEPoGKmVce6iqfplBiVN5weY73uGd/+bA5ZZHodbiEpo0tUBu5EAf3R/oXralB6SujQS7Kj5mJ/AjcKkUex9PKLD0vrvx470q2m/rseJhJRx0IOBC6JBt+AqEpY=
Received: from CH0PR03CA0283.namprd03.prod.outlook.com (2603:10b6:610:e6::18)
 by CH3PR10MB7629.namprd10.prod.outlook.com (2603:10b6:610:167::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 14:21:14 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::c2) by CH0PR03CA0283.outlook.office365.com
 (2603:10b6:610:e6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 14:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 14:21:11 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 08:21:07 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 08:21:07 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Dec 2025 08:21:07 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B8EL7tC3761430;
 Mon, 8 Dec 2025 08:21:07 -0600
Message-ID: <5e90cda7-a867-417b-a898-0ff10f2b2e1a@ti.com>
Date: Mon, 8 Dec 2025 08:21:06 -0600
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
 <ba834c1f-2e64-4e60-8ce7-d249cfbd11fb@ti.com>
 <8934e095-d694-4d47-b8e2-6fca9e164646@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <8934e095-d694-4d47-b8e2-6fca9e164646@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CH3PR10MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a41ad2-bbe2-4c94-d7fe-08de366509e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzVrbnFZTC96TjVtZjBYMVIwT3UzM2xKZWlpVVkxU21rc2ZBOEhXVkJBbVVL?=
 =?utf-8?B?VGZJbVR1eGJ5WWhWQW05ZmVWbWZZaHRRRXhQaTRta21ZdTBBc0xLQTNaOWdz?=
 =?utf-8?B?bjcrYVpZQ3FFd0o0S2VYZzhFek92dnFxWnYrdEtCYTR3T3hvczhiRlhpTUkz?=
 =?utf-8?B?YnYvVVVnRHE3b3RHSVBaV21vZmRXM2c2R1U2cVZlNmJsYnRQQkx1bk94Yzcz?=
 =?utf-8?B?a1BzaWlmcUhxUDNndDhESzdQbDR3UWRNVFlIcXlHWFRzTkF6MTZlMElpMVhS?=
 =?utf-8?B?NXAxRVdpWWpyYWxoTjdnM2FnaWNRSE8zRHcxbXdKTW8wY2RBRkpJbExRRGFs?=
 =?utf-8?B?d21HQVdYekl5U0J6ZlpwZlJaR3BxWUdlZy9oaklMNGl4M1U0SkNHRE1EZEds?=
 =?utf-8?B?aWdWUjhEM1h2UlJZazZWSGE0VHRabVJtdUhaSXY3M0xQQ1RXQVBOa0U0WXlS?=
 =?utf-8?B?TnhuaXNZTUNqYWVrME1malNEWUtCYUlxdUtLbnBETjBCdXB6Y2g4cGhxVU9S?=
 =?utf-8?B?enNVdXJ1K21PU00rcEJkT2ZpY0JBaTVLczVpem9kZWFMTng1QUlZRjZHazZT?=
 =?utf-8?B?d1BUTktxeGdwRlNLNFZWakVpMmtPSEx2SVVHSUJ0VGRDcjUvaGZ6Q25ESjVD?=
 =?utf-8?B?UWk4elpVay8zRjUrSjBxSWVENlNHRm5ORDl6Q2ZXaWYxUndMZGJFVjZ2UWlO?=
 =?utf-8?B?VmxjOWZxV2dqb0hDaWdaMGdJSkJTNnQwNWlYY21qTEtPYndFL29sa05yaS93?=
 =?utf-8?B?RWRqRnF6RXBEbUFoWG5xZ1RsR2IxU2Npek9wUnR2dlpPS1ZQanRhUW9Qb1JB?=
 =?utf-8?B?dlVidEl6blR4WTBMODVPOCtUYkM5UzFPNFVrUURRS3hvZmxYTU9SL3ZqemdO?=
 =?utf-8?B?ZUthTkx4OW53WlU3RXFTZ2g1K3hnUnFSSVEzSzdXOFRCcDh6WXNZcE1tZHhm?=
 =?utf-8?B?bkdCNFhBVmQ5a01yYit3VXNjTGRwTERvTlNqaHZ5SFFweE43N3BTZDVzZy9T?=
 =?utf-8?B?RlRUMThQRkRnUVBQelZTQytuakhGajBSY1hDbHNtWlRFYngrd0lEb2k1bW1J?=
 =?utf-8?B?Vm5SdDBFZldNNEJtaW9INWZqTGxzbHFYZ2tIU3RCM1VzK3RxZXZMRWR5MmVH?=
 =?utf-8?B?WTI4QWI1NmRhWm43NjRCc251d3Y2ZzVNNXZNU29vNWN0K1RWUGRkRnFaKzJr?=
 =?utf-8?B?di9zRnVmc3E4cDRrUWRVdWdvdFpJaERhL3gzZ0RKMm9iUjNyZTVMQ0paQzN1?=
 =?utf-8?B?NWY1SmQxWFRVV2loV3I1MjJCYnJuZVBYRzBCKzYwTmZRajNOMG1Hc0tKb3NW?=
 =?utf-8?B?QUlyZWxHTXpiVm40K2dCeTNjaEVxcTZVTEswb1VUWXRlcFBJOUNoQXhtQlBs?=
 =?utf-8?B?eHVEcnZieDlzQnVybkVpZXUwTW96SFZNYnFMaTBpWDlOTXVNbFFqZWdaaGJK?=
 =?utf-8?B?Q2xUWk1IVXluamtNWVl4SmFNWDBFOFNiUEtod1gvSWplR2FEd3Rac0FYS0Nm?=
 =?utf-8?B?aldXZC9vNmdsN3VMbkZFQ3lxSUpwaEh4bjFrcnVOb0V0QWQ4U25wM0pabkpD?=
 =?utf-8?B?NXpzQWFLK1ZPWHFWcjZIZFRLbFhJUW5Daml6RUZ3S2JadnNPbitVbkVIZity?=
 =?utf-8?B?bzdiaWlSb0JjZmxiT0JObUhaeW9EYkRVaU5zNEovRmpUa2o2dXB0Kzd2K1lx?=
 =?utf-8?B?VGpHc2ZtSXRwblYyOWhwL3BFd3hkdkU4bkNvZXJPMjA2NFRpeFlldTF5cWhO?=
 =?utf-8?B?UUVLTFY4UVlER0lkMUNBU0V5NTdERmk2bHdaczNRMEk3Q3o3cU9ka0RzQzlT?=
 =?utf-8?B?cEc3N09TUHg3cmlzakwrN2I1Vm1Td1lRdXJzM1dHdFFOaTZacCtmRng0dXpw?=
 =?utf-8?B?ZVRTUW5QM0l6WGpOM1p6UGVZbFBmd3lyN1NrdVlVZ24renlJRzF5RnZwTm1u?=
 =?utf-8?B?ZTRBajcvV25OcnE2UUJmNTdDTXMwbUNvVDJlWGF3RDlsclN3eG8rN2xJYWpL?=
 =?utf-8?B?UjdVQmg0Z0tnSnlPZnNBWkxUUnZMejN5WDMzQ2VwS2hCdnpxdG41Nm9rMFAr?=
 =?utf-8?Q?5gm0oK?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 14:21:11.8084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a41ad2-bbe2-4c94-d7fe-08de366509e5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7629
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

On 12/8/25 3:25 AM, Beleswar Prasad Padhi wrote:
> 
> On 05/12/25 20:12, Andrew Davis wrote:
>>
>>
>> On 12/5/25 1:32 AM, Beleswar Prasad Padhi wrote:
>>>
>>> On 02/12/25 18:47, Andrew Davis wrote:
>>>> On 12/1/25 11:56 PM, Beleswar Prasad Padhi wrote:
>>>>>
>>>>> On 02/12/25 00:58, Andrew Davis wrote:
>>>>>> On 11/28/25 9:04 AM, Beleswar Padhi wrote:
>>>>>>> The AM571x SoC has 1 GB DDR space. As part of normal re-location process
>>>>>>> U-Boot copies itself to the top of DDR bank. However, on HS devices, the
>>>>>>> top 37 MB is used by PPA and is firewalled. This results in an exception
>>>>>>> and the boot fails.
>>>>>>>
>>>>>>> Introduce a new defconfig for AM571x HS platforms and set
>>>>>>> CONFIG_SYS_MEM_TOP_HIDE to reserve the top 38 MB memory (aligned to 2MB
>>>>>>> as per page size for ARM32) for the same.
>>>>>>>
>>>>>>
>>>>>> This "SYS_MEM_TOP_HIDE" looks new, for other OMAP-class HS devices we
>>>>>> use "CFG_PRAM"[0], seems these two configs do the same thing, could probably
>>>>>> combine them in some way..
>>>>>>
>>>>>> As CFG_PRAM is set based on TI_SECURE_EMIF_TOTAL_REGION_SIZE which is 32MB
>>>>>
>>>>>
>>>>> CFG_PRAM is only set if TI_SECURE_EMIF_REGION_START is not set, but we
>>>>> have it set it to 0xbdb00000 in the am57xx_hs_evm_defconfig.
>>>>>
>>>>> https://github.com/u-boot/u-boot/blob/master/include/configs/ti_omap5_common.h#L75-L81
>>>>>
>>>>>> for all other AM57x, why is this needed only for AM571?
>>>>>
>>>>>
>>>>> Other AM57x boards have >1 GiB DDR. So, the top of DDR space does not
>>>>> intersect with the firewalled EMIF region (0xbdb00000). Only in case of
>>>>> AM571x, the top of DDR collides with firewalled region, so boot fails while
>>>>> doing reloc.
>>>>>
>>>>
>>>> Is there some way to detect this at runtime? Nothing prevents any of the
>>>> AM57x SoCs being used on boards with 1GB DDR (although they also might use
>>>> a different defconfig). How do we deal with this for K3 devices? Some use
>>>> an OP-TEE address aligned at 512MB and I'm sure one of them have that amount
>>>> of DDR.
>>>
>>>
>>> Well, actually not...
>>> It's the AM62 SIP platform. From DT, it would look like OPTEE is at the top of the
>>> DDR[1], but we do a FDT fixup here in u-boot to replace the OPTEE to the start
>>> of DDR[2]
>>>
>>> [1]: https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi#L71
>>> [2]: https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-k3/am62x/am625_fdt.c#L84
>>>
>>> I am not sure if we can do such a thing here for mem used by PPA/firmware
>>> as it could assume it has that memory hardcoded.
>>>
>>>>
>>>>>> We build for all
>>>>>> the AM57x with one defconfig, so this new defconfig will go unused. Just set
>>>>>> the default CFG_PRAM size to 64MB (same as AM43x),
>>>>>
>>>>>
>>>>> I am guessing all AM43x devices have the same amount of memory unlike
>>>>> AM57x devices? If we set CFG_PRAM to 38MB by default, won't we lose out
>>>>> that memory on other devices which do not face this limitation?
>>>>>
>>>>
>>>> We only really supported "officially" the AM437x-EVM. But our over-focus
>>>> on just our EVMs caused us to make assumptions that would later make
>>>> it difficult to add support for customer boards. Assuming DDR size was
>>>> one such assumption, and should a customer board have the "wrong" DDR
>>>> size things like this would break.
>>>>
>>>> So instead of making another one-off fix to get one of our EVMs working,
>>>> I'm trying to think of a way we can make this work automatically for any
>>>> combination of DDR size and firewalled region.
>>>
>>> TL;DR
>>> I think adding that dynamic support would be tied up only for TI usecase?
>>>
>>> Hmm yes, I get your point. But to be able to do this dynamically, we
>>> would want to see if gd->relocaddr intersects with CFG_PRAM:
>>>
>>> Case 1:
>>> gd->relocaddr > (SECURE_REGION_START + SECURE_REGION_SIZE)
>>> = Best case. U-Boot relocates to an address higher than firewalled addr
>>>
>>> Case 2:
>>> gd->relocaddr <= (SECURE_REGION_START + SECURE_REGION_SIZE)
>>> = Fixup needed. U-Boot relocates to an address which could overlap
>>> with secure region. Update the gd->relocaddr to a lower address range
>>> which won't overlap with secure region:
>>>
>>>       reloc_text_size = (RAM_TOP - gd->relocaddr);
>>>       gd->relocaddr = SECURE_REGION_START - reloc_text_size;
>>>
>>>
>>> And ofcourse, we can't put this logic in the existing 'reserve_pram'[3]
>>> INITCALL because gd->relocaddr gets modified in the subsequent
>>> initcalls like 'reserve_trace'. We would want to introduce a new
>>> INITCALL which would be invoked after all reserve_* initcalls and
>>> before the reloc_* initcalls; where we can put this logic.
>>>
>>> Let me know if you think this is worth adding, or is an overkill and
>>> we can live happily with CFG_PRAM = 38 MB for all AM57x devices :)
>>
>> Thanks for doing all this evaluation. I don't think this will be
>> the last time we run into this issue, but for now let's just make
>> CFG_PRAM = 64 MB for all AM57x devices and create the perfect solution
>> later.
> 
> 
> Thanks, I tried setting CFG_PRAM but it still ended up in a firewall
> exception. I guess this is because CFG_PRAM only ensures U-Boot doesn't
> relocate to that protected address[4], however that memory is still open
> for access by anything else if needed. Whereas, SYS_MEM_TOP_HIDE reduces
> the ram size itself[5], which ensures that memory is not visible to
> U-Boot at all (either for reloc, or general usage).

Seem PRAM ("Protected" RAM) isn't all it claims to be, better route then
is to convert our existing uses of PRAM to SYS_MEM_TOP_HIDE, which seems
more modern and uses KConfig.

Andrew

> 
> [4]: https://github.com/u-boot/u-boot/blob/master/common/board_f.c#L391
> [5]: https://github.com/u-boot/u-boot/blob/master/common/board_f.c#L371
> 
> Thanks,
> Beleswar
> 
>>
>> Andrew
>>
>>>
>>> [3]: https://github.com/u-boot/u-boot/blob/master/common/board_f.c#L990
>>>
>>> Thanks,
>>> Beleswar
>>>
>>>>
>>>> Andrew
>>>>
>>>>> Thanks,
>>>>> Beleswar
>>>>>
>>>>>> should be enough for all
>>>>>> and doesn't hurt to have more than needed reserved to be safe.
>>>>>>
>>>>>> Andrew
>>>>>>
>>>>>> [0] https://github.com/u-boot/u-boot/blob/master/include/configs/am43xx_evm.h#L153
>>>>>>
>>>>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>>>>> ---
>>>>>>> Fix boot for TI AM571x HS EVM board
>>>>>>> v2: Changelog:
>>>>>>> 1. Drop [PATCH v1 2/2] in v2 series. There is no need to add reserved
>>>>>>> memory node in DT as it is done by U-Boot as part of FDT fixups
>>>>>>> https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-omap2/fdt-common.c#L72-L107
>>>>>>> 2. Add entry in MAINTAINERS for new config.
>>>>>>> 3. Update commit message to use memory size in MB than raw hex bytes
>>>>>>>
>>>>>>> Link to v1:
>>>>>>> https://lore.kernel.org/all/20251128064353.1295063-1-b-padhi@ti.com/
>>>>>>>
>>>>>>> Test logs:
>>>>>>> https://gist.github.com/3V3RYONE/e86b3f4551986b0400d0e0f66d6ecc66
>>>>>>>
>>>>>>>      MAINTAINERS                     | 1 +
>>>>>>>      configs/am571x_hs_evm_defconfig | 3 +++
>>>>>>>      2 files changed, 4 insertions(+)
>>>>>>>      create mode 100644 configs/am571x_hs_evm_defconfig
>>>>>>>
>>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>>> index b43dae882b3..e5d564cd760 100644
>>>>>>> --- a/MAINTAINERS
>>>>>>> +++ b/MAINTAINERS
>>>>>>> @@ -1780,6 +1780,7 @@ F:    configs/am335x_hs_evm_spi_defconfig
>>>>>>>      F:    configs/am335x_hs_evm_uart_defconfig
>>>>>>>      F:    configs/am43xx_hs_evm_defconfig
>>>>>>>      F:    configs/am43xx_hs_evm_qspi_defconfig
>>>>>>> +F:    configs/am571x_hs_evm_defconfig
>>>>>>>      F:    configs/am57xx_hs_evm_defconfig
>>>>>>>      F:    configs/am57xx_hs_evm_usb_defconfig
>>>>>>>      F:    configs/dra7xx_hs_evm_defconfig
>>>>>>> diff --git a/configs/am571x_hs_evm_defconfig b/configs/am571x_hs_evm_defconfig
>>>>>>> new file mode 100644
>>>>>>> index 00000000000..7e44ee5221a
>>>>>>> --- /dev/null
>>>>>>> +++ b/configs/am571x_hs_evm_defconfig
>>>>>>> @@ -0,0 +1,3 @@
>>>>>>> +#include <configs/am57xx_hs_evm_defconfig>
>>>>>>> +
>>>>>>> +CONFIG_SYS_MEM_TOP_HIDE=0x2600000
>>>>>>
>>>>
>>

