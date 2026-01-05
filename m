Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF19CC79FA7
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 17:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3D7583D7A;
	Mon,  5 Jan 2026 18:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="i8WKrKNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1C5F83A26; Mon,  5 Jan 2026 18:19:57 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E7E583D8A
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 18:19:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYn0nwa93b8A6+x0rcmKINMDBNSlmIAT0S5UbFAUmV+sEJXKp8fdAaA4Pd/7fWxPFpHVx8bici72yUaP7fWzcgUfOMJ7KHzFOna1g3e3/tepJLnA2lFdJWgOEuNGgvSJ+bIqfT97obrjLTdyvRVWiYFDEXBibCzdR1HmpT3N7kEhjmBSjNTiEHndkM26IpKebe9DUidRQ5pL75xDoj9WayRViI6UoQVsCYlQMHBbcZaHUBeiMtCWMyvgsu6cvowQTTqxHOVS4z5PTIzK/mHUlpeq+LrPqNROS5QpyAiMQNk33tMDWexIjTjEB6/+6svnKMeDPJU1p5PffjRzAoAXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Fk11wmhftDs5ZfoIUI3qwadRY2SklhO7ui2ztLH6sE=;
 b=r8q8+s6G9muOI6J54q4y5U1+kM58oMv1CUhywkcUmkNp42IOT9UrBMWIObuovGnvggkNI4gBUnj6jn821KvACirgZwTigWp4Yg4/4aCdiKex343PusWxkn6FT2vXSKixW2fIcWiMYHv0w61RjVgCD/V39KIc1ZVGp1M8/UU3/jUY5TZ0It7aSeWOmEYHyrv9UhzeZVcjh0/GmktRBHqq4GbLB8lPj16BM1QuNn9jgZAYRFLwhXLmI1JN9E+2/TpN907NoOgkKM8gGE18RjKfWJdayHAUKjRMBhrAjzgs/7Z7nW5+bV1ydN46vPnljWUHKRTkiGphhpT2ZOlU0tNTMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Fk11wmhftDs5ZfoIUI3qwadRY2SklhO7ui2ztLH6sE=;
 b=i8WKrKNyYc9gg3JWf/VDaJkZbh0Jccx02Z6+n1aQRrQj4wLGe3a7YNLIfZnMvfg3Ufs6hr0YXu2jJw/losxfvQ8qNtHx9ZYA8E6Kg+6qblT838wJDGQLoGzlUcDwlkdijqCUPgr5dM0cIixaXBFXNm4v8xE4SzrH2fwgteiiu4s=
Received: from CY5PR18CA0033.namprd18.prod.outlook.com (2603:10b6:930:13::16)
 by IA1PR10MB8211.namprd10.prod.outlook.com (2603:10b6:208:463::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 17:19:53 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:13:cafe::5c) by CY5PR18CA0033.outlook.office365.com
 (2603:10b6:930:13::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon, 5
 Jan 2026 17:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 17:19:52 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 11:19:50 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 11:19:49 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 5 Jan 2026 11:19:49 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 605HJnC61520463;
 Mon, 5 Jan 2026 11:19:49 -0600
Message-ID: <f30315f1-484c-4350-b1f4-e3927c62b4dc@ti.com>
Date: Mon, 5 Jan 2026 11:19:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] configs: j722s_evm_r5_hsmboot: Add new defconfig
 to show HSM boot
To: Bryan Brattlof <bb@ti.com>, Beleswar Padhi <b-padhi@ti.com>
CC: <trini@konsulko.com>, <anshuld@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
 <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20251231173621.1069988-1-b-padhi@ti.com>
 <20251231173621.1069988-12-b-padhi@ti.com>
 <20260105141105.ykq2uaelapfqb2m2@bryanbrattlof.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260105141105.ykq2uaelapfqb2m2@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|IA1PR10MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 1def2b2c-f562-4bca-bbce-08de4c7ea364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0JLQmFpbWx5Q3FvSk5hUTRZUjRPTytuZGF0YzNCa3lLZFJ1WUg1K29lK1Iv?=
 =?utf-8?B?ZTNINFIzM1o0SnBXOVpjRklSRWpMeGdCRnFpakpHK0VXcERrd2p5T0Q4dG9K?=
 =?utf-8?B?bWdmSVZZc1dpMlFJcXpqV3JnRTloVS9IZFFIZm5zdjk4YndVa0dWZ2x3RWty?=
 =?utf-8?B?RU9rZ081K2ZSMmx6RWZtSzZPWlNOSEgyQ0JJemhpN1RFcFpnaDA0clZnb3E3?=
 =?utf-8?B?Ym1NTUkvbFdmUDFDU2haRlN2Y2dOZWVGaGJOM2pjSWJsZUdDZk9PN1krelEw?=
 =?utf-8?B?R0tlTEFOVlRKcmZUa3V0aVFPQ1NzbWRNMVdHK0ZqZnA4Ly90aEMvNVZ0aE80?=
 =?utf-8?B?RmdpUDV0c3krV1N3TkpSZHVSVTNKb25USjVaMVZ2cjA5K3FXbWFnNkpsM2Vm?=
 =?utf-8?B?TTlLUm04RmxhQXVIRjhicXpydm9pdzFkTW8zWG9hOGNyYzhHSCtIZDNwdi9W?=
 =?utf-8?B?ampMTU1iVUlXSmh1SC9sUjlNOWpWaEliMWFza1lIbG5PVHdzRldrWWZnSjh5?=
 =?utf-8?B?UWphL3pKS2tmYTQ0WktLalVwYVk3WU1ZWVVBZHg2VGl5YytIeHZBTjF1b3BS?=
 =?utf-8?B?TEhTTVlLUkNDeGhHazhOaEZEM1M3eUZjSDhycUxsN0lVM1U2S00rRlVISlhX?=
 =?utf-8?B?UXRhRWNQRHFUNzlsYXhRdVlLaVlzVjJPOStVbVdLbTdoMFZ5NWVqa0k1dkRR?=
 =?utf-8?B?cW56VVdsakdCOGZkRHRZd0tQTUxLcStvT1hVd0VSRGIzNG10MWJLaGQreTl0?=
 =?utf-8?B?ZGd6S1hNZ0RobGdKa0IxQ3JKd2VZRW0wVWhSMC8yb3UwejFGbE00dzdxbit3?=
 =?utf-8?B?L2ZRSi96Z3NXekVmTzh5NmxTYlU4VFB1UmQ1d1BZbWpOdVJzdm5yWkxrZEp1?=
 =?utf-8?B?M1JoaWREL2Y0Q0J2N0pKbjJSK2RmZ2ZNeVFaaU5vODRNZUcyellyOGxhcDN4?=
 =?utf-8?B?ZzFpTFZra21RZzZtckZVT09LRTNLNk4vL25FM0sydk4rUFZPS1NIWVJPVlA0?=
 =?utf-8?B?a1N1Vk9qVFVhNDZobkhobXYzMGZhK3lNYWhXV3REcnZnM1IxMXBtM0VKVEtm?=
 =?utf-8?B?NUY5UEJnM1JmV3NVRHpLVEZlb1huZnZFSVlPSURyNmN6WHd0OHlTWlFuZHJj?=
 =?utf-8?B?TlhESUFTbWZLcStEK2pBamJ3L09ObERKZlZDM1hvV0hYYmtYTzFzbW5ZeWRM?=
 =?utf-8?B?MVduRURlQ1Q5bDZRVDJpTEd4ZmNXWmJDcWM4Znd5cWd5SzIrbmpPOC83b3do?=
 =?utf-8?B?c2ZNL1NsNXB2d0RkS2F3NUwxRC83WktzT1paYVZRMkVZLzlXSUEzMWpPNGVJ?=
 =?utf-8?B?d3NMWWJETFdnVWE4emJoMHBKQUNWOHVBMHJGeTA4TnFiQVV5bE14eWFBK1Uw?=
 =?utf-8?B?SE92TmNrT08wVU9HVDRwcjRBS0VMRjNib01xdUJnZHJJNTNnS29EUXZ1Vkpi?=
 =?utf-8?B?NzY2dUQyRFJlVlQwOE9RRWc5Ui9oYkxNU2U0OVlMSDRaTmQzd3ZHbGw1SENm?=
 =?utf-8?B?ckdTU3JVVlMzR1pPRnEwdWlYN08xaGdzOVgvTDJwZi9KUnE1c1ZwQlA4WHAx?=
 =?utf-8?B?ZFFmY1R0cXQxZWREUFlFMFhZQi9EeUcxZkFxTG4yc1QzMHlXNURsZmpyMVkz?=
 =?utf-8?B?alBRODB0dXJsYU1Ud1BIVHMyMnFPNC9weXhzUkZLbVI2N3poOUZadkpuS0dq?=
 =?utf-8?B?SUJCMXFPcFU3WkZsVFZZRCtpcm1jdnJoSzFvZjk4cTNBb3gyTFd2bTM4NFhU?=
 =?utf-8?B?WFJCQ0ZYbXp3Q0cwODM2VVd5YW05bzBKTkUzd3pxSUQ3S0NjSmFBOUdNWWg5?=
 =?utf-8?B?djU1OVN0ZEtVQlQwYUxuQTNNRi9XOUhjTE10cnF3UFdHZ2FNL2pvdmNUOW1n?=
 =?utf-8?B?WU84NWpFU0h6VXBING5aZmp6N0RtczJTUUxXanh1OE0vakdaSW12M1BwSHpw?=
 =?utf-8?B?bFhyU0wybGl0OVIzYUp1L0tlZFFkRFkyc2FkYWJEZDkxZGViNHA1OEpRTE5L?=
 =?utf-8?B?TjYyL2tJODV1czhTclRweWFkdVV4a3RIeVNSc08vM2RvdEVhQ0dDcVRWVVdJ?=
 =?utf-8?B?ZS9oVkNqWlpBNGpobzR3Y2J4U3U4ZmxlY3ZyVG0vUmczTnRCczFqT0NaNHZa?=
 =?utf-8?Q?1DnM=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 17:19:52.3520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1def2b2c-f562-4bca-bbce-08de4c7ea364
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB8211
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

On 1/5/26 8:11 AM, Bryan Brattlof wrote:
> On December 31, 2025 thus sayeth Beleswar Padhi:
>> Up until now, the R5 SPL in J722S platform was configured to start out
>> of the SMS0_HSM_SRAM0_0 (0x0043C00000, 512KB) memory region. However,
>> with the requirement of loading HSM M4F core with its own secure
>> firmware, R5 SPL can no longer utilize that memory to execute itself.
>>
>> Therefore, utilize the MSRAM8KX256E0_RAM (0x0043C40000, 256KB) memory
>> region for loading and executing R5 SPL. Naturally, the SPL size has now
>> to be trimmed to be fit inside the smaller 256KB region.
>>
>> As an example, create a new defconfig (j722s_evm_r5_hsmboot_defconfig)
>> which removes the SPI related configs to trim down the SPL size to
>> ~175KB. The above defconfig demonstrates loading HSM core with SD, eMMC
>> and UART bootmodes.
> 
> I am worried we will need to find a better way to handle the defconfigs
> which are mainly here for testing things. I agree we should have a way
> to test this driver but if we go this route we will have too many
> defconfigs and build instructions for each evaluation board to get our
> code coverage to the levels we want.
> 
> And it really only confuses people who are getting started.
> 

+1

Using the SMS_HSM_SRAM for the R5 SPL was always a bit hacky, might be
better to move the default defconfig over to using MSRAM for R5 SPL. This
would of course mean we have to shrink it down a bit, but the Sitara
platforms get by with as much SRAM without much issue already.

How far is the current R5 SPL on J722S from fitting in MSRAM currently?

Andrew

> ~Bryan
> 

