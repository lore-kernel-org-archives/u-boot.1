Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EA9CEB2FE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 05:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 131FC890D8;
	Tue,  1 Oct 2024 07:02:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l2btbmVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 977AA890D8; Tue,  1 Oct 2024 07:02:05 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A428890DA
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 07:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c5bca59416so6187518a12.1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 22:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1727758923; x=1728363723;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bUif3YGJ3LG6bd9hGX/hM8r4+MkoghWSdAupcdP4w/A=;
 b=l2btbmVTrrvqLj5mUGi9fyuOBt/LiCz41/yd5Nr2jOp6XbQuNDOao/gjlirWEaZoUb
 hId06KRTVvPCF+H+pbVsOLcCev92mOPZ9bu0JTgRDfAjsjuRn1bWqVnoy+/bBwz2opDC
 cQcfxi8RIafRQ94sD4q8f1Y+7qazPKai8GOlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727758923; x=1728363723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bUif3YGJ3LG6bd9hGX/hM8r4+MkoghWSdAupcdP4w/A=;
 b=QXGKwriHhYPAKMPAUCcEczowgl6EISKeMrrDd7aK0XSmiLaA8syDp6x/JY7dEjmxYx
 q1abrWqnTLayX/sdHMrwLEdjEpiaR8esHXPSVFPR7KCpugEfJ2Mldlue8DgHDY/tr4Vz
 2e8ZujRjy02+HbXyfoxluxYOHF2rNXBWzhfuzYL2JDn0GoYmXaz5fbbit7IGob7i6jQE
 yEmo7PoqDft3bFh/dYujBXlIhzBEdd8wdMFAY66pdFdiSV8nEamBex1+p9Q5niheN3yC
 3xmTkMvvcJlKp6yVw9E81pshL88uVqOjdrJfiyf4LIBRiwfBYlUTQ4yWH9Ce6Bph0Awo
 yhww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoiBkuOuiaolkoM//LOM83EnikslwFCJXjZqfrTnZeSZeKkr5dWb/DF091RV93csLuKoSGp5g=@lists.denx.de
X-Gm-Message-State: AOJu0YxHYy0FZ4KT42MYC8cWevSvyM62nbS13YsO8GK8C1LNfYVg6zFn
 184NTcOeb1WtdIIYRnM2UPQHlNIj6JR3kXjWjuddccYVeI9wYIww2t3i9nzh3Mftqzbt9SqPq0e
 tHWtggJVAj6nqpC2bji2K6IehUIuw+7cabKsETA==
X-Google-Smtp-Source: AGHT+IEZ93g1Jpqx0baF5FAHSIECBP9HRaCGjD3XPhLsCu86FvaARoln9tC0jPrIF4QBxBi61ON3+V098tiGrIpfmWk=
X-Received: by 2002:a05:6402:50d3:b0:5c8:a01e:a06d with SMTP id
 4fb4d7f45d1cf-5c8a01ea1bbmr2156198a12.30.1727758922691; Mon, 30 Sep 2024
 22:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
 <20240913095622.72377-9-dario.binacchi@amarulasolutions.com>
 <beecebba-79f5-e21d-3062-287c2dbb04e9@denx.de>
 <CABGWkvqOzc3cGM_aKVurv1XbAbeHXE77xwq_uAmSuZMgjCoevQ@mail.gmail.com>
 <ebb734bd-bdf7-ffd2-d676-7eb6011466a3@denx.de>
In-Reply-To: <ebb734bd-bdf7-ffd2-d676-7eb6011466a3@denx.de>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 1 Oct 2024 07:01:50 +0200
Message-ID: <CAOf5uwm13jyOb0M9Xvx_bO1RpXhDcWqKBC-4fhZGo61Q5cjnjw@mail.gmail.com>
Subject: Re: [PATCH 08/26] power: Add iMX8M block ctrl driver for dispmix
To: hs@denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Ye Li <ye.li@nxp.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
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

Hi Heko

On Tue, Oct 1, 2024 at 6:23=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:
>
> Hi Dario,
>
> On 30.09.24 15:20, Dario Binacchi wrote:
> > Hello Heiko,
> >
> > On Tue, Sep 24, 2024 at 11:07=E2=80=AFAM Heiko Schocher <hs@denx.de> wr=
ote:
> >>
> >> Hello Dario,
> >>
> >> On 13.09.24 11:55, Dario Binacchi wrote:
> >>> From: Michael Trimarchi <michael@amarulasolutions.com>
> >>>
> >>> Add iMX8 block ctrl driver for displaymix on iMX8MM/iMX8MN and
> >>> mediamix on iMX8MP.
> >>>
> >>> To support blk ctrl driver, the power domain driver on iMX8M needs
> >>> update to add relevant PGC domains
> >>>
> >>> Signed-off-by: Ye Li <ye.li@nxp.com>
> >>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> >>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >>> ---
> >>>
> >>>    drivers/power/domain/Kconfig              |   6 +
> >>>    drivers/power/domain/Makefile             |   1 +
> >>>    drivers/power/domain/imx8m-blk-ctrl.c     | 438 ++++++++++++++++++=
++++
> >>>    drivers/power/domain/imx8m-power-domain.c | 213 ++++++++++-
> >>>    4 files changed, 656 insertions(+), 2 deletions(-)
> >>>    create mode 100644 drivers/power/domain/imx8m-blk-ctrl.c
> >>>
> >>> diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kcon=
fig
> >>> index bd82d2f7044b..fb006b6e8e28 100644
> >>> --- a/drivers/power/domain/Kconfig
> >>> +++ b/drivers/power/domain/Kconfig
> >>> @@ -40,6 +40,12 @@ config IMX8M_POWER_DOMAIN
> >>>          Enable support for manipulating NXP i.MX8M on-SoC power doma=
ins via
> >>>          requests to the ATF.
> >>>
> >>> +config IMX8M_BLK_CTRL
> >>> +     bool "Enable i.MX8M block control driver"
> >>> +     depends on POWER_DOMAIN && ARCH_IMX8M
> >>> +     help
> >>> +       Enable support for manipulating NXP i.MX8M on-SoC block contr=
ol driver
> >>> +
> >>>    config IMX8MP_HSIOMIX_BLKCTRL
> >>>        bool "Enable i.MX8MP HSIOMIX domain driver"
> >>>        depends on POWER_DOMAIN && IMX8MP
> >>> diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Mak=
efile
> >>> index 2daab73eb758..46849fd2a4db 100644
> >>> --- a/drivers/power/domain/Makefile
> >>> +++ b/drivers/power/domain/Makefile
> >>> @@ -8,6 +8,7 @@ obj-$(CONFIG_APPLE_PMGR_POWER_DOMAIN) +=3D apple-pmgr=
.o
> >>>    obj-$(CONFIG_BCM6328_POWER_DOMAIN) +=3D bcm6328-power-domain.o
> >>>    obj-$(CONFIG_IMX8_POWER_DOMAIN) +=3D imx8-power-domain-legacy.o im=
x8-power-domain.o
> >>>    obj-$(CONFIG_IMX8M_POWER_DOMAIN) +=3D imx8m-power-domain.o
> >>> +obj-$(CONFIG_IMX8M_BLK_CTRL) +=3D imx8m-blk-ctrl.o
> >>>    obj-$(CONFIG_IMX8MP_HSIOMIX_BLKCTRL) +=3D imx8mp-hsiomix.o
> >>>    obj-$(CONFIG_MTK_POWER_DOMAIN) +=3D mtk-power-domain.o
> >>>    obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) +=3D meson-gx-pwrc-vpu.o
> >>> diff --git a/drivers/power/domain/imx8m-blk-ctrl.c b/drivers/power/do=
main/imx8m-blk-ctrl.c
> >>> new file mode 100644
> >>> index 000000000000..4c89078b991b
> >>> --- /dev/null
> >>> +++ b/drivers/power/domain/imx8m-blk-ctrl.c
> >>> @@ -0,0 +1,438 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * Copyright 2023 NXP
> >>> + */
> >>> +
> >>> +#include <dm.h>
> >>> +#include <malloc.h>
> >>> +#include <power-domain-uclass.h>
> >>> +#include <asm/io.h>
> >>> +#include <dm/device-internal.h>
> >>> +#include <dm/device.h>
> >>> +#include <dt-bindings/power/imx8mm-power.h>
> >>> +#include <dt-bindings/power/imx8mn-power.h>
> >>> +#include <dt-bindings/power/imx8mp-power.h>
> >>> +#include <clk.h>
> >>> +#include <linux/delay.h>
> >>> +
> >>> +#define BLK_SFT_RSTN 0x0
> >>> +#define BLK_CLK_EN   0x4
> >>> +#define BLK_MIPI_RESET_DIV   0x8 /* Mini/Nano/Plus DISPLAY_BLK_CTRL =
only */
> >>> +
> >>> +#define DOMAIN_MAX_CLKS 4
> >>> +
> >>> +struct imx8m_blk_ctrl_domain {
> >>> +     struct clk clks[DOMAIN_MAX_CLKS];
> >>> +     struct power_domain power_dev;
> >>> +};
> >>> +
> >>> +struct imx8m_blk_ctrl {
> >>> +     void __iomem *base;
> >>> +     struct power_domain bus_power_dev;
> >>> +     struct imx8m_blk_ctrl_domain *domains;
> >>> +};
> >>> +
> >>> +struct imx8m_blk_ctrl_domain_data {
> >>> +     const char *name;
> >>> +     const char * const *clk_names;
> >>> +     const char *gpc_name;
> >>> +     int num_clks;
> >>> +     u32 rst_mask;
> >>> +     u32 clk_mask;
> >>> +     u32 mipi_phy_rst_mask;
> >>> +};
> >>> +
> >>> +struct imx8m_blk_ctrl_data {
> >>> +     int max_reg;
> >>> +     const struct imx8m_blk_ctrl_domain_data *domains;
> >>> +     int num_domains;
> >>> +     u32 bus_rst_mask;
> >>> +     u32 bus_clk_mask;
> >>> +};
> >>> +
> >>> +static int imx8m_blk_ctrl_request(struct power_domain *power_domain)
> >>> +{
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int imx8m_blk_ctrl_free(struct power_domain *power_domain)
> >>> +{
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int imx8m_blk_ctrl_enable_domain_clk(struct udevice *dev, ulo=
ng domain_id, bool enable)
> >>> +{
> >>> +     int ret, i;
> >>> +     struct imx8m_blk_ctrl *priv =3D (struct imx8m_blk_ctrl *)dev_ge=
t_priv(dev);
> >>> +     struct imx8m_blk_ctrl_data *drv_data =3D
> >>> +             (struct imx8m_blk_ctrl_data *)dev_get_driver_data(dev);
> >>> +
> >>> +     debug("%s num_clk %u\n", __func__, drv_data->domains[domain_id]=
.num_clks);
> >>> +
> >>> +     for (i =3D 0; i < drv_data->domains[domain_id].num_clks; i++) {
> >>> +             debug("%s clk %s\n", __func__, drv_data->domains[domain=
_id].clk_names[i]);
> >>> +             if (enable)
> >>> +                     ret =3D clk_enable(&priv->domains[domain_id].cl=
ks[i]);
> >>> +             else
> >>> +                     ret =3D clk_disable(&priv->domains[domain_id].c=
lks[i]);
> >>> +             if (ret && ret !=3D -ENOENT) {
> >>> +                     printf("Failed to %s domain clk %s\n", enable ?=
 "enable" : "disable",
> >>> +                            drv_data->domains[domain_id].clk_names[i=
]);
> >>> +                     return ret;
> >>> +             }
> >>> +     }
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int imx8m_blk_ctrl_power_on(struct power_domain *power_domain=
)
> >>> +{
> >>> +     struct udevice *dev =3D power_domain->dev;
> >>> +     struct imx8m_blk_ctrl *priv =3D (struct imx8m_blk_ctrl *)dev_ge=
t_priv(dev);
> >>> +     struct imx8m_blk_ctrl_data *drv_data =3D
> >>> +             (struct imx8m_blk_ctrl_data *)dev_get_driver_data(dev);
> >>> +     int ret;
> >>> +
> >>> +     debug("%s, id %lu\n", __func__, power_domain->id);
> >>> +
> >>> +     if (!priv->domains[power_domain->id].power_dev.dev)
> >>> +             return -ENODEV;
> >>> +
> >>> +     ret =3D power_domain_on(&priv->bus_power_dev);
> >>> +     if (ret < 0) {
> >>> +             printf("Failed to power up bus domain %d\n", ret);
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     /* Enable bus clock and deassert bus reset */
> >>> +     setbits_le32(priv->base + BLK_CLK_EN, drv_data->bus_clk_mask);
> >>> +     setbits_le32(priv->base + BLK_SFT_RSTN, drv_data->bus_rst_mask)=
;
> >>> +
> >>> +     /* wait for reset to propagate */
> >>> +     udelay(5);
> >>> +
> >>> +     /* put devices into reset */
> >>> +     clrbits_le32(priv->base + BLK_SFT_RSTN, drv_data->domains[power=
_domain->id].rst_mask);
> >>> +     if (drv_data->domains[power_domain->id].mipi_phy_rst_mask)
> >>> +             clrbits_le32(priv->base + BLK_MIPI_RESET_DIV, d
> >>> +                          rv_data->domains[power_domain->id].mipi_ph=
y_rst_mask);
> >>
> >> Does this build for you?
> >>
> >> I needed the following fix:
> >>
> >> diff --git a/drivers/power/domain/imx8m-blk-ctrl.c b/drivers/power/dom=
ain/imx8m-blk-ctrl.c
> >> index 4c89078b99..b772d50480 100644
> >> --- a/drivers/power/domain/imx8m-blk-ctrl.c
> >> +++ b/drivers/power/domain/imx8m-blk-ctrl.c
> >> @@ -114,8 +114,8 @@ static int imx8m_blk_ctrl_power_on(struct power_do=
main *power_domain)
> >>           /* put devices into reset */
> >>           clrbits_le32(priv->base + BLK_SFT_RSTN, drv_data->domains[po=
wer_domain->id].rst_mask);
> >>           if (drv_data->domains[power_domain->id].mipi_phy_rst_mask)
> >> -               clrbits_le32(priv->base + BLK_MIPI_RESET_DIV, d
> >> -                            rv_data->domains[power_domain->id].mipi_p=
hy_rst_mask);
> >> +               clrbits_le32(priv->base + BLK_MIPI_RESET_DIV,
> >> +                            drv_data->domains[power_domain->id].mipi_=
phy_rst_mask);
> >>
> >>           /* enable upstream and blk-ctrl clocks to allow reset to pro=
pagate */
> >>           ret =3D imx8m_blk_ctrl_enable_domain_clk(dev, power_domain->=
id, true);
> >>
> >> to get it building.
> >
> > Yes, you're right. I made some changes suggested by patman, and before
> > applying the
> >   patch, I didn't recompile, so I didn't notice.
> >
> >>
> >> BTW: Just also working on bootlogo support for an imx8mp based board!
> >>
> >> I now applied your patches:
> >>
> >> clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE present for gate =
and mux
> >> clk: clk-uclass: Implement CLK_OPS_PARENT_ENABLE
> >>
> >> And added in my adapted /drivers/clk/imx/clk-imx8mp.c (imported from l=
inux)
> >>
> >> clk_dm(IMX8MP_CLK_MEDIA_AXI, imx8m_clk_composite_flags("media_axi", im=
x8mp_media_axi_sels,
> >> ARRAY_SIZE(imx8mp_media_axi_sels), base + 0x8a00, CLK_IS_CRITICAL));
> >>
> >> instead of using imx8m_clk_composite, and dropped my approach to
> >> get clocks up and working.
> >>
> >> Also dropped my similiar approach for mediablock and used your
> >>
> >> power: Add iMX8M block ctrl driver for dispmix
> >>
> >> And with this 3 patches, bootlogo works also/still fine for me!
> >>
> >> I did not applied/need your patches:
> >>
> >> clk: imx8mn: Prevent clock critical path from disabling during reparen=
t and set_rate
> >> clk: imx8mm: Prevent clock critical path from disabling during reparen=
t and set_rate
> >> clk: imx8mm: Mark IMX8MM_SYS_PLL2 and IMX8MM_SYS_PLL3 as enabled
> >> clk: imx8mn: Mark IMX8MN_SYS_PLL2 and IMX8MN_SYS_PLL3 as enabled
> >>
> >> Of course, they are for imx8mm, but I mean I do not need similiar patc=
hes
> >> for imx8mp!
> >>
> >> Also not applied (as for imx8mm)
> >> clk: imx8mn: add video clocks support
> >>
> >> but as said, have similiar patch for clk-imx8mp.c
> >>
> >> May you check if using imx8m_clk_composite_flags() is working for you?
> >
> > I will do it
> >
> >>
> >> I did not applied your patches 09/26 and the following patches from
> >> your series, as I made a video bridge driver based on
> >>
> >> linux driver drivers/gpu/drm/bridge/fsl-ldb.c
> >>
> >> and a lcdif driver based on linux:/drivers/gpu/drm/mxsfb/lcdif_drv.c
> >>
> >
> > Thank you for you feedback Heiko
>
> You are welcome!
>
> Hmm.. unfortunately ... I had applied your 2 clock patches, which
> fixed a problem with enabling parent clocks ... but they broke booting
> on a carrier which has fec ethernet! After "Net: " output the board hang.=
..
>
> I reverted your 2 clock patches and it bootet again ... so there is
> a problem ... try to get some more time to look into...
>

We have a fec, but we had I think two patches more on it. I forget to
answer Marek
about them because I don't have my board now and because he is
partially right (or maybe right).
Anyway when we boot we could have and we have clocks that are enabled
by bootrom or SPL that
we need to declare as enable like PLL2/PLL3 those clocks are parts or
could be part of reparent so,
you need to have a reference counter on them that allow to not disable
during the down chain disable
and up chain enable. I think that what happens to your ethernet it's
that you disable some clock that is
critical to the board to survive. I had a patch merged by Tom that
prints the clock name so if you enable
the debug of the clock you will find that your board stops working
during one of this reparinting.

Can you check it?

Michael


> Do you have fec ethernet on your board?
>
> Thanks!
>
> bye,
> Heiko
> >
> > Regards,
> > Dario
> >
> >> bye,
> >> Heiko
> >> --
> >> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> >> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> >> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
> >
> >
> >
>
> --
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de



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
