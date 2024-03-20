Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E3FC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 13:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36CA087FE8;
	Wed, 20 Mar 2024 14:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="BGikW9Iu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9186787F87; Wed, 20 Mar 2024 14:08:07 +0100 (CET)
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz
 [139.28.40.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E62287E47
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 14:08:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=nabijaczleweli.xyz
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=nabijaczleweli@nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
 s=202305; t=1710940084;
 bh=xjJ1Kv4gNVDXXyinB6hN4hVXHilucAljimc7sHy3Wlc=;
 h=Date:From:To:Subject:From;
 b=BGikW9Iu/AFZ5j0IaL8T3ujvZacmIr9FIZGoKnxGl20fSFA5r5emQX+8LrQ9hmXTf
 w8irKQFL2nvV8BY51kM4pOthD3TM7IdYcPqP1w+93YqnXCDKq9dmctxzbIO5V0gkIj
 XaBQsuOYZzjTTYf2+LuBJvCdKspzEfLl8A96AVvmWVYztY1HlWTTLgbkAO09TUekyZ
 Ip+eYAdehrkaM4bc6ybBh2CGxUErJ1d3o7sNdYKe/O4VlSC8/Hjf9cjTQj/qmAY5tU
 2icS2/wxP57gfqImH2PK+cbFet5uimSRzPgzQVLHWLfrp+NiubxBT2FIrRPeALUHRw
 XRQEgDdIivJsQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
 by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id B95C8FEA;
 Wed, 20 Mar 2024 14:08:04 +0100 (CET)
Date: Wed, 20 Mar 2024 14:08:04 +0100
From: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH] tools: open FIT image for reading as O_RDONLY instead of
 O_RDWR
Message-ID: <yehdhyy7f272rllmk3jiyome7muiqrbm7ezbu4xnqcymrcaobu@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qrjo4tgaebo2ceob"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty
X-Mailman-Approved-At: Wed, 20 Mar 2024 14:08:27 +0100
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


--qrjo4tgaebo2ceob
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The only usage of the fd is for the single read() below;
this prevented
	mkimage -f auto -A arm64 \
		-T kernel -C lz4 -d Image-6.6.15.lz4 \
		-b mt8173-elm-hana-6.6.15.dtb outf
when the inputs were unwriteable.

Link: https://bugs.debian.org/1063097
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 tools/fit_image.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index beef1fa8..0fccfbb4 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -137,7 +137,7 @@ static int fdt_property_file(struct image_tool_params *=
params,
 	int ret;
 	int fd;
=20
-	fd =3D open(fname, O_RDWR | O_BINARY);
+	fd =3D open(fname, O_RDONLY | O_BINARY);
 	if (fd < 0) {
 		fprintf(stderr, "%s: Can't open %s: %s\n",
 			params->cmdname, fname, strerror(errno));
--=20
2.39.2


--qrjo4tgaebo2ceob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmX637IACgkQvP0LAY0m
WPFx1w/9HLFY1W8sbqy7IXrm5a6iltGcNdn2ViEmI9o2DYjGou0iUQhpPSqT6Tkx
1xpeEw9qoZpTdTGFG4VOSWDGsulf/z+183NSNF+lo4mWjlKlqDg15lfB2sHSU6hM
rnO9k49yWC83FrgNyT2JNW0p47Ugg8zLlo0I5JvGmXoptYqay0z7ioUW8urnsBoO
w2aNa399xYQ4Bma9pvUzsMDAMtx9PDEa0xtI1NWlAJQniPJz36QliBjKpWAkYxX4
dMtz8psAWiXLZ3wZ6P0ol717G35nVhP7wPYYMfAvAjKglEWpBoCjrwtwVW7Vz47W
OWwVy8SxZ+paxScanBTq8CuEDC/huNIdQJVj4wW38GOq7P8edzeqK6dfuUnw7ljY
Tz6rOi4XEfdw44O9FlOT8C1IEEvrz3QiGyhyOGTDeky0fkMKhaqxap5pe+mNzlGM
vZ6d6Gr6KfZy2m5b2h6tGYn/4gXkopn3Qm1DgKchUXdpwxtiV5+QVHhxWaSA87D/
LYjzkAEtZUFC5HnFI8JBy8KaRlvdZsPaOuwaXfJCRvWQ7aceQBDZC/a/otyCnFMx
T37dAwxO1bfgtq1ffaIhqumshT5jyhmaNFG3iMumKFVIIFyKZwnzOa5kdCqEGOyL
e1uF3kaTiQ15oMCxGs2TMDtXY2VTvAtZXu04yiQ4OsabkYafgIQ=
=VUCp
-----END PGP SIGNATURE-----

--qrjo4tgaebo2ceob--
