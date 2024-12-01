Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8943CD49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:15:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0B0E8973C;
	Sun,  1 Dec 2024 17:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jPrc45Pb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31B8589637; Sun,  1 Dec 2024 17:13:44 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8438F89637
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 17:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-724ffe64923so3515122b3a.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 08:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733069617; x=1733674417; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CSA/YYcOdrXlWgDpAlc7xIe2+c28oJWZMAzJ0dPa+cc=;
 b=jPrc45PbfvAo1HsrMpKArUefm3tA0EBPR6lvU8rmv/vqvVuetVHzAS5/4zdcaF8wwT
 S3Ql889uDgN2xol17KFY/e8DapJnZuvDdifZFvL0OdgLs1pW4EAZRJHiOf10XWDfEz1R
 cDVkmkceDjSVN/MC1O0wEHi14Yu/VR5n3LQ4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069617; x=1733674417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CSA/YYcOdrXlWgDpAlc7xIe2+c28oJWZMAzJ0dPa+cc=;
 b=jlqCy9ykLwi4PqYNXwyzKw/kRotQHHWfvolxyf7UqIRcRsadoEsPTXkEYGwRdfUWSG
 TG6zDuJzv2lgvwfcka6fQaic1Re5Enz6XZnAqdLvCXBT9gxgAWb2ktXuDbKvJhHd8tg7
 IyTd2NMVrBVoi+EIYokNie59BT6+MmgIsz8K5I5xIYWI/ur+sEOHsjXTtsg0lOeMI3DD
 KE5qCzib2RAkxNw4hydAhQLxT8w2257Cw6j/djZm+E+ovZpWXBuHZKSnPEcon7reKYSI
 KJYlFxAfkEU0TS2Akj27FKuPHpy7eR7Wo1fr04YzgE1btZxl1QdnHpRM2RvAW582Sf4L
 VLFA==
X-Gm-Message-State: AOJu0YzxNscEp3AG9TZbw5GQsCuYA8C24M6djIQiN5fgfPATg+L/YlH1
 h3i4jJiWsqxqIjV+kHMXpsl7MOtte3ysFKwBH7HPsMPt/k5xC+hbUg1HdKn9AaUP3ef15Ddxl7o
 eZuq9BcJVoMVZrk42SvsfmTzz9euH3+Q9ab4n
X-Gm-Gg: ASbGnctDkymnCe8oyGFqryUQldNC6lDpsR71vNhSfxbQ41Q2Gs08BdQKul+1qe4LRty
 fTPiESv0eObllg2VDKtIuqgn+I3ta4Q==
X-Google-Smtp-Source: AGHT+IE5xcf/Gp5EDkGcG84sbTToTil07jo37745oCkJl9sQCelcBwZlsVHWW+2Fd9FLneRKyQqIExLQeobb8F1WomA=
X-Received: by 2002:a17:90b:4f85:b0:2ea:712d:9a82 with SMTP id
 98e67ed59e1d1-2ee097c1e4emr25792759a91.29.1733069617070; Sun, 01 Dec 2024
 08:13:37 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-4-mjg59@srcf.ucam.org>
In-Reply-To: <20241123195616.305687-4-mjg59@srcf.ucam.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Dec 2024 09:12:38 -0700
Message-ID: <CAFLszTjUc8acBkRh=1sxtvzO7g2VEYN8bA1r1mTskcHsX7c86Q@mail.gmail.com>
Subject: Re: [PATCH 03/10] Add a command to find a load address
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: u-boot@lists.denx.de, Matthew Garrett <mgarrett@aurora.tech>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>
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

On Sat, 23 Nov 2024 at 12:57, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> From: Matthew Garrett <mgarrett@aurora.tech>
>
> For systems with more complicated firmware, the firmware memory map may
> vary significantly based on a number of factors. This makes it difficult to
> pick a hardcoded load address. Add a command for finding an available
> address with sufficient room to load the provided path.
>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>
>  cmd/Kconfig     |  7 ++++
>  cmd/Makefile    |  1 +
>  cmd/addr_find.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)
>  create mode 100644 cmd/addr_find.c

Reviewed-by: Simon Glass <sjg@chromium.org>

(again, this needs doc/ and test/cmd/...)

>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index ee85928ca21..5ed6a50121c 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -128,6 +128,13 @@ config CMD_ACPI
>           between the firmware and OS, and is particularly useful when you
>           want to make hardware changes without the OS needing to be adjusted.
>
> +config CMD_ADDR_FIND
> +        bool "addr_find"
> +       help
> +         This command searches for an unused region of address space
> +         sufficiently large to hold a file. If successful, it sets the
> +         loadaddr variable to this address.
> +
>  config CMD_ADDRMAP
>         bool "addrmap"
>         depends on ADDR_MAP
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 16fd8dcd723..38cb7a4aea5 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -15,6 +15,7 @@ obj-y += version.o
>  obj-$(CONFIG_CMD_ARMFFA) += armffa.o
>  obj-$(CONFIG_CMD_2048) += 2048.o
>  obj-$(CONFIG_CMD_ACPI) += acpi.o
> +obj-$(CONFIG_CMD_ADDR_FIND) += addr_find.o
>  obj-$(CONFIG_CMD_ADDRMAP) += addrmap.o
>  obj-$(CONFIG_CMD_AES) += aes.o
>  obj-$(CONFIG_CMD_ADC) += adc.o
> diff --git a/cmd/addr_find.c b/cmd/addr_find.c
> new file mode 100644
> index 00000000000..b187337d885
> --- /dev/null
> +++ b/cmd/addr_find.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Aurora Innovation, Inc. Copyright 2022.
> + *
> + */
> +
> +#include <blk.h>
> +#include <config.h>
> +#include <command.h>
> +#include <env.h>
> +#include <fs.h>
> +#include <lmb.h>
> +#include <asm/global_data.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int do_addr_find(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +       struct lmb_region *mem, *reserved;
> +       const char *filename;
> +       struct lmb lmb;
> +       loff_t size;
> +       int ret;
> +       int i, j;
> +
> +       if (!gd->fdt_blob) {
> +               log_err("No FDT setup\n");
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       if (fs_set_blk_dev(argv[1], argc >= 3 ? argv[2] : NULL, FS_TYPE_FAT)) {
> +               log_err("Can't set block device\n");
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       if (argc >= 4) {
> +               filename = argv[3];
> +       } else {
> +               filename = env_get("bootfile");
> +               if (!filename) {
> +                       log_err("No boot file defined\n");
> +                       return CMD_RET_FAILURE;
> +               }
> +       }
> +
> +       ret = fs_size(filename, &size);
> +       if (ret != 0) {
> +               log_err("Failed to get file size\n");
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);

As Tom says, lmb has changed to be global for now. However, since we
are not using EFI_LOADER's memory allocation here, it seems fine to
me.

> +       mem = &lmb.memory;
> +       reserved = &lmb.reserved;
> +
> +       for (i = 0; i < mem->cnt; i++) {
> +               unsigned long long start, end;
> +
> +               start = mem->region[i].base;
> +               end = mem->region[i].base + mem->region[i].size - 1;
> +               if ((start + size) > end)
> +                       continue;
> +               for (j = 0; j < reserved->cnt; j++) {
> +                       if ((reserved->region[j].base + reserved->region[j].size) < start)
> +                               continue;
> +                       if ((start + size) > reserved->region[j].base)
> +                               start = reserved->region[j].base + reserved->region[j].size;
> +               }
> +               if ((start + size) <= end) {
> +                       env_set_hex("loadaddr", start);
> +                       debug("Set loadaddr to 0x%llx\n", start);
> +                       return CMD_RET_SUCCESS;
> +               }
> +       }
> +
> +       log_err("Failed to find enough RAM for 0x%llx bytes\n", size);
> +       return CMD_RET_FAILURE;
> +}
> +
> +U_BOOT_CMD(
> +       addr_find, 7, 1, do_addr_find,
> +       "find a load address suitable for a file",
> +       "<interface> [<dev[:part]>] <filename>\n"
> +       "- find a consecutive region of memory sufficiently large to hold\n"
> +       "  the file called 'filename' from 'dev' on 'interface'. If\n"
> +       "  successful, 'loadaddr' will be set to the located address."
> +);
> --
> 2.47.0
>

Regards,
Simon
