Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09F7C43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 21:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15BCD83FEE;
	Sun, 28 Jun 2026 23:28:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SJedu5BM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF5E083FEE; Sun, 28 Jun 2026 23:28:04 +0200 (CEST)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3279805D7
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 23:28:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-9673385b1efso560568241.2
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 14:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782682080; cv=none;
 d=google.com; s=arc-20260327;
 b=nZAW3M4x5tsU4edLq5OUCiUDGMGmGIhQGJzkN/HEsWZyojckNQ2BScU62Zt1F0TM7o
 DgQygcRX/jVaPRexDHDlMMlHgU9PTdXuggYaZZ8LnGcxkvWayaORt6bsqyOTVRudHyRl
 j4qI6Ot68vyJMQS9kbiFoT4U/VzPsfZ8Bd4YejJdu9n/1oBHW+2TSLpBkbbWu4LKNH6e
 Ok5UCh9ULqajSIfG/WBTd/dNc7i5gZNpWS9ArNDII43hnPRWV397IQuBoqmjxf1XTewu
 fxFQj8rOGEGtV074o65SIl9BB//f5PZ/g5unRDu5EDFD4pcUNKCbZLQx73RLeSteTNXW
 BkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UbFzYXOshkKLFq6NS13VitzhIpM2q+ab/aATh6wFmGA=;
 fh=mitsjEvAS6uXdP5x07B2auKjsv6XcCDgoM9D4Qz19XY=;
 b=fNUWgNTl0KKoGyc+LB2GQesbmzARSr4RA/eNQesbJvQuljA/UkqTCV5GlXzGHae70O
 Z/WKB+ANi8Z4cY9m2O12WmXEcpoNEN70BjS53My+1t1p/z7t4H7PWPcHfJlFflFR3qMo
 i7x2hglDA8LwtBrT5hvN/5bnaGMQ91cF50mSBKNZpQwd4iDmDRA/C3JxUrqutc5Gnudx
 cZI9jbhSAHg5AORtzoHdIRPkwuxLiK1AI8Wu6YUHuC+0dVFl0c+BtzZ7mu70TKrUicEG
 9jixAk/n9MWPkQNIUiO9tH403vTkVSUpLOi5r/wyJWjtAZDvlW5d8PjZbINF2jG9Ym37
 bkjg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782682080; x=1783286880; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UbFzYXOshkKLFq6NS13VitzhIpM2q+ab/aATh6wFmGA=;
 b=SJedu5BM3im+Y7waaoBfZPgdzDycaqrfsF16QNO1u+HtY1Tl2q4nfwoqD/jeBw2MlR
 eaJoSH/NKsseWmrbDb5SregY9lcQ301oZKZWSk9wCiLKBqTFgpvLlEydcjg/u77Q5orJ
 0ZF+opL4Ce9uFxxQvLcQw3bhq6LcWPqqpj85k7HXbf2U7HWU4cOhRSlkTYRwU6IITR01
 4witSoKqw+/CIGH4+v/8lRBtH9LH9bL3l7AhPo9kyet39oMDTNVXwt7Q7XqwV0cBV+Fn
 bCMgbmcdn3zrlx7L+3Uu3UdzOluU2A8I82DpMqGhE5BVIjJx+bzZEJsJ26JsFqgd0JKF
 7vBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782682080; x=1783286880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UbFzYXOshkKLFq6NS13VitzhIpM2q+ab/aATh6wFmGA=;
 b=mR2RhySyZyiImE2Pc1up1rISFaNBf/cUTMBpOyxXkdg+iYWj9aB7MVjyf7GTEYYLQD
 Z+IpAbGrI5YNx9YVy+3kKd7btyALJi44Xzm+DFWEgT/qOJIIM+4z2lKX9soblg6d9eVh
 S2Nf25Wc4Y5Ib9mJcJnXWrf26gWefS2YLxQJpSD3UVOrqvNMJ0h1j8n0e/CfjBHak9tl
 HoiVZn/Yome3vil+2aFuWVGChbULK4lW3gBS6Xw9OdRPxfdMsK0oLdvo5PX3IebcL/38
 5R1s4aafyNRQAct8gNZON5JtwHai3O7Nb1gKlsNzgQ/uGCMyIxIqfnN9+mZAC1gA01XU
 ECdw==
X-Gm-Message-State: AOJu0Yzlx1wSnjbna/VYwMGODDu6FftJ9Uiya7Ru48MCAs1SB1+HqLmN
 n8kVsLyryCUSgDIoeE84jXonD3Lo9u/pAF3Ames3eJLrZUuladW7PM1WVSTKvERFVihNXiFLVij
 4tRCXR876RFFQZneyZnOFc3HUoiXVYRQ=
X-Gm-Gg: AfdE7ckh+FWHd9W399qNtSEupZHQ65P409TbZPP7JgPhN2TdhZ5Z8K02Jl+S9qFd50P
 pOqHquOHWVWoC63G/SR6t0FkgYoSDCikLKXSwgye5F+HDd0tx7mqr5zlHSbGVUG1Z3EQZEF/YaC
 hg9qugPVNBG1Owjwtk1eq2VmCPL5xPNYC08bUSkirIPLk9OiAV66uGdbLRThhWbPQGN+U4VanNX
 zEQAgnr5Tmtdf3n6Xo90TfunPKW+QEcaxQ+wPanCE41fq2Ih6GP7QWQRJaDmKGlbgmbAXcyCWN+
 XyCx8h+wMHqbEy+0dwrYQkITMsoaRv55BavhVMsCGSZRffs6alg/d9TwswLI31ow2VRY8Td3SIf
 DH8UFtV8TDJD9lw==
X-Received: by 2002:a05:6122:5309:b0:5bd:86ac:a847 with SMTP id
 71dfb90a1353d-5bd86aca88dmr2393149e0c.6.1782682079444; Sun, 28 Jun 2026
 14:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260626205153.2744981-1-james.hilliard1@gmail.com>
 <20260628171716.4a9d7793@ryzen.lan>
In-Reply-To: <20260628171716.4a9d7793@ryzen.lan>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 28 Jun 2026 15:27:48 -0600
X-Gm-Features: AVVi8CeRgHodkbFfyd8ZjyCBiYbPR1mEyyInU74knofbbo9fWjERZrArxUwzPOY
Message-ID: <CADvTj4opB+XMbupiBZtmZnuvDUtyDFkjWR5E1u2QMTXzjMqzrA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi: support DM MMC in SPL
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Hans de Goede <hdegoede@redhat.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Bohdan Chubuk <chbgdn@gmail.com>
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

On Sun, Jun 28, 2026 at 10:16=E2=80=AFAM Andre Przywara <andre.przywara@arm=
.com> wrote:
>
> On Fri, 26 Jun 2026 14:51:50 -0600
> James Hilliard <james.hilliard1@gmail.com> wrote:
>
> Hi James,
>
> > sunxi SPL normally uses the legacy MMC interface while U-Boot
> > proper uses the DM driver. Boards which enable SPL_DM_MMC need
>
> I think I mentioned this before: enabling the device model in the SPL
> (or not) is not a *device* decision, but a platform one.

I'm a bit confused here, uboot's configuration system from what I can tell
is designed to allow enabling device model for specific devices and even
for specific drivers.

Why would this need to be a platform level decision? Given that boards
that don't have enough SRAM for SPL DM support tend to be older, we
will presumably want to migrate newer boards to SPL DM at some point
in the future anyways.

> And for
> technical reasons, mostly to support older devices, which have no other
> choice, but also to keep it simple and the SPL small, we do not use DM
> in the SPL on Allwinner boards.

I mean, this seems to me to be justification for continuing to support
legacy drivers, not justification for not supporting DM as well since there
are also many sunxi boards that don't have that limitation.

> I see the SPL as the continuation of the
> BootROM, which is completely board agnostic.

At a minimum SPL is still fairly SoC specific. Although in practice it seem=
s
to not be all that board agnostic, I think if anything DM support makes it
more agnostic by allowing better factoring of the device specific stuff.

> The SPL can mimic this
> behaviour, to follow the decisions that the BootROM made, for instance
> about the boot device. The only difference here is the DRAM
> initialisation, which requires some board specific data, but so far we
> got away with just hardcoding it.

This is one of a few reasons I wanted to get SPL DM functional on sunxi.

> If that is not good anymore, I think
> we can find other solutions than pulling in the whole world of SPL_DM
> support.
>
> So what is the purpose of this exercise, why do you want DM_SPL
> supported?

Some cryptoengine uboot drivers I was working on adding seemed to
need DM_SPL, also I think handling DRAM profiles becomes easier with
it somewhat.

> Keep in mind that there are 178 Allwinner boards supported in
> U-Boot, so there better would be good reasons to change something
> fundamental like this for all of them. It changing it for a number of
> them is not better, because this doubles the test matrix, so we have to
> test now that it works on both legacy and DM_SPL boards - which frankly
> nobody will do.

Well it doesn't actually double the test matrix since presumably boards
that are not SPL DM compatible will continue to use non-DM drivers only.

Wouldn't we typically just pick either DM or non-DM configs for upstream
uboot testing/configs for any particular board to avoid maintaining more
configurations than necessary in the test matrix?

> And aside from that, please do NOT add any more #ifdef's to the U-Boot
> code.

This seemed to be how other subsystems handled both DM and non-DM
driver support, is there a better way?

> Also just posting single patches that do not do anything on their
> own is not a good idea.

I'm not sure what you mean here, the change here is fixing SPL DM
support in the driver, it's already possible to select SPL DM MMC
support in kconfig for the sunxi MMC driver.

> Cheers,
> Andre
>
> > the DM driver to perform the same early pinmux, resource and clock
> > setup as the legacy path.
> >
> > For SPL without OF_CONTROL, create controllers from static platform
> > data matching the controllers selected by the legacy SPL board code.
> > Reuse the legacy host capability, resource and clock setup helpers for
> > that no-devicetree probe path.
> >
> > For SPL with OF_CONTROL but without SPL_CLK or SPL_PINCTRL, keep
> > using the devicetree for the controller address and clock register
> > layout, then fall back to the legacy CCU base, clock init and pinmux
> > setup. This allows SPL to use DM_MMC without pulling the full clock
> > and pinctrl drivers into SRAM-constrained builds.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  arch/arm/include/asm/arch-sunxi/mmc.h |   1 +
> >  board/sunxi/board.c                   |   6 +-
> >  drivers/mmc/sunxi_mmc.c               | 252 +++++++++++++++++---------
> >  3 files changed, 175 insertions(+), 84 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/arch-sunxi/mmc.h b/arch/arm/include/a=
sm/arch-sunxi/mmc.h
> > index b8d91b5c64b..e6c19bf08fb 100644
> > --- a/arch/arm/include/asm/arch-sunxi/mmc.h
> > +++ b/arch/arm/include/asm/arch-sunxi/mmc.h
> > @@ -3,6 +3,7 @@
> >  #ifndef _ASM_ARCH_MMC_H_
> >  #define _ASM_ARCH_MMC_H_
> >
> > +void sunxi_mmc_pinmux_setup(int sdc_no);
> >  struct mmc *sunxi_mmc_init(int sdc_no);
> >
> >  #endif /* _ASM_ARCH_MMC_H_ */
> > diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> > index 3d1afec7c66..4311f38737c 100644
> > --- a/board/sunxi/board.c
> > +++ b/board/sunxi/board.c
> > @@ -334,7 +334,7 @@ void board_nand_init(void)
> >  #endif /* CONFIG_NAND_SUNXI */
> >
> >  #ifdef CONFIG_MMC
> > -static void mmc_pinmux_setup(int sdc)
> > +void sunxi_mmc_pinmux_setup(int sdc)
> >  {
> >       unsigned int pin;
> >
> > @@ -515,13 +515,13 @@ int board_mmc_init(struct bd_info *bis)
> >        * any problem with unconditionally enabling this in the SPL.
> >        */
> >       if (!IS_ENABLED(CONFIG_UART0_PORT_F)) {
> > -             mmc_pinmux_setup(0);
> > +             sunxi_mmc_pinmux_setup(0);
> >               if (!sunxi_mmc_init(0))
> >                       return -1;
> >       }
> >
> >       if (CONFIG_MMC_SUNXI_SLOT_EXTRA !=3D -1) {
> > -             mmc_pinmux_setup(CONFIG_MMC_SUNXI_SLOT_EXTRA);
> > +             sunxi_mmc_pinmux_setup(CONFIG_MMC_SUNXI_SLOT_EXTRA);
> >               if (!sunxi_mmc_init(CONFIG_MMC_SUNXI_SLOT_EXTRA))
> >                       return -1;
> >       }
> > diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
> > index e28c81afffe..7816dac3423 100644
> > --- a/drivers/mmc/sunxi_mmc.c
> > +++ b/drivers/mmc/sunxi_mmc.c
> > @@ -6,11 +6,11 @@
> >   *
> >   * MMC driver for allwinner sunxi platform.
> >   *
> > - * This driver is used by the (ARM) SPL with the legacy MMC interface,=
 and
> > - * by U-Boot proper using the full DM interface. The actual hardware a=
ccess
> > - * code is common, and comes first in this file.
> > - * The legacy MMC interface implementation comes next, followed by the
> > - * proper DM_MMC implementation at the end.
> > + * This driver is used by the (ARM) SPL with the legacy MMC interface =
or the
> > + * full DM interface, and by U-Boot proper using the full DM interface=
. The
> > + * actual hardware access code is common, and comes first in this file=
.
> > + * The legacy MMC interface implementation comes next, followed by the=
 DM_MMC
> > + * implementation at the end.
> >   */
> >
> >  #include <dm.h>
> > @@ -24,9 +24,7 @@
> >  #include <asm/io.h>
> >  #include <asm/arch/clock.h>
> >  #include <asm/arch/cpu.h>
> > -#if !CONFIG_IS_ENABLED(DM_MMC)
> >  #include <asm/arch/mmc.h>
> > -#endif
> >  #include <linux/delay.h>
> >  #include <sunxi_gpio.h>
> >
> > @@ -36,7 +34,12 @@
> >  #define CCM_MMC_CTRL_MODE_SEL_NEW    0
> >  #endif
> >
> > +#define SUNXI_MMC_NAME                       "SUNXI SD/MMC"
> > +
> >  struct sunxi_mmc_plat {
> > +#if !CONFIG_IS_ENABLED(OF_REAL)
> > +     unsigned int mmc_no;
> > +#endif
> >       struct mmc_config cfg;
> >       struct mmc mmc;
> >  };
> > @@ -64,6 +67,83 @@ static bool sunxi_mmc_can_calibrate(void)
> >              IS_ENABLED(CONFIG_MACH_SUN8I_R40);
> >  }
> >
> > +#if !CONFIG_IS_ENABLED(DM_MMC) || !CONFIG_IS_ENABLED(OF_REAL)
> > +static uint sunxi_mmc_get_host_caps(unsigned int mmc_no)
> > +{
> > +     uint host_caps =3D MMC_MODE_4BIT;
> > +
> > +     if ((IS_ENABLED(CONFIG_MACH_SUN50I) || IS_ENABLED(CONFIG_MACH_SUN=
8I) ||
> > +          IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
> > +          IS_ENABLED(CONFIG_MACH_SUN55I_A523)) && mmc_no =3D=3D 2)
> > +             host_caps =3D MMC_MODE_8BIT;
> > +
> > +     return host_caps | MMC_MODE_HS_52MHz | MMC_MODE_HS;
> > +}
> > +
> > +static int mmc_resource_init(struct sunxi_mmc_priv *priv, int sdc_no)
> > +{
> > +     void *ccm =3D (void *)SUNXI_CCM_BASE;
> > +
> > +     debug("init mmc %d resource\n", sdc_no);
> > +
> > +     switch (sdc_no) {
> > +     case 0:
> > +             priv->reg =3D (struct sunxi_mmc *)SUNXI_MMC0_BASE;
> > +             priv->mclkreg =3D ccm + CCU_MMC0_CLK_CFG;
> > +             break;
> > +     case 1:
> > +             priv->reg =3D (struct sunxi_mmc *)SUNXI_MMC1_BASE;
> > +             priv->mclkreg =3D ccm + CCU_MMC1_CLK_CFG;
> > +             break;
> > +#ifdef SUNXI_MMC2_BASE
> > +     case 2:
> > +             priv->reg =3D (struct sunxi_mmc *)SUNXI_MMC2_BASE;
> > +             priv->mclkreg =3D ccm + CCU_MMC2_CLK_CFG;
> > +             break;
> > +#endif
> > +#ifdef SUNXI_MMC3_BASE
> > +     case 3:
> > +             priv->reg =3D (struct sunxi_mmc *)SUNXI_MMC3_BASE;
> > +             priv->mclkreg =3D ccm + CCU_MMC3_CLK_CFG;
> > +             break;
> > +#endif
> > +     default:
> > +             printf("Wrong mmc number %d\n", sdc_no);
> > +             return -1;
> > +     }
> > +     priv->mmc_no =3D sdc_no;
> > +
> > +     return 0;
> > +}
> > +#endif
> > +
> > +#if !CONFIG_IS_ENABLED(DM_MMC) || !CONFIG_IS_ENABLED(OF_REAL) || \
> > +     !CONFIG_IS_ENABLED(CLK)
> > +static void sunxi_mmc_clock_init(int sdc_no)
> > +{
> > +     void *ccm =3D (void *)SUNXI_CCM_BASE;
> > +
> > +     debug("init mmc %d clock and io\n", sdc_no);
> > +#if !defined(CONFIG_SUN50I_GEN_H6) && !defined(CONFIG_SUNXI_GEN_NCAT2)
> > +     setbits_le32(ccm + CCU_AHB_GATE0, 1 << AHB_GATE_OFFSET_MMC(sdc_no=
));
> > +
> > +#ifdef CONFIG_SUNXI_GEN_SUN6I
> > +     /* unassert reset */
> > +     setbits_le32(ccm + CCU_AHB_RESET0_CFG, 1 << AHB_RESET_OFFSET_MMC(=
sdc_no));
> > +#endif
> > +#if defined(CONFIG_MACH_SUN9I)
> > +     /* sun9i has a mmc-common module, also set the gate and reset the=
re */
> > +     writel(SUNXI_MMC_COMMON_CLK_GATE | SUNXI_MMC_COMMON_RESET,
> > +            SUNXI_MMC_COMMON_BASE + 4 * sdc_no);
> > +#endif
> > +#else /* CONFIG_SUN50I_GEN_H6 */
> > +     setbits_le32(ccm + CCU_H6_MMC_GATE_RESET, 1 << sdc_no);
> > +     /* unassert reset */
> > +     setbits_le32(ccm + CCU_H6_MMC_GATE_RESET, 1 << (RESET_SHIFT + sdc=
_no));
> > +#endif
> > +}
> > +#endif
> > +
> >  static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int h=
z)
> >  {
> >       unsigned int pll, pll_hz, div, n, oclk_dly, sclk_dly;
> > @@ -492,43 +572,6 @@ static void sunxi_mmc_reset(void *regs)
> >  /* support 4 mmc hosts */
> >  struct sunxi_mmc_priv mmc_host[4];
> >
> > -static int mmc_resource_init(int sdc_no)
> > -{
> > -     struct sunxi_mmc_priv *priv =3D &mmc_host[sdc_no];
> > -     void *ccm =3D (void *)SUNXI_CCM_BASE;
> > -
> > -     debug("init mmc %d resource\n", sdc_no);
> > -
> > -     switch (sdc_no) {
> > -     case 0:
> > -             priv->reg =3D (struct sunxi_mmc *)SUNXI_MMC0_BASE;
> > -             priv->mclkreg =3D ccm + CCU_MMC0_CLK_CFG;
> > -             break;
> > -     case 1:
> > -             priv->reg =3D (struct sunxi_mmc *)SUNXI_MMC1_BASE;
> > -             priv->mclkreg =3D ccm + CCU_MMC1_CLK_CFG;
> > -             break;
> > -#ifdef SUNXI_MMC2_BASE
> > -     case 2:
> > -             priv->reg =3D (struct sunxi_mmc *)SUNXI_MMC2_BASE;
> > -             priv->mclkreg =3D ccm + CCU_MMC2_CLK_CFG;
> > -             break;
> > -#endif
> > -#ifdef SUNXI_MMC3_BASE
> > -     case 3:
> > -             priv->reg =3D (struct sunxi_mmc *)SUNXI_MMC3_BASE;
> > -             priv->mclkreg =3D ccm + CCU_MMC3_CLK_CFG;
> > -             break;
> > -#endif
> > -     default:
> > -             printf("Wrong mmc number %d\n", sdc_no);
> > -             return -1;
> > -     }
> > -     priv->mmc_no =3D sdc_no;
> > -
> > -     return 0;
> > -}
> > -
> >  static int sunxi_mmc_core_init(struct mmc *mmc)
> >  {
> >       struct sunxi_mmc_priv *priv =3D mmc->priv;
> > @@ -562,52 +605,27 @@ static const struct mmc_ops sunxi_mmc_ops =3D {
> >
> >  struct mmc *sunxi_mmc_init(int sdc_no)
> >  {
> > -     void *ccm =3D (void *)SUNXI_CCM_BASE;
> >       struct sunxi_mmc_priv *priv =3D &mmc_host[sdc_no];
> >       struct mmc_config *cfg =3D &priv->cfg;
> >       int ret;
> >
> >       memset(priv, '\0', sizeof(struct sunxi_mmc_priv));
> >
> > -     cfg->name =3D "SUNXI SD/MMC";
> > +     cfg->name =3D SUNXI_MMC_NAME;
> >       cfg->ops  =3D &sunxi_mmc_ops;
> >
> >       cfg->voltages =3D MMC_VDD_32_33 | MMC_VDD_33_34;
> > -     cfg->host_caps =3D MMC_MODE_4BIT;
> > -
> > -     if ((IS_ENABLED(CONFIG_MACH_SUN50I) || IS_ENABLED(CONFIG_MACH_SUN=
8I) ||
> > -         IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_MACH_SU=
N55I_A523)) &&
> > -         (sdc_no =3D=3D 2))
> > -             cfg->host_caps =3D MMC_MODE_8BIT;
> > -
> > -     cfg->host_caps |=3D MMC_MODE_HS_52MHz | MMC_MODE_HS;
> > +     cfg->host_caps =3D sunxi_mmc_get_host_caps(sdc_no);
> >       cfg->b_max =3D CONFIG_SYS_MMC_MAX_BLK_COUNT;
> >
> >       cfg->f_min =3D 400000;
> >       cfg->f_max =3D 52000000;
> >
> > -     if (mmc_resource_init(sdc_no) !=3D 0)
> > +     if (mmc_resource_init(priv, sdc_no) !=3D 0)
> >               return NULL;
> >
> >       /* config ahb clock */
> > -     debug("init mmc %d clock and io\n", sdc_no);
> > -#if !defined(CONFIG_SUN50I_GEN_H6) && !defined(CONFIG_SUNXI_GEN_NCAT2)
> > -     setbits_le32(ccm + CCU_AHB_GATE0, 1 << AHB_GATE_OFFSET_MMC(sdc_no=
));
> > -
> > -#ifdef CONFIG_SUNXI_GEN_SUN6I
> > -     /* unassert reset */
> > -     setbits_le32(ccm + CCU_AHB_RESET0_CFG, 1 << AHB_RESET_OFFSET_MMC(=
sdc_no));
> > -#endif
> > -#if defined(CONFIG_MACH_SUN9I)
> > -     /* sun9i has a mmc-common module, also set the gate and reset the=
re */
> > -     writel(SUNXI_MMC_COMMON_CLK_GATE | SUNXI_MMC_COMMON_RESET,
> > -            SUNXI_MMC_COMMON_BASE + 4 * sdc_no);
> > -#endif
> > -#else /* CONFIG_SUN50I_GEN_H6 */
> > -     setbits_le32(ccm + CCU_H6_MMC_GATE_RESET, 1 << sdc_no);
> > -     /* unassert reset */
> > -     setbits_le32(ccm + CCU_H6_MMC_GATE_RESET, 1 << (RESET_SHIFT + sdc=
_no));
> > -#endif
> > +     sunxi_mmc_clock_init(sdc_no);
> >       ret =3D mmc_set_mod_clk(priv, 24000000);
> >       if (ret)
> >               return NULL;
> > @@ -644,7 +662,7 @@ static int sunxi_mmc_getcd(struct udevice *dev)
> >           (mmc->cfg->host_caps & MMC_CAP_NEEDS_POLL))
> >               return 1;
> >
> > -     if (dm_gpio_is_valid(&priv->cd_gpio)) {
> > +     if (CONFIG_IS_ENABLED(DM_GPIO) && dm_gpio_is_valid(&priv->cd_gpio=
)) {
> >               int cd_state =3D dm_gpio_get_value(&priv->cd_gpio);
> >
> >               if (mmc->cfg->host_caps & MMC_CAP_CD_ACTIVE_HIGH)
> > @@ -652,6 +670,7 @@ static int sunxi_mmc_getcd(struct udevice *dev)
> >               else
> >                       return cd_state;
> >       }
> > +
> >       return 1;
> >  }
> >
> > @@ -661,6 +680,7 @@ static const struct dm_mmc_ops sunxi_mmc_ops =3D {
> >       .get_cd         =3D sunxi_mmc_getcd,
> >  };
> >
> > +#if CONFIG_IS_ENABLED(OF_REAL)
> >  static unsigned get_mclk_offset(void)
> >  {
> >       if (IS_ENABLED(CONFIG_MACH_SUN9I_A80))
> > @@ -671,20 +691,26 @@ static unsigned get_mclk_offset(void)
> >
> >       return 0x88;
> >  };
> > +#endif
> >
> >  static int sunxi_mmc_probe(struct udevice *dev)
> >  {
> >       struct mmc_uclass_priv *upriv =3D dev_get_uclass_priv(dev);
> >       struct sunxi_mmc_plat *plat =3D dev_get_plat(dev);
> >       struct sunxi_mmc_priv *priv =3D dev_get_priv(dev);
> > +#if CONFIG_IS_ENABLED(OF_REAL)
> >       struct reset_ctl_bulk reset_bulk;
> > +#if CONFIG_IS_ENABLED(CLK)
> >       struct clk gate_clk;
> > -     struct mmc_config *cfg =3D &plat->cfg;
> > +#endif
> >       struct ofnode_phandle_args args;
> >       u32 *ccu_reg;
> > +#endif
> > +     struct mmc_config *cfg =3D &plat->cfg;
> >       int ret;
> >
> > -     cfg->name =3D dev->name;
> > +     if (!cfg->name)
> > +             cfg->name =3D dev->name;
> >
> >       cfg->voltages =3D MMC_VDD_32_33 | MMC_VDD_33_34;
> >       cfg->host_caps =3D MMC_MODE_HS_52MHz | MMC_MODE_HS;
> > @@ -693,37 +719,58 @@ static int sunxi_mmc_probe(struct udevice *dev)
> >       cfg->f_min =3D 400000;
> >       cfg->f_max =3D 52000000;
> >
> > +#if CONFIG_IS_ENABLED(OF_REAL)
> >       ret =3D mmc_of_parse(dev, cfg);
> >       if (ret)
> >               return ret;
> >
> >       priv->reg =3D dev_read_addr_ptr(dev);
> > +     priv->mmc_no =3D ((uintptr_t)priv->reg - SUNXI_MMC0_BASE) / 0x100=
0;
> > +
> > +#if !CONFIG_IS_ENABLED(PINCTRL)
> > +     sunxi_mmc_pinmux_setup(priv->mmc_no);
> > +#endif
> >
> >       /* We don't have a sunxi clock driver so find the clock address h=
ere */
> >       ret =3D dev_read_phandle_with_args(dev, "clocks", "#clock-cells",=
 0,
> >                                         1, &args);
> > -     if (ret)
> > +     if (!ret)
> > +             ccu_reg =3D (u32 *)(uintptr_t)ofnode_get_addr(args.node);
> > +     else if (!CONFIG_IS_ENABLED(CLK))
> > +             ccu_reg =3D (u32 *)SUNXI_CCM_BASE;
> > +     else
> >               return ret;
> > -     ccu_reg =3D (u32 *)(uintptr_t)ofnode_get_addr(args.node);
> >
> > -     priv->mmc_no =3D ((uintptr_t)priv->reg - SUNXI_MMC0_BASE) / 0x100=
0;
> >       priv->mclkreg =3D (void *)ccu_reg + get_mclk_offset() + priv->mmc=
_no * 4;
> >
> > +#if CONFIG_IS_ENABLED(CLK)
> >       ret =3D clk_get_by_name(dev, "ahb", &gate_clk);
> >       if (!ret)
> >               clk_enable(&gate_clk);
> > +#else
> > +     sunxi_mmc_clock_init(priv->mmc_no);
> > +#endif
> >
> >       ret =3D reset_get_bulk(dev, &reset_bulk);
> >       if (!ret)
> >               reset_deassert_bulk(&reset_bulk);
> > +#else
> > +     cfg->host_caps =3D sunxi_mmc_get_host_caps(plat->mmc_no);
> > +     sunxi_mmc_pinmux_setup(plat->mmc_no);
> > +     ret =3D mmc_resource_init(priv, plat->mmc_no);
> > +     if (ret)
> > +             return ret;
> > +     sunxi_mmc_clock_init(plat->mmc_no);
> > +#endif
> >
> >       ret =3D mmc_set_mod_clk(priv, 24000000);
> >       if (ret)
> >               return ret;
> >
> >       /* This GPIO is optional */
> > -     gpio_request_by_name(dev, "cd-gpios", 0, &priv->cd_gpio,
> > -                          GPIOD_IS_IN | GPIOD_PULL_UP);
> > +     if (CONFIG_IS_ENABLED(DM_GPIO) && CONFIG_IS_ENABLED(OF_REAL))
> > +             gpio_request_by_name(dev, "cd-gpios", 0, &priv->cd_gpio,
> > +                                  GPIOD_IS_IN | GPIOD_PULL_UP);
> >
> >       upriv->mmc =3D &plat->mmc;
> >
> > @@ -739,6 +786,7 @@ static int sunxi_mmc_bind(struct udevice *dev)
> >       return mmc_bind(dev, &plat->mmc, &plat->cfg);
> >  }
> >
> > +#if CONFIG_IS_ENABLED(OF_REAL)
> >  static const struct udevice_id sunxi_mmc_ids[] =3D {
> >       { .compatible =3D "allwinner,sun4i-a10-mmc" },
> >       { .compatible =3D "allwinner,sun5i-a13-mmc" },
> > @@ -754,15 +802,57 @@ static const struct udevice_id sunxi_mmc_ids[] =
=3D {
> >       { .compatible =3D "allwinner,sun50i-a100-emmc" },
> >       { /* sentinel */ }
> >  };
> > +#endif
> >
> >  U_BOOT_DRIVER(sunxi_mmc_drv) =3D {
> >       .name           =3D "sunxi_mmc",
> >       .id             =3D UCLASS_MMC,
> > +#if CONFIG_IS_ENABLED(OF_REAL)
> >       .of_match       =3D sunxi_mmc_ids,
> > +#endif
> >       .bind           =3D sunxi_mmc_bind,
> >       .probe          =3D sunxi_mmc_probe,
> >       .ops            =3D &sunxi_mmc_ops,
> >       .plat_auto      =3D sizeof(struct sunxi_mmc_plat),
> >       .priv_auto      =3D sizeof(struct sunxi_mmc_priv),
> > +#if !CONFIG_IS_ENABLED(OF_CONTROL)
> > +     .flags          =3D DM_FLAG_PRE_RELOC,
> > +#endif
> >  };
> > +
> > +#if defined(CONFIG_XPL_BUILD) && CONFIG_IS_ENABLED(DM_MMC) && \
> > +     !CONFIG_IS_ENABLED(OF_CONTROL)
> > +/*
> > + * SPL runs DM binding before DRAM init, and sunxi SPL .bss is in DRAM=
.
> > + * Keep this static platform data non-zero so it stays in SRAM-backed =
.data.
> > + */
> > +#define SUNXI_MMC_PLAT(_mmc_no)      { \
> > +             .mmc_no =3D _mmc_no, \
> > +             .cfg.name =3D SUNXI_MMC_NAME, \
> > +     }
> > +
> > +#define SUNXI_MMC_DRVINFO(_mmc_no) \
> > +     static struct sunxi_mmc_plat sunxi_mmc##_mmc_no##_plat =3D \
> > +             SUNXI_MMC_PLAT(_mmc_no); \
> > +     U_BOOT_DRVINFO(sunxi_mmc##_mmc_no) =3D { \
> > +             .name =3D "sunxi_mmc", \
> > +             .plat =3D &sunxi_mmc##_mmc_no##_plat, \
> > +     }
> > +
> > +#if !IS_ENABLED(CONFIG_UART0_PORT_F)
> > +SUNXI_MMC_DRVINFO(0);
> > +#endif
> > +
> > +#if CONFIG_MMC_SUNXI_SLOT_EXTRA =3D=3D 1
> > +SUNXI_MMC_DRVINFO(1);
> > +#endif
> > +
> > +#if CONFIG_MMC_SUNXI_SLOT_EXTRA =3D=3D 2 && defined(SUNXI_MMC2_BASE)
> > +SUNXI_MMC_DRVINFO(2);
> > +#endif
> > +
> > +#if CONFIG_MMC_SUNXI_SLOT_EXTRA =3D=3D 3 && defined(SUNXI_MMC3_BASE)
> > +SUNXI_MMC_DRVINFO(3);
> > +#endif
> > +#endif
> >  #endif
>
