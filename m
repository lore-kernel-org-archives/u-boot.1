Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3C1D26D94
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 19:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76B1B843AD;
	Fri,  9 Jan 2026 20:21:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rN9zsG/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EC5A843C1; Fri,  9 Jan 2026 20:21:56 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazhn150100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d800::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED6358437C
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 20:21:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfAlfjM3sDWXv6XNcTxNzhcgz+UkZz4UPl6k+IU0HZWm/E7ATzUuqX2qdFxD4OCtlio+o4aODxlUUaxM5E4DdgWlfjoFi13sxPP8aURf/zcC4C7Q4fVcoxbu/0G98y0bOq2X1XPC4Xljhvn+vU0RQIoi5Izdgn7T1+d9UhEyV+nPRX3tIWc6YxlsDp35dKKVquNKuqhUHiia/4dtWExH5Z8i3fDYx2UVkTbBqOOozDMpvc3ZyOLs13k+LOQSpaPWKGpEZyrTK5nKP3ghOMRiKkVt09Pn0G6IYkCVkFj3cj+j9HJqMaZZhavHeqKe3N0hddh3iumxIiicqJKvrrSX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9VtLaZEQV6Jl7/cg8GQtp7Km0kF20+IK15wUjR96bs=;
 b=Qgh7gkAkyiO8a3ghsRUP9+Tj2CcwfWTuQF6O5+aqP+d5f2GS8RqKITXP6gylYv//7VZ3PoatlgyAhpxBLv0qgCx03nacfWGo0ilwO920o3Pfk6qmAdaNp33TnM7pFNbWCBSCQSIMk3oH69VcfFdU04452Vng/GzJAlI/RBXL8Yw2XO7N1PjMJlp2rOpPAGkC2hGpxREA0+6P9YNWHLrb2CRrB7rdI4VCu0cQoHPNdDpV6I7j3A2TkAb8voJHwtxJvrHKVoif867eLgqTJMnzjI8LES9P6/OPF163DzczOSQZ/Wzso/N5bO7+ofZozPQ+BQQH3VXtbpOOw4Bbh702Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9VtLaZEQV6Jl7/cg8GQtp7Km0kF20+IK15wUjR96bs=;
 b=rN9zsG/kri57G624Y1y94jgxCUtKctDc5ZnYeFq+uOCkUmPV1cII3vNgOdmJWGixQtNLVpyHd74QqhTphXUlEIFPUc6GvzFFVx3S91A4rOpHSAi8JCuEo1Lgoismk4yb+MzamMParPQiCtKJ878IyfAYFmjXnUTIzDLWkwRl7Ig=
Received: from SA9PR13CA0058.namprd13.prod.outlook.com (2603:10b6:806:22::33)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 19:21:49 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::f9) by SA9PR13CA0058.outlook.office365.com
 (2603:10b6:806:22::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Fri, 9
 Jan 2026 19:21:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 19:21:47 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 13:21:46 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 13:21:46 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 9 Jan 2026 13:21:46 -0600
Received: from [10.249.130.12] ([10.249.130.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 609JLeD4541257;
 Fri, 9 Jan 2026 13:21:41 -0600
Message-ID: <48022594-212f-4f43-ba9b-0802711e88e5@ti.com>
Date: Sat, 10 Jan 2026 00:51:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment
 before DTB
To: Tom Rini <trini@konsulko.com>
CC: <ilias.apalodimas@linaro.org>, <malysagreg@gmail.com>,
 <sughosh.ganu@linaro.org>, <philip.molloy@analog.com>,
 <marek.vasut+renesas@mailbox.org>, <james.hilliard1@gmail.com>,
 <anshuld@ti.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20260109190026.58464-1-b-padhi@ti.com>
 <20260109190026.58464-3-b-padhi@ti.com>
 <20260109191054.GJ3416603@bill-the-cat>
Content-Language: en-US
From: "Padhi, Beleswar" <b-padhi@ti.com>
In-Reply-To: <20260109191054.GJ3416603@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|SN7PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ecf9f47-5609-4d90-1a60-08de4fb45546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|34020700016|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzRYUHJUUEZmd0VyTnl2WkR4aU50Ull3OXZMVzkrMWpRUi9PRFpvdGdSUDM0?=
 =?utf-8?B?RU95Y3N3Wjg0UklOWnBWSjhDVTBvdnZKaHdQdFhET2xFZjc1YjlYdXNhQzho?=
 =?utf-8?B?aXV3bWNtUUNnOVFidmU4Q2EvcDJnS0NuN0VtQVhsQ0l5Q1pQUHNMaTg2cTBV?=
 =?utf-8?B?cEdEOXRlTWNZd01FekRWRlhXSXhad3hQODFuZmhXNTZnRExpMFNDeEkwc3la?=
 =?utf-8?B?MExiYjdOekhhZGpDT3M2dEhjS1VyWHVFOTRxbGg5UzdFR1RXa1ZBQnlHbnBm?=
 =?utf-8?B?K3RNWGgyZkhscnNNVDNkRWsyZlBycm5maG9UNHhJTE9NR1F1YlRXL3ZocVdB?=
 =?utf-8?B?VWNlMjd6eU1jRGozRUFDWWJPVWlZbEptcEFiUHA3YlZxNElsL09GWjYyV0dG?=
 =?utf-8?B?NGhhNkFhOFhqdFhzc3U5NnFNRHM4VEhiR0ZlZ05PemlMREhMSFUvbW5aSkZ4?=
 =?utf-8?B?NTd4UVRTUUxMdlhZTjlDY0wrZnc2MUtDb0VRWVVkeGw3R1ZCMEVVcko0RkNk?=
 =?utf-8?B?VHl6eVlXZGhXQmpDd01XaFY5SVhqN0s0RkhZUjZXc202UDl5MmNiaVdBQU1i?=
 =?utf-8?B?bWJFWnE1RyttdjVORi9BTGo5M1NGaVE5eENiTTJqNnFCaXo1L0g0VkFyUnlC?=
 =?utf-8?B?YURMemx6RFRVSmI2L0FNcUkwUTA2TkQ5by8yeHZoMmdISi92M3ZpOVR0anFN?=
 =?utf-8?B?OEorYXJCK2NFTXorQXY5TXlXSlVDMDZoSEtWM3ZIMlQzQVEycnpiSnRzeTRy?=
 =?utf-8?B?RmNzaW5ub2JUREN5bjk4bFRaL3UwV2FCeXoyemlaR3lMb2V3V2NtZWh2TGVs?=
 =?utf-8?B?TUNGY2hFTm8vSTF4MkFDbHlFaUNRUGZZV1hjaHIrbFlwVHNhSDRaWEZEZkJi?=
 =?utf-8?B?bkoxYS9LWURibXNSUFF2YXZPVU5Od3lhWTF1UTdZQkp4ZFcwd3JmMzhmQTdJ?=
 =?utf-8?B?UHRKQU5QQytLS3QzSzdMSVlJYUxyWTZ4a2MwRGU0S3NERXVQd2dHdmhaMTVv?=
 =?utf-8?B?ak5KWWQ2dUltL1NsWnBSK0FsSEdFcjQ1YjhCQjliZDhuZ2RNNUtRWDJlM0NF?=
 =?utf-8?B?MG16NkVNeFQzcEVPU3M4M2xnY1VqaG5HdTNVZnFSNG5ITFhrTXI4M0l5dkNr?=
 =?utf-8?B?ekVpZDVRcDlvK3Y5WWU5WEJtL0RrL011V2JwSUJXd0hmaEN2UDlBZ3lVclY4?=
 =?utf-8?B?OGJhakZERVM1cVlyR0gwT1J5K2NRZEFFYlE2Sk5GaVNOMnltY3FGNnpHbENl?=
 =?utf-8?B?T0ZkT2dKeTBwNUdydHppTWorQmxWVDFBUDVqWEFqcDlmZksxamlrT0pQTWZs?=
 =?utf-8?B?ZjdMNXBWZk50R0VDUmNHR09EazVrT3dtYktJVlF2bHZCQWFPeHZVeERrMStn?=
 =?utf-8?B?RXlUMC84WktUMFRyUXpTa0JrVlU5NENKVENzTTA0MjJ2WnlQZjgwZjExN2sr?=
 =?utf-8?B?c3hyemR1ZEV5TmlPUjEzaTBMUkY5WmFSRWhmT3pqOXRPRzFZa2Z0M1pXem9W?=
 =?utf-8?B?OC90M2FxSzFycWVTV0padlFjeDJMRUlCUnBpeEd3cEl6S085MGt1aUZma0Vk?=
 =?utf-8?B?NGdsMzV5NkFjRHRpaVNZalZZWksyeUs1VWgvcUF4aE9zNWVHT2pmZGZkWnJi?=
 =?utf-8?B?QStaTkRvbjQxbGxwTzRzNVB0dFhCb3d1RERCczg0dmJhZXN2RXJmSVVwQ1lF?=
 =?utf-8?B?OEZRaGY5OFZxbHd1K1J4dDhKU1YyZ0YraU95L2VoVGFXb1NGd1c1Y3dWZmlS?=
 =?utf-8?B?a1ZYWkpUTDhMTHdiMDVWeDBGWlVjK3pnMnl6dnhJTXpodDZJRjUreU1LVk5J?=
 =?utf-8?B?RC9ncDVQdUptbjMvZ05JY3hFZTNPQWFVVTVyTXBZdGZPZzFoSVI5Um85K3lS?=
 =?utf-8?B?c3VXWmZSUU9nMmNXVnY5RXBFSGNwcXJ4V3lmQTY5U1BlRDIra3U0d1BtVS9t?=
 =?utf-8?B?NXU2cm5hMGdHbWFKRjBmQnhoUUc3bWdNODdnQjdOSmFCNmpXL0hmSERrVlU2?=
 =?utf-8?B?ZmtvVnNQdWFSeHZPbkdGMktkNkdYYkVTTVVRQWV2RmZWRDZZWnZhSmlQUFp1?=
 =?utf-8?B?YjUwaU5FU1RWOGwvUXl0Y1ZDV1pWc0g3djZwYnRETVVhR0NadkRvTDhBTk5k?=
 =?utf-8?Q?yAHY=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(34020700016)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 19:21:47.5925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecf9f47-5609-4d90-1a60-08de4fb45546
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
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

Hi Tom,

On 1/10/2026 12:40 AM, Tom Rini wrote:
> On Sat, Jan 10, 2026 at 12:30:26AM +0530, Beleswar Padhi wrote:
>
>> The OMAP2 SPL linker script (also used for K3 platforms) currently uses
>> 4-byte alignment after the __u_boot_list section. Change this to 8-byte
>> alignment to meet the device tree specification requirement for DTB
>> alignment.
>>
>> However, this alignment directive only advances the location counter
>> without padding the actual binary output. When objcopy extracts
>> u-boot-spl-nodtb.bin, it includes only actual data, stopping at the last
>> byte of __u_boot_list (e.g., 0x41c359fc), not the aligned address (e.g.,
>> 0x41c35a00). When the FIT image containing device trees is concatenated
>> to the above SPL binary, it gets appended at the unaligned file size,
>> causing libfdt validation failure.
>>
>> To fix this, add an alignment directive inside the __u_boot_list section
>> itself. This forces the linker to include padding as part of the section
>> data, ensuring objcopy includes the padding bytes in the binary and the
>> appended FIT image starts at an 8-byte aligned boundary.
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>>   arch/arm/mach-omap2/u-boot-spl.lds | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach-omap2/u-boot-spl.lds
>> index 3bb759d8a1c..081323e6599 100644
>> --- a/arch/arm/mach-omap2/u-boot-spl.lds
>> +++ b/arch/arm/mach-omap2/u-boot-spl.lds
>> @@ -35,9 +35,10 @@ SECTIONS
>>   	. = ALIGN(4);
>>   	__u_boot_list : {
>>   		KEEP(*(SORT(__u_boot_list*)));
>> +		. = ALIGN(8);
>>   	} >.sram
>>   
>> -	. = ALIGN(4);
>> +	. = ALIGN(8);
>>   	__image_copy_end = .;
>>   	_end = .;
>>   	_image_binary_end = .;
> Do we need both of these? Shouldn't we just need the one inside the sram
> section with a comment that this ensures the end of the SRAM portion is
> 8-byte aligned?


Yes, we need only the first directive. But second one is just defensive
programming, if someday someone changes the memory layout, this just hints
that __image_copy_end should always be 8-byte aligned... Doesn't hurt to 
have
it? Let me know what you think!

Thanks,
Beleswar

