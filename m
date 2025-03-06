Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D947C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D15F1810DC;
	Thu,  6 Mar 2025 17:14:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d5eZAR4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74B31810DC; Thu,  6 Mar 2025 17:14:11 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E9A481420
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:14:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-abf6f3b836aso132682666b.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277645; x=1741882445; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JyTLLCoCJRvl8OdkWaXQ3q9t15C87PHcQXxOWqaZE8c=;
 b=d5eZAR4rmT9fh17DOXnBvKAT3F5t5W6rl5qL2DzN1IeDVec2Kbst+UGHMKu9p1Zqo7
 CtW0U94qgpXsOhfeYn0qXQWhf8AAPOZSb/EtkqpWk7WDPrXUxdfqKd7HT1nXVN1YuWp6
 VAjpWweYr+mrGoSqvHKcnV8ksUXx5yZafMOJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277645; x=1741882445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JyTLLCoCJRvl8OdkWaXQ3q9t15C87PHcQXxOWqaZE8c=;
 b=rVcHhsiN0fbygYzjusq9O+PV3DEHULw2VvkyBnfnGVgXQZ97XLIXHpDI3TUj+mA1eg
 oQdDswUN/6xjhJZ4W33LynP8c77WfznNNb2gA7Af+rhAKqfsR4uivfEDK+6LNBCX1y1I
 TE72mL1p0ifrcwKubsTXblxb1m1OpYBb52O85X58aeiKBwFEulQeaPQbDU7dKHj56rBk
 DpOBzYILPhPNocRpa5eNzgRdU1yJfRQd6gY4lQuVi2WrObxB7UndkYBujOWUkGimJHBz
 9VM2t6aPRlUK+8Q8A/zrLzNj9M+waRNOtzk9u9gVswzR7fKkfHotOnp3uOSjUFCXROx9
 RD7Q==
X-Gm-Message-State: AOJu0YyGdGi7HqPg3/ooepPYB2tpW55vOz0qNRcZ8zJPy1DkFTcU09yH
 Mg6zUW3ZPBwxuRijdWfHmd2gDRLGvz7y+iPigKiIEjAVcfPLScBECWorjvbO+gdUAK4A8cweb6v
 vetIH9zUKQ8Hmok+xjORloAjYoX7bl+idNVAQ57lX45F1UnE=
X-Gm-Gg: ASbGnct+993hrXrtpIW49CJJM8IE036Wbs6SeXcQsuSKfC01KccPXCFMKWp+UTQrQ2p
 C5gSOgPT1t2SCx/bGeEHejgtp82PXRYDlxC74fjscQk6SH2enmY03+qcQvRzNyrzMc2UBugCZZI
 G+Q8Hl3PTO8ElPHly/sSqvvBF8VWA=
X-Google-Smtp-Source: AGHT+IHaz9SqfKlc7HJctwnQmUrgoUc9PnR3rn1rv1VlL1Wejf/Ttu4Yzip44y8Sse4CdJFxEhlhfUA8Ek8lXtzrex4=
X-Received: by 2002:a17:907:7e8b:b0:ac1:ea5c:8711 with SMTP id
 a640c23a62f3a-ac20d97e6cfmr700051166b.1.1741277644576; Thu, 06 Mar 2025
 08:14:04 -0800 (PST)
MIME-Version: 1.0
References: <20250222213748.GB1233568@bill-the-cat>
 <CAFLszTj31qtx5TmOVLJAfhpzWHKTc9kcp22JTgJBe2bePSU60A@mail.gmail.com>
 <20250224231455.GI1233568@bill-the-cat>
 <CAFLszTiP+wPijf0QbTL0i9Ywk_0tWFwYP-1S1Lp+mFeqN=8zKg@mail.gmail.com>
 <20250227170352.GZ2640854@bill-the-cat>
 <CAFLszTgDms-RC+Qg=FLxtW253jh22eUb1Y-5OyB2U42EygdZWw@mail.gmail.com>
 <20250304161218.GA2640854@bill-the-cat>
 <CAFLszTj1hc7esvd_R3oVEqOpSBNFcRga0wmR3hnTsFELXi+m1g@mail.gmail.com>
 <20250305160631.GS2640854@bill-the-cat>
 <CAFLszTix7phNcsECa5Nwve-1g0fD6G0HZ=eWXxaHTjZp0+K9Xw@mail.gmail.com>
 <20250306143047.GA2640854@bill-the-cat>
In-Reply-To: <20250306143047.GA2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Mar 2025 09:13:52 -0700
X-Gm-Features: AQ5f1JoCkAqo8seb6e_LVMmbMiOe00y9XknsGG_UomDZbLvNQKq-EQZl0o030L0
Message-ID: <CAFLszTh47L11V7sbfbd2zaCs7rYpuPLTX4rBKnkUn8oQ9xUeXQ@mail.gmail.com>
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

On Thu, 6 Mar 2025 at 07:37, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Mar 06, 2025 at 06:59:08AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 5 Mar 2025 at 09:06, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Mar 05, 2025 at 07:18:40AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 4 Mar 2025 at 09:12, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Mar 04, 2025 at 08:35:56AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, 27 Feb 2025 at 10:03, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Feb 27, 2025 at 09:26:10AM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Mon, 24 Feb 2025 at 16:14, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Sat, Feb 22, 2025 at 05:24:05PM -0700, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Sat, 22 Feb 2025 at 14:37, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Sat, Feb 22, 2025 at 10:23:59AM -0700, Simon Glass wrote:
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, 21 Feb 2025 at 17:08, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, Feb 21, 2025 at 04:42:09PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 07:14, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Mon, Feb 17, 2025 at 06:14:06AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Sun, 16 Feb 2025 at 14:52, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Sun, Feb 16, 2025 at 12:39:34PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Sun, 16 Feb 2025 at 09:07, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Sun, Feb 16, 2025 at 07:10:12AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Sat, 15 Feb 2025 at 11:12, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > On Sat, Feb 15, 2025 at 10:21:16AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > On Sat, 15 Feb 2025 at 07:41, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > On Sat, Feb 15, 2025 at 04:59:40AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > On Mon, 10 Feb 2025 at 09:25, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > On Thu, Feb 06, 2025 at 03:38:55PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > This is a global default, so put it under 'default' like the tags.
> > > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > > > > > > > > > > > > > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > > > > > > > > > > > > > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > Please make v4 include the way you redid the second patch and be on top
> > > > > > > > > > > > > > > > > > > > > > > > > of mainline, thanks.
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > That's enough versions for me, so I'll let you do that, if you'd like.
> > > > > > > > > > > > > > > > > > > > > > > > It probably doesn't affect your tree as not as much is done in
> > > > > > > > > > > > > > > > > > > > > > > > parallel.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > I am disappointed.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > I'm sorry to disappoint you.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > The background is that I looked at the difference between our trees
> > > > > > > > > > > > > > > > > > > > > > and the gitlab files are quite different. My CI runs take about 35
> > > > > > > > > > > > > > > > > > > > > > mins and it seems that yours is around 90 mins. I would like to reduce
> > > > > > > > > > > > > > > > > > > > > > / remove the delta (for time and patch diff), but I'm not sure how.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > My goal is to get CI runs to below 20 minutes, best case.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > I'm sure CI could be quicker still with a number of faster runners. But
> > > > > > > > > > > > > > > > > > > > > if you can't be bothered to make changes against mainline, what is the
> > > > > > > > > > > > > > > > > > > > > point?
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > If you recall, I was working with your tree and had various ideas to
> > > > > > > > > > > > > > > > > > > > speed things up, but you didn't like it. So I've had to do it in my
> > > > > > > > > > > > > > > > > > > > tree. This is not about more runners (although I might have another
> > > > > > > > > > > > > > > > > > > > one soon). It is about running jobs in parallel.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > And I wasn't sure more runners in parallel would help (as it would slow
> > > > > > > > > > > > > > > > > > > down the fast runner which is what keeps the long jobs from being even
> > > > > > > > > > > > > > > > > > > longer) as much as adding more regular runners would (which we've done)
> > > > > > > > > > > > > > > > > > > and noted that in the end it's a configuration on the runner side so to
> > > > > > > > > > > > > > > > > > > go ahead. And I reviewed and ack'd the patches here which exposed the
> > > > > > > > > > > > > > > > > > > issues your path revealed. I just can't apply them because they need to
> > > > > > > > > > > > > > > > > > > be rebased (and squashed).
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > You have already added tags for things, but (IIUC) they are around the
> > > > > > > > > > > > > > > > > > other way from what I have added.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I have a tag called 'single' which means that the machine is only
> > > > > > > > > > > > > > > > > > allowed to one of those jobs. The world-build jobs are marked with
> > > > > > > > > > > > > > > > > > 'single'.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > For other jobs, I allow the runners to pick up some in parallel
> > > > > > > > > > > > > > > > > > depending on their performance (for moa and tui that is 10).
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > So at most, there is a 'world build' and 10 test.py jobs running on
> > > > > > > > > > > > > > > > > > the same machine. It seems to work fine in practice, although I would
> > > > > > > > > > > > > > > > > > rather be able to make these two types of jobs mutually exclusive, so
> > > > > > > > > > > > > > > > > > that a runner is either running 10 parallel jobs or 1 'single' job,
> > > > > > > > > > > > > > > > > > but not both. I'm not sure how to do that.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > So unless I'm missing something, in both cases the bottleneck is that
> > > > > > > > > > > > > > > > > for world build jobs you don't want anything else going on with the
> > > > > > > > > > > > > > > > > underlying build host. You could register 10 "all" runners and 1 "fast
> > > > > > > > > > > > > > > > > amd64" runner (and something similar but smaller for alexandra). If you
> > > > > > > > > > > > > > > > > update the registrations on source.denx.de can you then shut down your
> > > > > > > > > > > > > > > > > gitlab instance?
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I've put a tag of 'single' on things that should run on the single-job
> > > > > > > > > > > > > > > > runner. Everything else can run concurrently, e.g. up to 10 jobs. So I
> > > > > > > > > > > > > > > > have two runners on the same host. E.g. tui-single has 'limit = 1',
> > > > > > > > > > > > > > > > but 'tui' has no limit and is just governed by the 'concurrent = 10'
> > > > > > > > > > > > > > > > at the top of the file.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yes. And you could move those runners to the mainline gitlab. There is
> > > > > > > > > > > > > > > no "single" tag, that would be the "all" tag. And "tui-single" would be
> > > > > > > > > > > > > > > "fast amd64".
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > They are still attached to the Denx gitlab. Nothing has changed on my
> > > > > > > > > > > > > > side. I'm not sure that your new tags are working though. I have a
> > > > > > > > > > > > > > feeling something broke along the way when you made all your tag
> > > > > > > > > > > > > > changes. One of my servers makes a bit of noise and I haven't heard it
> > > > > > > > > > > > > > in quite a while.
> > > > > > > > > > > > >
> > > > > > > > > > > > > There's a few of your runners that are "stale" and haven't contacted
> > > > > > > > > > > > > gitlab in a long time. I'll double check the tags tho.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > If Denx would like to give me access to their gitlab instances, I'd be
> > > > > > > > > > > > > > happy to play around and figure out how to get it going as fast as my
> > > > > > > > > > > > > > tree does, and send a patch.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'm not sure what you mean by that? The instance itself?
> > > > > > > > > > > >
> > > > > > > > > > > > Yes. I can fiddle with tags on my runners and try to figure it out.
> > > > > > > > > > >
> > > > > > > > > > > I'm not sure what you're getting at here. If you mean "tags" in
> > > > > > > > > > > /etc/gitlab-runner/config.toml those aren't relevant here I believe.
> > > > > > > > > >
> > > > > > > > > > No, I mean the tags in CI. If I fiddle with them I can probably come
> > > > > > > > > > up with a way to run your CI much faster. Mine is about 35mins.
> > > > > > > > >
> > > > > > > > > I'm not so sure about that. Yours runs faster because it tests less. Now
> > > > > > > > > that we've got some of your other fast runners showing up again, this is
> > > > > > > > > more instructive of current times I think:
> > > > > > > > > https://source.denx.de/u-boot/u-boot/-/pipelines/24802
> > > > > > > >
> > > > > > > > But not this? :
> > > > > > >
> > > > > > > You forgot a link. But presumably to some run yesterday which took
> > > > > > > longer. And because Ilias was tweaking the currently donated arm64
> > > > > > > runners (that have other jobs to run) and also we had two or three
> > > > > > > custodians at a time preparing trees, things ran slower.
> > > > > >
> > > > > > Maybe, but I don't think so.
> > > > >
> > > > > No need to "think" about it. You can look at the pipeline history and
> > > > > see what was in queue for how long. And since I needed to be keeping an
> > > > > eye on two of the 3 arm64 runners, I could see when custodians were
> > > > > firing off tests. Aside from the number of pull requests I had waiting
> > > > > that morning.
> > > >
> > > > Your runs are reliably around an hour but mine are reliably just over
> > > > 30 minutes. I only have three runners.
> > > >
> > > > https://source.denx.de/u-boot/u-boot/-/pipelines
> > > > https://sjg.u-boot.org/u-boot/u-boot/-/pipelines
> > > >
> > > > I know you have added a duplicate build on arm64, but I can still
> > > > speed it up significantly if you'll allow me.
> > >
> > > I've never been stopping you.
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20241128160011.780550-1-sjg@chromium.org/
>
> Indeed. That gets back to what I keep telling you about how to test your
> CI changes on source.denx.de.

I don't understand your response here.

>
> > > > > > > > > If you want to make mainline CI run faster you will need to catch up
> > > > > > > > > with the missing coverage or argue that some things are redundant.
> > > > > > > >
> > > > > > > > Or perhaps I can actually just make it faster without dropping coverage?
> > > > > > >
> > > > > > > I mean, I don't know how that's physically possible, outside of adding
> > > > > > > many more expensive build hosts. We have two-three fast arm64 hosts and
> > > > > > > that world builds between 30-45 minutes. That's the biggest time
> > > > > > > bottleneck.
> > > > > >
> > > > > > Why did you join those builds up? It is better for throughput to have
> > > > > > a few runners working in parallel.
> > > > >
> > > > > Because I'm not optimizing for the single developer running CI case (or
> > > > > the loads of fast runners case). If we had sufficient resources, yes,
> > > > > the fastest possible way would be 4 "fast arm64" servers and 4 "fast
> > > > > amd64" servers each running if not 25% of the world build, at least 4
> > > > > easy to make and maintain groupings.
> > > > >
> > > > > However, we don't have that many of either. And they also need to be
> > > > > used for the biggest sandbox test suite jobs so that they run in about 5
> > > > > minutes, not about 10 minutes. So in order to not entirely block other
> > > > > custodians we do a single world build. Because make and buildman are
> > > > > very good about otherwise fully loading the server. Running anything
> > > > > else while that is going on will slow down the world build (and, the
> > > > > other job too).
> > > >
> > > > They're OK (on a fast machine) so long as the 'other' load is not too much.
> > >
> > > Things are OK until they aren't, yes. But just make sure you try out
> > > some of the worst case (ie more than one pipeline at a time running).
> >
> > We could collect stats on runs, I suppose. Perhaps it runs a lot when
> > I am asleep.
>
> That's not what your pipeline shows? Or do you mean the runners? Yes,
> the runners themselves are busy with jobs from source.denx.de.

Mostly the runners seem fairly unloaded, so far as I can tell, but as
I say, I don't have monitoring to see what happens at night.

>
> > > > > Aside, maintaining groupings is a pain. It was very bad with Travis, and
> > > > > it's only moderately painful with Azure where at least the end goal is
> > > > > 10 pipelines for maximum concurrency. And with Azure everyone *can* get
> > > > > their own "project" or whatever the right term is, and utilize 10
> > > > > runners at once.
> > > >
> > > > Yes, but we can update buildman to handle grouping automatically, as I
> > > > suggested once.
> > >
> > > I'm not sure we want make buildman act like distcc as well here. If we
> > > wanted to split the world in two, making it easy to say "arm not armv8"
> > > and "not (arm not armv8)" would be good enough.
> >
> > OK, yes that would be better as boards would be more sensibly grouped.
>
> I look forward to your results on testing that, then as I can't get that
> kind of list from buildman today (starting problem,
> "tools/buildman/buildman --dry-run -v all" is 10 boards).

OK

>
> > > > > > > The next biggest is that unless sandbox tests are run on a fast host,
> > > > > > > they take upwards of 10 minutes, rather than 5.
> > > > > >
> > > > > > Yes, they are just getting slower and slower.
> > > > >
> > > > > Adding more tests takes more time. But the real question is which tests
> > > > > take wall clock noticeable time, and why, and if we can do anything
> > > > > about it. My gut feeling is that it's in the disk image related tests
> > > > > and the user space verification of them.
> > > > >
> > > > > > > But please, rebase your work to next and see what you can do. There is
> > > > > > > likely some speed-ups possible if we allow for failures to take longer
> > > > > > > to happen (and don't gate world builds on all of test.py stage
> > > > > > > completing, just say sandbox). And if you do the work on source.denx.de
> > > > > > > (as there is *NOTHING* stopping you from registering more runners to
> > > > > > > your tree and using whatever tagging scheme you like) you might even see
> > > > > > > more of the time variability due to load from other custodians.
> > > > > >
> > > > > > I can't edit the tags on the runners, nor can I adjust them to run
> > > > > > untagged jobs, nor can I delete runners I don't want, so no, I believe
> > > > > > I need access to do that.
> > > > >
> > > > > You can do all of that with runners specific to u-boot-dm, and you can
> > > > > disable project / group runners yourself too. So yes, you can.
> > > >
> > > > Nope, sorry, I wasn't able to do any of this with the Denx tree as I
> > > > can't adjust tags and can't delete and recreate runners.
> > >
> > > You don't have
> > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/settings/ci_cd#js-runners-settings
> > > visible to you?
> >
> > Right. But also note that there are group runners on another page.
>
> And you disable them from the page I mentioned above. If you disable all
> of the existing project, group and shared runners (which are settings on
> that page) you will have zero runners available for your tree. You can
> then add project runners to only your project with whatever tagging
> scheme you like. You can then test your ideas about how tags would work.

OK, that sounds like a lot of hassle and you've already rejected my
ideas here. Are you saying you are open to a change? I am asking
because your last response suggested that my CI was no faster than
yours, or that it was only faster because it has less testing.

>
> > > > > > > > > > > > > > I also have another runner to add.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'll contact you off-list with the token.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > > > From my side, I have found it helpful and refreshing to have a gitlab
> > > > > > > > > > > > > > > > instance which I can control, e.g. it runs in half the time and if my
> > > > > > > > > > > > > > > > patches are completely blocked by Linaro, etc., I have an escape
> > > > > > > > > > > > > > > > valve.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yes, and I have no idea what any of that has to do with anything other
> > > > > > > > > > > > > > > than leading to confusion about what tree is or is not mainline. Since
> > > > > > > > > > > > > > > you own u-boot.org and ci.u-boot.org is your gitlab and
> > > > > > > > > > > > > > > https://ci.u-boot.org/u-boot/u-boot/ is your personal tree.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > For now I am working with my tree, so that I am not blocked by Linaro,
> > > > > > > > > > > > > > etc. but as you have seen I can rebase series for your tree as needed.
> > > > > > > > > > > > >
> > > > > > > > > > > > > And you're not addressing my point about using the project domain for
> > > > > > > > > > > > > your personal tree. That's my big huge "are you forking the project or
> > > > > > > > > > > > > what" problem.
> > > > > > > > > > > >
> > > > > > > > > > > > I'm just making sure that my work is not blocked or lost, as that has
> > > > > > > > > > > > happened too many times in the past few years.
> > > > > > > > > > >
> > > > > > > > > > > Again, are you intending to fork the project? Putting your personal tree
> > > > > > > > > > > in as "https://ci.u-boot.org/u-boot/u-boot.git" is not OK. I keep asking
> > > > > > > > > > > you to stop it.
> > > > > > > > > >
> > > > > > > > > > No, I'm not intending to fork anything. But I need a tree that I can
> > > > > > > > > > control and push things into.
> > > > > > > > >
> > > > > > > > > I don't know how you can call your personal tree being at
> > > > > > > > > "https://ci.u-boot.org/u-boot/u-boot.git" and saying it's somewhere you
> > > > > > > > > control and can push to while not also saying it's a fork. If you want
> > > > > > > > > to close down your gitlab and CNAME ci.u-boot.org to source.denx.de, you
> > > > > > > > > can still push things to u-boot-dm. Or if that's too constrained of a
> > > > > > > > > namespace you can also get a contributors/sjg/ namespace. But what
> > > > > > > > > you're doing today WILL lead to confusion.
> > > > > > > >
> > > > > > > > I believe I've answered this question before. It is simply that I
> > > > > > > > cannot get certain patches (bloblist, EFI, devicetree) into your tree.
> > > > > > > > There really isn't any other reason.
> > > > > > >
> > > > > > > Yes, that's still not an answer to my question.
> > > > > > >
> > > > > > > Or is the answer to my question "Yes, I'm trying to confuse people to
> > > > > > > thinking my tree is mainline."
> > > > > >
> > > > > > No, it's simply that you are not taking some patches in your tree and
> > > > > > complaining about the amount of patches.
> > > > >
> > > > > That's misleading at best. I'm not taking the patches that other
> > > > > custodians have repeatedly rejected and explained why they're rejecting
> > > > > them.
> > > >
> > > > Yes and this has affected my ability to move things forward so much
> > > > that I've had to set up my own tree. It has been working very well, to
> > > > have a relief valve.
> > >
> > > It's been working pretty terrible for the rest of the project as you
> > > build on top of things that have been rejected and you're collecting in
> > > your own personal downstream fork. Igor's email last night would be the
> > > latest example of "I wanted to look at this but where is it?"
> >
> > You make it sound like it is some strange force from the void that is
> > creating these problems :-)
>
> No, I'm saying you're making these problems and I wish you would stop.
>
> > The EFI-app thing was killed in review, so I picked it up and applied
>
> It was not "killed in review". It was posted once, given feedback and
> you picked it up for your tree in what felt like a day later but I'm
> sure was slightly longer than that.

Just over two weeks, when it seemed to me it was dead. I had emailed
Matthew several times asking if he could make time to post his work.
Telling him to refactor a load of the EFI_LOADER stuff just to get the
app running seems wrong to me. I believe I already explained this at
the time.

>
> > it and am now building on it (it now supports arm64). I mentioned
> > before that I found that whole review process embarrassing (if not
> > mortifying) and it made me realise that I shouldn't tolerate it
> > either. Matthew Garrett is the sort of engineer that people should
> > *welcome* to the project. Yes, Heinrich and Ilias had some useful
> > feedback which I will get to at some point, but it works. Perhaps I'll
> > get into it when Linaro gets the lwip network tests running with
> > sandbox :-)
>
> You know what, I'd really love feedback from Matthew about that.
>
> > The next step is to get it running in qemu with my lab...but you
> > rejected that too I think? So it won't be in your tree unless you
> > change your mind on that.
>
> Did I reject making labgrid a requirement for tests? Yes, I did. Did I
> explain why and offer alternatives? I also did. Does there seem to be
> any reason this next test of yours would require labgrid? No, there does
> not.

We can't 'require' Labgrid. There are too many loose strawmans being
thrown around here. But I want to use it in my lab and I want a test
which boots Ubuntu etc. in my lab using Labgrid. I explained that I
want to be able to interactively run the target ('ub-int qemu-86') as
well as run pytests ('ub-pyt qemu-x86 pxe') and in gitlab CI. That all
works today and all you need to do is not reject the patch.

>
> > Again, it isn't a strange and unexplained force. It is just a
> > consequence of your decisions here. If you were more flexible, I would
> > have been able to continue as we were.
>
> The only way I could be more flexible here is to apply everything you
> post without question.

That's the part of your thinking which I really struggle with. There
is a large amount of space in between that (which as you know I've
never even suggested) and what I am looking for.

The ANSI patch is an example of gratuitous rejection for no useful reason.

Given the number of emails I'm genuinely surprised at the lack of
progress we have made here.

Again, your decisions and position have produced the situation we are
in now. Much is in your control. If you are interested in changing
anything, even a little, I'm sure it would help.

>
> > > > > > > > At the moment your CI seems to be flaky as well:
> > > > > > > >
> > > > > > > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/jobs/1038174
> > > > > > >
> > > > > > > [aside, I think you meant to link to the pipeline itself, which also
> > > > > > > passed, but had some retries]
> > > > > > >
> > > > > > > Funny story. Ilias needed to tweak the fast arm64 hosts and also wanted
> > > > > > > to explore "What if we have concurrency higher?" and ran in to the
> > > > > > > problems you also ran in to with respect to git seeing an existing clone
> > > > > > > in progress and bailing. Followed by the problem of multiple non-trivial
> > > > > > > jobs running concurrently.
> > > > > > >
> > > > > > > All of which is why I keep trying to tell you that while "single" and
> > > > > > > concurrent runners work fine for you on a single user instance it will
> > > > > > > not scale.
> > > > > >
> > > > > > Yes, but I solved that with the patch I sent and it seems to be 100%
> > > > > > reliable now.
> > > > >
> > > > > Yes, you eventually solved it with 3 patches, which I asked you to
> > > > > rebase and squash to two patches (because #3 just fixes that #2 wasn't
> > > > > sufficient) and you declined.
> > > >
> > > > In general, why not just be more open to my ideas, even just try it
> > > > for a year? Given the tools I'm confident I can speed up your CI as
> > > > well.
> > >
> > > I've never not been open to applying patches to mainline that are
> > > against mainline. I am not going to rebase your work for you however.
> > > And I think it's terrible for the project as a whole when you post
> > > changes against your tree and people expect to be able to review them
> > > and then can't because it's against your downstream fork.
> >
> > I've started mentioning the base commit in patman and I think I'll
> > update it to show the source tree as well. I understand the rebasing
> > is a pain and I am certainly happy to shoulder some of that load. E.g.
> > I can send a PR for each series when you are ready to accept it. If
> > you like. Perhaps we can set a timeline for that (e.g. no comments for
> > a week?)
>
> You are subject to the same general timelines as everyone else. When
> your patches apply to mainline and aren't rejected. Which is "about two
> weeks" and has been for about 15 years now. Sometimes I will pull things
> in sooner when they're smaller / clearer, but that typically doesn't
> apply to your very large series with multiple changes in it.

OK, well again I'm happy to send a PR for things that haven't been
rejected for your tree.

Regards,
Simon
