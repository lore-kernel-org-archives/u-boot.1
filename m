Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC301CE7AB1
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 17:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B09A786A94;
	Mon, 25 Sep 2023 19:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZupuO4M8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD0B86ADA; Mon, 25 Sep 2023 19:55:41 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C04A98074B
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 19:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-59c0442a359so83813707b3.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 10:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695664538; x=1696269338; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AdijjKGl3rhMRuMY/M8E+hRVOTUi3A/RFd6mofUOupo=;
 b=ZupuO4M8HCMdoBP9jNvq5D14xEglseJJ7GpfOO7fr4+Pd5+G0tu74S40lDaXACSAdm
 lg2mdH0kbaBpM9wiEwU/GRbdzrGwG579KM7famjzpBz8Q7Rav/fNuEkAtiGd/z/yZ0VL
 fC0w0ewz6vVjkFGaKniO6Assn/02Y0exXg6gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695664538; x=1696269338;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdijjKGl3rhMRuMY/M8E+hRVOTUi3A/RFd6mofUOupo=;
 b=ln6NqMzllwNl/sMwJt3ipWtkmLBqOscP6V0kIUX5SQisivc0lWu6iosSSUhVUnC96d
 Cq5Ub/zrtEDf1i25ecp2nI2OBQW55lUOLIbq1Jy7C/QR4ezlllG37os+EyYsKsMMOxuG
 mjWfu6lenZlsPsw1KZ/VmpzN/KkwbJHuYwPgMgHUpKI0oWHaLP8KQ94haPoLfaQgV2Es
 eGIaZAkOjrjoMhyTp0SJffoL06g1PdxwJotO+c4DRtjIWvDl5+bXW9vHrgsMaIZC3IZ7
 l16Ya5uSy0FigvPDxX/eYZSIi8XIRcsv8MIgmkPDAjBWK2Zd7wwt7blVoSgYk3vfbU3s
 55yA==
X-Gm-Message-State: AOJu0YyjttGOSXiEEtCGQ+fBxPjwh/YPOdT4s1dxTqSQX8RKkpO4A7q/
 8RNnnwVCjDp5AQ+V7VD7Q9j3nQ==
X-Google-Smtp-Source: AGHT+IHjEKw4guYmyLlYUji4dYZx2vOQP8vlv4FrakrjZCBk+GyqOI0dn1mjRLQ4ZMN7qoc54DmKDA==
X-Received: by 2002:a81:5e05:0:b0:589:8b55:fe09 with SMTP id
 s5-20020a815e05000000b005898b55fe09mr6900166ywb.50.1695664538464; 
 Mon, 25 Sep 2023 10:55:38 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 p199-20020a8198d0000000b0059f5d686479sm1243602ywg.16.2023.09.25.10.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 10:55:37 -0700 (PDT)
Date: Mon, 25 Sep 2023 13:55:36 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/3] common: Remove a few more header files
Message-ID: <20230925175536.GG305624@bill-the-cat>
References: <20230925023958.1913268-1-sjg@chromium.org>
 <20230925140838.GV305624@bill-the-cat>
 <CAPnjgZ2gBRWt6v1i21Mq+bnqScnHYKATCURMtJ6E7DGspOdpnw@mail.gmail.com>
 <20230925151340.GB305624@bill-the-cat>
 <CAPnjgZ3-AAE11afQx12iqCH6gTeGo-XTBL5ZQn-b-CgOwry7=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FJwfZYkBgXsxUujX"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3-AAE11afQx12iqCH6gTeGo-XTBL5ZQn-b-CgOwry7=Q@mail.gmail.com>
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


--FJwfZYkBgXsxUujX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 10:18:55AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 25 Sept 2023 at 09:13, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Sep 25, 2023 at 08:35:44AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 25 Sept 2023 at 08:08, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Sep 24, 2023 at 08:39:49PM -0600, Simon Glass wrote:
> > > >
> > > > > This series removes two more header files from the common.h heade=
r. It
> > > > > also tidies up code style for time.h functions, to simplify simil=
ar
> > > > > maintenance in future.
> > > > >
> > > > >
> > > > > Simon Glass (3):
> > > > >   Fix code style for time functions
> > > > >   common: Drop time.h from common header
> > > > >   common: Drop linux/string.h from common header
> > > > [snip]
> > > > >  1709 files changed, 1854 insertions(+), 34 deletions(-)
> > > >
> > > > This is where I start to get worried we're possibly taking the wrong
> > > > approach to the problem.  Perhaps it would be better to:
> > > > 1. Start finding headers which include <common.h>, remove and fixup=
 the
> > > > breakage directly.
> > > > 2. Move on to removing <common.h> from files, a directory at a time.
> > > >
> > >
> > > The bigger question is whether you want common.h gone or not?
> >
> > Yes, I'd like it gone.
> >
> > > I shared my script with you so you can see what it is doing. But if a
> > > board uses memcmp(), for example, then it needs linux/string.h
> > > included. We can discuss why so many files use string functions, or
> > > whether the script is not perfect, but ultimately that is the
> > > question.
> > >
> > > Just these simple queries give you a sense of the scale:
> > >
> > >  git grep -l strcat |wc
> > >      45      45    1134
> > > git grep -l memcpy |wc
> > >     834     834   21643
> > >
> > > If you are suggesting that we add fewer includes for now, relying on
> > > transitive includes in header files, then I don't think that is very
> > > useful in the end. I had a series a few years back which removed
> > > common.h entirely and it foundered on this same issue.
> >
> > The problem I see with the approach you're taking now is that it's quite
> > hard to provide meaningful review.  Looking at the time.h patch here, I
> > assume you agree it would be better to just remove
> > arch/arm/include/asm/arch-tegra/timer.h as it's just a single prototype
> > already found in include/time.h.  And the example where time.h was
> > included inside a comment block is a tooling issue.  But then looking at
> > the printk.h patch I did just apply, I had to drop a few files because
> > they introduced seemingly random changes to the resulting build on some
> > platforms.
>=20
> That is very strange. But I think with the Kconfig thing we
> established that the build size can vary slightly for all sorts of
> reasons, nothing to do with actual functional changes, particularly
> with LTO. So as things standard, a build-size change isn't a good
> signal.

I think, LTO platforms aside, it's extremely important and correct.  If
you aren't intending a functional change, there shouldn't be a
functional change.  We need to be able to explain why a change is
happening if we're "just" changing headers.

> >  And something like that is much easier to deal with and
> > explain _why_ it's happening if we're removing the header file by file,
> > rather than world-wide move-a-header.
>=20
> With the Kconfig series I was unable to explain the minor 4-8 byte
> changes, despite quite a bit of effort, as you know.
>=20
> My suggestion is that we press ahead with the migration. If some
> maintainers want to do clean-up afterwards, then that would be great.

I'd rather go with what I said about removing common.h from files and
fixing them up as needed, and make any new code not include <common.h>
since it's long just been "add headers X/Y/Z" and no prototypes itself.
And it's exceedingly hard to review patches like this series has.

--=20
Tom

--FJwfZYkBgXsxUujX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmURyZQACgkQFHw5/5Y0
tywBGAwAieCUsP6faLIfRfcTPD8V6OnhzTsGO5O9th/JGik5Xn5TSyR/1oe3hQz7
V6U+yhPmTBnaRrAiz0qs0UofcrOh1S9NnwFhnwePPemzUaUv679Dzk+axe24KC+V
M0OfVK5TjWaGMokQS0cSFSIoaYeyxqmn1e5o3b4N+peTFV2XkfXp5YtYa5KDbp8E
EgPr+MtfKZ02jECLZbS6VjP9/g3OYwjj/uQFJgQAEARUeDs2A25XRKOHpLM39Yib
C1s/OVGlgHxhl4/epvcV6Hxrh6CZzP+7T2X2Xwpt3pF+/Yd/FD1ZIhJLjvEDveHh
9uVIPGI3L8N9tVKx8oJeJDxVVZpicxm8M8FwCGKx+THiGoz33TOKWI/JOmbg3Rpk
5I7gzoDI1tnHKm0H2+qxkIM4GFBgsWy/dxBo3DFVpGLgVvyUmX9nALBtlUqaPWrn
5PQxO5kSMAURXKYybq7ZLNAmhJbtTd2pTdrgXOZ1h6pag/rMJKDdwt4Zr5jW6kgq
nFMiMvvT
=Hz4y
-----END PGP SIGNATURE-----

--FJwfZYkBgXsxUujX--
