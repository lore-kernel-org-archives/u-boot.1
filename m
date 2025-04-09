Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435D6C36010
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 02:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BDD281F7B;
	Wed,  9 Apr 2025 04:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC89D81E1F; Wed,  9 Apr 2025 04:23:13 +0200 (CEST)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69AEB81E1F
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 04:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.27.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id C2748343221;
 Wed, 09 Apr 2025 02:23:07 +0000 (UTC)
Date: Wed, 9 Apr 2025 02:23:03 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] sunxi: add "fake" FEL pin support
Message-ID: <20250409022303-GYA17019@gentoo>
References: <20250408235959.10720-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408235959.10720-1-andre.przywara@arm.com>
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

Hi Andre Przywara:

I can understand the motivation behind this patch, which
I think it's a good addition to BROM FEL mode..

On 00:59 Wed 09 Apr     , Andre Przywara wrote:
> Some boards with Allwinner SoCs feature a "FEL" key, sometimes also
> labelled "uboot", which triggers the BootROM FEL mode, when pressed upon
> power-on or reset. This allows to access the SoC's memory via USB OTG,
> and to upload and execute code. There is a tool to upload our U-Boot image
> and immediately boot it, when the SoC is in FEL mode.
> 
> To mimic this convenient behaviour on boards without such a dedicated key,
> we can query a GPIO pin very early in the SPL boot, then trigger the
> BootROM FEL routine.  There has not been much of a SoC or board setup at
> this point, so we enter the BROM in a rather pristine state still. On
> 64-bit SoCs the required AArch32 reset guarantees a clean CPU state anyway.
> 
> Any GPIO can be used for that, and a board (or a user) is expected to
> specify the GPIO name using the CONFIG_SUNXI_FAKE_FEL_PIN Kconfig variable.
> When this variable is not set, the compiler will optimise away the call.
> 
is it possible to provide a dts interface to specify the gpio pin?
it would be more convenient, but a CONFIG option would be fine..

> Call the code first thing in board_init_f(), which is the first sunxi
> specific C routine.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/mach-sunxi/Kconfig |  9 +++++++++
>  arch/arm/mach-sunxi/board.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 25b47ada7ad..912d3a3a650 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -789,6 +789,15 @@ config MMC_SUNXI_SLOT_EXTRA
>  	slot or emmc on mmc1 - mmc3. Setting this to 1, 2 or 3 will enable
>  	support for this.
>  
> +config SUNXI_FAKE_FEL_PIN
> +	string "fake FEL GPIO pin"
> +	default ""
> +	---help---
> +	Define a GPIO that shall force entering FEL mode when a button
> +	connected to this pin is pressed at boot time.
> +	This takes a string in the format understood by sunxi_name_to_gpio,
> +	e.g. PH1 for pin 1 of port H.
> +
>  config I2C0_ENABLE
>  	bool "Enable I2C/TWI controller 0"
>  	default y if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I_R40
> diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
> index 701899ee4b2..ea0e7bb381d 100644
> --- a/arch/arm/mach-sunxi/board.c
> +++ b/arch/arm/mach-sunxi/board.c
> @@ -457,8 +457,38 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>  	return result;
>  }
>  
> +static void check_fake_fel_button(void)
> +{
> +	u32 brom_entry = 0x20;
> +	int pin, value, mux;
> +
> +	/* check for empty string at compile time */
> +	if (sizeof(CONFIG_SUNXI_FAKE_FEL_PIN) == sizeof(""))
> +		return;
> +
> +	pin = sunxi_name_to_gpio(CONFIG_SUNXI_FAKE_FEL_PIN);
> +	if (pin < 0)
> +		return;
> +
> +	mux = sunxi_gpio_get_cfgpin(pin);
> +	sunxi_gpio_set_cfgpin(pin, SUNXI_GPIO_INPUT);
> +	value = gpio_get_value(pin);
> +	sunxi_gpio_set_cfgpin(pin, mux);
> +
> +	if (value)
> +		return;
so will skip EFL mode when "GPIO == 1" (which means gpio high level)?
maybe we should document in the Kconfig help section:
 setting GPIO low to enter FEL mode
or even great if the gpio can be configurable for FEL mode

> +
> +	/* Older SoCs maps the BootROM high in the address space. */
> +	if (fel_stash.sctlr & BIT(13))
> +		brom_entry |= 0xffff0000;
> +
> +	return_to_fel(0, brom_entry);
> +}
> +
>  void board_init_f(ulong dummy)
>  {
> +	check_fake_fel_button();
> +
>  	sunxi_sram_init();
>  
>  	/* Enable non-secure access to some peripherals */
> -- 
> 2.46.3
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
