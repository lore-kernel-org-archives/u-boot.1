Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92833C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:26:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D11D88784;
	Fri, 19 Apr 2024 18:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R5bzdQ0M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 383DF88784; Fri, 19 Apr 2024 18:26:09 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FB338876E
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-571be483ccaso2576604a12.2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713543965; x=1714148765; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YOT/xEP2WcJYv7o3AQKdZq0kZ3mudHeFZ57lTmvWYuM=;
 b=R5bzdQ0MfMlETVF/1N00iDLiB9BjslDrPluTyFl27xiuZaliU9pA4DMxmJg5b8/Ub4
 Yo2mZGkO55W1HcO9whequuZQHiU4qJ1iVqPbL1aS1AA/JDpdN0fqcFcc8/m97iSxwZEf
 dV1qCCc69fOfCruyPCsmsdStgcR3gy9l4O8Afuku52NufbmYju6RtlUSslcLh/TW2i1N
 5CiZGhOUL86/7p9NOqW4tw14oWz5ldl4q/J8GypYb1If2qCQhmHEOIW6jm/eESwcoNlu
 vd1F4n40TjdtInymj9TS8m1hoDu11eGynlxqQkk7+cmF48sWoKJcTtUhdm09okS98icU
 4yAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713543965; x=1714148765;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YOT/xEP2WcJYv7o3AQKdZq0kZ3mudHeFZ57lTmvWYuM=;
 b=ddYHF2B6TqH9KIuJClAbx5Hu7rdo6wx1v7TRtY6Q87xFHw1kgyc1771BfUa5rB341i
 Cmx4sjfwf2XrUScwlp3YWhr/tjqPd0hpFUj4A43/GWLAxSa5PxF9G2rQgGxwVWbN0had
 FIwGoh8WyfPtnSh9QHTcInvqk2ICDargFUAPSZvvPTioHDFNrUXwliZ/9OOlIFHvUIxz
 hXAW8lx//eju3YAVP7ptxhR2cLl508eLuxfnw0a8Nh914F4UZwqdxBEDB8KSo3tRc+J6
 mhD5rBWC/eBdAipBtxQQy4LO6dMkF2TjQM9+E/PQXeUHwFsSOITpUIQmit74NrC2GmlB
 KABQ==
X-Gm-Message-State: AOJu0YxQkAjBblmZt2tpGUiFt2a9AxaHf6BYgHru3FlAcdCeoxleVdnm
 JE8q5A1jB5ObOis8afzG6/KetenYQwA7+f+a1ZlRzmdvgVZrgsOpVlxwBw==
X-Google-Smtp-Source: AGHT+IH0wZ/jLKh7sxDLb8xVneARsZnej2LX9F5Duvw0D/+1dzBn5YwrK/2SFA0ZhH/SPxZGsrOBLw==
X-Received: by 2002:a17:906:3412:b0:a52:434e:418e with SMTP id
 c18-20020a170906341200b00a52434e418emr1799412ejb.9.1713543965371; 
 Fri, 19 Apr 2024 09:26:05 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a170906a10b00b00a5244a80cfcsm2381561ejy.91.2024.04.19.09.26.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:26:04 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=61bc6e7c51d17e948a896e827572d7b57eee9a033775b48e33002c499a29;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 18:26:04 +0200
Message-Id: <D0O8N1XSTKTD.2J993U45EGU3@gmail.com>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 01/18] video: tegra20: dc: diverge DC per-SOC
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Thierry Reding"
 <treding@nvidia.com>, "Anatolij Gustschin" <agust@denx.de>, "Simon Glass"
 <sjg@chromium.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-2-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-2-clamor95@gmail.com>
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

--61bc6e7c51d17e948a896e827572d7b57eee9a033775b48e33002c499a29
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
[...]
> diff --git a/arch/arm/include/asm/arch-tegra114/display.h b/arch/arm/incl=
ude/asm/arch-tegra114/display.h
> new file mode 100644
> index 0000000000..9411525799
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-tegra114/display.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + *  (C) Copyright 2010
> + *  NVIDIA Corporation <www.nvidia.com>
> + */
> +
> +#ifndef __ASM_ARCH_TEGRA_DISPLAY_H
> +#define __ASM_ARCH_TEGRA_DISPLAY_H
> +
> +#include <asm/arch-tegra/dc.h>
> +
> +/* This holds information about a window which can be displayed */
> +struct disp_ctl_win {
> +	enum win_color_depth_id fmt;	/* Color depth/format */
> +	unsigned int	bpp;		/* Bits per pixel */
> +	phys_addr_t	phys_addr;	/* Physical address in memory */
> +	unsigned int	x;		/* Horizontal address offset (bytes) */
> +	unsigned int	y;		/* Veritical address offset (bytes) */
> +	unsigned int	w;		/* Width of source window */
> +	unsigned int	h;		/* Height of source window */
> +	unsigned int	stride;		/* Number of bytes per line */
> +	unsigned int	out_x;		/* Left edge of output window (col) */
> +	unsigned int	out_y;		/* Top edge of output window (row) */
> +	unsigned int	out_w;		/* Width of output window in pixels */
> +	unsigned int	out_h;		/* Height of output window in pixels */
> +};
> +
> +#endif /*__ASM_ARCH_TEGRA_DISPLAY_H*/

One of the earlier patches in the series gets rid of this per-SoC header
file in favor of a common one. Did this end up here by mistake? It
doesn't seem to be used.

> diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/teg=
ra-dc.c
> index f53ad46397..7605e77bc1 100644
> --- a/drivers/video/tegra20/tegra-dc.c
> +++ b/drivers/video/tegra20/tegra-dc.c
> @@ -3,7 +3,6 @@
>   * Copyright (c) 2011 The Chromium OS Authors.
>   */
> =20
> -#include <common.h>
>  #include <backlight.h>
>  #include <dm.h>
>  #include <fdtdec.h>
> @@ -23,10 +22,15 @@
>  #include <asm/arch/pinmux.h>
>  #include <asm/arch/pwm.h>
>  #include <asm/arch/display.h>
> -#include <asm/arch-tegra/timer.h>
> =20
>  DECLARE_GLOBAL_DATA_PTR;
> =20
> +/* Holder of Tegra per-SOC DC differences */
> +struct tegra_dc_soc_info {
> +	bool has_timer;
> +	bool has_rgb;
> +};
> +
>  /* Information about the display controller */
>  struct tegra_lcd_priv {
>  	int width;			/* width in pixels */
> @@ -35,6 +39,7 @@ struct tegra_lcd_priv {
>  	struct display_timing timing;
>  	struct udevice *panel;
>  	struct dc_ctlr *dc;		/* Display controller regmap */
> +	const struct tegra_dc_soc_info *soc;
>  	fdt_addr_t frame_buffer;	/* Address of frame buffer */
>  	unsigned pixel_clock;		/* Pixel clock in Hz */
>  	int dc_clk[2];			/* Contains clk and its parent */
> @@ -43,8 +48,8 @@ struct tegra_lcd_priv {
> =20
>  enum {
>  	/* Maximum LCD size we support */
> -	LCD_MAX_WIDTH		=3D 1920,
> -	LCD_MAX_HEIGHT		=3D 1200,
> +	LCD_MAX_WIDTH		=3D 2560,
> +	LCD_MAX_HEIGHT		=3D 1600,
>  	LCD_MAX_LOG2_BPP	=3D VIDEO_BPP16,
>  };
> =20
> @@ -110,9 +115,9 @@ static void update_window(struct tegra_lcd_priv *priv=
,
>  	writel(val, &dc->cmd.state_ctrl);
>  }
> =20
> -static int update_display_mode(struct dc_disp_reg *disp,
> -			       struct tegra_lcd_priv *priv)
> +static int update_display_mode(struct tegra_lcd_priv *priv)
>  {
> +	struct dc_disp_reg *disp =3D &priv->dc->disp;
>  	struct display_timing *dt =3D &priv->timing;
>  	unsigned long val;
>  	unsigned long rate;
> @@ -128,14 +133,16 @@ static int update_display_mode(struct dc_disp_reg *=
disp,
>  	       &disp->front_porch);
>  	writel(dt->hactive.typ | (dt->vactive.typ << 16), &disp->disp_active);
> =20
> -	val =3D DE_SELECT_ACTIVE << DE_SELECT_SHIFT;
> -	val |=3D DE_CONTROL_NORMAL << DE_CONTROL_SHIFT;
> -	writel(val, &disp->data_enable_opt);
> +	if (priv->soc->has_rgb) {
> +		val =3D DE_SELECT_ACTIVE << DE_SELECT_SHIFT;
> +		val |=3D DE_CONTROL_NORMAL << DE_CONTROL_SHIFT;
> +		writel(val, &disp->data_enable_opt);
> =20
> -	val =3D DATA_FORMAT_DF1P1C << DATA_FORMAT_SHIFT;
> -	val |=3D DATA_ALIGNMENT_MSB << DATA_ALIGNMENT_SHIFT;
> -	val |=3D DATA_ORDER_RED_BLUE << DATA_ORDER_SHIFT;
> -	writel(val, &disp->disp_interface_ctrl);
> +		val =3D DATA_FORMAT_DF1P1C << DATA_FORMAT_SHIFT;
> +		val |=3D DATA_ALIGNMENT_MSB << DATA_ALIGNMENT_SHIFT;
> +		val |=3D DATA_ORDER_RED_BLUE << DATA_ORDER_SHIFT;
> +		writel(val, &disp->disp_interface_ctrl);
> +	}
> =20
>  	/*
>  	 * The pixel clock divider is in 7.1 format (where the bottom bit
> @@ -147,7 +154,8 @@ static int update_display_mode(struct dc_disp_reg *di=
sp,
>  	div =3D ((rate * 2 + priv->pixel_clock / 2) / priv->pixel_clock) - 2;
>  	debug("Display clock %lu, divider %lu\n", rate, div);
> =20
> -	writel(0x00010001, &disp->shift_clk_opt);
> +	if (priv->soc->has_rgb)
> +		writel(0x00010001, &disp->shift_clk_opt);
> =20
>  	val =3D PIXEL_CLK_DIVIDER_PCD1 << PIXEL_CLK_DIVIDER_SHIFT;
>  	val |=3D div << SHIFT_CLK_DIVIDER_SHIFT;
> @@ -174,6 +182,7 @@ static void basic_init(struct dc_cmd_reg *cmd)
>  	writel(val, &cmd->disp_pow_ctrl);
> =20
>  	val =3D readl(&cmd->disp_cmd);
> +	val &=3D ~CTRL_MODE_MASK;
>  	val |=3D CTRL_MODE_C_DISPLAY << CTRL_MODE_SHIFT;

This seems unrelated to the rest here, but probably not worth splitting
it into a separate patch. I vaguely recall that this wasn't really
necessary because we do the reset prior to initialization and the
register is all zeroes by default?

>  	writel(val, &cmd->disp_cmd);
>  }
> @@ -229,8 +238,8 @@ static void rgb_enable(struct dc_com_reg *com)
>  		writel(rgb_sel_tab[i], &com->pin_output_sel[i]);
>  }
> =20
> -static int setup_window(struct disp_ctl_win *win,
> -			struct tegra_lcd_priv *priv)
> +static int setup_window(struct tegra_lcd_priv *priv,
> +			struct disp_ctl_win *win)
>  {
>  	if (priv->rotation) {
>  		win->x =3D priv->width * 2;
> @@ -274,12 +283,11 @@ static int setup_window(struct disp_ctl_win *win,
>   * You should pass in the U-Boot address here, and check the contents of
>   * struct tegra_lcd_priv to see what was actually chosen.
>   *
> - * @param blob			Device tree blob
>   * @param priv			Driver's private data
>   * @param default_lcd_base	Default address of LCD frame buffer
>   * Return: 0 if ok, -1 on error (unsupported bits per pixel)
>   */
> -static int tegra_display_probe(const void *blob, struct tegra_lcd_priv *=
priv,
> +static int tegra_display_probe(struct tegra_lcd_priv *priv,
>  			       void *default_lcd_base)
>  {
>  	struct disp_ctl_win window;
> @@ -288,7 +296,7 @@ static int tegra_display_probe(const void *blob, stru=
ct tegra_lcd_priv *priv,
>  	priv->frame_buffer =3D (u32)default_lcd_base;
> =20
>  	/*
> -	 * We halve the rate if DISP1 paret is PLLD, since actual parent
> +	 * We halve the rate if DISP1 parent is PLLD, since actual parent
>  	 * is plld_out0 which is PLLD divided by 2.
>  	 */
>  	if (priv->dc_clk[1] =3D=3D CLOCK_ID_DISPLAY)
> @@ -303,13 +311,17 @@ static int tegra_display_probe(const void *blob, st=
ruct tegra_lcd_priv *priv,
>  			       rate);
> =20
>  	basic_init(&priv->dc->cmd);
> -	basic_init_timer(&priv->dc->disp);
> -	rgb_enable(&priv->dc->com);
> +
> +	if (priv->soc->has_timer)
> +		basic_init_timer(&priv->dc->disp);
> +
> +	if (priv->soc->has_rgb)
> +		rgb_enable(&priv->dc->com);
> =20
>  	if (priv->pixel_clock)
> -		update_display_mode(&priv->dc->disp, priv);
> +		update_display_mode(priv);
> =20
> -	if (setup_window(&window, priv))
> +	if (setup_window(priv, &window))
>  		return -1;
> =20
>  	update_window(priv, &window);
> @@ -322,7 +334,6 @@ static int tegra_lcd_probe(struct udevice *dev)
>  	struct video_uc_plat *plat =3D dev_get_uclass_plat(dev);
>  	struct video_priv *uc_priv =3D dev_get_uclass_priv(dev);
>  	struct tegra_lcd_priv *priv =3D dev_get_priv(dev);
> -	const void *blob =3D gd->fdt_blob;
>  	int ret;
> =20
>  	/* Initialize the Tegra display controller */
> @@ -330,8 +341,8 @@ static int tegra_lcd_probe(struct udevice *dev)
>  	funcmux_select(PERIPH_ID_DISP1, FUNCMUX_DEFAULT);
>  #endif
> =20
> -	if (tegra_display_probe(blob, priv, (void *)plat->base)) {
> -		printf("%s: Failed to probe display driver\n", __func__);
> +	if (tegra_display_probe(priv, (void *)plat->base)) {
> +		debug("%s: Failed to probe display driver\n", __func__);

Shouldn't this remain a printf() to make it more visible in the logs
what's going on? I guess people will notice anyway when the display
doesn't turn on, but this is good information to know when
troubleshooting.

>  		return -1;
>  	}
> =20
> @@ -383,6 +394,8 @@ static int tegra_lcd_of_to_plat(struct udevice *dev)
>  		return -EINVAL;
>  	}
> =20
> +	priv->soc =3D (struct tegra_dc_soc_info *)dev_get_driver_data(dev);
> +
>  	ret =3D clock_decode_pair(dev, priv->dc_clk);
>  	if (ret < 0) {
>  		debug("%s: Cannot decode clocks for '%s' (ret =3D %d)\n",
> @@ -464,19 +477,43 @@ static int tegra_lcd_bind(struct udevice *dev)
>  static const struct video_ops tegra_lcd_ops =3D {
>  };
> =20
> +static const struct tegra_dc_soc_info tegra20_dc_soc_info =3D {
> +	.has_timer =3D true,
> +	.has_rgb =3D true,
> +};
> +
> +static const struct tegra_dc_soc_info tegra30_dc_soc_info =3D {
> +	.has_timer =3D false,
> +	.has_rgb =3D true,
> +};
> +
> +static const struct tegra_dc_soc_info tegra114_dc_soc_info =3D {
> +	.has_timer =3D false,
> +	.has_rgb =3D false,
> +};

My recollection is that technically Tegra114 still supports RGB, but it
ends up never being used on any of the platforms that I know of. On
Linux we base the decision to initialize the corresponding registers on
the status property of the "rgb" node of each display controller.
Perhaps that's something that U-Boot could do as well? That would avoid
programming these registers on Tegra20 and Tegra30 devices that don't
use RGB.

Thierry

--61bc6e7c51d17e948a896e827572d7b57eee9a033775b48e33002c499a29
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYimxwACgkQ3SOs138+
s6GSYw/+Lx5uU/hDXi+Buwkgt4CwKw054obMjFUEIAnwP6y8G1Cf4GCk2uGQG64d
osk5AUq8b4cKV608dRThnBN44k1gzEWNOPzsP52IfCJzHqvI/6+BuE1E90XEIHil
lBNu1kHQ3cNSvMIgd+I2PDgX0kbjPsoFCHZVT5jm4JVwISvR3rIzRiTHpwnGPLo6
e+6hj7kY6cZL2+/PJrl9mtLMnw9mws4Lnhu+rtzipHYKJM4gczafd3QB/w8l39U8
11qW1roq3YRnU7vGOQ6TEUcuJCl3/SoMNWHqfBjTcSL0izMYK7H7K8bOU6fYMA4s
AU3IzBtnblv5YYrWxkLnu0yVU2kdMI8DYkUf4X8THOA0YSrIdRh4OnloqiShR+KS
du3cKYek0Cr7HkDIGsPj+UxcCcxeXjx1CXJHuOw7Zd7FZqdCtkfzyx3siklcwi4f
j57o2dQCZqyxEvwoRlqIGjJ8ysQduV3duaA+TQuyDcfciao3EaCUnVriWb69dkaq
+BL4nPmvJyaM5h72nukCXYvYUMGbzeQqhnlHxvmSAIOwH+CJC2FBZqOY5UUIPu5A
DG9sra5i0mE9RUw7B6rfOtvTQT0bzaKqyjfRr+VqhIu0x269/MetDhZ4GoUbDBaU
jmJbhf5aTuSZvuW/i6TDILhiTcu1baxxVVRPYzuox+QnosnedLQ=
=Ra/k
-----END PGP SIGNATURE-----

--61bc6e7c51d17e948a896e827572d7b57eee9a033775b48e33002c499a29--
