Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D860C54F5F
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 07:20:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BA0983AC5;
	Fri, 20 Feb 2026 08:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DpbWT4i1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2EEA83CF2; Fri, 20 Feb 2026 08:20:23 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9693A83AA9
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 08:20:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4sG8lmXIZeIBHbkEkkCAdJ9aeD2Lp90g/OsMsxEU8SvPIWidNPA/X1zHutYX97JCR4O1AZ/3BIDT4UMhAOFSkJxlQpB08iB2hqShUukod89aePGQMpyxQeDi1f2+2Sb06lAyL28kxelQyowtxWUNrVBICauXHWDtSOPp5rxTPh6i+i6PSK9aIjbKSaTLZPOjOdQgWZc4K4OEUmjMMatHn5srqYXGXd7lquAGgCtcbmft6hqUUJuF87Ce20jowK/sFIWJuPvORzEZ6gcAEamkqkVRKRcUBEscgjvxefGxT9uo6fwUhoO5r+nUBrp8itqHzSqTKXXpmEO6T2TjuwR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcinSaqHyRyuQ6af4sRb0OWtCh59a0p+n7OEBxRPegU=;
 b=wQU2E3To/jnYoC4MXUr2h28t3WRDkOZ0kVXPD/Ra6gUuvha3QEsyAUcD+I30/cd3PNSxI+L5DBJV5D9bbQYzV7TS7qoapBgcajhKCK8KeeSUXQog2/tOLhIwo1Ostyg6IPVaJKaNgjerjZSFq71jkv1iJIv8o28Kzfol6Z0uLyEqAoKJ4UIyk9IDg76iz3iL+RSE28rrBRfbTdgDYjLbGWP22b1F2ILgUdTXRNRj25FBtQsIO0B06Y5QboTuCTbFiqVvWVpW+I2M0R1aT7ehKMedoE4jCgj0nOtTOr0EHywJSUcKxCi63+5dHhHNpzkqtZa/BvspNXKjezbR4dp+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=nabladev.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcinSaqHyRyuQ6af4sRb0OWtCh59a0p+n7OEBxRPegU=;
 b=DpbWT4i109OEekzDpM/w1lAU3Jgv/SytphtCME7b1pzO/UtWjo0MW3MSmqqJ0lsIeFchDo4VZmEsm8D7yOuCqrzOXMvZfwBBU1a9/r/KSudFVM3Y88Td6yVfUSid+PMxPmb9bnpG5o3xsH/uA9lt24c+EbvS7Yf03jy4Gg8lEmg=
Received: from BYAPR21CA0027.namprd21.prod.outlook.com (2603:10b6:a03:114::37)
 by CO1PR10MB4481.namprd10.prod.outlook.com (2603:10b6:303:9e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 07:20:17 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::69) by BYAPR21CA0027.outlook.office365.com
 (2603:10b6:a03:114::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.0 via Frontend Transport; Fri,
 20 Feb 2026 07:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 07:20:15 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 01:20:15 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 01:20:14 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 20 Feb 2026 01:20:14 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 61K7KAkD3956973; Fri, 20 Feb 2026 01:20:11 -0600
Message-ID: <c66f33ec-a2d8-44b2-99c1-ccf4f59855d1@ti.com>
Date: Fri, 20 Feb 2026 12:50:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spl: Add generic SPL MTD loader support
To: Fabio Estevam <festevam@gmail.com>, <michael@amarulasolutions.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <dinesh.maniyam@altera.com>, <a-dutta@ti.com>, <a-nandan@ti.com>,
 <jonas@kwiboo.se>, Fabio Estevam <festevam@nabladev.com>, <s-k6@ti.com>
References: <20260220031232.1254728-1-festevam@gmail.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20260220031232.1254728-1-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|CO1PR10MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ecdbb49-c69b-43f9-37ff-08de70507ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWpnbUxMazFQbWFKUEdSUnYxNklDeDF3NlRhSjkyMkNuQjBtVDBudVUyQTdW?=
 =?utf-8?B?bWU4TGU3Tmp1UnBrd3RVR1NCMmE0dmhkM1kvUnhpenBPR0lwNE5XQWZzRGhJ?=
 =?utf-8?B?Q2JLRFNPbDJ6ck8vcTZQV0ZKa0JkNGx5OXZRajBVbFNDS2E1U3RDSkFmdUU4?=
 =?utf-8?B?Ky9EVC9wNnJ6ZkloRmxKR1R0WGdEU0ZTZURiZWxoSGNUcEtPRkhoUHZwRkY1?=
 =?utf-8?B?MUFXL2ZjcjNjbWRkK0xlM01BNEJ1TmNVUCtCY2VUdW5hbzJsVTBNVm82OWQ4?=
 =?utf-8?B?Uk9QMGN1Q3BadDUxL21IUVJaN09tZW1NSkptWTJsN3p2VGZGV0V2cHdqSk03?=
 =?utf-8?B?Wk0xcmlBNit6b1EyZjk2V2VCTDAvSTZibjJPSnN3QjUyYjlkaVRrUThrWFRJ?=
 =?utf-8?B?QlVkMUwxVjJTd0c1VFdFTnREMmZsSExYOTRWblpsZHRjUWhKUUNtVjVCeXB4?=
 =?utf-8?B?aUx4VkNzNHE3MjgxNDA1eWF5U2JUTFN2aWF3aGdLYlVnTWtibTA5Mm5seFh2?=
 =?utf-8?B?RUZmTFN0azRXQWdYb2ZjaDdzVDBhRWU0ejI0K3lVQ0xwdDBxV2VPTDNLMVlD?=
 =?utf-8?B?QTVrTmsvN051cGg1UmFueldhT3FZbEN0a2p6OXlnWi8zYmNyNEQ1Qy9pRkc3?=
 =?utf-8?B?WWF6R0RzMzhyS3pMYlVYN3QwRDkwRkNtQkNJZXVtcnlxNUJMOTgxSjBqYlk3?=
 =?utf-8?B?V1A1eHJUMkUyTXYvTDRHdlIrZlBlSlU1aGx1N1hNcmZKWVJDRTIrckZBUkxm?=
 =?utf-8?B?MlVTS05MZGhZQjlkc3Nvd2QrUlpRRW1odGZicjE3L0xvd1Z2WUFWZ2kvRlhl?=
 =?utf-8?B?NzNzVzU1RytMcUhGYjFQU1cvb2x6MHFtVWFSdm9EY2xwQXZJYjJXeUg1WmFM?=
 =?utf-8?B?UmJNV0hTMytNRjVLSVd4ZWZWdXhxaUlTSHhiSzVPSkZxUlJHWjlaVVQ0ZGZr?=
 =?utf-8?B?NzRhaHprdXZSTWNjM2RPTk1Fd0ptOG1JeDVBVThBbnI4U244SWdBdnEvOGZ5?=
 =?utf-8?B?SEtpZ3FzcUdLOVJVaWpSTlJJSW8yZXM3UFcyYjJsYjZ1SlFwRmo1N0g0TDkr?=
 =?utf-8?B?WFpZZmhWdWJuZTdjaFVGQU1vaHNtQVZKU1Z2OG03S1FTaXhEalB1MXJtajVX?=
 =?utf-8?B?STZOWWlLb0liMkU1WWttQlpkdVJGZkYzNmJ6VXJBMWg5UGxEb0M2TE1VdHVN?=
 =?utf-8?B?M3d1OTBPM0JJRG9HVjNmeDZPcjNZL1dxVWh3cXNVZzVSMmxzQ2FBWE5lVElv?=
 =?utf-8?B?VElNVWlLeHZIcUIyWTJ5cmM1OU9wUm0wTnYraDM0ZlA3TSt3ZkJMdkZVS0Q2?=
 =?utf-8?B?QkMzVzFCaWZIT3ZKYm9NeUNmSVVxSU1JKzhLamRtQWxpZ1JyUmxpdUdSY1gx?=
 =?utf-8?B?RDNvamQram9TeWlrUVJYWksxTHk1OFkybUhCTUgxaHpsRlIwZXBiQUhTUDE3?=
 =?utf-8?B?TWN3d1VNQWJCcG5YTWlSN1dRKy9RSGVQOGhlSHEraHVrbDlFSUJKdW8zWDlK?=
 =?utf-8?B?YS82VTRoWDZTYmVxeXVPUHB6dnVMVHlVcE04ZHVIYWVFWVM0RENLdE1iSUhs?=
 =?utf-8?B?VWxmK3JYc2NWeE1RNzlNNmw4R0VtTFJtckNYSHZtTjNXUHZVWlYxQUJWcklJ?=
 =?utf-8?B?YXdPNjZueVV1dG1HRmlMbkZWUTd0bldIM3ZwcXcyUGxPVndWTm1TeUZxU3Va?=
 =?utf-8?B?SlF1Z3FGNTBQUFVpSkp3Yk5TUjlyZ0xya1VxZDhNeFFEUnBJZE1VQkYxRHFn?=
 =?utf-8?B?dDRLK0tmSjE2MGlqZklsY004eTA1Mll5emI1Y2VySStMTUt4V05XbFdYQi8v?=
 =?utf-8?B?M3BEUVZTcmdwdEdweXdGQTBNUlBnZmk1ZW1aSEVnMDA3THExRnVZN24rTjdj?=
 =?utf-8?B?SU51TEora1BOVWFtUmxTL25wZzRQZU9KVjV4Z3lNRzhVNHBCU3BYWExiU3pE?=
 =?utf-8?B?bWhnaEVUVTJNalFHanhZaURlY1NzaDB1RW14bDZieHlvVVFQTW55dGRpWUFu?=
 =?utf-8?B?YWdyQWhQVmRtRUowdXRnMTRZTjFlejFycHF1cVQzZUN6dzM4dGp6emM4RG5C?=
 =?utf-8?B?TzN3UGRWbUErT051MnduUlNGZXlvVkdzWStQUUY5TmZjbDg5c3dUSFV1eGxz?=
 =?utf-8?B?RTdJU25rT0d6Q3VuYkVsSmtxcjZjMkZOTWlEQXZxWGlpeGlmZ0pWK1pROUdo?=
 =?utf-8?B?NDNCWEltQVdiM2dkN0tVVHBsUXlraHBrSnVnZFZSeTBFeXVMaDVxNkRtcmVi?=
 =?utf-8?B?b3lZUjVmNm1MN2NrTkxkOWJOTkZ3PT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m3XK6/0sQjBvXDds6ibm95iKtnAlXDWavygqREmEDjOeTVbVsSl2eonwAkuIkl56VGhEkgqez6Er5IYVG8wCSkxEI07fg5UdHaXPEsBy7FIqNFEwN2PwEBoRbdEKIedeepJV3Z0wnID1gDzVV5SzQ4+MYHAOJ1ORnYIwBa1n1T5Iio+GxyO5cM5u4FfhXuoPxbsOYX+RDaZTlw34o1D+tjlxMFGCRkvs7smGBOsjgO68ddR0RxJGUIcWpvimGNMZRc7QSMQMDx7ipvy216wiBstXDjVUtgZJ+EJK45ayfQGpDgGjpMmkbdmSMYRTvTZDMbocPe+Hg1a4hem1fyFZUv4L3rp9WMqVMOV8SnjTJp+YAn6CaQKxcXFn+dzbyRbIyDDCkeTx16pOJJlA9FF5LBNHa0DekILt7Kd8DpuUa5SwVYtWoViQNl+r+DhGKmId
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 07:20:15.6650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecdbb49-c69b-43f9-37ff-08de70507ea9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4481
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

Hello Fabio,

On 20/02/26 08:42, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> Add support for loading the next stage from an MTD device in SPL.
> 
> Introduce CONFIG_SPL_MTD_LOAD and a generic SPL MTD loader
> implementation that uses the MTD subsystem to read the U-Boot payload.
> 
> The loader works with any MTD-backed storage, including raw NAND and
> SPI NAND, without being tied to a specific NAND type.
> 
> The payload offset defaults to CONFIG_SYS_MTD_U_BOOT_OFFS and can be
> overridden via the device tree property:
> 
>      u-boot,spl-payload-offset
> 
> To support both raw NAND and SPI NAND boot flows, the loader is
> registered for BOOT_DEVICE_NAND and BOOT_DEVICE_SPI. This allows it
> to operate correctly on platforms where the ROM reports either NAND
> or SPI as the boot source while using the same MTD-based loading
> infrastructure.
> 
> The required NAND core and SPI NAND drivers are built for SPL when
> CONFIG_SPL_MTD_LOAD is enabled.
> 
> This provides reusable infrastructure for boards that boot from MTD
> devices without relying on SPI-specific or NAND-specific SPL loaders.
> 
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
> Changes since v1:
> - Use uclass_get_device_by_seq().
> - Use puts() instead of debug() for error.
> - Include the new loader to include/spl_load.h.
> - Introduce SPL_MTD_SPI_NAND.
> 
>   common/spl/Kconfig        | 30 ++++++++++++++
>   common/spl/Makefile       |  1 +
>   common/spl/spl_mtd.c      | 83 +++++++++++++++++++++++++++++++++++++++
>   drivers/mtd/Makefile      |  1 +
>   drivers/mtd/nand/Makefile |  4 +-
>   include/spl_load.h        |  1 +
>   6 files changed, 119 insertions(+), 1 deletion(-)
>   create mode 100644 common/spl/spl_mtd.c
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 2998b7acb75f..16dbc5b54324 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -933,6 +933,12 @@ config SYS_MMCSD_FS_BOOT_PARTITION
>   	  used in fs mode.
>   	  Use -1 as a special value to use the first bootable partition.
>   
> +config SYS_SPL_MTD_SEQ
> +	int "MTD device number for the SPL load"
> +	default 0
> +	help
> +	  MTD device number used for the SPL load.
> +
>   config SPL_MMC_TINY
>   	bool "Tiny MMC framework in SPL"
>   	depends on SPL_MMC
> @@ -1578,6 +1584,30 @@ config SPL_SPI_LOAD
>   
>   endif # SPL_SPI_FLASH_SUPPORT
>   
> +config SPL_MTD_LOAD
> +	bool "Support loading from a generic MTD device"
> +	depends on SPL
> +	depends on MTD && DM_MTD
> +	help
> +	  Enable support for loading the next stage from an MTD device
> +	  using the MTD subsystem in SPL.
> +
> +	  This supports raw NAND and SPI NAND devices.
> +
> +config SPL_MTD_SPI_NAND
> +	bool "Enable SPI NAND support in SPL"
> +	depends on SPL_MTD_LOAD
> +	select MTD_SPI_NAND
> +	help
> +	 Build SPI NAND support for SPL.
> +
> +config SYS_MTD_U_BOOT_OFFS
> +	hex "address of U-boot payload in the MTD device"
> +	default 0x0
> +	help
> +	 Address within the MTD device where the U-boot payload is fetched
> +	 from.
> +
>   config SYS_SPI_U_BOOT_OFFS
>   	hex "address of u-boot payload in SPI flash"
>   	default 0x8000 if ARCH_SUNXI
> diff --git a/common/spl/Makefile b/common/spl/Makefile
> index 4c9482bd3096..67fc1cd1b396 100644
> --- a/common/spl/Makefile
> +++ b/common/spl/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_$(PHASE_)NVME) += spl_nvme.o
>   obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += spl_semihosting.o
>   obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
>   obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
> +obj-$(CONFIG_SPL_MTD_LOAD) += spl_mtd.o
>   obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
>   obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
>   endif
> diff --git a/common/spl/spl_mtd.c b/common/spl/spl_mtd.c
> new file mode 100644
> index 000000000000..904f1fbad834
> --- /dev/null
> +++ b/common/spl/spl_mtd.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * Generic SPL loader for MTD devices.
> + *
> + * Based on spl_spi.c, which is:
> + *
> + * Copyright (C) 2011 OMICRON electronics GmbH
> + *
> + * based on drivers/mtd/nand/raw/nand_spl_load.c
> + *
> + * Copyright (C) 2011
> + * Heiko Schocher, DENX Software Engineering, hs@denx.de.
> + */
> +
> +#include <config.h>
> +#include <errno.h>
> +#include <image.h>
> +#include <log.h>
> +#include <spl.h>
> +#include <spl_load.h>
> +
> +#include <dm.h>
> +#include <dm/ofnode.h>
> +#include <dm/uclass.h>
> +#include <mtd.h>
> +
> +static struct mtd_info *spl_mtd_get_device(void)
> +{
> +	struct udevice *dev;
> +	int ret;
> +
> +	ret = uclass_get_device_by_seq(UCLASS_MTD, CONFIG_SYS_SPL_MTD_SEQ, &dev);
> +	if (ret)
> +		return NULL;
> +
> +	return dev_get_uclass_priv(dev);
> +}
> +
> +static ulong spl_mtd_read(struct spl_load_info *load,
> +			  ulong offs, ulong size, void *buf)
> +{
> +	struct mtd_info *mtd = load->priv;
> +	size_t retlen;
> +	int ret;
> +
> +	ret = mtd_read(mtd, offs, size, &retlen, buf);
> +	if (ret && !mtd_is_bitflip(ret))
> +		return 0;
> +
> +	if (retlen != size)
> +		return 0;
> +
> +	return retlen;
> +}
> +
> +static int spl_mtd_load_image(struct spl_image_info *spl_image,
> +			      struct spl_boot_device *bootdev)
> +{
> +	struct spl_load_info load;
> +	struct mtd_info *mtd;
> +	ulong offset;
> +
> +	mtd = spl_mtd_get_device();
> +	if (!mtd) {
> +		puts("SPL: No MTD device found\n");
> +		return -ENODEV;
> +	}
> +
> +	spl_load_init(&load, spl_mtd_read, mtd, mtd->writesize);
> +
> +	offset = CONFIG_SYS_MTD_U_BOOT_OFFS;
> +
> +	if (CONFIG_IS_ENABLED(OF_REAL))
> +		offset = ofnode_conf_read_int("u-boot,spl-payload-offset",
> +					      offset);
> +
> +	return spl_load(spl_image, bootdev, &load, 0, offset);
> +}

I believe bad block management is critical during image loading, as
this directly impacts the device boot flow. But, I do not see any check
for bad blocks or logic to skip them in the load_image implementation.

Regards,
Santhosh.

> +

