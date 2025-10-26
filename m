Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F89CCF9E9
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 17:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13904832AD;
	Sun, 26 Oct 2025 18:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1642383623; Sun, 26 Oct 2025 18:32:37 +0100 (CET)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B54C82E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 18:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 8C21C1F8004F
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 17:32:29 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 75C57B0740B; Sun, 26 Oct 2025 17:32:27 +0000 (UTC)
Received: from shepard (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 62645B07403;
 Sun, 26 Oct 2025 17:32:25 +0000 (UTC)
Date: Sun, 26 Oct 2025 18:32:23 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jacky Chou <jacky_chou@aspeedtech.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 gss_mtk_uboot_upstream@mediatek.com
Subject: Re: [PATCH 1/1] net: phy: Do not do CL22 phy reset before ethernet
 phy driver probe
Message-ID: <aP5bJyRg-yq7PCqE@shepard>
References: <20241014070611.32040-1-SkyLake.Huang@mediatek.com>
 <3d811dec-d233-4e6d-bcc7-ac07c915e68a@mailbox.org>
 <aJJGvQpoYUWWjwrB@collins> <20251026154314.GW6688@bill-the-cat>
 <e88eceb2-7292-4888-8fbc-8022cabceb41@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HkxZnacxHsvTjEQk"
Content-Disposition: inline
In-Reply-To: <e88eceb2-7292-4888-8fbc-8022cabceb41@mailbox.org>
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


--HkxZnacxHsvTjEQk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun 26 Oct 25, 16:56, Marek Vasut wrote:
> On 10/26/25 4:43 PM, Tom Rini wrote:
> > On Tue, Aug 05, 2025 at 08:00:29PM +0200, Paul Kocialkowski wrote:
> > > Hi,
> > >=20
> > > Le Mon 14 Oct 24, 10:43, Marek Vasut a =C3=A9crit :
> > > > On 10/14/24 9:06 AM, Sky Huang wrote:
> > > > > From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> > > > >=20
> > > > > Remove unnecessary CL22 phy reset before ethernet phy driver
> > > > > probe. Lots of ethernet phys requires driver to load firmware.
> > > > > Before that, CL22 phy reset may lead to malfunction.
> > > > >=20
> > > > > Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
> > > > > ---
> > > > >    drivers/net/phy/phy.c | 2 --
> > > > >    1 file changed, 2 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> > > > > index 716a1d46111..e6fed8c41d7 100644
> > > > > --- a/drivers/net/phy/phy.c
> > > > > +++ b/drivers/net/phy/phy.c
> > > > > @@ -839,8 +839,6 @@ struct phy_device *phy_find_by_mask(struct mi=
i_dev *bus, uint phy_mask)
> > > > >    static void phy_connect_dev(struct phy_device *phydev, struct =
udevice *dev,
> > > > >    			    phy_interface_t interface)
> > > > >    {
> > > > > -	/* Soft Reset the PHY */
> > > > > -	phy_reset(phydev);
> > > > >    	if (phydev->dev && phydev->dev !=3D dev) {
> > > > >    		printf("%s:%d is connected to %s.  Reconnecting to %s\n",
> > > > >    		       phydev->bus->name, phydev->addr,
> > > >=20
> > > > This needs clarification and likely has to be handled differently. =
Removing
> > > > the reset would leave the PHY in potentially undefined state.
> > > >=20
> > > > Which PHY is affected by this ?
> > >=20
> > > Good hunch. I just bisected down to this commit as I had some issues =
with my
> > > Allwinner V3 board using the internal CL22 PHY. The symptom is that t=
he LEDS's
> > > polarity was inverted. Network still seems to work (although not test=
ed beyond
> > > ping).
> > >=20
> > > This change can have very significant consequences in general, which =
were not
> > > explored at all in the commit. This may break many boards that do rel=
y on that
> > > PHY reset, in various scenarios and for various reasons.
> > >=20
> > > I think it should be reverted as soon as possible to restore previous=
 behavior.
> >=20
> > I'm wondering if anyone has further comments here? If I do go and revert
> > this what is then going to break on the MediaTek side for example?
> Let's revert it, and if MTK stuff breaks, let's fix it properly then.

Agreed, keeping it only saves one setup but sacrifices many others. This is
definitely not right.

An immediate solution to support Mediatek would be to add a config
option (enabled by default) for the PHY reset. Or maybe this could be descr=
ibed
in the board file somehow (this is a policy decision so I don't think any
approach based on device-tree would be relevant here).

All the best,

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--HkxZnacxHsvTjEQk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmj+WycACgkQhP3B6o/u
lQwFyhAAgvYJIZQsgnjNU+uiSPloieYr4OWuXB6z0EtEUKR9yYu6nv6iwUPcgbfi
60CGkieQhg6ZwWDswlxsAL6dAH5qO2eQJ1P6Jq0MCw7smtbjy0p6aqqS5+3XOeTh
gQXdDXurEj1W52SZ9Bqlac1c2L58ay0lsYUPlwNQkHM+KoOqFKKx4ZY+6t3jCHI/
ejM/8+f5BUIaCVePV/BIIFvpdHGzOAtQ2pacsuiaglGAFOngL3IbtHuc5i638wtd
uoGaMseFuUNBFTOXBNiOc26s0SkAn5vrT8GX5N5+KaR1e8a/4KiNVGYAmLObXGZZ
B+nufFEfutg509TIlhzn/sGXM4ldwYe7Alku9GIjF4SdI6YiQhNO06dnaQiSrp3W
4JRGAFuwZKKZibAm5OIpdCEXNCVr2axlyfTOeRlde8496T4Kk75411S3g+3HTwN+
xBaBDS9FOwTU95w5x3dva5CVIV6tb7dLYgejyuOnyLN9E6PFK2FE0YZNlS1vUnbI
q1/jra+z3JSQCRWe4du1ZSTSWiOj05h2iOztl4AMQLqw0UDqjBA+DDnJIYQv6nnh
19bwWJZJ0X6qDrhKUtUXXr+s0Isvy/3BULmdcczwBS600JAMCga2GMmT75gDYNDq
4rGezKGzrcuhcVeVMEZwLssKKS/DwSBwUJ7lu07vwemPQj1rnLg=
=DFlL
-----END PGP SIGNATURE-----

--HkxZnacxHsvTjEQk--
