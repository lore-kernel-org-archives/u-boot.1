Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9903ED6206A
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 10:35:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32BE88955A;
	Tue, 19 Nov 2024 11:35:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h2XVBbAF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D70589557; Tue, 19 Nov 2024 11:35:20 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 861CB8955A
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 11:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso26309575e9.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 02:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732012518; x=1732617318;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=65wVwdtPs6LhZxyrvkZHnkj1YhHrKuX21s0aS8DbkkE=;
 b=h2XVBbAFupiYPoN4VDDhL3ziaVIQXeLOqngz+Mpxvf8pm3C+rnqocsCSh2/R2TZ7ZD
 1BhFrb7hWThjRbialBPGtgVMVP6TwCy0QoxeURHb8gCWCPvOsalzUAq7Uhn4IhoBV5mp
 GQMDhfYM5ID504wQ8t7GR9nGE8YpKCIbCi2w9H4VyC2CaTEJ/eGPmqvexvhn0ZAxkzCq
 2A5V5ennwlDaQoRonb0J+C0oIv8tn+/hATGplQ2AbzP8VG86aVzrebGpkd2K6jN/1IPv
 0fWzn5FR0J5HEpt8adfBo00jOqTDCjWe4s46HCk4tGQ35Ww+644MuRWLwvdu3wcOfgNf
 IiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732012518; x=1732617318;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=65wVwdtPs6LhZxyrvkZHnkj1YhHrKuX21s0aS8DbkkE=;
 b=G/kdqbDG5Pri5zWXiqPYwGcPdO3+wv5loQ74vqTseZ6CmPBFxGBnJUQ48RDVoaui1W
 uPb7EzgcJhsd6tpL63xHhHpd7h6RTcXleKgfctp+39H7vIkeNn+dDH+CrAmWXgivXv5D
 L4ealJBjWupsE8PejUQLse1jKZxJfj0F3vfiDRwvZVGEs9Y/tjXcbaK8KgxCKr4GGRII
 VAq8OLq/RfsWWSlaetvyrB1tgAMKwU+ORSLBYUJqlzFd3iLQeXYfu+p649m8ffGz7CLn
 vOcZbUvq7t/QYWTuF67XRqZtlqIOsSqHJWBQ/HzxvpRJl7REPKWajpjYJcVJCkLqgBSQ
 m0iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnL7RRfbGYDxMlQj4+Kog8yvcILL9ecqgCCB0xBedtkE0sjW0kAGesGufflEd9nqKJwxDL8NA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9aMNF8y1rw3iXuGzHkjUyKjem7fmVsripWqBCRTcA9GEZD/d7
 W+3zoXjPIk3vGQgw9amg2RStdWBiEOM1wqEtjsYUlgXN7jnshvkTwO0j6nlzKbQ=
X-Google-Smtp-Source: AGHT+IEsmUKV3xbztrNlPE6Zl3hJdojpHKuvPTJPR4tDFWx3QFpekF0QcYjxAwtqZ+4pATrfB2CuQw==
X-Received: by 2002:a05:600c:3d0b:b0:432:d735:cc85 with SMTP id
 5b1f17b1804b1-432df74c923mr124923435e9.18.1732012517883; 
 Tue, 19 Nov 2024 02:35:17 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da28cb89sm190822695e9.34.2024.11.19.02.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 02:35:17 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
Subject: Re: [PATCH v2 3/5] configs: khadas-vim3l_android{_ab}: move on
 bootmeth android
In-Reply-To: <20241114-adnroidv2-v2-3-015bffb1373a@baylibre.com>
References: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
 <20241114-adnroidv2-v2-3-015bffb1373a@baylibre.com>
Date: Tue, 19 Nov 2024 11:35:14 +0100
Message-ID: <87v7wjy0il.fsf@baylibre.com>
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

> Actually khadas vim3l use distro command to boot android image.
> Move on new bootmeth android for A/B and non-A/B vim3l android.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  configs/khadas-vim3l_android_ab_defconfig |  7 ++++++-
>  configs/khadas-vim3l_android_defconfig    |  7 ++++++-
>  include/configs/khadas-vim3l_android.h    | 26 ++++++++++++++++++++++----
>  include/configs/meson64_android.h         |  3 ---
>  4 files changed, 34 insertions(+), 9 deletions(-)

[...]

>
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_I2C=y
> diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
> index f39a3782d663..31068c59d5ed 100644
> --- a/include/configs/khadas-vim3l_android.h
> +++ b/include/configs/khadas-vim3l_android.h
> @@ -41,10 +41,28 @@
>  	"name=rootfs,size=-,uuid=" ROOT_UUID
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
> index 77364bbf9cf0..37ef8b8f7a7e 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -104,9 +104,6 @@
>  	"elif test $board_name = sei610; then " \
>  		"echo \"  Reading DTB for sei610...\"; " \
>  		"setenv dtb_index 1;" \
> -	"elif test $board_name = vim3l; then " \
> -		"echo \"  Reading DTB for vim3l...\"; " \
> -		"setenv dtb_index 2;" \
>  	"elif test $board_name = vim3; then " \
>  		"echo \"  Reading DTB for vim3...\"; " \
>  		"setenv dtb_index 3;" \
>
> -- 
> 2.34.1
