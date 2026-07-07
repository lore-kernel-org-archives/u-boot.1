Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C416EC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 08:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA1C2846B4;
	Tue,  7 Jul 2026 10:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KuF1vlzb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06C3284844; Tue,  7 Jul 2026 10:14:19 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74867801A9
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 10:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c9d1fc053e0so3234349a12.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 01:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783412055; cv=none;
 d=google.com; s=arc-20260327;
 b=Xa0tdftOxOpa04eG824WK6Xx12UOoNnv0SELzQX5t17tiZz57rIGl8u/Ocd85vmQ4W
 pWV1pOOnvR+AMrFKy9Jcsny/VX8m9fc0DgF/1gzd6TwrjWrjpiXCNOvMd4Mx2LdDWGYN
 J1DkRK5E3rjWj+SYVyckysf0EEWROKI1JOo6oQYVaVeVaH1JOKkgO+sbsOsIkyC+iaeQ
 sf/OQn2JSelqRwHOWSs+EL3cYbirjOEwuYGgyLmvD/AORCcS2RXukSH+jtzVZy9/4R5P
 qXfdiO34VlKQNPvUGgSGhtrzFXdFbyGLhyZHQjFkBi6VfBWFgzy2xnd86Um9wew/ICHz
 ImxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2LPWQEMH1uPUJ0lNqDQY3X+iT/p0KjThx8BBwTOpv0s=;
 fh=czSSP/LUr8ZZbp/8thY4FtDQo7KtY703J0qadFIGkmM=;
 b=PljWPOv5h1B/i5eNcNw89fsOHe/qmaUlskfBwr77/AIZlvC2oL6SesEqA8t0G2PPHr
 ikF2h8lZCkXNPlpIQMns0X41OSBA49lKlt0R8mUb14g69ZLz+4YhAtdT0jssRT3cSLR3
 ujZ7HneceIC13QomwvwfbJ/8V4dKRWf4IuKwkVJfcv94RMV3dSwLllT/Ptq6Th3MrgEG
 hFhM6cNSP7ao0SIzL+aatJoWtCSAURxge7SzW7cro3+FmDxRJ5mphNubLpDpkZlNr/2B
 7qeHC5nb7A/DrKMKhe7NpjsEiKPNUQnE8Y9lE1vS61UTWP/6SLDb0IwNTKSdRVNIfbJ7
 sTqA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783412055; x=1784016855; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2LPWQEMH1uPUJ0lNqDQY3X+iT/p0KjThx8BBwTOpv0s=;
 b=KuF1vlzb5Pnzi5I+F92hwlJzqlaiTdizEDh5cvq+D26PNoHjV1omDGyBQWV/YJnkjv
 hJYSJNTSDr5H+vuGb92u0MRWE/Wkxs1aH8KEs9c53RtBAQYPFW3zlAVd0YxIcG0KdTFJ
 2h9SOUcqy+jiVefCO4BraOljFSwng740dsPWSsDaq+xCvzScAUj2Vfl6HpN4kA4cPzEV
 ewjkda1LDbFMSTLIDKHwqGs+vFA91ix/O/z2OYdofMRhNyuUqAKWgcBdLAc6sk8FSL3L
 6Zw0pPcPtMtU1eK7dFdHZ2r0o2mGAxtk4yyh+IHFaBzsjHyP4niXlkv9At9FrrSnFxtO
 r6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783412055; x=1784016855;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2LPWQEMH1uPUJ0lNqDQY3X+iT/p0KjThx8BBwTOpv0s=;
 b=PyVJaKioiF20ilCL09LWpq9gtceQi0z5ef1SM2TwZkO+PQ5OnRf+9o/ccfl9I6aTmZ
 3Jdb07lkHpsYX3TOlpOJMqNCBZQHuBkBDqZTkTb6NX7lD7k5GKL5u9yLrmB5hUhv9VzC
 5LpNDsNcEf1JuUdzN4g22QkKUHQIEGL2eDKkEB9wJaKS7iRLMSq7IWGHZr6wdSaTRi4U
 DdCqVr87mnPFKGCbrLb2RCpsbcRLqxJ0y/vGN4wq3Tt2njUYCyenaVHm9XFh9H7jnmxa
 LRoMJJL1XmwuR0aXj1jjAsm0fU21ypSX3P/tP7cyB+El2tEEFEcAe3VCIFWyrf9ScCSE
 dCmQ==
X-Gm-Message-State: AOJu0YwBcr/VfIeUqgD1x/ap0BIJ7TNzj55Rug/WmDCyFzGlCIBmUyRa
 ZGkzUWUdGyU0dxzJ3qtGfMihDLCfkcPcxH1gu6oDfzWAB5PzbsO0tTqQi+lipPWK7RqKJNHnDek
 KAUya2Q9xDJ9mAXC2tN2+MNNb+2bIaLI=
X-Gm-Gg: AfdE7ckFzEsVUaMa4+xe+mUw4X1QkrbdP6JTRT4j4U9POXnywOk1rvD6kFN0X96jiX1
 iJltYvSXUt4xJZjgNGzDT5A/dvXCsiDWgxjZMbA/sbelvnEeneUnxHmDXbkxetFUmfiloO68Me4
 u+AbOgkwJwFCFWMjpd2pLKuIzbR2u0LbMz1n6kU/ZcWW2e2LvS4iv123ZwYdHmyGKlrehBDrxb7
 jY/2cba3cmMwn9IM0Ot4sfBN+9VfLn7Q6kBaQAO7e58jO9ZS4D2D3X1Hctsx7O6oYdPGcPDMrC0
 x7+B8g0g3g7Op6rwuu/Hrh6aYZyhog==
X-Received: by 2002:a05:6300:2206:b0:3b7:aefe:4367 with SMTP id
 adf61e73a8af0-3c08ee3949fmr5044800637.33.1783412054784; Tue, 07 Jul 2026
 01:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260702151325.290749-1-advaitd@mechasystems.com>
In-Reply-To: <20260702151325.290749-1-advaitd@mechasystems.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 7 Jul 2026 11:14:03 +0300
X-Gm-Features: AVVi8CfWWeWjzvit2Bc7i8k1iAJDZwIpUPQfukMfRFk677MexpU4yx-g82dk6po
Message-ID: <CAPVz0n1YGYKMWo6fVHF8gXZ8_6BjHCC4WUs-BBL5__+L8Bhi3w@mail.gmail.com>
Subject: Re: [PATCH v2] video: add ChipWealth CH13726A AMOLED panel driver
To: Advait Dhamorikar <advaitd@mechasystems.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, ag.dev.uboot@gmail.com, 
 ion@agorria.com, dario.binacchi@amarulasolutions.com, 
 michael@amarulasolutions.com, xypron.glpk@gmx.de, ravi@prevas.dk, 
 sjg@chromium.org, patrice.chotard@foss.st.com
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

=D1=87=D1=82, 2 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 18:14 Advai=
t Dhamorikar <advaitd@mechasystems.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Add support for AMOLED panels based on the ChipWealth CH13726A
> MIPI DSI display driver IC.
>
> The driver configures the MIPI DSI interface for 4 data lanes in RGB888
> video mode, performs the panel reset sequence, sends the vendor-specific
> initialization commands required by the controller, and enables the
> panel using the standard MIPI DCS Sleep Out and Display On commands.
>
> This driver is based on an earlier implementation by Pratham Malaviya.
>
> Signed-off-by: Advait Dhamorikar <advaitd@mechasystems.com>
> ---
>
> v1->v2
> - Expand CC list based on get_maintainer.pl output.
>
>  drivers/video/Kconfig               |   8 ++
>  drivers/video/Makefile              |   1 +
>  drivers/video/chipwealth-ch13726a.c | 193 ++++++++++++++++++++++++++++
>  3 files changed, 202 insertions(+)
>  create mode 100644 drivers/video/chipwealth-ch13726a.c
>

Hey there! Thanks for your contribution, it is pretty solid but there
are a few places that can be improved.

> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index c2acc13139c..7e82778e294 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -533,6 +533,14 @@ config VIDEO_BCM2835
>           that same resolution (or as near as possible) and 32bpp depth, =
so
>           that U-Boot can access it with full colour depth.
>
> +config VIDEO_AMOLED_CHIPWEALTH_CH13726A

May you please rename AMOLED > PANEL

> +       bool "ChipWealth CH13726A AMOLED panel support"
> +       depends on VIDEO

"depends on PANEL && BACKLIGHT"

> +       select VIDEO_MIPI_DSI
> +       help
> +         Say Y here if you want to enable support for AMOLED panels
> +         based on the ChipWealth CH13726A MIPI DSI display driver IC.
> +
>  config VIDEO_LCD_ENDEAVORU
>         tristate "Endeavoru 720x1280 DSI video mode panel"
>         depends on PANEL && BACKLIGHT
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 082b8967982..56df5e1860d 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_VIDEO_DW_HDMI) +=3D dw_hdmi.o
>  obj-$(CONFIG_VIDEO_DW_MIPI_DSI) +=3D dw_mipi_dsi.o
>  obj-$(CONFIG_VIDEO_EFI) +=3D efi.o
>  obj-y +=3D imx/
> +obj-$(CONFIG_VIDEO_AMOLED_CHIPWEALTH_CH13726A) +=3D chipwealth-ch13726a.=
o
>  obj-$(CONFIG_VIDEO_IVYBRIDGE_IGD) +=3D ivybridge_igd.o
>  obj-$(CONFIG_VIDEO_LCD_PANEL_EDP_4_LANE_1620M_VIA_ANX9804) +=3D anx9804.=
o
>  obj-$(CONFIG_VIDEO_LCD_ENDEAVORU) +=3D endeavoru-panel.o
> diff --git a/drivers/video/chipwealth-ch13726a.c b/drivers/video/chipweal=
th-ch13726a.c
> new file mode 100644
> index 00000000000..e6fef6c8e7f
> --- /dev/null
> +++ b/drivers/video/chipwealth-ch13726a.c
> @@ -0,0 +1,193 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ChipWealth CH13726A DSI panel driver
> + *
> + * Copyright (C) 2026 Mecha Systems
> + * Author(s):
> + *   Advait Dhamorikar <advaitd@mechasystems.com>
> + *   Pratham Malaviya  <prathamm@mechasystems.com>
> + */
> +
> +#include <backlight.h>
> +#include <dm.h>
> +#include <mipi_dsi.h>
> +#include <panel.h>
> +#include <asm/gpio.h>
> +#include <linux/delay.h>
> +#include <log.h>
> +
> +struct ch13726a_panel_priv {
> +       struct udevice *reg;
> +       struct udevice *backlight;
> +       struct gpio_desc reset;
> +};

You are lacking supplies here: vdd1v2, vddio, vdd and avdd

U-Boot can handle them so you should include control over them.

> +
> +static const struct display_timing default_timing =3D {
> +       .pixelclock.typ                 =3D       59832000,
> +       .hactive.typ                    =3D       1080,
> +       .hfront_porch.typ               =3D       12,
> +       .hback_porch.typ                =3D       12,
> +       .hsync_len.typ                  =3D       28,
> +       .vactive.typ                    =3D       1240,
> +       .vfront_porch.typ               =3D       2,
> +       .vback_porch.typ                =3D       2,
> +       .vsync_len.typ                  =3D       2,
> +};
> +
> +static int ch13726a_dcs_write_buf(struct udevice *dev, const void *data,
> +                                 size_t len)
> +{
> +       struct mipi_dsi_panel_plat *plat =3D dev_get_plat(dev);
> +       int ret;
> +
> +       ret =3D mipi_dsi_dcs_write_buffer(plat->device, data, len);
> +       if (ret < 0)
> +               log_err("failed to write dcs sequence: %d\n", ret);
> +
> +       return ret;
> +}
> +
> +#define dcs_write_seq(dev, cmd, seq...)                                \
> +({                                                             \
> +       const u8 d[] =3D { cmd, seq };                    \
> +                                                               \
> +       ch13726a_dcs_write_buf(dev, d, ARRAY_SIZE(d));          \
> +})
> +

You can fold this.

> +static void ch13726a_reset(struct udevice *dev)
> +{
> +       struct ch13726a_panel_priv *priv =3D dev_get_priv(dev);
> +
> +       dm_gpio_set_value(&priv->reset, true);
> +       mdelay(10);
> +       dm_gpio_set_value(&priv->reset, false);
> +       mdelay(10);
> +       dm_gpio_set_value(&priv->reset, true);
> +       mdelay(5);
> +}
> +
> +static int ch13726a_set_backlight(struct udevice *dev, int percent)
> +{
> +       struct mipi_dsi_panel_plat *plat =3D dev_get_plat(dev);
> +       struct mipi_dsi_device *device =3D plat->device;
> +       u8 brightness;
> +
> +       if (percent < 0)
> +               percent =3D 0;
> +       else if (percent > 100)
> +               percent =3D 100;
> +
> +       brightness =3D (percent * 255) / 100;
> +
> +       return mipi_dsi_dcs_set_display_brightness(device, brightness);
> +}
> +
> +static int ch13726a_panel_enable_backlight(struct udevice *dev)
> +{
> +       struct mipi_dsi_panel_plat *plat =3D dev_get_plat(dev);
> +       struct mipi_dsi_device *device =3D plat->device;
> +       int ret;
> +
> +       device->lanes =3D plat->lanes;
> +       device->format =3D plat->format;
> +       device->mode_flags =3D plat->mode_flags;
> +

You don't need this assignment.

> +       ret =3D mipi_dsi_attach(device);
> +       if (ret < 0)
> +               return ret;
> +
> +       ch13726a_reset(dev);
> +
> +       device->mode_flags |=3D MIPI_DSI_MODE_LPM;
> +

LPM flag is removed by mipi_dsi_device_transfer so you don't need it here.

> +       ret =3D dcs_write_seq(dev, 0x53, 0x00);
> +       if (ret < 0) {
> +               log_debug("%s: Init command failed(%d)\n",
> +                         __func__, ret);
> +               return ret;
> +       }
> +
> +       ret =3D dcs_write_seq(dev, 0x17, 0x00);
> +       if (ret < 0) {
> +               log_debug("%s: Init command failed (%d)\n",
> +                         __func__, ret);
> +               return ret;
> +       }
> +
> +       ret =3D dcs_write_seq(dev, 0x41, 0x00);
> +       if (ret < 0) {
> +               log_debug("%s: Init command failed (%d)\n",
> +                         __func__, ret);
> +               return ret;
> +       }
> +
> +       ret =3D mipi_dsi_dcs_exit_sleep_mode(device);
> +       if (ret)
> +               return ret;
> +
> +       mdelay(120);
> +
> +       ret =3D mipi_dsi_dcs_set_display_on(device);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static int ch13726a_panel_get_display_timing(struct udevice *dev,
> +                                            struct display_timing *timin=
gs)
> +{
> +       memcpy(timings, &default_timing, sizeof(*timings));
> +       return 0;
> +}
> +
> +static int ch13726a_panel_of_to_plat(struct udevice *dev)
> +{
> +       struct ch13726a_panel_priv *priv =3D dev_get_priv(dev);
> +       int ret;
> +
> +       ret =3D gpio_request_by_name(dev, "reset-gpios", 0,
> +                                  &priv->reset,
> +                                  GPIOD_IS_OUT);
> +       if (ret) {
> +               log_err("%s: cannot get reset GPIO (%d)\n",
> +                       __func__, ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int ch13726a_panel_probe(struct udevice *dev)
> +{
> +       struct mipi_dsi_panel_plat *plat =3D dev_get_plat(dev);
> +
> +       plat->lanes =3D 4;
> +       plat->format =3D MIPI_DSI_FMT_RGB888;
> +       plat->mode_flags =3D MIPI_DSI_MODE_VIDEO |
> +                          MIPI_DSI_MODE_VIDEO_BURST;
> +
> +       return 0;
> +}
> +
> +static const struct panel_ops ch13726a_panel_ops =3D {
> +       .enable_backlight       =3D       ch13726a_panel_enable_backlight=
,
> +       .set_backlight          =3D       ch13726a_set_backlight,
> +       .get_display_timing     =3D       ch13726a_panel_get_display_timi=
ng,
> +};
> +
> +static const struct udevice_id ch13726a_panel_ids[] =3D {
> +       { .compatible   =3D       "chipwealth,ch13726a" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(ch13726a_panel) =3D {
> +       .name           =3D       "ch13726a_panel",
> +       .id                     =3D       UCLASS_PANEL,
> +       .of_match       =3D       ch13726a_panel_ids,
> +       .ops            =3D       &ch13726a_panel_ops,
> +       .of_to_plat     =3D       ch13726a_panel_of_to_plat,
> +       .probe          =3D       ch13726a_panel_probe,
> +       .plat_auto      =3D       sizeof(struct mipi_dsi_panel_plat),
> +       .priv_auto      =3D       sizeof(struct ch13726a_panel_priv),
> +};
> --
> 2.43.0
>
