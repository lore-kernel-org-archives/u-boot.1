Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA26EC02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 19:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C11080AE6;
	Sun, 16 Feb 2025 20:39:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eJbF7y7U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE65C80BA8; Sun, 16 Feb 2025 20:39:48 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5D5880104
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 20:39:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso578456666b.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 11:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739734786; x=1740339586; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XfUOpgaGdo1Tu/pB/w9zaeAPjiHoaZUzJaPJDNNj42c=;
 b=eJbF7y7Un3PULZv5oKUvRm+Etz9ZpJcdqBt6ml6H7QGzUAOAkRGckgkRXF3E411xk5
 1zYNz6oj4X/iv9R3SKm/S/gFEs28PDbLOrZ4WbDFXvb8m7yA2FLafg5o2abq/Yd12ZQ4
 NHaZdG0DO8eMc6IIgZAAxlj4fpnFtwY0tVNr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739734786; x=1740339586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XfUOpgaGdo1Tu/pB/w9zaeAPjiHoaZUzJaPJDNNj42c=;
 b=DVZIPhdYPBgdxAqjN6iY8Ahw72zR1b2spfPpM4hTohhds1bhr3rPCpXzdL5ENnraR0
 8hN7eD6nIe30SXRvgD9Ed+dALz9dslpbiY4nYWAuWr1ZxT6QnLfYU4xC1y4v8t8lTApM
 5iqXRjr5CFmSovZxazHgXRcKPsaSPTIMnzGpa2Ts0XsJD6OF9ysW6Il7z0DtQHOOCfCZ
 1gn/gL2cU+xQpgBF3Dtjbw/21XuAPvDFOB8jREKDufb3AVnANO3rB1waJ8yHiSJeiSO5
 h9CMUHHxcPLbYz5sef7E7DnGT637hXKoH8M3CjO3M1vY7dqslCjibrom7cEE7O7MBpTw
 /zag==
X-Gm-Message-State: AOJu0YyxOzUndcOKeKRzjoohkbbGFpoOhEmi6xUq/Xq6aYKJd9+R49rm
 dGygRV4aEala5aewvDuTt5AX55XEMLJqqMCQI/ZFlLagI7Jg/Er0TUg7lXq7U/V5fPHR3uLwgfc
 o/H39klr0yaJDspV2YwvMxVdOay5EnlIiw/ks1Jm2nOufH4E=
X-Gm-Gg: ASbGncvT+FJ00P0VmxZ2xGPwoWV1Rlzs/j5S/pGEs4Ch7uHDUKAAJhbtdYr7GPIyByR
 DjiKFzXtRCAnUYvRT+5d/FUdjq2Wo7FvhwBZTQJOolAOvXd9dNPpmAsN4wqz5RJKwIR1f6vW/yg
 ==
X-Google-Smtp-Source: AGHT+IE0BcPibFShCUTncpOv9hkg0RC/vZtHYhN6nxyez1iEjuzxGTIeXA9YYmPrmUEC283OOrzp1N6K7r3u5NVD02w=
X-Received: by 2002:a17:906:314f:b0:ab6:de35:336c with SMTP id
 a640c23a62f3a-abb70b39242mr576089466b.19.1739734786073; Sun, 16 Feb 2025
 11:39:46 -0800 (PST)
MIME-Version: 1.0
References: <20250206223858.64672-1-sjg@chromium.org>
 <20250210162518.GA2902864@bill-the-cat>
 <CAFLszTidZzhttm99Eafxwp2y-61yhY+0o5OWmfwowKNC+nQtZw@mail.gmail.com>
 <20250215144147.GM1233568@bill-the-cat>
 <CAFLszTi3D4g5LadMvaxEAn3uUu2V5L1wKCEBLu8=dzicb0Rbww@mail.gmail.com>
 <20250215181227.GT1233568@bill-the-cat>
 <CAFLszThJ11Ph-8zaNV_D0u7-UD18XtULm0kwhgQmMAj5xFgHtA@mail.gmail.com>
 <20250216160744.GA1233568@bill-the-cat>
In-Reply-To: <20250216160744.GA1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 16 Feb 2025 12:39:34 -0700
X-Gm-Features: AWEUYZl_8Ub0fAFr0uU87McliktwzpxOi3_BOr8lmFa6i8-iD8_4ym3XcQ-mKE0
Message-ID: <CAFLszTiihyuqFBcdacu+2wfd3ivDzjf4nVqfU0BgKUc0u1s6=Q@mail.gmail.com>
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

On Sun, 16 Feb 2025 at 09:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Feb 16, 2025 at 07:10:12AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 15 Feb 2025 at 11:12, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Feb 15, 2025 at 10:21:16AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sat, 15 Feb 2025 at 07:41, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Feb 15, 2025 at 04:59:40AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 10 Feb 2025 at 09:25, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Feb 06, 2025 at 03:38:55PM -0700, Simon Glass wrote:
> > > > > > >
> > > > > > > > This is a global default, so put it under 'default' like the tags.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > > > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > > > >
> > > > > > > Please make v4 include the way you redid the second patch and be on top
> > > > > > > of mainline, thanks.
> > > > > >
> > > > > > That's enough versions for me, so I'll let you do that, if you'd like.
> > > > > > It probably doesn't affect your tree as not as much is done in
> > > > > > parallel.
> > > > >
> > > > > I am disappointed.
> > > >
> > > > I'm sorry to disappoint you.
> > > >
> > > > The background is that I looked at the difference between our trees
> > > > and the gitlab files are quite different. My CI runs take about 35
> > > > mins and it seems that yours is around 90 mins. I would like to reduce
> > > > / remove the delta (for time and patch diff), but I'm not sure how.
> > > >
> > > > My goal is to get CI runs to below 20 minutes, best case.
> > >
> > > I'm sure CI could be quicker still with a number of faster runners. But
> > > if you can't be bothered to make changes against mainline, what is the
> > > point?
> >
> > If you recall, I was working with your tree and had various ideas to
> > speed things up, but you didn't like it. So I've had to do it in my
> > tree. This is not about more runners (although I might have another
> > one soon). It is about running jobs in parallel.
>
> And I wasn't sure more runners in parallel would help (as it would slow
> down the fast runner which is what keeps the long jobs from being even
> longer) as much as adding more regular runners would (which we've done)
> and noted that in the end it's a configuration on the runner side so to
> go ahead. And I reviewed and ack'd the patches here which exposed the
> issues your path revealed. I just can't apply them because they need to
> be rebased (and squashed).

You have already added tags for things, but (IIUC) they are around the
other way from what I have added.

I have a tag called 'single' which means that the machine is only
allowed to one of those jobs. The world-build jobs are marked with
'single'.

For other jobs, I allow the runners to pick up some in parallel
depending on their performance (for moa and tui that is 10).

So at most, there is a 'world build' and 10 test.py jobs running on
the same machine. It seems to work fine in practice, although I would
rather be able to make these two types of jobs mutually exclusive, so
that a runner is either running 10 parallel jobs or 1 'single' job,
but not both. I'm not sure how to do that.

Regards,
Simon
