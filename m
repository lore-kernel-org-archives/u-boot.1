Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9FDC19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC2EC81269;
	Thu, 27 Feb 2025 17:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d9Jp0ZoB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 458E581273; Thu, 27 Feb 2025 17:25:11 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3CE3811CE
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:25:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5dedd4782c6so1974575a12.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740673508; x=1741278308; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ofWNEMpzir2UnhKIxT1gEJ55lXLHu32yBaE5ZAlHe+I=;
 b=d9Jp0ZoBv8JjAPe+QQx6N3Y8zHvKr6D5785y+oRzOLDLR4qEtYy6MsiguNWdsQ5T6f
 fRzOogkptiM769vfhLpgnR0erl725kkTWqcmSeCZLXf/G2lz+6cv4lRRaNZ0od0Ghgl4
 LPi14vgd+DhotqvqHJ0HmD/nj02OQuyQPX2wQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673508; x=1741278308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ofWNEMpzir2UnhKIxT1gEJ55lXLHu32yBaE5ZAlHe+I=;
 b=ZFR87uYxXkWetSYcoeko3fGIx+Pn0krHHBzBbliIKQt06HNIOOSps1MDJ7TzNOvv8W
 EtS4D8/uBveq5L3amJ/y5QQ009nzak+2levx0WmrQbun0qZ3dmfjI9x9rlxib8pakwEA
 iG+FiQTRTB0H0LFF/hbNh4nkbaOyKYTtg1YJ5ZQ1FTZl3Z0vscTWieX6P0B40ly63VKF
 5fUTsjgImsq29mvAOLzLGlylvK45cHkCZrskqC9njepXlr5I5N9t5Q/EJvYhnuTs/vOt
 fQEIJzeoeRzp47zDv+Bw1FTuxYPcJQUHohz78o/KIF8NNE1BlQrSKffbnD/u5HQ/6ufL
 4K+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNRmmKhv5ZcnQnHdi3sBEqKdu5zwa86CmZjKyT8NUFej5RZXSboMDQTjWvkjboy89+k0CKeiY=@lists.denx.de
X-Gm-Message-State: AOJu0Yzs3U6X0/Q6ay74gFc+tq9X+PALzz75rIhk+cwdBar3YfWInt7t
 Axxqn3czq/iR93uW03moggBZT9+aJH0m/Xq5qeuxeWdxT0e9kLH88A+lMo10sNAEb7e0doeiUM6
 ysv0p/52y4o82StncIOqmjZgL9+o3Kt9ry2q/
X-Gm-Gg: ASbGncvy+8s0rsmOr8PNH9pORYId7QlavqClfsmAdFymsGuowoK36FauOxVkHiEy6pv
 dUlKa4y0f1Pi/9b+s8zaXs9Oa5NIVjkXmf2eermZal0fnXrIi2srxFUOsP4gr6Q9X/+uk3HLv81
 rZaQPyU4iv
X-Google-Smtp-Source: AGHT+IGtvK1OoUU/Kb5b1JinnStm39TQeYUN8t5Jbfk5P9fI1T7fRuSeIpMnkIywYU8k1xqsUEeQ7/7A8ZDy1g9cH6M=
X-Received: by 2002:a17:907:7f91:b0:aba:7a3a:e267 with SMTP id
 a640c23a62f3a-abf265b58a4mr4202966b.45.1740673508218; Thu, 27 Feb 2025
 08:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20250212091820.213895-1-m-shah@ti.com>
 <445f7dd4-d445-41a2-ad0b-f0c2002f3f1a@cherry.de>
 <5ea8ee8e-1643-4b4b-974c-627f1958edd8@ti.com>
 <b98194df-a613-459a-b28c-7ecf5082433b@cherry.de>
In-Reply-To: <b98194df-a613-459a-b28c-7ecf5082433b@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Feb 2025 09:24:55 -0700
X-Gm-Features: AQ5f1JqmO15T-KaT6LMG4IhPCI5BezVpSalThKA6iUW1JiMx8IvTzV9fFR0igIc
Message-ID: <CAFLszThGNW-XO93MG7riBkSG==8K7vYO5Z0TkB46AWcS+SdB2Q@mail.gmail.com>
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

On Wed, 26 Feb 2025 at 03:53, Quentin Schulz <quentin.schulz@cherry.de> wro=
te:
>
> Hi Moteen,
>
> On 2/26/25 6:57 AM, Moteen Shah wrote:
> >
> > On 17/02/25 20:32, Quentin Schulz wrote:
> >> Hi Moteen,
> >>
> >> On 2/12/25 10:18 AM, Moteen Shah wrote:
> >>> [You don't often get email from m-shah@ti.com. Learn why this is
> >>> important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>
> >>> In the U-Boot pre-relocation stage, if the parent node lacks bootph*
> >>> property and the driver lacks a pre-reloc flag, all of its subsequent
> >>> subnodes gets skipped over from driver binding=E2=80=94even if they h=
ave a
> >>> bootph* property.
> >>>
> >>> This series addresses the issue by scanning through all the subnodes
> >>> of the current node for the bootph* property and propagate it to all
> >>> of its supernodes, ensuring that all of the applicable drivers are
> >>> bound and probed prior to relocation. This series implements one of
> >>> the solutions mentioned in [0].
> >>>
> >>> Since, all the nodes which are not having any bootph* property will
> >>> also be traversed, we will have to incur some overheads in boot time,
> >>> hence protecting the feature under a config.
> >>>
> >>> Boot time overheads:
> >>>      Baseline: Upstream u-boot
> >>>
> >>>      Patch test: Baseline + remove all bootph-all properties from
> >>>      *-u-boot.dtsi except the ones which are supposed to be probed
> >>>      but have no bootph in any of its subnode.
> >>>
> >>>      J7200 delta from baseline  : ~100ms
> >>>      J784S4 delta from baseline : ~350ms
> >>>
> >>
> >> Pfew, that's a lot of time. Can you tell us what's the delta in
> >> percentage from baseline? Because if your system is usually booting in
> >> one minute, 100ms isn't too bad :)
> >>
> >
> > Our system's boot time is about 2.2s (J7200) and that of J784s4 is 2.7s
> > (owing to a larger DT).
> >
>
> OK so respectively 4.5 and 12.9% boot time increase if I'm doing maths
> the right way, that's really a lot :/
>
> >
> >> FYI, I believe we've been hit by this issue on Rockchip but cannot
> >> find the thread or patch right now.
> >>
> >> For TPL and SPL, the Device Tree is parsed and looked for appropriate
> >> bootph properties. Any node which doesn't have a bootph property and
> >> doesn't have any children with a bootph property is removed from the
> >> tree. However, the bootph property (if only present in a children
> >> node) isn't propagated (meaning the node doesn't get the property).
> >> This is done by fdtgrep.
> >>
> >> The issue is that for U-Boot proper pre-relocation, the whole DT is
> >> taken and only nodes with the appropriate bootph property is probed
> >> and children nodes do NOT count as opposed to the TPL/SPL case.
> >>
> >> My idea was that maybe we should rather propagate the property, at the
> >> very least in U-Boot proper pre-relocation. This does mean we will
> >> increase (by which amount?) the size of the DT in U-Boot proper
> >> because we would add this property recursively up the tree from a node
> >> that has the bootph property for U-Boot proper pre-relocation. This
> >> **could** be an issue as the DT could be passed between stages and we
> >> would then hit the size limit. Sadly, I didn't take the time to look
> >> into adding support for that in fdtgrep nor will I have the time to do
> >> it, so take this as me sharing my wish list with you.
> >>
> >
> > Thanks for sharing this, the size increase this patch introduces for 48
> > such bootph-* tags is about 1.5KB's, we can go ahead and bind the super
> > parent to bypass the part of adding the tag, but for the next parent we
> > will have to traverse again down the DT adding in unnecessary
> > traversals(considering a case that we are 4-5 levels deep in the DT).
> >
>
> j784s4-evm/u-boot.dtb is 131616B
> j7200-evm/u-boot.dtb is 88368B
>
> so 1.5KiB would mean respectively, 1.1 and 1.7% in **DTB** **size**
> increase, not sure how that translate in terms of boot time though.
>
> Reading Tom's notes from the meeting a few days ago where this was
> seemingly discussed, I believe the issue is that the kernel wants the
> bootph- property only in the child node. But I assume this applies only
> to the DTS, which would be fine with this build time propagation of the
> bootph- properties to node parents recursively. Would the kernel also
> want the same limitation for the DTB?

It doesn't matter to the kernel, since there is no restriction as to
which nodes such a property can be added.

I like the binman route as it lends itself to further optimisations in
the future. For example, we might provide an ordered list of node
offsets to process before relocation.

But we could also have an algorithm which maintains a small list of
node-offsets which have been visited and have the required tag, so
avoid constant re-traversal.

Ideally, pre-relocation, we should not need a lot of drivers, since
SPL has done much of the early-init work already. Perhaps a UART and
not even any pinctrl / clocks / power?

Regards,
Simon
