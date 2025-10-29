Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D12CCCF9EE
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 18:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 041558004F;
	Wed, 29 Oct 2025 19:16:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="D2B35jor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90731800B6; Wed, 29 Oct 2025 19:16:24 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFB948003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 19:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIggiF4ZN6NVrMWa2IOxO8d+VSoT1hVYcNy6mqDvLp21fE1e9Jfwu5lKUnmFIbrFWf9qBmWrMk5oqxB8kLh/xXN2giDfHtIHrGBr/oC+RAf5k7+yAmnXImBVlQOOeHrHB542PpPu+nbjoNGwunq3J5OUO4pzSkQOCbntGKg1Uwbv9U4r3ACoi9DodYbOnhdqaef/Oyql+xPGp6fLDLhWBtRPIsdeBAjVA9x7KqnaC/l5DZJmU85s39lQYNpiK32Gcz5c1PHpFcL0LWUTb/wmpMC8WZcJZTuol3smaDJWH8REdBzXYgvp7cZFvoespjb2E58UmZ3+SThiOlsDVsjtWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WUD6pZ9CAbifkNgNnVC2zvif08I/lhWwmGaOYhCxMw=;
 b=cTOIDK6alb2yqjBLCpbdttEHKK30WxUN3rXRgOf5o/+rCgDxPHr0SGJOhKjnuMJmnvXnz2jFxaJp2c2WODxGb4IRriggNoG3apBp/zpIvdToM5Xk0wz/eMundm5X8drYkdCPe17yNy+VIoGjzZXEoftNgAAIHop15NPXWRq+yh0ZKlRbM91dAhOkz9zu71IaEapey09eqzzgkiGbnAJwauLOeOvamQBrHwCCRiPf5ze9+hEp/lpY68hD2Ny5gRNttO6QI/XUS7PIn76oowzqm0SauIOLWPteuga0FX9uwqUEs267Lsmb3bXe9zwfRF+w8nm5MqEQJjBsru80Dy7m5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WUD6pZ9CAbifkNgNnVC2zvif08I/lhWwmGaOYhCxMw=;
 b=D2B35jorkyr8F6lYaXglIn37vRtF3cQfYlUznnBVkDjWYT6tl2zgrUyACK4qok5+0tuGOEdv2DMj7hjoF30+ncFKu7utr+n148aHRbxLQu7Cfzl6pENWrE/Z3OyQUu8itwy2CFpWGS3b8CeskvbGeaqBvEQ5f9gQLYQlUb8DaAk=
Received: from DM6PR06CA0079.namprd06.prod.outlook.com (2603:10b6:5:336::12)
 by IA1PR10MB7115.namprd10.prod.outlook.com (2603:10b6:208:3f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 18:16:16 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::9d) by DM6PR06CA0079.outlook.office365.com
 (2603:10b6:5:336::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 18:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 18:16:15 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 13:16:12 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 13:16:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Oct 2025 13:16:11 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59TIGB27299280;
 Wed, 29 Oct 2025 13:16:11 -0500
Message-ID: <f31edd75-97a4-46b7-acf9-6513a9125a4e@ti.com>
Date: Wed, 29 Oct 2025 13:16:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] doc: ti: document R5 falcon mode for AM62 platforms
To: Anshul Dalal <anshuld@ti.com>
CC: <b-liu@ti.com>, <bb@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <nm@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>
References: <20251027130004.2156121-1-anshuld@ti.com>
 <20251027130004.2156121-9-anshuld@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251027130004.2156121-9-anshuld@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA1PR10MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b90db36-5dc1-48a3-2102-08de17173fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|34020700016|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3BTeHk5V0RUbng4cG1GUko4cjJVUWJOVmhiM3N5VXNPc2YxL3p2MUVyL29T?=
 =?utf-8?B?TjZ2RmpjUjNaY2o0bzdXV0dTMGdpWklqVVc4TmlPN1NJU0xSWUJHeitBWWZR?=
 =?utf-8?B?MnBNZUI1ZGlXSUFxZDZXT0FIbHVZeGRGb245LzZKVmdaWmVncXVrRktzNnAy?=
 =?utf-8?B?dTBKUnZaNVdpZk5Wa2R3MXlZOU5CSi85cnpKYnJqYzNvTFJwdWV0NGZ1NHQ1?=
 =?utf-8?B?N2dwYnZBOE02dEhaUHZVenpnZTFvNC9zNmZmRVgvdlpydGw2ai9ueHZESjZI?=
 =?utf-8?B?NStWajBrbGdOcUE5V0k2cURxdVlFTEtJR2pqeU1PWWh5c25KNmMvT0FXakdF?=
 =?utf-8?B?M1dVWm9pdnFWS0lEcUdTdExaWTBTbjRsdXVMV2w0d3NTdkFGV200Y3JLK1Ry?=
 =?utf-8?B?RE4zazc4aW0rUDdsSk9tM2NyNUhFNjNCZ1c2V2UwK3VuRG5wMzJFM1k5ZkhQ?=
 =?utf-8?B?aFBxajAwYUtpSG5PTzNUZnZTWXV3VlN4OVpVWklzZjhodWkxLysvL3hzelpY?=
 =?utf-8?B?YVpJaUhGeHRhV3pmdVBmRUN0VW80S2lsZzJkOUNzZldKV3hHN28zdVhPcGhh?=
 =?utf-8?B?OUdsSEU4ZGk0MHhCWVE4N2pLL0lDQS9ib0RXWUdEWXhUb0R1QzZqRTdlRzdE?=
 =?utf-8?B?bEJxbCtSeGNNM1NVeGdFNEc4WTBRbmVNeEh2RW8wdkRBRW9CenN4cU90eHA5?=
 =?utf-8?B?RGxyRmJVZkliV0NBcFpkeEN4MDJTeVV0SlZhYXNZZk1qUHI5VUY0dTN2ZElE?=
 =?utf-8?B?QWhLOWNQVXUxYmRRV016UkhwSXBtbWRwdjB1R29zb29mYWVBTU9SUzVOclJz?=
 =?utf-8?B?VzRBMWJQUno0WERHdnRJRHpUSnI5Z0JOTzZlQmIrcXU3Y1hLKy9Jc2hxSFk1?=
 =?utf-8?B?aGtGTWhIZWdHNm5pcStuU1MrWjQ0dTl0bHJ0TS9SaW9kVzdUYUdrVUhMS2VS?=
 =?utf-8?B?ak9tYzlzZXJHeWJaTStKeURGLzE2aHQ4WUxpalRTVGVMVjNvUjBPTkszR3Ft?=
 =?utf-8?B?V2dYeFA1V1Q4emxFbkhNSkhiZTlEd29SeHBwclNjeXZ3YUZZeUd2Y1p6NnZ4?=
 =?utf-8?B?My84SXJDVWRXVlNXaEdlZi9DazFJMVVrK1psUDNrQUNMazZpdE1XcUVlbFBQ?=
 =?utf-8?B?bEM2eGIxbms2Rm1vYmtNcWFPMU1Ub0tOak1lRXdmeU5waTZ5aThzcEdjUW5D?=
 =?utf-8?B?U05BMkYyQ3BCai85azJlQit1dUVVcDhEL1ZkQkdvaWs1TVo1THpxalM0WFNo?=
 =?utf-8?B?WUM1dWtFRGE0ZUppR3VBY0kzUUVENFdhazhQeDMzbHlvRitpM1Z0QndvNUdq?=
 =?utf-8?B?UU1UNlRseWMvUnVhbG9ibThBOTU1K2VNaURyL2FKcmhHSXpPcmFBNXU3dEVa?=
 =?utf-8?B?eXFoZDllc2JrRjJpVWR4VGQ4Nkt6WHlTYkRDTmVzWm54S2VkTHJ0bWtqVU45?=
 =?utf-8?B?Q0VaSGpxSXVYWFl3bThvdGhFMU1SUHVvM0hzck0xNGUySVpXeVdSelJNRmRm?=
 =?utf-8?B?QzVuQ203a3hOKzlXbnl4eTNNWExiaXJCMEJ2ZlVVanRYR3VYc3NNYmxRd1Aw?=
 =?utf-8?B?VVduak5kVFlNQ1hNYkhiRzZYU0k4Ti8wUnFGTGhUcU5GKy82NVVTSE5zN1lI?=
 =?utf-8?B?RFA1OEd0VFRGMGtiNzBpUG52SVdVYUpiTm5XQXIzN2pGdjZTenZhS3FtMU9N?=
 =?utf-8?B?RE0vZ0x2VnErZnNEblI1dml1Z0c4RlI1SU1ZekRSaExnMEpoNXRxeUx2VEx4?=
 =?utf-8?B?NFI1K2dHaUk3ZVdpUlFDS2VuQTY5KzFQMjRwdkI5YjNOZUVDTHpFMEp1aThU?=
 =?utf-8?B?emZLdGQvS3ZxNlJJRUhYSDdidnpyNjJuRHBmTnlGNmlDbDFQVWVENU1uS1I2?=
 =?utf-8?B?NEhod3E2VDNSVDZzWHRRZ3o1M0VQSXVaRUVuS0RlOXVESndCVks1R2dGQXJi?=
 =?utf-8?B?d1Z0OVlUQ2RWTDltcmkvYXh1QmhmQjNXT1FQUjlhbzFaYURqZUxqWHFWV29y?=
 =?utf-8?Q?zFHC7UbypA8x1QpO0aAacyo89e8ghc=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(34020700016)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 18:16:15.5800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b90db36-5dc1-48a3-2102-08de17173fe3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7115
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

On 10/27/25 8:00 AM, Anshul Dalal wrote:
> This patch adds user documentation for falcon boot for AM62 platforms.
> The main section is added to am62x_sk.rst and other documents just
> include the section. Steps to build falcon support, usage and the
> modified R5 memory map have been documented.
> 
> Two svg images have also been added for reference, one for the modified
> tifalcon.bin and other for the falcon specific fitImage format.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>   doc/board/ti/am62ax_sk.rst                    |  35 ++
>   doc/board/ti/am62px_sk.rst                    |  35 ++
>   doc/board/ti/am62x_sk.rst                     | 303 ++++++++++++++++++
>   doc/board/ti/img/fitImage_falcon.svg          | 180 +++++++++++
>   doc/board/ti/img/tifsstub_dm_tifalcon.bin.svg | 285 ++++++++++++++++
>   5 files changed, 838 insertions(+)
>   create mode 100644 doc/board/ti/img/fitImage_falcon.svg
>   create mode 100644 doc/board/ti/img/tifsstub_dm_tifalcon.bin.svg
> 
> diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
> index 4dd998bcce9..45992ec304b 100644
> --- a/doc/board/ti/am62ax_sk.rst
> +++ b/doc/board/ti/am62ax_sk.rst
> @@ -187,6 +187,41 @@ https://www.ti.com/lit/pdf/spruj16 under the `Boot Mode Pins` section.
>   
>   For SW2 and SW1, the switch state in the "ON" position = 1.
>   
> +Falcon Mode
> +-----------
> +
> +Falcon Mode on AM62ax platforms bypasses the A53 SPL and U-Boot with the overall
> +boot flow as below:
> +
> +**Normal boot flow:**
> +
> +* R5 SPL -> TFA -> OP-TEE -> A53 SPL -> U-Boot -> Kernel

It might be good to point out that the TFA and after is on a different
core than the R5 SPL, it might be obvious to us based on names, but
never hurts to make flow graph match, and also in some way show the
file names that contain the different parts, maybe somehting like:



         | tiboot3.bin |          tispl.bin       |  u-boot.img  |  Image  |
         |             |                          |              |         |
R5 Core      SPL
-------         \
A53 Core          -- -> TFA -> OP-TEE -> A53 SPL  --> U-Boot  -->  Kernel


Also if this section is the same for all these boards, could it also
be factored out into am62x_sk.rst?

Andrew

> +
> +**With falcon mode:**
> +
> +* R5 SPL -> TFA -> OP-TEE -> Kernel
> +
> +Build Process
> +^^^^^^^^^^^^^
> +
> +.. include:: ../ti/am62x_sk.rst
> +    :start-after: .. am62x_evm_falcon_start_build_process
> +    :end-before: .. am62x_evm_falcon_end_build_process
> +
> +Usage
> +^^^^^
> +
> +.. include:: ../ti/am62x_sk.rst
> +    :start-after: .. am62x_evm_falcon_start_usage
> +    :end-before: .. am62x_evm_falcon_end_usage
> +
> +R5 SPL Memory Map
> +^^^^^^^^^^^^^^^^^
> +
> +.. include:: ../ti/am62x_sk.rst
> +    :start-after: .. am62x_evm_falcon_start_r5_memory_map
> +    :end-before: .. am62x_evm_falcon_end_r5_memory_map
> +
>   Debugging U-Boot
>   ----------------
>   
> diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
> index a07d6a4da45..c13d991e1a3 100644
> --- a/doc/board/ti/am62px_sk.rst
> +++ b/doc/board/ti/am62px_sk.rst
> @@ -290,6 +290,41 @@ https://www.ti.com/lit/pdf/spruj83 under the `Boot Mode Pins` section.
>   
>   For SW2 and SW1, the switch state in the "ON" position = 1.
>   
> +Falcon Mode
> +-----------
> +
> +Falcon Mode on AM62px platforms bypasses the A53 SPL and U-Boot with the overall
> +boot flow as below:
> +
> +**Normal boot flow:**
> +
> +* R5 SPL -> TFA -> OP-TEE -> A53 SPL -> U-Boot -> Kernel
> +
> +**With falcon mode:**
> +
> +* R5 SPL -> TFA -> OP-TEE -> Kernel
> +
> +Build Process
> +^^^^^^^^^^^^^
> +
> +.. include:: ../ti/am62x_sk.rst
> +    :start-after: .. am62x_evm_falcon_start_build_process
> +    :end-before: .. am62x_evm_falcon_end_build_process
> +
> +Usage
> +^^^^^
> +
> +.. include:: ../ti/am62x_sk.rst
> +    :start-after: .. am62x_evm_falcon_start_usage
> +    :end-before: .. am62x_evm_falcon_end_usage
> +
> +R5 SPL Memory Map
> +^^^^^^^^^^^^^^^^^
> +
> +.. include:: ../ti/am62x_sk.rst
> +    :start-after: .. am62x_evm_falcon_start_r5_memory_map
> +    :end-before: .. am62x_evm_falcon_end_r5_memory_map
> +
>   Debugging U-Boot
>   ----------------
>   
> diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
> index dab2970a85c..62f68fa40de 100644
> --- a/doc/board/ti/am62x_sk.rst
> +++ b/doc/board/ti/am62x_sk.rst
> @@ -526,6 +526,309 @@ Next, based on NET_VCI_STRING string mentioned in respective defconfig file `tib
>   fetches `tispl.bin` and then `tispl.bin` fetches `u-boot.img` from TFTP server which
>   completes Ethernet boot on the device.
>   
> +Falcon Mode
> +-----------
> +
> +Falcon Mode on AM62x platforms bypasses the A53 SPL and U-Boot with the overall
> +boot flow as below:
> +
> +**Normal boot flow:**
> +
> +* R5 SPL -> TFA -> OP-TEE -> A53 SPL -> U-Boot -> Kernel
> +
> +**With falcon mode:**
> +
> +* R5 SPL -> TFA -> OP-TEE -> Kernel
> +
> +Build Process
> +^^^^^^^^^^^^^
> +
> +.. am62x_evm_falcon_start_build_process
> +
> +Enabling falcon mode requires re-building TFA, U-Boot and the kernel
> +``fitImage`` as follows:
> +
> +0. Setup environment variables:
> +"""""""""""""""""""""""""""""""
> +
> +Refer to the build procedure above for setting up the environment variables.
> +
> +1. Trusted Firmware-A:
> +""""""""""""""""""""""
> +
> +The R5 SPL in falcon mode loads the kernel at ``0x82000000`` and the
> +corresponding DTB at ``0x88000000``. Therefore TFA needs to be rebuild with
> +changes to the respective addresses.
> +
> +.. prompt:: bash $
> +
> + # Change load addresses for the kernel and DTB
> + export TFA_EXTRA_ARGS="PRELOADED_BL33_BASE=0x82000000 K3_HW_CONFIG_BASE=0x88000000"
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_tfa
> +    :end-before: .. k3_rst_include_end_build_steps_tfa
> +
> +2. U-Boot:
> +""""""""""
> +
> +* **2.1 R5:**
> +
> +.. prompt:: bash $
> +
> + # use the common falcon config fragment for all k3 platforms
> + export $UBOOT_FALCON_CFG_FRAGMENTR="k3_r5_falcon.config"
> + export UBOOT_CFG_CORTEXR="${UBOOT_CFG_CORTEXR} ${UBOOT_FALCON_CFG_FRAGMENTR}"
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_spl_r5
> +    :end-before: .. k3_rst_include_end_build_steps_spl_r5
> +
> +* **2.2 A53:**
> +
> +After rebuilding TFA, the binary needs to be repackaged inside the tispl
> +binaries:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_uboot
> +    :end-before: .. k3_rst_include_end_build_steps_uboot
> +
> +3. fitImage:
> +""""""""""""
> +
> +.. warning::
> +
> +    The ``fitImage`` available by default under ``boot/fitImage`` in rootfs of
> +    the standard SDK release is not compatible with falcon mode.
> +
> +For secure boot in falcon mode, the compute heavy authentication required for
> +the ``fitImage`` is offloaded from the slower R5 core to TIFS. This requires
> +``fitImage`` to package the necessary binaries (kernel and dtb) with a
> +pre-signed x509 certificate.
> +
> +**fitImage for falcon mode:**
> +
> +.. image:: img/fitImage_falcon.svg
> +  :alt: fitImage for falcon boot image format
> +
> +* **Sources**
> +
> +  * **Core Secdev K3**
> +
> +    | **source:** https://git.ti.com/cgit/security-development-tools/core-secdev-k3
> +    | **branch:** master
> +
> +**Follow the steps below to create a falcon compatible fitImage:**
> +
> +**3.1 Environment setup**
> +
> +.. prompt:: bash $
> +
> +  export DTB=path/to/dtb
> +  export IMAGE=path/to/kernel-image
> +
> +**3.2 fitImage creation**
> +
> +  An Image tree source (*its*) file describes the structure and contents of the
> +  final image produced by the ``mkimage`` tool.
> +
> +  To create the ``fitImage`` for falcon mode, create a file ``fitImage.its``
> +  with the following contents inside the ``core-secdev-k3`` source directory,:
> +
> +.. code-block:: dts
> +
> +    /dts-v1/;
> +
> +    / {
> +        description = "Kernel fitImage";
> +        #address-cells = <1>;
> +
> +        images {
> +            kernel-sec {
> +                description = "Linux kernel";
> +                data = /incbin/("Image.sec");
> +                type = "kernel";
> +                arch = "arm64";
> +                os = "linux";
> +                compression = "none";
> +                load = <0x82000000>;
> +                entry = <0x82000000>;
> +            };
> +
> +            fdt-sec {
> +                description = "Flattened Device Tree blob";
> +                data = /incbin/("falcon.dtb.sec");
> +                type = "flat_dt";
> +                arch = "arm64";
> +                compression = "none";
> +                load = <0x88000000>;
> +                entry = <0x88000000>;
> +            };
> +        };
> +
> +        configurations {
> +            default = "conf-falcon";
> +            conf-falcon {
> +                description = "Pre-signed Linux kernel, FDT blob";
> +                kernel = "kernel-sec";
> +                fdt = "fdt-sec";
> +            };
> +        };
> +    };
> +
> +Sign the kernel and dtb using ``secure-binary-image.sh`` and create the
> +``fitImage`` using mkimage:
> +
> +.. prompt:: bash $
> +
> +  # inside core-secdev-k3 source
> +  cp $IMAGE Image
> +  cp $DTB falcon.dtb
> +  ./scripts/secure-binary-image.sh Image Image.sec
> +  ./scripts/secure-binary-image.sh falcon.dtb falcon.dtb.sec
> +  mkimage -f fitImage.its fitImage
> +
> +.. am62x_evm_falcon_end_build_process
> +
> +Usage
> +^^^^^
> +
> +.. am62x_evm_falcon_start_usage
> +
> +Falcon Mode makes use of a cut down variant of the tispl binary called
> +``tifalcon.bin`` with lacks the Cortex-A SPL and it's DTBs. This file should
> +be present alongside the existing ``tispl.bin`` after building U-Boot for the
> +Cortex-A core.
> +
> +- **tifalcon.bin**
> +
> +.. image:: img/tifsstub_dm_tifalcon.bin.svg
> +  :alt: tifalcon.bin image format
> +
> +The R5 SPL requires both ``tifalcon.bin`` and the ``fitImage`` (created
> +in previous steps) to be present in the second partition of the MMC device
> +specified by the ``mmcdev`` environment variable. By default, ``mmcdev`` is
> +set to 1, which implies that the SD card is the boot media. Additionally, the
> +``bootpart`` environment variable, which defaults to 1:2, specifies that the
> +second partition of the SD card should be used as the root file system for the
> +kernel.
> +
> +To use eMMC instead of SD as the boot media, rebuild the R5 SPL with the
> +following diff:
> +
> +.. code-block:: diff
> +
> +    diff --git a/board/ti/<soc>/<soc>.env b/board/ti/<soc>/<soc>.env
> +    index 82b9f0741bb..73d59ac425c 100644
> +    --- a/board/ti/<soc>/<soc>.env
> +    +++ b/board/ti/<soc>/<soc>.env
> +    @@ -17,8 +17,8 @@ run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
> +
> +     boot_targets=mmc1 mmc0 usb pxe dhcp
> +     boot=mmc
> +    -mmcdev=1
> +    -bootpart=1:2
> +    +mmcdev=0
> +    +bootpart=0:1
> +     bootdir=/boot
> +     rd_spec=-
> +
> +**List of files required on SD/eMMC for Falcon Mode:**
> +
> +.. list-table::
> +   :widths: 8 8 8 25
> +   :header-rows: 1
> +
> +   * - File
> +     - Copy path on SD/eMMC
> +     - Partition
> +     - Description
> +
> +   * - ``tifalcon.bin``
> +     - ``/boot/tifalcon.bin``
> +     - rootfs (ext4)
> +     - tispl binary without SPL for the A core and DTB
> +
> +   * - ``fitImage``
> +     - ``/boot/fitImage``
> +     - rootfs (ext4)
> +     - kernel and dtb fitImage with pre-signed binaries
> +
> +.. note::
> +
> +    Falcon mode requires the boot binaries to be present in the root file system
> +    of either eMMC or SD, even when using raw eMMC boot mode to load
> +    ``tiboot3.bin``.
> +
> +.. am62x_evm_falcon_end_usage
> +
> +R5 SPL Memory Map
> +^^^^^^^^^^^^^^^^^
> +
> +.. am62x_evm_falcon_start_r5_memory_map
> +
> +Standard Boot:
> +""""""""""""""
> +
> +.. code-block::
> +
> +    0x80000000 +===============================+ Start of DDR
> +      512KiB   |   TFA reserved memory space   | CONFIG_K3_ATF_LOAD_ADDR
> +               |                               |
> +    0x80080000 +-------------------------------+ PRELOADED_BL33_BASE in TFA
> +     29.5MiB   |         A53 SPL + DTB +       | CONFIG_SPL_LOAD_FIT_ADDRESS
> +               | Download region for FIT in DFU|
> +    0x81e00000 +-------------------------------+
> +               |  R5 U-Boot SPL Stack + Heap   |
> +        2MiB   |       (size defined by        |
> +               | SPL_STACK_R_MALLOC_SIMPLE_LEN)|
> +    0x82000000 +-------------------------------+ CONFIG_SPL_STACK_R_ADDR
> +      112MiB   |            Unused             |
> +    0x89000000 +-------------------------------+
> +      331MiB   | Device Manager (DM) Load Addr |
> +    0x9db00000 +-------------------------------+
> +       12MiB   |          DM Reserved          |
> +    0x9e700000 +-------------------------------+
> +        1MiB   |            Unused             |
> +    0x9e800000 +-------------------------------+ BL32_BASE in TFA
> +       24MiB   |             OPTEE             |
> +    0xa0000000 +===============================+ End of DDR (512MiB)
> +
> +Falcon Mode:
> +""""""""""""
> +
> +.. code-block::
> +
> +    0x80000000 +===============================+ Start of DDR
> +      512KiB   |   TFA reserved memory space   | CONFIG_K3_ATF_LOAD_ADDR
> +    0x80080000 +-------------------------------+
> +     31.5MiB   |            Unused             |
> +    0x82000000 +-------------------------------+ PRELOADED_BL33_BASE in TFA
> +               |                               | CONFIG_SYS_LOAD_ADDR
> +       57MiB   |   Kernel + initramfs Image    | CONFIG_SPL_LOAD_FIT_ADDRESS
> +               |                               |
> +    0x85900000 +-------------------------------+
> +               |                               |
> +               |  R5 U-Boot SPL Stack + Heap   |
> +       39MiB   |       (size defined by        |
> +               | SPL_STACK_R_MALLOC_SIMPLE_LEN)|
> +               |                               |
> +    0x88000000 +-------------------------------+ CONFIG_SPL_STACK_R_ADDR
> +               |                               | K3_HW_CONFIG_BASE in TFA
> +       16MiB   |          Kernel DTB           | CONFIG_SPL_PAYLOAD_ARGS_ADDR
> +               |                               |
> +    0x89000000 +-------------------------------+
> +      331MiB   | Device Manager (DM) Load Addr |
> +    0x9db00000 +-------------------------------+
> +       12MiB   |          DM Reserved          |
> +    0x9e700000 +-------------------------------+
> +        1MiB   |            Unused             |
> +    0x9e800000 +-------------------------------+ BL32_BASE in TFA
> +       24MiB   |             OPTEE             |
> +    0xa0000000 +===============================+ End of DDR (512MiB)
> +
> +.. am62x_evm_falcon_end_r5_memory_map
> +
>   Debugging U-Boot
>   ----------------
>   
> diff --git a/doc/board/ti/img/fitImage_falcon.svg b/doc/board/ti/img/fitImage_falcon.svg
> new file mode 100644
> index 00000000000..b5f0229397f
> --- /dev/null
> +++ b/doc/board/ti/img/fitImage_falcon.svg
> @@ -0,0 +1,180 @@
> +<?xml version="1.0" encoding="UTF-8" standalone="no"?>
> +<!-- SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause -->
> +
> +<!-- Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/ -->
> +
> +<svg
> +   version="1.1"
> +   width="231"
> +   height="220"
> +   viewBox="-0.5 -0.5 231 220"
> +   id="svg72"
> +   sodipodi:docname="fitImage_falcon.svg"
> +   inkscape:version="1.4.1 (93de688d07, 2025-03-30)"
> +   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
> +   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
> +   xmlns="http://www.w3.org/2000/svg"
> +   xmlns:svg="http://www.w3.org/2000/svg">
> +  <sodipodi:namedview
> +     id="namedview74"
> +     pagecolor="#ffffff"
> +     bordercolor="#666666"
> +     borderopacity="1.0"
> +     inkscape:pageshadow="2"
> +     inkscape:pageopacity="0.0"
> +     inkscape:pagecheckerboard="0"
> +     showgrid="false"
> +     inkscape:zoom="2.9"
> +     inkscape:cx="83.62069"
> +     inkscape:cy="131.72414"
> +     inkscape:window-width="1918"
> +     inkscape:window-height="1078"
> +     inkscape:window-x="0"
> +     inkscape:window-y="0"
> +     inkscape:window-maximized="0"
> +     inkscape:current-layer="g62"
> +     inkscape:showpageshadow="2"
> +     inkscape:deskcolor="#d1d1d1" />
> +  <defs
> +     id="defs2">
> +    <inkscape:perspective
> +       sodipodi:type="inkscape:persp3d"
> +       inkscape:vp_x="0 : 104.5 : 1"
> +       inkscape:vp_y="0 : 1000 : 0"
> +       inkscape:vp_z="231 : 104.5 : 1"
> +       inkscape:persp3d-origin="115.5 : 46 : 1"
> +       id="perspective1" />
> +  </defs>
> +  <g
> +     id="g62">
> +    <rect
> +       x="-0.06279549"
> +       y="-0.062792346"
> +       width="230.12561"
> +       height="219.12558"
> +       rx="34.518837"
> +       ry="27.33382"
> +       fill="#d5e8d4"
> +       stroke="#82b366"
> +       pointer-events="all"
> +       id="rect4"
> +       style="display:inline;fill:#dbe4f4;fill-opacity:1;stroke:#8166b3;stroke-width:0.888796;stroke-dasharray:none;stroke-opacity:1" />
> +    <text
> +       x="115.15599"
> +       y="156.49472"
> +       fill="#000000"
> +       font-family="Helvetica"
> +       font-size="12px"
> +       text-anchor="middle"
> +       id="text8-8-7-6-6"
> +       style="display:inline"
> +       inkscape:label="x509 cert">x509 Certificate</text>
> +    <text
> +       x="115.15598"
> +       y="85.615631"
> +       fill="#000000"
> +       font-family="Helvetica"
> +       font-size="12px"
> +       text-anchor="middle"
> +       id="text8-8-7-6-6-1"
> +       style="display:inline"
> +       inkscape:label="x509 cert">x509 Certificate</text>
> +    <text
> +       x="114.532"
> +       y="42.263863"
> +       fill="#000000"
> +       font-family="Helvetica"
> +       font-size="12px"
> +       text-anchor="middle"
> +       id="text8-8-7-6-6-5"
> +       style="display:inline"
> +       inkscape:label="x509 cert">Fit Header</text>
> +    <text
> +       x="114.78398"
> +       y="106.884"
> +       fill="#000000"
> +       font-family="Helvetica"
> +       font-size="12px"
> +       text-anchor="middle"
> +       id="text8-8-7-6-6-5-5"
> +       style="display:inline"
> +       inkscape:label="x509 cert">Kernel Image</text>
> +    <rect
> +       style="display:none;fill:#000000;fill-opacity:0;stroke:#000000;stroke-width:1.00157;stroke-dasharray:none;stroke-opacity:1"
> +       id="rect1"
> +       width="171.46796"
> +       height="210.89911"
> +       x="36.799908"
> +       y="21.652758"
> +       transform="translate(-7.533886,15.237117)" />
> +    <text
> +       xml:space="preserve"
> +       style="font-size:21.3333px;text-align:start;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:#db8c8c;fill-opacity:1;stroke:#000000;stroke-width:1.13386"
> +       x="90.327087"
> +       y="177.15775"
> +       id="text1"><tspan
> +         sodipodi:role="line"
> +         id="tspan1"
> +         x="90.327087"
> +         y="177.15775" /></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-size:21.3333px;text-align:start;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:#db8c8c;fill-opacity:1;stroke:#000000;stroke-width:1.13386"
> +       x="106.45526"
> +       y="214.93161"
> +       id="text2"><tspan
> +         sodipodi:role="line"
> +         id="tspan2"
> +         x="106.45526"
> +         y="214.93161" /></text>
> +    <g
> +       id="g62-6"
> +       transform="translate(-5.6022949,-9.676433)">
> +      <text
> +         x="120.33229"
> +         y="188.7475"
> +         fill="#000000"
> +         font-family="Helvetica"
> +         font-size="12px"
> +         text-anchor="middle"
> +         id="text8-8-7-6-6-5-2"
> +         style="display:inline"
> +         inkscape:label="x509 cert">DTB</text>
> +    </g>
> +    <rect
> +       style="fill:#db8c8c;fill-opacity:0;stroke:#000000;stroke-width:1.13386"
> +       id="rect2"
> +       width="82.644012"
> +       height="17.6518"
> +       x="73.677986"
> +       y="94.992081" />
> +    <rect
> +       style="fill:#db8c8c;fill-opacity:0;stroke:#000000;stroke-width:1.13386;stroke-dasharray:none"
> +       id="rect2-7"
> +       width="32.336376"
> +       height="18.068098"
> +       x="98.83181"
> +       y="165.66302" />
> +    <rect
> +       style="fill:#db8c8c;fill-opacity:0;stroke:#000000;stroke-width:1.77036;stroke-dasharray:none"
> +       id="rect3"
> +       width="152.43475"
> +       height="70.500725"
> +       x="38.782627"
> +       y="127.54861" />
> +    <rect
> +       style="fill:#db8c8c;fill-opacity:0;stroke:#000000;stroke-width:1.77036;stroke-dasharray:none"
> +       id="rect3-9"
> +       width="152.43475"
> +       height="70.500732"
> +       x="38.782623"
> +       y="56.777336" />
> +    <rect
> +       style="fill:#db8c8c;fill-opacity:0;stroke:#000000;stroke-width:1.78506;stroke-dasharray:none"
> +       id="rect5"
> +       width="152.41736"
> +       height="36.60006"
> +       x="38.791306"
> +       y="20.211617" />
> +  </g>
> +</svg>
> diff --git a/doc/board/ti/img/tifsstub_dm_tifalcon.bin.svg b/doc/board/ti/img/tifsstub_dm_tifalcon.bin.svg
> new file mode 100644
> index 00000000000..2508923d480
> --- /dev/null
> +++ b/doc/board/ti/img/tifsstub_dm_tifalcon.bin.svg
> @@ -0,0 +1,285 @@
> +<?xml version="1.0" encoding="UTF-8" standalone="no"?>
> +<!-- SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause -->
> +
> +<!-- Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/ -->
> +
> +<svg
> +   version="1.1"
> +   width="231"
> +   height="280"
> +   viewBox="-0.5 -0.5 231 280"
> +   id="svg72"
> +   sodipodi:docname="tifsstub_dm_tifalcon.bin.svg"
> +   inkscape:version="1.4.1 (93de688d07, 2025-03-30)"
> +   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
> +   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
> +   xmlns:xlink="http://www.w3.org/1999/xlink"
> +   xmlns="http://www.w3.org/2000/svg"
> +   xmlns:svg="http://www.w3.org/2000/svg"
> +   xmlns:xhtml="http://www.w3.org/1999/xhtml">
> +  <sodipodi:namedview
> +     id="namedview74"
> +     pagecolor="#ffffff"
> +     bordercolor="#666666"
> +     borderopacity="1.0"
> +     inkscape:pageshadow="2"
> +     inkscape:pageopacity="0.0"
> +     inkscape:pagecheckerboard="0"
> +     showgrid="false"
> +     inkscape:zoom="2.3561254"
> +     inkscape:cx="175.5"
> +     inkscape:cy="151.30774"
> +     inkscape:window-width="1920"
> +     inkscape:window-height="1080"
> +     inkscape:window-x="0"
> +     inkscape:window-y="0"
> +     inkscape:window-maximized="0"
> +     inkscape:current-layer="g62"
> +     inkscape:showpageshadow="2"
> +     inkscape:deskcolor="#d1d1d1" />
> +  <defs
> +     id="defs2">
> +    <inkscape:perspective
> +       sodipodi:type="inkscape:persp3d"
> +       inkscape:vp_x="0 : 104.5 : 1"
> +       inkscape:vp_y="0 : 1000 : 0"
> +       inkscape:vp_z="231 : 104.5 : 1"
> +       inkscape:persp3d-origin="115.5 : 46 : 1"
> +       id="perspective1" />
> +  </defs>
> +  <g
> +     id="g62">
> +    <rect
> +       x="-0.0064085587"
> +       y="-0.0064054145"
> +       width="230.01283"
> +       height="278.39682"
> +       rx="34.501923"
> +       ry="34.727341"
> +       fill="#d5e8d4"
> +       stroke="#82b366"
> +       pointer-events="all"
> +       id="rect4"
> +       style="stroke-width:1.00331" />
> +    <rect
> +       x="40"
> +       y="30"
> +       width="160"
> +       height="60"
> +       fill="none"
> +       stroke="#000000"
> +       pointer-events="all"
> +       id="rect6" />
> +    <g
> +       transform="translate(-0.5,-0.5)"
> +       id="g12">
> +      <switch
> +         id="switch10">
> +        <foreignObject
> +           style="overflow: visible; text-align: left;"
> +           pointer-events="none"
> +           width="100%"
> +           height="100%"
> +           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
> +          <xhtml:div
> +             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 158px; height: 1px; padding-top: 60px; margin-left: 41px;">
> +            <xhtml:div
> +               style="box-sizing: border-box; font-size: 0px; text-align: center;"
> +               data-drawio-colors="color: rgb(0, 0, 0); ">
> +              <xhtml:div
> +                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">FIT Header</xhtml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x="120"
> +           y="64"
> +           fill="#000000"
> +           font-family="Helvetica"
> +           font-size="12px"
> +           text-anchor="middle"
> +           id="text8">FIT Header</text>
> +      </switch>
> +    </g>
> +    <rect
> +       x="40"
> +       y="160"
> +       width="160"
> +       height="50"
> +       fill="none"
> +       stroke="#000000"
> +       pointer-events="all"
> +       id="rect14" />
> +    <g
> +       transform="translate(-0.5,-0.5)"
> +       id="g20">
> +      <switch
> +         id="switch18">
> +        <foreignObject
> +           style="overflow: visible; text-align: left;"
> +           pointer-events="none"
> +           width="100%"
> +           height="100%"
> +           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
> +          <xhtml:div
> +             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 158px; height: 1px; padding-top: 185px; margin-left: 41px;">
> +            <xhtml:div
> +               style="box-sizing: border-box; font-size: 0px; text-align: center;"
> +               data-drawio-colors="color: rgb(0, 0, 0); ">
> +              <xhtml:div
> +                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">TIFS Stub<xhtml:br />
> +
> +(GP, HS-FS, HS-SE)</xhtml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x="120"
> +           y="189"
> +           fill="#000000"
> +           font-family="Helvetica"
> +           font-size="12px"
> +           text-anchor="middle"
> +           id="text16">TIFS Stub...</text>
> +      </switch>
> +    </g>
> +    <rect
> +       x="40"
> +       y="90"
> +       width="160"
> +       height="30"
> +       fill="none"
> +       stroke="#000000"
> +       pointer-events="all"
> +       id="rect22" />
> +    <g
> +       transform="translate(-0.5,-0.5)"
> +       id="g28">
> +      <switch
> +         id="switch26">
> +        <foreignObject
> +           style="overflow: visible; text-align: left;"
> +           pointer-events="none"
> +           width="100%"
> +           height="100%"
> +           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
> +          <xhtml:div
> +             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 158px; height: 1px; padding-top: 105px; margin-left: 41px;">
> +            <xhtml:div
> +               style="box-sizing: border-box; font-size: 0px; text-align: center;"
> +               data-drawio-colors="color: rgb(0, 0, 0); ">
> +              <xhtml:div
> +                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">TF-A</xhtml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x="120"
> +           y="109"
> +           fill="#000000"
> +           font-family="Helvetica"
> +           font-size="12px"
> +           text-anchor="middle"
> +           id="text24">TF-A</text>
> +      </switch>
> +    </g>
> +    <rect
> +       x="40"
> +       y="120"
> +       width="160"
> +       height="40"
> +       fill="none"
> +       stroke="#000000"
> +       pointer-events="all"
> +       id="rect30" />
> +    <g
> +       transform="translate(-0.5,-0.5)"
> +       id="g36">
> +      <switch
> +         id="switch34">
> +        <foreignObject
> +           style="overflow: visible; text-align: left;"
> +           pointer-events="none"
> +           width="100%"
> +           height="100%"
> +           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
> +          <xhtml:div
> +             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 158px; height: 1px; padding-top: 140px; margin-left: 41px;">
> +            <xhtml:div
> +               style="box-sizing: border-box; font-size: 0px; text-align: center;"
> +               data-drawio-colors="color: rgb(0, 0, 0); ">
> +              <xhtml:div
> +                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">OP-TEE</xhtml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x="120"
> +           y="144"
> +           fill="#000000"
> +           font-family="Helvetica"
> +           font-size="12px"
> +           text-anchor="middle"
> +           id="text32">OP-TEE</text>
> +      </switch>
> +    </g>
> +    <rect
> +       x="40"
> +       y="210"
> +       width="160"
> +       height="40"
> +       fill="none"
> +       stroke="#000000"
> +       pointer-events="all"
> +       id="rect38" />
> +    <g
> +       transform="translate(-0.5,-0.5)"
> +       id="g44">
> +      <switch
> +         id="switch42">
> +        <foreignObject
> +           style="overflow: visible; text-align: left;"
> +           pointer-events="none"
> +           width="100%"
> +           height="100%"
> +           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
> +          <xhtml:div
> +             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 158px; height: 1px; padding-top: 230px; margin-left: 41px;">
> +            <xhtml:div
> +               style="box-sizing: border-box; font-size: 0px; text-align: center;"
> +               data-drawio-colors="color: rgb(0, 0, 0); ">
> +              <xhtml:div
> +                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">R5 DM FW</xhtml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x="120"
> +           y="234"
> +           fill="#000000"
> +           font-family="Helvetica"
> +           font-size="12px"
> +           text-anchor="middle"
> +           id="text40">R5 DM FW</text>
> +      </switch>
> +    </g>
> +  </g>
> +  <switch
> +     id="switch70">
> +    <g
> +       requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
> +       id="g64" />
> +    <a
> +       transform="translate(0,-5)"
> +       xlink:href="https://www.drawio.com/doc/faq/svg-export-text-problems"
> +       target="_blank"
> +       id="a68">
> +      <text
> +         text-anchor="middle"
> +         font-size="10px"
> +         x="50%"
> +         y="100%"
> +         id="text66">Text is not SVG - cannot display</text>
> +    </a>
> +  </switch>
> +</svg>

