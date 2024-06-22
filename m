Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D14EC27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 09:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A36387D10;
	Sat, 22 Jun 2024 11:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QnsImm2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FC0A87EED; Sat, 22 Jun 2024 11:52:14 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CBE387D10
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 11:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57d106e69a2so1454362a12.0
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 02:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1719049932; x=1719654732;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8aO0vATgO8HqA5mFeuiqpYqkAd11Ufve9SQRhGqcro=;
 b=QnsImm2hyhbB5aka+vAtllFKizXS+d6AmZc8RMPIP1VvZmRLnodaPHglRmJbU8/f2T
 NerUfS2w0tSoom7cX37I40B5IOodvIRZ7iOgnfNEG14dc2pk20kEygEbdmc+C7K/qHXt
 7lPFwNKn8ux+TJdxl3C/GVKLqxjCyrdzfoDG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719049932; x=1719654732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8aO0vATgO8HqA5mFeuiqpYqkAd11Ufve9SQRhGqcro=;
 b=IXnRyFONT/oUTQFL1zBMU6PkWEaq7rS9SKDfxCHRyHwvCME2O0Iz4EEfrgIh/x7eYO
 vNPYh0s/jne9l9ZWDV7TgsHnjQgRab+JyG2zdIuzuqERUIV9vDF/lM8Ycx5AiKRguEhi
 AY5SguiTyi7iVXaISTfDWHJ1rrn8Ab8ogbVBvDci7r1ZAqtV6tD3HFX08Vd/XqxdJYJh
 l4FR4WgiV92/gwtYDf3htqcl88ClPreefwPyg4kSovjh3ipGqcBlADWtTdAZE9Cv4Q8r
 lhnkkN9r+/hg/kO0DE0KHnXrT8wA3fppw3WQVCW1H28z5G8LSIOvGbUucmMQpY0+fGod
 xGaA==
X-Gm-Message-State: AOJu0Yyu73rGaY2TAl9AutKnnHr5Ybn4E2cOcPVJ9oUQlU0m/YmxQJpr
 SJH6qOPq90vBY+AkRVuZhOIwrDOxvJY316mb20k5UkwchdR0MFJI/ObZrPiRDmEa6DsiixTpw7n
 f48Q0IcxlRyMiPhDM7GaVJUvvGNSlX2mhgKeQGg==
X-Google-Smtp-Source: AGHT+IEyRDgnMwN8u8GdDvVN3+K5Su3tAiXMlyMC65v69340ix4poOv+OaqlXWzwuIdBzAcnc6/N/ffkwLQWzyCFvSk=
X-Received: by 2002:a50:d613:0:b0:57c:c171:2fb6 with SMTP id
 4fb4d7f45d1cf-57d44c01418mr702506a12.1.1719049931939; Sat, 22 Jun 2024
 02:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240619123453.720600-1-sjg@chromium.org>
In-Reply-To: <20240619123453.720600-1-sjg@chromium.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 22 Jun 2024 11:52:00 +0200
Message-ID: <CAOf5uwkhN6pjapQW1aHWK+qGvCdeHPao5cpKFvxmbpA3kL8u0w@mail.gmail.com>
Subject: Re: [PATCH 1/3] pxe: Add debugging for booting
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Paul Menzel <paulepanter@mailbox.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Marek Vasut <marex@denx.de>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>,
 Tom Rini <trini@konsulko.com>
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

On Wed, Jun 19, 2024 at 2:34=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Show which boot protocol is being used.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  boot/pxe_utils.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index 4b22bb6f525..53ddb16be73 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -4,6 +4,8 @@
>   * Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
>   */
>
> +#define LOG_CATEGORY   LOGC_BOOT
> +
>  #include <command.h>
>  #include <dm.h>
>  #include <env.h>
> @@ -762,17 +764,22 @@ static int label_boot(struct pxe_context *ctx, stru=
ct pxe_label *label)
>
>         /* Try bootm for legacy and FIT format image */
>         if (genimg_get_format(buf) !=3D IMAGE_FORMAT_INVALID &&
> -            IS_ENABLED(CONFIG_CMD_BOOTM))
> +           IS_ENABLED(CONFIG_CMD_BOOTM)) {
> +               log_debug("using bootm\n");
>                 do_bootm(ctx->cmdtp, 0, bootm_argc, bootm_argv);
>         /* Try booting an AArch64 Linux kernel image */
> -       else if (IS_ENABLED(CONFIG_CMD_BOOTI))
> +       } else if (IS_ENABLED(CONFIG_CMD_BOOTI)) {
> +               log_debug("using booti\n");
>                 do_booti(ctx->cmdtp, 0, bootm_argc, bootm_argv);
>         /* Try booting a Image */
> -       else if (IS_ENABLED(CONFIG_CMD_BOOTZ))
> +       } else if (IS_ENABLED(CONFIG_CMD_BOOTZ)) {
> +               log_debug("using bootz\n");
>                 do_bootz(ctx->cmdtp, 0, bootm_argc, bootm_argv);
>         /* Try booting an x86_64 Linux kernel image */
> -       else if (IS_ENABLED(CONFIG_CMD_ZBOOT))
> +       } else if (IS_ENABLED(CONFIG_CMD_ZBOOT)) {
> +               log_debug("using zboot\n");
>                 do_zboot_parent(ctx->cmdtp, 0, zboot_argc, zboot_argv, NU=
LL);
> +       }
>
>         unmap_sysmem(buf);
>
> --
> 2.34.1
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
