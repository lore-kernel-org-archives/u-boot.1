Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D1FEE14D3
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 20:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D7CD8619A;
	Wed,  6 Sep 2023 22:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SshkQrUy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6882286308; Wed,  6 Sep 2023 22:53:56 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 517D886177
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 22:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2bcbfb3705dso5169151fa.1
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 13:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694033632; x=1694638432; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xE2ld7s63oztC8I5QVzmEQlIH4AjAbuHE2uVYljD5Z0=;
 b=SshkQrUy5uC7o1FZLvNuNRPyMybm9RtBVUYwg2V1U8BCSawOBY5Zk6Ofg+LPzFUHj4
 TFzB9zEOtDdBUZGwuaMOqjvnjmKO5KUO/ECFkSHWk2YJ+rAPGntPSOlrJ4YYvxMR4i1g
 7hCLb2LvDLhALyUWSdX8HrJIT6IwRD1lH/PDu6n5ARcPDnkJsryOsX0mx9HJ9ji/McQu
 fXYeLr8H/UqE4navHMiIy/I3XvqMvbdOB9WycToJitv5LLLEiiIkvUdLrHrHEOIFNsnt
 O/ba8+5r+HVoR/HKuGB6QTF6qRk1v6meTBxuu8qZZeDWqvHzrGbWl7z/ne78t+eQM7fY
 FT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694033632; x=1694638432;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xE2ld7s63oztC8I5QVzmEQlIH4AjAbuHE2uVYljD5Z0=;
 b=QvhVCuieOXOSFwif58iO+3EskFnZIVFmA8MNq/xvPHj4Nf+9MvLVOWbPkRU+Sjsf+k
 z0QNSMcrsbEOldPEKKmimnm8tTaNZNbmm9SWs8/2OV3LktmrcqetWLG4WoCKcnrDVKNb
 q71zbUQwoPanZwrIr8SbpqxmM1AfgSTD1pL8x7nZyXFsTBU0X4DD9meDTZl3mxWoUYRG
 8VhQoVzY4qxNaZVTZNPFUu6BrkukNoYdzOlKlft1GAiTAQBBU9c2d1oOi9geQR4FHjDd
 BXO9r0+RPbu2cOjArO2gwwRb9ZE2G6mUKDYN7HY1l5nzpKvU8WerNVh+mhEKMixydGjz
 xVtw==
X-Gm-Message-State: AOJu0Ywhcx75QvrqRkcQHr3VRZ7k36KgkRhZ/Xl0x7ft1ToNJ+w9eXdW
 PYYWmdwR4Atkvfao9rzihuY=
X-Google-Smtp-Source: AGHT+IFZuFU/8Qb0yOx2+tQ6P2Zi+a2bs/QhZ8kosX1tSWJPIHinu3aw5IMRP8BWsXTD4oNRD7Fv+g==
X-Received: by 2002:a05:651c:103b:b0:2bc:c51d:daa1 with SMTP id
 w27-20020a05651c103b00b002bcc51ddaa1mr3137921ljm.39.1694033632184; 
 Wed, 06 Sep 2023 13:53:52 -0700 (PDT)
Received: from localhost ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
 by smtp.gmail.com with ESMTPSA id
 s21-20020a2e98d5000000b002b6fe751b6esm3558302ljj.124.2023.09.06.13.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 13:53:51 -0700 (PDT)
Date: Wed, 6 Sep 2023 23:53:51 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Hans de Goede <hdegoede@redhat.com>, u-boot@lists.denx.de,
 Samuel Holland <samuel@sholland.org>, Jarrah Gosbell <kernel@undef.tools>,
 Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Vagrant Cascadian <vagrant@debian.org>, Jonas Smedegaard <dr@jones.dk>
Subject: Re: [PATCH] sunxi: board: provide CPU idle states to loaded OS
Message-ID: <ZPjm30KGDpY30D7k@skv.local>
References: <20230904205430.1647654-1-andrej.skvortzov@gmail.com>
 <20230905092712.6ba245bb@donnerap.manchester.arm.com>
 <ZPboy228t8rVajL8@skv.local> <20230906011232.05ee691a@slackpad.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230906011232.05ee691a@slackpad.lan>
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

Hi Andre,

On 23-09-06 01:12, Andre Przywara wrote:
> On Tue, 5 Sep 2023 11:37:31 +0300
> Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> 
> Hi,
> 
> > On 23-09-05 09:27, Andre Przywara wrote:
> > > On Mon,  4 Sep 2023 23:54:30 +0300
> > > Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> > > 
> > > Hi Andrey,
> > >   
> > > > When using SCPI as the PSCI backend, firmware can wake up the CPUs and
> > > > cluster from sleep, so CPU idle states are available for loaded OS to
> > > > use. TF-A modifies DTB to advertise available CPU idle states, when
> > > > SCPI is detected. This change copies nodes added by TF-A to any new
> > > > dtb that is used for loaded OS.  
> > > 
> > > Why do you need that, exactly? Why not just use $fdtcontroladdr for the
> > > kernel? We now keep the U-Boot copy of the .dts files in sync with the
> > > kernel. If you need to modify the DT in U-Boot, for instance by applying
> > > overlays, you can copy that DTB into a better suitable location first:  
> > > => fdt move $fdtcontroladdr $fdt_addr_r  
> > > 
> > > In any case, there shall be only one DT, that one in the U-Boot image. Why
> > > do you need to load another one for the kernel?  
> > 
> > extlinux is used by distributions (sometimes with device-specific changes especially
> 
> What distros are that? I guess some special ones, targeting embedded
> devices, like the Pinephone?

It's more likely universal operating system. In my particular case
this is Mobian (several device-specific packages on top of
Debian). It's very-very close to Debian with a goal to be
pure Debian in the near future.

Rhino Linux is using extlinux as well and will benefit for this change
as well.

> And who is generating extlinux.conf then? Is that some distro specific
> scripting, similar to how grub is configured?

extlinux.conf is automatically generated by standard Debian
u-boot-menu package. See [1] and [2]. 

> Honest questions, I am not a user of extlinux, I mostly use UEFI
> booting, or type U-Boot commands directly for experiments, or use
> boot.scr, as a quick-and-dirty hack.


> > for platforms not fully supported by mainline yet),
> 
> Do you need any changes to the DT? Do you need to apply overlays?
> If you run on a non-mainlined platform, you could still put your DT
> into the U-Boot tree, then you wouldn't need to load another DTB, which
> also simplifies the deployment on the kernel/distro side.

Currently Mobian linux kernel for sunxi-devices contains 36 extra patches with DT
modifications (add/remove nodes, modify existing properties). One of
them unconditionally adds cpuidle states to DT, that I'm trying to fix
upstream here with the proposed change.
DT overlays are not used.

Honestly I don't think that using dtb from u-boot will simplify
distribution deployment and maintenance. IMHO, it will make things
more complex. Currently on my device there are records in extlinux.conf
for 5.9, 5.10, 5.15, several 6.1 kernels, that I'm working on. All of
them have slightly (or sometimes more) different device-trees. Having
kernel and dtb deployed together makes life so much easier.

Mobian's dtb can't be put into u-boot. Mobian doesn't provide
device-specific bootloader (u-boot) and there is on-going work on
making device-independent universal images. 
As many other mobile Linux distributions Mobian relies on
Tow-Boot. That is used as a cross-distribution firmware (u-boot/tf-a/crust). [3]

> > then U-Boot loads DT defined in
> > extlinux.conf file. u-boot scripts are not used in case of extlinux at all.
> 
> That's fine, you don't need any U-Boot scripts for this to work. If
> there is no "fdt" or "fdtdir" label in extlinux.conf, then the U-Boot
> PXE code will eventually fall back to $fdtcontroladdr - I just tested
> that.
> So could you make that work for you? I guess all you need to change is
> to remove any fdtdir label from extlinux.conf?
> 
> Cheers,
> Andre

Regardless proposed change. Changes to dtb nodes already copied in
u-boot on the fly in boot/image-fdt.c:image_setup_libfdt. For example,
created optee nodes are copied there. I've just put platform specific
changes into platform specific ft_board_setup, that was made
apparently exactly for that.


1. https://packages.debian.org/trixie/u-boot-menu
2. https://salsa.debian.org/debian/u-boot-menu
3. https://tow-boot.org/

-- 
Best regards,
Andrey Skvortsov
