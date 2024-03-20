Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B83EC54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 13:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6DE788044;
	Wed, 20 Mar 2024 14:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="lA6MtpuK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3835E87FE8; Wed, 20 Mar 2024 14:08:13 +0100 (CET)
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz
 [139.28.40.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58B1D87E93
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 14:08:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=nabijaczleweli.xyz
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=nabijaczleweli@nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
 s=202305; t=1710940091;
 bh=P5MuviTN8/HiUhm5Il0XjL92z8evebBfRwusAr+odaU=;
 h=Date:From:To:Subject:From;
 b=lA6MtpuKfeaBzRbekQ/GfOfUUY9LIvqxCF0cL5Dvl/yjSOOHBnyMaFmby7ksVBJd6
 DF1r3zdVSG5rErNABuxeNdxxyYjVq81SbzwBtMGrhdfBpOiAzm8r7EuoWas2Y1tByh
 gw7mI4WaQ+hyXualgTibMrH4Rh6j6MZ8O0gMxzpbJIaJ9mUhLw2vOhA7gBQ4TO18jn
 H/MsszFLotuyR8zdwBvD/XTZEtJtoghWu/rgmUk4m3fPQlBom8KWs6qDA3BSwrml1E
 lT5KJMCO5OXGV/uGo/BR/66Va4zTiNThtju88lrGd4XRtBjLVxJEpyHYAEz1+8bDyI
 m2wzoFJIokVWg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
 by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 011171904;
 Wed, 20 Mar 2024 14:08:11 +0100 (CET)
Date: Wed, 20 Mar 2024 14:08:10 +0100
From: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH] tools: copyfile: use 64k instead of 512 buffer
Message-ID: <4le6hwyli3wl2fisv5lr3rizbqzx3g2xzytw26zcrsvgchqy6i@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="idodt6oe2hcnztxy"
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


--idodt6oe2hcnztxy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is an incredible pessimisation:
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

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 tools/fit_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/fit_common.c b/tools/fit_common.c
index 2d417d47..373fab6a 100644
--- a/tools/fit_common.c
+++ b/tools/fit_common.c
@@ -145,14 +145,14 @@ int copyfile(const char *src, const char *dst)
 		goto out;
 	}
=20
-	buf =3D calloc(1, 512);
+	buf =3D calloc(1, 64 * 1024);
 	if (!buf) {
 		printf("Can't allocate buffer to copy file\n");
 		goto out;
 	}
=20
 	while (1) {
-		size =3D read(fd_src, buf, 512);
+		size =3D read(fd_src, buf, 64 * 1024);
 		if (size < 0) {
 			printf("Can't read file %s\n", src);
 			goto out;
--=20
2.39.2

--idodt6oe2hcnztxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmX637oACgkQvP0LAY0m
WPEA2A/6A0v6cFBWMl1lgLGRM/2oKc7vBTefngnXwWdHzeCFjtOFJMSxH9nNzr1e
8G/1V9ZahDWUES5+Zb88sznWISEdoYztzgdGhTaKX/0osN2bxy0lxWX6z72Yv/zE
rQ7+VSKyEpJbTtSzf5o5Q0/Fi45CrZHISBZkdr8ObQfGmDc/VEp7Y/P8ijigyspB
EWgvR/Ey1JAUuRE/5mVblU3Comxowge2tT3PtsFIZLbbDpMY4qb4NmdTRL8R1tkr
7bf+uG6DCU0ybEUZDawp6SdrtG3S/CxI7xGEaJR6oMviwYp8VR4BvU87dIiGgi5G
sICD8ZCM45cNRREkpkXTlVSTpvDRyp85c0doQJWRqWznrbWDV4LPSwdcZjjAHMNf
SDcWaWJBnIlUmRne9jz1KvNsF6LF+q/Vbwp3GnpNfBHUfOFDpXsqbZP4q2S5m+q3
Dq6vLKUi8HpyCUZ9HfXt4XgNslGrtpiJlhTMtLcOaLFnMSumv+5SvgHImDDaPovc
0BvQUzaWIPIknG//N3Orxuvh9EF8JlBLM4Pk/U1jrBDQ5sVyBMuAO+fyoYfYmpmE
ZaLjXo6MQzfrjQdG8Gwytr8S10nfR3r0Pd4qT5oEpUbKmgCfW6H3zNMnzjbY+LpW
mo5uCc58HOQsUKLWpuIKSr8GPutmARj02l+eMlOU9j0CxuWtm9U=
=mM1C
-----END PGP SIGNATURE-----

--idodt6oe2hcnztxy--
