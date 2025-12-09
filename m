Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE5ED1CDC6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 05:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D990583B6C;
	Tue,  9 Dec 2025 06:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qdEEzVYx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9438383B81; Tue,  9 Dec 2025 06:53:35 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF6FE838A0
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 06:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xm35C2k0+Hgv6UlwDuueG+SrM2kVO55/x1pJoDw1TuVEdMi5Bm6ypvt088zahmQHqcEMQxZ/lFddso9u72GwdIipHPaESHgpblXWyZ9E6bjWvcbWucEk7jyQUNzPwE+552BPIJBTBEY4nhfkxcTMSFdXt0cZpqaRJpE9Bwl3ERGC7fIXGO9Ez/Hs79UsjAeSqHiievBFvtrXKFhu9XVBtfyt5pS3jGdAX9UZ6bYqoIl9+RoMahIoBX0B3wruCBMom9k4yb02HQBp8Go0k4JyahxVV9pCo/zCdCOjWAs3j9xgUbkyj9nJByID9zG2nIw98J+ASwmrhV7V/2OzkowT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtOTxg3ZDM7VMImEIc+Z1QGJQ0bu5kkhhC2OceB6inM=;
 b=clGuLdQT4TdqjxCl6esg5X4EQcTTYBGg+d9Jn0gtYPxDV46OEf5veKPWqk8fmP6/44P8K1w/sv7r7qR9qCl1ATzPGOmpISH1b4Mb7/j6JIn5tO9AlLd0mqOZOgvX/EGq8hY3wd3imVRndQKXCHOvptKat/LqNsd+kuiXOlodCXDIR5HjmhHtZaw5AjdQzaGYmpeM/Ci/Lz/bH021+ZwwZ7+VDHol5IIXVM3UqV4ySzgHVVUGZxaRMreUckEUYkr6rMixQKXsAJf9J12WVEa5/v1KIDOgRGn+rO3tZIViVocT5o7W0w6wIxiGAabgZnXh+bU3Ikn6mpHkVgbLRzK1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtOTxg3ZDM7VMImEIc+Z1QGJQ0bu5kkhhC2OceB6inM=;
 b=qdEEzVYxGa7fy3heUhtWjLt8nBmQg4llEZhTiPIeMk5y2wQQGhG2Ks7khLGgrVeuh496GDPntXyoIvCarOd1q4xaP7sa7a4K5idr5M1L5DZCOXfYU3UotCJuizJ532y8iU6BoSGyX2ogjr2J5d4Xvmg9zsYPTg6KiU/d09EOWaQ=
Received: from DM6PR08CA0056.namprd08.prod.outlook.com (2603:10b6:5:1e0::30)
 by PH3PPF55F79EE4E.namprd10.prod.outlook.com (2603:10b6:518:1::7a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 05:53:29 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::ab) by DM6PR08CA0056.outlook.office365.com
 (2603:10b6:5:1e0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 05:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 9 Dec 2025 05:53:28 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 23:53:23 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 23:53:22 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Dec 2025 23:53:22 -0600
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B95rKn2647924;
 Mon, 8 Dec 2025 23:53:21 -0600
Message-ID: <482090ac-6742-4e6a-9190-7c0e5c2259b8@ti.com>
Date: Tue, 9 Dec 2025 11:23:20 +0530
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
 <8934e095-d694-4d47-b8e2-6fca9e164646@ti.com>
 <5e90cda7-a867-417b-a898-0ff10f2b2e1a@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <5e90cda7-a867-417b-a898-0ff10f2b2e1a@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH3PPF55F79EE4E:EE_
X-MS-Office365-Filtering-Correlation-Id: ed926f98-daa7-4bd2-8dc0-08de36e74685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2I5SWd0VHpvZW1vd2pYQm95S1diL29EY0xwY2JSK25UcGFjVzI5L2VJRlFL?=
 =?utf-8?B?REREQXY1dlN3bmVoKytOd0k1WVovVDVyOVZneFIzSlREbzlWVEgyNC8wS1F1?=
 =?utf-8?B?Um1jZUVXNGdIR3pPbGozOU5RRFcwcHFPVHV5c3JIaVdEWHpJV0tXb2NxaFRH?=
 =?utf-8?B?M3dZU1k2Q2VJanM3Rk11L3lGYjQvL2poeUpUdEZhV0tKSDAzOUl6WVl5R2x0?=
 =?utf-8?B?Z25tc1lBalBHRE9HSE9HYVNodDFwVUdDSDZ3WGprK0h5ak83MzZuQzNmd0o5?=
 =?utf-8?B?Zk9EUEUyWWEvZEE3eVZ1QTVUOXRiQ0l4NDE5c3U0aXkrNmtxOGQxVXYwakxn?=
 =?utf-8?B?UU5BR3QyM0hXbVEzRHRucmRyblAzRFpmQy8rTW12dytJekEwVFl1cXVlMWJE?=
 =?utf-8?B?Q0hyczE4U0RQeXJvTU1QSU5SRHZWRmdxQ3duL2tzVHlrNjFGTlZJa1d6NEZ6?=
 =?utf-8?B?NW9LMUNoVm40MC9vbnlKQjRLdUxMN3B6SldYZDJYZVROK0RVbzVBRnJFMDht?=
 =?utf-8?B?ZXBXNHBEQ252M3ZwcmF5M25ZWjViS2Z3VVlHQUpucWJZcnZRV0d2QURya0cw?=
 =?utf-8?B?aW9rQzhNM2w5emZZMEZZcXA1UFJqc0ZMNHNGdUVZdFFJVzAxQ043dXp6Q2h0?=
 =?utf-8?B?enRNLzh0M1FoQkhXV2QwVTRxR3JDWGZBdkVFanNicWdLQzZha0tHVENzUGJn?=
 =?utf-8?B?YS9UNzI0SzFlakliSVAvZFdEVFZEVjNNMnBvT055WXRqcTMrM1hpdWg5QWNr?=
 =?utf-8?B?b0JtVy8wZEg1dXhYbUduTlFBRTYvRzdXL0dNb1grUGU4eEV1ZXRwMjFaUnFm?=
 =?utf-8?B?a2lTaGNCNkhCY2RNNys5RXl4UUlWNmNDUzhoc1V2aTlNUVEzSXg0YzRtYXdS?=
 =?utf-8?B?cmpFODBvbnVab0ZDK25KaTlSbTJaY2tVRm1weElPd0JsWmczZWlYaS8rOWV2?=
 =?utf-8?B?MmcwMVdlZG9sZVpvWldFUlE5TGZiL2M2NmlhN05OTUNta3lFai8vdWtRMjRl?=
 =?utf-8?B?dTdZYzNUdUNpNlBrY0xpLzBYc2hNVlNOTVN3WFN3UVNOV1A5M3RuMmlQdjRJ?=
 =?utf-8?B?K0t0bEd3aXlzV0hUTXdEMTJrTW5FMnVlT0YyTXJRWmRzRS9TbHM5RjNwY0gv?=
 =?utf-8?B?eTNFN0gxWTNQZW1zV1kvc0pDeDEyOU5MMitualZPRkltaFVXOXllcXhGRXNV?=
 =?utf-8?B?ckxBZnUyT2VpUjNWaXZSeDJzMnNyOThUWEtoNWE5Y3JPWU1iTGNEWGJWek10?=
 =?utf-8?B?ZzhSSzN6T3U2UVRSbXRJMGxUR0xLNlNFOC9WcEJ0Y0hZam9ZWm05V0N3MHY3?=
 =?utf-8?B?cFNLbmRLbmtJeEtOaFNNQVYzYk40d0RDcVFzZGxiNUVzMENIWFU1bTF5QmR4?=
 =?utf-8?B?MlVGT3NYTHZPV3V1NWFPcVk3anZRMWduTjRJSU9rV29WbWlNN1FqVXVyMzBv?=
 =?utf-8?B?cFE5TXExSTNSd3JEY0RQejJJSXR1N1FncWNWWnI1MFhBL2REemh4NlFHcmtv?=
 =?utf-8?B?NDZYbGQ0TFNZRFM4SzZjTTcwQkNYS25wWWpkVTJsRk0rcEQ4dmtZUXZwVVg5?=
 =?utf-8?B?aVJhQ083ZmE0SEMxV0t6SjJMRUNuRmE5dWg2dnF0TU5kVTVXeTRHdVVMS3dG?=
 =?utf-8?B?Y0tqanBmL0xSRDlEdUg1MWNzRkYvVzd4VDhjN2JCOUJWMWxkODhFZDVQZWRM?=
 =?utf-8?B?ZTg1eDVzT21DMmJKRDVjR1hTUk84UjVMdGU4S2FuQ2l5eW8rRE1wNXRJNjhM?=
 =?utf-8?B?YzZvZmd0S09aVWw5OUp0OGZhWTM3WS9xcXFIaEJlVXp1RlBzNGNTLytWd3hN?=
 =?utf-8?B?TG03bFFHSDc4YmVZU2JISSs0QmY4WXVnWXF5MWlJaWlPR3UyVzM3dGFuSHhT?=
 =?utf-8?B?VzVWcUcybWZ4clFZQUQ2WUlMQVMyVWl4dlhJeTdzRGJpdlV0cG1peHN0YmJI?=
 =?utf-8?B?VFRFN1Z5S24wWTVGcDRERWdHRm8zN01LNkVoOUZtdno2Y2xIRDRiVmorcFUx?=
 =?utf-8?B?U0xSUnZQSVlJMHpQS1RDQjcvYTUyZzN5VDBCU3hoMUZQQ0QvMXprOU5ycXVy?=
 =?utf-8?Q?qf8dwJ?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 05:53:28.0265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed926f98-daa7-4bd2-8dc0-08de36e74685
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF55F79EE4E
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


On 08/12/25 19:51, Andrew Davis wrote:
> On 12/8/25 3:25 AM, Beleswar Prasad Padhi wrote:
>>
>> On 05/12/25 20:12, Andrew Davis wrote:
>>>
>>>
>>> On 12/5/25 1:32 AM, Beleswar Prasad Padhi wrote:
>>>>
>>>> On 02/12/25 18:47, Andrew Davis wrote:
>>>>> On 12/1/25 11:56 PM, Beleswar Prasad Padhi wrote:
>>>>>>
>>>>>> On 02/12/25 00:58, Andrew Davis wrote:
>>>>>>> On 11/28/25 9:04 AM, Beleswar Padhi wrote:
>>>>>>>> The AM571x SoC has 1 GB DDR space. As part of normal re-location process
>>>>>>>> U-Boot copies itself to the top of DDR bank. However, on HS devices, the
>>>>>>>> top 37 MB is used by PPA and is firewalled. This results in an exception
>>>>>>>> and the boot fails.
>>>>>>>>
>>>>>>>> Introduce a new defconfig for AM571x HS platforms and set
>>>>>>>> CONFIG_SYS_MEM_TOP_HIDE to reserve the top 38 MB memory (aligned to 2MB
>>>>>>>> as per page size for ARM32) for the same.
>>>>>>>>
>>>>>>>
>>>>>>> This "SYS_MEM_TOP_HIDE" looks new, for other OMAP-class HS devices we
>>>>>>> use "CFG_PRAM"[0], seems these two configs do the same thing, could probably
>>>>>>> combine them in some way..
>>>>>>>
>>>>>>> As CFG_PRAM is set based on TI_SECURE_EMIF_TOTAL_REGION_SIZE which is 32MB
>>>>>>
>>>>>>
>>>>>> CFG_PRAM is only set if TI_SECURE_EMIF_REGION_START is not set, but we
>>>>>> have it set it to 0xbdb00000 in the am57xx_hs_evm_defconfig.
>>>>>>
>>>>>> https://github.com/u-boot/u-boot/blob/master/include/configs/ti_omap5_common.h#L75-L81
>>>>>>
>>>>>>> for all other AM57x, why is this needed only for AM571?
>>>>>>
>>>>>>
>>>>>> Other AM57x boards have >1 GiB DDR. So, the top of DDR space does not
>>>>>> intersect with the firewalled EMIF region (0xbdb00000). Only in case of
>>>>>> AM571x, the top of DDR collides with firewalled region, so boot fails while
>>>>>> doing reloc.
>>>>>>
>>>>>
>>>>> Is there some way to detect this at runtime? Nothing prevents any of the
>>>>> AM57x SoCs being used on boards with 1GB DDR (although they also might use
>>>>> a different defconfig). How do we deal with this for K3 devices? Some use
>>>>> an OP-TEE address aligned at 512MB and I'm sure one of them have that amount
>>>>> of DDR.
>>>>
>>>>
>>>> Well, actually not...
>>>> It's the AM62 SIP platform. From DT, it would look like OPTEE is at the top of the
>>>> DDR[1], but we do a FDT fixup here in u-boot to replace the OPTEE to the start
>>>> of DDR[2]
>>>>
>>>> [1]: https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi#L71
>>>> [2]: https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-k3/am62x/am625_fdt.c#L84
>>>>
>>>> I am not sure if we can do such a thing here for mem used by PPA/firmware
>>>> as it could assume it has that memory hardcoded.
>>>>
>>>>>
>>>>>>> We build for all
>>>>>>> the AM57x with one defconfig, so this new defconfig will go unused. Just set
>>>>>>> the default CFG_PRAM size to 64MB (same as AM43x),
>>>>>>
>>>>>>
>>>>>> I am guessing all AM43x devices have the same amount of memory unlike
>>>>>> AM57x devices? If we set CFG_PRAM to 38MB by default, won't we lose out
>>>>>> that memory on other devices which do not face this limitation?
>>>>>>
>>>>>
>>>>> We only really supported "officially" the AM437x-EVM. But our over-focus
>>>>> on just our EVMs caused us to make assumptions that would later make
>>>>> it difficult to add support for customer boards. Assuming DDR size was
>>>>> one such assumption, and should a customer board have the "wrong" DDR
>>>>> size things like this would break.
>>>>>
>>>>> So instead of making another one-off fix to get one of our EVMs working,
>>>>> I'm trying to think of a way we can make this work automatically for any
>>>>> combination of DDR size and firewalled region.
>>>>
>>>> TL;DR
>>>> I think adding that dynamic support would be tied up only for TI usecase?
>>>>
>>>> Hmm yes, I get your point. But to be able to do this dynamically, we
>>>> would want to see if gd->relocaddr intersects with CFG_PRAM:
>>>>
>>>> Case 1:
>>>> gd->relocaddr > (SECURE_REGION_START + SECURE_REGION_SIZE)
>>>> = Best case. U-Boot relocates to an address higher than firewalled addr
>>>>
>>>> Case 2:
>>>> gd->relocaddr <= (SECURE_REGION_START + SECURE_REGION_SIZE)
>>>> = Fixup needed. U-Boot relocates to an address which could overlap
>>>> with secure region. Update the gd->relocaddr to a lower address range
>>>> which won't overlap with secure region:
>>>>
>>>>       reloc_text_size = (RAM_TOP - gd->relocaddr);
>>>>       gd->relocaddr = SECURE_REGION_START - reloc_text_size;
>>>>
>>>>
>>>> And ofcourse, we can't put this logic in the existing 'reserve_pram'[3]
>>>> INITCALL because gd->relocaddr gets modified in the subsequent
>>>> initcalls like 'reserve_trace'. We would want to introduce a new
>>>> INITCALL which would be invoked after all reserve_* initcalls and
>>>> before the reloc_* initcalls; where we can put this logic.
>>>>
>>>> Let me know if you think this is worth adding, or is an overkill and
>>>> we can live happily with CFG_PRAM = 38 MB for all AM57x devices :)
>>>
>>> Thanks for doing all this evaluation. I don't think this will be
>>> the last time we run into this issue, but for now let's just make
>>> CFG_PRAM = 64 MB for all AM57x devices and create the perfect solution
>>> later.
>>
>>
>> Thanks, I tried setting CFG_PRAM but it still ended up in a firewall
>> exception. I guess this is because CFG_PRAM only ensures U-Boot doesn't
>> relocate to that protected address[4], however that memory is still open
>> for access by anything else if needed. Whereas, SYS_MEM_TOP_HIDE reduces
>> the ram size itself[5], which ensures that memory is not visible to
>> U-Boot at all (either for reloc, or general usage).
>
> Seem PRAM ("Protected" RAM) isn't all it claims to be, better route then
> is to convert our existing uses of PRAM to SYS_MEM_TOP_HIDE, which seems
> more modern and uses KConfig.


Posted patch for the same:
https://lore.kernel.org/all/20251209055043.1410085-1-b-padhi@ti.com/

Thanks,
Beleswar

>
> Andrew
>
>>
>> [4]: https://github.com/u-boot/u-boot/blob/master/common/board_f.c#L391
>> [5]: https://github.com/u-boot/u-boot/blob/master/common/board_f.c#L371
>>
>> Thanks,
>> Beleswar
>>
>>>
>>> Andrew
>>>
>>>>
>>>> [3]: https://github.com/u-boot/u-boot/blob/master/common/board_f.c#L990
>>>>
>>>> Thanks,
>>>> Beleswar
>>>>
>>>>>
>>>>> Andrew
>>>>>
>>>>>> Thanks,
>>>>>> Beleswar
>>>>>>
>>>>>>> should be enough for all
>>>>>>> and doesn't hurt to have more than needed reserved to be safe.
>>>>>>>
>>>>>>> Andrew
>>>>>>>
>>>>>>> [0] https://github.com/u-boot/u-boot/blob/master/include/configs/am43xx_evm.h#L153
>>>>>>>
>>>>>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>>>>>> ---
>>>>>>>> Fix boot for TI AM571x HS EVM board
>>>>>>>> v2: Changelog:
>>>>>>>> 1. Drop [PATCH v1 2/2] in v2 series. There is no need to add reserved
>>>>>>>> memory node in DT as it is done by U-Boot as part of FDT fixups
>>>>>>>> https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-omap2/fdt-common.c#L72-L107
>>>>>>>> 2. Add entry in MAINTAINERS for new config.
>>>>>>>> 3. Update commit message to use memory size in MB than raw hex bytes
>>>>>>>>
>>>>>>>> Link to v1:
>>>>>>>> https://lore.kernel.org/all/20251128064353.1295063-1-b-padhi@ti.com/
>>>>>>>>
>>>>>>>> Test logs:
>>>>>>>> https://gist.github.com/3V3RYONE/e86b3f4551986b0400d0e0f66d6ecc66
>>>>>>>>
>>>>>>>>      MAINTAINERS                     | 1 +
>>>>>>>>      configs/am571x_hs_evm_defconfig | 3 +++
>>>>>>>>      2 files changed, 4 insertions(+)
>>>>>>>>      create mode 100644 configs/am571x_hs_evm_defconfig
>>>>>>>>
>>>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>>>> index b43dae882b3..e5d564cd760 100644
>>>>>>>> --- a/MAINTAINERS
>>>>>>>> +++ b/MAINTAINERS
>>>>>>>> @@ -1780,6 +1780,7 @@ F:    configs/am335x_hs_evm_spi_defconfig
>>>>>>>>      F:    configs/am335x_hs_evm_uart_defconfig
>>>>>>>>      F:    configs/am43xx_hs_evm_defconfig
>>>>>>>>      F:    configs/am43xx_hs_evm_qspi_defconfig
>>>>>>>> +F:    configs/am571x_hs_evm_defconfig
>>>>>>>>      F:    configs/am57xx_hs_evm_defconfig
>>>>>>>>      F:    configs/am57xx_hs_evm_usb_defconfig
>>>>>>>>      F:    configs/dra7xx_hs_evm_defconfig
>>>>>>>> diff --git a/configs/am571x_hs_evm_defconfig b/configs/am571x_hs_evm_defconfig
>>>>>>>> new file mode 100644
>>>>>>>> index 00000000000..7e44ee5221a
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/configs/am571x_hs_evm_defconfig
>>>>>>>> @@ -0,0 +1,3 @@
>>>>>>>> +#include <configs/am57xx_hs_evm_defconfig>
>>>>>>>> +
>>>>>>>> +CONFIG_SYS_MEM_TOP_HIDE=0x2600000
>>>>>>>
>>>>>
>>>
>
