Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1F8C5B559
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 14:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98AC482116;
	Wed,  4 Jun 2025 16:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1749047150;
	bh=awamhgP8oDY21kSVeNfREYPDJwFRoyo//2W96II1Nbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hgy/TIs/c9Y1v1ZZY0jfPNQzELm5ENrDk7NYfbtct7jRO7TFkRb1gAjnkcKIPVrDr
	 mrFI8KkSQLlPUold7Kfy2i9nHbaA8bwv/SBek3l4pnmoGrYbCNJ3/XnY4kyXi/nqKF
	 FJEq+3XiuUFOtByJkbarnQHTLPeMk/XXd4hDZqaDoR2tlcOinzWKUtvKNohrVPN4vs
	 aykim+nMTBto3TEQoQqiztzyEnOjjjQydVlfBdz0HfBPJPWVb/6bBPVBqnfKXyblIz
	 C67GKWOvwCCJRUmgfRDhtZdGr3voktY0/oNWOuUyKsGYxWsuv1j24kAbmANUATYKqc
	 Cg3J5sHTiz5EQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A0D81E72; Wed,  4 Jun 2025 16:25:49 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01EB080584
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 16:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lukma@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="csA44+gr"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 18DD710397298; 
 Wed,  4 Jun 2025 16:25:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1749047146; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=awamhgP8oDY21kSVeNfREYPDJwFRoyo//2W96II1Nbg=;
 b=csA44+grA5TOXRXsLRY0EtrzoPh+8CW6XixG26ep+IC86PW4rjMTsC3k3D9CXzz0yafcgB
 LV1BNmo3zybk6J/zRNbtR5Wsm87hBBIwne0ZHwBovfNFOJrCb8vOUkhOu8SNlWSieSO31I
 k80XXSMPEIhF3Z75JdDQpr9QSufUoYrox6Nami3PuRHagvRydGwcqHYWUNo6JC1lEJMhfr
 wHLBtZ43/63jZht2227wyFJME6x+GBk7mtnXfa0MTEMfMVaESPmfM3j6hv55PG2lh1haW9
 lPAm2K9XO9X5R7SzfDeaMMKeWDO0FwU6n81ZxcB4KfnLtVnic+qUrafosFrhmA==
Date: Wed, 4 Jun 2025 16:25:42 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Anshul Dalal
 <anshuld@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] ARM: imx: mxs: Add support for imx287 based BTT devices
Message-ID: <20250604162542.34cccdeb@wsk>
In-Reply-To: <CAOMZO5BXe_vPSf5iK6q3CP8=UqOU3YtYabE6SXBGuF+qhOUvYg@mail.gmail.com>
References: <20250604115437.169451-1-lukma@denx.de>
 <CAOMZO5BXe_vPSf5iK6q3CP8=UqOU3YtYabE6SXBGuF+qhOUvYg@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6248uRpuZy4M8VKbl_OaNe6";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3
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

--Sig_/6248uRpuZy4M8VKbl_OaNe6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Wed, Jun 4, 2025 at 8:55=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wr=
ote:
>=20
> > +source "board/liebherr/btt/Kconfig"
> >  source "board/freescale/mx28evk/Kconfig"
> >  source "board/liebherr/xea/Kconfig" =20
>=20
> Please keep the entries sorted.

Ok.

>=20
> > --- /dev/null
> > +++ b/board/liebherr/btt/btt.c
> > @@ -0,0 +1,449 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * BTT[3C] iMX28 board
> > + *
> > + * Copyright (C) 2025 DENX Software Engineering
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + */
> > +
> > +#include <fdt_support.h>
> > +#include <init.h>
> > +#include <log.h>
> > +#include <net.h>
> > +#include <asm/global_data.h>
> > +#include <asm/gpio.h>
> > +#include <asm/io.h>
> > +#include <asm/arch/imx-regs.h>
> > +#include <asm/arch/iomux-mx28.h>
> > +#include <asm/arch/clock.h>
> > +#include <asm/arch/sys_proto.h>
> > +#include <linux/delay.h>
> > +#include <linux/mii.h>
> > +#include <miiphy.h>
> > +#include <netdev.h>
> > +#include <errno.h>
> > +#include <usb.h> =20
>=20
> Please double-check if all these are necessary. USB seems not to be
> used on this file.

Ok.

>=20
> > +void spl_board_init(void)
> > +{
> > +       struct gpio_desc phy_rst, boot, rescue, wifi_en, bt_en;
> > +       int ret, i;
> > +
> > +       /*
> > +        * On the new HW version of BTTC/3 (with LAN8720ai PHY) the
> > !RST pin
> > +        * (15) is pulled LOW by external resistor. As a result it
> > needs to be
> > +        * set HIGH as soon as possible to allow correct generation
> > of RESET
> > +        * pulse.
> > +        *
> > +        * In the old BTTC (with TLK105 PHY) the RC circuit was
> > used instead
> > +        * to set the RESET pin to HIGH after 100us, so there was
> > no need to
> > +        * set it explicitly.
> > +        */
> > +       ret =3D dm_gpio_lookup_name("GPIO4_12", &phy_rst);
> > +       if (ret)
> > +               printf("Cannot get GPIO4_12\n");
> > +
> > +       ret =3D dm_gpio_request(&phy_rst, "phy-rst");
> > +       if (ret)
> > +               printf("Cannot request GPIO4_12\n");
> > +
> > +       dm_gpio_set_dir_flags(&phy_rst, GPIOD_IS_OUT |
> > GPIOD_IS_OUT_ACTIVE); +
> > +       /*
> > +        * Explicitly set GPIO, which controls WL_EN (wifi) to LOW.
> > On the BTT3
> > +        * it is directly connected to Jody module without any
> > externa pull up
> > +        * down register.
> > +        */
> > +       ret =3D dm_gpio_lookup_name("GPIO0_27", &wifi_en);
> > +       if (ret)
> > +               printf("Cannot get GPIO0_27\n");
> > +
> > +       ret =3D dm_gpio_request(&wifi_en, "wifi-en");
> > +       if (ret)
> > +               printf("Cannot request GPIO0_27\n");
> > +
> > +       dm_gpio_set_dir_flags(&wifi_en, GPIOD_IS_OUT |
> > GPIOD_ACTIVE_LOW |
> > +                             GPIOD_IS_OUT_ACTIVE);
> > +
> > +       /*
> > +        * Explicitly set GPIO, which controls BT_EN (Bluetooth) to
> > LOW. On the
> > +        * BTT3 it is connected to Jody module via RC circuit
> > (after some R*C
> > +        * time this pin is set to HIGH). However, the manual
> > recommends setting
> > +        * it high from LOW state.
> > +        */
> > +       ret =3D dm_gpio_lookup_name("GPIO3_27", &bt_en);
> > +       if (ret)
> > +               printf("Cannot get GPIO3_27\n");
> > +
> > +       ret =3D dm_gpio_request(&bt_en, "bt-en");
> > +       if (ret)
> > +               printf("Cannot request GPIO3_27\n");
> > +
> > +       dm_gpio_set_dir_flags(&bt_en, GPIOD_IS_OUT |
> > GPIOD_ACTIVE_LOW |
> > +                             GPIOD_IS_OUT_ACTIVE); =20
>=20
> Since U-Boot does not support Wi-Fi/Bluetooth, should these pins be
> configured in U-Boot?
>=20
> Why can't the kernel take care of them instead?

This board (and XEA also) uses falcon boot.

In short - we use SPL, and then the Linux is called (uImage + dts).

What I'm trying to solve here is to have _always_, no matter if we
execute Linux from u-boot proper or directly from SPL, the same HW
state.

That is why some pins needs to be setup in SPL. Please also be aware,
that there also can be a "recovery" system run from net or USB, which
can also reboot the board (and we would need consistent state).

>=20
> > +
> > +       /* Address of boot parameters */
> > +       gd->bd->bi_boot_params =3D PHYS_SDRAM_1 + 0x100;
> > +
> > +       cpu_eth_init(NULL);
> > +
> > +       /* PHY INT#/PWDN# */
> > +       ret =3D dm_gpio_lookup_name("GPIO4_13", &phy_rst);
> > +       if (ret) {
> > +               printf("Cannot get GPIO4_13\n");
> > +               return ret;
> > +       }
> > +
> > +       ret =3D dm_gpio_request(&phy_rst, "phy-rst");
> > +       if (ret) {
> > +               printf("Cannot request GPIO4_13\n");
> > +               return ret; =20
>=20
> Can't U-Boot DM handle the Ethernet PHY reset instead?

Please see the above remark.

>=20
> > + * NOTE:
> > + *
> > + * IMX28 clock "stub" DM driver!
> > + *
> > + * Only used for SPL stage, which is NOT using DM; serial and
> > + * eMMC configuration.
> > + */
> > +static const struct udevice_id imx28_clk_ids[] =3D {
> > +       { .compatible =3D "fsl,imx28-clkctrl", },
> > +       { }
> > +};
> > +
> > +U_BOOT_DRIVER(fsl_imx28_clkctrl) =3D {
> > +       .name           =3D "fsl_imx28_clkctrl",
> > +       .id             =3D UCLASS_CLK,
> > +       .of_match       =3D imx28_clk_ids,
> > +}; =20
>=20
> A separate patch should add this.

This shall stay IMHO, as this is a CLK stub for u-boot.sb (which in
fact is very constrained in terms of size - IIRC < 40KiB). It is
required for proper of_platform generation (*.c and *.h files) for SPL.

>=20
> > +#define        MUX_CONFIG_LCD  (MXS_PAD_3V3 | MXS_PAD_4MA |
> > MXS_PAD_NOPULL) +#define        MUX_CONFIG_BOOT (MXS_PAD_3V3)
> > +#define        MUX_CONFIG_TSC  (MXS_PAD_3V3 | MXS_PAD_8MA |
> > MXS_PAD_PULLUP) +#define        MUX_CONFIG_SSP0 (MXS_PAD_3V3 |
> > MXS_PAD_12MA | MXS_PAD_PULLUP) +#define        MUX_CONFIG_SSP2
> > (MXS_PAD_3V3 | MXS_PAD_4MA | MXS_PAD_PULLUP) +#define
> > MUX_CONFIG_ENET (MXS_PAD_3V3 | MXS_PAD_8MA | MXS_PAD_NOPULL)
> > +#define        MUX_CONFIG_EMI  (MXS_PAD_3V3 | MXS_PAD_12MA |
> > MXS_PAD_NOPULL) =20
>=20
> Indentation looks strange here.

Ok, I will look on that.

>=20
> > +
> > +const iomux_cfg_t iomux_setup[] =3D { =20
>=20
> static?

Ok.

>=20
> > +       /* AUART0 IRDA */
> > +       MX28_PAD_AUART0_RX__AUART0_RX,
> > +       MX28_PAD_AUART0_TX__AUART0_TX,
> > +
> > +       /* AUART 4 RS422 */
> > +       MX28_PAD_AUART0_CTS__AUART4_RX,
> > +       MX28_PAD_AUART0_RTS__AUART4_TX,
> > +
> > +       /* USB0 */
> > +       MX28_PAD_AUART1_CTS__USB0_OVERCURRENT,
> > +       MX28_PAD_AUART1_RTS__USB0_ID,
> > +       MX28_PAD_LCD_VSYNC__GPIO_1_28, /* PRW_On */
> > +
> > +       /* USB1 */
> > +       MX28_PAD_PWM2__USB1_OVERCURRENT,
> > +
> > +       /* eMMC */
> > +       MX28_PAD_SSP0_CMD__SSP0_CMD | MUX_CONFIG_SSP0,
> > +       MX28_PAD_SSP0_DATA0__SSP0_D0 | MUX_CONFIG_SSP0,
> > +       MX28_PAD_SSP0_DATA1__SSP0_D1 | MUX_CONFIG_SSP0,
> > +       MX28_PAD_SSP0_DATA2__SSP0_D2 | MUX_CONFIG_SSP0,
> > +       MX28_PAD_SSP0_DATA3__SSP0_D3 | MUX_CONFIG_SSP0,
> > +       MX28_PAD_SSP0_DATA4__SSP0_D4 | MUX_CONFIG_SSP0,
> > +       MX28_PAD_SSP0_DATA5__SSP0_D5 | MUX_CONFIG_SSP0,
> > +       MX28_PAD_SSP0_DATA6__SSP0_D6 | MUX_CONFIG_SSP0,
> > +       MX28_PAD_SSP0_DATA7__SSP0_D7 | MUX_CONFIG_SSP0,
> > +       MX28_PAD_SSP0_DETECT__GPIO_2_9, /* Reset for eMMC */
> > +       MX28_PAD_SSP0_SCK__SSP0_SCK | MUX_CONFIG_SSP0,
> > +
> > +       /* DIG Keys */
> > +       MX28_PAD_GPMI_D00__GPIO_0_0,
> > +       MX28_PAD_GPMI_D01__GPIO_0_1,
> > +       MX28_PAD_GPMI_D02__GPIO_0_2,
> > +       MX28_PAD_GPMI_D03__GPIO_0_3,
> > +       MX28_PAD_GPMI_D04__GPIO_0_4,
> > +       MX28_PAD_GPMI_D05__GPIO_0_5,
> > +       MX28_PAD_GPMI_D06__GPIO_0_6,
> > +       MX28_PAD_GPMI_D07__GPIO_0_7,
> > +
> > +       /* ADR_0-2 */
> > +       MX28_PAD_GPMI_CE1N__GPIO_0_17,
> > +       MX28_PAD_GPMI_CE2N__GPIO_0_18,
> > +       MX28_PAD_GPMI_CE3N__GPIO_0_19,
> > +
> > +       /* Read Keys */
> > +       MX28_PAD_GPMI_RDY0__GPIO_0_20,
> > +
> > +       /* LATCH_EN */
> > +       MX28_PAD_GPMI_RDY1__GPIO_0_21,
> > +
> > +       /* Power off */
> > +       MX28_PAD_GPMI_RDN__GPIO_0_24,
> > +
> > +       /* WIFI EN */
> > +       MX28_PAD_GPMI_CLE__GPIO_0_27,
> > +
> > +       /* I2C1 Touch */
> > +       MX28_PAD_AUART2_CTS__GPIO_3_10,
> > +       MX28_PAD_AUART2_RTS__GPIO_3_11,
> > +       MX28_PAD_GPMI_RDY2__GPIO_0_22, /* Touch Reset */
> > +       MX28_PAD_GPMI_RDY3__GPIO_0_23, /* Touch INT */
> > +
> > +       /* TIVA */
> > +       MX28_PAD_AUART1_RX__SSP2_CARD_DETECT,
> > +       MX28_PAD_SSP2_MISO__SSP2_D0,
> > +       MX28_PAD_SSP2_MOSI__SSP2_CMD,
> > +       MX28_PAD_SSP2_SCK__SSP2_SCK,
> > +       MX28_PAD_SSP2_SS0__SSP2_D3,
> > +       MX28_PAD_SSP2_SS1__GPIO_2_20,
> > +       MX28_PAD_SSP2_SS2__GPIO_2_21,
> > +
> > +       /* SPI3 NOR-Flash */
> > +       MX28_PAD_AUART1_TX__SSP3_CARD_DETECT,
> > +       MX28_PAD_AUART2_RX__SSP3_D1,
> > +       MX28_PAD_AUART2_TX__SSP3_D2,
> > +       MX28_PAD_SSP3_MISO__SSP3_D0,
> > +       MX28_PAD_SSP3_MOSI__SSP3_CMD,
> > +       MX28_PAD_SSP3_SCK__SSP3_SCK,
> > +       MX28_PAD_SSP3_SS0__SSP3_D3,
> > +
> > +       /* NOR-Flash CMD */
> > +       MX28_PAD_LCD_RS__GPIO_1_26, /* Hold */
> > +       MX28_PAD_LCD_WR_RWN__GPIO_1_25, /* write protect */
> > +
> > +       /* I2C0 Codec */
> > +       MX28_PAD_I2C0_SCL__I2C0_SCL,
> > +       MX28_PAD_I2C0_SDA__I2C0_SDA,
> > +
> > +       /* I2S Codec */
> > +       MX28_PAD_SAIF0_BITCLK__SAIF0_BITCLK,
> > +       MX28_PAD_SAIF0_LRCLK__SAIF0_LRCLK,
> > +       MX28_PAD_SAIF0_MCLK__SAIF0_MCLK,
> > +       MX28_PAD_SAIF0_SDATA0__SAIF0_SDATA0,
> > +       MX28_PAD_SAIF1_SDATA0__SAIF1_SDATA0,
> > +
> > +       /* BT_EN */
> > +       MX28_PAD_SPDIF__GPIO_3_27,
> > +
> > +       /* EMI */
> > +       MX28_PAD_EMI_D00__EMI_DATA0 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_D01__EMI_DATA1 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_D02__EMI_DATA2 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_D03__EMI_DATA3 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_D04__EMI_DATA4 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_D05__EMI_DATA5 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_D06__EMI_DATA6 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_D07__EMI_DATA7 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_D08__EMI_DATA8 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_D09__EMI_DATA9 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_D10__EMI_DATA10 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_D11__EMI_DATA11 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_D12__EMI_DATA12 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_D13__EMI_DATA13 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_D14__EMI_DATA14 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_D15__EMI_DATA15 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_ODT0__EMI_ODT0 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_DQM0__EMI_DQM0 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_ODT1__EMI_ODT1 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_DQM1__EMI_DQM1 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_DDR_OPEN_FB__EMI_DDR_OPEN_FEEDBACK |
> > MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_CLK__EMI_CLK | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_DQS0__EMI_DQS0 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_DQS1__EMI_DQS1 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_DDR_OPEN__EMI_DDR_OPEN | MUX_CONFIG_EMI,
> > +
> > +       MX28_PAD_EMI_A00__EMI_ADDR0 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_A01__EMI_ADDR1 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_A02__EMI_ADDR2 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_A03__EMI_ADDR3 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_A04__EMI_ADDR4 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_A05__EMI_ADDR5 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_A06__EMI_ADDR6 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_A07__EMI_ADDR7 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_A08__EMI_ADDR8 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_A09__EMI_ADDR9 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_A10__EMI_ADDR10 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_A11__EMI_ADDR11 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_A12__EMI_ADDR12 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_A13__EMI_ADDR13 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_A14__EMI_ADDR14 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_BA0__EMI_BA0 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_BA1__EMI_BA1 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_BA2__EMI_BA2 | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_CASN__EMI_CASN | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_RASN__EMI_RASN | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_WEN__EMI_WEN | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_CE0N__EMI_CE0N | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_CE1N__EMI_CE1N | MUX_CONFIG_EMI,
> > +       MX28_PAD_EMI_CKE__EMI_CKE | MUX_CONFIG_EMI,
> > +
> > +       /* Uart3 Bluetooth-Interface */
> > +       MX28_PAD_AUART3_CTS__AUART3_CTS,
> > +       MX28_PAD_AUART3_RTS__AUART3_RTS,
> > +       MX28_PAD_AUART3_RX__AUART3_RX,
> > +       MX28_PAD_AUART3_TX__AUART3_TX,
> > +
> > +       /* framebuffer */
> > +       MX28_PAD_LCD_CS__LCD_CS | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D00__LCD_D0 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D01__LCD_D1 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D02__LCD_D2 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D03__LCD_D3 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D04__LCD_D4 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D05__LCD_D5 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D06__LCD_D6 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D07__LCD_D7 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D08__LCD_D8 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D09__LCD_D9 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D10__LCD_D10 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D11__LCD_D11 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D12__LCD_D12 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D13__LCD_D13 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D14__LCD_D14 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D15__LCD_D15 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D16__LCD_D16 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D17__LCD_D17 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D18__LCD_D18 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D19__LCD_D19 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D20__LCD_D20 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D21__LCD_D21 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D22__LCD_D22 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_D23__LCD_D23 | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_DOTCLK__LCD_DOTCLK | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_ENABLE__LCD_ENABLE | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_HSYNC__LCD_HSYNC | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_RD_E__LCD_VSYNC | MUX_CONFIG_LCD,
> > +       MX28_PAD_LCD_RESET__LCD_RESET | MUX_CONFIG_LCD,
> > +
> > +       /* DUART RS232 */
> > +       MX28_PAD_PWM0__DUART_RX,
> > +       MX28_PAD_PWM1__DUART_TX,
> > +
> > +       /* Backlight */
> > +       MX28_PAD_PWM3__PWM_3,
> > +
> > +       /* FEC Ethernet */
> > +       MX28_PAD_ENET_CLK__CLKCTRL_ENET | MUX_CONFIG_ENET,
> > +       MX28_PAD_ENET0_COL__ENET1_TX_EN | MUX_CONFIG_ENET,
> > +       MX28_PAD_ENET0_CRS__ENET1_RX_EN | MUX_CONFIG_ENET,
> > +       MX28_PAD_ENET0_MDC__ENET0_MDC | MUX_CONFIG_ENET,
> > +       MX28_PAD_ENET0_MDIO__ENET0_MDIO | MUX_CONFIG_ENET,
> > +       MX28_PAD_ENET0_RX_CLK__GPIO_4_13, /* Phy Interrupt */
> > +       MX28_PAD_ENET0_RX_EN__ENET0_RX_EN | MUX_CONFIG_ENET,
> > +       MX28_PAD_ENET0_RXD0__ENET0_RXD0 | MUX_CONFIG_ENET,
> > +       MX28_PAD_ENET0_RXD1__ENET0_RXD1 | MUX_CONFIG_ENET,
> > +       MX28_PAD_ENET0_RXD3__ENET1_RXD1 | MUX_CONFIG_ENET,
> > +       MX28_PAD_ENET0_TX_CLK__GPIO_4_5, /* n.c. */
> > +       MX28_PAD_ENET0_TX_EN__ENET0_TX_EN | MUX_CONFIG_ENET,
> > +       MX28_PAD_ENET0_TXD0__ENET0_TXD0 | MUX_CONFIG_ENET,
> > +       MX28_PAD_ENET0_TXD1__ENET0_TXD1 | MUX_CONFIG_ENET,
> > +       MX28_PAD_ENET0_TXD3__ENET1_TXD1 | MUX_CONFIG_ENET,
> > +       MX28_PAD_ENET0_TXD3__GPIO_4_12, /* PHY reset */
> > +
> > +       /* boot/rescue pins */
> > +       MX28_PAD_ENET0_RXD2__GPIO_4_9,
> > +       MX28_PAD_ENET0_TXD2__GPIO_4_11,
> > +
> > +       /* HW revision setup pins - by default pullup DISABLED */
> > +       MX28_PAD_ENET0_RXD3__GPIO_4_10,
> > +       MX28_PAD_ENET0_TX_CLK__GPIO_4_5,
> > +       MX28_PAD_ENET0_COL__GPIO_4_14,
> > +       MX28_PAD_ENET0_CRS__GPIO_4_15, =20
>=20
> What is the reason for doing a complete pinctrl configuration inside
> SPL?
>=20
> Can't you configure only the pins that SPL needs?

The reason is as I've mentioned above.

>=20
> > +#ifndef CONFIG_SPL_FRAMEWORK
> > +void board_init_ll(const u32 arg, const uint32_t *resptr)
> > +{
> > +       mxs_common_spl_init(arg, resptr, iomux_setup,
> > ARRAY_SIZE(iomux_setup)); +}
> > +#else
> > +void lowlevel_init(void)
> > +{
> > +       struct mxs_pinctrl_regs *pinctrl_regs =3D
> > +               (struct mxs_pinctrl_regs *)MXS_PINCTRL_BASE;
> > +
> > +       /* Set EMI drive strength */
> > +       writel(0x00003fff,
> > &pinctrl_regs->hw_pinctrl_emi_ds_ctrl_clr);
> > +       writel(0x00002aaa,
> > &pinctrl_regs->hw_pinctrl_emi_ds_ctrl_set); =20
>=20
> Please use defines instead of hardcoded values.

To be honest - this is probably took from first imx28-evk ports....
Probably people who wrote them are now retired :-)

>=20
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright (C) 2025 DENX Software Engineering
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + */
> > +#ifndef __CONFIGS_BTT_H__
> > +#define __CONFIGS_BTT_H__
> > +
> > +/* Memory configuration */
> > +#define PHYS_SDRAM_1                   0x40000000      /* Base
> > address */ +#define PHYS_SDRAM_1_SIZE              0x10000000
> > /* Max 256 MB RAM */ =20
>=20
> You could use SZ_256M and remove the comment.

Ok.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/6248uRpuZy4M8VKbl_OaNe6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhAV2YACgkQAR8vZIA0
zr1JeAf/c9t4ir3lTdiuoguYSVv/x4zIbsAHSRdJH64sSPxl1UkEdFjGzzQ53P2/
X5EIDkTkJ/KDETcvvtRsESlOzVvlWjzVYGrItEiaxj6kgii3nmIml5Rk2CjfgOLb
acHwJ7uDNR8x9577VbSXEmlqRM9vpLelh78YYDyuinfYgGJDBI3fTTC4mrh5yjiY
GJM27q9B273BiNEe3CDsavt/qpMWkWLwddE+oL89dmV+PLZ3lS3o+skIzRoTkGPH
FwDqVyID9WM4u51vVAXStUZ97YehRWqS9h9aawX4qA3n3/eR5RpJ3JtSBdRX9Vsk
p6p7H20pCeo9IhfkCAW3iNAdZkna9A==
=rJ/a
-----END PGP SIGNATURE-----

--Sig_/6248uRpuZy4M8VKbl_OaNe6--
