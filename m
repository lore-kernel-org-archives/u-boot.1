Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CCDC5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:47:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C846C88B36;
	Fri, 23 Aug 2024 22:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kDKzysVw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C177888BFD; Fri, 23 Aug 2024 22:47:40 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8CF588A99
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6bf9ac165d3so13307256d6.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724446057; x=1725050857; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sj5ohp6527wcmIFSdUXTyvq9Vu9++L+QxXnz7NqE/EY=;
 b=kDKzysVwnIXjQKpHyUlpGMi1NNxRKj99Fnwv/lseB7KvPMx4RaYptLb5rVU3ZI9eBN
 ZrfRzNFAkeRY/ET7/176LTy6aACagx7UFNsX1l3ky7gO1ASuM2/K5RPOXx0E/7XHRJlH
 nxjbNQKeqp0G/Wp+HhdSwGeQSvAYV1OEQDt9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724446057; x=1725050857;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sj5ohp6527wcmIFSdUXTyvq9Vu9++L+QxXnz7NqE/EY=;
 b=cFSNCMeRP+bLxzu5yjqgOqOk4hQOR0eVebHonDEabCRJdgPwpXbQoN5PGU1Sl5WD2c
 QtCqvp4p9gx4EuxLm6ByC7ob3ukXcbF6K4Yg/XDQ6ugj0NiFXkgiiDJ13DmrjvS5S9fr
 clTD4xe+udiFLnHqvsCFdjHtFijANRHp9gELZiBht9pQeZsfYo79BrIfTWq2PqD6om/Z
 gACKdqvWWo7OQ93eJkKb2q2K7Cu/m/gnqCi6f9rdN0ygOsKkxcdJx3xICaZktSbVvVlJ
 ZDKB1GWGCdu4xiqvr1Yl36s2iOrKZh5lezkZaFi1LZrnZc7g/J6AgwFAGBO51C7QkTX0
 Ub5g==
X-Gm-Message-State: AOJu0YxjrpF+Z53eUUhnycJHSjHH2DPcXOvBa5a7DTUvbSo4GCpPtnUd
 N/mNpO7pw+/T842XHJ5RchNCIGPHbClRnNyKQSomM7idPFZA9fGSfC4KW2tgfrs1+CC84P81flj
 Bvf1TOXZFjEt+TTgZXvcd7i+Cven00xCQO+B9
X-Google-Smtp-Source: AGHT+IGKALaiYNdtoLrJPwfm5bggEJVEvEsItpXw9voHJSLVncTTS7QnH1+g4CUUhwTtPD5Rbr/mtHKxMY4N9AEcglg=
X-Received: by 2002:a05:6214:3f8f:b0:6b4:b179:8eea with SMTP id
 6a1803df08f44-6c16dc2a9famr42068066d6.3.1724446056637; Fri, 23 Aug 2024
 13:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
 <20240821105839.2870293-18-sughosh.ganu@linaro.org>
In-Reply-To: <20240821105839.2870293-18-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Aug 2024 14:47:26 -0600
Message-ID: <CAFLszTiuOTquP5sztthp=zgb=u-c2ZADu8Rw6E-AhPV2Up9m3A@mail.gmail.com>
Subject: Re: [PATCH v3 17/27] lmb: do away with arch_lmb_reserve()
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
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

Hi Sughosh,

On Wed, 21 Aug 2024 at 05:00, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> All of the current definitions of arch_lmb_reserve() are doing the
> same thing -- reserve the region of memory occupied by U-Boot,
> starting from the current stack address to the ram_top. Introduce a
> function lmb_reserve_uboot_region() which does this, and do away with
> the arch_lmb_reserve() function.
>
> Instead of using the current value of stack pointer for starting the
> reserved region, have a fixed value, considering the stack size config
> value.nit
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2:
> * Remove the definitions of arch_lmb_reserve() and
>   arch_lmb_reserve_generic() functions.
> * Introduce a new function lmb_reserve_uboot_region() and call it from
>   lmb_reserve_common().
>
>  arch/arc/lib/cache.c        | 14 -------
>  arch/arm/lib/stack.c        | 14 -------
>  arch/m68k/lib/bootm.c       | 17 --------
>  arch/microblaze/lib/bootm.c | 14 -------
>  arch/mips/lib/bootm.c       | 15 -------
>  arch/nios2/lib/bootm.c      | 13 ------
>  arch/powerpc/lib/bootm.c    |  9 ----
>  arch/riscv/lib/bootm.c      | 13 ------
>  arch/sh/lib/bootm.c         | 13 ------
>  arch/x86/lib/bootm.c        | 18 --------
>  arch/xtensa/lib/bootm.c     | 13 ------
>  include/lmb.h               |  2 -
>  lib/lmb.c                   | 83 ++++++++++++++++++-------------------
>  13 files changed, 41 insertions(+), 197 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

question below

[..]

> diff --git a/include/lmb.h b/include/lmb.h
> index e6c6f1cdcd..6e435bd35c 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -108,8 +108,6 @@ void lmb_dump_all(void);
>  void lmb_dump_all_force(void);
>
>  void board_lmb_reserve(void);
> -void arch_lmb_reserve(void);
> -void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align);
>
>  #if CONFIG_IS_ENABLED(UNIT_TEST)

There is no need to do this in the header file, BTW. It will cause a
link error if someone uses it by mistake.

>  struct lmb *lmb_get(void);
> diff --git a/lib/lmb.c b/lib/lmb.c
> index e26e329248..1116b2b868 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
[..]
> @@ -215,10 +179,50 @@ static __maybe_unused int efi_lmb_reserve(void)
>         return 0;
>  }
>
> +static void lmb_reserve_uboot_region(void)
> +{
> +       int bank;
> +       ulong end, bank_end;
> +       phys_addr_t rsv_start;
> +
> +       rsv_start = gd->start_addr_sp - CONFIG_STACK_SIZE;
> +       end = gd->ram_top;
> +
> +       /*
> +        * Reserve memory from aligned address below the bottom of U-Boot stack
> +        * until end of RAM area to prevent LMB from overwriting that memory.
> +        */
> +       debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
> +
> +       /* adjust sp by 4K to be safe */
> +       rsv_start -= 16384;

Should that be SZ_4K ?

> +       for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> +               if (!gd->bd->bi_dram[bank].size ||
> +                   rsv_start < gd->bd->bi_dram[bank].start)
> +                       continue;
> +               /* Watch out for RAM at end of address space! */
> +               bank_end = gd->bd->bi_dram[bank].start +
> +                       gd->bd->bi_dram[bank].size - 1;
> +               if (rsv_start > bank_end)
> +                       continue;
> +               if (bank_end > end)
> +                       bank_end = end - 1;
> +
> +               lmb_reserve_flags(rsv_start, bank_end - rsv_start + 1,
> +                                 LMB_NOOVERWRITE);
> +
> +               if (gd->flags & GD_FLG_SKIP_RELOC)
> +                       lmb_reserve_flags((phys_addr_t)(uintptr_t)_start,
> +                                   gd->mon_len, LMB_NOOVERWRITE);
> +
> +               break;
> +       }
> +}
> +
>  static void lmb_reserve_common(void *fdt_blob)
>  {
> -       arch_lmb_reserve();
>         board_lmb_reserve();
> +       lmb_reserve_uboot_region();
>
>         if (CONFIG_IS_ENABLED(OF_LIBFDT) && fdt_blob)
>                 boot_fdt_add_mem_rsv_regions(fdt_blob);
> @@ -689,11 +693,6 @@ __weak void board_lmb_reserve(void)
>         /* please define platform specific board_lmb_reserve() */
>  }
>
> -__weak void arch_lmb_reserve(void)
> -{
> -       /* please define platform specific arch_lmb_reserve() */
> -}
> -
>  static int lmb_setup(void)
>  {
>         bool ret;
> --
> 2.34.1
>

Regards,
Simon
