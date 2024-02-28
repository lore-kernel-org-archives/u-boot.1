Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F77C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 07:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26AD487E8F;
	Wed, 28 Feb 2024 08:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A37X2XgI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA40187EEE; Wed, 28 Feb 2024 08:00:20 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0E1F8800D
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 08:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7d2e19120b5so3459377241.2
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 23:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709103611; x=1709708411; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+j6vZ0NUhmQQnerbYH/nV3wgm7PGa+uEHApn5YySZ1E=;
 b=A37X2XgIgLHYXG1ICG9vt1Y4iV0MQHnkOE7fkQEddRxpCetvP+uX7YGZyuV4eBKV13
 hLA8nym4k7tWmwbL9BiEIMEZBYEs39kXwemd0bJx5aMniyNhHMfvIO5pJO/fR/BAG61F
 rCbQYuY2IgGYtPclyP1+WMnF8l0sHC8xFF6k6Fsw6nkSrmF+AKQ7kwGeenA7D3FIkz17
 QEAnIJ3f8LhNvr/cyvY6qsbfnNg5v/LqcM9blICVGuXHYTecqjdId0UlTnnZUPKgOnDq
 nbLJ9m3YBNQ6BV1EopBg+h0fqtTCUqqtwZKdcCtliBwVoVQBb/ci5W7jYR4bJtzmeSqd
 zceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709103611; x=1709708411;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+j6vZ0NUhmQQnerbYH/nV3wgm7PGa+uEHApn5YySZ1E=;
 b=G4PVlJybSa3INRiriVsjKkATejkIrhHi9VzSOOv0u9Ub9dACJl32aHgLPKZNpKSdGW
 Chee+Z4NQy0t6ViIK0cBwwtR5KUpmR576Jr085QBHlpxMl4A5EZzme8hBACDsB6/Vm9p
 D4I7UrNUvvB/mI2Mb+eB+8AP2ghfnEEE0//op7Y5VNEW+s8Q6tGEa4oVK/X3IftX8owg
 oszFaWseBxUrqeKm6pBVbGOL8ap1ngdxNJmp4m703QNFWTnV3xp8hacoC7Y0Hckz0l5R
 kWj7qutySs7vsWUbgzmqBaOKjQFBCzv24WnA5u84m8yvq54I8CThJC9VtGIf6dVsH9Z0
 wjyg==
X-Gm-Message-State: AOJu0YxSeYMzkTwBMgJQPSOAW6CvTE8JNacC35iiDmuma5IYJp1/L6xO
 Tv5iAnn/6qx/V2sdHW4U9Hw0l6uqEjVDHqnHPsO4RvC/mBR/Laua5bbq4e7iPZCtSNebSj/+0R1
 2mTr+oIYd3IjXcsZmHtEeU+DA/dSmOakmekkrRQ==
X-Google-Smtp-Source: AGHT+IHzFGBGMVPty3in3w1QSK6o3ZDxmdk4fiWGXj1ZQAoDWS0GScKR7bUMpxORNYV/MQj+i6xkMde82ILySymC/p4=
X-Received: by 2002:a05:6102:3708:b0:471:cfdb:8462 with SMTP id
 s8-20020a056102370800b00471cfdb8462mr12943634vst.19.1709103610606; Tue, 27
 Feb 2024 23:00:10 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-6-sumit.garg@linaro.org>
 <CAHCN7x+wwoiLO_hpSkiHXFmAUwa0bhbYeQD_UHK10e2YOX+WKA@mail.gmail.com>
In-Reply-To: <CAHCN7x+wwoiLO_hpSkiHXFmAUwa0bhbYeQD_UHK10e2YOX+WKA@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 28 Feb 2024 12:29:59 +0530
Message-ID: <CAFA6WYNJ4BVHOFftSdwdMv2SMJ8ZQh3S7CRjJHfiAnosSbmgGQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P}
 PCIe PHY
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, francesco@dolcini.it, 
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, 
 festevam@denx.de, andrejs.cainikovs@toradex.com, sjg@chromium.org, 
 peng.fan@nxp.com, marex@denx.de, ilias.apalodimas@linaro.org, 
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
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

Hi Adam,

On Wed, 28 Feb 2024 at 04:42, Adam Ford <aford173@gmail.com> wrote:
>
> On Mon, Feb 26, 2024 at 2:05=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > Add initial support for i.MX8M{M/P} PCIe PHY. On i.MX8M{M/P} SoCs PCIe
> > PHY initialization moved to this standalone PHY driver.
> >
> > Inspired from counterpart Linux kernel v6.8-rc3 driver:
> > drivers/phy/freescale/phy-fsl-imx8m-pcie.c.
>
> I have a PCIe device that works just fine in Linux.  I have applied
> your series an enabled the same config options as you did along with
> some others to resolve some build issues.
>
> Any ideas how to address:
>
> nxp_imx8_pcie_phy pcie-phy@32f00000: PHY: Failed to power on
> pcie-phy@32f00000: -110.
>
> My PHY node looks like this
>
> &pcie_phy {
>     fsl,refclk-pad-mode =3D <IMX8_PCIE_REFCLK_PAD_INPUT>;
>     clocks =3D <&pcie0_refclk>;
>     clock-names =3D "ref";
>     status =3D "okay";
> };
>
> The pcie_refcllk is defined as a 100MHz fixed clock in U-Boot.  clk
> dump shows it to be:
>
> 100000000            0        |-- clock-pcie
>

I suppose that's an EVK board, try enabling MPCIE_3V3 regulator
required for EVK board via following patch:

diff --git a/drivers/pci/pcie_dw_imx.c b/drivers/pci/pcie_dw_imx.c
index 7856823c9188..32fd2cb05d4b 100644
--- a/drivers/pci/pcie_dw_imx.c
+++ b/drivers/pci/pcie_dw_imx.c
@@ -17,6 +17,7 @@
 #include <linux/iopoll.h>
 #include <log.h>
 #include <pci.h>
+#include <power/regulator.h>
 #include <regmap.h>
 #include <reset.h>
 #include <syscon.h>
@@ -158,6 +159,8 @@ static int pcie_dw_imx_probe(struct udevice *dev)
        struct pci_controller *hose =3D dev_get_uclass_priv(ctlr);
        int ret;

+       regulator_autoset_by_name("MPCIE_3V3", NULL);
+
        ret =3D imx_pcie_assert_core_reset(priv);
        if (ret) {
                dev_err(dev, "failed to assert core reset\n");

>
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/phy/Kconfig          |   9 ++
> >  drivers/phy/Makefile         |   1 +
> >  drivers/phy/phy-imx8m-pcie.c | 269 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 279 insertions(+)
> >  create mode 100644 drivers/phy/phy-imx8m-pcie.c
> >
> > diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> > index 60138beca498..110ec8f5008d 100644
> > --- a/drivers/phy/Kconfig
> > +++ b/drivers/phy/Kconfig
> > @@ -284,6 +284,15 @@ config PHY_IMX8MQ_USB
> >         help
> >           Support the USB3.0 PHY in NXP i.MX8MQ or i.MX8MP SoC
> >
> > +config PHY_IMX8M_PCIE
> > +       bool "NXP i.MX8MM/i.MX8MP PCIe PHY Driver"
> > +       depends on PHY
> > +       depends on IMX8MM || IMX8MP
>
> This should also depend on SYSCON and REGMAP to prevent build errors.
>

Ack, I will add those.

-Sumit

> > +       help
> > +         Support the PCIe PHY in NXP i.MX8MM or i.MX8MP SoC
> > +
> > +         This PHY is found on i.MX8M devices supporting PCIe.
> > +
> >  config PHY_XILINX_ZYNQMP
> >         tristate "Xilinx ZynqMP PHY driver"
> >         depends on PHY && ARCH_ZYNQMP
> > diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> > index 2e8723186c05..7a2b764492be 100644
> > --- a/drivers/phy/Makefile
> > +++ b/drivers/phy/Makefile
> > @@ -38,6 +38,7 @@ obj-$(CONFIG_PHY_DA8XX_USB) +=3D phy-da8xx-usb.o
> >  obj-$(CONFIG_PHY_MTK_TPHY) +=3D phy-mtk-tphy.o
> >  obj-$(CONFIG_PHY_NPCM_USB) +=3D phy-npcm-usb.o
> >  obj-$(CONFIG_PHY_IMX8MQ_USB) +=3D phy-imx8mq-usb.o
> > +obj-$(CONFIG_PHY_IMX8M_PCIE) +=3D phy-imx8m-pcie.o
> >  obj-$(CONFIG_PHY_XILINX_ZYNQMP) +=3D phy-zynqmp.o
> >  obj-y +=3D cadence/
> >  obj-y +=3D ti/
> > diff --git a/drivers/phy/phy-imx8m-pcie.c b/drivers/phy/phy-imx8m-pcie.=
c
> > new file mode 100644
> > index 000000000000..e09a7ac97235
> > --- /dev/null
> > +++ b/drivers/phy/phy-imx8m-pcie.c
> > @@ -0,0 +1,269 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2024 Linaro Ltd.
> > + *
> > + * Derived from Linux counterpart driver
> > + */
> > +
> > +#include <asm/io.h>
> > +#include <clk.h>
> > +#include <dm.h>
> > +#include <dm/device_compat.h>
> > +#include <generic-phy.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/iopoll.h>
> > +#include <syscon.h>
> > +#include <regmap.h>
> > +#include <reset.h>
> > +
> > +#include <dt-bindings/phy/phy-imx8-pcie.h>
> > +
> > +#define IMX8MM_PCIE_PHY_CMN_REG061     0x184
> > +#define  ANA_PLL_CLK_OUT_TO_EXT_IO_EN  BIT(0)
> > +#define IMX8MM_PCIE_PHY_CMN_REG062     0x188
> > +#define  ANA_PLL_CLK_OUT_TO_EXT_IO_SEL BIT(3)
> > +#define IMX8MM_PCIE_PHY_CMN_REG063     0x18C
> > +#define  AUX_PLL_REFCLK_SEL_SYS_PLL    GENMASK(7, 6)
> > +#define IMX8MM_PCIE_PHY_CMN_REG064     0x190
> > +#define  ANA_AUX_RX_TX_SEL_TX          BIT(7)
> > +#define  ANA_AUX_RX_TERM_GND_EN                BIT(3)
> > +#define  ANA_AUX_TX_TERM               BIT(2)
> > +#define IMX8MM_PCIE_PHY_CMN_REG065     0x194
> > +#define  ANA_AUX_RX_TERM               (BIT(7) | BIT(4))
> > +#define  ANA_AUX_TX_LVL                        GENMASK(3, 0)
> > +#define IMX8MM_PCIE_PHY_CMN_REG075     0x1D4
> > +#define  ANA_PLL_DONE                  0x3
> > +#define PCIE_PHY_TRSV_REG5             0x414
> > +#define PCIE_PHY_TRSV_REG6             0x418
> > +
> > +#define IMX8MM_GPR_PCIE_REF_CLK_SEL    GENMASK(25, 24)
> > +#define IMX8MM_GPR_PCIE_REF_CLK_PLL    FIELD_PREP(IMX8MM_GPR_PCIE_REF_=
CLK_SEL, 0x3)
> > +#define IMX8MM_GPR_PCIE_REF_CLK_EXT    FIELD_PREP(IMX8MM_GPR_PCIE_REF_=
CLK_SEL, 0x2)
> > +#define IMX8MM_GPR_PCIE_AUX_EN         BIT(19)
> > +#define IMX8MM_GPR_PCIE_CMN_RST                BIT(18)
> > +#define IMX8MM_GPR_PCIE_POWER_OFF      BIT(17)
> > +#define IMX8MM_GPR_PCIE_SSC_EN         BIT(16)
> > +#define IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE        BIT(9)
> > +
> > +#define IOMUXC_GPR14_OFFSET            0x38
> > +
> > +enum imx8_pcie_phy_type {
> > +       IMX8MM,
> > +       IMX8MP,
> > +};
> > +
> > +struct imx8_pcie_phy_drvdata {
> > +       const   char                    *gpr;
> > +       enum    imx8_pcie_phy_type      variant;
> > +};
> > +
> > +struct imx8_pcie_phy {
> > +       ulong                   base;
> > +       struct clk              hsio_clk;
> > +       struct regmap           *iomuxc_gpr;
> > +       struct reset_ctl        perst;
> > +       struct reset_ctl        reset;
> > +       u32                     refclk_pad_mode;
> > +       u32                     tx_deemph_gen1;
> > +       u32                     tx_deemph_gen2;
> > +       bool                    clkreq_unused;
> > +       const struct imx8_pcie_phy_drvdata      *drvdata;
> > +};
> > +
> > +static int imx8_pcie_phy_power_on(struct phy *phy)
> > +{
> > +       int ret;
> > +       u32 val, pad_mode;
> > +       struct imx8_pcie_phy *imx8_phy =3D dev_get_priv(phy->dev);
> > +
> > +       pad_mode =3D imx8_phy->refclk_pad_mode;
> > +       switch (imx8_phy->drvdata->variant) {
> > +       case IMX8MM:
> > +               reset_assert(&imx8_phy->reset);
> > +
> > +               /* Tune PHY de-emphasis setting to pass PCIe compliance=
. */
> > +               if (imx8_phy->tx_deemph_gen1)
> > +                       writel(imx8_phy->tx_deemph_gen1,
> > +                              imx8_phy->base + PCIE_PHY_TRSV_REG5);
> > +               if (imx8_phy->tx_deemph_gen2)
> > +                       writel(imx8_phy->tx_deemph_gen2,
> > +                              imx8_phy->base + PCIE_PHY_TRSV_REG6);
> > +               break;
> > +       case IMX8MP: /* Do nothing. */
> > +               break;
> > +       }
> > +
> > +       if (pad_mode =3D=3D IMX8_PCIE_REFCLK_PAD_INPUT ||
> > +           pad_mode =3D=3D IMX8_PCIE_REFCLK_PAD_UNUSED) {
> > +               /* Configure the pad as input */
> > +               val =3D readl(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG0=
61);
> > +               writel(val & ~ANA_PLL_CLK_OUT_TO_EXT_IO_EN,
> > +                      imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG061);
> > +       } else {
> > +               /* Configure the PHY to output the refclock via pad */
> > +               writel(ANA_PLL_CLK_OUT_TO_EXT_IO_EN,
> > +                      imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG061);
> > +       }
> > +
> > +       if (pad_mode =3D=3D IMX8_PCIE_REFCLK_PAD_OUTPUT ||
> > +           pad_mode =3D=3D IMX8_PCIE_REFCLK_PAD_UNUSED) {
> > +               /* Source clock from SoC internal PLL */
> > +               writel(ANA_PLL_CLK_OUT_TO_EXT_IO_SEL,
> > +                      imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG062);
> > +               writel(AUX_PLL_REFCLK_SEL_SYS_PLL,
> > +                      imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG063);
> > +               val =3D ANA_AUX_RX_TX_SEL_TX | ANA_AUX_TX_TERM;
> > +               writel(val | ANA_AUX_RX_TERM_GND_EN,
> > +                      imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG064);
> > +               writel(ANA_AUX_RX_TERM | ANA_AUX_TX_LVL,
> > +                      imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG065);
> > +       }
> > +
> > +       /* Set AUX_EN_OVERRIDE 1'b0, when the CLKREQ# isn't hooked */
> > +       regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
> > +                          IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE,
> > +                          imx8_phy->clkreq_unused ?
> > +                          0 : IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE);
> > +       regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
> > +                          IMX8MM_GPR_PCIE_AUX_EN,
> > +                          IMX8MM_GPR_PCIE_AUX_EN);
> > +       regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
> > +                          IMX8MM_GPR_PCIE_POWER_OFF, 0);
> > +       regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
> > +                          IMX8MM_GPR_PCIE_SSC_EN, 0);
> > +
> > +       regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
> > +                          IMX8MM_GPR_PCIE_REF_CLK_SEL,
> > +                          pad_mode =3D=3D IMX8_PCIE_REFCLK_PAD_INPUT ?
> > +                          IMX8MM_GPR_PCIE_REF_CLK_EXT :
> > +                          IMX8MM_GPR_PCIE_REF_CLK_PLL);
> > +       udelay(200);
> > +
> > +       /* Do the PHY common block reset */
> > +       regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
> > +                          IMX8MM_GPR_PCIE_CMN_RST,
> > +                          IMX8MM_GPR_PCIE_CMN_RST);
> > +
> > +       switch (imx8_phy->drvdata->variant) {
> > +       case IMX8MP:
> > +               reset_deassert(&imx8_phy->perst);
> > +               fallthrough;
> > +       case IMX8MM:
> > +               reset_deassert(&imx8_phy->reset);
> > +               udelay(500);
> > +               break;
> > +       }
> > +
> > +       /* Polling to check the phy is ready or not. */
> > +       ret =3D readl_poll_timeout(imx8_phy->base + IMX8MM_PCIE_PHY_CMN=
_REG075,
> > +                                val, val =3D=3D ANA_PLL_DONE, 20000);
> > +       return ret;
> > +}
> > +
> > +static int imx8_pcie_phy_init(struct phy *phy)
> > +{
> > +       struct imx8_pcie_phy *imx8_phy =3D dev_get_priv(phy->dev);
> > +
> > +       return clk_enable(&imx8_phy->hsio_clk);
> > +}
> > +
> > +static int imx8_pcie_phy_exit(struct phy *phy)
> > +{
> > +       struct imx8_pcie_phy *imx8_phy =3D dev_get_priv(phy->dev);
> > +
> > +       return clk_disable(&imx8_phy->hsio_clk);
> > +}
> > +
> > +static const struct phy_ops imx8_pcie_phy_ops =3D {
> > +       .init           =3D imx8_pcie_phy_init,
> > +       .exit           =3D imx8_pcie_phy_exit,
> > +       .power_on       =3D imx8_pcie_phy_power_on,
> > +};
> > +
> > +static const struct imx8_pcie_phy_drvdata imx8mm_drvdata =3D {
> > +       .gpr =3D "fsl,imx8mm-iomuxc-gpr",
> > +       .variant =3D IMX8MM,
> > +};
> > +
> > +static const struct imx8_pcie_phy_drvdata imx8mp_drvdata =3D {
> > +       .gpr =3D "fsl,imx8mp-iomuxc-gpr",
> > +       .variant =3D IMX8MP,
> > +};
> > +
> > +static const struct udevice_id imx8_pcie_phy_of_match[] =3D {
> > +       {.compatible =3D "fsl,imx8mm-pcie-phy", .data =3D (ulong)&imx8m=
m_drvdata, },
> > +       {.compatible =3D "fsl,imx8mp-pcie-phy", .data =3D (ulong)&imx8m=
p_drvdata, },
> > +       { },
> > +};
> > +
> > +static int imx8_pcie_phy_probe(struct udevice *dev)
> > +{
> > +       struct imx8_pcie_phy *imx8_phy =3D dev_get_priv(dev);
> > +       ofnode gpr;
> > +       int ret =3D 0;
> > +
> > +       imx8_phy->drvdata =3D (void *)dev_get_driver_data(dev);
> > +       imx8_phy->base =3D dev_read_addr(dev);
> > +       if (!imx8_phy->base)
> > +               return -EINVAL;
> > +
> > +       /* get PHY refclk pad mode */
> > +       dev_read_u32(dev, "fsl,refclk-pad-mode", &imx8_phy->refclk_pad_=
mode);
> > +
> > +       if (dev_read_u32(dev, "fsl,tx-deemph-gen1", &imx8_phy->tx_deemp=
h_gen1))
> > +               imx8_phy->tx_deemph_gen1 =3D 0;
> > +
> > +       if (dev_read_u32(dev, "fsl,tx-deemph-gen2", &imx8_phy->tx_deemp=
h_gen2))
> > +               imx8_phy->tx_deemph_gen2 =3D 0;
> > +
> > +       if (dev_read_bool(dev, "fsl,clkreq-unsupported"))
> > +               imx8_phy->clkreq_unused =3D true;
> > +       else
> > +               imx8_phy->clkreq_unused =3D false;
> > +
> > +       /* Grab GPR config register range */
> > +       gpr =3D ofnode_by_compatible(ofnode_null(), imx8_phy->drvdata->=
gpr);
> > +       if (ofnode_equal(gpr, ofnode_null())) {
> > +               dev_err(dev, "unable to find GPR node\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       imx8_phy->iomuxc_gpr =3D syscon_node_to_regmap(gpr);
> > +       if (IS_ERR(imx8_phy->iomuxc_gpr)) {
> > +               dev_err(dev, "unable to find iomuxc registers\n");
> > +               return PTR_ERR(imx8_phy->iomuxc_gpr);
> > +       }
> > +
> > +       ret =3D clk_get_by_name(dev, "ref", &imx8_phy->hsio_clk);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to get PCIEPHY ref clock\n");
> > +               return ret;
> > +       }
> > +
> > +       ret =3D reset_get_by_name(dev, "pciephy", &imx8_phy->reset);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to get PCIEPHY reset control\n");
> > +               return ret;
> > +       }
> > +
> > +       if (imx8_phy->drvdata->variant =3D=3D IMX8MP) {
> > +               ret =3D reset_get_by_name(dev, "perst", &imx8_phy->pers=
t);
> > +               if (ret) {
> > +                       dev_err(dev,
> > +                               "Failed to get PCIEPHY PHY PERST contro=
l\n");
> > +                       return ret;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +U_BOOT_DRIVER(nxp_imx8_pcie_phy) =3D {
> > +       .name =3D "nxp_imx8_pcie_phy",
> > +       .id =3D UCLASS_PHY,
> > +       .of_match =3D imx8_pcie_phy_of_match,
> > +       .probe =3D imx8_pcie_phy_probe,
> > +       .ops =3D &imx8_pcie_phy_ops,
> > +       .priv_auto      =3D sizeof(struct imx8_pcie_phy),
> > +};
> > --
> > 2.34.1
> >
