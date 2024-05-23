Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71596C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 10:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A479B884B2;
	Thu, 23 May 2024 12:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Up3ubXgB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9761884EA; Thu, 23 May 2024 12:51:47 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50AF388496
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 12:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5751237a79bso9114223a12.2
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 03:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1716461505; x=1717066305;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vXzkOjrMl0hojpjiGEGAwQco1/JHlXrKty+yGLUt8mo=;
 b=Up3ubXgBH0chdeqcWwbYdi6tvTz5G3j+hkI9vjNSbR871BWptYE/Mq/FDtyrbmWyy1
 M+phCC0UVz18h97oeNhdEMeCmEui5Cl+40L4Dgr+bmznTTOTy2fhGkOX+FGx0dpbJcnT
 jz97rohGMrLdfF5WQSLPaQLu1UQFRAlewFH0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716461505; x=1717066305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vXzkOjrMl0hojpjiGEGAwQco1/JHlXrKty+yGLUt8mo=;
 b=tIGES0DOlBhP6bGXKRNCQJwvMtv57gKRscy5y4t8GLojsHIIK2p/JMScKhyATsy8Jb
 WL4cbXpDdWXoqwOSG2faemZZQXB1otI+QDJwdVaHOIUQ64HcD8ApUvY4YYQKlxOX02K1
 xYyxD3MPu3u2J/Gi4Lgp1g7THV2q9zM3+T866C21lwhQnLDYi0hM3tfjTlQy6aMcS0Zd
 +psPfJEc7Xk0YkieZDzHeD063gBIorCvlv0DcpCJ4rtPL3B89luZHcQ64zAzZ9I9Opc5
 u2gJ973IfsHffIuNxl84rNR6c1aPfeUxaAmDOp2yEPDkJm6kIbhpGJVZnO96AJUqZbo2
 KCOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBt+eB2ALUA8EnNmBSdlzw6yXLlsEGrZsggKzEUmA4O31D/p6MgAxJ9obuMs3/0TIoivR+wckzPEZ84E27qNogJq6vTg==
X-Gm-Message-State: AOJu0Yz0DvtKhST2s6Bjtrcl3/yMuU1Cidfppkcs+zhve1uFHz95QOmC
 k7FDF2BmmKS3m7eswYmDklnDUaGvAPnsBtsKdc7+v2hmDVZR+PGTJgEop9/VLNmS59hrmxzFgAA
 tJCzPyvtfQKmw9KeoxiCgb3lHEKwiXd6J/Kjr0A==
X-Google-Smtp-Source: AGHT+IFeqXEvYHi8f1URd5GJJt6HAbJA5N6Io12oyrnXK9vz4Q8NUox0uttAf0YPraWrEXb3V7n1LXRmu3p/g0Um418=
X-Received: by 2002:a17:906:b184:b0:a59:bacc:b082 with SMTP id
 a640c23a62f3a-a62281cafabmr269276166b.60.1716461504617; Thu, 23 May 2024
 03:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240325144148.3738195-1-avromanov@salutedevices.com>
 <20240506135755.pgpttzekxd6g3css@cab-wsm-0029881>
 <CAOf5uwmV8s-mcNM42nC664uW=+s0waiJsr911UfmxJ32XJgJAQ@mail.gmail.com>
 <20240523104925.fwzfztgigojhjw6s@cab-wsm-0029881.sigma.sbrf.ru>
In-Reply-To: <20240523104925.fwzfztgigojhjw6s@cab-wsm-0029881.sigma.sbrf.ru>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 23 May 2024 12:51:33 +0200
Message-ID: <CAOf5uwkBq2yPyC982b6LJKoRk6B1+J8-ecj5xZbzyzFk-M7AeA@mail.gmail.com>
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

Hi

We queue them this afternoon

Michael

On Thu, May 23, 2024 at 12:49=E2=80=AFPM Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
>
> Hi Michael,
>
> On Mon, May 06, 2024 at 03:59:52PM +0200, Michael Nazzareno Trimarchi wro=
te:
> > Hi Alexey
> >
> > Sorry will will put on CI
>
> Any news?
>
> >
> > Michael
> >
> > On Mon, May 6, 2024 at 3:58=E2=80=AFPM Alexey Romanov
> > <avromanov@salutedevices.com> wrote:
> > >
> > > Hello! Ping.
> > >
> > > On Mon, Mar 25, 2024 at 05:41:42PM +0300, Alexey Romanov wrote:
> > > > Hello!
> > > >
> > > > This series adds support for the UBI block device, which
> > > > allows to read/write data block by block. For example,
> > > > it can now be used for BCB or Android AB command:
> > > >
> > > >   $ bcb load ubi 0 part_name
> > > >
> > > > Tested only on SPI NAND, so bind is made only for
> > > > SPI NAND drivers. Can be used with mtdblock device [1].
> > > >
> > > > ---
> > > >
> > > > Changes V1 -> V2 [2]:
> > > >
> > > >  - Rebased over mtdblock v2 patchset [3].
> > > >  - Compile UBI partitions support only if CONFIG_BLK option
> > > >    is enabled.
> > > >
> > > > - Links:
> > > >
> > > >   [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromano=
v@salutedevices.com/
> > > >   [2] https://lore.kernel.org/all/20240306134906.1179285-1-avromano=
v@salutedevices.com/
> > > >   [3] https://lore.kernel.org/all/20240307130726.1582487-1-avromano=
v@salutedevices.com/
> > > >
> > > > Alexey Romanov (6):
> > > >   ubi: allow to read from volume with offset
> > > >   ubi: allow to write to volume with offset
> > > >   drivers: introduce UBI block abstraction
> > > >   disk: don't try search for partition type if already set
> > > >   disk: support UBI partitions
> > > >   spinand: bind UBI block
> > > >
> > > >  cmd/ubi.c                   |  77 +++++++++++++++++++--
> > > >  disk/part.c                 |   7 ++
> > > >  drivers/block/blk-uclass.c  |   1 +
> > > >  drivers/mtd/nand/spi/core.c |   8 ++-
> > > >  drivers/mtd/ubi/Makefile    |   1 +
> > > >  drivers/mtd/ubi/block.c     | 130 ++++++++++++++++++++++++++++++++=
++++
> > > >  drivers/mtd/ubi/part.c      |  99 +++++++++++++++++++++++++++
> > > >  env/ubi.c                   |  16 ++---
> > > >  include/part.h              |   2 +
> > > >  include/ubi_uboot.h         |   8 ++-
> > > >  10 files changed, 332 insertions(+), 17 deletions(-)
> > > >  create mode 100644 drivers/mtd/ubi/block.c
> > > >  create mode 100644 drivers/mtd/ubi/part.c
> > > >
> > > > --
> > > > 2.34.1
> > > >
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
