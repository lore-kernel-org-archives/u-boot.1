Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB3FC28B30
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 05:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DE1181DCA;
	Wed, 26 Mar 2025 06:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEA388186D; Wed, 26 Mar 2025 02:46:43 +0100 (CET)
Received: from mail.wgdd.de (mail.wgdd.de [5.39.82.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D23CD8083E
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 02:46:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=dleidert@debian.org
Received: from [192.168.199.109] (ip-109-091-155-077.um37.pools.vodafone-ip.de
 [109.91.155.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: dleidert)
 by mail.wgdd.de (Postfix) with ESMTPSA id D56C38012B
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 02:46:40 +0100 (CET)
Message-ID: <1f48a22cb1376fb09e6efcaa696e0602831a2f3e.camel@debian.org>
Subject: Has CVE-2024-42040 ever been addressed?
From: Daniel Leidert <dleidert@debian.org>
To: u-boot@lists.denx.de
Date: Wed, 26 Mar 2025 02:46:39 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-6AocDJRsVRVci6B02VQ5"
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 26 Mar 2025 06:01:30 +0100
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


--=-6AocDJRsVRVci6B02VQ5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

CVE-2024-42040 was published last year. But I cannot find any response
to it, nor does it seem that it has been addressed yet. Has it been
missed? Will it be addressed in the future?

Regards, Daniel

--=-6AocDJRsVRVci6B02VQ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvu1N7VVEpMA+KD3HS80FZ8KW0F0FAmfjXH8ACgkQS80FZ8KW
0F22ehAAsfv6xqHE4Gl1vSo6SDJFgs4jjxYHmSS8jeUgOLA0oOInOO6sMCs7oSkN
Z9OlSuMdNsCU/ZtvKfFl8cxuIYhyW1BmOxo4YTwmWbnonSimFTNogxmXEARWyivg
lCKDU7iZ4VMYejJ90ExJjuhtH3PIoYM/68Y8hPvlHoL0rE2yl3TmG3QAuJAjzEQ8
VXiVpILjx+SbdUbewXXhEHB+GaXSnLJ7qdjsYAYa4k8mGlKV6pzv0twZU1pOhyr+
aT6WQArNIe1WaueEQBq+SObJamh64auvvs0S8GP30OHnTbeN1GbWkdgi8JrJuXF/
Rv+p+Luv7Dr2EZZG5FNfvWsf/k6/i7YrzBypCsax4onlYONj+82sbz/wiiR01qb6
WxDfBw/reIGFSS5FSMaPK6c2gGKd/RM95jxrvQVCvz1y38N+FBjMdHao5p3c7o9a
DzV8etChR7ZyncDJoy2nJiKWQXB0wTJlTbomw4eghSGR9FsloLrscqyoOfc+pEkV
/0/0RRWJvrJLHpcmNW1ThwdiZbIQ8QYUo+wFNVEEKy65KNHu4/02hzbtq0VaFmtT
j/S9v77k179+7nSPMTPuw+dDn6bAOpEC19viQQ8TapxlM9DCuBNuB4yaJ+bz6TOL
cujZb6EWTI6Jeq5MEPx57311b0ND1wunsCx7oBFzKAEgEd0Z2Tw=
=2rZP
-----END PGP SIGNATURE-----

--=-6AocDJRsVRVci6B02VQ5--
