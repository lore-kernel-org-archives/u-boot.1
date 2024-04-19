Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C86DC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 17:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99EFE887FE;
	Fri, 19 Apr 2024 19:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A2uBOrTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 414E78880F; Fri, 19 Apr 2024 19:16:42 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04CB4887FE
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 19:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-344047ac7e4so2085262f8f.0
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713546999; x=1714151799; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmphnSKgwvFaDvQRKlptb2ouASMnepKxPf/qLHNh4Ig=;
 b=A2uBOrTx1IsUZRhVRTnc6VlHBPudUdBNciRIjRjW04cj+meq59hibaJYK899a3iNsD
 0+B17m6Vxn0kw2/Z8s7t8gRLv2gD/VwBAvRohdv2ogYgB4GOWLgYooVFQtQC/hnhULBp
 Jj4l3aENOqvUo1hx6pfX72PJ9zs6Jk4an/ECwZT+lrcdd+GkAaj93RnOUtRTEGRPvIGt
 fvNWc1RRxQwx2nc2IAaWNiHbSnvqJGP8T2/7W5Bfp3jxld1IW9w6LW+DU9NI5RAoZsd4
 NvQ2L6drrY4ezbrUKokDf7tHKPTkrKvH5NKZQ2g7PTGi5qDRMOWqGat2K6Q07RL6EeGi
 zNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713546999; x=1714151799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HmphnSKgwvFaDvQRKlptb2ouASMnepKxPf/qLHNh4Ig=;
 b=LLjJtxOTPshOZ85Gx2VwW3Ujpk2ZGh9XzCNcahQRkJiheLI0ETKZn1r3neobWHBZpy
 +fsC6tMDgMIFtW2fkZb+Ju1Oc65lJ1UonyK16yLLbAC+ApCKI3S5Ee5jjIlpRHu/MDbV
 NBERFZmrRe+heCdVos4Ah/hGhDEmEaad+fG3KenfWSnuBzocA7tuCal12uYws2ZvV88z
 BZJl8lVQeOPTIeP7lhrY+XybRXsBR59zl7/1Y1QzXwMav7+LdnHGIOjbKvitm2zNLfMN
 5OEHwkKH7SdnU0MojAMhHZrM3Tloyo/AqTjbHIelegOBqfZgAUwn+R46/sXy1QLmVZl4
 mZWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPdvl/Dqxbrshq0ci1KWq6P8FN8NVbeJo+mKNn7iGixSC94rtpVK1UoH6uhk9PkRiC8gBlWmAdfktLgIwcgFS17LR7sA==
X-Gm-Message-State: AOJu0YzucACNIXSCp0G13c6f2MDYa2+mDZhKUXHdcpZs6cBFigs/6vec
 w9yH4co4CClVxVNzdJZnPPzNZg5k6VwDGJWW8v/rh657EiTjll4r5Ws0zWcpnPcR7Ec+o6FXqu3
 vBd9E35LJAHneK1pkXlgKt/ECQa/Hjw==
X-Google-Smtp-Source: AGHT+IHmRRxgkFBuFs6lv70We5kGBYD/hC06Bhg9dlI+2SkrSBO8YG+aNMmaxq5LugYOG4MDiWsjW0x1X+xZHr2cBkE=
X-Received: by 2002:a5d:59ab:0:b0:34a:6f29:f19f with SMTP id
 p11-20020a5d59ab000000b0034a6f29f19fmr1687598wrr.15.1713546999301; Fri, 19
 Apr 2024 10:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-2-clamor95@gmail.com>
 <D0O8N1XSTKTD.2J993U45EGU3@gmail.com>
In-Reply-To: <D0O8N1XSTKTD.2J993U45EGU3@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 19 Apr 2024 20:16:28 +0300
Message-ID: <CAPVz0n3ytkcVyX9XDhCmiaStdAYMFqX2_9fmb7Y5gYTTwjXDqg@mail.gmail.com>
Subject: Re: [PATCH v6 01/18] video: tegra20: dc: diverge DC per-SOC
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

=D0=BF=D1=82, 19 =D0=BA=D0=B2=D1=96=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 19:2=
6 Thierry Reding <thierry.reding@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> [...]
> > diff --git a/arch/arm/include/asm/arch-tegra114/display.h b/arch/arm/in=
clude/asm/arch-tegra114/display.h
> > new file mode 100644
> > index 0000000000..9411525799
> > --- /dev/null
> > +++ b/arch/arm/include/asm/arch-tegra114/display.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + *  (C) Copyright 2010
> > + *  NVIDIA Corporation <www.nvidia.com>
> > + */
> > +
> > +#ifndef __ASM_ARCH_TEGRA_DISPLAY_H
> > +#define __ASM_ARCH_TEGRA_DISPLAY_H
> > +
> > +#include <asm/arch-tegra/dc.h>
> > +
> > +/* This holds information about a window which can be displayed */
> > +struct disp_ctl_win {
> > +     enum win_color_depth_id fmt;    /* Color depth/format */
> > +     unsigned int    bpp;            /* Bits per pixel */
> > +     phys_addr_t     phys_addr;      /* Physical address in memory */
> > +     unsigned int    x;              /* Horizontal address offset (byt=
es) */
> > +     unsigned int    y;              /* Veritical address offset (byte=
s) */
> > +     unsigned int    w;              /* Width of source window */
> > +     unsigned int    h;              /* Height of source window */
> > +     unsigned int    stride;         /* Number of bytes per line */
> > +     unsigned int    out_x;          /* Left edge of output window (co=
l) */
> > +     unsigned int    out_y;          /* Top edge of output window (row=
) */
> > +     unsigned int    out_w;          /* Width of output window in pixe=
ls */
> > +     unsigned int    out_h;          /* Height of output window in pix=
els */
> > +};
> > +
> > +#endif /*__ASM_ARCH_TEGRA_DISPLAY_H*/
>
> One of the earlier patches in the series gets rid of this per-SoC header
> file in favor of a common one. Did this end up here by mistake? It
> doesn't seem to be used.
>
> > diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/t=
egra-dc.c
> > index f53ad46397..7605e77bc1 100644
> > --- a/drivers/video/tegra20/tegra-dc.c
> > +++ b/drivers/video/tegra20/tegra-dc.c
> > @@ -3,7 +3,6 @@
> >   * Copyright (c) 2011 The Chromium OS Authors.
> >   */
> >
> > -#include <common.h>
> >  #include <backlight.h>
> >  #include <dm.h>
> >  #include <fdtdec.h>
> > @@ -23,10 +22,15 @@
> >  #include <asm/arch/pinmux.h>
> >  #include <asm/arch/pwm.h>
> >  #include <asm/arch/display.h>
> > -#include <asm/arch-tegra/timer.h>
> >
> >  DECLARE_GLOBAL_DATA_PTR;
> >
> > +/* Holder of Tegra per-SOC DC differences */
> > +struct tegra_dc_soc_info {
> > +     bool has_timer;
> > +     bool has_rgb;
> > +};
> > +
> >  /* Information about the display controller */
> >  struct tegra_lcd_priv {
> >       int width;                      /* width in pixels */
> > @@ -35,6 +39,7 @@ struct tegra_lcd_priv {
> >       struct display_timing timing;
> >       struct udevice *panel;
> >       struct dc_ctlr *dc;             /* Display controller regmap */
> > +     const struct tegra_dc_soc_info *soc;
> >       fdt_addr_t frame_buffer;        /* Address of frame buffer */
> >       unsigned pixel_clock;           /* Pixel clock in Hz */
> >       int dc_clk[2];                  /* Contains clk and its parent */
> > @@ -43,8 +48,8 @@ struct tegra_lcd_priv {
> >
> >  enum {
> >       /* Maximum LCD size we support */
> > -     LCD_MAX_WIDTH           =3D 1920,
> > -     LCD_MAX_HEIGHT          =3D 1200,
> > +     LCD_MAX_WIDTH           =3D 2560,
> > +     LCD_MAX_HEIGHT          =3D 1600,
> >       LCD_MAX_LOG2_BPP        =3D VIDEO_BPP16,
> >  };
> >
> > @@ -110,9 +115,9 @@ static void update_window(struct tegra_lcd_priv *pr=
iv,
> >       writel(val, &dc->cmd.state_ctrl);
> >  }
> >
> > -static int update_display_mode(struct dc_disp_reg *disp,
> > -                            struct tegra_lcd_priv *priv)
> > +static int update_display_mode(struct tegra_lcd_priv *priv)
> >  {
> > +     struct dc_disp_reg *disp =3D &priv->dc->disp;
> >       struct display_timing *dt =3D &priv->timing;
> >       unsigned long val;
> >       unsigned long rate;
> > @@ -128,14 +133,16 @@ static int update_display_mode(struct dc_disp_reg=
 *disp,
> >              &disp->front_porch);
> >       writel(dt->hactive.typ | (dt->vactive.typ << 16), &disp->disp_act=
ive);
> >
> > -     val =3D DE_SELECT_ACTIVE << DE_SELECT_SHIFT;
> > -     val |=3D DE_CONTROL_NORMAL << DE_CONTROL_SHIFT;
> > -     writel(val, &disp->data_enable_opt);
> > +     if (priv->soc->has_rgb) {
> > +             val =3D DE_SELECT_ACTIVE << DE_SELECT_SHIFT;
> > +             val |=3D DE_CONTROL_NORMAL << DE_CONTROL_SHIFT;
> > +             writel(val, &disp->data_enable_opt);
> >
> > -     val =3D DATA_FORMAT_DF1P1C << DATA_FORMAT_SHIFT;
> > -     val |=3D DATA_ALIGNMENT_MSB << DATA_ALIGNMENT_SHIFT;
> > -     val |=3D DATA_ORDER_RED_BLUE << DATA_ORDER_SHIFT;
> > -     writel(val, &disp->disp_interface_ctrl);
> > +             val =3D DATA_FORMAT_DF1P1C << DATA_FORMAT_SHIFT;
> > +             val |=3D DATA_ALIGNMENT_MSB << DATA_ALIGNMENT_SHIFT;
> > +             val |=3D DATA_ORDER_RED_BLUE << DATA_ORDER_SHIFT;
> > +             writel(val, &disp->disp_interface_ctrl);
> > +     }
> >
> >       /*
> >        * The pixel clock divider is in 7.1 format (where the bottom bit
> > @@ -147,7 +154,8 @@ static int update_display_mode(struct dc_disp_reg *=
disp,
> >       div =3D ((rate * 2 + priv->pixel_clock / 2) / priv->pixel_clock) =
- 2;
> >       debug("Display clock %lu, divider %lu\n", rate, div);
> >
> > -     writel(0x00010001, &disp->shift_clk_opt);
> > +     if (priv->soc->has_rgb)
> > +             writel(0x00010001, &disp->shift_clk_opt);
> >
> >       val =3D PIXEL_CLK_DIVIDER_PCD1 << PIXEL_CLK_DIVIDER_SHIFT;
> >       val |=3D div << SHIFT_CLK_DIVIDER_SHIFT;
> > @@ -174,6 +182,7 @@ static void basic_init(struct dc_cmd_reg *cmd)
> >       writel(val, &cmd->disp_pow_ctrl);
> >
> >       val =3D readl(&cmd->disp_cmd);
> > +     val &=3D ~CTRL_MODE_MASK;
> >       val |=3D CTRL_MODE_C_DISPLAY << CTRL_MODE_SHIFT;
>
> This seems unrelated to the rest here, but probably not worth splitting
> it into a separate patch. I vaguely recall that this wasn't really
> necessary because we do the reset prior to initialization and the
> register is all zeroes by default?
>
> >       writel(val, &cmd->disp_cmd);
> >  }
> > @@ -229,8 +238,8 @@ static void rgb_enable(struct dc_com_reg *com)
> >               writel(rgb_sel_tab[i], &com->pin_output_sel[i]);
> >  }
> >
> > -static int setup_window(struct disp_ctl_win *win,
> > -                     struct tegra_lcd_priv *priv)
> > +static int setup_window(struct tegra_lcd_priv *priv,
> > +                     struct disp_ctl_win *win)
> >  {
> >       if (priv->rotation) {
> >               win->x =3D priv->width * 2;
> > @@ -274,12 +283,11 @@ static int setup_window(struct disp_ctl_win *win,
> >   * You should pass in the U-Boot address here, and check the contents =
of
> >   * struct tegra_lcd_priv to see what was actually chosen.
> >   *
> > - * @param blob                       Device tree blob
> >   * @param priv                       Driver's private data
> >   * @param default_lcd_base   Default address of LCD frame buffer
> >   * Return: 0 if ok, -1 on error (unsupported bits per pixel)
> >   */
> > -static int tegra_display_probe(const void *blob, struct tegra_lcd_priv=
 *priv,
> > +static int tegra_display_probe(struct tegra_lcd_priv *priv,
> >                              void *default_lcd_base)
> >  {
> >       struct disp_ctl_win window;
> > @@ -288,7 +296,7 @@ static int tegra_display_probe(const void *blob, st=
ruct tegra_lcd_priv *priv,
> >       priv->frame_buffer =3D (u32)default_lcd_base;
> >
> >       /*
> > -      * We halve the rate if DISP1 paret is PLLD, since actual parent
> > +      * We halve the rate if DISP1 parent is PLLD, since actual parent
> >        * is plld_out0 which is PLLD divided by 2.
> >        */
> >       if (priv->dc_clk[1] =3D=3D CLOCK_ID_DISPLAY)
> > @@ -303,13 +311,17 @@ static int tegra_display_probe(const void *blob, =
struct tegra_lcd_priv *priv,
> >                              rate);
> >
> >       basic_init(&priv->dc->cmd);
> > -     basic_init_timer(&priv->dc->disp);
> > -     rgb_enable(&priv->dc->com);
> > +
> > +     if (priv->soc->has_timer)
> > +             basic_init_timer(&priv->dc->disp);
> > +
> > +     if (priv->soc->has_rgb)
> > +             rgb_enable(&priv->dc->com);
> >
> >       if (priv->pixel_clock)
> > -             update_display_mode(&priv->dc->disp, priv);
> > +             update_display_mode(priv);
> >
> > -     if (setup_window(&window, priv))
> > +     if (setup_window(priv, &window))
> >               return -1;
> >
> >       update_window(priv, &window);
> > @@ -322,7 +334,6 @@ static int tegra_lcd_probe(struct udevice *dev)
> >       struct video_uc_plat *plat =3D dev_get_uclass_plat(dev);
> >       struct video_priv *uc_priv =3D dev_get_uclass_priv(dev);
> >       struct tegra_lcd_priv *priv =3D dev_get_priv(dev);
> > -     const void *blob =3D gd->fdt_blob;
> >       int ret;
> >
> >       /* Initialize the Tegra display controller */
> > @@ -330,8 +341,8 @@ static int tegra_lcd_probe(struct udevice *dev)
> >       funcmux_select(PERIPH_ID_DISP1, FUNCMUX_DEFAULT);
> >  #endif
> >
> > -     if (tegra_display_probe(blob, priv, (void *)plat->base)) {
> > -             printf("%s: Failed to probe display driver\n", __func__);
> > +     if (tegra_display_probe(priv, (void *)plat->base)) {
> > +             debug("%s: Failed to probe display driver\n", __func__);
>
> Shouldn't this remain a printf() to make it more visible in the logs
> what's going on? I guess people will notice anyway when the display
> doesn't turn on, but this is good information to know when
> troubleshooting.
>
debug() is preferred to reduce resulting image size.

> >               return -1;
> >       }
> >
> > @@ -383,6 +394,8 @@ static int tegra_lcd_of_to_plat(struct udevice *dev=
)
> >               return -EINVAL;
> >       }
> >
> > +     priv->soc =3D (struct tegra_dc_soc_info *)dev_get_driver_data(dev=
);
> > +
> >       ret =3D clock_decode_pair(dev, priv->dc_clk);
> >       if (ret < 0) {
> >               debug("%s: Cannot decode clocks for '%s' (ret =3D %d)\n",
> > @@ -464,19 +477,43 @@ static int tegra_lcd_bind(struct udevice *dev)
> >  static const struct video_ops tegra_lcd_ops =3D {
> >  };
> >
> > +static const struct tegra_dc_soc_info tegra20_dc_soc_info =3D {
> > +     .has_timer =3D true,
> > +     .has_rgb =3D true,
> > +};
> > +
> > +static const struct tegra_dc_soc_info tegra30_dc_soc_info =3D {
> > +     .has_timer =3D false,
> > +     .has_rgb =3D true,
> > +};
> > +
> > +static const struct tegra_dc_soc_info tegra114_dc_soc_info =3D {
> > +     .has_timer =3D false,
> > +     .has_rgb =3D false,
> > +};
>
> My recollection is that technically Tegra114 still supports RGB, but it
> ends up never being used on any of the platforms that I know of. On
> Linux we base the decision to initialize the corresponding registers on
> the status property of the "rgb" node of each display controller.
> Perhaps that's something that U-Boot could do as well? That would avoid
> programming these registers on Tegra20 and Tegra30 devices that don't
> use RGB.
>
This may be implemented in follow up. Please keep in mind that video subsys=
tem
existing in U-Boot is much simpler then Linux framework and some stuff may =
not
be easy to implement right away. Thanks.

> Thierry
