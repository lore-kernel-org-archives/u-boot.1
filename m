Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177D1C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A807874BD;
	Mon, 23 Oct 2023 09:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e/tM1zLs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA087871A2; Mon, 23 Oct 2023 09:05:48 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEC37874BD
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9ada2e6e75fso440669366b.2
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698044746; x=1698649546; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HYa2P92nZQifV5u/+d10+fEuWv9TCopYB3HJ7P7QdaM=;
 b=e/tM1zLsq2VQ2kV8cWlYemgL7gHnNbUqEDmiKlqVR590Of9EwTR1hIkkkQphIwnPeS
 NWgRI0QW3laBCtWdaGjHMIjWxsmx7nIXL1ZoFvBDBXY0sTqL1e4Q/31qcRyGVFm/3fGT
 oMNdOOdpXFSkp8eloxhykvxR6TxaOEih8mt8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698044746; x=1698649546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HYa2P92nZQifV5u/+d10+fEuWv9TCopYB3HJ7P7QdaM=;
 b=A/EgNLCTpAmwMOLTRFs+QSQLF8C4Fa76A0S1E2cVZqDzu7AUIstGrQh5TNnG5sx+Vu
 eUwNzIZVIWB4B+RGHEiCl1ddKloYHjvz4u078iurL94TSQF3OIgv2zqoS2F1ayBinwES
 jwhpgy7fc+5P6xzWl2pVLezS3ygj22WGRHdzJE8MM9I5uQ0wWAVbfHC0NSlMGhezKan3
 UJh++MhOKshHEd1j66YCNTjYpZIQAzPUWZ0rwowgmcCl4SSDKkX7mV2IHLFVOUDZuakm
 8puUS5awwaL7iHAufyhrtpelHlU4UDppl/t+3DHkqBzQ3nI6fT8QvRXB2hA/h3IkHPmo
 wHuw==
X-Gm-Message-State: AOJu0YwYl6Qy14f+xBwUD3KWPwLIri2GDwlSefYv9xgiI5xfvnFRFRp8
 PEUV+nDZcugr++WqjPw9jr6nX0nq2OkEzow/HgkkJEi4B5TRG9lO6xzccGGB
X-Google-Smtp-Source: AGHT+IGAb8MbmUFuvoThdFhORT6z3OLGefz8DsVimJeakWbwXc/Yq6MHcQZtQM7LnH0OUuH9DgI5mREEIOOXmGtJDGg=
X-Received: by 2002:a17:907:d38a:b0:9ad:ef08:1f32 with SMTP id
 vh10-20020a170907d38a00b009adef081f32mr5291479ejc.37.1698044746237; Mon, 23
 Oct 2023 00:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231019150105.714407-24-trini@konsulko.com>
 <20231020215302.3511807-1-trini@konsulko.com>
 <20231020215302.3511807-2-trini@konsulko.com>
 <CAPnjgZ2jgfJ4GXR+2qt5Qi=MOc=kubLrMLgYBGuO_trinUHnag@mail.gmail.com>
 <20231021183438.GB53397@bill-the-cat>
In-Reply-To: <20231021183438.GB53397@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Oct 2023 00:05:34 -0700
Message-ID: <CAPnjgZ2bKVTwEKcjeawootxXr-+iEmiowtctA52-=v07p+xBUQ@mail.gmail.com>
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

On Sat, 21 Oct 2023 at 11:34, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Oct 21, 2023 at 08:43:00AM -0700, Simon Glass wrote:
> > On Fri, 20 Oct 2023 at 14:53, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > The primary motivation for having a sandbox without LTO build in CI is
> > > to ensure that we don't have that option break. We now have the ability
> > > to run tests of specific options being enabled/disabled, so drop the
> > > parts of CI that build and test that configuration specifically and add
> > > a build test instead. We still test that "NO_LTO=1" rather than editing
> > > the config file works via the ftrace tests.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > This creates a small bisectability gap in CI itself, but I think is more
> > > reasonable than reworking the introduction of
> > > test/py/tests/test_sandbox_opts.py
> > >
> > > Cc: Simon Glass <sjg@chromium.org>
> > > ---
> > >  .azure-pipelines.yml               |  3 ---
> > >  .gitlab-ci.yml                     | 12 ------------
> > >  test/py/tests/test_sandbox_opts.py | 10 ++++++++++
> > >  3 files changed, 10 insertions(+), 15 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Q below
> >
> > >
> > > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > > index 6f91553e8613..65533b36dde4 100644
> > > --- a/.azure-pipelines.yml
> > > +++ b/.azure-pipelines.yml
> > > @@ -287,9 +287,6 @@ stages:
> > >          sandbox64_clang:
> > >            TEST_PY_BD: "sandbox64"
> > >            OVERRIDE: "-O clang-16"
> > > -        sandbox_nolto:
> > > -          TEST_PY_BD: "sandbox"
> > > -          BUILD_ENV: "NO_LTO=1"
> > >          sandbox_spl:
> > >            TEST_PY_BD: "sandbox_spl"
> > >            TEST_PY_TEST_SPEC: "test_ofplatdata or test_handoff or test_spl"
> > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > index 6decdfdee334..97c964fb8079 100644
> > > --- a/.gitlab-ci.yml
> > > +++ b/.gitlab-ci.yml
> > > @@ -258,12 +258,6 @@ sandbox with clang test.py:
> > >      OVERRIDE: "-O clang-16"
> > >    <<: *buildman_and_testpy_dfn
> > >
> > > -sandbox without LTO test.py:
> > > -  variables:
> > > -    TEST_PY_BD: "sandbox"
> > > -    BUILD_ENV: "NO_LTO=1"
> > > -  <<: *buildman_and_testpy_dfn
> > > -
> > >  sandbox64 test.py:
> > >    variables:
> > >      TEST_PY_BD: "sandbox64"
> > > @@ -275,12 +269,6 @@ sandbox64 with clang test.py:
> > >      OVERRIDE: "-O clang-16"
> > >    <<: *buildman_and_testpy_dfn
> > >
> > > -sandbox64 without LTO test.py:
> > > -  variables:
> > > -    TEST_PY_BD: "sandbox64"
> > > -    BUILD_ENV: "NO_LTO=1"
> > > -  <<: *buildman_and_testpy_dfn
> > > -
> > >  sandbox_spl test.py:
> > >    variables:
> > >      TEST_PY_BD: "sandbox_spl"
> > > diff --git a/test/py/tests/test_sandbox_opts.py b/test/py/tests/test_sandbox_opts.py
> > > index 91790b3374b4..422b43cb3bc1 100644
> > > --- a/test/py/tests/test_sandbox_opts.py
> > > +++ b/test/py/tests/test_sandbox_opts.py
> > > @@ -18,3 +18,13 @@ def test_sandbox_cmdline(u_boot_console):
> > >      out = util.run_and_log(
> > >          cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
> > >                 '-a', '~CMDLINE', '-o', TMPDIR])
> > > +
> > > +@pytest.mark.slow
> > > +@pytest.mark.boardspec('sandbox')
> > > +def test_sandbox_lto(u_boot_console):
> > > +    """Test building sandbox without CONFIG_LTO"""
> > > +    cons = u_boot_console
> > > +
> > > +    out = util.run_and_log(
> > > +        cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
> > > +               '-a', '~LTO', '-o', TMPDIR])
> >
> > Don't you need sandbox64 here?
>
> No, I don't think it's providing further value to just build sandbox64
> without LTO. I'm also not 100% sure this patch is really needed in that we're
> trying to test for "did we disable LTO via make arguments" and in turn
> only the ftrace test really catches that, as it will fail if we do have
> LTO enabled, yes?

Really the test is to make sure that sandbox builds without LTO. With
the build time being. For development, LTO serves no useful purpose
and just triples the incremental build time.

I suggest we keep sandbox64 just to prevent a regression on non-LTO,
but I suspect it is unlikely to happen in practice.

Regards,
Simon
