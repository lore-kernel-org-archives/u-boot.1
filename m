Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C78CEC8724
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 13:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B95C586682;
	Thu,  7 Sep 2023 15:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="hdYQyU88";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40D65868D7; Thu,  7 Sep 2023 15:08:39 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8927C8657B
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 15:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: a65fc4b0-4d7f-11ee-8608-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id a65fc4b0-4d7f-11ee-8608-005056999439;
 Thu, 07 Sep 2023 15:08:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=KlP9ORapXu6+Hh615zwKkjzGK4tJUKPsMYCeE9qUIdE=;
 b=hdYQyU88+Kz3gFowrPceDfZRVm83gBXIf5hxyMSNsgDHfgUwezGAJWFGoo+E3A6nhvOD1riqUFYuH
 0I8+WGXcvAdtCpi/K0C0YITuFXmdM8XmY1WA7CURnORgX3ciup72ycLDs0cWUrTT3cGOnfYoDY6SAW
 EL/ptd+1Yjm8xeMcd8QzDU+JkHaomXdePYguMBOoezU26eDeVV4cff6UVpRwYg8OoGkT8wHgncoYs2
 nro+YshOex90uYhEq/U/5eweVH1mF24TC1mkVX4Yim8PxduDf6vF5i4yUNJy6yVYXq6WhBtdA0qpeg
 3SH7nV9AEPzceC/VlXIpW5zYoI1Dy4A==
X-KPN-MID: 33|kgrgt8Pwr9M/e/TVZ1cexDK5z11QZxaGRkq2eMrGp9la94E3Ym61pp6+CvRtlg+
 cIQeqpWPaM0lNapYj5DhOfQCzCsXZEFjtuO9iHPRtX+A=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|WKOvoAaoZ4wOKjl6dvdyBt1/By5C5ryvpKVr5yW3T4SJ4/UlfyLWaKjd2ENveBt
 vbzTtK+b8BPmGJZZCh5uWcA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id a6fb436d-4d7f-11ee-875e-00505699d6e5;
 Thu, 07 Sep 2023 15:08:36 +0200 (CEST)
Date: Thu, 07 Sep 2023 15:08:35 +0200
Message-Id: <87bkeegmgc.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: kettenis@openbsd.org, u-boot@lists.denx.de, xypron.glpk@gmx.de
In-Reply-To: <CAPnjgZ2D6Fq5WnSxjxD2fzCZkZB0yDAk7mOda7bTuUf-KZLmhA@mail.gmail.com>
 (message from Simon Glass on Thu, 7 Sep 2023 06:23:10 -0600)
Subject: Re: [PATCH v2] bootstd: Make efi_mgr bootmeth work for non-sandbox
 setups
References: <20230903204000.96999-1-kettenis@openbsd.org>
 <CAPnjgZ2D6Fq5WnSxjxD2fzCZkZB0yDAk7mOda7bTuUf-KZLmhA@mail.gmail.com>
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
> Date: Thu, 7 Sep 2023 06:23:10 -0600
> 
> Hi Mark,
> 
> On Sun, 3 Sept 2023 at 14:40, Mark Kettenis <kettenis@openbsd.org> wrote:
> >
> > Enable the bootflow based on this bootmeth if the BootOrder EFI
> > variable is set.
> >
> > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > ---
> >
> > ChangeLog:
> >
> > v2: - Initialize EFI subsystem to populate EFI variables
> >
> >
> >  boot/bootmeth_efi_mgr.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> > index e9d973429f..e6c42d41fb 100644
> > --- a/boot/bootmeth_efi_mgr.c
> > +++ b/boot/bootmeth_efi_mgr.c
> > @@ -14,6 +14,8 @@
> >  #include <bootmeth.h>
> >  #include <command.h>
> >  #include <dm.h>
> > +#include <efi_loader.h>
> > +#include <efi_variable.h>
> >
> >  /**
> >   * struct efi_mgr_priv - private info for the efi-mgr driver
> > @@ -46,13 +48,26 @@ static int efi_mgr_check(struct udevice *dev, struct bootflow_iter *iter)
> >  static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> >  {
> >         struct efi_mgr_priv *priv = dev_get_priv(dev);
> > +       efi_status_t ret;
> > +       efi_uintn_t size;
> > +       u16 *bootorder;
> >
> >         if (priv->fake_dev) {
> >                 bflow->state = BOOTFLOWST_READY;
> >                 return 0;
> >         }
> >
> > -       /* To be implemented */
> > +       ret = efi_init_obj_list();
> 
> Doesn't this start up the whole EFI system? Is there a cheaper way to
> see if the variable subsystem exists, or can work?

A fair bit of it at least.  With the possible exception of launching
EFI capsules (which shouldn't happen for a "normal" boot), I don't
think this is very expensive though.

There currently isn't a way to only initialize the variable subsystem;
we can't just call efi_init_variables() here since we have to also
call efi_disks_register() and a later efi_init_obj_list() call would
call efi_init_variables() again, which would leak memory.

Alternatively we could just unconditionally declare the efi_mgr
bootmeth as "ready" (like you already do for sandbox).  That would
postpone initialization of the EFI subsystem until we actually execute
this bootmeth.

But we need to do something before we switch more targets to standard
boot since otherwise booting through the EFI boot manager is just
plain broken.

> > +       if (ret)
> > +               return log_msg_ret("init", ret);
> > +
> > +       /* Enable this method if the "BootOrder" UEFI exists. */
> > +       bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
> > +                               &size);
> > +       if (bootorder) {
> > +               bflow->state = BOOTFLOWST_READY;
> > +               return 0;
> > +       }
> >
> >         return -EINVAL;
> >  }
> > --
> > 2.42.0
> >
> 
> Regards,
> Simon
> 
