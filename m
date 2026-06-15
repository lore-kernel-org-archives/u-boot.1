Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9B1CD98C7
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 10:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90A1C846B0;
	Mon, 15 Jun 2026 12:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB1D584704; Mon, 15 Jun 2026 12:31:08 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57B99846A4
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 9CD8E37002F4
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 10:31:02 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 685C5B45A6E; Mon, 15 Jun 2026 10:31:01 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 54EEAB45A68;
 Mon, 15 Jun 2026 10:31:00 +0000 (UTC)
Date: Mon, 15 Jun 2026 12:30:57 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 =?utf-8?B?QW5kcsOp?= Przywara <andre.przywara@arm.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>
Subject: Re: [PATCH] ARM: fdt: copy TF-A reserved memory into fdt passed to
 Linux
Message-ID: <ai_UYZEnjO4H2cUK@collins>
References: <20260613204202.2360922-1-alexander.sverdlin@gmail.com>
 <ai6yjsgw-3hnNgNM@collins>
 <b0ff98144d34468c133cd62935afc546135b47ec.camel@gmail.com>
 <ai8X0ovb5V1zTJR9@collins>
 <95c289a3e64993c54b1e21737a74e794f90b9c13.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BFr0segkraD0FJfX"
Content-Disposition: inline
In-Reply-To: <95c289a3e64993c54b1e21737a74e794f90b9c13.camel@gmail.com>
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


--BFr0segkraD0FJfX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

Le Mon 15 Jun 26, 00:08, Alexander Sverdlin a =C3=A9crit :
> Hi Paul,
>=20
> On Sun, 2026-06-14 at 23:06 +0200, Paul Kocialkowski wrote:
> > > > But another thing we do overwrite current is the cpu idle states, w=
hich
> > > > are added by fdt_add_cpu_idle_states in tf-a. These are only set wh=
en the
> > > > SCP firmware is available (which is checked at run-time) and they a=
re
> > > > never propagated to the final device-tree. Including the definitions
> > > > statically would result in cpu idle calls done even without the SCP
> > > > firmware, which would probably fail (although maybe some states can
> > > > still be supported).
> > >=20
> > > Do you refer to some unmerged code? Didn't find it in the current TF-A
> > > sources...
> >=20
> > fdt_add_cpu_idle_states is in common/fdt_fixup.c and it is called by the
> > common allwinner code in plat/allwinner/common/sunxi_prepare_dtb.c based
> > on the sunxi_psci_is_scpi check (which currently always returns false
> > for A133).
>=20
> sorry, I misunderstood you initially, I though there are some data struct=
ures
> of the SCP firmware which are being overwritten by Linux, but it turns ou=
t,
> you refer to idle-states node and compatible =3D "arm,idle-state" subnode=
s...
> But contrary to /reserved-memory nodes for TF-A, these are fixed for a SoC
> model, even if you'd like to load SCP firmware at a different address, ri=
ght?

The nodes are only inserted by TF-A when the SCP firmware is present.
They should not be there without it so we cannot just have them always
present in the static device-tree declarations.

> It looks to me that all other machines/SoCs do define this stuff statical=
ly
> in the Linux DT.

I guess most of them don't consider the SCP firmware as optional but
make it a hard requirement. For Allwinner it is optional (and it's very
nice that way).

> I have a feeling, that idle-states node is more like a "contract" or an A=
PI
> between FW and Linux and is supposed to change less frequently, while loa=
ding
> TF-A to a completely different address would be transparent to Linux, as =
long
> as we properly copy /reserved-memory nodes.

You could see it that way yes.

All the best,

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--BFr0segkraD0FJfX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmov1GEACgkQhP3B6o/u
lQzcMg/+PAcFlb9UEi8FmcuBw4OOdnil6IGxSkVflb0BpnTh9wOTCen9DvZ5yLrM
DgjFtepqbvtj9alrKv/krVrotGhMeNFFEc3K2cs4Cq6GPqx3ARutDb5GDJF4LgjP
VHLwshGpfVIeBUhNF1bVIb/CS/RyIOysr5GXXmhuSwH2ddF+u9p5FypeToRdgOwp
TcAh+qTLKgtXt7XX67qY6BXDkJTQXD/ws+LsMUZZV8Cb17a8Chh5Bn7gfB4XWf5+
l0LvAOA6nYfN/9fMDvkH3Mn/cWUvul3UFsBBk0q3uuCkXLh0NtUKHZ/Hl5tGWxTo
YbAPptS3+EOLPAjObLA2di6ynBnerm+t+7dM9VlMhxK+5ZPkPFg5V7NKoDioqmFD
n4kD95LIKEBjc32CSc6aiLPNwJ1mtkx02TrPdgdacZzaWc52ZfPSFdWkVGyhGmY6
rjh/ELHRYkG67DzOeAzdkR5B4vUoRyn0eMfpb/1elgSimHvvAtZUmeJcxPELFXeQ
RHXix22ZXWANbGSEfkeaQdHpEtEjqUJk8Brdszjo4E5VABX+5W8lIS9DJc6HWc1Q
Z9diCKI2CFo/4wqhSqh8M5oAHSZVg8QDj1ii9yiy7IEdyZXcWAJAQiBLqYUOUK1i
tT9aViA2w2rMyzm0PdMMJlIjOkRKoQWd/aN7BKkAGXbiYCJYmwU=
=4HUt
-----END PGP SIGNATURE-----

--BFr0segkraD0FJfX--
