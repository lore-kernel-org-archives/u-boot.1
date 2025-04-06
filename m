Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43764C3601A
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 21:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6CEA82BDC;
	Sun,  6 Apr 2025 23:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KpI+9Ia2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA7E782BDC; Sun,  6 Apr 2025 23:11:18 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 557B082C2F
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 23:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e5c9662131so5819900a12.3
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 14:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743973875; x=1744578675; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BcI15po75c4DpryXM6XE2KAMbEcEzy/h6oWlMhrtVqM=;
 b=KpI+9Ia2sYIZyH7jvrTvxacZnwV83dXhI4kYZRY8D9/uPn2EjAAQIdyE8bOb2azk1m
 Dxmj47wWhZx/idkIO/WaZAURJj0XTl3MSsf5Siu9Ev1qNhbJ0GK5NQX5+8gMLrDin9mk
 Tu+42N4pOlrs9A8RJxkd5EW8IEUR0PjhyLQLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743973875; x=1744578675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BcI15po75c4DpryXM6XE2KAMbEcEzy/h6oWlMhrtVqM=;
 b=lXtK1U2wskiorzVFHCYRoytFw0YsXJXiLIKW5XQx2IozTX6qrszVwm9+wLHWtYuVY2
 WTImnQdAnLPBXvv/g4i6Uyq2E5/VnqL7DyflR2Z4op8iBlPQBZHaw54BWOCkf9UFRsFc
 uWB4z5DCz6kBfQ4K3tdk4fenU6cXMLBHuc44mpIcdkyLJuGtrrtSJQLJgKUSnQZ3ShgM
 tE39U71n9W2VmFW0ot+Av9NdTus+ee5eiY4Vge/6L9RQA5X5UrJ3Lnkc98KqUmzCIbBO
 53xQnTGlX/SLlXqJE2eby9uQzPO6VliGyp7ljzChF5aS2fXaQAf5uc45sn9l9p/5WZ4C
 1KkA==
X-Gm-Message-State: AOJu0YyVf4r8VdJt/zAH7TI82goDahUb3falMucoZwYbIWfah1im9O8x
 R4yc1sQinuuxwjMH8/OhSLRNGBtXgmDp5yGF1D9plXM74oZiZ9+BnS/KayiFYncbt56dMe+/vOl
 jx0AOcV99QQF+FJ7O4i73KmpidGXuLVlRuubw
X-Gm-Gg: ASbGnct44Lhwp63h3IDZTqge+3oTda9GQIZ64J0RuNFoUGHK8z1RTX7oK7QoTPSHWPw
 p+Ntg+fhjEd7buqh4DlNJkDYqmQr4z9u6bZ1krAhW84Ide+CGmp/sVuwXSnLBK1bndAd1n8M3bv
 pl4zhTnnk7Tx8sx74y0cLFpfRJs1bXJCNuUNq2lYc=
X-Google-Smtp-Source: AGHT+IHUXT5Sy73XKgX7gMs/LPVH8sVlT7v62WEMiuOkIXO37c7mf175CsjSCtNvAWklKH7BwyQ14R9l+DJTtVVbtHg=
X-Received: by 2002:a17:907:1b26:b0:ac7:3912:5ea7 with SMTP id
 a640c23a62f3a-ac7d6f22f82mr842672266b.60.1743973874523; Sun, 06 Apr 2025
 14:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250405221308.498047-1-sjg@chromium.org>
 <20250405221308.498047-2-sjg@chromium.org>
 <dc4dec57-6fba-4224-9f84-1cc63c58eacd@kwiboo.se>
In-Reply-To: <dc4dec57-6fba-4224-9f84-1cc63c58eacd@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Apr 2025 09:10:59 +1200
X-Gm-Features: ATxdqUEnyd67I1bf3xTSw1_xYgch-V5k86_kPtngIUOEXajn_iWbdrZFvEhoYvo
Message-ID: <CAFLszTim=Fq9rv0BfypZoje=i+HU_ZTdFK_GSQoZSsESWm=Jqg@mail.gmail.com>
Subject: Re: [PATCH 2/3] designware: Use the remove() method with related
 drivers
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 neil.armstrong@linaro.org, 
 =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>, 
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot-amlogic@groups.io
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

On Sun, 6 Apr 2025 at 21:02, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-04-06 00:12, Simon Glass wrote:
> > Several drivers make use of the designware Ethernet driver but do not
> > implement the remove() method. Add this so that DMA is stopped when the
> > OS is booted to avoid memory corruption, etc.
>
> The designware Ethernet driver core should not need the remove() ops as
> the eth_ops.stop() ops already should stop DMA. And the eth-uclass
> pre_remove() ops already call the eth_ops.stop() ops.
>
> All these drivers seem to use designware_eth_ops and thus have correct
> stop() ops configured and should really not need the remove() ops.
>

That's interesting. I wrote that code about 9 years ago so perhaps can
be forgiven for forgetting.

Very few drivers set the DM_FLAG_ACTIVE_DMA flag, certainly not the
designware ones. So how would they be removed?

> Side note, this also misses the gmac rockchip driver that uses its own
> eth_ops instead of designware_eth_ops, however it also use same stop()
> ops as all these drivers.

Hmm yes I saw that but then apparently forgot to include it.

I can perhaps redo this patch to add the DMA flag.

>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reported-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
> > ---
> >
> >  drivers/net/designware.c    |  2 +-
> >  drivers/net/designware.h    | 12 ++++++++++++
> >  drivers/net/dwmac_meson8b.c |  6 ++++++
> >  drivers/net/dwmac_s700.c    |  6 ++++++
> >  drivers/net/dwmac_socfpga.c |  6 ++++++
> >  5 files changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> > index eebf14bd51a..d4d31925fca 100644
> > --- a/drivers/net/designware.c
> > +++ b/drivers/net/designware.c
> > @@ -805,7 +805,7 @@ clk_err:
> >       return err;
> >  }
> >
> > -static int designware_eth_remove(struct udevice *dev)
> > +int designware_eth_remove(struct udevice *dev)
> >  {
> >       struct dw_eth_dev *priv =3D dev_get_priv(dev);
> >
> > diff --git a/drivers/net/designware.h b/drivers/net/designware.h
> > index e47101ccaf6..8c9d0190e03 100644
> > --- a/drivers/net/designware.h
> > +++ b/drivers/net/designware.h
> > @@ -247,6 +247,18 @@ struct dw_eth_dev {
> >
> >  int designware_eth_of_to_plat(struct udevice *dev);
> >  int designware_eth_probe(struct udevice *dev);
> > +
> > +/**
> > + * designware_eth_remove() - Remove the device
> > + *
> > + * Disables DMA and marks the device as remove. This must be called be=
fore
> > + * booting an OS, to ensure that DMA is inactive.
> > + *
> > + * @dev: Device to remove
> > + * Return 0 if OK, -ve on error
> > + */
> > +int designware_eth_remove(struct udevice *dev);
> > +
> >  extern const struct eth_ops designware_eth_ops;
> >
> >  struct dw_eth_pdata {
> > diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
> > index fde4aabbace..b2152f8da9b 100644
> > --- a/drivers/net/dwmac_meson8b.c
> > +++ b/drivers/net/dwmac_meson8b.c
> > @@ -145,6 +145,11 @@ static int dwmac_meson8b_probe(struct udevice *dev=
)
> >       return designware_eth_probe(dev);
> >  }
> >
> > +static int dwmac_meson8b_remove(struct udevice *dev)
> > +{
> > +     return designware_eth_remove(dev);
> > +}
> > +
> >  static const struct udevice_id dwmac_meson8b_ids[] =3D {
> >       { .compatible =3D "amlogic,meson-gxbb-dwmac", .data =3D (ulong)dw=
mac_setup_gx },
> >       { .compatible =3D "amlogic,meson-g12a-dwmac", .data =3D (ulong)dw=
mac_setup_axg },
> > @@ -158,6 +163,7 @@ U_BOOT_DRIVER(dwmac_meson8b) =3D {
> >       .of_match       =3D dwmac_meson8b_ids,
> >       .of_to_plat =3D dwmac_meson8b_of_to_plat,
> >       .probe          =3D dwmac_meson8b_probe,
> > +     .remove         =3D dwmac_meson8b_remove,
>
> There is no reason to add the dwmac_meson8b_remove function above, you
> could just use designware_eth_remove directly here.
>
> Same for remaining drivers below.

Yes, I wasn't sure which way to go on that. I'll remove them.

>
> Regards,
> Jonas
>
> >       .ops            =3D &designware_eth_ops,
> >       .priv_auto      =3D sizeof(struct dw_eth_dev),
> >       .plat_auto      =3D sizeof(struct dwmac_meson8b_plat),
> > diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
> > index 969d247b4f3..cfb37c3aa71 100644
> > --- a/drivers/net/dwmac_s700.c
> > +++ b/drivers/net/dwmac_s700.c
> > @@ -44,6 +44,11 @@ static int dwmac_s700_probe(struct udevice *dev)
> >       return designware_eth_probe(dev);
> >  }
> >
> > +static int dwmac_s700_remove(struct udevice *dev)
> > +{
> > +     return designware_eth_remove(dev);
> > +}
> > +
> >  static int dwmac_s700_of_to_plat(struct udevice *dev)
> >  {
> >       return designware_eth_of_to_plat(dev);
> > @@ -60,6 +65,7 @@ U_BOOT_DRIVER(dwmac_s700) =3D {
> >       .of_match =3D dwmac_s700_ids,
> >       .of_to_plat =3D dwmac_s700_of_to_plat,
> >       .probe  =3D dwmac_s700_probe,
> > +     .remove =3D dwmac_s700_remove,
> >       .ops    =3D &designware_eth_ops,
> >       .priv_auto      =3D sizeof(struct dw_eth_dev),
> >       .plat_auto      =3D sizeof(struct eth_pdata),
> > diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
> > index a9e2d8c0972..8e7a9975d28 100644
> > --- a/drivers/net/dwmac_socfpga.c
> > +++ b/drivers/net/dwmac_socfpga.c
> > @@ -130,6 +130,11 @@ static int dwmac_socfpga_probe(struct udevice *dev=
)
> >       return designware_eth_probe(dev);
> >  }
> >
> > +static int dwmac_socfpga_remove(struct udevice *dev)
> > +{
> > +     return designware_eth_remove(dev);
> > +}
> > +
> >  static const struct udevice_id dwmac_socfpga_ids[] =3D {
> >       { .compatible =3D "altr,socfpga-stmmac" },
> >       { }
> > @@ -141,6 +146,7 @@ U_BOOT_DRIVER(dwmac_socfpga) =3D {
> >       .of_match       =3D dwmac_socfpga_ids,
> >       .of_to_plat =3D dwmac_socfpga_of_to_plat,
> >       .probe          =3D dwmac_socfpga_probe,
> > +     .remove         =3D dwmac_socfpga_remove,
> >       .ops            =3D &designware_eth_ops,
> >       .priv_auto      =3D sizeof(struct dw_eth_dev),
> >       .plat_auto      =3D sizeof(struct dwmac_socfpga_plat),
>

Regards,
Simon
