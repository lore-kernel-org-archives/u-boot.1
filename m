Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BB0CCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 15:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDB8883677;
	Mon, 13 Oct 2025 17:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wqvqOa6Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5C3B83835; Mon, 13 Oct 2025 17:19:33 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C373E83621
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 17:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46faa5b0372so26619035e9.1
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 08:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760368770; x=1760973570; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=qyDQibH3GP02Qld7r/g/yjwGFwxvaPZIL4OlSKFyeHk=;
 b=wqvqOa6Ytovh2GG5KFvS+CA1z8JqSXia+AGFPr5tSljwfxPTVMFRpRJEbSKyeDxKgj
 2S49H2zECfXb+xcl4KAKta4JOYTKR38RbWYRMJ08kvkJnqQO0sEQWjcofXh6XlRlgpAr
 Mkplxxv/KPUHT6Qo2qEX+ceooa43zQo13PDpiXKb72CQLata0PtuvINp3u88o5TiVpSV
 0ki+hYyK3DZQBYB8Zv8XAeO5n5YMC3dEoY7eR8VjVpSEehuSvAmZiUNw6Hi8akw8Eh91
 wO1JDB9Y19n9F1LACoLzr9wXX9wj87iq69YghlTtE9tfZABZSDrgiW2SKN+HAGwoDp0J
 wwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760368770; x=1760973570;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qyDQibH3GP02Qld7r/g/yjwGFwxvaPZIL4OlSKFyeHk=;
 b=ucfr5ZI+l4CDSMzOR3q+9V7O1LK1zBuTZlF97mp+yh7w9BIloxG8tc9fY2OVNg5hnY
 LJ/EkhNvFNTgPvO9U6SQ3peRChaLhdr12n90nPDUaA7AOnsazIFzocdyQpMRB8oDMPiv
 2PKkmR2IODtu9Yx91bpdxT0ooe0j6oWarQAauB3UmIWppCkj1D4n6Ssu5v1C6bRwZVga
 JRepwvzyGobL83AJ6CxGzawQLk3bg/NqyMxLtJKWvOaVpWUsPB78+YBuCSg1W1uU78Ro
 u7uXnfZw6YlcOxiTDHyk7WXMxcNmgIr0eX3aRddtoFJZZ9a+dYc2RosVfR/53dQf8LRU
 A76Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhJba/LzDSY+4vFkDeZM9dGxHvdasuPERVDkwQXLbHw4wPGizI3pCMUi8BDgFkTWTfrtk+rvw=@lists.denx.de
X-Gm-Message-State: AOJu0YyhJ0uLxe+TWEiEj6dbrwAuvsqaojzHBmUjxYAn1i3NxX+kmFRF
 387ZiMQm++hH4XhDWFSqsKRcEI5+cM08WKjgA4sQ6apoOO5MzQZCNeUtgY9OLjb2UGk=
X-Gm-Gg: ASbGnctlq2tGgujOvvfyoiklFdS1yzJQQ21t4qEwRLleb/UiIQHmGU7WGP7J1liRlR7
 gaZyoKk2WcAkjeHPyjd/Cbr2O+V8L5+TfQGbm/CTVmuklG4tnw/cyUbM8WON+vgFkvtvrs3Ktpa
 KWusWGgd+cRYjjajgHxTj1tm8K4/V2qC5Tkw9Fb93B2p/h6GnWm8AHCvD3m23pJgfTPd4DRK9+7
 N/gGmBOdBQQmUB/BlDOJs5G6NSZ0Xh7Owg1NL1LpbCg/bUd1zujiwap5NGyqvEcLhSPPuIZaiB6
 xbQoHBr2S8pgYW02HqIcnQVmlpr6FCg1/mmAA3RzF0HuOFW+ShNeJF4C/8Vvgvlg1YYSIG/2moQ
 O0rhiIxQDMN1r3JK+pmSJrwZo6RqeQnwvBX4t9zWTOAr6UUdI1AoYctGDMSnkKCmum2o+BgC3xF
 3bPNscl2Y6AFnUwkAi5+Wo7NHd/G0B9lwE66Dq2qP8eN8=
X-Google-Smtp-Source: AGHT+IHbjvXCpyeaQgq0b72GdntppyngaiZxgYqoIPBNCOZIW4AU2SjimyQu5qm1FYnw4VdQhXTKPA==
X-Received: by 2002:a05:600c:888d:b0:468:9e79:bee0 with SMTP id
 5b1f17b1804b1-46fa9b939e4mr105853285e9.0.1760368769869; 
 Mon, 13 Oct 2025 08:19:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:4087:80b7:cd5a:8def?
 ([2a01:e0a:3d9:2080:4087:80b7:cd5a:8def])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5833dcsm18698881f8f.19.2025.10.13.08.19.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 08:19:29 -0700 (PDT)
Message-ID: <e00f5976-ab51-481c-8460-07a7a945acd6@linaro.org>
Date: Mon, 13 Oct 2025 17:19:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] arm: meson: add support for EFI capsule updates
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Viacheslav Bocharov <adeep@lexina.in>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Ferass El Hafidi <funderscore@tauchgang.dev>,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20251011-meson-capsule-v2-1-53a8be6595ce@postmarketos.org>
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
In-Reply-To: <20251011-meson-capsule-v2-1-53a8be6595ce@postmarketos.org>
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

On 10/11/25 20:16, Ferass El Hafidi wrote:
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
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
> Currently EFI capsule updates are only supported on the following
> Amlogic-based boards:
> 
>   - Libre Computer AML-S805X-AC
>   - Libre Computer AML-A311D-CC
>   - Libre Computer AML-S905D3-CC
> 
> This is done with board-specific configuration in board/libre-computer/.
> 
> With this patch, EFI capsule updates can now work on most of the other
> Amlogic boards supported by u-boot, such as the Libre Computer
> AML-S905X-CC, without the need for board-specific configuration
> beforehand.
> 
> Please note that flashing to the eMMC bootX partitions is not yet
> supported.
> ---
> Changes in v2:
>   - Don't run meson_setup_capsule unless CONFIG_DFU and CONFIG_EFI_LOADER
>     are enabled
>   - Coding style fixes
>   - Return when boot device is unsupported
>   - Link to v1: https://lore.kernel.org/r/20251007-meson-capsule-v1-1-6175f7b4cf9e@postmarketos.org
> ---
>   arch/arm/include/asm/arch-meson/boot.h |  2 ++
>   arch/arm/mach-meson/Makefile           |  2 +-
>   arch/arm/mach-meson/board-common.c     |  5 +++
>   arch/arm/mach-meson/capsule.c          | 61 ++++++++++++++++++++++++++++++++++
>   4 files changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/arch-meson/boot.h b/arch/arm/include/asm/arch-meson/boot.h
> index a11dfde719e3e48e10bcb1f6b1b84eb8586ca9e7..e66b45983fe2f5d81f83642c01502a72773213b2 100644
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
> index 535b0878b9105e7a83729bea65fa4cd70cd4beac..640921e2b8e9b4777f0b212991edea26de2987d4 100644
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
> index 39774c43049a40ed11578086603717571bedd23b..e8012604c33376ee031b89bbfcf16ef34d6dec73 100644
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
> index 0000000000000000000000000000000000000000..6e968a59c2cf26db179e11caac1eb6c3f76b2d2c
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
> ---
> base-commit: 072264c4b3406aee50dad08355588577a547ab48
> change-id: 20251007-meson-capsule-a19539e0a54e
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
