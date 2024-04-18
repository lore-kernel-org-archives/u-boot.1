Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5134BC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 23:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9508288648;
	Fri, 19 Apr 2024 01:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2230788662; Fri, 19 Apr 2024 01:07:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DE2C68837D
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 01:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F30772F;
 Thu, 18 Apr 2024 16:07:36 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 477733F738;
 Thu, 18 Apr 2024 16:07:08 -0700 (PDT)
Date: Fri, 19 Apr 2024 00:06:59 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: lhdjply@126.com
Cc: jagan@amarulasolutions.com, trini@konsulko.com, u-boot@lists.denx.de
Subject: Re: [PATCH] arm:suniv:complete the serial port configuration of Suniv
Message-ID: <20240419000659.39aa4573@minigeek.lan>
In-Reply-To: <20240313053323.282856-1-lhdjply@126.com>
References: <20240313053323.282856-1-lhdjply@126.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 13 Mar 2024 13:33:23 +0800
lhdjply@126.com wrote:

Hi,

> From: lhdjply <lhdjply@126.com>
> 
> 111

There should be a proper commit message here, explaining *why* this
patch is needed.
So what does this patch or which problem does it solve?

Please note that I consider those "SUNxx_GPy_UARTz" symbols nonsense,
since they do not carry real information. I thought about replacing all
those pinmux defines with something like SUNXI_PINMUX_x, defined to
x, so say: "#define SUNXI_PINMUX_5 5".
Does that sound better to you?

Cheers,
Andre

> 
> Signed-off-by: lhdjply <lhdjply@126.com>
> ---
>  arch/arm/mach-sunxi/board.c | 4 ++--
>  include/sunxi_gpio.h        | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
> index f4dbb2a740..b91c9629e4 100644
> --- a/arch/arm/mach-sunxi/board.c
> +++ b/arch/arm/mach-sunxi/board.c
> @@ -151,8 +151,8 @@ static int gpio_init(void)
>  	sunxi_gpio_set_cfgpin(SUNXI_GPE(3), 6);
>  	sunxi_gpio_set_pull(SUNXI_GPE(3), SUNXI_GPIO_PULL_UP);
>  #elif CONFIG_CONS_INDEX == 2 && defined(CONFIG_MACH_SUNIV)
> -	sunxi_gpio_set_cfgpin(SUNXI_GPA(2), SUNIV_GPE_UART0);
> -	sunxi_gpio_set_cfgpin(SUNXI_GPA(3), SUNIV_GPE_UART0);
> +	sunxi_gpio_set_cfgpin(SUNXI_GPA(2), SUNIV_GPA_UART1);
> +	sunxi_gpio_set_cfgpin(SUNXI_GPA(3), SUNIV_GPA_UART1);
>  	sunxi_gpio_set_pull(SUNXI_GPA(3), SUNXI_GPIO_PULL_UP);
>  #elif CONFIG_CONS_INDEX == 2 && defined(CONFIG_MACH_SUN5I)
>  	sunxi_gpio_set_cfgpin(SUNXI_GPG(3), SUN5I_GPG_UART1);
> diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
> index db3742c039..51258e3dd9 100644
> --- a/include/sunxi_gpio.h
> +++ b/include/sunxi_gpio.h
> @@ -108,6 +108,8 @@ enum sunxi_gpio_number {
>  #define SUN8I_H3_GPA_UART0	2
>  #define SUN8I_H3_GPA_UART2	2
>  
> +#define SUNIV_GPA_UART1		5
> +
>  #define SUN4I_GPB_PWM		2
>  #define SUN4I_GPB_TWI0		2
>  #define SUN4I_GPB_TWI1		2
> @@ -130,12 +132,16 @@ enum sunxi_gpio_number {
>  
>  #define SUNXI_GPD_LCD0		2
>  #define SUNXI_GPD_LVDS0		3
> +#define SUNIV_GPD_UART1		3
> +#define SUNIV_GPD_UART2		3
>  
>  #define SUNIV_GPE_UART0		5
> +#define SUNIV_GPE_UART2		3
>  
>  #define SUNXI_GPF_SDC0		2
>  #define SUNXI_GPF_UART0		4
>  #define SUN8I_GPF_UART0		3
> +#define SUNIV_GPF_UART0		3
>  
>  #define SUN4I_GPG_SDC1		4
>  #define SUN5I_GPG_SDC1		2

