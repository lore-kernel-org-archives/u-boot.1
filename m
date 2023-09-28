Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42170CE7B0E
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 09:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A33686E28;
	Thu, 28 Sep 2023 11:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wSdnXU5b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 105ED86E2D; Thu, 28 Sep 2023 11:02:30 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11518869CA
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 11:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4053cf48670so116532625e9.0
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 02:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695891747; x=1696496547; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=aniWBOwoqavJLYLoVn4Vl8iRHj2v7O68Ym4yCjsl1Ls=;
 b=wSdnXU5b0otIe4OgYn3B+nYDeSZeTEIvxDD98X6Czui1o6aUv9l7D1eoctEp/gU/vQ
 bEgc1KAFL1z2/jnqsppgDkQEVSL3eapWMOE1ZES2mjhoF7Sy3RZIXiJpoSlahT8aQOYe
 i9Ew4q1DTwiSHeU3j8RXpAVDY791PjL0pCtMrlSjtaDiaU5i3Yhb/2Swwxm6FUX/3Co3
 dcxfNGAeQZHOFr9yrasxNXOdl1nbZPIXwbT1T/v51Do6eICgxIZSuNdPfoDztHXVgEO/
 BFMdn143hMfF5puBIShMeA7u0jZJG4kp5LnKD0D8Oh6sWyFJ3j9uGMO7z0cdyY1FBsf7
 yfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695891747; x=1696496547;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aniWBOwoqavJLYLoVn4Vl8iRHj2v7O68Ym4yCjsl1Ls=;
 b=i1AE630KvftJFVyZ95BGfasXa4dU9wdX31goJm3tW3p3Xiiub8aitdRC54B3Z1LLpT
 3jt8/7rj90EBzNEHWbr2gNo9GJ1n35ccOEtLiJOSYi0QnDba5MEo3vgr2rPBUmF/zfqy
 N1BTHbD8mTeRI9Y3p4ESZWDQIaPItbh22drhiyVVU+8dPD/Sk1UbmxA86CCh2u01CoFy
 Cpvs/5oRtN+55IOLcq0aoh/lkYjlz+AicXst9PpG3cO0TMmSAybO2B44ihjA0Fmxf0xE
 ixSXtmb2fjPwFRy5HjxrdqNPzt8s0AqswUhJSy5eHy915dVLjlE4OZGNTPZHB5/p7OPT
 O+Bg==
X-Gm-Message-State: AOJu0YxfC0A0iodpIe1LR19+D8O5tn8GIXBZnQvz1FdiRq08BHQT3uzm
 Yh0HEimiX9lI6/GfzW/9mXT9Ng==
X-Google-Smtp-Source: AGHT+IFe1A9G/xxbjkrjSccJZOGwvnvA60VwxGDy1Fl8mYot5hRBYilTAnTgGa7gcjexSU8fjEhDPA==
X-Received: by 2002:adf:ee10:0:b0:31f:f753:9938 with SMTP id
 y16-20020adfee10000000b0031ff7539938mr605872wrn.58.1695891747432; 
 Thu, 28 Sep 2023 02:02:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:17b1:9dda:a3d1:a0b6?
 ([2a01:e0a:982:cbb0:17b1:9dda:a3d1:a0b6])
 by smtp.gmail.com with ESMTPSA id
 x5-20020adfdcc5000000b0031c6581d55esm19176915wrm.91.2023.09.28.02.02.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 02:02:26 -0700 (PDT)
Message-ID: <7cae57ac-de06-42b3-91e7-c5796a4f7fc0@linaro.org>
Date: Thu, 28 Sep 2023 11:02:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] mmc: Add SPL_MMC_PWRSEQ to fix link issue when building
 SPL
Content-Language: en-US, fr
To: Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Ferass El Hafidi <vitali64pmemail@protonmail.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
References: <20230925215516.1528643-1-jonas@kwiboo.se>
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
Organization: Linaro Developer Services
In-Reply-To: <20230925215516.1528643-1-jonas@kwiboo.se>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 25/09/2023 23:55, Jonas Karlman wrote:
> With MMC_PWRSEQ enabled the following link issue may happen when
> building SPL and SPL_PWRSEQ is not enabled.
> 
>    aarch64-linux-gnu-ld.bfd: drivers/mmc/meson_gx_mmc.o: in function `meson_mmc_probe':
>    drivers/mmc/meson_gx_mmc.c:295: undefined reference to `pwrseq_set_power'
> 
> Fix this by adding a SPL_MMC_PWRSEQ Kconfig option used to enable mmc
> pwrseq support in SPL.
> 
> Also add depends on DM_GPIO to fix following link issue:
> 
>    aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.o: in function `mmc_pwrseq_set_power':
>    drivers/mmc/mmc-pwrseq.c:26: undefined reference to `gpio_request_by_name'
>    aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.c:29: undefined reference to `dm_gpio_set_value'
>    aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.c:31: undefined reference to `dm_gpio_set_value'
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/mmc/Kconfig           | 10 +++++++++-
>   drivers/mmc/Makefile          |  2 +-
>   drivers/mmc/meson_gx_mmc.c    |  2 +-
>   drivers/mmc/rockchip_dw_mmc.c |  2 +-
>   include/mmc.h                 |  4 ++--
>   5 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index de01b9687bad..a9931d39412d 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -20,11 +20,19 @@ config MMC_WRITE
>   
>   config MMC_PWRSEQ
>   	bool "HW reset support for eMMC"
> -	depends on PWRSEQ
> +	depends on PWRSEQ && DM_GPIO
>   	help
>   	  Ths select Hardware reset support aka pwrseq-emmc for eMMC
>   	  devices.
>   
> +config SPL_MMC_PWRSEQ
> +	bool "HW reset support for eMMC in SPL"
> +	depends on SPL_PWRSEQ && SPL_DM_GPIO
> +	default y if MMC_PWRSEQ
> +	help
> +	  Ths select Hardware reset support aka pwrseq-emmc for eMMC
> +	  devices in SPL.
> +
>   config MMC_BROKEN_CD
>   	bool "Poll for broken card detection case"
>   	help
> diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
> index 2c65c4765ab2..0a79dd058bef 100644
> --- a/drivers/mmc/Makefile
> +++ b/drivers/mmc/Makefile
> @@ -11,7 +11,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += mmc_bootdev.o
>   endif
>   
>   obj-$(CONFIG_$(SPL_TPL_)MMC_WRITE) += mmc_write.o
> -obj-$(CONFIG_MMC_PWRSEQ) += mmc-pwrseq.o
> +obj-$(CONFIG_$(SPL_)MMC_PWRSEQ) += mmc-pwrseq.o
>   obj-$(CONFIG_MMC_SDHCI_ADMA_HELPERS) += sdhci-adma.o
>   
>   ifndef CONFIG_$(SPL_)BLK
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index fcf4f03d1e24..0825c0a2a838 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -288,7 +288,7 @@ static int meson_mmc_probe(struct udevice *dev)
>   
>   	mmc_set_clock(mmc, cfg->f_min, MMC_CLK_ENABLE);
>   
> -#ifdef CONFIG_MMC_PWRSEQ
> +#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
>   	/* Enable power if needed */
>   	ret = mmc_pwrseq_get_power(dev, cfg);
>   	if (!ret) {
> diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
> index 72c820ee6330..ad4529d6afa8 100644
> --- a/drivers/mmc/rockchip_dw_mmc.c
> +++ b/drivers/mmc/rockchip_dw_mmc.c
> @@ -145,7 +145,7 @@ static int rockchip_dwmmc_probe(struct udevice *dev)
>   
>   	host->fifo_mode = priv->fifo_mode;
>   
> -#ifdef CONFIG_MMC_PWRSEQ
> +#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
>   	/* Enable power if needed */
>   	ret = mmc_pwrseq_get_power(dev, &plat->cfg);
>   	if (!ret) {
> diff --git a/include/mmc.h b/include/mmc.h
> index 1022db3ffa7c..9aef31ea5deb 100644
> --- a/include/mmc.h
> +++ b/include/mmc.h
> @@ -590,7 +590,7 @@ struct mmc_config {
>   	uint f_max;
>   	uint b_max;
>   	unsigned char part_type;
> -#ifdef CONFIG_MMC_PWRSEQ
> +#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
>   	struct udevice *pwr_dev;
>   #endif
>   };
> @@ -808,7 +808,7 @@ int mmc_deinit(struct mmc *mmc);
>    */
>   int mmc_of_parse(struct udevice *dev, struct mmc_config *cfg);
>   
> -#ifdef CONFIG_MMC_PWRSEQ
> +#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
>   /**
>    * mmc_pwrseq_get_power() - get a power device from device tree
>    *

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
