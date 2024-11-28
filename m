Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFE7D66BAD
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 06:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84FE489819;
	Thu, 28 Nov 2024 07:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a2yvZntd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B99C689841; Thu, 28 Nov 2024 07:38:15 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7855689818
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d0062e9c80so593616a12.2
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 22:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732775893; x=1733380693; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hvp8bqJNY16hwMWLUhEhVPhNyehQ4f+RpMe3UTU1veI=;
 b=a2yvZntdZAun22KLJjlwk+qwUwJvuWxaQVki5qZLRUIlZnfqsemNxrLgWUGguRoVOG
 2VpCpVG1OOOQQK3dQncyM2gmiCmbnAooKnQw6u50uq2JiciAslb1rMObxnlpphfnaiT3
 XH20TdqbeRl/RA10qeO+cYV2gTPRSnfHo8pq5Tvek3W8w04QC9a7S+ITArC8hznvWru7
 mpml59896t9ZqDmWzAa3C6n34ujwAQG/fMMqvC/3/cYUXaNnIlmOAO+eGYwHIBoQTNt9
 i6mbaV+vXxdyUJjcdAuLJvQp3N+DsBoqeC/egISCJMHjHra0nLhU6yR02jVgeDKD7IeA
 THIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732775893; x=1733380693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hvp8bqJNY16hwMWLUhEhVPhNyehQ4f+RpMe3UTU1veI=;
 b=t/RX9gq1jOGJQZ8j9wBHYSq4w86Iip5cJQM7imKnn3hTn4bf2ef46/EVCODTBuin7Z
 ZQTue5OpxLA0AFpSFEo13jMUe3Fev8MikDtssg1iXDKJYh3O8RpR68fw0AzYdKiPrwBj
 Sgtm0cyCRmEoN3l7xdAsWjSwHDUlfa1eEn6LKklxs5Wnl0J3+eJmaOtdDO88aDRfi107
 aLJZXENJYOi0IB9deIcrsgaStEROYtKo2dOWY6Ckh5CmzGNUO90mx4bT5qQpD9h/Gx+g
 1oupRSkMURefC0fialnpKYrtMZuogJrYTbhAXCHCR22iY9kyrtB3hHzUHqON6+tcEFL3
 Jx5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0SDIZrdcE/u+qfDOMUeK0i1lLHGrSz6VpUnKJqKbr7bf1nyVCaQeiTMzrqupvCubZliKeew0=@lists.denx.de
X-Gm-Message-State: AOJu0YzF01Hyc5kdapfk1fYmk/4TTW5JopDxSup6bsEKl7Ynt+qKgm5S
 vXFCg5iB1mIlarv8r9zraOfD4OiKqvc94RI6BuNXva9nNfJA81NeFRoNXTZAMtytzSv9AP0VMsk
 SxWTZMGVCFAmGePC2hI/K4p6yY52d8ZnQcL+Ikg==
X-Gm-Gg: ASbGncv3l6NRqf8v3JEmmY9OF7Dg9rCrYOcNDlkEDGH4QGF1YNR1Q2kF9lDkCYjTPv4
 aF63mZfcUoRYF0V9hI0kYHhBPPokYz0UI
X-Google-Smtp-Source: AGHT+IFDrc5D4crD16YDG6VoyTdu9mfeBPoIm/zEZcMYz4su+lBTBnkSjnx/O8xYu4HONLYqTaEW4OeToiRxK9HquXM=
X-Received: by 2002:a05:6402:26cf:b0:5d0:8f25:24ff with SMTP id
 4fb4d7f45d1cf-5d08f252625mr2987106a12.14.1732775892961; Wed, 27 Nov 2024
 22:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
 <20241124-b4-efistub-arm64-v1-7-3e33f0340071@linaro.org>
In-Reply-To: <20241124-b4-efistub-arm64-v1-7-3e33f0340071@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 28 Nov 2024 12:08:01 +0530
Message-ID: <CADg8p94ma+FcJH2dAx=PtNjSq77Y0bGH8V_k64z_7+ij8R=P3Q@mail.gmail.com>
Subject: Re: [PATCH RFC 07/14] efi: stub: add known memory to U-Boot's EFI
 memory map
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Mon, 25 Nov 2024 at 01:58, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> When running U-Boot as an EFI payload with CONFIG_EFI_STUB, the reserved
> regions from the previous stage EFI bootloader should be carried over
> since they may not fully align with the reserved-memory regions in
> devicetree.
>
> Implement a helper to map these pages when the EFI subsystem starts up.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  include/efi_stub.h          |  7 +++++++
>  lib/efi/efi_info.c          | 31 +++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_memory.c |  5 +++++
>  3 files changed, 43 insertions(+)
>
> diff --git a/include/efi_stub.h b/include/efi_stub.h
> index ff3befd4830b..343c84435970 100644
> --- a/include/efi_stub.h
> +++ b/include/efi_stub.h
> @@ -56,5 +56,12 @@ int of_populate_from_efi(struct device_node *root);
>   * EFI payload with CONFIG_EFI_STUB enabled.
>   */
>  int dram_init_banksize_from_efi(void);
>
> +/**
> + * efi_add_known_memory_from_efi() - Add known memory pages from the memory map
> + * of the EFI bootloader that booted U-Boot. This is only applicable when running
> + * U-Boot as an EFI payload with CONFIG_EFI_STUB enabled.
> + */
> +void efi_add_known_memory_from_efi(void);
> +
>  #endif /* _EFI_STUB_H */
> diff --git a/lib/efi/efi_info.c b/lib/efi/efi_info.c
> index f9743a3e7fad..ef4e646b082b 100644
> --- a/lib/efi/efi_info.c
> +++ b/lib/efi/efi_info.c
> @@ -5,8 +5,9 @@
>   * Access to the EFI information table
>   */
>
>  #include <efi.h>
> +#include <efi_loader.h>
>  #include <efi_stub.h>
>  #include <errno.h>
>  #include <mapmem.h>
>  #include <asm/global_data.h>
> @@ -177,4 +178,34 @@ int dram_init_banksize_from_efi(void)
>         }
>
>         return 0;
>  }
> +
> +/* Called by U-Boot's EFI subsystem to add known memory. In our case
> + * we need to add some specific memory types from the original bootloaders
> + * EFI memory map
> + */
> +void efi_add_known_memory_from_efi(void)
> +{
> +       struct efi_mem_desc *desc, *end;
> +       struct efi_entry_memmap *map;
> +       int ret, size;
> +
> +       EFI_PRINT("Adding known memory from previous stage EFI bootloader\n");
> +
> +       ret = efi_info_get(EFIET_MEMORY_MAP, (void **)&map, &size);
> +       if (ret) {
> +               EFI_PRINT("%s: Missing memory map\n", __func__);
> +               return;
> +       }
> +       end = (struct efi_mem_desc *)((ulong)map + size);
> +
> +       for (desc = map->desc; desc < end; desc = efi_get_next_mem_desc(desc, map->desc_size)) {
> +               switch (desc->type) {
> +               case EFI_RESERVED_MEMORY_TYPE:
> +                       efi_add_memory_map_pg(desc->physical_start, desc->num_pages, desc->type, false);
> +                       break;
> +               default:
> +                       continue;
> +               }
> +       }
> +}

If this is DRAM memory that is being added, this now needs to happen
through LMB to ensure that these reserved memory regions don't get
used by the LMB allocator. You can check if something can be added to
the lmb_reserve_common() function. These regions will get marked as
boot services data. If these are to be kept as reserved memory even in
the OS, the memory type of these regions can be updated by keeping
this function. But the point to consider is that this needs to be
updated in the LMB memory map also.

-sughosh

> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index d2f5d563f2a0..50b0010608e7 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -7,8 +7,9 @@
>
>  #define LOG_CATEGORY LOGC_EFI
>
>  #include <efi_loader.h>da
> +#include <efi_stub.h>
>  #include <init.h>
>  #include <lmb.h>
>  #include <log.h>
>  #include <malloc.h>
> @@ -834,8 +835,12 @@ static void add_u_boot_and_runtime(void)
>  int efi_memory_init(void)
>  {
>         efi_add_known_memory();
>
> +#ifdef CONFIG_EFI_STUB
> +       efi_add_known_memory_from_efi();
> +#endif
> +
>         add_u_boot_and_runtime();
>
>  #ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
>         /* Request a 32bit 64MB bounce buffer region */
>
> --
> 2.47.0
>
