Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63C8CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 19:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19219839B7;
	Wed,  8 Oct 2025 21:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WGK2VTC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76938839DD; Wed,  8 Oct 2025 21:33:13 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 513388394E
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 21:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-43f912f9738so155182b6e.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 12:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759951990; x=1760556790; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5WXODrawxeiTE6zimCYQjLQWxDesByzsw4tP9tSqJL4=;
 b=WGK2VTC63msaDKivxTn1+7SCjWylKhQ5lkxk8VKlpJrQ8U+MUGrT7BajHCHuc4sBP6
 zya/q1GOzhTHpSJyTtoNtPPQCqNOAh1PdE9bT6pApE89ZRU7JzUOazsJ6jiezAkyUfJd
 3uazwQdVMNC04EIKijDzRjxsoayGpcZ8leFNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759951990; x=1760556790;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5WXODrawxeiTE6zimCYQjLQWxDesByzsw4tP9tSqJL4=;
 b=cZVKaIOHYqzs9Xa3noCHd+9l6TAJRH8W6yY1seOk6BjIar0NXB8X9UbOgKD8MO003S
 fhKJLCcne7EpNSEJ6DkeoRj2nbWYBf4nSX21qoYE4/yf3ROTAh+B7sLXVOc+MJsCjFAY
 KydcTeXgQoVvcCK016yUC215Hg4JSWtSGmmxzdIgU3LUqJp8zS5QAlB3XsGXL9AMlA+U
 /L0AC36Z66Kclh7mrND1l9/KKivKN4jHWMZVL1LOUayYTSz9kC0mHI1j5AsorqxYQ4ol
 DGq2deiPXKpfyiz7Wf69HNDBHFolJYrNfq+PNDNNJ9c7aH50vlLih66e/xDJEtqNUKUC
 QahA==
X-Gm-Message-State: AOJu0YzbMtT719mPSNJoIK9RrN9gYMGebtlFNSTdGiSWUi9S+T6LCEfJ
 GCfEm9X4LguUPXWjuihDO8fz4cxigSN6Dsqd2EPc/5o9FB/37lrfhE9dzOrr11wFbmdQPzQOnmw
 We0Bm4eQ=
X-Gm-Gg: ASbGncs8wAu/db31u/mzIONTOc8udmBJ7CHc/kRdT/iogjG0QQ4SHcvbem/FKBfkC/Y
 LUDM948K71up9kn0Lj5Y5+MbGLmObFHXhyRArS9hauTkP0E2jeCyLHYixqZkgn0Noa21W3Je//b
 XE3hL4Ko+b/OnE+S0p68eheGF0ndhtExT7oN7il+YI8L1iGVxp+81vrnjn/a8hcDA1XGvcR1mxt
 s0GJ9Axom/NBeARe8zu+m57iobUfe9QebQ4lc+KDFbt71wy+dXjj6Cs3nxaAYiUL3L1uOTcWWoX
 HGWT8ms1ijyqePBOjPBm9V7wiGfcGI2MMztFrNVm1MxaHriDcCob478hxK9kKOL98JQbszOfzeT
 NpkeOguROxAC7iJa/75tlMJjdT8+Q24JhMubemRmk7dpI+Q+zlQAMX4x/6EKsrwnEJdcxXKj+Ix
 Eg6bQCDjJN6g==
X-Google-Smtp-Source: AGHT+IG8CFG8FowdZk6EeXE9Sc/gxcR5SwknrLFD/i3zTNPeTmeHaKw3QDO4kdNbmXit4p2WwZTy5g==
X-Received: by 2002:a05:6808:11c8:b0:43f:49af:b849 with SMTP id
 5614622812f47-43fefc8c172mr4297586b6e.12.1759951989982; 
 Wed, 08 Oct 2025 12:33:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44189a67868sm178068b6e.24.2025.10.08.12.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 12:33:09 -0700 (PDT)
Date: Wed, 8 Oct 2025 13:33:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] cmd/dma: documentation
Message-ID: <20251008193306.GI298503@bill-the-cat>
References: <20251008174408.381-1-briansune@gmail.com>
 <20251008190713.GH298503@bill-the-cat>
 <CAN7C2SAaia8qV4sx-uMF2Y1GE4GW=WmmgSMHMApW0YoTzTqQOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x8Z0uALEULBATQLw"
Content-Disposition: inline
In-Reply-To: <CAN7C2SAaia8qV4sx-uMF2Y1GE4GW=WmmgSMHMApW0YoTzTqQOQ@mail.gmail.com>
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


--x8Z0uALEULBATQLw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 03:11:02AM +0800, Sune Brian wrote:
> Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B410=E6=9C=889=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=883:07=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Thu, Oct 09, 2025 at 01:44:08AM +0800, Brian Sune wrote:
> > > This explains how
> > > to use the new U-Boot command 'dmareset'.
> > >
> > > Signed-off-by: Brian Sune <briansune@gmail.com>
> > > ---
> > >  doc/usage/cmd/dmareset.rst | 55 ++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 55 insertions(+)
> > >  create mode 100644 doc/usage/cmd/dmareset.rst
> >
> > This needs to be included in doc/usage/index.rst (alphabetically sorted
> > still) in the shell commands section. Also please do "make htmldocs
> > KDOC_WERROR=3D1" and make sure there's no complains for v2, I see some
> > style issues it will trigger. To build the docs a python venv is
>=20
> I used the the checkpatch
>=20
> $ ./scripts/checkpatch.pl v1-0001-cmd-dma-documentation.patch
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #16:
> new file mode 100644
>=20
> total: 0 errors, 1 warnings, 0 checks, 55 lines checked
>=20
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>=20
> v1-0001-cmd-dma-documentation.patch has style problems, please review.
>=20
> NOTE: Ignored message types: COMPLEX_MACRO CONSIDER_KSTRTO ENOSYS
> MINMAX MULTISTATEMENT_MACRO_USE_DO_WHILE
> NETWORKING_BLOCK_COMMENT_STYLE PREFER_ETHER_ADDR_COPY USLEEP_RANGE
>=20
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>=20
>=20
> > suggested and you'll need to pip install -r doc/sphinx/requirements.txt
> > -r test/py/requirements.txt.  Thanks!
> >
> > --
> > Tom
>=20
> The doc uses another checking tools?

We have an outstanding update to checkpatch.pl that may or may not be
better for rST (as the kernel has been using it more and more), but this
is analogous to compiler warnings when building code, checkpatch.pl
won't catch that (but I manually enabled this driver in a build to check
it before pushing).

--=20
Tom

--x8Z0uALEULBATQLw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOa8bwAKCRAr4qD1Cr/k
CifgAQCHtAl18CMPfyBerZYH89k+U0zUIH+1G3rFP6wY7YJdIAD/Q+yxXAuUmMcy
8pN4Sv+Y/KY3qegE9OwRTLno9hZI1A0=
=ooKv
-----END PGP SIGNATURE-----

--x8Z0uALEULBATQLw--
