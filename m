Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE63CD637CE
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08D8989045;
	Fri, 15 Nov 2024 15:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K/+9D456";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EA128904E; Fri, 15 Nov 2024 15:09:51 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 741128903C
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so16490665e9.2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731679789; x=1732284589; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=gYQzkHHEBgkrCxvU3hEQ1QMq6ajHyt0vlJYF4e8RfcI=;
 b=K/+9D456VxV8yzvZov2WLTVFxVKimvI8wLZhsqv4nRGiLhMzovz5kvSdFH7jcLkoij
 Yoswb+ihD8gEXXLycJNm14PX7HB3GCjYRK9SiHgv9aauF5orViyCoxyavxOvM16lk848
 x5Nz1JNDkKcfFkrJc/ObwZrZ89/BNDoMlZXLUlVkbGL7Vw+BTBN3Tcrx0cVBNMSIM+yd
 Pji+4JTbTwOsasukTiubPW2TTs0NrlE6P5JzGkaqTO8DPTYaFhOALyK4fYm6/oiF0GTp
 ncl4ZegULVnd6UqrOywusalq7enrhSQ5zEOYrRH3+BVsHDlkrtvaO6PGKw8sMndrju+v
 BUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731679789; x=1732284589;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gYQzkHHEBgkrCxvU3hEQ1QMq6ajHyt0vlJYF4e8RfcI=;
 b=a3N0RDHy5aUGuhqYBRF9vlukne0r0ThDm9LpfuEx6h//K0/WvW7dyVrAp38ee0kfr1
 U6EAIKXNLkh2TJP0IBF2TwAXmSoKXZ/+5JTi21hdFoftMvQVMhQXV18Ypm4G6HCQbfNe
 D80H9G67LFh32MG2Qnjbo1pxiiS31s+8LlRxcB+1D0NMoPh8RIA4av3ZZkDMmNajm4Fj
 QigWt6mR2JILZbaKbjH/afM+bp6WmdhyaZzAUWELsLKAPXpYcvDhSMkm8iRyY9QhslUm
 OHBhnRQzwlif/Sk/wgNlKsChtzCjCWIvJm8btHqQVZZ9EwAofdtjZgYt8LKxnA1pq1g3
 Jgew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvFp3reANopU80RDUPB8vyefrDLVczaOcURzYJQpmtuG/LTIVR2wYDZfIYghRLGi6imQ1sO18=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8QpgiGV6pkr+yhIxQkVVRhd1MY55uFHP0LV4Un3n2qatf2KKs
 Hc+rbds5iopIDm543Ue2rG0bcsnvxT8eGMSXXZ6VjGTYv4loZvsf/BFbFvvCfgK3GP5caIjujGO
 p
X-Google-Smtp-Source: AGHT+IHbi85f9k78amp/H+s9oKvz6yJkk2LCsgQbJmYehreD2BQifuK0HNd5uId21Q+nov2ffitZ4A==
X-Received: by 2002:a05:6000:1863:b0:382:1c00:d47a with SMTP id
 ffacd0b85a97d-38225a91de7mr2367663f8f.36.1731679461984; 
 Fri, 15 Nov 2024 06:04:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8512:42be:302f:f436?
 ([2a01:e0a:982:cbb0:8512:42be:302f:f436])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-382247849b0sm2490795f8f.97.2024.11.15.06.04.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 06:04:21 -0800 (PST)
Message-ID: <95aa89c1-f0f0-4c2c-93b7-d3f77f0d60b8@linaro.org>
Date: Fri, 15 Nov 2024 15:04:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 4/5] configs: khadas-vim3_android{_ab}: move on
 bootmeth android
To: Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
References: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
 <20241114-adnroidv2-v2-4-015bffb1373a@baylibre.com>
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
In-Reply-To: <20241114-adnroidv2-v2-4-015bffb1373a@baylibre.com>
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
> Actually khadas vim3 use distro command to boot android image.
> Move on new bootmeth android for A/B and non-A/B vim3 android.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>   configs/khadas-vim3_android_ab_defconfig |  7 ++++++-
>   configs/khadas-vim3_android_defconfig    |  7 ++++++-
>   include/configs/khadas-vim3_android.h    | 26 ++++++++++++++++++++++----
>   include/configs/meson64_android.h        |  3 ---
>   4 files changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
> index de5357c45cbf..a078c5d363ae 100644
> --- a/configs/khadas-vim3_android_ab_defconfig
> +++ b/configs/khadas-vim3_android_ab_defconfig
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
> diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
> index a0d9c423c3c3..b77a44ce859b 100644
> --- a/configs/khadas-vim3_android_defconfig
> +++ b/configs/khadas-vim3_android_defconfig
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
> diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
> index 0e2953fe71b3..096ab4e5fb1f 100644
> --- a/include/configs/khadas-vim3_android.h
> +++ b/include/configs/khadas-vim3_android.h
> @@ -41,10 +41,28 @@
>   	"name=rootfs,size=-,uuid=" ROOT_UUID
>   #endif
>   
> -#define EXTRA_ANDROID_ENV_SETTINGS \
> -	"board=vim3\0" \
> -	"board_name=vim3\0" \
> +#define CFG_EXTRA_ENV_SETTINGS                                    \
> +	"board=vim3\0"                                               \
> +	"board_name=vim3\0"                                          \
> +	"bootmeths=android\0"                                         \
> +	"bootcmd=bootflow scan\0"                                     \
> +	"adtb_idx=3\0"                                                \
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
> index 37ef8b8f7a7e..d6ef0a83a686 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -104,9 +104,6 @@
>   	"elif test $board_name = sei610; then " \
>   		"echo \"  Reading DTB for sei610...\"; " \
>   		"setenv dtb_index 1;" \
> -	"elif test $board_name = vim3; then " \
> -		"echo \"  Reading DTB for vim3...\"; " \
> -		"setenv dtb_index 3;" \
>   	"else " \
>   		"echo Error: Android boot is not supported for $board_name; " \
>   		"exit; " \
> 

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
