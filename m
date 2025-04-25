Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5098CC369D3
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 14:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9BB782757;
	Fri, 25 Apr 2025 16:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G5LT9Z2L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC976828E1; Fri, 25 Apr 2025 16:36:30 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F8C582757
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 16:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so334478466b.0
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745591788; x=1746196588; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lfW3c6rfuysFW8hrHArQ4lVPBqbKyBADvrphRr+jg5o=;
 b=G5LT9Z2L1cJeNBsSLEMeFFuahOoYsacqz2AG3VHL0BkqOOZrX1u3TPbj3KTIv1CuMk
 TjMj7WRY4a+MGnI+33lVtT3+9cyxjU+oviuaqXfg/Cmy0EzuXaCZLlnaDuGnKe+QBnHP
 8WFt9tjLfFpQbwI8DLMY/82EQMyYlB85a7XY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745591788; x=1746196588;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lfW3c6rfuysFW8hrHArQ4lVPBqbKyBADvrphRr+jg5o=;
 b=APpxC4Nynpu9n45dhPDiUiXb8cKv2LbnSz4/SdEPl4hqcz6Tup3SS9Ar9/fvCi6hvl
 U4HYXIlXLo/Yn7Pe9lBB+FzsC+xvqu4tD4JLxRp8scUy6ACZ3vd+rvRruaaIEbk9cGbM
 juJB8b8x13B6M7T7lnx7Ea7/a5rMfZXfebqnrO+a6WRO07KefxNf0ZkUZDfSoqZ13wRP
 j7JZafvjTeKc+AD5CF2xSOedu9aKGkx78IeDtJEGtHBWnpKmSTwFdEXCCZsBhbfD87TY
 fBbbeGPNGj5NS6qxYoySzq44KpHAcRNLUsusAp3qzr6MO4cTbzH3JM5vwgayAoS0XTxa
 /k4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYSMna2U63TwYu/H9IhdyuF15nXay9gWUGALWJ7khHNWc4Tk9VeqToJHPlk0c7l8ktrmS4/ZI=@lists.denx.de
X-Gm-Message-State: AOJu0YwUJQvLw6fwYfD+62a7cPgFWJebXG0Nx7RTpye+w6LAp5/DuY/s
 5vIH1zMdp/ba7779M89ODIj5qJWsNgMw3nEuG/l1xwE3pWPEj+rczGxwr9YN3A8gY+ZyA7Lce6x
 IaFCM7vkbbiqubseycHWj4Mxck7M2NKWfaNOpzar//LvFnKw=
X-Gm-Gg: ASbGncss1wKgOBnjBEHDZ5qVowKOJyjV7XN1v7boOsX+e1rHqUFrQKkliSDI98b0FR5
 zW+gRRGYLknBojufdl3N69CRA0EBqiPYcm3CJn+UgvbWHDa9lEJg49InZEgWM+Iknxu7P5w7a4v
 yOW0uWZzvGsG4EM4AYT2iCmlSks3JEwfDfQQ==
X-Google-Smtp-Source: AGHT+IFxpKzETpSnvGsdX9c9e+v4iLIFwWMU6ub1isZ36NaZYbzFbLgk4fAZbm4Q/obxmKizHcgIFbAwH61+tjfeHKk=
X-Received: by 2002:a17:907:9409:b0:ac3:446d:142 with SMTP id
 a640c23a62f3a-ace7104eb61mr273007466b.2.1745591787761; Fri, 25 Apr 2025
 07:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAEyMn7b90ybqMOgb4ViAaQVqvTuma-HyYkwEvSVHfowfvEd3tA@mail.gmail.com>
 <20250424174539.GL5495@bill-the-cat>
 <CAEyMn7asyKz8MnXUBZqtuFehR4Vk8j_5ysRCq5=H3EqiL36aMw@mail.gmail.com>
 <CAEyMn7bb+9X3UhWuwd=zgnsUPf4naRi_WMFPU_i8LQbUshcb5g@mail.gmail.com>
In-Reply-To: <CAEyMn7bb+9X3UhWuwd=zgnsUPf4naRi_WMFPU_i8LQbUshcb5g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Apr 2025 08:36:16 -0600
X-Gm-Features: ATxdqUGIX0p64H2iqP1THvf4dyDZ0rkmeRdx4h2-ycrA9HH7YHHXN70fq1crpno
Message-ID: <CAFLszTg=gLDydqc-US7xwhR=yRw1ueRhSQOXDUNZ=2bnxs_=5w@mail.gmail.com>
Subject: Re: bootflow: extlinux and menu
To: Heiko Thiery <heiko.thiery@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heiko,

On Fri, 25 Apr 2025 at 02:20, Heiko Thiery <heiko.thiery@gmail.com> wrote:
>
> Hi Tom,
>
> Am Do., 24. Apr. 2025 um 19:49 Uhr schrieb Heiko Thiery
> <heiko.thiery@gmail.com>:
> >
> > Hi,
> >
> > Am Do., 24. Apr. 2025 um 19:45 Uhr schrieb Tom Rini <trini@konsulko.com>:
> > >
> > > On Thu, Apr 24, 2025 at 07:36:06PM +0200, Heiko Thiery wrote:
> > >
> > > > Hi,
> > > >
> > > > I tried bootflow for the first time and wanted to test my extlinux
> > > > configuration with separate menu entries. But I don't see that the
> > > > menu is shown. The default value is always selected. Am I right in
> > > > thinking that this is not supported with extlinux?
> > >
> > > I suspect Simon also found this recently and fixed it as part of another
> > > series. It's likely in:
> > > https://patchwork.ozlabs.org/project/uboot/list/?series=449177&state=*
> > > It wasn't based on master or next:
> > > https://patchwork.ozlabs.org/project/uboot/cover/20250319143820.2385092-1-sjg@chromium.org/
> > > And some of the tidying up lead to size growth in a number of platforms:
> > > https://patchwork.ozlabs.org/project/uboot/patch/20250319143820.2385092-2-sjg@chromium.org/
> > > Along with needing to document some of the user visible changes:
> > > https://patchwork.ozlabs.org/project/uboot/patch/20250319143820.2385092-7-sjg@chromium.org/
> > >
> > > You might want to see if just patches 7 / 8 / 9 resolve the issue you
> > > see and if so we can get just those merged in.
> >
> > Sounds promising. I will try to test this in the next days (when I'm
> > back in office) and give you a feedback.
>
> Unfortunately it does not solve the problem. What I have is the
> following extlinux config file on my boot partition:
>
> >>>> extlinux.conf
> label Kontron SMARC-sAM67
>   kernel /Image
>   devicetree /k3-am67a-kontron-sa67.dtb
>   append root=PARTUUID=f615c46d-fe53-4547-8875-4c21438d931e rootwait
>
> label Kontron SMARC-sAM67 on Evaluation Carrier 2.0
>   kernel /Image
>   devicetree /k3-am67a-kontron-sa67.dtb
>   devicetree-overlay /k3-am67a-kontron-sa67-ads2.dtbo
>   append root=PARTUUID=f615c46d-fe53-4547-8875-4c21438d931e rootwait
> >>>>
>
> >>>> output
> [SDHC] => bootflow scan
> Cannot persist EFI variables without system partition
> Bus usb@31000000: Register 1000840 NbrPorts 1
> Starting the controller
> USB XHCI 1.10
> Bus usb@31200000: cdns-usb3-host usb@31200000: set 1 has failed, back to 0
> scanning bus usb@31000000 for devices... 1 USB Device(s) found
> scanning bus usb@31200000 for devices... 1 USB Device(s) found
>
> Error: ethernet@8000000ethernet@800000 No valid MAC address found.
>
> Error: ethernet@8000000ethernet@800000 No valid MAC address found.
> [SDHC] => bootflow list
> Showing all bootflows
> Seq  Method       State   Uclass    Part  Name                      Filename
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
>   0  efi_mgr      ready   (none)       0  <NULL>
>   1  extlinux     ready   mmc          1  mmc@fa10000.bootdev.part_
> /extlinux/extlinux.conf
>   2  extlinux     ready   mmc          1  mmc@fa00000.bootdev.part_
> /extlinux/extlinux.conf
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
> (3 bootflows, 3 valid)
> [SDHC] => bootflow select 1
> [SDHC] => bootflow info
> Name:      mmc@fa10000.bootdev.part_1
> Device:    mmc@fa10000.bootdev
> Block dev: mmc@fa10000.blk
> Method:    extlinux
> State:     ready
> Partition: 1
> Subdir:    (none)
> Filename:  /extlinux/extlinux.conf
> Buffer:    ffad2b80
> Size:      17f (383 bytes)
> OS:        Kontron SMARC-sAM67 on Evaluation Carrier 2.0
> Cmdline:   (none)
> Logo:      (none)
> FDT:       <NULL>
> Error:     0
> [SDHC] => bootflow select 2
> [SDHC] => bootflow info
> Name:      mmc@fa00000.bootdev.part_1
> Device:    mmc@fa00000.bootdev
> Block dev: mmc@fa00000.blk
> Method:    extlinux
> State:     ready
> Partition: 1
> Subdir:    (none)
> Filename:  /extlinux/extlinux.conf
> Buffer:    ffad3b80
> Size:      17f (383 bytes)
> OS:        Kontron SMARC-sAM67 on Evaluation Carrier 2.0
> Cmdline:   (none)
> Logo:      (none)
> FDT:       <NULL>
> Error:     0
> [SDHC] =>
> >>>>
>
> For both found extlinux based entries it shows in the OS info line
> "Kontron SMARC-sAM67 on Evaluation Carrier 2.0" that is the name/label
> of the seconds entry. But when booting either 1 or 2 it always loads
> the first entry of extlinux without loading and applying the overlay.
>
> Also support for having the menu shown is also not available.

The behaviour you should see is that (after the bootflow menu) you
should see a separate 'extlinux' menu which allows you to choose the
correct entry. So you will need 'menu label' instead of label.

As Tom mentions my tree has some additional patches here:

https://sjg.u-boot.org/u-boot/u-boot.git

in case that helps.

As to what you really want (putting each extlinux item in a separate
bootflow), that's the next step. I will get back to it, but most
likely not before the end of June. If you would like to try
implementing it yourself, let me know and I can send some pointers.

Regards,
Simon
