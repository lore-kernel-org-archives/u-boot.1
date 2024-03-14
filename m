Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D379C54E5D
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 03:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2E7587F64;
	Thu, 14 Mar 2024 04:34:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="f/hwaVzM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C513887F78; Thu, 14 Mar 2024 04:34:41 +0100 (CET)
Received: from mail-m12813.netease.com (mail-m12813.netease.com
 [103.209.128.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52E1287CE8
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 04:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=f/hwaVzMtlioz0y825OFwSGQ5IrIeLImG1WlXMdvYDTxzO9PzDxCoKP6T3OwVWovdS70hbtAQUM3SrYwAbwIGH0O6xGFUWi+xvGoK8QY4xEKscnLdrCmcbXwTxqPwBQwJEoldPiDI+rETGLRmN4uABp2F7/IMdUq066WF3gXKa4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=22XwTAoWAD9/vM3XeAT0eDE7P3VWlbKjfbRW40HBKxY=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id D2109900245;
 Thu, 14 Mar 2024 11:34:32 +0800 (CST)
Message-ID: <1d795d10-b0d2-454c-a821-63e4c27ac676@rock-chips.com>
Date: Thu, 14 Mar 2024 11:34:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] rockchip: rk3328: Add support to build bootable
 SPI image
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Tianling Shen <cnsztl@gmail.com>,
 u-boot@lists.denx.de
References: <20240217002304.2141064-1-jonas@kwiboo.se>
 <20240217002304.2141064-14-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240217002304.2141064-14-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk9KGFZCSxkdSBgeQktDSB9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e3b069fa303a9kunmd2109900245
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBg6GBw6CzMJAigQHR9NTDYi
 NEoKCRxVSlVKTEpLSENMSUxIQkJNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIS01JNwY+
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


On 2024/2/17 08:22, Jonas Karlman wrote:
> Similar to RK35xx the BootRom in RK3328 can read all data and look for
> idbloader at 0x8000, same as it does for SD and eMMC.
>
> Use the rksd format and modify the mkimage offset to generate a bootable
> u-boot-rockchip-spi.bin that can be written to 0x0 of SPI NOR flash.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - No change
> ---
>   arch/arm/dts/rk3328-u-boot.dtsi        | 11 +++++++++++
>   arch/arm/mach-rockchip/rk3328/rk3328.c |  1 +
>   2 files changed, 12 insertions(+)
>
> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
> index a030f1a5e51d..4d43fe2fb51a 100644
> --- a/arch/arm/dts/rk3328-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> @@ -133,3 +133,14 @@
>   &usb20_otg {
>   	hnp-srp-disable;
>   };
> +
> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> +&binman {
> +	simple-bin-spi {
> +		mkimage {
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> +			offset = <0x8000>;
> +		};
> +	};
> +};
> +#endif
> diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c b/arch/arm/mach-rockchip/rk3328/rk3328.c
> index b591d38fe412..b82b209de9e2 100644
> --- a/arch/arm/mach-rockchip/rk3328/rk3328.c
> +++ b/arch/arm/mach-rockchip/rk3328/rk3328.c
> @@ -36,6 +36,7 @@
>   
>   const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>   	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff520000",
> +	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff190000/flash@0",
>   	[BROM_BOOTSOURCE_SD] = "/mmc@ff500000",
>   };
>   
