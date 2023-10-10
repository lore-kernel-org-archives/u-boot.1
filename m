Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6207FCD8CA1
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 14:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 701DC86C56;
	Tue, 10 Oct 2023 16:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T1RPhgfP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EC9986CCF; Tue, 10 Oct 2023 16:58:31 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BF2386DD6
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 16:58:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-538575a38ffso9439311a12.1
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696949892; x=1697554692; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jsj6jLX1LJ3PJkDRl0JML3QYWfsPHSopDXNDQf9WTBQ=;
 b=T1RPhgfPeFQalmohsDicvyGH5QEdN2JJ/DdQpN8uP5awRWti23Tadcno/bNC60P1hQ
 4UKoFFyXR6/R7QuSS/0+PCocuKz7KxYdweIvtzSg0OE5uZrwTILyzq4tTMG/iPHiP421
 0qibCtHuRR80czUnZACTG2Qi8bFZFIIbVd7So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696949892; x=1697554692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jsj6jLX1LJ3PJkDRl0JML3QYWfsPHSopDXNDQf9WTBQ=;
 b=g0gwY1xcj/9rvT3TvLHGY/IOdSYCdt9mO8Y9J+TKSCSaO3HDaYUXDbHDxR0dsbxZqz
 hSO6YDDEx0Snyd2oFNbNuUcH8Fh78PlWl9Fp6NgumqSpyyYpwkkLBfmF0OMsSn7LmeQB
 uJQccS0v3dKRwuklHPyJnB861tsbZ5Zp9efd3bdSJcAoatMkc1HWA8fZ9GO+FwqPJ5rP
 QL0XEuc2ur7MwZkwrUFE4gxkSZg9j6Ieu7IB4Xz0905/1oAoXchI7IrMY7khHU9w78U+
 Ut8T5SAvU57X6nTsDIeaVkFNkguPKiwO/Z72CO2gQseGbMjkUppf/ruGWdWM/jlCuLRS
 I2Wg==
X-Gm-Message-State: AOJu0Yx9PE3MUjZiR6nDDK9LhKWvZ5Dc/zb+DqsIP5tms3kxdnH5ckRz
 8bEgsx4sk+7rs5NrJ7ERDa9yADCbTdtKXrodF+gPdJPTkUx1Yyipj/4=
X-Google-Smtp-Source: AGHT+IE4NoQ+T3fM3pjpeAwzWh1WBrBw+smKGrJIETgDVcx+rch4myl1ZZ+xpjm4SK/Zz8j+f7ShAGNRE2Tgn9bEFDs=
X-Received: by 2002:a17:907:7613:b0:9ae:55ae:587f with SMTP id
 jx19-20020a170907761300b009ae55ae587fmr15339383ejc.37.1696949891730; Tue, 10
 Oct 2023 07:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR08MB2847E276099DF7263424F70083CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CALeDE9N6nhRBwtYqJ=7nqYuCsmbw03j3RBXRQ8jYsD=OMY=gBw@mail.gmail.com>
 <VI1PR08MB28474179AFB989B308072B1E83CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
In-Reply-To: <VI1PR08MB28474179AFB989B308072B1E83CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Oct 2023 08:57:59 -0600
Message-ID: <CAPnjgZ3t9-trzoLGc7Jcj0=J0sQLQcHSGN3_Pf+3=iZ6=rPPqA@mail.gmail.com>
Subject: Re: U-Boot 2023.10 does not boot from uSD on RPi4
To: Guillaume Gardet <Guillaume.Gardet@arm.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Ivan Ivanov <ivan.ivanov@suse.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,

On Tue, 10 Oct 2023 at 04:39, Guillaume Gardet <Guillaume.Gardet@arm.com>
wrote:
>
>
>
> > -----Original Message-----
> > From: Peter Robinson <pbrobinson@gmail.com>
> > Sent: Tuesday, October 10, 2023 12:22 PM
> > To: Guillaume Gardet <Guillaume.Gardet@arm.com>
> > Cc: mbrugger@suse.com; Ivan Ivanov <ivan.ivanov@suse.com>; Simon Glass
> > <sjg@chromium.org>; u-boot@lists.denx.de
> > Subject: Re: U-Boot 2023.10 does not boot from uSD on RPi4
> >
> > On Tue, Oct 10, 2023 at 10:26=E2=80=AFAM Guillaume Gardet
> > <Guillaume.Gardet@arm.com> wrote:
> > >
> > > Hi,
> > >
> > > U-Boot 2023.10 does not boot from uSD on RPi4.
> > > This has been found on openSUSE Tumbleweed. The only diff we need is:
> > >   -CONFIG_OF_EMBED=3Dy
> > >   +CONFIG_OF_BOARD=3Dy
> > > To use firmware provided Device Tree. But that should not affect the
mmc
> > behavior too much, I think.
> >
> > I've been booting Fedora fine on a RPi4 BUT there's issues with the
display
> > turning off [1] when the accelerated display modules load
> > (vc4) as a result of this patch set. Can you confirm if that's the same
problem
> > you're seeing?
>
> No, that's not my problem. My issue is grub was not loaded by u-boot from
uSD.
> It seems more like Simon's problem:
https://lists.denx.de/pipermail/u-boot/2023-October/533162.html
>
> @Simon, can you check if the patch below fixes your boot problem on RPi4,
please?

This has been reported at least twice before. There is a fix [2] which is
in my queue to apply.

Regarding the display problem, I got my rpi4 running again and Fedora
installed, but I won't get back to it until the end of the week as I'm at
osfc.

Regards,
Simon

>
> Thanks,
> Guillaume
>

[2]
https://patchwork.ozlabs.org/project/uboot/patch/20230923205017.1754340-1-s=
jg@chromium.org/

> >
> > [1] https://lists.denx.de/pipermail/u-boot/2023-October/533158.html
> >
> > > 'git bisect' points to:
> > > **********
> > > commit c771e5b8c2a186fb072b6c6f571d4a3cc86efba9
> > > Author: Simon Glass <sjg@chromium.org>
> > > Date:   Thu Jul 27 15:54:28 2023 -0600
> > >
> > >     arm: rpi: Switch to standard boot
> > >
> > >     Drop use of the distro scripts and use standard boot instead.
> > >
> > >     We don't need to specify the mmc devices individually, since they
are
> > >     used in order from 0 to 2, and standard boot uses that order
anyway.
> > >
> > >     Signed-off-by: Simon Glass <sjg@chromium.org>
> > > **********
> > >
> > > The following patch fixes the boot from uSD on RPi4 (not tested on
RPi3 nor RPi
> > Zero 2 W):
> > > **********
> > > diff --git a/board/raspberrypi/rpi/rpi.env
> > > b/board/raspberrypi/rpi/rpi.env index 30228285ed..02210b97b5 100644
> > > --- a/board/raspberrypi/rpi/rpi.env
> > > +++ b/board/raspberrypi/rpi/rpi.env
> > > @@ -74,4 +74,4 @@ pxefile_addr_r=3D0x02500000
> > >  fdt_addr_r=3D0x02600000
> > >  ramdisk_addr_r=3D0x02700000
> > >
> > > -boot_targets=3Dmmc usb pxe dhcp
> > > +boot_targets=3Dmmc0 mmc1 mmc2 usb pxe dhcp
> > > **********
> > >
> > > So, the comment from Simon " We don't need to specify the mmc devices
> > individually, since they are used in order from 0 to 2, and standard
boot uses that
> > order anyway" seems wrong for the RPi4 case.
> > >
> > > Cheers,
> > > Guillaume
> > >
> > > IMPORTANT NOTICE: The contents of this email and any attachments are
> > confidential and may also be privileged. If you are not the intended
recipient,
> > please notify the sender immediately and do not disclose the contents
to any
> > other person, use it for any purpose, or store or copy the information
in any
> > medium. Thank you.
> IMPORTANT NOTICE: The contents of this email and any attachments are
confidential and may also be privileged. If you are not the intended
recipient, please notify the sender immediately and do not disclose the
contents to any other person, use it for any purpose, or store or copy the
information in any medium. Thank you.
