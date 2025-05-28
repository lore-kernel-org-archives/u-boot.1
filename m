Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14356C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 18:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DA08833C8;
	Wed, 28 May 2025 20:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pfFwrbSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04F0C833D0; Wed, 28 May 2025 20:24:11 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7A1A833BF
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 20:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3109f106867so69537a91.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 11:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748456646; x=1749061446;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sznirocUoAY7MQ+QoCutxYY2K/tpQyELmJOJduS4R+I=;
 b=pfFwrbSVbowMwtxu4O7Xcdiks50O83RbB1MtPycdzWdET0/Ly+fx+HB1O7Ry5296PJ
 twA1c5FjwuM4zB97C4ofMjgu5aF89f1NRC1M4iuI8N5QrtPwx8DHBssCs3XGbrnTGg6c
 YRMCprTcj/qgBTPtERqMZ/GnjdtIosdFWygBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748456646; x=1749061446;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sznirocUoAY7MQ+QoCutxYY2K/tpQyELmJOJduS4R+I=;
 b=kDyujQlgx87Rnc6TmIZk4UClWjq3o8V9SdeFtRi3Dmf4UAjdgOWG0nGtoVvsU4UEHm
 g0Q8tuPSbYPHeOWurBZbjiLHcpTTMQM6E8hWS3pztzGJ0mZ5xDyBWm8Dtj4V4AVbw2o+
 gaox6g5nfX8rnRXJ2Hh6FlVhd0EovDKDM3QhMk5rUvXl2+wTUIpBITmgT3HeI6Taa4Pg
 EwYlsmR1ncWW15MQss4STIK9INkWN7la4zhrIjFowhPpqD+TgJ/GnROLp94l6nraIgLb
 jOQWotGAlCdWlXUemWeMupotIQDlvzptsSmYYEXtOUFZz5WuyO29pLLVVrybjWbF2Q73
 TxFw==
X-Gm-Message-State: AOJu0YwlRFIkO+fBiVXufFYUob30OEO4966lZs6htOpseHTR1U32QpiF
 8jGtTXR+k5UeYkGcDphmyezL2z0CEKwdzUatmT0eY/YzBSGckOOe0sHy/vHrN0zU/jwl+0jy9mK
 A05wfsorg6QZuXMeBfxlQ6GOJnYugwegkJL3rz2wa0VS6xbXE/bdT3nlfWw==
X-Gm-Gg: ASbGncvhDJgrGwX5i0afKojYw6/Bu7xCtV4ID8iphlPZT4lEVDBiWtAs4YH64kfXdtD
 KX9oTb+xiXJ+8yRTDxsBGGLo/b1ZRjrd3WZEs9WQ8v67fNGHNuYZuVgCa0CCHOL4TuIfps1Rd5H
 6Eo9Y9ghDXOjLyeoaQp5YKqVo6yx6w/i8=
X-Google-Smtp-Source: AGHT+IG8uBoVvIHH+uVB7GztlNTSu+SlLfWR5j2RGy+W3Ocz7V+D/1epM7gNTMpkCnhzT15wR1dI9TGkZmq4l5Km/lA=
X-Received: by 2002:a17:90b:1a8b:b0:312:1516:5ef1 with SMTP id
 98e67ed59e1d1-3121516658emr682118a91.7.1748456635749; Wed, 28 May 2025
 11:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250526194811.1179530-1-michael@amarulasolutions.com>
 <c56157288f9341f2bc12eccdaccb4e4d@dh-electronics.com>
In-Reply-To: <c56157288f9341f2bc12eccdaccb4e4d@dh-electronics.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 28 May 2025 20:23:43 +0200
X-Gm-Features: AX0GCFv00BOzrQydrGDa6PWAYKPBDiDbltWjWz24K8M9fM1RDaPnxqD8D10PcLg
Message-ID: <CAOf5uwk0eiKLO=y3BG=Pu+mnPgX9KFWTGJE-EuULA3G-DhSvcw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] clk: imx: add i.MX6UL clk driver
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 Adam Ford <aford173@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
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

Hi

On Wed, May 28, 2025 at 8:12=E2=80=AFPM Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:
>
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Michael Trimarch=
i
> Sent: Monday, May 26, 2025 9:48 PM
>
> Hello,
>
> > Subject: [PATCH v2 1/4] clk: imx: add i.MX6UL clk driver
> >
> > Add i.MX6UL clk driver for i.MX6UL CLK driver model usage
> >
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> >
> > ---
> >
> > Changes in v2:
> > - Add review tag
> >
> >  drivers/clk/imx/Kconfig      |   8 ++
> >  drivers/clk/imx/Makefile     |   1 +
> >  drivers/clk/imx/clk-imx6ul.c | 270 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 279 insertions(+)
> >  create mode 100644 drivers/clk/imx/clk-imx6ul.c
> >
> > diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> > index d17a54fb9b3..705d4a8e2ac 100644
> > --- a/drivers/clk/imx/Kconfig
> > +++ b/drivers/clk/imx/Kconfig
> > @@ -14,6 +14,14 @@ config CLK_IMX6Q
> >       help
> >         This enables DM/DTS support for clock driver in i.MX6Q platform=
s.
> >
> > +config CLK_IMX6UL
> > +     bool "Clock support for i.MXUL"
> > +     depends on ARCH_MX6
> > +     select CLK
> > +     select CLK_CCF
> > +     help
> > +       This enables DM/DTS support for clock driver in i.MX6UL platfor=
ms.
> > +
> >  config CLK_IMX8
> >       bool "Clock support for i.MX8"
> >       depends on ARCH_IMX8
> > diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> > index a89ee7acb12..b10221a195c 100644
> > --- a/drivers/clk/imx/Makefile
> > +++ b/drivers/clk/imx/Makefile
> > @@ -4,6 +4,7 @@
> >
> >  obj-$(CONFIG_$(PHASE_)CLK_CCF) +=3D clk-gate2.o clk-pllv3.o clk-pfd.o
> >  obj-$(CONFIG_$(PHASE_)CLK_IMX6Q) +=3D clk-imx6q.o
> > +obj-$(CONFIG_$(PHASE_)CLK_IMX6UL) +=3D clk-imx6ul.o
> >  obj-$(CONFIG_CLK_IMX8) +=3D clk-imx8.o
> >
> >  ifdef CONFIG_CLK_IMX8
> > diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.=
c
> > new file mode 100644
> > index 00000000000..941c9352248
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-imx6ul.c
> > @@ -0,0 +1,270 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2025 Amarula Solutions Software Engineering
> > + * Michael Trimarchi, Amarula Solutions Software Engineering,
> > michael@amarulasolutions.com
> > + */
> > +
> > +#include <clk-uclass.h>
> > +#include <dm.h>
> > +#include <log.h>
> > +#include <asm/arch/clock.h>
> > +#include <asm/arch/imx-regs.h>
> > +#include <dt-bindings/clock/imx6ul-clock.h>
> > +
> > +#include "clk.h"
> > +
> > +static int imx6ul_clk_request(struct clk *clk)
> > +{
> > +     debug("%s: request clk id %ld\n", __func__, clk->id);
> > +
> > +     if (clk->id < IMX6UL_CLK_DUMMY || clk->id >=3D IMX6UL_CLK_END) {
> > +             printf("%s: Invalid clk ID #%lu\n", __func__, clk->id);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static struct clk_ops imx6ul_clk_ops =3D {
> > +     .request =3D imx6ul_clk_request,
> > +     .set_rate =3D ccf_clk_set_rate,
> > +     .get_rate =3D ccf_clk_get_rate,
> > +     .enable =3D ccf_clk_enable,
> > +     .disable =3D ccf_clk_disable,
> > +};
> > +
> > +static const char *const pll_bypass_src_sels[] =3D { "osc", "dummy", }=
;
> > +static const char *const pll3_bypass_sels[] =3D { "pll3", "pll3_bypass=
_src", };
> > +static const char *const bch_sels[] =3D { "pll2_pfd2_396m", "pll2_pfd0=
_352m", };
> > +static const char *const gpmi_sels[] =3D { "pll2_pfd2_396m", "pll2_pfd=
0_352m", };
> > +
> > +static const char *const enfc_sels[] =3D { "pll2_pfd0_352m", "pll2_bus=
", "pll3_usb_otg",
> > "pll2_pfd2_396m",
> > +                                      "pll3_pfd3_454m", "dummy", "dumm=
y", "dummy", };
> > +static const char *const usdhc_sels[] =3D { "pll2_pfd2_396m", "pll2_pf=
d0_352m", };
> > +static const char *const periph_sels[] =3D { "periph_pre", "periph_clk=
2", };
> > +static const char *const periph2_pre_sels[] =3D { "pll2_bus", "pll2_pf=
d2_396m",
> > "pll2_pfd0_352m",
> > +                                             "pll4_audio_div", };
> > +static const char *const periph_clk2_sels[] =3D { "pll3_usb_otg", "osc=
", "pll2_bypass_src",
> > };
> > +static const char *const periph2_clk2_sels[] =3D { "pll3_usb_otg", "os=
c", };
> > +static const char *const perclk_sels[] =3D { "ipg", "osc", };
> > +
> > +static const char *const periph_pre_sels[] =3D { "pll2_bus", "pll2_pfd=
2_396m",
> > "pll2_pfd0_352m",
> > +                                            "pll2_198m", };
> > +static const char *const uart_sels[] =3D { "pll3_80m", "osc", };
> > +static const char *const ecspi_sels[] =3D { "pll3_60m", "osc", };
> > +
> > +static int imx6ul_clk_probe(struct udevice *dev)
> > +{
> > +     struct clk osc_clk;
> > +     void *base;
> > +     int ret;
> > +
> > +     /* Anatop clocks */
> > +     base =3D (void *)ANATOP_BASE_ADDR;
> > +
> > +     clk_dm(IMX6UL_CLK_DUMMY, clk_register_fixed_rate(NULL, "dummy", 0=
));
>
> I think you should move your clk_get_by_name of "osc" etc. from below
> to this place, because you refer to it in the next lines.

Ok

>
> > +     clk_dm(IMX6UL_CLK_PLL2,
> > +            imx_clk_pllv3(dev, IMX_PLLV3_GENERIC, "pll2_bus", "osc",
> > +                          base + 0x30, 0x1));
> > +     clk_dm(IMX6UL_CLK_PLL3_USB_OTG,
> > +            imx_clk_pllv3(dev, IMX_PLLV3_USB, "pll3_bypass", "osc",
> > +                          base + 0x10, 0x3));
>
> From my point of view the line with "pll3_bypass" here looks not correct
> and should be removed.

I need to check but please give more info about it. I have only one design =
so,
I have based most of the clk driver on what I can test

>
> > +     clk_dm(IMX6UL_CLK_PLL3,
> > +            imx_clk_pllv3(dev, IMX_PLLV3_USB, "pll3", "osc",
> > +                          base + 0x10, 0x3));
>
> I think you should move your definition of "pll3_bypass_src" and "pll3_by=
pass"
> from below to this place, because you refer to it in the next lines.
>
Ok

> > +     clk_dm(IMX6UL_CLK_PLL3_USB_OTG,
> > +            imx_clk_gate(dev, "pll3_usb_otg", "pll3_bypass", base + 0x=
10,
> > +                         13));
> > +     clk_dm(IMX6UL_CLK_PLL3_80M,
> > +            imx_clk_fixed_factor(dev, "pll3_80m", "pll3_usb_otg", 1, 6=
));
> > +     clk_dm(IMX6UL_CLK_PLL3_60M,
> > +            imx_clk_fixed_factor(dev, "pll3_60m", "pll3_usb_otg", 1, 8=
));
> > +     clk_dm(IMX6UL_CLK_PLL2_PFD0,
> > +            imx_clk_pfd("pll2_pfd0_352m", "pll2_bus", base + 0x100, 0)=
);
> > +     clk_dm(IMX6UL_CLK_PLL2_PFD1,
> > +            imx_clk_pfd("pll2_pfd1_594m", "pll2_bus", base + 0x100, 1)=
);
> > +     clk_dm(IMX6UL_CLK_PLL2_PFD2,
> > +            imx_clk_pfd("pll2_pfd2_396m", "pll2_bus", base + 0x100, 2)=
);
> > +     clk_dm(IMX6UL_CLK_PLL2_PFD3,
> > +            imx_clk_pfd("pll2_pfd3_396m", "pll2_bus", base + 0x100, 3)=
);
> > +     clk_dm(IMX6UL_CLK_PLL6,
> > +            imx_clk_pllv3(dev, IMX_PLLV3_ENET, "pll6", "osc", base + 0=
xe0,
> > +                          0x3));
> > +     clk_dm(IMX6UL_CLK_PLL6_ENET,
> > +            imx_clk_gate(dev, "pll6_enet", "pll6", base + 0xe0, 13));
> > +     clk_dm(IMX6UL_PLL3_BYPASS_SRC,
> > +            imx_clk_mux(dev, "pll3_bypass_src", base + 0x10, 14, 1,
> > +                        pll_bypass_src_sels,
> > +                        ARRAY_SIZE(pll_bypass_src_sels)));
> > +     clk_dm(IMX6UL_PLL3_BYPASS,
> > +            imx_clk_mux_flags(dev, "pll3_bypass", base + 0x10, 16, 1,
> > +                              pll3_bypass_sels, ARRAY_SIZE(pll3_bypass=
_sels),
> > +                              CLK_SET_RATE_PARENT));
> > +
> > +     ret =3D clk_get_by_name(dev, "osc", &osc_clk);
> > +     if (ret)
> > +             return ret;
> > +     clk_dm(IMX6UL_CLK_OSC, dev_get_clk_ptr(osc_clk.dev));
> > +
> > +     /* CCM clocks */
> > +     base =3D dev_read_addr_ptr(dev);
> > +     if (!base)
> > +             return -EINVAL;
> > +
> > +     clk_dm(IMX6UL_CLK_GPMI_SEL,
> > +            imx_clk_mux(dev, "gpmi_sel", base + 0x1c, 19, 1, gpmi_sels=
,
> > +                        ARRAY_SIZE(gpmi_sels)));
> > +     clk_dm(IMX6UL_CLK_BCH_SEL,
> > +            imx_clk_mux(dev, "bch_sel", base + 0x1c, 18, 1, bch_sels,
> > +                        ARRAY_SIZE(bch_sels)));
> > +     clk_dm(IMX6UL_CLK_USDHC1_SEL,
> > +            imx_clk_mux(dev, "usdhc1_sel", base + 0x1c, 16, 1, usdhc_s=
els,
> > +                        ARRAY_SIZE(usdhc_sels)));
> > +     clk_dm(IMX6UL_CLK_USDHC2_SEL,
> > +            imx_clk_mux(dev, "usdhc2_sel", base + 0x1c, 17, 1, usdhc_s=
els,
> > +                        ARRAY_SIZE(usdhc_sels)));
> > +     clk_dm(IMX6UL_CLK_ECSPI_SEL,
> > +            imx_clk_mux(dev, "ecspi_sel", base + 0x38, 18, 1, ecspi_se=
ls,
> > +                        ARRAY_SIZE(ecspi_sels)));
> > +     clk_dm(IMX6UL_CLK_UART_SEL,
> > +            imx_clk_mux(dev, "uart_sel", base + 0x24, 6, 1, uart_sels,
> > +                        ARRAY_SIZE(uart_sels)));
> > +     clk_dm(IMX6UL_CLK_ENFC_SEL,
> > +            imx_clk_mux(dev, "enfc_sel", base + 0x2c, 15, 3, enfc_sels=
,
> > +                        ARRAY_SIZE(enfc_sels)));
> > +     clk_dm(IMX6UL_CLK_PERCLK_SEL,
> > +            imx_clk_mux(dev, "perclk_sel", base + 0x1c, 6, 1, perclk_s=
els,
> > +                        ARRAY_SIZE(perclk_sels)));
> > +     clk_dm(IMX6UL_CLK_PERIPH_PRE,
> > +            imx_clk_mux(dev, "periph_pre", base + 0x18, 18, 2,
> > +                        periph_pre_sels, ARRAY_SIZE(periph_pre_sels)))=
;
> > +     clk_dm(IMX6UL_CLK_PERIPH2_PRE,
> > +            imx_clk_mux(dev, "periph2_pre", base + 0x18, 21, 2,
> > +                        periph2_pre_sels, ARRAY_SIZE(periph2_pre_sels)=
));
> > +     clk_dm(IMX6UL_CLK_PERIPH_CLK2_SEL,
> > +            imx_clk_mux(dev, "periph_clk2_sel", base + 0x18, 12, 2,
> > +                        periph_clk2_sels, ARRAY_SIZE(periph_clk2_sels)=
));
> > +     clk_dm(IMX6UL_CLK_PERIPH2_CLK2_SEL,
> > +            imx_clk_mux(dev, "periph2_clk2_sel", base + 0x18, 20, 1,
> > +                        periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sel=
s)));
> > +     clk_dm(IMX6UL_CLK_PERIPH,
> > +            imx_clk_busy_mux(dev, "periph", base + 0x14, 25, 1, base +=
 0x48,
> > +                             5, periph_sels, ARRAY_SIZE(periph_sels)))=
;
> > +     clk_dm(IMX6UL_CLK_AHB,
> > +            imx_clk_busy_divider(dev, "ahb", "periph", base + 0x14, 10=
, 3,
> > +                                 base + 0x48, 1));
> > +     clk_dm(IMX6UL_CLK_PERIPH_CLK2,
> > +            imx_clk_divider(dev, "periph_clk2", "periph_clk2_sel",
> > +                            base + 0x14, 27, 3));
> > +     clk_dm(IMX6UL_CLK_PERIPH2_CLK2,
> > +            imx_clk_divider(dev, "periph2_clk2", "periph2_clk2_sel",
> > +                            base + 0x14, 0, 3));
> > +     clk_dm(IMX6UL_CLK_IPG,
> > +            imx_clk_divider(dev, "ipg", "ahb", base + 0x14, 8, 2));
> > +     clk_dm(IMX6UL_CLK_ENFC_PRED,
> > +            imx_clk_divider(dev, "enfc_pred", "enfc_sel", base + 0x2c,=
 18,
> > +                            3));
> > +     clk_dm(IMX6UL_CLK_ENFC_PODF,
> > +            imx_clk_divider(dev, "enfc_podf", "enfc_pred", base + 0x2c=
, 21,
> > +                            6));
> > +     clk_dm(IMX6UL_CLK_GPMI_PODF,
> > +            imx_clk_divider(dev, "gpmi_podf", "gpmi_sel", base + 0x24,=
 22,
> > +                            3));
> > +     clk_dm(IMX6UL_CLK_BCH_PODF,
> > +            imx_clk_divider(dev, "bch_podf", "bch_sel", base + 0x24, 1=
9, 3));
> > +     clk_dm(IMX6UL_CLK_PERCLK,
> > +            imx_clk_divider(dev, "perclk", "perclk_sel", base + 0x1c, =
0, 6));
> > +     clk_dm(IMX6UL_CLK_UART_PODF,
> > +            imx_clk_divider(dev, "uart_podf", "uart_sel", base + 0x24,=
 0,
> > +                            6));
> > +     clk_dm(IMX6UL_CLK_USDHC1_PODF,
> > +            imx_clk_divider(dev, "usdhc1_podf", "usdhc1_sel", base + 0=
x24,
> > +                            11, 3));
> > +     clk_dm(IMX6UL_CLK_USDHC2_PODF,
> > +            imx_clk_divider(dev, "usdhc2_podf", "usdhc2_sel", base + 0=
x24,
> > +                            16, 3));
> > +     clk_dm(IMX6UL_CLK_ECSPI_PODF,
> > +            imx_clk_divider(dev, "ecspi_podf", "ecspi_sel", base + 0x3=
8, 19,
> > +                            6));
> > +
> > +     clk_dm(IMX6UL_CLK_APBHDMA,
> > +            imx_clk_gate2(dev, "apbh_dma", "bch_podf", base + 0x68, 4)=
);
> > +     clk_dm(IMX6UL_CLK_ECSPI1,
> > +            imx_clk_gate2(dev, "ecspi1", "ecspi_podf", base + 0x6c, 0)=
);
> > +     clk_dm(IMX6UL_CLK_ECSPI2,
> > +            imx_clk_gate2(dev, "ecspi2", "ecspi_podf", base + 0x6c, 2)=
);
> > +     clk_dm(IMX6UL_CLK_ECSPI3,
> > +            imx_clk_gate2(dev, "ecspi3", "ecspi_podf", base + 0x6c, 4)=
);
> > +     clk_dm(IMX6UL_CLK_ECSPI4,
> > +            imx_clk_gate2(dev, "ecspi4", "ecspi_podf", base + 0x6c, 6)=
);
> > +
> > +     clk_dm(IMX6UL_CLK_USBOH3,
> > +            imx_clk_gate2(dev, "usboh3", "ipg", base + 0x80, 0));
> > +     clk_dm(IMX6UL_CLK_USDHC1,
> > +            imx_clk_gate2(dev, "usdhc1", "usdhc1_podf", base + 0x80, 2=
));
> > +     clk_dm(IMX6UL_CLK_USDHC2,
> > +            imx_clk_gate2(dev, "usdhc2", "usdhc2_podf", base + 0x80, 4=
));
> > +
> > +     clk_dm(IMX6UL_CLK_UART3_IPG,
> > +            imx_clk_gate2(dev, "uart3_ipg", "ipg", base + 0x6c, 10));
> > +     clk_dm(IMX6UL_CLK_UART3_SERIAL,
> > +            imx_clk_gate2(dev, "uart3_serial", "uart_podf", base + 0x6=
c,
> > +                          10));
> > +     clk_dm(IMX6UL_CLK_UART4_IPG,
> > +            imx_clk_gate2(dev, "uart4_ipg", "ipg", base + 0x6c, 24));
> > +     clk_dm(IMX6UL_CLK_UART4_SERIAL,
> > +            imx_clk_gate2(dev, "uart4_serial", "uart_podf", base + 0x6=
c,
> > +                          24));
>
> My Console doesn't work with this driver, because it is on UART1.
> Could you define all UARTs for imx6UL/i.MX6ULL/i.MX6ULZ here?

Yes I can

>
> clk_dm(IMX6UL_CLK_UART1_IPG,
>        imx_clk_gate2(dev, "uart1_ipg", "ipg", base + 0x7c, 24));
> clk_dm(IMX6UL_CLK_UART1_SERIAL,
>        imx_clk_gate2(dev, "uart1_serial", "uart_podf", base + 0x7c, 24));
> clk_dm(IMX6UL_CLK_UART2_IPG,
>        imx_clk_gate2(dev, "uart2_ipg", "ipg", base + 0x68, 28));
> clk_dm(IMX6UL_CLK_UART2_SERIAL,
>        imx_clk_gate2(dev, "uart2_serial", "uart_podf", base + 0x68, 28));
> clk_dm(IMX6UL_CLK_UART3_IPG,
>        imx_clk_gate2(dev, "uart3_ipg", "ipg", base + 0x6c, 10));
> clk_dm(IMX6UL_CLK_UART3_SERIAL,
>        imx_clk_gate2(dev, "uart3_serial", "uart_podf", base + 0x6c, 10));
> clk_dm(IMX6UL_CLK_UART4_IPG,
>        imx_clk_gate2(dev, "uart4_ipg", "ipg", base + 0x6c, 24));
> clk_dm(IMX6UL_CLK_UART4_SERIAL,
>        imx_clk_gate2(dev, "uart4_serial", "uart_podf", base + 0x6c, 24));
> clk_dm(IMX6UL_CLK_UART5_IPG,
>        imx_clk_gate2(dev, "uart5_ipg", "ipg", base + 0x74, 2));
> clk_dm(IMX6UL_CLK_UART5_SERIAL,
>        imx_clk_gate2(dev, "uart5_serial", "uart_podf", base + 0x74, 2));
> clk_dm(IMX6UL_CLK_UART6_IPG,
>        imx_clk_gate2(dev, "uart6_ipg", "ipg", base + 0x74, 6));
> clk_dm(IMX6UL_CLK_UART6_SERIAL,
>        imx_clk_gate2(dev, "uart6_serial", "uart_podf", base + 0x74, 6));
> clk_dm(IMX6UL_CLK_UART7_IPG,
>        imx_clk_gate2(dev, "uart7_ipg", "ipg", base + 0x7c, 26));
> clk_dm(IMX6UL_CLK_UART7_SERIAL,
>        imx_clk_gate2(dev, "uart7_serial", "uart_podf", base + 0x7c, 26));
> clk_dm(IMX6UL_CLK_UART8_IPG,
>        imx_clk_gate2(dev, "uart8_ipg", "ipg", base + 0x80, 14));
> clk_dm(IMX6UL_CLK_UART8_SERIAL,
>        imx_clk_gate2(dev, "uart8_serial", "uart_podf", base + 0x80, 14));
>

I have an imx6ulz, so be patient but I can add them but I can not test
them at all.
I will check tonight what else to add but I was thinking of letting
other people contribute
more using their board.

Michael

> Regards
> Christoph



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
