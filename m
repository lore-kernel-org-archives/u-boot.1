Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E031FCE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 14:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA20B8667B;
	Sat, 23 Sep 2023 16:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fhx8ZxP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABEFD86844; Sat, 23 Sep 2023 16:36:11 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 317178641B
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 16:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so4353384a12.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695479768; x=1696084568; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDxMmDxwlw86YRfNykq5ly2bvZP3OpzvQaWvXX0F0RQ=;
 b=fhx8ZxP/jmzq5ycFZBu8YihVzyEBNdEYYoTEt+b02UjqCoyMLipZCVnkVYqpfxhY18
 ZUn0u9RyA93GLaxoMwVbWETpKWR0qlFCVro1kEyBPY6s92M4Xsa951wHS/ooPqBE++B2
 P5J29AxLUjmklBDQSh+yAHs/Ben8KqThknTWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695479768; x=1696084568;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FDxMmDxwlw86YRfNykq5ly2bvZP3OpzvQaWvXX0F0RQ=;
 b=VX5XgTSc7gmjCaSVb6L+K9e8SxJc4AVVPq5AKNbZn0ahi/sszeMwstr2YiluJqQJZB
 Vb+OO6LhQlvZiE4/Dqf70+jY4ZlNJyUV26JOuYbLzqXtg+g+OhuecU3qzAFZsqP+Yshh
 dvBqsACScw6d9bfHCZFmGNbTbgtkiXWUxEMb7agCROY2gaZhgfwb9jKnIPLak5++sAPC
 UwH5NRSiPeeZAh9e6khKJJhJCZdPYbC0i8I2AjzCzF+TlOsi98Zhoc2iZvyP91c3Rq3/
 y9tOdiAd/EpVc4k/Xa+VJgxvz8BMDsMiy1O0JplpQbdkqMdkxGi3Ve5ZB+qJrZTBFWNs
 xJ7g==
X-Gm-Message-State: AOJu0YwjYPRNixhVPTLA29NNEM9nipQqzN8yOMTnX2zT9Fq4F12w000+
 ZlOOgIIsWpAsXzsSX7G+w2xDUVm+fO4GcPYA7QTgzw==
X-Google-Smtp-Source: AGHT+IEszIpjGRf9smT98tZgjBHuOoqiC+sl97AUUt/Iffdrx+/Dr8vpVof0XNIQkL2S8Vc3/k+92YI5RTqxatm2oE0=
X-Received: by 2002:aa7:d58f:0:b0:532:c81b:99b1 with SMTP id
 r15-20020aa7d58f000000b00532c81b99b1mr1793566edq.18.1695479768475; Sat, 23
 Sep 2023 07:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ2mhRhOWoObKbw0R+8jmFT0QY4THpXR=f2s1svi6cwEvQ@mail.gmail.com>
 <536f587d-4a84-401a-8235-c3e9dff6756b@gmx.de>
In-Reply-To: <536f587d-4a84-401a-8235-c3e9dff6756b@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 Sep 2023 08:35:51 -0600
Message-ID: <CAPnjgZ0YRG1UoaMdk7ncHyebJwAJadPzfsyDHbAOm3KmV3JdQg@mail.gmail.com>
Subject: Re: Reading from ISO9660 in U-Boot
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Heinrich,

On Fri, 22 Sept 2023 at 19:02, Heinrich Schuchardt <xypron.glpk@gmx.de> wro=
te:
>
> On 9/23/23 00:13, Simon Glass wrote:
> > Hi Heinrick & Bin,
> >
> > I'd like to be able to figure out in U-Boot what OS is on a USB stick.
> > For example, with the Ubuntu installer, I can boot it (through grub),
> > but I cannot see how to read anything useful from the USB stick that
> > would indicate that it is Ubuntu, what version it is, etc.
> >
> > Does U-Boot need an ISO9660-filesystem driver for that? Is there any ot=
her way?
> >
> > With Debian I can see the actual files (linux and initrd) , so it is a
> > bit easier.
> >
> > Regards,
> > SImon
>
> The format of the Ubuntu images depends on the architecture. Let's
> assume that you relate to amd64
> (https://cdimage.ubuntu.com/daily-live/current/mantic-desktop-amd64.iso).
>
> This is a hybrid image, which can be either read as ISO 9660 or as a GPT
> partitioned image. This is the gdisk output:
>
> Number  Start (sector)    End (sector)  Size       Code  Name
>     1              64        10049451   4.8 GiB     0700  ISO9660
>     2        10049452        10059487   4.9 MiB     EF00  Appended2
>     3        10059488        10060087   300.0 KiB   0700  Gap1
>
> You can mount partition 2 as FAT file system in Linux:
>
> $ sudo kpartx mantic-desktop-amd64.iso -a -v
> [sudo] password for zfsdt:
> add map loop1p1 (252:4): 0 10049388 linear 7:1 64
> add map loop1p2 (252:5): 0 10036 linear 7:1 10049452
> add map loop1p3 (252:6): 0 600 linear 7:1 10059488
>
> $ sudo mount /dev/mapper/loop1p2 /mnt
>
> $ mount
> /dev/mapper/loop1p2 on /mnt type vfat
> (rw,relatime,fmask=3D0022,dmask=3D0022,codepage=3D437,iocharset=3Diso8859=
-1,shortname=3Dmixed,errors=3Dremount-ro)
>
> The problem is upstream U-Boot is that the partition drivers are scanned
> alphabetically: a_efi, dos, iso
>
> If we change this to a_iso, b_efi, dos, we can read the ISO image:
>
> =3D> host bind 0 /tmp/mantic-desktop-amd64.iso
> =3D> part list host 0
>
> Partition Map for HOST device 0  --   Partition Type: ISO
>
> Part   Start     Sect x Size Type
>    1     3684        4    512 U-Boot
>    2 10049452    10036    512 U-Boot
>
> =3D> ls host 0:2
>              EFI/
>
> =3D> load host 0:2 $kernel_addr_r EFI/boot/bootx64.efi
> 960472 bytes read in 0 ms
>
> Unfortunately the sandbox crashes when executing the EFI binary.
>
> So let't try qemu-x86_64_defconfig:
>
> qemu-system-x86_64 -m 3G -nographic -bios u-boot.rom \
> -drive if=3Dnone,file=3D/tmp/mantic-desktop-amd64.iso,format=3Draw,id=3DV=
IRTIO1 \
> -device virtio-blk,drive=3DVIRTIO1
>
> And voil=C3=A1 your are in GRUB.
>
> As it does not find the /boot directory let's go to the GRUB console:

I'm not sure what is going on there, as for me 'bootflow scan -lb usb'
boots automaticaly.

>
> grub> root=3D(cd0,gpt1)
> grub> linux /casper/vmlinuz root=3D/dev/vda1 efi=3Ddebug console=3D/dev/t=
tyS0
> grub> initrd /casper/initrd
> grub> boot
> EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
>
> I have no clue why it stops here.

That's the efi_gop graphics bug. I sent a v2 patch for it[1]

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230922153814.v2.1.I9=
f7f373d00947c704aeae0088dfedd8df07fab60@changeid/
