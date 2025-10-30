Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC272CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 550CF8334F;
	Thu, 30 Oct 2025 14:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="T+2c/Xoc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7A2C836D3; Thu, 30 Oct 2025 14:55:55 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60176800B6
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 14:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DI8G+Z2JCUrI/0MPFeOA14vtNV+ELvKJZlYtJAK/SeoF5caHh2BuNl9BfTdsam7rbkhD9nOMnVP3opKjNUSXXrM4liSxiU9fyWrWiAmB3Z15ewKlwkaSkBnTs4ZG3MK7DskQ+LG9g1pph5R7YVZ8VWCNFPVIlclauujL761QQ7r6NSMM7oKEhmCVkJMLOz1qXW2GfRvQhb35W3fG5/Ab42zgAyGSE3LzUo6kWt3QTzt//3rM9hyjsdc0+5YqqDg/5/ZB2LuZ/R50kvtYcyALVc8vyDc3Gq7s2dqROI4+jUvmK284PI3a9P93CHTIAMQwLvPEipyJCm/SNs7cDagXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7FbTM1auuc3bOdJF0ZKDFPh6jCaBDX/LoLz1h7uwPs=;
 b=s48C5Olyhv5mbvmSH4KerjloEqYCv5JMs+EBOqd4l5RD8Dk+D/Pfkcp6kDNFxFghCdHKkRie31xUhndckyiCBO0m7JEIb8QGYvX1lLJsC/SnlXFMSD0OYqDTV/U7epERtlv3PsUG0uXfmIijEvTJxzGxgHC9yUhhwUCtFLlLJKVsmmhKGo4qFAJXmO4DO5oI4ZOyNPaFzwSGeY2A4hfTZxg5pQ5E04fhL+iEby1uyZUk9D5N/dFzzHbm9EnIqb3LH6aKfh9uV0ok0FsmrmOPzMWFjpWg3e5bZGk2EebI6IREvksYTqE7qbB2IDECDNeHwfS4t9FEDrF/qiyjdrciag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7FbTM1auuc3bOdJF0ZKDFPh6jCaBDX/LoLz1h7uwPs=;
 b=T+2c/XocuGDnJzYgwj+dli/s4XF1kg1d2ijI86IDBiWF8Lsq4QhpWiNuadVrsyKBlPZzImOUsfR3Rjd+YRApW/ZgFOiLipHjpiKJCFgikmcVrHh/apJ8eHh6voPOMR5DeTATL6VOmvR3z/acEEz4wNFMdmGkmeuEmVrK0GzLQqk=
Received: from SJ0PR03CA0083.namprd03.prod.outlook.com (2603:10b6:a03:331::28)
 by DS0PR10MB7955.namprd10.prod.outlook.com (2603:10b6:8:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 13:55:46 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::86) by SJ0PR03CA0083.outlook.office365.com
 (2603:10b6:a03:331::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 13:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 13:55:46 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 08:55:41 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 08:55:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 08:55:41 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59UDtevw2290549;
 Thu, 30 Oct 2025 08:55:40 -0500
Message-ID: <6fe53b09-fe92-4d04-8e51-9084f2b01c77@ti.com>
Date: Thu, 30 Oct 2025 08:55:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/8] mach-k3: common: support only MMC in R5 falcon mode
To: Anshul Dalal <anshuld@ti.com>
CC: <b-liu@ti.com>, <bb@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <nm@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>
References: <20251030051937.3659010-1-anshuld@ti.com>
 <20251030051937.3659010-5-anshuld@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251030051937.3659010-5-anshuld@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DS0PR10MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5a43b9-7d59-4c33-d407-08de17bc065c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|34020700016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjdjeEt0MzFyWnVNRzEyU01ub25YYWcrQndiUUpJRkhxV2dNRTFHNHhsVkR2?=
 =?utf-8?B?Z2dzbUNOZTJRWjBOOE4ybUpudHZDc0tCSkk5d01nMW0rWlZSMXhSZzV2MnpY?=
 =?utf-8?B?ZG9sTHB2aVFHVCttZGxhYll6RnE0Nmd1U0xEODE2RmdMaGw0TzVubkJ2dHRC?=
 =?utf-8?B?dThGWmxBWVlxTGNpS2VlUjByZHJSZ2hnL24wOGczMlJHM0VDTjhlQ1FGNmxw?=
 =?utf-8?B?K0VtMzR3bmo0L2VPM1BsczFrcjR3cWdNeWxjTXJ2Znd1QWRzeC9LYm0yNEl0?=
 =?utf-8?B?UTdDMmFoQkMvZGdQWUVhU2cvMWRPaEM5dDBZOVA2YTZpR3IxajZEUUlTK3o1?=
 =?utf-8?B?RHVKK0pINys5REV3ZTIvSFhKbHZBSHNwd3g0bTI5VXM4TGtZOG5SbC9EenJE?=
 =?utf-8?B?M0xFM1BCaVZHbHc2dmNVR0JycmIrMTBVekxrRkRKM3o5MnA1R0V3WDhCTUdJ?=
 =?utf-8?B?M2NRQmJvZUViQW1MVkkvdEE3cjhzOVptVTZ6YWRYRHZWNkNuR1FNOGpDdSs5?=
 =?utf-8?B?RDg2TzFJbkZMZVNRaytlTW1OaDJHeDhIVHFucFlVU0RhYXJrNHlkcDFYejFw?=
 =?utf-8?B?V3M0am9kNE5YZHAzbE5EMGlhM1JGMFB6eGhyUXFEZ05vZ25vbkR2bjhYT0Rr?=
 =?utf-8?B?QkdCR2JiY1J0bGhCemlNL2VWanloNjNLTnNiTnU0RTZOOUFCcXpGMGRIbWJQ?=
 =?utf-8?B?TFJySkJMR0l5VW5abklwVjcyVUVzcWdON0lrTWJOV0FycGVJa3FIdTJiR2xS?=
 =?utf-8?B?ZEY4UmFVME5EakYxenI4UGRPUlhucm5zamlIZXpMSTR3WWY1U0Z1V1R1V01n?=
 =?utf-8?B?SlFDRTFVNE5xSWl5cUZHaFZRdmJmb2haczQvZWxWeW5xTkFEUDF6TFFYZ0JL?=
 =?utf-8?B?SnJUZXdzWmdLdUNERlp4RnJxNjlHc1E4TVp3Mm90cGFxQWJTUnJLdDZTSEdF?=
 =?utf-8?B?M3pxTWhjOXhibWxDbllFeHpkTzBHZTEyR1FQSm4wZ01VdW0rYTd2UDZ5aW9V?=
 =?utf-8?B?blF2d0lrVDQzSU9TSUh4RWowcWZrUlQ0b1dWMDhRZGs4QmdzMWxFSnFkZUR6?=
 =?utf-8?B?TkdqN3c5Vm0vZXdEdFJTM1FUOHI3b3hUczcvR0QzalVmTlh1ZWI0d3ZPZ2Nm?=
 =?utf-8?B?SmU1OXRhQUhaTmVGZzdDVit4T2pKV3dYcEpKMFBwZnlLL0Z3aWRMWWVaUUN2?=
 =?utf-8?B?K3lMOGQ1WjVUZmVQR05rTEN4NWhIUXpFN1pXU1VMWG5vMVgxZk1GS25VV3dZ?=
 =?utf-8?B?WHFpT3JKZEE3YnNGU3l1anRZeWxIRzhnbFBEcWdNK0xHbzZlY1BKMGdxcGps?=
 =?utf-8?B?NHFlRW9EQS92Zk12M3Rib2dNdHpUR2hRS0ZPczlUUC9BQXpDY0wweFpOdHN3?=
 =?utf-8?B?RmlLbGU3SGJQNWN5SFJBMFk5VEl3QjRSbVNsRkRRRXAvMjVWWFFkZGFRc3Ry?=
 =?utf-8?B?TjNDSFBud05ZK2JDSWZQSlJYYVRPVDB6RC92RnNjVGczbWFZOS9BUkphUFlK?=
 =?utf-8?B?Ym9YRDM3OU96eW03cG1ORHJZT3lkSzBiYlF1YXlqRlRCMFpmaFh0ZHpMOG85?=
 =?utf-8?B?dUZSL05LMnU5Mkc4cU8zZUNQR2lSVjVnOGNJaWpxUitSVEdyRFNFVlpmQ2pW?=
 =?utf-8?B?UXdWZTJtZW1JSXhtS1pYK1VYZzdEMldSRHVVWDJBb1ZFMXNaNXd0SjI3eEF2?=
 =?utf-8?B?NGllRXpjTVUxUmlwcHZQVGlsaGx1WXVmRWpTZEdKMXRtMGN0U3IxeWFwSjhh?=
 =?utf-8?B?UitKZFFvWGVkSlRMdTJzYWRrOThaU2MxeVlFUktXaU1WLzlTSEdzdFlxMzVk?=
 =?utf-8?B?dWl2aHQ2aWNFQjVDcGFiM08yZFJuZi9UWEc3ZUJRSkpNdWJKV2NFYmovd1ZJ?=
 =?utf-8?B?aURsNlFTckVjQm1JRDROaXBaREExbnV3WDVuZi9yV3ZlT3M5cVZLelNxbU9n?=
 =?utf-8?B?SktFMTk3OXJVZmxJREhPb0xwUlBsanY0Q1BCdy9VdThVZFJ6ZDdHa1Juek5J?=
 =?utf-8?B?OUZkTzJWV1J6Z0pNS21PTWFWZXQyLzJCZkdUYStLcFVEY2QwSGtXNGd2dHZw?=
 =?utf-8?B?c3g3OTFyWllXdlJQRUhSNmlPbUU3ZVR3bDgxaGNFNVRMeUs0K1ZDcGdQK2R5?=
 =?utf-8?Q?IfMY=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:55:46.0221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5a43b9-7d59-4c33-d407-08de17bc065c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7955
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

On 10/30/25 12:19 AM, Anshul Dalal wrote:
> To simplify the boot process and prevent the R5 SPL size from growing,
> this patch restricts the boot media to load the next stage payload
> (tifalcon.bin and kernel FIT) from MMC only.
> 

Is R5 SPL size the only reason? This seems rather restrictive to only
support one boot mode with all this..

> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>   arch/arm/mach-k3/am62ax/am62a7_init.c |  3 +++
>   arch/arm/mach-k3/am62px/am62p5_init.c |  4 ++++
>   arch/arm/mach-k3/am62x/am625_init.c   |  3 +++
>   arch/arm/mach-k3/common.h             |  1 +
>   arch/arm/mach-k3/r5/common.c          | 17 ++++++++++++++++-
>   5 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
> index 48d578e7d6f..1c8a5fd2a35 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
> @@ -240,5 +240,8 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>   
>   u32 spl_boot_device(void)
>   {
> +#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)

The check for CONFIG_ARM64 might not be needed, what if we want to
falcon boot from A53 SPL right into Linux?

> +	return k3_r5_falcon_bootmode();
> +#endif

This should be an #else capturing the below return call, otherwise
think about what the function looks like after the preprocessor step
if the above is true:

u32 spl_boot_device(void)
{
	return k3_r5_falcon_bootmode();
	return get_boot_device();
}

just seems odd.

Andrew

>   	return get_boot_device();
>   }
> diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
> index aebd5200b0d..4c215d5cebe 100644
> --- a/arch/arm/mach-k3/am62px/am62p5_init.c
> +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
> @@ -375,6 +375,10 @@ u32 spl_boot_device(void)
>   	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
>   	u32 bootmedia;
>   
> +#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
> +	return k3_r5_falcon_bootmode();
> +#endif
> +
>   	if (bootindex == K3_PRIMARY_BOOTMODE)
>   		bootmedia = __get_primary_bootmedia(devstat);
>   	else
> diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
> index 14f93ac998f..44b8d2654b2 100644
> --- a/arch/arm/mach-k3/am62x/am625_init.c
> +++ b/arch/arm/mach-k3/am62x/am625_init.c
> @@ -327,5 +327,8 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>   
>   u32 spl_boot_device(void)
>   {
> +#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
> +	return k3_r5_falcon_bootmode();
> +#endif
>   	return get_boot_device();
>   }
> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
> index 5807d358464..cd3e19374dc 100644
> --- a/arch/arm/mach-k3/common.h
> +++ b/arch/arm/mach-k3/common.h
> @@ -54,6 +54,7 @@ int shutdown_mcu_r5_core1(void);
>   
>   #if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
>   int k3_r5_falcon_bootmode(void);
> +int k3_r5_falcon_prep(void);
>   #endif
>   
>   #if (IS_ENABLED(CONFIG_K3_QOS))
> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
> index 439dd92ef54..aa94c0c1956 100644
> --- a/arch/arm/mach-k3/r5/common.c
> +++ b/arch/arm/mach-k3/r5/common.c
> @@ -391,6 +391,21 @@ int spl_start_uboot(void)
>   		return 0;
>   }
>   
> +int k3_r5_falcon_bootmode(void)
> +{
> +	char *mmcdev = env_get("mmcdev");
> +
> +	if (!mmcdev)
> +		return BOOT_DEVICE_NOBOOT;
> +
> +	if (strncmp(mmcdev, "0", sizeof("0")) == 0)
> +		return BOOT_DEVICE_MMC1;
> +	else if (strncmp(mmcdev, "1", sizeof("1")) == 0)
> +		return BOOT_DEVICE_MMC2;
> +	else
> +		return BOOT_DEVICE_NOBOOT;
> +}
> +
>   int k3_r5_falcon_prep(void)
>   {
>   	struct spl_image_loader *loader, *drv;
> @@ -402,7 +417,7 @@ int k3_r5_falcon_prep(void)
>   	memset(&kernel_image, '\0', sizeof(kernel_image));
>   	drv = ll_entry_start(struct spl_image_loader, spl_image_loader);
>   	n_ents = ll_entry_count(struct spl_image_loader, spl_image_loader);
> -	bootdev.boot_device = spl_boot_device();
> +	bootdev.boot_device = k3_r5_falcon_bootmode();
>   
>   	for (loader = drv; loader != drv + n_ents; loader++) {
>   		if (bootdev.boot_device != loader->boot_device)

