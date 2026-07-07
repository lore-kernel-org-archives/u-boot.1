Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A235C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 10:58:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C52D848EB;
	Tue,  7 Jul 2026 12:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MaqoaJ4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B75138498B; Tue,  7 Jul 2026 12:58:55 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 760B7846B4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 12:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0AeB2GWToqDWv4Mn/MDBZbC4xhSsyNpr6XWrkqvYDTs21NOCoeGM//VPA3AGDPPBf9kvWWc1Zu7V2RHqzpAf6tns2jHrbSlWr/+hZcblKyj2TWRtKdUjVZVd353rOTAafi0WM7O5CF9KqM0XX850gPTgDl6dGVQI5GzM+2L9fEoVeAntqx3prHaC8iNJBjiMfnmZ4nVsGZkVe2Rrc6WCryOOCK3QLlUiqI26xoaEmwfakrSrVtWO9dDFGlHg8L8qstTItg6KSaNfAQ+gZN7aLchaT/36zUaqunTlZpj8+Zu2Sa57IyqJTjXSLcMWCU3YYCtyeOeWP6xb3iV1h4weQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VB3HUesJUCzsuzHugb0qC5NdphgJyOMdq8+aAURxg8A=;
 b=Fr4rp1PHYP0fNA2EihHlRxHci+FJ2AfHboPPvmUMCxATPC2HpygzOTG/OGSvqmLgL8/3bO+RFU9n9NLgHUwArCdiwtFWxt002J5VSTvLoJPUFqOgsQx34Uz0LNSKmg9WRmPK4yn9zZvQhfqdNm3o4JJ37YYMTXRHAXVfg66rr3vU6RIo+H3Tn//aCJHcph2lPMgXe1vfzlh5UeuN3F10vlDWT+N+bsJqt38Nwv6FLqzi46khQD5BgSOk1pJZVOLuJaqDexCCRng9QhHJjkQmYMF9HMV5DX749XRV8cXNs+kJAFanKRflvqUWtKaMPskskyzizAZ0sII84inu68oLrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VB3HUesJUCzsuzHugb0qC5NdphgJyOMdq8+aAURxg8A=;
 b=MaqoaJ4b8lY+SEYOAsOLxaRCoPwlL/eFCtCr/EXzyV3ydkp69j+AdIniOyfMxCSRut8Nu1yykqNJ6FP4GK+JW11AD2CALhxdWnH09UV/VQ6iJrVKHOx/TXPsHnackKhPInNNO2eBgvlU5Qw3gKdnCgsmQKksNhRjg1EYMQEUk4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 10:58:49 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 10:58:48 +0000
Message-ID: <3c068e48-ef46-436f-afd8-13ca6f3eb533@amd.com>
Date: Tue, 7 Jul 2026 12:58:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal2: Select GIC redistributor base at runtime
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Maheedhar Bollapalli <maheedharsai.bollapalli@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Pranav Sanwal <pranav.sanwal@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <3819bbedb39a31a0f872540dac5ed6076d39c026.1782725609.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <3819bbedb39a31a0f872540dac5ed6076d39c026.1782725609.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::10) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c34031a-4318-440f-e9fb-08dedc16b938
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: H1+6KYtLT43CQ1vHzltR2SrfngKQvqpjCm8T4+O4PtLXvDgrBRtWSR8XqXXfFDoRxpVLxhz3JC1ti9IwqoDFhAlHXmZOUAqCeIWuFoowklUk5nmUSvOe+AeVWkmfrj/mzv+FaymY1fjMOpumbqcpCMrznoLOTT7CFzLTzNrGX37iBDBnE+1UM0pNYcYISU2KYuJnY/UCyg12QMEjeWJB0Ejm/f2HYcErFPCRZx17KBNyFM1PS8crU/sGN7FJT4yuTtzr3U50K2Qo84U4JqkbUNYhkVRaMYiojeZ5GKgByedxckdgHKh5c6VQ2HnwwlCrjQM/nwud5ikXB3zuhKn1oKQ2AEcutpmHAIeqFE9i9x4KFQDDTxKqWsz9Yx7LNdr60i70+AEab1uuyS7pR3p0DLsyzuWm79m7wRwQNOg7riZHgF4kiz+se7ntnN0GoBJG/sDCbVXs0hE/rTlYHLmjmJNQUvHtJxRl0xzUvwzQWflBB3X+FiYuoSxVfGNpInNTM9+hD65S2VLC/q6wpbu93+Q+xZfrMYO7rD+F7ZvyiwOccEn81YaN3Jff/uwoWHUy9c/xOMZQsidcCPfnDiCHfMJxUV3GmJmJoEDfTz7lk6D0jXpvUK1qxKBNCcsLuEzjQS8KPxNwWUABZ/3yToAPhOrNDlU5gFj01ruRMXM7Ijw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1Ivc1R0OW1UeUY3Q3AwdnpFbXJReWNPbTJxMXhRUGNhYm9iVXl1Y1dMTU93?=
 =?utf-8?B?UFZaK0ROTW9YVlN1KzZFdUJGSFFhNkNZNHhiV0dkM0hETEtrNmI3bTA2UkRw?=
 =?utf-8?B?d3V1UkFkOTFMVUg5Qzhpa3ZNdHFqVXNHeFYxZTBpYk5mSHBBV0ppZWd1TDB4?=
 =?utf-8?B?enZTSnhkUnh6OHRBUGRFblFNZ05mYVd2d2pTelFhVHJsWXYzcDZXb2dScjRT?=
 =?utf-8?B?YmdRUitML0pSeTYxV2k3K0MyR0VWdHdYVmhndlErNGVXNlFYM25tc2ZWQVRs?=
 =?utf-8?B?VGhPejZFdlNFa3VUS1VFbkE3Z2h2V09kT21QbXJvbko1bDIxdWRmbzJiYmV0?=
 =?utf-8?B?eGpLbzlvN0RVZDdlUytLY0NxZ3E1RTN5ZklGWVRvR205R2pZUjczTVFhK1Zh?=
 =?utf-8?B?VEpjeXRKLzBFVjZJUW4zS3JOcHNhZEJBMEM0ZFdacS9GQW9SUlBkSk5MRllt?=
 =?utf-8?B?UW1qb09xT1Y5OVg2ZmZUTVg4bTIzY2RUYW1tTmxNeU5ucU1sSXIxMnpkano1?=
 =?utf-8?B?dmxCZldLU0JJUHd4TWMwNUlZb252bk9Hd0k4UjVxaTB6WjdNV2l2MjQ1ZjJF?=
 =?utf-8?B?Y1hxbmoxa0R3TmNTWlJrZHprL0QvNTczdXVYSEs2R0k3VkRoTHRKdVdsZXdq?=
 =?utf-8?B?SWNBOTFXVk5rVGdBcWREOFd4aXpFUWVuRysyNjFoY2tCVE5LeGlFVTZ2aTZy?=
 =?utf-8?B?SUNxNll0VitKNHl4RnJuTTJiWWM1ejR2aGw4eUFSZlJDc0tPa3cwdTI1YnRw?=
 =?utf-8?B?MGxxRVZKTDJKWjBDdDRWdW1wYWdSZExscnlTUDhMZU1GSWFSSjQ2MVhKRFJR?=
 =?utf-8?B?dXZtWDRQdE1QSk5nM24zUm85VmFubGJ3Sm11QU81S2cvbUZ2QXgyazdaZzhG?=
 =?utf-8?B?cXhxMmYyZzlrUG8xNnl4WVVWN1VYbnhLNUIwS2U3b3VKc2lkQy91K0VHTGxB?=
 =?utf-8?B?TGRPNDJnSmtJbk14VEVHNGIzMDVlRDFDVHF5K01heDQ3Y0hvZFUva0tCeG9U?=
 =?utf-8?B?K2JKT2tYM0tXNGp1b3dNbHF0WVlsSm9aNHFjZkFiRFRwQlJLei9mQ1IyRkFI?=
 =?utf-8?B?dm9QbGtES0UyU2JiOXBiWXNnNHFoOCs1M0NERTNrb0o2cFFVYWNBUVJySTk1?=
 =?utf-8?B?WTVZNnZKc1krQ2ZyWjlXVjdyd0ZVbWxFQWhscll2dXZDckFoMjMwN05WR2FL?=
 =?utf-8?B?R3loaHRMbWZiZGlVdzNFSmUyRVVKWG9JMG9vQWs2Yk5QUWlrMEVNblBkWjZh?=
 =?utf-8?B?VUxXbFVxb3U0L3VFQzFldm9uVk9TdVdReTRSY3A1NnNPdGY2akQxc3R2M1Jm?=
 =?utf-8?B?UVZIME5yNjRJYStBZFFoZ2M2VDF6U3N1aUhPbWd2OVo3U2RPTS9kemgzZ2hX?=
 =?utf-8?B?RGhrS09QMWpFTGprS2Rvb1FxWlpRNFNmcnpXMm55VzJ3MVJGc1VkTGZEaVU5?=
 =?utf-8?B?TmJDMnZkMnl4UU1YN0pwQ1RFTkV5eVg5bjN5a3VWQjdxaU5tN3hBNzNVL29B?=
 =?utf-8?B?bzZQOEJZaG42WjQxMVMvNFFHbDBVYnVhaUlMcitERDBXckppT2o1aEQ4dkwv?=
 =?utf-8?B?ay9wWktEZE04YVhibEh2dnRvK2FKTGp1VVFFUjAwelRGM2dxaCtVT2Ixci9a?=
 =?utf-8?B?bG9Yc2xnRmFRZGJmRC9MOGxEK0NWQ2h0SlFtQmNxN1JreXMwbU9DRjJocXNW?=
 =?utf-8?B?NWJuYU5LNThXc2I4UE85Q1I5MnByRzNGalBDWEIyc3VneWpWaFI5S1JVeitR?=
 =?utf-8?B?bWxRdXNsTjZsVnJUaWhSeVJGc2o5K3VBUlIwQ3FoVHBhd0lkRkQ2TzlUQnlV?=
 =?utf-8?B?Z3FqMkk1TUNvREVRako5eU1NNFZJNjNCRFI2RGZwbFJqcTFKNXZ5SHAvWGYr?=
 =?utf-8?B?eFR0ZEVaaUxRTnRaeHVYVVp1ZmJKb0lwK3htU1F1TWcrblFlaHJLTU1QUGNB?=
 =?utf-8?B?QkE1bUVDTm9leHZON3dOaTFpZGF5dC9aNy9LcjQxWXJNWTRFZXNXL3V5VHUr?=
 =?utf-8?B?a0hJS0FhR0pKZ1JUZ01YaWdWQm4rS3c3TFhpaEhRUEZRWmg3SW5DVzUyOXdQ?=
 =?utf-8?B?amducERpMTFjNE52Q2hycHF0RWpjOWx1L2VUTFh4SDdmM2djWlp2SEl4c2s1?=
 =?utf-8?B?cE5jbUZPcFlHVUlPb1ZPbUZzaVNMcmQ3YlVaQWJPWWRUcExLZEVkNWNwd0dZ?=
 =?utf-8?B?Z1B5dGhMYkYxa3V1djZLb1RDS0xFTWZuRWsyQXl4TGhEaEpDQUg5ditMa3ov?=
 =?utf-8?B?dEd0Rm9EWFB1ekJ5VWVHLzdEVW9jekRYc0lBVllldlVsRUNtYjhickYxTUxt?=
 =?utf-8?B?c0VLdENQS3A3R1R2cnpEbzZlQXBWeGFObU5qMDgrTHhRYm5BV3BEQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c34031a-4318-440f-e9fb-08dedc16b938
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 10:58:48.9311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiM0yQW0ly8QaeFxSHaJfeR4SXCAsis+9DKGQs+LwJTSD/MyDCClRbGOeHW4YXC6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
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



On 6/29/26 11:33, Michal Simek wrote:
> The GIC redistributor base address depends on the part: the 2VM3654
> device has 4 APU cores and 3 GIC ITS blocks, which shifts the
> redistributor region up compared to the base 8 core / single ITS part.
> A single U-Boot binary must therefore pick the right base at runtime
> instead of relying on the compile-time GICR_BASE used by the generic
> lowlevel_init().
> 
> Add a SoC specific lowlevel_init() that reads the PMC TAP IDCODE and
> selects GICR_BASE_2VM3654 for the 2VM3654 device, otherwise keeps the
> default GICR_BASE. CONFIG_ARMV8_MULTIENTRY is not supported on Versal
> Gen 2 so the generic slave handling is intentionally dropped.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/mach-versal2/Makefile        |  1 +
>   arch/arm/mach-versal2/lowlevel_init.S | 40 +++++++++++++++++++++++++++
>   include/configs/amd_versal2.h         |  9 ++++++
>   3 files changed, 50 insertions(+)
>   create mode 100644 arch/arm/mach-versal2/lowlevel_init.S
> 
> diff --git a/arch/arm/mach-versal2/Makefile b/arch/arm/mach-versal2/Makefile
> index 96497b1dfd0a..73b3c8a6f357 100644
> --- a/arch/arm/mach-versal2/Makefile
> +++ b/arch/arm/mach-versal2/Makefile
> @@ -8,3 +8,4 @@
>   
>   obj-y	+= clk.o
>   obj-y	+= cpu.o
> +obj-y	+= lowlevel_init.o
> diff --git a/arch/arm/mach-versal2/lowlevel_init.S b/arch/arm/mach-versal2/lowlevel_init.S
> new file mode 100644
> index 000000000000..8bfe50b806e3
> --- /dev/null
> +++ b/arch/arm/mach-versal2/lowlevel_init.S
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * SoC specific lowlevel_init for AMD Versal Gen 2
> + *
> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#include <asm-offsets.h>
> +#include <config.h>
> +#include <linux/linkage.h>
> +#include <asm/macro.h>
> +#include <asm/arch/hardware.h>
> +
> +ENTRY(lowlevel_init)
> +	mov	x29, lr			/* Save LR */
> +
> +#if defined(CONFIG_GICV3)
> +	branch_if_slave x0, 1f
> +	ldr	x0, =GICD_BASE
> +	bl	gic_init_secure
> +1:
> +	/*
> +	 * Pick the redistributor base for this part. Default to GICR_BASE
> +	 * and switch to GICR_BASE_2VM3654 when the PMC TAP IDCODE matches
> +	 * the 2VM3654 device.
> +	 */
> +	ldr	x0, =GICR_BASE
> +	ldr	x1, =PMC_TAP_IDCODE
> +	ldr	w1, [x1]
> +	ldr	w2, =GICR_IDCODE_2VM3654
> +	cmp	w1, w2
> +	b.ne	3f
> +	ldr	x0, =GICR_BASE_2VM3654
> +3:
> +	bl	gic_init_secure_percpu
> +#endif
> +
> +	mov	lr, x29			/* Restore LR */
> +	ret
> +ENDPROC(lowlevel_init)
> diff --git a/include/configs/amd_versal2.h b/include/configs/amd_versal2.h
> index a07e12bd1468..00627dcd9433 100644
> --- a/include/configs/amd_versal2.h
> +++ b/include/configs/amd_versal2.h
> @@ -19,6 +19,15 @@
>   #define GICD_BASE	0xe2000000
>   #define GICR_BASE	0xe2060000
>   
> +/*
> + * The 2VM3654 part has 4 APU cores and 3 GIC ITS blocks (vs 8 cores and a
> + * single ITS on the base part), which moves the redistributor region up by
> + * the two extra ITS blocks. The right base is selected at runtime in
> + * lowlevel_init() based on the PMC TAP IDCODE.
> + */
> +#define GICR_BASE_2VM3654	0xe20a0000
> +#define GICR_IDCODE_2VM3654	0x04d98093
> +
>   /* Serial setup */
>   #define CFG_SYS_BAUDRATE_TABLE \
>   	{ 4800, 9600, 19200, 38400, 57600, 115200 }
> ---
> base-commit: e01bb5b8ad09464b8cbf9c4186683e998c2d40fe
> branch: debian-sent3
> 

Applied.
M
