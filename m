Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBDEC47DAF
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 21:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BA4687C82;
	Fri, 19 Jan 2024 22:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8C4087C9B; Fri, 19 Jan 2024 22:57:01 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4373487BC5
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 22:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 232EAFEC;
 Fri, 19 Jan 2024 13:57:44 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39A673F766;
 Fri, 19 Jan 2024 13:56:57 -0800 (PST)
Date: Fri, 19 Jan 2024 21:56:10 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Maxim Kiselev <bigunclemax@gmail.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, Ramon
 Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH v1] net: sun8i-emac: Add support for fixed-link phy
Message-ID: <20240119215610.3f5f467d@minigeek.lan>
In-Reply-To: <CALHCpMiWc4ZNS9yUnc-pHLxb_t9Ydy3Nsv91jcq13k1i2QQz5w@mail.gmail.com>
References: <20230614214405.1038301-1-bigunclemax@gmail.com>
 <20240116001735.7c48ea88@minigeek.lan>
 <CALHCpMg2atqadF4Kxt8E=+dh015sq4uN39TQbeOSWPkUkuMM8g@mail.gmail.com>
 <20240119173519.19828363@donnerap.manchester.arm.com>
 <CALHCpMiWc4ZNS9yUnc-pHLxb_t9Ydy3Nsv91jcq13k1i2QQz5w@mail.gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Fri, 19 Jan 2024 21:11:07 +0300
Maxim Kiselev <bigunclemax@gmail.com> wrote:

Hi Maxim,

> =D0=BF=D1=82, 19 =D1=8F=D0=BD=D0=B2. 2024=E2=80=AF=D0=B3. =D0=B2 20:35, A=
ndre Przywara <andre.przywara@arm.com>:
> >
> > On Tue, 16 Jan 2024 19:58:56 +0300
> > Maxim Kiselev <bigunclemax@gmail.com> wrote:
> >
> > Hi Maxim,
> > =20
> > > =D0=B2=D1=82, 16 =D1=8F=D0=BD=D0=B2. 2024=E2=80=AF=D0=B3. =D0=B2 03:1=
8, Andre Przywara <andre.przywara@arm.com>: =20
> > > >
> > > > On Thu, 15 Jun 2023 00:44:06 +0300
> > > > Maxim Kiselev <bigunclemax@gmail.com> wrote:
> > > >
> > > > Hi Maxim,
> > > > =20
> > > > > From: Maksim Kiselev <bigunclemax@gmail.com>
> > > > >
> > > > > Based on dt-specs fixed-link doesn't require phy-handle to be use=
d. =20
> > > >
> > > > Do you have such a board? =20
> > >
> > > Yes, I had a custom board with T113 SoC which has fixed phy eth. =20
> >
> > So just to clarify: this board connected something like a switch direct=
ly
> > to the MAC, just using RMII/RGMII? And then you have a fixed-phy node in
> > the DT, detailing the speed and duplex parameters? Matching the fixed-p=
hy
> > node description in ethernet-controller.yaml? And drivers/net/phy/fixed=
.c
> > takes care of parsing that? =20
>=20
> Yes, you are absolutely right. The T113s connected directly to the switch=
 port
> via RMII interface. Here is the part of DT, that describes that configura=
tion

Excellent, thanks for the confirmation!

Looking forward to v2!

Cheers,
Andre

> &emac {
>        pinctrl-names =3D "default";
>        pinctrl-0 =3D <&rmii_pg_pins>;
>        phy-mode =3D "rmii";
>        snps,reset-gpio =3D <&pio 4 12 GPIO_ACTIVE_LOW>; /* PE12 */
>        allwinner,tx-delay-ps =3D <700>;
>        allwinner,rx-delay-ps =3D <3100>;
>=20
>        fixed-link {
>                speed =3D <100>;
>                full-duplex;
>        };
> };
>=20
> > =20
> > > > And where is that written down? I don't see
> > > > it explicitly mentioned as optional in ethernet-controller.yaml or =
in
> > > > the DT spec PDF. =20
> > >
> > > Sorry for that commit description. I just found the similar commit, t=
hat
> > > fixes the same problem for zynq_gem
> > > 3888c8d1979289efe685fe29276aed4d4b685975 ("net: zynq_gem: Add support=
 for
> > > fixed-link phy") and copied the description from there.
> > > =20
> > > > The sun8i EMAC binding lists phy-handle as required,
> > > > so that would need to be relaxed there then. =20
> > >
> > > Oh, indeed. So it will require to send dt-binding changes to Linux fi=
rst...
> > >
> > > Therefore, I think we can live without fixed-phy support for sun8i EM=
AC.
> > > At least until some device with such a configuration appears on the
> > > market :) =20
> >
> > Well, I am fine with that patch if it fixes a problem for you. It looks
> > like requiring the phy-handle property is too strict, and just needs to=
 be
> > relaxed in the binding. If I see this correctly, the driver would still
> > accept every valid DT, by today's and future bindings?
> >
> > If you could just confirm my above assumptions, and maybe send a v2 wit=
h an
> > amended commit message, I would be happy to merge that patch. =20
>=20
> Sure, I'll fix the commit description and send v2 asap.
>=20
> > Cheers,
> > Andre
> > =20
> > > > > Fix driver to only read phy related setting when phy-handle is fo=
und. =20
> > > >
> > > > The patch itself looks fine, we already specify -1 as the default w=
hen
> > > > the PHY DT node does not contain a reg property, so that looks like=
 it
> > > > would work.
> > > >
> > > > Cheers,
> > > > Andre
> > > > =20
> > > > > Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> > > > > ---
> > > > >  drivers/net/sun8i_emac.c | 7 ++-----
> > > > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
> > > > > index 04c3274fbe..0e339d69e0 100644
> > > > > --- a/drivers/net/sun8i_emac.c
> > > > > +++ b/drivers/net/sun8i_emac.c
> > > > > @@ -834,11 +834,8 @@ static int sun8i_emac_eth_of_to_plat(struct =
udevice *dev)
> > > > >       priv->use_internal_phy =3D false;
> > > > >
> > > > >       offset =3D fdtdec_lookup_phandle(gd->fdt_blob, node, "phy-h=
andle");
> > > > > -     if (offset < 0) {
> > > > > -             debug("%s: Cannot find PHY address\n", __func__);
> > > > > -             return -EINVAL;
> > > > > -     }
> > > > > -     priv->phyaddr =3D fdtdec_get_int(gd->fdt_blob, offset, "reg=
", -1);
> > > > > +     if (offset >=3D 0)
> > > > > +             priv->phyaddr =3D fdtdec_get_int(gd->fdt_blob, offs=
et, "reg", -1);
> > > > >
> > > > >       pdata->phy_interface =3D dev_read_phy_mode(dev);
> > > > >       debug("phy interface %d\n", pdata->phy_interface); =20
> > > > =20
> > >
> > > Best wishes,
> > > Maksim =20
> > =20
>=20
> Best wishes,
> Maksim

