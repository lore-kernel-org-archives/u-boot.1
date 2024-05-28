Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCD2C25B7E
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 15:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22756884DC;
	Tue, 28 May 2024 17:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YAsXFiPB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42BC0884E5; Tue, 28 May 2024 17:45:12 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF8F58842A
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 17:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2bf59b781d6so830691a91.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 08:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716911108; x=1717515908; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gUwHgokjriNB88+yLkQA88rHG1G2DunmvAx3jCKNT3w=;
 b=YAsXFiPBL43HJs1jFAfTUdyUEgcUBhnpXl755u+ENHDD25yxTLN0JG4VkRs8rc6N86
 ExKpPDGfTLVquU8sodU6JXbRZnA/wFhszqHaeaJjiEs6uR5cyQrjgP25aMJ4ZnyosEye
 N/Gr0t+MylpwDpEQA2KrlY3p6A5XBtx2NGdsy3uZIhhdTliYjeplwzD5VySClKnT0IcA
 wx7UmLIWG6JjD4cFzvOpZB+Mq27zc2RMVdzr3MaQG++imRoJzU1QDFOGqjFPckT6drNT
 jAxhNN2qYgIJA2uv0pZLaZSkRZIqEAJbHQJQUi+XpvtRTJOe3opJCsb6qdACuMoDEzX+
 a5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911108; x=1717515908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gUwHgokjriNB88+yLkQA88rHG1G2DunmvAx3jCKNT3w=;
 b=lOYmx3tA5fZQjxQfjeaCZMmOomLQFaEnMtSaqTfcyxEVF1kvSweLJSdSp8ogfDebXS
 4fEhgfSXRMS7g9c86Oveax7w1bBoZT4xO9cmEzdvTGNqVGVxFIknd4hQz2LIXxhPsgHk
 jauM6yNUtDg+JARtp/49HwXkMwBMRZDF8LCfyCprWz/bOvqpWhDbjv8C7dFUvj3bcCQ7
 tU8BdbBbbXbjVI1ZDYl4AnDJjHqVVMEpfG9cdDQffzaz3OTbWCyJ/MewF/Q82odCrSjM
 TNg33JgnVHiwfTwaXXW0E01PWqNHEGKDEjhY+L261Z94MiWrV/WiqCWGrsomo+YY0dLS
 8jmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmVSz2v+MkJMRClChmXPJ9038tAdngiiruSn67EIDIxss1ryslEfAL2fEVThxniM8+L+ArP5/txrNVy2EY27MdAZwQRw==
X-Gm-Message-State: AOJu0YzVPatZ/7SfuxxtnZUZ/ChagSomXUnlcXlA3xFU/Doy5+iMAABm
 u6+GIRAln/K8HK+T+M46V1u6W6peEypDpdUXNPPX8yvj+2QCH0BydFlIrBqqCSSoCmwMCrelUsG
 ga6jamlsPZvNtGwq/a6gpK5XyGOd2npaRK6LvyXatCdC3+MCysvg=
X-Google-Smtp-Source: AGHT+IGWDQLgH5hREwB5dSAKEGbweyYbzfqrJR1x61/WS5zQhv1HvueQdghG+EQvRcrZwteoDxj8MNorsNPDHFyT788=
X-Received: by 2002:a17:90b:3709:b0:2ba:e4d:d2b0 with SMTP id
 98e67ed59e1d1-2bf5e137071mr11785196a91.3.1716911108231; Tue, 28 May 2024
 08:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
 <20240528144252.179247-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240528144252.179247-6-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 May 2024 18:44:32 +0300
Message-ID: <CAC_iWjK5TDEJFfSCGeSBDjaQTz-6k+mr0B19y8j0hF1rKerZwQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] efi_loader: move distro_efi_get_fdt_name()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Tue, 28 May 2024 at 17:43, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Move distro_efi_get_fdt_name() to a separate C module
> and rename it to efi_get_distro_fdt_name().
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         rebase patch
> ---
>  boot/bootmeth_efi.c      | 60 ++-------------------------------
>  include/efi_loader.h     |  2 ++
>  lib/efi_loader/Makefile  |  1 +
>  lib/efi_loader/efi_fdt.c | 73 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 78 insertions(+), 58 deletions(-)
>  create mode 100644 lib/efi_loader/efi_fdt.c
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index aebc5207fc0..40da77c497b 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -144,62 +144,6 @@ static int distro_efi_check(struct udevice *dev, struct bootflow_iter *iter)
>         return 0;
>  }
>
> -/**
> - * distro_efi_get_fdt_name() - Get the filename for reading the .dtb file
> - *
> - * @fname: Place to put filename
> - * @size: Max size of filename
> - * @seq: Sequence number, to cycle through options (0=first)
> - * Returns: 0 on success, -ENOENT if the "fdtfile" env var does not exist,
> - * -EINVAL if there are no more options, -EALREADY if the control FDT should be
> - * used
> - */
> -static int distro_efi_get_fdt_name(char *fname, int size, int seq)
> -{
> -       const char *fdt_fname;
> -       const char *prefix;
> -
> -       /* select the prefix */
> -       switch (seq) {
> -       case 0:
> -               /* this is the default */
> -               prefix = "/dtb";
> -               break;
> -       case 1:
> -               prefix = "";
> -               break;
> -       case 2:
> -               prefix = "/dtb/current";
> -               break;
> -       default:
> -               return log_msg_ret("pref", -EINVAL);
> -       }
> -
> -       fdt_fname = env_get("fdtfile");
> -       if (fdt_fname) {
> -               snprintf(fname, size, "%s/%s", prefix, fdt_fname);
> -               log_debug("Using device tree: %s\n", fname);
> -       } else if (IS_ENABLED(CONFIG_OF_HAS_PRIOR_STAGE)) {
> -               strcpy(fname, "<prior>");
> -               return log_msg_ret("pref", -EALREADY);
> -       /* Use this fallback only for 32-bit ARM */
> -       } else if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_ARM64)) {
> -               const char *soc = env_get("soc");
> -               const char *board = env_get("board");
> -               const char *boardver = env_get("boardver");
> -
> -               /* cf the code in label_boot() which seems very complex */
> -               snprintf(fname, size, "%s/%s%s%s%s.dtb", prefix,
> -                        soc ? soc : "", soc ? "-" : "", board ? board : "",
> -                        boardver ? boardver : "");
> -               log_debug("Using default device tree: %s\n", fname);
> -       } else {
> -               return log_msg_ret("env", -ENOENT);
> -       }
> -
> -       return 0;
> -}
> -
>  /*
>   * distro_efi_try_bootflow_files() - Check that files are present
>   *
> @@ -241,7 +185,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
>         ret = -ENOENT;
>         *fname = '\0';
>         for (seq = 0; ret == -ENOENT; seq++) {
> -               ret = distro_efi_get_fdt_name(fname, sizeof(fname), seq);
> +               ret = efi_get_distro_fdt_name(fname, sizeof(fname), seq);
>                 if (ret == -EALREADY)
>                         bflow->flags = BOOTFLOWF_USE_PRIOR_FDT;
>                 if (!ret) {
> @@ -340,7 +284,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
>         sprintf(file_addr, "%lx", fdt_addr);
>
>         /* We only allow the first prefix with PXE */
> -       ret = distro_efi_get_fdt_name(fname, sizeof(fname), 0);
> +       ret = efi_get_distro_fdt_name(fname, sizeof(fname), 0);
>         if (ret)
>                 return log_msg_ret("nam", ret);
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 1236eecff0f..1b4bc987a23 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -1199,4 +1199,6 @@ efi_status_t efi_load_option_dp_join(struct efi_device_path **dp,
>                                      struct efi_device_path *initrd_dp,
>                                      struct efi_device_path *fdt_dp);
>
> +int efi_get_distro_fdt_name(char *fname, int size, int seq);
> +
>  #endif /* _EFI_LOADER_H */
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 034e366967f..2af6f2066b5 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -59,6 +59,7 @@ obj-y += efi_device_path.o
>  obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) += efi_device_path_to_text.o
>  obj-$(CONFIG_EFI_DEVICE_PATH_UTIL) += efi_device_path_utilities.o
>  obj-y += efi_dt_fixup.o
> +obj-y += efi_fdt.o
>  obj-y += efi_file.o
>  obj-$(CONFIG_EFI_LOADER_HII) += efi_hii.o
>  obj-y += efi_image_loader.o
> diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
> new file mode 100644
> index 00000000000..0edf0c1e2fc
> --- /dev/null
> +++ b/lib/efi_loader/efi_fdt.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Bootmethod for distro boot via EFI
> + *
> + * Copyright 2021 Google LLC
> + * Written by Simon Glass <sjg@chromium.org>
> + */
> +
> +#include <efi_loader.h>
> +#include <env.h>
> +#include <errno.h>
> +#include <log.h>
> +#include <string.h>
> +#include <vsprintf.h>
> +
> +/**
> + * distro_efi_get_fdt_name() - get the filename for reading the .dtb file
> + *
> + * @fname:     buffer for filename
> + * @size:      buffer size
> + * @seq:       sequence number, to cycle through options (0=first)
> + *
> + * Returns:
> + * 0 on success,
> + * -ENOENT if the "fdtfile" env var does not exist,
> + * -EINVAL if there are no more options,
> + * -EALREADY if the control FDT should be used
> + */
> +int efi_get_distro_fdt_name(char *fname, int size, int seq)
> +{
> +       const char *fdt_fname;
> +       const char *prefix;
> +
> +       /* select the prefix */
> +       switch (seq) {
> +       case 0:
> +               /* this is the default */
> +               prefix = "/dtb";
> +               break;
> +       case 1:
> +               prefix = "";
> +               break;
> +       case 2:
> +               prefix = "/dtb/current";
> +               break;
> +       default:
> +               return log_msg_ret("pref", -EINVAL);
> +       }
> +
> +       fdt_fname = env_get("fdtfile");
> +       if (fdt_fname) {
> +               snprintf(fname, size, "%s/%s", prefix, fdt_fname);
> +               log_debug("Using device tree: %s\n", fname);
> +       } else if (IS_ENABLED(CONFIG_OF_HAS_PRIOR_STAGE)) {
> +               strcpy(fname, "<prior>");
> +               return log_msg_ret("pref", -EALREADY);
> +       /* Use this fallback only for 32-bit ARM */
> +       } else if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_ARM64)) {
> +               const char *soc = env_get("soc");
> +               const char *board = env_get("board");
> +               const char *boardver = env_get("boardver");
> +
> +               /* cf the code in label_boot() which seems very complex */
> +               snprintf(fname, size, "%s/%s%s%s%s.dtb", prefix,
> +                        soc ? soc : "", soc ? "-" : "", board ? board : "",
> +                        boardver ? boardver : "");
> +               log_debug("Using default device tree: %s\n", fname);
> +       } else {
> +               return log_msg_ret("env", -ENOENT);
> +       }
> +
> +       return 0;
> +}
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
