Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D64DC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 15:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDDF988702;
	Fri, 19 Apr 2024 17:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lmB7mbyn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91FD7886F9; Fri, 19 Apr 2024 17:20:03 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C45BC88747
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 17:19:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-418c2bf2f15so18258685e9.3
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 08:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713539996; x=1714144796; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Cm4MyJ8qrqJpAYLjN4p/kGa4O/1ZcREEOp+f1O9AtVM=;
 b=lmB7mbynx1Hx5vRmVRV+OM25j9+akkNg+txBEkHgidQfofvCHQFrxYwVaXsrc+5++u
 EXLHLLSOvBpfvmMHcTFm4KUFKSfZqEA6uk8P7hKTv7/RpywwVQA6fGDioI5XafXtbU3o
 b6RUWrpItGsa/uq0BicPPOC/oHsA4hTJvtoJfIN1C2Ra5GG76GJIo9wIT2hGb3w+jLFt
 qDmUSHBmc2o9Ubm/D4ioR81/ne+7onmDxfmKcdaFuo8m6XzeQf/ehffpj4vmjymQFUw6
 GsOEe91Hywl8VLV4uso6I5wmtBNS62y8075HWqSry6FGImrZA8UDFj2S6qZEIP0fh/R2
 bQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713539996; x=1714144796;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Cm4MyJ8qrqJpAYLjN4p/kGa4O/1ZcREEOp+f1O9AtVM=;
 b=Ai/pQBRExBWRb5PkPhLtgxhYaoTunGzs3uhDy2PlrIz8KftM1N7NiLgJjyPcvS3z3f
 H11YPpziUNRXc+wpBwhmhkz9yCKVn4uFdAy8h6SLkbyvOm3cQNcfDTwNPEloNpTH7MaB
 r5zaGK5WiVbedKjk3ClFal9JWDPAx/kXtew7KtYRxxV539oqDXLPqXvm1TfKmIuQCgNL
 A1YXzaxd4kj92XnD5QJa6MAHjom8hn4fWyo+Tw7l6q104dyzap0BlmyTqt7XOYbn5v1a
 eDlExrdFpa9/BRViH4dcQF5j3+IbEOxh62vJTZTUm5O7elUXXIuXDBIpqcAAOnlgzAOU
 MsOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtEtHJ3sudrGfMj+DAQpRILLwKD264XRORXEdeFCKgliWXa1zmg7wMQfaRl3/NiO5TZQSkCzRxxZyxPtdxDyJeC+MLvA==
X-Gm-Message-State: AOJu0Yysnx5uwkXu9NVYnUafm0w+h4uou+asxrVwSXltXXe5q7hwHrLe
 OjMFXqFVHGA46eiDwBnzpZpMJ4za/55NIKYTuYIUwV/b6uD9nkLf/LMMBoAq22I=
X-Google-Smtp-Source: AGHT+IFeWYT+U+sYIfrgIXo8perrLPosbaJ2M+A0eYPAymBiGP7isyWRByqPhAv7qR+CVATXoA9e0Q==
X-Received: by 2002:a05:600c:4691:b0:416:bbb3:335f with SMTP id
 p17-20020a05600c469100b00416bbb3335fmr1409736wmo.24.1713539996013; 
 Fri, 19 Apr 2024 08:19:56 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
 by smtp.gmail.com with ESMTPSA id
 hi4-20020a05600c534400b0041663450a4asm10223645wmb.45.2024.04.19.08.19.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 08:19:55 -0700 (PDT)
Message-ID: <099bcc97-d22b-4f5f-9968-4c9558539c4f@linaro.org>
Date: Fri, 19 Apr 2024 17:19:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/3] mach-snapdragon: use OF_UPSTREAM
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240418-b4-qcom-rbx-fixes-v1-0-e524eb29ae86@linaro.org>
 <20240418-b4-qcom-rbx-fixes-v1-1-e524eb29ae86@linaro.org>
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
In-Reply-To: <20240418-b4-qcom-rbx-fixes-v1-1-e524eb29ae86@linaro.org>
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

On 18/04/2024 19:24, Caleb Connolly wrote:
> Switch to using upstream DT from dts/upstream.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   MAINTAINERS                       | 4 ----
>   arch/arm/Kconfig                  | 1 +
>   configs/dragonboard410c_defconfig | 2 +-
>   configs/dragonboard820c_defconfig | 2 +-
>   configs/qcom_defconfig            | 2 +-
>   5 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c0d2b5138fca..d0a4a28b401d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -605,12 +605,8 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
>   R:	Sumit Garg <sumit.garg@linaro.org>
>   L:	u-boot-qcom@groups.io
>   S:	Maintained
>   T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
> -F:	arch/arm/dts/msm8*.dtsi
> -F:	arch/arm/dts/pm8???.dtsi
> -F:	arch/arm/dts/pms405.dtsi
> -F:	arch/arm/dts/sdm845.dtsi
>   F:	drivers/*/*/pm8???-*
>   F:	drivers/gpio/msm_gpio.c
>   F:	drivers/mmc/msm_sdhci.c
>   F:	drivers/phy/msm8916-usbh-phy.c
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 23ee25269a24..2931c82eb11f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1088,8 +1088,9 @@ config ARCH_SNAPDRAGON
>   	select BOARD_LATE_INIT
>   	select OF_BOARD
>   	select SAVE_PREV_BL_FDT_ADDR
>   	select LINUX_KERNEL_IMAGE_HEADER
> +	imply OF_UPSTREAM
>   	imply CMD_DM
>   
>   config ARCH_SOCFPGA
>   	bool "Altera SOCFPGA family"
> diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
> index 260a8349d3b2..9ef04fd45546 100644
> --- a/configs/dragonboard410c_defconfig
> +++ b/configs/dragonboard410c_defconfig
> @@ -8,9 +8,9 @@ CONFIG_SYS_MALLOC_LEN=0x802000
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x8007fff0
>   CONFIG_ENV_SIZE=0x2000
>   CONFIG_ENV_OFFSET=0x0
> -CONFIG_DEFAULT_DEVICE_TREE="apq8016-sbc"
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/apq8016-sbc"
>   CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 410C"
>   CONFIG_SYS_LOAD_ADDR=0x80080000
>   CONFIG_REMAKE_ELF=y
> diff --git a/configs/dragonboard820c_defconfig b/configs/dragonboard820c_defconfig
> index ebc80eb2a464..f6b2cb09ba31 100644
> --- a/configs/dragonboard820c_defconfig
> +++ b/configs/dragonboard820c_defconfig
> @@ -6,9 +6,9 @@ CONFIG_TEXT_BASE=0x80080000
>   CONFIG_SYS_MALLOC_LEN=0x804000
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x8007fff0
>   CONFIG_ENV_SIZE=0x4000
> -CONFIG_DEFAULT_DEVICE_TREE="apq8096-db820c"
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/apq8096-db820c"
>   CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 820C"
>   CONFIG_SYS_LOAD_ADDR=0x80080000
>   CONFIG_DISTRO_DEFAULTS=y
>   CONFIG_USE_BOOTARGS=y
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index ee3ed89cbc8a..218a9a769682 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -1,9 +1,9 @@
>   CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_POSITION_INDEPENDENT=y
>   CONFIG_ARCH_SNAPDRAGON=y
> -CONFIG_DEFAULT_DEVICE_TREE="sdm845-db845c"
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
>   CONFIG_SYS_LOAD_ADDR=0x0
>   CONFIG_BUTTON_CMD=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
