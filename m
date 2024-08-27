Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7416CC5320E
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 06:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8663F87CF8;
	Tue, 27 Aug 2024 08:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JLO3eQGp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8E3687C80; Tue, 27 Aug 2024 08:24:52 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62D1587CF8
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 08:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7cd967d8234so3053188a12.2
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 23:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724739889; x=1725344689; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s6YzcOiRttd5wMNzTVIEghZEfDknXfak1IJi3buhki4=;
 b=JLO3eQGpULOmFPhqvb8x/MZ/TaYPOzlZA6hAIygPKVoyPtPRBqkY9Q1cJzp1c8LoHH
 MROMqtIAMh8r/j+qReFixUmgG4ySNdD0lLaRwVcN7OlonwnO84A8xZ9ocy7aeYtwGYTO
 wYx383GhMM1KltjttN5xSaTcpkPLg/VGT4RnmbFuocbdxxR900tVm/reHBVnwH7fzvOL
 uuENsPWVpkjoZYnZo9vgYdqzgWQO7iUd9y+HskTufU+jBlx+J6XsHgovDHvZMfAGAT4m
 x0rh+ZWlNCT0xxU7F0x2BEOTe+zg3ll72A8ShjPtrLLWsxPJfZowkxtiq7AKnu2F+oLK
 3eYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724739889; x=1725344689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s6YzcOiRttd5wMNzTVIEghZEfDknXfak1IJi3buhki4=;
 b=ss9PsAtIw9DZtHV6ynfcuN7E9UBRKtDCfFW+7IYYiCm0ad7XGDD4U99xu2QeAPs41v
 aH7Un6hDhE8CLUnUBa2K1QfyTcbSP6tmsBpUdzwyf/B3TT0nZVUVDH2t398XD7BARexs
 JkmnOiy9bKZRGSi05xg5qu/sLXdFHh0W4ec0nRkvy1YaoHUvGB6gwwvkCCAWYzodABd0
 4pEstBgLX7XCzklzxz7QjfRHTdlJAZQlM++Kqph53i8ic5L9hc5+tlovTE8zfCdBaxRR
 xhpJvLfwGuOzzGzID/2zzk5ibf1uU5ybWpc4lLwDr0/At8+0BoEgFhUU2bj6wERzFS+4
 Z3LA==
X-Gm-Message-State: AOJu0YwMWN3d4fONvNtX1fHHWC4ZpVkLL6sHJRDcG5FB5EZfgBxm2XGC
 uQuRDuNGwEJtedx+sn80bTkoldNUWywwTP+ivKBQrnanfPEelgqMqtgEFDjyRcaFGmf2rmOrKyx
 U/VR6i4M61p1BrIFa4BXwoPNw3QXicEPLALm2bw==
X-Google-Smtp-Source: AGHT+IG1Bt6y0vYGbzaGWVP8CkSvMJihBY/AgymFR00MRc5OxMl4ASfnIgmK6CWThJBOF4ZMy7DdHv6EMDAx3Ba8zbc=
X-Received: by 2002:a05:6a21:398e:b0:1ca:ccd1:281e with SMTP id
 adf61e73a8af0-1ccc084cce6mr1968897637.7.1724739888507; Mon, 26 Aug 2024
 23:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
 <20240826115940.3233167-8-sughosh.ganu@linaro.org>
In-Reply-To: <20240826115940.3233167-8-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 27 Aug 2024 09:24:12 +0300
Message-ID: <CAC_iWj+47hpRym8=1Zb_8x30DGqdkuZc67WBKq1BFwjdiUOOqQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/27] lmb: remove config symbols used for lmb region
 count
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, 26 Aug 2024 at 15:00, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The LMB memory maps are now being maintained through a couple of
> alloced lists, one for the available(added) memory, and one for the
> used memory. These lists are not static arrays but can be extended at
> runtime. Remove the config symbols which were being used to define the
> size of these lists with the earlier implementation of static arrays.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes since V3: None
>
>  configs/a3y17lte_defconfig           |  1 -
>  configs/a5y17lte_defconfig           |  1 -
>  configs/a7y17lte_defconfig           |  1 -
>  configs/apple_m1_defconfig           |  1 -
>  configs/mt7981_emmc_rfb_defconfig    |  1 -
>  configs/mt7981_rfb_defconfig         |  1 -
>  configs/mt7981_sd_rfb_defconfig      |  1 -
>  configs/mt7986_rfb_defconfig         |  1 -
>  configs/mt7986a_bpir3_emmc_defconfig |  1 -
>  configs/mt7986a_bpir3_sd_defconfig   |  1 -
>  configs/mt7988_rfb_defconfig         |  1 -
>  configs/mt7988_sd_rfb_defconfig      |  1 -
>  configs/qcom_defconfig               |  1 -
>  configs/stm32mp13_defconfig          |  3 ---
>  configs/stm32mp15_basic_defconfig    |  3 ---
>  configs/stm32mp15_defconfig          |  3 ---
>  configs/stm32mp15_trusted_defconfig  |  3 ---
>  configs/stm32mp25_defconfig          |  3 ---
>  configs/th1520_lpi4a_defconfig       |  1 -
>  lib/Kconfig                          | 34 ----------------------------
>  20 files changed, 63 deletions(-)
>
> diff --git a/configs/a3y17lte_defconfig b/configs/a3y17lte_defconfig
> index 5c15d51fdc..b012b985a3 100644
> --- a/configs/a3y17lte_defconfig
> +++ b/configs/a3y17lte_defconfig
> @@ -23,4 +23,3 @@ CONFIG_HUSH_PARSER=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_I2C=y
>  CONFIG_DM_I2C_GPIO=y
> -CONFIG_LMB_MAX_REGIONS=64
> diff --git a/configs/a5y17lte_defconfig b/configs/a5y17lte_defconfig
> index 7c9b6b2511..25a7d5bc98 100644
> --- a/configs/a5y17lte_defconfig
> +++ b/configs/a5y17lte_defconfig
> @@ -23,4 +23,3 @@ CONFIG_HUSH_PARSER=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_I2C=y
>  CONFIG_DM_I2C_GPIO=y
> -CONFIG_LMB_MAX_REGIONS=64
> diff --git a/configs/a7y17lte_defconfig b/configs/a7y17lte_defconfig
> index c7297f7d75..c87379ab39 100644
> --- a/configs/a7y17lte_defconfig
> +++ b/configs/a7y17lte_defconfig
> @@ -23,4 +23,3 @@ CONFIG_HUSH_PARSER=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_I2C=y
>  CONFIG_DM_I2C_GPIO=y
> -CONFIG_LMB_MAX_REGIONS=64
> diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
> index 20d2cff93f..dca6e0ca8b 100644
> --- a/configs/apple_m1_defconfig
> +++ b/configs/apple_m1_defconfig
> @@ -26,4 +26,3 @@ CONFIG_SYS_WHITE_ON_BLACK=y
>  CONFIG_NO_FB_CLEAR=y
>  CONFIG_VIDEO_SIMPLE=y
>  # CONFIG_SMBIOS is not set
> -CONFIG_LMB_MAX_REGIONS=64
> diff --git a/configs/mt7981_emmc_rfb_defconfig b/configs/mt7981_emmc_rfb_defconfig
> index 76ee2aa2d6..d3e833905f 100644
> --- a/configs/mt7981_emmc_rfb_defconfig
> +++ b/configs/mt7981_emmc_rfb_defconfig
> @@ -62,4 +62,3 @@ CONFIG_MTK_SERIAL=y
>  CONFIG_FAT_WRITE=y
>  CONFIG_HEXDUMP=y
>  # CONFIG_EFI_LOADER is not set
> -CONFIG_LMB_MAX_REGIONS=64
> diff --git a/configs/mt7981_rfb_defconfig b/configs/mt7981_rfb_defconfig
> index 3989c79d2b..4bc2173f13 100644
> --- a/configs/mt7981_rfb_defconfig
> +++ b/configs/mt7981_rfb_defconfig
> @@ -65,4 +65,3 @@ CONFIG_DM_SPI=y
>  CONFIG_MTK_SPIM=y
>  CONFIG_HEXDUMP=y
>  # CONFIG_EFI_LOADER is not set
> -CONFIG_LMB_MAX_REGIONS=64
> diff --git a/configs/mt7981_sd_rfb_defconfig b/configs/mt7981_sd_rfb_defconfig
> index 9b33245527..8721b4074a 100644
> --- a/configs/mt7981_sd_rfb_defconfig
> +++ b/configs/mt7981_sd_rfb_defconfig
> @@ -62,4 +62,3 @@ CONFIG_MTK_SERIAL=y
>  CONFIG_FAT_WRITE=y
>  CONFIG_HEXDUMP=y
>  # CONFIG_EFI_LOADER is not set
> -CONFIG_LMB_MAX_REGIONS=64
> diff --git a/configs/mt7986_rfb_defconfig b/configs/mt7986_rfb_defconfig
> index 4d0cc85d0e..15c31de236 100644
> --- a/configs/mt7986_rfb_defconfig
> +++ b/configs/mt7986_rfb_defconfig
> @@ -65,4 +65,3 @@ CONFIG_DM_SPI=y
>  CONFIG_MTK_SPIM=y
>  CONFIG_HEXDUMP=y
>  # CONFIG_EFI_LOADER is not set
> -CONFIG_LMB_MAX_REGIONS=64
> diff --git a/configs/mt7986a_bpir3_emmc_defconfig b/configs/mt7986a_bpir3_emmc_defconfig
> index 3c296ab803..56921f3605 100644
> --- a/configs/mt7986a_bpir3_emmc_defconfig
> +++ b/configs/mt7986a_bpir3_emmc_defconfig
> @@ -62,4 +62,3 @@ CONFIG_MTK_SERIAL=y
>  CONFIG_FAT_WRITE=y
>  CONFIG_HEXDUMP=y
>  # CONFIG_EFI_LOADER is not set
> -CONFIG_LMB_MAX_REGIONS=64
> diff --git a/configs/mt7986a_bpir3_sd_defconfig b/configs/mt7986a_bpir3_sd_defconfig
> index f644070f4e..4ed06b72d5 100644
> --- a/configs/mt7986a_bpir3_sd_defconfig
> +++ b/configs/mt7986a_bpir3_sd_defconfig
> @@ -62,4 +62,3 @@ CONFIG_MTK_SERIAL=y
>  CONFIG_FAT_WRITE=y
>  CONFIG_HEXDUMP=y
>  # CONFIG_EFI_LOADER is not set
> -CONFIG_LMB_MAX_REGIONS=64
> diff --git a/configs/mt7988_rfb_defconfig b/configs/mt7988_rfb_defconfig
> index d0ed2cc1c9..f7ceaceb30 100644
> --- a/configs/mt7988_rfb_defconfig
> +++ b/configs/mt7988_rfb_defconfig
> @@ -81,4 +81,3 @@ CONFIG_MTK_SPIM=y
>  CONFIG_LZO=y
>  CONFIG_HEXDUMP=y
>  # CONFIG_EFI_LOADER is not set
> -CONFIG_LMB_MAX_REGIONS=64
> diff --git a/configs/mt7988_sd_rfb_defconfig b/configs/mt7988_sd_rfb_defconfig
> index 5631eaa338..808c8b9011 100644
> --- a/configs/mt7988_sd_rfb_defconfig
> +++ b/configs/mt7988_sd_rfb_defconfig
> @@ -69,4 +69,3 @@ CONFIG_MTK_SPIM=y
>  CONFIG_LZO=y
>  CONFIG_HEXDUMP=y
>  # CONFIG_EFI_LOADER is not set
> -CONFIG_LMB_MAX_REGIONS=64
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 8852e83a52..edbb624baf 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -117,4 +117,3 @@ CONFIG_SYS_WHITE_ON_BLACK=y
>  CONFIG_NO_FB_CLEAR=y
>  CONFIG_VIDEO_SIMPLE=y
>  CONFIG_HEXDUMP=y
> -CONFIG_LMB_MAX_REGIONS=64
> diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
> index caaabf39ef..9aa3560c7e 100644
> --- a/configs/stm32mp13_defconfig
> +++ b/configs/stm32mp13_defconfig
> @@ -103,6 +103,3 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0483
>  CONFIG_USB_GADGET_PRODUCT_NUM=0x5720
>  CONFIG_USB_GADGET_DWC2_OTG=y
>  CONFIG_ERRNO_STR=y
> -# CONFIG_LMB_USE_MAX_REGIONS is not set
> -CONFIG_LMB_MEMORY_REGIONS=2
> -CONFIG_LMB_RESERVED_REGIONS=16
> diff --git a/configs/stm32mp15_basic_defconfig b/configs/stm32mp15_basic_defconfig
> index 2e22bf8600..806935f389 100644
> --- a/configs/stm32mp15_basic_defconfig
> +++ b/configs/stm32mp15_basic_defconfig
> @@ -190,6 +190,3 @@ CONFIG_WDT=y
>  CONFIG_WDT_STM32MP=y
>  # CONFIG_BINMAN_FDT is not set
>  CONFIG_ERRNO_STR=y
> -# CONFIG_LMB_USE_MAX_REGIONS is not set
> -CONFIG_LMB_MEMORY_REGIONS=2
> -CONFIG_LMB_RESERVED_REGIONS=16
> diff --git a/configs/stm32mp15_defconfig b/configs/stm32mp15_defconfig
> index ffe7512650..5f050ee0d0 100644
> --- a/configs/stm32mp15_defconfig
> +++ b/configs/stm32mp15_defconfig
> @@ -166,6 +166,3 @@ CONFIG_WDT=y
>  CONFIG_WDT_STM32MP=y
>  # CONFIG_BINMAN_FDT is not set
>  CONFIG_ERRNO_STR=y
> -# CONFIG_LMB_USE_MAX_REGIONS is not set
> -CONFIG_LMB_MEMORY_REGIONS=2
> -CONFIG_LMB_RESERVED_REGIONS=16
> diff --git a/configs/stm32mp15_trusted_defconfig b/configs/stm32mp15_trusted_defconfig
> index 74deaaba2e..3c591d74af 100644
> --- a/configs/stm32mp15_trusted_defconfig
> +++ b/configs/stm32mp15_trusted_defconfig
> @@ -166,6 +166,3 @@ CONFIG_WDT=y
>  CONFIG_WDT_STM32MP=y
>  # CONFIG_BINMAN_FDT is not set
>  CONFIG_ERRNO_STR=y
> -# CONFIG_LMB_USE_MAX_REGIONS is not set
> -CONFIG_LMB_MEMORY_REGIONS=2
> -CONFIG_LMB_RESERVED_REGIONS=16
> diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
> index 87038cc773..f5623a19bb 100644
> --- a/configs/stm32mp25_defconfig
> +++ b/configs/stm32mp25_defconfig
> @@ -49,6 +49,3 @@ CONFIG_WDT_STM32MP=y
>  CONFIG_WDT_ARM_SMC=y
>  CONFIG_ERRNO_STR=y
>  # CONFIG_EFI_LOADER is not set
> -# CONFIG_LMB_USE_MAX_REGIONS is not set
> -CONFIG_LMB_MEMORY_REGIONS=2
> -CONFIG_LMB_RESERVED_REGIONS=32
> diff --git a/configs/th1520_lpi4a_defconfig b/configs/th1520_lpi4a_defconfig
> index 49ff92f6de..db80e33870 100644
> --- a/configs/th1520_lpi4a_defconfig
> +++ b/configs/th1520_lpi4a_defconfig
> @@ -79,4 +79,3 @@ CONFIG_BZIP2=y
>  CONFIG_ZSTD=y
>  CONFIG_LIB_RATIONAL=y
>  # CONFIG_EFI_LOADER is not set
> -# CONFIG_LMB_USE_MAX_REGIONS is not set
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 2059219a12..f8ac8daad3 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1105,40 +1105,6 @@ config LMB
>         help
>           Support the library logical memory blocks.
>
> -config LMB_USE_MAX_REGIONS
> -       bool "Use a common number of memory and reserved regions in lmb lib"
> -       default y
> -       help
> -         Define the number of supported memory regions in the library logical
> -         memory blocks.
> -         This feature allow to reduce the lmb library size by using compiler
> -         optimization when LMB_MEMORY_REGIONS == LMB_RESERVED_REGIONS.
> -
> -config LMB_MAX_REGIONS
> -       int "Number of memory and reserved regions in lmb lib"
> -       depends on LMB_USE_MAX_REGIONS
> -       default 16
> -       help
> -         Define the number of supported regions, memory and reserved, in the
> -         library logical memory blocks.
> -
> -config LMB_MEMORY_REGIONS
> -       int "Number of memory regions in lmb lib"
> -       depends on !LMB_USE_MAX_REGIONS
> -       default 8
> -       help
> -         Define the number of supported memory regions in the library logical
> -         memory blocks.
> -         The minimal value is CONFIG_NR_DRAM_BANKS.
> -
> -config LMB_RESERVED_REGIONS
> -       int "Number of reserved regions in lmb lib"
> -       depends on !LMB_USE_MAX_REGIONS
> -       default 8
> -       help
> -         Define the number of supported reserved regions in the library logical
> -         memory blocks.
> -
>  config PHANDLE_CHECK_SEQ
>         bool "Enable phandle check while getting sequence number"
>         help
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
