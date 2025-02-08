Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0963CC02199
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 01:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA8D80756;
	Sat,  8 Feb 2025 02:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g3qkHJ8G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18B1F807D9; Sat,  8 Feb 2025 02:28:57 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57ED880737
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 02:28:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ab795ebaa02so117003466b.1
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 17:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738978134; x=1739582934; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W0IViwgclifvo8SLcIiBvczy8aQGEwwS/dGVY8mwabU=;
 b=g3qkHJ8GM549JDfNTCZpXW2J7m3K5pWYACJAcGAo0q2jQ0YiZYZno8ZXv5ZIF0hAeL
 K4PTSt/vkGUNnOSnMnVOND7dtWWRRXT6sH+1ute6xga2P5syOEJ+4kmGtSHbcVlUkBpf
 K+p+D/yo3/h5M4vc+0exwSIf3OdaJzh3gU8gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738978134; x=1739582934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W0IViwgclifvo8SLcIiBvczy8aQGEwwS/dGVY8mwabU=;
 b=jabIrjCOYo5t45TWdRiudVv6JBT/3Eppj5YX7+b5CEA4bVEz0ZmR/AOaFfdpv/+5Kb
 2P2tInl2Zeo3CTeY/M3KSBlBuBKDK+L9Gy8MPqhy8koSoZO25vk9w4WKzCIMUZh8/6SA
 w996/05vuCizLonGzj79iRmYUMztbPhPIUhQLhAK6DTkgyrqniu1JQ7WS5QuFsof90mI
 ZBTm81bs2VpipT8Mo2GxA9mHpjRkb6yhims846Ao2fiGZKe+jqGzPQ37+fbQKu3Y8nfi
 wZ5hbOfOF/wg6bWM1KoWyiTce0a88Ok9a0rhWUH9Z8Rn+ES26kX809wz35QovoLj0UDZ
 8k9w==
X-Gm-Message-State: AOJu0Yx1fBIz9bYaOdsvWrY6KZpWDyMF8biahET6w+yYMj4rpWRYENMI
 U7ruKFqydYVcW4wplWWZbA2s2psZ/d/q7wkJGCMLZmxd2Vva+oWVwjjHEcm6UBd8ASOr9nEQcbe
 rNblO5GGYbGKbbzKTr07psS+krTskezerZQLd
X-Gm-Gg: ASbGncvBnzDk0oOWCeZGHi5EHtFLTi3sT2TEN7gemV/m1VIbEfvOOBhKts/FqQ/I0Z7
 FFR15tKfYPKJqUyNwQPm9nV6HOVi9sEWOpkzYxUxYJofh97ZTH8uEPyGApvqNNaMpuBPDJegifw
 ==
X-Google-Smtp-Source: AGHT+IGVPyBC4ac9dUd3TbdSFR4w/lp/sF//kdQbZthv1O/2aiQXbuNGcYTyxWkm8SAAfjrrfmCxYXjpp9kbIcIjNhQ=
X-Received: by 2002:a17:907:97cd:b0:ab6:eec5:a7cd with SMTP id
 a640c23a62f3a-ab789b4b02emr570432966b.32.1738978133761; Fri, 07 Feb 2025
 17:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-2-sjg@chromium.org>
 <20250203200744.GZ1233568@bill-the-cat>
 <CAFLszTh0JYdCy8SYOkbnhGZB-cbtcYeZiqoHp0R-VF4Nn9rbsA@mail.gmail.com>
 <20250206171045.GJ1233568@bill-the-cat>
In-Reply-To: <20250206171045.GJ1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Feb 2025 18:28:41 -0700
X-Gm-Features: AWEUYZmuZck4Q1A8My1MFZJsnaHIgUByxRPRfXGbkhNI8Jwvx9yiyWL23fXEzYY
Message-ID: <CAFLszTgpvPqJnX7b2YDvrOz19q4Gw_+ZP0UYoTaUKWFtB3N-Vw@mail.gmail.com>
Subject: Re: [PATCH 01/32] Convert build-efi script to Python
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
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

On Thu, 6 Feb 2025 at 10:10, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Feb 06, 2025 at 06:05:36AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 3 Feb 2025 at 13:07, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Feb 03, 2025 at 10:41:54AM -0700, Simon Glass wrote:
> > >
> > > > Before this gets any longer, convert it to Python so it is easier to
> > > > maintain.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  MAINTAINERS                        |   2 +-
> > > >  doc/develop/uefi/u-boot_on_efi.rst |   4 +-
> > > >  scripts/build-efi.py               | 258 +++++++++++++++++++++++++++++
> > > >  scripts/build-efi.sh               | 207 -----------------------
> > > >  4 files changed, 261 insertions(+), 210 deletions(-)
> > > >  create mode 100755 scripts/build-efi.py
> > > >  delete mode 100755 scripts/build-efi.sh
> > >
> > > This should just go live in the u-boot-extras repository as another
> > > sample script. And as a bonus, there you can just push the script right
> > > now.
> >
> > But I can't be sure it will stay that way. In any case I see these
> > scripts as first-class citizens, in the docs, tested in CI, used by
> > people to report bugs, updated as new features appear, etc.
>
> Yup, I still think that's the wrong way of looking at it. It's a sample
> script on how to use this for QEMU which means it's useful as a debug
> and development aid. It's bad for CI since if we want to deal with "CI
> is slow" we need to pre-create test disk images, not do that on the fly.
> And you've got sudo and various external blobs being used. No, it does
> not belong in the main repository and I'm sorry I missed it the first
> time.
>
> And converting this to python is even worse as we have yet another tool
> that should have a proper requirements.txt file and keeping that up to
> date. And then oh, the inevitable "here's a security issue in U-Boot!"
> (by which they mean an issue in a support script and not what's deployed
> and used).

IMO development aids are quite important for efficient development. We
have things like scripts/gen_compile_commands.py and checkpatch.pl
which I use quite a bit. Cloning another repo just to be able to
develop on U-Boot efficiently seems daft to me.

We don't pre-create any test-disk images at present(?) I'm not even
sure that is a good idea, since it means that updating a test becomes
a lot harder. It would save a little time, but the thing which creates
the image only takes a few seconds on tui (although this happens on
each runner on the test.py stage):

    2.6s  test_ut_dm_init_bootstd

Python is easier to maintain than shell when it gets beyond 100 lines
or so. We could use the same requirements.txt we have for test/py and
I'm not sure how to deal with the security side. It sounds like
calling it a contrib/ directory might be enough.

>
> So please, lets just move this to the extras repository, and point to
> *that* in our docs enough that it's clear that we have tooling that can
> be useful in some cases there.

So long as I can point to it in docs and never lose access to the repo
in the future, I think I can live with this. At least I can try it.

I think I could add it as a repo in the contriib/ subdir of the U-Boot
directory (with a .gitignore in U-Boot), so perhaps I can mostly
forget that it is separate.

Regards,
Simon
