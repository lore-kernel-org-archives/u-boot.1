Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C43EE3F28
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 20:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A19AE86CE8;
	Tue, 12 Sep 2023 22:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="E3L3UPjt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CB2D86E58; Tue, 12 Sep 2023 22:06:23 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E13BF86CE8
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 22:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: d65143f4-51a7-11ee-a194-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id d65143f4-51a7-11ee-a194-005056999439;
 Tue, 12 Sep 2023 22:06:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=rlkN4MCqqTsr185qgX09cPfZ7fxZoCwFPMVGpcXBQ14=;
 b=E3L3UPjtETyiQZawV+r9wK7kHNzDx2UgBFOeUQpEiVVWwx+DldlEEb8EBEmkBJL27u4MlxR3ossVW
 fvuNDkTKAxwZ5LtuKLXIVhEKMN8U+EIHz0ZprIHNhnnoOws+vwgdJBdiPok/DAYY6IxT+FbD7Adv9d
 t7Us5jaolFpruB5lZHmLgL/Cv/cnJUIkqkOp+oXAm+LoLIMqV+su7LpyKiNlBT501UTOCJYtC3+AFJ
 lblqHBTCOW93PVr+IVKotsQ2YOn2lRD1qK3Rp6zJyuqUMsXW6qp6izvSaWwj6sF6dGoWC2K8YTQmcP
 RupR0bICNEKAUpFVPISIp+Rd2U/ZkVg==
X-KPN-MID: 33|SQe4nUJiVwbDy/RyujKOhuO01H1SQdx9kIyy2k/KR4BbHExLxx5MjLOTj5k3kno
 VfilhFtaFszl/2jhb2eE2zQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|5Cx1zOmYQjWf1YCDpHeFXAXCwSR5TmdhZ6+JHkS0D2pb6qWELt8I7HNrlp88vrX
 auOLDkJK9jrqYqDev6pyb0Q==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id d684528b-51a7-11ee-ad2d-005056998788;
 Tue, 12 Sep 2023 22:06:20 +0200 (CEST)
Date: Tue, 12 Sep 2023 22:06:19 +0200
Message-Id: <87il8ff96s.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: kettenis@openbsd.org, u-boot@lists.denx.de, xypron.glpk@gmx.de
In-Reply-To: <CAPnjgZ1zta2DsTAUwHmxY8QFfPF0BFo4a6_v_J9nnVuCVBru=w@mail.gmail.com>
 (message from Simon Glass on Sun, 10 Sep 2023 13:13:16 -0600)
Subject: Re: [PATCH v2] bootstd: Make efi_mgr bootmeth work for non-sandbox
 setups
References: <20230903204000.96999-1-kettenis@openbsd.org>
 <CAPnjgZ2D6Fq5WnSxjxD2fzCZkZB0yDAk7mOda7bTuUf-KZLmhA@mail.gmail.com>
 <87bkeegmgc.fsf@bloch.sibelius.xs4all.nl>
 <CAPnjgZ1R8c2qCaraQavRr+=MiAiHK38gD1NS2FHdhkXV=XKVog@mail.gmail.com>
 <87v8cif53v.fsf@bloch.sibelius.xs4all.nl>
 <CAPnjgZ1zta2DsTAUwHmxY8QFfPF0BFo4a6_v_J9nnVuCVBru=w@mail.gmail.com>
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
> Date: Sun, 10 Sep 2023 13:13:16 -0600
> 
> Hi Mark,
> 
> On Sun, 10 Sept 2023 at 08:57, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >
> > > From: Simon Glass <sjg@chromium.org>
> > > Date: Thu, 7 Sep 2023 09:57:34 -0600
> > >
> > > Hi Mark,
> > >
> > > On Thu, 7 Sept 2023 at 07:08, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > > >
> > > > > From: Simon Glass <sjg@chromium.org>
> > > > > Date: Thu, 7 Sep 2023 06:23:10 -0600
> > > > >
> > > > > Hi Mark,
> > > > >
> > > > > On Sun, 3 Sept 2023 at 14:40, Mark Kettenis <kettenis@openbsd.org> wrote:
> > > > > >
> > > > > > Enable the bootflow based on this bootmeth if the BootOrder EFI
> > > > > > variable is set.
> > > > > >
> > > > > > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > > > > > ---
> > > > > >
> > > > > > ChangeLog:
> > > > > >
> > > > > > v2: - Initialize EFI subsystem to populate EFI variables
> > > > > >
> > > > > >
> > > > > >  boot/bootmeth_efi_mgr.c | 17 ++++++++++++++++-
> > > > > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> > > > > > index e9d973429f..e6c42d41fb 100644
> > > > > > --- a/boot/bootmeth_efi_mgr.c
> > > > > > +++ b/boot/bootmeth_efi_mgr.c
> > > > > > @@ -14,6 +14,8 @@
> > > > > >  #include <bootmeth.h>
> > > > > >  #include <command.h>
> > > > > >  #include <dm.h>
> > > > > > +#include <efi_loader.h>
> > > > > > +#include <efi_variable.h>
> > > > > >
> > > > > >  /**
> > > > > >   * struct efi_mgr_priv - private info for the efi-mgr driver
> > > > > > @@ -46,13 +48,26 @@ static int efi_mgr_check(struct udevice *dev, struct bootflow_iter *iter)
> > > > > >  static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> > > > > >  {
> > > > > >         struct efi_mgr_priv *priv = dev_get_priv(dev);
> > > > > > +       efi_status_t ret;
> > > > > > +       efi_uintn_t size;
> > > > > > +       u16 *bootorder;
> > > > > >
> > > > > >         if (priv->fake_dev) {
> > > > > >                 bflow->state = BOOTFLOWST_READY;
> > > > > >                 return 0;
> > > > > >         }
> > > > > >
> > > > > > -       /* To be implemented */
> > > > > > +       ret = efi_init_obj_list();
> > > > >
> > > > > Doesn't this start up the whole EFI system? Is there a cheaper way to
> > > > > see if the variable subsystem exists, or can work?
> > > >
> > > > A fair bit of it at least.  With the possible exception of launching
> > > > EFI capsules (which shouldn't happen for a "normal" boot), I don't
> > > > think this is very expensive though.
> > > >
> > > > There currently isn't a way to only initialize the variable subsystem;
> > > > we can't just call efi_init_variables() here since we have to also
> > > > call efi_disks_register() and a later efi_init_obj_list() call would
> > > > call efi_init_variables() again, which would leak memory.
> > > >
> > > > Alternatively we could just unconditionally declare the efi_mgr
> > > > bootmeth as "ready" (like you already do for sandbox).  That would
> > > > postpone initialization of the EFI subsystem until we actually execute
> > > > this bootmeth.
> > > >
> > > > But we need to do something before we switch more targets to standard
> > > > boot since otherwise booting through the EFI boot manager is just
> > > > plain broken.
> > >
> > > Yes...
> > >
> > > I don't have any great ideas on this. If we could get the EFI code
> > > better integrated into U-Boot then perhaps we would not need this
> > > 'monolithm' init?
> >
> > You'll have to take that up with the maintainers of the EFI loader
> > subsystem.  I just want to repair the breakage that was introduced
> > with bootstd.
> 
> Yes, understood. Do you know how long it takes to do this step?

It is instant.  But then this is on a fast machine with the EFI
variables stored on the internal NVMe disk, which is plenty fast as
well.  And I haven't enabled any of the capsule or TPM stuff hich may
take more time.

> The control for this feature is CMD_BOOTEFI_BOOTMGR...I think it would
> be better to have BOOTEFI_BOOTMGR as well as CMD_BOOTEFI_BOOTMGR,
> since it is strange to have a CMD Kconfig in lib/efi_loader
> 
> I am OK with this patch as I don't see any alternative. We need to do
> something and we can always improve it if it causes problems.
> 
> Heinrich?
> 
> Regards,
> Simon
> 
