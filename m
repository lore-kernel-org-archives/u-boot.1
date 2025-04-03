Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1A7C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 13:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5F2782006;
	Thu,  3 Apr 2025 15:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a2YYskNr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF69282045; Thu,  3 Apr 2025 15:01:36 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1566F81F44
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 15:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-af6b02d9e5eso618621a12.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 06:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743685292; x=1744290092; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7lAiyqixcNVkVD4byi7csb+5qPANpk5CCYaFp+cw8ZM=;
 b=a2YYskNrpU+LvgC1oyZFOeGHQRQcm2Jq8oLvi55cX+kz+Z64eaIVoZdPQYA1Ow7guE
 atLeSDJRur5S+KlfluFy53hZcsfbynxbxLwi3RSdkYz6qs/frqxRkDRBgMxOoCIgvi+a
 lknCuNlzQUVO0uUmNcpJ6zpPvaqkcCrUsc0grbm83EchLLVgiGVugoNVAWO6IIPh52il
 324aJI//PkEAyr0GVcLPq1ruZBHBmYWtID7SMd6mA7AnbmmQQsc5i1KKZ7OM9df9e2BS
 vIVigWEJP1RFcpwYz+95RoFsGaGUJB+Sea5ZbtkZywX0RAkT3qOFJ3oBGLjJgqKXvd/V
 NsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743685292; x=1744290092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7lAiyqixcNVkVD4byi7csb+5qPANpk5CCYaFp+cw8ZM=;
 b=Rwxkri+/A4g+FWs1b8yar+7FBYX6+o6nWMeYJHhuGdPiqXF+8lrDDQifIPMyDWpy5n
 Ry77wQWH1JJGA43ojoyFM+NEs8cswbL/8QoG2I7spZUxEv/EXPW5UrXilTkXWgtaap98
 A51X1QT+T2XV3tsvloVIiPM6C0mEHwX34MPBC1cqnMDpv4ciUACWxaWYvkcA3dgoCLuY
 8SIO5Nz41eMAyBkeQ6aSJ64M0LqX8Fdz1n06kls4fI7jRZchOoqqP7UoNz0CJXUJ6i84
 dFXG/s5BY3N8iEmO7WsjnpdoGQopQ3g9f/im79MnJ9GGiiplIicRgxxGfdlbLdoFBWVj
 JzDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1fl+NfMPGG//dyl/27n83KP4fK8/NtgPNfdbCb5oiaXFDyCwkt+VEf68c3JscmtKo12Q+lZI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8LHRvIAea5eIOiSMthxuHNBw4VFUUWDwPQ+KEKvfzeh691Ivb
 s8rEZxUYZWJlEM9CJUB2M8WE7Rqn0vtEcgitmhvkqA4o3xGcZk3nT8y1mtGY5pEsZd+G95b4hAH
 DNEzXSdTFlPd770780rD4+K5k3Ho=
X-Gm-Gg: ASbGncuSLLaf7kPIfMKxe7hs73aU8/l/3mDrEbp1z8umWiASFC44bwZG+SulGA0RvnS
 KWWxRrl6ea5Unc0K9AooAvWFz+NmFvnhDD46/U81OwI2UESd98IJGPxq25SbPHj5GJNefP+7qjJ
 mvMaM69dmNoGqA2NjxpOr8gmI/Zw==
X-Google-Smtp-Source: AGHT+IG66qiHACR83ZSmi95IqABkczQilKDeMg5Q2Hj6Z61dMGv0PUOLko4CrHSaXa2TttZySvqkjssWz5nIt+2bTZ8=
X-Received: by 2002:a17:90a:d64d:b0:301:a0e9:66f with SMTP id
 98e67ed59e1d1-3057cbfae85mr3755431a91.14.1743685292284; Thu, 03 Apr 2025
 06:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-12-478b5e3dd872@bootlin.com>
In-Reply-To: <20250403-ge-mainline-display-support-v6-12-478b5e3dd872@bootlin.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 3 Apr 2025 08:01:19 -0500
X-Gm-Features: AQ5f1JqfmK11nSuNUzCIsLSdSkExYc04b2IXk3VSanbMyACaI3kTvfnklJmGOL0
Message-ID: <CAHCN7x+NnM3TPS84uWRQavs15D8vta4nU+EppbAtvgi=inr7Fw@mail.gmail.com>
Subject: Re: [PATCH v6 12/12] video: imx: Add LCDIF driver
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
> Add support for the LCD interfaces (LCDIF1/2). When probed, these
> interfaces request numerous clocks and power domains, attach the bridge
> and look for a panel in order to retrieve its capabilities and
> properties.
>
> There is a similar existing driver in the upper folder for other i.MX
> targets, I discovered this driver a bit late. It is not targeting the
> i.MX8MP and I have no idea how different can the LCDIF be on this SoC,
> but I did not manage to get it work, especially because it is not fully
> compliant with the device-model, especially on the clocks/power
> management side which is all ad-hoc. This is normal though, it was
> contributed more than ten years ago.

I think there was some discussion in the LKML about how similar /
different he LCD interfaces are between the 8MP and other NXP/i.MX
boards.

since there are three instances of this LCDIF, when most other boards
have just one, do you know what happens if someone's device tree has
all three enabled? Is the video mirrored, or does it just go to one of
the instances?

adam
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/video/imx/Kconfig  |   3 +
>  drivers/video/imx/Makefile |   1 +
>  drivers/video/imx/lcdif.c  | 314 +++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 318 insertions(+)
>
> diff --git a/drivers/video/imx/Kconfig b/drivers/video/imx/Kconfig
> index c5cd2fecf780b62c0264b9627137517388aae1ab..12f11c2eea8c98cc341448923=
c80919afbceed46 100644
> --- a/drivers/video/imx/Kconfig
> +++ b/drivers/video/imx/Kconfig
> @@ -19,3 +19,6 @@ config IMX_LDB
>         depends on VIDEO_BRIDGE
>         help
>           Support for i.MX8MP DPI-to-LVDS on-SoC encoder.
> +
> +config IMX_LCDIF
> +       bool "i.MX LCDIFv3 LCD controller"
> diff --git a/drivers/video/imx/Makefile b/drivers/video/imx/Makefile
> index 8d106589b7544ef9694613a2284e2fbfb564cf63..1edf5a6bdf0c3afb218fbcd81=
384c7c277ca6b28 100644
> --- a/drivers/video/imx/Makefile
> +++ b/drivers/video/imx/Makefile
> @@ -5,3 +5,4 @@
>
>  obj-$(CONFIG_VIDEO_IPUV3) +=3D mxc_ipuv3_fb.o ipu_common.o ipu_disp.o
>  obj-$(CONFIG_IMX_LDB) +=3D ldb.o
> +obj-$(CONFIG_IMX_LCDIF) +=3D lcdif.o
> diff --git a/drivers/video/imx/lcdif.c b/drivers/video/imx/lcdif.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..9f4fc7f51524449ecf8e15555=
0e0fb3b641870d9
> --- /dev/null
> +++ b/drivers/video/imx/lcdif.c
> @@ -0,0 +1,314 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * i.MX8 LCD interface driver inspired from the Linux driver
> + * Copyright 2019 NXP
> + * Copyright 2024 Bootlin
> + * Adapted by Miquel Raynal <miquel.raynal@bootlin.com>
> + */
> +
> +#include <asm/io.h>
> +#include <asm/mach-imx/dma.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <panel.h>
> +#include <power-domain.h>
> +#include <video.h>
> +#include <video_bridge.h>
> +#include <linux/delay.h>
> +
> +#include "../videomodes.h"
> +
> +#define LCDIFV3_CTRL 0x0
> +#define LCDIFV3_CTRL_SET 0x4
> +#define LCDIFV3_CTRL_CLR 0x8
> +#define   CTRL_INV_HS BIT(0)
> +#define   CTRL_INV_VS BIT(1)
> +#define   CTRL_INV_DE BIT(2)
> +#define   CTRL_INV_PXCK BIT(3)
> +#define   CTRL_CLK_GATE BIT(30)
> +#define   CTRL_SW_RESET BIT(31)
> +
> +#define LCDIFV3_DISP_PARA 0x10
> +#define   DISP_PARA_DISP_MODE_NORMAL 0
> +#define   DISP_PARA_LINE_PATTERN_RGB_YUV 0
> +#define   DISP_PARA_DISP_ON BIT(31)
> +
> +#define LCDIFV3_DISP_SIZE 0x14
> +#define   DISP_SIZE_DELTA_X(x) ((x) & 0xffff)
> +#define   DISP_SIZE_DELTA_Y(x) ((x) << 16)
> +
> +#define LCDIFV3_HSYN_PARA 0x18
> +#define   HSYN_PARA_FP_H(x) ((x) & 0xffff)
> +#define   HSYN_PARA_BP_H(x) ((x) << 16)
> +
> +#define LCDIFV3_VSYN_PARA 0x1C
> +#define   VSYN_PARA_FP_V(x) ((x) & 0xffff)
> +#define   VSYN_PARA_BP_V(x) ((x) << 16)
> +
> +#define LCDIFV3_VSYN_HSYN_WIDTH 0x20
> +#define   VSYN_HSYN_PW_H(x) ((x) & 0xffff)
> +#define   VSYN_HSYN_PW_V(x) ((x) << 16)
> +
> +#define LCDIFV3_CTRLDESCL0_1 0x200
> +#define   CTRLDESCL0_1_WIDTH(x) ((x) & 0xffff)
> +#define   CTRLDESCL0_1_HEIGHT(x) ((x) << 16)
> +
> +#define LCDIFV3_CTRLDESCL0_3 0x208
> +#define   CTRLDESCL0_3_PITCH(x) ((x) & 0xFFFF)
> +
> +#define LCDIFV3_CTRLDESCL_LOW0_4 0x20C
> +#define LCDIFV3_CTRLDESCL_HIGH0_4 0x210
> +
> +#define LCDIFV3_CTRLDESCL0_5 0x214
> +#define   CTRLDESCL0_5_YUV_FORMAT(x) (((x) & 0x3) << 14)
> +#define   CTRLDESCL0_5_BPP(x) (((x) & 0xf) << 24)
> +#define     BPP32_ARGB8888 0x9
> +#define   CTRLDESCL0_5_SHADOW_LOAD_EN BIT(30)
> +#define   CTRLDESCL0_5_EN BIT(31)
> +
> +struct lcdifv3_priv {
> +       void __iomem *base;
> +       struct clk pix_clk;
> +       struct power_domain pd;
> +       struct udevice *panel;
> +       struct udevice *bridge;
> +};
> +
> +static void lcdifv3_set_mode(struct lcdifv3_priv *priv,
> +                            struct display_timing *timings)
> +{
> +       u32 reg;
> +
> +       writel(DISP_SIZE_DELTA_X(timings->hactive.typ) |
> +              DISP_SIZE_DELTA_Y(timings->vactive.typ),
> +              priv->base + LCDIFV3_DISP_SIZE);
> +
> +       writel(HSYN_PARA_FP_H(timings->hfront_porch.typ) |
> +              HSYN_PARA_BP_H(timings->hback_porch.typ),
> +              priv->base + LCDIFV3_HSYN_PARA);
> +
> +       writel(VSYN_PARA_BP_V(timings->vback_porch.typ) |
> +              VSYN_PARA_FP_V(timings->vfront_porch.typ),
> +              priv->base + LCDIFV3_VSYN_PARA);
> +
> +       writel(VSYN_HSYN_PW_H(timings->hsync_len.typ) |
> +              VSYN_HSYN_PW_V(timings->vsync_len.typ),
> +              priv->base + LCDIFV3_VSYN_HSYN_WIDTH);
> +
> +       writel(CTRLDESCL0_1_WIDTH(timings->hactive.typ) |
> +              CTRLDESCL0_1_HEIGHT(timings->vactive.typ),
> +              priv->base + LCDIFV3_CTRLDESCL0_1);
> +
> +       if (timings->flags & DISPLAY_FLAGS_HSYNC_LOW)
> +               writel(CTRL_INV_HS, priv->base + LCDIFV3_CTRL_SET);
> +       else
> +               writel(CTRL_INV_HS, priv->base + LCDIFV3_CTRL_CLR);
> +
> +       if (timings->flags & DISPLAY_FLAGS_VSYNC_LOW)
> +               writel(CTRL_INV_VS, priv->base + LCDIFV3_CTRL_SET);
> +       else
> +               writel(CTRL_INV_VS, priv->base + LCDIFV3_CTRL_CLR);
> +
> +       if (timings->flags & DISPLAY_FLAGS_DE_LOW)
> +               writel(CTRL_INV_DE, priv->base + LCDIFV3_CTRL_SET);
> +       else
> +               writel(CTRL_INV_DE, priv->base + LCDIFV3_CTRL_CLR);
> +
> +       if (timings->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
> +               writel(CTRL_INV_PXCK, priv->base + LCDIFV3_CTRL_SET);
> +       else
> +               writel(CTRL_INV_PXCK, priv->base + LCDIFV3_CTRL_CLR);
> +
> +       writel(0, priv->base + LCDIFV3_DISP_PARA);
> +
> +       reg =3D readl(priv->base + LCDIFV3_CTRLDESCL0_5);
> +       reg &=3D ~(CTRLDESCL0_5_BPP(0xf) | CTRLDESCL0_5_YUV_FORMAT(0x3));
> +       reg |=3D CTRLDESCL0_5_BPP(BPP32_ARGB8888);
> +       writel(reg, priv->base + LCDIFV3_CTRLDESCL0_5);
> +}
> +
> +static void lcdifv3_enable_controller(struct lcdifv3_priv *priv)
> +{
> +       u32 reg;
> +
> +       reg =3D readl(priv->base + LCDIFV3_DISP_PARA);
> +       reg |=3D DISP_PARA_DISP_ON;
> +       writel(reg, priv->base + LCDIFV3_DISP_PARA);
> +
> +       reg =3D readl(priv->base + LCDIFV3_CTRLDESCL0_5);
> +       reg |=3D CTRLDESCL0_5_EN;
> +       writel(reg, priv->base + LCDIFV3_CTRLDESCL0_5);
> +}
> +
> +static int lcdifv3_video_sync(struct udevice *dev)
> +{
> +       struct lcdifv3_priv *priv =3D dev_get_priv(dev);
> +       u32 reg;
> +
> +       reg =3D readl(priv->base + LCDIFV3_CTRLDESCL0_5);
> +       reg |=3D CTRLDESCL0_5_SHADOW_LOAD_EN;
> +       writel(reg, priv->base + LCDIFV3_CTRLDESCL0_5);
> +
> +       return 0;
> +}
> +
> +static void lcdifv3_init(struct udevice *dev, struct display_timing *tim=
ings)
> +{
> +       struct video_uc_plat *plat =3D dev_get_uclass_plat(dev);
> +       struct lcdifv3_priv *priv =3D dev_get_priv(dev);
> +
> +       clk_set_rate(&priv->pix_clk, timings->pixelclock.typ);
> +
> +       writel(CTRL_SW_RESET | CTRL_CLK_GATE, priv->base + LCDIFV3_CTRL_C=
LR);
> +       udelay(10);
> +
> +       lcdifv3_set_mode(priv, timings);
> +
> +       writel(plat->base & 0xFFFFFFFF, priv->base + LCDIFV3_CTRLDESCL_LO=
W0_4);
> +       writel(plat->base >> 32, priv->base + LCDIFV3_CTRLDESCL_HIGH0_4);
> +
> +       writel(CTRLDESCL0_3_PITCH(timings->hactive.typ * 4), /* 32bpp */
> +              priv->base + LCDIFV3_CTRLDESCL0_3);
> +
> +       lcdifv3_enable_controller(priv);
> +}
> +
> +static int lcdifv3_video_probe(struct udevice *dev)
> +{
> +       struct video_uc_plat *plat =3D dev_get_uclass_plat(dev);
> +       struct video_priv *uc_priv =3D dev_get_uclass_priv(dev);
> +       struct lcdifv3_priv *priv =3D dev_get_priv(dev);
> +       struct clk axi_clk, disp_axi_clk;
> +       struct display_timing timings;
> +       u32 fb_start, fb_end;
> +       int ret;
> +
> +       ret =3D power_domain_get(dev, &priv->pd);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D clk_get_by_name(dev, "pix", &priv->pix_clk);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D clk_get_by_name(dev, "axi", &axi_clk);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D clk_get_by_name(dev, "disp_axi", &disp_axi_clk);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D power_domain_on(&priv->pd);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D clk_enable(&priv->pix_clk);
> +       if (ret)
> +               goto dis_pd;
> +
> +       ret =3D clk_enable(&axi_clk);
> +       if (ret)
> +               goto dis_pix_clk;
> +
> +       ret =3D clk_enable(&disp_axi_clk);
> +       if (ret)
> +               goto dis_axi_clk;
> +
> +       priv->base =3D dev_remap_addr(dev);
> +       if (!priv->base) {
> +               ret =3D -EINVAL;
> +               goto dis_clks;
> +       }
> +
> +       /* Attach bridge */
> +       ret =3D uclass_get_device_by_endpoint(UCLASS_VIDEO_BRIDGE, dev,
> +                                           -1, -1, &priv->bridge);
> +       if (ret)
> +               goto dis_clks;
> +
> +       ret =3D video_bridge_attach(priv->bridge);
> +       if (ret)
> +               goto dis_clks;
> +
> +       ret =3D video_bridge_set_backlight(priv->bridge, 80);
> +       if (ret)
> +               goto dis_clks;
> +
> +       /* Attach panels */
> +       ret =3D uclass_get_device_by_endpoint(UCLASS_PANEL, priv->bridge,
> +                                           1, -1, &priv->panel);
> +       if (ret) {
> +               ret =3D uclass_get_device_by_endpoint(UCLASS_PANEL, priv-=
>bridge,
> +                                                   2, -1, &priv->panel);
> +               if (ret)
> +                       goto dis_clks;
> +       }
> +
> +       ret =3D panel_get_display_timing(priv->panel, &timings);
> +       if (ret) {
> +               ret =3D ofnode_decode_display_timing(dev_ofnode(priv->pan=
el),
> +                                                  0, &timings);
> +               if (ret) {
> +                       printf("Cannot decode panel timings (%d)\n", ret)=
;
> +                       goto dis_clks;
> +               }
> +       }
> +
> +       lcdifv3_init(dev, &timings);
> +
> +       /* Only support 32bpp for now */
> +       uc_priv->bpix =3D VIDEO_BPP32;
> +       uc_priv->xsize =3D timings.hactive.typ;
> +       uc_priv->ysize =3D timings.vactive.typ;
> +
> +       /* Enable dcache for the frame buffer */
> +       fb_start =3D plat->base & ~(MMU_SECTION_SIZE - 1);
> +       fb_end =3D ALIGN(plat->base + plat->size, 1 << MMU_SECTION_SHIFT)=
;
> +       mmu_set_region_dcache_behaviour(fb_start, fb_end - fb_start,
> +                                       DCACHE_WRITEBACK);
> +       video_set_flush_dcache(dev, true);
> +
> +       return 0;
> +
> +dis_clks:
> +       clk_disable(&disp_axi_clk);
> +dis_axi_clk:
> +       clk_disable(&axi_clk);
> +dis_pix_clk:
> +       clk_disable(&priv->pix_clk);
> +dis_pd:
> +       power_domain_off(&priv->pd);
> +
> +       return ret;
> +}
> +
> +static int lcdifv3_video_bind(struct udevice *dev)
> +{
> +       struct video_uc_plat *plat =3D dev_get_uclass_plat(dev);
> +
> +       /* Max size supported by LCDIF */
> +       plat->size =3D 1920 * 1080 * VNBYTES(VIDEO_BPP32);
> +
> +       return 0;
> +}
> +
> +static const struct udevice_id lcdifv3_video_ids[] =3D {
> +       { .compatible =3D "fsl,imx8mp-lcdif" },
> +       { }
> +};
> +
> +static struct video_ops lcdifv3_video_ops =3D {
> +       .video_sync =3D lcdifv3_video_sync,
> +};
> +
> +U_BOOT_DRIVER(lcdifv3_video) =3D {
> +       .name =3D "lcdif",
> +       .id =3D UCLASS_VIDEO,
> +       .of_match =3D lcdifv3_video_ids,
> +       .bind =3D lcdifv3_video_bind,
> +       .ops =3D &lcdifv3_video_ops,
> +       .probe =3D lcdifv3_video_probe,
> +       .priv_auto =3D sizeof(struct lcdifv3_priv),
> +       .flags =3D DM_FLAG_PRE_RELOC | DM_FLAG_OS_PREPARE,
> +};
>
> --
> 2.48.1
>
