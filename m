Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0002ECCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 12:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98F35837E4;
	Fri, 17 Oct 2025 14:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kIzY1HBR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4998C83734; Fri, 17 Oct 2025 14:35:00 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A3F683655
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 14:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7815092cd0bso19628907b3.2
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 05:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760704497; x=1761309297; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3DJqa60LO6ItNUteps8woglBgc6PlZiLH0b/i2PMCaM=;
 b=kIzY1HBRuoOW4KHK9dWqVs2oK2eW83R+OcSDNbWUlPWM0WPtNAIoeRQ9N4uHFveCPf
 AFqoeg0gQb3V83vYIGDeeOGt0xoIx706FJy2omXIWKg502H8N/egXgnhTYd5fjJ2by7B
 wJ29oG1Fgxp2E1wQddDSFIhVko/WPQeQGGg9Iw5LUNE5VKvKcb/isiLsmMl7xSl4eSTi
 5Er+tDWbkix+/9BsTfKBaIdrnYUrkfkX3YG8ggUP9/Wg3UZggDVBF96BKOca7cplIYN3
 Pu0/9gCRf4YFTECptf/yOWapVq0FIlTejFi0zKsaeHSSgfxpm1PrH+oDxQn/wCJAvBTt
 Pm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760704497; x=1761309297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3DJqa60LO6ItNUteps8woglBgc6PlZiLH0b/i2PMCaM=;
 b=nHGV37eeWi41GJUce4ma1NK7HBAmzP2CWSOxU16LHkxYSskWG43Gcb011s+CGCQ7Ea
 eogk1E1WRmSzl74qs1ZpSJhqjgtAzJHgeGw09BlnoJ2Q4TT4CzUar2etZayFGwyciA8z
 vpvgFXm83lAhzXj3KuHN0q/FaqtmHbIlNAbr4m5EZuDNOHeGblrvZU8hYEnUgBntsZJi
 a/lmEcnP8RVBy6/aUqBaYgfFDNJQy5BiaV52nDGJ0Yvl4HdrkRyL+mNzDZvIKqHMLLEH
 Mo2u9fDfmP5bNrRPmBJoE/ZPQKKfpgh3znpDmznTQKQUAx81TVZJyejDDwr7ShBL3KQT
 F2tQ==
X-Gm-Message-State: AOJu0Yw8nb7duCMQ/G9EwpRpcbPfBlmvYJM5HWA2GSkE45mfSwe5zbiy
 +HyNn3FRSg9vvpR8K/v3xyxmPDjUjzD31IP5ctKWHYGDazXIALYCotKXlyDJn0AmPbutYCQbm4+
 jlX/BR/24DUX5FwymWXjKiiKIebvsKwU2BNrQdv6V4w==
X-Gm-Gg: ASbGncvRUva7Ke086fehiMFpggyasWd53srjVO2EkKvML0BPp1s1w95YaDqlLH53M4U
 pEb4BEUYHIWR8R0P/UqRAntBBmj94p0VJKPX8IVad8zLbwOKwO/+F2/8BnA2vXPc0Eq4wHnqp2e
 q/fMd39KukYjTI8S1JEIbbqejEiX6+Z+0BfdnOmjjZnJErugWRizf/7FdWLlnk7Ux9r3qDaITzo
 sd2byEJRTMFRU6Hq2d0KK0By2ZmT3+0E9TrmCobuMD1EqOJildpVSXxCX8QmUR5GoCHDaJQ6faP
 spmWLYZqh0LjCHhSgps7VAu1kqnhQihf6PXCELCmaFaZnZ15xgA=
X-Google-Smtp-Source: AGHT+IGEmLw/yriHwEHsvhH/Gv6PefxmReF2V/MPavBTN3q2UyDkWWcFP64TiU4g/Gb4a4cC+fWUnJIWNQfky2WkEys=
X-Received: by 2002:a05:690c:600f:b0:721:6b2e:a08a with SMTP id
 00721157ae682-7836d2d6737mr58068187b3.37.1760704496753; Fri, 17 Oct 2025
 05:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20251010134424.3835757-1-anshuld@ti.com>
 <20251010134424.3835757-8-anshuld@ti.com>
In-Reply-To: <20251010134424.3835757-8-anshuld@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 17 Oct 2025 15:34:20 +0300
X-Gm-Features: AS18NWCmNS0MKfifm40qS0-3u9sK1OUwF54AwNuRoh9n4sqI_bKYWm3dAalElO8
Message-ID: <CAC_iWjJSdG6Z-6HtKt3VaJPT8A4HZO3UxbfmuFJ4RCY7jvJPvg@mail.gmail.com>
Subject: Re: [PATCH v10 07/11] arm: armv8: mmu: add mmu_unmap_reserved_mem
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, d-gole@ti.com, b-padhi@ti.com, vigneshr@ti.com, 
 trini@konsulko.com, nm@ti.com, robertcnelson@gmail.com, w.egorov@phytec.de, 
 francesco.dolcini@toradex.com, ggiordano@phytec.com, m-chawdhry@ti.com, 
 afd@ti.com, bb@ti.com, u-kumar1@ti.com, devarsht@ti.com, xypron.glpk@gmx.de
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

Hi Anshul,

On Fri, 10 Oct 2025 at 16:44, Anshul Dalal <anshuld@ti.com> wrote:
>
> For armv8, U-Boot uses a static map defined as 'mem_map' for configuring
> the MMU's page tables, done by mmu_setup.
>
> Though this works well for simpler platforms, it makes creating runtime
> carveouts by modifying the static array at runtime exceedingly complex
> like in mach-snapdragon/board.c.
>
> Creation of such carveouts are much better handled by APIs such as
> mmu_change_region_attr once the page tables are configured. Usually such
> carveouts are configured via the device-tree's reserved-memory node
> which provides the address and size for the carveout.
>
> Therefore this patch adds mmu_unmap_reserved_mem which acts as a wrapper
> over mmu_change_region_attr, helping unmap a reserved-memory region.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> Tested-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  arch/arm/cpu/armv8/cache_v8.c    | 26 ++++++++++++++++++++++++++
>  arch/arm/include/asm/armv8/mmu.h |  8 ++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 9b3c37dae82..f2e006a98ab 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -86,6 +86,32 @@ int mem_map_from_dram_banks(unsigned int index, unsigned int len, u64 attrs)
>
>         return 0;
>  }
> +
> +int mmu_unmap_reserved_mem(const char *name)
> +{
> +       void *fdt = (void *)gd->fdt_blob;
> +       char node_path[128];
> +       fdt_addr_t addr;
> +       fdt_size_t size;
> +       int ret;
> +
> +       snprintf(node_path, sizeof(node_path), "/reserved-memory/%s", name);
> +       ret = fdt_path_offset(fdt, node_path);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (!fdtdec_get_bool(fdt, ret, "no-map"))
> +               return -EINVAL;
> +

Apologies I wasn't clear on my last mail. Can we do this check
conditional please? IOW add a "check_nomap" in the function args

> +       addr = fdtdec_get_addr_size(fdt, ret, "reg", &size);
> +       if (addr == FDT_ADDR_T_NONE)
> +               return -1;
> +
> +       mmu_change_region_attr_nobreak(addr, size, PTE_TYPE_FAULT);
> +
> +       return 0;
> +}
> +
>  u64 get_tcr(u64 *pips, u64 *pva_bits)
>  {
>         int el = get_effective_el();
> diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
> index 6e7a3366844..ca402c7d74c 100644
> --- a/arch/arm/include/asm/armv8/mmu.h
> +++ b/arch/arm/include/asm/armv8/mmu.h
> @@ -207,6 +207,14 @@ void setup_pgtables(void);
>   */
>  int mem_map_from_dram_banks(unsigned int index, unsigned int len, u64 attrs);
>
> +/**
> + * mmu_unmap_reserved_mem() - Unmaps a reserved-memory node as PTE_TYPE_FAULT
> + * once MMU is configured by mmu_setup.
> + *
> + * @name: The name of the node under "/reserved-memory/" path
> + */
> +int mmu_unmap_reserved_mem(const char *name);
> +
>  u64 get_tcr(u64 *pips, u64 *pva_bits);
>
>  /**
> --
> 2.51.0
>

Other than that
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
