Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2A2C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 12:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE84803CB;
	Sat, 18 Jan 2025 13:53:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bQ2cYI0t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CAF18063E; Sat, 18 Jan 2025 13:53:10 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D363780077
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 13:53:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21644aca3a0so71511515ad.3
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 04:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737204786; x=1737809586; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3mNjtj5zr3R4LSJyWoMu96q7XvzcvK+KM2zWHHvmgE=;
 b=bQ2cYI0t8rRioVWVk+EDXNLC0F/jRQkdJqkBUe/hWfJHkzGWmL3KDka9C8Oa7jd5Fo
 A0llgX2dfLQ5eTiUZt13q2Onkhy7rciiv16IN+XNsv9C6IDIMQ9ovXnzMbv+2/XkhGqB
 JcmuUgZVJAdE1SmJOlKS46hCcLpi/WB0yiVRFCANNDdYF9ZzeT4Z8IOO4ydTj/YI/iDs
 Ac+5xcP6Weo3VoOPm39qDXmIyC1o5IbRdmRcqci/xzKfICdqa++Uov2/gCBUnqxqANqD
 +KbfSojhWLNWkOh6bThWh89PKVWiR7ilIhVMv1JtEIeV1n9q3xnfLW2ptvWowCGCgKLm
 /TLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737204786; x=1737809586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M3mNjtj5zr3R4LSJyWoMu96q7XvzcvK+KM2zWHHvmgE=;
 b=umSr+0dMslKq2mN4s80mA7zQ49yJkYXhEWzi+1lVhGsyQcRJ3N8WfPqYNkdv2EH5Go
 KUP8UgYihj9jLPCGKc4NN7BYwehCyk6YWHEjAPNmgXKJa7gwycHW0iIMksSoQ89Tuqnd
 c5xWh+Ma4nKzM7XGtYnFPymFq0Q83WCyveYlMOmKQ/VfKgE3ndaqvPwlgGzAAO1XL9E2
 YyyChR8nRDc4tqn3UvVSaIyMGC19rkK0Cqs/wcuqTLKwBr6qyfsG8HifDmvVm/FhQYI/
 ANEZ6Ox3SFe6QXUA9HLPi6R68msvKLMmSKfTNgtIjT/t3N6CIcsj5KP9SWlwQH2BH8dG
 jdJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEh472o3MVFQ5H8dKxcp5zxLEQ8gdUuTs2AcYRU5T57P3mG24N6O5JATzAlG85+Hrcnf6u14o=@lists.denx.de
X-Gm-Message-State: AOJu0YzgaBXBmhQTM6ppU/FkWn8I2OxoPJ2hSIzbFrgux2vruPcSV0LF
 v6e9OwuPxhp1vokBlXm8p7RFgrPGE0qifGLdXxptAO9v5ujwNy+SA9+gR9yYhHWdVz8fQz5fDsB
 hFHFBItD1oUQw61lXBPSalAVdIzE=
X-Gm-Gg: ASbGncsuP806oVrqOt0T3ZmP7lOZq3uPx4WF8Rh1tyy2SoHAveeXbqPH3PgyfLZIlnB
 8qS/COz1+ht3ktBcyrl03sqXT1WJZSRqQuhnex8H/zo+hmPbWZWJIQieTusWHfjXgxQL5ySrA8A
 sjv4hCKA==
X-Google-Smtp-Source: AGHT+IGMy7ZFKs02XGA8kBaoNAEWTNyKAEkpTu1KtYfTbghDkIrt3Ygj4H0xKnWDPM4TLGom2iW0mj9ZtGFJ3HBsOMI=
X-Received: by 2002:a17:902:ec87:b0:215:bf1b:a894 with SMTP id
 d9443c01a7336-21c3555cf79mr93252545ad.24.1737204786152; Sat, 18 Jan 2025
 04:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20250114052548.763611-1-anarsoul@gmail.com>
In-Reply-To: <20250114052548.763611-1-anarsoul@gmail.com>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Sat, 18 Jan 2025 15:52:54 +0300
X-Gm-Features: AbW1kvYmmOL3gkNtjLkxcmuDrGx4IWceVeoEP5k1loaFvndIqrkcFF7BTMJwlP8
Message-ID: <CAJs94EbAfQ8Ht6tiX_V=wcVP7cADzuAGzJSLn4KZnVPXN_0XDg@mail.gmail.com>
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

Both UART-console and HDMI-console works with this patcheset on my Rock64 b=
oard.

Tested-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>

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
