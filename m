Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40833F8D754
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 14:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73555841C2;
	Thu, 16 Apr 2026 16:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aSwSa89n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 267A9841D5; Thu, 16 Apr 2026 16:38:31 +0200 (CEST)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F24F7840AB
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 16:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6501c4857b2so5455840d50.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776350307; cv=none;
 d=google.com; s=arc-20240605;
 b=FVgFeQbnj7dEK871vdJq4w5NOf/6l1/3QSxeDOCTtvrfRNolMTyqRgXSomsxmLshPL
 Mh/hb0xE5TyjZMBtajg5Lg14jbNZ2h0/aI0YT/rdPdp6P90whKBsqpNYj2V2bfhoPjuC
 sfNDz357JVLofioz8v32Z1wE/+7hMObbXH58mB7cVhutL4z98PFIpigdezHBzHtmT5eV
 7inODUcsochk33QTDAcbjLYhImkleso7dFzbpTO+yuO06LMhLZ9/YSSKuq8UVFdpZCmA
 zQihfRFz8+OR/nd7YK4T8x7Phb2PdS1ae0HP+sZB3RmuyNTo8nzMMah2QptXJc1lPrj1
 sHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LJFY6Dez2V26yIfYpOQhdrDXwL+xBZ5pZIULDtJUlos=;
 fh=fMIRLHPrjszqdMt5C9QCjZtCMhlxKhkShnffRQVQvkk=;
 b=XfOIhi0a4vaS3y0N5HiRcSMN1n7JWGUIuROqNpe7PYKDnfff6URNAAuZdpVL6ToB+0
 +05CaXSlTHnqMnbuPHI+3x2Pw+N+3CMQp45ykBtd41yT3M+kD7sdie9HIMfy+QAbEvhp
 EsDfRcHWcjBT8PnFgLLLCdmSF1XguIv1U/j5yLXdt06f1BhJ/noV2akYx5Ei9kfCtE/n
 xoyi/leqPFynofz+PybS2h1yaYzJZ1DMrhhXINwYaKnLLBUv3vo7Z8LcEbp1YOJJQBBu
 IpyoCfuHaIRZmlQuGii68MDmDosITHJaqLiGbHYRATHeqmLib6YBa+Q7ym2fejasDpR5
 A4Ew==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776350307; x=1776955107; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LJFY6Dez2V26yIfYpOQhdrDXwL+xBZ5pZIULDtJUlos=;
 b=aSwSa89nEMrstbB0Fkket8p1EoBdzH2221ruMmSFqrVCuUtW9AdbNNO1cDoIrJV5HB
 FoPMm+pycIcMQxcKdrIKxm5GriwA1mcHZMhX2LABEl4gu5+o49h6xgbZwc7zfr4UbPjp
 o+3ClAr3JLvMneBged4v00Pz1DNr3u1JcWQ50mlnCsWKFVp71nuWUQtJ/d8IskQmvbhO
 N/NxJlX2bnXWSscJpQhXjobc6pSiEsRqoFm0iA0DBatIMzEjxXLtk13UOPvK5UhPDOJs
 77Q3QaAPwzUrCfr8YQ8YCk4enXmlzBWBbfG8a5fSsA2qcr9OMXfU8ZYN4Mf4sR/5xcE2
 WCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776350307; x=1776955107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJFY6Dez2V26yIfYpOQhdrDXwL+xBZ5pZIULDtJUlos=;
 b=G3I+hQrLGOu4s9Q8Zpv6J2ruC7dMf0vXyWjw/1Jkreb6ucaDiH6HvhWEq4wSzfBP7o
 epntcBULkrNlsOu50J8cYFsMWUcvZvUA0DkYAc8s+Kwc9uUafJydToP1QM1bx9Xo3sv4
 KGUDXyRwt+msleb/4ez8M9wXoaENyMcuql0tRGLLBXTVsb+7AZ8tAlRlanYnmktYBdP4
 2jmBW5hwl0MJspyqRscgy1GPAUvQqhEZh89RTT7yoBxpRZkr2XzMtp5MEqG4W8IJccXX
 ppcT2pdZtEvpplDMuZLRhntFkQDIYFc5v4IPeUtrmDrMxnM1dLBUbIMj7EbakoNP4VRZ
 jODg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+M+T1Y4Q79K3aA+s0JrLRSwiEMj/PFQHMiDetNUVHTEyD3RyBDQAGOj38NRe/ZrCnUa9sqRwU=@lists.denx.de
X-Gm-Message-State: AOJu0YxGZrft+XKF9hEN+y5XG1612D9kAowgtZNJ5OzD8Y3coews78Qz
 bYAbp3DX/CuZn/GbkA5CXrH2YTTUUDFYlWdEkq9G3xyOb5kphWTiwzI2wsR7NcU6z7WWps3oglg
 pdBrvVDM2APYrCU/job6OEbb9k31tF6xy7pmFFAn9Lg==
X-Gm-Gg: AeBDiessJ0RdRzh9CrfomBjJq8biDilro9K27Q1g1q922RTrMABCDX7lQweAsb46kcH
 Rhzz8V0qBh5c9iuylyMrzywbd6MWf4OUsyTKVGcakFxcse01AT9NfcyYR7+7T4MbwgT2SR+5ukf
 za2ICS3bIrUpaPV3hDGMsX4/lk8bxKQy0acsYpzqjptdm3Rd46R/u73hnVGMsRa73ruVBf295sP
 tqn8JLL72Cupex7LoV4mW1IUZAuKsSUqr0gJ/A9oOsooEf/ezKb5Vna/gdW0A79FReRGKCM0odr
 5/2T8gAH5e/ebW8S66HuHsXOzPGgqEtD2jSRhSuhd4mXDpGUGuxOVEuSUuMoCEQ/KKSEN5Z2NY5
 7GC1ukvJQbZ5D74kXqRI+MzdcPxtfvQiEiChu2lJVFcaoh8UU/BOSFhSsBiy0BmfnNBRKHY/kzi
 J6x9oymL7MQWgjUtJckKmbL3ifiga+/hwhYKgE14wMtEiy9Zi95jyDPz8hAf3b4jBmy6RrMkN16
 BnKY6Pie2ZpbetBpgeP4VCC7lTZEMuvMKDCkbtAxZbqQngXGyTe/wi5cu0g86SdxmyFwDZS78vB
 Uamg116C7OU9+41mk5nr/4hU+vLrxYK2MFQxUDbtUffy
X-Received: by 2002:a53:d015:0:b0:651:b8a6:3236 with SMTP id
 956f58d0204a3-651b8a6445dmr17512840d50.62.1776350306691; Thu, 16 Apr 2026
 07:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-7-rs@ti.com>
In-Reply-To: <20260413203555.1990337-7-rs@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 16 Apr 2026 17:37:49 +0300
X-Gm-Features: AQROBzDQicxpm2mzz0HFL74g2_n9uy2c40A3weGq1pjMErJP5Ek60joUNxqw_zo
Message-ID: <CAC_iWj+2=ajV0cXFT6a5Y2oqtTwcaPRcpkYqTbu4o+jbFmX+5w@mail.gmail.com>
Subject: Re: [PATCHv3 6/6] memory: reserve from start_addr_sp to end_addr_sp
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, u-boot@lists.denx.de
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

Hi Randolph,


On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
>
> From: Randolph Sapp <rs@ti.com>
>
> Add a new global data struct member called end_addr_sp. This stores the
> original value of relocaddr, directly from setup_dest_addr. This is
> specifically to avoid any adjustments made by other init functions.
>
> Reserve the memory from gd->start_addr_sp - CONFIG_STACK_SIZE to
> gd->end_addr_sp instead of gd->ram_top. This allows platform specific
> relocation addresses to work without unnecessarily painting over a large
> range.
>

Is there a platform we can test the changes? Running the in QEMU had
no differences.

> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---

[...]

>  #ifdef CFG_PRAM
> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> index 745d2c3a966..2f3ef26a17c 100644
> --- a/include/asm-generic/global_data.h
> +++ b/include/asm-generic/global_data.h
> @@ -115,6 +115,12 @@ struct global_data {
>          * @start_addr_sp: initial stack pointer address
>          */
>         unsigned long start_addr_sp;
> +       /**
> +        * @end_addr_sp: the end of memory currently in use by uboot,
> +        *               should be the original value of the relocaddr before
> +        *               any other allocations shift it
> +        */
> +       unsigned long end_addr_sp;
>         /**
>          * @reloc_off: relocation offset
>          */
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index b3b292ebf56..bd0d875a8cd 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -870,8 +870,8 @@ static void add_u_boot_and_runtime(void)
>         /* Add U-Boot */
>         uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
>                        uboot_stack_size) & ~EFI_PAGE_MASK;
> -       uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> -                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
> +       uboot_pages = ((gd->end_addr_sp - uboot_start) + EFI_PAGE_MASK) >>
> +                     EFI_PAGE_SHIFT;

The map_sysmem dance is still needed here for sandbox.

>         efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
>                               false, false);
>  #if defined(__aarch64__)
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 7ecc548d831..da61b005154 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -534,46 +534,19 @@ static long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
>
>  static void lmb_reserve_uboot_region(void)
>  {
> -       int bank;
> -       ulong end, bank_end;
> +       ulong size;
>         phys_addr_t rsv_start;
> -       ulong pram = 0;
>
>         rsv_start = gd->start_addr_sp - CONFIG_STACK_SIZE;
> -       end = gd->ram_top;
> +       size = gd->end_addr_sp - rsv_start;
>
> -       /*
> -        * Reserve memory from aligned address below the bottom of U-Boot stack
> -        * until end of RAM area to prevent LMB from overwriting that memory.
> -        */
> -       debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
> -
> -#ifdef CFG_PRAM
> -       pram = env_get_ulong("pram", 10, CFG_PRAM);
> -       pram = pram << 10; /* size is in kB */
> -#endif

This functionality is removed, but we still have boards defining CFG_PRAM

> +       debug("## Current stack ends at 0x%08lx\n", (ulong)rsv_start);
>
> -       for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> -               if (!gd->bd->bi_dram[bank].size ||
> -                   rsv_start < gd->bd->bi_dram[bank].start)
> -                       continue;
> -               /* Watch out for RAM at end of address space! */
> -               bank_end = gd->bd->bi_dram[bank].start +
> -                       gd->bd->bi_dram[bank].size - 1;
> -               if (rsv_start > bank_end)
> -                       continue;
> -               if (bank_end > end)
> -                       bank_end = end - 1;
> -
> -               lmb_reserve(rsv_start, bank_end - rsv_start - pram + 1,
> +       if (gd->flags & GD_FLG_SKIP_RELOC)
> +               lmb_reserve((phys_addr_t)(uintptr_t)_start, gd->mon_len,
>                             LMB_NOOVERWRITE);
> -
> -               if (gd->flags & GD_FLG_SKIP_RELOC)
> -                       lmb_reserve((phys_addr_t)(uintptr_t)_start,
> -                                   gd->mon_len, LMB_NOOVERWRITE);
> -
> -               break;
> -       }
> +       else
> +               lmb_reserve(rsv_start, size, LMB_NOOVERWRITE);
>  }
>
>  static void lmb_reserve_common(void *fdt_blob)
> --
> 2.53.0
>

Thanks
/Ilias
