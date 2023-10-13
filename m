Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE17CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B64286E5E;
	Fri, 13 Oct 2023 18:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PQXLlrF9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4952586E5E; Fri, 13 Oct 2023 18:10:50 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13E8D86F02
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53e3b8f906fso1646990a12.2
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697213396; x=1697818196; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PNWM0h+GC6ThYKsnpe0685Mt/4So8EsB2dEjvh5vTyo=;
 b=PQXLlrF9YYP5lIHFbOAsvs8/n//unwxYrUbXaEJoiyfaGaMgzCZKFXKekzWQurYuCe
 vIN2r45V+nDh20apFQIFBocK+3Hu6Uf4erbpSXx46CkkSwwLjhFtjh+56D+KBxOQ+LVB
 Pr/h/z2nHygkYnmz2G+qatA+XLvlYG7Vbzje4lhd2VzEkqE2ip2mK+L4bYAUP5KvyPsG
 t/BVRW/HP9aSpCTod2b5WVjyABlahrC5/DcaKmgzSTeU1099X7KeYMiZTPS70fDxuLzE
 CY8woKfNgwC8FWBVdqlhA9cmlPSFuM/38HyrjOz3Sps3E7CUZB4q28N1jWxlKJuAUHT7
 PhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697213396; x=1697818196;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PNWM0h+GC6ThYKsnpe0685Mt/4So8EsB2dEjvh5vTyo=;
 b=A4rxt2LDrtFaV7J2tgI2QiHkDmxJAElgqyGk/Kb/FiTs87YSuG/BNiSgAnuWEm5254
 oS+4llcErMfizAV95Z1BTfilT+CXbwM5L1D//SK49NSM3xnCn1o5YYSkfAPR5YkVWvUw
 zRWbXceXHsOOGEpN0ySatM1HfUsISQw8mQpzHvCJZwscyP9at/Ll6NHORq5N+hiMkNRD
 U7gqqdzknkaCVlMLjmLRhftsif5UiCajOVjEb/d8A/xb/1SQEEoAxyiLd4wFmPaWsEiG
 aEEO6fBb3XNFN2tUrVkY11B37zwo39KP7GSmYXDptvto7vZrN0a+QKRsZbYcdQ2qCcC0
 6JUw==
X-Gm-Message-State: AOJu0YxN2fK6kRU1O+StElA1VS0MacNnvdX1HVCMCsx3xjh2kn1GgAN0
 e6Tc/PFHPB0892C0wToVG10DKaIAH3hmLyg5fpA=
X-Google-Smtp-Source: AGHT+IFk9GMTV8i8zQfAAWuX6nqZ1Mj2s4fct7grxRSox68OoWkGFnC6ua+GYlq4EZpbc1tSwUAgw+uLnzw8ZpBCm9I=
X-Received: by 2002:a05:6402:34d1:b0:53e:2c59:73e7 with SMTP id
 w17-20020a05640234d100b0053e2c5973e7mr3341555edc.32.1697213396272; Fri, 13
 Oct 2023 09:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR08MB2847E276099DF7263424F70083CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CALeDE9N6nhRBwtYqJ=7nqYuCsmbw03j3RBXRQ8jYsD=OMY=gBw@mail.gmail.com>
 <VI1PR08MB28474179AFB989B308072B1E83CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CAPnjgZ3t9-trzoLGc7Jcj0=J0sQLQcHSGN3_Pf+3=iZ6=rPPqA@mail.gmail.com>
In-Reply-To: <CAPnjgZ3t9-trzoLGc7Jcj0=J0sQLQcHSGN3_Pf+3=iZ6=rPPqA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 13 Oct 2023 17:09:45 +0100
Message-ID: <CALeDE9Oh9c+X5tG9RswuE=a=yQRW-j93q2oHJeOehLHHY2bSgw@mail.gmail.com>
Subject: Re: U-Boot 2023.10 does not boot from uSD on RPi4
To: Simon Glass <sjg@chromium.org>
Cc: Guillaume Gardet <Guillaume.Gardet@arm.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 Ivan Ivanov <ivan.ivanov@suse.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, Oct 10, 2023 at 3:58=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi,
>
> On Tue, 10 Oct 2023 at 04:39, Guillaume Gardet <Guillaume.Gardet@arm.com>=
 wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Peter Robinson <pbrobinson@gmail.com>
> > > Sent: Tuesday, October 10, 2023 12:22 PM
> > > To: Guillaume Gardet <Guillaume.Gardet@arm.com>
> > > Cc: mbrugger@suse.com; Ivan Ivanov <ivan.ivanov@suse.com>; Simon Glas=
s
> > > <sjg@chromium.org>; u-boot@lists.denx.de
> > > Subject: Re: U-Boot 2023.10 does not boot from uSD on RPi4
> > >
> > > On Tue, Oct 10, 2023 at 10:26=E2=80=AFAM Guillaume Gardet
> > > <Guillaume.Gardet@arm.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > U-Boot 2023.10 does not boot from uSD on RPi4.
> > > > This has been found on openSUSE Tumbleweed. The only diff we need i=
s:
> > > >   -CONFIG_OF_EMBED=3Dy
> > > >   +CONFIG_OF_BOARD=3Dy
> > > > To use firmware provided Device Tree. But that should not affect th=
e mmc
> > > behavior too much, I think.
> > >
> > > I've been booting Fedora fine on a RPi4 BUT there's issues with the d=
isplay
> > > turning off [1] when the accelerated display modules load
> > > (vc4) as a result of this patch set. Can you confirm if that's the sa=
me problem
> > > you're seeing?
> >
> > No, that's not my problem. My issue is grub was not loaded by u-boot fr=
om uSD.
> > It seems more like Simon's problem: https://lists.denx.de/pipermail/u-b=
oot/2023-October/533162.html
> >
> > @Simon, can you check if the patch below fixes your boot problem on RPi=
4, please?
>
> This has been reported at least twice before. There is a fix [2] which is=
 in my queue to apply.

Looking at that patch it scans the first 3 devices, how does it handle
non storage devices like SDIO WiFi modules? It shouldn't be trying to
scan those.

> Regarding the display problem, I got my rpi4 running again and Fedora ins=
talled, but I won't get back to it until the end of the week as I'm at osfc=
.
>
> Regards,
> Simon
>
> >
> > Thanks,
> > Guillaume
> >
>
> [2] https://patchwork.ozlabs.org/project/uboot/patch/20230923205017.17543=
40-1-sjg@chromium.org/
>
> > >
> > > [1] https://lists.denx.de/pipermail/u-boot/2023-October/533158.html
> > >
> > > > 'git bisect' points to:
> > > > **********
> > > > commit c771e5b8c2a186fb072b6c6f571d4a3cc86efba9
> > > > Author: Simon Glass <sjg@chromium.org>
> > > > Date:   Thu Jul 27 15:54:28 2023 -0600
> > > >
> > > >     arm: rpi: Switch to standard boot
> > > >
> > > >     Drop use of the distro scripts and use standard boot instead.
> > > >
> > > >     We don't need to specify the mmc devices individually, since th=
ey are
> > > >     used in order from 0 to 2, and standard boot uses that order an=
yway.
> > > >
> > > >     Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > **********
> > > >
> > > > The following patch fixes the boot from uSD on RPi4 (not tested on =
RPi3 nor RPi
> > > Zero 2 W):
> > > > **********
> > > > diff --git a/board/raspberrypi/rpi/rpi.env
> > > > b/board/raspberrypi/rpi/rpi.env index 30228285ed..02210b97b5 100644
> > > > --- a/board/raspberrypi/rpi/rpi.env
> > > > +++ b/board/raspberrypi/rpi/rpi.env
> > > > @@ -74,4 +74,4 @@ pxefile_addr_r=3D0x02500000
> > > >  fdt_addr_r=3D0x02600000
> > > >  ramdisk_addr_r=3D0x02700000
> > > >
> > > > -boot_targets=3Dmmc usb pxe dhcp
> > > > +boot_targets=3Dmmc0 mmc1 mmc2 usb pxe dhcp
> > > > **********
> > > >
> > > > So, the comment from Simon " We don't need to specify the mmc devic=
es
> > > individually, since they are used in order from 0 to 2, and standard =
boot uses that
> > > order anyway" seems wrong for the RPi4 case.
> > > >
> > > > Cheers,
> > > > Guillaume
> > > >
> > > > IMPORTANT NOTICE: The contents of this email and any attachments ar=
e
> > > confidential and may also be privileged. If you are not the intended =
recipient,
> > > please notify the sender immediately and do not disclose the contents=
 to any
> > > other person, use it for any purpose, or store or copy the informatio=
n in any
> > > medium. Thank you.
> > IMPORTANT NOTICE: The contents of this email and any attachments are co=
nfidential and may also be privileged. If you are not the intended recipien=
t, please notify the sender immediately and do not disclose the contents to=
 any other person, use it for any purpose, or store or copy the information=
 in any medium. Thank you.
