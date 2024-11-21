Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4224E64016
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 21:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D16889382;
	Thu, 21 Nov 2024 22:42:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BHIrNabl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9023F8941A; Thu, 21 Nov 2024 22:42:17 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29F8B89370
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 22:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fb5740a03bso16411351fa.1
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 13:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732225334; x=1732830134; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YEpxV+Iu9Q2aZYl9R7Go7FT197xdHnccidn5MfF6aQ8=;
 b=BHIrNablusP8wDp9Tb6/Lp6gb6uf7AyAY4KAIOcDZG/7palh2n2Ys6oS4atlGNIuB3
 Kf7A292tKb3nR+dmSAj+C6Hw5qelcebdq7dUPRDN/qKGhipSmWjgZ9GE6GR8tU1lurWF
 3sV5jp9rYNGCFyOLL77ogrxOop0LPpRXGBfFKsIyK3Bjf7SK526wcm0abIm+1YDbXfQu
 EGJnwMhjv23LgoA+a7IFx1nkSMnTPGbVNvQl6wnhc6JnhErTNqU8px6K8vjzBIfIOoQv
 tDgXUvppGlJA88StztbjoENXFp9o19vbQlCtRJRvbyd3fQ4s9XMZoop1Pp/4KJVxr6cL
 ZrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732225334; x=1732830134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YEpxV+Iu9Q2aZYl9R7Go7FT197xdHnccidn5MfF6aQ8=;
 b=ekpkgveAQbyDZUMhPHkQDo+Cc2h6VY4TNjC4JgSvqSHLdp8mH/YMEoIWUBeey8y7S2
 sSXgwyprL+PSE3rrRNYBQ/HHTB2fMw121t+Em7o3QsoeqCMa5bmBdAuw9haqAn7bSqSw
 PLjXiapemYhObWSoVBAbYowqp0mcNcS7RCVsHJj2efn4YZax9sXVFZ/lvqIqi9DWXo0i
 AlPL+APx/M4eP/SpV+QhCtZZ4EDjbC75bGor/zfEnB3R6Gv68V4vZ8ih5gvX5UBqS+nw
 7rozq1pRMHMvLdPIxk5pZss1uZAz4uvlA7DLUYlTCcZ74kNu02Olmp2ocL2NLLtlL0X5
 abPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0TkDqeVmNDWEEFxVl1QPqxlQHfd6LKQSyCUkA35fB7asXH32Yo7PdzLzyTQ5sENVwuykmmsw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/m2LgZ5aexi7hnACjCuuwVbkxwDad0KOtl77Yet03y1YTahkI
 rnlJkB7M57iMK4+tqR2zJkG6OHkga48axsfbGDaoiLtsVQjSEW2FXstjq72myb/2TD44KOUf3hS
 IRM445S/MdZwYzuBUgcd95sSN6L34L0+f
X-Gm-Gg: ASbGncsFwXQuljsyQje59r/fhURPcSHRacxH4KSt3NhT+LkcHnFEWG2UufJiRWSHez+
 80GwL0C2qxLiBIs65GmunoJFRruRaLHXAdSNeSeqvsGa/ieVH+Ie67WcXZc2KoJR8/w==
X-Google-Smtp-Source: AGHT+IFICXTi5L4Yi9FKRLBaCIcf6EXzVdF1AycUbfI0lV/wAF+5tS5g5Ydy8+JIWdyLi2hVCv5jHJBZNwgbFX4JDz0=
X-Received: by 2002:a2e:bc1f:0:b0:2fb:90bc:1b3b with SMTP id
 38308e7fff4ca-2ffa716cd2emr2038021fa.28.1732225333975; Thu, 21 Nov 2024
 13:42:13 -0800 (PST)
MIME-Version: 1.0
References: <mvm8qtnv310.fsf@suse.de>
 <8d4e3685-8082-4b74-828f-05ccee5ac8e0@canonical.com>
 <mvmfrnko8tk.fsf@suse.de> <7610b940-63ae-4b52-a71e-555b2d2db35e@canonical.com>
In-Reply-To: <7610b940-63ae-4b52-a71e-555b2d2db35e@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Thu, 21 Nov 2024 13:42:02 -0800
Message-ID: <CANV2PTMUwRpYyCUJGTakpF3t6QHCMpSH80_N76=uniqk5vbBtQ@mail.gmail.com>
Subject: Re: 2025.01-rc2 fails to boot on VisionFive2
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Andreas Schwab <schwab@suse.de>, u-boot@lists.denx.de, 
 Minda Chen <minda.chen@starfivetech.com>
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

On Thu, Nov 21, 2024 at 9:21=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 21.11.24 17:22, Andreas Schwab wrote:
> > On Nov 21 2024, Heinrich Schuchardt wrote:
> >
> >> On 13.11.24 11:31, Andreas Schwab wrote:
> >>> "Error reading cluster" is the new error.
> >>> U-Boot SPL 2025.01-rc2 (Nov 08 2024 - 07:13:26 +0000)
> >>> DDR version: dc2e84f0.
> >>> Trying to boot from MMC2
> >>> U-Boot 2025.01-rc2 (Nov 08 2024 - 07:13:26 +0000)
> >>> CPU:   sifive,u74-mc
> >>> Model: StarFive VisionFive 2 v1.2A
> >>> DRAM:  4 GiB
> >>> Core:  136 devices, 26 uclasses, devicetree: board
> >>> WDT:   Not starting watchdog@13070000
> >>> MMC:   mmc@16010000: 0, mmc@16020000: 1
> >>> Loading Environment from SPIFlash... SF: Detected gd25lq128 with page=
 size 256 Bytes, erase size 4 KiB, total 16 MiB
> >>> *** Warning - bad CRC, using default environment
> >>> StarFive EEPROM format v2
> >>> --------EEPROM INFO--------
> >>> Vendor : StarFive Technology Co., Ltd.
> >>> Product full SN: VF7110A1-2249-D004E000-00000408
> >>> data version: 0x2
> >>> PCB revision: 0xa1
> >>> BOM revision: A
> >>> Ethernet MAC0 address: 6c:cf:39:00:16:8d
> >>> Ethernet MAC1 address: 6c:cf:39:00:16:8e
> >>> --------EEPROM INFO--------
> >>> starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
> >>> starfive_7110_pcie pcie@2c000000: Starfive PCIe bus probed.
> >>> In:    serial@10000000
> >>> Out:   serial@10000000
> >>> Err:   serial@10000000
> >>> Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
> >>> starting USB...
> >>> Bus xhci_pci: Register 5000420 NbrPorts 5
> >>> Starting the controller
> >>> USB XHCI 1.00
> >>> scanning bus xhci_pci for devices... 2 USB Device(s) found
> >>>          scanning usb for storage devices... 0 Storage Device(s) foun=
d
> >>> Working FDT set to ff72ca10
> >>> Hit any key to stop autoboot:  0
> >>> Card did not respond to voltage select! : -110
> >>> ** Booting bootflow '<NULL>' with efi_mgr
> >>> Error reading cluster
> >>
> >> This is a message from the FAT file system driver.
> >
> > The file system is ok when read after interrupting the boot.
>
> That ls works does not mean that the file system is not corrupted.
>
> dosfsck will tell you if there is something wrong.
>
> >
> > StarFive # mmc dev 1
> > switch to partitions #0, OK
> > mmc1 is current device
> > StarFive # ls mmc 1:1
> >              EFI/
> >        304   ubootefi.var
> >
> > 1 file(s), 1 dir(s)
> >
> > StarFive # ls mmc 1:1 EFI
> >              ./
> >              ../
> >              BOOT/
> >
> > 0 file(s), 3 dir(s)
> >
> > StarFive # ls mmc 1:1 EFI/BOOT
> >              ./
> >              ../
> >     167936   BOOTRISCV64.EFI
> >        164   grub.cfg
> >
> > 2 file(s), 2 dir(s)
> >
> > But running boot will end with the above error, and mmc 1 no longer
> > works.
> >
> >> Which image reproduces the problem?
> >
> > I've built U-Boot here
> > <https://build.opensuse.org/project/show/home:Andreas_Schwab:riscv:u-bo=
ot>.
> >
>
> I was asking which SD-card image that was used, e.g. some Suse
> preinstalled image.
>
> Best regards
>
> Heinrich

Hi Andreas,

There is an offset (1GB?) in address space to DRAM. On boards having
4GB DRAM and more there is a failure to load data with mmc driver to
the 4GB memory address. . If you load data smaller than the length of
the offset to the 4GB address it is a valid action, however the MMC
driver limitation will cause this to fail. Similarly you can load that
same data to $loadaddr (2GB+320MB) or $kernel_addr_r (1GB+2MB) and
that does not cause a problem.

Try 'load' from mmc storage and experiment with addresses above and
below 0x100000000 (1024*1024*1024*4) this way to get a failure and a
success. When there is a failure then the mmc storage appears to not
respond in future requests. The content of data being transferred (OS
image, EFI app, ...) does not matter there, so it should be easy to
test for.

-E
