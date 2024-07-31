Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A8CC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 21:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77A8E88A6D;
	Wed, 31 Jul 2024 23:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mWRO5e2G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B5CB882F0; Wed, 31 Jul 2024 23:40:05 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEFA988A6D
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 23:40:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-682ff2f0e67so25027407b3.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 14:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722462001; x=1723066801; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dg9/xhZKwPHGtFlI2kzKSaACqiA2QNzvqxQ9n2q2ykM=;
 b=mWRO5e2GV/G3MGLQr93wAI4mWmkopBopsZT4+i9YY/nh6i1YhvHX3sInHmz2xD6T4j
 s7X6Fag7NK9AyFsofqrE3xpOk6bIj0gMaUm0Vd2Vp8L4KH6dFtOFr0KTGG5+GXeE8Fk8
 AEq26iW/ey7CmrCDtbuGcfb8smJKS+texTRgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722462001; x=1723066801;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dg9/xhZKwPHGtFlI2kzKSaACqiA2QNzvqxQ9n2q2ykM=;
 b=Da8Z2OGhSPipQnbH9qAVM6iqvRKTCtNf6N5o3SHIj8d8nHn6DhJO5MapWqCMzHUGvW
 YSaCJ9jYG30hMIik70YsMe8PSpmHEBGEMTitnSJVXTJ1/8snCjytr6JAldfp5kYaUJNj
 v2gCwo8rlQndfmtYThybiPoAMXmN+yJGWlVH6C/Z+aev1lpVJFRBNw0P/CConrxf0zyb
 hbXCQf7ddlaGw4O1+P0XPy4bJn2sluCZKBEsTn4FaCkkePUpfsSuijKyUJuSw/QjhKka
 MXrTxaj1/H+9IXusxEBVvKi7K46AeiUifz6fIPYGga+uVscCHOlosAfqWYfYetWU8U4M
 OJpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSkbalT7Kp07gLz1KeLRYnj18b3EkNGN0BwxJXyS0FJFraVIWqmhn4KEhg6i89NFmUBKFUuGGZoVU+qLbbPo84GmXRlg==
X-Gm-Message-State: AOJu0YydMsU3pVrvL9P2gVlyuu98FZoOuDEwmvG0/+GzEEricDudCdcs
 erBw3JTNxXfk4102EGFYtBRitfQfrEgVBP4jOWT66amaGxUzi4xY6o5Lxo8ox8/hLTfQo4PC82Z
 xEOMhDskOT4/gzsGDo2fe/9iInw2g2cklXfW5
X-Google-Smtp-Source: AGHT+IGAbRFXCxTZUmFp9sVrHCH/0KJxP7EysUWY6D1Ul4K7p7fsjUhzkwUicBQE7DxtEv2jgvYlHvkPrMbb18bYR6U=
X-Received: by 2002:a0d:fc02:0:b0:669:e266:2c55 with SMTP id
 00721157ae682-6874c6406c6mr5279387b3.5.1722462001413; Wed, 31 Jul 2024
 14:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-6-sjg@chromium.org>
 <CAEfUkUKABkoHWr8i5fLNxgLAcs_7AdVYJEJj_UJj_Oby0HmwNA@mail.gmail.com>
 <CAFLszThqijQQjvSgGAkK387KXV9mjo8xs9tEK_jfKGocYyZzGQ@mail.gmail.com>
 <CAC_iWj+M5uw1qaVcUFZpXDArdbF3jfJDXk1HiA1i4S2eEYbEig@mail.gmail.com>
 <CAFLszTgeKggZYaTRnH9xB7Uznf0=OS42aogg-rym7cp=QRjw+A@mail.gmail.com>
 <CAC_iWj+Y+hXwjgcVaMdEYrE_G9XuuhiZQnp2ckCYNkzYPZN3tQ@mail.gmail.com>
 <CAFLszThK_FnLxWrSzax_Jm7XMmmTanTmGrLjK3MfCM0uqKsNOw@mail.gmail.com>
 <ZnLR_NnJY3hFBXcR@hera>
 <CAFLszTitfewWG_dHDM3idEyntkL8tjvh6puH08+aUDeXLy4+LQ@mail.gmail.com>
 <CAEfUkU+AJb8z6_KgMVac90iQ6R4P0dNTgq5hitvZrXDQ8x8B1w@mail.gmail.com>
 <CAFLszTjQwiJFbgG+aXf9qmXPbHSP6JVowhv=xdZYr3B45_+1nA@mail.gmail.com>
 <CAFLszThtUprUv5ZsoN-R_W2c9YG4FvvZ6zT_qGpqOwW5Axbs1Q@mail.gmail.com>
 <CAC_iWjJE-CmSFnv5Lz-w_v+XvV3_6vA7b9uiaf_qf9+2E0tfBw@mail.gmail.com>
In-Reply-To: <CAC_iWjJE-CmSFnv5Lz-w_v+XvV3_6vA7b9uiaf_qf9+2E0tfBw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Jul 2024 15:39:50 -0600
Message-ID: <CAFLszThKS5qUgH4jtEi1XkbKyG8FyKWWu4ifk+1He=192AQw7Q@mail.gmail.com>
Subject: Re: [PATCH 5/9] fdt: Correct condition for bloblist existing
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Tom Rini <trini@konsulko.com>, Jerry Van Baren <vanbaren@cideas.com>, 
 Shiji Yang <yangshiji66@outlook.com>
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

Hi Ilias,

On Wed, 31 Jul 2024 at 14:09, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Wed, 31 Jul 2024 at 01:35, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi all,
> >
> > On Fri, 21 Jun 2024 at 12:16, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Raymond,
> > >
> > > On Fri, 21 Jun 2024 at 10:40, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Fri, 21 Jun 2024 at 10:58, Simon Glass <sjg@chromium.org> wrote:
> > > >>
> > > >> Hi Ilias,
> > > >>
> > > >> On Wed, 19 Jun 2024 at 06:41, Ilias Apalodimas
> > > >> <ilias.apalodimas@linaro.org> wrote:
> > > >> >
> > > >> > Hi Simon,
> > > >> >
> > > >> > On Wed, Jun 12, 2024 at 02:24:31PM -0600, Simon Glass wrote:
> > > >> > > Hi Ilias,
> > > >> > >
> > > >> > > On Wed, 12 Jun 2024 at 00:02, Ilias Apalodimas
> > > >> > > <ilias.apalodimas@linaro.org> wrote:
> > > >> > > >
> > > >> > > > [...]
> > > >> > > >
> > > >> > > > > > > >> ---
> > > >> > > > > > > >>
> > > >> > > > > > > >>  lib/fdtdec.c | 12 ++++++++++--
> > > >> > > > > > > >>  1 file changed, 10 insertions(+), 2 deletions(-)
> > > >> > > > > > > >>
> > > >> > > > > > > >> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > > >> > > > > > > >> index b2c59ab3818..b141244e3b9 100644
> > > >> > > > > > > >> --- a/lib/fdtdec.c
> > > >> > > > > > > >> +++ b/lib/fdtdec.c
> > > >> > > > > > > >> @@ -1669,8 +1669,16 @@ int fdtdec_setup(void)
> > > >> > > > > > > >>  {
> > > >> > > > > > > >>         int ret = -ENOENT;
> > > >> > > > > > > >>
> > > >> > > > > > > >> -       /* If allowing a bloblist, check that first */
> > > >> > > > > > > >> -       if (CONFIG_IS_ENABLED(BLOBLIST)) {
> > > >> > > > > > > >> +       /*
> > > >> > > > > > > >> +        * If allowing a bloblist, check that first. This would be better
> > > >> > > > > > > >> +        * handled with an OF_BLOBLIST Kconfig, but that caused far too much
> > > >> > > > > > > >> +        * argument, so add a hack here, used e.g. by chromebook_coral
> > > >> > > > > > > >
> > > >> > > > > > > > I am a bit confused by this comment - It means you will not use OF_BLOBLIST,
> > > >> > > > > > > > but actually you are using it below. Is it a typo?
> > > >> > > > > > >
> > > >> > > > > > > Basically it would be cleaner to have a separate, phase-specific
> > > >> > > > > > > Kconfig control as to whether the DT can come from the bloblist (I
> > > >> > > > > > > can't remember the Kconfig name I suggested, nor the patch as it was
> > > >> > > > > > > last year sometime). But for now I am adding this hack to get a few
> > > >> > > > > > > boards working again.
> > > >> > > > > >
> > > >> > > > > > I am a bit confused.
> > > >> > > > > > First of all the comment is innapropriate. We went through a lengthy
> > > >> > > > > > discussion on BLOBLIST/OF_BLOSLIST etc and,  even Tom chimed in and we
> > > >> > > > > > made up our minds. Why are you adding this comment now? Why do code
> > > >> > > > > > comments have to illustrate your personal opinion -- which was
> > > >> > > > > > rejected?
> > > >> > > > >
> > > >> > > > > I'm sorry for the tone of the comment. I am not trying to offend
> > > >> > > > > anyone here and I'm happy to change the language.
> > > >> > > >
> > > >> > > > Yes please a comment explaining why that piece of code is there is far
> > > >> > > > more intuitive.
> > > >> > >
> > > >> > > OK, once we have agreed the below I can do that.
> > > >> > >
> > > >> > > >
> > > >> > > > >  As I probably
> > > >> > > > > mentioned at the time, my accepted patch breaks my workflow and
> > > >> > > > > several boards. I hope you can understand how frustrating that sort of
> > > >> > > > > thing can be.
> > > >> > > >
> > > >> > > > Yes, I do and I am fine with a short-term patch that fixes issues, as
> > > >> > > > long as its not too intrusive. There is a very thin line between quick
> > > >> > > > and dirty fixes to spaghetti unreadable code. But we should have
> > > >> > > > comments and/or commit messages indicating that this needs a proper
> > > >> > > > fix
> > > >> > >
> > > >> > > I spent a lot of time explaining this last time.
> > > >> > >
> > > >> > > >
> > > >> > > > > Also, now that I have my lab back up and running and I
> > > >> > > > > would like these boards to work again on mainline!
> > > >> > > > >
> > > >> > > > > >
> > > >> > > > > > Grepping for OF_BLOBLIST, I can't find any matches, so is the above if a typo?
> > > >> > > > >
> > > >> > > > > Remember, it was a patch you rejected :-)
> > > >> > > >
> > > >> > > > I don't maintain any of that. I only gave some feedback along the
> > > >> > > > lines of "bloblist was designed to be auto-discoverable, I don't see
> > > >> > > > how adding an explicit Kconfig helps". IIRC we eventually followed
> > > >> > > > what Tom suggested.
> > > >> > >
> > > >> > > I'm not trying to point the finger here. So far the boards are broken
> > > >> > > in mainline...I'm just trying to fix that,
> > > >> > >
> > > >> > > >
> > > >> > > > In any case, the amount of bike-shedding in the topic is too much. Do
> > > >> > > > you mind explaining the problem in your workflow again? Perhaps we can
> > > >> > > > find a solution that is integrated in bloblist_maybe_init() instead of
> > > >> > > > injecting ifs on when a bloblist should or should not be searched for
> > > >> > > > all over the place.
> > > >> > >
> > > >> > > TPL (or SPL) sets up a bloblist with bits of info in it, but no DT
> > > >> > > (which is in memory-mapped SPI flash)
> > > >> > > U-Boot proper starts up, it wants to get the bloblist but not hang if
> > > >> > > the bloblist doesn't have a DT
> > > >> >
> > > >> > Sure, that's reasonable and IIRC that's the design we agreed a while back.
> > > >> > Looking at the code, if the DT isn't found in a bloblist and the feature is
> > > >> > enabled, we don't crash. We just print a debug message and continue to find
> > > >> > the DT as we used. Why do we have to skip the call to
> > > >> > bloblist_maybe_init()?
> > > >>
> > > >> Because at this point, if there is no bloblist, then it needs to be
> > > >> created. But creating it this early may fail, e.g. since there is no
> > > >> malloc(). The intent of this code is to locate an FDT from an existing
> > > >> bloblist. There is no point in creating a new bloblist here, since it
> > > >> obviously won't have an FDT in it.
> > > >>
> > > > Can we add a bool arg to bloblist_init for this?
> > > > Eg. int bloblist_init(bool allow_malloc);
> > >
> > > Yes, we can do anything, but that seems like a hack to me...if we init
> > > the bloblist for the first time in the current phase, then it
> > > obviously won't have an FDT inside it. It is the unconditional
> > > requirement of an FDT which is causing the problems here.
> >
> > Can we apply this patch, please? I still have several broken boards in
> > my lab due to this.
>
> Raymond acked the patch, I don't mind merging it

OK thank you.

There is another one too - see the note at the end.

https://patchwork.ozlabs.org/project/uboot/patch/20240721100940.3202027-6-sjg@chromium.org/

Regards,
Simon
