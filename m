Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D45CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:00:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 053568717E;
	Thu, 19 Oct 2023 16:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eldohppD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 252F58701D; Thu, 19 Oct 2023 16:00:27 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B415C870B1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507a62d4788so8030951e87.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 07:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697724024; x=1698328824; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HUGd65t4W5SHxiwWlgtEw3FwwJpC/0d3yoXO1lQykL0=;
 b=eldohppDtntVbfiyJ3VAN/O+9xJPHl29XCnBXO6qi80ZNRvGiUcQSR1WcCbkoomnf0
 ymBVN0II8ugVkF8VjWvtfJC1RiI4NOYVz9CTUNYVAH0cdoE18CMO0nsWmDTOi4lytXGM
 13u34LvX9gGawPpPvz1PUZ+LdMjybZEICEqKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697724024; x=1698328824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HUGd65t4W5SHxiwWlgtEw3FwwJpC/0d3yoXO1lQykL0=;
 b=vQKQuBuHZp0K+bV+3ggAKUjOX4Emvr3dQskS07DDVPx4u2sEn1pQgzUl+F7FKH3eMu
 HlstE8lQqAUa0rMDBaZUIuyC1vGAXIbiwUl3RFpu7V9DYP3JuNYkdsQCTZbAnJVGDTaO
 1EjAiwGLNrqLclg2KzxrgwD8yqLfZLmCR4Ha+rPsYmJ8CMUzf5ZgTeFk+Q39z+d28etB
 KDdo6uhQBfSBdunhQInLFJNtBv9FfTMnSyktcxM7IEVBRWyVm+BPwr8LcNolMw0Pi7Wr
 Wtuf16cuMJXdM7PFpTXfJ5XvOTFOb2Z3tqTlSyy/+X/enQga+sUXaxugopzRUp86U/b+
 JjAw==
X-Gm-Message-State: AOJu0YxEyBrvick6dTg59YSMtBhDEK0xZERLNd5JToOAp7BQ8w9dEY7Z
 f7qVMUOKD8ryFk4O15RVsB8v8NRTmIQn7RwwloIl3Q==
X-Google-Smtp-Source: AGHT+IF7h+bO1RbM2qhD86aqxiwzLxC57JzjhwRpgeFrJKtqB+GS3YpIrFyyfikj4ZJDAaB6lVAiDlbmmOLSTTdiESo=
X-Received: by 2002:a19:f609:0:b0:505:6e21:32e1 with SMTP id
 x9-20020a19f609000000b005056e2132e1mr1553225lfe.10.1697724023491; Thu, 19 Oct
 2023 07:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR08MB2847E276099DF7263424F70083CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CALeDE9N6nhRBwtYqJ=7nqYuCsmbw03j3RBXRQ8jYsD=OMY=gBw@mail.gmail.com>
 <VI1PR08MB28474179AFB989B308072B1E83CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CAPnjgZ3t9-trzoLGc7Jcj0=J0sQLQcHSGN3_Pf+3=iZ6=rPPqA@mail.gmail.com>
 <VI1PR08MB2847B5EFD8F36E5A4D41FEBD83D2A@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <a151e6508695fcc2cee740f299e58e0fee6146b3.camel@suse.com>
In-Reply-To: <a151e6508695fcc2cee740f299e58e0fee6146b3.camel@suse.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Oct 2023 08:00:11 -0600
Message-ID: <CAPnjgZ0KVwF-u5G2r-zt8+FmiHK_2ASEsoro3MtVsah58_WqMg@mail.gmail.com>
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

On Thu, 19 Oct 2023 at 02:59, Ivan Ivanov <ivan.ivanov@suse.com> wrote:
>
>
> Hi,
>
> Sorry I can't find mail thread regarding patch itself, so using this one:
>
> On Fri, 2023-10-13 at 10:08 +0000, Guillaume Gardet wrote:
> >
> >
> >
> > Hi,
> >
> > Indeed, your patch [2] fixes my boot problem.
> >
>
> <snip>
>
> >
> >
> > [2] https://patchwork.ozlabs.org/project/uboot/patch/20230923205017.1754340-1-sjg@chromium.org/
> >
> > > >
> > > > [1] https://lists.denx.de/pipermail/u-boot/2023-October/533158.html
> > > >
> > > > > 'git bisect' points to:
> > > > > **********
> > > > > commit c771e5b8c2a186fb072b6c6f571d4a3cc86efba9
> > > > > Author: Simon Glass <sjg@chromium.org>
> > > > > Date:   Thu Jul 27 15:54:28 2023 -0600
> > > > >
> > > > >      arm: rpi: Switch to standard boot
> > > > >
> > > > >      Drop use of the distro scripts and use standard boot instead.
> > > > >
> > > > >      We don't need to specify the mmc devices individually, since they are
> > > > >      used in order from 0 to 2, and standard boot uses that order anyway.
> > > > >
> > > > >      Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > **********
> > > > >
> > > > > The following patch fixes the boot from uSD on RPi4 (not tested on RPi3 nor RPi
> > > > Zero 2 W):
> > > > > **********
> > > > > diff --git a/board/raspberrypi/rpi/rpi.env
> > > > > b/board/raspberrypi/rpi/rpi.env index 30228285ed..02210b97b5 100644
> > > > > --- a/board/raspberrypi/rpi/rpi.env
> > > > > +++ b/board/raspberrypi/rpi/rpi.env
> > > > > @@ -74,4 +74,4 @@ pxefile_addr_r=0x02500000
> > > > >   fdt_addr_r=0x02600000
> > > > >   ramdisk_addr_r=0x02700000
> > > > >
> > > > > -boot_targets=mmc usb pxe dhcp
> > > > > +boot_targets=mmc0 mmc1 mmc2 usb pxe dhcp
> > > > > **********
> > > > >
> > > > > So, the comment from Simon " We don't need to specify the mmc devices
> > > > individually, since they are used in order from 0 to 2, and standard boot uses that
> > > > order anyway" seems wrong for the RPi4 case.
> > > > >
>
> I am afraid we still have a boot issue. This time device can not boot from USB.
> Device boot order was changed to USB first then uSD. uSD card is removed.
>
> Please see [1] attachment #870321 for boot log details.
>
> I have not invested time to debug this, still.

Thanks for the info. Is this using 'boot_targets=mmc usb pxe dhcp'?

We can revert the patch, perhaps, but I'd like to understand why it is failing.

Regards,
Simon
