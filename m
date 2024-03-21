Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E83C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 19:15:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF050880AA;
	Thu, 21 Mar 2024 20:15:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="H7JPIN13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 939BE880AA; Thu, 21 Mar 2024 19:29:31 +0100 (CET)
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz
 [139.28.40.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FD7D87F33
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 19:29:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=nabijaczleweli.xyz
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=nabijaczleweli@nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
 s=202305; t=1711045767;
 bh=nd9RioAg6o0e80zs/kwjuMtZOpSJ/nQRw8tFMmhyFaQ=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=H7JPIN13L/EtNV7gyWzTKxLmGTjt3vIHQP+UTezieOMCsAX/nm59JrIGiMmdUiMJt
 vQF46vx0sP1obJXCSlwHItss6BjvtgP11cjCJS0mYnmc4s3jja1B5wkhH/NEF99in7
 eA7uqeYt6Fll8V6/lbVmEtfHfsFCqHBxUxgSvsu6bihZahQgZ1LQJXEq3s2JTPsF/p
 Zi7AhBBcw01T8vC3Z4RZ3BhSRgBxyQa9XvfZ+BYMmrXfIAg8ZWhLRZoVgePaDxQe4H
 7H4MW1fheokETQy6P44n4n/l4SeYVEwWmPVwbQTPx/FYg18YRLGmolLIo7m6z+2TcZ
 3/9rjd/VpAd/A==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
 by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id D675F180E;
 Thu, 21 Mar 2024 19:29:27 +0100 (CET)
Date: Thu, 21 Mar 2024 19:29:27 +0100
From: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v2] tools: copyfile: use 64k instead of 512 buffer
Message-ID: <bb5hzhpopwm2d65b5wjsvafsr537nbuyk3msebwth2v56vo3hu@tarta.nabijaczleweli.xyz>
References: <f48faaa30f42ab63c616611b0b0067b6@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="js4dh7cggshs5hpp"
Content-Disposition: inline
In-Reply-To: <f48faaa30f42ab63c616611b0b0067b6@manjaro.org>
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


--js4dh7cggshs5hpp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is a trivial but significant optimisation:
mkimage took >200ms (and 49489 writes (of which 49456 512)),
now it takes  110ms (and   419 writes (of which   386 64k)).

sendfile is much more appropriate for this and is done in one syscall,
but doesn't bring any significant speedups over 64k r/w
at the 13M size ranges, so there's no need to introduce
	#if __linux__
	while((size =3D sendfile(fd_dst, fd_src, NULL, 128 * 1024 * 1024)) > 0)
		;
	if(size !=3D -1) {
		ret =3D 0;
		goto out;
	}
	#endif

Also lift up the buffer size to a macro.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
---
 tools/fit_common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/fit_common.c b/tools/fit_common.c
index 2d417d47..1df4785c 100644
--- a/tools/fit_common.c
+++ b/tools/fit_common.c
@@ -127,6 +127,7 @@ err:
=20
 int copyfile(const char *src, const char *dst)
 {
+#define copyfile_bufsize (64 * 1024)
 	int fd_src =3D -1, fd_dst =3D -1;
 	void *buf =3D NULL;
 	ssize_t size;
@@ -145,14 +146,14 @@ int copyfile(const char *src, const char *dst)
 		goto out;
 	}
=20
-	buf =3D calloc(1, 512);
+	buf =3D calloc(1, copyfile_bufsize);
 	if (!buf) {
 		printf("Can't allocate buffer to copy file\n");
 		goto out;
 	}
=20
 	while (1) {
-		size =3D read(fd_src, buf, 512);
+		size =3D read(fd_src, buf, copyfile_bufsize);
 		if (size < 0) {
 			printf("Can't read file %s\n", src);
 			goto out;
--=20
2.39.2

--js4dh7cggshs5hpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmX8fIcACgkQvP0LAY0m
WPE6mRAAsjwQc/xcDrS5sI4XAykaR1CrVsUqMl3XKKoicSn0ZAaoBBDC1D+367ec
zNmAu2cJMz+4dYiMKFJ6SVncVSIhtSm5RrKcFmcQZawt5oTfvi9Xfjs+Oaww6R6j
6MQ+2DH8vWp0x7GfBJsSn3CuESI4U/DJF41nAjeWR9TVKKBXNwGatZxWK1Q/et5X
iHir5zYzx0GdfQkTTr5cVrqLax/gTHMsWVhRX/g3L6wP176RCl1GgUeQiXfe0e2C
MbmVL9t8iMHV6AMdec61Zc+yzR9iGRia0RUXizqvyhgQxCIF9NWtJ5dkVk9t8TCV
XbqnAupGPHKWtbRdHLfPVVinYMlQ+YsoF7a/e+56Qwk/iFdMPsLbYJc+OXrbhdzt
8Ytm+r8chLGKpESfRBjokvSAqkIXn83U1LuGU17iiupTVI4UTQRnAJBWTMLbOwf+
k+lM80wcIHHcSt25W0r0fe+b/ef88aUTPTaYTDSb5hJAYQ3sFS3SiMl+K5vs0Axx
T2N2lbx/z/33BLz1kfJoiunNA9/tZQw53M3dEAn0oYVs3stC2Ejn4rtSIYnn45Kw
ORMYuGChPTOToyC6YqPwCur/+cqib9mvds2gRSFBRNz4oXcz/uKiMmYaAe2bjNSA
Yv8da8Pps7JB2Uor96HEH7B6fH6QQIM5N8b6tIilpzumfxZzWzw=
=Zq5v
-----END PGP SIGNATURE-----

--js4dh7cggshs5hpp--
