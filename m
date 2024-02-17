Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92271C48BC3
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 16:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0535B87DCD;
	Sat, 17 Feb 2024 17:36:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gcAhicO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA4F687C48; Sat, 17 Feb 2024 17:36:50 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E612A87E6D
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 17:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55ee686b5d5so2138336a12.0
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 08:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708187797; x=1708792597; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4K4P67FDnIwvxD62QsllIQlR3nVVEyEy8gCXYYasAYc=;
 b=gcAhicO7Cj7IW1XncchuHDBwatlIu9U1yLBkiwnrrI+nARkW7fwadFMPBeiHFdKan2
 hW7uBRDCp0Dujim47QYa8cvy32BBa2sB9hJpDfn+8CnQMtM3hgBKQ+HMpzRZvpNlqYGI
 oKVODVfZ1kX2GpjeIJitNigHT6wjJdzVPZK4NWbT7XXLeYybbXofIr5aVmTMzdJUvW8Y
 6MRPuiuPdMNdK9MVaHfz99TNut3yhJtqm00fX5+kT68NfnRSaXaXaO8LaK8VSowJRwYy
 hpRwgKbXHzALezdg7jdWKBqlCsoK+4aBUKfwPnhkeZzyLfHzh+yMr/hW1PeuDPG6JCQR
 fDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708187797; x=1708792597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4K4P67FDnIwvxD62QsllIQlR3nVVEyEy8gCXYYasAYc=;
 b=cVk4C7/ee9miU1/kIB5Fievsj0pN3WbXSpsLzcwLJR9odoe7RTIRlz0LQVbd8oSKle
 I4Mh7QIW36EwwScLAYndNPcs6wej2/G0y3C/ee5pDGBmCpSjy0dNuqNKPLE61iu29gWI
 gBiPvJhrmdTUI1jADWc3RX0Kfzbw95HCAACkn3IsSjMl9HHXsJKg5I97wlt+GG9fOY5m
 tt24rSkQ0CWvFmiUH60xIC4jw2HKDtU61YH8fU6tIibYPLXhzhQaiqsuC6jD+YFiRX0P
 FNLyDp81n3s/bBI6Uj9VkFdI8MUmB8HV6PhnFIBMmM7l2iVgR7QXPIiOb+rsHPe7KdKA
 xWYg==
X-Gm-Message-State: AOJu0YxhWmNi3dDNlSKvtWQnTqXHgfh5L6vo18todoRFntHYh2EhwfBg
 OwGzuVCAM0ngQRyuzkWxUNI4oxIzvAeYHnhxQIEg712eJdEOl9DLEzaFBAPHG9Mk0tReRyur0sO
 1LB4lKKAdgRpTWDolkGzHsPiCosReons0
X-Google-Smtp-Source: AGHT+IHNM5v+UhAK4IrvmTr9bacIngPKuJMr+fNJU0BwMp84fUSqe8lEw+I8hNFAHqcsqF0MG7GeY03t7Q36wNeAeB4=
X-Received: by 2002:a05:6402:2051:b0:564:41a5:b976 with SMTP id
 bc17-20020a056402205100b0056441a5b976mr224620edb.10.1708187797062; Sat, 17
 Feb 2024 08:36:37 -0800 (PST)
MIME-Version: 1.0
References: <eb9a091f-9f8e-401a-bd71-a9a3511a21b0@reposit.be>
In-Reply-To: <eb9a091f-9f8e-401a-bd71-a9a3511a21b0@reposit.be>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 17 Feb 2024 16:36:25 +0000
Message-ID: <CALeDE9Oy3YgAE1rW6kVimYybQpq-h4PEPKkvG7WuwHv1zFZ2+Q@mail.gmail.com>
Subject: Re: How To Move Root Partition From eMMC to SSD
To: spamsink <spamsink@reposit.be>
Cc: u-boot@lists.denx.de
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

> I am running the NanoPi R6C.  The device is not capable of booting from
> the SSD, the next best thing is to load the root filesystem from the SSD.

By booting you mean loading the firmware from SSD (by which I think
you mean NVME right).

> Using rockchip's repos, I compile from source the images to boot 1) from
> the microSD card and 2) from eMMC.  I install to the eMMC.  Then, so as
> not to mount any partitions from eMMC, I boot from the microSD card, and
> I clone the root partition from the eMMC (/dev/mmcblk2p8) to the SSD
> (/dev/nvme0n1p1).
>
> I boot from the eMMC, the output of "cat /proc/cmdline" is:
>
> storagemedia=emmc androidboot.storagemedia=emmc androidboot.mode=normal
> androidboot.dtbo_idx=0 androidboot.verifiedbootstate=orange
> earlycon=uart8250,mmio32,0xfeb50000 console=ttyFIQ0 coherent_pool=1m
> irqchip.gicv3_pseudo_nmi=0 rw root=/dev/mmcblk2p8 rootfstype=ext4
> rootflags=discard data=/dev/mmcblk2p9 consoleblank=0
> cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory swapaccount=1
> androidboot.fwver=uboot-a83a7263ef-01/09/2024
>
> How do I change "root=/dev/mmcblk2p8" to "root=/dev/nvme0n1p1"?
>
> I connect to the serial port and get to the U-Boot monitor.  I examine
> the variables.  "bootcmd" runs "bootrkp" which boots the system.
> "bootrkp" ignores "bootargs", I confirm this by deleting "bootargs"
> before running "bootrkp", the system boots up as before with no change
> in behavior.  "bootrkp" is implemented in file "cmd/bootrkp.c".  That
> code emits the equivalent of:
>
> setenv bootm-no-reloc y
> booti 0x400000 0xa200000:0x7b2bc0 0x8300000
>
> Can I tell U-Boot to load the root partition from /dev/nvme0n1p1, either
> by entering commands at the monitor, or by modifying the source code of
> U-Boot, or through any other means?

You don't mention what OS you're trying to load, is it Android?

So upstream U-Boot can boot a Linux OS from NVME on a rk3588 device,
but it appears you're using the Rockchip fork and I have no idea of
the state of that.

The upstream U-Boot doesn't yet have the R6C.

Generally if a device doesn't have something like a SPI flash where
you can put firmware it's fine to use the eMMC for firmware and it
should be able to run an OS from NVME.

If you're not using Android and are using a standard Linux distro I
would look at enabling "distro boot" in the rockchip fork which will
give you a standard UEFI boot interface and things should work. I have
no idea if the U-Boot fork you're using includes PCI or NVME support
but obviously make sure the appropriate drivers are enabled for that
(look at the upstream Rock5B config).

Unfortunately I can't offer much more help from there as I generally
only deal with upstream.

Peter
