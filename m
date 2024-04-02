Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3009C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 16:39:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFDA28815E;
	Tue,  2 Apr 2024 18:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="UeIqRAod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A2488155; Tue,  2 Apr 2024 18:39:06 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85C0688170
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 18:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzZUDtRSejUus7moLi9VuWx4uUZ6gTBGIJ30brbYUvC5/08gbNPaf8PmQeNo79UFKtuRRUzD8M0AcM5BIuZkcOpHa4zU183RS0onNBhfhXjuMEiHSYQT15E+TUdNtJw73D288naPOU4ECFwTufBRbgzWOX6IYtC1b40tUfjyL4yGoTK5qo8prtLGYExKQe2Haw9Hs6zeqQxLyTfWciV/S2QWX/n5431pkJZasJt/jlm1hHDM6u8ek4v473nk24H6l1iu5q5L0Tw7+woTezdLdRZUGsWGtitn3Aw+3c0bgpTgNljJuDGJ/9YpJdqSuW7BUEhrbtW8d8j+ZbU3E+Fcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TW0972hZgM88eY6G43dwLj1OUeuGperKQqqKxyAmxq8=;
 b=Oo+jEITlNHxRFRoGonW6+uYovLrfrDZc1Ayn4ZeVqWx3Ye+pk6HwyJvLhl97pcjkik9fkldVDyFCMdulJ8TqmuNP7KAmJLWn4l7kfW/Fhb4oanMX5JuUZJP5Gu6EtGUaNKsdvlJPGhc7mnkzHzzgi3+M6HCYpEnMYuf9yJ0N3U3s1GtKcWdyDZtOrrae7kLTYCGBWrRXAhVjcsFfi57e/vBE+CsKmNng0VUFnEAEWqTt9qL1AFOq1jiWnpLI+0vkigrZkJYrk1utq0wzsnGFE/6edVl0oDvx5O7GnPyT+LSFlLFcgJ4Qxwh5ckPZgjpnW11pE1/+tUv90JjfWH7lvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TW0972hZgM88eY6G43dwLj1OUeuGperKQqqKxyAmxq8=;
 b=UeIqRAodDKXGdyEgX4OvjxeNTzbAPgR9RpTFT9B2fll/NV4Tlq7KI+PRFn2adKp/kS9D8NaI0+MNkkjs9xo8xOST1iNfHg8/FkowNjEAQbRfb3V93j75ATPr3PtqXhYvLG6ZOVl/gjKB7NTBfxedPrB0qKYutZmUpJkuK6jn/KS7ZBIq2LCZ+MjRtU1ByihQfNs6ncjr2FbuKVFck9tNGOEBiGE/YhlCpYloYYnIGsC2vH6RatfdI/3FbhsCniiwebo+Skj/RtIWPHEg3xf+/cmpGUnWYxzGZrwAx3Y/spfop43mwixD6l+rH21c6yNSyz9OosI6J+H+a8/ch7EL9w==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DUZPR04MB9793.eurprd04.prod.outlook.com (2603:10a6:10:4b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 16:39:01 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 16:39:01 +0000
Message-ID: <7ceeb297-f1aa-406d-8e87-d02a92e58af8@theobroma-systems.com>
Date: Tue, 2 Apr 2024 18:38:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [V1 PATCH 1/2] rockchip: sdram: Support getting banks from TPL
 for rk3568 and rk3588
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: naoki@radxa.com, cym@rock-chips.com, gajjar04akash@gmail.com,
 frattaroli.nicolas@gmail.com, jagan@edgeble.ai, cnsztl@gmail.com,
 andyshrk@163.com, chenjh@rock-chips.com, frank-w@public-files.de,
 jjriek@verizon.net, eugen.hristev@collabora.com, tom@tom-fitzhenry.me.uk,
 jonas@kwiboo.se, inindev@gmail.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240401181435.553351-1-macroalpha82@gmail.com>
 <20240401181435.553351-2-macroalpha82@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240401181435.553351-2-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::10) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DUZPR04MB9793:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LPgmBSzY17QF9X0JKCT2AStmKB1CdHYm2teUd1ss2fBkmNdLUUeWMRf491lMierpR/CtC4fU0tQGC9Dc7rDrh9J8dAcyYU3Fj/8mziyeE2hfrp/n1VDEvG5tEf5r4H1IFwkUlE/L7ODpbcoXsTJfGGTewHiWV/NI4816V2LUz7UBRXkDjhuXxMWby3hKM0k8J5Wzoc4AZ65FluaD9yWAbr/6lQoSEWc6ml33Qke/CBk4iBCDkYpQ6gEC1u7Hed5FO2Yp4W/DkyUHQoGbxLDkbKWkvzSjrNHwYckrcDbjaiBwPDzM4viiUdjXh5d9E0610Y1BVM63+8HSh/rXSiakz8PLKDAvRFDc8usug1MftWsme5TOdKxOHr5Fvz95TEWoOHnxbwssyvuGzyHmY3O9WcHQsS5kQgw9fb8Jsy/PhspLzrlR/iuHGo+lvnSNK4SWfJzRLqtTFDcLNbpA5L9wy3howzCnG3D9yiGAGKgNTINhCbGIGvyHcZ3FemvIWhidAFmzPCsM4JqgOqhJ02xsqRb/qdrVCHQg/CSje2k5NFkc77lzasoLaZWxN/rAf3CM/f7I5s1o0wHmqAjP0psi/GpXDWdYnc/qFCF89qq+g1V1+R81P66cOBuErLiErLXCy3VNpDNxmRlyYwoD5OjCfTTfwre0CN2BHbcrE+i6Ec=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1pMMTF4MjlyN0VkanBTdWg0Qm56YVBUMHVyWHlEMFZIODYvcHNwb0I0QUhv?=
 =?utf-8?B?cWNJTm92TjBGaFRxZHphcmtRZnFZLzdxZno5SUVLWUdYTkRqSGFqMmoxZUVP?=
 =?utf-8?B?L1pxLzVpbHlZN0pqUVowZUpFOWxvSWpTMis5MzhKZFJNWVBiZ3BFVk9yZnY5?=
 =?utf-8?B?QWhZeTJKMHJFYlRDTkhaOFRFczh2aDljZXU1TituSWZMNmdXLzVLc3Zvek5t?=
 =?utf-8?B?UjRWaU5Lbmg1NGVxdFFmTkw4WExpcWlNRlQrcnRBTTFMUVBqNFZ2YWtNc2hF?=
 =?utf-8?B?cHRxRDJibUJsT2ZPeEF1THJEYmhhMGRUSzJSUUhvaStGYUJWc2pBWVdPUGw4?=
 =?utf-8?B?REl0ajdnVU0wY2k3UFhWcGFVK0tOdjJ4YzlneFdQTjhGQ29hcmRiemQ1MHFU?=
 =?utf-8?B?dGJ2SXFEWW9Ba3VhaDJ4cVZSQlhXNE1nMlJGcmxtUWdIdXM5QVR6RSthMDJK?=
 =?utf-8?B?Y1IxN1VsdUxVazN4YVVIbTlyMTRRb0ExUml1WlZjSElST1BqQ2k0WmlLdjZC?=
 =?utf-8?B?eVk3eHQ5NVphc2RzVnBnenRSSmdNTlFacHpXWkR1c2RXN3NVUS83eHpFQXhj?=
 =?utf-8?B?czdOZXJBYkducFhvVXZuU2dzQkd4MGluZ0pkaStxb2dKcWkyclFMelk1MjN6?=
 =?utf-8?B?VEprQ1kvV1RpL3dZTmt5dmt3cGl6Rk8yY05WalMrRWNWY3VSSkZadGVMOXIr?=
 =?utf-8?B?NSttd0h4Z1FnUjA2aEtuKzRUc09XRGFpOUZJcEN4aTd3aTdyZHBiQmtpejBl?=
 =?utf-8?B?V2tpVDJIUUVGMnVnWlgvOXlhbEZ3ZDdQRUc4V1ExL2FJMGJpeGF2L2hHek5L?=
 =?utf-8?B?R21iS2lqYVZYYjEwUHJFQnVmVzBTcjd0YnFiS0V2ZkxlUmRYSk5MTStLdlAv?=
 =?utf-8?B?OUhNVnFZWlZWZkpqVTBlUGJnUXAvVVVUK09YTGFwVTFDbVFkcC9ZaXBQeW5h?=
 =?utf-8?B?Uy9FZzljcTMxejVoM2hkekxZcUJYVjN2SWJvRzlQSlRQanU4dlZvbGlHUGhR?=
 =?utf-8?B?Mi90MTBML0wwY01XVEJodmpQbHRITlJLTzJqNVdOMWNJZFZPOXdlTlRCeVlJ?=
 =?utf-8?B?VG9wSHZTNHM5Sy8zS2FXRFJ4NFMvRklibDdhRVR0SlVPWTdtcmdJM2g4Vm9j?=
 =?utf-8?B?ZjZVcEVRS3E1cE5jRElLVi9tN29tYXZkNmNYTE1zeFRCNVV2MHdzNzdoazZW?=
 =?utf-8?B?bDBoN3hNN3hLZ3loVmJlR2hldFFRRzA2K0ROT2xiU1NqNHlDZ3RIYnVjaVlE?=
 =?utf-8?B?bjlVZWE1cHV6SG92WDhvRHlHU0w3dVROM3doTE9Pak4xS2d3WWovMGJiTzNw?=
 =?utf-8?B?b3FudGdGYkFmWXBXeUVRL3k5eGgyaWd4YmFpQ3JjcTd0YTM4ekhmRGwzeVhX?=
 =?utf-8?B?RFhEZUtTN1VhU2JoZ2lVYjZZSVFhSXh1cHBrbVBTWkVRNTBROWlJcDcwSHNh?=
 =?utf-8?B?QXVvYXd6YThBRlprc1RiWFpJTkdBeXdBWGF5ZWM4V3o3Tk4zSGp1QW5DYWRK?=
 =?utf-8?B?VFZPRjdHMHpQOUdRVkdNZ1dUZTgrclJ6TkxOb3BEWlR0SzUxNXp1UzVwcDcw?=
 =?utf-8?B?ZDR0UHBmKzgyZE5IWGViZWU5emlGZjhXdkNlVmJPS0pIRmh4czBPaGVrUHpI?=
 =?utf-8?B?OUdOeko0WkdJc3FlMmd1eHdYd1YwS0hjOG9RZEdiSmVtZVpZb2dFaVRjZTNk?=
 =?utf-8?B?WU9wS0NHZFdGR2pFRjZFRmhkbG9DWkFZRWF4eHVGT3ZNOUJDeEJwVGVKbEEw?=
 =?utf-8?B?dmZ1TDYzci84OWZWd1NwcnZqTzdnTTk0WC96Uk82bTFnOFJYWDR6UkNHWnIx?=
 =?utf-8?B?d1ZacERsWTV1Tm1FTHJlb1poZ29SSzM2ei9HeE95Zk0xRjdWRE1uQVh5RExm?=
 =?utf-8?B?eUErS0VoU2F6RWp4cExFM09icjNRSXRLcXcvTFduR0p3Snl1S2hweFU0VzJX?=
 =?utf-8?B?SjFaQzBGekE0MTNEVFZPazJOeDY5OXZhUEFtVk5oMnlNbTJrYjhtTmwvYmgv?=
 =?utf-8?B?RkVWckU5RFRXeHRaV0ZZUW01SjFxeUtDd1JCbkFYSnVWZ3NTRVAxeVJZelpN?=
 =?utf-8?B?bUpHR0VlQUMwdEcrZEY4VEZtUjExcUpMODROc3N5REJTT0xkeUlHRDI5VElR?=
 =?utf-8?B?bWtiMkVZc3RlQU5MbSt2U29tSDRuS29JdnRWOFhxamJxM2h1V0x6MWcvVXQ4?=
 =?utf-8?Q?DEyAqaUsvYhklMoXbSkr12k=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ff3ac0-9870-4040-d876-08dc533366fe
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 16:39:01.8335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvsXaOkxIXkAjlFDk615H42GKweDC88UwXhZNL+jINn0+EzlrGstkTT6v+Par3AidTFgIJRzDdQWvzLipqyXBOwkd1ypWWquUGdu2VYgYAe0CG+EiAgAZ81PMIzgwYxn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9793
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

Hi Chris,

On 4/1/24 20:14, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Allow RK3568 and RK3588 based boards to get the RAM bank configuration
> from the ROCKCHIP_TPL stage instead of the current logic. This fixes
> both an issue where 256MB of RAM is blocked for devices with >= 4GB
> of RAM and where memory holes need to be defined for devices with
>> = 16GB of RAM. In the event that neither SOC is used and the
> ROCKCHIP_TPL stage is not used, fall back to existing logic.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>   arch/arm/mach-rockchip/sdram.c | 100 +++++++++++++++++++++++++++++++++
>   1 file changed, 100 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index 0d9a0aef6f..e02fb03c5f 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -12,6 +12,7 @@
>   #include <asm/io.h>
>   #include <asm/arch-rockchip/sdram.h>
>   #include <dm/uclass-internal.h>
> +#include <linux/errno.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> @@ -35,11 +36,110 @@ struct tos_parameter_t {
>   	s64 reserve[8];
>   };
>   
> +/* Tag magic */
> +#define ATAGS_CORE_MAGIC	0x54410001
> +#define ATAGS_DDR_MEM_MAGIC	0x54410052
> +
> +/* Tag size and offset */
> +#define ATAGS_SIZE		SZ_8K
> +#define ATAGS_OFFSET		(SZ_2M - ATAGS_SIZE)
> +#define ATAGS_PHYS_BASE		(CFG_SYS_SDRAM_BASE + ATAGS_OFFSET)
> +
> +/* ATAGS memory structure. */
> +struct tag_ddr_mem {
> +	u32 count;
> +	u32 version;
> +	u64 bank[20];
> +	u32 flags;
> +	u32 data[2];
> +	u32 hash;
> +} __packed;
> +
> +/**
> + * rockchip_dram_init_banksize() - Get RAM banks from Rockchip TPL
> + *
> + * Iterate through the defined ATAGS memory location to first find a
> + * valid core header, then find a valid ddr_info header. Sanity check
> + * the number of banks found. Then, iterate through the data to add
> + * each individual memory bank. Perform fixups on memory banks that
> + * overlap with a reserved space. If an error condition is received,
> + * it is expected that memory bank setup will fall back on existing
> + * logic. If ROCKCHIP_EXTERNAL_TPL is false then immediately return,
> + * and if neither ROCKCHIP_RK3588 or ROCKCHIP_RK3568 is enabled
> + * immediately return.
> + *
> + * Return number of banks found on success or negative on error.
> + */
> +__weak int rockchip_dram_init_banksize(void)
> +{
> +	struct tag_ddr_mem *ddr_info;
> +	size_t val;
> +	size_t addr = ATAGS_PHYS_BASE;

I think this should be phys_addr_t instead of size_t?

size_t is an unsigned long on aarch64 and phys_addr_t is an unsigned 
long long so 4B vs 8B.

This however would likely prevent us from reusing this code on aarch32 
machines, but maybe it's a problem for the people who'll look into 
supporting this :) (also, aarch32 and >= 3.75GiB may be a bit optimistic 
:) ).

> +	int i;
> +

u8 is plenty enough here :)

> +	if (!IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL))
> +		return 0;
> +	if (!IS_ENABLED(CONFIG_ROCKCHIP_RK3588) &&
> +	    !IS_ENABLED(CONFIG_ROCKCHIP_RK3568))
> +		return 0;
> +
> +	if (!IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL))
> +		return -EPERM;
> +

I think testing once is enough :)

Also, you probably want to use -ENOTSUPP instead?

> +	while (addr < (ATAGS_PHYS_BASE + ATAGS_SIZE)) {
> +		val = readl(addr);
> +		if (val == ATAGS_CORE_MAGIC)

Save a variable by not saving the result of readl and just check against 
ATAGS_CORE_MAGIC.

> +			break;
> +		addr += 4;

This is an incorrect step size, addr is 4B, so this will result in 16B 
increments, which may be too much. Additionally, we shouldn't read every 
4B as the tag is only ever guaranteed to be 4B aligned, not that we 
would have a tag every 4B. This also means that it's possible somehow 
the content of a tag at a 4B-aligned offset has the CORE_MAGIC for some 
reason, but we shouldn't match on it.

I recommend to follow what Rockchip does downstream:

"""
struct tag_header {
     u32 size; /* size in units of 4B */
     u32 magic;
};
"""

if magic != CORE_MAGIC, then we should increment addr by size * 4B and 
check again.

> +	}
> +	if (addr >= (ATAGS_PHYS_BASE + ATAGS_SIZE))
> +		return -ENODATA;

I think it'd be nice to have debug messages here and there :)

> +
> +	while (addr < (ATAGS_PHYS_BASE + ATAGS_SIZE)) {
> +		val = readl(addr);
> +		if (val == ATAGS_DDR_MEM_MAGIC)
> +			break;
> +		addr += 4;

Same remarks here.

> +	}
> +	if (addr >= (ATAGS_PHYS_BASE + ATAGS_SIZE))
> +		return -ENODATA;
> +
> +	ddr_info = (void *)addr + 4;

It seems that arithmetic operations on void pointers is illegal in the C 
standard. This also quite obfuscate what you want to do here.

Considering that in this patch you're iterating for each 4B until you 
get the MAGIC, the next 4B are data for that header of that magic.

If you go for the tag_header I suggested above, I would recommend to do 
the following instead:

"""
ddr_info = (u8*)addr + sizeof(addr);
"""

This is a bit more explicit wrt to what's expected, we want to have the 
address of the data right after the tag_header we point to currently. 
(and in-code comments also do not hurt :) ).


> +	if (!ddr_info->count || ddr_info->count > CONFIG_NR_DRAM_BANKS)
> +		return -ENODATA;
> +
> +	for (i = 0; i < (ddr_info->count); i++) {
> +		size_t start_addr = ddr_info->bank[i];

This should be phys_addr_t since it represents an address in physical 
memory?

> +		size_t size = ddr_info->bank[(i + ddr_info->count)];
> +		size_t tmp;
> +

Please add a comment here to explain everything about those first 2M :) 
(reserved for TF-A but sometimes the ATAGS don't have it reserved)

> +		if (start_addr < SZ_2M) {
> +			tmp = SZ_2M - start_addr;
> +			start_addr = SZ_2M;
> +			size = size - tmp;
> +		}
> +

Same here, a small comment to explain the check below would be nice.

> +		if (start_addr >= SDRAM_MAX_SIZE && start_addr < SZ_4G)
> +			start_addr = SZ_4G;
> +

Why are we not changing the size here as well?

Same here, a small comment to explain the check below would be nice.

> +		tmp = start_addr + size;
> +		if (tmp > SDRAM_MAX_SIZE && tmp < SZ_4G)
> +			size = SDRAM_MAX_SIZE - start_addr;
> + > +		gd->bd->bi_dram[i].start = start_addr;
> +		gd->bd->bi_dram[i].size = size;
> +	}
> +
> +	return i;
> +}
> +

Cheers,
Quentin
