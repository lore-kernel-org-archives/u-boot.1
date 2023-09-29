Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA70E728C4
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 16:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64C4486EC1;
	Fri, 29 Sep 2023 18:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YcqPnfFr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5E2586EE1; Fri, 29 Sep 2023 18:02:36 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CEFD86E8D
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 18:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d8198ca891fso15897355276.1
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696003353; x=1696608153; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Zd/zJnyaE5BfER+Xs0SfYOvbMRiIJYnLPVblvj5jauk=;
 b=YcqPnfFrR838uNZwQiIrrOs1ozWIGZAKY8BE1zbsl8pstzVE504LhG7ecEHGOJFBzp
 eEftZpE1zu0QQ0RHqJ/dz4nnmr/b4SUGN86+77g2Mri/Fd++5aCw9UKp1G5Ses3XCy8x
 ByetXQpA0Ji0D1o+9gbZ7jYzhdcCy3xjkLdes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696003353; x=1696608153;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zd/zJnyaE5BfER+Xs0SfYOvbMRiIJYnLPVblvj5jauk=;
 b=L9WaCc7KxJNvdIiBnX1XR3j61oGWYj05IHtFQ2Sssy1zLztL8WFiUHzFHBAYib9u/s
 RT+zAsv7F59gIXBc/TWLG3vq7fkV+rdV4wsE93vN1BcgqB3B9qlE65s/hbzqJhQZkkUV
 SEcPu306k0P51F7Mzc5kDz2+YWkBKV2AqbcgQGkemCuPvNZLNcBR5WNmC64ytzcdi3bu
 O7z8QeCknqpYyW8jA5b9SLddnOlcrYeCHdh4dTzOl6I5LeBD0fng1zaGOE7W+LxHhgql
 7yXiVCnh8xk+OoDRFk9tGn05a/J3N3xRH51zRvly34obCZiq3EQj5UVPFOS6/9hFglVz
 /Zzw==
X-Gm-Message-State: AOJu0YwrtmgUoL+YeyE5zjJ92Mgki3/lMer2qlcJmlLTAThnfXA9jfMk
 rNsSiyUr0lhkk5n/HqDj2AW5bg==
X-Google-Smtp-Source: AGHT+IG+ZuqimujPOenKgpfyQl5KLDzadq1BaRsjboZYNfDk9LzFFb2hNUJ6ud8sZcRL3YwdS+NXtw==
X-Received: by 2002:a25:ab21:0:b0:d29:3f14:9d96 with SMTP id
 u30-20020a25ab21000000b00d293f149d96mr5067481ybi.56.1696003352847; 
 Fri, 29 Sep 2023 09:02:32 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a39b-08c7-b2a8-b94f.res6.spectrum.com.
 [2603:6081:7b00:6400:a39b:8c7:b2a8:b94f])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a259f0d000000b00d748501d9b4sm4922913ybq.21.2023.09.29.09.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 09:02:32 -0700 (PDT)
Date: Fri, 29 Sep 2023 12:02:30 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Subject: Re: [PATCH] scripts/Makefile.lib: also consider
 $(CONFIG_SYS_BOARD)-u-boot.dtsi
Message-ID: <20230929160230.GP305624@bill-the-cat>
References: <20230427162100.GE1134230@bill-the-cat>
 <20230427173113.GG1134230@bill-the-cat>
 <40c79f7b-205d-0b48-7ee2-e052eaa1317f@prevas.dk>
 <20230503135158.GY1134230@bill-the-cat>
 <20230503145438.GB1134230@bill-the-cat>
 <0f2df366-65ca-664f-1f90-0c2aeafce8f1@prevas.dk>
 <68f445de-c903-c3a1-906f-2cf7b5675d08@prevas.dk>
 <20230925181940.GH305624@bill-the-cat>
 <08e35aab-309c-a8e1-931e-7ab142beb593@prevas.dk>
 <CAPnjgZ3jO5s3HZRjXdG-dVLNmGYnyCWnpvzRKpKhBCRQqWH33Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MxuxS9Nwfu0bd6uq"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3jO5s3HZRjXdG-dVLNmGYnyCWnpvzRKpKhBCRQqWH33Q@mail.gmail.com>
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


--MxuxS9Nwfu0bd6uq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 09:15:00AM -0600, Simon Glass wrote:
> Hi Rasmus,
>=20
> On Mon, 25 Sept 2023 at 13:05, Rasmus Villemoes
> <rasmus.villemoes@prevas.dk> wrote:
> >
> > On 25/09/2023 20.19, Tom Rini wrote:
> > > On Mon, Sep 25, 2023 at 10:27:43AM +0200, Rasmus Villemoes wrote:
> > >> On 04/05/2023 14.35, Rasmus Villemoes wrote:
> > >>> On 03/05/2023 16.54, Tom Rini wrote:
> > >>
> > >>>> The one last problem now is on stm32mp15_dhcor_basic which is a
> > >>>> defconfig missing one from OF_LIST but including it in the its fil=
e, so
> > >>>> the above is the patch we need.
> > >>>>
> > >>
> > >> Hi Tom
> > >>
> > >> Can I persuade you to try something like
> > >> https://source.denx.de/u-boot/u-boot/-/commit/a05e0d0e6b9103542a1076=
f9cab0005f400fa072
> > >> again, but leaving the .dtbo targets in there?
> > >>
> > >> I could send a patch, but it's entirely mechanical, and not really m=
eant
> > >> for being applied until we know if there's more to be cleaned up.
> > >
> > > So what ended up being the problem I think is the case Simon pointed =
out
> > > where we do take the output from "make all" and concatenate one of the
> > > dtbs that was generated with u-boot.img or so, and it works.  But may=
be
> > > that should just list all of the valid DTBs that it needs in the
> > > defconfig to start with? I don't quite know, it was a case I hadn't
> > > considered at the time.
> > >
> >
> > Re-reading the thread, I can't see where that was mentioned.
> >
> > But yes, if some boards (still) need that, and have more than one
> > possible .dtb, the board can't set an OF_LIST different from the default
> > consisting of DEFAULT_DEVICE_TREE because changing OF_LIST requires
> > SPL_LOAD_FIT || MULTI_DTB_FIT.
> >
> > How do we figure out if such boards even exist?
>=20
> Honestly at this point I've forgotten what this is all about.
>=20
> Perhaps the easiest approach is to create a new Kconfig to control
> whether a board-level .dtsi is included in the list of wildcard
> searches. Then you can enable it for your board without affecting
> others.

That's getting things backwards, from what this cleanup does.  Today we
have messy lists of "build these device trees" and then don't use most
of them, and some of the list is just Wrong (listing dts files as an
output).  With the series to handle dtbo files, we could remove
virtually all of that, and the only use cases that don't Just Work still
are the ones I forget which board you mentioned (I think it was Samsung
tho?) where the defconfig doesn't list all of the device trees, just one
of them, and the other 5 that we build can also be easily used.  Does
that ring a bell?

--=20
Tom

--MxuxS9Nwfu0bd6uq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUW9Q0ACgkQFHw5/5Y0
tyyqiQv/eUf3vgg3tfOZopyS/XbTcmB1OPzYJZYcgHufgsK1m6QL4UuyvWT/qJ7P
J6QbcWdfbcNDmDChD/1pDdJyiQhcjwWjnzRfdTTgJ9Tmn5SiSvlZmZuVu3QBjM7Y
8XWOMXXnq0a8gEkAPGXsr3D0WHGQq9cJKG4DPbc1iyfJoOoFGcBfe5chKe29+JUu
P1f28Hphf4aSbcQHY1yTQzDGYHIiherNpYEakrTG+vN+uzdAAhAEqhqpoIDlPzqL
z9snj3e9Lf52n17ARXfEZrmsbq6/TnCJfS6mNPL4lWMdrNCx247yileNDU7011TU
Y1xTsAB1mTSRnOTPWS5LdIxVP4IBTRbHXMSHmezMGlpgqgmT1cNa5khnlzJl0E1j
gzCiLlbXGSmAmL5+35mdDzRA9nhun/zUsYnzaGRHuZjgajuYcBbtrwtJafLhShL4
ugSbd11TIwSkZPyHLlNz8dV4q6jbLT2nnVx1dBk8mumMaT1q7r5ec0K+TxtfMhrV
BRrqsG3y
=BBWN
-----END PGP SIGNATURE-----

--MxuxS9Nwfu0bd6uq--
