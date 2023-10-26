Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89ED2C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 15:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A226D875D1;
	Thu, 26 Oct 2023 17:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oqZykeWJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 714BB875CB; Thu, 26 Oct 2023 17:37:05 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71DCD875D1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 17:37:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4083f61322fso8364715e9.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 08:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698334622; x=1698939422; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CfViyEpUZt6CJrymvsSheWE2uchD9c00WcrztQfVUwA=;
 b=oqZykeWJdcQxGWVZGTB+jQQIWP7Y9ONtzAw8NhwZrU84mTrGFsB9H4IOl0S2p4znOc
 /3dGywHTszdynFDG6fznkqEtY8vSYHa33p5iIKU/IXUgqX16Q7k3/OW+VtgCRUFlve2o
 Q09rSIGhSMBcgaktUiIJLz47xJpsKc7VZf/eFXWlM5AinFQjwZHRMTBG3uel1V/0FH3i
 bZ0393ak0T4cYd8RudhJOpM1rdDTCKq5zV7YdERdVg2EQTl1ZbTa+6XtSBEfUZ6LF9WT
 ENVqxnOXNxysPUSp7CpnlzN2UWK2L1ZWsB7XeRpGWUzPyNSrLn7IBwv49EXl/vK5zbA3
 MqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698334622; x=1698939422;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CfViyEpUZt6CJrymvsSheWE2uchD9c00WcrztQfVUwA=;
 b=C1cTqwqDppput1bn9CTo5ptqVRF46IKboPOdXzeZVjlRNoBYEzjKVX5M/i0Qg75p7z
 S9Ntm4DSTgQxKs00umnaNYe1E0uq3F9Nt9Mcihf4JLO2swLoxsKByMNIdw+mLLOFPaZi
 6Cl+r5xv2FopeoVAwEA6HbmvBb0ef6Rb3y5XggHMJvDvYS72Ju92nGRkQjibao2rkEYd
 H6wI/w1kRRtNqOs22fGvTff4pMWRvgheNMlRA2yGtMY7VSeRa3zTxQMR5XqrvDBCEBLY
 H2kUOIXGTOPiYurjThbkeq1IxEm/82zJyMnkSgCQGlf9MjaWxmBZ3ob1MIocMbNamXYl
 oztg==
X-Gm-Message-State: AOJu0YxHeFc4/kxH6o9VzYXcv1uhoJIrY3+TGja5GAnM0ROEYq6C+YVq
 5/UMkFikJs+ms2Mqs5i0Cn5/8A==
X-Google-Smtp-Source: AGHT+IF5MVGEcPwuFl8w9SFV2+J4gd6J/1JCKBlnf7vekjxTv5mLC9UEAOHd7HnzaP5mNHio2UrTHQ==
X-Received: by 2002:a05:600c:4fc2:b0:406:177e:5df7 with SMTP id
 o2-20020a05600c4fc200b00406177e5df7mr121210wmq.29.1698334621646; 
 Thu, 26 Oct 2023 08:37:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f57f:eb08:d29b:8c9c?
 ([2a01:e0a:982:cbb0:f57f:eb08:d29b:8c9c])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a5d5609000000b0032da7454ebesm14475858wrv.79.2023.10.26.08.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 08:37:01 -0700 (PDT)
Message-ID: <8e3c3c31-6f42-4d62-8778-d91a525b05d6@linaro.org>
Date: Thu, 26 Oct 2023 17:37:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] configs: khadas-vim3*_android: fix environment saving
Content-Language: en-US, fr
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
References: <20231026-fix-saveenv-v1-1-6aa59be65481@baylibre.com>
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
In-Reply-To: <20231026-fix-saveenv-v1-1-6aa59be65481@baylibre.com>
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

On 26/10/2023 15:41, Mattijs Korpershoek wrote:
> The environment is used to configure some additional boot features such as:
> * extra boot arguments
> * enable AVB (Android Verified Boot) verification
> 
> Right now, we cannot store it in eMMC:
> 
>    Loading Environment from nowhere... OK
> 
> Fix it by enabling the appropriate options in the defconfig
> 
> Fixes: b749d5ecdc06 ("configs: meson64_android: define raw parts for bootloader")
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   configs/khadas-vim3_android_ab_defconfig  | 4 ++++
>   configs/khadas-vim3_android_defconfig     | 4 ++++
>   configs/khadas-vim3l_android_ab_defconfig | 4 ++++
>   configs/khadas-vim3l_android_defconfig    | 4 ++++
>   4 files changed, 16 insertions(+)
> 
> diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
> index ccd6f6f8a075..0abccb64ee15 100644
> --- a/configs/khadas-vim3_android_ab_defconfig
> +++ b/configs/khadas-vim3_android_ab_defconfig
> @@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
>   CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x0
>   CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
>   CONFIG_OF_LIBFDT_OVERLAY=y
> @@ -45,7 +46,10 @@ CONFIG_CMD_AB_SELECT=y
>   CONFIG_CMD_REGULATOR=y
>   CONFIG_CMD_AVB=y
>   CONFIG_OF_CONTROL=y
> +CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_DEV=2
> +CONFIG_SYS_MMC_ENV_PART=2
>   CONFIG_ADC=y
>   CONFIG_SARADC_MESON=y
>   CONFIG_BUTTON=y
> diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
> index 5c3d565971d6..33ede5262295 100644
> --- a/configs/khadas-vim3_android_defconfig
> +++ b/configs/khadas-vim3_android_defconfig
> @@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
>   CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x0
>   CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
>   CONFIG_OF_LIBFDT_OVERLAY=y
> @@ -43,7 +44,10 @@ CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_CMD_REGULATOR=y
>   CONFIG_CMD_AVB=y
>   CONFIG_OF_CONTROL=y
> +CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_DEV=2
> +CONFIG_SYS_MMC_ENV_PART=2
>   CONFIG_ADC=y
>   CONFIG_SARADC_MESON=y
>   CONFIG_BUTTON=y
> diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
> index 0d6de8001382..8f32f8e8ad5b 100644
> --- a/configs/khadas-vim3l_android_ab_defconfig
> +++ b/configs/khadas-vim3l_android_ab_defconfig
> @@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
>   CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x0
>   CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
>   CONFIG_OF_LIBFDT_OVERLAY=y
> @@ -45,7 +46,10 @@ CONFIG_CMD_AB_SELECT=y
>   CONFIG_CMD_REGULATOR=y
>   CONFIG_CMD_AVB=y
>   CONFIG_OF_CONTROL=y
> +CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_DEV=2
> +CONFIG_SYS_MMC_ENV_PART=2
>   CONFIG_ADC=y
>   CONFIG_SARADC_MESON=y
>   CONFIG_BUTTON=y
> diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
> index 827752f24373..443c10aee3d0 100644
> --- a/configs/khadas-vim3l_android_defconfig
> +++ b/configs/khadas-vim3l_android_defconfig
> @@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
>   CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x0
>   CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
>   CONFIG_OF_LIBFDT_OVERLAY=y
> @@ -43,7 +44,10 @@ CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_CMD_REGULATOR=y
>   CONFIG_CMD_AVB=y
>   CONFIG_OF_CONTROL=y
> +CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_DEV=2
> +CONFIG_SYS_MMC_ENV_PART=2
>   CONFIG_ADC=y
>   CONFIG_SARADC_MESON=y
>   CONFIG_BUTTON=y
> 
> ---
> base-commit: 14a21f1a80afc58d52dc72e35f27d3a47d36c082
> change-id: 20231026-fix-saveenv-eb5484622282
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
