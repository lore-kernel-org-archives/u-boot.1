Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C064CCF9F0
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 04:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 658FD83A13;
	Sat,  1 Nov 2025 05:00:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qjmXrpMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29F2783A15; Sat,  1 Nov 2025 05:00:38 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AA79839DD
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 05:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7u45Ue8KbY6hQK4yB8FULe5yzYzQ7+MzYJyAYexIGkHX4Neav+ORegz2laIp4S3or76obbZGNPBt8zGRSS9JE2e1ANYgnYf9UvKPvlpcK5cRelTDJWoA1OFhkcXdoYLcO3a/Yp3xwViuuOOqfmSd7mdzFPYtJylPkJUeXE10ql3AjrdkRrQKpXJqYnCQs0dz210MquPMoNptWvnVGM/ps6ajOfqoW2//9AvyvSK1Enn05cYUvPEqsxxNO0wBMfOeoe9fLSjQeTdcQJsY0kEG/U7XBNr5WRTEkzzKYev41pXpxZTmq2+kVfOoZWCfUFbYOC1p0ZFeT7BC6b3Wy8e2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OrML685Eo3HlkZvKEORfut3hN8maqscTgjajLQSLko=;
 b=kGsWcGkNMMV+kgWozcOdah2xRDIs44jON6o3GqNPLca2DbWuBpJ/VaoDsunQg8BEYHmaSzslyrSxz7TgFsi15/FRY/QcN6QYvsd+9Gm3+KJ1ux/XWkUMvYJP2xTNSAfTwXtMpShP4ByWbGnhT/fYYqER96Jyphu8RpgR0z9lWw98Kn9wVeGrcami9Mok9oLrPBi/kaTPBjxYdLB9VaVeR1+oC0ybj9lAAUGRCumjjI5vgtmn0Ag2ktYMqKF4MHIINwgLx9iCBT/SKpgEQCIS9hDvTfzONDs1AtWJoMQuxSgmnDYLA0Cvb3nRMAqUjVTD8mO5MkS4Lm9RJXDtQB5MDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=bestguesspass action=none header.from=ti.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OrML685Eo3HlkZvKEORfut3hN8maqscTgjajLQSLko=;
 b=qjmXrpMyfo37604aEm3DtvvaVg6mBwRnqjKUR9XOx1GE6kLN7jHh2dzxcixIEwzHFw1PNACePIGZRXqpC4mhpIpo4MH6SBLTE3CWeHwzGnZ/LeNUA0C+RRP1qvtx/+Xrf4Nlk+3UVw7aAQ/M/kZ2V7w29oDKxjVimdFENRpoF0c=
Received: from BL1PR13CA0327.namprd13.prod.outlook.com (2603:10b6:208:2c1::32)
 by CY5PR10MB6070.namprd10.prod.outlook.com (2603:10b6:930:3a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Sat, 1 Nov
 2025 04:00:32 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::44) by BL1PR13CA0327.outlook.office365.com
 (2603:10b6:208:2c1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Sat, 1
 Nov 2025 04:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Sat, 1 Nov 2025 04:00:30 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 23:00:26 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 23:00:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 23:00:26 -0500
Received: from [172.24.234.127] (psdkl-workstation0.dhcp.ti.com
 [172.24.234.127])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A140MGn687114;
 Fri, 31 Oct 2025 23:00:23 -0500
Message-ID: <5f1d8353-bb04-4f43-847d-9f66761b574d@ti.com>
Date: Sat, 1 Nov 2025 09:30:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mach-k3: refactor A53 speed grade clock-rate fixup
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Aparna Patra <a-patra@ti.com>, "Bryan
 Brattlof" <bb@ti.com>, Udit Kumar <u-kumar1@ti.com>, Dhruva Gole
 <d-gole@ti.com>, Judith Mendez <jm@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Nishanth
 Menon" <nm@ti.com>
References: <20251030-ti_speed_grade_fix-v1-0-703e4189640a@ti.com>
 <20251030-ti_speed_grade_fix-v1-2-703e4189640a@ti.com>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20251030-ti_speed_grade_fix-v1-2-703e4189640a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CY5PR10MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5c718e-2a25-4f98-fc13-08de18fb32ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2pXZVAyNHBRODVUTEV6M1NqeDMwblF0RnBFekNUM2tUdGNUeXZBcmFUREdq?=
 =?utf-8?B?V0gzUG1zdVNnOVl3dm9pbmZQVGtlNzZyVHpFR2E1OElvenNianRKTE1ENjdh?=
 =?utf-8?B?STFBWlhqb1ZjNUU3YUdndEtGYXRaSjNjTVdwOGZFeWN1OFNDbVRzNEU5ODJL?=
 =?utf-8?B?R2ZxREIyR0N4c3BHLzVNT2FzTGM0bHpnREN3SjFCUW05NmRnbHJmUHBLdzhY?=
 =?utf-8?B?UFZ1N0pKUFZkcmVUbnhJazNGN1NRTzYvYnE5MXRYaVZmRmVWak12QXZJeEJD?=
 =?utf-8?B?MWlGMmpxd1RWWk8raTVjMUJGV1RnSGE5YmZOZitNc1RGbTF4L0NjNStYNVlK?=
 =?utf-8?B?NVNOL01YY2FBeHkyelI5cWt4cWpZUTIwQUxIN3FLbjdHYklQNEFYcFpVcVI1?=
 =?utf-8?B?UE9OMFdvVC9LMkR0NWNabnhnWmxMNElXeVM0NGJWZFdPYUdsT0RraFE3TUg2?=
 =?utf-8?B?US96MUVWZDgzTEtBY3hvUndTRE15RzBPRitaQ2Y2TVNKbUNERjVsekpNZ1FS?=
 =?utf-8?B?SWY5RUpLbEwrbDF6V2JoaGl2VUovbmlZdjZxbzNsSXd3WCtoMDdiTDlPaWw2?=
 =?utf-8?B?QXdocTJ6L01TQmhuYy9ISGJYR0llZTdLeTR1UzhnbmJxWVRPcStyZEpOSWZ0?=
 =?utf-8?B?eks0RFh1SUtOeTB5WUdKdVUrcSt3OWNTL2x3WlZMdUF4dTVIUmQycFNCRk5o?=
 =?utf-8?B?NmNPM3hGUDVCdVE1SHdPL1JoVHdSbWVQZlM0ZlJkL3M4SXB2d0tOYXhySUZW?=
 =?utf-8?B?SUF2RnlGSWRrdGx6anViMW1rNkNMSzdmNUtqa1BUelRRTmFxRVgwbU9zYXZt?=
 =?utf-8?B?VkRWQksyTUY0cDZ2QmVGNVBXTkdsWjN3djJlRGlTUmR5RU9yMjRxb2NpeE95?=
 =?utf-8?B?SXg0VWJIUTJWY0twT2ZFTUZ1dmY0SHVHM1ByRkVsaWdGeDBhZXdvWmdZVklh?=
 =?utf-8?B?UlN2a1c4R0pMMkpIN3Q2UzVXWjdZeGJWUUNWeUZuanBCeUV6NGhVaHdaRWhq?=
 =?utf-8?B?bWthWEMwdFlyWkE3RW5xeUtmbzRVYmY5SWhXcDNJd2h3eEhkbi83N3FSNUpP?=
 =?utf-8?B?QUR2UXFhQ0RvdTRqckpnVFUvQVR1Y2dOZW9seHRobHJILzlQRS8zc1hRRENm?=
 =?utf-8?B?RHFWakplSTF3WFI0Zis3Y2l1RHY2UUZOSE4xQ3dvZEFCRTNnbjJWK2Nub0N3?=
 =?utf-8?B?aGRkbHR4ZFUrdm9taVhOOExvL3UrMzBlMjEyVUdYbWNXcjJMQ2FMQU84QjR3?=
 =?utf-8?B?QjhrQS9wMTBBcUNVSThkVld1MENaU1dGNFRQTS9NeVBtLzNxcDRTb29hcGRX?=
 =?utf-8?B?Sjd3OCszc2ZWcmwydFlYRElzd3Yvb2xha3ZPRHpYdmJsVy9OQXhRQU1nRys4?=
 =?utf-8?B?ZlVrV01XbjNCamt4VkMwV3RTY2s3R0tTblBGdWcrTUxreVRzMjFWMDViRU1T?=
 =?utf-8?B?ek0vdWxBd3VpSTNINTErbEEyeDVLc2ZUVENPbUVPQmVsM2hkSVk4V2pvc2J0?=
 =?utf-8?B?bW0wWEpYVVVIQTFSN3Jkd2lLOG5wSUlMd2RReTRWU3YwbHRtQjZGMzd4SmRq?=
 =?utf-8?B?UHAxVzRHWFA0RDhGTUlEL2w5WnpPU3ZVTnYveE9wSXJGVDBKZ3VaTjJOMmFF?=
 =?utf-8?B?eXl0Vnh2ZkM1aGlYTSt4WFNLVkxzWDZtMDJPNFRvWERqYmlzVDIxSzVTNTdJ?=
 =?utf-8?B?VURJWnBDeUNJeHMxMi9XOG5rVXRpSkNiWmppc05hVEZXNVJESnZyVFVweC9y?=
 =?utf-8?B?MDNIYXl3MjlhZXpOVEl6emZWTDNOMzhWV2JZdnVBRjFHTDRRVElGZk1rbEQx?=
 =?utf-8?B?RWFET1U3QU90MFZXalRuNUV5SFRIYVN1bHpPWmNSenRwT0QzOU5aanlWQmdj?=
 =?utf-8?B?V1VDNVNoazQ4bzZlUEZLL2k2TmdhQ054QTJubW1aZm4vZkl1clhWNWcrZzdl?=
 =?utf-8?B?WmlNckhKeDZLc3FOQTdteHpqc284UTVSTmRrdzMyd1Z6NnUyTm1JZkZlYWky?=
 =?utf-8?B?WlhrZjY4QWljaG4zSE5LVW16L2s1bHNaZUxTVFFVdFlNaWliMFVURDZhQjNi?=
 =?utf-8?B?b3I2ZDc4aUpjTVNFeVBBLytiTUFBT1Q2Rm8vM2dHcVNoeVJpaXFOQnMwTkhx?=
 =?utf-8?Q?Xd7w=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(34020700016)(1800799024)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 04:00:30.2294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5c718e-2a25-4f98-fc13-08de18fb32ee
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6070
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



On 30/10/25 18:33, Anshul Dalal wrote:
> The K3 ARM64 rproc driver uses the "assigned-clock-rates" value in the
> respective "/a53@0" node to properly configure the clocks for the A53
> core.
> 
> Although the clock value in the DT node might need to be fixed based on
> SoC's speed grade at runtime. Certain SoCs such as AM62p and AM62x
> already had this implemented, this patch moves the common code to
> common.c to avoid duplication and simplify speed grade handling.
> 
> The logic to detect the correct entry in the "assigned-clock-rates"
> property has also changed. Where we earlier relied on per SoC specific
> device and clock IDs for the A53 core, we now use the "clock-names"
> property which is device agnostic.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>   arch/arm/mach-k3/am62px/am62p5_init.c          |  87 ++++++--------------
>   arch/arm/mach-k3/am62x/am625_init.c            |  84 ++++++-------------
>   arch/arm/mach-k3/common.c                      | 108 +++++++++++++++++++++++++
>   arch/arm/mach-k3/common.h                      |  11 ++-
>   arch/arm/mach-k3/include/mach/am62_hardware.h  |  24 ------
>   arch/arm/mach-k3/include/mach/am62p_hardware.h |  17 ----
>   6 files changed, 165 insertions(+), 166 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
> index aebd5200b0db9959805d04408b34d283e21b6e2c..eeb054d575ad94040370817f648c5319850fe7f8 100644
> --- a/arch/arm/mach-k3/am62px/am62p5_init.c
> +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
> @@ -11,14 +11,10 @@
>   #include <dm.h>
>   #include <dm/uclass-internal.h>
>   #include <dm/pinctrl.h>
> -#include <dm/ofnode.h>
>   
>   #include "../sysfw-loader.h"
>   #include "../common.h"
>   
> -/* TISCI DEV ID for A53 Clock */
> -#define AM62PX_DEV_A53SS0_CORE_0_DEV_ID 135
> -
>   #define CTRLMMR_MCU_RST_CTRL             0x04518170
>   #define RST_CTRL_ESM_ERROR_RST_EN_Z_MASK 0xFFFDFFFF
>   
> @@ -26,6 +22,29 @@ struct fwl_data cbass_main_fwls[] = {
>   	{ "FSS_DAT_REG3", 7, 8 },
>   };
>   
> +const struct k3_speed_grade_map am62p_map[] = {
> +	{'O', 1000000000},
> +	{'S', 1250000000},
> +	{'T', 1250000000},
> +	{'U', 1250000000},
> +	{'V', 1250000000},
> +	{/* List Terminator */ },
> +};
> +
> +char k3_get_speed_grade(void)
> +{
> +	u32 efuse_val = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
> +	u32 efuse_speed = (efuse_val & JTAG_DEV_SPEED_MASK) >>
> +			  JTAG_DEV_SPEED_SHIFT;
> +
> +	return ('A' - 1) + efuse_speed;
> +}
> +
> +const struct k3_speed_grade_map *k3_get_speed_grade_map(void)
> +{
> +	return am62p_map;
> +}
> +
>   /*
>    * This uninitialized global variable would normal end up in the .bss section,
>    * but the .bss is cleared between writing and reading this variable, so move
> @@ -74,62 +93,6 @@ static void ctrl_mmr_unlock(void)
>   	mmr_unlock(PADCFG_MMR1_BASE, 1);
>   }
>   
> -#if CONFIG_IS_ENABLED(OF_CONTROL)
> -static int get_a53_cpu_clock_index(ofnode node)
> -{
> -	int count, i;
> -	struct ofnode_phandle_args *args;
> -	ofnode clknode;
> -
> -	clknode = ofnode_path("/bus@f0000/system-controller@44043000/clock-controller");
> -	if (!ofnode_valid(clknode))
> -		return -1;
> -
> -	count = ofnode_count_phandle_with_args(node,  "assigned-clocks", "#clock-cells", 0);
> -
> -	for (i  = 0; i < count; i++) {
> -		if (!ofnode_parse_phandle_with_args(node, "assigned-clocks",
> -						    "#clock-cells", 0, i, args)) {
> -			if (ofnode_equal(clknode, args->node) &&
> -			    args->args[0] == AM62PX_DEV_A53SS0_CORE_0_DEV_ID)
> -				return i;
> -		}
> -	}
> -
> -	return -1;
> -}
> -
> -static void fixup_a53_cpu_freq_by_speed_grade(void)
> -{
> -	int index, size;
> -	u32 *rates;
> -	ofnode node;
> -
> -	node =  ofnode_path("/a53@0");
> -	if (!ofnode_valid(node))
> -		return;
> -
> -	rates = fdt_getprop_w(ofnode_to_fdt(node), ofnode_to_offset(node),
> -			      "assigned-clock-rates", &size);
> -
> -	index = get_a53_cpu_clock_index(node);
> -
> -	if (!rates || index < 0 || index >= (size / sizeof(u32))) {
> -		printf("Wrong A53 assigned-clocks configuration\n");
> -		return;
> -	}
> -
> -	rates[index] = cpu_to_fdt32(k3_get_a53_max_frequency());
> -
> -	printf("Changed A53 CPU frequency to %dHz (%c grade) in DT\n",
> -	       k3_get_a53_max_frequency(), k3_get_speed_grade());
> -}
> -#else
> -static void fixup_a53_cpu_freq_by_speed_grade(void)
> -{
> -}
> -#endif

The original function here was implemented behind #if 
CONFIG_IS_ENABLED(OF_CONTROL). (With an empty function in the else case)

While the new common implementation does not have such the config check.
Is this intentional?


Regards,
Aniket

> -
>   static __maybe_unused void enable_mcu_esm_reset(void)
>   {
>   	/* Set CTRLMMR_MCU_RST_CTRL:MCU_ESM_ERROR_RST_EN_Z  to '0' (low active) */
> @@ -251,9 +214,7 @@ void board_init_f(ulong dummy)
>   	spl_enable_cache();
>   
>   	setup_qos();
> -	debug("am62px_init: %s done\n", __func__);
> -
> -	fixup_a53_cpu_freq_by_speed_grade();
> +	k3_fix_rproc_clock("/a53@0");
>   }
>   
>   u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
> diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
> index 14f93ac998f7d11997b753550c0ea38926e35e64..9f7f2d8c084654b1b55a23a6fa889161cd1c8cb2 100644
> --- a/arch/arm/mach-k3/am62x/am625_init.c
> +++ b/arch/arm/mach-k3/am62x/am625_init.c
> @@ -12,7 +12,6 @@
>   #include <dm.h>
>   #include <dm/uclass-internal.h>
>   #include <dm/pinctrl.h>
> -#include <dm/ofnode.h>
>   
>   #include "../sysfw-loader.h"
>   #include "../common.h"
> @@ -26,15 +25,34 @@
>   #define K3RTC_KICK0_UNLOCK_VALUE	0x83e70b13
>   #define K3RTC_KICK1_UNLOCK_VALUE	0x95a4f1e0
>   
> -/* TISCI DEV ID for A53 Clock */
> -#define AM62X_DEV_A53SS0_CORE_0_DEV_ID 135
> -
>   struct fwl_data rom_fwls[] = {
>   	{ "SOC_DEVGRP_MAIN", 641, 1 },
>   	{ "SOC_DEVGRP_MAIN", 642, 1 },
>   	{ "SOC_DEVGRP_MAIN", 642, 2 },
>   };
>   
> +const struct k3_speed_grade_map am62x_map[] = {
> +	{'G', 300000000},
> +	{'K', 800000000},
> +	{'S', 1000000000},
> +	{'T', 1250000000},
> +	{/* List Terminator */ },
> +};
> +
> +char k3_get_speed_grade(void)
> +{
> +	u32 efuse_val = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
> +	u32 efuse_speed = (efuse_val & JTAG_DEV_SPEED_MASK) >>
> +			  JTAG_DEV_SPEED_SHIFT;
> +
> +	return ('A' - 1) + efuse_speed;
> +}
> +
> +const struct k3_speed_grade_map *k3_get_speed_grade_map(void)
> +{
> +	return am62x_map;
> +}
> +
>   /*
>    * This uninitialized global variable would normal end up in the .bss section,
>    * but the .bss is cleared between writing and reading this variable, so move
> @@ -123,62 +141,6 @@ static __maybe_unused void rtc_erratumi2327_init(void)
>   	writel(K3RTC_KICK1_UNLOCK_VALUE, REG_K3RTC_KICK1);
>   }
>   
> -#if CONFIG_IS_ENABLED(OF_CONTROL)
> -static int get_a53_cpu_clock_index(ofnode node)
> -{
> -	int count, i;
> -	struct ofnode_phandle_args *args;
> -	ofnode clknode;
> -
> -	clknode = ofnode_path("/bus@f0000/system-controller@44043000/clock-controller");
> -	if (!ofnode_valid(clknode))
> -		return -1;
> -
> -	count = ofnode_count_phandle_with_args(node,  "assigned-clocks", "#clock-cells", 0);
> -
> -	for (i  = 0; i < count; i++) {
> -		if (!ofnode_parse_phandle_with_args(node, "assigned-clocks",
> -						    "#clock-cells", 0, i, args)) {
> -			if (ofnode_equal(clknode, args->node) &&
> -			    args->args[0] == AM62X_DEV_A53SS0_CORE_0_DEV_ID)
> -				return i;
> -		}
> -	}
> -
> -	return -1;
> -}
> -
> -static void fixup_a53_cpu_freq_by_speed_grade(void)
> -{
> -	int index, size;
> -	u32 *rates;
> -	ofnode node;
> -
> -	node =  ofnode_path("/a53@0");
> -	if (!ofnode_valid(node))
> -		return;
> -
> -	rates = fdt_getprop_w(ofnode_to_fdt(node), ofnode_to_offset(node),
> -			      "assigned-clock-rates", &size);
> -
> -	index = get_a53_cpu_clock_index(node);
> -
> -	if (!rates || index < 0 || index >= (size / sizeof(u32))) {
> -		printf("Wrong A53 assigned-clocks configuration\n");
> -		return;
> -	}
> -
> -	rates[index] = cpu_to_fdt32(k3_get_a53_max_frequency());
> -
> -	printf("Changed A53 CPU frequency to %dHz (%c grade) in DT\n",
> -	       k3_get_a53_max_frequency(), k3_get_speed_grade());
> -}
> -#else
> -static void fixup_a53_cpu_freq_by_speed_grade(void)
> -{
> -}
> -#endif
> -
>   void board_init_f(ulong dummy)
>   {
>   	struct udevice *dev;
> @@ -294,7 +256,7 @@ void board_init_f(ulong dummy)
>   	}
>   	spl_enable_cache();
>   
> -	fixup_a53_cpu_freq_by_speed_grade();
> +	k3_fix_rproc_clock("/a53@0");
>   }
>   
>   u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 7c06764af8256b7fd27f8e7f208a597b1b91652b..3a97b70259e965c6ab400d5fbebd8b46f0a55173 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -304,6 +304,114 @@ void enable_caches(void)
>   }
>   #endif
>   
> +__weak char k3_get_speed_grade(void)
> +{
> +	return K3_SPEED_GRADE_UNKNOWN;
> +}
> +
> +__weak const struct k3_speed_grade_map *k3_get_speed_grade_map(void)
> +{
> +	return NULL;
> +}
> +
> +static int k3_fdt_set_assigned_clk_rate(const char *path, const char *clk_name,
> +					unsigned int new_clk_rate)
> +{
> +	int size, clk_name_index, phandle_count;
> +	struct ofnode_phandle_args phandle_args;
> +	unsigned int dev_id, clock_id, i;
> +	ofnode node = ofnode_path(path);
> +	u32 *clk_rates;
> +	int ret;
> +
> +	debug("%s: Setting clock '%s' frequency of '%s' to %u\n", __func__,
> +	      path, clk_name, new_clk_rate);
> +
> +	clk_name_index =
> +		ofnode_stringlist_search(node, "clock-names", clk_name);
> +	if (clk_name_index < 0)
> +		return clk_name_index;
> +
> +	ret = ofnode_parse_phandle_with_args(node, "clocks", "#clock-cells", 0,
> +					     clk_name_index, &phandle_args);
> +
> +	if (ret || phandle_args.args_count != 2)
> +		return -EINVAL;
> +
> +	dev_id = phandle_args.args[0];
> +	clock_id = phandle_args.args[1];
> +
> +	debug("%s: Found dev_id: %u, clock_id: %u\n", __func__, dev_id,
> +	      clock_id);
> +
> +	phandle_count = ofnode_count_phandle_with_args(node, "assigned-clocks",
> +						       "#clock-cells", 0);
> +
> +	for (i = 0; i < phandle_count; i++) {
> +		ret = ofnode_parse_phandle_with_args(node, "assigned-clocks",
> +						     "#clock-cells", 0, i,
> +						     &phandle_args);
> +
> +		if (ret || phandle_args.args_count != 2)
> +			continue;
> +
> +		if (phandle_args.args[0] == dev_id &&
> +		    phandle_args.args[1] == clock_id) {
> +			clk_rates = (u32 *)ofnode_read_prop(node,
> +				"assigned-clock-rates", &size);
> +
> +			if (i >= (size / sizeof(u32)))
> +				return -EOVERFLOW;
> +
> +			clk_rates[i] = cpu_to_fdt32(new_clk_rate);
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static u32 k3_get_a_core_frequency(char speed_grade)
> +{
> +	const struct k3_speed_grade_map *map = k3_get_speed_grade_map();
> +	unsigned int i;
> +
> +	if (!map)
> +		return 0;
> +
> +	for (i = 0; map[i].speed_grade != 0; i++) {
> +		if (map[i].speed_grade == speed_grade)
> +			return map[i].a_core_frequency;
> +	}
> +
> +	return 0;
> +}
> +
> +void k3_fix_rproc_clock(const char *path)
> +{
> +	u32 a_core_frequency;
> +	char speed_grade;
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_ARM64))
> +		return;
> +
> +	speed_grade = k3_get_speed_grade();
> +	a_core_frequency = k3_get_a_core_frequency(speed_grade);
> +
> +	if (!a_core_frequency) {
> +		printf("%s: Failed to get speed grade frequency\n", __func__);
> +		return;
> +	}
> +
> +	ret = k3_fdt_set_assigned_clk_rate(path, "core", a_core_frequency);
> +	if (ret)
> +		printf("Failed to set clock rates for '%s': %d\n", path, ret);
> +	else
> +		printf("Set clock rates for '%s', CPU: %dMHz at Speed Grade '%c'\n",
> +		       path, a_core_frequency / 1000000, speed_grade);
> +}
> +
>   void spl_enable_cache(void)
>   {
>   #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
> index 52d3faaab5c94578cf4f7e288cbf840500d490a1..6452188bd1949da83be20dcff6e59a282c3ff51e 100644
> --- a/arch/arm/mach-k3/common.h
> +++ b/arch/arm/mach-k3/common.h
> @@ -13,7 +13,8 @@
>   /* keep ram_top in the 32-bit address space */
>   #define CFG_MAX_MEM_MAPPED		0x100000000
>   
> -#define K3_FIREWALL_BACKGROUND_BIT (8)
> +#define K3_FIREWALL_BACKGROUND_BIT	(8)
> +#define K3_SPEED_GRADE_UNKNOWN		'\0'
>   
>   struct fwl_data {
>   	const char *name;
> @@ -21,6 +22,11 @@ struct fwl_data {
>   	u16 regions;
>   };
>   
> +struct k3_speed_grade_map {
> +	char speed_grade;
> +	u32 a_core_frequency;
> +};
> +
>   enum k3_firewall_region_type {
>   	K3_FIREWALL_REGION_FOREGROUND,
>   	K3_FIREWALL_REGION_BACKGROUND
> @@ -44,6 +50,9 @@ int load_firmware(char *name_fw, char *name_loadaddr, u32 *loadaddr);
>   void k3_sysfw_print_ver(void);
>   void k3_dm_print_ver(void);
>   void spl_enable_cache(void);
> +char k3_get_speed_grade(void);
> +const struct k3_speed_grade_map *k3_get_speed_grade_map(void);
> +void k3_fix_rproc_clock(const char *path);
>   void mmr_unlock(uintptr_t base, u32 partition);
>   bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data);
>   enum k3_device_type get_device_type(void);
> diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
> index 2f5655bf24ac64cb807e282650712c36ebca0f36..9b8fd6276f112375828acd0e2c3d14fd38dc6940 100644
> --- a/arch/arm/mach-k3/include/mach/am62_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
> @@ -113,15 +113,6 @@ static inline int k3_get_core_nr(void)
>   	return (full_devid & JTAG_DEV_CORE_NR_MASK) >> JTAG_DEV_CORE_NR_SHIFT;
>   }
>   
> -static inline char k3_get_speed_grade(void)
> -{
> -	u32 full_devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
> -	u32 speed_grade = (full_devid & JTAG_DEV_SPEED_MASK) >>
> -			   JTAG_DEV_SPEED_SHIFT;
> -
> -	return 'A' - 1 + speed_grade;
> -}
> -
>   static inline int k3_get_temp_grade(void)
>   {
>   	u32 full_devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
> @@ -142,21 +133,6 @@ static inline int k3_get_max_temp(void)
>   	}
>   }
>   
> -static inline int k3_get_a53_max_frequency(void)
> -{
> -	switch (k3_get_speed_grade()) {
> -	case 'K':
> -		return 800000000;
> -	case 'S':
> -		return 1000000000;
> -	case 'T':
> -		return 1250000000;
> -	case 'G':
> -	default:
> -		return 300000000;
> -	}
> -}
> -
>   static inline int k3_has_pru(void)
>   {
>   	u32 full_devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
> diff --git a/arch/arm/mach-k3/include/mach/am62p_hardware.h b/arch/arm/mach-k3/include/mach/am62p_hardware.h
> index a310b52b45dc5cb76c215c598deee287a2e8e3c6..3c8fbb6b4211153b34fd156ca87b484c5ac9322e 100644
> --- a/arch/arm/mach-k3/include/mach/am62p_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/am62p_hardware.h
> @@ -120,23 +120,6 @@ static inline int k3_get_max_temp(void)
>   		return JTAG_DEV_TEMP_EXTENDED_VALUE;
>   }
>   
> -static inline char k3_get_speed_grade(void)
> -{
> -	u32 dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
> -	u32 speed_grade = (dev_id & JTAG_DEV_SPEED_MASK) >>
> -			   JTAG_DEV_SPEED_SHIFT;
> -
> -	return 'A' - 1 + speed_grade;
> -}
> -
> -static inline int k3_get_a53_max_frequency(void)
> -{
> -	if (k3_get_speed_grade() == 'O')
> -		return 1000000000;
> -	else
> -		return 1250000000;
> -}
> -
>   #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
>   
>   static const u32 put_device_ids[] = {};
> 

