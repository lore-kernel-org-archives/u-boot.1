Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38424F3380C
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 08:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 772318413A;
	Tue, 17 Mar 2026 09:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE4FA84142; Tue, 17 Mar 2026 09:36:46 +0100 (CET)
Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CE8C84132
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 09:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62H8aRG8053958;
 Tue, 17 Mar 2026 16:36:27 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Mar
 2026 16:36:27 +0800
Date: Tue, 17 Mar 2026 16:36:22 +0800
From: Leo Liang <ycliang@andestech.com>
To: Uros Stajic <uros.stajic@htecgroup.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu <cfu@mips.com>
Subject: Re: [PATCH v5 1/8] riscv: Add initial support for P8700 SoC
Message-ID: <abkShhoklqkNwnIo@swlinux02>
References: <20251224154449.946780-1-uros.stajic@htecgroup.com>
 <20251224154449.946780-2-uros.stajic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251224154449.946780-2-uros.stajic@htecgroup.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62H8aRG8053958
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

Hi Uros,

On Wed, Dec 24, 2025 at 03:45:22PM +0000, Uros Stajic wrote:
> From: Chao-ying Fu <cfu@mips.com>
> 
> Add initial platform support for the P8700-F, a high-performance
> multi-core RV64GC SoC with optional multi-cluster configuration and
> hardware multithreading.
> 
> This patch introduces the initial platform code necessary to support
> the P8700 CPU in U-Boot.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> ---
>  arch/riscv/Kconfig                        |   1 +
>  arch/riscv/cpu/p8700/Kconfig              |  14 +++
>  arch/riscv/cpu/p8700/Makefile             |   7 ++
>  arch/riscv/cpu/p8700/cache.c              |  93 ++++++++++++++++++
>  arch/riscv/cpu/p8700/cpu.c                | 111 ++++++++++++++++++++++
>  arch/riscv/cpu/p8700/dram.c               |  37 ++++++++
>  arch/riscv/include/asm/arch-p8700/p8700.h | 110 +++++++++++++++++++++
>  7 files changed, 373 insertions(+)
>  create mode 100644 arch/riscv/cpu/p8700/Kconfig
>  create mode 100644 arch/riscv/cpu/p8700/Makefile
>  create mode 100644 arch/riscv/cpu/p8700/cache.c
>  create mode 100644 arch/riscv/cpu/p8700/cpu.c
>  create mode 100644 arch/riscv/cpu/p8700/dram.c
>  create mode 100644 arch/riscv/include/asm/arch-p8700/p8700.h
...
> diff --git a/arch/riscv/cpu/p8700/cpu.c b/arch/riscv/cpu/p8700/cpu.c
> new file mode 100644
> index 00000000000..d63f7073d75
> --- /dev/null
> +++ b/arch/riscv/cpu/p8700/cpu.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
> + */
> +
> +#include <asm/encoding.h>
> +#include <asm/io.h>
> +#include <linux/types.h>
> +#include <asm/arch-p8700/p8700.h>
> +
> +static __noreturn void jump_to_addr(ulong addr)
> +{
> +	asm volatile ("jr %0" :: "r"(addr) : "memory");
> +	__builtin_unreachable();
> +}
> +
> +void harts_early_init(void)
> +{
> +	if (!IS_ENABLED(CONFIG_RISCV_MMODE))
> +		return;
> +
> +	ulong hartid = csr_read(CSR_MHARTID);
> +
> +	/* Wait for DDR3 calibration */
> +	while (!(readl((void __iomem *)BOSTON_PLAT_DDR3STAT) &
> +		 BOSTON_PLAT_DDR3STAT_CALIB)) {
> +		/* busy-wait */
> +	}
> +
> +	/*
> +	 * Only mhartid[3:0] == 0 performs CM/GCR programming.
> +	 * Other harts skip CM/GCR setup and go straight to PMP/PMA setup.
> +	 */
> +	if ((hartid & 0xFULL) == 0) {
> +		ulong cm_base = CM_BASE;
> +		void __iomem *gcr_win = (void __iomem *)0x1fb80000;
> +		ulong cluster = (hartid >> MHARTID_CLUSTER_SHIFT) &
> +				MHARTID_CLUSTER_MASK;
> +
> +		cm_base += cluster << CM_BASE_CLUSTER_SHIFT;
> +
> +		if ((hartid & 0xFFFFUL) == 0)
> +			writeq(cm_base, gcr_win + GCR_BASE_OFFSET);
> +
> +		ulong core = (hartid >> MHARTID_CORE_SHIFT) & MHARTID_CORE_MASK;
> +
> +		/* Enable coherency for the current core */
> +		cm_base += core << CM_BASE_CORE_SHIFT;
> +		writeq((u64)GCR_CL_COH_EN_EN,
> +		       (void __iomem *)(cm_base + P8700_GCR_C0_COH_EN));
> +
> +		/*
> +		 * On hart 0, default PCIe DMA mapping should be the non-IOCU
> +		 * target.
> +		 */
> +		if (hartid == 0) {
> +			writel(0x00, (void __iomem *)BOSTON_PLAT_NOCPCIE0ADDR);
> +			writel(0x00, (void __iomem *)BOSTON_PLAT_NOCPCIE1ADDR);
> +			writel(0x00, (void __iomem *)BOSTON_PLAT_NOCPCIE2ADDR);
> +		}
> +	}
> +
> +	/* PMP setup */
> +	csr_write(pmpaddr1, 0x2fffffffUL);
> +	csr_write(pmpaddr2, 0x07ff7fffUL);
> +	csr_write(pmpaddr3, 0x07f3ffffUL);
> +	csr_write(pmpaddr4, 0x1fffffffffffffffUL);
> +
> +	unsigned long pmpcfg = ((unsigned long)(PMP_NAPOT | PMP_R | PMP_W |
> +						PMP_X) << 32) |
> +				((unsigned long)(PMP_NAPOT | PMP_R |
> +						PMP_X) << 24) |
> +				((unsigned long)(PMP_NAPOT | PMP_R | PMP_W |
> +						PMP_X) << 16) |
> +				((unsigned long)(PMP_NAPOT | PMP_R | PMP_W |
> +						PMP_X) << 8);
> +
> +	csr_write(pmpcfg0, pmpcfg);
> +
> +	/* PMA/cache attributes */
> +	ulong pmacfg0;
> +
> +	if (hartid == 0) {
> +		/*
> +		 * Hart 0: cacheable for pmp0, pmp1, pmp3; uncacheable for
> +		 * pmp2, pmp4.
> +		 */

Are these typos? Are they meant to be pma0, pma1, pma3, ...etc?
If yes, I can modify them on my side.

> +		pmacfg0 = ((unsigned long)CCA_CACHE_DISABLE << 32) |
> +			((unsigned long)CCA_CACHE_ENABLE  << 24) |
> +			((unsigned long)CCA_CACHE_DISABLE << 16) |
> +			((unsigned long)CCA_CACHE_ENABLE  << 8)  |
> +			((unsigned long)CCA_CACHE_ENABLE);
> +	} else {
> +		/*
> +		 * Hart 1 or above: cacheable for pmp0, pmp1; uncacheable for
> +		 * pmp2, pmp3, pmp4.
> +		 */

Ditto.

> +		pmacfg0 = ((unsigned long)CCA_CACHE_DISABLE << 32) |
> +			((unsigned long)CCA_CACHE_DISABLE << 24) |
> +			((unsigned long)CCA_CACHE_DISABLE << 16) |
> +			((unsigned long)CCA_CACHE_ENABLE  << 8)  |
> +			((unsigned long)CCA_CACHE_ENABLE);
> +	}
> +
> +	asm volatile ("csrw %0, %1" :: "i"(CSR_PMACFG0), "r"(pmacfg0));
> +	asm volatile ("fence" ::: "memory");
> +
> +	/* Secondary harts: after early setup, jump to the common entry point */
> +	if (hartid != 0)
> +		jump_to_addr(CONFIG_SYS_LOAD_ADDR);
> +}
...
> diff --git a/arch/riscv/include/asm/arch-p8700/p8700.h b/arch/riscv/include/asm/arch-p8700/p8700.h
> new file mode 100644
> index 00000000000..5ca9b4b9497
> --- /dev/null
> +++ b/arch/riscv/include/asm/arch-p8700/p8700.h
> @@ -0,0 +1,110 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
> + */
> +
> +#ifndef __P8700_H__
> +#define __P8700_H__
> +
> +#define CSR_MIPSCONFIG7		0x7d7
> +#define CSR_PMACFG0			0x7e0
> +
> +#define MHARTID_HART_SHIFT	0
> +#define MHARTID_HART_MASK	0xf
> +#define MHARTID_CORE_SHIFT	4
> +#define MHARTID_CORE_MASK	0xff
> +#define MHARTID_CLUSTER_SHIFT	16
> +#define MHARTID_CLUSTER_MASK	0xf
> +
> +#define MARCHID_UARCH_SHIFT	0
> +#define MARCHID_UARCH_MASK	0xff
> +#define MARCHID_CLASS_SHIFT	8
> +#define MARCHID_CLASS_MASK	0xff
> +#define MARCHID_CLASS_M		0
> +#define MARCHID_CLASS_I		1
> +#define MARCHID_CLASS_P		2
> +
> +#define CM_BASE_CORE_SHIFT	8
> +#define CM_BASE_CLUSTER_SHIFT	19
> +
> +#define P8700_TIMER_ADDR	0x16108050
> +
> +#define CCA_CACHE_ENABLE	0
> +#define CCA_BUFFER_CACHE	1
> +#define CCA_CACHE_DISABLE	2
> +#define CCA_UNCACHE_ACC		3
> +#define PMA_SPECULATION		(0x1 << 3)
> +
> +#define L1_I_CACHE      0
> +#define L1_D_CACHE      1
> +#define L3_CACHE        2
> +#define L2_CACHE        3

Just checking. Are these indices correct?

> +
> +#define HIT_INVALIDATE          4
> +#define HIT_WRITEBACK_INV       5
> +
> +#define HIT_INVALIDATE_D        ((HIT_INVALIDATE << 2) | L1_D_CACHE)
> +#define HIT_INVALIDATE_SD       ((HIT_INVALIDATE << 2) | L2_CACHE)
> +#define HIT_WRITEBACK_INV_D     ((HIT_WRITEBACK_INV << 2) | L1_D_CACHE)
> +#define HIT_WRITEBACK_INV_SD    ((HIT_WRITEBACK_INV << 2) | L2_CACHE)
> +
> +#define L1D_LINE_SIZE_SHIFT	10
> +#define L1D_LINE_SIZE_MASK	0x7
> +
> +#define GCR_L2_CONFIG	0x16100130
> +#define L2_LINE_SIZE_SHIFT	8
> +#define L2_LINE_SIZE_MASK	0xf
> +
> +#define PMP_R			0x01
> +#define PMP_W			0x02
> +#define PMP_X			0x04
> +#define PMP_TOR			0x8
> +#define PMP_NA4			0x10
> +#define PMP_NAPOT		0x18
> +
> +#define CM_BASE			0x16100000
> +#define CPC_BASE		(CM_BASE + 0x8000)
> +
> +/* CPC Block offsets */
> +#define CPC_OFF_LOCAL		0x2000
> +
> +#define CPC_PWRUP_CTL		0x0030
> +
> +#define CPC_SYS_CONFIG		0x0140
> +
> +#define CPC_Cx_CMD		0x0000
> +#define CPC_Cx_CMD_RESET	0x4
> +
> +#define P8700_GCR_C0_COH_EN	0x20f8
> +#define P8700_GCR_C1_COH_EN	0x21f8
> +#define P8700_GCR_C2_COH_EN	0x22f8
> +#define P8700_GCR_C3_COH_EN	0x23f8
> +#define P8700_GCR_C4_COH_EN	0x24f8
> +#define P8700_GCR_C5_COH_EN	0x25f8
> +
> +#define GCR_CL_COH_EN		0x2008
> +#define GCR_CL_COH_EN_EN	(0x1 << 0)
> +#define GCR_BASE_OFFSET		0x0008
> +#define GIC_BASE_OFFSET		0x0080
> +#define CPC_BASE_OFFSET		0x0088
> +#define ENABLE			0x1
> +#define COUNT_STOP		(0x1 << 28)
> +#define GIC_LOCAL_SECTION_OFS	0x8000
> +#define GIC_VL_MASK		0x08
> +#define GIC_VL_RMASK		0x0c
> +#define GIC_VL_SMASK		0x10
> +#define GIC_VL_COMPARE_MAP	0x44
> +
> +#define INDEXED(op, reg, idx, offset, base) \
> +	li	idx, offset	;\
> +	add	idx, idx, base	;\
> +	op	reg, (idx)
> +
> +#define BOSTON_PLAT_BASE	0x17ffd000

"BOSTON_PLAT_BASE" seems to cause redefinition error when build with -Werror.
The redefinition is introduced in the second patch.

> +#define BOSTON_PLAT_DDR3STAT	(BOSTON_PLAT_BASE + 0x14)
> +#define BOSTON_PLAT_DDR3STAT_CALIB	(0x1 << 2)
> +#define BOSTON_PLAT_NOCPCIE0ADDR        (BOSTON_PLAT_BASE + 0x3c)
> +#define BOSTON_PLAT_NOCPCIE1ADDR        (BOSTON_PLAT_BASE + 0x40)
> +#define BOSTON_PLAT_NOCPCIE2ADDR        (BOSTON_PLAT_BASE + 0x44)
> +
> +#endif /* __P8700_H__ */
