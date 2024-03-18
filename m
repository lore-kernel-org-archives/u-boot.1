Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F6CC54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 08:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8284C879AF;
	Mon, 18 Mar 2024 09:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zIO2rKoA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A325879F4; Mon, 18 Mar 2024 09:50:03 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49F2D87861
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 09:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41409fd8b6eso14875525e9.2
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 01:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710751800; x=1711356600; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=PEmbO0hfg4t6Va4sobnHhk3Do5ZSP52QFaOChTFVAnk=;
 b=zIO2rKoAPBgUoW9TDTwjmj4Ajq0a51qZOpe+lYY+DFaV2N//l91iPXuG4y9t+4WnQQ
 4dqPkeIvpPXzAWTWB0sg4bKwGrLDKP/77qHQGxcxa/vUx/7FVhn1OMZdkCo1TJQe06Kh
 uRJ2yt4TIo9trKk8aeAmXxFSSxgxyTYT4ledty9HU81ryN41TtjGJcMHmd5pRsj5xPwk
 eMVOCnigEplF+LwvBB5lI00vAhDdndMTlDHmkgNrdnbjLI3i/YCRBOT53brJyTkQtmnt
 CDbozpbbTG1oyFsg5WdoqDK3jLoSURPHodPsYSw5lBhDyq8AntYBFMm5Tq7zl6VIEDX8
 UJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710751800; x=1711356600;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PEmbO0hfg4t6Va4sobnHhk3Do5ZSP52QFaOChTFVAnk=;
 b=c87bWKFwq9qrnNCP4nvmb/mwmAmMdSHT4oh65ayhMcO2LVWvYx7Q3g/LH4bAjGe+YV
 FovsBw7wv71iVXwhPMoad+cbigcvVj+NBNHGp/mtuXNtSqyrONMURnUMaus9b7OeOmXB
 ucz+7Dvlp5GLzx9aX029lgDzGlgjyc7Fv2Py25w9/Bd81RcSBZGmjWGwoe4l3tkaTmqU
 14IRNyNNnm2+A+gBzuYxQaRIKxc/O1DTuTz5/i306IPv5Boh16i1v+IWe+4FalPGrris
 /foc0Tg6yD1AxZ0MY6ReoP2yhrdVYyYpO9iBMHbIPeOyMjo04OZ5OdeccCT0vBN30cke
 lpNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrZE/jeyYnNRoYJDYiJbZmnNQdUVTMCaxHfPuYcegVwg5Mxgp+tseUIHI+57cM3qXq65FxxQwsjpde6no9Xz9e/xRQeA==
X-Gm-Message-State: AOJu0YzVNVbadt1lwm2E7Y+8H94SGXkfV0kiZtFnaZ6aGzOIXXrE4Ao4
 AGlcImPQSttaSAjCwMhLdi3VfN8oyPnPW3Do4TlhG/Y666xSCirPZbSg+QiQGLLWNsDXOJlok6d
 Wcn4=
X-Google-Smtp-Source: AGHT+IHQEN87wPE/3GAp0yBZNmyZ4J2FeHIoRE4dfSDBJWMxRyCBVtACSHp5HBbW/wRzNgp+flvXrA==
X-Received: by 2002:a05:6000:e43:b0:33e:8171:3f0f with SMTP id
 dy3-20020a0560000e4300b0033e81713f0fmr4255865wrb.70.1710751800375; 
 Mon, 18 Mar 2024 01:50:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ad2b:a316:59d9:3dbc?
 ([2a01:e0a:982:cbb0:ad2b:a316:59d9:3dbc])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a056000108d00b0033d202abf01sm9236451wrw.28.2024.03.18.01.49.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 01:50:00 -0700 (PDT)
Message-ID: <86162fbc-856a-4e95-92ec-be6647f71d7c@linaro.org>
Date: Mon, 18 Mar 2024 09:50:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] configs: amlogic: set board family to avoid random
 MAC on WeTek Hub/Play2
Content-Language: en-US, fr
To: u-boot-amlogic@groups.io, christianshewitt@gmail.com,
 u-boot@lists.denx.de, linux-amlogic@lists.infradead.org
References: <20240316135430.826898-1-christianshewitt@gmail.com>
 <20240316135430.826898-4-christianshewitt@gmail.com>
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
In-Reply-To: <20240316135430.826898-4-christianshewitt@gmail.com>
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

Hi,

On 16/03/2024 14:54, Christian Hewitt wrote:
> Add CONFIG_SYS_BOARD="p200" to the Hub/Play2 board configs to ensure the
> factory programmed MAC is correctly read from efuse.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   configs/wetek-hub_defconfig   | 1 +
>   configs/wetek-play2_defconfig | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/configs/wetek-hub_defconfig b/configs/wetek-hub_defconfig
> index fd92b041e73..413bbfe9ab7 100644
> --- a/configs/wetek-hub_defconfig
> +++ b/configs/wetek-hub_defconfig
> @@ -1,5 +1,6 @@
>   CONFIG_ARM=y
>   CONFIG_ARCH_MESON=y
> +CONFIG_SYS_BOARD="p200"
>   CONFIG_TEXT_BASE=0x01000000
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> diff --git a/configs/wetek-play2_defconfig b/configs/wetek-play2_defconfig
> index b887419a6ba..dd98929444c 100644
> --- a/configs/wetek-play2_defconfig
> +++ b/configs/wetek-play2_defconfig
> @@ -1,5 +1,6 @@
>   CONFIG_ARM=y
>   CONFIG_ARCH_MESON=y
> +CONFIG_SYS_BOARD="p200"
>   CONFIG_TEXT_BASE=0x01000000
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y


CONFIG_SYS_BOARD="p200" is already the default value for MESON_GXBB, see arch/arm/mach-meson/Kconfig

Neil
