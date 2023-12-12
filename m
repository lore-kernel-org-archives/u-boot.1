Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301F4C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 14:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3E9E874DD;
	Tue, 12 Dec 2023 15:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TGKI6ZJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D01B78760D; Tue, 12 Dec 2023 15:06:17 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD48587495
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 15:06:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c9f85eff28so85849241fa.3
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 06:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702389974; x=1702994774; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1tMOORCNOYtEIJA8dDTNDz8TejM74te+xohGNEKCi54=;
 b=TGKI6ZJpFuM7ZungVpj10KLBxIQoEtc8W9Z/I+f1vAohQD0e008m5DZE6GhXb4QMuv
 0Fz/yOGOATj30O7krnrsJDiKvdX8pjz/Bn9kV/QXJdHEKI21Kk6egoDuoCPEABHXWCZV
 etCTXUZSw95TGZH7zChJa4wuthe2CDayjyyds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702389974; x=1702994774;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1tMOORCNOYtEIJA8dDTNDz8TejM74te+xohGNEKCi54=;
 b=YGG86o9IfauFSm7gnp1TzRzGRlLGEAKmmyrKVWfMUPCdWMwNs/8sd4BPtSHXZ57f4z
 +tsFLGmnppyPgeFKnJxiDo0wOLdPNc/BHKZAlAVVrJ+penf2Mjd6QWHDsW6KtZx37epX
 fgyFrNdckoEwfIkxGXqMqefoy+D+RdauHuv8oZQLoGWIDBXO9+DqkbNukTGs6SqN2TDn
 Q6dJG/xLQJlMY9b7+mUJ/C+Zc4h5eS2ZGMps7m6y3NvaEIC5Ta2zTeoVDRj4TtqvhSeS
 CpwGYB2R5iBUGgoCt16a3B+dE6E2/v6HGiQKmnINopGrjq2pJIZrX0Ae1/r714AWIbAd
 PR9A==
X-Gm-Message-State: AOJu0Yy5Un2DdQpabYz34ZEBDdeOnwU0AcJ8fQZUXiiet7k0+uVixcLE
 ItCOpOkX46kuEYIJA5Lj3mpibL0AC+Acg5bZ3iT/t8pQsCWsecaQC6Q=
X-Google-Smtp-Source: AGHT+IH2dJRmSCKmnR0hgWA/F9+kWV6B8rQEmfyChAn5h/4EJVhyZ330zRC20EZ7iwNkeRbvp5po71WHlZ3b4iySAkU=
X-Received: by 2002:a2e:9397:0:b0:2ca:ed2:2a31 with SMTP id
 g23-20020a2e9397000000b002ca0ed22a31mr2614897ljh.52.1702389973847; Tue, 12
 Dec 2023 06:06:13 -0800 (PST)
MIME-Version: 1.0
References: <20231210150304.124458-1-marek.vasut+renesas@mailbox.org>
 <CAPnjgZ10dpyK3qyoogTaabyH0sNsXRZReCGdvVhdO=0LG2DJWw@mail.gmail.com>
 <6b56dc6f-f753-4da3-b371-4a8146d3f4e9@mailbox.org>
In-Reply-To: <6b56dc6f-f753-4da3-b371-4a8146d3f4e9@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 12 Dec 2023 07:05:59 -0700
Message-ID: <CAPnjgZ1bwt8-n=saKfdcoKOx42SdE1-t36eGazaiatzn626_ww@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: Poll CD in case cyclic framework is enabled
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Marek,

On Mon, 11 Dec 2023 at 12:24, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 12/11/23 18:52, Simon Glass wrote:
> > Hi Marek,
> >
> > On Sun, 10 Dec 2023 at 08:03, Marek Vasut
> > <marek.vasut+renesas@mailbox.org> wrote:
> >>
> >> In case the cyclic framework is enabled, poll the card detect of already
> >> initialized cards and deinitialize them in case they are removed. Since
> >> the card initialization is a longer process and card initialization is
> >> done on first access to an uninitialized card anyway, avoid initializing
> >> newly detected uninitialized cards in the cyclic callback.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> ---
> >> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> >> Cc: Peng Fan <peng.fan@nxp.com>
> >> Cc: Simon Glass <sjg@chromium.org>
> >> ---
> >> V2: Move the cyclic registration/unregistration into mmc init/deinit
> >> V3: Replace if (CONFIG_IS_ENABLED(CYCLIC)...) with #if as the former
> >>      does not work with structure members
> >> ---
> >>   drivers/mmc/mmc.c | 36 ++++++++++++++++++++++++++++++++++++
> >>   include/mmc.h     |  5 +++++
> >>   2 files changed, 41 insertions(+)
> >>
> >> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> >> index eb5010c1465..a5686dbc12e 100644
> >> --- a/drivers/mmc/mmc.c
> >> +++ b/drivers/mmc/mmc.c
> >> @@ -2985,6 +2985,22 @@ static int mmc_complete_init(struct mmc *mmc)
> >>          return err;
> >>   }
> >>
> >> +#if CONFIG_IS_ENABLED(CYCLIC)
> >> +static void mmc_cyclic_cd_poll(void *ctx)
> >> +{
> >> +       struct mmc *m = ctx;
> >> +
> >> +       if (!m->has_init)
> >> +               return;
> >> +
> >> +       if (mmc_getcd(m))
> >> +               return;
> >> +
> >> +       mmc_deinit(m);
> >> +       m->has_init = 0;
> >> +}
> >> +#endif
> >> +
> >>   int mmc_init(struct mmc *mmc)
> >>   {
> >>          int err = 0;
> >> @@ -3007,6 +3023,19 @@ int mmc_init(struct mmc *mmc)
> >>          if (err)
> >>                  pr_info("%s: %d, time %lu\n", __func__, err, get_timer(start));
> >>
> >> +#if CONFIG_IS_ENABLED(CYCLIC)
> >
> > We really shouldn't be adding new #ifdefs to the code.
> >
> > If you really want to make put ->cyclic behind an #ifdef then how
> > about creating an accessor as is done in global_data.h ?
>
> That's really just working around the underlying issue, which is that
> this does not compile:
>
> struct foo {
> #if CONFIG_IS_ENABLED(STUFF)
>    type member;
> #endif
> ...
> };
>
> type fn() {
> ...
> if (CONFIG_IS_ENABLED(STUFF))
>    access struct->member;
> ...
> }
>
> Accessor won't make it any better, would it ? It would only attempt to
> hide the error and make the code more fragile, i.e. this:
>
> accessor(struct)
> {
> type fn() {
> if (CONFIG_IS_ENABLED(STUFF))
>    return access struct->member;
> else
>    return 0;
> }
>
> }
>
> type fn() {
> ...
>    accessor(struct);
> ...
> }
>
> I suspect it also won't compile for one thing, and for the other, it
> really just hides the issue.

No, I mean like this:

#ifdef CONFIG_ACPI
#define gd_acpi_ctx() gd->acpi_ctx
#define gd_acpi_start() gd->acpi_start
#define gd_set_acpi_start(addr) gd->acpi_start = addr
#else
#define gd_acpi_ctx() NULL
#define gd_acpi_start() 0UL
#define gd_set_acpi_start(addr)
#endif

The header file has #ifdefs but not the C files.

Regards,
Simon
