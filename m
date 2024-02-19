Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FC8C48260
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 09:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7A0C87DDE;
	Mon, 19 Feb 2024 10:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Bvs6Lo3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0227A87E80; Mon, 19 Feb 2024 10:13:42 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1b::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9948487DB7
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 10:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVvGkceyn+gFwHezPPcvGRim6QGFZq2FxunJsJW4GjrtTLAA7VrdscXlOCxcrwKJULdes9SqdsjAUzB0bbeh5P4Srlfz4z303ftiNKjdBZG5YVaHGPTi5LxeFFJbZeFt3yupAJHjwUmeFL15yc8zIb05hgnVgaSpzakgT9DFt9a1V5rFTd7PCE0om0Jko+jrV3My3L6PpK8myiWLv9SjWZFlBX1kxC9btkaSttMVl32Kh9OaQv5UsL0Ll2sCx2ieYPDJhzkhuPZR9VjPpzmV0mTCQ6hIC5DBqZ5wlFApn6kXA7r48YGOOARzwwa3WHQQ8lsCPtSLpaluree04Mg9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Le+6zzpM2t7WYPuAngaxUa6oNXGwBow8/BfwPPmdA/w=;
 b=Bb3NmqCREYHWRA9tOkHfUpo/rB/Y1Kzpi7eRWSvbke2boUBE9zKwdBYoz9L1PMp7KWE3EYwkurB+Ecdd/hE98C0SH/fUInrB+S5VAhl5ltuMDxmZ/8zWazoCCgnOs4GxENCNVfrRD6X3xrG6kUzNRK4MBunvuKb6RPAEAAEanpDWMQArX8e8vmpRfm4uT8V7/R5HFW2w2G7rn8Lrn80+bD1zD7IrpvAKOVQDy/ZRovW/428/m+X8GNPaqCqlFiAvu1rHE98KEzr7icSnNAtT6ArLIZgAuqYa02fn1n1GcPjOKsn357fPFcM5w+gsj9HM+g4cg75c/bVt2qOx6o+sXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Le+6zzpM2t7WYPuAngaxUa6oNXGwBow8/BfwPPmdA/w=;
 b=Bvs6Lo3llYHD1BghQ4Gu3S0zT6Tni9kJu10HH7OzfS2a2kzFid+/oFXbGrLjRtqMGUGx9jXAZJXWw1g0yxEzR+uA2lkFnSK7oAGyt12swhLmnnhaapGxMlETErBRUk5ihxaa6PMYsYFiG5BdLLtJuJ5ybW7iC8pQ9LMuo1OvruUogRvHflrlSokOsxcmMmRq+X3j+xW1Tzio166jMxNC13iojgr0b4NbHQ1oepHiwfJi6FGfJAYYb/68GsMohAvvJvDrvA8TsVw3Uz32j4fXZcZLUBxlQhmGICYQbC+cJx/5JLbfwJJq5EKZHFxpM2s0D5fLzXYZ56tzNy3xx0B2ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DU2PR04MB8664.eurprd04.prod.outlook.com (2603:10a6:10:2df::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Mon, 19 Feb
 2024 09:13:28 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 09:13:27 +0000
Message-ID: <877adf49-acc1-4f94-a509-45e25cc49f86@theobroma-systems.com>
Date: Mon, 19 Feb 2024 10:13:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] board: rockchip: Add a common ROCK Pi 4 target
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>
Cc: u-boot@lists.denx.de
References: <20240217183610.2621132-1-jonas@kwiboo.se>
 <20240217183610.2621132-5-jonas@kwiboo.se>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240217183610.2621132-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::6) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DU2PR04MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: d02f06e0-e97c-4e6a-435f-08dc312b088c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8NgAO9lMZpX8liltz6f2ygPXx7AYuox2ntBs5bqgVjrRB3qBog3gIU3CjoESB7Ug+PlZk3EonHT9hvJQaoWPnuZkMpBVINJZ1sQZkhApeHBp8QtbFb/i/CKIMugOJ0KJkycFjzIUc5SXB6LxeIrnX2G6UhqyDsy9hXLQavZfa29JgDJecZ3TTr9a+pIngJx3pzMYpvRLMy29yNihIJ8H1pmt1ZBLP9j0mG5SpAaM7aXupM7kRlr8EJUZrORsgVZro6PGXaibEg0MK/1RjNmHnYWWrEFu2sEAS5emz+otnYXRaC9Efm3G+JJgvRpx8mGMC8z0v+YU1EOzREwpAH44fsa0RrhBmZ34yRihRs5yLx/17zij+QKhGf2nFkZAHtxXrkZv93dVSxfm9LQQM1pJHLsRYhctZAgHp35rzpx5P6HGwF2cVkyhAS0+x0sJG+3WtkCu+oDXngTeqU7f5KHZqPqGIZg8Vq8fHXT9vvkgHmQID467ApJLNrd1h2Tndx4an8wniOri49WKz1B/vDGC0Ft3SDCW21xkaY41RuSg7qNI1ZlydF1k/a9wValEr/S
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(136003)(366004)(396003)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2906002)(44832011)(31686004)(5660300002)(316002)(41300700001)(53546011)(66556008)(110136005)(86362001)(4326008)(38100700002)(478600001)(8676002)(31696002)(6506007)(8936002)(6486002)(6512007)(66476007)(66946007)(83380400001)(2616005)(26005)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dThUcG83YzErSWszcllIekNaYjR2UTErc0c0ZTQxRDhST0dqMGVDMFExOWI5?=
 =?utf-8?B?Q01aY3RBSzN4cEx2d2FwYTZVY0VhcGdoWm9sb2Y5L2Y5TlQvQ2RIUWExVjNY?=
 =?utf-8?B?ckE2Z0xaQi9MeUdSNWY0WEVxdk1rbGdtOXQ5cVNPN3YyMGZDTjhWcjZyTmY1?=
 =?utf-8?B?S1Jwdzl6RExHcEQ4eUk3U1hnN2NvQ1l6V2YyZEdMMEorMi9tcVNFUEthVm1o?=
 =?utf-8?B?TFo2RkRib2VCcVVlTUxZQURPeUVsTTh2K1VWenVpTWFRby9lMG1PTzJGOHha?=
 =?utf-8?B?K2N4OU1TMHMxNHFjZURmUTJEMWh0OHBQM0FSdEFSNFlweXltY2tqYlpqdWJn?=
 =?utf-8?B?T1E5RWxYWGRYb1R4VlQ3Rkt2YmNSK3ZMOWRDODRJYWJxYjA2Zyt5bkQ1RXU2?=
 =?utf-8?B?RUN1dzZyMTZKYVBQeVJPczNGMEgzNjFCK2VWT3pVUTBkeXZOSDBabFdub3NC?=
 =?utf-8?B?c2Q1SzB4ZmgzRE01aTc2VWNzK1lKQ1IzSHJwdXh0UHV5cTg4bm8zMThwRWFF?=
 =?utf-8?B?anpldnFhandCZTd2N1ZxV1lHU3pGb0VJMm56Nm9pWTFzcThuamE2eEwvVUcx?=
 =?utf-8?B?WndRbzJSMkVOczlpMlZuWHpkL2ZSM3JMYktwZE1vQnNOakV5UWlkdGNJN0s1?=
 =?utf-8?B?U2pHQmVJWkFEeGF6YUkxd1hUWmVwdkZpVFV4aGhTWkt5amk5NUhBc3FTUmJH?=
 =?utf-8?B?RGQ5SUh5dHpkL01EVm83SVV5UWpFRjFucERhdWF5b2gzWGZ5eDg5dHJ3dFp0?=
 =?utf-8?B?RGZ1TW5TWUxkMDB5em5KV3lLb1BUU0Uwdi9xNUhSNVp2OTR1ZzBGRnNBZGQ0?=
 =?utf-8?B?bjk5MlpCYlliUStQcU41MkJWWWNrRXk5TGFJaXlnQ2lpbk1wRmQzaHdYVzlG?=
 =?utf-8?B?MjdaWXkrUXoyS2phcEhoTHBoWmlYeHgyRjdncDVXVTZ1Y1dRUmhsMXp6dEVG?=
 =?utf-8?B?T1FITG9VK2RXZUVSMW5vV011THhjSDNpYUx5b3hWVVllSituV3BkYXRGOUlN?=
 =?utf-8?B?cXBnWENxSTVFL1AzYkhxdlgyUEJxdjMyc1RSWnFPcDA3Um1ZNnE1Nlg4cEFZ?=
 =?utf-8?B?S3ZOall6ZStXb1djRWtvSzNIOFFLTFRZTXVPT2FFeVFRSCtzOXovekM1V3V0?=
 =?utf-8?B?eXgwV1hlWUxDNlJ3YWRGcjBNSWt6NXVCaUpMc0lVeDNRQmhIWnc0dGZuT3d5?=
 =?utf-8?B?QzhrK3ExMlJDVUdyMURNYW5nbDJFVmpOSkF3OUJXRnlLeVQvSHVaU2VqcXhK?=
 =?utf-8?B?dmlid296a0RRb0c0d1ZOTGVSR3Yvanp4UFd2VFQ0amVMbmM3UzVKT2NIK1c4?=
 =?utf-8?B?QUZPKzdDcjh3V1o4a3QxOGdwUUo0MFVWQWdQWFk3NWdObFI1OVpCblJEQlJN?=
 =?utf-8?B?d2ZOb0c4QkJjSzA3OEppT2dGRW9XNksrSWpWVkdWdThIZGRISVMrQ0JnaGZw?=
 =?utf-8?B?WENGMWJ6NWI5UzNHVXFpWTZhZ0pMazZTa29aYVpSNXAwTTVCUzJhaTVjZ29J?=
 =?utf-8?B?dUJuQWVNRE5yZU9zYUtwKzFFM085cjJ3ZjZvbkNSNkdWQThXaGRuZHZOaGpy?=
 =?utf-8?B?Ri9LRFl2RnRlMXlmSk0vV1RiVnFFc3FzTndSa0hxWG1qdjlRQjFaL2piSStq?=
 =?utf-8?B?THVDeHZOSGhJZ1NPaUtGODYwYnBnaklvcVRTY2x4T2owQXhVak13c2E3WWFE?=
 =?utf-8?B?ZnpWTUQ5MjJtVHp5WElveWJVcG9WbHhSU2tYeklxZElkQXFwUjFYYTlLOHov?=
 =?utf-8?B?MEw5bUVRSlN2U0VhZ0lud0E4TFlNdVFMSDgzVjdheWtVMW83aDR0bnNNbDA1?=
 =?utf-8?B?Vm4zR1p6Y09jN3UxQTd0cXNycEc1dVhrYlc1STFKQVFEN1hKYVNFR0djZU5H?=
 =?utf-8?B?clhNZzJpcGxWb0xVUEtlVVBsVFpPY2V0WWNVR094dERvQ3RRQWRiYjRFK1ZB?=
 =?utf-8?B?ZktnR1g2Tk5wY0wrd0FwalJ1MVNjSkF6eCtobmR3ZzJhcjN0aysvOXlaMFF5?=
 =?utf-8?B?S0JWNk1pcG9mODdCSW9CUFB1RTdyWFEwNWxuU2c4b09aVkRKMVhqQ2M1eTY1?=
 =?utf-8?B?VVNpczdacTVXcXF0ZmJteWZKVjY1d09xNzJoVktUS2g4UmthdXNSRi9RYjcx?=
 =?utf-8?B?VU1rSllQKzF6bUIvMWlHbFB4L3JaR0pIYkMxU3FsY0NVRy93cjl0aU90Sjhh?=
 =?utf-8?Q?H6+3o7H1ZAjfCVdsxSUKkJM=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02f06e0-e97c-4e6a-435f-08dc312b088c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 09:13:27.8864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1pu2sMpugtPERne4CxtIP9NnvuQvJoYg6ALf95sa4oaEH9cegoK5eZ8BwsyFOcHk/4jPmAEOtwu0KpX4PUSXwR2VV6fLye4R0NYHIX4i+LfwPBcn29qdOx7Llnsp/0t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8664
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

Hi Jonas,

On 2/17/24 19:35, Jonas Karlman wrote:
> Move ROCK Pi 4 specific board code from the shared evb_rk3399 target
> into its own board target and update related defconfigs to use the new
> TARGET_ROCKPI4_RK3399 option.
> 
> Also move the call to gpt_capsule_update_setup() from the weak function
> rk_board_late_init() into the main board_late_init() function.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/mach-rockchip/board.c                | 10 +++---
>   arch/arm/mach-rockchip/rk3399/Kconfig         |  6 ++++
>   board/radxa/rockpi4-rk3399/Kconfig            | 15 +++++++++
>   board/radxa/rockpi4-rk3399/MAINTAINERS        | 29 +++++++++++++++++
>   .../rockpi4-rk3399}/Makefile                  |  2 +-
>   .../rockpi4-rk3399/rockpi4-rk3399.c}          | 13 ++------
>   board/rockchip/evb_rk3399/MAINTAINERS         | 29 -----------------
>   configs/rock-4c-plus-rk3399_defconfig         |  2 +-
>   configs/rock-4se-rk3399_defconfig             |  2 +-
>   configs/rock-pi-4-rk3399_defconfig            |  2 +-
>   configs/rock-pi-4c-rk3399_defconfig           |  2 +-
>   include/configs/rk3399_common.h               | 16 ----------
>   include/configs/rockpi4-rk3399.h              | 32 +++++++++++++++++++
>   13 files changed, 95 insertions(+), 65 deletions(-)
>   create mode 100644 board/radxa/rockpi4-rk3399/Kconfig
>   create mode 100644 board/radxa/rockpi4-rk3399/MAINTAINERS
>   rename board/{rockchip/evb_rk3399 => radxa/rockpi4-rk3399}/Makefile (79%)
>   rename board/{rockchip/evb_rk3399/evb-rk3399.c => radxa/rockpi4-rk3399/rockpi4-rk3399.c} (79%)
>   create mode 100644 include/configs/rockpi4-rk3399.h
> 
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index 4f666aee706f..dea5805c4665 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -34,7 +34,7 @@
>   #include <asm/arch-rockchip/periph.h>
>   #include <power/regulator.h>
>   
> -#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
>   
>   #define DFU_ALT_BUF_LEN			SZ_1K
>   
> @@ -185,10 +185,6 @@ static void gpt_capsule_update_setup(void)
>   
>   __weak int rk_board_late_init(void)
>   {
> -#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
> -	gpt_capsule_update_setup();
> -#endif
> -
>   	return 0;
>   }
>   
> @@ -196,6 +192,10 @@ int board_late_init(void)
>   {
>   	setup_boot_mode();
>   
> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
> +	gpt_capsule_update_setup();
> +#endif
> +
>   	return rk_board_late_init();
>   }
>   
> diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
> index d01063ac98b6..bf3600aee2ad 100644
> --- a/arch/arm/mach-rockchip/rk3399/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3399/Kconfig
> @@ -89,6 +89,11 @@ config TARGET_ROCK960_RK3399
>   	   * 2x USB 3.0 type A, 2x USB 2.0 type A (host mode only),
>   	     1x USB 3.0 type C OTG
>   
> +config TARGET_ROCKPI4_RK3399
> +	bool "Radxa ROCK Pi 4 board"
> +	help
> +	  Support for ROCK Pi 4 board family by Radxa.
> +
>   config TARGET_ROCKPRO64_RK3399
>   	bool "Pine64 Rockpro64 board"
>   	help
> @@ -174,6 +179,7 @@ source "board/google/gru/Kconfig"
>   source "board/pine64/pinebook-pro-rk3399/Kconfig"
>   source "board/pine64/pinephone-pro-rk3399/Kconfig"
>   source "board/pine64/rockpro64_rk3399/Kconfig"
> +source "board/radxa/rockpi4-rk3399/Kconfig"
>   source "board/rockchip/evb_rk3399/Kconfig"
>   source "board/theobroma-systems/puma_rk3399/Kconfig"
>   source "board/vamrs/rock960_rk3399/Kconfig"
> diff --git a/board/radxa/rockpi4-rk3399/Kconfig b/board/radxa/rockpi4-rk3399/Kconfig
> new file mode 100644
> index 000000000000..d82663506b12
> --- /dev/null
> +++ b/board/radxa/rockpi4-rk3399/Kconfig
> @@ -0,0 +1,15 @@
> +if TARGET_ROCKPI4_RK3399
> +
> +config SYS_BOARD
> +	default "rockpi4-rk3399"
> +
> +config SYS_VENDOR
> +	default "radxa"
> +
> +config SYS_CONFIG_NAME
> +	default "rockpi4-rk3399"
> +
> +config BOARD_SPECIFIC_OPTIONS # dummy
> +	def_bool y
> +
> +endif
> diff --git a/board/radxa/rockpi4-rk3399/MAINTAINERS b/board/radxa/rockpi4-rk3399/MAINTAINERS
> new file mode 100644
> index 000000000000..12d4f35af881
> --- /dev/null
> +++ b/board/radxa/rockpi4-rk3399/MAINTAINERS
> @@ -0,0 +1,29 @@
> +ROCK-PI-4
> +M:	Jagan Teki <jagan@amarulasolutions.com>
> +R:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	board/radxa/rockpi4-rk3399/
> +F:	configs/rock-pi-4-rk3399_defconfig
> +F:	arch/arm/dts/rk3399-rock-pi-4.dtsi
> +F:	arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> +F:	arch/arm/dts/rk3399-rock-pi-4a.dts
> +F:	arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
> +F:	configs/rock-pi-4c-rk3399_defconfig
> +F:	arch/arm/dts/rk3399-rock-pi-4c.dts
> +F:	arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi
> +

Probably for a different patch but I think this would benefit from using 
a glob?

+F:	arch/arm/dts/rk3399-rock-pi-4*

Cheers,
Quentin
