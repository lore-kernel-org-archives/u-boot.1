Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3381D33A22
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 18:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18A4B88C44;
	Tue,  5 Nov 2024 19:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 888B588ED9; Tue,  5 Nov 2024 19:45:12 +0100 (CET)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3204E88A0A
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 19:45:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 86B361F0004D
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 18:45:08 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id D21D0A44AF2; Tue,  5 Nov 2024 18:45:07 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 8DB96A44AF0;
 Tue,  5 Nov 2024 18:45:06 +0000 (UTC)
Date: Tue, 5 Nov 2024 19:45:04 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@cherry.de>, u-boot@lists.denx.de,
 Paul Kocialkowski <contact@paulk.fr>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH next 0/5] rockchip: rk3399: allow to trigger sysreset in
 TPL
Message-ID: <ZypnsKWG0d1gplk8@collins>
References: <20241105-rk3399-sysreset-gpio-tpl-v1-0-12caff07a4e4@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QFjIwKd+VfnrM6zX"
Content-Disposition: inline
In-Reply-To: <20241105-rk3399-sysreset-gpio-tpl-v1-0-12caff07a4e4@cherry.de>
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


--QFjIwKd+VfnrM6zX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Tue 05 Nov 24, 16:36, Quentin Schulz a =C3=A9crit :
> A sysreset-gpio can be provided in an RK3399 platform's Device Tree and
> if U-Boot detects a "warm" boot was done, it'll toggle that GPIO to
> perform a reset of the PMIC, essentially forcing a cold boot to make
> sure there are no non-default values in SoC registers.
>=20
> For now, this was only supported in SPL, probably because when this was
> implemented RK3399 (and specifically Puma) didn't have TPL support so
> SPL was the earliest stage. Now that most RK3399 boards (and
> specifically Puma) have TPL enabled, it makes sense to add support for
> triggering this sysreset from it. It brings the following advantages:
> - faster boot time as we don't need to reach SPL to be able to reset the
>   system on a condition we know is already met in TPL,
> - have less code to be impacted by the issue this system reset works
>   around (that is, "unclean" SoC registers after a reboot),
> - less confusion around the reason for restarting. Indeed when done from
>   SPL, the following log can be observed:

Thanks for doing this, I think it makes a lot of sense to have it in the TP=
L!

Cheers,

Paul

> """
> U-Boot TPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 15:31:45)
> Channel 0: DDR3, 666MHz
> BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D16 CS=3D1 Die BW=3D16 Size=3D2048MB
> Channel 1: DDR3, 666MHz
> BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D16 CS=3D1 Die BW=3D16 Size=3D2048MB
> 256B stride
> Trying to boot from BOOTROM
> Returning to boot ROM...
>=20
> U-Boot SPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 15:31:45 =
+0100)
> Trying to boot from MMC2
>=20
> U-Boot TPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 15:31:45)
> """
>=20
> possibly hinting at an issue within the SPL when loading the fitImage
> from MMC2 instead of the normal course of events (a system reset).
>=20
> For this to be possible, the sysreset function is adapted to be able to
> run in SPL and TPL by checking the appropriate symbols and a weak
> callback is added in the TPL main C code so that we can hook this
> sysreset function within the TPL code path.
>=20
> @Cc Paul since he's trying to add support for this sysreset to the
> Firefly ROC-RK3399-PC[1] and Pine64 ROCKPro64[2]. You'll want to have
> gpio1 with boopth-pre-sram though so it makes it to the TPL DTB.
>=20
> [1] https://lore.kernel.org/u-boot/20240926183111.1324284-1-paulk@sys-bas=
e.io/
> [2] https://lore.kernel.org/u-boot/20240926183111.1324284-2-paulk@sys-bas=
e.io/
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (5):
>       pinctrl: rockchip: allow to build for TPL
>       rockchip: rk3399: merge CRU check within rk3399_force_power_on_reset
>       rockchip: tpl: allow to call board/SoC-specific code before DRAM in=
it
>       rockchip: rk3399: allow to handle sysreset-gpio in TPL
>       rockchip: configs: puma-rk3399: do the system reset in TPL
>=20
>  arch/arm/mach-rockchip/rk3399/rk3399.c | 58 +++++++++++++++++++---------=
------
>  arch/arm/mach-rockchip/tpl.c           |  6 ++++
>  configs/puma-rk3399_defconfig          |  3 ++
>  drivers/pinctrl/Kconfig                |  8 +++++
>  drivers/pinctrl/rockchip/Kconfig       |  7 ++++
>  5 files changed, 56 insertions(+), 26 deletions(-)
> ---
> base-commit: 56accc56b9aab87ef4809ccc588e1257969cd271
> change-id: 20241105-rk3399-sysreset-gpio-tpl-50620781cdd9
>=20
> Best regards,
> --=20
> Quentin Schulz <quentin.schulz@cherry.de>
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Specialist in multimedia, graphics and embedded hardware support with Linux.

--QFjIwKd+VfnrM6zX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmcqZ7AACgkQhP3B6o/u
lQznAw/+O73vDVc3Aapfea3uxT8yoqQO3M7ONS7EQPLhmCvUsSeMpi5GSmJyWsZb
Z9p/+zPaLg/ogh3zGHdH3Viiilx7k0GMAgxrkNYejztV3us7ufF0CYP5St+3VASb
cXJrwCziKOa+S6hK4xPsHMUb4U1vLEWUgbklSfm7t89o0L1oGgeYGRQavje1OLMy
gn6g4b0VaYcpLZrVRXRk7E4kuuTl+OC3NFonWWO3bVjiDglNGr5/bdQdIhbcQmcU
pDBt8Ybv6tIYsnG+ISHgr5J68ygpomAS+H4ePMMg2f4C77wHgIA1ujPmD27eTXLo
5hcjcbxXD7zwfNlyKDSeDPm+kXdnKwTzGzvmyzXOP+fmodDVGYb/7GD77FmEkld1
/nVhm6SHyl4O730koS6CEaaqH3iZEw0slXF7MPpSNiU5Y5Ex+NjJb+TnzD7g5Tf8
xt+VSADO3xHzfyrn8eVJLLjlVjVyg624DQ0qtEwxkALmAWD/n7J8a33+zwlD0CWl
Kwa1LfCz0DKsjknr7nblnLcpWfGgSZIspqloQ6edNudoKLccTkLEhbV5T4vxDNYW
mQmJ3YLZ4M1DvR21GAqPXBG4qFO6LwL52BWz5sKkrpOjuEQFk/PoMuUjqBOxx0Hd
9HpCxFngb0gyHdjB+RT4Cj5PLejkY6cyum1OAx6SME3PSkkCHRg=
=IXA3
-----END PGP SIGNATURE-----

--QFjIwKd+VfnrM6zX--
