Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E89BFF8861
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 11:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D97AC83FDB;
	Mon, 27 Apr 2026 13:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="QH6fG5Qh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AE7183FDB; Mon, 27 Apr 2026 13:29:50 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 834DB839D9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 13:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/Mujw9XexBnHU1ywmcSn9cSuoKwNjjRbPWFhZswGZOlL52qRlvbD725MavxENCGX/kHUlSbz8B/36cOG6mUoe9LoPOKZvknLQ55ZZyq99WtoLCiOBimV3ddDKDLz/xvhRoMg2KnuUGRQ4rjHxHCHtvbL/Qtnh7T8BAiMP2igyxKw4JkJPKpQTyXGjgjmSUQwyPF/4gQA0gcvcOt9aHlLKjo3algeX6jlXHddaQ0r7BV8zUGN5YXVAPXYYg5mW0feTfY7diQ3AqOdVPa9quh5wQTQRuyuex5d/lO/TaVsZh2C4aNCH9yRoSAc6ZPzh0AlSpxika8tshyyIYy1vnzCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLdiHI9enqTPNVVyIqSOXP/go7ADX46MdUrgx9dttYQ=;
 b=AX53jsTLLok4nwjmCQxOo2QNV7KVj/uvfiQobOGTXKTViz/OOUMW09zKQeokIrFzsF+0bXp6PVO+K7qrGVbv+UQN4NM0KMgEEGilRQ1kwX0xmb/4iEX6mw0OAHrVvwvd6YDBtw4D4WGDWQh/NSls28FDEbrVKkeNM5lV+rQOpYbV4/18vPjcDaLfsYXRZ51dA2gbHVXzjWiSKyf0hE84H02fLQ1b02SThQoA759RGO10wRHhs3bbHJ1b7kcSpmmQ7aYMN2dCNtHf3rOWQygTrvbVmSEoei3Pcjf7EvnqxlZfztvcV59twkjs21yKx09RLcsp5iRE0Oztyp5HYBpjeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLdiHI9enqTPNVVyIqSOXP/go7ADX46MdUrgx9dttYQ=;
 b=QH6fG5QhntkGXoGGAKZV+DPNxw9tWmc9sGmGPr/L0xaiNEK3Lz3u6l9k+y9S1vaR26TbF/qb0+v/c5Pjn1Mqdc7D7/aWq8oSGxlKIR+gQiy//cvTEcdPuw1qeS9TQPQueIE27ucnWHB5zOn+g+voQox1obKmWxTLWIFgU7RFQsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PA1PR04MB11532.eurprd04.prod.outlook.com (2603:10a6:102:4e0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 11:29:43 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9846.016; Mon, 27 Apr 2026
 11:29:43 +0000
Message-ID: <71f9df6c-81a5-461a-abae-ee07814705d0@cherry.de>
Date: Mon, 27 Apr 2026 13:29:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: add Anbernic RG-DS
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
References: <20260423183549.598018-1-macroalpha82@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260423183549.598018-1-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0141.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::25) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PA1PR04MB11532:EE_
X-MS-Office365-Filtering-Correlation-Id: c06c4c0a-f442-4c02-e1d6-08dea450472a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: FRV0i6XGyY6Gnh5M+DY0RvKQdh957Hjm5RMzxFByaDdHXnNoHv7BHdCgrIPGc9JuGXLY+8K99Jvf1JSaR0x5LztWJ2SVZXzebJLCRMLen0awH0sOQTNdxyAnECpYdFkgKcbWT5A4uJjdzgMXzd6jwjc9M9uG4xh/T0q1jMV4nrupFUkYNSAXHm3w14kY37ZL1wlTrdKYRJKsfC6stbaxor5IZK8Jg7NYzGbRKbIiJh94FjxrFn3HChG+WjOr+lhLsLawkAZ7/9VBFTG584R4I44UvWmWO9DW+1uuENmXJlGPvrPeDqSQFOMkOEblj6Lw1bfRFoO5Q8a32Tqhq0wpJwF2CuUiVBRWw450zZxERuH+2TqgTmfG4Y1dbawF/S/nRmKgWxkTIijqQ5WkAG+LzF4ABXrd5T/HU44jOW9D1ifdIdzG/jkb+9i/Za5JuhjaNM3NQeJTyl4osZSDUITuOTe9hAtugBkoMSR3LBhZtGWP731fji5LLJy5dwYh2k3zDCsHkvdDC9Owc8DD7okWgRLDHwd3iPXC5apfRpqJUhXxusC1TPRc2E/YUZbgF8yjrzh6A5Oyoyx7zuHMxh3BQH17TRuDnORATCsuPPDzsZRdGWeSshCS8ahfaBA2f4Y1MIzmVzv6ZO3q4WbMG72sgJaRMWeCOT9vSfSIDg0x4fCMa2JmV53HInFPvZ5vYjt2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmhWY1JhTHE2ZDUxaWthbzZsRUZTVEZlU2Z5anlSeFZlU0h5NHIzUit2dXdL?=
 =?utf-8?B?NFRmZmwrOXpvakcyUTFwazkvczZ0ZXcxQlJaRUFaY3NDRjM2ZTlnVFFaSFpK?=
 =?utf-8?B?WkxKVlcxNnBHM3hVZ0dFZG40Q0tnMmJMSmVMS2l4K21oMy9yMUQyQUtHdVAv?=
 =?utf-8?B?VzhGOTcvVUc3WUpWZkJzTmZsSmhxZHdhN0RXQ1NhdDVFVXR2YjdGU0VUZzhW?=
 =?utf-8?B?QmxOcFh1eWFlVjZRWG5lWEx0dVBHbE80VmRlMFNiS2htL1RVVExJUHIzekwv?=
 =?utf-8?B?WDlORnVxL01zRG5CbVNKdVBSbHhoTnREcUJNNEExZlVocXZiUGdEVDBKb2ZH?=
 =?utf-8?B?a3ZBOE9tdEtvMEdIYzBqOFRKdng4S1BrMjIxdEdvNXUxQkplWm80UTRPWkt6?=
 =?utf-8?B?ZnZ5QXQ5VVZ4Q3VTbDlMU1NvVENaWmpRWjhVcU8zNWx0ZFZ2Q0FTK3hCU0pY?=
 =?utf-8?B?YUFKNFI4cGdtc3NVaktJcnJseCswaUFiK0c4ZE5TcjRVMHBFNFRodWw1dm1U?=
 =?utf-8?B?ek1nenVYdGNOM1k1WVI0Zk5mNFAvWGh6YnVjbDlDT2pUbDlSc0lDVnRGTjRj?=
 =?utf-8?B?Sm1ja0QzendldTlLd1pSd1ZGeTRicVdkb2ZaQXdjaWlSb1U2c2tqM25iYUQ5?=
 =?utf-8?B?RXJrczFOOHl0WUI2WlIxUStYK3czV1RNczhLUTVGUTEzbDk2L21XNVh1SWk0?=
 =?utf-8?B?aG1nYWd6bktGTzdaeDlCc0xzbXl3Z3BZYlhRV0lVelNNNXg3dFVkdmZrN2wz?=
 =?utf-8?B?bGJuSHdpUGVtK3hibHMwWEk0dEJaNHQxc1hrRVB5WkJyWDhUaElvQW50ejJy?=
 =?utf-8?B?NGkzclU3U1Iwc3NsUEFMbWM5Tjdsam1ZZnVBODRTUzBFSjhNWmtMb2JTRmhs?=
 =?utf-8?B?ZHBaNVc1T29nUHZNbWlJNXdMOUtqTWx3bDZRQjgyZW9hckF6dUFoKy9RK29o?=
 =?utf-8?B?NkYzWnNyV2ZLVW9aY2FZZkRKdFVSa0piaTVDZ29BQ3pDaHZWdnNreVRud3A2?=
 =?utf-8?B?STNicGdLSEtqM3kyU1o3SEZYaHlndXZWd0J2UzNGUm03UXJLV0tyeWlYaHlZ?=
 =?utf-8?B?WHV4em5vOXM0cDJhSFJFK3JNLzdGTWhMT25sUncwUzQzTjFTUk5PRU5zV1JX?=
 =?utf-8?B?WUdWaHhxUFpvOGVFL2U5NWMxNE9iQktidjAzL2w4V0xERGpmOGJnODQwZDZr?=
 =?utf-8?B?Ri95SkdMYllRNVRvTm1PaXpBdHRzK2FvTHBHUmRvRnNLNDAxUkY3cEF2V2Vm?=
 =?utf-8?B?a1VrV3Vsa3MvWnl2a0ZUSndtckw5TVlPSzlQRFZ5V0E3WU11NENKWU00MjND?=
 =?utf-8?B?d3BldHBqcFJUSHhxWVNDUmlybTJ3RHduZmZNTUZPME1xZVJXTmR5V1ZWRlM4?=
 =?utf-8?B?NHZscUVYWGdkSTJTQ0k2d1ZNdVYvUkpkWHgwWFRBK3pDVXU0NFlQSzFVU0hy?=
 =?utf-8?B?Ujk1QUZKRUd4NzJtcGMxZ0syVXNNa3BoMmk4VEgzUmhlbmM2UnIyckhkNGxz?=
 =?utf-8?B?bVJsTkxxdG4wUkJ2K253NnhMRXF1Z3cxOVVuYTNnVHJCeVBDSVI5N3RQTkg3?=
 =?utf-8?B?czU1aExsWGl1UGpDbk9QNzhOM0sxVjk4dEtLVEZLNzVkMWlaQVFQei95b2h2?=
 =?utf-8?B?WWxOUnlKK2RHSkFwOTZaaWJQTjB5ZVYzVFY0NUE2RzMydGUxUVppVEJDczJH?=
 =?utf-8?B?WmZ2ZWFGanJyWWVGbjFQeG0yblJ3aDdnV2s2L1MyM0hwTytTMU1yWCsyWS8w?=
 =?utf-8?B?RWpoK0ZvQ1BJa0dCODVZR3hibC9wS0dzbk50RWx5R1I1WWN6U0luN3lDaW53?=
 =?utf-8?B?dUViZEtrNjBtNGtYU09hd0ZjVVYzZWZ6K2k3K0M3VnNWZnF3MHZOSzBSMXU3?=
 =?utf-8?B?WmUvc3JWYTYwTk5pZTUyTC9COCtkNDlUS09kcnVDanVaWXJVOGovblJzVC9F?=
 =?utf-8?B?eTFmdVNNVDF0M1NHN3pqK2duOVN5YW1vMTAzWHkyakpWaktyQkJXYTZMclBG?=
 =?utf-8?B?cDdFWC9DaHlDMDI1SmdDK0VuOTFIZDVZYXIyRmJEaVVLOUg2RE9iSmtqWWxU?=
 =?utf-8?B?b3NKOFphMXdGbkVSbjBqN1lVeWFuNk5OdFluVEVNdzcyY1J5Vjdna05TYmxh?=
 =?utf-8?B?Y0sycDVtV29oU3hHdUVML0Z5S3c1alRGQmRrL3U1NUVxcHpDSitpSjQyUkQy?=
 =?utf-8?B?UkZ0b2FJRlRSelNNeXF2KzY1bVM1NVloTVRZdy9CeEJyKzVxVGRiZGtyUytH?=
 =?utf-8?B?ZERTbExKTnlhV2hibHp0anIvbko3d0pLWnBrVEEwV2NiRTg0UEJLOHJBTWdQ?=
 =?utf-8?B?VW5vK3ZTWHE3UHdZZjFRSjJVdVNlNEVPNjY1OXpvd1FPcnVBNStucGx2NGJT?=
 =?utf-8?Q?NpTn5wD07AoFoUa8X7oh/eJxOzQsAIsmdCO8B?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c06c4c0a-f442-4c02-e1d6-08dea450472a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 11:29:43.3189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1Nr2NgtfuT9GkHpPU4HF2tE1IHtrX1T5warbt/gGJ853iT+HOY+aKbuO8bpc+7bVc+4yXQ2JuTTVJzH8Zqk1NDWr4vmBiY9/dal2jJtvQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11532
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

On 4/23/26 8:35 PM, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the Anbernic RG-DS dual-screen handheld gaming device.
> 
> Link: https://anbernic.com/products/rgds
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>   .../arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi | 41 ++++++++++
>   arch/arm/mach-rockchip/rk3568/Kconfig         |  7 ++
>   board/anbernic/rg-ds/Kconfig                  | 12 +++
>   board/anbernic/rg-ds/MAINTAINERS              |  7 ++
>   configs/anbernic-rg-ds-rk3568_defconfig       | 76 +++++++++++++++++++
>   include/configs/anbernic-rg-ds-rk3568.h       | 12 +++
>   6 files changed, 155 insertions(+)
>   create mode 100644 arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
>   create mode 100644 board/anbernic/rg-ds/Kconfig
>   create mode 100644 board/anbernic/rg-ds/MAINTAINERS
>   create mode 100644 configs/anbernic-rg-ds-rk3568_defconfig
>   create mode 100644 include/configs/anbernic-rg-ds-rk3568.h
> 

Please add an entry to doc/board/rockchip/rockchip.rst.

> diff --git a/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi b/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> new file mode 100644
> index 00000000000..337e50f2e54
> --- /dev/null
> +++ b/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "rk356x-u-boot.dtsi"
> +
> +&gpio0 {
> +	bootph-pre-ram;
> +};
> +
> +&i2c0 {
> +	bootph-pre-ram;
> +};
> +
> +&i2c0_xfer {
> +	bootph-pre-ram;
> +};
> +
> +&i2s1m0_mclk {
> +	bootph-pre-ram;
> +};
> +
> +&pmic_int_l {
> +	bootph-pre-ram;
> +};
> +
> +&rk817 {
> +	regulators {
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&sdhci {
> +	cap-mmc-highspeed;
> +};

Why is this not upstreamed to the Linux kernel DTS?

> +
> +&sdmmc_pwren_l {
> +	bootph-pre-ram;
> +};
> +
> +&vcc3v3_sd {
> +	bootph-pre-ram;
> +};

Don't you need vccio_sd as well since it's the vin-supply of vcc3v3_sd? 
(and also used as vqmmc-supply for sdmmc0

> diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> index 2730220a18e..8fbd764ab54 100644
> --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> @@ -8,6 +8,12 @@ config TARGET_EVB_RK3568
>   	help
>   	  RK3568 EVB is a evaluation board for Rockchp RK3568.
>   
> +config TARGET_ANBERNIC_RG_DS_RK3568
> +	bool "Anbernic RG DS"
> +	help
> +	  Anbernic RG DS gaming device with Rockchip RK3568 and dual
> +	  displays.
> +
>   config TARGET_ANBERNIC_RGXX3_RK3566
>   	bool "Anbernic RGXX3"
>   	help
> @@ -71,6 +77,7 @@ config SYS_SOC
>   	default "rk3568"
>   
>   source "board/rockchip/evb_rk3568/Kconfig"
> +source "board/anbernic/rg-ds/Kconfig"
>   source "board/anbernic/rgxx3_rk3566/Kconfig"
>   source "board/hardkernel/odroid_m1/Kconfig"
>   source "board/hardkernel/odroid_m1s/Kconfig"
> diff --git a/board/anbernic/rg-ds/Kconfig b/board/anbernic/rg-ds/Kconfig
> new file mode 100644
> index 00000000000..cb93c249cf4
> --- /dev/null
> +++ b/board/anbernic/rg-ds/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_RG_DS_RK3568
> +
> +config SYS_BOARD
> +	default "rg-ds-rk3568"
> +
> +config SYS_VENDOR
> +	default "anbernic"
> +
> +config SYS_CONFIG_NAME
> +	default "rg-ds-rk3568"
> +
> +endif
> diff --git a/board/anbernic/rg-ds/MAINTAINERS b/board/anbernic/rg-ds/MAINTAINERS
> new file mode 100644
> index 00000000000..79ddb663ab7
> --- /dev/null
> +++ b/board/anbernic/rg-ds/MAINTAINERS
> @@ -0,0 +1,7 @@
> +ANBERNIC-RG-DS-RK3568
> +M:	Chris Morgan <macromorgan@hotmail.com>
> +S:	Maintained
> +F:	arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> +F:	board/anbernic/rg-ds

Should we have rk3568 mentioned here maybe? Not a blocker though.

> +F:	configs/anbernic-rg-ds_defconfig
> +F:	include/configs/anbernic-rg-ds.h

Both defconfig and include files do not match here.

> diff --git a/configs/anbernic-rg-ds-rk3568_defconfig b/configs/anbernic-rg-ds-rk3568_defconfig
> new file mode 100644
> index 00000000000..c16a208a117
> --- /dev/null
> +++ b/configs/anbernic-rg-ds-rk3568_defconfig
> @@ -0,0 +1,76 @@
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
> +# CONFIG_EFI_LOADER is not set

Any reason for explicitly disabling EFI support? (aside from other 
anbernic devices disabling it as well?) I believe some distros depend on 
that for booting up?

> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y

Is this really used? I'm thinking we should probably stop using this for 
new boards if possible?

> +CONFIG_OF_STDOUT_VIA_ALIAS=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-anbernic-rg-ds.dtb"
> +CONFIG_DISABLE_CONSOLE=y

Why no console? This will make debugging harder no?

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

Why remove clock-names?

Cheers,
Quentin
