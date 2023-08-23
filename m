Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD82BC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 00:00:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97E2786536;
	Thu, 24 Aug 2023 01:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O16D4mIf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F84F864FF; Thu, 24 Aug 2023 01:59:23 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED1AC86501
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d656d5e8265so6047277276.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pC/MoY6FtOMC0yrpkRSbavxJh0p6n8POl2GERXmxpjc=;
 b=O16D4mIf1rQOxjs0Zobo3LP0JEEmfmfVuBUGNHBNv9hfaX9fXoBtDURPpJRnUKQQ4d
 Wfq3N1GgJ/y0srmF64hjuDtezLSl0KuhFmx604UG+9HF+wQz2vSKrMm8TScmcUrbbJi5
 0aiUG7b6jKq79rN6M3eGidGO56HT5WpICeZYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pC/MoY6FtOMC0yrpkRSbavxJh0p6n8POl2GERXmxpjc=;
 b=J/p6+buWxsfTYPNQyuL4EgerpqlRjiuAUTHinRqwdXDYo5VK5UIoYmDM8n8cqZ3srX
 UKA0vosFHyApB9L3L4CPcFMG3SN9dcXkgvrHZU0EQqGYCqLLtdy34Fqar3b5xnLirSC1
 cplZdj0ggHKklfyQjwRlyfh/f97eWgciPPVCM85GM/AGVe2U0zod47PpqmumkaYj6d6Q
 gtE1YCUvKdm5940wHokpj7FeadLruhElSludSd/BfAkbg/b8tbBabLSH4G9Ln5QvzMTH
 ATy3DMLkw51RkRhQcg6suVmP2codGQORA/RBxjOFa7Z5cgA+ocQBUmW805lnw7BJ/ngI
 VgEg==
X-Gm-Message-State: AOJu0YyZoLL8DEfJoeV99fh2SeqvM/5posifhNTtWQOeAH24wX0Jpzr+
 NzFSpceSuzZIun+whmBW1iOgV9ktGgtmHXaK03bju2YDtmnk5LlZvoE=
X-Google-Smtp-Source: AGHT+IGDkh1hZ7OD5fAPKkuqc36mKcQf/E8fheoAHtdOSYyHw0g8Uy/2/tjFamiqdLJGM5L9copM48OSuty1xnB21ao=
X-Received: by 2002:a25:dc8f:0:b0:d4d:6366:1fcd with SMTP id
 y137-20020a25dc8f000000b00d4d63661fcdmr13718814ybe.0.1692835156423; Wed, 23
 Aug 2023 16:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220712071212.2188390-1-sumit.garg@linaro.org>
 <20220712071212.2188390-6-sumit.garg@linaro.org>
In-Reply-To: <20220712071212.2188390-6-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Aug 2023 17:57:59 -0600
Message-ID: <CAPnjgZ2jR_fpjKo6XyG6eOY1ZX9ktXsaON6Ey6STY1ZjcnUzAw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] board: qualcomm: Add support for dragonboard845c
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, rfried.dev@gmail.com, peng.fan@nxp.com, 
 jh80.chung@samsung.com, trini@konsulko.com, dsankouski@gmail.com, 
 stephan@gerhold.net, vinod.koul@linaro.org, nicolas.dechesne@linaro.org, 
 mworsfold@impinj.com, daniel.thompson@linaro.org, pbrobinson@gmail.com
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

Hi Sumit,

On Tue, 12 Jul 2022 at 01:12, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Add support for 96Boards Dragonboard 845C aka Robotics RB3 development
> platform. This board complies with 96Boards Open Platform Specifications.
>
> Features:
> - Qualcomm Snapdragon SDA845 SoC
> - 4GiB RAM
> - 64GiB UFS drive
>
> U-boot is chain loaded by ABL in 64-bit mode as part of boot.img.
> For detailed build and boot instructions, refer to
> doc/board/qualcomm/sdm845.rst, board: dragonboard845c.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
> ---
>  arch/arm/dts/dragonboard845c-uboot.dtsi       |  37 +++++++
>  arch/arm/dts/dragonboard845c.dts              |  44 ++++++++
>  arch/arm/mach-snapdragon/Kconfig              |  14 +++
>  board/qualcomm/dragonboard845c/Kconfig        |  12 +++
>  board/qualcomm/dragonboard845c/MAINTAINERS    |   6 ++
>  board/qualcomm/dragonboard845c/Makefile       |   9 ++
>  board/qualcomm/dragonboard845c/db845c.its     |  63 +++++++++++
>  .../dragonboard845c/dragonboard845c.c         |   9 ++
>  configs/dragonboard845c_defconfig             |  28 +++++
>  doc/board/qualcomm/sdm845.rst                 | 100 +++++++++++++++---
>  include/configs/dragonboard845c.h             |  28 +++++
>  11 files changed, 337 insertions(+), 13 deletions(-)
>  create mode 100644 arch/arm/dts/dragonboard845c-uboot.dtsi
>  create mode 100644 arch/arm/dts/dragonboard845c.dts
>  create mode 100644 board/qualcomm/dragonboard845c/Kconfig
>  create mode 100644 board/qualcomm/dragonboard845c/MAINTAINERS
>  create mode 100644 board/qualcomm/dragonboard845c/Makefile
>  create mode 100644 board/qualcomm/dragonboard845c/db845c.its
>  create mode 100644 board/qualcomm/dragonboard845c/dragonboard845c.c
>  create mode 100644 configs/dragonboard845c_defconfig
>  create mode 100644 include/configs/dragonboard845c.h
>
[..]

> diff --git a/doc/board/qualcomm/sdm845.rst b/doc/board/qualcomm/sdm845.rst
> index b6642c9579..8ef4749287 100644
> --- a/doc/board/qualcomm/sdm845.rst
> +++ b/doc/board/qualcomm/sdm845.rst
> @@ -35,9 +35,25 @@ Pack android boot image
>  ^^^^^^^^^^^^^^^^^^^^^^^
>  We'll assemble android boot image with ``u-boot.bin`` instead of linux kernel,
>  and FIT image instead of ``initramfs``. Android bootloader expect gzipped kernel
> -with appended dtb, so let's mimic linux to satisfy stock bootloader:
> +with appended dtb, so let's mimic linux to satisfy stock bootloader.
>

[..]

> +The dragonboard845c is a Qualcomm Robotics RB3 Development Platform, based on
> +the Qualcomm SDM845 SoC.
> +
> +Steps:
> +
> +- Build u-boot::
> +
> +       $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> +       $ make dragonboard845c_defconfig
> +       $ make
> +
> +- Create dummy dtb::
> +
> +       workdir=/tmp/prepare_payload
> +       mkdir -p "$workdir"
> +       mock_dtb="$workdir"/payload_mock.dtb
> +
> +       dtc -I dts -O dtb -o "$mock_dtb" << EOF
> +       /dts-v1/;
> +       / {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +
> +               memory@80000000 {
> +                       device_type = "memory";
> +                       /* We expect the bootloader to fill in the size */
> +                       reg = <0 0x80000000 0 0>;
> +               };
> +
> +               chosen { };
> +       };
> +       EOF
> +
> +- gzip u-boot::
> +
> +       gzip u-boot.bin
> +
> +- Append dtb to gzipped u-boot::
> +
> +        cat u-boot.bin.gz "$mock_dtb" > u-boot.bin.gz-dtb
> +
> +- A ``db845c.its`` file can be found in ``board/qualcomm/dragonboard845c/``
> +  directory. It expects a folder as ``db845c_imgs/`` in the main directory
> +  containing pre-built kernel, dts and ramdisk images. See ``db845c.its``
> +  for full path to images::
> +
> +       mkimage -f db845c.its db845c.itb
> +
> +- Now we've got everything to build android boot image::
> +
> +       mkbootimg --kernel u-boot.bin.gz-dtb --ramdisk db845c.itb \
> +       --output boot.img --pagesize 4096 --base 0x80000000
> +
> +- Flash boot.img using db845c fastboot method.

What command should be used here? I can run 'fastboot devices' but am
not sure what command to use to flash U-Boot.

Also, is it possible to flash U-Boot as a first-stage bootloader?

> +
> +More information can be found on the `DragonBoard 845c page`_.
>
>  .. _Samsung S9 page: https://en.wikipedia.org/wiki/Samsung_Galaxy_S9
> +.. _DragonBoard 845c page: https://www.96boards.org/product/rb3-platform/
> diff --git a/include/configs/dragonboard845c.h b/include/configs/dragonboard845c.h
> new file mode 100644
> index 0000000000..108dde199b
> --- /dev/null
> +++ b/include/configs/dragonboard845c.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Configuration file for Dragonboard 845c, based on Qualcomm SDA845 chip
> + *
> + * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
> + */
> +
> +#ifndef __CONFIGS_SDM845_H
> +#define __CONFIGS_SDM845_H
> +
> +#include <linux/sizes.h>
> +#include <asm/arch/sysmap-sdm845.h>
> +
> +#define CONFIG_SYS_BAUDRATE_TABLE      { 115200, 230400, 460800, 921600 }
> +
> +#define CONFIG_EXTRA_ENV_SETTINGS \
> +       "bootm_size=0x5000000\0"        \
> +       "bootm_low=0x80000000\0"        \
> +       "bootcmd=bootm $prevbl_initrd_start_addr\0"
> +
> +/* Size of malloc() pool */
> +#define CONFIG_SYS_BOOTM_LEN   SZ_64M
> +
> +/* Monitor Command Prompt */
> +#define CONFIG_SYS_CBSIZE      512
> +#define CONFIG_SYS_MAXARGS     64
> +
> +#endif
> --
> 2.25.1
>

Regards,
Simon
