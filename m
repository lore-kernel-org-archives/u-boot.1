Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3863E92708
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 15:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2824B86D05;
	Thu,  5 Oct 2023 17:02:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QYj3IlxQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03C386D0A; Thu,  5 Oct 2023 17:02:03 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6500D86CF7
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 17:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9a9f139cd94so186252166b.2
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696518116; x=1697122916; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TzOGvmVycVU/YlTKc2iM7DeYnHJIDhHG9U9pm+Wksrk=;
 b=QYj3IlxQc6jktu5R4gEuYEvTynKfFVk9qVLg6CwBUVn4eXsuOeZ8fp2nDFbMzLdNJa
 hAgwI4JtoiO/Ot5zcfQiPkdM2LoKo2eTCmnC+jFFC7KAuncKS/ctPzECdv+Qx4JqE59+
 DdvPTNB5X/nDDuuQkl8KdhbvjR0QxpbWTjAao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696518116; x=1697122916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TzOGvmVycVU/YlTKc2iM7DeYnHJIDhHG9U9pm+Wksrk=;
 b=b1GbGbje3BwCyCkF1vWSeHKksg6RTZrWiDtMUZ9XJYJX6D7FWzmdt89gTNjI2XM31/
 mj3t0B5H55lMXCaqQWr1yYV+vNlAz4NzuSf+jC6+QZS5MAFhH9rcxKilU2c5CbYDnGGZ
 ejl3wylaKvsk2kwdRro5fvn+48tjYTAbWneJDTShsMzwORFR7SuArWNJOsS0whSZD/cW
 3R64LtDoTxCS+VUJTczxz7uAsCl3VQ+MU3uPXztdyHU8xPrSK7YhBZbIbtaUAQp6IJ6O
 w6zKS4bsMRE1Q6Y293KijOs9ONrQrFmN2PIbl3rK5a/B1Nq7AcOH2+JqR86igzGccVT3
 eZBw==
X-Gm-Message-State: AOJu0Yw6Vlp+w9p4/pF7moCQeOJflsMQZyaCc5OdAcq4m+OC3SGjfLnz
 iSdRGBF2E6FQFhdy8zdAsUtA5nuwXtu4YuXbLbjoiQ==
X-Google-Smtp-Source: AGHT+IFZf/fyKP2XMxDE9eS8YnYwg91ErnSSWZKxbvpTTnIaamb8zSt4xZ1YY6LSItj+7RHnyKpIdaV1mCNbLS21LUQ=
X-Received: by 2002:a17:907:75fb:b0:9b2:b2ad:2a8f with SMTP id
 jz27-20020a17090775fb00b009b2b2ad2a8fmr4477166ejc.11.1696518115519; Thu, 05
 Oct 2023 08:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231005130642.21402-1-rogerq@kernel.org>
 <20231005130642.21402-3-rogerq@kernel.org>
In-Reply-To: <20231005130642.21402-3-rogerq@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Oct 2023 09:01:42 -0600
Message-ID: <CAPnjgZ0uMLFdqvpcDMKnXQDL-m1ecUB33gat4EZK7jm=UeEB4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] board: ti: am64x: Switch to standard boot flow
To: Roger Quadros <rogerq@kernel.org>
Cc: trini@konsulko.com, nm@ti.com, vigneshr@ti.com, m-chawdhry@ti.com, 
 jonas@kwiboo.se, srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com, 
 u-boot@lists.denx.de
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

Hi Roger,

On Thu, 5 Oct 2023 at 07:07, Roger Quadros <rogerq@kernel.org> wrote:
>
> Switch to using bootstd. Note with this change, we will stop using
> distro_bootcmd and instead depend entirely on bootflow method of
> starting the system up.
>
> Drop header files that are no longer needed in am64x_evm.h.
> k3_dfu.h is available via k3_dfu.env in am64x.env.
>
> Drop unused macro CFG_SYS_SDRAM_BASE1.
>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  board/ti/am64x/am64x.env        | 1 +
>  configs/am64x_evm_a53_defconfig | 5 +++--
>  include/configs/am64x_evm.h     | 9 ---------
>  3 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/board/ti/am64x/am64x.env b/board/ti/am64x/am64x.env
> index 68e42222b7..efd736b99b 100644
> --- a/board/ti/am64x/am64x.env
> +++ b/board/ti/am64x/am64x.env
> @@ -15,6 +15,7 @@ console=ttyS2,115200n8
>  args_all=setenv optargs earlycon=ns16550a,mmio32,0x02800000 ${mtdparts}
>  run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
>
> +boot_targets=mmc1 mmc0 usb pxe dhcp
>  boot=mmc
>  mmcdev=1
>  bootpart=1:2
> diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
> index 718ad176cb..43bfcf957a 100644
> --- a/configs/am64x_evm_a53_defconfig
> +++ b/configs/am64x_evm_a53_defconfig
> @@ -31,8 +31,9 @@ CONFIG_SPL_SPI=y
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SPL_LOAD_FIT=y
>  CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
> -CONFIG_DISTRO_DEFAULTS=y
> -CONFIG_BOOTCOMMAND="run envboot; run distro_bootcmd;"
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_BOOTSTD_DEFAULTS=y
> +CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
>  CONFIG_BOARD_LATE_INIT=y
>  CONFIG_SPL_MAX_SIZE=0x180000
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> diff --git a/include/configs/am64x_evm.h b/include/configs/am64x_evm.h
> index 062102a610..f9f8c7bc2f 100644
> --- a/include/configs/am64x_evm.h
> +++ b/include/configs/am64x_evm.h
> @@ -9,15 +9,6 @@
>  #ifndef __CONFIG_AM642_EVM_H
>  #define __CONFIG_AM642_EVM_H
>
> -#include <linux/sizes.h>
> -#include <config_distro_bootcmd.h>
> -#include <env/ti/mmc.h>
> -#include <asm/arch/am64_hardware.h>
> -#include <env/ti/k3_dfu.h>
> -
> -/* DDR Configuration */
> -#define CFG_SYS_SDRAM_BASE1            0x880000000
> -
>  /* Now for the remaining common defines */
>  #include <configs/ti_armv7_common.h>

It looks like this file still includes distro_bootcmd and defines all
the BOOT_TARGET things. Can they be dropped? Perhaps for now they
could be put behind an #ifdef if other boards need them?

I suspect that with your patch as is, the environment is still full of scripts?

>
> --
> 2.34.1
>

Regards,
Simon
