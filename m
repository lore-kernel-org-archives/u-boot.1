Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727DDC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 07:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2D76877B1;
	Fri, 22 Dec 2023 08:43:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WgzBa5Cg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C77F87801; Fri, 22 Dec 2023 08:43:31 +0100 (CET)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30E1A874AC
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 08:43:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4b68fefe9fcso416160e0c.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 23:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703231007; x=1703835807; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6gMjZVs1btGHY9KAACFaJzDhm3/RZmwambofWanonWA=;
 b=WgzBa5Cgtc+qAU/Bpb5ysD0rhYcMD2L08LIngv0UUpEh3fjb7BGy77CfJQqiLxgq6c
 lhOEaiHc1vN2Q35ltO+8KOPVUqpw4ybpqpNgeQKyY37j3vLdu8YrGAZauTtv9eUED7Pz
 cM4pJbf8JqJGE84h8uEjGOCk+vgs81YX04gAKu8XXgk5sq7Y+1CSt+Xll2IdRvaU7LZT
 2SY6nXKT6xEu39CaNCL7ZYilx96/0R2/Vnl5pOzCcfIRC2mVMNtkzpUHsPUVleHq5nzG
 WgszrTHUKrpPTeS2SQheXULg4NYv9FVSZ3lRO6TncugFiSadgvHOhwbhTlvSF+B6A9lu
 C1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703231007; x=1703835807;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6gMjZVs1btGHY9KAACFaJzDhm3/RZmwambofWanonWA=;
 b=kK2MjEqVi0vyZNV1wq5rAbRZJ7dMfEKvEh2GaR6DMCurUdIh0FXg9BMfj7HCmSEfm+
 NIEtc5k6BqClIwHEXn3YNCu0jwvClZQNRc3lOPQJD6yLJ+xZ6d1akdsJAxd8XPsTvlrw
 xLSeclx1/Olr0TxpT9vgy2OI0G1W0qEa5vjN+01BwwfI33U34Bvq9V4T/YRSG+QiRAzV
 qhFlZGnjwimfe6NCAcC59NpPKSw3y7AR79034PBAr9J2myFB5Tjs9/4VxKufyAmI43Ps
 5AL4OGetrhBBfFm/mTqPRZGo4Ty3UbNz4FebhSNovdMeheIL86JVhsjx/SiaG/gh7hNz
 R8pw==
X-Gm-Message-State: AOJu0YxVJ+YIY2EYIOFu79pvrgcbkTYa8Wu0mocuw+52BFYUOpnvrtzH
 eBxLhdHrzZbnjuPO6j+8uEFlhhIn96N47Ne1CH1q5FqIuHx6bg==
X-Google-Smtp-Source: AGHT+IEfWzQzRrDdiKbrLpGgtFKixm734dRMPIjffJ8cE2bH2YbL/Ft+b+43oibeY2cxI07M6iatLtysx1peiJ4Wwb8=
X-Received: by 2002:a05:6102:3eca:b0:466:125:464a with SMTP id
 n10-20020a0561023eca00b004660125464amr513540vsv.11.1703231006879; Thu, 21 Dec
 2023 23:43:26 -0800 (PST)
MIME-Version: 1.0
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-31-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-31-b6dd9704219e@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 22 Dec 2023 13:13:15 +0530
Message-ID: <CAFA6WYMHd9e9MtUmCu9zVjD4RqE4VRthgEC7GfbSWq=nwDkp+Q@mail.gmail.com>
Subject: Re: [PATCH v2 31/32] board: qcs404-evb: drop board code
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

Hi Caleb,

On Tue, 19 Dec 2023 at 21:34, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> This board is entirely supported by the generic arch code and DTS. The
> board code used to handle turning on the vbus regulator, however this is
> now handled via DT.
>
> With this, the board specific defconfig is also no longer needed, so
> drop it as well.

I would like to understand how the board specific bits are to be
handled going forward. One of the examples for QCS404 derived board
uses I2C eeprom to save the ethernet MAC address. How should one
configure that via this generic target?

Would you expect arch/arm/mach-snapdragon/board.c to hold that code?
Or we should have a separate defconfig and board support code for
that?

BTW, qcs404-evb does provide networking support but at the time when I
added its support the network port was broken. It may very well be the
case that someone tries to enable networking on qcs404-evb in the
future.

The same holds true for how we should add support for fastboot mode
entry on a button press when U-boot starts as a first stage
bootloader.

It's always good to see generalization coming in but that should come
with alternate methods to support existing board needs.

-Sumit

>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  board/qualcomm/qcs404-evb/Makefile     |  6 ----
>  board/qualcomm/qcs404-evb/qcs404-evb.c | 49 -----------------------------
>  configs/qcs404evb_defconfig            | 56 ----------------------------------
>  3 files changed, 111 deletions(-)
>
> diff --git a/board/qualcomm/qcs404-evb/Makefile b/board/qualcomm/qcs404-evb/Makefile
> deleted file mode 100644
> index 4665827e0859..000000000000
> --- a/board/qualcomm/qcs404-evb/Makefile
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -# (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
> -#
> -
> -obj-y += qcs404-evb.o
> diff --git a/board/qualcomm/qcs404-evb/qcs404-evb.c b/board/qualcomm/qcs404-evb/qcs404-evb.c
> deleted file mode 100644
> index 1a4b1f97a3ae..000000000000
> --- a/board/qualcomm/qcs404-evb/qcs404-evb.c
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Board init file for QCS404-EVB
> - *
> - * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
> - */
> -
> -#include <common.h>
> -#include <cpu_func.h>
> -#include <dm.h>
> -#include <env.h>
> -#include <init.h>
> -#include <asm/cache.h>
> -#include <asm/gpio.h>
> -#include <asm/global_data.h>
> -#include <fdt_support.h>
> -
> -DECLARE_GLOBAL_DATA_PTR;
> -
> -void qcom_board_init(void)
> -{
> -       struct udevice *pmic_gpio;
> -       struct gpio_desc usb_vbus_boost_pin;
> -       int ret, node;
> -
> -       ret = uclass_get_device_by_name(UCLASS_GPIO,
> -                                       "pms405_gpios@c000",
> -                                       &pmic_gpio);
> -       if (ret < 0) {
> -               printf("Failed to find pms405_gpios@c000 node.\n");
> -               return;
> -       }
> -
> -       node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pmic_gpio),
> -                                 "usb_vbus_boost_pin");
> -       if (node < 0) {
> -               printf("Failed to find usb_hub_reset_pm dt node.\n");
> -               return;
> -       }
> -       ret = gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
> -                                        &usb_vbus_boost_pin, 0);
> -       if (ret < 0) {
> -               printf("Failed to request usb_hub_reset_pm gpio.\n");
> -               return;
> -       }
> -
> -       dm_gpio_set_dir_flags(&usb_vbus_boost_pin,
> -                             GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> -}
> diff --git a/configs/qcs404evb_defconfig b/configs/qcs404evb_defconfig
> deleted file mode 100644
> index 7daaa449ffbd..000000000000
> --- a/configs/qcs404evb_defconfig
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -CONFIG_ARM=y
> -CONFIG_SYS_BOARD="qcs404-evb"
> -CONFIG_SKIP_LOWLEVEL_INIT=y
> -CONFIG_COUNTER_FREQUENCY=19000000
> -CONFIG_POSITION_INDEPENDENT=y
> -CONFIG_ARCH_SNAPDRAGON=y
> -CONFIG_DEFAULT_DEVICE_TREE="qcs404-evb"
> -CONFIG_IDENT_STRING="\nQualcomm QCS404-EVB"
> -CONFIG_SYS_LOAD_ADDR=0x80000000
> -CONFIG_FIT=y
> -CONFIG_FIT_VERBOSE=y
> -CONFIG_BOOTDELAY=5
> -CONFIG_USE_BOOTARGS=y
> -CONFIG_BOOTARGS="earlycon ignore_loglevel root= clk_ignore_unused"
> -CONFIG_SAVE_PREV_BL_FDT_ADDR=y
> -CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
> -# CONFIG_DISPLAY_CPUINFO is not set
> -CONFIG_HUSH_PARSER=y
> -CONFIG_SYS_MAXARGS=64
> -CONFIG_SYS_CBSIZE=512
> -CONFIG_CMD_GPIO=y
> -CONFIG_CMD_GPT=y
> -CONFIG_CMD_MMC=y
> -CONFIG_CMD_PART=y
> -CONFIG_CMD_USB=y
> -CONFIG_CMD_EXT2=y
> -CONFIG_CMD_EXT4=y
> -CONFIG_CMD_EXT4_WRITE=y
> -CONFIG_CMD_FAT=y
> -CONFIG_CMD_FS_GENERIC=y
> -# CONFIG_NET is not set
> -CONFIG_CLK=y
> -CONFIG_CLK_QCOM_QCS404=y
> -CONFIG_MSM_GPIO=y
> -CONFIG_QCOM_PMIC_GPIO=y
> -CONFIG_MISC=y
> -CONFIG_MMC_HS400_SUPPORT=y
> -CONFIG_MMC_SDHCI=y
> -CONFIG_MMC_SDHCI_ADMA=y
> -CONFIG_MMC_SDHCI_MSM=y
> -CONFIG_PHY=y
> -CONFIG_PHY_QCOM_USB_HS_28NM=y
> -CONFIG_PHY_QCOM_USB_SS=y
> -CONFIG_PINCTRL=y
> -CONFIG_PINCTRL_QCOM_QCS404=y
> -CONFIG_DM_PMIC=y
> -CONFIG_PMIC_QCOM=y
> -CONFIG_MSM_SERIAL=y
> -CONFIG_SPMI_MSM=y
> -CONFIG_USB=y
> -CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
> -CONFIG_USB_DWC3=y
> -CONFIG_USB_DWC3_GENERIC=y
> -CONFIG_USB_STORAGE=y
> -CONFIG_LMB_MAX_REGIONS=64
>
> --
> 2.42.1
>
