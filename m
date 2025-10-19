Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5868CCD195
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 09:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27423836D2;
	Sun, 19 Oct 2025 11:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="c1SIrnN1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A8F283835; Sun, 19 Oct 2025 11:23:44 +0200 (CEST)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3408836D1
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 11:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
Date: Sun, 19 Oct 2025 11:23:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1760865821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RiFX5Hc/Vmif7GNlcwbGKytNc2DWwMhDkPYR4PXMCO0=;
 b=c1SIrnN1pwD/zQpMrQTdrbU05U3h+pe5eIyQXWOKY+xWavdy/uzvyFeAc/IGMQckYGfhpZ
 L1jBHDnWhAxoi8GyZ2PEUfCR+p3Ks/+4b6Kr9GFX6sEhOWRli9Lo/IwdeFVHtma6/H7UGW
 J0uvw3Z6/pjNi3n+pscCSpA1rJBsIFk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Henrik Grimler <henrik@grimler.se>
To: Lukas Timmermann <uboot@timmermann.space>
Cc: u-boot@lists.denx.de
Subject: Re: [RFC PATCH 1/2] gpio: s5p_gpio: Add config option for s5p_gpio
 driver
Message-ID: <20251019092335.GA88117@l14.localdomain>
References: <20251013231542.821799-1-uboot@timmermann.space>
 <20251013231542.821799-2-uboot@timmermann.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013231542.821799-2-uboot@timmermann.space>
X-Migadu-Flow: FLOW_OUT
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

Hi Lukas,

On Tue, Oct 14, 2025 at 01:14:01AM +0200, Lukas Timmermann wrote:
> This config option is required to make use of a newer pinctrl driver on
> exynos 5 platforms. It is enabled per default to ensure older devices
> can still use this driver.
> 
> Signed-off-by: Lukas Timmermann <uboot@timmermann.space>
> ---
> 
>  arch/arm/mach-exynos/pinmux.c | 18 ++++++++++++++++++
>  drivers/gpio/Kconfig          |  7 +++++++
>  drivers/gpio/Makefile         |  2 +-
>  3 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/pinmux.c b/arch/arm/mach-exynos/pinmux.c
> index 48c325190d5..77c831b8684 100644
> --- a/arch/arm/mach-exynos/pinmux.c
> +++ b/arch/arm/mach-exynos/pinmux.c
> @@ -934,3 +934,21 @@ int pinmux_decode_periph_id(const void *blob, int node)
>  	return PERIPH_ID_NONE;
>  }
>  #endif
> +
> +#if !CONFIG_IS_ENABLED(S5P_GPIO)
> +
> +/* Add stub functions if s5p_gpio driver isn't enabled */
> +
> +void gpio_set_pull(int pin, int pull)
> +{
> +}
> +
> +void gpio_set_drv(int pin, int drv)
> +{
> +}
> +
> +void gpio_cfg_pin(int pin, int cfg)
> +{
> +}
> +
> +#endif
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 58e464106a3..2c09fb7a65d 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -724,5 +724,12 @@ config MPFS_GPIO
>  	depends on DM_GPIO
>  	help
>  		Enable to support the GPIO driver on Polarfire SoC
> +config S5P_GPIO
> +	default y
> +	bool "Samsung S5P GPIO driver"
> +	depends on DM_GPIO && S5P
> +	help
> +	  Support GPIO controllers on Samsung Exynos 5 family of SoCs.

S5P has more members than just Exynos 5, in fact it seems like most
Exynos processors also have an S5Pxxxx name. Please make the
description more general, as the driver is used by not only Exynos 5.

> +	  This driver doesn't support upstream Linux device tree bindings.

Nitpick: AFAIK, as a non native speaker, "doesn't" is conversational /
informal, and the long form 'does not' should be preferred in written
English.

Best regards,
Henrik Grimler

>  
>  endif
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 83e10c79b91..5555ed27b14 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -35,7 +35,7 @@ obj-$(CONFIG_PCA953X)		+= pca953x.o
>  obj-$(CONFIG_ROCKCHIP_GPIO)	+= rk_gpio.o
>  obj-$(CONFIG_RCAR_GPIO)		+= gpio-rcar.o
>  obj-$(CONFIG_RZA1_GPIO)		+= gpio-rza1.o
> -obj-$(CONFIG_S5P)		+= s5p_gpio.o
> +obj-$(CONFIG_S5P_GPIO)		+= s5p_gpio.o
>  obj-$(CONFIG_SANDBOX_GPIO)	+= sandbox.o sandbox_test.o
>  obj-$(CONFIG_TEGRA_GPIO)	+= tegra_gpio.o
>  obj-$(CONFIG_TEGRA186_GPIO)	+= tegra186_gpio.o
> -- 
> 2.51.0
> 
