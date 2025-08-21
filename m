Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F58BCA0EEB
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 15:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8656C81D5D;
	Thu, 21 Aug 2025 17:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Uu2BN+tA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A938081FEE; Thu, 21 Aug 2025 17:02:28 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B95680422
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 17:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3e56ff1c11eso5182525ab.0
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755788545; x=1756393345; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eXmffAm4HWWUXRoyf5ymrn1gaXah5qgCVC6G9JM1H20=;
 b=Uu2BN+tAz2OpIOt2JOEaHCr2SPsngwt01jU1LmUsg2iLZJOBcMqu3qJVF/fnd5cONj
 UGk8UJFT3l931EUkhR1r4ZZVRzW+gRIjzfyC/KOETU26XJMJFVymHQZDQFwnhbTQ+AHZ
 CUwL325R0PFXdmEawxwSqzyANr4Q6P8ER5GEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755788545; x=1756393345;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXmffAm4HWWUXRoyf5ymrn1gaXah5qgCVC6G9JM1H20=;
 b=Rptauf5FuToNxc4ozepI+djwT/cPe3L+5DUuJQh5acIIS4Ur34TcJ41QbV/HPHp2P/
 H7VH47Xx1n17v1b8dgRjQvb99+YMG8yx+Cg+0NGOg7ScASCGwzGUDHICWUWZ3hzwjBlb
 3nG6AipVvW4zMIbM6l4GbPvTyedasw74C9fsyQjlvZt72HJ888mHrthX+K2LkK8tASEz
 ZUv1w8hITGRFqbJYG0rnIQjjgs2PsQpCnlJCFX45LIGrjGKaLoVh0unlPzie14w3S+Cj
 8/hGU9QpaG4ffUsuCgkfhfoEwAB+h+kC5yy5i0apAdo3SbYUmKE8qd7dyri8JjWstgM/
 QmPg==
X-Gm-Message-State: AOJu0Yzes04k8plStyeCJukXGiQ9HrHQ2LULN1b7F6PId4lbSMJlUKtg
 Oiv/hGN7oK1mNzzXXogEjgsBof9lrytDniqw+bHY9WRGBwcctg2ck1e++NyMbEkROFF0NnJYC3o
 Fm+zytsg=
X-Gm-Gg: ASbGncskn+EchzuexFzccETVr9QjKNbxybYcoN4LMbN1YLoRh5E1k30DFrJkc7BYTWB
 /fUNDU5uaObx8aRVoB6iPttfgUV2Ucym/6dhKu5RnJUjwTNkCnK0vU+JPj9JE24xKufaxKARTQu
 Wph3rSkojJDMZMlOwVKxo1rRXha3yjKAN4wlLoXm+UZgl8mAI0KxRGsrqQju4/cYGeoHbbyeqNN
 +gt92LiDgb8/8PR/fVa4FvrDYS9gcyoTfBvJXnOInDQChvdQvJx879N9BrYcwNyDVC9gNEOutmi
 3SO+tj+hqO29jfGxJbCWBtQ0lfaWEN/Eo/xpuXjAsXuDdsqt//Mv2std2wGEUa+Wk+HkJesUpS8
 7zCmNSDAfpQR5n9MwM6X/EbWKhdp3QOyWHc0R0BmdgjQe0PkCk4LsIKIF
X-Google-Smtp-Source: AGHT+IFJTc6W0m7hewhL6RqV8tl02Le9I+ccE6H8g3SWXMuOKUdvZ/m/PUEBOkEUiddcY6YcnJXPxQ==
X-Received: by 2002:a05:6e02:3813:b0:3e5:67a6:d3fe with SMTP id
 e9e14a558f8ab-3e6d405b797mr44723415ab.9.1755788544533; 
 Thu, 21 Aug 2025 08:02:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-884702457d5sm233839739f.17.2025.08.21.08.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 08:02:23 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:02:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] lib: use utf-8 as encoding for C includes
Message-ID: <20250821150220.GK124814@bill-the-cat>
References: <20250820231711.45677-1-heinrich.schuchardt@canonical.com>
 <20250821002223.GJ124814@bill-the-cat>
 <df457055-aa0e-417f-b9dc-d35a9d5c5a0d@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rwC5grzXX6p4HpoO"
Content-Disposition: inline
In-Reply-To: <df457055-aa0e-417f-b9dc-d35a9d5c5a0d@canonical.com>
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


--rwC5grzXX6p4HpoO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 09:09:01AM +0200, Heinrich Schuchardt wrote:
> On 21.08.25 02:22, Tom Rini wrote:
> > On Thu, Aug 21, 2025 at 01:17:11AM +0200, Heinrich Schuchardt wrote:
> > > Correct spelling of name 'Joan Lled=F3' in copyright comments.
> > >=20
> > > This avoids warnings in CI:
> > >=20
> > >      Skipping file './lib/lwip/lwip/contrib/ports/unix/posixlib/lwipo=
pts.h'
> > >      due to unicode error
> > >=20
> > >      Skipping file
> > >      './lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/socke=
ts.h'
> > >      due to unicode error
> > >=20
> > >      Skipping file
> > >      './lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/inet.=
h'
> > >      due to unicode error
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   lib/lwip/lwip/contrib/ports/unix/posixlib/include/posix/inet.h  | 2=
 +-
> > >   .../lwip/contrib/ports/unix/posixlib/include/posix/sockets.h    | 2=
 +-
> > >   lib/lwip/lwip/contrib/ports/unix/posixlib/lwipopts.h            | 2=
 +-
> > >   3 files changed, 3 insertions(+), 3 deletions(-)
> >=20
> > Which test does this and can we just tell it to ignore what are
> > essentially untouched upstream files?
> >=20
>=20
> One of these:
>=20
> tools/dtoc/src_scan.py:629:                print("Skipping file '%s' due =
to
> unicode error" % fname)
> tools/dtoc/src_scan.py:654:                print("Skipping file '%s' due =
to
> unicode error" % fname)
> tools/dtoc/test_src_scan.py:87:                         r"Skipping file '=
=2E*'
> due to unicode error\s*")
>=20
> The patch only changes the encoding, not the content of a comment.
> Why would you want to use codepage 437?

I don't want to touch upstream files if at all possible. Submit the fix
upstream too at least?

--=20
Tom

--rwC5grzXX6p4HpoO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKc0+AAKCRAr4qD1Cr/k
CoEqAP0f3LZ3nXEmJXrymPtBvly5tDlbnRfejlHNac8+LVKCdgD/dpVmF0mXKsru
F5dQ22QZOt1jjxZH18QyDdvIP4qSwws=
=HE2z
-----END PGP SIGNATURE-----

--rwC5grzXX6p4HpoO--
