Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F606C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:53:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76A0887EEB;
	Mon, 12 Feb 2024 14:53:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gKpnvqWO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 309A987EED; Mon, 12 Feb 2024 14:53:41 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E9CE87CC2
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 14:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55c2cf644f3so4191096a12.1
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 05:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707746017; x=1708350817; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zlp7U8N+Z2D626qTkp0uBMHY7gqgFyv48MfDPFiTnek=;
 b=gKpnvqWO6Q8hSvJgNkZp8MowTw+hJuA2l9eDfExoLxTk7l5HQB1ze7Lgu/R6skEulC
 WBVLK0z4cVfODY6yp1ivDdjGLTM5lIe6Mu0pXwK+cLgM2x8UhWKPXpgfxJviEZiHCW9G
 MUx/BS1OOnooeW39BrEnIuWLO4FRMjhRzU67HhWzjSdNMh/VSttVp5HikamhHir6laCB
 2OElrWotd9A7QFtaFQTmx2FyWTB6i64cl+92Gzk+bl1q/aMIdT/QdQSAKit3fYlBbzZc
 F9JAGC3aGPhVDu+xyUWbWR8msfV7UzB1herRJAR8boMfgu8JO3zMn7wuwMNH7L20l9LS
 B6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707746017; x=1708350817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zlp7U8N+Z2D626qTkp0uBMHY7gqgFyv48MfDPFiTnek=;
 b=CSUbkbBfht/O6kSQxpPCm2Gnom3gJVzHGI+9Xc/z80PztLN8HbiXxAikrPtuqUG7I0
 WL2jIf/Ab2h1yDfKvIV3g21Hn/5dKaQPCIYv2hIzaGENcvfdy/zHF+jM1OBE8kMwTLwv
 6EmLZ3YuVzFe6IA/TzETPhZim9n0Y+upw+6ubJmOBla9bu915rVyNz6FsWiH/0tr+Src
 2ZE2XZqdAYwCTspnswx60k881pZg6wHmKTFPz+POApo5cj+0RI2w7Awqe5y+iZs161oX
 iOOdtSwbymgVstcs/yS4FSqcdYEprDADrmQN7rMdzljqB/oxcZhcsi2L/n2urQdnc4z+
 NmWg==
X-Gm-Message-State: AOJu0YxaY1dtUIXKQ3FLSBbn9kv69TFkEEDxRiLbCsda+tZ2eHtxshJb
 a1ylTpypBNAjhFFsn+5cKY8b7mAGpOLOfEcaLxbVwSi+o37ebbOzlrEZtF7SJzZElMg6rf4+Jk5
 0/vTSV3Ob0BulW61abs4bUxRgztM=
X-Google-Smtp-Source: AGHT+IGFWW6burAfoVNDFauWpmKhX1P8zH5n282XWO4Tys85X5xVM5Y5bnLjpNqA+xYH0EiyH2NEwVZ04Rg5f2vYE8w=
X-Received: by 2002:aa7:d8c6:0:b0:560:5f1e:f416 with SMTP id
 k6-20020aa7d8c6000000b005605f1ef416mr4491607eds.32.1707746016581; Mon, 12 Feb
 2024 05:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
 <20240209-jaguar-v2-10-6c9ffe09b924@theobroma-systems.com>
In-Reply-To: <20240209-jaguar-v2-10-6c9ffe09b924@theobroma-systems.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 12 Feb 2024 13:53:25 +0000
Message-ID: <CALeDE9OomFFtrdHrkrswe+1d0h6RzHGEoVB-1x4tnMfmvJX9jA@mail.gmail.com>
Subject: Re: [PATCH v2 10/20] rockchip: transform
 rockchip_capsule_update_board_setup into a weak function symbol
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>,
 Dragan Simic <dsimic@manjaro.org>, 
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 9 Feb 2024 at 09:50, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> There's only one user of rockchip_capsule_update_board_setup, which is
> in board.c, and only one board defines it, so instead of having a header
> only for one function symbol, let's just use a weak symbol instead.

Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  arch/arm/include/asm/arch-rockchip/misc.h | 9 ---------
>  arch/arm/mach-rockchip/board.c            | 5 ++++-
>  2 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/misc.h b/arch/arm/include/asm/arch-rockchip/misc.h
> deleted file mode 100644
> index ef37ff1661a..00000000000
> --- a/arch/arm/include/asm/arch-rockchip/misc.h
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * RK3399: Architecture common definitions
> - *
> - * Copyright (C) 2019 Collabora Inc - https://www.collabora.com/
> - *      Rohan Garg <rohan.garg@collabora.com>
> - */
> -
> -void rockchip_capsule_update_board_setup(void);
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index 80b4514852f..4f666aee706 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -32,7 +32,6 @@
>  #include <asm/arch-rockchip/boot_mode.h>
>  #include <asm/arch-rockchip/clock.h>
>  #include <asm/arch-rockchip/periph.h>
> -#include <asm/arch-rockchip/misc.h>
>  #include <power/regulator.h>
>
>  #if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
> @@ -148,6 +147,10 @@ void set_dfu_alt_info(char *interface, char *devstr)
>         env_set("dfu_alt_info", buf);
>  }
>
> +__weak void rockchip_capsule_update_board_setup(void)
> +{
> +}
> +
>  static void gpt_capsule_update_setup(void)
>  {
>         int p, i, ret;
>
> --
> 2.43.0
>
