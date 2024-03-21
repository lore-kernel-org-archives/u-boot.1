Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0622C6FD1F
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 19:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 640FD88121;
	Thu, 21 Mar 2024 20:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="PGUNut28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 720E6880B2; Thu, 21 Mar 2024 19:31:57 +0100 (CET)
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz
 [139.28.40.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43F9F87F6A
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 19:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=nabijaczleweli.xyz
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=nabijaczleweli@nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
 s=202305; t=1711045914;
 bh=zTPXeMQmgPJp0Ut2WlRrQl1d35DIscl31Lk1CBN3J7s=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=PGUNut28yoGhqUnbwG/vTumGxlYiajx1WrYB2r1c8JCHdxq0Kde4SiS3qiZM+BXsh
 23ga7A8skPlB8CBHNa+V2wOKJDB1GTaU51aHJemAKNh/SdbD/kVr3PoDDwzBKaoVNk
 eVD3hEZZHh32i+I3S9Wzp8q06+SnNxTTEkh4tceU8DmoDmPo4vmiKBeZuEuXwKyF6T
 v60jKXDS/OZ4N40SldLfY+byMF9yG8Ygp+6ZmUENqa613jnBQW5KC1dh2gClnkSrOE
 xFfqE2P0MWqdzIhlmr+sHlHKy8yDYwO8M0EiW3K4stBlga2GqsGw74cF5fAtRDXF22
 F2cF5jWf4IfEg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
 by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id DADF9133E;
 Thu, 21 Mar 2024 19:31:54 +0100 (CET)
Date: Thu, 21 Mar 2024 19:31:54 +0100
From: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v2] tools: open FIT image read-only
Message-ID: <rt336whqarwenm6q2pbla2x2yewfxwjpxuh2x6mmo5i7ynfopl@tarta.nabijaczleweli.xyz>
References: <a5562c55fef9fd07e8a087ebcd389e60@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vxya4pfihwgpzcvm"
Content-Disposition: inline
In-Reply-To: <a5562c55fef9fd07e8a087ebcd389e60@manjaro.org>
User-Agent: NeoMutt/20231221-2-4202cf-dirty
X-Mailman-Approved-At: Thu, 21 Mar 2024 20:15:42 +0100
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


--vxya4pfihwgpzcvm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Open for reading as O_RDONLY instead of O_RDWR:
the only usage of the fd is for the single read() below;
this prevented
	mkimage -f auto -A arm64 \
		-T kernel -C lz4 -d Image-6.6.15.lz4 \
		-b mt8173-elm-hana-6.6.15.dtb outf
when the inputs were unwritable.

Link: https://bugs.debian.org/1063097
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
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

--vxya4pfihwgpzcvm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmX8fRoACgkQvP0LAY0m
WPGpNxAAgM1dI1zhIw2+W7b43ApZ38fgfBIqDvq8OrK8e7bY2T7fPr4FOsp67nQo
GvhMZM+0uzS6LHXiU364tI0j1lLBxi3o09fQeHHyKd/p4iI+fjDZ16CLqsW1o5iF
j0TQXX3OYA904XySUucBJr3FqL0Ppo/suGDRwR2Jx6I9opFLwczu9pzUudOiWEff
smWsIBVeBLsfATx74BOnYtK05a7zNupf9loJDjLVJjnGvWg0tOyTfUnXA+1nRD1f
WVc13I2FszH/9vV0fi1cU2EgVE1fvFaUXuXPhvDl+REJcnqw8NSKmJ7VO4E/wcJa
CpDiRQwJR1pCY67gIpTA4BsF2pLxm52wcxaKsE9uyI1oS6xm49xXvovJLlNFXDEk
5/tQA8sRnNDArgh8UMlngsGJhMVv5+RHNguSSu2kvUNqMrme/HQLgvYOwojuHcSu
c3/VLYyr85JwEFAR6+csoHhUgDZCnrPdo8eR4EcQpEmrLMD/PMztmsiFtzPDL4jh
D6E50FTglRfNX3DS4f1FeEUDOjEk4OGlU79AOsnOXMBjZ6PlDWp6socE5xtWWm/l
VAkURGIK69lwxy1LRXUz/BurMgsAWLZqdXlNzKKH4rLBWNXPBaQ1f1HsceRwiD/X
x2orhQ1y2i1VEuh99VVMyJVsKTRKwD+0XmR6ZYeUoO7G0UqdwyM=
=Bah3
-----END PGP SIGNATURE-----

--vxya4pfihwgpzcvm--
