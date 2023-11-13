Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF8DC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 02:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F29086B0A;
	Mon, 13 Nov 2023 03:42:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PCuSVAI+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B1E686B4E; Mon, 13 Nov 2023 03:42:51 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3076586958
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 03:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507bd64814fso5781902e87.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 18:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699843368; x=1700448168; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dx7olLyu0C1wYk1t00SxH6Eq4zksZJil98GI/ckykG4=;
 b=PCuSVAI+Jh8g0huSyH908RNPKwNgrXBdN0g+Hheu6usqB1aXjefkzTevk1Ue8jgyrt
 81BA4F10Eh2UrfDZHtOrIGxmKZoFwHpKoWEKR2iRGvYdOgbWltDssznQdaHEUqmGcti4
 mZN91MRvxXlbV7Zdgju9U+c0sEe3kOYJWAtNmO2t9wxJQVRP2NDekqBis0SZTXwwT5si
 F2Ldzy/aLy6+6oJA+Qr117SidQjg/kfccI4xMMtYuq2ep5Vr30WlCSGR4PeMhIJKAeSI
 q7kxSbc1TZM1BVLyoNibXQtgTsLByVSmmOa9b5iWqMnvlge6YzzGkIgHbuiXNz5Fn8bE
 XH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699843368; x=1700448168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dx7olLyu0C1wYk1t00SxH6Eq4zksZJil98GI/ckykG4=;
 b=X4ZkikJEFeRkQIsEDinL3863WlWJi0fnVgaxidbvmx1JQEIdcIWL2cawNfiqKw9b/X
 F4oDH5111mKRPb3FnZ0bTixrwMsvj3M/mK5YF1+ILhWAT1f8+5787OFh4EzxEcbZSJDe
 SQQ0TtIlNj/ucmJdK8ny4JOt07udBDzFXuPH4GcVBEIb5UaR0cqnvHw7619pLYNzirtv
 KVG+I0jW9VaeN6ufAIe/P/EwcYCxvhv7/378+GESHwMv2aON/T/BmDj5Xug3c4Vp9n7c
 2KT+EbWtvz0GrG5f/hyGQgax5GF7uQ6ayhXdqvBiTGFTxnqDWzUQP5MnTjkKG2TqvBNT
 7VWw==
X-Gm-Message-State: AOJu0YyXLPOuz4vvqTmeoTGteFm50OEt5Pc+Gss87BLwXoSIFAXk2F/o
 d99wYy0fr8g2D/yiJ25soWYSmw6Jy9ZjBEMMQOY=
X-Google-Smtp-Source: AGHT+IF3h76K6E7uGbn5V2ytx9lNaJGOHuxUZoCeyLxQVH46UCLkL0ClgyBFTOYjbHNX7r6YtQcfsjSlFygfScGlTOQ=
X-Received: by 2002:ac2:5dd6:0:b0:507:9d70:b297 with SMTP id
 x22-20020ac25dd6000000b005079d70b297mr3048390lfq.60.1699843367929; Sun, 12
 Nov 2023 18:42:47 -0800 (PST)
MIME-Version: 1.0
References: <20231107090128.199267-1-JJLIU0@nuvoton.com>
 <8b3ac0c1-6f2a-92ec-120a-ae65faae1c0b@gmail.com>
In-Reply-To: <8b3ac0c1-6f2a-92ec-120a-ae65faae1c0b@gmail.com>
From: Jim Liu <jim.t90615@gmail.com>
Date: Mon, 13 Nov 2023 10:42:36 +0800
Message-ID: <CAKUZ0+GwDB+f669CJ+hy7n9NpVkZR1y_ZwRRMJVyC2Be7RAcFw@mail.gmail.com>
Subject: Re: [PATCH v2] clk: nuvoton: add read only feature for clk driver
To: Sean Anderson <seanga2@gmail.com>
Cc: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com, 
 u-boot@lists.denx.de
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

Hi Sean

Thanks for your review.

The spi clock setting is related to booting flash, it is setup by
early bootloader and we don't want u-boot to change it


Best regards,
Jim


On Thu, Nov 9, 2023 at 2:07=E2=80=AFAM Sean Anderson <seanga2@gmail.com> wr=
ote:
>
> On 11/7/23 04:01, Jim Liu wrote:
> > Add a flag to set ahb/apb/fiu clock divider as read-only
> > It just protects the clock source and can't modify it in uboot.
>
> Thanks for adding this
>
> > Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> > ---
> > Changes for v2:
> >     - add commit message
> > ---
> >   drivers/clk/nuvoton/clk_npcm.c    | 15 ++++++++++++---
> >   drivers/clk/nuvoton/clk_npcm.h    |  1 +
> >   drivers/clk/nuvoton/clk_npcm8xx.c | 12 ++++++------
> >   3 files changed, 19 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/clk/nuvoton/clk_npcm.c b/drivers/clk/nuvoton/clk_n=
pcm.c
> > index 8d71f2a24b..18cb9cddbf 100644
> > --- a/drivers/clk/nuvoton/clk_npcm.c
> > +++ b/drivers/clk/nuvoton/clk_npcm.c
> > @@ -135,7 +135,7 @@ static u32 npcm_clk_get_div(struct clk *clk)
> >       return div;
> >   }
> >
> > -static u32 npcm_clk_set_div(struct clk *clk, u32 div)
> > +static int npcm_clk_set_div(struct clk *clk, u32 div)
> >   {
> >       struct npcm_clk_priv *priv =3D dev_get_priv(clk->dev);
> >       struct npcm_clk_div *divider;
> > @@ -145,6 +145,9 @@ static u32 npcm_clk_set_div(struct clk *clk, u32 di=
v)
> >       if (!divider)
> >               return -EINVAL;
> >
> > +     if (divider->flags & DIV_RO)
> > +             return 0;
> > +
> >       if (divider->flags & PRE_DIV2)
> >               div =3D div >> 1;
> >
> > @@ -153,6 +156,12 @@ static u32 npcm_clk_set_div(struct clk *clk, u32 d=
iv)
> >       else
> >               clkdiv =3D ilog2(div);
> >
> > +     if (clkdiv > (divider->mask >> (ffs(divider->mask) - 1))) {
> > +             printf("clkdiv(%d) for clk(%ld) is over limit\n",
> > +                    clkdiv, clk->id);
> > +             return -EINVAL;
> > +     }
> > +
> >       val =3D readl(priv->base + divider->reg);
> >       val &=3D ~divider->mask;
> >       val |=3D (clkdiv << (ffs(divider->mask) - 1)) & divider->mask;
> > @@ -253,8 +262,8 @@ static ulong npcm_clk_set_rate(struct clk *clk, ulo=
ng rate)
> >       if (ret)
> >               return ret;
> >
> > -     debug("%s: rate %lu, new rate (%lu / %u)\n", __func__, rate, pare=
nt_rate, div);
> > -     return (parent_rate / div);
> > +     debug("%s: rate %lu, new rate %lu\n", __func__, rate, npcm_clk_ge=
t_rate(clk));
> > +     return npcm_clk_get_rate(clk);
> >   }
> >
> >   static int npcm_clk_set_parent(struct clk *clk, struct clk *parent)
> > diff --git a/drivers/clk/nuvoton/clk_npcm.h b/drivers/clk/nuvoton/clk_n=
pcm.h
> > index 06b60dc8b8..b4726d8381 100644
> > --- a/drivers/clk/nuvoton/clk_npcm.h
> > +++ b/drivers/clk/nuvoton/clk_npcm.h
> > @@ -50,6 +50,7 @@
> >   #define PRE_DIV2    BIT(2)  /* Pre divisor =3D 2 */
> >   #define POST_DIV2   BIT(3)  /* Post divisor =3D 2 */
> >   #define FIXED_PARENT        BIT(4)  /* clock source is fixed */
> > +#define DIV_RO               BIT(5)  /* divider is read-only */
> >
> >   /* Parameters of PLL configuration */
> >   struct npcm_clk_pll {
> > diff --git a/drivers/clk/nuvoton/clk_npcm8xx.c b/drivers/clk/nuvoton/cl=
k_npcm8xx.c
> > index 27e3cfcf55..d1b32e3237 100644
> > --- a/drivers/clk/nuvoton/clk_npcm8xx.c
> > +++ b/drivers/clk/nuvoton/clk_npcm8xx.c
> > @@ -45,12 +45,12 @@ static struct npcm_clk_select npcm8xx_clk_selectors=
[] =3D {
> >   };
> >
> >   static struct npcm_clk_div npcm8xx_clk_dividers[] =3D {
> > -     {NPCM8XX_CLK_AHB, CLKDIV1, CLK4DIV, DIV_TYPE1 | PRE_DIV2},
> > -     {NPCM8XX_CLK_APB2, CLKDIV2, APB2CKDIV, DIV_TYPE2},
> > -     {NPCM8XX_CLK_APB5, CLKDIV2, APB5CKDIV, DIV_TYPE2},
> > -     {NPCM8XX_CLK_SPI0, CLKDIV3, SPI0CKDIV, DIV_TYPE1},
> > -     {NPCM8XX_CLK_SPI1, CLKDIV3, SPI1CKDIV, DIV_TYPE1},
> > -     {NPCM8XX_CLK_SPI3, CLKDIV1, SPI3CKDIV, DIV_TYPE1},
> > +     {NPCM8XX_CLK_AHB, CLKDIV1, CLK4DIV, DIV_TYPE1 | PRE_DIV2 | DIV_RO=
},
> > +     {NPCM8XX_CLK_APB2, CLKDIV2, APB2CKDIV, DIV_TYPE2 | DIV_RO},
> > +     {NPCM8XX_CLK_APB5, CLKDIV2, APB5CKDIV, DIV_TYPE2 | DIV_RO},
>
> And this makes sense for bus clocks
>
> > +     {NPCM8XX_CLK_SPI0, CLKDIV3, SPI0CKDIV, DIV_TYPE1 | DIV_RO},
> > +     {NPCM8XX_CLK_SPI1, CLKDIV3, SPI1CKDIV, DIV_TYPE1 | DIV_RO},
> > +     {NPCM8XX_CLK_SPI3, CLKDIV1, SPI3CKDIV, DIV_TYPE1 | DIV_RO},
>
> But it's a little unclear to me why this is enabled for SPI. Are you e.g.
> doing XIP from SPI?
>
> --Sean
>
> >       {NPCM8XX_CLK_SPIX, CLKDIV3, SPIXCKDIV, DIV_TYPE1},
> >       {NPCM8XX_CLK_UART, CLKDIV1, UARTDIV1, DIV_TYPE1},
> >       {NPCM8XX_CLK_UART2, CLKDIV3, UARTDIV2, DIV_TYPE1},
>
