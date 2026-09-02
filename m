Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A46C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:33:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0922980E8A;
	Wed,  2 Sep 2026 13:33:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7vjQhAKRNmF2; Wed,  2 Sep 2026 13:33:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788356019;
	bh=XCWszUM468AN2cU7PLUxXlSKjhOwq3emh4LZlOmRi0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FV1zYbXWillCVFbiFAISE2Hl/ljT2sPC805F9Y70lvfB5K6yskXaR9cWKRrefU8DO
	 i710ay2X51DW2Jia3aDjLMCwGQOrYt8PvWcPTZ61qCxqYwAuR5r7vAbDxKtmMRyIS8
	 4iFdUjnAAoHL9zWli9tnFn0lGzDaQKy4unggLZ87FuqbkU89qTHnv8GmJVSs+dFsgD
	 I4ULR4N6R3LyMm4uoITewtyiq2v02jdVKCYBWZcZubjiTiAqjkZ7l0WmsV9Cr3U0Rw
	 XnzzDgaaucy48oSSJeaKoniLOgEZEQVFWKGJjPX352a2MpbcQ/5EWhAVTwC1eWgYCO
	 L0//EomnECo1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFD4880E52;
	Wed,  2 Sep 2026 13:33:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E5961127
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:33:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6BF9407C6
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:33:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wA21V9hUZRGP for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:33:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=o1Bn51jn
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 82D6A407BC
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:33:34 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c2530cabcf4so166289566b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 06:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788356013; cv=none;
 d=google.com; s=arc-20260327;
 b=qNKWihknsUATPr2B29XrFWkEVUzJJcPEPay+01z4QF+S41W9oVqVWLz0XNcFInV0o1
 ZstA89MxhCqsifD0jJjCnJ+q6FFgaPbZs2yJ0AB/Q1n6AYsyua/Uy29QSojU8rTIKNDD
 Q8kMJUzuDLsJ2159FPS8WVEj2KZ2QDTrAqgHRs6kmebL+QhzmwXsbYw3+0qTvdcdA8VP
 0f5zwIt2rHTKBmzMAOPDOi5qQota+D+Qd3g2rUp6zr1E1opaahRaLcKLhUigOZnvrLtT
 CRrsfEfaMC1SrHXW3PGVjc8j75w7EfZVzc9wM6eA645GAJ7rakTynv2wNDGV/lVtUuiW
 74Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XCWszUM468AN2cU7PLUxXlSKjhOwq3emh4LZlOmRi0A=;
 fh=Er963qdjwAlLKHbbO0hPUYDsJ74LkLQwGpqLl7sRVlc=;
 b=nv4qvCsScuBa3zd2nHus4dKh4hZAvzfDxBLyVq00f82oIkI6GFDIjVP+PoTssLH3OC
 Q7IICB+N0ETnaMkF1Dqa6rd/tjohXnEppl0k5Bu5NAPIWnmdIz7//KC8gKnuwT4fFdGv
 J0e10SuY3vN1QoZu9CdPb/7DO2SxTjuGDm84NCWNi+36shR283GFd4hIWt3a94qsemSL
 8ZT3KgxPBfQ04MUQNAvDxReCGYoZSF4JHnGjJeo8S8Q2rk4wDHIkvvxsQGuD5CTE7ROC
 dElp51EAVWLrviWAaUs5018gzuDZpoowTaj0SZAStUCLo/fkVVwAmCCjOfHIAz/aCT+Z
 2ZBA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788356013; x=1788960813;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XCWszUM468AN2cU7PLUxXlSKjhOwq3emh4LZlOmRi0A=;
 b=o1Bn51jnJJNb14/phGw0KXTEXzvxtK2/6urHs9FDVsHI6rbCwz/p6T74PvyGzBTB+B
 JKr8Dm8LATKWcxOBeVnQ4rDjm30obXAwl5lb8CoBrrWynNZPVOsObIZtIuW375I/v9am
 xV3CPm3zyxKgnIUiVDX0xEUN1HwCNJ0RBYw+VjQCejtaJsklzibnCYX6Nz/DaL0rwaal
 9XhxXXJf+ws5gNGkr0fbE95voCcRiBWVwozUWGIF+qM1RGoyxvMrTNgNDIu4vN3zgc28
 s+8cPS7DwOMjBto9gZf1w0PoJb1R192UKevlmuv22mAsOQfUXpTFQD34k/rRVM2lUB3K
 4SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788356013; x=1788960813;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XCWszUM468AN2cU7PLUxXlSKjhOwq3emh4LZlOmRi0A=;
 b=dokOYb6dnrbP0o+TzH3ffP3zhT9ebQJG2/WCnjSBBE38jxfAOHRfFmLTH1oH3AgJDa
 ACMDFOixx5X9UaQc0dE1Tn9seDk3XaTNtqf250heStyRYv12u82mtWvrpDwDdLET4hDB
 XY1TJE9q2fDn+i/93CbS/6kP9ORidHsmNP3CE6ZtNpOG9MhAxAdoTZHGVWrBkjeYbzJV
 QqHiqVKrDwqaJN+zXkjSuQNKZEWwZcMYI8kcQK9r5gokIcMw/bmoSvclugNsH/8Lya4a
 K8ed8Z4l4x/p5GI4/X1FzODwJbCOi3gljJbuhqO3Xzk78C6/yMrW5JjIWbeBlAvzfc1t
 PgQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnlVpbPaPqFcW80dJ/qcukHspatc1RdMoZB+zu3cGHfTvRlampURtwuDjax8Ca0i50GAkqjy0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mq9G8Eq/C2P9RQkF1hXFyh20YhV9ZCUi+QGsabOxsLQvsPIkNA
 L+22TCGbXnpns/MiL2ss6NqEjC28GdUrDcKcLjw19jVe7qyxbvGlp8+eI7b97z8+KSkniD8B/kM
 +B19wDPbplx6oAG93E4uQHSgNttFnfdSH0Nv9gmDKDg==
X-Gm-Gg: AYBFou3OEi5HoAxp4jg7kOvVCXJMpN1XIKY+XBJNTBJR6g8EH+7jlTJu5KGK00ArsZU
 8bL+S2hxcxUYxBkAMEKiUubIARiTU4n/sdvIkp8oxeoeABFUP17MtUS+3kbeJSoeMSopqoodlgb
 D5DLwWoaQWxgJnI0oZGAjKB3m14pGXnw1hvlEnrkQhIpDz+7iUXe/pNiVyjkPCNJJoJkb1/n38D
 1LJ9JCe652t/nNKbTPfQGSpzLuJny40uz5WAqKYmW0iPWrfmvWj40xmxj/YAq/XTRDQC6fF+VRW
 mAWnh8iJ3bCUKc/ta1dvsQ0HpmGy6FCYJmeeMPoZu9v+KX3UMc8/EKfyneMrSOoo6vXadR4XsKS
 Gt/+5OXzCmN2giQE1oHWi1Cn3l0lS4lOvybPKUa+FVcW5LP5URik6kCUBT7I43OtL
X-Received: by 2002:a17:907:7206:b0:c25:2ec9:db91 with SMTP id
 a640c23a62f3a-c25d54754b6mr308423866b.14.1788356012760; Wed, 02 Sep 2026
 06:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260826-mtk-video-panel-startek-078-v2-1-c56342b77835@baylibre.com>
In-Reply-To: <20260826-mtk-video-panel-startek-078-v2-1-c56342b77835@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 2 Sep 2026 15:33:23 +0200
X-Gm-Features: AcwNN1VLTbodd6uvVAOLKhoysypkOnH0ytU9d_xWefzkI0gFboAT7PSA0TTjH_A
Message-ID: <CAEHHSvYCCi1Aksqb1mrkTOV8gz5852uzyqOkTNWPX4dcbhg-Wg@mail.gmail.com>
Subject: Re: [PATCH v2] video: panel-startek-kd070fhfid078: new driver
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Le mer. 26 ao=C3=BBt 2026 =C3=A0 23:22, David Lechner <dlechner@baylibre.co=
m> a =C3=A9crit :
>
> Add a driver for the Startek KD070FHFID078 7" DSI panel. This panel is
> used on the MediaTek Genio 360 EVK board.
>
> The display mode and DSI mode flags follow the upstream Linux driver
> panel-himax-hx8279.c, which is what the "himax,hx8279" fallback
> compatible in the device tree binds to.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Add a driver for the Startek KD070FHFID078 7" DSI panel.
>
> This depends on the mipi_dsi {generic,dcs}_write_seq helper macros series
> for mipi_dsi_generic_write_seq().
>
> Note: no defconfig enables this driver yet, since there is no MediaTek DS=
I
> host driver in U-Boot at this point. It will be enabled together with the
> display pipeline support.
> ---
> Changes in v2:
> - Added missing BACKLIGHT and DM_REGULATOR Kconfig dependencies.
> - Use the display mode and MIPI_DSI_CLOCK_NON_CONTINUOUS flag from the
>   upstream Linux panel-himax-hx8279.c driver instead of the MediaTek
>   downstream driver.
> - enable-gpios is now optional, matching the binding.
> - A missing backlight is now an error instead of a warning.
> - Do not request reset/enable GPIOs as active, so they are not asserted
>   before the regulators are enabled.
> - Use mipi_dsi_dcs_exit_sleep_mode()/mipi_dsi_dcs_set_display_on() instea=
d
>   of raw DCS opcodes and check their return values.
> - Dropped stale InforceComputing/Linaro copyright and author lines.
> - Dropped the unused dev field and the unreachable mode check.
> - Link to v1: https://patch.msgid.link/20260814-mtk-video-panel-startek-0=
78-v1-1-5f84a57244bc@baylibre.com
> ---
>  MAINTAINERS                                 |   6 +
>  drivers/video/Kconfig                       |  10 +
>  drivers/video/Makefile                      |   1 +
>  drivers/video/panel-startek-kd070fhfid078.c | 283 ++++++++++++++++++++++=
++++++
>  4 files changed, 300 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fabcb8b2968..b3bf5b1f8c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1723,6 +1723,12 @@ R:       GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_ups=
tream@mediatek.com>
>  S:     Maintained
>  F:     drivers/video/panel-startek-kd070fhfid015.c
>
> +STARTEK KD070FHFID078 PANEL
> +M:     David Lechner <dlechner@baylibre.com>
> +R:     GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> +S:     Maintained
> +F:     drivers/video/panel-startek-kd070fhfid078.c
> +
>  TARGET_BCMNS3
>  M:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>  S:     Maintained
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 37ab17f0ab2..495e4382a22 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -330,6 +330,16 @@ config PANEL_STARTEK_KD070FHFID015
>           1200 x 1920 pixels. It provides a MIPI DSI interface to the hos=
t, a
>           built-in LED backlight and touch controller.
>
> +config PANEL_STARTEK_KD070FHFID078
> +       bool "STARTEK KD070FHFID078 panel"
> +       depends on PANEL && BACKLIGHT && DM_GPIO && DM_REGULATOR
> +       select VIDEO_MIPI_DSI
> +       help
> +         Say Y here if you want to enable support for STARTEK KD070FHFID=
078 DSI panel.
> +         The panel is a 7-inch TFT LCD display with a resolution of 1200=
 x 1920
> +         pixels. It provides a MIPI DSI interface to the host, a built-i=
n LED
> +         backlight and touch controller.

This looks like a copy/paste from PANEL_STARTEK_KD070FHFID015. The
built-in LED backlight is wrong for this panel. drop it.

> +
>  config VIDEO_BOCHS
>         bool "Enable Bochs video emulation for QEMU"
>         help
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 7a54f1f290d..7a7b54e6b53 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_$(PHASE_)VIDEO) +=3D video_bmp.o
>  obj-$(CONFIG_$(PHASE_)PANEL) +=3D panel-uclass.o
>  obj-$(CONFIG_PANEL_HX8238D) +=3D hx8238d.o
>  obj-$(CONFIG_PANEL_STARTEK_KD070FHFID015) +=3D panel-startek-kd070fhfid0=
15.o
> +obj-$(CONFIG_PANEL_STARTEK_KD070FHFID078) +=3D panel-startek-kd070fhfid0=
78.o
>  obj-$(CONFIG_$(PHASE_)SIMPLE_PANEL) +=3D simple_panel.o
>
>  obj-$(CONFIG_VIDEO_LOGO) +=3D u_boot_logo.bmp.o
> diff --git a/drivers/video/panel-startek-kd070fhfid078.c b/drivers/video/=
panel-startek-kd070fhfid078.c
> new file mode 100644
> index 00000000000..dd5cac46267
> --- /dev/null
> +++ b/drivers/video/panel-startek-kd070fhfid078.c
> @@ -0,0 +1,283 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 MediaTek Inc.
> + * Copyright (C) 2026 BayLibre, SAS
> + *
> + * Authors:
> + * - Guillaume La Roque <glaroque@baylibre.com>
> + * - Jitao Shi <jitao.shi@mediatek.com>
> + * - David Lechner <dlechner@baylibre.com>
> + */
> +
> +#include <asm-generic/gpio.h>
> +#include <backlight.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <errno.h>
> +#include <linux/delay.h>
> +#include <mipi_dsi.h>
> +#include <panel.h>
> +#include <power/regulator.h>
> +
> +struct stk078_panel {
> +       struct gpio_desc *enable_gpio;
> +       struct gpio_desc *reset_gpio;
> +       struct mipi_dsi_device *dsi;
> +       struct udevice *iovcc;
> +       struct udevice *vdd;
> +       struct udevice *backlight;
> +};
> +
> +static const struct drm_display_mode default_mode =3D {
> +       .clock =3D 156458,
> +       .hdisplay =3D 1200,
> +       .hsync_start =3D 1200 + 50,
> +       .hsync_end =3D 1200 + 50 + 24,
> +       .htotal =3D 1200 + 50 + 24 + 66,
> +       .vdisplay =3D 1920,
> +       .vsync_start =3D 1920 + 14,
> +       .vsync_end =3D 1920 + 14 + 2,
> +       .vtotal =3D 1920 + 14 + 2 + 10,
> +};
> +
> +static int stk078_panel_init(struct stk078_panel *stk)
> +{
> +       struct mipi_dsi_device *dsi =3D stk->dsi;
> +       int ret;
> +
> +       mipi_dsi_generic_write_seq(dsi, 0xB0, 0x05);
> +       mipi_dsi_generic_write_seq(dsi, 0xB3, 0x52);
> +       mipi_dsi_generic_write_seq(dsi, 0xB8, 0x7F);
> +       mipi_dsi_generic_write_seq(dsi, 0xBC, 0x20);
> +       mipi_dsi_generic_write_seq(dsi, 0xD6, 0x7F);
> +       mipi_dsi_generic_write_seq(dsi, 0xB0, 0x01);
> +       mipi_dsi_generic_write_seq(dsi, 0xC0, 0x0D);
> +       mipi_dsi_generic_write_seq(dsi, 0xC1, 0x0D);
> +       mipi_dsi_generic_write_seq(dsi, 0xC2, 0x06);
> +       mipi_dsi_generic_write_seq(dsi, 0xC3, 0x06);
> +       mipi_dsi_generic_write_seq(dsi, 0xC4, 0x08);
> +       mipi_dsi_generic_write_seq(dsi, 0xC5, 0x08);
> +       mipi_dsi_generic_write_seq(dsi, 0xC6, 0x0A);
> +       mipi_dsi_generic_write_seq(dsi, 0xC7, 0x0A);
> +       mipi_dsi_generic_write_seq(dsi, 0xC8, 0x0C);
> +       mipi_dsi_generic_write_seq(dsi, 0xC9, 0x0C);
> +       mipi_dsi_generic_write_seq(dsi, 0xCA, 0x00);
> +       mipi_dsi_generic_write_seq(dsi, 0xCB, 0x00);
> +       mipi_dsi_generic_write_seq(dsi, 0xCC, 0x0E);
> +       mipi_dsi_generic_write_seq(dsi, 0xCD, 0x0E);
> +       mipi_dsi_generic_write_seq(dsi, 0xCE, 0x01);
> +       mipi_dsi_generic_write_seq(dsi, 0xCF, 0x01);
> +       mipi_dsi_generic_write_seq(dsi, 0xD0, 0x04);
> +       mipi_dsi_generic_write_seq(dsi, 0xD1, 0x04);
> +       mipi_dsi_generic_write_seq(dsi, 0xD2, 0x00);
> +       mipi_dsi_generic_write_seq(dsi, 0xD3, 0x00);
> +       mipi_dsi_generic_write_seq(dsi, 0xD4, 0x0D);
> +       mipi_dsi_generic_write_seq(dsi, 0xD5, 0x0D);
> +       mipi_dsi_generic_write_seq(dsi, 0xD6, 0x05);
> +       mipi_dsi_generic_write_seq(dsi, 0xD7, 0x05);
> +       mipi_dsi_generic_write_seq(dsi, 0xD8, 0x07);
> +       mipi_dsi_generic_write_seq(dsi, 0xD9, 0x07);
> +       mipi_dsi_generic_write_seq(dsi, 0xDA, 0x09);
> +       mipi_dsi_generic_write_seq(dsi, 0xDB, 0x09);
> +       mipi_dsi_generic_write_seq(dsi, 0xDC, 0x0B);
> +       mipi_dsi_generic_write_seq(dsi, 0xDD, 0x0B);
> +       mipi_dsi_generic_write_seq(dsi, 0xDE, 0x00);
> +       mipi_dsi_generic_write_seq(dsi, 0xDF, 0x00);
> +       mipi_dsi_generic_write_seq(dsi, 0xE0, 0x0E);
> +       mipi_dsi_generic_write_seq(dsi, 0xE1, 0x0E);
> +       mipi_dsi_generic_write_seq(dsi, 0xE2, 0x01);
> +       mipi_dsi_generic_write_seq(dsi, 0xE3, 0x01);
> +       mipi_dsi_generic_write_seq(dsi, 0xE4, 0x03);
> +       mipi_dsi_generic_write_seq(dsi, 0xE5, 0x03);
> +       mipi_dsi_generic_write_seq(dsi, 0xE6, 0x00);
> +       mipi_dsi_generic_write_seq(dsi, 0xE7, 0x00);
> +       mipi_dsi_generic_write_seq(dsi, 0xB0, 0x03);
> +       mipi_dsi_generic_write_seq(dsi, 0xBA, 0xF0);
> +       mipi_dsi_generic_write_seq(dsi, 0xC8, 0x07);
> +       mipi_dsi_generic_write_seq(dsi, 0xC9, 0x03);
> +       mipi_dsi_generic_write_seq(dsi, 0xCA, 0x41);
> +       mipi_dsi_generic_write_seq(dsi, 0xD2, 0x01);
> +       mipi_dsi_generic_write_seq(dsi, 0xD3, 0x05);
> +       mipi_dsi_generic_write_seq(dsi, 0xD4, 0x05);
> +       mipi_dsi_generic_write_seq(dsi, 0xD5, 0x8A);
> +       mipi_dsi_generic_write_seq(dsi, 0xE4, 0xC0);
> +       mipi_dsi_generic_write_seq(dsi, 0xE5, 0x00);
> +       mipi_dsi_generic_write_seq(dsi, 0xB0, 0x00);
> +       mipi_dsi_generic_write_seq(dsi, 0xBF, 0x1F);
> +       mipi_dsi_generic_write_seq(dsi, 0xC0, 0x12);
> +       mipi_dsi_generic_write_seq(dsi, 0xC2, 0x1E);
> +       mipi_dsi_generic_write_seq(dsi, 0xC4, 0x1E);
> +       mipi_dsi_generic_write_seq(dsi, 0xB0, 0x06);
> +       mipi_dsi_generic_write_seq(dsi, 0xB8, 0xA5);
> +       mipi_dsi_generic_write_seq(dsi, 0xC0, 0xA5);
> +       mipi_dsi_generic_write_seq(dsi, 0xBC, 0x11);
> +       mipi_dsi_generic_write_seq(dsi, 0xD5, 0x48);
> +       mipi_dsi_generic_write_seq(dsi, 0xB8, 0x00);
> +       mipi_dsi_generic_write_seq(dsi, 0xC0, 0x00);
> +
> +       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> +       if (ret < 0)
> +               return ret;
> +
> +       mdelay(120);
> +
> +       ret =3D mipi_dsi_dcs_set_display_on(dsi);
> +       if (ret < 0)
> +               return ret;
> +
> +       mdelay(20);
> +
> +       return 0;
> +}
> +
> +static int stk078_panel_enable_backlight(struct udevice *dev)
> +{
> +       struct stk078_panel *stk =3D dev_get_priv(dev);
> +       struct mipi_dsi_panel_plat *plat =3D dev_get_plat(dev);
> +       struct mipi_dsi_device *dsi =3D plat->device;
> +       int ret;
> +
> +       stk->dsi =3D dsi;
> +       ret =3D mipi_dsi_attach(dsi);
> +       if (ret < 0) {
> +               dev_err(dev, "mipi_dsi_attach failed: %d\n", ret);
> +               return ret;
> +       }
> +
> +       dm_gpio_set_value(stk->reset_gpio, 0);
> +       if (stk->enable_gpio)
> +               dm_gpio_set_value(stk->enable_gpio, 0);
> +       mdelay(10);
> +
> +       ret =3D regulator_enable(stk->vdd);
> +       if (ret < 0) {
> +               dev_err(dev, "enable vdd failed: %d\n", ret);
> +               goto out_gpio;
> +       }
> +
> +       ret =3D regulator_enable(stk->iovcc);
> +       if (ret < 0) {
> +               dev_err(dev, "enable iovcc failed: %d\n", ret);
> +               goto out_vdd;
> +       }
> +
> +       mdelay(15);
> +       if (stk->enable_gpio)
> +               dm_gpio_set_value(stk->enable_gpio, 1);
> +       mdelay(10);
> +       dm_gpio_set_value(stk->reset_gpio, 1);
> +       mdelay(140);
> +
> +       ret =3D stk078_panel_init(stk);
> +       if (ret < 0) {
> +               dev_err(dev, "panel init sequence failed: %d\n", ret);
> +               goto out_power;
> +       }
> +
> +       ret =3D backlight_enable(stk->backlight);
> +       if (ret < 0) {
> +               dev_err(dev, "enable backlight failed: %d\n", ret);
> +               goto out_power;
> +       }
> +
> +       return 0;
> +
> +out_power:
> +       regulator_disable(stk->iovcc);
> +out_vdd:
> +       regulator_disable(stk->vdd);
> +out_gpio:
> +       dm_gpio_set_value(stk->reset_gpio, 0);
> +       if (stk->enable_gpio)
> +               dm_gpio_set_value(stk->enable_gpio, 0);
> +
> +       return ret;

I think we are missing mipi_dsi_detach() call at the end

> +}
> +
> +static int stk078_panel_add(struct udevice *dev)
> +{
> +       struct stk078_panel *stk =3D dev_get_priv(dev);
> +       int ret;
> +
> +       ret =3D device_get_supply_regulator(dev, "iovcc-supply", &stk->io=
vcc);
> +       if (ret) {
> +               dev_err(dev, "Failed to get iovcc regulator: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret =3D device_get_supply_regulator(dev, "vdd-supply", &stk->vdd)=
;
> +       if (ret) {
> +               dev_err(dev, "Failed to get vdd regulator: %d\n", ret);
> +               return ret;
> +       }
> +
> +       stk->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_IS_OUT);
> +       if (IS_ERR(stk->reset_gpio)) {
> +               ret =3D PTR_ERR(stk->reset_gpio);
> +               dev_err(dev, "cannot get reset-gpios %d\n", ret);
> +               return ret;
> +       }
> +
> +       stk->enable_gpio =3D devm_gpiod_get_optional(dev, "enable", GPIOD=
_IS_OUT);
> +       if (IS_ERR(stk->enable_gpio)) {
> +               ret =3D PTR_ERR(stk->enable_gpio);
> +               dev_err(dev, "cannot get enable-gpios %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret =3D uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
> +                                          "backlight", &stk->backlight);
> +       if (ret) {
> +               dev_err(dev, "failed to get backlight: %d\n", ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int stk078_panel_probe(struct udevice *dev)
> +{
> +       struct mipi_dsi_panel_plat *plat =3D dev_get_plat(dev);
> +       int ret;
> +
> +       plat->lanes =3D 4;
> +       plat->format =3D MIPI_DSI_FMT_RGB888;
> +       plat->mode_flags =3D MIPI_DSI_MODE_VIDEO |
> +                          MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +                          MIPI_DSI_MODE_LPM |
> +                          MIPI_DSI_CLOCK_NON_CONTINUOUS;
> +
> +       ret =3D stk078_panel_add(dev);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;

can be simplified:  return stk078_panel_add(dev);

> +}
> +
> +static int stk078_panel_get_modes(struct udevice *dev,
> +                                 const struct drm_display_mode **modes)
> +{
> +       *modes =3D &default_mode;
> +
> +       return 1;
> +}
> +
> +static const struct panel_ops stk078_panel_ops =3D {
> +       .enable_backlight =3D stk078_panel_enable_backlight,
> +       .get_modes =3D stk078_panel_get_modes,
> +};
> +
> +static const struct udevice_id stk078_of_match[] =3D {
> +       { .compatible =3D "startek,kd070fhfid078" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(stk078_panel_driver) =3D {
> +       .name           =3D "panel-startek-kd070fhfid078",
> +       .id             =3D UCLASS_PANEL,
> +       .of_match       =3D stk078_of_match,
> +       .ops            =3D &stk078_panel_ops,
> +       .probe          =3D stk078_panel_probe,
> +       .plat_auto      =3D sizeof(struct mipi_dsi_panel_plat),
> +       .priv_auto      =3D sizeof(struct stk078_panel),
> +};
>
> ---
> base-commit: f252d228be2b2d180737ad0a851f91749273cbd9
> change-id: 20260814-mtk-video-panel-startek-078-1a9ab38e89f7
> prerequisite-message-id: <20260806-add_mipi_dsi_write_seq_helper_macros-v=
1-0-6b533788d0ac@baylibre.com>
> prerequisite-patch-id: cf35ac4802976971af68bd0ce1dc0ab872fdb661
> prerequisite-patch-id: 9f6aca2bfde84a5d84329b77b3b9af8898b18e4a
> prerequisite-patch-id: e7bb7ee54b88b6d6e00f74fe84b1c81d00957051
> prerequisite-patch-id: d4a530120b1a93d68e4b17c6e1fcf2878e784454
> prerequisite-patch-id: 18b1bbeab6808decceaf5117b3e999baf4495e1d
> prerequisite-patch-id: d50e7e28a399c303226ff08c78e60749930a7243
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>
