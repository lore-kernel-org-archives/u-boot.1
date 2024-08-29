Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EEAC83F0F
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 12:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9500D88B83;
	Thu, 29 Aug 2024 14:18:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QEluRawI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8E4088B83; Thu, 29 Aug 2024 14:18:01 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8573F88B31
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 14:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6bf7f4a133aso3082576d6.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 05:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724933878; x=1725538678; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKnM0kdUqC/hccWTHPED7RQYFlesg6Iw1hPf1DrjL0U=;
 b=QEluRawIbGE6RkCVpEe4AHC5p7be65u2J2LpGJvXlTbJhte2uy7WHojOZPHlTYGbp8
 JyN5UHcu48wcbqUHvP7/PrWKqODShc59bjs0s3K+xyXJtOjdT1VgFyExMQbvfw1UNFbH
 Bkz830qKiWVRnhasz4iwCNlWTehNHwqF0r2fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724933878; x=1725538678;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PKnM0kdUqC/hccWTHPED7RQYFlesg6Iw1hPf1DrjL0U=;
 b=R3FiHS4uB0Eg40L9F0F8Pff4ZHBCLcID9AfI6jQ+VjclYGhq+Fnk2f9NbDRbUDvtpB
 wbzVlYVrYEmDTDLK1iB7wqvvyC/mdJXBwtdrdt/0BYJp22tv4WhkQfWWiypzTc9ztzEZ
 n0+07Fc8kjF8OjzubgwxaLbYo/NF81LbyGxHayFoMPGLAI9JA0djq9T0+S1goi2K0Wdh
 8De0lBQUOn6Ln+gU9wdN68U2P8TmUQyBjwjgjaFxQyMRNuwgyurCp5JaTbrYi5yBFZQp
 3YFW55AOW0ODYfba2Y5pjZTCt1zFykyG9d3Fo0aseBEGPGHwKc7uytRU22+iYYPBKzbj
 gKLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX27Fh86afgls79TK1rsgO4Y5bh16ehsYPmPkp9/9pbkEAtaZMYQGzLCDh6p4cKlknmnX6trV8=@lists.denx.de
X-Gm-Message-State: AOJu0YxaNvTRIXXhiucK6gYSJVfAz78Hlv1GzAVwx0J0PLht4QvAJGDJ
 i8KVjiUHXFdkYB8bYZNS5TeHmQFiyiRqAQzfkwl5vx/OP8tKqRPkRaZAJ7vkh54Gf8iYhRx83L1
 kYwd4KHY7VJPlK27VJy7gapG9t5ZAXOyJ1zoWWsHcmzCnCXk=
X-Google-Smtp-Source: AGHT+IH1V3FoFblvsri3qhrkVPHrQaZENHOUoFCFpYO3xofL1UsWu1PSLb/XtmoKJgJSQsXr9ikBsGHj+t/31ajLDFU=
X-Received: by 2002:a05:6214:5a13:b0:6b5:d6da:fbfe with SMTP id
 6a1803df08f44-6c33e630dd0mr29076816d6.1.1724933878355; Thu, 29 Aug 2024
 05:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <7f33e3d7-e5ab-4c1d-a69a-153a50a6b0c2@Spark>
 <7cbce75d-51fe-4c87-9c90-01e86a06f0fe@Spark>
 <CALeDE9PEMh14rp8paEvhN6pRebxzXonCqidvaTaByHHG2MLgZw@mail.gmail.com>
 <69306a5c-90cf-4526-b2c0-483996910a88@Spark>
 <CALeDE9OXK_Wm-KbPC5Qs2C7L0OfQtFXtU2Y6_g-gK6euGMJsqw@mail.gmail.com>
 <7056f770-e3c9-42e5-a654-f52c29edf616@Spark>
 <CALeDE9MnhYve3vrVUsJ=LKOR9B8vo2UizeYktAcYsPdpO4nHOg@mail.gmail.com>
In-Reply-To: <CALeDE9MnhYve3vrVUsJ=LKOR9B8vo2UizeYktAcYsPdpO4nHOg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 06:17:47 -0600
Message-ID: <CAFLszTjAOXppbkY1V8DnkSb9BPYiFBaW_E-wYM9sqKB3Vj3uUg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Grub_doesn=E2=80=99t_load_devicetree?=
To: Peter Robinson <pbrobinson@gmail.com>
Cc: =?UTF-8?B?VG9tYcW+IFphbWFu?= <tomaz@mono.si>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Toma=C5=BE,

On Thu, 29 Aug 2024 at 03:44, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Thu, 29 Aug 2024 at 10:40, Toma=C5=BE Zaman <tomaz@mono.si> wrote:
>
> > I get this:
> >
> > No UEFI binary known at 0x81000000
> >

That is the UEFI hack which we need to clean up at some point.

When you load an image, it calls efi_set_bootdev() so EFI knows where
it came from. You could check that the call is happening in your case.

Can U-Boot use the same DT as Linux?

>
> Are you building the kernel with all the appropriate UEFI shim bits?
> Installing the EFI kernel pieces etc?
>
> Sorry, I can't help with kernel build process bits, you'll need to google
> that.
>
>
> > *Toma=C5=BE Zaman, *CEO
> > Mono Technologies Inc.
> > +386 30 651 645
> >
> >
> >
> > On 29 Aug 2024 at 11:38 +0200, Peter Robinson <pbrobinson@gmail.com>,
> > wrote:
> >
> >
> >
> > On Thu, 29 Aug 2024 at 10:31, Toma=C5=BE Zaman <tomaz@mono.si> wrote:
> >
> >> Doesn=E2=80=99t work - at least not correctly:
> >>
> >> =3D> fatload mmc 0:1 $fdt_addr_r /boot/dtb/fsl-ls1046a-rdb-sdk.dtb
> >> 31793 bytes read in 4 ms (7.6 MiB/s)
> >> =3D> fatload mmc 0:1 $kernel_addr_r /EFI/boot/grubaa64.efi
> >> 3978688 bytes read in 168 ms (22.6 MiB/s)
> >> =3D> setenv fman_ucode
> >> =3D> bootefi $kernel_addr_r $fdt_addr_r
> >> Failed to load EFI variables
> >> WARNING failed to get smmu node: FDT_ERR_NOTFOUND
> >> WARNING failed to get smmu node: FDT_ERR_NOTFOUND
> >> Booting /\EFI\boot\grubaa64.efi
> >> Welcome to GRUB!
> >>
> >> Because of those FDT_ERR_NOTFOUND kernel reports a bunch of errors and
> >> doesn=E2=80=99t boot with all the hardware support I need it to.
> >>
> >> On the other hand, if I run the same kernel/devicetree/initramfs with
> >> booti, bypassing the Grub completely, it works fine. The problem is, I=
 need
> >> Grub2 for his project.
> >>
> >
> > What if you boot the kernel directly using bootefi rather than booti?
> >
> >
> >> *Toma=C5=BE Zaman, *CEO
> >> Mono Technologies Inc.
> >> +386 30 651 645
> >>
> >>
> >>
> >> On 29 Aug 2024 at 10:02 +0200, Peter Robinson <pbrobinson@gmail.com>,
> >> wrote:
> >>
> >> On Thu, 29 Aug 2024 at 05:14, Toma=C5=BE Zaman <tomaz@mono.si> wrote:
> >>
> >>
> >> I=E2=80=99m working on an arm64 board with an NXP LS1046A CPU and I si=
mply cannot
> >> get Grub to load a different device tree than the one that=E2=80=99s p=
rovided to it
> >> by the EFI Stub.
> >>
> >> =3D> fatload mmc 0:1 $kernel_addr_r /EFI/boot/grubaa64.efi
> >> =3D> fatload mmc 0:1 $fdt_addr_r /boot/dtb/fsl-ls1046a-rdb-sdk.dtb
> >> =3D> bootefi $kernel_addr_r $fdt_addr_r
> >>
> >> At his point, I get a couple of errors like =E2=80=9Csmmu node not fou=
nd=E2=80=9D.
> >>
> >> However, if I, instead of "fsl-ls1046a-rdb-sdk.dtb=E2=80=9D use
> >> "fsl-ls1046a-rdb.dtb=E2=80=9D, then I get to Grub without any errors.
> >>
> >> And this is where I encounter the issue. Because I would like to use a
> >> different DTB for booting Linux than the one that=E2=80=99s provided b=
y the EFI
> >> configuration table, I set
> >>
> >> devicetree /boot/dtb/fsl-ls1046a-rdb-sdk.dtb
> >> linux /boot/vmlinuz-6.6.3-arm64
> >> initrd /boot/initrd.img-6.6.3-arm64
> >>
> >> In this case, the devicetree instruction gets ignored completely, and
> >> before I see kernel loading, the message =E2=80=9CUsing FDT from the E=
FI
> >> configuration table"
> >>
> >> Is there a way for me to override/replace the device tree that u-boot
> >> passed to Grub? I tried passing the =E2=80=9Cdtb=3D=E2=80=9C parameter=
 to the kernel boot
> >> command, but in that case, I get "EFI stub: ERROR: Failed to handle
> >> fs_proto=E2=80=9D because kernel when booting doesn=E2=80=99t appear t=
o have access to the
> >> same filesystem that Grub does.
> >>
> >>
> >> Why don't you load a new one into memory with u-boot and then grub
> >> will already have the one you want to use and grun doesn't need to do
> >> anything. Something like this on the U-Boot command line would load
> >> the DT and grub and start to boot:
> >>
> >> load mmc 0:1 ${kernel_addr_r} EFI/BOOT/BOOTAA64.EFI
> >> load mmc 0:1 ${fdt_addr_r} dtb/${fdtfile}
> >> bootefi ${kernel_addr_r} ${fdt_addr_r}
> >>
> >> You'll need to adjust for storage, partitions, file paths etc.
> >>
> >> Thank you!
> >>
> >>
> >> (this is my first time using *any* mailing list, so apologies if this =
is
> >> the wrong address to send this question to)
> >>
> >> Toma=C5=BE Zaman, CEO
> >> Mono Technologies Inc.
> >> +386 30 651 645
> >>
> >> [cid:18EB2FEE485A4DD7A1CE716CE14FCBC7]
> >>
> >>

Regards,
Simon
