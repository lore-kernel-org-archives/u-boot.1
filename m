Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE07E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:19:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3CFC8921B;
	Fri,  6 Dec 2024 20:19:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AtvsYVJA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EAE189376; Fri,  6 Dec 2024 20:19:57 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D852488F20
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:19:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2eb1433958dso1780680a91.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733512793; x=1734117593; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p6p9GSGRQhVCsoRZUetwjbChqGnC48yxIZeC8knmh8s=;
 b=AtvsYVJAIOmMK8lsf/ulO3eWBAF5B/r9EZb3IH04GNsUPQXhsEgpNHztsjDgbo8Qnz
 UnFmiwvMwO8yEZgIhlKumcXSjbUh1120t0J2ZoEWqq439TneMQQHWMHYAvbdLKdADr+y
 UlXVWX8eQeqDIoMG4xW3JWkI1xliTEJJOwL3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512793; x=1734117593;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p6p9GSGRQhVCsoRZUetwjbChqGnC48yxIZeC8knmh8s=;
 b=iuUWsuBEUQ4jtDHmBCHZDA+itTEUapJMjoNovofkW16LA7JNSJe+b9T7pGDKy1vEu6
 UBzsXi2BlTg2QFNZSZgE8HfnjLhMnYzv2h/Lml3v8kvVxVa6m126Hwl7hF7vJAMK/snT
 mnTVgzIXBktYvofx2WpNtB9QBlg9ej8ZBkFvfReZlHmlWUVxQIPP8OqevU05LepYO3U+
 fMUmJaEnZOE4YZsmXpwYIKBzobhWlQ3WiLIo9fLVhW8owaNR1Ajm1RcEMveJoUAL/sKe
 JmdZgUrtEZKiUjDfkebCRwTdAGRBnnyEMJkfMZJV7CkDnFyu5ZIUZLxpaRyzvQOVJgjy
 V8Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2V7uzk7blVy7wFZ/7keOx3WF+cHausbeyV5oDKqc3E2mZUcL/BnG/XTXLb9X5UVxHLwfcBx4=@lists.denx.de
X-Gm-Message-State: AOJu0YyjwHJ7jKSvfPDHVmrBNk7H0shV/bZsZdwcFPtWvOcz3O7wJi6x
 WpBjNJLBu9Buo5aW0u+uhNCG74FfIJZ+8OGU/jdPesjKXI9ECaRlFKnxc+wBdWSyLxxuUECKAla
 S2c7h/a7PfoVPx9U9rtyJavG9jMfKfEAS5545GwEXovAb6N4=
X-Gm-Gg: ASbGncvLtNiQyLP/+xo/SCbXf9f3WKSD7r2QA69nCFF1c0cc9l8R/TfyiLWhysse6eg
 mFlzwRxFydmb5Ya7552j23Wyal4Pf0Plv
X-Google-Smtp-Source: AGHT+IE3mq9mdaGwsH9wR1Y8ZSjg+GUH0lxZLVy/uyNEPgyfHKSezYPaFJ4cOTwWj9RwDBDrMmky+uLNy/T4V5hMXoA=
X-Received: by 2002:a17:90b:1e43:b0:2ee:8008:b583 with SMTP id
 98e67ed59e1d1-2ef69fffa82mr6959616a91.16.1733512793422; Fri, 06 Dec 2024
 11:19:53 -0800 (PST)
MIME-Version: 1.0
References: <20241202001243.1283274-1-sjg@chromium.org>
 <D477BE0D-064D-46CE-B83B-C8B1E546575D@gmx.de>
 <20241202141558.GD2457179@bill-the-cat>
 <CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com>
 <20241204012907.GD2457179@bill-the-cat>
 <CAFLszTgrd3gb0hfTCtRgaX2nwbCPhGKiftAJ8gCqrGDw-thOHw@mail.gmail.com>
 <20241204162707.GG2457179@bill-the-cat>
In-Reply-To: <20241204162707.GG2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 12:19:38 -0700
Message-ID: <CAFLszTjs7taGs5LjiZ4XBgkJtjK_Db7ZiWwbpW6Kzz_tFjo=Rw@mail.gmail.com>
Subject: Re: Applying patches to mainline (Was: Re: [PATCH v2 0/7] efi_loader:
 Add support for logging to a buffer)
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Tom,

On Wed, 4 Dec 2024 at 09:27, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 04, 2024 at 08:13:04AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 3 Dec 2024 at 18:29, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Dec 02, 2024 at 05:21:05PM -0700, Simon Glass wrote:
> > >
> > > > From my side I'd like to change the conversation a little, to how to
> > > > land code, rather than why we should bother. "Code needs to land"
> > > > should be the motto. If someone has taken the time to create
> > > > something, our bias should be towards getting it in, with sufficient
> > > > changes to make it fit the project. There are cases where something is
> > > > just a bad idea, or should be done another way, but for people working
> > > > on major features or changes, biasing towards not landing the code is
> > > > just going to make them go elsewhere.
> > >
> > > This is the wrong approach I believe. The goal has always been and
> > > continues to be to have reviewed (whenever possible, our developer
> > > community is small) incremental change over time.
> >
> > Yes, I agree with that, but it isn't what I said.
>
> I don't know how else to interpret "Code needs to land". I'm not sure
> what reviewed patches we have that are outstanding, but also not fairly
> new. We do have patches outstanding, in general. Much of those fall in
> to the categories of:
> - Custodian is active, but also very busy (virtually everyone is a
>   volunteer so I have a hard time getting forceful with people that have
>   a large queue).
> - Custodian isn't active / no direct custodian and the code hasn't been
>   reviewed by anyone else.

Here's my intention with 'code needs to land': to bias against people
saying "I don't like this; I don't care about your use case; please go
away"

>
> > > Just because something
> > > has been posted a number of times does not mean it's ready to be merged.
> >
> > I didn't say that either.
>
> It's an impression you give however when you repost a series less than a
> day after last posting, without addressing all of the feedback.

I'm going to ignore that comment as it is not helpful and
mischaracterises my contributions.

>
> > > Your challenge today is that on patchwork you have over 150 patches
> > > covering a wide variety of topics and of which many series have
> > > technically-merited feedback that needs to be addressed in a technical
> > > manner.
> >
> > By my count I have about 10 series in progress, with a small number of
> > patches (< 10?) with pending feedback
>
> I'm not sure about that less than 10 number, in part because it's hard
> to keep track of which feedback was applied, and which not. And part
> because some of those series are places where I told you I'm unsure
> about the core concept but you asked and I'm giving you leeway to show
> me the end result.

OK

>
> > that isn't effectively just a
> > NAK.
>
> To be clear, "just a NAK" isn't the whole story. Those NAKs come with
> technical rationales and requests. But maybe they're just lost in the
> volume of emails you have in some cases. I know for example I mentioned
> a few times and places that we have tests today for booting the OS, when
> you mention that we need to add a test for booting the OS. We need to
> expand that test, yes.

If you look at the OF_BLOBLIST thing, it is basically a NAK. I don't
see any other way to interpret it,. So several boards in my lab have
been broken for a year.

>
> > It isn't a particularly large number, if you add up the patches I
> > do in each cycle. It is in the nature of development and code review
> > that things are often not right the first time, or someone else has
> > another perspective, so I cannot see how this can be reduced.
>
> The easy way to reduce it would be to go from 10 series in progress to 1
> series in progress, and finish that before picking up series number 2,
> and so on. And then in the future, stop when you have more than 2 or 3
> in progress at once.

That's obviously not practical for the amount I am contributing and
the length of time it takes us to get things in. I hope it isn't a
serious suggestion!

>
> But really, it feels like "Code needs to land" is another way of saying
> "Just a NAK should be ignored".

Yes, a bias more towards that would be more healthy IMO. A NAK needs
to come with a full understanding of the use case, an alternative way
to meet the use case, once that doesn't involve boiling the Pacific
Ocean.

Regards,
Simon
