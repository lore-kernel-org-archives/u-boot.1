Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7E5FC6160
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 17:17:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEF9A83AB7;
	Sat,  3 Jan 2026 18:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="mzM8M5DR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E759B83B49; Sat,  3 Jan 2026 18:17:52 +0100 (CET)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80C2183AAD
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 18:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j.ne@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 41AE8240027
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 18:17:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1767460670; bh=dF3wVdFKIG8b4Ot0mBTt6C1OkeoAKAZV2NvkCFMQi08=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Disposition:From;
 b=mzM8M5DRAsFAjxFh9EPc7H8m9a2chvDqHh9FPNrBv7lZeewqib/iujMZHnnlXhWZC
 F+9Xzhwm41u5/Pf3+RPdzNErYBgLUfWLukDJKiMwX0oKJQBDQkrgJfPGGWPLCsOCbM
 3aBmweC5kH4S5AzxG2gEEa4rt6SbNTy4Dxz0O1mYGgx/DwUgKy8jF+NeIYeNQfYjTS
 IVlr3ZYyLxeRZvo6MQmS7RZ671wRriUQysNkQ/3fYQMjyZa2hwh2H51YKaY08J0sRS
 7CVZ8k0E4lPh3ccsPTI2g/a27uYV/nBc6N4Jfk+rZR9sRBMT1Jn61DsHK0chZ6LdZD
 Z4900RbS2MxHQ==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4dk6hF2SxVz9rxL;
 Sat,  3 Jan 2026 18:17:48 +0100 (CET)
Date: Sat, 03 Jan 2026 17:17:49 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Tom Rini <trini@konsulko.com>
Cc: j.ne@posteo.net, u-boot@lists.denx.de,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Peter Geis <pgwipeout@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH next] board: amediatech: Add X96Q support
Message-ID: <aVlPPDgl10jPNrzw@probook>
References: <20251231-x96q-v1-1-316d703b8f03@posteo.net>
 <20260102150846.GD6124@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SSBMd7vZYOSHzlJt"
Content-Disposition: inline
In-Reply-To: <20260102150846.GD6124@bill-the-cat>
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


--SSBMd7vZYOSHzlJt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 02, 2026 at 09:08:46AM -0600, Tom Rini wrote:
> On Wed, Dec 31, 2025 at 08:45:03PM +0100, J. Neusch=C3=A4fer via B4 Relay=
 wrote:
>=20
> > From: "J. Neusch=C3=A4fer" <j.ne@posteo.net>
> >=20
> > The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM,
> > 8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
> > output, and infrared input.
> >=20
> >   https://x96mini.com/products/x96q-tv-box-android-10-set-top-box
> >=20
> > This commit adds a defconfig and some documentation. The devicetree is
> > already in dts/upstream.
> >=20
> > The CONFIG_DRAM_SUNXI_* settings are chosen such that the register
> > values in the DRAM PHY's MMIO space are as close as possible to those
> > observed when booting with the preinstalled vendor U-Boot.
> >=20
> > ---
> > Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>
> > ---
> >  configs/x96q_defconfig         | 46 ++++++++++++++++++++++++++++++++++
>=20
> This needs to come from "make savedefconfig" and:
> [snip]
> > +CONFIG_SUNXI_DRAM_H616_DDR3_1333=3Dy    # DDR3 is correct, but vendor =
uboot mentions 600 MHz DRAM CLK
> [snip]

Ok, I'll re-generate it.

> > +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D60   # os =3D 0, uboot not =
detected
> > +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D61   # e59f002c e5810000 f5=
7ff04f f57ff06f (4a0000cc)
> > +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D62   # a9431e66 a9442668 a9=
452e6a a946366c (4a0002cc)
> > +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D64   # 52800000 91008081 79=
400025 34000080 (4a0006cc)
> > +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D96   # 340007c0 f9401673 eb=
1302ff 54000760 (4a006acc)
> > +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D112  # f9003fe0 f94047e0 6b=
1c001f 54fffcc0 (4a0162cc)
>=20
> If this information is useful, it needs to be preserved in the docs.

I made these notes during bringup, but they're not useful anymore.


Thanks for your review!
J. Neusch=C3=A4fer

--SSBMd7vZYOSHzlJt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmlZTxYACgkQCDBEmo7z
X9stqhAAr9H0d9TR4telDVJMOIAFk0PFyuNh+vx508BXghjxToY5q3Sxz95QINTO
lwKkkTzhc46T3MXmyhy9bteR26lw61AuAZnLqx+/9AGeSbe/uJZTpDO5QyCtx0pv
5vG5KhvcZAg+krw3ANIBEeH2cUKM6rNg4BHUTADhKfhhFvvsqDryY/GP3vrBnQaG
EX12OZw4elvdpOduEP0CMjxbebpsvrO71MevkGqUQi/Mb38ULgL2XI4sZfZtlIQ5
4VgvxdXvagsP8IKKMew3AHZ3i6y5REeTe8pJRxfgu9YvsfUjrTN4+a4vR2UttT2C
fuXl3sbwanU0OnPzmpiH/T+wfsdLinDlZh7omhhfw0mYAxxuDprhJgqneSv6TZNR
u3J9ImQM0VdSYXt0iVSiPwpvj+S91kM86pbzoPRfq4krxSfUEQGV23SuBIGJEK8s
qzHiQanMUNub02Kc4A9EbUVwi8FFWxjzc2iEFK7qrs977kQ2WsJyiCudmxetvkS6
3A0Sia9ZyEV29oKT/R/aySMOyLPc2FH88RWQhYNCkLZddc1zchEFCmPvQuu1dR67
BPg6FI/Q7v9jQaqHJ+Gubq1LksHmYOY4WoKaJOiux7+KgEWB0I41OUURHrJ57W5t
z9RoZswKbydYcgKoQFoBZOX6hRUCi6JEuWGV1Kn4vHBi69pn6xk=
=pT/C
-----END PGP SIGNATURE-----

--SSBMd7vZYOSHzlJt--
