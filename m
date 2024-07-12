Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD5BC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 10:21:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8A9A88009;
	Fri, 12 Jul 2024 12:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jltSMVPI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F40388667; Fri, 12 Jul 2024 12:21:31 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4932188009
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 12:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-595856e2336so3087182a12.1
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 03:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720779689; x=1721384489; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VlWO6OsxVguYbW1idGTp/TPMA7t5OLHCGmw14F9osfo=;
 b=jltSMVPIwhEl4zqukAn4MdVr8yUB8lG/647bLPNiLpB9evuTTrptwueixOUki9/qVU
 CV4H4GMng1HnlYOmgwTuan2Zwbkh8fp5LwIdXLnQovnBeXSkwadFDfON56dOVN09RxJU
 19sOPshSgoBAR4TT27NBcyPDZ/h3KlqIcy41Z6uiPzecrGKnM2MrdTLF+NhPu2cZoQIv
 ZAZxV9LgLcHV3qH48ga6/pZyN7HGP0rYCofQzj/xRbt8jwEN41Oo6dMtU2+fv9EecVg6
 mTo4rCMSvy6O1qX8/LN8arwBy88HesAWXJAY6DB+zaJIUkaO3npJemg3cSA/S6ewIHz4
 WDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720779689; x=1721384489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VlWO6OsxVguYbW1idGTp/TPMA7t5OLHCGmw14F9osfo=;
 b=brmKF7LxAL0FPitPHS7ubKRw3addEN+XvzfZBgVHGZI/SVNgJ4cZuoKpioW6/bRnFC
 an0OhGg2rgV5VLX7TmX3GNUjmrnMb2ndmFBOCzVFBD4QhijhO46eqnA66IUtIm/EnXF/
 ebd1NaDN8kuUqmzK0ZUxjVhodW8y3RsC+x/iKEFUBGvAa8u0CEzDVN7InnTVi7Owc8+c
 bsMYFAcDT0gJXIyHQaTKCKXZ0gDP41dofVukblZOUvDClkZAivobTMsQUVlinYV0PmyS
 DAaGh3NU30b/IOXuhVyOEWxqVBFZlwyWu5aKOyLDJLPFyqUQ2MsXQrTBlLngF511+Fpf
 LJ0A==
X-Gm-Message-State: AOJu0YyjXUFQHZwMYA649BWr521fkOhBjgKfB14Qm73PnPFaNE7f3w3N
 jF9d+cN8QXwMRlSJc8HIwrw/6lv+RMfmAODI162wnpO4RPJ+nGQIK3n7PpIimC+E+zdouj+0AmZ
 ArnDfOYaLTZAUMlABuMDcQYuET1aeou6K
X-Google-Smtp-Source: AGHT+IEeOwYYaZp+BMxQVr4l2C6zcMyZ8cIXZFqrC82B/RniKUtVY2zoYN3FMV1URxMOkNMi1MgxULPwZny5w/73riw=
X-Received: by 2002:a05:6402:35ce:b0:57c:bec1:ff4b with SMTP id
 4fb4d7f45d1cf-599647adfedmr2060639a12.10.1720779688448; Fri, 12 Jul 2024
 03:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240712090725.2093317-1-rasmus.villemoes@prevas.dk>
 <20240712090725.2093317-2-rasmus.villemoes@prevas.dk>
In-Reply-To: <20240712090725.2093317-2-rasmus.villemoes@prevas.dk>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 12 Jul 2024 11:21:17 +0100
Message-ID: <CALeDE9NFn8OPwzGxHKV5f1Pe0XoGwL7TjyODRe8R8itQS5487g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm: bcm283x: remove unused empty
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

On Fri, 12 Jul 2024 at 10:07, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> This empty stub was originally added as one branch of an #ifdef in
> commit 45a6d231b2f (bcm2835_wdt: support for the BCM2835/2836
> watchdog). That incarnation of the rpi watchdog driver was later
> removed in c7adc0b5f98 (watchdog: bcm2835_wdt: Remove unused BCM283x
> watchdog driver and its references), but this now unused stub was left
> behind. The later (re-)added rpi watchdog driver does not define a
> hw_watchdog_disable() function, as that is properly integrated in the
> watchdog framework.
>
> Reviewed-by: Stefan Roese <sr@denx.de>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

Thanks!

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
