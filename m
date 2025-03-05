Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F31DC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30B1980F56;
	Wed,  5 Mar 2025 15:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="atLioXVx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7D62810DC; Wed,  5 Mar 2025 15:18:55 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF91A808B6
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:18:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abec8b750ebso1184465166b.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741184332; x=1741789132; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KcCEdBuPVsAu/2A43A7dsHdGpuEhEDEUufd01DK2fGw=;
 b=atLioXVxl62gwVSzGr03Fg0VCZpXR6HARHvYnRhDpm7k0fms9sd4Un474na/XjX5VP
 idloKMDSljnwxFvbEuowH629FsTxZIQIjAmA1NcpJOW/Ar1oMjeMUhoN/2VAdtnb+9iZ
 UNZnnLlxC1pGoIoUB9OAqljmCwntSOhc2ifRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741184332; x=1741789132;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KcCEdBuPVsAu/2A43A7dsHdGpuEhEDEUufd01DK2fGw=;
 b=UNZ046rBkHUVpYltHoprXEwdZ4ezUs1QQnqkehiefnC3dKrP5cnpgehlAGLd5I09E4
 dTSRsS2j4UBR96eir+LSjmAOfHXt/o3zxTuM6/UWtoJIn4Kw1FpKwA0N3AXJNpZwqQ+X
 SwPXBQZMHFIFghyK11RHWnA0Ax96TxDs+q5jEugX5mCwc94f5oYb0cH/Ab0E3VUUh13S
 UXHRzD4QKetvfzaMo1JSWLNyUtAPw6LJTWAngcZH88Y13eXnAibmWQ8tJHYO1bufkKM5
 XfD82M/6PHSPGg4L69/CUgsaqyWVCq8HLZy4shXMdJB6oObWQTF/n/p6jo+hEa9y4h2y
 Ie+g==
X-Gm-Message-State: AOJu0YxGH4AM1TOqaEcGB/dKAS9MAtuk40ASH9FMK8oj+riqzt8gGLHu
 YJ3NBY1wyu0TGekVvawRXXXVaPL79Zu0URofcYTpZemVKkhUqpvVHB1cl4uOHZUpk5Fm5g4AQX9
 +lZqcj8tNUdU0bclB7TxGnJ+4KWWQCrAqBUInwZZMnAAxpn0=
X-Gm-Gg: ASbGncswC/uZlJWOqcnGPyb7VidxiQV9uF2D0oV7H7f5GBfKJdstdDWPMKRqRiV+35b
 QXsoSyc9uz/Mk8x2LT/jx0NGCy1PWWyqBLzaHrIrncTiYoY7Is8OxV0ZHDxWwwalTyj7kYKPi5M
 LlnpiXrQ1LYENjLIT1xUL+7cXvLCw=
X-Google-Smtp-Source: AGHT+IHLoGlaX9hS018kArRj+SvzB1djEBRlWihDRxqvIZYXNmRecehXqjyTYPzwGV50+yP3JZ8ajyM36YSZmojq++M=
X-Received: by 2002:a17:906:f5a9:b0:abf:4550:9764 with SMTP id
 a640c23a62f3a-ac20db11abemr289778166b.24.1741184332148; Wed, 05 Mar 2025
 06:18:52 -0800 (PST)
MIME-Version: 1.0
References: <20250217141409.GJ1233568@bill-the-cat>
 <CAFLszTij+suCqQ+c0bmTEsHEu6+xUWWCMEG-gJ5DYbjhv0oJGg@mail.gmail.com>
 <20250222000819.GX1233568@bill-the-cat>
 <CAFLszThLjxyMPty=tvrE9nQMNOtcF1H-njBb0Tep_ccXee3waw@mail.gmail.com>
 <20250222213748.GB1233568@bill-the-cat>
 <CAFLszTj31qtx5TmOVLJAfhpzWHKTc9kcp22JTgJBe2bePSU60A@mail.gmail.com>
 <20250224231455.GI1233568@bill-the-cat>
 <CAFLszTiP+wPijf0QbTL0i9Ywk_0tWFwYP-1S1Lp+mFeqN=8zKg@mail.gmail.com>
 <20250227170352.GZ2640854@bill-the-cat>
 <CAFLszTgDms-RC+Qg=FLxtW253jh22eUb1Y-5OyB2U42EygdZWw@mail.gmail.com>
 <20250304161218.GA2640854@bill-the-cat>
In-Reply-To: <20250304161218.GA2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Mar 2025 07:18:40 -0700
X-Gm-Features: AQ5f1JpFvLE4lXRbKHLkNddd7vWA87Umr2GL8gNfaExGtoUpTAYF93cNDA9Vj9w
Message-ID: <CAFLszTj1hc7esvd_R3oVEqOpSBNFcRga0wmR3hnTsFELXi+m1g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 4 Mar 2025 at 09:12, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Mar 04, 2025 at 08:35:56AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 27 Feb 2025 at 10:03, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Feb 27, 2025 at 09:26:10AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 24 Feb 2025 at 16:14, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Feb 22, 2025 at 05:24:05PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Sat, 22 Feb 2025 at 14:37, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Sat, Feb 22, 2025 at 10:23:59AM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Fri, 21 Feb 2025 at 17:08, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Feb 21, 2025 at 04:42:09PM -0700, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Mon, 17 Feb 2025 at 07:14, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Mon, Feb 17, 2025 at 06:14:06AM -0700, Simon Glass wrote:
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > On Sun, 16 Feb 2025 at 14:52, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Sun, Feb 16, 2025 at 12:39:34PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Sun, 16 Feb 2025 at 09:07, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Sun, Feb 16, 2025 at 07:10:12AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Sat, 15 Feb 2025 at 11:12, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Sat, Feb 15, 2025 at 10:21:16AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Sat, 15 Feb 2025 at 07:41, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Sat, Feb 15, 2025 at 04:59:40AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Mon, 10 Feb 2025 at 09:25, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > On Thu, Feb 06, 2025 at 03:38:55PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > This is a global default, so put it under 'default' like the tags.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > > > > > > > > > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > > > > > > > > > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Please make v4 include the way you redid the second patch and be on top
> > > > > > > > > > > > > > > > > > > > > of mainline, thanks.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > That's enough versions for me, so I'll let you do that, if you'd like.
> > > > > > > > > > > > > > > > > > > > It probably doesn't affect your tree as not as much is done in
> > > > > > > > > > > > > > > > > > > > parallel.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > I am disappointed.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I'm sorry to disappoint you.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > The background is that I looked at the difference between our trees
> > > > > > > > > > > > > > > > > > and the gitlab files are quite different. My CI runs take about 35
> > > > > > > > > > > > > > > > > > mins and it seems that yours is around 90 mins. I would like to reduce
> > > > > > > > > > > > > > > > > > / remove the delta (for time and patch diff), but I'm not sure how.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > My goal is to get CI runs to below 20 minutes, best case.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > I'm sure CI could be quicker still with a number of faster runners. But
> > > > > > > > > > > > > > > > > if you can't be bothered to make changes against mainline, what is the
> > > > > > > > > > > > > > > > > point?
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > If you recall, I was working with your tree and had various ideas to
> > > > > > > > > > > > > > > > speed things up, but you didn't like it. So I've had to do it in my
> > > > > > > > > > > > > > > > tree. This is not about more runners (although I might have another
> > > > > > > > > > > > > > > > one soon). It is about running jobs in parallel.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > And I wasn't sure more runners in parallel would help (as it would slow
> > > > > > > > > > > > > > > down the fast runner which is what keeps the long jobs from being even
> > > > > > > > > > > > > > > longer) as much as adding more regular runners would (which we've done)
> > > > > > > > > > > > > > > and noted that in the end it's a configuration on the runner side so to
> > > > > > > > > > > > > > > go ahead. And I reviewed and ack'd the patches here which exposed the
> > > > > > > > > > > > > > > issues your path revealed. I just can't apply them because they need to
> > > > > > > > > > > > > > > be rebased (and squashed).
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > You have already added tags for things, but (IIUC) they are around the
> > > > > > > > > > > > > > other way from what I have added.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I have a tag called 'single' which means that the machine is only
> > > > > > > > > > > > > > allowed to one of those jobs. The world-build jobs are marked with
> > > > > > > > > > > > > > 'single'.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > For other jobs, I allow the runners to pick up some in parallel
> > > > > > > > > > > > > > depending on their performance (for moa and tui that is 10).
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > So at most, there is a 'world build' and 10 test.py jobs running on
> > > > > > > > > > > > > > the same machine. It seems to work fine in practice, although I would
> > > > > > > > > > > > > > rather be able to make these two types of jobs mutually exclusive, so
> > > > > > > > > > > > > > that a runner is either running 10 parallel jobs or 1 'single' job,
> > > > > > > > > > > > > > but not both. I'm not sure how to do that.
> > > > > > > > > > > > >
> > > > > > > > > > > > > So unless I'm missing something, in both cases the bottleneck is that
> > > > > > > > > > > > > for world build jobs you don't want anything else going on with the
> > > > > > > > > > > > > underlying build host. You could register 10 "all" runners and 1 "fast
> > > > > > > > > > > > > amd64" runner (and something similar but smaller for alexandra). If you
> > > > > > > > > > > > > update the registrations on source.denx.de can you then shut down your
> > > > > > > > > > > > > gitlab instance?
> > > > > > > > > > > >
> > > > > > > > > > > > I've put a tag of 'single' on things that should run on the single-job
> > > > > > > > > > > > runner. Everything else can run concurrently, e.g. up to 10 jobs. So I
> > > > > > > > > > > > have two runners on the same host. E.g. tui-single has 'limit = 1',
> > > > > > > > > > > > but 'tui' has no limit and is just governed by the 'concurrent = 10'
> > > > > > > > > > > > at the top of the file.
> > > > > > > > > > >
> > > > > > > > > > > Yes. And you could move those runners to the mainline gitlab. There is
> > > > > > > > > > > no "single" tag, that would be the "all" tag. And "tui-single" would be
> > > > > > > > > > > "fast amd64".
> > > > > > > > > >
> > > > > > > > > > They are still attached to the Denx gitlab. Nothing has changed on my
> > > > > > > > > > side. I'm not sure that your new tags are working though. I have a
> > > > > > > > > > feeling something broke along the way when you made all your tag
> > > > > > > > > > changes. One of my servers makes a bit of noise and I haven't heard it
> > > > > > > > > > in quite a while.
> > > > > > > > >
> > > > > > > > > There's a few of your runners that are "stale" and haven't contacted
> > > > > > > > > gitlab in a long time. I'll double check the tags tho.
> > > > > > > > >
> > > > > > > > > > If Denx would like to give me access to their gitlab instances, I'd be
> > > > > > > > > > happy to play around and figure out how to get it going as fast as my
> > > > > > > > > > tree does, and send a patch.
> > > > > > > > >
> > > > > > > > > I'm not sure what you mean by that? The instance itself?
> > > > > > > >
> > > > > > > > Yes. I can fiddle with tags on my runners and try to figure it out.
> > > > > > >
> > > > > > > I'm not sure what you're getting at here. If you mean "tags" in
> > > > > > > /etc/gitlab-runner/config.toml those aren't relevant here I believe.
> > > > > >
> > > > > > No, I mean the tags in CI. If I fiddle with them I can probably come
> > > > > > up with a way to run your CI much faster. Mine is about 35mins.
> > > > >
> > > > > I'm not so sure about that. Yours runs faster because it tests less. Now
> > > > > that we've got some of your other fast runners showing up again, this is
> > > > > more instructive of current times I think:
> > > > > https://source.denx.de/u-boot/u-boot/-/pipelines/24802
> > > >
> > > > But not this? :
> > >
> > > You forgot a link. But presumably to some run yesterday which took
> > > longer. And because Ilias was tweaking the currently donated arm64
> > > runners (that have other jobs to run) and also we had two or three
> > > custodians at a time preparing trees, things ran slower.
> >
> > Maybe, but I don't think so.
>
> No need to "think" about it. You can look at the pipeline history and
> see what was in queue for how long. And since I needed to be keeping an
> eye on two of the 3 arm64 runners, I could see when custodians were
> firing off tests. Aside from the number of pull requests I had waiting
> that morning.

Your runs are reliably around an hour but mine are reliably just over
30 minutes. I only have three runners.

https://source.denx.de/u-boot/u-boot/-/pipelines
https://sjg.u-boot.org/u-boot/u-boot/-/pipelines

I know you have added a duplicate build on arm64, but I can still
speed it up significantly if you'll allow me.

>
> > > > > If you want to make mainline CI run faster you will need to catch up
> > > > > with the missing coverage or argue that some things are redundant.
> > > >
> > > > Or perhaps I can actually just make it faster without dropping coverage?
> > >
> > > I mean, I don't know how that's physically possible, outside of adding
> > > many more expensive build hosts. We have two-three fast arm64 hosts and
> > > that world builds between 30-45 minutes. That's the biggest time
> > > bottleneck.
> >
> > Why did you join those builds up? It is better for throughput to have
> > a few runners working in parallel.
>
> Because I'm not optimizing for the single developer running CI case (or
> the loads of fast runners case). If we had sufficient resources, yes,
> the fastest possible way would be 4 "fast arm64" servers and 4 "fast
> amd64" servers each running if not 25% of the world build, at least 4
> easy to make and maintain groupings.
>
> However, we don't have that many of either. And they also need to be
> used for the biggest sandbox test suite jobs so that they run in about 5
> minutes, not about 10 minutes. So in order to not entirely block other
> custodians we do a single world build. Because make and buildman are
> very good about otherwise fully loading the server. Running anything
> else while that is going on will slow down the world build (and, the
> other job too).

They're OK (on a fast machine) so long as the 'other' load is not too much.

>
> Aside, maintaining groupings is a pain. It was very bad with Travis, and
> it's only moderately painful with Azure where at least the end goal is
> 10 pipelines for maximum concurrency. And with Azure everyone *can* get
> their own "project" or whatever the right term is, and utilize 10
> runners at once.

Yes, but we can update buildman to handle grouping automatically, as I
suggested once.

>
>
> > > The next biggest is that unless sandbox tests are run on a fast host,
> > > they take upwards of 10 minutes, rather than 5.
> >
> > Yes, they are just getting slower and slower.
>
> Adding more tests takes more time. But the real question is which tests
> take wall clock noticeable time, and why, and if we can do anything
> about it. My gut feeling is that it's in the disk image related tests
> and the user space verification of them.
>
> > > But please, rebase your work to next and see what you can do. There is
> > > likely some speed-ups possible if we allow for failures to take longer
> > > to happen (and don't gate world builds on all of test.py stage
> > > completing, just say sandbox). And if you do the work on source.denx.de
> > > (as there is *NOTHING* stopping you from registering more runners to
> > > your tree and using whatever tagging scheme you like) you might even see
> > > more of the time variability due to load from other custodians.
> >
> > I can't edit the tags on the runners, nor can I adjust them to run
> > untagged jobs, nor can I delete runners I don't want, so no, I believe
> > I need access to do that.
>
> You can do all of that with runners specific to u-boot-dm, and you can
> disable project / group runners yourself too. So yes, you can.

Nope, sorry, I wasn't able to do any of this with the Denx tree as I
can't adjust tags and can't delete and recreate runners.

>
> > > > > > > > > > I also have another runner to add.
> > > > > > > > >
> > > > > > > > > I'll contact you off-list with the token.
> > > > > > > > >
> > > > > > > > > > > > From my side, I have found it helpful and refreshing to have a gitlab
> > > > > > > > > > > > instance which I can control, e.g. it runs in half the time and if my
> > > > > > > > > > > > patches are completely blocked by Linaro, etc., I have an escape
> > > > > > > > > > > > valve.
> > > > > > > > > > >
> > > > > > > > > > > Yes, and I have no idea what any of that has to do with anything other
> > > > > > > > > > > than leading to confusion about what tree is or is not mainline. Since
> > > > > > > > > > > you own u-boot.org and ci.u-boot.org is your gitlab and
> > > > > > > > > > > https://ci.u-boot.org/u-boot/u-boot/ is your personal tree.
> > > > > > > > > >
> > > > > > > > > > For now I am working with my tree, so that I am not blocked by Linaro,
> > > > > > > > > > etc. but as you have seen I can rebase series for your tree as needed.
> > > > > > > > >
> > > > > > > > > And you're not addressing my point about using the project domain for
> > > > > > > > > your personal tree. That's my big huge "are you forking the project or
> > > > > > > > > what" problem.
> > > > > > > >
> > > > > > > > I'm just making sure that my work is not blocked or lost, as that has
> > > > > > > > happened too many times in the past few years.
> > > > > > >
> > > > > > > Again, are you intending to fork the project? Putting your personal tree
> > > > > > > in as "https://ci.u-boot.org/u-boot/u-boot.git" is not OK. I keep asking
> > > > > > > you to stop it.
> > > > > >
> > > > > > No, I'm not intending to fork anything. But I need a tree that I can
> > > > > > control and push things into.
> > > > >
> > > > > I don't know how you can call your personal tree being at
> > > > > "https://ci.u-boot.org/u-boot/u-boot.git" and saying it's somewhere you
> > > > > control and can push to while not also saying it's a fork. If you want
> > > > > to close down your gitlab and CNAME ci.u-boot.org to source.denx.de, you
> > > > > can still push things to u-boot-dm. Or if that's too constrained of a
> > > > > namespace you can also get a contributors/sjg/ namespace. But what
> > > > > you're doing today WILL lead to confusion.
> > > >
> > > > I believe I've answered this question before. It is simply that I
> > > > cannot get certain patches (bloblist, EFI, devicetree) into your tree.
> > > > There really isn't any other reason.
> > >
> > > Yes, that's still not an answer to my question.
> > >
> > > Or is the answer to my question "Yes, I'm trying to confuse people to
> > > thinking my tree is mainline."
> >
> > No, it's simply that you are not taking some patches in your tree and
> > complaining about the amount of patches.
>
> That's misleading at best. I'm not taking the patches that other
> custodians have repeatedly rejected and explained why they're rejecting
> them.

Yes and this has affected my ability to move things forward so much
that I've had to set up my own tree. It has been working very well, to
have a relief valve.

>
> > > > At the moment your CI seems to be flaky as well:
> > > >
> > > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/jobs/1038174
> > >
> > > [aside, I think you meant to link to the pipeline itself, which also
> > > passed, but had some retries]
> > >
> > > Funny story. Ilias needed to tweak the fast arm64 hosts and also wanted
> > > to explore "What if we have concurrency higher?" and ran in to the
> > > problems you also ran in to with respect to git seeing an existing clone
> > > in progress and bailing. Followed by the problem of multiple non-trivial
> > > jobs running concurrently.
> > >
> > > All of which is why I keep trying to tell you that while "single" and
> > > concurrent runners work fine for you on a single user instance it will
> > > not scale.
> >
> > Yes, but I solved that with the patch I sent and it seems to be 100%
> > reliable now.
>
> Yes, you eventually solved it with 3 patches, which I asked you to
> rebase and squash to two patches (because #3 just fixes that #2 wasn't
> sufficient) and you declined.

In general, why not just be more open to my ideas, even just try it
for a year? Given the tools I'm confident I can speed up your CI as
well.

Regards,
Simon
