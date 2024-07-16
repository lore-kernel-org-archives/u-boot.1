Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C02C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 691BA889FD;
	Tue, 16 Jul 2024 09:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YvAoZZjf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC5D388865; Tue, 16 Jul 2024 09:04:57 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E60F889CD
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-44acdd30c3fso28186331cf.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113494; x=1721718294; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gSWuA5R9u6+UDu+JkngiS3EmtQxeWGdtodNH+ZEkmEs=;
 b=YvAoZZjfCVvdr3thHoD4KSUsuMSmG7kNY95UYbnCA62ZB1PHRSJYBV5/uU14W3ZbRz
 Z86zT2kOa6vAHyYO5chr8hWzcKZR+IcB34CaX+i4TmYR3xSyOdx2WnT2AA/7W/cyXMgl
 o1ZrjNdFTs2AzVQAvoEkHk4TxeVDqOkIK/OfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113494; x=1721718294;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gSWuA5R9u6+UDu+JkngiS3EmtQxeWGdtodNH+ZEkmEs=;
 b=D2QgEPbRbE8MEjmK5AY5m/SZtiZ6cdHBYC4U+CY5hQaSObNwhSVkSJuoHbi0rf8QkP
 E7vr53SKj08t2GseMa+lXcmKfazEOyJSZVkTzv+nW6n/sGu92LapnT2aoOJ5n6VpPPcH
 HOO4+FKmhNLWY917c02UxTNSfthVfXxq/6TXhoV/oZ2tctl1mSDrWZnFOI5Zs5Tash1U
 Zebgss1mSxemSdAOaXGyaamngzaKyeebNtB6bEY5Ood6vbvnxee10B9+jPgUgz7yxy4A
 VP1BfoIkh6d8gr/m/Ug/qiOjE9O6PS0eMVPrz01dNRkJOS8DA7PFegV/ZOO0xpoINcBk
 HDlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5/Rmq9adN03d6U7eJPIqQTGgduX+1CsNCGZ5ADediISKYrbka/Ndqf/sEWWafW2VWjy0RNBxfpm7cSHNUfnYL1yBTZg==
X-Gm-Message-State: AOJu0YysliYs+sv0tdwaQItjJvoY/JOFblXvaAUeLG2x2/7zlugr8kDo
 IADaomYsvsNI7jKUBIhLVWhe1wUlhhPNf8hzK+tYFnirvH+BBrZbaiMbDbUIeEg2NgktsbyaBTy
 xm+VwCOlXqee9pts/q/80OHR041pbpQpfF0Hy
X-Google-Smtp-Source: AGHT+IEGsm0U0XTCCkC8vbS888bUIHmt36RR25WktR9AD2FuGCaMwuIl6hTb22CvOeFEYR5ew42fG5xgWUbvhdQa+ek=
X-Received: by 2002:a05:6214:29e5:b0:6b5:8046:69f3 with SMTP id
 6a1803df08f44-6b77f514567mr18700926d6.26.1721113493934; Tue, 16 Jul 2024
 00:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-6-sjg@chromium.org>
 <a3aad2bc-863a-493d-9446-a65f28fcc09a@gmx.de>
In-Reply-To: <a3aad2bc-863a-493d-9446-a65f28fcc09a@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 16 Jul 2024 08:04:43 +0100
Message-ID: <CAFLszTgzs161zcaik6C1_LEgjxSunY=Ogh8kFqzE3D=2=ZzXKA@mail.gmail.com>
Subject: Re: [PATCH 05/13] doc: Add a description for bootmeth_qfw
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nam Cao <namcao@linutronix.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Mon, 15 Jul 2024 at 23:56, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 7/15/24 12:13, Simon Glass wrote:
> > Add documentation for the qfw bootmeth.
> >
>
> %s/bootmeth/boot method/
>
>
> > Fix up the compatible string to drop the 'extlinux' part, which is not
> > relevant to this bootmeth.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   boot/bootmeth_qfw.c              |  2 +-
> >   doc/develop/bootstd/index.rst    |  1 +
> >   doc/develop/bootstd/overview.rst |  1 +
> >   doc/develop/bootstd/qfw.rst      | 21 +++++++++++++++++++++
> >   4 files changed, 24 insertions(+), 1 deletion(-)
> >   create mode 100644 doc/develop/bootstd/qfw.rst
> >
> > diff --git a/boot/bootmeth_qfw.c b/boot/bootmeth_qfw.c
> > index dfaa944594e..2f8e00cf350 100644
> > --- a/boot/bootmeth_qfw.c
> > +++ b/boot/bootmeth_qfw.c
> > @@ -88,7 +88,7 @@ static struct bootmeth_ops qfw_bootmeth_ops = {
> >   };
> >
> >   static const struct udevice_id qfw_bootmeth_ids[] = {
> > -     { .compatible = "u-boot,qfw-extlinux" },
> > +     { .compatible = "u-boot,qfw-bootmeth" },
> >       { }
> >   };
> >
> > diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
> > index 5052afe448f..f8fce7207ce 100644
> > --- a/doc/develop/bootstd/index.rst
> > +++ b/doc/develop/bootstd/index.rst
> > @@ -9,3 +9,4 @@ Standard Boot
> >      overview
> >      extlinux
> >      pxelinux
> > +   qfw
> > diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
> > index fd0692daf0d..bcc2c00c775 100644
> > --- a/doc/develop/bootstd/overview.rst
> > +++ b/doc/develop/bootstd/overview.rst
> > @@ -418,6 +418,7 @@ Bootmeth drivers are provided for:
> >      - EFI boot using bootefi from disk
> >      - VBE
> >      - EFI boot using boot manager
> > +   - :doc:`QFW <qfw>`: QEMU firmware interface
> >
> >
> >   Command interface
> > diff --git a/doc/develop/bootstd/qfw.rst b/doc/develop/bootstd/qfw.rst
> > new file mode 100644
> > index 00000000000..b0d47fd246a
> > --- /dev/null
> > +++ b/doc/develop/bootstd/qfw.rst
> > @@ -0,0 +1,21 @@
> > +.. SPDX-License-Identifier: GPL-2.0+:
> > +
> > +QFW Bootmeth
> > +============
> > +
> > +`QEMU <hhttps://www.qemu.org/>`_ is a system emulator which is able to boot
> > +Operating Systems. QEMU provides specific support for booting an OS image
> > +provided on the QEMU command line.
> > +
> > +When invoked on a bootdev for UCLASS_QFW, this bootmeth reads the kernel
> > +provided by the QEMU `-kernel` argument, the iniital ramdisk and provided by
>
> %s/iniital/initial/
>
> > +`-initrd` and the boot arguments (command line) provided by `-append` into
> > +memory ready for booting.
> > +
> > +When the bootflow is booted, the bootmeth tries the `booti` command first, then
>
> Boot methods should work if the command line is deactivated. We should
> not use run_command() but extract the functionality into library code.
>
> Why would you first try to run booti and then bootz irrespective of the
> availability of the commands? Function qfw_boot() needs rework.

Yes, this is just the existing code ported into a bootmeth. I have not
tried to rework it, but it would be a good idea now that I have done
all the work of separating out booting from cmdline.

>
> There should be a configuration symbol to disable the boot method when
> CONFIG_QFW is enabled.
>
> The bootmethod should no be built if booti and bootz are not available
>
> > +falls back to the `bootz` command. U-Boot's 'control' devicetree is passed
> > +through to the kernel.
> > +
> > +The compatible string "u-boot,qfw-bootmeth" is used for the driver. The driver
> > +is automatically instantiated if there are no bootmeth drivers in the
> > +devicetree.
>
> This paragraph should be moved to the overview.
>
> Please, mention the configuration requirements.
Regards,
Simon
