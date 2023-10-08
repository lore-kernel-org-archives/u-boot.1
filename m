Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54FBE95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 20:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6664586898;
	Sun,  8 Oct 2023 22:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HWy0qr1p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42B5C86B3C; Sun,  8 Oct 2023 22:20:41 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6495886801
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 22:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9a645e54806so665094066b.0
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 13:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696796439; x=1697401239; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oY3Kl1E/XoZnqA5c5qfVSaGTYiDuWatQCz6SLAHnEoU=;
 b=HWy0qr1p0e1okJm33WhIvea8xADPN2RYLyVIlDc5lKg5Zfi6aaxAJ9/N12sriPRnod
 mcRlxkr6cjQDGnBtM5mT6IxINs5A4OUyHob0jBI2jezu5Y1hTcXI07mgDc5QpMd8mqtN
 rhbFNkX/UpGniYi5r6nveHzRXrs6YkEAJuaXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696796439; x=1697401239;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oY3Kl1E/XoZnqA5c5qfVSaGTYiDuWatQCz6SLAHnEoU=;
 b=PFJaipjQ8S6v7VtgShy7+L1k1RqgyYcukgLpHJ+TnL7cIMyPi3WU0rjhtANLe4tddj
 UOWFESpCPPc5QYT3du70i1121zyGvlr//T4zQH3sFtJWBi+RGgm3z/tWntSSilq/rM5g
 DlCPwzcrnK1McCF8TR1uA56VEhtqoIiSNaHMcCg6UDmmcWoKdUvZ9sMzMdAxMVBgR2Mf
 r+52+ygkikcOjGJI7bBM4TOoTl870PrsQRBk3VxAhK0tKpub1g/iNhGbwjIPJfmuy7YH
 0RYMyJdZxk9NyPUCKUlfzMKEDtbPbI4gdxAAnigcye2EsVgXMzsVd1lFoiTTKcgZ+Pgl
 fREA==
X-Gm-Message-State: AOJu0Yxd4oWvC2c0JyjcfBkvFr4o8ahDnEPnwDjmbeN0jcAsDYSAoaf/
 GmZ0EhO5LZNlXd1iI+KxG/XHpqZ6Q0z8ixt+4ml2Sg==
X-Google-Smtp-Source: AGHT+IG7SOCEJgWkQoiGVySC41x9WUipBkxRIApOWBt0KOgxU/0LrJdVVVp1/kusfI0axYzj1ojsKCXchdQvspq2POk=
X-Received: by 2002:a17:906:51ca:b0:9b8:9838:1df9 with SMTP id
 v10-20020a17090651ca00b009b898381df9mr12853909ejk.59.1696796438613; Sun, 08
 Oct 2023 13:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230727215433.578830-1-sjg@chromium.org>
 <CALeDE9MADwXU_gExvQZJnxKYDk1C1YLiZyL1jhe9-Um1hQA=6Q@mail.gmail.com>
 <CAPnjgZ2L7Rfbuj6aN3oQqOPPxywraDaL1AM6xyQiNB8T6PFPGg@mail.gmail.com>
 <CALeDE9OJpP8P-8Wk=Jt=Ju2Q8MQoLVDOjvY8HBMF6JZP3pitVg@mail.gmail.com>
In-Reply-To: <CALeDE9OJpP8P-8Wk=Jt=Ju2Q8MQoLVDOjvY8HBMF6JZP3pitVg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 8 Oct 2023 14:20:27 -0600
Message-ID: <CAPnjgZ2FGkx+v3rn24D0rdNQE3AnmJhM-=e8uzbXw7u1-J_zSg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/3] rpi: Convert to standard boot
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Matthias Brugger <mbrugger@suse.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
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

Hi Peter,

On Sun, 8 Oct 2023 at 12:02, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Simon,
>
> > > So with more testing of 2023.10 in Fedora we found a regression where
> > > the display dies when the vc4 module loads in the kernel. With further
> > > debug it was found that it was due to the new U-Boot and with
> > > bisecting it myself I have found this series is the cause of the
> > > regression.
> > >
> > > The testing I have done is with recent RPi firmware, U-Boot 2023.10
> > > and kernel 6.5.x, but also seen with 6.4.x, with a minimal text only
> > > image. I can also reproduce it by using the F-38 GA image, no updates
> > > and purely just changing the U-Boot component. I've done my testing on
> > > the RPi4.
> > >
> > > Let me know if you need more information, I believe you have a RPi you
> > > can test with.
> >
> > Thanks for the report. Which rpi should I test with? I take it that
> > vc4 is a kernel module? Do you have the error message?
>
> Well I've been testing on the RPi4 (as I mentioned above), there's no
> direct error message that's directly linked but the screen goes blank
> and turns off, even on a text only install, and yes, on the rpi4 the
> vc4 kernel module deals with driving the HDMI and other output
> interfaces (whereas the v3d is the driver for the render unit), and on
> rpi3 and older vc4 also runs the 3D render module too.

OK I have an rpi4, but I don't get that far:

>>>
U-Boot 2023.10-00111-g7d1e5aacdb4 (Oct 08 2023 - 14:14:10 -0600)

DRAM:  948 MiB (effective 3.9 GiB)
RPI 4 Model B (0xc03111)
Core:  205 devices, 16 uclasses, devicetree: board
MMC:   mmcnr@7e300000: 1, mmc@7e340000: 0
Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1...
In:    serial,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
Net:   eth0: ethernet@7d580000
PCIe BRCM: link up, 5.0 Gbps x1 (SSC)
starting USB...
Bus xhci_pci: Register 5000420 NbrPorts 5
Starting the controller
USB XHCI 1.00
scanning bus xhci_pci for devices... 3 USB Device(s) found
       scanning usb for storage devices... 1 Storage Device(s) found
Hit any key to stop autoboot:  0
U-Boot> bootfl scan
Card did not respond to voltage select! : -110
** Booting bootflow 'usb_mass_storage.lun0.bootdev.part_2' with efi
Card did not respond to voltage select! : -110
Failed to load EFI variables
ERROR: invalid device tree
Boot failed (err=-22)
<<<

Do you know what that might be? I ask because it seems that you are
actually able to boot.

I'll keep looking.

Regards,
Simon
[..]
