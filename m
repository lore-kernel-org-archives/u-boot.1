Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EFCC3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 15:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71EEC8211F;
	Wed,  7 May 2025 17:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PHZkRtOj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C2338212F; Wed,  7 May 2025 17:23:30 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D129820EB
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 17:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72ecc0eeb8bso1896220a34.0
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 08:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746631407; x=1747236207; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rxOr+CGgPZdRgFpWoSj91aYoOnMnbV1GHAQ2DYNP4yI=;
 b=PHZkRtOj/bqzaJTn8hp3iuaXhE4Nz970n0+38rHlK/01z2E4EudyaV5EK8he0SdRpY
 hIFDG8wsbXd1f0CbPWtXgEFTTDl5Z3wmtTLuprdpjMkEvG5/j2RnRhEs5gVkCLFtuUI3
 iMTfBJuOqwQR+2F58QpP6o2lyYu68o1KQN1H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746631407; x=1747236207;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rxOr+CGgPZdRgFpWoSj91aYoOnMnbV1GHAQ2DYNP4yI=;
 b=RF9IcK/fs5CkDmdV1f/VjcKVp5zTcppnQrdrLRuPTzplnWXuhU5pXPXmP1m/UI23nT
 8kINViUnMpTSkEcdxiwTC31vnzx9uIGJHx/sltQGBACnXgvLLutoqVfabKu6ntcOd0/U
 3X0LwH5i5n/62mX11vK+kBLa5yTGrJV96LHCJbTkruCyJeJGsZuc0W5MVBWfN6kG7rMU
 9wTraE5v1301FRqRudZgNQ60sgm14eDTPTqbt9etLXU+p1WiDJSgcSBqqktEuw3BB7yU
 AOEfQ9FVv+a6oCH+RP1tVQ9cPQfss5XduoLFaLhMOx0W1Nf4u9XeTssTfJgMYu6S3MDu
 Q5vg==
X-Gm-Message-State: AOJu0YwzKiSytDMOyvuBwvfmaejNYTHEXRYE0e2HSTeMDc4UwwsqKnWz
 kSpd2XYEQtRMEOhus6Pugz+/5kjKTxINUZ4HMLmJ9LZfDy0aYJPQeR96RhFkLl0=
X-Gm-Gg: ASbGncuQNBGSVbLnBt0DXR0Uz5QDNDjXTI2pZVbcD+MbsUWNcSYawJj6d9CTZpsCktN
 VX9s7PHQWjudUaPc6EysWDFhPbaAeV3nn4qKVTimObqs2SCkUQrJCfsmy5HcgrcSjbKnbfcdF7b
 7qr7JbfExEKLd6/kHI7cUFZu2s7pG4gwBqxuudqfR2g0mYH4psHtTOA8ITlPJ4aoetNaQR2vQt2
 JFmxwmW9L0+TcR2M75o27t6h1ne2F8Pa267/JDRQrbeXtkuoy2rq2Z1tdN4XNEMRu5TsFLkzT8D
 DvRfDgc3sI7GWETHiMvvE6polZPkV4f9i4t9b/L2WsJpj/iGE9D+pJd04bGjZxUgHqg1zbj84gN
 ldQ==
X-Google-Smtp-Source: AGHT+IGjBJwLAHm9+RGS8uJUDu/0AU8wjKlEFyGwjr53k0XTUouxcOIeJksEpuLCJzcIbfabsugjXA==
X-Received: by 2002:a05:6830:3787:b0:72b:992b:e41 with SMTP id
 46e09a7af769-73210b26dc0mr2615894a34.23.1746631406860; 
 Wed, 07 May 2025 08:23:26 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-732109dfaebsm578922a34.13.2025.05.07.08.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 08:23:26 -0700 (PDT)
Date: Wed, 7 May 2025 09:23:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH v2 1/3] Bring in linux/limits.h
Message-ID: <20250507152323.GJ5430@bill-the-cat>
References: <20250418105919.1645824-1-sjg@chromium.org>
 <20250418133943.GK5495@bill-the-cat>
 <CAFLszTgaqCyK5t+5XqbW6SZ-vC1PCUv4h+YPqt0Zem1yXEn4AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v1l1MhEPtr5UvTbR"
Content-Disposition: inline
In-Reply-To: <CAFLszTgaqCyK5t+5XqbW6SZ-vC1PCUv4h+YPqt0Zem1yXEn4AQ@mail.gmail.com>
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


--v1l1MhEPtr5UvTbR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 10:47:13AM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 18 Apr 2025 at 15:39, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Apr 18, 2025 at 04:59:13AM -0600, Simon Glass wrote:
> >
> > > From: Simon Glass <simon.glass@canonical.com>
> > >
> > > Add part of this file from Linux v6.14 so we can include it from the
> > > linux/overflow.h file. Drop the relevant section from kernel.h
> > >
> > > The top of the file is omitted since it defines things used in mbedos
> > > and we get an error on SIZE_MAX.
> > >
> > > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > > ---
> > > Error is:
> > >
> > >   In file included from include/limits.h:6,
> > >                  from lib/mbedtls/external/mbedtls/library/constant_t=
ime.c:14:
> > >   include/linux/limits.h:7:35: error: missing binary operator before =
token "0"
> > >     7 | #define SIZE_MAX        (~(size_t)0)
> > >       |                                   ^
> > >   lib/mbedtls/external/mbedtls/library/constant_time_internal.h:65:6:=
 note: in expansion of macro =E2=80=98SIZE_MAX=E2=80=99
> > >    65 | #if (SIZE_MAX > 0xffffffffffffffffULL)
> > >       |      ^~~~~~~~
> > >   include/linux/limits.h:7:35: error: missing binary operator before =
token "0"
> > >     7 | #define SIZE_MAX        (~(size_t)0)
> > >       |                                   ^
> > >   lib/mbedtls/external/mbedtls/library/constant_time_internal.h:71:8:=
 note: in expansion of macro =E2=80=98SIZE_MAX=E2=80=99
> > >    71 | #elif (SIZE_MAX > 0xffffffff) || defined(MBEDTLS_HAVE_INT64)
> > >       |        ^~~~~~~~
> > >   make[3]: *** [scripts/Makefile.build:256: lib/mbedtls/external/mbed=
tls/library/constant_time.o] Error 1
> > >   make[2]: *** [scripts/Makefile.build:398: lib/mbedtls] Error 2
> > >
> > > Changes in v2:
> > > - Add new patch to bring in linux/limits.h
> > >
> > >  include/limits.h       |  2 ++
> > >  include/linux/kernel.h | 12 ------------
> > >  include/linux/limits.h | 21 +++++++++++++++++++++
> > >  3 files changed, 23 insertions(+), 12 deletions(-)
> > >  create mode 100644 include/linux/limits.h
> >
> > Ugh. I think we need to:
> > - Fix lib/string.c (and Fixes commit 7c7361b98d6e ("lib: implement
> >   strnstr()")) to not bring in <limits.h> as that should be limited to
> >   mbedtls usage.
> > - Not bring <linux/limits.h> to <limits.h> to start with at least (we
> >   can worry about handling wrappers around overflow protection there
> >   separately).
>=20
> There are quite a few places which need the limits. If I remove the
> dups from kernel.h then some things don't compile, at least not
> without including linux/limits,h in limits,h (which it seems to me we
> should do).

So, looking at things more to understand the problem, mbedTLS uses
constants for types (reasonable choice) and the Linux kernel uses types
and casts (also reasonable choice), and these can't be mixed and
matched, that's what results in the error you see. So, I'll re-evaluate
your v2, that might be the best compromise.

--=20
Tom

--v1l1MhEPtr5UvTbR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgbeucACgkQFHw5/5Y0
tyxjFAv9GCrrqblTBNaCvTixX2IkxKrzdkVS9TU7SzzlQijG4rymIfZj9FBqEsXj
iy4Jmrs36Dpcej2WXiCCF6nQUYnNKnEHzE9jEvDcFurqpdTDXSkbJZ6DO/KvV1oz
EzG4l56K69cF69i83Uc7txLu6kEx5GOhpZmRf2E7GMN+94Mhf6FPyZ7bDST/VnUn
MFnQtbQIGI5wqLuTMNmuxifK88YiCD5EPlDi3kAQSZhPZ94FJAAO+C1IaIgH7DCM
RKtytIuHIYfmPWyGKh76W29ndA0Dw3ALc4wft4GUJpRtfTjPG6EQNJT/Ue9129rS
NU1CBbz4/F57NFECfGvS20Uj+LIM/a2uZCdMtHmcyG1CbOvbYnkX6UFt2+oYyBke
ba1q1Hrlro7PIJxmd1E7eHUi5Vg1e2Oj4yE6PqakRXTL1FfcVrnq1GNO/hd+ezY1
7LhqOQdgogjSSt2riEO5GddoLYf68FlJZ84fha/Uyhv6osGQ0Q1DAlvP22fvQhSy
0lzmAQzT
=tzaD
-----END PGP SIGNATURE-----

--v1l1MhEPtr5UvTbR--
