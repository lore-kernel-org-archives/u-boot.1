Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB3FEE49A3
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 02:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FBEA864AD;
	Wed, 23 Aug 2023 04:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oQftv/Kb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5A92864AE; Wed, 23 Aug 2023 04:34:45 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3FAE86410
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 04:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5257e2b5d12so6184177a12.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 19:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692758082; x=1693362882;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8pEal+5tZnjZNU3iafZA7hBShQmtIs/IvcQVV+QqiU=;
 b=oQftv/Kbf+M3Oiux8fvxnxNgRxVR/OQ0N0EVTUjbt75G3FpfzWtgPjRn/qs8gRFqCK
 l3MRR72PMnjm/z1onv8/H/RM56nez2D2U3+D57nGB5YcvJwEXEcmEHydbjOhDWa6lkRe
 mGfEErGPSqgrfyJdVqokUfrAr9uxaLMd/1l9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692758082; x=1693362882;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y8pEal+5tZnjZNU3iafZA7hBShQmtIs/IvcQVV+QqiU=;
 b=H9p4Y+JLHTnlVW6cQEyd2P0MVkhSB16ud0c+xkKn6ttmTgLhMuZDPAAaEfYVzjX6JB
 7N0wiJPD8CTffD3rSolFTfWVbODjs1h6N+u5Ozg7mO0C1Dt5RwjPoG5uIKYAWdLDmflm
 LpR1HU5SYwyJqA3FURafxI65bequmUAwjppIGv0h8nmbHi4ujJp1mBlpFjQixDbqHHvb
 URsMlLyn7tTUbC03UIMMI025NnhU6MrHYLWZpmF2QCJw3WaaLzmOZBW/UfF8K/kRWBzJ
 ddywv6m1LzNdVW27jY/BGp5o8DXmcdQKHaoDtCK3EKgUkDTBulnAqeR+Kk/MboR6Z6x9
 Mdpg==
X-Gm-Message-State: AOJu0YzKOU01LmsIL9KOfifvxXuWyJRGD9OMjC5OffIVXxwyPfOCQMq9
 nQgcVzpdwMTWQoOxaGXDfCTG6VzSxjPZS8FHJAcOsw==
X-Google-Smtp-Source: AGHT+IHt2IerC/FXYr+AaWZLospU5QGuzwMveuSIBPY9f8a0OF3V9VCXt+lwCW6iqnE4Jj6XsG7NxszTTuzLdp5Hu5U=
X-Received: by 2002:aa7:cd48:0:b0:525:950d:5f62 with SMTP id
 v8-20020aa7cd48000000b00525950d5f62mr6624505edw.42.1692758081995; Tue, 22 Aug
 2023 19:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-2-nm@ti.com>
 <CAPnjgZ0p5YkgvYM_F0j97bvAoM1qieafyjFQ_neyUoDuNFyN2g@mail.gmail.com>
 <20230822233358.geaqdn2vi34a5no2@uniformly>
In-Reply-To: <20230822233358.geaqdn2vi34a5no2@uniformly>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Aug 2023 20:34:29 -0600
Message-ID: <CAPnjgZ1HhohnyqxnxSXUSwJh=UkH+Ot3nowwXg8JW=3BFuZkxQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/8] env_default: Allow CONFIG_EXTRA_ENV_TEXT to
 override CFG_EXTRA_ENV_SETTINGS
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
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

Hi Nishanth,

On Tue, 22 Aug 2023 at 17:34, Nishanth Menon <nm@ti.com> wrote:
>
> On 17:16-20230822, Simon Glass wrote:
> > Hi Nishanth,
> >
> > On Tue, 22 Aug 2023 at 12:41, Nishanth Menon <nm@ti.com> wrote:
> > >
> > > CFG_EXTRA_ENV_SETTINGS is set in common board config files, This allows
> > > for majority of the settings to be set in a common manner. However, the
> > > minor variations between various board can be addressed by the board.env
> > > files. The board.env files are converted into CONFIG_EXTRA_ENV_TEXT.
> > >
> > > However, this creates a minor problem. For example:
> > > distro_bootcmd.h and used by ti_armv7_common.h uses it as:
> > >  #define BOOT_TARGET_DEVICES(func) \
> > >         func(MMC, mmc, 0) \
> > >         func(MMC, mmc, 1)
> >
> > OK, but we should be using bootstd for new boards.
>
> Agreed, and I think I am using bootstd[1] unless I am missing something
> completely.

Then why do you have BOOT_TARGET_DEVICES() ?

>
> we still have a problem with EXTRA_ENV_SETTINGS and ENV_TEXT. This patch
> helps enforce priority of ENV_TEXT.
>
> But overall, I agree that we need to move off from EXTRA_ENV to text..
> probably in stages, I guess.

OK good

>
> > >
> > > Which in turn generates:
> > > boot_targets=mmc0 mmc1
> > >
> > > And this probably works fine for most boards, However when the
> > > boot_targets need to be reversed, the preferred behavior would have been
> > > to define it in board.env file as:
> > > boot_targets=mmc1 mmc0
> > >
> > > By changing the order of the inclusion, we allow for the
> > > CONFIG_EXTRA_ENV_TEXT to have a higher priority in the definition.
> > >
> > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > > ---
> > > Cc: Simon Glass <sjg@chromium.org>
> > >
> > > New patch
> > >
> > >  include/env_default.h | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/env_default.h b/include/env_default.h
> > > index b16c22d5a28c..714dfa9e845e 100644
> > > --- a/include/env_default.h
> > > +++ b/include/env_default.h
> > > @@ -112,12 +112,12 @@ const char default_environment[] = {
> > >  #ifdef CONFIG_MTDPARTS_DEFAULT
> > >         "mtdparts="     CONFIG_MTDPARTS_DEFAULT         "\0"
> > >  #endif
> > > +#ifdef CFG_EXTRA_ENV_SETTINGS
> > > +       CFG_EXTRA_ENV_SETTINGS
> > > +#endif
> > >  #ifdef CONFIG_EXTRA_ENV_TEXT
> > >         /* This is created in the Makefile */
> > >         CONFIG_EXTRA_ENV_TEXT
> > > -#endif
> > > -#ifdef CFG_EXTRA_ENV_SETTINGS
> > > -       CFG_EXTRA_ENV_SETTINGS
> > >  #endif
> >
> > and text environment
>
> Could you clarify what I am missing?

I'm not sure about that. I have no objection to this patch.

>
> [1] https://u-boot.readthedocs.io/en/latest/develop/bootstd.html
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

Regards,
Simon
