Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2107DC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F23A87F8C;
	Tue, 20 Feb 2024 14:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RH4g41sb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C45187FB2; Tue, 20 Feb 2024 14:48:01 +0100 (CET)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1AAE87F8C
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:47:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7d625a3ace6so3606016241.0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708436874; x=1709041674; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VmGIhxO59SLpouC2dMm8ijXBxyY7dHQBG/cTFp+irEs=;
 b=RH4g41sbTqHihSUkaZpvTvsA6qiHbHuihPSYI7JuNg4aKaMoWzy3wmXsyS247QfPz4
 lkZzbkXxRslMELgVlIYM2NJpH8NNdgEBkE2wPfHHZZhwvNVye2QdLx5OA49dNgwwOyB5
 t3xBm9TVbLZSezTFG+nszRQineF08fRdSf3y0UALoGZGN3wsTYwRQjzhEeNHD7cHGSb+
 rARgWkszsQB7pBGQiFdTh8tr0FGfBATsVZI/Tzjf2kD8htCPPv2Xaj3gdP7gDcPJ/WFE
 hFRPojSeK7w2x031mT8MBel12Dm2viqWhisaa4uMD3dk1ExLCGZLMNZMj/b9+BwYlPHW
 uGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708436874; x=1709041674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VmGIhxO59SLpouC2dMm8ijXBxyY7dHQBG/cTFp+irEs=;
 b=EL2u9NON5xCfgUTNT2Lr6G3v1pJzZxmH/F/YAMH7DytKKNxgHP5ahCkDeUQvyUp9aH
 5x4J6V92CQfZr6he8YiT/MDrUn7CzamVi9q28iYC+oH+i2OFtUUxu9Snh3DRafScpZaZ
 YKV8UIRWEX4JM7+UsNwXSEfD03Dih4afwF+Hm5pv4Pbmw6tjLRScWUf59kD+HBRqrEWR
 5wRZLghtZ54eyCGTfuzponETppjvjvlTIoixpD70xFb8b9+ODXrA1dNXhMd/k5Gnoev1
 tH7fi8x58xuWG6i97hr8U88yPJC/AN7ST0G9SeDsVBUFgzIMO7PR/dTkF1GRNDz2MpX8
 aJkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTwS/ryXUrCWNrGFtZpRc0iwTAzhUCMzEqxz2vp/sBjH8o24wCbOx3KVqpuvaprTK0EsLuulAbIwPuEn3rr93x9ZFJcg==
X-Gm-Message-State: AOJu0YwKuhloKUmd4uqxqqTHLfIwbvCHsNf/L4Em7ZUj36wV91fcp/fr
 CR5djuhp1Mj+gtS5vbiTJdpHHQAzrwxwPxFH4UXC8g4PsdOjXTQo7zMKDtPAu6VOA5mykkkFeWI
 Q/1hfHFp5ujmPXGTXf13d/WJPIifzRi5hHTLS6w==
X-Google-Smtp-Source: AGHT+IErhcYFiGP6ZYlqbnY3k9fRZm6Q02qSclDWUb5uM/qAtxSmci25wpME0nRW6qCef00sw2RXpDRaGOBPjb/npUA=
X-Received: by 2002:a67:fe4e:0:b0:470:5b27:dc82 with SMTP id
 m14-20020a67fe4e000000b004705b27dc82mr3690547vsr.8.1708436874622; Tue, 20 Feb
 2024 05:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-24-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-24-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 19:17:43 +0530
Message-ID: <CAFA6WYOiq7TFVjr0knd0vGk2GGGus7k2UrjLp=+5NfakERSv6Q@mail.gmail.com>
Subject: Re: [PATCH v4 24/39] board: qcs404-evb: drop board code
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
> This board is entirely supported by the generic arch code and DTS. The
> board code used to handle turning on the vbus regulator, however this is
> now handled via DT.
>
> With this, the board specific defconfig is also no longer needed, so
> drop it as well.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  board/qualcomm/qcs404-evb/Makefile     |  6 ----
>  board/qualcomm/qcs404-evb/qcs404-evb.c | 49 -----------------------------
>  configs/qcs404evb_defconfig            | 56 ----------------------------------
>  3 files changed, 111 deletions(-)
>

Glad to see qcs404 being supported by generic defconfig.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

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
> index d85d193895b0..000000000000
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
> -CONFIG_SYS_CBSIZE=512
> -# CONFIG_DISPLAY_CPUINFO is not set
> -CONFIG_HUSH_PARSER=y
> -CONFIG_SYS_MAXARGS=64
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
> 2.43.1
>
