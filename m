Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22DDFA3725
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 00:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61DF5841BC;
	Fri,  2 Jan 2026 01:42:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76F13841F4; Fri,  2 Jan 2026 01:42:18 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6C14B841CC
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 01:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED5F6497;
 Thu,  1 Jan 2026 16:42:08 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21A603F694;
 Thu,  1 Jan 2026 16:42:13 -0800 (PST)
Date: Fri, 2 Jan 2026 01:41:24 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev, Jagan Teki
 <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Paul Kocialkowski <contact@paulk.fr>, Samuel
 Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 10/10] sunxi: mmc: enable support for A733
Message-ID: <20260102014124.3b35207c@minigeek.lan>
In-Reply-To: <20251130-01-a733-soc-support-v2-10-18bdd4376fad@gentoo.org>
References: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
 <20251130-01-a733-soc-support-v2-10-18bdd4376fad@gentoo.org>
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

On Sun, 30 Nov 2025 21:45:19 +0000
Yixun Lan <dlan@gentoo.org> wrote:

> Minor clock adjustment for new A733 MMC controller, the SMHC0_CLK_REG
> start at offset 0x400, and with step size of 0x10.
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  drivers/mmc/sunxi_mmc.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
> index e28c81afffe..689bec6693c 100644
> --- a/drivers/mmc/sunxi_mmc.c
> +++ b/drivers/mmc/sunxi_mmc.c
> @@ -112,6 +112,9 @@ static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int hz)
>  			if (priv->mmc_no == 2)
>  				pll_hz *= 2;
>  		}
> +
> +		if (IS_ENABLED(CONFIG_MACH_SUN60I_A733))
> +			pll_hz /= 3;
>  	}
>  
>  	div = pll_hz / hz;
> @@ -167,7 +170,8 @@ static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int hz)
>  	}
>  
>  	/* The A523 has a second divider, not a shift. */
> -	if (IS_ENABLED(CONFIG_MACH_SUN55I_A523))
> +	if (IS_ENABLED(CONFIG_MACH_SUN55I_A523) ||
> +		IS_ENABLED(CONFIG_MACH_SUN60I_A733))
>  		n = (1U << n) - 1;
>  
>  	writel(CCM_MMC_CTRL_ENABLE| pll | CCM_MMC_CTRL_N(n) |
> @@ -661,17 +665,28 @@ static const struct dm_mmc_ops sunxi_mmc_ops = {
>  	.get_cd		= sunxi_mmc_getcd,
>  };
>  
> -static unsigned get_mclk_offset(void)
> +static unsigned int get_mclk_offset(void)
>  {
>  	if (IS_ENABLED(CONFIG_MACH_SUN9I_A80))
>  		return 0x410;
>  
> +	if (IS_ENABLED(CONFIG_MACH_SUN60I_A733))
> +		return 0xd00;
> +
>  	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
>  		return 0x830;
>  
>  	return 0x88;
>  };
>  
> +static unsigned int get_mclk_size(void)

Can you please fold this function into the one above, passing in the
MMC controller number?
static unsigned int get_mclk_offset(int mmc_no);

Thanks,
Andre

> +{
> +	if (IS_ENABLED(CONFIG_MACH_SUN60I_A733))
> +		return 0x10;
> +
> +	return 0x4;
> +};
> +
>  static int sunxi_mmc_probe(struct udevice *dev)
>  {
>  	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
> @@ -707,7 +722,7 @@ static int sunxi_mmc_probe(struct udevice *dev)
>  	ccu_reg = (u32 *)(uintptr_t)ofnode_get_addr(args.node);
>  
>  	priv->mmc_no = ((uintptr_t)priv->reg - SUNXI_MMC0_BASE) / 0x1000;
> -	priv->mclkreg = (void *)ccu_reg + get_mclk_offset() + priv->mmc_no * 4;
> +	priv->mclkreg = (void *)ccu_reg + get_mclk_offset() + priv->mmc_no * get_mclk_size();
>  
>  	ret = clk_get_by_name(dev, "ahb", &gate_clk);
>  	if (!ret)
> 

