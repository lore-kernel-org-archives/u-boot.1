Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB71DD637CE
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F5AA88FB5;
	Fri, 15 Nov 2024 15:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hWMSPgxs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97F618904D; Fri, 15 Nov 2024 15:04:14 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86E3288EF7
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-431481433bdso5950605e9.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731679452; x=1732284252; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=lpB0qu0GSGHrXDcJf/fV0re+V5hcE5UctaQ+JRYlOx4=;
 b=hWMSPgxs4Wo9nvy0n7q1HbCTh8E0G0J3ffT9BudE9MTYEEVtAEt64Bc29SQvlyrhot
 oOxBzQDT451CVs5Hbb4FrFCQRVug9y5lm7ASKTi9QXEWGT3c99IiCfFDwHqFw+VWS3hK
 U+mrFtSykM8HA0ShmQv0Lzm/rbspLCBwsI9X26D+thGkvp1IMZhewcI1+ZLWqsvsrJAw
 0uYxgsPI3+Mrn9x+gwcEdKuVYAaXXyjAInyIL6O7KJ/estdcJJSEPeNpbmMMje9+G3gJ
 iJcYz+yjnwkr2w9PulHkSX3wTdcJmdYRY7VH2D4gGMnB3QquVaxYUiuhgRu138rkvII/
 zZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731679452; x=1732284252;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lpB0qu0GSGHrXDcJf/fV0re+V5hcE5UctaQ+JRYlOx4=;
 b=La3EuJKBfRT9Qm5DhUZGiN3UPLbX6npOQGozSmx2DV24Dq07dyfFyjixZuS7fdk5wi
 Jxf6Ik8Fz3JIxmGhYO+ucpMZH6KGWCtrjgnU3LRIk4pNzZZutNttxoxDTjTrsxec/2tN
 Mz9GXAdMLR2ePNTZhHP/yPxhHeD8oQ3w7a0fhcgawUI9r+BWjHCd4d5GDvqM8CBi5opX
 sFxLcyklDl/N8kmAG92k4aWK8rP/CPPu7bQNiGtGgUVmM7q1FIA+/lAphZPtTUegodqH
 gVmQIMiyWapr9HY3Hzz50V6rEYd0EXj0fps2MSdyCX5Pi2z0T5ivUu6VdsxVQa5e3Q8C
 X1wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMZfAZ6UoPgZKWsCa7g3H7JSepRPPd+saE6CLEjNauEn7EJ+GOgLM7Mn8GwIZ0mjUuZmeLpTI=@lists.denx.de
X-Gm-Message-State: AOJu0YzQIVkmXc5LpPCesDZ+zqDUpfSutS3g9k213Ctb8bEp5dpCjWaR
 3au+vLX0vab6YhyNb3kSMvr0FIuiMkdZcw7/bZjPHhnd43FY0A79a528Zr+mmvQ=
X-Google-Smtp-Source: AGHT+IG/H2rXaPEypfg/arEShsMb6iIyTSAfnBTzdySY3ga6aUWt8W9nQa+lW4X+PT5nMK8QNeoe2Q==
X-Received: by 2002:a05:600c:138f:b0:431:7c78:b885 with SMTP id
 5b1f17b1804b1-432df7179d4mr23188545e9.4.1731679450111; 
 Fri, 15 Nov 2024 06:04:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8512:42be:302f:f436?
 ([2a01:e0a:982:cbb0:8512:42be:302f:f436])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432d478511dsm80500835e9.0.2024.11.15.06.04.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 06:04:09 -0800 (PST)
Message-ID: <6f0f015b-e5b2-4ea6-be6a-bddd945fdcf7@linaro.org>
Date: Fri, 15 Nov 2024 15:04:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 3/5] configs: khadas-vim3l_android{_ab}: move on
 bootmeth android
To: Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
References: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
 <20241114-adnroidv2-v2-3-015bffb1373a@baylibre.com>
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
In-Reply-To: <20241114-adnroidv2-v2-3-015bffb1373a@baylibre.com>
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

On 14/11/2024 22:29, Guillaume La Roque wrote:
> Actually khadas vim3l use distro command to boot android image.
> Move on new bootmeth android for A/B and non-A/B vim3l android.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>   configs/khadas-vim3l_android_ab_defconfig |  7 ++++++-
>   configs/khadas-vim3l_android_defconfig    |  7 ++++++-
>   include/configs/khadas-vim3l_android.h    | 26 ++++++++++++++++++++++----
>   include/configs/meson64_android.h         |  3 ---
>   4 files changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
> index 4d7b90f23002..43db61056baf 100644
> --- a/configs/khadas-vim3l_android_ab_defconfig
> +++ b/configs/khadas-vim3l_android_ab_defconfig
> @@ -24,6 +24,12 @@ CONFIG_REMAKE_ELF=y
>   CONFIG_FIT=y
>   CONFIG_FIT_SIGNATURE=y
>   CONFIG_FIT_VERBOSE=y
> +CONFIG_BOOTMETH_ANDROID=y
> +# CONFIG_BOOTMETH_EXTLINUX is not set
> +# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
> +# CONFIG_BOOTMETH_EFILOADER is not set
> +# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
> +# CONFIG_BOOTMETH_VBE is not set
>   CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_OF_BOARD_SETUP=y
>   # CONFIG_DISPLAY_CPUINFO is not set
> @@ -35,7 +41,6 @@ CONFIG_SYS_MAXARGS=32
>   CONFIG_CMD_ADTIMG=y
>   CONFIG_CMD_ABOOTIMG=y
>   # CONFIG_CMD_IMI is not set
> -CONFIG_CMD_BCB=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
> diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
> index 4ec27262cdc7..32d57a5b9090 100644
> --- a/configs/khadas-vim3l_android_defconfig
> +++ b/configs/khadas-vim3l_android_defconfig
> @@ -24,6 +24,12 @@ CONFIG_REMAKE_ELF=y
>   CONFIG_FIT=y
>   CONFIG_FIT_SIGNATURE=y
>   CONFIG_FIT_VERBOSE=y
> +CONFIG_BOOTMETH_ANDROID=y
> +# CONFIG_BOOTMETH_EXTLINUX is not set
> +# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
> +# CONFIG_BOOTMETH_EFILOADER is not set
> +# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
> +# CONFIG_BOOTMETH_VBE is not set
>   CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_OF_BOARD_SETUP=y
>   # CONFIG_DISPLAY_CPUINFO is not set
> @@ -34,7 +40,6 @@ CONFIG_SYS_MAXARGS=32
>   CONFIG_CMD_ADTIMG=y
>   CONFIG_CMD_ABOOTIMG=y
>   # CONFIG_CMD_IMI is not set
> -CONFIG_CMD_BCB=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
> diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
> index f39a3782d663..31068c59d5ed 100644
> --- a/include/configs/khadas-vim3l_android.h
> +++ b/include/configs/khadas-vim3l_android.h
> @@ -41,10 +41,28 @@
>   	"name=rootfs,size=-,uuid=" ROOT_UUID
>   #endif
>   
> -#define EXTRA_ANDROID_ENV_SETTINGS \
> -	"board=vim3l\0" \
> -	"board_name=vim3l\0" \
> +#define CFG_EXTRA_ENV_SETTINGS                                    \
> +	"board=vim3l\0"                                               \
> +	"board_name=vim3l\0"                                          \
> +	"bootmeths=android\0"                                         \
> +	"bootcmd=bootflow scan\0"                                     \
> +	"adtb_idx=2\0"                                                \
> +	"partitions=" PARTS_DEFAULT "\0"                              \
> +	"mmcdev=2\0"                                                  \
> +	"fastboot_raw_partition_bootloader=0x1 0xfff mmcpart 1\0"     \
> +	"fastboot_raw_partition_bootenv=0x0 0xfff mmcpart 2\0"        \
> +	"gpio_recovery=88\0"                                          \
> +	"stdin=" STDIN_CFG "\0"                                       \
> +	"stdout=" STDOUT_CFG "\0"                                     \
> +	"stderr=" STDOUT_CFG "\0"                                     \
> +	"dtboaddr=0x08200000\0"                                       \
> +	"loadaddr=0x01080000\0"                                       \
> +	"fdt_addr_r=0x01000000\0"                                     \
> +	"scriptaddr=0x08000000\0"                                     \
> +	"kernel_addr_r=0x01080000\0"                                  \
> +	"pxefile_addr_r=0x01080000\0"                                 \
> +	"ramdisk_addr_r=0x13000000\0"                                 \
>   
> -#include <configs/meson64_android.h>
> +#include <configs/meson64.h>
>   
>   #endif /* __CONFIG_H */
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index 77364bbf9cf0..37ef8b8f7a7e 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -104,9 +104,6 @@
>   	"elif test $board_name = sei610; then " \
>   		"echo \"  Reading DTB for sei610...\"; " \
>   		"setenv dtb_index 1;" \
> -	"elif test $board_name = vim3l; then " \
> -		"echo \"  Reading DTB for vim3l...\"; " \
> -		"setenv dtb_index 2;" \
>   	"elif test $board_name = vim3; then " \
>   		"echo \"  Reading DTB for vim3...\"; " \
>   		"setenv dtb_index 3;" \
> 

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
