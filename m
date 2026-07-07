Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2806AC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 13:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BEDC84942;
	Tue,  7 Jul 2026 15:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ZqUDqc20";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E38078494B; Tue,  7 Jul 2026 15:31:54 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 93085848EB
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 15:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71EE31A2D;
 Tue,  7 Jul 2026 06:31:47 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 ECB603F85F; Tue,  7 Jul 2026 06:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1783431111; bh=wJ1vh8dLe4d8Fie83914eK500UlrxDu4qxlaeKNYdDY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZqUDqc201V7E+la0UZMU6/7JsUF/qOf59jHc2Vu49lkOhhgL8GAIE531w5MSgJnWI
 36GhG1/z6qWWFk4IUdu3lJbvK4FK3NHFSOScFfOE22tji6x7Ismmv653RRWh0k4OL1
 GTBUy569Ks61zO8/SdPGTAuzOFxwN9rnB/q9m4Mc=
Message-ID: <61a7e0c7-46b2-4a85-8f53-b8e2486e89e7@arm.com>
Date: Tue, 7 Jul 2026 15:31:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sunxi: mask DATA0 during H6-family clock updates
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
References: <20260703194738.3540286-1-james.hilliard1@gmail.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260703194738.3540286-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi James,


On 7/3/26 21:47, James Hilliard wrote:
> Linux marks the H6/A100-style controllers with mask_data0 and sets the
> CLKCR MASK_DATA0 bit while issuing update-clock commands. Without this,
> the controller can sample DAT0 as busy around clock updates before the
> first card command, so card detection may fail with -ETIMEDOUT.

Can you please say *WHY* this change is needed? Is this "card detection 
may fail" a theoretical assumption, or did this happen to you in 
practice? I wouldn't be aware of any reports about issues with MMC in 
U-Boot, so I'd be curious to hear about that, with a concrete example, 
and how often this happens, if you experienced this. Also if that 
applies to the SPL or to U-Boot proper only.

> Mirror the Linux behavior for H6-family and NCAT2-family controllers while
> updating the card clock.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   drivers/mmc/sunxi_mmc.c | 30 +++++++++++++++++++++++++++---
>   drivers/mmc/sunxi_mmc.h |  1 +
>   2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
> index e28c81afffe..145d6bd7c9d 100644
> --- a/drivers/mmc/sunxi_mmc.c
> +++ b/drivers/mmc/sunxi_mmc.c
> @@ -64,6 +64,12 @@ static bool sunxi_mmc_can_calibrate(void)
>   	       IS_ENABLED(CONFIG_MACH_SUN8I_R40);
>   }
>   
> +static bool sunxi_mmc_needs_data0_mask(void)
> +{
> +	return IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
> +	       IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2);

Meh, I see that this is a pragmatic approach, but I wonder if this 
should come from the DT when in U-Boot proper (or when using DM_MMC in 
general).

> +}
> +
>   static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int hz)
>   {
>   	unsigned int pll, pll_hz, div, n, oclk_dly, sclk_dly;
> @@ -201,14 +207,31 @@ static int mmc_update_clk(struct sunxi_mmc_priv *priv)
>   	return 0;
>   }
>   
> +static int mmc_update_clk_with_data0_mask(struct sunxi_mmc_priv *priv)

If I see this correctly, then this function is only called (twice) from 
mmc_config_clock() below, but you don't change the other user in the 
error path of sunxi_mmc_send_cmd_common(), right? It's probably worth 
mentioning this in the commit message.

And if that's true, please fold the functionality into 
mmc_config_clock(). This one knows the value of clkcr already, so no 
need for two read/modify/write operations, and no need for a function 
with a lengthy name.

> +{
> +	bool mask_data0 = sunxi_mmc_needs_data0_mask();
> +	int ret;
> +
> +	if (mask_data0)
> +		setbits_le32(&priv->reg->clkcr, SUNXI_MMC_CLK_MASK_DATA0);
> +
> +	ret = mmc_update_clk(priv);
> +
> +	if (mask_data0)
> +		clrbits_le32(&priv->reg->clkcr, SUNXI_MMC_CLK_MASK_DATA0);
> +
> +	return ret;
> +}
> +
>   static int mmc_config_clock(struct sunxi_mmc_priv *priv, struct mmc *mmc)
>   {
>   	unsigned rval = readl(&priv->reg->clkcr);
>   
>   	/* Disable Clock */
> -	rval &= ~SUNXI_MMC_CLK_ENABLE;
> +	rval &= ~(SUNXI_MMC_CLK_ENABLE | SUNXI_MMC_CLK_POWERSAVE |

What about this POWERSAVE bit? If you change this as well, please 
mention this in the commit message, and say why this is needed (as it 
wasn't used before in the driver).

Cheers,
Andre

> +		  SUNXI_MMC_CLK_MASK_DATA0);
>   	writel(rval, &priv->reg->clkcr);
> -	if (mmc_update_clk(priv))
> +	if (mmc_update_clk_with_data0_mask(priv))
>   		return -1;
>   
>   	/* Set mod_clk to new rate */
> @@ -231,9 +254,10 @@ static int mmc_config_clock(struct sunxi_mmc_priv *priv, struct mmc *mmc)
>   #endif
>   
>   	/* Re-enable Clock */
> +	rval &= ~(SUNXI_MMC_CLK_POWERSAVE | SUNXI_MMC_CLK_MASK_DATA0);
>   	rval |= SUNXI_MMC_CLK_ENABLE;
>   	writel(rval, &priv->reg->clkcr);
> -	if (mmc_update_clk(priv))
> +	if (mmc_update_clk_with_data0_mask(priv))
>   		return -1;
>   
>   	return 0;
> diff --git a/drivers/mmc/sunxi_mmc.h b/drivers/mmc/sunxi_mmc.h
> index 71865160319..c9a0f3833a2 100644
> --- a/drivers/mmc/sunxi_mmc.h
> +++ b/drivers/mmc/sunxi_mmc.h
> @@ -58,6 +58,7 @@ struct sunxi_mmc {
>   
>   #define SUNXI_MMC_CLK_POWERSAVE		(0x1 << 17)
>   #define SUNXI_MMC_CLK_ENABLE		(0x1 << 16)
> +#define SUNXI_MMC_CLK_MASK_DATA0	(0x1U << 31)
>   #define SUNXI_MMC_CLK_DIVIDER_MASK	(0xff)
>   
>   #define SUNXI_MMC_GCTRL		0x000

