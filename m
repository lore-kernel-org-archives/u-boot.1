Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF32C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 18:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F155A841CF;
	Tue,  5 Aug 2025 20:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F162A8420C; Tue,  5 Aug 2025 20:00:44 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B853841CC
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 20:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 2D0EC1F00050
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 18:00:34 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id E4DBFB011F1; Tue,  5 Aug 2025 18:00:32 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id DA122B011EA;
 Tue,  5 Aug 2025 18:00:31 +0000 (UTC)
Date: Tue, 5 Aug 2025 20:00:29 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Sky Huang <SkyLake.Huang@mediatek.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Eugeniu Rosca <erosca@de.adit-jv.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jacky Chou <jacky_chou@aspeedtech.com>, u-boot@lists.denx.de,
 gss_mtk_uboot_upstream@mediatek.com
Subject: Re: [PATCH 1/1] net: phy: Do not do CL22 phy reset before ethernet
 phy driver probe
Message-ID: <aJJGvQpoYUWWjwrB@collins>
References: <20241014070611.32040-1-SkyLake.Huang@mediatek.com>
 <3d811dec-d233-4e6d-bcc7-ac07c915e68a@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RtJXya13LO+7Pt7O"
Content-Disposition: inline
In-Reply-To: <3d811dec-d233-4e6d-bcc7-ac07c915e68a@mailbox.org>
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


--RtJXya13LO+7Pt7O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Mon 14 Oct 24, 10:43, Marek Vasut a =C3=A9crit :
> On 10/14/24 9:06 AM, Sky Huang wrote:
> > From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> >=20
> > Remove unnecessary CL22 phy reset before ethernet phy driver
> > probe. Lots of ethernet phys requires driver to load firmware.
> > Before that, CL22 phy reset may lead to malfunction.
> >=20
> > Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
> > ---
> >   drivers/net/phy/phy.c | 2 --
> >   1 file changed, 2 deletions(-)
> >=20
> > diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> > index 716a1d46111..e6fed8c41d7 100644
> > --- a/drivers/net/phy/phy.c
> > +++ b/drivers/net/phy/phy.c
> > @@ -839,8 +839,6 @@ struct phy_device *phy_find_by_mask(struct mii_dev =
*bus, uint phy_mask)
> >   static void phy_connect_dev(struct phy_device *phydev, struct udevice=
 *dev,
> >   			    phy_interface_t interface)
> >   {
> > -	/* Soft Reset the PHY */
> > -	phy_reset(phydev);
> >   	if (phydev->dev && phydev->dev !=3D dev) {
> >   		printf("%s:%d is connected to %s.  Reconnecting to %s\n",
> >   		       phydev->bus->name, phydev->addr,
>=20
> This needs clarification and likely has to be handled differently. Removi=
ng
> the reset would leave the PHY in potentially undefined state.
>=20
> Which PHY is affected by this ?

Good hunch. I just bisected down to this commit as I had some issues with my
Allwinner V3 board using the internal CL22 PHY. The symptom is that the LED=
S's
polarity was inverted. Network still seems to work (although not tested bey=
ond
ping).

This change can have very significant consequences in general, which were n=
ot
explored at all in the commit. This may break many boards that do rely on t=
hat
PHY reset, in various scenarios and for various reasons.

I think it should be reverted as soon as possible to restore previous behav=
ior.

All the best,

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--RtJXya13LO+7Pt7O
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmiSRr0ACgkQhP3B6o/u
lQywYA/9E8yRLbH5IkDbJhAnDKKoqi1MEwJtAZwACa7qHSFx4YC/uuKFxttc4msC
bN9xnDiu2oMe3o1FEXuqB62U0JDVnwvzcJZ2b0MHGpsV4WrEa4/Bqx3M60RL3Qq6
Hb2/5x9UOX5c9tx9L0seutoz/u6H4r0VbkX6H+m6CwGUjfqNWKcUpsAODKzLzRMR
zG/gWahTd9E70spjCPT03WpU8BD3/7jb6wPwALhXeENDEFEE4Im5PunaJ5x8S7x0
4U2+k72hJs0CCB2ga8HVx2hmLJLgu13RRTj6w+wMLFRZuCiEB9fMor7RKDit57F/
vRB+UqPz8xzv/6t2dgdchfsDZRmIW3b7nb3a0Y/tB8IcNewIMnjLjJPl+DYXHbtb
rgqCkK4D4KcvJvt60qkglrYyhWH6D+AbqlUHY/yV6GOZUCnRDgdYglI65SuVPm1w
SpmDryOCL+q8mW+vp8q0ynGtDbBH4JSDOQlPXjwPqaYwM3Ef2/fhfvKU6hFYxC2V
gec4lsRAsuXXsYFedNFvbUlo52B31411xsRJklzjq6gy/daHcLzlTgOKwccVh60d
OpAJ7YUjn3oRW0TZbcyO1842vzK0HkHHeN79XOHMFRyuIdbpE/dGECcokbNYvpv4
Jfa1ANnFeSWg0ue71y0/xcgMDG17e/LxdhZEII8+J2i6nfyzFcQ=
=ExbK
-----END PGP SIGNATURE-----

--RtJXya13LO+7Pt7O--
