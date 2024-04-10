Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7002CD1296
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 08:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F3F788120;
	Wed, 10 Apr 2024 10:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zhskD86D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA2B870AB; Wed, 10 Apr 2024 10:41:32 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA1288120
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-516d09bd434so7086079e87.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 01:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712738490; x=1713343290; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=0tpoiP1WVK3Dot6TsClbeh5UTExgKtFRAeW3xuDk604=;
 b=zhskD86DbdwxZ2SSN9XPbnhknk4bXabc5iEh6d8WYd6laC6qsYFUUU+gIFCvTi5Ivu
 nrZ9KPZ/9923cQmoYuyEpaW7mHFx/Ly+2iYFzkHxVHq/SrZyN8ycisA5cxIuXl/Jcb5l
 ixctSna7fLKpNMWpakwXmJlDVJsYEQsGvEhxhGaQtcj+rK+XJ7ffDoCBTrJUdIfqGZgB
 JXrP07X/u9I7qJK1RCGOlA2bnVox4r9nzEaUzbcJWfUKyWL/3e/zBZhl9Xo+l8d3rdf7
 7b37CV/aQqE+OkXnZ3QJz+x0hNHP9dA5JzVCfrcgm83IyK+B04deRIcB2G2JG0R2uWk4
 wQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712738490; x=1713343290;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0tpoiP1WVK3Dot6TsClbeh5UTExgKtFRAeW3xuDk604=;
 b=ayA1qpUrEINDoYaptOv36DE51K4OXyAG2A2eNxJ8pWZByK0qahriUM0JKtpKOJX/S6
 TwMR1IIK5e90Ob7JE5+Kn2He+t/CmDTdQsPDohL5INr+qEP7+Fv5y7CJSeKnhxRFRCnh
 iqUBGD11mxQgLhR/BJ1PumW6XXgEt+yjGAoiCMvLFqiVldUYdavONIOUJfjguEucPvQw
 QKIvdFQiKWvu7/UupAjk6EcMvHuObBzT3GfpOA0QS2zC3ARrN2PEqtXZ5q01zNO5C3L4
 L0NAKqivi8iIv40EZ0YTg399aW7E9CChEbo1kjXvC2NYpjeJE6k3sbcFgdXOHz8DnFOQ
 gxlA==
X-Gm-Message-State: AOJu0Yxwx6EKEXV+t6141y+MkGWdiAlYKN7itlIafqgm8e+p6KmrKXfV
 /mSjwQ7v5IUoengNvP4ZtAP+UcL6lK/TRvKPpcdA5WuJH0QOsz7lSPpYFP1hVu0=
X-Google-Smtp-Source: AGHT+IHth31AtHva/v4oFH5RNuJpBetyWFnmASYJ0Tr91kGAswh05iwza5+yvPutMkAzpjpB0NSO/g==
X-Received: by 2002:a05:6512:4dd:b0:515:90e5:4555 with SMTP id
 w29-20020a05651204dd00b0051590e54555mr1036500lfq.16.1712738489788; 
 Wed, 10 Apr 2024 01:41:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7b0c:6cd:4afa:674b?
 ([2a01:e0a:982:cbb0:7b0c:6cd:4afa:674b])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a5d6710000000b00343956e8852sm13286337wru.42.2024.04.10.01.41.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 01:41:29 -0700 (PDT)
Message-ID: <51f7133f-2204-421f-9b21-40657fde5f37@linaro.org>
Date: Wed, 10 Apr 2024 10:41:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/7] mmc: msm_sdhci: use modern DT handling
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
 <20240409-b4-qcom-mmc-fixes-v1-2-5039164ecbf7@linaro.org>
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
In-Reply-To: <20240409-b4-qcom-mmc-fixes-v1-2-5039164ecbf7@linaro.org>
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

On 09/04/2024 20:03, Caleb Connolly wrote:
> using fdtdec_* functions is incompatible with OF_LIVE and generally
> offers a less friendly interface. Update to use dev_read_* functions
> instead.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/mmc/msm_sdhci.c | 28 +++++++++++++++++++---------
>   1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index f23d425144ef..5689b4765122 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -205,9 +205,9 @@ static int msm_sdc_remove(struct udevice *dev)
>   
>   	var_info = (void *)dev_get_driver_data(dev);
>   
>   	/* Disable host-controller mode */
> -	if (!var_info->mci_removed)
> +	if (!var_info->mci_removed && priv->base)
>   		writel(0, priv->base + SDCC_MCI_HC_MODE);
>   
>   	clk_release_bulk(&priv->clks);
>   
> @@ -215,23 +215,33 @@ static int msm_sdc_remove(struct udevice *dev)
>   }
>   
>   static int msm_of_to_plat(struct udevice *dev)
>   {
> -	struct udevice *parent = dev->parent;
>   	struct msm_sdhc *priv = dev_get_priv(dev);
> +	const struct msm_sdhc_variant_info *var_info;
>   	struct sdhci_host *host = &priv->host;
> -	int node = dev_of_offset(dev);
> +	int ret;
> +
> +	var_info = (void*)dev_get_driver_data(dev);
>   
>   	host->name = strdup(dev->name);
>   	host->ioaddr = dev_read_addr_ptr(dev);
> -	host->bus_width = fdtdec_get_int(gd->fdt_blob, node, "bus-width", 4);
> -	host->index = fdtdec_get_uint(gd->fdt_blob, node, "index", 0);
> -	priv->base = (void *)fdtdec_get_addr_size_auto_parent(gd->fdt_blob,
> -			dev_of_offset(parent), node, "reg", 1, NULL, false);
> -	if (priv->base == (void *)FDT_ADDR_T_NONE ||
> -	    host->ioaddr == (void *)FDT_ADDR_T_NONE)
> +	ret = dev_read_u32(dev, "bus-width", &host->bus_width);
> +	if (ret)
> +		host->bus_width = 4;
> +	ret = dev_read_u32(dev, "index", &host->index);
> +	if (ret)
> +		host->index = 0;
> +	priv->base = dev_read_addr_index_ptr(dev, 1);
> +
> +	if (!host->ioaddr)
>   		return -EINVAL;
>   
> +	if (!var_info->mci_removed && !priv->base) {
> +		printf("msm_sdhci: MCI base address not found\n");
> +		return -EINVAL;
> +	}
> +
>   	return 0;
>   }
>   
>   static int msm_sdc_bind(struct udevice *dev)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
