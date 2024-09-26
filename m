Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4270CDE03C
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:10:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F8A788F44;
	Fri, 27 Sep 2024 00:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z3D4MOdn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2E6188F44; Fri, 27 Sep 2024 00:10:17 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7890788F4D
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-45821eb62daso8279971cf.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388612; x=1727993412; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kNB6wTA65HFqoMPZawibPuTYeldhQEjRFDCjLHOY++8=;
 b=Z3D4MOdnjjtcdKMbRbPMV05lydKa0ScFGPQ4proK6BHy7qkRcor2qh0Sbz60i9aPpB
 Op/7QTRxnhZBKuTrRcVYuCeQ6UA74x5tHswU0IM/D+PUzXmZqb1sQwjGnyL2CItg5PeJ
 DExUz70PrGBS8L+odLxyk4qI8Tu73LuwbyXH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388612; x=1727993412;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kNB6wTA65HFqoMPZawibPuTYeldhQEjRFDCjLHOY++8=;
 b=i/cM7KmoctHORSIQJi81xUxZSL2+/LisoeaJ9SwCqn9L8qPeqhey13+lqDIWNQlCk9
 sl7+24ezEdtJ7RSCg8ZgV/dgCJ3IWtpZYNIlIU5tawR+tfjVmwlvbrZGYw4h1uji0APw
 KhwOHK7OtGlZRfLNHAyZmJzo1vW5uI3jIP85VB+HfdLilu7qn2ecf/mAWKQIJcA+BW0D
 ZHtm444EBSSAKqDGcxukxVikPM+YTgrsYadBzk9xlkblvM37/Fbrr1FKHihTRfzF0ILi
 oi4NO8+U6DeBDHkhQuYSdZ2m1Cmhb/loO65xgmwpTaQ2uf8OuPTkWe9r1fNH2PM8dc4X
 6jpw==
X-Gm-Message-State: AOJu0Yw7cbquTnbIbKElxOYr0tiLgWdZBuLgMRT/KLhT4bI0o9yctkWW
 erCPq3Gp4a2TqeVSgQf/KgGe2bnS8vner2JAnVqohcljvniSriCSwSXiY+RRaP4TpY/aMmseaql
 LbVIVFbcqYm7SGIVxjUWM3pdedUk7yTWK+Fks
X-Google-Smtp-Source: AGHT+IENZm//9LJ+Es1LGptjpiM/B3OFlLiKr57wVS8oVvXa1gcIQ/7572luCuQ7RuX5kUuVbow6AfYA/OczVgESsos=
X-Received: by 2002:a05:6214:5990:b0:6cb:3925:ec95 with SMTP id
 6a1803df08f44-6cb3b66d1a1mr12461026d6.53.1727388612361; Thu, 26 Sep 2024
 15:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240926204455.963584-1-sjg@chromium.org>
 <20240926204455.963584-20-sjg@chromium.org>
 <68dfb206-92c8-4016-ade6-007ad8830667@denx.de>
In-Reply-To: <68dfb206-92c8-4016-ade6-007ad8830667@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Sep 2024 00:10:00 +0200
Message-ID: <CAFLszTjcF4CvSeqLn2Ng-VhpmKqHBdO7BOmHGHUY6KOW7-CGtA@mail.gmail.com>
Subject: Re: [PATCH 19/27] mx23_olinuxino: Drop status-LED code
To: Marek Vasut <marex@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

On Thu, 26 Sept 2024 at 23:40, Marek Vasut <marex@denx.de> wrote:
>
> On 9/26/24 10:44 PM, Simon Glass wrote:
> > This is not used anymore, so drop it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   board/olimex/mx23_olinuxino/mx23_olinuxino.c | 7 -------
> >   1 file changed, 7 deletions(-)
> >
> > diff --git a/board/olimex/mx23_olinuxino/mx23_olinuxino.c b/board/olimex/mx23_olinuxino/mx23_olinuxino.c
> > index b2bb6678c23..78136c1620a 100644
> > --- a/board/olimex/mx23_olinuxino/mx23_olinuxino.c
> > +++ b/board/olimex/mx23_olinuxino/mx23_olinuxino.c
> > @@ -13,9 +13,6 @@
> >   #include <asm/arch/imx-regs.h>
> >   #include <asm/arch/clock.h>
> >   #include <asm/arch/sys_proto.h>
> > -#ifdef CONFIG_LED_STATUS
> > -#include <status_led.h>
> > -#endif
> >   #include <linux/delay.h>
> >
> >   DECLARE_GLOBAL_DATA_PTR;
> > @@ -61,9 +58,5 @@ int board_init(void)
> >       /* Adress of boot parameters */
> >       gd->bd->bi_boot_params = PHYS_SDRAM_1 + 0x100;
> >
> > -#if defined(CONFIG_LED_STATUS) && defined(CONFIG_LED_STATUS_BOOT_ENABLE)
> > -     status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_STATE);
> > -#endif
> Why not define the GPIO LED in DT, it might even already be defined there.

Yes I see it in the DT for quite a few boards, so that's what we should use.

Regards,
Simon
