Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F975CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 11:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D98A586DF7;
	Thu, 12 Oct 2023 13:38:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qfFyQJBu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E186886E15; Thu, 12 Oct 2023 13:37:45 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94FA086D0C
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 13:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4065f29e933so9953445e9.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 04:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697110659; x=1697715459; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=xNYM4I7N3U4ZmgbKW9A7xk7r2mOYAqNVK7YXs+0TTVc=;
 b=qfFyQJBu5NTDmdCWZcdiqjqU87QNsgbykgD0PNnV5CzG/iRUpJXMvPPMDRIYj8F6fk
 3O4SXEIy0x1CNHf7EtyZQ31t94J9DsE7hzcDZ5MA5CpGs0TiZ+fQUBlIhJHf2+z/xd+P
 jHKe/gCUrD/WBddmJnSvR3b+EPard8HmbAXZAGcXIeNn22oX3As973Q1zUDZUMD/40zR
 2LsT55GFxU9q8FmY+vawr6UJi1o+iSQhdTaB/KQQ3JnsYRaZla7wsIoOp0ZwxMYV7P6H
 aDHPLd/DlL4mPSap70uo69oHRshfy6dW6K9rq58q1pFer7z2vZpj27e/k1Lcpo9xJlGZ
 sO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697110659; x=1697715459;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xNYM4I7N3U4ZmgbKW9A7xk7r2mOYAqNVK7YXs+0TTVc=;
 b=sUUxACgapCv6yw6v643g746HjGUKgowveTi81NTeTwnjPGQX/PxrXw+LD1BhXqWI9H
 f8ucshlcRrNcexLBQbiygTUnIevbQHyWTiWmGyj1qLEqKIzF0QdNKUfffyGL0RccLlJu
 7dNXPmYjdScV1awJ1x2qH0kmenuOW9c9WHViiVUDMspv8G7SVZvuLfQJphGLx4bXtRTI
 wjwxC+lwnNkNRoVeBe5vQlHdCjL5iRxgLt9e2ERduW39UMLny1qXhPUrKWcW33d0bVPC
 1VJUbOsCoKUxTFL8mDHw/UxkCmMoFtlkPizNo5dMt41+j/mjq1muKQXlDZ/5cbdTThma
 +I4Q==
X-Gm-Message-State: AOJu0YwssazBY5eFKO0XasR3IWkuboAXmToU/QOYYgnFMgHR6EGaMzel
 qvrCD3uJddhZ+WBpZ4lRaqhXkQ==
X-Google-Smtp-Source: AGHT+IEElUhyVkAhgz4LTEwYR4jrfvFqsdox9upvTEC5L/bVVfzh0RJ6PYl4IuwuWUphrzHZViSR/A==
X-Received: by 2002:adf:b646:0:b0:32d:7bb1:b05e with SMTP id
 i6-20020adfb646000000b0032d7bb1b05emr4957512wre.42.1697110658747; 
 Thu, 12 Oct 2023 04:37:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:d423:df8b:7f17:7909?
 ([2a01:e0a:982:cbb0:d423:df8b:7f17:7909])
 by smtp.gmail.com with ESMTPSA id
 ce9-20020a5d5e09000000b0032d687fd9d0sm6560581wrb.19.2023.10.12.04.37.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 04:37:38 -0700 (PDT)
Message-ID: <98cad3c6-eaac-4efe-b7af-4c1d496051ab@linaro.org>
Date: Thu, 12 Oct 2023 13:37:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 1/1] drivers: rng: add support for Meson S4
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 sughosh.ganu@linaro.org, xypron.glpk@gmx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
References: <20231012075828.22685-1-avromanov@salutedevices.com>
 <20231012075828.22685-2-avromanov@salutedevices.com>
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
Organization: Linaro Developer Services
In-Reply-To: <20231012075828.22685-2-avromanov@salutedevices.com>
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

On 12/10/2023 09:58, Alexey Romanov wrote:
> For some Amlogic SOC's, mechanism to obtain random number
> has been changed. For example, S4 now uses status bit waiting algo.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/rng/meson-rng.c | 72 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rng/meson-rng.c b/drivers/rng/meson-rng.c
> index e0a1e8c7e0..fd2988e91b 100644
> --- a/drivers/rng/meson-rng.c
> +++ b/drivers/rng/meson-rng.c
> @@ -10,10 +10,23 @@
>   #include <dm.h>
>   #include <rng.h>
>   #include <asm/io.h>
> +#include <linux/iopoll.h>
> +
> +#define RNG_DATA	0x00
> +#define RNG_S4_DATA	0x08
> +#define RNG_S4_CFG	0x00
> +
> +#define RUN_BIT		BIT(0)
> +#define SEED_READY_STS_BIT	BIT(31)
> +
> +struct meson_rng_priv {
> +	u32 (*read)(fdt_addr_t base);
> +};
>   
>   struct meson_rng_plat {
>   	fdt_addr_t base;
>   	struct clk clk;
> +	struct meson_rng_priv *priv;
>   };
>   
>   /**
> @@ -27,10 +40,11 @@ struct meson_rng_plat {
>   static int meson_rng_read(struct udevice *dev, void *data, size_t len)
>   {
>   	struct meson_rng_plat *pdata = dev_get_plat(dev);
> +	struct meson_rng_priv *priv = pdata->priv;
>   	char *buffer = (char *)data;
>   
>   	while (len) {
> -		u32 rand = readl(pdata->base);
> +		u32 rand = priv->read(pdata->base);
>   		size_t step;
>   
>   		if (len >= 4)
> @@ -44,6 +58,47 @@ static int meson_rng_read(struct udevice *dev, void *data, size_t len)
>   	return 0;
>   }
>   
> +static int meson_rng_wait_status(void __iomem *cfg_addr, int bit)
> +{
> +	u32 status = 0;
> +	int ret;
> +
> +	ret = readl_relaxed_poll_timeout(cfg_addr,
> +					 status, !(status & bit),
> +					 10000);
> +	if (ret)
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
> +static u32 meson_common_rng_read(fdt_addr_t base)
> +{
> +	return readl(base);
> +}
> +
> +static u32 meson_s4_rng_read(fdt_addr_t base)
> +{
> +	void __iomem *cfg_addr = (void *)base + RNG_S4_CFG;
> +	int err;
> +
> +	writel_relaxed(readl_relaxed(cfg_addr) | SEED_READY_STS_BIT, cfg_addr);
> +
> +	err = meson_rng_wait_status(cfg_addr, SEED_READY_STS_BIT);
> +	if (err) {
> +		pr_err("Seed isn't ready, try again\n");
> +		return err;
> +	}
> +
> +	err = meson_rng_wait_status(cfg_addr, RUN_BIT);
> +	if (err) {
> +		pr_err("Can't get random number, try again\n");
> +		return err;
> +	}
> +
> +	return readl_relaxed(base + RNG_S4_DATA);
> +}
> +
>   /**
>    * meson_rng_probe() - probe rng device
>    *
> @@ -59,6 +114,8 @@ static int meson_rng_probe(struct udevice *dev)
>   	if (err)
>   		return err;
>   
> +	pdata->priv = (struct meson_rng_priv *)dev_get_driver_data(dev);
> +
>   	return 0;
>   }
>   
> @@ -102,9 +159,22 @@ static const struct dm_rng_ops meson_rng_ops = {
>   	.read = meson_rng_read,
>   };
>   
> +static const struct meson_rng_priv meson_rng_priv = {
> +	.read = meson_common_rng_read,
> +};
> +
> +static const struct meson_rng_priv meson_rng_priv_s4 = {
> +	.read = meson_s4_rng_read,
> +};
> +
>   static const struct udevice_id meson_rng_match[] = {
>   	{
>   		.compatible = "amlogic,meson-rng",
> +		.data = (ulong)&meson_rng_priv,
> +	},
> +	{
> +		.compatible = "amlogic,meson-s4-rng",
> +		.data = (ulong)&meson_rng_priv_s4,
>   	},
>   	{},
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
