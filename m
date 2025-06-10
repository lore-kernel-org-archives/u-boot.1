Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF01C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 16:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8B2482B18;
	Tue, 10 Jun 2025 18:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ckHwublu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 131D182B20; Tue, 10 Jun 2025 18:50:06 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16CA582B07
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 18:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so39923535e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749574203; x=1750179003; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=06Gdpx3sTXPXqDOZUOlpHdhKKrzXaIKpp5oc2THRU7M=;
 b=ckHwubluN0qSrrfrC/1ImtXCYdBn2rgOIp++NDgKEtMbxi1DMQPy+qShY0BGNpwv/N
 ELeJPz7XG+nxhZvbURoGKAb4+suBbmZcP+/7cVLfiIeOk91fLl61FkpygQwz0fynT62x
 xgpX6FYGaRARmQNSmO2IZlsUw1y6GRNp+IsP9/ifxnHWW5dOaFMfxSp1n5X79nuk+/fw
 Au+lO9UFZNIx1kgN3yh1F95uekOsCoN6WQssRRfKHHRehAwax/CmqUmHuooTx/7shNAw
 0W2dd2vt/kwkmMt5NpvuPmWcO8fQsBPRrVO70D9lDuVlXTVlDfsC6BALeOmWjdjYUFCg
 RYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749574203; x=1750179003;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=06Gdpx3sTXPXqDOZUOlpHdhKKrzXaIKpp5oc2THRU7M=;
 b=U4eZCwLCY806K68I6PnpvaYvo35bLtsXSrbbMaKjaY2N5TOANVd1O03454VH5Soo0Z
 t4g6q4IlnlgFlP6xc4G9/VqJt8tNatiA6YtaDhCkczqE+wrbNhvazNT56NN4awJAWZjC
 /6Bh0Fj3D1R4jbcAQaxQ2D0MmoXUwXuP8HDsvzuYUuNvU7WpZpW57zZBnjL8o64klExf
 fgCmhAdYJG+rTXqbDtlqWhRXQwmDSnwZzMKq0RXTFaxCMptDCTT69ytcI/sbYdXvAEOG
 +XeIVXozRUKx1PSLhaICihUQLJDm3xICuiO2eB1nRkW0bRfRpxzh9ynwKMryU+wspy/h
 evcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAHd6jw/qQ4sxMuOy/aChDc1fRmiHLiItzQs5h9+Qq9cBYY+/lTJwbOvNCfBwmOo/diSOpOtE=@lists.denx.de
X-Gm-Message-State: AOJu0YzBwa3GwFeoO74z/sUBKoX/+o2kZagxG3eSmskPc52iWf8wqMh8
 2s0C3T4asWOd4Nm91drsJKpawDOKafMnp4UwzpolyMT+lyLI8zKO+B+SBM1ICmQOn6c=
X-Gm-Gg: ASbGncu18tuzxlcwSzHO4KswgY/iXYXKXcor7KjWVCmCPxlHrDnpq9o83lWPolk4RNN
 pd3EBJeL78bjeXjEPmIjXOgji6BYgdSHd3RwecBaRl1OAchlWn2sLLcHYEluZW7PB0BIOj3ll1N
 waCJObgrCp7GkuFOlbcLxAHFx9Vfa+PdQfzb5d3YMGGMMgscfZUy8dUg02eA9iBYTezzYHtIKfD
 CDFeLVuuUJp4tO/HP3PPlbpoSErkKt3DXZfUrAdP8dB6IPjc9cE3y6rxRAvk+SHaNYaZbKBBOrS
 plwgsrVJUABFQsnz3KJs3cqgtNcl62Mk63kEj2S6FU4nLXlBDUh2s5tg2Zbve7wjZMn0lbYs5sz
 C8VFukjTBdniS9cSKXxJ/NY9qY6IW0MiP95STswP+RT9aZpk=
X-Google-Smtp-Source: AGHT+IFhLOVw6AP0FeG+rmoIhlTHKSubX+cEFp8G6uEY7Q+BxSah7qNI4kgjof39WHLAJpW3sahyhA==
X-Received: by 2002:a05:600c:1e27:b0:441:b00d:e9d1 with SMTP id
 5b1f17b1804b1-4531ddec2d7mr40531225e9.2.1749574203500; 
 Tue, 10 Jun 2025 09:50:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f0b:a9b6:d508:9d14?
 ([2a01:e0a:3d9:2080:f0b:a9b6:d508:9d14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730c7761sm142951835e9.32.2025.06.10.09.50.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 09:50:03 -0700 (PDT)
Message-ID: <2db56219-855c-4813-8171-2d45706e3a46@linaro.org>
Date: Tue, 10 Jun 2025 18:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/1] soft_spi performance enhancement
To: verdun@hpe.com, jmverdun3@gmail.com, u-boot@lists.denx.de
References: <20250610163835.26874-1-verdun@hpe.com>
 <20250610163835.26874-2-verdun@hpe.com>
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
In-Reply-To: <20250610163835.26874-2-verdun@hpe.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/06/2025 18:38, verdun@hpe.com wrote:
> From: Jean-Marie Verdun <verdun@hpe.com>
> 
> Add a test when delay is set to 0 to improve performances
> by 20% on ARM based systems
> 
> Signed-off-by: Jean-Marie Verdun <verdun@hpe.com>
> ---
>   drivers/spi/soft_spi.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/soft_spi.c b/drivers/spi/soft_spi.c
> index 50bd7be5640..e97352000f8 100644
> --- a/drivers/spi/soft_spi.c
> +++ b/drivers/spi/soft_spi.c
> @@ -173,7 +173,8 @@ static int soft_spi_xfer(struct udevice *dev, unsigned int bitlen,
>   			soft_spi_scl(dev, !cidle);
>   		if ((txrx & SPI_MASTER_NO_TX) == 0)
>   			soft_spi_sda(dev, !!(tmpdout & 0x80));
> -		udelay(plat->spi_delay_us);
> +		if (plat->spi_delay_us)
> +			udelay(plat->spi_delay_us);
>   
>   		/*
>   		 * sample bit
> @@ -190,7 +191,8 @@ static int soft_spi_xfer(struct udevice *dev, unsigned int bitlen,
>   							    &plat->mosi :
>   							    &plat->miso);
>   		tmpdout	<<= 1;
> -		udelay(plat->spi_delay_us);
> +		if (plat->spi_delay_us)
> +			udelay(plat->spi_delay_us);
>   
>   		/*
>   		 * drive bit

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
