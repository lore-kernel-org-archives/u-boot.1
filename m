Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCD7CD98D9
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 09:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 501E38056B;
	Fri, 12 Jun 2026 11:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fJhGd8CX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEBE9839A8; Fri, 12 Jun 2026 11:10:27 +0200 (CEST)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B08B28005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6605c3453f2so866996d50.1
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 02:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781255423; cv=none;
 d=google.com; s=arc-20240605;
 b=gKyS02APQKBKwXnX0ySBSQ+i0wVkAIwGG1BlpExjyKGxEwAYFhK88Tzlna2dUmhrbo
 KFgcHMQTarWzUAeu6qCwaJIYFDTTCwt66ZO10AwWfk0VonxtD3uekMpyvWeNOkQxFiLq
 oOlXbcdlGHIZ2jRtF0Lq0KVJDPK6DA23IEocRDNvg+8S7J2LFGBNTaXZEvEr3WfHTQnB
 tJDBBDKoXq6ucQvkYfxB7E0X9vOBou4+OPdrk8Ki1L/XLpSWU1XrgB4tpgxwj0GM0l2S
 DDvS78CL6wPPhpuwDcBCPNhlKtAbPXSaXBIsI8Dnq8XVRVL8blIXzRtzmmTbrQBAHWaJ
 6IvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XBsCKlvFVF0Bi7ijANYza65a1Q2/DDYkb4t4VXH9Uus=;
 fh=afdFkhg+X0dJedjeczr8qfrLvDZpz9MX/GqWAgIgc5U=;
 b=VCwSXp7tQbJHbx/KlP5pqm0XgB3HwCxxRstz89748LWTNFCHdhWTzW4LcuLEy5lSvB
 mUE6huyUpvfThipKbVbq2cR7eumahiKVyR/Ltdz+FeXdWovtjmpxztWOhf7SOLG6IzLg
 g3+HsIJrOOThHz1SmWx3eAUYktRtw/Reb8gjPh90IpXzuuAWJzqxajUtNYs+F8visyZp
 VQ5+PzkFLxufqlt7Vi7bXihId4akkZPSUpoe1KJ+Q8dWg+fdgNP8RyUyRVaD1Tq1k4lD
 08SlVAAy1FBv9yPhG8LWz/9P/vDvb5BK7nb1IOVlFC9Dr4jtKymAzHcktZzgjVXyl6/y
 7ilw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781255423; x=1781860223; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XBsCKlvFVF0Bi7ijANYza65a1Q2/DDYkb4t4VXH9Uus=;
 b=fJhGd8CXP1gtuOH5CQhENO8g1BvCBeGJiDrkCq6UYrxYU1DRK3Lqz6Q2+SgYJinf4Q
 SQZBLuFXnHUPuKXfye4ckDU/XnPLd2mM4x6YjvdfMqVJh2Sg2UbHa+gskOaV2pHoZUHb
 KVi56bj0PdrI69sCFC5M13eBGpVcEKN0exGDfrJNvuUDEDUdHbay5yqja23T8puVvScc
 KuADP3F+x4jr3yVECgV1bL4Nygs6PaQNT/0zAFi+0a5W5uZFmVM/jLwBtlEoqAOGcLfQ
 q5slPiSJZjfnzMHtCl7OvYrN2JEG9kqQN0ON2bSm9hG0BD05EHhLtOBvzYMvT+gZ+BEG
 gE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781255423; x=1781860223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XBsCKlvFVF0Bi7ijANYza65a1Q2/DDYkb4t4VXH9Uus=;
 b=jvi1TEP0aDtJDYX/MZ567zRh9dNe1ZatQyd3MoDQcvuIehUnCy8Fy0s5EF6fQxgcsY
 l4riyJodxa+UWU/u7u9kd9DXOVifXF8eicZqf77Vfpg+4c+/0TuZFoBOzaxpfHolEoxC
 ogYmS9/D4ik18AajfX3CUF4EkON4bjp9w+gHTUs1xB+NL2hr0Ou8JvRGRNsIg4NVtNXe
 oTKeEmn17uX3JuCZW7MGuSldRugiMyN+pkRXgG2FfjC0tTbWzPM5BZXAHR0kZN2koUGh
 wusYjryklV2AJ8XLmKci9c8t9t5CWomQ7qKEbzE2Nf3QzOVy4LwBG+wi1aGw+8OosqSG
 vTaw==
X-Gm-Message-State: AOJu0YwmYPbAETuT9DRG6r5yB3b8pSZftpMtVFsHFzty+poqI4lYK2Op
 FsI+5nW0b+L0hjvVC+bJ/b0tt7uYSuoLz9mcZFQV5zjfgRTquHeZCGJHArOeyy6B/zgpKU8GwXb
 pkVUw/KL+/SrjnXFhIqomYKNo4RqmSt0luYywGWD5tzwpICO5a3+IXfs7cw==
X-Gm-Gg: Acq92OHOP4cboapkgTSd30Jioriimo1DZVPB7M9JMLoLQvqPFZYYSGncc4rxe3F1jSI
 yha7cl/5NvlMymhEWsshPPk6dr1nvQFm3NBBoF1j9999akrKHJ9vfaCVFfr2CnXQz96UDSq6MMA
 zIbrTMxPZC7DXo6NT/0nR8SslIfizsDZDoQbOgK742f5Fslx3XI5y9EFkz3i+qMjm0PmwhtVuqM
 Nd0qibfxkYL5Kv34KoxaA3Y+m4FPf+Cak+W5nzryZZuLywUQTZ8jx5emQ9RQkr1+l/QFIpyU1Qk
 zZDXPtUJmZ7h1SLjTqfh4SBwRPhslkojAoBezPaDP8aufJ9gWzOGBi2FnIu6eCzl6C5UOcBSm4C
 X0OzY99w3Fvcm4+pOqHmYSvMNla7NchZcFZPySWAb7fP5aIp5yMnr+XE7EbXw3xl3U/wYe8KdLa
 6T6FASmOhv96nZ2emGHdFoWm5n43ejyfrWRl1TYfzJokX0m9ttvovrpHh/YBGABbUqk+lFL4EcI
 femwBuZeHSw1xzc5vhNG97gVp37j+V7ubvLS4NR/lmui7q6RwTKPeyqSIEX/J/Gu2vOFXemVjrJ
 uhMKsWxt87UXjEOpJ8aAnsy1LUpM//lcUiy4j0YkMsco30G6Bw14yVQ2t5tnskpq+PG0ibYB6I/
 RdJj4xg==
X-Received: by 2002:a05:690e:e83:b0:65c:2360:dfc8 with SMTP id
 956f58d0204a3-662782c47e1mr1431030d50.19.1781255423421; Fri, 12 Jun 2026
 02:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-b4-mmu-unmap-fixes-v6-0-ac0764cccf40@linaro.org>
 <20260608-b4-mmu-unmap-fixes-v6-4-ac0764cccf40@linaro.org>
In-Reply-To: <20260608-b4-mmu-unmap-fixes-v6-4-ac0764cccf40@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 12 Jun 2026 12:09:46 +0300
X-Gm-Features: AVVi8CdXdWaaYbq65juiN2AUxvcEUv8MyjFmSW0fQg9L63stJaWhr_v4cHswIs0
Message-ID: <CAC_iWjKtRhbG4sPE7PZ4ZdKh5mMTLwis4wBzWQDDs=YDuji3MQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] armv8: mmu: fix and optimise explicitly unmapping
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

On Mon, 8 Jun 2026 at 20:14, Casey Connolly <casey.connolly@linaro.org> wrote:
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  arch/arm/cpu/armv8/cache_v8.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 01f72c3d0ec6..6c85022556ad 100644
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
> @@ -990,11 +990,12 @@ u64 *__weak arch_get_page_table(void) {
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
> @@ -1002,11 +1003,16 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
>         int levelshift = level2shift(level);
>         u64 levelsize = 1ULL << levelshift;
>         u64 *pte = find_pte(start, level);
>
> -       /* Can we can just modify the current level block PTE? */
> +       /* Can we can just modify the current level block/page? */
>         if (is_aligned(start, size, levelsize)) {
> -               if (flag) {
> +               if (attrs == PTE_TYPE_FAULT) {
> +                       if (pte_type(pte) == PTE_TYPE_TABLE && level < 3)
> +                               *pte = 0;
> +                       else
> +                               *pte &= ~(PTE_TYPE_MASK);
> +               } else if (flag) {
>                         *pte &= ~PMD_ATTRMASK;
>                         *pte |= attrs & PMD_ATTRMASK;
>                 } else {
>                         *pte &= ~PMD_ATTRINDX_MASK;
> @@ -1106,8 +1112,12 @@ void mmu_change_region_attr(phys_addr_t addr, size_t size, u64 attrs)
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
