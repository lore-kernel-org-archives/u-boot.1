Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBF2CEBF61
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 00:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA07283B91;
	Tue, 18 Nov 2025 01:57:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0162F83C16; Tue, 18 Nov 2025 01:57:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B9F8583AEF
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 01:57:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93761FEC;
 Mon, 17 Nov 2025 16:57:13 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 034313F66E;
 Mon, 17 Nov 2025 16:57:19 -0800 (PST)
Date: Tue, 18 Nov 2025 00:57:12 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Tom Rini
 <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, Paul
 Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 08/11] pinctrl: sunxi: a733: add initial support
Message-ID: <20251118005712.4722b766@minigeek.lan>
In-Reply-To: <20251116-01-a733-soc-support-v1-8-fb4c8db78e75@gentoo.org>
References: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
 <20251116-01-a733-soc-support-v1-8-fb4c8db78e75@gentoo.org>
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

On Sun, 16 Nov 2025 14:43:59 +0000
Yixun Lan <dlan@gentoo.org> wrote:

Hi,

> Introduce pinctrl driver for A733 SoC, but only limited devices are
> supported which includes GMAC, MMC, SPI, UART.
> 
> Setup an offset 0x80 for virtual PA port, as A733 changes the register
> layout, with this adjustment, all other ports can be found correctly.
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  drivers/pinctrl/sunxi/Kconfig         | 10 ++++++
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 57 +++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
> index 54314992299..0e48a71e8b5 100644
> --- a/drivers/pinctrl/sunxi/Kconfig
> +++ b/drivers/pinctrl/sunxi/Kconfig
> @@ -149,4 +149,14 @@ config PINCTRL_SUN55I_A523_R
>  	default MACH_SUN55I_A523
>  	select PINCTRL_SUNXI
>  
> +config PINCTRL_SUN60I_A733
> +	bool "Support for the Allwinner A733 PIO"
> +	default MACH_SUN60I_A733
> +	select PINCTRL_SUNXI
> +
> +config PINCTRL_SUN60I_A733_R
> +	bool "Support for the Allwinner A733 R-PIO"
> +	default MACH_SUN60I_A733
> +	select PINCTRL_SUNXI
> +
>  endif
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index fd357ab0d4e..c628109511e 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -197,6 +197,10 @@ static int sunxi_pinctrl_bind(struct udevice *dev)
>  
>  	plat->base = dev_read_addr_ptr(dev);
>  
> +	/* offset 0x80 as virtual PA port */
> +	if (device_is_compatible(dev, "allwinner,sun60i-a733-pinctrl"))
> +		plat->base += 0x80;

So this makes it obvious that this only works in U-Boot proper, but we
need a solution that works for both SPL and U-Boot proper. Also you
probably noticed that the R_PIO is still using the traditional layout,
something we cannot really model with the code as is today.

I came up with a solution to define all the pinctrl generation constants
separately for the R_PIO and normal PIO, then having something like
this (just for those two symbols, we would need more):

+/* The A733 combines a Gen3 main PIO block with a Gen2 R_PIO one (sigh!) */
+#ifdef CONFIG_MACH_SUN60I_A733
+       #define SUNXI_PINCTRL_R_BANK_SIZE       0x30
+       #define SUNXI_PIO_R_OFFSET              0x00
+#else
+       #define SUNXI_PINCTRL_R_BANK_SIZE       SUNXI_PINCTRL_BANK_SIZE
+       #define SUNXI_PIO_R_OFFSET              SUNXI_PIO_OFFSET
+#endif

Those two you can then use in sunxi_gpio.c like this:

 static void* BANK_TO_GPIO(int bank)
 {
        void *pio_base;
+       u32 bank_size;
 
        if (bank < SUNXI_GPIO_L) {
                pio_base = (void *)(uintptr_t)SUNXI_PIO_BASE;
+               pio_base += SUNXI_PIO_OFFSET;
+               bank_size = SUNXI_PINCTRL_BANK_SIZE;
        } else {
                pio_base = (void *)(uintptr_t)SUNXI_R_PIO_BASE;
+               pio_base += SUNXI_PIO_R_OFFSET;
+               bank_size = SUNXI_PINCTRL_R_BANK_SIZE;
                bank -= SUNXI_GPIO_L;
        }
-
-       return pio_base + bank * SUNXI_PINCTRL_BANK_SIZE;
+       return pio_base + bank * bank_size;

As mentioned, there is a bit more to do, but this should give you an
idea. Most changes would actually be in sunxi_gpio.c, so the pinctrl
driver does not need many changes.

Cheers,
Andre

> +
>  	ret = device_bind_driver_to_node(dev, "gpio_sunxi", dev->name,
>  					 dev_ofnode(dev), &gpio_dev);
>  	if (ret)
> @@ -782,6 +786,31 @@ static const struct sunxi_pinctrl_desc __maybe_unused sun55i_a523_pinctrl_desc =
>  	.num_banks	= 11,
>  };
>  
> +static const struct sunxi_pinctrl_function sun60i_a733_pinctrl_functions[] = {
> +	{ "gpio_in",	0 },
> +	{ "gpio_out",	1 },
> +	{ "gmac0",	5 },	/* PH0-PH15 */
> +	{ "gmac1",	5 },	/* PJ0-PJ15 */
> +	{ "mmc0",	2 },	/* PF0-PF5 */
> +	{ "mmc1",	2 },	/* PG0-PG5 */
> +	{ "mmc2",	3 },	/* PC0, PC1, PC5, PC6, PC8-PC11, PC13-PC16 */
> +	{ "mmc3",	4 },	/* PC0, PC1, PC5, PC6, PC8-PC11, PC13-PC16 */
> +	{ "spi0",	5 },	/* PC2-PC4, PC7, PC12 */
> +#if IS_ENABLED(CONFIG_UART0_PORT_F)
> +	{ "uart0",	3 },	/* PF2, PF4 */
> +#else
> +	{ "uart0",	2 },	/* PB9, PB10 */
> +#endif
> +	{ "uart1",	2 },	/* PG6, PG7 */
> +};
> +
> +static const struct sunxi_pinctrl_desc __maybe_unused sun60i_a733_pinctrl_desc = {
> +	.functions	= sun60i_a733_pinctrl_functions,
> +	.num_functions	= ARRAY_SIZE(sun60i_a733_pinctrl_functions),
> +	.first_bank	= SUNXI_GPIO_A,
> +	.num_banks	= 11,
> +};
> +
>  static const struct sunxi_pinctrl_function sun50i_h616_r_pinctrl_functions[] = {
>  	{ "gpio_in",	0 },
>  	{ "gpio_out",	1 },
> @@ -847,6 +876,21 @@ static const struct sunxi_pinctrl_desc __maybe_unused sun55i_a523_r_pinctrl_desc
>  	.num_banks	= 2,
>  };
>  
> +static const struct sunxi_pinctrl_function sun60i_a733_r_pinctrl_functions[] = {
> +	{ "gpio_in",	0 },
> +	{ "gpio_out",	1 },
> +	{ "r_i2c0",	2 },	/* PL0-PL1 */
> +	{ "r_uart0",	3 },	/* PL2-PL3 */
> +	{ "r_uart1",	2 },	/* PL2-PL3 */
> +};
> +
> +static const struct sunxi_pinctrl_desc __maybe_unused sun60i_a733_r_pinctrl_desc = {
> +	.functions	= sun60i_a733_r_pinctrl_functions,
> +	.num_functions	= ARRAY_SIZE(sun60i_a733_r_pinctrl_functions),
> +	.first_bank	= SUNXI_GPIO_L,
> +	.num_banks	= 2,
> +};
> +
>  static const struct udevice_id sunxi_pinctrl_ids[] = {
>  #ifdef CONFIG_PINCTRL_SUNIV_F1C100S
>  	{
> @@ -1034,6 +1078,19 @@ static const struct udevice_id sunxi_pinctrl_ids[] = {
>  		.data = (ulong)&sun55i_a523_r_pinctrl_desc,
>  	},
>  #endif
> +
> +#ifdef CONFIG_PINCTRL_SUN60I_A733
> +	{
> +		.compatible = "allwinner,sun60i-a733-pinctrl",
> +		.data = (ulong)&sun60i_a733_pinctrl_desc,
> +	},
> +#endif
> +#ifdef CONFIG_PINCTRL_SUN60I_A733_R
> +	{
> +		.compatible = "allwinner,sun60i-a733-r-pinctrl",
> +		.data = (ulong)&sun60i_a733_r_pinctrl_desc,
> +	},
> +#endif
>  	{}
>  };
>  
> 

