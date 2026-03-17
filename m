Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4760BF33817
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 08:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD9284172;
	Tue, 17 Mar 2026 09:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DB0484175; Tue, 17 Mar 2026 09:50:08 +0100 (CET)
Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96E918416C
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 09:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62H8ntd3058348;
 Tue, 17 Mar 2026 16:49:55 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Mar
 2026 16:49:55 +0800
Date: Tue, 17 Mar 2026 16:49:52 +0800
From: Leo Liang <ycliang@andestech.com>
To: Uros Stajic <uros.stajic@htecgroup.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu <cfu@mips.com>
Subject: Re: [PATCH v5 6/8] net: pch_gbe: Add PHY reset and MAC address
 fallback for RISC-V
Message-ID: <abkVsH2JESBRsnvD@swlinux02>
References: <20251224154449.946780-1-uros.stajic@htecgroup.com>
 <20251224154449.946780-7-uros.stajic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251224154449.946780-7-uros.stajic@htecgroup.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62H8ntd3058348
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

On Wed, Dec 24, 2025 at 03:47:02PM +0000, Uros Stajic wrote:
> From: Chao-ying Fu <cfu@mips.com>
> 
> Add optional PHY reset support via GPIO defined in the device tree.
> 
> Improve robustness by handling probe errors and falling back to the
> environment-provided MAC address if no hardware MAC is found.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
> ---
>  board/mips/boston-riscv/Kconfig |  4 ++++
>  drivers/net/pch_gbe.c           | 37 +++++++++++++++++++++++++++++++--
>  drivers/net/pch_gbe.h           |  1 +
>  3 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/board/mips/boston-riscv/Kconfig b/board/mips/boston-riscv/Kconfig
> index 68c5fc50489..4d55d96603e 100644
> --- a/board/mips/boston-riscv/Kconfig
> +++ b/board/mips/boston-riscv/Kconfig
> @@ -40,4 +40,8 @@ config PHY_REALTEK
>      bool
>      default y
>  
> +config TFTP_FILE_NAME_MAX_LEN
> +    int "Maximum length of TFTP file name"
> +    default 256
> +
>  endif
> diff --git a/drivers/net/pch_gbe.c b/drivers/net/pch_gbe.c
> index adeca3d040d..dea8ab828ac 100644
> --- a/drivers/net/pch_gbe.c
> +++ b/drivers/net/pch_gbe.c
> @@ -7,6 +7,7 @@
>  
>  #include <cpu_func.h>
>  #include <dm.h>
> +#include <env.h>
>  #include <errno.h>
>  #include <log.h>
>  #include <malloc.h>
> @@ -15,6 +16,7 @@
>  #include <miiphy.h>
>  #include <linux/delay.h>
>  #include "pch_gbe.h"
> +#include <asm/gpio.h>

This should be <asm-generic/gpio.h>, right?

>  
>  #if !defined(CONFIG_PHYLIB)
>  # error "PCH Gigabit Ethernet driver requires PHYLIB - missing CONFIG_PHYLIB"
> @@ -33,6 +35,13 @@ static void pch_gbe_mac_read(struct pch_gbe_regs *mac_regs, u8 *addr)
>  	macid_lo = readl(&mac_regs->mac_adr[0].low) & 0xffff;
>  	debug("pch_gbe: macid_hi %#x macid_lo %#x\n", macid_hi, macid_lo);
>  
> +	if (!macid_lo && !macid_hi) {
> +		if (eth_env_get_enetaddr("ethaddr", addr))
> +			return;
> +
> +		printf("No MAC found in either EG20T H/W or environment");
> +	}
> +
>  	addr[0] = (u8)(macid_hi & 0xff);
>  	addr[1] = (u8)((macid_hi >> 8) & 0xff);
>  	addr[2] = (u8)((macid_hi >> 16) & 0xff);
> @@ -74,6 +83,14 @@ static int pch_gbe_reset(struct udevice *dev)
>  	priv->rx_idx = 0;
>  	priv->tx_idx = 0;
>  
> +	if (dm_gpio_is_valid(&priv->gpio_phy_reset)) {
> +		/* Reset the PHY */
> +		dm_gpio_set_value(&priv->gpio_phy_reset, 1);
> +		udelay(15000);
> +		dm_gpio_set_value(&priv->gpio_phy_reset, 0);
> +		udelay(5000);
> +	}
> +
>  	writel(PCH_GBE_ALL_RST, &mac_regs->reset);
>  
>  	/*
> @@ -450,6 +467,11 @@ static int pch_gbe_probe(struct udevice *dev)
>  	plat->iobase = (ulong)iobase;
>  	priv->mac_regs = (struct pch_gbe_regs *)iobase;
>  
> +	err = gpio_request_by_name(dev, "phy-reset-gpios", 0,
> +				   &priv->gpio_phy_reset, GPIOD_IS_OUT);
> +	if (err && (err != -ENOENT))
> +		return err;
> +
>  	/* Read MAC address from SROM and initialize dev->enetaddr with it */
>  	pch_gbe_mac_read(priv->mac_regs, plat->enetaddr);
>  
> @@ -459,9 +481,17 @@ static int pch_gbe_probe(struct udevice *dev)
>  
>  	err = pch_gbe_reset(dev);
>  	if (err)
> -		return err;
> +		goto out_err;
> +
> +	err = pch_gbe_phy_init(dev);
> +	if (err)
> +		goto out_err;
>  
> -	return pch_gbe_phy_init(dev);
> +	return 0;
> +out_err:
> +	if (dm_gpio_is_valid(&priv->gpio_phy_reset))
> +		dm_gpio_free(dev, &priv->gpio_phy_reset);
> +	return err;
>  }
>  
>  static int pch_gbe_remove(struct udevice *dev)
> @@ -472,6 +502,9 @@ static int pch_gbe_remove(struct udevice *dev)
>  	mdio_unregister(priv->bus);
>  	mdio_free(priv->bus);
>  
> +	if (dm_gpio_is_valid(&priv->gpio_phy_reset))
> +		dm_gpio_free(dev, &priv->gpio_phy_reset);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/net/pch_gbe.h b/drivers/net/pch_gbe.h
> index 7e0fdbfd5a3..dcbb94094bc 100644
> --- a/drivers/net/pch_gbe.h
> +++ b/drivers/net/pch_gbe.h
> @@ -292,6 +292,7 @@ struct pch_gbe_priv {
>  	struct udevice *dev;
>  	int rx_idx;
>  	int tx_idx;
> +	struct gpio_desc gpio_phy_reset;
>  };
>  
>  #endif /* _PCH_GBE_H_ */
