Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7740ED44C76
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 16:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 813CD80325;
	Thu, 15 Jan 2026 17:14:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="X9ADEd7I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0350C82BF2; Thu, 15 Jan 2026 17:14:48 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1DB880077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 17:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 8431D1FA85;
 Thu, 15 Jan 2026 17:14:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1768493684;
 bh=1BExtbnU1I/YtfCnCMPzph0lZbXavW44xwgyIExmbFE=; h=From:To:Subject;
 b=X9ADEd7Iy2upGg0NRx3uhmY2JfivFWj7ely2PuTjWPDFKLpPRZHWOlMCqO5Li41UT
 h1uBQCngcwfPAwZOztKgYNgJfS/UOTW4HjAa01gAINT+33QQXo151q2Qfl2u7dPZOE
 jMYKQ9gRTFIhApHPl69/XcgVYdtSIj9C3tz2MaDhHAqeZXXfXnMPsIGfSF+11NApKK
 jeiQAlKK1sMihS83RsiyP6DtBhAUKGKsqmmb+rYZCBZSxzoIlXQNT9zt37G8M68PUY
 cepGPp4MF7c32Tq86JyQITCK+hRRd/zthQyvRt31prg2q47qnyCAV6Z0Ugjs20rZv5
 ZNjlR0b+GOy9Q==
Date: Thu, 15 Jan 2026 17:14:40 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 5/5] board: toradex: add splash screen to Toradex
 i.MX7D Colibri board
Message-ID: <20260115161440.GA93500@francesco-nb>
References: <20260115-repair_imx7_splash-v2-0-6595491341ba@bootlin.com>
 <20260115-repair_imx7_splash-v2-5-6595491341ba@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115-repair_imx7_splash-v2-5-6595491341ba@bootlin.com>
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

Hello,

On Thu, Jan 15, 2026 at 02:52:48PM +0100, Thomas Bonnefille wrote:
> Fixes the PWM<A> that was previously used as a GPIO output instead of a
> real PWM, it also reserve the framebuffer region to preserve the splash
> screen while the OS is booting.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  board/toradex/colibri_imx7/colibri_imx7.c | 41 +++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/board/toradex/colibri_imx7/colibri_imx7.c b/board/toradex/colibri_imx7/colibri_imx7.c
> index 69a8a18d3a7..55480213c67 100644
> --- a/board/toradex/colibri_imx7/colibri_imx7.c
> +++ b/board/toradex/colibri_imx7/colibri_imx7.c
> @@ -18,6 +18,7 @@
>  #include <asm/io.h>
>  #include <dm.h>
>  #include <dm/platform_data/serial_mxc.h>
> +#include <fdt_simplefb.h>
>  #include <fdt_support.h>
>  #include <fsl_esdhc_imx.h>
>  #include <jffs2/load_kernel.h>
> @@ -29,8 +30,10 @@
>  #include <netdev.h>
>  #include <power/pmic.h>
>  #include <power/rn5t567_pmic.h>
> +#include <pwm.h>
>  #include <usb.h>
>  #include <usb/ehci-ci.h>
> +#include <video.h>
>  #include "../common/tdx-common.h"
>  
>  DECLARE_GLOBAL_DATA_PTR;
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
> @@ -130,10 +135,15 @@ static int setup_lcd(void)
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
> +	if (ret)
> +		return ret;
> +	ret = pwm_enable(0);
> +	return ret;
>  }
>  #endif
>  
> @@ -142,12 +152,11 @@ static int setup_lcd(void)
>   */
>  void board_preboot_os(void)
>  {
> -#ifdef CONFIG_VIDEO
> -	gpio_direction_output(GPIO_PWM_A, 1);
> -	gpio_direction_output(GPIO_BL_ON, 0);
> -#endif
> +	if (IS_ENABLED(CONFIG_VIDEO) && IS_ENABLED(CONFIG_VIDEO_REMOVE)) {
> +		gpio_direction_output(GPIO_PWM_A, 1);
> +		gpio_direction_output(GPIO_BL_ON, 0);
> +	}

Is this correct now that PWM_A is not used as GPIO anymore? See
`backlight_pads`  ?


