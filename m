Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9592C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 15:43:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6946981DE3;
	Tue,  1 Apr 2025 17:43:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JdkZCxN/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4B9E81EC0; Tue,  1 Apr 2025 17:43:02 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C1AE8171B
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 17:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac29fd22163so954662566b.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743522180; x=1744126980; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cb/O+OkB4NxH84JR7CoKOqaEEjfL6To5vP5tLIHVmaE=;
 b=JdkZCxN/LS3tR9LmRlDEK3hUuZERuvb8drU+RLDbD2goPKGM7kWzluWzQSDJY45TGR
 cLx4L62w7x0CEmCsLjIYcRDm5e2DP/QD+xim/M+mz5uCX9P1Om786ROhEjOsSrmr8KUC
 O923/wfnAoEBJNov4+hQfuTvBw28PGtW8XF30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743522180; x=1744126980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cb/O+OkB4NxH84JR7CoKOqaEEjfL6To5vP5tLIHVmaE=;
 b=huFEaPiwj4nBB8rchpkM6ZNEMd4cARS8XzwG1iuMo6MAL2TwZgH7QWR0M74sBoOozX
 plFKULpdbYABMaBVYtx4Orsu08BtH8X7asZHxHWBOm4p2zSatGn5nDxx2CWlE98r5Qx+
 6htF7g8r3SY3lJBhVq2gneVeK/WU7j5CoY2fSGcR2d/iQnR+Tdm4b8QETuL0Bgpb1coD
 41Zn3BkYNdlC42R4Lzo2tSii9WexYT97Nmi6SxWMkieV2tfjTxL+kI71aeYrAPyiw70P
 x4fmbY7p5HTFr+92RPLVCgj/iV5byUQDFrqAU0aBpNxqnzxTs8ZrZCleZmKTr+eMArac
 F/jA==
X-Gm-Message-State: AOJu0Yzdbp0p621YsxPgogd+VIrHiQC9G7DSy8mye2W/Z/k6te8dC/f6
 ZImNOr1cQkWn8KKxRSKhESo+l8ihRk1z6tVoYVLojkbyfP4za7xnlwsNvl9PEiB3ECKco9Zb/8h
 2cqYePpm73Ls2llfGp/umNQpiTGkAJPwtwa3q
X-Gm-Gg: ASbGnct2L9kpmL/XrbZ6AwcGGuTppGQaxZ+CMWJtYwopPm7X5O3gyN6U53ayxYdGxkq
 Qr/90Wd0frMO8dDGuH4ib/yCrxnIA+v7AT7/6K4hycZg4YQFP4CFqAeuSo1SAxwrymxSYYsE79c
 FUY9IVpYHg5afguHvdo1FVdSjzN4qy6vKmDBAMSug=
X-Google-Smtp-Source: AGHT+IFXOTPgeLG5NK6vnYg9T5mV0Vnz/ILm+WOaM+nlpEEkE3w+K1PM+SoQkbYi/r3McUEmNum2mG+nOazksijqZ0Y=
X-Received: by 2002:a17:907:724a:b0:ac2:972c:f732 with SMTP id
 a640c23a62f3a-ac738ad5864mr1165784566b.33.1743522179791; Tue, 01 Apr 2025
 08:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250328153522.3555472-1-sjg@chromium.org>
 <20250328153522.3555472-20-sjg@chromium.org>
 <6721d34c-83eb-44d9-9be5-a4f8346481e3@kwiboo.se>
 <CAFLszTiEwMqyhwJ6NvkhpE3cOw7z+VHmhqMdHcPVGyr6rK4yEA@mail.gmail.com>
 <99333ff1-f794-410b-aade-fd73450d5a1f@kwiboo.se>
In-Reply-To: <99333ff1-f794-410b-aade-fd73450d5a1f@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Apr 2025 04:42:46 +1300
X-Gm-Features: AQ5f1JoedPA0mHFOT9gi80KIvHVnkiP-jK2g3hGUTSdmgvY19yqBGFzH-RKe6es
Message-ID: <CAFLszTiwdr_E-O=UoVGfTTyjsJ_t9LvSPGD2v2cTKp=fhLgW5Q@mail.gmail.com>
Subject: Re: [PATCH v3 19/31] rockchip: Provide a VPL phase on rk3399
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Dragan Simic <dsimic@manjaro.org>, 
 Greg Malysa <greg.malysa@timesys.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Paul Kocialkowski <paulk@sys-base.io>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 huang lin <hl@rock-chips.com>
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

Hi Jonas,

On Sun, 30 Mar 2025 at 05:46, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-03-29 00:40, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 28 Mar 2025 at 10:16, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 2025-03-28 16:34, Simon Glass wrote:
> >>> Add support for this new phase, which runs after TPL. It determines the
> >>> state of the machine, then selects which SPL image to use. SDRAM init is
> >>> then done in SPL, so that it is updatable.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>> (no changes since v2)
> >>>
> >>> Changes in v2:
> >>> - Rewrite help for VPL_ROCKCHIP_COMMON_BOARD
> >>> - Skip spl-boot-order.c for VPL (rather than modifying it)
> >>>
> >>>  arch/arm/include/asm/spl.h               |   1 +
> >>>  arch/arm/mach-rockchip/Kconfig           |  25 +++++-
> >>>  arch/arm/mach-rockchip/Makefile          |  11 ++-
> >>>  arch/arm/mach-rockchip/rk3399/Kconfig    |   9 ++
> >>>  arch/arm/mach-rockchip/spl.c             |   3 +
> >>>  arch/arm/mach-rockchip/tpl.c             |   2 +-
> >>>  arch/arm/mach-rockchip/u-boot-vpl-v8.lds | 107 +++++++++++++++++++++++
> >>>  arch/arm/mach-rockchip/vpl.c             |  53 +++++++++++
> >>>  common/spl/Kconfig                       |   1 +
> >>>  9 files changed, 205 insertions(+), 7 deletions(-)
> >>>  create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
> >>>  create mode 100644 arch/arm/mach-rockchip/vpl.c
> >>>
> >>
> >> This patch and therefore this series does not apply to the next branch.
> >>
> >> Are there any depends that are missing or are you only testing based on
> >> your own fork?
> >
> > Until we are ready to apply things, yes I am using the sjg tree. See
> > the tags in the cover letters of patches I send. For this one it is:
> >
> > base-commit: 3f76d803db9b500f43bc534465945a8d2836bb3e
> > branch: vbi3
>
> This base-commit does not even exist in your vbi3 branch :-/

Are you sure? The base commit works fine for me:

$ pe 3f76d803db9b500f43bc534465945a8d2836bb3e
3f76d803db9 (ci/master) Merge branch 'ci' into 'master'
d07049b9f28 (el/ci) arm: Support a separate stack for VPL
abfff044f26 spl: Use CONFIG_VAL() to obtain the SPL stack
7a032a125f5 spl: Add an SPL_HAVE_INIT_STACK option
8d319b22019 tpl: Rename TPL_NEEDS_SEPARATE_STACK to TPL_HAVE_INIT_STACK
794124b3258 Merge branch 'ci' into 'master'

The branch name is a local branch, not necessarily pushed anywhere. Is
there some better terminology that I should use there? Perhaps
'local-branch' ?

>
> >
> > So no, there is nothing else that this series depends on and if you
> > can review it I can send a PR for Tom for -next one all necessary
> > changes are made.
>
> Sorry, this does not help, my main concern is testing that this does not
> break or affect anything for the remaining Rockchip boards. Something
> that is hard to test and validate when patches do not even apply to any
> of the mainline master or next branches.
>
> Sending patches based on a tree that has diverged with around 677 files
> changed, 20072 insertions(+), 17023 deletions(-), if my git fu is
> correct, and then expect us to test based on this diverged tree does not
> help with gaining confidence in this series.
>
> I can understand keeping a personal tree that will diverge at times,
> i.e. my personal tree has ~120-150 patches on top of mainline master.
> However, I always try to keep my work-in-progress branches rebased on
> top of master or next.
>
> For v4, please send a series based on mainline master or next branch,
> as stated in "General Patch Submission Rules" [1] in the U-Boot docs.
>
> If the series has some depends, I suggest you also publish a branch
> to a public repo with any limited depends applied on top of master or
> next along with the patches in your series.

For now I am going to wait until you pick up your clean-up of part of
my series. Then I can pull that in any try to send the final VBE
series again.

I haven't had any rockchip patches rejected, so we should be able to
resolve this.

>
> [1] https://docs.u-boot.org/en/latest/develop/sending_patches.html

Regards,
Simon
