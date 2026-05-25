Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0359DCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 11:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34EEE8460E;
	Mon, 25 May 2026 13:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WG9kaPzm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EDBD84671; Mon, 25 May 2026 13:22:45 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFB55844CF
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 13:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-65890a6ca20so10253711d50.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:22:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779708161; cv=none;
 d=google.com; s=arc-20240605;
 b=SUA4DOQQo75B5ycib5JRJaK5bSqBHI6bNPqFSRtejCDXjOuhirxMYskoVLR57AlMju
 NkIiE20jHT7m/16ztg3mTfx0V++qhopD51AXC66n4hQcj1e6eTYKKSvdHNO45uJ94sXu
 XhxucGCezuvwkDF27XVDWyQp085S8+OCRC+MYbQFDcT76KxkfxKMyNfhV1g/1pE26/8l
 EIfmLwznnTlsThHwa1uZSMrMRGdxXwY2W53Ro6eJImz7jEOegukd4VqF1slZkCQjmnSB
 3dgjcHwi/tiNElONBC36UIfLsY3paiHt3YB/niEPkS6bzkfAcwgmv4QuPEUd6AJ7/9QQ
 +qOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9ok8si9YB1wCn4DXl4t/JR+0UHqxNZJn2qm13eCT+NY=;
 fh=afdFkhg+X0dJedjeczr8qfrLvDZpz9MX/GqWAgIgc5U=;
 b=IcYEQyyoopSYN0Jcgzwu/R2cLnr8DxWVsyIRYZREsSFlEheMyQ/cGy/e/nKzuU4sSS
 NIdVWUJ8ip2DPZetFyTEEzA3v+QrjUQ0HzyoJs0ElZDMteXoNt7xtkHwTr+x4ztq3gCt
 k7pUH4SovzvHZalKSIdy9upqKHNnfEWUEx123hNly2WryZWT4utbBRNLhNN58cegRuw0
 B4NiLtbH1BnBFvxapRBSzV08W7GB8HehuqQTe+E+wMVmNM1AW3O3L6KcpTAnhHlzqOJg
 BnvZ981it1x4Y38oMLMcsb7L77lJKlAuMUhSj1HE+lU7qt4sBr8JmRxV//fdO9GwI1dU
 yuBg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779708161; x=1780312961; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9ok8si9YB1wCn4DXl4t/JR+0UHqxNZJn2qm13eCT+NY=;
 b=WG9kaPzmO62w9uZl76NUuRW2CKRZHUVJbvvBdQ5m2+Fe3ZPwfHbJlSDFZmwWt9I7Uy
 75F6uWR8ruJKgxCVU9rFQEaRxmenkvhIKZN5JvAXtJyj+s9b7oqIzlLcgbaosXptW0kg
 aSY/A6lsX7VTHF0jhWFTRyqAG9ZbY5s3dS3Wq/gsU/F0aiM10dOjTW9grJP2u2f7hazw
 3wsYQRbysibYdoiP6MdzB4ryluSWnrp1xUDGpt+kxpvE/CSmaXJuWp9Qt65W7gzaXaUs
 vSYZ7whhP5/HbJFqj9zYHcV97xH0Cvk5GZB9/NL4/vD5HYYsrfRmlBkQrqe5/qQRr5Vb
 cLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779708161; x=1780312961;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ok8si9YB1wCn4DXl4t/JR+0UHqxNZJn2qm13eCT+NY=;
 b=ssyJaiTsRyj9M6bdlFKl1AwGE9Iiax+sD0Uhs0HLXA8xbRb9MOojyC4VUu3TwQ9pst
 DtHsBPJOp8tB0leSOhf1bFT0gF7HZhyib/94aSsDewBKQZm4PH0kda1DJOHw5xJIT+td
 VBRKrgdUethUqBd4zT0AC2mNuAQ/MulpoCYOQjqVKfVmMBjbDB/CZUDq8i+s28ZG/SLI
 XNHVNijan/Whisc+LqMmhDqTQ5VmAz7RpV8t7Py75Torh7hCNNsgpUZ1Fwx8U8uEK2aA
 IE1hwL9gRMkQRpaEmvH+gw+BT42z6suUw31vOSFP1t4dywbbdX795nSNQ4Vkz4bvK5zf
 JIYw==
X-Gm-Message-State: AOJu0YzGecEDU88IS1cdiSkCMgZ8SyybOI6OojRmzWmBF0xSEgID9cWf
 Hr7pCz6TzdHxnZfYjqJn7C+KarnOZnPVNpaZYtlGteqREQTqvajSEnRcX3Nceh6uyPtuIEr5OiW
 BvBPqMpSwnQXvtas5tcxjGIAntRR9/k4t00yd9QJWow==
X-Gm-Gg: Acq92OHEaXZLOwOsmu8bP3ZgJ8yX1+mQZJQBoTcyceQ7vg8PnlMpnoDEzkkhUeXk9Mg
 jk8drHSAy8OVpTalqwEWq/aRqTlP0rbkHuLXWoSjCkbI8n7zQh70s+MlBKTqBa7Ma6gi4BgbeHn
 rEDM+eMEmeRynLSTK69Qj2Og4F1E5l9h5oefV6Gt7sMRTXUQBw882YBwhv6luE0hh728ZruuwXa
 StAjFoyHaA/w8Dj6FLJpHp7i5xHv22hL/nqpOztTuAaQAyEYL3XMEPTn705jOwkpHiYg4/ZFlul
 j4mYRd/UPiJg1B4MnNfOFHuKFZQEgpWWF5YypI595TPnaUKlSWoXC/Jda746xtSbTNs/+Pk9Esl
 W4B4A5tFvO3E4/iEgNwD1KDXc/MG6SXQfMcbAb0hkjTC0NzO+7VeSoianZbcIboTvzvR8utO7lr
 oy7Sb/DyGP/8c7woQDBdkCS/762v0afLq+DmX43H8ZFKDR2ZqyU5Oq7zW2tkGS9AwTRNAy3C+qc
 X7nQwb6PARkKMQI8sc3oWFnclml++3WhhFUrPMtDhRgyrM//Jyc5VUl/obNLs6Z8c6exeMQmFYV
 BNIqGoEW7m5i+1GE9Yib0rFXjfdGwrHDjYg6RSX0M3vTfXQ0ll92s2/Y7zHNMIc9kF5KuL7s6QU
 C0NgfHw==
X-Received: by 2002:a05:690e:4851:b0:651:8ba3:8785 with SMTP id
 956f58d0204a3-65ec9988b59mr8522747d50.60.1779708160592; Mon, 25 May 2026
 04:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-b4-mmu-unmap-fixes-v5-0-7802245a40a2@linaro.org>
 <20260518-b4-mmu-unmap-fixes-v5-1-7802245a40a2@linaro.org>
In-Reply-To: <20260518-b4-mmu-unmap-fixes-v5-1-7802245a40a2@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 25 May 2026 14:22:04 +0300
X-Gm-Features: AVHnY4IksW69-YSDxJ-ptZCC6JzdUNUJqOa_-geqLXKnSV7qSvWs9oNISszsZrQ
Message-ID: <CAC_iWjLY+uPxaEWipg1Cuq4JFuZ9WoAYURN-Tvnx-n9--cpk3A@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] armv8: mmu: add a function to help debug TLB
 lookups
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>
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

On Mon, 18 May 2026 at 12:00, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> Implement a super basic software TLB walk which can look up a single
> address in the TLB and print each stage of the translation. This is
> helpful for debugging TLB issues and will be compiled out if unused.
>
> Example output on QEMU aarch64:
>
> Performing software TLB lookup of address 0x50100000 va_bits: 40
>   PTE: 0x47fe0000. addr[47:39]: 0x000 (offset 0x00000)
>   L0: 0x47fe0000 -> TABLE (0x47fe1000)
>     PTE: 0x47fe1000. addr[38:30]: 0x001 (offset 0x00008)
>     L1: 0x47fe1008 -> BLOCK (0x40000000)
>       [0x40000000 - 0x80000000]
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  arch/arm/cpu/armv8/cache_v8.c    | 60 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/include/asm/armv8/mmu.h |  7 +++++
>  2 files changed, 67 insertions(+)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 39479df7b21f..97a1c39ed268 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -733,8 +733,68 @@ void dump_pagetable(u64 ttbr, u64 tcr)
>                va_bits, va_bits < 39 ? 3 : 4);
>         walk_pagetable(ttbr, tcr, pagetable_print_entry, NULL);
>  }
>
> +/* Do a software pagetable walk for the given address */
> +void tlb_debug_lookup(u64 addr)
> +{
> +       u64 va_bits;
> +       u64 ttbr = gd->arch.tlb_addr, *pte;
> +       int lshift, level;
> +
> +       get_tcr(NULL, &va_bits);
> +       level = va_bits < 39 ? 1 : 0;
> +
> +       printf("Performing software TLB lookup of address %#010llx va_bits: %lld\n",
> +              addr, va_bits);
> +
> +       addr = ALIGN_DOWN(addr, 0x1000);
> +       pte = ((u64 *)ttbr);
> +       for (int i = level; i < 4; i++) {
> +               int indent = (i - level + 1) * 2;
> +               u32 idx;
> +               u64 _addr;
> +
> +               lshift = level2shift(i);
> +               idx = (addr >> lshift) & 0x1FF;
> +
> +               printf("%*sPTE: %#010llx. addr[%d:%d]: %#05x (offset %#07x)\n", indent, "", (u64)pte,
> +                      lshift + 8, lshift, idx, idx * 8);
> +               printf("%*sL%d: %#010llx -> ", indent, "", i, (u64)(&pte[idx]));
> +
> +               pte = &pte[idx];
> +               _addr = *pte & GENMASK_ULL(va_bits, PAGE_SHIFT);
> +
> +               /*
> +                * Check the PTE and either descend if it's a table or print
> +                * the mapping and return.
> +                */
> +               switch (pte_type(pte)) {
> +               case PTE_TYPE_FAULT:
> +                       printf("UNMAPPED!\n");
> +                       return;
> +               case PTE_TYPE_BLOCK:
> +                       printf("BLOCK (%#010llx)\n", _addr);
> +                       break;
> +               case PTE_TYPE_TABLE:
> +                       if (i < 3) {
> +                               printf("TABLE (%#010llx)\n", _addr);
> +                               pte = (u64 *)_addr;
> +                               continue;
> +                       } else { /* PTE_TYPE_PAGE */
> +                               printf("PAGE (%#010llx)\n", _addr);
> +                       }
> +                       break;
> +               default:
> +                       printf("Unknown (%#010llx)\n", _addr);
> +                       break;
> +               }
> +
> +               printf("%*s[%#010llx - %#010llx]\n", indent + 2, "", _addr, _addr + (1 << lshift));
> +               return;
> +       }
> +}
> +
>  /* Returns the estimated required size of all page tables */
>  __weak u64 get_page_table_size(void)
>  {
>         u64 one_pt = MAX_PTE_ENTRIES * sizeof(u64);
> diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
> index 8aa5f9721c4a..ee81619a1843 100644
> --- a/arch/arm/include/asm/armv8/mmu.h
> +++ b/arch/arm/include/asm/armv8/mmu.h
> @@ -186,8 +186,15 @@ void walk_pagetable(u64 ttbr, u64 tcr, pte_walker_cb_t cb, void *priv);
>   * @tcr: TCR value to use
>   */
>  void dump_pagetable(u64 ttbr, u64 tcr);
>
> +/**
> + * tlb_debug_lookup() - Perform a software TLB walk printing each stage
> + *
> + * @addr: the address to look-up in the TLB.
> + */
> +void tlb_debug_lookup(u64 addr);
> +
>  struct mm_region {
>         u64 virt;
>         u64 phys;
>         u64 size;
>
> --
> 2.53.0
>
