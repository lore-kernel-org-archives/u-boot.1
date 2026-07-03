Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC54C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 17:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C0EB849F0;
	Fri,  3 Jul 2026 19:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jhqHCZn2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21462849F3; Fri,  3 Jul 2026 19:11:33 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 625AB849BA
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 19:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-8eff5ce3b95so5505956d6.3
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 10:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783098689; cv=none;
 d=google.com; s=arc-20260327;
 b=ffXX5E9Oc09aEuPG4H8m2n5IoiibcI89TBRqPzyp6xyzFihqw1cV/P5jib8yPrChYt
 6nmDQ7XFEXLLnKf2Chzd+FdnEanrQZlbjVJ6Fy7G9WmRr4JNv5Usb+99B8R03qTZ0oiN
 ILqj+gKn0vu/zsVDUpAkI32gyztdYsfvuBumrlF/lADoN/gR6MZkiQzOjICAwdyODj39
 3bKdTxpw79lTDCcXT61FqUjCHZzNd7LOCOSr735va5ewA0dQ2YwC1Q3ainy4Nw2o+e4p
 AehKqZnSF28ESvDFf2/ONCaVxH7+ZbwJzE2BtgzVusRuHZOP4OF7gJBp3sTaJjV9VDly
 7SHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+V/ofNMZDhMQJTZF0v5ivUUQb16GLkabrPY7JUpJZT4=;
 fh=/IgWAMTJ1di/aV68NONbYoez3saguAb8kE5OH6EuAFs=;
 b=ZDcjEzXjpvaLjqWq1gUhNAS/CQgjnnzjdlVEZXi7Vr/7xZYr4UGMQ7Yr90tFN5qNpW
 S5Q8qBbIq2LkHtzvM+BC/ywOtfubK3T7oousyb45tzaqei3M5YFXrnKzsXR0TlrgiWy/
 EGpCQ4GR3pWb8uqH9AhJBE62gewbu7XESqEhGryOMx3OaA2zthHR/PHEzn8XM6hD5N63
 OgYhk2y553nQlq6/a7TXlJr5fK2v6pT6ZSI6XtHSRTZUABseeu8/6MVmQzqX9NnCYGrK
 Q5xPbR68TjTfVSvqb6otUm2f2CqEy3lcaaxOo6igI3bghOVYLbkNa5vMfvMD1ZSK1jwR
 8yhg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783098689; x=1783703489; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+V/ofNMZDhMQJTZF0v5ivUUQb16GLkabrPY7JUpJZT4=;
 b=jhqHCZn2JZj3uWS/0eagj1IyWwQ7A/RbzbHhKTcS8APpDlyGQWOjGEN5LtdV1Yp+YQ
 pA9wN8xVTt10XEKzte+VHXUIW6QryCrSnJQXXGbDspYRpKdL1QWIo9mKrbrj5QsDbhJM
 e24ciA2z0UB05J2P1VGOwHVCH7FMNrW4MWvPyGdnK3ekd89TkieZwlZPNtwOcMyatFt9
 L9k9Tef9GwpT8WIRFYO/ESUe+JZPxLgf5dFLElkZeePVqvUoqBjgMFbaPXLsOh3DTjkZ
 bEdc9p0Ak9O5b2HAkwWRJTq+nJ35gA2zc6UqogmiygeJpGIrJW33Z3a9maPAaaCpz68r
 kijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783098689; x=1783703489;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+V/ofNMZDhMQJTZF0v5ivUUQb16GLkabrPY7JUpJZT4=;
 b=jsyzRkaV9yIEGQ4K7Nl6YAEZkJ68kmprAi+HHRBAB7hZj9NgXUuEdeIYKchyzanLaJ
 67z3KTnpEospBmjlTzNAKSVDElGBotTPmE42stnYs/KxZO2pS9Z/JRVn6TbuR7CC09gW
 IaobvmWcgilhMVoF6JlumCwEGiSjNmd0sIMZRfS9w3xihmTfH8pu9lzWRyRoTR9gAlbU
 KedbIe0Rl+YusGVi/9FE6E83cScWkWnebdQiAXVejGiKvo0exmVF17hIwfW7XgxPDwTd
 DvB6wIf3SXhePRbuhQIkPHU9OAFdFBPyde9wCXznOkbkFk9k6+DKSeFdKDVyocCr5kde
 kUpg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpm6dNOFLDIz0IfGrKDAcGmEwSgZEGB/zpqgesQrUXQK8L6SfYky8CyeQd903t5gHH7qR+BNh0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw55uY8hvPFEm5xIajoO0FtSGZAuP7itzrHc5lYVmZXyfUDNKkz
 2nDVBjTrb3LawH3i6LoGKw65q+BUuiug2nQUJv/bMbXldp2orV84o8GFRrHffStIOJ/2lTOdWe1
 DG4W04gugxgmIj1Gf9FynQJpLoyzJmzM=
X-Gm-Gg: AfdE7cn34NFXxrEteJ+XUFiGb/g3Z7Gf8Tvf/dl30KxE8ZmMhRTZPhmthmVxg1wf5NB
 eTqqS57t5hu4JJ/o4xkog7qRcrPtl/KaecptieFnU2SBvjlU69zGw8vmQ8+GMM2UDxemvARnpSg
 kDV2EKDzxvG1XY7slq63xJ/bXEtVuALPAwq3re4iR+PlBrvyngcCTJZNBS5Oc91XwQrMO0zIURN
 w7UqnPJfW06rs26dNtJI1bM+nRfMynOrJ6Sh9yTnUPsVolvMKd1h9mjKEbCcTiLRmIG89TFsjAx
 1yMunWvVLhENQQIN/Nd7k5qzhGFCCFXidj2C7yGY3IA6RHWCr5Tc9jaIhqVLEwC3ezkXOr9Txcv
 ETiCmqDhmjpFhbZPFVm/dfgsmWHLa4MN0bLJfmaor6GeYFv8pMPNCoUtazqD/Hw8suF7gFWOc1W
 OxHA==
X-Received: by 2002:a05:6214:d62:b0:8ef:33aa:94d7 with SMTP id
 6a1803df08f44-8f74c3a8fc4mr1168816d6.40.1783098688828; Fri, 03 Jul 2026
 10:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
 <6c21c8d8-74c0-43bc-9249-6cc1dc401136@linaro.org>
 <CAFLszTjGwi0MhX3wNH0eGVsumG=8c48hupe86eS_8E+J+LNdBA@mail.gmail.com>
 <CALeDE9MSA5RGEuBseiSrj6-yw9a44=0+PWC8=_HKboC-fWkkzQ@mail.gmail.com>
 <CAFLszThAqVjZ0Jd5kdB5q=bhGTNpAeHw3WXpUHnFQ_OH_KmXLA@mail.gmail.com>
 <6d0f3078-2ba8-474c-9a1f-481eeb7f47bf@cherry.de>
 <CAFLszTi+4s51HtaQrgBLEsOzoCjtZ+CGdvqBm4B9_fj-rpKqwg@mail.gmail.com>
In-Reply-To: <CAFLszTi+4s51HtaQrgBLEsOzoCjtZ+CGdvqBm4B9_fj-rpKqwg@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 3 Jul 2026 18:11:15 +0100
X-Gm-Features: AVVi8CcqUKAvq736gNMjSfQ_CTS1wX-PwB5_5mD2ya3l-lw-Jzey9O4OHDaOBWI
Message-ID: <CALeDE9OWeMs3peX8+4+i6iTmZn-EO2e+7s7q6S1yFaRUa0dksQ@mail.gmail.com>
Subject: Re: U-Boot Concept Tree Proposal
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

> > >>>>> Another difference is AI. I believe that AI is the next step on from
> > >>>>> compilers, which also took a long time to produce good code and find
> > >>>>> acceptance. The Concept tree welcomes (and encourages) high-quality AI
> > >>>>> contributions and reviews. It accepts PRs and allows reviews on PRs or the
> > >>>>> mailing list. It relies 99% on automated tests (sandbox, QEMU and labs) so
> > >>>>> sets a high bar for testing. It uses a separate Gitlab instance for now and
> > >>>>> of course uses a separate mailing list and Patchwork project to avoid
> > >>>>> cluttering the main list. Concept runs an AI-powered cherry-picker so that
> > >>>>> it keeps up with mainline. In no sense is it operated as a fork.
> > >>>>
> > >>>> I'm clearly against using AI for any of development or review work as it
> > >>>> can't be fully trusted and will monopolize precious reviewers time reviewing
> > >>>> AI code instead of reviewing legitimate contributions from individual and companies.
> > >>>>
> > >>>> Using AI for CI testing and regression testing could help if it doesn't add
> > >>>> a burden for maintainers by reporting false positives.
> > >>>
> > >>> RIght, Tom has been very clear about this too, even suggesting that AI
> > >>> is actually unethical. This is indeed one of my motivations for the
> > >>> Concept tree.
> > >>
> > >> To avoid the scrutiny of using AI? If that's the case and you're
> > >> intention I have further concerns.
> > >
> > > Not really the scrutiny...the more scrutiny the better, I think. But
> > > if mainline is anti-AI then Concept can provide a place where people
> > > can make use of it.
> > >
>
> Thanks for taking the time to reply to this - it is a very important
> but very quiet thread.
>
> >
> > Tom has clearly communicated multiple times that AI is generally not
> > welcome in U-Boot. So how is accepting AI contributions into Concept
> > compatible with "Once features are landed and functional in Concept I
> > hope that many will find their way to mainline"? Who's going to do the
> > work? Who's going to take the legal liability of reworking AI-written
> > code for submission to mainline? How is this going to address the main
> > issue you're having of "code is not landing"? It's still not in mainline.
>
> U-Boot tends to follow Linux, so we'll see what U-Boot's policy turns
> out to be in .rst format. I am hopeful that eventually more people
> will see the cost/benefit ratio of AI in a different light. My
> understanding is the policy will be addressed once the infra move is
> finished. Linux requires disclosure, something I have worked hard to
> do in Concept. The legal question is covered by Linux's policy too
> [1]. I do understand that any new technology creates fans and
> opponents, problems and opportunities. Some thoughts at [3]
>
> My approach has generally been to embrace change (and deal with the
> fallout) rather than to resist it.
>
> >
> > What I think will happen is "I cannot get this merged into mainline so
> > I'm going to get it merged into Concept and then direct my users at
> > that". And eventually, over time, everything from this Concept
> > contributor and their users will only land in Concept and we won't even
> > have it on mainline ML.
>
> I don't want to speak for Tom, but yes I can trace the genesis of
> Concept to the increasing difficultly of getting things accepted,
> particularly large things like bootstd and VBE. What do you suggest
> instead of Concept?
>
> >
> > You keep repeating Concept is not a fork, but I don't understand how it
> > can NOT be one.
>
> Concept cherry-picks from mainline so that it stays up-to-date. So it
> should be possible to grab a feature from Concept and apply it to
> mainline without too many conflicts. A fork does not care about
> mainline at all. This is a big and complex topic though, since
> features build on each other (e.g. see the BLS thread [2] where the
> Concept version builds on pxe_utils refactoring, making it hard to get
> into mainline without several precursor series).

A fork of a project is where it diverges which a number of different
features, there's lots of projects with forks where the forks cherry
pick between each other and try and remain largely compatible. One
example that comes to mind is Linux Foundation forked the Ubuntu LXD
project to a project called Incus.

> > Considering Concept is apparently going to be hosted on the same GitLab
> > instance as mainline, I see this as potentially confusing people as to
> > what it actually is.
>
> Yes it could be confusing...I'm open to ideas on how to handle that.
>
> > I still am pretty upset at the various articles you
> > or AI in your behalf posted on the u-boot.org website claiming support
> > for various features in U-Boot either "submitted" (nowhere to be seen on
> > the ML) or not explicitly stating they are merged in a fork of U-Boot
> > (Concept, that is).
>
> See above re fork. I am responsible for the articles, although Claude
> and Gemini helped write most of them. I thought I was being quite
> careful to label things as 'Concept', but I've just gone back through
> and found a good number unfortunately did not. I've fixed those and
> also updated the titles in about 20 cases too. Please let me know if
> you see other problems.
>
> > That with the fact our official documentation used
> > to be on docs.u-boot.org really made it look like (to me) we were behind
> > this effort. We made the mistake of hosting the docs on a domain name we
> > didn't (still don't?) control, I would like to avoid repeating the same
> > mistake a different way by hosting a fork on the same instance as mainline.
>
> OK. Would a URL link to Concept be acceptable?

I don't think we have buy in from the community into the whole concept
fork as it is to be actually discussing links as yet.

I think you need to answer the questions to the community about concept:
1) Why are you holding the u-boot.org domain hostage over this
2) Maybe you need to read back through the input from the community
and revist what you think concept should be

I feel I was very clear, both on the community call when it was bought
up, which lead to you starting this thread so I had assumed you
understood that you had to get the community buy in.

In the follow up private discussions about it after it was clear as a
whole that the PLC was uncomfortable with a specific websiite (we
don't plan on supporting forks, would we provide that feature for all
forks?) for concept. I offered the idea of a custodians tree to allow
you to develop and maintain the features that you were preparing for
upstream in your concept tree to enable easier collaboration for those
that wished to work with you on those specific features. Maybe I
wasn't clear enough in my communications but it was never intended to
be the location to host a fork.

So I think you need to revist what the idea of concept actually is and
come back to the community with an adjusted proposal.

First though, I repeat again, would you please explain to the
community why you are holding the u-boot.oirg domain hostage to try
and force the PLC to accept an idea that we have been explicit about
the need to get the community to buy into this "concept". I think the
community deserves an answer.

> > U-Boot has friction also because we don't have enough reviewers or
> > maintainers compared to the number of contributors. I don't see how you
> > plan on addressing that by maintaining Concept by yourself (with an AI
> > I'm assuming).
> > I appreciate you're possibly one of the most if not the most active
> > reviewer on the ML and that there's not much more you can do to improve
> > the situation aside from recruiting more people to review.
>
> Yes I have generally been the most active reviewer over the last 10
> years or so, although sometimes I have burnout and stop.
>
> Here's how people become reviewers, IMO:
>
> Step 1: Punter has a problem, debugs it and conceives a fix / feature
> to resolve it
> Step 2: Punter sends a patch or short series

I'm not sure it's appropriate to call our developers and contributors
"Punters" [1] please be respectful of people.

> Step 3a: People review the code and Tom accepts some version of it
> Step 3b: Patch is rejected, or people are mean or dismissive, or don't
> understand the problem, or the effort gets too great (punter exits
> here and goes to write his own firmware in Rust :-)
> Step 5: Punter sees a related patch from someone else and decides to
> reply with some thoughts
> Step 6: Punter starts getting interested in more areas of U-Boot,
> sending patches and reviewing, etc.

I think going from a single patch to a firmware written in rust is a
bit of a fanciful stretch.

From experience people involved in the project review things when:
1) They know the topic or the hardware
2) Are interested in the features or functionality provided
3) Are a maintainer of a device or subsystem
4) Wish to assist
5) they have hardware they can test on
6) they wish to scratch an iitch.

Regards,
Peter

[1] https://www.urbandictionary.com/define.php?term=punter
