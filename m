Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DF8C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 07:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B03887703;
	Fri,  3 Nov 2023 08:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N5Wy9PzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDC00875ED; Fri,  3 Nov 2023 08:22:39 +0100 (CET)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E85D687703
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 08:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-45845db2d63so768004137.3
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 00:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698996153; x=1699600953; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a4lWYGo+VSS4RgJtYsTjMsHPCX5NHTcGnnWg7hGMdOA=;
 b=N5Wy9PzNlEH16GL7McK8boZEQiJJfPHJdlWin0+rzjYZDOo77Lc+1Q5T+h9glCajPK
 E1YhCSSfSOS0oRDfHRAGgWHlBn90DqlpZKsTZCuQVBvGTpIGdXwDrkxzJyq2xfinfA9L
 Cok2sh1j7pIDbUuTARGETRFrA2KmvtkNmp42uxcUq0UI7JE0pSRScATKq7ufkJ+nJR8n
 bHUNFKTYEgdkbT5msoe/TM6876GUFBmU2cdmDEw5cf4J/ho/ng5hkorwLSFcBjt//Xel
 hZxDgHNmh99ZD2AD7o54u8iybh5nJjjAVw5cAYFU3W7ENNV7u4DHL71PCVl55BKlsFfl
 +Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698996153; x=1699600953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a4lWYGo+VSS4RgJtYsTjMsHPCX5NHTcGnnWg7hGMdOA=;
 b=KrwlFyI/GRXqDQXRkd+MRfYTAowsnBwkEiiPIjjK9mvNwrfe6cxzc734DB3UCzCUjI
 coN5CBstxLHyuR8d5LfIeRqWEOYrkaO3poNqsxztFx/HTpkLn9tjjiQwt2gPuuvKvSlR
 LIK5sRbjyeddW1IyH91V+mJn3E6GKXrfPH9gpJxP/oRSqm8zRfcwlhsPYSPkaPyNjIkq
 PWYul931phuWKGzLEMDvwklRz036rDXPeRZpgp6iZrZ/uK8SyHMGCTvxxaHAovOSrRwl
 Zv8c00At1hQq+eb0Y4H9Rz/gjjVDuZXjD1YOCWkg2rUU2vetuhj/IRS8c1/bSkkDqj4k
 syHw==
X-Gm-Message-State: AOJu0YzvnF00e4nRT++Jcga5d6m+5SefGwIyPHbd0nyKi2iyG+6UJ2Mo
 MvUzWOPiHcPejFtvq4D4k+EwavWWPsJT3XtnHEUWPg==
X-Google-Smtp-Source: AGHT+IF/f5COE8umyf/aScj7YiP5/NP6Qm76t6Q38Q4exRnjRbvibktd2rEqFKe+SFHryLqQekEwHeVwIVAXh190rOU=
X-Received: by 2002:a67:c004:0:b0:457:cd98:490b with SMTP id
 v4-20020a67c004000000b00457cd98490bmr21147151vsi.0.1698996153390; Fri, 03 Nov
 2023 00:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231025-b4-qcom-pinctrl-v1-0-9123d6a217eb@linaro.org>
 <20231025-b4-qcom-pinctrl-v1-5-9123d6a217eb@linaro.org>
In-Reply-To: <20231025-b4-qcom-pinctrl-v1-5-9123d6a217eb@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 3 Nov 2023 12:52:21 +0530
Message-ID: <CAFA6WYN1H=hy2o4wbPy=U1ORhANk1-JAtPXOb6j_xCqdpEfDWA@mail.gmail.com>
Subject: Re: [PATCH 5/6] pinctrl: qcom: move ipq4019 driver from mach-ipq40xx
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, u-boot@lists.denx.de
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

On Tue, 31 Oct 2023 at 19:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Drop the duplicated pinctrl-snapdragon driver from mach-ipq40xx and add
> it to drivers/pinctrl/qcom.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/Kconfig                                   |   1 +
>  arch/arm/mach-ipq40xx/Makefile                     |   8 -
>  arch/arm/mach-ipq40xx/pinctrl-snapdragon.c         | 166 ---------------------
>  arch/arm/mach-ipq40xx/pinctrl-snapdragon.h         |  30 ----
>  drivers/pinctrl/qcom/Kconfig                       |   7 +
>  drivers/pinctrl/qcom/Makefile                      |   1 +
>  .../pinctrl/qcom}/pinctrl-ipq4019.c                |  25 +++-
>  7 files changed, 28 insertions(+), 210 deletions(-)
>

I would expect this to be the 2nd patch in this series. Apart from
that feel free to add:

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index faccfaf720a8..23daed70aac9 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -767,6 +767,7 @@ config ARCH_IPQ40XX
>         select SMEM
>         select OF_CONTROL
>         select CLK_QCOM_IPQ4019
> +       select PINCTRL_QCOM_IPQ4019
>         imply CMD_DM
>
>  config ARCH_KEYSTONE
> diff --git a/arch/arm/mach-ipq40xx/Makefile b/arch/arm/mach-ipq40xx/Makefile
> deleted file mode 100644
> index b36a935c6f9f..000000000000
> --- a/arch/arm/mach-ipq40xx/Makefile
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -# Copyright (c) 2019 Sartura Ltd.
> -#
> -# Author: Robert Marko <robert.marko@sartura.hr>
> -
> -obj-y += pinctrl-snapdragon.o
> -obj-y += pinctrl-ipq4019.o
> diff --git a/arch/arm/mach-ipq40xx/pinctrl-snapdragon.c b/arch/arm/mach-ipq40xx/pinctrl-snapdragon.c
> deleted file mode 100644
> index 036fec93d727..000000000000
> --- a/arch/arm/mach-ipq40xx/pinctrl-snapdragon.c
> +++ /dev/null
> @@ -1,166 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * TLMM driver for Qualcomm IPQ40xx
> - *
> - * (C) Copyright 2018 Ramon Fried <ramon.fried@gmail.com>
> - *
> - * Copyright (c) 2020 Sartura Ltd.
> - *
> - * Author: Robert Marko <robert.marko@sartura.hr>
> - *
> - */
> -
> -#include <common.h>
> -#include <dm.h>
> -#include <errno.h>
> -#include <asm/io.h>
> -#include <dm/device_compat.h>
> -#include <dm/lists.h>
> -#include <dm/pinctrl.h>
> -#include <linux/bitops.h>
> -#include "pinctrl-snapdragon.h"
> -
> -struct msm_pinctrl_priv {
> -       phys_addr_t base;
> -       struct msm_pinctrl_data *data;
> -};
> -
> -#define GPIO_CONFIG_OFFSET(x)         ((x) * 0x1000)
> -#define TLMM_GPIO_PULL_MASK GENMASK(1, 0)
> -#define TLMM_FUNC_SEL_MASK GENMASK(5, 2)
> -#define TLMM_DRV_STRENGTH_MASK GENMASK(8, 6)
> -#define TLMM_GPIO_DISABLE BIT(9)
> -
> -static const struct pinconf_param msm_conf_params[] = {
> -       { "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 2 },
> -       { "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
> -       { "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 2 },
> -};
> -
> -static int msm_get_functions_count(struct udevice *dev)
> -{
> -       struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> -
> -       return priv->data->functions_count;
> -}
> -
> -static int msm_get_pins_count(struct udevice *dev)
> -{
> -       struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> -
> -       return priv->data->pin_count;
> -}
> -
> -static const char *msm_get_function_name(struct udevice *dev,
> -                                        unsigned int selector)
> -{
> -       struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> -
> -       return priv->data->get_function_name(dev, selector);
> -}
> -
> -static int msm_pinctrl_probe(struct udevice *dev)
> -{
> -       struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> -
> -       priv->base = devfdt_get_addr(dev);
> -       priv->data = (struct msm_pinctrl_data *)dev->driver_data;
> -
> -       return priv->base == FDT_ADDR_T_NONE ? -EINVAL : 0;
> -}
> -
> -static const char *msm_get_pin_name(struct udevice *dev, unsigned int selector)
> -{
> -       struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> -
> -       return priv->data->get_pin_name(dev, selector);
> -}
> -
> -static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
> -                         unsigned int func_selector)
> -{
> -       struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> -
> -       clrsetbits_le32(priv->base + GPIO_CONFIG_OFFSET(pin_selector),
> -                       TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE,
> -                       priv->data->get_function_mux(func_selector) << 2);
> -       return 0;
> -}
> -
> -static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
> -                          unsigned int param, unsigned int argument)
> -{
> -       struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> -
> -       switch (param) {
> -       case PIN_CONFIG_DRIVE_STRENGTH:
> -               clrsetbits_le32(priv->base + GPIO_CONFIG_OFFSET(pin_selector),
> -                               TLMM_DRV_STRENGTH_MASK, argument << 6);
> -               break;
> -       case PIN_CONFIG_BIAS_DISABLE:
> -               clrbits_le32(priv->base + GPIO_CONFIG_OFFSET(pin_selector),
> -                            TLMM_GPIO_PULL_MASK);
> -               break;
> -       case PIN_CONFIG_BIAS_PULL_UP:
> -               clrsetbits_le32(priv->base + GPIO_CONFIG_OFFSET(pin_selector),
> -                            TLMM_GPIO_PULL_MASK, argument);
> -               break;
> -       default:
> -               return 0;
> -       }
> -
> -       return 0;
> -}
> -
> -static int msm_pinctrl_bind(struct udevice *dev)
> -{
> -       ofnode node = dev_ofnode(dev);
> -       const char *name;
> -       int ret;
> -
> -       ofnode_get_property(node, "gpio-controller", &ret);
> -       if (ret < 0)
> -               return 0;
> -
> -       /* Get the name of gpio node */
> -       name = ofnode_get_name(node);
> -       if (!name)
> -               return -EINVAL;
> -
> -       /* Bind gpio node */
> -       ret = device_bind_driver_to_node(dev, "gpio_msm",
> -                                        name, node, NULL);
> -       if (ret)
> -               return ret;
> -
> -       dev_dbg(dev, "bind %s\n", name);
> -
> -       return 0;
> -}
> -
> -static struct pinctrl_ops msm_pinctrl_ops = {
> -       .get_pins_count = msm_get_pins_count,
> -       .get_pin_name = msm_get_pin_name,
> -       .set_state = pinctrl_generic_set_state,
> -       .pinmux_set = msm_pinmux_set,
> -       .pinconf_num_params = ARRAY_SIZE(msm_conf_params),
> -       .pinconf_params = msm_conf_params,
> -       .pinconf_set = msm_pinconf_set,
> -       .get_functions_count = msm_get_functions_count,
> -       .get_function_name = msm_get_function_name,
> -};
> -
> -static const struct udevice_id msm_pinctrl_ids[] = {
> -       { .compatible = "qcom,ipq4019-pinctrl", .data = (ulong)&ipq4019_data },
> -       { }
> -};
> -
> -U_BOOT_DRIVER(pinctrl_snapdraon) = {
> -       .name           = "pinctrl_msm",
> -       .id             = UCLASS_PINCTRL,
> -       .of_match       = msm_pinctrl_ids,
> -       .priv_auto      = sizeof(struct msm_pinctrl_priv),
> -       .ops            = &msm_pinctrl_ops,
> -       .probe          = msm_pinctrl_probe,
> -       .bind           = msm_pinctrl_bind,
> -};
> diff --git a/arch/arm/mach-ipq40xx/pinctrl-snapdragon.h b/arch/arm/mach-ipq40xx/pinctrl-snapdragon.h
> deleted file mode 100644
> index 2341a713495d..000000000000
> --- a/arch/arm/mach-ipq40xx/pinctrl-snapdragon.h
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Qualcomm Pin control
> - *
> - * (C) Copyright 2018 Ramon Fried <ramon.fried@gmail.com>
> - *
> - */
> -#ifndef _PINCTRL_SNAPDRAGON_H
> -#define _PINCTRL_SNAPDRAGON_H
> -
> -#include <common.h>
> -
> -struct msm_pinctrl_data {
> -       int pin_count;
> -       int functions_count;
> -       const char *(*get_function_name)(struct udevice *dev,
> -                                        unsigned int selector);
> -       unsigned int (*get_function_mux)(unsigned int selector);
> -       const char *(*get_pin_name)(struct udevice *dev,
> -                                   unsigned int selector);
> -};
> -
> -struct pinctrl_function {
> -       const char *name;
> -       int val;
> -};
> -
> -extern struct msm_pinctrl_data ipq4019_data;
> -
> -#endif
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 412925c48788..2fe639814785 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -20,6 +20,13 @@ config PINCTRL_QCOM_APQ8096
>           Say Y here to enable support for pinctrl on the MSM8996 / APQ8096
>           Snapdragon 820 SoC, as well as the associated GPIO driver.
>
> +config PINCTRL_QCOM_IPQ4019
> +       bool "Qualcomm IPQ4019 GCC"
> +       select PINCTRL_QCOM
> +       help
> +         Say Y here to enable support for pinctrl on the IPQ4019 SoC,
> +         as well as the associated GPIO driver.
> +
>  config PINCTRL_QCOM_QCS404
>         bool "Qualcomm QCS404 GCC"
>         select PINCTRL_QCOM
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 86f507427301..6d9aca6d7b7e 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -4,6 +4,7 @@
>
>  obj-$(CONFIG_PINCTRL_QCOM) += pinctrl-qcom.o
>  obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
> +obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
>  obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
>  obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
>  obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
> diff --git a/arch/arm/mach-ipq40xx/pinctrl-ipq4019.c b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
> similarity index 71%
> rename from arch/arm/mach-ipq40xx/pinctrl-ipq4019.c
> rename to drivers/pinctrl/qcom/pinctrl-ipq4019.c
> index 3e365f8cc86a..2d99f99e1e45 100644
> --- a/arch/arm/mach-ipq40xx/pinctrl-ipq4019.c
> +++ b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
> @@ -7,12 +7,13 @@
>   * Author: Robert Marko <robert.marko@sartura.hr>
>   */
>
> -#include "pinctrl-snapdragon.h"
>  #include <common.h>
> +#include <dm.h>
> +
> +#include "pinctrl-qcom.h"
>
>  #define MAX_PIN_NAME_LEN 32
> -static char pin_name[MAX_PIN_NAME_LEN];
> -
> +static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
>  static const struct pinctrl_function msm_pinctrl_functions[] = {
>         {"gpio", 0},
>         {"blsp_uart0_0", 1}, /* Only for GPIO:16,17 */
> @@ -26,7 +27,6 @@ static const struct pinctrl_function msm_pinctrl_functions[] = {
>         {"mdc_0", 1}, /* Only for GPIO7 */
>         {"mdc_1", 2}, /* Only for GPIO52 */
>  };
> -
>  static const char *ipq4019_get_function_name(struct udevice *dev,
>                                              unsigned int selector)
>  {
> @@ -45,10 +45,23 @@ static unsigned int ipq4019_get_function_mux(unsigned int selector)
>         return msm_pinctrl_functions[selector].val;
>  }
>
> -struct msm_pinctrl_data ipq4019_data = {
> -       .pin_count = 100,
> +static const struct msm_pinctrl_data ipq4019_data = {
> +       .pin_data = { .pin_count = 100, },
>         .functions_count = ARRAY_SIZE(msm_pinctrl_functions),
>         .get_function_name = ipq4019_get_function_name,
>         .get_function_mux = ipq4019_get_function_mux,
>         .get_pin_name = ipq4019_get_pin_name,
>  };
> +
> +static const struct udevice_id msm_pinctrl_ids[] = {
> +       { .compatible = "qcom,ipq4019-pinctrl", .data = (ulong)&ipq4019_data },
> +       { /* Sentinal */ }
> +};
> +
> +U_BOOT_DRIVER(pinctrl_ipq4019) = {
> +       .name           = "pinctrl_ipq4019",
> +       .id             = UCLASS_NOP,
> +       .of_match       = msm_pinctrl_ids,
> +       .ops            = &msm_pinctrl_ops,
> +       .bind           = msm_pinctrl_bind,
> +};
>
> --
> 2.42.0
>
