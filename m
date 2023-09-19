Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E4FCD54AB
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 08:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0D0086A93;
	Tue, 19 Sep 2023 10:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AlY3ubjG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2342386AA4; Tue, 19 Sep 2023 10:47:18 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41D5E86A8A
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 10:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9adca291f99so506313066b.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695113236; x=1695718036; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BP9606YOi2gtH5rDwU434olSH6fDanJ1Bbw20Xxl3Fo=;
 b=AlY3ubjGuPYwtRmwA8yqWQK+2CTvQBmcUxMZMJqs9aw3J3QZdZMMms9HaRYkLuUuHE
 +UD+4qOnFvxiab2+XzMIlr2/VMJkdlS9JfYlzZvTbZOiRYpPSFxUcHgM+XZ8qDpstx7e
 SmjwaYkLb5mqweYNnV5/Wb6ep2IWS+mkoHmSUcKC99NDGrpdrtyL74j6pRz06o7xYpDb
 B17pBULifVcJN5t1seBpzvEldZ9kkezMq21AMif6PrJruoiX8nd6eRNeTRZqQS/OGhLI
 IOQbPEFSsvgJ+SMHlU2IgLXMiVMZZNRX4a//AFOXiDrrSH2qyw7skiqX/+iBI/jSgC6g
 b46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695113236; x=1695718036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BP9606YOi2gtH5rDwU434olSH6fDanJ1Bbw20Xxl3Fo=;
 b=lgEGLCAaPpjs0Tmhi+mU4ur00yp/CG9TC32u68l0dKEngQg9vlPKvtbPq476BRVF1a
 LfYU/cPcaDOCJpMASmq16Q9V+GQhiESIqhc0/9rc03z9C58/rTRwjl7mXuIkA3xOfHwl
 PUWAfbSnJgG5XK8iqT7P+ZA/L39C87/HreI+ILZct34Fv6fyt7Q6W0zrwFair2KCox73
 K31vuJx1EYTQ+GJ7hsT2zIBud8Gw0OiqEq/7B8VC/yYdMH/W7kEWzi1kSjHkfyZzNQtJ
 pHjHAjM/dnzJEYI80zsqpQGrGWvekeg0pY5q4B1xCtoatvJHJ4KsD2DcfGyrUWyPLu3J
 kuQg==
X-Gm-Message-State: AOJu0Yzbie2asBhkui9zbYYfnYVxrifOwx50+OqgwfzPuBXUwF3y2fAn
 uDxIwmaTxXtEN9l1CpGElHMQyOvl7QReDNmWGKo=
X-Google-Smtp-Source: AGHT+IFyc5qZBz1ytynWDDVt4VZocvO3/AVlnXOylnqrB5H/zaZEooJzV9O/S0gggcQe/FXVp3qGQxeaI7VzrQX651Q=
X-Received: by 2002:a17:906:7685:b0:9a2:1e03:1572 with SMTP id
 o5-20020a170906768500b009a21e031572mr9767053ejm.19.1695113235748; Tue, 19 Sep
 2023 01:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230910191304.191580-1-sjg@chromium.org>
 <20230910191304.191580-2-sjg@chromium.org>
In-Reply-To: <20230910191304.191580-2-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 16:47:03 +0800
Message-ID: <CAEUhbmWnsbtdTaa6tktO_7cWBRXdzsftQAFk95qboVet6trYxA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] x86: Update cbmem driver
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Sadovsky <nable.maininbox@googlemail.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
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

Hi Simon,

On Mon, Sep 11, 2023 at 3:13=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> This driver is not actually built since a Kconfig was never created for
> it.
>
> Add a Kconfig (which is already implied by COREBOOT) and update the
> implementation to avoid using unnecessary memory. Drop the #ifdef at the
> top since we can rely on Kconfig to get that right.
>
> To enable it (in addition to serial and video), use:
>
>    setenv stdout serial,vidconsole,cbmem
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v4:
> - Add some comments to help understand the overflow mechanism
>
> Changes in v2:
> - Update to support the new overflow mechanism
>
>  drivers/misc/Kconfig         |  8 +++++++
>  drivers/misc/cbmem_console.c | 43 ++++++++++++++++++++++--------------
>  2 files changed, 34 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index a6e3f62ecb09..c930e4a361bf 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -122,6 +122,14 @@ config VEXPRESS_CONFIG
>           configuration bus on the Arm Versatile Express boards via
>           a sysreg driver.
>
> +config CBMEM_CONSOLE
> +       bool "Write console output to coreboot cbmem"
> +       depends on X86
> +       help
> +         Enables console output to the cbmem console, which is a memory
> +         region set up by coreboot to hold a record of all console outpu=
t.
> +         Enable this only if booting from coreboot.
> +
>  config CMD_CROS_EC
>         bool "Enable crosec command"
>         depends on CROS_EC
> diff --git a/drivers/misc/cbmem_console.c b/drivers/misc/cbmem_console.c
> index 8bbe33d414da..3cbe9fb1a46a 100644
> --- a/drivers/misc/cbmem_console.c
> +++ b/drivers/misc/cbmem_console.c
> @@ -5,27 +5,37 @@
>
>  #include <common.h>
>  #include <console.h>
> -#ifndef CONFIG_SYS_COREBOOT
> -#error This driver requires coreboot
> -#endif
> -
>  #include <asm/cb_sysinfo.h>
>
> -struct cbmem_console {
> -       u32 buffer_size;
> -       u32 buffer_cursor;
> -       u8  buffer_body[0];
> -}  __attribute__ ((__packed__));
> -
> -static struct cbmem_console *cbmem_console_p;
> -
>  void cbmemc_putc(struct stdio_dev *dev, char data)
>  {
> -       int cursor;
> +       const struct sysinfo_t *sysinfo =3D cb_get_sysinfo();
> +       struct cbmem_console *cons;
> +       uint pos, flags;
> +
> +       if (!sysinfo)
> +               return;
> +       cons =3D sysinfo->cbmem_cons;
> +       if (!cons)
> +               return;
> +
> +       pos =3D cons->cursor & CBMC_CURSOR_MASK;
> +
> +       /* preserve the overflow flag if present */
> +       flags =3D cons->cursor & ~CBMC_CURSOR_MASK;
> +
> +       cons->body[pos++] =3D data;
> +
> +       /*
> +        * Deal with overflow - the flag may be cleared by another progra=
m which
> +        * reads the buffer out, e.g. Linux
> +        */

U-Boot is not memory resident, so this does not sound like a correct
overflow mechanism to me.

> +       if (pos >=3D cons->size) {
> +               pos =3D 0;
> +               flags |=3D CBMC_OVERFLOW;
> +       }
>
> -       cursor =3D cbmem_console_p->buffer_cursor++;
> -       if (cursor < cbmem_console_p->buffer_size)
> -               cbmem_console_p->buffer_body[cursor] =3D data;
> +       cons->cursor =3D flags | pos;
>  }
>
>  void cbmemc_puts(struct stdio_dev *dev, const char *str)
> @@ -40,7 +50,6 @@ int cbmemc_init(void)
>  {
>         int rc;
>         struct stdio_dev cons_dev;
> -       cbmem_console_p =3D lib_sysinfo.cbmem_cons;
>
>         memset(&cons_dev, 0, sizeof(cons_dev));
>

Regards,
Bin
