Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2349FC02183
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 14:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D275880141;
	Sun, 19 Jan 2025 15:09:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OueeQs1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF4FC801CF; Sun, 19 Jan 2025 15:09:00 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F33680085
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 15:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5378=UM=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1737295737;
 bh=vRhMgkuZmkccZPdH8MGp+aLXM06aPwAbWjSGxcyh1aE=;
 b=OueeQs1x5VtgnoOaJF2sF/8LKIYoL+9Jv9m3b9Ped7iAe2pj7A2WA3+J3dP+BGjJ2QezpCXb7
 EEQOW3odhskfc8cFrO6rM1MG6n7llFD5XJBJsLl1hF7hx3jxpC0JT0cd5RutqsaAPnAKNSKSNzr
 vItfGm5LYO6v2AG0fc6nZ1OG+VC3PfMisErqUa1Rd5grZQn1CWibc3uTxNDq3HNbv7ZdcdyPSKt
 ktg1feaQxRC94dfIkD5HGkOfVEGD6bNEG50Ydh8gKJRZ+jrrA09ncUd0uvumF0gV/raCT1oJBFf
 xR4zlO9B2FeVkxrqwOC7OKX83tD6OzBTrUPYvIUf5J4w==
X-Forward-Email-ID: 678d076b070b5f33f71af574
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <46543de3-e368-42d2-a42a-031f14b31d54@kwiboo.se>
Date: Sun, 19 Jan 2025 15:08:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] configs: pinetab2-rk3566: Enable video and USB
 keyboard
To: Dang Huynh <danct12@riseup.net>
Cc: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Ondrej Jirman <megi@xff.cz>, Dragan Simic <dsimic@manjaro.org>,
 u-boot@lists.denx.de
References: <20250116-vop2-pt2-v1-0-c9d646b53930@riseup.net>
 <20250116-vop2-pt2-v1-10-c9d646b53930@riseup.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250116-vop2-pt2-v1-10-c9d646b53930@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Dang,

On 2025-01-16 10:15, Dang Huynh wrote:
> Now that we have VOP2 support, let's enable it and support the
> built in USB keyboard.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>  configs/pinetab2-rk3566_defconfig | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/configs/pinetab2-rk3566_defconfig b/configs/pinetab2-rk3566_defconfig
> index 45e63b42d192dc172f24e071b09c8203675965d8..b250d8d12e9d5e045e28db4d455850f94514321f 100644
> --- a/configs/pinetab2-rk3566_defconfig
> +++ b/configs/pinetab2-rk3566_defconfig
> @@ -23,7 +23,10 @@ CONFIG_FIT_VERBOSE=y
>  CONFIG_SPL_FIT_SIGNATURE=y
>  CONFIG_SPL_LOAD_FIT=y
>  CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_USE_PREBOOT=y

Please try to avoid adding USE_PREBOOT because it will slow down boot by
several seconds thanks to it force running "usb start". For normal use
starting usb is typically not needed. We should try and delay usb start
until it is really needed.

>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-pinetab2-v2.0.dtb"
> +CONFIG_PRE_CONSOLE_BUFFER=y
> +CONFIG_SYS_CONSOLE_ENV_OVERWRITE=y
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>  CONFIG_SPL_MAX_SIZE=0x40000
> @@ -57,6 +60,8 @@ CONFIG_BUTTON=y
>  CONFIG_BUTTON_ADC=y
>  CONFIG_BUTTON_GPIO=y
>  CONFIG_SPL_CLK=y
> +CONFIG_CLK_CCF=y
> +CONFIG_CLK_COMPOSITE_CCF=y

Is CCF and COMPOSITE_CCF needed?

>  # CONFIG_USB_FUNCTION_FASTBOOT is not set
>  CONFIG_ROCKCHIP_GPIO=y
>  CONFIG_SYS_I2C_ROCKCHIP=y
> @@ -69,6 +74,7 @@ CONFIG_MMC_SDHCI_SDMA=y
>  CONFIG_MMC_SDHCI_ROCKCHIP=y
>  CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>  CONFIG_SPI_FLASH_SILICONKAISER=y
> +CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>  CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>  CONFIG_SPL_PINCTRL=y
> @@ -94,6 +100,7 @@ CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_GENERIC=y
>  CONFIG_USB_DWC3=y
>  CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_KEYBOARD=y
>  CONFIG_USB_HOST_ETHER=y
>  CONFIG_USB_ETHER_ASIX=y
>  CONFIG_USB_ETHER_ASIX88179=y
> @@ -101,4 +108,12 @@ CONFIG_USB_ETHER_RTL8152=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_DOWNLOAD=y
>  CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_VIDEO=y
> +CONFIG_CONSOLE_ROTATION=y
> +CONFIG_VIDEO_LCD_BOE_TH101MB31IG002_28A=y
> +CONFIG_DISPLAY=y
> +CONFIG_VIDEO_ROCKCHIP=y
> +CONFIG_DISPLAY_ROCKCHIP_HDMI=y
> +CONFIG_DISPLAY_ROCKCHIP_DW_MIPI=y
> +CONFIG_VIDEO_DT_SIMPLEFB=y

I do not see a simple-framebuffer compatible, is VIDEO_DT_SIMPLEFB
needed?

Regards,
Jonas

>  CONFIG_ERRNO_STR=y
> 

