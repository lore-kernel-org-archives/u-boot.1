Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EDDEE01E9
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 22:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55A9F88F35;
	Wed, 11 Sep 2024 00:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cthByZgB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4011E88F5C; Wed, 11 Sep 2024 00:07:16 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B25B388EBF
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 00:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7a9ab721058so26340485a.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726006032; x=1726610832; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nkcWUPzLNtyzh/lKSs1xElyv5wJdeQcxvUVRSwn+p+o=;
 b=cthByZgB2Q3ENQXfDrSxxxeCSv3PIJNXTM4R32YG/NEesabB7DGB6RRSDGCC/hm8YJ
 SBf4+oQxuETyIVG5t+eTUUMub45TdqoaYJg9lDb9uYnl84X5LRrKJmBUm7VHyJr1kWFc
 Yqjt9Z18ExljGMGYknxBOMyc2UUyvJyMnoy6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726006032; x=1726610832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkcWUPzLNtyzh/lKSs1xElyv5wJdeQcxvUVRSwn+p+o=;
 b=LyLMUcaa3A4lW8h0wl+5V3FeqemSOUwz6eSehqr446guYw9aEpC375nf+yNiwWoHIo
 uygh+UnwF6knephU5LWDn5ZPH/HwktF9JboFNX6HFOpisXIWWR/IE15XgoAh13nO7HOF
 x+oGEyiqu2lgokHfhDOLzt0SjM3VbB4F/OJRAHcPYAlC1WnFoHbLN0QlazMGHlubhi2k
 pxIfLJ/59+XlpA53WizhJTdNRg5IsNtQQ7WkaOS2jNABQG68MMm+yav7jCzEzpTNLHQs
 Jm11C/ySKE/qUnfZLsLGdx0BI9c6AR2eET8R4RpG5KxplmMHg3ss77W5YXCdZ99N1NIT
 XIkA==
X-Gm-Message-State: AOJu0YzzOMbTz1dWlYjJcbOk+YhesFY6II8N5t6iv7W9tGkEFlLkisIr
 Hmjh+KoEvRpR3wcxfx5oCKk3+3nvqjmTVFUFcPly8ilM6P8Dz+skpE6wZZrfY2I=
X-Google-Smtp-Source: AGHT+IHHa6Prxpcjib0P2vUSEWk/r0swvLKYwMc1E68fgzUqH4h8H8JAecrztnrmgMkrFSJgbJM2fw==
X-Received: by 2002:a05:620a:4014:b0:7a9:b3eb:9c9b with SMTP id
 af79cd13be357-7a9bf96ddcbmr1040756585a.13.1726006032350; 
 Tue, 10 Sep 2024 15:07:12 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7a040dbsm347663685a.86.2024.09.10.15.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:07:11 -0700 (PDT)
Date: Tue, 10 Sep 2024 16:07:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v3 2/3] buildman: Allow skipping the dtc build
Message-ID: <20240910220708.GN4252@bill-the-cat>
References: <CAFLszTh1Nig-hs+Gtxzg8f-=vE1z4BvNSfEyUGtatZohj0pnuQ@mail.gmail.com>
 <CAFLszTgufCxvXjJupqDphcGwJ0gfvrYxQACK3kYRKaumpKgrYQ@mail.gmail.com>
 <20240822141013.GQ1626301@bill-the-cat>
 <CAFLszTiV8Nut06NeJFqT87y8qSTfzMYwxY6vc10+Q6NY6u2m-A@mail.gmail.com>
 <20240902153904.GX2479150@bill-the-cat>
 <CAFLszTi4_=n6SmfN8unNx6DgO+C4HQwpxG8gcWuOGUd4Lna_ug@mail.gmail.com>
 <20240910184242.GL4252@bill-the-cat>
 <CAFLszTjfU8m-dQyXXAHJ0FWGfAMdvF3yYDMOofN87qocY0mRyg@mail.gmail.com>
 <20240910185237.GM4252@bill-the-cat>
 <CAFLszTgNPmHD7t4k1BkB_eSVZz7ZgP9=vuoPykm2ZGV0PQxg3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kfytsXdrXqQxG9YB"
Content-Disposition: inline
In-Reply-To: <CAFLszTgNPmHD7t4k1BkB_eSVZz7ZgP9=vuoPykm2ZGV0PQxg3g@mail.gmail.com>
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


--kfytsXdrXqQxG9YB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 02:14:35PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 10 Sept 2024 at 12:52, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Sep 10, 2024 at 12:45:39PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 10 Sept 2024 at 12:42, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Sep 10, 2024 at 12:41:11PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 2 Sept 2024 at 09:39, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sun, Sep 01, 2024 at 02:09:39PM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Thu, 22 Aug 2024 at 08:10, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Wed, Aug 21, 2024 at 09:00:25PM -0600, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Fri, 16 Aug 2024 at 17:53, Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Fri, 16 Aug 2024 at 11:22, Tom Rini <trini@konsulko.=
com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Aug 15, 2024 at 01:57:45PM -0600, Simon Glass=
 wrote:
> > > > > > > > > > >
> > > > > > > > > > > > For most boards, the device-tree compiler is built =
in-tree, ignoring the
> > > > > > > > > > > > system version. Add a special option to skip this b=
uild. This can be
> > > > > > > > > > > > useful when the system dtc is up-to-date, as it spe=
eds up the build.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > ---
> > > > > > > > > > > >
> > > > > > > > > > > > (no changes since v1)
> > > > > > > > > > > >
> > > > > > > > > > > >  tools/buildman/builder.py       | 27 +++++++++++++=
+++++++++++++-
> > > > > > > > > > > >  tools/buildman/builderthread.py |  4 ++--
> > > > > > > > > > > >  tools/buildman/buildman.rst     |  3 +++
> > > > > > > > > > > >  tools/buildman/cmdline.py       |  2 ++
> > > > > > > > > > > >  tools/buildman/control.py       |  3 ++-
> > > > > > > > > > > >  tools/buildman/test.py          | 31 +++++++++++++=
++++++++++++++++++
> > > > > > > > > > > >  6 files changed, 66 insertions(+), 4 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > We should probably do this more generically, outside =
of buildman. We
> > > > > > > > > > > have scripts/dtc-version.sh and if the system version=
 isn't new enough
> > > > > > > > > > > (and we just need to define whatever the minimum vers=
ion is), then we
> > > > > > > > > > > build our (not currently that new anymore) dtc instea=
d.
> > > > > > > > > >
> > > > > > > > > > Yes I think I did a patch for that ages ago [1], but it=
 was rejected.
> > > > > > > > > >
> > > > > > > > > > I'd be very happy for it to be applied as I think it is=
 a better
> > > > > > > > > > solution than this one.
> > > > > > > > > >
> > > > > > > > > > I see that some poor sod tried to do this in Linux this=
 morning.
> > > > > > > > >
> > > > > > > > > Any thoughts on that patch?
> > > > > > > >
> > > > > > > > I'm open to re-considering [1] again, but we need to handle=
 the warning
> > > > > > > > problem first. That means...
> > > > > > > >
> > > > > > > > > Also I do see one problem. Newer dtc version produce a lo=
t of
> > > > > > > > > warnings, which causes CI to fail. So if we always use th=
e newest
> > > > > > > > > version, people are going to see a ton of warnings when t=
hey run
> > > > > > > > > locally. Am I missing something here?
> > > > > > > >
> > > > > > > > Well, it would be great to get our Kbuild logic anywhere cl=
ose to
> > > > > > > > in-sync again with upstream. But syncing up the disabling w=
arning flags
> > > > > > > > shouldn't be too hard.
> > > > > > >
> > > > > > > So, coming back to this patch, the nice thing about it is tha=
t it is
> > > > > > > deterministic. So people who build U-Boot and don't want funky
> > > > > > > behaviour will be happy. It will use the internal dtc by defa=
ult. To
> > > > > > > use the external one, you must provide an option.
> > > > > > >
> > > > > > > This patch only affects buildman, but as you can see the mech=
anism it
> > > > > > > uses is to set the DTC variable, which people can do without =
buildman.
> > > > > > > It's just a convenience, but useful enough to have a flag, I =
believe.
> > > > > >
> > > > > > Wait, that's right, we have DTC as a thing that can be set in t=
he
> > > > > > environment, so why do we need something for buildman at all?
> > > > >
> > > > > It's a convenience. I have found that it speeds things up quite a=
 bit,
> > > > > so I want to enable it most of the time. But we can't do it by de=
fault
> > > > > and need it to be optional, I believe.
> > > >
> > > > I wasn't clear, sorry. Why is:
> > > > $ export DTC=3D/usr/local/bin/dtc
> > > > $ tools/buildman/buildman ...
> > > >
> > > > Enough?
> > >
> > > My patch is more equivalent to:
> > >
> > > DTC=3D`which dtc` buildman...
> > >
> > > As I said it is a convenience which I want to use all the time,
> > > including in CI. Are you worried about changing buildman? What is the
> > > issue here?
> >
> > My question / concern is why do we need:
> >
> > >  6 files changed, 66 insertions(+), 4 deletions(-)
> >
> > When we can do it with zero code changes?
>=20
> We don't need anything here...but this helps with my productivity as
> and can add this flag easily when doing large builds.
>=20
> Note that half of those lines are a test and another half are just
> plumbing it through all the layers. Any new flag will end up with
> this, even if it is a few lines of 'real' code.
>=20
> > And then similar to the
> > worries I set aside with the "venv" related changes,
>=20
> That change does fix a bug. Without the change, we cannot run code
> coverage in CI, which I very-much want to turn on once Marek can
> figure out the missing Binman tests.
>=20
> > you're making one
> > tool be clever and work as exactly as expected (but perhaps in a "do
> > what I meant, not what I said" manner?) way.
>=20
> The only magic is that it locates dtc on the path, but that is the
> thing that I find valuable.
>=20
> > If we have "set DTC in
> > environment, it's always obeyed, can be passed directly to make" but
> > also "pass buildman a flag to say where dtc is" why do we need the
> > latter if it should already be working, and I think already is working?
>=20
> The flag doesn't tell buildman where dtc is, though. It tells buildman
> to hunt for it and use that in preference to the internal build. I am
> not suggesting adding anything non-deterministics.
>=20
> A general point here...buildman is pretty stable but it is not perfect
> and we continue to tweak it to help make it a better tool. When it is
> perfect, I will certainly stop sending patches for it. I normally only
> send a patch when a bug is reported or something annoys me. The dtc
> thing annoys me *a lot* because it chews up ~20% of my CPU for no
> purpose. I had not realised how bad this problem was.

Thanks for explaining. Whenever you want to pick this one up, go ahead
and send it along then. And I guess at some point we should look at (a)
re-syncing our libfdt code and (b) switching to using system dtc by
default?

--=20
Tom

--kfytsXdrXqQxG9YB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbgwwkACgkQFHw5/5Y0
tywBkwv9FIuBETbHwsdCtlORiSe0v24dz8Y4mebuzpzjvt2dTBYMFpkZKT3dvphM
0Qkk/Kif6inVvszdOk6Y4WdnjaFvY5kmYHUxIT3PhDRi53AOty2WN+HLy99HYihC
kSBC8/rk2Y8SsmrLeF461J9cSBNsJeyOGYvdvU7KHFxfJNQPewi4OQWdEk59E+9c
dnhdYjPYEgzAwuiHchyrbs/jYWjobpyTETKAkpQIQHbN3c+LObTFpNlEJuym6FCo
YsTWawyvd6daEvexpjfpD6/8K1JgCt6kjQeRZ1oN90bM/3K3XTvPEc11P/4j6E8B
Qb5Nzzt3IbnGBRI28o/g3LOjWeIs/mQmJPuwny4qApHYk+mATH2v54tV34Y9FQ0V
zo9z5/VNxqkEQPla6kYFg9myRcS0khc8az+kWcV4t+tBxarjMviJo5WlVPj48zu7
IeG5BkJxna7kPD7r7inPhJuluzgz+OuTWONnxG0vQnmpskwzG7pRIDBf3F9wvBFE
L7O58uHe
=WOXQ
-----END PGP SIGNATURE-----

--kfytsXdrXqQxG9YB--
