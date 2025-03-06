Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D467FC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 17:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C7F6810DC;
	Thu,  6 Mar 2025 18:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cuGPycj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFC7D810F4; Thu,  6 Mar 2025 18:56:20 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 592F780F9E
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 18:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac202264f9cso183219566b.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 09:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741283778; x=1741888578; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZhewETUL4KN1I1z+L3XLQwhPAwbjL+z/0Wzq0bdxkVo=;
 b=cuGPycj2HsQfPz4QyVcx8Gvth79B4HDw+Tts2owICwGt6lTSLrtn0XtPDZsT+EWyl9
 t3MjxUSWCjc9NmuJJOKIYm4EPBeQmpZqg5GdGiYPc9b9oZripn/qSvGZ+NkBS7ilw0Ue
 9VvY6+QhnfCN11Du9IagpjgtTp2R+4F0mnQOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741283778; x=1741888578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZhewETUL4KN1I1z+L3XLQwhPAwbjL+z/0Wzq0bdxkVo=;
 b=WzrZVgZJtW4P5A0rHPLg5TBKT6KjiQanwHEk03ZfN/uN04SiI0phHspGAmE7PTBebj
 LxX1iV91AGKlta1vbSR02HTp6O2gQSCF8ongHE1mOVWEoS/MFNTqHDjIQaTBmJVw4MW9
 aetdYXswPPoKI84+O3adG6/IzdZZkTWp2IK7jNQjK6SOCnxbU6af1V8SnXSXawrsP2QI
 TyovhuW9F1/UnR+0N+Oyn8iVapPAmnK9Fwu2wTlHR82qaktUTVHbMXhROszTrylGirb1
 /BTRGMo4J6ZfeSBz5XN+7UspAvZ0g4pFdbr3i1YKgXa7SdYEU85sswTItMiDDc4tGqLG
 S03g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXInCylOYx4r1+CY2FyQ982hjQugXqI0ccN78RqJl6RPAN1ytsVBhKDcN5YwprjrrLZ1uTIMDo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7xPaRL1z6djNwG2S6qUdFHUH7r4MjGDswVKhVORtKqVfwFfpL
 rBcMVTQAtEApoRyVYUE5OKGhKRtXNpl5iTxaJIb1EciIxe8KlBFVBpNyK0W0MvbCUQtpGh7mDKJ
 n5s6gDYhv2cUR2wa59ZKihcOHzLMjeYDzNMfY
X-Gm-Gg: ASbGncsyO92QlX6hs4vaVtHLvbPSCzN4SfWZN9FGfXavSt1iCy0Ir8a2Mq3rRK9yHf0
 /ps+x6Lj8bozqsfTbTV81ctMI1ydzZLILHBPvVNCS+PxZf3WHBcj7eBHsOwsiYBuU7iaGKJTF2r
 jcxaeo502BXk9nZ94Kt91/5VxyxwQ=
X-Google-Smtp-Source: AGHT+IGjLBwLDyhWig6R3ctbGXJzFnOtBL8KZeiVUTtBrZnA1SP6TPR3ZK/jWCUHEEdyGa8ctzPJNJcfQSwljIhTxto=
X-Received: by 2002:a17:907:3f18:b0:abf:6b30:7a94 with SMTP id
 a640c23a62f3a-ac20e151231mr871362966b.45.1741283777786; Thu, 06 Mar 2025
 09:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20250305183544.40525-1-hd@os-cillation.de>
 <20250305183544.40525-3-hd@os-cillation.de>
 <33908f3c-b8d2-4beb-8caa-d6ff7cc3317c@cherry.de>
 <edbda604-e8f8-4f4c-b506-2dfb528fe10d@os-cillation.de>
In-Reply-To: <edbda604-e8f8-4f4c-b506-2dfb528fe10d@os-cillation.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Mar 2025 10:56:03 -0700
X-Gm-Features: AQ5f1JrOpMzGrkqZDki7Y41Jsw6rfrrCdN0bhF5_c-RLEVoV7LdSaMHtu2yPI7E
Message-ID: <CAFLszTjxFRf1tkFc-eSJ7W7oUeFFW7J3eGQHxrMebqR5P7N3RQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Makefile.lib: Set xPL build related defines for DTB
 build
To: Hendrik Donner <hd@os-cillation.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, 
 Oliver Graute <oliver.graute@kococonnector.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Michal Simek <michal.simek@amd.com>, Prasad Kummari <prasad.kummari@amd.com>
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

Hi Hendrik,

On Thu, 6 Mar 2025 at 09:28, Hendrik Donner <hd@os-cillation.de> wrote:
>
>
> Hello,
>
> On 06.03.25 11:18, Quentin Schulz wrote:
> > Hi Hendrik,
> >
> > On 3/5/25 7:35 PM, Hendrik Donner wrote:
> >> [You don't often get email from hd@os-cillation.de. Learn why this is
> >> important at https://aka.ms/LearnAboutSenderIdentification ]
> >>
> >> The CONFIG_*PL_BUILD defines are currently not defined when
> >> preprocessing the dts files, leading to build problems with binman. Set
> >> the defines based on the related CONFIG_*PL values.
> >>
> >> Tested-by: Oliver Graute <oliver.graute@kococonnector.com>
> >
> > Please have this person publicly answer they tested it instead of having
> > it already in the v1 of the patch, too easy to impersonate someone and
> > give a false sense of trust into a patch that may not actually have been
> > tested.
> >
> >> Signed-off-by: Hendrik Donner <hd@os-cillation.de>
> >> ---
> >>   scripts/Makefile.lib | 10 ++++++++++
> >>   1 file changed, 10 insertions(+)
> >>
> >> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> >> index 54403040f00..dd2c6363224 100644
> >> --- a/scripts/Makefile.lib
> >> +++ b/scripts/Makefile.lib
> >> @@ -217,6 +217,16 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -
> >> nostdinc                    \
> >>                   -
> >> D__ASSEMBLY__                                          \
> >>                   -undef -D__DTS__
> >>
> >> +ifeq ($(CONFIG_SPL),y)
> >> +dtc_cpp_flags += -DCONFIG_XPL_BUILD  -DCONFIG_SPL_BUILD
> >> +endif
> >> +ifeq ($(CONFIG_TPL),y)
> >> +dtc_cpp_flags += -DCONFIG_XPL_BUILD  -DCONFIG_TPL_BUILD
> >> +endif
> >> +ifeq ($(CONFIG_VPL),y)
> >> +dtc_cpp_flags += -DCONFIG_XPL_BUILD  -DCONFIG_VPL_BUILD
> >> +endif
> >> +
> >
> > You don't actually explain what you're trying to fix here and why this
> > fixes it?
> >
> > Why would you need those symbols for the DT?
> >
>
> well they are already in use in tree ([1], [2]), which breaks the build.
>
> The history of both files is that the guards were introduced as
> CONFIG_SPL, which builds, to CONFIG_SPL_BUILD, which should break the
> build, haven't tested, and somewhat recently to CONFIG_XPL_BUILD,
> which is when i noticed that it breaks the build for me.
>
> Now the guards are around SPL specific nodes, so i didn't question it.
> My understanding was that those are needed not necessarily during the
> SPL phase, but only if SPL is defined at all.
>
> If i understand you correctly none of it should have been introduced
> like that in the first place?
>
> I noticed it's broken in the uboot CI run too, but since the boards
> need firmware blobs the CI build is erroring out in the first place, so
> i guess no one noticed.
>
> > For removing nodes in xPL, you can use one of the bootph- properties.
> >
> > The DT is supposed to represent the HW, so having a different DT between
> > stages is very likely wrong. Note that having a subset of the full DT in
> > xPL stages is a bit of an exception here, for size purposes (usually
> > because of limited SRAM) or boot time purposes (you don't need to enable
> > everything in the DT in the first stage after BootROM simply to init
> > UART and DRAM :) ).
> >
> > As for binman, why would it even need to be run during the xPL build
> > stages? Can you provide more context on this?
> >
> > We have some big nasty ifdefery in arch/arm/dts/rockchip-u-boot.dtsi for
> > example, which has some logic on whether some symbols are defined, but
> > they are defined regardless of the stage and I assume binman gets run
> > only once, and not in xPL build phase? Is this something not applicable
> > for (I assume that's the user of that) imx8?
>
> The arch/arm/dts/rockchip-u-boot.dtsi ifdefery is based directly on
> CONFIG_SPL, not CONFIG_SPL_BUILD nor CONFIG_XPL_BUILD, so maybe the 2
> dtsi i mentioned should have kept using CONFIG_SPL in the first place.
>
> So move those back to using CONFIG_SPL?

Yes, that is the best thing. The condition should be whether xPL is
enabled, not whether this is the xPL build.

We must not allow xPL_BUILD in .dts files since it will make it
impossible for binman to produce a functional image in many cases.

Can you perhaps look at a checkpatch test for that?

>
> Regards,
> Hendrik
>
> [1]
> https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/imx8qm-u-boot.dtsi#L13
> [2]
> https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/imx8qxp-u-boot.dtsi#L13
>
> >
> > Cheers,
> > Quentin
>

Regards,
Simon
