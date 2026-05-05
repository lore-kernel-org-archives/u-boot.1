Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A309FF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 14:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB4C4848FC;
	Tue,  5 May 2026 16:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YtYYjvQN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B22BB84948; Tue,  5 May 2026 16:25:29 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2027C848B7
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 16:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7dea20cf21aso4964460a34.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 07:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777991126; x=1778595926; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=plv9iTtG0/HeI3WjyAe8UoGbu2DEh1vJJSeUwidBM2g=;
 b=YtYYjvQNIvZAK1hd/8FzQ7QCCvfpn1wCiG/3lUtJtEBXiGjuf5BUkM/FlUaN+C/x44
 0cT1ggCCbGeI5I9F9Zv00HbbahxWRYY0ZFiqJ1+xa0QM1WB3H94Q1pmQs4bEd91Uw6FK
 cz9e8KyCAup1M+KW2NFDnpXZs/NV+8JoLfFbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777991126; x=1778595926;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=plv9iTtG0/HeI3WjyAe8UoGbu2DEh1vJJSeUwidBM2g=;
 b=HlcfanUfD8AOGc03iZkp6DjmQXX6N1hdfz1f3Eb2O8CEogu16Fhuhne+jT0bf4zWa3
 tkBYQRXAcpabd+u/yiyetHmea/kcjd1iCj36vdzgQ/A+9IbPnA0ZpGr/mtg5z+6qIEJV
 EaQiDfHoCyjyej79oMeym6yrEtQOVWpaMAhnRhn8ho7DHTEOcRcubHSJHTgndbFF/Nsg
 FWL6RyPsSWDfG5onfAsxEAdrNH0zVzbXpd00zzajQIxfpblnrh3dxQ7GXnehUvAgg8xv
 yFxXOn0RxTAT25Bad981LMk/FIpUDalpnNTJ8boXsJG3XDNAp9bU/q+wdura5ovS/RTt
 Rs7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ++pcvC+x7GhcPCUU2bA5644X7qHNj0GD+rCTacn7RUuE0qhHsxiCZVaLntFR/4qcTUqBvlnow=@lists.denx.de
X-Gm-Message-State: AOJu0YzYhum1pMOGxkMV9v9U0qlB8wxJgfIJRWZJ6UWdUOzBcb4RBqjs
 iIjahEEvAJg/QGHKyDq8GVKWTXHPAGaZkkdxhXEOjX8LtY0XGVdVgnJNL5JB3R7YA0g=
X-Gm-Gg: AeBDievQZRtrL05pRyIB36HGuNj2U9z+41z8rmqdDlVh160jXsKCJJ0V8SxzHCZj5ba
 Tsa15oFyyaIpQCk5c2RhHxpHWCk4GiB6DpFrr8lzFjW4Wh4vuWF/qHnoDvvv280iv5armnu3ZP/
 4drhPFloNvZ/Q84fhLNxrwUFLeWZgf+H/ViGniwwMeJOsdgZw4zPILR5o99bC6/4uj+NRHYsHsz
 zCsgF6S/Saimh5/0gIfXe1jb4uFO9DMCuNbRrKRYWb2XGBWLGV+5ojkDWpMzfInQmrmTIWa1I/+
 dBmzM1zxfuwOexQPy/8ezGgCbyxB2YJ366bAtm0E2nhuP4GXvnFXfIs7EZQI8JE7iQBQIrunIN1
 NfunCquvB5iPPIsgAUSnoJ4G3JXaGY3sVRfRuf8MUOxasy13+eTtntQbsQ0jTQ7aIKwBJShpk7h
 fP0JBnj3UqDgDsdGovIs7tBzBNsA9LuMKojJ6c8G543HK0z59SlqUCMDQYOMeAsV38vpfKtIsyV
 yRI5wml7f/lVcoINbNhLrIPGVA1MKeVbmqDNSL1koRI9G9MlF9XP7KorgqZhg==
X-Received: by 2002:a05:6820:2228:b0:684:6be1:ed83 with SMTP id
 006d021491bc7-6998d2523a9mr1498002eaf.40.1777991125662; 
 Tue, 05 May 2026 07:25:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-434548d9decsm14451753fac.3.2026.05.05.07.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 07:25:25 -0700 (PDT)
Date: Tue, 5 May 2026 08:25:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <simon.glass@canonical.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH RFC next 02/18] CI: pass clang HOSTCC and CC to pytest
Message-ID: <20260505142522.GO1614990@bill-the-cat>
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-2-b19301d1948a@cherry.de>
 <20260504180534.GK1614990@bill-the-cat>
 <cd62b6cc-f9ae-4ad9-ba7f-28629d5f0e78@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H6izGwdR9vNc6fy2"
Content-Disposition: inline
In-Reply-To: <cd62b6cc-f9ae-4ad9-ba7f-28629d5f0e78@cherry.de>
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


--H6izGwdR9vNc6fy2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2026 at 11:34:12AM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 5/4/26 8:05 PM, Tom Rini wrote:
> > On Mon, May 04, 2026 at 03:20:29PM +0200, Quentin Schulz wrote:
> > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > >=20
> > > test_env_initial_env_file test calls make on the build directory pass=
ed
> > > with --build-dir parameter which points at UBOOT_TRAVIS_BUILD_DIR whi=
ch
> > > is populated with buildman before pytest is run. For "sandbox with cl=
ang
> > > test.py" and "sandbox64 with clang test.py" jobs, buildman uses clang=
-20
> > > toolchain, but pytest isn't configured to use that as well, resulting=
 in
> > > gcc being used with a configuration made with clang-20 toolchain.
> > >=20
> > > Specify the HOSTCC and CC clang make arguments so pytest uses the pro=
per
> > > toolchain, this will be required in a few commits when we'll upgrade =
to
> > > a newer version of scripts/Makefile.extrawarn which gets rid of check=
ing
> > > whether a clang flag exists (because it's supported by the min clang
> > > version the kernel advertises as being supported) which will be an is=
sue
> > > since GCC for sure doesn't support all clang flags.
> > >=20
> > > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > ---
> > >   .gitlab-ci.yml | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > index 245e422d72f..d0ebd9f123b 100644
> > > --- a/.gitlab-ci.yml
> > > +++ b/.gitlab-ci.yml
> > > @@ -288,6 +288,7 @@ sandbox with clang test.py:
> > >       - ${HOST}
> > >     variables:
> > >       TEST_PY_BD: "sandbox"
> > > +    TEST_PY_EXTRA: "--make-args HOSTCC=3Dclang-20 --make-args CC=3Dc=
lang-20"
> >=20
> > Is ""--make-args 'HOSTCC=3Dclang-20 CC=3Dclang-20'" not parsed correctl=
y ?
> >=20
>=20
> Well, this will make 'HOSTCC=3Dclang-20 CC=3Dclang-20' a single argument =
no?
>=20
> Try:
> make 'HOSTCC=3Dclang CC=3Dclang'
>=20
> Makefile doesn't like it.
>=20
> If you're complaining about the need for duplicating --make-args, it's a
> choice I made when selecting the "append" action for that parameter, c.f.
> https://docs.python.org/3/library/argparse.html#action.
>=20
> We could use the "extend" action with nargs=3D* or +, but I personally ha=
te
> those. It'd look like something like that:
> --make-args HOSTCC=3Dclang-20 CC=3Dclang-20
>=20
> It requires you to be aware of the special "--" argument to stop parsing =
of
> command options and start parsing positional arguments.

I was wondering if there was a way to avoid multiple --make-args, yes.
And I agree that switching to requiring -- to stop processing isn't an
improvement, so this is fine. Thanks for explaining.

--=20
Tom

--H6izGwdR9vNc6fy2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafn9ygAKCRAr4qD1Cr/k
Ch89AQCM26ujcU6OUoiQ7HZHXTmAX0XuXFIWmS2TeCh1xebIQQD/YL4ezoEO+MiU
s1cNEJH0uxDlNBqf7W23FdoUfWQ/lAA=
=KZuF
-----END PGP SIGNATURE-----

--H6izGwdR9vNc6fy2--
