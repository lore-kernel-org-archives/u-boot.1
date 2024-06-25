Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AAFC2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 14:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 275BD88452;
	Tue, 25 Jun 2024 16:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fcukRuc6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFF2788464; Tue, 25 Jun 2024 16:14:24 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E50488356
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 16:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-24cbb884377so2787773fac.0
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 07:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719324861; x=1719929661; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Sau0zfAuS6BweceMEHZiXzjAE9I+mql+FM0F6CC/vAU=;
 b=fcukRuc6ZUr626X5RW77ZERvbocR/isPsldTf5llR0uKJFdACkU6Gjnf0V+UWVjP+o
 v6e5o9EOy0GXGSk7fThEadfTt97zaNd1CWj6FG4BhIbc4B1d4S8KDvGnkTxENilZpzwj
 IoRrYDoJoVcLR+EOUIwDSHcZC05Qzd6ZBd/ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719324861; x=1719929661;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sau0zfAuS6BweceMEHZiXzjAE9I+mql+FM0F6CC/vAU=;
 b=p84GTdotnWB0/kLpsMN4x2pUhncdQYrdwB5IuK5Za2DST4+CuAZ3Sj/yOz3X10+dZc
 /jLK032ys9gApt9TVpQnAnkKZx/72Zb0CaY9XdQa8j8pjLDK3maj6kgrOcdguR1mwVYd
 47/Vl95imbA59L3YNjyWhobmaQW8Ds+MaYJVP3yH2H1dJszc6z2r5G3vaDZ+XX9m8v4W
 20LiwT+W+Ao1v9O6sKAvkqlPjdtW2ahzXX8b8IJ2QVFWVnWHfatw1LXecc3tVeiwTHNx
 cp9+DELEcG/QlSc0M4Hvr77MhoEbWgCDkWVxUFZcyboo9zV4PkPgnfKO8WY9NEnbvbf4
 Xn2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXPLmVcfLRIVxp9FLUWvXjnjcsW9aE+hFBlLlTe5mFAZZSZLQMzPS5LNFoGTyulWD0OhV0HmBR4rP7hCCeXWYMJjlxRA==
X-Gm-Message-State: AOJu0YzDLtf7v9DqgEFIEl7zRX5hcZD7171FuyXWlq9XBADYgypfuilO
 3nS+EShP9m2eYlDIOJ7UPtWZUssnZKeY3UdxcP1MUGfFPxgwTeYIcC98foWjdzw=
X-Google-Smtp-Source: AGHT+IGs4l3Gz51+mV2gIObEt5eGkivO2f2uP74AZeK2J3gSDmiJqN06a/iLkX9/2s3Xq4E9tiPqAg==
X-Received: by 2002:a05:6870:96a1:b0:254:bf41:de9d with SMTP id
 586e51a60fabf-25d06e8c2a2mr8210658fac.48.1719324861120; 
 Tue, 25 Jun 2024 07:14:21 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25cd4b80c52sm2458413fac.43.2024.06.25.07.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 07:14:20 -0700 (PDT)
Date: Tue, 25 Jun 2024 08:14:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 25/42] test: Allow connecting to a running board
Message-ID: <20240625141417.GN38804@bill-the-cat>
References: <20240611200156.2245525-1-sjg@chromium.org>
 <20240611200156.2245525-26-sjg@chromium.org>
 <ZnoHs6YiQlsoUWrL@toradex.com>
 <CAFLszTiR6oabXzbrjC4DTvJM11HfSyMZSergdA1=isWY1pVeOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R59ZPj0SUJL1E9r9"
Content-Disposition: inline
In-Reply-To: <CAFLszTiR6oabXzbrjC4DTvJM11HfSyMZSergdA1=isWY1pVeOQ@mail.gmail.com>
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


--R59ZPj0SUJL1E9r9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 01:31:19PM +0100, Simon Glass wrote:
> Hi Andrejs,
>=20
> On Tue, 25 Jun 2024 at 00:56, Andrejs Cainikovs
> <andrejs.cainikovs@toradex.com> wrote:
> >
> > On Tue, Jun 11, 2024 at 02:01:39PM -0600, Simon Glass wrote:
> > > Sometimes we know that the board is already running the right softwar=
e,
> > > so provide an option to allow running of tests directly, without first
> > > resetting the board.
> > >
> > > This saves time when re-running a test where only the Python code is
> > > changing.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  test/py/conftest.py                   |  3 +++
> > >  test/py/u_boot_console_base.py        | 14 ++++++++++----
> > >  test/py/u_boot_console_exec_attach.py | 21 ++++++++++++---------
> > >  3 files changed, 25 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > > index fc9dd3a83f8..ca66b9d9e61 100644
> > > --- a/test/py/conftest.py
> > > +++ b/test/py/conftest.py
> > > @@ -79,6 +79,8 @@ def pytest_addoption(parser):
> > >      parser.addoption('--gdbserver', default=3DNone,
> > >          help=3D'Run sandbox under gdbserver. The argument is the cha=
nnel '+
> > >          'over which gdbserver should communicate, e.g. localhost:123=
4')
> > > +    parser.addoption('--no-prompt-wait', default=3DFalse, action=3D'=
store_true',
> > > +        help=3D"Assume that U-Boot is ready and don't wait for a pro=
mpt")
> > >
> > >  def run_build(config, source_dir, build_dir, board_type, log):
> > >      """run_build: Build U-Boot
> > > @@ -238,6 +240,7 @@ def pytest_configure(config):
> > >      ubconfig.board_type =3D board_type
> > >      ubconfig.board_identity =3D board_identity
> > >      ubconfig.gdbserver =3D gdbserver
> > > +    ubconfig.no_prompt_wait =3D config.getoption('no_prompt_wait')
> > >      ubconfig.dtb =3D build_dir + '/arch/sandbox/dts/test.dtb'
> > >
> > >      env_vars =3D (
> > > diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_=
base.py
> > > index e4f86f6af5b..a61eec31148 100644
> > > --- a/test/py/u_boot_console_base.py
> > > +++ b/test/py/u_boot_console_base.py
> > > @@ -413,11 +413,17 @@ class ConsoleBase(object):
> > >              if not self.config.gdbserver:
> > >                  self.p.timeout =3D TIMEOUT_MS
> > >              self.p.logfile_read =3D self.logstream
> > > -            if expect_reset:
> > > -                loop_num =3D 2
> > > +            if self.config.no_prompt_wait:
> > > +                # Send an empty command to set up the 'expect' logic=
=2E This has
> > > +                # the side effect of ensuring that there was no part=
ial command
> > > +                # line entered
> > > +                self.run_command(' ')
> > >              else:
> > > -                loop_num =3D 1
> > > -            self.wait_for_boot_prompt(loop_num =3D loop_num)
> > > +                if expect_reset:
> > > +                    loop_num =3D 2
> > > +                else:
> > > +                    loop_num =3D 1
> > > +                self.wait_for_boot_prompt(loop_num =3D loop_num)
> >
> > Hi Simon,
> >
> > I had a very bad day, so here you go:
> >
> > =3D=3D ?
>=20
> What does this mean? I hope you have a good day today.

I _think_ this one is that "self.wait_for_boot_prompt(loop_num =3D
loop_num)" should be "self.wait_for_boot_prompt(loop_num =3D=3D loop_num)" ?

--=20
Tom

--R59ZPj0SUJL1E9r9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ60LYACgkQFHw5/5Y0
tyyjLwv9H8qo9sCXbz+ZTIfWz3Yj+vWVpM0TWvOstAER9h8J2Hbv88RD8+FP70/j
3emOydunLwt5MlFAEz9DzjFeeXCHkhEH55C6RtTYoCJukuj2Zme62zN+IvlHu/xE
XOXtC5iYWlDVsvcqsIlTYRV/r9Pjp/FIYt6zy3d8ULjG+sHnBQpn9JiVgUjbhbFB
up91SqXabi6+uzLrlldFCYuh12k6aJ6gYFJ5NIaFv3RpBfULcUVQVerhYvIGFa6n
pJzQTpFp8WBOblK8/Ys9ByQ+Qy+xEX+iEZgnvvb521G2jHlFGDxOGidMF/956Lnk
h42Tu7VDWXrJr5/OO62tPWg44GR8m3pVe8niMklVgzZgzi+TNUSj4MSSoQoGP8fw
wMXCWmvH2M1YZnoybFwOLKKOedrMJuhDgLTR5XDuwWPXPXgPl0zHrIWDJJcdTQtx
VEutwVi78ZkH+6ISlxSTuvx3eRICxqmvY1l8fL0+ma9biP9IJo7fvartpdRg24Xt
51wkb5fM
=tzKd
-----END PGP SIGNATURE-----

--R59ZPj0SUJL1E9r9--
