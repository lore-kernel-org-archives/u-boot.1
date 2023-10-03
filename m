Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078DCE7542D
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 07:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FD1587259;
	Tue,  3 Oct 2023 09:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XKEAzoC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17D6887236; Tue,  3 Oct 2023 09:25:54 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D5087274
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 09:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-323ef9a8b59so605135f8f.3
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 00:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696317951; x=1696922751; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=uRpSIp615rSgorl7ZN5XH35mOJr2XFYUgEk86KUPY44=;
 b=XKEAzoC5jBXoX8DaRrd23HQLbkRCJTw87nZ7gPpi1+a4wzRypaW6/CQl+cg9Qd8KRY
 62praiMTq2g6q1SEgKYK0d7nXTgIUq/w0H5heFVas/KeQFUFpvshukqIndmONb6bLdnh
 FQSmKsRRvDcRO7RrGlKuoi2w0aXH6GMogPvCFyxz5AQ/eHEE4hByH7PEO2GsEpkDMvEn
 zLkYzqwpsXVbeu8+lp2MRWXrNIXi8+md9vI2RxcFoZmGxzaf1jtyw4j5JNhoMivMlbQg
 cil3f8kHlwhz3X0OI9mL9LFaxGhIu2/veCdTBSR7MxOkh4i98gVtcC+HXPmCwsSDPdkX
 MBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696317951; x=1696922751;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uRpSIp615rSgorl7ZN5XH35mOJr2XFYUgEk86KUPY44=;
 b=YSqizxJ/ybEac4jYsa8tnfHL8VastP/lzjRWpldvRME9IFlaecxrQFsyf+c2qcq3qg
 5xUejaJTlt2It88slusCba2Koy+XSituSViAqUfr/GS1Zg3m5NSVBp1OqakBtbbizZdX
 4YVm0YkEMQlPGooMfo8ymOgPW+D4ZfvfAYEvwnFDSDxd69HdTRrJE8KoqRreTgVxbXhS
 1zL98g4q2bQoKgvqt4gPgHQnLXfoNxuPP3OegUsJiwP2LaO/LrFJlS4jIQLYl+sjwrvS
 sAA+DRdb6XZrXVZxC1mqOXOVDbxMpX3RtclaQbGFC8ChfZx6E7z1q29TPUiPdWf4HYZO
 9jjQ==
X-Gm-Message-State: AOJu0Yyh+Y51LNBY+rdBLMYnpiOYCkoOPm/A/Z2bOcsbmeejpgieI99h
 FuhFe5/d4A2pryuSa7x4TTQlwg==
X-Google-Smtp-Source: AGHT+IHpxICqTPr/UHG7UgVWeTEFvTaSeTYAy02zvROIEN+pZiSy/rf59XSL5EbxX8nOH37matEbHg==
X-Received: by 2002:a5d:5304:0:b0:31f:f9fb:d5bd with SMTP id
 e4-20020a5d5304000000b0031ff9fbd5bdmr11646658wrv.68.1696317950759; 
 Tue, 03 Oct 2023 00:25:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e31a:fe1c:e925:9858?
 ([2a01:e0a:982:cbb0:e31a:fe1c:e925:9858])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a5d444f000000b0031c5e9c2ed7sm865579wrr.92.2023.10.03.00.25.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 00:25:50 -0700 (PDT)
Message-ID: <c4e8ac42-cef6-442d-8d0f-ea91a34cc6e0@linaro.org>
Date: Tue, 3 Oct 2023 09:25:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 4/8] phy: move clk enable/disable in init/exit
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
References: <20231002165857.19512-1-avromanov@salutedevices.com>
 <20231002165857.19512-5-avromanov@salutedevices.com>
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
In-Reply-To: <20231002165857.19512-5-avromanov@salutedevices.com>
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

On 02/10/2023 18:58, Alexey Romanov wrote:
> It is better to place clk_enable() in phy_meson_g12a_usb2_init()
> and clk_disable() in phy_meson_g12a_usb2_exit().
> 
> For more detailed information, please see comments in the review of
> a similar driver in the Linux Kernel:
> 
> https://lore.kernel.org/all/CAFBinCCEhobbyKHuKDWzTYCQWgNT1-e8=7hMhq1mvT6CuEOjGw@mail.gmail.com/
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/phy/meson-g12a-usb2.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
> index 2e366b16ae..7b028784a0 100644
> --- a/drivers/phy/meson-g12a-usb2.c
> +++ b/drivers/phy/meson-g12a-usb2.c
> @@ -160,6 +160,14 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
>   	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
>   	int ret;
>   
> +#if CONFIG_IS_ENABLED(CLK)
> +	ret = clk_enable(&priv->clk);
> +	if (ret && ret != -ENOSYS && ret != -ENOTSUPP) {
> +		pr_err("failed to enable PHY clock\n");
> +		return ret;
> +	}
> +#endif
> +
>   	ret = reset_assert(&priv->reset);
>   	udelay(1);
>   	ret |= reset_deassert(&priv->reset);
> @@ -252,6 +260,10 @@ static int phy_meson_g12a_usb2_exit(struct phy *phy)
>   	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
>   	int ret;
>   
> +#if CONFIG_IS_ENABLED(CLK)
> +	clk_disable(&priv->clk);
> +#endif
> +
>   	ret = reset_assert(&priv->reset);
>   	if (ret)
>   		return ret;
> @@ -289,13 +301,6 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
>   	ret = clk_get_by_index(dev, 0, &priv->clk);
>   	if (ret < 0)
>   		return ret;
> -
> -	ret = clk_enable(&priv->clk);
> -	if (ret && ret != -ENOSYS && ret != -ENOTSUPP) {
> -		pr_err("failed to enable PHY clock\n");
> -		clk_free(&priv->clk);
> -		return ret;
> -	}
>   #endif
>   
>   	return 0;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
