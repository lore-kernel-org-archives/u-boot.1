Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7DBC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:19:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1410F8129B;
	Wed,  5 Mar 2025 15:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oVrhaNPg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D87808B6; Wed,  5 Mar 2025 15:19:41 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F01B981276
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac0b6e8d96cso487807166b.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741184378; x=1741789178; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mgFlxWU6LTybP7X8Dy0r6kE0XuXTdtcVhrX2Tp3uBos=;
 b=oVrhaNPgT9deyytNOK2TkmHRi0woueZ+vxyiLWiprvpNbEIqQf4Tc+lm9pZRUJdp/D
 eiDoUXbvdQINLzd9Pev4KQcKD9Qz/NtFJcv10PwQiI39jrDH6mwxncTOL2lnqFYO3c9C
 anNsItdw+1uPSMUBltGYqZpx5pM2+h5Y2PMyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741184378; x=1741789178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mgFlxWU6LTybP7X8Dy0r6kE0XuXTdtcVhrX2Tp3uBos=;
 b=szP2ZpifInv0MyLF7DHkHYORHHe5QY9OmuwDk4xUqzlg9j/cWfMvxkU4Tm3SROz33i
 3xdELdJwBj609xNLx8kKwijlLaH2/g38HWqQnbSV3AIcfrP7bKKGRxIDFURyjZusc1uW
 Bk38crMNr9pdDxW78R8tQ1cMF+4LMiiNRIzQA8mmICCNXhUC83gBmSdWX8WavVbjY6fK
 eXwiyxi7Gt22LP7C6TP+WVC2rZMjt5U/tJxS98LC5qFj3dobzi76XzoR1GVq8ZAEZoKs
 ZZP9lRUdET9YaQ+ZuLn8bLzNVLBv4QABPMsXJVsvQ8ZjamKfT+HNp7V6u6BEK6Hq+ney
 cmNg==
X-Gm-Message-State: AOJu0YwQy35kIbNIYDXk+qQhKeg7qYuVsysZNdPgbLf+iwGDoKyNvqjl
 S4W2Hq4rzVqMa3M7jt3roytRxEk+sTVmybLb/OKKFP6oiIosg2l0eDGwzzZ+pMgc5ogPjgQMLOH
 haixdLdzI5w8KyHod/CdDw5sj0UVzVJ850dyt
X-Gm-Gg: ASbGncvVFWHjpHemFTSk+fmiVq2FGRv46NoeC6BwJelC7nh36SU8skYSqbkMRA53lkE
 kJrkcY2lQAGjMRJE3cypgxwHSuJbHyZriP0nmIkICsSvn8RaLBcI9qK0lH/RRVMfBXspgDga0mA
 yuHhkI5Jp4pHjVMBv/usnlsCeetHs=
X-Google-Smtp-Source: AGHT+IEPWbm9NjSMaXG1F9nxh8Go+jmOeB7edP1CUnLDgDNYmutHUEXnmaf4Q9RbaBgUiJ44WqrMMd5PLp/2diLCUE0=
X-Received: by 2002:a17:907:8b9a:b0:abe:cccd:9222 with SMTP id
 a640c23a62f3a-ac20db05a16mr331714566b.54.1741184378140; Wed, 05 Mar 2025
 06:19:38 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTh=Mn9Hxe41KBB+8xjBBxVv=spV=g26tY+Hq6q43EM4=w@mail.gmail.com>
 <20250220204001.GC1233568@bill-the-cat>
 <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
 <20250221141940.GG1233568@bill-the-cat>
 <CAFLszTh=oq3z4P_tAKYETHE40yfHQOH1XHeKqmhQEAQ=PL1HUw@mail.gmail.com>
 <20250221175320.GN1233568@bill-the-cat>
 <20250221181055.GO1233568@bill-the-cat>
 <CAFLszTgnj+ZFq1vEcSSKCOeYjx0NKesO8Lo3aOJ2Nm-jhuTvig@mail.gmail.com>
 <20250224232303.GJ1233568@bill-the-cat>
 <CAFLszTgtdETGCYYtH3ni7Wv0W6Ckv1SoZRG8djQ-3uKBn1YZWQ@mail.gmail.com>
 <20250304152909.GZ2640854@bill-the-cat>
In-Reply-To: <20250304152909.GZ2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Mar 2025 07:19:25 -0700
X-Gm-Features: AQ5f1Jpejs8ON31b4fOTeWgMJ4TuSmOLWV_c7pNPj-0M7RdENRH4TkdRnugEngM
Message-ID: <CAFLszTiNQSs51iE=rcM7qQjipmWCKZiPX+gV2ztb+ZAB8m2MBw@mail.gmail.com>
Subject: Re: Rate of innovation in the project (Was: Re: Rate of change in the
 project)
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

On Tue, 4 Mar 2025 at 08:29, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Mar 04, 2025 at 06:13:36AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > (I changed the subject as 'change' sounds like change for change's sake)
>
> Frankly, you have a lot of "tidy up" patches where nothing was
> functionally wrong.

Yes, but they are important too. One of the problems I see with U-Boot
is that not enough people are willing to do refactoring and code
maintenance on the required scale.

>
> > On Mon, 24 Feb 2025 at 16:23, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Feb 22, 2025 at 05:00:59PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > (I think you chopped off too much context, so I've added it below)
> > >
> > > That's fine. But I omitted it because it's also true for any other DM
> > > migration, and bootstd more fully and adding more classes of devices for
> > > bootmeths and I honestly think you have a half dozen big things that are
> > > in various states of being merged and enabled and perhaps even more that
> > > didn't get much past sandbox being enabled.
> >
> > Yes I often have new ideas and start things.
>
> And my point is they need to be finished.

We've been through this quite a bit and I believe we have a shared
understanding of why it is hard for me to 'finish' things in your
tree.

>
> > > > On Fri, 21 Feb 2025 at 11:11, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Feb 21, 2025 at 11:53:20AM -0600, Tom Rini wrote:
> > > > > > On Fri, Feb 21, 2025 at 08:03:12AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > [snip]
> > > >
> > > > [unsnip]
> > > > > > > > >
> > > > > > > > > Sure, but we can't even get sunxi bootstd or LED over the line. How do
> > > > > > > > > you imagine we could retire the legacy image?
> > > > > > > >
> > > > > > > > Partly by focusing on one thing and not 5 things at a time. bootstd is
> > > > > > > > stuck on reworking efi bootmanager integration, and LED is waiting for
> > > > > > > > someone to confirm that really, finally, we have all of the old use
> > > > > > > > cases supported in the new code.
> > > > > > > >
> > > > > > > > But more importantly, do we really have anyone not using u-boot.img? I
> > > > > > > > don't know.
> > > > [unsnip end]
> > > >
> > > > > > > If we did one of these sorts of things at a time, we would only get
> > > > > > > 2-3 things done each year!
> > > > > >
> > > > > > A project with 4 yearly releases finishing two 2-3 big changes a year
> > > > > > sounds great to me. Rather than not finishing a dozen things?
> > > > >
> > > > > As this is a huge thread already, I'm splitting this part out.
> > > > >
> > > > > I would seriously frame slowing down and having just one big change
> > > > > being in progress at a time, until it's done, as a good thing, not a bad
> > > > > thing. We're a small community with limited bandwidth.
> > > >
> > > > I can't see how that would work.
> > >
> > > Well, what we have today is clearly not working well enough for you. And
> > > "just land my changes" is still not an option for mainline.
> >
> > You really haven't addressed my point here.
>
> Then I don't see your point, or fundamentally disagree with it.

My point is that I am trying to keep U-Boot in a position to solve the
major problems I see with boot firmware, largely because I don't see
much else out there. I can't do that with 2-3 big changes a year, not
even close.

>
> > > > I just looked at LED[1] originally sent almost 5 months ago and the
> > > > latest version is marked 'changes requested'. I don't know of any
> > > > changes I can make. Are you hoping that [sorry forgot who it was] will
> > > > get around to digging the only affected device out of his drawer and
> > > > try to get the activity-LED going? It might take a while.
> > >
> > > Yes, and as a reminder it's only been 6 or 7 months since mainline had
> > > all of the required functionality, maybe. And what *you* could do to
> > > speed things along is implement the functionality on any of the boards
> > > at your disposal. Anything with a LED today would be fine for this.
> >
> > Oh well. I would have thought that Christian's series was enough there?
>
> Might be. Waiting for someone to have time to confirm functionality.
> Which you had previously agreed was a good idea, I thought.

OK, so we'll just wait another few releases?

>
> > > > The sunxi one[2] was sent over 6 months ago and the latest version is
> > > > also marked 'changes requested'. You could apply that series with
> > > > either the bootmgr revert or the patch that drops bootmgr for sunxi.
> > > > Then Heinrich can come along with his patch on top of that.
> > >
> > > The sunxi one is blocked because it needs to be rebased on top of the
> > > fix I did for BLK stuff and then yes you also could have done the
> > > "bootstd uses bootmanager" idea that you've both agreed is a step in the
> > > right direction. Because it's actually a generic issue with bootmgr +
> > > bootstd that only became more evident as more platforms moved
> > > towards using it.
> >
> > So can you clearly explain what is blocking sunxi?r
>
> In no particular order:
> - Testing.
> - Fixing the problems with efi boot manager, which is a global "use
>   bootstd more" problem, not sunxi
>
> And maybe:
> - Handle FEL correctly. I'd have to re-read everything again to see if
>   that was resolved right, or not.

Andre did the testing which is how he found the bootmgr/FEL problem.
FEL is handled correctly in my series.

For bootmgr, there are two patches in my series so you can choose
which one you want.

>
> > Does it just need a rebase?
>
> Not just a rebase.
>
> > Which patches should be included and which not?
>
> Once the efi boot manager part is fixed, just the parts required for it?

So just take the patch which disables bootmgr from sunxi?

>
> > Also we
> > normally expect patches sent first to have priority.
>
> No we don't. There might be some general advice / rules of thumb but
> it's far from some sort of absolute rule. Things are merged when they
> work and are correct.

Well I was a bit put out seeing the series rejected on v3 due to an
out-of-tree thing I wasn't aware of.

>
> > Here you have
> > apparently applied your BLK stuff and then want me to rework on top of
> > it?
>
> Yes, I applied the "handle BLK correctly" part that I tried to explain
> to you how to fix a few times, and you either didn't understand or
> didn't care. I'm leaning more towards "didn't care" now and thought we
> should break things a little bit first and fix them later.
>
> > I agreed to the bootmanager work-around but I'm certainly not going to
> > write it. I would rather make bootmgr more iterative, if that is
> > possible.
>
> Then more bootstd migrations are likely blocked until it can handle efi
> boot manager correctly, which you don't want to do.

The correct way to handle bootmgr is (probably?) to have it use
bootstd to scan for stuff. But as you know, I can't get patches into
the EFI subsystem, so it's moot.

>
> > > Which is why I had spent so much time trying to get
> > > you to migrate more SoCs to bootstd because it's your feature.
> >
> > So take the sunxi patches and then I'll do the next one? On the one
> > hand you complain that there are too many balls in the air and on the
> > other you stop the balls from landing. It just doesn't 'compute' for
> > me, sorry.
>
> Yes, I'm sorry you're having trouble following my requests. Again, I
> wanted more bootstd migration not for its own sake, but to expose
> problems with the framework and for you to then fix those problems.

There is no problem with the framework. Please just follow my notes
above and apply the patches. Specifically these ones:

733876246aa sunxi: Add a bootmeth for FEL
ab5fbb4f7c0 efi_loader: bootstd: Drop bootmgr for sunxi
(leave this one out for now) 9f4ed60d90c RFC: Revert "bootstd: Make
efi_mgr bootmeth work for non-sandbox setups"
90d88509ebd sunxi: Move to bootstd
e0a16425620 sunxi: Drop old distro boot variables
da69a979ec7 env: Provide a work-around for unquoting fdtfile
7c37601d6be (dm/std-working, dm-public/std-working) sunxi: Move to
text environment

I'm tired of hearing that there is something wrong with bootstd here,
so please stop saying that.

>
> > > So yes, I think things would be in a better place if we tried to get
> > > *less* big things done at once and didn't pick up another big thing
> > > until the last was really done.
> >
> > You should address my point above. Are you trying to limit me to 3-4
> > large series a year?
>
> You personally? No. The whole project? Yes, one big feature that's
> complete and works every 3 months for a project with limited resources
> sounds amazing. U-Boot isn't a toy personal project, it's something used
> in production on real devices and needs to move at a sustainable pace
> with minimal regressions.

I believe that is getting better with the increased focus on testing,
something which I have been pushing for years.

Regards,
Simon
