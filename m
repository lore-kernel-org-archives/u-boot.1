Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD78C71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 03:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76894867F7;
	Mon,  4 Sep 2023 05:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VOC07iLL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11CAA86867; Mon,  4 Sep 2023 05:46:26 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74A7D86758
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 05:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52a4737a08fso1218842a12.3
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 20:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693799183; x=1694403983; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4Bp+59tuyHo+78KDoYi9QeqLZdbEI6/Yr5zbu6kuis=;
 b=VOC07iLLJ0WaY0J8it05LVYC0ZiB9PL3SFV3G23hGJVAmsIektmRqpusmv8D+Hvnxv
 AFLMK5SlQ2wMlul1MmlC1SysWmtsGc5sSNNeJFuvrRfVlEXHlkYJ2hDuow3MAwX2AqOW
 SbpoowQPWgnaa6elBI7SMCtirgVzqaZVayw+PSajDuT5nR/twwLaQwpz5W9/b1cfDEBT
 BK+O8RAgZxYxGkx2wMJ81jRbvN6ZoyUfVszkp204XJiIdmFenG1HW2gxoEEwH67KGyv1
 uvI4jvD5r5WDRvuQjNFu0cPu27KsoOO153OUcQ6tRDzd0Lk65uXzm5WiQoPnjAToJ/gj
 w55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693799183; x=1694403983;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4Bp+59tuyHo+78KDoYi9QeqLZdbEI6/Yr5zbu6kuis=;
 b=LqmXP7em+cU6FDtT1TZvSh8H9BiHrhcvtuOGJf9jf6qT2TSYEDK25NHbZrKEGx1pk5
 K/k8hV+gETvXfSdOQwjGM5cYyEyNMy7MRVUYyjw1M8neeTTr3lG+LF9VGLpdOBVAtEok
 f2lb2w5TFMztbGNbuyQI/ARfZ98nl5yZVYxLGceedTVdMvG6R7hMkL8MXIhW1nITLst/
 CabIZXn2Gl2z1KqCO7Ag93rGmgpEv0ATRMSnli/FW491BpvYZtbjiAIt0F/L/Wc7rn7y
 lUzYfGFpzRHLb3631DMznV/UKctGCy6Xvwsp906l3ArWz86+jOhob0ORwMDyMLUWP8Rc
 3vqQ==
X-Gm-Message-State: AOJu0YwM2hgscbuuBz1DaPeUYJQvDlt1r2PEEZ+42/8SsbVlm7RQ35GV
 7J0g3JRaUo8BGqed4+rnw+/eQ5ouF1nBEP3tqRo=
X-Google-Smtp-Source: AGHT+IHu7vQanqFcg9Q4vxNguACDsZUzIpiwTpwHDvQYzKZo+Fm84c+shL3tCaDhAmXUuDRTmdwyLtRc4vka0xnllWQ=
X-Received: by 2002:a05:6402:2c4:b0:525:6772:1595 with SMTP id
 b4-20020a05640202c400b0052567721595mr6237104edx.6.1693799182626; Sun, 03 Sep
 2023 20:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230817015754.776507-1-sjg@chromium.org>
 <20230817015754.776507-2-sjg@chromium.org>
In-Reply-To: <20230817015754.776507-2-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 4 Sep 2023 11:46:09 +0800
Message-ID: <CAEUhbmX0D7DnhsPZrKHk3AHjomvVZrtJdonkWpxGeDTZbjhsQQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86: Update cbmem driver
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 Nable <nable.maininbox@googlemail.com>, Coreboot ML <coreboot@coreboot.org>, 
 Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
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

On Thu, Aug 17, 2023 at 9:58=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
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
> (no changes since v2)
>
> Changes in v2:
> - Update to support the new overflow mechanism
>
>  drivers/misc/Kconfig         |  8 ++++++++
>  drivers/misc/cbmem_console.c | 38 +++++++++++++++++++-----------------
>  2 files changed, 28 insertions(+), 18 deletions(-)
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
> index 8bbe33d414da..7a47a814f638 100644
> --- a/drivers/misc/cbmem_console.c
> +++ b/drivers/misc/cbmem_console.c
> @@ -5,27 +5,30 @@
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
> -
> -       cursor =3D cbmem_console_p->buffer_cursor++;
> -       if (cursor < cbmem_console_p->buffer_size)
> -               cbmem_console_p->buffer_body[cursor] =3D data;
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
> +       flags =3D cons->cursor & ~CBMC_CURSOR_MASK;

This line does not seem useful to me, as we don't use the extracted
flag from the higher bits of cons->cursor.

I guess we can just drop it.

> +
> +       cons->body[pos++] =3D data;
> +       if (pos >=3D cons->size) {
> +               pos =3D 0;
> +               flags |=3D CBMC_OVERFLOW;

Who is supposed to clear the overflow flag?

> +       }
> +
> +       cons->cursor =3D flags | pos;
>  }
>
>  void cbmemc_puts(struct stdio_dev *dev, const char *str)
> @@ -40,7 +43,6 @@ int cbmemc_init(void)
>  {
>         int rc;
>         struct stdio_dev cons_dev;
> -       cbmem_console_p =3D lib_sysinfo.cbmem_cons;
>
>         memset(&cons_dev, 0, sizeof(cons_dev));
>
> --

Regards,
Bin
