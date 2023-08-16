Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01352C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 14:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0718F869D3;
	Wed, 16 Aug 2023 16:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bf6rwU6B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28BB886902; Wed, 16 Aug 2023 16:40:06 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17BD18677D
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 16:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-c5f98fc4237so5032753276.2
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 07:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692196795; x=1692801595;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gah+M7570E+2fXqA97jtHJAyonEOIt0wFWnQRBXO890=;
 b=bf6rwU6BPXcVvcIJTeWwASV/3jm47wPfLAjL4EmZONDdYLFOYHo+qf1xip0gFuuN2x
 taLZ8ZdSXu7obfYKvuaMDliur59T/kpbYao3uo+HtKEeBva2nPu/1HcqI/KbClvzfiiU
 ppiudRXDug9sgsNfLkoEhmyDxoSNBKk3Bka9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692196795; x=1692801595;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gah+M7570E+2fXqA97jtHJAyonEOIt0wFWnQRBXO890=;
 b=AfS/ii6I+LHtkSAu2kWF921khQYvrmljTuQbSHGafiEmMCjPCOmr0NClaY5qV57utm
 uom22arCXm5cUe56fMJ8Ni4sd/mxxW8LtqEYNLXW/RnUdwJIKgK62RQ/ZFNN6wqyolJT
 vDrXpBgSRj1XEkX8BpbZjECP0NlYCcVfQNfTqCJLJ2hUojbs+rrePwyBQKZCbjWAZFiP
 6VrT1ZClIg4VtkYZB5vKRLfAAaCofocKmJtDf5UEx94SI8qfaHoikAIOmlvnAMkqNC6t
 iP2wd//pgFnpb/BQ/vppvzdhUlE24Z4UDvHGjU2pRpjV9KzydscqKSlyoelCDImmWgcI
 e1uQ==
X-Gm-Message-State: AOJu0YzpvUWgMJTHdL4yYx+7YgmEYUTuSowBwsd4fUqtHoXhMyLqtA7a
 aD+PRSf10srqB+CaoHPodslY/OXN+iFajvDK+Gs3og==
X-Google-Smtp-Source: AGHT+IEUnH6TQwhX1nHIvxx0rS63/ouv4cl2SoYKo4UY9sCYWD/ySGMincq+K7u5HWKOxdIzdoWqrJuCHVpVnpdoDUQ=
X-Received: by 2002:a25:42d1:0:b0:d6b:6b53:d1ab with SMTP id
 p200-20020a2542d1000000b00d6b6b53d1abmr1832280yba.38.1692196794575; Wed, 16
 Aug 2023 07:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ34z865voaKeShSJpdvWcFLbN0OEWBnus4qt0W_1P4jBw@mail.gmail.com>
 <20230816110551.86930-1-abdellatif.elkhlifi@arm.com>
 <e41876d3-7bc2-08f7-9573-0aa7e7a7153a@mailbox.org>
In-Reply-To: <e41876d3-7bc2-08f7-9573-0aa7e7a7153a@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 16 Aug 2023 08:39:26 -0600
Message-ID: <CAPnjgZ3=7oGkM_FmKc097VALOgQVfmHDqcnUfh19+-9Ccd+=pA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] log: select physical address formatting in a
 generic way
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 marek.vasut+renesas@mailbox.org, 
 nd@arm.com, trini@konsulko.com, u-boot@lists.denx.de
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

On Wed, 16 Aug 2023 at 05:13, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 8/16/23 13:05, Abdellatif El Khlifi wrote:
> > sets the log formatting according to the platform (64-bit vs 32-bit)
>
> Use imperative mood please, see
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
>
> > Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> >   cmd/armffa.c  | 8 --------
> >   include/log.h | 9 +++++++++
> >   2 files changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/cmd/armffa.c b/cmd/armffa.c
> > index 7e6eafc03a..ab0fd54d97 100644
> > --- a/cmd/armffa.c
> > +++ b/cmd/armffa.c
> > @@ -13,14 +13,6 @@
> >   #include <stdlib.h>
> >   #include <asm/io.h>
> >
> > -/* Select the right physical address formatting according to the platform */
> > -#ifdef CONFIG_PHYS_64BIT
> > -#define PhysAddrLength "ll"
> > -#else
> > -#define PhysAddrLength ""
> > -#endif
> > -#define PHYS_ADDR_LN "%" PhysAddrLength "x"
>
> Would it make sense to implement printf '%pa' formatting string instead ?

The problem is that it is not a pointer. Also we want the compiler to
check the size.

Regards,
Simon
