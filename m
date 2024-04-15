Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B6DC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 09:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F7B6881FB;
	Mon, 15 Apr 2024 11:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="YwskY1yK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF69881FE; Mon, 15 Apr 2024 11:19:12 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D483088193
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 11:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1713172749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jNsoSd+OVj06ItL33N7bTwPLgMNckI04SqFxABthN1w=;
 b=YwskY1yKjrNUMt0OjikstaFJ1WHTTtffMKbDeetoyvjSkTKGCqHtt7tZ6WpmTRKWz1eZJh
 3yXylUKe/mmK3nmPPM4SLZviI6YC5ebqYQM3NfPg1OgaskJdhSEjHZdNln/9GUdwwX3ocb
 hduWnNso2VJ/kiVm9g9p7LSSiI4Z2vEb/67bjYXdixyns56YY67LKmJ+iSZAMmjzmhTdvm
 gIuFKMDAWwB4zEceiU88u9tgBW4Q7uW53lyMCd1CGmt9lOvWyEE2ILf1W/DFbX3LT+wLp1
 TlrLxgwBIOvXaow8on4sLR5Kap5J0ahkl8RenuJZtxNXNsZQGiFpIYrehau2sQ==
Date: Mon, 15 Apr 2024 11:19:09 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, Quentin
 Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] mmc: rockchip_sdhci: Fix 4 blocks PIO mode read limit
 for RK35xx
In-Reply-To: <20240410143052.227908-1-jonas@kwiboo.se>
References: <20240410143052.227908-1-jonas@kwiboo.se>
Message-ID: <897dbacc895abc96a72bb944196897e3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-04-10 16:30, Jonas Karlman wrote:
> The commit 2cc6cde647e2 ("mmc: rockchip_sdhci: Limit number of blocks
> read in a single command") introduced a limit of number of blocks to
> read to fix a Data End Bit Error on RK3568 and RK3588. This had a side
> affect of significant slowing down reading FIT from eMMC.
> 
> After the commit 6de9d7b2f13c ("rockchip: rk35xx: Enable eMMC HS200 
> mode
> by default") the limit of number of blocks to read workaround is no
> longer necessary and at HS200+ a Data End Bit Error is no longer
> happening using PIO mode.
> 
> Change this limitation to allow reading more than 4 blocks with a 
> single
> CMD18 command in PIO mode at HS200+ speed, keep using the 4 blocks
> limitation when loadig FIT from eMMC at lower speed than HS200.
> 
> Fixes: 2cc6cde647e2 ("mmc: rockchip_sdhci: Limit number of blocks read
> in a single command")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Looking good to me.  Thanks for peforming this dynamically, based
on the actual MMC interface speed/mode.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> v2: Move cfg->b_max configuration to set_ios_post() ops
> 
> This significantly speed up FIT loading from eMMC on RK3588 boards with
> a mmc-hs200 prop in the sdhci node, and boards without a mmc-hs200 prop
> continue to work.
> ---
>  drivers/mmc/rockchip_sdhci.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/rockchip_sdhci.c 
> b/drivers/mmc/rockchip_sdhci.c
> index 706fb1235796..c889c7bc9855 100644
> --- a/drivers/mmc/rockchip_sdhci.c
> +++ b/drivers/mmc/rockchip_sdhci.c
> @@ -391,6 +391,8 @@ static int rk3568_sdhci_config_dll(struct
> sdhci_host *host, u32 clock, bool enab
>  static int rk3568_sdhci_set_ios_post(struct sdhci_host *host)
>  {
>  	struct mmc *mmc = host->mmc;
> +	struct rockchip_sdhc_plat *plat = dev_get_plat(mmc->dev);
> +	struct mmc_config *cfg = &plat->cfg;
>  	u32 reg;
> 
>  	reg = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> @@ -437,6 +439,20 @@ static int rk3568_sdhci_set_ios_post(struct
> sdhci_host *host)
> 
>  	sdhci_writew(host, reg, DWCMSHC_EMMC_EMMC_CTRL);
> 
> +	/*
> +	 * Reading more than 4 blocks with a single CMD18 command in PIO mode
> +	 * triggers Data End Bit Error using a slower mode than HS200. Limit 
> to
> +	 * reading max 4 blocks in one command when using PIO mode.
> +	 */
> +	if (!(host->flags & USE_DMA)) {
> +		if (mmc->selected_mode == MMC_HS_200 ||
> +		    mmc->selected_mode == MMC_HS_400 ||
> +		    mmc->selected_mode == MMC_HS_400_ES)
> +			cfg->b_max = CONFIG_SYS_MMC_MAX_BLK_COUNT;
> +		else
> +			cfg->b_max = 4;
> +	}
> +
>  	return 0;
>  }
> 
> @@ -598,16 +614,6 @@ static int rockchip_sdhci_probe(struct udevice 
> *dev)
>  	    dev_read_bool(dev, "u-boot,spl-fifo-mode"))
>  		host->flags &= ~USE_DMA;
> 
> -	/*
> -	 * Reading more than 4 blocks with a single CMD18 command in PIO mode
> -	 * triggers Data End Bit Error on RK3568 and RK3588. Limit to reading
> -	 * max 4 blocks in one command when using PIO mode.
> -	 */
> -	if (!(host->flags & USE_DMA) &&
> -	    (device_is_compatible(dev, "rockchip,rk3568-dwcmshc") ||
> -	     device_is_compatible(dev, "rockchip,rk3588-dwcmshc")))
> -		cfg->b_max = 4;
> -
>  	return sdhci_probe(dev);
>  }
