Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86B8C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 17:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E312C87CCB;
	Fri, 19 Jan 2024 18:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0654687CF5; Fri, 19 Jan 2024 18:35:33 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8D2D087CBF
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 18:35:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 484A31042;
 Fri, 19 Jan 2024 09:36:15 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3522C3F5A1;
 Fri, 19 Jan 2024 09:35:28 -0800 (PST)
Date: Fri, 19 Jan 2024 17:35:19 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Maxim Kiselev <bigunclemax@gmail.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, Ramon
 Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH v1] net: sun8i-emac: Add support for fixed-link phy
Message-ID: <20240119173519.19828363@donnerap.manchester.arm.com>
In-Reply-To: <CALHCpMg2atqadF4Kxt8E=+dh015sq4uN39TQbeOSWPkUkuMM8g@mail.gmail.com>
References: <20230614214405.1038301-1-bigunclemax@gmail.com>
 <20240116001735.7c48ea88@minigeek.lan>
 <CALHCpMg2atqadF4Kxt8E=+dh015sq4uN39TQbeOSWPkUkuMM8g@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue, 16 Jan 2024 19:58:56 +0300
Maxim Kiselev <bigunclemax@gmail.com> wrote:

Hi Maxim,

> =D0=B2=D1=82, 16 =D1=8F=D0=BD=D0=B2. 2024=E2=80=AF=D0=B3. =D0=B2 03:18, A=
ndre Przywara <andre.przywara@arm.com>:
> >
> > On Thu, 15 Jun 2023 00:44:06 +0300
> > Maxim Kiselev <bigunclemax@gmail.com> wrote:
> >
> > Hi Maxim,
> > =20
> > > From: Maksim Kiselev <bigunclemax@gmail.com>
> > >
> > > Based on dt-specs fixed-link doesn't require phy-handle to be used. =
=20
> >
> > Do you have such a board? =20
>=20
> Yes, I had a custom board with T113 SoC which has fixed phy eth.

So just to clarify: this board connected something like a switch directly
to the MAC, just using RMII/RGMII? And then you have a fixed-phy node in
the DT, detailing the speed and duplex parameters? Matching the fixed-phy
node description in ethernet-controller.yaml? And drivers/net/phy/fixed.c
takes care of parsing that?

> > And where is that written down? I don't see
> > it explicitly mentioned as optional in ethernet-controller.yaml or in
> > the DT spec PDF. =20
>=20
> Sorry for that commit description. I just found the similar commit, that
> fixes the same problem for zynq_gem
> 3888c8d1979289efe685fe29276aed4d4b685975 ("net: zynq_gem: Add support for
> fixed-link phy") and copied the description from there.
>=20
> > The sun8i EMAC binding lists phy-handle as required,
> > so that would need to be relaxed there then. =20
>=20
> Oh, indeed. So it will require to send dt-binding changes to Linux first.=
..
>=20
> Therefore, I think we can live without fixed-phy support for sun8i EMAC.
> At least until some device with such a configuration appears on the
> market :)

Well, I am fine with that patch if it fixes a problem for you. It looks
like requiring the phy-handle property is too strict, and just needs to be
relaxed in the binding. If I see this correctly, the driver would still
accept every valid DT, by today's and future bindings?

If you could just confirm my above assumptions, and maybe send a v2 with an
amended commit message, I would be happy to merge that patch.

Cheers,
Andre

> > > Fix driver to only read phy related setting when phy-handle is found.=
 =20
> >
> > The patch itself looks fine, we already specify -1 as the default when
> > the PHY DT node does not contain a reg property, so that looks like it
> > would work.
> >
> > Cheers,
> > Andre
> > =20
> > > Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> > > ---
> > >  drivers/net/sun8i_emac.c | 7 ++-----
> > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
> > > index 04c3274fbe..0e339d69e0 100644
> > > --- a/drivers/net/sun8i_emac.c
> > > +++ b/drivers/net/sun8i_emac.c
> > > @@ -834,11 +834,8 @@ static int sun8i_emac_eth_of_to_plat(struct udev=
ice *dev)
> > >       priv->use_internal_phy =3D false;
> > >
> > >       offset =3D fdtdec_lookup_phandle(gd->fdt_blob, node, "phy-handl=
e");
> > > -     if (offset < 0) {
> > > -             debug("%s: Cannot find PHY address\n", __func__);
> > > -             return -EINVAL;
> > > -     }
> > > -     priv->phyaddr =3D fdtdec_get_int(gd->fdt_blob, offset, "reg", -=
1);
> > > +     if (offset >=3D 0)
> > > +             priv->phyaddr =3D fdtdec_get_int(gd->fdt_blob, offset, =
"reg", -1);
> > >
> > >       pdata->phy_interface =3D dev_read_phy_mode(dev);
> > >       debug("phy interface %d\n", pdata->phy_interface); =20
> > =20
>=20
> Best wishes,
> Maksim

