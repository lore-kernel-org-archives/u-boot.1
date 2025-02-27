Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41183C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59F3281276;
	Thu, 27 Feb 2025 17:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KG8wiGH0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB32281276; Thu, 27 Feb 2025 17:26:30 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 943D68141E
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220f4dd756eso25584715ad.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740673585; x=1741278385; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HXY/cwjd+v6lBXGqiA8K/8y2gr7UJ/vrqQ5w9kqkiUg=;
 b=KG8wiGH0Ch+eDPC0+/PjLOhr/0tIOKVBE64aB0tn8c9nyibwo5YCEqpUV242pDZqW3
 aV1D+d3nbNDnxNkWgd5Zv5yK2N3UlLXVtl9cRdBAuthJ0FYXLN9nqGjViE3DJnR/KocK
 D79jXhyStT9hsIrs0kyELm4jW0emXr2xP1oyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673585; x=1741278385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HXY/cwjd+v6lBXGqiA8K/8y2gr7UJ/vrqQ5w9kqkiUg=;
 b=E84Eo4CkrJmdynShuTZKuxwDsn65cpmqafqm0Fi58bRrIGpKGbwzlu/tG9tyylJ0kf
 8KGTzdT1g3HUCzkRLmGxZxARMj//RkgkEnar8Cy+sTBaNdZtxG3aOPABSbbAgcKMK6x5
 WwsTqpNvg9aoE24DwGExZ7L0m1nluC5LKG1wwjfjPcoqTf5gzfKJdcwO/wh7L1/zj/fG
 bMiW1yBoYiBs3GEX0lU3doBeZAkiRQYK7KN/Or3gUqaHiWY1I3nrWV6PO3Y7KyX5q3Oa
 sFOd5Lwca7jyUPe9JtFN9PswFGZgPuzAC1uH02ThU76GMlribEnR4LCPb5C8AddbnqzX
 fcpg==
X-Gm-Message-State: AOJu0YwNOYgERDub7dkknouydAl267oZnyaXYZLIPjipNhCwsn2hnWdj
 ARWdNXASRQT/hIsqgltfDtVFnurOMmIyj/m8s4Ft6OYxODrPrFFNkg0c3xenjAAAPVPaFnlkMNH
 jgw3c2ko037/lvWeiZbM8pzFVhs1ZydE4dtA8XC/8eKZOfgA=
X-Gm-Gg: ASbGncssDPnih/H3v+jV8mv7pqWsxHdac6/zlCAPWJ0mkWAx9maz9urgAIpwWRVSFIP
 ueNbD56VEZIgN3Cm6a9LjxtNtc7SN5V3rNNNj6G/r0A1hKE1p4MFTLiROBC1EfebTRaOLgBZ3/p
 F5CW+RcsAt
X-Google-Smtp-Source: AGHT+IGiJfREhSqqEaZWI4sis2QZ1pNRq+zx473PYV66Ixi+u1Qt0KL6N8RnuRL9cwNlfyolFvhDjuw59YMC/JvFXHY=
X-Received: by 2002:a17:90b:380a:b0:2f9:d9fe:e72e with SMTP id
 98e67ed59e1d1-2fe68ae2863mr21211462a91.16.1740673583661; Thu, 27 Feb 2025
 08:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20250216160744.GA1233568@bill-the-cat>
 <CAFLszTiihyuqFBcdacu+2wfd3ivDzjf4nVqfU0BgKUc0u1s6=Q@mail.gmail.com>
 <20250216215230.GE1233568@bill-the-cat>
 <CAFLszTiydBJ8BseNHNJO+tf21QwPSJ-Od1Jnp6QWUTsPOmgFdg@mail.gmail.com>
 <20250217141409.GJ1233568@bill-the-cat>
 <CAFLszTij+suCqQ+c0bmTEsHEu6+xUWWCMEG-gJ5DYbjhv0oJGg@mail.gmail.com>
 <20250222000819.GX1233568@bill-the-cat>
 <CAFLszThLjxyMPty=tvrE9nQMNOtcF1H-njBb0Tep_ccXee3waw@mail.gmail.com>
 <20250222213748.GB1233568@bill-the-cat>
 <CAFLszTj31qtx5TmOVLJAfhpzWHKTc9kcp22JTgJBe2bePSU60A@mail.gmail.com>
 <20250224231455.GI1233568@bill-the-cat>
In-Reply-To: <20250224231455.GI1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Feb 2025 09:26:10 -0700
X-Gm-Features: AQ5f1JphIoL3z-R1EZTibsblZZUwFTtmSo6FWNRjx644hcJH_Wt7ZcftqypLO3w
Message-ID: <CAFLszTiP+wPijf0QbTL0i9Ywk_0tWFwYP-1S1Lp+mFeqN=8zKg@mail.gmail.com>
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

On Mon, 24 Feb 2025 at 16:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Feb 22, 2025 at 05:24:05PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 22 Feb 2025 at 14:37, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Feb 22, 2025 at 10:23:59AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 21 Feb 2025 at 17:08, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Feb 21, 2025 at 04:42:09PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 17 Feb 2025 at 07:14, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Mon, Feb 17, 2025 at 06:14:06AM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Sun, 16 Feb 2025 at 14:52, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Sun, Feb 16, 2025 at 12:39:34PM -0700, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Sun, 16 Feb 2025 at 09:07, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Sun, Feb 16, 2025 at 07:10:12AM -0700, Simon Glass wrote:
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > On Sat, 15 Feb 2025 at 11:12, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Sat, Feb 15, 2025 at 10:21:16AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Sat, 15 Feb 2025 at 07:41, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Sat, Feb 15, 2025 at 04:59:40AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Mon, 10 Feb 2025 at 09:25, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Thu, Feb 06, 2025 at 03:38:55PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > This is a global default, so put it under 'default' like the tags.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > > > > > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > > > > > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Please make v4 include the way you redid the second patch and be on top
> > > > > > > > > > > > > > > > > of mainline, thanks.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > That's enough versions for me, so I'll let you do that, if you'd like.
> > > > > > > > > > > > > > > > It probably doesn't affect your tree as not as much is done in
> > > > > > > > > > > > > > > > parallel.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I am disappointed.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I'm sorry to disappoint you.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > The background is that I looked at the difference between our trees
> > > > > > > > > > > > > > and the gitlab files are quite different. My CI runs take about 35
> > > > > > > > > > > > > > mins and it seems that yours is around 90 mins. I would like to reduce
> > > > > > > > > > > > > > / remove the delta (for time and patch diff), but I'm not sure how.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > My goal is to get CI runs to below 20 minutes, best case.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'm sure CI could be quicker still with a number of faster runners. But
> > > > > > > > > > > > > if you can't be bothered to make changes against mainline, what is the
> > > > > > > > > > > > > point?
> > > > > > > > > > > >
> > > > > > > > > > > > If you recall, I was working with your tree and had various ideas to
> > > > > > > > > > > > speed things up, but you didn't like it. So I've had to do it in my
> > > > > > > > > > > > tree. This is not about more runners (although I might have another
> > > > > > > > > > > > one soon). It is about running jobs in parallel.
> > > > > > > > > > >
> > > > > > > > > > > And I wasn't sure more runners in parallel would help (as it would slow
> > > > > > > > > > > down the fast runner which is what keeps the long jobs from being even
> > > > > > > > > > > longer) as much as adding more regular runners would (which we've done)
> > > > > > > > > > > and noted that in the end it's a configuration on the runner side so to
> > > > > > > > > > > go ahead. And I reviewed and ack'd the patches here which exposed the
> > > > > > > > > > > issues your path revealed. I just can't apply them because they need to
> > > > > > > > > > > be rebased (and squashed).
> > > > > > > > > >
> > > > > > > > > > You have already added tags for things, but (IIUC) they are around the
> > > > > > > > > > other way from what I have added.
> > > > > > > > > >
> > > > > > > > > > I have a tag called 'single' which means that the machine is only
> > > > > > > > > > allowed to one of those jobs. The world-build jobs are marked with
> > > > > > > > > > 'single'.
> > > > > > > > > >
> > > > > > > > > > For other jobs, I allow the runners to pick up some in parallel
> > > > > > > > > > depending on their performance (for moa and tui that is 10).
> > > > > > > > > >
> > > > > > > > > > So at most, there is a 'world build' and 10 test.py jobs running on
> > > > > > > > > > the same machine. It seems to work fine in practice, although I would
> > > > > > > > > > rather be able to make these two types of jobs mutually exclusive, so
> > > > > > > > > > that a runner is either running 10 parallel jobs or 1 'single' job,
> > > > > > > > > > but not both. I'm not sure how to do that.
> > > > > > > > >
> > > > > > > > > So unless I'm missing something, in both cases the bottleneck is that
> > > > > > > > > for world build jobs you don't want anything else going on with the
> > > > > > > > > underlying build host. You could register 10 "all" runners and 1 "fast
> > > > > > > > > amd64" runner (and something similar but smaller for alexandra). If you
> > > > > > > > > update the registrations on source.denx.de can you then shut down your
> > > > > > > > > gitlab instance?
> > > > > > > >
> > > > > > > > I've put a tag of 'single' on things that should run on the single-job
> > > > > > > > runner. Everything else can run concurrently, e.g. up to 10 jobs. So I
> > > > > > > > have two runners on the same host. E.g. tui-single has 'limit = 1',
> > > > > > > > but 'tui' has no limit and is just governed by the 'concurrent = 10'
> > > > > > > > at the top of the file.
> > > > > > >
> > > > > > > Yes. And you could move those runners to the mainline gitlab. There is
> > > > > > > no "single" tag, that would be the "all" tag. And "tui-single" would be
> > > > > > > "fast amd64".
> > > > > >
> > > > > > They are still attached to the Denx gitlab. Nothing has changed on my
> > > > > > side. I'm not sure that your new tags are working though. I have a
> > > > > > feeling something broke along the way when you made all your tag
> > > > > > changes. One of my servers makes a bit of noise and I haven't heard it
> > > > > > in quite a while.
> > > > >
> > > > > There's a few of your runners that are "stale" and haven't contacted
> > > > > gitlab in a long time. I'll double check the tags tho.
> > > > >
> > > > > > If Denx would like to give me access to their gitlab instances, I'd be
> > > > > > happy to play around and figure out how to get it going as fast as my
> > > > > > tree does, and send a patch.
> > > > >
> > > > > I'm not sure what you mean by that? The instance itself?
> > > >
> > > > Yes. I can fiddle with tags on my runners and try to figure it out.
> > >
> > > I'm not sure what you're getting at here. If you mean "tags" in
> > > /etc/gitlab-runner/config.toml those aren't relevant here I believe.
> >
> > No, I mean the tags in CI. If I fiddle with them I can probably come
> > up with a way to run your CI much faster. Mine is about 35mins.
>
> I'm not so sure about that. Yours runs faster because it tests less. Now
> that we've got some of your other fast runners showing up again, this is
> more instructive of current times I think:
> https://source.denx.de/u-boot/u-boot/-/pipelines/24802

But not this? :

>
> If you want to make mainline CI run faster you will need to catch up
> with the missing coverage or argue that some things are redundant.

Or perhaps I can actually just make it faster without dropping coverage?

>
> > > > > > I also have another runner to add.
> > > > >
> > > > > I'll contact you off-list with the token.
> > > > >
> > > > > > > > From my side, I have found it helpful and refreshing to have a gitlab
> > > > > > > > instance which I can control, e.g. it runs in half the time and if my
> > > > > > > > patches are completely blocked by Linaro, etc., I have an escape
> > > > > > > > valve.
> > > > > > >
> > > > > > > Yes, and I have no idea what any of that has to do with anything other
> > > > > > > than leading to confusion about what tree is or is not mainline. Since
> > > > > > > you own u-boot.org and ci.u-boot.org is your gitlab and
> > > > > > > https://ci.u-boot.org/u-boot/u-boot/ is your personal tree.
> > > > > >
> > > > > > For now I am working with my tree, so that I am not blocked by Linaro,
> > > > > > etc. but as you have seen I can rebase series for your tree as needed.
> > > > >
> > > > > And you're not addressing my point about using the project domain for
> > > > > your personal tree. That's my big huge "are you forking the project or
> > > > > what" problem.
> > > >
> > > > I'm just making sure that my work is not blocked or lost, as that has
> > > > happened too many times in the past few years.
> > >
> > > Again, are you intending to fork the project? Putting your personal tree
> > > in as "https://ci.u-boot.org/u-boot/u-boot.git" is not OK. I keep asking
> > > you to stop it.
> >
> > No, I'm not intending to fork anything. But I need a tree that I can
> > control and push things into.
>
> I don't know how you can call your personal tree being at
> "https://ci.u-boot.org/u-boot/u-boot.git" and saying it's somewhere you
> control and can push to while not also saying it's a fork. If you want
> to close down your gitlab and CNAME ci.u-boot.org to source.denx.de, you
> can still push things to u-boot-dm. Or if that's too constrained of a
> namespace you can also get a contributors/sjg/ namespace. But what
> you're doing today WILL lead to confusion.

I believe I've answered this question before. It is simply that I
cannot get certain patches (bloblist, EFI, devicetree) into your tree.
There really isn't any other reason.

At the moment your CI seems to be flaky as well:

https://source.denx.de/u-boot/custodians/u-boot-dm/-/jobs/1038174

>
> > > > BTW weka is too slow so I took it off.
> > >
> > > I'll remove it.
> > >
> > > > tui is running but seems to be renamed 'tui-redux' now. I don't see it
> > > > getting jobs though.
> > >
> > > It's been getting jobs. Is it something sufficiently fast that it should
> > > be doing big jobs?
> >
> > Yes, tui is the same as moa, pretty fast.
>
> Thanks, I've added the "fast amd64" tag then so it'll get the long
> running jobs too.

OK good.

Regards,
Simon
