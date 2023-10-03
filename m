Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28788E7542D
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 07:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 885918723B;
	Tue,  3 Oct 2023 09:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N5pMYf4C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 444D487222; Tue,  3 Oct 2023 09:25:31 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35E968724B
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 09:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32488a22810so569625f8f.3
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 00:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696317927; x=1696922727; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CQhOFoEAhUQ8MM8lzRTBmRbrIKO+On2/xFqVETc6Fsc=;
 b=N5pMYf4CJtbxmEmqSH0bNKg2JGgTVAbDPwAqBLYJAMLqSWGzgfihrolAZoMzVhFYrq
 hZT4SVX9MRKO8Mj0jMZYVNvhcEdPZOnviKqeh70D5i9lCwb2CODc8z+w1V03aC2K1Xer
 ZcJ1Tts3z3L+/mv7au0M7BAL7fkoDFQL66qDb495mr5sRi44ig3ZTcwyh91N82/l1cVt
 FSSoKohV2x7NOpzsp/taSscFJaDm+/A4DBLsttj16QG7P9VwjrzydeNtE9iblepqt4oE
 h3SeE50opJK5/5pp8PMEile5cbYF3jbtZyuB3y307kal9RLOY671mK1NsBWqDk/F6Fe/
 Uxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696317927; x=1696922727;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CQhOFoEAhUQ8MM8lzRTBmRbrIKO+On2/xFqVETc6Fsc=;
 b=aOmcloo/ONtmtTXTzGw3onEOBB1oqJXfvTJ/EdpriITlWhms/Gn85u9kpEvezscxBa
 LHmgHodKyMfnkLOa1uZ0ddbnHrW4kiB6AzBYuW6d/xARhdx5KyHGoXUfPy1ai/5cnKyq
 p9q/kfN20kCvIYFZtlZz+jAo+DgAvazt5/94u4XkPHX+tkabJ2pwCyu/qOYWvWnuH0wJ
 y979iNZHq//Ey2QylB81998VmhYT4JlI0APUQu3/g+3NwgfvHEdMv0GQrvoRU/rXuCE5
 PtR+t3yKbRuxuF0OlMYVOeI5WSA3nDX4G/zVTW7IlVkiznDTUY/joHUNGzvBVCPqflxu
 Rb1A==
X-Gm-Message-State: AOJu0YzHD8hqtb+EjnJfxDVT2uLeWhF4EKAfRczGXhq7NjLhBd4PLZTH
 xU9sYnGv3Kzi5oerKY+OFK6m/1Wk1eGUnlUOdoxz2h6E
X-Google-Smtp-Source: AGHT+IEhOJkUPiRUCm79nhg/DAVEMjK+6tFZDySwVkECnZuQkSzEdlOBYfdvza6k/YNT+FGVn6h0SQ==
X-Received: by 2002:adf:de11:0:b0:319:74b5:b67d with SMTP id
 b17-20020adfde11000000b0031974b5b67dmr11301055wrm.66.1696317927575; 
 Tue, 03 Oct 2023 00:25:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e31a:fe1c:e925:9858?
 ([2a01:e0a:982:cbb0:e31a:fe1c:e925:9858])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a5d444f000000b0031c5e9c2ed7sm865579wrr.92.2023.10.03.00.25.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 00:25:27 -0700 (PDT)
Message-ID: <090b7afc-38e0-4fda-a143-b8737e24bc0d@linaro.org>
Date: Tue, 3 Oct 2023 09:25:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/8] reset: add support for Amlogic A1 family
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
References: <20231002165857.19512-1-avromanov@salutedevices.com>
 <20231002165857.19512-3-avromanov@salutedevices.com>
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
In-Reply-To: <20231002165857.19512-3-avromanov@salutedevices.com>
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
> This patch adds reset support for the Amlogic A1 family.
> We add the structure meson_reset_drvdata, which in the future
> will allow this driver to be used for other families by declaring
> only the correct parameters reg_count and level_offset.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/reset/reset-meson.c | 42 +++++++++++++++++++++++++++++++------
>   1 file changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 64bc696f13..9d0c8b354f 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -13,18 +13,26 @@
>   #include <reset-uclass.h>
>   #include <regmap.h>
>   #include <linux/bitops.h>
> +#include <linux/delay.h>
>   
> -#define REG_COUNT	8
>   #define BITS_PER_REG	32
> -#define LEVEL_OFFSET	0x7c
> +
> +struct meson_reset_drvdata {
> +	unsigned int reg_count;
> +	unsigned int level_offset;
> +};
>   
>   struct meson_reset_priv {
>   	struct regmap *regmap;
> +	struct meson_reset_drvdata *drvdata;
>   };
>   
>   static int meson_reset_request(struct reset_ctl *reset_ctl)
>   {
> -	if (reset_ctl->id > (REG_COUNT * BITS_PER_REG))
> +	struct meson_reset_priv *priv = dev_get_priv(reset_ctl->dev);
> +	struct meson_reset_drvdata *data = priv->drvdata;
> +
> +	if (reset_ctl->id > (data->reg_count * BITS_PER_REG))
>   		return -EINVAL;
>   
>   	return 0;
> @@ -33,9 +41,10 @@ static int meson_reset_request(struct reset_ctl *reset_ctl)
>   static int meson_reset_level(struct reset_ctl *reset_ctl, bool assert)
>   {
>   	struct meson_reset_priv *priv = dev_get_priv(reset_ctl->dev);
> +	struct meson_reset_drvdata *data = priv->drvdata;
>   	uint bank = reset_ctl->id / BITS_PER_REG;
>   	uint offset = reset_ctl->id % BITS_PER_REG;
> -	uint reg_offset = LEVEL_OFFSET + (bank << 2);
> +	uint reg_offset = data->level_offset + (bank << 2);
>   	uint val;
>   
>   	regmap_read(priv->regmap, reg_offset, &val);
> @@ -64,15 +73,36 @@ struct reset_ops meson_reset_ops = {
>   	.rst_deassert = meson_reset_deassert,
>   };
>   
> +static const struct meson_reset_drvdata meson_gxbb_data = {
> +	.reg_count = 8,
> +	.level_offset = 0x7c,
> +};
> +
> +static const struct meson_reset_drvdata meson_a1_data = {
> +	.reg_count = 3,
> +	.level_offset = 0x40,
> +};
> +
>   static const struct udevice_id meson_reset_ids[] = {
> -	{ .compatible = "amlogic,meson-gxbb-reset" },
> -	{ .compatible = "amlogic,meson-axg-reset" },
> +	{
> +		.compatible = "amlogic,meson-gxbb-reset",
> +		.data = (ulong)&meson_gxbb_data,
> +	},
> +	{
> +		.compatible = "amlogic,meson-axg-reset",
> +		.data = (ulong)&meson_gxbb_data,
> +	},
> +	{
> +		.compatible = "amlogic,meson-a1-reset",
> +		.data = (ulong)&meson_a1_data,
> +	},
>   	{ }
>   };
>   
>   static int meson_reset_probe(struct udevice *dev)
>   {
>   	struct meson_reset_priv *priv = dev_get_priv(dev);
> +	priv->drvdata = (struct meson_reset_drvdata *)dev_get_driver_data(dev);
>   
>   	return regmap_init_mem(dev_ofnode(dev), &priv->regmap);
>   }

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
