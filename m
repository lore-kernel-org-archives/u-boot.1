Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95148C5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 21:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B710D88BAC;
	Fri, 23 Aug 2024 23:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ax5WoCqj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98CA588B82; Fri, 23 Aug 2024 23:07:31 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42F1288936
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 23:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a1d436c95fso143494385a.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 14:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724447248; x=1725052048; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AYLYjFSuNJUwTUWBFc+10VT1GubeFPAwpehQnh2mMfM=;
 b=ax5WoCqjTNKuToxMApa4dc68HvETlnYodtlQUnMmyvChQYd2ODcwP4SklirpR1bUJE
 +/mNEJ97Zs8UWhiTYIm5ew11GEbV2Xu7DBowrNCPxXxXalkx9bCQBxjMQyBKFxMXueiM
 yBHMkN9vTB9yNSGhZFSIxBlEQvbFeJfl/vn70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724447248; x=1725052048;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AYLYjFSuNJUwTUWBFc+10VT1GubeFPAwpehQnh2mMfM=;
 b=hLAh9cpnVJkIGFEzftvGK9ippxz2fBk0zHnDpkTQTVQIGdapnzXNPWJ6FfnHloqrCy
 s35qNb05N64zslMp7nmPtaO85wBUACaomDYVDMYeVRDe5pkqPw3Z3X2br+Gri7ZmnOiJ
 zEhjAnNQOpQDVK4K8JugR4t9enYlelg+xd/2/hV7cZbqJW611EeiGRzS2Cm93PV/D2IF
 aTIxi4koJTGARClyq5LB/xHPThN8Xaw9DXe+xNyU16A5g4BlKxkInxHMHEgMULbnYj6L
 4IN7UCnBuVExdc2cq0sEMZN8MH6XvvLMjVhkEA0iEFxE0lK/+TqoEK79Bm7ZmsiL1D4R
 7BCg==
X-Gm-Message-State: AOJu0YydH8BHnhWwcpXxtJ4Xgh9SZrAaqAqcuBVzwepMhFTd2djkkwOr
 m8RebVMSG0y4JJ6qnPMq9lQJlNZwQOZs9xS7XSsbpD06kDLFrgDn6JpUKwpdNwU=
X-Google-Smtp-Source: AGHT+IEFucq43j/jtEHKuo+fAiJqClHRZn1ie6k4FZZ/Rxp+Gp8118Cs9/OSudC6aN7U3sTuGF3diw==
X-Received: by 2002:a05:620a:4244:b0:79f:16b0:df8f with SMTP id
 af79cd13be357-7a6897ac814mr368692785a.48.1724447247841; 
 Fri, 23 Aug 2024 14:07:27 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f3bb329sm215230085a.78.2024.08.23.14.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 14:07:27 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:07:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 26/35] global_data: Reduce size of early-malloc vars
Message-ID: <20240823210723.GY1626301@bill-the-cat>
References: <20240821161927.695717-1-sjg@chromium.org>
 <20240821161927.695717-27-sjg@chromium.org>
 <20240823133450.GA1627158@bill-the-cat>
 <CAFLszThQKH-pM1nTNJv5HwLanc9tGL4ZgvPLzxWk48LmxHa+NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C1xdEPAMUWHcLAWq"
Content-Disposition: inline
In-Reply-To: <CAFLszThQKH-pM1nTNJv5HwLanc9tGL4ZgvPLzxWk48LmxHa+NQ@mail.gmail.com>
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


--C1xdEPAMUWHcLAWq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 02:30:04PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 23 Aug 2024 at 07:34, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Aug 21, 2024 at 10:19:18AM -0600, Simon Glass wrote:
> >
> > > The early malloc region is normally quite small and is certainly less
> > > than 4GB, so use a 32-bit value for the limit and pointer. Update the
> > > comment for clarity while we are here.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  arch/arm/lib/bdinfo.c             | 2 +-
> > >  common/board_r.c                  | 2 +-
> > >  common/malloc_simple.c            | 7 ++++---
> > >  common/spl/spl.c                  | 4 ++--
> > >  include/asm-generic/global_data.h | 6 +++---
> > >  5 files changed, 11 insertions(+), 10 deletions(-)
> >
> > This breaks booting on am64x_evm_a53 which is an odd platform that does
> > SPL->SPL->U-Boot.
>=20
> OK, I can repeat that on the Beagleplay in my lab. I sent a v3 patch.
> Thanks for bisecting.

Oh good, beagleplay is run after the EVM in my loop and so I didn't see
it was broken there too.

> I'd love to be able to push trees to gitlab and have them run on my
> lab. I think you said that the patches[1] break your lab, so let me
> know if there is anything I can fix.
>=20
> Regards,
> Simon
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D420392

Well the good news is that I've got the tests running again here, and I
think I mostly understand where the challenges will be in updating this
lab to a newer labgrid version and so being able to migrate it to on top
of your patches. The challenge next will be time. Likely the next steps
will be splitting out your serieses in to test fixes and labgrid
implementation details.

--=20
Tom

--C1xdEPAMUWHcLAWq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbI+ggACgkQFHw5/5Y0
tyywhQwAg4MCWcRmreD6QdmnCiK9u/miSTquk9t4IvKd9o7mXWoinggWauJRKgS9
VKExCbfr6+MdYS9ye00Dp4wm+5H/NdFuFMtwTh7Y9C9JNabKiaBmE9zIEMQMyagk
r4F4O32gnE9IS+0vLOBDkXcsuLzAzganqR5oOtQA3Bzk8ebR1KF5gUsVE7waEn3Q
HYqZ+laatN5ys/0x92xr/8sA2375xSiEATgSjP3VjZ4ElKqqkJAUR2yqx41ELaz9
g+atXLxTYPDuKlMCH5Ayt+RxuY1ymWsWbH7xMftL9fK23EwgZZUaE83oDt2K5GF9
TtnLq9TxIiIj7FlrxEf+mqKz/gFk3TmHSZirnGjGveKvHWM30h34fb8Hqaj8GQ5f
36pyuGDMjHdxbWwklaIIlQYP9dKzeN2D/JUi1gzlJ9nsGGPxpakj/8doQwnoYVbE
MeznuQGPXrmBHMrHlwEzYMBJ7IMhaIicb+rhUKm3RjwvMyrjRlsC19DF2Hk1sCyX
KHY8nQAw
=w6/o
-----END PGP SIGNATURE-----

--C1xdEPAMUWHcLAWq--
