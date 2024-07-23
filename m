Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94370C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 08:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 685ED88496;
	Tue, 23 Jul 2024 10:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RpnQmhgB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C099A886FC; Tue, 23 Jul 2024 10:49:26 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C01C888496
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 10:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2cb55418470so2593977a91.1
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 01:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721724560; x=1722329360; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sjovoMG9foo0O7DmuwO8Pvmauss8R952F+qlDNT15As=;
 b=RpnQmhgB8NJQ16A1TjuuP5QU5N7zPzK+dEeW0Se4+fPmEYtunOQSpNQwIIe/6sQW8h
 JUqVG8J8UK2AhayhlHwJGIw9hSbJkwc42xjQmt7cPa+e5wNb7BZC/2BrH5F5C3MvXtsj
 s84U3KPfTwPjQPwOCaeFiW5scLDjLJs0LafYd3bWuNgbHiqwI0PH1L9b9RCkm2bdIvtH
 dFYoW7GpTCoKg7bV8WIZ33eLD//JN77zJGB2k+04nzl8LhGzSd4p8ky99E2CGA6D7jkA
 an1pW1TAnrAr8P6lwiHrru+gDk4/ONtKzXDtvlyYyITFtK12NTd4ruqe+IIjM0GXEThz
 ebZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721724560; x=1722329360;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sjovoMG9foo0O7DmuwO8Pvmauss8R952F+qlDNT15As=;
 b=BnQ84bNOvmAbBeyxWImJPn85QMJYyRpaajoDmhYfymPR1ak5XiCimj+4Vtnl4bFLC/
 hFuccgLa5/QxaYlrar6r7l1slxSpxz0rqCtIvS+d7hgm5O7QsBfDxY4rHyPLjC74RDiD
 CUWQG2IpIATFjW2xRGRVAKNVHJ1pwgX1q1TRHxuvZib0pYGBonxO25Qtw57QUxGg5N/1
 qz4/r5RWg55YlaLToB9DREkF18JizTcJRL5MXKEbsPPmoXa1kYJ+XcA7qUZ9/HbqJsAa
 3SjrkBB2vGZ4b4t9dCtiI7pwujrBo+0o4IBG+HwOCVTgdrGxBV0prwCdJhq429tah9hw
 eqIg==
X-Gm-Message-State: AOJu0YyoMjYEEK45yGVhChaRhcTjtykRX2zOmZvQlMUvSaLuVzmsCM95
 zBsn5vAx6+7GmqTrDby25IEukO/048w2l5RvnJOBDAFpbphStt34rV9O4rhsgEXox5KeG9d3LZc
 64Rm+AqshsBVo6UPEHKxuvPifdiihHhkPbbBVhS5PvhrvngSTpBI=
X-Google-Smtp-Source: AGHT+IFybuxKiRCMlkaLu9Av1WzTFP7ryBHG1ayRBr8/HyQngKrWYqZ28N09PvjFEBVs5T2vrGX9+n7L05zTToV6DhI=
X-Received: by 2002:a17:90a:f481:b0:2cc:f538:7cf0 with SMTP id
 98e67ed59e1d1-2cd15e8dbebmr6915590a91.4.1721724560010; Tue, 23 Jul 2024
 01:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-15-sughosh.ganu@linaro.org>
In-Reply-To: <20240704073544.670249-15-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Jul 2024 11:48:43 +0300
Message-ID: <CAC_iWjJuZKqSPGFzzw3Xr5Y28KprAsVLGOnAcryFTwx2M_BTvw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 14/48] lmb: remove config symbols used for lmb
 region count
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>, 
 Michal Simek <michal.simek@amd.com>
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

On Thu, 4 Jul 2024 at 10:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The LMB memory maps are now being maintained through a couple of
> alloced lists, one for the available(added) memory, and one for the
> used memory. These lists are not static arrays but can be extended at
> runtime. Remove the config symbols which were being used to define the
> size of these lists with the earlier implementation of static arrays.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: New patch
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
> index 37966bfb20..1ce46a0625 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -106,4 +106,3 @@ CONFIG_SYS_WHITE_ON_BLACK=y
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
> index b3baa4b85b..072ed0ecfa 100644
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
