Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6D7C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 03:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 400628772A;
	Sun, 17 Mar 2024 04:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Ku8GFrGq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EEB887B71; Sun, 17 Mar 2024 04:17:49 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E21C83346
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 04:17:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1710645466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uv/8Y/sh2al76PkCUCk0XTLqrEuMuXuEhGPF1ePAnf0=;
 b=Ku8GFrGq+0yd1SjnQJSAZDRTyFtmlAJjWaNKCX9X8FAezu9t2JQZQXHWkWCuAtUUY5mdYq
 1U8HbGUTxEbUEOInAbbK5MzQ7UZ5i4CKz9sUgHg/vpAIp892SpJfGXoW3qDqnJi9ly2Pny
 gNcf3ifcnXTU+amv84ex+2k3krLoK7t7tiuJdVPmjXzVyMRC/8rZWnXqLL3XdH5uJEqKBr
 VtzRHLw6u1CKC7gVjI74WSI6KnZZT0DjmaZWrnn7DK/PWO9i+Px7ARi1/uYSjKfL07ur/E
 cTxOVKPBsB+olyLDHZapOZ/aHfHPqXahHBXv/j20ExUzxYJiDNPYcDTClotAXg==
Date: Sun, 17 Mar 2024 04:17:44 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan
 <peng.fan@nxp.com>
Subject: Re: [PATCH v2] mmc: Unconditionally call mmc_deinit()
In-Reply-To: <20240317030147.509788-1-marek.vasut+renesas@mailbox.org>
References: <20240317030147.509788-1-marek.vasut+renesas@mailbox.org>
Message-ID: <52ad2b4510d74eb40ecb58010b7f375f@manjaro.org>
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

On 2024-03-17 04:01, Marek Vasut wrote:
> Place the SDR104/HS200/HS400 checks into the mmc_deinit() and always
> call it. This simplifies the code and removes ifdeffery. No functional
> change is expected.
> 
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> ---
> V2: - Add sd_select_mode_and_width and mmc_select_mode_and_width stubs
>       in case MMC_TINY is defined
>     - Add RB from Jaehoon
> ---
>  drivers/mmc/mmc-uclass.c | 13 +------------
>  drivers/mmc/mmc.c        | 19 +++++++++++++++----
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index 328456831dd..cdead044177 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -494,10 +494,7 @@ static int mmc_blk_probe(struct udevice *dev)
>  	if (ret) {
>  		debug("Probing %s failed (err=%d)\n", dev->name, ret);
> 
> -		if (CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) ||
> -		    CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) ||
> -		    CONFIG_IS_ENABLED(MMC_HS400_SUPPORT))
> -			mmc_deinit(mmc);
> +		mmc_deinit(mmc);
> 
>  		return ret;
>  	}
> @@ -505,9 +502,6 @@ static int mmc_blk_probe(struct udevice *dev)
>  	return 0;
>  }
> 
> -#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) || \
> -    CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
> -    CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
>  static int mmc_blk_remove(struct udevice *dev)
>  {
>  	struct udevice *mmc_dev = dev_get_parent(dev);
> @@ -516,7 +510,6 @@ static int mmc_blk_remove(struct udevice *dev)
> 
>  	return mmc_deinit(mmc);
>  }
> -#endif
> 
>  static const struct blk_ops mmc_blk_ops = {
>  	.read	= mmc_bread,
> @@ -532,12 +525,8 @@ U_BOOT_DRIVER(mmc_blk) = {
>  	.id		= UCLASS_BLK,
>  	.ops		= &mmc_blk_ops,
>  	.probe		= mmc_blk_probe,
> -#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) || \
> -    CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
> -    CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
>  	.remove		= mmc_blk_remove,
>  	.flags		= DM_FLAG_OS_PREPARE,
> -#endif
>  };
>  #endif /* CONFIG_BLK */
> 
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index d96db7a0f83..4722bb2711a 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -2250,6 +2250,16 @@ error:
> 
>  	return -ENOTSUPP;
>  }
> +#else
> +static int sd_select_mode_and_width(struct mmc *mmc, uint card_caps)
> +{
> +	return 0;
> +};
> +
> +static int mmc_select_mode_and_width(struct mmc *mmc, uint card_caps)
> +{
> +	return 0;
> +};
>  #endif
> 
>  #if CONFIG_IS_ENABLED(MMC_TINY)
> @@ -3010,13 +3020,15 @@ int mmc_init(struct mmc *mmc)
>  	return err;
>  }
> 
> -#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) || \
> -    CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
> -    CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
>  int mmc_deinit(struct mmc *mmc)
>  {
>  	u32 caps_filtered;
> 
> +	if (!CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) &&
> +	    !CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) &&
> +	    !CONFIG_IS_ENABLED(MMC_HS400_SUPPORT))
> +		return 0;
> +
>  	if (!mmc->has_init)
>  		return 0;
> 
> @@ -3034,7 +3046,6 @@ int mmc_deinit(struct mmc *mmc)
>  		return mmc_select_mode_and_width(mmc, caps_filtered);
>  	}
>  }
> -#endif
> 
>  int mmc_set_dsr(struct mmc *mmc, u16 val)
>  {
