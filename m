Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF76F588DF
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 14:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB353839D5;
	Mon, 20 Apr 2026 16:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WS5NTvpU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EDB583BC4; Mon, 20 Apr 2026 16:28:26 +0200 (CEST)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB284805D7
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 16:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-651b0eb2564so3229001d50.3
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 07:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776695301; cv=none;
 d=google.com; s=arc-20240605;
 b=ILVlOAt7cLQSerrpGpsFHbWsCg4Gu8eizH6tp0g/OLxnoQbKFlWtie+XfZ1AEjAvfy
 NUCUaT2FRq4YjlOq/+xst6SFyDkCOaTz0SJxGmgk/SUIEda1UDYEHh4YHay+eCJGivmh
 6Z5A1VZ87v3dSnpEnjzaigMIC60G8HEUrHG9mmW4mcywmCAWhm2L2UybJJ5dz5hKDzSO
 WEegesMW1wG2xxZd23tDc0164wokKEQvQug9Pwg+WICrAQhsHJBObD3Hu07NZFfPWAer
 s4D1d0FuyTJZnTnXAlLZOGz6mEeNQibVmPCG2VvyRidd+f++Av5uwgljy9zV6QS6IMhu
 GWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w0Exsmakawlrpk9iO9N5PbEQVnljUehp+N8g6V37jZ8=;
 fh=SzNPHZIeN+k6IeQInPOGtANz36ph+KMIKXuDTTHViNU=;
 b=cHQyL0zuO06q6nVqQZOXY+AorFR079t+E/btYbqotYcs/6ysyH4SfXe5kgDpIKivzb
 vvhxE/odK8NVXLrNwCCYOavGn6FNRpXhMPkQyE8SZ5wcv8tb6nv9Hop3jzioFRgFPzT0
 RVG2JuGr1vmx6ZvMsC44MntCeE7+dlJsXv+lT2Jl/XP43rgwnjv/MVC1xurKT4yRAIF6
 ivajT+aqN5rQ6fEs2TcDMXDFqONEdOlynzZbCDup9rmQkr5Zn+dnMkfiqLkivi38QG7i
 z17gAgbxXVXsSaViHk5Rjd311MM6PU3Qm5ZzhdvuuuOgE4MgUFEkrw/joG1KnxUr1wJS
 +kbA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776695301; x=1777300101; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w0Exsmakawlrpk9iO9N5PbEQVnljUehp+N8g6V37jZ8=;
 b=WS5NTvpUpCX3AzAmL7lK2VRiD70yucZQTlNFddjD/Uq5bmR4IL/u7idAeTDYFkjtfz
 sut4jF97D88O8LlYsc6s5IyelBuoTyRxxX0h5uK7NJzx3PJ363VDeqydDyIVjrP6CZAe
 MRJupwGxEw3GhrFu8kplDcijF/oa656eEih3NIe06zXg0PEaNJ51sRNPb6y43rswHu27
 Ip7Qs7JrkCOFlCfRmwDyzE+jnmfWasQ1vGClz1gJVN1eA+XpTRHIIw7Jrv+Auqx7kdwD
 s2BbTelpMXAage7iZaIzDZFAucpltbXzEwOZhvrfeEiurpm5t33CzVWuGNO281U1cSoz
 WXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776695301; x=1777300101;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w0Exsmakawlrpk9iO9N5PbEQVnljUehp+N8g6V37jZ8=;
 b=l3o8Gcdrz/d7Iiw01gBD9VhLLi2YchURoCC/u4Ar/G6qf1I4nNkosICnWjuarvzv2x
 TVv8sGyQXw9ib4hWerT0nQg0D3KksDHJrHLj575JD+wbrtMjuck/+KiHO9N8I7qNmuQ3
 w/wgh7aHtnxEjeVgR2vyH4a0ClFHc8X5yKgnqXoFRdbGy0AuKEx16xfEm0mXDgbMIXmw
 DJVFGz4h8POdCAr+zmLxwNpgeNXpNMhkRjYmrD4M2Kyp7+Ray6QccmFMxN0YPx2YoZvz
 WBh80x1KseiWJliPg+qTbpmXhH1sk51uCVe/3kLJBRdqjIpOcwPYTUlTdPvi6vqMpTcA
 dBHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qjUT3kII5UXR7g0ydfZzPaExTA7+XUcVzo9IrpjlcEWjuv9d9vkXTZDoDMrurAEJO1Df/r1c=@lists.denx.de
X-Gm-Message-State: AOJu0YxQgiaAt7WxcEGee+Z9htTCFvUtDlKN9Gpt8HxLIdSgfVguxxiU
 3iiY6dmJ48EnP3fBF6pGLWu792VfrLuo9JoUJQDUB05EsNEDQMl4JSBiyW0ysFumy+Fe4smONWP
 65k99BeuSGmpI8XRyx0SXjxlCJl4+Nqmwb2oy1AcrcL4DyzmaeYoY
X-Gm-Gg: AeBDietMPQRux+ycfRB4xJNq9XR6CFryPuKxA1CtNvdEco3KQOrVU3D87LTofGYjDnW
 4GclRY3XWEVJE1Mu9zJG3GUxSkY/O9AEajGSgVqbyfIr7A11gNGKmZ1cudt4vhWBGhJQsl+k5iI
 5rZjr0E2T5QKK29ErdALdZgejr2XH9Fg8BFunuG5ep7u8m4pRM4URWoDFbCIKuc6WeY+tqlpgvC
 wd2HytqFjCHhkODCDt6XxhiW6TSJ+f01+6ScXweP2JWZaFMpci3QKxNMxVLN0azxCEQvlSRUJ4m
 e7BvDlpDnnkwaOsKUIdzibGXng48KKTekULIy7pnYlKFqX3eSGBuq7Q+d7NWlZxuKZ6WD59TouB
 w2qBwEwUG3ZdEfzpRx8dZaLAVd3G8QqQgUnhPTxkYnAid4SpufeU5J9SujxGlVH75r9fSEsPD+u
 NFh701zcYeLvYFmQ5QEcwGiFaWFRUrPhLOwVgPQGQ5vwFGE2JvOGv+Dj6W0jDeS14BD6L7hM62n
 4bfZu9p7NXwKMYioP2PzIFmidTfV86dWBRpiCzB++W4TAoQj6580NiBhWSXJ/MfEFvACwHijGNn
 ivRk7QtDYTA58eSTnAxJEZ6CqqlxLWPhnJyJL73QbueMHBI60J18+Yw=
X-Received: by 2002:a05:690e:4814:b0:651:e13d:21ef with SMTP id
 956f58d0204a3-6531080a7d4mr8642406d50.15.1776695301544; Mon, 20 Apr 2026
 07:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-7-rs@ti.com>
 <CAC_iWj+2=ajV0cXFT6a5Y2oqtTwcaPRcpkYqTbu4o+jbFmX+5w@mail.gmail.com>
 <DHUT7XN85MRK.18B9QGYDHEPIB@ti.com> <DHVQ3XX4U4OG.3T8QXYV5OHWFO@ti.com>
In-Reply-To: <DHVQ3XX4U4OG.3T8QXYV5OHWFO@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 20 Apr 2026 17:27:44 +0300
X-Gm-Features: AQROBzDkK1UpD8HIekP6k_KcY1CIqQUN-gTL9t_NbFFf-q1jhrBv4SdecMtSOoY
Message-ID: <CAC_iWjLWYOmbPNnOiUqNQBMYUsTAVxAVzka_Lo611RF-GbazmQ@mail.gmail.com>
Subject: Re: [PATCHv3 6/6] memory: reserve from start_addr_sp to end_addr_sp
To: Randolph Sapp <rs@ti.com>
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

[....]

> >>>          */
> >>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> >>> index b3b292ebf56..bd0d875a8cd 100644
> >>> --- a/lib/efi_loader/efi_memory.c
> >>> +++ b/lib/efi_loader/efi_memory.c
> >>> @@ -870,8 +870,8 @@ static void add_u_boot_and_runtime(void)
> >>>         /* Add U-Boot */
> >>>         uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
> >>>                        uboot_stack_size) & ~EFI_PAGE_MASK;
> >>> -       uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> >>> -                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
> >>> +       uboot_pages = ((gd->end_addr_sp - uboot_start) + EFI_PAGE_MASK) >>
> >>> +                     EFI_PAGE_SHIFT;
> >>
> >> The map_sysmem dance is still needed here for sandbox.
> >>
> >
> > Why? We're not using that address directly. We're just trying to figure out how
> > large the carveout region is.
> >
> > There's not anything funky going on with the global data structure for sandbox
> > functionality is there? LMB definitely didn't do anything to account for that.
>
> Ah. Symmetry, to answer my own question. We *may* get a virtual address.

Yes.

>
> That does bring up another issue though. What good does reserving a virtual
> region that simply maps to a physical region do? Shouldn't we reserve the
> physical region outright? Isn't that what LMB is tracking?
>
> Suppose I need to read up on this sandbox and architecture dependent virtual
> addressing scheme.

Yea and arguably we havent done a great job documenting that :(.
The tl;dr is that you are unaffected in the majority of the cases. I
wanted to fix the map_sysmem parts for a while.

Thanks
/Ilias
>
> >>>         efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
> >>>                               false, false);
> >>>  #if defined(__aarch64__)
> >>> diff --git a/lib/lmb.c b/lib/lmb.c
> >>> index 7ecc548d831..da61b005154 100644
> >>> --- a/lib/lmb.c
> >>> +++ b/lib/lmb.c
> >>> @@ -534,46 +534,19 @@ static long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
> >>>
> >>>  static void lmb_reserve_uboot_region(void)
> >>>  {
> >>> -       int bank;
> >>> -       ulong end, bank_end;
> >>> +       ulong size;
> >>>         phys_addr_t rsv_start;
> >>> -       ulong pram = 0;
> >>>
> >>>         rsv_start = gd->start_addr_sp - CONFIG_STACK_SIZE;
> >>> -       end = gd->ram_top;
> >>> +       size = gd->end_addr_sp - rsv_start;
> >>>
> >>> -       /*
> >>> -        * Reserve memory from aligned address below the bottom of U-Boot stack
> >>> -        * until end of RAM area to prevent LMB from overwriting that memory.
> >>> -        */
> >>> -       debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
> >>> -
> >>> -#ifdef CFG_PRAM
> >>> -       pram = env_get_ulong("pram", 10, CFG_PRAM);
> >>> -       pram = pram << 10; /* size is in kB */
> >>> -#endif
> >>
> >> This functionality is removed, but we still have boards defining CFG_PRAM
> >
> > The PRAM allocation occurs before this, and it is carved out of the region
> > covered by start_addr_sp through end_addr_sp. It's actually part of the reason I
> > needed to add end_addr_sp, as it moves the relocation address pointer. We don't
> > need to account for it separately now.
> >
> >>> +       debug("## Current stack ends at 0x%08lx\n", (ulong)rsv_start);
> >>>
> >>> -       for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> >>> -               if (!gd->bd->bi_dram[bank].size ||
> >>> -                   rsv_start < gd->bd->bi_dram[bank].start)
> >>> -                       continue;
> >>> -               /* Watch out for RAM at end of address space! */
> >>> -               bank_end = gd->bd->bi_dram[bank].start +
> >>> -                       gd->bd->bi_dram[bank].size - 1;
> >>> -               if (rsv_start > bank_end)
> >>> -                       continue;
> >>> -               if (bank_end > end)
> >>> -                       bank_end = end - 1;
> >>> -
> >>> -               lmb_reserve(rsv_start, bank_end - rsv_start - pram + 1,
> >>> +       if (gd->flags & GD_FLG_SKIP_RELOC)
> >>> +               lmb_reserve((phys_addr_t)(uintptr_t)_start, gd->mon_len,
> >>>                             LMB_NOOVERWRITE);
> >>> -
> >>> -               if (gd->flags & GD_FLG_SKIP_RELOC)
> >>> -                       lmb_reserve((phys_addr_t)(uintptr_t)_start,
> >>> -                                   gd->mon_len, LMB_NOOVERWRITE);
> >>> -
> >>> -               break;
> >>> -       }
> >>> +       else
> >>> +               lmb_reserve(rsv_start, size, LMB_NOOVERWRITE);
> >>>  }
> >>>
> >>>  static void lmb_reserve_common(void *fdt_blob)
> >>> --
> >>> 2.53.0
> >>>
> >>
> >> Thanks
> >> /Ilias
>
