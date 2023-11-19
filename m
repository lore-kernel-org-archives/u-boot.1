Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9CEC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 20:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CDB587185;
	Sun, 19 Nov 2023 21:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A17786E65; Sun, 19 Nov 2023 21:49:03 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 6F0AE87185
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 21:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.04,212,1695654000"; 
 d="asc'?scan'208";a="187341278"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 20 Nov 2023 05:48:56 +0900
Received: from unknown (unknown [10.226.92.15])
 by relmlir5.idc.renesas.com (Postfix) with SMTP id DE53C4003FDB;
 Mon, 20 Nov 2023 05:48:54 +0900 (JST)
Date: Sun, 19 Nov 2023 20:48:53 +0000
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 3/5] i2c: rzg2l: Add I2C driver for RZ/G2L family
Message-ID: <20231119204853.bmg4ghuo625c3zkm@GBR-5CG2373LKG.adwin.renesas.com>
References: <20231115174025.12974-1-paul.barker.ct@bp.renesas.com>
 <20231115174025.12974-4-paul.barker.ct@bp.renesas.com>
 <90feb671-d939-4dbf-9a49-418fc9a56b23@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uriuhymfhfkc3ge3"
Content-Disposition: inline
In-Reply-To: <90feb671-d939-4dbf-9a49-418fc9a56b23@mailbox.org>
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


--uriuhymfhfkc3ge3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 09:15:36PM +0100, Marek Vasut wrote:
> On 11/15/23 18:40, Paul Barker wrote:
> > This driver supports the I2C module on the Renesas RZ/G2L (R9A07G044)
> > SoC, also known as the RIIC module.
> >=20
> > This patch is based on both the u-boot driver in the Renesas RZ BSP
> > 3.0.5 release [1] (commit 7fcc1fdc2534), and the Linux v6.6 driver
> > (commit ffc253263a13).
> >=20
> > Support for deblocking the I2C bus is included as this may be needed
> > after triggering a reset via the Power Management IC (PMIC) over I2C
> > (the PMIC asserts the reset line before the SoC completes the I2C write
> > transaction with obvious bus locking effects). If the SDA line is
> > observed to be low during initialisation, we automatically attempt to
> > deblock.
> >=20
> > [1]: https://github.com/renesas-rz/renesas-u-boot-cip
> >=20
> > Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>=20
> The driver seems very similar to drivers/i2c/rcar_iic.c , can there be so=
me
> code reuse ?

My initial idea was to extend the R-Car iic driver but I quickly saw
that would be very messy. All the registers and bits are in different
places, the calculations are different (particularly in regard to
setting bus speed) and the read/write process has more edge cases for
the RZ/G2L. The bus recovery mechanism we use also doesn't exist on
previous R-Car SoCs.

The Linux drivers for these modules are also separate, see
drivers/i2c/busses/i2c-sh_mobile.c (for R-Car and earlier SoCs) and
drivers/i2c/busses/i2c-riic.c (for RZ/G2L) in the Linux kernel.

Thanks,
Paul

--uriuhymfhfkc3ge3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZVp0oQAKCRDbaV4Vf/JG
vbCgAP9reIWrhFIJxRUpPL8JHCMhyckjAu3LxJzfYT4HvKMP7gEA+zZQFbzf7OJt
Es3dU1b8mNtjp1fsM3gU6ZJ9Q0bfBQo=
=T4bc
-----END PGP SIGNATURE-----

--uriuhymfhfkc3ge3--
