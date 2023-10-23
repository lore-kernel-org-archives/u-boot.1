Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB68C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 884DE878BA;
	Mon, 23 Oct 2023 09:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4059387874; Mon, 23 Oct 2023 09:05:23 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id EDD6E878AE
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,244,1694703600"; 
 d="asc'?scan'208";a="184048297"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 23 Oct 2023 16:05:10 +0900
Received: from unknown (unknown [10.226.93.66])
 by relmlir6.idc.renesas.com (Postfix) with SMTP id AEF1141A29F6;
 Mon, 23 Oct 2023 16:05:08 +0900 (JST)
Date: Mon, 23 Oct 2023 08:04:48 +0100
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] mmc: tmio: Disable 1/1024 clock divider on Renesas R-Car
 platforms
Message-ID: <20231023070322.it5w7fm3swubxox5@GBR-5CG2373LKG.adwin.renesas.com>
References: <20231022214057.102051-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kidmr36c5lagtd5m"
Content-Disposition: inline
In-Reply-To: <20231022214057.102051-1-marek.vasut+renesas@mailbox.org>
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


--kidmr36c5lagtd5m
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3gpvlrdcscfeoyc4"
Content-Disposition: inline


--3gpvlrdcscfeoyc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 11:40:43PM +0200, Marek Vasut wrote:
> The R-Car Gen3 SD_CLK_CTRL register does not use BIT(16) to implement
> divider 1/1024, instead BIT(16) is reserved bit and divider 1/1024 is
> not supported. The divider 1/1024 is specific to Socionext variant of
> the IP, as is indicated by Linux commit:
>=20
> 0196c8db8363 ("mmc: tmio: move tmio_mmc_set_clock() to platform hook")
> "
> Socionext (and Panasonic) uses bit 10 (CLKSEL) for 1/1.  Also, newer
> versions of UniPhier SoC variants use bit 16 for 1/1024.
> "
>=20
> Do not set the TMIO_SD_CAP_DIV1024 on Renesas R-Car platforms even if
> the IP VERSION register does exist, and indicates IP version is newer
> or equal to version 1.0 . The IP version 1.0 or newer does not imply
> presence of the 1/1024 divider.
>=20
> Since the TMIO driver is used exactly by two supported platforms, that
> is Renesas R-Car and Socionext UniPhier, it is OK to check whether the
> TMIO_SD_CAP_RCAR capability is not set to identify the UniPhier platform
> and add the capability only on that platform.
>=20
> Fixes: 58c35b17aa8f ("mmc: matsushita-common: Always check controller ver=
sion")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

I've confirmed that the 1/1024 divider doesn't exist in the RZ/G2L
datasheet.

Acked-by: Paul Barker <paul.barker.ct@bp.renesas.com>

--3gpvlrdcscfeoyc4--

--kidmr36c5lagtd5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZTYbDwAKCRDbaV4Vf/JG
vUrEAP4hNelvhlq2ueOV8IqpvhOeWDt3MGfQ+WC54SEREqq7nwD9ES/Kw1ch051j
+nqSzEA0q2wBceOORLBjlzJurdlkyg8=
=ekBk
-----END PGP SIGNATURE-----

--kidmr36c5lagtd5m--
