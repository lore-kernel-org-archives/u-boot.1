Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50FCD66B9A
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 23:32:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E32AA89791;
	Wed, 27 Nov 2024 00:32:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sp6mjYnf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72D5C89669; Wed, 27 Nov 2024 00:32:26 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18A6589772
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 00:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6eea47d51aeso59149067b3.2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 15:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732663943; x=1733268743; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BaftC54eejqG4zHDkQQb3b1qEPHRh6O5uoRxi7IZKns=;
 b=Sp6mjYnf03+ATK5B1TdujRIDYSeKn7/w94hEeR3zV9GMMai8lv5qMsla/bsJF4JmsW
 f6H/mkL2Pnfhza1aaXb5jIhE+0lKPbpPWIzBRPOeBh323ZNKfWrQskoe3NRaqS0mxp26
 qEVVTA7vuDJ79cGfYwp27YFUF1GKSrpK/OWXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732663943; x=1733268743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BaftC54eejqG4zHDkQQb3b1qEPHRh6O5uoRxi7IZKns=;
 b=sFve3B6n7YLmID+ddFKpAswD8QWGbBtoyOYtjmbvUKrUZ0EbLB3jdsE7Y+DDhb/6Lu
 +sc/dehnGmoZLQPg3ntCd2LSD9GuBo6TL4dY3XuIbAEXiIo3Ag4latGmInG/WZA/GZJv
 URxKtXDYuqq5Em96fOl4VpaZgUhi2MGrWBqTvidMIFkAIZj4NR0ymBWPgkpDgsQxrzVh
 D97BBIiWTPeISSTV1g5tRdbqT/Viov7+2WvBk1UPKHr/T322G0E7kc1Buuqfaf611oOp
 WmXSqpEGzgXlU5haL6NeD3O/iqIZlxybk5aR1aCcnA55g7nEalXqMbm8gI1+Ma3Yhu+f
 444Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfR1boUMkDPdqJpolmIK04CcxVqDzsa0yJz5C7etY6dpYm2UcchVuxvN3114Ynf0+21ZSJdYI=@lists.denx.de
X-Gm-Message-State: AOJu0Yxcb/EgXC4Fk1MJCZo7x2E/WCMiyzjKORUMmXb4Ny/ZLYa7LRF6
 IVDF0H49aBT40F5dImM7ZXnumAseeWuxT5fR91QInO5FjVyCeo6UFMSXHEq27w8=
X-Gm-Gg: ASbGnctC9OTMtydy9h0dKG/0fPf5qlv2IjiqUSbiXt9VAqxel40TbHPt0sFHb+9iL4Z
 gC6b9ONHpdsTiFx8ywOor3TYULMML5cnsaSNWd2dezQ/5Le/b2FYxYGOgNTMxFJlJD0ftzYwtZ0
 8olcXvWw/6PZ4VKqzjohsWAeuwiyBRahtMp7w3D7LU0ySh18PrrEkJ1dTicnGJ6Bk4lM6xR+Agc
 wAIY4viIEvUnm7KikwB+KxAoxY7Wu8AB+0ZA4kxQEeLl5qAbg==
X-Google-Smtp-Source: AGHT+IF/bTUAHljHKZK/YMrJfQ+99DrlPoV3AxnV2W3gvO6cOstiXMdDJKVbwOU2+9qL/VOpUnQwtA==
X-Received: by 2002:a05:690c:4906:b0:6ee:a70c:873c with SMTP id
 00721157ae682-6ef372802dbmr15233897b3.34.1732663942919; 
 Tue, 26 Nov 2024 15:32:22 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b4a487sm60658126d6.100.2024.11.26.15.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 15:32:22 -0800 (PST)
Date: Tue, 26 Nov 2024 17:32:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 05/13] efi_loader: Move some memory-function comments to
 header
Message-ID: <20241126233218.GW3600562@bill-the-cat>
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-6-sjg@chromium.org>
 <d415c887-bb0c-47e8-bfd4-d0049f596367@gmx.de>
 <CAFLszTiOp56JkV1u5qOdJUYH2vJ5YHWwpBUmhb8WWiNs2S0B+w@mail.gmail.com>
 <20241126155508.GR3600562@bill-the-cat>
 <CAFLszThjgZtYrc707w8D+PZULJQB8qpNxgDYnAV+UoNebaPm8g@mail.gmail.com>
 <20241126223332.GV3600562@bill-the-cat>
 <aa7134ee-97dc-4fcc-b739-0f97e57817fd@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/uf0nfbHSF51f7/o"
Content-Disposition: inline
In-Reply-To: <aa7134ee-97dc-4fcc-b739-0f97e57817fd@gmx.de>
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


--/uf0nfbHSF51f7/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 11:50:40PM +0100, Heinrich Schuchardt wrote:
> On 11/26/24 23:33, Tom Rini wrote:
> > On Tue, Nov 26, 2024 at 01:04:25PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >=20
> > > On Tue, 26 Nov 2024 at 08:55, Tom Rini <trini@konsulko.com> wrote:
> > > >=20
> > > > On Tue, Nov 26, 2024 at 08:37:33AM -0700, Simon Glass wrote:
> > > > > Hi Heinrich,
> > > > >=20
> > > > > On Tue, 26 Nov 2024 at 02:35, Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
> > > > > >=20
> > > > > > On 25.11.24 21:44, Simon Glass wrote:
> > > > > > > Exported functions should be documented in the header file, n=
ot the
> > > > > > > implementation. We tend to make such updates on a piecemeal b=
asis to
> > > > > > > avoid a 'flag day'. Move some comments related to memory allo=
cation to
> > > > > > > follow the convention.
> > > > > > >=20
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > >=20
> > > > > > Please, have a look at this line in doc/
> > > > > >=20
> > > > > > doc/api/efi.rst:78:
> > > > > > .. kernel-doc:: lib/efi_loader/efi_memory.c
> > > > >=20
> > > > > Hmm, we should not add C files as then we end up with all sorts of
> > > > > internal functions, like checksum(). The help is a bit of a mess =
on
> > > > > that page IMO and it could use an index at the top or side.
> > > >=20
> > > > Why? Looking at the linux kernel (where we borrow this framework fr=
om
> > > > and lots of developers expect to follow that style) it's extremely
> > > > common to kernel-doc C files. I don't see why documenting internal
> > > > functions (which should be clear as being internal) is a problem.
> > >=20
> > > It depends what you mean by docs. U-Boot puts the documentation for
> > > exported functions in header files.
> >=20
> > I'm sorry, that's a circular definition. And no, there is not a hard and
> > fast rule that we only put kernel-doc style comments in header files
> > (which are consumed by other files and tooling to generate
> > documentation).
> >=20
> > > Putting docs in C files clutters the docs with internal
> > > implementations, when most people just want to see the API. The way
> > > U-Boot does things, it is easy to see the internal (implementation)
> > > docs by looking at the C code and the external functions by looking at
> > > the header files.
> >=20
> > Or it makes things harder to understand because the human readable
> > documentation for a given function is separate from the file the
> > implements the function. This is possibly why in the linux kernel, where
> > we borrow "kernel-doc" from, documentation is frequently in the C file
> > which is then included in Documentation files (the type you objected to
> > in the start of this patch) which include additional human-readable
> > explanation of the intention and usage of the API in question.
> >=20
>=20
> For static functions we will continue to have function documentation in
> the C files and not in the headers. I personally never looked up the API
> documentation in the HTML docs but always in the source.
>=20
> I am not opposed against moving the EFI function documentation into the
> header files. But we should update doc/develop/efi.rst accordingly in
> the same patch series. This is missing here.

My point is that the linux kernel is about 60% C files and 40% header
files being kernel-doc'd in to documentation files and so "U-Boot
doesn't put documentation in to C files" seems like the wrong approach.

--=20
Tom

--/uf0nfbHSF51f7/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdGWn8ACgkQFHw5/5Y0
tyxbMAv/brmRrbSw224R4EsUrlz7w1CRzDdOGaT6+U5ijZyanFNehcDzHdYOj8tJ
1+YUJzDzww7ArwhvIfdMEd3ejA0fS9KDMjEVTqznAhzvISyM8ljwrZ5TjxJCworU
Fb6Z9Y4sesfmUkQ9wZSxWcSWSkPTjWdsyyOslmXurZdGFp6c88eoizveljStJV3O
XLqk4nR0p3TNbwtyEOc/EEjwZn8n41iuXN3lLMkAik9x2hJNzHxpuuTLvvEOSEmm
o9pJyudUX9duR8Lmo3yVL1Ux/YXcjWpd6EEQzQMLlfcEY2igl6eG9SAFFvVpBz1C
GcdQEsa+7KdV38H5tBrE6JB+mwrNnz3FZiSZ2QrmtbF7hyiuZ0Cgksl1ahnuqY1Y
R58XNQIRksnh4TAZH0l9mTyfKfg5jBEVe5km9PIbqz02iKdYF/LXkF6haQIr4N17
HtoxQ7qhmK1XeR9/bzU0TNa2xrLKUt0Sv1sMGpelR6jBhEyZLgiX1UXC1gnuIVC7
aWOSvDCc
=g7wH
-----END PGP SIGNATURE-----

--/uf0nfbHSF51f7/o--
