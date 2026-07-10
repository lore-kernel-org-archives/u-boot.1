Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A38C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 09:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0119D849D2;
	Fri, 10 Jul 2026 11:46:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Uooc5OOf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58DF18498B; Fri, 10 Jul 2026 11:46:36 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BE098496E
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHTDyZy0tXbkIUQQKhNM/qQY3jRSLXNKQ0QeTDvAQLJotyA8P8ul3e+dftRXDp99UOXG7Vzu07UuhszLkPIvveqLZywLPue8uJFixVBo/bHbuUuQ9Nvat8qsEewFX2t+sXoASMhkHr0rQBgv7/+/iNNSVOISCqEy0bhJo08kAu75uKHvNva0b2FdByCGbmsulGg9R7KTowCNFLNteYlzlaEDOUQvLJSxdPBriVpD6v89OR96ZAmIweA2ZESEN7fpuNaf6eRL9RNPQklK6SBdjpJ5ApcnvfWU9RTGUYn2fccr3xsErrkBKEMh5nZ+UulEHdJcaQEpKLXCyjiPrxEbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1L1TkH5CYmrCcJDDUkFQrIZJ+FO9xD+2JviKqm19L5U=;
 b=phdBbmwsriNdx6RX0X4zjqa6lFs0e7lyFKilUbKzR8ydQl5kU/bRrrzAviLioucgDEi6fYSijJfqJdZcf0FLYJqN+JeA+veGN48H8jnmWpg0NOej+OmE/zEMf3T1qvzYXz19lAcuxUrLIjTD4o+FIgQaLC4qjXYwYNmNHeLPVHsXosaMXwPUvu8xrZNz9ZNbppzMAGh11mkb/6f2tNji+/x9tQM/8JNb13yMf/VBhNNmmrsxUocAqXfbPubbD977KbYJSdSlnaKxxTu2X2nc0dqR2Gxrst85RtaVFC8rpZZ8s1AySu2zUzANdodIuYGSY7lzg6Dnmu3xLpZLnW9tUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L1TkH5CYmrCcJDDUkFQrIZJ+FO9xD+2JviKqm19L5U=;
 b=Uooc5OOfuatK5uZpO752GTUNp+scwe1aYcuaA/cRx/4r7sgmxTq1Q7LwhHk7AqOpnAaBYfNpLcb3Lwdj2ldYp7Ax/VTk3aepOnwMIA30GfaA58U7l4XUa+rXxMTKMc+GB5v1hU9GJsY+oHmAbrZ4I4R8KoCdC6gMPg4qcWUk9ks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB7590.eurprd04.prod.outlook.com (2603:10a6:20b:23d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 09:46:28 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 09:46:27 +0000
Message-ID: <a4a0d7e5-f117-456c-a25f-2f05373c09da@cherry.de>
Date: Fri, 10 Jul 2026 11:46:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: Add support for Radxa E52C
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, jonas@kwiboo.se, heiko@sntech.de,
 christopher.obbard@linaro.org, cnsztl@gmail.com, xuhui.lin@rock-chips.com
References: <20260110011505.36915-1-naoki@radxa.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260110011505.36915-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2PEPF000008AB.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::645) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e407f4-a6c6-481c-60fc-08dede681cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5XZUG5u1WTM29HHGs9GuC9K0F7KARd50qKmUFetTEjWGGSNiu+76pwNNSuutXwWrh3/tDMLMPajxI4OknhP/At+n+uvzOzndE4QKKEhl6kvTlPV6sDFgs3vzxpzlbGuUA/n/9qcFl9Ds0d8UThfOn6NJFAzcUvrB59CozQPx3GY95M6tkcEhZTt2KVFxcO8oHxim6tgoUPiUlhSM7F8P6Z5QWpreVmj+UBtH/9eNsw4FFNzZinocvM1tm4Cm4I7n76arSEx+pmo6MDKf6gc7aGgkwa7hTtXMb6ET1aEWSHnLeQdsEa6FifXT6xu3bvpw+qJy/3LTIN6T7GEcwl6oheC2aYiGmFPH78PuZv7OZETqD6XlP6DCl4Frg7QPtt275YwiKWSEBJfLkxNDqbRnfQQl3rfWtynjrWJkeJq75DFhxuBKaTLDGbTJqtkon5y9B4N9JOA8VMf0whD4CSKx4OE9plgrlODVq56sJO51UW0Ik8zg9fMfda8mFPeFjbdaSzTz17sD6TiEZP8qzrGuSNUx2rK9PKc6UVGb/PyYud+t1dQEIu3saSm6K6jyqFu6kyrRqKexxZhPxozci0YF1mf+rXWkD3tp/1nHpIFFuj9xPYDMMHjJkFp2wohL69ig
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2tkRzhTNVVSZlJwSVBnZFFrd1NoM2EwWlJIeDVYUVQ3MjlsbUY2V25jR0hC?=
 =?utf-8?B?UlA0YzZLQXcwRXNKNGFFZ2laU1B6WldPZmN5NWVreno5ZnpuK2haM2wyUUNL?=
 =?utf-8?B?YW1nU0VLZTQ5NDhVL1hRNG1XK1RUM1Y4eUt1YmdLbmdsQWZKek9Oc2drenhD?=
 =?utf-8?B?ZXI2N0xOM2phZEdISHJJcXZIc28xR0YxeGNVRXFENkUxZHZuYlBLWnYwQXNt?=
 =?utf-8?B?M0NiZnJmR2ZMbDZlU3hxMUFpTkthNndtWHovWkZhcS9BQkNjRTJpM1VuQmla?=
 =?utf-8?B?c2NJTkdyQk1zM1Q3aFhQUmpZM3FYTUNCWUVJQWNFSHBsUEh2eFJBak9sUUZK?=
 =?utf-8?B?YkcwZlphTjJPSGZkYk9kQUo1NlVvVXoyOWtGZERtaWx4SHczckhwWEtGV090?=
 =?utf-8?B?VHFMY2pxRmUrSVJIYXRPR0dCTHhhczlFV2ptMVJTYklxT1NmclVKcEkxeDBk?=
 =?utf-8?B?bFY0VHZGOEJhVHBzOWN4NE9yc20wdC9YN1pvb3k5ZzdFRlh5aExNTUNJR1VC?=
 =?utf-8?B?MExBM3ZHQm1VOURRS1ZxMWlwYlp1S2t2Y2NRU1ZnZWFTN00vNDNtcFV2c0t0?=
 =?utf-8?B?dWhFck11bXJOVFRGNmNjVUV4NTFSZTNOQlB6RG16d0Z0dEthQlJlWTFCbjZR?=
 =?utf-8?B?VG93WGdDMmsza3BQUFUza1Zaczh0bUhvaWUxMjlSTi9pSk5UTm4wU2NUdWRV?=
 =?utf-8?B?WHIwa2ZUeHFxR05yd1l6RWxuc0RESld3WGpkT3BoRDlmNU1MMDJvaHBON0ZY?=
 =?utf-8?B?d1dGOVVRL2JKMVpRVGZxTnRZclFpTi9uMWg3RTcxQ040RFI2VXh4T2tLNDVm?=
 =?utf-8?B?ajdxUkVBeVNIYmxSWGFTMHRpU08yYWZ5RFBRZ1VOZ1duSlJJZXVGR1FCV1Jr?=
 =?utf-8?B?RlZuOTN4aTEzaFhGb0hpRzZJUW5GWllTbWs1ZCtaazJSZkFibU9QMEsyZUJI?=
 =?utf-8?B?VXRBdGtBU09sNW45MkFsMmF2VzJWTXVpUVFGNUtDem10by9iaGJlZ3RsbmtX?=
 =?utf-8?B?UEJleFNzbEx5OXVaazNTNnJTTElMWGlDb2RyRDdCRGtRMHNuTkRRMDlLVXhE?=
 =?utf-8?B?eFpVVmpESWN2WUE5Vjk1WklVc0szaS91VHMwTW93UnJ1K3RBc0pzOVhDd3NW?=
 =?utf-8?B?YUFJMWtNdEZSdk9XY1NVdS9FVUJsblVEbWI5VUlSVzBQTkdvbmRXT3lFRmh0?=
 =?utf-8?B?QXU2OTRkWlBsYnJHZjdncGxuT0xLZlJIamVqOTJ2R3BQYkVtakJXZkN5WjVs?=
 =?utf-8?B?VmltM1ZzbGpTYTdkdjg5S2NvRkZwRE1QakZBcy9tN2xndFNiUmJqcDNQcXk2?=
 =?utf-8?B?WWdIWDlTTi90d1V4cDhaYzlRaGZ2azR2K1RlQ1hiaTZiTkp3ZlFwcS9UWFN2?=
 =?utf-8?B?M2x5K2N6MitnY0JQVE5Md3pLMU15T3FRTVQ5L2IvRnVXYVRQWnFiam8wcC9Z?=
 =?utf-8?B?bXlnd29lY2IwbGtUWFhQTFlpb09Fc2l2cGdZaEtpVUxiZEU1NU1oMmI5QnBC?=
 =?utf-8?B?aFpjaFJMeXJwR2hDMVlSSEsydW9DYmlMOVZvazZDVnR3VkN6M2dsRnVIUzc3?=
 =?utf-8?B?TkdLVGV6Mk43bjBlTDBWZ2dLN3ZkdVE1dXJvTjkrbWRPRmM3UFNVcmtWeVNE?=
 =?utf-8?B?cTFGVENROHJkazhhZzVUY0l1ZGswUTlZdWl6TGtqNldBRU94Ykd5YmhoVURi?=
 =?utf-8?B?NmNtMVVZaEhVL0NhUzB2cHZVRGU5eDNZZmN6dlZjRkNEWU91ZHF0MURLamtk?=
 =?utf-8?B?bjVodTlHa3JwTTYrRHdDWm1Ld3E1OWpMQnEyb0FRNWJKZGlZWHlmSnNWMnhn?=
 =?utf-8?B?TkVrSk1OMGoyNm9NSkg4U05tTkJjanlOSndVMzNWb1V0OHdZb3lXeXlOVmRC?=
 =?utf-8?B?aURabTRKNkk1eU5kbTJlb0d3d1p5M2RBa3pjSjJpN04vNW9Od09pRXVESnpy?=
 =?utf-8?B?TTdaMC9lTVNMOHdxblZoRzFRZ0pJT3pWeDlSaHkyMFdldzc4NFZIR2FjdTY5?=
 =?utf-8?B?YS8yNHdNWHJZcmpydzJpOEtzQStSRUN0SUdzN2JncnZaZnErYWRRSmRlV1lJ?=
 =?utf-8?B?bjdXc2I2WU5wODFJd0NVcFp2U2xCazNYVk1aYnpPZk02cjJDZTdxdUFFZkJa?=
 =?utf-8?B?bjA2Q3JKQTR4Z3JvbkhhMWlCRGE1UFlxaXp3SGZhQnJDUk1SWVdrQ2NaNHkv?=
 =?utf-8?B?V0dIOGVoZmF6ZVpWYnJmYmZkL2o0bjFnRDArd0hOYjVtb0FmRnZnSU9BSVZJ?=
 =?utf-8?B?MlpsZnc1cjltc0thYTVRd250dTAvSkxaaENyQk42L29OVjhsOVlBM3BQZWda?=
 =?utf-8?B?c0wyL1hXVVRDZEUyUzdKR1pwS1A3WHFjcDRFK1dyVDQreWd4bjNMZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e407f4-a6c6-481c-60fc-08dede681cf7
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 09:46:27.8589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BuJijdHv2wbQeVUI+3PUHPFRAWgMibboFA7alEulsZE6ssCSRKtLMcltmwPjxt9wI4GCSumM7oHfYWh3ssHNPW4mrkonz6mYuZ6+nxiu3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7590
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

Hi Naoki,

Just to let you know that this patch will not be merged as-is due to 
review provided by Jonas. Please send a v2 with the feedback taken into 
account (or continue the discussion on this thread if you disagree with 
Jonas on his feedback) if you're still interested in adding support for 
the E52C, thanks!

On 1/10/26 2:15 AM, FUKAUMI Naoki wrote:
> The Radxa E52C is a compact network computer developed by Radxa, based
> on the Rockchip RK3582 SoC. [1]
> 
> Specification:
> - Dual Cortex-A76 and Quad Cortex-A55 cores
> - 5TOPS NPU
> - Up to 8GB LPDDR4x RAM
> - Up to 64GB eMMC
> - microSD card slot
> - USB 3.0 Type-A OTG port
> - USB Type-C debug port (USB-UART)
> - USB Type-C power port (5V)
> - 2x Gigabit Ethernet ports
> - Maskrom and User buttons
> - Aluminum alloy case
> 
> [1] https://dl.radxa.com/e/e52c/radxa_e52c_product_brief.pdf
> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
> This patch depends on
>   https://patchwork.ozlabs.org/project/uboot/patch/20260107230747.3552391-2-jonas@kwiboo.se/
> ---
>   arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi | 24 +++++++
>   configs/radxa-e52c-rk3582_defconfig        | 77 ++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst            |  1 +
>   3 files changed, 102 insertions(+)
>   create mode 100644 arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi
>   create mode 100644 configs/radxa-e52c-rk3582_defconfig
> 
> diff --git a/arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi b/arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi
> new file mode 100644
> index 00000000000..dd65cdd250f
> --- /dev/null
> +++ b/arch/arm/dts/rk3582-radxa-e52c-u-boot.dtsi
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2026 Radxa Computer (Shenzhen) Co., Ltd.
> + */
> +
> +#include "rk3588s-u-boot.dtsi"
> +
> +/ {
> +	leds-0 {
> +		led-1 {
> +			default-state = "on";
> +			gpios = <&gpio4 RK_PB2 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-2 {
> +			default-state = "on";
> +			gpios = <&gpio4 RK_PB4 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&sdhci {
> +	mmc-hs200-1_8v;
> +};
> diff --git a/configs/radxa-e52c-rk3582_defconfig b/configs/radxa-e52c-rk3582_defconfig
> new file mode 100644
> index 00000000000..5c1056867f2
> --- /dev/null
> +++ b/configs/radxa-e52c-rk3582_defconfig
> @@ -0,0 +1,77 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3582-radxa-e52c"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_EVB_RK3588=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_OF_SYSTEM_SETUP=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3582-radxa-e52c.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MISC=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_RNG=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +# CONFIG_ADC is not set
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHYLIB=y
> +CONFIG_RTL8169=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SPL_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_PSCI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 7a8532b49fc..2fd7d687d2e 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -160,6 +160,7 @@ List of mainline supported Rockchip boards:
>        - Khadas Edge2 (khadas-edge2-rk3588s)
>        - MNT Reform2 (mnt-reform2-rk3588)
>        - Pine64 QuartzPro64 (quartzpro64-rk3588)
> +     - Radxa E52C (radxa-e52c-rk3582)
>        - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
>        - Radxa ROCK 5A (rock5a-rk3588s)
>        - Radxa ROCK 5B/5B+/5T (rock5b-rk3588)

