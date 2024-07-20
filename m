Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35ABAC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E58F788840;
	Sat, 20 Jul 2024 14:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lyIF47X+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B76D88675; Sat, 20 Jul 2024 14:36:19 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 201C588673
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b78c980981so15913806d6.2
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 05:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721478975; x=1722083775; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dLHa3XLXYc9cn9xszSRkjx5rBWee/Wnw6YB1cXZOpMU=;
 b=lyIF47X+mofE0Ht6T85150NJsgcYZqTvtEJmWLw7+Zwe7IlcpUWhnOssRyfuGVf8e+
 lKtBuh+qt7WRDs2l+9zC4IPvpXxzSFf2JsYzw5ObbG056CeMtgPE7NN9ekTwMZ5xzzW4
 Cc8wDN6ZEU5y8ShHm/JaBY9AaOx8lk44j5pK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721478975; x=1722083775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dLHa3XLXYc9cn9xszSRkjx5rBWee/Wnw6YB1cXZOpMU=;
 b=K30/z63nPXgnNAJ7y2GCzeCarcdh90WId8pnCoBspZQix8UlJpuYk8U4JUesV5KTkr
 QxqMGkqKQ2cLm5/eGxUXwrt3bYt20/r4UzZGIzHpUN1P8ZOgy+Hhm69pKmu0PQ9ChEjo
 31VGQhqkXMlOTvdLrl259XUK+AxPAF58w/+DbFTAlg7R0SiExz0ZifyOjtb1owNUfONQ
 GZK7wPMIy+tmMwrBJefp5uPufEAYtM1i5XNFudhlhGFuG0LXaEOmbh5eA4xIsQTqgh5U
 v86/hFKviSuY15EOY1zk0DHkmDpKasJFMHaqBvQO0dDCHyN27iuOTHMrKuumYlPUSKjs
 VY5g==
X-Gm-Message-State: AOJu0Yw8yR19HnBrCwVrrRs3I7JodKRlE6080muio/5h/WVhXG3K421C
 o3yOVAMaGdKudpwH7hxC5Hti9e+VBI9IHl1vWfYiuxRDxLnXpcpIRZf3i1WtrdXdTrGivwZD0Gg
 lM7dK0pyb17D1rXg2JS2XluOzvjF+BsdMSgyPrfM1O7bT79c=
X-Google-Smtp-Source: AGHT+IHyN9bIxSyhrOj08J9GmA6f8BVxBZcJXLX8kjQMvbWNgPvhiyzo7ZzFPreW7Frc31irPm+/w6aUCgo7w5Bs8Xw=
X-Received: by 2002:a05:6214:240d:b0:6b5:50:4427 with SMTP id
 6a1803df08f44-6b96106d9c0mr20719326d6.12.1721478974939; Sat, 20 Jul 2024
 05:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240719215123.3358410-1-agust@denx.de>
In-Reply-To: <20240719215123.3358410-1-agust@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 20 Jul 2024 13:36:04 +0100
Message-ID: <CAFLszTjjgvFePwsMO-u-bKRjaCREXy1PCpOCmfH=Atvm2ThAqg@mail.gmail.com>
Subject: Re: [PATCH] board: beagle: convert to CONFIG_DM_I2C
To: Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Anatolij,

On Fri, 19 Jul 2024 at 22:51, Anatolij Gustschin <agust@denx.de> wrote:
>
> Rework to remove use of legacy I2C API.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  board/beagle/beagle/beagle.c   | 41 +++++++++++++++++++++-------------
>  configs/omap3_beagle_defconfig |  2 +-
>  include/configs/omap3_beagle.h |  3 ---
>  3 files changed, 26 insertions(+), 20 deletions(-)
>
> diff --git a/board/beagle/beagle/beagle.c b/board/beagle/beagle/beagle.c
> index ac2f89cf21..ae258817e9 100644
> --- a/board/beagle/beagle/beagle.c
> +++ b/board/beagle/beagle/beagle.c
> @@ -41,7 +41,6 @@
>  #include "beagle.h"
>  #include <command.h>
>
> -#define TWL4030_I2C_BUS                        0
>  #define EXPANSION_EEPROM_I2C_BUS       1
>  #define EXPANSION_EEPROM_I2C_ADDRESS   0x50
>
> @@ -213,27 +212,37 @@ void get_board_mem_timings(struct board_sdrc_timings *timings)
>   */
>  static unsigned int get_expansion_id(void)
>  {
> -       i2c_set_bus_num(EXPANSION_EEPROM_I2C_BUS);
> +       struct udevice *eeprom = NULL;
> +       int ret;
>
> -       /* return BEAGLE_NO_EEPROM if eeprom doesn't respond */
> -       if (i2c_probe(EXPANSION_EEPROM_I2C_ADDRESS) == 1) {
> -               i2c_set_bus_num(TWL4030_I2C_BUS);
> +       ret = i2c_get_chip_for_busnum(EXPANSION_EEPROM_I2C_BUS,
> +                                     EXPANSION_EEPROM_I2C_ADDRESS, 1, &eeprom);
> +       if (ret)
>                 return BEAGLE_NO_EEPROM;

Isn't this in the devicetree? It should be possible to use
i2c_eeprom_read(). See for example sysinfo_rcar_probe().

> -       }
>
>         /* read configuration data */
> -       i2c_read(EXPANSION_EEPROM_I2C_ADDRESS, 0, 1, (u8 *)&expansion_config,
> -                sizeof(expansion_config));
> +       ret = dm_i2c_read(eeprom, 0, (uint8_t *)&expansion_config,
> +                         sizeof(expansion_config));
> +       if (ret != 0) {
> +               /* return BEAGLE_NO_EEPROM if eeprom doesn't respond */
> +               return BEAGLE_NO_EEPROM;
> +       }
>
> -       /* retry reading configuration data with 16bit addressing */
>         if ((expansion_config.device_vendor == 0xFFFFFF00) ||
>             (expansion_config.device_vendor == 0xFFFFFFFF)) {
>                 printf("EEPROM is blank or 8bit addressing failed: retrying with 16bit:\n");
> -               i2c_read(EXPANSION_EEPROM_I2C_ADDRESS, 0, 2, (u8 *)&expansion_config,
> -                        sizeof(expansion_config));
>         }
>
> -       i2c_set_bus_num(TWL4030_I2C_BUS);
> +       /* retry reading configuration data with 16bit addressing */
> +       ret = i2c_get_chip_for_busnum(EXPANSION_EEPROM_I2C_BUS,
> +                                     EXPANSION_EEPROM_I2C_ADDRESS, 2, &eeprom);
> +       if (ret)
> +               return BEAGLE_NO_EEPROM;
> +
> +       ret = dm_i2c_read(eeprom, 0, (uint8_t *)&expansion_config,
> +                         sizeof(expansion_config));
> +       if (ret != 0)
> +               return BEAGLE_NO_EEPROM;
>
>         return expansion_config.device_vendor;
>  }
> @@ -281,13 +290,13 @@ static void beagle_dvi_pup(void)
>                 #define GPIODATADIR1 (TWL4030_BASEADD_GPIO+3)
>                 #define GPIODATAOUT1 (TWL4030_BASEADD_GPIO+6)
>
> -               i2c_read(TWL4030_CHIP_GPIO, GPIODATADIR1, 1, &val, 1);
> +               twl4030_i2c_read_u8(TWL4030_CHIP_GPIO, GPIODATADIR1, &val);
>                 val |= 4;
> -               i2c_write(TWL4030_CHIP_GPIO, GPIODATADIR1, 1, &val, 1);
> +               twl4030_i2c_write_u8(TWL4030_CHIP_GPIO, GPIODATADIR1, val);
>
> -               i2c_read(TWL4030_CHIP_GPIO, GPIODATAOUT1, 1, &val, 1);
> +               twl4030_i2c_read_u8(TWL4030_CHIP_GPIO, GPIODATAOUT1, &val);
>                 val |= 4;
> -               i2c_write(TWL4030_CHIP_GPIO, GPIODATAOUT1, 1, &val, 1);
> +               twl4030_i2c_write_u8(TWL4030_CHIP_GPIO, GPIODATAOUT1, val);
>                 break;
>         }
>  }
> diff --git a/configs/omap3_beagle_defconfig b/configs/omap3_beagle_defconfig
> index 8a709243a9..f76709389c 100644
> --- a/configs/omap3_beagle_defconfig
> +++ b/configs/omap3_beagle_defconfig
> @@ -61,7 +61,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
>  CONFIG_SPL_OF_TRANSLATE=y
>  CONFIG_USB_FUNCTION_FASTBOOT=y
>  CONFIG_FASTBOOT_BUF_ADDR=0x82000000
> -CONFIG_SYS_I2C_LEGACY=y
> +CONFIG_DM_I2C=y
>  CONFIG_SPL_SYS_I2C_LEGACY=y
>  CONFIG_LED_STATUS=y
>  CONFIG_LED_STATUS0=y
> diff --git a/include/configs/omap3_beagle.h b/include/configs/omap3_beagle.h
> index af7cb3513f..b616dd2608 100644
> --- a/include/configs/omap3_beagle.h
> +++ b/include/configs/omap3_beagle.h
> @@ -28,9 +28,6 @@
>  /* NAND: SPL falcon mode configs */
>  #endif /* CONFIG_MTD_RAW_NAND */
>
> -/* Enable Multi Bus support for I2C */
> -#define CFG_I2C_MULTI_BUS
> -
>  /* DSS Support */
>
>  /* TWL4030 LED Support */
> --
> 2.25.1
>

Regards,
Simon
