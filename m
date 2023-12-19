Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4FDC46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 19:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E400D86DEE;
	Tue, 19 Dec 2023 20:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MOgDZXAh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EE2B87527; Tue, 19 Dec 2023 20:36:35 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12A898078B
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50c222a022dso5942173e87.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703014592; x=1703619392; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AoNPOtbHfQHL4Y7bSsqvZW8PYOrYdA8L/FkwmXmToSc=;
 b=MOgDZXAhJ7pkBssI8j74/e4ubSBIPz8lBwQwSN04/Wxxi+MDJ7RQEBhJ6BSMMsZo8y
 B0EldKhkX8JSmab0QTu46/M24Su47fNV1S+YPdw1Q8ZUtJF4oMWnutaT5/E/VNHr3OCY
 6R3OrQMAkxsT3Ofky5qLRGbhnPrcP1k9Akc38lQr31Q6lotJQluNm618n5GMPEDlLWJL
 A6H65GXAr1XqPT5goM0+P557U3QFIrc8XjGXDZqqeLojhTsa+HKdhbnVNCuNPL6tbvtL
 MIZi/A2Jf67R5n7OQ6veGW1Npj29LAocb6wq+8nm6j2Z5QPdqJL7YhL0uSpFIhCA+Xtz
 +ifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703014592; x=1703619392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AoNPOtbHfQHL4Y7bSsqvZW8PYOrYdA8L/FkwmXmToSc=;
 b=uVyX4VZytHm6aExkdDpy7BW5FegKoDmGPCr4hO1XzHnDGIJy7Tx7C1+2+vdtLSF9so
 n0p77k6I/eeLpSu7mq8iGXotKUu0Q7q56sWo6JrbeP2goPFUod4hCMxsHhLRuP/x/JS+
 De0BJGxnGyjiNCRzS6dzY630KmquMPlaTtUS2jVUtXT1hMEVMimMp9f9fWjztz53ntx8
 XRqEmHxhh3zNFhj6uVID4B153GRClsYPBPDPNlqDIalACIL4cSLI+bYGBeBu7ttxvkPz
 unxWci+jtkm+rNo79z4vlj4TbsAx2byRoAZSvDMk3lbY+scPnhwgmGDefoiPL2EEnTuI
 jYAg==
X-Gm-Message-State: AOJu0YwgnLUAudkk7iJYHhPuUrbalRFmCKRcT4VvSgtFgUCxWc1dOW2y
 KTjH9T7PBQ+hEwY61ORM+Bxf9tk2u1zym4R7tV0=
X-Google-Smtp-Source: AGHT+IEGWqPIfm5IcRWEaQADg7diFSdgmgxzYzYpRTS6nx3xxSsA+78JUyOYS+RSFhouaisQkkWHAdTstQlHBBR1xF4=
X-Received: by 2002:a05:6512:2397:b0:50e:501d:59aa with SMTP id
 c23-20020a056512239700b0050e501d59aamr27684lfv.53.1703014592007; Tue, 19 Dec
 2023 11:36:32 -0800 (PST)
MIME-Version: 1.0
References: <CAPnjgZ0eNv0ZRp_gDb-r46qTJ=u_9B9AGMp3n9dA889U013d4A@mail.gmail.com>
In-Reply-To: <CAPnjgZ0eNv0ZRp_gDb-r46qTJ=u_9B9AGMp3n9dA889U013d4A@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 19 Dec 2023 19:36:20 +0000
Message-ID: <CALeDE9MqhgTE-SWNNEKnpF7EjEEVbhgJvUg_aU6D41c5gPCnwA@mail.gmail.com>
Subject: Re: How to boot Fedora 39
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Simon,

Sorry for the delayed response, I was out with COVID.

> I tried the instructions here with a rpi4:
>
> https://docs.fedoraproject.org/en-US/quick-docs/raspberry-pi/#_installing_fedora_on_a_raspberry_pi_for_linux_users
>
> xzcat Fedora-Workstation-39-1.5.aarch64.raw.xz | sudo dd
> status=progress bs=4M of=/dev/sdb
> 16843096064 bytes (17 GB, 16 GiB) copied, 151 s, 112 MB/s
> 0+2051288 records in
> 0+2051288 records out
> 17179869184 bytes (17 GB, 16 GiB) copied, 152.023 s, 113 MB/s

Hmm, I have not had any reports of Workstation failing to boot. Did
you check the sha256sum against the published ones to make sure it
came down properly?

I generally do all my U-Boot testing with the Minimal spin as it's a
little more straight forward for low level debugging like boots as it
doesn't have fun things like btrfs and graphical stacks. You can get
the F-39 one here:

https://dl.fedoraproject.org/pub/fedora-secondary/releases/39/Spins/aarch64/images/Fedora-Minimal-39-1.5.aarch64.raw.xz

Let me know how you get on.

Peter

>
> Then booted:
>
>
> U-Boot 2023.07 (Oct 25 2023 - 00:00:00 +0000)
>
> DRAM:  992 MiB (effective 3.9 GiB)
> RPI 4 Model B (0xc03111)
> Core:  211 devices, 17 uclasses, devicetree: board
> MMC:   mmcnr@7e300000: 1, mmc@7e340000: 0
> Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1...
> In:    serial
> Out:   vidconsole
> Err:   vidconsole
> Net:   eth0: ethernet@7d580000
> PCIe BRCM: link up, 5.0 Gbps x1 (SSC)
> starting USB...
> Bus usb@7e980000: USB DWC2
> Bus xhci_pci: Register 5000420 NbrPorts 5
> Starting the controller
> USB XHCI 1.00
> scanning bus usb@7e980000 for devices... 1 USB Device(s) found
> scanning bus xhci_pci for devices... 3 USB Device(s) found
>        scanning usb for storage devices... 0 Storage Device(s) found
> Hit any key to stop autoboot:  0
> switch to partitions #0, OK
> mmc0 is current device
> Scanning mmc 0:1...
> Found EFI removable media binary efi/boot/bootaa64.efi
> 966711 bytes read in 105 ms (8.8 MiB/s)
> Card did not respond to voltage select! : -110
> No EFI system partition
> No EFI system partition
> Failed to persist EFI variables
> Booting /efi\boot\bootaa64.efi
> No EFI system partition
> Failed to persist EFI variables
> No EFI system partition
> Failed to persist EFI variables
> No EFI system partition
> Failed to persist EFI variables
> error: ../../grub-core/commands/search.c:315:no such device:
> 77e306d4-532a-4d8c-b023-5bde5c8689ac.
>
>
>
>                                    GRUB version 2.06
>
>    Minimal BASH-like line editing is supported. For the first word,
> TAB lists
>    possible command completions. Anywhere else TAB lists possible
> device or file
>    completions.
>
>
> grub>
>
>
> I looked at the partition list and don't see that GUID, but perhaps
> U-Boot is missing some config?
>
> U-Boot> part list mmc 0
>
> Partition Map for MMC device 0  --   Partition Type: DOS
>
> Part    Start Sector    Num Sectors     UUID            Type
>   1     2048            1228800         7d51a49c-01     06 Boot
>   2     1230848         2097152         7d51a49c-02     83
>   3     3328000         30226432        7d51a49c-03     83
> U-Boot>
>
> Regards,
> Simon
