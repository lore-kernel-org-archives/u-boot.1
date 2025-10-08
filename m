Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62C3CCD183
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 16:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45248839DE;
	Wed,  8 Oct 2025 18:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jURhD5qG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D6ED83F6D; Wed,  8 Oct 2025 18:51:49 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C931839B9
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 18:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6399328ff1fso61813a12.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759942306; x=1760547106; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nbj9oTfuvFI/anq7Fcac4bH/zry0dVmKlhfNhhYk06g=;
 b=jURhD5qG5iRUg04fqFc6o/4V4V7FgIigFBQ7P4ubmE+ammeF9h139VztJOdqcAKSYB
 GJ9yv32r1zv4J8ljq+/CuRnyiggZugH1GLC+WZAt31Oz17zp2TkEo+qZ9DUiAAbboGpH
 3FhQ23h31GAB4F0ZLcBMimCG4Z5ysa0oJhL4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759942306; x=1760547106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nbj9oTfuvFI/anq7Fcac4bH/zry0dVmKlhfNhhYk06g=;
 b=KMb/pJAGSnSgZQWMIIWeQja/OWNGEqwMgmRmcSX0qA+VBSf0Y5OLw8jwt/mkhA9Iv1
 onxVyv8Dw++es9h2rX3D7qlB6f3eJdJ02SJTc5tc2/Xxfr9MngyiJ6OUa6SNfSKQyMFr
 5Y9jKuM3PVQUGFJ6yq5mJWFPti3Lptaj6OSnS5TbANyTfr/KDib5Mo7mTnLGWCtDjGl8
 jZUPg5Z8rhRRmDdK7TzkrFooTsHLTnYOAoaFEt7w7T1Qq/tTok1NgJt++yA+B/FW+tTR
 HmVTTufTslC4kFNYNFJW1+jkib0VTaQv9AuvDsdbO+GCQKUkymUT8ZmFlA0UmRACukgS
 GbTA==
X-Gm-Message-State: AOJu0YxV+mOqdIOxRW8k1gOU01cOTr1fQUfAcF+WUJgtSBODMWelIvGS
 h2RvOGpv5mHupqJktAqfvs9tsZO/9Dihyc33gU1Vt3BzBlNj1/8UgcwFRhUGvBO8CcdzHBtzClp
 eRsCnbjzP8dUhutU6HN/f4fPGwxyQbU1C4l6PwYDt
X-Gm-Gg: ASbGnctt4ycjFXZewMbVhk3OTqfkoN5s9OQpKNTK6IlapWUZqPYiTr0EwKLjC9kEM/1
 ruTun0b53cGamKqjRpTzS08A67ZsZUFhfZhFlDwJqJx9NROVn5ZEn9yIIpRmuauQLhZd4riL9gg
 +rlHrRVnnhm2m9IBuT95b9nz0ymkswvEn0gyJK1eLVvAQcLogbH8ZjAeG8zzEct/FaxRJiWXFLf
 dtXJCBEQINJRmr26BhS8+PESv1TL6oO5kHyP2vz
X-Google-Smtp-Source: AGHT+IHD404rm46ARzT3tf62/rOK4aPcaUe7gH4vrRaAeuf1cG00Y1AVD5Hp1sz2NkfCMHBaWcn6kUyJeT8+u8yQjm0=
X-Received: by 2002:a05:6402:5c9:b0:639:e30c:247b with SMTP id
 4fb4d7f45d1cf-639e30c2dacmr2210794a12.30.1759942305952; Wed, 08 Oct 2025
 09:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20251001212649.3263574-1-sjg@chromium.org>
 <CALeDE9Ovemog2AGN_Li8Ju12QKHOC0D30V2=KG00f0KsQ5aPkg@mail.gmail.com>
In-Reply-To: <CALeDE9Ovemog2AGN_Li8Ju12QKHOC0D30V2=KG00f0KsQ5aPkg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Oct 2025 10:51:34 -0600
X-Gm-Features: AS18NWC3M1jAdozl2nP9w2IRmL6HRv5zPTah_G2IPxZsWn7mi5kSCyfTVYNsfiU
Message-ID: <CAFLszThwb9AsWwZULTKZZz1hcFW2Ns1tNttMrO=mpGp4UvYvVw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] boot: Support priority for global bootmeths
To: Peter Robinson <pbrobinson@gmail.com>
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

Hi Peter,

On Tue, 7 Oct 2025 at 10:38, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Simon,
>
> Welcome back!
>
> This is quite a large series making it quite hard to review.
>
> > At present global bootmeths always run first, before all other
> > bootmeths. Optimisations in the code take advantage of this, putting
> > them at the end, so they can be used once and then forgotten.
>
> How often would you expect a device to actually want to enable and run
> all boot methods? EG I would expect an organisation who's making a
> general purpose devic to maybe want UEFI and extlinux, but likely not
> android, rauc and some of the other ones. I would think it's would be
> quite unusual for a device to enable everything and for a usecase
> specific device they'd probably want just one.

I suppose it depends on what is being booted. If it is a more closed
and embedded system, then perhaps only one bootmeth is enabled. For
many of the boards that U-Boot supports, different people likely run a
lot of different things.

>
> > In some cases it is useful to run global bootmeths later in the boot.
> > For example, the EFI-bootmgr bootmeth may itself scan devices and the
> > network, so running it first can hold up the boot significantly for
> > boards not actually relying on EFI-bootmgr to boot.
>
> Exactly, would boards not relying on UEFI actually enable it at all,
> similarly if a device is not ever expecting to boot off a network they
> would disable it.

Possibly.

>
> > This series introduces a new field in global bootmeths which indicates
> > the priority, using the same scheme as is used with bootdev hunters.
> > Thus it is possible to insert the EFI-bootmgr bootmeth just before the
> > hunter for network bootdevs is invoked.
> >
> > Despite the simplicity of the concept and the relatively small series,
> > this is a fairly significant enhancement. It is also quite tricky to
> > implement, largely due to the way the original code was written, with
> > global bootmeths being a small, size-optimised add-on to the original
> > bootstd implementation.
>
> So we know it's complex but I'm still unsure what value it provides.
>
> > For now we only allow each global bootmeth to run at most once, but this
> > implementation is written in a way that we could relax that if needed.
> > Then the bootmeth itself could decide whether to run at any particular
> > point in the bootflow iteration.
>
> Why would we want to run them more than once?

It may come to pass that we want a bootmeth to try to boot based on
the bootdevs already seen (e.g. pre-network) and then try again later
(e.g. once the network is available).

>
> > Size growth is about 390 bytes on Thumb2 (e.g. firefly-rk3288) if
> > CONFIG_BOOTMETH_GLOBAL is enabled, which it normally is. With that
> > disabled (which saves about 4K on the same platform), there is no
> > growth.
>
> So what value does adding 4K by default to the firmware provide? All
> what makes something a global boot method vs a non global (local?)
> boot method?

This is described at [1]. Global bootmeths are not specific to a
bootdev. They can operate independently of particular devices. For
example, sunxi FEL operates on something that isn't a bootdev. Bootmgr
operates on all devices it can find in the system. So global bootmeths
are an important part of the bootstd model.

>
> > Changes in v2:
> > - Add a log_err() for an invalid state
> > - Update commit message to indicate the bootmeth will always run
> > - Document how the priority was chosen
> > - Add a bit more detail suggested by Heinrich
>
> I think this series needs to be broken down into a couple of series.
>
> These looks like fixes mostly unrelated to and independent of the new feature:
> >   boot: Improve comments related to global bootmeths
> >   boot: Move obtaining the label into a common file
> >   boot: Add more debugging to iter_incr()
> >   boot: Move showing of bootflows out of the command
> >   boot: Move preparing bootdev into a function

OK.

>
> I think these are the bits that do the global stuff.
> >   boot: Add a new test for global bootmeths
> >   boot: Update first_glob_method when dropping a bootmeth
> >   boot: Add a flag for whether there are global bootmeths
> >   boot: Support rescanning the global bootmeths
> >   boot: Only run global bootmeths once each
> >   boot: Implement a priority for global bootmeths
> >   boot: Don't change the method count after global bootmeths
> >   boot: Run global bootmeths after all bootdevs are exhausted
> >   boot: Run the EFI bootmgr just before network devices
> >   boot: doc: Update for new global-bootmeth features
>
> Why do we want this? What does all bootmeths mean in this context?

Are you asking why we want this feature at all? The original genesis
was a discussion on the U-Boot call a few weeks back, where we were
trying to work out how to enable the 'script' bootmeth to run before
bootmgr, since the latter starts up the network, thus slowing boot
significantly. This idea what we came up with.

> >   boot: Try all bootmeths on the final partition
>
> As I, and at least Tom, but I think others, have asked in the past
> please do smaller patchsets on single topics. If you need to do
> cleanups post them as a different dependent patch set.
>
> You have complained in the past that people don't review your series
> fast enough, but doing large sets like this with an inter mix of fixes
> and enhancements make it hard for people to review, eg I put this in
> my back log because of that exactly.

I'm not sure what you are referring to here. Can you provide a link?

I will check with Tom about posting just the 5 patches above.

>
> Regards,
> Peter
>
> >  boot/bootflow.c                  | 318 ++++++++++++++++++++++++++++---
> >  boot/bootmeth-uclass.c           |  15 +-
> >  boot/bootmeth_efi_mgr.c          |   9 +
> >  cmd/bootflow.c                   |  66 +------
> >  doc/develop/bootstd/overview.rst |  40 +++-
> >  include/bootflow.h               |  39 +++-
> >  include/bootmeth.h               |   4 +
> >  test/boot/bootflow.c             |  75 +++++++-
> >  8 files changed, 457 insertions(+), 109 deletions(-)
> >
> > --
> > 2.43.0
> >
> > base-commit: aff68c8514858ddd8d2e508d47bede566511521b
> > branch: glob-us2

[1] https://docs.u-boot.org/en/latest/develop/bootstd/overview.html#bootmeth
