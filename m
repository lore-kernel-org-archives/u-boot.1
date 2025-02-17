Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E490C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 13:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01A4880104;
	Mon, 17 Feb 2025 14:14:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kioQcMX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D5B280BA8; Mon, 17 Feb 2025 14:14:23 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB44E80017
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 14:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e0373c7f55so3519265a12.0
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 05:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739798060; x=1740402860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZZGEePkDk0cSepYmH83mlmE6OylKXq5PHsxvf14DZQI=;
 b=kioQcMX6sazVgXsBSBeDL0woYUMvbAsZt4XYiqBsFBmQreOc3w6e2u8yJ/V45cK0gL
 CSYt5/fn72UWWqWZWbf2XTE/Ht4zHtfQ4+gp6dHJV+CyiBGP4qCmjTbdQ6GkRHl2T3Qr
 XOHU0Qu3YQaGcGoDbP0XiX8l/pmdnp8wadX44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739798060; x=1740402860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZZGEePkDk0cSepYmH83mlmE6OylKXq5PHsxvf14DZQI=;
 b=XZ5iHq9ErwzSaclgLt2So0IuNMAJ7zZ+jGmg1+h+MXUAGjP7OnKWTZuliWKb20M2aA
 Jnluzhf4aeBnAlmgP8TgrYnA9bvRIncPb1u923MQH0PS8EMsD/GGL+6hyeRJCzGw3iiz
 fpwwxTD2bq7Shrpz6MTlAlQevsIaSSpIJcDQB8SHR4J5LmqrUruD/J7VRpcSeLFY/63i
 LEtFxgcj9Bp/mKEiOp5kqZEH8N9lUU+lLr+3FCrgrS+R1eIdS6HG0DAd6pOi+19k4j+7
 pXkCClf/lHoCi22rEdkJVTi8j1VUuVLdZzYhytBtLPKQo/m1V6Q8oLdsafNCcyOQJ0fs
 mSKA==
X-Gm-Message-State: AOJu0YzwXa5s2/yKLjMEdHpS/YpZhxEElXWEJo+P/LHiWK979FYNnaiJ
 pMfNa+dI6vaEBruBt35qCxrsT2d6zbpt3mnLyxSC8wH2Dk06NWkjJDnv71CMxhHtSP2LbPx54mn
 8lXILcun58ZZxrciE79T0YXq6ZhduRl0xm6Nw
X-Gm-Gg: ASbGncseLhtCm0ieEFBqdCE4ouf0jYhTk4nmDrok17tMbAjwKkT4hMnQABDULyf/jlI
 s0o290QKK3/PUicwYhTIgOqfLtetpjcTRv272krpRW7x1JarAnWOjO3cWzFjEfm5fQXA4aoCHTw
 ==
X-Google-Smtp-Source: AGHT+IHhk0ED1Ur+/4jt4GnPHTzA8HYPTi02HU6aWf/6iV90WDHQxedlIkZAAqkOZ7SWVgigQ4LTIeNKCLCO3OWgWEk=
X-Received: by 2002:a17:907:3f96:b0:ab7:f0fa:1340 with SMTP id
 a640c23a62f3a-abb70e408e4mr1035935566b.50.1739798059878; Mon, 17 Feb 2025
 05:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20250206223858.64672-1-sjg@chromium.org>
 <20250210162518.GA2902864@bill-the-cat>
 <CAFLszTidZzhttm99Eafxwp2y-61yhY+0o5OWmfwowKNC+nQtZw@mail.gmail.com>
 <20250215144147.GM1233568@bill-the-cat>
 <CAFLszTi3D4g5LadMvaxEAn3uUu2V5L1wKCEBLu8=dzicb0Rbww@mail.gmail.com>
 <20250215181227.GT1233568@bill-the-cat>
 <CAFLszThJ11Ph-8zaNV_D0u7-UD18XtULm0kwhgQmMAj5xFgHtA@mail.gmail.com>
 <20250216160744.GA1233568@bill-the-cat>
 <CAFLszTiihyuqFBcdacu+2wfd3ivDzjf4nVqfU0BgKUc0u1s6=Q@mail.gmail.com>
 <20250216215230.GE1233568@bill-the-cat>
In-Reply-To: <20250216215230.GE1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Feb 2025 06:14:06 -0700
X-Gm-Features: AWEUYZlMFdrqtu_S2dWSAx9N63XDlufobWJ8ISqkZV3dOGpt6wFSOHFIwloBoSo
Message-ID: <CAFLszTiydBJ8BseNHNJO+tf21QwPSJ-Od1Jnp6QWUTsPOmgFdg@mail.gmail.com>
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

On Sun, 16 Feb 2025 at 14:52, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Feb 16, 2025 at 12:39:34PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, 16 Feb 2025 at 09:07, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Feb 16, 2025 at 07:10:12AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sat, 15 Feb 2025 at 11:12, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Feb 15, 2025 at 10:21:16AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Sat, 15 Feb 2025 at 07:41, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Sat, Feb 15, 2025 at 04:59:40AM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Mon, 10 Feb 2025 at 09:25, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Feb 06, 2025 at 03:38:55PM -0700, Simon Glass wrote:
> > > > > > > > >
> > > > > > > > > > This is a global default, so put it under 'default' like the tags.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > > > > > >
> > > > > > > > > Please make v4 include the way you redid the second patch and be on top
> > > > > > > > > of mainline, thanks.
> > > > > > > >
> > > > > > > > That's enough versions for me, so I'll let you do that, if you'd like.
> > > > > > > > It probably doesn't affect your tree as not as much is done in
> > > > > > > > parallel.
> > > > > > >
> > > > > > > I am disappointed.
> > > > > >
> > > > > > I'm sorry to disappoint you.
> > > > > >
> > > > > > The background is that I looked at the difference between our trees
> > > > > > and the gitlab files are quite different. My CI runs take about 35
> > > > > > mins and it seems that yours is around 90 mins. I would like to reduce
> > > > > > / remove the delta (for time and patch diff), but I'm not sure how.
> > > > > >
> > > > > > My goal is to get CI runs to below 20 minutes, best case.
> > > > >
> > > > > I'm sure CI could be quicker still with a number of faster runners. But
> > > > > if you can't be bothered to make changes against mainline, what is the
> > > > > point?
> > > >
> > > > If you recall, I was working with your tree and had various ideas to
> > > > speed things up, but you didn't like it. So I've had to do it in my
> > > > tree. This is not about more runners (although I might have another
> > > > one soon). It is about running jobs in parallel.
> > >
> > > And I wasn't sure more runners in parallel would help (as it would slow
> > > down the fast runner which is what keeps the long jobs from being even
> > > longer) as much as adding more regular runners would (which we've done)
> > > and noted that in the end it's a configuration on the runner side so to
> > > go ahead. And I reviewed and ack'd the patches here which exposed the
> > > issues your path revealed. I just can't apply them because they need to
> > > be rebased (and squashed).
> >
> > You have already added tags for things, but (IIUC) they are around the
> > other way from what I have added.
> >
> > I have a tag called 'single' which means that the machine is only
> > allowed to one of those jobs. The world-build jobs are marked with
> > 'single'.
> >
> > For other jobs, I allow the runners to pick up some in parallel
> > depending on their performance (for moa and tui that is 10).
> >
> > So at most, there is a 'world build' and 10 test.py jobs running on
> > the same machine. It seems to work fine in practice, although I would
> > rather be able to make these two types of jobs mutually exclusive, so
> > that a runner is either running 10 parallel jobs or 1 'single' job,
> > but not both. I'm not sure how to do that.
>
> So unless I'm missing something, in both cases the bottleneck is that
> for world build jobs you don't want anything else going on with the
> underlying build host. You could register 10 "all" runners and 1 "fast
> amd64" runner (and something similar but smaller for alexandra). If you
> update the registrations on source.denx.de can you then shut down your
> gitlab instance?

I've put a tag of 'single' on things that should run on the single-job
runner. Everything else can run concurrently, e.g. up to 10 jobs. So I
have two runners on the same host. E.g. tui-single has 'limit = 1',
but 'tui' has no limit and is just governed by the 'concurrent = 10'
at the top of the file.

From my side, I have found it helpful and refreshing to have a gitlab
instance which I can control, e.g. it runs in half the time and if my
patches are completely blocked by Linaro, etc., I have an escape
valve.

Regards,
Simon
