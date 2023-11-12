Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73FAC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ACC18747E;
	Sun, 12 Nov 2023 21:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TUhbLcLV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72B9D87456; Sun, 12 Nov 2023 21:03:34 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73E648749F
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-daf2eda7efaso2150074276.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819409; x=1700424209; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BsSxMaKrcNWbAUkYrkzVcb6HHL9K+a+KNHx50GlkeIk=;
 b=TUhbLcLV2Ga4K5Unji86ioHm3hULlTL/O6iNHrSpKJcKjL8JjVPM6kJJ4G5TjQ0eiK
 UKSqaHz1oVn+Nt4NQclemN1qdgh+3iTxL2vCVY16re9fZNaRaMImkq1/GkDAunByekV/
 pSTMxgQ5J7DQS/5pghdYT2PPBPTaPx88A+7zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819409; x=1700424209;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BsSxMaKrcNWbAUkYrkzVcb6HHL9K+a+KNHx50GlkeIk=;
 b=hPZpclVw18Ck65GfXdcyScU5xn876vS1rRcsaZ2utRCFlSGWR0J0PrdIiob46EDtjJ
 OSn9xayDtRNftqQzyxMhOoOlUA+gsRYy6GbsMAq34ZRfvd9P6YSxeqVFdomuMY+IoW/f
 sJVL+cpiYmq5f+ZVNhxlzuhSWcGsSiLk27mi6jbnPLvqQagQ9T72xcgKG2zOxZdVzgqr
 hc57A9wB1KXrBYE624yZwejnYXWnIEMqUvay4082fd6/3lyF12B4NumpGCx7riCnY2EE
 WKw1zz7uA/FU5/mCHzEyvq+Q27AVZOEm0p1K4OzXoMD6U1/whSDud6NY2eeumKHhm72m
 x6fw==
X-Gm-Message-State: AOJu0YxAWDXNnmKAXtvv1LOPhBRkfPOEsko5zyDYDl5ap/Mes7/EpBLo
 4EbHYEUg3qJ+cmZI0AxZlPnwdkmRtCW7G6WgZ2IeNw==
X-Google-Smtp-Source: AGHT+IFZwwK/4c9mY84mLuaIqExhj5ZZ4ZCyb03U7WLArzKUfGLMGzjHdHRykofsNoEWkw5TnX/SFxF1lBdZfbX9G0Q=
X-Received: by 2002:a25:76d6:0:b0:d71:6b6e:1071 with SMTP id
 r205-20020a2576d6000000b00d716b6e1071mr4752963ybc.32.1699819408968; Sun, 12
 Nov 2023 12:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20231110152944.647535-1-devarsht@ti.com>
 <20231110152944.647535-2-devarsht@ti.com>
In-Reply-To: <20231110152944.647535-2-devarsht@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:16 -0700
Message-ID: <CAPnjgZ3oMx76JhJsOMRxLgDaoLqCw5emZ_yvrjPOP=881h=Z2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] arm: mach-k3: common: Reserve video memory from
 end of the RAM
To: Devarsh Thakkar <devarsht@ti.com>
Cc: u-boot@lists.denx.de, agust@denx.de, trini@konsulko.com, 
 bmeng.cn@gmail.com, msuchanek@suse.de, rasmus.villemoes@prevas.dk, 
 yangshiji66@outlook.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com, 
 a-bhatia1@ti.com, j-luthra@ti.com, nsekhar@ti.com, n-jain1@ti.com
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

Hi Devarsh,

On Fri, 10 Nov 2023 at 08:29, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Add function spl_reserve_video which is a wrapper
> around video_reserve to setup video memory and update
> the relocation address pointer.
>
> Setup video memory before page table reservation so that
> framebuffer memory gets reserved from the end of RAM.
>
> This is as per the new policy being discussed for passing
> blobs where each of the reserved areas for bloblists
> to be passed need to be reserved at the end of RAM.
>
> This is done to enable the next stage to directly skip
> the pre-reserved area from previous stage right from the end of RAM
> without having to make any gaps/holes to accommodate those
> regions which was the case before as previous stage
> reserved region not from the end of RAM.
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V2:
> - Make a generic function "spl_reserve_video" under
>   common/spl which can be re-used by other platforms too
>   for reserving video memory from spl.
>
> V3:
> - Change spl_reserve_video to spl_reserve_video_from_ram_top
>   which enforce framebuffer reservation from end of RAM
> - Use gd->ram_top instead of local ram_top and update
>   gd->reloc_addr after each reservation
> - Print error message on framebuffer reservation
> ---
>  arch/arm/mach-k3/common.c | 17 ++++++++++++-----

Please split that off into its own patch, so that the generic code
stands on its own.

>  common/spl/spl.c          | 27 +++++++++++++++++++++++++++
>  include/spl.h             |  6 ++++++
>  3 files changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index c3006ba387..6590045140 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -525,19 +525,26 @@ void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size)
>  void spl_enable_dcache(void)
>  {
>  #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
> -       phys_addr_t ram_top = CFG_SYS_SDRAM_BASE;
> +       gd->ram_top = CFG_SYS_SDRAM_BASE;
> +       int ret = 0;
>
>         dram_init();
>
>         /* reserve TLB table */
>         gd->arch.tlb_size = PGTABLE_SIZE;
>
> -       ram_top += get_effective_memsize();
> +       gd->ram_top += get_effective_memsize();
>         /* keep ram_top in the 32-bit address space */
> -       if (ram_top >= 0x100000000)
> -               ram_top = (phys_addr_t) 0x100000000;
> +       if (gd->ram_top >= 0x100000000)
> +               gd->ram_top = (phys_addr_t)0x100000000;
>
> -       gd->arch.tlb_addr = ram_top - gd->arch.tlb_size;
> +       gd->relocaddr = gd->ram_top;
> +
> +       ret = spl_reserve_video_from_ram_top();
> +       if (ret)
> +               pr_err("ERROR: Failed to framebuffer memory in SPL\n");
> +
> +       gd->arch.tlb_addr = gd->relocaddr - gd->arch.tlb_size;
>         gd->arch.tlb_addr &= ~(0x10000 - 1);
>         debug("TLB table from %08lx to %08lx\n", gd->arch.tlb_addr,
>               gd->arch.tlb_addr + gd->arch.tlb_size);
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 732d90d39e..452bf303de 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -41,6 +41,7 @@
>  #include <fdt_support.h>
>  #include <bootcount.h>
>  #include <wdt.h>
> +#include <video.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>  DECLARE_BINMAN_MAGIC_SYM;
> @@ -151,6 +152,32 @@ void spl_fixup_fdt(void *fdt_blob)
>  #endif
>  }
>
> +/*
> + * Reserve video memory for SPL splash screen from
> + * end of RAM
> + *
> + * RETURN
> + * 0 : On success
> + * Non-zero : On failure
> + */

Drop that comment as you have one in the header

> +int spl_reserve_video_from_ram_top(void)
> +{
> +       if (CONFIG_IS_ENABLED(VIDEO)) {
> +               ulong addr;
> +               int ret;
> +
> +               addr = gd->ram_top;
> +               ret = video_reserve(&addr);
> +               if (ret)
> +                       return ret;
> +               debug("Reserving %luk for video at: %08lx\n",
> +                     ((unsigned long)gd->relocaddr - addr) >> 10, addr);
> +               gd->relocaddr = addr;
> +       }
> +
> +       return 0;
> +}
> +
>  ulong spl_get_image_pos(void)
>  {
>         if (!CONFIG_IS_ENABLED(BINMAN_UBOOT_SYMBOLS))
> diff --git a/include/spl.h b/include/spl.h
> index 0d49e4a454..39f2a7581d 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -825,6 +825,12 @@ int spl_usb_load(struct spl_image_info *spl_image,
>
>  int spl_ymodem_load_image(struct spl_image_info *spl_image,
>                           struct spl_boot_device *bootdev);
> +/**
> + * spl_reserve_video_from_ram_top() - Reserve framebuffer memory from end of RAM
> + *

This needs more detail

> + * Return: 0 on success, otherwise error code
> + */
> +int spl_reserve_video_from_ram_top(void);
>
>  /**
>   * spl_invoke_atf - boot using an ARM trusted firmware image
> --
> 2.34.1
>

Regards,
Simon
