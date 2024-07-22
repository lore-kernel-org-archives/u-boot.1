Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD18C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 06:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B986B881E7;
	Mon, 22 Jul 2024 08:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WQD9Ng7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA6E288210; Mon, 22 Jul 2024 08:42:35 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C9BC881E7
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 08:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2cb5787b4a5so1961938a91.2
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 23:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721630552; x=1722235352; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fMAsIn1WLv/uRrGfSqU4qBG6j6tQcPQ4ox1e8Jrl8Ro=;
 b=WQD9Ng7thL9IRpl4rFccjgFB0NXesaQg8b43xE9YiDcLZS0hwz/QmVKs3Adr/WAbbl
 sFv/YvPsndNkLnPOACMBl0WfyAJVA77gpDTDuPu2c6oW1ABmJF3qQ2jn/SnuqRv9+6OD
 SIdWIWMZjh2A4yWX3efhcWo4mCaaSeb2TdafsscNiymNcA+aAqa7tTtwsqhokSZHOxS0
 szbLPIiF67I6ksolTIyw/HtESF9DuYoxdn21vrOHOhTsRcZSgZ54JNAmbCOaCL/aourr
 FCT5IDJ9hyBBXHzDwmFtlH/KOQSsV1cKsHzw+8YrdXHeErjtiAgUAJXQZWru6WPNfd6/
 ru6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721630552; x=1722235352;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fMAsIn1WLv/uRrGfSqU4qBG6j6tQcPQ4ox1e8Jrl8Ro=;
 b=lnqTR5lriv6YEK0pzuqSdr9ZgLmDFtXY0IDWMsV9wWHyZAd5EtBf/dEG9WftlUoA7h
 mwoSrzaxSJa1v7GwmcQXFBS11STrhdNeYK6QXPis4rFkLPpEPibAExdfu0vpDGGY2cBS
 iuFs1ZCSCv9KalZELs5IoNi2NzZB5Vva8qz0efbWt1zEX04QxyM6l4yS1dxjxhzX4Q58
 VkkBOGVhcfjiClzhNNICJLd1emnuEDOuOtutOvzT7TUO6HPa6sUZsCyq549DzXP8ePhT
 j6Kdf932GaqRnwWeehdr3cT9ynJcxwRMUFR6MZDye2IzJ/wTzYzWycK5wjVBrJJf0T9Q
 8PAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZwxyEnKNKGpMqC+KVSzR9+njFySD+e1oBalJ472oVoHMlnJZIIQPUQ4CmJGhueC4hcKdmXUwt7T1EU6t5ryiufkKeqw==
X-Gm-Message-State: AOJu0YxB7tJroAdPRkUzAiB7v4y8zwrLNk9jTM40ycjguVN6tTG/Cl1y
 xlfv0HQdS+cH2Y96V6jU7hlBMHONZdChuPPw6nvWOzybuCxSXoWRyMaenfOlLs4iYiGYMQ3tLj+
 58eHx6xPw/AY5AP/PBlZU/1gpYcpzqLZFO9nOcw==
X-Google-Smtp-Source: AGHT+IHJLUXGz5+uA+0vIqZfoRjwlLuiIqwBmtPjZR2HC3O3U3nYmt4SU0wSCQ6CrssLVHWA3x0zdLmIbKaz0DqELYE=
X-Received: by 2002:a17:90a:c593:b0:2c9:81c6:b0e7 with SMTP id
 98e67ed59e1d1-2cd274ade2fmr2423183a91.30.1721630551730; Sun, 21 Jul 2024
 23:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240710-arm64-backtrace-v1-0-5a2ba50485dd@linaro.org>
 <20240710-arm64-backtrace-v1-1-5a2ba50485dd@linaro.org>
In-Reply-To: <20240710-arm64-backtrace-v1-1-5a2ba50485dd@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Jul 2024 09:41:55 +0300
Message-ID: <CAC_iWjJm1HPQWLgr5fp5AmFMTXKom4DygEMerG9Z-s0uwW7o2w@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] drop unused kallsyms support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
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

On Wed, 10 Jul 2024 at 19:26, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> There was some very old code floating around for decoding symbols, it's
> incomplete and is never built. Remove it so we can add a new
> implementation.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  Makefile            | 11 -----------
>  common/Makefile     |  1 -
>  common/kallsyms.c   | 43 -------------------------------------------
>  common/system_map.c |  8 --------
>  4 files changed, 63 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index f5b2512f3690..fcb9565d2fff 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1786,21 +1786,10 @@ quiet_cmd_u-boot__ ?= LD      $@
>                 $(PLATFORM_LIBS) -Map u-boot.map;                               \
>                 $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>  endif
>
> -quiet_cmd_smap = GEN     common/system_map.o
> -cmd_smap = \
> -       smap=`$(call SYSTEM_MAP,u-boot) | \
> -               awk '$$2 ~ /[tTwW]/ {printf $$1 $$3 "\\\\000"}'` ; \
> -       $(CC) $(c_flags) -DSYSTEM_MAP="\"$${smap}\"" \
> -               -c $(srctree)/common/system_map.c -o common/system_map.o
> -
>  u-boot:        $(u-boot-init) $(u-boot-main) $(u-boot-keep-syms-lto) u-boot.lds FORCE
>         +$(call if_changed,u-boot__)
> -ifeq ($(CONFIG_KALLSYMS),y)
> -       $(call cmd,smap)
> -       $(call cmd,u-boot__) common/system_map.o
> -endif
>
>  ifeq ($(CONFIG_RISCV),y)
>         @tools/prelink-riscv $@
>  endif
> diff --git a/common/Makefile b/common/Makefile
> index e98354734206..bca02e4c362f 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -34,9 +34,8 @@ obj-$(CONFIG_USB_ONBOARD_HUB) += usb_onboard_hub.o
>  obj-$(CONFIG_CONSOLE_MUX) += iomux.o
>  obj-$(CONFIG_MTD_NOR_FLASH) += flash.o
>  obj-$(CONFIG_CMD_KGDB) += kgdb.o kgdb_stubs.o
>  obj-$(CONFIG_I2C_EDID) += edid.o
> -obj-$(CONFIG_KALLSYMS) += kallsyms.o
>  obj-y += splash.o
>  obj-$(CONFIG_SPLASH_SOURCE) += splash_source.o
>  obj-$(CONFIG_MENU) += menu.o
>  obj-$(CONFIG_UPDATE_COMMON) += update.o
> diff --git a/common/kallsyms.c b/common/kallsyms.c
> deleted file mode 100644
> index 49b3897078ae..000000000000
> --- a/common/kallsyms.c
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -/*
> - * Helper functions for working with the builtin symbol table
> - *
> - * Copyright (c) 2008-2009 Analog Devices Inc.
> - * Licensed under the GPL-2 or later.
> - */
> -
> -
> -/* We need the weak marking as this symbol is provided specially */
> -extern const char system_map[] __attribute__((weak));
> -
> -/* Given an address, return a pointer to the symbol name and store
> - * the base address in caddr.  So if the symbol map had an entry:
> - *             03fb9b7c_spi_cs_deactivate
> - * Then the following call:
> - *             unsigned long base;
> - *             const char *sym = symbol_lookup(0x03fb9b80, &base);
> - * Would end up setting the variables like so:
> - *             base = 0x03fb9b7c;
> - *             sym = "_spi_cs_deactivate";
> - */
> -const char *symbol_lookup(unsigned long addr, unsigned long *caddr)
> -{
> -       const char *sym, *csym;
> -       char *esym;
> -       unsigned long sym_addr;
> -
> -       sym = system_map;
> -       csym = NULL;
> -       *caddr = 0;
> -
> -       while (*sym) {
> -               sym_addr = hextoul(sym, &esym);
> -               sym = esym;
> -               if (sym_addr > addr)
> -                       break;
> -               *caddr = sym_addr;
> -               csym = sym;
> -               sym += strlen(sym) + 1;
> -       }
> -
> -       return csym;
> -}
> diff --git a/common/system_map.c b/common/system_map.c
> deleted file mode 100644
> index 8307293bf3ae..000000000000
> --- a/common/system_map.c
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -/*
> - * The builtin symbol table for use with kallsyms
> - *
> - * Copyright (c) 2008-2009 Analog Devices Inc.
> - * Licensed under the GPL-2 or later.
> - */
> -
> -const char const system_map[] = SYSTEM_MAP;
>
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
