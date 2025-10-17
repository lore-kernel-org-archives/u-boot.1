Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E22CCCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 12:09:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A18C283710;
	Fri, 17 Oct 2025 14:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DH2yyiqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B62683734; Fri, 17 Oct 2025 14:09:52 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0A0083655
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 14:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-63e0c6f0adfso1899727d50.3
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 05:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760702989; x=1761307789; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UUyGtfm084SWIPpLIJ/IkKYSPrGSUzo0J+WTi3FW8lk=;
 b=DH2yyiqO0FfQJdv+1Wi47KjmJPSu6to+Rx5NXg7b+gfhFFuAJTrzlJwrduvpU0BUSy
 L76sSnRon/gzmbgiXkTRf4Q+a7u7Ti01y5rY2NqbqJesCN3hkVDSBOTNDanxCt5/FScj
 gr/bCYtAC4UE4a5dS3MNe2gJOCwyF6EgaOw8rdqlVBYFzrhKaYpsSCpwMi+FSHK9/Tm5
 Zix9vyDM4Ef/jbgQ6f5Ib1BqjDxPPkP1kaUmXSha77QXp1wJDOsgxH4SvHHrXVVqf9Ma
 24xzUW5yyIBPWF28F6oUnIIr/y7iyyascVvXDyPBkm51S2Wr4ae2i30vkcH73TZrhL2Y
 Zf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760702989; x=1761307789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UUyGtfm084SWIPpLIJ/IkKYSPrGSUzo0J+WTi3FW8lk=;
 b=iHdE5vMXg96mBZMbub55/8rzo9Dzmw/bCcnYIwNdTS3S3utwW1g5d0iYzhCWhfZQ/d
 CtKILO0zE9+hHWmHRQiOn9H1s7oxExuXS711amiJFlARTzfyVcWOGlHOMJKTz5/nIocQ
 6N6Svtxfq01L9e6eLdN0ynGv4o2X0QYZZh7rBjMzoVn4gk8YZNLMyf5E3bO3sF8UqysU
 INtZOc2n47jINa0f6u7E/7R1dir1xyNbi/yhkbCnwy7CPeOukBl5WKntQZYH9yTWINxb
 HFtsDmiy/ORsq4MqvPJWYKvnJmzgH4tZHrUxZw4wMZW8fSvv12sj3DT3XEcGI8RjNbDB
 7BLQ==
X-Gm-Message-State: AOJu0YyLD7UIaCcWavDYsK9+wYK1uLMES1NlrupUn/BgwTjGpFQjY0EB
 /ouRZ5KUZfOddsOjiphup8wqrFgapLL0ME9qHFOgjo0fC0oh5S35Z+HW1+zIKhYVt7oFrR4uQBO
 2+KMtYUIf/N5pRukuaGOPlPyti17ciXGSj7ot3krj6g==
X-Gm-Gg: ASbGncuk8zCjjiLVjWtL2Nt4QAmHh0iQbG378pOUBqB2NFvHWxXaamC3e3K5SXyk4iG
 MG8t2oqhQJx0J+5RRh8LzgC4qTyRnuCOwNMD89obFOMYc7xYJ0eFQSlRK8vKodLQbG1X7AHxmbj
 uq087GclvpGU5XMr3o9mvyMZGAEmJdA37YpH2HTsgsDxgefSW5iPlsAiBWgcQKBYz5TeGRrqRkm
 fG3KKYdZonImUAd7upFnTDtVB7twmz4FPYw9YBWz5kEj7v54tbaC4YoXNEIlybzbpYQ4v0WDTFa
 800I7kY/RbnUEkQwYnco3RBlEgw5YEZF3ZY3S60XHL6YzDV8mXI=
X-Google-Smtp-Source: AGHT+IEK9Eru30tbMzS8MQqPFla9smHE4CyWXhe9UUGu4RpyA+qssJHLm+wWhV3vhb/Bi8omzTaTLr4rZaASc33+2bY=
X-Received: by 2002:a53:c792:0:b0:63c:f5a6:f302 with SMTP id
 956f58d0204a3-63e161fb12dmr2248346d50.68.1760702988511; Fri, 17 Oct 2025
 05:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20251010134424.3835757-1-anshuld@ti.com>
 <20251010134424.3835757-6-anshuld@ti.com>
In-Reply-To: <20251010134424.3835757-6-anshuld@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 17 Oct 2025 15:09:12 +0300
X-Gm-Features: AS18NWAxskcfg_Vh2CpAulw-Taq_WSf_xGjNdswCV5gbMyr8bOE3vlYTM9xe5kw
Message-ID: <CAC_iWj+pyDhYnaJE+eX8LP+Czu13+oH+H1XfMbH4wWgVqY6k2w@mail.gmail.com>
Subject: Re: [PATCH v10 05/11] arm: armv8: mmu: add mem_map_from_dram_banks
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
> the MMU as part of mmu_setup.
>
> But since the exact configuration of memory banks might not be known at
> build time, many platforms such as imx9, versal2 etc. utilize
> gd->bd->bi_dram to configure the static map at runtime.
>
> Therefore this patch adds a new API mem_map_from_dram_banks that
> modifies the static map in a similar way. Allowing the caller to map all
> dram banks by just passing the index to last entry in their mem_map and
> it's length.
>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> Tested-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  arch/arm/cpu/armv8/cache_v8.c    | 28 ++++++++++++++++++++++++++++
>  arch/arm/include/asm/armv8/mmu.h | 11 +++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 74c78cb2fb0..9b3c37dae82 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -58,6 +58,34 @@ static int get_effective_el(void)
>         return el;
>  }
>
> +int mem_map_from_dram_banks(unsigned int index, unsigned int len, u64 attrs)
> +{
> +       unsigned int i;
> +       int ret = fdtdec_setup_memory_banksize();
> +
> +       if (ret) {
> +               log_err("%s: Failed to setup dram banks\n", __func__);
> +               return ret;
> +       }
> +
> +       if (index + CONFIG_NR_DRAM_BANKS >= len) {
> +               log_err("%s: Provided mem_map array has insufficient size for DRAM entries\n",
> +                       __func__);
> +               return -ENOMEM;
> +       }
> +
> +       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> +               mem_map[index].virt = gd->bd->bi_dram[i].start;
> +               mem_map[index].phys = gd->bd->bi_dram[i].start;
> +               mem_map[index].size = gd->bd->bi_dram[i].size;
> +               mem_map[index].attrs = attrs;
> +               index++;
> +       }
> +
> +       memset(&mem_map[index], 0, sizeof(mem_map[index]));
> +
> +       return 0;
> +}

Is there a reason we add all the memory maps now and remove them later
with mmu_unmap_reserved_mem(). IOW we could add the DT parsing in this
function and not map the 'no-map' addresses to begin with.
Unless someone changes the DTB on the fly ?

Thanks
/Ilias
>  u64 get_tcr(u64 *pips, u64 *pva_bits)
>  {
>         int el = get_effective_el();
> diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
> index 3807c702fb6..6e7a3366844 100644
> --- a/arch/arm/include/asm/armv8/mmu.h
> +++ b/arch/arm/include/asm/armv8/mmu.h
> @@ -194,8 +194,19 @@ struct mm_region {
>         u64 attrs;
>  };
>
> +/* Used as the memory map for MMU configuration by mmu_setup */
>  extern struct mm_region *mem_map;
>  void setup_pgtables(void);
> +
> +/**
> + * mem_map_from_dram_banks() - Populate mem_map with entries corresponding to
> + * dram banks as per the gd. This should be called prior to mmu_setup.
> + *
> + * @index: The entry in mem_map to start the over-write
> + * @len: The size of mem_map
> + */
> +int mem_map_from_dram_banks(unsigned int index, unsigned int len, u64 attrs);
> +
>  u64 get_tcr(u64 *pips, u64 *pva_bits);
>
>  /**
> --
> 2.51.0
>
