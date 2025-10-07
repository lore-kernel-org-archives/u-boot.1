Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EFDCCA476
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 16:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26C54839E8;
	Tue,  7 Oct 2025 18:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d4zXEYOT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B580839F3; Tue,  7 Oct 2025 18:38:46 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FF54839A8
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 18:38:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-628f29d68ecso15820923a12.3
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 09:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759855124; x=1760459924; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KfI7bC0XUh40D7aasB2j5Gms6LqNWxiMYl26PCUym28=;
 b=d4zXEYOTyPOirgBArjQZKt1g+C3M99Xesabjn4q2xmuCxzKtrOBwG/0aCJGVFuGIIF
 sMACbtHM7l/ZJ/SHqj/JIVUMSGzwMo7gNTksuYiaa2GuM0OcVWzQFeJ+lGdeHtBc8DAU
 tWlKAXoAZHdd4YdZK8XXWdRh/cIVNrZs8izmC6x3zjf1MEw/gJQbvU30qPhc1TMx9/Wk
 o20URp7W3fU3Rpn6m4Cjlu+iiLXrfNICVqbRILFBI5LdGJCLKXdQ8yi58NEdulOVsUmz
 DAsYUGhW7hCm6DskH3e3YUu9IvDQ4DgdJtBgAAdGmWYeYlxODsAgtsdewi3lZdKlJast
 /e6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759855124; x=1760459924;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KfI7bC0XUh40D7aasB2j5Gms6LqNWxiMYl26PCUym28=;
 b=CbCA9Nse4Ww1IFxtVVEjHZNFtLcy+1cIIya/RI8se4EvT7qsKcR1eeJe63QZNmt1Go
 hUaFa+L6fIdwH62RhnjewN8SO1BysqtnPRJCrvpbKG2wcsEeVWmB1Ns/UaZtXuaS1TWA
 772NBVP/YJ6oRaCf24BEOEXyIAAlzTNizsNK4GTy7hrvUySnZfWkCDFibLlsPJvys2Kk
 MTOfQaGX3HIpLoHYruYyOIuFd54upEgD555mnyArcDirZmNeGX2p7+JSiSs0I1g05ClH
 CSiPVxta/NHI0y1PY7Q7ugRe2jrv9Qq2bGjMPdRNTNPbhBqXdmn2zbXxeTdQk8dgoc+3
 i4+A==
X-Gm-Message-State: AOJu0YxDxjOg11t/Y8wRvwAmR/NIc2EDqRdJUe/iLiYP40VU533Wt/p8
 05YAggmHiKGxZG01V/grcEBdZCfmPjUfoYBTg5/rQ040Zha6vCAmUFk0J5o62E+PBKIP8Gho8CS
 izkOfh9oZcCF0fsoBz7wPXZJmvdR1TPw=
X-Gm-Gg: ASbGnct+2oiueHZeqB8ATg+hTTrlokWLKZwjQ7qZry99U2H70HB0CXTY43JHEWG8MBf
 zq80RV6T26/LDeTEPQDUjO0AAc3ZkiN2PSKD6BFh3H7rOBobcQwtzBUyJBAS7b1DfM8fii/aAHx
 +KvypSvMp5f20jpXJT9duYIvx5PFFQhe74VVlXl/iqgYTioNOgR7WoULKuikN44sJT4L34mZYKs
 9dUa3j6LlUPlEt9zDtpO8+U2N79IbgfsV7oapI6ZHSN6tzpG/VEwpTIGiCyzaEvgyjdOQ2gWOI3
 OXwOzqy5aFEhBwQaUSlGEGbjCIqpyI/pD0d0SBg=
X-Google-Smtp-Source: AGHT+IGYyggdMsO7iEtqEeyWTY8KjJ0NkT0bTLsMTu2xYxTJRazTh1CFJLEiqw3mh9Arc4n2aDCuPnf1fpUseg0ULKs=
X-Received: by 2002:a05:6402:5c9:b0:61c:8114:8832 with SMTP id
 4fb4d7f45d1cf-639d5b86757mr40771a12.16.1759855123304; Tue, 07 Oct 2025
 09:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251001212649.3263574-1-sjg@chromium.org>
In-Reply-To: <20251001212649.3263574-1-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 7 Oct 2025 17:38:31 +0100
X-Gm-Features: AS18NWD134Ml9fLp56fAypeKgGyoTl-Asxh_keVNpLLBxsr5uKw2sPx5_2PRFiU
Message-ID: <CALeDE9Ovemog2AGN_Li8Ju12QKHOC0D30V2=KG00f0KsQ5aPkg@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] boot: Support priority for global bootmeths
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Martin Schwan <m.schwan@phytec.de>, Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Simon,

Welcome back!

This is quite a large series making it quite hard to review.

> At present global bootmeths always run first, before all other
> bootmeths. Optimisations in the code take advantage of this, putting
> them at the end, so they can be used once and then forgotten.

How often would you expect a device to actually want to enable and run
all boot methods? EG I would expect an organisation who's making a
general purpose devic to maybe want UEFI and extlinux, but likely not
android, rauc and some of the other ones. I would think it's would be
quite unusual for a device to enable everything and for a usecase
specific device they'd probably want just one.

> In some cases it is useful to run global bootmeths later in the boot.
> For example, the EFI-bootmgr bootmeth may itself scan devices and the
> network, so running it first can hold up the boot significantly for
> boards not actually relying on EFI-bootmgr to boot.

Exactly, would boards not relying on UEFI actually enable it at all,
similarly if a device is not ever expecting to boot off a network they
would disable it.

> This series introduces a new field in global bootmeths which indicates
> the priority, using the same scheme as is used with bootdev hunters.
> Thus it is possible to insert the EFI-bootmgr bootmeth just before the
> hunter for network bootdevs is invoked.
>
> Despite the simplicity of the concept and the relatively small series,
> this is a fairly significant enhancement. It is also quite tricky to
> implement, largely due to the way the original code was written, with
> global bootmeths being a small, size-optimised add-on to the original
> bootstd implementation.

So we know it's complex but I'm still unsure what value it provides.

> For now we only allow each global bootmeth to run at most once, but this
> implementation is written in a way that we could relax that if needed.
> Then the bootmeth itself could decide whether to run at any particular
> point in the bootflow iteration.

Why would we want to run them more than once?

> Size growth is about 390 bytes on Thumb2 (e.g. firefly-rk3288) if
> CONFIG_BOOTMETH_GLOBAL is enabled, which it normally is. With that
> disabled (which saves about 4K on the same platform), there is no
> growth.

So what value does adding 4K by default to the firmware provide? All
what makes something a global boot method vs a non global (local?)
boot method?

> Changes in v2:
> - Add a log_err() for an invalid state
> - Update commit message to indicate the bootmeth will always run
> - Document how the priority was chosen
> - Add a bit more detail suggested by Heinrich

I think this series needs to be broken down into a couple of series.

These looks like fixes mostly unrelated to and independent of the new feature:
>   boot: Improve comments related to global bootmeths
>   boot: Move obtaining the label into a common file
>   boot: Add more debugging to iter_incr()
>   boot: Move showing of bootflows out of the command
>   boot: Move preparing bootdev into a function

I think these are the bits that do the global stuff.
>   boot: Add a new test for global bootmeths
>   boot: Update first_glob_method when dropping a bootmeth
>   boot: Add a flag for whether there are global bootmeths
>   boot: Support rescanning the global bootmeths
>   boot: Only run global bootmeths once each
>   boot: Implement a priority for global bootmeths
>   boot: Don't change the method count after global bootmeths
>   boot: Run global bootmeths after all bootdevs are exhausted
>   boot: Run the EFI bootmgr just before network devices
>   boot: doc: Update for new global-bootmeth features

Why do we want this? What does all bootmeths mean in this context?
>   boot: Try all bootmeths on the final partition

As I, and at least Tom, but I think others, have asked in the past
please do smaller patchsets on single topics. If you need to do
cleanups post them as a different dependent patch set.

You have complained in the past that people don't review your series
fast enough, but doing large sets like this with an inter mix of fixes
and enhancements make it hard for people to review, eg I put this in
my back log because of that exactly.

Regards,
Peter

>  boot/bootflow.c                  | 318 ++++++++++++++++++++++++++++---
>  boot/bootmeth-uclass.c           |  15 +-
>  boot/bootmeth_efi_mgr.c          |   9 +
>  cmd/bootflow.c                   |  66 +------
>  doc/develop/bootstd/overview.rst |  40 +++-
>  include/bootflow.h               |  39 +++-
>  include/bootmeth.h               |   4 +
>  test/boot/bootflow.c             |  75 +++++++-
>  8 files changed, 457 insertions(+), 109 deletions(-)
>
> --
> 2.43.0
>
> base-commit: aff68c8514858ddd8d2e508d47bede566511521b
> branch: glob-us2
