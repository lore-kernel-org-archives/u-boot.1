Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA5DE81BD3
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 17:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A0CE805D7;
	Mon,  9 Feb 2026 18:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NudPpqKr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D66D83C23; Mon,  9 Feb 2026 18:15:32 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E4F680325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 18:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIfpE0tmM4upzfQCyLk6zN6MDY36rjJTCm0mY/bxlw85JyxFexrU0whsTqs1PJRoRLQxKZkshMZUYt9v+TnDUa8ng8JMNJYL4sXkqMMccrSYc9I6wMcQOnkeoZt+eHTUmiHaIKPuKbFcD6DxlqFKlWz2CfFcJtGOpyBTpaaitwd0+xdsSXs0uhojScih1wczmdFdFDKmeuAVa5CXJo09F77s/R90qQX/DMFSOBrhqwQRPiSL8lD3D9rwxueiTOjv2t7TSNdUBFr0AAO3/Gp+QBmRdBbzH9oGaxoyQQKfXFWqthDIb4mzdR+87Sq6VpGbt4Tc25MMj8bh0rjGP5kOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+Lnb/xiPJOqlJKC8z0Req/t/xoTLo1GNiC5cgBF0aA=;
 b=IkiHh4hNsVLDtsG7CdKoa/3OjDo1/rB6y94Rj1rf7KJrtfnSz2gWNfxfQfu6cShsZExzPFkEmNzWg+4e1uqmn9hGBlWPG5QsfnohuhI6A+Zso65ZMOOMCS4izg36RAhT6O0dStffaNYdVHsVMW9al45J6s3mg98S1R/1Ul6vFNHM3C+qThgV0jZFvhDUUiPqGBiM1itPadSYRsefhcvpA4bRhTumWHiSG9Ao/LITXOFORiQ5DD96ZY/ZBcw4aWFtkamQRg4sLgMxYAmPO7eMpr9CVMo14AClhvxQ9sztfhyP9wFuEcQPGBlocUlWSkcxYEsxT8t1HLrnUh9EpUbiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+Lnb/xiPJOqlJKC8z0Req/t/xoTLo1GNiC5cgBF0aA=;
 b=NudPpqKrqwXV962TZFaBOtsJTVV5w5TW0jySM6OrdRaH8kHHG9FUUO1Gfe4x9yADjhjEWFyTY6d+5ehhhYcL7pzV+Bt18ePmDGrNHfyo24dbfF/PgOPC12RFZbKngfqKCCJH+qi71fg614C8HOSCZtLM6TG3ZIWSzPzhPkc1jZs=
Received: from BYAPR03CA0026.namprd03.prod.outlook.com (2603:10b6:a02:a8::39)
 by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com (2603:10b6:518:1::7d4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 17:15:25 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::90) by BYAPR03CA0026.outlook.office365.com
 (2603:10b6:a02:a8::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 17:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 17:15:24 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 11:15:23 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 11:15:23 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Feb 2026 11:15:23 -0600
Received: from [10.249.131.231] ([10.249.131.231])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 619HFKNw2385027;
 Mon, 9 Feb 2026 11:15:21 -0600
Message-ID: <7d49a94b-311d-43a1-8a2b-25ce78e345bc@ti.com>
Date: Mon, 9 Feb 2026 22:45:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ram: k3-ddrss: Add exit retention support
To: Prasanth Babu Mantena <p-mantena@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>
References: <20260127121253.3011605-1-p-mantena@ti.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20260127121253.3011605-1-p-mantena@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|PH3PPFE6F9E2E1D:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ebec03-0fd9-459a-7eff-08de67fed022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|18082099003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUV2czJIczN5VU01ZUQxTWxrQUJTckVYSHRTNkppcERsNlVrSnFNbHFHNGl6?=
 =?utf-8?B?N3Y2Wmw0aVI2OGJndDB6TVJQUmJTMDJ1T3hDeC9CWjBIYlVyV0VDaEJmaUNU?=
 =?utf-8?B?cTZ5L2d4aEUvV3Q2cUlMZHI4S2xjWlF1VVBQTXJ0WDgva0JBSkozb2J4amlV?=
 =?utf-8?B?eHRDM0czaTV6RXRvcUg0aXZ6R1BpUGlIeFFySFJPZEZRYmZGL29NZGUvalRG?=
 =?utf-8?B?em1rSXZpa2lPUVltLzFTcG8vZldOclIzQmt3S085R2hJeFdUbHlFSVF5M1B0?=
 =?utf-8?B?TEc1dzlMRjlIUlo3bWhXYjlNMFljY1F4ZTNsc2VkUlNqaU9WWnRleFVIZllB?=
 =?utf-8?B?eDllaUtDKzdmVWJ6dEF0TS8wSU5DVEgweTRrWkkwOWdlcWIrMldkNUxSMjRI?=
 =?utf-8?B?RlUvSXBXQzlITDE3OEgzNjU3YTZSWHlLa1Mrd2RCWG9SM1VFcHVnMXpCZi8y?=
 =?utf-8?B?bVVYMFZjd2dyc2pocmQvLzc3WG0zK1g5d0t2NzRZZUVTVldYQjBxODZiLzY2?=
 =?utf-8?B?aWtWMzdVYVFQR1Jkcit5Y21XWnYwNERIVWJ6U2VoaGF1bGVwdGwvYXZ4K002?=
 =?utf-8?B?dk9lRUF5RDU4YVFBYnJRT05tWjhpV2NURlJHQmptUWJCaWZ2U2p1eHZyRTQr?=
 =?utf-8?B?R00rWnVZeS85UTI5Y1RaSStLbE9zTXB1ZmlIeUxZbFdCVndCK2ZUV3ZqT0Jk?=
 =?utf-8?B?dEswRzRVUzNVL3ROQmtXV3BJWXZQWFhhTE5LTWNIaGZFMFFkTzI1UGpYZGN2?=
 =?utf-8?B?eXp3YW1vb3RPWmFvY2xuQzR3UTVZOFR5eHRmUlgrdElZOFJUc2FpNVVnZ1d6?=
 =?utf-8?B?NzlKVTAzTFp1bzZ1Z2ZEVmdxODl6ZnRBOHRDK2Jqc3FBMkdvclloUlNBaGJL?=
 =?utf-8?B?TDJNeWhzZ3lpcGJSTitCNGdkTmVhN1ZsZ1BDYUhPQ2FUZWtsY3JIeDJwOVBQ?=
 =?utf-8?B?N0pNTTFIRmp2Q0l0clRBOXRJUm4za09ZRThQSEF6TGJIbmxPcFQyT0JzTE9B?=
 =?utf-8?B?di9vRkp4U2ZhR3FMK2RvVmQ2SGhoZlZ1U1pEUlRhZXR1SnlRcHdCcDg5RHlX?=
 =?utf-8?B?TS8yUTVLTkQ5a3FWaXg5OXdDalVlcWx2d2V0NGsxRzAxb0pMMnJFTGFkcGFl?=
 =?utf-8?B?Nk9sc2NnWHNVVzN3K1Yra2c1bW9xSXZxYnlDNWdJQWZZcXVMNkNLclZscGt0?=
 =?utf-8?B?SnJKRzFEemJ2SkxFSVF2dWFuYkNvaWVva0VLMmxySGV2RlRlNWlnV3lSeFJu?=
 =?utf-8?B?QjZlV1VlSWJSQXpzTWhURkRTdXRNazZnbHlRbU1YTFhOclEvV0QzNnBwN1NI?=
 =?utf-8?B?RzVsSzVYNmc5ZUIrbm0xKzFxZzJPY1NxL05jWUNuOXF4YzFvbStkdFpPNDZE?=
 =?utf-8?B?Qnl1LzdjMVJWbkpJK0llL3FFSTAxS3RCbEVVNmNxZnlZOCtobUthbWtWTExa?=
 =?utf-8?B?eWdKTHdkUnhQRnBaVUtnNjdoWWllUi9iZnVjSm9LaENaZTcxQzBaRlJKaURq?=
 =?utf-8?B?a2xoZFBtME1CN01ERm1CZ1BjOVRZM2RQcFFOdnhHQU5EWlUrdmpTc01TSXhw?=
 =?utf-8?B?NnpiQTZLZEN0VkpoR3VRZURsTDJzcDJQUnJqZEpkTHRLTzU2VGdSZVdUWThO?=
 =?utf-8?B?MlBMREVjM3doOU03V09kaUk2YnlEakZUZmNOWHQ1L1k2TnNnTVgwTXZwKzVW?=
 =?utf-8?B?RFBnVXBDZ25hbEpiTGhTWlk5ZDFFL0xuenByUk5GWk45Z2NxWmxtVGE5T2VF?=
 =?utf-8?B?Zm5oaFUyMVRHRjczKzJjSTVVMlp0R0NWOE9GRWdGdlR2QW8vbGhjT1liZWky?=
 =?utf-8?B?REVTQU9ybGd1Zk42bmdvM3NFZDdXYnBWYTk2d3pkdE81UE9DUVdUSU5jZEJz?=
 =?utf-8?B?Qm9UeXRnTk9mK3dqRjFJd3RYaXFUUE10V0xvcVo5S2hvV1lKOVJYVTZIRmdV?=
 =?utf-8?B?czIvMVo1TXFiVENHajE0RUkyT1Erb29yOWc4SkIrSmlnUFhSVk5DbFBSVmZm?=
 =?utf-8?B?M1JXNXlPc1JPcTBPMStybVV0QkpZRWFoOGZJbXdqYStwWXNibVF2WEdyc1Fv?=
 =?utf-8?B?eGdUZnpWSzAxQ1RuWW5Nc0tZS3ZWbHYybERuakgwRm1VK21pYnBEMkt4VEF5?=
 =?utf-8?B?b3YxWXhFYWlCUkx0a1NhZXJFRmNVRGNHZUxmdFkzMlpSZTg4MHNKYW5Zbi9S?=
 =?utf-8?B?Z1E9PQ==?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(18082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GVnGGUXSO6N8zZg05yHdOS5GTLYMe7u5a8twJew9lKXsv1AW6YMHU+zsRDa2oRbTupgsP+PAgiSzKet4QYsvLkODX5HQ9fHBYcJdFtSjQdHsaiTnEQ3+a71Cgg2qWPfa3A1G+srTJq6EA01bjr5gBsOtT+kImwJntGssk7cfr/eE8T99elKTl0lazfiM9KTl7pAK9JW0KB5/TvjlQFas8Vxj2da+oBrF5LVVQdPDE8OusoOZHmRVGaA8ReguuIhZuejZYjy8+fOlebEdXh8fc+Te5+tS2M/KdKsEDW75FXcClMjEyEd/GTcHlyAD4L5K3Xz7br1kwk8PPZhYUOrcB3iVQ864a468aEqoUpnJsIofG0l7RQlpE6/AXMAB9S3FKHsQmXJqf24Z4rgpXaduNlXrProryf3imAMSTR4Ww+1nAiuLEdI2VmpAw6HwFVvR
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 17:15:24.3153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ebec03-0fd9-459a-7eff-08de67fed022
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFE6F9E2E1D
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

Hi Prasanth

On 1/27/2026 5:42 PM, Prasanth Babu Mantena wrote:
> From: Thomas Richard <thomas.richard@bootlin.com>
> 
> Add functions that implements retention exit sequence of DDR.
> 
> Typical DDR resume sequence is:
> - exit DDR from retention
> - de-assert the DDR_RET pin
> - restore DDR max frequency
> - exit DDR from low power
> 
> We have to separate each action in order to de-assert the DDR_RET pins
> at the right time, because the DDR_RET pins are all tied together
> in hardware.
> Additional interleaving to be taken care and configuring of PMIC differs
> device to device depending on number of PMIC.
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> ---
>  arch/arm/mach-k3/include/mach/k3-ddr.h |  16 ++
>  drivers/ram/k3-ddrss/k3-ddrss.c        | 253 +++++++++++++++++++++++++
>  drivers/ram/k3-ddrss/lpddr4_k3_reg.h   | 120 ++++++++++++
>  3 files changed, 389 insertions(+)
>  create mode 100644 drivers/ram/k3-ddrss/lpddr4_k3_reg.h
> 
> diff --git a/arch/arm/mach-k3/include/mach/k3-ddr.h b/arch/arm/mach-k3/include/mach/k3-ddr.h
> index 207e60b2763..c82c25ba285 100644
> --- a/arch/arm/mach-k3/include/mach/k3-ddr.h
> +++ b/arch/arm/mach-k3/include/mach/k3-ddr.h
> @@ -7,6 +7,7 @@
>  #define _K3_DDR_H_
>  
>  #include <spl.h>
> +#include <compiler.h>
>  
>  /* We need 3 extra entries for:
>   *   SoC peripherals, flash and the sentinel value.
> @@ -14,10 +15,25 @@
>  #define K3_MEM_MAP_LEN			((CONFIG_NR_DRAM_BANKS) + 3)
>  #define K3_MEM_MAP_FIRST_BANK_IDX	2
>  
> +struct k3_ddrss_regs {

Looks like these are not generic K3 DDRSS register struct, so it should be named
perhaps k3_ddrss_ret_reg

> +	u32 ctl_141;
> +	u32 phy_1305;
> +	u32 ctl_88;
> +	u32 pi_134;
> +	u32 pi_7;
> +	u32 ctl_20;
> +	u32 wdqlvl_f1;
> +	u32 wdqlvl_f2;
> +};
> +
>  int dram_init(void);
>  int dram_init_banksize(void);
>  
>  void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image);
>  void fixup_memory_node(struct spl_image_info *spl_image);
>  
> +/* LPDDR4 power management functions */
> +void k3_ddrss_lpddr4_exit_retention(struct udevice *dev, struct k3_ddrss_regs *regs);
> +void k3_ddrss_lpddr4_change_freq(struct udevice *dev);
> +void k3_ddrss_lpddr4_exit_low_power(struct udevice *dev, struct k3_ddrss_regs *regs);
>  #endif /* _K3_DDR_H_ */
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
> index 5144470b931..140bd7678bb 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
> @@ -19,11 +19,13 @@
>  #include <power-domain.h>
>  #include <wait_bit.h>
>  #include <power/regulator.h>
> +#include <mach/k3-ddr.h>
>  
>  #include "lpddr4_obj_if.h"
>  #include "lpddr4_if.h"
>  #include "lpddr4_structs_if.h"
>  #include "lpddr4_ctl_regs.h"
> +#include "lpddr4_k3_reg.h"
>  
>  #define SRAM_MAX 512
>  
> @@ -438,6 +440,257 @@ static int k3_ddrss_ofdata_to_priv(struct udevice *dev)
>  	return ret;
>  }
>  
> +#if defined(CONFIG_K3_J721E_DDRSS)
> +
> +void k3_ddrss_lpddr4_exit_retention(struct udevice *dev,
> +				    struct k3_ddrss_regs *regs)
> +{
> +	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
> +	u32 regval;
> +	unsigned int pll_ctrl;

This variable can remain uninitialized especially since the switch you're using
to assign it below, doesn't have a default case.

> +	volatile unsigned int val;
> +
> +	/*
> +	 * Saving registers
> +	 */
> +	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_141, &regs->ctl_141);
> +	lpddr4_k3_readreg_phy(ddrss, DENALI_PHY_1305, &regs->phy_1305);
> +	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_88, &regs->ctl_88);
> +	lpddr4_k3_readreg_pi(ddrss, DENALI_PI_134, &regs->pi_134);
> +	// PI_139 cannot be restored

Use consistent Linux guideline commenting (/* */)

> +	lpddr4_k3_readreg_pi(ddrss, DENALI_PI_7, &regs->pi_7);
> +	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_20, &regs->ctl_20);
> +
> +	/* disable auto entry / exit */
> +	lpddr4_k3_clr_ctl(ddrss, DENALI_CTL_141, (0xF << 24) | (0xF << 16));
> +
> +	/* Configure DFI Interface, DDR retention exit occurs through PHY */
> +	lpddr4_k3_readreg_phy(ddrss, LPDDR4__PHY_SET_DFI_INPUT_0__REG, &regval);
> +	regval &= ~0xF0F; // Set DFI_Input_1 = 0
> +	regval |= 0x01;   // Set DFI Input_0 = 1
> +	lpddr4_k3_writereg_phy(ddrss, LPDDR4__PHY_SET_DFI_INPUT_0__REG, regval);
> +
> +	/* PWRUP_SREFRESH_EXIT = 1 */
> +	lpddr4_k3_set_ctl(ddrss, LPDDR4__PWRUP_SREFRESH_EXIT__REG, 0x1);
> +
> +	/* PI_PWRUP_SREFRESH_EXIT = 0 */
> +	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_PWRUP_SREFRESH_EXIT__REG, 0x1 << 16);
> +
> +	/* PI_DRAM_INIT_EN = 0 */
> +	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_DRAM_INIT_EN__REG, 0x1 << 8);
> +
> +	/* PI_DFI_PHYMSTR_STATE_SEL_R = 1  (force memory into self-refresh) */
> +	lpddr4_k3_set_pi(ddrss, LPDDR4__PI_DFI_PHYMSTR_STATE_SEL_R__REG, (1 << 24));
> +
> +	/*  PHY_INDEP_INIT_MODE = 0 */
> +	lpddr4_k3_clr_ctl(ddrss, LPDDR4__PHY_INDEP_INIT_MODE__REG, (0x1 << 16));
> +
> +	/* PHY_INDEP_TRAIN_MODE = 1 */
> +	lpddr4_k3_set_ctl(ddrss, LPDDR4__PHY_INDEP_TRAIN_MODE__REG, 0x1);
> +
> +	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F1__REG, &regs->wdqlvl_f1);
> +	regs->wdqlvl_f1 &= LPDDR4__DENALI_PI_214__PI_WDQLVL_EN_F1_MASK;
> +
> +	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F2__REG, &regs->wdqlvl_f2);
> +	regs->wdqlvl_f2 &= LPDDR4__DENALI_PI_217__PI_WDQLVL_EN_F2_MASK;
> +
> +	/* clear periodic WDQLVL for F0 */
> +	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F0__REG,
> +			0x2 << LPDDR4__DENALI_PI_212__PI_WDQLVL_EN_F0_SHIFT);
> +
> +	/* clear periodic WDQLVL for F1 */
> +	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F1__REG,
> +			0x2 << LPDDR4__DENALI_PI_214__PI_WDQLVL_EN_F1_SHIFT);
> +
> +	/* clear periodic WDQLVL for F2 */
> +	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F2__REG,
> +			0x2 << LPDDR4__DENALI_PI_217__PI_WDQLVL_EN_F2_SHIFT);
> +
> +#define PLL_CTRL_OFF 0x20
> +#define PLL_CFG 0x00680000
> +	switch (ddrss->instance) {
> +	case 0:
> +		pll_ctrl = PLL_CFG + 12 * 0x1000 + PLL_CTRL_OFF;
> +		break;
> +	case 1:
> +		pll_ctrl = PLL_CFG + 26 * 0x1000 + PLL_CTRL_OFF;
> +		break;
> +	case 2:
> +		pll_ctrl = PLL_CFG + 27 * 0x1000 + PLL_CTRL_OFF;
> +		break;
> +	case 3:
> +		pll_ctrl = PLL_CFG + 28 * 0x1000 + PLL_CTRL_OFF;
> +		break;
> +	}

Can we use the clock framework clk-k3-pll.c and/or clk-k3.c to set up these PLLs
instead of hardcoding this here?

> +
> +	*(unsigned int *)pll_ctrl |= 0x80000000;
> +	val = *(volatile unsigned int *)pll_ctrl;
> +	if ((val & 0x80000000) != 0x80000000)
> +		val = *(volatile unsigned int *)pll_ctrl;

Please use proper I/O functions (readl, writel). But priority would be
completely move this clocking related code to use our clock drivers as mentioned
above.

> +}
> +
> +void k3_ddrss_lpddr4_change_freq(struct udevice *dev)

I don't understand what this function is supposed to be doing in addition to
what k3_lpddr3_freq_update does, the name can be changed to make it clearer if
this sequence is specific for LPM or something.

> +{
> +	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
> +	u32 regval;
> +	unsigned long tmo;
> +
> +	/* PI_START=1 */
> +	lpddr4_k3_set_pi(ddrss, LPDDR4__PI_START__REG, 0x01);
> +	/* START=1 */
> +	lpddr4_k3_set_ctl(ddrss, LPDDR4__START__REG, 0x01);
> +
> +	k3_lpddr4_freq_update(ddrss);
> +
> +	tmo = timer_get_us() + 100000;
> +	do {
> +		lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_INT_STATUS__REG, &regval);
> +		if (timer_get_us() > tmo) {
> +			printf("%s:%d timeout error\n", __func__, __LINE__);

dev_err instead of printf in all these failure conditions

> +			hang();
> +		}
> +	} while ((regval & (1 << 0)) == 0x00);
> +
> +	tmo = timer_get_us() + 4000;

Can use wait_for_* functions for polling with timeout.

> +	do {
> +		lpddr4_k3_readreg_ctl(ddrss, LPDDR4__INT_STATUS_0__REG, &regval);
> +		if (timer_get_us() > tmo) {
> +			printf("%s:%d timeout error\n", __func__, __LINE__);
> +			hang();
> +		}
> +	} while ((regval & (1 << 9)) == 0x00);
> +
> +	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_INT_STATUS__REG, &regval);
> +	debug("%s: PI interrupt status: 0x%08x\n", __func__, regval);
> +
> +	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__INT_STATUS_0__REG, &regval);
> +	debug("%s: Controller interrupt status: 0x%08x\n", __func__, regval);
> +
> +	debug("%s: Successfully exited Retention\n", __func__);
> +}
> +
> +void k3_ddrss_lpddr4_exit_low_power(struct udevice *dev,
> +				    struct k3_ddrss_regs *regs)
> +{
> +	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
> +	u32 regval, fspop, fspwr;
> +	unsigned long tmo;
> +
> +	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
> +	debug("%s: LP State: 0x%08x\n", __func__, regval);
> +
> +	/* make sure that LP flag is clear before going through this process */
> +	lpddr4_k3_writereg_ctl(ddrss, LPDDR4__INT_ACK_0__REG, (0x1 << 10));
> +
> +	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__CKSRX_F1__REG, &regval);
> +	regval &= ~(0x7F << 24);
> +	regval |= (0x2 << 24); // set low power mode exit
> +	lpddr4_k3_writereg_ctl(ddrss, LPDDR4__CKSRX_F1__REG, regval);
> +
> +	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
> +	debug("%s: LP State: 0x%08x\n", __func__, regval);
> +
> +	/* wait until low power operation has been completed */
> +	tmo = timer_get_us() + 4000;
> +	do {
> +		lpddr4_k3_readreg_ctl(ddrss, LPDDR4__INT_STATUS_0__REG, &regval);
> +		if (timer_get_us() > tmo) {
> +			printf("%s:%d timeout error\n", __func__, __LINE__);
> +			hang();
> +		}
> +	} while ((regval & (0x1 << 10)) == 0);
> +
> +	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
> +	debug("%s: LP State: 0x%08x\n", __func__, regval);
> +
> +	lpddr4_k3_writereg_ctl(ddrss, LPDDR4__INT_ACK_0__REG, (0x1 << 10));
> +
> +	/*
> +	 * bit 6 / 14 -- lp_state valid
> +	 * bits 13:8 / 5:0 0x0F SRPD Long with Mem and Controller Clk Gating
> +	 */
> +	tmo = timer_get_us() + 4000;
> +	do {
> +		lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
> +		if (timer_get_us() > tmo) {
> +			printf("%s:%d timeout error\n", __func__, __LINE__);
> +			hang();
> +		}
> +	} while ((regval & 0x4F4F) != 0x4040);
> +
> +	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
> +	debug("%s: LP State: 0x%08x\n", __func__, regval);
> +
> +	/*
> +	 * MR13 data within the PI is based upon CS but NOT based upon
> +	 * frequency set point.
> +	 * MR13 is the current MR13 value
> +	 */
> +	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_MR13_DATA_0__REG, &regval);
> +	fspop = (regval & ((u32)1 << 31)) >> 31;
> +	fspwr = (regval & ((u32)1 << 30)) >> 30;
> +
> +	lpddr4_k3_set_ctl(ddrss, LPDDR4__FSP_OP_CURRENT__REG,
> +			 fspop << LPDDR4__DENALI_CTL_192__FSP_OP_CURRENT_SHIFT);
> +
> +	lpddr4_k3_set_ctl(ddrss, LPDDR4__FSP_WR_CURRENT__REG,
> +			 fspwr << LPDDR4__DENALI_CTL_192__FSP_WR_CURRENT_SHIFT);
> +
> +	// do not allow CTL to update MR
> +	lpddr4_k3_set_ctl(ddrss, LPDDR4__FSP_PHY_UPDATE_MRW__REG,
> +			 1 << LPDDR4__DENALI_CTL_191__FSP_PHY_UPDATE_MRW_SHIFT);
> +
> +	// do not allow PI to update MR
> +	lpddr4_k3_clr_pi(ddrss, DENALI_PI_64, 1 << 0);
> +
> +	// PI_FREQ_MAP defines supported working frequencies
> +	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_FREQ_MAP__REG, &regval);
> +	if (regval & (0x1 << 1)) {
> +		// define FSP0 and FSP1 as trained
> +		lpddr4_k3_set_ctl(ddrss, LPDDR4__MR_FSP_DATA_VALID_F0__REG,
> +				 LPDDR4__DENALI_CTL_190__MR_FSP_DATA_VALID_F0_MASK);
> +		lpddr4_k3_set_ctl(ddrss, LPDDR4__MR_FSP_DATA_VALID_F1__REG,
> +				 LPDDR4__DENALI_CTL_190__MR_FSP_DATA_VALID_F1_MASK);
> +	}
> +	if (regval & (0x1 << 2)) {
> +		// define FSP0 and FSP2 as trained
> +		lpddr4_k3_set_ctl(ddrss, LPDDR4__MR_FSP_DATA_VALID_F0__REG,
> +				 LPDDR4__DENALI_CTL_190__MR_FSP_DATA_VALID_F0_MASK);
> +		lpddr4_k3_set_ctl(ddrss, LPDDR4__MR_FSP_DATA_VALID_F2__REG,
> +				 LPDDR4__DENALI_CTL_190__MR_FSP_DATA_VALID_F2_MASK);
> +	}
> +
> +	/*
> +	 * Restore registers
> +	 */
> +	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_141, regs->ctl_141);
> +	lpddr4_k3_writereg_phy(ddrss, DENALI_PHY_1305, regs->phy_1305);
> +	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_88, regs->ctl_88);
> +	lpddr4_k3_writereg_pi(ddrss, DENALI_PI_134, regs->pi_134);
> +	// PI_139 cannot be restored
> +	lpddr4_k3_writereg_pi(ddrss, DENALI_PI_7, regs->pi_7);
> +	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_20, regs->ctl_20);
> +
> +	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_141, &regs->ctl_141);
> +	lpddr4_k3_readreg_phy(ddrss, DENALI_PHY_1305, &regs->phy_1305);
> +	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_88, &regs->ctl_88);
> +	// PI_139 cannot be restored
> +	lpddr4_k3_readreg_pi(ddrss, DENALI_PI_7, &regs->pi_7);
> +
> +	lpddr4_k3_readreg_pi(ddrss, DENALI_PI_79, &regval);
> +	lpddr4_k3_writereg_pi(ddrss, DENALI_PI_80, regval);
> +
> +	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_293, &regval);
> +	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_295, regval);
> +
> +	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_294, &regval);
> +	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_296, regval);
> +
> +	lpddr4_k3_set_pi(ddrss, DENALI_PI_214, regs->wdqlvl_f1);
> +	lpddr4_k3_set_pi(ddrss, DENALI_PI_217, regs->wdqlvl_f2);
> +}
> +#endif /* CONFIG_K3_J721E_DDRSS */
> +
>  void k3_lpddr4_probe(struct k3_ddrss_desc *ddrss)
>  {
>  	u32 status = 0U;
> diff --git a/drivers/ram/k3-ddrss/lpddr4_k3_reg.h b/drivers/ram/k3-ddrss/lpddr4_k3_reg.h
> new file mode 100644
> index 00000000000..ba8e8b619fb
> --- /dev/null
> +++ b/drivers/ram/k3-ddrss/lpddr4_k3_reg.h
> @@ -0,0 +1,120 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */
> +/*
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#ifndef LPDDR4_K3_REG
> +#define LPDDR4_K3_REG
> +
> +#define lpddr4_k3_readreg_ctl(ddrss, reg, pt) do {	\
> +		u16 offset = 0U;					\
> +		u32 result = 0U;					\
> +		TH_OFFSET_FROM_REG(reg, CTL_SHIFT, offset);			\
> +		result = ddrss->driverdt->readctlconfig(&ddrss->pd, pt, (u16 *)(&offset), 1); \
> +		if (result > 0U) {					\
> +			printf("%s: Failed to read %s\n", __func__, xstr(reg));	\
> +			hang();						\
> +		}			\
> +	} while (0)
> +
> +#define lpddr4_k3_readreg_pi(ddrss, reg, pt) do {	\
> +		u16 offset = 0U;					\
> +		u32 result = 0U;					\
> +		TH_OFFSET_FROM_REG(reg, PI_SHIFT, offset);			\
> +		result = ddrss->driverdt->readphyindepconfig(&ddrss->pd, pt, (u16 *)(&offset), 1); \
> +		if (result > 0U) {					\
> +			printf("%s: Failed to read %s\n", __func__, xstr(reg));	\
> +			hang();						\
> +		}			\
> +	} while (0)
> +
> +#define lpddr4_k3_readreg_phy(ddrss, reg, pt) do {	\
> +		u16 offset = 0U;					\
> +		u32 result = 0U;					\
> +		TH_OFFSET_FROM_REG(reg, PHY_SHIFT, offset);			\
> +		result = ddrss->driverdt->readphyconfig(&ddrss->pd, pt, (u16 *)(&offset), 1); \
> +		if (result > 0U) {					\
> +			printf("%s: Failed to read %s\n", __func__, xstr(reg));	\
> +			hang();						\
> +		}			\
> +	} while (0)
> +
> +#define lpddr4_k3_writereg_ctl(ddrss, reg, value)  do {	\
> +		u16 offset = 0U;					\
> +		u32 result = 0U;					\
> +		u32 writeval = value;					\
> +		TH_OFFSET_FROM_REG(reg, CTL_SHIFT, offset);			\
> +		result = ddrss->driverdt->writectlconfig(&ddrss->pd, &writeval, (u16 *)(&offset), 1); \
> +		if (result > 0U) {					\
> +			printf("%s: Failed to write %s\n", __func__, xstr(reg)); \
> +			hang();						\
> +		}		\
> +	} while (0)
> +
> +#define lpddr4_k3_writereg_pi(ddrss, reg, value)  do {	\
> +		u16 offset = 0U;					\
> +		u32 result = 0U;					\
> +		u32 writeval = value;					\
> +		TH_OFFSET_FROM_REG(reg, PI_SHIFT, offset);			\
> +		result = ddrss->driverdt->writephyindepconfig(&ddrss->pd, &writeval, (u16 *)(&offset), 1); \
> +		if (result > 0U) {					\
> +			printf("%s: Failed to write %s\n", __func__, xstr(reg)); \
> +			hang();						\
> +		}		\
> +	} while (0)
> +
> +#define lpddr4_k3_writereg_phy(ddrss, reg, value) do {	\
> +		u16 offset = 0U;					\
> +		u32 result = 0U;					\
> +		u32 writeval = value;					\
> +		TH_OFFSET_FROM_REG(reg, PHY_SHIFT, offset);			\
> +		result = ddrss->driverdt->writephyconfig(&ddrss->pd, &writeval, (u16 *)(&offset), 1); \
> +		if (result > 0U) {					\
> +			printf("%s: Failed to write %s\n", __func__, xstr(reg)); \
> +			hang();						\
> +		}		\
> +	} while (0)
> +
> +#define lpddr4_k3_set_ctl(k3_ddrss, reg, mask) do {	\

How was this working? The parameter says "k3_ddrss" but you are using "ddrss" in
the macro definition?

> +	u32 val;					\
> +	lpddr4_k3_readreg_ctl(ddrss, reg, &val);		\
> +	val |= mask;					\
> +	lpddr4_k3_writereg_ctl(ddrss, reg, val);		\
> +	} while (0)
> +
> +#define lpddr4_k3_clr_ctl(k3_ddrss, reg, mask) do {		\
> +		u32 val;					\
> +		lpddr4_k3_readreg_ctl(ddrss, reg, &val);		\
> +		val &= ~(mask);					\
> +		lpddr4_k3_writereg_ctl(ddrss, reg, val);		\
> +	} while (0)
> +
> +#define lpddr4_k3_set_pi(k3_ddrss, reg, mask) do {		\
> +		u32 val;					\
> +		lpddr4_k3_readreg_pi(ddrss, reg, &val);		\
> +		val |= mask;					\
> +		lpddr4_k3_writereg_pi(ddrss, reg, val);		\
> +	} while (0)
> +
> +#define lpddr4_k3_clr_pi(k3_ddrss, reg, mask) do {		\
> +		u32 val;					\
> +		lpddr4_k3_readreg_pi(ddrss, reg, &val);		\
> +		val &= ~(mask);					\
> +		lpddr4_k3_writereg_pi(ddrss, reg, val);		\
> +	} while (0)
> +
> +#define lpddr4_k3_set_phy(ddrss, reg, mask) do {		\
> +	u32 val;					\
> +	lpddr4_k3_readreg_phy(ddrss, reg, &val);		\
> +	val |= mask;					\
> +	lpddr4_k3_writereg_phy(ddrss, reg, val);		\
> +	} while (0)
> +
> +#define lpddr4_k3_clr_phy(ddrss, reg, mask) do {		\
> +	u32 val;					\
> +	lpddr4_k3_readreg_phy(ddrss, reg, &val);		\
> +	val &= ~(mask);					\
> +	lpddr4_k3_writereg_phy(ddrss, reg, val);		\
> +	} while (0)
> +
> +#endif  /* LPDDR4_K3_REG */

For all these functions I would prefer if you could move them into
"lpddr4_getinstance" (in lpddr4_obj_if.c) to have .setphy, .clrphy etc. as a
common place for all our IP read/write interfacing functions.

-- 
Thanking You
Neha Malcom Francis

