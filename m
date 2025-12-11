Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD57D41D5F
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 15:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6126D83869;
	Thu, 11 Dec 2025 16:44:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XF2fSRkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5AF08389A; Thu, 11 Dec 2025 16:44:36 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B5078367F
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 16:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso1274835e9.1
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 07:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765467874; x=1766072674; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=NSmP6L2iOHNaoyVL/LzA2LcpYgdz6B9ort77RDUjaB8=;
 b=XF2fSRkR/1ak2KOU/hd9VhbqXmUicFjUK2+4zwWPxJvVk+gnysT6ZESiyS1jJ8BiRZ
 WCYWwMAwJdA6ftMw1zL2Li6LklSiAOUzwb+TOuNcvlx6BPTmlwpTEWxh3Eaa6dL9sasJ
 BRIalzfCOFTnRkxO1RKYDG69Rj1PpBDF7rtpdzzbC9Whu5FW8pJl6FQz4EHdCWTvXjJy
 ThmKUkLDQBkW8Af5njG9YIFj4JmJwqqlNXVBob0ddUy91KTBJZ/D25HfldMffz4H5wNU
 aGL9b5blX+Hg4tSVaUPRqRjxmk9jl50iYEZE32Vfms5iM3787+hnQQD+DMqRxeB0SJfq
 jwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765467874; x=1766072674;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NSmP6L2iOHNaoyVL/LzA2LcpYgdz6B9ort77RDUjaB8=;
 b=Bsqez+XosshSmA9q/5y4ZeKet7GijSspRIWqaoLETXPNt+6hqGYq1g9NBf3g1Hyvae
 j6pB4U9KD8o4XuW7u4Ya1nqgEkTGV0spSUoWLbDrBYxEvOrMNfKLG44Jv57OBPySgVYC
 fQf7BgJHX58+S2BdkPG9Pn1WKRtzWkvb9O4CAtOq3cyB1gQdfhrM04E3Bi6RhWvvmfG7
 TcU0c9F+uPkfvc6P9dgTQPq5IcmHJ32ah//93uKt7Hq5g8pQjnZaQiz6ThuwqLj9URt4
 PqLmlhSmKVunOs9FkKcn3dvD+E1vgsbg7KpJnfzhtkMe0FYghfGXmAWkIY89HusUYTdz
 Bttg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmA7mSzosG7r1yjVJXmKDSHwA3Dmm3A3nxb9JGqkfmr/As72lvq290WKqvVz86cAbO+6SMib8=@lists.denx.de
X-Gm-Message-State: AOJu0YxIfSKw30Q19oj6IoI2gCG3gMK9Mky0LCMEsjKxbr9ndNStl0ED
 KKGE001M8lr+etnMyYenAbq1YGu3wNCKoeMWGuzVVZpJTCUg4xpWtGdEvrwEz14zc89GlM5ViO8
 rxuuT
X-Gm-Gg: AY/fxX4L0m60XnM4fNA1zeAYOWEOvlLjzVeyjabzhBqC8QAtRukFi/Tsi92ciABIxm2
 K/juF9U3UIXkuz/V8C2BhyuPS1CN/TDtZl3iiZIJvXHTojgZb8vAXlpaAL+ieuBgwMRHtjn8eHB
 Nz9CAu7tJM20QOykM42vGTYQLgQsv6HuWjAlM3CGeAgaCRB1dUNctugY784PLFEPS6ulAHRxdT+
 IJiMiWQZsjllQjWKib9uJcjZErrAfLunzE9Dk0CwkgWwnC0cgoB0PySI6Y/oXQyXVJ1y63bVB0/
 wBB2jrO0Lf99pumnYNmsmZGyFwKcM8cFwjYMpKUUCNG4IQuPuMrfNS/jML69017CsR6lh+B8uyN
 a/XiZBmRz9a5CPMt4yqMTPqdHt2T+nj5SdxRQ8rwNs5tDstb5YPLbPXpSPpVffCr9cptwg2vdTw
 h3U1jnmzM8RH0azHcUEuBcLJvwBdI6GlMTojyaOdH0WhNDeRmhIgJ5S/p9tE+h
X-Google-Smtp-Source: AGHT+IGguGZ4yBGf4wrdpXTHxWWYAILOYd/nnhWz9ZZDopBy2rKc11tgve2pYoY7VE4gKZXezkfS5w==
X-Received: by 2002:a05:6000:2586:b0:42b:32d1:28ae with SMTP id
 ffacd0b85a97d-42fab276f4dmr2825763f8f.22.1765467873648; 
 Thu, 11 Dec 2025 07:44:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:1fdc:8c26:84af:4a6?
 ([2a01:e0a:3d9:2080:1fdc:8c26:84af:4a6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b96c70sm6290268f8f.37.2025.12.11.07.44.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 07:44:33 -0800 (PST)
Message-ID: <7a30f8de-c87b-46e3-83e9-6d61484b2ecb@linaro.org>
Date: Thu, 11 Dec 2025 16:44:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 1/2] arm: meson: add support for EFI capsule updates
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Viacheslav Bocharov <adeep@lexina.in>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Ferass El Hafidi <funderscore@tauchgang.dev>,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20251211-meson-capsule-v4-0-59f126ba4115@postmarketos.org>
 <20251211-meson-capsule-v4-1-59f126ba4115@postmarketos.org>
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
In-Reply-To: <20251211-meson-capsule-v4-1-59f126ba4115@postmarketos.org>
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

On 12/11/25 16:37, Ferass El Hafidi wrote:
> Previously, few Amlogic devices supported EFI capsule updates.
> Generally only the Libre Computer ones with SPI flash supported it,
> thanks to board-specific code.
> 
> This commit commonises capsule update support across supported
> Amlogic boards.  Similar to Qualcomm's support for it, the dfu string
> and firmware name is automatically generated at runtime depending on
> which device we are booted from.  Right now this supports flashing to
> the eMMC/SD and SPI flash.
> 
> As usual, the capsule UUID is automatically generated.  You can get it
> by enabling CONFIG_CMD_EFIDEBUG and running:
> 
> 	=> efidebug capsule esrt
> 	========================================
> 	ESRT: fw_resource_count=1
> 	ESRT: fw_resource_count_max=1
> 	ESRT: fw_resource_version=1
> 	[entry 0]==============================
> 	ESRT: fw_class=796180D4-AAB2-50F1-B16A-53DFF9CA89B2
> 	ESRT: fw_type=unknown
> 	ESRT: fw_version=0
> 	ESRT: lowest_supported_fw_version=0
> 	ESRT: capsule_flags=0
> 	ESRT: last_attempt_version=0
> 	ESRT: last_attempt_status=success
> 	========================================
> 
> Reviewed-by: Evgeny Bachinin <EABachinin@salutedevices.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   arch/arm/include/asm/arch-meson/boot.h |  2 ++
>   arch/arm/mach-meson/Makefile           |  2 +-
>   arch/arm/mach-meson/board-common.c     |  5 +++
>   arch/arm/mach-meson/capsule.c          | 61 ++++++++++++++++++++++++++++++++++
>   4 files changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/arch-meson/boot.h b/arch/arm/include/asm/arch-meson/boot.h
> index a11dfde719e..e66b45983fe 100644
> --- a/arch/arm/include/asm/arch-meson/boot.h
> +++ b/arch/arm/include/asm/arch-meson/boot.h
> @@ -21,6 +21,8 @@ int meson_get_boot_device(void);
>   
>   int meson_get_soc_rev(char *buff, size_t buff_len);
>   
> +void meson_setup_capsule(void);
> +
>   /**
>    * meson_get_socinfo - retrieve cpu_id of the Amlogic SoC
>    *
> diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
> index 535b0878b91..640921e2b8e 100644
> --- a/arch/arm/mach-meson/Makefile
> +++ b/arch/arm/mach-meson/Makefile
> @@ -2,7 +2,7 @@
>   #
>   # Copyright (c) 2016 Beniamino Galvani <b.galvani@gmail.com>
>   
> -obj-y += board-common.o sm.o board-info.o
> +obj-y += board-common.o sm.o board-info.o capsule.o
>   obj-$(CONFIG_MESON_GX) += board-gx.o
>   obj-$(CONFIG_MESON_AXG) += board-axg.o
>   obj-$(CONFIG_MESON_G12A) += board-g12a.o
> diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
> index 39774c43049..e8012604c33 100644
> --- a/arch/arm/mach-meson/board-common.c
> +++ b/arch/arm/mach-meson/board-common.c
> @@ -145,6 +145,11 @@ int board_late_init(void)
>   {
>   	meson_set_boot_source();
>   
> +	if (CONFIG_IS_ENABLED(DFU) && CONFIG_IS_ENABLED(EFI_LOADER)) {
> +		/* Generate dfu_string for EFI capsule updates */
> +		meson_setup_capsule();
> +	}
> +
>   	return meson_board_late_init();
>   }
>   
> diff --git a/arch/arm/mach-meson/capsule.c b/arch/arm/mach-meson/capsule.c
> new file mode 100644
> index 00000000000..6e968a59c2c
> --- /dev/null
> +++ b/arch/arm/mach-meson/capsule.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2025, Ferass El Hafidi <funderscore@postmarketos.org>
> + */
> +
> +#include <asm/arch/boot.h>
> +#include <dm.h>
> +#include <efi_loader.h>
> +#include <mmc.h>
> +
> +/*
> + * To be able to support multiple devices and flash to the correct one we need
> + * to automatically generate the dfu_string and fw_name to match the device we
> + * are booted from. This is done by meson_setup_capsule() which is then called
> + * in board_late_init(). Right now we support EFI capsule updates on SPI flash,
> + * eMMC and SD cards.
> + */
> +struct efi_fw_image fw_images[] = {
> +	{
> +		.image_index = 1,
> +	},
> +};
> +
> +struct efi_capsule_update_info update_info = {
> +	.dfu_string = NULL, /* to be set in meson_capsule_setup */
> +	.num_images = ARRAY_SIZE(fw_images),
> +	.images = fw_images,
> +};
> +
> +/*
> + * TODO: Support usecase e.g. FIT image on eMMC + SPL on SD.
> + */
> +void meson_setup_capsule(void)
> +{
> +	static char dfu_string[32] = { 0 };
> +	int mmc_devnum = 0; /* mmc0 => SD card */
> +	u32 max_size = 0x2000; /* 4 MB (MMC sectors are 512 bytes each) */
> +	u32 offset = 0x1; /* offset for flashing to eMMC/SD */
> +	int boot_device = meson_get_boot_device();
> +
> +	switch (boot_device) {
> +	case BOOT_DEVICE_EMMC:
> +		mmc_devnum = 1; /* mmc1 is always eMMC */
> +		fallthrough;
> +	case BOOT_DEVICE_SD:
> +		snprintf(dfu_string, 32, "mmc %d=u-boot.bin raw %d %d", mmc_devnum, offset, max_size);
> +		fw_images[0].fw_name = u"U_BOOT_MESON_MMC";
> +		break;
> +	case BOOT_DEVICE_SPI:
> +		/* We assume there's only one SPI flash */
> +		fw_images[0].fw_name = u"U_BOOT_MESON_SPI";
> +		snprintf(dfu_string, 32, "sf 0:0=u-boot.bin raw 0 %d", max_size);
> +		break;
> +	default:
> +		debug("setup_capsule: Boot device %d unsupported\n", boot_device);
> +		return;
> +	}
> +	debug("EFI Capsule DFU string: %s", dfu_string);
> +
> +	update_info.dfu_string = dfu_string;
> +}
> 

Wait this means all boards uses the same GUID ?

Neil
