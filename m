Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FFEC44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 06:21:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E072E82991;
	Mon, 20 Jul 2026 08:21:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pYdDg9oe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9599283E76; Mon, 20 Jul 2026 08:21:19 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com (unknown
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41A7580517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8BRoBZAECJAHk6yMyNje70A9yRFmTV22uHHRs4SHHQikoVLpugOhkdmVdcl6I2z7I2sxtUgkn0zg0kBNgnhGE+b5Eo+PqEl8fHCA6ztaHldLZX5OsvU+gRF55l5ykm0Ah+av/8zRykqkEGHK8ocb+qCvZS79LDdLf6GaVBPb6f/dPC7y7FQqTKCtCnbHRINt9JH/itt87KM24E14OAxQCclcUtLmYChJtlJ6nKpb7QJqk+SBceMcdFVo0hP3YRJQO023JitxShtC5ilr0OqmlbBirzmR3L7XTzSDTQjBqTXkVQ3RAnWJFzHTZrHyT17Fkf90eQlpAnP+cyqxuUZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MP91Yt7iWzZZLqLJbCsGGpEoP/jf6TY0B9/0d3S+BQ0=;
 b=Fqu065RegCZYgyhoHi0Q5IscHV6WLjGFwIzJ+qGA9tY+FttimBy39UN0m2XEuGWhVj6tgin15s1i92kbHeFUSZaSo8SkjWki3oRISz6J9PAncvjBG/TCrQpJn3e6R7s0hB/a/AlngkN57QN2ugIIgQzcMIA4lH8cju5BBCj+JaXeioCn6sSWa69rJ58xewDmDU74Tg5W/wWNXISPfudj7zP3yPlV5w9N0GenaziIVmwREoq/id+R5tT9OD/PvZt39bRTxpnytD9jXqbJhaC3UDDfGvwWH5olhAXHSS/W4UFwlFVR8/3lK5AmT6MX+bDRYbHfcaN0A066AJfYcJejaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MP91Yt7iWzZZLqLJbCsGGpEoP/jf6TY0B9/0d3S+BQ0=;
 b=pYdDg9oeWFESaq/WOkQiXMsCpSRUQsdsK8N9+N5W7/yjQJlEWO4n0EbMUxO5L27xsNdBs4S2OGJdl1TwT4d4WrKY8yXYg4y+ECvQOSN1BBwg8j1GP2Kbcer+pYhbDYDh4bzxUjrPW5MuDg6gbIVSBIe90JOzf49copupWJ8i4PU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 06:21:08 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 06:21:08 +0000
Message-ID: <d38109ed-eab4-4fd1-9e61-9e5a3268ebd5@amd.com>
Date: Mon, 20 Jul 2026 08:21:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: versal2: Make hardware.h assembly safe
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
References: <de4de47ea457b285c5870e7ba25b4baf554561e7.1783493630.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <de4de47ea457b285c5870e7ba25b4baf554561e7.1783493630.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::12) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 1598edf7-9dd0-4916-c3e8-08dee627164a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LIIna3VoGW2A8TXmBGD0eI0XLAB0AWTVK9vtwjg9QsXHq9Jz4bix3aDxNATjOxK2D3JScou62huM7MlwX/w+f3m11WDEgHRA6gPo0wcM0m+q75JMZxdVQzz9PVv5xiK9H8pv/2/qPU6AJ1xHZhuvYH8mtdro+BwOVEMNMSlicwZxpoRO+fvgGd84eA1E3AZgCPdSjDIW6rdnaAm2tKiSiHAxFbEYZiQM8cLqxHsEg+/QYFu3nnIpR3TWLFDrN44Nvrl674Odh+T932qIpP02u9AAhCC/cJMYo0K/nkM2MMsP0RfiroajBZCwKgN58Flms4wrmPlu430MVZ5ZbFQaheqTEUlJ2SWLYGFxsgqdDDMdA40eD9zNwS3cHohx8oTjPHcmEB48PgLFDRPsHn58ytPAMjxX2O2YqX93gyTHLl3WjSbIe8t0AlP3H9hYWOAgaXFzs6OopHVOfG9NOitToFG8Q7BMFsR1Kc2MLVYUGqBAhfLjYrff2qd+9pfVtkFlzlCuL+Q3PxH9+VjgHnyR+430LiUFkx2epbVmNb2oHMxOTSBfzwz2nSqd/BeEUwjCzJHQo0Cg8qkll/eZIwLxX9iM/eQKUl50A1OO2Av16cm/aDC6xergxQqpgOeN/fumSgw1hrKmeksgiW1QUk+BYKuB8P13gbpD/dLf0mQfprA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTM0aWdibi9XcTFlR3BvWG9UQjVSMktiaTR1UFVCK1d2UDNFb2V5ODM4YW1J?=
 =?utf-8?B?STdZNjRzMWFDWlVyUzNMRTh1cE9zc0ozQXlzOVBZRXNPeXI1UTdaYkN6WGJv?=
 =?utf-8?B?dVhsWkFjKzJSVDl0eXluRVBoTDNTT0dibStDQ3RYdVdrUFF0YmNxUkRnSXg4?=
 =?utf-8?B?Mjh1aWVjYkxVRTdNR2taNDlkT2FEcmZBQVNLaHNsZDdnaGFuVVhxRUdSU1Na?=
 =?utf-8?B?VzFFdzFYL1RFWEZ4ckFZTlV0SFo1cjErTWRGUktPWGlXVW8zZkJBV3lQb01z?=
 =?utf-8?B?WTUvWkhLQW9lUXdiNm9RbEpkSUcvaHBJVnNQVXpKMEd1TmN3dU5WTGwvcklh?=
 =?utf-8?B?VnAvMEUrUGk4SzNUVDZtRC8vNG9seWJycGRTTlhqWEdRbE5iZ3NxRnF6UjJI?=
 =?utf-8?B?NGdsenBjR3k2SE5XeUNBampLV2VvbCtmclNWTE1lYXRPSkQrK1dCOHJHZTIv?=
 =?utf-8?B?QllPUWF4VmpHUjFzVHROeXNwSG1DdHFzbDNDSGhjUCtDYmFqTmsvdmZtU2Q4?=
 =?utf-8?B?dXE5TU5QRy95Vmh0aTB2Ym0xQVhMTm56Z3lqSndhT2MveHFMdWEySVA4eGZL?=
 =?utf-8?B?T2o2RWJydzl5T3NwV1V2OFg5RVc1ZWppNHJhdXE3aElPang3TktYVFB6YjJu?=
 =?utf-8?B?cDg4WVczQmRPNUhGVG92dlo1SXRoa1JWWXFmZzdaV0tiSHlxSTJ0Q1hITDJH?=
 =?utf-8?B?UUkwdWdtK0FSTE96MnVJakV5R2IwaEQ5cTdWanEzQllGcVVrRlpXb1dRK2ps?=
 =?utf-8?B?YTVsMVVDaDVmT2taQkNIZzJQN2t1cFJtUHB3eFhkdTVBK2EzQXVtNlhySkEz?=
 =?utf-8?B?MkRtakhJRmFuSG1lRTFoSGNibWRDMXBON2hFRndHMVhQK0NJRzg2QXFLU1Bq?=
 =?utf-8?B?L0lLVGhIdlVoTE9HelhPczhQOGcybUpJRUM2b2hSN1B0Wm0vS0J1bm93VUlv?=
 =?utf-8?B?RkhyZkhic0tJQXBDb1lxa25hdm13aXp3RUVmZkE4MExiM05RS2hlWEZKVmp0?=
 =?utf-8?B?WjV1Y3ZPcFRHOFpTczBwQTAwdUprbEJZNkVPek95ZDFLZDdtZU5EdkhDbEl1?=
 =?utf-8?B?b3ZMSWtkQjBKRDNvYW9iMkVSMzZWekp2UC9QRlBlam5QNTg2NUZLMWl3YWFu?=
 =?utf-8?B?dWdEMWFDekx0ZW1Jam01bFdvM3RTZXlGV1ZicGk2dk51NU5jaTg5V0tia1pi?=
 =?utf-8?B?VmhHK25YZmlQanU1MnFOeEIvODZrWmhyM29kTituVUNCazZheS9PSjQ1ZkFu?=
 =?utf-8?B?anpJbk12cGRRbXh2QmNIUXBKT3lNelJaZkVvcDF5QXFXSUZlVTdpTTZpcXVZ?=
 =?utf-8?B?MEdYNHBDMm1BQnI4QTZVQlF1L1VGRTJsTjJCZkxXZktJbDNEZTRFajByMmhx?=
 =?utf-8?B?MjBUUjBlZk1TK21nWlhESmJ2WkwwM2w1cG5pWjFIWjdwMy8venV2WEpEYzRD?=
 =?utf-8?B?MTJKdE0zUjl0Q1V4S2l5cTgvcjBWQ29wSktzQllhZW00Y0ExdGx6dmpSUmhQ?=
 =?utf-8?B?OGh0VXUwb1FoWWduK3RwME5vanVxaHdDVmw1TU9sMWZDcEttdnRRYzV2bzhr?=
 =?utf-8?B?S3c0WmRzZlVRelVoYnpXZmlZZ2hLK0hNeVd5RWd5N0tYN2VrYnBRdFZCdW0y?=
 =?utf-8?B?cm9JdXl2bFVhd0Z3TEV4VkZUUUlQS3Q3MVFaOW5oTDlOa0IrYXV3QVB2UW9r?=
 =?utf-8?B?QzF2a1AyYjY5NEI4aW9SclBtUEJra1ZnTnFBem5YU3B2L09CT1gwM2J0NDdL?=
 =?utf-8?B?dHRyTXp1Qkp5VUJYWENENjVsVTRmdFo5RTdJamtSZnBUNUdGS2MySTlhbGdX?=
 =?utf-8?B?bTVncmtZazRsL1oxd3FLanV0NEs2K3pOWGlOcnhzTjFlbmxPalcwUk9pUXdF?=
 =?utf-8?B?eFhBV3JCbVlEMnM0ODcxVG5BZVhDdWlBVUg1dEs1MkYrbWtBc1VlaTBxeXE0?=
 =?utf-8?B?aWljWUk2bU4yUDN5S1E0enlzUkxhL1NROFZMN2p6N2hJY3NEM1Q0RWlIZjFa?=
 =?utf-8?B?U2Y1RWlMY2dPZHB6Z2tvcklkaDU3Tnl0NGs2SVdsTHhVZjRlZnc2enk5WDYx?=
 =?utf-8?B?YVVST2J1aURzNWRBNzNUUFhFVVpPUTFVMER6bUNYMWFQUDN0OUM3SmtOL3o5?=
 =?utf-8?B?b0ZpZ2E0bFhGSDQ4cTZxd2V6Zk82b1VjN0hEbUNzOWxpUlJ2STNmQUdEcWNT?=
 =?utf-8?B?dDZ6OGhGczdqcEFPd2xXWjA3UURWcUZLRnRwdW5xaUFaOUx1WnV5TmFudWtu?=
 =?utf-8?B?eC9XTFBobnZ3Y2RyN1EzOFJHMmxEYno3ZXVOMnFtSlRBQ25qc0dBSnoxd0Rk?=
 =?utf-8?Q?gX7hRzRxzUzge3K2iL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1598edf7-9dd0-4916-c3e8-08dee627164a
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 06:21:08.6526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rq0fAys71koQER4f7LsHnp9jgtRPb0YeHXDh2qhJ8Svo9E2/vvt8M73uOCT6Fzft
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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



On 7/8/26 08:53, Michal Simek wrote:
> The register address and bootmode defines in this header are useful from
> early assembly (e.g. lowlevel_init reading PMC_TAP_IDCODE), but the file
> could not be included from .S because the C-only declarations were not
> guarded.
> 
> Reorder the header so all plain address/value defines are visible to both
> C and assembly, and move every C-only construct (the linux/bitops.h
> include, the register structs, the base pointer-cast macros and the
> platform enum) into a single #ifndef __ASSEMBLY__ block.
> 
> No functional change for C consumers.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - new patch in series
> 
>   arch/arm/mach-versal2/include/mach/hardware.h | 82 +++++++++----------
>   1 file changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/arm/mach-versal2/include/mach/hardware.h b/arch/arm/mach-versal2/include/mach/hardware.h
> index 1bebf20910a0..7977529fd6c1 100644
> --- a/arch/arm/mach-versal2/include/mach/hardware.h
> +++ b/arch/arm/mach-versal2/include/mach/hardware.h
> @@ -4,34 +4,6 @@
>    * Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
>    */
>   
> -#ifndef __ASSEMBLY__
> -#include <linux/bitops.h>
> -#endif
> -
> -struct crlapb_regs {
> -	u32 reserved0[67];
> -	u32 cpu_r5_ctrl;
> -	u32 reserved;
> -	u32 iou_switch_ctrl; /* 0x114 */
> -	u32 reserved1[13];
> -	u32 timestamp_ref_ctrl; /* 0x14c */
> -	u32 reserved3[108];
> -	u32 rst_cpu_r5;
> -	u32 reserved2[17];
> -	u32 rst_timestamp; /* 0x348 */
> -};
> -
> -struct iou_scntrs_regs {
> -	u32 counter_control_register; /* 0x0 */
> -	u32 reserved0[7];
> -	u32 base_frequency_id_register; /* 0x20 */
> -};
> -
> -struct crp_regs {
> -	u32 reserved0[128];
> -	u32 boot_mode_usr;	/* 0x200 */
> -};
> -
>   #define VERSAL2_CRL_APB_BASEADDR		0xEB5E0000
>   #define VERSAL2_CRP_BASEADDR			0xF1260000
>   #define VERSAL2_IOU_SCNTR_SECURE		0xEC920000
> @@ -41,10 +13,6 @@ struct crp_regs {
>   #define IOU_SWITCH_CTRL_DIVISOR0_SHIFT		8
>   #define IOU_SCNTRS_CONTROL_EN			1
>   
> -#define crlapb_base ((struct crlapb_regs *)VERSAL2_CRL_APB_BASEADDR)
> -#define crp_base ((struct crp_regs *)VERSAL2_CRP_BASEADDR)
> -#define iou_scntr_secure ((struct iou_scntrs_regs *)VERSAL2_IOU_SCNTR_SECURE)
> -
>   #define PMC_TAP	0xF11A0000
>   
>   #define PMC_TAP_IDCODE		(PMC_TAP + 0)
> @@ -76,15 +44,6 @@ struct crp_regs {
>   #define PMC_MULTI_BOOT_REG	0xF1110004
>   #define PMC_MULTI_BOOT_MASK	0x1FFF
>   
> -enum versal2_platform {
> -	VERSAL2_SILICON = 0,
> -	VERSAL2_SPP = 1,
> -	VERSAL2_EMU = 2,
> -	VERSAL2_QEMU = 3,
> -	VERSAL2_SPP_MMD = 5,
> -	VERSAL2_EMU_MMD = 6,
> -};
> -
>   #define VERSAL2_SLCR_BASEADDR	0xF1060000
>   #define VERSAL_AXI_MUX_SEL	(VERSAL2_SLCR_BASEADDR + 0x504)
>   #define VERSAL_OSPI_LINEAR_MODE	BIT(1)
> @@ -108,3 +67,44 @@ enum versal2_platform {
>   
>   #define PMC_GLOBAL_PGGS3_REG	0xF111005C
>   #define PMC_GLOBAL_PGGS4_REG	0xF1110060
> +
> +#ifndef __ASSEMBLY__
> +#include <linux/bitops.h>
> +
> +struct crlapb_regs {
> +	u32 reserved0[67];
> +	u32 cpu_r5_ctrl;
> +	u32 reserved;
> +	u32 iou_switch_ctrl; /* 0x114 */
> +	u32 reserved1[13];
> +	u32 timestamp_ref_ctrl; /* 0x14c */
> +	u32 reserved3[108];
> +	u32 rst_cpu_r5;
> +	u32 reserved2[17];
> +	u32 rst_timestamp; /* 0x348 */
> +};
> +
> +struct iou_scntrs_regs {
> +	u32 counter_control_register; /* 0x0 */
> +	u32 reserved0[7];
> +	u32 base_frequency_id_register; /* 0x20 */
> +};
> +
> +struct crp_regs {
> +	u32 reserved0[128];
> +	u32 boot_mode_usr;	/* 0x200 */
> +};
> +
> +#define crlapb_base ((struct crlapb_regs *)VERSAL2_CRL_APB_BASEADDR)
> +#define crp_base ((struct crp_regs *)VERSAL2_CRP_BASEADDR)
> +#define iou_scntr_secure ((struct iou_scntrs_regs *)VERSAL2_IOU_SCNTR_SECURE)
> +
> +enum versal2_platform {
> +	VERSAL2_SILICON = 0,
> +	VERSAL2_SPP = 1,
> +	VERSAL2_EMU = 2,
> +	VERSAL2_QEMU = 3,
> +	VERSAL2_SPP_MMD = 5,
> +	VERSAL2_EMU_MMD = 6,
> +};
> +#endif /* __ASSEMBLY__ */
> ---
> base-commit: 3278a671cb521d898e6f49d35f6bc034b2ac4d46
> branch: debian-sent3
> 

Applied all.
M
