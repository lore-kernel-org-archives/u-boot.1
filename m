Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33104C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 15:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D7B288BD6;
	Fri, 19 Jul 2024 17:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IMZynVUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CBFB88BD6; Fri, 19 Jul 2024 17:05:35 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5888888C08
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 17:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b7aed340daso4646296d6.3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 08:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721401531; x=1722006331; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J6PvrXbdQ1YrW7o20PWn/grGH0Gl0my0eQJzv/aUQ5U=;
 b=IMZynVUHystx/2bN9zehxC5zOOC6r7nKsJoUU2tmJQ2eIyqeBwpXWTBzw3MH3c4SyL
 ChkmxsPfT89TxZcO/3Tmn3HGXJatWlo7iJaQ0RGCjpGYLxDk+05H+m7sJGEYwlIGtZzA
 w88L7O5WdojVLBjvXCJSm6/pa/Oc0Ogn4nWZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721401531; x=1722006331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J6PvrXbdQ1YrW7o20PWn/grGH0Gl0my0eQJzv/aUQ5U=;
 b=AwI0Iq9A3X9WPiYjlnQLLbMDztIaeWsl/8z8J9CULwHdjn8QBdTP0e3eoEwjkYWkcf
 poN95I77dpYRomE8ZY2J347b/vxGzfACto6E9tSraMPYc29FA11vAlYugMTZbYtzVsjp
 XDkdsaImea8nnvfIIfmhSwygCRHEcbPxfUzxR2TDX16fffvudD+fMHOkQgXP8dOWsLcZ
 IfwxFIkfZdOx3HGNy1EZVaVlyvTaRzlx+5Xru7TGMYeINgxaBnMtIeCgWuXHGZ9ar/Ld
 EnOhMuKElLUky/5GMGiY6nn0WmJsIvm8MFmr5WwknK4PjIPRP2sgmGT5d8VBfsdkhQw7
 JDZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+ad1iwsSEgn8W3PKqZlF7vkT4Q0Mz6YsHpnb8PWSNChmZvl/W8yp0tSI5Q3eDRcakDChc3FJs8Gz/rrBA+ODBiw5kcw==
X-Gm-Message-State: AOJu0YxZQWwkJk4/j5AntRB/M0zhgR9SoD6dcXsr2duOYN9bbyuzUCRS
 0FcxA5MXPoYOPio56qk+heVZbDuYGFLlWqzJ7gdpeCIEb1b7EMuTWoUhEnpZHPVDv6lyX5DyYou
 P/tVE16k80leIanbvjjVGbzMLyC+exBw9XldZ
X-Google-Smtp-Source: AGHT+IFlfbtZL1skIbjGOGlDtBOUjDIhsqA6JX0Hpb8OaG3xyPzyCU2vStD23PY7OlxKZLr7aj5OhQHK8r7U+8a9yTs=
X-Received: by 2002:a05:6214:5198:b0:6b7:6544:c004 with SMTP id
 6a1803df08f44-6b78caf60dfmr120972666d6.1.1721401531195; Fri, 19 Jul 2024
 08:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-3-sjg@chromium.org>
 <22edf937-af4d-4cf5-a251-095c1615cb4a@gmx.de>
 <CAFLszTim9eiN5rObbZbGYa6ZgCV0G=7s6v1Bji3QO=o1fOiiaQ@mail.gmail.com>
 <20240716161801.GE561963@bill-the-cat>
In-Reply-To: <20240716161801.GE561963@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Jul 2024 16:05:20 +0100
Message-ID: <CAFLszTjLKFmo0ANYg6Zx0LO-WnHPSFC4yR=1QLd-9uLX01W7dQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] doc: Move bootstd into its own directory
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

Hi Tom,

On Tue, 16 Jul 2024 at 17:18, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jul 16, 2024 at 08:04:38AM +0100, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Mon, 15 Jul 2024 at 22:58, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 7/15/24 12:13, Simon Glass wrote:
> > > > Before adding more files, move the bootstd docs into a new directory,
> > > > with an index.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >   MAINTAINERS                                       |  2 +-
> > > >   doc/board/starfive/milk-v_mars_cm.rst             |  2 +-
> > > >   doc/develop/board_best_practices.rst              |  2 +-
> > > >   doc/develop/bootstd/index.rst                     |  9 +++++++++
> > > >   doc/develop/{bootstd.rst => bootstd/overview.rst} | 14 +++++++-------
> > > >   doc/develop/index.rst                             |  2 +-
> > > >   doc/usage/cmd/bootdev.rst                         |  2 +-
> > > >   doc/usage/cmd/bootflow.rst                        |  2 +-
> > > >   doc/usage/cmd/bootmeth.rst                        |  2 +-
> > > >   doc/usage/environment.rst                         |  2 +-
> > > >   10 files changed, 24 insertions(+), 15 deletions(-)
> > > >   create mode 100644 doc/develop/bootstd/index.rst
> > > >   rename doc/develop/{bootstd.rst => bootstd/overview.rst} (99%)
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 9bee9284cca..86b830aa997 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -927,7 +927,7 @@ F:        boot/bootmeth*.c
> > > >   F:  boot/bootstd.c
> > > >   F:  cmd/bootdev.c
> > > >   F:  cmd/bootflow.c
> > > > -F:   doc/develop/bootstd.rst
> > > > +F:   doc/develop/bootstd/
> > > >   F:  doc/usage/bootdev.rst
> > > >   F:  doc/usage/bootflow.rst
> > > >   F:  doc/usage/bootmeth.rst
> > > > diff --git a/doc/board/starfive/milk-v_mars_cm.rst b/doc/board/starfive/milk-v_mars_cm.rst
> > > > index b31de6043bb..52d4e5e9098 100644
> > > > --- a/doc/board/starfive/milk-v_mars_cm.rst
> > > > +++ b/doc/board/starfive/milk-v_mars_cm.rst
> > > > @@ -89,7 +89,7 @@ provide a default value.
> > > >
> > > >   The variable *$fdtfile* is used in the boot process to automatically load
> > > >   a device-tree provided by the operating system. For details of the boot
> > > > -process refer to the :doc:`U-Boot Standard Boot <../../../develop/bootstd>`
> > > > +process refer to the :doc:`/develop/bootstd/index`
> > > >   description.
> > > >
> > > >   Boot source selection
> > > > diff --git a/doc/develop/board_best_practices.rst b/doc/develop/board_best_practices.rst
> > > > index f44401eab7d..09632c80ce7 100644
> > > > --- a/doc/develop/board_best_practices.rst
> > > > +++ b/doc/develop/board_best_practices.rst
> > > > @@ -7,7 +7,7 @@ In addition to the regular best practices such as using :doc:`checkpatch` and
> > > >   following the :doc:`docstyle` and the :doc:`codingstyle` there are some things
> > > >   which are specific to creating a new board port.
> > > >
> > > > -* Implement :doc:`bootstd` to ensure that most operating systems will be
> > > > +* Implement :doc:`bootstd/index` to ensure that most operating systems will be
> > > >     supported by the platform.
> > > >
> > > >   * The platform defconfig file must be generated via `make savedefconfig`.
> > > > diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
> > > > new file mode 100644
> > > > index 00000000000..f4f87c7787c
> > > > --- /dev/null
> > > > +++ b/doc/develop/bootstd/index.rst
> > > > @@ -0,0 +1,9 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0+:
> > > > +
> > > > +Standard Boot
> > > > +=============
> > > > +
> > > > +.. toctree::
> > > > +   :maxdepth: 2
> > > > +
> > > > +   overview
> > > > diff --git a/doc/develop/bootstd.rst b/doc/develop/bootstd/overview.rst
> > > > similarity index 99%
> > > > rename from doc/develop/bootstd.rst
> > > > rename to doc/develop/bootstd/overview.rst
> > > > index 34631089ae0..761f61a573b 100644
> > > > --- a/doc/develop/bootstd.rst
> > > > +++ b/doc/develop/bootstd/overview.rst
> > > > @@ -1,7 +1,7 @@
> > > >   .. SPDX-License-Identifier: GPL-2.0+:
> > > >
> > > > -U-Boot Standard Boot
> > > > -====================
> > > > +Standard Boot Overview
> > > > +======================
> > > >
> > >
> > >
> > >
> > > The text is not optimized for readability, e.g.
> > >
> > > "- bootdev  - a device which can hold or access a distro (e.g. MMC,
> > > Ethernet)"
> > >
> > > Please, consistently replace the non-words in the boot standard
> > > documentation:
> > >
> > > %s/bootdev/boot device/
> > > %s/bootmeth/boot method/
> > > %s/bootflow/boot flow/
> >
> > I do want to keep the terms, It is easy to search for bootdev or
> > bootmeth in the code and docs. Once people learn what they mean it is
> > pretty simple.
>
> I agree, this is the documentation for "bootdev" and "bootmeth" and
> "bootflow" not for "boot device" and so forth.
>
> > > "distro" isn't a dictionary word either. Do you mean operating system?
> >
> > I mean a linux distro, in the sense that 'distro boot' uses it.
>
> Maybe an initial statement early about starting your operating system
> distribution (distro), and then it's OK to say distro later on? This
> does also work on non-Linux distributions :)

I missed this comment...

There is this in the introduction: "For Linux, the distro (Linux
distribution, e.g. Debian, Fedora) is responsible"

In other places I call it an Operating System. I like the word
'distro' since it is widely used. It is also the name of the
script-based distro-boot feature. However it refers to Linux, which is
a bit limiting.

I'm open to any changes here to make things better / clearer.

Regards,
SImon
