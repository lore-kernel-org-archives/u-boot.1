Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A84CC25B77
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 02:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32E94882DF;
	Tue, 21 May 2024 04:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jrlw95xL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D069388306; Tue, 21 May 2024 04:31:54 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90D3088027
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 04:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcmvbkbc@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1eecc71311eso94999075ad.3
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716258711; x=1716863511; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WjtvgQjVoGBFzQe3NlBH1WsS5ONTHZ8zstlnVBxx7+g=;
 b=Jrlw95xLmj9vphtJ6cKRb05Xxf1AgPMyYM4z/iJCw7XPD5zkgYfdmA5kDUETD8iBkl
 eIU6Yd49W8YLtrDzbbR58qbVvsEXgw92TjglBmrwuGT9iq+mMDrZt7ftTn5WS4C+nQ5S
 QI9iOV/ogMEt6bDRVVDmSxxZivQ9SdGyYrHGPU/3vYXfpjYkdBNpH4Y8giZoz3jH6vS3
 bIokWXDO65pPfGpIKUm7KLiuYjJiUzA/M2+d6D3il5K3WCRSX5DX9eWS3gJGtaAK7yGC
 Ho+glkpx0nwqs7mnJE1JMX84PqDNzCrHWVg188KMYoLOW2GvnIE2YLuozqqknYy9GoPo
 r7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716258711; x=1716863511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WjtvgQjVoGBFzQe3NlBH1WsS5ONTHZ8zstlnVBxx7+g=;
 b=nelkbY1Wek1OAzR95KeL1fOYlABn1MaWOxmxb9ODdlw9huiIK/6Qe+kiolu/Gwwiq+
 xq5y3pWcSmjdug2TfQQz/YhZq0fB/ZbvHProdDgGa+j82VlS3G0p9z7IAybVbLChPRty
 lcFLiA9gh+Jfu4wtJ2yoe6PDBBYDg4lfUvAgvcvY6OcUpXlXeLZmRe1fseZ+gaPcBAvt
 RTl5tlCBdJYWkHwKKj0yBJ/SeRZdCXdG7d3i82HHymtcO0S7Tw/J7eA+BBBTDbPXQvnL
 fH7+aYfKG5kZsyzpYZOnBqylGB+j6PIswV4fuBlra8U8pebFnDZaWwwe/+0b4hzO1gD7
 8QFw==
X-Gm-Message-State: AOJu0Yw6npVKm6EgZT4gljf0SZV2ifOse1YrBgBbBh6BXvdB/DkDtA23
 AQ1TxALYofGuDVdtTV9YMdnn7kj0FuRTbjzDpVZ1fsFvXduu0Oojp/BtUYeOyd6agG1fstkmbQ1
 WNeUr1uP++RuNPhwHPfKmLNBjW+8=
X-Google-Smtp-Source: AGHT+IH9Xovi+EX07LWb8VJhb5mK/mYRUsPoWXNK/MAfmMi1I+DxTSZFA91o0pHf+B+gKdTujrCcPgbhkNQLnPxWxdI=
X-Received: by 2002:a05:6a20:971a:b0:1a7:5780:1f4b with SMTP id
 adf61e73a8af0-1afde0bc489mr35652914637.24.1716258710990; Mon, 20 May 2024
 19:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
 <20240519-qemu-xtensa-v1-6-8fff0cb11c19@flygoat.com>
In-Reply-To: <20240519-qemu-xtensa-v1-6-8fff0cb11c19@flygoat.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 20 May 2024 19:31:40 -0700
Message-ID: <CAMo8Bf+HoyoDiKBVDkWeB=NLVO2zuYWbquk+2rp3znsUEor6pw@mail.gmail.com>
Subject: Re: [PATCH 06/10] drivers: serial: Add xtensa semihosting driver
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>, 
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
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

On Sun, May 19, 2024 at 1:53=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
> Add xtensa semihosting driver.
>
> It can't use regular semihosting driver as Xtensa's has it's own
> semihosting ABI.
>
> Note that semihosting supports puts in serial but I never managed to
> get it work, so it's putc only for now.

I wonder, what were the issues that you experienced?

> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  drivers/serial/Kconfig                     | 18 ++++++-
>  drivers/serial/Makefile                    |  1 +
>  drivers/serial/serial_xtensa_semihosting.c | 79 ++++++++++++++++++++++++=
++++++
>  3 files changed, 97 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 1fe4607598eb..3a1e5a6f2877 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -501,6 +501,15 @@ config DEBUG_UART_MT7620
>           driver will be available until the real driver model serial is
>           running.
>
> +config DEBUG_UART_XTENSA_SEMIHOSTING
> +       bool "Xtensa semihosting"
> +       depends on XTENSA_SEMIHOSTING_SERIAL
> +       help
> +         Select this to enable the debug UART using the Xtensa semihosti=
ng driver.
> +         This provides basic serial output from the console without need=
ing to
> +         start up driver model. The driver will be available until the r=
eal
> +         driver model serial is running.
> +
>  endchoice
>
>  config DEBUG_UART_BASE
> @@ -936,7 +945,6 @@ config SH_SCIF_CLK_FREQ
>  config SEMIHOSTING_SERIAL
>         bool "Semihosting UART support"
>         depends on SEMIHOSTING && !SERIAL_RX_BUFFER
> -       imply SERIAL_PUTS
>         help
>           Select this to enable a serial UART using semihosting. Special =
halt
>           instructions will be issued which an external debugger (such as=
 a
> @@ -1115,6 +1123,14 @@ config XEN_SERIAL
>           If built without DM support, then requires Xen
>           to be built with CONFIG_VERBOSE_DEBUG.
>
> +config XTENSA_SEMIHOSTING_SERIAL
> +       bool "Xtensa Semihosting UART support"
> +       depends on DM_SERIAL
> +       depends on XTENSA_SEMIHOSTING
> +       imply SERIAL_PUTS
> +       help
> +         Select this to enable a serial UART using Xtensa semihosting.
> +
>  choice
>         prompt "Console port"
>         default 8xx_CONS_SMC1
> diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
> index dbe598b74064..78810f98367c 100644
> --- a/drivers/serial/Makefile
> +++ b/drivers/serial/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_MT7620_SERIAL) +=3D serial_mt7620.o
>  obj-$(CONFIG_HTIF_CONSOLE) +=3D serial_htif.o
>  obj-$(CONFIG_SIFIVE_SERIAL) +=3D serial_sifive.o
>  obj-$(CONFIG_XEN_SERIAL) +=3D serial_xen.o
> +obj-$(CONFIG_XTENSA_SEMIHOSTING_SERIAL) +=3D serial_xtensa_semihosting.o
>  obj-$(CONFIG_S5P4418_PL011_SERIAL) +=3D serial_s5p4418_pl011.o
>
>  ifndef CONFIG_SPL_BUILD
> diff --git a/drivers/serial/serial_xtensa_semihosting.c b/drivers/serial/=
serial_xtensa_semihosting.c
> new file mode 100644
> index 000000000000..1bf3c18537e7
> --- /dev/null
> +++ b/drivers/serial/serial_xtensa_semihosting.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + */
> +
> +#include <dm.h>
> +#include <malloc.h>
> +#include <serial.h>
> +
> +#include <asm/platform/simcall.h>
> +
> +/**
> + * struct simc_serial_priv - Semihosting serial private data
> + * @counter: Counter used to fake pending every other call
> + */
> +struct simc_serial_priv {
> +       unsigned int counter;
> +};
> +
> +static int simc_serial_getc(struct udevice *dev)
> +{
> +       char ch =3D 0;
> +
> +       simc_read(0, &ch, sizeof(ch));
> +
> +       return ch;
> +}
> +
> +static int simc_serial_putc(struct udevice *dev, const char ch)
> +{
> +       char str[2] =3D {0};

Why does it need to be an array if only the first element is ever used?

> +
> +       str[0] =3D ch;
> +       simc_write(1, str, 1);
> +
> +       return 0;
> +}
> +
> +static int simc_serial_pending(struct udevice *dev, bool input)
> +{
> +       struct simc_serial_priv *priv =3D dev_get_priv(dev);
> +
> +       if (input)
> +               return priv->counter++ & 1;

This can result in blocking the whole CPU thread of the emulator when
used with simcall-based semihosting and there's no input actually available=
.
Not sure how it would behave with the gdbio. I think something like
the following:

if (input) {
    int res =3D simc_poll(0);
    return res < 0 ? priv->counter++ & 1 : res;
}

could be used here to avoid that.

> +       return false;
> +}
> +
> +static const struct dm_serial_ops simc_serial_ops =3D {
> +       .putc =3D simc_serial_putc,
> +       .getc =3D simc_serial_getc,
> +       .pending =3D simc_serial_pending,
> +};
> +
> +U_BOOT_DRIVER(simc_serial) =3D {
> +       .name   =3D "serial_xtensa_semihosting",
> +       .id     =3D UCLASS_SERIAL,
> +       .priv_auto =3D sizeof(struct simc_serial_priv),
> +       .ops    =3D &simc_serial_ops,
> +       .flags  =3D DM_FLAG_PRE_RELOC,
> +};
> +
> +U_BOOT_DRVINFO(simc_serial) =3D {
> +       .name =3D "serial_xtensa_semihosting",
> +};
> +
> +#if CONFIG_IS_ENABLED(DEBUG_UART_XTENSA_SEMIHOSTING)
> +#include <debug_uart.h>
> +
> +static inline void _debug_uart_init(void)
> +{
> +}
> +
> +static inline void _debug_uart_putc(int c)
> +{
> +       simc_serial_putc(NULL, c);
> +}
> +
> +DEBUG_UART_FUNCS
> +#endif
>
> --
> 2.43.0
>


--=20
Thanks.
-- Max
