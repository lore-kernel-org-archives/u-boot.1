Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C241C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 09:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDF8188542;
	Fri, 24 May 2024 11:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="f9kivgCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73058885E1; Fri, 24 May 2024 11:01:29 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB56C88568
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 11:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5b2dec569e3so3783490eaf.2
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 02:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1716541284; x=1717146084;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kOlsnVNqOEhHlHxYg43Ng7k/ha6WTrl/xXYlQ3fhz0=;
 b=f9kivgCA23T+Mg0SwWJ/uX8daJNIfGLUNkm2eM6Nj38wf4RNcMF1Ehr7isiFDFMH3D
 CPaKrlfZTskTmu/GtBGTUEeOLjbO05uIxpCnzDLRKFgOz9uOzM38Wr3tXRrAE4+hftG6
 w/83+1xdol0VT5LBd0nLzWHwPF31CocmtSRR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716541284; x=1717146084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9kOlsnVNqOEhHlHxYg43Ng7k/ha6WTrl/xXYlQ3fhz0=;
 b=qjIsPti3T4S6VBLPJu7usRaLvziY+U4Jlj8fc0lubkzlU+wpOtl86IOCWwtFNCPkz6
 o0H79IZtYrgmwOU6XY+ZJnkUdHpagx3W+Nx7mGpjXC2HL1Km25O3rskNJNNCfybXFiHJ
 Svvb6KYSfDL4Pdhgp6MxNFUisXw8f015w1uWz55UGy7pznm8nLMs0ps3oGsOEutEuq6+
 HZQ7566idlUL+Q3a7U2b3suYuHeuXDLaobAwdFcpqn7eCbqcb/KSXtH7tZFfd+WpctLi
 l/038pvJv0AaCz0pQo9zRkQhVDt1IypNlNNkMrUonWvqW5z9QB52Ps2P9GHrE+vRtQN1
 wntg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNb9LycFMJXmQdVh2fJ5Dfa5uLlCHb+kK+GWUKpIv2o4Ea0UXNWu180eY+9fGOpfe10P7V+ZFEOnh5EUOgugQH8Y/h5g==
X-Gm-Message-State: AOJu0YwVLHoiryymlczF3hY104432d5d2IBEuH98P9JjN62w3uPHYEox
 hvmZoU67kigeLBQ42i/OsVTcgpVxTnROyp0Y1yQZ74aHMJQcOPQSL1K9ritVG2mWQbG1t+bFXY1
 gOjbr8+BoNdhKWMWWA6ieS5SURuAqEY0iSIVY8Q==
X-Google-Smtp-Source: AGHT+IGpvL1Q2gpwNIBuNX7pOLKjPEZQDmoUK+Ns7/5xpMopnq+lf1c3j4kzxiAh9k7bAdXWVTMsSfHSBdV/K6sBzDA=
X-Received: by 2002:a05:6358:eda:b0:192:5bd6:74d7 with SMTP id
 e5c5f4694b2df-197e50f80ecmr160803155d.13.1716541284070; Fri, 24 May 2024
 02:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240325144148.3738195-1-avromanov@salutedevices.com>
 <20240506135755.pgpttzekxd6g3css@cab-wsm-0029881>
 <CAOf5uwmV8s-mcNM42nC664uW=+s0waiJsr911UfmxJ32XJgJAQ@mail.gmail.com>
 <20240523104925.fwzfztgigojhjw6s@cab-wsm-0029881.sigma.sbrf.ru>
 <CAOf5uwkBq2yPyC982b6LJKoRk6B1+J8-ecj5xZbzyzFk-M7AeA@mail.gmail.com>
 <20240523105931.a6teu5moqei4i7jc@cab-wsm-0029881.sigma.sbrf.ru>
In-Reply-To: <20240523105931.a6teu5moqei4i7jc@cab-wsm-0029881.sigma.sbrf.ru>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Fri, 24 May 2024 11:01:13 +0200
Message-ID: <CABGWkvqqX5oY7cH4B2t3U16Fcwk3OVmsMVwgL7+pShN-PtcG+A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Introduce UBI block device
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
 "kmpark@infradead.org" <kmpark@infradead.org>, 
 "hs@denx.de" <hs@denx.de>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "dunaev@tecon.ru" <dunaev@tecon.ru>, 
 "sjg@chromium.org" <sjg@chromium.org>, "bmeng@tinylab.org" <bmeng@tinylab.org>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "tobias@waldekranz.com" <tobias@waldekranz.com>, 
 "jpewhacker@gmail.com" <jpewhacker@gmail.com>, 
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>, 
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
 "jbx6244@gmail.com" <jbx6244@gmail.com>, 
 "abdellatif.elkhlifi@arm.com" <abdellatif.elkhlifi@arm.com>, 
 "mikhail.kshevetskiy@iopsys.eu" <mikhail.kshevetskiy@iopsys.eu>, 
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 kernel <kernel@sberdevices.ru>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Alexey,

On Thu, May 23, 2024 at 12:59=E2=80=AFPM Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> On Thu, May 23, 2024 at 12:51:33PM +0200, Michael Nazzareno Trimarchi wro=
te:
> > Hi
> >
> > We queue them this afternoon
>
> Thank you.
>
> I also wanted to remind you that there is still a similiar patchest with
> mtdblock support (https://lore.kernel.org/all/20240506135607.aprjqn7uyng2=
jgp5@cab-wsm-0029881/)
> that should be applied to bracnh before this.
>
> >
> > Michael
> >
> > On Thu, May 23, 2024 at 12:49=E2=80=AFPM Alexey Romanov
> > <avromanov@salutedevices.com> wrote:
> > >
> > >
> > > Hi Michael,
> > >
> > > On Mon, May 06, 2024 at 03:59:52PM +0200, Michael Nazzareno Trimarchi=
 wrote:
> > > > Hi Alexey
> > > >
> > > > Sorry will will put on CI
> > >
> > > Any news?
> > >
> > > >
> > > > Michael
> > > >
> > > > On Mon, May 6, 2024 at 3:58=E2=80=AFPM Alexey Romanov
> > > > <avromanov@salutedevices.com> wrote:
> > > > >
> > > > > Hello! Ping.
> > > > >
> > > > > On Mon, Mar 25, 2024 at 05:41:42PM +0300, Alexey Romanov wrote:
> > > > > > Hello!
> > > > > >
> > > > > > This series adds support for the UBI block device, which
> > > > > > allows to read/write data block by block. For example,
> > > > > > it can now be used for BCB or Android AB command:
> > > > > >
> > > > > >   $ bcb load ubi 0 part_name
> > > > > >
> > > > > > Tested only on SPI NAND, so bind is made only for
> > > > > > SPI NAND drivers. Can be used with mtdblock device [1].
> > > > > >
> > > > > > ---
> > > > > >
> > > > > > Changes V1 -> V2 [2]:
> > > > > >
> > > > > >  - Rebased over mtdblock v2 patchset [3].
> > > > > >  - Compile UBI partitions support only if CONFIG_BLK option
> > > > > >    is enabled.
> > > > > >
> > > > > > - Links:
> > > > > >
> > > > > >   [1] https://lore.kernel.org/all/20240227100441.1811047-1-avro=
manov@salutedevices.com/
> > > > > >   [2] https://lore.kernel.org/all/20240306134906.1179285-1-avro=
manov@salutedevices.com/
> > > > > >   [3] https://lore.kernel.org/all/20240307130726.1582487-1-avro=
manov@salutedevices.com/
> > > > > >
> > > > > > Alexey Romanov (6):
> > > > > >   ubi: allow to read from volume with offset
> > > > > >   ubi: allow to write to volume with offset
> > > > > >   drivers: introduce UBI block abstraction
> > > > > >   disk: don't try search for partition type if already set
> > > > > >   disk: support UBI partitions
> > > > > >   spinand: bind UBI block
> > > > > >
> > > > > >  cmd/ubi.c                   |  77 +++++++++++++++++++--
> > > > > >  disk/part.c                 |   7 ++
> > > > > >  drivers/block/blk-uclass.c  |   1 +
> > > > > >  drivers/mtd/nand/spi/core.c |   8 ++-
> > > > > >  drivers/mtd/ubi/Makefile    |   1 +
> > > > > >  drivers/mtd/ubi/block.c     | 130 ++++++++++++++++++++++++++++=
++++++++
> > > > > >  drivers/mtd/ubi/part.c      |  99 +++++++++++++++++++++++++++
> > > > > >  env/ubi.c                   |  16 ++---
> > > > > >  include/part.h              |   2 +
> > > > > >  include/ubi_uboot.h         |   8 ++-
> > > > > >  10 files changed, 332 insertions(+), 17 deletions(-)
> > > > > >  create mode 100644 drivers/mtd/ubi/block.c
> > > > > >  create mode 100644 drivers/mtd/ubi/part.c
> > > > > >
> > > > > > --
> > > > > > 2.34.1
> > > > > >
> > > > >
> > > > > --
> > > > > Thank you,
> > > > > Alexey
> > > >
> > > >
> > > >
> > > > --
> > > > Michael Nazzareno Trimarchi
> > > > Co-Founder & Chief Executive Officer
> > > > M. +39 347 913 2170
> > > > michael@amarulasolutions.com
> > > > __________________________________
> > > >
> > > > Amarula Solutions BV
> > > > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > > > T. +31 (0)85 111 9172
> > > > info@amarulasolutions.com
> > > > www.amarulasolutions.com
> > >
> > > --
> > > Thank you,
> > > Alexey
> >
> >
> >
> > --
> > Michael Nazzareno Trimarchi
> > Co-Founder & Chief Executive Officer
> > M. +39 347 913 2170
> > michael@amarulasolutions.com
> > __________________________________
> >
> > Amarula Solutions BV
> > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > T. +31 (0)85 111 9172
> > info@amarulasolutions.com
> > www.amarulasolutions.com
>
> --
> Thank you,
> Alexey

I applied your series

https://patchwork.ozlabs.org/user/todo/uboot/?series=3D401667
https://patchwork.ozlabs.org/user/todo/uboot/?series=3D400302

but the CI fails. The first applied series already has problems:

Building current source for 1 boards (1 thread, 64 jobs per thread)
53 x86: + coreboot
54+In file included from include/linux/printk.h:4,
55+ from include/linux/kernel.h:5,
56+ from include/linux/bitops.h:22,
57+ from include/uuid.h:13,
58+ from include/part.h:11,
59+ from drivers/mtd/mtdblock.c:55:
60+drivers/mtd/mtdblock.c: In function 'mtd_blk_read':
61+drivers/mtd/mtdblock.c:100:32: error: format '%lx' expects argument
of type 'long unsigned int', but argument 7 has type 'lbaint_t' {aka
'long long unsigned int'} [-Werror=3Dformat=3D]
62+ 100 | pr_err("mtdblock: failed to read block 0x%lx\n", cur);
63+ | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
64+include/log.h:157:21: note: in definition of macro 'pr_fmt'
65+ 157 | #define pr_fmt(fmt) fmt
66+ | ^~~
67+include/log.h:178:33: note: in expansion of macro 'log'
68+ 178 | #define log_err(_fmt...) log(LOG_CATEGORY, LOGL_ERR, ##_fmt)
69+ | ^~~
70+include/linux/printk.h:50:31: note: in expansion of macro 'log_err'
71+ 50 | CONFIG_LOGLEVEL > 3 ? log_err(fmt, ##__VA_ARGS__) : 0; \
72+ | ^~~~~~~
73+drivers/mtd/mtdblock.c:100:25: note: in expansion of macro 'pr_err'
74+ | ^~~~~~
75+drivers/mtd/mtdblock.c:100:68: note: format string is defined here
76+ | ~~^
77+ | |
78+ | long unsigned int
79+ | %llx
80+drivers/mtd/mtdblock.c: In function 'mtd_blk_write':
81+drivers/mtd/mtdblock.c:167:32: error: format '%lx' expects argument
of type 'long unsigned int', but argument 7 has type 'lbaint_t' {aka
'long long unsigned int'} [-Werror=3Dformat=3D]
82+ 167 | pr_err("mtdblock: failed to read block 0x%lx\n", cur);
83

Please run the tests locally to fix the errors.

Thanks and regards,
Dario

--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
