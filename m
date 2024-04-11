Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E4BC4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 21:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A53F488120;
	Thu, 11 Apr 2024 23:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hFW+TOI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B228D880A8; Thu, 11 Apr 2024 23:54:06 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DD5588120
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 23:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d6c9678cbdso2916891fa.2
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 14:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712872443; x=1713477243; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzaVb6x4UCTdbd58jPL+C9xLkdZbCIJlFvTCQNZCH7Q=;
 b=hFW+TOI7A+2BZT1gRooJI5m2VNGYxT5MdBkXYXJBEIxySa3/+ATyerJTE2dPDF7Hii
 YHYiwPck65lw0x1PLosoIZ1hKKajx1k4NlAMZ0dvLpA7uYEQzH+UmOf4yyqoQsXWIxpX
 usVsthxfNZXREQQL71kdFTW98TmKPY6HCkhFaPewwtWMDw32ZRtMA30sRC72DSaWFvgd
 j3g1A6hRxrI/MNfAwBayrlRjaNSEBTFthfZ7Gvcq8/FbaES0hivP1mviy6NJO3f+Lezx
 /Oy1uWEprXWdNaT2qTGbGVINGk7YSIcYwDsEdeltCx4gCEs/1NQYNzh9rBOQNM1gJJX9
 ulnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712872443; x=1713477243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzaVb6x4UCTdbd58jPL+C9xLkdZbCIJlFvTCQNZCH7Q=;
 b=NbpV79dMbSA7FAjqOVtMtKzq/6zr4JRWOOjdMBBKIV3Ps6pfgVOxT0W4HPrCNT6FEI
 RGdx7hsdkF6sSABN7IOBCiGAL7XuAxJo+LeZmQtsrlrEJT+tdaCw1AQEwdqGJ3j3CP3u
 t34gWLAuz/tmavwpFXy3B4utkObhC57Vcs2wY9c+NSEqlI8FhiCDRQXfw62DgImzSQc7
 f0p/Wh7XlpOb7IbYUOasl3Wr0nJ0Ktn2eYmIZxFZ9D1jx+AcRk6lr39F0EoB+Q54ACW1
 A8p83xS3wSOUwhtdydKZ4pl29XLaHLTu1CEx3n/EOHUKkoW8i22M7/HXGu0ohOd6P8J3
 erbA==
X-Gm-Message-State: AOJu0YwGPdAh9k1SbnyeDbGjl3y0JKi95PIdyc74yx9CSP8lCEzIPMgA
 +UA5yfySYgq0Bo1mo817cnRe36asaG+26u1KGblFtKs+u8tS8kXPxstGktFOI2OuAA/8hVI+ub1
 8f6np1CraZFocV5nL5Kdb7paOTJk=
X-Google-Smtp-Source: AGHT+IGmZoRkgPiMTb8ImoeFsH4kSaSsVxy0TD8XyhDk5bxCclZvb3FK6EdK67OUMOTB1hp9K7ZNKCCrFDi4Y9LBDo0=
X-Received: by 2002:a2e:a385:0:b0:2d8:5cc7:fa97 with SMTP id
 r5-20020a2ea385000000b002d85cc7fa97mr375460lje.26.1712872442595; Thu, 11 Apr
 2024 14:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230608195631.55364-1-CFSworks@gmail.com>
 <ZheG8J8h-X5GPdwX@titan>
 <CAH5Ym4gEJi693VRtrdgQAUmqQuQCCmQ1ASYJofQw92M6nBHyXA@mail.gmail.com>
 <ZheThnKWQJ3Zah-t@titan>
In-Reply-To: <ZheThnKWQJ3Zah-t@titan>
From: Sam Edwards <cfsworks@gmail.com>
Date: Thu, 11 Apr 2024 15:53:51 -0600
Message-ID: <CAH5Ym4jgSbRsRQF21LbuQAft6-q5i6ssJc21p+S1qXfyme0mng@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] sunxi, usb: UDC/DM gadget model support
To: John Watts <contact@jookia.org>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Marek Vasut <marex@denx.de>
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

On Thu, Apr 11, 2024 at 1:40=E2=80=AFAM John Watts <contact@jookia.org> wro=
te:
>
> On Thu, Apr 11, 2024 at 12:52:14AM -0600, Sam Edwards wrote:
> > Hi John,
> >
> > This patch was developed against (and used very heavily on) the Turing
> > Pi 2, which has an Allwinner T113-s3 SoC. Likely it should work for
> > any T113/D1 board. I haven't been encountering any USB errors but also
> > my use case hasn't gone much beyond the `udc` command. What
> > device/errors do you have over there?
> >
> > Cheers,
> > Sam
>
> Hi Sam,
>
> I made a list of things that do work:
>
> - DFU (slowly, probably due to no DMA) to RAM
> - CDC serial console
>
> Running a command like this:
>
> ubi part ubi; ubifsmount ubi:root; ums 0 ubi 0;

Hi John,

Ahh I see the problem. In U-Boot, `ubi` isn't actually a block device:
it's implemented as a stub in the block layer, and the filesystem
layer redirects `ubi` accesses to the currently-mounted ubifs instead.
But the `ums` command works on the block layer, so it's not being
intercepted, and instead hitting that stub and likely crashing. In the
spirit of the Linux ubiblock driver, I have another patchset[1] I've
been working on[2] to expose static ubivols as true read-only block
devices. Note that this only works for static volumes: the access
semantics of dynamic volumes are too flash-like to support block
device access, so accessing them with `ums` likely will never work
like users expect.

Still, there could be some interaction issue between `ums`<->USB that
I haven't identified. Could you try with mmc (if available) or a
ramdisk (otherwise) just to confirm that `ums` is fine?

Regards,
Sam

[1] https://lore.kernel.org/u-boot/20230812000606.72319-1-CFSworks@gmail.co=
m/T/
[2] Not very diligently; if you're interested in helping test it, I'd
love to get back to it.

>
> Gives this output in dmesg:
>
> [3633079.772330] usb-storage 1-1.1:1.0: USB Mass Storage device detected
> [3633079.772506] scsi host9: usb-storage 1-1.1:1.0
> [3633080.794607] scsi 9:0:0:0: Direct-Access     Linux    UMS disk 0     =
  ffff PQ: 0 ANSI: 2
> [3633080.794941] sd 9:0:0:0: Attached scsi generic sg6 type 0
> [3633080.795214] sd 9:0:0:0: [sdg] 3942645758 512-byte logical blocks: (2=
.02 TB/1.83 TiB)
> [3633080.795220] sd 9:0:0:0: [sdg] 3925868545-byte physical blocks
> [3633080.795341] sd 9:0:0:0: [sdg] Write Protect is off
> [3633080.795345] sd 9:0:0:0: [sdg] Mode Sense: 0f 00 00 00
> [3633080.795462] sd 9:0:0:0: [sdg] Write cache: enabled, read cache: enab=
led, doesn't support DPO or FUA
> [3633080.907359] usb 1-1.1: reset high-speed USB device number 44 using x=
hci_hcd
> [3633081.021905] usb 1-1.1: device descriptor read/64, error -71
> [3633081.238566] usb 1-1.1: device descriptor read/64, error -71
> [3633081.448573] usb 1-1.1: reset high-speed USB device number 44 using x=
hci_hcd
> [3633081.558566] usb 1-1.1: device descriptor read/64, error -71
> [3633081.775236] usb 1-1.1: device descriptor read/64, error -71
> [3633081.988559] usb 1-1.1: reset high-speed USB device number 44 using x=
hci_hcd
> [3633086.788615] usb 1-1.1: Device not responding to setup address.
> [3633091.799190] usb 1-1.1: Device not responding to setup address.
> [3633092.008482] usb 1-1.1: device not accepting address 44, error -71
> [3633092.747719] usb 1-1.1: USB disconnect, device number 44
> [3633092.748488] device offline error, dev sdg, sector 0 op 0x0:(READ) fl=
ags 0x0 phys_seg 2 prio class 2
> [3633092.748502] buffer_io_error: 10 callbacks suppressed
> [3633092.748504] Buffer I/O error on dev sdg, logical block 0, async page=
 read
> [3633092.748511] Buffer I/O error on dev sdg, logical block 1, async page=
 read
> [3633092.748520] device offline error, dev sdg, sector 4 op 0x0:(READ) fl=
ags 0x0 phys_seg 2 prio class 2
> [3633092.748525] Buffer I/O error on dev sdg, logical block 2, async page=
 read
> [3633092.748529] Buffer I/O error on dev sdg, logical block 3, async page=
 read
> [3633092.748582] device offline error, dev sdg, sector 0 op 0x0:(READ) fl=
ags 0x0 phys_seg 4 prio class 2
> [3633092.748594] Buffer I/O error on dev sdg, logical block 0, async page=
 read
> [3633092.748600] Buffer I/O error on dev sdg, logical block 1, async page=
 read
> [3633092.748605] Buffer I/O error on dev sdg, logical block 2, async page=
 read
> [3633092.748609] Buffer I/O error on dev sdg, logical block 3, async page=
 read
> [3633092.748621] ldm_validate_partition_table(): Disk read failed.
> [3633092.748638] device offline error, dev sdg, sector 0 op 0x0:(READ) fl=
ags 0x0 phys_seg 2 prio class 2
> [3633092.748644] Buffer I/O error on dev sdg, logical block 0, async page=
 read
> [3633092.748649] Buffer I/O error on dev sdg, logical block 1, async page=
 read
> [3633092.748665] device offline error, dev sdg, sector 4 op 0x0:(READ) fl=
ags 0x0 phys_seg 2 prio class 2
> [3633092.748686] device offline error, dev sdg, sector 0 op 0x0:(READ) fl=
ags 0x0 phys_seg 2 prio class 2
> [3633092.748704] device offline error, dev sdg, sector 4 op 0x0:(READ) fl=
ags 0x0 phys_seg 2 prio class 2
> [3633092.748726] device offline error, dev sdg, sector 0 op 0x0:(READ) fl=
ags 0x0 phys_seg 2 prio class 2
> [3633092.748744] device offline error, dev sdg, sector 4 op 0x0:(READ) fl=
ags 0x0 phys_seg 2 prio class 2
> [3633092.748754]  sdg: unable to read partition table
> [3633092.748825] sd 9:0:0:0: [sdg] Attached SCSI removable disk
>
> Hitting Ctrl-C in U-Boot then re-running the command gives this output:
>
> CTRL+C - Operation aborted
> =3D> ubi part ubi; ubifsmount ubi:root; ums 0 ubi 0;
> UBI partition 'ubi' already selected
> UMS: LUN 0, dev ubi -352321538, hwpart 234, sector 0x0, count 0xeafffffe
> prefetch abort
> pc : [<e8fd9ffa>]          lr : [<45fb7665>]
> reloc pc : [<e5e53ffa>]    lr : [<42e31665>]
> sp : 45d5f970  ip : 45dd66a8     fp : 00000000
> r10: 45ff88ec  r9 : 45d65eb0     r8 : 45dd1fe8
> r7 : 45dd1fd8  r6 : 45ff5f18     r5 : 45dd5600  r4 : 45fff4f0
> r3 : e8fd9fff  r2 : 45ff3260     r1 : 00000005  r0 : 45dd5594
> Flags: Nzcv  IRQs off  FIQs off  Mode SVC_32 (T)
> Code: ffff ffff fefd ffff (ffff) ffff
> Resetting CPU ...
>
> Fastboot instantly downloads an image but produces this output:
>
> =3D> fastboot 0
> musb-hdrc: peripheral reset irq lost!
> Starting download of 7317504 bytes
> .......................................................
> downloading of 7317504 bytes finished
> Booting kernel at 42000000...
>
>
> Wrong Image Type for bootm command
> ERROR -91: can't get kernel image!
> resetting ...
>
>
> Running 'fastboot stage' to just upload an image then hitting Ctrl-C in U=
-Boot gives this error:
>
> undefined instruction
> pc : [<45d69280>]          lr : [<45fb8c0b>]
> reloc pc : [<42be3280>]    lr : [<42e32c0b>]
> sp : 45d5fa28  ip : 45d6b59c     fp : 00000000
> r10: 00000002  r9 : 45d65eb0     r8 : 00000000
> r7 : 00000002  r6 : 45d68c3c     r5 : 00000000  r4 : 45d69288
> r3 : 45d69280  r2 : 00000001     r1 : 00001238  r0 : 45d69288
> Flags: nZCv  IRQs off  FIQs off  Mode SVC_32
> Code: ffffffff ffffffff ffffffff ffffffff (ffffffff)
> Resetting CPU ...
>
> Not too sure what's happening here.
>
> John.
>
> >
> > >
> > > John.
> > >
> > > On Thu, Jun 08, 2023 at 01:56:29PM -0600, Sam Edwards wrote:
> > > > Happy Thursday, U-Boot list!
> > > >
> > > > Here is attempt 2 at making this USB controller driver compatible w=
ith
> > > > DM's gadget model, following what most of the other musb variants d=
o.
> > > >
> > > > v2 removes the unwanted printfs in the probe func, per feedback fro=
m Marek.
> > > > I received no other feedback against v1 of this patch.
> > > >
> > > > Cheers,
> > > > Sam
> > > >
> > > > Sam Edwards (2):
> > > >   usb: musb-new: sunxi: remove unwanted printfs
> > > >   usb: musb-new: sunxi: make compatible with UDC/DM gadget model
> > > >
> > > >  drivers/usb/musb-new/sunxi.c | 52 +++++++++++++++++++++-----------=
----
> > > >  1 file changed, 31 insertions(+), 21 deletions(-)
> > > >
> > > > --
> > > > 2.39.2
> > > >
