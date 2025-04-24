Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A92C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 17:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED2498056A;
	Thu, 24 Apr 2025 19:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ea69GAWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A46FB809D4; Thu, 24 Apr 2025 19:38:58 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D4B6803CC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 19:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-401eff272b5so137869b6e.0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745516335; x=1746121135; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lquYw0E68tD9ZRiHPHlLLLy4QsHiJPTGwvZrdFJJwqc=;
 b=Ea69GAWKzb9khjp4LnuaUzZsBqirWCJhsUSDIlvO9Y41afkeyYF1+aQfOKureCR33w
 eeFq4xRIoHS1VEcbR8JwDwYNUVFaZjDvWM8dBRGQ2GFVaQHzAV7KdVJwtIcWvah3oMcr
 5IrzJ+FcxDt9ajVUTjIefMz/n0u4c7hzrAuFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745516335; x=1746121135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lquYw0E68tD9ZRiHPHlLLLy4QsHiJPTGwvZrdFJJwqc=;
 b=KanrtjgIVyIQ6+G9qgwTKFSFhW7TpzHUlOtkF28yvT4jmbXkn9L7KwkBbdWsWTt24e
 dzd4GmngAISV9+LEu7C8oTgvkC/UosLDaCZ/ysVAT7wiCtikyUpelcV3XIsC87xT1ppQ
 J0BNJvOvcW3VgT4Yc5yg2VJyTA01QZAsqT+KtyDj4ial8EEx9dq0G/EH5kB2fgz7mRPs
 LwzqqbPfBI9G2AqPjmCERG3M7t6eK3YJWaqTf+NLkfL4ttYuIEg0Rvgu1MFlVxwU3wvj
 Er6sAZDJt91UkVUqp5m3zYMMbgWJfu3NeGaZOW7OYJ5LciuLKtQtms7Mf7ZV63ybRfAo
 /Mxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAbZkgw+yvPvhsAqdvtm+eCvnavBHmLSTiO9aou0FRzckXFXDUwgBCZBvKfOkm7vYJhGxKJ6w=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3SXHqVnHbwLyjkrWJuCSLmFzsBCx6/kA2Xtdc7ZFIWVw4H9Uc
 F5QbCecbLfBcNGBSgCA7EohjpBbE9gtH/oCXT8/KkMQ1WudUfnXZ5NURXO051FI=
X-Gm-Gg: ASbGncsXRUw1cr4qcV75Ye6H43arZr6N7DzV919dqgX4+qsBfroV2clZM0uIyLILBvX
 GHfoh+ruPftHlN/lBW/R+LbJkN5VOnl7fjnv42qLzyCDJqPXia8fE9WRzUePon4emStHtyBE6sj
 iSXSgB9e+nTBFZfVxp4d9xfvAd3QbzPd31ty4n19PDmt8RHkSFLGY/mgcET7uzb9XBLMTgosNyU
 YT70EQpXOUSg0NJf4WRHDXBria2OlBsKcmMeXx9N9VHOvsGjntDxBFphhtvDhuus6Vnevua1RV+
 LmnUu7gMduyjSHg4/jdgiKPLd3W6k8sLkfWfJfHMgJWanXyuJs8v9aXWtR7yqFel1cUNyrsdnVg
 XBQ==
X-Google-Smtp-Source: AGHT+IEjITRjlp/fOBfAr/ctMfhmaDC6dC70DcH4/bFDrumC2P+KncbMt6P/bHjRIOMrZrWKzMDXkw==
X-Received: by 2002:a05:6808:6f8e:b0:3f8:eee4:7140 with SMTP id
 5614622812f47-401f11ae193mr240149b6e.22.1745516335044; 
 Thu, 24 Apr 2025 10:38:55 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401ec9782eesm328806b6e.49.2025.04.24.10.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 10:38:54 -0700 (PDT)
Date: Thu, 24 Apr 2025 11:38:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>,
 u-boot@lists.denx.de, vigneshr@ti.com, rick@andestech.com,
 mporter@konsulko.com
Subject: Re: [RFC] Expected behavior of the go command
Message-ID: <20250424173852.GK5495@bill-the-cat>
References: <D9DXL95MTQ8I.3EUY0C6M2L4NE@ti.com>
 <CAFLszTg72Ai2V-L3MKvqDx8ROk97jiW4bvAbvFtZEAFBBp6qfQ@mail.gmail.com>
 <ad4a911f-681a-4fea-b79c-8489b47d7360@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kHtysvCS8GeVdF1E"
Content-Disposition: inline
In-Reply-To: <ad4a911f-681a-4fea-b79c-8489b47d7360@pengutronix.de>
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


--kHtysvCS8GeVdF1E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 04:22:51PM +0200, Ahmad Fatoum wrote:
> Hi,
>=20
> On 4/23/25 14:28, Simon Glass wrote:
> > Hi Anshul,
> >=20
> > On Wed, 23 Apr 2025 at 04:04, Anshul Dalal <anshuld@ti.com> wrote:
> >>
> >> Hi all,
> >>
> >> I was trying to understand how the go command is expected to work when
> >> used to load custom OSes. My use case requires getting a proprietary OS
> >> to boot using the go command on a TI K3 platform. The OS expects caches
> >> to be flushed and the mmu to be disabled before we jump to it.
> >>
> >> The go command (do_go func in cmd/boot.c) calls the do_go_exec function
> >> underneath which does not seem to have a consistent implementation
> >> across various architectures.
> >>
> >> In RISC-V the implementation (arch/riscv/lib/boot.c:10) calls
> >> cleanup_before_linux before jumping to the loaded binary. This behavio=
ur
> >> would enable the direct use of the go command for booting a custom OS
> >> (like in my use case). Though no such generic implementation exists for
> >> ARM64.
> >>
> >> I was wondering why we have the call to cleanup_before_linux for RISCV
> >> and not ARM64?
> >>
> >> Also, is booting a custom OS using the go command a supported use-case?
> >> If yes, it might be better to rename the function to be more generic
> >> like cleanup_before_os from *_linux and call it for each invocation of
> >> the go command.
> >=20
> > Yes it is supposed to do what you say. You could rationalise the code
> > a bit, so that all archs do a similar thing, or perhaps just RISC-V
> > and ARM for now.
>=20
> I ran into issues with go too trying to start barebox and I always
> assumed that go is rather meant to start programs that call back into
> U-Boot using the jump table mechanism. In that case, you likely don't
> want to turn off caches.

Exactly. "go" is really just "go $addr now", and so if things like
caches need to be flushed / disabled, that needs to happen via a command
first. RISC-V being helpful here is an unfortunate mis-implementation.

> What I settled on is having the barebox build generate a FIT image that
> can be used from U-Boot, barebox, coreboot ...etc.
>=20
> Maybe the same would be also suitable for you? Alternatively, you could
> compile your custom OS as an ELF image and boot that properly as if it
> were a kernel. Both ways would also allow you to specify a load address
> if your OS is not relocatable and pass along arguments.
>=20
> I went with the FIT route for barebox, because we can now ship device
> trees for all enabled boards in the same FIT image alongside one generic
> second stage barebox with DT support. If you want to support different
> boards with your OS image that might be of interest to you as well.

A FIT image is a good idea. It's also possible and I think more commonly
how custom OSes are done, to use "bootelf" instead.

--=20
Tom

--kHtysvCS8GeVdF1E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgKdyEACgkQFHw5/5Y0
tyyPUwv/V5g5ZrqqMSpi4SNittRbfLzbl2m75Ndy4trj7rtxBb3+Kl7u4jhdR4Ep
qnXxZg0rmzeJkLAOaKD7LUgzo0pO5xidFkpdQ50aAlCqUqTINuq8rYeHosmnT4BB
WTIt7DhkcypRPPEGTIttdHsEtLzePeuYlhLazp2ByWH2sYUy8d1h5Gq76RoGUAOA
2h3S6/kv1Zo/OxAjQAky6oao91VWk2J0MEXIOMPDRXyX0Hc2jAIG4X+5eTY3/nAx
o2zclP+cpA0p1CC8Y8W8NKY9gYhZBKAtPYb6+D6J4Xhw3HKXHPOeYcrg6ch4Lgzl
DzeuOwtOcJkFOuAc64mUnnCignuL8fBfySqpghRNDZ3IebJyxTSVjAebmYvMHuje
31uBssg++5/9A4ZGav7D7zyvV/byVi8H8CBzrCRwbhSKK3IQBsiXJlkE9lkdZTzK
C3E/w6L+gZiqfDXe2zxlJlFSK73C7/09zB5sbRQXeJ+LmRetSoTqGswe9H3VpR15
bR1s5Q2F
=swrT
-----END PGP SIGNATURE-----

--kHtysvCS8GeVdF1E--
