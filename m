Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470A8CD6E6E
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 20:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87C9A84957;
	Thu,  4 Jun 2026 22:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yz5xSjD+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE1D684962; Thu,  4 Jun 2026 22:20:15 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0D6884944
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 22:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-660e9fef1d4so1449771d50.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 13:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780604411; cv=none;
 d=google.com; s=arc-20240605;
 b=jbDC/xQlxdVIP5iw6MvOOuCHCE24d0CBkLa1YZu7Dmw3Sp1blVq3h/3R36GBoiw9vp
 veFHiZkJd1D+UG2uKh5/37nfiMzBhhPA9OhkWgGmyy4znYWSw51LkcOpRdOHD9SM750k
 6/592XLPXp6de3vCLtXuhsWV8EJGTsoTuK00HgPxJvGlabmVReaK8sCxOAQdNtcxGLHe
 ShitqIHzDv5eee3/cY+hvDUUQ0pJ8LmylwpaJhy4lXvGC5NtJE9QJZEiGqH9MfujKSIR
 25yVZj9fstsXsjbtVkCluh6+FlkyrQ4hzvlqNiwhufinIJbo3NmYrcxfaCCOChKmEB3Q
 ZIng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HRK2R3ZW1goo79UKpc26pL9XAUyqGUXwOlvcs9vDwE0=;
 fh=GpGsPLVAJBOQFFBzSUENsxLoOYdphKMRbbFIq/lx+0Y=;
 b=cjZTVR+dYu13n+/WCo3ON5oroj9DzqsE/VajXwncJvRQiAjZYyfOhXF2EwcVQw1XAx
 6pN41mvsXQIM2QQeAbRxP3kukBt5Mux6uV1dmNZA/QrAf0zTyT0hj1NtM8pG+40xF09S
 571VBT6CVNWSEVJV7dwjrkB2zJkD+X/jPAe3Vfv+b3syEqaWpeoev56akrIdhYQjKucw
 ewizLmY50i5XEDMqzYsR4oOO79PbHkNOQtuOBG31fIeOc4VaGf9dbPakPtdpQitLxTIE
 wwc6R50QA+gJ4rN3ZbAOlcZxYnlD2OrW2Ecnutp4tu4lNk2dHQnpvc6ut6L5OSCh59yO
 0f+g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780604411; x=1781209211; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HRK2R3ZW1goo79UKpc26pL9XAUyqGUXwOlvcs9vDwE0=;
 b=yz5xSjD+eZ97O287ZJsMuWEsuYFTdhIF+3DyrYzL/9F+5787rRYA2HgIFPwSrOp/6x
 v6sN8KCiaF6W3cCRz5N4YpgeoKybHHIVptTBZUnJIeXa+/P1MTa2j6Bf/xqQFhSWcsM0
 BQYm3ya1nVfuvpIxoQOlzlHDroyX1m6OCVODUcWVI9yxIId7rWks/SG//mjccmB2ZoC6
 YeeOJdtPIPi9NttodlgJPaq9zyQu/hsvokfXdVnLbwejWx0PcbWt9pWvxN3as3nu3eAt
 WNKFzZMszEna3lIaqKaR6BkQoyBDT9Zgdo3TIP2Adm3PYVsii8kaS/rphYOtq88nXYub
 F7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780604411; x=1781209211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HRK2R3ZW1goo79UKpc26pL9XAUyqGUXwOlvcs9vDwE0=;
 b=F8jXtsALsABCPFJqjphroOf0/mat/yV79QeHTukxoz5kHojCQMbCTIjqFA/8AUB1pd
 Tr7zvcL+xWnC86R5WfXDl0vx1c4nDMinp+3Qf3ghYA8vysi3qu3JN4qXChUZbkzjuzqS
 9lcFCQfBIGMuZH9brrLio8sT7RYoQeUFZze0m1U6s/wnnIaXXHukRJZZVlhNM43vc/vL
 3rl9LycfCejAOhsMgyBFRkX4rtOYrGWPzItqSB/Ckj9pcFrluDl6V/2+K5TtX+qjGtXj
 083b63OSeakcbVADVvEr1TsR/s4+CceHs+l4s2/lt4r8VjVijk6tOJu9iGEVLJpuzyBg
 Mm1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ia5gByaMcffx5LPd9lbimRfrFKZp7lOZ9vGWMmOQVww1gl72OhmvBrRURjKaXolcLnZq9A5c=@lists.denx.de
X-Gm-Message-State: AOJu0YzX72MqD0drCkM57ZGU9vr/tj6e0O9fnLzCStkwr+IJyCgiQ2UN
 fIARMO700D4+dyjq2Xgqq/fhrm9RgBSw4bOrpmaJtbYUDVd2+q/C9tiwxV3CaG8Ll4lPEhmuc4w
 XBDlgB6G0sJNBhNgScOodogLs+CeDTs5PSopOmPq+3w==
X-Gm-Gg: Acq92OFpRGChVfBKYKDH4QlqXo/Etp/ejVXyIi5BEDgOGimVQZlUOAU45E5Ys1NpzKr
 3bncUyykJ04FBden49PhOWZjElN4s9oHplBizqbnDOSYq1jwtqafj3V2qav42qa4nUilQdt2cqe
 NfWNL4PbeLjS7hJPLCbvW0n88kYdylGiSlqGTq1UI59hAm+bT8iLal2VbdNhAp0N1Ifl/ZbL1bt
 rcIId4eAmgHpi3RETyzXFYlZeEtgNt0YtAVrWvfjSGZ4+8HoluO/JlfKjh47QBJk7VbRWF2Z4a2
 pjK3QPXYRqiP5DF6ZVTBAvNOInNUh7DqT5yk4be+moujF7HXNWIIz9jPd3zv4sCqlh4eW2+WecZ
 jNkTdJVN5Zxm2M2Jyd1UFuNlXffnodv68WZ7gASdY05L/sgqm+iHGmjetGMLFQB+MuWBMprsP/m
 BpJxR9n5POijndhMQoQEDZqPidsfeQdTHvAxsSH5aw7d8UL5cB7dGsXlysW63+a7kL6wZcGNZ4w
 bnCtKkTM8bI3O0+JAfi1xrS2j1vrgtTrn8sGw0k2MCsUoZq0uMux2zb3naekb3uLHSyva+vEIf4
 MPb3uzeMHecuWVv3w4Vqi0sFOJkuRatyrPlc201lwZoss+Of0k7UnAV5TQ+N9kGoU5OpYis3HT5
 EO5doYmalXT0xtG1hwjOxCtaY4QU=
X-Received: by 2002:a05:690e:b85:b0:661:80f:5984 with SMTP id
 956f58d0204a3-661080f6b86mr90153d50.12.1780604410912; Thu, 04 Jun 2026
 13:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260604155038.3182-1-rs@ti.com> <20260604155038.3182-5-rs@ti.com>
In-Reply-To: <20260604155038.3182-5-rs@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Jun 2026 23:19:34 +0300
X-Gm-Features: AVHnY4LSg2uv-ZnNR42RaYAnH0otKHehwQRIBm4BQvno2pNSJ4OXQc_iDaz145M
Message-ID: <CAC_iWjK=e2zqCg3rKSr0-w5Poi6q4nHKeq5eZsDBkSOz8e8xRA@mail.gmail.com>
Subject: Re: [PATCHv10 4/4] memory: reserve from start_addr_sp to
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

Hi Randolph

On Thu, 4 Jun 2026 at 18:51, <rs@ti.com> wrote:
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

Looking at this again, I don't think you can reserve only up to
initial_relocaddr. That's the base address we relocate and everything
else (.data, .bss) etc should be living above that address. We have to
account for the size of the relocated u-boot binary + bss and reserve
those areas as well.

Cheers
/Ilias
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> v7:
>         - Reinstate bank hopping logic for U-Boot reserved region
>         - Update description for gd->initial_relocaddr, make it clear this is
>           also an exclusive value
>         - Leave the PRAM region out of the reservation. Previous commit messages
>           indicate that this is intended.
> v8:
>         - Adjust initial_relocaddr doc string
> ---
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
> index 2feb29f0a2c..c3da7c20cb2 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -871,7 +871,7 @@ static void add_u_boot_and_runtime(void)
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
