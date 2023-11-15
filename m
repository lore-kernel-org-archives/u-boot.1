Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A098C48BF9
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 14:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C49D587197;
	Wed, 15 Nov 2023 15:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="GBSE3rhN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46AC087197; Wed, 15 Nov 2023 15:12:16 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E67F786FBB
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 15:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50943ccbbaeso9755399e87.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 06:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700057533; x=1700662333;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vHmz5cTfYiw4lBw6F6NylQUzcJ1qCNOxsVwviIvfD+w=;
 b=GBSE3rhNS8NM9D2bGgf9R/dKTzoByf0WxvVa3Mnthcx4LkHvMfOWpzVz6VY9zYk0M9
 s77FKE5VXjnRVKP0bKuMXC2rnnJ/TA7Jv2a0n4TGqGsxv+cVvV0aIUqA/5lXxKxqREB7
 PxLvhQzXPo4iqnlfwSrDdFKYMSheprgJp9BXb/23RrFl/00MylFK75+lOYZ7ZgtkgVXG
 ql/8L6n1rwZQCTP+usKkfETd+/bo1MjoGNyAXgCeVvZUbOkWV6qWEJUZX7okclA1GP9q
 PyNvfC3OR96D1E09fYbtvv3shVSV4/QxnDI0pVV7w76wTXFMCo626kUEirQ5iai2fEvS
 18qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700057533; x=1700662333;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vHmz5cTfYiw4lBw6F6NylQUzcJ1qCNOxsVwviIvfD+w=;
 b=u893wpB22oYy1noJK8lFUD8C/JXLVFQ3CXTIuNh6Zhvlg0bfKvuHjGHRneqK/4WoR0
 mwM9+ee80gKEZcfeigj8VexhZv27y7zfDfs9nfSJlCr12i6cENmBAlmYKFcNrBhF4fWX
 d/u2ysFqBvevDCU8P03uhQkU3WVypHUsafV+ZnXVZWzgOp4abxOdc3o+tnGXntOuNMum
 32YK2s84wcHJAZQXX2vgx4S1qgv6CksKCVUPMMIHVfkiH0TFEpIOw8sa4zsKQlShkBSo
 l5ZyACHX+P5fHDtk1txYL8P/N8L2pfda624m0REJtobDYaB4YiYAqn2x7QUbpTj9LbW8
 DJCw==
X-Gm-Message-State: AOJu0Yz+SxOkDzMQS2EB529gInVB+XC7ZVZ189vvNurDuz7/WFvmb+Pz
 TmA3y8Dwt19488KUyDU55qKc0NcQLfXFHvClglXaRd6b
X-Google-Smtp-Source: AGHT+IGzxTDh6GNqwR8AmrYIvYg2lplfXYuYfXWLrVNShys9QjwX67cUQ5urDip5uP5WCbvEIGfL1A==
X-Received: by 2002:ac2:46c4:0:b0:503:fee:5849 with SMTP id
 p4-20020ac246c4000000b005030fee5849mr7770949lfo.53.1700057532493; 
 Wed, 15 Nov 2023 06:12:12 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com.
 [209.85.167.48]) by smtp.gmail.com with ESMTPSA id
 16-20020ac25f10000000b004fde41a2059sm1651937lfq.305.2023.11.15.06.12.11
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 06:12:11 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-507bd644a96so9763514e87.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 06:12:11 -0800 (PST)
X-Received: by 2002:ac2:46c4:0:b0:503:fee:5849 with SMTP id
 p4-20020ac246c4000000b005030fee5849mr7770905lfo.53.1700057531480; Wed, 15 Nov
 2023 06:12:11 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2hrverfcsEEahUcRkcjrnF3jr0oyds2yo0RBVMB7E01g@mail.gmail.com>
 <CAPnjgZ1-_ohZaVwMGtTDt4-W--2q0AM2KPtX9RLgAbMEhMRugw@mail.gmail.com>
In-Reply-To: <CAPnjgZ1-_ohZaVwMGtTDt4-W--2q0AM2KPtX9RLgAbMEhMRugw@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Wed, 15 Nov 2023 14:12:00 +0000
X-Gmail-Original-Message-ID: <CAHc5_t1icj6d82GH+FK8qGg3MvDkpwEicH964ULcN971_=aSKg@mail.gmail.com>
Message-ID: <CAHc5_t1icj6d82GH+FK8qGg3MvDkpwEicH964ULcN971_=aSKg@mail.gmail.com>
Subject: Re: bug - bootflow: grub efi crashes when bootflow selected explicitly
To: Simon Glass <sjg@chromium.org>
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

HI Simon,

Thanks for the speedy reply.
I can confirm patch [2] fixes the problem - at least on the USB2.0
port on RockPro64.
I see some issue with the USB disk being unable to provide its size on
the USB3.0 port but that might not be linked to bootflow.

PS - Also tested with
https://patchwork.ozlabs.org/project/uboot/list/?series=3D382070

Regards,
Shantur

On Wed, Nov 15, 2023 at 1:12=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> +Heinrich Schuchardt
>
> Hi Shantur,
>
> On Wed, 15 Nov 2023 at 05:59, Shantur Rathore <i@shantur.com> wrote:
> >
> > Hi all,
> >
> > I am facing an issue with bootflow where grub efi crashes only when
> > bootflow is selected manually.
> >
> > Board - RockPro64
> > OS - Armbian Bookworm CLI
> > U-boot : 2024.01-rc2
> > Built and installed in SPI
> > Boot Device =3D USB drive connected to USB 2.0 port
> >
> > Success scenario :
> >
> > =3D> setenv boot_targets usb
> > =3D> setenv bootmeths efi
> > =3D> bootflow scan -lb
> >
> > Grub loads and Linux boots
> > Full Log - https://pastebin.com/KUFtUcha
> >
> > Failure scenario
> > Full Log : https://pastebin.com/GHyG2NDz
> >
> > > setenv boot_targets usb
> > =3D> setenv bootmeths efi
> > =3D> bootflow scan
> > =3D> bootflow list
> > Showing all bootflows
> > Seq Method State Uclass Part Name Filename
> > --- ----------- ------ -------- ---- ------------------------ ---------=
-------
> > 0 efi ready usb_mass_ 1 usb_mass_storage.lun0.boo efi/boot/bootaa64.efi
> > --- ----------- ------ -------- ---- ------------------------ ---------=
-------
> > (1 bootflow, 1 valid)
> > =3D> bootflow select 0
> > =3D> bootflow boot
> > ** Booting bootflow 'usb_mass_storage.lun0.bootdev.part_1' with efi
> >
> > Loading Linux 6.1.50-current-rockchip64 ...
> > Loading initial ramdisk ...
> > EFI stub: Booting Linux Kernel...
> > EFI stub: Using DTB from configuration table
> > EFI stub: Exiting boot services...
> > "Synchronous Abort" handler, esr 0x96000044, far 0x300905a65
> > elr: 000000000022d634 lr : 0000000000208e14 (reloc)
> > elr: 00000000f3f47634 lr : 00000000f3f22e14
> > x0 : 0000000300905a4d x1 : 0000000000000000
> > x2 : 0000000000000000 x3 : 000000000207fff0
> > x4 : 00000000f3fd6470 x5 : 000000000207fff0
> > x6 : 0000ffff00000004 x7 : 00000000f1f9fad0
> > x8 : 7f7f7f7f7f7f7f7f x9 : 000000000000d02c
> > x10: 00000000f1efee8c x11: 000000000000d020
> > x12: 00000000f1efef88 x13: 00000000ad400000
> > x14: 00000000f1efef2c x15: 00000000f1eff057
> > x16: 00000000f3f21fc0 x17: 00000000d017a1d0
> > x18: 00000000f1f11d70 x19: 00000000f1f21eb0
> > x20: 0000000000000000 x21: 00000000f1f27b80
> > x22: 0000000000000000 x23: 0000000000000000
> > x24: 0000000000000000 x25: 00000000f3fc9ed7
> > x26: 00000000b0c36000 x27: 00000000f02cd000
> > x28: 00000000f03a210c x29: 00000000f1efee20
> >
> > Code: f9400860 eb06001f 540004e0 f9400c66 (f9000c06)
> > UEFI image [0x00000000f0da4000:0x00000000f0dbbfff] '/efi\boot\fbaa64.ef=
i'
> > UEFI image [0x00000000f0386000:0x00000000f07adfff] '/\EFI\debian\grubaa=
64.efi'
> > UEFI image [0x00000000af4e0000:0x00000000b11dffff]
> > Resetting CPU ...
> >
> > resetting ...
> >
> > I am unable to figure out what is the difference between the 2 ways of =
booting.
> >
> > Thanks for your help.
>
> Thank you for the detailed report. Can you try series [1] in
> particular patch [2]
>
> It has been sitting around for quite a while, unfortunately.
>
> Regards,
> Simon
>
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D381851
> [2] https://patchwork.ozlabs.org/project/uboot/patch/20231112130245.v4.5.=
If206027372f73ce32480223e5626f4b944e281b7@changeid/
