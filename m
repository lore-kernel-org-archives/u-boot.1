Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08088E92710
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 18:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2DF383C93;
	Sat, 27 Dec 2025 19:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W4uELYGN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFE4F83CB1; Sat, 27 Dec 2025 19:51:16 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61EAF83C6C
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 19:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b7a02592efaso1208389566b.1
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 10:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766861474; x=1767466274; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M10WPkpxFO62WeR+gd6q/teBT5HhycqO8GTpoPeSOU4=;
 b=W4uELYGNXMW7cGl83FVw1duLP179VznvrnjtmKqj3u6fQiufo56Q1Rr61wcsqrXg3X
 wRCCOCV7ljFhzAwInN07ZQPYocf96PwMSFwaMA08iqLtOlJLcB+wRnvUhFjr5JXDElir
 Y2q6NlSk866PpoPr0cS4pXSBJoiVBRMRlYeqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766861474; x=1767466274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M10WPkpxFO62WeR+gd6q/teBT5HhycqO8GTpoPeSOU4=;
 b=IdYJjNXpoBBqnZlzukkf2StyD4+pUNalistzQnIiM6d2YN7ne1fYB3x+g8AEwHSZ/J
 iMZDCFFyN1k9Lwg8ImaexSJayqZrIvk+rWvtqtmdhRAh5Z2y+31+MeyBdM3KtL7ZjYQD
 5UoWHVkha1td7JHelZiUhSN3K8/l7ceIKK+p2TvbdO8NJZDJTPZi+t3l34oLOW9+1IUK
 H+Lzk4cGfd6tlkvPKYBKw+9gKhXeIlYyLnbG5kKZW29Ft38CP9sZ94j/+/Maym0Dvd8z
 APFzPklX/jdk5F3jajrLqZf7VW8P7UfKn7xz6SdyKKsw9Q2RusYR2JIgvM0p8a6bPfPE
 jBRw==
X-Gm-Message-State: AOJu0YzL0/Pae3co199ymcHCvGKWYSs1BCLm+f6Ok9ampEDdvYWdfwOp
 uYQ7rh7qyEBn8lqVPnaYoad3PSuxs9XRo5oW59TwJNtOiEPn09bhneupx/MbEiFEltsqw18NM/t
 REvMeB/9VbPm6QhEJehubZXnaXAmWnybeSOAxxI9W
X-Gm-Gg: AY/fxX5IGxwsLiZakZJnwNl+bpY6LKentXgJ9uWKtuki+ql74e0YuPK99uQgs46hty/
 xtbtwNWioIoqhclGYCV8jzDMGoLnnTj4rmZsm7zVVONNe2lQJD/z21CEP/JM/5cFMbJtS7coQQO
 8S6Dlw6XLNrCPcHk7qjL4t9jKNfYPTW66yV8U/Mr+tTlba6I+S0GnPriz0qkgzn7RMJmWqqGqob
 G1EgAKzs8lqOwytQtEAUo8W/Wm8b5MYOR1mgliEr+Ab8SGsVXdEtZgwWuPoMe11pflXuA==
X-Google-Smtp-Source: AGHT+IGXNA470NWLwiMsVPentjRLtc4XBICniTEohKu4jty95vLhadFCabkoWTcPSChXvaz3GZjavGHF/SPNbSVYrDI=
X-Received: by 2002:a17:907:1b15:b0:b73:9792:918b with SMTP id
 a640c23a62f3a-b8036f5fcf3mr2966240966b.27.1766861473638; Sat, 27 Dec 2025
 10:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20251201194857.2371332-1-simon.glass@canonical.com>
 <CAFLszTiS_hQbKnguY=ykyNOKk_hsMzBOAZAnOPjn7U49eunuFw@mail.gmail.com>
 <20251227144800.GJ710860@bill-the-cat>
 <CAFLszTib_BXUxdfkNTey0_r+RV9bKLwv6mqMd8P-ab-YevoWLA@mail.gmail.com>
 <20251227150651.GK710860@bill-the-cat>
In-Reply-To: <20251227150651.GK710860@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Dec 2025 11:51:02 -0700
X-Gm-Features: AQt7F2przHIAwZ8vAE0emv4oldX-D9eElp99fLALXtCmG0B_niOKXySfW6gFzUU
Message-ID: <CAFLszTg+yDdJ4TFPJF=_Z9f_aT7M1fuVCBc54sLcYfyfvvd97g@mail.gmail.com>
Subject: Re: [PATCH] dm: core: Create ofnode stubs when OF_REAL is disabled
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>, 
 Claude <noreply@anthropic.com>, Anurag Dutta <a-dutta@ti.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Pavel Herrmann <morpheus.ibis@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
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

On Sat, 27 Dec 2025 at 08:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Dec 27, 2025 at 07:58:10AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 27 Dec 2025 at 07:48, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Dec 27, 2025 at 04:44:07AM -0700, Simon Glass wrote:
> > > > Hi,
> > > >
> > > > On Mon, 1 Dec 2025 at 12:49, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > When there is no device tree there is not point in trying to find nodes,
> > > > > etc. since they will all be null.
> > > > >
> > > > > Add static inlines to skip the code in that case.
> > > > >
> > > > > Unfortunately this makes the file a little convoluted and there are
> > > > > two inlines for ofnode_is_enabled() and ofnode_first/next_subnode(). But
> > > > > it seems better than the alternative.
> > > > >
> > > > > We could also consider splitting up the header file.
> > > > >
> > > > > Also add a rule in drivers/Makefile to compile ofnode.o when OF_REAL is
> > > > > enabled but DM is not (for kontron-sl-mx6ul) and move the
> > > > > ofnode_for_each_compatible_node/prop() macros outside the OF_REAL
> > > > > condition, since they only use functions that have stubs.
> > > > >
> > > > > Co-developed-by: Claude <noreply@anthropic.com>
> > > > > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > > > > ---
> > > > >
> > > > >  drivers/Makefile      |   4 +
> > > > >  drivers/core/Makefile |   3 +-
> > > > >  include/dm/ofnode.h   | 714 +++++++++++++++++++++++++++++++++++++-----
> > > > >  3 files changed, 641 insertions(+), 80 deletions(-)
> > > >
> > > > Any thoughts on this patch, please?
> > >
> > > I'm not sure what you're expecting for AI-developed patches after we
> > > talked on the community call about not doing that.
> >
> > I haven't been able to join recently but should be able to join the
> > one in a few weeks. Which meeting was it?
>
> The last call you joined, where you asked about briging up AI, and I
> explained why I didn't think it was a good idea, and we should at least
> wait until after kernel summit, which was going to talk about it, before
> we do anything else.

Oh, that call. Yes I heard what you said. I didn't got to plumbers,
but Marek might have heard something.

See this patch for the current state:

https://lore.kernel.org/ksummit/20251114183528.1239900-1-dave.hansen@linux.intel.com/

There will likely be a discussion next year about which tag to use.
But I suppose this is relevant too:

https://www.linuxfoundation.org/legal/generative-ai

>
> > > That absolute briefest review I can give is that it didn't solve the
> > > problem either, and so you didn't test it correctly.
> > >
> > > I was just planning to ignore this, rather than get in to another long
> > > thread with you that I suspect few people would read.
> >
> > The problem solved is in the commit message. Is that the problem you
> > are referring to, or is there another one? We can discuss it in the
> > next call if you prefer.
>
> It seems like you forgot why you made this patch. But your patch also
> doesn't solve the problem it states, which you would have also found if
> you did more in-depth testing.
>
> This patch is I think a great example of why as a project U-Boot should
> have a "Don't use AI" policy. If with all your experience with the
> project this is the best you can get I fear others will have even worse
> quality output.

It seems like you have reviewed the patch and have some feedback, but
you want me to guess what it might be? Is that correct?

That patch took quite a while to put together and is fairly ugly. I am
sure I could split it up, particularly if it doesn't have to be
bisectable. But it could easily become 10 patches and a few separate
files, given the current state of ofnode.h

But no, I don't know what is wrong with it. If you would like to tell
me I can take a look.

Regards,
Simon
