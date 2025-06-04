Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F9DC5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 13:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65F1380584;
	Wed,  4 Jun 2025 15:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YY9aZovI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C38FE8070C; Wed,  4 Jun 2025 15:50:06 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 722798004F
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 15:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5533a86a134so6096007e87.3
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 06:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749045004; x=1749649804; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73cPr8GF//umfRT5quh+yPhH+JUrcpl7/h8gz0mJJ4k=;
 b=YY9aZovIpA39zAf0Hxg/wnePEHXkl1s6jTomQuPtVvLJUB9r1rIFm3Z+l8NvEzpuZQ
 pj5/fqhrj16zinWz1JWUNuUzFrzoFbOeCdfQbLgVFEgIlEbqY8aNU/Btee/pMWoDeP/c
 pi58MD2HAIHJFNQ1EFcCwwZ/fx4p7y4dDJwH9Z8cTNUTWM0x3RNBmat9LTexTVmDsRii
 +7ROMJHqplYRY9xrEkIvLe148uVmi8JbeI3F/iasuyen6IcKlt6WqRs4IV27pfqCOQI3
 shwxiaASf7Siwl8d9+OwC8uhBg7Pwkz8XCV5c3QHcukaK1OBle7Z5NNJy4eHhEuAPZJq
 GAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749045004; x=1749649804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=73cPr8GF//umfRT5quh+yPhH+JUrcpl7/h8gz0mJJ4k=;
 b=RKUKjOA4J6jsX27x2mWwGdkm4MUPhUJbZw70zFcmhjMBsuROIbb4zvMRwxPhEP77y6
 U1j5IEtXZ6UhsvMWqvOzwOgO43P6QXANE6uNOqpY5TBJEjgXbT23e8ds3bH4Up9c44Qt
 /kmq2JiIgadH8og7ncJErDsZlzYMt8C7AtCJOyDhdAkKa2RWgU4IZ8w1FgoCIGrEGLXX
 WENPC0Bk9xxxhQx7C/SGRnPxRkNlNMHggKhc7V0f89pJTL2b5j47hkkp/wVNI5q4V9Rx
 nY5MEkFDLJZ3ruwJYW0Wx5OmRuj59Wyaql/MoTN6COJp/9RUor2iDDQmVKT7b/S5LQi1
 IrYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVALAJ8BHzsPCG2uxORq48z3LL1ssKg2aaKAkElO9hGrHvSR52S+Jd2Gic3szXq07wr15mqPfI=@lists.denx.de
X-Gm-Message-State: AOJu0Yww2S1Ym9/+Sp4JbnH7IXAnO7mNaaBevOtMAPN5V3Rz9GRm0756
 XqYcq4r0AUwKzt67WLzA7BGzPd09bF45RLJQq+0Y5buvulsPEMpYaUs/9uWTBZ7hBpYGCNDJ6OE
 rARMEpuQihcElTlTlV6xTEubICzzgB5o=
X-Gm-Gg: ASbGncu4hp/9pfIkLvFUdP4ObOi6RPBysAFtMOnBtQK1H74hNTyLH2lsDSDnfrFeJnL
 A8lvDg7wBpcI/PNHRMGuteQTQj0n6KiNk6o/nf+IhgDNX4fgz3ysK9y0DdiQAtidNkC2CxUaTO0
 1IlZ9Lr/DkS91IX5qFE8WEwrE4rZJjXmn2Zab6Bw40JvocauwgVMQ3d9NSp0EM5Wsuc6MbdON/y
 /M=
X-Google-Smtp-Source: AGHT+IFVN9pLexb5viaEaTKwiBYra8gaBB2trGik025hIuei3njslFHWiewoZ1A2kOHoVKfICMS9zpMBUEUGEl5wT2U=
X-Received: by 2002:a05:6512:b90:b0:550:e527:886f with SMTP id
 2adb3069b0e04-55356df40b7mr895980e87.51.1749045003323; Wed, 04 Jun 2025
 06:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250604115437.169451-1-lukma@denx.de>
In-Reply-To: <20250604115437.169451-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 4 Jun 2025 10:49:51 -0300
X-Gm-Features: AX0GCFsuMs_hI9tiuscaEpZOH3M-PDPuYA_I7c4rm8QIVaxdMQabZjKFXZjmefw
Message-ID: <CAOMZO5BXe_vPSf5iK6q3CP8=UqOU3YtYabE6SXBGuF+qhOUvYg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: imx: mxs: Add support for imx287 based BTT devices
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Lukasz,

On Wed, Jun 4, 2025 at 8:55=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wrot=
e:

> +source "board/liebherr/btt/Kconfig"
>  source "board/freescale/mx28evk/Kconfig"
>  source "board/liebherr/xea/Kconfig"

Please keep the entries sorted.

> --- /dev/null
> +++ b/board/liebherr/btt/btt.c
> @@ -0,0 +1,449 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * BTT[3C] iMX28 board
> + *
> + * Copyright (C) 2025 DENX Software Engineering
> + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> + */
> +
> +#include <fdt_support.h>
> +#include <init.h>
> +#include <log.h>
> +#include <net.h>
> +#include <asm/global_data.h>
> +#include <asm/gpio.h>
> +#include <asm/io.h>
> +#include <asm/arch/imx-regs.h>
> +#include <asm/arch/iomux-mx28.h>
> +#include <asm/arch/clock.h>
> +#include <asm/arch/sys_proto.h>
> +#include <linux/delay.h>
> +#include <linux/mii.h>
> +#include <miiphy.h>
> +#include <netdev.h>
> +#include <errno.h>
> +#include <usb.h>

Please double-check if all these are necessary. USB seems not to be
used on this file.

> +void spl_board_init(void)
> +{
> +       struct gpio_desc phy_rst, boot, rescue, wifi_en, bt_en;
> +       int ret, i;
> +
> +       /*
> +        * On the new HW version of BTTC/3 (with LAN8720ai PHY) the !RST =
pin
> +        * (15) is pulled LOW by external resistor. As a result it needs =
to be
> +        * set HIGH as soon as possible to allow correct generation of RE=
SET
> +        * pulse.
> +        *
> +        * In the old BTTC (with TLK105 PHY) the RC circuit was used inst=
ead
> +        * to set the RESET pin to HIGH after 100us, so there was no need=
 to
> +        * set it explicitly.
> +        */
> +       ret =3D dm_gpio_lookup_name("GPIO4_12", &phy_rst);
> +       if (ret)
> +               printf("Cannot get GPIO4_12\n");
> +
> +       ret =3D dm_gpio_request(&phy_rst, "phy-rst");
> +       if (ret)
> +               printf("Cannot request GPIO4_12\n");
> +
> +       dm_gpio_set_dir_flags(&phy_rst, GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIV=
E);
> +
> +       /*
> +        * Explicitly set GPIO, which controls WL_EN (wifi) to LOW. On th=
e BTT3
> +        * it is directly connected to Jody module without any externa pu=
ll up
> +        * down register.
> +        */
> +       ret =3D dm_gpio_lookup_name("GPIO0_27", &wifi_en);
> +       if (ret)
> +               printf("Cannot get GPIO0_27\n");
> +
> +       ret =3D dm_gpio_request(&wifi_en, "wifi-en");
> +       if (ret)
> +               printf("Cannot request GPIO0_27\n");
> +
> +       dm_gpio_set_dir_flags(&wifi_en, GPIOD_IS_OUT | GPIOD_ACTIVE_LOW |
> +                             GPIOD_IS_OUT_ACTIVE);
> +
> +       /*
> +        * Explicitly set GPIO, which controls BT_EN (Bluetooth) to LOW. =
On the
> +        * BTT3 it is connected to Jody module via RC circuit (after some=
 R*C
> +        * time this pin is set to HIGH). However, the manual recommends =
setting
> +        * it high from LOW state.
> +        */
> +       ret =3D dm_gpio_lookup_name("GPIO3_27", &bt_en);
> +       if (ret)
> +               printf("Cannot get GPIO3_27\n");
> +
> +       ret =3D dm_gpio_request(&bt_en, "bt-en");
> +       if (ret)
> +               printf("Cannot request GPIO3_27\n");
> +
> +       dm_gpio_set_dir_flags(&bt_en, GPIOD_IS_OUT | GPIOD_ACTIVE_LOW |
> +                             GPIOD_IS_OUT_ACTIVE);

Since U-Boot does not support Wi-Fi/Bluetooth, should these pins be
configured in U-Boot?

Why can't the kernel take care of them instead?

> +
> +       /* Address of boot parameters */
> +       gd->bd->bi_boot_params =3D PHYS_SDRAM_1 + 0x100;
> +
> +       cpu_eth_init(NULL);
> +
> +       /* PHY INT#/PWDN# */
> +       ret =3D dm_gpio_lookup_name("GPIO4_13", &phy_rst);
> +       if (ret) {
> +               printf("Cannot get GPIO4_13\n");
> +               return ret;
> +       }
> +
> +       ret =3D dm_gpio_request(&phy_rst, "phy-rst");
> +       if (ret) {
> +               printf("Cannot request GPIO4_13\n");
> +               return ret;

Can't U-Boot DM handle the Ethernet PHY reset instead?

> + * NOTE:
> + *
> + * IMX28 clock "stub" DM driver!
> + *
> + * Only used for SPL stage, which is NOT using DM; serial and
> + * eMMC configuration.
> + */
> +static const struct udevice_id imx28_clk_ids[] =3D {
> +       { .compatible =3D "fsl,imx28-clkctrl", },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(fsl_imx28_clkctrl) =3D {
> +       .name           =3D "fsl_imx28_clkctrl",
> +       .id             =3D UCLASS_CLK,
> +       .of_match       =3D imx28_clk_ids,
> +};

A separate patch should add this.

> +#define        MUX_CONFIG_LCD  (MXS_PAD_3V3 | MXS_PAD_4MA | MXS_PAD_NOPU=
LL)
> +#define        MUX_CONFIG_BOOT (MXS_PAD_3V3)
> +#define        MUX_CONFIG_TSC  (MXS_PAD_3V3 | MXS_PAD_8MA | MXS_PAD_PULL=
UP)
> +#define        MUX_CONFIG_SSP0 (MXS_PAD_3V3 | MXS_PAD_12MA | MXS_PAD_PUL=
LUP)
> +#define        MUX_CONFIG_SSP2 (MXS_PAD_3V3 | MXS_PAD_4MA | MXS_PAD_PULL=
UP)
> +#define        MUX_CONFIG_ENET (MXS_PAD_3V3 | MXS_PAD_8MA | MXS_PAD_NOPU=
LL)
> +#define        MUX_CONFIG_EMI  (MXS_PAD_3V3 | MXS_PAD_12MA | MXS_PAD_NOP=
ULL)

Indentation looks strange here.

> +
> +const iomux_cfg_t iomux_setup[] =3D {

static?

> +       /* AUART0 IRDA */
> +       MX28_PAD_AUART0_RX__AUART0_RX,
> +       MX28_PAD_AUART0_TX__AUART0_TX,
> +
> +       /* AUART 4 RS422 */
> +       MX28_PAD_AUART0_CTS__AUART4_RX,
> +       MX28_PAD_AUART0_RTS__AUART4_TX,
> +
> +       /* USB0 */
> +       MX28_PAD_AUART1_CTS__USB0_OVERCURRENT,
> +       MX28_PAD_AUART1_RTS__USB0_ID,
> +       MX28_PAD_LCD_VSYNC__GPIO_1_28, /* PRW_On */
> +
> +       /* USB1 */
> +       MX28_PAD_PWM2__USB1_OVERCURRENT,
> +
> +       /* eMMC */
> +       MX28_PAD_SSP0_CMD__SSP0_CMD | MUX_CONFIG_SSP0,
> +       MX28_PAD_SSP0_DATA0__SSP0_D0 | MUX_CONFIG_SSP0,
> +       MX28_PAD_SSP0_DATA1__SSP0_D1 | MUX_CONFIG_SSP0,
> +       MX28_PAD_SSP0_DATA2__SSP0_D2 | MUX_CONFIG_SSP0,
> +       MX28_PAD_SSP0_DATA3__SSP0_D3 | MUX_CONFIG_SSP0,
> +       MX28_PAD_SSP0_DATA4__SSP0_D4 | MUX_CONFIG_SSP0,
> +       MX28_PAD_SSP0_DATA5__SSP0_D5 | MUX_CONFIG_SSP0,
> +       MX28_PAD_SSP0_DATA6__SSP0_D6 | MUX_CONFIG_SSP0,
> +       MX28_PAD_SSP0_DATA7__SSP0_D7 | MUX_CONFIG_SSP0,
> +       MX28_PAD_SSP0_DETECT__GPIO_2_9, /* Reset for eMMC */
> +       MX28_PAD_SSP0_SCK__SSP0_SCK | MUX_CONFIG_SSP0,
> +
> +       /* DIG Keys */
> +       MX28_PAD_GPMI_D00__GPIO_0_0,
> +       MX28_PAD_GPMI_D01__GPIO_0_1,
> +       MX28_PAD_GPMI_D02__GPIO_0_2,
> +       MX28_PAD_GPMI_D03__GPIO_0_3,
> +       MX28_PAD_GPMI_D04__GPIO_0_4,
> +       MX28_PAD_GPMI_D05__GPIO_0_5,
> +       MX28_PAD_GPMI_D06__GPIO_0_6,
> +       MX28_PAD_GPMI_D07__GPIO_0_7,
> +
> +       /* ADR_0-2 */
> +       MX28_PAD_GPMI_CE1N__GPIO_0_17,
> +       MX28_PAD_GPMI_CE2N__GPIO_0_18,
> +       MX28_PAD_GPMI_CE3N__GPIO_0_19,
> +
> +       /* Read Keys */
> +       MX28_PAD_GPMI_RDY0__GPIO_0_20,
> +
> +       /* LATCH_EN */
> +       MX28_PAD_GPMI_RDY1__GPIO_0_21,
> +
> +       /* Power off */
> +       MX28_PAD_GPMI_RDN__GPIO_0_24,
> +
> +       /* WIFI EN */
> +       MX28_PAD_GPMI_CLE__GPIO_0_27,
> +
> +       /* I2C1 Touch */
> +       MX28_PAD_AUART2_CTS__GPIO_3_10,
> +       MX28_PAD_AUART2_RTS__GPIO_3_11,
> +       MX28_PAD_GPMI_RDY2__GPIO_0_22, /* Touch Reset */
> +       MX28_PAD_GPMI_RDY3__GPIO_0_23, /* Touch INT */
> +
> +       /* TIVA */
> +       MX28_PAD_AUART1_RX__SSP2_CARD_DETECT,
> +       MX28_PAD_SSP2_MISO__SSP2_D0,
> +       MX28_PAD_SSP2_MOSI__SSP2_CMD,
> +       MX28_PAD_SSP2_SCK__SSP2_SCK,
> +       MX28_PAD_SSP2_SS0__SSP2_D3,
> +       MX28_PAD_SSP2_SS1__GPIO_2_20,
> +       MX28_PAD_SSP2_SS2__GPIO_2_21,
> +
> +       /* SPI3 NOR-Flash */
> +       MX28_PAD_AUART1_TX__SSP3_CARD_DETECT,
> +       MX28_PAD_AUART2_RX__SSP3_D1,
> +       MX28_PAD_AUART2_TX__SSP3_D2,
> +       MX28_PAD_SSP3_MISO__SSP3_D0,
> +       MX28_PAD_SSP3_MOSI__SSP3_CMD,
> +       MX28_PAD_SSP3_SCK__SSP3_SCK,
> +       MX28_PAD_SSP3_SS0__SSP3_D3,
> +
> +       /* NOR-Flash CMD */
> +       MX28_PAD_LCD_RS__GPIO_1_26, /* Hold */
> +       MX28_PAD_LCD_WR_RWN__GPIO_1_25, /* write protect */
> +
> +       /* I2C0 Codec */
> +       MX28_PAD_I2C0_SCL__I2C0_SCL,
> +       MX28_PAD_I2C0_SDA__I2C0_SDA,
> +
> +       /* I2S Codec */
> +       MX28_PAD_SAIF0_BITCLK__SAIF0_BITCLK,
> +       MX28_PAD_SAIF0_LRCLK__SAIF0_LRCLK,
> +       MX28_PAD_SAIF0_MCLK__SAIF0_MCLK,
> +       MX28_PAD_SAIF0_SDATA0__SAIF0_SDATA0,
> +       MX28_PAD_SAIF1_SDATA0__SAIF1_SDATA0,
> +
> +       /* BT_EN */
> +       MX28_PAD_SPDIF__GPIO_3_27,
> +
> +       /* EMI */
> +       MX28_PAD_EMI_D00__EMI_DATA0 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_D01__EMI_DATA1 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_D02__EMI_DATA2 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_D03__EMI_DATA3 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_D04__EMI_DATA4 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_D05__EMI_DATA5 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_D06__EMI_DATA6 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_D07__EMI_DATA7 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_D08__EMI_DATA8 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_D09__EMI_DATA9 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_D10__EMI_DATA10 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_D11__EMI_DATA11 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_D12__EMI_DATA12 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_D13__EMI_DATA13 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_D14__EMI_DATA14 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_D15__EMI_DATA15 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_ODT0__EMI_ODT0 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_DQM0__EMI_DQM0 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_ODT1__EMI_ODT1 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_DQM1__EMI_DQM1 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_DDR_OPEN_FB__EMI_DDR_OPEN_FEEDBACK | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_CLK__EMI_CLK | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_DQS0__EMI_DQS0 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_DQS1__EMI_DQS1 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_DDR_OPEN__EMI_DDR_OPEN | MUX_CONFIG_EMI,
> +
> +       MX28_PAD_EMI_A00__EMI_ADDR0 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_A01__EMI_ADDR1 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_A02__EMI_ADDR2 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_A03__EMI_ADDR3 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_A04__EMI_ADDR4 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_A05__EMI_ADDR5 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_A06__EMI_ADDR6 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_A07__EMI_ADDR7 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_A08__EMI_ADDR8 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_A09__EMI_ADDR9 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_A10__EMI_ADDR10 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_A11__EMI_ADDR11 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_A12__EMI_ADDR12 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_A13__EMI_ADDR13 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_A14__EMI_ADDR14 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_BA0__EMI_BA0 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_BA1__EMI_BA1 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_BA2__EMI_BA2 | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_CASN__EMI_CASN | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_RASN__EMI_RASN | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_WEN__EMI_WEN | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_CE0N__EMI_CE0N | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_CE1N__EMI_CE1N | MUX_CONFIG_EMI,
> +       MX28_PAD_EMI_CKE__EMI_CKE | MUX_CONFIG_EMI,
> +
> +       /* Uart3 Bluetooth-Interface */
> +       MX28_PAD_AUART3_CTS__AUART3_CTS,
> +       MX28_PAD_AUART3_RTS__AUART3_RTS,
> +       MX28_PAD_AUART3_RX__AUART3_RX,
> +       MX28_PAD_AUART3_TX__AUART3_TX,
> +
> +       /* framebuffer */
> +       MX28_PAD_LCD_CS__LCD_CS | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D00__LCD_D0 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D01__LCD_D1 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D02__LCD_D2 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D03__LCD_D3 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D04__LCD_D4 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D05__LCD_D5 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D06__LCD_D6 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D07__LCD_D7 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D08__LCD_D8 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D09__LCD_D9 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D10__LCD_D10 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D11__LCD_D11 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D12__LCD_D12 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D13__LCD_D13 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D14__LCD_D14 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D15__LCD_D15 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D16__LCD_D16 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D17__LCD_D17 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D18__LCD_D18 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D19__LCD_D19 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D20__LCD_D20 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D21__LCD_D21 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D22__LCD_D22 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_D23__LCD_D23 | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_DOTCLK__LCD_DOTCLK | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_ENABLE__LCD_ENABLE | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_HSYNC__LCD_HSYNC | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_RD_E__LCD_VSYNC | MUX_CONFIG_LCD,
> +       MX28_PAD_LCD_RESET__LCD_RESET | MUX_CONFIG_LCD,
> +
> +       /* DUART RS232 */
> +       MX28_PAD_PWM0__DUART_RX,
> +       MX28_PAD_PWM1__DUART_TX,
> +
> +       /* Backlight */
> +       MX28_PAD_PWM3__PWM_3,
> +
> +       /* FEC Ethernet */
> +       MX28_PAD_ENET_CLK__CLKCTRL_ENET | MUX_CONFIG_ENET,
> +       MX28_PAD_ENET0_COL__ENET1_TX_EN | MUX_CONFIG_ENET,
> +       MX28_PAD_ENET0_CRS__ENET1_RX_EN | MUX_CONFIG_ENET,
> +       MX28_PAD_ENET0_MDC__ENET0_MDC | MUX_CONFIG_ENET,
> +       MX28_PAD_ENET0_MDIO__ENET0_MDIO | MUX_CONFIG_ENET,
> +       MX28_PAD_ENET0_RX_CLK__GPIO_4_13, /* Phy Interrupt */
> +       MX28_PAD_ENET0_RX_EN__ENET0_RX_EN | MUX_CONFIG_ENET,
> +       MX28_PAD_ENET0_RXD0__ENET0_RXD0 | MUX_CONFIG_ENET,
> +       MX28_PAD_ENET0_RXD1__ENET0_RXD1 | MUX_CONFIG_ENET,
> +       MX28_PAD_ENET0_RXD3__ENET1_RXD1 | MUX_CONFIG_ENET,
> +       MX28_PAD_ENET0_TX_CLK__GPIO_4_5, /* n.c. */
> +       MX28_PAD_ENET0_TX_EN__ENET0_TX_EN | MUX_CONFIG_ENET,
> +       MX28_PAD_ENET0_TXD0__ENET0_TXD0 | MUX_CONFIG_ENET,
> +       MX28_PAD_ENET0_TXD1__ENET0_TXD1 | MUX_CONFIG_ENET,
> +       MX28_PAD_ENET0_TXD3__ENET1_TXD1 | MUX_CONFIG_ENET,
> +       MX28_PAD_ENET0_TXD3__GPIO_4_12, /* PHY reset */
> +
> +       /* boot/rescue pins */
> +       MX28_PAD_ENET0_RXD2__GPIO_4_9,
> +       MX28_PAD_ENET0_TXD2__GPIO_4_11,
> +
> +       /* HW revision setup pins - by default pullup DISABLED */
> +       MX28_PAD_ENET0_RXD3__GPIO_4_10,
> +       MX28_PAD_ENET0_TX_CLK__GPIO_4_5,
> +       MX28_PAD_ENET0_COL__GPIO_4_14,
> +       MX28_PAD_ENET0_CRS__GPIO_4_15,

What is the reason for doing a complete pinctrl configuration inside SPL?

Can't you configure only the pins that SPL needs?

> +#ifndef CONFIG_SPL_FRAMEWORK
> +void board_init_ll(const u32 arg, const uint32_t *resptr)
> +{
> +       mxs_common_spl_init(arg, resptr, iomux_setup, ARRAY_SIZE(iomux_se=
tup));
> +}
> +#else
> +void lowlevel_init(void)
> +{
> +       struct mxs_pinctrl_regs *pinctrl_regs =3D
> +               (struct mxs_pinctrl_regs *)MXS_PINCTRL_BASE;
> +
> +       /* Set EMI drive strength */
> +       writel(0x00003fff, &pinctrl_regs->hw_pinctrl_emi_ds_ctrl_clr);
> +       writel(0x00002aaa, &pinctrl_regs->hw_pinctrl_emi_ds_ctrl_set);

Please use defines instead of hardcoded values.

> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2025 DENX Software Engineering
> + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> + */
> +#ifndef __CONFIGS_BTT_H__
> +#define __CONFIGS_BTT_H__
> +
> +/* Memory configuration */
> +#define PHYS_SDRAM_1                   0x40000000      /* Base address *=
/
> +#define PHYS_SDRAM_1_SIZE              0x10000000      /* Max 256 MB RAM=
 */

You could use SZ_256M and remove the comment.
