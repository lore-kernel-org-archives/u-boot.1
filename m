Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E894C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 10:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66BE887D49;
	Tue,  2 Apr 2024 12:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="QyyuHaAk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1850D87F19; Tue,  2 Apr 2024 12:38:15 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B793487BAF
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 12:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViwKQxjPwQkc9GMiOwsASURvhpuicZ3CIqjCWKA2AKMEcYBLXZYPvfuS/sYIFo7VorVdnWc7bsrNV5KzCr5nDpl6WdlosyDApJ8ADDvND/IJCjHiQrrASJzDUUhqMKGnFuxQX0C5BBjQMBs/RFVHoJKyg4RPNhIW6zclCH8mubk0rvLSH2UOgtXitxz67ouZXdy/5ZDowfTNSJ2iBgheCczQkcQFTP51rXVFy6n+/SgRw5TkX4bSnFwBvuWuFPoGcSbx5Ro/H4OrCSjZqY4K2Q6quwgbwtlAzOsrXWmZPcJ9rmqoz8qfJ7yNY0pUek5trck8UFtsPaIy992BimbW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ig+Ejrr5Ju78AIZCA5Ef7pEyI0+j7Zjcd5VeWVf6hiw=;
 b=Mn8iGcarp9GMaJrKXMbwzsTyDoMhCt7E+x6C4hvxZURQTzJYmow0M1UMqy8VIFXWuIVeTU0EyI5xJAJ8wVWcTkt4AKXbS5MNpcTi//dC82FVUSfwixxynCbII7/+ARtINdxfHQ35Gp8yE7GTYBjbrT8Sn1oLMPtBYLY5WiDUtZCsrCxniRLkJPhUhkbwvLoWWi5XHVNyc4yHsVxde/LQZdKl4tCHoM+Qk3B/pQPqfokf+aSwt3EMzfUuUk3f07ftK/atmB+D7nfA3EV5YhsihEydwJ2gg5pd/Ov/LEGfr80WqlmxyJOW9wURvnGQMW/mrk5BEUZDXqzB2sbuR2N1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ig+Ejrr5Ju78AIZCA5Ef7pEyI0+j7Zjcd5VeWVf6hiw=;
 b=QyyuHaAkolyb5p3PEj5nEkE7QUMHoMuxZluJLw/GZvmdRber0cUty+WLTuNPmsQ9w5uYYzwu1C9aIK5iKSZG5bmnoYpwIW3kcefbHASoOeECScU5XM8N/tTgyM6FQogFJ3cSxUrFZnI+sDSrd1GqRWZg4Jnr0axrhYYV6xR9s73BxPtxuz9ls0C9n2roCW0uzszbVOfprwhXsU1kJXMUhZdrfnnZwihF3noM16G6LxmHIpjukRBpYQchHS9C43e3knViuIGurrAuo8U/ybdSN1f6iTSRPU4DNawLeFnERoUDGMcAZwXhtSqM1AQ2OudN6mw4cQPkCuBveSf3YvFgQQ==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM8PR04MB8033.eurprd04.prod.outlook.com (2603:10a6:20b:234::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:38:10 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 10:38:10 +0000
Message-ID: <d10bd351-5005-427f-bc41-ebe547e5bda6@theobroma-systems.com>
Date: Tue, 2 Apr 2024 12:38:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/19] rockchip: rk356x-generic: Add support for SPI flash
 and USB OTG
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240329190224.3613471-1-jonas@kwiboo.se>
 <20240329190224.3613471-19-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240329190224.3613471-19-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0003.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::6) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM8PR04MB8033:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NC1u1dG7VfFrNWNVzMs/MaPFDEHz8cgA+uGURk4ekOaRqMzAPSjwqttWYncqhk9RPOvVCWGCIHTPEz+sGXKnBaXvmJYBL2M2Nir4QBEud8br+Wz3ZGTZruYPZi+QJoeSz2Dqo89y2PaM+EmauW2BhhVIQEUdqxnY+cnKkhDgXunQEd/CbL62jgV/2ivz+qnTSfnRqelzqvWXprXyMrdzcAEH5up6+IsTG+VWgGTdkZqUwk66JH4WfyumEf0/5Jd3JPKzqiCGenZYRC7QAOJFGz+k/xFWRL+KjyjDY2zwDSXNNkuachwrGJgxxNpbvtUX6pecteVdGx/qfsTtn7S8tktoJPYukBVFtqFuV9o9SoreSIQ5DbsrusWXGFOAmX0mFRx9V27JF9fq0dtcuSD2c1jKGx1yP2cC20DkKf4hofdHnhbXQNDR/a//6RrAwinwq/h/YX71/s/bLsouOyYfNOfVIzJqT12CroIy7shA/0VanYj0+brfM0l/9rRIvK/G9h0d0eL4E7QEqDGLFq2EH89ER1XVwwaaepvWKSf0B2QtValcoDGqO28JFkubhgH10xyxx/oDxhIoPtnBjw/cal7J9g6BSYbuh88HHzHKzCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFVyZGUxZUxGWVcreGc0MkdxWnhaQXNCOGRxaXBmUTdsckwySllsODVmUkVR?=
 =?utf-8?B?Qk5ybXYzcXJmNDhNRnBIaFUyWUhzejllQmxabkxCaW9tSUVoTjhFdlRKZ0Uv?=
 =?utf-8?B?VGUwRkM2K2E4TzRmOGZ2MlIwTGhsUlJ6bEhGUlhZdGI3U0NGVDUwQnU1V0Nj?=
 =?utf-8?B?QzVibEZoVDdmMU4zV2tiNDgyRTV2V2tMN0xobk9RTUcyOXRCdjRqVjU1N3B6?=
 =?utf-8?B?RUZhdVVhSERrd201RFN3ODJ3OG9UeDJSTnhTTkswYkxTWmxKcmI1NFRJZytS?=
 =?utf-8?B?Y3FFTE9xQ2JtUUkzZURvMHk4M3hZdjJKalRqWE9NN0NEZ3pjNURjRzJ5Z0du?=
 =?utf-8?B?aXNLUTVHckFaNU5VYzRnNUJnbGlHeUsvRVJVaHdtZ09jQml5ZnJIWkxua2h1?=
 =?utf-8?B?ZzZGdDFYY3ZQS1dUVEhUM0dzQ3lZL2xSbjM2ck02OGNkbm51Wks3MDlERmN5?=
 =?utf-8?B?Ly92K3ZPU0U0Q2JUYW5ZU0h6V2VnbGxFb1dqRzhiNHdVNXN3dkVvZlR4aG1Z?=
 =?utf-8?B?THJOTmY1M1g1a3NCYjVHN1ZKdGFLMk9pYVRVeTdrcHc1S05RcG9CNGp4MmE5?=
 =?utf-8?B?Z1BXS1RROXNoRUhueWNMbUtYS0VibE1ibVNsKy95K3hvcHlKSno1OStmTDB1?=
 =?utf-8?B?K3RUc2dBc3hEZ3k2ZUxPYmxsRDFhd0Q0a01mUnFvSHprM1lvL1lWMXJJeCtz?=
 =?utf-8?B?ckRHRkhncW1hRllYbk5Dcm15OFl6RTRtQktVU2VwWXNkU1prS005a2E3Ungr?=
 =?utf-8?B?Q2dHUkZIOGZkUXBnbGNuOVZIWXR4cjQzTDZQOUdJc3VVYVRrbHdVSU1wSVhs?=
 =?utf-8?B?bnozb3dJcThqdGUxUzdWU1FnNE9PdVhPR2FWMjJWTEVTQXE0bVFMVHp1Z0cy?=
 =?utf-8?B?VUNsTEhFNDhSTUFpZWlRTG41d1pVYy9PRElEVHdmL2Y4WjFKMm9LSkFiWEdq?=
 =?utf-8?B?eTNBMUp6eXBhZmltc2xINWNmS0hSMUFxaWlkMVNXVEhvaUI5eVlzelNhenow?=
 =?utf-8?B?OVlQRm1WN3B1MW9yMXh1UzNFbHRDcWhyMmdaczlFQUJTaWFEam5WMFZYQzJE?=
 =?utf-8?B?NFJMaURYSUZhVEZkekpPT3JzajVMMUFEQVFBQXIrakZjTUNIeTY4SkJOQWth?=
 =?utf-8?B?aHdCSDhJTDYrc1NTdnZiVTdDUmpvK1BFYXIrN055ajN5K2ZBUlZnbWZOcHdO?=
 =?utf-8?B?ZWxsZ2FwY2pyM245bVZJVG5TczF4SEtsWHcydVZ2SmdWdEthQmJ6VHFocVlt?=
 =?utf-8?B?akFGV09hVmlSVGFmZm5VTk0zSTYvOVlwQW5MTVRDbnRFY29HS3NKUzl2dGxR?=
 =?utf-8?B?ZHRVNUd0MWE5MWZPRVdSN0Q0Z1QwejdaOW9BTGRqOWdaQ1ZTSFlNSmo5Uld6?=
 =?utf-8?B?bG9RcHI4VHJGdFA5ZXVLYlR3bnNobU9vTzVhTGNteXdOalRZL1hWMnpPZUR0?=
 =?utf-8?B?a0lTcHhsUWQ3VmcxZ0gwbHlTRFAyaDUyU3lqRE1xN3U3NExtL1NSa1Vob3Yx?=
 =?utf-8?B?WXVtUFlhN2c1UDBTRXkwemdnNDkxK3dYM2lBbDM2bDdhSVJxNFc4Nnphcm9l?=
 =?utf-8?B?YTRwZ3ZFSFJodlNjMjhiMDM2UWVhNERzTTFMQW5qVHJwajdmc2o1dTRFU3dt?=
 =?utf-8?B?cVBZSGZ0WS9BaE1leFQveWpvL0NWTXBNS2JqYUFKWk9KdDRBYU9nbGRtWlhv?=
 =?utf-8?B?Zm52eU4wZDRqVGN6SWM4UjRGQWVOaE1iclFIV1Z1NmphVXFuZmVaU3BXY0pV?=
 =?utf-8?B?a2RXbmVLTHNsa0Y5WTYwblVSSjRzUnJJQ2lZWFNNOCtlUUNUcTJZRG5JNFBW?=
 =?utf-8?B?cXgwY0Q4S1lWOEtud3Jwak1BZ3gxMVdiK3JlTWNGTGFJT1dUL01FN2ZaTEg1?=
 =?utf-8?B?MCt1VnZJdCs5elRtcVFBYTVXekdTd1pmL085Y0VEV3hTK0cyR0FyM1V5OFB1?=
 =?utf-8?B?K0Y3akNWZ3RsOERubFhKTnBaVFBCTlV2Nm04Q0Vjdis1ZVNYMHVCTmZEMXhx?=
 =?utf-8?B?cVQyOVpydVdMNlUzZWRGbU9kb1gweS96UDdHZWM4SUw5V0V4S3RMdzZrZGVR?=
 =?utf-8?B?Z296ZmltZXR4aEx4T3hjRFZPemgvN0hWUUdSNnFDNVpIOEdLLzZ2Y205MjJN?=
 =?utf-8?B?eHNrbDVGKzFWRU0xNTUxV2dTVGJCL0lyS0hGMkFjMENFY3pyZmFqNXJtbFUv?=
 =?utf-8?Q?OlkjjYABlxvJgpL9A8L60xY=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4b08a7-fa98-402b-0a52-08dc5300fdf1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:38:10.6401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHKbhLD9IISaOdLwL0hsDugLB0cSfPUdLvGM6lo2EfpPzunueCsYaR/jAFKZCYl417BaiApbRW5BSDcQ7gz+TElVjC7ZZLWf/HQbaR43SstysRnPJjAYPmvsn6OGMMAh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8033
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

On 3/29/24 20:01, Jonas Karlman wrote:
> Extend the Generic RK3566/RK3568 target to also include support for SPI
> flash, USB OTG, RockUSB and UMS.
> 
> Also fix sdmmc alias, include missing pinctrl and add broken-cd prop to
> fix use of SD-card in linux.
> 

I think we would have benefit with more and smaller commits there, but 
since you're the one mainly maintaining those generic devices, up to you.

[...]

>   &sdmmc0 {
> +	broken-cd;
>   	bus-width = <4>;
>   	cap-sd-highspeed;
>   	disable-wp;
>   	no-mmc;
>   	no-sdio;
>   	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd>;
> +	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;

This is... surprising.

`broken-cd` but we still mux the SDMMC_DET pin in the SD card detect 
function?

According to the dt binding, if broken-cd is provided, we should do 
polling. If neither cd-gpios nor broken-cd is passed, host native card 
detect will be used (which I assume means the SD card controller handles 
this internally).

c.f. 
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/mmc/mmc-controller.yaml#L33

What are we supposed to do there actually, because this seems to be 
contradicting itself?

>   	status = "okay";
>   };
>   
> +&sfc {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <24000000>;

Random thought, but shouldn't we update common/spl/spl_spi.c to read 
this value instead of using CONFIG_SF_DEFAULT_SPEED? (Nothing to do in 
this patch series though :) ).

[...]

> diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
> index e7d5e55bbfd8..b458080cd539 100644
> --- a/configs/generic-rk3568_defconfig
> +++ b/configs/generic-rk3568_defconfig
> @@ -3,17 +3,22 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=2
> +CONFIG_SF_DEFAULT_SPEED=24000000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3568-generic"
>   CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>   CONFIG_SPL_SERIAL=y
>   CONFIG_DEBUG_UART_BASE=0xFE660000
>   CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
>   CONFIG_SYS_LOAD_ADDR=0xc00800
>   CONFIG_DEBUG_UART=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
>   CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_SPL_LOAD_FIT=y
> +# CONFIG_BOOTMETH_VBE is not set
>   CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-generic.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
> @@ -21,32 +26,58 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>   CONFIG_SPL_ATF=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>   # CONFIG_CMD_SETEXPR is not set
>   # CONFIG_SPL_DOS_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +# CONFIG_NET is not set

This seems surprising, do you really want to get rid of network support 
for the generic board defconfig?

Cheers,
Quentin
