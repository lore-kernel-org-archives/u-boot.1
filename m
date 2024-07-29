Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD384C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 08:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 546BC882D6;
	Mon, 29 Jul 2024 10:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BGwdY2IF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB938887B9; Mon, 29 Jul 2024 10:56:48 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6965C88276
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f029e9c9cfso50323851fa.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 01:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722243405; x=1722848205; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kE1/bfDS4aJkfWaGaPcly/RhGkrF9npCiCWbQI5kEIQ=;
 b=BGwdY2IFJxBQVzq6wn3iZNrL/SwNMFsztpnTZZfW6EWOcx5iUg6CGOUG55s6BOkU1d
 zt1xHpUic7qEDaLfbriQ9GAXeW4ihWxVruDtnsFNFvXKUl9m/sD8koxzLepQgz62uZxk
 r7XIIYmGgYvRrsWTIApcpTWV2xwYHj767J2cEcdwGqyClHr0JVAu9V/cEoIZOt8dBka1
 PM8aQoL+loUaoAWWKjhQVkiQYjUX2QoAFcozblkAcjC3XVn9s3BobbAbr9pa528P9Yt7
 7cHbaftK1SSqtg34SAOn0+eimxkVf8rOUeI/lw167j9gStie3HUov6/5CnX3HAO+Gwd5
 1hSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722243405; x=1722848205;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kE1/bfDS4aJkfWaGaPcly/RhGkrF9npCiCWbQI5kEIQ=;
 b=P45O8UoEWlTibQj71RlU72Kj01qUaJv9TEhQ/7QcSQzRezHk8Pr/OoV7GMiBgcYt85
 mvuy8jH68PiexDCh0kcHZSnUwTOn2yjTBa9urdHb0elkJ+1JVU+RkxZlo6Id1EuFqmy9
 8ZnAhQP0r+SC5J0+RsnouQvk59eeKaVtEHDlGJgMYssEZvhG7u2ddMnKV1WdunPyOKOx
 0JVOiA+8T0kilLymkf/iXSme3Gu5rLYnL3lql+NXfneXTky9vyvd4l7iTHJ0odkUESa0
 KxQXPnDcxJt9covFvgx7CTBbnnJ+ZV1FQdEmsPdRACRKplilvPSQnqFO6Rzgv0TvxUAJ
 fdYw==
X-Gm-Message-State: AOJu0Yw066rdE+88aFTug3R3dD1eq3y4MlGvD+M/Vv3kY29O3r9tfDv3
 vsQWOBp7P+szX99N+uKGwy3L1KLZmmXWY3Q3SXLoP1yRC5qe1IT1Nxz8Il/cwFYi+dI5RWdhRAe
 788DsBJB5HIYrpgxqciE66LDS94CQKk9VjX7ZRw==
X-Google-Smtp-Source: AGHT+IE5LrvajtAkvktKmcT1H6ebxltdZkt1yh4LV00ET11tyZBMa9N27TNxQHvwXZDtrMYkPlBNMjQSphtudIaEiCA=
X-Received: by 2002:a2e:9786:0:b0:2ef:2c68:a776 with SMTP id
 38308e7fff4ca-2f12ee5777dmr54489651fa.37.1722243404445; Mon, 29 Jul 2024
 01:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-37-sughosh.ganu@linaro.org>
 <CAFLszTjQ011M-C+JNAPkFce2CEA5qofdm2TEtETndcU1k8vF5w@mail.gmail.com>
In-Reply-To: <CAFLszTjQ011M-C+JNAPkFce2CEA5qofdm2TEtETndcU1k8vF5w@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 29 Jul 2024 14:26:33 +0530
Message-ID: <CADg8p964_oxktCBb2BF81MCpGQVUbPYh-e1yxjjUbBKr=cfOpw@mail.gmail.com>
Subject: Re: [PATCH 36/40] test: lmb: add a separate class of unit tests for
 lmb
To: Simon Glass <sjg@chromium.org>
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

On Fri, 26 Jul 2024 at 05:03, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 24 Jul 2024 at 00:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Add the LMB unit tests under a separate class of tests. The LMB tests
> > involve changing the LMB's memory map. With the memory map now
> > persistent and global, running these tests has a side effect and
> > impact any subsequent tests. Run these tests separately so that the
> > system can be reset on completion of these tests.
> >
>
> This is just not a good idea...we should fix the tests so they don't
> have these side effects.

But this test *will* have side-effects -- if we are making the lmb
memory maps persistent, testing that code will have an impact. There
is no getting around it. Btw, I got this idea based on how the VBE
tests are run. This is similar to what is being done for the VBE
tests.

As an aside, what issue do you see with running these tests separately?

-sughosh

>
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since rfc: None
> >
> >  include/test/suites.h        |  1 +
> >  test/Kconfig                 |  9 ++++++
> >  test/Makefile                |  1 +
> >  test/cmd_ut.c                |  7 +++++
> >  test/lib/Makefile            |  1 -
> >  test/{lib/lmb.c => lmb_ut.c} | 53 ++++++++++++++++++++++--------------
> >  6 files changed, 50 insertions(+), 22 deletions(-)
> >  rename test/{lib/lmb.c => lmb_ut.c} (93%)
>
> Regards,
> Simon
