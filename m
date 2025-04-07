Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1197C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 12:23:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 496FD82E40;
	Mon,  7 Apr 2025 14:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="emi1zp9R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7125C82E58; Mon,  7 Apr 2025 14:23:00 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D55C482E38
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 14:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 39b3a62d-13ab-11f0-beb8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 39b3a62d-13ab-11f0-beb8-005056992ed3;
 Mon, 07 Apr 2025 14:24:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=c2iDJTmF+2vVx7FXiG4O4MtEztzJshLbOD07fMdLEQA=;
 b=emi1zp9R2f/5+FE463d0hNVsL/1/KDtSVwvNHaiLt0XCcj2UioipJ1K78gElKUzT+EcSBNm3nAcEY
 bM+wSRZv8d0AA9/ZDCvJ0hQ9Izg2TUBfTKOK/FL5PwZeDBHT4xFX3EGqxEi3rxEjchQmVB/hoD5Qwu
 rP9kym8U/O/x2CYGVw/5qoY7mVIoE1xY3fwc63/RpJ4huNEJ9hCEToInDv2+uBZf5OvtrCl5dSowiY
 3JgIO99G53StekVxsMOTQLWi0hMjDl++neevcE4Nfq83AqtbJ+2Eg6CSChne5jEBotH/S+v3Gj8TRc
 Ze3WuUPlaDuDCRqwh1FMPrCjE4qDmyw==
X-KPN-MID: 33|+KjEJA8P3MxRkvCynsNMy7okO8xf8PDVKU5IfmSBJ2bC40FimOls4OQ0LgyXMZB
 Fo11946M443ptnKFjX6r62A==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Z8VpjQAN9/zMh/j52Ii7j5oV1sJ0Us1OIOtNiq7TwUY6j16v3APFxz14lb+glbc
 htHfhuFIsRAqHOSfVj1+zlw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 0935b2dd-13ab-11f0-af98-005056998788;
 Mon, 07 Apr 2025 14:22:57 +0200 (CEST)
Date: Mon, 07 Apr 2025 14:22:56 +0200
Message-Id: <87tt70w47z.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 trini@konsulko.com, neil.armstrong@linaro.org,
 jonas@kwiboo.se, christian@kohlschutter.com, j@jannau.net,
 u-boot@lists.denx.de
In-Reply-To: <CAFLszTh7BXFvG_q9tMiCmrLZzsQY6uEqQo62wXBBfsPkObO=3g@mail.gmail.com>
 (message from Simon Glass on Mon, 7 Apr 2025 22:49:05 +1200)
Subject: Re: [PATCH v2 3/4] efi_loader: Move device-removal later in
 exit-boot-services
References: <20250407013513.638110-1-sjg@chromium.org>
 <20250407013513.638110-4-sjg@chromium.org>
 <e2cca54d-188f-450d-ba70-a8a778263a72@gmx.de>
 <CAFLszTh7BXFvG_q9tMiCmrLZzsQY6uEqQo62wXBBfsPkObO=3g@mail.gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
> Date: Mon, 7 Apr 2025 22:49:05 +1200

Hi Simon,

Since I brought up the same objection as Heinrich...

> Hi Heinrich,
> 
> On Mon, 7 Apr 2025 at 19:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 07.04.25 03:35, Simon Glass wrote:
> > > This removal should be the last thing done, so that U-Boot does no more
> > > memory allocations afterwards, thus avoiding potentially allocating
> > > memory which has been freed by a device that fails to de-activate its
> > > DMA.
> >
> > The EFI application that is calling ExitBootServices() has been reading
> > the EFI memory map with GetMemoryMap() before. This is checked by
> > comparing the MapKey parameter.
> >
> > Whatever allocations are done or not in ExitBootServices() is not
> > visible to the EFI application.
> >
> > DMA has to be stopped in all cases.
> 
> Yes, DMA must be stopped.
> 
> >
> > I don't understand the virtue of the proposed change.
> 
> It is described in the next two paragraphs:
> 
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > > Of course, devices should be marked with DM_FLAG_ACTIVE_DMA or
> > > DM_FLAG_OS_PREPARE but this change is good practice, in any case.

I disagree.  Stopping DMA is early as possible is good practice.

> > > It also matches the code in announce_and_cleanup(), which we should at
> > > some point unify with EFI_LOADER

As far as I can see there is nothing that happens in between the old
location and your new location in efi_exit_boot_services() that
matches anything that is done in announce_and_cleanup().

> See above. Also, what do you think about unifying with
> announce_and_cleanup() ?
> 
> Regards,
> Simon
> 
> 
> > >
> > > So move the code and add a comment.
> > >
> > > Note that the TCG2 log is updated after this call, but I cannot see any
> > > allocations there.
> > >
> > > Reported-by: Christian Kohlschütter <christian@kohlschutter.com>
> > > Link: https://lore.kernel.org/u-boot/C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschutter.com/
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >   lib/efi_loader/efi_boottime.c | 21 +++++++++++++--------
> > >   1 file changed, 13 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> > > index ffe43accd1e..e525662f82f 100644
> > > --- a/lib/efi_loader/efi_boottime.c
> > > +++ b/lib/efi_loader/efi_boottime.c
> > > @@ -2250,14 +2250,6 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
> > >                       list_del(&evt->link);
> > >       }
> > >
> > > -     if (!efi_st_keep_devices) {
> > > -             bootm_disable_interrupts();
> > > -             if (IS_ENABLED(CONFIG_USB_DEVICE))
> > > -                     udc_disconnect();
> > > -             board_quiesce_devices();
> > > -             dm_remove_devices_active();
> > > -     }
> > > -
> > >       /* Patch out unsupported runtime function */
> > >       efi_runtime_detach();
> > >
> > > @@ -2279,6 +2271,19 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
> > >       /* Give the payload some time to boot */
> > >       efi_set_watchdog(0);
> > >       schedule();
> > > +
> > > +     /*
> > > +      * this should be the last thing done, to avoid memory allocations
> > > +      * between removing devices and the OS taking over
> > > +      */
> > > +     if (!efi_st_keep_devices) {
> > > +             bootm_disable_interrupts();
> > > +             if (IS_ENABLED(CONFIG_USB_DEVICE))
> > > +                     udc_disconnect();
> > > +             board_quiesce_devices();
> > > +             dm_remove_devices_active();
> > > +     }
> > > +
> > >   out:
> > >       if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
> > >               if (ret != EFI_SUCCESS)
> >
> 
