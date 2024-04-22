Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F96EC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A703883BD;
	Mon, 22 Apr 2024 10:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="eyjfky+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4334883C2; Mon, 22 Apr 2024 10:11:38 +0200 (CEST)
Received: from mail-m32108.qiye.163.com (mail-m32108.qiye.163.com
 [220.197.32.108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52BB888398
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:11:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=eyjfky+9mUwKxpCG9YxAVvbQ5BoY5a1JQ86RDsKf1D0uYqNBGNAUAG/y1hgTmX7F2W6o778pN4zbUGIxtz1fEjXL2CPnBKoG25ekfWdNEaTicZ/Hef68Bs7Kct5Wn4PzKTyqYUxfDUDScyEABhVGQxm7qumjz+US+ZYPxrKqpZs=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=XTSqIgdR3SYTdtp4+ihvzgQd1OFYC/yP2IQG+ysaOqE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.226] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 1F6B2900105;
 Mon, 22 Apr 2024 16:11:30 +0800 (CST)
Message-ID: <1da68456-eac6-4efa-9a15-38d0008d6a6b@rock-chips.com>
Date: Mon, 22 Apr 2024 16:11:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/28] rockchip: rk3588-generic: Add support for USB OTG
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-28-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-28-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk5LHVYdTklJSU5OQ0wfHUxVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04dc318503a9kunm1f6b2900105
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRA6ETo6PjMMKjoKTRhRDR9L
 MhRPCUNVSlVKTEpITExIT0JLQkNKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPT09KNwY+
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


On 2024/4/22 14:29, Jonas Karlman wrote:
> Add support for USB OTG, RockUSB and UMS to the generic RK3588S/RK3588
> target.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: No change
> v2: Split patch
> ---
>   arch/arm/dts/rk3588-generic-u-boot.dtsi | 22 ++++++++++++++++++++++
>   arch/arm/dts/rk3588-generic.dts         |  2 +-
>   configs/generic-rk3588_defconfig        | 11 +++++++++++
>   3 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/rk3588-generic-u-boot.dtsi b/arch/arm/dts/rk3588-generic-u-boot.dtsi
> index 853ed58cfe58..225dfa0b682a 100644
> --- a/arch/arm/dts/rk3588-generic-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-generic-u-boot.dtsi
> @@ -1,3 +1,25 @@
>   // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>   
>   #include "rk3588s-u-boot.dtsi"
> +
> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy0_otg {
> +	status = "okay";
> +};
> +
> +&usbdp_phy0 {
> +	status = "okay";
> +};
> +
> +&usbdp_phy0_u3 {
> +	status = "okay";
> +};
> +
> +&usb_host0_xhci {
> +	dr_mode = "peripheral";
> +	maximum-speed = "high-speed";
> +	status = "okay";
> +};
> diff --git a/arch/arm/dts/rk3588-generic.dts b/arch/arm/dts/rk3588-generic.dts
> index baafe7463f1b..95d757676f12 100644
> --- a/arch/arm/dts/rk3588-generic.dts
> +++ b/arch/arm/dts/rk3588-generic.dts
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>   /*
> - * Minimal generic DT for RK3588S/RK3588 with eMMC and SD-card enabled
> + * Minimal generic DT for RK3588S/RK3588 with eMMC, SD-card and USB OTG enabled
>    */
>   
>   /dts-v1/;
> diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
> index b50f4f8b8008..e96df619b59d 100644
> --- a/configs/generic-rk3588_defconfig
> +++ b/configs/generic-rk3588_defconfig
> @@ -27,6 +27,8 @@ CONFIG_SPL_ATF=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>   # CONFIG_CMD_SETEXPR is not set
>   # CONFIG_SPL_DOS_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
> @@ -36,6 +38,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
>   CONFIG_SPL_CLK=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> @@ -44,10 +47,18 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
>   CONFIG_SPL_PINCTRL=y
>   CONFIG_SPL_RAM=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
>   CONFIG_ERRNO_STR=y
