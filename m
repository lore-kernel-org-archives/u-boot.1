Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FAAD116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 19:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB80083B8C;
	Mon,  1 Dec 2025 20:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mEPC3jDW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFF0683BF4; Mon,  1 Dec 2025 20:28:32 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0759A83B63
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 20:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwdfCQiFawNpqqZlnGZoil6sxEJHcZ2zTXYQy/WQ5RFVGGN+xEg98bILr07QGkgZBRvTednVHc2Cf7FRGhVzxUAYoOH/QdyiV26vAcHFTyFL9r5gLlfHtOS094gxJJZs0lgsN2KKYqURdHAqd8ykDgvA6QhguHfoCbdc4O77QcWOBT1ACeutSUms6en0CJ4otxl+2QWBbSUihKhWMRbKK/RYVo9wVLkx/iu9N1CrZ1o89rd0Siw96iXCO4G/7BOMa4NvHNyGCGg0ZxDdDUUNSUiU1KmkQUhowBC909Yr836qAk+dbcgdCU9SwRyvRdrSTvSjVaVOoKpa1S0N2Ek5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zF5goSK6J89AQkRxArwBuXsqgXxrm2pIOVNf0YfnMLY=;
 b=ePGADRvsyWUvHEeQRFBU5HSPth7DdDKzZLWQH4GTuI6Hz8TX6YLsYGyj9DfnID1GFk/QDObgStO+0QPS9UuKlXY/XKFp1qHLmvfuoojSzeAYxekbHnJacSwNv/BEsMD9uzQ+F7m0PWRLOBTsXognGxemThdD26kz4x6XuH0MEZPsBBB98ZVTbN5VsXe5W9mKML9du5g3HHQjdlueUXDhyTGEcyxL9OovoGAl61LyRc+vW9pAB5fSvMYVDcaKZJAwtN0IMaGi6pJX2IJOYOoMFRdFYOWZNYZcCAZ8/9UtslC7LOFjraKSYtoJV2tbv5Pl96dbzOXyNIAANzf7q1e1yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF5goSK6J89AQkRxArwBuXsqgXxrm2pIOVNf0YfnMLY=;
 b=mEPC3jDWNgE0oZu6vbAuDCIXJQwisN3Z8sdbqH2DReb88N0LziCEj51bXvUla2f3Qz+kS1NNtAq1PanqbkoFNqis5M8Elc6eNV9tH4uW7nuF8kFOU5rGWnqU79TmD02n4qzmuaTvzxiFh2dTxGWfXYFuPTTzT63Z6DbFtk3URD8=
Received: from PH8P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::16)
 by SJ0PR10MB5892.namprd10.prod.outlook.com (2603:10b6:a03:422::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:28:26 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::f1) by PH8P223CA0026.outlook.office365.com
 (2603:10b6:510:2db::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 19:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 19:28:25 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 13:28:25 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 13:28:24 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 13:28:24 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1JSOKI972964;
 Mon, 1 Dec 2025 13:28:24 -0600
Message-ID: <c5f858f8-0eb3-4ff0-bc7b-6286a43c93da@ti.com>
Date: Mon, 1 Dec 2025 13:28:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: am571x_hs_evm_defconfig: Reserve EMIF memory
 used by PPA
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>
CC: <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20251128150455.3279166-1-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251128150455.3279166-1-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SJ0PR10MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 21877b4a-cfa3-4333-99e9-08de310fcc4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlhPRnV4aVBCb1htQXVLMHBpbFM2WjRiTnJkZEZpTU1WeEYzSUs1RVJINms1?=
 =?utf-8?B?MmFkS2xxQ1V6cEdIUmNydU9pTzFVUXBLeEpONmFONlBDV3RNQVMzRWs0b1B3?=
 =?utf-8?B?eDV6QVUza0xxcGlnWkcxL2pWN3R4WG0vVlFDRGkzQTBDV3ZZZzdMTG9YbHdq?=
 =?utf-8?B?R3hPYnpFTzhrSGpyZGZrZkZJTGc4bm16bGdmcU5IYUllQk5pNVlYVW1lVSt3?=
 =?utf-8?B?Tm5YNnFJTWlCUEVobGtXVmRiUHY1T25wZWREL0ttMS9ES0FpMUtTSTQraVZh?=
 =?utf-8?B?bVlYdko5cVJpTStQMlB5OFhicmJIZk84azBCVGoyemFLWjRudTdVNmkxdkJ0?=
 =?utf-8?B?d0VWbUpmSXBlVUhUYnkxQzQ5RjFWV0hhRGtFM2ZNbFNKMVFEaVRIMS9UK2pw?=
 =?utf-8?B?TlZMV1F5MW5vS2dnUXlFbEEwQ1FsUVNXeUluWTZPSmo4N1REMk1ZbE5vM1ph?=
 =?utf-8?B?aEFvaVdtL0szT2RMY1ZFdzdQSk16VnExNDJhQklHaGtBUnY1WUFkNVdsRDVU?=
 =?utf-8?B?dWVUVlc5ZldlUzYxQTFkbUhSYlMyWklvOFA3ajZsSFowMUJPWFNldDRXeFh0?=
 =?utf-8?B?N29PUkppNEV3eFF2N3VocmI4TGVIS1Azem1BMVYrVnRGQnh2NmJHZVFkVG5U?=
 =?utf-8?B?RDFiTVRLVlhRSCtzTEF6MEZLYWUwWTExWHE4cFg1WWljcnltT2NpVG80WHhz?=
 =?utf-8?B?TTY2cVpBQ01GVjYyRVBZaFRWRjQ2czQ5dzdjMjBFUUdCNW94VXMrOCsySmNq?=
 =?utf-8?B?L2UvNDRqa05uc2NaS2RHcGZOLzFEOW5MbWRGTkJ0bWtISytrV0t0QXh1MXRv?=
 =?utf-8?B?SjhXNTV0SzdMdndRV3BWc1ZDVmthd29uUitpcTRSTDJlVk0xMUo0UzdNWTE1?=
 =?utf-8?B?ZkV2RlRBWGMvTGVVMkpCbkwzREErMG9hUkpmclptL01NQm0xT1Z6OTJ1SzI4?=
 =?utf-8?B?UFo4NS9tUkY4T2VLeWh3aXVZMmdhU2dBakRlbzBoTExTamxDVENKL29lRWdo?=
 =?utf-8?B?R0N5M2xtNy9yY3prb2ZMSUxqUXhQSjJoT2VUYXhKeTkzYWk5VmwwKzBKS3Bk?=
 =?utf-8?B?bTlrdlZNcnNJRW9hL2huVG8xQXRTYW44cFNuTHlmTzY0S3AzbXFFNS9UOHN5?=
 =?utf-8?B?UGk0TWs2OWRvajdiaWt5R3VFd2VBT0Fvd1lhQVdWOVBvODFrY09naksvUlUz?=
 =?utf-8?B?aCsrdjVHbnRCb1FJTEJYaGFaekdaeHZwNVpNOTlhMFJLZDE0SFUvemMxSUxW?=
 =?utf-8?B?NE9jSncyaUhSNFNjNlN6VUpmSzZ4UlR4cUtaOTd6cTRzQVRuVjNLYTVjaHVw?=
 =?utf-8?B?K2Z5bERTd0djOFBnT1FYcWNxQmtXZkd6UnF4ellqMDJONFRNdkE5cUp1UGxD?=
 =?utf-8?B?TXBmM3NSRTNjdUUxZ0F3b3FoTDNGekV5MkNST3dxbVVQaGhLUmNPL0ZyTUZT?=
 =?utf-8?B?a2RTVnI0U0RLS0ZMejY2UWZrSzJMdGJBY1ZJRWpQdEZKRjhEbGQ4VkRENlYr?=
 =?utf-8?B?RGFZWkdlZ2E3MXRmL1lzOXF4WU1ubG5kM21yZXJZeHpBNFhHZmo1a1hyKzZC?=
 =?utf-8?B?N2xjS1NRU2hSbGdOaGpCb1NCVGIyQSttTFhnQ3N1am4xQlBWUEFDOXBRenRq?=
 =?utf-8?B?RmhCSHRCSXBKUDRoU1R2YnBIaG1LbnZCWkR3azBvZUVDbHhCSnNCMGh4ZGs0?=
 =?utf-8?B?ZFBQNUYxVjM5b3lUUmhJL3ZHSGJEOVJYYTdJOEZ6QlROc0YzVU1UNXJFYnRZ?=
 =?utf-8?B?dlA4ZWJTZ0RabHYrK3I0S2pkcW5SNFNvTnZRS01xMDFpdm04SEF2THRIN0VK?=
 =?utf-8?B?YzdBZXR1QkVGT2k4WEFJSWFFRnFLZGhaaXZINFJHRExpNlhZd3RyWlQ2VkN1?=
 =?utf-8?B?NHZGZnFGdTNxVTIvSkR0YnFzcFBrS0xOU3dqWWRXeUZ1NHkyK1AwZGNWOVQr?=
 =?utf-8?B?M01UMU9VNm5XNkk4V2FsbHVOSzNQV0cweXl4VFV1cG9wZVp4V05BM0tzTUJE?=
 =?utf-8?B?ZlFVclRXb1VQZnFoYURCa29NdXFBaSs3dmZyL090Y1lwTTBGNUdNcDJOdTBW?=
 =?utf-8?Q?o7nDNj?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:28:25.4786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21877b4a-cfa3-4333-99e9-08de310fcc4e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5892
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

On 11/28/25 9:04 AM, Beleswar Padhi wrote:
> The AM571x SoC has 1 GB DDR space. As part of normal re-location process
> U-Boot copies itself to the top of DDR bank. However, on HS devices, the
> top 37 MB is used by PPA and is firewalled. This results in an exception
> and the boot fails.
> 
> Introduce a new defconfig for AM571x HS platforms and set
> CONFIG_SYS_MEM_TOP_HIDE to reserve the top 38 MB memory (aligned to 2MB
> as per page size for ARM32) for the same.
> 

This "SYS_MEM_TOP_HIDE" looks new, for other OMAP-class HS devices we
use "CFG_PRAM"[0], seems these two configs do the same thing, could probably
combine them in some way..

As CFG_PRAM is set based on TI_SECURE_EMIF_TOTAL_REGION_SIZE which is 32MB
for all other AM57x, why is this needed only for AM571? We build for all
the AM57x with one defconfig, so this new defconfig will go unused. Just set
the default CFG_PRAM size to 64MB (same as AM43x), should be enough for all
and doesn't hurt to have more than needed reserved to be safe.

Andrew

[0] https://github.com/u-boot/u-boot/blob/master/include/configs/am43xx_evm.h#L153

> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> Fix boot for TI AM571x HS EVM board
> v2: Changelog:
> 1. Drop [PATCH v1 2/2] in v2 series. There is no need to add reserved
> memory node in DT as it is done by U-Boot as part of FDT fixups
> https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-omap2/fdt-common.c#L72-L107
> 2. Add entry in MAINTAINERS for new config.
> 3. Update commit message to use memory size in MB than raw hex bytes
> 
> Link to v1:
> https://lore.kernel.org/all/20251128064353.1295063-1-b-padhi@ti.com/
> 
> Test logs:
> https://gist.github.com/3V3RYONE/e86b3f4551986b0400d0e0f66d6ecc66
> 
>   MAINTAINERS                     | 1 +
>   configs/am571x_hs_evm_defconfig | 3 +++
>   2 files changed, 4 insertions(+)
>   create mode 100644 configs/am571x_hs_evm_defconfig
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b43dae882b3..e5d564cd760 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1780,6 +1780,7 @@ F:	configs/am335x_hs_evm_spi_defconfig
>   F:	configs/am335x_hs_evm_uart_defconfig
>   F:	configs/am43xx_hs_evm_defconfig
>   F:	configs/am43xx_hs_evm_qspi_defconfig
> +F:	configs/am571x_hs_evm_defconfig
>   F:	configs/am57xx_hs_evm_defconfig
>   F:	configs/am57xx_hs_evm_usb_defconfig
>   F:	configs/dra7xx_hs_evm_defconfig
> diff --git a/configs/am571x_hs_evm_defconfig b/configs/am571x_hs_evm_defconfig
> new file mode 100644
> index 00000000000..7e44ee5221a
> --- /dev/null
> +++ b/configs/am571x_hs_evm_defconfig
> @@ -0,0 +1,3 @@
> +#include <configs/am57xx_hs_evm_defconfig>
> +
> +CONFIG_SYS_MEM_TOP_HIDE=0x2600000

