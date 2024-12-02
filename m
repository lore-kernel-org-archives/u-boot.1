Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4DCD7831F
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 13:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ABAF890BC;
	Mon,  2 Dec 2024 14:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yh+o87Cj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 145E988F55; Mon,  2 Dec 2024 14:35:15 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F641885F7
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 14:35:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b66d55522dso324303385a.1
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 05:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733146511; x=1733751311; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OGNpODrkfBOyKmFHWhUSzuq7U1iHWxgIKoW4QHownS8=;
 b=Yh+o87CjxXrhrHBthpVx+QkMHmnN50kEtrVDBg2YQx4Sz4mFo6OkhPr+zkAVPIIJ1W
 VBiHubAZToHbXRx80ScknPQEw68MeEPxf6huA4IPH6Ccj78atxU/I7ZXeenSkQnC2GJo
 VaK7kx6pj5j8qJHI+K/8uvCPunZTH5FYIKJnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733146511; x=1733751311;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGNpODrkfBOyKmFHWhUSzuq7U1iHWxgIKoW4QHownS8=;
 b=u2Is4qJyhxywqptxcp0ZnpyoRRbTomrCXzS3f8qN+GFVl3hBhjrH1bi8N9sDbp+08Q
 AM2SIEkWOtwR1eo6p2CcvJA+v/V5P8/XOHGpiK3Y9Mwk+/PoBnAfuU/rrGkC/nLIYrBv
 MEWpDqKBOnLnmvvqxkW6ys72pgTV2D/Jyw0fYGzmrMtyoe/4RRoakeEHvR41HWexClzP
 nL2lI8zFTOvgxa/YSYIlrrn2ewRinlPb7xlUhkt1zQAO+Q0cNV3pjJFaAApKyrw0aL5B
 qzJemr4PyWo0ZYLbq3ykcUeq+dLUdleXW0l4pYJ0YO1XPLZ2KURF3LV5vd7Sld0vTdqj
 i/Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3xA+lakbVpiR/JFQqU4VW0DbEX/a7GuDfaZz2vBmWRlF9B5VuvpMqAg9rt4r8ZsOK2m+b9rU=@lists.denx.de
X-Gm-Message-State: AOJu0YwxLJ13yo5W/8lYJGI279Vf4FJ+KG1AM2ft6pS8QgS+QBTY2177
 byh99/1ssz2eyRsRrcgAtpkbIUpODAj7tAA50oAMHixjNLwNLWL2bkyQvjXxQNY=
X-Gm-Gg: ASbGncviFHoW3kOnYfJM/9kE0CDQvkAkBnqBknOqc8uniZXV+a5+D23pPYk8+S491E3
 ipTi+bS1KoL7ojw5kzP3uOXug7b6NBBabG7C0LNsdxDaQ5wXoBpEKU6ClWXn4GLBnc6hl1bbys+
 wG23aDtPDc9tYcsK7GJn5A9bC7kif+lfma0EvfGU1DEUBSCo+sap1EC3B04VO3vbX7uV4s0JhOt
 cpCSKDKEFz4vixwgmgHb3npHrUXtPuJZ9qLik/KIwyi/UkqDw==
X-Google-Smtp-Source: AGHT+IGuNTanI6/jRzX8vjcoUskmpkM724PGq6FJc2QbmNZ1JruRzIuucwZnBN0birO4c40cme+Faw==
X-Received: by 2002:ad4:5d4d:0:b0:6d8:8d87:e5b4 with SMTP id
 6a1803df08f44-6d88d8807b5mr180695876d6.19.1733146511149; 
 Mon, 02 Dec 2024 05:35:11 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d883839882sm39670076d6.13.2024.12.02.05.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:35:10 -0800 (PST)
Date: Mon, 2 Dec 2024 07:35:07 -0600
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
Message-ID: <20241202133507.GB2457179@bill-the-cat>
References: <20241126155508.GR3600562@bill-the-cat>
 <CAFLszThjgZtYrc707w8D+PZULJQB8qpNxgDYnAV+UoNebaPm8g@mail.gmail.com>
 <20241126223332.GV3600562@bill-the-cat>
 <aa7134ee-97dc-4fcc-b739-0f97e57817fd@gmx.de>
 <20241126233218.GW3600562@bill-the-cat>
 <CAFLszTi1A_672F68q5DYJW2g0T+LGZJcBwSVysXJD7+xG=Shbw@mail.gmail.com>
 <20241127141532.GZ3600562@bill-the-cat>
 <CAFLszTg8L4A0oGLh=K5kc8hR_E+LxFYeC_vNHMZDbV_+ZT8Btg@mail.gmail.com>
 <20241127221059.GE3600562@bill-the-cat>
 <CAFLszTiP3ika=dGQ9pX3btdY7CWB-n3AsqaSa4DZRPJj9fs0Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p0W6GjN7TU4MZTnD"
Content-Disposition: inline
In-Reply-To: <CAFLszTiP3ika=dGQ9pX3btdY7CWB-n3AsqaSa4DZRPJj9fs0Hg@mail.gmail.com>
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


--p0W6GjN7TU4MZTnD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2024 at 01:24:54PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 27 Nov 2024 at 15:11, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Nov 27, 2024 at 07:56:11AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 27 Nov 2024 at 07:15, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Nov 27, 2024 at 06:07:58AM -0700, Simon Glass wrote:
> > > > > Hi,
> > > > >
> > > > > On Tue, 26 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Nov 26, 2024 at 11:50:40PM +0100, Heinrich Schuchardt w=
rote:
> > > > > > > On 11/26/24 23:33, Tom Rini wrote:
> > > > > > > > On Tue, Nov 26, 2024 at 01:04:25PM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Tue, 26 Nov 2024 at 08:55, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Nov 26, 2024 at 08:37:33AM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > >
> > > > > > > > > > > On Tue, 26 Nov 2024 at 02:35, Heinrich Schuchardt <xy=
pron.glpk@gmx.de> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On 25.11.24 21:44, Simon Glass wrote:
> > > > > > > > > > > > > Exported functions should be documented in the he=
ader file, not the
> > > > > > > > > > > > > implementation. We tend to make such updates on a=
 piecemeal basis to
> > > > > > > > > > > > > avoid a 'flag day'. Move some comments related to=
 memory allocation to
> > > > > > > > > > > > > follow the convention.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > >
> > > > > > > > > > > > Please, have a look at this line in doc/
> > > > > > > > > > > >
> > > > > > > > > > > > doc/api/efi.rst:78:
> > > > > > > > > > > > .. kernel-doc:: lib/efi_loader/efi_memory.c
> > > > > > > > > > >
> > > > > > > > > > > Hmm, we should not add C files as then we end up with=
 all sorts of
> > > > > > > > > > > internal functions, like checksum(). The help is a bi=
t of a mess on
> > > > > > > > > > > that page IMO and it could use an index at the top or=
 side.
> > > > > > > > > >
> > > > > > > > > > Why? Looking at the linux kernel (where we borrow this =
framework from
> > > > > > > > > > and lots of developers expect to follow that style) it'=
s extremely
> > > > > > > > > > common to kernel-doc C files. I don't see why documenti=
ng internal
> > > > > > > > > > functions (which should be clear as being internal) is =
a problem.
> > > > > > > > >
> > > > > > > > > It depends what you mean by docs. U-Boot puts the documen=
tation for
> > > > > > > > > exported functions in header files.
> > > > > > > >
> > > > > > > > I'm sorry, that's a circular definition. And no, there is n=
ot a hard and
> > > > > > > > fast rule that we only put kernel-doc style comments in hea=
der files
> > > > > > > > (which are consumed by other files and tooling to generate
> > > > > > > > documentation).
> > > > > > > >
> > > > > > > > > Putting docs in C files clutters the docs with internal
> > > > > > > > > implementations, when most people just want to see the AP=
I. The way
> > > > > > > > > U-Boot does things, it is easy to see the internal (imple=
mentation)
> > > > > > > > > docs by looking at the C code and the external functions =
by looking at
> > > > > > > > > the header files.
> > > > > > > >
> > > > > > > > Or it makes things harder to understand because the human r=
eadable
> > > > > > > > documentation for a given function is separate from the fil=
e the
> > > > > > > > implements the function. This is possibly why in the linux =
kernel, where
> > > > > > > > we borrow "kernel-doc" from, documentation is frequently in=
 the C file
> > > > > > > > which is then included in Documentation files (the type you=
 objected to
> > > > > > > > in the start of this patch) which include additional human-=
readable
> > > > > > > > explanation of the intention and usage of the API in questi=
on.
> > > > > > > >
> > > > > > >
> > > > > > > For static functions we will continue to have function docume=
ntation in
> > > > > > > the C files and not in the headers. I personally never looked=
 up the API
> > > > > > > documentation in the HTML docs but always in the source.
> > > > >
> > > > > Same here.
> > > > >
> > > > > > >
> > > > > > > I am not opposed against moving the EFI function documentatio=
n into the
> > > > > > > header files. But we should update doc/develop/efi.rst accord=
ingly in
> > > > > > > the same patch series. This is missing here.
> > > > >
> > > > > OK
> > > > >
> > > > > >
> > > > > > My point is that the linux kernel is about 60% C files and 40% =
header
> > > > > > files being kernel-doc'd in to documentation files and so "U-Bo=
ot
> > > > > > doesn't put documentation in to C files" seems like the wrong a=
pproach.
> > > > >
> > > > > U-Boot tries to document functions in header files. At the risk of
> > > > > making a blanket statement with thousands of counter-examples, th=
at is
> > > > > not so much the case in Linux.
> > > > >
> > > > > To a large extent, people developing features in U-Boot rely on t=
he
> > > > > header files to see what functions they can call. With the
> > > > > documentation there, they often don't need to look at the source.=
 I
> > > > > certainly don't, unless the header-file comment is inadequate.
> > > >
> > > > I think this is a case of what you do, rather than what everyone el=
se
> > > > does.
> > >
> > > That's not my reading of the source tree.
> >
> > So, if we call this point 1 for a moment.
> >
> > > The file we are talking about has some comments in the header and some
> > > in the source file. When you use an lsp client, it doesn't know what
> > > to do.
> >
> > Sounds like a bad client? Because again, we should be following the
> > kernel here.
> >
> > > > We want to be more like the linux kernel here, rather than less
> > > > like the linux kernel, given the number of kernel people also worki=
ng
> > > > here. If Heinrich is fine with re-arranging everything, OK. But I t=
hink
> > > > documentation with the code makes it less likely to get out of date,
> > > > both in terms of intentional changes and bug fixes.
> > >
> > > I am not suggesting separating documentation from code. I agree that
> > > makes no sense. What I have consistently done (and asked for in
> > > reviews) is:
> > >
> > > - exported functions are documented next to their prototype in the he=
ader
> > > - static functions are documented next to their implementation
> >
> > So going back to point 1 now, yes. This is what I'm saying. Your
> > preference, expressed through reviews and telling people to change when
> > they do it other ways, is where the current situation comes from.
> >
> > > This makes it easy to read the header file and see what the module is
> > > doing, without having to dive into the implementation, which could be
> > > 1000 lines or more. It also makes for more useful kerneldoc, IMO,
> > > since we are showing functions which are exported and therefore more
> > > useful for development. Adding the entire C code of U-Boot into
> > > kerneldoc seems like a bad use of space.
> >
> > Um, I don't follow you here. If the code doesn't have kerneldoc
> > comments, it's not included. I just made a silly test with a change to
> > include/clk.h. It's not included in the output. And "the code might be
> > so big it needs refactoring" is not a good excuse.
>=20
> Yes, I see that static functions don't appear by default, so adding C
> files doesn't necessarily result in functions appearing in the doc
> output.

Only properly formatted comments are used in documentation, yes. So
static functions could be, if it was important to do so.

> > The kernel is inconsistent here. The first example I went to look for of
> > something that uses both C and header files in a document was
> > Documentation/admin-guide/pstore-blk.rst and both fs/pstore/blk.c and
> > include/linux/pstore_blk.h are kernel-doc'd in and the header describes
> > a public function of the C file while the C file describes other
> > functions too.
>=20
> Yes, pstore docs seems like a nice way to do things, for docs.
>=20
> For people working on the code base, I strongly believe that exported
> functions and structs are the main way to understand how to use a
> subsystem, so their docs should be in the header file.

Sure. But there is no project-wide rule. I strongly believe that the API
should be documented alongside of the code so that it doesn't drift
apart, among other reasons.

--=20
Tom

--p0W6GjN7TU4MZTnD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdNt4sACgkQFHw5/5Y0
tywBHwv/VTGJH5rgMOl0FxbxDZaD6ZyqggS/wTy8WM9BPX2skTuRsWTkX/AUS/IV
3gnN2Lat2/qjj9wtFO8GgqsAjFgmx0Azd7yXw13YQFpQGUmMLp/HrLMPFknYJ/yE
tJ9VJWW7I8weSGvUw2RCvMa/esoNT07mHcBZrgKTwOGq65ii1QPmZEsmFHrxgJ18
kVVo5V36dXq/zt13aKRGvdo7zd+hQPsVdSAZHl2nSKSG8WR/LWQgKGyjv3xXqxRI
hS858PNuSyAG2UTm5cWmy58vx2XNxzcEoyX5B81jeccmtbU6Z/s/8uGF4icLDqX0
w2S9snSrjtoo4WRPWp67V7aHr8Y6+c3EmomztHoH6leYl8w463x7Qy2sp0qsESqd
U3qZD+GUHGjHBncsx5bLsrTguKIRy7PvOBN+pv5ihJZ0WMBDbMC1mwnv8x8CacRU
c2CKviSOCo5xe73St5y2k0Q+GY9tR5pLCmq3aDjWOSAi0R7cdYGwyQG2clhE6ksc
N3iu5yrx
=dBzG
-----END PGP SIGNATURE-----

--p0W6GjN7TU4MZTnD--
