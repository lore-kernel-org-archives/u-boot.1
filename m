Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516BDC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D524D88396;
	Mon, 22 Apr 2024 10:10:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="NqfBeI8D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7C5D8839D; Mon, 22 Apr 2024 10:10:56 +0200 (CEST)
Received: from mail-m12773.qiye.163.com (mail-m12773.qiye.163.com
 [115.236.127.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5869088353
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=NqfBeI8Degwej9b/aXr344tmL/9OhKBEuX/Ap3aXNrqS6TuLsrJRc7oQ0nY4VNdKGs+HZExffOyWd7AEPxfWy9rYmXQatj5Z8ELjvSYcnULfnKNqeLlrmOnIm0c7A9hDOgdKzMFMcP01q6I4MOtXPzIzdbDsMRvKwbiwqYqAGH8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=uYpkcYGbBzPC6T7IVDBCGzbCE3qe8qFc7VMfNM1mthA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.226] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 2C1C29002B1;
 Mon, 22 Apr 2024 16:10:48 +0800 (CST)
Message-ID: <90d34d9d-0f35-4d7d-9dd6-263d25de7852@rock-chips.com>
Date: Mon, 22 Apr 2024 16:10:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/28] rockchip: rk356x-generic: Add support for USB OTG
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-26-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-26-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJPT1ZMT0JMHUpPHU4ZTE1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04db8e4103a9kunm2c1c29002b1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQw6NBw*CDNRMjoCGBgSDkkP
 DEoKCh9VSlVKTEpITExIT09CSEhCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSkpMNwY+
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
> Add support for USB OTG, RockUSB and UMS to the generic RK3566/RK3568
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
>   arch/arm/dts/rk3568-generic.dts  | 19 ++++++++++++++++++-
>   configs/generic-rk3568_defconfig | 10 ++++++++++
>   2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/rk3568-generic.dts b/arch/arm/dts/rk3568-generic.dts
> index 87c3aff26589..085a09268e8a 100644
> --- a/arch/arm/dts/rk3568-generic.dts
> +++ b/arch/arm/dts/rk3568-generic.dts
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>   /*
> - * Minimal generic DT for RK3566/RK3568 with eMMC, SD-card and SPI flash enabled
> + * Minimal generic DT for RK3566/RK3568 with eMMC, SD-card, SPI flash and USB OTG enabled
>    */
>   
>   /dts-v1/;
> @@ -58,3 +58,20 @@
>   &uart2 {
>   	status = "okay";
>   };
> +
> +&usb_host0_xhci {
> +	dr_mode = "peripheral";
> +	extcon = <&usb2phy0>;
> +	maximum-speed = "high-speed";
> +	phys = <&usb2phy0_otg>;
> +	phy-names = "usb2-phy";
> +	status = "okay";
> +};
> +
> +&usb2phy0 {
> +	status = "okay";
> +};
> +
> +&usb2phy0_otg {
> +	status = "okay";
> +};
> diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
> index 9276eae63ee3..26114f9cb2a5 100644
> --- a/configs/generic-rk3568_defconfig
> +++ b/configs/generic-rk3568_defconfig
> @@ -31,6 +31,8 @@ CONFIG_SPL_ATF=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>   # CONFIG_CMD_SETEXPR is not set
>   # CONFIG_SPL_DOS_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
> @@ -40,6 +42,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
>   CONFIG_SPL_CLK=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_MISC=y
>   # CONFIG_ROCKCHIP_IODOMAIN is not set
> @@ -57,6 +60,7 @@ CONFIG_SPI_FLASH_SILICONKAISER=y
>   CONFIG_SPI_FLASH_WINBOND=y
>   CONFIG_SPI_FLASH_XMC=y
>   CONFIG_SPI_FLASH_XTX=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_SPL_PINCTRL=y
>   CONFIG_SPL_RAM=y
>   CONFIG_BAUDRATE=1500000
> @@ -64,4 +68,10 @@ CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_ROCKCHIP_SFC=y
>   CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
>   CONFIG_ERRNO_STR=y
