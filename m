Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AB9CD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 07:45:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFD41839A8;
	Wed,  3 Jun 2026 09:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Ebi5sxnN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB60483EF9; Wed,  3 Jun 2026 09:45:39 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 909B88341A
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 09:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Md3+tc/cFE/7FGOPnRgKc0W0n/96WC7eeUI1YBgAZg7byU1+2g1o3YXCylhfbBWM0zL9snmmACVpbn6Q/1HXGviPc2jeE4jX53stGXeob45Xu726RAU8hamRxeAsSd63cSQSxi4u0qd3QpS5Ujc25ve2N0DoRGPw/C8IG9YI2eFab0Tqu6tCMhKAzI7eTCLJzXaSUtDeQvnX2LMql0xaYE197KHbpJlvjMgYZnxShxz5YMY6kHCRrOA3kvJtlEr5ADqXgWpYuucVUfu62IptitLg7c9ymw89vLz3aQXpsEMJAYAf9OVFSLUUi1I2k/L+jjOzbGrgDvmGXHtZYd5NeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8TAgoJXci4cufarIpQntFEegzk8HJL84uQoDYhZuoY=;
 b=bsFIdCjPBKQdIbaczv2DUnpK6BZcrScEb4pUltOX0Xn+CSu/YbXkJqQp9mAvv0++BYgj1EgExEHyQ4OOeHHcwD1/egTFY+1EJh9TF+exhHXzeKVKfa/0vdNhYVL+mE9ZtsnIyLTdrGWAe+zT9ZGdces7xnxcbNrdQOG5S5abwOPfSwQIxIrNorFTei7+ESB6ezyB2LW5j9wtQuYF403986i9gKkZ1s6MTUahQZL6e5HNDc0ZNrmHlDvzP3KzIY4/7CZ4//0kvkFPt++KSMpaMhYACLzi2DEjeTUa1CqIZ66j0qpyYOzYRikZcaxMHyLrBMSdbm0Wv1sUbMz9d0cOhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8TAgoJXci4cufarIpQntFEegzk8HJL84uQoDYhZuoY=;
 b=Ebi5sxnN0RkDDbnb858HDG/XV9TbcH3EpHcvVUW0sdUXsSG1whSYJ+rjvvYqz6p7PHUR6qx006H1HuH7rVUPVS/IgQMHbfGIw1qIXBt63IrX/N7agPpN5DFDJqnTboSuRxETdrV0bZlqNwdIc87ItYgxq0T1DjvFiTWZAdkWjtaqNHSLvPbNZP6Rut33tTWiEgHIdRsssg7zOVFfGO6wqr0JXTiL8sFzLy+7rsrSZYiQXIxOHP+iqWgPq4VkJZQOv+OCtd8V5zJAes1ttUKlXAAHlR0xtrOnenDnhSA3hvmHD0C4nCQU5kWr+AXNmx1jMmNISMcExGwu7B5iMP7nww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by DM4PR03MB6858.namprd03.prod.outlook.com (2603:10b6:8:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 07:45:33 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 07:45:33 +0000
Message-ID: <bb783124-f47c-4b9b-9619-9bf3da99fec9@altera.com>
Date: Wed, 3 Jun 2026 15:45:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] spl: s10: Enhance watchdog support in SPL for
 Stratix 10
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
 <20260518011245.19083-10-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260518011245.19083-10-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|DM4PR03MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fb337c-e7d5-4284-aae9-08dec14417d4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|55112099003|56012099006|6133799003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: HIHXokqFnAgFUpx0S3BonFjK26Mhc81aZsz5SHn8smp7pr5uUosuay0SH0aIImRz6rVvEweS7p1cJ7ERjJHA3SjKt0jQt1hhnD/YGrHerOpGLDjPyltm8yim496me6K+Pf74/wyFwN3Miv8mM3HRLteyM6qRp/vzoGuzfw+my4Gdt2MmuVvrOoJNO7qRTvHjTBZ8XtuxiCQjZ1Yxkr3YHwroNvqzb2rBFBvHlm5xnFmKKS9iutKDHlrR4wFUo3gxd9Ib9qcrOxKCMbzRoBtUAUyPSOdc1aT3BC9sQTjlGC586OAK5Duj16DCa3EcLPuUJU8MuXdt/A7Y+60kyU32M4TPr7Xb433dQo1+BagWkXfik8Jl0s1ZRU5B8nvi5iVn9eO8AgKnKw/s28i7oEBGYc3MgvZ/She94+o7evw83V9C6NVU06cIK/TychA8fJrKgJaY7lviiKq/Z68ZmvGHF0yWSz3nGidEE9WbDvFz2Iitd4xiTqEz+uT2gTh0PyOqcSmj7EgsD3J39Xw+sD7oVfGi7huOI4GTfrrZBMRdlKTUZoxmvnQQu21zbiD7YDtewXB3bXyA0gq+uzWYkcJuzEJBZQIp9QCNwHLLfKfntMHRSJutahQH4XNmOqpztnC6/l2iSQmmyWkO2zmagLhGL+XEdmzBcsLxVplFeIDYEMS2tvqLTPJ0UrnBFxOHdxJU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(55112099003)(56012099006)(6133799003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXdMeThsK2E0YXVsaDl1SFZuMVFOdktKc1ZlTFQzSlJ6M3ZDbGYrejNneTIv?=
 =?utf-8?B?blNnOUljSXJtQ0ovb0lFVzdySkNLT1k1b1QxUDdvQkxSRzNndUo5c1o3YWNv?=
 =?utf-8?B?dTAxWm5NNGZid1EzckF1WHFuRXM3NWZMSUlDV1pRZXNIbXdBKzlTQ1dGajlM?=
 =?utf-8?B?OGhDa3VGVW9kaHlaVkpMdjBydmsyam5PVzN0VUpoSWhjT1d6cTJ1R3VCalg2?=
 =?utf-8?B?OERXS3l1YmI2RCtuMlU3MHNyeGxUazJac3lSTHpCQnhhMnEwV0Y0OUlyYXFr?=
 =?utf-8?B?NHkvZXd4c2h6OXh2WURQZGh1TmhWaUg0SERpL0VQRldkdWd3VXlqRksybHdm?=
 =?utf-8?B?Yi8xYWdEM3JBa1NuajNpNUpmbURwd2cvY2IrZ1JJY1hLK05ndzdPbHI5UUlr?=
 =?utf-8?B?VllNWFBGazR4Sm9meS9na1hrTHFhenRkYVRmM1FCRWQxL0MxTzA0cjRMdis2?=
 =?utf-8?B?ZHo4eUVEd0hPTGJUMFFSUFQ3bloyaDlIVGFJdy9QZ2l4aFhYa2hlV1B1OEwx?=
 =?utf-8?B?TVRQNDVTVHl0VU9OZDBaaW1yRVRnRGszazB6UDFEa21oeXlWRWxrTWVGU08y?=
 =?utf-8?B?NVYvTjZZenZsekhlVk00KzhuaE1HZmc5Z2pGZ0JkZTVPK0psTi83ZjVEcHN2?=
 =?utf-8?B?dFJwdm9CRHZlMjFoODEra3ZiQW00bGd5b3J0V3hZdXlKcUcrN21ieGdBbFB2?=
 =?utf-8?B?MHErMFNYZWhxU2YwWTNhN2NLOXBSZGZWbVdHZnBqODFuZjRTZHBwcTBTcm5E?=
 =?utf-8?B?Zk5pQ0V5Qi9icHNEdm1Cek04NDBkcW5zS09xbjRYWTRCcGZSUGN5bmRpQWJS?=
 =?utf-8?B?K2ZpNXBLUVdaR2p5WXhRdkV4OE1LSXpVb29JL2pJNzcyVlZBNEVxUHJEcDkv?=
 =?utf-8?B?RFJ0MVFNUUtIWS90NDFHWTB2Z0k3WjRwNE9Pdk84NmZnUnA2NXVSQWRxYmNu?=
 =?utf-8?B?RWt5ZlE3TnZwUjdtcEJkdk9Wc0xJT0w0R29BaHNvY0RGWUhBWVZkSlBJRmho?=
 =?utf-8?B?K0V5REdaQ3hCN05teWNuM3hSUDE4K3lnOVpmS0JQQk1JRmw2Y0R0OU9ydkZF?=
 =?utf-8?B?eGFQTmhWbXp1RGxmL0ZVdHZpZ0FiYUwrVHJjMUN5ZlYxZEZSbzdoZEdlcWtD?=
 =?utf-8?B?V2hzeHVuSWJWZ1pYNDJHMGZHU3BhTzcySUFFQXdVa1ZYaTJraWd0VVc0MnpO?=
 =?utf-8?B?RGdaZzFLVmR1Z3hWc1NCbXNOSk03VHVoUEg0K1BqRVJFRTBXZmNoSFVoNWox?=
 =?utf-8?B?RUJjSW1Sa3Q4SXpkRjJrM3g2Q2lSeDNVMTVzT1A4ZWF2Y05sRGhqQitIeDhr?=
 =?utf-8?B?T0NqMnBGZXBzM0FKM1dlazFvWno1VzFXVHE3M3VieEtua2pudkk0ZFcxSjZk?=
 =?utf-8?B?SENsQkd1UjlFb2JlenBQbHFIL0wvemgrcElnWWNlcEU1UTBKZngwbTB0eEtR?=
 =?utf-8?B?N0NYMk9CSW8zSHFTWjlqQWFwSHFVdEUvVkZkWFNhK0M3WHF1aC8wOGNGWEZu?=
 =?utf-8?B?dzBUVmNGQVpmVFRzbDNlbUFyQXY1NDJibWdvZFJPcTdoczlmNjZOOWkvVWJo?=
 =?utf-8?B?TWwyNFlQMEV1MUMwVHdTcFRaV2poR29tZVA5enN2Z1JobU5nM0wyLzBUR29u?=
 =?utf-8?B?Y1daTGhDOVlPc0ZpOSthOEFidURJcnlQU2JEd01KbHZ2Y0o5MnBHbE12Y2Vy?=
 =?utf-8?B?d1dLSmMzdjZjckVsWWpaNlVyTmNpMC8wR3ZwTmtTbW9LRnJ4UlNQVWhydDNZ?=
 =?utf-8?B?MDV0ZEFheTBGKzgzdmJrdXVUaGJYNVBia2NueWRBV2s3TTlPdDlpM2dqTXcv?=
 =?utf-8?B?OGw4OVpjWlNPTy9OQTZobEhQeUFQc2crbGlLQVd4cE9DR25qT1kvaGtkSFQ5?=
 =?utf-8?B?dGZBVEM3L3pZU2lUSmgrSmVYUlV5TFF1K3p5ZENHaUpMaXVueW1mL2tvUDYv?=
 =?utf-8?B?SUVkejZQOHRFRkZoMlhNZUhsV2lyOXFWcmUvT3FrQkkxdDI1TWc2c051dE9D?=
 =?utf-8?B?Q1ZuRjB1azRuL2lJNXZDeWY0QUN6Z2t1SHhWbTdCQi8vckdid1RMUSszOXor?=
 =?utf-8?B?YUwyZ2pmZ201eVpCSXRKLzJOYXpjTHhFWmJlRFdBTFM3am55VDNPcnFyZlB1?=
 =?utf-8?B?N2w3MTJzbUlqTEJvTFV4dTFIa0o0UXFEQXpxYk44bXNYV2hud1hERy84d1Ey?=
 =?utf-8?B?bW9McjI5U0FGSk0vL0x3VXdaVGhGbWk3anZlUzYxWXNyV2Ixd0RZdlAzSHJB?=
 =?utf-8?B?MjZsRTRvRWxUUkMrNk0zVnc3Mlp6Q3dudnhoU0xMNER2a2c3NXIyMHBLT01t?=
 =?utf-8?B?ekpwUzNsdFhyOXJXdTBXVG9mS1BEYnRKY0NaL0Y0NjFpalBRTGpQVTFDNmVl?=
 =?utf-8?Q?BRqZpz5EEewzSh/g=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fb337c-e7d5-4284-aae9-08dec14417d4
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:45:33.6673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VxDuykOe3uGqFZyGBwVQFhpsPhd5qkuHxEKtj4ifCIP9ElU87fma+/FAY+u5KEgcFZdyeN2C2DVrbkcAbIsVr7NKPVnoW808lkLJobmqbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6858
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

Hi Alif,


On 18/5/2026 9:12 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Watchdog should be primed before longer, failure-prone steps such as
> firewall, SDRAM or QSPI initialization so that if a hang occurs in one of
> those steps, it is able to trigger a reset.
>
> Switch from the legacy hw_watchdog_init() path to the driver-model WDT
> (initr_watchdog()). This requires clocks and reset to be valid for
> the L4 watchdog block, and so it must run after the clock manager
> (uclass_get_device(UCLASS_CLK)) succeeds.
>
> Enabling watchdog immediately after clock init keeps watchdog coverage as
> early as possible.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Commit message improvement
>
>   arch/arm/mach-socfpga/spl_s10.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
> index ace029557f3..588dca4fcd3 100644
> --- a/arch/arm/mach-socfpga/spl_s10.c
> +++ b/arch/arm/mach-socfpga/spl_s10.c
> @@ -18,7 +18,7 @@
>   #include <asm/arch/misc.h>
>   #include <asm/arch/reset_manager.h>
>   #include <asm/arch/system_manager.h>
> -#include <watchdog.h>
> +#include <wdt.h>
>   #include <dm/uclass.h>
>   
>   u32 reset_flag(void)
> @@ -54,13 +54,6 @@ void board_init_f(ulong dummy)
>   	writel(SYSMGR_WDDBG_PAUSE_ALL_CPU,
>   	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_WDDBG);
>   
> -#ifdef CONFIG_HW_WATCHDOG
> -	/* Enable watchdog before initializing the HW */
> -	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
> -	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
> -	hw_watchdog_init();
> -#endif
> -
>   	/* ensure all processors are not released prior Linux boot */
>   	writeq(0, CPU_RELEASE_ADDR);
>   
> @@ -80,6 +73,13 @@ void board_init_f(ulong dummy)
>   		hang();
>   	}
>   
> +	/*
> +	 * Enable watchdog as early as possible before initializing other
> +	 * component.
> +	 */
> +	if (CONFIG_IS_ENABLED(WDT))
> +		initr_watchdog();
> +
>   #ifdef CONFIG_DEBUG_UART
>   	socfpga_per_reset(SOCFPGA_RESET(UART0), 0);
>   	debug_uart_init();


DM WDT needs clock/reset; ordering after uclass_get_device(UCLASS_CLK) 
matches spl_agilex.c and commit message rationale.


Best regards,

Tien Fong

