Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155B9D2C546
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:44:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8488388EBA;
	Tue, 22 Oct 2024 14:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pZzQk+6G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC60588F5B; Tue, 22 Oct 2024 14:44:07 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8428E88EBA
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso55257185e9.0
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 05:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729601044; x=1730205844;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HnndWNwRsL1q8HvAW3FI4EMo0HeD8M4loMRst/Y8j+4=;
 b=pZzQk+6GNB34Wa3/o/Nu6sVq70C0Mt4MCQRgLGhxKpZ1Lt8qs+txi7y1a39IxbzTyy
 2uxyN19Xk4ez2cNDTtzrKNm6lW96BMg1mfJm1PRiXkvfGUtAaPGnoXrieO6DQqI3tKS7
 rCja2aELfOUZMW3jrOjJr6ZTIlX7hVuR8lLv/2XiRm2rmPc4yLZ6KWmi6H5Y2MrU1k3b
 FJ7Hc19ML3dC27sppLjjzQiwDwSh9Vfcf+4BNf/sum23EAT1kGm9OKm+w/XcA5sjH8qK
 Ut4lZSp38w/nRTrQ04QVuCdkbE88NE2s4dEclxZNJT4CWFUO2232RFu1L3pKJvQNsuIN
 7fdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729601044; x=1730205844;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HnndWNwRsL1q8HvAW3FI4EMo0HeD8M4loMRst/Y8j+4=;
 b=Xv7Z34vphz1EhiIt5BfO3Q3is6c4+vI9htU1L10dOlvjpIh8I+GcIF6B8sbr9zFnzI
 6P2JDh7iIwHRK2Jz5Mom433ZU+s/VUwDFvhTck3FO8MYUZ/fh896NLk1R76LxX/nP9yj
 l97Xdn4+3+FvKPM1wXS03rdh9xu6oPVQIdx8p55V85VOZVJ5V/e6J+Z2+XWFplr/WI87
 4Q2qMHYvIzL7QQslA4Cuvl/3W2RrJ05xtWKZZRZGzPGC0ATM3zmT+iFoe7sQunMTtJC+
 b2YwJVCZo2MEr8/j7gKXMpFsj/QG5t9hZqqhn2KR0FYjDfScdM2rALmTLWWE1MVod64S
 5GbA==
X-Gm-Message-State: AOJu0YwyBSSJh1XeSPIFbt34LKZcqS6ggM5775gszlluUOq54w6tTv3D
 sdR1RkW6l1JrZmULpLo0OXejGQNuvISmZsW3CaHcEcrPZUGBXwUXOB7nOo5I42k=
X-Google-Smtp-Source: AGHT+IGOnkc82nBls6tNCvq1352Sfvcu1ltRgMwkAF/KKa8wz7+ZgfsWBJqpisVgm4M29jYoqiShmg==
X-Received: by 2002:a05:600c:674a:b0:42f:8229:a0a1 with SMTP id
 5b1f17b1804b1-431616adba5mr108854245e9.33.1729601043935; 
 Tue, 22 Oct 2024 05:44:03 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a58cc2sm6559144f8f.54.2024.10.22.05.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 05:44:03 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Guillaume La Roque
 <glaroque@baylibre.com>,
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com,
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
Subject: Re: [PATCH 4/6] configs: khadas-vim3l_android{_ab}: move on
 bootmeth android
In-Reply-To: <20241017-adnroidv2-v1-4-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
 <20241017-adnroidv2-v1-4-781c939902c9@baylibre.com>
Date: Tue, 22 Oct 2024 14:43:52 +0200
Message-ID: <871q08wbnb.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Guillaume,

Thank you for the patch.

On jeu., oct. 17, 2024 at 18:10, Guillaume La Roque <glaroque@baylibre.com> wrote:

> Actually khadas vim3l use distro command to boot android image.
> Move on new bootmeth android for A/B and non-A/B vim3l android.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  configs/khadas-vim3l_android_ab_defconfig |  7 ++++++-
>  configs/khadas-vim3l_android_defconfig    |  7 ++++++-
>  include/configs/khadas-vim3l_android.h    | 29 +++++++++++++++++++++++++----
>  3 files changed, 37 insertions(+), 6 deletions(-)
>
> diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
> index 4d7b90f23002..43db61056baf 100644
> --- a/configs/khadas-vim3l_android_ab_defconfig
> +++ b/configs/khadas-vim3l_android_ab_defconfig
> @@ -24,6 +24,12 @@ CONFIG_REMAKE_ELF=y
>  CONFIG_FIT=y
>  CONFIG_FIT_SIGNATURE=y
>  CONFIG_FIT_VERBOSE=y
> +CONFIG_BOOTMETH_ANDROID=y
> +# CONFIG_BOOTMETH_EXTLINUX is not set
> +# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
> +# CONFIG_BOOTMETH_EFILOADER is not set
> +# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
> +# CONFIG_BOOTMETH_VBE is not set
>  CONFIG_LEGACY_IMAGE_FORMAT=y
>  CONFIG_OF_BOARD_SETUP=y
>  # CONFIG_DISPLAY_CPUINFO is not set
> @@ -35,7 +41,6 @@ CONFIG_SYS_MAXARGS=32
>  CONFIG_CMD_ADTIMG=y
>  CONFIG_CMD_ABOOTIMG=y
>  # CONFIG_CMD_IMI is not set
> -CONFIG_CMD_BCB=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_I2C=y
> diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
> index 4ec27262cdc7..32d57a5b9090 100644
> --- a/configs/khadas-vim3l_android_defconfig
> +++ b/configs/khadas-vim3l_android_defconfig
> @@ -24,6 +24,12 @@ CONFIG_REMAKE_ELF=y
>  CONFIG_FIT=y
>  CONFIG_FIT_SIGNATURE=y
>  CONFIG_FIT_VERBOSE=y
> +CONFIG_BOOTMETH_ANDROID=y
> +# CONFIG_BOOTMETH_EXTLINUX is not set
> +# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
> +# CONFIG_BOOTMETH_EFILOADER is not set
> +# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
> +# CONFIG_BOOTMETH_VBE is not set
>  CONFIG_LEGACY_IMAGE_FORMAT=y
>  CONFIG_OF_BOARD_SETUP=y
>  # CONFIG_DISPLAY_CPUINFO is not set
> @@ -34,7 +40,6 @@ CONFIG_SYS_MAXARGS=32
>  CONFIG_CMD_ADTIMG=y
>  CONFIG_CMD_ABOOTIMG=y
>  # CONFIG_CMD_IMI is not set
> -CONFIG_CMD_BCB=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_I2C=y
> diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
> index f39a3782d663..4455898b5262 100644
> --- a/include/configs/khadas-vim3l_android.h
> +++ b/include/configs/khadas-vim3l_android.h
> @@ -26,6 +26,7 @@
>  	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
>  	"name=userdata,size=11218M,uuid=${uuid_gpt_userdata};" \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
> +

nit: un-necessary change here?

>  #else
>  #define PARTS_DEFAULT \
>  	"uuid_disk=${uuid_gpt_disk};" \
> @@ -39,12 +40,32 @@
>  	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
>  	"name=userdata,size=12722M,uuid=${uuid_gpt_userdata};" \
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
> +

nit: un-necessary change here?

>  #endif
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
> +	"check_button=gpio input ${gpio_recovery};test $? -eq 0;\0"   \

What is check_button needed for ?
It's used in include/configs/meson64_android.h to check if we should
boot recovery but since we no longer use that file here I think we can
safely remove this.

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

Should we also patch configs/meson64_android.h to remove everything
related to VIM3L? This way, we don't keep unused code in there.

> +#include <configs/meson64.h>
>  
>  #endif /* __CONFIG_H */
>
> -- 
> 2.34.1
