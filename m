Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8B4EC111A
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 18:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B41C83C39;
	Mon, 23 Feb 2026 19:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jr/KYJJ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A610283C6E; Mon, 23 Feb 2026 19:45:47 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BC1D83935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 19:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d18f80b5c2so3957797a34.3
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 10:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771872344; x=1772477144; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VWAB5EU7iuQvKSdIhUTutuZfFtG2OKTgdaxgmQFiKSs=;
 b=Jr/KYJJ1sQcWDD7T0/E8y9nW7l5Vi4WvM9Pv1/rM8TjUsZZc96GGTEWxxV6j+r2gwW
 t/mk3OcAZ/+n2Y/M8Y3ROOBHbhylJ+9ZZ243z0oB42C5Ilo1GhuCi8cK7s6izqgc4lio
 QdLvjQEcqHe2KTWq2Sh7PEX2cDBr8SOo3gCig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771872344; x=1772477144;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VWAB5EU7iuQvKSdIhUTutuZfFtG2OKTgdaxgmQFiKSs=;
 b=rz+V+c1UhUK7KQ/e9vmKysLDYX1UyKvmejis9zmEFlbMdQcdVfmmt4Fh0UJCavZcoR
 Ek+RPfBSIMgI84qf84p8Ly+b8oxU3iojKpSrlxNLIk8HtEkuVaBeTn7aDyXIynnXPUpI
 C5iEIocatBV2GUFxIbrckMH6YzOIULXlh0KaL3thWyPVC3W7bgxxlAxMst4CEyR73+r9
 4NHg+aL0QvDXxRK8D5alE4AAxSr0vLPurP1uTmiRJf/f34kBMhg2+5hwaXHFZPn4ABY5
 VKEEgGbKrO1UhVpah8F/TeQ4guVnBGx9sBvgJgRfpkXrSsjJ25cb4yVgJ3N0ETsTC8Fk
 L+9g==
X-Gm-Message-State: AOJu0Yylgic3oJ4cTSXWD9fMRbS7aXKt5GaYWFDOeJrGzwnAIzYtnrNV
 PODHKPjsxHyhTEogKdxRNZu7HndeWIE6Mn+0YZwPUhacjI2ua1VM40i5yeDTgr4Yni4=
X-Gm-Gg: AZuq6aKUFMOwZdZ0KVRaM4rx8rqAxSGi4z8a+7RbtnWI6juk+uq2PiijbiXcwE4rL0G
 +tEkVxQcp37MxrGaAEKfj968oEoCLQakqSacQCapCOoOauPeCvfXYvVxsOWVlyKFN8VWcWPn7Ur
 3UtXFCujH06M47WGlOmzerKtu5c0gmDD5+miq/6tVtwam+5vUXLhuZupM8B3tMDrDDlYZ28ruVV
 ob9rMfNUNE0NenH4ijGJoMA/1tEmXUiEHEUuKPAKQvrSDtiHQqS1YEHUqc/2XeL3JBRvk8CHij9
 IUsmMjd+CPPkKA+4pkZGMFBPN1iL5mbYjojickcmokrg+VMnyIdfTSc3HzYKlTIls9H9J3qVaQq
 6MWyEsBmGe+mdOmosMuZ1GzvZ7gXIw/B5Edza7WlpEx1y9fQ8kkAEwNAwK2z3mar2JXNgiStr0g
 35v6gOwaz3qzPO7ShcpQWRs7x8vKMh/rsXA16IIYqt8geETQSjJVQhn1vvDr0+qJA4REs1gLUsk
 kfvZrttLvrECFF7B/MpwXgem83VFrUpGUnTnFSE5YtBORBgCK8=
X-Received: by 2002:a05:6830:4ac6:b0:7ca:e8bf:8c4c with SMTP id
 46e09a7af769-7d52be3eb0amr7194334a34.12.1771872344016; 
 Mon, 23 Feb 2026 10:45:44 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d04de97sm7635972a34.21.2026.02.23.10.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 10:45:43 -0800 (PST)
Date: Mon, 23 Feb 2026 12:45:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de
Subject: Re: please pull u-boot-samsung master
Message-ID: <20260223184541.GD3233182@bill-the-cat>
References: <CGME20260223103749epcas1p2d9af2576eb9704b70a8572f7ccb8080f@epcas1p2.samsung.com>
 <2d9001dca4b0$74a82c10$5df88430$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OecPXXuwBzWBBbww"
Content-Disposition: inline
In-Reply-To: <2d9001dca4b0$74a82c10$5df88430$@samsung.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--OecPXXuwBzWBBbww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 07:37:49PM +0900, Minkyu Kang wrote:

> Dear Tom,
>=20
> The following changes since commit eed514b11d04a2f8a949521ad3bffba3ec98bd=
2f:
>=20
>   video: correct label for cyclic video_idle (2026-01-29 10:00:59 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-samsung.git master
>=20
> for you to fetch changes up to 11198fa347390eb449c2a0939f5f00cf510fe285:
>=20
>   doc: board: samsung: exynos-mobile: remove requirement of stub device t=
ree
> (2026-02-23 15:35:33 +0900)
>=20

Unfortunately the exynos-mobile does not build in CI with this PR:
https://source.denx.de/u-boot/u-boot/-/jobs/1383183/viewer

--=20
Tom

--OecPXXuwBzWBBbww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZygSgAKCRAr4qD1Cr/k
CkeyAQCShvfxTByDJP7d25Bmn/GI06ckuC/XbX8sbtCPiZ5VhwEA3XXSYjNwUjuh
L19OxTHqFPi+7i30XM93DBveDFdk4QI=
=VdwD
-----END PGP SIGNATURE-----

--OecPXXuwBzWBBbww--
