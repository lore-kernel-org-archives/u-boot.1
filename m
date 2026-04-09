Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B40F31E41
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 15:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8B3F841B9;
	Thu,  9 Apr 2026 17:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6387C83CF5; Thu,  9 Apr 2026 17:10:31 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4C4A83693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 17:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=contact@paulk.fr
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id DB4131F8005C
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 15:10:24 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 65702B401BA; Thu,  9 Apr 2026 15:10:23 +0000 (UTC)
Received: from shepard (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id E9EF5B401B3;
 Thu,  9 Apr 2026 15:10:21 +0000 (UTC)
Date: Thu, 9 Apr 2026 17:10:19 +0200
From: Paul Kocialkowski <contact@paulk.fr>
To: Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: Philippe Simons <simons.philippe@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] sunxi: H616: dram: fix LPDDR3 TRP6 parsing
Message-ID: <adfBW5aKiDm6TRzZ@shepard>
References: <20260407164717.7356-1-simons.philippe@gmail.com>
 <f78d23da-0e61-4a06-ae48-22cadd7ac24d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FsDOLbvbGNg7guXs"
Content-Disposition: inline
In-Reply-To: <f78d23da-0e61-4a06-ae48-22cadd7ac24d@gmail.com>
X-Mailman-Approved-At: Thu, 09 Apr 2026 17:38:43 +0200
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


--FsDOLbvbGNg7guXs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu 09 Apr 26, 13:48, Mikhail Kalashnikov wrote:
> On 4/8/26 00:47, Philippe Simons wrote:
> > From: Jernej Skrabec <jernej.skrabec@gmail.com>
> >=20
> > Allwinner's BSP DRAM code uses parameter TPR6, presumably containing
> > some "Vref" parameter, to encode the values for *all* four supported DR=
AM
> > types. The code selects one byte based on the DRAM type used at runtime.
> > To allow copying DRAM parameters from vendor firmware, we used this val=
ue
> > and its encoding, but wrongly: the proper order of bytes is DDR3, DDR4,
> > LPDDR3, LPDDR4, from LSB to MSB, cf. the A523 and A133 DRAM code.
> >=20
> > Correct the masking for LPDDR3 to fix DRAM operation on some boards
> > using this DRAM type.
> >=20
> > With LPDDR3 TRP6 parsing fixed, adapt default DRAM_SUNXI_TPR6 value.
> > Also change LPDDR4 default value to 0x38 used by A523 boards.
> >=20
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > [adjusted commit message, update default value]
> > Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
> > ---
> >   arch/arm/mach-sunxi/Kconfig            | 2 +-
> >   arch/arm/mach-sunxi/dram_sun50i_h616.c | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> > index e979ee4a2cc..a1ddc6a1fc8 100644
> > --- a/arch/arm/mach-sunxi/Kconfig
> > +++ b/arch/arm/mach-sunxi/Kconfig
> > @@ -144,7 +144,7 @@ config DRAM_SUNXI_TPR3
> >   config DRAM_SUNXI_TPR6
> >   	hex "DRAM TPR6 parameter"
> > -	default 0x3300c080
> > +	default 0x38c00080
> I don't think this will be a good solution. The changes in this series
> were originally made to improve compatibility with the vendor driver,
> but now you are introducing an additional inconsistency by closing the
> previous one. The default values are not just arbitrary values =E2=80=94 =
they
> are part of the vendor code that was obtained through binary analysis.
> https://lore.kernel.org/all/20231018172109.085cce24@donnerap.manchester.a=
rm.com/

I tend to agree with you, it feels like the default value was taken from the
reference code while the field parsing was just an issue that was introduced
with the h616 code. So it should not affect the defaut value, which was lik=
ely
mistakenly parsed before.

> There are several options here:
> 1. If our goal is to improve compatibility, then we should not change
> the default values for LPDDR4, and only keep the changes for LPDDR3.
> 2. Add the changes from option 2, and additionally introduce the default
> values for the A523 platform that I made during the initial binary
> analysis but for some reason did not get merged into mainline.
> (https://github.com/iuncuim/u-boot/blob/b17c5c8911a4fce328b01e6332632a9cc=
d88ebc6/arch/arm/mach-sunxi/Kconfig#L102)

It would be good to have different defaults for different platforms yes.
Note that the a133 code has some fallback with defaults when the extracted
field in tpr6 is zero. Maybe they should be used as default value for a133.
We probably still need to keep these fallbacks in the code in case some
board-specific tpr6 value does have zeroes and relies on this behavior.

> 3. If we accept the incompatibility between the vendor driver and
> the mainline driver, then this patch series is unnecessary because
> they introduce additional inconsistency with the vendor driver.

We definitely want to be able to take the dram parameter values straight fr=
om
the BSP and put them directly into our Kconfig. Changing the order of fields
would make porting new boards very painful so it should be avoided.

> I think option two is the most correct, but option one is also suitable,
> since the DRAM driver for the A523 only supports DDR3 and LPDDR4,
> and the default values in this case are the same as for the H616
> (A523 is 0x33808080, H616 is 0x33c00080).

I suggest we keep the current default (without moving the lpddr3 bits) for =
h616
and add new defaults in Kconfig for a523 and a133.

> >   	help
> >   	  TPR6 value from vendor DRAM settings.
> > diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sun=
xi/dram_sun50i_h616.c
> > index 3345c9b8e82..42a0550e015 100644
> > --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > @@ -975,7 +975,7 @@ static bool mctl_phy_init(const struct dram_para *p=
ara,
> >   		val =3D para->tpr6 & 0xff;
> >   		break;
> >   	case SUNXI_DRAM_TYPE_LPDDR3:
> > -		val =3D para->tpr6 >> 8 & 0xff;
> > +		val =3D para->tpr6 >> 16 & 0xff;

This change is definitely necessary though.

> >   		break;
> >   	case SUNXI_DRAM_TYPE_LPDDR4:
> >   		val =3D para->tpr6 >> 24 & 0xff;

All the best,

Paul

--=20
Paul Kocialkowski,

Free software developer - https://www.paulk.fr/
Independent contractor - sys-base - https://www.sys-base.io/

Contributor to fully free software support for selected hardware.

--FsDOLbvbGNg7guXs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmnXwVsACgkQhP3B6o/u
lQw18w//aPHQOCgCjwVSfqg5cYE6Adxj1PY6O7khgnhtJfFuJodXYlLS+gGh6YeV
llhwqZgylz9KslbpfBUZSpuzSASu4MkuYp9whFk89dRyvafd/MZKCnjgHUXNDNz+
tocklRKQjDXuA6wuGmB+XFZ4oCcmDxLjYpcDfk3DOf+fCFHEHcuqUIat9JTQBWkW
2XSsG9hF8awRf6p2Yu8cDiERMV6YUKmlSsP5d4zrcvwcvnt+feUYvxBmOPPvAYCT
dLWUhwaNnnlPbaAyt7tfVleM3WK8wM8inY0t97ALKFalDi/w1nff2tXZ5sjJ6CPe
0IMvBNX9V8Wsk5UgETpqtCAA5rhozmX0GNKXTUmiVXJmt5Dzmv921MuZrXCSNDv4
oWPpTxPSOxRt2O6GyRUfOKCt9qmo73p3kgXgR+ksgRnUTCeaY8/b1Vajp/HiErMi
te1Encit0DH6RugZz0ETkcOPHkKAHYn3BqCKgWk5f2wz0RcNmcYwgc1fP+5PPiLL
0gRY7SNrst6zWBfl+POeIk+6E/4PanZZA9gjHyh81m3p5tvbvqZ/+TEnFo+EWE/d
Hvg+Hovl0iI8dxN+5rIYV7mvQLcgkaFQLHwNfb40efUCBQ6VVZ0CACdnqpkV3Net
QQ5g3Hsb+R4yW+9TsQ/TiF3ZV9WAv8ZRazZEMFgtSD2W6rM7TWg=
=I0TU
-----END PGP SIGNATURE-----

--FsDOLbvbGNg7guXs--
