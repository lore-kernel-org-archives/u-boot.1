Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC2BC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C52AA889EC;
	Tue, 16 Jul 2024 09:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hg0Y2Czc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC71288865; Tue, 16 Jul 2024 09:04:53 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2672A889BD
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b624f4180bso26799126d6.3
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113489; x=1721718289; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qTfwW3Cl+/XE8hYPsp+wTILuwWzDvz0GqZzv5N6tQME=;
 b=Hg0Y2CzclfA0CkTjoF2Mc2U8oG+KYsOZdJkNcMPcG0+iiBnE0iihv68Qff9w9nxx8K
 zkKc2aJuceFwequcFil+fqkxxmWzogCulRtP0McLMxK5UIwC/8Mo7uj9mt5PBJTs7ZP9
 Aczo4zcX1XetfTz85vqNMUhfmraA39UxYvGrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113489; x=1721718289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qTfwW3Cl+/XE8hYPsp+wTILuwWzDvz0GqZzv5N6tQME=;
 b=mrHAFNRRohc+KAZTNzqmWV9jTuFNyr8WFmede8AaBR10ue1o/2hQnPr+O0ckTu3z+z
 ZT/EBIq0A8SJa01buIV+YTr86/cgn/O8EW9XYAumwQCsX7endrTTDhqWyNWX/5/i05rf
 LKN+HarzjmZIBKlmtgNXjutN6B5JtV7TX0F3ovpq/tjCi/n6qh0x6dbuRDjFfKfr8VdF
 x3sYkpy/sPzEZYlBktpsm7smOQW+xlyq7zU0Ttyu6nutuVVB7QjNPJPYuuNb51FiIqQs
 6grenvnHZAgj713whwK9LIMhc1jacQu1IkAEZhs9hr2l9s5ahDt1zrEIvQ9Y9g552JUZ
 jeHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgzufm0WFqxrHHbH2lpRtUHLUD0Rpx8w3I/VleqOeiAw1IB4khOMrVo471swaTbouzNEiRKgm2EIiOLcRbumHprAq8sQ==
X-Gm-Message-State: AOJu0Yz3io5nhJH1f0vs87PZZz52rH4UyxxPnR68DXrCdmwSLDT6svAg
 pw258rX7oFQzhpp1aNIkBqrzg+s0qjseYadPG2sJGyHxDGf0Bssub2xywLRUf+elQtRi5LmCc7g
 ONgnHZ4mCRC/dYhPmfWAIeYwXeYuHTY+H5RE3
X-Google-Smtp-Source: AGHT+IGNSGbwoGNvrI5JcTLXeyugkAblY9vmSAyjbazv6lQqYFewsX1hYDymcmWtIo7VHomkNVMaE6FYEgRIQnTyxRU=
X-Received: by 2002:ad4:5aef:0:b0:6b5:df48:bc7b with SMTP id
 6a1803df08f44-6b77f5f5370mr17966856d6.55.1721113488842; Tue, 16 Jul 2024
 00:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-3-sjg@chromium.org>
 <22edf937-af4d-4cf5-a251-095c1615cb4a@gmx.de>
In-Reply-To: <22edf937-af4d-4cf5-a251-095c1615cb4a@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 16 Jul 2024 08:04:38 +0100
Message-ID: <CAFLszTim9eiN5rObbZbGYa6ZgCV0G=7s6v1Bji3QO=o1fOiiaQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] doc: Move bootstd into its own directory
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Dahl <ada@thorsis.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, E Shattow <lucent@gmail.com>, 
 Jaewon Jung <jaewon8868@gmail.com>, Janne Grunau <j@jannau.net>, 
 Joao Marcos Costa <jmcosta944@gmail.com>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Mon, 15 Jul 2024 at 22:58, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 7/15/24 12:13, Simon Glass wrote:
> > Before adding more files, move the bootstd docs into a new directory,
> > with an index.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   MAINTAINERS                                       |  2 +-
> >   doc/board/starfive/milk-v_mars_cm.rst             |  2 +-
> >   doc/develop/board_best_practices.rst              |  2 +-
> >   doc/develop/bootstd/index.rst                     |  9 +++++++++
> >   doc/develop/{bootstd.rst => bootstd/overview.rst} | 14 +++++++-------
> >   doc/develop/index.rst                             |  2 +-
> >   doc/usage/cmd/bootdev.rst                         |  2 +-
> >   doc/usage/cmd/bootflow.rst                        |  2 +-
> >   doc/usage/cmd/bootmeth.rst                        |  2 +-
> >   doc/usage/environment.rst                         |  2 +-
> >   10 files changed, 24 insertions(+), 15 deletions(-)
> >   create mode 100644 doc/develop/bootstd/index.rst
> >   rename doc/develop/{bootstd.rst => bootstd/overview.rst} (99%)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9bee9284cca..86b830aa997 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -927,7 +927,7 @@ F:        boot/bootmeth*.c
> >   F:  boot/bootstd.c
> >   F:  cmd/bootdev.c
> >   F:  cmd/bootflow.c
> > -F:   doc/develop/bootstd.rst
> > +F:   doc/develop/bootstd/
> >   F:  doc/usage/bootdev.rst
> >   F:  doc/usage/bootflow.rst
> >   F:  doc/usage/bootmeth.rst
> > diff --git a/doc/board/starfive/milk-v_mars_cm.rst b/doc/board/starfive/milk-v_mars_cm.rst
> > index b31de6043bb..52d4e5e9098 100644
> > --- a/doc/board/starfive/milk-v_mars_cm.rst
> > +++ b/doc/board/starfive/milk-v_mars_cm.rst
> > @@ -89,7 +89,7 @@ provide a default value.
> >
> >   The variable *$fdtfile* is used in the boot process to automatically load
> >   a device-tree provided by the operating system. For details of the boot
> > -process refer to the :doc:`U-Boot Standard Boot <../../../develop/bootstd>`
> > +process refer to the :doc:`/develop/bootstd/index`
> >   description.
> >
> >   Boot source selection
> > diff --git a/doc/develop/board_best_practices.rst b/doc/develop/board_best_practices.rst
> > index f44401eab7d..09632c80ce7 100644
> > --- a/doc/develop/board_best_practices.rst
> > +++ b/doc/develop/board_best_practices.rst
> > @@ -7,7 +7,7 @@ In addition to the regular best practices such as using :doc:`checkpatch` and
> >   following the :doc:`docstyle` and the :doc:`codingstyle` there are some things
> >   which are specific to creating a new board port.
> >
> > -* Implement :doc:`bootstd` to ensure that most operating systems will be
> > +* Implement :doc:`bootstd/index` to ensure that most operating systems will be
> >     supported by the platform.
> >
> >   * The platform defconfig file must be generated via `make savedefconfig`.
> > diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
> > new file mode 100644
> > index 00000000000..f4f87c7787c
> > --- /dev/null
> > +++ b/doc/develop/bootstd/index.rst
> > @@ -0,0 +1,9 @@
> > +.. SPDX-License-Identifier: GPL-2.0+:
> > +
> > +Standard Boot
> > +=============
> > +
> > +.. toctree::
> > +   :maxdepth: 2
> > +
> > +   overview
> > diff --git a/doc/develop/bootstd.rst b/doc/develop/bootstd/overview.rst
> > similarity index 99%
> > rename from doc/develop/bootstd.rst
> > rename to doc/develop/bootstd/overview.rst
> > index 34631089ae0..761f61a573b 100644
> > --- a/doc/develop/bootstd.rst
> > +++ b/doc/develop/bootstd/overview.rst
> > @@ -1,7 +1,7 @@
> >   .. SPDX-License-Identifier: GPL-2.0+:
> >
> > -U-Boot Standard Boot
> > -====================
> > +Standard Boot Overview
> > +======================
> >
>
>
>
> The text is not optimized for readability, e.g.
>
> "- bootdev  - a device which can hold or access a distro (e.g. MMC,
> Ethernet)"
>
> Please, consistently replace the non-words in the boot standard
> documentation:
>
> %s/bootdev/boot device/
> %s/bootmeth/boot method/
> %s/bootflow/boot flow/

I do want to keep the terms, It is easy to search for bootdev or
bootmeth in the code and docs. Once people learn what they mean it is
pretty simple.

>
> "distro" isn't a dictionary word either. Do you mean operating system?

I mean a linux distro, in the sense that 'distro boot' uses it.

> That term would still not catch what a boot device is:
>
> The boot device is the device that holds the next boot stage.
>
> This could for instance be GRUB which in turn will offer a menu allowing
> to select one of multiple operating systems.
>
> Or that next boot stage could be an operating system kernel together
> with its initial ram disk and a device-tree.

This is covered to some extent at [1].  But what you are talking about
here is not covered - e.g. using GRUB. You could perhaps sent a patch
to [1] ?

>
> Best regards
>
> Heinrich
>
>
>
> >   Introduction
> >   ------------
> > @@ -17,7 +17,7 @@ introduces the following concepts:
> >   For Linux, the distro (Linux distribution, e.g. Debian, Fedora) is responsible
> >   for creating a bootflow for each kernel combination that it wants to offer.
> >   These bootflows are stored on media so they can be discovered by U-Boot. This
> > -feature is typically called `distro boot` (see :doc:`distro`) because it is
> > +feature is typically called `distro boot` (see :doc:`../distro`) because it is
> >   a way for distributions to boot on any hardware.
> >
> >   Traditionally U-Boot has relied on scripts to implement this feature. See
> > @@ -32,7 +32,7 @@ way to boot with U-Boot. The feature is extensible to different Operating
> >   Systems (such as Chromium OS) and devices (beyond just block and network
> >   devices). It supports EFI boot and EFI bootmgr too.
> >
> > -Finally, standard boot supports the operation of :doc:`vbe`.
> > +Finally, standard boot supports the operation of :doc:`../vbe`.
> >
> >   Bootflow
> >   --------
> > @@ -427,16 +427,16 @@ Three commands are available:
> >
> >   `bootdev`
> >       Allows listing of available bootdevs, selecting a particular one and
> > -    getting information about it. See :doc:`../usage/cmd/bootdev`
> > +    getting information about it. See :doc:`/usage/cmd/bootdev`
> >
> >   `bootflow`
> >       Allows scanning one or more bootdevs for bootflows, listing available
> >       bootflows, selecting one, obtaining information about it and booting it.
> > -    See :doc:`../usage/cmd/bootflow`
> > +    See :doc:`/usage/cmd/bootflow`
> >
> >   `bootmeth`
> >       Allow listing of available bootmethds and setting the order in which they
> > -    are tried. See :doc:`../usage/cmd/bootmeth`
> > +    are tried. See :doc:`/usage/cmd/bootmeth`
> >
> >   .. _BootflowStates:
> >
> > diff --git a/doc/develop/index.rst b/doc/develop/index.rst
> > index f9c4bf839ee..c0107a783fc 100644
> > --- a/doc/develop/index.rst
> > +++ b/doc/develop/index.rst
> > @@ -29,7 +29,7 @@ Implementation
> >
> >      directories
> >      bloblist
> > -   bootstd
> > +   bootstd/index
> >      ci_testing
> >      commands
> >      config_binding
> > diff --git a/doc/usage/cmd/bootdev.rst b/doc/usage/cmd/bootdev.rst
> > index f759abab354..98a0f43c580 100644
> > --- a/doc/usage/cmd/bootdev.rst
> > +++ b/doc/usage/cmd/bootdev.rst
> > @@ -22,7 +22,7 @@ Description
> >   The `bootdev` command is used to manage bootdevs. It can list available
> >   bootdevs, select one and obtain information about it.
> >
> > -See :doc:`../../develop/bootstd` for more information about bootdevs in general.
> > +See :doc:`/develop/bootstd/index` for more information about bootdevs in general.
> >
> >
> >   bootdev list
> > diff --git a/doc/usage/cmd/bootflow.rst b/doc/usage/cmd/bootflow.rst
> > index 6519e4880a9..5d41fe37a7a 100644
> > --- a/doc/usage/cmd/bootflow.rst
> > +++ b/doc/usage/cmd/bootflow.rst
> > @@ -26,7 +26,7 @@ Description
> >   The `bootflow` command is used to manage bootflows. It can scan bootdevs to
> >   locate bootflows, list them and boot them.
> >
> > -See :doc:`../../develop/bootstd` for more information.
> > +See :doc:`/develop/bootstd/index` for more information.
> >
> >   Note that `CONFIG_BOOTSTD_FULL` (which enables `CONFIG_CMD_BOOTFLOW_FULL) must
> >   be enabled to obtain full functionality with this command. Otherwise, it only
> > diff --git a/doc/usage/cmd/bootmeth.rst b/doc/usage/cmd/bootmeth.rst
> > index bac9fdf85cd..c3d2ec1574b 100644
> > --- a/doc/usage/cmd/bootmeth.rst
> > +++ b/doc/usage/cmd/bootmeth.rst
> > @@ -21,7 +21,7 @@ Description
> >   The `bootmeth` command is used to manage bootmeths. It can list them and change
> >   the order in which they are used.
> >
> > -See :doc:`../../develop/bootstd` for more information.
> > +See :doc:`/develop/bootstd/index` for more information.
> >
> >
> >   .. _bootmeth_order:
> > diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
> > index 7d4b448cb30..cc33d3ec0f2 100644
> > --- a/doc/usage/environment.rst
> > +++ b/doc/usage/environment.rst
> > @@ -100,7 +100,7 @@ to add environment variables.
> >
> >   Board maintainers are encouraged to migrate to the text-based environment as it
> >   is easier to maintain. The distro-board script still requires the old-style
> > -environments, so use :doc:`../develop/bootstd` instead.
> > +environments, so use :doc:`/develop/bootstd/index` instead.
> >
> >
> >   List of environment variables
>

[1] https://docs.u-boot.org/en/latest/develop/bootstd.html#bootdev
