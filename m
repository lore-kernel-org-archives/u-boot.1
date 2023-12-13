Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF554C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 19:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D43F387852;
	Wed, 13 Dec 2023 20:52:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hkW47yhf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3A5787857; Wed, 13 Dec 2023 20:52:34 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A2A87850
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 20:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-db537948ea0so7201535276.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 11:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702497150; x=1703101950; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t0BcNri+9OqLMewU6y0G7X4aGhg9VkVZJxhdeXMyaz8=;
 b=hkW47yhfn0HuvKJcamXAN5arhxc68V13p+P3jpOd7iuhk2I+gqbTTKqPav8aFSoKkj
 teVU+dKWANjit40E3vVPoU7VfDJNVaraypgU/a45OchEA8TUY41tNcKVGP7h3K0jnXIC
 1K0o2eaUa2LmJxtV1hN+z8haaMMPyxiLbhs1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702497150; x=1703101950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t0BcNri+9OqLMewU6y0G7X4aGhg9VkVZJxhdeXMyaz8=;
 b=jKQH1CPtBoANklo3nMgxbSJZiaz3zFYYfFHC3ddyqfPYt14Nv3BQOVwO+3F+BC8z9N
 Snqde0FaEpapDYFj0ekKKpNcpOgS7JjUskpSNubKPH7pWYBV1aEr9BXyPbvimjiQ/KTA
 7oi8u2h7rZG8yOA9rFdkG1d6oLU2Xu+5JaLY7FpyC9b07vuZC/5KWqK439vtGE8TQobG
 cY2ih0PTYWY/GJfmbpGb2SJ0c2x9YF3Bic1BEEHzxydlgIybctC6/sl8YALWvPJNSNHk
 +j+VTQMtFXuLP7AAV66XajGEtWDel8LjUAvTUkrHpdMnT6eaURXNInIlWysSxwiaVl/t
 X3Bg==
X-Gm-Message-State: AOJu0YyOkPtB0evyeRNoi3NQw3+BFXaM/Iy31AjSuwsTF3D6Xi2WJdPG
 qQRbBb/nEPlHUj6Y5bs4j8dBzqyWiHWEJnYg5+xrLA==
X-Google-Smtp-Source: AGHT+IHnOajbBfClFOt27YsmHWjkqL86/kCiobe64FoUd37j0Jb3s90tb/U1QBIsa5f2PogQjCJWk9QwmphtBgQuZjk=
X-Received: by 2002:a5b:151:0:b0:dbc:692e:b08 with SMTP id
 c17-20020a5b0151000000b00dbc692e0b08mr5328702ybp.80.1702497149501; 
 Wed, 13 Dec 2023 11:52:29 -0800 (PST)
MIME-Version: 1.0
References: <20231210150304.124458-1-marek.vasut+renesas@mailbox.org>
 <CAPnjgZ10dpyK3qyoogTaabyH0sNsXRZReCGdvVhdO=0LG2DJWw@mail.gmail.com>
 <6b56dc6f-f753-4da3-b371-4a8146d3f4e9@mailbox.org>
 <CAPnjgZ1bwt8-n=saKfdcoKOx42SdE1-t36eGazaiatzn626_ww@mail.gmail.com>
 <b09c6600-b05b-4fec-beb0-c0a9a226a507@mailbox.org>
In-Reply-To: <b09c6600-b05b-4fec-beb0-c0a9a226a507@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:49:59 -0700
Message-ID: <CAPnjgZ0vjRjX3nQ+GU-vL6cgZN++szsS_ZEYXN1KXJD=Yxgyvw@mail.gmail.com>
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

On Wed, 13 Dec 2023 at 07:08, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 12/12/23 15:05, Simon Glass wrote:
> > Hi Marek,
> >
> > On Mon, 11 Dec 2023 at 12:24, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >>
> >> On 12/11/23 18:52, Simon Glass wrote:
> >>> Hi Marek,
> >>>
> >>> On Sun, 10 Dec 2023 at 08:03, Marek Vasut
> >>> <marek.vasut+renesas@mailbox.org> wrote:
> >>>>
> >>>> In case the cyclic framework is enabled, poll the card detect of already
> >>>> initialized cards and deinitialize them in case they are removed. Since
> >>>> the card initialization is a longer process and card initialization is
> >>>> done on first access to an uninitialized card anyway, avoid initializing
> >>>> newly detected uninitialized cards in the cyclic callback.
> >>>>
> >>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >>>> ---
> >>>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> >>>> Cc: Peng Fan <peng.fan@nxp.com>
> >>>> Cc: Simon Glass <sjg@chromium.org>
> >>>> ---
> >>>> V2: Move the cyclic registration/unregistration into mmc init/deinit
> >>>> V3: Replace if (CONFIG_IS_ENABLED(CYCLIC)...) with #if as the former
> >>>>       does not work with structure members
> >>>> ---
> >>>>    drivers/mmc/mmc.c | 36 ++++++++++++++++++++++++++++++++++++
> >>>>    include/mmc.h     |  5 +++++
> >>>>    2 files changed, 41 insertions(+)
> >>>>
> >>>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> >>>> index eb5010c1465..a5686dbc12e 100644
> >>>> --- a/drivers/mmc/mmc.c
> >>>> +++ b/drivers/mmc/mmc.c
> >>>> @@ -2985,6 +2985,22 @@ static int mmc_complete_init(struct mmc *mmc)
> >>>>           return err;
> >>>>    }
> >>>>
> >>>> +#if CONFIG_IS_ENABLED(CYCLIC)
> >>>> +static void mmc_cyclic_cd_poll(void *ctx)
> >>>> +{
> >>>> +       struct mmc *m = ctx;
> >>>> +
> >>>> +       if (!m->has_init)
> >>>> +               return;
> >>>> +
> >>>> +       if (mmc_getcd(m))
> >>>> +               return;
> >>>> +
> >>>> +       mmc_deinit(m);
> >>>> +       m->has_init = 0;
> >>>> +}
> >>>> +#endif
> >>>> +
> >>>>    int mmc_init(struct mmc *mmc)
> >>>>    {
> >>>>           int err = 0;
> >>>> @@ -3007,6 +3023,19 @@ int mmc_init(struct mmc *mmc)
> >>>>           if (err)
> >>>>                   pr_info("%s: %d, time %lu\n", __func__, err, get_timer(start));
> >>>>
> >>>> +#if CONFIG_IS_ENABLED(CYCLIC)
> >>>
> >>> We really shouldn't be adding new #ifdefs to the code.
> >>>
> >>> If you really want to make put ->cyclic behind an #ifdef then how
> >>> about creating an accessor as is done in global_data.h ?
> >>
> >> That's really just working around the underlying issue, which is that
> >> this does not compile:
> >>
> >> struct foo {
> >> #if CONFIG_IS_ENABLED(STUFF)
> >>     type member;
> >> #endif
> >> ...
> >> };
> >>
> >> type fn() {
> >> ...
> >> if (CONFIG_IS_ENABLED(STUFF))
> >>     access struct->member;
> >> ...
> >> }
> >>
> >> Accessor won't make it any better, would it ? It would only attempt to
> >> hide the error and make the code more fragile, i.e. this:
> >>
> >> accessor(struct)
> >> {
> >> type fn() {
> >> if (CONFIG_IS_ENABLED(STUFF))
> >>     return access struct->member;
> >> else
> >>     return 0;
> >> }
> >>
> >> }
> >>
> >> type fn() {
> >> ...
> >>     accessor(struct);
> >> ...
> >> }
> >>
> >> I suspect it also won't compile for one thing, and for the other, it
> >> really just hides the issue.
> >
> > No, I mean like this:
> >
> > #ifdef CONFIG_ACPI
> > #define gd_acpi_ctx() gd->acpi_ctx
> > #define gd_acpi_start() gd->acpi_start
> > #define gd_set_acpi_start(addr) gd->acpi_start = addr
> > #else
> > #define gd_acpi_ctx() NULL
> > #define gd_acpi_start() 0UL
> > #define gd_set_acpi_start(addr)
> > #endif
> >
> > The header file has #ifdefs but not the C files.
>
> Hmmm, I can't say I like that either, that just adds more indirection
> into the code and makes it harder to read in my opinion .

Sure, it isn't for everyone. But adding new #ifdefs is really grim
IMO. Maybe you will get used to it? Maybe there is a better approach?

Regards,
Simon
