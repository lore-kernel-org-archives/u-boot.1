Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8197DC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 08:00:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2755060817;
	Tue, 21 Jul 2026 08:00:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3l01dV3bVd7M; Tue, 21 Jul 2026 08:00:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 080066080C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784620835;
	bh=Bz7rHdUjkWL0jTzZNPpWHyvTQ/s7apH8M3kXEgBkOf8=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Ul8R0Z+RLLZWvlArNgtMot+I2UcKKNSbIVQkVYjIkKD3t9LJ/nT4hJ3Iq0ZKC28u3
	 efDHCqTVrxbnuYgZNvki5rPdMEERfj2r4aBmVA9zIfwPJhwHG8VIBxJIxTD58rE87F
	 W3uAemyooVMeNP2+2VpvmLp4BWvp/9paXujvZNBuOJ4GjZ1tgbjISE1r+qaT2OSCIW
	 DGLhyuiQlWUlW7XcFL2CzNaxrBh+1/r1Vi2IP8ZA5YSgx8FrWCFIBvjp6wmFJOAhMD
	 OWv0oPRsbDPqBvmEZoTNtD+3vVh2dMng0FgNZfku731yKnz897i3w5Z6W1k18H3v9o
	 dKwQkHD7/T2dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 080066080C;
	Tue, 21 Jul 2026 08:00:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D7B642A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B13C80DF3
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:00:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ldm2ElRt12x9 for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 08:00:32 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2B3DE80DEE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2B3DE80DEE
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B3DE80DEE
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:00:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B711844F6; Tue, 21 Jul 2026 10:00:30 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8E22803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 10:00:27 +0200 (CEST)
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-caf45fc5202so7696838a12.1
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 01:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784620826; cv=none;
 d=google.com; s=arc-20260327;
 b=IrTJwrbVOkbWwvesn7oPzqL/AgtRcqWl0QoqYg4boF0JldpjZ2pvKa1lmjHj/Vudiq
 /dza5C2hDpu2fxhLvtXmuzDANpJ7Rrf+7dwlGE+sy/hh+Hhc11yzs5OEmG2Jo38vAJum
 eS+JXiyepXgV7uBHJsIFgNa73Z8ukOOqrnMW7wC/LvkyNAknpyC1jeeCkz9Rt4mAD+xV
 rdXQLtqGqtf2PO3Czxr2YS5MoPdXlJ5e4FQzj/tHwWIw+fEhNivYzCTnxLCsPeedEX4m
 mEpowgnuEbc1WvNkIyn0ZNTseEwI6ZU3RSDAKjVGX7YjDuD9gB498GcXLsogtB2zaGUA
 4f/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Bz7rHdUjkWL0jTzZNPpWHyvTQ/s7apH8M3kXEgBkOf8=;
 fh=cpUGXydLUNzyDKeZrCkRbAJvyRRfulgXrvM9rBuka1A=;
 b=FnDXLEgryurfD2KOzUlP0q8v/uGy/CQi4ndsSHdV4BqWLxairk4nVVl29ntPyTpFgx
 YblkYONIdmKXHbCFilgPcquE+6FmyRBVAsoJCifaWz1VgsqicIWhyZTzCa8lKHyYThVI
 VoCksK/R2jubYgqXB9MbRSGnROLAZZArwRvpKnijtzzdKAJbNWswVc6M8gQSBEfXxq8D
 FPKU/dW3NaKMeAhX9AgTTUsjPuUbD3UW/Swu9ARiUyW52U1JrKpWoUn31Hnr7e2kwxIf
 RrzIQeRbtMULowv1YfNqEHu2LvtOPmC1UeD3y5mneIQrmxbssNYQmFpzxVgP2lZpPVWc
 Y8Xw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784620826; x=1785225626;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bz7rHdUjkWL0jTzZNPpWHyvTQ/s7apH8M3kXEgBkOf8=;
 b=ciNNCFql9x/s644s1i159X7bZOXPn4kk9u6KbzdA8/4tHVH4K8kuF0ivd6d6z5nRTu
 9S49wAJF7EzwS3jrLnyYWjEteVnlBOEODi6T4Zz7QtVtVIJXv2dqVwP64xAtN98/QXY0
 4BV5NSN8/AVEddQXyPuH1VtimO5qzBuwitjNt5KvKtkOfGFhHeZkxi6WNA52p5iGgwcG
 VG9N+LDast3eLc6xxTKRGBf/75n3shxGfLFna3ewXD+NOBLA2JzC2bDUBu3CwS28mCeP
 /GhuBK9+JJgh8FuVqxS5MhBYx4BM44hBX7uKwGuPobK8sII/mT76HrqymO8m4eQgP9jO
 mgCA==
X-Gm-Message-State: AOJu0YzLJnss1z267DZoQhTEg3WKNGGf7JsJYri1fbs9DDdcNFqVY6T+
 okKrsgEi33JSe1f+ysdHMM4SDvFVMkYrK1qGF/2b9onRYV+Ds7ppbJbDi6F46YIFS08X9UvATMQ
 DxYuvQGy+pPjvnubet+6rNtu2IPuMSKc=
X-Gm-Gg: AfdE7cmjacTHkFvsehhdNLTs0ELQi3q/tV465sYhcKyc+dSm2VTUNa78NkS6A7X1zR2
 9BRsKDL1lHPc/tidy+tpk5EGxpTHcDceI0DBo4wxMMTCxkXMcT9d8eAyIReftr4GAf2RVDqK+Xe
 7LQNJ2uby7+rbtc3IuBrqurTNF6ZT42BpoDtwJu6H8WzSd3x/1Er+bo4D3+fJHW5Wrbeii0Nz3L
 4gaoma6WtnhHwS7Q9ZCtvdSGpWoI16Cq1jmYMMdBEIbIxvyKh5zvaAsScWWnmgYjWvtYUYPkdPK
 o2hY7kJt2HssIc+Pils=
X-Received: by 2002:a05:6a21:a8d:b0:3c3:9c4e:de3a with SMTP id
 adf61e73a8af0-3c3ad5b1bd4mr19364915637.6.1784620825494; Tue, 21 Jul 2026
 01:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260716110318.97757-1-advaitd@mechasystems.com>
In-Reply-To: <20260716110318.97757-1-advaitd@mechasystems.com>
Date: Tue, 21 Jul 2026 11:00:13 +0300
X-Gm-Features: AUfX_mx5NZX3VkBz3VMdA6QI1-xtK-tya8ZhPURpoyRfFBcYOheuTWT4yK4W02c
Message-ID: <CAPVz0n0zSAwzx5=xTBcitECQnmrjS+Fh5UboFC=igup=Sump6g@mail.gmail.com>
Subject: Re: [PATCH v3] video: add ChipWealth CH13726A AMOLED panel driver
To: Advait Dhamorikar <advaitd@mechasystems.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Rasmus Villemoes <ravi@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784620826; x=1785225626; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bz7rHdUjkWL0jTzZNPpWHyvTQ/s7apH8M3kXEgBkOf8=;
 b=oaNnYac6KqCQ3X4Kxs1N7T/vWfC6Bv3T7D4dsYpl9lkcJljvvpOOQghHOaUgy67nnd
 JF4/Xv3Jxsc6umFi4TQd+c17nd8okR/qOhHpbrYlKCSK3O8AO13ZAmgzCPiXsPm1BKCB
 /H7d0iHvD+gcmZ3AFhFIuea7DY/0QRzt82HU15YyrKcsL9GTNvnr0luazWMpeF/UDsSq
 myuu4DBtKrfNosAGENcc2gRilQWgQilzALVu23ULTMEYw8g7NY0oLkRuoCEdQlVxIEHp
 uAeAzbLoT3hB+q7+twTP/Uo2NyGcheYX80wv0pl7ynNPvgDzEg7VVKQEGdLv6S6YSwwj
 Wl0w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=oaNnYac6
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=clamor95@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="oaNnYac6"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Svyatoslav Ryhel via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Svyatoslav Ryhel <clamor95@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

=D1=87=D1=82, 16 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 14:03 Adva=
it Dhamorikar <advaitd@mechasystems.com> =D0=BF=D0=B8=D1=88=D0=B5:
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
> v2 -> v3
> Link to v2: https://lore.kernel.org/all/20260702151325.290749-1-advaitd@m=
echasystems.com/
> - Add regulator support using the U-Boot regulator framework.
> - Minor code cleanup.
>
>  drivers/video/Kconfig               |   8 +
>  drivers/video/Makefile              |   1 +
>  drivers/video/chipwealth-ch13726a.c | 221 ++++++++++++++++++++++++++++
>  3 files changed, 230 insertions(+)
>  create mode 100644 drivers/video/chipwealth-ch13726a.c
>
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index c2acc13139c..a214626f376 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -762,6 +762,14 @@ config VIDEO_LCD_SPI_MISO
>         option takes a string in the format understood by 'sunxi_name_to_=
gpio'
>         function, e.g. PH1 for pin 1 of port H.
>
> +config VIDEO_PANEL_CHIPWEALTH_CH13726A
> +       bool "ChipWealth CH13726A AMOLED panel support"
> +       depends on PANEL && BACKLIGHT
> +       select VIDEO_MIPI_DSI
> +       help
> +         Say Y here if you want to enable support for AMOLED panels
> +         based on the ChipWealth CH13726A MIPI DSI display driver IC.
> +
>  source "drivers/video/meson/Kconfig"
>
>  config VIDEO_MVEBU
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 082b8967982..efa7e288691 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_VIDEO_LCD_SSD2828) +=3D ssd2828.o
>  obj-$(CONFIG_VIDEO_LCD_TDO_TL070WSH30) +=3D tdo-tl070wsh30.o
>  obj-$(CONFIG_VIDEO_LCD_SONY_L4F00430T01) +=3D sony-l4f00430t01.o
>  obj-$(CONFIG_VIDEO_LCD_SAMSUNG_S6E63M0) +=3D samsung-s6e63m0.o
> +obj-$(CONFIG_VIDEO_PANEL_CHIPWEALTH_CH13726A) +=3D chipwealth-ch13726a.o
>  obj-$(CONFIG_VIDEO_MCDE_SIMPLE) +=3D mcde_simple.o
>  obj-${CONFIG_VIDEO_MESON} +=3D meson/
>  obj-${CONFIG_VIDEO_MIPI_DSI} +=3D mipi_dsi.o
> diff --git a/drivers/video/chipwealth-ch13726a.c b/drivers/video/chipweal=
th-ch13726a.c
> new file mode 100644
> index 00000000000..18f1dbc2e78
> --- /dev/null
> +++ b/drivers/video/chipwealth-ch13726a.c
> @@ -0,0 +1,221 @@
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
> +       struct udevice *vdd;
> +       struct udevice *vddio;
> +       struct udevice *vdd1v2;
> +       struct udevice *avdd;
> +       struct udevice *reg;

I must have missed this previously, sorry. The reg udevice pointer
seems not to be used anywhere.
Else seems fine, with this fixed.

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>

> +       struct udevice *backlight;
> +       struct gpio_desc reset;
> +};
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
> +#define dcs_write_seq(dev, cmd, seq...)                                \
> +({                                                             \
> +       struct mipi_dsi_panel_plat *plat =3D dev_get_plat(dev);   \
> +       const u8 d[] =3D { cmd, seq };                            \
> +       int ret;                                                \
> +                                                               \
> +       ret =3D mipi_dsi_dcs_write_buffer(plat->device,           \
> +                                       d, ARRAY_SIZE(d));      \
> +       if (ret < 0)                                            \
> +               log_err("failed to write dcs sequence: %d\n", ret);\
> +       ret;                                                    \
> +})
> +
> +static int ch13726a_hw_init(struct udevice *dev)
> +{
> +       int ret;
> +
> +       ret =3D dcs_write_seq(dev, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x00);
> +       if (ret < 0) {
> +               log_debug("%s: Init command failed (%d)\n",
> +                         __func__, ret);
> +               return ret;
> +       }
> +
> +       ret =3D dcs_write_seq(dev, MIPI_DSI_V_SYNC_END, 0x00);
> +       if (ret < 0) {
> +               log_debug("%s: Init command failed (%d)\n",
> +                         __func__, ret);
> +               return ret;
> +       }
> +
> +       mdelay(120);
> +
> +       ret =3D dcs_write_seq(dev, MIPI_DSI_GENERIC_LONG_WRITE, 0x00);
> +       if (ret < 0) {
> +               log_debug("%s: Init command failed (%d)\n",
> +                         __func__, ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
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
> +       ret =3D mipi_dsi_attach(device);
> +       if (ret < 0)
> +               return ret;
> +
> +       ch13726a_reset(dev);
> +
> +       ret =3D ch13726a_hw_init(dev);
> +       if (ret)
> +               return ret;
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
> +       if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
> +               ret =3D device_get_supply_regulator(dev, "vdd-supply",
> +                                                 &priv->vdd);
> +               if (ret && ret !=3D -ENOENT)
> +                       return ret;
> +
> +               ret =3D device_get_supply_regulator(dev, "vddio-supply",
> +                                                 &priv->vddio);
> +               if (ret && ret !=3D -ENOENT)
> +                       return ret;
> +
> +               ret =3D device_get_supply_regulator(dev, "vdd1v2-supply",
> +                                                 &priv->vdd1v2);
> +               if (ret && ret !=3D -ENOENT)
> +                       return ret;
> +
> +               ret =3D device_get_supply_regulator(dev, "avdd-supply",
> +                                                 &priv->avdd);
> +               if (ret && ret !=3D -ENOENT)
> +                       return ret;
> +       }
> +
> +       ret =3D gpio_request_by_name(dev, "reset-gpios", 0,
> +                                  &priv->reset,
> +                                  GPIOD_IS_OUT);
> +       if (ret) {
> +               log_err("%s: cannot get reset GPIO (%d)\n",
> +                       __func__, ret);
> +               if (ret !=3D -ENOENT)
> +                       return ret;
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
> +                       MIPI_DSI_MODE_VIDEO_BURST |
> +                       MIPI_DSI_MODE_LPM;
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
