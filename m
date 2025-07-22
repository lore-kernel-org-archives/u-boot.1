Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F07EC83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 00:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86523836F0;
	Tue, 22 Jul 2025 02:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85F5683738; Tue, 22 Jul 2025 02:34:06 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 725FD832AD
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 02:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 248961595;
 Mon, 21 Jul 2025 17:33:57 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EA863F66E;
 Mon, 21 Jul 2025 17:34:01 -0700 (PDT)
Date: Tue, 22 Jul 2025 01:32:00 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Mikhail Kalashnikov
 <iuncuim@gmail.com>, Yixun Lan <dlan@gentoo.org>, Paul Kocialkowski
 <paulk@sys-base.io>, linux-sunxi@lists.linux.dev, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v2 09/20] sunxi: mmc: add support for Allwinner A523 MMC
 mod clock
Message-ID: <20250722013200.25622e40@minigeek.lan>
In-Reply-To: <20250717235455.32528-10-andre.przywara@arm.com>
References: <20250717235455.32528-1-andre.przywara@arm.com>
 <20250717235455.32528-10-andre.przywara@arm.com>
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

On Fri, 18 Jul 2025 00:54:44 +0100
Andre Przywara <andre.przywara@arm.com> wrote:

> The Allwinner A523 SoC has a slightly changed mod clock, where the P
> factor, formerly a shift value, is now a second divider value.
> Also the input clock is not PLL_PERIPH0_2X (1200MHz) anymore, but
> PLL_PERIPH0_400M, so adjust the input rate calculation accordingly.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/mmc/sunxi_mmc.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
> index 06c1e09bf26..7c85030be16 100644
> --- a/drivers/mmc/sunxi_mmc.c
> +++ b/drivers/mmc/sunxi_mmc.c
> @@ -99,6 +99,15 @@ static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int hz)
>  		 */
>  		if (IS_ENABLED(CONFIG_MACH_SUN8I_R528))
>  			pll_hz /= 2;
> +
> +		/*
> +		 * The A523/T527 uses PERIPH0_400M as the MMC input clock,
> +		 * which is the PERIPH0 nominal rate (1200MHz) / 3.

As Yixun figured correctly, a recent patch fixed the PLL PERIPH0 clock
calculation for NCAT2 chips, so the routine reports 600 MHz, to stay
compatible with older SoCs. So the divider here must be 3, really, not
6.
But this is only half the truth, since for MMC2 the base clock is
PLL_PERIPH0_800M, so we must multiply this by 2 again afterwards, to
reach the proper eMMC frequency.

Fixed in my tree.

Cheers,
Andre

> +		 * Together with the fixed post-divider of 2 of the MMC mod
> +		 * clock, that gives a divider of 6.
> +		 */
> +		if (IS_ENABLED(CONFIG_MACH_SUN55I_A523))
> +			pll_hz /= 6;
>  	}
>  
>  	div = pll_hz / hz;
> @@ -153,6 +162,10 @@ static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int hz)
>  			CCM_MMC_CTRL_SCLK_DLY(sclk_dly);
>  	}
>  
> +	/* The A523 has a second divider, not a shift. */
> +	if (IS_ENABLED(CONFIG_MACH_SUN55I_A523))
> +		n = (1U << n) - 1;
> +
>  	writel(CCM_MMC_CTRL_ENABLE| pll | CCM_MMC_CTRL_N(n) |
>  	       CCM_MMC_CTRL_M(div) | val, priv->mclkreg);
>  
> @@ -559,7 +572,8 @@ struct mmc *sunxi_mmc_init(int sdc_no)
>  	cfg->host_caps = MMC_MODE_4BIT;
>  
>  	if ((IS_ENABLED(CONFIG_MACH_SUN50I) || IS_ENABLED(CONFIG_MACH_SUN8I) ||
> -	    IS_ENABLED(CONFIG_SUN50I_GEN_H6)) && (sdc_no == 2))
> +	    IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_MACH_SUN55I_A523)) &&
> +	    (sdc_no == 2))
>  		cfg->host_caps = MMC_MODE_8BIT;
>  
>  	cfg->host_caps |= MMC_MODE_HS_52MHz | MMC_MODE_HS;

