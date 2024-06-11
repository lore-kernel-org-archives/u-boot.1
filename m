Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA813C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 19:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D624E885E7;
	Tue, 11 Jun 2024 21:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gB7u28Wm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 752C3883C2; Tue, 11 Jun 2024 21:25:26 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBFBF885E7
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 21:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3d21c4eec2dso876014b6e.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 12:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718133919; x=1718738719; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f/W3ZYCExXN9sXjJ5/F31iZ1CE2MJek42TMKjQJ0j3o=;
 b=gB7u28WmlzA2PCT9gExC+2NYrlBD+FJEoNf/AUGDuhPCb2XbNoLC+xh3VWUJ94R+mr
 zFCNCdI+24Iy9j9qRi1Ht9DoeceqQ2G/fkmkbUgx1BYFKIo6KhuU9W1omI6FIpT9t1wh
 hoUXCr5Mn2QcfOzm4GbdnYD77nUqhMPGhCL0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718133919; x=1718738719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f/W3ZYCExXN9sXjJ5/F31iZ1CE2MJek42TMKjQJ0j3o=;
 b=f+pmASiB/CXRW3zc8JJMTuIb6upgc+V62pLpJF2Z4I2zTTWVZkB5xh/VtRV+WLPL/h
 1PaPAm8/fV6wSNyYVgdvylPEge0wqTzWXbGRaGGTs7lBh1x1xwmT7JCDzhUdGIbGkqw0
 TTusDOfacPaCkqz7q6tstIOArQytL7hYd4WsNdaY1B4pTAZ+t87uvEn9R5+seuA4bZsl
 QNc7RaGs74hY1Hnd/JcehiKnhMZRu/DtI2tJjY9dnh+/x0IGCeVC6l4tTNHJp9UUXpPE
 RPhTnPML0fOVnXiIn/CCh1oRKMX0zEiJHsbznvDqRpiGojhIUzKpFSmn5pUFRbRqcyyh
 UjRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfcD4pynlEzch3RiiEkxy0jNON3n63VgjH4L9pZQ92xMGV0ndIP2SXr5h03uwM4Kk16hs9s0CC9EzCQu9yiEUKUT03+A==
X-Gm-Message-State: AOJu0Yzx6LclkDPihS2OrAXCmTBMqxABbCoQz/Aev8hDsRRnRR2wBGpv
 T91Ovr8vTFQXTFJzd9hxuNrc3mJ5m0BD96/x1F3K06rggyRcK6SDpjjFxqmur8TwzIgyKS8GHgB
 GrKZ9gGqLlPt3NCimgk7v7WixbQ1ALBCUXJ9g
X-Google-Smtp-Source: AGHT+IG1YvV8JPon+a3i73h4Q5kl2V3a5WecEab3ytxZ+eiLUXeo2+TDfAjTwPiOvImiMMvGv4q4kgY4mY62VQp7hno=
X-Received: by 2002:a05:6808:1294:b0:3d2:20fb:9585 with SMTP id
 5614622812f47-3d220fb9812mr9689988b6e.12.1718133919436; Tue, 11 Jun 2024
 12:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-6-sjg@chromium.org>
 <CAEfUkUKABkoHWr8i5fLNxgLAcs_7AdVYJEJj_UJj_Oby0HmwNA@mail.gmail.com>
 <CAFLszThqijQQjvSgGAkK387KXV9mjo8xs9tEK_jfKGocYyZzGQ@mail.gmail.com>
 <CAC_iWj+M5uw1qaVcUFZpXDArdbF3jfJDXk1HiA1i4S2eEYbEig@mail.gmail.com>
In-Reply-To: <CAC_iWj+M5uw1qaVcUFZpXDArdbF3jfJDXk1HiA1i4S2eEYbEig@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 13:25:08 -0600
Message-ID: <CAFLszTgeKggZYaTRnH9xB7Uznf0=OS42aogg-rym7cp=QRjw+A@mail.gmail.com>
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

On Tue, 11 Jun 2024 at 08:27, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Tue, 11 Jun 2024 at 13:54, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Raymond,
> >
> > On Mon, 10 Jun 2024 at 13:13, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Tue, 4 Jun 2024 at 23:27, Simon Glass <sjg@chromium.org> wrote:
> > >>
> > >> On some boards, the bloblist is created in SPL once SDRAM is ready. It
> > >> cannot be accessed until that point, so is not available early in SPL.
> > >>
> > >> Add a condition to avoid a hang in this case.
> > >>
> > >> This fixes a hang in chromebook_coral
> > >>
> > >> Fixes: 70fe2385943 ("fdt: Allow the devicetree to come from a bloblist")
> > >>
> > >> Signed-off-by: Simon Glass <sjg@chromium.org>
> > >> ---
> > >>
> > >>  lib/fdtdec.c | 12 ++++++++++--
> > >>  1 file changed, 10 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > >> index b2c59ab3818..b141244e3b9 100644
> > >> --- a/lib/fdtdec.c
> > >> +++ b/lib/fdtdec.c
> > >> @@ -1669,8 +1669,16 @@ int fdtdec_setup(void)
> > >>  {
> > >>         int ret = -ENOENT;
> > >>
> > >> -       /* If allowing a bloblist, check that first */
> > >> -       if (CONFIG_IS_ENABLED(BLOBLIST)) {
> > >> +       /*
> > >> +        * If allowing a bloblist, check that first. This would be better
> > >> +        * handled with an OF_BLOBLIST Kconfig, but that caused far too much
> > >> +        * argument, so add a hack here, used e.g. by chromebook_coral
> > >
> > > I am a bit confused by this comment - It means you will not use OF_BLOBLIST,
> > > but actually you are using it below. Is it a typo?
> >
> > Basically it would be cleaner to have a separate, phase-specific
> > Kconfig control as to whether the DT can come from the bloblist (I
> > can't remember the Kconfig name I suggested, nor the patch as it was
> > last year sometime). But for now I am adding this hack to get a few
> > boards working again.
>
> I am a bit confused.
> First of all the comment is innapropriate. We went through a lengthy
> discussion on BLOBLIST/OF_BLOSLIST etc and,  even Tom chimed in and we
> made up our minds. Why are you adding this comment now? Why do code
> comments have to illustrate your personal opinion -- which was
> rejected?

I'm sorry for the tone of the comment. I am not trying to offend
anyone here and I'm happy to change the language. As I probably
mentioned at the time, my accepted patch breaks my workflow and
several boards. I hope you can understand how frustrating that sort of
thing can be. Also, now that I have my lab back up and running and I
would like these boards to work again on mainline!

>
> Grepping for OF_BLOBLIST, I can't find any matches, so is the above if a typo?

Remember, it was a patch you rejected :-)

Regards,
Simon



>
>
> Thanks
> /Ilias
> >
> > >
> > >>
> > >> +        * The necessary test is whether the previous stage passed a bloblist,
> > >> +        * not whether this one creates one.
> > >> +        */
> > >> +       if (CONFIG_IS_ENABLED(OF_BLOBLIST) &&
> > >> +           (spl_prev_phase() != PHASE_TPL ||
> > >> +            !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> > >>                 ret = bloblist_maybe_init();
> > >>                 if (!ret) {
> > >>                         gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> > >> --
> > >> 2.34.1
> > >>
> > >
> > > Regards,
> > > Raymond
> >
> > Regards,
> > Simon
