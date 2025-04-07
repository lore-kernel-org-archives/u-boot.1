Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEAAC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 07:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E56B182C87;
	Mon,  7 Apr 2025 09:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zySwr//L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CFF182CA2; Mon,  7 Apr 2025 09:31:07 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA6E082C55
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 09:31:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so14258095e9.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 00:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744011063; x=1744615863; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=/PzUkauJz6eUqsp2mAxyAZ/wmWS1LrZrN50sg9NQblE=;
 b=zySwr//LBMWigasHAgM2txizPeVsRvo+9TxK7u1mahtYszElg5mHL0AcRSoSIbWSIJ
 0mOq/vjWhJfLyAaYD7+NjRvehY0sxPHMuMbCG9ULr/YksswRvH9046fi2xSYzGbrHJJ1
 QSPIC69pqiIPNF2Ez5gd+2ZsTM09TjEI9+VEV94/JN38XoJl6Tl+F7k0NbVRBe4dcAz3
 EkmA+4Xt07pXYoKm4oxW+1ebruKyXvfHcXQSG2ggleMrpKYiC4AGUDddiZCMwGDGxMYe
 1m9fzyaQ+nrAm8ukcuUfAqWaoUMq82VDXV51ZIMGQjmFRmOYyG68HBoivNBUyyRc9cLp
 RChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744011063; x=1744615863;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/PzUkauJz6eUqsp2mAxyAZ/wmWS1LrZrN50sg9NQblE=;
 b=eWQjt9A92II1EXpnWmv3uT9velMKKVBvbUN8JsUiXLhKjfjkiiRIIkcqqJt2X4qh67
 IMK7paENd3Y+EL43kmLkxe19tVOSOGIEO8oC8qScJALfrqBJrbyQLwMWMOEccwwmGZLc
 SlSSJj8YhshSqX5PstYxt75JscwtMcSirBa3c2BcAqB+Yjdoa2lG2nqss3+6tWnqhj3L
 cCGJ9dp+HR/1DG2+dYzzql73Nf6t+/RCANjwqzAquKSq7p/HXGCxo6iUkGz26j2LOUIY
 wr9NKx3EQReRtYANVoxW0AtUcCQ24TuMktvB15Mavb8g78XKJlGvcWMBMoBo6tBNHR7Z
 u/zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6hfxU02wg0bB93U5yrfwDcJ9o47k1+NQIaXjtzSt6p/Z8JNGqFCHbMvDrZTU36R7hTyaffCw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy82Zt4NVUicqAZap6WMPxPMl/2AAwjsmrUbdMtyJ4C4LZcRKZv
 1RzsqqNpplKKcYi22+fJFwXf0mC4KiOT9xfD29oO7ZXS0CrC7/woFUlHky2OI5U=
X-Gm-Gg: ASbGncvx5ZWMl6m0OXK/gXG4PUjZuyU+IubB76Tw21dXPmbEmEEDMx4hlFDHskkycLM
 hMaJubztKEX2C+v8X1hYw9G+rGZONBYyqUaIh1JpUVVdceNVFty1Y0w2C37ZxceBlCntCQFYl9R
 60PAmxR8+jDbej5l1Q4/z1MzbbMKdI+sO1NSB5eQ3YCBvyfHQ3Gj2cSaySHN8xLSa17eNOJ6TaZ
 gsw6YjDajOCYundvi8JDAa/vWmx/YRC3cD4644jy/p4bMPa4AyO77q6oZyGz1bGF8xfMrrDe7qf
 eizpbrs5qAUpWZf+HxbaDxnJCiTfPHkTWrxnjfPQMEd1C/tqmL3fKtm10KJ7Jv+sJhTeR/iXW7g
 4Cmc8qZnlxq8uCimj6f1ONA==
X-Google-Smtp-Source: AGHT+IEDQ9y5nKH2og5UFcQiDQvnJ3oIwDc2EBPuXms0Q1hXL+7/sBqoCgHUKa+sbp0I4TcNFFY7Cg==
X-Received: by 2002:a05:600c:3109:b0:43c:f629:66f4 with SMTP id
 5b1f17b1804b1-43ecf57edb7mr120838525e9.0.1744011063015; 
 Mon, 07 Apr 2025 00:31:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1f27a55sm123104595e9.2.2025.04.07.00.31.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 00:31:02 -0700 (PDT)
Message-ID: <5d894819-119a-44ed-b3aa-5f99e54c76c6@linaro.org>
Date: Mon, 7 Apr 2025 09:31:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/4] designware: Use the remove() method with related
 drivers
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot-amlogic@groups.io
References: <20250407013513.638110-1-sjg@chromium.org>
 <20250407013513.638110-2-sjg@chromium.org>
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
In-Reply-To: <20250407013513.638110-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 07/04/2025 03:35, Simon Glass wrote:
> Several drivers make use of the designware Ethernet driver but do not
> implement the remove() method. Add this to keep things tidy.
> 
> Note that the Ethernet uclass calls each driver's stop() method on
> removal, so there is no need to do that here.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reported-by: Christian Kohlschütter <christian@kohlschutter.com>
> ---
> 
> Changes in v2:
> - Use the designware_eth_remove() method directly
> - Add gmac_rockchip too
> - Reword the commit message to mention the uclass' actions
> 
>   drivers/net/designware.c    |  2 +-
>   drivers/net/designware.h    | 12 ++++++++++++
>   drivers/net/dwmac_meson8b.c |  1 +
>   drivers/net/dwmac_s700.c    |  1 +
>   drivers/net/dwmac_socfpga.c |  1 +
>   drivers/net/gmac_rockchip.c |  1 +
>   6 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> index 07b0f49ef58..5385849ea6b 100644
> --- a/drivers/net/designware.c
> +++ b/drivers/net/designware.c
> @@ -805,7 +805,7 @@ clk_err:
>   	return err;
>   }
>   
> -static int designware_eth_remove(struct udevice *dev)
> +int designware_eth_remove(struct udevice *dev)
>   {
>   	struct dw_eth_dev *priv = dev_get_priv(dev);
>   
> diff --git a/drivers/net/designware.h b/drivers/net/designware.h
> index e47101ccaf6..8c9d0190e03 100644
> --- a/drivers/net/designware.h
> +++ b/drivers/net/designware.h
> @@ -247,6 +247,18 @@ struct dw_eth_dev {
>   
>   int designware_eth_of_to_plat(struct udevice *dev);
>   int designware_eth_probe(struct udevice *dev);
> +
> +/**
> + * designware_eth_remove() - Remove the device
> + *
> + * Disables DMA and marks the device as remove. This must be called before
> + * booting an OS, to ensure that DMA is inactive.
> + *
> + * @dev: Device to remove
> + * Return 0 if OK, -ve on error
> + */
> +int designware_eth_remove(struct udevice *dev);
> +
>   extern const struct eth_ops designware_eth_ops;
>   
>   struct dw_eth_pdata {
> diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
> index fde4aabbace..bf94e50842d 100644
> --- a/drivers/net/dwmac_meson8b.c
> +++ b/drivers/net/dwmac_meson8b.c
> @@ -158,6 +158,7 @@ U_BOOT_DRIVER(dwmac_meson8b) = {
>   	.of_match	= dwmac_meson8b_ids,
>   	.of_to_plat = dwmac_meson8b_of_to_plat,
>   	.probe		= dwmac_meson8b_probe,
> +	.remove		= designware_eth_remove,
>   	.ops		= &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
>   	.plat_auto	= sizeof(struct dwmac_meson8b_plat),
> diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
> index 969d247b4f3..e78193f3376 100644
> --- a/drivers/net/dwmac_s700.c
> +++ b/drivers/net/dwmac_s700.c
> @@ -60,6 +60,7 @@ U_BOOT_DRIVER(dwmac_s700) = {
>   	.of_match = dwmac_s700_ids,
>   	.of_to_plat = dwmac_s700_of_to_plat,
>   	.probe  = dwmac_s700_probe,
> +	.remove	= designware_eth_remove,
>   	.ops    = &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
>   	.plat_auto	= sizeof(struct eth_pdata),
> diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
> index a9e2d8c0972..dda33f90d65 100644
> --- a/drivers/net/dwmac_socfpga.c
> +++ b/drivers/net/dwmac_socfpga.c
> @@ -141,6 +141,7 @@ U_BOOT_DRIVER(dwmac_socfpga) = {
>   	.of_match	= dwmac_socfpga_ids,
>   	.of_to_plat = dwmac_socfpga_of_to_plat,
>   	.probe		= dwmac_socfpga_probe,
> +	.remove		= designware_eth_remove,
>   	.ops		= &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
>   	.plat_auto	= sizeof(struct dwmac_socfpga_plat),
> diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
> index 8cfeeffe95b..5c542d62bd8 100644
> --- a/drivers/net/gmac_rockchip.c
> +++ b/drivers/net/gmac_rockchip.c
> @@ -756,6 +756,7 @@ U_BOOT_DRIVER(eth_gmac_rockchip) = {
>   	.of_match = rockchip_gmac_ids,
>   	.of_to_plat = gmac_rockchip_of_to_plat,
>   	.probe	= gmac_rockchip_probe,
> +	.remove	= designware_eth_remove,
>   	.ops	= &gmac_rockchip_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
>   	.plat_auto	= sizeof(struct gmac_rockchip_plat),

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
