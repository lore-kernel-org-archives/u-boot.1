Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AEBE7AD43
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FCA586D80;
	Tue,  3 Oct 2023 15:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WQeSD2KQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F7D486672; Tue,  3 Oct 2023 15:20:52 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 450FA86DDF
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32329d935d4so932900f8f.2
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 06:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696339248; x=1696944048; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=D2Q3dx5DjcgMxfcC+WcIYhO7m+VcD7KHy6pA9uIZNiA=;
 b=WQeSD2KQwdfMZoQ9QZLu4cjAQ5Ozg5WC4mX3U3yboqCVDuuQOIv1gB+2e+A+tqgc4e
 m8aM+VGibSuYfuyNr14Uhbe1rIXtbim9S9to8gDPb4vj6UuCa1CEnm5guSXPqwZIWAne
 8o+px9anKmHXGR9SNuz6ZnftZJGFbOjMi7g/Xx/exiGMgEBBvzM4c+hiWQeTptkzH32H
 gsinUj0HFlTfwNLYwLLbi7pJayADdGEVb/WJeRHTT7xa6SjXjoOiu0GZPKYVLhxItxxy
 3c6iHyNrjoLAwKeaeRj55yERhzGgfx8FWYgIyRzXSW62jdIJRvHLPZzLiTEcbGEWj4fs
 1vvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696339248; x=1696944048;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=D2Q3dx5DjcgMxfcC+WcIYhO7m+VcD7KHy6pA9uIZNiA=;
 b=Os6/t3qhGiOeWTeZL/jyaJkixE35DNWD525rnpIzi39Je+f4czCB6KszqKDMVwGQ0g
 MyLU0U5odyvYSBXJVvOC7B/dCD2jODzDZpoYAmlit/putJww6/WZ8zDe7/IdkiNJehY/
 GeIZhqHs3kD+PHaXOZ9e+YSLYXNlMOKbBgkwZGSpQF7I3Rqdgwk2+7Ti/2edfG/k5whT
 zQ80dB1UouWLIFg6HFRo04faaCcEsWSYK9CarfCpGOo5p7S+9RjJ2DmtJGXTJiPLPpww
 Spc5Os86ecu/KgJro91SJyInyjOFj3OGoEwk4P06YOYSYBwLv3Stv5ZfTgq9ixaiVdzx
 x1Vw==
X-Gm-Message-State: AOJu0Yz1Ot1XBY73sShA/u6T5qiRJHapjX0pZV4Eg7WJgUTOV/Y3A2VP
 CejHuW1Kl+oRYXm4Zq1ifYMIlg==
X-Google-Smtp-Source: AGHT+IFJwZROV/H500nKh71kCYXwmfHR/knR+uiczM0QdJmNlS7L4X7+HXzbVrm/CXvtk6AUGugdZQ==
X-Received: by 2002:a5d:63d2:0:b0:313:e953:65d0 with SMTP id
 c18-20020a5d63d2000000b00313e95365d0mr13500848wrw.28.1696339247487; 
 Tue, 03 Oct 2023 06:20:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e31a:fe1c:e925:9858?
 ([2a01:e0a:982:cbb0:e31a:fe1c:e925:9858])
 by smtp.gmail.com with ESMTPSA id
 f8-20020adfdb48000000b0031ff89af0e4sm1568213wrj.99.2023.10.03.06.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 06:20:47 -0700 (PDT)
Message-ID: <5d2f41d9-d98a-486d-b5da-6289dcffffea@linaro.org>
Date: Tue, 3 Oct 2023 15:20:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 5/8] phy: support Amlogic A1 family
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
References: <20231003112838.41503-1-avromanov@salutedevices.com>
 <20231003112838.41503-6-avromanov@salutedevices.com>
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
In-Reply-To: <20231003112838.41503-6-avromanov@salutedevices.com>
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

On 03/10/2023 13:28, Alexey Romanov wrote:
> Setting G12A and A1 is similar, so we can use G12A phy
> driver with little changes.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/phy/Kconfig           |  2 +-
>   drivers/phy/meson-g12a-usb2.c | 79 ++++++++++++++++++++++++++++-------
>   2 files changed, 66 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index cf4d5908d7..60be62907d 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -190,7 +190,7 @@ config MESON_GXL_USB_PHY
>   
>   config MESON_G12A_USB_PHY
>   	bool "Amlogic Meson G12A USB PHYs"
> -	depends on PHY && ARCH_MESON && MESON_G12A
> +	depends on PHY && ARCH_MESON && (MESON_G12A || MESON_A1)
>   	imply REGMAP
>   	help
>   	  This is the generic phy driver for the Amlogic Meson G12A
> diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
> index 7b028784a0..90053dbea3 100644
> --- a/drivers/phy/meson-g12a-usb2.c
> +++ b/drivers/phy/meson-g12a-usb2.c
> @@ -18,6 +18,7 @@
>   #include <regmap.h>
>   #include <linux/delay.h>
>   #include <power/regulator.h>
> +#include <power-domain.h>
>   #include <reset.h>
>   #include <clk.h>
>   
> @@ -146,18 +147,28 @@
>   #define RESET_COMPLETE_TIME					1000
>   #define PLL_RESET_COMPLETE_TIME					100
>   
> +enum meson_soc_id {
> +	MESON_SOC_A1,
> +	MESON_SOC_G12A,
> +};
> +
>   struct phy_meson_g12a_usb2_priv {
>   	struct regmap		*regmap;
>   #if CONFIG_IS_ENABLED(CLK)
>   	struct clk		clk;
>   #endif
>   	struct reset_ctl	reset;
> +#if CONFIG_IS_ENABLED(POWER_DOMAIN)
> +	struct power_domain pwrdm;
> +#endif
> +	int soc_id;
>   };
>   
>   static int phy_meson_g12a_usb2_init(struct phy *phy)
>   {
>   	struct udevice *dev = phy->dev;
>   	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
> +	u32 value;
>   	int ret;
>   
>   #if CONFIG_IS_ENABLED(CLK)
> @@ -196,8 +207,7 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
>   		FIELD_PREP(PHY_CTRL_R17_MPLL_FILTER_PVT2, 2) |
>   		FIELD_PREP(PHY_CTRL_R17_MPLL_FILTER_PVT1, 9));
>   
> -	regmap_write(priv->regmap, PHY_CTRL_R18,
> -		FIELD_PREP(PHY_CTRL_R18_MPLL_LKW_SEL, 1) |
> +	value = FIELD_PREP(PHY_CTRL_R18_MPLL_LKW_SEL, 1) |
>   		FIELD_PREP(PHY_CTRL_R18_MPLL_LK_W, 9) |
>   		FIELD_PREP(PHY_CTRL_R18_MPLL_LK_S, 0x27) |
>   		FIELD_PREP(PHY_CTRL_R18_MPLL_PFD_GAIN, 1) |
> @@ -209,6 +219,11 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
>   		FIELD_PREP(PHY_CTRL_R18_MPLL_ADJ_LDO, 1) |
>   		PHY_CTRL_R18_MPLL_ACG_RANGE;
>   
> +	if (priv->soc_id == MESON_SOC_A1)
> +		value |= PHY_CTRL_R18_MPLL_DCO_CLK_SEL;
> +
> +	regmap_write(priv->regmap, PHY_CTRL_R18, value);
> +
>   	udelay(PLL_RESET_COMPLETE_TIME);
>   
>   	/* UnReset PLL */
> @@ -231,13 +246,19 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
>   		FIELD_PREP(PHY_CTRL_R20_USB2_BGR_VREF_4_0, 0) |
>   		FIELD_PREP(PHY_CTRL_R20_USB2_BGR_DBG_1_0, 0));
>   
> -	regmap_write(priv->regmap, PHY_CTRL_R4,
> -		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_7_0, 0xf) |
> -		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_15_8, 0xf) |
> -		FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_23_16, 0xf) |
> -		PHY_CTRL_R4_TEST_BYPASS_MODE_EN |
> -		FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_1_0, 0) |
> -		FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_3_2, 0));
> +	if (priv->soc_id == MESON_SOC_G12A)
> +		regmap_write(priv->regmap, PHY_CTRL_R4,
> +			FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_7_0, 0xf) |
> +			FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_15_8, 0xf) |
> +			FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_23_16, 0xf) |
> +			PHY_CTRL_R4_TEST_BYPASS_MODE_EN |
> +			FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_1_0, 0) |
> +			FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_3_2, 0));
> +	else if (priv->soc_id == MESON_SOC_A1)
> +		regmap_write(priv->regmap, PHY_CTRL_R21,
> +			PHY_CTRL_R21_USB2_CAL_ACK_EN |
> +			PHY_CTRL_R21_USB2_TX_STRG_PD |
> +			FIELD_PREP(PHY_CTRL_R21_USB2_OTG_ACA_TRIM_1_0, 2));
>   
>   	/* Tuning Disconnect Threshold */
>   	regmap_write(priv->regmap, PHY_CTRL_R3,
> @@ -246,10 +267,15 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
>   		FIELD_PREP(PHY_CTRL_R3_DISC_THRESH, 3));
>   
>   	/* Analog Settings */
> -	regmap_write(priv->regmap, PHY_CTRL_R14, 0);
> -	regmap_write(priv->regmap, PHY_CTRL_R13,
> -		PHY_CTRL_R13_UPDATE_PMA_SIGNALS |
> -		FIELD_PREP(PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET, 7));
> +	if (priv->soc_id == MESON_SOC_G12A) {
> +		regmap_write(priv->regmap, PHY_CTRL_R14, 0);
> +		regmap_write(priv->regmap, PHY_CTRL_R13,
> +			PHY_CTRL_R13_UPDATE_PMA_SIGNALS |
> +			FIELD_PREP(PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET, 7));
> +	} else if (priv->soc_id == MESON_SOC_A1) {
> +		regmap_write(priv->regmap, PHY_CTRL_R13,
> +			FIELD_PREP(PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET, 7));
> +	}
>   
>   	return 0;
>   }
> @@ -281,6 +307,8 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
>   	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
>   	int ret;
>   
> +	priv->soc_id = (enum meson_soc_id)dev_get_driver_data(dev);
> +
>   	ret = regmap_init_mem(dev_ofnode(dev), &priv->regmap);
>   	if (ret)
>   		return ret;
> @@ -297,6 +325,22 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
>   		return ret;
>   	}
>   
> +#if CONFIG_IS_ENABLED(POWER_DOMAIN)
> +	ret = power_domain_get(dev, &priv->pwrdm);
> +	if (ret < 0 && ret != -ENODEV) {
> +		pr_err("failed to get power domain\n");
> +		return ret;
> +	}
> +
> +	if (ret != -ENODEV) {
> +		ret = power_domain_on(&priv->pwrdm);
> +		if (ret < 0) {
> +			pr_err("failed to enable power domain\n");
> +			return ret;
> +		}
> +	}
> +#endif
> +
>   #if CONFIG_IS_ENABLED(CLK)
>   	ret = clk_get_by_index(dev, 0, &priv->clk);
>   	if (ret < 0)
> @@ -307,7 +351,14 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
>   }
>   
>   static const struct udevice_id meson_g12a_usb2_phy_ids[] = {
> -	{ .compatible = "amlogic,g12a-usb2-phy" },
> +	{
> +		.compatible = "amlogic,g12a-usb2-phy",
> +		.data = (ulong)MESON_SOC_G12A,
> +	},
> +	{
> +		.compatible = "amlogic,a1-usb2-phy",
> +		.data = (ulong)MESON_SOC_A1,
> +	},
>   	{ }
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
