Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFFAC4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 13:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B6C5878AA;
	Wed,  7 Feb 2024 14:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f/hog5bA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3A6E87C4C; Wed,  7 Feb 2024 14:48:18 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0C25871A7
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 14:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-60487b4ba0eso6035877b3.2
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 05:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707313695; x=1707918495; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mtdVnP4H9UBLZBbVxinTpohZ0e44+JMzrKrxamPMixY=;
 b=f/hog5bAQkJOw8tTBJiJ6mmC7080QEfKW3ge6EktSB4RvwXrQlYmkvUkRUT6O0bb+t
 NaGH4J+Fena4oBV1BVhmRrDrEMbJtfDK27PLGwhs7Bq7gW8Q1UFB/JqiSqGjyhZxbrFb
 AG1tzOrYAk3bp+gZacDR2RWOfp3tcm8wuCjbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707313695; x=1707918495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mtdVnP4H9UBLZBbVxinTpohZ0e44+JMzrKrxamPMixY=;
 b=LdKjY3tdWtA7IRhYnYZPTEu4gMSL1aDbXbhL84Ts64OFhl+cnvbzBN3GzLm4W+f0Jh
 5ZOXdFF9RxIV7GiSClDd/t59cm+ogpJq41nKEyl69qT3vZqOW/rJX604My1dtJYEExsl
 +wvcPBKAsarDiZ8eWqm1SIajJ46f/cLZYasH7KtPXrWzF8NM/A8yquILWX286Cg7Z18d
 +lAkQeYAqCT26eK7D/1y27wfHA4XJWTrM/QleLp0EJGwYT93SH76K5M9XsEXd28aItPs
 reuCZJUjPAhKCm1dVJNUTYWtLkWVR/hlcg8aN6U3SzP1wxnolFwsEtO773ufcT1wSc6E
 shTw==
X-Gm-Message-State: AOJu0Yz4plT3GGnuJO77LFuhVUTBXT0RXwLoBQhkmUrN3+kGV00gFDi9
 BcznycYHRqwArlegcJDUzZ2eJ0jITwVJ86bjF7J9lTl9hcfqC7B+43JMUt4AogidwA5oynWg+Ec
 t
X-Google-Smtp-Source: AGHT+IE0x8XnE0HhkV7PpsXT5CA0EHawXihpgKosKULHN5lJlMTSsDLn0ED/WruaX1lE54UMwJ5X3g==
X-Received: by 2002:a81:4c94:0:b0:5ff:83be:8939 with SMTP id
 z142-20020a814c94000000b005ff83be8939mr4316261ywa.37.1707313695418; 
 Wed, 07 Feb 2024 05:48:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 fw8-20020a05690c374800b006047d393041sm252541ywb.107.2024.02.07.05.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 05:48:14 -0800 (PST)
Date: Wed, 7 Feb 2024 08:48:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [RFC] Drop md5sum, crc32 and sha1 cmds in favor of hash cmd
Message-ID: <20240207134813.GV1152441@bill-the-cat>
References: <CAByghJZqOnV8w4nJKDOjiPVUGkq2KqYS=qxps09744==oXwtZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D4MEFOPhh+hWJRTP"
Content-Disposition: inline
In-Reply-To: <CAByghJZqOnV8w4nJKDOjiPVUGkq2KqYS=qxps09744==oXwtZQ@mail.gmail.com>
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


--D4MEFOPhh+hWJRTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 02:00:16PM +0100, Igor Opaniuk wrote:
> Hello,
>=20
> I was playing a bit with different hash functions recently, and
> it turned out that md5sum, crc32, sha1 cmds just duplicate
> what is already covered by generic `hash` cmd.
>=20
> =3D> sha1 0x60000000 0x200
> sha1 for 60000000 ... 600001ff =3D=3D> 4ff5ffc91d00a95155518b920f46e2483d=
0e1437
> =3D> hash sha1 0x60000000 0x200
> sha1 for 60000000 ... 600001ff =3D=3D> 4ff5ffc91d00a95155518b920f46e2483d=
0e1437
>=20
> =3D> crc32 0x60000000 0x200
> crc32 for 60000000 ... 600001ff =3D=3D> 6fe352e8
> =3D> hash crc32 0x60000000 0x200
> crc32 for 60000000 ... 600001ff =3D=3D> 6fe352e8
>=20
> =3D> md5sum 0x60000000 0x200
> md5 for 60000000 ... 600001ff =3D=3D> e6bbbe95f5b41996f4a9b9af7bbd4050
> =3D> hash md5 0x60000000 0x200
> md5 for 60000000 ... 600001ff =3D=3D> e6bbbe95f5b41996f4a9b9af7bbd4050
>=20
> Considering that most of them (besides md5sum) are using the same
> int hash_command() function under the hood, but have a lot of duplicated
> code for handling params, does it make sense to do some cleanup and
> drop all them in favour  `hash`?
>=20
> I also plan to extend usage info for `hash` by adding a list
> compiled-in algos based on hash related compiled flags
> (CONFIG_SHA1, CONFIG_CRC32 etc), so it's clear what algos
> are available for hash calculation.
>=20
> Comments/objections are welcome!

It would be good, implementation wise, if each of those commands was
just a redirect to hash ..., similar to how "load ...." will call the
right filesystem calls. Does that make sense? Thanks.

--=20
Tom

--D4MEFOPhh+hWJRTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXDih0ACgkQFHw5/5Y0
tyxsygv/cuzVsWKT+9Ar/zh3PyqvLaRuXbv2+iRYUwEHMxjuOQTsLlqIvP1yxjuZ
goRU1bPppUn7YxMlh1bvAzFftRPAZRY0rb3JvtF5fLdBbQ3+oSmRC3LkMq9AnbwS
RPdScvR1RzEuHWOPWdNodJN/qDnC4dnKtCPI3HI3Z+OZ4QZoqSZd3LIjjezPMtNV
DrdJynbv3GskCB1Rahmp3/1unPrKnTDYjTaXpvE+yKMy1HdA8lnZszElEU+xmjuZ
MkbbMK4TBt1Xxw4PryZJfvEpOoZmuzFRQ4PoHUCA+sxFMMCzaqOhybQum9h2lwHZ
mv9CXK62ymxWDyPgHASPotQfGF956NKsJq0QDXtpCPjHPXQHRk6NuxOJIMdnwRDL
LF5DqWl5WBIfhtuaaw3O+9+svukOON+lIgVlkHB0Rc8G2piHggThtd/c5Ewwr3w7
tTGmtSr9/LCPFOSNhpSwdt0ktI6yZJBiZCSNdrOnIQDGlqe1QkCGY08g6ohIuIar
p9JfZbw+
=js10
-----END PGP SIGNATURE-----

--D4MEFOPhh+hWJRTP--
