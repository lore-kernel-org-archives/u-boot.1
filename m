Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FC4D1BDF5
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 21:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57DE888FCC;
	Mon,  4 Nov 2024 22:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wb73UY7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C920388F33; Mon,  4 Nov 2024 22:05:52 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BAD1884DB
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 22:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b152a23e9aso331442185a.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 13:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730754349; x=1731359149; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=coAJ1Opoo9ApI58ljyJ/9Xt8hDD+9QvcFKM1aqvSYno=;
 b=Wb73UY7z+kxEREGeRMKPi53fvhHtPSkN9XJp0mEFtNpHqgCydWJAqgiIUsyYvXWrRe
 tkdaZ1FjuwKBpbADkMpoYOjWahw0Fx+uJD9heBzrsY/XzyMgzX0brbLwBEPOFzS+Lmai
 v/9fG8wJKUAWNZjt0917PlkhgwiQg1TqZMAuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754349; x=1731359149;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=coAJ1Opoo9ApI58ljyJ/9Xt8hDD+9QvcFKM1aqvSYno=;
 b=cTM+65LQLmGK9k6DyEkaiCs8HFN5dzFpVJL5M2OPm5IAgvLO0CIs+188pM7Lf5Gynt
 a/DJahXxALgy6jsAplHRbSgXa07m7zuDM7JoB2IePWXFGI5L7/RE9OQ5NcmZNaYo74Ex
 Zl4NKg3d9YGe7NN0X6WQ1ZjMNatJlaQXzSubZ7+ngqZ+mozABrplc2+JpgWZnMqkPf8n
 fdg3Dt2JDT+NSdhHsNeuTAkrViUSnTDOJaHSYf8vV1arajcBcAB9qCKaVJCRXaoEdD/2
 yas4Hh/LffqpqDfHfLSR60JQwG+O6+lnPQZk9gYCt3HVLJU31NABJBegZiPZrlT9e0/w
 cCcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWggk2xuIzAuE2fWNX0DK3mt57NR39y8+Lfqx/tFnRzUSVXeufLZ1j9J1C/RcLAsKVrmg7+4vQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxpLa64tf4B1ggzt0ikXojvZIkzU7AUh1Gn8QO5nOvtCU5y+Yek
 anc//ClaYjMa1P1BH/MmHzDILvd2j3Zw/0O1r7uJnIJyjo8ZwcZs7mWMtjYDlck=
X-Google-Smtp-Source: AGHT+IErhTo70bBsY6O6g0ifb4EOzpmWIY2Vhvl+YFK+gomLAk3Wj39KgsW9utbyoODowUs+EvcP9w==
X-Received: by 2002:a05:620a:4456:b0:7a9:dc30:3d3e with SMTP id
 af79cd13be357-7b193efa681mr4863448085a.24.1730754349029; 
 Mon, 04 Nov 2024 13:05:49 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a11765sm455776185a.69.2024.11.04.13.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:05:47 -0800 (PST)
Date: Mon, 4 Nov 2024 15:05:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Janne Grunau <j@jannau.net>, sughosh.ganu@linaro.org,
 kettenis@openbsd.org, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH 0/4] Fix IOVA allocation in Apple dart iommu after global
 LMB mem map changes
Message-ID: <20241104210545.GV3600562@bill-the-cat>
References: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
 <CADg8p97H9eqncSEGjZF5EGP2M9Y10MmV28RwSdtsW+T8fSURiw@mail.gmail.com>
 <87v7x63p3c.fsf@bloch.sibelius.xs4all.nl>
 <CADg8p96csvFbyWpgajy_ewZMXRCsKstbhGFMnDUcGnG9e+QA3g@mail.gmail.com>
 <20241103173633.GA664967@robin.jannau.net>
 <87jzdk3rtb.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C2qcf1goimc0zrwM"
Content-Disposition: inline
In-Reply-To: <87jzdk3rtb.fsf@bloch.sibelius.xs4all.nl>
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


--C2qcf1goimc0zrwM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2024 at 10:56:00PM +0100, Mark Kettenis wrote:
> > Date: Sun, 3 Nov 2024 18:36:33 +0100
> > From: Janne Grunau <j@jannau.net>
> >=20
> > On Sun, Nov 03, 2024 at 07:53:36PM +0530, Sughosh Ganu wrote:
> > > On Sat, 2 Nov 2024 at 16:00, Mark Kettenis <mark.kettenis@xs4all.nl> =
wrote:
> > > >
> > > > > From: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > Date: Fri, 1 Nov 2024 17:17:22 +0530
> > > > >
> > > > > On Fri, 1 Nov 2024 at 15:47, Janne Grunau <j@jannau.net> wrote:
> > > > > >
> > > > > > The changes in "Make LMB memory map global and persistent" [1] =
break
> > > > > > mapping DMA memory in the USB xHCI driver when using the apple_=
dart
> > > > > > iommu present on Apple silicon systems.
> > > > > >
> > > > > > The IOVA space used by the u-boot driver (low 4GB) and physical=
 memory
> > > > > > do not overlap. The physical memory on this systems starts depe=
nding on
> > > > > > the SoC either at 0x10_0000_0000 or 0x100_0000_0000. It make no=
 sense to
> > > > > > manage these distinct regions in a single LMB map. In addition =
every
> > > > > > device has its own iommu and IO address space so sharing a sing=
le memory
> > > > > > map between all iommu instances is not necessary.
> > > > > >
> > > > > > To fix this issue restore the used subset (add, alloc and free)=
 of the
> > > > > > previous pointer based LMB interface with "io_" as prefix.
> > > > > >
> > > > > > To ensure that low level lmb functions do not use the global LMB
> > > > > > variable reorder lib/lmb.c so that the variable is not visible.
> > > > > >
> > > > > > Tested with patches from my "Fix device removal order for Apple=
 dart
> > > > > > iommu" series [2] to fix a separate issue.
> > > > > >
> > > > > > The cosmetic commit has two checkpatch warnings in existing cod=
e which I
> > > > > > ignored.
> > > > > >
> > > > > > [1] https://lore.kernel.org/u-boot/20240826115940.3233167-1-sug=
hosh.ganu@linaro.org/
> > > > > > [2] https://lore.kernel.org/u-boot/20241031-iommu_apple_dart_or=
dering-v1-0-8a6877946d6b@jannau.net/
> > > > > >
> > > > > > Signed-off-by: Janne Grunau <j@jannau.net>
> > > > > > ---
> > > > > > Janne Grunau (4):
> > > > > >       lmb: Do not use global LMB variable in _lmb_free()
> > > > > >       lmb: cosmetic: reorder functions and global LMB variable
> > > > > >       lmb: Add basic io_lmb functionality
> > > > > >       iommu: apple: Manage IOVA separately from global LMB mem =
map
> > > > >
> > > > > Thanks for these changes. I am currently on leave, but will take a
> > > > > look at this in detail next week. But on a cursory glance, I have=
 to
> > > > > say that I am not entirely satisfied with this solution as well. =
With
> > > > > these patches, we now have a disparity in terms on how we view th=
e LMB
> > > > > memory map -- we have a global map for RAM address range, but a p=
er
> > > > > device one for IOVA's. I understand that IOVA's are supposed to be
> > > > > per-device,
> > > >
> > > > The IVOA's are per-stream.  Multiple devices might share a single
> > > > stream.
> > > >
> > > > > but then I think that perhaps LMB is not the right way to
> > > > > solve this. This was fine earlier, when the entire LMB implementa=
tion
> > > > > in U-Boot was local, but that is not the case now. I wonder if th=
ere
> > > > > can be a different, non-LMB way to implement this.
> > > >
> > > > Of course there can be a different implementation.  But why add a
> > > > separate implementation for what is essentially the same problem:
> > > > allocate blocks out of an address space.
> > >=20
> > > My primary concern here is to prevent setting a precedent that it is
> > > okay to have a local, per caller lmb instance.
> >=20
> > I think the issue is thinking this is per caller. It is not (primarily)
> > by caller. It is one LMB instance per managed independent address space
> > block. Apple silicon SoCs have multiple independent iommus. Each iommu
> > can handle multiple address spaces (streams, only partially implemented
> > in the u-boot driver.
> >=20
> > > If it is allowed for
> > > one caller, it becomes difficult to say no to someone proposing a
> > > similar approach later. In any case, based on how the allocation logic
> > > works, with all the addresses being allocated from the IOMMU driver's
> > > map function callback, why can there not be a single instance of an
> > > iova lmb structure. That would at least ensure some kind of parity on
> > > how the lmb maps are maintained.
> >=20
> > There are multiple fully independent IOVA spaces. I doesn't make sense
> > to allocate them from a single pool.
> >=20
> > > > Before you changed the goal posts, lmb did exactly that.  The only
> > > > problem was that there were multiple lmb instances covering the same
> > > > "main memory" address space.
> > >=20
> > > I had provided an explanation of the situation that existed prior to
> > > these changes in a writeup [1]. And that writeup had clearly provided
> > > the two possible solutions to fix the issue with EFI allocated memory
> > > working with LMB. And it was decided through discussion on that
> > > writeup as well as on the mailing list that this was the approach to
> > > be taken.
> >=20
> > That document missed due to unfortunate circumstances one special case
> > in the LMB usage. Consolidating all struct lmb referring main memory
> > into a single opaque object is useful. Please let's move on to fix the
> > single usage which broke due to the change.
> >=20
> > >From my point of view it's clear that "io_lmb*" is separate from the
> > main memory lmb. It manages the IO virtual address space of devices and
> > it is fine that there as many (io_)lmb instances as there are IO virtual
> > address spaces. These do not have to be managed via struct lmb and
> > looking at the minimal io_lmb* API a simpler implementation would work.
> > An alternative implementation would be duplicated code and reusing the
> > existing tested lmb code is desireable.
> > If we want a stronger distinction between lmb and io_lmb we could hide
> > struct lmb from io_lmb.
>=20
> Thanks Janne, you explained that very well and I 100% agree.

Yes, thanks, that's a helpful explanation. I believe this series makes
sense in that regard, and I've reviewed 1/2. I'd like Sughosh at least
to look at 3, in light of the above.

--=20
Tom

--C2qcf1goimc0zrwM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcpNykACgkQFHw5/5Y0
tyzJ7gv9EL6cHNzgP/StffAP596wZCRJo6b43+S3ALKQoC5mEpI5bsf2drM8ZPOq
6fEwJCzAzX57+JZH1zXyfdGx+5T2+6jLeoEMukhN/+Iez6J2Usu5owfVotBMEtg3
JbwQNwEsZi1O8ksmAj3ALssc+LBVbMVQWJzWVQhO4hf6gq2RHlIdeuj1vRjQeeuf
W1oTo/e1Eae8O4C/wXBVIH7VQ/F+p2WpcIs5GObEM3rd/HY0ga9e4QFoGlPBI5Jc
bG5p9hm8mbmAhdbzcBN9ESlw9gbvbcSktr5Llzg7ZE1IXJytQAFW1pWSTxB6PVLP
z5HB+OHKGe/yUiTRhaFoGwed42XvLBHjMSSxb7HCUUWImVvaP5j40O6VZUmC6hpQ
MXnmmpys804Zs8TezVzzOQy84RECOmzFhe0X5XaJ7vYwDUCggAgBhiAN1JkXIFn+
/FzO0fdlUTXWYxTMf/yW31cx+NJG9vG4svrUR+S8uehU/99JKe1Qn+hAsYSpAjVA
Lt+KtCe4
=rDU4
-----END PGP SIGNATURE-----

--C2qcf1goimc0zrwM--
