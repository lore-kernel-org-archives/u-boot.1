Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC261C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 15:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 578F4884C6;
	Fri, 21 Jun 2024 17:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VHpJpx2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B19F8851C; Fri, 21 Jun 2024 17:22:35 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 286D7884C6
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 17:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5bb36de2171so1042535eaf.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 08:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718983352; x=1719588152; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mLPo6bANnQRVBi6yITxZogL60zCOdhCdK751sQvrMh4=;
 b=VHpJpx2ICSX0p9qijwUP0qnB3ykIJKiebnyfoPWv3vsiaIXlXIVjuRuBc7QQ8cVQM5
 yBKU335FAzI3Tf25yITzMAuWibj1gj9/Hibyc0PMMhwwTKakZpERjQcyTB57jtSaoDO5
 POh7hxCbXI3Bs8frj5M50fbIdAtl7i4rnRY+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718983352; x=1719588152;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLPo6bANnQRVBi6yITxZogL60zCOdhCdK751sQvrMh4=;
 b=TI9Hiu0v0QZVnQ7D81Vn3ff37wSBLHXvPfXcvYeXJIsw/Cbuei/oLGvWSElr+OMKv5
 Lx/ngKNm1OsqKyBogQrw0NwnKUM2Jo4OFh+Edxq8rW4CumnCG6TlQWz+2j3zhsMsa8+e
 tKvw5W+MBsMhwLJUiOpteY9FVYh56sPQIsmxYINtO+mVvpR6Y3bJSvshfDnRFHrNlR/x
 icbxC1OdFwsYB1U93Q1dq5lIN4GBNQgoYYEyHQ3sNgpbYYmtAnRAqznGcsXF1fh4SJfZ
 fMeXoi87VnrVXJlHSrMExNkM6BzrsKIpRWEFFekbO/lhF6ywEtIMxXgyTjMHir+7ZPhj
 eX2A==
X-Gm-Message-State: AOJu0YxEUYNe4YyZYx8ZV45qmIImNHL5h85GCAEz8yzkTzsZRzeNG7Pt
 trm5Dhvh9CHRLnSwvkYAG5i4HXgFP5Ax2euXn/l7rSE5CzAbGUtUn/Gflm5kgo0=
X-Google-Smtp-Source: AGHT+IGbRcKEY+iD0v+OE8aFyZSP35rhNxt/hIZdsBCdWwkdVanPUSlNQ3JiDoW5Bnhwo7ovmuJfSw==
X-Received: by 2002:a05:6870:2254:b0:25c:9a02:cb64 with SMTP id
 586e51a60fabf-25c9a02d2b0mr8021344fac.16.1718983351729; 
 Fri, 21 Jun 2024 08:22:31 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25ce25f70bbsm190436fac.1.2024.06.21.08.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 08:22:31 -0700 (PDT)
Date: Fri, 21 Jun 2024 09:22:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 3/5] buildman: Support building within a Python venv
Message-ID: <20240621152229.GV68077@bill-the-cat>
References: <20240620131937.1130446-1-sjg@chromium.org>
 <20240620131937.1130446-4-sjg@chromium.org>
 <20240620143232.GM68077@bill-the-cat>
 <CAFLszTj0QgctNFigd=m7450gCLU3mnu9bTXtk=DuZmE7eAtWBg@mail.gmail.com>
 <20240620233026.GU68077@bill-the-cat>
 <CAFLszTi7qXX6R5=LQqCMveH7aJ=N96Mcob+gp11MEPixgrK66A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q3lRkNGn78uhbWdO"
Content-Disposition: inline
In-Reply-To: <CAFLszTi7qXX6R5=LQqCMveH7aJ=N96Mcob+gp11MEPixgrK66A@mail.gmail.com>
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


--Q3lRkNGn78uhbWdO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 08:57:50AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 20 Jun 2024 at 17:30, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jun 20, 2024 at 05:05:30PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 20 Jun 2024 at 08:32, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Jun 20, 2024 at 07:19:35AM -0600, Simon Glass wrote:
> > > >
> > > > > The Python virtualenv tool sets up a few things in the envronment,
> > > > > putting its path first in the PATH environment variable and setti=
ng up
> > > > > a sys.prefix different from the sys.base_prefix value.
> > > > >
> > > > > At present buildman puts the toolchain path first in PATH so that=
 it can
> > > > > be found easily during the build. For sandbox this causes problem=
s since
> > > > > /usr/bin/gcc (for example) results in '/usr/bin' being prepended =
to the
> > > > > PATH variable. As a result, the venv is partially disabled.
> > > > >
> > > > > The result is that sandbox builds within a venv ignore the venv, =
e.g.
> > > > > when looking for packages.
> > > > >
> > > > > Correct this by detecting the venv and adding the toolchain path =
after
> > > > > the venv path.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > Why are we using PATH at all in this case? Shouldn't we just be set=
ting
> > > > CROSS_COMPILE=3D/full/path/to/the/prefix ?
> > >
> > > This is the -p option to buildman. The original commit was:
> > >
> > > commit bb1501f2c22c979961b735db775605cccedd98f6
> > > Author: Simon Glass <sjg@chromium.org>
> > > Date:   Mon Dec 1 17:34:00 2014 -0700
> > >
> > >     buildman: Add an option to use the full tool chain path
> > >
> > >     In some cases there may be multiple toolchains with the same name=
 in the
> > >     path. Provide an option to use the full path in the CROSS_COMPILE
> > >     environment variable.
> > >
> > >     Note: Wolfgang mentioned that this is dangerous since in some cas=
es there
> > >     may be other tools on the path that are needed. So this is set up=
 as an
> > >     option, not the default. I will need test confirmation (i.e. that=
 this
> > >     commit fixes a real problem) before merging it.
> > >
> > > As to why we don't always do this, well that is back in the mists of
> > > time, 10 years ago.
> > >
> > > BTW, this is raising a point ("let's change the behaviour") separate
> > > from the goal of this commit, which is to fix a problem with venv,
> > > albeit that if we made -p the only option, then we could potentially
> > > drop all PATH changes. Perhaps toolchains are built differently now,
> > > such that they always invoke their tools using the same prefix and
> > > dir?
> >
> > Wait, I'm confused. buildman internally updates its own PATH to avoid
> > calling CROSS_COMPILE with the full path due to a concern about
> > toolchain bugs?
>=20
> Not its own PATH: the one it passes to U-Boot's 'make'.

OK, but the point stands.

> I'm not sure why, actually. It is such a long time ago that I don't remem=
ber.
>=20
> I see:
>=20
> ~/.buildman-toolchains/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-=
gnueabi-ld

Yes, prefixed version that's allowed to be called by users.

> and
>=20
> ~/.buildman-toolchains/gcc-13.2.0-nolibc/arm-linux-gnueabi/arm-linux-gnue=
abi/bin/ld

Internal usage, here be dragons and all that.

> but interestingly there is no gcc in the latter directory, which there
> was in 4.6 (and presumably for some time after).
>=20
> Certainly for sandbox there is no prefix, so we cannot add it in that
> case, and sandbox is actually the arch used to run these tests.

CROSS_COMPILE is empty for sandbox, yes.

> What are you suggesting we change about this patch?

That it's going about things backwards? If you're setting CROSS_COMPILE
_then_ it should be the full path that it already knows otherwise if not
setting CROSS_COMPILE then also not modifying PATH.

--=20
Tom

--Q3lRkNGn78uhbWdO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ1mrEACgkQFHw5/5Y0
tywQVwv/dbTrBRYgpVqL3+vQCR15Mbx5cxrfvCNk4emUPzxezOSWegDEJkbyD+SK
BEVl8AmYlhHGpHBV6gpJB3ULe8xgQ4/vmF6jEcSg8lcZXE3OkyNXGLO43sCTygkP
xHjFeQaj6GXkubmh0IYNVzvXiTnExhNyOVWL7boU7i8h6V8x7YlDxfebz0dLCBXi
41+uOm+cxujV9TtW5JbeXQ8BCD14eJf1xj3ZYmxmkQm8DPgou9gS4gpIFZpTbgQK
yRxZVazZi4+gDzdCa4PXtabJ87kzFJzIJ1IpMgyD/lvfIdnqCA/5t6JoTlwxuF/V
xguwhTFHJfNYY4E/j63fiOgrNw2YkpE5zrf3mQDkA5l2/CfqWtHO+Jz+XYftcX66
hMfUhU9DQJ58XLje7ZhaN3DC43KIZ375YB7yGYAxDURlFMJRfEzYVz3K3SPdiZQG
1D21rGdrtT9wPdlLsOgMB4f9uI04N2H3uscvCVvFlebaVHvq+L28fxGiJ19GFNqS
Sm9TNCDQ
=0st/
-----END PGP SIGNATURE-----

--Q3lRkNGn78uhbWdO--
