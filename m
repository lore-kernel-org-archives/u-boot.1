Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C98D10F44
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 13:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2DB484201;
	Wed, 26 Nov 2025 14:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QY4CrmAb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F00584222; Wed, 26 Nov 2025 14:10:31 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75C94841E6
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 14:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42b32900c8bso3938606f8f.0
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 05:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764162628; x=1764767428; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Hz3L9YdKjJc0eMl8GQaznxrAmPx7lWZ0oJVTt9DQsXM=;
 b=QY4CrmAbTD0In2jBscuhsK+gsbDr6YM+8SCJL41hruD1kECqwRzk1j1g8b6WWMvgRY
 AL0ielaP4UgeBobm42lAOPu/k5C88k/2KkdSuAr0EVFjnP82dtOHTermA9UZEo6tGZjk
 Qduuqoi/+G8xmqMaTbewq2nOh5quPsdYp1ue0CM44PoLcSkojbmXdyltYCcJPHOqsYOY
 x0XW1ypCvM/Bw6B1szAsC3Kx++3JFje/zNsuuSytqQUqUXYBnCUYFnoqATzqYJhchEpS
 7JeO+9Oh8I71drirDvhDNPNt+NErbIVSXS6PVK2nHhTpxK1fylXZMpQ45A4JJd+oUb2o
 ixig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764162628; x=1764767428;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hz3L9YdKjJc0eMl8GQaznxrAmPx7lWZ0oJVTt9DQsXM=;
 b=Mt66SonNI+TzQNxXigktRICxzh2dXyLNL9YerRth1sDPLZ7IK3YjGFzRVcCMXtlvKq
 MNiJJOoKE0pm9mFkONL+Vd9DaTZ0+IN4/jS9WRPM5WS2S7+vga2jazxEbwpe1kHXoKGz
 rE2heetEkVIepoMD3EGX3K0a9OYGcP6b9Xof4q/C6viinht2QRZE29R9wnY2OkUm/qqd
 zs1TD0ZsR0kUTNVfIXilAVSjG4MJ86jqaBFo2IRBW+g3H3u8LKUPtf/t28S2rxwRs+UN
 Q0itqoWj3HX/8imOre5QIZbv8nTLwZxugxVtzzpRaEekb8Z6YyEqfAfRbCzYUzT90t77
 +Qrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbODqsUC5b0UAAdXVVkEweUZP1323O8b4RGbVWFv7mwjwIuEOkHgS261ulcRy2d3zWhDmJKfc=@lists.denx.de
X-Gm-Message-State: AOJu0YzJBWq0cQwXyGWkWwVWL0jctU7x1da28jkjLdRkBuvvHrx17os7
 GQQueOwSOu8dCgBoQxQGHNo+47P7dPKsJkSiA4IUNGHqzCNz3TQrrig8s0jRfNQRlP0=
X-Gm-Gg: ASbGnctCy0K9vAMi5SkX8aBRfU5fU4m4H1607fRheVHp2rMz1XFv3lO1BmnStXJaS5C
 rPrTeRYRFnrM+FsnG65x+4VDzYv7gUTC2xWXWUAAH4f/qZTE3eRmlC0WDPZy/t9Up1olLVm2ss9
 vbUW9oeA+BsUwXK/NpQnSU1Fl+iPsxFiX7uoei+zP98mO/ddEFcRkmHuNJPEfDF5Aj8Uz0MsnXO
 QCpPW1wotYGl1WonJDsnQ6DPArxQcB1blp3fb14cwRXd8B8CdX9Y0egn4ej2cgDglzU/DrZ1YDh
 nALtitMOBUs/S+dDRlCE480YGT+6MWAYgb/T2DwkwtVRBHc8p+vanysAgPf4gVgues83bV3EhBw
 OAGn99v2aBirmkQMPCGLdGnjhxn004kfPm7e1Xr9UVYroOh0sRhuUrlZ2fd69BrzQRj44YlXLIa
 sae3109/kF6kA83AOlQGpnOWL7WpDWC9JnmnYfTCMQg1R2yLvIOjvzLgnslVBc
X-Google-Smtp-Source: AGHT+IFMmLFNjjYdZ00MBXXpQc7ocEEhhGae0SZ20TvFNCzVmXKiswE6tz9qsO7dqtn+VN1WgrQwHQ==
X-Received: by 2002:a05:6000:184a:b0:42b:549d:cdfc with SMTP id
 ffacd0b85a97d-42cc1d2e36dmr20716869f8f.35.1764162627697; 
 Wed, 26 Nov 2025 05:10:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:91ba:3a5e:334:4534?
 ([2a01:e0a:3d9:2080:91ba:3a5e:334:4534])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8baesm40803619f8f.39.2025.11.26.05.10.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 05:10:27 -0800 (PST)
Message-ID: <fec8b234-289b-43d7-a974-c4225fa6e3aa@linaro.org>
Date: Wed, 26 Nov 2025 14:10:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 02/10] mmc: meson_gx_mmc: add minimal non-DM driver
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
 <20251126-spl-gx-v5-2-6cbffb2451ca@postmarketos.org>
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
In-Reply-To: <20251126-spl-gx-v5-2-6cbffb2451ca@postmarketos.org>
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

On 11/26/25 13:17, Ferass El Hafidi wrote:
> Add a minimal non-DM MMC driver for use in size-constrained
> environments.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   arch/arm/include/asm/arch-meson/gx.h |  5 +++
>   drivers/mmc/meson_gx_mmc.c           | 77 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 82 insertions(+)
> 
> diff --git a/arch/arm/include/asm/arch-meson/gx.h b/arch/arm/include/asm/arch-meson/gx.h
> index 26ec5d0bc34..8cfc6b00329 100644
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
> index 5852b24c6d2..d1558ebe3a2 100644
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
> @@ -67,10 +69,14 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>   	 * Other SoCs use CLK_CO_PHASE_180 by default.
>   	 * It needs to find what is a proper value about each SoCs.
>   	 */
> +#if CONFIG_IS_ENABLED(DM_MMC)
>   	if (meson_gx_mmc_is_compatible(mmc->dev, MMC_COMPATIBLE_SM1))
>   		meson_mmc_clk |= CLK_CO_PHASE_270;
>   	else
>   		meson_mmc_clk |= CLK_CO_PHASE_180;
> +#else /* U-Boot SPL on GX SoCs */
> +	meson_mmc_clk |= CLK_CO_PHASE_180;
> +#endif
>   
>   	/* 180 phase tx clock */
>   	meson_mmc_clk |= CLK_TX_PHASE_000;
> @@ -82,9 +88,14 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>   	meson_write(mmc, meson_mmc_clk, MESON_SD_EMMC_CLOCK);
>   }
>   
> +#if CONFIG_IS_ENABLED(DM_MMC)
>   static int meson_dm_mmc_set_ios(struct udevice *dev)
>   {
>   	struct mmc *mmc = mmc_get_mmc_dev(dev);
> +#else /* U-Boot SPL */
> +static int meson_legacy_mmc_set_ios(struct mmc *mmc)
> +{
> +#endif
>   	uint32_t meson_mmc_cfg;
>   
>   	meson_mmc_config_clock(mmc);
> @@ -193,10 +204,16 @@ static void meson_mmc_read_response(struct mmc *mmc, struct mmc_cmd *cmd)
>   	}
>   }
>   
> +#if CONFIG_IS_ENABLED(DM_MMC)
>   static int meson_dm_mmc_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
>   				 struct mmc_data *data)
>   {
>   	struct mmc *mmc = mmc_get_mmc_dev(dev);
> +#else /* U-Boot SPL */
> +static int meson_legacy_mmc_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
> +				     struct mmc_data *data)
> +{
> +#endif
>   	struct meson_mmc_plat *pdata = mmc->priv;
>   	uint32_t status;
>   	ulong start;
> @@ -235,6 +252,59 @@ static int meson_dm_mmc_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
>   	return ret;
>   }
>   
> +#if !CONFIG_IS_ENABLED(DM_MMC) /* Non-DM MMC driver for use in U-Boot SPL */
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
> +#else /* DM-based driver for use in U-Boot proper */
>   static const struct dm_mmc_ops meson_dm_mmc_ops = {
>   	.send_cmd = meson_dm_mmc_send_cmd,
>   	.set_ios = meson_dm_mmc_set_ios,
> @@ -282,6 +352,12 @@ static int meson_mmc_probe(struct udevice *dev)
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
> @@ -336,3 +412,4 @@ U_BOOT_DRIVER(meson_mmc) = {
>   	.of_to_plat = meson_mmc_of_to_plat,
>   	.plat_auto	= sizeof(struct meson_mmc_plat),
>   };
> +#endif /* CONFIG_IS_ENABLED(DM_MMC) */
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
