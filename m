Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6398AD1039D
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 11:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B1BE839A8;
	Wed, 26 Nov 2025 12:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="fTwSIuAC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE5D83E46; Wed, 26 Nov 2025 12:59:39 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39C0583966
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 12:59:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 26E101F92A;
 Wed, 26 Nov 2025 12:59:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1764158375;
 bh=OvUxBedo0FzsLRKdmHaD0EVqnhKRr3Amjb3FfkdZpWU=; h=From:To:Subject;
 b=fTwSIuACv7NQbGDyCzIsCN3B4gLXbGMto+98A9K1fGcA9TTOtxupKvmz/fmJqEx+g
 P6cIEq6uHw/ymJXvjhosjwBG/Lj30jQUOuOjmuXOgXWuDdRG71fy5Hh4fHLS2hcWDQ
 ROUqltoHJEY0sJ3+OUaa0V1HYzI+VfFXn9G9aaqDQLTezu4Y7ppmVD5alXShSjyNgq
 WoDZVpY4b+JR7OoHaqOheEDjMtq5swjQBsG1/kRPMp+RGfC/3LNu6mtLZVkaSORklo
 bmkAZTVeJ34qG/YRGxkLaA2yVPW5q4lp1ZXlcMnAFUSdKd0S0jds9OZ8nP2l1QhgEC
 8YY+gEEgr8zvA==
Date: Wed, 26 Nov 2025 12:59:31 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 5/5] board: toradex: add splash screen to Toradex i.MX7D
 Colibri board
Message-ID: <20251126115931.GA26872@francesco-nb>
References: <20251126-repair_imx7_splash-v1-0-d3877afb7381@bootlin.com>
 <20251126-repair_imx7_splash-v1-5-d3877afb7381@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126-repair_imx7_splash-v1-5-d3877afb7381@bootlin.com>
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

Hello Thomas,
thanks for your patch


On Wed, Nov 26, 2025 at 12:41:57AM +0100, Thomas Bonnefille wrote:
> This commit fixes the PWM<A> that was previously used as a GPIO output
> instead of a real PWM, it also reserve the framebuffer region to
> preserve the splash screen while the OS is booting.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>

From a quick look it seems ok to me, however ...

> ---
>  board/toradex/colibri_imx7/colibri_imx7.c | 40 +++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/board/toradex/colibri_imx7/colibri_imx7.c b/board/toradex/colibri_imx7/colibri_imx7.c
> index 69a8a18d3a7..b5d22337a04 100644
> --- a/board/toradex/colibri_imx7/colibri_imx7.c
> +++ b/board/toradex/colibri_imx7/colibri_imx7.c
> @@ -7,6 +7,8 @@
>  #include <env.h>
>  #include <init.h>
>  #include <net.h>
> +#include <fdt_simplefb.h>
> +#include <video.h>
>  #include <asm/arch/clock.h>
>  #include <asm/arch/crm_regs.h>
>  #include <asm/arch/imx-regs.h>
> @@ -29,6 +31,7 @@
>  #include <netdev.h>
>  #include <power/pmic.h>
>  #include <power/rn5t567_pmic.h>
> +#include <pwm.h>
>  #include <usb.h>
>  #include <usb/ehci-ci.h>
>  #include "../common/tdx-common.h"
> @@ -114,7 +117,7 @@ static iomux_v3_cfg_t const backlight_pads[] = {
>  	/* Backlight On */
>  	MX7D_PAD_SD1_WP__GPIO5_IO1 | MUX_PAD_CTRL(NO_PAD_CTRL),
>  	/* Backlight PWM<A> (multiplexed pin) */
> -	MX7D_PAD_GPIO1_IO08__GPIO1_IO8   | MUX_PAD_CTRL(NO_PAD_CTRL),
> +	MX7D_PAD_GPIO1_IO08__PWM1_OUT   | MUX_PAD_CTRL(NO_PAD_CTRL),
>  	MX7D_PAD_ECSPI2_MOSI__GPIO4_IO21 | MUX_PAD_CTRL(NO_PAD_CTRL),
>  };
>  
> @@ -123,6 +126,8 @@ static iomux_v3_cfg_t const backlight_pads[] = {
>  
>  static int setup_lcd(void)
>  {
> +	int ret = 0;
> +
>  	imx_iomux_v3_setup_multiple_pads(backlight_pads, ARRAY_SIZE(backlight_pads));
>  
>  	/* Set BL_ON */
> @@ -130,10 +135,14 @@ static int setup_lcd(void)
>  	gpio_direction_output(GPIO_BL_ON, 1);
>  
>  	/* Set PWM<A> to full brightness (assuming inversed polarity) */
> -	gpio_request(GPIO_PWM_A, "PWM<A>");
> -	gpio_direction_output(GPIO_PWM_A, 0);
> -
> -	return 0;
> +	enable_pwm_clk(1, 0);
> +	ret = pwm_init(0, 0, 0);
> +	if (ret)
> +		return ret;
> +	ret = pwm_config(0, 0, 6666666);

You are setting a period here for the PWM backlight (150Hz?),
considering that colibri imx7 is a SoM, e.g. there is no actual display
part of it, is this number generic enough?

Francesco


