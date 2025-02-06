Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CD2C02199
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 21:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FA8A80C72;
	Thu,  6 Feb 2025 22:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WsFinw+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B8880EEB; Thu,  6 Feb 2025 22:27:58 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C38980F0B
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 22:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso2217401a91.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 13:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738877274; x=1739482074; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5+Dfte3PFFIIQtI8axSf1NOIOJBrHlwdSMUf7ACqQOs=;
 b=WsFinw+PD0l9C3e6rXzgMaIn+FJyuAdLE+5SWGE7z07rYsWkLcITXK9XdY65htFM9E
 wiqndtI+FLbrvkuaa+z0smEFX6LRO8zgaie/xEXlz8INf1uMDEv/EjyLXBW6qugRqmoq
 dnukT/gdcvlBJs+dlUh0PER3ctjyYvmYQi8zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738877274; x=1739482074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5+Dfte3PFFIIQtI8axSf1NOIOJBrHlwdSMUf7ACqQOs=;
 b=ZR3vXlvZGiH84chO4LiiWiCexv+vNMPeYi45ukpUKSXqVOKN42jkC6f0g890+xC9rJ
 JoOojCfNjDuoMLBX5ESW7OmL3eq9VHzDYk7E01mzhaurX4vJVq9Z7tFCZp4Woo/TIQT6
 ec6rz3UvoSGKx0BDiAzj+cTGTIO55lNeQebOxxFdfu7jnRHD6wuOkAKN7eHiJzmBPA4f
 YUy4TQvICdB1rRy/t5OFxOOnCCEjKQHSEVD9tlKptMd8kxaDzfUggsLM32eYb3JF+C6X
 M6JPL0ulheT1yXS2GCY00nscLPGInTb6m4StPoqHWRWEcZwzxmqdyYhn9KdxiDyASRaU
 nU7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrd/vgeSpUXHtD1G/yKKLtQSgxp6sy7qXpvw6DlTfn1LgD0t1tfo0nJtshUh7RcczGGR6EvQ8=@lists.denx.de
X-Gm-Message-State: AOJu0YxO3QjXCYC6GqUOsUxWjRjZJgu/TgvChsj96Be9Rh+TvUqNBC0I
 c/iG6dxIVVsOaGH62I5NrfJ4Tx5QxOeMfmaFB7q9+abcEROkScD3HDEvehfYyHSvcYShaaMpr0m
 xLLemBeocA6u086ALMCYrc0yhWKvWIQZJ8xLd
X-Gm-Gg: ASbGncu9HnmFhJRCNtLkjEVhYAjt9yjvaP4DhHsul1K/Sa4ZbD1VLzFy/rzzFq0iTg2
 G3cvmkpiTF45x+0WAgljsC2QzaCnOrGzBE7IWvuMncMlDJeIuCS3PgwKlm7BWwD+9stndGl6Irg
 ==
X-Google-Smtp-Source: AGHT+IHZBzy4TTLyPSO+qyxn9AYttyFZ9W2OlJXd3yWddnAL8NuabVp/ZU/r1xGAPZ6yV58kTJZXINSlzE6/aMv1uuA=
X-Received: by 2002:a05:6a00:9283:b0:72a:bcc2:eefb with SMTP id
 d2e1a72fcca58-7305d421c08mr1039339b3a.2.1738877274137; Thu, 06 Feb 2025
 13:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-17-sjg@chromium.org>
 <20250203200919.GJ1233568@bill-the-cat>
In-Reply-To: <20250203200919.GJ1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 14:27:34 -0700
X-Gm-Features: AWEUYZmNm4ZcMBeUKQuTW9QWU-5IazwUcIDCd6_PfPqfO5wSRDRxJ2Iyh0SfXss
Message-ID: <CAFLszTggumhnw4PajCXRSr0fFshBP04bo9WeW0kHm-dV31cdgA@mail.gmail.com>
Subject: Re: [PATCH 16/32] efi: arm: Don't do the EL2 switch when running
 under EFI
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Janne Grunau <j@jannau.net>
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

Hi Tom,

On Mon, 3 Feb 2025 at 13:09, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Feb 03, 2025 at 10:42:09AM -0700, Simon Glass wrote:
>
> > The previous bootloader has likely done this already, so avoid trying to
> > do it again. This fixes a crash in QEMU when booting from EDK2
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  arch/arm/lib/bootm.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
> > index 974cbfe8400..688c2f3f29b 100644
> > --- a/arch/arm/lib/bootm.c
> > +++ b/arch/arm/lib/bootm.c
> > @@ -16,6 +16,7 @@
> >  #include <command.h>
> >  #include <cpu_func.h>
> >  #include <dm.h>
> > +#include <init.h>
> >  #include <log.h>
> >  #include <asm/global_data.h>
> >  #include <dm/root.h>
> > @@ -186,8 +187,10 @@ __weak void setup_board_tags(struct tag **in_params) {}
> >  #ifdef CONFIG_ARM64
> >  static void do_nonsec_virt_switch(void)
> >  {
> > -     smp_kick_all_cpus();
> > -     dcache_disable();       /* flush cache before swtiching to EL2 */
> > +     if (ll_boot_init()) {
> > +             smp_kick_all_cpus();
> > +             dcache_disable();       /* flush cache before swtiching to EL2 */
> > +     }
> >  }
> >  #endif
>
> Since Marek just did a bunch of work around "use U-Boot for all ELs" I
> wonder if there's something cleaner / different we should be doing here?

It's certainly possible, but I'm not sure what that would look like.

Regards,
Simon
