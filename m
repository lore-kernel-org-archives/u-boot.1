Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBC4D6C2BC
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 01:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C34A895FD;
	Wed, 20 Nov 2024 02:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UfxfxEhx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B841A895D9; Wed, 20 Nov 2024 02:46:20 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E06A8961B
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 02:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6eeb31b10ceso13126577b3.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 17:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732067177; x=1732671977; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NlH6qXVAxbffCTCb7xxGozR/1kofKqGeIoNXHMsv3EA=;
 b=UfxfxEhxYp94f+uP5OjJ5B7Di2lIjkIk5nwAPqq3ZD6HubG5TZqlKJXIokeCmejJNC
 j2mzbeNKuMhElGwQgL+8VaMyb8O1VebCCMeRjf1MQuqIi++vqyzU5fzPR1YIlHJ9vxJ2
 N6nU8TWFUt2QNZysTStmssMU+FRfsOOa6cWG7PPM/rcpJu3iMJUK6ZscepXCJVnij9ID
 bRbQga6JRvXmtIhjb/KS+xlkT/ua14LBhr+WmFLjXkzKW6dkdRH9JF4R1hEdDStyNABK
 hkxDpROwGGhkoHkO5v6XkDPeb01099fgkS+bvzWwGr+iWUURoNV6R2RaGOKxs5iLmyBW
 kAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732067177; x=1732671977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NlH6qXVAxbffCTCb7xxGozR/1kofKqGeIoNXHMsv3EA=;
 b=cyhXm7XRPn0CHgVImRKKOMP+clM8PlHiMUE1i0+GwMIQKpiUQS6RI8GDgOE1eMyuq4
 8HerVQsT4d+QwFIA6ETBCDHzLK6V2QLiAZWd4QT5PMdiodOzAdxbNmf6csaaWtsjyfaO
 /u2K/9nUrlIT79WhQ7UBHUXX4n7D/idO/OqPzzIAztkhAkqJ29bFGI3kdTt1ZnZiN4nD
 Ni0IRVVWXSiwt0VLOUWoOU/Hrq0e3SCxDowyaoi76a1XbBQHZfSMKdJeq0v75PqDwJXV
 8LwJOjC+OE/rnumG4mzP8yizX1sp7rAENe0rhw578p/Z9ZO+OnH2Ql120Bg+3GEeLTWT
 f7hg==
X-Gm-Message-State: AOJu0YzM7+xGp8Q/Tgx5DthNI9Rele4+AiKyyQNDhb4cfyZE4A6FaXsH
 5pAyTX2ukOTIhjQlBIe5jnxqt1KSb/r+sSm3vvxkkg+OCelC9zrehBYNwpQqFuEwZ8+n2qsLisu
 lhW955d9/wfgsbqUebc0y1l+Krhs=
X-Google-Smtp-Source: AGHT+IHW29AksikBr4bLbeQ0ovymnyxgXiFvRZJdBMLDe/hA79mdVL/8YhKXg/ENTwSDXv+n3eDN7WzK1JKXzF3xieU=
X-Received: by 2002:a05:690c:608a:b0:6db:db51:c02d with SMTP id
 00721157ae682-6eebd145724mr12023087b3.25.1732067177136; Tue, 19 Nov 2024
 17:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20241120131556.1.I395d95af213e80340ae53152f6a49fc86c5f0c69@changeid>
 <20241120012332.GZ3600562@bill-the-cat>
In-Reply-To: <20241120012332.GZ3600562@bill-the-cat>
From: Chris Packham <judge.packham@gmail.com>
Date: Wed, 20 Nov 2024 14:46:05 +1300
Message-ID: <CAFOYHZCxM2YxquZdphtWWikgwbVVvKL3XdZTchWRySTMJkUiMg@mail.gmail.com>
Subject: Re: [PATCH] arm: mvebu: Add Allied Telesis x250 board
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>, 
 Alexander Dahl <ada@thorsis.com>, Fabio Estevam <festevam@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, Robert Marko <robimarko@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Tony Dinh <mibodhi@gmail.com>
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

Hi Tom,

Thanks for the quick response

On Wed, Nov 20, 2024 at 2:23=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, Nov 20, 2024 at 01:16:00PM +1300, Chris Packham wrote:
>
> > The x250 and SE240 are series of 10G L2+ switches from Allied Telesis.
> > There are a number of them in the range but as far as U-Boot is
> > concerned all the CPU block components are the same so there's only one
> > board defined.
> >
> > Signed-off-by: Chris Packham <judge.packham@gmail.com>
> [snip]
> > diff --git a/include/configs/x250.h b/include/configs/x250.h
> > new file mode 100644
> > index 000000000000..5a3f445e218c
> > --- /dev/null
> > +++ b/include/configs/x250.h
> > @@ -0,0 +1,54 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright (C) 2024 Allied Telesis
> > + */
> > +
> > +#ifndef __X250_H_
> > +#define __X250_H_
> > +
> > +/*
> > + * High Level Configuration Options (easy to change)
> > + */
> > +#define CFG_SYS_TCLK         250000000       /* 250MHz */
> > +
> > +/* additions for new ARM relocation support */
> > +#define CFG_SYS_SDRAM_BASE   0x00000000
> > +
> > +/* auto boot */
> > +
> > +#define CFG_SYS_BAUDRATE_TABLE   { 9600, 19200, 38400, 57600, \
> > +                                   115200, 230400, 460800, 921600 }
>
> We really can't use the default table?
>
> > +
> > +/*
> > + * Other required minimal configurations
> > + */
> > +
> > +/* When runtime detection fails this is the default */
> > +
> > +/* USB ethernet */
>
> Dead comments.
>
> > +
> > +/*
> > + * PCI configuration
> > + */
>
> Probably doesn't apply to this section..
>

All copy and paste. Infact I'm not sure I can use the baud rates
>115200. I'll drop them

> > +#ifdef CONFIG_DISTRO_DEFAULTS
> > +#define BOOT_TARGET_DEVICES(func) \
> > +     func(USB, usb, 0) \
> > +     func(SCSI, scsi, 0) \
> > +     func(PXE, pxe, na) \
> > +     func(DHCP, dhcp, na)
> > +
> > +#include <config_distro_bootcmd.h>
> > +#else
> > +#define BOOTENV
> > +#endif
>
> And you should move to bootstd.
>

I'll look into that. For our internal purposes we don't actually use
this as we have some legacy things we do to boot our images. For my
own testing I tend to just use bootm directly.
