Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F456C27C75
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 06:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B0D98825E;
	Wed, 12 Jun 2024 08:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xqS0MBgD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0151C88373; Wed, 12 Jun 2024 08:02:09 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CB968812C
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 08:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2bfffa3c748so1688976a91.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718172125; x=1718776925; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jxCsx41o4aWJcNn10kEsUbgyRwUzKgNzDtxRSvAHqc4=;
 b=xqS0MBgDswOVGDl1SX6hpPYNBWV0W2B3+bVQaaAlz40BVvujnm/Iyxer5fkbgbc1SQ
 EgCPS8AklLTLV1lJVNXms5ccxFom5Rr+K4DC/BR6LtcuO2DmAwhJ0mcv45OGmrKFNiLq
 M8/hp+Y/Oav8nvDuqaaHUrANVq6GQHwIE+96nYqnZnii4PWbYloMxAkU7N8I167wjp3u
 B5wcB+ujTrrymdwoOEZ0xRqAt8VhExOJD6f8ZU6YF+HYXRzAypwICF4WL2HE3mgp4oll
 vX7nHjMi/g5wUuJ3zJUbIBjq2Dno9aXjY6hHDOVYjxJPmRhvPMQ2cI+xR+s6o8fWsVbo
 jJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718172125; x=1718776925;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jxCsx41o4aWJcNn10kEsUbgyRwUzKgNzDtxRSvAHqc4=;
 b=MhcfeBfOOQaV9y2xPc3Xkl1IKHRjq9KPUR/y5qnBmZfPkj5+9brm+hKiNvtOs9BsXS
 yU4iFoETwfVNSWU1XMUeoazIowyjudBDNUFfmsgvfLnLfU2w/deVe/pQ4ZrnTu+WRam5
 HPqr0x4qx6hVWIKv0crkicmkG15kli2xgrNMYQ85+/9/dTvBmzq2SOLHT6bz/wE/x/m3
 h7HDs1+iYZqPsgoXnd+ezfrtGG9CXwp7LnUvzT5+jfV0yz+g0fXL3YodWkni61LjL85P
 qoDOk8eEhI440+g0vMFk92mwumJtD7Rgk1L+bCylYiFm/8id+8X9RldQ6LQr8d2H80f8
 xCYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNhTIbOXmpU+ufjINfM9JA0GJ3z4e5+JjEDhQq4CcQa1iTtVWwq7oe9EZ8hR2aH+QMAcCUqx5hCmvdSyrN05if05eHSQ==
X-Gm-Message-State: AOJu0YzL+PDsKYL2ncGAmKOI6AarwQLy59sBf1tI1EcujXsyqjlbP/JQ
 KLL08XKXhKmvBvhmAfyRcWbZPlGfS+MYcPeCHzF8k5RCsWcVaWphPS8GQt3ITAdf3ViHl1r6vZ9
 TlP+YUwkz5TGPY2KelQjIKRlSVKrVhnzXe+LiqQ==
X-Google-Smtp-Source: AGHT+IGkDKO7jqw9OL0HMjecvHzmslCL4Yc3cJfyPyxTdLiM6gL2sS+JyY9Z9RJpyHrgaSDn/gHxJfqpnYvjonMnG3U=
X-Received: by 2002:a17:90a:e294:b0:2c2:d6c8:977 with SMTP id
 98e67ed59e1d1-2c4a764bdc6mr868839a91.24.1718172125054; Tue, 11 Jun 2024
 23:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-6-sjg@chromium.org>
 <CAEfUkUKABkoHWr8i5fLNxgLAcs_7AdVYJEJj_UJj_Oby0HmwNA@mail.gmail.com>
 <CAFLszThqijQQjvSgGAkK387KXV9mjo8xs9tEK_jfKGocYyZzGQ@mail.gmail.com>
 <CAC_iWj+M5uw1qaVcUFZpXDArdbF3jfJDXk1HiA1i4S2eEYbEig@mail.gmail.com>
 <CAFLszTgeKggZYaTRnH9xB7Uznf0=OS42aogg-rym7cp=QRjw+A@mail.gmail.com>
In-Reply-To: <CAFLszTgeKggZYaTRnH9xB7Uznf0=OS42aogg-rym7cp=QRjw+A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 12 Jun 2024 09:01:28 +0300
Message-ID: <CAC_iWj+Y+hXwjgcVaMdEYrE_G9XuuhiZQnp2ckCYNkzYPZN3tQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] fdt: Correct condition for bloblist existing
To: Simon Glass <sjg@chromium.org>
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

[...]

> > > >> ---
> > > >>
> > > >>  lib/fdtdec.c | 12 ++++++++++--
> > > >>  1 file changed, 10 insertions(+), 2 deletions(-)
> > > >>
> > > >> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > > >> index b2c59ab3818..b141244e3b9 100644
> > > >> --- a/lib/fdtdec.c
> > > >> +++ b/lib/fdtdec.c
> > > >> @@ -1669,8 +1669,16 @@ int fdtdec_setup(void)
> > > >>  {
> > > >>         int ret = -ENOENT;
> > > >>
> > > >> -       /* If allowing a bloblist, check that first */
> > > >> -       if (CONFIG_IS_ENABLED(BLOBLIST)) {
> > > >> +       /*
> > > >> +        * If allowing a bloblist, check that first. This would be better
> > > >> +        * handled with an OF_BLOBLIST Kconfig, but that caused far too much
> > > >> +        * argument, so add a hack here, used e.g. by chromebook_coral
> > > >
> > > > I am a bit confused by this comment - It means you will not use OF_BLOBLIST,
> > > > but actually you are using it below. Is it a typo?
> > >
> > > Basically it would be cleaner to have a separate, phase-specific
> > > Kconfig control as to whether the DT can come from the bloblist (I
> > > can't remember the Kconfig name I suggested, nor the patch as it was
> > > last year sometime). But for now I am adding this hack to get a few
> > > boards working again.
> >
> > I am a bit confused.
> > First of all the comment is innapropriate. We went through a lengthy
> > discussion on BLOBLIST/OF_BLOSLIST etc and,  even Tom chimed in and we
> > made up our minds. Why are you adding this comment now? Why do code
> > comments have to illustrate your personal opinion -- which was
> > rejected?
>
> I'm sorry for the tone of the comment. I am not trying to offend
> anyone here and I'm happy to change the language.

Yes please a comment explaining why that piece of code is there is far
more intuitive.

>  As I probably
> mentioned at the time, my accepted patch breaks my workflow and
> several boards. I hope you can understand how frustrating that sort of
> thing can be.

Yes, I do and I am fine with a short-term patch that fixes issues, as
long as its not too intrusive. There is a very thin line between quick
and dirty fixes to spaghetti unreadable code. But we should have
comments and/or commit messages indicating that this needs a proper
fix

> Also, now that I have my lab back up and running and I
> would like these boards to work again on mainline!
>
> >
> > Grepping for OF_BLOBLIST, I can't find any matches, so is the above if a typo?
>
> Remember, it was a patch you rejected :-)

I don't maintain any of that. I only gave some feedback along the
lines of "bloblist was designed to be auto-discoverable, I don't see
how adding an explicit Kconfig helps". IIRC we eventually followed
what Tom suggested.

In any case, the amount of bike-shedding in the topic is too much. Do
you mind explaining the problem in your workflow again? Perhaps we can
find a solution that is integrated in bloblist_maybe_init() instead of
injecting ifs on when a bloblist should or should not be searched for
all over the place.

Regards
/Ilias

>
> Regards,
> Simon
>
>
>
> >
> >
> > Thanks
> > /Ilias
> > >
> > > >
> > > >>
> > > >> +        * The necessary test is whether the previous stage passed a bloblist,
> > > >> +        * not whether this one creates one.
> > > >> +        */
> > > >> +       if (CONFIG_IS_ENABLED(OF_BLOBLIST) &&
> > > >> +           (spl_prev_phase() != PHASE_TPL ||
> > > >> +            !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> > > >>                 ret = bloblist_maybe_init();
> > > >>                 if (!ret) {
> > > >>                         gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> > > >> --
> > > >> 2.34.1
> > > >>
> > > >
> > > > Regards,
> > > > Raymond
> > >
> > > Regards,
> > > Simon
