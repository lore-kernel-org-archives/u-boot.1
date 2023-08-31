Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3141C83F2F
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 19:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B184F86886;
	Thu, 31 Aug 2023 21:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="UJ5tgK05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59EAF86776; Thu, 31 Aug 2023 21:03:24 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8028786785
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 21:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3a751d2e6ecso745697b6e.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1693508600; x=1694113400; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bcUkjD9Yao9cXPE7+O5KLH/kZNZwJQLC1OKJdvs9cCs=;
 b=UJ5tgK0538ysT4qSzIQTKlx2iE0h4A5wD3a0kKorhN/PvOvAEb7s5HA3DGqZLRzuqB
 +5NsunNcPPvDxbArc+jhUtejhN/4vo2VQtl5N2mlOK02pV2P1cgKVKqdU9dR/bH4lS+B
 nHtY4CUCQp75fN6s6rqTtkt0b4+dTb/XgrIx6kyYhm0p8VAvNvABEcHaJrKpJD07VIu6
 WJ7oG6w2OihFiO9BKlm30d0snJyc+bhdHQB6Wz+xTW/ifPN/StBMEuyjtQbdIXyXxw8F
 4fCA2gtPKhsSlhHFOFv5SwN4M5otQk/8SkjOKyIyWtbYYW6HVGfI4kt3LIxVqVXthmaA
 F/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693508600; x=1694113400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bcUkjD9Yao9cXPE7+O5KLH/kZNZwJQLC1OKJdvs9cCs=;
 b=IWT2pwqRTccqGnRXx/1SzO6q6OlEi2KyzJivSkCWxb7Gkud+2YU6goi2PjH/phr24a
 k8j9AxKNKVp0cOaOHPQZtAKNeKViyjey9mvlzHR1INLEGxy3203kM9PqCAnU4EvjuWnk
 xhCgASNxpII+TAAkfSMb+gWTmBjYARgoiCyWssxiBr+BQIYT3heV+6AXlOQb/XV/to4u
 aXvmmhWl4vAYmNKmnsRbQ1Sz6/uUwV0jBzOM684jLtU79lLkep5X0Ebmictv3QxoXkDA
 o+rxoCxOaHhVCBjuaoEIEjwqsR+nfd0q6/hDFt48NFQO+kUmFe48kVSBpdrtxZF39LUe
 EYyg==
X-Gm-Message-State: AOJu0Yx88Vx4CKnq0oGl/77rWH7IsKNAHnnYXQ//JalOqFDjwJHhpHkf
 loyWwgw8C3Skh/sDS+5b9KW67w/uzSqI+TRJwi/+dA==
X-Google-Smtp-Source: AGHT+IFfyYs3hOqXTmhM29rGL/ciC3K+m/jYUmy21g2FwQwepb1Vgr2d2K8K7M0yAzK2IbPDfy6K/i0VrYzulcXEZAs=
X-Received: by 2002:a05:6808:1a06:b0:3a4:38fa:2e08 with SMTP id
 bk6-20020a0568081a0600b003a438fa2e08mr604190oib.7.1693508599989; Thu, 31 Aug
 2023 12:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <08a3e6c09cce13287c69ad370e409e7f1766b406.1693465465.git.michal.simek@amd.com>
 <60a84405f3fefabb8b48a4e1ce84431483a729f3.1693465465.git.michal.simek@amd.com>
In-Reply-To: <60a84405f3fefabb8b48a4e1ce84431483a729f3.1693465465.git.michal.simek@amd.com>
From: Simon Glass <sjg@google.com>
Date: Thu, 31 Aug 2023 13:02:03 -0600
Message-ID: <CAPnjgZ0KnY3DmSOq2x6L+yYNAGb=VN03_tKnpXesjTQjE567BQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] xilinx: board: Add support to pick bootscr flash
 offset/size from DT
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com
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

On Thu, 31 Aug 2023 at 01:04, Michal Simek <michal.simek@amd.com> wrote:
>
> Location of bootscript in flash can be specified via /options/u-boot DT
> node by using bootscr-flash-offset and bootscr-flash-size properties.
> Values should be saved to script_offset_f and script_size_f variables.
> Variables are described in doc/develop/bootstd.rst as:
> script_offset_f
>     SPI flash offset from which to load the U-Boot script, e.g. 0xffe000
>
> script_size_f
>     Size of the script to load, e.g. 0x2000
>
> Both of them are used by sf_get_bootflow() in drivers/mtd/spi/sf_bootdev.c
> to identify bootscript location inside flash.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> Changes in v2:
> - Change message from printf to debug not to disturb current users
>
>  board/xilinx/common/board.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index b3fb6acc25a3..126f0d81a9ed 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -411,6 +411,7 @@ int board_late_init_xilinx(void)
>         int i, id, macid = 0;
>         struct xilinx_board_description *desc;
>         phys_size_t bootm_size = gd->ram_top - gd->ram_base;
> +       u64 bootscr_flash_offset, bootscr_flash_size;
>
>         if (!IS_ENABLED(CONFIG_MICROBLAZE)) {
>                 ulong scriptaddr;
> @@ -435,11 +436,19 @@ int board_late_init_xilinx(void)
>                 }
>         }
>
> +       if (!ofnode_read_bootscript_flash(&bootscr_flash_offset,
> +                                         &bootscr_flash_size)) {
> +               ret |= env_set_hex("script_offset_f", bootscr_flash_offset);
> +               ret |= env_set_hex("script_size_f", bootscr_flash_size);
> +       } else {
> +               debug("!!! Please define bootscr-flash-offset via DT !!!\n");
> +               ret |= env_set_hex("script_offset_f",
> +                                  CONFIG_BOOT_SCRIPT_OFFSET);
> +       }
> +
>         if (IS_ENABLED(CONFIG_ARCH_ZYNQ) || IS_ENABLED(CONFIG_MICROBLAZE))
>                 bootm_size = min(bootm_size, (phys_size_t)(SZ_512M + SZ_256M));
>
> -       ret |= env_set_hex("script_offset_f", CONFIG_BOOT_SCRIPT_OFFSET);
> -
>         ret |= env_set_addr("bootm_low", (void *)gd->ram_base);
>         ret |= env_set_addr("bootm_size", (void *)bootm_size);
>
> --
> 2.36.1
>
