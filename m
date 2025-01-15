Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4487C02185
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 163FA80214;
	Wed, 15 Jan 2025 14:58:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZIydj76w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF9880214; Wed, 15 Jan 2025 14:58:40 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65DD9800C2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2f4409fc8fdso1476885a91.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736949517; x=1737554317; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MeUyo58dISV+dWS0jMpZkjQ6dabAY9fl2mA8GdkI3HQ=;
 b=ZIydj76wtFVq0TXkdG9jW47vJ33b39zxpx4wfARhOcTV7E3loDQJ2UDOCtqCo55nZF
 DpdlgKu6Xg+LIs7R3ZbaGaoU/vfRoDydW/yD09hX0L5gixPSOdrO1WGbzZRPzcQEOEcE
 w65WuRjBIk3gMJhya+cSkbUvv0uM19pfgfDYQg3Xf6yJN1AKymY/Qza5GkXlQxjzTepJ
 BAKflwH8YkxG1nE3aZCMm/uhJ550BKULvU1o2nAClVWBqUg3kDU8ak3S9OcVYX5/H52x
 1Harp+JgG3nog4wb1hcjdkErlm1XMw5juG7YLP2pBvQHSG2Xete98oxuvTSDphaB8upv
 rRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736949517; x=1737554317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MeUyo58dISV+dWS0jMpZkjQ6dabAY9fl2mA8GdkI3HQ=;
 b=KJYs8DTatk35hISzhr1yyzUZeSMrkPlCuDZy1c5xmowITwTS9ewQeWmXAONW6xVaJs
 9T39iRAT8F8gwuXtfipzMi3LlOPVVlY2uB4Cp1IL7rT1MmG8YZqTIfIZHUrl5KX+I2jN
 V/DoiKuHGrqHZdv35qno0ycmLuHsb7V3jZUg+a3GqyN+hX/s/T1kLsTZeK8HaRhNMsu+
 iZypvnVnsJpKXS/Z0fmH5XB6lCq8wja0rMLJ4lMMCfhGHfA9clfDyweCdbhk24/JgEcg
 DvnMVwoo6xuiJT2PlSOd7JYv7WL25buZ0X/11r/BcIUgyPFJXR//Kp14Uv0vwMWy8Sba
 Rblg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyedfx7sYVU6Po7KgyT3Hv3KMalmJDNAGWrF/5phY9ZgDUwxORwTbn85uaALXy3paM+gGewCw=@lists.denx.de
X-Gm-Message-State: AOJu0YzRdO5B6TR039ewt83yyCwDhUH2exMyIaT+raIqbHRaRR90L4Le
 ZdTAg0H4lHxh4sCUIjJEMzgVUDZcCOKjY4Xpzt/sr0rvnf3DBulrxagAF4KmPOzR6LuUe9fheJW
 Sm9exKMgHe5BlrSJxWT3gqPAXCp0=
X-Gm-Gg: ASbGncvLjvRmxrTpTHHTu/Ek0BRcEMldTnlgZop24EDtch3UkyHDA/aK0Lt6XtFq9Rz
 AZYHmf+dW4enfUgtwGYY2sXR0Yl1yqCVi6tzKptx3q5PdznTt/ddIJ8SrExIT
X-Google-Smtp-Source: AGHT+IFVsFhz3Fs3+t6jzmbKwK+6uRFRKxmLRwmqM98WkkzdyBmLqpPye+gmMG3UxGnenn3WffVne0uvyYtveqWUh1M=
X-Received: by 2002:a17:90b:134e:b0:2f2:a974:1e45 with SMTP id
 98e67ed59e1d1-2f728e36688mr4649653a91.16.1736949516652; Wed, 15 Jan 2025
 05:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20250114052548.763611-1-anarsoul@gmail.com>
In-Reply-To: <20250114052548.763611-1-anarsoul@gmail.com>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Wed, 15 Jan 2025 16:58:25 +0300
X-Gm-Features: AbW1kvZirn4-K9s5pxRGQSt4MDNo_mLO_7DXQpwqE9VuqCKrLP2Htxj5fhL4kEE
Message-ID: <CAJs94Eas=3SsJoyZOTs2b_v=sBDUEHvXnu94s0J1vLVJ13738w@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: rockchip: rk3328: use HDMIPHY PLL as a clock
 parent for VOP_DCLK
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Anatolij Gustschin <agust@denx.de>, Dragan Simic <dsimic@manjaro.org>,
 Chen-Yu Tsai <wens@csie.org>, 
 Christopher Obbard <chris.obbard@collabora.com>, Jagan Teki <jagan@edgeble.ai>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

Thanks. Very interesting. I'll test it on my Rock64 at the weekend.

=D0=B2=D1=82, 14 =D1=8F=D0=BD=D0=B2. 2025=E2=80=AF=D0=B3. =D0=B2 08:26, Vas=
ily Khoruzhick <anarsoul@gmail.com>:
>
> The only video mode that currently works on rk3328 in u-boot is 1080p,
> because it uses GPLL for VOP_DCLK clock parent.
>
> Linux driver uses HDMIPHY PLL as a clock parent for VOP_DCLK, since using
> GPLL or CPLL is not feasible due these PLL being used as a clock parent
> for other devices. It would be cumbersome to recalculate dividers
> for the rest of the devices, and u-boot doesn't do it anyway. As a
> result, u-boot is not able to set desired dot clock for most
> resolutions.
>
> Switch to using HDMIPHY as a clock parent for VOP_DCLK
>
> Tested with 768p, 1080p, 1440p monitors.
>
> Fixes: 92edae779f8c ("clk: rockchip: rk3328: Add VOP clk support")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/clk/rockchip/clk_rk3328.c | 76 +++++++------------------------
>  1 file changed, 16 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk_rk3328.c b/drivers/clk/rockchip/clk=
_rk3328.c
> index 7701a9734ee..537af6b3290 100644
> --- a/drivers/clk/rockchip/clk_rk3328.c
> +++ b/drivers/clk/rockchip/clk_rk3328.c
> @@ -79,6 +79,12 @@ enum {
>         PLL_MODE_SLOW                   =3D 0,
>         PLL_MODE_NORM,
>
> +       /* MISC_CON */
> +       HDMIPHY_24M_SEL_SHIFT           =3D 13,
> +       HDMIPHY_24M_SEL_MASK            =3D 1 << HDMIPHY_24M_SEL_SHIFT,
> +       HDMIPHY_24M_SEL_PCLK            =3D 0,
> +       HDMIPHY_24M_SEL_24MHZ           =3D 1,
> +
>         /* CLKSEL_CON0 */
>         CLK_CORE_PLL_SEL_APLL           =3D 0,
>         CLK_CORE_PLL_SEL_GPLL,
> @@ -583,41 +589,11 @@ static ulong rk3328_spi_set_clk(struct rk3328_cru *=
cru, uint hz)
>  }
>
>  #ifndef CONFIG_XPL_BUILD
> -static ulong rk3328_vop_get_clk(struct rk3328_clk_priv *priv, ulong clk_=
id)
> -{
> -       struct rk3328_cru *cru =3D priv->cru;
> -       u32 div, con, parent;
> -
> -       switch (clk_id) {
> -       case ACLK_VOP_PRE:
> -               con =3D readl(&cru->clksel_con[39]);
> -               div =3D (con & ACLK_VOP_DIV_CON_MASK) >> ACLK_VOP_DIV_CON=
_SHIFT;
> -               parent =3D GPLL_HZ;
> -               break;
> -       case ACLK_VIO_PRE:
> -               con =3D readl(&cru->clksel_con[37]);
> -               div =3D (con & ACLK_VIO_DIV_CON_MASK) >> ACLK_VIO_DIV_CON=
_SHIFT;
> -               parent =3D GPLL_HZ;
> -               break;
> -       case DCLK_LCDC:
> -               con =3D readl(&cru->clksel_con[40]);
> -               div =3D (con & DCLK_LCDC_DIV_CON_MASK) >> DCLK_LCDC_DIV_C=
ON_SHIFT;
> -               parent =3D GPLL_HZ;
> -               break;
> -       default:
> -               printf("%s: Unsupported vop get clk#%ld\n", __func__, clk=
_id);
> -               return -ENOENT;
> -       }
> -
> -       return DIV_TO_RATE(parent, div);
> -}
> -
>  static ulong rk3328_vop_set_clk(struct rk3328_clk_priv *priv,
>                                 ulong clk_id, uint hz)
>  {
>         struct rk3328_cru *cru =3D priv->cru;
>         int src_clk_div;
> -       u32 con, parent;
>
>         src_clk_div =3D DIV_ROUND_UP(GPLL_HZ, hz);
>         assert(src_clk_div - 1 < 31);
> @@ -636,42 +612,25 @@ static ulong rk3328_vop_set_clk(struct rk3328_clk_p=
riv *priv,
>                              (src_clk_div - 1) << ACLK_VIO_DIV_CON_SHIFT)=
;
>                 break;
>         case DCLK_LCDC:
> -               con =3D readl(&cru->clksel_con[40]);
> -               con =3D (con & DCLK_LCDC_SEL_MASK) >> DCLK_LCDC_SEL_SHIFT=
;
> -               if (con) {
> -                       parent =3D readl(&cru->clksel_con[40]);
> -                       parent =3D (parent & DCLK_LCDC_PLL_SEL_MASK) >>
> -                                DCLK_LCDC_PLL_SEL_SHIFT;
> -                       if (parent)
> -                               src_clk_div =3D DIV_ROUND_UP(GPLL_HZ, hz)=
;
> -                       else
> -                               src_clk_div =3D DIV_ROUND_UP(GPLL_HZ, hz)=
;
> -
> -                       rk_clrsetreg(&cru->clksel_con[40],
> -                                    DCLK_LCDC_DIV_CON_MASK,
> -                                    (src_clk_div - 1) <<
> -                                    DCLK_LCDC_DIV_CON_SHIFT);
> -               }
> +               /* Set HDMIPHY clock output to pixel clock */
> +               rk_clrsetreg(&cru->misc, HDMIPHY_24M_SEL_MASK,
> +                            HDMIPHY_24M_SEL_PCLK << HDMIPHY_24M_SEL_SHIF=
T);
> +               /* Set HDMIPHY as a parent of DCLK_LCDC, and set all divi=
sors to 1 */
> +               rk_clrsetreg(&cru->clksel_con[40],
> +                            DCLK_LCDC_DIV_CON_MASK | DCLK_LCDC_SEL_MASK =
| CLK_HDMIPHY_DIV_CON_MASK,
> +                            (1 - 1) << CLK_HDMIPHY_DIV_CON_SHIFT |
> +                            DCLK_LCDC_SEL_HDMIPHY << DCLK_LCDC_SEL_SHIFT=
 |
> +                            (1 - 1) << DCLK_LCDC_DIV_CON_SHIFT);
>                 break;
>         default:
>                 printf("%s: Unable to set vop clk#%ld\n", __func__, clk_i=
d);
>                 return -EINVAL;
>         }
>
> -       return rk3328_vop_get_clk(priv, clk_id);
> +       return hz;
>  }
>  #endif
>
> -static ulong rk3328_hdmiphy_get_clk(struct rk3328_cru *cru)
> -{
> -       u32 div, con;
> -
> -       con =3D readl(&cru->clksel_con[40]);
> -       div =3D (con & CLK_HDMIPHY_DIV_CON_MASK) >> CLK_HDMIPHY_DIV_CON_S=
HIFT;
> -
> -       return DIV_TO_RATE(GPLL_HZ, div);
> -}
> -
>  static ulong rk3328_clk_get_rate(struct clk *clk)
>  {
>         struct rk3328_clk_priv *priv =3D dev_get_priv(clk->dev);
> @@ -701,9 +660,6 @@ static ulong rk3328_clk_get_rate(struct clk *clk)
>         case SCLK_SPI:
>                 rate =3D rk3328_spi_get_clk(priv->cru);
>                 break;
> -       case PCLK_HDMIPHY:
> -               rate =3D rk3328_hdmiphy_get_clk(priv->cru);
> -               break;
>         case SCLK_USB3OTG_REF:
>                 rate =3D OSC_HZ;
>                 break;
> --
> 2.47.1
>


--=20
With best regards,
Matwey V. Kornilov
