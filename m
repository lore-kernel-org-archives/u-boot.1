Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9071E7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 08:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C84CD89138;
	Sat,  7 Dec 2024 09:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F6nqddDL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1716788FA5; Sat,  7 Dec 2024 09:18:56 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02350891B4
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 09:18:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6efea3c9e6eso9106757b3.0
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 00:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733559532; x=1734164332; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PLaD1fa0At0WOULvfJWglWOO3TmOJLUEifmNSmuBCM8=;
 b=F6nqddDL6rxvPBO+5h/jiFzC56TvE96PUKqi0C8ie1FxuPBXYti4spu5YQsD1BJxwl
 NBGEsgeTmRT9Cg5gEjzpGUZpkwMNR/JoMbQMlksw9gcPIGlHqdgstqY7Tq2Yn/7yB8OG
 rbDv2dvB92AId4b4dQI8tB1uknXDl709R55iv+q3oeiLXjVXfa5HZJlKL1+BSmZieSFQ
 yLyMtZ2NdjjnlMUNRDzxRL0GFdXWttK8JWm1p/RhAjTMS0pSjRdpylVDRUCrMkvv0Kjs
 VMbAIgPhojY80csfjjrvcI8zs1R+ZvDNSRb6AWzBPOhGsDdXuvlVqK4rzDCIopKfxSRj
 F4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733559532; x=1734164332;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PLaD1fa0At0WOULvfJWglWOO3TmOJLUEifmNSmuBCM8=;
 b=k1pl0xjxv6cj1Zc0lXanVZj8fR/XjkA8pri23tCbB8SKxN7J7CdsS1c4tZ+Iqf9fSg
 0TBShoX2mqMcaywn1tsf7Sruzi6ekbilsFEzPXTz0BOblxuheG4GcMdkwXsluONv/+8d
 HxEQHpPpWHo2FE9l2/qehGsEBTN6/FRTYm5Y5ptDV+Dm8Abkp5Tk5gALeO4D0GoNhfQk
 KVyVV2F9/f5K0bVlKnZGbnNpvqs6rZ/WBXCSvP46vmU541TDytSwyErnu2kD2a+0/3TP
 oTBfe3Tf4Jy/cSoTpQsBj0lSylBhyfaaNWmOlh4jhT4fJ7Ap6kQavOSU2VR1EM3Fx4tH
 J9Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWLBMISsppNFmxnY6V+pWLn3N5gEOhj/eR7hX+scZCC58XImFPm4OBqCA00rKykTcU0XTKMD4=@lists.denx.de
X-Gm-Message-State: AOJu0YydUgHCl5YwqjeSk8+ksQdCjmq+fnP7yJBvvSzSjkc8WYYlzsqQ
 HPEwedHWBtoywyTGkKsK4R7RZckp/pflW6YmGnCf0Xxn4uXCzQEykDlfCHDGWvsQxrIgjhC0C/w
 OqGCZ49bNkJ2dlGRtHE8SVjDZP7bBnSNUGLY7E1wiVUfVB4m386E=
X-Gm-Gg: ASbGncvJ3C85at/7AikiHLW5Rs8p6P7SK6plqefSccSskP6rxQrwFaVabOtKtuZSiYT
 QyR1qPcqHJjm8VcGUVvXE3AzJWBpVk7E=
X-Google-Smtp-Source: AGHT+IHiG/6FfEzARRuKR+tvPb6GViBw0Y05ghtUQzldkPimtChgHFfzhfehy52QpEYNoMCC95fpX/H1P3QBUb+cE9Y=
X-Received: by 2002:a05:690c:698c:b0:6ee:4bee:d912 with SMTP id
 00721157ae682-6efe3c10098mr63383797b3.21.1733559531794; Sat, 07 Dec 2024
 00:18:51 -0800 (PST)
MIME-Version: 1.0
References: <20241202001243.1283274-1-sjg@chromium.org>
 <D477BE0D-064D-46CE-B83B-C8B1E546575D@gmx.de>
 <20241202141558.GD2457179@bill-the-cat>
 <CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com>
 <20241204012907.GD2457179@bill-the-cat>
 <CAFLszTgrd3gb0hfTCtRgaX2nwbCPhGKiftAJ8gCqrGDw-thOHw@mail.gmail.com>
 <20241204162707.GG2457179@bill-the-cat>
 <CAFLszTjs7taGs5LjiZ4XBgkJtjK_Db7ZiWwbpW6Kzz_tFjo=Rw@mail.gmail.com>
In-Reply-To: <CAFLszTjs7taGs5LjiZ4XBgkJtjK_Db7ZiWwbpW6Kzz_tFjo=Rw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 7 Dec 2024 10:18:15 +0200
Message-ID: <CAC_iWjL1f3T2YSNS4OV76EyvaU757XSt4xrG2kZFjMOwL-Y0Pg@mail.gmail.com>
Subject: Re: Applying patches to mainline (Was: Re: [PATCH v2 0/7] efi_loader:
 Add support for logging to a buffer)
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Fri, 6 Dec 2024 at 21:19, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Wed, 4 Dec 2024 at 09:27, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Dec 04, 2024 at 08:13:04AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 3 Dec 2024 at 18:29, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Dec 02, 2024 at 05:21:05PM -0700, Simon Glass wrote:
> > > >
> > > > > From my side I'd like to change the conversation a little, to how to
> > > > > land code, rather than why we should bother. "Code needs to land"
> > > > > should be the motto. If someone has taken the time to create
> > > > > something, our bias should be towards getting it in, with sufficient
> > > > > changes to make it fit the project. There are cases where something is
> > > > > just a bad idea, or should be done another way, but for people working
> > > > > on major features or changes, biasing towards not landing the code is
> > > > > just going to make them go elsewhere.
> > > >
> > > > This is the wrong approach I believe. The goal has always been and
> > > > continues to be to have reviewed (whenever possible, our developer
> > > > community is small) incremental change over time.
> > >
> > > Yes, I agree with that, but it isn't what I said.
> >
> > I don't know how else to interpret "Code needs to land". I'm not sure
> > what reviewed patches we have that are outstanding, but also not fairly
> > new. We do have patches outstanding, in general. Much of those fall in
> > to the categories of:
> > - Custodian is active, but also very busy (virtually everyone is a
> >   volunteer so I have a hard time getting forceful with people that have
> >   a large queue).
> > - Custodian isn't active / no direct custodian and the code hasn't been
> >   reviewed by anyone else.
>
> Here's my intention with 'code needs to land': to bias against people
> saying "I don't like this; I don't care about your use case; please go
> away"
>
> >
> > > > Just because something
> > > > has been posted a number of times does not mean it's ready to be merged.
> > >
> > > I didn't say that either.
> >
> > It's an impression you give however when you repost a series less than a
> > day after last posting, without addressing all of the feedback.
>
> I'm going to ignore that comment as it is not helpful and
> mischaracterises my contributions.
>

I don't know how that mischaracterizes your contributions. No one is
trying to debase your contributions or be unappreciative of your
efforts.

But having 6-7 simultaneous patchsets of 30+ patches is simply
impossible to track. So you do miss addressing feedback, but no one
said it's done deliberately. I am pretty sure it's just natural due to
the large volume of patches.
It would be *way* easier for reviewers and you if you tried to send
smaller patchesets that you could reliably track, discuss, and
address.

On a personal note, it's frustrating for me because I constantly need
to go back and forth between older conversations to figure out what
comments you decided to address on revision X. It takes 3x of the
usual time I need to review other patches and on top of that reviewing
a series of 30+ patches takes time and takes more time to merge
because it's simply a lot of code to review. So my suggestion is to
spend some time and think how to make the *reviewers* life easier
instead of yours.

> >
> > > > Your challenge today is that on patchwork you have over 150 patches
> > > > covering a wide variety of topics and of which many series have
> > > > technically-merited feedback that needs to be addressed in a technical
> > > > manner.
> > >
> > > By my count I have about 10 series in progress, with a small number of
> > > patches (< 10?) with pending feedback
> >
> > I'm not sure about that less than 10 number, in part because it's hard
> > to keep track of which feedback was applied, and which not. And part
> > because some of those series are places where I told you I'm unsure
> > about the core concept but you asked and I'm giving you leeway to show
> > me the end result.
>
> OK
>
> >
> > > that isn't effectively just a
> > > NAK.
> >
> > To be clear, "just a NAK" isn't the whole story. Those NAKs come with
> > technical rationales and requests. But maybe they're just lost in the
> > volume of emails you have in some cases. I know for example I mentioned
> > a few times and places that we have tests today for booting the OS, when
> > you mention that we need to add a test for booting the OS. We need to
> > expand that test, yes.
>
> If you look at the OF_BLOBLIST thing, it is basically a NAK. I don't
> see any other way to interpret it,. So several boards in my lab have
> been broken for a year.

I haven't had time to look into that series, but I will. The problem
with reverts like that is
- I get the feeling you need some special code for some special
ancient chromebooks that no one cares or uses apart from you. That's
problematic overall. We can't just make a project look weird because
some hardware is special. It's the hardware that has to adapt, not the
other way around
- Reverts need to have a *very solid* explanation.

For example, this is your x86 revert patches
https://lore.kernel.org/u-boot/20241112131830.576864-1-sjg@chromium.org/
and this is what actually got merged
https://lore.kernel.org/u-boot/20241129170814.768438-1-ilias.apalodimas@linaro.org/
Which one would you rather read a year from now debugging a similar issue?

Another example is the fdt sutff here
https://lore.kernel.org/u-boot/20241201144240.1664398-5-sjg@chromium.org/
Tom, Raymond and I spent a lot of our time explaining why we need this
feature like this and what's the technical reason behind the decision.
Your commit message basically says "I know better and you should all
listen to my almighty ideas and btw this breaks 3 special ancient
platforms, so I am reverting this". Now I don't know who Kevin and BoB
are and I wish them luck, but that's hardly a readable commit message
or will mean anything in a year from now.

The way I read this commit message is that you show zero respect for
the effort all of the other people put into code explaining and
documenting the feature, your 'justification' has no technical
background whatsoever and then you come back complaining that people
don't appreciate your efforts.

/Ilias
>
> >
> > > It isn't a particularly large number, if you add up the patches I
> > > do in each cycle. It is in the nature of development and code review
> > > that things are often not right the first time, or someone else has
> > > another perspective, so I cannot see how this can be reduced.
> >
> > The easy way to reduce it would be to go from 10 series in progress to 1
> > series in progress, and finish that before picking up series number 2,
> > and so on. And then in the future, stop when you have more than 2 or 3
> > in progress at once.
>
> That's obviously not practical for the amount I am contributing and
> the length of time it takes us to get things in. I hope it isn't a
> serious suggestion!
>
> >
> > But really, it feels like "Code needs to land" is another way of saying
> > "Just a NAK should be ignored".
>
> Yes, a bias more towards that would be more healthy IMO. A NAK needs
> to come with a full understanding of the use case, an alternative way
> to meet the use case, once that doesn't involve boiling the Pacific
> Ocean.
>
> Regards,
> Simon
