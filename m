Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB10EE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 15:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61630803AC;
	Wed, 11 Dec 2024 16:54:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m56zI7f0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B934E80327; Wed, 11 Dec 2024 16:54:28 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65E0780371
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:54:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-724d23df764so6301073b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733932465; x=1734537265; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o5GzmLQrT0Zh4wzIKqtQe0uZdJ+6S2+nfqcG/boISVw=;
 b=m56zI7f0MYmms2A1/I90LhxTNP93rLBv9obatcL1wSVN9N6/qFZ4UUOvVeo+pSN8Z8
 hKCifpJkeRniq5QhOkYTVLgZbFMkOtNG3nc8Swr2rvkW/jGmwmWRzuIrGvRJtwfeBO52
 mmBzSuBHTyNSqa6R4KBbVx32xgVSUpQOEdt/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932465; x=1734537265;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o5GzmLQrT0Zh4wzIKqtQe0uZdJ+6S2+nfqcG/boISVw=;
 b=WPHQ/ofGxNR6EcbAxyJKeyQWVjf0i02Mq3Q7tRIBSIYPgNOauly3VqZ4N3IOYaiF97
 vlEIXLLI4KeU/iE8jLs2LmO4F/pEKtIeAHqaz7nW10lKyBwk5u3nM9FakdMXdZVlWsHV
 nSiX81Dv1+TyFtV29mCQSQG8TUC/EODz/ywWJbZvwM8/sfibrpMOfD6Jf83Nm9D/aLFH
 /AL8J0qGqs8LCdIuX1G5se/CU/TXqcR4ce5f0zePrqAP+CHYvN4Ss1buoqBms1FMHLIw
 g0YuWKJwa1WL2uXA38SDVD1zbi5ue2w9InSQ4JpSF0nTI6R2hVDNYEq3ii/y1YtnmG6E
 s+Og==
X-Gm-Message-State: AOJu0YwhcquQKFITjVLEhBW+88M8bRzzawL8tHPymlYyNTNOyx+lgUtY
 cXBL1LwNVIevTIOO94cg6+mxOtRx3jWUNwP9DxCBfGvA5Nqz4a3Wlj+7mTfI8RJpb+g5opmIys2
 A7yNw7w7cchMnctevgEQEY+MjAkODCqhUlAHw
X-Gm-Gg: ASbGncs8G/3Exto160CBLkFXLM2/kuFpZWf5Fx/3lZWSE9ip0Pl9wJP2ynoyqf65aGp
 1vQoyitmW4lqxQZnpkFTfPnAYoGIqMLVXNadH
X-Google-Smtp-Source: AGHT+IGNWpu1QZovx9x/tByA5hUgcNFo3k+AbzvARLZEJJ0/xGbIB4LRuUMlbP2IpsPZIp1AzD4xlnV5qw4oYnkG574=
X-Received: by 2002:a05:6a20:728f:b0:1dc:e8d:c8f0 with SMTP id
 adf61e73a8af0-1e1cdb20db5mr588669637.29.1733932464788; Wed, 11 Dec 2024
 07:54:24 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-19-sjg@chromium.org>
 <CAC_iWj+warnOCWhpp9H4-AUc70Ft-6jRM9tRcZ3yVTKJ1_88FA@mail.gmail.com>
In-Reply-To: <CAC_iWj+warnOCWhpp9H4-AUc70Ft-6jRM9tRcZ3yVTKJ1_88FA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Dec 2024 08:54:11 -0700
Message-ID: <CAFLszTgT0tE=fU2W__n1Kz_yoAE32wnMcVOEb99XG4EZCzP3TQ@mail.gmail.com>
Subject: Re: [PATCH v5 18/23] efi_loader: Don't try to add sandbox runtime code
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Wed, 11 Dec 2024 at 08:19, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> >
> > This cannot work since the code is not present in the emulated memory.
> > In any case, sandbox cannot make use of the runtime code.
> >
> > For now, just drop it from sandbox. We can always adjust things to copy
> > it into memory, if needed.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  lib/efi_loader/efi_memory.c | 26 ++++++++++++++++----------
> >  1 file changed, 16 insertions(+), 10 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index 0f149f99c7d..6475b94f951 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -767,16 +767,22 @@ static void add_u_boot_and_runtime(void)
> >         runtime_mask = SZ_64K - 1;
> >  #endif
> >
> > -       /*
> > -        * Add Runtime Services. We mark surrounding boottime code as runtime as
> > -        * well to fulfill the runtime alignment constraints but avoid padding.
> > -        */
> > -       runtime_start = (uintptr_t)__efi_runtime_start & ~runtime_mask;
> > -       runtime_end = (uintptr_t)__efi_runtime_stop;
> > -       runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
> > -       runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
> > -       efi_add_memory_map_pg(runtime_start, runtime_pages,
> > -                             EFI_RUNTIME_SERVICES_CODE, false);
>
>
> Can sandbox boot an OS? If not there's no point adding this. But if
> you insist, I prefer

No sandbox can't really boot an OS. The primary reason for this change
is to avoid strange things appearing in the EFI memory map (and
therefore the EFI log). I found it very confusing.

> if (IS_ENABLED(CONFIG_SANDBOX)
>     return
>
> at the top of the function

OK

>
> Thanks
> /Ilias
>
> > +       if (!IS_ENABLED(CONFIG_SANDBOX)) {
> > +               /*
> > +                * Add Runtime Services. We mark surrounding boottime code as
> > +                * runtime as well to fulfill the runtime alignment constraints
> > +                * but avoid padding.
> > +                *
> > +                * This is not enabled for sandbox, since we cannot map the
> > +                * sandbox code into emulated SDRAM
> > +                */
> > +               runtime_start = (uintptr_t)__efi_runtime_start & ~runtime_mask;
> > +               runtime_end = (uintptr_t)__efi_runtime_stop;
> > +               runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
> > +               runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
> > +               efi_add_memory_map_pg(runtime_start, runtime_pages,
> > +                                     EFI_RUNTIME_SERVICES_CODE, false);
> > +       }
> >  }
> >
> >  int efi_memory_init(void)
> > --
> > 2.34.1
> >

Regards,
Simon
