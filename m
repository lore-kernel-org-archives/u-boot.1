Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C76E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 20:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 487C2801CE;
	Tue, 17 Dec 2024 21:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nntX/tY8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73EB9801FB; Tue, 17 Dec 2024 21:29:08 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9C9380107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 21:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d932b5081eso52461116d6.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 12:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734467344; x=1735072144; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O4GpFh9cWIEjSxF++j17mjrQ+fPC+htOOvAavHXE1i0=;
 b=nntX/tY8c84y/k/fmwPtak5wAOncM4TiGbIOQQ8QwKPPFGNUyASg5H6T1oxQw3qZqG
 o+laGGRavvewAIhFd40QJKuQOWJB2vv5wJNcJL0CIpPiM9D8XWtuj0wdpBo3pT083RBu
 0NY2TKxrMyYV5M2900xJeRITlIvKKcbNw1a38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734467344; x=1735072144;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O4GpFh9cWIEjSxF++j17mjrQ+fPC+htOOvAavHXE1i0=;
 b=s1uwzdEzjnStqeWdRJdhCgAJJ9rGPolav/mRXt9UzajZiV7168roR2d0NllbXIQUtb
 hpqyU9aPYECfLQkaveMYsXziWJbOYeP4rekEDPsOirn6p+sdn+ey2JNr8I0ckVhRqPus
 8+QuRxx7ZXOOLeU0H5fhSJFRVeex7U30jMvXXOV1oywzyplVDDt2Dte6LMmnfBFLw5Mi
 xGvad5z1ZOZUUJ1WJ66oZyiHlzBrZ3o4zPVRG2fKLKdRGfD+XMRv3PLpsyoR+5PyZmHE
 +apS8oRykxQU68qTKFnwvK27roXFGa6CSRtoD0YqSNkBCBhcOfGaCvESD/QjumVqUNZk
 Phlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUqcLTqGVvbIujT/y7L2j/OWa80DZ1qELz6kwxSJN5jSkXzhxAPxlNiWuxhJI2LAP44GLLLc8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1mKSONNWRX0HxtV+7t5jz+V70PUcC2vLDCJ+74x+8dDkuw0qS
 fuZV8apuCrfgutMiaWSMuzfmVmisUsqde0eYgowpR9PSeh2thAuE+Gj3xsKHv3U=
X-Gm-Gg: ASbGncupEvgRHOL4mgGxno5QoeSGAyHMmmuGqQf5sySfEM/TwRhLE3BgJFkGzz1X9r8
 fGTT1vjofID44WJsgyadi4DJglGw441437cwrXt5ZrGWlX0eFaD5/hg/+4t8j2UIzCaOesj0643
 v+ZyxsXh5O2x0y4JJ7aZ6x0jm50j5YxWLsFvRdReO+7YdyTUoEPSBzvcdpqyZ3SnWA3cmp1WTH4
 zKVDNgcAYkx/VuxiAoLHzpwEfnCMxzCtWxXoopFvhqc/T9YKXEwB7BM
X-Google-Smtp-Source: AGHT+IEeNzxM41fAUeaZV4RtyOXVuD6ACsgCY7BvlPY5IIYxZw/70ZU81zKEjCzMv0Nmpkp/UW+EXw==
X-Received: by 2002:a05:6214:e83:b0:6d8:7eb9:9bd7 with SMTP id
 6a1803df08f44-6dd0925e674mr5469406d6.43.1734467344486; 
 Tue, 17 Dec 2024 12:29:04 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd22f0e4sm42521316d6.2.2024.12.17.12.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 12:29:03 -0800 (PST)
Date: Tue, 17 Dec 2024 14:29:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Raymond Mao <raymond.mao@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/3] efi: Correct logic for OF_EMBED and OF_SEPARATE
 co-existing
Message-ID: <20241217202900.GT1505244@bill-the-cat>
References: <20241211004503.3775922-2-sjg@chromium.org>
 <20241211004503.3775922-1-sjg@chromium.org>
 <CAFLszTjHyhwf0dV8THPDswXz58jRCW+ZX90Hr4_i7PjXsVHPBA@mail.gmail.com>
 <20241217142527.GL1505244@bill-the-cat>
 <CAFLszTg93ddp3r2Bmv+p-wKRBDxVYqz2mQ56etGqSWCGUjo6Jw@mail.gmail.com>
 <20241217195734.GR1505244@bill-the-cat>
 <CAFLszTidPRWQCeQ+fsyn_P420eK6obqtYu7=pHtxDHhxumVoLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iksgrFSe45Hsyvly"
Content-Disposition: inline
In-Reply-To: <CAFLszTidPRWQCeQ+fsyn_P420eK6obqtYu7=pHtxDHhxumVoLg@mail.gmail.com>
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


--iksgrFSe45Hsyvly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 01:17:42PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 17 Dec 2024 at 12:57, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Dec 17, 2024 at 12:46:17PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 17 Dec 2024 at 07:25, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Dec 17, 2024 at 08:00:56AM -0600, Simon Glass wrote:
> > > >
> > > > > While we do plan to switch to OF_SEPARATE now it is supported, it=
 seems
> > > > > worth at least showing how OF_EMBED could be used instead, just f=
or the
> > > > > record.
> > > > >
> > > > > So make the Makefile rule conditional on OF_SEPARATE and adjust f=
dtdec
> > > > > to avoid a build error when OF_EMBED is used.
> > > > >
> > > > > Finally. the dtb symbol has a double underscore, so update it to =
avoid a
> > > > > build warning.
> > > > >
> > > > > With future patches, OF_EMBED will no-longer be used with the EFI=
 app,
> > > > > so it is expected that it will eventually stop working.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > Fixes: 2e7bf25f6bf ("Support separate DTB files with the UEFI app=
")
> > > > > ---
> > > > >
> > > > >  Makefile                       | 2 +-
> > > > >  include/asm-generic/sections.h | 2 +-
> > > > >  lib/fdtdec.c                   | 2 +-
> > > > >  3 files changed, 3 insertions(+), 3 deletions(-)
> > > > >
> > > > > Applied to sjg/master, thanks!
> > > >
> > > > Since you've picked up several series that no one was objecting to =
and
> > > > providing reasonable feedback on and applied them to your own tree,=
 do
> > > > you plan to squash/rebase them and repost so they can be applied to
> > > > master / next at some point?
> > >
> > > The original EFI-app series actually had objections in toto. Did you
> > > not see the comments from Heinrich?
> >
> > I assume you mean:
> > https://patchwork.ozlabs.org/project/uboot/patch/20241123195616.305687-=
2-mjg59@srcf.ucam.org/#3419029
> > which is a question.
>=20
> Apart from the general tone, it was mostly the cover letter.

Which is
https://patchwork.ozlabs.org/project/uboot/cover/20241123195616.305687-1-mj=
g59@srcf.ucam.org/#3418939
and an open question to explain the use case more.

> > > I've offered to send pull requests every now and then, to keep things
> > > in sync, if that is your goal? But I don't believe I can do that for
> > > particular patches/series. It is going to be hard enough for me to
> > > just maintain my own tree, let along dealing with your/Linaro tree.
> >
> > I find you calling the mainline project tree "your/Linaro tree"
> > offensive. And I'm again asking you to explain in public what you are
> > doing exactly.
>=20
> I'm sorry you are offended. Please suggest a better name that I can
> use. Honestly, from my point of view, it feels like a
> Linaro-controlled tree. There's nothing particularly wrong with that,
> but I would like the freedom to continue to innovate U-Boot, without
> Linaro telling me what to do. Does that sound OK to you?

It's mainline. The tree at https://source.denx.de/u-boot/u-boot is the
mainline tree for the Das U-Boot project, and I am the maintainer of
that tree and the nominal head of the U-Boot project. If you want to
ignore the feedback you have been given by other people to do whatever
you like, please don't call it U-Boot. It is not "Linaro" disagreeing
with your ideas, it's a number of people. It's most frequently myself
(neither I nor my company get any money from Linaro, nor Arm Ltd),
Heinrich (employed at Canonical, like you) or Ilias (yes, Linaro).

While I am open to, and am exploring how to formally change the project
=66rom the old fashioned "Benevolent Dictator For Life" model to something
that reflects modern project management, Wolfgang passed the project hat
down to me a long time ago. If you don't like my leadership, moving past
the BDFL model and to something else will give you a chance to take the
reigns, so to speak.

--=20
Tom

--iksgrFSe45Hsyvly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdh3wgACgkQFHw5/5Y0
tyzj3gv+Oxm+wP+HWDX4FdGqhUQ9hZvi0lq8htL137gG8y4AHbqtqOU0RtdeCXm4
U/hS1lWCifgQI5wimusL/sCCsbaa/CFIsjfDVjNXXkmE41U6CgPdOG8lz4mJdmGD
BwPnvZsvehxkMwH/YP5czCHzLvQwjNVRWbLOsxpWVu9AOSaSLaiVlZEMKovhCxwR
9EoxTybfcS6c4Jq5vMR4nZjEBB53DpwCq8C0iUO+phGZSXiQ8mLjjPE3GSCtUdLH
3mF+zRiJ9cpGCJ6C9J8LITdw0NjNkiwYXz3meMGdX5SczazdMXAgfohzTxpFZS0V
Sfjkx3Vi+EKy4sidqIiwB6Z1C3OVsWDMXTvx7cVsYfwXcOSnD4rv4+LsDeW4j9bI
OF2t6ej+Io1eEi1010mQaw/OlxbhciT+RA3xao+3khIzzkTpFZ2G6X7jLxYD9wkt
4hpDs3d8rU0HKI7Sn8QD85U/P6cxOU5MJ1ZvV5qK0ERu9b8kPnYvRKKCoLfW8deA
yE9o3KG2
=aOCB
-----END PGP SIGNATURE-----

--iksgrFSe45Hsyvly--
