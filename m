Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87057C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 541CF87D85;
	Tue, 20 Feb 2024 14:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tV+l1YeK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FD9787D85; Tue, 20 Feb 2024 14:46:55 +0100 (CET)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EA8A87D7E
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-47063d4b17cso863987137.1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708436807; x=1709041607; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iFF76GW5PWPJpHijLrw95ZRBCTbwcHynZ4N19te2AUE=;
 b=tV+l1YeKq1egNJ05PvaWSqjfpnbIAuNBQkYpcxN4EBJO2RJ3h/AF27v4S82Br+OPOO
 lwEKyWWdUPhLkJ++phP3Qbcu8N80efE1zu1AfFGzQ/yPQwWw5GEldo3vf8BnhDIMuyp5
 F/Qw2McRcReiWsV7npV9qNp19RH39G7RlssnJoo371BPLm/E5IvTVAN3SHEmiQQ87a2A
 xfaGT9zWhVfmuDCeKBaAPZARnjTUTQS5D2QRcERL7AEknMD9BxbyxvFNf92TqiGr+ZeE
 tqh1jm2lZY6ugFPJbVJGXgX4s8hToiRV0harXXDSmoBoV7okv7TeFWPy0EYke4BtGPNq
 Jm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708436807; x=1709041607;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iFF76GW5PWPJpHijLrw95ZRBCTbwcHynZ4N19te2AUE=;
 b=olGjILY1GyXd528csQ8zdpBdCrghw9L68U52h6bx+dAEG+xQXBrg6ptLAMwA8W14G8
 s8B0mJewWj36RaZP0W47p492rAALtzqO8cfxdM49dfrceHlO5gk+1JBOWxn5G/QHH12J
 tVZYlaSTpfHTPKVj4doTBRvrg/ctg3Hg+s/dmdRIl5FOFLG8Kf/xiraBVg/Ibk5oA9se
 RYdf3EPUicn1oM3XB0xxkQUM0K+IZYyvyTWzWgqn7tYM23t/jNY/YLg1UzPCwJ4B5vgT
 pxmWlhNQ2Hldet6RGs8wbQcXDr+nmfCPIgvB4WnYMNUmiQCp+hSGy1a2QR0pKqcKQ70v
 cyOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyaYvksb1PmrRoqJS1dR70ilpYikzdJjRsd6S9If6MWBT+iODlmrIbBv8RorarxICjGK2P/psayTEvTJcGlshr7k53Jw==
X-Gm-Message-State: AOJu0YzIJZ80BDa3MT5qEXncikvQOUqFFQ3zbr0IEZI3K/cauobNbIGr
 OS/va0YWzA+3TH4Uf3+sKtpHmgsprycA6AJ2H00nFFTcFVNylDErfZGJ3OaaCY1fsECRVUN47s6
 /ebxo+wocD8FBTyCeTz8aPoDU7CXSQpiCdFoqwA==
X-Google-Smtp-Source: AGHT+IGvjGMK9FEJrqnLvkbYq9JPlP7wfT2/g5YPEuNM+KGqdD4hWh8D9y/3d8zKdZMVti/7ZT9xSuF+UaKGXQbcpkI=
X-Received: by 2002:a67:fa56:0:b0:470:3fe3:8189 with SMTP id
 j22-20020a67fa56000000b004703fe38189mr5959242vsq.3.1708436807296; Tue, 20 Feb
 2024 05:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-23-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-23-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 19:16:36 +0530
Message-ID: <CAFA6WYPg=mBRvLqtdaQ1omzeKU6WcbNt_dWBqV4H36sWb3-ibA@mail.gmail.com>
Subject: Re: [PATCH v4 23/39] mach-snapdragon: carve out no-map regions
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> On Qualcomm platforms, the TZ may already have certain memory regions
> under protection by the time U-Boot starts. There is a rare case on some
> platforms where the prefetcher might speculatively access one of these
> regions resulting in a board crash (TZ traps and then resets the board).
>
> We shouldn't be accessing these regions from within U-Boot anyway, so
> let's mark them all with PTE_TYPE_FAULT to prevent any speculative
> access and correctly trap in EL1 rather than EL3.
>
> This is quite costly with caches off (takes ~2 seconds on SDM845 vs 35ms
> with caches on). So to minimise the impact this is only enabled on
> QCS404 for now (where the issue is known to occur).
>
> In the future, we should try to find a more efficient way to handle
> this, perhaps by turning on the MMU in stages.
>

I suppose you forgot to update the commit message since we already
found more or less an efficient way.

> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/board.c | 162 +++++++++++++++++++++++++++++++++------
>  1 file changed, 140 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 5a859aabd5c4..f12f5791a136 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -25,6 +25,7 @@
>  #include <lmb.h>
>  #include <malloc.h>
>  #include <usb.h>
> +#include <sort.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> @@ -296,7 +297,7 @@ int board_late_init(void)
>
>  static void build_mem_map(void)
>  {
> -       int i;
> +       int i, j;
>
>         /*
>          * Ensure the peripheral block is sized to correctly cover the address range
> @@ -312,28 +313,23 @@ static void build_mem_map(void)
>                          PTE_BLOCK_NON_SHARE |
>                          PTE_BLOCK_PXN | PTE_BLOCK_UXN;
>
> -       debug("Configured memory map:\n");
> -       debug("  0x%016llx - 0x%016llx: Peripheral block\n",
> -             mem_map[0].phys, mem_map[0].phys + mem_map[0].size);
> -
> -       /*
> -        * Now add memory map entries for each DRAM bank, ensuring we don't
> -        * overwrite the list terminator
> -        */
> -       for (i = 0; i < ARRAY_SIZE(rbx_mem_map) - 2 && gd->bd->bi_dram[i].size; i++) {
> -               if (i == ARRAY_SIZE(rbx_mem_map) - 1) {
> -                       log_warning("Too many DRAM banks!\n");
> -                       break;
> -               }
> -               mem_map[i + 1].phys = gd->bd->bi_dram[i].start;
> -               mem_map[i + 1].virt = mem_map[i + 1].phys;
> -               mem_map[i + 1].size = gd->bd->bi_dram[i].size;
> -               mem_map[i + 1].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> -                                    PTE_BLOCK_INNER_SHARE;
> -
> -               debug("  0x%016llx - 0x%016llx: DDR bank %d\n",
> -                     mem_map[i + 1].phys, mem_map[i + 1].phys + mem_map[i + 1].size, i);
> +       for (i = 1, j = 0; i < ARRAY_SIZE(rbx_mem_map) - 1 && gd->bd->bi_dram[j].size; i++, j++) {
> +               mem_map[i].phys = gd->bd->bi_dram[j].start;
> +               mem_map[i].virt = mem_map[i].phys;
> +               mem_map[i].size = gd->bd->bi_dram[j].size;
> +               mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | \
> +                                  PTE_BLOCK_INNER_SHARE;
>         }
> +
> +       mem_map[i].phys = UINT64_MAX;
> +       mem_map[i].size = 0;
> +
> +#ifdef DEBUG
> +       debug("Configured memory map:\n");
> +       for (i = 0; mem_map[i].size; i++)
> +               debug("  0x%016llx - 0x%016llx: entry %d\n",
> +                     mem_map[i].phys, mem_map[i].phys + mem_map[i].size, i);
> +#endif
>  }
>
>  u64 get_page_table_size(void)
> @@ -341,10 +337,132 @@ u64 get_page_table_size(void)
>         return SZ_64K;
>  }
>
> +static int fdt_cmp_res(const void *v1, const void *v2)
> +{
> +       const struct fdt_resource *res1 = v1, *res2 = v2;
> +
> +       return res1->start - res2->start;
> +}
> +
> +#define N_RESERVED_REGIONS 32
> +
> +/* Mark all no-map regions as PTE_TYPE_FAULT to prevent speculative access.
> + * On some platforms this is enough to trigger a security violation and trap
> + * to EL3.
> + */
> +static void carve_out_reserved_memory(void)
> +{
> +       static struct fdt_resource res[N_RESERVED_REGIONS] = { 0 };
> +       int parent, rmem, count, i = 0;
> +       phys_addr_t start;
> +       size_t size;
> +
> +       /* Some reserved nodes must be carved out, as the cache-prefetcher may otherwise
> +        * attempt to access them, causing a security exception.
> +        */
> +       parent = fdt_path_offset(gd->fdt_blob, "/reserved-memory");
> +       if (parent <= 0) {
> +               log_err("No reserved memory regions found\n");
> +               return;
> +       }
> +
> +       /* Collect the reserved memory regions */
> +       fdt_for_each_subnode(rmem, gd->fdt_blob, parent) {
> +               const fdt32_t *ptr;
> +               int len;
> +               if (!fdt_getprop(gd->fdt_blob, rmem, "no-map", NULL))
> +                       continue;
> +
> +               if (i == N_RESERVED_REGIONS) {
> +                       log_err("Too many reserved regions!\n");
> +                       break;
> +               }
> +
> +               /* Read the address and size out from the reg property. Doing this "properly" with
> +                * fdt_get_resource() takes ~70ms on SDM845, but open-coding the happy path here
> +                * takes <1ms... Oh the woes of no dcache.
> +                */

Nice optimization.

> +               ptr = fdt_getprop(gd->fdt_blob, rmem, "reg", &len);
> +               if (ptr) {
> +                       /* Qualcomm devices use #address/size-cells = <2> but all reserved regions are within
> +                        * the 32-bit address space. So we can cheat here for speed.
> +                        */
> +                       res[i].start = fdt32_to_cpu(ptr[1]);
> +                       res[i].end = res[i].start + fdt32_to_cpu(ptr[3]);
> +                       i++;
> +               }
> +       }
> +
> +       /* Sort the reserved memory regions by address */
> +       count = i;
> +       qsort(res, count, sizeof(struct fdt_resource), fdt_cmp_res);
> +
> +       /* Now set the right attributes for them. Often a lot of the regions are tightly packed together
> +        * so we can optimise the number of calls to mmu_change_region_attr() by combining adjacent
> +        * regions.
> +        */
> +       start = ALIGN_DOWN(res[0].start, SZ_2M);
> +       size = ALIGN(res[0].end - start, SZ_2M);
> +       for (i = 1; i <= count; i++) {
> +               /* We ideally want to 2M align everything for more efficient pagetables, but we must avoid
> +                * overwriting reserved memory regions which shouldn't be mapped as FAULT (like those with
> +                * compatible properties).

This comment requires an update too.

With above incorporated, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> +                * If within 2M of the previous region, bump the size to include this region. Otherwise
> +                * start a new region.
> +                */
> +               if (i == count || start + size < res[i].start - SZ_2M) {
> +                       debug("  0x%016llx - 0x%016llx: reserved\n",
> +                             start, start + size);
> +                       mmu_change_region_attr(start, size, PTE_TYPE_FAULT);
> +                       /* If this is the final region then quit here before we index
> +                        * out of bounds...
> +                        */
> +                       if (i == count)
> +                               break;
> +                       start = ALIGN_DOWN(res[i].start, SZ_2M);
> +                       size = ALIGN(res[i].end - start, SZ_2M);
> +               } else {
> +                       /* Bump size if this region is immediately after the previous one */
> +                       size = ALIGN(res[i].end - start, SZ_2M);
> +               }
> +       }
> +}
> +
> +/* This function open-codes setup_all_pgtables() so that we can
> + * insert additional mappings *before* turning on the MMU.
> + */
>  void enable_caches(void)
>  {
> +       u64 tlb_addr = gd->arch.tlb_addr;
> +       u64 tlb_size = gd->arch.tlb_size;
> +       u64 pt_size;
> +       ulong carveout_start;
> +
> +       gd->arch.tlb_fillptr = tlb_addr;
> +
>         build_mem_map();
>
>         icache_enable();
> +
> +       /* Create normal system page tables */
> +       setup_pgtables();
> +
> +       pt_size = (uintptr_t)gd->arch.tlb_fillptr -
> +                 (uintptr_t)gd->arch.tlb_addr;
> +       debug("Primary pagetable size: %lluKiB\n", pt_size / 1024);
> +
> +       /* Create emergency page tables */
> +       gd->arch.tlb_size -= pt_size;
> +       gd->arch.tlb_addr = gd->arch.tlb_fillptr;
> +       setup_pgtables();
> +       gd->arch.tlb_emerg = gd->arch.tlb_addr;
> +       gd->arch.tlb_addr = tlb_addr;
> +       gd->arch.tlb_size = tlb_size;
> +
> +       carveout_start = get_timer(0);
> +       /* Takes ~20-50ms on SDM845 */
> +       carve_out_reserved_memory();
> +       debug("carveout time: %lums\n", get_timer(carveout_start));
> +
>         dcache_enable();
>  }
>
> --
> 2.43.1
>
