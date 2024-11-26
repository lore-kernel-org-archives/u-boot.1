Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F338DD66B85
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 22:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ACC689612;
	Tue, 26 Nov 2024 23:33:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yns2oowY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C8BB894F4; Tue, 26 Nov 2024 23:33:41 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7CB489266
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 23:33:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-297078d8eaeso4332339fac.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 14:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732660416; x=1733265216; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Eek4nEbSgnbMZsavauArj0ASt5znWdCQWCzVBJdjl4k=;
 b=Yns2oowYGbM+nr9M70aFDFUX5ZYeP2rodrzYrkeS7OoM+3g6GJvNYjoE6t2CEz4HjY
 hNvX0tEL6cIG0LHGkGOqiSmPvtFbyKuO5XFO/uLueA20pUWLOihdxjJTNdUrXAAgX/m/
 62w54ehJmcuzavWh87sWhmE0NjA8yl4eGhK9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732660416; x=1733265216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eek4nEbSgnbMZsavauArj0ASt5znWdCQWCzVBJdjl4k=;
 b=ILtckaUrqUwJZ5+XB5MuMShfeeuRxjgObTrpx9ljh21CaozZlPnnje0FCWJVeOHrma
 rp+gpO1xtcR5ZtSQpd98gepqZyUSl87WBbVaSG7w1QFpM1ArzROgZqq6D9RwHTewpF7g
 gqECnCTfb4KdYBF+WjXwwp5MljhgcK/WatRZdy+ejwqddpAcRwfRDQwG7/BRZ9JvudfW
 Zi0zXMusQhb5SNGn1doBbgCQcgBs/OC3+rEHNrHPaBGcWid5sXMBuCsLkxErbWkjkOM/
 ETuUIyftGbEty6LZTR6loCbAEklMZ2cmtb7KQYfciQGW+RNLNTNtml1uD4WMhrRuqjZI
 pRZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeLX7msakvkQDHS+QMAZpSE2WWmeDq57rVqfmPeHbIV3eW/8HM5NUR8DA0okiDBjn51jnzZYI=@lists.denx.de
X-Gm-Message-State: AOJu0YyoAO5820YBgJv3kWvFwtfh8pgGdLEZH/BgXWTcnP25NIBLG2ta
 8vCEM9SpzGJp6WH1M/RGmHBwMetbCfx9+W6Gy1aRwnbPsRspvyg6JY89cyphGMg=
X-Gm-Gg: ASbGncsXsFZt5utzo1lLHpzAi/BmYPyy773BSPrTkGP3roN1tLpFenZyohVG9cADXxX
 v7cUZrC6kavsHO9MHwWpOSdzQcfGFBUlMoIlPGL7pl3QilpqLQbzC+hTcT406Co+3uX7lwnBYSm
 LO1inCFH2PYCiWcPoRUzgoJMTlznyLl+ItXayMaSOl79M3M4fI5G6omuhhrM+ylqQF3rSimbhch
 nuT/tfO9XOM6GxJ5LxRujxZloM/MYm7Dvv1uDO0ILGdlZwNPg==
X-Google-Smtp-Source: AGHT+IHOloh3V3C37rrUoqMNJYXwwtqL6By8uPa6UkJ+657lYFSOWM0pKaODYGw1FXI8+gh1T15yPA==
X-Received: by 2002:a05:6359:5fac:b0:1b8:3435:5999 with SMTP id
 e5c5f4694b2df-1cab15d44edmr124578955d.14.1732660416645; 
 Tue, 26 Nov 2024 14:33:36 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466a43545besm16197931cf.83.2024.11.26.14.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 14:33:35 -0800 (PST)
Date: Tue, 26 Nov 2024 16:33:32 -0600
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
Message-ID: <20241126223332.GV3600562@bill-the-cat>
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-6-sjg@chromium.org>
 <d415c887-bb0c-47e8-bfd4-d0049f596367@gmx.de>
 <CAFLszTiOp56JkV1u5qOdJUYH2vJ5YHWwpBUmhb8WWiNs2S0B+w@mail.gmail.com>
 <20241126155508.GR3600562@bill-the-cat>
 <CAFLszThjgZtYrc707w8D+PZULJQB8qpNxgDYnAV+UoNebaPm8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BJywYHbw+qriKrcA"
Content-Disposition: inline
In-Reply-To: <CAFLszThjgZtYrc707w8D+PZULJQB8qpNxgDYnAV+UoNebaPm8g@mail.gmail.com>
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


--BJywYHbw+qriKrcA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 01:04:25PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 26 Nov 2024 at 08:55, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Nov 26, 2024 at 08:37:33AM -0700, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Tue, 26 Nov 2024 at 02:35, Heinrich Schuchardt <xypron.glpk@gmx.de=
> wrote:
> > > >
> > > > On 25.11.24 21:44, Simon Glass wrote:
> > > > > Exported functions should be documented in the header file, not t=
he
> > > > > implementation. We tend to make such updates on a piecemeal basis=
 to
> > > > > avoid a 'flag day'. Move some comments related to memory allocati=
on to
> > > > > follow the convention.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > Please, have a look at this line in doc/
> > > >
> > > > doc/api/efi.rst:78:
> > > > .. kernel-doc:: lib/efi_loader/efi_memory.c
> > >
> > > Hmm, we should not add C files as then we end up with all sorts of
> > > internal functions, like checksum(). The help is a bit of a mess on
> > > that page IMO and it could use an index at the top or side.
> >
> > Why? Looking at the linux kernel (where we borrow this framework from
> > and lots of developers expect to follow that style) it's extremely
> > common to kernel-doc C files. I don't see why documenting internal
> > functions (which should be clear as being internal) is a problem.
>=20
> It depends what you mean by docs. U-Boot puts the documentation for
> exported functions in header files.

I'm sorry, that's a circular definition. And no, there is not a hard and
fast rule that we only put kernel-doc style comments in header files
(which are consumed by other files and tooling to generate
documentation).

> Putting docs in C files clutters the docs with internal
> implementations, when most people just want to see the API. The way
> U-Boot does things, it is easy to see the internal (implementation)
> docs by looking at the C code and the external functions by looking at
> the header files.

Or it makes things harder to understand because the human readable
documentation for a given function is separate from the file the
implements the function. This is possibly why in the linux kernel, where
we borrow "kernel-doc" from, documentation is frequently in the C file
which is then included in Documentation files (the type you objected to
in the start of this patch) which include additional human-readable
explanation of the intention and usage of the API in question.

--=20
Tom

--BJywYHbw+qriKrcA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdGTLAACgkQFHw5/5Y0
tyzmOgv/clnMCEW+2RpnTvu1LSdHVqdp8dz19gaHFnBDJ+kPpa0Lo2XVeKFQHMWr
0tmo63Cz5R2yUp5pHmH9pn2LMRt28GwnJcCWbd+UB7pYCTiORc845aOYdn14Ehpk
6w9n6wTzrt+hTc5zq7hajnLszKMy5gGrh+JrpVrz3nRnEuxgwXMSBJot4/ajegyD
gICmeQNRDx8kSV9LBfNw8Wkaf3hJyYBk51mtJOAvTJm+kM4itmQu3inmz+yMOw1Y
RQ+m7Ep9Rr6hRDb71G0V45rxnw4g/D4YkXkNgxPN59u5OOSMGPqNXqmhOGI2j09y
k5Ay2gLgRjc3ril8r5hGH/0IuyAr1TQd/tT8f0IggMGpemi/ZUqHxm+Uo2PMuX+5
bphV0XjgWdgRWqWCKqeK0TRrB4AixGOuK/amnGjuYHPmrCxpicVm/7ASKv7qkouJ
XHdP12XkG7iT5ssRvBxtTvS8oCfDl1VYQRskncV/aD9W8FkeCBxAlr/WyJGjsk+m
/hu+UD0n
=DdyU
-----END PGP SIGNATURE-----

--BJywYHbw+qriKrcA--
