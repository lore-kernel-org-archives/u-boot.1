Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AD9C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 09:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 763B082CF5;
	Mon,  7 Apr 2025 11:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BKQUEbt6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DCB182D17; Mon,  7 Apr 2025 11:02:58 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB5C982CF4
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 11:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so29518865e9.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 02:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744016575; x=1744621375; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=u+rzT3uPZDpQ+1X9XeciAuNlOrZG7N3NjG/D7ztro4I=;
 b=BKQUEbt67pW73JGYigYCvweH1CcMQyKRE77ALpRobjh0U4OVd2yfBB/UerMNeF3fjd
 CMJp0sdr8N0svPRIu5IR9sLhqxEo3SC+BAtEYOcByBUgYTX9nP/zfHzfqlTluk3Hcev+
 iG4EcwKL3UuG8/D39s/Ocz7pZ2fdXWhu4FrYL+G86DrsN5AQPtoCBTH0OkL9Z39IzL4z
 glUAY19xDPoJ4d0JEN37SDOR40MfBtxE5vpoE5Eku+CZa5tTsS8odZKfM29VtQJpb+iu
 0GzwE7w82hHxfU8cGUv0fYgJpjePLuanoEfNSJhleZPRJ8vCHXeItDXowNRlq4DlQNhU
 zorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744016575; x=1744621375;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=u+rzT3uPZDpQ+1X9XeciAuNlOrZG7N3NjG/D7ztro4I=;
 b=PPu1U1/X5htStlROge1enxdmuf+IhjO0K23eWPjK86V6u7hxgJeYCWXruOEJr3FwqA
 eYYNvMBSEqmH2ltRTyDXz4IGRkkczIgdZy+Mz/lSHFartLv6p1oywATKjYpzGE//ydTE
 FDk2VpVpkHweSnA1eXeordEE4hWfAGBhrcD8DRK347P/Sfs1Ch9M/V4FvrKT6eZfafVn
 Gou/SYle85zdGHY+ZOHnUf8QCL3M1DMcYkvEbMg12+e2+7hKYXmzDcQ9JdRkvlbrIkRB
 /W/sWsyi+XwzZzKGQdKGEvHX+wJhgFn0aruuny0jpQvMXamvu/uaCT8upAqMkAakx6d+
 mY/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNfuPXJ2lYpB5hbAwyxT3j86bacb1FwYM5qdR9P/dVmU5o+lc1DmJivnDx2N1YhO7hmmQgqyU=@lists.denx.de
X-Gm-Message-State: AOJu0YwcVhTOa7RujdRCqpZ7FGIbO2trET4p507STkHh0rmVKmzdf0qr
 z4HdJAiZ5blXRDZ9jDXrd0BD6VE/UbT0JmH8241saPT9gJmPLjp4dz/PZAGPHgE=
X-Gm-Gg: ASbGnct2CaLAnQRgJkJuSJdLMjGRWnddmBXaniVwZl40eQoBSW59j+l1Mt3LA1Xn+R5
 P/eal4opka9KC3v8apfnVy7+24n/rRw3uwATdkbM/ql7UMzLBmPFLxu+WIpI+e+K5ejfGaHbBQw
 y9jWszKwE1oXKofTdEWc2Ln09vTpCJapA5w/QeRuzxzI44SfieZLlvrxqosPoTHLXuOZVoLaxU5
 NPpukt7Fy37DGEchm1l3kHjIJ7wk7H7VvctOHCU6kiDOz10L9neD1g1YlXpVDbJeYFgljsumKPl
 NYBm5MLzaA3kKKMItZCv+SWn3wFbX9bvs3Lloi+VW80XwMJ8H83taTD2rl7HXuw2F6aMh0kpii5
 dw3pptXnuixWeRjKQPLNeqCHvVecuBtzS
X-Google-Smtp-Source: AGHT+IGElTtu+6d3PiELmPxn2Rl9yJfb/DCc2TTB40o3W7wGJBJKlG2FRIfyLnf688IFYkG/mNccMQ==
X-Received: by 2002:a05:600c:4589:b0:43b:c7f0:6173 with SMTP id
 5b1f17b1804b1-43eced9a50cmr89199385e9.4.1744016575297; 
 Mon, 07 Apr 2025 02:02:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec169b8a3sm125685435e9.19.2025.04.07.02.02.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 02:02:55 -0700 (PDT)
Message-ID: <157becc8-34c2-48eb-a65e-55d312e9aa05@linaro.org>
Date: Mon, 7 Apr 2025 11:02:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/7] mmc: msm_sdhci: handle bulk clock initialization error
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 caleb.connolly@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
 <20250407081927.138915-4-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20250407081927.138915-4-jorge.ramirez@oss.qualcomm.com>
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

On 07/04/2025 10:19, Jorge Ramirez-Ortiz wrote:
> Some boards do not require all clocks to be available (i.e:
> dragonboard820c).

Can you specify which clock isn't available ? Because we have clk-stub for that

Thanks,
Neil

> 
> This change provides a fallback to the core clock when the bulk cant be
> retrived.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   drivers/mmc/msm_sdhci.c | 27 +++++++++++++++++++++++++--
>   1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 27bb7052fca..8081330bd25 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -9,6 +9,7 @@
>   
>   #include <clk.h>
>   #include <dm.h>
> +#include <dm/devres.h>
>   #include <malloc.h>
>   #include <sdhci.h>
>   #include <wait_bit.h>
> @@ -56,6 +57,17 @@ struct msm_sdhc_variant_info {
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> +static int get_core_clock(struct udevice *dev, struct clk_bulk *bulk)
> +{
> +	bulk->count = 1;
> +
> +	bulk->clks = devm_kcalloc(dev, 1, sizeof(struct clk), GFP_KERNEL);
> +	if (!bulk->clks)
> +		return -ENOMEM;
> +
> +	return clk_get_by_name(dev, "core", &bulk->clks[0]);
> +}
> +
>   static int msm_sdc_clk_init(struct udevice *dev)
>   {
>   	struct msm_sdhc *prv = dev_get_priv(dev);
> @@ -73,8 +85,15 @@ static int msm_sdc_clk_init(struct udevice *dev)
>   
>   	ret = clk_get_bulk(dev, &prv->clks);
>   	if (ret) {
> -		log_warning("Couldn't get mmc clocks: %d\n", ret);
> -		return ret;
> +		log_warning("Bulk clocks not available (%d), trying core clock\n", ret);
> +
> +		/* Sometimes not all clocks are needed - chainloading uboot */
> +		ret = get_core_clock(dev, &prv->clks);
> +		if (ret) {
> +			log_warning("Core clock not available:(%d)\n", ret);
> +			return ret;
> +		}
> +		n_clks = 1;
>   	}
>   
>   	ret = clk_enable_bulk(&prv->clks);
> @@ -83,6 +102,9 @@ static int msm_sdc_clk_init(struct udevice *dev)
>   		return ret;
>   	}
>   
> +	if (n_clks == 1)
> +		goto set_rate;
> +
>   	/* If clock-names is unspecified, then the first clock is the core clock */
>   	if (!ofnode_get_property(node, "clock-names", &n_clks)) {
>   		if (!clk_set_rate(&prv->clks.clks[0], clk_rate)) {
> @@ -105,6 +127,7 @@ static int msm_sdc_clk_init(struct udevice *dev)
>   		return -EINVAL;
>   	}
>   
> +set_rate:
>   	/* The clock is already enabled by the clk_bulk above */
>   	clk_rate = clk_set_rate(&prv->clks.clks[i], clk_rate);
>   	/* If we get a rate of 0 then something has probably gone wrong. */

