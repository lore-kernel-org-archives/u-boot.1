Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E357C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97A9C87EAD;
	Tue, 20 Feb 2024 14:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DU+9N+nQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E782987D74; Tue, 20 Feb 2024 14:34:39 +0100 (CET)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B922787F52
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4704c69a3d9so440952137.2
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708436070; x=1709040870; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W3+KMQRh4vU8vAY5b2uLWXEKyISabds93gB2twbvB+c=;
 b=DU+9N+nQbPSG+RdfM6ED4Jk5jGtBRdhW1d53g05Gr7EW9D2t/Y3uT8RSt/X84jS08C
 fP8j36EaNqE9zTXRNmFZnSTMjePlhd/JiBpt2z/FV5WBjGQob/78IGsS3PVsus2e1476
 v3OsfKqLozSsqWe9JHWLxEul7uJVyJW1L/Sl8K9q4buLe00lYBiza3mvjdZNXYAnuuzW
 B5bFDMTMrwnYnIYpu+88KruoiKwhY1p+MyU2ptkil+/e2BiTDErHXj9l57sgIH69euTx
 dR/VzuzJ27NIc28FmtRh5+RA1jUmYWUiTbIsDxEimNhCcZwcAZzMDBw1mpoBBmGDnKOB
 u2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708436070; x=1709040870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W3+KMQRh4vU8vAY5b2uLWXEKyISabds93gB2twbvB+c=;
 b=j3S25ESnZHq6fmByWKZ2sreW0Bt/spnzxpIExDjlbUwzsN08KjNo/0Y6HqFx6mqKMg
 /J2qZ6JYLQHOiIm2EhqrhwDTHAqH6NgdKAeKWn3XtTxKpmDw2uOb1CsXMAzEpGwrH/3G
 IU7xK8xcDUeHyG7yrcjJxR1K9bt66O1bTrI/NNQyKyJycbAHZ86X3tgGZKsBNFLxzD3X
 93uUR+6cxrwDpzUwXkogMkvqQVgPMydIE4HRz4o6Me8w4Qg0QtS4rpE33jj0UcJHedl7
 aeSwujNfIF54dwslQwv66TcAaIeTgNRntp397gcdJO4TAE7HsMCxAKJJAyY9hSYjykD2
 CfcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvxXN+7MHPh2Qdaiygzj9T+Jb0ktzfRQuMCJQPrdu4dPZT6Sd5T7RqKEP2a4/S2pJH8xNBOU+dB3PAk4gdQWYBMjCzZg==
X-Gm-Message-State: AOJu0YxAEzkXjJwELZJI7kwVqwT3uhOnhr81vzDTpzHwQm+ToQTjleUe
 Qw+EtBsMJccUzy33tzHMz2HOK7ood9UsTuGJdDE07bnBoOI9OX5JzxUAdjwqvfjlL0UiR9ipN0C
 ALwJKCsNlq3oOPNWlLEaiYuJXHXkm+79aBikC8g==
X-Google-Smtp-Source: AGHT+IHgxu84eeJkf8JnpPqLtnt+W+uAE9KWFZjSCpKe9agxlEsVzJvCpdJ5jxXH+pj19jvCGGtfeC78Br4ZHM0onVE=
X-Received: by 2002:a05:6102:2926:b0:470:4969:b35 with SMTP id
 cz38-20020a056102292600b0047049690b35mr7688463vsb.31.1708436070517; Tue, 20
 Feb 2024 05:34:30 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-21-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-21-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 19:04:19 +0530
Message-ID: <CAFA6WYMK+sb-sdQp2nswHhg2GSxczCziqp-Q2n+fZCrRs8q1NA@mail.gmail.com>
Subject: Re: [PATCH v4 21/39] mach-snapdragon: dynamic load addresses
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Heavily inspired by Apple board code. Use the LMB allocator to configure
> load addresses at runtime, and implement a lookup table for selecting a
> devicetree.
>
> As some Qualcomm RBx boards have different RAM capacities and base
> addresses, it isn't possible to hardcode these regions.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/Kconfig                                 |  1 +
>  arch/arm/mach-snapdragon/board.c                 | 34 ++++++++++++++++++++++++
>  board/qualcomm/dragonboard410c/dragonboard410c.c |  2 +-
>  3 files changed, 36 insertions(+), 1 deletion(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 672577d0ddcc..0dba77f86b49 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1095,6 +1095,7 @@ config ARCH_SNAPDRAGON
>         select OF_SEPARATE
>         select SMEM
>         select SPMI
> +       select BOARD_LATE_INIT
>         select OF_BOARD
>         select SAVE_PREV_BL_FDT_ADDR
>         select LINUX_KERNEL_IMAGE_HEADER
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index a1867852bcca..f445bed3af00 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -22,6 +22,7 @@
>  #include <linux/bug.h>
>  #include <linux/psci.h>
>  #include <linux/sizes.h>
> +#include <lmb.h>
>  #include <malloc.h>
>  #include <usb.h>
>
> @@ -159,6 +160,39 @@ int board_init(void)
>         return 0;
>  }
>
> +void __weak qcom_late_init(void)
> +{
> +}
> +
> +#define KERNEL_COMP_SIZE       SZ_64M
> +
> +#define addr_alloc(lmb, size) lmb_alloc(lmb, size, SZ_2M)
> +
> +/* Stolen from arch/arm/mach-apple/board.c */
> +int board_late_init(void)
> +{
> +       struct lmb lmb;
> +       u32 status = 0;
> +
> +       lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
> +
> +       /* We need to be fairly conservative here as we support boards with just 1G of TOTAL RAM */
> +       status |= env_set_hex("kernel_addr_r", addr_alloc(&lmb, SZ_128M));
> +       status |= env_set_hex("ramdisk_addr_r", addr_alloc(&lmb, SZ_128M));
> +       status |= env_set_hex("kernel_comp_addr_r", addr_alloc(&lmb, KERNEL_COMP_SIZE));
> +       status |= env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
> +       status |= env_set_hex("scriptaddr", addr_alloc(&lmb, SZ_4M));
> +       status |= env_set_hex("pxefile_addr_r", addr_alloc(&lmb, SZ_4M));
> +       status |= env_set_hex("fdt_addr_r", addr_alloc(&lmb, SZ_2M));
> +
> +       if (status)
> +               log_warning("%s: Failed to set run time variables\n", __func__);
> +
> +       qcom_late_init();
> +
> +       return 0;
> +}
> +
>  static void build_mem_map(void)
>  {
>         int i;
> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
> index 0136cc2237de..fbbfc0e65e24 100644
> --- a/board/qualcomm/dragonboard410c/dragonboard410c.c
> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
> @@ -88,7 +88,7 @@ int misc_init_r(void)
>         return 0;
>  }
>
> -int board_late_init(void)
> +int qcom_late_init(void)
>  {
>         char serial[16];
>
>
> --
> 2.43.1
>
