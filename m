Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE16CCF9FC
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD936836D3;
	Thu, 30 Oct 2025 14:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bQ0GC1V6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5130783710; Thu, 30 Oct 2025 14:47:10 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B89F6800B6
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 14:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSYceEORBbDIuQjlAAe/60Dqx9MYxC88DQ+3qiuDA2o5hxDPNMFgSP8gGTAtwY2vLYwXZ9ePSjyBT2ODUYqdwxJcYRCOae36KMs7A6qb6A7PfSSJaVK8mG6lyjoEhTp1lY7DIhKCn8f9ouDf3NfDhy0efejOpc/FSZk1QVIvPJl68VahFCg7l+TFlPoCXC430QCGXxS/Gq5r02nM9yYy2Ts9VRPes4P6wqXxNULLm+AImCDeTcBXTte3K0LymX/xpWHGnD8FCJouc3V+/l8x4lZPQJDwDTBDPrDIAL0foXdk4MF9+kmSyFBda20/lPirtMm2ob/OmB3Ce4bY3B6hgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5BIYdPuG8yMLoP7PSDUViw1IPeGAQgOz1y/eAnMqUM=;
 b=Or5zA51PkHJZVa9KambrJWlckzh5ipv3AJbk6zQuBX45gltPYy/cmQcvoC2ESfZxmxsh+65Hkx7vOef9R1Iz6IGmlxg9Y3Lc2VKmDch+h4ruXhSESMNEMpOxmHYUS2I/Dx22iSYCadz5vWtfdNW9yrLZeI/hwtuY6dsU5BsEX6zsasC55rxt6MAPy1/Jtdvy5ZPRuVg3DVVsEre+kx2LJXKKNeM7DP9xMphm2P3j4eS/DyQNogBB9wtDDF90WZDpsLbAdjXd3tZxHgf3xGkWvLUJXzNltAILhwDTZk0BV3fMNpNsm+g85VqpKadv1wcth4/4rW7XgkpiY+YmQvRBhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5BIYdPuG8yMLoP7PSDUViw1IPeGAQgOz1y/eAnMqUM=;
 b=bQ0GC1V6bSb/b+JtMu9f2UhOzz+u8+et1eREqEitSe7JwgcjZOvkKVkdV8Dc8g80LYe3eDfI0VpIlnYpv5v+Ke4ZUiFuiNWTrRn/T+yR+ShgjLuAupn0ri7DfWZVRETnHmfvtNR464h65hR5/4O9nRv3AIfiAuJqohdB8FacL2o=
Received: from SJ0PR13CA0154.namprd13.prod.outlook.com (2603:10b6:a03:2c7::9)
 by SJ0PR10MB5889.namprd10.prod.outlook.com (2603:10b6:a03:3ee::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 30 Oct
 2025 13:47:03 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::61) by SJ0PR13CA0154.outlook.office365.com
 (2603:10b6:a03:2c7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.5 via Frontend Transport; Thu,
 30 Oct 2025 13:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 13:47:03 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 08:46:57 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 08:46:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 08:46:57 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59UDkv8S2281823;
 Thu, 30 Oct 2025 08:46:57 -0500
Message-ID: <e6791dc8-45b5-458e-afdf-f96778b529af@ti.com>
Date: Thu, 30 Oct 2025 08:46:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/8] mach-k3: common: enable falcon mode from R5 SPL
To: Anshul Dalal <anshuld@ti.com>
CC: <b-liu@ti.com>, <bb@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <nm@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>
References: <20251030051937.3659010-1-anshuld@ti.com>
 <20251030051937.3659010-4-anshuld@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251030051937.3659010-4-anshuld@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|SJ0PR10MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ad028d-2529-4eaa-bb1f-08de17bacee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|34020700016|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVJEZjVVVmpmV0RRSEhSTnppZjhLQVM2S1ViSWo2U3I0SFBTVmt5ZXZtbCtw?=
 =?utf-8?B?ZVVMYnJ2WlRYT0sybFdMeGlmMjgrb3picUt0K3kxSHoyZ2U5T2I2VWRlWnRj?=
 =?utf-8?B?aXVJUWhweEcxamlFUEY5cVMyMXhxa005eFoybVRTMnNRcWtUblUya0tZUUNs?=
 =?utf-8?B?NEpPS2l6VTk2T2lLd3dVWWs0L1hnOTk4anE5Yzg0UmtRRzJlS0FCVFlybyt3?=
 =?utf-8?B?d1BucldMSnZUZnJRNjdYdlc0MjZNbHBBRlhCR0t6MmErQjF6RkpNM0hSaTFp?=
 =?utf-8?B?aC9kaDV1WVh3eHRINlI1SzYwcVcyVk1OU0p2QWVFQlljU3F2Rk1iL0Z1amFB?=
 =?utf-8?B?OVpuL0w3R1ZHWUFISTBYWEhnemJoUkhaWnZjdHF5bUJqYVFRRVVhVnc5QjhQ?=
 =?utf-8?B?Q1lUc2FMZGtvUzd4U1NnenN1UlV0amNoSTZnaUl0NWFLd0lCZTZqQkZLdEJa?=
 =?utf-8?B?Nk01bVdsYkVLMW95TTZuSS80Mm8rZE1OZkxjcVRDVnZ4YzdpTFpmZEhONEZD?=
 =?utf-8?B?WXVIQTAzbFhYZXlBVlhoVmdXWUdaM21RZzVUc2hBeDlRTmoyb0N3ZXVxcjhk?=
 =?utf-8?B?bC94THpxam03RnQvVEREY054a0hHZXJIS3NNMHBYb2V1TzZCT2RUNUdaMUxI?=
 =?utf-8?B?d3p2OFZqaEhzSEEzSlhkNkRHbGtuS0RjOVIralcxYnN5T0diekVnYXNuV0o4?=
 =?utf-8?B?aUU3azc3Rjl1ZlhuUnJ3Y2w1a0cxQXNzZHRscFhZc2FhN1BEaHNrWmgwMVBP?=
 =?utf-8?B?L2l0TktOUkNXVkdmbVlBWXZXY1Y0YmtwYW9QS3U3UFhnM0xYM1hEenhmRERG?=
 =?utf-8?B?NzhHZmlrQlhKNU1DSEJJd29UQ3VNQVdxVG1pTE9yVDVxNTBZSnBwaGZDTlVN?=
 =?utf-8?B?dFZEMXV2cHRHTFdtRm9GSVdSa1A4b2pRci9iOHI2WFY3YmxTQWZNVm9RaWFp?=
 =?utf-8?B?S1JvUHJwNFJBVVZ5K0ZZbVJKdzdka1JXNzhMNFArT2VST3h5dGFzQkREM1JX?=
 =?utf-8?B?WnRyVHY5S0VlTldCSllwM2ZJRzFyelZGWW13cnVSYmREdmJNbVQ4bGpFa2Q4?=
 =?utf-8?B?aitKcnZYOHBFNG5EMkcwdW1qQ0xFYUlPQ3Y1dXhZWXpqQkFRaG8vdlZuSjFH?=
 =?utf-8?B?U2ZvMmh4MzQzU2Fad2ZGT1FVV0R0Ti9Ja043cEZEa1gxVTVPdUdQcEg1L0w2?=
 =?utf-8?B?R0FZZmtaUHdGc2xzcitRSG50UmJ6TXU5UjB6R3p0YmRkUmM4TCtuQis2MUxL?=
 =?utf-8?B?QSsyWGU1MzIwK2s4TUlkSWFHTXg0VUVtb0RpK1dHQWNnTEFQREFaZ0JWampW?=
 =?utf-8?B?YytHVEJDRTBMUU5vMitLejVVUzMvUkE5Wmxvek53YTFUV3d0eTNHMVdXc3hh?=
 =?utf-8?B?ZVpnZjRhOU1SZy9YU2NJV1d0a0tlOHR5dTZYS1lUbzVVaTZ3a2lwY3ozSDBm?=
 =?utf-8?B?aFA5SVh1d0FhSVlkSXJaNkNMdWNSNWJleUtlWUh1OUJCOHpWRzY5YkIxMzNY?=
 =?utf-8?B?cHNsWnhGWGc3b01CdmYrRnNGaTJiNitIYWE2UHJFVHlYSlhMVjU4eDVJem90?=
 =?utf-8?B?NHZiUW13ei9tclh1WHAvaGgzL2o2Q0psWUFEa0FhTmpBOUR1WEorTU5NUGov?=
 =?utf-8?B?MCtHWllHZXowK2h2SFZOdFFmeFBTY1BaRUowMml0ckFsR1BLcnVNWUNkRnVR?=
 =?utf-8?B?cTByUFkwSzlRZ2g1UW5zbmx2bUdQVy9VTzJRbHJJK2RsbElneXBHQW9jakFu?=
 =?utf-8?B?S2d2bVRDYVRVbkVMWnI5UENPc0M4Y25QYTZNMk5maWUyanM5M0NXVTdvb2E2?=
 =?utf-8?B?d3A4ZktBQi8vZ1FEZGRhMDZVRm9GWGVVcHFyQlM4VlNjanc0UWRucnRDcUpB?=
 =?utf-8?B?WGM0ZEpiaTBOeFpYeUFNL0JJZFJPaFBQQVVWblo1ckdmRmxRYnovR3VOallj?=
 =?utf-8?B?Ymg2WDNCQ2lqbnJncC83Ymp4M2VtNCtpaldNOVFTR1A4ZWEwZmhSYkpubk5P?=
 =?utf-8?B?RCtkclBWS0hJYVlZeitUbDJISENHcmhhR3lSbEpPTHpuTlErbTlxNTcxVDlp?=
 =?utf-8?B?L3hyNTJuV2g4dmMxRnN4aW90KzFqOFRkUk1UWlhSZGJ0Q29YejJIQjZCS3Vu?=
 =?utf-8?Q?NmCs=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(34020700016)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:47:03.4710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ad028d-2529-4eaa-bb1f-08de17bacee5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5889
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
> We use the spl_board_prepare_for_boot hook to call k3_r5_falcon_prep
> which is ran after tispl is loaded but before jump_to_image.
> 
> In k3_r5_falcon_prep, we find the boot media and load the kernel FIT
> just as standard secure falcon mode (since spl_start_uboot returns 0
> now). Once the kernel and args are loaded.
> 
> Now when the flow goes to jump_to_image, we do the regular pre-jump
> procedure and jump to TFA which jumps to the kernel directly since we
> have already loaded the kernel and dtb at their respective addresses
> (PRELOADED_BL33_BASE and K3_HW_CONFIG_BASE).
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>   arch/arm/mach-k3/common.c    |  8 +++++++
>   arch/arm/mach-k3/common.h    |  4 ++++
>   arch/arm/mach-k3/r5/common.c | 45 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 57 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 04a0f232d84..c446d1c47fd 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -360,6 +360,14 @@ void spl_perform_arch_fixups(struct spl_image_info *spl_image)
>   
>   void spl_board_prepare_for_boot(void)
>   {
> +#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
> +	int ret;
> +
> +	ret = k3_r5_falcon_prep();
> +	if (ret)
> +		panic("%s: Failed to boot in falcon mode: %d\n", __func__, ret);
> +#endif /* falcon mode on R5 SPL */
> +
>   #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
>   	dcache_disable();
>   #endif
> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
> index 52d3faaab5c..5807d358464 100644
> --- a/arch/arm/mach-k3/common.h
> +++ b/arch/arm/mach-k3/common.h
> @@ -52,6 +52,10 @@ void do_board_detect(void);
>   void ti_secure_image_check_binary(void **p_image, size_t *p_size);
>   int shutdown_mcu_r5_core1(void);
>   
> +#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
> +int k3_r5_falcon_bootmode(void);
> +#endif
> +
>   #if (IS_ENABLED(CONFIG_K3_QOS))
>   void setup_qos(void);
>   #else
> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
> index 6269b33f66b..439dd92ef54 100644
> --- a/arch/arm/mach-k3/r5/common.c
> +++ b/arch/arm/mach-k3/r5/common.c
> @@ -376,3 +376,48 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
>   	}
>   }
>   #endif
> +
> +#ifdef CONFIG_SPL_OS_BOOT_SECURE
> +
> +static bool tifalcon_loaded;

Not strictly needed as statics will default to 0, assigning false
here makes it more clear what the starting value should be,

static bool tifalcon_loaded = false;

> +
> +int spl_start_uboot(void)
> +{
> +	/* If tifalcon.bin is not loaded, proceed to regular boot */
> +	if (!tifalcon_loaded)
> +		return 1;
> +
> +	/* Boot to linux on R5 SPL with tifalcon.bin loaded */
> +		return 0;

Extra indent tab here.

> +}
> +
> +int k3_r5_falcon_prep(void)
> +{
> +	struct spl_image_loader *loader, *drv;
> +	struct spl_image_info kernel_image;
> +	struct spl_boot_device bootdev;
> +	int ret = -ENXIO, n_ents;
> +
> +	tifalcon_loaded = true;

Should this be set down after we make sure loading doesn't fail?

> +	memset(&kernel_image, '\0', sizeof(kernel_image));
> +	drv = ll_entry_start(struct spl_image_loader, spl_image_loader);
> +	n_ents = ll_entry_count(struct spl_image_loader, spl_image_loader);
> +	bootdev.boot_device = spl_boot_device();
> +
> +	for (loader = drv; loader != drv + n_ents; loader++) {
> +		if (bootdev.boot_device != loader->boot_device)
> +			continue;
> +		if (loader) {

If loader is NULL, the if above containing loader->boot_device would have
already null pointer deref crashed. You might want to move this check up
into the if check above.

Andrew

> +			printf("Loading falcon payload from %s\n",
> +			       spl_loader_name(loader));
> +			ret = loader->load_image(&kernel_image, &bootdev);
> +			if (ret)
> +				continue;
> +
> +			return 0;
> +		}
> +	}
> +
> +	return ret;
> +}
> +#endif

