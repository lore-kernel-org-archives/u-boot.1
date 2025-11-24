Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B03ECFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 14:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 892D183B85;
	Mon, 24 Nov 2025 15:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OQ8a5QYw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD33A83B85; Mon, 24 Nov 2025 15:42:03 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E69F83ABA
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:42:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6574ace76dbso1776823eaf.3
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 06:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763995320; x=1764600120; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ToFGfgCndwQKMS2NfG45EJY2VnyBA06Q5d/2jRK45TM=;
 b=OQ8a5QYwqbTJeaFmeDhF8xfLcd5CebUKchjK7zEnHH8Ps1MUqqjVmEgy1ytQCkrrFY
 dFjv7WeP2derucUjmU5sQbjCJLRrivTU/w+kTtwC7qzGb1HsXB07c6SvA5jrRAvYz/b+
 WCuA4CiUoWlk9U44oWHdvuWeXh1Sm4NwwoCQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763995320; x=1764600120;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ToFGfgCndwQKMS2NfG45EJY2VnyBA06Q5d/2jRK45TM=;
 b=YAvOmOvW6qJkN/KMle/rDGaOH22muLtqMQLY8sEAsZHeXRt8dM7V0AdzrFSpFb7RkV
 yfC0rdnJTvDLD2C5tRmwW2c5ZZbyKKAj6Z4qfzX/My0XcrAIDEv6+tVrCNR09bd8ss4o
 eo7CSofoctI0CS8sgBHi4TiS1celWNCQ723+Pgeie6ft4naUpfJvY1903AgeGpsQkL9L
 BoZDRbiKGEeX2c7W6sdC2OsGTEMXpSH7IcXndvCyBsxp+5WLCbrhw10VXx+2BJSqzD4f
 0tFm0ljSMChJ9BynqZXeJPTWZPEeRKMZq4B+JMFvtNQsnxfZx0yp64lwXblL2X77hwWn
 z86w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4uszW1ROkFs/TQtn6Nx8AH8ycrtnbTUHvvf04IxToWiSwD+n+wUJ2CPw01hHBFuW6yU56xN8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+kZMrvcI7sTebN2waNO3EhhbwQHIGIdWaqUMvBtpXVqUru/wD
 U6Ln0+3za93Ghbg4qT+XEUjFDaaH+WEuClnuSL3L6QP8e6xS1fjWHE3UyLA7WhrOii8=
X-Gm-Gg: ASbGncsEuvJCI1AlScGoHbawC9+NfYBiD59FFDmosay0pJcqbz+xjDjW6qbgP6xJ8bN
 rrPmaC3xcHfVRtSBcbK2XqmSY5n/uInV0/X37FUsffbx4Im5HkmodtmdTnxFxpz2+IHqjCnhjCP
 i0TB0Pwpd44fxaA4XoPtsb5HC6VrS7QLpDL9euCEbY20HnKWyJ0WMBsekPA5K8fPIZowWA3RjZ4
 quwcmKu3D1xW4pejLvlwV6RCy2auXObIB50kxS7qzpZdaVxBCnm9OJb0G8VQrLX+bo4ogmza7r9
 dh58y50J3PMNaVblkl20llA26EuXKpOgYkeT11TAQiJR289kfr3i+BDN38eZ4qydUtrmMV0FEf4
 teI1U/iOwZVHiKS/Rfr+alkb38rdqC8/KvRkkKF0YnyapMTMb3WQnyTa7GsbiiEpUUrIFDtVjfa
 tCmeTQA8lE7xlI12c2UcDQkya7de8k1vq40GWneBENHXZyYilpBQ==
X-Google-Smtp-Source: AGHT+IHFrPDXgecya990wYCf6fUBZ2D/jY36B2788CItsEtURIIYlDbpeMDw+UzSijiGJjdwOdLqfQ==
X-Received: by 2002:a05:6808:6d83:b0:450:ae23:54f8 with SMTP id
 5614622812f47-451128ef641mr5069002b6e.19.1763995319797; 
 Mon, 24 Nov 2025 06:41:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9dc8e0e1sm6259777fac.18.2025.11.24.06.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 06:41:59 -0800 (PST)
Date: Mon, 24 Nov 2025 08:41:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, Heiko Schocher <hs@nabladev.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] i2c: sandbox: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
Message-ID: <20251124144157.GK2125796@bill-the-cat>
References: <b7063159-f5d0-4f8d-be35-2e7fa5f8f750@mailbox.org>
 <CAFLszTjyXo9yh6Jzdaev9GhN8OZ4Z5xz9phgNHnKCvA0ASzbaA@mail.gmail.com>
 <60b12c96-4e63-4cf1-8c27-25eabead529c@mailbox.org>
 <CAFLszThg+6LdxHXOYy9x8-nat+bsspbUT8Dg_vqnmx62aO0a2g@mail.gmail.com>
 <a8fa7ff0-1324-4213-b45b-b4df637e6bee@mailbox.org>
 <CAFLszTgLjRT_x1+tX0xpBzTy9bDJSYXw=5gOBvvNSqdOZDiZoQ@mail.gmail.com>
 <c75bacd5-532a-4783-9f1f-02884eee7918@mailbox.org>
 <CAFLszThKSE7v6TJhfeP2jGTS=GkpVuDpYHNHh_fMFL9TSjrnqA@mail.gmail.com>
 <20251121192359.GC2125796@bill-the-cat>
 <CAFLszTh2o9uMgGcRPfNU4TDRZEqy8rpe75w3q6352PrN9bX=ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1e2ey3LXjRym4yPT"
Content-Disposition: inline
In-Reply-To: <CAFLszTh2o9uMgGcRPfNU4TDRZEqy8rpe75w3q6352PrN9bX=ZQ@mail.gmail.com>
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


--1e2ey3LXjRym4yPT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 07:31:27AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 21 Nov 2025 at 12:24, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Nov 21, 2025 at 12:09:21PM -0700, Simon Glass wrote:
> > > Hi Marek,
> > >
> > > On Fri, 21 Nov 2025 at 11:01, Marek Vasut <marek.vasut@mailbox.org> w=
rote:
> > > >
> > > > On 11/21/25 6:40 PM, Simon Glass wrote:
> > > >
> > > > Hello Simon,
> > > >
> > > > >>>>> - create a new VALID_OFFSET assumption (split out from VALID_=
DTB)
> > > > >>>>> which checks offsets in fdt_next_tag()
> > > > >>>>>
> > > > >>>>> The latter might be best. It would likely be very cheap in te=
rms of
> > > > >>>>> code size. In fact, I should have thought of this at the time.
> > > > >>>> Wouldn't it be better to not misuse libfdt ?
> > > > >>>
> > > > >>> It actually isn't a misuse. It is perfectly OK to pass an inval=
id
> > > > >>> offset and libfdt has defined behaviour in that case, absent any
> > > > >>> 'assumptions' we force.
> > > > >>
> > > > >> It actually isn't OK to pass in invalid offset if we compile FDT=
 with
> > > > >> disabled tree validity checks.
> > > > >
> > > > > We are saying exactly the same thing, if you read both of the abo=
ve :-)
> > > >
> > > > What I wrote is, that it is NOT OK to pass invalid offset to libfdt=
 IFF
> > > > the DT validity checks are disabled. This is yes a misuse.
> > >
> > > Yes, of course. It IS OK if you enable the validity checks.
> > >
> > > >
> > > > >>> Remember, in Linux these checks are enabled. We added the 'assu=
me'
> > > > >>> thing to reduce code size. Here you have found a situation wher=
e it
> > > > >>> breaks stuff, so we should back off the assumption a bit.
> > > > >> U-Boot also has those checks enabled, SPL does not, and things b=
reak
> > > > >> when OF_PLATDATA is enabled and there is no valid node associate=
d with
> > > > >> the udevice.
> > > > >
> > > > > Right, so add SPL_OF_LIBFDT_ASSUME_MASK for SPL and check the code
> > > > > size. If it is too much, add a new level FDT_ASSUME_EXISTS before
> > > > > FDT_ASSUME_SANE and use that for the necessary checks (there will=
 only
> > > > > be a few, from my reading of the code).
> > > > The SPL assumes the FDT is valid, and disables FDT validation in li=
bfdt,
> > > > to keep the code size low.
> > > >
> > > > U-Boot does enable that validation in libfdt, and grows its size a =
bit
> > > > because of that (and also because the DT might come from outside), =
but
> > > > SPL can not do that (and control DT does not generally come from ou=
tside
> > > > in SPL).
> > > >
> > > > That is why these few fixes actually repair the misuse, instead of
> > > > re-enabling the validation in libfdt.
> > >
> > > Enable basic validation if !OF_REAL ? Create a new level of 'assume'
> > > for just what you need?
> > >
> > > It just seems really odd to disable validation and then try to not
> > > call the functions in case they will crash. The next person who comes
> > > along will have an unexplained crash. It's just too brittle.
> >
> > You seem to have missed the entire context of the problem here. Today,
> > in upstream exactly one platform disables validation in full U-Boot.
> > Exactly zero platforms enable any form of validation in xPL. Upstream
> > dtc has made a large number of changes since v1.4.6. Whatever we have
> > been assuming could be done cannot be done anymore.
>=20
> I took a look at what I landed in upstream dtc, we have
> ASSUME_VALID_DTB, so we should just use that.

Where? Full U-Boot? No, because we're being told to read a random file
and see if it's a device tree, full checks are fine. xPL? No, we don't
have room.

> It has very few checks. If we want one more step that really just
> checks that fdt is not NULL, I could try to do that upstream.
>=20
> As to my missing something, I am aware that we don't enable validation
> in xPL (I still recall writing that code), but also that with
> OF_PLATDATA enabled, we need some sort of basic validation if people
> want to call dev_read_...() functions. My attempt to show that was to
> add assert() statements in some of the ofnode functions. As part of
> changing this, we should really remove those, or perhaps make them
> dependent on the 'assume' value.
>=20
> The key thing is not to solve the problem at the right level, rather
> than adding lots of checks to avoid a mine.

Then it's a good thing we're not adding lots of checks and instead
cleaning up the code and removing ifdefs and solving the problem Marek
ran in to as well.

If there's still some further cleanups that can be done on top of that,
great. But I'm pretty sure the mask/assume stuff is the wrong place to
be looking.

--=20
Tom

--1e2ey3LXjRym4yPT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSRusQAKCRAr4qD1Cr/k
CmH+AQC9pci2HONmjJAl0oXAheTLVY9Pge90VMM3DKpX59hxrgEAm4IUvDLj1zqM
u9l3XZd7UUpSp9+vdAOqbC0/xDVZpQ0=
=ZvwA
-----END PGP SIGNATURE-----

--1e2ey3LXjRym4yPT--
