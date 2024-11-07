Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3D9D43358
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 12:27:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C062589258;
	Thu,  7 Nov 2024 13:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCB9889259; Thu,  7 Nov 2024 13:27:49 +0100 (CET)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7141F89229
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 13:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id D4F201F0004D
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 12:27:40 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 016CCA451B0; Thu,  7 Nov 2024 12:27:37 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id AB114A451AD;
 Thu,  7 Nov 2024 12:27:36 +0000 (UTC)
Date: Thu, 7 Nov 2024 13:27:34 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@cherry.de>, u-boot@lists.denx.de,
 Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH next v2 4/4] rockchip: rk3399: move sysreset-gpio logic
 to TPL
Message-ID: <ZyyyNttkdcdQmmCw@collins>
References: <20241106-rk3399-sysreset-gpio-tpl-v2-0-22aa82189eb6@cherry.de>
 <20241106-rk3399-sysreset-gpio-tpl-v2-4-22aa82189eb6@cherry.de>
 <149361d4-4cbb-4007-b00f-6b4efbd7978f@rock-chips.com>
 <5cfa0fbe-5003-4da1-9933-7664da07cd4d@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="p/oQfHhcbvMwx+Y6"
Content-Disposition: inline
In-Reply-To: <5cfa0fbe-5003-4da1-9933-7664da07cd4d@cherry.de>
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


--p/oQfHhcbvMwx+Y6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Thu 07 Nov 24, 12:04, Quentin Schulz a =C3=A9crit :
> On 11/7/24 8:14 AM, Kever Yang wrote:
> > Yes, this movement is reasonable and needed for this workaround,
> > although still not
> >=20
> > understand why puma board need this.
>=20
> Me neither, this predates me joining the company, c.f.:
> https://source.denx.de/u-boot/u-boot/-/commit/ae0d33a7291a164a11ae034bcf4=
f71226b2bef48
> https://source.denx.de/u-boot/u-boot/-/commit/5f104178bf713615dc404fdfcf0=
fb53d89c66a07
> https://source.denx.de/u-boot/u-boot/-/commit/07586ee4322abca01db52624b92=
5e5218538f259
>=20
> What I can tell you is that it seems this is required as Paul (in Cc) is
> trying to add support for it for the Firefly ROC-RK3399-PC[1] and the
> ROCKPro64[2], so it seems it's useful for **some** purpose.

The initial issue I was seeing was that one of the MMC controllers showed s=
ome
errors and failed to read data after reboot, while it always worked on cold
boot. With this feature enabled, it worked reliably after reboot.

I didn't investigate exactly which component (maybe clocks, maybe regulator=
s)
caused the problem, but it clearly wasn't correctly reset.

Cheers,

Paul

> [1]
> https://lore.kernel.org/u-boot/20240926183111.1324284-1-paulk@sys-base.io/
> [2]
> https://lore.kernel.org/u-boot/20240926183111.1324284-2-paulk@sys-base.io/
>=20
> > > - faster boot time as we don't need to reach SPL to be able to reset =
the
> > > =C2=A0=C2=A0 system on a condition we know is already met in TPL,
> > > - have less code to be impacted by the issue this system reset works
> > > =C2=A0=C2=A0 around (that is, "unclean" SoC registers after a reboot),
> > > - less confusion around the reason for restarting. Indeed when done f=
rom
> > > =C2=A0=C2=A0 SPL, the following log can be observed:
> > >=20
> > > """
> > > U-Boot TPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 15:31=
:45)
> > > Channel 0: DDR3, 666MHz
> > > BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D16 CS=3D1 Die BW=3D16 Size=3D2048MB
> > > Channel 1: DDR3, 666MHz
> > > BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D16 CS=3D1 Die BW=3D16 Size=3D2048MB
> > > 256B stride
> > > Trying to boot from BOOTROM
> > > Returning to boot ROM...
> > >=20
> > > U-Boot SPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 -
> > > 15:31:45 +0100)
> > > Trying to boot from MMC2
> > >=20
> > > U-Boot TPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 15:31=
:45)
> > > """
> > So with this patch set, we can see the TPL banner twice ?
> >=20
> >=20
> > PS: We are able to merge to master instead of next before next branch is
> > open, because we still have
> >=20
> > enough time to debug before next release.
> >=20
>=20
> My understanding is that once -rc1 is out, we should only do bug fixing in
> master. BUT at the same time, next branch isn't actually open until -rc2.
>=20
> Up to you! It's not really urgent, Puma was migrated to TPL only in v2023=
=2E01
> and we've lived without sysreset-gpio in TPL since then :)
>=20
> Cheers,
> Quentin

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Specialist in multimedia, graphics and embedded hardware support with Linux.

--p/oQfHhcbvMwx+Y6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmcssjYACgkQhP3B6o/u
lQxioA//XkD6jVaNI4qIWlfM9d81nv6gKCL0wS/m07xZoaK9gbhNab9i6Abo+1+K
YrNXcIOIqqluux/xHN1OFPzciQ6V2YSQC+Rj8aa2w2jUPAs8PYBMexpCeWEdcow/
R8qwBMnOmeQLRa9FLP8MFKvArmUPY88wgo/Z52x3Hb5f0Kjxm+g5e2T8FMtjdF9e
MRTq+Xej2u1j/1Z/aXoQqIGE8yz3Ipz2c3MzqskTfAzAyS3tug2Bv7Sy8uQY4ryR
WDsRweBU38yUhUo3QZky4+dw6GuIBPFNpbmFQWIV/g1Zye6y/ZrL5cF6n+C1qoR9
I165MImX1LH7MYKMg37FrshmXJrIrUIC4ChO1pzgwjI8dbQz57gRBk0SSV8nwcQ4
dKqNRvuDYGh5mJ82dRCQAbWH7YKc6fByPiyYWuz+8ootF+/NCl8RSJaw4Q2skCJb
gRErgGDb/YUyc6F9JRx80n2VpMWBr2ke3OHMClOGYZTcE2Aq25QqT8vgv7prP1sk
NxYaypNyadJOqvxUI/EiWsbVl++J2nmxidctfSleQ90zrNtXyhU8kqINE7pUt8OX
0LEZhBbRw9KYKjAtFTJaWJBOwz48ea/bWduViPNYhn4x7NI9gWvEUW0FLWYvrozR
AoKceMwqV2q1dJCGSEcb2SOX4eOJglodcJLBM6BaaT+0z3ypG9U=
=+Lco
-----END PGP SIGNATURE-----

--p/oQfHhcbvMwx+Y6--
