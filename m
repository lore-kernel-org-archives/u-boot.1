Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9627ED0E6D1
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7BEA88A24;
	Mon, 21 Oct 2024 10:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="krOeGNqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CCA9889EB; Mon, 21 Oct 2024 10:55:19 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A49F892C6
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e49ad46b1so2871744b3a.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 01:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729500916; x=1730105716; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qBJ+pOm7TlSnuK9L07APds1u0pZHXjn1BKV25DNU5k0=;
 b=krOeGNqfCsDo1E45DlMOYGKBBk1rqprsXSUt8c3frDtRY2x/lc5f0rLwiP7UWnw8w+
 nmQaznex0N2aMZ52LqJnN1wncA47vJQ3ABtJXEhaiABnuVZ3c5p3NLCDo0jrswAs/VlU
 RdhnPCeItblWigjLluU9EMct2cDKhpXQYZ+3u5gsXpu640zeNcfqjFbzOZ0d81wkBFg6
 E2VXYzg3EWqyIQjqWbrKGfYisu9gjap166nUmiUO/FcBVRv6YLxP7l9Rp7JAiIF7iK1F
 odlew5TlSAbIkqPtBY9Wq8hkXXsK5EjF+b42tAq31uQemkl8xHJlMA33v/dKYmPemFpz
 XleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729500916; x=1730105716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qBJ+pOm7TlSnuK9L07APds1u0pZHXjn1BKV25DNU5k0=;
 b=xKUWO7pruS4juCif0hkpTIhXJsko+jZqFufmWWPyNple9txfrH13uXxfradioN2USQ
 X0alsZmhCILrwoNCEbm0oAEO+5ELJ3BUSu34ZPd9A5SzPblgyivwFTsuQGJqKlJg04Iz
 ocY/bswHPvu2XxgH/dz/GF7DrPFnoRCZfMEXt7pGDO55retythq3ToxDkZv2AbF66nar
 X3haESzxdt6qiQJXvpMhEnmfq/UmXwRj9IZacveC/jq3oIea+Pkmh/DLYkuIz/ivtkVf
 0FCWOUzcPbjD/ROgRrLzm7pUTLfkvZllJcw0p9RwSNnq5CZOuH3KIslHa26U4RkDcAWu
 m2TA==
X-Gm-Message-State: AOJu0Yyor25s9sQ9I7JcRFlXUy572Gjyu4PNh2bwyaMfYvhDibpNFHtS
 U2Yymqc4J+npP3iwDlx1KMLKBtaADbu4LnjobJdCKj6CaBY3u4VhAWEJzUzUTqyGm//tVnxUTC2
 fTZapen66xki3PGAtUYQa2/RLccJlJLUvZIViXw==
X-Google-Smtp-Source: AGHT+IElscYArJLXiZnBqN2lxVSwVMNodooUIsokJ6bX72InS0wTGnw5NTZ6+jlDWrBoK0F1LjMZUQemwZrsHj147IU=
X-Received: by 2002:a05:6a00:2441:b0:71e:7046:c0f8 with SMTP id
 d2e1a72fcca58-71ea3357ba4mr13543760b3a.26.1729500915606; Mon, 21 Oct 2024
 01:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241021081934.289473-1-sjg@chromium.org>
 <20241021081934.289473-6-sjg@chromium.org>
In-Reply-To: <20241021081934.289473-6-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 21 Oct 2024 11:54:38 +0300
Message-ID: <CAC_iWjKonZQrD5yR9ektcwpa=dtUvh8Q-0qjT59rTTHyib8utQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] cmd: Move meminfo command into its own file
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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

On Mon, 21 Oct 2024 at 11:19, Simon Glass <sjg@chromium.org> wrote:
>
> In preparation for expanding this command, move it into a separate file.
> Rename the function to remove the extra underscore. Update the number of
> arguments to 1, since 3 is incorrect.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Split into its own patch
>
>  cmd/Kconfig   |  1 +
>  cmd/Makefile  |  1 +
>  cmd/mem.c     | 19 -------------------
>  cmd/meminfo.c | 26 ++++++++++++++++++++++++++
>  4 files changed, 28 insertions(+), 19 deletions(-)
>  create mode 100644 cmd/meminfo.c
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index a4ca61c37dd..05bd3e8a5e2 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -885,6 +885,7 @@ config MD5SUM_VERIFY
>
>  config CMD_MEMINFO
>         bool "meminfo"
> +       default y if SANDBOX
>         help
>           Display memory information.
>
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 3c5bd56e912..16e275eba63 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -110,6 +110,7 @@ obj-$(CONFIG_CMD_LOG) += log.o
>  obj-$(CONFIG_CMD_LSBLK) += lsblk.o
>  obj-$(CONFIG_CMD_MD5SUM) += md5sum.o
>  obj-$(CONFIG_CMD_MEMORY) += mem.o
> +obj-$(CONFIG_CMD_MEMINFO) += meminfo.o
>  obj-$(CONFIG_CMD_IO) += io.o
>  obj-$(CONFIG_CMD_MII) += mii.o
>  obj-$(CONFIG_CMD_MISC) += misc.o
> diff --git a/cmd/mem.c b/cmd/mem.c
> index 4d6fde28531..9e716776393 100644
> --- a/cmd/mem.c
> +++ b/cmd/mem.c
> @@ -1379,17 +1379,6 @@ U_BOOT_CMD(
>
>  #endif
>
> -#ifdef CONFIG_CMD_MEMINFO
> -static int do_mem_info(struct cmd_tbl *cmdtp, int flag, int argc,
> -                      char *const argv[])
> -{
> -       puts("DRAM:  ");
> -       print_size(gd->ram_size, "\n");
> -
> -       return 0;
> -}
> -#endif
> -
>  U_BOOT_CMD(
>         base,   2,      1,      do_mem_base,
>         "print or set address offset",
> @@ -1433,14 +1422,6 @@ U_BOOT_CMD(
>  );
>  #endif /* CONFIG_CMD_MX_CYCLIC */
>
> -#ifdef CONFIG_CMD_MEMINFO
> -U_BOOT_CMD(
> -       meminfo,        3,      1,      do_mem_info,
> -       "display memory information",
> -       ""
> -);
> -#endif
> -
>  #ifdef CONFIG_CMD_RANDOM
>  U_BOOT_CMD(
>         random, 4,      0,      do_random,
> diff --git a/cmd/meminfo.c b/cmd/meminfo.c
> new file mode 100644
> index 00000000000..bb9bcec2e3f
> --- /dev/null
> +++ b/cmd/meminfo.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 Google LLC
> + * Written by Simon Glass <sjg@chromium.org>
> + */
> +
> +#include <command.h>
> +#include <display_options.h>
> +#include <asm/global_data.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
> +                      char *const argv[])
> +{
> +       puts("DRAM:  ");
> +       print_size(gd->ram_size, "\n");
> +
> +       return 0;
> +}
> +
> +U_BOOT_CMD(
> +       meminfo,        1,      1,      do_meminfo,
> +       "display memory information",
> +       ""
> +);
> --
> 2.43.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
