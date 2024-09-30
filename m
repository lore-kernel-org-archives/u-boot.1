Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B28CE8340
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 13:21:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DAD788B27;
	Mon, 30 Sep 2024 15:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PzoJ8AgQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC4A488770; Mon, 30 Sep 2024 15:21:05 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49C0888EC0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 15:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e25d11cc9f0so3341416276.3
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 06:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1727702460; x=1728307260;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjZl8ny4BEF8a9k/k0H5FH8y0ctFVllp3cDM74zintc=;
 b=PzoJ8AgQjQg0YkYDQ0Un5pD4eXBuNKm132XeX01AZahG+G1527TzYIbxc8ilUMqZdh
 EtbkU/QbFyvKE4SyXT35hUx5E8C/jYDudavAkYvihrQ6GHVO44O+sM/A0RdqmImyR15L
 ZZjBXCWlhyUUUWTUJTl4TItShLy8T7t3WqEyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727702460; x=1728307260;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjZl8ny4BEF8a9k/k0H5FH8y0ctFVllp3cDM74zintc=;
 b=tFNdBhhPr05XAAFEx+lxUQ+il1JMu/acmnBaSVz3svJAatLSbyifD1ItBJclPr5paZ
 XCpEHDc/3Z/g91roLDFTH7UBiTmMJEPjQPMtXZB8v5yR91rZvp73NQGd2WbrKMf6KBnS
 JvH+g3SiNSNUHHq9LnV8pjdJKMoHGOSexuHbCeSy3rio+goEc4XPdjBGMEbb5i9IAzPn
 OuWmcGHwid+cr+3lIyqtdPFCUwgWFyja81e4zYRVlTg7oEOthaVzJnG1WjiZ2TdkPJVx
 3O+sN5cLJbi0Bn4my+Wgdg8+LCOqAx2a9a5ePKfv4UQ7lKutJyasj0fUAFK7r/T7nYCu
 +lYg==
X-Gm-Message-State: AOJu0YwnEl6rCjsOenXq8vG9SOIC6u2Wn/2QbpmRPAicfxedkqFqqaP9
 lED4YT7oh0y5ovNzizsiNnbwE7wk8xA8JYCQnRi0VcTYEko4kMR5cqkYJA5l4ia79GCwOUSyD2z
 E+2rX3yLftklxWV3HAq1edzp+uOvyb6Ghn+XGGQ==
X-Google-Smtp-Source: AGHT+IEHoUIfJqIyI58Z3RbVMgvBgYmspmFEL7kIvFucUyJLEj9M0ggo2ODaJNAlUPFKGTjiKfcdsCL5DbwEIvD3qG8=
X-Received: by 2002:a05:6902:2204:b0:e22:5dd9:b130 with SMTP id
 3f1490d57ef6-e2604b30109mr8211444276.11.1727702460028; Mon, 30 Sep 2024
 06:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
 <20240913095622.72377-9-dario.binacchi@amarulasolutions.com>
 <beecebba-79f5-e21d-3062-287c2dbb04e9@denx.de>
In-Reply-To: <beecebba-79f5-e21d-3062-287c2dbb04e9@denx.de>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 30 Sep 2024 15:20:49 +0200
Message-ID: <CABGWkvqOzc3cGM_aKVurv1XbAbeHXE77xwq_uAmSuZMgjCoevQ@mail.gmail.com>
Subject: Re: [PATCH 08/26] power: Add iMX8M block ctrl driver for dispmix
To: hs@denx.de
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>, 
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com, 
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

Hello Heiko,

On Tue, Sep 24, 2024 at 11:07=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:
>
> Hello Dario,
>
> On 13.09.24 11:55, Dario Binacchi wrote:
> > From: Michael Trimarchi <michael@amarulasolutions.com>
> >
> > Add iMX8 block ctrl driver for displaymix on iMX8MM/iMX8MN and
> > mediamix on iMX8MP.
> >
> > To support blk ctrl driver, the power domain driver on iMX8M needs
> > update to add relevant PGC domains
> >
> > Signed-off-by: Ye Li <ye.li@nxp.com>
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >
> >   drivers/power/domain/Kconfig              |   6 +
> >   drivers/power/domain/Makefile             |   1 +
> >   drivers/power/domain/imx8m-blk-ctrl.c     | 438 +++++++++++++++++++++=
+
> >   drivers/power/domain/imx8m-power-domain.c | 213 ++++++++++-
> >   4 files changed, 656 insertions(+), 2 deletions(-)
> >   create mode 100644 drivers/power/domain/imx8m-blk-ctrl.c
> >
> > diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfi=
g
> > index bd82d2f7044b..fb006b6e8e28 100644
> > --- a/drivers/power/domain/Kconfig
> > +++ b/drivers/power/domain/Kconfig
> > @@ -40,6 +40,12 @@ config IMX8M_POWER_DOMAIN
> >         Enable support for manipulating NXP i.MX8M on-SoC power domains=
 via
> >         requests to the ATF.
> >
> > +config IMX8M_BLK_CTRL
> > +     bool "Enable i.MX8M block control driver"
> > +     depends on POWER_DOMAIN && ARCH_IMX8M
> > +     help
> > +       Enable support for manipulating NXP i.MX8M on-SoC block control=
 driver
> > +
> >   config IMX8MP_HSIOMIX_BLKCTRL
> >       bool "Enable i.MX8MP HSIOMIX domain driver"
> >       depends on POWER_DOMAIN && IMX8MP
> > diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makef=
ile
> > index 2daab73eb758..46849fd2a4db 100644
> > --- a/drivers/power/domain/Makefile
> > +++ b/drivers/power/domain/Makefile
> > @@ -8,6 +8,7 @@ obj-$(CONFIG_APPLE_PMGR_POWER_DOMAIN) +=3D apple-pmgr.o
> >   obj-$(CONFIG_BCM6328_POWER_DOMAIN) +=3D bcm6328-power-domain.o
> >   obj-$(CONFIG_IMX8_POWER_DOMAIN) +=3D imx8-power-domain-legacy.o imx8-=
power-domain.o
> >   obj-$(CONFIG_IMX8M_POWER_DOMAIN) +=3D imx8m-power-domain.o
> > +obj-$(CONFIG_IMX8M_BLK_CTRL) +=3D imx8m-blk-ctrl.o
> >   obj-$(CONFIG_IMX8MP_HSIOMIX_BLKCTRL) +=3D imx8mp-hsiomix.o
> >   obj-$(CONFIG_MTK_POWER_DOMAIN) +=3D mtk-power-domain.o
> >   obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) +=3D meson-gx-pwrc-vpu.o
> > diff --git a/drivers/power/domain/imx8m-blk-ctrl.c b/drivers/power/doma=
in/imx8m-blk-ctrl.c
> > new file mode 100644
> > index 000000000000..4c89078b991b
> > --- /dev/null
> > +++ b/drivers/power/domain/imx8m-blk-ctrl.c
> > @@ -0,0 +1,438 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2023 NXP
> > + */
> > +
> > +#include <dm.h>
> > +#include <malloc.h>
> > +#include <power-domain-uclass.h>
> > +#include <asm/io.h>
> > +#include <dm/device-internal.h>
> > +#include <dm/device.h>
> > +#include <dt-bindings/power/imx8mm-power.h>
> > +#include <dt-bindings/power/imx8mn-power.h>
> > +#include <dt-bindings/power/imx8mp-power.h>
> > +#include <clk.h>
> > +#include <linux/delay.h>
> > +
> > +#define BLK_SFT_RSTN 0x0
> > +#define BLK_CLK_EN   0x4
> > +#define BLK_MIPI_RESET_DIV   0x8 /* Mini/Nano/Plus DISPLAY_BLK_CTRL on=
ly */
> > +
> > +#define DOMAIN_MAX_CLKS 4
> > +
> > +struct imx8m_blk_ctrl_domain {
> > +     struct clk clks[DOMAIN_MAX_CLKS];
> > +     struct power_domain power_dev;
> > +};
> > +
> > +struct imx8m_blk_ctrl {
> > +     void __iomem *base;
> > +     struct power_domain bus_power_dev;
> > +     struct imx8m_blk_ctrl_domain *domains;
> > +};
> > +
> > +struct imx8m_blk_ctrl_domain_data {
> > +     const char *name;
> > +     const char * const *clk_names;
> > +     const char *gpc_name;
> > +     int num_clks;
> > +     u32 rst_mask;
> > +     u32 clk_mask;
> > +     u32 mipi_phy_rst_mask;
> > +};
> > +
> > +struct imx8m_blk_ctrl_data {
> > +     int max_reg;
> > +     const struct imx8m_blk_ctrl_domain_data *domains;
> > +     int num_domains;
> > +     u32 bus_rst_mask;
> > +     u32 bus_clk_mask;
> > +};
> > +
> > +static int imx8m_blk_ctrl_request(struct power_domain *power_domain)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int imx8m_blk_ctrl_free(struct power_domain *power_domain)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int imx8m_blk_ctrl_enable_domain_clk(struct udevice *dev, ulong=
 domain_id, bool enable)
> > +{
> > +     int ret, i;
> > +     struct imx8m_blk_ctrl *priv =3D (struct imx8m_blk_ctrl *)dev_get_=
priv(dev);
> > +     struct imx8m_blk_ctrl_data *drv_data =3D
> > +             (struct imx8m_blk_ctrl_data *)dev_get_driver_data(dev);
> > +
> > +     debug("%s num_clk %u\n", __func__, drv_data->domains[domain_id].n=
um_clks);
> > +
> > +     for (i =3D 0; i < drv_data->domains[domain_id].num_clks; i++) {
> > +             debug("%s clk %s\n", __func__, drv_data->domains[domain_i=
d].clk_names[i]);
> > +             if (enable)
> > +                     ret =3D clk_enable(&priv->domains[domain_id].clks=
[i]);
> > +             else
> > +                     ret =3D clk_disable(&priv->domains[domain_id].clk=
s[i]);
> > +             if (ret && ret !=3D -ENOENT) {
> > +                     printf("Failed to %s domain clk %s\n", enable ? "=
enable" : "disable",
> > +                            drv_data->domains[domain_id].clk_names[i])=
;
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int imx8m_blk_ctrl_power_on(struct power_domain *power_domain)
> > +{
> > +     struct udevice *dev =3D power_domain->dev;
> > +     struct imx8m_blk_ctrl *priv =3D (struct imx8m_blk_ctrl *)dev_get_=
priv(dev);
> > +     struct imx8m_blk_ctrl_data *drv_data =3D
> > +             (struct imx8m_blk_ctrl_data *)dev_get_driver_data(dev);
> > +     int ret;
> > +
> > +     debug("%s, id %lu\n", __func__, power_domain->id);
> > +
> > +     if (!priv->domains[power_domain->id].power_dev.dev)
> > +             return -ENODEV;
> > +
> > +     ret =3D power_domain_on(&priv->bus_power_dev);
> > +     if (ret < 0) {
> > +             printf("Failed to power up bus domain %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     /* Enable bus clock and deassert bus reset */
> > +     setbits_le32(priv->base + BLK_CLK_EN, drv_data->bus_clk_mask);
> > +     setbits_le32(priv->base + BLK_SFT_RSTN, drv_data->bus_rst_mask);
> > +
> > +     /* wait for reset to propagate */
> > +     udelay(5);
> > +
> > +     /* put devices into reset */
> > +     clrbits_le32(priv->base + BLK_SFT_RSTN, drv_data->domains[power_d=
omain->id].rst_mask);
> > +     if (drv_data->domains[power_domain->id].mipi_phy_rst_mask)
> > +             clrbits_le32(priv->base + BLK_MIPI_RESET_DIV, d
> > +                          rv_data->domains[power_domain->id].mipi_phy_=
rst_mask);
>
> Does this build for you?
>
> I needed the following fix:
>
> diff --git a/drivers/power/domain/imx8m-blk-ctrl.c b/drivers/power/domain=
/imx8m-blk-ctrl.c
> index 4c89078b99..b772d50480 100644
> --- a/drivers/power/domain/imx8m-blk-ctrl.c
> +++ b/drivers/power/domain/imx8m-blk-ctrl.c
> @@ -114,8 +114,8 @@ static int imx8m_blk_ctrl_power_on(struct power_domai=
n *power_domain)
>          /* put devices into reset */
>          clrbits_le32(priv->base + BLK_SFT_RSTN, drv_data->domains[power_=
domain->id].rst_mask);
>          if (drv_data->domains[power_domain->id].mipi_phy_rst_mask)
> -               clrbits_le32(priv->base + BLK_MIPI_RESET_DIV, d
> -                            rv_data->domains[power_domain->id].mipi_phy_=
rst_mask);
> +               clrbits_le32(priv->base + BLK_MIPI_RESET_DIV,
> +                            drv_data->domains[power_domain->id].mipi_phy=
_rst_mask);
>
>          /* enable upstream and blk-ctrl clocks to allow reset to propaga=
te */
>          ret =3D imx8m_blk_ctrl_enable_domain_clk(dev, power_domain->id, =
true);
>
> to get it building.

Yes, you're right. I made some changes suggested by patman, and before
applying the
 patch, I didn't recompile, so I didn't notice.

>
> BTW: Just also working on bootlogo support for an imx8mp based board!
>
> I now applied your patches:
>
> clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE present for gate and=
 mux
> clk: clk-uclass: Implement CLK_OPS_PARENT_ENABLE
>
> And added in my adapted /drivers/clk/imx/clk-imx8mp.c (imported from linu=
x)
>
> clk_dm(IMX8MP_CLK_MEDIA_AXI, imx8m_clk_composite_flags("media_axi", imx8m=
p_media_axi_sels,
> ARRAY_SIZE(imx8mp_media_axi_sels), base + 0x8a00, CLK_IS_CRITICAL));
>
> instead of using imx8m_clk_composite, and dropped my approach to
> get clocks up and working.
>
> Also dropped my similiar approach for mediablock and used your
>
> power: Add iMX8M block ctrl driver for dispmix
>
> And with this 3 patches, bootlogo works also/still fine for me!
>
> I did not applied/need your patches:
>
> clk: imx8mn: Prevent clock critical path from disabling during reparent a=
nd set_rate
> clk: imx8mm: Prevent clock critical path from disabling during reparent a=
nd set_rate
> clk: imx8mm: Mark IMX8MM_SYS_PLL2 and IMX8MM_SYS_PLL3 as enabled
> clk: imx8mn: Mark IMX8MN_SYS_PLL2 and IMX8MN_SYS_PLL3 as enabled
>
> Of course, they are for imx8mm, but I mean I do not need similiar patches
> for imx8mp!
>
> Also not applied (as for imx8mm)
> clk: imx8mn: add video clocks support
>
> but as said, have similiar patch for clk-imx8mp.c
>
> May you check if using imx8m_clk_composite_flags() is working for you?

I will do it

>
> I did not applied your patches 09/26 and the following patches from
> your series, as I made a video bridge driver based on
>
> linux driver drivers/gpu/drm/bridge/fsl-ldb.c
>
> and a lcdif driver based on linux:/drivers/gpu/drm/mxsfb/lcdif_drv.c
>

Thank you for you feedback Heiko

Regards,
Dario

> bye,
> Heiko
> --
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
