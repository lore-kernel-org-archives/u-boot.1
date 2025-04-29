Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44768C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 09:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64FF6809A5;
	Tue, 29 Apr 2025 11:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PHe6o7sm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A570280BAD; Tue, 29 Apr 2025 11:38:56 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01A0D8070C
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 11:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-30c2d427194so47762121fa.0
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 02:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745919533; x=1746524333; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mxqyLtTU83yQy1rXl79aZi86cn7poFlvb/mT7OkDlh0=;
 b=PHe6o7sm1M+m3IJ2xTs2AUbdABeGr9cjItG1AxQMveeFtYzrOB/qiERuATqOntk2ma
 Eon/Y8pa1bmE0nUSCfpR14o2lmf4GEGNe4sx5Pa9MiXFahZkU9o4Bief0hLJWl7G+UrE
 eSteWVAiy+0i73/oNpI0/NpO4YUDCGlh+aRVzOYUeuKYyge8rVdk8LGWRXD7wrHeBqSq
 U3rcqYbcXFRrDtOhjdrpf485ELG9Atv6pSTiy45eSx1q3/4XSzp2NybjrFtPrYj1xd4T
 wrzXc4rqERBvNGcRGSqkSw10HEMoNFz6vjEPnztV9fU+iuM63fCdEDq0w05HDM7sKu4m
 HBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745919533; x=1746524333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mxqyLtTU83yQy1rXl79aZi86cn7poFlvb/mT7OkDlh0=;
 b=RhVOWjBMpgroz3q/lAdQwg2kxO0AFHm0EFjW073m8DV1nPqavfXz0mIxO0rTYEP0Fk
 uH5ehGZo2HzJs30wyo/MnGPBXhxmzFOWH2SqA+MSjsnNLmMH7Ln5J5mdoy04fb5CUt06
 vRnCwCGdBJ4/TucYiSLqaSvAwHYKa2QbixYW/G6n6V6tSUn2grbfMhNs84EduAp8i/T7
 uaZhTpWIQWfZt3fQe5yNyU+bHAkjOX+E6LyzQD7sktyukWgaxJbCsfdyFwK3Yw8G3Yn9
 euORTSn/BBNHtkAny8wT0ey28aDZlgGuDlYB31YWc6o8qyOcgqXQ6Z1cDu/Ff8C1aKjQ
 sVGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7PE1pdLzrBN5WWtfMHAyzpRAu/3/gV4p9xQsoU1t3sI0z6oPem6J5icr4ZtA3poq4atOGaNI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzrtfh25hCGPPu/9CQsj+Z2X/0bB+No6RFjXrCBzuqSczlRuWNL
 uQF+dUUmZX8/jql2F3son36G3t64eFF/DbpjNLX0suqCVLNVbYtLRegOq8c7JV0yA11xLfDas0U
 q5Sq++zl4KIzx5p38y4yyCUE/IsY=
X-Gm-Gg: ASbGnctjMMUkOufx3HTseKRBuhsfHpyicvVTmjTelLzOh4a09DRfaGmhd5fngB0C2ll
 qkyMVwayrP4cYkFeABcfIvi3LgwVary+TN9ZMUTplpXDROUcL1F224DNefAuK+ZVT0mrKgmAgBH
 Rg6lfgbjPar0lT8PlngZIdsYI=
X-Google-Smtp-Source: AGHT+IGi4iS6HhAHksNk4savLmZjgvARi6geyabUQCpBJws4fmt+hRDdHj/7Lf3NP2U+yxonciFwakKQ9LG9LmpOcRw=
X-Received: by 2002:a05:651c:1582:b0:310:506c:613 with SMTP id
 38308e7fff4ca-31d5c4f0edemr6806451fa.37.1745919532291; Tue, 29 Apr 2025
 02:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAEyMn7b90ybqMOgb4ViAaQVqvTuma-HyYkwEvSVHfowfvEd3tA@mail.gmail.com>
 <20250424174539.GL5495@bill-the-cat>
 <CAEyMn7asyKz8MnXUBZqtuFehR4Vk8j_5ysRCq5=H3EqiL36aMw@mail.gmail.com>
 <CAEyMn7bb+9X3UhWuwd=zgnsUPf4naRi_WMFPU_i8LQbUshcb5g@mail.gmail.com>
 <CAFLszTg=gLDydqc-US7xwhR=yRw1ueRhSQOXDUNZ=2bnxs_=5w@mail.gmail.com>
In-Reply-To: <CAFLszTg=gLDydqc-US7xwhR=yRw1ueRhSQOXDUNZ=2bnxs_=5w@mail.gmail.com>
From: Heiko Thiery <heiko.thiery@gmail.com>
Date: Tue, 29 Apr 2025 11:38:39 +0200
X-Gm-Features: ATxdqUEjzpKCaOvSkbwMHqQZoccAhzSs_FQYRRf5z7hnpn9AQoVLjsBKvkKpi-c
Message-ID: <CAEyMn7Y+un5JHC4YCVkz=PzFiT-oM+Dtx_NLK6mzGi3GxpRNag@mail.gmail.com>
Subject: Re: bootflow: extlinux and menu
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Simon,

Am Fr., 25. Apr. 2025 um 16:36 Uhr schrieb Simon Glass <sjg@chromium.org>:

> Hi Heiko,
>
> On Fri, 25 Apr 2025 at 02:20, Heiko Thiery <heiko.thiery@gmail.com> wrote:
> >
> > Hi Tom,
> >
> > Am Do., 24. Apr. 2025 um 19:49 Uhr schrieb Heiko Thiery
> > <heiko.thiery@gmail.com>:
> > >
> > > Hi,
> > >
> > > Am Do., 24. Apr. 2025 um 19:45 Uhr schrieb Tom Rini <
> trini@konsulko.com>:
> > > >
> > > > On Thu, Apr 24, 2025 at 07:36:06PM +0200, Heiko Thiery wrote:
> > > >
> > > > > Hi,
> > > > >
> > > > > I tried bootflow for the first time and wanted to test my extlinux
> > > > > configuration with separate menu entries. But I don't see that the
> > > > > menu is shown. The default value is always selected. Am I right in
> > > > > thinking that this is not supported with extlinux?
> > > >
> > > > I suspect Simon also found this recently and fixed it as part of
> another
> > > > series. It's likely in:
> > > >
> https://patchwork.ozlabs.org/project/uboot/list/?series=449177&state=*
> > > > It wasn't based on master or next:
> > > >
> https://patchwork.ozlabs.org/project/uboot/cover/20250319143820.2385092-1-sjg@chromium.org/
> > > > And some of the tidying up lead to size growth in a number of
> platforms:
> > > >
> https://patchwork.ozlabs.org/project/uboot/patch/20250319143820.2385092-2-sjg@chromium.org/
> > > > Along with needing to document some of the user visible changes:
> > > >
> https://patchwork.ozlabs.org/project/uboot/patch/20250319143820.2385092-7-sjg@chromium.org/
> > > >
> > > > You might want to see if just patches 7 / 8 / 9 resolve the issue you
> > > > see and if so we can get just those merged in.
> > >
> > > Sounds promising. I will try to test this in the next days (when I'm
> > > back in office) and give you a feedback.
> >
> > Unfortunately it does not solve the problem. What I have is the
> > following extlinux config file on my boot partition:
> >
> > >>>> extlinux.conf
> > label Kontron SMARC-sAM67
> >   kernel /Image
> >   devicetree /k3-am67a-kontron-sa67.dtb
> >   append root=PARTUUID=f615c46d-fe53-4547-8875-4c21438d931e rootwait
> >
> > label Kontron SMARC-sAM67 on Evaluation Carrier 2.0
> >   kernel /Image
> >   devicetree /k3-am67a-kontron-sa67.dtb
> >   devicetree-overlay /k3-am67a-kontron-sa67-ads2.dtbo
> >   append root=PARTUUID=f615c46d-fe53-4547-8875-4c21438d931e rootwait
> > >>>>
> >
> > >>>> output
> > [SDHC] => bootflow scan
> > Cannot persist EFI variables without system partition
> > Bus usb@31000000: Register 1000840 NbrPorts 1
> > Starting the controller
> > USB XHCI 1.10
> > Bus usb@31200000: cdns-usb3-host usb@31200000: set 1 has failed, back
> to 0
> > scanning bus usb@31000000 for devices... 1 USB Device(s) found
> > scanning bus usb@31200000 for devices... 1 USB Device(s) found
> >
> > Error: ethernet@8000000ethernet@800000 No valid MAC address found.
> >
> > Error: ethernet@8000000ethernet@800000 No valid MAC address found.
> > [SDHC] => bootflow list
> > Showing all bootflows
> > Seq  Method       State   Uclass    Part  Name
> Filename
> > ---  -----------  ------  --------  ----  ------------------------
> > ----------------
> >   0  efi_mgr      ready   (none)       0  <NULL>
> >   1  extlinux     ready   mmc          1  mmc@fa10000.bootdev.part_
> > /extlinux/extlinux.conf
> >   2  extlinux     ready   mmc          1  mmc@fa00000.bootdev.part_
> > /extlinux/extlinux.conf
> > ---  -----------  ------  --------  ----  ------------------------
> > ----------------
> > (3 bootflows, 3 valid)
> > [SDHC] => bootflow select 1
> > [SDHC] => bootflow info
> > Name:      mmc@fa10000.bootdev.part_1
> > Device:    mmc@fa10000.bootdev
> > Block dev: mmc@fa10000.blk
> > Method:    extlinux
> > State:     ready
> > Partition: 1
> > Subdir:    (none)
> > Filename:  /extlinux/extlinux.conf
> > Buffer:    ffad2b80
> > Size:      17f (383 bytes)
> > OS:        Kontron SMARC-sAM67 on Evaluation Carrier 2.0
> > Cmdline:   (none)
> > Logo:      (none)
> > FDT:       <NULL>
> > Error:     0
> > [SDHC] => bootflow select 2
> > [SDHC] => bootflow info
> > Name:      mmc@fa00000.bootdev.part_1
> > Device:    mmc@fa00000.bootdev
> > Block dev: mmc@fa00000.blk
> > Method:    extlinux
> > State:     ready
> > Partition: 1
> > Subdir:    (none)
> > Filename:  /extlinux/extlinux.conf
> > Buffer:    ffad3b80
> > Size:      17f (383 bytes)
> > OS:        Kontron SMARC-sAM67 on Evaluation Carrier 2.0
> > Cmdline:   (none)
> > Logo:      (none)
> > FDT:       <NULL>
> > Error:     0
> > [SDHC] =>
> > >>>>
> >
> > For both found extlinux based entries it shows in the OS info line
> > "Kontron SMARC-sAM67 on Evaluation Carrier 2.0" that is the name/label
> > of the seconds entry. But when booting either 1 or 2 it always loads
> > the first entry of extlinux without loading and applying the overlay.
> >
> > Also support for having the menu shown is also not available.
>
> The behaviour you should see is that (after the bootflow menu) you
> should see a separate 'extlinux' menu which allows you to choose the
> correct entry. So you will need 'menu label' instead of label.
>

You are right. I added the missing keywords and now it works as expected.
The menu appears.


>
> As Tom mentions my tree has some additional patches here:
>
> https://sjg.u-boot.org/u-boot/u-boot.git
>
> in case that helps.
>
> As to what you really want (putting each extlinux item in a separate
> bootflow), that's the next step. I will get back to it, but most
> likely not before the end of June. If you would like to try
> implementing it yourself, let me know and I can send some pointers.
>

This is not what I expected to work. But it would also be good/nice to
have. Unfortunately I cannot provide help here.


>
> Regards,
> Simon
>
