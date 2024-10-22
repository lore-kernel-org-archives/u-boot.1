Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1649ED2C548
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A4358878A;
	Tue, 22 Oct 2024 14:46:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FMzM6NgH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4661488EBA; Tue, 22 Oct 2024 14:46:43 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FBD6881C1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:46:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-431548bd1b4so54617925e9.3
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 05:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729601201; x=1730206001;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=LBoyQ6YybvW2ed3USuSGHRo92Y/y9rMgOfXSEGyDSpo=;
 b=FMzM6NgHWLJuk6xlxyS7nJl/Pwzrq0fk/uk+OMYJMlOvOHxf59If37XZUmU2A/GfKs
 uNZg8Z9G8O3tOCAG/FQoclINEswSqNn9qsgQYan2pa8XUdqEG4s24Zie3LlRnRIGiWx8
 9LGn6k2db0jglzshW/4gnEy6hFj9S7RcEBXfcV+9V6wLmEKysK/ztY3cgwT0Ce8mNUoL
 0Yr5/YoF+9OZRAA6/zhdBfa+0Ss2Pfafq+bY0Xof1bOf4iwzt9RYLaUa8iZPwicMNWcL
 rm6ssmQCXA3n/Pq6K8Uxn26yZifhPaA7Djmsn7D0mK25l+Pzp5DkO7DD4wuphVAkg1y0
 Mm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729601201; x=1730206001;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LBoyQ6YybvW2ed3USuSGHRo92Y/y9rMgOfXSEGyDSpo=;
 b=lKONAPAtP5W3RMpdNaqXOgM9u4hes7p7TCfWoUZB8/dVLJjSMi/Q3qY4q+ci42zs5w
 CvQYD9IF+5kRk1JZY62vvUh/N8vgEv9XKoJg9G5mVwW5VkVhyzshyKMw9V0MTzs0EuRg
 JWCl6zg7hcchoehU1cLCSkmsFIrUFqmCvC8LdnIjbnBvjELxhdCMuwcq2/oNOisyp4jJ
 l5mU5cT+4zOdyo830Gjc2IlFyczoURJXrK/LnsjPsv6cYDk0ipq227XGyq4rvZvPaL2r
 wFkAdewbWgvC5UkhY2YfSBZe4WxChb2z6NlUS08HaDVcynM3JZQwx0pPEkRUuAGHCHe7
 3sEA==
X-Gm-Message-State: AOJu0YywcfGKzoYiG+iQ78XHBIri8Ttk0zL4F1sIRMsrridgJPAMlrnB
 TlYcavXPNWlqevhqzE4o3Z4LtEnsNUfd5xJ9yGtDE0Op85PiAsu3/B3mAUxdw4s=
X-Google-Smtp-Source: AGHT+IFjG3TtiRtXWrm7ap2tEgR9N1KoOC4+1geVpVD4SjcDnaJWpIDHrLmg0zJU+z3fKb4AmXWj7A==
X-Received: by 2002:a05:600c:4349:b0:431:5f1b:a7c6 with SMTP id
 5b1f17b1804b1-4317744a9dfmr46642685e9.30.1729601200640; 
 Tue, 22 Oct 2024 05:46:40 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5c2c8esm87883605e9.36.2024.10.22.05.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 05:46:40 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Guillaume La Roque
 <glaroque@baylibre.com>,
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com,
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
Subject: Re: [PATCH 5/6] configs: khadas-vim3_android{_ab}: move on bootmeth
 android
In-Reply-To: <20241017-adnroidv2-v1-5-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
 <20241017-adnroidv2-v1-5-781c939902c9@baylibre.com>
Date: Tue, 22 Oct 2024 14:46:36 +0200
Message-ID: <87y12guwyb.fsf@baylibre.com>
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

> Actually khadas vim3 use distro command to boot android image.
> Move on new bootmeth android for A/B and non-A/B vim3 android.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  configs/khadas-vim3_android_ab_defconfig |  7 ++++++-
>  configs/khadas-vim3_android_defconfig    |  7 ++++++-
>  include/configs/khadas-vim3_android.h    | 27 +++++++++++++++++++++++----
>  3 files changed, 35 insertions(+), 6 deletions(-)
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
> index 0e2953fe71b3..498afd0287f4 100644
> --- a/include/configs/khadas-vim3_android.h
> +++ b/include/configs/khadas-vim3_android.h
> @@ -41,10 +41,29 @@
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
