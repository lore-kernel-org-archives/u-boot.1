Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53473CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5E4584176;
	Fri, 10 Oct 2025 14:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mn/RJv8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E07841E6; Fri, 10 Oct 2025 14:08:55 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8320A8410C
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-636d5cefab2so2278239d50.2
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760098131; x=1760702931; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FmDJkEijYbrwS9i9UKX7dS4tDRD41OgFnQ74fKnbUfg=;
 b=mn/RJv8W6EdVv0xpEpbP8T5QKVhOXJnW+OTuCGVjrz3m0cHH0a/I5NmHu2oNm6qWIh
 yDsaddQsPswxiji3LB09oFnFHSo/rNhVLbWfbpdZz2IaqQM+aEGXrp8Bxne1nRmPGg/k
 UjWwCkax1XVWjpDCf8Dcu5wHZMEtVTXFReTwRwrtW0W5ZMNCLrR6x2odcJhM2922t8gk
 FQNRnRV4lpzPiTHrexe+R2qck0yORZa1O6VRMzy2NagAb/QTU+XqbVaHug/Sn+86rM2g
 bwiMaNq7umo/n0W3gC9IKbgPOKkBOQagQlZRm4iSHOmFzotb9ahXCNHg6O6NI8bIpw+l
 l43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760098131; x=1760702931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FmDJkEijYbrwS9i9UKX7dS4tDRD41OgFnQ74fKnbUfg=;
 b=Wj6zRL38Od8F2tMpPwVJsjNirFsAbSW09eiiYW3NJp3jg7Ol0caWq05HNOfdsrPAlx
 LEuyARNUP/9DwqNdEGAO/xpm2s3aO1BiAvWGOMSy2rCNBdP6Hwp4Tq72AssjS9ABXKAm
 omnOFB3+pdcFTW9yAiXgISBqVBOdwU09kyOZaUaHP/f0UhVXPu/CebP1uDr/01uHsk1d
 gVWJ1+RGZELCJjOqr36K9KxH1iriDf0Oof69fJE5Wo2CUW/AbVSEm/ogu5/0X83aMltC
 jRuABA7JgwDXf4LEB+qE+c++ZNm7xzyPm8kiB2M0k3u683gTNpKHYT1426kfPL9C2Hel
 2P0A==
X-Gm-Message-State: AOJu0YzYtnJ98nSDKGO4cfOodIr2dfmTkcTfNln2UuwVQ8cFFsyN532A
 MAXgb/MF9MXMPly5h0A3F1Q7rSxutgVae883U4PSOh3IVUYZLjSZOnNbATKn9K8hVaAsaTnhBL0
 vQ7j2i50sKt1w0hfRpOJRw5CcVGoHutqZO9IhowXBfw==
X-Gm-Gg: ASbGnctKCKU0mDt9JKfikEdGdiQPBUqS0AXmntTOtWX4oSaY71pFxDJXAOO/OZTDDDf
 PxGDMwIqOd29vsGKiv5Tu1WoC48u8f2MkzxjbObNHe5nccLn3UMBcl2dPokwbtS9pe91J9jO0/c
 QP3PuJzz+QVfVoZVFipElwrDKmOpEBY9pdvRpqTRWIMo4sgYwMGqZcA79/0tqb33KKvXMfkB/zN
 dqFBmdXWvSfGarkmcX/fhvUhkqDPWpgXA2XN5a4OAjz53Uk1qGrISensijJNYivruAjc/3etoQH
 2Ojvf8ZO2Lbe5cnYgVNT
X-Google-Smtp-Source: AGHT+IFIqFPnsAQcw1xrXL5AQqfeDusORlSzBqdkAz3lVdF/VX8DGbbX4gufN+BanxKxlN5BX3Km8/ufTmh+gMDhVSA=
X-Received: by 2002:a05:690e:245:b0:63c:eb11:5c8 with SMTP id
 956f58d0204a3-63ceb110680mr2002156d50.11.1760098131270; Fri, 10 Oct 2025
 05:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20251010055340.2574743-1-anshuld@ti.com>
 <20251010055340.2574743-8-anshuld@ti.com>
In-Reply-To: <20251010055340.2574743-8-anshuld@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Oct 2025 15:08:15 +0300
X-Gm-Features: AS18NWD6VmCSmFyGgQHLrEG5VyUtURQm-kOxCGLCkQngu240S8Av8-l-jqE_9OM
Message-ID: <CAC_iWjJhBWRirbMjwAvdih2tmFH_PxikzFJfAK-txYQuGmKDnA@mail.gmail.com>
Subject: Re: [PATCH v9 07/11] arm: armv8: mmu: add mmu_unmap_reserved_mem
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

On Fri, 10 Oct 2025 at 08:54, Anshul Dalal <anshuld@ti.com> wrote:
>
> For armv8, U-Boot uses a static map defined as 'mem_map' for configuring
> the MMU's page tables, done by mmu_setup.
>
> Though this works well for simpler platforms, it makes creating runtime
> carveouts by modifying the static array at runtime exceedingly complex
> like in mach-snapdragon/board.c.
>
> Creation of such carveouts is much better handled by APIs such as
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
>  arch/arm/cpu/armv8/cache_v8.c    | 23 +++++++++++++++++++++++
>  arch/arm/include/asm/armv8/mmu.h |  9 +++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index cdf17d5f396..74814601483 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -86,6 +86,29 @@ int mem_map_fix_dram_banks(unsigned int index, unsigned int len, u64 attrs)
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

The DT spec defines a /reserved/ no-map; option for reserved memory
that should not participate in the memory map.
Is there any reason why we unconditionally unmap reserved memory and
not the no-map one only?

Cheers
/Ilias
> +
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
> index 257352f216e..fbd64e649ff 100644
> --- a/arch/arm/include/asm/armv8/mmu.h
> +++ b/arch/arm/include/asm/armv8/mmu.h
> @@ -206,6 +206,15 @@ void setup_pgtables(void);
>   * @len: The size of mem_map
>   */
>  int mem_map_fix_dram_banks(unsigned int index, unsigned int len, u64 attrs);
> +
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
