Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078A7C3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 07:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 297B888792;
	Thu, 11 Jul 2024 09:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FD6xehGR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4174B8874F; Thu, 11 Jul 2024 09:54:45 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B31B88792
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 09:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-58f9874aeb4so789138a12.0
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 00:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720684482; x=1721289282; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z0ljXH81U+7qGEotX+5WnyS1T3YANx6bAf4KpiNVVeY=;
 b=FD6xehGRBtyFzezDDSlo5Bgeyh6XyTLnh7Uh+NmKlMOakTGx7WLy+xUIixoL0/u7pu
 8Oet6kkyQEL3EGKP++VNzoXRp/AtB2c3GiV41Q/DszKZqDJdeVJXlp0pN1rg0ed8XdQA
 mST+BJyOgYmLtdXFRrbehK5zBsPUNVxKmWZ/4P/nnu8CoeZhAxX9QKcPemII0+Z4kL4Y
 4qi8ysq999C0PQ35aRHHREV2njLj+1DeEJOnkTAiZ2ytMTjcPK8Q1bzoMGgy/MvmwJZ4
 6EkxYGhpxtZHAYokogZxiahUM5kQNepk0qe7TNcERRT/VPjq27nsA47lztA1wpP8rvGO
 n+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720684482; x=1721289282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z0ljXH81U+7qGEotX+5WnyS1T3YANx6bAf4KpiNVVeY=;
 b=tgHG4ZUTJ593YedsryIWjc+/GA6DmMz1ItdqvU9Puh3ffjs0smgyAyQMquLzvGDZ6Q
 OtNzbwqSM7zUUqc7/B3yYwvGI4pySLDEfL9a4KLQ3yhdwPSCKEOY3mZD+iwZtiW3C4Ht
 kz9mRiSbLXWsA334NxMt4/vrt4AMX/0bFlEIIXp3T4+EY6y54IKC1tBlsS/8ZlmZ10zu
 z3fBcTwT75FFlE2MJwMBPRXctkFKPEjroLiBSspLIZ1ceg1JSn/8mcEII7cQn/+SuNnu
 m/juaSOy/UpdD8zKs7q/WW/p6xQgMZZe+EsB70Gb20HxTf/JNGkdAFhzGI8pSLzGxxEf
 pn2g==
X-Gm-Message-State: AOJu0YyGprU6odwE+UsKO/6gb+uoVsq1YRbBwfL7SwNjhT1Fg3Va5BAh
 ryjtUrCStumQMog+8RSyny+LF0/j7VezGoZA5vXuZrJSN1V3aHlS+qs3AZete9Np0udGcHnD4Zl
 PxmIwum95Zy7WHuixGlcchacdPUQ=
X-Google-Smtp-Source: AGHT+IGQVM+RNM24renLRwo7f1Gp//BOf3WxaZ/AOEbaeMNsjukpkqKAjlWlyVDHU/TgTvRykFsf1BHUOJtDMgzvl7I=
X-Received: by 2002:a05:6402:1e89:b0:582:7e6d:6816 with SMTP id
 4fb4d7f45d1cf-594ba98f460mr5677910a12.8.1720684481499; Thu, 11 Jul 2024
 00:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240710211730.2635847-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20240710211730.2635847-1-rasmus.villemoes@prevas.dk>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 11 Jul 2024 08:54:30 +0100
Message-ID: <CALeDE9NVen4Zd7Vv8c8hQwqGXPqCKrSniUaJinSXzSrzSM3syw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: bcm283x: remove pointless empty
 hw_watchdog_disable
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>
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

On Wed, 10 Jul 2024 at 22:17, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> This empty stub was originally added as one branch of an #ifdef in
> commit 45a6d231b2f (bcm2835_wdt: support for the BCM2835/2836
> watchdog). That incarnation of the rpi watchdog driver was later
> removed in c7adc0b5f98 (watchdog: bcm2835_wdt: Remove unused BCM283x
> watchdog driver and its references), but this now-pointless stub was

You don't need a - in "now-pointless" and I think "now unused" is a
better term, please update the subject too.

> left behind. The later (re-)added rpi watchdog driver does not define
> a hw_watchdog_disable() function, as that is properly integrated in
> the watchdog framework (i.e. not of the hw_* kind).
>
> Since it wasn't declared static, the compiler cannot even elide
> it (though it does get inlined into the caller here, and the
> out-of-line definition does get gc'ed by the linker).

All the things in () don't add value to this, please remove them.

> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  arch/arm/mach-bcm283x/reset.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-bcm283x/reset.c b/arch/arm/mach-bcm283x/reset.c
> index 9199234917f..1dc7ce50d1d 100644
> --- a/arch/arm/mach-bcm283x/reset.c
> +++ b/arch/arm/mach-bcm283x/reset.c
> @@ -25,8 +25,6 @@
>  /* max ticks timeout */
>  #define BCM2835_WDOG_MAX_TIMEOUT       0x000fffff
>
> -void hw_watchdog_disable(void) {}
> -
>  __efi_runtime_data struct bcm2835_wdog_regs *wdog_regs;
>
>  static void __efi_runtime
> @@ -34,10 +32,9 @@ __reset_cpu(struct bcm2835_wdog_regs *wdog_regs, ulong ticks)
>  {
>         uint32_t rstc, timeout;
>
> -       if (ticks == 0) {
> -               hw_watchdog_disable();
> +       if (ticks == 0)
>                 timeout = RESET_TIMEOUT;
> -       } else
> +       else
>                 timeout = ticks & BCM2835_WDOG_MAX_TIMEOUT;
>
>         rstc = readl(&wdog_regs->rstc);
> --
> 2.45.2
>
