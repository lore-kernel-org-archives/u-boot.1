Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B3AC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 20:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A79C6884FF;
	Fri, 21 Jun 2024 22:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ll5Ea31j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2093C88548; Fri, 21 Jun 2024 22:49:03 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0B2E88059
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 22:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3d2299e6650so1119833b6e.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 13:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719002939; x=1719607739; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=25WSz6Ry4cM9/ml+3bhYvECgQ2mEe6x8uUEQbS8izUA=;
 b=ll5Ea31joU8wnpaIJ1wjn+FRdxtbwck8zFc/bh7Ug1m61vaMCi/DymcofhBQc7pXhg
 7mUcWfn6LsZlsjsRtc+8uf78QMicFGr7I5r3jlCRWxNAnZZ8xFrDRR2es8ow170X7UVU
 qHYQN9wRtAvil1+kCQNGysxGJC3VN/9hVh1vM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719002939; x=1719607739;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=25WSz6Ry4cM9/ml+3bhYvECgQ2mEe6x8uUEQbS8izUA=;
 b=uwN4mtoSFp73SSXmfeyh/kBeEU2y5+WQa6PGBr12axa9q6pq61wnJpNdLzvBAbSmBP
 QzxFlHE0yZwGSZOBYu/Z1TNK3+NEf5zn7WMFpFDGZX3Bv4mWB86H91YrwPTanrTJP+zW
 dQME+eJpr56QQDYi/DhuB6GQRfWCQ7/e4iyLNTNactfVE4zoQa1WzPDExsOulYBGE+YV
 0P4tgMmuWr93Pn9XUNqbYzZBfbnglLH5AtYAu0u2zuE8ABgc5OkQ6t5oIUS+fv7GAkpM
 XA5paSWjaAdwVulzbc5kM2Ph7KhSHn8brDelgrqKKlRxSfyA3p19qYLUnaCEX9IYm+a+
 350g==
X-Gm-Message-State: AOJu0Ywh5xwospYQksg0NKK1Oz1NUK+ey6SqGFgfo89Y63fCUdbEI0LA
 wIaeD8J4UkJZlZXAgRFWiRXErSE48BGU47Cwdgl4WAFgeuWbMHBa5R3PXshIOYQ=
X-Google-Smtp-Source: AGHT+IGAUZPIso5/FnNFtAsYLRZZoZtAUw77lLH3UKo2eMnBppe1gp5COgL1jdsKkLxcjpITYq0m1w==
X-Received: by 2002:a05:6870:fb90:b0:254:a694:e678 with SMTP id
 586e51a60fabf-25c94d02f62mr9783083fac.37.1719002939337; 
 Fri, 21 Jun 2024 13:48:59 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25cd4941a11sm571661fac.9.2024.06.21.13.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 13:48:58 -0700 (PDT)
Date: Fri, 21 Jun 2024 14:48:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 3/5] buildman: Support building within a Python venv
Message-ID: <20240621204856.GC68077@bill-the-cat>
References: <20240620131937.1130446-1-sjg@chromium.org>
 <20240620131937.1130446-4-sjg@chromium.org>
 <20240620143232.GM68077@bill-the-cat>
 <CAFLszTj0QgctNFigd=m7450gCLU3mnu9bTXtk=DuZmE7eAtWBg@mail.gmail.com>
 <20240620233026.GU68077@bill-the-cat>
 <CAFLszTi7qXX6R5=LQqCMveH7aJ=N96Mcob+gp11MEPixgrK66A@mail.gmail.com>
 <20240621152229.GV68077@bill-the-cat>
 <CAFLszTi_NBBxz3MZz0HuOW5c2bGT3FgZ2usnAginZ0LC_TdX9A@mail.gmail.com>
 <20240621192617.GA68077@bill-the-cat>
 <CAFLszTiA5JFU3EaTi_f142tDRej6rSMk=gCWitnqC2tb8d_vtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BwRchxss3G+bi+a5"
Content-Disposition: inline
In-Reply-To: <CAFLszTiA5JFU3EaTi_f142tDRej6rSMk=gCWitnqC2tb8d_vtQ@mail.gmail.com>
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


--BwRchxss3G+bi+a5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 01:39:46PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 21 Jun 2024 at 13:26, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Jun 21, 2024 at 12:19:12PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 21 Jun 2024 at 09:22, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Jun 21, 2024 at 08:57:50AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 20 Jun 2024 at 17:30, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Jun 20, 2024 at 05:05:30PM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Thu, 20 Jun 2024 at 08:32, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Thu, Jun 20, 2024 at 07:19:35AM -0600, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > The Python virtualenv tool sets up a few things in the en=
vronment,
> > > > > > > > > putting its path first in the PATH environment variable a=
nd setting up
> > > > > > > > > a sys.prefix different from the sys.base_prefix value.
> > > > > > > > >
> > > > > > > > > At present buildman puts the toolchain path first in PATH=
 so that it can
> > > > > > > > > be found easily during the build. For sandbox this causes=
 problems since
> > > > > > > > > /usr/bin/gcc (for example) results in '/usr/bin' being pr=
epended to the
> > > > > > > > > PATH variable. As a result, the venv is partially disable=
d.
> > > > > > > > >
> > > > > > > > > The result is that sandbox builds within a venv ignore th=
e venv, e.g.
> > > > > > > > > when looking for packages.
> > > > > > > > >
> > > > > > > > > Correct this by detecting the venv and adding the toolcha=
in path after
> > > > > > > > > the venv path.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > >
> > > > > > > > Why are we using PATH at all in this case? Shouldn't we jus=
t be setting
> > > > > > > > CROSS_COMPILE=3D/full/path/to/the/prefix ?
> > > > > > >
> > > > > > > This is the -p option to buildman. The original commit was:
> > > > > > >
> > > > > > > commit bb1501f2c22c979961b735db775605cccedd98f6
> > > > > > > Author: Simon Glass <sjg@chromium.org>
> > > > > > > Date:   Mon Dec 1 17:34:00 2014 -0700
> > > > > > >
> > > > > > >     buildman: Add an option to use the full tool chain path
> > > > > > >
> > > > > > >     In some cases there may be multiple toolchains with the s=
ame name in the
> > > > > > >     path. Provide an option to use the full path in the CROSS=
_COMPILE
> > > > > > >     environment variable.
> > > > > > >
> > > > > > >     Note: Wolfgang mentioned that this is dangerous since in =
some cases there
> > > > > > >     may be other tools on the path that are needed. So this i=
s set up as an
> > > > > > >     option, not the default. I will need test confirmation (i=
=2Ee. that this
> > > > > > >     commit fixes a real problem) before merging it.
> > > > > > >
> > > > > > > As to why we don't always do this, well that is back in the m=
ists of
> > > > > > > time, 10 years ago.
> > > > > > >
> > > > > > > BTW, this is raising a point ("let's change the behaviour") s=
eparate
> > > > > > > from the goal of this commit, which is to fix a problem with =
venv,
> > > > > > > albeit that if we made -p the only option, then we could pote=
ntially
> > > > > > > drop all PATH changes. Perhaps toolchains are built different=
ly now,
> > > > > > > such that they always invoke their tools using the same prefi=
x and
> > > > > > > dir?
> > > > > >
> > > > > > Wait, I'm confused. buildman internally updates its own PATH to=
 avoid
> > > > > > calling CROSS_COMPILE with the full path due to a concern about
> > > > > > toolchain bugs?
> > > > >
> > > > > Not its own PATH: the one it passes to U-Boot's 'make'.
> > > >
> > > > OK, but the point stands.
> > > >
> > > > > I'm not sure why, actually. It is such a long time ago that I don=
't remember.
> > > > >
> > > > > I see:
> > > > >
> > > > > ~/.buildman-toolchains/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/ar=
m-linux-gnueabi-ld
> > > >
> > > > Yes, prefixed version that's allowed to be called by users.
> > > >
> > > > > and
> > > > >
> > > > > ~/.buildman-toolchains/gcc-13.2.0-nolibc/arm-linux-gnueabi/arm-li=
nux-gnueabi/bin/ld
> > > >
> > > > Internal usage, here be dragons and all that.
> > > >
> > > > > but interestingly there is no gcc in the latter directory, which =
there
> > > > > was in 4.6 (and presumably for some time after).
> > > > >
> > > > > Certainly for sandbox there is no prefix, so we cannot add it in =
that
> > > > > case, and sandbox is actually the arch used to run these tests.
> > > >
> > > > CROSS_COMPILE is empty for sandbox, yes.
> > > >
> > > > > What are you suggesting we change about this patch?
> > > >
> > > > That it's going about things backwards? If you're setting CROSS_COM=
PILE
> > > > _then_ it should be the full path that it already knows otherwise i=
f not
> > > > setting CROSS_COMPILE then also not modifying PATH.
> > >
> > > That is what the code does, yes. It either adds the toolchain path to
> > > CROSS_COMPILE or to PATH, not both. The 'full_path' argument controls
> > > which one it uses.
> >
> > I'm saying it should always use the full path to CROSS_COMPILE and never
> > modify PATH.
>=20
> That wouldn't work with toolchains that don't have a prefix, though.
> If that is what you want I'm happy to modify the patch.

Yes, thanks.

--=20
Tom

--BwRchxss3G+bi+a5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ15zUACgkQFHw5/5Y0
tyykcAv8DtF3Fxyamt8pPLQHQ9S7Dw0SpjecyvKxJvnIRvXTyKk45sBdjTq5+NV0
yOQGk9iCWaIKQhFhBo7zIOc60X5jhWR9FIPnjclFlVbPOTb+DxNm3fOFbwIq+Bbi
YYWpSf0qC3gOvRQkSuo/qGojblrKpfwLkyS+UCM90FeYTGDRxHiOGtJAWU7T7dci
es3CsmCdvJftFN8lCtFu82MCOkqG62qP3/zhoCUe7Ju3S2UMczN9D7NbHPjVsovT
PIWFFmmQfPGN1/RJ/rT/qScyldERU+mM0ZeUKd8+pwDeprPyAh8X4admJqB6jURe
ulS0KcpD/Atd+W4hDbBzFc1YDLN3ehhRcwsOIkZyHtEBWq85WPj+YYsg2MQZNxi2
/4ripg45ZZmYVcJz7ya1fsNPOMdgB5YPYBcOMmdv28J68KC1W0tGfnrAWnZqMZTI
pb+KN1Y/DPUn9mW01djKYS/KjqrGP3eLhiWlCg11oSeX71hKz8zZBmai2RSDJ1UI
JENr7/p2
=ASBn
-----END PGP SIGNATURE-----

--BwRchxss3G+bi+a5--
