Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00ECC3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 15:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 154008211F;
	Wed,  7 May 2025 17:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z5ShfTgK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 160CB8212F; Wed,  7 May 2025 17:47:18 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF3E81F32
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 17:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72c3b863b8eso2771239a34.2
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746632833; x=1747237633; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hi+OoBVGk2u7g/mmAaFKSybRxZor+9v3vRIlYdLuz9Y=;
 b=Z5ShfTgKpZ7s6F4RUTBtK7FhoPXYyx1f7eUKRzylD/HSuzhIOJdrKABB32nxxItlKc
 IaQIswYVZc4oNODiEUTapt+TlQx3C/YeME86dMdHDrcRws6Ej7C6w+u1hXQAqsFNkUH2
 CV3LJUtzSFFYymyZa7J9P5tApyCMdrv7zhwg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746632833; x=1747237633;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hi+OoBVGk2u7g/mmAaFKSybRxZor+9v3vRIlYdLuz9Y=;
 b=LDHJ6AZxGX0fWLsWoz+0lXpOXDwgKThf5iyM4Q0ESs6iDyxCYULclM3Gys9red3Mhv
 boT8V81493IBv2XptZ38I+EuvqZRY7N33iH2yUT0u/78j3/wc/W1Rp9C03f8M5mEQONQ
 yKhMexkdygr9A1P0HJ4NoqkWUow7JV5xaIt3LrldqCNqOD8tZ7uMCeuQODdgoNGZZ3UD
 QFyzTXAYNBjovyGNDCkdzsYwCYnj03B5FJQ3RbUhaTkIJLEkswzrx8o7BXmEoKu/AJPL
 SBbkBnq9HtHnPc046X9TVsAPkwI59opluz/Tjyg1odUJmTDaSr5u2M04kVxIK31HECe1
 ifKg==
X-Gm-Message-State: AOJu0YykiSQcFilrRVPX7s3bzQb5b59l/Rr7KtGXWeMIV5tSh3j2N6jZ
 1A8hHwu1dU9pf+EtbpfILxMQvYNndAN8dsLsHUn0JRkxEQzm4XH9FPPx0uQZW6c=
X-Gm-Gg: ASbGnct3H1jZPMK+usfKuc7oPGyd4D8JktdtWNy9MYZFREdo0EOVF12Fh9R1wPyzV8o
 zfjMPhbqgKdja5eaEF49Mblm9mOInnQV2ZS0Zo2xU3kRsQ4RMiPbYm2beC7jnnzInck3G8zxpQW
 +ZfbCQCA6Yv4caXYB4XKZV8vcnBBxD2TIoPty2fqsIuWXR2mjkFV3DByV0tfFXMBc5Ped7GvcUH
 Y/wjpXImvkQgLY+fUSs2IL3C78Zge+Sk/ZL1AIT1FRCQ77y16g+bMB/EGIHC6ZMb2hRfsmxehil
 onEsTd9VwQvLgTXKtoSiEDqPQgjpqZiEHAd8daPDVdyTMv8kvdN9sBw1LHCCU/iVVfHvkUBF1CX
 6ww==
X-Google-Smtp-Source: AGHT+IHWwgt0o1pehtAvvrNgyyMSGJLDzjG1f/SB00YWgXcjU1poTWTWNfXQsLRZ84PjtfVgSYTuUQ==
X-Received: by 2002:a05:6830:6502:b0:72c:3289:827d with SMTP id
 46e09a7af769-73210b14e75mr2237682a34.18.1746632833442; 
 Wed, 07 May 2025 08:47:13 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73210a1acb1sm594727a34.38.2025.05.07.08.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 08:47:12 -0700 (PDT)
Date: Wed, 7 May 2025 09:47:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH v2 1/3] Bring in linux/limits.h
Message-ID: <20250507154710.GK5430@bill-the-cat>
References: <20250418105919.1645824-1-sjg@chromium.org>
 <20250418133943.GK5495@bill-the-cat>
 <CAFLszTgaqCyK5t+5XqbW6SZ-vC1PCUv4h+YPqt0Zem1yXEn4AQ@mail.gmail.com>
 <20250507152323.GJ5430@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WelmGM+JEqjKdC1r"
Content-Disposition: inline
In-Reply-To: <20250507152323.GJ5430@bill-the-cat>
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


--WelmGM+JEqjKdC1r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 09:23:23AM -0600, Tom Rini wrote:
> On Wed, May 07, 2025 at 10:47:13AM +0200, Simon Glass wrote:
> > Hi Tom,
> >=20
> > On Fri, 18 Apr 2025 at 15:39, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Apr 18, 2025 at 04:59:13AM -0600, Simon Glass wrote:
> > >
> > > > From: Simon Glass <simon.glass@canonical.com>
> > > >
> > > > Add part of this file from Linux v6.14 so we can include it from the
> > > > linux/overflow.h file. Drop the relevant section from kernel.h
> > > >
> > > > The top of the file is omitted since it defines things used in mbed=
os
> > > > and we get an error on SIZE_MAX.
> > > >
> > > > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > > > ---
> > > > Error is:
> > > >
> > > >   In file included from include/limits.h:6,
> > > >                  from lib/mbedtls/external/mbedtls/library/constant=
_time.c:14:
> > > >   include/linux/limits.h:7:35: error: missing binary operator befor=
e token "0"
> > > >     7 | #define SIZE_MAX        (~(size_t)0)
> > > >       |                                   ^
> > > >   lib/mbedtls/external/mbedtls/library/constant_time_internal.h:65:=
6: note: in expansion of macro =E2=80=98SIZE_MAX=E2=80=99
> > > >    65 | #if (SIZE_MAX > 0xffffffffffffffffULL)
> > > >       |      ^~~~~~~~
> > > >   include/linux/limits.h:7:35: error: missing binary operator befor=
e token "0"
> > > >     7 | #define SIZE_MAX        (~(size_t)0)
> > > >       |                                   ^
> > > >   lib/mbedtls/external/mbedtls/library/constant_time_internal.h:71:=
8: note: in expansion of macro =E2=80=98SIZE_MAX=E2=80=99
> > > >    71 | #elif (SIZE_MAX > 0xffffffff) || defined(MBEDTLS_HAVE_INT64)
> > > >       |        ^~~~~~~~
> > > >   make[3]: *** [scripts/Makefile.build:256: lib/mbedtls/external/mb=
edtls/library/constant_time.o] Error 1
> > > >   make[2]: *** [scripts/Makefile.build:398: lib/mbedtls] Error 2
> > > >
> > > > Changes in v2:
> > > > - Add new patch to bring in linux/limits.h
> > > >
> > > >  include/limits.h       |  2 ++
> > > >  include/linux/kernel.h | 12 ------------
> > > >  include/linux/limits.h | 21 +++++++++++++++++++++
> > > >  3 files changed, 23 insertions(+), 12 deletions(-)
> > > >  create mode 100644 include/linux/limits.h
> > >
> > > Ugh. I think we need to:
> > > - Fix lib/string.c (and Fixes commit 7c7361b98d6e ("lib: implement
> > >   strnstr()")) to not bring in <limits.h> as that should be limited to
> > >   mbedtls usage.
> > > - Not bring <linux/limits.h> to <limits.h> to start with at least (we
> > >   can worry about handling wrappers around overflow protection there
> > >   separately).
> >=20
> > There are quite a few places which need the limits. If I remove the
> > dups from kernel.h then some things don't compile, at least not
> > without including linux/limits,h in limits,h (which it seems to me we
> > should do).
>=20
> So, looking at things more to understand the problem, mbedTLS uses
> constants for types (reasonable choice) and the Linux kernel uses types
> and casts (also reasonable choice), and these can't be mixed and
> matched, that's what results in the error you see. So, I'll re-evaluate
> your v2, that might be the best compromise.

Yeah, for v3 you need to address the comments on 3/3 still.

--=20
Tom

--WelmGM+JEqjKdC1r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgbgHoACgkQFHw5/5Y0
tyzjtAwAgDRGyJvwPdRfMqrW1kEp01uFtiMx2n27nuWnWdXsOoW4f09cdvBfBUb/
GY0eVuBvPLDm4pO56EeCT8jmHaiUjAYW6hQ+JFsc6FFF00X2cfM5pIiTdXygruds
wxMTBVFKABmnOUqB106AvHyI4oVK7n+NOSt3/jafPsqQdvehhuwxnHqFoa/hbhvC
cOtnri5FSTtZlO4HU6OHIlI+TKTDzKRSk0lEzIDesknsHM0bbHxcVUaffK3et03e
NMNVNEw/0Rcn3M8AeP76Mwuym6on1JBL99ic1pQ+RamVSownb6SyOCLAoRqcc0em
/Yxn2f8teJWxAY2fIVoWTnsdVYyhhIF5R054brCqspW05enQXObTuov7Mvihsgbw
cBCZLtO1NuBG7nWBKu+oQ/i2k9TXerViTN5leWNp37fgDGP+dAqOYTimqix+Vl6p
YokU4Vm7g4+GRNRolaG1u0EMM9ULk4E7h7iUgJKNoeVXx1aLGnX7OaHE0+VbrzMv
yWFPzWnQ
=PsH/
-----END PGP SIGNATURE-----

--WelmGM+JEqjKdC1r--
