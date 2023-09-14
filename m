Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FF2EEAA6E
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 20:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D238658D;
	Thu, 14 Sep 2023 22:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oxRgP8T+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD75C86596; Thu, 14 Sep 2023 22:22:38 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6E4986560
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 22:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-502f302b68dso123285e87.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 13:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694722956; x=1695327756; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PO8mmI8n8h3HddmkLeNWSh70rH7gfxUCzIqxC74rO+I=;
 b=oxRgP8T+omgZXygn/ClW0jhFRNWSA3zkLAuVMApSCpGAgd+4Z4r+cWGoXroJ3bAJUn
 urB85ZuhEUakKFyyqqfdMVQ+S2Sw1xStkl/hOB2/3z/TI+0Ua0txentE2ugmWUUgXpgY
 oHMM1r8JqOT6nMibJfjKqc7Jnm42XndZTpLYih3uRSDfUXYgY5/+0lyjHJ25e9B6FIHp
 4icbNW16nQruR0xl9/2ltO91zOQ1HFPRH/eGm/ZjsC3qQ4k5sM72qIwLxIxvAiC0ERrt
 p2/oKyANnsjQQM8BrFyO3Kh7Gv2EnPz5msWholx5MFB51PEIVL1otmdgGZpzUKqSY+QM
 UFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694722956; x=1695327756;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PO8mmI8n8h3HddmkLeNWSh70rH7gfxUCzIqxC74rO+I=;
 b=bAUWxcnjXA9PTxpJGN07Jj1XGSJ2Ownrzv93239920kmoFK4JSJ4l/k41RntHejlUd
 9itOO0tpeHT5y8esMMksKyxuqbH3eYo+yZtlec7Oz3aGdnebOGksgiHAF890aio0XLMB
 N9pStSKA5n7z7yEm313HlR+pu2trnvQs8A6JNZEkYj0Wga3Sg1J2CBDYlOJpKu3GnCOx
 OhV4GlqudeUc7dfsULdJWJflZ+JBJJ2kYGYIEpMpR2bkXQ+FVbtOIRWrFSe5SwsxQm1Z
 DfxkDSqyRqV389wC9F3Emkdm+ihVQ3cd9Yq7JtAMl5HcNGc4gZQLRoVtw5SKg0H0X6dG
 GwUg==
X-Gm-Message-State: AOJu0YwO/94ECHCZkm/SlW4rN8mL5WF5QjOskZnIPoOW9/xs96OoNK9s
 pNQVIaAbtB11pJrjktAxeFM=
X-Google-Smtp-Source: AGHT+IHYdPqDtSUCS6XbZntUiyvP8uZHqIAqftvLgIffaNH2sGM+6AKTYICAewFBTSBCQvSKlDTz7Q==
X-Received: by 2002:a05:6512:3d9e:b0:500:83dd:27e6 with SMTP id
 k30-20020a0565123d9e00b0050083dd27e6mr6552065lfv.27.1694722955673; 
 Thu, 14 Sep 2023 13:22:35 -0700 (PDT)
Received: from localhost ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
 by smtp.gmail.com with ESMTPSA id
 c27-20020ac244bb000000b00502b04e2722sm397228lfm.3.2023.09.14.13.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:22:35 -0700 (PDT)
Date: Thu, 14 Sep 2023 23:22:34 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Hans de Goede <hdegoede@redhat.com>, u-boot@lists.denx.de,
 Samuel Holland <samuel@sholland.org>, Jarrah Gosbell <kernel@undef.tools>,
 Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Vagrant Cascadian <vagrant@debian.org>, Jonas Smedegaard <dr@jones.dk>
Subject: Re: [PATCH] sunxi: board: provide CPU idle states to loaded OS
Message-ID: <ZQNris+EpoAIQjMU@skv.local>
References: <20230904205430.1647654-1-andrej.skvortzov@gmail.com>
 <20230905092712.6ba245bb@donnerap.manchester.arm.com>
 <ZPboy228t8rVajL8@skv.local> <20230906011232.05ee691a@slackpad.lan>
 <ZPjm30KGDpY30D7k@skv.local> <20230911231510.46b248ac@slackpad.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230911231510.46b248ac@slackpad.lan>
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

On 23-09-11 23:15, Andre Przywara wrote:
> On Wed, 6 Sep 2023 23:53:51 +0300
> Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> 
> > > > > > When using SCPI as the PSCI backend, firmware can wake up the CPUs and
> > > > > > cluster from sleep, so CPU idle states are available for loaded OS to
> > > > > > use. TF-A modifies DTB to advertise available CPU idle states, when
> > > > > > SCPI is detected. This change copies nodes added by TF-A to any new
> > > > > > dtb that is used for loaded OS.    
> > > > > 
> > > > > Why do you need that, exactly? Why not just use $fdtcontroladdr for the
> > > > > kernel? We now keep the U-Boot copy of the .dts files in sync with the
> > > > > kernel. If you need to modify the DT in U-Boot, for instance by applying
> > > > > overlays, you can copy that DTB into a better suitable location first:    
> > > > > => fdt move $fdtcontroladdr $fdt_addr_r    
> > > > > 
> > > > > In any case, there shall be only one DT, that one in the U-Boot image. Why
> > > > > do you need to load another one for the kernel?    
> > > > 
> > > > extlinux is used by distributions (sometimes with device-specific changes especially  
> > > 
> > > What distros are that? I guess some special ones, targeting embedded
> > > devices, like the Pinephone?  
> > 
> > It's more likely universal operating system. In my particular case
> > this is Mobian (several device-specific packages on top of
> > Debian). It's very-very close to Debian with a goal to be
> > pure Debian in the near future.
> > 
> > Rhino Linux is using extlinux as well and will benefit for this change
> > as well.
> 
> We seem to have a very different understanding of "universal operating
> systems" ;-)
> You seem to talk about specific distros for embedded devices, whereas I
> think of Ubuntu/Debian/Fedora/Arch/you-name-it.

I was talking about Debian (The universal operating system ;-)
initially. Even if PinePhone in my case runs Mobian,
it uses the same packages and scripts and repositories from Debian. The
difference is quite small (kernel and some other small changes).

> And I still don't understand what a particular distribution has to do
> with that: this is purely a question of boot firmware and who provides
> the DTB.
> > 
> > > > for platforms not fully supported by mainline yet),  
> > > 
> > > Do you need any changes to the DT? Do you need to apply overlays?
> > > If you run on a non-mainlined platform, you could still put your DT
> > > into the U-Boot tree, then you wouldn't need to load another DTB, which
> > > also simplifies the deployment on the kernel/distro side.  
> > 
> > Currently Mobian linux kernel for sunxi-devices contains 36 extra patches with DT
> 
> That does not sound good. Why are those patches not upstream?

Agree, I ask the same question. Some of the patches were posted for
review and stalled, some of them haven't been posted. I'm preparing
table to track current status of the patches. Maybe ping some of them.

There are some big and complex changes like wlan/bt driver, that it's hard to
upstream in the current shape.

> > modifications (add/remove nodes, modify existing properties). One of
> > them unconditionally adds cpuidle states to DT, that I'm trying to fix
> > upstream here with the proposed change.
> 
> That's very honourable, but not every patch that works(TM) is the right
> approach to take upstream.

Sure, this one will probably stay in our patches until all DT changes
are upstream.

> > Mobian doesn't provide
> > device-specific bootloader (u-boot) and there is on-going work on
> > making device-independent universal images.
> 
> With "universal image" you mean a single rootfs, and a single kernel for
> every device? Of course, this is how Linux works everywhere, and the
> arm64 kernel was a single-image kernel from day one (same as x86). And
> taking the DTs out there and into firmware is just even more
> consequential.
> 

> > 
> > Regardless proposed change. Changes to dtb nodes already copied in
> > u-boot on the fly in boot/image-fdt.c:image_setup_libfdt. For example,
> > created optee nodes are copied there.
> 
> Yes, that is an example, just not a particularly good one. This seems
> to originate from 2019, again building on the idea that you need to load
> a DTB for the kernel from somewhere. I don't like to proliferate those
> ideas anymore.
> 
> > I've just put platform specific
> > changes into platform specific ft_board_setup, that was made
> > apparently exactly for that.
> 
> Not really, that's for platform specific runtime *adjustments*, like
> adding a unique MAC address, or adding simplefb DT nodes.

Thanks again for taking time and explaining your position. I agree, that in
a long term dtb should be provided by u-boot. In that case proposed
change will not be needed. Hopefully we'll get all changes upstream
and could use $fdtcontroladdr some day.

-- 
Best regards,
Andrey Skvortsov
