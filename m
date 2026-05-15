Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470ACCD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 07:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98F98838BB;
	Fri, 15 May 2026 09:39:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XyCYjNtC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B46D2839D9; Fri, 15 May 2026 09:39:13 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55AC5836AC
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 09:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-65c477a3278so10991619d50.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 00:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778830749; cv=none;
 d=google.com; s=arc-20240605;
 b=iDABhSkprkFRyAJgqXTzdCtFIIUVlfjVGIEeSHhDrjMD/GyQ43t471rRS0mfYnF+ke
 BtPEDAbJ6L8K6ScgXTcheeZ1ZtKXxk3mBYFUWaq3o+QmNGjvtl94KRZwDF8L3XaCkpJ8
 Ky7W32zY9E4NIVembcgcyBF/GgCTVYRCQEhyPU6fiUdJM/HGDmYcl85RyFm8R8a2tEg2
 UZ3/SOcVLi1C5C/qQv2uyEymBHJiEwZY1iE5inCRp32Eev0j2jTjxoCzgk2KIIPu1mfe
 iZ+bEvPJBGfurMuf0Bmu7KaamrEWqNBY+sJdcbKuLkQF/iH/zf6Z6GITY6w5ZYD9zIPn
 LywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YWhvcbNhc3evB4nV7DZ4YrnkqFGFGqsKbEdYWXpsRqU=;
 fh=dVa0TW8tP86BWtD/Q+x7fjJG8AULtcK3I90hkN1QKj4=;
 b=DXdK6EaYB8XL7ekBQl/juMBAGj8Fgl9dDEex/ulV9p9lBHjC8FkLCCrSkpdZgA/2Uy
 AU4AW1TaFi5ZthyDGJo/th2y+Hu0NZNBDfounKxc8KhDF0sZquqxHBEeBRoq7iezGwjU
 yZ0hM2uAaZllB/GDK7kdKKwLn86laM+vjLJBNZyLXdRoc5lYKm4aur8jrZyB92Jwwp8f
 G7HAlJ43QBqyGmxW64kGF8xwCNULy9tvrn6lKvTsMMeGwj4nPcI0O+z+IR6IxGZYOxDR
 GTNHA+JA8dRFsFNkFbkj1HkVqRdHgRVgWw8hzXuLDFoKXFlUiffQuS5DfN6X9gto7aC0
 l3AQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778830749; x=1779435549; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YWhvcbNhc3evB4nV7DZ4YrnkqFGFGqsKbEdYWXpsRqU=;
 b=XyCYjNtCVmcIjgQD30aLrURQbQoS19/yc5ftNZjU47A+SCGo3oenNw59cA8Jx8jDu1
 ITTcrHDGWePJELG6egVhC8oQFytiBpjY7XEB1vkTjA8NNR7A1bkiGmYYBQgZER9JHGi1
 n1/j4EclNSPA5gCGMDcR1m+XKzLekJi0gRVtfrLdn9Q2cGGQNZb99v8LlzM28xSPXZFB
 Sq6hTl6/Qxk8CAZ8QGmfTiOgnIiVeBApvxDNjQDMGAU+p/H01ZJw+yIKXlzcd4SAeo+O
 +vdepjpzsodJC7nuIIhQ+4sYCivCY4LSwTuUlubNFNhFb+nRduwy9pFiKGuUpkYPMXrV
 vOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778830749; x=1779435549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YWhvcbNhc3evB4nV7DZ4YrnkqFGFGqsKbEdYWXpsRqU=;
 b=JAn8MA160eNWCZG4vsV++HJrYGt0/whqvyhYZP1C+efjcxwlYFlP6IyaiG6JDuJugm
 GBsBNApud2Hph6rM4jIKfPfmixiCcBIc/sjJYmQcWZ4wAUwDcRJT8UUc6NPjuhvuKF/e
 SiVEM7rj2ZkNBkFNFOHbqTaoaah3eb6BOOEAUxTeHbXFiO6uXbq0xG9lxduZPXSht7iV
 8oOG6ctZkRum45c/fk0TlcVDgUbR0IcTzTSqn80u/t55fAHUpbW6PZctJJgRkWtxUi/R
 JQoqLuf5HDWCHQS8nOpDRVRkrFpIg494nRYMrfjenVtezTFVspTgdFVjJ8fov3n3tF1D
 r3+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mRXmSt3S+WZzFziq8dxracrZoyxvhcMY7QCCZowF9xI/CnAVojOjgiRKj2W/OwVaHOhvsQ0s=@lists.denx.de
X-Gm-Message-State: AOJu0YypV8Rim0tOVFXiC3TRGU8XYTSYSJS5XIXM68Gp/LcjFIgi7z67
 mJwB4cNUUkGuQSSmcjN9dbgxEx5O8Gg+S5pkj53JOJJiVdUfOlQg76QBHcqc39+MLj1Lv/nWep2
 H1iNxbn8Xl3FgMP532T+mVq2E12Z44dc1BdkE30RpNw==
X-Gm-Gg: Acq92OH65z44YugxjSxQF8wLbF5OlkLFtJCDryFz6n2f4XESDAlwGYvCjKTfeATrGEE
 NUdpBKqhnF5rY3fC05DHSRm8ToO7n8734VmA0Q4pA/VvXNEqKEuI7HHZ+Tf4aEs8mzJDQfT+Fjy
 shSEikt0VFEsGxc6rZhJ9E6tW+ejePi0/Vbs6+8WbnEdNc2PMd726EZz4mEetkFWWHQP8eeIbKX
 TkZmzus8Em2Elhy0yi/b0D2CtXK2rEDfZicX5D3itHAtOpBGNhbXlrNDtBStQPEI1u/hostJTFD
 PzqLHkLqStLS3u/ziHpdZOceE9Eezy8b1VZ2mNmqvVbdWVzGWOnOe7UKUKgE6c4BGvyUYzzHINn
 qF5NuQ8Cpsrc96JKKJSAl77LWRawQdL2UOhASCiWJ7f1i8LzPon04+K00KsybehxBNDpNsPLsMz
 HSPjV+Pzc/suwDwk9DfME42t851bX/xiC77nqFDc/4BafnwjZVrzusOQ1VKNhQ55k9S6pS7GUOD
 GubejJXFrRe3o5+F7kJY7CxGL57OHMz1D5rYJhmznTTP+BGwad7+B1pvxmiONT4Z/61kvlK/7Kq
 ORo994i6owBxLmx86e78/pIxjapV+Ip2dFcp/G7XrbXHrvbzJJ3k57GdRdmCIcBiFud7PwkV7tO
 8lVsM2A==
X-Received: by 2002:a05:690e:4385:b0:65c:1a0f:d8bf with SMTP id
 956f58d0204a3-65e2285e665mr2065949d50.50.1778830748860; Fri, 15 May 2026
 00:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260513204943.736142-1-rs@ti.com>
 <20260513204943.736142-4-rs@ti.com>
In-Reply-To: <20260513204943.736142-4-rs@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 15 May 2026 10:38:32 +0300
X-Gm-Features: AVHnY4L4H7imJVFdxWYZnj7tnOM-9n8rwr5EKisCbKFQbkHv4NEBkBAfRnQBN7o
Message-ID: <CAC_iWjJnLi4apE7LY4b4VB5yujyjZhxEk+sbB50snkPk0wqiYA@mail.gmail.com>
Subject: Re: [PATCHv8 3/3] memory: reserve from start_addr_sp to
 initial_relocaddr
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, sjg@chromium.org, u-boot@lists.denx.de
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

On Wed, 13 May 2026 at 23:49, <rs@ti.com> wrote:
>
> From: Randolph Sapp <rs@ti.com>
>
> Add a new global data struct member called initial_relocaddr. This
> stores the original value of relocaddr, directly from setup_dest_addr.
> This is specifically to avoid any adjustments made by other init
> functions.
>
> Reserve the memory from gd->start_addr_sp - CONFIG_STACK_SIZE to
> gd->initial_relocaddr instead of gd->ram_top. This allows platform
> specific relocation addresses to work without unnecessarily painting
> over a large range.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> v7:
>         - Reinstate bank hopping logic for U-Boot reserved region
>         - Update description for gd->initial_relocaddr, make it clear this is
>           also an exclusive value
>         - Leave the PRAM region out of the reservation. Previous commit messages
>           indicate that this is intended.
> v8:
>         - Adjust initial_relocaddr doc string
>
>  common/board_f.c                  | 9 ++++++++-
>  include/asm-generic/global_data.h | 9 +++++++++
>  lib/efi_loader/efi_memory.c       | 2 +-
>  lib/lmb.c                         | 7 ++++---
>  4 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/common/board_f.c b/common/board_f.c
> index ce87c619e68..aeb53b4c274 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -330,6 +330,8 @@ __weak int arch_setup_dest_addr(void)
>
>  static int setup_dest_addr(void)
>  {
> +       int ret;
> +
>         debug("Monitor len: %08x\n", gd->mon_len);
>         /*
>          * Ram is setup, size stored in gd !!
> @@ -356,7 +358,12 @@ static int setup_dest_addr(void)
>         gd->relocaddr = gd->ram_top;
>         debug("Ram top: %08llX\n", (unsigned long long)gd->ram_top);
>
> -       return arch_setup_dest_addr();
> +       ret = arch_setup_dest_addr();
> +       if (ret)
> +               return ret;
> +
> +       gd->initial_relocaddr = gd->relocaddr;
> +       return 0;
>  }
>
>  #ifdef CFG_PRAM
> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> index 745d2c3a966..8d1d49b1133 100644
> --- a/include/asm-generic/global_data.h
> +++ b/include/asm-generic/global_data.h
> @@ -107,6 +107,15 @@ struct global_data {
>          * GDB using the 'add-symbol-file u-boot <relocaddr>' command.
>          */
>         unsigned long relocaddr;
> +       /**
> +        * @initial_relocaddr: top address of U-Boot in RAM
> +        *
> +        * This should be the value of relocaddr after setup_dest_addr() and
> +        * before reserve_pram() or any other allocations or reservations shift
> +        * it. This address will, depending on the platform, be equivalent to
> +        * ram_top and should also be considered an exclusive address.
> +        */
> +       unsigned long initial_relocaddr;
>         /**
>          * @irq_sp: IRQ stack pointer
>          */
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 046a2bb4641..9d7eda9422f 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -869,7 +869,7 @@ static void add_u_boot_and_runtime(void)
>         /* Add U-Boot */
>         uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
>                        uboot_stack_size) & ~EFI_PAGE_MASK;
> -       uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> +       uboot_pages = ((uintptr_t)map_sysmem(gd->initial_relocaddr - 1, 0) -
>                        uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
>         efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
>                               false, false);
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 8f12c6ad8e5..27c8565e590 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -540,13 +540,14 @@ static void lmb_reserve_uboot_region(void)
>         ulong pram = 0;
>
>         rsv_start = gd->start_addr_sp - CONFIG_STACK_SIZE;
> -       end = gd->ram_top;
> +       end = gd->initial_relocaddr;
>
>         /*
>          * Reserve memory from aligned address below the bottom of U-Boot stack
> -        * until end of RAM area to prevent LMB from overwriting that memory.
> +        * until the original relocation address to prevent LMB from
> +        * overwriting that memory.
>          */
> -       debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
> +       debug("## Current stack ends at 0x%08lx\n", (ulong)rsv_start);
>
>  #ifdef CFG_PRAM
>         pram = env_get_ulong("pram", 10, CFG_PRAM);
> --
> 2.54.0
>
