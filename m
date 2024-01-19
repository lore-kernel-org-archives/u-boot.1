Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D9CC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 18:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0879187DCB;
	Fri, 19 Jan 2024 19:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QmDi7/3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB37D87DA9; Fri, 19 Jan 2024 19:11:21 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D843387CC8
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 19:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a2cea0563cbso167806566b.3
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 10:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705687879; x=1706292679; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPtHqJmd+LA3YpPiWtzpi0YeL+Ke3gD8SHfR93Ps0HI=;
 b=QmDi7/3XU6YZAoWuDGDPzYbt1d1i+AMvfBU4sX9pw7LYfMqdrUoWZ2p77oGX1O2o3z
 fsM+6r9LSh2cKuVLxeyEae2QWvN/NY16B4tA7PYTZsRs747BFDzhbppNvugdiQ2Gf9XO
 aPYdKrObgiM0+mnjvp9LgtkEunov0V7uZtyPjJWKd+MSIIS/8OZV9oBBrd9HuvfZTUOq
 I93iAJ37PEeSGjOK0aJXnKWkQONjJfmd+NBqhmzIrEyz+O//xhnropRbFhiGH5QWwhmt
 SuVHvK6X4KN38n8YM6U9OFMVKy/3epCL9JMAYqYhNul+ztPywfQrurm851aN6TW2AGKC
 y9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705687879; x=1706292679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oPtHqJmd+LA3YpPiWtzpi0YeL+Ke3gD8SHfR93Ps0HI=;
 b=BM+aZ9BoB6QKOkwH87tdHs4qBqSFlI9UC9SpXBujh6byqQafpHfMabPUK9LtQA+6/G
 ozC/+Z15Gx0XJdewoI3PQTB8h5MBMm2eXYOSl5PJkrWCSefoSPe0bwf9CHsggiGR4kEk
 xA8oZbX70nH+1toJyKzeOwk2Cj0OhUbqeCokrwgi0nkoluFR6PX0thEbBYD9564kCTc9
 dh48MU2sNO9jZ8mxSljPFNVh7u94ntylwbr8VwTD545cTQn3kV5SZW9mvUPRDutsopas
 jZezoHU0RJD3Q91GCkyZ71kvsZrDrLqpYJkMgC4pomBp1w8RMwqTvJy30/aEbabWMZpn
 ZtBQ==
X-Gm-Message-State: AOJu0YxbMcRjhGlQSRMxolhhntc1JBpxCmPR/K04o+jVFAhkcZHzwbkw
 A5nlL5qU1JwBkuvEsaPZ5HWJKKYAcp40j9Ry4lwkSf6NnGQPh87hJjH1VWl3ZGBFFEkYoCB6KN5
 GGem/pSXHQctgw2lggcrXWmbZDQ0=
X-Google-Smtp-Source: AGHT+IG/4vrKOQHMGsezBRK/3UnkLqxf7kQx7xDtozw4dAAVTd/sqqIUq7qydmbhsywTCYWpbbMIcki0uTDPjHhzFls=
X-Received: by 2002:a17:907:a704:b0:a2c:4fc6:15d9 with SMTP id
 vw4-20020a170907a70400b00a2c4fc615d9mr117880ejc.20.1705687878993; Fri, 19 Jan
 2024 10:11:18 -0800 (PST)
MIME-Version: 1.0
References: <20230614214405.1038301-1-bigunclemax@gmail.com>
 <20240116001735.7c48ea88@minigeek.lan>
 <CALHCpMg2atqadF4Kxt8E=+dh015sq4uN39TQbeOSWPkUkuMM8g@mail.gmail.com>
 <20240119173519.19828363@donnerap.manchester.arm.com>
In-Reply-To: <20240119173519.19828363@donnerap.manchester.arm.com>
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Fri, 19 Jan 2024 21:11:07 +0300
Message-ID: <CALHCpMiWc4ZNS9yUnc-pHLxb_t9Ydy3Nsv91jcq13k1i2QQz5w@mail.gmail.com>
Subject: Re: [PATCH v1] net: sun8i-emac: Add support for fixed-link phy
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
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

Hi Andre,

=D0=BF=D1=82, 19 =D1=8F=D0=BD=D0=B2. 2024=E2=80=AF=D0=B3. =D0=B2 20:35, And=
re Przywara <andre.przywara@arm.com>:
>
> On Tue, 16 Jan 2024 19:58:56 +0300
> Maxim Kiselev <bigunclemax@gmail.com> wrote:
>
> Hi Maxim,
>
> > =D0=B2=D1=82, 16 =D1=8F=D0=BD=D0=B2. 2024=E2=80=AF=D0=B3. =D0=B2 03:18,=
 Andre Przywara <andre.przywara@arm.com>:
> > >
> > > On Thu, 15 Jun 2023 00:44:06 +0300
> > > Maxim Kiselev <bigunclemax@gmail.com> wrote:
> > >
> > > Hi Maxim,
> > >
> > > > From: Maksim Kiselev <bigunclemax@gmail.com>
> > > >
> > > > Based on dt-specs fixed-link doesn't require phy-handle to be used.
> > >
> > > Do you have such a board?
> >
> > Yes, I had a custom board with T113 SoC which has fixed phy eth.
>
> So just to clarify: this board connected something like a switch directly
> to the MAC, just using RMII/RGMII? And then you have a fixed-phy node in
> the DT, detailing the speed and duplex parameters? Matching the fixed-phy
> node description in ethernet-controller.yaml? And drivers/net/phy/fixed.c
> takes care of parsing that?

Yes, you are absolutely right. The T113s connected directly to the switch p=
ort
via RMII interface. Here is the part of DT, that describes that configurati=
on

&emac {
       pinctrl-names =3D "default";
       pinctrl-0 =3D <&rmii_pg_pins>;
       phy-mode =3D "rmii";
       snps,reset-gpio =3D <&pio 4 12 GPIO_ACTIVE_LOW>; /* PE12 */
       allwinner,tx-delay-ps =3D <700>;
       allwinner,rx-delay-ps =3D <3100>;

       fixed-link {
               speed =3D <100>;
               full-duplex;
       };
};

>
> > > And where is that written down? I don't see
> > > it explicitly mentioned as optional in ethernet-controller.yaml or in
> > > the DT spec PDF.
> >
> > Sorry for that commit description. I just found the similar commit, tha=
t
> > fixes the same problem for zynq_gem
> > 3888c8d1979289efe685fe29276aed4d4b685975 ("net: zynq_gem: Add support f=
or
> > fixed-link phy") and copied the description from there.
> >
> > > The sun8i EMAC binding lists phy-handle as required,
> > > so that would need to be relaxed there then.
> >
> > Oh, indeed. So it will require to send dt-binding changes to Linux firs=
t...
> >
> > Therefore, I think we can live without fixed-phy support for sun8i EMAC=
.
> > At least until some device with such a configuration appears on the
> > market :)
>
> Well, I am fine with that patch if it fixes a problem for you. It looks
> like requiring the phy-handle property is too strict, and just needs to b=
e
> relaxed in the binding. If I see this correctly, the driver would still
> accept every valid DT, by today's and future bindings?
>
> If you could just confirm my above assumptions, and maybe send a v2 with =
an
> amended commit message, I would be happy to merge that patch.

Sure, I'll fix the commit description and send v2 asap.

> Cheers,
> Andre
>
> > > > Fix driver to only read phy related setting when phy-handle is foun=
d.
> > >
> > > The patch itself looks fine, we already specify -1 as the default whe=
n
> > > the PHY DT node does not contain a reg property, so that looks like i=
t
> > > would work.
> > >
> > > Cheers,
> > > Andre
> > >
> > > > Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> > > > ---
> > > >  drivers/net/sun8i_emac.c | 7 ++-----
> > > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
> > > > index 04c3274fbe..0e339d69e0 100644
> > > > --- a/drivers/net/sun8i_emac.c
> > > > +++ b/drivers/net/sun8i_emac.c
> > > > @@ -834,11 +834,8 @@ static int sun8i_emac_eth_of_to_plat(struct ud=
evice *dev)
> > > >       priv->use_internal_phy =3D false;
> > > >
> > > >       offset =3D fdtdec_lookup_phandle(gd->fdt_blob, node, "phy-han=
dle");
> > > > -     if (offset < 0) {
> > > > -             debug("%s: Cannot find PHY address\n", __func__);
> > > > -             return -EINVAL;
> > > > -     }
> > > > -     priv->phyaddr =3D fdtdec_get_int(gd->fdt_blob, offset, "reg",=
 -1);
> > > > +     if (offset >=3D 0)
> > > > +             priv->phyaddr =3D fdtdec_get_int(gd->fdt_blob, offset=
, "reg", -1);
> > > >
> > > >       pdata->phy_interface =3D dev_read_phy_mode(dev);
> > > >       debug("phy interface %d\n", pdata->phy_interface);
> > >
> >
> > Best wishes,
> > Maksim
>

Best wishes,
Maksim
