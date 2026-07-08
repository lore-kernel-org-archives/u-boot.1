Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D65CC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 11:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D5E8843B6;
	Wed,  8 Jul 2026 13:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H9342Nj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB87184979; Wed,  8 Jul 2026 13:48:41 +0200 (CEST)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41FD184118
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 13:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-667627ae83aso697807d50.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 04:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783511316; cv=none;
 d=google.com; s=arc-20260327;
 b=b/kKDgODPspfQc5fvQyWKzPYumAQJjIRuBgvGVbbaamQtFfoWff0ud8KO39aCQN0k2
 aOOcgswN2rRx1ff2+lutJN7ahenBCss0KnPt2nZajFinrlRFRsGMspMJBRzJ3HH/2LFs
 eFqiXqVLQNIMtgYf4Tuk8heHc/Md7l1jB57+78A4C3yVFj0X1s09Vfh1pN2MbHnBoOZm
 tKoqEDQo+0HQLN4s731h2lqRjJ5OVQ0B9EQtiiciuuIneoLmu6Ul0LssUdxr2IXk/a+M
 ID8sbNAcM1acplX9aQbJ+1FcruHCQZ/OXJxZZbdl5GsjUPosFmoe3vZnyganWbtKeMtw
 27DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZiUZRWEOwfgE5+LeZrb6NF+lBjHGKlffGHODW6L5GT0=;
 fh=tJHuAKXewfII5qNVfwXQ7mOd0P1awial3MZAFbXBJQw=;
 b=jKGSusc+6HaEERsXVoOpjL3k0VTq+sX5djByXKAAA7I+CYoSFUuuKX12hRBZPiJXiu
 YL0lx5cKh84JuIXXMgnYiDl2NqRWkZRpVVk8a7NMlUNeYb3ArGYDXh71mhJwFW15PTNe
 4Zm4w/f6qn+n0NP092LjybU0epCG+GiyWN/BfWZatm2CdPbnU0sefvudDD57+CmqHYwd
 av/AYfVTqhpsrSnWtuFQQb6vlYEnrw90GMbLIEvHYdNN0Fn/VErv6MZk1jlV+61UBler
 gg5SaT3J6xSgImSnVHO4/wafpWIiiTtvjxgt88pJeBTVHKBrAZDR2OKgBXJXmBSOOG9h
 ranQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783511316; x=1784116116; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZiUZRWEOwfgE5+LeZrb6NF+lBjHGKlffGHODW6L5GT0=;
 b=H9342Nj2HhcTAl7X7fM0mdrjtjDvR/AqZII7D4M/jQK61zZ/7MoQNmqoJDf9DgUkNl
 HgrUVP0RLmyoLyw/bXI7mKbvBvuS/AtgsD4QJffNXFFFb3lKZ9jIisY6+WyKyNgqGaET
 ZYgmoUqcSTWIu0mO9/PLSlYSkx5IsLXddry5y3yvYmCHSj389Dc8Nvnb8qsFj4UP70G4
 jOPBG7AraxXo+pdUVh6cTcBdMg8W2Jla5zwXLjuYkRPD+rM/ZW1BZhsq2QgktpTYC0Nb
 XoRi44FITJdw2JQT+UjRNRSDRy9+UekRdYbcypLcDR0U9d8id27k9DTSoNXOLOY3oT2o
 J9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783511316; x=1784116116;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZiUZRWEOwfgE5+LeZrb6NF+lBjHGKlffGHODW6L5GT0=;
 b=K3lFCxwho55tEag8JNndNv7T/bAgcdJHQB77uBiqc7bsOIguuhzJ/5ASJ7Xt3/kORx
 VKmlo82FgcT2V+JQlcsTuSye1+G3ubHeuN5iuQZMABui5BAR+IIr+JeF5/eCysES/sJT
 aQM/r4zXLjudeRE7Xbjr5DAommxpBLLy4fp3S1W1bEp6Z25Fvx0pcFDY1jzcl+9tXvns
 o29gMWeoE0eiwDaGQKbGi+xlOTK/7PYvE+KwPJcZNuU3gYS90jxTrrpqaUb2J6DNT6Wy
 i8mxFz8T7pDWos1ijSG/Cbe9Gg3MzPT2XmCevU/fTFdVWAUSrKD46MPUKZMjIIXoRYgi
 8Cdg==
X-Gm-Message-State: AOJu0YyZgd5jAKcXmKGY3pxjqU94gGMtakOunHcEcxxqtolJ2CLAdWjM
 0jxA/soRP14vMOkZ8EWtfrJELoiREEb0s1ny8xDzyOStys6t/J6h2qBUEFlRp17eccB9caLmY6k
 cKhUu7vfwGfXXRjFprbe+QPoayDYNXpE8ezmzqQJGlQ==
X-Gm-Gg: AfdE7cmv6XNy6PfEeOa9eRz9jxlCK0YaeaVA77Qi6xB2JdDf3kgh709FYyxHkJJ/grN
 H5Uu8oQYKL3hVjgqLXf4RITqhj29bq0ThN4s2fRiG51PmlK6yopdNJQ4FdtRhgpUuM/9xP2IGkp
 NGK8+PfxjHxETTNl3xt0MUdkOp/1Y2kM2217YRo9dnXJkgS8ODO2nHg1pqDj+FefgBnt+u854yz
 pNrZxm8UNmtBqcbAYx+wFIQwH1MlE6pkSsZxFJyCgB2CDpPHEs+E2WocuvGg7CrlGWN5YD9YDDl
 z18tCdPO8pd6zuotxbsXVH5dNfKJxER3kTyH3ypJNnH5kFVdxk1vD/eKsWJ15Iq4I2tQ+E8WJmh
 6YhxuF7R33R/uIFC/eVn7k9qu1aNjbgLdP+7daZkJJt9K/LGHBBpkGbok8sl+cSjB1NM/cxCal4
 PahV7R2PxE1AXYVQ9sLAghKGvvesB/MrfpbLfzyd4WqrDK6QYCc333uVOAn03uprhMwyfIQhBez
 12U2wej4LWwSnv0kr0DhtAfcbCl2C00D1phSHHNHLyvkGiLxAmvIEL0q67B6XReoCbX8TZi7LkG
 nsoEQg7EbV2MW5FBVm7x7rzkG1y+j8SyyrzhyL0dCSG3rHwsY+DFNbZsqpQFGub2gR1LTeo=
X-Received: by 2002:a53:e6c7:0:b0:667:9ae7:8d24 with SMTP id
 956f58d0204a3-6679f1d0886mr1294538d50.83.1783511315739; Wed, 08 Jul 2026
 04:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260708111721.1455945-1-akshay.belsare@amd.com>
In-Reply-To: <20260708111721.1455945-1-akshay.belsare@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 Jul 2026 14:47:59 +0300
X-Gm-Features: AVVi8CfY_hs9u3IhMCGEPtsP-X-YXHGI15RvfZBmHMRtXITNfdtYgigox7qvxpY
Message-ID: <CAC_iWjKDy8ziyMkuHwhg=-VGZ7C5HMYXFQG+ZjATXqwEDjvipQ@mail.gmail.com>
Subject: Re: [PATCH] arm: armv8: mmu: fix DCACHE_OFF incorrectly unmapping
 region
To: Akshay Belsare <akshay.belsare@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@amd.com, 
 padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Simon Glass <sjg@chromium.org>, Mark Kettenis <kettenis@openbsd.org>
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

Hi Akshay

On Wed, 8 Jul 2026 at 14:17, Akshay Belsare <akshay.belsare@amd.com> wrote:
>
> DCACHE_OFF is defined as (0 << 2) = 0, and PTE_TYPE_FAULT is defined
> as (0 << 0) = 0. In mmu_set_region_dcache_behaviour(), the cache
> attribute passed to set_regions() is computed as:
>   attrs = PMD_ATTRINDX(option >> 2)
> For DCACHE_OFF=0 this evaluates to PMD_ATTRINDX(0) = 0, which equals
> PTE_TYPE_FAULT.
>
> Commit 6468ca13ffd6f ("armv8: mmu: fix and optimise explicitly unmapping
> regions") added an unmap path to set_one_region() that
> triggers when attrs == PTE_TYPE_FAULT. Because DCACHE_OFF and
> PTE_TYPE_FAULT share the same numerical value (0), any call to
> mmu_set_region_dcache_behaviour() with DCACHE_OFF silently unmaps the
> target region instead of changing its cache attributes to non-cached.
>
> The subsequent flush_dcache_range() call at the end of
> mmu_set_region_dcache_behaviour() then crashes with a Level 3
> translation fault because the region it tries to flush has just been
> unmapped.
>
> The existing flag parameter already distinguishes the two callers:
>  - mmu_set_region_dcache_behaviour() always passes flag=false
>  - mmu_change_region_attr_nobreak() always passes flag=true, and is the
>    only legitimate caller that passes PTE_TYPE_FAULT to unmap a region
>
> Guard the unmap path with flag so that DCACHE_OFF attribute changes
> take the correct else branch, which ORs in the ATTRINDX bits only,
> leaving the PTE valid.

I don't really love the 'flag' attribute that distinguishes between
preserving or overwriting the permission bits...

However, this does fix an issue.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> This was observed as a boot crash on Versal, Versal Net, and ZynqMP
> platforms during network initialisation. The zynq_gem driver calls
> mmu_set_region_dcache_behaviour() with DCACHE_OFF to make its BD
> descriptor ring non-cached. With the bug the BD memory is unmapped,
> and the subsequent dcache flush inside
> mmu_set_region_dcache_behaviour() faults.
>
> Fixes: 6468ca13ffd6f ("armv8: mmu: fix and optimise explicitly unmapping regions")
> Signed-off-by: Akshay Belsare <akshay.belsare@amd.com>
> ---
>  arch/arm/cpu/armv8/cache_v8.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index e59528e576e..ad232435eb2 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -1006,7 +1006,7 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
>
>         /* Can we can just modify the current level block/page? */
>         if (is_aligned(start, size, levelsize)) {
> -               if (attrs == PTE_TYPE_FAULT) {
> +               if (attrs == PTE_TYPE_FAULT && flag) {
>                         if (pte_type(pte) == PTE_TYPE_TABLE && level < 3)
>                                 *pte = 0;
>                         else
> --
> 2.25.1
>
