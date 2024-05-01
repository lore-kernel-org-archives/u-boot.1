Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7EAC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 16:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5845A88B5F;
	Wed,  1 May 2024 18:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="MeNbJIa7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84CA088B5B; Wed,  1 May 2024 18:06:49 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BC7488B56
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 18:06:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a55b3d57277so842539866b.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 09:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1714579605; x=1715184405; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8zMjTJcd1poWYR+oyB2OtLAGvcn5r+Y0ltXjN3HAOc=;
 b=MeNbJIa7Kw0U+6ZggUgZfXz+NjY4vsPZ3uqWbMSqKvGI27HDmnISGwWwdfraGuJRKN
 WjHACxSh8ODan10v7qaAIu/Q9jg3aMEZo42iBzct3u5Ka5ha1j+Lv04tF0vojgDU6/NH
 QSUL4kYqBe+xqnhXJ5ewL6ODkAzprSAOd47Q/nqPjMhZp6dSGpTgO5heNknE9JujwZS9
 GSW8XWr7CI63m4MRR06vqSy6UpzVFAzWwGtYXvImHiAGPSxogubLSmJzYOq8F0n4w6y3
 bgGG0s4JV9E/OSmRr5Ipl3VKuFjZkA0yKCeXylak49m8C5OW4/fUT76fAFJw2SdaOiOr
 O87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714579605; x=1715184405;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8zMjTJcd1poWYR+oyB2OtLAGvcn5r+Y0ltXjN3HAOc=;
 b=KqfguPwWj8gg2BHiJvk41HYxD2GC1CfUvUJNwxa4AM7wiBscZIn2B5/jNtNn7zIuqZ
 ijfb7qxH4i//ZVi2LzM92tLOtW6XtCctgh2Er8mWJ9+Jjlw4JfVt0ZT3ocBYa0S8Sgtt
 WUum1ZTFxnLIHv/pGI1ft71tX2oI55M9t2eB/rjgpjyiZJqlCVyRZ9SipifNiaAfBWrI
 bHP5CJlZhxsDYSsUF2CZF3MxrRYhsHK3lloI8fNsfxRHlNUjwpfDiM6YpoKDvpA0tVtL
 l8nZNYDmYJ594TG8i8EE16OXGeiHb2cfrTNrFCbDcH2EeDLsij47rVYbA2suNJ5lSFRZ
 I9tQ==
X-Gm-Message-State: AOJu0YzthtvzJi3+BG+W0hfkpvEn/B+GSsbI0zLvurCWFDjoqhr30lzT
 PK2dogfXjvD3TFDj7WT6v204h6rLDWWDy3hkHqtgEBoPpc2XBgRIHmcGmEfrOEYcwAucKO4Jexo
 Q4SoEl+i/B5mF9FkL5Gx85+IHcAJPpRYjrjK5uw==
X-Google-Smtp-Source: AGHT+IFWq0gqu02bhka14+xeliVQWyY/8pugkkMCd16GfOvL1h0ValU6BimhYS98ytWKGuSK6Lmuf5Hoa96OOsGF7XE=
X-Received: by 2002:a17:906:494d:b0:a58:c743:9ea9 with SMTP id
 f13-20020a170906494d00b00a58c7439ea9mr2016959ejt.1.1714579604719; Wed, 01 May
 2024 09:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-64-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-64-trini@konsulko.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 1 May 2024 09:06:33 -0700
Message-ID: <CAJ+vNU2hXOk0jgNWeqogQEaTP2AvU_qSy9ddjF1wFkBgTQKhRg@mail.gmail.com>
Subject: Re: [PATCH 064/149] board: gateworks: Remove <common.h> and add
 needed includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Tue, Apr 30, 2024 at 7:44=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Tim Harvey <tharvey@gateworks.com>
> ---
>  board/gateworks/gw_ventana/common.c           | 1 -
>  board/gateworks/gw_ventana/eeprom.c           | 1 -
>  board/gateworks/gw_ventana/gw_ventana.c       | 1 -
>  board/gateworks/gw_ventana/gw_ventana_spl.c   | 2 +-
>  board/gateworks/venice/eeprom.c               | 1 -
>  board/gateworks/venice/lpddr4_timing_imx8mm.c | 1 -
>  board/gateworks/venice/spl.c                  | 1 -
>  7 files changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/board/gateworks/gw_ventana/common.c b/board/gateworks/gw_ven=
tana/common.c
> index 74328b2e1b31..891d1b5ddcaa 100644
> --- a/board/gateworks/gw_ventana/common.c
> +++ b/board/gateworks/gw_ventana/common.c
> @@ -5,7 +5,6 @@
>   * Author: Tim Harvey <tharvey@gateworks.com>
>   */
>
> -#include <common.h>
>  #include <env.h>
>  #include <fsl_esdhc_imx.h>
>  #include <hwconfig.h>
> diff --git a/board/gateworks/gw_ventana/eeprom.c b/board/gateworks/gw_ven=
tana/eeprom.c
> index e622a9ba9e4d..b37f19722491 100644
> --- a/board/gateworks/gw_ventana/eeprom.c
> +++ b/board/gateworks/gw_ventana/eeprom.c
> @@ -5,7 +5,6 @@
>   */
>
>  #include <command.h>
> -#include <common.h>
>  #include <gsc.h>
>  #include <hexdump.h>
>  #include <i2c.h>
> diff --git a/board/gateworks/gw_ventana/gw_ventana.c b/board/gateworks/gw=
_ventana/gw_ventana.c
> index 683def7e9f71..21a908c20dd5 100644
> --- a/board/gateworks/gw_ventana/gw_ventana.c
> +++ b/board/gateworks/gw_ventana/gw_ventana.c
> @@ -6,7 +6,6 @@
>   */
>
>  #include <command.h>
> -#include <common.h>
>  #include <fdt_support.h>
>  #include <gsc.h>
>  #include <hwconfig.h>
> diff --git a/board/gateworks/gw_ventana/gw_ventana_spl.c b/board/gatework=
s/gw_ventana/gw_ventana_spl.c
> index 2f046c9c0b3e..3de4727b2edf 100644
> --- a/board/gateworks/gw_ventana/gw_ventana_spl.c
> +++ b/board/gateworks/gw_ventana/gw_ventana_spl.c
> @@ -4,7 +4,7 @@
>   * Author: Tim Harvey <tharvey@gateworks.com>
>   */
>
> -#include <common.h>
> +#include <config.h>
>  #include <env.h>
>  #include <gsc.h>
>  #include <hang.h>
> diff --git a/board/gateworks/venice/eeprom.c b/board/gateworks/venice/eep=
rom.c
> index 241be4ee630b..afaabf348793 100644
> --- a/board/gateworks/venice/eeprom.c
> +++ b/board/gateworks/venice/eeprom.c
> @@ -3,7 +3,6 @@
>   * Copyright 2021 Gateworks Corporation
>   */
>
> -#include <common.h>
>  #include <gsc.h>
>  #include <hexdump.h>
>  #include <i2c.h>
> diff --git a/board/gateworks/venice/lpddr4_timing_imx8mm.c b/board/gatewo=
rks/venice/lpddr4_timing_imx8mm.c
> index 78b431dc2844..3f2c090a94fc 100644
> --- a/board/gateworks/venice/lpddr4_timing_imx8mm.c
> +++ b/board/gateworks/venice/lpddr4_timing_imx8mm.c
> @@ -6,7 +6,6 @@
>   */
>
>  #include <linux/kernel.h>
> -#include <common.h>
>  #include <asm/arch/ddr.h>
>  #include <asm/arch/lpddr4_define.h>
>
> diff --git a/board/gateworks/venice/spl.c b/board/gateworks/venice/spl.c
> index b0a315ba9531..f10d310a46d4 100644
> --- a/board/gateworks/venice/spl.c
> +++ b/board/gateworks/venice/spl.c
> @@ -3,7 +3,6 @@
>   * Copyright 2021 Gateworks Corporation
>   */
>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <hang.h>
>  #include <i2c.h>
> --
> 2.34.1
>

Acked-By: Tim Harvey <tharvey@gateworks.com>

Tim
