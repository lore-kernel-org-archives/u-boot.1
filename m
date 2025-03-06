Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8742C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9818F81895;
	Thu,  6 Mar 2025 17:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HtOyqsva";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41C5281433; Thu,  6 Mar 2025 17:11:08 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAA05808A2
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bbc8b7c65so10274575e9.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277459; x=1741882259; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hHWk+8m7BQC9Aeqv7rZlr3oL5IXw0VdJCNFMSPvc9/w=;
 b=HtOyqsvajRJbonvmKcrXo+cjQK++TrSeXO/4Sy5k0ute0ixO98IL4547xfa6dt+dNm
 fJve/nged5jLgJBExV+495ELmGq1dHT+mnpTkh5goJift10/XBlfyRTCjmfV4bP8+Xiq
 qYW5keP+QLqqVRUOF/zSPzC0gSO7+Hljya5YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277459; x=1741882259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hHWk+8m7BQC9Aeqv7rZlr3oL5IXw0VdJCNFMSPvc9/w=;
 b=fMXeZrmlFJ6Gusiv93R0aeEOKXcG16F4NZiKIpyADTtnjWWuAGtgceI0XUZ+AiI/+k
 qTfDk+TUnd0aGx+08UjwGOnkbt14Gqk9awM/Hv3Xz3+3vCFYgdv3vo5S+KXznJc1bU/2
 qBEj/8EdrR36Bi6GCIv2m5xCGoHgJ4JuPU9aHTqepBty81uDLQR0rNqjy+qRQuHauIkm
 qbyWlTvLB5t4fIXgkXin9csPiiVxbz4OejQL00rwDFFqwkTEE9HISKvma5WxeNmVG3mZ
 m1K4DHdW435SQZ/32EOC2MkdFB6DWy1uMd/d3bqGF0ioGb5xMCiZ6F6gXOGfkOmgG5Qj
 6Org==
X-Gm-Message-State: AOJu0Yx5kGPesCYZUhUVdtNAgFaSMRkLwYH3LN0fgLT2WXM2b/lWTsAh
 2HztkRU/Y59qkqCLSCN6UcVnLgRpoBxhplsdGrZbwQJnttIUBegF8ZKZ5dm9XBJqQlN4cOkGbIA
 +uWcjV8bdKD8/6F9Zr4jx6yq6mqb4iwcXkleeALt7P/+PRIs=
X-Gm-Gg: ASbGncuqJhqEY1x4JNLrwzsLrszWXDDOKbv/LEfWI6KAHejeo14qYkpVWBquZGSN9At
 xQqqoPETz98j121Whve86trmD3TU+yMj/WbHvWrmweTyBhtN5StNvzuwRs74M8pN3/KBwLauc3I
 WiuBEd2foFgxA9+zktQjfLKznvST8=
X-Google-Smtp-Source: AGHT+IE0c1acZIbooe30U0TGKQglzdcp02HgkFUpw+wxoUKhcz84TJImf4soctysEyLTFd8zitIypxN9BVnwJWvjYM0=
X-Received: by 2002:a05:6000:1565:b0:390:ee34:228b with SMTP id
 ffacd0b85a97d-3911f7564fcmr8506037f8f.24.1741277458974; Thu, 06 Mar 2025
 08:10:58 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
 <20250221141940.GG1233568@bill-the-cat>
 <CAFLszTh=oq3z4P_tAKYETHE40yfHQOH1XHeKqmhQEAQ=PL1HUw@mail.gmail.com>
 <20250221175320.GN1233568@bill-the-cat>
 <20250221181055.GO1233568@bill-the-cat>
 <CAFLszTgnj+ZFq1vEcSSKCOeYjx0NKesO8Lo3aOJ2Nm-jhuTvig@mail.gmail.com>
 <20250224232303.GJ1233568@bill-the-cat>
 <CAFLszTgtdETGCYYtH3ni7Wv0W6Ckv1SoZRG8djQ-3uKBn1YZWQ@mail.gmail.com>
 <20250304152909.GZ2640854@bill-the-cat>
 <CAFLszTiNQSs51iE=rcM7qQjipmWCKZiPX+gV2ztb+ZAB8m2MBw@mail.gmail.com>
 <20250305162236.GT2640854@bill-the-cat>
In-Reply-To: <20250305162236.GT2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Mar 2025 09:10:47 -0700
X-Gm-Features: AQ5f1JrIGirjjWDk_kajfwTDKtjkYRKRiLxpsgreUwXzqUG1Y52ILrSrHSEMXO8
Message-ID: <CAFLszTjv54tYLHkG=RNeXJoZ+f-QHxMH=B_aU2=iOZhaoD7qKg@mail.gmail.com>
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

On Wed, 5 Mar 2025 at 09:22, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 05, 2025 at 07:19:25AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 4 Mar 2025 at 08:29, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Mar 04, 2025 at 06:13:36AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > (I changed the subject as 'change' sounds like change for change's sake)
> > >
> > > Frankly, you have a lot of "tidy up" patches where nothing was
> > > functionally wrong.
> >
> > Yes, but they are important too. One of the problems I see with U-Boot
> > is that not enough people are willing to do refactoring and code
> > maintenance on the required scale.
>
> Again, how much "refactoring" is needed of everything.

Without regular refactoring, projects just die.

>
> > > > On Mon, 24 Feb 2025 at 16:23, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Feb 22, 2025 at 05:00:59PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > (I think you chopped off too much context, so I've added it below)
> > > > >
> > > > > That's fine. But I omitted it because it's also true for any other DM
> > > > > migration, and bootstd more fully and adding more classes of devices for
> > > > > bootmeths and I honestly think you have a half dozen big things that are
> > > > > in various states of being merged and enabled and perhaps even more that
> > > > > didn't get much past sandbox being enabled.
> > > >
> > > > Yes I often have new ideas and start things.
> > >
> > > And my point is they need to be finished.
> >
> > We've been through this quite a bit and I believe we have a shared
> > understanding of why it is hard for me to 'finish' things in your
> > tree.
>
> I don't think we do. Because from my point of view you're as interested
> in finishing up the details and working through the migrations as you
> are on moving to the next thing.

That sounds right, it is nice to finish migrations. But I don't like
the slowness of it all.

>
> > > > > > On Fri, 21 Feb 2025 at 11:11, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Fri, Feb 21, 2025 at 11:53:20AM -0600, Tom Rini wrote:
> > > > > > > > On Fri, Feb 21, 2025 at 08:03:12AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > [snip]
> > > > > >
> > > > > > [unsnip]
> > > > > > > > > > >
> > > > > > > > > > > Sure, but we can't even get sunxi bootstd or LED over the line. How do
> > > > > > > > > > > you imagine we could retire the legacy image?
> > > > > > > > > >
> > > > > > > > > > Partly by focusing on one thing and not 5 things at a time. bootstd is
> > > > > > > > > > stuck on reworking efi bootmanager integration, and LED is waiting for
> > > > > > > > > > someone to confirm that really, finally, we have all of the old use
> > > > > > > > > > cases supported in the new code.
> > > > > > > > > >
> > > > > > > > > > But more importantly, do we really have anyone not using u-boot.img? I
> > > > > > > > > > don't know.
> > > > > > [unsnip end]
> > > > > >
> > > > > > > > > If we did one of these sorts of things at a time, we would only get
> > > > > > > > > 2-3 things done each year!
> > > > > > > >
> > > > > > > > A project with 4 yearly releases finishing two 2-3 big changes a year
> > > > > > > > sounds great to me. Rather than not finishing a dozen things?
> > > > > > >
> > > > > > > As this is a huge thread already, I'm splitting this part out.
> > > > > > >
> > > > > > > I would seriously frame slowing down and having just one big change
> > > > > > > being in progress at a time, until it's done, as a good thing, not a bad
> > > > > > > thing. We're a small community with limited bandwidth.
> > > > > >
> > > > > > I can't see how that would work.
> > > > >
> > > > > Well, what we have today is clearly not working well enough for you. And
> > > > > "just land my changes" is still not an option for mainline.
> > > >
> > > > You really haven't addressed my point here.
> > >
> > > Then I don't see your point, or fundamentally disagree with it.
> >
> > My point is that I am trying to keep U-Boot in a position to solve the
> > major problems I see with boot firmware, largely because I don't see
> > much else out there. I can't do that with 2-3 big changes a year, not
> > even close.
>
> Then maybe you need to fork off and make Simon-Boot. Or maybe you need
> to take leadership of the project as a whole. Because I do not see what
> you want as sustainable for the project.

Or you could just be a little more flexible?

>
> > > > > > I just looked at LED[1] originally sent almost 5 months ago and the
> > > > > > latest version is marked 'changes requested'. I don't know of any
> > > > > > changes I can make. Are you hoping that [sorry forgot who it was] will
> > > > > > get around to digging the only affected device out of his drawer and
> > > > > > try to get the activity-LED going? It might take a while.
> > > > >
> > > > > Yes, and as a reminder it's only been 6 or 7 months since mainline had
> > > > > all of the required functionality, maybe. And what *you* could do to
> > > > > speed things along is implement the functionality on any of the boards
> > > > > at your disposal. Anything with a LED today would be fine for this.
> > > >
> > > > Oh well. I would have thought that Christian's series was enough there?
> > >
> > > Might be. Waiting for someone to have time to confirm functionality.
> > > Which you had previously agreed was a good idea, I thought.
> >
> > OK, so we'll just wait another few releases?
>
> Until someone, which could be you even, has the time to verify things,
> yes. Easily. Happily.

The incentives are wrong here, of course. People should *want* to test
in case patches break their use case. People who wait 6 months to test
are just not that interested in the project.

>
> > > > > > The sunxi one[2] was sent over 6 months ago and the latest version is
> > > > > > also marked 'changes requested'. You could apply that series with
> > > > > > either the bootmgr revert or the patch that drops bootmgr for sunxi.
> > > > > > Then Heinrich can come along with his patch on top of that.
> > > > >
> > > > > The sunxi one is blocked because it needs to be rebased on top of the
> > > > > fix I did for BLK stuff and then yes you also could have done the
> > > > > "bootstd uses bootmanager" idea that you've both agreed is a step in the
> > > > > right direction. Because it's actually a generic issue with bootmgr +
> > > > > bootstd that only became more evident as more platforms moved
> > > > > towards using it.
> > > >
> > > > So can you clearly explain what is blocking sunxi?r
> > >
> > > In no particular order:
> > > - Testing.
> > > - Fixing the problems with efi boot manager, which is a global "use
> > >   bootstd more" problem, not sunxi
> > >
> > > And maybe:
> > > - Handle FEL correctly. I'd have to re-read everything again to see if
> > >   that was resolved right, or not.
> >
> > Andre did the testing which is how he found the bootmgr/FEL problem.
> > FEL is handled correctly in my series.
>
> So FEL is OK afterall, good.
>
> > For bootmgr, there are two patches in my series so you can choose
> > which one you want.
>
> And the answer there was neither, both are wrong. We instead finally hit
> a more fundamental problem. Which you don't want to solve. And Heinrich
> has said he'll post RFC on, but hasn't had time.

Or you could just make a decision.

>
> > > > Does it just need a rebase?
> > >
> > > Not just a rebase.
> > >
> > > > Which patches should be included and which not?
> > >
> > > Once the efi boot manager part is fixed, just the parts required for it?
> >
> > So just take the patch which disables bootmgr from sunxi?
>
> Who was in favour of that idea again?

Andre seemed OK with it as no one uses it at present and it allows us
to make progress.

https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-4-sjg@chromium.org/#3418689

>
> > > > Also we
> > > > normally expect patches sent first to have priority.
> > >
> > > No we don't. There might be some general advice / rules of thumb but
> > > it's far from some sort of absolute rule. Things are merged when they
> > > work and are correct.
> >
> > Well I was a bit put out seeing the series rejected on v3 due to an
> > out-of-tree thing I wasn't aware of.
>
> Yes, you need to figure out how to get a better handle on your emails
> since you shouldn't have been unaware then.

Yes I've scaled back my reviews significantly and that is giving me more time.

>
> > > > Here you have
> > > > apparently applied your BLK stuff and then want me to rework on top of
> > > > it?
> > >
> > > Yes, I applied the "handle BLK correctly" part that I tried to explain
> > > to you how to fix a few times, and you either didn't understand or
> > > didn't care. I'm leaning more towards "didn't care" now and thought we
> > > should break things a little bit first and fix them later.
> > >
> > > > I agreed to the bootmanager work-around but I'm certainly not going to
> > > > write it. I would rather make bootmgr more iterative, if that is
> > > > possible.
> > >
> > > Then more bootstd migrations are likely blocked until it can handle efi
> > > boot manager correctly, which you don't want to do.
> >
> > The correct way to handle bootmgr is (probably?) to have it use
> > bootstd to scan for stuff. But as you know, I can't get patches into
> > the EFI subsystem, so it's moot.
>
> Since you insist on starting with several "tidy up" series that have
> been rejected before starting on the problem at hand, yes, that's true.

Yes, I am aware it is true.

>
> > > > > Which is why I had spent so much time trying to get
> > > > > you to migrate more SoCs to bootstd because it's your feature.
> > > >
> > > > So take the sunxi patches and then I'll do the next one? On the one
> > > > hand you complain that there are too many balls in the air and on the
> > > > other you stop the balls from landing. It just doesn't 'compute' for
> > > > me, sorry.
> > >
> > > Yes, I'm sorry you're having trouble following my requests. Again, I
> > > wanted more bootstd migration not for its own sake, but to expose
> > > problems with the framework and for you to then fix those problems.
> >
> > There is no problem with the framework. Please just follow my notes
> > above and apply the patches. Specifically these ones:
>
> That it doesn't work nicely with EFI boot manager IS a problem with the
> framework.

It's a problem with bootmgr, which I'm not going to take on, since I
am unable to get patches into EFI_LOADER.

>
> > 733876246aa sunxi: Add a bootmeth for FEL
> > ab5fbb4f7c0 efi_loader: bootstd: Drop bootmgr for sunxi
> > (leave this one out for now) 9f4ed60d90c RFC: Revert "bootstd: Make
> > efi_mgr bootmeth work for non-sandbox setups"
> > 90d88509ebd sunxi: Move to bootstd
> > e0a16425620 sunxi: Drop old distro boot variables
> > da69a979ec7 env: Provide a work-around for unquoting fdtfile
> > 7c37601d6be (dm/std-working, dm-public/std-working) sunxi: Move to
> > text environment
> >
> > I'm tired of hearing that there is something wrong with bootstd here,
> > so please stop saying that.
>
> Well, from my point of view there is a problem. Because your "tidy up"
> isn't working with what mainstream OS distributions want. So it's not a
> 1:1 replacement for what we have today that does work.

Which tidy-up?

>
> > > > > So yes, I think things would be in a better place if we tried to get
> > > > > *less* big things done at once and didn't pick up another big thing
> > > > > until the last was really done.
> > > >
> > > > You should address my point above. Are you trying to limit me to 3-4
> > > > large series a year?
> > >
> > > You personally? No. The whole project? Yes, one big feature that's
> > > complete and works every 3 months for a project with limited resources
> > > sounds amazing. U-Boot isn't a toy personal project, it's something used
> > > in production on real devices and needs to move at a sustainable pace
> > > with minimal regressions.
> >
> > I believe that is getting better with the increased focus on testing,
> > something which I have been pushing for years.
>
> I'm referring to the breadth of testing, not the depth of testing. More
> tests are good. More boards being tested is more important. Your lab is
> good, yes, but it's not like HW vendors haven't been testing already and
> for a long time. And your feedback on their feedback (needing to be able
> to use a they-push-out model) wasn't positive.

Are you saying that you want me to implement a framework to access
test results from HW vendors and that until I do that, you consider
that I am holding testing back?? Anyway, don't such frameworks already
exist?

Again, back to this thread, if you want me to migrate things, consider
applying the sunxi patches as I have described above. I will then look
at the next target for bootstd. But while you hold this up, I cannot
move forward with more bootstd migration. It doesn't seem that much to
ask.

- Simon
