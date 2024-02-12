Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B6BC4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 08:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 476CD876D3;
	Mon, 12 Feb 2024 09:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JPxc1K62";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C92287996; Mon, 12 Feb 2024 09:46:58 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20C0B876A9
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 09:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40fd2f7ef55so21751085e9.0
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 00:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707727615; x=1708332415; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=FsyfvOGKjV4oLHBSUmJZVuMWe1FDn1/3xhvUTM0kBfQ=;
 b=JPxc1K62GSpGoRL5oATO2S05FuxhZKekBJYwyXv0mc4LQU3GBlG0dWHoPa5DXjySbS
 lTAgynkErTo5sjE5ktz+4sUIle5kqIO9FsaUVxSKRmeiVy5Vv7BFEWYvakXgDT1N23KC
 HAe6Ka81Uia3BVQutuQOP/VU4QwuIFIHIl33sphcou4KRje72x/+7mfy9s3/OOYEcmB0
 2iWNdhK/IEx545bU9N7Bd6qUhCTy9DcW+Qhcu0sykf2bg+3NWllNbD+PobcGxv892N8J
 3zw9PSXpW4prX89mrUMcUD2pj5qlDKTQFWdHA3bfwl0cgHTM9JCoraiu/iwuJ8Th201B
 Es2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707727615; x=1708332415;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FsyfvOGKjV4oLHBSUmJZVuMWe1FDn1/3xhvUTM0kBfQ=;
 b=HMFE3w3n9TiaMMvg/GHFMlvxs28R8JMB6XMUYsuZz8mXEXscnl1iPIJ4XME+4W1jFu
 /MCVddHvafJMgNPxo8qXF0lQ25ar9sWSD3JdwEgOHgCN7h2o/YBj5muAQI9Cfy+39mad
 I51GAo7/LhEhR8yoyKTIVZsOXRNPFU4S6Jg5Y3hhOAo+E8xxkpbLhdgslLjGU0ji1rkC
 Hk1PiDT/W7N3cgae/aMB6MOs/XkOZ/k/RqC+4CQ9Q2ktNpSRwl1PGQkUUHQpbnx/5ofx
 PTY1sUYhBb7vtcfXIr7F77jqHlizUMSDhmhTHc0nl42h8THPE7oV/jjdVkvxk8XA5SWZ
 RDaA==
X-Gm-Message-State: AOJu0Yw+z+4C2099p52PkE8SYvFK2uZ6jxMtIdxdx6ddu0VLdv4NkX9l
 icMjnsZ5hvUWC42zUlttQ8YeDw+FJGkHrKvT1QYbdVgETyiQiy0woBMnOQ9Kl4g=
X-Google-Smtp-Source: AGHT+IETvwUR3iD6rRYOSRrznHvQGfa6Gnb8c34M0LLNxpwNc9wTi+FX+JKO42/NoMFwc+j8jWo06w==
X-Received: by 2002:a05:600c:4f42:b0:410:709e:f223 with SMTP id
 m2-20020a05600c4f4200b00410709ef223mr5030670wmq.9.1707727615513; 
 Mon, 12 Feb 2024 00:46:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWc9CVFU9s1iK5bjVgn202CiRILRD1oPR2dLqIbQV1rLk3Xf5olG3VidJV3u0leqhrkCjeTqq2X3eiMBeYsrgAcZ9JgissrPbOQ7oEXS+mLIE8jnwHYuwDt+KMspPAL
Received: from [192.168.7.190] (212-114-21-58.box.freepro.com. [212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 jx6-20020a05600c578600b0040ffd94cd27sm7816237wmb.45.2024.02.12.00.46.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 00:46:55 -0800 (PST)
Message-ID: <0aed6601-145e-4645-9fcd-efaae6eaacb4@linaro.org>
Date: Mon, 12 Feb 2024 09:46:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] configs: khadas-vim3*_android: fix AVB oom error
Content-Language: en-US, fr
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
References: <20240209-vim3-avb-malloc-v1-1-91427d8c19ab@baylibre.com>
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
In-Reply-To: <20240209-vim3-avb-malloc-v1-1-91427d8c19ab@baylibre.com>
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

On 09/02/2024 09:58, Mattijs Korpershoek wrote:
> When booting Android with AVB enabled, an OOM is observed:
> 
>    => avb init ${mmcdev}
>    => avb verify _a
>    ## Android Verified Boot 2.0 version 1.1.0
>    read_is_device_unlocked not supported yet
>    read_rollback_index not supported yet
>    avb_util.c:182: ERROR: Failed to allocate memory.
>    OOM error occurred during verification
> 
> A custom malloc length of 128MB is required as documented in
> commit 285a83b12bdf ("configs: meson64_android: increase SYS_MALLOC_LEN to 128M for AVB")
> 
> However, this 128M custom malloc length was not ported to Kconfig in
> commit 7cfbba36e9f8 ("Convert CONFIG_SYS_MALLOC_LEN to Kconfig")
> 
> Add it back to fix AVB verification on VIM3/VIM3L.
> 
> Fixes: 7cfbba36e9f8 ("Convert CONFIG_SYS_MALLOC_LEN to Kconfig")
> Co-developed-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   configs/khadas-vim3_android_ab_defconfig  | 1 +
>   configs/khadas-vim3_android_defconfig     | 1 +
>   configs/khadas-vim3l_android_ab_defconfig | 1 +
>   configs/khadas-vim3l_android_defconfig    | 1 +
>   4 files changed, 4 insertions(+)
> 
> diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
> index b41c2660fff0..ee62fe36d414 100644
> --- a/configs/khadas-vim3_android_ab_defconfig
> +++ b/configs/khadas-vim3_android_ab_defconfig
> @@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="vim3"
>   CONFIG_SYS_CONFIG_NAME="khadas-vim3_android"
>   CONFIG_ARCH_MESON=y
>   CONFIG_TEXT_BASE=0x01000000
> +CONFIG_SYS_MALLOC_LEN=0x08000000
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
> index 88197f5f5e99..cecbe5061793 100644
> --- a/configs/khadas-vim3_android_defconfig
> +++ b/configs/khadas-vim3_android_defconfig
> @@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="vim3"
>   CONFIG_SYS_CONFIG_NAME="khadas-vim3_android"
>   CONFIG_ARCH_MESON=y
>   CONFIG_TEXT_BASE=0x01000000
> +CONFIG_SYS_MALLOC_LEN=0x08000000
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
> index 3381d2e92701..ec4e0dc72e22 100644
> --- a/configs/khadas-vim3l_android_ab_defconfig
> +++ b/configs/khadas-vim3l_android_ab_defconfig
> @@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="vim3"
>   CONFIG_SYS_CONFIG_NAME="khadas-vim3l_android"
>   CONFIG_ARCH_MESON=y
>   CONFIG_TEXT_BASE=0x01000000
> +CONFIG_SYS_MALLOC_LEN=0x08000000
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
> index 3fa587ef1db5..206f8defca6b 100644
> --- a/configs/khadas-vim3l_android_defconfig
> +++ b/configs/khadas-vim3l_android_defconfig
> @@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="vim3"
>   CONFIG_SYS_CONFIG_NAME="khadas-vim3l_android"
>   CONFIG_ARCH_MESON=y
>   CONFIG_TEXT_BASE=0x01000000
> +CONFIG_SYS_MALLOC_LEN=0x08000000
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> 
> ---
> base-commit: 076529725f16f07a5cb2d5feba25d62b5f5a5872
> change-id: 20240209-vim3-avb-malloc-aa3de534d6a0
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
