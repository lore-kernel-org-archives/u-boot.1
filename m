Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED96AC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DD45889D4;
	Tue, 16 Jul 2024 09:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UwbeGuZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 797FF889E8; Tue, 16 Jul 2024 09:04:55 +0200 (CEST)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01E9B889DA
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4f2ec49e067so1933242e0c.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113492; x=1721718292; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nv5V+rXAwg51BuUFscQp9NP6t2ww6HQ3ejThH1ky3IA=;
 b=UwbeGuZnHQq8hqDYAxEUW+SfCZjN3OUZwUdO7qt7JlHexpuSCNvZ5KBrxFYUALFPvY
 OfSehdVysCFA/atdKHjhYviKHtwZv0VNI/kjTbAgbuXDOMuRKUEMYZ1qutywa9nhe0VN
 7VbcBxTLrn9i0u0vRdmeIdH9dLJ5FMOKt4KFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113492; x=1721718292;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nv5V+rXAwg51BuUFscQp9NP6t2ww6HQ3ejThH1ky3IA=;
 b=LzzY+2eQTDjF7Igq0nEaL11WGDdXosscVhjmhmGijM4f/evI+kXCrsMYvTcB3hg4+N
 o/8gmVKJDgUQbB7aNieFRXJO4ZLsj3ka5qX/jHLCd+KVRkQNwrUg8E8r4Uwu8Rk+HaWV
 kY2sER/nnqZAqgZIzCyYcFRTQGwxdVZJxosHWgaHs+cJ2K/Bn5THRUGnrXMA6oLAdlKj
 oYwnNljjK8BcPlURKCIMt0Ia7NQsRX5mtycGcm/Geou6wJ3jpKvY2KQtzScLCaUtFzqR
 tJkTxUVGIa9bj5g0JR43uTscqrkCr4Cc1Ts20SUjzyqMwdP8j9709IEJAKXHRia/WRRD
 SYSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWwckhcYSaAkSHk6tJLfq4Wqq97jiG5MouvLionIY0iXaAjFzarw+nXgWjxfubTbEy/NdzZ8JLGT8aHL6i65fS8OMLNw==
X-Gm-Message-State: AOJu0YwFUaraSkf+JYZDuzIXD22xKaXAp3i4w7lmuB7H/Hybc2gPmXMF
 4QOjHwg4jVMNEY9FH04/uc5gvRHLF5uYeeVYb5Zi9dZCWJP1Gx6wEPVah78qtYZWrHQP7+wCxvf
 VOApWqmzf/ajiqRnL9QRFtkv19+peEqWlePSw
X-Google-Smtp-Source: AGHT+IGEoeiSKJebJ/c7BHPzryhHxLY4+qFNMlB+4mZT+NBNSRq/ivsmrKCN8jMTwTsvuJGwvyn3GohHwkckLSa6ih8=
X-Received: by 2002:a05:6122:2527:b0:4f2:e1c9:fc1b with SMTP id
 71dfb90a1353d-4f4d0782518mr1480022e0c.4.1721113491622; Tue, 16 Jul 2024
 00:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-4-sjg@chromium.org>
 <b89a7250-3453-4580-8ee6-eddfe83ad10a@gmx.de>
In-Reply-To: <b89a7250-3453-4580-8ee6-eddfe83ad10a@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 16 Jul 2024 08:04:40 +0100
Message-ID: <CAFLszThZ_QK3r=CKCuys7hRX823-UqffK+apK=iAFWr05D1qdQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] doc: Add a description for bootmeth_extlinux
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

On Mon, 15 Jul 2024 at 23:30, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 7/15/24 12:13, Simon Glass wrote:
> > Add documentation for the extlinux bootmeth.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   doc/develop/bootstd/extlinux.rst | 27 +++++++++++++++++++++++++++
> >   doc/develop/bootstd/index.rst    |  1 +
> >   doc/develop/bootstd/overview.rst |  2 +-
> >   3 files changed, 29 insertions(+), 1 deletion(-)
> >   create mode 100644 doc/develop/bootstd/extlinux.rst
> >
> > diff --git a/doc/develop/bootstd/extlinux.rst b/doc/develop/bootstd/extlinux.rst
> > new file mode 100644
> > index 00000000000..28490f38899
> > --- /dev/null
> > +++ b/doc/develop/bootstd/extlinux.rst
> > @@ -0,0 +1,27 @@
> > +.. SPDX-License-Identifier: GPL-2.0+:
> > +
> > +Extlinux Bootmeth
> > +=================
> > +
> > +`Extlinux <https://uapi-group.org/specifications/specs/boot_loader_specification>`_
> > +(sometimes called syslinux) allows U-Boot to provide a menu of possible
>
> %s/possible/available/
>
> > +Operating Systems from which the user can choose.
>
> %s/Operating Systems/operating systems/
>
> > +
> > +U-Boot includes a parser for the `extlinux.conf` file. It consists primarily of
> > +a list of named OSes along with the kernel, initial ramdisk and other settings.
>
> Please, avoid abbreviations.
>
> %s/OSes/operating systems/
>
> > +The file is stored in the `extlinux/` subdirectory, possibly under the `boot/`
> > +subdirectory. This list of prefixes ({"/", "/boot"} by default) can be selected
> > +with the `filename-prefixes` property in the bootstd device.
>
> %s/bootstd/boot standard/
>
> > +
> > +Note that PXE (Preboot eXecution-Environment) uses the same file format, but in
> > +a network context.
> > +
> > +When invoked on a bootdev, this bootmeth searches for the file and creates a
>
> Please, replace throughout the text:
>
> %s/bootdev/boot device/
> %s/bootmeth/boot method/
>
>
> > +bootflow if found.
>
> %s/bootflow/bootflow/
>
> > +
> > +When the bootflow is booted, the bootmeth calls pxe_setup_ctx() to set up the
> > +context, then pxe_process() to process the file. Depending on the contents, this
> > +may boot an OS or provide a list of options to the user, perhaps with a timeout.
>
> %/OS/operating system/
>
> > +
> > +The compatible string "u-boot,extlinux" is used for the driver. The driver is
> > +automatically instantiated if there are no bootmeth drivers in the devicetree.
>
> Device-tree never contain boot method drivers. Do you mean:
>
> If no boot method driver is selected by a compatible string in the
> device-tree and CONFIG_BOOTMETH_EXTLINUX=y, the extlinux boot method
> driver is enabled by default.

Not quite. The devicetree can specify the bootmeth devices, iwc the
automatic binding is not enabled. I'll add a note to the main docs and
drop this.

>
> Please, mention that the driver is only available if
> CONFIG_BOOTMETH_EXTLINUX=y.
>
> > diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
> > index f4f87c7787c..5bbb3d633a3 100644
> > --- a/doc/develop/bootstd/index.rst
> > +++ b/doc/develop/bootstd/index.rst
> > @@ -7,3 +7,4 @@ Standard Boot
> >      :maxdepth: 2
> >
> >      overview
> > +   extlinux
> > diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
> > index 761f61a573b..086a0b1281d 100644
> > --- a/doc/develop/bootstd/overview.rst
> > +++ b/doc/develop/bootstd/overview.rst
> > @@ -412,7 +412,7 @@ Available bootmeth drivers
> >
> >   Bootmeth drivers are provided for:
>
> %s/Bootmeth/Boot method/
>
> >
> > -   - extlinux / syslinux boot from a disk
>  > +   - :doc:`extlinux / syslinux <extlinux>` boot from a disk
>
> After "provided for:" I would expect "booting from a storage device".
>
> You can't use the infinitive here. The days of disks are counted.
>
> Best regards
>
> Heinrich
>
> >      - extlinux boot from a network (PXE)
> >      - U-Boot scripts from disk, network or SPI flash
> >      - EFI boot using bootefi from disk
>

Regards,
Simon
