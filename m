Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6580BC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 12:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0809687CD1;
	Wed,  1 Nov 2023 13:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D45A687C08; Wed,  1 Nov 2023 13:10:34 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 147BF87AEF
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 13:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EE692F4;
 Wed,  1 Nov 2023 05:11:10 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC8E63F67D;
 Wed,  1 Nov 2023 05:10:27 -0700 (PDT)
Date: Wed, 1 Nov 2023 12:10:25 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Samuel Holland <samuel@sholland.org>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH] net: sun8i_emac: Drop DM_GPIO checks
Message-ID: <20231101121025.45155f60@donnerap.manchester.arm.com>
In-Reply-To: <20231031052554.63319-1-samuel@sholland.org>
References: <20231031052554.63319-1-samuel@sholland.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Tue, 31 Oct 2023 00:25:46 -0500
Samuel Holland <samuel@sholland.org> wrote:

Hi,

> DM_GPIO is always enable in U-Boot proper for ARCH_SUNXI, and this
> driver is never enabled in SPL, so the condition is always true.

Yes indeed, the u-boot.bin binaries of all sunxi boards are identical with
and without this patch.

> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Who is going to take this, does this go via some network tree?

Thanks,
Andre

> ---
> 
>  drivers/net/sun8i_emac.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
> index 4ba9ee1529e..a12f7e32e8f 100644
> --- a/drivers/net/sun8i_emac.c
> +++ b/drivers/net/sun8i_emac.c
> @@ -168,9 +168,7 @@ struct emac_eth_dev {
>  	struct clk ephy_clk;
>  	struct reset_ctl tx_rst;
>  	struct reset_ctl ephy_rst;
> -#if CONFIG_IS_ENABLED(DM_GPIO)
>  	struct gpio_desc reset_gpio;
> -#endif
>  	struct udevice *phy_reg;
>  };
>  
> @@ -617,7 +615,6 @@ err_tx_clk:
>  	return ret;
>  }
>  
> -#if CONFIG_IS_ENABLED(DM_GPIO)
>  static int sun8i_mdio_reset(struct mii_dev *bus)
>  {
>  	struct udevice *dev = bus->priv;
> @@ -649,7 +646,6 @@ static int sun8i_mdio_reset(struct mii_dev *bus)
>  
>  	return 0;
>  }
> -#endif
>  
>  static int sun8i_mdio_init(const char *name, struct udevice *priv)
>  {
> @@ -664,9 +660,7 @@ static int sun8i_mdio_init(const char *name, struct udevice *priv)
>  	bus->write = sun8i_mdio_write;
>  	snprintf(bus->name, sizeof(bus->name), name);
>  	bus->priv = (void *)priv;
> -#if CONFIG_IS_ENABLED(DM_GPIO)
>  	bus->reset = sun8i_mdio_reset;
> -#endif
>  
>  	return  mdio_register(bus);
>  }
> @@ -783,9 +777,7 @@ static int sun8i_emac_eth_of_to_plat(struct udevice *dev)
>  	const fdt32_t *reg;
>  	int node = dev_of_offset(dev);
>  	int offset = 0;
> -#if CONFIG_IS_ENABLED(DM_GPIO)
>  	int reset_flags = GPIOD_IS_OUT;
> -#endif
>  	int ret;
>  
>  	pdata->iobase = dev_read_addr(dev);
> @@ -872,7 +864,6 @@ static int sun8i_emac_eth_of_to_plat(struct udevice *dev)
>  		printf("%s: Invalid RX delay value %d\n", __func__,
>  		       sun8i_pdata->rx_delay_ps);
>  
> -#if CONFIG_IS_ENABLED(DM_GPIO)
>  	if (fdtdec_get_bool(gd->fdt_blob, dev_of_offset(dev),
>  			    "snps,reset-active-low"))
>  		reset_flags |= GPIOD_ACTIVE_LOW;
> @@ -887,7 +878,6 @@ static int sun8i_emac_eth_of_to_plat(struct udevice *dev)
>  	} else if (ret == -ENOENT) {
>  		ret = 0;
>  	}
> -#endif
>  
>  	return 0;
>  }

