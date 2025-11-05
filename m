Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A437CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 21:00:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C000283B03;
	Wed,  5 Nov 2025 22:00:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jEGc1xuQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA2A83B03; Wed,  5 Nov 2025 22:00:19 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C998E83AEA
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 22:00:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GajkvthfR1GKewfgL2PHH9PPtXkeb49LwB9xSkYDr1lYwFb02DVSBp845ld4kuDyq/uRc5nNBVWkuWzQiJjBJfEG83Q4iiTg8az7DNMEYJCD3fChs7mUKH0TEIEqb/8XLkkrnHsTRnPJAAAiVfbnYAZFIcc7sp9YhXMqlDHHxAqRxEN/Uw1ctcaH4s3Wa/TwXS40h0Rz61p/KYKJ3Tj7xCABQAuQO6WVXCLHSejLXwjVKuzqx5huclTV6cBvMruwUcNzLQ8e7v8oFcTYptQqA5mmCqmKvC5St3NQEN28gi/4yiOQkktwdzwcExwXkWjZxinS80uUf/qG62RT5ml31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ztaQZGt2TcTO8QC65OyfaaPrZiLM+leROu8n5+BC2Q=;
 b=gj0QSAXoTNRfarldEwWslX07jEBQqqWIFtB2zDtW+qDz+YrwoL00FKwQEOWh/TpcV3V36O8BBuQRtsoRmPj+N9oZfzykKjvlJdzH4AqkeRGqV42zLHLjzTQYwT+8Y0yUlPXhHya/9UAv+kXsq3ns7dIZCqEe70nI3FgrJ9gcnRkUsgTluWdNrkl2+YoDlw1d0/SPtT4ICNky/YEyvKvjMmbBzVooSvfbTiNJ2Y3VcVIRgEOS1zX76o53Kp9dNWhwP7WtvLZEleix0XyRZOXFTIT/U+tCgEntbbXj37JO1moeAVwUkeWrR4dwtjT8Jgd5lTNMjeKxkVJ/K0kK7WR3cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ztaQZGt2TcTO8QC65OyfaaPrZiLM+leROu8n5+BC2Q=;
 b=jEGc1xuQCziHWALpXhnVI6kcQiMFr11rhK0HQ01/HUOIrMx6hDkYlpi93BqMgnCVHeuQSnqXuJWxI94rNa/TsCMqgfXWUtHMOBED6Kw3TZ2pUK88GBgafF/okpAKrsjR4RlQ1xfJu7tfLG1UWwQCQqD983vdN2U/j82SPw56joM=
Received: from BL0PR02CA0005.namprd02.prod.outlook.com (2603:10b6:207:3c::18)
 by DS4PPF6D651AD93.namprd10.prod.outlook.com (2603:10b6:f:fc00::d27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 21:00:12 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::2b) by BL0PR02CA0005.outlook.office365.com
 (2603:10b6:207:3c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Wed, 5
 Nov 2025 21:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 21:00:12 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 15:00:07 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 15:00:07 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 15:00:07 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A5L064H136903;
 Wed, 5 Nov 2025 15:00:06 -0600
Message-ID: <e761adae-2a3c-42af-9dc6-b689e81ec746@ti.com>
Date: Wed, 5 Nov 2025 15:00:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 2/2] configs: am62x_evm_a53_defconfig: Enable
 A53 splashscreen at u-boot SPL
To: Swamil Jain <s-jain1@ti.com>, <devarsht@ti.com>,
 <aradhya.bhatia@linux.dev>, <n-jain1@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <trini@konsulko.com>, <jd@denx.de>,
 <tl@denx.de>, <agust@denx.de>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <h-shenoy@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
References: <20251105163040.4086273-1-s-jain1@ti.com>
 <20251105163040.4086273-3-s-jain1@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251105163040.4086273-3-s-jain1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|DS4PPF6D651AD93:EE_
X-MS-Office365-Filtering-Correlation-Id: a04e29c5-7472-495b-abe5-08de1cae4fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|34020700016|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0hqcURzWHRaVElMUXhBU2Rrd2tJNVlHUkI1NHhtcWpCQ0thdW9LNTVxZUdD?=
 =?utf-8?B?aThZTjVYclR4K3F2N1hBUm03aEl6VWRBZmpZZVZiMXY1M2doYjdsSXlXbkpq?=
 =?utf-8?B?TFN2eUZUd1FydlNSTWZvVC8vQlN3L2VwMjgrcmpwM0p3M2JxM3ZXZGR6Y24z?=
 =?utf-8?B?Uk8vZm5QUkx2dkNucFdkQ1d3VjhiRHBVWDFqbmd4bFcyb2Q2RnNhUTNTaUZu?=
 =?utf-8?B?eEs1YzlaUUJuVzBsWVhFY2JnTllWZmlHS0lFUFVrdTRMWTlXNkhva2dUQi8x?=
 =?utf-8?B?Z1FtVnh4MFRXM0hYWUxHZkRoMGhoUTdaeWYwZytUM0NZTTRiTTQ0UUM0blBQ?=
 =?utf-8?B?R09wQzZCUmU1b0d2VmQwaFhmNTZncm9PVlB1ekNRU0thMGwrcHpTajBGbnZx?=
 =?utf-8?B?czNJNUI4bmxNRmJtY3FyQUtzVmR6QitpMXJLVFRVM0E3UW0xL2ZGT2tXZTZP?=
 =?utf-8?B?MmpQWHhZczFEd1NlaXZsMjR6RTE0bUtESldGWlpaNll6c3h3alJtb1BIRHNm?=
 =?utf-8?B?cVZUejZZaTA4UkZMZGs1RFYyT0NhMmpQY294WWZYNkxMOEM2bjdEQ2MvY2Nx?=
 =?utf-8?B?dlp1ZjZsTWtmUDdqeTdBZTUxbjVSc09UYUlScFpvK0YyK01ROGZNQk8yL2ln?=
 =?utf-8?B?T2VQWVJ0bzJIQktGblFhY21jVXBXYUJSa0liL1p3NXFEY09GblkvWENoMmlt?=
 =?utf-8?B?WmkzSEloY0R4SnZYM1VMSnp0TVA1dHVBbFY0NEtpK2czaUl5RjdJSkFMUjVa?=
 =?utf-8?B?UE1MS3hXRHVzdDhsOUFuUmQ4Y0Z0bkRLUS8xcjBBRTRaSUwrYXB0MCtUelBP?=
 =?utf-8?B?RDRZT0MzMUdCSjlIOG9CRmRWREwxeElWUWltakt6aWpYckVqMU5nV0xHRm5m?=
 =?utf-8?B?UDkyaHczTm54UFVLQUlLOHU1NWRIdlA2MUNPT3NUVDdrVzdyckszbVhSb05h?=
 =?utf-8?B?UW5zdDBPZjU3UjBsbDRBbkEwb050T21TNklXa1RmTEU3UTJvQ3NsSnJ6U1B5?=
 =?utf-8?B?dXhYUXEwMC95amkvWVBiR3VrNlhRdTJuT0RYL25NaDJjNElTSmVaVUdhclll?=
 =?utf-8?B?TW9RMjFBNC9ZV2hLQ0pROXNuUmdDUE02VGRwMW9DYm0vT3hOWGhFNGh6aGxL?=
 =?utf-8?B?MURydjB5SG10SWZSWmdOdUpwdFZ2SEtHWU5qc25tdUxvYXZwZ3VuQWt1VC91?=
 =?utf-8?B?cXpzMzJjTXVmRG1IckJIdXNEdWxrRVJLcGlvaXRmeHhtcnNvZldYTjVoQkV5?=
 =?utf-8?B?UERqeFhqeFRsd1NpTkR0YUU3VFF0MUpzMHFLT1B6eCtvRU5mM2Z2SzhKT1gx?=
 =?utf-8?B?OVlZZ0VDcUZDYWYxaGpWV1BodVpQSzh0eFFEUFBFdG1xNDRiNWRTZWJURllU?=
 =?utf-8?B?WVRUMmRwTEJRTlEvNGVwWDkxbEM4RWI3TmtXVGp4Zmk1V1ZDbWxDU0VJQzM0?=
 =?utf-8?B?ZFpVMUpUVlpUQWJGUVFLTlFxVkFNK2xaUXMwb2NLVWk3aXo2SFhScGJRZEZh?=
 =?utf-8?B?SVpKdHU1RGRoM2E2M3BreFhac3pzUXVVbitQYThHK0VkdlAzaStPODdHOVFp?=
 =?utf-8?B?SXNaV1JtRklHT1FFQUE5dEFiYW54dnU1dVZzVVdxZE9CVGVGVk5jakx0Ymh3?=
 =?utf-8?B?Tzg4OTdySW1TUHFXUmh4VVRBckt6aldEYXZBVWVsU3lKL2NaT2xrMElTcCtj?=
 =?utf-8?B?OGVkK2RQV1FjQWovUFNZeHZxb1pjcDBwZHJRVnJKVDhwV1daS1hvZUdkZ1FO?=
 =?utf-8?B?ZjBMSndyZHVZZVZ6ZVZsL3phNCtzS0VjM3JvbUlsWDQ1Yk1CMXhYdlJlcVEz?=
 =?utf-8?B?STQ1K2RNcEVxNEkrSFZSZDR5RmxLMElhZU5UY285MkhaWjd2OUdSRzJXLzcy?=
 =?utf-8?B?eGhiRHE5YmhEOVRMMm9jaTJrRmhmS2FEeTFWR2NsT2NVTmUrWFlmUCtWZnNZ?=
 =?utf-8?B?cCtPMXNUWEh3N2FVa3UrbEhjVmY2OHE5dXhnR3dOc2NVdTdmbVJOR2JDQkZK?=
 =?utf-8?B?cFhYV0x5K0E1RUJVZUtMNzN1NThic3MrSVl6d1Y5ZTFZRDVzcGIwWWlNT09z?=
 =?utf-8?B?VGhqbW5Lb2paNDJpaTcwbnNmWmY5OEpHUUNrMU9oeVMwS1NCcjl3WE9qbGdC?=
 =?utf-8?Q?dPpQ=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(34020700016)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 21:00:12.2231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a04e29c5-7472-495b-abe5-08de1cae4fe3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6D651AD93
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

On 11/5/25 10:30 AM, Swamil Jain wrote:
> From: Devarsh Thakkar <devarsht@ti.com>
> 
> Enable A53 splashscreen at u-boot SPL stage. SPL_MAX_SIZE is bumped up
> to 0x80000 to accommodate splash related code. Bloblist related macros
> are enabled to preserve splash context till u-boot proper.  SPL Board
> initialization Kconfig is set to dynamically update simple-framebuffer
> and reserved-memory DT nodes before kernel bootup.
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> Signed-off-by: Swamil Jain <s-jain1@ti.com>
> ---
>   configs/am62x_a53_splashscreen.config | 16 ++++++++++++++++
>   configs/am62x_evm_a53_defconfig       |  4 +++-
>   2 files changed, 19 insertions(+), 1 deletion(-)
>   create mode 100644 configs/am62x_a53_splashscreen.config
> 
> diff --git a/configs/am62x_a53_splashscreen.config b/configs/am62x_a53_splashscreen.config
> new file mode 100644
> index 00000000000..0419d60e281
> --- /dev/null
> +++ b/configs/am62x_a53_splashscreen.config
> @@ -0,0 +1,16 @@
> +CONFIG_FDT_SIMPLEFB=y
> +CONFIG_VIDEO=y
> +CONFIG_SYS_WHITE_ON_BLACK=y
> +CONFIG_SPL_VIDEO_TIDSS=y
> +CONFIG_BMP_24BPP=y
> +CONFIG_BMP_32BPP=y
> +CONFIG_SPL_VIDEO=y
> +CONFIG_SPL_SPLASH_SCREEN=y
> +CONFIG_SPL_SYS_WHITE_ON_BLACK=y
> +CONFIG_SPL_SPLASH_SCREEN_ALIGN=y
> +CONFIG_SPL_SPLASH_SOURCE=y
> +CONFIG_SPL_BMP=y
> +CONFIG_SPL_VIDEO_BMP_GZIP=y
> +CONFIG_SPL_BMP_24BPP=y
> +CONFIG_SPL_BMP_32BPP=y
> +CONFIG_SPL_HIDE_LOGO_VERSION=y
> diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
> index 4da668396d0..57d0cec2222 100644
> --- a/configs/am62x_evm_a53_defconfig
> +++ b/configs/am62x_evm_a53_defconfig
> @@ -24,7 +24,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>   CONFIG_SPL_BSS_START_ADDR=0x80c80000
>   CONFIG_SPL_BSS_MAX_SIZE=0x80000
>   CONFIG_SPL_STACK_R=y
> -CONFIG_SPL_SIZE_LIMIT=0x40000
> +CONFIG_SPL_SIZE_LIMIT=0x80000
>   CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
>   CONFIG_SPL_FS_FAT=y
>   CONFIG_SPL_LIBDISK_SUPPORT=y
> @@ -88,6 +88,7 @@ CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_OMAP24XX=y
>   CONFIG_DM_MAILBOX=y
>   CONFIG_K3_SEC_PROXY=y
> +CONFIG_FS_LOADER=y

Why not put this in the config fragment?

>   CONFIG_SUPPORT_EMMC_BOOT=y
>   CONFIG_MMC_IO_VOLTAGE=y
>   CONFIG_SPL_MMC_IO_VOLTAGE=y
> @@ -143,3 +144,4 @@ CONFIG_EFI_SET_TIME=y
>   
>   #include <configs/k3_efi_capsule.config>
>   #include <configs/am62x_a53_usbdfu.config>
> +#include <configs/am62x_a53_splashscreen.config>
> \ No newline at end of file

Fix this and your tools to not allow it.

Andrew
