Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B29C10DC1
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 13:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A308F876E7;
	Wed,  6 Dec 2023 14:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="221oDSxn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88EAF87723; Wed,  6 Dec 2023 14:25:24 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5BD787771
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 14:25:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-332fd81fc8dso702518f8f.3
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 05:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701869117; x=1702473917;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PNYxj26MFjnH++plApzuhQRe99G+HDe2iewYPKnMZFI=;
 b=221oDSxncjjvjURgRD1FkvRmfKaRXe1yboSP5aB9sIk5PwIVXc3gpWLwSOLq1HGY4F
 mSN2iQKnk5BsYkAqxCndiCkZTdCt9Elf9tQzSyfIt1fjYX6Sqj3IHome5nmEcPRIFJ2e
 rpRoAwFghXvof9JOuVONmOFrbFnjhIIqj3cTKDDlT5Muanh6/MKYwqlebW0cYw1QW+Bt
 rT9ISvICRHxisztZp1eheU7Bi4Dt0yHk2teksatJXnShKM9f4IVzbf1Zn/HTX70aT9No
 h1xMHsDV/adEcrOZ2FSmt7l9btATkij2d7a5OuFa5qKSQA3xIDZSNBQMf2f+UJD7XiUR
 MIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701869117; x=1702473917;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PNYxj26MFjnH++plApzuhQRe99G+HDe2iewYPKnMZFI=;
 b=Vswwl2XX4/hnE6txPfS76mFhnSgPWs4C8p9mZNM/oaDsPj3vOTAecaGA5Nu2uQMMlm
 FUkeYKkhXapP3sF0ApGn101ZeXJfAEWYz0og2Fd+R8NT4HOfK0JkD5aLTWs4XcqFMD/D
 AKTu8U0lEQa5U8OmRMuAgPhqq4ubW6A9kdpqsBMnCjK2c8U0Mr5PGCM8781NXRAvhxeS
 FSlMnusH6NKXg2rTxNErsNmdHjAn5nNjK86EKY4rhUIFEn0g5gVTJYQIkynREK18IQb1
 p1j83+CukTf5vZjGrnG2uLNfV8COdmAE6gbODBveGdttnsuW+hUOlrtMYwJcTtj3WDat
 p2Og==
X-Gm-Message-State: AOJu0Yxwgcy7JEgQ63insVOUO3OeZwr722ZURzfktDel1RI+qO3vElDq
 o5yOVDBNiUgF/xkweTNeczqo3A==
X-Google-Smtp-Source: AGHT+IG/EPO/7Sn3Xnsj0upb/Yt+rZSXBeW91IppXwLceSKhc38mwZPGTn+UMgeDEiiyXrDaEaP60w==
X-Received: by 2002:a5d:6e42:0:b0:333:2fd2:68e1 with SMTP id
 j2-20020a5d6e42000000b003332fd268e1mr561273wrz.116.1701869117085; 
 Wed, 06 Dec 2023 05:25:17 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 j9-20020adfea49000000b0033331beb85asm14095172wrn.69.2023.12.06.05.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 05:25:16 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Dmitrii Merkurev <dimorinny@google.com>, Heiko
 Schocher <hs@denx.de>, Marek Vasut <marex@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Ramon Fried <rfried.dev@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 06/14] fastboot: Change fastboot_buf_addr to an address
In-Reply-To: <CAPnjgZ1GopQ9pt7nENuNKzT3f9aZ80nYhv8jiE3+8RapC4q67g@mail.gmail.com>
References: <20231204003144.899097-1-sjg@chromium.org>
 <20231204003144.899097-6-sjg@chromium.org> <87plzlypon.fsf@baylibre.com>
 <CAPnjgZ1GopQ9pt7nENuNKzT3f9aZ80nYhv8jiE3+8RapC4q67g@mail.gmail.com>
Date: Wed, 06 Dec 2023 14:25:15 +0100
Message-ID: <87edfz31l0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Tue, Dec 05, 2023 at 20:54, Simon Glass <sjg@chromium.org> wrote:

> Hi Mattijs,
>
> On Tue, 5 Dec 2023 at 02:16, Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> Hi Simon,
>>
>> Thank you for your patch.
>>
>> On dim., d=C3=A9c. 03, 2023 at 17:31, Simon Glass <sjg@chromium.org> wro=
te:
>>
>> > Given the name of this variable, it should be an address, not a
>> > pointer. Update this, to make it easier to use with sandbox.
>> >
>> > Signed-off-by: Simon Glass <sjg@chromium.org>
>>
>> Tested that I could reflash AOSP on the Khadas VIM 3 board.
>>
>> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3
>>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>
>> Some small nit/question below.
>>
>> > ---
>> >
>> >  cmd/fastboot.c                |  2 +-
>> >  drivers/fastboot/fb_command.c | 13 ++++++++-----
>> >  drivers/fastboot/fb_common.c  | 15 ++++-----------
>> >  include/fastboot-internal.h   |  2 +-
>> >  include/fastboot.h            |  6 +++---
>> >  5 files changed, 17 insertions(+), 21 deletions(-)
>> >
>> > diff --git a/cmd/fastboot.c b/cmd/fastboot.c
>> > index c3c19231c988..792e83d372c3 100644
>> > --- a/cmd/fastboot.c
>> > +++ b/cmd/fastboot.c
>> > @@ -159,7 +159,7 @@ NXTARG:
>> >               return CMD_RET_USAGE;
>> >       }
>> >
>> > -     fastboot_init((void *)buf_addr, buf_size);
>> > +     fastboot_init(buf_addr, buf_size);
>> >
>> >       if (!strcmp(argv[1], "udp"))
>> >               return do_fastboot_udp(argc, argv, buf_addr, buf_size);
>> > diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_comma=
nd.c
>> > index 5fcadcdf503d..ec030886dbb8 100644
>> > --- a/drivers/fastboot/fb_command.c
>> > +++ b/drivers/fastboot/fb_command.c
>> > @@ -10,6 +10,7 @@
>> >  #include <fastboot-internal.h>
>> >  #include <fb_mmc.h>
>> >  #include <fb_nand.h>
>> > +#include <mapmem.h>
>> >  #include <part.h>
>> >  #include <stdlib.h>
>> >  #include <linux/printk.h>
>> > @@ -252,7 +253,7 @@ void fastboot_data_download(const void *fastboot_d=
ata,
>> >               return;
>> >       }
>> >       /* Download data to fastboot_buf_addr */
>> > -     memcpy(fastboot_buf_addr + fastboot_bytes_received,
>> > +     memcpy(map_sysmem(fastboot_buf_addr, 0) + fastboot_bytes_receive=
d,
>> >              fastboot_data, fastboot_data_len);
>>
>> I'm a little confused on why there is no call of unmap_sysmem() here but
>> that seems to be the case for plenty other callers of map_sysmem().
>>
>> From what I've seen, in the sandbox unmap_sysmem() is a no-oop, but what
>> about other architectures ?
>
> Yes it is always a nop. It is designed such that address 0 can be used
> as RAM in sandbox.
>
> For PCI the mapping can in fact do something special, so that
> memory-mapped peripherals can expose their registers. See
> drivers/misc/swap_case.c for an example of that. But we have not ended
> up with lots of tests.

Understood, thank you for clarifying !

>
>>
>> >
>> >       pre_dot_num =3D fastboot_bytes_received / BYTES_PER_DOT;
>> > @@ -296,13 +297,15 @@ void fastboot_data_complete(char *response)
>> >   */
>> >  static void __maybe_unused flash(char *cmd_parameter, char *response)
>> >  {
>> > +     void *buf =3D map_sysmem(fastboot_buf_addr, 0);
>> > +
>> >       if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
>> > -             fastboot_mmc_flash_write(cmd_parameter, fastboot_buf_add=
r,
>> > -                                      image_size, response);
>> > +             fastboot_mmc_flash_write(cmd_parameter, buf, image_size,
>> > +                                      response);
>> >
>> >       if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
>> > -             fastboot_nand_flash_write(cmd_parameter, fastboot_buf_ad=
dr,
>> > -                                       image_size, response);
>> > +             fastboot_nand_flash_write(cmd_parameter, buf, image_size,
>> > +                                       response);
>>
>> Same here.
>>
>> >  }
>> >
>
> [..]
>
> Regards,
> Simon
