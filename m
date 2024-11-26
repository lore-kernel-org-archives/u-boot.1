Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B661AD3B9AC
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 15:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 084F188DDA;
	Tue, 26 Nov 2024 16:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ow6eVpNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0EA288DF1; Tue, 26 Nov 2024 16:55:15 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F6BD88360
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:55:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6d41d46162eso35083246d6.0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732636512; x=1733241312; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TyX3UzqRYwNpiuXU2RObhA/CwRR3/X1yhLrPbb7S3tw=;
 b=Ow6eVpNyV46df+mW7XkVddvSREUpunrNH4yUAvsDiyM05FVCPIPZYSrvXoQFpI31n4
 76wiEzOLodTk9u6+FMDqnWsJyKQR02Uz2HBY981LApxQrQ/ZMAfQLGrfSEJ/IASW+1Z/
 Y8WJYBwYZ37+bTY/otehS4pk2U+BF+MDzfQNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732636512; x=1733241312;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TyX3UzqRYwNpiuXU2RObhA/CwRR3/X1yhLrPbb7S3tw=;
 b=o+0okKTqy1/LbNEFhceasd5qPOL2Xcu1/ffO2SVaW22Vhdvrq3Vvaburdam2CFagc6
 q0Wo8g+EH34zTYfQMJRvc6R4TSktfX8AFBkaDgzCxcLDJJaEblga88SNvwxaxNAevezQ
 P9PngyspJflBrHvNE6IQabzdm0Vd1mlQ/nWsuKTlLSNcDZ0gLw1tW0YuW3NKNMcY+GPO
 y+tsnZj+zQT9jISjfo89+isA+FnwBKNoEul28CqH9AVZQFdKRiQmZp6T/QIuA58AZm3M
 OzatD2iRQm1GRpTyuG+mnI3MqwbqGsjQbEpR2FWW8xgcOX0CUI4IRTi+B/nrzWPXcpdh
 6kfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUljqkTQt3cCJNxNqCchDKTrFvmFveBQFwO3RQhT5lkSD7yIHRHDNxmjJh8peQxkJg5n9NdU44=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+jrS2f8rQOuIB7q6SW0lSZ4/gtpBpKcHjp/5jO4mJitcAECrr
 +REzRc9L4QmhAXro2Lh8ogu17LyY+BomPe8e71taz+qO0epI1I8S07ZgpaUVen8=
X-Gm-Gg: ASbGnct9716giu18TXyqBqKbPuqyzJ9FS3QIOwf573YoKZZHP+PI7o2aFp8u1nNiO9e
 VfrJJ+2eVzIRA0IubSyyGOruWoUHkxBpXuH5pdeCsp9W6PvaujgxVMAyLrhZkVaFF/tNbdigg8q
 ss61m7JrASxQfgrWkzAVXtvj53Mq0GjVOhFbBQbrf4bnAHaGj+GvPS4XOOTGxfbTm1rtN0SZALV
 0YKq7Q0hXAPggYgZVHpqzTkYiLgCfgY4Lr4hWBMSy+BIQkBpg==
X-Google-Smtp-Source: AGHT+IGrETWuIixikXw6ISpOSzWGHnRG6zBGg4nTf6RzzmjJB3H09tlbJelD12yhP6aOMIfzQci4cA==
X-Received: by 2002:ad4:5fca:0:b0:6d4:1680:612f with SMTP id
 6a1803df08f44-6d451345932mr235416066d6.31.1732636512465; 
 Tue, 26 Nov 2024 07:55:12 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b66aea65d2sm238706085a.103.2024.11.26.07.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 07:55:12 -0800 (PST)
Date: Tue, 26 Nov 2024 09:55:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 05/13] efi_loader: Move some memory-function comments to
 header
Message-ID: <20241126155508.GR3600562@bill-the-cat>
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-6-sjg@chromium.org>
 <d415c887-bb0c-47e8-bfd4-d0049f596367@gmx.de>
 <CAFLszTiOp56JkV1u5qOdJUYH2vJ5YHWwpBUmhb8WWiNs2S0B+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Npe8IFkXV6DKz+AA"
Content-Disposition: inline
In-Reply-To: <CAFLszTiOp56JkV1u5qOdJUYH2vJ5YHWwpBUmhb8WWiNs2S0B+w@mail.gmail.com>
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


--Npe8IFkXV6DKz+AA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 08:37:33AM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Tue, 26 Nov 2024 at 02:35, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> > On 25.11.24 21:44, Simon Glass wrote:
> > > Exported functions should be documented in the header file, not the
> > > implementation. We tend to make such updates on a piecemeal basis to
> > > avoid a 'flag day'. Move some comments related to memory allocation to
> > > follow the convention.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > Please, have a look at this line in doc/
> >
> > doc/api/efi.rst:78:
> > .. kernel-doc:: lib/efi_loader/efi_memory.c
>=20
> Hmm, we should not add C files as then we end up with all sorts of
> internal functions, like checksum(). The help is a bit of a mess on
> that page IMO and it could use an index at the top or side.

Why? Looking at the linux kernel (where we borrow this framework from
and lots of developers expect to follow that style) it's extremely
common to kernel-doc C files. I don't see why documenting internal
functions (which should be clear as being internal) is a problem.

--=20
Tom

--Npe8IFkXV6DKz+AA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdF71gACgkQFHw5/5Y0
tyxLoQv/cW4WSyV/ho9kPAehC4p5RY2M96Sylntdfe0chuSK+LrS+k/ZucEEqh0b
lOSE63W0IjY291l19CM0AhzdPFu6zK+vim1EyX4nTMHZC4qGXPGboRqAD1SDA4VG
3yJNe399dvzUmquyYgHoMTqXJvQeWEmlm53WevkKspS9XxtLUyyD3dWUDr8ze6Ec
/7XFb0T8k6H9SlO4xn1mLyppk5CtSw6hvxa+jrZjznePAmHzhl/eeVcMtUS5lyeJ
HCyDBj5pCA1PfXh7Em7W9q8cYsQHEy8u2Zb/XGs5HmmxH6crV80IQeXzEg5znGM1
geHD2SgEIqR0S+UAOmptdw/WIJdBy+yi6h+3+2JA0dAUp6mkGgSpKd/coIrg69jN
ojEJQ6KTLQR+lMUleGV1N37LhpGWLSeMjyeDCGiMHx6WErehUQd8q8QhGzTzQ8Zt
dUuKpOTBg7N7V4HCiNX2KjxsMk/wVhae4W+m2hOiPKwB2chjJfHZcGcG/Evf7CtA
ie5LdfpF
=vuAw
-----END PGP SIGNATURE-----

--Npe8IFkXV6DKz+AA--
