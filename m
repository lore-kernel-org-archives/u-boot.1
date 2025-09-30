Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5C9CAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 18:38:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23EDA800D7;
	Tue, 30 Sep 2025 20:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CI4n0JuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5603B828A2; Tue, 30 Sep 2025 20:38:04 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3160A800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 20:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e491a5b96so26420845e9.2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759257481; x=1759862281; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=OSEYf7DNHsue+2b7q22e1yCg1EEJ9hj4KsJ2xfjd+Xs=;
 b=CI4n0JuFXVBySnY87Qampwyc6iHjUlAsrSZMZ0KFNA3zSQJRZ0dBXoeER7TEzTmLES
 gPK5QXHX6BNR1lZh+rT5fn+VGRbWOC5BCdkO9WlwLmUHb0joIzkXKk4bQfr1ix9xZ438
 tiygBiXW1ZDz5e++hQYYZi/9YKmkGx/yLX+8Ab2Gbaj3dzhchpDZ3WTsyR5DW4iN+KJ/
 GAG+3k7oVoeG67KUDVp8IWUY9NI03kCVjNHyNg1UkK6Mjh89XyhgbhwBcIrC9wKUTAdm
 WZSFAUfQVCRiTgJIFbxrWxNKsIMPr7APEdVH7YRk66Ca7YWJlDdRiYaMW2XhH5r44Gu2
 vfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759257481; x=1759862281;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OSEYf7DNHsue+2b7q22e1yCg1EEJ9hj4KsJ2xfjd+Xs=;
 b=vAv1XqgF0g+bbVuXstd2WitdQ68Rfy+AHjcSLoRNY7epQD+IT4K5NDS4QZhQuFgR+O
 EcUAE6OVBkrOWHvqpsXl4J3Hv+MJJwgXbq5LxI3mjkhnxG/UoPCV6j1MPXS53N7az6he
 Dxl4muYwQ4HPLq/8S7OIz3LRAYjtxu8x/sk+uOibKT/cbIXwRCiqkB/6E0X+iv4gFECR
 qSm8afzxmXS8wPY4pjPiokK8KubUtLVgujB7pt767j6EFRkQybddRT5CJR46BPVW1yvn
 s5caJaJ5r3aWvz5Jd7KmKbZgUMZ2COcEUqP1LkkljtbMMVF7FPefRPWGJhn/pO/aU6IK
 GPrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8advntp42KCnNca9CqBRorfE0A123bwV8Tro/f2VpCeDTNADX6z3jIozxto+c/XeMdQScyxs=@lists.denx.de
X-Gm-Message-State: AOJu0YxqUXQ5YL9iFHu+IRZRdLWyo5Vowu58S0rq7FCZbhoPgHxc5bJa
 9kL8/ewEPlI2LfrVmL5ZlfHXhIir+cL0dHGNSiSkhVxQdY0XwRAjFl/h7xvHpbGZRMY=
X-Gm-Gg: ASbGncvnk0Xddfhqo7pNPME1+Cy6t8Fw+Pvr0cP4Fq5CRUOA9JLufQ2D4GjeXVf3mQQ
 49k3l570lmgx/2i0AHPpg2kv5jLWX4jBJfX5vAXjtZt61oiqa75R7dPZQZWPx2ol3ZabFN8gsVc
 HLzFmHe52yqEjhGa4Z+OX4Bnd97V75ynCwDFuU5VdqFaWyz92WarfTgOoh/jMZyCnM0Rdb0cWO/
 UiYdQGJ9SCk4BsjM1483PurQo9hhpksVr1SlZ6y6uQ/7vVZdiJ2QVog5VijaA9WGQdogr7qz719
 /ABKtRPWYayVJYjF4tcYqI+BZQ0HFLeAkETAZbsvJkicjtxQXIP+Ac0mKmYP0/4j67A/NluLnhR
 Ezr1D6dcgYpPHnazbC7WhnCBTHu/Au0fRAmW2P3zFcLMU5Orl2oPP0kVzqKXv0drLYXp5Z9TyvJ
 N/9FZ1lTzjKK4vQEwkpdhnSvdLG6Va3p2p0A==
X-Google-Smtp-Source: AGHT+IHy+pWaN7t46oAwNTX+kBV3ErY5Yu7TX8LO8tXlbODoL5G8zhJJS2FxManE5J/aTlzCbaBQaA==
X-Received: by 2002:a05:600c:c093:b0:45b:4a98:91cf with SMTP id
 5b1f17b1804b1-46e61faa217mr388755e9.15.1759257480549; 
 Tue, 30 Sep 2025 11:38:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9459:14e0:525e:d859?
 ([2a01:e0a:3d9:2080:9459:14e0:525e:d859])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5c44bd75sm19028615e9.4.2025.09.30.11.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 11:38:00 -0700 (PDT)
Message-ID: <25bcee75-b7f0-4775-98e2-bce17ac513b2@linaro.org>
Date: Tue, 30 Sep 2025 20:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] qcom_defconfig: enable watchdog command
To: Paul Sajna <sajattack@postmarketos.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250923-qcom_config_enable_cmd_wdt-v1-1-70cccf9f01e3@postmarketos.org>
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
In-Reply-To: <20250923-qcom_config_enable_cmd_wdt-v1-1-70cccf9f01e3@postmarketos.org>
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

On 9/24/25 04:05, Paul Sajna wrote:
> CONFIG_WDT and CONFIG_WDT_QCOM were previously added in
> https://source.denx.de/u-boot/u-boot/-/commit/530764de9fc8539cd2354501e9c42804bc4c4dac
> 
> U-Boot and Linux pet the watchdog by default,
> but it's helpful to also have the command to control the watchdog,
> (CONFIG_CMD_WDT)
> so it can be manually disabled by the user, for example, if the kernel
> is expected to stall during debugging with kgdb.
> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>   configs/qcom_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 86d7de89e7746e33f4385ca78c839b43319cd861..88595e5293418407dcaf1e7f8ee1b2b5f6bda4f5 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -44,6 +44,7 @@ CONFIG_CMD_EFIDEBUG=y
>   CONFIG_CMD_RNG=y
>   CONFIG_CMD_REGULATOR=y
>   CONFIG_CMD_LOG=y
> +CONFIG_CMD_WDT=y
>   CONFIG_OF_LIVE=y
>   CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
>   CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=y
> 
> ---
> base-commit: 4d84fa1261eb27d57687f2e4c404a78b8653c183
> change-id: 20250923-qcom_config_enable_cmd_wdt-c31e1a5f2e2a
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
