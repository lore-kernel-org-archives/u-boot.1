Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057BCD6206A
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 10:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E64789564;
	Tue, 19 Nov 2024 11:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mceweyyB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 279D789564; Tue, 19 Nov 2024 11:36:45 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26E9789558
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 11:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43167ff0f91so36834195e9.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 02:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732012602; x=1732617402;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/LBhCHTMqQoVJOzxseY1ef0b7wf1TZ9sjxf392UfOXQ=;
 b=mceweyyBEIyvxeXtdymO1unaoYRUZiQhd3WKOQmthx467Yaj5/5iBBDEvAl7Es25WG
 u/fPajCAKx9fRr3pptq2VkwX096ySohHitOf1TIcyQg2CpCE2bCWL/WvdIRTj6nSEW3V
 KtYT4GJIS+60LvycYF9Eebi7ri/sEEuBxFBTrSUdmojYs28Z9Y9qn2wPeRVgijOus0bv
 g8wMxc98QEC16ErYdIKPXVmRwka+F0iYQegrmUYiJnP/znSVMGCcmrw2DBWvfo3wRzpb
 V5zPcRiJcyUCWcqBZragjV+UobkTO5qXNjke+adXcVPr102l4qvEgAXGDYeL+Fyqrs4K
 Lt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732012602; x=1732617402;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/LBhCHTMqQoVJOzxseY1ef0b7wf1TZ9sjxf392UfOXQ=;
 b=rO6snW+ADty0cJlzG1kh4cbbfjLYvbKyuIkYCmq90EUiuR/UyOyAJFlHNeKzJkMFxl
 D/f0d6+EXyJammYNVD4boAorv0CiC9CLsfKCo2gVZy7Cm97bsrQhYpsce2MXoXaOmckl
 jnnF9rx4Df3uff2iLtEQ+E02zDbH19R9B90kJ8CNmsJEMnVf9+ugBriyihUZcIBIys66
 ErDCYHf42p50jqO5U6pykUM3PpNt+iyrC4qIzz+x2FPf74J2bNoVbtOA0s8YdPjC7+h+
 oJmLhhznsEq0lS3L7QLN8IEWFS5aHDX2V6UoWNBj0p0/DSnAXPe8IKUZxbt++8AImZsW
 rrzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmiG8LkJBCOXyquWvzQUdPs+bTFDqxbEx3qBb4HloNhSquTvrpJmD+sEhs6ovyFhatBQv6GQ0=@lists.denx.de
X-Gm-Message-State: AOJu0YzeIHKxW2soKja+SGfL0xq9gduJqtZdD0okdjnM87tivsfAPWuh
 fZPO+p7OShCXIgPF0EIFjmkSDRr3emvEUUOIXCLopjgAS9sJtXCLbXKMIARHKdg=
X-Google-Smtp-Source: AGHT+IGeOhQVK5roYdKsJcwiXti8c1+ZumWM5pcDIV4pdd7hQR+qoNMUg1QKoU1H/sDJeUrYKMRF/w==
X-Received: by 2002:a05:600c:1908:b0:431:52da:9d67 with SMTP id
 5b1f17b1804b1-432df7178f9mr147610135e9.3.1732012602628; 
 Tue, 19 Nov 2024 02:36:42 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab80a28sm188186415e9.24.2024.11.19.02.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 02:36:42 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
Subject: Re: [PATCH v2 4/5] configs: khadas-vim3_android{_ab}: move on
 bootmeth android
In-Reply-To: <20241114-adnroidv2-v2-4-015bffb1373a@baylibre.com>
References: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
 <20241114-adnroidv2-v2-4-015bffb1373a@baylibre.com>
Date: Tue, 19 Nov 2024 11:36:40 +0100
Message-ID: <87serny0g7.fsf@baylibre.com>
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

On jeu., nov. 14, 2024 at 22:29, Guillaume La Roque <glaroque@baylibre.com> wrote:

> Actually khadas vim3 use distro command to boot android image.
> Move on new bootmeth android for A/B and non-A/B vim3 android.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  configs/khadas-vim3_android_ab_defconfig |  7 ++++++-
>  configs/khadas-vim3_android_defconfig    |  7 ++++++-
>  include/configs/khadas-vim3_android.h    | 26 ++++++++++++++++++++++----
>  include/configs/meson64_android.h        |  3 ---
>  4 files changed, 34 insertions(+), 9 deletions(-)
>
> diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
> index de5357c45cbf..a078c5d363ae 100644
> --- a/configs/khadas-vim3_android_ab_defconfig
> +++ b/configs/khadas-vim3_android_ab_defconfig
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
> diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
> index a0d9c423c3c3..b77a44ce859b 100644
> --- a/configs/khadas-vim3_android_defconfig
> +++ b/configs/khadas-vim3_android_defconfig
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
> diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
> index 0e2953fe71b3..096ab4e5fb1f 100644
> --- a/include/configs/khadas-vim3_android.h
> +++ b/include/configs/khadas-vim3_android.h
> @@ -41,10 +41,28 @@
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
>  #endif
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

gpio_recovery is not used anywhere. Can we please drop this?

With that addressed, please add:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

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
>  #endif /* __CONFIG_H */
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index 37ef8b8f7a7e..d6ef0a83a686 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -104,9 +104,6 @@
>  	"elif test $board_name = sei610; then " \
>  		"echo \"  Reading DTB for sei610...\"; " \
>  		"setenv dtb_index 1;" \
> -	"elif test $board_name = vim3; then " \
> -		"echo \"  Reading DTB for vim3...\"; " \
> -		"setenv dtb_index 3;" \
>  	"else " \
>  		"echo Error: Android boot is not supported for $board_name; " \
>  		"exit; " \
>
> -- 
> 2.34.1
