Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E66C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 18:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A9E81E72;
	Tue,  3 Jun 2025 20:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8D7C82C15; Tue,  3 Jun 2025 19:37:41 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B0882A76
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 19:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=contact@paulk.fr
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 797991F0004D
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 17:37:37 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id E599DAC3548; Tue,  3 Jun 2025 17:37:35 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id A30A0AC3543;
 Tue,  3 Jun 2025 17:37:34 +0000 (UTC)
Date: Tue, 3 Jun 2025 19:37:32 +0200
From: Paul Kocialkowski <contact@paulk.fr>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Icenowy Zheng <icenowy@aosc.xyz>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/6] sunxi: Add support for the Lichee Pi Zero with Dock
Message-ID: <aD8y3JiXF6ATCWTS@collins>
References: <20250601153943.2690123-1-contact@paulk.fr>
 <20250601153943.2690123-3-contact@paulk.fr>
 <20250602014014.0664e6fe@minigeek.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4IBd5vSnfAoqLdZU"
Content-Disposition: inline
In-Reply-To: <20250602014014.0664e6fe@minigeek.lan>
X-Mailman-Approved-At: Tue, 03 Jun 2025 20:38:26 +0200
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


--4IBd5vSnfAoqLdZU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andre,

Le Mon 02 Jun 25, 01:40, Andre Przywara a =C3=A9crit :
> On Sun,  1 Jun 2025 17:39:39 +0200
> Paul Kocialkowski <contact@paulk.fr> wrote:
>=20
> Hi Paul,
>=20
> > This adds a U-Boot config and device-tree build for the Lichee Pi Zero
> > with Dock. Compared to the Lichee Pi Zero, it has an ethernet port
> > (with internal PHY) so the EMAC driver and network support are enabled.
>=20
> I just realised that there is no difference between the U-Boot versions
> of the DT and the kernel ones, so can you please use the opportunity to
> upgrade the V3x systems to OF_UPSTREAM (in a separate patch)? This would
> involve removing all the redundant .dts* files from arch/arm/dts, see
> dc2dd2de0f782860 for an example.

Yes definitely! I wasn't sure whether there was some specific reason why
it hadn't been done yet.

> Regardless the defconfig looks alright, but one comment:
>=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  arch/arm/dts/Makefile                | 3 ++-
> >  configs/LicheePi_Zero_Dock_defconfig | 7 +++++++
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >  create mode 100644 configs/LicheePi_Zero_Dock_defconfig
> >=20
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index 32b698a7f411..be6867ceae0e 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -650,7 +650,8 @@ dtb-$(CONFIG_MACH_SUN8I_V3S) +=3D \
> >  	sun8i-s3-elimo-initium.dtb \
> >  	sun8i-s3-pinecube.dtb \
> >  	sun8i-v3-sl631-imx179.dtb \
> > -	sun8i-v3s-licheepi-zero.dtb
> > +	sun8i-v3s-licheepi-zero.dtb \
> > +	sun8i-v3s-licheepi-zero-dock.dtb
> >  dtb-$(CONFIG_MACH_SUN8I_R528) +=3D \
> >  	sun8i-t113s-mangopi-mq-r-t113.dtb
> >  dtb-$(CONFIG_MACH_SUN50I_H5) +=3D \
> > diff --git a/configs/LicheePi_Zero_Dock_defconfig b/configs/LicheePi_Ze=
ro_Dock_defconfig
> > new file mode 100644
> > index 000000000000..ec172d98b65e
> > --- /dev/null
> > +++ b/configs/LicheePi_Zero_Dock_defconfig
> > @@ -0,0 +1,7 @@
> > +CONFIG_ARM=3Dy
> > +CONFIG_ARCH_SUNXI=3Dy
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"sun8i-v3s-licheepi-zero-dock"
> > +CONFIG_SPL=3Dy
> > +CONFIG_MACH_SUN8I_V3S=3Dy
> > +# CONFIG_HAS_ARMV7_SECURE_BASE is not set
>=20
> IIUC, the V3S does not have (secure) SRAM A2, and no ARISC? Can we
> express this in the Kconfig file then, since it's not a board config
> option?

Indeed I cannot find any mention of SRAM A2 and ARISC. Makes sense given the
low-end target for this chip.

Sure it's better to move it to the Kconfig too. Will do in the next revisio=
n.

All the best,

Paul

> Cheers,
> Andre
>=20
> > +CONFIG_SUN8I_EMAC=3Dy
>=20

--=20
Paul Kocialkowski,

Free software developer - https://www.paulk.fr/
Independent contractor - sys-base - https://www.sys-base.io/

Contributor to fully free software support for selected hardware.

--4IBd5vSnfAoqLdZU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmg/MtwACgkQhP3B6o/u
lQxmWxAAgIAxp7XvnXKyiQhRKT7PAqehl0Vj0Jt3ygxjtF836Sk6UiORnQ7DI0M3
oOZPrys3G9ndZiKCBt3JM7mGhrRyEvURvzV7TDucfVIYg33Wa45oW02HCKXdgVIW
OM45t+7L1nK90pF+s1c/erNbtEZKoFz+wuzPYht/E0JnUmeh5WmKyrqBffkPJOLu
kng2Cvn4T5ffSo4E3tlN+1Por93mK9iKDDXliyImq4SzCzS32Ui0vCxq73LumiwV
iGpg4fzkVLC6x3E90MSPHi7iiITk/W/LK51aQeUG1HHt3SEilXykv9v2ypIOc14H
ktXwZ3zd27e5YHqZuLjRVSlkW3i93dSHfrBKc6UP6hCvixu1k+u+VkXIuIErVkD4
MGMpuu83ZhfLk4Iv0BymW6VE9Um4bdtgEhft7PiDlDhfUiP1Gr+TvMvBVDQni+kg
MJxOP2PjzGTd08Hqj1au+YU6Y0NIJpBs7kf7RWyRS4ERzERZCWkf3nsMwScDf1tW
CXbBrMWQgrMoeSxg6yjHjXj8t3koAY6f+plapuy22XOz1kPpqvuJOaFGe6Qwnh42
zoukJa/oYa0ulnTmA/GyZWrYH3bkJ9GW/Qs0Bfr0W8MIKP9S/7x+j3lxTEX20Lbj
1s/P9cERmSLRDtx/9b6FryonO1vTB/1BUdMXgwYQCXpQiToXLmY=
=JiZQ
-----END PGP SIGNATURE-----

--4IBd5vSnfAoqLdZU--
