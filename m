Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3F2CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18EB586FC2;
	Sun, 15 Oct 2023 09:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gt0Ipie8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFD3A86F85; Sun, 15 Oct 2023 09:04:19 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A715386FAF
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-507a0907896so1446066e87.2
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697353307; x=1697958107; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cIA25xfmbKRFZt6IzxVWfCQ5le9F57gd8Cth/59w1TI=;
 b=Gt0Ipie8MQEDhQnosflch8eTyxVUU4wulQp0JPFMVcLC0zgJjRFQFjUxKVrDL33qUw
 YviNbXjP/rrQ6B6aDrxwNtoTeAt3La4PCVk//DWmxPzEjO7dD43nUhGzOHeJiTFXNYbw
 X6ofVbJtsjVr1iMKXN25WrhEp7tbJ0Nx+gP38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697353307; x=1697958107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cIA25xfmbKRFZt6IzxVWfCQ5le9F57gd8Cth/59w1TI=;
 b=Be7u2l5LxOgOh8/UpaTz5s0HnWP5F3l0ZYj4I9CwZ0BK8WEBbKsQqcWdKi0Fnjhg9U
 3P9y/sIVswcrGbPb+D3TavXO6Mbo7td0SpWWdo1O+Qr1AhlDScVnsJ/AOcAlLgakcjn0
 fxMs87I7cHXzwy6qU12XqFcQRi1MbPJEfzgkRKUD0kBaZuz2qHBkZzlN71SG/+Mxmklw
 jKOKyDkkNjOSqLkJX+RGlsYXN3hMEUwsYn1/hTo5RS78qQZtSiMNHoz09f8Xkye/Oim4
 qtHCKlq1JnjB3S4NB9Mk0q6XyTmihymN1Ye80/Mv5alBWboiAY3ykz86g1URwrXoxq3y
 VLzw==
X-Gm-Message-State: AOJu0YxY6RMN8BybOyWRjnuOjhQvZyKfPDa2/m862Wu0Yz8nMDnhbMgZ
 0imJ2p03BeOsZ3DT6nprHwGMoEUpnNFXizH47PBxPcj9TWF77ZkB6ho=
X-Google-Smtp-Source: AGHT+IHNYAxqFOKWm6AjHO0lY1ULovK09x05xuMDe1y8/QtzkM6Mvqfr7DqonPHAZIBqMB9BvcT7xiJwWs4B0Qg7HXU=
X-Received: by 2002:a50:f61e:0:b0:53e:817e:488 with SMTP id
 c30-20020a50f61e000000b0053e817e0488mr1675012edn.11.1697326521021; Sat, 14
 Oct 2023 16:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230727215433.578830-1-sjg@chromium.org>
 <CALeDE9MADwXU_gExvQZJnxKYDk1C1YLiZyL1jhe9-Um1hQA=6Q@mail.gmail.com>
 <CAPnjgZ2L7Rfbuj6aN3oQqOPPxywraDaL1AM6xyQiNB8T6PFPGg@mail.gmail.com>
 <CALeDE9OJpP8P-8Wk=Jt=Ju2Q8MQoLVDOjvY8HBMF6JZP3pitVg@mail.gmail.com>
 <CAPnjgZ2FGkx+v3rn24D0rdNQE3AnmJhM-=e8uzbXw7u1-J_zSg@mail.gmail.com>
 <CAPnjgZ0HCt6G-hgaxHp7=5VN35iknFGXsbqatVrjLZtDc91HyQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ0HCt6G-hgaxHp7=5VN35iknFGXsbqatVrjLZtDc91HyQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 14 Oct 2023 17:35:08 -0600
Message-ID: <CAPnjgZ1+W0Mcaftn957agnE=comq+pUo-KuOhsSf4xpFcFG=Fw@mail.gmail.com>
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

On Tue, 10 Oct 2023 at 08:58, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Peter,
>
> On Sun, 8 Oct 2023 at 14:20, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Peter,
> >
> > On Sun, 8 Oct 2023 at 12:02, Peter Robinson <pbrobinson@gmail.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > > > So with more testing of 2023.10 in Fedora we found a regression where
> > > > > the display dies when the vc4 module loads in the kernel. With further
> > > > > debug it was found that it was due to the new U-Boot and with
> > > > > bisecting it myself I have found this series is the cause of the
> > > > > regression.
> > > > >
> > > > > The testing I have done is with recent RPi firmware, U-Boot 2023.10
> > > > > and kernel 6.5.x, but also seen with 6.4.x, with a minimal text only
> > > > > image. I can also reproduce it by using the F-38 GA image, no updates
> > > > > and purely just changing the U-Boot component. I've done my testing on
> > > > > the RPi4.
> > > > >
> > > > > Let me know if you need more information, I believe you have a RPi you
> > > > > can test with.
> > > >
> > > > Thanks for the report. Which rpi should I test with? I take it that
> > > > vc4 is a kernel module? Do you have the error message?
> > >
> > > Well I've been testing on the RPi4 (as I mentioned above), there's no
> > > direct error message that's directly linked but the screen goes blank
> > > and turns off, even on a text only install, and yes, on the rpi4 the
> > > vc4 kernel module deals with driving the HDMI and other output
> > > interfaces (whereas the v3d is the driver for the render unit), and on
> > > rpi3 and older vc4 also runs the 3D render module too.
> >
> > OK I have an rpi4, but I don't get that far:
> >
> > >>>
> > U-Boot 2023.10-00111-g7d1e5aacdb4 (Oct 08 2023 - 14:14:10 -0600)
> >
> > DRAM:  948 MiB (effective 3.9 GiB)
> > RPI 4 Model B (0xc03111)
> > Core:  205 devices, 16 uclasses, devicetree: board
> > MMC:   mmcnr@7e300000: 1, mmc@7e340000: 0
> > Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1...
> > In:    serial,usbkbd
> > Out:   serial,vidconsole
> > Err:   serial,vidconsole
> > Net:   eth0: ethernet@7d580000
> > PCIe BRCM: link up, 5.0 Gbps x1 (SSC)
> > starting USB...
> > Bus xhci_pci: Register 5000420 NbrPorts 5
> > Starting the controller
> > USB XHCI 1.00
> > scanning bus xhci_pci for devices... 3 USB Device(s) found
> >        scanning usb for storage devices... 1 Storage Device(s) found
> > Hit any key to stop autoboot:  0
> > U-Boot> bootfl scan
> > Card did not respond to voltage select! : -110
> > ** Booting bootflow 'usb_mass_storage.lun0.bootdev.part_2' with efi
> > Card did not respond to voltage select! : -110
> > Failed to load EFI variables
> > ERROR: invalid device tree
> > Boot failed (err=-22)
> > <<<
> >
> > Do you know what that might be? I ask because it seems that you are
> > actually able to boot.
> >
> > I'll keep looking.
>
> This was apparently a corrupted uSD card as I tried again and it booted.

It boots up and I see a strange greenish cloud picture. But the image
disappears every 10 seconds or so. Is that the problem you are seeing?

Then I tried again with bootstd disabled and it booted with the fedora
thing in the top left. No flicker.

Then I tried again with bootstd enabled and it booted with the fedora
thing in the middle No flicker.

So I am not sure what is going on here.

I noticed this in the output when booting from Fedora (without updating U-Boot):

Found EFI removable media binary efi/boot/bootaa64.efi
Found DTB mmc 0:2 /dtb/broadcom/bcm2711-rpi-4-b.dtb

The first line looks OK, but I cannot see the second line anywhere in
the distro scripts. Also I know of no mechanism to use a DT from a
different partition than the EFI app. Could Fedora be doing something
strange here?

One last thing is that Fedora has the DT files in the root dir of
partition 1. They should be in the dtb/broadcom directory, I believe.

Regards,
Simon
