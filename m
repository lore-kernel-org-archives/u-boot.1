Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B967E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 14:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81234801B6;
	Thu, 12 Dec 2024 15:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lwc7grHZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68EE8801BD; Thu, 12 Dec 2024 15:05:09 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B90FA8018E
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 15:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d3bbb0f09dso1039325a12.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 06:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734012306; x=1734617106; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=by8khCtAsRnghwsGbSr6Dq/JDd7LAJqqgIr//f/oNws=;
 b=lwc7grHZ6ikBLvjOenc8OE1m068zBwmMA/6w17TLshz2Nowhzx0oQ3dQ4eO3gugHoc
 hSfA3aOWqOQIDpqYaTmJoPKLG7lJ2yiRuGMytQ6ogZjxpv+DpiU7OoKLL+PVYdCzaCGR
 PAZMEYI+VQDW9bym+PD6xZiPVQfDpaeUZbCdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734012306; x=1734617106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=by8khCtAsRnghwsGbSr6Dq/JDd7LAJqqgIr//f/oNws=;
 b=sU3V59M4lYEt/4QLW667pF4nb2pDlPxAcwv3eTdHkhZFnRpI6v9t6lJJtEjfCGriSf
 J3QE+M7xSRHFBVWiAdPOdHoUdmqoVoL8WIviL3Nq/jze034NvIWSVkD/mRzbmFaDP+lB
 AZeYFMr+WwFLXh9A0V2ZRjia4ymStwV5PUwcR9IEO/SJyqKjrEZSN7AyIJ/VKoum8lmE
 rHiZhLGo0wf7JbpWiCoquAwxWFfSvbodTKZlKFwh0Sf6w4OiSbo5V0p7al72pTYDu4XV
 MNadCCxnNsO+ojn/fyPtp2gZcwuKAWhvs1z7qNKoABp8lVILoFJewwayu1xzm++o96aY
 Lr9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+tPe7lEDU5qPoq6GRylVvu3hZof/RGayD8p0gZsIVvHTmt3DvygTOvB2qb0B3dhzNeyBbGMU=@lists.denx.de
X-Gm-Message-State: AOJu0YyT8ifEOu8u+dwl+7V93zEt9zraMlt0srGh94hCAv4+MYXL8doh
 /6D1GtbpSqj6h7Ll4jaEPsudVi8LJZM2pVg9N6pXRJVk8deYqOqNJc3LPUQK+x0F8akURLJdZQ7
 dlkSEXmpFq8y70qohyVq6pq2luHmQkovj6Q0w
X-Gm-Gg: ASbGncti/tIg1cG4qHg0yLG2VGsCdlWYzTxYHibRBMk7ZsHbYMJnosKMtXrMHfLV1dT
 /yos6WNceWdCXxPYN6ssUTFmypZSjASlprwJqLK8=
X-Google-Smtp-Source: AGHT+IEqeP4ECwZCt8hFlqsy3mWEdMl9iNFsd+3/86WQxRl19RUl5K6E69Tnrx+8oXL+GhxQQBu14hDyidOU0mA6Zq4=
X-Received: by 2002:a17:907:1ded:b0:aa6:94c0:f753 with SMTP id
 a640c23a62f3a-aa6c1b2a9d1mr367602466b.33.1734012305849; Thu, 12 Dec 2024
 06:05:05 -0800 (PST)
MIME-Version: 1.0
References: <20241202001243.1283274-1-sjg@chromium.org>
 <D477BE0D-064D-46CE-B83B-C8B1E546575D@gmx.de>
 <20241202141558.GD2457179@bill-the-cat>
 <CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com>
 <20241204012907.GD2457179@bill-the-cat>
 <CAFLszTgrd3gb0hfTCtRgaX2nwbCPhGKiftAJ8gCqrGDw-thOHw@mail.gmail.com>
 <20241204162707.GG2457179@bill-the-cat>
 <CAFLszTjs7taGs5LjiZ4XBgkJtjK_Db7ZiWwbpW6Kzz_tFjo=Rw@mail.gmail.com>
 <CAC_iWjL1f3T2YSNS4OV76EyvaU757XSt4xrG2kZFjMOwL-Y0Pg@mail.gmail.com>
In-Reply-To: <CAC_iWjL1f3T2YSNS4OV76EyvaU757XSt4xrG2kZFjMOwL-Y0Pg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Dec 2024 07:04:54 -0700
Message-ID: <CAFLszTgnzrBfS=TeCsKQRHKfufAs9x+M=VbOmF22T-guXx3R_A@mail.gmail.com>
Subject: Re: Applying patches to mainline (Was: Re: [PATCH v2 0/7] efi_loader:
 Add support for logging to a buffer)
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
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

Hi Ilias,

On Sat, 7 Dec 2024 at 01:18, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 6 Dec 2024 at 21:19, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Tom,
> >
> > On Wed, 4 Dec 2024 at 09:27, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Dec 04, 2024 at 08:13:04AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 3 Dec 2024 at 18:29, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Dec 02, 2024 at 05:21:05PM -0700, Simon Glass wrote:
> > > > >
> > > > > > From my side I'd like to change the conversation a little, to how to
> > > > > > land code, rather than why we should bother. "Code needs to land"
> > > > > > should be the motto. If someone has taken the time to create
> > > > > > something, our bias should be towards getting it in, with sufficient
> > > > > > changes to make it fit the project. There are cases where something is
> > > > > > just a bad idea, or should be done another way, but for people working
> > > > > > on major features or changes, biasing towards not landing the code is
> > > > > > just going to make them go elsewhere.
> > > > >
> > > > > This is the wrong approach I believe. The goal has always been and
> > > > > continues to be to have reviewed (whenever possible, our developer
> > > > > community is small) incremental change over time.
> > > >
> > > > Yes, I agree with that, but it isn't what I said.
> > >
> > > I don't know how else to interpret "Code needs to land". I'm not sure
> > > what reviewed patches we have that are outstanding, but also not fairly
> > > new. We do have patches outstanding, in general. Much of those fall in
> > > to the categories of:
> > > - Custodian is active, but also very busy (virtually everyone is a
> > >   volunteer so I have a hard time getting forceful with people that have
> > >   a large queue).
> > > - Custodian isn't active / no direct custodian and the code hasn't been
> > >   reviewed by anyone else.
> >
> > Here's my intention with 'code needs to land': to bias against people
> > saying "I don't like this; I don't care about your use case; please go
> > away"
> >
> > >
> > > > > Just because something
> > > > > has been posted a number of times does not mean it's ready to be merged.
> > > >
> > > > I didn't say that either.
> > >
> > > It's an impression you give however when you repost a series less than a
> > > day after last posting, without addressing all of the feedback.
> >
> > I'm going to ignore that comment as it is not helpful and
> > mischaracterises my contributions.
> >
>
> I don't know how that mischaracterizes your contributions. No one is
> trying to debase your contributions or be unappreciative of your
> efforts.
>
> But having 6-7 simultaneous patchsets of 30+ patches is simply
> impossible to track. So you do miss addressing feedback, but no one
> said it's done deliberately. I am pretty sure it's just natural due to
> the large volume of patches.
> It would be *way* easier for reviewers and you if you tried to send
> smaller patchesets that you could reliably track, discuss, and
> address.
>
> On a personal note, it's frustrating for me because I constantly need
> to go back and forth between older conversations to figure out what
> comments you decided to address on revision X. It takes 3x of the
> usual time I need to review other patches and on top of that reviewing
> a series of 30+ patches takes time and takes more time to merge
> because it's simply a lot of code to review. So my suggestion is to
> spend some time and think how to make the *reviewers* life easier
> instead of yours.

I find it hard to review subsequent revisions, too. I tend to assume
that people have made the changes and I use the per-patch change log
to see that.

If this were the core issue, I believe I could improve it with better
tooling, to keep track of lots of smaller series.

>
> > >
> > > > > Your challenge today is that on patchwork you have over 150 patches
> > > > > covering a wide variety of topics and of which many series have
> > > > > technically-merited feedback that needs to be addressed in a technical
> > > > > manner.
> > > >
> > > > By my count I have about 10 series in progress, with a small number of
> > > > patches (< 10?) with pending feedback
> > >
> > > I'm not sure about that less than 10 number, in part because it's hard
> > > to keep track of which feedback was applied, and which not. And part
> > > because some of those series are places where I told you I'm unsure
> > > about the core concept but you asked and I'm giving you leeway to show
> > > me the end result.
> >
> > OK
> >
> > >
> > > > that isn't effectively just a
> > > > NAK.
> > >
> > > To be clear, "just a NAK" isn't the whole story. Those NAKs come with
> > > technical rationales and requests. But maybe they're just lost in the
> > > volume of emails you have in some cases. I know for example I mentioned
> > > a few times and places that we have tests today for booting the OS, when
> > > you mention that we need to add a test for booting the OS. We need to
> > > expand that test, yes.
> >
> > If you look at the OF_BLOBLIST thing, it is basically a NAK. I don't
> > see any other way to interpret it,. So several boards in my lab have
> > been broken for a year.
>
> I haven't had time to look into that series, but I will. The problem
> with reverts like that is
> - I get the feeling you need some special code for some special
> ancient chromebooks that no one cares or uses apart from you. That's
> problematic overall. We can't just make a project look weird because
> some hardware is special. It's the hardware that has to adapt, not the
> other way around
> - Reverts need to have a *very solid* explanation.
>
> For example, this is your x86 revert patches
> https://lore.kernel.org/u-boot/20241112131830.576864-1-sjg@chromium.org/
> and this is what actually got merged
> https://lore.kernel.org/u-boot/20241129170814.768438-1-ilias.apalodimas@linaro.org/
> Which one would you rather read a year from now debugging a similar issue?

Reverts are done to fix regressions. We don't need to justify a revert
that breaks something. It is just a revert. You can see how this
should be done at [1]. Tom applied it within a day, without any fuss,
as he should. No, this is not a core issue either.

>
> Another example is the fdt sutff here
> https://lore.kernel.org/u-boot/20241201144240.1664398-5-sjg@chromium.org/
> Tom, Raymond and I spent a lot of our time explaining why we need this
> feature like this and what's the technical reason behind the decision.
> Your commit message basically says "I know better and you should all
> listen to my almighty ideas and btw this breaks 3 special ancient
> platforms, so I am reverting this".

This is a deflection at best. WIth OF_BLOBLIST, you can just enable
that option and get what you want. You can even make it the default in
U-Boot. The issue is that you don't want to have the option. But
without the ability to turn the option off, my special, ancient
platforms, that no one cares about except me, break.

> Now I don't know who Kevin and BoB
> are and I wish them luck, but that's hardly a readable commit message
> or will mean anything in a year from now.

chromebook_kevin and chromebook_bob are a rk3399-based Chromebooks

Again, the commit message is not a core issue. If you found yourself
in a reflective mood, you might want to consider how I feel about 5-6
platforms which I care about a lot, being permanently broken in Tom's
tree.

>
> The way I read this commit message is that you show zero respect for
> the effort all of the other people put into code explaining and
> documenting the feature, your 'justification' has no technical
> background whatsoever and then you come back complaining that people
> don't appreciate your efforts.

Obviously you are entitled to your opinions, but I don't agree, sorry.
I doubt anyone is particularly interested in my thoughts on this, so
I'll refrain from commenting further.

Just to confirm, nothing in your email appears to address any of my
concerns. If it was intended to, please point out what I missed.

>
> /Ilias
> >
> > >
> > > > It isn't a particularly large number, if you add up the patches I
> > > > do in each cycle. It is in the nature of development and code review
> > > > that things are often not right the first time, or someone else has
> > > > another perspective, so I cannot see how this can be reduced.
> > >
> > > The easy way to reduce it would be to go from 10 series in progress to 1
> > > series in progress, and finish that before picking up series number 2,
> > > and so on. And then in the future, stop when you have more than 2 or 3
> > > in progress at once.
> >
> > That's obviously not practical for the amount I am contributing and
> > the length of time it takes us to get things in. I hope it isn't a
> > serious suggestion!
> >
> > >
> > > But really, it feels like "Code needs to land" is another way of saying
> > > "Just a NAK should be ignored".
> >
> > Yes, a bias more towards that would be more healthy IMO. A NAK needs
> > to come with a full understanding of the use case, an alternative way
> > to meet the use case, once that doesn't involve boiling the Pacific
> > Ocean.
> >

- SImon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20241201144240.1664398-8-sjg@chromium.org/
