Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0DDCF6BE2
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 02:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB55583C6E;
	Wed,  7 Jan 2026 03:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JkPTBoHh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B867883CDC; Wed,  7 Jan 2026 03:33:03 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4325183C4B
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 03:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b804646c718so236144266b.2
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 18:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767753181; x=1768357981; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W2e6dqFQenCSAZq3Qfurc14QV8akf2FXzqJ1zOS9McU=;
 b=JkPTBoHh6h1eR0N+zIFG8VSKlrp/PfodpA39avS+ilTfB0n5vddgtK2MbkjhnWp0CR
 9NdX6pRSSvbHS2RGinVPSqYrxoYgWjP3rwC+HjPIjYVwG/zoT10wDAHOALweS9uaZGEI
 4anY323HZwCndyimokRz/7nuomzbdlFxKE2mP2fntE7u79YW5IdP3Sy9xsne0veuu+Ac
 yOCq8T98K2eQ1f+8Q7Z2DLZ3ra7LmtpkfmZOhZvkTckwwwFN9yVezTIvUA/kdm0w+cDg
 SajgXZifPYOijbmwhCWEQP8g0hSSUy6CQ6IkC2AriMtqGZFV+Wn7v8wLJ7e0cRopGLIV
 Z/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767753181; x=1768357981;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2e6dqFQenCSAZq3Qfurc14QV8akf2FXzqJ1zOS9McU=;
 b=MTBcY1apTtfRfcgsdo2pDIJF2574qKDbOCtHQR44/jrCPtrs5RJ+iZAzCO4EYa2ChD
 Otagv6YZC8KkdvGHwPP6oqSqX7n8jnMq/1yXynI+y2CSng0+GyvBfOx1U2M1aAi8du+E
 5U9wFbvuqegNhaga5pcuKDfzlSg1/gyj++GtpnyN2RD7FQCWnZ4gWXN9uP0K4oll8fCr
 90uBq6ofpZU034cMJmWn1qH6KGWkvSNAgiy8wwmUn+IJUUEbx7JwnBetHqDwximybgLM
 5OP1X/uydM9xL8+tCW7JOiXv3Kb30tGUiYUs6+Ic7vOhS6j3CpQeH14ihNotdcMS2s3d
 CZ9g==
X-Gm-Message-State: AOJu0YwqT0mk0FKTt+85Gs9HnpucUW+NBr3j0nHTTTtoQKCJ1xAvi3pB
 8AgaixSpn0P36R1R8DNrhUZZ1hFXSo3VLPGw9kji6ADYXZ0UwOI5w5nuWB7OXAe+x0qZN7BXGRh
 YPz46uooe48Pd0pUwgOshLpqAYfqxCmw=
X-Gm-Gg: AY/fxX7ceoGwEe/33ebGpSxbbHISfhcXITj4AEoRr3upNuYacw5ZLWQ44W22SQIznxg
 KhrIUuZpe7Nvm4LJus/ri0GRraqAHLP8sNWJtl/3fvyxPbLy6CT42bZv9lVUk9ehanN8o8IlYEP
 jjrRgpTnQ512iQqKImtp2RrgQGLnH6zpNEmYWaySt2aE9jOSSN4gd7bUAero3d36l8PR/4+yYt+
 pvQ2/oLdMQ9xfJXRfigLNyyaTfk6doFrFXjd4jsnRQUIxLkNpLWi0kXScFO3kn2MUyhn8znKX2g
 yQprNir2XMo7fq4sTW92DSOSBCbxmThhegkhR71sEb6lqUw73n94mLlJiMuauMT+VK0miXIFK6h
 eWAV33JX872MaCf3cVEoffsMSkJ5tT1IKTgso
X-Google-Smtp-Source: AGHT+IFN4guWl0Ppo1DJGFKR+LNDzuGYRyZYyKFJVJTnD12/JZxJar/sXkXTcSaBq7Gd1al+yITP+0ndNLmEg8teAfc=
X-Received: by 2002:a17:907:3e20:b0:b76:5393:758d with SMTP id
 a640c23a62f3a-b8445345c45mr84077966b.34.1767753180350; Tue, 06 Jan 2026
 18:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-9-simon.glass@canonical.com>
In-Reply-To: <20260107003131.3064800-9-simon.glass@canonical.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 7 Jan 2026 02:32:49 +0000
X-Gm-Features: AQt7F2pexBJzv0rawgtJKRCZOPy3ViuIixZVSHcnv2LO4NTj3cZVVd_pTIHz7Bc
Message-ID: <CALeDE9OuqwihBTNHaVa7yOMUT7y2i0iqLMg4Zc=OKDpDE_foBw@mail.gmail.com>
Subject: Re: [PATCH 08/10] riscv: Call bootm_final()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <simon.glass@canonical.com>, Adriano Cordova <adrianox@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Leo <ycliang@andestech.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Rick Chen <rick@andestech.com>, Yao Zi <me@ziyao.cc>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

On Wed, 7 Jan 2026 at 00:40, Simon Glass <sjg@chromium.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Make use of this function, adding some pieces needed by RISC-V
>
> Drop the udc_disconnect() from EFI_LOADER since it is now done in
> bootm_final()

This is two different changes, please split the patch.

> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Simon Glass <simon.glass@canonical.com>

Do you have a clone? Choose one email for a signoff please.

> ---
>
>  arch/riscv/lib/bootm.c        | 22 +---------------------
>  boot/bootm_final.c            |  9 ++++++++-
>  lib/efi_loader/efi_boottime.c |  2 --
>  3 files changed, 9 insertions(+), 24 deletions(-)
>
> diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
> index 35403e03ab0..bd47275b52e 100644
> --- a/arch/riscv/lib/bootm.c
> +++ b/arch/riscv/lib/bootm.c
> @@ -32,27 +32,7 @@ DECLARE_GLOBAL_DATA_PTR;
>   */
>  static void announce_and_cleanup(int fake)
>  {
> -       printf("\nStarting kernel ...%s\n\n", fake ?
> -               "(fake run for tracing)" : "");
> -       bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
> -#ifdef CONFIG_BOOTSTAGE_FDT
> -       bootstage_fdt_add_report();
> -#endif
> -#if CONFIG_IS_ENABLED(BOOTSTAGE_REPORT)
> -       bootstage_report();
> -#endif
> -
> -#ifdef CONFIG_USB_DEVICE
> -       udc_disconnect();
> -#endif
> -
> -       /*
> -        * Call remove function of all devices with a removal flag set.
> -        * This may be useful for last-stage operations, like cancelling
> -        * of DMA operation or releasing device internal buffers.
> -        */
> -       dm_remove_devices_active();
> -
> +       bootm_final(fake);
>         cleanup_before_linux();
>  }
>
> diff --git a/boot/bootm_final.c b/boot/bootm_final.c
> index 7077702d8c7..7f069877d06 100644
> --- a/boot/bootm_final.c
> +++ b/boot/bootm_final.c
> @@ -7,17 +7,24 @@
>
>  #include <bootm.h>
>  #include <bootstage.h>
> +#include <usb.h>
>  #include <dm/root.h>
>
>  void bootm_final(enum bootm_final_t flags)
>  {
> -       printf("\nStarting kernel ...\n\n");
> +       printf("\nStarting kernel ...%s\n\n", flags & BOOTM_FINAL_FAKE ?
> +               "(fake run for tracing)" : "");
>
>         bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
>
> +       if (IS_ENABLED(CONFIG_BOOTSTAGE_FDT) && IS_ENABLED(CONFIG_CMD_FDT))
> +               bootstage_fdt_add_report();
>         if (IS_ENABLED(CONFIG_BOOTSTAGE_REPORT))
>                 bootstage_report();
>
> +       if (IS_ENABLED(CONFIG_USB_DEVICE))
> +               udc_disconnect();
> +
>         /*
>          * Call remove function of all devices with a removal flag set.
>          * This may be useful for last-stage operations, like cancelling
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index 13d0d4dbe88..0bc66ee61a8 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -2238,8 +2238,6 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
>
>         if (!efi_st_keep_devices) {
>                 bootm_disable_interrupts();
> -               if (IS_ENABLED(CONFIG_DM_ETH))
> -                       eth_halt();
>                 board_quiesce_devices();
>                 bootm_final(0);
>         }
> --
> 2.43.0
>
