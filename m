Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE28CCD187
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 09:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17ED384176;
	Thu,  9 Oct 2025 11:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="EUtTiyc/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DB9783A89; Thu,  9 Oct 2025 11:10:06 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 061A083A89
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 11:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 7CF772622C;
 Thu,  9 Oct 2025 11:10:03 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T635s6MdFuM1; Thu,  9 Oct 2025 11:10:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760001002; bh=3f2/kw/eC4rC/nuLag9715Vz62H7anpH8etJxqeWwi0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EUtTiyc/0xZZHaNskDmSa+R6kT28RvV+Sh24h1YodNEiMxVBdZ3VZ7GrFRjNk+SS1
 nOTi1c2c489RIJ2QWroxrJSeVBR4Uyci2O+/GmjgUAtq2p1hxlo1uBFBpmIJhkb3Rg
 DSIJPiq6E2FXMrWc4lhqYIZkJsGBIUsDDiRWhkz+JWOjyW/85bl3qHe3JTz57s7EMO
 7xZoFhycPnjkMmY1FYs38dJlCDFu4p82w6SwqZx1JvFzaYKrF8TMvqMNbntb8X89ro
 z8I/2v32QVaYKg0p128N/rnQX/tdqn5ldg8dTorP12f4+VQdolFXwIzMLKoaFk3npF
 gJgq08COpjJRQ==
Date: Thu, 9 Oct 2025 09:09:48 +0000
From: Yao Zi <ziyao@disroot.org>
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH RFC v3 2/8] mmc: meson_gx_mmc: add minimal non-DM driver
Message-ID: <aOd73MIbAhvilmWK@pie>
References: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
 <20251008-spl-gx-v3-2-5999637df4b9@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008-spl-gx-v3-2-5999637df4b9@postmarketos.org>
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

On Wed, Oct 08, 2025 at 10:00:38AM +0000, Ferass El Hafidi wrote:
> Add a minimal non-DM MMC driver for use in size-constrained
> environments.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>  arch/arm/include/asm/arch-meson/gx.h |  5 +++
>  drivers/mmc/meson_gx_mmc.c           | 75 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 79 insertions(+), 1 deletion(-)
> 
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c

...

> +#if !CONFIG_IS_ENABLED(DM_MMC)

This is a large conditional compilation block with nested #if's, do you
think commenting #else and #endif with the condition improves the
readibility? i.e.

	#if !CONFIG_IS_ENABLED(DM_MMC)

	...

	#else /* !CONFIG_IS_ENALBED(DM_MMC) */

	...

	#endif /* CONFIG_IS_ENALBED(DM_MMC) */

Best regards,
Yao Zi

> +struct meson_mmc_plat mmc_plat[2];
> +
> +static int meson_legacy_mmc_init(struct mmc *mmc)
> +{
> +	/* reset all status bits */
> +	meson_write(mmc, STATUS_MASK, MESON_SD_EMMC_STATUS);
> +
> +	/* disable interrupts */
> +	meson_write(mmc, 0, MESON_SD_EMMC_IRQ_EN);
> +
> +	return 0;
> +}
> +
> +static const struct mmc_ops meson_mmc_ops = {
> +	.send_cmd	= meson_legacy_mmc_send_cmd,
> +	.set_ios	= meson_legacy_mmc_set_ios,
> +	.init		= meson_legacy_mmc_init,
> +};
> +
> +struct mmc *meson_mmc_init(int mmc_no)
> +{
> +	struct meson_mmc_plat *pdata = &mmc_plat[mmc_no];
> +	struct mmc_config *cfg = &pdata->cfg;
> +
> +	cfg->voltages = MMC_VDD_33_34 | MMC_VDD_32_33 |
> +			MMC_VDD_31_32 | MMC_VDD_165_195;
> +	cfg->host_caps = MMC_MODE_8BIT | MMC_MODE_4BIT;
> +	cfg->f_min = DIV_ROUND_UP(SD_EMMC_CLKSRC_24M, CLK_MAX_DIV);
> +	cfg->f_max = 6000000; /* 6 MHz */
> +	cfg->b_max = 127; /* max 128 - 1 block */
> +	cfg->name = "Meson SD/eMMC";
> +	cfg->ops = &meson_mmc_ops;
> +
> +	if (mmc_no == 0) /* MMC1: SD card */
> +		pdata->regbase = (void *)0xd0072000;
> +	else if (mmc_no == 1) /* MMC2: eMMC */
> +		pdata->regbase = (void *)0xd0074000;
> +
> +#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
> +	/* Enable power if needed */
> +	ret = mmc_pwrseq_get_power(dev, cfg);
> +	if (!ret) {
> +		ret = pwrseq_set_power(cfg->pwr_dev, true);
> +		if (ret)
> +			return ret;
> +	}
> +#endif
> +
> +	return mmc_create(cfg, pdata);
> +}
> +
> +#else
>  static const struct dm_mmc_ops meson_dm_mmc_ops = {
>  	.send_cmd = meson_dm_mmc_send_cmd,
>  	.set_ios = meson_dm_mmc_set_ios,
> @@ -282,6 +348,12 @@ static int meson_mmc_probe(struct udevice *dev)
>  	cfg->b_max = 511; /* max 512 - 1 blocks */
>  	cfg->name = dev->name;
>  
> +	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
> +		cfg->host_caps &= ~(MMC_MODE_HS_52MHz | MMC_MODE_HS);
> +		cfg->f_max = 6000000; /* 6 MHz */
> +		cfg->b_max = 127; /* max 128 - 1 block */
> +	}
> +
>  	mmc->priv = pdata;
>  	upriv->mmc = mmc;
>  
> @@ -336,3 +408,4 @@ U_BOOT_DRIVER(meson_mmc) = {
>  	.of_to_plat = meson_mmc_of_to_plat,
>  	.plat_auto	= sizeof(struct meson_mmc_plat),
>  };
> +#endif
> 
> -- 
> 2.51.0
> 
