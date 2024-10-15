Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E93D216B7
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 14:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2652D882BE;
	Tue, 15 Oct 2024 16:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="drBS3LcX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10F7E88009; Tue, 15 Oct 2024 16:30:46 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C744488009
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 16:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b111535924so445015785a.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 07:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729002642; x=1729607442; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l5nUZu5+JI43MXHvPO9gRjFKmW3r/R1MUL6ZmBJEpUg=;
 b=drBS3LcXOKeGAvn8jAAJsE3Y+tnFGDsofmzMdcJY4Rr9jMudin67jPHACpPLMS0rh4
 /cWuZnkaraIE/GyWWQ3OPfp7+OtSoJ3lNxbH5NSd68OOauKn500oTgRZJNvN6Xsmu//F
 zV7CcVA2LJCfX2w7+8mJSCy3EEVpy3j5MpE04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729002642; x=1729607442;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5nUZu5+JI43MXHvPO9gRjFKmW3r/R1MUL6ZmBJEpUg=;
 b=M6uUgkc2hnwA3CGjF4LBsa4sSIyiY598Dptoj0n+Yv0GZNwLTXFl2kHx+8Mi9is6JF
 2+tHeYsJ7AzjKDMrBNMHxGXzyV1J0YuODfzWYj5fLs/UBqc8SyPWeFpiaL3+dzHLwL8e
 GloDiOMkdKOWFdbwgpC9tAU93u8YBJeiVMR5pscvidbXDGDAzMNUv4GOTaRcY/ABc57E
 X3nsYQkoo5dJwxpMJ5Nko1vDiWF5i3+bAFjeNON1IqW31EHgkScfe1vM1beApToqc5Js
 17xLvhBxHe1k+K7xqv3ih3JjzXdgUZKciG3RlCSx22C+q+gJvjGB50ZO3YBR+pG3ZUIa
 l3nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgzWqjuN2or7MFzm0CLhMHO2WjN9Y3nzz1zR/fhKG0MOp/6H4GvPMzMg8q4XlYpczZePGsBFs=@lists.denx.de
X-Gm-Message-State: AOJu0YwF2vCbbtWx+lESxDq66WR/wjzgRuz/F2hjPIgMcwp+P12ZIyZq
 2rXJRbUoLvG1n+JnmFv+qlHBSudVeOS3zbBqAq/wGtNdKBDzl/fXYwDTRhagvt0=
X-Google-Smtp-Source: AGHT+IFDQnH7Tv1lEimv0yHh5XzIZQP+z+BK3ojWCx1mzo2Vm+ZbCzR2u9Kxd/2FhiwK/XSnmc3Cwg==
X-Received: by 2002:a05:620a:468a:b0:7ae:d2d0:f86 with SMTP id
 af79cd13be357-7b11a396bfcmr2049840885a.38.1729002642345; 
 Tue, 15 Oct 2024 07:30:42 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b136164e4fsm76084785a.2.2024.10.15.07.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:30:41 -0700 (PDT)
Date: Tue, 15 Oct 2024 08:30:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: Re: [PATCH v4 4/5] efi: Reserve some memory for initial use
Message-ID: <20241015143038.GM53053@bill-the-cat>
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-5-sjg@chromium.org>
 <71ECC011-77EC-4308-AFE5-0E301BC27F84@gmx.de>
 <20241012012716.GE14210@bill-the-cat>
 <CAC_iWjL_YQ24ZecbN7oC-37PRR6iuUiiui-a0VPqSSVRunepdQ@mail.gmail.com>
 <CAFLszTjzHBtR8vzk0wT-nNiwbsotqskVhVEX0ibh-Uea1+Da6Q@mail.gmail.com>
 <20241014214236.GB53053@bill-the-cat>
 <CAFLszTi8iJRMBVd79JLumPVz3VB0A8w1v_ZM2pP9D_cp_nx3yg@mail.gmail.com>
 <20241014215454.GF53053@bill-the-cat>
 <CAFLszTiaO0NqK+-qqnEB28+iqH0jh7bW_uFWW-eNG8vBWG15Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Jcuwzeu7hNLgwGN8"
Content-Disposition: inline
In-Reply-To: <CAFLszTiaO0NqK+-qqnEB28+iqH0jh7bW_uFWW-eNG8vBWG15Xg@mail.gmail.com>
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


--Jcuwzeu7hNLgwGN8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 07:12:21AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 14 Oct 2024 at 15:55, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 14, 2024 at 03:50:51PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 14 Oct 2024 at 15:42, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Oct 14, 2024 at 02:19:56PM -0600, Simon Glass wrote:
> > > > > Hi,
> > > > >
> > > > > On Fri, 11 Oct 2024 at 23:47, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Tom
> > > > > >
> > > > > > On Sat, 12 Oct 2024 at 04:27, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Sat, Oct 12, 2024 at 12:01:54AM +0200, Heinrich Schuchardt=
 wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > Am 11. Oktober 2024 23:21:25 MESZ schrieb Simon Glass <sjg@=
chromium.org>:
> > > > > > > > >The 'point of cooperation' is where U-Boot starts allowing=
 EFI to use
> > > > > > > > >memory outside of the U-Boot region. Until that point, it =
is desirable
> > > > > > > > >to keep more below U-Boot free for loading images.
> > > > > > > > >
> > > > > > > > >Reserve a small region for this purpose.
> > > > > > > >
> > > > > > > > Your commit message provides no clue why this should be nee=
ded.
> > > > >
> > > > > Yes, I hadn't realised that people didn't understand what I was
> > > > > getting at. Tom asked the same question on irc.
> > > > >
> > > > > It allows us to separate the lmb allocations from the EFI allocat=
ions,
> > > > > so we don't need to have them both in sync. We use lmb for loading
> > > > > images, then EFI takes over and does what it likes, respecting the
> > > > > existing lmb reservations.
> > > >
> > > > But, again, LMB is not for loading of images. It's for dealing with
> > > > memory reservations of various types.
> > >
> > > Up until recently, I believe, my statement was true, but in any case,
> > > this isn't gemaine to the issue here.
> > >
> > > The point is, this is a useful distinction, allowing us to avoid the
> > > complexity of keeping them in sync, and avoid putting this pain on
> > > people who are not using EFI. We are either in U-Boot code, in which
> > > case lmb rules, or we are going into an app, in which case EFI rules
> > > (but must read in the lmb info).
> > >
> > > We are going to end up with people turning off EFI_LOADER because it
> > > behaves so badly.
> >
> > Frankly, in hind sight I should not have agreed to split the LMB rework
> > between "everything else" and "EFI" in hopes that we would then be able
> > to get the "EFI" part of this agreed upon. It's "behaving badly" right
> > now because we merged half of the changes in the hopes that we could get
> > your agreement on the rest of them fairly quickly. This is not
> > happening, however.
>=20
> Well, another option would be to revert the problem patch (or two) and
> do this work with careful consideration of the impacts, taking account
> of my architectural objections.

Well, no. You have objections that no one else has agreed with and most
of the active developers in the areas in question have objections to
your designs. So no, I repeat myself. My mistake here was taking half of
the work in, rather than all of the work in.

--=20
Tom

--Jcuwzeu7hNLgwGN8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcOfIsACgkQFHw5/5Y0
tyzf2wv8CBCwQIC7b4yvYICv1nRy9TLSHTgxPhfvMfkb7wHmOTYmfkwg78KaSwbG
869QyKJsxT7XEVczxx8nTAC13JJ0z/MEyYvfJ2kGamxr6Wj0ub4PPI9+5dBzXMEh
fj2S68st7AvbF3/Fh9yXnxW/pfgwtWs/SdoyTVvlThefAmEuMb6Wi7b7fgT10yMr
SqjHcV885DQ4QWXhLgzq0z5lJcbGgxJ78F/ZLZvIQ65KeEoHhpG13bZAp3fX3miN
rJ9n0VW97MGRwLRHaM1qE2UzkUTtyLmsDs3ISilsPG1E8YFaxysNhrs/b1+XXHvN
gsf9ws6xvXw3O0gx7wsOGhOFNFuXQjFncQmNJtOZPS0B6XpAQVc2RbmN5YVZ4sr4
fQwGsMt/tmtxrdoWwnMl8UedTtEyM4p8/ty5hlLDeOGYe5tevm7ysUi9xVGNBq5X
42xcCFY9mP8v+luAgP0lsjn1NHMs4/z/loWuHaDtYX4S98nzjiXFbbFeqeXmzPFT
IF3+VZ0f
=3SzA
-----END PGP SIGNATURE-----

--Jcuwzeu7hNLgwGN8--
