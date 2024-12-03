Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3F9E6C5E3
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 00:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDE2A885F4;
	Tue,  3 Dec 2024 01:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jbdyuhn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 246EA89171; Tue,  3 Dec 2024 01:35:11 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC05B87F3B
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 01:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6d8878ec049so35446626d6.3
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 16:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733186107; x=1733790907; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9WMHOHjiiA/M7ORR+oOAJ+Swm1eAJPNCbJrizJQezWg=;
 b=jbdyuhn/CtHWUBz4KpFEl3uyQmQVmMSfq2katN+S2f1zfqgeftHC/DH92N4iGV6Rxn
 bnCX3NsrHtuVdyTJenC+5Kz9LyzjfCVreyR25Xq82Rijq865NXO7+ViFzrpnQcpvodsZ
 BVdTX9E+wfSORqw0J7820eKUBPlwFrhsEKtYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733186107; x=1733790907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WMHOHjiiA/M7ORR+oOAJ+Swm1eAJPNCbJrizJQezWg=;
 b=BhmYW6VWW9fhqRSbi9p8EB8bdw/nvkhJiDlIckBQ/qPSTeq8ISVfKJ7GkHpRGImmC+
 kTV+web6wtbykG3n0ap7VMjGM2SxU5CIw5rdWjJ83+mdcfFyBZMkiwoIyDmCP7jMPrOZ
 utY6S1XxdtGN1Ld3niAH0VcnqAqx6LeerNICBm36lR+e0gt7c5o0DIquWGd8G6hOcfdQ
 YMfnGtgkvCGGHpr+/UhieuYDL6tBkNJ5cQW/Pv39QB/jYZVzYh04EOCiUvnHBQ8FQJ+/
 HbhVt0bZvLIg+8aV6Vvthm/SiIjHf3m2W6vGwGQm+SMGR1LIXmGJc4RmKdFtgLSUL6kY
 YzuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkc7G8HIJOA0YVr2ckrFBDDgyDJbJrcpYfwz2je9sQh/EAvcIrT1cyBGdgy+vQUpmVkq47hpU=@lists.denx.de
X-Gm-Message-State: AOJu0YzaDfsmWVrWiR8KFMcmhQP6Mn3MFdByg5fcIjDIAB/98f/+QZBU
 LidR3msRlmMxH6RnZ7CsmbHivI696m1mGdBmKfraHwGubcIaSffLsN3Z15HEsMs97JW3s+2URJO
 OwlQ=
X-Gm-Gg: ASbGncvX6DqQYBDiFqeCfCxSeB7BziTaN4Z0A/Ot/nCXQiuUYCNK3YCljDFA1iyhBHm
 eCeEq8D45fUJGvxTbJwjNgraT522NAFhvuR/NGJEBtV4mtiH5k0/lFfwkU6NUSCBg9/6AaVMCv2
 IjRl6sQPI1F/DtSbradyrPlwv2mQC3NkmKSL2GSMMt0HZSV7PIXBA0JqdOEsxx5jRsvT133kYG1
 d0pIwCGgz/YqP6iwwiQRNUDia2lWLPQ+PBxfT39BORN1i2s7g==
X-Google-Smtp-Source: AGHT+IHvMJbTWCMqtD6K4cfdcyIdR78gGqh7se/dXhwHr7yUkIuFGGcU9LXZIp24bJSaOOQw6fKq5A==
X-Received: by 2002:a05:6214:1947:b0:6d8:b5b8:702e with SMTP id
 6a1803df08f44-6d8b72ceee9mr13919006d6.9.1733186107433; 
 Mon, 02 Dec 2024 16:35:07 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8ae95ec53sm10844126d6.37.2024.12.02.16.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 16:35:06 -0800 (PST)
Date: Mon, 2 Dec 2024 18:35:03 -0600
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
Message-ID: <20241203003503.GL2457179@bill-the-cat>
References: <20241126223332.GV3600562@bill-the-cat>
 <aa7134ee-97dc-4fcc-b739-0f97e57817fd@gmx.de>
 <20241126233218.GW3600562@bill-the-cat>
 <CAFLszTi1A_672F68q5DYJW2g0T+LGZJcBwSVysXJD7+xG=Shbw@mail.gmail.com>
 <20241127141532.GZ3600562@bill-the-cat>
 <CAFLszTg8L4A0oGLh=K5kc8hR_E+LxFYeC_vNHMZDbV_+ZT8Btg@mail.gmail.com>
 <20241127221059.GE3600562@bill-the-cat>
 <CAFLszTiP3ika=dGQ9pX3btdY7CWB-n3AsqaSa4DZRPJj9fs0Hg@mail.gmail.com>
 <20241202133507.GB2457179@bill-the-cat>
 <CAFLszTi2g6a9HZNsrMGKiegQSQCLUsJEccHv2OR2DPvb7sXtDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="usmsPaXAus9Jlr78"
Content-Disposition: inline
In-Reply-To: <CAFLszTi2g6a9HZNsrMGKiegQSQCLUsJEccHv2OR2DPvb7sXtDA@mail.gmail.com>
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


--usmsPaXAus9Jlr78
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2024 at 05:20:31PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 2 Dec 2024 at 06:35, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Nov 30, 2024 at 01:24:54PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 27 Nov 2024 at 15:11, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Nov 27, 2024 at 07:56:11AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 27 Nov 2024 at 07:15, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Nov 27, 2024 at 06:07:58AM -0700, Simon Glass wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > On Tue, 26 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Tue, Nov 26, 2024 at 11:50:40PM +0100, Heinrich Schuchar=
dt wrote:
> > > > > > > > > On 11/26/24 23:33, Tom Rini wrote:
> > > > > > > > > > On Tue, Nov 26, 2024 at 01:04:25PM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Tue, 26 Nov 2024 at 08:55, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Tue, Nov 26, 2024 at 08:37:33AM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Tue, 26 Nov 2024 at 02:35, Heinrich Schuchardt=
 <xypron.glpk@gmx.de> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On 25.11.24 21:44, Simon Glass wrote:
> > > > > > > > > > > > > > > Exported functions should be documented in th=
e header file, not the
> > > > > > > > > > > > > > > implementation. We tend to make such updates =
on a piecemeal basis to
> > > > > > > > > > > > > > > avoid a 'flag day'. Move some comments relate=
d to memory allocation to
> > > > > > > > > > > > > > > follow the convention.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Please, have a look at this line in doc/
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > doc/api/efi.rst:78:
> > > > > > > > > > > > > > .. kernel-doc:: lib/efi_loader/efi_memory.c
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hmm, we should not add C files as then we end up =
with all sorts of
> > > > > > > > > > > > > internal functions, like checksum(). The help is =
a bit of a mess on
> > > > > > > > > > > > > that page IMO and it could use an index at the to=
p or side.
> > > > > > > > > > > >
> > > > > > > > > > > > Why? Looking at the linux kernel (where we borrow t=
his framework from
> > > > > > > > > > > > and lots of developers expect to follow that style)=
 it's extremely
> > > > > > > > > > > > common to kernel-doc C files. I don't see why docum=
enting internal
> > > > > > > > > > > > functions (which should be clear as being internal)=
 is a problem.
> > > > > > > > > > >
> > > > > > > > > > > It depends what you mean by docs. U-Boot puts the doc=
umentation for
> > > > > > > > > > > exported functions in header files.
> > > > > > > > > >
> > > > > > > > > > I'm sorry, that's a circular definition. And no, there =
is not a hard and
> > > > > > > > > > fast rule that we only put kernel-doc style comments in=
 header files
> > > > > > > > > > (which are consumed by other files and tooling to gener=
ate
> > > > > > > > > > documentation).
> > > > > > > > > >
> > > > > > > > > > > Putting docs in C files clutters the docs with intern=
al
> > > > > > > > > > > implementations, when most people just want to see th=
e API. The way
> > > > > > > > > > > U-Boot does things, it is easy to see the internal (i=
mplementation)
> > > > > > > > > > > docs by looking at the C code and the external functi=
ons by looking at
> > > > > > > > > > > the header files.
> > > > > > > > > >
> > > > > > > > > > Or it makes things harder to understand because the hum=
an readable
> > > > > > > > > > documentation for a given function is separate from the=
 file the
> > > > > > > > > > implements the function. This is possibly why in the li=
nux kernel, where
> > > > > > > > > > we borrow "kernel-doc" from, documentation is frequentl=
y in the C file
> > > > > > > > > > which is then included in Documentation files (the type=
 you objected to
> > > > > > > > > > in the start of this patch) which include additional hu=
man-readable
> > > > > > > > > > explanation of the intention and usage of the API in qu=
estion.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > For static functions we will continue to have function do=
cumentation in
> > > > > > > > > the C files and not in the headers. I personally never lo=
oked up the API
> > > > > > > > > documentation in the HTML docs but always in the source.
> > > > > > >
> > > > > > > Same here.
> > > > > > >
> > > > > > > > >
> > > > > > > > > I am not opposed against moving the EFI function document=
ation into the
> > > > > > > > > header files. But we should update doc/develop/efi.rst ac=
cordingly in
> > > > > > > > > the same patch series. This is missing here.
> > > > > > >
> > > > > > > OK
> > > > > > >
> > > > > > > >
> > > > > > > > My point is that the linux kernel is about 60% C files and =
40% header
> > > > > > > > files being kernel-doc'd in to documentation files and so "=
U-Boot
> > > > > > > > doesn't put documentation in to C files" seems like the wro=
ng approach.
> > > > > > >
> > > > > > > U-Boot tries to document functions in header files. At the ri=
sk of
> > > > > > > making a blanket statement with thousands of counter-examples=
, that is
> > > > > > > not so much the case in Linux.
> > > > > > >
> > > > > > > To a large extent, people developing features in U-Boot rely =
on the
> > > > > > > header files to see what functions they can call. With the
> > > > > > > documentation there, they often don't need to look at the sou=
rce. I
> > > > > > > certainly don't, unless the header-file comment is inadequate.
> > > > > >
> > > > > > I think this is a case of what you do, rather than what everyon=
e else
> > > > > > does.
> > > > >
> > > > > That's not my reading of the source tree.
> > > >
> > > > So, if we call this point 1 for a moment.
> > > >
> > > > > The file we are talking about has some comments in the header and=
 some
> > > > > in the source file. When you use an lsp client, it doesn't know w=
hat
> > > > > to do.
> > > >
> > > > Sounds like a bad client? Because again, we should be following the
> > > > kernel here.
> > > >
> > > > > > We want to be more like the linux kernel here, rather than less
> > > > > > like the linux kernel, given the number of kernel people also w=
orking
> > > > > > here. If Heinrich is fine with re-arranging everything, OK. But=
 I think
> > > > > > documentation with the code makes it less likely to get out of =
date,
> > > > > > both in terms of intentional changes and bug fixes.
> > > > >
> > > > > I am not suggesting separating documentation from code. I agree t=
hat
> > > > > makes no sense. What I have consistently done (and asked for in
> > > > > reviews) is:
> > > > >
> > > > > - exported functions are documented next to their prototype in th=
e header
> > > > > - static functions are documented next to their implementation
> > > >
> > > > So going back to point 1 now, yes. This is what I'm saying. Your
> > > > preference, expressed through reviews and telling people to change =
when
> > > > they do it other ways, is where the current situation comes from.
> > > >
> > > > > This makes it easy to read the header file and see what the modul=
e is
> > > > > doing, without having to dive into the implementation, which coul=
d be
> > > > > 1000 lines or more. It also makes for more useful kerneldoc, IMO,
> > > > > since we are showing functions which are exported and therefore m=
ore
> > > > > useful for development. Adding the entire C code of U-Boot into
> > > > > kerneldoc seems like a bad use of space.
> > > >
> > > > Um, I don't follow you here. If the code doesn't have kerneldoc
> > > > comments, it's not included. I just made a silly test with a change=
 to
> > > > include/clk.h. It's not included in the output. And "the code might=
 be
> > > > so big it needs refactoring" is not a good excuse.
> > >
> > > Yes, I see that static functions don't appear by default, so adding C
> > > files doesn't necessarily result in functions appearing in the doc
> > > output.
> >
> > Only properly formatted comments are used in documentation, yes. So
> > static functions could be, if it was important to do so.
> >
> > > > The kernel is inconsistent here. The first example I went to look f=
or of
> > > > something that uses both C and header files in a document was
> > > > Documentation/admin-guide/pstore-blk.rst and both fs/pstore/blk.c a=
nd
> > > > include/linux/pstore_blk.h are kernel-doc'd in and the header descr=
ibes
> > > > a public function of the C file while the C file describes other
> > > > functions too.
> > >
> > > Yes, pstore docs seems like a nice way to do things, for docs.
> > >
> > > For people working on the code base, I strongly believe that exported
> > > functions and structs are the main way to understand how to use a
> > > subsystem, so their docs should be in the header file.
> >
> > Sure. But there is no project-wide rule. I strongly believe that the API
> > should be documented alongside of the code so that it doesn't drift
> > apart, among other reasons.
>=20
> Again we are reaching the limits of email, I fear, as I am not
> suggesting that we document the API somewhere other than in the code.
> It is just that the API should be in the header file, next to the
> function it relates to. It can't drift apart, since the header-file
> must match the C function, or it won't compile.

It will certainly drift apart because the comment that documents how the
function works is separate from the implementation.

--=20
Tom

--usmsPaXAus9Jlr78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdOUjcACgkQFHw5/5Y0
tywMYgwAlImWyOV5nBLih1VPDJYpTEMjxp3peomER5llkGrMLCvEnscuwYz8t+ox
9twPX+g8WFaf+/5ONN5b5MmnxXRF1OhwhO34rMcjE4uCCHOtrCy6uWodbLUgPNiT
pUtZgP2n+33N2Zesnbfw49dPDeCyGJg2Ntifk5ypt96s7/2B3wCWg5oF4ld0PqXp
r512XdvKp7yEDN9395yjSnWfC1Cb5eZo2va2hUlafOma8s2/Zp25wY74LfB/C2xo
9+HGe80DJRFkUllhq8DCzwrhUK59hoTdT3sEiwSNkGLxhA87olKal/8A4lDdPxzP
xVGFB6yxKid/6Xrru8QEbsWO7uw9M4822cfaWApa8BX+bZdg7BcLE2zL3TOA0xVJ
gZjXAaXBjqix3XBDneqJWMzmlZVjbtA7W3PyU7qD9mqgGnyTt0rMDeOi3yeSLWzE
ncyMmWOckzNO8USyfdZUFL/X8qBE4J9KC4acYrlxkjL9HOOg3R1sgMCwYGFtr3+T
PN1SaBXu
=8uG3
-----END PGP SIGNATURE-----

--usmsPaXAus9Jlr78--
