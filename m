Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99E8C43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 16:30:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D0DF84119;
	Sat,  4 Jul 2026 18:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jEaEvBnK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C074B841F2; Sat,  4 Jul 2026 18:30:24 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14AA68341A
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 18:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c124c3c876aso214806166b.1
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 09:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783182621; cv=none;
 d=google.com; s=arc-20260327;
 b=SS3TF5dZJFw8DNdQrm5WYTyvBF4VnzoY0+386aYtbPulMs9v8dKKBc/3ZilS8mdQXy
 PXwKXSA8NLZfzbHzPUMJM+wrU6wHGkVBgQZJdOetXjLykmqKnQl/zSVbBuPobohkms9Z
 cw5dSG/x84g1Ii1yd46qpaquv1gBfPg0bJgqrC6gwyCsoU9Jm9KSNbYCKRTzsYSkkyD2
 ZtWEH7JQ5VuHUUQl7Yj9sdgkhSQJkpjZv6XlfVk7X9RwFJPAAUpsd6aChPmGL36fTDpT
 /Agwml6bYOwK4XqL4zyuqXDdNDysc/HwE6hkIi7HwGt93TY9l/SK1GlObBE7EREClRXt
 svzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oFkUDM4cmccLtN749lOeQaKUZBp95Y1Mo/Y+PMBp1TE=;
 fh=TyjeA5pzKfachOVOXKCyIEPRoBDY7jD1AxgLRVVcr5g=;
 b=MfOYpWkMwuXUq3SMMYiy+rh/5Q2nIednUSpF5M3tS9A55nXv2cr+KoAEknW507yMTk
 3tC0Xo2vjYQEzBkQG3TgOOrvIdc5+Ep/7Q7x1IXhT7nQGY9OS8eMP5ycfKj3+er3wCmQ
 k14CUuIYgq8GWGzNw8nUS/NkcNYfeAdVZSayrO8Yg18UZ80IE00SWNWXPMQqlxffgts4
 z1xPqTlM45AcMN/ZZMS6MnWPAfPF9EgzRap0gTDh8IAwoSuMyzoKOBNlB1HxMjKUjnR8
 B4d5jOGkFkZhVRRX8KAIsb5iDq/jI/tj79qjEhvVKt8SpE7SckeZcyx8wlTevIAXYMYz
 Ie1Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783182621; x=1783787421; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oFkUDM4cmccLtN749lOeQaKUZBp95Y1Mo/Y+PMBp1TE=;
 b=jEaEvBnK4+n0eR3rAjN4p7ddSDJjNzq7Y7mtAXug9t384E0sSyUTvia2/qdTdHVGJ+
 JK63bv+skbzo9hdezOmBSSA8rJahBt3yE38UYGPdvzjZgnTq37b09uc7Hr1oMAYQhK+l
 mKaGwSwA2EsVUjDlg1Y45bfurNqt4DSpR0NMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783182621; x=1783787421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFkUDM4cmccLtN749lOeQaKUZBp95Y1Mo/Y+PMBp1TE=;
 b=X1TKbIIC5s+Wlsa10Mr3tjscF3kbYVHw3NF+kEvwxg/cJf2LUaNYogpZDNjOdONe2z
 gOKASX6lxg+dMUZTWqRF90EhL5x1BvdlfanrKebuHTlF2yH4Yj2ualC0gDHatawXhHAW
 ThFVZ72KWba8nESoyIfzdIwrX90GObeaK/hAxego3UC0RBGDJK4cauqSW18qTc4jEwa5
 jyaNM2vEcJKnwdSNJd4I1YJmaIq5aD7nhH2pTpvyMI5Cw9b9NgrPuVZR3U+li+Wz7Vm6
 bkGSet9Fhc0BRej3c/+9Lb03+rx0FhjdS/wgeMJfztmeni/RFJQwjfIy1fgjtrHFim+u
 YILw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6B0qyIEWxH6tQakuyaztE0DxzK5XC89Ii/EL2W9Cgj/0MeHxC7uxDKdyapOJsDqJgNDlUBrc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+uC8EjrRfYY1xiVQq8rwcrq6NNQ9tCssFueZ1bIJfbkL0riK7
 1ZlAIQUZk8ezocaE/OClk7l9Rk7/Or2UwW68WDU560FcP8d23aEmiaFCfXjd3gNqPONfiJr1/YR
 X6XjbtNzseTJcasYLGsqdOkRg1G3Nil3s1ltSnpjcI4JlJZRtd48+v63r
X-Gm-Gg: AfdE7cnJE8b0HC9EY8nIKKKyxO0Ff1dGqmyqsbHQO27Lm9vPTxRLHR3MlJbLZYKtAth
 2Nf4Khx+9/hFwP6oeo1611KhzKar/YhfUxzsB+sAhFmTz/ED31gqJZtQcaXqr966qdPPPlc8Ny6
 GpMWe6xe3iA30ZInPfZJ1FkMRMzx+bX8EHh5nfioDgIZBEdLDYF2FHLeCOj/+6hjeUW66rHK3E1
 vr486xcUKUBXG0Mfwf3gGmExjD7yzBqEn83rGz65ysvLC8HMi8Xo2Dql6tYzNk+lCIf9tc=
X-Received: by 2002:a17:907:97ca:b0:c12:40c2:9d09 with SMTP id
 a640c23a62f3a-c12e6963b89mr131737766b.12.1783182621383; Sat, 04 Jul 2026
 09:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
 <6c21c8d8-74c0-43bc-9249-6cc1dc401136@linaro.org>
 <CAFLszTjGwi0MhX3wNH0eGVsumG=8c48hupe86eS_8E+J+LNdBA@mail.gmail.com>
 <CALeDE9MSA5RGEuBseiSrj6-yw9a44=0+PWC8=_HKboC-fWkkzQ@mail.gmail.com>
 <CAFLszThAqVjZ0Jd5kdB5q=bhGTNpAeHw3WXpUHnFQ_OH_KmXLA@mail.gmail.com>
 <6d0f3078-2ba8-474c-9a1f-481eeb7f47bf@cherry.de>
 <CAFLszTi+4s51HtaQrgBLEsOzoCjtZ+CGdvqBm4B9_fj-rpKqwg@mail.gmail.com>
 <CALeDE9OWeMs3peX8+4+i6iTmZn-EO2e+7s7q6S1yFaRUa0dksQ@mail.gmail.com>
In-Reply-To: <CALeDE9OWeMs3peX8+4+i6iTmZn-EO2e+7s7q6S1yFaRUa0dksQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 4 Jul 2026 10:30:07 -0600
X-Gm-Features: AVVi8CdWEu6v-52vrSsGyE1VpJxZsUeGFdwtIka2NNIzPbilqt6jcX_vmqYkvAE
Message-ID: <CAFLszTg24RTHi0A0vWfv62FfZhm1Uz4iw=4m7NZ6_4W3R3kwyQ@mail.gmail.com>
Subject: Re: U-Boot Concept Tree Proposal
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
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

Hi Peter,

On Fri, 3 Jul 2026 at 11:11, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Simon,
>
> > > >>>>> Another difference is AI. I believe that AI is the next step on from
> > > >>>>> compilers, which also took a long time to produce good code and find
> > > >>>>> acceptance. The Concept tree welcomes (and encourages) high-quality AI
> > > >>>>> contributions and reviews. It accepts PRs and allows reviews on PRs or the
> > > >>>>> mailing list. It relies 99% on automated tests (sandbox, QEMU and labs) so
> > > >>>>> sets a high bar for testing. It uses a separate Gitlab instance for now and
> > > >>>>> of course uses a separate mailing list and Patchwork project to avoid
> > > >>>>> cluttering the main list. Concept runs an AI-powered cherry-picker so that
> > > >>>>> it keeps up with mainline. In no sense is it operated as a fork.
> > > >>>>
> > > >>>> I'm clearly against using AI for any of development or review work as it
> > > >>>> can't be fully trusted and will monopolize precious reviewers time reviewing
> > > >>>> AI code instead of reviewing legitimate contributions from individual and companies.
> > > >>>>
> > > >>>> Using AI for CI testing and regression testing could help if it doesn't add
> > > >>>> a burden for maintainers by reporting false positives.
> > > >>>
> > > >>> RIght, Tom has been very clear about this too, even suggesting that AI
> > > >>> is actually unethical. This is indeed one of my motivations for the
> > > >>> Concept tree.
> > > >>
> > > >> To avoid the scrutiny of using AI? If that's the case and you're
> > > >> intention I have further concerns.
> > > >
> > > > Not really the scrutiny...the more scrutiny the better, I think. But
> > > > if mainline is anti-AI then Concept can provide a place where people
> > > > can make use of it.
> > > >
> >
> > Thanks for taking the time to reply to this - it is a very important
> > but very quiet thread.
> >
> > >
> > > Tom has clearly communicated multiple times that AI is generally not
> > > welcome in U-Boot. So how is accepting AI contributions into Concept
> > > compatible with "Once features are landed and functional in Concept I
> > > hope that many will find their way to mainline"? Who's going to do the
> > > work? Who's going to take the legal liability of reworking AI-written
> > > code for submission to mainline? How is this going to address the main
> > > issue you're having of "code is not landing"? It's still not in mainline.
> >
> > U-Boot tends to follow Linux, so we'll see what U-Boot's policy turns
> > out to be in .rst format. I am hopeful that eventually more people
> > will see the cost/benefit ratio of AI in a different light. My
> > understanding is the policy will be addressed once the infra move is
> > finished. Linux requires disclosure, something I have worked hard to
> > do in Concept. The legal question is covered by Linux's policy too
> > [1]. I do understand that any new technology creates fans and
> > opponents, problems and opportunities. Some thoughts at [3]
> >
> > My approach has generally been to embrace change (and deal with the
> > fallout) rather than to resist it.
> >
> > >
> > > What I think will happen is "I cannot get this merged into mainline so
> > > I'm going to get it merged into Concept and then direct my users at
> > > that". And eventually, over time, everything from this Concept
> > > contributor and their users will only land in Concept and we won't even
> > > have it on mainline ML.
> >
> > I don't want to speak for Tom, but yes I can trace the genesis of
> > Concept to the increasing difficultly of getting things accepted,
> > particularly large things like bootstd and VBE. What do you suggest
> > instead of Concept?
> >
> > >
> > > You keep repeating Concept is not a fork, but I don't understand how it
> > > can NOT be one.
> >
> > Concept cherry-picks from mainline so that it stays up-to-date. So it
> > should be possible to grab a feature from Concept and apply it to
> > mainline without too many conflicts. A fork does not care about
> > mainline at all. This is a big and complex topic though, since
> > features build on each other (e.g. see the BLS thread [2] where the
> > Concept version builds on pxe_utils refactoring, making it hard to get
> > into mainline without several precursor series).
>
> A fork of a project is where it diverges which a number of different
> features, there's lots of projects with forks where the forks cherry
> pick between each other and try and remain largely compatible. One
> example that comes to mind is Linux Foundation forked the Ubuntu LXD
> project to a project called Incus.
>
> > > Considering Concept is apparently going to be hosted on the same GitLab
> > > instance as mainline, I see this as potentially confusing people as to
> > > what it actually is.
> >
> > Yes it could be confusing...I'm open to ideas on how to handle that.
> >
> > > I still am pretty upset at the various articles you
> > > or AI in your behalf posted on the u-boot.org website claiming support
> > > for various features in U-Boot either "submitted" (nowhere to be seen on
> > > the ML) or not explicitly stating they are merged in a fork of U-Boot
> > > (Concept, that is).
> >
> > See above re fork. I am responsible for the articles, although Claude
> > and Gemini helped write most of them. I thought I was being quite
> > careful to label things as 'Concept', but I've just gone back through
> > and found a good number unfortunately did not. I've fixed those and
> > also updated the titles in about 20 cases too. Please let me know if
> > you see other problems.
> >
> > > That with the fact our official documentation used
> > > to be on docs.u-boot.org really made it look like (to me) we were behind
> > > this effort. We made the mistake of hosting the docs on a domain name we
> > > didn't (still don't?) control, I would like to avoid repeating the same
> > > mistake a different way by hosting a fork on the same instance as mainline.
> >
> > OK. Would a URL link to Concept be acceptable?
>
> I don't think we have buy in from the community into the whole concept
> fork as it is to be actually discussing links as yet.
>
> I think you need to answer the questions to the community about concept:
> 1) Why are you holding the u-boot.org domain hostage over this
> 2) Maybe you need to read back through the input from the community
> and revist what you think concept should be
>
> I feel I was very clear, both on the community call when it was bought
> up, which lead to you starting this thread so I had assumed you
> understood that you had to get the community buy in.
>
> In the follow up private discussions about it after it was clear as a
> whole that the PLC was uncomfortable with a specific websiite (we
> don't plan on supporting forks, would we provide that feature for all
> forks?) for concept. I offered the idea of a custodians tree to allow
> you to develop and maintain the features that you were preparing for
> upstream in your concept tree to enable easier collaboration for those
> that wished to work with you on those specific features. Maybe I
> wasn't clear enough in my communications but it was never intended to
> be the location to host a fork.

A fork would be something which forks off mainline and goes its
separate way. Concept is not a fork. Perhaps a constantly merged,
multi-feature branch would be a better term. Please read my original
email again on this point and I'm happy to explain it further. Quite a
few series have already found their way to mainline.

> So I think you need to revist what the idea of concept actually is and
> come back to the community with an adjusted proposal.

It seems that you are rejecting the whole idea of a Concept tree (my
original post on this thread). Can you please confirm that? But if you
have ideas on how it could work with modifications, please share them.
There must be some common ground somewhere.

>
> First though, I repeat again, would you please explain to the
> community why you are holding the u-boot.oirg domain hostage to try
> and force the PLC to accept an idea that we have been explicit about
> the need to get the community to buy into this "concept". I think the
> community deserves an answer.

This is a bit of a one-sided view. The real situation is that for many
years to implement major features and improvements in U-Boot, but that
became progressively more difficult as Tom started refusing to accept
series and I have no ability to get PRs applied. Perhaps I was naive
to expect our good working relationship would continue forever, but I
have contributed a huge amount to U-Boot and having the rug pulled out
felt very unfair, not to say bad for the project. Regarding the
domain, I have offered to point subdomains to anywhere you wish, which
would resolve this. In the meantime I have mirrored the website and
moved various things away from the domain. But I cannot support the
sort of split that happened with Barebox, if that is your goal.

I don't mind hosting a separate tree somewhere else, if that is your
preference, but it needs to have some relationship with U-Boot and a
clear understanding of what that relationship is. If that is not
possible / acceptable, then I suppose we should close this thread. I'm
skeptical of our ability to resolve complex things on mailing lists in
cany case, although I started this thread at your request.

>
> > > U-Boot has friction also because we don't have enough reviewers or
> > > maintainers compared to the number of contributors. I don't see how you
> > > plan on addressing that by maintaining Concept by yourself (with an AI
> > > I'm assuming).
> > > I appreciate you're possibly one of the most if not the most active
> > > reviewer on the ML and that there's not much more you can do to improve
> > > the situation aside from recruiting more people to review.
> >
> > Yes I have generally been the most active reviewer over the last 10
> > years or so, although sometimes I have burnout and stop.
> >
> > Here's how people become reviewers, IMO:
> >
> > Step 1: Punter has a problem, debugs it and conceives a fix / feature
> > to resolve it
> > Step 2: Punter sends a patch or short series
>
> I'm not sure it's appropriate to call our developers and contributors
> "Punters" [1] please be respectful of people.

It's a pretty common term in the UK, at least, certainly not
disrespectful from my understanding or intention, using it to mean a
customer willing to buy or try out the product. I wasn't aware of the
urban definitions and now I wish I hadn't just read them!

>
> > Step 3a: People review the code and Tom accepts some version of it
> > Step 3b: Patch is rejected, or people are mean or dismissive, or don't
> > understand the problem, or the effort gets too great (punter exits
> > here and goes to write his own firmware in Rust :-)
> > Step 5: Punter sees a related patch from someone else and decides to
> > reply with some thoughts
> > Step 6: Punter starts getting interested in more areas of U-Boot,
> > sending patches and reviewing, etc.
>
> I think going from a single patch to a firmware written in rust is a
> bit of a fanciful stretch.
>
> From experience people involved in the project review things when:
> 1) They know the topic or the hardware
> 2) Are interested in the features or functionality provided
> 3) Are a maintainer of a device or subsystem
> 4) Wish to assist
> 5) they have hardware they can test on
> 6) they wish to scratch an iitch.

That's fine, we have a somewhat different experience. From my years of
watching this, it mostly starts with people seeing their code accepted
(motivated by your #6).

Regards,
Simon

>
> [1] https://www.urbandictionary.com/define.php?term=punter
