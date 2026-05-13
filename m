Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2D6CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 11:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F6E836AC;
	Wed, 13 May 2026 13:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ply+C+XT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB8A83FB0; Wed, 13 May 2026 13:58:01 +0200 (CEST)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4909880F0E
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 13:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65c21049dafso6145779d50.2
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 04:57:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778673477; cv=none;
 d=google.com; s=arc-20240605;
 b=OUJdiUr/Cu2fr551DUSLwin5nT17nG6XmAiURPT464xCHUzwfkLJE0WhEkbbNVrFY/
 lqqJPFi4/diU3Hp8GpJCTG4twBduT3KxbRaQMpxcz0IaVh++Sdd6ii9odfobt40WVbLi
 +HyKu29ybM1L6KhHVgU8KgsRtEBl/Ea9XCHZ78MGwwcDgke9mSscLiqF2v3Hd5QiZg+A
 2ZPBUJuqC8qD39byXvTJQLvXSAScw48u0WKWXPdwkbv/SCg7yJc1gn0kvyGGOVPhrjQ7
 zW2/WJxcdeWAyxViawEZ9yLzkdx2DdQVS2lh3XCP+/LvHYp1EQZpdQCXfx5GKjx1/3Az
 zpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oXHBE3jtH/ULkOUUWCFTzWmmpcX+01HfHqMuW8jEL1I=;
 fh=afdFkhg+X0dJedjeczr8qfrLvDZpz9MX/GqWAgIgc5U=;
 b=XuUzEshnH+VXtb2yD/PGXZv2VSpVpIHBhgymPM8/YuprZwHw+2DgAO5HuQLwiJZ7f2
 pYRODCzHXcWmExQU4kvpgU7dFETJets6mpdQaEr5507uACM9F7rAx02ap3JWs+PS/F2R
 MPt+VtUwxJbYs0jy81OZWUtUfnv0uiLYAbPc7WYe29HVk8aYa8PqHRn/7BWYcBkbA8LQ
 QAJor134vtCO/gFr8hYlMk2sJHx+4TNAdX3bD2d+ZdjRcIe5e7uLDcO6HNDuzn9rAjzm
 +2wH4ZgKbwbjCZhyiZlin3kfGoauhwdWb76OwrJk1xwBjKbrci+1QFKRYAMZ5K0EwNII
 Saow==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778673477; x=1779278277; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oXHBE3jtH/ULkOUUWCFTzWmmpcX+01HfHqMuW8jEL1I=;
 b=Ply+C+XThQRmr73LW6XrLqemPjdRHI7KfvNQM+WtobGc/VysGINK28Bw2Mq8iRJctF
 1sGan2d6JqVxe9Fg8ZfBF9t+REUgJ53FVdJXp9cMZ4wA9QppzNNjF6w1QjhbuSso7CAj
 5hzjg879KvkUbJHb8TYT0w++218j0yCfxLr1g4U6oGgmbozai2mRyPWGQfkC+TJHOXmk
 6Btt2gS4PUwoGaulG8BjvwcggCsEaCEyajNHYKzJ3om2PwMe6RbVfHi/bwWVfwDtLOvw
 IUt48l+kl3PcJHpomACgis91wHNd0pE+qsmdtTztVwHLQOb6U7JdKS711UW0S/1kGKUQ
 LSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778673477; x=1779278277;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXHBE3jtH/ULkOUUWCFTzWmmpcX+01HfHqMuW8jEL1I=;
 b=ilNbzq+pl/ctzFY/+GOnGz+wRHPt4lVatrqOxDg7UT7kF1WTQNQ8HAB9ybMLXtdABX
 TpLO23aA23XGiMWWjb4wJ/0F53665QJ4ekVNNBEcWSdKBR+81WG/xwIwfi1DzTRLvdju
 YFmMhycRLtPf4i2Evz48rDGh8oZftAsCxQc0083menkNyQrIYxwT/qzwRD9tegl/IMst
 4yHRAWrULYBTGgyqi+3AOszVpyU1rw1fbJ/RVyFkF2FBZu+uxzo/TOL/ASCHHqBetQqn
 0dlDonkGQ9npeafVPAovWO3BM3pP+UX+Ve5NMCnEUYZlzZ5rIm444n+sUx8CFNo3pq1S
 ShEw==
X-Gm-Message-State: AOJu0YxCL/Gx2wNccW/14yFi6V1WUQT5R5ILWsnqdcEN0EgOOwovhVUj
 8kjv11UTX8dGewPG8/h3u+rAnLoiOGpo7Vle0qGIDYBW/M+p1j+bgFAuBgZVrH88KF3m4tTBC6u
 4DHjIamxh3gq5XYiaSsaywgzqxLUkBncOD9IfK8dHQw==
X-Gm-Gg: Acq92OFlKGuJV6CJias11uLlC3Ga2wbSzynOapb9UsBcw2PtQzHOf7K4llAl1YIqOWA
 SLCuswmluPaR6+PyRgPKYQ2qGCFrbrEfuWyULXvPzJKCzxvzg3TZN4SpNe2hFxwwoDy+7lWAp6b
 vUf7Yz+db7/bdU7sSwjX+NkigBqfAG8W3+NBnpjPfr6qTB2ph3fxjXVpI4mVHcMUKCpYg0+mTp8
 8Gwl3qrMZOSScd2hRF34N4A9tv9sXQVONegkJ4hAeM7fs+ywafFlBeZzcV75XlGJNqd06b8fV9/
 D+FvJGKSqiGKdLJbx/V6mcGzsvqJ6g/5pC6HvZzbkEPP3e/z+/Pbj1ria6eRnqgl7jLfnoseCML
 gHUSLJyVIA9D2u9nBiVWfuHjxgfIifFiMgHDaQOdP0oZCtHKGS4kYnzgPUP6FHVb5OKTbIYxEIZ
 DvqfQ2LSZBvwY+VuufDsePVeFOckk76vp9PragF7MtkMkLDYNsgXRMvF2Tdf8Lpuls7WA21F2z9
 BDJsT5SJSMAqP5zd8/K10f0r7KdRF46BtsJXBNU5+609/DF0EESAapqee53P2TgtfAG8cpdMG3k
 Ans4Y8MqDz39tyBoue16hTH5TcVCY7TxvQ88+M8tC2yJ23ve0gdyVrqpfOTErFdk/4tg1kSTx8n
 a3ZChTA==
X-Received: by 2002:a05:690e:4848:b0:650:dbb:e79c with SMTP id
 956f58d0204a3-65df6318595mr1871149d50.40.1778673476981; Wed, 13 May 2026
 04:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-b4-mmu-unmap-fixes-v4-0-fab802f647c9@linaro.org>
 <20260512-b4-mmu-unmap-fixes-v4-4-fab802f647c9@linaro.org>
In-Reply-To: <20260512-b4-mmu-unmap-fixes-v4-4-fab802f647c9@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 May 2026 14:57:21 +0300
X-Gm-Features: AVHnY4KXAbksRDIf5ycwDMdqogh9B97FKLjgMephRIzWmj18j7HEq7i-Mk98RMQ
Message-ID: <CAC_iWjKgQhx2G1hpjBSzqKE0QJmuGFNoiMWE5=JNZaJvcA-9HQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] armv8: mmu: fix and optimise explicitly unmapping
 regions
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

Hi Casey,

On Tue, 12 May 2026 at 14:13, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> As more platforms start ensuring they explicitly unmap reserved-memory
> regions a few issues have appeared with how the existing dynamic mapping
> code works. Fix these and get a small optimisation as well.
>
> 1. Teach pte_type() to actually respect the PTE_TYPE_VALID bit
> 2. Don't walk the TLB a second time if we call mmu_change_region_attr()
>    with PTE_TYPE_FAULT (since it would just be a slow nop)
> 3. Fix how set_one_region() decides to split blocks.
>
> Today set_one_region() will always split blocks until it reaches the
> smallest granule size (4k) and then update all of these pages. This
> appears to be due to a big in how is_aligned() is implemented, since
> it only evaluates to true if addr and size are both multiples of the
> current granule size, so a mapping aligned to 2M which is 4M in size
> will cleanly result in 2 blocks being set, but a mapping aligned to
> 2M which is 4M + 8k in size will result in blocks being split and 1026
> individual pages being set.
>
> While for the address it is correct to enforce that it is aligned to
> the current granule size, we only need to check if the region size is
> greater than the current granule size. This allows us to simplify our
> second example above to only 4 entries being updated (assuming no blocks
> have to be split) since we only need to update 2 blocks to map the first
> 4M, drastically improving the best-case performance.
>
> In the case where the address is 4k aligned rather than 2M aligned we
> will still be restricted to mapping 4k pages until we reach 2M alignment
> where we could then map a larger 2M granule which previously would never
> happen.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  arch/arm/cpu/armv8/cache_v8.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index e9ce6335ee9e..bcfc36603adb 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -162,9 +162,9 @@ u64 get_tcr(u64 *pips, u64 *pva_bits)
>  #define MAX_PTE_ENTRIES 512
>
>  static int pte_type(u64 *pte)
>  {
> -       return *pte & PTE_TYPE_MASK;
> +       return *pte & PTE_TYPE_VALID ? *pte & PTE_TYPE_MASK : PTE_TYPE_FAULT;
>  }
>
>  /* Returns the LSB number for a PTE on level <level> */
>  static int level2shift(int level)
> @@ -980,11 +980,12 @@ u64 *__weak arch_get_page_table(void) {
>
>         return NULL;
>  }
>
> +/* Checks if the current PTE is an aligned subset of the region */
>  static bool is_aligned(u64 addr, u64 size, u64 align)
>  {
> -       return !(addr & (align - 1)) && !(size & (align - 1));
> +       return !(addr & (align - 1)) && size >= align;
>  }
>
>  /* Use flag to indicate if attrs has more than d-cache attributes */
>  static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
> @@ -992,11 +993,16 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
>         int levelshift = level2shift(level);
>         u64 levelsize = 1ULL << levelshift;
>         u64 *pte = find_pte(start, level);
>
> -       /* Can we can just modify the current level block PTE? */
> +       /* Can we can just modify the current level block/page? */
>         if (is_aligned(start, size, levelsize)) {
> -               if (flag) {
> +               if (attrs == PTE_TYPE_FAULT) {
> +                       if (pte_type(pte) == PTE_TYPE_TABLE)

The code will still unmap the wrong regions here. One easy to way to
reprod this is apply this for QEMU, enabme meminfo and have a look at
the output.

index 38f0ec5f2fbb..c001ccca878d 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -114,6 +114,7 @@ int board_late_init(void)
        if (CONFIG_IS_ENABLED(USB_KEYBOARD))
                usb_init();

+       mmu_change_region_attr(0x50100000, 0x200000, PTE_TYPE_FAULT);
        return 0;
 }

So, what I think is happening is that pte_type() doesn't take the
level into account. But For L3 entries PTE_TYPE_TABLE (which is really
PTE_TYPE_PAGE for that level) will alway be true on level 3.

Cheers
/Ilias

/Ilias
> +                               *pte &= ~0;
> +                       else
> +                               *pte &= ~(PMD_ATTRMASK | PTE_TYPE_MASK | PTE_BLOCK_INNER_SHARE);
> +               } else if (flag) {
>                         *pte &= ~PMD_ATTRMASK;
>                         *pte |= attrs & PMD_ATTRMASK;
>                 } else {
>                         *pte &= ~PMD_ATTRINDX_MASK;
> @@ -1097,8 +1103,12 @@ void mmu_change_region_attr(phys_addr_t addr, size_t size, u64 attrs)
>         flush_dcache_range(gd->arch.tlb_addr,
>                            gd->arch.tlb_addr + gd->arch.tlb_size);
>         __asm_invalidate_tlb_all();
>
> +       /* If we were unmapping a region then we have nothing to make and can return. */
> +       if (attrs == PTE_TYPE_FAULT)
> +               return;
> +
>         mmu_change_region_attr_nobreak(addr, size, attrs);
>  }
>
>  int pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
>
> --
> 2.53.0
>
