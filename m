Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E3AC52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 16:41:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0456587CF8;
	Mon, 12 Aug 2024 18:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="AcUoeWEk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A27A987B77; Mon, 12 Aug 2024 18:41:55 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF1F9887B9
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 18:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7ab5fc975dso357298366b.1
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 09:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1723480912; x=1724085712;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WIXs0YTrbksd8mLrHAX2Pid9SjOzJxgtxaeZLU7IJn8=;
 b=AcUoeWEkIZbqk13sglNEup2tz7FWgwo1y/PrPZ9qbL2ERDX4gxeBVMhGQ0iHvO2c9Z
 Xjq0nsDfwj+pNZGIxoJXUOaMRXJQAuzDVR1VxHz/BxCjbdfod/rFwLb2o70CGcgTCIG/
 2fnPds0REXTDyvvIvBT4OhsaO05d5qh5TZzSE4m+CcqBKBtGcAXeY1vgtHIBNOQee5jt
 1brudTk3NGsLzUMpyL+hwR/9UCDtwt7BCBbGBRPNjDOWIvUprIXThl4b7qE4LTlyzZEx
 cIKLIfpEW3c0ge1jNQJS7jn4+8QwdSuVo9fVyW50xS6l76bSvJjSFKvYQ+bWTIPaSHQc
 wWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723480912; x=1724085712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WIXs0YTrbksd8mLrHAX2Pid9SjOzJxgtxaeZLU7IJn8=;
 b=DKBeWb6IIQK6JWikJykgnY4O5qoWNnWvZLcaO2hQYG2EyXv1iCo9YswF3RgjpAuXI+
 2s6O75xodwsBpiAGxUyEcjtL4BAtRsMb49TKuSdw4sF5FAf5Jl7BP/dGIgXhTBb0L5wW
 hm15AKbkSCdYQOt0xC1iLN5GEEOiqOFygnaEptBcW7EYLM0b7x3KlSGYNlRfFviEpfgp
 2FA+2qyopR6PUZlzUIXLPr232hlyZuXGnnMrBJNe3kAAv8LtERKzU+tZs6cOAHi7TnjR
 Gyb/VYfV2uIiJDibuavaVmHmpHdzIhWQt3nnosYZBz7Qi4DdE4X4uOfxGJKANILY2iDi
 fEIQ==
X-Gm-Message-State: AOJu0YxQrEuHi57cNAl+oQm9DiD8OUkCqtURtXSddx0q65aG7ODB4l44
 l/PF1Df3PCDgMLEO054DV4Byssnb89Kj2HRW74coxYFi52948zu0BspuSUfZrtER/2HV54VUoVl
 Sv4Le1Tl/Qu2kdyNiId1qqlB4v/MyQ2lLfXAezg==
X-Google-Smtp-Source: AGHT+IFjz5D9qI8Ntz9ogL3b8+nzll/3eh1KOj6mc+08epk1bHdNmsObS3nHP+rINPDBlG2+oe8eh431K6ZuIeePpOY=
X-Received: by 2002:a17:907:e64b:b0:a7a:8e98:890d with SMTP id
 a640c23a62f3a-a80ed1bffb8mr70388766b.16.1723480911899; Mon, 12 Aug 2024
 09:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240731094307.65307-1-lukasz.czechowski@thaumatec.com>
 <d1f9b069-1c07-44d6-8dbc-fc6cd07b576c@cherry.de>
 <5c5f170a-90d5-40db-b1b5-da004f3e3d9f@cherry.de>
In-Reply-To: <5c5f170a-90d5-40db-b1b5-da004f3e3d9f@cherry.de>
From: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>
Date: Mon, 12 Aug 2024 18:41:41 +0200
Message-ID: <CABd623urDxhiAdiJfFNUf3vqqGcHZ1Ef2LNaPX3wVAocLWx03w@mail.gmail.com>
Subject: Re: [PATCH] rockchip: clk: add UART0 clock getter/setter
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com, lukma@denx.de, 
 seanga2@gmail.com
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

Hi Quentin,
I've submitted the updated version of the patch. Indeed the
calculation for UART0_CLK_SEL_UART0_NP5 seemed wrong - I've corrected
it. Added also casting to u64, as according to TRM, PLL can reach up
to 3,2GHz.
Declaration order and commit message are updated.
As for the clock source for UART0_CLK_SEL_UART0_FRAC, I'd like to keep
things simple, so I left the GPLL configured as clock source.
Similarly is already done in the rk3588 clock driver.

Best regards,
Lukasz


czw., 1 sie 2024 o 12:27 Quentin Schulz <quentin.schulz@cherry.de> napisa=
=C5=82(a):
>
> Hi Lukasz,
>
> Maybe also make it explicit in the commit title that this is for px30
> only :)
>
> On 8/1/24 12:26 PM, Quentin Schulz wrote:
> > Hi Lukasz,
> >
> > On 7/31/24 11:43 AM, Lukasz Czechowski wrote:
> >> Add dedicated getter and setter for SCLK_UART0_PMU.
> >> This allows the driver to correctly handle UART0 clocks, and thus
> >> it fixes the issues with UART0 not working in case DEBUG_UART is
> >> disabled.
> >> Unlike other Rockchip SoCs, i.e. rk3399, in the PX30 the default
> >> clock source for UART is GPLL, instead of external oscillator.
> >> If the DEBUG_UART is enabled, the clock source is changed in
> >> board_debug_uart_init function to 24Mhz oscillator, which also
> >> matches the fallback value obtained from DT node.
> >> In case the DEBUG_UART is disabled, the UART clock source remains
> >> default, and the DM serial driver wrongly configures the baud rate,
> >> resulting in broken communication.
> >> By implementing the UART clock getter/setter, the serial driver
> >> can probe the actual configuration and corectly configure itself.
> >> The DEBUG_UART settings now should not affect it.
> >>
> >> The driver supports GPLL and 24M oscillator. NPLL and USBPHY480M
> >> sources, that are managed by CRU, are not yet handled, as likely
> >> they won't be used in real scenarios.
> >>
> >> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> >> ---
> >>   arch/arm/include/asm/arch-rockchip/cru_px30.h |   7 ++
> >>   drivers/clk/rockchip/clk_px30.c               | 107 ++++++++++++++++=
++
> >>   2 files changed, 114 insertions(+)
> >>
> >> diff --git a/arch/arm/include/asm/arch-rockchip/cru_px30.h
> >> b/arch/arm/include/asm/arch-rockchip/cru_px30.h
> >> index b66277fc7f3..504459bd93d 100644
> >> --- a/arch/arm/include/asm/arch-rockchip/cru_px30.h
> >> +++ b/arch/arm/include/asm/arch-rockchip/cru_px30.h
> >> @@ -464,5 +464,12 @@ enum {
> >>       UART0_CLK_SEL_UART0_FRAC,
> >>       UART0_DIVNP5_SHIFT        =3D 0,
> >>       UART0_DIVNP5_MASK        =3D 0x1f << UART0_DIVNP5_SHIFT,
> >> +
> >> +    /* CRU_PMU_CLKSEL5_CON */
> >> +    CLK_UART_FRAC_NUMERATOR_SHIFT    =3D 16,
> >> +    CLK_UART_FRAC_NUMERATOR_MASK    =3D 0xffff <<
> >> CLK_UART_FRAC_NUMERATOR_SHIFT,
> >> +    CLK_UART_FRAC_DENOMINATOR_SHIFT    =3D 0,
> >> +    CLK_UART_FRAC_DENOMINATOR_MASK =3D
> >> +        0xffff << CLK_UART_FRAC_DENOMINATOR_SHIFT,
> >>   };
> >>   #endif
> >> diff --git a/drivers/clk/rockchip/clk_px30.c
> >> b/drivers/clk/rockchip/clk_px30.c
> >> index 2875c152b20..64f1a335cb0 100644
> >> --- a/drivers/clk/rockchip/clk_px30.c
> >> +++ b/drivers/clk/rockchip/clk_px30.c
> >> @@ -1589,6 +1589,107 @@ static ulong px30_pmuclk_set_gpll_rate(struct
> >> px30_pmuclk_priv *priv, ulong hz)
> >>       return priv->gpll_hz;
> >>   }
> >> +static ulong px30_pmu_uart0_get_clk(struct px30_pmuclk_priv *priv)
> >> +{
> >> +    struct px30_pmucru *pmucru =3D priv->pmucru;
> >> +    u32 clk_uart0_div_con;
> >> +    u32 clk_uart0_pll_sel;
> >> +    u32 clk_uart0_sel;
> >> +    u32 con;
> >> +    ulong pll_rate;
> >> +    ulong clk_uart0;
> >> +
> >
> > You could group all declarations of the same type on the same line and
> > also respect reverse xmas tree ordering
> > (https://docs.kernel.org/process/maintainer-netdev.html#local-variable-=
ordering-reverse-xmas-tree-rcs) (though I don't think we are that strict in=
 U-Boot).
> >
> >> +    con =3D readl(&pmucru->pmu_clksel_con[3]);
> >> +    clk_uart0_div_con =3D bitfield_extract_by_mask(con,
> >> UART0_DIV_CON_MASK);
> >> +    clk_uart0_pll_sel =3D bitfield_extract_by_mask(con,
> >> UART0_PLL_SEL_MASK);
> >> +
> >> +    switch (clk_uart0_pll_sel) {
> >> +    case UART0_PLL_SEL_GPLL:
> >> +        pll_rate =3D px30_pmuclk_get_gpll_rate(priv);
> >> +        break;
> >> +    case UART0_PLL_SEL_24M:
> >> +        pll_rate =3D OSC_HZ;
> >> +        break;
> >> +    case UART0_PLL_SEL_480M:
> >> +    case UART0_PLL_SEL_NPLL:
> >> +        /* usbphy480M and NPLL clocks, generated by CRU, are not
> >> supported yet */
> >> +    default:
> >> +        return -ENOENT;
> >> +    }
> >> +
> >> +    clk_uart0 =3D DIV_TO_RATE(pll_rate, clk_uart0_div_con);
> >> +    con =3D readl(&pmucru->pmu_clksel_con[4]);
> >> +    clk_uart0_sel =3D bitfield_extract_by_mask(con, UART0_CLK_SEL_MAS=
K);
> >> +
> >> +    switch (clk_uart0_sel) {
> >> +    case UART0_CLK_SEL_UART0:
> >> +        return clk_uart0;
> >> +    case UART0_CLK_SEL_UART0_NP5:{
> >> +            u32 clk_uart0_divnp5_div_con;
> >> +
> >> +            clk_uart0_divnp5_div_con =3D
> >> +                bitfield_extract_by_mask(con, UART0_DIVNP5_MASK);
> >> +            return DIV_TO_RATE((2 * clk_uart0),
> >> +                       (2 * clk_uart0_divnp5_div_con + 3));
> >
> > Are you sure about this DIV_TO_RATE here?
> >
> > The TRM states:
> >
> > clk_uart0_divnp5_div_con
> > clk_uart0_np5=3D2*clk_uart0/(2*div_con+3)
> >
> > but this would make it
> > clk_uart0_np5=3D2*clk_uart0/((2*div_con+3) + 1)
> >
> > I believe?
> >
> > The kernel seems to be handling it like the TRM says (but I wouldn't be
> > 100% certain here as the clock subsystem and Rockchip drivers have many
> > indirections and I may have gotten lost at some point :) ).
> >
> > I think we're fine also regarding u32 overflows as we would hit this if
> > the rates were abore 2.1GHz and I think GPLL and NPLL aren't that fast.
> >
> >> +        } > +    case UART0_CLK_SEL_UART0_FRAC:{
> >> +            u32 fracdiv, n, m;
> >> +
> >> +            fracdiv =3D readl(&pmucru->pmu_clksel_con[5]);
> >> +            n =3D bitfield_extract_by_mask(fracdiv,
> >> +                             CLK_UART_FRAC_NUMERATOR_MASK);
> >> +            m =3D bitfield_extract_by_mask(fracdiv,
> >> +                             CLK_UART_FRAC_DENOMINATOR_MASK);
> >> +            return (u64) clk_uart0 * n / m;
> >> +        }
> >> +    default:
> >> +        return -ENOENT;
> >> +    }
> >> +}
> >> +
> >> +static ulong px30_pmu_uart0_set_clk(struct px30_pmuclk_priv *priv,
> >> ulong rate)
> >> +{
> >> +    struct px30_pmucru *pmucru =3D priv->pmucru;
> >> +    ulong gpll_rate;
> >> +    u32 clk_uart0_div_con;
> >> +    u32 clk_uart0_pll_sel;
> >> +    u32 clk_uart0_sel;
> >> +    ulong m =3D 0, n =3D 0;
> >> +
> >> +    gpll_rate =3D px30_pmuclk_get_gpll_rate(priv);
> >> +    if (gpll_rate % rate =3D=3D 0) {
> >> +        clk_uart0_pll_sel =3D UART0_PLL_SEL_GPLL;
> >> +        clk_uart0_sel =3D UART0_CLK_SEL_UART0;
> >> +        clk_uart0_div_con =3D DIV_ROUND_UP(priv->gpll_hz, rate);
> >> +    } else if (rate =3D=3D OSC_HZ) {
> >> +        clk_uart0_pll_sel =3D UART0_PLL_SEL_24M;
> >> +        clk_uart0_sel =3D UART0_CLK_SEL_UART0;
> >> +        clk_uart0_div_con =3D 1;
> >> +    } else {
> >> +        clk_uart0_pll_sel =3D UART0_PLL_SEL_GPLL;
> >> +        clk_uart0_sel =3D UART0_CLK_SEL_UART0_FRAC;
> >> +        clk_uart0_div_con =3D 1;
> >> +        rational_best_approximation(rate, priv->gpll_hz,
> >> +                        GENMASK(16 - 1, 0),
> >> +                        GENMASK(16 - 1, 0), &m, &n);
> >
> > I guess we could try to find whether OSC_HZ could produce a closer
> > approximation than GPLL but I'm not sure it's worth it right now.
> >
> > Otherwise looking good,
> > Cheers,
> > Quentin
