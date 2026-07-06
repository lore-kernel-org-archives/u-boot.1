Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B58C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 16:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D330846FD;
	Mon,  6 Jul 2026 18:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nTliemv9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A7F584852; Mon,  6 Jul 2026 18:15:20 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE705846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 18:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-8f24f290af5so27352956d6.1
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 09:15:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783354516; cv=none;
 d=google.com; s=arc-20260327;
 b=VMxNXUJp+6aeyT6abITtflxx7+hof3lvp5KL43RosmvVQkO/dVLWm+BXsEyDItOLoL
 ffjbw/VUy8RBkAf3vCFGGx0dCohJZGBVFvvKkO3iyUCKToxFMMEAvQPU7s2I/pUAJ+rm
 zQW3uz60F7yc7o/xhvIOGRMS4ExoHHDTmKYZZZoGUax06Pp1I9ThPRDs3hpK8BjgyRaj
 f0+iEys5gFQvjEUle+jPcRpL/0dYKROSVWXkpiDW+3NIMX9kbweaM1BQ+0uZBkcho7e3
 niaNXaE8oV0fbUPCfREYUSYQcHYsEYkvcdVAlBYKs+ayEc81We/JcsphOXRBnwssJRAe
 PS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lmEfPYACKAOGUScLdrTsTGpYHUscTU5JrLd5fWjFmoU=;
 fh=PSdG6r/FQEKksTnT+Exp5fIw872iVho500iLrPvgJhM=;
 b=a8JqZxIuLKk10qLgnQPDbKjpBr8tIk5cZQ3w97g3lVG+CPASHlyCdcZ3+WD9+fKDiL
 rQVlyc0kh5W6QJcV61bRP6/TubfojXL3WUZCxQhCJ5qYzwlWYNDlntLuOHwWJOvgH4Ke
 GZh/KkswDuwrqMkFMCBbjz/YAMoaxlCut+137hl7YnhmT1cgJLerFaQYZvaaFcobEuWD
 yzao/YvG/jilEJENUKTUsHwkfIk6vmBh/k823w3Egy+sZgw4NMNDfcG0Wrw5iIj6fJlk
 c7vV4dHJgC8nlnI13f5M/oIkg6Ll19ivyLu1bUtpz5sfM1hWIWdJTXRTGHTzjAj2xsUe
 PWqg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783354516; x=1783959316; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lmEfPYACKAOGUScLdrTsTGpYHUscTU5JrLd5fWjFmoU=;
 b=nTliemv9QLmWuy7PLHVMppInwY7mROpDyrrbE+aZKlK5TP1tXiH+h6wlnrU++OXYdV
 m3Wz450JUCrbXbloq+Y4euTNTUt1YI/ifr6bkFIDumM7k+KWPKFejbKr2PoudYzZw7+a
 Z21rhbjR9TKRjLDmmNVk8SdmGvU0B9QXh+ALTB5r2maX6Z1IEYp6eHPdRdL+LkzVHSYb
 ozx9BbiCjQZJsslf2nLwEfkm/GwSbRtetesqTRhlIIpO7T34vpup4eZgC0PT7MeH6KuD
 lHUvwbzfXKPRLmsKxrO54YUcEmL3ZIL9O74n2zsCFTf4dQ7KwDpXxgU0uoQ1YRc/Nl6w
 fdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783354516; x=1783959316;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lmEfPYACKAOGUScLdrTsTGpYHUscTU5JrLd5fWjFmoU=;
 b=o7hMAsKpi7fDg4m0olzSIQJIxyzubLAU4doGnKS6ph2KD4BefvTyiy6XFprbC+y4C2
 hNezbk8luU9T6J1phHG6bnqr4QePhLiSufO8wRlKiF3mKB0ya9KrQvQWF/1P41L1XDgb
 Lwl9q1rq+OJoP4HhQDywZpsQpPkrrPSFQ5Vm34c2jqoPJsiDdq2DbrlUW98CNT62bSpU
 wdINhiYqNBzil7wZdQ/bAS3nu42uk1kxNJ6P++Fv6OYQ9+mfO2On8SLQeQtyvRRnBlpx
 RwCjxsRKy/PWAaNdL1UT8VVllk23E7bIrQtUgJjc/Z6rdk6MKQC2bc2hg/QHzt54oaDs
 ThTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMesaco961oTQSnAXek+/2LzjV4d7bcISw1YG0O3pBjmgnzVBeg+/KevvpGOayrdaMYeH29/k=@lists.denx.de
X-Gm-Message-State: AOJu0YygcXW2Dz3EwqhCp/Xrbf98yEBq7nARPfXAryGVJ1FHWNRZz7gV
 3ho7wcmr+sjDMoDS3h1d8pchvLym5HcS2+A4YSUSamVjozPa1ReRLd0i//j2hULVw1eqo0eZzMQ
 +4860HHucBBEWKiBdLgmwjTwmUb2Ko/B7Sg==
X-Gm-Gg: AfdE7cnjp39NhmuFEDLqeRFroarh3xdsRCFaicqEi7k7QF1M3zM5RSerg5G3mr2/+NT
 rfHGTu0ATR/2gXFCt1KCCaBuGw3KJL/vm/326n2q60y73irGZm5juGDk8w25Mtmv9MQg9qRekte
 VafGCyZVzKT9E13HGrBtn8mCjP9LfLV1Pm8Fpk4ja6HzWZlR0UipcGVrnVXGVrw0hFnP4MT/r02
 K46U0TLcOVltQra6wpkN/bM24thecUE7M8O5d4a4w4PxNlekRvqCLmkCe2zv4wFAkI4EBiFhwLf
 bs0SrGbETu81+skcaCkA+0b65yY/ycZ1fKYwm1kRz+esEC+5vF2YzTGHH8hqGFcRWC4OyHpxI1Q
 a1iRfXLtMKEMpBJeb4GIfoeNSxtGitec2az2CfseH6cclALiQEFhMijx/BsJteEc/6vA=
X-Received: by 2002:a05:6214:2461:b0:8f3:e97:59c6 with SMTP id
 6a1803df08f44-8fcb25aa0dcmr14564286d6.20.1783354516098; Mon, 06 Jul 2026
 09:15:16 -0700 (PDT)
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
In-Reply-To: <CALeDE9Mcg2TUcnv3LD4k2pmCnogV97KqjUn-dQiDfAZt+hPN4Q@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 6 Jul 2026 17:15:03 +0100
X-Gm-Features: AVVi8CeH4Cfq-ffcoThq8wA4yKvMvnzRDEp0ukQdQ9SwiIqqu8QstGp3NKGK-dU
Message-ID: <CALeDE9O4cPp7aWsiHreqOt_sE4t=y5MzvnyuCCGpwzD6hFjuAg@mail.gmail.com>
Subject: Re: U-Boot Concept Tree Proposal
To: Simon Glass <sjg@chromium.org>
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

Didm't mean to leave the list off my reply.

On Mon, 6 Jul 2026 at 16:18, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Simon,
>
> > > In the follow up private discussions about it after it was clear as a
> > > whole that the PLC was uncomfortable with a specific websiite (we
> > > don't plan on supporting forks, would we provide that feature for all
> > > forks?) for concept. I offered the idea of a custodians tree to allow
> > > you to develop and maintain the features that you were preparing for
> > > upstream in your concept tree to enable easier collaboration for those
> > > that wished to work with you on those specific features. Maybe I
> > > wasn't clear enough in my communications but it was never intended to
> > > be the location to host a fork.
> >
> > A fork would be something which forks off mainline and goes its
> > separate way. Concept is not a fork. Perhaps a constantly merged,
> > multi-feature branch would be a better term. Please read my original
> > email again on this point and I'm happy to explain it further. Quite a
> > few series have already found their way to mainline.
> >
> > > So I think you need to revist what the idea of concept actually is and
> > > come back to the community with an adjusted proposal.
> >
> > It seems that you are rejecting the whole idea of a Concept tree (my
> > original post on this thread). Can you please confirm that? But if you
> > have ideas on how it could work with modifications, please share them.
> > There must be some common ground somewhere.
>
> Nope, not at all rejecting it, what I was saying is that I don't
> believe you have got the community to buy into your idea. I don't see
> it as the PLC's job to reject/accept it, as I've always stated it's a
> community decision, of which I am but one voice.
>
> On ideas I believe I have already shared the idea of working branches
> for features you believe should be in mainline U-Boot. Outside of that
> I don't have other ideas, but it's also not my concept.
>
> > > First though, I repeat again, would you please explain to the
> > > community why you are holding the u-boot.oirg domain hostage to try
> > > and force the PLC to accept an idea that we have been explicit about
> > > the need to get the community to buy into this "concept". I think the
> > > community deserves an answer.
> >
> > This is a bit of a one-sided view. The real situation is that for many
> > years to implement major features and improvements in U-Boot, but that
> > became progressively more difficult as Tom started refusing to accept
> > series and I have no ability to get PRs applied. Perhaps I was naive
> > to expect our good working relationship would continue forever, but I
> > have contributed a huge amount to U-Boot and having the rug pulled out
> > felt very unfair, not to say bad for the project. Regarding the
>
> So that gives you a right to hold the domain hostage why?
>
> Also your past contributions doesn't give you a free pass to force the
> landing of patch series that you think should be in there. That's not
> how open source works, it's certainly not how this project works.
>
> I think you need to step back and ask yourself why you're finding it
> hard to get patches reviewed and accepted.
>
> To give you an idea I have had numerous community members complain to
> me about you, I am sure Tom has similar, some are to the point where
> the only way they will deal with your code is if it's part of the
> subsystems they maintain and hence it ends up in their patchwork queue
> and otherwise they actively filter mails out from you so they don't
> see them. I don't keep a count or details but it's well over 5 and I
> may even have to start using something other than fingers.
>
> To put in straight forward terms, a lot of people are fed up with your
> behaviour, then when you get called out for it, or Tom has to have a
> conversation with you about it rather than addressing the actual issue
> you "take some time out" and come back a few months later without
> actually addressing your behaviour.
>
> Now you're holding the domain hostage which is similar bad behaviour.
> Not to even mention that you registered a US U-Boot charity and
> attempted to register the trademark all without telling *ANYONE* in
> the community what you were doing. Did you think you could just walk
> away and keep the project "Because of all your contributions"? Again,
> while you have contributed a lot I think the wider community of
> contributors as a whole have contributed more, and by contribute I
> don't just mean purely on the lines of code, but reviews,
> architectural discussions and all sorts of other things that actually
> make a community and it gives you no right of ownership over the
> project.
>
> I'm sorry Simon but the way to get your patches reviewed is to rebuild
> your standing with the community not by trying to force an official
> recognition of a fork by holding the domain hostage.
>
> > domain, I have offered to point subdomains to anywhere you wish, which
> > would resolve this. In the meantime I have mirrored the website and
> > moved various things away from the domain. But I cannot support the
> > sort of split that happened with Barebox, if that is your goal.
>
> And as I've stated we can't use it that way, the SFC has requirements
> around the project's assets (which include things like domains) as
> Neal has explained and I am fairly certain as has the SFC. Also
> there's dynamic infrastructure where we need to be able to move things
> with little notice so it would cause outages without the control of
> the domain.
>
> > I don't mind hosting a separate tree somewhere else, if that is your
> > preference, but it needs to have some relationship with U-Boot and a
> > clear understanding of what that relationship is. If that is not
> > possible / acceptable, then I suppose we should close this thread. I'm
> > skeptical of our ability to resolve complex things on mailing lists in
> > cany case, although I started this thread at your request.
>
> As I've stated numerous times before you need to get the community to
> buy into this.
>
> You have kept this "secret" from the community for a very long time,
> and by secret you've not been open about your intentions, until we
> explicitly asked you to go and explain it to the community.
>
> > > > > U-Boot has friction also because we don't have enough reviewers or
> > > > > maintainers compared to the number of contributors. I don't see how you
> > > > > plan on addressing that by maintaining Concept by yourself (with an AI
> > > > > I'm assuming).
> > > > > I appreciate you're possibly one of the most if not the most active
> > > > > reviewer on the ML and that there's not much more you can do to improve
> > > > > the situation aside from recruiting more people to review.
> > > >
> > > > Yes I have generally been the most active reviewer over the last 10
> > > > years or so, although sometimes I have burnout and stop.
> > > >
> > > > Here's how people become reviewers, IMO:
> > > >
> > > > Step 1: Punter has a problem, debugs it and conceives a fix / feature
> > > > to resolve it
> > > > Step 2: Punter sends a patch or short series
> > >
> > > I'm not sure it's appropriate to call our developers and contributors
> > > "Punters" [1] please be respectful of people.
> >
> > It's a pretty common term in the UK, at least, certainly not
> > disrespectful from my understanding or intention, using it to mean a
> > customer willing to buy or try out the product. I wasn't aware of the
> > urban definitions and now I wish I hadn't just read them!
>
> As a person that has lived in the UK for over 20 years, and an
> antipodean, I am well aware of why you used the term, but even in the
> UK it can be considered derogatory, but we are a community that is a
> lot wider than that, it after all the project evolved out of Germany,
> and we have contributors from a wide community that isn't associated
> with the nuances of the UK and related cultures so I suggest the use
> of terms like newbies and contributors that aren't open to
> interpretations because not everyone is aware of UK/antipodean
> specific nomenclature.
>
> Just like your behaviour as a supposed leader in this community you
> also need to be aware of the nuances of your language.
>
> > > > Step 3a: People review the code and Tom accepts some version of it
> > > > Step 3b: Patch is rejected, or people are mean or dismissive, or don't
> > > > understand the problem, or the effort gets too great (punter exits
> > > > here and goes to write his own firmware in Rust :-)
> > > > Step 5: Punter sees a related patch from someone else and decides to
> > > > reply with some thoughts
> > > > Step 6: Punter starts getting interested in more areas of U-Boot,
> > > > sending patches and reviewing, etc.
> > >
> > > I think going from a single patch to a firmware written in rust is a
> > > bit of a fanciful stretch.
> > >
> > > From experience people involved in the project review things when:
> > > 1) They know the topic or the hardware
> > > 2) Are interested in the features or functionality provided
> > > 3) Are a maintainer of a device or subsystem
> > > 4) Wish to assist
> > > 5) they have hardware they can test on
> > > 6) they wish to scratch an iitch.
> >
> > That's fine, we have a somewhat different experience. From my years of
> > watching this, it mostly starts with people seeing their code accepted
> > (motivated by your #6).
>
> I've been involved in U-Boot, whether that was on this list I don't
> remember, since I started to make Fedora run on arm around 2010 with
> the purchase of a Beagle-XM. It has been a wild ride. Experiences are
> always different, I was involved in the original distro-boot
> implementation and trying to get that upstream. Ultimately my
> experience and your experience doesn't devalue either person's
> contributions or the rest of the communities.
>
> Regards,
> Peter
