Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247B6CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 06:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B14E83A3D;
	Wed,  5 Nov 2025 07:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GI84iBgA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58F0183A41; Wed,  5 Nov 2025 07:05:16 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1447283A35
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 07:05:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akTJJCXgw8OAW80bdwysGdjUZF65QZ7YVXLN9kXoY0HufpvzLRy2L6YFQxK9x0GgyoeCdWOTZeqZ8kqpeWi1e0Skz2jbPG4spFctOGj0uz3ZBVt6nsB2lprqvo1khoIpnrNGHllcO5+6KZ29zRSHxl89Dqwg1zqZQWnra+Ob56Pbyw8aYPEEneaKXM/t6aDkkmcXkqPYZPLwjrht/EqXzfu6q6f+7iw0vJgcnFCTyOS2pDzCvEE1cghc/BzcFsUQaPzcLqRMqJ6rd6jdIE2W6VAQzKm/ewanG3wkO6I9vZlZHqR217RoDGmtUOeTZ/t6q7vEIXrRlmjgo3AjxMxbWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSbQfg2jp8Esq7WwaK2zWVBcpp2iAeNSk7oagJGeMsQ=;
 b=hCYuNLQ8JURybk/l68JsKkkQOtumQFFlUxn5Tnvcnr6H2W4jEGIcmfldiYSv0FPOlSi4ZFXVoQYRFfVTuD0e9VIyrrkANG0SLcuRlL8FzxY/EAiCr8U4LlXFOAT3yYGMYQg0SljMLuo0OZ5/uhmsBy8T7HVzQ+l+J8hBafucSduTbHp3s6uXvuh0McPALy5P+6k1yyhq54mAMoAiFhqvw54A7JfqwC/rIlER1NOGBMlXUQZvhpfNUk5ZkyV3h83AllfwumrtLa7ek1KdXIKQoTzSxncFisqMVcH03ew9euPCKQ/R0WmWvYN2ZFXvg6Vm0tGR7l0g74fLbg19h8SYIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=dh-electronics.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSbQfg2jp8Esq7WwaK2zWVBcpp2iAeNSk7oagJGeMsQ=;
 b=GI84iBgAxLzXSjldJYBR/izJH+gfvgGp3vDB2WLoAbbz8Cjyps+WthHcsoZT/ZOHrbVa54Uft7IETP97fNKxQjJy7Bd7fyb4qaS/BYlch6eyNXVns57574XxsBr2RmJKmiHj2tvsybtneIArw8cf3znFS5v0wxVRo4OstY8Iqxs=
Received: from SN6PR2101CA0008.namprd21.prod.outlook.com
 (2603:10b6:805:106::18) by SJ2PR10MB6964.namprd10.prod.outlook.com
 (2603:10b6:a03:4cb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 06:05:09 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::91) by SN6PR2101CA0008.outlook.office365.com
 (2603:10b6:805:106::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.4 via Frontend Transport; Wed, 5
 Nov 2025 06:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 06:05:07 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 00:05:05 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 00:05:05 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 00:05:05 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A56541S3219593;
 Wed, 5 Nov 2025 00:05:05 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 5 Nov 2025 11:35:03 +0530
Message-ID: <DE0J9DJSVAS3.339E9U0OW3BPI@ti.com>
CC: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>, Judith Mendez
 <jm@ti.com>, Udit Kumar <u-kumar1@ti.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Vignesh R
 <vigneshr@ti.com>, Christoph Niedermaier <cniedermaier@dh-electronics.com>
Subject: Re: [PATCH] configs: am65x_usbdfu: add
 SPL_USE_TINY_PRINTF_POINTER_SUPPORT
From: Anshul Dalal <anshuld@ti.com>
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251105-am65_dfu_fix-v1-1-acc29111dccf@ti.com>
In-Reply-To: <20251105-am65_dfu_fix-v1-1-acc29111dccf@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|SJ2PR10MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cfb2939-2ec5-4a29-f21c-08de1c31452c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|34020700016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFpzaFA5b1VJMnF5RmlKUzZocVJneVAwZDhYWmJlclc4MytubW92RGVWbnZX?=
 =?utf-8?B?SW1yMHRhRDY3VVl5amY3U3BTaDRIN2xOL00vMzU0enhSNlhsaG0xbGgrV3ND?=
 =?utf-8?B?N0RicVl3RktjSktIMnd2OFloZXhlNzF3UERURHZlekRKTGFFeXRmSEkrdWZm?=
 =?utf-8?B?NmhKNTV6OEphTVY4YkxSeDRSeTBkTWthbko5UjVmYkwxOGFDWGJnYTdJUVVH?=
 =?utf-8?B?QVNrNUJHTHg0RHhsR25MUUxVU0ZUblpuR1J5bVRHdy9YMlhOQ2RBQjIxNGRW?=
 =?utf-8?B?Tm5xR3U1M0NKVU1UQzNDS01XVzRKTEdqdFREQ0lMZFJVcS8rQlpvNUZHb1ZN?=
 =?utf-8?B?eVhRcFRxOTJNR1hRT0pqWGlIbFVuenpEMUdxNW5ZVU9iaC95SmRoZC9rUGdS?=
 =?utf-8?B?WVN3YzN1Nktlbm54bHhLVTFCTitudjdsa292SnZoUGpDU2dKa3RaWG9SbVVU?=
 =?utf-8?B?V0tuNjlFSUJKS0ZVdzZ3ak8yV0JTODV1aUZ2YkpZR0F3cVhaYmwxQmFHcFU3?=
 =?utf-8?B?ZmJGSUJKNUQwUUdHVWV3L2Fwc0haR2ZPRVRkcTZneUZYYThjSFRqNENFOXdE?=
 =?utf-8?B?bmhUdm9CWVNqNDJCSUJsQmpiZnhMMlJVdHd4NG9KNmRoZjB4dU8xSHNJclBl?=
 =?utf-8?B?Uk0rNm9MYm1ET3dTUDlBaWpPbzdkNU9wN3BRZ0g0aHpEZmRyNlZQa3ZOUDVR?=
 =?utf-8?B?OVpOMDh0dHZpVjFGK28rLytSdktUMENWeWhCMHI5c3NLam5PdDFhanNXM1N6?=
 =?utf-8?B?ZlRqZkFaeUpaTTlOdVBDVncvRWlHSk53dTlERFduNXpoZVZ0RWF2eG1pdVJW?=
 =?utf-8?B?alNCS3l2R0Q4SWVScHRyZmxkdXJNazRWajhPSnpvMUxqeTh2VWtDVFNiQVA2?=
 =?utf-8?B?cFdQUnNHSWJoeXBoR3M5T2JscCttOXVaZFhwa1kvWFhVcTlnOHVNRTE5SFZ5?=
 =?utf-8?B?Ym5RQ3o3NlIzL3VBQVl5R3lnN0FwQzAzNWJaa3M5ZVBBcE84ZFFFVjVzM0wz?=
 =?utf-8?B?TzU4MDZkNzN5NVhiNHNFTGdJdkVmWTFlcmoxa3JuYzJraXp0NURhem1XQm5w?=
 =?utf-8?B?S0t0THdqTTFwMTZLa2RNK1Q5OW5tbFVtTFdaaWFvckFZRUdqVEgycEJJNjFw?=
 =?utf-8?B?OElsM0dFZFc2bFZMb1ovWXY4LytEY2ZoZDNoaDJRblArZTdoWHpuMFhRYmRZ?=
 =?utf-8?B?N3BTZ2JoOG9DYXZxK2NuMVp5N0FUUHR5ZVozSkFzY2VPdTM0Mmh0SDZqL2FB?=
 =?utf-8?B?TUtxMGVETkV0RU1ESWdydzZneEYvbWVGY3ZBZ0NLZm9rY25ZYmFqbFRlclBh?=
 =?utf-8?B?TVQvRlNqeTZmbHY0MVRLZ1FZR28xZHdrYWw5YWJrQUZVb2diNlRHbEpGY1hr?=
 =?utf-8?B?c0o3ckZLSTQ4dENxVzJiTFgyMlM4L0lxMW5veXcvR284dEVkVWpTckcvaUJ6?=
 =?utf-8?B?V1hIYVU3ZzBJdDlqam9XVGVxSzFOZzlOU0VVZnBETE5LUlJLUmQ5MmFqaEdp?=
 =?utf-8?B?U2VhOW01cTBKb2dSSlUrb1VNcDNwR2hqZnczWVI1Qk9SRFQ1T05mZ1lmb2Nv?=
 =?utf-8?B?WjFYUEFXL0l1NWg5a3MzamZpTGRJa0Zickp4aXZnc2UwcHBKbW5rKzc2VlpV?=
 =?utf-8?B?QlJOeW16a2RLM283bVl1N1RDNzZLakNUbVdLVzdXamJ2YXhvcDhnL0VvUWRP?=
 =?utf-8?B?L003SG9Kbk90SFVCdzFrbzZQSklFc1h3ekhQdENnZmhZUFlLekVOaTdIaVpF?=
 =?utf-8?B?SCtoaVNCRGxWOU55ZW5aQzhRdUQxWkFnVDVZOWpYMVlMdm1yV0pTRFR1VUZQ?=
 =?utf-8?B?S1ZrQjFNM2lNTThXUm94dnpBY3B1Y3pPeEczOFpDY2Y3ZGNSRWhvM3ZJa3hj?=
 =?utf-8?B?M29VYUFDV3VqdXA5NkZaM29ENjhZV3NXRkVwY0NTVXc3TmFaY3pBR3d3WCtB?=
 =?utf-8?B?RnRmRk9jNW1Da0U4eFpPZDFtNEFTQU1SQlJDaVJLT2lLRlFQNXRTZ2IzTDJu?=
 =?utf-8?B?eFoxUlBPK0RzM1BGSEVrQkJzZlBFK2k1MG1kMEtVUFdnc0pqYW1mMWpWSjRD?=
 =?utf-8?B?L1VyNzAwL2psTXUyVmJuS3RSbWJucTlIN0lGcWJRdFJsc3dTbmZzM1d6bDhx?=
 =?utf-8?Q?gqv8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 06:05:07.2089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfb2939-2ec5-4a29-f21c-08de1c31452c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6964
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

On Wed Nov 5, 2025 at 11:32 AM IST, Anshul Dalal wrote:
> Since the commit 1e24e84db41a ("tiny-printf: Handle formatting of %p
> with an extra Kconfig"), SPL_USE_TINY_PRINTF_POINTER_SUPPORT has been
> made mandatory in order to use %p which would earlier have defaulted to
> a 'long' print.
>
> Without this config symbol, k3_sysfw_dfu_download fails to set the
> correct value for the DFU string with:
>
>  sprintf(dfu_str, "sysfw.itb ram 0x%p 0x%x", addr,
>    CONFIG_K3_SYSFW_IMAGE_SIZE_MAX);
>
> The value we get "sysfw.itb ram 0x? 0x41c29d40" causes a boot failure.
>
> Therefore this patch sets SPL_USE_TINY_PRINTF_POINTER_SUPPORT for the
> usbdfu defconfig and also cleans up the usage of "CONFIG_*=3Dn".
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> Not sure if a 'Fixes' tag is appropriate here since the commit
> 1e24e84db41a ("tiny-printf: Handle formatting of %p with an extra
> Kconfig") did cause a regression though I think the problem existed with
> the usage of "%p" with TINY_PRINTF set to begin with.
> ---
>  configs/am65x_evm_r5_usbdfu_defconfig | 63 ++++++++++++++++++-----------=
------
>  1 file changed, 32 insertions(+), 31 deletions(-)
>
> diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r5=
_usbdfu_defconfig
> index f9161f1fe111ff97f7aa79f10b21c3b0ab1dad32..b3def7946b3eb799582f04cc5=
22725cb3f9a6eb1 100644
> --- a/configs/am65x_evm_r5_usbdfu_defconfig
> +++ b/configs/am65x_evm_r5_usbdfu_defconfig
> @@ -6,6 +6,7 @@ CONFIG_SYS_MALLOC_F_LEN=3D0x57000
>  CONFIG_SPL_GPIO=3Dy
>  CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
>  CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
> +CONFIG_SPL_USE_TINY_PRINTF_POINTER_SUPPORT=3Dy
>  CONFIG_SOC_K3_AM654=3Dy
>  CONFIG_K3_EARLY_CONS=3Dy
>  CONFIG_TARGET_AM654_R5_EVM=3Dy
> @@ -41,34 +42,34 @@ CONFIG_USB_GADGET_VENDOR_NUM=3D0x0451
>  CONFIG_USB_GADGET_PRODUCT_NUM=3D0x6162
>  CONFIG_USB_GADGET_DOWNLOAD=3Dy
>  CONFIG_SPL_DFU=3Dy
> -CONFIG_MMC=3Dn
> -CONFIG_SPL_DM_SPI=3Dn
> -CONFIG_SPL_MMC=3Dn
> -CONFIG_SPL_FS_FAT=3Dn
> -CONFIG_SPL_SPI_FLASH_SUPPORT=3Dn
> -CONFIG_SPL_SPI=3Dn
> -CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dn
> -CONFIG_SPL_DM_SPI_FLASH=3Dn
> -CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=3Dn
> -CONFIG_SPL_SPI_LOAD=3Dn
> -CONFIG_CMD_MMC=3Dn
> -CONFIG_ENV_OVERWRITE=3Dn
> -CONFIG_ENV_IS_IN_FAT=3Dn
> -CONFIG_DMA_CHANNELS=3Dn
> -CONFIG_TI_K3_NAVSS_UDMA=3Dn
> -CONFIG_SUPPORT_EMMC_BOOT=3Dn
> -CONFIG_MMC_HS200_SUPPORT=3Dn
> -CONFIG_SPL_MMC_HS200_SUPPORT=3Dn
> -CONFIG_MMC_SDHCI=3Dn
> -CONFIG_SPL_MMC_SDHCI_ADMA=3Dn
> -CONFIG_MMC_SDHCI_AM654=3Dn
> -CONFIG_MTD=3Dn
> -CONFIG_DM_SPI_FLASH=3Dn
> -CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dn
> -CONFIG_SPI_FLASH_STMICRO=3Dn
> -CONFIG_SOC_DEVICE=3Dn
> -CONFIG_SOC_DEVICE_TI_K3=3Dn
> -CONFIG_SOC_TI=3Dn
> -CONFIG_SPI=3Dn
> -CONFIG_DM_SPI=3Dn
> -CONFIG_CADENCE_QSPI=3Dn
> +# CONFIG_MMC is not set
> +# CONFIG_SPL_DM_SPI is not set
> +# CONFIG_SPL_MMC is not set
> +# CONFIG_SPL_FS_FAT is not set
> +# CONFIG_SPL_SPI_FLASH_SUPPORT is not set
> +# CONFIG_SPL_SPI is not set
> +# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
> +# CONFIG_SPL_DM_SPI_FLASH is not set
> +# CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT is not set
> +# CONFIG_SPL_SPI_LOAD is not set
> +# CONFIG_CMD_MMC is not set
> +# CONFIG_ENV_OVERWRITE is not set
> +# CONFIG_ENV_IS_IN_FAT is not set
> +# CONFIG_DMA_CHANNELS is not set
> +# CONFIG_TI_K3_NAVSS_UDMA is not set
> +# CONFIG_SUPPORT_EMMC_BOOT is not set
> +# CONFIG_MMC_HS200_SUPPORT is not set
> +# CONFIG_SPL_MMC_HS200_SUPPORT is not set
> +# CONFIG_MMC_SDHCI is not set
> +# CONFIG_SPL_MMC_SDHCI_ADMA is not set
> +# CONFIG_MMC_SDHCI_AM654 is not set
> +# CONFIG_MTD is not set
> +# CONFIG_DM_SPI_FLASH is not set
> +# CONFIG_SPI_FLASH_SFDP_SUPPORT is not set
> +# CONFIG_SPI_FLASH_STMICRO is not set
> +# CONFIG_SOC_DEVICE is not set
> +# CONFIG_SOC_DEVICE_TI_K3 is not set
> +# CONFIG_SOC_TI is not set
> +# CONFIG_SPI is not set
> +# CONFIG_DM_SPI is not set
> +# CONFIG_CADENCE_QSPI is not set
>
> ---
> base-commit: 1c250e444ad3b15315ee8b0fcb3fc3acc26449e2
> change-id: 20251105-am65_dfu_fix-1144eec06b19
>
> Best regards,

CC: +Christoph Niedermaier

