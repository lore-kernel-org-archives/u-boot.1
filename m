Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77282C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 17:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D083780141;
	Sun,  9 Feb 2025 18:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NzmdxtxG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3045680141; Sun,  9 Feb 2025 18:52:33 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A1B9800B3
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 18:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e4419a47887so2811722276.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 09:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739123549; x=1739728349; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIfejGoMjADe3rXqglGEKiv112NqbdKduGREsZaInRE=;
 b=NzmdxtxGNQQtwmNiz5L4zkd+L5JBWkdulmAwf3eF/EGi/RJXkRi39IT82nPjIHwqkY
 VfwDaSX/uzmSw3mXqt9Pgsx35Ps7GsaVhjKjwRfy/58N+OTcIsaqPfpaPVYKPYIk2BJD
 MimWjU/ODm/4pS+e2av1UG7DZvRYdBCYTchVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739123549; x=1739728349;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIfejGoMjADe3rXqglGEKiv112NqbdKduGREsZaInRE=;
 b=a19ya6uTY4yZyCnguU2q8QS1Tmw5X0m58ppcFCIvgctph3kGRMqlW8BcZdPbOtlhOW
 A+2x7LU5Ll+JzTRqJ3cQ5o7BC7TPb/lnd2z3q/JSRN7HfDCqgkk5BkLs4xFqHQjp1BJP
 B3XsjGAf6fwlYqgZTXXZ28XbB5iGtUo5H1+aAApPYoDbmqpECp7h/Kjlh+eiNDQp3J2M
 1vhem/Efza1aNey2e+w5CUV9FsPHf79GxAQG87lJALYdDxo9nrtUiRO3b91sct6BswVm
 ooTbke5cIIyxhemtF6/ArlwdLNofKgIxXFy6gUPbS5RAVwWQo0yik9L++qKLnBWeYyTc
 8ewQ==
X-Gm-Message-State: AOJu0YyXIRCDbAGJEFVTYSNuCkQ3gxM1tK+0SRYjTEND4PRb/QiIdkz2
 7qK06UpgrD+OxpeU6LYXcNCLNheS1Xdo/Jt9IV5mMS06+LIESih1S5mrRh13MjI=
X-Gm-Gg: ASbGnctQy8cYeLAofFfmw/0tj9jfVTYz1zKlMxS1UNUbf7tesKLIYq2NTVlcJC0nRGs
 6doR/IB28awjN09EqqcTLC93CvbdZfUJ+q8tH4t8t+h/bejiFOtnN4PN5NyCGDAXvDwlt5Z60cw
 n47CinGJWqNsgu++XeTF3k+eFpUAc2Gnz4XWIQ/MdnDZxCbh1Snwsla9YC4W2RcvTHB9ALMHwET
 GyyQYnQ2L/5b6lfno8fpRSiFzTrZfZeWPVCVfmqufPuHWikt5LJUTcB42kCPwsTuxxExmnfcJEb
 ZIL3VLB1OfmgZrY=
X-Google-Smtp-Source: AGHT+IFnrpIKnC9VJdKxubTpErgJ5LURezaHqF3MrZ4rId0L/6A01omrlK9/gFW0VId+K9uQjLl2/g==
X-Received: by 2002:a05:6902:110b:b0:e5b:45ab:9607 with SMTP id
 3f1490d57ef6-e5b461ea24cmr8891960276.25.1739123549383; 
 Sun, 09 Feb 2025 09:52:29 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5b3a45d7e6sm2069334276.45.2025.02.09.09.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 09:52:28 -0800 (PST)
Date: Sun, 9 Feb 2025 11:52:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH 01/32] Convert build-efi script to Python
Message-ID: <20250209175225.GQ1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-2-sjg@chromium.org>
 <20250203200744.GZ1233568@bill-the-cat>
 <CAFLszTh0JYdCy8SYOkbnhGZB-cbtcYeZiqoHp0R-VF4Nn9rbsA@mail.gmail.com>
 <20250206171045.GJ1233568@bill-the-cat>
 <CAFLszTgpvPqJnX7b2YDvrOz19q4Gw_+ZP0UYoTaUKWFtB3N-Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EWa8qQKWVeEYR7mv"
Content-Disposition: inline
In-Reply-To: <CAFLszTgpvPqJnX7b2YDvrOz19q4Gw_+ZP0UYoTaUKWFtB3N-Vw@mail.gmail.com>
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


--EWa8qQKWVeEYR7mv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2025 at 06:28:41PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 6 Feb 2025 at 10:10, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 06, 2025 at 06:05:36AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 3 Feb 2025 at 13:07, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Feb 03, 2025 at 10:41:54AM -0700, Simon Glass wrote:
> > > >
> > > > > Before this gets any longer, convert it to Python so it is easier=
 to
> > > > > maintain.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > >  MAINTAINERS                        |   2 +-
> > > > >  doc/develop/uefi/u-boot_on_efi.rst |   4 +-
> > > > >  scripts/build-efi.py               | 258 +++++++++++++++++++++++=
++++++
> > > > >  scripts/build-efi.sh               | 207 -----------------------
> > > > >  4 files changed, 261 insertions(+), 210 deletions(-)
> > > > >  create mode 100755 scripts/build-efi.py
> > > > >  delete mode 100755 scripts/build-efi.sh
> > > >
> > > > This should just go live in the u-boot-extras repository as another
> > > > sample script. And as a bonus, there you can just push the script r=
ight
> > > > now.
> > >
> > > But I can't be sure it will stay that way. In any case I see these
> > > scripts as first-class citizens, in the docs, tested in CI, used by
> > > people to report bugs, updated as new features appear, etc.
> >
> > Yup, I still think that's the wrong way of looking at it. It's a sample
> > script on how to use this for QEMU which means it's useful as a debug
> > and development aid. It's bad for CI since if we want to deal with "CI
> > is slow" we need to pre-create test disk images, not do that on the fly.
> > And you've got sudo and various external blobs being used. No, it does
> > not belong in the main repository and I'm sorry I missed it the first
> > time.
> >
> > And converting this to python is even worse as we have yet another tool
> > that should have a proper requirements.txt file and keeping that up to
> > date. And then oh, the inevitable "here's a security issue in U-Boot!"
> > (by which they mean an issue in a support script and not what's deployed
> > and used).
>=20
> IMO development aids are quite important for efficient development. We
> have things like scripts/gen_compile_commands.py and checkpatch.pl
> which I use quite a bit. Cloning another repo just to be able to
> develop on U-Boot efficiently seems daft to me.

There's pluses and minuses and fine lines to be drawn, yes.

> We don't pre-create any test-disk images at present(?) I'm not even
> sure that is a good idea, since it means that updating a test becomes
> a lot harder. It would save a little time, but the thing which creates
> the image only takes a few seconds on tui (although this happens on
> each runner on the test.py stage):
>=20
>     2.6s  test_ut_dm_init_bootstd
>=20
> Python is easier to maintain than shell when it gets beyond 100 lines
> or so. We could use the same requirements.txt we have for test/py and
> I'm not sure how to deal with the security side. It sounds like
> calling it a contrib/ directory might be enough.
>=20
> >
> > So please, lets just move this to the extras repository, and point to
> > *that* in our docs enough that it's clear that we have tooling that can
> > be useful in some cases there.
>=20
> So long as I can point to it in docs and never lose access to the repo
> in the future, I think I can live with this. At least I can try it.
>=20
> I think I could add it as a repo in the contriib/ subdir of the U-Boot
> directory (with a .gitignore in U-Boot), so perhaps I can mostly
> forget that it is separate.

You've had write access to the u-boot-extras repository since it was
created, sorry if I wasn't clear about that. And another good thing
about having "contrib" things outside of the main repository is that
it's much easier to grant write access to others.

--=20
Tom

--EWa8qQKWVeEYR7mv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeo61YACgkQFHw5/5Y0
tyz6qAwAk/E/lsMzUKn1qktcFc6nI81564iwX0oIN1zQ8rfrvUuQX1iBf6OXUsCm
7a1FSGQKrBvRR3B3Wt8SUsrKHKnqycv0U9lRK6US3U2KOJurj5RK74Zq7ozW3Ose
dpq82WLsBN0uxD2iIYzJp/WZj7qz1J44njYR2uO9zxCUQaIlKlHqeh+SXK7l0t0X
ovfv7A0mYGRKc1LyR2gekA7NuRVeDQ240NdHzJ84pHSvcHayMjl4Z34pC+rmjcM3
bnhr7pYtupHaLTiyMWNo7INE6YTnG4egrJs64BAZoPp5YM0pwif3uxOhoCADvyW1
bXmuD+vKMy1O6io+jKoaKdukqkVxKLyt6EL3r2jRQkP+ZnbbCxQhTGbbkWt+0SIS
CJhXKis/Z/Pa2mFeVMLzd3Ugsn5L+SCMH7QrS1C5md9465ulPqgRjiY/fROpwoLU
ByzhczpkF7pjHdusPobj4oRvEyIqOlxO+JaMnXvLDMcl9yhH2K4XVKayRX2c6jqW
TgnBDT45
=Iqyz
-----END PGP SIGNATURE-----

--EWa8qQKWVeEYR7mv--
