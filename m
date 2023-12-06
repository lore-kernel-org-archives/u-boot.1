Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47294C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 03:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60A1787660;
	Wed,  6 Dec 2023 04:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z/B2x/BQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42ABA875EE; Wed,  6 Dec 2023 04:54:45 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3198D870F4
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 04:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5d226f51f71so71663247b3.3
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 19:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701834880; x=1702439680; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fqf5VjUPEa7OsNPlAGY+SlVVc0QAYWZwWNdp69C0ReM=;
 b=Z/B2x/BQ0Vt7xtXZa89GYkmi81YZfckJ1WVorxlQF01Sj2w+4OoPBiYj0B8RWmtbRJ
 RAmQ2iDtPAvT45hMewd/nPv4LQrW64ho/eSiHGl/mfGmq18U5De9KQLaFUScRbiSDeKO
 CjnEKCN51zxgB66shFwDD4KpFhz0K/JeW/b3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701834880; x=1702439680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fqf5VjUPEa7OsNPlAGY+SlVVc0QAYWZwWNdp69C0ReM=;
 b=mlIarEmVwijoyUe4R6/2nLl9Ow/W2Jm+9dAt5pk7p9/M6UWxLMvf3UwjZCO82599PL
 2zYvk9uZJT9b9l0eDSYqF4ZmwOyZF4X8LmxEeJB4nPT8YWst+F6wXPTaQNELvwmJ7Lyy
 GZfVLqrcNZi75pTZyPtU0TbjZWy9EThF9rJjAfi0o5bg5kGVLmo/NbYJeAGXNC6Z+FaG
 VW3BwafL9V97/gaj6XBXvT9NP7GQdKUzIwc9yYsnQ/7nI+GJLef/CHJNr4AVDd9gWJhu
 t3cYh4VHHwgPHHQE8eI92GkSRMV9ggie/2WMtkYBeCUVRZ+OR0zUeScJMEPmFhkpX6E1
 /oKA==
X-Gm-Message-State: AOJu0Yx6m646ALmId7uyWNtJkOa6OYInKZoaqhGJLNoZMBTvpEyRUwws
 uTN6a0n3FDYxpgcY8+8hs3cWAku9UF9pa8k+WCmuow==
X-Google-Smtp-Source: AGHT+IG+f2HAaI/hs8SUR8sPK1+xOEJ5MN8dQAmPjjfU1kVTvhhIANYwXvGh8kQTu/RUJmYxNTrwedA9W+ZucB74wmI=
X-Received: by 2002:a81:520c:0:b0:5d7:1940:dd93 with SMTP id
 g12-20020a81520c000000b005d71940dd93mr148244ywb.105.1701834879796; Tue, 05
 Dec 2023 19:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20231204003144.899097-1-sjg@chromium.org>
 <20231204003144.899097-6-sjg@chromium.org>
 <87plzlypon.fsf@baylibre.com>
In-Reply-To: <87plzlypon.fsf@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Dec 2023 20:54:19 -0700
Message-ID: <CAPnjgZ1GopQ9pt7nENuNKzT3f9aZ80nYhv8jiE3+8RapC4q67g@mail.gmail.com>
Subject: Re: [PATCH 06/14] fastboot: Change fastboot_buf_addr to an address
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Heiko Schocher <hs@denx.de>,
 Marek Vasut <marex@denx.de>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Sean Anderson <sean.anderson@seco.com>
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

Hi Mattijs,

On Tue, 5 Dec 2023 at 02:16, Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Simon,
>
> Thank you for your patch.
>
> On dim., d=C3=A9c. 03, 2023 at 17:31, Simon Glass <sjg@chromium.org> wrot=
e:
>
> > Given the name of this variable, it should be an address, not a
> > pointer. Update this, to make it easier to use with sandbox.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Tested that I could reflash AOSP on the Khadas VIM 3 board.
>
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> Some small nit/question below.
>
> > ---
> >
> >  cmd/fastboot.c                |  2 +-
> >  drivers/fastboot/fb_command.c | 13 ++++++++-----
> >  drivers/fastboot/fb_common.c  | 15 ++++-----------
> >  include/fastboot-internal.h   |  2 +-
> >  include/fastboot.h            |  6 +++---
> >  5 files changed, 17 insertions(+), 21 deletions(-)
> >
> > diff --git a/cmd/fastboot.c b/cmd/fastboot.c
> > index c3c19231c988..792e83d372c3 100644
> > --- a/cmd/fastboot.c
> > +++ b/cmd/fastboot.c
> > @@ -159,7 +159,7 @@ NXTARG:
> >               return CMD_RET_USAGE;
> >       }
> >
> > -     fastboot_init((void *)buf_addr, buf_size);
> > +     fastboot_init(buf_addr, buf_size);
> >
> >       if (!strcmp(argv[1], "udp"))
> >               return do_fastboot_udp(argc, argv, buf_addr, buf_size);
> > diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_comman=
d.c
> > index 5fcadcdf503d..ec030886dbb8 100644
> > --- a/drivers/fastboot/fb_command.c
> > +++ b/drivers/fastboot/fb_command.c
> > @@ -10,6 +10,7 @@
> >  #include <fastboot-internal.h>
> >  #include <fb_mmc.h>
> >  #include <fb_nand.h>
> > +#include <mapmem.h>
> >  #include <part.h>
> >  #include <stdlib.h>
> >  #include <linux/printk.h>
> > @@ -252,7 +253,7 @@ void fastboot_data_download(const void *fastboot_da=
ta,
> >               return;
> >       }
> >       /* Download data to fastboot_buf_addr */
> > -     memcpy(fastboot_buf_addr + fastboot_bytes_received,
> > +     memcpy(map_sysmem(fastboot_buf_addr, 0) + fastboot_bytes_received=
,
> >              fastboot_data, fastboot_data_len);
>
> I'm a little confused on why there is no call of unmap_sysmem() here but
> that seems to be the case for plenty other callers of map_sysmem().
>
> From what I've seen, in the sandbox unmap_sysmem() is a no-oop, but what
> about other architectures ?

Yes it is always a nop. It is designed such that address 0 can be used
as RAM in sandbox.

For PCI the mapping can in fact do something special, so that
memory-mapped peripherals can expose their registers. See
drivers/misc/swap_case.c for an example of that. But we have not ended
up with lots of tests.

>
> >
> >       pre_dot_num =3D fastboot_bytes_received / BYTES_PER_DOT;
> > @@ -296,13 +297,15 @@ void fastboot_data_complete(char *response)
> >   */
> >  static void __maybe_unused flash(char *cmd_parameter, char *response)
> >  {
> > +     void *buf =3D map_sysmem(fastboot_buf_addr, 0);
> > +
> >       if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
> > -             fastboot_mmc_flash_write(cmd_parameter, fastboot_buf_addr=
,
> > -                                      image_size, response);
> > +             fastboot_mmc_flash_write(cmd_parameter, buf, image_size,
> > +                                      response);
> >
> >       if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
> > -             fastboot_nand_flash_write(cmd_parameter, fastboot_buf_add=
r,
> > -                                       image_size, response);
> > +             fastboot_nand_flash_write(cmd_parameter, buf, image_size,
> > +                                       response);
>
> Same here.
>
> >  }
> >

[..]

Regards,
Simon
