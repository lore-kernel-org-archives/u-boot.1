Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E5BC19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35BD8811B2;
	Thu, 27 Feb 2025 17:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bPWboeFC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F23A5812C0; Thu, 27 Feb 2025 17:27:26 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CFA1810F5
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2feb91a25bdso292931a91.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740673643; x=1741278443; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j3QPDcPacd3EtbyUCaoI0oct/VB010BbxH0t1N2UT0s=;
 b=bPWboeFCL5ZNpLYOfr1FECtk0X1LvgGZQzQzi2DDBEjuaVKYnxJXqOc7uYEBUY1UHK
 7Xt6NYfJdpOC7UoGlL59fotQlQ0kIsjgVX0ONB2ExQtcGB9tYaWKHKmCQyuOKeFxR2g7
 +uNfbTK04pKAmJXcKbKD1N06Kjc+vd8dR+XSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673643; x=1741278443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j3QPDcPacd3EtbyUCaoI0oct/VB010BbxH0t1N2UT0s=;
 b=Wo2o8EUMTs1caKbaFKNhnhaQq2enP36YwA6+xz7Ulo53Xk0hiJOTpF+BUe1dsTG1eJ
 JH8Ac1IGkLoTM0c6SzO8YAs1fH4Aft1H9Z9+b7L/xXAV/dH05qOWYBGjKOvRMmE4uSw5
 TlojczqbInH36Wi1nn/eFBP+boY0hmD4J5BDEN3W8vFIjyFIEjDKAL+ZhBgD+Kr7pRXv
 DvSKnjcQNfj8F+i02mdBQG1wuiS6PS4eGm0+loBoY7nRIB7pSfxax4NPeur7BIoV82Kw
 E7IkMU84+vTWj5f0qhNC1FAZ5ZRu9jW2EikL1LWGNtH0qbUT2jiIzrjkwzbSIpEDqGp7
 m/4A==
X-Gm-Message-State: AOJu0Yy8Phe51dCBhRrr+sTcMwHh+WhS3/wf1FgVSucEdVVoiXsOlrHw
 F9XO/a9Dc7HewZV5RSvpTuzRM9qOxP8UH7002ATu+oBiWNFCBRFiqDMoV2cfeb+tGkhdAHN2bU/
 RZeQDdZOWR0pE361XvQzvKQxN46f8y0Jt9wktvLi1ZWR/nKk=
X-Gm-Gg: ASbGnct3veApUlMo33OzG8RFy9DVALYQRYw3eip6abBI3hBgD/qHHY+qgxWZn8hxV96
 yFmQfNVT25U3UaQKByXJZ02WlpSb2Iodj5v1x6/z76nxR0SWq0Mz22dH1Rlyakd4maUqrZGsPgR
 p7eOWmaR9E
X-Google-Smtp-Source: AGHT+IFr8FfGydhiZecYUPOOZKSgorxYnp95hyyWiWhwy2y9el/6H9mx1qvC5hahx3eYhlZDG/83+oOgDibAVPbfB4M=
X-Received: by 2002:a17:90a:da87:b0:2fe:b799:77dc with SMTP id
 98e67ed59e1d1-2feb7997961mr1308021a91.9.1740673643158; Thu, 27 Feb 2025
 08:27:23 -0800 (PST)
MIME-Version: 1.0
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-4-sjg@chromium.org>
 <c24f369c-e675-4095-bcc8-6e17f5df2162@kwiboo.se>
In-Reply-To: <c24f369c-e675-4095-bcc8-6e17f5df2162@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Feb 2025 09:26:51 -0700
X-Gm-Features: AQ5f1JpEnB9bg4HZl-IoCf6yu7xvP8-Trn41DiUHLinjQW6NclSm1QQI8xvoTh4
Message-ID: <CAFLszTj3gLkrbfRoPPVjX7gtGTc5VhChZKbrgQpO5NjDWZcGZg@mail.gmail.com>
Subject: Re: [PATCH v2 03/35] spl: Use CONFIG_VAL() to obtain the SPL stack
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Leo <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>
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

Hi Jonas,

On Mon, 17 Feb 2025 at 14:17, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-02-09 22:14, Simon Glass wrote:
> > Now that we have the same option for SPL and VPL, simplify the logic for
>
> I suspect you mean TPL here?

Yes

>
> > determining the initial stack.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Suggested-by: Tom Rini <trini@konsulko.com>
> > ---
> >
> > Changes in v2:
> > - Add new patch to use CONFIG_VAL() to obtain the SPL stack
> >
> >  arch/arm/cpu/armv7/lowlevel_init.S | 4 ++--
> >  arch/arm/cpu/armv7/start.S         | 4 ++--
> >  arch/arm/lib/crt0.S                | 6 ++----
> >  arch/arm/lib/crt0_64.S             | 6 ++----
> >  arch/riscv/cpu/start.S             | 4 ++--
> >  5 files changed, 10 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv7/lowlevel_init.S b/arch/arm/cpu/armv7/lowlevel_init.S
> > index c2a0fe061a3..72b7b7d082c 100644
> > --- a/arch/arm/cpu/armv7/lowlevel_init.S
> > +++ b/arch/arm/cpu/armv7/lowlevel_init.S
> > @@ -26,8 +26,8 @@ WEAK(lowlevel_init)
> >       /*
> >        * Setup a temporary stack. Global data is not available yet.
> >        */
> > -#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
> > -     ldr     sp, =CONFIG_SPL_STACK
> > +#if CONFIG_IS_ENABLED(HAVE_INIT_STACK)
> > +     ldr     sp, =CONFIG_VAL(STACK)
> >  #else
> >       ldr     sp, =SYS_INIT_SP_ADDR
> >  #endif
> > diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
> > index 3394db46953..959251957de 100644
> > --- a/arch/arm/cpu/armv7/start.S
> > +++ b/arch/arm/cpu/armv7/start.S
> > @@ -279,8 +279,8 @@ ENTRY(cpu_init_cp15)
> >       orr     r2, r4, r2              @ r2 has combined CPU variant + revision
> >
> >  /* Early stack for ERRATA that needs into call C code */
> > -#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
> > -     ldr     r0, =(CONFIG_SPL_STACK)
> > +#if CONFIG_IS_ENABLED(HAVE_INIT_STACK)
> > +     ldr     r0, =CONFIG_VAL(STACK)
> >  #else
> >       ldr     r0, =(SYS_INIT_SP_ADDR)
> >  #endif
> > diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
> > index 007e89407a8..8ef18ce17e4 100644
> > --- a/arch/arm/lib/crt0.S
> > +++ b/arch/arm/lib/crt0.S
> > @@ -100,10 +100,8 @@ ENTRY(_main)
> >   * Set up initial C runtime environment and call board_init_f(0).
> >   */
> >
> > -#if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_HAVE_INIT_STACK)
> > -     ldr     r0, =(CONFIG_TPL_STACK)
> > -#elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
> > -     ldr     r0, =(CONFIG_SPL_STACK)
> > +#if CONFIG_IS_ENABLED(HAVE_INIT_STACK)
> > +     ldr     r0, =CONFIG_VAL(STACK)
>
> This changes behavior, prior to this the the SPL_STACK would be fallback
> for TPL. Now this will only fallback to SYS_INIT_SP_ADDR. Is this
> intentional and/or will this affect any board?

I didn't see that, actually. But I think it is a bug, so yes my change
is intentional. I'll update the commit message.

>
> >  #else
> >       ldr     r0, =(SYS_INIT_SP_ADDR)
> >  #endif
> > diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
> > index 1b6782b06ed..30950ddaf9b 100644
> > --- a/arch/arm/lib/crt0_64.S
> > +++ b/arch/arm/lib/crt0_64.S
> > @@ -69,10 +69,8 @@ ENTRY(_main)
> >  /*
> >   * Set up initial C runtime environment and call board_init_f(0).
> >   */
> > -#if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_HAVE_INIT_STACK)
> > -     ldr     x0, =(CONFIG_TPL_STACK)
> > -#elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
> > -     ldr     x0, =(CONFIG_SPL_STACK)
> > +#if CONFIG_IS_ENABLED(HAVE_INIT_STACK)
> > +     ldr     x0, =CONFIG_VAL(STACK)
>
> Same here, this changes behavior and should be mentioned in the commit
> message.
>
> Also this and two preceding patches deserve their own series, especially
> since this changes behavior.

OK

>
> Regards,
> Jonas
>
> >  #elif defined(CONFIG_INIT_SP_RELATIVE)
> >  #if CONFIG_POSITION_INDEPENDENT
> >       adrp    x0, __bss_start     /* x0 <- Runtime &__bss_start */
> > diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
> > index c8526dd82fd..7bafdfd390a 100644
> > --- a/arch/riscv/cpu/start.S
> > +++ b/arch/riscv/cpu/start.S
> > @@ -90,8 +90,8 @@ _start:
> >   * Set stackpointer in internal/ex RAM to call board_init_f
> >   */
> >  call_board_init_f:
> > -#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
> > -     li      t0, CONFIG_SPL_STACK
> > +#if CONFIG_IS_ENABLED(HAVE_INIT_STACK)
> > +     li      t0, CONFIG_VAL(STACK)
> >  #else
> >       li      t0, SYS_INIT_SP_ADDR
> >  #endif
>

Regards,
Simon
