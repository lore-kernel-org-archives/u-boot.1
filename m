Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6CFC004C0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 18:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E82CE87653;
	Sat, 21 Oct 2023 20:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NAchi20n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2CD287654; Sat, 21 Oct 2023 20:34:46 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DE538764E
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 20:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-66d03491a1eso10509686d6.2
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 11:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697913281; x=1698518081; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZH0wddT11mLH06GqpK3ctXHnRczZZ1seaE1EvQ6/ocQ=;
 b=NAchi20nc7cuzAmJ4GY23GVEQS9PEN6CaGGeD2r6p+rwN+178ZR6SMvT0fpMPV33Ng
 ArF1OpjJ1cYWjSkc7M/faAENDr5uS0dDWGVdPF+LJeducTg5dY5ZF1RWGM0tJI/dcjlf
 WqkPwf/jOQFjqONi4P7+/BLE2AqM8XRmyl8Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697913281; x=1698518081;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZH0wddT11mLH06GqpK3ctXHnRczZZ1seaE1EvQ6/ocQ=;
 b=RBPj95Qpkje3lame/C18thUxGPUTo5Da3GMU28lRAVf86tnAGR0DzigJxNOvkB4d4v
 2ZJhhkQRBtTUuZBhlNmopwiR8bUsAQRwnpkqLiDFLTMfy1bNZv1fDu/zpnfIZo8K+ETe
 3qHjjP0mDMdb2z0dxECiOBlyA+MhH4wA0UQ6+ohbsaP5TChKAQl9J/+ZRvZSs/3TGdDa
 alhI+AM0I6M3d7pFG958vtB0bKIeV/yek4PoUHbhG9eO1M2QgYDsKE1UCZ2jOSTTex5q
 rVMy91KsnMzc74ev1Z4kDSKp49On4KjokDTWWnzhnIpMa1iRd+8J5w6vTmScKNLZ53GW
 Jcww==
X-Gm-Message-State: AOJu0YwS/rKD+dVBjp0+IUu2tsPlIHsGLWFm/o3n/ClTGcitwaIBHfYZ
 upzJtzNZhLDYK8LOzbt2Qj9dZqoc5MA7gQ1NBbJg0w==
X-Google-Smtp-Source: AGHT+IE9Kd+XaGwLpCrnxKSxT5rtKcaewLRNa2fnAMv0UGDdUIMg+j1Uf8T/bLWU8LMQPxOG6mZpKA==
X-Received: by 2002:a05:6214:2525:b0:66d:59da:d225 with SMTP id
 gg5-20020a056214252500b0066d59dad225mr6045375qvb.15.1697913280815; 
 Sat, 21 Oct 2023 11:34:40 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d02f-b9d9-0a79-793c.res6.spectrum.com.
 [2603:6081:7b00:6400:d02f:b9d9:a79:793c])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a05621411ac00b0066d5220d860sm1628725qvv.18.2023.10.21.11.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 11:34:39 -0700 (PDT)
Date: Sat, 21 Oct 2023 14:34:38 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [v4.1 2/2] CI, pytest: Add a test for sandbox without LTO
Message-ID: <20231021183438.GB53397@bill-the-cat>
References: <20231019150105.714407-24-trini@konsulko.com>
 <20231020215302.3511807-1-trini@konsulko.com>
 <20231020215302.3511807-2-trini@konsulko.com>
 <CAPnjgZ2jgfJ4GXR+2qt5Qi=MOc=kubLrMLgYBGuO_trinUHnag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M/Cv/5U1rSCnljzf"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2jgfJ4GXR+2qt5Qi=MOc=kubLrMLgYBGuO_trinUHnag@mail.gmail.com>
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


--M/Cv/5U1rSCnljzf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 21, 2023 at 08:43:00AM -0700, Simon Glass wrote:
> On Fri, 20 Oct 2023 at 14:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > The primary motivation for having a sandbox without LTO build in CI is
> > to ensure that we don't have that option break. We now have the ability
> > to run tests of specific options being enabled/disabled, so drop the
> > parts of CI that build and test that configuration specifically and add
> > a build test instead. We still test that "NO_LTO=3D1" rather than editi=
ng
> > the config file works via the ftrace tests.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > This creates a small bisectability gap in CI itself, but I think is more
> > reasonable than reworking the introduction of
> > test/py/tests/test_sandbox_opts.py
> >
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> >  .azure-pipelines.yml               |  3 ---
> >  .gitlab-ci.yml                     | 12 ------------
> >  test/py/tests/test_sandbox_opts.py | 10 ++++++++++
> >  3 files changed, 10 insertions(+), 15 deletions(-)
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> Q below
>=20
> >
> > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > index 6f91553e8613..65533b36dde4 100644
> > --- a/.azure-pipelines.yml
> > +++ b/.azure-pipelines.yml
> > @@ -287,9 +287,6 @@ stages:
> >          sandbox64_clang:
> >            TEST_PY_BD: "sandbox64"
> >            OVERRIDE: "-O clang-16"
> > -        sandbox_nolto:
> > -          TEST_PY_BD: "sandbox"
> > -          BUILD_ENV: "NO_LTO=3D1"
> >          sandbox_spl:
> >            TEST_PY_BD: "sandbox_spl"
> >            TEST_PY_TEST_SPEC: "test_ofplatdata or test_handoff or test_=
spl"
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index 6decdfdee334..97c964fb8079 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -258,12 +258,6 @@ sandbox with clang test.py:
> >      OVERRIDE: "-O clang-16"
> >    <<: *buildman_and_testpy_dfn
> >
> > -sandbox without LTO test.py:
> > -  variables:
> > -    TEST_PY_BD: "sandbox"
> > -    BUILD_ENV: "NO_LTO=3D1"
> > -  <<: *buildman_and_testpy_dfn
> > -
> >  sandbox64 test.py:
> >    variables:
> >      TEST_PY_BD: "sandbox64"
> > @@ -275,12 +269,6 @@ sandbox64 with clang test.py:
> >      OVERRIDE: "-O clang-16"
> >    <<: *buildman_and_testpy_dfn
> >
> > -sandbox64 without LTO test.py:
> > -  variables:
> > -    TEST_PY_BD: "sandbox64"
> > -    BUILD_ENV: "NO_LTO=3D1"
> > -  <<: *buildman_and_testpy_dfn
> > -
> >  sandbox_spl test.py:
> >    variables:
> >      TEST_PY_BD: "sandbox_spl"
> > diff --git a/test/py/tests/test_sandbox_opts.py b/test/py/tests/test_sa=
ndbox_opts.py
> > index 91790b3374b4..422b43cb3bc1 100644
> > --- a/test/py/tests/test_sandbox_opts.py
> > +++ b/test/py/tests/test_sandbox_opts.py
> > @@ -18,3 +18,13 @@ def test_sandbox_cmdline(u_boot_console):
> >      out =3D util.run_and_log(
> >          cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
> >                 '-a', '~CMDLINE', '-o', TMPDIR])
> > +
> > +@pytest.mark.slow
> > +@pytest.mark.boardspec('sandbox')
> > +def test_sandbox_lto(u_boot_console):
> > +    """Test building sandbox without CONFIG_LTO"""
> > +    cons =3D u_boot_console
> > +
> > +    out =3D util.run_and_log(
> > +        cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
> > +               '-a', '~LTO', '-o', TMPDIR])
>=20
> Don't you need sandbox64 here?

No, I don't think it's providing further value to just build sandbox64
without LTO. I'm also not 100% sure this patch is really needed in that we'=
re
trying to test for "did we disable LTO via make arguments" and in turn
only the ftrace test really catches that, as it will fail if we do have
LTO enabled, yes?

--=20
Tom

--M/Cv/5U1rSCnljzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU0Gb4ACgkQFHw5/5Y0
tyyX3AwAkmUUQe5vVD1L9XJe6rDL3PxZftJyDl6AExdBQ+WFtPb0eZ86z5dwKPoh
imlIjeoVwTghxGEinjEFhh3MpbfuG1KZz/THPvANrY1nyVYmRzZPGRoEeeAkI0kB
Q3sP5qCzujvG+81AQMsk4b3RShYod1WpAU9rAfkeyyZqsDs+YujjBlsHZwysJ8Bb
TGyhB4BgTLHBCR74ae22lKLl8erxmLi+gD7T84n8vYP16DaZDOI3Q9+rpqMVco7+
IueYolOWMFfJ5Pt0WFar9q2DrPW3aF8G2BaefoNjQ8iuMwiVHw4KscKle1mPuE9w
zOoMi2ORP1nSG7p77TmjZDRkDclFsnvigpqcfLdJI2IFV5AWbzCUffBKxnxz5Abd
6+rXLbjUneJ2DnLQvm7kiRkFJ1H3HX53Gs90zDaQ8Vlzc1ltQabbx/fIbEf0NBrR
vmgCEfGVyfmeAiMExfknVbJ9cqr52NtIWx/el2kU2msCjZYPEA8qp1jd1+8BsuSY
hnNtcYlA
=NgtR
-----END PGP SIGNATURE-----

--M/Cv/5U1rSCnljzf--
