Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23C1C3ABBC
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 10:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A8DD8091A;
	Mon, 12 May 2025 12:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TCk+cQuo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5853481DD6; Mon, 12 May 2025 12:04:39 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFC8B805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 12:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ad241baf856so292786966b.0
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747044276; x=1747649076; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H7wqUmeQxImZo9I4UjDMb0Yuabns1sdp2FRzB39Gx70=;
 b=TCk+cQuoJlcOw1RRTiUg6ONMu77DE/WOXc3yLE3s7KmZkaN3ez+UT0s+hSk1iZXfoK
 H54Rxn8UsC+Qh33zvHXBwuFP6MNoG15v60rkl6qdQWcwac3ijdRugnpgOOdq7DY0W6hW
 JzwOtlO7eG6tZW3m+e+SDAchos3LrrkYJ6LDxuau1C2jR/X5sY2Dt2rxozhgC/LyrRlo
 YDRmRJoGwPAFGqArH6dM1vKpQz0rCzDBG431VhyM0C1kMbG1NGVBSG+BWxAjpHKW4UF1
 kiRLEq5Lkrz/A+9fMjud9XnH9F7zmJw7KxuKLPi+71yJceUxHit+e8PpUPYSdE0c/KzC
 HXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747044276; x=1747649076;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H7wqUmeQxImZo9I4UjDMb0Yuabns1sdp2FRzB39Gx70=;
 b=A96dqivWVXjbwJjoP3i0iz+VtvCUkyHoMFBOZLvLnl4OMPCEmJsiAVc4NKgnDhmPPZ
 puB4F6rKtqBaG41dg5XgKiNWN9BvdW4X15OrF39vArZxZ+CX5EUW5hil0guTBbl5+Y2r
 P90RmmU4eUhHinuuf+VqLI2UcjLUb/4eibY9h3QqGazd8iFY/ww5NlfkwvUoeCmQ3ePd
 E4V75CgcbABma62tssy+0QeqZWrtccqr5UKu2D1BHk5uix0xStCphF8fwGUrELmw6Kmd
 D2kDgHRnXel0vTcayRjGlnPHcEzstuYvFkF5dgOoKR0r50aPpBb7w9oyF6xNpOy9OWE7
 Y51w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVujkItJMsyqmUSZFr1kATq8/m1VQ2Ozj+pt389aPvBx3s8pCCukIgtpI/FW/D1F9dHVCSqG9w=@lists.denx.de
X-Gm-Message-State: AOJu0YyVjn4+nlnvZbvhXn8SXK/mK6E/0zSH17P6aE8EoBsWTnuUfPj0
 fm3hcNUeMSYg4crDIZ7Eoem/xHJa1bhkBIG1+K42cB0krMHGJxuqKL9hprTi5XtIDPwC9I2KU7X
 9nFmpQG0JvBSWAL5xdWwE1KzMkXQ=
X-Gm-Gg: ASbGnctdYddYGnrk+eQ4d362vFW2CzeiRra7ITmuclncRt1y6l2UZCeDdClaqTaQXr+
 lUkZRg8xjTKWDjf5TeONp87hs3cYNqYYIzFy6jXWOGAUhaFlf0Q1GmZYHpSe7essnFBlP14pydd
 CtK14HFd1Wo84F157OhL6wD1lzNDn0GTI=
X-Google-Smtp-Source: AGHT+IFa00fBbASZiwwzqM5ZvytS2NjW0Pi9nonQttu1kOtUwY1W98EiZyn0wzjG8V4b10zs8cDhHYC7NRv5OTm1olA=
X-Received: by 2002:a17:907:980f:b0:ad2:5212:5e87 with SMTP id
 a640c23a62f3a-ad252126162mr354983066b.16.1747044276051; Mon, 12 May 2025
 03:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
 <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
 <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org>
 <CAEUiLubVazb4rgfBd-r-5AtyfBVaMFmy89OO_UZB97FM43if7w@mail.gmail.com>
 <D9QX0MRWSYW6.3ELRB73BS6PRT@postmarketos.org>
 <CAEUiLuYW61Vz4zAie2K9cnXXQxxRj150Nc-fJMQCh9NwXZQmzQ@mail.gmail.com>
 <CANAwSgRkqAj5Q4LMO-CKBSoMgO-+zd6JpbVs+eWY3kPgmj9bug@mail.gmail.com>
 <CAEUiLubakMjzhi2sUTQx1S4ciTjkL6ysx465i1t-T5zKUQdUvw@mail.gmail.com>
 <CAEUiLuY2D_CzkEH0+gCvkbC_MtJ4B-MLYYkx_r2E9BHxPvuVjg@mail.gmail.com>
 <CANAwSgRvtgsejhsj=TyRAYWdQRfGRigvw9+=HzcdxbDopoiFYw@mail.gmail.com>
 <7BAB0A37-3DA8-4FC9-AFFE-7CAE6FA92367@gmail.com>
In-Reply-To: <7BAB0A37-3DA8-4FC9-AFFE-7CAE6FA92367@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 12 May 2025 15:34:21 +0530
X-Gm-Features: AX0GCFvF7325CEN4o8poH8aCEiTW3B4cGtpSuk-e07uajOPJy3vAypccAc3rTK4
Message-ID: <CANAwSgTtU2oe4jwJySGk7wq3QqShuyUedFjeUrE-VRi=uH1_TQ@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot-amlogic@groups.io, Wayne Schroeder <raz@chewies.net>, 
 Ferass El Hafidi <funderscore@postmarketos.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Christian,

On Mon, 12 May 2025 at 15:05, Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> > On 12 May 2025, at 10:59=E2=80=AFam, Anand Moon via groups.io <linux.am=
oon=3Dgmail.com@groups.io> wrote:
> >
> > Hi Wayne,
> >
> > On Sun, 11 May 2025 at 01:51, Wayne Schroeder <raz@chewies.net> wrote:
> >>
> >> Applied patches to 2025.04 release (applied clean).  Made stock
> >> defconfig for odroid n2, built, signed, installed.  The reboot issue
> >> remains and usb ports are unavailable to linux kernel after reboot.
> >>
> >> It is worth noting that linux does see some enumeration of devices
> >> after a while, but even if it logs to the console about device
> >> attachment, the devices don't actually function.  This was the same
> >> behavior with the release version.
> >>
> > Thanks for testing these patches.
> > We need to modify the boot order to probe USB before MMC
>
> Why? Most Amlogic boards boot from an mmc device (SD or internal flash
> storage) not USB. It smells like a workaround not a fix, and I wonder
> what the performance impact on boot will be?
>
I'm providing a solution that may not apply to all Amlogic boards.
The goal is to ensure the USB device binds early, allowing the USB keyboard
and mass storage device to be detected promptly.
However, I'm unsure if booting from USB mass storage is supported.

Thanks
-Anand
> Christian
>
> > diff --git a/include/configs/meson64.h b/include/configs/meson64.h
> > index f3275b37a51..3ace59880bd 100644
> > --- a/include/configs/meson64.h
> > +++ b/include/configs/meson64.h
> > @@ -119,8 +119,8 @@
> > #define BOOT_TARGET_DEVICES(func) \
> >        func(ROMUSB, romusb, na)  \
> >        func(USB_DFU, usbdfu, na)  \
> > -       BOOT_TARGET_MMC(func) \
> >        BOOT_TARGET_DEVICES_USB(func) \
> > +       BOOT_TARGET_MMC(func) \
> >        BOOT_TARGET_NVME(func) \
> >        BOOT_TARGET_SCSI(func) \
> >        BOOT_TARGET_PXE(func) \
> >
> > Here is the boot sequence at my end.
> > ------------------------
> > U-Boot 2025.07-rc1-00223-g704a4d1fd804 (May 12 2025 - 12:15:29 +0530)
> > odroid-n2/n2-plus
> >
> > Model: Hardkernel ODROID-N2
> > SoC:   Amlogic Meson G12B (S922X) Revision 29:c (40:2)
> > DRAM:  1 GiB (total 3.8 GiB)
> > Core:  402 devices, 30 uclasses, devicetree: separate
> > MMC:   mmc@ffe05000: 0, mmc@ffe07000: 1
> > Loading Environment from nowhere... OK
> > In:    usbkbd,serial
> > Out:   vidconsole,serial
> > Err:   vidconsole,serial
> > Board variant: n2-plus
> > Net:   eth0: ethernet@ff3f0000
> >
> > Hit any key to stop autoboot:  0
> > starting USB...
> > Register 3000140 NbrPorts 3
> > Starting the controller
> > USB XHCI 1.10
> > Bus usb@ff500000: 4 USB Device(s) found
> >       scanning usb for storage devices... 1 Storage Device(s) found
> >
> > Device 0: Vendor: ASMT     Rev: 0    Prod: 2115
> >            Type: Hard Disk
> >            Capacity: 114473.4 MB =3D 111.7 GB (234441648 x 512)
> > ... is now current device
> > Scanning usb 0:1...
> > Card did not respond to voltage select! : -110
> > Cannot persist EFI variables without system partition
> > Loading Boot0000 'mmc 1' failed
> > Loading Boot0001 'usb 0' failed
> > EFI boot manager: Cannot load any image
> > Card did not respond to voltage select! : -110
> > switch to partitions #0, OK
> > mmc1(part 0) is current device
> > Scanning mmc 1:1...
> > Found /extlinux/extlinux.conf
> > Retrieving file: /extlinux/extlinux.conf
> > 1:      Manjaro ARM
> > Retrieving file: /Image
> > Retrieving file: /initramfs-linux.img
> > append: initrd=3D/initramfs-linux.img console=3DttyAML0,115200n8
> > root=3DPARTUUID=3D0efc7c36-02 rootwait audit=3D0 clk_ignore_unused
> > plymouth.ignore-serial-consoles
> >
> >> Wayne
> >>
> >> On Fri, May 9, 2025 at 10:01=E2=80=AFAM Wayne Schroeder <raz@chewies.n=
et> wrote:
> >>>
> >>> Yes.  Will report back how it works on the n2+.
> >>>
> >>>
> >>> On Fri, May 9, 2025 at 2:08=E2=80=AFAM Anand Moon <linux.amoon@gmail.=
com> wrote:
> >>>>
> >>>> Hi Wayne,
> >>>>
> >>>> On Fri, 9 May 2025 at 01:25, Wayne Schroeder <raz@chewies.net> wrote=
:
> >>>>>
> >>>>> I actually already have a working solution that I documented in my
> >>>>> github repo (dubschro/odroid-n2).  All I do is set BOOTCOMMAND to
> >>>>> check/delete a flag file on my boot partition and if it is found, t=
hen
> >>>>> reset usb and sleep for 10 seconds.  I then have a systemd shutdown
> >>>>> script only on reboot to touch that file.
> >>>>>
> >>>>> CONFIG_BOOTCOMMAND=3D"fatrm mmc 0:1 reboot && echo Resetting USB on
> >>>>> reboot... && usb reset && sleep 10; run distro_bootcmd"
> >>>>>
> >>>>> It is a hack, but... the system reliably reboots remotely now, and
> >>>>> that's the important part for now.
> >>>>>
> >>>>> Wayne
> > I did not modify this at my end. However, this is not required with
> > the above fix.
> >
> > Thanks
> > -Anand
> >>>>>
> >>>>> On Thu, May 8, 2025 at 11:22=E2=80=AFAM Ferass El Hafidi
> >>>>> <funderscore@postmarketos.org> wrote:
> >>>>>>
> >>>>>> On Wed May 7, 2025 at 1:03 PM UTC, Wayne Schroeder wrote:
> >>>>>>> It's hard for me to quantify if usb works in u-boot as I'm not lo=
ading
> >>>>>>> off of any usb storage devices.  It certainly never lets me use t=
he
> >>>>>>> keyboard to abort auto boot, and never has.  On reboot, to reliab=
ly
> >>>>>>
> >>>>>> You can send bytes via UART to abort boot, if you happen to have a=
 UART
> >>>>>> adapter around.
> >>>>>
> >>>> Can you test this series to see if this resolves the issue?
> >>>>
> >>>> https://patchwork.ozlabs.org/project/uboot/list/?series=3D456088
> >>>>
> >>>> Thanks
> >>>> -Anand
> >>>>
> >>>>> _______________________________________________
> >>>>> linux-amlogic mailing list
> >>>>> linux-amlogic@lists.infradead.org
> >>>>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Groups.io Links: You receive all messages sent to this group.
> > View/Reply Online (#2696): https://groups.io/g/u-boot-amlogic/message/2=
696
> > Mute This Topic: https://groups.io/mt/112625435/6407323
> > Group Owner: u-boot-amlogic+owner@groups.io
> > Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [christianshewitt=
@gmail.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
