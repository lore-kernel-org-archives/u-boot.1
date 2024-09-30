Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2064ACE8379
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 18:52:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CEA38908D;
	Mon, 30 Sep 2024 20:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Er1ZN7h2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D05E8907F; Mon, 30 Sep 2024 20:52:28 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32EE587D1A
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 20:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6de14e0f050so38639997b3.0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 11:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727722344; x=1728327144; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E7jrz5jBcKxdgCKu7qLVTZxv0o5LNAxkOdVdlPtw6Uc=;
 b=Er1ZN7h2FzonoPBQHP7QYLRyKzS4g+i6OaJ7kdJPnbwbm2zROIqDhPkJ/0Bgg769kl
 fV73nwzMsFTEKfZ+RpFIZ/deoAHS3dP3U12KYs2Z3RPJ6z/Qm/ER5wSKRuXfD8tYgSmx
 3cUH0CzUGxp3bqd7yQ6gDLHFQ3Bt3mfTxsMeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727722344; x=1728327144;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E7jrz5jBcKxdgCKu7qLVTZxv0o5LNAxkOdVdlPtw6Uc=;
 b=FlV3AKBYy8M9eCxjEaHc5z7OQ5V8vBur3VLAW1yVc6rpurNBHK6boBFBY56D2YASTT
 2xEOOD7dnVq9gITqvHvQ2wdKFEmqBYkgYoW1bpjd/fEqWmMndTZPnTA+ySnUFkdIzWks
 CRyOeSyTVUjG2aD9THk2MSRtxK6jzjp+pF6Q861D3Kgn5+mn/0aTM3PJKnavmicRseFu
 StWdE/TXaHXSHIemjfMOBJXWQSCUeOdwUbNfiIODiPp4CgJNEK97yeVw5n8z6a0sTC9i
 NdYSSObSx3rCGU1VYgmp76wrQPfJm0x71KEu5PO2nBQRPQRpJ/H/iuX/76acHiuDxL6r
 ud8g==
X-Gm-Message-State: AOJu0YxM1mjVXEtV0USb7bNlmC2LINxgTZLUkRQy+XbxVgLoEb+PMJL7
 VXVeOZMkmmhv7p7l1zBQXakwtPT/osoEyDmWu6bIhjrlovLBv7FX6JeyfimyCJhAGXh6kgAt/pm
 ndZkicsK2PXyA0IeIKrft7Wv55RT6Xz+Gwdda25QpoMgZ7MQ=
X-Google-Smtp-Source: AGHT+IEnkgBI+rpAFVZ0sYFGtF3buye5D+2jPXGdytqoqJG520JHGEQnbwipPcV39Uw9M5Z2i2888gHlt1HijCJkAZU=
X-Received: by 2002:a05:690c:3:b0:6e2:313a:a022 with SMTP id
 00721157ae682-6e2475b93d2mr102689817b3.33.1727722344108; Mon, 30 Sep 2024
 11:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240929092739.2513768-1-daniel@0x0f.com>
In-Reply-To: <20240929092739.2513768-1-daniel@0x0f.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 30 Sep 2024 12:52:13 -0600
Message-ID: <CAFLszTjkzoZxvx5yGeg098h4qGFUCYYW4kYygB3ypiZFOCKf5g@mail.gmail.com>
Subject: Re: [PATCH] cmd: Make bootvx independent of bootelf
To: Daniel Palmer <daniel@0x0f.com>
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

Hi Daniel,

On Sun, 29 Sept 2024 at 03:27, Daniel Palmer <daniel@0x0f.com> wrote:
>
> There are lots of usecases for running baremetal ELF
> binaries via bootelf but if you enable bootelf you
> get bootvx as well and you probably don't want or need
> it.
>
> Hide bootvx behind it's own configuration option.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  cmd/Kconfig | 11 +++++++++--
>  cmd/elf.c   |  6 ++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 978f44eda426..262c4118f7f6 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -491,11 +491,18 @@ config CMD_CEDIT
>           loading and saving of configuration as well as showing an editor.
>
>  config CMD_ELF
> -       bool "bootelf, bootvx"
> +       bool "bootelf"
>         default y
>         select LIB_ELF
>         help
> -         Boot an ELF/vxWorks image from the memory.
> +         Boot an ELF image from memory.
> +
> +config CMD_ELF_BOOTVX
> +       bool "bootvx"
> +       default y
> +       depends on CMD_ELF
> +       help
> +         Boot a vxWorks image from memory
>
>  config CMD_ELF_FDT_SETUP
>         bool "Flattened Device Tree setup in bootelf cmd"
> diff --git a/cmd/elf.c b/cmd/elf.c
> index 673c6c30511c..fe7f06ef74eb 100644
> --- a/cmd/elf.c
> +++ b/cmd/elf.c
> @@ -10,8 +10,10 @@
>  #include <env.h>
>  #include <image.h>
>  #include <log.h>
> +#ifdef CONFIG_CMD_ELF_BOOTVX
>  #include <net.h>
>  #include <vxworks.h>
> +#endif

No need to #idef headers files. Just include them always.

>  #ifdef CONFIG_X86
>  #include <vesa.h>
>  #include <asm/cache.h>
> @@ -100,6 +102,7 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>         return rcode;
>  }
>
> +#ifdef CONFIG_CMD_ELF_BOOTVX
>  /*
>   * Interpreter command to boot VxWorks from a memory image.  The image can
>   * be either an ELF image or a raw binary.  Will attempt to setup the
> @@ -307,6 +310,7 @@ int do_bootvx(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>
>         return 1;
>  }
> +#endif
>
>  U_BOOT_CMD(
>         bootelf, CONFIG_SYS_MAXARGS, 0, do_bootelf,
> @@ -323,8 +327,10 @@ U_BOOT_CMD(
>  #endif
>  );
>
> +#ifdef CONFIG_CMD_ELF_BOOTVX
>  U_BOOT_CMD(
>         bootvx, 2, 0, do_bootvx,
>         "Boot vxWorks from an ELF image",
>         " [address] - load address of vxWorks ELF image."
>  );

This needs a doc/usage/cmd update

I'm not sure if it is possible to test it in CI?

> +#endif
> --
> 2.43.0
>

Regards,
Simon
