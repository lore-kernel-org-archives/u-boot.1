Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB854C46CCD
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8270187895;
	Thu, 21 Dec 2023 17:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hYsIFWcd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C71C877D8; Thu, 21 Dec 2023 17:24:41 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9B2387895
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3365f1326e4so866894f8f.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703175878; x=1703780678; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=h1Cw7TpnoSHqqrNLzjxtNutUUlQH4637gtVVZW2ZaLw=;
 b=hYsIFWcdrXnoTicRxAonyq5ATbesW+VPru2V2cx74Vn/iyiVKkmoHU3oO0SmTCA3u1
 DOyXpTzkaYlNzq8lLLfbC9EkZ9OMADyv/gshp5Lws6Odqnlfru+ivwMb8abYJ0bFW+MF
 K2zwOdP6IjFHI6SGy1IANXYOamLeyt6evRp2B3zvwWj+DUURaBOkMAABgNdp8BXtv8RM
 zUGRl8rsHfUkTWIksQfWmGhUP2KexxIZ7pa7AcN6cgELPQ459U/3iRGQNKOtjprdIWsm
 WaiB8Y+X+S9+n8hTc2oRY3tm7PioFsb5+TzZrFPgc6pcoQ/syKR+gK1UcMIaJve5q4+9
 iCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703175878; x=1703780678;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=h1Cw7TpnoSHqqrNLzjxtNutUUlQH4637gtVVZW2ZaLw=;
 b=VQDJKCCZ42HT52gDQe3Fc5m6/hTT4hZfTtY4R/pXZTVefcxeh+6cRPS+EeXLo87ibe
 gftBx4XiHQGkDyRZVLJ3ZKRW2aACwM/NhrpBnR0jn0ffFPTj4EfjrJmI3H9jJZnIQqvN
 fOrdbTwQX28iQ5JdhCiAtVQ5wVtSerETax3xD+KHm1ZEYoh21VQhQS0qFZFxAQc28jyA
 Zljh4AZx9Yg5EiZNUlGVZ+LijoEsw6hSI0TmDPmiMhmY2FY4iy3qmikxHzJF+4M1AJ5k
 b/JoCYnGKfnTcyjoUk5QjZZQpwdZCdjN/7XfiMGLUZjpXdybCJIyTvEII+irX95t1tzJ
 pTHA==
X-Gm-Message-State: AOJu0YwOa1xs9m71hdYgTzg7nvFvYiy1rwG/DDDanidtaZT+aOI5E9g4
 YSgwTvZJnH62HZTzOP1WKPDdVRKrQN4A6Q==
X-Google-Smtp-Source: AGHT+IGuvdz1j2fqo24kVdUWWRhs1J0Jw7Q3BmTxnyoA5CLnZqu1Q5SWn2OeFSnvzrpFJSwQqUmqrg==
X-Received: by 2002:a5d:4b4c:0:b0:336:8632:6482 with SMTP id
 w12-20020a5d4b4c000000b0033686326482mr9477wrs.129.1703175875507; 
 Thu, 21 Dec 2023 08:24:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a5d4247000000b003366811fd6bsm2334868wrr.14.2023.12.21.08.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:24:35 -0800 (PST)
Message-ID: <a694bbc8-9407-47b0-ae61-b1204960f808@linaro.org>
Date: Thu, 21 Dec 2023 17:24:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 13/32] board: dragonboard410c: import board code from
 mach-snapdragon
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-13-b6dd9704219e@linaro.org>
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
In-Reply-To: <20231219-b4-qcom-common-target-v2-13-b6dd9704219e@linaro.org>
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

On 19/12/2023 17:04, Caleb Connolly wrote:
> Some of the db410c board support code was written to be generic and
> placed in mach-snapdragon. However, as the db410c is the only board
> using this, move the code out of mach-snapdragon. This makes is more
> obvious what code is relevant for which targets and helps tidy things up
> a little more.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/Makefile                  |  2 -
>   arch/arm/mach-snapdragon/include/mach/dram.h       | 12 -----
>   arch/arm/mach-snapdragon/misc.c                    | 55 ----------------------
>   board/qualcomm/dragonboard410c/Makefile            |  3 +-
>   board/qualcomm/dragonboard410c/dragonboard410c.c   |  4 +-
>   .../qualcomm/dragonboard410c/misc.c                | 51 +++++++++++++++++++-
>   .../mach => board/qualcomm/dragonboard410c}/misc.h |  1 +
>   7 files changed, 54 insertions(+), 74 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index 3a3a297c1768..d02432df8b04 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -6,6 +6,4 @@ obj-$(CONFIG_SDM845) += sysmap-sdm845.o
>   obj-$(CONFIG_SDM845) += init_sdm845.o
>   obj-$(CONFIG_TARGET_DRAGONBOARD820C) += sysmap-apq8096.o
>   obj-$(CONFIG_TARGET_DRAGONBOARD410C) += sysmap-apq8016.o
> -obj-y += misc.o
> -obj-y += dram.o
>   obj-$(CONFIG_TARGET_QCS404EVB) += sysmap-qcs404.o
> diff --git a/arch/arm/mach-snapdragon/include/mach/dram.h b/arch/arm/mach-snapdragon/include/mach/dram.h
> deleted file mode 100644
> index 0a9eedda414c..000000000000
> --- a/arch/arm/mach-snapdragon/include/mach/dram.h
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Snapdragon DRAM
> - * Copyright (C) 2018 Ramon Fried <ramon.fried@gmail.com>
> - */
> -
> -#ifndef DRAM_H
> -#define DRAM_H
> -
> -int msm_fixup_memory(void *blob);
> -
> -#endif
> diff --git a/arch/arm/mach-snapdragon/misc.c b/arch/arm/mach-snapdragon/misc.c
> deleted file mode 100644
> index 7d452f4529b7..000000000000
> --- a/arch/arm/mach-snapdragon/misc.c
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Miscellaneous Snapdragon functionality
> - *
> - * (C) Copyright 2018 Ramon Fried <ramon.fried@gmail.com>
> - *
> - */
> -
> -#include <common.h>
> -#include <mmc.h>
> -#include <asm/arch/misc.h>
> -#include <asm/unaligned.h>
> -
> -/* UNSTUFF_BITS macro taken from Linux Kernel: drivers/mmc/core/sd.c */
> -#define UNSTUFF_BITS(resp, start, size) \
> -	({ \
> -		const int __size = size; \
> -		const u32 __mask = (__size < 32 ? 1 << __size : 0) - 1;	\
> -		const int __off = 3 - ((start) / 32); \
> -		const int __shft = (start) & 31; \
> -		u32 __res; \
> -					\
> -		__res = resp[__off] >> __shft; \
> -		if (__size + __shft > 32) \
> -			__res |= resp[__off - 1] << ((32 - __shft) % 32); \
> -		__res & __mask;	\
> -	})
> -
> -u32 msm_board_serial(void)
> -{
> -	struct mmc *mmc_dev;
> -
> -	mmc_dev = find_mmc_device(0);
> -	if (!mmc_dev)
> -		return 0;
> -
> -	if (mmc_init(mmc_dev))
> -		return 0;
> -
> -	return UNSTUFF_BITS(mmc_dev->cid, 16, 32);
> -}
> -
> -void msm_generate_mac_addr(u8 *mac)
> -{
> -	/* use locally adminstrated pool */
> -	mac[0] = 0x02;
> -	mac[1] = 0x00;
> -
> -	/*
> -	 * Put the 32-bit serial number in the last 32-bit of the MAC address.
> -	 * Use big endian order so it is consistent with the serial number
> -	 * written as a hexadecimal string, e.g. 0x1234abcd -> 02:00:12:34:ab:cd
> -	 */
> -	put_unaligned_be32(msm_board_serial(), &mac[2]);
> -}
> diff --git a/board/qualcomm/dragonboard410c/Makefile b/board/qualcomm/dragonboard410c/Makefile
> index 1b99c8b0efef..a3ae1a5f9136 100644
> --- a/board/qualcomm/dragonboard410c/Makefile
> +++ b/board/qualcomm/dragonboard410c/Makefile
> @@ -2,4 +2,5 @@
>   #
>   # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>   
> -obj-y	:= dragonboard410c.o
> +obj-y += dragonboard410c.o
> +obj-y += misc.o
> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
> index 1adac07569ae..eea603a4148d 100644
> --- a/board/qualcomm/dragonboard410c/dragonboard410c.c
> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
> @@ -18,10 +18,10 @@
>   #include <asm/global_data.h>
>   #include <asm/gpio.h>
>   #include <fdt_support.h>
> -#include <asm/arch/dram.h>
> -#include <asm/arch/misc.h>
>   #include <linux/delay.h>
>   
> +#include "misc.h"
> +
>   DECLARE_GLOBAL_DATA_PTR;
>   
>   #define USB_HUB_RESET_GPIO 2
> diff --git a/arch/arm/mach-snapdragon/dram.c b/board/qualcomm/dragonboard410c/misc.c
> similarity index 64%
> rename from arch/arm/mach-snapdragon/dram.c
> rename to board/qualcomm/dragonboard410c/misc.c
> index 499dfdf0da6e..27d51ef78914 100644
> --- a/arch/arm/mach-snapdragon/dram.c
> +++ b/board/qualcomm/dragonboard410c/misc.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
> - * Onboard memory detection for Snapdragon boards
> + * Miscellaneous Snapdragon functionality
>    *
>    * (C) Copyright 2018 Ramon Fried <ramon.fried@gmail.com>
>    *
> @@ -9,10 +9,56 @@
>   #include <common.h>
>   #include <dm.h>
>   #include <log.h>
> +#include <mmc.h>
>   #include <part.h>
>   #include <smem.h>
>   #include <fdt_support.h>
> -#include <asm/arch/dram.h>
> +#include <asm/unaligned.h>
> +
> +#include "misc.h"
> +
> +/* UNSTUFF_BITS macro taken from Linux Kernel: drivers/mmc/core/sd.c */
> +#define UNSTUFF_BITS(resp, start, size) \
> +	({ \
> +		const int __size = size; \
> +		const u32 __mask = (__size < 32 ? 1 << __size : 0) - 1;	\
> +		const int __off = 3 - ((start) / 32); \
> +		const int __shft = (start) & 31; \
> +		u32 __res; \
> +					\
> +		__res = resp[__off] >> __shft; \
> +		if (__size + __shft > 32) \
> +			__res |= resp[__off - 1] << ((32 - __shft) % 32); \
> +		__res & __mask;	\
> +	})
> +
> +u32 msm_board_serial(void)
> +{
> +	struct mmc *mmc_dev;
> +
> +	mmc_dev = find_mmc_device(0);
> +	if (!mmc_dev)
> +		return 0;
> +
> +	if (mmc_init(mmc_dev))
> +		return 0;
> +
> +	return UNSTUFF_BITS(mmc_dev->cid, 16, 32);
> +}
> +
> +void msm_generate_mac_addr(u8 *mac)
> +{
> +	/* use locally adminstrated pool */
> +	mac[0] = 0x02;
> +	mac[1] = 0x00;
> +
> +	/*
> +	 * Put the 32-bit serial number in the last 32-bit of the MAC address.
> +	 * Use big endian order so it is consistent with the serial number
> +	 * written as a hexadecimal string, e.g. 0x1234abcd -> 02:00:12:34:ab:cd
> +	 */
> +	put_unaligned_be32(msm_board_serial(), &mac[2]);
> +}
>   
>   #define SMEM_USABLE_RAM_PARTITION_TABLE 402
>   #define RAM_PART_NAME_LENGTH            16
> @@ -97,3 +143,4 @@ int msm_fixup_memory(void *blob)
>   
>   	return 0;
>   }
> +

Spurious newline

> diff --git a/arch/arm/mach-snapdragon/include/mach/misc.h b/board/qualcomm/dragonboard410c/misc.h
> similarity index 87%
> rename from arch/arm/mach-snapdragon/include/mach/misc.h
> rename to board/qualcomm/dragonboard410c/misc.h
> index c60e3e472470..fe44caf51b18 100644
> --- a/arch/arm/mach-snapdragon/include/mach/misc.h
> +++ b/board/qualcomm/dragonboard410c/misc.h
> @@ -9,5 +9,6 @@
>   
>   u32 msm_board_serial(void);
>   void msm_generate_mac_addr(u8 *mac);
> +int msm_fixup_memory(void *blob);
>   
>   #endif
> 

With this fixed:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
