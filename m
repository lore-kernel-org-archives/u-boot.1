Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F74CDB484
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 943D186F80;
	Thu, 19 Oct 2023 16:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XcyscPGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4C3987243; Thu, 19 Oct 2023 16:33:12 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76DF186F80
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53e84912038so8477786a12.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697725988; x=1698330788; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fm/Sl3KNu9U6Sqm4fHO5Dz85uq0sxl5cHxxWPs4cLvM=;
 b=XcyscPGltmVcWWvIwcjl/+m9RbMd6kUT+aMCua3lTETL2Iya2sI34s00nkyvx+5tOo
 XlD02ia4nnJ8UwIt8eGzvykvpl3M8wpEf5yeXEO0YVr0RsaOnZw+lA7YVWBGV/Bx+1cp
 I0gBQQ7nQFpcTB+WiU6wgb/vsUs1ZcaeBtQb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697725988; x=1698330788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fm/Sl3KNu9U6Sqm4fHO5Dz85uq0sxl5cHxxWPs4cLvM=;
 b=AV35k16nT5+Bz40UFfEdE5DrgJ2Pe3KEeb8H8b+NghXMrHYa87JkiFph/qkrwiK6Qb
 iyJ1HSgJNNEmzE6IJ/ztlWTSYDQzFw4feBkCFqpqPpoychLCn1tzpmrm1/H67v+/R864
 Pjxs/Or0yVrc/+s7rbeyJRLqFUbFpFuPFF5Odd4aqAXsJexB3E5UOjL9mk5zP4akhfbt
 rcGMLm2XdROgzPj7aB2TSw14vaKUQEhjZAUQ2hjF525LCMOu43kuB+paJhNzhxyT6QZB
 nKRslxhkwQ7i/EUizANM1uMKaxMc2UllU6EKSLhNmYMLIeDvyYA/nW+MouMmCPJBDpYI
 VLQw==
X-Gm-Message-State: AOJu0YxzgWtqNJRNKld6AJjBtDIXS4myJcoe8ikbBTm9099jqNUCxr/+
 1ScLgZiSHA2xdbtA0g8nO++WWwXAQ7Jcjm8Zz5NLaQ==
X-Google-Smtp-Source: AGHT+IG0C91LaTxwyosJsFGc1XqhS1+3/w2kVFY8l6x0FU5WHJ/b6lPp88qFCgwF+b36ji6Mka7AqzS9cH+3o+eXvqg=
X-Received: by 2002:a50:cd9e:0:b0:53f:9ced:e5b4 with SMTP id
 p30-20020a50cd9e000000b0053f9cede5b4mr1222330edi.13.1697725987851; Thu, 19
 Oct 2023 07:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR08MB2847E276099DF7263424F70083CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CALeDE9N6nhRBwtYqJ=7nqYuCsmbw03j3RBXRQ8jYsD=OMY=gBw@mail.gmail.com>
 <VI1PR08MB28474179AFB989B308072B1E83CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CAPnjgZ3t9-trzoLGc7Jcj0=J0sQLQcHSGN3_Pf+3=iZ6=rPPqA@mail.gmail.com>
 <VI1PR08MB2847B5EFD8F36E5A4D41FEBD83D2A@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <a151e6508695fcc2cee740f299e58e0fee6146b3.camel@suse.com>
 <CAPnjgZ0KVwF-u5G2r-zt8+FmiHK_2ASEsoro3MtVsah58_WqMg@mail.gmail.com>
 <d0cfe8627544d1699031315cc53b961c4cadc126.camel@suse.com>
In-Reply-To: <d0cfe8627544d1699031315cc53b961c4cadc126.camel@suse.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Oct 2023 08:32:56 -0600
Message-ID: <CAPnjgZ3AsKe9V0gE8KBbjaFQv9+3xTrqfV9k=HiDOgmBenqGRQ@mail.gmail.com>
Subject: Re: U-Boot 2023.10 does not boot from uSD on RPi4
To: Ivan Ivanov <ivan.ivanov@suse.com>
Cc: Guillaume Gardet <Guillaume.Gardet@arm.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Ivan,

On Thu, 19 Oct 2023 at 08:29, Ivan Ivanov <ivan.ivanov@suse.com> wrote:
>
> On Thu, 2023-10-19 at 08:00 -0600, Simon Glass wrote:
> > > >
> > > > [2] https://patchwork.ozlabs.org/project/uboot/patch/20230923205017.1754340-1-sjg@chromium.org/
> > > >
> > > > > >
> > > > > > [1] https://lists.denx.de/pipermail/u-boot/2023-October/533158.html
> > > > > >
> > > > > > > 'git bisect' points to:
> > > > > > > **********
> > > > > > > commit c771e5b8c2a186fb072b6c6f571d4a3cc86efba9
> > > > > > > Author: Simon Glass <sjg@chromium.org>
> > > > > > > Date:   Thu Jul 27 15:54:28 2023 -0600
> > > > > > >
> > > > > > >      arm: rpi: Switch to standard boot
> > > > > > >
> > > > > > >      Drop use of the distro scripts and use standard boot instead.
> > > > > > >
> > > > > > >      We don't need to specify the mmc devices individually, since they are
> > > > > > >      used in order from 0 to 2, and standard boot uses that order anyway.
> > > > > > >
> > > > > > >      Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > **********
> > > > > > >
> > > > > > > The following patch fixes the boot from uSD on RPi4 (not tested on RPi3 nor RPi
> > > > > > Zero 2 W):
> > > > > > > **********
> > > > > > > diff --git a/board/raspberrypi/rpi/rpi.env
> > > > > > > b/board/raspberrypi/rpi/rpi.env index 30228285ed..02210b97b5 100644
> > > > > > > --- a/board/raspberrypi/rpi/rpi.env
> > > > > > > +++ b/board/raspberrypi/rpi/rpi.env
> > > > > > > @@ -74,4 +74,4 @@ pxefile_addr_r=0x02500000
> > > > > > >   fdt_addr_r=0x02600000
> > > > > > >   ramdisk_addr_r=0x02700000
> > > > > > >
> > > > > > > -boot_targets=mmc usb pxe dhcp
> > > > > > > +boot_targets=mmc0 mmc1 mmc2 usb pxe dhcp
> > > > > > > **********
> > > > > > >
> > > > > > > So, the comment from Simon " We don't need to specify the mmc devices
> > > > > > individually, since they are used in order from 0 to 2, and standard boot uses that
> > > > > > order anyway" seems wrong for the RPi4 case.
> > > > > > >
> > >
> > > I am afraid we still have a boot issue. This time device can not boot from USB.
> > > Device boot order was changed to USB first then uSD. uSD card is removed.
> > >
> > > Please see [1] attachment #870321 for boot log details.
> > >
> > > I have not invested time to debug this, still.
> >
> > Thanks for the info. Is this using 'boot_targets=mmc usb pxe dhcp'?
> >
>
> Yes. "boot_targets=mmc usb pxe dhcp". Full environment added to the bug.
>
> https://bugzilla.suse.com/show_bug.cgi?id=1216036

OK thank you, I will take a look.

I wonder if there is a way of testing pending patches, or do they need
to be applied before they can be tested in your systems?

Regards,
Simon
