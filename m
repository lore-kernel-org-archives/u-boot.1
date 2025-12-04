Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9288D2444A
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 17:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 433B484132;
	Thu,  4 Dec 2025 18:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iY9e4b33";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30CB984132; Thu,  4 Dec 2025 18:41:20 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA0578410C
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 18:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c7bfba3996so821805a34.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 09:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764870076; x=1765474876; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K7vEsFENon76SdaTKP1doZS1Wfpady4nh11L8I01Lz8=;
 b=iY9e4b330y+cHjuOsjmpxO4iBcvjLVKZzWxYiSbg8Id041h0z9XTP2iT3xWPSNn1kt
 3ZmL0gPeUeU77bXesVRbF/51jCSDXZHboedeltarGcC32QNHrRjpUwYLEjIcAIukrEbg
 /OZ5BglYwJTMXWYO8aDFDjq/n8TE/9XKa9lk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764870076; x=1765474876;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K7vEsFENon76SdaTKP1doZS1Wfpady4nh11L8I01Lz8=;
 b=k73tMxZIHi/u1ayrdq71AsQDID2VnwokaHdVDSJTTNq/J3V8MV1KoQVvsFSGbHjM/+
 aBRG0rH8B7olUM33kwG1NmjvbXjFpVqPyxFjCmCt9J0uw724GddaJXhufwmkJXXehDEQ
 Tw2jlbpS7uh1Iz7W3Fu5wmobhnCFaOTFDo+SDcSUQ3gEwcvwgcAajnr91AvgYfgg1c9h
 8Jgou8VRAEyi1YADWljvyCbOsGukRQyYbrCGkWmI0Ohr3MDlIvZT5Dzdz+t4mN8G21y8
 j4DKbODfIozhhMFK4ga1ZlVbjSqCNqscV1Mz0mCCCScRYxp7qNSrS+EkpylAbUjSURfq
 4Wqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEoxgohWRRdr8/JsE/9qeItcF7D8Ypi/C8qTDUT3H3gYlvPDlrbZPW3V5x4uS6oh0ksjR+ozo=@lists.denx.de
X-Gm-Message-State: AOJu0YyWLYB3ZhI8oY8ncvfDxNKgplN9dp3d2U1elDEo0+/QWfRczkT0
 Z6D9Zz6IqK99tmJFDb8i9VUZ8bg8WraTB7uaGrD6FqX4jsCCKSaotcA/D+cya2duEjk=
X-Gm-Gg: ASbGnctnshxUham1CySitRlq2b1jLnzGvKqP21IzDAFrVp9MntbamjsX9A20QEEriww
 onZZPprtrJq7ID2ViRohC9Ij37/OiXvem/Cu23LjSNEdI0AGrSG4/tCQdH7rXKgn7bGaDtCapaU
 sjuEYNMzWdCSb9wQKU2/Iyu9LqWFbgVAwGJgSzzywHhU++sTy88Mz54KgH9DyMPUHgQuRN2WgGn
 5bV9g428CTXqOO88hdomfpIbMHlZznA3CLI8KoNfG5ew+twvOFxwuoFQUkg9Aa6/x1P9b2jZ4yQ
 HAUw/G5dcweCsBXmsPF3U7ApsUL92p0ql4jlLqE5/SxFgLdm8lvTa2mJIErKXfFh4Pjp38DEExJ
 OpOCZEE21/dQOWZlu7i0dvqeVw7fS8k2cpiejwjkmnZMf6tLj3y3YgaAsvnruVQvM15rH8bDp2q
 Xtq0fb8CbY7SfDdhV/CB4zzjEPnTgVhUPeqGT5q/k5wtshQMph5SHR6KbxuHe5
X-Google-Smtp-Source: AGHT+IHSZtxacssBWYcLrbEuk+R6RPHY/3oP1KzLOanMM2ComdE30hUnwNSO/Y0yW1JhKF2/6tJhqg==
X-Received: by 2002:a05:6830:264a:b0:7c7:827f:872b with SMTP id
 46e09a7af769-7c958cabca9mr2578043a34.37.1764870076369; 
 Thu, 04 Dec 2025 09:41:16 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a93f050sm1930794a34.12.2025.12.04.09.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 09:41:15 -0800 (PST)
Date: Thu, 4 Dec 2025 11:41:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH] pinctrl: single: Add missing free in
 single_allocate_function
Message-ID: <20251204174113.GA303283@bill-the-cat>
References: <BESP194MB2805A2491EFE4D94C777F9C5DAD8A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <97a3117c-7bab-47d1-a5ed-1a33e7c2441a@cherry.de>
 <20251203161142.GQ303283@bill-the-cat>
 <e25260e7-70ce-41c0-aa89-a8fb5a406b57@cherry.de>
 <20251203162826.GR303283@bill-the-cat>
 <20251204171536.GZ303283@bill-the-cat>
 <36b9d7da-13e7-4620-948f-1b3b3b61a250@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6imgIEGVf7HXW6rg"
Content-Disposition: inline
In-Reply-To: <36b9d7da-13e7-4620-948f-1b3b3b61a250@cherry.de>
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


--6imgIEGVf7HXW6rg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2025 at 06:28:34PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 12/4/25 6:15 PM, Tom Rini wrote:
> > On Wed, Dec 03, 2025 at 10:28:26AM -0600, Tom Rini wrote:
> > > On Wed, Dec 03, 2025 at 05:23:47PM +0100, Quentin Schulz wrote:
> > > > Hi Tom,
> > > >=20
> > > > On 12/3/25 5:11 PM, Tom Rini wrote:
> > > > > On Wed, Dec 03, 2025 at 04:36:49PM +0100, Quentin Schulz wrote:
> > > > > > Hi Fran=E7ois,
> > > > > >=20
> > > > > > On 12/2/25 7:39 PM, Francois Berder wrote:
> > > > > > > If func->pins could not be allocated, one must also free
> > > > > > > func variable that was allocated previously.
> > > > > > >=20
> > > > > >=20
> > > > > > Well.... devm_* functions should take care of this when the dev=
ice is
> > > > > > removed (or probe failed), but if and only if CONFIG_DEVRES is =
enabled.
> > > > > > However, in that case, this code may be executed outside of a p=
robe scenario
> > > > > > I guess (it is called in set_state() callback from the pinctrl =
device). This
> > > > > > thus makes sense to me here.
> > > > > >=20
> > > > > > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > > > >=20
> > > > > > I'm also wondering if we shouldn't check the return value of
> > > > > > single_configure_pins/bits in set_state instead of always retur=
ning 0?
> > > > > >=20
> > > > > > We probably need to devm_kfree a bunch of other devm_ allocatio=
ns as well?
> > > > > >=20
> > > > > > I see a loop in single_add_gpio_func() we should probably unwin=
d if there's
> > > > > > a devm_kzalloc which fails?
> > > > > >=20
> > > > > > Maybe we need a .remove callback where we devm_kfree all of fun=
ctions and
> > > > > > gpiofuncs lists from single_priv, in case DEVRES isn't actually=
 set?
> > > > >=20
> > > > > I've wondered, but not fired off a build to check, what the growt=
h is
> > > > > going to be on default y for DEVRES. There's only a few platforms=
 /
> > > > > chips doing it today and I think most drivers are written like the
> > > > > kernel where freeing is automatic, so there's lots of cases like =
this
> > > >=20
> > > > I see devm I assume it's automatically freed (or whatever counterpa=
rt of the
> > > > devm function is) if the device is removed or fails to probe but th=
at's
> > > > rarely the actual case.
> > > >=20
> > > > The issue here is that DEVRES is not enough, we would need SPL_DEVR=
ES,
> > > > TPL_DEVRES, VPL_DEVRES, WHATEVER_DEVRES (added and) enabled as well=
 as we do
> > > > compile devres only if $(CONFIG_$(PHASE_)DEVRES) and then surround =
code with
> > > > CONFIG_IS_ENABLED(DEVRES).
> > >=20
> > > Yes, we'd also need to see about being concerned with xPL or not, more
> > > widely, with respect to DEVRES.
> >=20
> > Checking this out now, and we've already handled the xPL case by
> > deciding that we just don't support DEVRES there (and there's likely not
> > space to do the work nor reason to, given the lifespan of the runtime).
> >=20
>=20
> I assume there's no way to have an issue reusing (if at all possible) the
> malloc pool from xPL in a later stage?

Correct. Anything from previous stage passed to next stage must be done
via that mechanism.

> > > > > one here.
> > > > >=20
> > > >=20
> > > > I think this one is an exception as the device may still exist if t=
he error
> > > > path is taken, so I think it makes sense to explicitly free it here,
> > > > regardless of DEVRES compilation state.
> > >=20
> > > And then it would only be the case of having to worry about some
> > > failure paths rather than how it's leaked today, if I follow things
> > > right.
> >=20
> > Here's where it gets more interesting. For the cases where we could be,
> > but aren't, enabling DEVRES it's around 500 bytes growth, with the
> > reward that we get proper and expected memory management. The challenge
> > is that we have some platforms where there's nothing making use of
> > devm_kmalloc and friends and so we need to go around and manually select
> > DEVRES on functionality that makes use of it.
>=20
> Don't define devm_* functions for proper + !DEVRES so that it fails to
> build?

Yes, something clever can be worked out so that a platform that enables
say DM_RESET (select DEVRES in my WIP tree) and SPL_DM_RESET (no
SPL_DEVRES) builds fine, and say T2080RDB (no devm_* allocs) builds fine
and then still catch that ah, rkmtd also should select DEVRES.

That said, the first practical problem is that
drivers/clk/clk-uclass.c::clk_get_bulk calls devm_kcalloc() and so CLK
should select DEVRES and so that's going to catch a lot of other
existing callers. So that fix gets held off in the series I'd do until I
can catch all the others.

--=20
Tom

--6imgIEGVf7HXW6rg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTHHrwAKCRAr4qD1Cr/k
ChqcAQDkBjO7ggwEq0vSm41+ZMVy3jdCVihNDGSP3cT8SoTTlgD/TLPsc3i9b8jy
KGzNFM37TrgaeCUyBOwyWpZjUjTekQs=
=anXh
-----END PGP SIGNATURE-----

--6imgIEGVf7HXW6rg--
