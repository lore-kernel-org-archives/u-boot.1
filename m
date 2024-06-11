Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAAFC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 14:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27288885C5;
	Tue, 11 Jun 2024 16:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="haYByDvL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEE17886AE; Tue, 11 Jun 2024 16:27:32 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8656E8859A
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7042a8ad9f5so2092914b3a.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718116049; x=1718720849; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3234PJsJWoMjhGJmeAyOrBFLMpTf/uP0nQvhUtOFlAA=;
 b=haYByDvLq4WEEVGT/qI1DEt4sV+yCiu9DPQSYkDfqzOiC7V7YTaodzae3dv80Qvmmn
 KwVS2Y7li9/YOTlZCFVoiKh+KNTP8b41rF1hptU4AtqB6UVZAgwyW4yEaa+2ocIF6H+K
 KK2tKxP+SzWiQIZV4OBj/Et1XJYmM5dHgkEzC+l5pzMt4OXT1V1SH/aErnkwnEUogK/b
 vtrxmkP18Fe4lWsBVvXX/lJ31OGSJq/BD7vC59B3TOO/fiN6NWxIQdRIHDueQFYF3iKb
 rmlhsYvaIROF5s/dbrWgSUma1Ez+T9vmiE1wsenNfvDMf1IhMAZY5vCs1tFHSr6udtYH
 Sqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718116049; x=1718720849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3234PJsJWoMjhGJmeAyOrBFLMpTf/uP0nQvhUtOFlAA=;
 b=RN6T8byoGgEasRJgv0bD4NvpTZQqA/fe5yVJNIk6LMkHP5l3KfxMm0y6CiCe1oYNKZ
 9Fu8DhPtPV4c3rkyhEg8i18UCtUUkotxKUa5JBa9jGd7uibUICdAbR5bIY6tkG1WkbdD
 2yhpoH4A9oync9KKcelcWpwG49iiewMxgJn6kKdAlevr4+VDwf3A6KOQGmr9sx7p29yu
 uCpU2SQkGvblvCjtsktKzaMeYDG4UayQMbaQK8if091Wx0xpV0B0NoBkBTzfVkq9Lhim
 uo53WzAvhOBAOn/t2zL/y8wkZBvsOthta96IYY7cXBkQVWzz8hLUU6C/St7UmSXtKWoB
 bYdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI/6GS8BhP7kdUf6xZ1rnpB0kWkpkKJeIpCqv6oFu1ao0e5EtcvI3ku+sFSi+dI7NhcIP2/N4S81k0bcSkhNl46e7o0Q==
X-Gm-Message-State: AOJu0Yz2azGJsVoDK3S9Mp79Bb7dGqB+y++rVUaz1ZEuYgUckiO8kcSG
 c09SRrtRJfF0As16nqgkwJCTAH380CNNn2oZ4pxb4QxKnTLq9ED/f6VsjfDmE5YrFzh/x2ZrNIY
 lTOTXubTTcw/dWqFrpMQM+Nm9cZ7G8mBSGc5XVw==
X-Google-Smtp-Source: AGHT+IHSJJHeqNz5WHP91qK5u2/MTdv3Ej9a6zdzDfhMw5J6IMFQ4djEw4cF9PBZXRIRb4EjugjYWWO5kUJcTdX1po8=
X-Received: by 2002:a17:90a:d4f:b0:2c2:c979:4c06 with SMTP id
 98e67ed59e1d1-2c32b4a0f15mr3860786a91.14.1718116048812; Tue, 11 Jun 2024
 07:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-6-sjg@chromium.org>
 <CAEfUkUKABkoHWr8i5fLNxgLAcs_7AdVYJEJj_UJj_Oby0HmwNA@mail.gmail.com>
 <CAFLszThqijQQjvSgGAkK387KXV9mjo8xs9tEK_jfKGocYyZzGQ@mail.gmail.com>
In-Reply-To: <CAFLszThqijQQjvSgGAkK387KXV9mjo8xs9tEK_jfKGocYyZzGQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Jun 2024 17:26:51 +0300
Message-ID: <CAC_iWj+M5uw1qaVcUFZpXDArdbF3jfJDXk1HiA1i4S2eEYbEig@mail.gmail.com>
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

On Tue, 11 Jun 2024 at 13:54, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Mon, 10 Jun 2024 at 13:13, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Tue, 4 Jun 2024 at 23:27, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> On some boards, the bloblist is created in SPL once SDRAM is ready. It
> >> cannot be accessed until that point, so is not available early in SPL.
> >>
> >> Add a condition to avoid a hang in this case.
> >>
> >> This fixes a hang in chromebook_coral
> >>
> >> Fixes: 70fe2385943 ("fdt: Allow the devicetree to come from a bloblist")
> >>
> >> Signed-off-by: Simon Glass <sjg@chromium.org>
> >> ---
> >>
> >>  lib/fdtdec.c | 12 ++++++++++--
> >>  1 file changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> >> index b2c59ab3818..b141244e3b9 100644
> >> --- a/lib/fdtdec.c
> >> +++ b/lib/fdtdec.c
> >> @@ -1669,8 +1669,16 @@ int fdtdec_setup(void)
> >>  {
> >>         int ret = -ENOENT;
> >>
> >> -       /* If allowing a bloblist, check that first */
> >> -       if (CONFIG_IS_ENABLED(BLOBLIST)) {
> >> +       /*
> >> +        * If allowing a bloblist, check that first. This would be better
> >> +        * handled with an OF_BLOBLIST Kconfig, but that caused far too much
> >> +        * argument, so add a hack here, used e.g. by chromebook_coral
> >
> > I am a bit confused by this comment - It means you will not use OF_BLOBLIST,
> > but actually you are using it below. Is it a typo?
>
> Basically it would be cleaner to have a separate, phase-specific
> Kconfig control as to whether the DT can come from the bloblist (I
> can't remember the Kconfig name I suggested, nor the patch as it was
> last year sometime). But for now I am adding this hack to get a few
> boards working again.

I am a bit confused.
First of all the comment is innapropriate. We went through a lengthy
discussion on BLOBLIST/OF_BLOSLIST etc and,  even Tom chimed in and we
made up our minds. Why are you adding this comment now? Why do code
comments have to illustrate your personal opinion -- which was
rejected?

Grepping for OF_BLOBLIST, I can't find any matches, so is the above if a typo?


Thanks
/Ilias
>
> >
> >>
> >> +        * The necessary test is whether the previous stage passed a bloblist,
> >> +        * not whether this one creates one.
> >> +        */
> >> +       if (CONFIG_IS_ENABLED(OF_BLOBLIST) &&
> >> +           (spl_prev_phase() != PHASE_TPL ||
> >> +            !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> >>                 ret = bloblist_maybe_init();
> >>                 if (!ret) {
> >>                         gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> >> --
> >> 2.34.1
> >>
> >
> > Regards,
> > Raymond
>
> Regards,
> Simon
