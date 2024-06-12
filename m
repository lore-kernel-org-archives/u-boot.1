Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805EEC27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 09:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D882688791;
	Wed, 12 Jun 2024 11:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sNI5KQ4n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6E2E887BF; Wed, 12 Jun 2024 11:38:11 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D96C58842C
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 11:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42278f3aea4so9443395e9.1
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 02:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718185089; x=1718789889; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=VzljB8jmpcEO9vcgAPg2Nspsl2b2Y8mmxAD2e8IXtG0=;
 b=sNI5KQ4nv9IyNfJhJH/J1aqnERzUYWvdYH98CM5LiqFrw5HbkI0icuwr0oLttTk9hx
 X7CJdKLlAth8xT+jctcwtgcLHFTnJisivKi/nuiUcZ96vDMuVJzbKfLCipPJz1DK/9b4
 Zaf4jxhybdqWzEAUm9VDeInYBhOUyeIoeQNcLDwyPk/TD80ExN+1s/giv2iPNSF7h+lK
 SLVJXNUIZkffFgKaqSt2UBun9GRvDI5NFn6+iwgr34Uz/XntzADkCy9hw3sGoTBjwPIn
 e6Umj51X+BFQumHKhLd59tkf75U9Uj7g7+OZiQFXEy8FCdFD02fBNIPKY25tr6mi9jNx
 TuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718185089; x=1718789889;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VzljB8jmpcEO9vcgAPg2Nspsl2b2Y8mmxAD2e8IXtG0=;
 b=FQEwC/NCwSqbKFkpd94EoXyRexTndvj79JBH4Mn0tb/oF51i6vIhoUngDzvAmtRv0t
 waOYYbKlqYPhqp5GcnW/x/t49rEp00deAHQSObNFhd2hKfIJsmdE/i86lcA5BWMfL6BM
 qzPfA7E8G036+d9GpSvma+aPuuS1wXRJGZMnuqGs01gtpY/+4FF4TurSFh5lVdmwbtK7
 ish/gTHl7A5ypocX4DqbrO9AH8eHpVJ3KTMqEPr9pmi9l32ZtRbqufGUXyofFalXMUa+
 PtjTFr13eLniDvRKkzKl2KTSkC6zotH/j3AcOcYWQIzHodPsc2u3b8DkhvqsfQ2XGkQE
 bFwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/RZC+Wb6uIKfyoZpWIJx9ezzbm1crhpHQjnSjwLM5saxvWPWzwAKEF/S6eah7r0omMkeUtErKoiriejz94sFf9nFNeA==
X-Gm-Message-State: AOJu0YzfFK8tINdLkaNMJ610bz3+YHsHTC2fNo+iML9nkiEf1fdu0jj9
 tx1RVMhqSinlPdNJ0GKayHkYatc33QZfws2bFOCWEE0Kln2ItSLsmMZRcJgA+AM=
X-Google-Smtp-Source: AGHT+IEa9jduPgL5gzXIBcDAH5XUaC9iVf2SX3cjtGVpA/X0ZzyvVO2vj5hj7djYeBo/QKfuhbEV+A==
X-Received: by 2002:a05:600c:4587:b0:421:7983:f1c4 with SMTP id
 5b1f17b1804b1-422863a85bcmr11697725e9.6.1718185089242; 
 Wed, 12 Jun 2024 02:38:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:30bd:bf21:eed1:8aeb?
 ([2a01:e0a:982:cbb0:30bd:bf21:eed1:8aeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286fe7629sm19043315e9.10.2024.06.12.02.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 02:38:08 -0700 (PDT)
Message-ID: <37218b15-80ec-4bb5-9c64-91b94f5c2679@linaro.org>
Date: Wed, 12 Jun 2024 11:38:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 18/42] meson: Correct driver declaration for meson_axg_gpio
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot-amlogic@groups.io
References: <20240611200156.2245525-1-sjg@chromium.org>
 <20240611200156.2245525-19-sjg@chromium.org>
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
In-Reply-To: <20240611200156.2245525-19-sjg@chromium.org>
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

On 11/06/2024 22:01, Simon Glass wrote:
> This should use the driver macros so that the driver appears in the
> linker list. Fix this.
> 
> Fixes: 8587839f19d ("pinctrl: meson: add axg support")
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c | 2 +-
>   drivers/pinctrl/meson/pinctrl-meson-axg.c     | 4 ++--
>   drivers/pinctrl/meson/pinctrl-meson-axg.h     | 2 +-
>   drivers/pinctrl/meson/pinctrl-meson-g12a.c    | 4 ++--
>   4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
> index 52c726cf038..15ebd574ef1 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
> @@ -179,7 +179,7 @@ static const struct dm_gpio_ops meson_axg_gpio_ops = {
>   	.direction_output = meson_gpio_direction_output,
>   };
>   
> -const struct driver meson_axg_gpio_driver = {
> +U_BOOT_DRIVER(meson_axg_gpio) = {
>   	.name	= "meson-axg-gpio",
>   	.id	= UCLASS_GPIO,
>   	.probe	= meson_gpio_probe,
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
> index 94e09cd3f8a..ed3f92b2d75 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
> @@ -939,7 +939,7 @@ struct meson_pinctrl_data meson_axg_periphs_pinctrl_data = {
>   	.num_groups	= ARRAY_SIZE(meson_axg_periphs_groups),
>   	.num_funcs	= ARRAY_SIZE(meson_axg_periphs_functions),
>   	.num_banks	= ARRAY_SIZE(meson_axg_periphs_banks),
> -	.gpio_driver	= &meson_axg_gpio_driver,
> +	.gpio_driver	= DM_DRIVER_REF(meson_axg_gpio),
>   	.pmx_data	= &meson_axg_periphs_pmx_banks_data,
>   };
>   
> @@ -953,7 +953,7 @@ struct meson_pinctrl_data meson_axg_aobus_pinctrl_data = {
>   	.num_groups	= ARRAY_SIZE(meson_axg_aobus_groups),
>   	.num_funcs	= ARRAY_SIZE(meson_axg_aobus_functions),
>   	.num_banks	= ARRAY_SIZE(meson_axg_aobus_banks),
> -	.gpio_driver	= &meson_axg_gpio_driver,
> +	.gpio_driver	= DM_DRIVER_REF(meson_axg_gpio),
>   	.pmx_data	= &meson_axg_aobus_pmx_banks_data,
>   };
>   
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.h b/drivers/pinctrl/meson/pinctrl-meson-axg.h
> index c8d2b3af036..a6581bab500 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-axg.h
> +++ b/drivers/pinctrl/meson/pinctrl-meson-axg.h
> @@ -61,6 +61,6 @@ struct meson_pmx_axg_data {
>   	}
>   
>   extern const struct pinctrl_ops meson_axg_pinctrl_ops;
> -extern const struct driver meson_axg_gpio_driver;
> +extern U_BOOT_DRIVER(meson_axg_gpio);
>   
>   #endif /* __PINCTRL_MESON_AXG_H__ */
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-g12a.c b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
> index 24f47f82558..67114df6824 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-g12a.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
> @@ -1253,7 +1253,7 @@ static struct meson_pinctrl_data meson_g12a_periphs_pinctrl_data = {
>   	.num_groups	= ARRAY_SIZE(meson_g12a_periphs_groups),
>   	.num_funcs	= ARRAY_SIZE(meson_g12a_periphs_functions),
>   	.num_banks	= ARRAY_SIZE(meson_g12a_periphs_banks),
> -	.gpio_driver	= &meson_axg_gpio_driver,
> +	.gpio_driver	= DM_DRIVER_REF(meson_axg_gpio),
>   	.pmx_data	= &meson_g12a_periphs_pmx_banks_data,
>   };
>   
> @@ -1267,7 +1267,7 @@ static struct meson_pinctrl_data meson_g12a_aobus_pinctrl_data = {
>   	.num_groups	= ARRAY_SIZE(meson_g12a_aobus_groups),
>   	.num_funcs	= ARRAY_SIZE(meson_g12a_aobus_functions),
>   	.num_banks	= ARRAY_SIZE(meson_g12a_aobus_banks),
> -	.gpio_driver	= &meson_axg_gpio_driver,
> +	.gpio_driver	= DM_DRIVER_REF(meson_axg_gpio),
>   	.pmx_data	= &meson_g12a_aobus_pmx_banks_data,
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
