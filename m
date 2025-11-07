Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008BACCFA1B
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 08:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 508F883C96;
	Fri,  7 Nov 2025 09:21:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="l0GXoIYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29D0F83CA4; Fri,  7 Nov 2025 09:21:56 +0100 (CET)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [84.16.66.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F027683C94
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 09:21:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d2sV94y2RzQgZ;
 Fri,  7 Nov 2025 09:21:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1762503713;
 bh=zEIxSg5QuNkISt2iCpV95R2k4A3CvvGDRSk1FdJ6LnY=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=l0GXoIYimr8bjLkga0okAvdjiL2Q0wacisznYUPj+oHCgv2fj8IqgBx22fIGyG3AS
 KCAFr1Is3iPCj84VG44ydoEYPqpG2E+mW2eDWUwP2fKu5451uzqeil8ucRNYQ6ScDm
 8sTZEEzats5BqNxmC1jE5mTslHt4IGe3k4TrAXFE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d2sV84wnTzpQk; Fri,  7 Nov 2025 09:21:52 +0100 (CET)
Message-ID: <3459766068b6c38d6c2b316d3975e11661033324.camel@pschenker.ch>
Subject: Re: [PATCH v1 0/6] remoteproc: k3-r5: Build fixes and security
 improvements
From: Philippe Schenker <dev@pschenker.ch>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, stefan@embear.ch, Andrew Davis <afd@ti.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Beleswar Padhi
 <b-padhi@ti.com>, Daniel Schultz	 <d.schultz@phytec.de>, Hari Nagalla
 <hnagalla@ti.com>, Judith Mendez <jm@ti.com>,  Neha Malcom Francis	
 <n-francis@ti.com>
Date: Fri, 07 Nov 2025 09:21:12 +0100
In-Reply-To: <20251106193527.GA3087996@bill-the-cat>
References: <20251023094631.16742-1-dev@pschenker.ch>
 <20251106193527.GA3087996@bill-the-cat>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-Vie3tw4LpQntUqK7tPrP"
User-Agent: Evolution 3.58.1 
MIME-Version: 1.0
X-Infomaniak-Routing: alpha
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


--=-Vie3tw4LpQntUqK7tPrP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tom,=20

Sorry for not spotting this. I will improve the patchset and send a v2.

On Thu, 2025-11-06 at 13:35 -0600, Tom Rini wrote:
> On Thu, Oct 23, 2025 at 11:46:18AM +0200, Philippe Schenker wrote:
>=20
> > From: Philippe Schenker <philippe.schenker@impulsing.ch>
> >=20
> >=20
> > This series fixes compilation errors when building for R5 cores and
> > addresses a security issue where authenticated images were not
> > being
> > used correctly.
> >=20
> > Patch 1: Cosmetic removal of duplicate code
> >=20
> > Patches 2-3: Fix build errors caused by type mismatches between
> > function signatures and the types used in R5 builds.
> >=20
> > Patches 4-5: fix a bug where ti_secure_image_post_process()
> > relocates
> > images during authentication, but callers were still using the
> > original
> > unverified addresses.
> >=20
> > Patch 6: Implements is_running operation to allow querying R5F core
> > status.
> >=20
> > Note: If preferred, I can split this series.
>=20
> With the series applied, I see warnings now on:
> j721e_beagleboneai64_r5 am62x_beagleplay_r5 am67a_beagley_ai_r5
> phycore_am62ax_r5 phycore_am62ax_r5_ethboot phycore_am62ax_r5_usbdfu
> phycore_am62x_r5 phycore_am62x_r5_ethboot phycore_am62x_r5_usbdfu
> phycore_am64x_r5 am62ax_evm_r5 am62dx_evm_r5 am62px_evm_r5
> am62px_evm_r5_ethboot am62x_evm_r5 am62x_evm_r5_ethboot am62x_lpsk_r5
> am64x_evm_r5 am65x_evm_r5 am65x_evm_r5_usbdfu am65x_evm_r5_usbmsc
> j7200_evm_r5 j721e_evm_r5 j721e_sk_r5 am68_sk_r5 am68_sk_r5_ethboot
> j721s2_evm_r5 j722s_evm_r5 j722s_evm_r5_ethboot am69_sk_r5
> am69_sk_r5_ethboot j742s2_evm_r5 j784s4_evm_r5 verdin-am62_r5
> verdin-am62p_r5
> like:
> arch/arm/mach-k3/security.c:122:20: error: cast to pointer from
> integer of different size [-Werror=3Dint-to-pointer-cast]
> =C2=A0=C2=A0 122 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *p_ima=
ge =3D (void *)image_addr;

--=-Vie3tw4LpQntUqK7tPrP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEPaCxfVqqNYSPnRhRjRDjR2hoXxoFAmkNq/gACgkQjRDjR2ho
Xxq0kwv+OXPalVZ64Zvz5m/BZV7OZGyEpwbACYmxSCQ/E0ejwmybXQV9NIM5L2qM
6EOj5BL+DmTMXu1mdDZsRQtc3J+i096cOw1ZgrkvONj3BhWdKOULzhfLNmlriChw
EeSI6bVpGGXrFQS5EjoFi2LqreD1WDlsIPEFi0f4Auov4cItT0kx4xbBBt2+lxTs
CcgIo6ACik06Egsxlqrw/n/ynPR8b+R4pRRt3zajIV/DdhsbLSUlAIG+8ycDyoFR
CAZns0eAlH7xO08YX/FbgaFytgDKBrgS7ykPYgZ9wRqyfvof1D9gqOvgbqHLnJ5l
zUapdmc+/AH56iUVAMW0vHdlHr9YbNNOBwitFk7lR8969AVs+iOd5rkZzVeo5HNL
CIATh6TDj6dZi414TdX1moGhnXivuZ+DD6h/oU1E3JOXcyG7l+P9s0cFahTIAUdd
kKubZ1WePU6v2I/bEAYfON01oRSKT9RaZMeRliNBAXC+4YSFDlq+m0Dw+/S6rhFn
LHvJL9cC
=0Lwo
-----END PGP SIGNATURE-----

--=-Vie3tw4LpQntUqK7tPrP--
