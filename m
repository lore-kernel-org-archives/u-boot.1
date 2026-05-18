Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8754ECD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 08:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1752483FEE;
	Mon, 18 May 2026 10:05:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MODypdcv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11D3F84688; Mon, 18 May 2026 10:05:19 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65E2983AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 10:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-65c477a3278so2112063d50.3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 01:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779091513; cv=none;
 d=google.com; s=arc-20240605;
 b=aTs2KjidbYlf9Vd1elFAIFTGThcS2KJ0mzYjtqctFHz33URw0BK040X/G0KCozrafH
 tDQWwEL4/BGe4Tbd5D496fBqoM9tH0wnkbKEHgXgQzQeC3dK6EcBf+0bc3ob/eLW5zP5
 yDdvZw70EoJf25+4Fsh9C/CyMlBRsFfGbYhhq/P2X7lmIRdhpzqJhA98ba2pcgPaRBV9
 DLtrFdAw05KLzXdE5mVivLkAwyBJO/+v6eiYByFy5lGO/An2I6CDSVLUzal0xK4svixy
 pd+RiTQweOQCJcus93YO/MD6JzpNP9VwxzXagP55wxamZO8lkbCoA9JKZmgBup6Afa7T
 185Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7H7NqasfFwtMBtHZglrlRFdO+xN6xsNACMh27v0c+Tc=;
 fh=ovq/5t1o7AdIEUD75iX2y2XHOz36vZstehvnqiiYK8I=;
 b=KnPEZqyyMF7uMsThAtkfB2y67Evez2rpRevzuBPBlCgh33b1s7ZBGyqPsBuO2Iplsu
 JcOB3xCDFud+aU5VZdiAL3Q50BIXUIHgF9T6K7GRQ5fS6Sp9Vc+/+bOyV9StLbTotXVU
 uGywjlmAFzQrQ0PYkb28jHRFU6Tz7LXg7vwspOLS+Bze3+unWsrPxdysKI7Up9ZnYKyl
 Kf7pQZ6+xIjA1kB6rY6xK7nstINTyaqKEPERb3weJemy+GL7p7VWikm6Qdn83xcoVM5s
 LTpFZrhfRGUhZONGAduIW5JmgXLwHUbwWnoe94ZzIaaCb2dzrbyxq1TByYQ+KzOwbWMr
 6ODA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779091513; x=1779696313; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7H7NqasfFwtMBtHZglrlRFdO+xN6xsNACMh27v0c+Tc=;
 b=MODypdcv8dDRKACWRtEUIOcSItD6DNetsTXnULjHDlsZpuC5cYJueig4FwTJfdgYxN
 ekLim56Yw3YNRr2Bx2C27uXjUf1iRPqFeI/P8C4jB2sttRSOgQwaLYW4RpwpQ9tZFGQE
 g3SGEZzD9A2uTc4deLEzaDeQBgnBN80FC6P9ACaqb0gv11LIogMMqiRFw9c4NCc6a2Su
 m7QMVF/SvITLRjxjqa89R2h18j+b1YdYKbkBo+NBiPI+tsSRW1SLYRXhjypyi4pdIykV
 w5uAScrI8bBiJgep1eEgyjWf3lg36iJxeT+PHmvVWRPTG0kMuQYuprOG+AJ62O4pDzgf
 CjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779091513; x=1779696313;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7H7NqasfFwtMBtHZglrlRFdO+xN6xsNACMh27v0c+Tc=;
 b=HUtzuJBF4sqUMGH/+68vuWhkKZIqqJIMjZajCkPhZiJjp4+hKjES77BoPLNyANCczG
 NLVCnlW1CoLjvhDPraPYRomrjH6+alUU5Za2420HIeFzpdTdoaGNj4WLCuGTOYeijxkb
 sJRH42rP3jONfuFOc554hMRQ8+8gc31T7K2Doycd/F3HaBJNHZe6aJTux2S+OlH29JeD
 Xj9pNPEQ5/zumCSnMKUaDLoHF9UOZ+KvvbXlO4ZLs8CvRfRmzi9422xQYPLhLQR1jcDq
 PHrTWUncr7AqON5DtKcOuhCusgj3hDzx1wm/qHhnD53NHtDMxYe0ILOb4L4cHK7E4voB
 30QA==
X-Gm-Message-State: AOJu0YwzV6sqXL+EShZOyG0QeXNcueElYZHioMRYMugZs72Cl1RTDBhP
 wqyT1QcTmDSRKsSEVyG7JlSAVFWjnkxW7sD6njwtL2fqPFwBLYDOXkgoTOulJyx8J2RJPdO8dfu
 PKrN9saTT3MLzhz6Z2U5Bm8cmJzrdjV3zXCcV/YGYwA==
X-Gm-Gg: Acq92OFdi6QVcU1gbj0XaQ5TwqQDYFbeZ9wfuXdx1uVzTGArOMQrJQAZEFV3DhemT2n
 3nIvmR46YfsN4ETLyV37GTAD32l6yHz6FqE+NKeCsPMZIiY4/JL4svCX5DyEs/f+Fr7lWTLMZJR
 8si4o8V1PJJO9eepoF7o+9Y3kqJ/BpxnBuEMX9FpW4L07/zTuek0JEXNttf/hHgUcTG2HpG1XgI
 ZOMyMQPBDVDgUStsC6IFpbcu7SwPyZRkyLKfo/9rf8Y7P5WlrV+7DzhRM7iv/bhOunh+mDXy6WB
 fTy8By6xwlUW+FOlMxGPnzIyCIhxEPTeFn3Wt9wZVEBrpP9QHmZ+X0sJmG+nr4eq1WGQbGZzSNx
 D8j7CarmorZMtMOcj+CAS4DgMl4u8pR2A3J19JyBEerJAtiTKq7XGlPdN08BNs8fQ+XekrtfwO9
 8gsZV237Wjnl6rIlRlIBRKYxYziyyu56wKi31AQjPZB8w+YyhAEPFDKcRb5dE+/YoGTnDKH5F/O
 kVdcjtgwqMpqf4nvhGarmRQnHhX1OZNT7+gOEGAr7+kaXH+plb20YH1xPGjyqEN90cffQCNzrIL
 ucDdt7MdJUhzA6NrwSfHt8flzljA+cug7Kx8eXL8BWtzoYRksR/wNs9h2xZn2YL2zUp7rtK7jNY
 IrvBm8g==
X-Received: by 2002:a05:690e:d50:b0:651:b938:188b with SMTP id
 956f58d0204a3-65e2273520dmr11657289d50.24.1779091512984; Mon, 18 May 2026
 01:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-am62_firewall_exception_fix-v1-1-4b274718bdac@ti.com>
In-Reply-To: <20260512-am62_firewall_exception_fix-v1-1-4b274718bdac@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 18 May 2026 11:04:36 +0300
X-Gm-Features: AVHnY4K-ZS7s9q54TiQwlmlnYRUJ5H5BrnDjiaLBhz3kpAoJuX62xHxIg5oP7Zg
Message-ID: <CAC_iWjJHnzfgMThnUnzd=s_21wndWX57pinNMoq9As+e_TSOOQ@mail.gmail.com>
Subject: Re: [PATCH master] mach-k3: enable mmu after reserved memory is
 unmapped
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Dhruva Gole <d-gole@ti.com>, Mark Kettenis <kettenis@openbsd.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Moteen Shah <m-shah@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, Chintan Vankar <c-vankar@ti.com>
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

Hi Anshul

On Tue, 12 May 2026 at 14:03, Anshul Dalal <anshuld@ti.com> wrote:
>
> Currently the sequence to enable caches for the A53/A72 core on K3
> devices looks as follows:
>
>  1. Map entire DDR banks
>  2. Setup page tables and enable MMU (done by mmu_setup)
>  3. Unmap reserved-memory regions
>  4. Enable caches
>
> However there is a brief period of execution between #2 and #3 where the
> core can issue speculative accesses to the entire DDR space (including
> the reserved-memory regions) despite the caches being disabled.

This is indeed a problem and the fix looks correct.
What worries me though is that the mmu is common across v8 boards. Is
there a way to generalize this instead of adding per board variants?

Thanks
/Ilias

>
> A firewall exception is triggered whenever such speculative access is
> made to secure DDR region of TFA or OP-TEE. This patch fixes the issue
> by re-ordering the sequence as follows:
>
>  1. Map entire DDR banks
>  2. Setup page tables
>  3. Unmap reserved-memory regions
>  4. Enable MMU
>  5. Enable caches
>
> Fixes: f1c694b8fdde ("mach-k3: map all banks using mem_map_from_dram_banks")
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> For testing, I had used an AM62p with the following diff to enable
> logging from TIFS:
>
>   --- a/board/ti/am62px/board-cfg.yaml
>   +++ b/board/ti/am62px/board-cfg.yaml
>   @@ -33,5 +33,5 @@ board-cfg:
>            subhdr:
>                magic: 0x020C
>                size: 8
>   -        trace_dst_enables: 0x00
>   -        trace_src_enables: 0x00
>   +        trace_dst_enables: 0xd
>   +        trace_src_enables: 0x3f
>
> Without this patch an exception[1] similar to the following is observed
> at A53 SPL stage:
>
>   FWL Bit  0x1
>   Exception addr  0x45B08000
>   FWL Exception  0x1000100
>    0x60000
>    0x80002880
>    0x0
>    0x141201
>    0x40
>
> [1]: https://software-dl.ti.com/tisci/esd/latest/6_topic_user_guides/firewall_faq.html#how-do-i-debug-firewall-issues
> ---
>  arch/arm/cpu/armv8/cache_v8.c    |  2 +-
>  arch/arm/include/asm/armv8/mmu.h |  1 +
>  arch/arm/mach-k3/common.c        | 10 +++++++++-
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 39479df7b21..169e68627e1 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -777,7 +777,7 @@ void setup_pgtables(void)
>                 add_map(&mem_map[i]);
>  }
>
> -static void setup_all_pgtables(void)
> +void setup_all_pgtables(void)
>  {
>         u64 tlb_addr = gd->arch.tlb_addr;
>         u64 tlb_size = gd->arch.tlb_size;
> diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
> index 8aa5f9721c4..969f1745445 100644
> --- a/arch/arm/include/asm/armv8/mmu.h
> +++ b/arch/arm/include/asm/armv8/mmu.h
> @@ -197,6 +197,7 @@ struct mm_region {
>  /* Used as the memory map for MMU configuration by mmu_setup */
>  extern struct mm_region *mem_map;
>  void setup_pgtables(void);
> +void setup_all_pgtables(void);
>
>  /**
>   * mem_map_from_dram_banks() - Populate mem_map with entries corresponding to
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index b0a75988714..a910c6e3725 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -265,8 +265,10 @@ void board_prep_linux(struct bootm_headers *images)
>  void enable_caches(void)
>  {
>         void *fdt = (void *)gd->fdt_blob;
> +       int el = current_el();
>         int ret;
>
> +       /* Map all DDR banks as Normal memory */
>         ret = mem_map_from_dram_banks(K3_MEM_MAP_FIRST_BANK_IDX, K3_MEM_MAP_LEN,
>                                      PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>                                              PTE_BLOCK_INNER_SHARE);
> @@ -278,8 +280,11 @@ void enable_caches(void)
>                 printf("%s: Failed to perform reserved-memory fixups (%s)\n",
>                        __func__, fdt_strerror(ret));
>
> -       mmu_setup();
> +       setup_all_pgtables();
> +       set_ttbr_tcr_mair(el, gd->arch.tlb_addr, get_tcr(NULL, NULL),
> +                         MEMORY_ATTRIBUTES);
>
> +       /* Unmap reserved memory regions */
>         if (CONFIG_K3_ATF_LOAD_ADDR >= CFG_SYS_SDRAM_BASE) {
>                 ret = mmu_unmap_reserved_mem("tfa", true);
>                 if (ret)
> @@ -294,6 +299,9 @@ void enable_caches(void)
>                                __func__, ret);
>         }
>
> +       /* enable the mmu */
> +       set_sctlr(get_sctlr() | CR_M);
> +
>         icache_enable();
>         dcache_enable();
>  }
>
> ---
> base-commit: 525ef034e5bed619c0f822da5373ed1fdadc8501
> change-id: 20260512-am62_firewall_exception_fix-20a335cca769
>
> Best regards,
> --
> Anshul Dalal <anshuld@ti.com>
>
