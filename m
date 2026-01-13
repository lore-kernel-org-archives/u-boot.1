Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E5DD0C838
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 10:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA38683045;
	Tue, 13 Jan 2026 11:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g9UHBIC3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 096498352B; Tue, 13 Jan 2026 11:25:54 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azhn15010053.outbound.protection.outlook.com [52.102.136.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8717082B20
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:25:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0ANXyUaXY85qM+lcGVeMJKyqHetyoPilUJJa9HrFKmTjK8BVv4g3fYOznhaQesbC3ZgayDneHnTSjhTyk6nHq0DPIuw17tPqdxdsUX/L/RxS7wemQmKjET1kz3512lSedtoLG2nmQf55ZSN4kgrxJwPLdQ4NQQIlJZpBX4Cm7vQdBShDXUFbXbaRLUQ3vqDhLHjbGHwsQtU4LQU69pVFnwxzFYr6WhgVA7Nz0M5OsHFa0B3Q+jhcvU/redp1ySjT5GqLAHPjxt3a4dj4HqZN5GvoyIbuqLq10kOfneG87RWGCahUMuvB+x0VW+HDI5dWuiRe8O0dENawdLq10Y9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSU1nQsPO5i5ahdhlQZ7LJFJap02JnIrry/AzK1ASH8=;
 b=LuEa78tgz9abr/W2Qi8fH4bhPsf0eJlSTRzsANk2kemX3jJo9jRMJAr7ZcZC07UvznZL6wA3B0fAX9ktC84qPvVQYs0RG7dPZLetbycr0xfBedEcuGzArcihFPaXjGRf72ISZOviZTbT9VYS9uPPpc2cie4/50eO6W8sS+IRjBOzpPptks4gTenwF/1+WdUcWgLz8+DWYiluL2vbXFB3FvWCLGoQsiwIH1eNSZjG1H0A22MweBTPz59aB+ovcLUJF63CAQ7vzyJlc3aus++J1Bgy0LmQ7W3DE9n3tC9AUzmOIXMNkAHpKzUKF2UP365eKXNgZPNhRHSraUC7BVq4QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSU1nQsPO5i5ahdhlQZ7LJFJap02JnIrry/AzK1ASH8=;
 b=g9UHBIC3VZ+LFtGWZKEVXaAMLK/DJ+TlzsVoEo8Thf2eeh660guGxMcb38AwO55EJCF0K9PT5aDMDuq2Hz16bcoEMDMGexWTkcv2RTM1Q2/Tzh/6A5Rjdh+iX67s/qYrEo3j9QMSBLrB1d2NQwFImCI/4PeRW3LhSPVwFtN0njo=
Received: from BL0PR01CA0018.prod.exchangelabs.com (2603:10b6:208:71::31) by
 SJ5PPFC41A007A8.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7ca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 10:25:48 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:71:cafe::f7) by BL0PR01CA0018.outlook.office365.com
 (2603:10b6:208:71::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 10:25:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 10:25:46 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 04:25:30 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 04:25:29 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 04:25:29 -0600
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60DAPO671994846;
 Tue, 13 Jan 2026 04:25:25 -0600
Message-ID: <98d6a5d5-a09c-4dd0-a3c3-af5f9b58dc3b@ti.com>
Date: Tue, 13 Jan 2026 15:55:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] scripts/Makefile.xpl: Align filtered DTB to 8-byte
 within multidtb.fit
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>
CC: <ilias.apalodimas@linaro.org>, <malysagreg@gmail.com>,
 <sughosh.ganu@linaro.org>, <philip.molloy@analog.com>,
 <james.hilliard1@gmail.com>, <anshuld@ti.com>, <afd@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-2-b-padhi@ti.com>
 <9257e248-512f-4c42-999b-0f8c4f0f92b7@mailbox.org>
 <2854b18c-324f-4052-a6e5-538df6a0bcab@ti.com>
 <a799f9d0-e369-4ccf-8c64-60623143ca86@mailbox.org>
 <20260112220323.GT3416603@bill-the-cat>
 <e7d8161c-789c-4d44-af2b-19bf69f4eb12@mailbox.org>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <e7d8161c-789c-4d44-af2b-19bf69f4eb12@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|SJ5PPFC41A007A8:EE_
X-MS-Office365-Filtering-Correlation-Id: c90a3a5c-2399-44cc-0fd8-08de528e1d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|34020700016|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3ZrdnRvT2ltL3Qzb081MTJ2V1daaUwyWGxXbHptUXRZcnV4WGsvV1h3Tml0?=
 =?utf-8?B?bmVhWmp5WnFaT3poeFd0V3R3N04zdng3cTk2eHJ6dzk0VTYxaXJML0ErSjlt?=
 =?utf-8?B?eG1jQkNDc09pQ24xMEV2cklnQ0FOR0ZXR0VVOG5HUnFwWW43Y28xQ3d6NDh1?=
 =?utf-8?B?K0RBV2h1QnFYQXpNdmVnRG10Ujl4MGM3TnB3TXJCeGs4NlFTUStYQU1Zb2tu?=
 =?utf-8?B?a2MxQzNzbFJZeFVyM2ZJTWNGY1JQWHZ0U0V5VWh0UmdiRjdpcWs2YjV6Rmh2?=
 =?utf-8?B?UzZieWhuODcrWFNIZGM2ZG83a29KSTF4OEJrS1pQNDFGdWZhb3V3TmxZbjda?=
 =?utf-8?B?YUhHTGpXcXZLV3BtVm50SEVjUUpCbGdpdmFycFNqQWllNWphSW41MERDZGFC?=
 =?utf-8?B?bW51M01Iek53YlJmNGE5RjUvWmhGWE9WdGhINHBhYS92MG5YVU9lWWc1QkpZ?=
 =?utf-8?B?MktHeWkxVVIranphTlNZNmc2M0l1a2JlYkVzUjJ6bythZjVDa1Z5eFBOcmVp?=
 =?utf-8?B?YTQvRmJ0RW1qU1VJeElTZzlJODFPTEhOYXYrVmJJb3cxUktsN3pMS215N05L?=
 =?utf-8?B?UlZvTXN0SUVSUytHVDRHYVNrMDFTV0ovQ2I4Qm4yUm9VUGJ4MVBCb0JJNTAr?=
 =?utf-8?B?OTc4dmlYQVVjZk5WekVkQm5XeldTNkpaa0V2cmlHbDE0ZHZ0dEI0OFpxbHhx?=
 =?utf-8?B?STZaTGV6VVYyZ0RSbDhGeUVoNC8xTVZyLyttM3FiVS9nVUhkMSsybSs3NStN?=
 =?utf-8?B?YVVocFY3QjQ1cE04cnozNjQyUFJ3Vk9ielR0K2lQZXVEUU5zMHhjMm5ZQjdo?=
 =?utf-8?B?ZU9JL292SmN6U0JWam1BdGFabU9GdXpwNXNFQ1pmbjVSSmNzWEFvZGtVdita?=
 =?utf-8?B?c2g3QXJBSC9EM1d3R0gyM1k1cURQb1Q5V3k4bCswMy82TTd6ZkZUa21wMEFo?=
 =?utf-8?B?a1M3bHl5a0hWTm9kYUtQQ0xWTCtXbDhIVkhtbUc2d29vZ20zRWsrMjl3OFJK?=
 =?utf-8?B?N0NHUXk4ek1mYnNFSnhzY0EyNG55QXBxeW5yWFRDNmYydHdaeWhxNG4yQ2FO?=
 =?utf-8?B?aGQrTFI3M1NuM1cwblNma0J3Zmc2cjRuejFNb3lmelVHbytBSUZVOWlxenhQ?=
 =?utf-8?B?VngzQ21ocXROL1JCYWlZU0dhbVBVcC91bUtsd0g5eXh4alQwajJNeE1sWWpS?=
 =?utf-8?B?MHhMeWl5STAwSnFqRkdRdk9taFN5cFFqTDRtV1o4WGc5QUtJNUUwUUdXbnhi?=
 =?utf-8?B?VFo5cTZwT21iU29jcXppMGREekgrVDc3dENmajcwZE5OZ3diN0kzS2tDQ3JG?=
 =?utf-8?B?RmhoWUdVVXNQRmxPVkt2OHFNQ0xwQy9MNjFqbDFNWTMxTW9XWVh5MjZkaDY5?=
 =?utf-8?B?aExUcWUvTzVraVBnMkVYZVdQMEpIQUkxVGJXandEWENvRU5xa1QvS0lyc3ho?=
 =?utf-8?B?Ny9kenJHcjVncUgxTVJJVUdlMHZTc2tnVGo4M3VEb3pHOU5JWjFqNGtCZjBp?=
 =?utf-8?B?N0szTzlhSGVGcFRUbWZ0SHkvQXN5aWFRU3JUcXpJejlYTEVNS1k3WnhsbE1Y?=
 =?utf-8?B?RWZqeXMwTEtLdWcraFpzclhpajBKeWMwcVdNcHhOUStFaEkvQXhkdDVjTCts?=
 =?utf-8?B?YkpSdWNZZG1TUFlKK2ljb1NKTGtuQTBzSGhrMUJQSCtjK3BTaWUvYVU5UmF2?=
 =?utf-8?B?TkprdFRLeUd6SnpwbkZhalIzVWU5clFLcTY0UWh4blBXazBESDVDNDRiSzdI?=
 =?utf-8?B?N3hlZXhUSFBoZGVqOEEySi9xemRvYWdsKzk1QzVjZ3FCVG9MSEJnYTg1ZzBF?=
 =?utf-8?B?cyt0d21DaUQ5Yy9COU0vemFUejY2OUY2cVU0OXJxU3F2bWVkeStMMGRjUGpL?=
 =?utf-8?B?UEF4OWsvdE9kQkZXTHptbCtHaWc4WTdWODZKUkhXU0o4MFU5UkJ2NVpydnZY?=
 =?utf-8?B?UFY1U3FvOEl3SGVnV3A5SHJ2YldRVnRmMXZGRXE3bEZ4ZWJmSGZ1WUhaaVFH?=
 =?utf-8?B?MldLL3U0TGxoOVExaE9OazFkeklyZzNqZmZ2azMwcHlmYTZUN0FxeENnTVZX?=
 =?utf-8?B?bVlhaGtYbjJNWFZ2RXNNNGVqR0RmNFFCQVNFakRXM1RZaDhENStGRmViZlJM?=
 =?utf-8?Q?KQK0=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(34020700016)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 10:25:46.5084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c90a3a5c-2399-44cc-0fd8-08de528e1d77
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC41A007A8
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


On 13/01/26 05:23, Marek Vasut wrote:
> On 1/12/26 11:03 PM, Tom Rini wrote:
>
>>>> This we can fix in the Makefile via the dd command as suggested by Tom.
>>>
>>> My concern is about LEGACY fitImages (means already generated ones), not
>>> newly generated ones.
>>
>> Why is that a concern? If it's a legacy fitImage for the OS, we relocate
>> the device tree already normally to be aligned. If it's a legacy
>> fitImage of U-Boot, it's an old U-Boot?
>
> Not necessarily, it could be new U-Boot using old fitImage, for whatever reason (falcon boot maybe ?). We should not break that.
>
>>>>> - Should mkimage -E align blobs to 8 bytes by default ? I think yes,
>>>>> and frankly, I thought it does so already, but apparently not.
>>>>
>>>>
>>>> This can be done, but should it be? Not all FITs demand an 8-byte
>>>> alignment right? It is only the FDT which requires this.
>>> Maybe if image type is flat_dt, it should be implicitly 8-byte aligned then
>>> ?
>>
>> Well, the device tree spec says 8-byte alignment.
>
> 8 byte alignment of what, start of DT, right ?


Yeah from start... In this case, the FDT for OS is aligned, but the sub DT
from the FIT is not aligned by 8-bytes.

>
>> It's not "FDT for OS"
>> that's 8-byte, it's any device tree should start out 8 byte aligned, and
>> everything else should then be naturally aligned. If we're looking in a
>> device tree for another device tree to use in place and not relocate
>> then that second tree must be aligned.
>>
>> Or am I missing something?
> The discussion is about mkimage -E which generates DTs for U-Boot SPL use. The DTs in those external data should likely be aligned to 8 bytes by default, i.e. implicitly set -B 8 (they don't seem to be right now).

Instead of -E, we can use '-b' which always takes DT and make sure that is 8-byte aligned by default:

Usage: mkimage [-D dtc_options] [-f fit-image.its|-f auto|-f auto-conf|-F] [-b <dtb> [-b <dtb>]] [-E] [-B size] [-i <ramdisk.cpio.gz>] fit-image
-b => append the device tree binary to the FIT

Thanks,
Beleswar

