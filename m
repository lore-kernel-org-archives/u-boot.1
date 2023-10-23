Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73293C25B45
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 17:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCB3C86F90;
	Mon, 23 Oct 2023 19:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HLDSlupr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFBDB87935; Mon, 23 Oct 2023 19:14:07 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7326887243
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 19:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-991c786369cso528577866b.1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 10:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698081245; x=1698686045; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UhVX5L9g7ACPiYY9vm/PiwrMxVp/Ra6aAqMTzGKsvOY=;
 b=HLDSlupr8HjzfHIJqW1WTzBRA4MlFMccOG/E2J3UcJUwBOnSEamL3qn/Lhha0kksW7
 edx4+bF9ybdNHcZJAl2JRI1vHnhKptwPOSiXb7nA8abYQfU8BM5uM/jFLbn4A0fGpBEI
 iD3E9bs9iJykTOLz1EVP1dNwmNiLpzP/PLEXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698081245; x=1698686045;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UhVX5L9g7ACPiYY9vm/PiwrMxVp/Ra6aAqMTzGKsvOY=;
 b=GXgpabTAiWhEP1WRndzk72/78hKcIeNYiO1ckLtzyg7Sz8Um0qhDeJ1HbUxwAlP46r
 kItvjnnuGdJg/IhRW0shei02W5tN3lc94KSLdRK2gr+Umk1Z9yE3K9uPpoXFnfK+JdJY
 QSKPAUYJjjQEMgTWyCoOaA9Uwp1Sc/JWoO6nkdKfnq+rCOiijA2dvH6oaiIrcRiQoVAc
 UwFhGGdr3Ic+6jTZCPHwU3merpvBWysha8RJF1hUkz03hRX0abU6ajwN46wl93dAhY+P
 XRfSKzfyJxoW6WOsrL1kMajx5ZMpGNht+kIO6UVaZRaA213BZbH3avc355xel4viSg4C
 sUjg==
X-Gm-Message-State: AOJu0Yxt/J+3rykhaDrbuKF1S5SEMK2mFtDupRHJ6pkb0VkMpu45Jc2u
 8OplPnPoANZw2dxpaJaEbn/5CQ/625w29HM7FI88L4Vz7dOFvPpICOiEhf2d
X-Google-Smtp-Source: AGHT+IHNsxsMsMts8zpZyJz5aZmrMVqRF6uVGcOA/19D0CnZIHJz49/L8W9zi4R259CGML5u9sQKUCFkh7OYSWeiA1k=
X-Received: by 2002:a17:907:7f88:b0:9bf:5df1:38d2 with SMTP id
 qk8-20020a1709077f8800b009bf5df138d2mr7300723ejc.3.1698081244730; Mon, 23 Oct
 2023 10:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231019150105.714407-24-trini@konsulko.com>
 <20231020215302.3511807-1-trini@konsulko.com>
 <20231020215302.3511807-2-trini@konsulko.com>
 <CAPnjgZ2jgfJ4GXR+2qt5Qi=MOc=kubLrMLgYBGuO_trinUHnag@mail.gmail.com>
 <20231021183438.GB53397@bill-the-cat>
 <CAPnjgZ2bKVTwEKcjeawootxXr-+iEmiowtctA52-=v07p+xBUQ@mail.gmail.com>
 <20231023133728.GH496310@bill-the-cat>
In-Reply-To: <20231023133728.GH496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Oct 2023 10:13:52 -0700
Message-ID: <CAPnjgZ06w+uaSZr6PWo6NFoWfxiNuu-bar4e3zn+bVL-4wPvUQ@mail.gmail.com>
Subject: Re: [v4.1 2/2] CI, pytest: Add a test for sandbox without LTO
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Mon, 23 Oct 2023 at 06:37, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 23, 2023 at 12:05:34AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 21 Oct 2023 at 11:34, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Oct 21, 2023 at 08:43:00AM -0700, Simon Glass wrote:
> > > > On Fri, 20 Oct 2023 at 14:53, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > The primary motivation for having a sandbox without LTO build in CI is
> > > > > to ensure that we don't have that option break. We now have the ability
> > > > > to run tests of specific options being enabled/disabled, so drop the
> > > > > parts of CI that build and test that configuration specifically and add
> > > > > a build test instead. We still test that "NO_LTO=1" rather than editing
> > > > > the config file works via the ftrace tests.
> > > > >
> > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > ---
> > > > > This creates a small bisectability gap in CI itself, but I think is more
> > > > > reasonable than reworking the introduction of
> > > > > test/py/tests/test_sandbox_opts.py
> > > > >
> > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >  .azure-pipelines.yml               |  3 ---
> > > > >  .gitlab-ci.yml                     | 12 ------------
> > > > >  test/py/tests/test_sandbox_opts.py | 10 ++++++++++
> > > > >  3 files changed, 10 insertions(+), 15 deletions(-)
> > > >
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > Q below
> > > >
> > > > >
> > > > > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > > > > index 6f91553e8613..65533b36dde4 100644
> > > > > --- a/.azure-pipelines.yml
> > > > > +++ b/.azure-pipelines.yml
> > > > > @@ -287,9 +287,6 @@ stages:
> > > > >          sandbox64_clang:
> > > > >            TEST_PY_BD: "sandbox64"
> > > > >            OVERRIDE: "-O clang-16"
> > > > > -        sandbox_nolto:
> > > > > -          TEST_PY_BD: "sandbox"
> > > > > -          BUILD_ENV: "NO_LTO=1"
> > > > >          sandbox_spl:
> > > > >            TEST_PY_BD: "sandbox_spl"
> > > > >            TEST_PY_TEST_SPEC: "test_ofplatdata or test_handoff or test_spl"
> > > > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > > index 6decdfdee334..97c964fb8079 100644
> > > > > --- a/.gitlab-ci.yml
> > > > > +++ b/.gitlab-ci.yml
> > > > > @@ -258,12 +258,6 @@ sandbox with clang test.py:
> > > > >      OVERRIDE: "-O clang-16"
> > > > >    <<: *buildman_and_testpy_dfn
> > > > >
> > > > > -sandbox without LTO test.py:
> > > > > -  variables:
> > > > > -    TEST_PY_BD: "sandbox"
> > > > > -    BUILD_ENV: "NO_LTO=1"
> > > > > -  <<: *buildman_and_testpy_dfn
> > > > > -
> > > > >  sandbox64 test.py:
> > > > >    variables:
> > > > >      TEST_PY_BD: "sandbox64"
> > > > > @@ -275,12 +269,6 @@ sandbox64 with clang test.py:
> > > > >      OVERRIDE: "-O clang-16"
> > > > >    <<: *buildman_and_testpy_dfn
> > > > >
> > > > > -sandbox64 without LTO test.py:
> > > > > -  variables:
> > > > > -    TEST_PY_BD: "sandbox64"
> > > > > -    BUILD_ENV: "NO_LTO=1"
> > > > > -  <<: *buildman_and_testpy_dfn
> > > > > -
> > > > >  sandbox_spl test.py:
> > > > >    variables:
> > > > >      TEST_PY_BD: "sandbox_spl"
> > > > > diff --git a/test/py/tests/test_sandbox_opts.py b/test/py/tests/test_sandbox_opts.py
> > > > > index 91790b3374b4..422b43cb3bc1 100644
> > > > > --- a/test/py/tests/test_sandbox_opts.py
> > > > > +++ b/test/py/tests/test_sandbox_opts.py
> > > > > @@ -18,3 +18,13 @@ def test_sandbox_cmdline(u_boot_console):
> > > > >      out = util.run_and_log(
> > > > >          cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
> > > > >                 '-a', '~CMDLINE', '-o', TMPDIR])
> > > > > +
> > > > > +@pytest.mark.slow
> > > > > +@pytest.mark.boardspec('sandbox')
> > > > > +def test_sandbox_lto(u_boot_console):
> > > > > +    """Test building sandbox without CONFIG_LTO"""
> > > > > +    cons = u_boot_console
> > > > > +
> > > > > +    out = util.run_and_log(
> > > > > +        cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
> > > > > +               '-a', '~LTO', '-o', TMPDIR])
> > > >
> > > > Don't you need sandbox64 here?
> > >
> > > No, I don't think it's providing further value to just build sandbox64
> > > without LTO. I'm also not 100% sure this patch is really needed in that we're
> > > trying to test for "did we disable LTO via make arguments" and in turn
> > > only the ftrace test really catches that, as it will fail if we do have
> > > LTO enabled, yes?
> >
> > Really the test is to make sure that sandbox builds without LTO. With
> > the build time being. For development, LTO serves no useful purpose
> > and just triples the incremental build time.
> >
> > I suggest we keep sandbox64 just to prevent a regression on non-LTO,
> > but I suspect it is unlikely to happen in practice.
>
> I don't follow you here. This adds the build time test for disabling
> LTO, as that's at least an option for sandbox (other platforms require
> it because otherwise we won't fit on the hardware). I'm mainly not sure
> if this test is right in that what we really want to know is "does
> NO_LTO=1" pass things as expected, and the ftrace test covers that.

OK, I see. Well let's run with it and see how we go. I have wanted to
have these sorts of tests for a while, so we can check combinations
that are not in common use.

BTW buildman supports -L which disabled LTO using the NO_LTO=1 option

Regards,
Simon
