Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CADDC001CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 16:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5B3687FB6;
	Thu, 11 Apr 2024 18:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZuCey7DN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E58E183346; Thu, 11 Apr 2024 18:14:44 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5F3B87FD7
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 18:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-516ef30b16eso2455e87.3
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 09:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1712852081; x=1713456881;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+rV9cPHaNjvs0MWiApJ8HcPztno8otrDFyUlQD7DtA=;
 b=ZuCey7DNtkv/BOa/NnDB3elkynKO/m4wL4/Fpr6yANi7SYdD0UlnKkUGDbZh6sNakY
 puR+HpksShuZrH8w1MAMZavS3d2frURJ89zP3Msgw98sj4awwKmSbZm4gtSmJfcbIKCc
 BPMpk+LYfV/d2udxO8pxHik1CAYwv9xCFKPos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712852081; x=1713456881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+rV9cPHaNjvs0MWiApJ8HcPztno8otrDFyUlQD7DtA=;
 b=BTPeaF85rm63lX0VQ6kX0fxbqYf+ZEPiiLzguSEpFXjUDf34gLNzCsUHc+plEmVscZ
 nC/JNHyvf3MUaI4VIZEFNE3g3Y5bOIdX7gOZ+8pLR9RBDE1GzNhFFvhLXTvQKjdwxW3p
 yVC3NjDEbS+5ROSWQTTkvsEge/+rOft6DAIQe6zheQ205W6R06Uy1bGYzVCHUt6MXX4H
 xxbQ0p1hGos0XKoi1gMP6RPfoM+C7osQ77DXD5aC8yCf3ABTJkq5+bsippUkvlSDT0k5
 INeDOHkNJa44+DWPPclt/9PAq+0mi1ELG3jVek+qmzgdg9pFFPZyoNqFpqHl8XbhKpDH
 MfXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUm5py2sW4EOR6OIZoTZNzdXQAEFWW2UzVAMP+aKe7KbdoxDbZvqjzZ+vjYsmcx49Gk0YeiqxlkKiF6w/eVRaPDYU/xw==
X-Gm-Message-State: AOJu0YxLVhxiujbVvvLMifA7O/QAnQBXc81gJLLIm7uSoa3lokQXdNN1
 Qy6vs2kqr+RtX/BL1zy6FyqepDIvnEbWgk3HeNl5VgVLGTPtKhHLmRNNqQaAaJ5h67+iwMVGEab
 FfEPslsJf1H9pbCELNxTN+o11V+wZ+te6g8qfIg==
X-Google-Smtp-Source: AGHT+IGrpTqAtgMTFmLHBVowtW1+Z778qw5aVUvLm4QFAIw54bB/VtUfpTsupu/aKp/ZJ8+qdJBky4uI4wA9c+Py6iU=
X-Received: by 2002:a05:6512:312a:b0:516:d448:b42a with SMTP id
 p10-20020a056512312a00b00516d448b42amr137256lfd.26.1712852080962; Thu, 11 Apr
 2024 09:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240404105813.1520732-1-avromanov@salutedevices.com>
 <20240411160857.fb6a2neossmz2d4y@cab-wsm-0029881.sigma.sbrf.ru>
In-Reply-To: <20240411160857.fb6a2neossmz2d4y@cab-wsm-0029881.sigma.sbrf.ru>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 11 Apr 2024 18:14:29 +0200
Message-ID: <CAOf5uwkGoHVzDvvz3pqCsro2VC+Vxj-YaKKkye=n=AU8w8dJmA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Introduce mtdblock device
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

I will review tomorrow, I need have a time window to test even on my board

Mihcael

On Thu, Apr 11, 2024 at 6:09=E2=80=AFPM Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> Hello! Ping.
>
> On Thu, Apr 04, 2024 at 01:58:10PM +0300, Alexey Romanov wrote:
> > Hello!
> >
> > This series adds support for the mtdblock device, which
> > allows to read/write data block by block. For example,
> > it can now be used for BCB or Android AB command:
> >
> >   $ bcb load mtd 0 part_name
> >
> > Tested only on SPI NAND, so bind is made only for
> > SPI NAND drivers.
> >
> > ---
> >
> > Changes V1 -> V2 [1]:
> >
> >   - Drop patch [2].
> >   - Add warning if bind NAND mtdblock device.
> >   - Move documentation of mtdblock implementation
> >     from commit message to the source code.
> >   - Remove __maybe_unused from mtd partition functions
> >     description.
> >   - Use blk_enabled() instead of #ifdefs.
> >
> > Changes V2 -> V3 [2]:
> >
> >   - Rebased over [3].
> >   - Rename mtd_bread/bwrite -> mtd_blk_read/write.
> >   - Fix GPL-2.0 license short name definiton in headers.
> >   - Add empty line after MTD_ENTRY_NUMBERS define.
> >
> > Links:
> >
> >   - [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@=
salutedevices.com/
> >   - [2] https://lore.kernel.org/all/20240227100441.1811047-5-avromanov@=
salutedevices.com/
> >   - [3] https://lore.kernel.org/u-boot/20240403114047.84030-1-heinrich.=
schuchardt@canonical.com/T/#u
> >
> > Alexey Romanov (3):
> >   disk: support MTD partitions
> >   drivers: introduce mtdblock abstraction
> >   spinand: bind mtdblock
> >
> >  disk/part.c                 |   3 +-
> >  drivers/block/blk-uclass.c  |   1 +
> >  drivers/mtd/Kconfig         |   1 +
> >  drivers/mtd/Makefile        |   1 +
> >  drivers/mtd/mtdblock.c      | 227 ++++++++++++++++++++++++++++++++++++
> >  drivers/mtd/mtdpart.c       |  69 +++++++++++
> >  drivers/mtd/nand/spi/core.c |  20 ++++
> >  include/linux/mtd/mtd.h     |  12 ++
> >  include/part.h              |   3 +
> >  9 files changed, 336 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/mtd/mtdblock.c
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
