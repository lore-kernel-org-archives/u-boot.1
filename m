Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4A1C83F12
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 14:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30742865A0;
	Thu, 31 Aug 2023 16:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="df8a8Gvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A70CF865A2; Thu, 31 Aug 2023 16:35:37 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E666C8659C
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 16:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4020b88bd03so8811915e9.3
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693492534; x=1694097334; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0MR6viG98veKGXMSit7+kQzC+Z6sABV5/uXFVJwYIYg=;
 b=df8a8Gvf8eDeVV8lcn+0ROk8DC1OHkfE3SES+hJCoGLJhVocM21q17FWNoLSZwar4i
 oB51Iw8nga4NpK+a5Ub9QGonWU0oEFFddBzRQPQKWx2PTlOwslrpEKpKG5GSXT0OSu5x
 KJBBqMpzhw4+dKFLhnMZej6KNHeUyWCXnxHKRZG4FgPAOQGnGhc47gEU1hApT2a4v2BP
 7Zvfpc4y5LFeNJSiKXnHYKZg6JEdd/jRcsiIWUGKtULbSfhO3fWSJSzdL4SE7Sbo2/L/
 gREBwrexrxESdtAikCt3pdbcMnlqWpPlVgg/KtOn8iahqRl0ZMiXttfIkK1S0wyUFcOh
 13jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693492534; x=1694097334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0MR6viG98veKGXMSit7+kQzC+Z6sABV5/uXFVJwYIYg=;
 b=C5tb5zOoEcP+h3A3WRARPh/VUD9DPpCo3QgSzviMXd+YpY6i+Oe2mzr5fmN85HeZNJ
 Je/P752ZWBZj9JleAkplRnaUWUQekiBYyRzDbsaSe7ezyUFfTCkn8tQ85TQqfz/tLNO4
 zS2hcX4u1cD6WslLIALG2/ZVJY8NDo0pqrgp7B+hpFey+C3GBq5ubjn9oLMj4BDmzSKl
 joH4k0Dv9BSMYeErfqTId6ZM9Ym+0Z4dmePO/yWgaB0s0gjI+xImD3FUCnVQwt9ok2zI
 HGyScDSpLVI93qAEpmHbRzLfq2toPoxQUqre8DuL07vlyPzjL82XA1tjhdJXs4UVCgvb
 Vnog==
X-Gm-Message-State: AOJu0YzG0r1XPknhyjef6kTA04nKvxaxJxTdapVTs9XQ/OPGMdMxMh8f
 l8QkH+REjL0OaqCBU1BQIAH6pL61RK+la0Gx2Tgnig==
X-Google-Smtp-Source: AGHT+IHAmq+Mu1f6CSB8cx5zae/Zxt5Uq6//Yw1abhrIRjK83I+Donbcm2lRMLtli5MGTSRlwQxJ2Z8ppkc2lNusw/c=
X-Received: by 2002:a05:600c:2256:b0:400:6bee:f4fe with SMTP id
 a22-20020a05600c225600b004006beef4femr4274869wmm.21.1693492534214; Thu, 31
 Aug 2023 07:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230822075112.717992-1-bhupesh.sharma@linaro.org>
 <20230822075112.717992-3-bhupesh.sharma@linaro.org>
 <20230830185205.GA1149416@bill-the-cat>
 <0de1f4aa-a8be-805e-8260-6178b1368ab4@amd.com>
 <20230831133102.GO3101304@bill-the-cat>
In-Reply-To: <20230831133102.GO3101304@bill-the-cat>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date: Thu, 31 Aug 2023 20:05:22 +0530
Message-ID: <CAH=2Ntxvw8sjeFWkKAqryxo01cFZ7ni0yNzB+SAHcZ_YDgUGtw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] armv8: Disable SYS_DCACHE_OFF & SYS_ICACHE_OFF for
 ARM64
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, sjg@chromium.org,
 bhupesh.linux@gmail.com, Peng Fan <peng.fan@nxp.com>
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

On Thu, 31 Aug 2023 at 19:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 31, 2023 at 10:24:07AM +0200, Michal Simek wrote:
> >
> >
> > On 8/30/23 20:52, Tom Rini wrote:
> > > On Tue, Aug 22, 2023 at 01:21:12PM +0530, Bhupesh Sharma wrote:
> > >
> > > > Ideally SYS_ICACHE_OFF and SYS_DCACHE_OFF should never be set for
> > > > ARM64 (ARMv8) platforms, as it makes booting u-boot slower on these
> > > > platforms.
> > > >
> > > > However, if some platforms require ICACHE or DCACHE  to be disabled
> > > > only for the smaller SPL stage, we should support such configurations
> > > > in u-boot as well.
> >
> > I am missing the reason why this change should be accepted.
> >
> > > >
> > > > Compile-tested for:
> > > > - qemu arm64
> >
> > qemu doesn't model caches that's why I don't think it is relevant here.
> >
> > > > - imx8
> > > > - stm32
> > > >
> > > > and run-tested on:
> > > > - Qualcomm RB3 platform
> > > >
> > > > Cc: Tom Rini <trini@konsulko.com>
> > > > Cc: Simon Glass <sjg@chromium.org>
> > > > Cc: Peng Fan <peng.fan@nxp.com>
> > > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > >   arch/arm/Kconfig            | 2 ++
> > > >   arch/arm/cpu/armv8/Makefile | 4 ++--
> > > >   2 files changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > > index 36ee1e9a3c..92bff715e3 100644
> > > > --- a/arch/arm/Kconfig
> > > > +++ b/arch/arm/Kconfig
> > > > @@ -141,6 +141,7 @@ config THUMB2_KERNEL
> > > >   config SYS_ICACHE_OFF
> > > >           bool "Do not enable icache"
> > > > + depends on !ARM64
> > > >           help
> > > >             Do not enable instruction cache in U-Boot.
> > > > @@ -153,6 +154,7 @@ config SPL_SYS_ICACHE_OFF
> > > >   config SYS_DCACHE_OFF
> > > >           bool "Do not enable dcache"
> > > > + depends on !ARM64
> > > >           help
> > > >             Do not enable data cache in U-Boot.
> > > > diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
> > > > index bba4f570db..0d0c1728e4 100644
> > > > --- a/arch/arm/cpu/armv8/Makefile
> > > > +++ b/arch/arm/cpu/armv8/Makefile
> > > > @@ -5,13 +5,13 @@
> > > >   extra-y := start.o
> > > > +obj-y    += cache_v8.o
> > > >   obj-y   += cpu.o
> > > >   ifndef CONFIG_$(SPL_TPL_)TIMER
> > > >   obj-$(CONFIG_SYS_ARCH_TIMER) += generic_timer.o
> > > >   endif
> > > >   ifndef CONFIG_$(SPL_)SYS_DCACHE_OFF
> > > > -obj-y    += cache_v8.o
> > > > -obj-y    += cache.o
> > > > +obj-y  += cache.o
> > > >   endif
> > > >   ifdef CONFIG_SPL_BUILD
> > > >   obj-$(CONFIG_ARMV8_SPL_EXCEPTION_VECTORS) += exceptions.o
> > >
> > > I'm adding Michal here because this changes the behavior on xilinx
> > > platforms that had the icache off.  I was under the impression that at
> > > the levels U-Boot runs at on aarch64, we just couldn't have
> > > icache/dcache off, but I guess that's wrong?
> > >
> >
> > yes. We are using icache off for mini u-boot configurations for quite a long
> > time. I tried to find out any commit why we started to use it but didn't
> > find any record. But will ask team to retest that use cases to see if that
> > is working or not.
> > In our case we are using small full U-Boot not any SPL variant.
> >
> > My biggest issue with the patch is that it is not clear what issue it is
> > trying to solve as I have mentioned above.
> > It just says that ideally icache/dcache should be on. If you want to enforce
> > it on your platform you can select it when that platform is selected and
> > don't need enforce it for other platforms.
>
> Thanks Michal. Bhupesh, I was wrong in v1, having caches off is allowed,
> so you just need to fix issues like part one does where code doesn't
> compile when the options are disabled, and then are there further
> changes needed for your usecase?

Sure Tom. I will go back to sending v1 as v3 with some minor changes.

Thanks,
Bhupesh
