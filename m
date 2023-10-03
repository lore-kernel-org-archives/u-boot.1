Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FFEE7AD42
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C279B87259;
	Tue,  3 Oct 2023 15:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h+TFABzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FC5C87285; Tue,  3 Oct 2023 15:21:11 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F56687441
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-327b7e08456so945560f8f.2
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 06:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696339269; x=1696944069; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=KK8nmRmNQygjjViCiLRnGglt+F9y0kDV4bmr3SV9+Fk=;
 b=h+TFABzNYqFD2DJFmqDW1hC7Nn7ue01QTXBqOMJAl8y8Ib+hfUXMzAUr+rTMnEZvvY
 rU9wrj6K2v8knwRNbXHrMT9kEc+4XxjwJGmrIfgFK2Dr8AzKeaSFVW0oQOOIC3s87wGK
 0HE31qZNrn4JNoWxIhGdbTou2zaaYtkPIx7yRy1cjLDarH57IUZhpyuYVvKFU8FWEKQz
 nTjLll4KKvTIk1Y7GnCwtygpCdcudAR7cQ21kopYeb26yIvXksgSvLmlP8+jODhv46kx
 0EFOXmDjyZ2L4NmBfzResWPZJAVoA+TQhBgEVaItWBIGGyewV+K/7aiEO2Bg9NqebA7i
 W1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696339269; x=1696944069;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KK8nmRmNQygjjViCiLRnGglt+F9y0kDV4bmr3SV9+Fk=;
 b=ogb2kvEjJbVZresrvOdbNgww6eqcYbYN6KIiIhXHU6QRoQlATPN6Y3k6x9eNGcjKMx
 9tyIBTZE5HW/6reCNFgSf36e7Ub8GdhCmMF9r7vWOSJRKj2kw7KAtP62gi854YW2qsBq
 UgITv2p+5GCfaMkYc6S58I6g0CVfWtkCXx9rJtMcAwsac8qvZFo5zspc4KfvhjqjnM4L
 Mu+1z13BgRamnhv9UdCU58eFUT9Kw2hraVqb10QeUuUlpLbxqbP7/3ZvjKqB/3qp7cXK
 MKmEVp9BQnPbBdxOfg+HANh71reiVy/+6BcsMsJd0uzBtAqTvQLSLcLk2Yo824MAN9Zc
 r22Q==
X-Gm-Message-State: AOJu0Yxx4LE99fnFiSFkdLJtsbbb6Yb65eoPJJPGNyKEspPUzNFYpNLU
 23yUxQQKFOZ7tNkCraGXN7iZLQ==
X-Google-Smtp-Source: AGHT+IHdbWDShCgBiloWUJ08ARDisa8mrQI8/CwcNNIWVhwJuYUF3wlQERa6Xjznvqq1LuaYSDTqSA==
X-Received: by 2002:a5d:6447:0:b0:324:8239:2872 with SMTP id
 d7-20020a5d6447000000b0032482392872mr11530081wrw.71.1696339268822; 
 Tue, 03 Oct 2023 06:21:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e31a:fe1c:e925:9858?
 ([2a01:e0a:982:cbb0:e31a:fe1c:e925:9858])
 by smtp.gmail.com with ESMTPSA id
 f8-20020adfdb48000000b0031ff89af0e4sm1568213wrj.99.2023.10.03.06.21.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 06:21:08 -0700 (PDT)
Message-ID: <e8f12d8c-aa70-45e9-b7f1-29840110b356@linaro.org>
Date: Tue, 3 Oct 2023 15:21:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 8/8] ad401: enable USB stack
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
References: <20231003112838.41503-1-avromanov@salutedevices.com>
 <20231003112838.41503-9-avromanov@salutedevices.com>
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
In-Reply-To: <20231003112838.41503-9-avromanov@salutedevices.com>
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
> Currently we have all drivers for use USB stack on A1-series
> SoC's. Let's enable USB options for the Amlogic AD401 reference A1
> SoC board.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   configs/ad401_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/configs/ad401_defconfig b/configs/ad401_defconfig
> index 529e553bac..b02ff47b7a 100644
> --- a/configs/ad401_defconfig
> +++ b/configs/ad401_defconfig
> @@ -51,4 +51,7 @@ CONFIG_DEBUG_UART_SKIP_INIT=y
>   CONFIG_MESON_SERIAL=y
>   CONFIG_SPI=y
>   CONFIG_DM_SPI=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_USB_GADGET=y
>   CONFIG_WDT=y

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
