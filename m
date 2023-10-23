Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3B0C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:37:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0421587902;
	Mon, 23 Oct 2023 15:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QWHsgHjK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28C6F8790E; Mon, 23 Oct 2023 15:37:36 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA16287853
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d9beb865a40so3048087276.1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698068252; x=1698673052; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AkLlg+WHuCBeIvWUuuC2p9iR1LOyx0qjAUqSScDmM3w=;
 b=QWHsgHjKzteyS05G6WENnziAyEwHF6bzT/UPFI97MZ65PO92hV5jvtzGNhsUAxdiuB
 5XeIUjztzoAP12fnux13a+qk6tblDC7j5xOnZLFhu9+MPvQi+mkruZ1pxBf5Eg9i3wCR
 xk5+KDDbFVxvr5frko9Ocy3os2t7U8xl+CV4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698068252; x=1698673052;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AkLlg+WHuCBeIvWUuuC2p9iR1LOyx0qjAUqSScDmM3w=;
 b=CfNDinZ47iNPtZQakWzcqszSqzT/s3s62/tdMiD63gB/5iJSQXx9ARIGqkG3bekiDU
 LG6BS5/n+81Z3UPEpKIE+YTlKubk29pqpyyEGaOzpr4NL8I20IgHK4BQkMNUMEDHdCcU
 fgABuJhQyQcPrWJ5GfphoxjAXg5orJbFvOqKoRa5rLF9GzX1L6J455WvnLzZ/In/TPeH
 Zu/7D5/5SkloixYF9mKaMRyh8DM0p3TzsIsC8e39OL2fuypLAXmMLy/ObcSMbcVDAhZN
 EXeNfUmQIzFbPpqg7dYRDeGf9bf1Q7tqK1BExrpxddUfCWIdYhEFTiepCsBAjZGEv6hO
 I4zQ==
X-Gm-Message-State: AOJu0YyqJjTk7s6M2D+V1aUf6nT7NrV2/3skitRkO5D2d0LtXofQel7c
 1vQ0oyXfyC1bJnUe7u94briWnA==
X-Google-Smtp-Source: AGHT+IEnEt3x5p/EjA0sJFwby/qWlft3yN0qNvCISUqx+p38qeQmXtDY60TWwv8sQpwAmp4p83f05w==
X-Received: by 2002:a25:943:0:b0:d9a:4ae7:ba2c with SMTP id
 u3-20020a250943000000b00d9a4ae7ba2cmr8243196ybm.22.1698068252553; 
 Mon, 23 Oct 2023 06:37:32 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 16-20020a250910000000b00d749bc5b169sm2699408ybj.43.2023.10.23.06.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 06:37:31 -0700 (PDT)
Date: Mon, 23 Oct 2023 09:37:28 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [v4.1 2/2] CI, pytest: Add a test for sandbox without LTO
Message-ID: <20231023133728.GH496310@bill-the-cat>
References: <20231019150105.714407-24-trini@konsulko.com>
 <20231020215302.3511807-1-trini@konsulko.com>
 <20231020215302.3511807-2-trini@konsulko.com>
 <CAPnjgZ2jgfJ4GXR+2qt5Qi=MOc=kubLrMLgYBGuO_trinUHnag@mail.gmail.com>
 <20231021183438.GB53397@bill-the-cat>
 <CAPnjgZ2bKVTwEKcjeawootxXr-+iEmiowtctA52-=v07p+xBUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4z2UnihlTfPmbDSn"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2bKVTwEKcjeawootxXr-+iEmiowtctA52-=v07p+xBUQ@mail.gmail.com>
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


--4z2UnihlTfPmbDSn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 12:05:34AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 21 Oct 2023 at 11:34, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Oct 21, 2023 at 08:43:00AM -0700, Simon Glass wrote:
> > > On Fri, 20 Oct 2023 at 14:53, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > The primary motivation for having a sandbox without LTO build in CI=
 is
> > > > to ensure that we don't have that option break. We now have the abi=
lity
> > > > to run tests of specific options being enabled/disabled, so drop the
> > > > parts of CI that build and test that configuration specifically and=
 add
> > > > a build test instead. We still test that "NO_LTO=3D1" rather than e=
diting
> > > > the config file works via the ftrace tests.
> > > >
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > This creates a small bisectability gap in CI itself, but I think is=
 more
> > > > reasonable than reworking the introduction of
> > > > test/py/tests/test_sandbox_opts.py
> > > >
> > > > Cc: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >  .azure-pipelines.yml               |  3 ---
> > > >  .gitlab-ci.yml                     | 12 ------------
> > > >  test/py/tests/test_sandbox_opts.py | 10 ++++++++++
> > > >  3 files changed, 10 insertions(+), 15 deletions(-)
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > Q below
> > >
> > > >
> > > > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > > > index 6f91553e8613..65533b36dde4 100644
> > > > --- a/.azure-pipelines.yml
> > > > +++ b/.azure-pipelines.yml
> > > > @@ -287,9 +287,6 @@ stages:
> > > >          sandbox64_clang:
> > > >            TEST_PY_BD: "sandbox64"
> > > >            OVERRIDE: "-O clang-16"
> > > > -        sandbox_nolto:
> > > > -          TEST_PY_BD: "sandbox"
> > > > -          BUILD_ENV: "NO_LTO=3D1"
> > > >          sandbox_spl:
> > > >            TEST_PY_BD: "sandbox_spl"
> > > >            TEST_PY_TEST_SPEC: "test_ofplatdata or test_handoff or t=
est_spl"
> > > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > index 6decdfdee334..97c964fb8079 100644
> > > > --- a/.gitlab-ci.yml
> > > > +++ b/.gitlab-ci.yml
> > > > @@ -258,12 +258,6 @@ sandbox with clang test.py:
> > > >      OVERRIDE: "-O clang-16"
> > > >    <<: *buildman_and_testpy_dfn
> > > >
> > > > -sandbox without LTO test.py:
> > > > -  variables:
> > > > -    TEST_PY_BD: "sandbox"
> > > > -    BUILD_ENV: "NO_LTO=3D1"
> > > > -  <<: *buildman_and_testpy_dfn
> > > > -
> > > >  sandbox64 test.py:
> > > >    variables:
> > > >      TEST_PY_BD: "sandbox64"
> > > > @@ -275,12 +269,6 @@ sandbox64 with clang test.py:
> > > >      OVERRIDE: "-O clang-16"
> > > >    <<: *buildman_and_testpy_dfn
> > > >
> > > > -sandbox64 without LTO test.py:
> > > > -  variables:
> > > > -    TEST_PY_BD: "sandbox64"
> > > > -    BUILD_ENV: "NO_LTO=3D1"
> > > > -  <<: *buildman_and_testpy_dfn
> > > > -
> > > >  sandbox_spl test.py:
> > > >    variables:
> > > >      TEST_PY_BD: "sandbox_spl"
> > > > diff --git a/test/py/tests/test_sandbox_opts.py b/test/py/tests/tes=
t_sandbox_opts.py
> > > > index 91790b3374b4..422b43cb3bc1 100644
> > > > --- a/test/py/tests/test_sandbox_opts.py
> > > > +++ b/test/py/tests/test_sandbox_opts.py
> > > > @@ -18,3 +18,13 @@ def test_sandbox_cmdline(u_boot_console):
> > > >      out =3D util.run_and_log(
> > > >          cons, ['./tools/buildman/buildman', '-m', '--board', 'sand=
box',
> > > >                 '-a', '~CMDLINE', '-o', TMPDIR])
> > > > +
> > > > +@pytest.mark.slow
> > > > +@pytest.mark.boardspec('sandbox')
> > > > +def test_sandbox_lto(u_boot_console):
> > > > +    """Test building sandbox without CONFIG_LTO"""
> > > > +    cons =3D u_boot_console
> > > > +
> > > > +    out =3D util.run_and_log(
> > > > +        cons, ['./tools/buildman/buildman', '-m', '--board', 'sand=
box',
> > > > +               '-a', '~LTO', '-o', TMPDIR])
> > >
> > > Don't you need sandbox64 here?
> >
> > No, I don't think it's providing further value to just build sandbox64
> > without LTO. I'm also not 100% sure this patch is really needed in that=
 we're
> > trying to test for "did we disable LTO via make arguments" and in turn
> > only the ftrace test really catches that, as it will fail if we do have
> > LTO enabled, yes?
>=20
> Really the test is to make sure that sandbox builds without LTO. With
> the build time being. For development, LTO serves no useful purpose
> and just triples the incremental build time.
>=20
> I suggest we keep sandbox64 just to prevent a regression on non-LTO,
> but I suspect it is unlikely to happen in practice.

I don't follow you here. This adds the build time test for disabling
LTO, as that's at least an option for sandbox (other platforms require
it because otherwise we won't fit on the hardware). I'm mainly not sure
if this test is right in that what we really want to know is "does
NO_LTO=3D1" pass things as expected, and the ftrace test covers that.

--=20
Tom

--4z2UnihlTfPmbDSn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2dxUACgkQFHw5/5Y0
tyyaRAwAjCRf54q7lBugcPGN8h7aUnbbsCWhW1h9ozEER8Bx+Hv05yoWr7Ck1jUQ
uP/i58vFF+8B3ujxPTqt7mIHrsh5nYSE7nY6tDCoBOBGDmZqtPhLNguV6YdbR/ru
aX3u7lbOg0/EX0r4eUeu1n3DzQR/UyRFwSLbPt+nJgtqLAUWJiDg7f8I2gaBPEct
nN3nmmKoV6X0RLicu2BIi/pCdQiAnQqf6EiKmI1ZDS6xTO/anqj+DD7HVyBkDBMP
tKoBtC9OR6L2yCZQJzZnm2qRTDA/2L79jwDP9FazyOy3cBq1Tpr/cI5X9Yr5XN7g
EwDBiMn5XSEv6BN1yq8+okixf8Hlk72vi6orQJE8sV2lGwQPHfvRGdtalhjGenwR
i9hvpJpdEOarXmyefSueH8jtyh0QQvKAKj30YGp5pIaiAo1XFIGP3zKSFFM6qe6B
PRMGghlwp7uALtLwN9AfCNmzCKyAXVmCidM+Rtr3oVkTFXlpj5GykE/HWlBFsYrS
hBbiiHjA
=Np6R
-----END PGP SIGNATURE-----

--4z2UnihlTfPmbDSn--
