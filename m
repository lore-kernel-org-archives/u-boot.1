Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CCBC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F00028846D;
	Fri, 21 Jun 2024 21:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pb6OhHO8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12B9F884D0; Fri, 21 Jun 2024 21:26:24 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1F798845A
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3d2299e6650so1094632b6e.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718997980; x=1719602780; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UfdWcaCB4h4SN424VkBevQv0MfO2SGL1/A1cFztV6o8=;
 b=Pb6OhHO8vNPhpMioJZS7bXjyA8WNd2ps68BBeWMvseZNKMKFZEQ35vq8s9GlRva0uB
 WK+xg+YRPTnHEUFt5vm+5lBajJZ5gTWJkFLoTmbhk+2/l+ATiohA/rnsK+MNNnmTeUzn
 MqVpvWIYpSSbE53geHMgxkXoc+lWLaFnNPrEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718997980; x=1719602780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfdWcaCB4h4SN424VkBevQv0MfO2SGL1/A1cFztV6o8=;
 b=qpx4u0XWHSnGb3XY0FNWKEEAlF6y7TlV25eBfScnLJuD2QiYH/X1RNBDn83J8aN5P/
 lv08bXQ4bvhhMGXgZwj4k9cL6MjFJJFeJofWuZuhwDSenshZZVcP0aU8y4hxB05ojtNb
 JyQp5wVo0itIamQg2O47KQyPK05pLmuk0wOnP/Juy+DkMdTKFp3LXcfuFpbC/KjWZUYS
 B2y1Zv2Ok8rf+B6PajAsFYDPeiM6+sCnNECfvtWz/o88DGQcejn80N4c4Bdn1WZVengu
 P4GOttle8lJmL0kpEi3QhCBOp1Y0XDLQsJ4HSaW9w9KHNJKcsILMdBWSOT8IPbe6+rIF
 3ZJA==
X-Gm-Message-State: AOJu0YxCcT+v4dDUI1u1ZN6D/+I5lX43QS9ib9wY40DxWlFe+T1zG+qQ
 DsumM2b8ajjGhX8wdyHhNzxYxsAO28dul2F7qnQm9xFWBTGcXnVH3gD1xWqxLII=
X-Google-Smtp-Source: AGHT+IHBTru6jGMjlzbCdflM6KQ79Jum2Tmv4JDf0Rd+W4tdE1NX8Sv/9+Wd5sKfzuVxL9wHj05IFg==
X-Received: by 2002:a05:6808:1b1f:b0:3d2:1bbf:5b5c with SMTP id
 5614622812f47-3d51baf7e87mr9659740b6e.52.1718997980256; 
 Fri, 21 Jun 2024 12:26:20 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d5345e6196sm401572b6e.58.2024.06.21.12.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:26:19 -0700 (PDT)
Date: Fri, 21 Jun 2024 13:26:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 3/5] buildman: Support building within a Python venv
Message-ID: <20240621192617.GA68077@bill-the-cat>
References: <20240620131937.1130446-1-sjg@chromium.org>
 <20240620131937.1130446-4-sjg@chromium.org>
 <20240620143232.GM68077@bill-the-cat>
 <CAFLszTj0QgctNFigd=m7450gCLU3mnu9bTXtk=DuZmE7eAtWBg@mail.gmail.com>
 <20240620233026.GU68077@bill-the-cat>
 <CAFLszTi7qXX6R5=LQqCMveH7aJ=N96Mcob+gp11MEPixgrK66A@mail.gmail.com>
 <20240621152229.GV68077@bill-the-cat>
 <CAFLszTi_NBBxz3MZz0HuOW5c2bGT3FgZ2usnAginZ0LC_TdX9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GvJ/3Ecsurj9f1X8"
Content-Disposition: inline
In-Reply-To: <CAFLszTi_NBBxz3MZz0HuOW5c2bGT3FgZ2usnAginZ0LC_TdX9A@mail.gmail.com>
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


--GvJ/3Ecsurj9f1X8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 12:19:12PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 21 Jun 2024 at 09:22, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Jun 21, 2024 at 08:57:50AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 20 Jun 2024 at 17:30, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Jun 20, 2024 at 05:05:30PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 20 Jun 2024 at 08:32, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Jun 20, 2024 at 07:19:35AM -0600, Simon Glass wrote:
> > > > > >
> > > > > > > The Python virtualenv tool sets up a few things in the envron=
ment,
> > > > > > > putting its path first in the PATH environment variable and s=
etting up
> > > > > > > a sys.prefix different from the sys.base_prefix value.
> > > > > > >
> > > > > > > At present buildman puts the toolchain path first in PATH so =
that it can
> > > > > > > be found easily during the build. For sandbox this causes pro=
blems since
> > > > > > > /usr/bin/gcc (for example) results in '/usr/bin' being prepen=
ded to the
> > > > > > > PATH variable. As a result, the venv is partially disabled.
> > > > > > >
> > > > > > > The result is that sandbox builds within a venv ignore the ve=
nv, e.g.
> > > > > > > when looking for packages.
> > > > > > >
> > > > > > > Correct this by detecting the venv and adding the toolchain p=
ath after
> > > > > > > the venv path.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > >
> > > > > > Why are we using PATH at all in this case? Shouldn't we just be=
 setting
> > > > > > CROSS_COMPILE=3D/full/path/to/the/prefix ?
> > > > >
> > > > > This is the -p option to buildman. The original commit was:
> > > > >
> > > > > commit bb1501f2c22c979961b735db775605cccedd98f6
> > > > > Author: Simon Glass <sjg@chromium.org>
> > > > > Date:   Mon Dec 1 17:34:00 2014 -0700
> > > > >
> > > > >     buildman: Add an option to use the full tool chain path
> > > > >
> > > > >     In some cases there may be multiple toolchains with the same =
name in the
> > > > >     path. Provide an option to use the full path in the CROSS_COM=
PILE
> > > > >     environment variable.
> > > > >
> > > > >     Note: Wolfgang mentioned that this is dangerous since in some=
 cases there
> > > > >     may be other tools on the path that are needed. So this is se=
t up as an
> > > > >     option, not the default. I will need test confirmation (i.e. =
that this
> > > > >     commit fixes a real problem) before merging it.
> > > > >
> > > > > As to why we don't always do this, well that is back in the mists=
 of
> > > > > time, 10 years ago.
> > > > >
> > > > > BTW, this is raising a point ("let's change the behaviour") separ=
ate
> > > > > from the goal of this commit, which is to fix a problem with venv,
> > > > > albeit that if we made -p the only option, then we could potentia=
lly
> > > > > drop all PATH changes. Perhaps toolchains are built differently n=
ow,
> > > > > such that they always invoke their tools using the same prefix and
> > > > > dir?
> > > >
> > > > Wait, I'm confused. buildman internally updates its own PATH to avo=
id
> > > > calling CROSS_COMPILE with the full path due to a concern about
> > > > toolchain bugs?
> > >
> > > Not its own PATH: the one it passes to U-Boot's 'make'.
> >
> > OK, but the point stands.
> >
> > > I'm not sure why, actually. It is such a long time ago that I don't r=
emember.
> > >
> > > I see:
> > >
> > > ~/.buildman-toolchains/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-li=
nux-gnueabi-ld
> >
> > Yes, prefixed version that's allowed to be called by users.
> >
> > > and
> > >
> > > ~/.buildman-toolchains/gcc-13.2.0-nolibc/arm-linux-gnueabi/arm-linux-=
gnueabi/bin/ld
> >
> > Internal usage, here be dragons and all that.
> >
> > > but interestingly there is no gcc in the latter directory, which there
> > > was in 4.6 (and presumably for some time after).
> > >
> > > Certainly for sandbox there is no prefix, so we cannot add it in that
> > > case, and sandbox is actually the arch used to run these tests.
> >
> > CROSS_COMPILE is empty for sandbox, yes.
> >
> > > What are you suggesting we change about this patch?
> >
> > That it's going about things backwards? If you're setting CROSS_COMPILE
> > _then_ it should be the full path that it already knows otherwise if not
> > setting CROSS_COMPILE then also not modifying PATH.
>=20
> That is what the code does, yes. It either adds the toolchain path to
> CROSS_COMPILE or to PATH, not both. The 'full_path' argument controls
> which one it uses.

I'm saying it should always use the full path to CROSS_COMPILE and never
modify PATH.

--=20
Tom

--GvJ/3Ecsurj9f1X8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ109kACgkQFHw5/5Y0
tyxV8gwArZyFPUrEqD4f74fTsbw0zGctPoLkCKGiQoVmdT9AFjnF63RDRWrpdiOv
dGEZHFCMvcVQW6HwZJ7rn/puq5LyQHjoBvpthv+LsHi64M7Y4JTzq8pKEHMDi4TN
tqNAYOKUAgUVKjmvE0zJejMzH89/N45rXJ9x2vg7XKuOSefHHFEPm3Jz/rz/jTpB
SMa6TDLbpPuR8yjKvpdVLmpqoo+/toQnDV6f2ZX74QfTOCmLLklz6Xzy3x30JnXg
w9/H9JOB8mDtRaVBfDm+WGIYutF3f0TbKfp7lQcm0r4gTg40IQvW28CShUUYgAqI
E6cW7K4aubUI7/IVwwT5aZri/YeCG6Cxwk1QCS3mv9UVV+v7cQyCEr9eCpLIuMJ0
YVN/SWvZl28huZlkIrty3lGWy/93Z0agqdMZI50vhb9Y8me3n9FgxNUww0BNEcqu
VU1JcHuJH6xO+K5N0P0NPmkw3ySIBQ3RQY0isMJQR1QWHZ54Ig5rThDJDI0mEsu+
fSAX839z
=Luzl
-----END PGP SIGNATURE-----

--GvJ/3Ecsurj9f1X8--
