Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F59EC5ACB3
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C94DD86FD5;
	Sat, 18 Nov 2023 18:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bEGDWBP4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2CEC87006; Sat, 18 Nov 2023 18:11:33 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 571A986DEE
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:11:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5b31c5143a0so32837927b3.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327489; x=1700932289; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IFoivxtOGULxKBtYga/6ShZ3vAtd3TZTE8U9TUtI888=;
 b=bEGDWBP4W6Gd3naHea0EemCIsqr/K2HqFz90Q7emyeWTqveS2vqVy9NJOeDL06/sjM
 8rQhhOjwj1CpqA1roofcd76NveODzrfcvkQofOqdX0YvZyimLFa3NI4/gY1IEZ7kfOTQ
 uQSM83hclhIXTF54gCvqbX463jovsJfQJItWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327489; x=1700932289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IFoivxtOGULxKBtYga/6ShZ3vAtd3TZTE8U9TUtI888=;
 b=ppW6AdT6Zycqw7gTxXPw5de7vRnS6dIyS2bA+UyqNs/q8PQsaXQoImITpx5mkcuoQo
 EztloNYmmfTTo1cWqk8SK+Kk1yVZ+0zmoq04j6HyOgrYs1pdGCa6lTzArPSwmhmKWzku
 j4IMXNsVEHqbRE9prv68jvOj8aF7iTRCw8V8mfM+gG/hZsU/F8KDnos3IaaLFScCDA7a
 Gwn/AFMK0D6oz3p3AtHUwCpApxPyMk0UtOwTOSIMAUZ5IrskVGCVN2++tCArZ33gvk9R
 IaiYIoplqm1SCJzj+lbMtpEE3ZBaKN1I6J8yrm8rLKRYIn2aFvRx71Z4sA4szv3KiT62
 IyAQ==
X-Gm-Message-State: AOJu0YxJxRHJw3yhYocSUqiWiPacAl2VlJzXvZ12vQC5Le5Fs6DVIM+t
 ZNXsMYAh5rhmnLeChZDJfTc4c2xPMZ5MoTeGK4y1Wg==
X-Google-Smtp-Source: AGHT+IHdT8YyKBgvcKRaJZ7KTF4rzdsZjv8DZKonwlBZ6i5nyKK1KKLzstNnua9k9DMcw4bTY/4G+DKOrYczUDBZBNI=
X-Received: by 2002:a0d:e503:0:b0:5ad:4975:c860 with SMTP id
 o3-20020a0de503000000b005ad4975c860mr2701748ywe.39.1700327488793; Sat, 18 Nov
 2023 09:11:28 -0800 (PST)
MIME-Version: 1.0
References: <20231117225313.2144665-1-trini@konsulko.com>
 <20231117225313.2144665-4-trini@konsulko.com>
In-Reply-To: <20231117225313.2144665-4-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:09:55 -0700
Message-ID: <CAPnjgZ2N__uy8qdhJfwzrk088dyG8fFGXbsh4-Z4yWa6rkDFNA@mail.gmail.com>
Subject: Re: [PATCH 4/5] sandbox: Audit config.h and common.h usage
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Fri, 17 Nov 2023 at 15:54, Tom Rini <trini@konsulko.com> wrote:
>
> Remove and replace common.h and config.h in sandbox when it's not needed
> and add some explicit includes where needed.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  arch/sandbox/cpu/cache.c         | 1 -
>  arch/sandbox/cpu/cpu.c           | 1 -
>  arch/sandbox/cpu/sdl.c           | 2 +-
>  arch/sandbox/cpu/spl.c           | 1 -
>  arch/sandbox/cpu/start.c         | 2 +-
>  arch/sandbox/cpu/state.c         | 2 +-
>  arch/sandbox/include/asm/io.h    | 2 ++
>  arch/sandbox/include/asm/state.h | 1 -
>  arch/sandbox/lib/bootm.c         | 1 -
>  arch/sandbox/lib/fdt_fixup.c     | 1 -
>  arch/sandbox/lib/interrupts.c    | 1 -
>  arch/sandbox/lib/pci_io.c        | 1 -
>  board/sandbox/sandbox.c          | 2 +-
>  13 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Is it possible to move CFG_SYS_SDRAM_BASE/SIZE to Kconfig?

For CFG_SYS_BAUDRATE_TABLE perhaps we could have a standard set that
most boards use, or turn it into a set of word flags with a bit for
each rate?

>
> diff --git a/arch/sandbox/cpu/cache.c b/arch/sandbox/cpu/cache.c
> index 46c62c0b4461..c8a5e64214b6 100644
> --- a/arch/sandbox/cpu/cache.c
> +++ b/arch/sandbox/cpu/cache.c
> @@ -3,7 +3,6 @@
>   * Copyright 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
>   */
>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <asm/state.h>
>
> diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
> index a1c5c7c4311a..d6475c969c4d 100644
> --- a/arch/sandbox/cpu/cpu.c
> +++ b/arch/sandbox/cpu/cpu.c
> @@ -5,7 +5,6 @@
>
>  #define LOG_CATEGORY   LOGC_SANDBOX
>
> -#include <common.h>
>  #include <bootstage.h>
>  #include <cpu_func.h>
>  #include <errno.h>
> diff --git a/arch/sandbox/cpu/sdl.c b/arch/sandbox/cpu/sdl.c
> index 590e406517bf..ed84646bdab7 100644
> --- a/arch/sandbox/cpu/sdl.c
> +++ b/arch/sandbox/cpu/sdl.c
> @@ -72,7 +72,7 @@ static struct sdl_info {
>  static void sandbox_sdl_poll_events(void)
>  {
>         /*
> -        * We don't want to include common.h in this file since it uses
> +        * We don't want to include cpu_func.h in this file since it uses
>          * system headers. So add a declation here.
>          */
>         extern void reset_cpu(void);
> diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
> index 16b766279833..9ad9da686c6a 100644
> --- a/arch/sandbox/cpu/spl.c
> +++ b/arch/sandbox/cpu/spl.c
> @@ -3,7 +3,6 @@
>   * Copyright (c) 2016 Google, Inc
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <hang.h>
>  #include <handoff.h>
> diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
> index 2589c2eba738..dce804165296 100644
> --- a/arch/sandbox/cpu/start.c
> +++ b/arch/sandbox/cpu/start.c
> @@ -3,7 +3,7 @@
>   * Copyright (c) 2011-2012 The Chromium OS Authors.
>   */
>
> -#include <common.h>
> +#include <config.h>
>  #include <cli.h>
>  #include <command.h>
>  #include <efi_loader.h>
> diff --git a/arch/sandbox/cpu/state.c b/arch/sandbox/cpu/state.c
> index e38bb248b7ff..2462f990baae 100644
> --- a/arch/sandbox/cpu/state.c
> +++ b/arch/sandbox/cpu/state.c
> @@ -3,7 +3,7 @@
>   * Copyright (c) 2011-2012 The Chromium OS Authors.
>   */
>
> -#include <common.h>
> +#include <config.h>
>  #include <autoboot.h>
>  #include <bloblist.h>
>  #include <errno.h>
> diff --git a/arch/sandbox/include/asm/io.h b/arch/sandbox/include/asm/io.h
> index 31ab7289b4bd..1ccb25a0fe1e 100644
> --- a/arch/sandbox/include/asm/io.h
> +++ b/arch/sandbox/include/asm/io.h
> @@ -6,6 +6,8 @@
>  #ifndef __SANDBOX_ASM_IO_H
>  #define __SANDBOX_ASM_IO_H
>
> +#include <linux/types.h>
> +
>  enum sandboxio_size_t {
>         SB_SIZE_8,
>         SB_SIZE_16,
> diff --git a/arch/sandbox/include/asm/state.h b/arch/sandbox/include/asm/state.h
> index 59a20595f51d..c84a1f7060f4 100644
> --- a/arch/sandbox/include/asm/state.h
> +++ b/arch/sandbox/include/asm/state.h
> @@ -6,7 +6,6 @@
>  #ifndef __SANDBOX_STATE_H
>  #define __SANDBOX_STATE_H
>
> -#include <config.h>
>  #include <sysreset.h>
>  #include <stdbool.h>
>  #include <linux/list.h>
> diff --git a/arch/sandbox/lib/bootm.c b/arch/sandbox/lib/bootm.c
> index dc8b8e46cb41..270671145a0b 100644
> --- a/arch/sandbox/lib/bootm.c
> +++ b/arch/sandbox/lib/bootm.c
> @@ -4,7 +4,6 @@
>   * Copyright (c) 2015 Sjoerd Simons <sjoerd.simons@collabora.co.uk>
>   */
>
> -#include <common.h>
>  #include <bootstage.h>
>  #include <image.h>
>  #include <asm/io.h>
> diff --git a/arch/sandbox/lib/fdt_fixup.c b/arch/sandbox/lib/fdt_fixup.c
> index a646f2059c2c..e333bd52ea28 100644
> --- a/arch/sandbox/lib/fdt_fixup.c
> +++ b/arch/sandbox/lib/fdt_fixup.c
> @@ -2,7 +2,6 @@
>
>  #define LOG_CATEGORY LOGC_ARCH
>
> -#include <common.h>
>  #include <fdt_support.h>
>  #include <log.h>
>
> diff --git a/arch/sandbox/lib/interrupts.c b/arch/sandbox/lib/interrupts.c
> index 4d7cbff802c6..3f6583e11f04 100644
> --- a/arch/sandbox/lib/interrupts.c
> +++ b/arch/sandbox/lib/interrupts.c
> @@ -5,7 +5,6 @@
>   * found in the LICENSE file.
>   */
>
> -#include <common.h>
>  #include <efi_loader.h>
>  #include <irq_func.h>
>  #include <os.h>
> diff --git a/arch/sandbox/lib/pci_io.c b/arch/sandbox/lib/pci_io.c
> index 2038141947ab..6040eacb594f 100644
> --- a/arch/sandbox/lib/pci_io.c
> +++ b/arch/sandbox/lib/pci_io.c
> @@ -8,7 +8,6 @@
>   * IO space access commands.
>   */
>
> -#include <common.h>
>  #include <command.h>
>  #include <dm.h>
>  #include <log.h>
> diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
> index 9d58860451c5..802596569c64 100644
> --- a/board/sandbox/sandbox.c
> +++ b/board/sandbox/sandbox.c
> @@ -3,8 +3,8 @@
>   * Copyright (c) 2011 The Chromium OS Authors.
>   */
>
> -#include <common.h>
>  #include <addr_map.h>
> +#include <config.h>

It seems strange to add config.h anywhere other than first. But I
don't mind if that is what you intend.

>  #include <cpu_func.h>
>  #include <cros_ec.h>
>  #include <dm.h>
> --
> 2.34.1
>

Regards,
Simon
