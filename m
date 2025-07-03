Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65568C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 06:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEB3580E9A;
	Thu,  3 Jul 2025 08:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gM0HUnQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFFF381FEE; Thu,  3 Jul 2025 08:29:51 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7188580194
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 08:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-40a4de1753fso439071b6e.1
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 23:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751524188; x=1752128988; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HukX30uFytXJ8ZyrBySmSH6dbzr895qMsCH56VRD5R4=;
 b=gM0HUnQJZX26JH8Y/2rtp34n+37PWm7fxmWT8f21WRB/+kETez3xry73M0gNJCkQfO
 mGKs3Cz89UD8T1GxD1GL/TajmyZy6HX4OngTeTJ93aFMXtmix3f7PwoS0JWO+e2ZsYLU
 lJOhHC9D4aNkWL03rBhyqQyR/HKCGqr+20l4ypYRfvqT4WA6PM06mZTuAg5zigpWQxG8
 xmElGiOpGUgoVmZyuDqmbYiWy4EVbrLr3IgQLz08bDkYK2UGfpCus2arq9gw+hg6O2T7
 h/iB+4JL5LoNDj/6zzVG0sqXB43mn0FqHib8m+e98waTSeeY/JUYNUQB+5NPoSc1xigi
 T3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751524188; x=1752128988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HukX30uFytXJ8ZyrBySmSH6dbzr895qMsCH56VRD5R4=;
 b=MAOttDJQ2FdM4JlKtWnNwULVQsd2aWj4t396zzZeiAxi/2HRS92XqaGQL+9CKFXVTT
 YOa0nI87z8XAWjv6OFATv5PZKc/KQ3IV7/gRCnXtbcbg3F/NzluPDCl03+9it50xFfGy
 M/0N4guUt/4iYakmmHJHi2fgvrwY0oy7oNOKN+5d9FALqztMMwXBqy53Q9PpXatUG8VQ
 t+dMM9xABCdKdoHZEhEkctC+i+2hr1DlmBm82MxPcdcedE4o3FNu4qJ2DhyjlNHrPYgw
 7RE2JrnKdDby7x0HNb1EH1Npgveem3ernOOWd3uGwcugATCnkX/Oa9bgpfJ7JZrGUteL
 jx5w==
X-Gm-Message-State: AOJu0Yx2Yid1FE681ChLe8j8aH/TP50DiJ4tnY1hJR7ohQV2jtrFK3cc
 q7S4Q1gCbywCbzYyI1B7jVh9aD0Ab0rM0Kwaa8O6uONLgdYfjL4041RfCk8q4U5Pd9YivyWFqFO
 pabdHLfqYIyrv1aQQhhCe+I5EQs3GnqLadNtQ/P1wNQ==
X-Gm-Gg: ASbGncvPLqQijgPrSs4D8hG112c+1/Lr8KdKZjPHq99BYusrmvFTRL9nbaiEmNGz1m+
 uxdoDLjVcCbvDPp/RMppVMa/uRG1JpK74pQYFnBdUkMUiXTUYnUKNnuLvYqN1gw2ouXcZEz+zw4
 zK02pqvRruMt9yUekKsIhAjg8tA3M/2IIBJDO4Vi5lzw==
X-Google-Smtp-Source: AGHT+IGI4OGPStZZ9AuKdBOiLxjncJX7P0bn7h3VPOEDVH5NCO17OZXiOhEZgiFPQ0OH/mAeGPAazdr4EylkSmvDVRE=
X-Received: by 2002:a05:6808:6d8e:b0:40b:a4ca:f7cb with SMTP id
 5614622812f47-40cf31e2e60mr631154b6e.15.1751524187852; Wed, 02 Jul 2025
 23:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250703060517.3909695-1-alexthreed@gmail.com>
In-Reply-To: <20250703060517.3909695-1-alexthreed@gmail.com>
From: Alex Shumsky <alexthreed@gmail.com>
Date: Thu, 3 Jul 2025 09:29:36 +0300
X-Gm-Features: Ac12FXxiTJK9KERhSzHwWPAo7Slmzyu-gb6jqMUeip1RYfLyuvRHaRsx8-89NwM
Message-ID: <CAF4oh-NPW_nYdMoeh0y0wVK3e1c4gyroTvJUKh5tuXFNFvDOnw@mail.gmail.com>
Subject: Re: [PATCH v2] rockchip: rockchip-inno-usb2: Fix Synchronous Abort on
 usb start
To: u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Hi Jonas,

This time I had difficulties to reproduce Synchronous Abort on a real board=
, but
then I spotted a difference with my previous tests.
"usb start" abort happen when I boot upstream/current u-boot proper from
SD-card by older SPL/TPL installed on eMMC (stock/proprietary u-boot from 2=
019
installed by STB manufacturer).
There is no Sync Abort with upstream SPL/TPL. Looks like NULL dereference a=
re
still there but some SPL/TPL init code prevents it from aborting.

On Thu, Jul 3, 2025 at 9:05=E2=80=AFAM Alex Shumsky <alexthreed@gmail.com> =
wrote:
>
> Fix NULL pointer dereference that happen when rockchip-inno-usb2 clock
> enabled before device probe. This early clock enable call happen in proce=
ss
> of parent clock activation added in ac30d90f3367.
>
> Fixes: 229218373c22 ("phy: rockchip-inno-usb2: Add support for clkout_ctl=
_phy").
> Fixes: ac30d90f3367 ("clk: Ensure the parent clocks are enabled while rep=
arenting")
> Co-authored-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> ---
>
> Changes in v2:
> - rework patch (add NULL check to code instead of dts modification)
>
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/=
rockchip/phy-rockchip-inno-usb2.c
> index 88b33de1b2..3cc5956aed 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -167,20 +167,27 @@ static struct phy_ops rockchip_usb2phy_ops =3D {
>         .of_xlate =3D rockchip_usb2phy_of_xlate,
>  };
>
> -static void rockchip_usb2phy_clkout_ctl(struct clk *clk, struct regmap *=
*base,
> -                                       const struct usb2phy_reg **clkout=
_ctl)
> +static int rockchip_usb2phy_clkout_ctl(struct clk *clk, struct regmap **=
base,
> +                                      const struct usb2phy_reg **clkout_=
ctl)
>  {
>         struct udevice *parent =3D dev_get_parent(clk->dev);
>         struct rockchip_usb2phy *priv =3D dev_get_priv(parent);
>         const struct rockchip_usb2phy_cfg *phy_cfg =3D priv->phy_cfg;
>
> -       if (priv->phy_cfg->clkout_ctl_phy.enable) {
> +       // phy_cfg can be NULL if this function called before probe (when=
 parent
> +       // clocks are enabled)
> +       if (!phy_cfg)
> +               return -EINVAL;
> +
> +       if (phy_cfg->clkout_ctl_phy.enable) {
>                 *base =3D priv->phy_base;
>                 *clkout_ctl =3D &phy_cfg->clkout_ctl_phy;
>         } else {
>                 *base =3D priv->reg_base;
>                 *clkout_ctl =3D &phy_cfg->clkout_ctl;
>         }
> +
> +       return 0;
>  }
>
>  /**
> @@ -206,7 +213,8 @@ int rockchip_usb2phy_clk_enable(struct clk *clk)
>         const struct usb2phy_reg *clkout_ctl;
>         struct regmap *base;
>
> -       rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl);
> +       if (rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl))
> +               return -ENOSYS;
>
>         /* turn on 480m clk output if it is off */
>         if (!property_enabled(base, clkout_ctl)) {
> @@ -230,7 +238,8 @@ int rockchip_usb2phy_clk_disable(struct clk *clk)
>         const struct usb2phy_reg *clkout_ctl;
>         struct regmap *base;
>
> -       rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl);
> +       if (rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl))
> +               return -ENOSYS;
>
>         /* turn off 480m clk output */
>         property_enable(base, clkout_ctl, false);
> --
> 2.43.0
>
> base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
> branch: fix-rk3328-usb2phy-clock-v2
