Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A975CC52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 23:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3171988C92;
	Sat, 17 Aug 2024 01:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e75JeOYB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0139388C71; Sat, 17 Aug 2024 01:54:23 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 009C188C62
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 01:54:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6bf7707dbb6so16647826d6.0
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 16:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723852449; x=1724457249; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aYp9aB10j8qIDm1s0RpBIaMvgugO5UsEgjdbuYYOHUA=;
 b=e75JeOYBvpPtLyDtMfSJQer09nPPKvhD0CkM3pyPJz9he1V6T1upeXJ69DD/xlaWIA
 vn4qhy+aaCOne7nNMCYbhlNAQVfFlFBav7hiSdgZaWw6aYNoU2dyYXsoHfmCQU9MZUGD
 uePoTtPCdXxIklhpgeejptEMviwF/LLfNJDdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723852449; x=1724457249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aYp9aB10j8qIDm1s0RpBIaMvgugO5UsEgjdbuYYOHUA=;
 b=aHemR9EjzK3wo03qfzrk0JN04GyUQQ/RSi8XWTld6lcZpxZgHpZcwkwaBJjsKGvEpG
 iJmtf023N7MgIKZWdZq/Tg1krDy5zvpILS4TML00Tl0v0rxds+Wsf/QbgYeqEE6tP3XM
 UtqWznKhutTCnfLi1YfuDoznKj4kJzBuUIU3shDkj+FaZbXj6MIVVyXPetBrBFE0UvVN
 YZVPrDAw1JikfjRs3IsDMZ204C2syRjAys+rN4xYQ7btHxo+SfCzxYQpeRhvPhUEUca2
 rptiXisUJGs9OmVPUa7H45cUCJwCTX/zxJ3blmVh5SRnhe0tL8lDDxrOgslTPMB1I/AB
 aU2g==
X-Gm-Message-State: AOJu0Ywi3BikRVMhIK1TSvwWU5afJ9gCbKJVUlWvNwmQy1bqVEw+AHSe
 78DSvizfoUW/95mESgNw9/PQ40mPArU73N7BgroR0aWNNXbQTq6c90nE4W79zmJhvfyxAQ75bZ0
 7ZUGVY6T8lIymTAc1TqylOO4Gyi0aEOh9KkVn
X-Google-Smtp-Source: AGHT+IGSVymwMlQ9XdFAVdrNlL2paByxuardPazU/HlfSO3avOXyDko8MWOMQAOJ7B2RH6XobHlEdq8V3ogb6ClT14Y=
X-Received: by 2002:a05:6214:2f0d:b0:6b5:7f19:e61d with SMTP id
 6a1803df08f44-6bf7d50efcbmr119499536d6.6.1723852449642; Fri, 16 Aug 2024
 16:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-28-sughosh.ganu@linaro.org>
 <CAFLszTh-5c4_OdZs8F_e=giR+ZFjNB1oX8L8cV8hXi9Je6e+5w@mail.gmail.com>
 <CADg8p954ZtuXpC_b_rfkpWuXBGFV40Kp=DJby_oRsTp2GYbcHw@mail.gmail.com>
 <CAFLszTgsbrBefPQ7EGdLbC8fUO=oZUoQ13TYeo=pJzu2Uro_kQ@mail.gmail.com>
 <CADg8p96ogU8isBs6rs+s5-U4XJOXryPDb-MzHTuxwT8L07HQ3A@mail.gmail.com>
 <CADg8p978HKb1r9D3e_ZbErrfnKnLy7-bOTfuk2Suc-Qvq7n_ig@mail.gmail.com>
In-Reply-To: <CADg8p978HKb1r9D3e_ZbErrfnKnLy7-bOTfuk2Suc-Qvq7n_ig@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 Aug 2024 17:53:58 -0600
Message-ID: <CAFLszThzR=2V=Oqe6iZq8gK1stwEH1_kraFNnSPSQpyGMN3A0A@mail.gmail.com>
Subject: Re: [PATCH v2 27/32] test: cedit: use allocated address for reading
 file
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
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

On Fri, 16 Aug 2024 at 11:53, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 16 Aug 2024 at 22:39, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Fri, 16 Aug 2024 at 20:17, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Fri, 16 Aug 2024 at 04:34, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > On Fri, 16 Aug 2024 at 02:02, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Sughosh,
> > > > >
> > > > > On Wed, 14 Aug 2024 at 05:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > >
> > > > > > Instead of a randomly selected address, use an LMB allocated one for
> > > > > > reading the file into memory. With the LMB map now being persistent
> > > > > > and global, the address used for reading the file might be already
> > > > > > allocated as non-overwritable, resulting in a failure. Get a valid
> > > > > > address from LMB and then read the file to that address.
> > > > > >
> > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > ---
> > > > > > Changes since V1:
> > > > > > * Don't use the API version with flags parameter.
> > > > > >
> > > > > >  test/boot/cedit.c | 6 +++++-
> > > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > >
> > > > >
> > > > > No, this address needs to work fine without using lmb. Same with any
> > > > > other tests. Tests make use of the sandbox memory space memory
> > > > > addresses and it makes things easier to code and debug.
> > > >
> > > > Like I had explained earlier [1], not using the LMB API for allocating
> > > > the address results in issues, since the load command internally
> > > > checks if the address can be used for reading the dtb. Without this
> > > > patch, the cmd_ut test fails. I am not sure why you do not like this
> > > > solution. But in any case, can you propose some other solution? I
> > > > believe I can tweak the address to some other value, but that would
> > > > not be a proper solution, but simply kicking the can down the road.
> > > > Thanks.
> > >
> > > But this is why I suggested having lmb_push() and lmb_pop(), so you
> > > should be able to use those in the few tests which have this problem.
> >
> > Ah yes, I forgot about that change. Let me try running the test again
> > and see what I get. Thanks.
>
> Sorry, I think I was hasty in my reply. This would not work. We have
> the lmb_push()/lmb_get() functions only for the lmb specific tests. In
> this scenario, we have the load command which checks the lmb address
> against reservations, which are the "normal operation" memory map. So,
> if we have to have this to work, this might need a way of using a new
> lmb structure instance for every test. So that every test that gets
> invoked, does so like the way the lmb tests are.

Why does the 'load' operation fail? When I revert this patch the tests
still seem to pass.

Regards,
Simon


>
> -sughosh
>
> >
> > -sughosh
> >
> > >
> > > If it becomes more widespread and affects a lot of tests, we could do
> > > thing automatically in the test framework, but for now, that doesn't
> > > seem necessary.
> > >
> > > >
> > > > -sughosh
> > > >
> > > > [1] - https://lists.denx.de/pipermail/u-boot/2024-July/560569.html
> > >
> > > Regards,
> > > Simon
