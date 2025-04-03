Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A2DC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 12:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 352F6820FE;
	Thu,  3 Apr 2025 14:58:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k9b4RA67";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C057582105; Thu,  3 Apr 2025 14:58:10 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3D0281F44
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 14:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-af9925bbeb7so665895a12.3
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743685085; x=1744289885; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFWmlhgDd3beWOGhfwS7pqeDr+MPpgd2WpfjiC1BGg4=;
 b=k9b4RA67iFpjVKMv6DCJc+CjO9mgqwFX3JyzI+/gYjum+rYEBUyh4donMnjTAjBTxi
 kf3NqSb7JLm5JXZfc6U8UxbtXYa4PFhZcMIOsJlkKXOSBdgW/65ud6vUs8eNv104WAXW
 TCt/3OSaeBd/fQ9nBtiS+nUm2KVi58zB2vS94I4OsKbGsL+9gAw1826DucGY42FGqIgK
 sBGMT8ipmAOZQ8o77NcP/UBYUJ3ACu1rrFCcfMMq9GFuAZFB61RKC2yj7kI74UfPq1kR
 fCyCsWxY7s4OyuzabEp9M9yknO8Vr5uMCa8qWm4v+/rxxL5kzhdxRS1eHymjXQPXcSNH
 S78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743685085; x=1744289885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WFWmlhgDd3beWOGhfwS7pqeDr+MPpgd2WpfjiC1BGg4=;
 b=r8PYQv+kr05wvFRLSlklQ9WNbNiGHpUZ2ZJDrFXy2sN0GBqgLlzCJfD9XoHWMVQlPv
 ao7HwCvLjOksUUzJpCA2iyb0m3ekSb299313SzFCfUK+hdwZH9Q7Q7+pd0AvMyG/okby
 6JashGrcEoNz899HqmNScBDRkVbO4iu4JfY5AiaJhGatY3Vz4ilj035uU6MZVUhzMHtX
 5lUBInxWCpec0RAduFbpfiW/nYwy+TQEd8h7tsGARGxA18ri20q9YplCq7bfA/8/FdXH
 tXX24H24+0rEy3snyad+NrGHWZ7V7FEeI1RsHSETjDv6gLSfTQvEyDAdFrY9nStXK9px
 r0lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1USFOa29k2Ame9ihjty6h9rczWwrpkVlSronwkwzVJVY5w8huLnDAMuRdk+72veIM6v2bywI=@lists.denx.de
X-Gm-Message-State: AOJu0YxCQ08C0ZUoFCWPLmfWu9mDj7wtwT42QAa0+10DBNJ/VuTnAAf3
 qHyy3W+pcS6KHb0X6q6Ht3mepwV+VE2gSaaOdtjTL40pj6bC4F0EjjUEfmmrdQsV6TA8W1BtrMm
 W8GzW+O4+WCbXf3AsrEEXsvLwjijCRlDW
X-Gm-Gg: ASbGncsf6ng+EecaX4L91yOoem+MJK0sIj4ma8XN90nBURRieRXHCwlDSpBRWqP5E/X
 xHd9Ac0WVZpY42tvDTl0NxlDwj/WmWMsCteeO4mg1meSdWo2kQyMKdHbP54nfVDwLllugD7Ob+Q
 sKVfVSQcXgny0vh7ROBe1XRDj8P7/1sQy9yd+8
X-Google-Smtp-Source: AGHT+IHdjd7mJjZIteHWkYeJ5UnqOOudCM4hChIXg6vbTfsVhYZahbdvrvmSbPjRLfX1oOx3HbtsNHb+w0bramfZBVg=
X-Received: by 2002:a17:90b:2d4b:b0:2ee:9b09:7d3d with SMTP id
 98e67ed59e1d1-3057cc171a1mr3613772a91.19.1743685085249; Thu, 03 Apr 2025
 05:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-9-478b5e3dd872@bootlin.com>
In-Reply-To: <20250403-ge-mainline-display-support-v6-9-478b5e3dd872@bootlin.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 3 Apr 2025 07:57:53 -0500
X-Gm-Features: AQ5f1JrYRA85Tui5IXKDvjZWbb_J4HOS1N5b3jO4STXer-nToYJnYeqQDL3KSKM
Message-ID: <CAHCN7xKD8AODyDNSz21aO5kDJD1FygKUcsfXsCXV+K59VdgWDw@mail.gmail.com>
Subject: Re: [PATCH v6 09/12] imx: power-domain: Add support for the MEDIAMIX
 control block
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Fabio Estevm <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Mario Six <mario.six@gdsys.cc>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>
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

On Thu, Apr 3, 2025 at 2:39=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> This block delivers power and clocks to the whole display and rendering
> pipeline.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/power/domain/Kconfig           |   7 ++
>  drivers/power/domain/Makefile          |   1 +
>  drivers/power/domain/imx8mp-mediamix.c | 208 +++++++++++++++++++++++++++=
++++++
>  3 files changed, 216 insertions(+)
>
> diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
> index bd82d2f7044b3c3f8c88dea27c39193efedb4c84..5f5218bd8b5f4bed8283e91da=
61ac7c8c3eb97ae 100644
> --- a/drivers/power/domain/Kconfig
> +++ b/drivers/power/domain/Kconfig
> @@ -47,6 +47,13 @@ config IMX8MP_HSIOMIX_BLKCTRL
>         help
>           Enable support for manipulating NXP i.MX8MP on-SoC HSIOMIX bloc=
k controller.
>
> +config IMX8MP_MEDIAMIX_BLKCTRL
> +       bool "Enable i.MX8MP MEDIAMIX domain driver"
> +       depends on POWER_DOMAIN && IMX8MP
> +       select CLK
> +       help
> +         Enable support for manipulating NXP i.MX8MP on-SoC MEDIAMIX blo=
ck controller.
> +
>  config MTK_POWER_DOMAIN
>         bool "Enable the MediaTek power domain driver"
>         depends on POWER_DOMAIN && ARCH_MEDIATEK
> diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefil=
e
> index 110646c503ab97941a2bb86caf53f94542008219..356ec07163fd299f00e81a629=
ffc06c663a26c25 100644
> --- a/drivers/power/domain/Makefile
> +++ b/drivers/power/domain/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_BCM6328_POWER_DOMAIN) +=3D bcm6328-power-dom=
ain.o
>  obj-$(CONFIG_IMX8_POWER_DOMAIN) +=3D imx8-power-domain-legacy.o imx8-pow=
er-domain.o
>  obj-$(CONFIG_IMX8M_POWER_DOMAIN) +=3D imx8m-power-domain.o
>  obj-$(CONFIG_IMX8MP_HSIOMIX_BLKCTRL) +=3D imx8mp-hsiomix.o
> +obj-$(CONFIG_IMX8MP_MEDIAMIX_BLKCTRL) +=3D imx8mp-mediamix.o
>  obj-$(CONFIG_MTK_POWER_DOMAIN) +=3D mtk-power-domain.o
>  obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) +=3D meson-gx-pwrc-vpu.o
>  obj-$(CONFIG_MESON_EE_POWER_DOMAIN) +=3D meson-ee-pwrc.o
> diff --git a/drivers/power/domain/imx8mp-mediamix.c b/drivers/power/domai=
n/imx8mp-mediamix.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..78c32ca3d3a87febdefd5d128=
d39d817674b8d32
> --- /dev/null
> +++ b/drivers/power/domain/imx8mp-mediamix.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * i.MX8 MEDIAMIX control block driver
> + * Copyright (C) 2024 Miquel Raynal <miquel.raynal@bootlin.com>
> + * Inspired from Marek Vasut <marex@denx.de> work on the hsiomix driver.
> + */
> +
> +#include <asm/io.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <power-domain-uclass.h>
> +#include <linux/delay.h>
> +
> +#include <dt-bindings/power/imx8mp-power.h>
> +
> +#define BLK_SFT_RSTN           0x0
> +#define BLK_CLK_EN             0x4
> +
> +struct imx8mp_mediamix_priv {
> +       void __iomem *base;
> +       struct clk clk_apb;
> +       struct clk clk_axi;
> +       struct clk clk_disp2;
> +       struct power_domain pd_bus;
> +       struct power_domain pd_lcdif2;
> +};
> +
> +static int imx8mp_mediamix_on(struct power_domain *power_domain)
> +{
> +       struct udevice *dev =3D power_domain->dev;
> +       struct imx8mp_mediamix_priv *priv =3D dev_get_priv(dev);
> +       struct power_domain *domain;
> +       struct clk *clk;
> +       u32 reset;
> +       int ret;
> +
> +       switch (power_domain->id) {
> +       case IMX8MP_MEDIABLK_PD_LCDIF_2:
> +               domain =3D &priv->pd_lcdif2;
> +               clk =3D &priv->clk_disp2;
> +               reset =3D BIT(11) | BIT(12) | BIT(24);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       /* Make sure bus domain is awake */
> +       ret =3D power_domain_on(&priv->pd_bus);
> +       if (ret)
> +               return ret;
> +
> +       /* Put devices into reset */
> +       clrbits_le32(priv->base + BLK_SFT_RSTN, reset);
> +
> +       /* Enable upstream clocks */
> +       ret =3D clk_enable(&priv->clk_apb);
> +       if (ret)
> +               goto dis_bus_pd;
> +
> +       ret =3D clk_enable(&priv->clk_axi);
> +       if (ret)
> +               goto dis_apb_clk;
> +
> +       /* Enable blk-ctrl clock to allow reset to propagate */
> +       ret =3D clk_enable(clk);

I am only offering a suggestion if you ever need to push another rev.
It appears that all the clocks are either on or off and if any fail,
you immediately turn off any clocks that were enabled.  There are some
bulk clock options where you can basically tell the driver to turn
them all on or all off.

clk_get_bulk, clk_enable_bulk, clk_disable_bulk, and clk_release_all
are the functions I am thinking of.  Your imx8mp_mediamix_priv
structure could then replace all the individual clocks with struct
clk_bulk.

That might shrink the overall code and simplify the readability.


> +       if (ret)
> +               goto dis_axi_clk;
> +       setbits_le32(priv->base + BLK_CLK_EN, reset);
> +
> +       /* Power up upstream GPC domain */
> +       ret =3D power_domain_on(domain);
> +       if (ret)
> +               goto dis_lcdif_clk;
> +
> +       /* Wait for reset to propagate */
> +       udelay(5);

On Linux, the GPCv2 driver was updated to increase a delay from 5 to
10 uSeconds [1] .  I don't know if that's needed here, but it's
something to consider.

adam

[1] - https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it/commit/drivers/pmdomain/imx?h=3Dnext-20250403&id=3D2379fb937de5333991c56=
7eefd7d11b98977d059
> +
> +       /* Release reset */
> +       setbits_le32(priv->base + BLK_SFT_RSTN, reset);
> +
> +       return 0;
> +
> +dis_lcdif_clk:
> +       clk_disable(clk);
> +dis_axi_clk:
> +       clk_disable(&priv->clk_axi);
> +dis_apb_clk:
> +       clk_disable(&priv->clk_apb);
> +dis_bus_pd:
> +       power_domain_off(&priv->pd_bus);
> +
> +       return ret;
> +}
> +
> +static int imx8mp_mediamix_off(struct power_domain *power_domain)
> +{
> +       struct udevice *dev =3D power_domain->dev;
> +       struct imx8mp_mediamix_priv *priv =3D dev_get_priv(dev);
> +       struct power_domain *domain;
> +       struct clk *clk;
> +       u32 reset;
> +
> +       switch (power_domain->id) {
> +       case IMX8MP_MEDIABLK_PD_LCDIF_2:
> +               domain =3D &priv->pd_lcdif2;
> +               clk =3D &priv->clk_disp2;
> +               reset =3D BIT(11) | BIT(12) | BIT(24);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       /* Put devices into reset and disable clocks */
> +       clrbits_le32(priv->base + BLK_SFT_RSTN, reset);
> +       clrbits_le32(priv->base + BLK_CLK_EN, reset);
> +
> +       /* Power down upstream GPC domain */
> +       power_domain_off(domain);
> +
> +       clk_disable(clk);
> +       clk_disable(&priv->clk_axi);
> +       clk_disable(&priv->clk_apb);
> +
> +       /* Allow bus domain to suspend */
> +       power_domain_off(&priv->pd_bus);
> +
> +       return 0;
> +}
> +
> +static int imx8mp_mediamix_of_xlate(struct power_domain *power_domain,
> +                                   struct ofnode_phandle_args *args)
> +{
> +       power_domain->id =3D args->args[0];
> +
> +       return 0;
> +}
> +
> +static int imx8mp_mediamix_bind(struct udevice *dev)
> +{
> +       /* Bind child lcdif */
> +       return dm_scan_fdt_dev(dev);
> +}
> +
> +static int imx8mp_mediamix_probe(struct udevice *dev)
> +{
> +       struct imx8mp_mediamix_priv *priv =3D dev_get_priv(dev);
> +       int ret;
> +
> +       priv->base =3D dev_read_addr_ptr(dev);
> +
> +       ret =3D clk_get_by_name(dev, "apb", &priv->clk_apb);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D clk_get_by_name(dev, "axi", &priv->clk_axi);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D clk_get_by_name(dev, "disp2", &priv->clk_disp2);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D power_domain_get_by_name(dev, &priv->pd_bus, "bus");
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D power_domain_get_by_name(dev, &priv->pd_lcdif2, "lcdif2")=
;
> +       if (ret < 0)
> +               goto free_bus_pd;
> +
> +       return 0;
> +
> +free_bus_pd:
> +       power_domain_free(&priv->pd_bus);
> +       return ret;
> +}
> +
> +static int imx8mp_mediamix_remove(struct udevice *dev)
> +{
> +       struct imx8mp_mediamix_priv *priv =3D dev_get_priv(dev);
> +
> +       power_domain_free(&priv->pd_lcdif2);
> +       power_domain_free(&priv->pd_bus);
> +
> +       return 0;
> +}
> +
> +static const struct udevice_id imx8mp_mediamix_ids[] =3D {
> +       { .compatible =3D "fsl,imx8mp-media-blk-ctrl" },
> +       { }
> +};
> +
> +struct power_domain_ops imx8mp_mediamix_ops =3D {
> +       .on =3D imx8mp_mediamix_on,
> +       .off =3D imx8mp_mediamix_off,
> +       .of_xlate =3D imx8mp_mediamix_of_xlate,
> +};
> +
> +U_BOOT_DRIVER(imx8mp_mediamix) =3D {
> +       .name           =3D "imx8mp_mediamix",
> +       .id             =3D UCLASS_POWER_DOMAIN,
> +       .of_match       =3D imx8mp_mediamix_ids,
> +       .bind           =3D imx8mp_mediamix_bind,
> +       .probe          =3D imx8mp_mediamix_probe,
> +       .remove         =3D imx8mp_mediamix_remove,
> +       .priv_auto      =3D sizeof(struct imx8mp_mediamix_priv),
> +       .ops            =3D &imx8mp_mediamix_ops,
> +};
>
> --
> 2.48.1
>
