Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD508D1CDC6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 05:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0AB083B2C;
	Tue,  9 Dec 2025 06:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="t9e4TF6+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5A6483B6C; Tue,  9 Dec 2025 06:39:17 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ECD183935
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 06:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2xk0zNYa/7WCEzCIh9yMo2e6uXtdqiW89TvUjRnDls3u8HqRbMWnhl8mVQmb0fd6z+pqo+N1yM5jnuA3UYuIPh0dy/UEqTUu7pzF7cBkPNB8mV2q6DnmRcrZcsAtgbqwePlRLp0lH3ezq/dUEKG6Qt2jD4qCm4oAInx4lfUWziPqX7tGLSQ2xZTjVe9A2MwY1fFzA8+zlzm1i/ZTyKrbY8TB7uT+OFW4vcSsx901dKQnd6SDp5gzzV078wEgcV9Ag2X+NhFe8GboZHWjFAgTwvQemGZwg0YX9WKKfdTGQ0tPs5uyUlTYQtDLIzNUmw50JV95pSFTk+uzZT/BapnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLkB3+AROUeDceoqv6NgqmW4UjSSotSTdHR3P7O9ZEA=;
 b=r7gaHfbL2RHwa9Vz2cFJsUpRYS/oBHwbtPfX8MlreRrRzHMCH0KfhqS3Qxc91P3bDTPjxD3XjZiSgcg236UgNhwv04lvt366vW8aNiFWQesLJKlKYI2WjZq340t2hdrQ6bNd8YSKseg7sMj5lI2nXX+utA9/eEs7Z1QoBypLpl8Tvp+BRKF68Rn6KzRlSPGgqzfg8bW9T9JbVX1I2zT3V1/Opicc5ruW/LZjm4cln8oYBKrBDKxsnxEMN/7LbVkmdDmqv9upobJyCK64KW58ZUkY4fjq+1u0pXuljByTpwiJC+b304c9/oeytqDG4dLTfUSv2dmMu5sc5rqTNj71fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLkB3+AROUeDceoqv6NgqmW4UjSSotSTdHR3P7O9ZEA=;
 b=t9e4TF6+Dd0mZciO3qaC9+TDNR7sK6lkd4+LSau9B06BK5UlRfh9HoW9owINw6zT2Yr5XiqIxVVcpdV6I5/nIuWuT2hvup8SJ0NfSMBkv1un9UxTtqTn6W7mI3lggoX1FntQKrwPgbQcU3GvRh1dPCkEaBY17eqzOblBejkD7Qg=
Received: from PH8PR15CA0015.namprd15.prod.outlook.com (2603:10b6:510:2d2::23)
 by SJ5PPFCC3E08AE4.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7ce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Tue, 9 Dec
 2025 05:39:10 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::a3) by PH8PR15CA0015.outlook.office365.com
 (2603:10b6:510:2d2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 05:39:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 05:39:09 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 23:39:07 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 23:39:06 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Dec 2025 23:39:06 -0600
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B95d4dV629522;
 Mon, 8 Dec 2025 23:39:05 -0600
Message-ID: <76c1f98c-dc6c-4760-aa82-3651515015c3@ti.com>
Date: Tue, 9 Dec 2025 11:09:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: am571x_hs_evm_defconfig: Reserve EMIF memory
 used by PPA
To: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>
CC: <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20251128150455.3279166-1-b-padhi@ti.com>
 <c5f858f8-0eb3-4ff0-bc7b-6286a43c93da@ti.com>
 <52e73f71-6c4d-4630-88f4-81de3fedaf83@ti.com>
 <1e980f3c-5955-47c1-81d4-f758dfa2d09c@ti.com>
 <0a4d1065-24ce-4806-9696-b300717a672f@ti.com>
 <ba834c1f-2e64-4e60-8ce7-d249cfbd11fb@ti.com>
 <8934e095-d694-4d47-b8e2-6fca9e164646@ti.com>
 <5e90cda7-a867-417b-a898-0ff10f2b2e1a@ti.com>
 <20251208142444.GO303283@bill-the-cat>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20251208142444.GO303283@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SJ5PPFCC3E08AE4:EE_
X-MS-Office365-Filtering-Correlation-Id: ab05614b-c794-4694-41c7-08de36e546a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVpWNVJqT1gvbmtRbFFFKzFSUitvRUE3SkFCQTAvOU5tRTJ6NlBvdURjZWh1?=
 =?utf-8?B?UTNjcnkxbm1HeUNOcmRxTFlFZmR5a1ZsMFp3akd3S0dsV1NTZEpuMVpRbVpR?=
 =?utf-8?B?MlNUNGxaUkxleDRzYS92NjVWQ0JvZlR0NVVLZkhVWVVlTUxnU2oyZEYyaTQx?=
 =?utf-8?B?MUdpaDdjL2VWWTkvVkdsWHBnUVhBTnJkd0Raa1NiTTlTWTJIMTk3MXpRZUVK?=
 =?utf-8?B?ZDFLNEFiL1VkZHdVTzlHVjlrNFlKa0NrVWdQRC9qaXl6a3NUL1FsaVcwTVBj?=
 =?utf-8?B?bmlocGI2cUl2TlB4SFVuSHJOMGRWdTlSZ1luTU02RVBneUhzQjRqY2VsdE1O?=
 =?utf-8?B?NW9haURnNXl4dlg0UzJIUzg3WkdhTjFIazJmUW9QdGp0UnNXdCtmZzR0L2hv?=
 =?utf-8?B?WDl2RG9vYVNSVjlwUGt3bDc4SVFxUjErTFhjVVVXM3B5dWliWXhLUERRRjh6?=
 =?utf-8?B?NWI0UXYwdVpJZlZ3WUlhZ3djbjBmUk5vMXVDSkdhNENiNm1ZQlN3Q1FPUE5x?=
 =?utf-8?B?anhHYi9MdDBWMTRDM2REbGRMVUtFNmNWcnRDSUs5bmtFTjdVWlpqN0hiWXdl?=
 =?utf-8?B?WFVMNTJKaEIyRmZSSDRkeUN3UXhPNGpQSTNMcDV6OXJjZDVKQzFqNlp2TnA5?=
 =?utf-8?B?Z3g4dlRTYTJRQXpzaHN3SXAwN2c1c1hwcDZjL2VZb0U5aU1hQkQyRXlLVkl3?=
 =?utf-8?B?SElUVkJXbC9KNkdIOWJteWx6eWx0VzFWUHBLZWcrbWxqbis3Y2Zwb0NTL0JJ?=
 =?utf-8?B?Yklyb0tka0UvZHBJeWNRbGhiTU9YbDFQTDhTV1RYczVBdUFEUkR5N2FLRkVN?=
 =?utf-8?B?czhLVGRHV203bUYzdUZEQkFXbXg4bXN5VGUvakg3UjlJZDNwTnE3TjdzL3dq?=
 =?utf-8?B?WFFRbGI3MUdkWGJzam1zcm5KVTNRNUlqRktOckk0QUkzdE4yQS9WQzN4bmln?=
 =?utf-8?B?aGJ5VnhQVlFESTU2NVo4SXNMMXJsU2NpZ1hlS0ZXWm5LdWd0N0oybEpseXND?=
 =?utf-8?B?RHlpNVpqV3JOWHZBMkJGRytVUTZYaUFWQytiZDB5cEZXajVabFlKMS9uekNy?=
 =?utf-8?B?UjRXdy83SnFLQ3VzUWl4Nlc2L254MUhnQ1VJTDFVOHNZZlNOTmxDai90aUta?=
 =?utf-8?B?eWtiT0loVzNnY1VjZlNMMmdxcEVHSGF6K0NXZzB3R1VJM05zdld4RUkrZlpr?=
 =?utf-8?B?MTY2cXRMU0Nha01MK0I4bDJmRlIwcHVBOWdwaFV3engwNmdDY21ETURsMW5P?=
 =?utf-8?B?a2dXNlZid0MyMkpTNnEreVpVNnlvZFdCdmRFZmZPMy9SOUpicDNmL2k3anFk?=
 =?utf-8?B?SHVPNWhCd3BtRURPZHBLb2xKc2ZWTkFqK0FFMjhZQzNHeTFqaG1rRy8rTjdX?=
 =?utf-8?B?azFQWTNPMGVQalRzQ0FNYmdDYzJ1ZStyQVNqT0tIMmRlR0hVWjRLcWMwYzFN?=
 =?utf-8?B?Y1dJU29URVBzamtScUlPa2tDRVE0QlVIc0ptNzBTNGU1SHNNNDJQUEIxejRz?=
 =?utf-8?B?MlNnNWI5b1hwZjdIMm45bzBGOUduOHVwRW8xQ3cvK21PK0s5RG9OemZIVytM?=
 =?utf-8?B?Q0FoMjhLUFJsUlRNVFRPdjJLOFgyeDRGWU9SSHBqUDVqdlVNa0FyZnJiU2pr?=
 =?utf-8?B?K09MdUtuL3pkZERQaUd4SktReERNQWdBYzcyWTgwZG5SSVdENjZzSXpBbmpv?=
 =?utf-8?B?K0xvczdpdlZ6TzRBdmdFdk40ZWRlUkZmNDVRMHEyY0F5T056WUZjT2ozT3pJ?=
 =?utf-8?B?cEl1N2p0VTlvcXVBSExoRFFwdjZnelhJNTN3b3dXT1JUeCs3WlF5TUJYZkRS?=
 =?utf-8?B?dEtHOUtMTGVKRTUxc1doZW5NMkhxTFgvUkY2ODc0QnZvL3VBUTdad1RNK1V3?=
 =?utf-8?B?cWVaSS9vMXFId1ZZWEhBUU9pVnRDa1hBT21ieWhmY2FXRjBKRStlekNnWkZm?=
 =?utf-8?B?MXdYNlVGMWZUOGZZOS9xdEE3UlJKVFZhdFBjVU9FT3Y2MkxHWTlaaEN5Qkcy?=
 =?utf-8?B?aEhaTkplZFdiam5NRGovNHQ2cTdxekNMZkhQYmJ2QjFVcWVMYTR2ZUlDQzQw?=
 =?utf-8?Q?9CGtjT?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 05:39:09.3133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab05614b-c794-4694-41c7-08de36e546a1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCC3E08AE4
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


On 08/12/25 19:54, Tom Rini wrote:
> On Mon, Dec 08, 2025 at 08:21:06AM -0600, Andrew Davis wrote:
>> On 12/8/25 3:25 AM, Beleswar Prasad Padhi wrote:
>>> On 05/12/25 20:12, Andrew Davis wrote:
>>>>
>>>> On 12/5/25 1:32 AM, Beleswar Prasad Padhi wrote:
>>>>> On 02/12/25 18:47, Andrew Davis wrote:
>>>>>> On 12/1/25 11:56 PM, Beleswar Prasad Padhi wrote:
>>>>>>> On 02/12/25 00:58, Andrew Davis wrote:
>>>>>>>> On 11/28/25 9:04 AM, Beleswar Padhi wrote:
>>>>>>>>> The AM571x SoC has 1 GB DDR space. As part of normal re-location process
>>>>>>>>> U-Boot copies itself to the top of DDR bank. However, on HS devices, the
>>>>>>>>> top 37 MB is used by PPA and is firewalled. This results in an exception
>>>>>>>>> and the boot fails.
>>>>>>>>>
>>>>>>>>> Introduce a new defconfig for AM571x HS platforms and set
>>>>>>>>> CONFIG_SYS_MEM_TOP_HIDE to reserve the top 38 MB memory (aligned to 2MB
>>>>>>>>> as per page size for ARM32) for the same.
>>>>>>>>>
>>>>>>>> This "SYS_MEM_TOP_HIDE" looks new, for other OMAP-class HS devices we
>>>>>>>> use "CFG_PRAM"[0], seems these two configs do the same thing, could probably
>>>>>>>> combine them in some way..
>>>>>>>>
>>>>>>>> As CFG_PRAM is set based on TI_SECURE_EMIF_TOTAL_REGION_SIZE which is 32MB
>>>>>>>
>>>>>>> CFG_PRAM is only set if TI_SECURE_EMIF_REGION_START is not set, but we
>>>>>>> have it set it to 0xbdb00000 in the am57xx_hs_evm_defconfig.
>>>>>>>
>>>>>>> https://github.com/u-boot/u-boot/blob/master/include/configs/ti_omap5_common.h#L75-L81
>>>>>>>
>>>>>>>> for all other AM57x, why is this needed only for AM571?
>>>>>>>
>>>>>>> Other AM57x boards have >1 GiB DDR. So, the top of DDR space does not
>>>>>>> intersect with the firewalled EMIF region (0xbdb00000). Only in case of
>>>>>>> AM571x, the top of DDR collides with firewalled region, so boot fails while
>>>>>>> doing reloc.
>>>>>>>
>>>>>> Is there some way to detect this at runtime? Nothing prevents any of the
>>>>>> AM57x SoCs being used on boards with 1GB DDR (although they also might use
>>>>>> a different defconfig). How do we deal with this for K3 devices? Some use
>>>>>> an OP-TEE address aligned at 512MB and I'm sure one of them have that amount
>>>>>> of DDR.
>>>>>
>>>>> Well, actually not...
>>>>> It's the AM62 SIP platform. From DT, it would look like OPTEE is at the top of the
>>>>> DDR[1], but we do a FDT fixup here in u-boot to replace the OPTEE to the start
>>>>> of DDR[2]
>>>>>
>>>>> [1]: https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi#L71
>>>>> [2]: https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-k3/am62x/am625_fdt.c#L84
>>>>>
>>>>> I am not sure if we can do such a thing here for mem used by PPA/firmware
>>>>> as it could assume it has that memory hardcoded.
>>>>>
>>>>>>>> We build for all
>>>>>>>> the AM57x with one defconfig, so this new defconfig will go unused. Just set
>>>>>>>> the default CFG_PRAM size to 64MB (same as AM43x),
>>>>>>>
>>>>>>> I am guessing all AM43x devices have the same amount of memory unlike
>>>>>>> AM57x devices? If we set CFG_PRAM to 38MB by default, won't we lose out
>>>>>>> that memory on other devices which do not face this limitation?
>>>>>>>
>>>>>> We only really supported "officially" the AM437x-EVM. But our over-focus
>>>>>> on just our EVMs caused us to make assumptions that would later make
>>>>>> it difficult to add support for customer boards. Assuming DDR size was
>>>>>> one such assumption, and should a customer board have the "wrong" DDR
>>>>>> size things like this would break.
>>>>>>
>>>>>> So instead of making another one-off fix to get one of our EVMs working,
>>>>>> I'm trying to think of a way we can make this work automatically for any
>>>>>> combination of DDR size and firewalled region.
>>>>> TL;DR
>>>>> I think adding that dynamic support would be tied up only for TI usecase?
>>>>>
>>>>> Hmm yes, I get your point. But to be able to do this dynamically, we
>>>>> would want to see if gd->relocaddr intersects with CFG_PRAM:
>>>>>
>>>>> Case 1:
>>>>> gd->relocaddr > (SECURE_REGION_START + SECURE_REGION_SIZE)
>>>>> = Best case. U-Boot relocates to an address higher than firewalled addr
>>>>>
>>>>> Case 2:
>>>>> gd->relocaddr <= (SECURE_REGION_START + SECURE_REGION_SIZE)
>>>>> = Fixup needed. U-Boot relocates to an address which could overlap
>>>>> with secure region. Update the gd->relocaddr to a lower address range
>>>>> which won't overlap with secure region:
>>>>>
>>>>>       reloc_text_size = (RAM_TOP - gd->relocaddr);
>>>>>       gd->relocaddr = SECURE_REGION_START - reloc_text_size;
>>>>>
>>>>>
>>>>> And ofcourse, we can't put this logic in the existing 'reserve_pram'[3]
>>>>> INITCALL because gd->relocaddr gets modified in the subsequent
>>>>> initcalls like 'reserve_trace'. We would want to introduce a new
>>>>> INITCALL which would be invoked after all reserve_* initcalls and
>>>>> before the reloc_* initcalls; where we can put this logic.
>>>>>
>>>>> Let me know if you think this is worth adding, or is an overkill and
>>>>> we can live happily with CFG_PRAM = 38 MB for all AM57x devices :)
>>>> Thanks for doing all this evaluation. I don't think this will be
>>>> the last time we run into this issue, but for now let's just make
>>>> CFG_PRAM = 64 MB for all AM57x devices and create the perfect solution
>>>> later.
>>>
>>> Thanks, I tried setting CFG_PRAM but it still ended up in a firewall
>>> exception. I guess this is because CFG_PRAM only ensures U-Boot doesn't
>>> relocate to that protected address[4], however that memory is still open
>>> for access by anything else if needed. Whereas, SYS_MEM_TOP_HIDE reduces
>>> the ram size itself[5], which ensures that memory is not visible to
>>> U-Boot at all (either for reloc, or general usage).
>> Seem PRAM ("Protected" RAM) isn't all it claims to be, better route then
>> is to convert our existing uses of PRAM to SYS_MEM_TOP_HIDE, which seems
>> more modern and uses KConfig.
> I don't think it's any more or less modern, but to be clear, there's no
> way (or no reason?) to describe these memory areas in DT? Or is it that
> we also need to do some game to remove it from U-Boot's view early on
> because how of little memory there is / where this area is? Thanks!


Yes.. We need to remove that memory from U-Boot's view early on because
this area is in top of DDR where U-Boot would relocate to if not hidden.

Thanks,
Beleswar

