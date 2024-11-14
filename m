Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3410AD6A22F
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 21:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BA788968D;
	Thu, 14 Nov 2024 22:08:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="e6QNbG9L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2D598968E; Thu, 14 Nov 2024 22:08:20 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96A1A8968B
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 22:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 214453F27D
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 21:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731618497;
 bh=LO1DyoIaTrZcAVPJ+orpCxnRrGcLdFFME66LsQ54YsM=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=e6QNbG9LyT1Htl/rihaNHzkQQbdzb84ofR7a8aVpO/+cQVpPL9BioDufd11Im9heu
 6Y4vnYjsORwW0rnc5E5BT4WgR9CN7aYdWjGrRcuW1Xj85I3OCxztkiwXSE1C1WfvbD
 JyTecLjcaTw+c+L2zQUqDtyX40m0xmdKRWn/f7kQhdXZT1mhxKLtS/AYjJH4dHYAeV
 hGfLuD0DJILrHQElYzXkDuLrcIHi5PaIOSOn2rrT1ReRbghk5fd6Ueug0P4sbd/dwU
 RM6RyhYERG5XeKU+U/Xg4uFo5Y90aDTwpxwPY1XhCkjNAZbhrev1MPmAIL2xFpWuTn
 ajsEsXgowJ0iw==
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2e2ed2230fcso75526a91.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 13:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618496; x=1732223296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LO1DyoIaTrZcAVPJ+orpCxnRrGcLdFFME66LsQ54YsM=;
 b=nFS5yYUAqGwiddmULokCIoEjFIQquLiP//Yz02LjZiErQpgUE3KEzF4tSctWHIg6YR
 PkzsLM6Nf4vIesqhWtfWJU3ilQGOQ9N3kH0YFcIDwqFUiovPsZ1z66g3aG/7IG7ol85j
 vp6hTv/2H94EClN6QQ8DZTcYqGnXKnlzDp/NuNjdp8Jl7sn36JqLyZY0kUicJcj75xoD
 dQZFnfDECR4fMq97mowuhMkU//7OPHZim7K8XqQOHTDcJlOcjkfSos9Z07GsSrdQgEkV
 x5qCDJlJAsQNxEeI9S7FAOJCRILCZ2GgLG61k/gzim9+778kf43Njn7wLfcQWH68WeRt
 20+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBpePHe//EK0P+/JgS1DAlYi2K8/i83IaDFLJf/qswdDNQCPhgtJuz8Ml+T7ANVY+xTXUVEnw=@lists.denx.de
X-Gm-Message-State: AOJu0YzvomKunkacedNZytLIwc67MbBmc5SXlu+j7TqD8opDq2dUjH3u
 DSs5Jca66NegpubMeIjd4I9b5A/iS3m+8AMkOyAn9hAc1MilW1Ao6AZdWARi72xFF4Y7KG2pGJH
 t1wnbosNn50am58eqG2oAV2D0KYFjLpnbkXdNcEx+x2wPQqfk7J2A2QmlcLw6hddT2W9C0FIPmC
 zmsul27W3z/1F/r0JiZyxvazfReOGM+e3MZJVgarB4xg==
X-Received: by 2002:a17:90a:e70c:b0:2e2:ba35:3573 with SMTP id
 98e67ed59e1d1-2ea1551e33dmr473244a91.20.1731618495730; 
 Thu, 14 Nov 2024 13:08:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+0USzGfll2h9UIy1tq0GjEebDaz7gepj9HBhMByoSPvPwHJLIQEQN6c72NW5tZNXOIL5Pg2Pb0J1JLBfgGXA=
X-Received: by 2002:a17:90a:e70c:b0:2e2:ba35:3573 with SMTP id
 98e67ed59e1d1-2ea1551e33dmr473216a91.20.1731618495361; Thu, 14 Nov 2024
 13:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20241113195519.49150-1-heinrich.schuchardt@canonical.com>
 <80ee6e68-cfb5-4144-aa99-88e52420cba9@kwiboo.se>
In-Reply-To: <80ee6e68-cfb5-4144-aa99-88e52420cba9@kwiboo.se>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Thu, 14 Nov 2024 22:08:04 +0100
Message-ID: <CAM=mAOk4ZeF5wuNNmOZYwFL8Bhb64otKKnKkiGZyZZkXQywdfA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: run bootdev_hunt() to find ESP
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Jonas Karlman <jonas@kwiboo.se> schrieb am Do., 14. Nov. 2024, 21:26:

> Hi Heinrich,
>
> On 2024-11-13 20:55, Heinrich Schuchardt wrote:
> > Some hard devices need specific routines to scan for block devices,
> > e.g. NVMe (nvme scan), SCSI (scsi start).
> >
> > Invoke bootdev_hunt() to find all block devices.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  lib/efi_loader/efi_setup.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> > index aa59bc7779d..8e0ff16f3eb 100644
> > --- a/lib/efi_loader/efi_setup.c
> > +++ b/lib/efi_loader/efi_setup.c
> > @@ -7,6 +7,7 @@
> >
> >  #define LOG_CATEGORY LOGC_EFI
> >
> > +#include <bootdev.h>
> >  #include <efi_loader.h>
> >  #include <efi_variable.h>
> >  #include <log.h>
> > @@ -228,6 +229,13 @@ efi_status_t efi_init_obj_list(void)
> >        * Probe block devices to find the ESP.
> >        * efi_disks_register() must be called before efi_init_variables().
> >        */
> > +     if (CONFIG_IS_ENABLED(BOOTSTD)) {
> > +             int r;
> > +
> > +             r = bootdev_hunt(NULL, 0);
> > +             if (r)
> > +                     log_debug("No boot device available\n");
> > +     }
> >       ret = efi_disks_register();
> >       if (ret != EFI_SUCCESS)
> >               goto out;
>
> This is causing significant slower boot when trying to boot using
> extlinux (or script) from mmc device on Rockchip, this will cause all
> slow devices to be initialized before a quick mmc boot, e.g. pci init,
> usb start and dhcp due to efi_mgr being the global bootmeth.
>

Specifically DHCP is very slow and not needed here.

Maybe Simon has an idea how to filter it out. We should filter on
UCLASS_BLK related here.

Furthermore I don't know if global bootmeths are always have to run first
or if you could customize this.

Best regards

Heinrich



> With this patch applied:
>
>   U-Boot 2025.01-rc2 (Nov 14 2024 - 20:09:17 +0000)
>
>   Model: Radxa ROCK 3B
>   SoC:   RK3568J
>   DRAM:  8 GiB (effective 7.7 GiB)
>   PMIC:  RK809 (on=0x40, off=0x00)
>   Core:  341 devices, 33 uclasses, devicetree: separate
>   MMC:   mmc@fe000000: 2, mmc@fe2b0000: 1, mmc@fe310000: 0
>   Loading Environment from nowhere... OK
>   In:    serial@fe660000
>   Out:   serial@fe660000
>   Err:   serial@fe660000
>   Net:   eth1: ethernet@fe010000, eth0: ethernet@fe2a0000
>   Hit any key to stop autoboot:  0
>   Scanning for bootflows in all bootdevs
>   Seq  Method       State   Uclass    Part  Name
> Filename
>   ---  -----------  ------  --------  ----  ------------------------
> ----------------
>   Scanning global bootmeth 'efi_mgr':
>   pcie_dw_rockchip pcie@fe260000: PCIe-0 Link Fail
>   pcie_dw_rockchip pcie@fe280000: PCIe-1 Link Fail
>   ethernet@fe2a0000 Waiting for PHY auto negotiation to complete.........
> TIMEOUT !
>   phy_startup() failed: -110
>   FAILED: -110
>   ethernet@fe010000 Waiting for PHY auto negotiation to complete.........
> TIMEOUT !
>   phy_startup() failed: -110
>   FAILED: -110
>   BOOTP broadcast 1
>   BOOTP broadcast 2
>   BOOTP broadcast 3
>   BOOTP broadcast 4
>   BOOTP broadcast 5
>   BOOTP broadcast 6
>   BOOTP broadcast 7
>   BOOTP broadcast 8
>   BOOTP broadcast 9
>   BOOTP broadcast 10
>   BOOTP broadcast 11
>   BOOTP broadcast 12
>   BOOTP broadcast 13
>   BOOTP broadcast 14
>   BOOTP broadcast 15
>   BOOTP broadcast 16
>   BOOTP broadcast 17
>
>   Retry time exceeded; starting again
>   pcie_dw_rockchip pcie@fe260000: PCIe-0 Link Fail
>   pcie_dw_rockchip pcie@fe280000: PCIe-1 Link Fail
>   pcie_dw_rockchip pcie@fe260000: PCIe-0 Link Fail
>   pcie_dw_rockchip pcie@fe280000: PCIe-1 Link Fail
>   scanning bus for devices...
>   Bus usb@fd000000: Register 2000140 NbrPorts 2
>   Starting the controller
>   USB XHCI 1.10
>   Bus usb@fd800000: USB EHCI 1.00
>   scanning bus usb@fd000000 for devices... 1 USB Device(s) found
>   scanning bus usb@fd800000 for devices... 2 USB Device(s) found
>   No boot device available
>   Card did not respond to voltage select! : -110
>   Cannot persist EFI variables without system partition
>     0  efi_mgr      ready   (none)       0  <NULL>
>   ** Booting bootflow '<NULL>' with efi_mgr
>   Loading Boot0000 'mmc 1' failed
>   Loading Boot0001 'mmc 0' failed
>   EFI boot manager: Cannot load any image
>   Boot failed (err=-14)
>   Scanning bootdev 'mmc@fe2b0000.bootdev':
>     1  extlinux     ready   mmc          1  mmc@fe2b0000.bootdev.part
> /extlinux/extlinux.conf
>   ** Booting bootflow 'mmc@fe2b0000.bootdev.part_1' with extlinux
>   1:      linux
>   Retrieving file: /Image.gz
>   Retrieving file: /initramfs.cpio.gz
>      Uncompressing Kernel Image to 0
>   ## Flattened Device Tree blob at eded3690
>      Booting using the fdt blob at 0xeded3690
>   Working FDT set to eded3690
>      Loading Ramdisk to ecb0d000, end ecea1d3c ... OK
>      Loading Device Tree to 00000000ecaf5000, end 00000000ecb0c6d7 ... OK
>   Working FDT set to ecaf5000
>
>   Starting kernel ...
>
> I guess we can always disable efi_mgr on Rockchip, similar to sunxi, to
> restore pre stdboot behavior.
>
> Regards,
> Jonas
>
>
