Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E43C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 23:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A6A0881B0;
	Fri, 22 Mar 2024 00:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="GHv7YeZl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CD7388126; Thu, 21 Mar 2024 21:37:31 +0100 (CET)
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz
 [139.28.40.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2075488013
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 21:37:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=nabijaczleweli.xyz
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=nabijaczleweli@nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
 s=202305; t=1711053448;
 bh=y1Q+2btBEkx2dxPm6YbQIOH4BPu0Kgs5IyDcGy+nJ9Y=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=GHv7YeZlJ/Zr2NE8YVgPbqRzygaETVRRVBOYNZT+i5u180L8LmUlNshjK/Db7vird
 TYApDqS7GbC15vEGmU/y+9d4EnWPT9tzw0Icg3xFgLa4KAYO7kg7DSDllJXfppZt5e
 imz1N9BCtErD+PNk2oZh2Nxyzb1FzMj4kv2Y21/78UOBnEBnvPRcmTPS0PmyOiJKpl
 yQbeSB8+4a/q/FNwp7i4b8lNX89Yv9SGJCWQTcZlQhdlVzM4To2E19UGakOf5rR6Z4
 RNMQe4KI3NTiZ8cU1CJoU4OV1gc+gaZ0Ph13Y090m9Fz+yg+f0pqzmqkGpLw4Pibag
 vtyYtz5f9GzsQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
 by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 9CE271A08;
 Thu, 21 Mar 2024 21:37:28 +0100 (CET)
Date: Thu, 21 Mar 2024 21:37:28 +0100
From: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Dragan Simic <dsimic@manjaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de
Subject: [PATCH v3] tools: copyfile: use 64k instead of 512 buffer
Message-ID: <u2jkzgrq4tbtvvazqzamuixjiwhdrwvnla7sdbfm6ia2si52i7@tarta.nabijaczleweli.xyz>
References: <2894747cef36c9533b2915b803ce754f@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d6hfr6llxbc36ewq"
Content-Disposition: inline
In-Reply-To: <2894747cef36c9533b2915b803ce754f@manjaro.org>
User-Agent: NeoMutt/20231221-2-4202cf-dirty
X-Mailman-Approved-At: Fri, 22 Mar 2024 00:35:38 +0100
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


--d6hfr6llxbc36ewq
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

Also extract the buffer size to a constant.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
---
On Thu, Mar 21, 2024 at 08:49:52PM +0100, Dragan Simic wrote:
> On 2024-03-21 19:29, Ahelenia Ziemia=C5=84ska wrote:
> > This is a trivial but significant optimisation:
> s/optimisation/optimization/
This seems to run counter to precedent of not doing americans'
imperialism for them for free
(I see -ise/-ize in free variation even in my 100-deep checkout).

> > +#define copyfile_bufsize (64 * 1024)
> This is not the right place for such a preprocessor directive.
> Instead, it should be placed at the start of the file.
>
> Also, it should use all uppercase letters.
FTR, neither of these points seem to be universal;
I modelled this after tools/mtk_image.c (also cf. scripts/kconfig/expr.c),
but there are at least 25 other function-local macros
(as in git grep -B1 '^#define' | grep -c -A1 -e '-{' returns 27).

Also kinda weird to explicitly request a macro
only to review it back to a constant, but whatever.

 tools/fit_common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/fit_common.c b/tools/fit_common.c
index 2d417d47..37066203 100644
--- a/tools/fit_common.c
+++ b/tools/fit_common.c
@@ -129,6 +129,7 @@ int copyfile(const char *src, const char *dst)
 {
 	int fd_src =3D -1, fd_dst =3D -1;
 	void *buf =3D NULL;
+	const size_t bufsize =3D 64 * 1024;
 	ssize_t size;
 	size_t count;
 	int ret =3D -1;
@@ -145,14 +146,14 @@ int copyfile(const char *src, const char *dst)
 		goto out;
 	}
=20
-	buf =3D calloc(1, 512);
+	buf =3D calloc(1, bufsize);
 	if (!buf) {
 		printf("Can't allocate buffer to copy file\n");
 		goto out;
 	}
=20
 	while (1) {
-		size =3D read(fd_src, buf, 512);
+		size =3D read(fd_src, buf, bufsize);
 		if (size < 0) {
 			printf("Can't read file %s\n", src);
 			goto out;
--=20
2.39.2

--d6hfr6llxbc36ewq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmX8moYACgkQvP0LAY0m
WPEFexAAlYL9Mcxnu+1UDR+M0UoFIr0Yce41C21xSf2vNGklIgmcXQd2WN266RGN
X7R9I64C6/qMbuswdzKxoeekykGETbokxw+4tPHaMcGgJb0/ipyZcvI737LxL+aY
8iWXLI8fvYXEFzaCm4BBvKTx28IUbK/EPboz13el/IIQm9pj+1qYVinqUBfceeXu
67Y/fMthL+/VxDjEQre3ZHpjf4Cy78A3MCvRoyS8QCJ6A5XMAagmeyFoTgyCBEzo
3l5QsJccVekqH6WkpESjUZDSMljMdc59tQrumoEC2EwwRYBs0Lqni/gomj5iwZtt
eBx19U+9fbVbTfHJN7C3pFfQWcLmIU/6S2nblzVe0xnllAczKXl4hlTo4BcGXKK6
ZF5tPKQCbSxB37t9AYNRNEgfY+vMCKJWZ1Dmz/6bfUfnIAGrPTxLXP39ZHEbUx3C
odA8L0x4Ci9PjsjA7NEJC41j2LA/trXMngC2PMup/YE5+eNVeFwbE81cwBxUB9Xh
KcQspUieANl4X7lhcGKq715FpaiOxjrGnWxPY9rWT8pY4yIsddVphoTMcojcag/2
yV6YlrAJkVJLDmTBZVHlJsPviAD5AfuuU7Mq3To9XmaGhVCwJSDBbzHJrSXtHO5B
D9GKwVS/E8+M6EdrF34jJGNwvnBMKJcou+PPJp/nUD7JbL2kKXE=
=Uvhu
-----END PGP SIGNATURE-----

--d6hfr6llxbc36ewq--
