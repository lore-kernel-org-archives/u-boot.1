Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88247C4167D
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 13:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4426877A1;
	Thu,  2 Nov 2023 14:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D8NfPQuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F4ED877A2; Thu,  2 Nov 2023 14:36:37 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FA0387631
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 14:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50939d39d0fso1159779e87.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 06:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698932193; x=1699536993; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=7I/2CWZ3akEX1BMyg2Naxgpst6GvEWhgqlYh7GaknSU=;
 b=D8NfPQuwh5JUhyzJnFjcrZkB8frPxqHhzLSVg/5XgWS9kpJ607I6LufIj2Vo76CqmZ
 yn7mKPRjSPeLgytz2RrB5W+ifKO371NzBKgRLjbeWLkjTpivVX11TCjF0yW75qYf73YQ
 6QRl012nQ1jeF8ciZP80ee2MvZQxWMNK/yT7LJaXbkXE6fnl7uARwIImEz6iq207bitf
 xlH9bVY0ZjMsvZVB3cjV8UxF2LlLm8l7JLc7rgxh6X88hbFOQQ0cZrtL+DorxEK/1nTv
 BD2qy0+dFstGo31aUOBq2wR3mEooHpxo/golBWfzlCixPoJZaTYB3rwBP1tDOKa2WgXD
 bqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698932193; x=1699536993;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7I/2CWZ3akEX1BMyg2Naxgpst6GvEWhgqlYh7GaknSU=;
 b=farqYbmSLx8vvOSLYP05uiXM6fzTQ6fGshNQeO1tuWtBW8pa1gUq0s9XG48hJkKtOj
 UYK4n/98RpsZ7T6GdE8WAA2/ocseJ8CeRtbpnFaaxGPhegWJ22Jr07JI/e59zaFEZamK
 Dt1hkp3p0ETiyY2ggfuFgdlrIxo2o4KSUryfrK26zKOsI218OfycABqJ/TK3RrwNvY7I
 X0+iapr1nPPc8umzN5L4kKcZs2DueG8o8zg6ffMRyJQ1iHQwLBkKLOxit13+zfECS/DO
 ksVQo/85Xjgmy3R4GQPUz+eKmbpdmFtkeSaXSwafmUhw/AedLIhkp5dSdgcrKnbBeGbE
 yK1A==
X-Gm-Message-State: AOJu0YwSFga9Z90zQeAGUz5JTuGF0rARJojBPfrq3shr7b7yF9rYPb7u
 2sMKYobC291CFTU+t3yEdcjwGw==
X-Google-Smtp-Source: AGHT+IE+W4jm3q0J88C1Zx2eUpzoepR8nN0U07m8TI60dIUqlNfDyEBaTLfipZYrr+7jxTZnes6Prw==
X-Received: by 2002:a05:6512:3481:b0:507:9618:dc1f with SMTP id
 v1-20020a056512348100b005079618dc1fmr13011405lfr.69.1698932193239; 
 Thu, 02 Nov 2023 06:36:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4ac1:f109:811c:51be?
 ([2a01:e0a:982:cbb0:4ac1:f109:811c:51be])
 by smtp.gmail.com with ESMTPSA id
 g9-20020adff409000000b0032dbf26e7aesm2508168wro.65.2023.11.02.06.36.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 06:36:32 -0700 (PDT)
Message-ID: <764768fd-c67d-4681-ac4b-e9d0a8bc4fba@linaro.org>
Date: Thu, 2 Nov 2023 14:36:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/2] drivers: sm: bind child sm devices in the device
 tree
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru,
 Dmitry Rokosov <ddrokosov@salutedevices.com>
References: <20231101140500.9025-1-avromanov@salutedevices.com>
 <20231101140500.9025-3-avromanov@salutedevices.com>
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
In-Reply-To: <20231101140500.9025-3-avromanov@salutedevices.com>
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

On 01/11/2023 15:04, Alexey Romanov wrote:
> From: Dmitry Rokosov <ddrokosov@salutedevices.com>
> 
> One well-known sm child device that provides secure power control is the
> Secure Power Controller. This device utilizes SMC calls to communicate
> with power domains on the secure monitor side.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/sm/meson-sm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/sm/meson-sm.c b/drivers/sm/meson-sm.c
> index faef369f35..1dd1584855 100644
> --- a/drivers/sm/meson-sm.c
> +++ b/drivers/sm/meson-sm.c
> @@ -194,6 +194,7 @@ U_BOOT_DRIVER(meson_sm) = {
>   	.id = UCLASS_SM,
>   	.of_match = meson_sm_ids,
>   	.probe = meson_sm_probe,
> +	.bind = dm_scan_fdt_dev,
>   	.priv_auto = sizeof(struct meson_sm_priv),
>   	.ops = &sm_ops,
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
