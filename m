Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F254C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 22:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89F5887E6F;
	Fri,  9 Feb 2024 23:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="e8HshNcD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A52987C13; Fri,  9 Feb 2024 23:19:57 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8163087E71
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 23:19:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5116643c64eso2444677e87.3
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 14:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707517195; x=1708121995; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jX1q+0308w70ABBa9F8mP1OwoiyJ6dI9xe1GVqQXjTQ=;
 b=e8HshNcD/tTxEjq+HrLFbS4/rXn9QRFXn0CtBmIQx0YqtnLxnyjQhoJeUjaJuEI9KF
 Vu6DAYTXJsG+fXeGHLFLgZgEASGb34e95/IPrwqe54qKVv52QX3v3JYHexmyhJJEwlq8
 PVOojZdHMYyWxi8Iv2q2Gv6Bn6v5OLuAFS890A0WHcPUp9W4dur+EObGwku4qkJTnhlT
 1pdpsZAS7TRZtptdzHO9Sp3FTSUNRnqARxr8gQU5BOXZSuoC9aEcbX4GZONq820CiBSh
 XHrzQJA7eR8LgyaB9fYjHGewWbZzJb5xozZYVsSjQ3aRe/4dTeW3IDDQF5aJ5url9G19
 rluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707517195; x=1708121995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jX1q+0308w70ABBa9F8mP1OwoiyJ6dI9xe1GVqQXjTQ=;
 b=su9kwe15J4Sz+g9F/7xsBbj3LQ0nXw6jBckqMuqXwtZ14pfWoQCl5dXhGy5CrCuy8z
 90cB7hCKXmDTDh9JsWCSp4LQSkBa7nSZEnG6NdHTJLYH4E3j/G8Oo45DpkdKF7LCPCIu
 L/75+hQJczsMRZcr0Bx9jIXwrWIOKpy8b2pssqM+S5r9Jx6XdMFVMXnhquuA0xdvFU83
 bcf55WgX3zFE/SLl1XAMDZdZZTfHoeetrFolOKefQ2D8fR1y+OkDl+RX0EQaTMzwnQqT
 VFCaAHCsvED1nTNZmWYF7OA8cX1TahI/ffoi9gryO/aSZJ8avdG4KFU9OOGzxwclB6MW
 Fh4g==
X-Gm-Message-State: AOJu0YyyyzqzsKsCcFDEWKoQgnbmdPoZiAjrtP5DwMhUvAnLP94C6Q6S
 5X6maGFM2j1JOx30ytXuIbY697Dy4v6ywMyaias0qqNbURY1iBkuISkB28OVUBywSMSSgPm+AU0
 99SSfGT8Z//eTSk2MAmgYiCuA6lcQA9okZZ8SjA==
X-Google-Smtp-Source: AGHT+IG7Ex0RJgKqZGWkmbFv1I+AczqwV0IECMdJlUTZo+zbTgIKU43Rx+ABK6KyXjLdUlHN3+R2Jsc0GzhNnpvtknc=
X-Received: by 2002:ac2:41c4:0:b0:511:7a72:6524 with SMTP id
 d4-20020ac241c4000000b005117a726524mr221278lfi.15.1707517194795; Fri, 09 Feb
 2024 14:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20240209103009.5463-1-othacehe@gnu.org>
 <20240209103009.5463-2-othacehe@gnu.org>
In-Reply-To: <20240209103009.5463-2-othacehe@gnu.org>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Fri, 9 Feb 2024 23:19:42 +0100
Message-ID: <CAL6CDMHEbn3THePnu8iykJ-z=1KnauU6j0ijQVEAweRPGV1FiA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] imx93: Use a header for imx9_probe_mu declaration
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>, 
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, u-boot@lists.denx.de
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

On Fri, Feb 9, 2024 at 1:05=E2=80=AFPM Mathieu Othacehe <othacehe@gnu.org> =
wrote:
>
> Put imx9_probe_mu declaration in a new mu.h header file.
>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>  arch/arm/include/asm/arch-imx9/mu.h | 13 +++++++++++++
>  board/freescale/imx93_evk/spl.c     |  2 +-
>  board/phytec/phycore_imx93/spl.c    |  2 +-
>  3 files changed, 15 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/include/asm/arch-imx9/mu.h
>
> diff --git a/arch/arm/include/asm/arch-imx9/mu.h b/arch/arm/include/asm/a=
rch-imx9/mu.h
> new file mode 100644
> index 00000000000..b8604992914
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-imx9/mu.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + */
> +
> +#ifndef __ARCH_IMX9_MU_H
> +#define __ARCH_IMX9_MU_H
> +
> +#include <event.h>
> +
> +int imx9_probe_mu(void *ctx, struct event *event);
> +
> +#endif
> diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/=
spl.c
> index be9c24fc0d9..a98ed69db88 100644
> --- a/board/freescale/imx93_evk/spl.c
> +++ b/board/freescale/imx93_evk/spl.c
> @@ -14,6 +14,7 @@
>  #include <asm/global_data.h>
>  #include <asm/io.h>
>  #include <asm/arch/imx93_pins.h>
> +#include <asm/arch/mu.h>
>  #include <asm/arch/clock.h>
>  #include <asm/arch/sys_proto.h>
>  #include <asm/mach-imx/boot_mode.h>
> @@ -91,7 +92,6 @@ int power_init_board(void)
>  }
>  #endif
>
> -extern int imx9_probe_mu(void *ctx, struct event *event);
>  void board_init_f(ulong dummy)
>  {
>         int ret;
> diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx9=
3/spl.c
> index da4b9e53594..dabc5316f33 100644
> --- a/board/phytec/phycore_imx93/spl.c
> +++ b/board/phytec/phycore_imx93/spl.c
> @@ -7,6 +7,7 @@
>
>  #include <asm/arch/clock.h>
>  #include <asm/arch/ddr.h>
> +#include <asm/arch/mu.h>
>  #include <asm/arch/sys_proto.h>
>  #include <asm/arch/trdc.h>
>  #include <asm/mach-imx/boot_mode.h>
> @@ -99,7 +100,6 @@ int power_init_board(void)
>         return 0;
>  }
>
> -extern int imx9_probe_mu(void *ctx, struct event *event);
>  void board_init_f(ulong dummy)
>  {
>         int ret;
> --
> 2.41.0
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
