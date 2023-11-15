Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C50C07533
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 15:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA64587088;
	Wed, 15 Nov 2023 16:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bwj5hCEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DBDB84003; Wed, 15 Nov 2023 16:05:30 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CDCB842D0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 16:05:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5b499b18b28so79638717b3.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 07:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700060727; x=1700665527; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTcQpCOiFDE/Oh/mJ0cHGnTzllsYZq1dHovMxLOB1sI=;
 b=bwj5hCELBUMPn4SFYfp8tZb8rtLM8Y/HKpVpijCUKXv3l/9ue5+AtLg0EHee4XdG02
 UNR16R2iwdv0/gCcOkrxTooyz4Hc1ZAIf6HUNLhubCSMyZIm9wRgSiMGIhFH92vCcUNG
 M0pyrzld5e/3UL8k03kBnPGZf6CnUZB8gmFoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700060727; x=1700665527;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTcQpCOiFDE/Oh/mJ0cHGnTzllsYZq1dHovMxLOB1sI=;
 b=ZPa5wFOY+Bh27kSf9Eezh+eGtjVUS/4Wr0IpRg1TfRo3S1PAvBDjIThUugeiTGziD+
 bXd2EjoWPbT6MEZDzPgPF3oV7a7xvZhTzbA6XFSAyc3OWUKkfBJZsYotkssSgD0tg7Yo
 o6issI3oi0PrmP1RkKpLZ1HL7kwfFISN6UToeJ8l8o3R+EiuDcJEUwyW3nq5WiDuwO3q
 vpJCjlStKSzyUBj0vON3PnTEKjNzwqZXlFF/euIP8kvz9nv8CTdHGZi2IQWl/8fGC7gX
 XBQIcqGRO7A1M+9DZW2yEcepMA3NToQU1L5R76Xg7yso3f0/UEh0jDTfgkL5G5ZkHa9o
 R7Uw==
X-Gm-Message-State: AOJu0Yx9bKpU9lH4o61cXikWxu7e5685G9i2cQBkMdPIfaiLoDAQ37Zz
 z3ixfos0TBpZ25R+8kkj0e9K/aeKgDhTIhIQSI6oIQ==
X-Google-Smtp-Source: AGHT+IG3WcF2qBc2L6YzEDntwkQNX7XICnMj5IuLhCHbNRagwP62IEcFwsWt6kOC4lW4EVEF6WacPoiTnHAVJIs8HMo=
X-Received: by 2002:a81:8704:0:b0:59f:519e:3e9a with SMTP id
 x4-20020a818704000000b0059f519e3e9amr15482812ywf.20.1700060726458; Wed, 15
 Nov 2023 07:05:26 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2hrverfcsEEahUcRkcjrnF3jr0oyds2yo0RBVMB7E01g@mail.gmail.com>
 <CAPnjgZ1-_ohZaVwMGtTDt4-W--2q0AM2KPtX9RLgAbMEhMRugw@mail.gmail.com>
 <CAHc5_t1icj6d82GH+FK8qGg3MvDkpwEicH964ULcN971_=aSKg@mail.gmail.com>
In-Reply-To: <CAHc5_t1icj6d82GH+FK8qGg3MvDkpwEicH964ULcN971_=aSKg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 08:05:09 -0700
Message-ID: <CAPnjgZ3saZfyog0Jq4Oh3hVmhKiY+aucPwStbVOtjF=oF_D6-Q@mail.gmail.com>
Subject: Re: bug - bootflow: grub efi crashes when bootflow selected explicitly
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Shantur,

On Wed, 15 Nov 2023 at 07:12, Shantur Rathore <i@shantur.com> wrote:
>
> HI Simon,
>
> Thanks for the speedy reply.
> I can confirm patch [2] fixes the problem - at least on the USB2.0
> port on RockPro64.
> I see some issue with the USB disk being unable to provide its size on
> the USB3.0 port but that might not be linked to bootflow.
>
> PS - Also tested with
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D382070

OK, good. Can you please reply on the patch(es) with a Tested-by tag?

Regards,
SImon

>
> Regards,
> Shantur
>
> On Wed, Nov 15, 2023 at 1:12=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > +Heinrich Schuchardt
> >
> > Hi Shantur,
> >
> > On Wed, 15 Nov 2023 at 05:59, Shantur Rathore <i@shantur.com> wrote:
> > >
> > > Hi all,
> > >
> > > I am facing an issue with bootflow where grub efi crashes only when
> > > bootflow is selected manually.
> > >
> > > Board - RockPro64
> > > OS - Armbian Bookworm CLI
> > > U-boot : 2024.01-rc2
> > > Built and installed in SPI
> > > Boot Device =3D USB drive connected to USB 2.0 port
> > >
> > > Success scenario :
> > >
> > > =3D> setenv boot_targets usb
> > > =3D> setenv bootmeths efi
> > > =3D> bootflow scan -lb
> > >
> > > Grub loads and Linux boots
> > > Full Log - https://pastebin.com/KUFtUcha
> > >
> > > Failure scenario
> > > Full Log : https://pastebin.com/GHyG2NDz
> > >
> > > > setenv boot_targets usb
> > > =3D> setenv bootmeths efi
> > > =3D> bootflow scan
> > > =3D> bootflow list
> > > Showing all bootflows
> > > Seq Method State Uclass Part Name Filename
> > > --- ----------- ------ -------- ---- ------------------------ -------=
---------
> > > 0 efi ready usb_mass_ 1 usb_mass_storage.lun0.boo efi/boot/bootaa64.e=
fi
> > > --- ----------- ------ -------- ---- ------------------------ -------=
---------
> > > (1 bootflow, 1 valid)
> > > =3D> bootflow select 0
> > > =3D> bootflow boot
> > > ** Booting bootflow 'usb_mass_storage.lun0.bootdev.part_1' with efi
> > >
> > > Loading Linux 6.1.50-current-rockchip64 ...
> > > Loading initial ramdisk ...
> > > EFI stub: Booting Linux Kernel...
> > > EFI stub: Using DTB from configuration table
> > > EFI stub: Exiting boot services...
> > > "Synchronous Abort" handler, esr 0x96000044, far 0x300905a65
> > > elr: 000000000022d634 lr : 0000000000208e14 (reloc)
> > > elr: 00000000f3f47634 lr : 00000000f3f22e14
> > > x0 : 0000000300905a4d x1 : 0000000000000000
> > > x2 : 0000000000000000 x3 : 000000000207fff0
> > > x4 : 00000000f3fd6470 x5 : 000000000207fff0
> > > x6 : 0000ffff00000004 x7 : 00000000f1f9fad0
> > > x8 : 7f7f7f7f7f7f7f7f x9 : 000000000000d02c
> > > x10: 00000000f1efee8c x11: 000000000000d020
> > > x12: 00000000f1efef88 x13: 00000000ad400000
> > > x14: 00000000f1efef2c x15: 00000000f1eff057
> > > x16: 00000000f3f21fc0 x17: 00000000d017a1d0
> > > x18: 00000000f1f11d70 x19: 00000000f1f21eb0
> > > x20: 0000000000000000 x21: 00000000f1f27b80
> > > x22: 0000000000000000 x23: 0000000000000000
> > > x24: 0000000000000000 x25: 00000000f3fc9ed7
> > > x26: 00000000b0c36000 x27: 00000000f02cd000
> > > x28: 00000000f03a210c x29: 00000000f1efee20
> > >
> > > Code: f9400860 eb06001f 540004e0 f9400c66 (f9000c06)
> > > UEFI image [0x00000000f0da4000:0x00000000f0dbbfff] '/efi\boot\fbaa64.=
efi'
> > > UEFI image [0x00000000f0386000:0x00000000f07adfff] '/\EFI\debian\grub=
aa64.efi'
> > > UEFI image [0x00000000af4e0000:0x00000000b11dffff]
> > > Resetting CPU ...
> > >
> > > resetting ...
> > >
> > > I am unable to figure out what is the difference between the 2 ways o=
f booting.
> > >
> > > Thanks for your help.
> >
> > Thank you for the detailed report. Can you try series [1] in
> > particular patch [2]
> >
> > It has been sitting around for quite a while, unfortunately.
> >
> > Regards,
> > Simon
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D381851
> > [2] https://patchwork.ozlabs.org/project/uboot/patch/20231112130245.v4.=
5.If206027372f73ce32480223e5626f4b944e281b7@changeid/
