Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC86DE95A95
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 07:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FB5A865ED;
	Mon,  9 Oct 2023 09:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 121F486661; Mon,  9 Oct 2023 09:12:35 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 20E1286568
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 09:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,209,1694703600"; 
 d="asc'?scan'208";a="178621557"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 09 Oct 2023 16:12:28 +0900
Received: from unknown (unknown [10.226.92.156])
 by relmlir5.idc.renesas.com (Postfix) with SMTP id D3A28400C099;
 Mon,  9 Oct 2023 16:12:26 +0900 (JST)
Date: Mon, 9 Oct 2023 08:12:25 +0100
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH] doc: Add a short intro video
Message-ID: <20231009071027.ujkgzxq4trahncal@GBR-5CG2373LKG.adwin.renesas.com>
References: <20231008213557.621529-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2anyrk6ghdevr7vt"
Content-Disposition: inline
In-Reply-To: <20231008213557.621529-1-sjg@chromium.org>
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


--2anyrk6ghdevr7vt
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7e4gjldcmpydlqtq"
Content-Disposition: inline


--7e4gjldcmpydlqtq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 08, 2023 at 03:35:56PM -0600, Simon Glass wrote:
> This video covers the basics in a short time, so add a link to it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  doc/learn/talks.rst | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/doc/learn/talks.rst b/doc/learn/talks.rst
> index 0bb44aeabe55..d65e3b92be1a 100644
> --- a/doc/learn/talks.rst
> +++ b/doc/learn/talks.rst
> @@ -15,6 +15,9 @@ learn a bit about U-Boot:
>    <https://www.youtube.com/watch?v=3DYlJBsVZJkDI>`__
>    from Embedded Linux Conference 2023.
> =20
> +* `Introduction to U-Boot for beginners
> +  <https://www.youtube.com/watch?v=3DrVaiLgXccSE>`__
> +
>  See elinux_talks_ for a more comprehensive list.
> =20
>  .. _elinux_talks: https://elinux.org/Boot_Loaders#U-Boot
> --=20
> 2.42.0.609.gbb76f46606-goog
>=20

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>

--7e4gjldcmpydlqtq--

--2anyrk6ghdevr7vt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZSOn2QAKCRDbaV4Vf/JG
vfRtAQCwuBJ89TltUn7qLgL9Cak5vD7TWis/Adb/T3wZmJ9oewD/fVngzBwQpK0C
bu9t2L9165ZC1IRAKEFeCRNugXqgOAA=
=nSFu
-----END PGP SIGNATURE-----

--2anyrk6ghdevr7vt--
