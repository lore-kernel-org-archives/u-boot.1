Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8E7C3DA5D
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A97889F7;
	Tue, 16 Jul 2024 09:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Na+7KzyS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9012A889F5; Tue, 16 Jul 2024 09:04:57 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3EB588865
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b553b1a159so31756616d6.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113493; x=1721718293; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zW4JO59b+1Mbfo1831qkMyvtkN6gqKZU/HS6rm+w2Nw=;
 b=Na+7KzyS6t1gdCUjRcNS/YtG6ieZTr29kSMeVw8VksIKQHw7Alofe8eDHxVVogcVLp
 GLw2tpA8TfR0uYnejHqMt2B9pArSJHXPvWLfkA+uq8hP6Kkg/M+meSxiBkwlK+qX2Cn+
 y8c+dy13JxghPn5nWSnHzNbdYYlPaRdqfBf58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113493; x=1721718293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zW4JO59b+1Mbfo1831qkMyvtkN6gqKZU/HS6rm+w2Nw=;
 b=KWJD6dk8Dz6aQAk/r60/ZO0e/Gthu2N5PCLi37oApZDXGwHZB2Yyq17fZsxPAh335S
 +5JhbGrTVAgI5MaWiYOynfLjxnhc9UpszwHVTcUK9ps5M+wbGZcJnF9/IL+QzsWxOpPz
 HwWQ0iws9FTxJVdk5aeiF4TTXgYcefhDpxn/7f+PhLR64AQdgAYx2R/DSB6fI7MTsDQz
 uUlrVMS9O4ppIhG5sgWLi0i/BteVVA4s4xDvJuRwQiuK8/sk8ok1q4CTfqWuH1Fj5HdB
 wzquXWvzpKtpJDEIT8khXVHmjdt3vOx0dJPKI7j0gmeZJJe9og2LZJQ2SPEHzcLzAIuN
 w4cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBZ7nJD936O8Pw+UxtgmazDMIGByKPcxLLwgdbZLJnpScC1kszf+KOiqJWdnxhw330GOV0nQc1KyPVGPI9oWSJPjr/Rw==
X-Gm-Message-State: AOJu0YzBmOEPL5/RxzN4UD71c5De9UEOCNrpt6fYidn6ZNRiKUZwadiL
 qjWgB6+qiUvYsKL4LHcxcPrlqh5lYV7Nl/8CBfezHGQLnubSrjgoKU7YAivk631hbuQXjNviMlo
 6NqSLFg95N5ij7oO/oU20prYkY7mo1Fs08gad
X-Google-Smtp-Source: AGHT+IGZoTNqCEDcBTaWIztunciCEaZlKW7YunxDekcu4uHbs38QNVL08zqU+cnBwsHkrnHhB+HGZ6wNhbPIYBihHOE=
X-Received: by 2002:a05:6214:5012:b0:6b0:7413:e0e9 with SMTP id
 6a1803df08f44-6b77f36d6aemr20615516d6.5.1721113493680; Tue, 16 Jul 2024
 00:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-5-sjg@chromium.org>
 <846128e4-2833-43e6-8af9-9f57d9025475@gmx.de>
In-Reply-To: <846128e4-2833-43e6-8af9-9f57d9025475@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 16 Jul 2024 08:04:42 +0100
Message-ID: <CAFLszTjkZ03gWA7AMhxSr=z_=eokSFfJBBZES4droDC+rcv6tw@mail.gmail.com>
Subject: Re: [PATCH 04/13] doc: Add a description for bootmeth_pxe
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

On Mon, 15 Jul 2024 at 23:47, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 7/15/24 12:13, Simon Glass wrote:
> > Add documentation for the pxe bootmeth.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   doc/develop/bootstd/index.rst    |  1 +
> >   doc/develop/bootstd/overview.rst |  2 +-
> >   doc/develop/bootstd/pxelinux.rst | 27 +++++++++++++++++++++++++++
> >   3 files changed, 29 insertions(+), 1 deletion(-)
> >   create mode 100644 doc/develop/bootstd/pxelinux.rst
> >
> > diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
> > index 5bbb3d633a3..5052afe448f 100644
> > --- a/doc/develop/bootstd/index.rst
> > +++ b/doc/develop/bootstd/index.rst
> > @@ -8,3 +8,4 @@ Standard Boot
> >
> >      overview
> >      extlinux
> > +   pxelinux
> > diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
> > index 086a0b1281d..fd0692daf0d 100644
> > --- a/doc/develop/bootstd/overview.rst
> > +++ b/doc/develop/bootstd/overview.rst
> > @@ -413,7 +413,7 @@ Available bootmeth drivers
> >   Bootmeth drivers are provided for:
> >
> >      - :doc:`extlinux / syslinux <extlinux>` boot from a disk
> > -   - extlinux boot from a network (PXE)
> > +   - :doc:`extlinux / syslinux <extlinux>` boot from a network (PXE)
> >      - U-Boot scripts from disk, network or SPI flash
> >      - EFI boot using bootefi from disk
> >      - VBE
> > diff --git a/doc/develop/bootstd/pxelinux.rst b/doc/develop/bootstd/pxelinux.rst
> > new file mode 100644
> > index 00000000000..08ba67e09c5
> > --- /dev/null
> > +++ b/doc/develop/bootstd/pxelinux.rst
> > @@ -0,0 +1,27 @@
> > +.. SPDX-License-Identifier: GPL-2.0+:
> > +
> > +PXE Bootmeth
> > +============
> > +
> > +PXE (Preboot eXecution-Environment) provides a way to boot an Operating System
>
> %s/Operating System/operating system/
>
> > +over a network interface. The PXE bootmeth supports PXELINUX and allows U-Boot to
>
> %s/bootmeth/boot method/
>
> > +provide a menu of possible Operating Systems from which the user can choose.
>
> PXELINUX is a binary. Does U-Boot really provide a menu when the
> PXELINUX binary is downloaded and executed?

It downloads a config file which is what includes information about
the menu. I think I was a bit unclear about this when I wrote this
doc.

>
> > +
> > +U-Boot includes a parser for the `extlinux.conf` file described
> > +`here <https://uapi-group.org/specifications/specs/boot_loader_specification>`_.
> > +It consists primarily of a list of named OSes along with the kernel, initial
> > +ramdisk and other settings. The file is retrieved from a network server using
> > +tftpboot.
>
> Does this paragraph relate to PXELINUX?
>
> tftpboot is a command and not a protocol. Shouldn't boot methods work
> when the command line interface is disabled? I guess you want to replace
>
> %s/tftpboot/the TFTP protocol/
>
> > +
> > +When invoked on a bootdev, this bootmeth searches for the file and creates a
>
> %s/bootdev/boot device/
> %s/bootmeth/boot method/
>
> > +bootflow if found. See
>
> %s/bootflow/boot flow/
>
> > +`PXELINUX <https://wiki.syslinux.org/wiki/index.php?title=PXELINUX>`_ for
> > +a full description of the search procedure.
> > +
> > +When the bootflow is booted, the bootmeth calls pxe_setup_ctx() to set up the
> > +context, then pxe_process() to process the file. Depending on the contents, this
> > +may boot an OS or provide a list of options to the user, perhaps with a timeout.
> > +
> > +The compatible string "u-boot,extlinux-pxe" is used for the driver. The driver
> > +is automatically instantiated if there are no bootmeth drivers in the
> > +devicetree.
>
> Device-trees contain compatible strings for drivers, not the drivers
> themselves.
>
> If every configured boot method is enabled if there is no compatible
> string for boot methods in the device-tree, why don't we mention this in
> the overview instead of repeating ourselves?

OK done

>
> Please, mention the relevant configuration option.

Regards,
Simon
