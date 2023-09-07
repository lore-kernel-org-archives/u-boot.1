Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE2BEC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 15:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A388086A1C;
	Thu,  7 Sep 2023 17:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="apjoWIlj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E61A869F2; Thu,  7 Sep 2023 17:57:49 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA46586A14
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso134972066b.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102266; x=1694707066; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sCXoShlQ3+20Ri9jrbaVtIIxDnQvEGKrYLP2MttuT68=;
 b=apjoWIlj+7V0RB9LBTR5vxkTLuJihXcHvnn0EowcwYxKrLgG5ihfZtGr5MRjhq7Xzb
 4peTH2qSUY3QULLrN9jZu3zyrnoeOsItf993q62+YGk5dlnvmsBDZImdRimt1Dfqs4rH
 GNZGvcWSvPjH2EngANiOy2CzlDAvZFM8HKMA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102266; x=1694707066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sCXoShlQ3+20Ri9jrbaVtIIxDnQvEGKrYLP2MttuT68=;
 b=Lz/ug5IQJlmHoIlquszqQQpj4RY76pS7nCa3zQmSOBE2teJecb8T/dWicKAXku1WqA
 JWRsbW3rHArfyWDiIs4Y0tFEwNXndtRXmlRtMpKrZldu/vxZK0zJj6GHTtC5v4pvvAfw
 Ho0N9/8CPziQNT2WM1aBynyT8n6SP1qRNsWa/MW+XhL2sQQfBaaW2Q7C3y5s2eFm2OYt
 eNShCCzHuLyRc/E9/EhTkGCBLdnsZMWp83t/CibBaWpdslo5/GU3vK1R//dHlKNWmB7b
 wKUShJRPuZjGz9d/JNeRRn0Rpj07hp59ZhfvvxFGcmCp5Yjs3iRTIlbmDzV+gFFxLg3n
 z3Cg==
X-Gm-Message-State: AOJu0YxmFoBfjIhDE8fEVX5iguMiXTz7CGieaC9zusQKFJKDDqYhlorE
 j9jKREyihnDfmXKOVq++zoaCOdwPyvhQEWDXp70cxcPgvv+SxYtFKVw=
X-Google-Smtp-Source: AGHT+IGtp5QZ2mMSZjR3YYpunzkMQZiJPUXRiLTty76piX1Kz2RUlnC92a728VODGp3QEgrpyegQ81aeIeqIDkcnHBE=
X-Received: by 2002:a17:906:5396:b0:993:d75b:63ea with SMTP id
 g22-20020a170906539600b00993d75b63eamr4987617ejo.16.1694102266129; Thu, 07
 Sep 2023 08:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230903204000.96999-1-kettenis@openbsd.org>
 <CAPnjgZ2D6Fq5WnSxjxD2fzCZkZB0yDAk7mOda7bTuUf-KZLmhA@mail.gmail.com>
 <87bkeegmgc.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87bkeegmgc.fsf@bloch.sibelius.xs4all.nl>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Sep 2023 09:57:34 -0600
Message-ID: <CAPnjgZ1R8c2qCaraQavRr+=MiAiHK38gD1NS2FHdhkXV=XKVog@mail.gmail.com>
Subject: Re: [PATCH v2] bootstd: Make efi_mgr bootmeth work for non-sandbox
 setups
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: kettenis@openbsd.org, u-boot@lists.denx.de, xypron.glpk@gmx.de
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

Hi Mark,

On Thu, 7 Sept 2023 at 07:08, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Simon Glass <sjg@chromium.org>
> > Date: Thu, 7 Sep 2023 06:23:10 -0600
> >
> > Hi Mark,
> >
> > On Sun, 3 Sept 2023 at 14:40, Mark Kettenis <kettenis@openbsd.org> wrote:
> > >
> > > Enable the bootflow based on this bootmeth if the BootOrder EFI
> > > variable is set.
> > >
> > > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > > ---
> > >
> > > ChangeLog:
> > >
> > > v2: - Initialize EFI subsystem to populate EFI variables
> > >
> > >
> > >  boot/bootmeth_efi_mgr.c | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> > > index e9d973429f..e6c42d41fb 100644
> > > --- a/boot/bootmeth_efi_mgr.c
> > > +++ b/boot/bootmeth_efi_mgr.c
> > > @@ -14,6 +14,8 @@
> > >  #include <bootmeth.h>
> > >  #include <command.h>
> > >  #include <dm.h>
> > > +#include <efi_loader.h>
> > > +#include <efi_variable.h>
> > >
> > >  /**
> > >   * struct efi_mgr_priv - private info for the efi-mgr driver
> > > @@ -46,13 +48,26 @@ static int efi_mgr_check(struct udevice *dev, struct bootflow_iter *iter)
> > >  static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> > >  {
> > >         struct efi_mgr_priv *priv = dev_get_priv(dev);
> > > +       efi_status_t ret;
> > > +       efi_uintn_t size;
> > > +       u16 *bootorder;
> > >
> > >         if (priv->fake_dev) {
> > >                 bflow->state = BOOTFLOWST_READY;
> > >                 return 0;
> > >         }
> > >
> > > -       /* To be implemented */
> > > +       ret = efi_init_obj_list();
> >
> > Doesn't this start up the whole EFI system? Is there a cheaper way to
> > see if the variable subsystem exists, or can work?
>
> A fair bit of it at least.  With the possible exception of launching
> EFI capsules (which shouldn't happen for a "normal" boot), I don't
> think this is very expensive though.
>
> There currently isn't a way to only initialize the variable subsystem;
> we can't just call efi_init_variables() here since we have to also
> call efi_disks_register() and a later efi_init_obj_list() call would
> call efi_init_variables() again, which would leak memory.
>
> Alternatively we could just unconditionally declare the efi_mgr
> bootmeth as "ready" (like you already do for sandbox).  That would
> postpone initialization of the EFI subsystem until we actually execute
> this bootmeth.
>
> But we need to do something before we switch more targets to standard
> boot since otherwise booting through the EFI boot manager is just
> plain broken.

Yes...

I don't have any great ideas on this. If we could get the EFI code
better integrated into U-Boot then perhaps we would not need this
'monolithm' init?

Regards,
Simon
