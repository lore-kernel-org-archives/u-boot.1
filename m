Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE921CA1016
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 08:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C13E82AE9;
	Mon,  8 Sep 2025 10:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jqcr2q1Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 233F882C84; Mon,  8 Sep 2025 10:10:19 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CC23800B6
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 10:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45de64f89a9so4740625e9.1
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 01:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757319016; x=1757923816; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=2DyBnEDJm/cOK871iR7+touhMmlUnmvLtw8TC0gBp7c=;
 b=jqcr2q1YLH5e8Oeus45stmWV4sd/S9DrcmrlKPGTRb+E3rsiyFdJSRBddSTuKroHLd
 m4iIJx/I3KSER60Aein5AqHVoYaPhtvmbyaCTC4VE7BxWZWbqoHxUIi0fZbXHuIXO+Mr
 gOJxxvtgRO0YTKnjIDsVImgpKE6PlNTCEAgXkVCk9jVOaQ3YFo6wX9O4jjcsmdOEivsb
 xUqNsum7TJjjmB3QW6CEy/6e8fi9+8Kp0EOanTMWWNMBIgTPPvgQVbC2FrG+tAYIWgUf
 VhHpdmD+m1nLfYvdV9zeHSSOpldHVZTTKzF+A/h6wDBZIRuv/XmZzYeO/wuaumjhWMvC
 ikrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757319016; x=1757923816;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2DyBnEDJm/cOK871iR7+touhMmlUnmvLtw8TC0gBp7c=;
 b=fzFnhdzqqomGdXVUjEex+G7pArfDVnh6TPKyBDe5ODgCynUyCA5kuMHoSBeW2OCiUS
 172OhtZytfX38O7U5Oa9EnM3T0jk6CpFnaH95I2Yli3MRf7rPK/sFc01cT7tqZz0D2TP
 7h8OybvDwAjiBgXnzx0O3aAJQrhnf6R53RqRdhTG3po+zPntM8Ss95JmJ5Xat+x96c4z
 C7lwZilhZXRzA205lINHPquwRk2c2CpWyHgnvjTR2P9dliTb9Mz7I54762grsYUDp4kd
 hthnNP2LsL0mXqHb+gX7I1+OsBN1wxWqVsG02QQdRGthvD/GMx2Exz8FWdtxYbLmglX5
 u/aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnd7dX1ORsBfypiSGOqPjgpNkB1Wj4yoGFuNkXtNgDFdgWvzsecUs/+SI/qPDcNhBVGbPC+LA=@lists.denx.de
X-Gm-Message-State: AOJu0YzG4K9afX5yny1KHs70BaAz0gnvJnaGqbuU4/r3ncWzTu3xdf11
 d5UlcCKXJCcy/v9eXDNshYAMr9uOeu1U/obVb/dhcD8QQxCDTPKfZE4/1wlvRmjIBpE=
X-Gm-Gg: ASbGncuJnKxiPmPD6efzy+cPElZWecCA+0QQxfDBdYQUxPR41TWi3tQmiBnGbwM1pIE
 OQY2OteanVKqnCr11UzsoTRuS2vaNLUph6bO536F0j8wXdvQgkWmnkiUBQRkOfWtAUEezzamBlZ
 QuLf2G7oNthR2YKX36To/TCyPLuh+cYmCbX/TUh2dtez+6J7Lkq17gs4/epffp/eGBOPUV6EZyd
 P8Q0xYJMXPMtHLtwg/oOAmMP+OnA/MQTY4q0wzo/pleIL3RzWbGvc50OZkR1PCubsDsAyTGEtwt
 lRTMs8FsFVP37GtRoSzPrQvvaq59EykEoh6SDfayTSHsK7VDQCMmMuG4R38759WoEXwq3j4ksAV
 dENCoeUxu6x8e1hOJZZZY4QLwCCtYIZl8Eu1/B+R2TGJEaqbWRiAAcF018hO/SZgsMq99gHe9Xd
 6mzokBZ/9f1Q==
X-Google-Smtp-Source: AGHT+IHh7sZvWhs6RE3omVCSRw5onP4gN8+ySacRF1tTchMHgRPz735tdNkjcYaE7qV3DrILtcscaQ==
X-Received: by 2002:a05:600c:1d22:b0:45d:d202:77f0 with SMTP id
 5b1f17b1804b1-45dde1b14f0mr51278165e9.5.1757319015906; 
 Mon, 08 Sep 2025 01:10:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:61c1:5d31:4427:381b?
 ([2a01:e0a:3d9:2080:61c1:5d31:4427:381b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e8879cesm434452465e9.12.2025.09.08.01.10.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 01:10:15 -0700 (PDT)
Message-ID: <7dd0f481-3e43-48f1-8549-49918d6facea@linaro.org>
Date: Mon, 8 Sep 2025 10:10:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 3/9] mmc: meson_gx_mmc: don't bail if there is no
 clock driver
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-3-37395d9ff5af@postmarketos.org>
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
In-Reply-To: <20250907-spl-gx-v1-3-37395d9ff5af@postmarketos.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 07/09/2025 16:36, Ferass El Hafidi wrote:
> The clock driver is too big for U-Boot SPL at the moment.  In the
> meantime, continue mmc init even if it is not present.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   drivers/mmc/meson_gx_mmc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index a4338f1e29c1da07acb0333be9b75a318cba1334..d83a79fa0894fc6a32c40642ebce5f845120efaf 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -332,11 +332,11 @@ static int meson_mmc_probe(struct udevice *dev)
>   
>   	/* Enable the clocks feeding the MMC controller */
>   	ret = clk_get_bulk(dev, &clocks);
> -	if (ret)
> +	if (ret && ret != -ENOSYS)
>   		return ret;
>   
>   	ret = clk_enable_bulk(&clocks);
> -	if (ret)
> +	if (ret && ret != -ENOSYS)
>   		return ret;
>   
>   	cfg->voltages = MMC_VDD_33_34 | MMC_VDD_32_33 |
> 

Can you only not bail out in SPL ? I would like to keep the current behavior on non-SPL.

Neil
