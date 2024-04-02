Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AADCD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 08:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66D66880A7;
	Tue,  2 Apr 2024 10:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ofaqlYKl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51DB888076; Tue,  2 Apr 2024 10:32:21 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F76588301
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 10:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3417a3151c4so4523701f8f.3
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 01:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712046738; x=1712651538; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=MajPqTOYmVLcuG8zRjHLy40/ivQadT6j7D5kRu5ytFw=;
 b=ofaqlYKlsuaq1HdX242bDKXsuDyIXJsFwLxQrX+V/3Cbn3pTuAgDpHFX59JkpRDuDR
 9a/9MEx5U2FMv4ZjsiPv2aarDRCgcpH3JKCdP4tDgSn8kAoYLRZ+jYvSjAswPW/uIEOu
 /brlgrE8m/RtV9qrCZGTDDoUjsBnvPvf3GSzIlzOwQ5XKcwcfF/9XILNHajIadBtGKV/
 lGvVPZS17eYkSqRpjbbGttskdYr4z6hRHybQ1UHCfyTEF3DDN6tZ81/KbAvw8iXNnqeh
 glLzfD90K0ohQPPs6r/VvLlGmVhnRFo2njDqzC8d+rKIkjoY/h2RcZpno6iG17mckuse
 7YsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712046738; x=1712651538;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MajPqTOYmVLcuG8zRjHLy40/ivQadT6j7D5kRu5ytFw=;
 b=aaxBvKBI6377XUo56dhlk54k6z7Rw4QawdVQKAcGFmQwwHSHtx86ZMVKY9ox6VnD3U
 gdK6D85EHSD7fRB/Ny7uirUvdEEb4Yp1DPZ0FQA/r+ye7aEUsCl+ipGvG0E+pNEhIPYO
 55yTxvUPe5J2aUn+1PKWzEBYou77NZ3xdY+gWh/EkRkhq+CU1iKxw9FiBu8lFSPl9R3C
 Uc+BzFLiUyH2BUK1ORao5y06a3ysbu6hP+Su9jWjus6c+bW79IRByktPHHQgFUrN3JZU
 9CJP8tIhfnm5010p0PItBZQzOuKeRFXyHNV7u2blYEd/Ztc7Yf+vazaH4p2u+kLtnXOO
 qwbw==
X-Gm-Message-State: AOJu0YzhrIfOaVdqtv2wpPO26hu27e+jMs7bd4qecmap2NCFjVRAIhY8
 N2Bh/X5Po+9aZmaEkTqwHlP1hOZAB9PaNzcdWpBiOy0Hq2ApWCTrT1p3DNktCrU=
X-Google-Smtp-Source: AGHT+IEZXRX5Fz1QltHPMxSVSjFFJSKFD9d0t74toHUg2KeQgP8niuQLB30aGqrGAs9bgnrwLNwWcQ==
X-Received: by 2002:adf:f2c3:0:b0:343:6c5b:5886 with SMTP id
 d3-20020adff2c3000000b003436c5b5886mr704268wrp.46.1712046738368; 
 Tue, 02 Apr 2024 01:32:18 -0700 (PDT)
Received: from [192.168.7.190] (82-64-249-211.subs.proxad.net. [82.64.249.211])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a5d6212000000b0034181bea3b0sm13639695wru.3.2024.04.02.01.32.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 01:32:17 -0700 (PDT)
Message-ID: <e4097911-4892-4a70-be52-1e8a965e08cb@linaro.org>
Date: Tue, 2 Apr 2024 10:32:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 11/16] mach-snapdragon: fixup power-domains
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
 <20240328-b4-qcom-livetree-v5-11-4e98228b3d03@linaro.org>
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
In-Reply-To: <20240328-b4-qcom-livetree-v5-11-4e98228b3d03@linaro.org>
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

On 28/03/2024 18:59, Caleb Connolly wrote:
> We don't support the RPM(h)PD power domains in U-Boot, and we don't need
> to - the necessary resources are on, and we aren't going to enter any
> low power modes.
> 
> We could try using a no-op device, but this requires adding a compatible
> for every platform, and just pollutes the driver model. So instead let's
> just remove every "power-domains" property that references the RPM(h)pd
> power controller. This takes <1ms as we're using OF_LIVE.
> 
> Of note, this only applies to drivers which are loading post-relocation.
> Drivers loaded pre-reloc that reference the rpm(h)pd still need
> DM_FLAG_DEFAULT_PD_CTRL_OFF in their flags.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/of_fixup.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index 4fdfed2dff16..3f7ac227bd09 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -21,8 +21,9 @@
>   #include <dm/of_access.h>
>   #include <dm/of.h>
>   #include <fdt_support.h>
>   #include <linux/errno.h>
> +#include <stdlib.h>
>   #include <time.h>
>   
>   /* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
>    * USB controllers. Rather than requiring source level DT changes, we fix up
> @@ -109,8 +110,38 @@ static void fixup_usb_nodes(void)
>   			log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
>   	}
>   }
>   
> +/* Remove all references to the rpmhpd device */
> +static void fixup_power_domains(void)
> +{
> +	struct device_node *pd = NULL, *np = NULL;
> +	struct property *prop;
> +	const __be32 *val;
> +
> +	/* All Qualcomm platforms name the rpm(h)pd "power-controller" */
> +	for_each_of_allnodes(pd) {
> +		if (pd->name && !strcmp("power-controller", pd->name))
> +			break;
> +	}
> +
> +	/* Sanity check that this is indeed a power domain controller */
> +	if (!of_find_property(pd, "#power-domain-cells", NULL)) {
> +		log_err("Found power-controller but it doesn't have #power-domain-cells\n");
> +		return;
> +	}
> +
> +	/* Remove all references to the power domain controller */
> +	for_each_of_allnodes(np) {
> +		if (!(prop = of_find_property(np, "power-domains", NULL)))
> +			continue;
> +
> +		val = prop->value;
> +		if (val[0] == cpu_to_fdt32(pd->phandle))
> +			of_remove_property(np, prop);
> +	}
> +}
> +
>   #define time_call(func, ...) \
>   	do { \
>   		u64 start = timer_get_us(); \
>   		func(__VA_ARGS__); \
> @@ -119,5 +150,6 @@ static void fixup_usb_nodes(void)
>   
>   void qcom_of_fixup_nodes(void)
>   {
>   	time_call(fixup_usb_nodes);
> +	time_call(fixup_power_domains);
>   }
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Also tested on SM8550 & SM8650, so:

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
