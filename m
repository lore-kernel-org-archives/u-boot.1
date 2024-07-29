Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3001AC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B569287E13;
	Mon, 29 Jul 2024 17:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YYpV1hiG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8127E88806; Mon, 29 Jul 2024 17:27:56 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 642638785E
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e0b9589a72dso302899276.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266873; x=1722871673; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UYHYd5eOU8HeQCo6iX8k8K2b8QCaWGZM8evMeOQ6h7g=;
 b=YYpV1hiGrDxbUaQiFxkrPiK4V+KMpGnPM3+bRtO5uLdZFMHWzHDhmRPB6DiluEGaqh
 AOzK6xK4GSr2aCAjphERVpH0REYPhdnwtxRy7nM4loMyLRIhOjY+C/LgCTb44JphOJxe
 ojtIxOZczfeZTBHstBNZRRFMv44S6djzliF1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266873; x=1722871673;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UYHYd5eOU8HeQCo6iX8k8K2b8QCaWGZM8evMeOQ6h7g=;
 b=NfShv3w6pCtor29Us3ugR8WDqDpu1wofybJP3aBjhnoX3TVcXEtivj6zxVG33hpRan
 LA8PobAfc+9Jg75joe79+1hqBeMZktqOoyfIc93rW/Pxdp9U0nXB7kMq79KTGDvDskVf
 RoZMW8q3hUWgD6RAP5YoWigXpci0LHxT9de+4/OULmaY+//iWko+onLmUpqq4UfNCjqG
 S2mxqQP2wmNE+F1NKFWuEKHzJ9blmsO65ms7r3LL2FEbPt5aNczv2lYejFcqyUIKQIZt
 f/APVpgXHHKmiW3UNGuOirXqblZFngY8duZkYjCsInsvB5wSdWpg2U2MV6JcZDXhAEla
 AU6Q==
X-Gm-Message-State: AOJu0YxH8K5MlC5Tne7gt+zIxzzXlKpBnanM0NUQXFGnaMz1PpG/U7rn
 cMFs3M49fZGzbBoG+cxC1Q6Auizsc/YIX4Y5BxkEc4a5sthsrjhLVXbHG5igMrIZhJDx5FJd6Z2
 q5kmJWDuFtykvz12LxCwFzq17sRNhRKu0bdIt
X-Google-Smtp-Source: AGHT+IF/U8pe1WVuOObOqJFq23fy6lbjgToLhGwLwHouRNQp5uT6LjTRY74iKgwh2EB1WBY8EoRP80oYgQtW8cbh1Eo=
X-Received: by 2002:a25:1e06:0:b0:e03:601a:1a83 with SMTP id
 3f1490d57ef6-e0b545a5306mr7877759276.39.1722266873291; Mon, 29 Jul 2024
 08:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-25-sughosh.ganu@linaro.org>
 <CAFLszTj-+LgVc7ychfuiQXB27WRVzAuqUCV6wQvBLgk0_PzwKg@mail.gmail.com>
 <CADg8p97_eYrwfuENcOA6m7DShtENbTVaWJQDy73vkqusAfTztg@mail.gmail.com>
In-Reply-To: <CADg8p97_eYrwfuENcOA6m7DShtENbTVaWJQDy73vkqusAfTztg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:27:42 -0600
Message-ID: <CAFLszTghJQS6ss0PM1k2bRn4Ymf0_7AP2W5UrDCS=_MxoZm3XA@mail.gmail.com>
Subject: Re: [PATCH 24/40] lmb: add a common implementation of
 arch_lmb_reserve()
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Mon, 29 Jul 2024 at 02:42, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Almost all of the current definitions of arch_lmb_reserve() are doing
> > > the same thing. The only exception in a couple of cases is the
> > > alignment parameter requirement. Have a generic weak implementation of
> > > this function, keeping the highest value of alignment that is being
> > > used(16K).
> > >
> > > Also, instead of using the current value of stack pointer for starting
> > > the reserved region, have a fixed value, considering the stack size
> > > config value.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since rfc: None
> > >
> > >  arch/arc/lib/cache.c        | 14 --------------
> > >  arch/arm/lib/stack.c        | 14 --------------
> > >  arch/m68k/lib/bootm.c       | 17 -----------------
> > >  arch/microblaze/lib/bootm.c | 14 --------------
> > >  arch/mips/lib/bootm.c       | 15 ---------------
> > >  arch/nios2/lib/bootm.c      | 13 -------------
> > >  arch/powerpc/lib/bootm.c    | 13 +++----------
> > >  arch/riscv/lib/bootm.c      | 13 -------------
> > >  arch/sh/lib/bootm.c         | 13 -------------
> > >  arch/x86/lib/bootm.c        | 18 ------------------
> > >  arch/xtensa/lib/bootm.c     | 13 -------------
> > >  lib/lmb.c                   |  6 +++++-
> > >  12 files changed, 8 insertions(+), 155 deletions(-)
> >
> > How about not having a weak function? I have to wonder whether powerpc
> > really needs to be different? If it does, I suppose we could use an
> > event to deal with powerpc.
>
> Again, I have the same question about weak functions. It does not seem
> to be a universal policy.

Perhaps the powerpc maintainer can help figure this out, with answers
to the questions I posed?

Regards,
SImon
