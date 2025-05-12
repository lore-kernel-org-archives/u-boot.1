Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D31C3ABBC
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 07:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7227581FEE;
	Mon, 12 May 2025 09:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RYiZgT23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB2A881FEE; Mon, 12 May 2025 09:00:05 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4211D800C1
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 09:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5fcc96b6a64so3728148a12.0
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 00:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747033202; x=1747638002; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RE4W61aAOb1s0oTAzxitw/T5NG98quwd4lODU2UlHFo=;
 b=RYiZgT23PDn+wAOfGHAioDIODUrK15ADbCxZjyaGbppETNuk542FrnjLQh89LVJYHh
 vsf+u1aMCfw1a4Ot697jKXC+nip/2uQ9ho8+LwJFOE9mnpq69w9/hdAiZL8qoq2Quhel
 goXAlocEAsn1tZjfkePrGm87Krk2DLt/EYPnwjpNLniq5Kh+S/GegaOnGV7GigX9rWNU
 5DFnnMwCp46sw2KR1+k1/OiH/8e3aNPxj57U867YozDsRNusU6DwRMcZR7aXHisGO43U
 oKaAItu9FY2eV4wuIFQUahCU6zu/zyUTLUDDjl/bSX2XET7GsAYz1i+lDOpgaVSZViEz
 gfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747033202; x=1747638002;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RE4W61aAOb1s0oTAzxitw/T5NG98quwd4lODU2UlHFo=;
 b=sZY/3cKlgat4FkC1t9sPlbOfLgRnYKNC8yeC2PyErU4g/dhB1XY5iMTvF7k4DGRCuX
 Pd78tColAPFAGOvY3F4Eg8byun47sW2cV/GKyVMhQy21R3s6Wag5YDs9qP5P9JpgQP3K
 y61EG/CighrvwYx5IfcQA8yDwO28ZYulCljo60wIR+K7q1wVNreEaQGNct38N56oZFb/
 SCR5NmuR3Cdje/Qb+N4LTTFFLvzgfLkQG/B8BrVAmCy0IxLo0e+lbKMWp0k2RPkBYyTj
 8X6s48vSYF8eze3XhxyreZvcyMpomMRdL53UKji04cAdB/y9fHgTEcTPLB3FVsgCKp/e
 viHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+ZSTiJKaFawj2UGX0Tohi40bB6OKiL6CZ3pf2QKTk+jeWuH7Xn5QhC1Djw5a+p1T77FuK2LQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwIVCzBadSw6PcbSih0AOsv1u/xE3r5bkYDm+cq9pMnfPpO33FF
 u61AQD1LcvgO5R2nd0CSYdObzl9gO/7ASA1wXjQXJtz8FqcAOkfxuzM1h95iCw8UuEoQ8gtGhTN
 vihTzkPmVB8gnRpGCHh7J/DyOAiI=
X-Gm-Gg: ASbGncsFBY8G5N/vrxVaHPlpqjj3+JEKUtYbTdgsJfv7FX0X5BIBtGW56ibCJlQggKl
 OxVQOgh9p3IQFIP2yVGqB9Jyhkg97n+sew6HS/qKIDTNdmDjMEybAHOA6cRsRbhxJrIYtIfEthZ
 bqYRMbvJgWdjNO0mliFHbJN2EScK3Yr0A=
X-Google-Smtp-Source: AGHT+IGMxSCbWcgPzDLdDPHV7TfxL8v/NW+1JmcI6bueniQxO5V4IVkVoPOd+64ynfcPW+GlQfBTX11OdkJnRa9tEGY=
X-Received: by 2002:a17:907:a4c1:b0:ace:d957:d6d8 with SMTP id
 a640c23a62f3a-ad2190246bamr985408566b.34.1747033201870; Mon, 12 May 2025
 00:00:01 -0700 (PDT)
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
In-Reply-To: <CAEUiLuY2D_CzkEH0+gCvkbC_MtJ4B-MLYYkx_r2E9BHxPvuVjg@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 12 May 2025 12:29:46 +0530
X-Gm-Features: AX0GCFuPfWHrJ33a9lpuqKkhYPNkooJHOZyZqq_x46YoNFQCXw_ATD6jRE8W2w8
Message-ID: <CANAwSgRvtgsejhsj=TyRAYWdQRfGRigvw9+=HzcdxbDopoiFYw@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: Wayne Schroeder <raz@chewies.net>
Cc: Ferass El Hafidi <funderscore@postmarketos.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, 
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

Hi Wayne,

On Sun, 11 May 2025 at 01:51, Wayne Schroeder <raz@chewies.net> wrote:
>
> Applied patches to 2025.04 release (applied clean).  Made stock
> defconfig for odroid n2, built, signed, installed.  The reboot issue
> remains and usb ports are unavailable to linux kernel after reboot.
>
> It is worth noting that linux does see some enumeration of devices
> after a while, but even if it logs to the console about device
> attachment, the devices don't actually function.  This was the same
> behavior with the release version.
>
Thanks for testing these patches.
We need to modify the boot order to probe USB before MMC

diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index f3275b37a51..3ace59880bd 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -119,8 +119,8 @@
 #define BOOT_TARGET_DEVICES(func) \
        func(ROMUSB, romusb, na)  \
        func(USB_DFU, usbdfu, na)  \
-       BOOT_TARGET_MMC(func) \
        BOOT_TARGET_DEVICES_USB(func) \
+       BOOT_TARGET_MMC(func) \
        BOOT_TARGET_NVME(func) \
        BOOT_TARGET_SCSI(func) \
        BOOT_TARGET_PXE(func) \

Here is the boot sequence at my end.
------------------------
U-Boot 2025.07-rc1-00223-g704a4d1fd804 (May 12 2025 - 12:15:29 +0530)
odroid-n2/n2-plus

Model: Hardkernel ODROID-N2
SoC:   Amlogic Meson G12B (S922X) Revision 29:c (40:2)
DRAM:  1 GiB (total 3.8 GiB)
Core:  402 devices, 30 uclasses, devicetree: separate
MMC:   mmc@ffe05000: 0, mmc@ffe07000: 1
Loading Environment from nowhere... OK
In:    usbkbd,serial
Out:   vidconsole,serial
Err:   vidconsole,serial
Board variant: n2-plus
Net:   eth0: ethernet@ff3f0000

Hit any key to stop autoboot:  0
starting USB...
Register 3000140 NbrPorts 3
Starting the controller
USB XHCI 1.10
Bus usb@ff500000: 4 USB Device(s) found
       scanning usb for storage devices... 1 Storage Device(s) found

Device 0: Vendor: ASMT     Rev: 0    Prod: 2115
            Type: Hard Disk
            Capacity: 114473.4 MB =3D 111.7 GB (234441648 x 512)
... is now current device
Scanning usb 0:1...
Card did not respond to voltage select! : -110
Cannot persist EFI variables without system partition
Loading Boot0000 'mmc 1' failed
Loading Boot0001 'usb 0' failed
EFI boot manager: Cannot load any image
Card did not respond to voltage select! : -110
switch to partitions #0, OK
mmc1(part 0) is current device
Scanning mmc 1:1...
Found /extlinux/extlinux.conf
Retrieving file: /extlinux/extlinux.conf
1:      Manjaro ARM
Retrieving file: /Image
Retrieving file: /initramfs-linux.img
append: initrd=3D/initramfs-linux.img console=3DttyAML0,115200n8
root=3DPARTUUID=3D0efc7c36-02 rootwait audit=3D0 clk_ignore_unused
plymouth.ignore-serial-consoles

> Wayne
>
> On Fri, May 9, 2025 at 10:01=E2=80=AFAM Wayne Schroeder <raz@chewies.net>=
 wrote:
> >
> > Yes.  Will report back how it works on the n2+.
> >
> >
> > On Fri, May 9, 2025 at 2:08=E2=80=AFAM Anand Moon <linux.amoon@gmail.co=
m> wrote:
> > >
> > > Hi Wayne,
> > >
> > > On Fri, 9 May 2025 at 01:25, Wayne Schroeder <raz@chewies.net> wrote:
> > > >
> > > > I actually already have a working solution that I documented in my
> > > > github repo (dubschro/odroid-n2).  All I do is set BOOTCOMMAND to
> > > > check/delete a flag file on my boot partition and if it is found, t=
hen
> > > > reset usb and sleep for 10 seconds.  I then have a systemd shutdown
> > > > script only on reboot to touch that file.
> > > >
> > > > CONFIG_BOOTCOMMAND=3D"fatrm mmc 0:1 reboot && echo Resetting USB on
> > > > reboot... && usb reset && sleep 10; run distro_bootcmd"
> > > >
> > > > It is a hack, but... the system reliably reboots remotely now, and
> > > > that's the important part for now.
> > > >
> > > > Wayne
I did not modify this at my end. However, this is not required with
the above fix.

Thanks
-Anand
> > > >
> > > > On Thu, May 8, 2025 at 11:22=E2=80=AFAM Ferass El Hafidi
> > > > <funderscore@postmarketos.org> wrote:
> > > > >
> > > > > On Wed May 7, 2025 at 1:03 PM UTC, Wayne Schroeder wrote:
> > > > > > It's hard for me to quantify if usb works in u-boot as I'm not =
loading
> > > > > > off of any usb storage devices.  It certainly never lets me use=
 the
> > > > > > keyboard to abort auto boot, and never has.  On reboot, to reli=
ably
> > > > >
> > > > > You can send bytes via UART to abort boot, if you happen to have =
a UART
> > > > > adapter around.
> > > >
> > > Can you test this series to see if this resolves the issue?
> > >
> > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D456088
> > >
> > > Thanks
> > > -Anand
> > >
> > > > _______________________________________________
> > > > linux-amlogic mailing list
> > > > linux-amlogic@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-amlogic
