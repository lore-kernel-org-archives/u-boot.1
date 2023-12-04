Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF8EC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 10:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D52487538;
	Mon,  4 Dec 2023 11:28:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VB5sGWB8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 088068771F; Mon,  4 Dec 2023 11:28:08 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E72FE870D4
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 11:28:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alex.kiernan@gmail.com
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-35d67599613so11335135ab.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 02:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701685684; x=1702290484; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E0LjNOpXQY1XWp/CQagg9GYQgTfMGAd4dWwl2Wu06dg=;
 b=VB5sGWB8fP9qtQ7P+UMi34VLRJXUEJmL2zGo1YJswiGEvW/xfFI/IUnMOWW7YEHNO9
 SmFp9UTsDK74qrq5JnmIzDOMOhThK1jBooxumN8gKC0sZdBx5ZvUdjdlTghi68Eeqn7s
 KoQALKi+jimnbMOWG7Obi5mdUs56KLsVDNH0cOpdT5kHmH0Qhz2k/vUAvBNTM2e3NikU
 rNuROpmP3HesUgEZAF2C1sE5wUdBIoZm+nWBkODrBvYodfKYXGw8+NssO8VD8cTj/YRL
 Z40/tg11xe0q1PUq9Vf6drKGN05qNGjpKu5mkWjRNSu4ReXvmuCyzMTAjFjZaB/KPpMI
 SJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701685684; x=1702290484;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E0LjNOpXQY1XWp/CQagg9GYQgTfMGAd4dWwl2Wu06dg=;
 b=agCdVyXpZMgQ2/jYC+6nJC2uW9I4cxXtx5IsMl9lvWG+XYRXqXOgeFhD4XLjWzjgEN
 cGrtdYkQp1+uXVraY9Jy37flOM55O4fwqV/g+sofCAPEQxxMS2KSMDOQCLbDuebS6fLx
 viyg/osDAMS2R4FFXXAy6mAGcLCF/GBG3dFwCHPDTkpmBEHWL7fzu9upFc7/KyLX7vAu
 xOgZzD8VtvvWOu6kdePFDC5TT2/KjgqCNggVe3W+m1lB+kz4EtLGrUqf4d4D2yy/pniH
 1BWj2uPiG5P6X8OdBYLiqfjsatIUoFeUMnD/7IZYy/HSFiDdZIbjCz0xjyIEIjOWVKji
 EYGw==
X-Gm-Message-State: AOJu0YzXnbt+KiAHxOGgFiGetXIshE8ePK013pnaB0Ivp7I8ENP3PpJN
 Gk9tviUiE6IJ/I+FvGQguXaM7gY3pgtdaTA29T4=
X-Google-Smtp-Source: AGHT+IEXF5KaquNuUs8Gq6GzJnNr+BgABMhKQlxdHS1ZwFe4d60y/i7QEiR80JHx5j80PPLd8X117+MC9YvJ+3AJd6E=
X-Received: by 2002:a92:d489:0:b0:35d:72ba:8bff with SMTP id
 p9-20020a92d489000000b0035d72ba8bffmr938687ilg.69.1701685684590; Mon, 04 Dec
 2023 02:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20231204003144.899097-1-sjg@chromium.org>
 <20231204003144.899097-8-sjg@chromium.org>
In-Reply-To: <20231204003144.899097-8-sjg@chromium.org>
From: Alex Kiernan <alex.kiernan@gmail.com>
Date: Mon, 4 Dec 2023 10:27:53 +0000
Message-ID: <CAO5Uq5Tow3D1THezrX5bFhM+0n+Dd8=ESQA5owHLLERMCjKkRQ@mail.gmail.com>
Subject: Re: [PATCH 08/14] fastboot: Remove dependencies on CMDLINE
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Heiko Schocher <hs@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Samuel Holland <samuel@sholland.org>, 
 Sean Anderson <sean.anderson@seco.com>
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

On Mon, Dec 4, 2023 at 1:31=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> It is possible to boot a kernel without CMDLINE being enabled. Update
> the implementation to handle this, and drop the condition from the
> FASTBOOT config.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  drivers/fastboot/Kconfig     |  1 -
>  drivers/fastboot/fb_common.c | 26 ++++++++++++--------------
>  2 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 11fc0fe1c800..837c6f1180da 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -1,5 +1,4 @@
>  menu "Fastboot support"
> -       depends on CMDLINE
>
>  config FASTBOOT
>         bool
> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> index 07f5946d9ed1..85935380e79d 100644
> --- a/drivers/fastboot/fb_common.c
> +++ b/drivers/fastboot/fb_common.c
> @@ -11,6 +11,7 @@
>   */
>
>  #include <bcb.h>
> +#include <bootm.h>
>  #include <common.h>
>  #include <command.h>
>  #include <env.h>
> @@ -144,20 +145,17 @@ void fastboot_boot(void)
>  {
>         char *s;
>
> -       s =3D env_get("fastboot_bootcmd");
> -       if (s) {
> -               run_command(s, CMD_FLAG_ENV);
> -       } else if (IS_ENABLED(CONFIG_CMD_BOOTM)) {
> -               static char boot_addr_start[20];
> -               static char *const bootm_args[] =3D {
> -                       "bootm", boot_addr_start, NULL
> -               };
> -
> -               snprintf(boot_addr_start, sizeof(boot_addr_start) - 1,
> -                        "%lx", fastboot_buf_addr);
> -               printf("Booting kernel at %s...\n\n\n", boot_addr_start);
> -
> -               do_bootm(NULL, 0, 2, bootm_args);
> +       if (IS_ENABLED(CONFIG_CMDLINE)) {
> +               s =3D env_get("fastboot_bootcmd");
> +               if (s) {
> +                       run_command(s, CMD_FLAG_ENV);
> +                       return;
> +               }
> +       } else if (IS_ENABLED(CONFIG_BOOTM)) {
> +               int ret;
> +
> +               printf("Booting kernel at %lx...\n\n\n", fastboot_buf_add=
r);
> +               ret =3D bootm_boot_start(fastboot_buf_addr, NULL);
>
>                 /*
>                  * This only happens if image is somehow faulty so we sta=
rt
> --

Doesn't this change the logic? Previously if you didn't set
fastboot_bootcmd you'd fall into the bootm path (if CONFIG_BOOTM was
enabled), with this, if CONFIG_CMDLINE is enabled then you will never
hit the bootm path.

--=20
Alex Kiernan
