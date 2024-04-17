Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C59EC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 00:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D02E388004;
	Wed, 17 Apr 2024 02:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="De3wwrgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CA5988005; Wed, 17 Apr 2024 02:19:15 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5589788003
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 02:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-db4364ecd6aso5355427276.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 17:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713313151; x=1713917951; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9K+HmiEzGDXpxNgXjDksdAzBbHBDGi5Ls1Cuva6J2sI=;
 b=De3wwrgETXrgX6HdtRsb51Rh6d65+y9emjVVZDjd2GV5DO7veIXm065KUxESI19uk8
 qOAkVwVTjjRK4+Z+a7h24GHvik6Cjvi7iH76LukxHFR9+BG2cglL8R1mAQRA8Rw6vhgm
 OwYUc/fRrDHuD/P7seMjv6//c5LH5VAtqtDp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713313151; x=1713917951;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9K+HmiEzGDXpxNgXjDksdAzBbHBDGi5Ls1Cuva6J2sI=;
 b=QR205dbTcn/cxPXsypjosubDGozF6evws6E1CCua/o6d7usNyN1+UfvrJ2pJ4HujXw
 jaQAFMxHXZ/hB27Ooe355whYcgz3YkP9mCOpAYjsdhF4e/kh6TrvwRJ4BQylPYywslML
 kQisJJSzZiWPNljB4Qm3GZjGHICbDA4qpP5kkwj6uHMhnCntLYZrGynORQ4rwjYeXHqc
 GfuboOcSIj/v4vJmUDCpPTMn8RmDC3H69gEf065NPyFwoMK+WtHee9nkBKcOx9nvRWZR
 hZ98cN/L/v5fSS2Yp7Moba4UU/MKmVnt6ig0Z0SOCAfEW+g2QzJhAR4Aeg3Oop6hMJ/2
 b5yA==
X-Gm-Message-State: AOJu0Yy/jl1CdYfR6QP8UPkwLA+lSbrgrcasyOjIqJfWWWrDE1LpIOP2
 rpzA3lRuKL6m4f8QAdTwBJj20FtEr0e2i5pdnhnAJm4Jg5MBOS6hSRkEclKU6UrGjYsuKviGGem
 y88M=
X-Google-Smtp-Source: AGHT+IFbCezPNzJvPuzUzYr/Qr04VdpdzPRrpfUiUnMIaE1fqYrkISF9MK+CQBFIcFA19sf4wn41bw==
X-Received: by 2002:a05:6902:38c:b0:dc2:3279:fde5 with SMTP id
 f12-20020a056902038c00b00dc23279fde5mr14028420ybs.22.1713313151093; 
 Tue, 16 Apr 2024 17:19:11 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 cv14-20020ad44d8e000000b0069942d4cc06sm7823265qvb.115.2024.04.16.17.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 17:19:10 -0700 (PDT)
Date: Tue, 16 Apr 2024 18:19:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
Subject: Re: [PATCH 06/23] image: remove redundant hash includes
Message-ID: <20240417001906.GD1054907@bill-the-cat>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
 <20240416190019.81016-7-raymond.mao@linaro.org>
 <20240416191947.GV1054907@bill-the-cat>
 <CAEfUkUJi-CCxPo+o1TepxWTNugJhZ23X4YupowiiwLB+90ojxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tTHtyk7wStB5wY85"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJi-CCxPo+o1TepxWTNugJhZ23X4YupowiiwLB+90ojxQ@mail.gmail.com>
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


--tTHtyk7wStB5wY85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 08:13:53PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Tue, 16 Apr 2024 at 15:19, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Tue, Apr 16, 2024 at 12:00:02PM -0700, Raymond Mao wrote:
> >
> > > Remove the redundant includes of u-boot/md5.h, u-boot/sha1.h,
> > > u-boot/sha256.h and u-boot/sha512.h
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > ---
> > >  boot/image-fit.c | 4 ----
> > >  boot/image.c     | 2 --
> > >  2 files changed, 6 deletions(-)
> >
> > Can you please explain how these are redundant? It's not clear, thanks.
> >
> > Both image.c and image-fit.c include image.h that
> includes <u-boot/hash-checksum.h>.
> So we don't need to explicitly repeat "#include <u-boot/<digest>.h>" in
> both files.

OK, so lets move this to a prep series patch then please, and then later
<u-boot/hash-checksum.h> can if/as needed get the right headers for
mbedtls or not.

--=20
Tom

--tTHtyk7wStB5wY85
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYfFXcACgkQFHw5/5Y0
tyyGkgv9GUi+WjdxE9/JgxearV49zv7bFjh6M3ONl0emSv+12T9co+p4ajgB0+Si
L925u2jo4rKSND6nDTpxh2yq5J/dtBB9YLszfMjm+1OJYgxHnSKfHi1E0FBJgQoa
6mdOiCqjtJgeCB/AUHFgs0lKvEosI59iK3p0thaJN9dvU44SrvjB4w+meDXc2aVs
dQvaXQ6SMZERB6QhJT5Lbh8PcdLALNplcUuyNhpbSbEHTp22MInay+GM88P3knjt
5MCJyWK1buZ7/Pxwrd+grYEGZL5O00aEhsC8zYf7x1rbqGaoRSt6FDyXkwySRFhJ
XX4GBcpuVZal63eDWBD/bCyRYXKgvD9lXpdaLn5i6Pt44GHwWSIBC9r7CWuFNFva
coT36esssfqbKp8vaIWejtgrwHuEr6Bdk8ov6k0gR3hZZfBdcRN1bNGULavPS7z1
ZEJ96uHz2HdnRnmp87oyjatv9rDvKwnNsqrExFaa9BNA8hVeNgNfrk1nLqFv92C6
0n7OXo1p
=pBxT
-----END PGP SIGNATURE-----

--tTHtyk7wStB5wY85--
