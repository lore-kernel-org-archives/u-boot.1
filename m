Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4411CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 13:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E84F88394E;
	Wed,  8 Oct 2025 15:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kKpaIKi+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4B7E839B9; Wed,  8 Oct 2025 15:33:09 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E89C8394A
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 15:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e504975dbso45365955e9.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 06:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759930387; x=1760535187; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=6gCtVeqv/xctn0W0vlzJRNNyG26Hrx1wHzyi8DOXBLk=;
 b=kKpaIKi+8t0dhjsAKHV6C1oijHDtaFaX2LTLEDEYamnIlwSZpnWOeixyfHgl4x8+1j
 cZpjBOpOT+yFfAdKEmeDzxI3ZUjfrBqwyzM9qrHMG5wTnVrRwINqLZ/y9X2bRGNpdPqI
 zt16Bqhk2VEugDhE6/0tJF0JuNw8L9g0m3vtw5jP0y78bTdmRvPD1Xyqd1nwi1odZsuh
 h4tmcJrauwiq4zrRcHYx8gRKLl2l6z3zzx335O/HXa8GFhdo2DWYLQt1QVAgcBlhM1Ps
 3Pfab56lZCZnyECIjEjA087laJk3r/DbkZCgOzxNjV2FpwTqjA9gb3O0fQCLI9+cX8/w
 CClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759930387; x=1760535187;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6gCtVeqv/xctn0W0vlzJRNNyG26Hrx1wHzyi8DOXBLk=;
 b=kT9SjAhk8edtj9Vu5r4Uo4HyM+DScesbpNUFZXhOvzQTcXPs+OKpRcmD+u6v+TeLp1
 jVJUtEHazL7/OcyOBVM6SpCnAKpAlF7oEkmDw2i79DEVf1ml5TMj4DINyWxrjM2q69cG
 lU6M8zKAUENJ3MmNc42S2djaRLmHIAqlumXEQOSr7SXUOW+q+ErJCDZZTPixXM4zkOUL
 sBqDsdCnkMbIyo6RDDgvgudk+J+Vs49zWLM3MKFvTJuaxTOLhHOV5YmMymI1Qu81/ty1
 pXOEaWWldK6C4vbt+9GUGfuFPiyWxBYkSynbJGXKSW62q3b02tUcjFM65carOi4GSTMs
 OXrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1c6OmP4Zx8GXhwkt/E3QWJNy/SUADKHXCGdOZvKPr/uOmmlOBnl6gjHeiD6IgIJ9p0/+pVtE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8caCC9pBE6kdiyNqz8MWWg8uMXmUkM7AVPsQAQ1NWKbK4+w9O
 6rbqZUbXMLoirGJtmxHr60GSWhtznO7fT7mKVxNl4rJ2Io4kxydQ/FBeSW71OYffUUs=
X-Gm-Gg: ASbGncuCjUzDJ1FBjHtU0w5NWTyC+Ppw7z8F+acdD7Ah4tV4dWKVYmq8APpp1YaicVI
 yGIOGhJTcdUWZdBeKEKdC3QAcxDs62qOMbVE1Q67ivguzfFmsm3P1o8LsGlrQLhM4NWb5YIfrVl
 rJA9o+hr5c6mAyC18fyTPZJYt+eH46Gqp6Kh4+xqRcIn6ZT+J98qJTLIfpAeB4SkAu9r39Fq9i7
 oXZ43W+ZaE9emI4JKGncMnw3rXbMPBFGhPCMSwqvyVTHEzk3wN7dhLiMl/vNGupe8TH7odoCvCo
 5lADPiKJXEbscfK2pFthS6wYB8Ygb5sdzCEpQM/WJrCxo9AGBCrJExtBDEmfaBzB5tvom7TV90M
 olq0iSofJvg+8RgSMVOMMxkUagiw4P+Kbrh3EqfptdYqVFupuQto4D0B3tXkR+BKEJzUx/RHcaT
 AJ5G+5p5qwwhiIEs7JUn4=
X-Google-Smtp-Source: AGHT+IFUXJq7JH7SlIOgsPhp2y57cfdx+ATI9LUbff2mxRd9EDkWvooMDDXud42aZcpW0hCJvb0Lqw==
X-Received: by 2002:a05:600c:c162:b0:46e:5a5b:db60 with SMTP id
 5b1f17b1804b1-46fa9affbe0mr28779705e9.31.1759930386678; 
 Wed, 08 Oct 2025 06:33:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b264:afbc:dee:3d?
 ([2a01:e0a:3d9:2080:b264:afbc:dee:3d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f4bdcsm30017252f8f.54.2025.10.08.06.33.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 06:33:06 -0700 (PDT)
Message-ID: <d6b85855-f55e-4699-875c-86cf0200011b@linaro.org>
Date: Wed, 8 Oct 2025 15:33:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC v3 2/8] mmc: meson_gx_mmc: add minimal non-DM driver
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
 <20251008-spl-gx-v3-2-5999637df4b9@postmarketos.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20251008-spl-gx-v3-2-5999637df4b9@postmarketos.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/8/25 12:00, Ferass El Hafidi wrote:
> Add a minimal non-DM MMC driver for use in size-constrained
> environments.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   arch/arm/include/asm/arch-meson/gx.h |  5 +++
>   drivers/mmc/meson_gx_mmc.c           | 75 +++++++++++++++++++++++++++++++++++-
>   2 files changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/arch-meson/gx.h b/arch/arm/include/asm/arch-meson/gx.h
> index 26ec5d0bc340bc03587047d68a88042779e64536..8cfc6b00329f252bbf452dba00f8ad56b480c707 100644
> --- a/arch/arm/include/asm/arch-meson/gx.h
> +++ b/arch/arm/include/asm/arch-meson/gx.h
> @@ -41,4 +41,9 @@
>   #define GX_GPIO_IN(n)		GX_PERIPHS_ADDR(_GX_GPIO_OFF(n) + 1)
>   #define GX_GPIO_OUT(n)	GX_PERIPHS_ADDR(_GX_GPIO_OFF(n) + 2)
>   
> +/* Non-DM MMC init */
> +#if CONFIG_IS_ENABLED(MMC) && !CONFIG_IS_ENABLED(DM_MMC)
> +struct mmc *meson_mmc_init(int mmc_no);
> +#endif
> +
>   #endif /* __GX_H__ */
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index 5852b24c6d2a5a9d1b1e8a62f8c0ec325b339182..a4338f1e29c1da07acb0333be9b75a318cba1334 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -16,6 +16,7 @@
>   #include <linux/log2.h>
>   #include "meson_gx_mmc.h"
>   
> +#if CONFIG_IS_ENABLED(DM_MMC)
>   bool meson_gx_mmc_is_compatible(struct udevice *dev,
>   				enum meson_gx_mmc_compatible family)
>   {
> @@ -23,6 +24,7 @@ bool meson_gx_mmc_is_compatible(struct udevice *dev,
>   
>   	return compat == family;
>   }
> +#endif
>   
>   static inline void *get_regbase(const struct mmc *mmc)
>   {
> @@ -67,7 +69,7 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>   	 * Other SoCs use CLK_CO_PHASE_180 by default.
>   	 * It needs to find what is a proper value about each SoCs.
>   	 */
> -	if (meson_gx_mmc_is_compatible(mmc->dev, MMC_COMPATIBLE_SM1))
> +	if (IS_ENABLED(CONFIG_MESON_SM))

I'm not a fan of that, technically while we keep the socs separated the
driver should be generic and not rely on the soc config.

I'k ok to have it in non-DM, but in DM it should still use meson_gx_mmc_is_compatible().

Neil

>   		meson_mmc_clk |= CLK_CO_PHASE_270;
>   	else
>   		meson_mmc_clk |= CLK_CO_PHASE_180;
> @@ -82,9 +84,14 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>   	meson_write(mmc, meson_mmc_clk, MESON_SD_EMMC_CLOCK);
>   }
>   
> +#if CONFIG_IS_ENABLED(DM_MMC)
>   static int meson_dm_mmc_set_ios(struct udevice *dev)
>   {
>   	struct mmc *mmc = mmc_get_mmc_dev(dev);
> +#else
> +static int meson_legacy_mmc_set_ios(struct mmc *mmc)
> +{
> +#endif
>   	uint32_t meson_mmc_cfg;
>   
>   	meson_mmc_config_clock(mmc);
> @@ -193,10 +200,16 @@ static void meson_mmc_read_response(struct mmc *mmc, struct mmc_cmd *cmd)
>   	}
>   }
>   
> +#if CONFIG_IS_ENABLED(DM_MMC)
>   static int meson_dm_mmc_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
>   				 struct mmc_data *data)
>   {
>   	struct mmc *mmc = mmc_get_mmc_dev(dev);
> +#else
> +static int meson_legacy_mmc_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
> +				     struct mmc_data *data)
> +{
> +#endif
>   	struct meson_mmc_plat *pdata = mmc->priv;
>   	uint32_t status;
>   	ulong start;
> @@ -235,6 +248,59 @@ static int meson_dm_mmc_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
>   	return ret;
>   }
>   
> +#if !CONFIG_IS_ENABLED(DM_MMC)
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
>   static const struct dm_mmc_ops meson_dm_mmc_ops = {
>   	.send_cmd = meson_dm_mmc_send_cmd,
>   	.set_ios = meson_dm_mmc_set_ios,
> @@ -282,6 +348,12 @@ static int meson_mmc_probe(struct udevice *dev)
>   	cfg->b_max = 511; /* max 512 - 1 blocks */
>   	cfg->name = dev->name;
>   
> +	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
> +		cfg->host_caps &= ~(MMC_MODE_HS_52MHz | MMC_MODE_HS);
> +		cfg->f_max = 6000000; /* 6 MHz */
> +		cfg->b_max = 127; /* max 128 - 1 block */
> +	}
> +
>   	mmc->priv = pdata;
>   	upriv->mmc = mmc;
>   
> @@ -336,3 +408,4 @@ U_BOOT_DRIVER(meson_mmc) = {
>   	.of_to_plat = meson_mmc_of_to_plat,
>   	.plat_auto	= sizeof(struct meson_mmc_plat),
>   };
> +#endif
> 

