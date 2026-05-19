Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C66ECD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 18:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D03C08039B;
	Tue, 19 May 2026 20:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bFEyHcgb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 216AF80086; Tue, 19 May 2026 20:38:15 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE00080086
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 20:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5a884815606so4722416e87.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:38:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779215890; cv=none;
 d=google.com; s=arc-20240605;
 b=G9HSC8QZPuG7BY9nJ3mmVcXgeaotos+pyFwrAO83Ycie8hvgqpt7UwpXk2vgvEzaWe
 b+EWvJKotA7oKidzRpKtH515iG9x7CGWQqsJmSBz7kQM/sdizU3upXbbCG/6hSpQz1Zk
 dcGTLNL24TqVJUSjubSWuMErZL62z7jtOU32vzTm4ttXws0qlvNoGtOhNIDu1vUtPorR
 Xk9ueLZh9OTsvuVx90Tq9ZDtJVikXhpcWWXt59cLgZ98JjdLUHoBxvVk6v3uik95Kj8t
 qmoVFR817Wx4H0J5WcCfHtD9+fxpOs1w7Q8eorfrTP+GPQp5RodjFOKXPaF8nb0GleFX
 u0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PGUEMTk9diliVGqSgz2GLP6X54p80uLspGpOX1QKUHA=;
 fh=1YFjU5b9WB3jclHra/dbEKs8P1MocCIZNzaX587XNzA=;
 b=LULPyBh/ZdJOPgOFkocaP0x6q/WsHQ9fpvPj29nul7BbRIzdC7MR5/L3uEdpZLp8Oo
 BsDNwckIXI2DhwxZe46PktfgTjLmAnh5lzcd1/Uda+ryaVDrnmFPsTWnd7OVjc9HhxNf
 inS/moMw4DiLxl9tBd4yDHJxngAQU5hZuL56irlAv0/Lm66AXxTDlgJXGbrOGMkmzDpt
 vcJSrOKaHNWn4akdGat8qdEYzwXTN0VOvFw7xseiBWmzHhODXUEvUxVoTam3QIS4SWVs
 NVB8LnQydRKPc3JUmMM/BLejtSZ8QVm64esszCEVx/txhf02a6xFgreDk3i1nOqNPmwQ
 NDZQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779215890; x=1779820690; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PGUEMTk9diliVGqSgz2GLP6X54p80uLspGpOX1QKUHA=;
 b=bFEyHcgbbyErp+P06mpAuktE+bo36faf6LxUppe1yLhd7vYy9wXU07G1p1lg1Ye8D5
 enWvF94REK8PEui1uE91bVa3XVX0onWgsSE3xiFNfzthZ1H/EOkD+jWvCJawDRJNLmcy
 p0MsvbVK7w2liTQMdF0tHxBNcllGx/kuSeAhf1uRu6YhLk5q52G17zN9Uu0e6FNKbypT
 l8FhANpSkzFsAdAa0RBssAL6kTPn4PCtUnzfp7IbpdeCfHzRnbM88HjWLMssMvp6bYxd
 QLDZ3fX69TaJuH5qshMkYA2ACg8VF66/drM3hH9/EU6OOPtfhxRR43TJAYQQpEKCtP5c
 hJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779215890; x=1779820690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGUEMTk9diliVGqSgz2GLP6X54p80uLspGpOX1QKUHA=;
 b=G6JSbbV+P7mW0vugn+LMRVHuq56ZErA1TTGOny+PzcxpZMAd3IFV+ImzZnkPBL8YI/
 E62bl8xpLXGMB6R6FMZD2V14jKOjKfyEvnABsVUYvmC/N3Dj4TgRHAmIdIvV4jfhbnyI
 3sXjR27LdAPAJ/KHF9aovvYO8akO+ow532cphEZmqiplstLzBK0bpEClJyACLIZIoq+e
 UdY4N3jwtTEKf5NU8UjENf/SN3I9iqMNwotxH064IsVRmSNHowhDjHlzHI2e3s+vqxuj
 lNDGZ3TdSAdJGcfo4slW3UTlolmJ/Qz+PmuaScsmvM5f6C6qqFl4Fg/eYgnOlpRvK12I
 owrw==
X-Gm-Message-State: AOJu0YwK3bOLtrujE50hwev2Ck/Fq9rMq7twouBMrumdfO4TtVmssmYQ
 85TqGiZaETM+ofS2W3c26d4ffnAQv25Y3A7aYfKcvHsKiz74uB+cDuGYMM5d8MmoLSfG9RCDiKS
 2IbSOyz0cmWDgPzeRnPjeFXvQd1bu3mqxVPAbvbEKlw==
X-Gm-Gg: Acq92OFMZdoZA6MNIDr6F0qnuzeIvGrH4IJ6gJm3WuXYZLae4wvvPDYNN9Q/edW7n7W
 jWbnDvLX6WbKMwJ0oPxMWBA27S5/zlCf4MEqBm+xTYBM7u68cUk0J4XdauMcGQpq5Y7yqtotsIX
 ca7eEreJiiQ1Q/F5FLhMOeai9PFrDLa7YPlTBjAtvhuw3L2BZigKPno5mRWdhHTdoccRNu/KumX
 jYvhbX/VTKJ6N4i3njujHX57msmF7YWboLZSHjeBQvuJ+EsIQ5OHn9pk3scZSVNnaylafoV0M6C
 ge0GPE5f28XdanZSBU7zfojesFG3eyS0bG+9793xO05Wxd/qidx5sSEh4+xgmBWKgFPUrb7xh94
 BBGLLkHp5vOeRHmwr0mxJqAaYVaIxMl7qeQb2jcdz+SLqEJG7WpJ2J6+OkhueTsGRbmBrrGd0mE
 P0L2+KMAX92IFcflTG8QupMqBfWelUFK4kSfecd8C+LQpy8GhDE6hqdrGrdQck3fGSB5S4wxAgb
 TC3KpKU+4poVIXDFQm5j4KtmeeQJLm6xWYtMCli0t/uOsCxCNjw2xg1QWBEYWlYu/RHdcV/Quto
 e1AvuG7bwBE05WoW26AVaV2YR77gQNTWTq/wqrdXA7eYFz9UMWaobdmMIBmIvEgTCzM5r4zUZHQ
 IA3GI6O1j2n6q6tE=
X-Received: by 2002:a05:6512:159f:b0:5a8:6df4:6ad7 with SMTP id
 2adb3069b0e04-5aa0e616abfmr6073888e87.14.1779215889819; Tue, 19 May 2026
 11:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-am62_firewall_exception_fix-v2-0-bd6e816ec23d@ti.com>
 <20260518-am62_firewall_exception_fix-v2-1-bd6e816ec23d@ti.com>
In-Reply-To: <20260518-am62_firewall_exception_fix-v2-1-bd6e816ec23d@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 19 May 2026 21:37:31 +0300
X-Gm-Features: AVHnY4LI_9UDoBI6YA-2nu0mXYTpSg1bpueSYU9BwSSWPEqs2YaElIDfuX-RX80
Message-ID: <CAC_iWjLY8XxyMVYc8Z8mPUD9Hd5rK=tuG68kjf8LDfuRWj9uPg@mail.gmail.com>
Subject: Re: [PATCH master v2 1/2] arm: armv8: mmu: move mmu enablement out of
 mmu_setup
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Moteen Shah <m-shah@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, 
 Chintan Vankar <c-vankar@ti.com>, Suhaas Joshi <s-joshi@ti.com>
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

On Mon, 18 May 2026 at 14:54, Anshul Dalal <anshuld@ti.com> wrote:
>
> Currently mmu_setup for ARMv8 performs two functions, first it sets up
> the page tables based the memory map provided by the board and then it
> enables the MMU.
>
> However for some platforms runtime fixes to the generated page tables
> are required before the MMU can be enabled, such as K3 family of SoCs.
>
> Therefore this patch moves the enablement of the MMU out of mmu_setup
> and to a standalone mmu_enable function to give more granular control to
> the platforms.
>
> Note that no functional changes are intended from this patch.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  arch/arm/cpu/armv8/cache_v8.c    | 5 ++++-
>  arch/arm/include/asm/armv8/mmu.h | 5 +++++
>  arch/arm/mach-k3/common.c        | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 39479df7b21..7c0e3f6d055 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -810,8 +810,10 @@ __weak void mmu_setup(void)
>         el = current_el();
>         set_ttbr_tcr_mair(el, gd->arch.tlb_addr, get_tcr(NULL, NULL),
>                           MEMORY_ATTRIBUTES);
> +}
>
> -       /* enable the mmu */
> +void mmu_enable(void)
> +{
>         set_sctlr(get_sctlr() | CR_M);
>  }
>
> @@ -881,6 +883,7 @@ void dcache_enable(void)
>         if (!mmu_status()) {
>                 __asm_invalidate_tlb_all();
>                 mmu_setup();
> +               mmu_enable();
>         }
>
>         /* Set up page tables only once (it is done also by mmu_setup()) */
> diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
> index 8aa5f9721c4..5359b2ad87b 100644
> --- a/arch/arm/include/asm/armv8/mmu.h
> +++ b/arch/arm/include/asm/armv8/mmu.h
> @@ -222,6 +222,11 @@ u64 get_tcr(u64 *pips, u64 *pva_bits);
>   * mmu_setup() - Sets up the mmu page tables as per mem_map
>   */
>  void mmu_setup(void);
> +
> +/**
> + * mmu_enable() - Enable the MMU by setting 'M' bit in SCTLR register
> + */
> +void mmu_enable(void);
>  #endif
>
>  #endif /* _ASM_ARMV8_MMU_H_ */
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index b0a75988714..396018b7a7a 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -279,6 +279,7 @@ void enable_caches(void)
>                        __func__, fdt_strerror(ret));
>
>         mmu_setup();
> +       mmu_enable();
>
>         if (CONFIG_K3_ATF_LOAD_ADDR >= CFG_SYS_SDRAM_BASE) {
>                 ret = mmu_unmap_reserved_mem("tfa", true);
>
> --
> 2.53.0
>
