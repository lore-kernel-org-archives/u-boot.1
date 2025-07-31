Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDD8C83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 09:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDE7B83641;
	Thu, 31 Jul 2025 11:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="U01VjXIU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE76E83641; Thu, 31 Jul 2025 11:19:58 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2DA98349B
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 11:19:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0307a9198e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V8Ruko027400;
 Thu, 31 Jul 2025 11:19:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 m1h6gnVGxmrQtV1tQCd3gQew3CvGjkBBADeVXRNQAv0=; b=U01VjXIUj4Rohy4T
 mtbuWHfoS/Bx1Bd9jBuwMyNHmO5niuSYNjLAHnl3yEbhwi1Is6c7tVVYyu/0kfcr
 v1OZo/fWsJSHVT5aGfRbWdvbSzR3wNFqHR2HOgu7D2mpe4y+2CRfa5C+RGrAIFlR
 QbykuU/uS+yIbfoC4vvO1g1pBZUQJ7gGZ/RnVETYcnu4J50BcFh1uQCt+oZhIEPJ
 8Pq8iM35p5J61ROv6zB+6zhXUbvBymlnS2f/lcahbIp8EXMZLPNhy9oMI5j02+6O
 56IgxcjYYlXv7w3zof5byVCXlHUUMvTpPOzq3aqVjurgjcPbKWNR3kdhiZCXW9VS
 axO/9Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484m59dwdp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Jul 2025 11:19:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D94DA40056;
 Thu, 31 Jul 2025 11:18:46 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7E2167530B0;
 Thu, 31 Jul 2025 11:18:14 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 11:18:13 +0200
Message-ID: <a8744b8a-423c-4bd8-a597-62bd5e027714@foss.st.com>
Date: Thu, 31 Jul 2025 11:18:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] ARM: stm32: Limit early cache enablement in SPL
 to STM32MP15xx
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Cheick Traore <cheick.traore@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250630001053.952342-1-marek.vasut@mailbox.org>
 <20250630001053.952342-3-marek.vasut@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250630001053.952342-3-marek.vasut@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
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



On 6/30/25 02:10, Marek Vasut wrote:
> The STM32MP13xx SRAM size is half that the SRAM size on STM32MP15xx,
> disable early dcache start on STM32MP13xx as the TLB itself takes
> about a quarter of the SPL size. The dcache will be enabled later,
> once DRAM is available and TLB can be placed in DRAM.
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Cheick Traore <cheick.traore@foss.st.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Gatien Chevallier <gatien.chevallier@foss.st.com>
> Cc: Lionel Debieve <lionel.debieve@foss.st.com>
> Cc: Pascal Zimmermann <pzimmermann@dh-electronics.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
> V2: Add RB from Patrice
> ---
>  arch/arm/mach-stm32mp/stm32mp1/cpu.c | 9 ++++++---
>  arch/arm/mach-stm32mp/stm32mp1/spl.c | 3 ++-
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> index 8c09d91de05..e0c6f8ba937 100644
> --- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> +++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> @@ -28,7 +28,9 @@
>   * early TLB into the .data section so that it not get cleared
>   * with 16kB allignment (see TTBR0_BASE_ADDR_MASK)
>   */
> +#if (!IS_ENABLED(CONFIG_XPL_BUILD) || !IS_ENABLED(CONFIG_STM32MP13X))
>  u8 early_tlb[PGTABLE_SIZE] __section(".data") __aligned(0x4000);
> +#endif
>  
>  u32 get_bootmode(void)
>  {
> @@ -95,18 +97,19 @@ void dram_bank_mmu_setup(int bank)
>   */
>  static void early_enable_caches(void)
>  {
> +#if (!IS_ENABLED(CONFIG_XPL_BUILD) || !IS_ENABLED(CONFIG_STM32MP13X))
>  	/* I-cache is already enabled in start.S: cpu_init_cp15 */
> -
>  	if (CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
>  		return;
>  
>  #if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
> -		gd->arch.tlb_size = PGTABLE_SIZE;
> -		gd->arch.tlb_addr = (unsigned long)&early_tlb;
> +	gd->arch.tlb_size = PGTABLE_SIZE;
> +	gd->arch.tlb_addr = (unsigned long)&early_tlb;
>  #endif
>  
>  	/* enable MMU (default configuration) */
>  	dcache_enable();
> +#endif
>  }
>  
>  /*
> diff --git a/arch/arm/mach-stm32mp/stm32mp1/spl.c b/arch/arm/mach-stm32mp/stm32mp1/spl.c
> index 9c4fafbf478..e63bdaaf42f 100644
> --- a/arch/arm/mach-stm32mp/stm32mp1/spl.c
> +++ b/arch/arm/mach-stm32mp/stm32mp1/spl.c
> @@ -220,10 +220,11 @@ void board_init_f(ulong dummy)
>  	 * activate cache on DDR only when DDR is fully initialized
>  	 * to avoid speculative access and issue in get_ram_size()
>  	 */
> -	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
> +	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF) && !IS_ENABLED(CONFIG_STM32MP13X)) {
>  		mmu_set_region_dcache_behaviour(STM32_DDR_BASE,
>  						CONFIG_DDR_CACHEABLE_SIZE,
>  						DCACHE_DEFAULT_OPTION);
> +	}
>  }
>  
>  void spl_board_prepare_for_boot(void)
Applied to u-boot-stm32/master

Thanks
Patrice
