Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650FFC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB761808B6;
	Wed,  5 Mar 2025 15:15:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PDv/hKJQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93C9A80E94; Wed,  5 Mar 2025 15:15:45 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 086FA8083E
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:15:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e4f5cc3172so8625207a12.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741184142; x=1741788942; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFAD5w0b16qURvplUDbr9wbpqXx3q0KIA+LMJtl1GJU=;
 b=PDv/hKJQCe/VLgYXyDXcFiRaNytQlg7Gq/xb/oQSxTeR1ORorowgh+21XPh+GGuNjv
 SeQxuQwa1uYIJX/5fzsufoaZr2A5+kN/aYOnPUOBkYshvM+GSpk7km8Hhck31EfRBL/f
 YJ7L0NcZPDs34zQC4pMnCgb/pb8rm0ascpvFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741184142; x=1741788942;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFAD5w0b16qURvplUDbr9wbpqXx3q0KIA+LMJtl1GJU=;
 b=uPIHwPoDwg6xybr8Agajaa6HljObSXc7z5JnbBVNe0gFOLuRTJdUrzAh6fsJdCVQFy
 ULqnIjTtbqEhELASDCd2Lln2dV4sFgEqxI8qdo5bLMpk4glMgYJX+8Ekiyef9wG5Bb1j
 iLOGYvJTWkgP2jwTqdh7a0kDZHWaL29jJzS1HNHfHcYsqU/me/DXM+AZjOirC1+FwO97
 dNTFxqQ+DzDjCY07Wuy8y6jJm+YLKy8bxYu2V/gjAM4tMD90dRBGYL/iJRKkN3YEEBR9
 f3i9I5c3X0AZ808QdUr8iS4j255NsHzlnJp8jzCNTDTy7rKxPkmgbvOPG3Sh3OJ2xqsv
 4LQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIfVA1X/6vlAJKOYQY17rbuACAN4kmPkcxZJrCdkYBPoslx86WIg2jnQBvwD51YtoGTy80ETo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxh+4MsC97re/FhV/OB12yZeTQizzX4xeRu0a+9ttijeTCZjbSY
 gvZs6i+JA/ZKj5I4qL19HR97LGafeGsIIhqpVWOhWIqm5/KKPNXkpPmPUaVr6cnCY3S2GZEQ8hU
 0iJFbFfNCudCjevVNylpbIdijOJ5g1A1kMGb2
X-Gm-Gg: ASbGncuAIlMYThli/4i9lcy405yM0ZHFQU+FBsymBCdz4JJMLo54Tnc6LvU0117RgWY
 P789L48ThKsqah9aAf9h6EyYPELL5PUT3MPN4MPRmAfoAWwSTxOvnXwHcryHwM+CHRouXy5A9uz
 vTlCWdjgXRbsdPMelIwm3HSYf41bQ=
X-Google-Smtp-Source: AGHT+IF4IVD0Pz8TL6bfBLKGaneR3UEp6odr22LJLC/0IfCVAujp6gfvUY5aJY0MAXifSzGY+vKCdnuK/YbMZ9EcUqo=
X-Received: by 2002:a17:906:c108:b0:abf:78b6:c56e with SMTP id
 a640c23a62f3a-ac20d8bcad3mr317444366b.16.1741184142327; Wed, 05 Mar 2025
 06:15:42 -0800 (PST)
MIME-Version: 1.0
References: <20250212091820.213895-1-m-shah@ti.com>
 <445f7dd4-d445-41a2-ad0b-f0c2002f3f1a@cherry.de>
 <5ea8ee8e-1643-4b4b-974c-627f1958edd8@ti.com>
 <b98194df-a613-459a-b28c-7ecf5082433b@cherry.de>
 <CAFLszThGNW-XO93MG7riBkSG==8K7vYO5Z0TkB46AWcS+SdB2Q@mail.gmail.com>
 <82953044-5f64-412b-84e4-382eb694bd0d@cherry.de>
In-Reply-To: <82953044-5f64-412b-84e4-382eb694bd0d@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Mar 2025 07:15:27 -0700
X-Gm-Features: AQ5f1JqHgZciJRDew9avpMcR8MmOUdDWnRHlTqs7QMHeUTdHJ2RpBrLWCDjMjXo
Message-ID: <CAFLszTggtFV14q_ZrOpZjSAv4gDohPpGnjvMx9BsBEU23SbSNg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2 v1] Propagate bootph* property to all parent nodes
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Moteen Shah <m-shah@ti.com>, u-boot@lists.denx.de, trini@konsulko.com, 
 m-chawdhry@ti.com, n-francis@ti.com, vigneshr@ti.com, u-kumar1@ti.com, 
 a-chavda@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Quentin,

On Fri, 28 Feb 2025 at 04:04, Quentin Schulz <quentin.schulz@cherry.de> wro=
te:
>
> Hi Simon,
>
> On 2/27/25 5:24 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Wed, 26 Feb 2025 at 03:53, Quentin Schulz <quentin.schulz@cherry.de>=
 wrote:
> >>
> >> Hi Moteen,
> >>
> >> On 2/26/25 6:57 AM, Moteen Shah wrote:
> >>>
> >>> On 17/02/25 20:32, Quentin Schulz wrote:
> >>>> Hi Moteen,
> >>>>
> >>>> On 2/12/25 10:18 AM, Moteen Shah wrote:
> >>>>> [You don't often get email from m-shah@ti.com. Learn why this is
> >>>>> important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>>>
> >>>>> In the U-Boot pre-relocation stage, if the parent node lacks bootph=
*
> >>>>> property and the driver lacks a pre-reloc flag, all of its subseque=
nt
> >>>>> subnodes gets skipped over from driver binding=E2=80=94even if they=
 have a
> >>>>> bootph* property.
> >>>>>
> >>>>> This series addresses the issue by scanning through all the subnode=
s
> >>>>> of the current node for the bootph* property and propagate it to al=
l
> >>>>> of its supernodes, ensuring that all of the applicable drivers are
> >>>>> bound and probed prior to relocation. This series implements one of
> >>>>> the solutions mentioned in [0].
> >>>>>
> >>>>> Since, all the nodes which are not having any bootph* property will
> >>>>> also be traversed, we will have to incur some overheads in boot tim=
e,
> >>>>> hence protecting the feature under a config.
> >>>>>
> >>>>> Boot time overheads:
> >>>>>       Baseline: Upstream u-boot
> >>>>>
> >>>>>       Patch test: Baseline + remove all bootph-all properties from
> >>>>>       *-u-boot.dtsi except the ones which are supposed to be probed
> >>>>>       but have no bootph in any of its subnode.
> >>>>>
> >>>>>       J7200 delta from baseline  : ~100ms
> >>>>>       J784S4 delta from baseline : ~350ms
> >>>>>
> >>>>
> >>>> Pfew, that's a lot of time. Can you tell us what's the delta in
> >>>> percentage from baseline? Because if your system is usually booting =
in
> >>>> one minute, 100ms isn't too bad :)
> >>>>
> >>>
> >>> Our system's boot time is about 2.2s (J7200) and that of J784s4 is 2.=
7s
> >>> (owing to a larger DT).
> >>>
> >>
> >> OK so respectively 4.5 and 12.9% boot time increase if I'm doing maths
> >> the right way, that's really a lot :/
> >>
> >>>
> >>>> FYI, I believe we've been hit by this issue on Rockchip but cannot
> >>>> find the thread or patch right now.
> >>>>
> >>>> For TPL and SPL, the Device Tree is parsed and looked for appropriat=
e
> >>>> bootph properties. Any node which doesn't have a bootph property and
> >>>> doesn't have any children with a bootph property is removed from the
> >>>> tree. However, the bootph property (if only present in a children
> >>>> node) isn't propagated (meaning the node doesn't get the property).
> >>>> This is done by fdtgrep.
> >>>>
> >>>> The issue is that for U-Boot proper pre-relocation, the whole DT is
> >>>> taken and only nodes with the appropriate bootph property is probed
> >>>> and children nodes do NOT count as opposed to the TPL/SPL case.
> >>>>
> >>>> My idea was that maybe we should rather propagate the property, at t=
he
> >>>> very least in U-Boot proper pre-relocation. This does mean we will
> >>>> increase (by which amount?) the size of the DT in U-Boot proper
> >>>> because we would add this property recursively up the tree from a no=
de
> >>>> that has the bootph property for U-Boot proper pre-relocation. This
> >>>> **could** be an issue as the DT could be passed between stages and w=
e
> >>>> would then hit the size limit. Sadly, I didn't take the time to look
> >>>> into adding support for that in fdtgrep nor will I have the time to =
do
> >>>> it, so take this as me sharing my wish list with you.
> >>>>
> >>>
> >>> Thanks for sharing this, the size increase this patch introduces for =
48
> >>> such bootph-* tags is about 1.5KB's, we can go ahead and bind the sup=
er
> >>> parent to bypass the part of adding the tag, but for the next parent =
we
> >>> will have to traverse again down the DT adding in unnecessary
> >>> traversals(considering a case that we are 4-5 levels deep in the DT).
> >>>
> >>
> >> j784s4-evm/u-boot.dtb is 131616B
> >> j7200-evm/u-boot.dtb is 88368B
> >>
> >> so 1.5KiB would mean respectively, 1.1 and 1.7% in **DTB** **size**
> >> increase, not sure how that translate in terms of boot time though.
> >>
> >> Reading Tom's notes from the meeting a few days ago where this was
> >> seemingly discussed, I believe the issue is that the kernel wants the
> >> bootph- property only in the child node. But I assume this applies onl=
y
> >> to the DTS, which would be fine with this build time propagation of th=
e
> >> bootph- properties to node parents recursively. Would the kernel also
> >> want the same limitation for the DTB?
> >
> > It doesn't matter to the kernel, since there is no restriction as to
> > which nodes such a property can be added.
> >
> > I like the binman route as it lends itself to further optimisations in
> > the future. For example, we might provide an ordered list of node
> > offsets to process before relocation.
> >
>
> We already have bootph- properties for pre-reloc, why would we need an
> ordered list of node offsets to process before relocation? What's the
> idea here?

Just to save execution time.

>
> > But we could also have an algorithm which maintains a small list of
> > node-offsets which have been visited and have the required tag, so
> > avoid constant re-traversal.
> >
>
> Why can't we use the same behavior we have for bootph- properties for
> TPL/SPL in pre-reloc, why do we have to have a completely different
> implementation there?
>
> In the worst case, we could have a separate DTB for pre-reloc too,
> stripped down the same way it's done for TPL and SPL for example.

The reason we (already) have a completely separate implementation is
that the unwanted nodes simply aren't present in xPL. So there is no
need to check for tags.

>
> > Ideally, pre-relocation, we should not need a lot of drivers, since
> > SPL has done much of the early-init work already. Perhaps a UART and
> > not even any pinctrl / clocks / power?
> >
>
> I can tell you I need the storage medium used by SPL to load proper to
> be in the pre-reloc phase of proper for everything to work properly, so
> "just UART" is not good enough for me.
>
> So, SPI flash, SPI controller, eMMC controller, SD controller, pinconf,
> pinmux, clocks, ... c.f. 100f489f58a6 ("rockchip: rk3399: Fix loading
> FIT from SD-card when booting from eMMC") (yes the commit is about
> fixing FIT loading, but see the end of the commit log).

In principle I don't see why. If there is a full-featured SPL, then
U-Boot really doesn't need to do much in its pre-relocation phase.

One of the challenges is that we can't remove clock/power/etc. because
drivers expect them. For example the UART will use the clock to set
the baud rate. But we can check for -ENOSYS and assume that we don't
need to do it.

>
> I don't think it makes sense to have an automagic solution that decides
> which nodes should appear or not. We already have bootph- properties for
> that.

Are you referring to my 'ordered list of nodes'? It's just that we can
do a little pre-processing and save time. It would need to be part of
the DT though, so it's a bit tricky....

>
> I feel like I'm missing something from the big picture, can someone tell
> me what it is :) ?

We're just trying to reduce the time taken by board_init_f(), which
seems too high on some platforms.

Regards,
Simon
