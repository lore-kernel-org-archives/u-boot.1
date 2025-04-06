Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745C9C3600C
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 10:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF6A682B45;
	Sun,  6 Apr 2025 12:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="aaPzOYqU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99F2E82B46; Sun,  6 Apr 2025 12:01:06 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0803282B2F
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 12:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 0bec00d0-12ce-11f0-a9b5-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 0bec00d0-12ce-11f0-a9b5-00505699b430;
 Sun, 06 Apr 2025 12:01:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=f7DKFSF0gfKEDd0tCaco9uYFOhqO46QJPgYuZyblHEA=;
 b=aaPzOYqUIaQJYyq+b0cOjz3i09vYKVDeNE43WF6+QADBs2v+gmX5edxmOWLKzc8xBlV+YDPmqVXbx
 3+U80BQJ0SS+ZBPA9oqpZRLe9TzGfDNis5CGCbk3kDbIkvVkZGBoIw6IUhHHngQKPuEWCwfTM5JDJw
 CYZdZBx7DLTxU1+a8qIRRqmY0tnVk0Ts5QVRw7AROtAhVhzXChzEGBhKrjuEJcmKTMpS4u0RNv4Kg4
 M/fOL7RUGdv69+v7kA1WwrPBVXF71Ab/y18gSOrUOyom/xcFI7XfpzqYIXOHcEstKpqV5MZfn9umEc
 4snF7srXhJZR00ktRxbBkgrplYmqXvg==
X-KPN-MID: 33|t1KetOIo1se4H0bKrpEYS7xhurLHnIexDLqlrGyl03gKScexsJtUou8bO9RFoH6
 NIVlv/O+IgaRb51pKGqtrgruLhf0kPUzlH22lRc0RFtg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|fPzmrSR5rVLSlNa/ioBxJuRrwvo1DON25Yv4Jhctqu3fy0qWdNo4MDX7ApOVYJS
 F49xzobyU//Js+/HqPZS+ZQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 0bb6f439-12ce-11f0-97c8-00505699d6e5;
 Sun, 06 Apr 2025 12:01:02 +0200 (CEST)
Date: Sun, 06 Apr 2025 12:01:01 +0200
Message-Id: <87y0wdwqw2.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: sjg@chromium.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 mcb30@ipxe.org, christian@kohlschutter.com,
 neil.armstrong@linaro.org, u-boot@lists.denx.de
In-Reply-To: <CAM=mAOnCdLWMUfU1DCdUu0RdM0-PXaW_2XrPT5UaKOCSNU4PaQ@mail.gmail.com>
 (message from Heinrich Schuchardt on Sun, 6 Apr 2025 07:14:49 +0200)
Subject: Re: [PATCH 1/1] efi_loader: stop network in EXIT_BOOT_SERVICES
References: <20250405065812.33027-1-heinrich.schuchardt@canonical.com>
 <CAFLszTgp38yBXnSigfT-mEFU=rqyAKjp0WBQGgHP_N3vRxCq=Q@mail.gmail.com>
 <CAM=mAOnCdLWMUfU1DCdUu0RdM0-PXaW_2XrPT5UaKOCSNU4PaQ@mail.gmail.com>
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

> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Date: Sun, 6 Apr 2025 07:14:49 +0200
> 
> Simon Glass <sjg@chromium.org> schrieb am Sa., 5. Apr. 2025, 22:46:
> 
> > Hi,
> >
> > On Sat, 5 Apr 2025 at 19:58, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >
> > > It has been reported that memory corruption can occurred because network
> > > packages where received after EXIT_BOOT_SERVICES. See the thread
> > > starting at [1].
> > >
> > > We try to remove all drivers when EXIT_BOOT_SERVICES is called. But
> > >
> > > * Some network drivers don't call their own stop method when removed.
> > > * Some network drivers don't have a remove method.
> > > * Some devices have CONFIG_DM_DEVICE_REMOVE=n.
> >
> > A few points:
> > 1. Only three boards disable DM_DEVICE_REMOVE and enable EFI_LOADER;
> > EFI_LOADER must depend on it or select it
> >
> 
> Why does that option exist at all?

Presumably it shaves a few bytes off the final binaries?  And if you
don't have any drivers that do uncontrolled DMA you don't really need
to do any driver tear down.

> How would a driver live on when U-Boot is not around?
> 
> My two cents: That option should vanish as it is incompatible with the
> driver model.
> 
> 2. If devices don't enable DM_DEVICE_REMOVE we'll have similar
> > problems with USB, etc.
> 
> 3. The code in efi_boottime.c should be unified with
> > announce_and_cleanup() since otherwise this will happen on the non-EFI
> > path
> >
> > Please do at least (1) now, if this patch is targeted at the imminent
> > release.
> 
> 
> > Also, we need a fix in the affected network driver, although I suspect
> > the reporter will do that.
> >
> 
> You just sent patches for the network drivers.
> 
> Best regards
> 
> Heinrich
> 
> 
> > Regards,
> > Simon
> >
> >
> >
> >
> > >
> > > Let's call eth_halt() in EXIT_BOOT_SERVICES explicitly.
> > >
> > > [1]
> > >
> > https://lore.kernel.org/all/C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschutter.com/
> > >
> > > Cc: Michael Brown <mcb30@ipxe.org>
> > > Reported-by: Christian Kohlschütter <christian@kohlschutter.com>
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >  lib/efi_loader/efi_boottime.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/lib/efi_loader/efi_boottime.c
> > b/lib/efi_loader/efi_boottime.c
> > > index 5164cb15986..eaa6464fa39 100644
> > > --- a/lib/efi_loader/efi_boottime.c
> > > +++ b/lib/efi_loader/efi_boottime.c
> > > @@ -15,6 +15,7 @@
> > >  #include <irq_func.h>
> > >  #include <log.h>
> > >  #include <malloc.h>
> > > +#include <net-common.h>
> > >  #include <pe.h>
> > >  #include <time.h>
> > >  #include <u-boot/crc.h>
> > > @@ -2235,6 +2236,8 @@ static efi_status_t EFIAPI
> > efi_exit_boot_services(efi_handle_t image_handle,
> > >                 bootm_disable_interrupts();
> > >                 if (IS_ENABLED(CONFIG_USB_DEVICE))
> > >                         udc_disconnect();
> > > +               if (IS_ENABLED(CONFIG_DM_ETH))
> > > +                       eth_halt();
> > >                 board_quiesce_devices();
> > >                 dm_remove_devices_active();
> > >         }
> > > --
> > > 2.48.1
> > >
> >
> 
