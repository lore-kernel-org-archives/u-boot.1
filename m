Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F5FC00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3729D879C1;
	Tue, 24 Oct 2023 20:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JoxjVuE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88152879B1; Tue, 24 Oct 2023 20:04:27 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48B04879A9
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a822f96aedso48456167b3.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698170659; x=1698775459; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aJm4LCQbAx6liUG+zJFflq7Z3UsAChEtL+Jt2EUGqN4=;
 b=JoxjVuE9eVPgQv5c0ydWmJFAh2e6FlQ7KXAZxRdwoYFVW5fGT0UFauvOMFyxkd5dRP
 EAelch5nLWT9vW3grRW9bZgsC670FW8nqCdymdDdc0Fwo53nLehuJStP4ptL6m8AEoSp
 qhadpTLlyPQo6Sp+AaVEBK5zvGul3A9lkv75c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170659; x=1698775459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aJm4LCQbAx6liUG+zJFflq7Z3UsAChEtL+Jt2EUGqN4=;
 b=U8ythZKvGoC/0DPaD5BI976h5PXaV7pxHZP0Gre4AXTaUBKIjHJMNcHZcmSDIPxNqF
 26BFm9Pchgjc+AlB87tfSSL2VGhnsrlo6kAt4fywF4q44WaRDidKFhgcTncc2bBUt2yh
 dqEcDrMTiJ4Bk9Pr0NPS88CJXKLF/h0Sj+UxUNynue+4bcULCTY7BaldS+EM9bioSyxI
 bnUoo4oUpa/yusj5ZlitOo17T6MRUX6To30CT9TJjwK0lAH2Fg5JLbnwkNclAcGoeZtg
 ViraullOvmCzMNWTHDZ7sDXQAG/xdSIHeaPz14jW4WyBOyRdOUQNHKWELb/ypywhhS60
 GPVw==
X-Gm-Message-State: AOJu0YwFYewzzUW+6imnVmeqq1kv6n5/kEVRq+2MjVVdjcgZnLJ4p7ja
 oL9rtOGDmf79ExLMuJEL6K9WAD6M4h2lizDeUtYx0g==
X-Google-Smtp-Source: AGHT+IHYltHaglqvf1J1iUkwb4gHPJllX6sHuU9t6KaUzlMyeaMmNGPq6fPi4bUisuGhSbWd2sTorb0ChNc+4xApnts=
X-Received: by 2002:a81:8745:0:b0:591:8d06:e4e8 with SMTP id
 x66-20020a818745000000b005918d06e4e8mr14071234ywf.38.1698170658982; Tue, 24
 Oct 2023 11:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-prevbl-fdt-v1-1-541f71dba802@linaro.org>
In-Reply-To: <20231024-b4-prevbl-fdt-v1-1-541f71dba802@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Oct 2023 11:03:41 -0700
Message-ID: <CAPnjgZ3mcyST+6dLk1r=cXwQDFT1CNAfOXXfbMaSFGt+HqCiCg@mail.gmail.com>
Subject: Re: [PATCH] arm: init: add an option to use FDT from previous
 bootloader
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
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

Hi Caleb,

On Tue, 24 Oct 2023 at 04:32, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Add a new config option to allow u-boot to reuse the FDT provided by the

U-Boot (please fix throughout)

> previous stage bootloader when available.
>
> On some boards the previous stage bootloader can populate
> platform-specific parts of the devicetree such as the memory node, this
> allows us to avoid hardcoding it in u-boot and instead determine it
> dynamically at runtime.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> This patch will improve generic support for Qualcomm boards by enabling
> us to configure the memory map at runtime rather than having hardcoded
> maps on a per-device basis. I've gone for this approach initially to try
> and avoid introducing board specific code where possible, but I'm happy
> to rework this into mach-snapdragon if that's preferred.

Do you think it could use bloblist instead? I did send a patch to use
the FDT in the bloblist:

https://patchwork.ozlabs.org/project/uboot/patch/20230926141514.2101787-40-sjg@chromium.org/

Regards,
Simon

> ---
> base-commit: e65b5d35c9116485366bb08138043d51220551da
>
> // Caleb (they/them)
> ---
>  arch/arm/lib/save_prev_bl_data.c |  7 +++++++
>  boot/Kconfig                     | 10 ++++++++++
>  include/init.h                   |  9 +++++++++
>  lib/fdtdec.c                     |  7 ++++++-
>  4 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/lib/save_prev_bl_data.c b/arch/arm/lib/save_prev_bl_data.c
> index f7b23faf0d66..b0608502535e 100644
> --- a/arch/arm/lib/save_prev_bl_data.c
> +++ b/arch/arm/lib/save_prev_bl_data.c
> @@ -45,6 +45,13 @@ bool is_addr_accessible(phys_addr_t addr)
>         return false;
>  }
>
> +phys_addr_t get_prev_bl_fdt_addr(void)
> +{
> +       if (!is_addr_accessible((phys_addr_t)reg0))
> +               return 0;
> +       return reg0;
> +}
> +
>  int save_prev_bl_data(void)
>  {
>         struct fdt_header *fdt_blob;
> diff --git a/boot/Kconfig b/boot/Kconfig
> index a01e6cb8aafe..c127ba254589 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1599,6 +1599,16 @@ config SAVE_PREV_BL_INITRAMFS_START_ADDR
>           If no initramfs was provided by previous bootloader, no env variables
>           will be created.
>
> +config USE_PREV_BL_FDT
> +       depends on SAVE_PREV_BL_FDT_ADDR && !OF_BOARD
> +       bool "Use the FDT provided by the previous stage bootloader"
> +       help
> +         When u-boot is chain-loaded from a previous bootloader, enable this option
> +         to use the FDT provided by the previous bootloader instead of any built-in
> +         to u-boot.
> +
> +         If no FDT was available, u-boot will fall back to its internal FDT.
> +
>  menu "Configuration editor"
>
>  config CEDIT
> diff --git a/include/init.h b/include/init.h
> index 4e7fe26c2004..58604cd98758 100644
> --- a/include/init.h
> +++ b/include/init.h
> @@ -168,6 +168,15 @@ defined(CONFIG_SAVE_PREV_BL_FDT_ADDR)
>   * Return: 0 if ok; -ENODATA on error
>   */
>  int save_prev_bl_data(void);
> +
> +/**
> + * get_prev_bl_fdt_addr - When u-boot is chainloaded, get the address
> + * of the FDT passed by the previous bootloader.
> + *
> + * Return: the address of the FDT passed by the previous bootloader
> + * or 0 if not found.
> + */
> +phys_addr_t get_prev_bl_fdt_addr(void);
>  #endif
>
>  /**
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index 7a6916764835..85425f2dc1ee 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1222,7 +1222,7 @@ static int uncompress_blob(const void *src, ulong sz_src, void **dstp)
>   */
>  static void *fdt_find_separate(void)
>  {
> -       void *fdt_blob = NULL;
> +       void *fdt_blob = NULL, *prevbl_fdt_blob;
>
>         if (IS_ENABLED(CONFIG_SANDBOX))
>                 return NULL;
> @@ -1234,6 +1234,11 @@ static void *fdt_find_separate(void)
>         else
>                 fdt_blob = (ulong *)__bss_end;
>  #else
> +#if defined(CONFIG_USE_PREV_BL_FDT)
> +       prevbl_fdt_blob = (void *)get_prev_bl_fdt_addr();
> +       if (prevbl_fdt_blob)
> +               return prevbl_fdt_blob;
> +#endif
>         /* FDT is at end of image */
>         fdt_blob = (ulong *)_end;
>
>

Regards,
SImon
