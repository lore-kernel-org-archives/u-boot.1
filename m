Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FF2C71153
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 19:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C980A86D16;
	Sun, 10 Sep 2023 21:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R/0kQYwu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47DB186D00; Sun, 10 Sep 2023 21:14:56 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70E3B86D01
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d7260fae148so3374537276.1
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694373287; x=1694978087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rhjnb565dv/nh9Gb69ArKQq+I84VvsnYOTJBidPAenQ=;
 b=R/0kQYwuZMTm/Eq/111dzWxmzE0pNcaG0ePv3IooXyBJ9UMLJyTsLFimhqVw5kGd0H
 eHx+0wf9UM8bEluwW6KIXTAPjHgWTQSkZaJ1QWcz1neH77+5LoJhMJBnEZrYWaUAVvtt
 hlWZzLnr5sxK93Z5JvxSc03LaxhqIYKqXlKRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694373287; x=1694978087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rhjnb565dv/nh9Gb69ArKQq+I84VvsnYOTJBidPAenQ=;
 b=g+p6vszSv+0Rin2klszZTs8e+qgB+g0fd8dWiEIreWLojIZoG12sIT4YWgNnTDHc59
 3bEELVjf0PMDtrgi3wQY8/M3ZNswiFtaK6wkqkCHW0Wd916orbQPyqkoY5k4dot4CMVq
 Uv/bAFl0+3T4UFWwXGTn6/SpycXWtHOm2j6loKxoxoUfyKJo44aN9PviPL7SM46QwTsZ
 7xFURBoGoB8clt5hcO1jWCsb0w+wK6cr7zT30yY4ghrc+qLp4qbfD5qU8rrC1jFvymg8
 suOhBpJd5+qvOIBXx1/y7SbzvB2PhW35WwvsFUXhayLKYgsFTXXJi07EBhDq0BVSUO+E
 gnkw==
X-Gm-Message-State: AOJu0YylCzfhXHUK8Lb7wQvxLMfCvHCqUDSoY97LLCNxRVONcZLTPQs2
 gZFt22DcD41Ku/338UCN0Fs+nTjfDugM92JVYFla6w==
X-Google-Smtp-Source: AGHT+IEZn0nCHn8NDNTzYvZxzFE0ievKwKRW6GffYwJTTRRC02Qa0mBfTRDwNdopuoFtsGg+WAmeAyKwLl2ijGvSetw=
X-Received: by 2002:a25:d344:0:b0:d47:b3ac:e255 with SMTP id
 e65-20020a25d344000000b00d47b3ace255mr6866941ybf.43.1694373286967; Sun, 10
 Sep 2023 12:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230903204000.96999-1-kettenis@openbsd.org>
 <CAPnjgZ2D6Fq5WnSxjxD2fzCZkZB0yDAk7mOda7bTuUf-KZLmhA@mail.gmail.com>
 <87bkeegmgc.fsf@bloch.sibelius.xs4all.nl>
 <CAPnjgZ1R8c2qCaraQavRr+=MiAiHK38gD1NS2FHdhkXV=XKVog@mail.gmail.com>
 <87v8cif53v.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87v8cif53v.fsf@bloch.sibelius.xs4all.nl>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 13:13:16 -0600
Message-ID: <CAPnjgZ1zta2DsTAUwHmxY8QFfPF0BFo4a6_v_J9nnVuCVBru=w@mail.gmail.com>
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

On Sun, 10 Sept 2023 at 08:57, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Simon Glass <sjg@chromium.org>
> > Date: Thu, 7 Sep 2023 09:57:34 -0600
> >
> > Hi Mark,
> >
> > On Thu, 7 Sept 2023 at 07:08, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > >
> > > > From: Simon Glass <sjg@chromium.org>
> > > > Date: Thu, 7 Sep 2023 06:23:10 -0600
> > > >
> > > > Hi Mark,
> > > >
> > > > On Sun, 3 Sept 2023 at 14:40, Mark Kettenis <kettenis@openbsd.org> wrote:
> > > > >
> > > > > Enable the bootflow based on this bootmeth if the BootOrder EFI
> > > > > variable is set.
> > > > >
> > > > > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > > > > ---
> > > > >
> > > > > ChangeLog:
> > > > >
> > > > > v2: - Initialize EFI subsystem to populate EFI variables
> > > > >
> > > > >
> > > > >  boot/bootmeth_efi_mgr.c | 17 ++++++++++++++++-
> > > > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> > > > > index e9d973429f..e6c42d41fb 100644
> > > > > --- a/boot/bootmeth_efi_mgr.c
> > > > > +++ b/boot/bootmeth_efi_mgr.c
> > > > > @@ -14,6 +14,8 @@
> > > > >  #include <bootmeth.h>
> > > > >  #include <command.h>
> > > > >  #include <dm.h>
> > > > > +#include <efi_loader.h>
> > > > > +#include <efi_variable.h>
> > > > >
> > > > >  /**
> > > > >   * struct efi_mgr_priv - private info for the efi-mgr driver
> > > > > @@ -46,13 +48,26 @@ static int efi_mgr_check(struct udevice *dev, struct bootflow_iter *iter)
> > > > >  static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> > > > >  {
> > > > >         struct efi_mgr_priv *priv = dev_get_priv(dev);
> > > > > +       efi_status_t ret;
> > > > > +       efi_uintn_t size;
> > > > > +       u16 *bootorder;
> > > > >
> > > > >         if (priv->fake_dev) {
> > > > >                 bflow->state = BOOTFLOWST_READY;
> > > > >                 return 0;
> > > > >         }
> > > > >
> > > > > -       /* To be implemented */
> > > > > +       ret = efi_init_obj_list();
> > > >
> > > > Doesn't this start up the whole EFI system? Is there a cheaper way to
> > > > see if the variable subsystem exists, or can work?
> > >
> > > A fair bit of it at least.  With the possible exception of launching
> > > EFI capsules (which shouldn't happen for a "normal" boot), I don't
> > > think this is very expensive though.
> > >
> > > There currently isn't a way to only initialize the variable subsystem;
> > > we can't just call efi_init_variables() here since we have to also
> > > call efi_disks_register() and a later efi_init_obj_list() call would
> > > call efi_init_variables() again, which would leak memory.
> > >
> > > Alternatively we could just unconditionally declare the efi_mgr
> > > bootmeth as "ready" (like you already do for sandbox).  That would
> > > postpone initialization of the EFI subsystem until we actually execute
> > > this bootmeth.
> > >
> > > But we need to do something before we switch more targets to standard
> > > boot since otherwise booting through the EFI boot manager is just
> > > plain broken.
> >
> > Yes...
> >
> > I don't have any great ideas on this. If we could get the EFI code
> > better integrated into U-Boot then perhaps we would not need this
> > 'monolithm' init?
>
> You'll have to take that up with the maintainers of the EFI loader
> subsystem.  I just want to repair the breakage that was introduced
> with bootstd.

Yes, understood. Do you know how long it takes to do this step?

The control for this feature is CMD_BOOTEFI_BOOTMGR...I think it would
be better to have BOOTEFI_BOOTMGR as well as CMD_BOOTEFI_BOOTMGR,
since it is strange to have a CMD Kconfig in lib/efi_loader

I am OK with this patch as I don't see any alternative. We need to do
something and we can always improve it if it causes problems.

Heinrich?

Regards,
Simon
