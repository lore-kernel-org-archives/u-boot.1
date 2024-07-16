Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED016C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21F37889DB;
	Tue, 16 Jul 2024 09:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k68DOfJs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF86889D2; Tue, 16 Jul 2024 09:05:04 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45D83889EF
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6b06e63d288so30432396d6.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113495; x=1721718295; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p1Pzeaun7BVbDsjDBDjk6CrkpBuWAB1cE1Q9Ofk3QnI=;
 b=k68DOfJsCdqKrfdzDUl5suaweVEPdvBN+CuSqbtV/NnO8QfbzF/xPZOT2+RL3+2+oQ
 zduyDdC48PjNady/Sa1nDOG8PUCBh1RIGiEOnINgAqHdXPNbQomoMGUNXX3UnZbcSQ/m
 YcmUz3NQ+9Z0ArL8NBgve7dRj49AQjHsxJ26I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113495; x=1721718295;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p1Pzeaun7BVbDsjDBDjk6CrkpBuWAB1cE1Q9Ofk3QnI=;
 b=PMULPvijTnPRbGzZoEJ0P5daHiCmM+SiooZGTXsQcXgMUJ53YbR+FGDAyr3c1c66un
 53Eviqe3pReedro5fIRfusC1bhxn0+/Uh7aD7RY7wkHbQyPsks1+Ik8Vj9YrvDCHsqRV
 tXaqh9OBH6ekA4n80wXbWFaiYF0Wayi1dFiIfII8N+UDW72I3SkU5VpZT1yd9bCQpo46
 hiocCKEVp72MXy2P6UILiSmSf5w18or+zNi/UVaATC82oHah0MNpLRiEjJzoVo8r8VxX
 AgSVKf2TNAKSrCujcZaQPYgIBTjVWjiwT32Qg5HbyIVbPXUKQlcQqQPYjkDEQmE61XYa
 ajaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlNSdVZCym2lkmJb1pyibe11qmU1+BOd/XHZ+K+rGNo++kqlm0fK0jqyPDHGTqqsMUoHYUf9tLpcQPZop00r+6K/mAuA==
X-Gm-Message-State: AOJu0Yz97fESq8h+fJ9kPWoZgyzlckPG7VOfrpbkaekQRJsDSGLRXELp
 yLNqlAa4fHCqrRNsB4VUxHppyI/zCCMQRMZqcaDcQ1V/fkzgkK7KkGVaxuNcYvUekXAgs5DApvk
 KP9YrlTpYBOT6CKT01eHGG4qNlextcn3qM6ON+1TrYOKQXRM=
X-Google-Smtp-Source: AGHT+IE4GUPX7+MYFXbgiRZgZj4yEJfZOwbijWDIibgtcu/gN23zDscalaHEwTNb1ICvNSoRHDPbmi8IRlDv0c1BH3M=
X-Received: by 2002:a05:6214:4009:b0:6b0:9479:cdd7 with SMTP id
 6a1803df08f44-6b77f602d9fmr13496026d6.54.1721113495211; Tue, 16 Jul 2024
 00:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-7-sjg@chromium.org>
 <50172cea-e2f1-4190-8491-04defa171d6c@gmx.de>
In-Reply-To: <50172cea-e2f1-4190-8491-04defa171d6c@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 16 Jul 2024 08:04:44 +0100
Message-ID: <CAFLszThBP3+h1-H=-PcGezU3cPnHfTkqtRybA0fYX5AhTJ5P8Q@mail.gmail.com>
Subject: Re: [PATCH 06/13] doc: Add a description for bootmeth_cros
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nam Cao <namcao@linutronix.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Tue, 16 Jul 2024 at 00:07, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 7/15/24 12:13, Simon Glass wrote:
> > Add documentation for the cros bootmeth.
>
> %s/bootmeth/boot method/
>
> throughout the patch.
>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   doc/develop/bootstd/cros.rst     | 33 ++++++++++++++++++++++++++++++++
> >   doc/develop/bootstd/index.rst    |  1 +
> >   doc/develop/bootstd/overview.rst |  1 +
> >   3 files changed, 35 insertions(+)
> >   create mode 100644 doc/develop/bootstd/cros.rst
> >
> > diff --git a/doc/develop/bootstd/cros.rst b/doc/develop/bootstd/cros.rst
> > new file mode 100644
> > index 00000000000..96f148837ac
> > --- /dev/null
> > +++ b/doc/develop/bootstd/cros.rst
> > @@ -0,0 +1,33 @@
> > +.. SPDX-License-Identifier: GPL-2.0+:
> > +
> > +ChromiumOS Bootmeth
> > +===================
> > +
> > +ChromiumOS provides a mechanism for booting its Operating System from a block
> > +device, described
> > +`here <https://www.chromium.org/chromium-os/chromiumos-design-docs/verified-boot/>`_.
> > +
> > +U-Boot includes support for reading the associated data structures from the
> > +device and identifying a bootable ChromiumOS image. This structure includes the
> > +kernel itself, boot arguments (kernel command line), as well as the x86 setup
> > +block (for x86 only).
> > +
> > +When invoked on a bootdev, this bootmeth searches for kernel partitions with
>
> What does 'invoked on a boot device' mean? Do you mean "if ChromimumOS
> selects a boot device"?

No, this how bootstd works. It scans through the bootdevs one at a
time and invokes the bootmeths on each.

>
> > +the appropriate GUID (Globally Unique Identifier). When found, the information
> > +is loaded and a bootflow is created.
> > +
> > +When the bootflow is booted, the bootmeth reads the kernel and boot arguments.
> > +It then boots the kernel using zboot (on x86) or bootm (on ARM). The boot
> > +arguments are adjusted to replace %U with the UUID of the selected kernel
> > +partition. This results in the correct root disk being used, which is the next
> > +partition after the kernel partition.
> > +
> > +For ARM, a :doc:`/usage/fit/index` is used. The `CONFIG_FIT_BEST_MATCH` option
> > +must be enabled for U-Boot to select the correct devicetree to boot with.
> > +
> > +Note that a ChromiumOS image typically has two copies of the OS, each with its
>
> %s/OS/operating system/
>
> > +own kernel and root disk. There is no initial ramdisk (initrd). This means that
> > +this bootmeth typically locates two separate images.
> > +
> > +The compatible string "u-boot,cros" is used for the driver. The driver is
> > +automatically instantiated if there are no bootmeth drivers in the devicetree.
>
> The last sentence should be moved to the overview.
>
> Please, mention the relevant configuration option for the boot method
> driver.
>
[..]

Regards,
Simon
