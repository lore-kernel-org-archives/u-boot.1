Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00067C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 08:20:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13D1D810EB;
	Fri, 25 Apr 2025 10:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KFUU4ZSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7320581B4B; Fri, 25 Apr 2025 10:20:14 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E066F8059A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 10:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-549b116321aso2340479e87.3
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 01:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745569211; x=1746174011; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Eob7/C8ovksMNN+68IdMHg5TEaH+XXYEwxE//c04w7s=;
 b=KFUU4ZSci+Pn68YPk6KR3NE9wQWB3Cx6sKjP7I8Jhg713jsfDn33SOAsqFCtcDiiJr
 UxVCfXWoZgGBzVIr0dXOcPQQrlCAWoG/Rh51crKDjG6faHOa4D69eUtkNWLTI1A0Jreq
 IjfyDUqWOxDQRLhzfLZN9IjBXP6DHJFp45jOJ1LCuWbHEDif07hE3qbU6r54zhyFzvEP
 j8MvZEQwIUD1Io7+0zlVGJ2dkPITLENiREAOheSwhntujbh+AC3Zik9c0KuhgNJLn7A3
 XUX6I4KsLA/veeX/CTh49clAJqFytYW/5aoW2KVW2gHwQgQurMCWgp49Wh3EWvhPLAz0
 iQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745569211; x=1746174011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eob7/C8ovksMNN+68IdMHg5TEaH+XXYEwxE//c04w7s=;
 b=c1l/zJ0ZKh0Qmepbiu7q7kw0usLA6srTsIvPtRHIDsx85pvZ32hijScHkFAU3Ajxj/
 KT4M/9zd6UAb4q3t3BWrUjcc96Fmx7yRNCKFbuN2ldE9aHB50zBp+81Gha91tbCo0EhH
 2iNWqBdWKlZn4g5dcVm4sCa7oPKj47UsjAAN0Fwb0KKXEu8mt8Jjs4b2PnTIrnb9Y5dt
 W/inSXyrzTqDrlX0a+DLZflf6Y/btsgSszfp3cpfUxDEQD2ZZcRexowG63Or062zglgJ
 lk0ieHYsLyxuKupcv9JAUldJJOh/uq2b2i4W99A1NJidlXnc/vtUNjNVb0sdUGmz/vI2
 yzBQ==
X-Gm-Message-State: AOJu0YyNejOil8/lkHF4BVdx+9nCvcWJplzcBdOHdzsXo+DQgrpAkJ0V
 EHDffkmWBx7wXHUp1JdPQM2/v1mfvgPljovRD3ajIpjRz9/9vndGIIKyLqJdlJWa1XNTedQGmOY
 KiKBqxC1Mak00Ox7+6ePattSd5ys=
X-Gm-Gg: ASbGnctRW05cNyMZBDpB5aRG3k7KQ64uVO8MWnj1JWCWhdd3FBvtfZ82gSWu3joOsIZ
 5ywSGiw/QTiOpz/hC5JsUXhlLk1MVh2epwHtmK8MZBbq6oj6mpy4UZIIXIJSi0p8yWNgmXDZdqS
 3DNH/N0m9uYpHWGmqCuJOss4o=
X-Google-Smtp-Source: AGHT+IE45BFYZloVk1XXzgcAIig0JYrgnxuSilrfnvcfyByg3wHNcPFM2xKYrR41fwtYxNURSHYxO7M5HvnzEi809Rw=
X-Received: by 2002:a2e:bc0b:0:b0:30b:c9cb:47e5 with SMTP id
 38308e7fff4ca-31905b6a79bmr4078381fa.8.1745569210692; Fri, 25 Apr 2025
 01:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAEyMn7b90ybqMOgb4ViAaQVqvTuma-HyYkwEvSVHfowfvEd3tA@mail.gmail.com>
 <20250424174539.GL5495@bill-the-cat>
 <CAEyMn7asyKz8MnXUBZqtuFehR4Vk8j_5ysRCq5=H3EqiL36aMw@mail.gmail.com>
In-Reply-To: <CAEyMn7asyKz8MnXUBZqtuFehR4Vk8j_5ysRCq5=H3EqiL36aMw@mail.gmail.com>
From: Heiko Thiery <heiko.thiery@gmail.com>
Date: Fri, 25 Apr 2025 10:19:57 +0200
X-Gm-Features: ATxdqUGGHXhY5Iy8IT2_sgKjV2pDdxq9uLPIm1OQBSW09Uq8NLb3icwOyX92aQQ
Message-ID: <CAEyMn7bb+9X3UhWuwd=zgnsUPf4naRi_WMFPU_i8LQbUshcb5g@mail.gmail.com>
Subject: Re: bootflow: extlinux and menu
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
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

Hi Tom,

Am Do., 24. Apr. 2025 um 19:49 Uhr schrieb Heiko Thiery
<heiko.thiery@gmail.com>:
>
> Hi,
>
> Am Do., 24. Apr. 2025 um 19:45 Uhr schrieb Tom Rini <trini@konsulko.com>:
> >
> > On Thu, Apr 24, 2025 at 07:36:06PM +0200, Heiko Thiery wrote:
> >
> > > Hi,
> > >
> > > I tried bootflow for the first time and wanted to test my extlinux
> > > configuration with separate menu entries. But I don't see that the
> > > menu is shown. The default value is always selected. Am I right in
> > > thinking that this is not supported with extlinux?
> >
> > I suspect Simon also found this recently and fixed it as part of another
> > series. It's likely in:
> > https://patchwork.ozlabs.org/project/uboot/list/?series=449177&state=*
> > It wasn't based on master or next:
> > https://patchwork.ozlabs.org/project/uboot/cover/20250319143820.2385092-1-sjg@chromium.org/
> > And some of the tidying up lead to size growth in a number of platforms:
> > https://patchwork.ozlabs.org/project/uboot/patch/20250319143820.2385092-2-sjg@chromium.org/
> > Along with needing to document some of the user visible changes:
> > https://patchwork.ozlabs.org/project/uboot/patch/20250319143820.2385092-7-sjg@chromium.org/
> >
> > You might want to see if just patches 7 / 8 / 9 resolve the issue you
> > see and if so we can get just those merged in.
>
> Sounds promising. I will try to test this in the next days (when I'm
> back in office) and give you a feedback.

Unfortunately it does not solve the problem. What I have is the
following extlinux config file on my boot partition:

>>>> extlinux.conf
label Kontron SMARC-sAM67
  kernel /Image
  devicetree /k3-am67a-kontron-sa67.dtb
  append root=PARTUUID=f615c46d-fe53-4547-8875-4c21438d931e rootwait

label Kontron SMARC-sAM67 on Evaluation Carrier 2.0
  kernel /Image
  devicetree /k3-am67a-kontron-sa67.dtb
  devicetree-overlay /k3-am67a-kontron-sa67-ads2.dtbo
  append root=PARTUUID=f615c46d-fe53-4547-8875-4c21438d931e rootwait
>>>>

>>>> output
[SDHC] => bootflow scan
Cannot persist EFI variables without system partition
Bus usb@31000000: Register 1000840 NbrPorts 1
Starting the controller
USB XHCI 1.10
Bus usb@31200000: cdns-usb3-host usb@31200000: set 1 has failed, back to 0
scanning bus usb@31000000 for devices... 1 USB Device(s) found
scanning bus usb@31200000 for devices... 1 USB Device(s) found

Error: ethernet@8000000ethernet@800000 No valid MAC address found.

Error: ethernet@8000000ethernet@800000 No valid MAC address found.
[SDHC] => bootflow list
Showing all bootflows
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------
----------------
  0  efi_mgr      ready   (none)       0  <NULL>
  1  extlinux     ready   mmc          1  mmc@fa10000.bootdev.part_
/extlinux/extlinux.conf
  2  extlinux     ready   mmc          1  mmc@fa00000.bootdev.part_
/extlinux/extlinux.conf
---  -----------  ------  --------  ----  ------------------------
----------------
(3 bootflows, 3 valid)
[SDHC] => bootflow select 1
[SDHC] => bootflow info
Name:      mmc@fa10000.bootdev.part_1
Device:    mmc@fa10000.bootdev
Block dev: mmc@fa10000.blk
Method:    extlinux
State:     ready
Partition: 1
Subdir:    (none)
Filename:  /extlinux/extlinux.conf
Buffer:    ffad2b80
Size:      17f (383 bytes)
OS:        Kontron SMARC-sAM67 on Evaluation Carrier 2.0
Cmdline:   (none)
Logo:      (none)
FDT:       <NULL>
Error:     0
[SDHC] => bootflow select 2
[SDHC] => bootflow info
Name:      mmc@fa00000.bootdev.part_1
Device:    mmc@fa00000.bootdev
Block dev: mmc@fa00000.blk
Method:    extlinux
State:     ready
Partition: 1
Subdir:    (none)
Filename:  /extlinux/extlinux.conf
Buffer:    ffad3b80
Size:      17f (383 bytes)
OS:        Kontron SMARC-sAM67 on Evaluation Carrier 2.0
Cmdline:   (none)
Logo:      (none)
FDT:       <NULL>
Error:     0
[SDHC] =>
>>>>

For both found extlinux based entries it shows in the OS info line
"Kontron SMARC-sAM67 on Evaluation Carrier 2.0" that is the name/label
of the seconds entry. But when booting either 1 or 2 it always loads
the first entry of extlinux without loading and applying the overlay.

Also support for having the menu shown is also not available.

--
Heiko


> Thanks in advance.
>
> BR
> Heiko
>
> > --
> > Tom
