Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684EDECD9B7
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 01:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A03283015;
	Fri,  6 Feb 2026 02:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uCNGvEef";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE71083015; Fri,  6 Feb 2026 02:51:02 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D14380086
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 02:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7cfd9b898cdso934431a34.2
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 17:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770342659; x=1770947459; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zdNBLVtrNJh5qvUtRP/9mi0MTRVnFPsOVxwPbovn/T8=;
 b=uCNGvEefiF5nYN0VgMchdwo4AK0jWb1rwm9WHbgvOeIHtlA9Vb9cFzp213XSBvC0OG
 Hdjd8uKit8e5CT+5vY/V10HDWlPM/zUq5FZYljeR6n4j7VqdIJMfpM2nINRgI2Epw+ot
 XTcDcS6zCew2eebHWq3I1NWC1eTc8800nuHpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770342659; x=1770947459;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zdNBLVtrNJh5qvUtRP/9mi0MTRVnFPsOVxwPbovn/T8=;
 b=Q0qFHjeCvi7iKCy6ttbbQCZYL6T0PW3DLTM5JLWfscSmDu5P0qzmpisHKJUjB24qpb
 agNFkKHCki4ApoIGsLpadHvWcpq0ZN7KBWa30vvqFHKHkiK/+KQSBEYrEcIqzNDDORk0
 kwpjwE4bJ+2YnpZB7nPiOx2ZEq22juKfRozTvtsZexVsiQtXkD5W+co9KGEDpRi+kTLH
 dTJ56ynPIfqg77wYDbbOwEbKOPRq1qM/HAvM3Xh+jmu840qdm+8J/7L61KLCyGg3IrMn
 D0DJAQEvCwSsUVmIJpGqwHmvB+kGp/4/nIW2YxqnlrSh8jcp7Szp+KyhbQTQt8cQv11N
 9Ftw==
X-Gm-Message-State: AOJu0Yz9JomVwl9YrXmtgugdDNCjQCW+RLccd+sI6lEWl8Y2hTLG+h70
 hbb9KRL+6nQnGbJOIcHq+4BR8VqxTKp9uTIYQq9XkCAY1FUGhAHoJK0Oue+YCVr1N0A=
X-Gm-Gg: AZuq6aK3xQp6eCsbGt65GZlBY2jEoTHKfwAeg5Olxc/ym3pgvkzq3X9KVU7Duqpj1Ur
 lGrezWF5PGns8YHg0fTSXT4O66dOBg139/YMbIkH6N9YR/ubsCujlPyeHw2nx0zatCXIgMAYAa0
 bCesPTI7EzMNXF7BmNnD5PQpD3sh2L986Rc4dyBmXDFgsjZkWQy/8xRXrmdGY+1qdAvyGpgt0uf
 KYwbz1kaIo9XWw3hy2D2pqzMU155I/yWjRhjG8uMPbR429hp7Yc+VxsNz1jslcn+oSMlsez6Ukr
 CRsTJZ+xHBwcqUG+bHv/Nij46xWT8zoml43l63BdZZErfpDnbztCOhXo1aApZonfvFC2SDl6CKo
 Xrm31QKZTXpE6NKwf1Nn809yYd0ewHVeug7wQxWdIiFyzi7sDBOstvyAyd+d3sQEGit3bF5QpSs
 hNb32JhLZqItspmb1zMm2Zy6ZwdganKMYKn7+B9z/6k8M8b1MHXn6MwFeu+lZsoVw6MADN1zFL5
 cFymGUSVrvOMZTIS7qGOrY36SjTlLJwreojAAA=
X-Received: by 2002:a05:6830:600b:b0:7c7:5f09:879c with SMTP id
 46e09a7af769-7d46467f230mr554965a34.26.1770342658900; 
 Thu, 05 Feb 2026 17:50:58 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d46470df08sm691203a34.8.2026.02.05.17.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 17:50:58 -0800 (PST)
Date: Thu, 5 Feb 2026 19:50:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Jeremy Compostella <jeremy.compostella@intel.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] x86/coreboot: Exclude memory regions starting above 4GB
Message-ID: <20260206015056.GO2603314@bill-the-cat>
References: <87qzr1z0tf.fsf@jcompost-mobl.amr.corp.intel.com>
 <87a4xnuljz.fsf@jcompost-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xOBuIvsvA1Jz0zap"
Content-Disposition: inline
In-Reply-To: <87a4xnuljz.fsf@jcompost-mobl.amr.corp.intel.com>
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


--xOBuIvsvA1Jz0zap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2026 at 10:50:24AM -0700, Jeremy Compostella wrote:

> Is there anything more I should be doing? This is a bug fix I would reall=
y appreciate seeing merged.

It would be nice if someone else reviewed it. It's also been a day since
posting. I'll put it in my list to make sure doesn't get lost for the
next release, thanks.

>=20
> Regards,
> Jeremy
>=20
> Jeremy Compostella <jeremy.compostella@intel.com> writes:
>=20
> > This commit updates the RAM region filtering logic in
> > board_get_usable_ram_top() to skip any memory regions whose start addre=
ss
> > is above 4GB. Previously, only the end address was capped at 4GB, but
> > regions entirely above this threshold were still considered.
> >
> > Typically, the following memory map entries would cause
> > board_get_usable_ram_top() to return 0x100000000, which is incorrect.
> >
> >     start=3D00000000, end=3D00001000, type=3D16
> >     start=3D00001000, end=3D000a0000, type=3D1
> >     start=3D000a0000, end=3D000f6000, type=3D2
> >     start=3D000f6000, end=3D000f7000, type=3D16
> >     start=3D000f7000, end=3D00100000, type=3D2
> >     start=3D00100000, end=3D6f170000, type=3D1
> >     start=3D6f170000, end=3D70000000, type=3D16
> >     start=3D70000000, end=3D80800000, type=3D2
> >     start=3De0000000, end=3Df8000000, type=3D2
> >     start=3Dfa000000, end=3Dfc000000, type=3D2
> >     start=3Dfc800000, end=3Dfc880000, type=3D2
> >     start=3Dfd800000, end=3Dfe800000, type=3D2
> >     start=3Dfeb00000, end=3Dfeb80000, type=3D2
> >     start=3Dfec00000, end=3Dfed00000, type=3D2
> >     start=3Dfed20000, end=3Dfed80000, type=3D2
> >     start=3Dfeda1000, end=3Dfeda2000, type=3D2
> >     start=3Dfedc0000, end=3Dfede0000, type=3D2
> >     start=3D100000000, end=3D102400000, type=3D2
> >     start=3D102400000, end=3D47f800000, type=3D1
> >     start=3D4000000000, end=3D4020000000, type=3D2
> >
> > By adding a check to continue the loop if the region's start address
> > exceeds 0xffffffffULL, the function now properly ignores regions that a=
re
> > not usable in 32-bit address space.
> >
> > Change-Id: I8cbe0281aeea67a2f5bb9f6669456f5c7df9b409
> > Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
> > ---
> >  arch/x86/cpu/coreboot/sdram.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/x86/cpu/coreboot/sdram.c b/arch/x86/cpu/coreboot/sdra=
m.c
> > index 013225f129a..cc1edd7badd 100644
> > --- a/arch/x86/cpu/coreboot/sdram.c
> > +++ b/arch/x86/cpu/coreboot/sdram.c
> > @@ -42,6 +42,8 @@ phys_addr_t board_get_usable_ram_top(phys_size_t tota=
l_size)
> >  			continue;
> > =20
> >  		/* Filter memory over 4GB. */
> > +		if (start > 0xffffffffULL)
> > +			continue;
> >  		if (end > 0xffffffffULL)
> >  			end =3D 0x100000000ULL;
> >  		/* Skip this region if it's too small. */
>=20
> --=20
> Jeremy
> One Emacs to rule them all

--=20
Tom

--xOBuIvsvA1Jz0zap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYVI+QAKCRAr4qD1Cr/k
CmsDAQCPWbfXkkxm/APLZn/hQlJqkjVLoM8yU0CDOKLv36yzDAD+P/aEeR7oRtHy
3sdAcQv1+Ydtmf+lbQAHKD0CASh8qgM=
=fOYU
-----END PGP SIGNATURE-----

--xOBuIvsvA1Jz0zap--
