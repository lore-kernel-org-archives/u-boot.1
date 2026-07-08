Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66014C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 20:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B83F847AF;
	Wed,  8 Jul 2026 22:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hgNFi6yW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 772668496E; Wed,  8 Jul 2026 22:21:04 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0EAE843B6
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 22:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-693c51a8a19so258236a12.3
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 13:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783542061; cv=none;
 d=google.com; s=arc-20260327;
 b=R0+cgC0fLDqJHF0SjrPQgq12B4Mg/LZVWHsbYDq+tftAdduTb8kxurvJC6/l1cCHW8
 /LlG1fDhkBLD5Ob+q1zclNhM6PhJy0oaxZmhQrM58ErVV7gdklcOm+7mhd4/FliBCxbp
 lhlrxcf++k5zcrjk3Z24aGdaIQaUz3GG8BjuckW1P+Zh9xbcCZxLWKRgIQNq0jNU7d4j
 thip9XvHvcZzmIhSvyLR/GrHF6jlnqyZrYJvwEmDznqNFHo426pFOOtMIZMdfw/GC2pX
 0nF6UWMwKexHKPlr5k+n66GxtZsZSSlA7dtFvxLWxQAHUmMXTKf9vLOGtPB1dQQs8CU1
 hvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rIqi0d9mBl0CF2hPDjnR/p39KKeTaDsJymLxd7SOz4g=;
 fh=BjJQoWpAXQ7+eYv08gDu5lkGVjVwoUD402CnFaLJvqI=;
 b=hQwBzykRxuXtdNVReDQULz0fgMu3RIRBCwBwwgo11FEBcTdR8u/lgvb5b5tlQ8q95q
 Aecv1TNKKCSPU5tywVnRwTZl5Gr280N7t250CL/4rJL8UcquUUI5OG3PzQ5dRcMTUpgG
 UCJ8D65zZzU/XqLcOYsOdIkAUfMJZkMaSXa7Wubjhaw8Yu6nWiMi9s85NKr5AFgUYRzz
 QMcikjN7UQ9I5oGADjsQQIRuERwv+8mbmUv/9EWZ8AlKhaoxcrOkr3sMfBAp6/n/CyVU
 JfRnQjxGcw5wqQFmxQDXmMDQQvmYxdhtpmpADAop42WTEvZVZv/wKyPvZYEHDtAPspgS
 HFoQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783542061; x=1784146861; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rIqi0d9mBl0CF2hPDjnR/p39KKeTaDsJymLxd7SOz4g=;
 b=hgNFi6yWETSz4r2Hn1b4MmvK8rXN6YPxr1ROdCRNyENjCTBYF0nJ6kIXCMSjWB2QK7
 rg4uT31ehpL8w0AGnByEOfE8uo3CRjxEiIKXIK2b/7xP8fwe0cJGav3FYYsZYKNgor+X
 9k13HmMWxKxyQQbA9agM7dcM04q8WC48RWUBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783542061; x=1784146861;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rIqi0d9mBl0CF2hPDjnR/p39KKeTaDsJymLxd7SOz4g=;
 b=NnA7kH0k5YeGeSGm4YY3kM5gET85MIEgo7+4SejK54GGOJlvHLASH6U2Ok4FL4mXYT
 UKd4W8otyr77OpG9Aw6BYddIzyds7NrfDMDH02HpdSN4zDUfco4BPNf9hGD029NTqPkD
 UA0rHYhnpP2++HAqQj1wdSltGX1p0q+8P5QEnjRc1yYwXk0I5Ot/DjY9AbkdhPJgN8c3
 j1cw2lptlupLGn8txJYlm6Z3t/AYh8wk1Xuzf7wq2p85UvVT3CgYn6BmFWCOoWY2D8PI
 mWUAmnKn61txTpuUhSk+5gDS8IGPZ4nson4UF2UE7gAR/EogX7NWZ2qddnP/5A5g2/OB
 6LQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLsSIS4lGJb1hggriOIgyz0++mtOmfD/6rUEqgtLhoShqISJQklKnvvw6aOcoeS6OHqJzxiTk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3DOyycn8XAgqJbKqILPPgnGvyAI3COCUSBGAETzPHeR8bpvM0
 7UojR00FTs8hqGJXLzRA6tPnCv4C3jfHhNy7ortZuVtVkZ1UnI393dzis2bIDjx5ZtLsTeHZvSz
 rlyEMhQ+wSFahl0Vc8mGHnFWG87SPzpKHD3nGE8ejyMYLH5RIjZR5wA==
X-Gm-Gg: AfdE7cmbJFQkdRfGljOrDYjHByYilw4ZuSRRUy6L+ORktRJTQyfBsQcHm+yRaKp5oqt
 i4X+/t+4JD0Bq7nyZnAQjtT+V8djyeXt6tSGcuZy350KHdAfz4xGglczOstR4JxH67qr63MSdQU
 Tb/xiVxYFUWrrwxQQuKS8wkRzW8MGhak2Hx/MMXn1hy2CO2jpbgg+/Ym0F8P6LENmbD0gsEQC9L
 u8nwO3ZJwHSu+byLvODHZWdDZUm7Po6BU4XIl98vvop3eSseChVEmJ1o/ny2d2QNtZvPuo=
X-Received: by 2002:a05:6402:51c6:b0:69a:9c13:a2a2 with SMTP id
 4fb4d7f45d1cf-69ab44ab465mr1835809a12.41.1783542061112; Wed, 08 Jul 2026
 13:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
 <6c21c8d8-74c0-43bc-9249-6cc1dc401136@linaro.org>
 <CAFLszTjGwi0MhX3wNH0eGVsumG=8c48hupe86eS_8E+J+LNdBA@mail.gmail.com>
 <CALeDE9MSA5RGEuBseiSrj6-yw9a44=0+PWC8=_HKboC-fWkkzQ@mail.gmail.com>
 <CAFLszThAqVjZ0Jd5kdB5q=bhGTNpAeHw3WXpUHnFQ_OH_KmXLA@mail.gmail.com>
 <6d0f3078-2ba8-474c-9a1f-481eeb7f47bf@cherry.de>
 <CAFLszTi+4s51HtaQrgBLEsOzoCjtZ+CGdvqBm4B9_fj-rpKqwg@mail.gmail.com>
 <CALeDE9OWeMs3peX8+4+i6iTmZn-EO2e+7s7q6S1yFaRUa0dksQ@mail.gmail.com>
 <CAFLszTg24RTHi0A0vWfv62FfZhm1Uz4iw=4m7NZ6_4W3R3kwyQ@mail.gmail.com>
 <CALeDE9Mcg2TUcnv3LD4k2pmCnogV97KqjUn-dQiDfAZt+hPN4Q@mail.gmail.com>
 <CALeDE9O4cPp7aWsiHreqOt_sE4t=y5MzvnyuCCGpwzD6hFjuAg@mail.gmail.com>
In-Reply-To: <CALeDE9O4cPp7aWsiHreqOt_sE4t=y5MzvnyuCCGpwzD6hFjuAg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Jul 2026 14:20:48 -0600
X-Gm-Features: AVVi8Ceh_IWCmBdzjsX3wlta0wnouwsYUNKrtGVths5eaAg5UW7etP2kVCC-0Og
Message-ID: <CAFLszTgRUEGG6UpfE0X83RXPU_pb8ZAMv18zNrmcHbrvyg=k5A@mail.gmail.com>
Subject: Re: U-Boot Concept Tree Proposal
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, tom.rini@konsulko.com
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

On Mon, 6 Jul 2026 at 10:15, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Didm't mean to leave the list off my reply.
>
> On Mon, 6 Jul 2026 at 16:18, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > Hi Simon,
> >
> > > > In the follow up private discussions about it after it was clear as a
> > > > whole that the PLC was uncomfortable with a specific websiite (we
> > > > don't plan on supporting forks, would we provide that feature for all
> > > > forks?) for concept. I offered the idea of a custodians tree to allow
> > > > you to develop and maintain the features that you were preparing for
> > > > upstream in your concept tree to enable easier collaboration for those
> > > > that wished to work with you on those specific features. Maybe I
> > > > wasn't clear enough in my communications but it was never intended to
> > > > be the location to host a fork.
> > >
> > > A fork would be something which forks off mainline and goes its
> > > separate way. Concept is not a fork. Perhaps a constantly merged,
> > > multi-feature branch would be a better term. Please read my original
> > > email again on this point and I'm happy to explain it further. Quite a
> > > few series have already found their way to mainline.
> > >
> > > > So I think you need to revist what the idea of concept actually is and
> > > > come back to the community with an adjusted proposal.
> > >
> > > It seems that you are rejecting the whole idea of a Concept tree (my
> > > original post on this thread). Can you please confirm that? But if you
> > > have ideas on how it could work with modifications, please share them.
> > > There must be some common ground somewhere.
> >
> > Nope, not at all rejecting it, what I was saying is that I don't
> > believe you have got the community to buy into your idea. I don't see
> > it as the PLC's job to reject/accept it, as I've always stated it's a
> > community decision, of which I am but one voice.
> >
> > On ideas I believe I have already shared the idea of working branches
> > for features you believe should be in mainline U-Boot. Outside of that
> > I don't have other ideas, but it's also not my concept.
> >
> > > > First though, I repeat again, would you please explain to the
> > > > community why you are holding the u-boot.oirg domain hostage to try
> > > > and force the PLC to accept an idea that we have been explicit about
> > > > the need to get the community to buy into this "concept". I think the
> > > > community deserves an answer.
> > >
> > > This is a bit of a one-sided view. The real situation is that for many
> > > years to implement major features and improvements in U-Boot, but that
> > > became progressively more difficult as Tom started refusing to accept
> > > series and I have no ability to get PRs applied. Perhaps I was naive
> > > to expect our good working relationship would continue forever, but I
> > > have contributed a huge amount to U-Boot and having the rug pulled out
> > > felt very unfair, not to say bad for the project. Regarding the
> >
> > So that gives you a right to hold the domain hostage why?
> >
> > Also your past contributions doesn't give you a free pass to force the
> > landing of patch series that you think should be in there. That's not
> > how open source works, it's certainly not how this project works.
> >
> > I think you need to step back and ask yourself why you're finding it
> > hard to get patches reviewed and accepted.
> >
> > To give you an idea I have had numerous community members complain to
> > me about you, I am sure Tom has similar, some are to the point where
> > the only way they will deal with your code is if it's part of the
> > subsystems they maintain and hence it ends up in their patchwork queue
> > and otherwise they actively filter mails out from you so they don't
> > see them. I don't keep a count or details but it's well over 5 and I
> > may even have to start using something other than fingers.
> >
> > To put in straight forward terms, a lot of people are fed up with your
> > behaviour, then when you get called out for it, or Tom has to have a
> > conversation with you about it rather than addressing the actual issue
> > you "take some time out" and come back a few months later without
> > actually addressing your behaviour.
> >
> > Now you're holding the domain hostage which is similar bad behaviour.
> > Not to even mention that you registered a US U-Boot charity and
> > attempted to register the trademark all without telling *ANYONE* in
> > the community what you were doing. Did you think you could just walk
> > away and keep the project "Because of all your contributions"? Again,
> > while you have contributed a lot I think the wider community of
> > contributors as a whole have contributed more, and by contribute I
> > don't just mean purely on the lines of code, but reviews,
> > architectural discussions and all sorts of other things that actually
> > make a community and it gives you no right of ownership over the
> > project.
> >
> > I'm sorry Simon but the way to get your patches reviewed is to rebuild
> > your standing with the community not by trying to force an official
> > recognition of a fork by holding the domain hostage.

Reading this I feel that you have imputed all sorts of motives which
are not there.

> >
> > > domain, I have offered to point subdomains to anywhere you wish, which
> > > would resolve this. In the meantime I have mirrored the website and
> > > moved various things away from the domain. But I cannot support the
> > > sort of split that happened with Barebox, if that is your goal.
> >
> > And as I've stated we can't use it that way, the SFC has requirements
> > around the project's assets (which include things like domains) as
> > Neal has explained and I am fairly certain as has the SFC. Also
> > there's dynamic infrastructure where we need to be able to move things
> > with little notice so it would cause outages without the control of
> > the domain.
> >
> > > I don't mind hosting a separate tree somewhere else, if that is your
> > > preference, but it needs to have some relationship with U-Boot and a
> > > clear understanding of what that relationship is. If that is not
> > > possible / acceptable, then I suppose we should close this thread. I'm
> > > skeptical of our ability to resolve complex things on mailing lists in
> > > cany case, although I started this thread at your request.
> >
> > As I've stated numerous times before you need to get the community to
> > buy into this.
> >
> > You have kept this "secret" from the community for a very long time,
> > and by secret you've not been open about your intentions, until we
> > explicitly asked you to go and explain it to the community.

Well my hope was that we could make some progress and I did take up
your suggestion. But it seems to have just resulted in creating more
disagreement. I'm sure that wasn't your intention, but it seems you
were genuinely surprised by what I wrote.

I don't want to suggest that I had a clear idea or plan about any of
this when I set up my tree, other than trying to figure out a way to
unblock my efforts. But in writing up this Concept idea I thought it
would add real value to the project. I still recall that you shot down
standard boot and that was around the beginning of all this.

[..]

Regards,
Simon
