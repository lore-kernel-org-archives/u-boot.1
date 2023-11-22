Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1257C61D9B
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 19:02:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2397186FB2;
	Wed, 22 Nov 2023 20:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PApzbjjy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32F9D875E3; Wed, 22 Nov 2023 20:02:01 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 941AD86784
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 20:01:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-548f6f3cdc9so152961a12.2
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 11:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700679718; x=1701284518; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+SFPxgJhF/gAyuGr+8Jb9NrGuVzMoSbVraIkM0wUlG0=;
 b=PApzbjjy+AC64qVXaC9SptWUvHGQ6c6oWJkx4lrc/x7OvFEnwOXWPDb9S/5SdFVR24
 m7WF/ZnPxY8MF4Ou+vnTfkll1WZal/qM2bzSPMO2krjG4yb+tTOHcm42M18XRx6zt8wk
 OS2gz+yt3bPn3nZg5qOlhMR4i9OWn8s+Mg+5qg2iEI/mjCAl9LFSIiZoy28lAsVLoNyY
 N2zkcw1DFydlo8lh9dwntxx/szjJO14wuWxrAUUwiXA0uh3w71l72Tt3j9Mvh4wf3qbR
 tVVlp9APjt0p8quvgB1k92saBaCTogQYzQdey2f1AfYh9fxtYorrPofIoEVh/UMDijFE
 rFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700679718; x=1701284518;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+SFPxgJhF/gAyuGr+8Jb9NrGuVzMoSbVraIkM0wUlG0=;
 b=R/QZHxZFrq2XaI0O/LTMAOQS11508jH7xGkOMVj7XEj8iUyYUXjjj7Mwe2+vET/XOA
 8LzVSfunWFKmi9e2BpkXiKKo9OKT7zTkYGM+kfjXfSAIQa2K92UbQis1IHeBh2UGIzPa
 cyzhy8gJGyJpKiiuzffjubBkyB2u6PpK3sB8E089MByFR2VZc+Vgejvk6Q+uUFPZYZSF
 PmHFnjx9jiOZWCPFxAJVOU3BR5P2IFb3toZlMits1SM5Au7anv+jmLlfay9yuv7UPrkH
 AMYVBjv9VLrjccxeGxT0fhEf84PR0EvV5uPg4f0Pk6GkICdQqbfZtwKrzd8O3IzV9OUq
 Ni5Q==
X-Gm-Message-State: AOJu0YzD/RHqmJ5h9l5aJRj2i0gJt7+L12v0XWigEM6PnmaeWOn5qmsn
 kqPJdCIaCZ73kYDjtG5XpDpySiZI8sX8cuimQBM67lrM
X-Google-Smtp-Source: AGHT+IHDb7R7UZDVQWJfc/55Xd0d3FWb9g78/+RKiiDf2sTXupi+Q/9WqtXCXS0hf4de98Dm8THkvPoijBpW0wD41KU=
X-Received: by 2002:a05:6402:5156:b0:53e:3d9f:3c72 with SMTP id
 n22-20020a056402515600b0053e3d9f3c72mr2448132edd.18.1700679717951; Wed, 22
 Nov 2023 11:01:57 -0800 (PST)
MIME-Version: 1.0
References: <CAKRNjQ20oazcjhAR3+WaQG0MObvHC_Zya8mZKwaRrcCeuZAhpw@mail.gmail.com>
In-Reply-To: <CAKRNjQ20oazcjhAR3+WaQG0MObvHC_Zya8mZKwaRrcCeuZAhpw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 22 Nov 2023 19:01:46 +0000
Message-ID: <CALeDE9MpaEy_5nKH5P+umxybKr19_hB5tsRb1iOh_P9R822_sw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rpi5: initial support
To: Dmitry Malkin <dmitry@bedrocksystems.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, mbrugger@suse.com
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

> rpi5: add alternative way to get MBOX address via FDT
>  node

Same note about descriptive commit titles, it's useful not to have 3
consecutive commits with the same title.

> MBOX on RPI5/bcm2712 has a different offset. Find it via
> "brcm,bcm2835-mbox" node.

Do we do use the DT node just for the RPi5 and the old method for all
older RPi, or do we move all generations to finding it by DT?

> Signed-off-by: Dmitry Malkin <dmitry@bedrocksystems.com>
> ---
> v2:
>       new patch
> ---
>  arch/arm/mach-bcm283x/include/mach/base.h |  1 +
>  arch/arm/mach-bcm283x/include/mach/mbox.h |  4 ++--
>  arch/arm/mach-bcm283x/init.c              | 12 +++++++++++-
>  3 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-bcm283x/include/mach/base.h
> b/arch/arm/mach-bcm283x/include/mach/base.h
> index 4ccaf69693..8cd224921e 100644
> --- a/arch/arm/mach-bcm283x/include/mach/base.h
> +++ b/arch/arm/mach-bcm283x/include/mach/base.h
> @@ -7,6 +7,7 @@
>  #define _BCM283x_BASE_H_
>
>  extern unsigned long rpi_bcm283x_base;
> +extern unsigned long rpi_bcm283x_mbox_addr;
>
>  #ifdef CONFIG_ARMV7_LPAE
>  #ifdef CONFIG_TARGET_RPI_4_32B
> diff --git a/arch/arm/mach-bcm283x/include/mach/mbox.h
> b/arch/arm/mach-bcm283x/include/mach/mbox.h
> index 490664f878..ad086be467 100644
> --- a/arch/arm/mach-bcm283x/include/mach/mbox.h
> +++ b/arch/arm/mach-bcm283x/include/mach/mbox.h
> @@ -38,8 +38,8 @@
>
>  /* Raw mailbox HW */
>
> -#define BCM2835_MBOX_PHYSADDR ({ BUG_ON(!rpi_bcm283x_base); \
> -                 rpi_bcm283x_base + 0x0000b880; })
> +#define BCM2835_MBOX_PHYSADDR ({ BUG_ON(!rpi_bcm283x_mbox_addr); \
> +                 rpi_bcm283x_mbox_addr; })
>
>  struct bcm2835_mbox_regs {
>      u32 read;
> diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
> index 362838e9b9..aef3a31f29 100644
> --- a/arch/arm/mach-bcm283x/init.c
> +++ b/arch/arm/mach-bcm283x/init.c
> @@ -145,6 +145,11 @@ static void rpi_update_mem_map(void) {}
>
>  unsigned long rpi_bcm283x_base = 0x3f000000;
>
> +/* This is intialized before relocation. Enforce .data section usage.
> + * Otherwise it's going to .bss and will be zero after relocation.
> + */
> +unsigned long __section(".data") rpi_bcm283x_mbox_addr;
> +
>  int arch_cpu_init(void)
>  {
>      icache_enable();
> @@ -154,7 +159,7 @@ int arch_cpu_init(void)
>
>  int mach_cpu_init(void)
>  {
> -    int ret, soc_offset;
> +    int ret, soc_offset, mbox_offset;
>      u64 io_base, size;
>
>      rpi_update_mem_map();
> @@ -170,6 +175,11 @@ int mach_cpu_init(void)
>          return ret;
>
>      rpi_bcm283x_base = io_base;
> +    rpi_bcm283x_mbox_addr = rpi_bcm283x_base + 0xb880;
> +
> +    mbox_offset = fdt_node_offset_by_compatible((void*)gd->fdt_blob,
> soc_offset, "brcm,bcm2835-mbox");
> +    if (mbox_offset > soc_offset)
> +        rpi_bcm283x_mbox_addr =
> fdt_get_base_address((void*)gd->fdt_blob, mbox_offset);
>
>      return 0;
>  }
> --
> 2.40.1
