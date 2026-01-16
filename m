Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E937C982FE
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 21:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87CC783952;
	Fri, 16 Jan 2026 22:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nX34eGnw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82C2B83956; Fri, 16 Jan 2026 22:04:44 +0100 (CET)
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com
 [IPv6:2001:4860:4864:20::41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDE908394E
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 22:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-3f9ebb269c3so1389965fac.3
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 13:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768597480; x=1769202280; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uXG8s6omFoE8npmUuH2thq5EYJE6KzUZEQ79/r6QVwU=;
 b=nX34eGnwkjTKfHeRZmiI51b2XQwuEaNRiayC4EmgkS+g5GSxIrH5hSmy3MCgeKmwiU
 j3mtSgSKCOlSQ/W8aEbEzdUK40X0kAg8iYEA+sdSFz2DBgeOIyrm/mwbFf/tBj/7NJHj
 I8RBANs7A+uV98OFjChnJKYD1aPSFh94OFBlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768597480; x=1769202280;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uXG8s6omFoE8npmUuH2thq5EYJE6KzUZEQ79/r6QVwU=;
 b=tk9R5YoI225gLjgQIV1PQHXgRgc1qU8krF1MDOOC0MNyCzOhrmXJOBx4WuQ/hN3p81
 yNOyBNuSm79bbqhhlW2tiP0UoOCRufSHtIBCGwUr6M4j3ntvCrmTd808TQ/cSw2N3qYe
 SK3EpTSDeJVUQdNX0vs89fleadPD4YGJTRSMKvjF1OB7ea2TAMeWIQqq9a5OfA1jOcFH
 YD4guuBiVOd4gVw/urV9keJhVxh9W9/XLVidazF53y12jlwhKdCrI1RQ03qsQr+AinZW
 fsDDBIedKOwr3gQw5k9xehK4+9fAmJUZfH6GWsXxOGNXxK200dk/ioqcAjMS9s4QTT/a
 h54A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7+xaAQDfUR+joZIR53BCPXAFj+bLzMkxWKujjU1UxXJA1XZeRTHVHWKvMsD7otXayz2UX04w=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0P871XFSFPAzOGzIW3zuFf4OF0vLIgstb0Kn84eaDaZneiEx9
 zHVYsjM4ox0GFU3ZMBZ7rfBWr3pQo5ooVOGnWGU0N4uWgUDAcOSw6tw4QZauOroqipA=
X-Gm-Gg: AY/fxX79flag3tqkHuwcPDbwYhH7ptkAm1d0v0pDin/UV/PTOBJ+PSGE5qhDIZbqF7s
 t5wo5Q9o2DBpQ7qzHyahFtORWGJru/XyM5gRe6UHfvp0Fx6rlC0bLedKrOMG9mHQChBq4hokwx+
 0umm/bbtGNMxXFwRFPDa/JM/N2OeyAiTUoDTWLiZ95DZnhXKG6+0ivzI9uAQXjtkhU0+LpCCjff
 EPXvzbLWwEvH/vcNmjn5jQ24i9FOGj79CUXPCyFITpqmUcm/BuanULYtMLA1XBfB1kEt1Wh4NJR
 WfwRSrk+14AFeUD3UnWC6s6Q8VLADx2/nHfPz+nrUhgsFoxwPo6hzUyctH3UP0skJbIAcqH4axV
 D1zZUBvNRFN9c+36qjI29Cqck0iD8rZK5kaBUQsaMIqF0/MrTLQ5eqZbXjuHa28DTjW6ZzusGxW
 1HFNmnFl8S28a/uJuy1cUqR09WwWH4rwLxDgIr8Q47+6QJrSNGJBvzVi0PEPNytA/JCBvvQVa0Z
 /orsKVAIpVKX9iXQqvOIIndoeadNy7FukbHGnE=
X-Received: by 2002:a05:6870:9623:b0:3c9:7378:39a9 with SMTP id
 586e51a60fabf-4044c16399fmr2281546fac.8.1768597480486; 
 Fri, 16 Jan 2026 13:04:40 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044bd1488esm2524340fac.11.2026.01.16.13.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 13:04:39 -0800 (PST)
Date: Fri, 16 Jan 2026 15:04:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Eddie Kovsky <ekovsky@redhat.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, mark.kettenis@xs4all.nl,
 Quentin Schulz <quentin.schulz@cherry.de>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, u-boot@lists.denx.de
Subject: Re: [PATCH v2] Add support for OpenSSL Provider API
Message-ID: <20260116210437.GR3416603@bill-the-cat>
References: <20251027195834.71109-1-ekovsky@redhat.com>
 <c2b48b27-9d4e-4be8-b94a-4aac7ef922a8@cherry.de>
 <aSCsgniomRMN0u1m@daedalus> <87fr9h5swg.fsf@kernel.org>
 <aUmB_fvpK1macga7@daedalus> <87zf6sflkr.fsf@kernel.org>
 <20260106003347.GC3416603@bill-the-cat> <aWqK4eo83-ybjlCQ@daedalus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3CNhsOS8SapyWUvZ"
Content-Disposition: inline
In-Reply-To: <aWqK4eo83-ybjlCQ@daedalus>
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


--3CNhsOS8SapyWUvZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 12:00:49PM -0700, Eddie Kovsky wrote:
> On 01/05/26, Tom Rini wrote:
> > On Mon, Jan 05, 2026 at 10:36:04AM +0100, Mattijs Korpershoek wrote:
> > > On Mon, Dec 22, 2025 at 10:38, Eddie Kovsky <ekovsky@redhat.com> wrot=
e:
> > >=20
> > > > On 12/11/25, Mattijs Korpershoek wrote:
> > > >> Hi Eddie,
> > > >>=20
> > > >> Thank you for working on this. It would be really nice if we could=
 build
> > > >> U-Boot on more recent Linux distros without bridge packages such as
> > > >> openssl-devel-engine.
> > > >>=20
> > > >>=20
> > > >> I also don't linke this double negative.
> > > >> As you already shared, Linux solved this via:
> > > >>=20
> > > >> #if OPENSSL_VERSION_MAJOR >=3D 3
> > > >>=20
> > > >> Why can't we have something similar?
> > > >> See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3D558bdc45dfb2669e1741384a0c80be9c82fa052c
> > > >>=20
> > > >
> > > > Hi Mattijs
> > > >
> > > > Yes, we could also implement it this way with the extra USE_PKCS11_=
XXX
> > > > symbol. Jan's original patch I based my work on does something simi=
lar,
> > > > and I perhaps oversimplified it.
> > >=20
> > > In my experience, when porting things from the Linux kernel into U-Bo=
ot,
> > > we try to keep the code as similar as possible. This helps reducing
> > > maintainance burden.
> > >=20
> > > Sometimes, we can't do that. In that case, we should explain why.
> > >=20
> > > Do we have a strong reason for *not* reusing OPENSSL_VERSION_MAJOR wi=
th
> > > USE_PKCS11_XXX ?
> > >=20
> > > [...]
> > >=20
> > > >> >>=20
> > > >> >
> > > >> > It's not the prettiest code. But I'm trying to be very conservat=
ive
> > > >> > in making these changes so that no one's workflow is disrupted.
> > > >> > Developers should be able to build U-Boot with the latest OpenSSL
> > > >> > without impacting developers who are in environments utilizing t=
he
> > > >> > Engine API. The goal here is to preserve feature parity between =
the two
> > > >> > APIs. Adding support for custom Providers is outside the scope o=
f this
> > > >> > change, but could certainly be added later.
> > > >>=20
> > > >> I'd be in favor to drop CONFIG_OPENSSL_NO_DEPRECATED all together =
and
> > > >> just use "#if OPENSSL_VERSION_MAJOR >=3D 3".
> > > >>=20
> > > >> Tom, or anyone else, is there a particular` reason for gating this=
 in a
> > > >> Kconfig ?
> > > >>=20
> > > >> The oldest Ubuntu version that seems supported (22.04) already has
> > > >> OpenSSL version 3:
> > > >>=20
> > > >> $ podman run -it /bin/bash ubuntu:22.04
> > > >> root@6dc347676b8a:~# apt update && apt install -y openssl
> > > >> root@6dc347676b8a:~# openssl version
> > > >> OpenSSL 3.0.2 15 Mar 2022 (Library: OpenSSL 3.0.2 15 Mar 2022)
> > > >>=20
> > > >
> > > > I assumed that we would want this to be an explicit config option, =
but
> > > > logically there is no reason that it has to be. I'd be happy to spi=
n up
> > > > a v3 if there's agreement that the Kconfig isn't needed.
> > >=20
> > > Tom, do you have an opinion on this? It seems you are listed as
> > > maintainer for this (THE REST).
> >=20
> > Yes, sorry, I think part of the question here is how it plays out with
> > LibreSSL and other alternatives to openssl, which ends up being a Mark
> > question.
> >=20
> > --=20
> > Tom
>=20
> I am being careful not to break backwards compatibility here. I've
> written the patch so that anyone who needs to continue using the Engine
> API can do so.
>=20
> The LibreSSL project implements the OpenSSL 1.1 API, but does not
> support the OpenSSL 3 API, and to be the best of my knowledge does not
> intend to support the Provider interface. During the V1 discussion I did
> ask Mark to verify that my patch preserves backwards compatibility with
> LibreSSL as intended.
>=20
> Tom, regarding the other question, would you prefer that I implement
> this using just #ifdefs without the Kconfig option?

Yes, lets follow the kernel's example with just #ifdefs, thanks.

--=20
Tom

--3CNhsOS8SapyWUvZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWqn4gAKCRAr4qD1Cr/k
CpcSAP9Igfc1Cs9qWR0+GHYUqdcPEaDtkFu2aIkN7TWqIkjtRQEA9Ad6vuBGX1dc
l1UFSxuxxTQGXFXCFgCYFW9ndyXE7Ao=
=krKG
-----END PGP SIGNATURE-----

--3CNhsOS8SapyWUvZ--
