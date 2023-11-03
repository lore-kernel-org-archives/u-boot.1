Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64498C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 07:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18312875ED;
	Fri,  3 Nov 2023 08:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nR2IZyFg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D87186F69; Fri,  3 Nov 2023 08:30:17 +0100 (CET)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D09BD87703
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 08:29:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-457e5dec94dso828217137.3
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 00:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698996598; x=1699601398; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S0vM49CVe0/8ZQFeFXoMImtTNt/MiqiWfkDqkKRiWsE=;
 b=nR2IZyFgNRtrzzeeMNoQlwqX7hUDpSe66utyLbpGbveSirVPHf66TQfaD0fsCuQ8OO
 qMmhoqBNponzUICTi5oH0RyBqSvtiNAzmQ5y6lak7LVFK1gD9ybGDqBBraJXNn5Nvntl
 5Ful+rpVKSFZgfXBtKgMDds7AWu7w2KOB4I6MQiD79Qdepco3kLhCoxTYFfMUXR0juaL
 GE1V4TtbnfQmuXOr9HHmACrMzHulONwbmIwvi1CstF862WrsYd2GBIyL7A+OmBEuHpG6
 zJjfy33b27xlmtnch6DfzLKtD5Pn49olpuFOLu6TSgklxdSq0zuqJ4eV3q2akM7mQ6m3
 /lWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698996598; x=1699601398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S0vM49CVe0/8ZQFeFXoMImtTNt/MiqiWfkDqkKRiWsE=;
 b=lzHANuDRM6qozGn1vxP/3pmGzbTLwHmvTQhmyyT5MJPebqhyy4/QJaonfAXkBnNkDT
 3NSqVneZCTXMV/6O5oUCJ1+QlwLBbC2XWh0n9XGt42y48ogWAuXMGgN+odXCDN5ykJ7C
 eBS8d79nUGbKNf5jew602+BhywNAmRgpjaVdTiWlyJQs6nGrDMEIAjSSIaPeJEdXTYt4
 Y5ScS59TGzTpSHC4BqkJlbJl7kpGwZrfIptWVgsoVOoyS0N2SL2kf9XX0qLbNmKLFf7Z
 fgq/qPqIofl8WAa5JOIXf1raZPPJsYlpEFEJtMM6zEkYyLraura3n/COIhFd2uvwro+K
 5ZtQ==
X-Gm-Message-State: AOJu0YzTZrnPBBFdoLEE3LipFdZOetWbQr9x+f9KvvVADodx3EwGQPl5
 SK7tDF/esycZPrCK4qZ1O3Q1pYHmdC172rEgChMIJQ==
X-Google-Smtp-Source: AGHT+IGeyqZ4/l9QVPaQlqFGg04nvnIuqqcOrnXX3TOgWokVtfaBJPnlgu3DDjo3d/7ZDFp3LTkMiYvhWRMhX0NFlLA=
X-Received: by 2002:a67:ae45:0:b0:45d:95ad:f584 with SMTP id
 u5-20020a67ae45000000b0045d95adf584mr879241vsh.2.1698996598269; Fri, 03 Nov
 2023 00:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231025-b4-qcom-pinctrl-v1-0-9123d6a217eb@linaro.org>
 <20231025-b4-qcom-pinctrl-v1-6-9123d6a217eb@linaro.org>
In-Reply-To: <20231025-b4-qcom-pinctrl-v1-6-9123d6a217eb@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 3 Nov 2023 12:59:46 +0530
Message-ID: <CAFA6WYPF8KYvH__biQpsS5dVukWq_ZW2B6AbjXMpUhGx9cstEg@mail.gmail.com>
Subject: Re: [PATCH 6/6] pinctrl: qcom: rename msm -> qcom
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
> The "MSM" naming hasn't been correct for quite a while now, in line
> with Linux lets rename all these msm_* functions to qcom_* as well as
> ensure namespacing is consistent across the pinctrl and GPIO drivers.

Can we do it treewide for once such that there isn't any inconsistent
naming? You can push that as a separate patch too.

-Sumit

>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  configs/dragonboard410c_defconfig        |  2 +-
>  configs/dragonboard845c_defconfig        |  2 +-
>  configs/qcs404evb_defconfig              |  2 +-
>  configs/starqltechn_defconfig            |  2 +-
>  drivers/gpio/Kconfig                     |  6 +-
>  drivers/gpio/Makefile                    |  2 +-
>  drivers/gpio/{msm_gpio.c => qcom_gpio.c} | 72 ++++++++++++------------
>  drivers/pinctrl/qcom/pinctrl-apq8016.c   | 22 ++++----
>  drivers/pinctrl/qcom/pinctrl-apq8096.c   | 22 ++++----
>  drivers/pinctrl/qcom/pinctrl-ipq4019.c   | 18 +++---
>  drivers/pinctrl/qcom/pinctrl-qcom.c      | 96 ++++++++++++++++----------------
>  drivers/pinctrl/qcom/pinctrl-qcom.h      |  8 +--
>  drivers/pinctrl/qcom/pinctrl-qcs404.c    | 22 ++++----
>  drivers/pinctrl/qcom/pinctrl-sdm845.c    | 19 +++----
>  include/qcom-gpio.h                      |  6 +-
>  15 files changed, 149 insertions(+), 152 deletions(-)
>
> diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
> index b338326e34c0..11c631799ccf 100644
> --- a/configs/dragonboard410c_defconfig
> +++ b/configs/dragonboard410c_defconfig
> @@ -43,7 +43,7 @@ CONFIG_USB_FUNCTION_FASTBOOT=y
>  CONFIG_FASTBOOT_BUF_ADDR=0x91000000
>  CONFIG_FASTBOOT_FLASH=y
>  CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> -CONFIG_MSM_GPIO=y
> +CONFIG_QCOM_GPIO=y
>  CONFIG_QCOM_PMIC_GPIO=y
>  CONFIG_LED=y
>  CONFIG_LED_GPIO=y
> diff --git a/configs/dragonboard845c_defconfig b/configs/dragonboard845c_defconfig
> index a69d82761a8d..afbdc15d88b2 100644
> --- a/configs/dragonboard845c_defconfig
> +++ b/configs/dragonboard845c_defconfig
> @@ -19,7 +19,7 @@ CONFIG_SYS_CBSIZE=512
>  CONFIG_CMD_GPIO=y
>  # CONFIG_NET is not set
>  CONFIG_CLK=y
> -CONFIG_MSM_GPIO=y
> +CONFIG_QCOM_GPIO=y
>  CONFIG_QCOM_PMIC_GPIO=y
>  CONFIG_PINCTRL=y
>  CONFIG_DM_PMIC=y
> diff --git a/configs/qcs404evb_defconfig b/configs/qcs404evb_defconfig
> index 9e72f64f7849..545ee25b0e7d 100644
> --- a/configs/qcs404evb_defconfig
> +++ b/configs/qcs404evb_defconfig
> @@ -31,7 +31,7 @@ CONFIG_CMD_FAT=y
>  CONFIG_CMD_FS_GENERIC=y
>  # CONFIG_NET is not set
>  CONFIG_CLK=y
> -CONFIG_MSM_GPIO=y
> +CONFIG_QCOM_GPIO=y
>  CONFIG_QCOM_PMIC_GPIO=y
>  CONFIG_MISC=y
>  CONFIG_MMC_HS400_SUPPORT=y
> diff --git a/configs/starqltechn_defconfig b/configs/starqltechn_defconfig
> index 5b85ce5fe96f..9962211d8ab7 100644
> --- a/configs/starqltechn_defconfig
> +++ b/configs/starqltechn_defconfig
> @@ -23,7 +23,7 @@ CONFIG_CMD_BMP=y
>  # CONFIG_NET is not set
>  CONFIG_BUTTON=y
>  CONFIG_CLK=y
> -CONFIG_MSM_GPIO=y
> +CONFIG_QCOM_GPIO=y
>  CONFIG_QCOM_PMIC_GPIO=y
>  CONFIG_DM_KEYBOARD=y
>  CONFIG_BUTTON_KEYBOARD=y
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 74baa98d3c15..2e57eedd466f 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -259,7 +259,7 @@ config MSCC_SGPIO
>            SIO controller is to connect control signals from SFP
>            modules and to act as an LED controller.
>
> -config MSM_GPIO
> +config QCOM_GPIO
>         bool "Qualcomm GPIO driver"
>         depends on DM_GPIO
>         help
> @@ -268,9 +268,7 @@ config MSM_GPIO
>           gpio has it's own set of registers.
>           Only simple GPIO operations are supported (get/set, change of
>           direction and checking pin function).
> -         Supported devices:
> -         - APQ8016
> -         - MSM8916
> +         See PINCTRL_QCOM for a list of supported platforms.
>
>  config MXC_GPIO
>         bool "Freescale/NXP MXC GPIO driver"
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index c8b3fd78141a..b5ebcf75dbfa 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -58,7 +58,7 @@ obj-$(CONFIG_IMX_RGPIO2P)     += imx_rgpio2p.o
>  obj-$(CONFIG_PIC32_GPIO)       += pic32_gpio.o
>  obj-$(CONFIG_OCTEON_GPIO)      += octeon_gpio.o
>  obj-$(CONFIG_MVEBU_GPIO)       += mvebu_gpio.o
> -obj-$(CONFIG_MSM_GPIO)         += msm_gpio.o
> +obj-$(CONFIG_QCOM_GPIO)                += qcom_gpio.o
>  obj-$(CONFIG_$(SPL_)PCF8575_GPIO)      += pcf8575_gpio.o
>  obj-$(CONFIG_$(SPL_TPL_)QCOM_PMIC_GPIO)        += qcom_pmic_gpio.o
>  obj-$(CONFIG_MT7620_GPIO)      += mt7620_gpio.o
> diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/qcom_gpio.c
> similarity index 50%
> rename from drivers/gpio/msm_gpio.c
> rename to drivers/gpio/qcom_gpio.c
> index 7d01fecf46f2..a0b183eb0784 100644
> --- a/drivers/gpio/msm_gpio.c
> +++ b/drivers/gpio/qcom_gpio.c
> @@ -24,22 +24,22 @@ DECLARE_GLOBAL_DATA_PTR;
>  #define GPIO_IN          0
>  #define GPIO_OUT         1
>
> -struct msm_gpio_bank {
> +struct qcom_gpio_priv {
>         phys_addr_t base;
> -       const struct msm_pin_data *pin_data;
> +       const struct qcom_pin_data *pin_data;
>  };
>
>  #define GPIO_CONFIG_REG(dev, x) \
> -       (qcom_pin_offset(((struct msm_gpio_bank *)dev_get_priv(dev))->pin_data->pin_offsets, x))
> +       (qcom_pin_offset(((struct qcom_gpio_priv *)dev_get_priv(dev))->pin_data->pin_offsets, x))
>
>  #define GPIO_IN_OUT_REG(dev, x) \
>         (GPIO_CONFIG_REG(dev, x) + 0x4)
>
> -static int msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
> +static int qcom_gpio_direction_input(struct udevice *dev, unsigned int gpio)
>  {
> -       struct msm_gpio_bank *priv = dev_get_priv(dev);
> +       struct qcom_gpio_priv *priv = dev_get_priv(dev);
>
> -       if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
> +       if (qcom_pinctrl_is_reserved(dev_get_parent(dev), gpio))
>                 return 0;
>
>         /* Disable OE bit */
> @@ -49,11 +49,11 @@ static int msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
>         return 0;
>  }
>
> -static int msm_gpio_set_value(struct udevice *dev, unsigned int gpio, int value)
> +static int qcom_gpio_set_value(struct udevice *dev, unsigned int gpio, int value)
>  {
> -       struct msm_gpio_bank *priv = dev_get_priv(dev);
> +       struct qcom_gpio_priv *priv = dev_get_priv(dev);
>
> -       if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
> +       if (qcom_pinctrl_is_reserved(dev_get_parent(dev), gpio))
>                 return 0;
>
>         value = !!value;
> @@ -63,12 +63,12 @@ static int msm_gpio_set_value(struct udevice *dev, unsigned int gpio, int value)
>         return 0;
>  }
>
> -static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
> -                                    int value)
> +static int qcom_gpio_direction_output(struct udevice *dev, unsigned int gpio,
> +                                     int value)
>  {
> -       struct msm_gpio_bank *priv = dev_get_priv(dev);
> +       struct qcom_gpio_priv *priv = dev_get_priv(dev);
>
> -       if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
> +       if (qcom_pinctrl_is_reserved(dev_get_parent(dev), gpio))
>                 return 0;
>
>         value = !!value;
> @@ -81,21 +81,21 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
>         return 0;
>  }
>
> -static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
> +static int qcom_gpio_get_value(struct udevice *dev, unsigned int gpio)
>  {
> -       struct msm_gpio_bank *priv = dev_get_priv(dev);
> +       struct qcom_gpio_priv *priv = dev_get_priv(dev);
>
> -       if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
> +       if (qcom_pinctrl_is_reserved(dev_get_parent(dev), gpio))
>                 return 0;
>
>         return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) >> GPIO_IN);
>  }
>
> -static int msm_gpio_get_function(struct udevice *dev, unsigned int gpio)
> +static int qcom_gpio_get_function(struct udevice *dev, unsigned int gpio)
>  {
> -       struct msm_gpio_bank *priv = dev_get_priv(dev);
> +       struct qcom_gpio_priv *priv = dev_get_priv(dev);
>
> -       if (msm_pinctrl_is_reserved(dev_get_parent(dev), gpio))
> +       if (qcom_pinctrl_is_reserved(dev_get_parent(dev), gpio))
>                 return GPIOF_UNKNOWN;
>
>         if (readl(priv->base + GPIO_CONFIG_REG(dev, gpio)) & GPIO_OE_ENABLE)
> @@ -104,28 +104,28 @@ static int msm_gpio_get_function(struct udevice *dev, unsigned int gpio)
>         return GPIOF_INPUT;
>  }
>
> -static const struct dm_gpio_ops gpio_msm_ops = {
> -       .direction_input        = msm_gpio_direction_input,
> -       .direction_output       = msm_gpio_direction_output,
> -       .get_value              = msm_gpio_get_value,
> -       .set_value              = msm_gpio_set_value,
> -       .get_function           = msm_gpio_get_function,
> +static const struct dm_gpio_ops qcom_gpio_ops = {
> +       .direction_input        = qcom_gpio_direction_input,
> +       .direction_output       = qcom_gpio_direction_output,
> +       .get_value              = qcom_gpio_get_value,
> +       .set_value              = qcom_gpio_set_value,
> +       .get_function           = qcom_gpio_get_function,
>  };
>
> -static int msm_gpio_probe(struct udevice *dev)
> +static int qcom_gpio_probe(struct udevice *dev)
>  {
> -       struct msm_gpio_bank *priv = dev_get_priv(dev);
> +       struct qcom_gpio_priv *priv = dev_get_priv(dev);
>
>         priv->base = dev_read_addr(dev);
> -       priv->pin_data = (struct msm_pin_data *)dev_get_driver_data(dev);
> +       priv->pin_data = (struct qcom_pin_data *)dev_get_driver_data(dev);
>
>         return priv->base == FDT_ADDR_T_NONE ? -EINVAL : 0;
>  }
>
> -static int msm_gpio_of_to_plat(struct udevice *dev)
> +static int qcom_gpio_of_to_plat(struct udevice *dev)
>  {
>         struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> -       const struct msm_pin_data *pin_data = (struct msm_pin_data *)dev_get_driver_data(dev);
> +       const struct qcom_pin_data *pin_data = (struct qcom_pin_data *)dev_get_driver_data(dev);
>
>         /* Get the pin count from the pinctrl driver */
>         uc_priv->gpio_count = pin_data->pin_count;
> @@ -137,12 +137,12 @@ static int msm_gpio_of_to_plat(struct udevice *dev)
>         return 0;
>  }
>
> -U_BOOT_DRIVER(gpio_msm) = {
> -       .name   = "gpio_msm",
> +U_BOOT_DRIVER(qcom_gpio) = {
> +       .name   = "qcom_gpio",
>         .id     = UCLASS_GPIO,
> -       .of_to_plat = msm_gpio_of_to_plat,
> -       .probe  = msm_gpio_probe,
> -       .ops    = &gpio_msm_ops,
> +       .of_to_plat = qcom_gpio_of_to_plat,
> +       .probe  = qcom_gpio_probe,
> +       .ops    = &qcom_gpio_ops,
>         .flags  = DM_UC_FLAG_SEQ_ALIAS,
> -       .priv_auto      = sizeof(struct msm_gpio_bank),
> +       .priv_auto      = sizeof(struct qcom_gpio_priv),
>  };
> diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> index 8149ffd83cc4..652f8a51be60 100644
> --- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
> +++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> @@ -13,7 +13,7 @@
>
>  #define MAX_PIN_NAME_LEN 32
>  static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
> -static const char * const msm_pinctrl_pins[] = {
> +static const char * const qcom_pinctrl_pins[] = {
>         "SDC1_CLK",
>         "SDC1_CMD",
>         "SDC1_DATA",
> @@ -28,14 +28,14 @@ static const char * const msm_pinctrl_pins[] = {
>         "QDSD_DATA3",
>  };
>
> -static const struct pinctrl_function msm_pinctrl_functions[] = {
> +static const struct pinctrl_function qcom_pinctrl_functions[] = {
>         {"blsp1_uart", 2},
>  };
>
>  static const char *apq8016_get_function_name(struct udevice *dev,
>                                              unsigned int selector)
>  {
> -       return msm_pinctrl_functions[selector].name;
> +       return qcom_pinctrl_functions[selector].name;
>  }
>
>  static const char *apq8016_get_pin_name(struct udevice *dev,
> @@ -45,24 +45,24 @@ static const char *apq8016_get_pin_name(struct udevice *dev,
>                 snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
>                 return pin_name;
>         } else {
> -               return msm_pinctrl_pins[selector - 122];
> +               return qcom_pinctrl_pins[selector - 122];
>         }
>  }
>
>  static unsigned int apq8016_get_function_mux(unsigned int selector)
>  {
> -       return msm_pinctrl_functions[selector].val;
> +       return qcom_pinctrl_functions[selector].val;
>  }
>
> -static const struct msm_pinctrl_data apq8016_data = {
> +static const struct qcom_pinctrl_data apq8016_data = {
>         .pin_data = { .pin_count = 133, },
> -       .functions_count = ARRAY_SIZE(msm_pinctrl_functions),
> +       .functions_count = ARRAY_SIZE(qcom_pinctrl_functions),
>         .get_function_name = apq8016_get_function_name,
>         .get_function_mux = apq8016_get_function_mux,
>         .get_pin_name = apq8016_get_pin_name,
>  };
>
> -static const struct udevice_id msm_pinctrl_ids[] = {
> +static const struct udevice_id qcom_pinctrl_ids[] = {
>         { .compatible = "qcom,msm8916-pinctrl", .data = (ulong)&apq8016_data },
>         { /* Sentinal */ }
>  };
> @@ -70,7 +70,7 @@ static const struct udevice_id msm_pinctrl_ids[] = {
>  U_BOOT_DRIVER(pinctrl_apq8016) = {
>         .name           = "pinctrl_apq8016",
>         .id             = UCLASS_NOP,
> -       .of_match       = msm_pinctrl_ids,
> -       .ops            = &msm_pinctrl_ops,
> -       .bind           = msm_pinctrl_bind,
> +       .of_match       = qcom_pinctrl_ids,
> +       .ops            = &qcom_pinctrl_ops,
> +       .bind           = qcom_pinctrl_bind,
>  };
> diff --git a/drivers/pinctrl/qcom/pinctrl-apq8096.c b/drivers/pinctrl/qcom/pinctrl-apq8096.c
> index d64ab1ff7bee..d0c1424dff7a 100644
> --- a/drivers/pinctrl/qcom/pinctrl-apq8096.c
> +++ b/drivers/pinctrl/qcom/pinctrl-apq8096.c
> @@ -13,7 +13,7 @@
>
>  #define MAX_PIN_NAME_LEN 32
>  static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
> -static const char * const msm_pinctrl_pins[] = {
> +static const char * const qcom_pinctrl_pins[] = {
>         "SDC1_CLK",
>         "SDC1_CMD",
>         "SDC1_DATA",
> @@ -23,14 +23,14 @@ static const char * const msm_pinctrl_pins[] = {
>         "SDC1_RCLK",
>  };
>
> -static const struct pinctrl_function msm_pinctrl_functions[] = {
> +static const struct pinctrl_function qcom_pinctrl_functions[] = {
>         {"blsp_uart8", 2},
>  };
>
>  static const char *apq8096_get_function_name(struct udevice *dev,
>                                              unsigned int selector)
>  {
> -       return msm_pinctrl_functions[selector].name;
> +       return qcom_pinctrl_functions[selector].name;
>  }
>
>  static const char *apq8096_get_pin_name(struct udevice *dev,
> @@ -40,24 +40,24 @@ static const char *apq8096_get_pin_name(struct udevice *dev,
>                 snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
>                 return pin_name;
>         } else {
> -               return msm_pinctrl_pins[selector - 150];
> +               return qcom_pinctrl_pins[selector - 150];
>         }
>  }
>
>  static unsigned int apq8096_get_function_mux(unsigned int selector)
>  {
> -       return msm_pinctrl_functions[selector].val;
> +       return qcom_pinctrl_functions[selector].val;
>  }
>
> -static const struct msm_pinctrl_data apq8096_data = {
> +static const struct qcom_pinctrl_data apq8096_data = {
>         .pin_data = { .pin_count = 157, },
> -       .functions_count = ARRAY_SIZE(msm_pinctrl_functions),
> +       .functions_count = ARRAY_SIZE(qcom_pinctrl_functions),
>         .get_function_name = apq8096_get_function_name,
>         .get_function_mux = apq8096_get_function_mux,
>         .get_pin_name = apq8096_get_pin_name,
>  };
>
> -static const struct udevice_id msm_pinctrl_ids[] = {
> +static const struct udevice_id qcom_pinctrl_ids[] = {
>         { .compatible = "qcom,msm8996-pinctrl", .data = (ulong)&apq8096_data },
>         { /* Sentinal */ }
>  };
> @@ -65,7 +65,7 @@ static const struct udevice_id msm_pinctrl_ids[] = {
>  U_BOOT_DRIVER(pinctrl_apq8096) = {
>         .name           = "pinctrl_apq8096",
>         .id             = UCLASS_NOP,
> -       .of_match       = msm_pinctrl_ids,
> -       .ops            = &msm_pinctrl_ops,
> -       .bind           = msm_pinctrl_bind,
> +       .of_match       = qcom_pinctrl_ids,
> +       .ops            = &qcom_pinctrl_ops,
> +       .bind           = qcom_pinctrl_bind,
>  };
> diff --git a/drivers/pinctrl/qcom/pinctrl-ipq4019.c b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
> index 2d99f99e1e45..2081d6d86f82 100644
> --- a/drivers/pinctrl/qcom/pinctrl-ipq4019.c
> +++ b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
> @@ -14,7 +14,7 @@
>
>  #define MAX_PIN_NAME_LEN 32
>  static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
> -static const struct pinctrl_function msm_pinctrl_functions[] = {
> +static const struct pinctrl_function qcom_pinctrl_functions[] = {
>         {"gpio", 0},
>         {"blsp_uart0_0", 1}, /* Only for GPIO:16,17 */
>         {"blsp_uart0_1", 2}, /* Only for GPIO:60,61 */
> @@ -30,7 +30,7 @@ static const struct pinctrl_function msm_pinctrl_functions[] = {
>  static const char *ipq4019_get_function_name(struct udevice *dev,
>                                              unsigned int selector)
>  {
> -       return msm_pinctrl_functions[selector].name;
> +       return qcom_pinctrl_functions[selector].name;
>  }
>
>  static const char *ipq4019_get_pin_name(struct udevice *dev,
> @@ -42,18 +42,18 @@ static const char *ipq4019_get_pin_name(struct udevice *dev,
>
>  static unsigned int ipq4019_get_function_mux(unsigned int selector)
>  {
> -       return msm_pinctrl_functions[selector].val;
> +       return qcom_pinctrl_functions[selector].val;
>  }
>
> -static const struct msm_pinctrl_data ipq4019_data = {
> +static const struct qcom_pinctrl_data ipq4019_data = {
>         .pin_data = { .pin_count = 100, },
> -       .functions_count = ARRAY_SIZE(msm_pinctrl_functions),
> +       .functions_count = ARRAY_SIZE(qcom_pinctrl_functions),
>         .get_function_name = ipq4019_get_function_name,
>         .get_function_mux = ipq4019_get_function_mux,
>         .get_pin_name = ipq4019_get_pin_name,
>  };
>
> -static const struct udevice_id msm_pinctrl_ids[] = {
> +static const struct udevice_id qcom_pinctrl_ids[] = {
>         { .compatible = "qcom,ipq4019-pinctrl", .data = (ulong)&ipq4019_data },
>         { /* Sentinal */ }
>  };
> @@ -61,7 +61,7 @@ static const struct udevice_id msm_pinctrl_ids[] = {
>  U_BOOT_DRIVER(pinctrl_ipq4019) = {
>         .name           = "pinctrl_ipq4019",
>         .id             = UCLASS_NOP,
> -       .of_match       = msm_pinctrl_ids,
> -       .ops            = &msm_pinctrl_ops,
> -       .bind           = msm_pinctrl_bind,
> +       .of_match       = qcom_pinctrl_ids,
> +       .ops            = &qcom_pinctrl_ops,
> +       .bind           = qcom_pinctrl_bind,
>  };
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
> index 92b35c198788..4f5ef5c14dd4 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcom.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
> @@ -20,12 +20,12 @@
>
>  #include "pinctrl-qcom.h"
>
> -#define MSM_PINCTRL_MAX_RESERVED_RANGES 32
> +#define qcom_PINCTRL_MAX_RESERVED_RANGES 32
>
> -struct msm_pinctrl_priv {
> +struct qcom_pinctrl_priv {
>         phys_addr_t base;
> -       struct msm_pinctrl_data *data;
> -       u32 reserved_ranges[MSM_PINCTRL_MAX_RESERVED_RANGES * 2];
> +       struct qcom_pinctrl_data *data;
> +       u32 reserved_ranges[qcom_PINCTRL_MAX_RESERVED_RANGES * 2];
>         int reserved_ranges_count;
>  };
>
> @@ -37,37 +37,37 @@ struct msm_pinctrl_priv {
>  #define TLMM_DRV_STRENGTH_MASK GENMASK(8, 6)
>  #define TLMM_GPIO_DISABLE BIT(9)
>
> -static const struct pinconf_param msm_conf_params[] = {
> +static const struct pinconf_param qcom_conf_params[] = {
>         { "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 2 },
>         { "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
>         { "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 3 },
>  };
>
> -static int msm_get_functions_count(struct udevice *dev)
> +static int qcom_get_functions_count(struct udevice *dev)
>  {
> -       struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> +       struct qcom_pinctrl_priv *priv = dev_get_priv(dev);
>
>         return priv->data->functions_count;
>  }
>
> -static int msm_get_pins_count(struct udevice *dev)
> +static int qcom_get_pins_count(struct udevice *dev)
>  {
> -       struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> +       struct qcom_pinctrl_priv *priv = dev_get_priv(dev);
>
>         return priv->data->pin_data.pin_count;
>  }
>
> -static const char *msm_get_function_name(struct udevice *dev,
> -                                        unsigned int selector)
> +static const char *qcom_get_function_name(struct udevice *dev,
> +                                         unsigned int selector)
>  {
> -       struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> +       struct qcom_pinctrl_priv *priv = dev_get_priv(dev);
>
>         return priv->data->get_function_name(dev, selector);
>  }
>
> -static int msm_pinctrl_parse_ranges(struct udevice *dev)
> +static int qcom_pinctrl_parse_ranges(struct udevice *dev)
>  {
> -       struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> +       struct qcom_pinctrl_priv *priv = dev_get_priv(dev);
>         int count;
>
>         if (ofnode_read_prop(dev_ofnode(dev), "gpio-reserved-ranges",
> @@ -79,9 +79,9 @@ static int msm_pinctrl_parse_ranges(struct udevice *dev)
>                 /* Size is in bytes, but we're indexing by ints */
>                 count /= 4;
>
> -               if (count > MSM_PINCTRL_MAX_RESERVED_RANGES) {
> +               if (count > qcom_PINCTRL_MAX_RESERVED_RANGES) {
>                         dev_err(dev, "gpio-reserved-ranges must be less than %d (got %d)\n",
> -                               MSM_PINCTRL_MAX_RESERVED_RANGES, count);
> +                               qcom_PINCTRL_MAX_RESERVED_RANGES, count);
>                         return -EINVAL;
>                 }
>
> @@ -98,15 +98,15 @@ static int msm_pinctrl_parse_ranges(struct udevice *dev)
>         return 0;
>  }
>
> -static int msm_pinctrl_probe(struct udevice *dev)
> +static int qcom_pinctrl_probe(struct udevice *dev)
>  {
> -       struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> +       struct qcom_pinctrl_priv *priv = dev_get_priv(dev);
>         int ret;
>
>         priv->base = dev_read_addr(dev);
> -       priv->data = (struct msm_pinctrl_data *)dev_get_driver_data(dev);
> +       priv->data = (struct qcom_pinctrl_data *)dev_get_driver_data(dev);
>
> -       ret = msm_pinctrl_parse_ranges(dev);
> +       ret = qcom_pinctrl_parse_ranges(dev);
>         if (ret) {
>                 printf("Couldn't parse reserved GPIO ranges!\n");
>                 return ret;
> @@ -115,19 +115,19 @@ static int msm_pinctrl_probe(struct udevice *dev)
>         return priv->base == FDT_ADDR_T_NONE ? -EINVAL : 0;
>  }
>
> -static const char *msm_get_pin_name(struct udevice *dev, unsigned int selector)
> +static const char *qcom_get_pin_name(struct udevice *dev, unsigned int selector)
>  {
> -       struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> +       struct qcom_pinctrl_priv *priv = dev_get_priv(dev);
>
>         return priv->data->get_pin_name(dev, selector);
>  }
>
> -static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
> -                         unsigned int func_selector)
> +static int qcom_pinmux_set(struct udevice *dev, unsigned int pin_selector,
> +                          unsigned int func_selector)
>  {
> -       struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> +       struct qcom_pinctrl_priv *priv = dev_get_priv(dev);
>
> -       if (msm_pinctrl_is_reserved(dev, pin_selector))
> +       if (qcom_pinctrl_is_reserved(dev, pin_selector))
>                 return 0;
>
>         clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
> @@ -136,12 +136,12 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
>         return 0;
>  }
>
> -static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
> -                          unsigned int param, unsigned int argument)
> +static int qcom_pinconf_set(struct udevice *dev, unsigned int pin_selector,
> +                           unsigned int param, unsigned int argument)
>  {
> -       struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> +       struct qcom_pinctrl_priv *priv = dev_get_priv(dev);
>
> -       if (msm_pinctrl_is_reserved(dev, pin_selector))
> +       if (qcom_pinctrl_is_reserved(dev, pin_selector))
>                 return 0;
>
>         switch (param) {
> @@ -165,22 +165,22 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
>         return 0;
>  }
>
> -struct pinctrl_ops msm_pinctrl_ops = {
> -       .get_pins_count = msm_get_pins_count,
> -       .get_pin_name = msm_get_pin_name,
> +struct pinctrl_ops qcom_pinctrl_ops = {
> +       .get_pins_count = qcom_get_pins_count,
> +       .get_pin_name = qcom_get_pin_name,
>         .set_state = pinctrl_generic_set_state,
> -       .pinmux_set = msm_pinmux_set,
> -       .pinconf_num_params = ARRAY_SIZE(msm_conf_params),
> -       .pinconf_params = msm_conf_params,
> -       .pinconf_set = msm_pinconf_set,
> -       .get_functions_count = msm_get_functions_count,
> -       .get_function_name = msm_get_function_name,
> +       .pinmux_set = qcom_pinmux_set,
> +       .pinconf_num_params = ARRAY_SIZE(qcom_conf_params),
> +       .pinconf_params = qcom_conf_params,
> +       .pinconf_set = qcom_pinconf_set,
> +       .get_functions_count = qcom_get_functions_count,
> +       .get_function_name = qcom_get_function_name,
>  };
>
> -int msm_pinctrl_bind(struct udevice *dev)
> +int qcom_pinctrl_bind(struct udevice *dev)
>  {
>         ofnode node = dev_ofnode(dev);
> -       struct msm_pinctrl_data *data = (struct msm_pinctrl_data *)dev_get_driver_data(dev);
> +       struct qcom_pinctrl_data *data = (struct qcom_pinctrl_data *)dev_get_driver_data(dev);
>         struct driver *drv;
>         struct udevice *pinctrl_dev;
>         const char *name;
> @@ -204,9 +204,9 @@ int msm_pinctrl_bind(struct udevice *dev)
>         if (!name)
>                 return -EINVAL;
>
> -       drv = lists_driver_lookup_name("gpio_msm");
> +       drv = lists_driver_lookup_name("qcom_gpio");
>         if (!drv) {
> -               printf("Can't find gpio_msm driver\n");
> +               printf("Can't find qcom_gpio driver\n");
>                 return -ENODEV;
>         }
>
> @@ -224,14 +224,14 @@ int msm_pinctrl_bind(struct udevice *dev)
>  U_BOOT_DRIVER(qcom_pinctrl) = {
>         .name           = "qcom_pinctrl",
>         .id             = UCLASS_PINCTRL,
> -       .priv_auto      = sizeof(struct msm_pinctrl_priv),
> -       .ops            = &msm_pinctrl_ops,
> -       .probe          = msm_pinctrl_probe,
> +       .priv_auto      = sizeof(struct qcom_pinctrl_priv),
> +       .ops            = &qcom_pinctrl_ops,
> +       .probe          = qcom_pinctrl_probe,
>  };
>
> -bool msm_pinctrl_is_reserved(struct udevice *dev, unsigned int pin)
> +bool qcom_pinctrl_is_reserved(struct udevice *dev, unsigned int pin)
>  {
> -       struct msm_pinctrl_priv *priv = dev_get_priv(dev);
> +       struct qcom_pinctrl_priv *priv = dev_get_priv(dev);
>         unsigned int i, start;
>
>         for (i = 0; i < priv->reserved_ranges_count; i += 2) {
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.h b/drivers/pinctrl/qcom/pinctrl-qcom.h
> index efb6a44b1409..2aa8c80c696f 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcom.h
> +++ b/drivers/pinctrl/qcom/pinctrl-qcom.h
> @@ -13,8 +13,8 @@
>
>  struct udevice;
>
> -struct msm_pinctrl_data {
> -       struct msm_pin_data pin_data;
> +struct qcom_pinctrl_data {
> +       struct qcom_pin_data pin_data;
>         int functions_count;
>         const char *(*get_function_name)(struct udevice *dev,
>                                          unsigned int selector);
> @@ -28,8 +28,8 @@ struct pinctrl_function {
>         int val;
>  };
>
> -extern struct pinctrl_ops msm_pinctrl_ops;
> +extern struct pinctrl_ops qcom_pinctrl_ops;
>
> -int msm_pinctrl_bind(struct udevice *dev);
> +int qcom_pinctrl_bind(struct udevice *dev);
>
>  #endif
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcs404.c b/drivers/pinctrl/qcom/pinctrl-qcs404.c
> index ac00afa2a1f4..410cdbb23925 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
> @@ -12,7 +12,7 @@
>
>  #define MAX_PIN_NAME_LEN 32
>  static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
> -static const char * const msm_pinctrl_pins[] = {
> +static const char * const qcom_pinctrl_pins[] = {
>         "SDC1_RCLK",
>         "SDC1_CLK",
>         "SDC1_CMD",
> @@ -22,7 +22,7 @@ static const char * const msm_pinctrl_pins[] = {
>         "SDC2_DATA",
>  };
>
> -static const struct pinctrl_function msm_pinctrl_functions[] = {
> +static const struct pinctrl_function qcom_pinctrl_functions[] = {
>         {"blsp_uart2", 1},
>         {"rgmii_int", 1},
>         {"rgmii_ck", 1},
> @@ -42,7 +42,7 @@ static const struct pinctrl_function msm_pinctrl_functions[] = {
>  static const char *qcs404_get_function_name(struct udevice *dev,
>                                             unsigned int selector)
>  {
> -       return msm_pinctrl_functions[selector].name;
> +       return qcom_pinctrl_functions[selector].name;
>  }
>
>  static const char *qcs404_get_pin_name(struct udevice *dev,
> @@ -52,24 +52,24 @@ static const char *qcs404_get_pin_name(struct udevice *dev,
>                 snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
>                 return pin_name;
>         } else {
> -               return msm_pinctrl_pins[selector - 120];
> +               return qcom_pinctrl_pins[selector - 120];
>         }
>  }
>
>  static unsigned int qcs404_get_function_mux(unsigned int selector)
>  {
> -       return msm_pinctrl_functions[selector].val;
> +       return qcom_pinctrl_functions[selector].val;
>  }
>
> -static struct msm_pinctrl_data qcs404_data = {
> +static struct qcom_pinctrl_data qcs404_data = {
>         .pin_data = { .pin_count = 126, },
> -       .functions_count = ARRAY_SIZE(msm_pinctrl_functions),
> +       .functions_count = ARRAY_SIZE(qcom_pinctrl_functions),
>         .get_function_name = qcs404_get_function_name,
>         .get_function_mux = qcs404_get_function_mux,
>         .get_pin_name = qcs404_get_pin_name,
>  };
>
> -static const struct udevice_id msm_pinctrl_ids[] = {
> +static const struct udevice_id qcom_pinctrl_ids[] = {
>         { .compatible = "qcom,qcs404-pinctrl", .data = (ulong)&qcs404_data },
>         { /* Sentinal */ }
>  };
> @@ -77,7 +77,7 @@ static const struct udevice_id msm_pinctrl_ids[] = {
>  U_BOOT_DRIVER(pinctrl_qcs404) = {
>         .name           = "pinctrl_qcs404",
>         .id             = UCLASS_NOP,
> -       .of_match       = msm_pinctrl_ids,
> -       .ops            = &msm_pinctrl_ops,
> -       .bind           = msm_pinctrl_bind,
> +       .of_match       = qcom_pinctrl_ids,
> +       .ops            = &qcom_pinctrl_ops,
> +       .bind           = qcom_pinctrl_bind,
>  };
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> index 9f0f4085ce2d..08cca602e94a 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> @@ -3,7 +3,6 @@
>   * Qualcomm SDM845 pinctrl
>   *
>   * (C) Copyright 2021 Dzmitry Sankouski <dsankouski@gmail.com>
> - * (C) Copyright 2023 Linaro Ltd.
>   *
>   */
>
> @@ -19,7 +18,7 @@
>  #define MAX_PIN_NAME_LEN 32
>  static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
>
> -static const struct pinctrl_function msm_pinctrl_functions[] = {
> +static const struct pinctrl_function qcom_pinctrl_functions[] = {
>         {"qup9", 1},
>         {"gpio", 0},
>  };
> @@ -60,7 +59,7 @@ static const unsigned int sdm845_pin_offsets[] = {
>  static const char *sdm845_get_function_name(struct udevice *dev,
>                                              unsigned int selector)
>  {
> -       return msm_pinctrl_functions[selector].name;
> +       return qcom_pinctrl_functions[selector].name;
>  }
>
>  static const char *sdm845_get_pin_name(struct udevice *dev,
> @@ -72,21 +71,21 @@ static const char *sdm845_get_pin_name(struct udevice *dev,
>
>  static unsigned int sdm845_get_function_mux(unsigned int selector)
>  {
> -       return msm_pinctrl_functions[selector].val;
> +       return qcom_pinctrl_functions[selector].val;
>  }
>
> -static struct msm_pinctrl_data sdm845_data = {
> +static struct qcom_pinctrl_data sdm845_data = {
>         .pin_data = {
>                 .pin_offsets = sdm845_pin_offsets,
>                 .pin_count = ARRAY_SIZE(sdm845_pin_offsets),
>         },
> -       .functions_count = ARRAY_SIZE(msm_pinctrl_functions),
> +       .functions_count = ARRAY_SIZE(qcom_pinctrl_functions),
>         .get_function_name = sdm845_get_function_name,
>         .get_function_mux = sdm845_get_function_mux,
>         .get_pin_name = sdm845_get_pin_name,
>  };
>
> -static const struct udevice_id msm_pinctrl_ids[] = {
> +static const struct udevice_id qcom_pinctrl_ids[] = {
>         { .compatible = "qcom,sdm845-pinctrl", .data = (ulong)&sdm845_data },
>         { /* Sentinal */ }
>  };
> @@ -94,7 +93,7 @@ static const struct udevice_id msm_pinctrl_ids[] = {
>  U_BOOT_DRIVER(pinctrl_sdm845) = {
>         .name           = "pinctrl_sdm845",
>         .id             = UCLASS_NOP,
> -       .of_match       = msm_pinctrl_ids,
> -       .ops            = &msm_pinctrl_ops,
> -       .bind           = msm_pinctrl_bind,
> +       .of_match       = qcom_pinctrl_ids,
> +       .ops            = &qcom_pinctrl_ops,
> +       .bind           = qcom_pinctrl_bind,
>  };
> diff --git a/include/qcom-gpio.h b/include/qcom-gpio.h
> index 490a1de55f89..758a6ad9234f 100644
> --- a/include/qcom-gpio.h
> +++ b/include/qcom-gpio.h
> @@ -10,7 +10,7 @@
>  #include <asm/types.h>
>  #include <stdbool.h>
>
> -struct msm_pin_data {
> +struct qcom_pin_data {
>         int pin_count;
>         const unsigned int *pin_offsets;
>  };
> @@ -28,7 +28,7 @@ static inline u32 qcom_pin_offset(const unsigned int *offs, unsigned int selecto
>  struct udevice;
>
>  /**
> - * msm_pinctrl_is_reserved() - Check if a pin lies in a reserved range
> + * qcom_pinctrl_is_reserved() - Check if a pin lies in a reserved range
>   *
>   * @dev: pinctrl device
>   * @pin: Pin number
> @@ -38,6 +38,6 @@ struct udevice;
>   * Call using dev_get_parent() from the GPIO device, it is a child of
>   * the pinctrl device.
>   */
> -bool msm_pinctrl_is_reserved(struct udevice *dev, unsigned int pin);
> +bool qcom_pinctrl_is_reserved(struct udevice *dev, unsigned int pin);
>
>  #endif /* _QCOM_GPIO_H_ */
>
> --
> 2.42.0
>
