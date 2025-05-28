Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED5AC5B54E
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 14:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E97D883290;
	Wed, 28 May 2025 16:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WBfu2sNJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E01483291; Wed, 28 May 2025 16:19:53 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3122E8328D
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 16:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2da73155e91so1471748fac.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 07:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748441990; x=1749046790; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LpssntYILGO2x3v8et6mOQ3pxjHE0eA9pwlNMtx2L+c=;
 b=WBfu2sNJFlR6YNr4OZSfg2ChbPZ1/gFU/l2sEs6I9NXgzWfpqJPbELOq+/aCy+N477
 i2HjUFdKOvrTZwnTuAtD1wJshAVS40gAfz0MzIb0fiehIXzI9QpvEtsm4NErjJZ8+PdF
 EDHERv5UUl43bx2v3p4rJqDd531hyc/9XcXDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748441990; x=1749046790;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpssntYILGO2x3v8et6mOQ3pxjHE0eA9pwlNMtx2L+c=;
 b=L+uh1His6OzfdHb6bmcCueL6DJQERgU16F+wDJP6Li0w1GRKbTict12Avk7s2XeBYV
 NxEPpwepRM5Ajd09DC4CWjShgThEuP0+YU5o0ZFNC3+7g2aGkc2qsLnrKLF8fyWleQOo
 U08fVkm/pSKlzg+RQ0kNajM/mZhgTpSv3Ec9dBBkCSrZoyDEmA1E8fLQHQK+O2OkdbIW
 QMXsLYhoqLFFrZl527uRRhQvuHK3ApZnutUe5Hz6lXh/VXp2Wr3IO41KMa4wzRBsTx99
 QVpx+kyOKiAo+OzLdcz2PlFimB6+HbwM4S2RzaeAPpjvExD4fJcceHwSu4RFIR7JdxTr
 u+rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQjr4gm5dzw4yV3BS3TlvhzvU2pqEVDKyQYI23GMKeLIiKDqiL0GiSlOTx5TUrFacO66742G8=@lists.denx.de
X-Gm-Message-State: AOJu0YwEPf8Zvv1A3NyGz99jCgzC/Arcr6NC3vavkjZ5PttwrrC8vVv7
 VJWh5DZXdHLBDGK67odXKZPZqNViPQNN+QxfrFH1KeF3BdIlImRjyteObmKo+GH12J8=
X-Gm-Gg: ASbGnctDY80WB1ORnaLtIjPuNJHe1kFvJHGgpeq016wXYlc3m5OQQChZfFdo42HjYWz
 5jP03rf9DNX3HjE6Yzk/wKTCQExyOH81J6L99qhHzb11RRpH3usg3O+AXAmdFfCWc+cqWnccqCt
 neCfN84UQkzQYVhEfv6jc4lXzp7d+Del2qLofwAaxqNiXtSkdJ0okAL0DUxPfU9hYDulDWKSo1G
 dqZ9zLDU+ZjSiwpkKlBi/jq12GcLxvO6J/GIQuUO9w70vXIvmb2nbrRZd7JDByTnJ1kkv8jjqh1
 K5WSzlcXs+Ycn9/UvxG/V+FextWfSqY/50+QI/VZTPgQCJLfH0kDPhnVOUhASfRwgnQo2FY68tv
 foEGbwYanQys1
X-Google-Smtp-Source: AGHT+IG+3Jut3ALjIK1KL46g7cdeAL8gI5B9Tw1XaDL+0X74+vLf2oTjEhn5k/gPxsJvfZfv4f2qHw==
X-Received: by 2002:a05:6870:898a:b0:2d4:e96a:580d with SMTP id
 586e51a60fabf-2e861e6c94fmr7577288fac.16.1748441989696; 
 Wed, 28 May 2025 07:19:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e8e1a36937sm243332fac.32.2025.05.28.07.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 07:19:48 -0700 (PDT)
Date: Wed, 28 May 2025 08:19:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] makefile: fix Clang link error when
 RSA_PUBLIC_KEY_PARSER is selected
Message-ID: <20250528141945.GV100073@bill-the-cat>
References: <20250527210508.1488509-1-raymond.mao@linaro.org>
 <6b992b47-de7c-45ce-9c3c-ca4a2295f7c9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SCEFuIxcxeG8+8TJ"
Content-Disposition: inline
In-Reply-To: <6b992b47-de7c-45ce-9c3c-ca4a2295f7c9@linaro.org>
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


--SCEFuIxcxeG8+8TJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 10:25:06AM +0200, Jerome Forissier wrote:
> Hi Rayond,
>=20
> On 5/27/25 23:05, Raymond Mao wrote:
> > MbedTLS bignum module needs '__udivti3' which is a 128-bit division
> > function provided by the compiler runtime, typically libgcc for GCC or
> > clang_rt.builtins for Clang.
> > Thus 'clang_rt.builtins' library is required when building using Clang.
>=20
> How do you reproduce the problem? Can you give the config and build
> command you are using?
>=20
> >=20
> > Fixes: 13de8483388c ("mbedtls: add mbedtls into the build system")
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  Makefile | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Makefile b/Makefile
> > index f88684947ee..16506dcaec6 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -37,7 +37,6 @@ else ifeq ("riscv32", $(MK_ARCH))
> >  else ifeq ("riscv64", $(MK_ARCH))
> >    export HOST_ARCH=3D$(HOST_ARCH_RISCV64)
> >  endif
> > -undefine MK_ARCH
> > =20
> >  # Avoid funny character set dependencies
> >  unexport LC_ALL
> > @@ -915,8 +914,13 @@ PLATFORM_LIBGCC =3D arch/$(ARCH)/lib/lib.a
> >  else
> >  ifndef CONFIG_CC_IS_CLANG
> >  PLATFORM_LIBGCC :=3D -L $(shell dirname `$(CC) $(c_flags) -print-libgc=
c-file-name`) -lgcc
> > +else ifeq ($(CONFIG_RSA_PUBLIC_KEY_PARSER_MBEDTLS),y)
> > +# mbedtls bignum needs '__udivti3' - a 128-bit division function that'=
s provided by clang-rt.
> > +CLANG_RT_DIR :=3D $(shell $(CC) --print-resource-dir)/lib/linux
> > +PLATFORM_LIBGCC :=3D -L$(CLANG_RT_DIR) -lclang_rt.builtins-$(MK_ARCH)
>=20
> I'm afraid this won't work when cross-compiling because the compiler-rt
> builtins libraries are usually not installed with the compiler.
> For example on my Ubuntu 24.04 machine:
>=20
> $ clang --version
> Ubuntu clang version 18.1.3 (1ubuntu1)
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin

How about if you use the llvm.org packages?

--=20
Tom

--SCEFuIxcxeG8+8TJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg3G4EACgkQFHw5/5Y0
tywfSgv7B+NQApw8uwdZuxttu4dR8ZugQ8L60BAD87qU/KIR73SdhwwhpIQpdShj
gUpwSrzQF4XboDbb+x/kFSp2mt3sk+bI1Nx3UBCU8MtrzeW7RfPYKEkdERd2nwC9
FuWs4qgwlc5/RX9XuUgG9WatyBJKtVwIx6Qd6ZIYE/O7l/bcHCSnHWD/8Oi47vJU
ycb1N2bHeuwq4xclpcsgSmn409fJpRjzuoEpnYFjhF+c1TsjtoWbLUbuD78L34Mr
3qcoYVZ8OoXnxXhQ+HDnj6wZt6n5ZWYelFwZ89Q2Y0re3a2Hrjw/5LgRtojkfNw7
39r0doQEJXAnFmMq342ukIC+h5CV9ya7SEfeDFkvgoccQfcPWN1MW5G/jmUZUAUC
bYVpSPkb/bTOVMl31NRfWpqSLiQchQim5e6uc8i9oGDVLLEa0Lkg3BKwDowoiSDx
56VqSbUtEAjGxD9p3Tkqfoy6tcpcOaeEmQKJ0FB5Y9MsIouO59bKwG9YkVc+OC5Q
RLivSV8j
=4wU1
-----END PGP SIGNATURE-----

--SCEFuIxcxeG8+8TJ--
