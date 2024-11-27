Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB44D6D242
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 22:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A6268980C;
	Wed, 27 Nov 2024 23:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HaT7K+9i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A59988981D; Wed, 27 Nov 2024 23:11:07 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D55A897F9
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 23:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b65f2daae6so14474085a.1
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 14:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732745464; x=1733350264; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eoLD2FyBXJfBNg9h+3eNF8ibw8llOjNGpNg1e+jt6ZE=;
 b=HaT7K+9iL29BD7YcPbc9UA+nLOorXTyFFL6C/fu3upPZI/WvpIMsLwTqrfOp3Ts7mY
 ZQrUomA+04z/vNSK/XB7tGyO2NIKYUK3S5/rTEpsahpYWBVogfuCfL5hLhWulVt8TIYr
 6RYGG0XVwG9xwC3rUJATJqmFXnHsVlFj6XIOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732745464; x=1733350264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoLD2FyBXJfBNg9h+3eNF8ibw8llOjNGpNg1e+jt6ZE=;
 b=AW2O9PC9RQKc4PMN8+7GD6fUNocL2FQYxdHWkoA23TNHFZv2O8QZPLiBO+KS9dybQf
 9icxL/SeZMF+0YDL/hQqAQEH5Vg/hqPXfaKRtcxsmevzNJqZbZqd4Ga9Gf3OUz2JFGy2
 1r3npvho38a22oRCAxWDNUBX1KYLoSfPZuPnVf7u0EhynhjyRSsMSVAGxMePxS1wt2+w
 N3TFuKqg8YpAeoiPEGjv58RIdOYCruHQoZJ2MfBWbxb8zWX7i039F/T4Cw/ldX8H9DJC
 1o0KrENJaa0axQPN1Psu8RhuPIxnq2mB5E5jKqCtj3QPy2TE56k3YzR/eDp4b73ydy/V
 26DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmnKB0zUjIsKHgUOTERInGJAfdN+JGqWiZcIaEkJELEtFlwe0PORHmzcc/CUCB5wUKucVjqew=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/y+/X8AsStKZATtPrfjZkmtI1oaHyeO2m/cA7i8BmNNjulouD
 6AP9zmHAQ8P9LQZLQq9vgbtlirCwZ0Ae5PABuNZFX8Y3DsbEL5b/MatYbEZUpJKHqnB0i4et09g
 ZQAQ=
X-Gm-Gg: ASbGncuucIiAUiCjIuh+fSumVaIFKX/tcZgO5lK3IS2UXryXpJOu9phRChg9KaPnL1b
 1iWS2LPHIyWbD0R1ab5yFbSijzRTZoh9tkC8Yg11FpYfyLgX5I57K7oElDxEPLR6nnoP7spqa8f
 TR1Wfal0wu0mdlVFcb1s0b8etIsCkVV99TDKV8hKWmMctV/CHGZm7aucELPJ72uyBl1XWfqqzw0
 XBDjj1B1+v2SEBj3a219aQJwVpjkBeMlg1KSid2l3yA1IKIdg==
X-Google-Smtp-Source: AGHT+IHOA7EkshjVW9DChE+IT/v3KTvc9vshDItf06WuZsQELKnGiMaGAPImHG7JoFwFBXB3ifuc4A==
X-Received: by 2002:a05:620a:268c:b0:7b6:6a76:3a4a with SMTP id
 af79cd13be357-7b67c2c16d3mr538370285a.28.1732745463966; 
 Wed, 27 Nov 2024 14:11:03 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492e03bsm4746385a.38.2024.11.27.14.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 14:11:02 -0800 (PST)
Date: Wed, 27 Nov 2024 16:10:59 -0600
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
Message-ID: <20241127221059.GE3600562@bill-the-cat>
References: <d415c887-bb0c-47e8-bfd4-d0049f596367@gmx.de>
 <CAFLszTiOp56JkV1u5qOdJUYH2vJ5YHWwpBUmhb8WWiNs2S0B+w@mail.gmail.com>
 <20241126155508.GR3600562@bill-the-cat>
 <CAFLszThjgZtYrc707w8D+PZULJQB8qpNxgDYnAV+UoNebaPm8g@mail.gmail.com>
 <20241126223332.GV3600562@bill-the-cat>
 <aa7134ee-97dc-4fcc-b739-0f97e57817fd@gmx.de>
 <20241126233218.GW3600562@bill-the-cat>
 <CAFLszTi1A_672F68q5DYJW2g0T+LGZJcBwSVysXJD7+xG=Shbw@mail.gmail.com>
 <20241127141532.GZ3600562@bill-the-cat>
 <CAFLszTg8L4A0oGLh=K5kc8hR_E+LxFYeC_vNHMZDbV_+ZT8Btg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3kyW4h1BUFCzcpVp"
Content-Disposition: inline
In-Reply-To: <CAFLszTg8L4A0oGLh=K5kc8hR_E+LxFYeC_vNHMZDbV_+ZT8Btg@mail.gmail.com>
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


--3kyW4h1BUFCzcpVp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 07:56:11AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 27 Nov 2024 at 07:15, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Nov 27, 2024 at 06:07:58AM -0700, Simon Glass wrote:
> > > Hi,
> > >
> > > On Tue, 26 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Nov 26, 2024 at 11:50:40PM +0100, Heinrich Schuchardt wrote:
> > > > > On 11/26/24 23:33, Tom Rini wrote:
> > > > > > On Tue, Nov 26, 2024 at 01:04:25PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 26 Nov 2024 at 08:55, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Tue, Nov 26, 2024 at 08:37:33AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Heinrich,
> > > > > > > > >
> > > > > > > > > On Tue, 26 Nov 2024 at 02:35, Heinrich Schuchardt <xypron=
=2Eglpk@gmx.de> wrote:
> > > > > > > > > >
> > > > > > > > > > On 25.11.24 21:44, Simon Glass wrote:
> > > > > > > > > > > Exported functions should be documented in the header=
 file, not the
> > > > > > > > > > > implementation. We tend to make such updates on a pie=
cemeal basis to
> > > > > > > > > > > avoid a 'flag day'. Move some comments related to mem=
ory allocation to
> > > > > > > > > > > follow the convention.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > >
> > > > > > > > > > Please, have a look at this line in doc/
> > > > > > > > > >
> > > > > > > > > > doc/api/efi.rst:78:
> > > > > > > > > > .. kernel-doc:: lib/efi_loader/efi_memory.c
> > > > > > > > >
> > > > > > > > > Hmm, we should not add C files as then we end up with all=
 sorts of
> > > > > > > > > internal functions, like checksum(). The help is a bit of=
 a mess on
> > > > > > > > > that page IMO and it could use an index at the top or sid=
e.
> > > > > > > >
> > > > > > > > Why? Looking at the linux kernel (where we borrow this fram=
ework from
> > > > > > > > and lots of developers expect to follow that style) it's ex=
tremely
> > > > > > > > common to kernel-doc C files. I don't see why documenting i=
nternal
> > > > > > > > functions (which should be clear as being internal) is a pr=
oblem.
> > > > > > >
> > > > > > > It depends what you mean by docs. U-Boot puts the documentati=
on for
> > > > > > > exported functions in header files.
> > > > > >
> > > > > > I'm sorry, that's a circular definition. And no, there is not a=
 hard and
> > > > > > fast rule that we only put kernel-doc style comments in header =
files
> > > > > > (which are consumed by other files and tooling to generate
> > > > > > documentation).
> > > > > >
> > > > > > > Putting docs in C files clutters the docs with internal
> > > > > > > implementations, when most people just want to see the API. T=
he way
> > > > > > > U-Boot does things, it is easy to see the internal (implement=
ation)
> > > > > > > docs by looking at the C code and the external functions by l=
ooking at
> > > > > > > the header files.
> > > > > >
> > > > > > Or it makes things harder to understand because the human reada=
ble
> > > > > > documentation for a given function is separate from the file the
> > > > > > implements the function. This is possibly why in the linux kern=
el, where
> > > > > > we borrow "kernel-doc" from, documentation is frequently in the=
 C file
> > > > > > which is then included in Documentation files (the type you obj=
ected to
> > > > > > in the start of this patch) which include additional human-read=
able
> > > > > > explanation of the intention and usage of the API in question.
> > > > > >
> > > > >
> > > > > For static functions we will continue to have function documentat=
ion in
> > > > > the C files and not in the headers. I personally never looked up =
the API
> > > > > documentation in the HTML docs but always in the source.
> > >
> > > Same here.
> > >
> > > > >
> > > > > I am not opposed against moving the EFI function documentation in=
to the
> > > > > header files. But we should update doc/develop/efi.rst accordingl=
y in
> > > > > the same patch series. This is missing here.
> > >
> > > OK
> > >
> > > >
> > > > My point is that the linux kernel is about 60% C files and 40% head=
er
> > > > files being kernel-doc'd in to documentation files and so "U-Boot
> > > > doesn't put documentation in to C files" seems like the wrong appro=
ach.
> > >
> > > U-Boot tries to document functions in header files. At the risk of
> > > making a blanket statement with thousands of counter-examples, that is
> > > not so much the case in Linux.
> > >
> > > To a large extent, people developing features in U-Boot rely on the
> > > header files to see what functions they can call. With the
> > > documentation there, they often don't need to look at the source. I
> > > certainly don't, unless the header-file comment is inadequate.
> >
> > I think this is a case of what you do, rather than what everyone else
> > does.
>=20
> That's not my reading of the source tree.

So, if we call this point 1 for a moment.

> The file we are talking about has some comments in the header and some
> in the source file. When you use an lsp client, it doesn't know what
> to do.

Sounds like a bad client? Because again, we should be following the
kernel here.

> > We want to be more like the linux kernel here, rather than less
> > like the linux kernel, given the number of kernel people also working
> > here. If Heinrich is fine with re-arranging everything, OK. But I think
> > documentation with the code makes it less likely to get out of date,
> > both in terms of intentional changes and bug fixes.
>=20
> I am not suggesting separating documentation from code. I agree that
> makes no sense. What I have consistently done (and asked for in
> reviews) is:
>=20
> - exported functions are documented next to their prototype in the header
> - static functions are documented next to their implementation

So going back to point 1 now, yes. This is what I'm saying. Your
preference, expressed through reviews and telling people to change when
they do it other ways, is where the current situation comes from.

> This makes it easy to read the header file and see what the module is
> doing, without having to dive into the implementation, which could be
> 1000 lines or more. It also makes for more useful kerneldoc, IMO,
> since we are showing functions which are exported and therefore more
> useful for development. Adding the entire C code of U-Boot into
> kerneldoc seems like a bad use of space.

Um, I don't follow you here. If the code doesn't have kerneldoc
comments, it's not included. I just made a silly test with a change to
include/clk.h. It's not included in the output. And "the code might be
so big it needs refactoring" is not a good excuse.

The kernel is inconsistent here. The first example I went to look for of
something that uses both C and header files in a document was
Documentation/admin-guide/pstore-blk.rst and both fs/pstore/blk.c and
include/linux/pstore_blk.h are kernel-doc'd in and the header describes
a public function of the C file while the C file describes other
functions too.

--=20
Tom

--3kyW4h1BUFCzcpVp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdHmO4ACgkQFHw5/5Y0
tyxStgv/QrsCY/mPqYKucTgEil5NHTin7SzS7XKfaFwu0VO/ZJtoAujVyATAC9pn
S2Xkp8aqmg57GHIveiGJfgL1wz6vkMy2+sCZvgK9LN6AM18V/0K2LT+Py0dK+Q+7
jWjWwBo72OtoRuXHVPcfAJypBfUSGsrbpgXLXi2fFlWkCv/rK9XTL2ATvS/KLhEU
+RJM03HsnXI13SOQT3fyEM65CvBkbERxbeYSCTqIVgTJlksDV3iDIZTIC5BcPOPr
InkvweVUfkNnM07IQLd2rWFRjrx1xVhoDsJaAZzzBVenyFOKr6ymdYnSphKz4ZaR
v1gYVtxO778JA8GHhwmKXP4TmgdaSQAu/qloFb6BBH+G6rd8iNFs3/rC31kZsD0r
kVZiKyI2XKpPMzNXF/zfRVkd8povO0q0uSfoGsEOG7gYRdxQD65dqBIgy9aS4lp5
X0A8NuGgdriAAeI5j71v4NnXXPoAU7nQVKmJnI1QFHkh/5nLOVeDXVUfPU28nQR2
Sg1ZdX2H
=WRud
-----END PGP SIGNATURE-----

--3kyW4h1BUFCzcpVp--
