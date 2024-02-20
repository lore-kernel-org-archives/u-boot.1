Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFCEC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7C2187F83;
	Tue, 20 Feb 2024 14:33:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WZYgRm2E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 724EF87F7D; Tue, 20 Feb 2024 14:33:56 +0100 (CET)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F32887F52
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-4704e6dd739so403760137.0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708436023; x=1709040823; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QHYXyS6TAINPkbztlz9IrOcNN59LC1PkB3+meihPRJ0=;
 b=WZYgRm2Ec5nB3osenJkU0NUwU7SmVdVrlxeGAoAcxm7awyV1M1K8XMKI7OpMEbqu4B
 c5o4gBNqYWVZVhyez2Ma/YQr9R+oAQCSHU/OGlYmpZH4yObHxcIHOm31syHMnBQQk6lO
 yL6682dZNwU43px1VrZtTjQ/yyKFXUO6StbtJwABdb5bv6tOnPbhdvE7JFXvZw04jmE+
 sm2ambv8CcI5cOQHTLyUlIuiKKNqeaw9n57d8eqkuZaYGB22dgtcusvQp7n+/P366Aer
 XEJziPTSglKjtSjiisfsTaZI3CtH6L6T9WfJQ/RHLljqV83C6eHAv5BATYEL8w9tewsA
 gfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708436023; x=1709040823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QHYXyS6TAINPkbztlz9IrOcNN59LC1PkB3+meihPRJ0=;
 b=nBwW0xb0OhbRwOfk2thGYfDjCzWjv7BDbejgLZXFBt6NDv76sxN2oX3Ib/oLyaUTRb
 bHN93KkdAqPSPfPHWVI/m4qgLumgUPZ7LlcawUOqTPkEwaUnaRrDKxEToD//BjFcWTLS
 Ek5wcEefiLkOaHg/MZ2z8uIAawH75edG0/x3ZQuzWtCdzFLtOTMepwxaaEf5JuyEXz12
 Mv8pgVWbEsKhtBPemQiDlBgvi1YRF3JB7S97cwijFTM7YdVRt+0VXjFUW0HxhyIhTYAZ
 kdEvFhXtFjq8TdpkHQYZuCOw89Jt8bRBM8f9je7oERas+yNfawFLJp7F/cNox30X9A1N
 pR0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE27iV2MsQw8eaeWRtqIxsz8+0q1CigDV/gh+JUNjo14SgArbcBPAJmRxQfJ2Z6TVea1ZtaCi9EcTGkRw9woSys4dXWQ==
X-Gm-Message-State: AOJu0YzF/OqumbZDQOAAR93tZi12GEygWPvdbtRryPVKSPrSeuF1QvSK
 3dcjoxDGoim5ybsSgOL3iO1W938TYvPXHhJHHW9UsdMdSAa8AXw2jn0jvcvdb+1BQN0rUjgRKWd
 yfjto0nKPPCafiDYoDYf39UWXE8IR3MZ88z4Wew==
X-Google-Smtp-Source: AGHT+IEJUnkBQOvk9GzNqLasF8FqrUvs0LXIxaWo9vqWy+fd/yVkrBVNIl3lJ0edUKGRPIdz1qo00/E1eoz9O2847UY=
X-Received: by 2002:a67:eb94:0:b0:46e:c865:6b4a with SMTP id
 e20-20020a67eb94000000b0046ec8656b4amr11739007vso.34.1708436023028; Tue, 20
 Feb 2024 05:33:43 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-20-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-20-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 19:03:31 +0530
Message-ID: <CAFA6WYM6QEVoUnLKcoa3kdOPftTPV4FAbNvuLJZX_bNb=QMmVw@mail.gmail.com>
Subject: Re: [PATCH v4 20/39] mach-snapdragon: generalise board support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
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

On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Historically, Qualcomm boards have relied on heavy hardcoding in U-Boot,
> in many cases to the specific SoC but also to the board itself (e.g.
> memory map). This has been largely resolved by modernising the Qualcomm
> drivers in U-Boot, however the board code still largely follows this
> model.
>
> This patch removes the board specific memory maps and duplicated board
> init code, replacing it with generic init code.
>
> The memory map is now built at runtime based on data read from DT, this
> allows for the memory map to be provided without having to recompile
> U-Boot. Support is also added for booting with appended DTBs, so that
> the first-stage bootloader can populate the memory map for us.
>
> The sdm845 specific init code is dropped entirely, it set an environment
> variable depending on if a button was pressed, but this variable wasn't
> used in U-Boot, and could be written to use the button command instead.
>
> The KASLR detection is also dropped as with appended dtb, the kaslr seed
> can be read directly from the DTB passed to U-Boot.
>
> A new qcom_defconfig is added, with the aim of providing a generic
> U-Boot configuration that will work on as many Qualcomm boards as
> possible. It replaces the defconfig files for the Dragonboard 845c,
> Galaxy S9, and QCS404 EVB. For now the db410c and 820c are excluded as
> they still have some board code left.
>
> Similarly, the config headers for db845c, starqltechn, and qcs404-evb
> are replaced by a single qcom header.
>
> The previously db410c-specific board_usb_init() function is made to be
> generic and is added to mach-snapdragon. While we lack proper modelling
> for USB configuration, using a well-known named pinctrl state is a
> reasonably generic middleground, and works using upstream DT. This
> function will do nothing unless the USB node has a pinctrl state named
> "device", in which case it will be set when entering USB peripheral
> mode.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/Kconfig                                 |   3 +
>  arch/arm/dts/Makefile                            |   9 +-
>  arch/arm/mach-snapdragon/Kconfig                 |  96 ++--------
>  arch/arm/mach-snapdragon/Makefile                |   6 +-
>  arch/arm/mach-snapdragon/board.c                 | 215 +++++++++++++++++++++++
>  arch/arm/mach-snapdragon/init_sdm845.c           |  73 --------
>  arch/arm/mach-snapdragon/sysmap-apq8016.c        |  31 ----
>  arch/arm/mach-snapdragon/sysmap-apq8096.c        |  31 ----
>  arch/arm/mach-snapdragon/sysmap-qcs404.c         |  43 -----
>  arch/arm/mach-snapdragon/sysmap-sdm845.c         |  31 ----
>  board/qualcomm/dragonboard410c/Kconfig           |  15 --
>  board/qualcomm/dragonboard410c/dragonboard410c.c |  41 -----
>  board/qualcomm/dragonboard820c/Kconfig           |  15 --
>  board/qualcomm/dragonboard820c/dragonboard820c.c |  39 +---
>  board/qualcomm/dragonboard845c/Kconfig           |  12 --
>  board/qualcomm/qcs404-evb/Kconfig                |  15 --
>  board/qualcomm/qcs404-evb/qcs404-evb.c           |  21 +--
>  configs/dragonboard410c_defconfig                |   6 +-
>  configs/dragonboard820c_defconfig                |   6 +-
>  configs/dragonboard845c_defconfig                |  29 ---
>  configs/qcom_defconfig                           |  67 +++++++
>  configs/qcs404evb_defconfig                      |   5 +-
>  configs/starqltechn_defconfig                    |  41 -----
>  include/configs/dragonboard845c.h                |  20 ---
>  include/configs/qcom.h                           |  21 +++
>  include/configs/qcs404-evb.h                     |  20 ---
>  include/configs/sdm845.h                         |  26 ---
>  27 files changed, 345 insertions(+), 592 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 6b072be24634..672577d0ddcc 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1095,6 +1095,9 @@ config ARCH_SNAPDRAGON
>         select OF_SEPARATE
>         select SMEM
>         select SPMI
> +       select OF_BOARD
> +       select SAVE_PREV_BL_FDT_ADDR
> +       select LINUX_KERNEL_IMAGE_HEADER
>         imply CMD_DM
>
>  config ARCH_SOCFPGA
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index ce10d3dbb07d..751035a577f6 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -631,10 +631,11 @@ dtb-$(CONFIG_TARGET_SL28) += fsl-ls1028a-kontron-sl28.dtb \
>
>  dtb-$(CONFIG_TARGET_TEN64) += fsl-ls1088a-ten64.dtb
>
> -dtb-$(CONFIG_TARGET_DRAGONBOARD410C) += dragonboard410c.dtb
> -dtb-$(CONFIG_TARGET_DRAGONBOARD820C) += dragonboard820c.dtb
> -dtb-$(CONFIG_TARGET_STARQLTECHN) += starqltechn.dtb
> -dtb-$(CONFIG_TARGET_QCS404EVB) += qcs404-evb.dtb
> +dtb-$(CONFIG_ARCH_SNAPDRAGON) += dragonboard410c.dtb \
> +       dragonboard820c.dtb \
> +       dragonboard845c.dtb \
> +       starqltechn.dtb \
> +       qcs404-evb.dtb
>
>  dtb-$(CONFIG_TARGET_STEMMY) += ste-ux500-samsung-stemmy.dtb
>
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index f897c393464f..96e44e2c5491 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -3,6 +3,9 @@ if ARCH_SNAPDRAGON
>  config SYS_SOC
>         default "snapdragon"
>
> +config SYS_VENDOR
> +       default "qualcomm"
> +
>  config SYS_MALLOC_F_LEN
>         default 0x2000
>
> @@ -12,91 +15,24 @@ config SPL_SYS_MALLOC_F
>  config SPL_SYS_MALLOC_F_LEN
>         default 0x2000
>
> -config SDM845
> -       bool "Qualcomm Snapdragon 845 SoC"
> -       select LINUX_KERNEL_IMAGE_HEADER
> -       imply CLK_QCOM_SDM845
> -       imply PINCTRL_QCOM_SDM845
> -       imply BUTTON_QCOM_PMIC
> -
>  config LNX_KRNL_IMG_TEXT_OFFSET_BASE
>         default 0x80000000
>
> -choice
> -       prompt "Snapdragon board select"
> -
> -config TARGET_DRAGONBOARD410C
> -       bool "96Boards Dragonboard 410C"
> -       select BOARD_LATE_INIT
> -       select ENABLE_ARM_SOC_BOOT0_HOOK
> -       imply CLK_QCOM_APQ8016
> -       imply PINCTRL_QCOM_APQ8016
> -       imply BUTTON_QCOM_PMIC
> +config SYS_BOARD
> +       string "Qualcomm custom board"
>         help
> -         Support for 96Boards Dragonboard 410C. This board complies with
> -         96Board Open Platform Specifications. Features:
> -         - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> -         - 1GiB RAM
> -         - 8GiB eMMC, uSD slot
> -         - WiFi, Bluetooth and GPS module
> -         - 2x Host, 1x Device USB port
> -         - HDMI
> -         - 20-pin low speed and 40-pin high speed expanders, 4 LED, 3 buttons
> +         The Dragonboard 410c and 820c have additional board init
> +         code that isn't shared with other Qualcomm boards.
> +         Based on this option board/qualcomm/<CONFIG_SYS_BOARD> will
> +         be used.
>
> -config TARGET_DRAGONBOARD820C
> -       bool "96Boards Dragonboard 820C"
> -       select LINUX_KERNEL_IMAGE_HEADER
> -       imply CLK_QCOM_APQ8096
> -       imply PINCTRL_QCOM_APQ8096
> -       imply BUTTON_QCOM_PMIC
> +config SYS_CONFIG_NAME
> +       string "Board configuration name"
> +       default SYS_BOARD if SYS_BOARD != ""
> +       default "qcom"
>         help
> -         Support for 96Boards Dragonboard 820C. This board complies with
> -         96Board Open Platform Specifications. Features:
> -         - Qualcomm Snapdragon 820C SoC - APQ8096 (4xKyro CPU)
> -         - 3GiB RAM
> -         - 32GiB UFS drive
> -
> -config TARGET_DRAGONBOARD845C
> -       bool "96Boards Dragonboard 845C"
> -       help
> -         Support for 96Boards Dragonboard 845C aka Robotics RB3 Development
> -         Platform. This board complies with 96Boards Open Platform
> -         Specifications. Features:
> -         - Qualcomm Snapdragon SDA845 SoC
> -         - 4GiB RAM
> -         - 64GiB UFS drive
> -       select MISC_INIT_R
> -       select SDM845
> -
> -config TARGET_STARQLTECHN
> -       bool "Samsung S9 SM-G9600(starqltechn)"
> -       help
> -         Support for Samsung S9 SM-G9600(starqltechn) board.
> -         Features:
> -         - Qualcomm Snapdragon SDM845 SoC
> -         - 4GiB RAM
> -         - 64GiB UFS drive
> -       select MISC_INIT_R
> -       select SDM845
> -
> -config TARGET_QCS404EVB
> -       bool "Qualcomm Technologies, Inc. QCS404 EVB"
> -       select LINUX_KERNEL_IMAGE_HEADER
> -       imply CLK_QCOM_QCS404
> -       imply PINCTRL_QCOM_QCS404
> -       help
> -         Support for Qualcomm Technologies, Inc. QCS404 evaluation board.
> -         Features:
> -         - Qualcomm Snapdragon QCS404 SoC
> -         - 1GiB RAM
> -         - 8GiB eMMC, uSD slot
> -
> -endchoice
> -
> -source "board/qualcomm/dragonboard410c/Kconfig"
> -source "board/qualcomm/dragonboard820c/Kconfig"
> -source "board/qualcomm/dragonboard845c/Kconfig"
> -source "board/samsung/starqltechn/Kconfig"
> -source "board/qualcomm/qcs404-evb/Kconfig"
> +         This option contains information about board configuration name.
> +         Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
> +         will be used for board configuration.
>
>  endif
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index d02432df8b04..857171e593da 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -2,8 +2,4 @@
>  #
>  # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>
> -obj-$(CONFIG_SDM845) += sysmap-sdm845.o
> -obj-$(CONFIG_SDM845) += init_sdm845.o
> -obj-$(CONFIG_TARGET_DRAGONBOARD820C) += sysmap-apq8096.o
> -obj-$(CONFIG_TARGET_DRAGONBOARD410C) += sysmap-apq8016.o
> -obj-$(CONFIG_TARGET_QCS404EVB) += sysmap-qcs404.o
> +obj-y += board.o
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> new file mode 100644
> index 000000000000..a1867852bcca
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Common initialisation for Qualcomm Snapdragon boards.
> + *
> + * Copyright (c) 2024 Linaro Ltd.
> + * Author: Caleb Connolly <caleb.connolly@linaro.org>
> + */
> +
> +#include "time.h"
> +#include <asm/armv8/mmu.h>
> +#include <asm/gpio.h>
> +#include <asm/io.h>
> +#include <asm/psci.h>
> +#include <asm/system.h>
> +#include <dm/device.h>
> +#include <dm/pinctrl.h>
> +#include <dm/uclass-internal.h>
> +#include <dm/read.h>
> +#include <env.h>
> +#include <init.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/bug.h>
> +#include <linux/psci.h>
> +#include <linux/sizes.h>
> +#include <malloc.h>
> +#include <usb.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
> +
> +struct mm_region *mem_map = rbx_mem_map;
> +
> +int dram_init(void)
> +{
> +       return fdtdec_setup_mem_size_base();
> +}
> +
> +static int ddr_bank_cmp(const void *v1, const void *v2)
> +{
> +       const struct {
> +               phys_addr_t start;
> +               phys_size_t size;
> +       } *res1 = v1, *res2 = v2;
> +
> +       if (!res1->size)
> +               return 1;
> +       if (!res2->size)
> +               return -1;
> +
> +       return (res1->start >> 24) - (res2->start >> 24);
> +}
> +
> +int dram_init_banksize(void)
> +{
> +       int ret;
> +
> +       ret = fdtdec_setup_memory_banksize();
> +       if (ret < 0)
> +               return ret;
> +
> +       if (CONFIG_NR_DRAM_BANKS < 2)
> +               return 0;
> +
> +       /* Sort our RAM banks -_- */
> +       qsort(gd->bd->bi_dram, CONFIG_NR_DRAM_BANKS, sizeof(gd->bd->bi_dram[0]), ddr_bank_cmp);
> +
> +       return 0;
> +}
> +
> +static void show_psci_version(void)
> +{
> +       struct arm_smccc_res res;
> +
> +       arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
> +
> +       debug("PSCI:  v%ld.%ld\n",
> +             PSCI_VERSION_MAJOR(res.a0),
> +             PSCI_VERSION_MINOR(res.a0));
> +}
> +
> +void *board_fdt_blob_setup(int *err)
> +{
> +       phys_addr_t fdt;
> +       /* Return DTB pointer passed by ABL */
> +       *err = 0;
> +       fdt = get_prev_bl_fdt_addr();
> +
> +       /*
> +        * If we bail then the board will simply not boot, instead let's
> +        * try and use the FDT built into U-Boot if there is one...
> +        * This avoids having a hard dependency on the previous stage bootloader
> +        */
> +       if (IS_ENABLED(CONFIG_OF_SEPARATE) && (!fdt || fdt != ALIGN(fdt, SZ_4K))) {
> +               debug("%s: Using built in FDT, bootloader gave us %#llx\n", __func__, fdt);
> +               return (void *)gd->fdt_blob;
> +       }
> +
> +       return (void *)fdt;
> +}
> +
> +void reset_cpu(void)
> +{
> +       psci_system_reset();
> +}
> +
> +/*
> + * Some Qualcomm boards require GPIO configuration when switching USB modes.
> + * Support setting this configuration via pinctrl state.
> + */
> +int board_usb_init(int index, enum usb_init_type init)
> +{
> +       struct udevice *usb;
> +       int ret = 0;
> +
> +       /* USB device */
> +       ret = uclass_find_device_by_seq(UCLASS_USB, index, &usb);
> +       if (ret) {
> +               printf("Cannot find USB device\n");
> +               return ret;
> +       }
> +
> +       ret = dev_read_stringlist_search(usb, "pinctrl-names",
> +                                        "device");
> +       /* No "device" pinctrl state, so just bail */
> +       if (ret < 0)
> +               return 0;
> +
> +       /* Select "default" or "device" pinctrl */
> +       switch (init) {
> +       case USB_INIT_HOST:
> +               pinctrl_select_state(usb, "default");
> +               break;
> +       case USB_INIT_DEVICE:
> +               pinctrl_select_state(usb, "device");
> +               break;
> +       default:
> +               debug("Unknown usb_init_type %d\n", init);
> +               break;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * Some boards still need board specific init code, they can implement that by
> + * overriding this function.
> + *
> + * FIXME: get rid of board specific init code
> + */
> +void __weak qcom_board_init(void)
> +{
> +}
> +
> +int board_init(void)
> +{
> +       show_psci_version();
> +       qcom_board_init();
> +       return 0;
> +}
> +
> +static void build_mem_map(void)
> +{
> +       int i;
> +
> +       /*
> +        * Ensure the peripheral block is sized to correctly cover the address range
> +        * up to the first memory bank.
> +        * Don't map the first page to ensure that we actually trigger an abort on a
> +        * null pointer access rather than just hanging.
> +        * FIXME: we should probably split this into more precise regions
> +        */
> +       mem_map[0].phys = 0x1000;
> +       mem_map[0].virt = mem_map[0].phys;
> +       mem_map[0].size = gd->bd->bi_dram[0].start - mem_map[0].phys;
> +       mem_map[0].attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN;
> +
> +       debug("Configured memory map:\n");
> +       debug("  0x%016llx - 0x%016llx: Peripheral block\n",
> +             mem_map[0].phys, mem_map[0].phys + mem_map[0].size);
> +
> +       /*
> +        * Now add memory map entries for each DRAM bank, ensuring we don't
> +        * overwrite the list terminator
> +        */
> +       for (i = 0; i < ARRAY_SIZE(rbx_mem_map) - 2 && gd->bd->bi_dram[i].size; i++) {
> +               if (i == ARRAY_SIZE(rbx_mem_map) - 1) {
> +                       log_warning("Too many DRAM banks!\n");
> +                       break;
> +               }
> +               mem_map[i + 1].phys = gd->bd->bi_dram[i].start;
> +               mem_map[i + 1].virt = mem_map[i + 1].phys;
> +               mem_map[i + 1].size = gd->bd->bi_dram[i].size;
> +               mem_map[i + 1].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +                                    PTE_BLOCK_INNER_SHARE;
> +
> +               debug("  0x%016llx - 0x%016llx: DDR bank %d\n",
> +                     mem_map[i + 1].phys, mem_map[i + 1].phys + mem_map[i + 1].size, i);
> +       }
> +}
> +
> +u64 get_page_table_size(void)
> +{
> +       return SZ_64K;
> +}
> +
> +void enable_caches(void)
> +{
> +       build_mem_map();
> +
> +       icache_enable();
> +       dcache_enable();
> +}
> diff --git a/arch/arm/mach-snapdragon/init_sdm845.c b/arch/arm/mach-snapdragon/init_sdm845.c
> deleted file mode 100644
> index 067acc9a6f44..000000000000
> --- a/arch/arm/mach-snapdragon/init_sdm845.c
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Common init part for boards based on SDM845
> - *
> - * (C) Copyright 2021 Dzmitry Sankouski <dsankouski@gmail.com>
> - */
> -
> -#include <button.h>
> -#include <init.h>
> -#include <env.h>
> -#include <common.h>
> -#include <asm/system.h>
> -#include <asm/gpio.h>
> -#include <dm.h>
> -
> -DECLARE_GLOBAL_DATA_PTR;
> -
> -int dram_init(void)
> -{
> -       return fdtdec_setup_mem_size_base();
> -}
> -
> -void reset_cpu(void)
> -{
> -       psci_system_reset();
> -}
> -
> -__weak int board_init(void)
> -{
> -       return 0;
> -}
> -
> -/* Check for vol- and power buttons */
> -__weak int misc_init_r(void)
> -{
> -       struct udevice *btn;
> -       int ret;
> -       enum button_state_t state;
> -
> -       ret = button_get_by_label("pwrkey", &btn);
> -       if (ret < 0) {
> -               printf("Couldn't find power button!\n");
> -               return ret;
> -       }
> -
> -       state = button_get_state(btn);
> -       if (state == BUTTON_ON) {
> -               env_set("key_power", "1");
> -               printf("Power button pressed\n");
> -       } else {
> -               env_set("key_power", "0");
> -       }
> -
> -       /*
> -        * search for kaslr address, set by primary bootloader by searching first
> -        * 0x100 relocated bytes at u-boot's initial load address range
> -        */
> -       uintptr_t start = gd->ram_base;
> -       uintptr_t end = start + 0x800000;
> -       u8 *addr = (u8 *)start;
> -       phys_addr_t *relocaddr = (phys_addr_t *)gd->relocaddr;
> -       u32 block_size = 0x1000;
> -
> -       while (memcmp(addr, relocaddr, 0x100) && (uintptr_t)addr < end)
> -               addr += block_size;
> -
> -       if ((uintptr_t)addr >= end)
> -               printf("KASLR not found in range 0x%lx - 0x%lx", start, end);
> -       else
> -               env_set_addr("KASLR", addr);
> -
> -       return 0;
> -}
> diff --git a/arch/arm/mach-snapdragon/sysmap-apq8016.c b/arch/arm/mach-snapdragon/sysmap-apq8016.c
> deleted file mode 100644
> index ffa3f9aa3532..000000000000
> --- a/arch/arm/mach-snapdragon/sysmap-apq8016.c
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Qualcomm APQ8016 memory map
> - *
> - * (C) Copyright 2016 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
> - */
> -
> -#include <common.h>
> -#include <asm/armv8/mmu.h>
> -
> -static struct mm_region apq8016_mem_map[] = {
> -       {
> -               .virt = 0x0UL, /* Peripheral block */
> -               .phys = 0x0UL, /* Peripheral block */
> -               .size = 0x8000000UL,
> -               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> -                        PTE_BLOCK_NON_SHARE |
> -                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> -       }, {
> -               .virt = 0x80000000UL, /* DDR */
> -               .phys = 0x80000000UL, /* DDR */
> -               .size = 0x80000000UL,
> -               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> -                        PTE_BLOCK_INNER_SHARE
> -       }, {
> -               /* List terminator */
> -               0,
> -       }
> -};
> -
> -struct mm_region *mem_map = apq8016_mem_map;
> diff --git a/arch/arm/mach-snapdragon/sysmap-apq8096.c b/arch/arm/mach-snapdragon/sysmap-apq8096.c
> deleted file mode 100644
> index 0614f8308d02..000000000000
> --- a/arch/arm/mach-snapdragon/sysmap-apq8096.c
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Qualcomm APQ8096 memory map
> - *
> - * (C) Copyright 2017 Jorge Ramirez Ortiz <jorge.ramirez-ortiz@linaro.org>
> - */
> -
> -#include <common.h>
> -#include <asm/armv8/mmu.h>
> -
> -static struct mm_region apq8096_mem_map[] = {
> -       {
> -               .virt = 0x0UL, /* Peripheral block */
> -               .phys = 0x0UL, /* Peripheral block */
> -               .size = 0x10000000UL,
> -               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> -                        PTE_BLOCK_NON_SHARE |
> -                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> -       }, {
> -               .virt = 0x80000000UL, /* DDR */
> -               .phys = 0x80000000UL, /* DDR */
> -               .size = 0xC0000000UL,
> -               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> -                        PTE_BLOCK_INNER_SHARE
> -       }, {
> -               /* List terminator */
> -               0,
> -       }
> -};
> -
> -struct mm_region *mem_map = apq8096_mem_map;
> diff --git a/arch/arm/mach-snapdragon/sysmap-qcs404.c b/arch/arm/mach-snapdragon/sysmap-qcs404.c
> deleted file mode 100644
> index 64ca4adf1bd1..000000000000
> --- a/arch/arm/mach-snapdragon/sysmap-qcs404.c
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Qualcomm QCS404 memory map
> - *
> - * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
> - */
> -
> -#include <common.h>
> -#include <asm/armv8/mmu.h>
> -
> -static struct mm_region qcs404_mem_map[] = {
> -       {
> -               .virt = 0x0UL, /* Peripheral block */
> -               .phys = 0x0UL, /* Peripheral block */
> -               .size = 0x8000000UL,
> -               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> -                        PTE_BLOCK_NON_SHARE |
> -                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> -       }, {
> -               .virt = 0x80000000UL, /* DDR */
> -               .phys = 0x80000000UL, /* DDR */
> -               .size = 0x05900000UL,
> -               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> -                        PTE_BLOCK_INNER_SHARE
> -       }, {
> -               .virt = 0x89600000UL, /* DDR */
> -               .phys = 0x89600000UL, /* DDR */
> -               .size = 0x162000000UL,
> -               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> -                        PTE_BLOCK_INNER_SHARE
> -       }, {
> -               .virt = 0xa0000000UL, /* DDR */
> -               .phys = 0xa0000000UL, /* DDR */
> -               .size = 0x20000000UL,
> -               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> -                        PTE_BLOCK_INNER_SHARE
> -       }, {
> -               /* List terminator */
> -               0,
> -       }
> -};
> -
> -struct mm_region *mem_map = qcs404_mem_map;
> diff --git a/arch/arm/mach-snapdragon/sysmap-sdm845.c b/arch/arm/mach-snapdragon/sysmap-sdm845.c
> deleted file mode 100644
> index 721ac411665c..000000000000
> --- a/arch/arm/mach-snapdragon/sysmap-sdm845.c
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Qualcomm SDM845 memory map
> - *
> - * (C) Copyright 2021 Dzmitry Sankouski <dsankousk@gmail.com>
> - */
> -
> -#include <common.h>
> -#include <asm/armv8/mmu.h>
> -
> -static struct mm_region sdm845_mem_map[] = {
> -       {
> -               .virt = 0x0UL, /* Peripheral block */
> -               .phys = 0x0UL, /* Peripheral block */
> -               .size = 0x10000000UL,
> -               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> -                        PTE_BLOCK_NON_SHARE |
> -                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> -       }, {
> -               .virt = 0x80000000UL, /* DDR */
> -               .phys = 0x80000000UL, /* DDR */
> -               .size = 0x200000000UL, /* 8GiB - maximum allowed memory */
> -               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> -                        PTE_BLOCK_INNER_SHARE
> -       }, {
> -               /* List terminator */
> -               0,
> -       }
> -};
> -
> -struct mm_region *mem_map = sdm845_mem_map;
> diff --git a/board/qualcomm/dragonboard410c/Kconfig b/board/qualcomm/dragonboard410c/Kconfig
> deleted file mode 100644
> index 03bd7ae309cd..000000000000
> --- a/board/qualcomm/dragonboard410c/Kconfig
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -if TARGET_DRAGONBOARD410C
> -
> -config SYS_BOARD
> -       default "dragonboard410c"
> -
> -config SYS_VENDOR
> -       default "qualcomm"
> -
> -config SYS_SOC
> -       default "apq8016"
> -
> -config SYS_CONFIG_NAME
> -       default "dragonboard410c"
> -
> -endif
> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
> index 40b5448c6ef1..0136cc2237de 100644
> --- a/board/qualcomm/dragonboard410c/dragonboard410c.c
> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
> @@ -23,37 +23,6 @@
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> -#define USB_HUB_RESET_GPIO 2
> -#define USB_SW_SELECT_GPIO 3
> -
> -int board_usb_init(int index, enum usb_init_type init)
> -{
> -       struct udevice *usb;
> -       int ret = 0;
> -
> -       /* USB device */
> -       ret = device_find_global_by_ofnode(ofnode_path("/soc/usb"), &usb);
> -       if (ret) {
> -               printf("Cannot find USB device\n");
> -               return ret;
> -       }
> -
> -       /* Select "default" or "device" pinctrl */
> -       switch (init) {
> -       case USB_INIT_HOST:
> -               pinctrl_select_state(usb, "default");
> -               break;
> -       case USB_INIT_DEVICE:
> -               pinctrl_select_state(usb, "device");
> -               break;
> -       default:
> -               debug("Unknown usb_init_type %d\n", init);
> -               break;
> -       }
> -
> -       return 0;
> -}
> -
>  /* UNSTUFF_BITS macro taken from Linux Kernel: drivers/mmc/core/sd.c */
>  #define UNSTUFF_BITS(resp, start, size) \
>         ({ \
> @@ -119,11 +88,6 @@ int misc_init_r(void)
>         return 0;
>  }
>
> -int board_init(void)
> -{
> -       return 0;
> -}
> -
>  int board_late_init(void)
>  {
>         char serial[16];
> @@ -166,8 +130,3 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>                            "local-bd-address", mac, ARP_HLEN, 1);
>         return 0;
>  }
> -
> -void reset_cpu(void)
> -{
> -       psci_system_reset();
> -}
> diff --git a/board/qualcomm/dragonboard820c/Kconfig b/board/qualcomm/dragonboard820c/Kconfig
> deleted file mode 100644
> index aff9af527128..000000000000
> --- a/board/qualcomm/dragonboard820c/Kconfig
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -if TARGET_DRAGONBOARD820C
> -
> -config SYS_BOARD
> -       default "dragonboard820c"
> -
> -config SYS_VENDOR
> -       default "qualcomm"
> -
> -config SYS_SOC
> -       default "apq8096"
> -
> -config SYS_CONFIG_NAME
> -       default "dragonboard820c"
> -
> -endif
> diff --git a/board/qualcomm/dragonboard820c/dragonboard820c.c b/board/qualcomm/dragonboard820c/dragonboard820c.c
> index 2f0db628368b..ac7de711c588 100644
> --- a/board/qualcomm/dragonboard820c/dragonboard820c.c
> +++ b/board/qualcomm/dragonboard820c/dragonboard820c.c
> @@ -27,24 +27,6 @@
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> -int dram_init(void)
> -{
> -       gd->ram_size = PHYS_SDRAM_SIZE;
> -
> -       return 0;
> -}
> -
> -int dram_init_banksize(void)
> -{
> -       gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
> -       gd->bd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
> -
> -       gd->bd->bi_dram[1].start = PHYS_SDRAM_2;
> -       gd->bd->bi_dram[1].size  = PHYS_SDRAM_2_SIZE;
> -
> -       return 0;
> -}
> -
>  static void sdhci_power_init(void)
>  {
>         const u32 TLMM_PULL_MASK = 0x3;
> @@ -113,28 +95,9 @@ static void sdhci_power_init(void)
>                         rclk[i].val  << rclk[i].bit);
>  }
>
> -static void show_psci_version(void)
> -{
> -       struct arm_smccc_res res;
> -
> -       arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
> -
> -       printf("PSCI:  v%ld.%ld\n",
> -              PSCI_VERSION_MAJOR(res.a0),
> -               PSCI_VERSION_MINOR(res.a0));
> -}
> -
> -int board_init(void)
> +void qcom_board_init(void)
>  {
>         sdhci_power_init();
> -       show_psci_version();
> -
> -       return 0;
> -}
> -
> -void reset_cpu(void)
> -{
> -       psci_system_reset();
>  }
>
>  /* Check for vol- button - if pressed - stop autoboot */
> diff --git a/board/qualcomm/dragonboard845c/Kconfig b/board/qualcomm/dragonboard845c/Kconfig
> deleted file mode 100644
> index 52fdff288d59..000000000000
> --- a/board/qualcomm/dragonboard845c/Kconfig
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -if TARGET_DRAGONBOARD845C
> -
> -config SYS_BOARD
> -       default "dragonboard845c"
> -
> -config SYS_CONFIG_NAME
> -       default "dragonboard845c"
> -
> -config SYS_VENDOR
> -       default "qualcomm"
> -
> -endif
> diff --git a/board/qualcomm/qcs404-evb/Kconfig b/board/qualcomm/qcs404-evb/Kconfig
> deleted file mode 100644
> index 32657c7d5e31..000000000000
> --- a/board/qualcomm/qcs404-evb/Kconfig
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -if TARGET_QCS404EVB
> -
> -config SYS_BOARD
> -       default "qcs404-evb"
> -
> -config SYS_VENDOR
> -       default "qualcomm"
> -
> -config SYS_SOC
> -       default "qcs404"
> -
> -config SYS_CONFIG_NAME
> -       default "qcs404-evb"
> -
> -endif
> diff --git a/board/qualcomm/qcs404-evb/qcs404-evb.c b/board/qualcomm/qcs404-evb/qcs404-evb.c
> index 249dca7e72f1..1a4b1f97a3ae 100644
> --- a/board/qualcomm/qcs404-evb/qcs404-evb.c
> +++ b/board/qualcomm/qcs404-evb/qcs404-evb.c
> @@ -14,16 +14,10 @@
>  #include <asm/gpio.h>
>  #include <asm/global_data.h>
>  #include <fdt_support.h>
> -#include <asm/arch/dram.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> -int dram_init(void)
> -{
> -       return fdtdec_setup_mem_size_base();
> -}
> -
> -int board_init(void)
> +void qcom_board_init(void)
>  {
>         struct udevice *pmic_gpio;
>         struct gpio_desc usb_vbus_boost_pin;
> @@ -34,29 +28,22 @@ int board_init(void)
>                                         &pmic_gpio);
>         if (ret < 0) {
>                 printf("Failed to find pms405_gpios@c000 node.\n");
> -               return ret;
> +               return;
>         }
>
>         node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pmic_gpio),
>                                   "usb_vbus_boost_pin");
>         if (node < 0) {
>                 printf("Failed to find usb_hub_reset_pm dt node.\n");
> -               return node;
> +               return;
>         }
>         ret = gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
>                                          &usb_vbus_boost_pin, 0);
>         if (ret < 0) {
>                 printf("Failed to request usb_hub_reset_pm gpio.\n");
> -               return ret;
> +               return;
>         }
>
>         dm_gpio_set_dir_flags(&usb_vbus_boost_pin,
>                               GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> -
> -       return 0;
> -}
> -
> -void reset_cpu(void)
> -{
> -       psci_system_reset();
>  }
> diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
> index 56a73893d3df..efdee8a40fa3 100644
> --- a/configs/dragonboard410c_defconfig
> +++ b/configs/dragonboard410c_defconfig
> @@ -1,9 +1,10 @@
>  CONFIG_ARM=y
> +CONFIG_SYS_BOARD="dragonboard410c"
>  CONFIG_COUNTER_FREQUENCY=19000000
> +CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
>  CONFIG_ARCH_SNAPDRAGON=y
>  CONFIG_TEXT_BASE=0x8f600000
>  CONFIG_SYS_MALLOC_LEN=0x802000
> -CONFIG_NR_DRAM_BANKS=1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x8007fff0
>  CONFIG_ENV_SIZE=0x2000
> @@ -38,7 +39,9 @@ CONFIG_CMD_TIMER=y
>  CONFIG_ENV_IS_IN_MMC=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_SYS_MMC_ENV_PART=2
> +CONFIG_BUTTON_QCOM_PMIC=y
>  CONFIG_CLK=y
> +CONFIG_CLK_QCOM_APQ8016=y
>  CONFIG_USB_FUNCTION_FASTBOOT=y
>  CONFIG_FASTBOOT_BUF_ADDR=0x91000000
>  CONFIG_FASTBOOT_FLASH=y
> @@ -52,6 +55,7 @@ CONFIG_MMC_SDHCI_MSM=y
>  CONFIG_PHY=y
>  CONFIG_PINCTRL=y
>  CONFIG_PINCONF=y
> +CONFIG_PINCTRL_QCOM_APQ8016=y
>  CONFIG_DM_PMIC=y
>  CONFIG_PMIC_QCOM=y
>  CONFIG_MSM_SERIAL=y
> diff --git a/configs/dragonboard820c_defconfig b/configs/dragonboard820c_defconfig
> index 7304ff97dd8e..89847ce0b307 100644
> --- a/configs/dragonboard820c_defconfig
> +++ b/configs/dragonboard820c_defconfig
> @@ -1,14 +1,13 @@
>  CONFIG_ARM=y
> +CONFIG_SYS_BOARD="dragonboard820c"
>  CONFIG_COUNTER_FREQUENCY=19000000
>  CONFIG_ARCH_SNAPDRAGON=y
>  CONFIG_TEXT_BASE=0x80080000
>  CONFIG_SYS_MALLOC_LEN=0x804000
> -CONFIG_NR_DRAM_BANKS=2
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x8007fff0
>  CONFIG_ENV_SIZE=0x4000
>  CONFIG_DEFAULT_DEVICE_TREE="dragonboard820c"
> -CONFIG_TARGET_DRAGONBOARD820C=y
>  CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 820C"
>  CONFIG_SYS_LOAD_ADDR=0x80080000
>  CONFIG_DISTRO_DEFAULTS=y
> @@ -35,12 +34,15 @@ CONFIG_ENV_IS_IN_EXT4=y
>  CONFIG_ENV_EXT4_INTERFACE="mmc"
>  CONFIG_ENV_EXT4_DEVICE_AND_PART="0:1"
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_BUTTON_QCOM_PMIC=y
>  CONFIG_CLK=y
> +CONFIG_CLK_QCOM_APQ8096=y
>  CONFIG_QCOM_PMIC_GPIO=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_MSM=y
>  CONFIG_PINCTRL=y
>  CONFIG_PINCONF=y
> +CONFIG_PINCTRL_QCOM_APQ8096=y
>  CONFIG_DM_PMIC=y
>  CONFIG_PMIC_QCOM=y
>  CONFIG_MSM_SERIAL=y
> diff --git a/configs/dragonboard845c_defconfig b/configs/dragonboard845c_defconfig
> deleted file mode 100644
> index f29f11e342e7..000000000000
> --- a/configs/dragonboard845c_defconfig
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -CONFIG_ARM=y
> -CONFIG_SKIP_LOWLEVEL_INIT=y
> -CONFIG_COUNTER_FREQUENCY=19000000
> -CONFIG_POSITION_INDEPENDENT=y
> -CONFIG_ARCH_SNAPDRAGON=y
> -CONFIG_DEFAULT_DEVICE_TREE="dragonboard845c"
> -CONFIG_TARGET_DRAGONBOARD845C=y
> -CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 845C"
> -CONFIG_SYS_LOAD_ADDR=0x80000000
> -CONFIG_FIT=y
> -CONFIG_FIT_VERBOSE=y
> -CONFIG_BOOTDELAY=5
> -CONFIG_SAVE_PREV_BL_FDT_ADDR=y
> -CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
> -CONFIG_SYS_CBSIZE=512
> -# CONFIG_DISPLAY_CPUINFO is not set
> -CONFIG_HUSH_PARSER=y
> -CONFIG_SYS_MAXARGS=64
> -CONFIG_CMD_GPIO=y
> -# CONFIG_NET is not set
> -CONFIG_CLK=y
> -CONFIG_MSM_GPIO=y
> -CONFIG_QCOM_PMIC_GPIO=y
> -CONFIG_PINCTRL=y
> -CONFIG_DM_PMIC=y
> -CONFIG_PMIC_QCOM=y
> -CONFIG_MSM_GENI_SERIAL=y
> -CONFIG_SPMI_MSM=y
> -CONFIG_LMB_MAX_REGIONS=64
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> new file mode 100644
> index 000000000000..a84f5aee444e
> --- /dev/null
> +++ b/configs/qcom_defconfig
> @@ -0,0 +1,67 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_POSITION_INDEPENDENT=y
> +CONFIG_ARCH_SNAPDRAGON=y
> +CONFIG_DEFAULT_DEVICE_TREE="dragonboard845c"
> +CONFIG_SYS_LOAD_ADDR=0x0
> +CONFIG_BUTTON_CMD=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_BOOTSTD_FULL=y
> +# CONFIG_BOOTMETH_VBE is not set
> +CONFIG_BOOTDELAY=1
> +CONFIG_USE_PREBOOT=y
> +CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
> +CONFIG_SYS_CBSIZE=512
> +CONFIG_LOG_MAX_LEVEL=9
> +CONFIG_LOG_DEFAULT_LEVEL=4
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_CMD_BOOTMENU=y
> +CONFIG_CMD_CLK=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_UFS=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_CAT=y
> +CONFIG_CMD_BMP=y
> +CONFIG_CMD_LOG=y
> +# CONFIG_NET is not set
> +CONFIG_BUTTON_QCOM_PMIC=y
> +CONFIG_CLK=y
> +CONFIG_CLK_QCOM_QCS404=y
> +CONFIG_CLK_QCOM_SDM845=y
> +CONFIG_MSM_GPIO=y
> +CONFIG_QCOM_PMIC_GPIO=y
> +CONFIG_DM_KEYBOARD=y
> +CONFIG_BUTTON_KEYBOARD=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ADMA=y
> +CONFIG_MMC_SDHCI_MSM=y
> +CONFIG_PHY=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_QCOM_QCS404=y
> +CONFIG_PINCTRL_QCOM_SDM845=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_QCOM=y
> +CONFIG_SCSI=y
> +CONFIG_MSM_SERIAL=y
> +CONFIG_MSM_GENI_SERIAL=y
> +CONFIG_SPMI_MSM=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSINFO_SMBIOS=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y
> +CONFIG_USB_DWC3=y
> +CONFIG_UFS=y
> +CONFIG_VIDEO=y
> +# CONFIG_VIDEO_FONT_8X16 is not set
> +CONFIG_VIDEO_FONT_16X32=y
> +CONFIG_SYS_WHITE_ON_BLACK=y
> +CONFIG_NO_FB_CLEAR=y
> +CONFIG_VIDEO_SIMPLE=y
> +CONFIG_HEXDUMP=y
> +# CONFIG_GENERATE_SMBIOS_TABLE is not set
> +CONFIG_LMB_MAX_REGIONS=64
> diff --git a/configs/qcs404evb_defconfig b/configs/qcs404evb_defconfig
> index 700c024e8b6a..d85d193895b0 100644
> --- a/configs/qcs404evb_defconfig
> +++ b/configs/qcs404evb_defconfig
> @@ -1,11 +1,10 @@
>  CONFIG_ARM=y
> +CONFIG_SYS_BOARD="qcs404-evb"
>  CONFIG_SKIP_LOWLEVEL_INIT=y
>  CONFIG_COUNTER_FREQUENCY=19000000
>  CONFIG_POSITION_INDEPENDENT=y
>  CONFIG_ARCH_SNAPDRAGON=y
>  CONFIG_DEFAULT_DEVICE_TREE="qcs404-evb"
> -CONFIG_DM_RESET=y
> -CONFIG_TARGET_QCS404EVB=y
>  CONFIG_IDENT_STRING="\nQualcomm QCS404-EVB"
>  CONFIG_SYS_LOAD_ADDR=0x80000000
>  CONFIG_FIT=y
> @@ -31,6 +30,7 @@ CONFIG_CMD_FAT=y
>  CONFIG_CMD_FS_GENERIC=y
>  # CONFIG_NET is not set
>  CONFIG_CLK=y
> +CONFIG_CLK_QCOM_QCS404=y
>  CONFIG_MSM_GPIO=y
>  CONFIG_QCOM_PMIC_GPIO=y
>  CONFIG_MISC=y
> @@ -42,6 +42,7 @@ CONFIG_PHY=y
>  CONFIG_PHY_QCOM_USB_HS_28NM=y
>  CONFIG_PHY_QCOM_USB_SS=y
>  CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_QCOM_QCS404=y
>  CONFIG_DM_PMIC=y
>  CONFIG_PMIC_QCOM=y
>  CONFIG_MSM_SERIAL=y
> diff --git a/configs/starqltechn_defconfig b/configs/starqltechn_defconfig
> deleted file mode 100644
> index 6980a8232667..000000000000
> --- a/configs/starqltechn_defconfig
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -CONFIG_ARM=y
> -CONFIG_SKIP_LOWLEVEL_INIT=y
> -CONFIG_COUNTER_FREQUENCY=19000000
> -CONFIG_POSITION_INDEPENDENT=y
> -CONFIG_ARCH_SNAPDRAGON=y
> -CONFIG_DEFAULT_DEVICE_TREE="starqltechn"
> -CONFIG_TARGET_STARQLTECHN=y
> -CONFIG_IDENT_STRING="\nSamsung S9 SM-G9600"
> -CONFIG_SYS_LOAD_ADDR=0x80000000
> -CONFIG_FIT=y
> -CONFIG_FIT_VERBOSE=y
> -CONFIG_BOOTDELAY=0
> -CONFIG_SAVE_PREV_BL_FDT_ADDR=y
> -CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
> -CONFIG_SYS_CBSIZE=512
> -CONFIG_SYS_PBSIZE=532
> -# CONFIG_DISPLAY_CPUINFO is not set
> -CONFIG_HUSH_PARSER=y
> -CONFIG_SYS_MAXARGS=64
> -CONFIG_CMD_BOOTMENU=y
> -CONFIG_CMD_GPIO=y
> -CONFIG_CMD_BMP=y
> -# CONFIG_NET is not set
> -CONFIG_BUTTON=y
> -CONFIG_CLK=y
> -CONFIG_MSM_GPIO=y
> -CONFIG_QCOM_PMIC_GPIO=y
> -CONFIG_DM_KEYBOARD=y
> -CONFIG_BUTTON_KEYBOARD=y
> -CONFIG_PINCTRL=y
> -CONFIG_DM_PMIC=y
> -CONFIG_PMIC_QCOM=y
> -CONFIG_MSM_GENI_SERIAL=y
> -CONFIG_SPMI_MSM=y
> -CONFIG_VIDEO=y
> -# CONFIG_VIDEO_FONT_8X16 is not set
> -CONFIG_VIDEO_FONT_16X32=y
> -CONFIG_SYS_WHITE_ON_BLACK=y
> -CONFIG_VIDEO_SIMPLE=y
> -CONFIG_VIDEO_DT_SIMPLEFB=y
> -CONFIG_LMB_MAX_REGIONS=64
> diff --git a/include/configs/dragonboard845c.h b/include/configs/dragonboard845c.h
> deleted file mode 100644
> index 14a8a2ca049e..000000000000
> --- a/include/configs/dragonboard845c.h
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Configuration file for Dragonboard 845c, based on Qualcomm SDA845 chip
> - *
> - * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
> - */
> -
> -#ifndef __CONFIGS_SDM845_H
> -#define __CONFIGS_SDM845_H
> -
> -#include <linux/sizes.h>
> -
> -#define CFG_SYS_BAUDRATE_TABLE { 115200, 230400, 460800, 921600 }
> -
> -#define CFG_EXTRA_ENV_SETTINGS \
> -       "bootm_size=0x5000000\0"        \
> -       "bootm_low=0x80000000\0"        \
> -       "bootcmd=bootm $prevbl_initrd_start_addr\0"
> -
> -#endif
> diff --git a/include/configs/qcom.h b/include/configs/qcom.h
> new file mode 100644
> index 000000000000..e50b3bce5cdd
> --- /dev/null
> +++ b/include/configs/qcom.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Configuration file for Qualcomm Snapdragon boards
> + *
> + * (C) Copyright 2021 Dzmitry Sankouski <dsankouski@gmail.com>
> + * (C) Copyright 2023 Linaro Ltd.
> + */
> +
> +#ifndef __CONFIGS_SNAPDRAGON_H
> +#define __CONFIGS_SNAPDRAGON_H
> +
> +#define CFG_SYS_BAUDRATE_TABLE { 115200, 230400, 460800, 921600 }
> +
> +/* Load addressed are calculated during board_late_init(). See arm/mach-snapdragon/board.c */
> +#define CFG_EXTRA_ENV_SETTINGS \
> +       "stdin=serial,button-kbd\0"     \
> +       "stdout=serial,vidconsole\0"    \
> +       "stderr=serial,vidconsole\0" \
> +       "bootcmd=bootm $prevbl_initrd_start_addr\0"
> +
> +#endif
> diff --git a/include/configs/qcs404-evb.h b/include/configs/qcs404-evb.h
> deleted file mode 100644
> index 9501d43665e9..000000000000
> --- a/include/configs/qcs404-evb.h
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Configuration file for QCS404 evaluation board
> - *
> - * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
> - */
> -
> -#ifndef __CONFIGS_QCS404EVB_H
> -#define __CONFIGS_QCS404EVB_H
> -
> -#include <linux/sizes.h>
> -
> -#define CFG_SYS_BAUDRATE_TABLE { 115200, 230400, 460800, 921600 }
> -
> -#define CFG_EXTRA_ENV_SETTINGS \
> -       "bootm_size=0x5000000\0"        \
> -       "bootm_low=0x80000000\0"        \
> -       "bootcmd=bootm $prevbl_initrd_start_addr\0"
> -
> -#endif
> diff --git a/include/configs/sdm845.h b/include/configs/sdm845.h
> deleted file mode 100644
> index 5ad8569b2152..000000000000
> --- a/include/configs/sdm845.h
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Configuration file for boards, based on Qualcomm SDM845 chip
> - *
> - * (C) Copyright 2021 Dzmitry Sankouski <dsankouski@gmail.com>
> - */
> -
> -#ifndef __CONFIGS_SDM845_H
> -#define __CONFIGS_SDM845_H
> -
> -#include <linux/sizes.h>
> -
> -#define CFG_SYS_BAUDRATE_TABLE { 115200, 230400, 460800, 921600 }
> -
> -#define CFG_EXTRA_ENV_SETTINGS \
> -       "bootm_size=0x4000000\0"        \
> -       "bootm_low=0x80000000\0"        \
> -       "stdin=serial,button-kbd\0"     \
> -       "stdout=serial,vidconsole\0"    \
> -       "stderr=serial,vidconsole\0"    \
> -       "preboot=source $prevbl_initrd_start_addr:prebootscript\0" \
> -       "bootcmd=source $prevbl_initrd_start_addr:bootscript\0"
> -
> -/* Size of malloc() pool */
> -
> -#endif
>
> --
> 2.43.1
>
