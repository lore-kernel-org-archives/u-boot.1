Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F96CCF9E3
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 15:09:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A98EC83B1A;
	Wed, 12 Nov 2025 16:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RU8qqdzi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5524783C93; Wed, 12 Nov 2025 16:09:03 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E752883A6A
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 16:09:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H14VSM8BV6Tzlrn1pcV1w7ALDUS0ebZI6YSG+0wI+hBf4rUIqHCAxXffjGjSq5PI0PnCVdmt9dBFx/uhE5TLOTJTLH63MbWBJMNhbBmIKswguC3nBwH9LAY6ck2/SoUPgLoW+ryDQrHyW3+iznrqTCivRJUFQW+187P1PENNxt4xtiwC39oYfRHT8BO3LDpVI1UrBWEDVGU6nvfiOX445H6eBn2ghtfQexPRWXmFvidVL6GaOWGt/Evvs4DmVKYzHcRCu0MxgP9r4bAkDGaPSqLV1X/0iTcyyq3G7ftn8f0hsOuq3OnvxxoKj2Qf4LBJyHP6NKJe0jLoLHqeaLRzWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5M0h+cPNYDFAoRSTJxW7hBYYlMlNbWB+IlOO2isHMs=;
 b=So1Kg6K7TU/slAgHaMy0LIreTLHXdWZHd23cfMoU9XTPt/mwMAd810jvDwJm4apXKukBY4+N0dmny4EcLOVXy3rm97UzBaet5VKxHHLfiJiv2CZE4J+bsETCXJiAqGuMelVrT19Ky+8vY5+xUhQa32GRlLcIzoZfnMRLyHxSw4ihqhA7xm1agRMwwHjkbbXISn9aSSfbL81FwYhyC/irfylQNL0xremeqvNgtKPsvfBNR9HgeZKMmes3RtVwrittx7+Z6LmFKYjo2LrJcUrhMWQ/Y61pv7FlgxISHVo8pFMJaSICgsa+wHT3AYszvi7jKcxVCH+nHxXWiZZ9CB/BaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5M0h+cPNYDFAoRSTJxW7hBYYlMlNbWB+IlOO2isHMs=;
 b=RU8qqdzifWYiZvdbFlxL+89imGOyWw0Q+V/Yf1RURoYIudO6QpjjYZMwBUEOQYsUxOiJlAKjHgr2sG57rkGiB3+HtuOcgIG+GDLWMuDuz1J9g6eFnWDQ7RhxvFZ/fcSFZaqYtlA8Z0K/D7sla5CF5IJqSZIvL5RvOHH6Xxkhg4U=
Received: from PH7PR17CA0045.namprd17.prod.outlook.com (2603:10b6:510:323::10)
 by SA6PR10MB8086.namprd10.prod.outlook.com (2603:10b6:806:446::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 15:08:57 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::dd) by PH7PR17CA0045.outlook.office365.com
 (2603:10b6:510:323::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 15:08:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 15:08:57 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 09:08:52 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 09:08:51 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 09:08:51 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACF8lVe2843950;
 Wed, 12 Nov 2025 09:08:48 -0600
Message-ID: <ac1472da-3d1e-4975-9815-50a83b4abd9b@ti.com>
Date: Wed, 12 Nov 2025 20:38:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] configs: j784s4_evm_r5_defconfig: Enable configs
 for PCIe boot
To: Hrushikesh Salunke <h-salunke@ti.com>, <trini@konsulko.com>,
 <c-vankar@ti.com>, <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <peng.fan@nxp.com>, <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>,
 <jm@ti.com>, <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <danishanwar@ti.com>, <u-kumar1@ti.com>
References: <20251112064725.1049199-1-h-salunke@ti.com>
 <20251112064725.1049199-5-h-salunke@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251112064725.1049199-5-h-salunke@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|SA6PR10MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 54073f05-81c0-45e7-7b36-08de21fd66fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QllrRmJvUDBIZnF3S3dsMWFFWHBuNktiUWhjalMrSG5kNytxbkozdGRJTzN0?=
 =?utf-8?B?OHNuNmFVV0s1dUEyYmp6Myt3SGFKeUsrMnc1Ny92Rmp4aG55MTQ1VENTSDJG?=
 =?utf-8?B?WmNnWWxrcTF0cWxxMU5PNThmRHY2TnVyVkFlOWZWWkpod3JLaFlXOTlaNXp0?=
 =?utf-8?B?aTNibVJWR1VWbjcrcHowS3Y5RkV2am40T1FRTUdpM2tFS3NJa1lVaXozUEk4?=
 =?utf-8?B?c2JXcXFnUHlaUkJVM1lMN1RTTVZORVJlMmx1dFA5cENrS3laQlYyam1CRkRm?=
 =?utf-8?B?NmJrbGJxVkxTNW1QbktkUFQzUnJHMlBsald6ZmxPMkNFSkZHQWxaM1I0SE53?=
 =?utf-8?B?TlNaL0U1SE96TXkyZmVxZllINmhEZUJUVHlBdUw2NTEvLzJIb2RuQXpObDB4?=
 =?utf-8?B?Uis4ZURrZHBwMGt1Q2tZeVd3RXRzYVFNaVJYdm43NHJqV2pTU3QwY0J6Yjg1?=
 =?utf-8?B?ZXNpalg0Rmd3WGdTczQzTkY4cFVZbnVoRmRkQWJ6ZU5PeFFnQWswK1Q3czNr?=
 =?utf-8?B?STZxOXV1VXdXb0RQdTJ4WlQxY2NTNUpDemIzTnNXR3BGTzZDMlhLdmY1UGNR?=
 =?utf-8?B?Yy9kYyszaHlwcThFQWlBZmV2TEZLSVIrNExHTmpMQStURDNoSUYvSGJCRVlK?=
 =?utf-8?B?SlJvYkt1Z0JCbWFvYXFsL3k1TDIxTDVSSUx3cnJvQWdUbmRPaG9DUkVqY2Mz?=
 =?utf-8?B?QmllR1orNnZ5dlBiY3ZFY2M3OC9jeFR5Q3pvaHpoVnVqVUVMUEVpdEZJbE5j?=
 =?utf-8?B?TzBFbmJlTUgzVTFpaW5DSitEV1h6VXlVQ1AvNjlNTXUzZytnZWRRZkZLbTdt?=
 =?utf-8?B?QXdmV0Q1OWUxQUNUYVNMZXIvS2MweDRFOFhveERnOXlVRHBKZSsrTElOOXJk?=
 =?utf-8?B?YnE5ZjA5dERrVUtGQzVITSt0R2VLNjV6YlU4dTFXTmJnd0VJN2lZbFlyeUx0?=
 =?utf-8?B?Qi8zYXRHcWVQRnVjbDhjNm9zRFBRZUFScHZJWHR2QisyczN3TmNERjVzWHBG?=
 =?utf-8?B?TGViMjJENk9ncXFPeFpQM1F3K3ROOTZHZGZyVG82ckczU3hUWC81TEVUMUty?=
 =?utf-8?B?V2VoaUxLYU5acnRjWjYybThkcURxVGJ3S3ZYNGFyUWVqNTJlWFV2MXpyUDZG?=
 =?utf-8?B?RSttTUZKTWVXMjFNU0R0Uy9DTERxZjF0V1R6SkQ2WGg2N0U5UFF0ZVpSanQw?=
 =?utf-8?B?QUxHZUJ1bVp4WGU2Y3dlaE5LQ1U1eXZBZTBrS3ZUSDNYZTdTVGM3Qm42NVR1?=
 =?utf-8?B?d2swaThIOGU0UXM5amJXMGxJa1RZN1kwM1RuRDB2STZPTHk2VFZMbWh5Q2Ew?=
 =?utf-8?B?VzlCbVZYM05LaFJHdXhoWG8vaTF0YWRJdzlXMTMxVXlIa21OQm42cXMvWHU1?=
 =?utf-8?B?UDIvM3NTaklXVStUSGoxMlQzQnFSemVGTGM4dU0xTlVReEhKNzIxbmtvU1hx?=
 =?utf-8?B?VmtwUzJ5ZGxGQ1dFL1Jyb2IxVko5L0g2SWJFZHpNblc0aUlIakFiSUlodW5C?=
 =?utf-8?B?cVRxOEhOSStDaFd3eHRZL1pibHpBTnVGZWxUUmFhNUZKU1lwdUV1QkNJKzlp?=
 =?utf-8?B?Z1NCeDRpZEFDN1FLSVpNMkJuOEFzR2hYUlRrL3ZmbFFnbWVXSTJmNXJOdzNz?=
 =?utf-8?B?eWFtZHozVXI4OHFZTXhQcEVLOE1HZ0lGU2UvcDJpL2pHaGpJa3JoZGkrN3VL?=
 =?utf-8?B?RE4zckJtL2FuRzQ1TzZyT1BMZUJxSkdQOXZPTytQT3BtL0lXSU0wTWN5RWE5?=
 =?utf-8?B?dUdpandOVkNXQVdRL0xoQnJsck1GVmxPTHRSNHd4dGNpNWlEL3Y2MTVwUmpT?=
 =?utf-8?B?dEg1R3lBVnBqL1BCVDQzMjFuaVJaeVlzaFhMeWFyWkdpeHRsVlFKVHU0SWdM?=
 =?utf-8?B?R1Q0S2FzdWRiMm9MSHNBM1N6QklmaVFtMGEyMkw2NjJNYlJFRG1BVGJaR2pQ?=
 =?utf-8?B?Q2YrT29RU1FkOVBvWStLS0NUOXhBYm9qdHpGRG9FOHdFbUpid1ZFOFIrbWNB?=
 =?utf-8?B?RzQ0MG5WaDFobm9lRFAwaUYyZ3I5Y2NwckJVSE1aQmVnRk8rRXBtUDRQV24r?=
 =?utf-8?B?RlcxSDZpRnBxQUhxMjl3eGw1UTJHZzRJUnFiTE5yQ0pvMWJrOXBPeG1QcFR0?=
 =?utf-8?Q?q8y/sTBJtlzFKDUDZnRddsOlQ?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:08:57.0803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54073f05-81c0-45e7-7b36-08de21fd66fa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8086
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


On 11/12/2025 12:17 PM, Hrushikesh Salunke wrote:
> J784S4 SoC has two instances of PCIe, namely PCIe0 and PCIe1. The
> PCIe1 instance is used for PCIe endpoint boot. Enable the configs
> required for PCIe boot on the J784S4 platform.
>
> Additionally, enable configs for J721E WIZ SERDES wrapper, Cadence
> Torrent PHY, and MMIO multiplexer. These are required to configure
> the SERDES lanes at the R5 SPL stage for PCIe endpoint operation.
>
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> ---
>   configs/j784s4_evm_r5_defconfig | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
> index cc340a2fe76..a69a253ad12 100644
> --- a/configs/j784s4_evm_r5_defconfig
> +++ b/configs/j784s4_evm_r5_defconfig
> @@ -52,9 +52,16 @@ CONFIG_SPL_FS_EXT4=y
>   CONFIG_SPL_I2C=y
>   CONFIG_SPL_DM_MAILBOX=y
>   CONFIG_SPL_DM_SPI_FLASH=y
> +CONFIG_SPL_PCI_ENDPOINT=y
>   CONFIG_SPL_DM_RESET=y
>   CONFIG_SPL_POWER_DOMAIN=y
>   CONFIG_SPL_RAM_DEVICE=y
> +CONFIG_SPL_PCI_DFU=y
> +CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS=0x80800000
> +CONFIG_SPL_PCI_DFU_BAR_SIZE=0x400000
> +CONFIG_SPL_PCI_DFU_VENDOR_ID=0x104c
> +CONFIG_SPL_PCI_DFU_DEVICE_ID=0xb012
> +CONFIG_SPL_PCI_DFU_BOOT_PHASE="tiboot3.bin"


Since AM69 and J742S2 share , this config.

So please test on these two board as well,


>   # CONFIG_SPL_SPI_FLASH_TINY is not set
>   CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
>   CONFIG_SPL_SPI_LOAD=y
> @@ -122,6 +129,12 @@ CONFIG_SPI_FLASH_SPANSION=y
>   CONFIG_SPI_FLASH_S28HX_T=y
>   CONFIG_SPI_FLASH_STMICRO=y
>   CONFIG_SPI_FLASH_MT35XU=y
> +CONFIG_MULTIPLEXER=y
> +CONFIG_SPL_MUX_MMIO=y
> +CONFIG_PCIE_CDNS_TI_EP=y
> +CONFIG_SPL_PHY=y
> +CONFIG_SPL_PHY_CADENCE_TORRENT=y
> +CONFIG_SPL_PHY_J721E_WIZ=y
>   CONFIG_PINCTRL=y
>   CONFIG_SPL_PINCTRL=y
>   CONFIG_PINCTRL_SINGLE=y
