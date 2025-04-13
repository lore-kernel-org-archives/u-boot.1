Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A92FC3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 15:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FC6982932;
	Sun, 13 Apr 2025 17:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="dIVDJDAB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2569B829E4; Sun, 13 Apr 2025 17:26:15 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EE9C800B3
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 17:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b5c5=XA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744557970;
 bh=7rot6UTgKlVPRdYNiOgrauvRAcAaOQraSS5RpE5dSbc=;
 b=dIVDJDABvUNV3G88FMxxo8rD54muAOghkUQQXeAmjeBMANkKR9EmrYN+pktn3fXN75v6pTFcD
 yxiuAEWF1OU5TtZMZ89dvPzriSsC3yPSzzTl320cK6H0uAixj84kOoBMl027zaPpy4WDL4puAGi
 AOESVaN0eMEViw8vTE0aww+jyIir8zANlCXJOiKfs1Ie0yyCjx1NYzvF0OhOyFiud6tF/dFDuSs
 rZAFVsstB7LK09byKw/qqjeqJxO0MMTHQPs8YKApcFtoc3pNzozya2772K249uGkwL44umKhohy
 /Acs1fo41gqP2BrVyPQsYupr2c5zWec+MhTNsL0c7VBw==
X-Forward-Email-ID: 67fbd7907cfcd77aa7dc3cc5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <6d852aca-dcc8-4098-9406-fc09738a205d@kwiboo.se>
Date: Sun, 13 Apr 2025 17:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] configs: pinetab2-rk3566: Enable video and USB
 keyboard
To: Dang Huynh <danct12@riseup.net>
Cc: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Ondrej Jirman <megi@xff.cz>, Dragan Simic <dsimic@manjaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Piotr Zalewski <pZ010001011111@proton.me>
References: <20250412-vop2-pt2-v3-0-7c796db335e9@riseup.net>
 <20250412-vop2-pt2-v3-11-7c796db335e9@riseup.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250412-vop2-pt2-v3-11-7c796db335e9@riseup.net>
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

Hi,

On 2025-04-12 16:27, Dang Huynh wrote:
> Now that we have VOP2 support, let's enable it and support the
> built in USB keyboard.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>  configs/pinetab2-rk3566_defconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/configs/pinetab2-rk3566_defconfig b/configs/pinetab2-rk3566_defconfig
> index 45e63b42d192dc172f24e071b09c8203675965d8..792ec0ec119437fd7a920558a149363c886c87de 100644
> --- a/configs/pinetab2-rk3566_defconfig
> +++ b/configs/pinetab2-rk3566_defconfig
> @@ -57,6 +57,7 @@ CONFIG_BUTTON=y
>  CONFIG_BUTTON_ADC=y
>  CONFIG_BUTTON_GPIO=y
>  CONFIG_SPL_CLK=y
> +CONFIG_CLK_CCF=y

Rockchip clk drivers does not use this, and I do not see any new clock
driver being added in this series.

Why is this needed?

Regards,
Jonas

>  # CONFIG_USB_FUNCTION_FASTBOOT is not set
>  CONFIG_ROCKCHIP_GPIO=y
>  CONFIG_SYS_I2C_ROCKCHIP=y
> @@ -69,6 +70,7 @@ CONFIG_MMC_SDHCI_SDMA=y
>  CONFIG_MMC_SDHCI_ROCKCHIP=y
>  CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>  CONFIG_SPI_FLASH_SILICONKAISER=y
> +CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>  CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>  CONFIG_SPL_PINCTRL=y
> @@ -94,6 +96,7 @@ CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_GENERIC=y
>  CONFIG_USB_DWC3=y
>  CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_KEYBOARD=y
>  CONFIG_USB_HOST_ETHER=y
>  CONFIG_USB_ETHER_ASIX=y
>  CONFIG_USB_ETHER_ASIX88179=y
> @@ -101,4 +104,12 @@ CONFIG_USB_ETHER_RTL8152=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_DOWNLOAD=y
>  CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_VIDEO=y
> +CONFIG_VIDEO_LCD_BOE_TH101MB31IG002_28A=y
> +CONFIG_DISPLAY=y
> +CONFIG_VIDEO_ROCKCHIP=y
> +CONFIG_DISPLAY_ROCKCHIP_HDMI=y
> +CONFIG_DISPLAY_ROCKCHIP_DW_MIPI=y
> +CONFIG_VIDEO_BRIDGE=y
> +CONFIG_VIDEO_REMOVE=y
>  CONFIG_ERRNO_STR=y
> 

