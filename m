Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78672CD1284
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 12:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7831788150;
	Tue,  9 Apr 2024 14:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="Wqty4nu5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ED468817B; Tue,  9 Apr 2024 14:14:37 +0200 (CEST)
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz
 [139.28.40.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09A9088173
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 14:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=nabijaczleweli.xyz
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=nabijaczleweli@nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
 s=202305; t=1712664874;
 bh=D2ed9BT0RCkQTXzQzGDA+t3yschimo5ULgA58lJrrB8=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=Wqty4nu5bXlLVsCgJ1tiT/MvwWY3zpsGZYbY1YxRu9TElR/jiWe3CRAzoxOmlNubs
 SZUAi/8AZfLZKbrotEz0GH3dlkTiro8xynkuoZR0tqcH/86Uo9E0mZ62Y9iSABJIj6
 FGp9JKAX7Sy1N1lvBPO1Z4BTCuZXu/Ubu284XrSerK0FDSQuWOHBXHBXNCLKmvrpEu
 tIpwQQrSsHBjbTRMoFFvdjh9RGEqK4IPR+IFwEAIEvt+X2LduSsRZoe7YlVMMuTBBv
 KO93qipYzjiN5bmLZQ9hJ6WjBM9AulOswY6qoDhXq4Lu6csAd6iPuHUxiv1LSQ4Umg
 87eHp0fd7nJZQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
 by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 677F8293E;
 Tue,  9 Apr 2024 14:14:34 +0200 (CEST)
Date: Tue, 9 Apr 2024 14:14:34 +0200
From: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Dragan Simic <dsimic@manjaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de
Subject: [PATCH v4] tools: copyfile: use 64k instead of 512 buffer
Message-ID: <xp66c7g532kqzu6tai7enm3ribhhvftsr2o7uqfv3qmodcxy5l@tarta.nabijaczleweli.xyz>
References: <af5db6b1165d5f800f21463592779f8e@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mddm2rigptc5oo7l"
Content-Disposition: inline
In-Reply-To: <af5db6b1165d5f800f21463592779f8e@manjaro.org>
User-Agent: NeoMutt/20231221-2-4202cf-dirty
X-Mailman-Approved-At: Tue, 09 Apr 2024 14:57:26 +0200
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


--mddm2rigptc5oo7l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is a trivial but significant optimization:
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

Also extract the buffer size to a macro.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 tools/fit_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/fit_common.c b/tools/fit_common.c
index 2d417d47..d1cde16c 100644
--- a/tools/fit_common.c
+++ b/tools/fit_common.c
@@ -23,6 +23,8 @@
 #include <image.h>
 #include <u-boot/crc.h>
=20
+#define COPYFILE_BUFSIZE (64 * 1024)
+
 void fit_print_header(const void *fit, struct image_tool_params *params)
 {
 	fit_print_contents(fit);
@@ -145,14 +147,14 @@ int copyfile(const char *src, const char *dst)
 		goto out;
 	}
=20
-	buf =3D calloc(1, 512);
+	buf =3D calloc(1, COPYFILE_BUFSIZE);
 	if (!buf) {
 		printf("Can't allocate buffer to copy file\n");
 		goto out;
 	}
=20
 	while (1) {
-		size =3D read(fd_src, buf, 512);
+		size =3D read(fd_src, buf, COPYFILE_BUFSIZE);
 		if (size < 0) {
 			printf("Can't read file %s\n", src);
 			goto out;
--=20
2.39.2

--mddm2rigptc5oo7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmYVMScACgkQvP0LAY0m
WPGLIA//YTtuqh1Kc60X/BDTFEMZfbaCLrlXkBFGEts3oRxBoMG4ykUJgJkXHiJ8
GJ+Vo+EEExKQNvWYqtE4Rp8IdQ3uts9Yr2Xn3gK1LQId0guVxWn+G/4xnnutIoPM
7jMGMmUNTYiv6qzXUvn5r+U2qR4jVhgddbekt9w2+hjnQExUhx78WK5DBG+ZgBeW
8/VeV/ZA0sixPaMtOeR1SVWC2rcizhsz2cGry7bXWVYj3gF2O9Q2yGzq6ozGyfO4
EbylKBwQU13gSl+3ireS4oey5pe0SJl34BYj/0SQmr8paBXC0HxEGiho1NhsOeYK
WqGRviaFgaDObPPagBv1Iw12N/Fs3QBIJ/i5sTJqi7ehlx2rp1em/93lLNp+i6GS
b6D75+xwb693vdb6cuFLD2SatLP6FNoDnH6ggABy6SoLIna4oEsQd9PhLfPkawzx
Pgh9IVeQdMHbq4gWSZ3KEC6gBaDZ2BA/E1Je4qvx2/lBWUzslwQO/18p7ImXrvkW
ng5eamrfeVaUU6nNtTQpaRmuOxqWJFod/8kQY+xhtrwFIkVXbR+uFAAT42cw5XGB
8wWrmCjnIk28UP6rY8WUA4RMfhptlVB2BZx80Ia+uCrxym+2wI4U2FBDoDGjOwEV
OFPxkKjx5oLVF6zbqjPOPmAkPoWrMZLBxrOpizxJrSfwa+mTPxs=
=ISAu
-----END PGP SIGNATURE-----

--mddm2rigptc5oo7l--
