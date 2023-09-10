Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC22EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 14:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2596F86B9A;
	Sun, 10 Sep 2023 16:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="ggn1LLHi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2A8286C35; Sun, 10 Sep 2023 16:57:44 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21AEF84003
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 16:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 61cbee74-4fea-11ee-8608-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 61cbee74-4fea-11ee-8608-005056999439;
 Sun, 10 Sep 2023 16:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=LvAvcHrp3gkmcqHyuqyQhUSRR2JrPMJ+pn6xirNtifI=;
 b=ggn1LLHiHVOacRGbdXJAHqCcjbVoVRD1iXdqR8EegYqjfSi6m1E8mrGQggp1AV/r+iHG1UJc4dxZW
 GCiYdppC1gjHRPxUaUv2daslBsEegjle2OFfo87QSW5caHTWtPYpfnnnT4BO75hxCS9Lo+077xsCAX
 FFyTk/tY/GSXm7wJsDpStu3v1hWK87aNP8zeXsX9AV89eWPMlJeke55rrMoOtN7deYDfq0DuoKcXT1
 Lt7H/iBZQR8Cw5YFhduw3xAYdBH380uZLUSJ/YFHoGXgrYMk49KwoYDoRjC0i36oMXKgIEZmulQLFs
 yp8wzkv5d9CqbEJFYdjVXnm44kuwfxQ==
X-KPN-MID: 33|BLwes38aXQ597bRHTNFmQphSL7EqKN3PBnllLgWrfUK+6s6VeUHy2gkRm/pjDom
 Qh4jVh4AnPdkq2CGlwln5ixYGNTkPPWe8vHf5graUGCU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|cPN8kF2Xry1yU2j/T3srdOWO77w8QKKsusJRnkWjWxnqetFhs3eMEf+TyM5pBg2
 8KZsTpqYRJXL7c1gXeMehRA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 6399b3a4-4fea-11ee-acaa-00505699d6e5;
 Sun, 10 Sep 2023 16:57:41 +0200 (CEST)
Date: Sun, 10 Sep 2023 16:57:40 +0200
Message-Id: <87v8cif53v.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: kettenis@openbsd.org, u-boot@lists.denx.de, xypron.glpk@gmx.de
In-Reply-To: <CAPnjgZ1R8c2qCaraQavRr+=MiAiHK38gD1NS2FHdhkXV=XKVog@mail.gmail.com>
 (message from Simon Glass on Thu, 7 Sep 2023 09:57:34 -0600)
Subject: Re: [PATCH v2] bootstd: Make efi_mgr bootmeth work for non-sandbox
 setups
References: <20230903204000.96999-1-kettenis@openbsd.org>
 <CAPnjgZ2D6Fq5WnSxjxD2fzCZkZB0yDAk7mOda7bTuUf-KZLmhA@mail.gmail.com>
 <87bkeegmgc.fsf@bloch.sibelius.xs4all.nl>
 <CAPnjgZ1R8c2qCaraQavRr+=MiAiHK38gD1NS2FHdhkXV=XKVog@mail.gmail.com>
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

> From: Simon Glass <sjg@chromium.org>
> Date: Thu, 7 Sep 2023 09:57:34 -0600
> 
> Hi Mark,
> 
> On Thu, 7 Sept 2023 at 07:08, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >
> > > From: Simon Glass <sjg@chromium.org>
> > > Date: Thu, 7 Sep 2023 06:23:10 -0600
> > >
> > > Hi Mark,
> > >
> > > On Sun, 3 Sept 2023 at 14:40, Mark Kettenis <kettenis@openbsd.org> wrote:
> > > >
> > > > Enable the bootflow based on this bootmeth if the BootOrder EFI
> > > > variable is set.
> > > >
> > > > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > > > ---
> > > >
> > > > ChangeLog:
> > > >
> > > > v2: - Initialize EFI subsystem to populate EFI variables
> > > >
> > > >
> > > >  boot/bootmeth_efi_mgr.c | 17 ++++++++++++++++-
> > > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> > > > index e9d973429f..e6c42d41fb 100644
> > > > --- a/boot/bootmeth_efi_mgr.c
> > > > +++ b/boot/bootmeth_efi_mgr.c
> > > > @@ -14,6 +14,8 @@
> > > >  #include <bootmeth.h>
> > > >  #include <command.h>
> > > >  #include <dm.h>
> > > > +#include <efi_loader.h>
> > > > +#include <efi_variable.h>
> > > >
> > > >  /**
> > > >   * struct efi_mgr_priv - private info for the efi-mgr driver
> > > > @@ -46,13 +48,26 @@ static int efi_mgr_check(struct udevice *dev, struct bootflow_iter *iter)
> > > >  static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> > > >  {
> > > >         struct efi_mgr_priv *priv = dev_get_priv(dev);
> > > > +       efi_status_t ret;
> > > > +       efi_uintn_t size;
> > > > +       u16 *bootorder;
> > > >
> > > >         if (priv->fake_dev) {
> > > >                 bflow->state = BOOTFLOWST_READY;
> > > >                 return 0;
> > > >         }
> > > >
> > > > -       /* To be implemented */
> > > > +       ret = efi_init_obj_list();
> > >
> > > Doesn't this start up the whole EFI system? Is there a cheaper way to
> > > see if the variable subsystem exists, or can work?
> >
> > A fair bit of it at least.  With the possible exception of launching
> > EFI capsules (which shouldn't happen for a "normal" boot), I don't
> > think this is very expensive though.
> >
> > There currently isn't a way to only initialize the variable subsystem;
> > we can't just call efi_init_variables() here since we have to also
> > call efi_disks_register() and a later efi_init_obj_list() call would
> > call efi_init_variables() again, which would leak memory.
> >
> > Alternatively we could just unconditionally declare the efi_mgr
> > bootmeth as "ready" (like you already do for sandbox).  That would
> > postpone initialization of the EFI subsystem until we actually execute
> > this bootmeth.
> >
> > But we need to do something before we switch more targets to standard
> > boot since otherwise booting through the EFI boot manager is just
> > plain broken.
> 
> Yes...
> 
> I don't have any great ideas on this. If we could get the EFI code
> better integrated into U-Boot then perhaps we would not need this
> 'monolithm' init?

You'll have to take that up with the maintainers of the EFI loader
subsystem.  I just want to repair the breakage that was introduced
with bootstd.
