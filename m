Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDEBCA1013
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 08:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10A7E82AE9;
	Mon,  8 Sep 2025 10:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VLwzgmnz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 043D382DA1; Mon,  8 Sep 2025 10:13:40 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F26FF800B6
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 10:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3e2fdddd01dso509621f8f.2
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 01:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757319217; x=1757924017; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=9iBapWgwRqiXRlt0vE5a+EpSdNZ2hubF+RfUp2joKM4=;
 b=VLwzgmnzLX7Zgibx4GI3KgYlhByRVg9UQ1lyYzg4ys8gWzlTZGcLAb/pNPZlZNakrx
 pqTuNZmMZDjcDQyx50B/GIhsTuBz9x0tohWBdmvmSKu3AknI+pM2ZEaNTfqkyxEVjOVQ
 huQ3Y+S+ostmz+sGlyJNIPa2BdBtvMtZWmT//B42J910LU2Xml+kb6bQJ/Owq6xYuJlu
 fF7I7Ci4oilkSdRMKYqbMhICZaw3UYbBCKgC7nqu8UlEdbar3oyHepOhvPJ6ErsgYGUl
 xjkmLO41bgQJcBBZoLuqm3BjKzLc0HnwfOwoeTzS8DnKSRmwUms9k2/9CCXsfXBKd9k9
 kgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757319217; x=1757924017;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9iBapWgwRqiXRlt0vE5a+EpSdNZ2hubF+RfUp2joKM4=;
 b=OH0FqccKeRpYV1ur1jHk7aObMJIzfjkyT917fWd0uI55xiAXtvte8ti9gRwlNhQJWN
 Exm2qlxo3B9/IYO6qzN0L1dYLlaBur9sOCQjGQjMEe4w6mL1BLtGLF2a047BV5VcGV4L
 neSq0hTDd5Enmq+5gjGjO9Q0SQImT045VO2gc3dMggf34qFgvYqJjzI6h0DrMdz/ZraT
 9jqXz6GC7KJsrFVmAFi8W7Ia40zD+aj861ocujsNlGc/NiCblWmokpxXnqo8JpL/H5Tj
 UVl5VOUuiIFNsUPvhFLmUf+dZy0kXfoOBP5f8qWI9qa+axLsH/zbhtxs6cCkaOvOntk9
 GXHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9XLxo6RtjyfSw8dMH9Wvej3HvglfS9PSGRIX76sdH3gl6fsmyBGAGFOHUqtaZf4SUVTlfWOw=@lists.denx.de
X-Gm-Message-State: AOJu0YxNrYb8Xfm17+HB3NVBGKXZJnUj7RwXTnwW3S9R+OkGLNHaEaWK
 yWwfDSiQGKVxpJxjKgYcjcV/Ci0bL070tLNyjqIZbiMLpAKgTfQv9i2i9h+PuE0QbAI=
X-Gm-Gg: ASbGnctflom7fMqURRXllCb9h57kHZzLRZNNYCZRVP623d6KxvdFrjMl8ym7fDWyKNz
 dnRnJdjaRBTeFNS4lefgj9MiFvdwkRzYfQqqMiwU/zgPUSpFT3h0o7INkDy28Ag4pv2XzoDnfaF
 DnSbUJPFRYW2absBjoOTsEpujbw/y6Z1Dh0C/AlVup+iAkfoeuwH3sZrXmb7F/FtNQwZtAXf3vp
 s07AX5T71Tzfc/ImSLKULZKDudHBPTPAYo+nItu8OBP9M2Khdc7ggHZ401Khtd3+NAFUuwZVtlh
 Jv9Bof1PCD1d9beUSJlD/eOAFt3wqQr0v6/rFDIyb9GrJ8NMXNBevk37whcctktdgo+u6svXWPf
 YOVvrtvrNmD4DjV1d/FRAFS78w+9pu2vYPF/S1OaB1ShKFbMVwKZReuYgt0FyGGxz3riAk0bDa7
 kHkARjMP6Itg==
X-Google-Smtp-Source: AGHT+IGpGvDX2X6HzO8xX/1OyGYK377MG/5Bb72VAJMjVsH10CJgGS4eMQppVkujYzI62FieuvBsdw==
X-Received: by 2002:a05:6000:3106:b0:3e6:116a:8fed with SMTP id
 ffacd0b85a97d-3e64bde97a5mr5530130f8f.45.1757319217286; 
 Mon, 08 Sep 2025 01:13:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:61c1:5d31:4427:381b?
 ([2a01:e0a:3d9:2080:61c1:5d31:4427:381b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b9c5c89f2sm245164025e9.14.2025.09.08.01.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 01:13:36 -0700 (PDT)
Message-ID: <ac3a7c41-92d1-4045-a258-c09f80432c9c@linaro.org>
Date: Mon, 8 Sep 2025 10:13:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 8/9] board: amlogic: add kconfig fragments for SPL
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-8-37395d9ff5af@postmarketos.org>
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
In-Reply-To: <20250907-spl-gx-v1-8-37395d9ff5af@postmarketos.org>
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
> Add kconfig fragments for building SPL binaries for:
>   · ODROID-C2
>   · Videostrong KII Pro
>   · Libre Computer LePotato (1 GB and 2 GB variants)
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   board/amlogic/p200/spl-odroid-c2.config           | 37 ++++++++++++++++++++++
>   board/amlogic/p200/spl-videostrong-kii-pro.config | 38 +++++++++++++++++++++++
>   board/amlogic/p212/spl-libretech-cc-1gb.config    | 36 +++++++++++++++++++++
>   board/amlogic/p212/spl-libretech-cc-2gb.config    | 38 +++++++++++++++++++++++
>   4 files changed, 149 insertions(+)
> 
> diff --git a/board/amlogic/p200/spl-odroid-c2.config b/board/amlogic/p200/spl-odroid-c2.config
> new file mode 100644
> index 0000000000000000000000000000000000000000..d5ea295bc6d281f3d7770cc841ccbae5aee468a4
> --- /dev/null
> +++ b/board/amlogic/p200/spl-odroid-c2.config
> @@ -0,0 +1,37 @@
> +#
> +# U-Boot SPL fragment for odroid-c2
> +#
> +
> +CONFIG_SPL=y
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_SPL_TEXT_BASE=0xd9001000
> +CONFIG_SPL_STACK=0xd9013000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0xd900c000
> +CONFIG_SPL_HAVE_INIT_STACK=y
> +CONFIG_SPL_BSS_MAX_SIZE=0x1000
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +# CONFIG_SPL_SERIAL_PRESENT is not set
> +# CONFIG_SPL_SHA1 is not set
> +
> +# Enable MMC and serial drivers
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_MMC=y
> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x100
> +# CONFIG_SYS_MMCSD_FS_BOOT is not set
> +
> +# Image things
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_FIT_IMAGE_POST_PROCESS=y
> +CONFIG_SPL_MAX_SIZE=0xb000
> +CONFIG_SPL_PAD_TO=0x1fe00
> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_OF_CONTROL=y
> +# DRAM configuration
> +CONFIG_DRAM_SIZE=2048
> +CONFIG_DRAM_2T_MODE=y
> +CONFIG_DRAM_TWO_IDENTICAL_RANKS=y
> diff --git a/board/amlogic/p200/spl-videostrong-kii-pro.config b/board/amlogic/p200/spl-videostrong-kii-pro.config
> new file mode 100644
> index 0000000000000000000000000000000000000000..5b3ba9d990840411ef3cef3db3c6aa9d7085b3ef
> --- /dev/null
> +++ b/board/amlogic/p200/spl-videostrong-kii-pro.config
> @@ -0,0 +1,38 @@
> +#
> +# U-Boot SPL fragment for videostrong-kii-pro
> +#
> +
> +CONFIG_SPL=y
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_SPL_TEXT_BASE=0xd9001000
> +CONFIG_SPL_STACK=0xd9013000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0xd900c000
> +CONFIG_SPL_HAVE_INIT_STACK=y
> +CONFIG_SPL_BSS_MAX_SIZE=0x1000
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +# CONFIG_SPL_SERIAL_PRESENT is not set
> +# CONFIG_SPL_SHA1 is not set
> +
> +# Enable MMC and serial drivers
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_MMC=y
> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x100
> +# CONFIG_SYS_MMCSD_FS_BOOT is not set
> +
> +# Image things
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_FIT_IMAGE_POST_PROCESS=y
> +CONFIG_SPL_MAX_SIZE=0xb000
> +CONFIG_SPL_PAD_TO=0x1fe00
> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_OF_CONTROL=y
> +# DRAM configuration
> +CONFIG_DRAM_SIZE=2048
> +CONFIG_DRAM_2T_MODE=y
> +CONFIG_DRAM_TWO_DIFF_RANKS=y
> +
> diff --git a/board/amlogic/p212/spl-libretech-cc-1gb.config b/board/amlogic/p212/spl-libretech-cc-1gb.config
> new file mode 100644
> index 0000000000000000000000000000000000000000..f58bb69325980d582d2d826ebbf28e4700965dfb
> --- /dev/null
> +++ b/board/amlogic/p212/spl-libretech-cc-1gb.config
> @@ -0,0 +1,36 @@
> +#
> +# U-Boot SPL fragment for libretech-cc (1 GB variant)
> +#
> +
> +CONFIG_SPL=y
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_SPL_TEXT_BASE=0xd9001000
> +CONFIG_SPL_STACK=0xd9013000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0xd900c000
> +CONFIG_SPL_HAVE_INIT_STACK=y
> +CONFIG_SPL_BSS_MAX_SIZE=0x1000
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +# CONFIG_SPL_SERIAL_PRESENT is not set
> +# CONFIG_SPL_SHA1 is not set
> +
> +# Enable MMC and serial drivers
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_MMC=y
> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x100
> +# CONFIG_SYS_MMCSD_FS_BOOT is not set
> +
> +# Image things
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_FIT_IMAGE_POST_PROCESS=y
> +CONFIG_SPL_MAX_SIZE=0xb000
> +CONFIG_SPL_PAD_TO=0x1fe00
> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_OF_CONTROL=y
> +# DRAM configuration
> +CONFIG_DRAM_2T_MODE=y
> +CONFIG_DRAM_DQS_CORR=y
> diff --git a/board/amlogic/p212/spl-libretech-cc-2gb.config b/board/amlogic/p212/spl-libretech-cc-2gb.config
> new file mode 100644
> index 0000000000000000000000000000000000000000..65d700558e65ca8d819f397a0153be8bf07ae702
> --- /dev/null
> +++ b/board/amlogic/p212/spl-libretech-cc-2gb.config
> @@ -0,0 +1,38 @@
> +#
> +# U-Boot SPL fragment for libretech-cc (2 GB variant)
> +#
> +
> +CONFIG_SPL=y
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_SPL_TEXT_BASE=0xd9001000
> +CONFIG_SPL_STACK=0xd9013000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0xd900c000
> +CONFIG_SPL_HAVE_INIT_STACK=y
> +CONFIG_SPL_BSS_MAX_SIZE=0x1000
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +# CONFIG_SPL_SERIAL_PRESENT is not set
> +# CONFIG_SPL_SHA1 is not set
> +
> +# Enable MMC and serial drivers
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_MMC=y
> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x100
> +# CONFIG_SYS_MMCSD_FS_BOOT is not set
> +
> +# Image things
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_FIT_IMAGE_POST_PROCESS=y
> +CONFIG_SPL_MAX_SIZE=0xb000
> +CONFIG_SPL_PAD_TO=0x1fe00
> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_OF_CONTROL=y
> +# DRAM configuration
> +CONFIG_DRAM_SIZE=2048
> +CONFIG_DRAM_2T_MODE=y
> +CONFIG_DRAM_DQS_CORR=y
> +CONFIG_DRAM_TWO_IDENTICAL_RANKS=y
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
