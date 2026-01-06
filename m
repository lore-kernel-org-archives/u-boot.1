Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB75DC47BE0
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 10:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D30C83D9F;
	Tue,  6 Jan 2026 11:37:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BDRCVbf8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB46B83F20; Tue,  6 Jan 2026 11:37:57 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6701C83A57
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 11:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AB210p9E7Cn6QMR0LqheHqenKEtoXOHx8lM/m8fz94bt+gGhZLFksyrAmUvvpIcUcueWOyyL8qs5xVJvG9VSXj2cKX4IIRRwmRi3YqO1YrSTmpLl5ErL6CCOnXwXSJn+GfTYprIvG/3wORcn/NHggGQeEx6JQC4pSaXcBFRXJy4cWK3SAtqf73EqEjMhwOVz4izZVemdBfqm4Kpx5HEOrQ1lh+k0IaX9ORFS+ADent4AgcXWg6I8CkGfBpL/npCM10Yc5HrxGn599MOO7ocurAYpVfjpqwZ+ZYs15oaXcMD18LiiS/i5X6DeSPA0+S1qiiNUQWmHZ2J0BbtuQUTVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODXQ/Nhxq69c3Gq2aA57qE0AbX1hA69KtlrMttghrfc=;
 b=Rw1HCWb7er0I4/3CRgq5RCJBljtwCHedD3fqnPa+00RSNIVEECmG/7dmiIb8p6+2sMomVNWMTLOXj1c7qPQJnDm7hLrLcjt/acTBZ2xMhydbzqyPc78kQ3oepPhtXCRaCdCccaLVwrNZmFx4ifIG8iMWzhRjBSo31ZCzx3pLKdMSXwSd37lkyQY+koYF/IFvSGTTQSYMdXywvIndXE2UMSZ54i1konwsEVO8F/yMvsfmeLWiKSbICgfalwSi6m1lMEgOscfs3Hk6rX5kNH3HVcXcjtEX3nFvwf+hwuE7dw1NUqSsMVCnzGZUW5ktxLjJiGdzlDMeZ3JdcIJnPYXM1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODXQ/Nhxq69c3Gq2aA57qE0AbX1hA69KtlrMttghrfc=;
 b=BDRCVbf8QoCI7MFS2ZL7/NoSGjXZ93Ayoc3D7tzxQuRm3fvw7En+DK7L0k1z70NGTuJJUwPvzSsSYbqg1bxV6JXwH6M9LcwQSuut2uPaAqLWV6OFhYBLFmz9gmqZKtNnL3894qUlyJ32QFl6gFKAk9LX3OoTl+sGBWPZK7Qm4Jg=
Received: from SJ0PR03CA0169.namprd03.prod.outlook.com (2603:10b6:a03:338::24)
 by PH0PR10MB997688.namprd10.prod.outlook.com (2603:10b6:510:384::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 10:37:52 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::ae) by SJ0PR03CA0169.outlook.office365.com
 (2603:10b6:a03:338::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 10:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:37:52 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 04:37:48 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 04:37:48 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 6 Jan 2026 04:37:47 -0600
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 606AbiLS2879465;
 Tue, 6 Jan 2026 04:37:45 -0600
Message-ID: <4c742926-05d4-4d9b-a8c7-c36209c01c6a@ti.com>
Date: Tue, 6 Jan 2026 16:07:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] configs: j722s_evm_r5_hsmboot: Add new defconfig
 to show HSM boot
To: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>
CC: <trini@konsulko.com>, <anshuld@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
 <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20251231173621.1069988-1-b-padhi@ti.com>
 <20251231173621.1069988-12-b-padhi@ti.com>
 <20260105141105.ykq2uaelapfqb2m2@bryanbrattlof.com>
 <f30315f1-484c-4350-b1f4-e3927c62b4dc@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <f30315f1-484c-4350-b1f4-e3927c62b4dc@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|PH0PR10MB997688:EE_
X-MS-Office365-Filtering-Correlation-Id: be5b5ed3-62da-435e-b3b4-08de4d0fa52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXN6WTlPMjk1Y2I2c0V6Z3o3b25ZRzB5OEY4SHlXNFF5VmxoVHh3L2R3ZDZp?=
 =?utf-8?B?ZmNlM3d4NStrZnRJSWg5YklVNlpPZW9IUTRlQXRUbFhhMGsvQWR4R2pTMnQw?=
 =?utf-8?B?OHNZTUtubW1Dd0xBdkpQL1UwcDlTV0Z2bTUyTlNaNGM3aWtObXZjeUdwUHI5?=
 =?utf-8?B?bzZyTlZwQThBNE1yRFVyaTZua1pFUllWWi91L0V3c3M3NFlpRHNKTTlrME5Q?=
 =?utf-8?B?U0FwcjVydHpjR0graXBMWWZ1Wkx1bS9DMVJHcERYUGcrN0cxcVhkVXNiR1gx?=
 =?utf-8?B?VUR3K2FtMndVUEYzaHNValFOelYyL25SMkdFclhtNDlqcWFSZEM1MFJna0d1?=
 =?utf-8?B?eGNJVkJvRjJ0TFBLelh6TXRlb3ZFYTBTeUFtM2dxKy9xK04xL2ROM2trVGpQ?=
 =?utf-8?B?Z2hkcE1QbDJLaWk5OTJxWlh1OTdxc0k3eWRqZWNJZDB0VDRmVFBnT3FFdUxG?=
 =?utf-8?B?blJVN3pQT3dMbDBNNUt3Ym5VdTg4QlN2ZzlwcUEvd3Z5UUh5RmFlZXlnYTMy?=
 =?utf-8?B?U0lxdS82Slhiem5WbVdJakxOTFFtcEtqSG13bEEyd0pTbkszd3ZpWnRUaUc2?=
 =?utf-8?B?Z3VWU0RMNFN4cnptcEdaU0R4NGZ1Q1Z6RHRLaWtVeWU5ejl0YTRST0hqWVdO?=
 =?utf-8?B?YXhLWjR3Nk16QUgzNlo3b1Q3SVprNGpBK3dXNWNpNlQ1bWx0MldZU2ZNRWZV?=
 =?utf-8?B?Sm9PWUVxR1RYWTdWNnFOejRqN0ljMGVsTjRiNzFveGJ2MDk0VVZaWTBrbzd2?=
 =?utf-8?B?NHQrc2dyUXRlRzVPTkVtZW5UeDEzaWl0QWlrNHYyMGhnb1N6bjZJaVBtdFJX?=
 =?utf-8?B?YnpzdU16anhoek9hc3hHeHhaWVdUc1gvVm4zTm9jd0xxbTlSalRPRHBRYjVQ?=
 =?utf-8?B?emZ6OHYyZkxBTTRlanYxUURiVmtWbjA5QndwMXVKZG1taFZ6NTZTSHZVUmw2?=
 =?utf-8?B?VTdPKzRSbmhhS0t4Tm1XSCsrbHJTUmgybXNIY1Z2SGdoVzdRaHVJWWtiRDZq?=
 =?utf-8?B?aTJwa0g0VlpqWkpBREU1R3Yvd3NwbndIc0V6bkU2cWlEWjJHT2Q4SWhiNW9l?=
 =?utf-8?B?TlJyT0twbFdhM1ArQXowYWJ1RDVhMHREZ3RJbngzaDM4WEFpbE9wZkJIRnFD?=
 =?utf-8?B?Y0hsK2Fsa0ZYdnFoVFo5VWJKdHJXQjM3NDZ3emdacVJQSFR0UFM2ZTE0U2gz?=
 =?utf-8?B?emMyYk1vVW1yUDN2aGhVby9lVy9DMnd5K3B5R21ad2RYemtNYXFVZjJsRVdZ?=
 =?utf-8?B?ZHprajVuSkhTQjlkRmt1TFUzZFVYSjFrSTRvdHRUS2piRm1xaW9CaGZiR3Bo?=
 =?utf-8?B?THdnZlc1bCtZUW5TUGFCbFpwLzdLMU5EUUZveWpzRVZuSzBnZVVrcXZYeUZG?=
 =?utf-8?B?OGZSRERtTGx4Q2taR000YUozU21leVA4aVUvSHVKVlpFcWdISEZQd0ZndGR0?=
 =?utf-8?B?OVdUR3VncnJObjhVWUhpeGpPS3B4MjNyWDJYa2JjcDVOQ08xKzZ0NStnTkhO?=
 =?utf-8?B?Tk9sdll0Qlc4Wi9MdVMvc3RIU2g1NGgvbWdoTjhDRjBsTlhOeVdpNHpwR1N0?=
 =?utf-8?B?dnhqNXF5SDJmUWg5RCtsN0ZxQWRrL2E2SXFjelp4TGw2ZG9wSmFvSG82c29Y?=
 =?utf-8?B?Z3FqNE12Y0cxblBrb2NZYWdJK3gveXVGL0J1Mk9wRlJ5MmVjZEQyVFBrMTRo?=
 =?utf-8?B?ZEtlUXNhanp6YTBkVGZmRGJ4VjhmSWZtcDRwczB1MWNoa1IvMVNaNk9sSCth?=
 =?utf-8?B?NHE2TVE5bkd5bDZONXNzcllNZ0RyMHNjZmNFejZjOG5KUUtMNDc3RWtENm10?=
 =?utf-8?B?MlYvWnNOaTBZZDkxUm5PMkNxbTZCL3hSOG9lalViNUdlZDRzTGpxSUY5aFdK?=
 =?utf-8?B?WnFualM2Y0VLTGdlaDhOYm1WT0FzNkU2WGVWT0orcVh0cVhsV0hhc2doOW44?=
 =?utf-8?B?SG5RZEV6V2UyeHdENTFkWktqcW1KS2lqUU03QmtaY3NIZmV3ZHhoMFEwOGRv?=
 =?utf-8?B?NU1mT0xwZTBKS3lTZy9uc002bjcwbWIrRlBiWExhS0RPeG5iU2lFMHhFYjhS?=
 =?utf-8?B?dW9lVjdNZTNkVGRkanlrQi80VDJPZnJRdlFxamtNWXRMcDJhUTN4QjJRamRh?=
 =?utf-8?Q?tSGI=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:37:52.3564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be5b5ed3-62da-435e-b3b4-08de4d0fa52c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997688
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

Hi Bryan, Andrew

On 05/01/26 22:49, Andrew Davis wrote:
> On 1/5/26 8:11 AM, Bryan Brattlof wrote:
>> On December 31, 2025 thus sayeth Beleswar Padhi:
>>> Up until now, the R5 SPL in J722S platform was configured to start out
>>> of the SMS0_HSM_SRAM0_0 (0x0043C00000, 512KB) memory region. However,
>>> with the requirement of loading HSM M4F core with its own secure
>>> firmware, R5 SPL can no longer utilize that memory to execute itself.
>>>
>>> Therefore, utilize the MSRAM8KX256E0_RAM (0x0043C40000, 256KB) memory
>>> region for loading and executing R5 SPL. Naturally, the SPL size has now
>>> to be trimmed to be fit inside the smaller 256KB region.
>>>
>>> As an example, create a new defconfig (j722s_evm_r5_hsmboot_defconfig)
>>> which removes the SPI related configs to trim down the SPL size to
>>> ~175KB. The above defconfig demonstrates loading HSM core with SD, eMMC
>>> and UART bootmodes.
>>
>> I am worried we will need to find a better way to handle the defconfigs
>> which are mainly here for testing things. I agree we should have a way
>> to test this driver but if we go this route we will have too many
>> defconfigs and build instructions for each evaluation board to get our
>> code coverage to the levels we want.
>>
>> And it really only confuses people who are getting started.
>>
>

Agreed, not a fan of creating multiple defconfigs too, But...

> +1
>
> Using the SMS_HSM_SRAM for the R5 SPL was always a bit hacky, might be
> better to move the default defconfig over to using MSRAM for R5 SPL. 


...won't that effect backward compat if we disable some configs?

> This
> would of course mean we have to shrink it down a bit, but the Sitara
> platforms get by with as much SRAM without much issue already.
>
> How far is the current R5 SPL on J722S from fitting in MSRAM currently?


It's not just R5 SPL but also it's required stack, heap, BSS, global data
and Scratchpad area. Adding all those we get ~270KB bin. Whereas
our MSRAM is 256KB.

So a bloat of ~14KB.

Thanks,
Beleswar

>
> Andrew
>
>> ~Bryan
>>
>
