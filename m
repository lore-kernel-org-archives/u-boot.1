Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44B2C369BD
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 04:23:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE95682A1C;
	Sat, 19 Apr 2025 06:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="o8cyAM6V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4483B82ADA; Sat, 19 Apr 2025 06:22:58 +0200 (CEST)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B81FE82A18
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 06:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4Zfdlc1jrBz9sRJ;
 Sat, 19 Apr 2025 04:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1745036572; bh=z010S4sHgZ12ICmxXkq5CmcToBV3WK7MzeZ7uoTEjVg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o8cyAM6ViRy3t72c04Mm7hlyM1cSXrBtbH8UgORR5UemywGg54RcDL22EJqy5fgkK
 2BjrQOK9ELwBEcRc/zoWTKXZ7sQkLb7FgHdph+S1i+1c0yKBKe3GeXgzDI2ionbsjx
 f9LmdeO9e0qfEjGmmZEorlZjiKg+mhFG8JAcjtgA=
X-Riseup-User-ID: 0838A62A503732770F79CCEEEC3BE0D28E791FC9BB0605302DC50DF953032226
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4ZfdlW3FfQzFsqH;
 Sat, 19 Apr 2025 04:22:46 +0000 (UTC)
Date: Sat, 19 Apr 2025 11:22:43 +0700
From: Dang Huynh <danct12@riseup.net>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Ondrej Jirman <megi@xff.cz>, Dragan Simic <dsimic@manjaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, Piotr Zalewski <pZ010001011111@proton.me>
Subject: Re: [PATCH v3 11/12] configs: pinetab2-rk3566: Enable video and USB
 keyboard
Message-ID: <aAMlE1Wzimw3U8b2@melt-pi5>
References: <20250412-vop2-pt2-v3-0-7c796db335e9@riseup.net>
 <20250412-vop2-pt2-v3-11-7c796db335e9@riseup.net>
 <6d852aca-dcc8-4098-9406-fc09738a205d@kwiboo.se>
 <Z_5fNUPHuDP1cPmC@melt-pi5>
 <e36d58f5-6a92-4080-9648-1583250cce37@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e36d58f5-6a92-4080-9648-1583250cce37@kwiboo.se>
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

On Tue, Apr 15, 2025 at 05:52:55PM +0200, Jonas Karlman wrote:
> On 2025-04-15 15:29, Dang Huynh wrote:
> > On Sun, Apr 13, 2025 at 05:26:03PM +0200, Jonas Karlman wrote:
> >> Hi,
> >>
> >> On 2025-04-12 16:27, Dang Huynh wrote:
> >>> Now that we have VOP2 support, let's enable it and support the
> >>> built in USB keyboard.
> >>>
> >>> Signed-off-by: Dang Huynh <danct12@riseup.net>
> >>> ---
> >>>  configs/pinetab2-rk3566_defconfig | 11 +++++++++++
> >>>  1 file changed, 11 insertions(+)
> >>>
> >>> diff --git a/configs/pinetab2-rk3566_defconfig b/configs/pinetab2-rk3566_defconfig
> >>> index 45e63b42d192dc172f24e071b09c8203675965d8..792ec0ec119437fd7a920558a149363c886c87de 100644
> >>> --- a/configs/pinetab2-rk3566_defconfig
> >>> +++ b/configs/pinetab2-rk3566_defconfig
> >>> @@ -57,6 +57,7 @@ CONFIG_BUTTON=y
> >>>  CONFIG_BUTTON_ADC=y
> >>>  CONFIG_BUTTON_GPIO=y
> >>>  CONFIG_SPL_CLK=y
> >>> +CONFIG_CLK_CCF=y
> >>
> >> Rockchip clk drivers does not use this, and I do not see any new clock
> >> driver being added in this series.
> >>
> >> Why is this needed?
> > I initially added this to get around clk_enable error, but it seems like
> > you don't need to enable VOP clocks.
> > 
> > However, I noticed that enabling CCF will give us clock rate that are
> > pretty close to how it's configured on Linux.
> 
> As mentioned on IRC with CCF enabled the clk enable() ops does not need
> to be enabled however without CFF the enable() ops must be enable or the
> set_parent() ops is just ignored.
> 
> So I expect the issue with different rates is that some clock is never
> changing parent as requested by DT or driver code.
> 
> Please try following diff with CCF disabled:
> 
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 4b3d812f9c65..93dd32ebe74d 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -624,7 +624,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
>  		return -ENOSYS;
>  
>  	ret = clk_enable(parent);
> -	if (ret) {
> +	if (ret && ret != -ENOSYS) {
>  		printf("Cannot enable parent %s\n", parent->dev->name);
>  		return ret;
>  	}
> 
> 
> Not sure this is a good solution or if it will be better to let the
> clk_rk3568.c driver just implement a dummy enable() ops.
> 
Applying the diff does appear to make the clock rate show up correctly
and the mentioned "Cannot enable parent" error disappeared.

Before:
rk_display_init(vop@fe040000): dclk_vp1 clkrate 73000000

After:
rk_display_init(vop@fe040000): dclk_vp1 clkrate 73428571

> Regards,
> Jonas
> 
> > 
> >>
> >> Regards,
> >> Jonas
> >>
> >>>  # CONFIG_USB_FUNCTION_FASTBOOT is not set
> >>>  CONFIG_ROCKCHIP_GPIO=y
> >>>  CONFIG_SYS_I2C_ROCKCHIP=y
> >>> @@ -69,6 +70,7 @@ CONFIG_MMC_SDHCI_SDMA=y
> >>>  CONFIG_MMC_SDHCI_ROCKCHIP=y
> >>>  CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> >>>  CONFIG_SPI_FLASH_SILICONKAISER=y
> >>> +CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
> >>>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> >>>  CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> >>>  CONFIG_SPL_PINCTRL=y
> >>> @@ -94,6 +96,7 @@ CONFIG_USB_OHCI_HCD=y
> >>>  CONFIG_USB_OHCI_GENERIC=y
> >>>  CONFIG_USB_DWC3=y
> >>>  CONFIG_USB_DWC3_GENERIC=y
> >>> +CONFIG_USB_KEYBOARD=y
> >>>  CONFIG_USB_HOST_ETHER=y
> >>>  CONFIG_USB_ETHER_ASIX=y
> >>>  CONFIG_USB_ETHER_ASIX88179=y
> >>> @@ -101,4 +104,12 @@ CONFIG_USB_ETHER_RTL8152=y
> >>>  CONFIG_USB_GADGET=y
> >>>  CONFIG_USB_GADGET_DOWNLOAD=y
> >>>  CONFIG_USB_FUNCTION_ROCKUSB=y
> >>> +CONFIG_VIDEO=y
> >>> +CONFIG_VIDEO_LCD_BOE_TH101MB31IG002_28A=y
> >>> +CONFIG_DISPLAY=y
> >>> +CONFIG_VIDEO_ROCKCHIP=y
> >>> +CONFIG_DISPLAY_ROCKCHIP_HDMI=y
> >>> +CONFIG_DISPLAY_ROCKCHIP_DW_MIPI=y
> >>> +CONFIG_VIDEO_BRIDGE=y
> >>> +CONFIG_VIDEO_REMOVE=y
> >>>  CONFIG_ERRNO_STR=y
> >>>
> >>
> 

Best regards,
Dang

