Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B47C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 20:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1478184A29;
	Wed,  8 Jul 2026 22:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WIBEjlL6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DD5384A3E; Wed,  8 Jul 2026 22:43:03 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 868F484A12
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 22:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c15e3141d02so23381966b.2
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 13:43:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783543380; cv=none;
 d=google.com; s=arc-20260327;
 b=mu8kE+dINiL1ErLjO6+lwyx3i8lvQ9t6kcaRXGPZyW3/2nWw9jE9KZ4lkXnjhx5TLm
 HAgTeLDPKl/ieB8XiAgovBqCwR4zK16TiGknS0pBjoXZy8Y5UBwAyXuX8Z4bMzl8fAOQ
 lyxt71kF4cbhrY70xmCiZHw4cv9Qq96ypG3cvmjSkghErTawLzCAsyX1BqHR+QOKS/7h
 jJbb8Gv3gvW7is/qEOBPaRIwf8QCzJKyM7Lw3ZHXhhdcz9O7jboLrPVDe3/o31XVvBw3
 UmyYbx89QjnkzVDGKD7bT8/US0lzlh6bMW7l0WGzE8wawhwtFcN9P3PpJ2tWkos07hOj
 Ejbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YbXujot0Bs1MfatgAKL12SAVomXUp1nb4laDtAMzfCw=;
 fh=Fz2hJ015Y/uV/977P7s/L5uShpr33kY+/lsVxqCJsT0=;
 b=gA42NLxVf7PT1Cea5oQr1jcDEtKiRrf7Y4B4Umn3Q6uR9khgxK9z0DlRLZ97d5wmr1
 dgS58wR77pEAkjCDFytf+NydYhatp625C35hriUxZSzOUouKBdG3c11NIx/f1ycgrgyk
 tFxF4WC8PHiEJlQSPXEuREel6M98vqv9Ok1BEegthyTvqN9AGhe4Fj5IbzKXwYIGWGzN
 Br0jL9L+nAPKhHZCf29nns9xq2tZc4WcwFCOiPZJ+if4KV/ifht8x9WUJm2JBRi7ylXV
 u/0EEm1IEDHmDsEvt6YXb2is+W4sMyR1jCo9NDYsEOBsaMl1Zw4bG4bnu6Y98pFjC1Nx
 275g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783543380; x=1784148180; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YbXujot0Bs1MfatgAKL12SAVomXUp1nb4laDtAMzfCw=;
 b=WIBEjlL6vG2HEH6H/QTlr+xKnHjslxkQG2RMHEoZV8vjoyYdmB1qbiq81l6N4Xg+3i
 goYzIueKw3k4QiKcl1z4srLC1RMtDOY/lQDquHKaJtzbvj83P2CNnFXSG+L4zRkXIzGz
 p4vKmHf7PZj6dPuGyY2PuVoYKxOS5eja07B8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783543380; x=1784148180;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YbXujot0Bs1MfatgAKL12SAVomXUp1nb4laDtAMzfCw=;
 b=lO4R05wxz1bwo8WFwCNNcrkdatNU4a6R8r2KuAqM7sR8yzllo7U9g8ogbdXYUiKObH
 9KyX1IEmGaLGgTsHHUs6eHm9neD6m3wAGNGqC3RSiL3RW+0PefyoHEGO585YaK+UJYq6
 7yZnxJGasLUuAGNFpcp6CqRHSRMTH2MN8y3AdAHDSXGkPyMr8gtJyV8VR5JZJD3jMA8h
 HUet+M7QcTZ4eaij5c5IAP/Ivj+S7x+1XH6JhYvaLz6T66keCVLKcf4PieTTGNMIMmC1
 PSi8cRCUNWWO2Gn5FN4yG3CLvp1dgXReddYSncGjCkdN/UfMWimaMHp9H1IHkVK3wK6e
 nE2A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqydvs/Pvq+hVlqphOazB+LmfrfcWI0mAdoFgzulN+lIT85wmrcXG86YHAGmcN6uqy0fhQHbEw=@lists.denx.de
X-Gm-Message-State: AOJu0YxHmcu3AG8V3NjxUAu9HaHA7vvkM3CVF5TZnmfIELv5G19GGAbA
 9sRvvxVdcXUHDW8Q/vLkLn5oIETYCBBJA61jH8iOJ+qcztexKXUcZUOaWLc4c25YmEQPdvp4wJX
 dz2AzSfxj3+JhGqrY+PzuJeKlgTUNNYaWegD5O+qs
X-Gm-Gg: AfdE7cl3QkNrbeiSW1j2QbWive6jwhdUYQgGJwXW6NHDwODjOHLTiR/QPMZo4illW/w
 +vFyRkVuQm8OyOBsrP9UOydAsGOLDtMzjQyHpSBjrXspvgBD0QG4GAAoDUSe9wfjz0wZnQPEhhI
 h/9dhFNSzyXoOBighDQWs+yGFOj9S8NCzvrsXH9RtgBLGbXuKwJCLhKl3edS/v2ntaWFsfVFWNW
 QByURuVZ7OJ9PG7L2JbZN9bmfHlfXbPV0h5l1nnFUuAVWlU2LSvA1nP93moT0GPpB3erbY=
X-Received: by 2002:a17:907:3f96:b0:c12:8d49:48c6 with SMTP id
 a640c23a62f3a-c15ce21d7a0mr194333866b.55.1783543379839; Wed, 08 Jul 2026
 13:42:59 -0700 (PDT)
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
 <55e94a52-c953-45b5-b28c-6d258f357947@cherry.de>
In-Reply-To: <55e94a52-c953-45b5-b28c-6d258f357947@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Jul 2026 14:42:45 -0600
X-Gm-Features: AVVi8CcslxzLrE2uDb3acHPwTU4gvtAOhQ_87qzzq9YWHgQVbpfzIyfu0e133o0
Message-ID: <CAFLszTi_hpd8AsJD+8S_Cp6+ua=Udd0hpyJmuvF_wco4PTbq6Q@mail.gmail.com>
Subject: Re: U-Boot Concept Tree Proposal
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Quentin,

On Mon, 6 Jul 2026 at 10:29, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 7/4/26 6:30 PM, Simon Glass wrote:
> > Hi Peter,
> >
> > On Fri, 3 Jul 2026 at 11:11, Peter Robinson <pbrobinson@gmail.com> wrote:
> [...]
> >>
> >> I don't think we have buy in from the community into the whole concept
> >> fork as it is to be actually discussing links as yet.
> >>
> >> I think you need to answer the questions to the community about concept:
> >> 1) Why are you holding the u-boot.org domain hostage over this
> >> 2) Maybe you need to read back through the input from the community
> >> and revist what you think concept should be
> >>
> >> I feel I was very clear, both on the community call when it was bought
> >> up, which lead to you starting this thread so I had assumed you
> >> understood that you had to get the community buy in.
> >>
> >> In the follow up private discussions about it after it was clear as a
> >> whole that the PLC was uncomfortable with a specific websiite (we
> >> don't plan on supporting forks, would we provide that feature for all
> >> forks?) for concept. I offered the idea of a custodians tree to allow
> >> you to develop and maintain the features that you were preparing for
> >> upstream in your concept tree to enable easier collaboration for those
> >> that wished to work with you on those specific features. Maybe I
> >> wasn't clear enough in my communications but it was never intended to
> >> be the location to host a fork.
> >
> > A fork would be something which forks off mainline and goes its
> > separate way. Concept is not a fork. Perhaps a constantly merged,
>
> But... patches in Concept have already gone their separate way? We don't
> have them on the ML (nor do we want them at the moment as they are
> mostly AI-written and the Tom's position on the topic is currently "don't").

Right, we don't want them on the ML (tried that!)

>
> > multi-feature branch would be a better term. Please read my original
> > email again on this point and I'm happy to explain it further. Quite a
> > few series have already found their way to mainline.
> >
>
> If it's not mainline or a maintainer tree with commits on their way to
> master or next, it's a fork to me. FWIW, I think we could even consider
> the maintainer tree as a fork as well, but since it's explicitly listed
> as our workflow (c.f.
> https://docs.u-boot-project.org/en/latest/develop/process.html#work-flow-of-a-custodian)
> then I guess it's not one (not in the strict term).

I suppose it depends how long from tree to master or next. Maintainers
tend to have have code that sits around and isn't sent for a while.
But it is normally in individual branches rather than all piled up
into one big list of commits.

>
> My company has a U-Boot tree + a few patches that are mainline, I don't
> claim it's NOT a fork even though all commits are either already merged
> or already sent to the mailing list (a requirement we have for anything
> upstream: send first to the ML, then we import if from the ML). In that
> regard, Concept would be worse as there's no guarantee patches in
> Concept would even make it to the mailing list.
>
> Your insistence that Concept is not a fork is puzzling to be honest.

OK well perhaps it isn't that important. The fact that it keeps up
with mainline is why I don't think of it as a fork. But no matter.

>
> >> So I think you need to revist what the idea of concept actually is and
> >> come back to the community with an adjusted proposal.
> >
> > It seems that you are rejecting the whole idea of a Concept tree (my
> > original post on this thread). Can you please confirm that? But if you
> > have ideas on how it could work with modifications, please share them.
> > There must be some common ground somewhere.
> >
>
> I'll let Peter speak his mind.
>
> As for myself, I don't care about anything not going to the ML. I
> wouldn't want an ostensible fork be hosted on official infra.
>
> You've made multiple reviews in the past on the ML mentioning Concept to
> users (I know, I received one and had to look up what this thing was).
> You continued to merge other people's patches in your maintainer tree
> while Tom had refused to take some of your pull requests and continued
> to reply to patches on the ML that they were merged, even though they
> were blocked by other patches in the same pull request Tom had refused
> to take. You repeatedly failed (back then) to take into account Tom's
> request to stop bombarding the ML with long and difficult to review
> patch series. The situation ended up with you being on hiatus for 6
> months. You can imagine I'm being a bit skeptical what your actual
> intent is with hosting Concept on official infra and claiming it is not
> a fork.

I'm sorry about that. Let's just say there was frustration on both sides.

>
> There may not necessarily be a common ground or compromise, rejection
> may be what the project decides.

I hope not.

>
> >>
> >> First though, I repeat again, would you please explain to the
> >> community why you are holding the u-boot.oirg domain hostage to try
> >> and force the PLC to accept an idea that we have been explicit about
> >> the need to get the community to buy into this "concept". I think the
> >> community deserves an answer.
> >
> > This is a bit of a one-sided view. The real situation is that for many
> > years to implement major features and improvements in U-Boot, but that
> > became progressively more difficult as Tom started refusing to accept
> > series and I have no ability to get PRs applied. Perhaps I was naive
> > to expect our good working relationship would continue forever, but I
> > have contributed a huge amount to U-Boot and having the rug pulled out
> > felt very unfair, not to say bad for the project. Regarding the
> > domain, I have offered to point subdomains to anywhere you wish, which
> > would resolve this. In the meantime I have mirrored the website and
> > moved various things away from the domain. But I cannot support the
> > sort of split that happened with Barebox, if that is your goal.
> >
>
> You didn't answer Peter's question. Also note that you're not doing the
> redirect properly, c.f. https://docs.u-boot.org/en/latest/ (and I'm
> assuming all URLs except the base one). If we don't own the domain, we
> cannot make use of it as a third party (you) will be free to serve
> whatever they want would they change their mind in the future (and we
> wouldn't necessarily know). I do not want to be included in this
> discussion but "hand over the domain" != "i can redirect for you".

Yes, that's true, and in fact I cannot point to the website properly
at the moment as it refuses to load at u-boot.org

>
> Pasting the rest of the discussion in the other thread here as Peter has
> started referencing it so maybe we can merge the discussion into one
> (copy-pasting manually so maybe I'll mangle the "depth" of answers).
> EDIT: well, took too long and Peter answered already, but eh, here it is
> anyway.
>
>  >>
>  >> Tom has clearly communicated multiple times that AI is generally not
>  >> welcome in U-Boot. So how is accepting AI contributions into Concept
>  >> compatible with "Once features are landed and functional in Concept I
>  >> hope that many will find their way to mainline"? Who's going to do the
>  >> work? Who's going to take the legal liability of reworking AI-written
>  >> code for submission to mainline? How is this going to address the main
>  >> issue you're having of "code is not landing"? It's still not in
> mainline.
>
>  > U-Boot tends to follow Linux, so we'll see what U-Boot's policy turns
>  > out to be in .rst format. I am hopeful that eventually more people
>  > will see the cost/benefit ratio of AI in a different light. My
>  > understanding is the policy will be addressed once the infra move is
>  > finished. Linux requires disclosure, something I have worked hard to
>  > do in Concept. The legal question is covered by Linux's policy too
>  > [1]. I do understand that any new technology creates fans and
>  > opponents, problems and opportunities. Some thoughts at [3]
>  >
>
> Note that SFC (under whose umbrella U-Boot now is) != LF and the
> official stance of SFC is now available at:
> https://sfconservancy.org/llm-gen-ai/llm-backed-generative-ai-recommendations.html
>
> I will quote some part in the preamble that I think is worth highlighting:
>
> """
> Some FOSS project leaders have taken a zero-tolerance approach to any
> LLM-gen-AI contributions to their projects. We support leaders who make
> such decisions.
> """
>
> So it's possible the project decides we don't want to go ahead with
> encouraging the use of LLM/AI. At the same time, we import a
> non-negligible amount of code from the Linux kernel which for some
> subsystems allow LLM/AI tools, so the project is already tainted by
> AI/LLM (or soon, e.g. via dts/upstream in v7.1).

This was not the original driver of the Concept tree. AI is perhaps
something we could discuss on one of the calls, once the infra stuff
is finished.

>
>  > My approach has generally been to embrace change (and deal with the
>  > fallout) rather than to resist it.
>
> Note that *you* may decide *you* want to embrace change, but it doesn't
> necessarily mean the project wants to accept it/them.

Exactly.

>
>  >> What I think will happen is "I cannot get this merged into mainline so
>  >> I'm going to get it merged into Concept and then direct my users at
>  >> that". And eventually, over time, everything from this Concept
>  >> contributor and their users will only land in Concept and we won't even
>  >> have it on mainline ML.
>
>  > I don't want to speak for Tom, but yes I can trace the genesis of
>  > Concept to the increasing difficultly of getting things accepted,
>  > particularly large things like bootstd and VBE. What do you suggest
>  > instead of Concept?
>
> I understand. But I fail to see how you're addressing the issue with
> Concept? Like, how is this going to help you get things merged into
> mainline? Being cynical here but the only positive outcome I see for you
> with Concept is strong-arming the project into accepting your changes
> that we're currently rejecting/not reviewing.

It is providing an option which currently does not exist, but I think
needs to exist. If you go back 10 years to when EFI was added to
U-Boot, no one asked whether it was perfect, or complete, or fully
migrated, etc. It was years before the EFI loader could actually boot
properly (I recall even in 2022 hacking away to get it to boot Ubuntu
on a Chromebook). But now we want to have things that work perfectly
and are complete, or we won't take the series. We need a way to build
up features such that they can be proven and then brought into
mainline.

>
> The difficulty of contributing to open-source projects is not new: you
> must have buy-in from other people to get interest from reviewers and
> maintainers to get your code merged. Convince people your thing is the
> right thing, justify your patches, provide ample context in cover
> letters and patches so drive-by reviewers or people with little time
> have it easier to review your code, contact distros to figure out if
> they are behind your project (e.g. VBE) and get their support and public
> push otherwise this is someone having a grand plan for how things should
> be but they forget other people are involved for this grand plan to work
> or even be used.

I do a reasonable job of this for the smaller things. But for the
larger things, particularly boot-related, particularly multi-series
efforts, I tend to run out of steam. Wouldn't anyone? WIth Concept
I've been able to finish things, such as the PXE refactor, expo and
the EFI apps, that I would struggle to do in mainline doing a series
of <15 patches 4 times a year.

I know we already discussed this topic in a call some weeks back and
Michal had an idea for a staging area. Should we try to get interested
people to attend the next call and try to figure out a path forward?

Regards,
Simon
