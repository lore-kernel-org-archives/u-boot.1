Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FA4C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8447A88859;
	Mon, 29 Jul 2024 17:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jN/rXVnI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 831438885E; Mon, 29 Jul 2024 17:28:24 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6856288852
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6b79c969329so17013186d6.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266901; x=1722871701; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eWTRTWJ00oCoewk69efDRbZgYjXy6xdpaDOqR5hJay0=;
 b=jN/rXVnI9abZrEdZDPURc6FQpo87JEipXNDBXXZX1QcdfEQrk6ILXcE2ThId0izs61
 zn5eRxKUdVwWsc9Vtlx279n1qWkVnsESSmvFpT1mTXjnuK+UbidyFNXCjAhFf+DEX3iN
 UXEojtv+RIS9B8ZOzgAjsrzwvcEfGsfWiLHn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266901; x=1722871701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eWTRTWJ00oCoewk69efDRbZgYjXy6xdpaDOqR5hJay0=;
 b=ngY77+cf5/Bj5zq6YqsE2nhd+UDggyAHcQdNubHKbZq+Nwb4IbAfv8eLCShyEjRD50
 G6Y/2EYiREIxPPq/b0A3FS01qa1z89w86ZfILLL4qF/MP0kmmmIjgBS3TWqVd5Xo+oyb
 4kdQxurXc6BXkLi+OKCMuDS2AHRNzvXcWT4sfI00bT8+1BXbRDAFOyOTDlrnWWt+VuFq
 pfyYkMW92WH9DtxIPLZ2tkulITkloCTSgGEw63ygGWjod6VPQ2xnhr9zRNLVMid/C5TZ
 aIjw9LrqnOtn6d+pCf4wePTpGNDh3w15gyfG3lKmQGar9oVUjaS53NIorw7wN+5958x4
 gLMg==
X-Gm-Message-State: AOJu0Yy2KhuEeIuaV72mhfRWS8EL43ZHgchW51N0qC+X4L1BsHRz8Elg
 k58k+r41bAZ8pX0fcjsR75tTYMJU+CUt/E8yKP1XJsEdB5kvZKsCptuKmjUfnaYn6TTkOxjtNrr
 d0eE8eGUjXbnsUa86fZYDqe25I/agNDitfzEs
X-Google-Smtp-Source: AGHT+IHHqXYy6j0XVHJApgxxkEtKiysE10Pv8Mz5igw1R7/n0rLKtlQNkc4VRSPmOlQUl7z2nj8tH9c5zsPZgALRvbM=
X-Received: by 2002:a05:6214:e83:b0:6b0:7821:4026 with SMTP id
 6a1803df08f44-6bb55af157fmr110159866d6.52.1722266901411; Mon, 29 Jul 2024
 08:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-37-sughosh.ganu@linaro.org>
 <CAFLszTjQ011M-C+JNAPkFce2CEA5qofdm2TEtETndcU1k8vF5w@mail.gmail.com>
 <CADg8p964_oxktCBb2BF81MCpGQVUbPYh-e1yxjjUbBKr=cfOpw@mail.gmail.com>
In-Reply-To: <CADg8p964_oxktCBb2BF81MCpGQVUbPYh-e1yxjjUbBKr=cfOpw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:10 -0600
Message-ID: <CAFLszTgWYoz=Kd7EqUTU-CQEXYig9biwJ9UACeDOeNdbdkgXUw@mail.gmail.com>
Subject: Re: [PATCH 36/40] test: lmb: add a separate class of unit tests for
 lmb
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Mon, 29 Jul 2024 at 02:56, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 26 Jul 2024 at 05:03, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Wed, 24 Jul 2024 at 00:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Add the LMB unit tests under a separate class of tests. The LMB tests
> > > involve changing the LMB's memory map. With the memory map now
> > > persistent and global, running these tests has a side effect and
> > > impact any subsequent tests. Run these tests separately so that the
> > > system can be reset on completion of these tests.
> > >
> >
> > This is just not a good idea...we should fix the tests so they don't
> > have these side effects.
>
> But this test *will* have side-effects -- if we are making the lmb
> memory maps persistent, testing that code will have an impact. There
> is no getting around it. Btw, I got this idea based on how the VBE
> tests are run. This is similar to what is being done for the VBE
> tests.

You can set up the state before the test and restore it afterwards.
That is what we do with other tests and it is why you should have the
lmb state in a struct. See for example state_reset_for_test() which is
called if the test has a UT_TESTF_DM flag.

You can add a save/restore function (since you don't want a lmb pointer).

The _norun thing is because the tests are written in C but need some
Python setup. So the setup is done and then the test is run
immediately afterwards.

>
> As an aside, what issue do you see with running these tests separately?

They don't run with the 'ut' command so must be done specially. There
is no Python setup needed. We have DM tests which save and restore all
sorts of things...so we should do the same with lmb.


>
> -sughosh
>
> >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since rfc: None
> > >
> > >  include/test/suites.h        |  1 +
> > >  test/Kconfig                 |  9 ++++++
> > >  test/Makefile                |  1 +
> > >  test/cmd_ut.c                |  7 +++++
> > >  test/lib/Makefile            |  1 -
> > >  test/{lib/lmb.c => lmb_ut.c} | 53 ++++++++++++++++++++++--------------
> > >  6 files changed, 50 insertions(+), 22 deletions(-)
> > >  rename test/{lib/lmb.c => lmb_ut.c} (93%)

- Simon
