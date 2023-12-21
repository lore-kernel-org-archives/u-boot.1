Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64B5C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C5A8878AF;
	Thu, 21 Dec 2023 17:25:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L/av+myp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1E72877D8; Thu, 21 Dec 2023 17:25:34 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55E0A87899
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33686649b72so922481f8f.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703175930; x=1703780730; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=4QyF2BNxnETZB8qZepcrwYM6Eg1chPpsq0wZef+COn8=;
 b=L/av+mypypiH5F0kQR/hJCjAK9IHAFjzSAglPsWbz9kgG/N7esHgysucJ16RglfQxC
 h23lj3tfjfbqFdeEvr3CZcflDbF41/D06OnricMILsvrXpd0qTQLfeKrcYE9yxUTNSht
 +k5qKAMlI1izD5rAf/UKE65wdEEwRUhvPszCfxTXjl4oRHiMHJEMR4ENLjZsFUwEimOP
 Ex8ypAK++rE/AhqjGOSpI4Dj113E5cLRwgn4YPmeQ+ntBu+BE72n+NzwPjMq/L2qkjNc
 zgjr7yZhdTPY9Hj6ODTjnNUsC2u92MbrNjom7G9n+TH7J/8ZxvOUuD03Mf1RXR7QxJoO
 Rz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703175930; x=1703780730;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4QyF2BNxnETZB8qZepcrwYM6Eg1chPpsq0wZef+COn8=;
 b=ag9t7I7sF5QL3OQHQ6xT47uRxblRPofeK3zlRqEQriSZPtXZm6UxFTiWPjfrJO8MJw
 IgvWeXFFpJ4UCSImnHkmWjR4hs4pm4S6izpNkpVlVaH2BULb6/G9PCieYYBkhFnTn+RK
 zuKUdn1mYicODpd+PyzBD6dhyZ5e1cM4nXS0ASwFh0qjDVndpzTVdztLA/sfnFwg3XJp
 EvCug3fHhZ5DyxnEbEfCRp1Q87OBxAWWh6QzQyCtf1ByMvEPysNk7sXWhNWW8UE2a6y5
 XBIR3VzIRarsu4Rgb5RGjbjkAJeAHY68J1ZyYxtX9IROI6FkUjJTZX9dntuyGC/gGK67
 nauQ==
X-Gm-Message-State: AOJu0Yw/QbDdgJe2ZFFs3VK7hE2cWQuN6IMDSS0v0Py4g3F29jEE+RNL
 b5pukeFRU2ESwPba0drPoeaHGkCfeybNlg==
X-Google-Smtp-Source: AGHT+IF1eBwbz0GTCHNBsoVb7vxNft3l7Ft1x0lcorIBssPKbZndFcbuxbNuvpw8nmBArRvnS1nwug==
X-Received: by 2002:a05:6000:1088:b0:336:7051:8400 with SMTP id
 y8-20020a056000108800b0033670518400mr33487wrw.23.1703175929721; 
 Thu, 21 Dec 2023 08:25:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a5d4247000000b003366811fd6bsm2334868wrr.14.2023.12.21.08.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:25:29 -0800 (PST)
Message-ID: <d61c57e2-4572-41d7-b2e1-e886759b7577@linaro.org>
Date: Thu, 21 Dec 2023 17:25:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 14/32] board: dragonboard820c: use
 LINUX_KERNEL_IMAGE_HEADER
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
 <20231219-b4-qcom-common-target-v2-14-b6dd9704219e@linaro.org>
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
In-Reply-To: <20231219-b4-qcom-common-target-v2-14-b6dd9704219e@linaro.org>
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
> db820c predated support for prepending the kernel image header
> automatically, drop it's custom linker script and head.S in favour of
> this generic support.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/Kconfig          |   1 +
>   board/qualcomm/dragonboard820c/Makefile   |   1 -
>   board/qualcomm/dragonboard820c/head.S     |  33 ---------
>   board/qualcomm/dragonboard820c/u-boot.lds | 111 ------------------------------
>   4 files changed, 1 insertion(+), 145 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index ad6671081910..f897c393464f 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -45,6 +45,7 @@ config TARGET_DRAGONBOARD410C
>   
>   config TARGET_DRAGONBOARD820C
>   	bool "96Boards Dragonboard 820C"
> +	select LINUX_KERNEL_IMAGE_HEADER
>   	imply CLK_QCOM_APQ8096
>   	imply PINCTRL_QCOM_APQ8096
>   	imply BUTTON_QCOM_PMIC
> diff --git a/board/qualcomm/dragonboard820c/Makefile b/board/qualcomm/dragonboard820c/Makefile
> index 643311f5b3ba..2ae6d16364aa 100644
> --- a/board/qualcomm/dragonboard820c/Makefile
> +++ b/board/qualcomm/dragonboard820c/Makefile
> @@ -3,4 +3,3 @@
>   # (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@gmail.com>
>   
>   obj-y	:= dragonboard820c.o
> -extra-y += head.o
> diff --git a/board/qualcomm/dragonboard820c/head.S b/board/qualcomm/dragonboard820c/head.S
> deleted file mode 100644
> index b052a858fd32..000000000000
> --- a/board/qualcomm/dragonboard820c/head.S
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * ARM64 header for proper chain-loading with Little Kernel.
> - *
> - * Little Kernel shipped with Dragonboard820C boots standard Linux images for
> - * ARM64. This file adds header that is required to boot U-Boot properly.
> - *
> - * For details see:
> - * https://www.kernel.org/doc/Documentation/arm64/booting.txt
> - *
> - * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
> - */
> -
> -#include <config.h>
> -
> -/*
> - *   per document in linux/Doc/arm64/booting.text
> - */
> -.global _arm64_header
> -_arm64_header:
> -	b _start
> -	.word 0
> -	.quad   CONFIG_TEXT_BASE-PHYS_SDRAM_1 /* Image load offset, LE */
> -	.quad   0    /* Effective size of kernel image, little-endian */
> -	.quad   0    /* kernel flags, little-endian */
> -	.quad   0    /* reserved */
> -	.quad   0    /* reserved */
> -	.quad   0    /* reserved */
> -	.byte   0x41 /* Magic number, "ARM\x64" */
> -	.byte   0x52
> -	.byte   0x4d
> -	.byte   0x64
> -	.word   0    /* reserved (used for PE COFF offset) */
> diff --git a/board/qualcomm/dragonboard820c/u-boot.lds b/board/qualcomm/dragonboard820c/u-boot.lds
> deleted file mode 100644
> index 5251b59fbe76..000000000000
> --- a/board/qualcomm/dragonboard820c/u-boot.lds
> +++ /dev/null
> @@ -1,111 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Override linker script for fastboot-readable images
> - *
> - * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
> - *
> - * Based on arch/arm/cpu/armv8/u-boot.lds (Just add header)
> - */
> -
> -OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
> -OUTPUT_ARCH(aarch64)
> -ENTRY(_arm64_header)
> -SECTIONS
> -{
> -	. = 0x00000000;
> -
> -	. = ALIGN(8);
> -	.text :
> -	{
> -		*(.__image_copy_start)
> -		board/qualcomm/dragonboard820c/head.o (.text*)
> -		CPUDIR/start.o (.text*)
> -	}
> -
> -	/* This needs to come before *(.text*) */
> -	.efi_runtime : {
> -                __efi_runtime_start = .;
> -		*(.text.efi_runtime*)
> -		*(.rodata.efi_runtime*)
> -		*(.data.efi_runtime*)
> -                __efi_runtime_stop = .;
> -	}
> -
> -	.text_rest :
> -	{
> -		*(.text*)
> -	}
> -
> -	. = ALIGN(8);
> -	.rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
> -
> -	. = ALIGN(8);
> -	.data : {
> -		*(.data*)
> -	}
> -
> -	. = ALIGN(8);
> -
> -	. = .;
> -
> -	. = ALIGN(8);
> -	__u_boot_list : {
> -		KEEP(*(SORT(__u_boot_list*)));
> -	}
> -
> -	. = ALIGN(8);
> -
> -	.efi_runtime_rel : {
> -                __efi_runtime_rel_start = .;
> -		*(.rel*.efi_runtime)
> -		*(.rel*.efi_runtime.*)
> -                __efi_runtime_rel_stop = .;
> -	}
> -
> -	. = ALIGN(8);
> -
> -	.image_copy_end :
> -	{
> -		*(.__image_copy_end)
> -	}
> -
> -	. = ALIGN(8);
> -
> -	.rel_dyn_start :
> -	{
> -		*(.__rel_dyn_start)
> -	}
> -
> -	.rela.dyn : {
> -		*(.rela*)
> -	}
> -
> -	.rel_dyn_end :
> -	{
> -		*(.__rel_dyn_end)
> -	}
> -
> -	_end = .;
> -
> -	. = ALIGN(8);
> -
> -	.bss_start : {
> -		KEEP(*(.__bss_start));
> -	}
> -
> -	.bss : {
> -		*(.bss*)
> -		 . = ALIGN(8);
> -	}
> -
> -	.bss_end : {
> -		KEEP(*(.__bss_end));
> -	}
> -
> -	/DISCARD/ : { *(.dynsym) }
> -	/DISCARD/ : { *(.dynstr*) }
> -	/DISCARD/ : { *(.dynamic*) }
> -	/DISCARD/ : { *(.plt*) }
> -	/DISCARD/ : { *(.interp*) }
> -	/DISCARD/ : { *(.gnu*) }
> -}
> 

Easy code removal!

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
