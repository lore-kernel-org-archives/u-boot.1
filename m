Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D433C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 18:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E997588CF7;
	Sat,  3 Aug 2024 20:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kaI61OsA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E38B885BC; Sat,  3 Aug 2024 18:18:04 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 358D388CAB
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 18:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sre@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E090160E07;
 Sat,  3 Aug 2024 16:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE49C116B1;
 Sat,  3 Aug 2024 16:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722701880;
 bh=QmVaG65Mg7TUnSk+GS0vc3YhHdMJ2WKBv0jdx3R1L1g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kaI61OsADH6Hecvvvcd3uZUDE+olu56U0lvaNoTpZGi3UEZdWS8eCA20pEa5S4/Lm
 445Ze/yZ+gBz+scWccjEicoFbkNEn65kIAEAdFdQxG8b1L8ct3n6HCSsYUVw6g3tKh
 z4pnrzmTv2oSRv+Pl3uLcc/Q+HJvic8ph8NXUOmzoUQIhBjMMFiQ84Fu+7XQXOgdN6
 gbN5a+el4IBwvBEPDAzmnktWDyxOLaNY9CjPM/44Ep2HNIje5XVhNptW1DgufwYilk
 nnE5WC7eA30FDOrnbI0QWDrMvM9TLa+9UKpYWM/8utyJOsRNALq0ltWVnblFOTOpfe
 kwavwYUmHYv3Q==
Received: by mercury (Postfix, from userid 1000)
 id F36721060930; Sat, 03 Aug 2024 18:17:57 +0200 (CEST)
Date: Sat, 3 Aug 2024 18:17:57 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Marek Vasut <marex@denx.de>, 
 Eugen Hristev <eugen.hristev@collabora.com>, Tim Harvey <tharvey@gateworks.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Simon Glass <sjg@chromium.org>, Soeren Moch <smoch@web.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3 3/7] board: rock5b-rk3588: add USB-C controller support
Message-ID: <tr5v2aoyyytil5cgs56fi4wyqfvugkpt2yf3zkrstyawbl3xds@k7t5d2x2ting>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
 <20240802180027.139193-4-sebastian.reichel@collabora.com>
 <354cb9d4-45f0-4dc8-909a-925423d75044@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g2pxyis7yw5cd7xe"
Content-Disposition: inline
In-Reply-To: <354cb9d4-45f0-4dc8-909a-925423d75044@kwiboo.se>
X-Mailman-Approved-At: Sat, 03 Aug 2024 20:55:08 +0200
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


--g2pxyis7yw5cd7xe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Fri, Aug 02, 2024 at 10:42:56PM GMT, Jonas Karlman wrote:
> On 2024-08-02 19:59, Sebastian Reichel wrote:
> > Enable support for the fusb302 USB Type-C controller.
> >=20
> > This will do early USB PD (power deliver) negotiation, which must happen
> > within 5 seconds after the USB-C connector has plugged in according to
> > the specification. It takes almost 5 seconds to go through the bootchain
> > on Rock 5B and jump to the operating system. When the Linux initializes
> > the fusb302 usually 20-30 seconds have gone since the device has been
> > plugged, which is far too late. The USB PD power source reacts with a
> > hard reset, which disables VBUS for some time. This is not a problem for
> > a battery driven device, but Rock 5B will loose its power-supply and
> > reset. By initializing PD in U-Boot, this can be avoided.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  board/radxa/rock5b-rk3588/Makefile        |  6 ++++
> >  board/radxa/rock5b-rk3588/rock5b-rk3588.c | 35 +++++++++++++++++++++++
> >  2 files changed, 41 insertions(+)
> >  create mode 100644 board/radxa/rock5b-rk3588/Makefile
> >  create mode 100644 board/radxa/rock5b-rk3588/rock5b-rk3588.c
> >=20
> > diff --git a/board/radxa/rock5b-rk3588/Makefile b/board/radxa/rock5b-rk=
3588/Makefile
> > new file mode 100644
> > index 000000000000..95d813596da4
> > --- /dev/null
> > +++ b/board/radxa/rock5b-rk3588/Makefile
> > @@ -0,0 +1,6 @@
> > +# SPDX-License-Identifier:     GPL-2.0+
> > +#
> > +# Copyright (c) 2022 Collabora Ltd.
> > +#
> > +
> > +obj-y +=3D rock5b-rk3588.o
> > diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/ro=
ck5b-rk3588/rock5b-rk3588.c
> > new file mode 100644
> > index 000000000000..1c17ae93c76c
> > --- /dev/null
> > +++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> > @@ -0,0 +1,35 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2023-2024 Collabora Ltd.
> > + */
> > +
> > +#include <usb/tcpm.h>
> > +
> > +#ifdef CONFIG_MISC_INIT_R
> > +int misc_init_r(void)
>=20
> You should not override misc_init_r() here as it will override the
> rockchip board common misc_init_r() function that read cpuid, set serial
> and ethernet mac address env vars.
>=20
> I would suggest you instead of tcpm_get() add something similar to
>=20
> int tcpm_probe_all()
> {
> 	struct udevice *dev;
> 	struct uclass *uc;
> 	int ret;
>=20
> 	ret =3D uclass_get(UCLASS_TCPM, &uc);
> 	if (ret)
> 		return ret;
>=20
> 	for (ret =3D uclass_first_device_check(UCLASS_TCPM, &dev);
> 	     dev;
> 	     ret =3D uclass_next_device_check(&dev)) {
> 		if (ret)
> 			printf("Failed to probe Type-C controller '%s' (ret=3D%d)\n",
> 			       dev->name, ret);
> 	}
>=20
> 	return 0;
> }
>=20
> or if we do not care about the error message this could use
>=20
> 	uclass_probe_all(UCLASS_TCPM);
>=20
> and call it from the rockchip board common code in mach-rockchip/board.c
> directly after the call to regulators_enable_boot_on() in board_init().
>=20
> Alternatively you could call following in a tcpm_post_bind()
>=20
> 	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>=20
> to automatically probe the device as soon as possible after all devices
> have been bind, this is how the rockchip-io-domain driver does it.
>=20
> Otherwise we need to add custom board code for each board using USB PD,
> something to avoid.

All of your suggestions result in any USB-PD controllers being
probed automatically. I intentionally did not go that way, since
probing can be quite slow depending on the remote side. For most
power-supplies it seems to be quite fast, but I've seen a boot
with one of the supplies being delayed by 2-3 seconds. Seems not
nice to add this penality for a device not depending on it.

Greetings,

-- Sebastian

>=20
> Regards,
> Jonas
>=20
> > +{
> > +	struct udevice *dev;
> > +	int ret;
> > +
> > +	/*
> > +	 * This will do early USB PD (power deliver) negotiation, which must
> > +	 * happen within 5 seconds after the USB-C connector has plugged in
> > +	 * according to the specification. It takes almost 5 seconds to go
> > +	 * through the bootchain on Rock 5B and jump to the operating system.
> > +	 * When the Linux initializes the fusb302 usually 20-30 seconds have
> > +	 * gone since the device has been plugged, which is far too late.
> > +	 *
> > +	 * The USB PD power source reacts with a hard reset, which disables
> > +	 * VBUS for some time. This is not a problem for a battery driven
> > +	 * device, but Rock 5B will loose its power-supply and reset. By
> > +	 * initializing PD in U-Boot, this can be avoided.
> > +	 */
> > +	ret =3D tcpm_get("usb-typec@22", &dev);
> > +	if (ret) {
> > +		printf("Failed to probe Type-C controller\n");
> > +		return 0;
> > +	}
> > +
> > +	return 0;
> > +}
> > +#endif
>=20

--g2pxyis7yw5cd7xe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmauWDUACgkQ2O7X88g7
+prR7g/+OFPVgllfEiPn75ROGbvFVf1hHMQKw6U/IxIX7DAm6pCTBe8dgdg0IVgz
R47zxJMaYXKhJd1eILa+MNtxfWD5mAnMZgO4BDkUKQHbUdPHSHA1d40JNhQsCpFt
FsbBdey5YJzW/ZOedq4xDLICjWTbUAaUAcgqVi7ABElXfLzmdZm4hJ1LlhBEfZbh
JQ0ruprGdUx8vBJx62vpqk/bw6qc6wG008CjktjxHj91cXkOBSPhlaR3e9gxhy6e
sBUbrw1KDmNUZ7ocpKMXxlEMV6CvWZnPHM+lM2NVuvFSgEWuMniJwbFqAQBMQdBn
3a0F3EbORyc6bp+1Fa85Csk7pPWAo1cnckeoymxxPvdVuh4lPkdeo8YXQWCDMc1+
HxKlJpPSfEi+OtAR+en03sw1vu3CDjR2wuNfQhubdonTuZZCEbtThQ4n63skFaVE
mSa/S3yn7PYBs98lH+IocYEpCprXs+knJt+lyRYHKHhTwR5vFisda8T9yQfI7t/H
nKM0cXDuCHT1975DKoTTm1vRaKNjRDlbVmDty6vk2xNaMmoQH3B2RT3WKnyv2/ii
z4QMJoLw4Bs4IHUEngq20e4ijeJjHdgqqUezdJvbfE0+quCwEwrGAF1TP0SbuoGu
T48S+KSWbSbV3d378gd5pIp7eUNzJ+AQsw+P/uwmvomXCuHUmuY=
=OmQl
-----END PGP SIGNATURE-----

--g2pxyis7yw5cd7xe--
