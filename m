Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7508BCD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 15:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6944384915;
	Wed,  6 May 2026 17:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FgRiJANw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1435684951; Wed,  6 May 2026 17:14:51 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B268490D
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyGUuzdTkC6I7LxULooyw8ndocNqs8OITArIzhq5UCNqChXVMTCovNp5iOZbNcqyCjB+Slb7HXGs1v/2yDEhVziWz+SZapg8TXhEHlONNCTyJtd0r0nCFqrv4dMq+W4yNECFYN8vbA0e1MxkUziU8+kJIbJ8cweUwrUs/C+kwKOjHt09ClyZ2i27KjvQteN8yxJX94UiKoeD10SSm5rcFPWycT4+FjYEgFKg2IaHHFRy5TvMO82lEjrjTgXdCSSEBbYhyjXnfEEEF2i50GvGh/z6A+N1yvuUmLyk2Bn09pClux+3TJyzqd+XZ9O98rrixakHbqWFRFLZhJaEiVoFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixwabaoKOfyDVWqZh6lRO4Lj96tiDGGP6rqGos5yEAM=;
 b=fuhEUzYvUXikn6tqThDGz0PolBaNM8xSsdor/IConmSD/c+wznZNiyk4IbE9nx6mRuO+9lWt2wjfQk5VhX8G1CYOQ7ngSPrqNhDL3r89bSaf/b806bALSQS5Ngsw846GCRd0o2yIPpY8aoFyIOjOAcmglxli2oxW44W+TUzm2Jwie4Qz/+47+NudylU7WuWO2KK9C9PnyHy5YTWxywrEQ2fCFxE+0uF/oPkzY328Y4I54chOFYvvFByO8PLNAHEA2XewGqgS8ctngjqQurbqJuPYrW1RjvoEROiS2rGunTLd8SB4j9AFtT4/iykAqD8MMqwFzfrFQmdvk/2fubt4kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixwabaoKOfyDVWqZh6lRO4Lj96tiDGGP6rqGos5yEAM=;
 b=FgRiJANwbcJpP1Wyh8IYE1bHY1t2+B4X0a3zDowTuw1AInda+MK5f1yEJknfZM5+uGjYbeiTuQeD952cB33XYf0/BUXqxzyPfyJ8b+PG1/De+4/eHCj6GtBxbD5ecu66jUSbIAoqxpzju/NnpvvfHN7dphtZ6qiBLrsmK2geGlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AM8PR04MB7732.eurprd04.prod.outlook.com (2603:10a6:20b:237::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 15:14:45 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 15:14:45 +0000
Message-ID: <977aa4b0-ead7-4df9-9ce3-8626c3b0f845@cherry.de>
Date: Wed, 6 May 2026 17:14:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] board: rockchip: add Anbernic RG-DS
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
References: <20260427175553.21426-1-macroalpha82@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260427175553.21426-1-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF0000020F.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8cf) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AM8PR04MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f5542d-2461-4c9b-8fc8-08deab82347d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 6LBd1BVVc0tZwf6SyZOOrRvafyE4J1G2p0U3Sw7frSUJ+GAQh8vFJNdgpSCN68116oLxc/0kHF+1KgqNr3/HQki1sd+1j4aLly0b2pXX67bLX8tXDevu5mR/IWCuSfK1EBBslCAMAlmZ5tJO4kkWrsr3YCWQN4DozNtwJBZzwHRuEYXNvva8kFMKoHU98RtoM6px7QTspgDx2KnX8Iatv7YwvEtA/FfiN+RQq3xqjzdAweovLmmMsy2oN35SRrI1YhNQ1196x1gi5M5o/tVJOftDPhTJW6ebXoYMpgqZ+6HebzHyeHgiYAyxdZ7osyaHZiUZdvNbFJ+X/3tuSXXogPz4SUX86p1qcvPfuuVj2Fvwd6xnWmzc49VkoDyYgYDGes09CaV47sVLC9SN8DbK+5C8jefdcUmb9L7jr6gBSVHWRGH4yV/ZzMKq/Xs3NF9LRswbo6itd3yslIV1vrgqs9IyR3B7hGGz8Xs/78j4bb4/20y+URLXl2K+9WkJIvaVSPUfmesYmugyDWV5V6xS55ZDDIH3QqKaF7X2eyBTey//ZBXLC8tzV/n69e5J69gYev6gkdLNi/es2Nct0utgSACG55NbvSZLN2yBwLk5VKGyoJMPSmu3GLz7GsQLxlMdEN3bUUPBkB2uBJjV66iv0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0RoRUd2dXdWemFsMVkyY3JPNDdSYTQ4eThtS3cvaW1MMzgvQmtVUnZ0MXdQ?=
 =?utf-8?B?dElzZ2N0dDUxOUhRaXRQdzZEZlRNVEtaQW83NE85UFB3c2lKL0JUYTBDRS9h?=
 =?utf-8?B?SGtWUEVKY1Z0UU1XcW1zdnlBWDB3am1maUhIaitmNWN1TkdDNWRlR1lYWEp1?=
 =?utf-8?B?SjBFM2VJOXB2eDhnNDZRQmIySmQxNmNucGVjSHFLSWhvYTQxVkNsL2tYaW00?=
 =?utf-8?B?eWMzM0xGdndRbWt4b2hBWHJjZkZJTERLb2d6MWQyNHlZUzVOTjIreFVuMFVS?=
 =?utf-8?B?SEhqNE5ZVXByWmVXQXNZOC9sQ0VIeExkdUgvNlkxRXViWmFaZEhBWGZ6ai81?=
 =?utf-8?B?T25xWHU4UEg0eS9FNC9hZ2doVit1MmtqTldYMmJzdmRIZGMrRnoya0VOYTJM?=
 =?utf-8?B?dFpDWUpSTHlnNTJiaWNzT2p6N3hEdjNHNC9kY1ZzbkszYXVqSmJISDhRTXQ5?=
 =?utf-8?B?KzJoKzRMK3hzMURDbWJ5cUpOb05HOFNpbXlueGczd0Ixd09JcUUvemEvM3Ny?=
 =?utf-8?B?ZnE0aUw3SitJZTZmRGRhNVFLdnA1elVpQUF1bDZRL2pKSk90bzlnZ08vMnNa?=
 =?utf-8?B?UEtLakN4Y3pwR3ZHNW1ER1VDVFV0MkdqSmJsVWV2bjJRaUh5TXRLRHJtcnFk?=
 =?utf-8?B?UmdWSGxMQ1g4YTdqOVM0QnZ1eUpJQTI0Q1pXTmhPR0ROKzBKS2FveDVLbzEv?=
 =?utf-8?B?VXUyOXlRc1g1NUdTWGFBRExoeit3UGJFZW9nNUhmRjJVNnJyZmY2U25yUkU2?=
 =?utf-8?B?RU9rWTJ4L1IrTERsRHVZc00vZlhuT05MbE1uZ2I0RUlodzJiMnFvbSt0WUtW?=
 =?utf-8?B?V0Y3NlZMcnlQSzVHOU10dEtXeUZqbmM5ZWhxSXowQ2pEdzMyM3c1ZklacS8r?=
 =?utf-8?B?OFB2ejJ6WkRJWk9tbWZJRUtvekx1a05wZHNCTVBKdDRHZHZpSlRPRFJML1po?=
 =?utf-8?B?Rk1XM3VTdWxhcTQ0ZDU2dm5Cd0FsU3lHbFUrcGU2eW15SllxZzNCSU5qS0xi?=
 =?utf-8?B?NWVUcTd0eDJUYTVOcHdVeFVTNENEb3o3VTV2alpuTU5KcDlsSDdVRjBYSDFO?=
 =?utf-8?B?dkFwYVJTS2ZBa2syNWhORElRdkNzZGRBMjN5NjFBZkttSUR0R3U1RnE2Y3Ay?=
 =?utf-8?B?VkVvc0RPSWE2Yk8zdGEyODNqR25BTVFxZGcwRUw3MmRPZncxYjZYNjM0NkZa?=
 =?utf-8?B?MlNtNlJwRlNpeFMwRzd6dzNIdjVlRXVvMkNMT0E0RnJ1eFE4ZU1NSUt2SlhZ?=
 =?utf-8?B?VTVtcTFIZmdXMzBXNHB1SXVUd25ZZzFjd2Q5Q1o2YlZHUDNUZ2F5TEJkelNH?=
 =?utf-8?B?c0gxNzlFNVNkS1pjOHd6Mldpd0FmbFg4WGZpUWhKVFNTejZOWWVzeWt1UlNq?=
 =?utf-8?B?ck10dFV2bmhXbEVwNkZVSk5LaUYrelJqRldlTE9tNlU5dnAxbnMxYkpCMkVB?=
 =?utf-8?B?Vys2cVZhS1Jsd25HWmYvcHNzQ0orZHlSNFVOQzJidUMxc3QweHB6MHF3a2dX?=
 =?utf-8?B?WkN2ZFdwdWdIN0dxUXpkN2wrcnEyd0NCdWRES1FQMVBQR3EwUDlUNGtyZUdU?=
 =?utf-8?B?M0ZhSDdpMXllVjVHRnhQMzcvMllxbFFSanFEdExMaG5yT1FrRVR6NTFpa1Ja?=
 =?utf-8?B?bjlYVFJyVFQ5SU1zQ25UNDlmSFJsMmI2QmdCNm5GS0p4OFlnWEpCUStTaVYw?=
 =?utf-8?B?OURtYWo3blhRaERLRk1hR09QTG5YcWVjTmFudzFTVFhoTEdwb3BuV0hSTy8w?=
 =?utf-8?B?Qlg2a3BXZ0Q3aGpGRTdSTjlYN3huNXBVQVFxSXBxdFhIWnpZS0djM3pWTUl2?=
 =?utf-8?B?YWsxQzN2cG93dVFZZXV4VGxwZ25sa2tvWFhPTTh0V1hybUJsNVloUitPSVVL?=
 =?utf-8?B?bjFiTXpWUXZ1WWt6czQySjFKYVFXYVF4N0piaXRVQXpyTG1FVkRvU1Avbk9Y?=
 =?utf-8?B?c01zT05UekVTcGs0NWZLQjF6S2hibmEyY0lwMWZ2UUcybXZmam1JOVIyV0FK?=
 =?utf-8?B?UnhsK0ZmMkNIekxaQ2JLV3BrYkdod0pBSXhxVlJkVFlFQWJqLys3bVhTMlZG?=
 =?utf-8?B?YXFqTEMyZ09wb2FXZkVucU4rZjcySCtxM3JRR3hnUHFrRW8yRXNkY1ZOSEhJ?=
 =?utf-8?B?dHRQeUw5ZkFaeXlkL002VDZuZ3d3ajkxTlphR0tiZGs5Z21Ba3RkMThFckk4?=
 =?utf-8?B?WTEvRHJBeFJqbG8rZU9tUk1xQTNvTis3dUNOMUtmV0dVV3cyZWRndUVDYlVC?=
 =?utf-8?B?eXMyWk1zOEN4TEZndzlJeTRNU0cyNGtxd3F1Wjd4WlpWUklRMWhuU0llbllv?=
 =?utf-8?B?b2s5MHVKTkYxT1BldU1BWDlvSGVjTFZNcmxqZGFFNlJsMHJZeFh0UTJURWhl?=
 =?utf-8?Q?itzXphM5J3xRhJMq/kc6OQVK4uyzY4f8/i7TqVsUSBvuY?=
X-MS-Exchange-AntiSpam-MessageData-1: o3B9ZpmJFXdmwhZCG4zwToz9VYjt52l0cXs=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f5542d-2461-4c9b-8fc8-08deab82347d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:14:44.9358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sbv6DiXNngWI7tgHB+v9bsQJOTOM+k3Q/yOc7yHH8JtgdJORVGMPOKtghxk7HMjHtTOgT1+P4XDqV0BKsgtzNiVFtFhbmtvBflRHNs+DkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7732
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

On 4/27/26 7:55 PM, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the Anbernic RG-DS dual-screen handheld gaming device.
> 

Can you please augment the commit log to specify why we need to list 
clock-names in CONFIG_OF_SPL_REMOVE_PROPS? It's quite important as it's 
not meant to be an oversight! Verbatim what you said in v1 as an answer 
to my question is perfectly fine :)

I'm a bit puzzled as to why removing clock-names (I'm assumign the one 
in &rk817) helps. Isn't clocks property still here? Don't have time to 
investigate today though.

> Link: https://anbernic.com/products/rgds
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
> Changes since V1:
>   - Added entry to doc/board/rockchip/rockchip.rst.
>   - Removed &sdhci and added &vccio_sd to u-boot device tree.
>   - Added rk3568 to board path.
>   - Corrected defconfig and include files in MAINTAINERS.
>   - Removed CONFIG_EFI_LOADER, CONFIG_LEGACY_IMAGE_FORMAT, and
>     CONFIG_DISABLE_CONSOLE from defconfig.
> ---
>   .../arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi | 41 +++++++++++
>   arch/arm/mach-rockchip/rk3568/Kconfig         |  7 ++
>   board/anbernic/rg-ds_rk3568/Kconfig           | 12 +++
>   board/anbernic/rg-ds_rk3568/MAINTAINERS       |  7 ++
>   configs/anbernic-rg-ds-rk3568_defconfig       | 73 +++++++++++++++++++
>   doc/board/rockchip/rockchip.rst               |  1 +
>   include/configs/anbernic-rg-ds-rk3568.h       | 12 +++
>   7 files changed, 153 insertions(+)
>   create mode 100644 arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
>   create mode 100644 board/anbernic/rg-ds_rk3568/Kconfig
>   create mode 100644 board/anbernic/rg-ds_rk3568/MAINTAINERS
>   create mode 100644 configs/anbernic-rg-ds-rk3568_defconfig
>   create mode 100644 include/configs/anbernic-rg-ds-rk3568.h
> 
> diff --git a/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi b/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> new file mode 100644
> index 00000000000..00d57104775
> --- /dev/null
> +++ b/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "rk356x-u-boot.dtsi"

We know it's based on rk3568, so include rk3568-u-boot.dtsi instead. 
Considering all other boards are including this, I guess it's fine for 
now and a follow-up patch to change them all would be ok.

[...]

> diff --git a/configs/anbernic-rg-ds-rk3568_defconfig b/configs/anbernic-rg-ds-rk3568_defconfig
> new file mode 100644
> index 00000000000..34528b22420
> --- /dev/null
> +++ b/configs/anbernic-rg-ds-rk3568_defconfig
> @@ -0,0 +1,73 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-anbernic-rg-ds"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_ANBERNIC_RG_DS_RK3568=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_OF_STDOUT_VIA_ALIAS=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-anbernic-rg-ds.dtb"
> +# CONFIG_CONSOLE_MUX is not set
> +CONFIG_BOARD_TYPES=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_BOARD_RNG_SEED=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_POWER=y
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_PWM=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MMC=y
> +# CONFIG_CMD_SETEXPR is not set
> +# CONFIG_CMD_CLS is not set
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_LIST="rockchip/rk3568-anbernic-rg-ds"
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> +CONFIG_NO_NET=y

Please disable NET instead of enabling NO_NET, I would like all users of 
NO_NET to eventually stop using it so we can get rid of it (or make it a 
transitional Kconfig symbol once our kbuild supports it).

Looks good to me otherwise!

Cheers,
Quentin
