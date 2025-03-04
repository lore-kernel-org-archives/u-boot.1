Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743F2C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 14:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2573801CF;
	Tue,  4 Mar 2025 15:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uu/9zYJR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A39C805C3; Tue,  4 Mar 2025 15:20:52 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B15048006D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 15:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e4930eca0d4so4061466276.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 06:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741098048; x=1741702848; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sRTD7mnUKOvrCFOEHKNTPu7B7iySOaIcohaKSSuhzkA=;
 b=uu/9zYJR2ztBdESJrAWZwdF4gKIVcL6lqzgUQJgLViGr0cS58ww7eKe/cq4gX2lehl
 zFHz0RoNd98S5/EBeSAF+rLxndLqcNsRIoj0M9kdJSSHS2NWspZ7N/n+MScoSWMnEwgA
 hrMaJbp7M7eH+0ljgoXDwR/22GXKqnndqu2I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741098048; x=1741702848;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sRTD7mnUKOvrCFOEHKNTPu7B7iySOaIcohaKSSuhzkA=;
 b=ow+5+2Cl6V2Ukmcktl5wTTiI9jeeJ7QcQhSIm+su9cBg1fR4BMN/NahcxUxxzsXDY6
 F5DvkZQpsu59yH9K+XVRy+odeWHH5ODpROrGYEDslGY7p2N6NuAMN9TCsyiAzkbw4Xwk
 bTWmIjeWDcqSs2iRU3odkg68aSo38SVB0bkk/+B4pVwvR3dlyjIlxXeobcs0UIoRKXzh
 wgA1L4tZc7efHEEFYz+MMKNFAxS5yh+nQssWSqOvfIF06V42C4AkQEmGDC/nnGN5N1XA
 ZEXIm2CXk3A6LvnF3vX8mewRETR4+6IsHXlnF5NYXJdtkaGlRR1qI7b2dfg9n9u/LTIm
 NgrA==
X-Gm-Message-State: AOJu0Yxy10WFzI7mq5DwJWrdxzrVkBqDS15xDFqoTc78EbVzwjsLNf24
 7g93Rh7uk5rE5ldksQV9aaUJoDv2UsF86tK9uiCFGocyOwrioITQTrdnGDdxHn0=
X-Gm-Gg: ASbGnctnOe6LsJm/f1BRsMs0Wm0xnD4S/8S8BjDGFZdyMnRRag29PUYYUlZ1gFVQnUN
 428JChl9OgjP0Oeax6U86jOa3jFruhmcZrNrw9/OE3ufrGiehnSLTThzh30x51evP2xlak9lH+w
 ED8qaIGE7DaTVBpym7OxBnLmedgbwobkbOXNhBChCp7/mDhYrgSpWj1YvidUQJxKfc863UWseOq
 0bAgrYSW7KzolxCS2FIAwFpmE4V2ObgjgNyjrwAxdC63gkoJuFYWUvSjwf41UwOoytTPLlxQ0Gt
 s3lkhKQMGo24whL1L+npET34CSd8b8TMCVxQoVm/r0E=
X-Google-Smtp-Source: AGHT+IG0uteAmn9PUjS5hj904GbnPadJbkIYpcS1c6SksVixLcyg0IIDMOzSaut1SjCcAF/AKYGK9w==
X-Received: by 2002:a05:6902:188a:b0:e3a:228f:b6ae with SMTP id
 3f1490d57ef6-e60b2ed3644mr18521554276.28.1741098048446; 
 Tue, 04 Mar 2025 06:20:48 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e60a3a334ffsm3642215276.17.2025.03.04.06.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 06:20:47 -0800 (PST)
Date: Tue, 4 Mar 2025 08:20:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: Re: [PATCH 0/7] binman: Check code-coverage requirements
Message-ID: <20250304142044.GV2640854@bill-the-cat>
References: <20250225200635.3781149-1-sjg@chromium.org>
 <20250225210645.GA2640854@bill-the-cat>
 <CAFLszTig7O=Eyx+C0xAsxkJi+rP_ghXgXBxUwN47GZLxg-KFwA@mail.gmail.com>
 <20250225213152.GB2640854@bill-the-cat>
 <CAFLszTicCUoW7qqy8qDwQ5a_9HuwwLExQsFdAuYRnXG5-J_NYQ@mail.gmail.com>
 <20250225215306.GD2640854@bill-the-cat>
 <CAFLszTgen=t-SCrwE7nPOjUTGHO7smNZ5CSvxWR=4KhE8DJ=DA@mail.gmail.com>
 <20250227170441.GF2640854@bill-the-cat>
 <CAFLszTisYPa1_pbnHNb9a7F2Nrfk70KH27p60_sQ+UTR3tAA0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zP8UwhcLKvF+eyM7"
Content-Disposition: inline
In-Reply-To: <CAFLszTisYPa1_pbnHNb9a7F2Nrfk70KH27p60_sQ+UTR3tAA0A@mail.gmail.com>
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


--zP8UwhcLKvF+eyM7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 06:10:27AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 27 Feb 2025 at 10:04, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 27, 2025 at 09:25:25AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 25 Feb 2025 at 14:53, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Feb 25, 2025 at 02:44:12PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 25 Feb 2025 at 14:31, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 25, 2025 at 02:26:39PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 25 Feb 2025 at 14:06, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Tue, Feb 25, 2025 at 01:06:25PM -0700, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > This series adds a cover-coverage check to CI for Binman.=
 The iMX8 tests
> > > > > > > > > are still not completed, so a work-around is included for=
 those.
> > > > > > > > >
> > > > > > > > > A few fixes are included for some other problems.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Jiaxun Yang (1):
> > > > > > > > >   binman: Workaround lz4 cli padding in test cases
> > > > > > > > >
> > > > > > > > > Simon Glass (6):
> > > > > > > > >   binman: Exclude dist-packages and site-packages
> > > > > > > > >   binman: Drop GetRootSkipAtStart()
> > > > > > > > >   binman: fit: Drop unused code
> > > > > > > > >   binman: Drop algo check in CheckSetHashValue()
> > > > > > > > >   binman: Workaround missing test coverage
> > > > > > > > >   CI: Run code-coverage test for Binman
> > > > > > > >
> > > > > > > > While we likely need Jiaxun's fix in order to be able to up=
date to
> > > > > > > > Ubuntu 24.04, the series itself doesn't apply to -next, ple=
ase rebase if
> > > > > > > > you intend for this to be in mainline, thanks.
> > > > > > >
> > > > > > > OK, would you able to pick this series up?
> > > > > > >
> > > > > > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D444=
576
> > > > > >
> > > > > > It also doesn't apply. You should really put together a PR, aga=
inst
> > > > > > next.
> > > > >
> > > > > Oh, it needs another patch anyway. I'll send a v2. Once that is i=
n I
> > > > > can rework this one.
> > > >
> > > > Again, it would be helpful if you would send a PR and always base y=
our
> > > > patches on the appropriate upstream branch.
> > >
> > > I understand that, and I'm happy to rebase / resend when you are ready
> > > to apply. I'd like to keep the diff as small as we can. But I don't
> > > think it should hold up reviews, otherwise we're just going to diverge
> > > further. When you reject patches for your tree I typically apply them
> > > to my tree in the hope that they might find favour in future.
> >
> > I think you've got this backwards still.
> >
> > > For the skip-at-start series I sent a series, which you have seen.
> >
> > Yes, and what blocked them to start with is they defaulted to your tree
> > and not mainline.
>=20
> I can send a pull request for things, but your tree is missing things
> and that seems to be growing over time.

By definition your downstream fork is missing things. That's on you to
fix, not me.

> As you have seen, I sent [1] to test the water so we'll see how it fares.

That's not a very kind way to put it, given that I've only stopped
applying your various series once they don't apply to upstream. And
since that's actually fixing platforms and not just tidying up code I'll
likely apply that later today.

> > > Speaking of patches, the PXE series seems to have got lost. It is
> > > 'changes requested' but I'm not sure what changes are needed.
> >
> > The changes requested was that it breaks lwIP + tftp. You asked that I
> > ignore that since it wasn't failing in public CI, I said it was failing
> > in my CI. I then noticed that it should have failed in public CI (and
> > likely was on Azure, but that's often overloaded enough I cancel runs
> > when I see failures elsewhere). So I then fixed public CI so that the
> > lwIP platforms there too should fail.
>=20
> Well I did offer to add a test in my lab...I'll take another look at some=
 point.

Well, it's blocked until it doesn't break platforms.

> > > I also just found the membuf thing was never applied.
> >
> > Was that the one where Rasmus asked you to do it differently?
>=20
> Yes and I spent quite a bit of time investigating, and replied, but
> didn't see any further response. The power-of-two idea is too
> restrictive and anyway is beyond the scope of my series which is
> mostly to add some tests and align the naming better with U-Boot. I
> did suggest some follow-on ideas. Anyway, I am wanting to use it in
> future series, so it would be good to apply it.

No, I'm not going to apply something where the feedback starts with "No,
that is the worst of all worlds".

--=20
Tom

--zP8UwhcLKvF+eyM7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfHDDgACgkQFHw5/5Y0
tyxdFwv5AXgLAFdik3SsVMuT1lVZCP99qBWnf7a5WUUVK/PHlEiYoPHqVjkia+p1
yIjQTbBqjcnIiOwbi62XkxtKoJuJeHqMNfzKtKLDTwFAmzbZhV5a/CfL5lX0Pxm+
X0NvviLepPJ/KUovppUKgx21oE9s6ozGkSuMwqwOH1G45RnuCC+nZshgaP5VDfZi
DvOuK5qaHLujt0bIkG/xfLfjDI/ogkvR22rS/ZqQUj1H4uAauLAJqckMZDMyDpYD
XJYz//1yVKiBZwm/FfHRWZ//Qhi7aZvBfth3rF6Pzdj3/OMheCRuSmt3NAKti3Vw
XkzNgYinrTbpuwacycM9Jat5PoieXJTLCL941KPiOeYJWhi/TZnZCmWYQzbqDvsh
5V1dWIQ0bYDx3naCo+Qd6zOI+5rwyhHbrqAxzHx5QI98VNeGNfbcCMOn7PlgkT0/
74mRLUrVWMfDjtrlvfPhjGtjAV0nx9hwxB6WZXfugjewcCwKdUTY+JwEBU7CEyKo
bLBviF/l
=6Tca
-----END PGP SIGNATURE-----

--zP8UwhcLKvF+eyM7--
