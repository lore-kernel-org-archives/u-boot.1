Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA2DC10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 14:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76E3A885AE;
	Mon,  6 May 2024 16:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="c3wExEC9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1764F885B5; Mon,  6 May 2024 16:00:08 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0A2788541
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 16:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a599eedc8eeso422668866b.1
 for <u-boot@lists.denx.de>; Mon, 06 May 2024 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1715004005; x=1715608805;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lG9uGcDNhUAOhSqxPGDxs1zlPVDNOMeSxXQdqK3uQZA=;
 b=c3wExEC93cSQbELBUk0q+G2WcnhG+N9RA9uIEejtHwXULzOk1tHSl+GmAtTOyh7dIf
 XZ6ggQJ1/acUlaY5q6k1VB0WVE1tMJWwKpo7jw395cUR/nAaOXg2p/Ev62+Z61ik+zJd
 y/dQNzecV1CetGWDEiZ/1o38stFH53BBXci6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715004005; x=1715608805;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lG9uGcDNhUAOhSqxPGDxs1zlPVDNOMeSxXQdqK3uQZA=;
 b=Twt6G5YshZlOLikEOc5507i+aFqb4H9bHV8L6KgDoIsuYzDrUMjrlLmDpGXr0mj5/N
 Mum2Ndro0JnsDKAQC2NUkCT/FkJwhtUBAmEfREpZKO9Lybs+/lsXo66GljcGhzHhLDsi
 4Dji1r1ZCDvXVrqadyc4oMTTVxzrtNGdCvIRHfxaeFXJojWhYbQNL3COfIJsqKGm9u0R
 rldw9v+DYnZ/HG9lfMl1avXw2jmQND/b/aAdqgg5afnElGf2YW09Eg2JlIT1A8vmOVH9
 gUNxhTKgJlk0qLvkRUMILexywPV0YjMxsQ8Ue65nBHksNAakdpMoUqPw9QegGi73pQPG
 CAiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg63TcIh3hmVc91wIRe1WONKTbjH5Ffmtnxzy9RqE0OPNr4AsmREJ1OpGTLWAyVVX7AMCsgqlyait+nDgF6DhBWn2dOw==
X-Gm-Message-State: AOJu0YzLcdw4tB0t8UNezGnQvJcsqiMQqaamXr2pWR8nNO8LlIUrAHlp
 RvoNmtDhvwZjthE+w/3lxiUtSYRH7lXZ21+QDdVdrZva4b5BavSWJNJPrDuHsLh/G5zDFBnxLYk
 AHHr6bteNQpQGnp8ulf9mPSXjdqMOWkIwWGwm6w==
X-Google-Smtp-Source: AGHT+IHx+ShVNIIpUlawbRFH9XRIAQxKb64D4iyRWFbizrHz0fpEbUWF5uhUW6+oQ3XpuRS2TEzVaziMtilvHeipWPo=
X-Received: by 2002:a17:906:5006:b0:a55:9195:362c with SMTP id
 s6-20020a170906500600b00a559195362cmr5506780ejj.49.1715004004803; Mon, 06 May
 2024 07:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240325144148.3738195-1-avromanov@salutedevices.com>
 <20240506135755.pgpttzekxd6g3css@cab-wsm-0029881>
In-Reply-To: <20240506135755.pgpttzekxd6g3css@cab-wsm-0029881>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 6 May 2024 15:59:52 +0200
Message-ID: <CAOf5uwmV8s-mcNM42nC664uW=+s0waiJsr911UfmxJ32XJgJAQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Introduce UBI block device
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: "dario.binacchi@amarulasolutions.com"
 <dario.binacchi@amarulasolutions.com>, 
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

Hi Alexey

Sorry will will put on CI

Michael

On Mon, May 6, 2024 at 3:58=E2=80=AFPM Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> Hello! Ping.
>
> On Mon, Mar 25, 2024 at 05:41:42PM +0300, Alexey Romanov wrote:
> > Hello!
> >
> > This series adds support for the UBI block device, which
> > allows to read/write data block by block. For example,
> > it can now be used for BCB or Android AB command:
> >
> >   $ bcb load ubi 0 part_name
> >
> > Tested only on SPI NAND, so bind is made only for
> > SPI NAND drivers. Can be used with mtdblock device [1].
> >
> > ---
> >
> > Changes V1 -> V2 [2]:
> >
> >  - Rebased over mtdblock v2 patchset [3].
> >  - Compile UBI partitions support only if CONFIG_BLK option
> >    is enabled.
> >
> > - Links:
> >
> >   [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@sa=
lutedevices.com/
> >   [2] https://lore.kernel.org/all/20240306134906.1179285-1-avromanov@sa=
lutedevices.com/
> >   [3] https://lore.kernel.org/all/20240307130726.1582487-1-avromanov@sa=
lutedevices.com/
> >
> > Alexey Romanov (6):
> >   ubi: allow to read from volume with offset
> >   ubi: allow to write to volume with offset
> >   drivers: introduce UBI block abstraction
> >   disk: don't try search for partition type if already set
> >   disk: support UBI partitions
> >   spinand: bind UBI block
> >
> >  cmd/ubi.c                   |  77 +++++++++++++++++++--
> >  disk/part.c                 |   7 ++
> >  drivers/block/blk-uclass.c  |   1 +
> >  drivers/mtd/nand/spi/core.c |   8 ++-
> >  drivers/mtd/ubi/Makefile    |   1 +
> >  drivers/mtd/ubi/block.c     | 130 ++++++++++++++++++++++++++++++++++++
> >  drivers/mtd/ubi/part.c      |  99 +++++++++++++++++++++++++++
> >  env/ubi.c                   |  16 ++---
> >  include/part.h              |   2 +
> >  include/ubi_uboot.h         |   8 ++-
> >  10 files changed, 332 insertions(+), 17 deletions(-)
> >  create mode 100644 drivers/mtd/ubi/block.c
> >  create mode 100644 drivers/mtd/ubi/part.c
> >
> > --
> > 2.34.1
> >
>
> --
> Thank you,
> Alexey



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
