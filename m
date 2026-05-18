Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB3CCD4F52
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 12:54:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E98F83EF9;
	Mon, 18 May 2026 14:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SMfnDKEt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3189384664; Mon, 18 May 2026 14:54:41 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCB9F83AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 14:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9A7C2601E4;
 Mon, 18 May 2026 12:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B7AC2BCB7;
 Mon, 18 May 2026 12:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779108877;
 bh=fYhY3sQYhAQ5MKFm3vnt7a33bWnwpguDnUucyHTbyRY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SMfnDKEtsBttOqmIscUE/ug4sipSNLSNk6Bte9a5BtZtbX/fMlDMY9jX3mFpuwX47
 KQLlVF1EV8MwLslJmnt3rjhR4VnwMVO0Nh1bUmRUg5fkQOfjoITyJXwl0M0vFGb6e3
 hUUgfuX41Eop3pFhDkgRoVChd+HjGwIF49Glnzk3qAAG+TYndfhfqAGQAX3HWymAj+
 THSNmo8G3drR+hgEnNrGUTBGGuylr2lkJAsHSE4VlNc6L/rBHT2FQpK7UHFh8uoxec
 fROE0GwlQjG+CadYFM+VFrE0w7lDTqdHTAYku1JTQgQ/NOQu/k78OYp2NdHZjQVAB/
 6lDmsPyeTOXIw==
Date: Mon, 18 May 2026 18:24:26 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v2 12/15] mach-snapdragon: move memory parsing to its own
 file
Message-ID: <agsMAjyc7npwsbpt@sumit-xelite>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-12-c01ec2ff3886@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-b4-modernise-smem-v2-12-c01ec2ff3886@linaro.org>
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

On Mon, May 04, 2026 at 08:57:40PM +0200, Casey Connolly wrote:
> This code is getting a bit complicated, split it out to try and keep
> things a bit better organised as we're going to be supporting populating
> the memory layout from various other sources.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/Makefile    |   2 +-
>  arch/arm/mach-snapdragon/board.c     | 115 -------------------------------
>  arch/arm/mach-snapdragon/dram.c      | 127 +++++++++++++++++++++++++++++++++++
>  arch/arm/mach-snapdragon/qcom-priv.h |   2 +
>  4 files changed, 130 insertions(+), 116 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index 343e825c6fdd..e481e4f26e5c 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0+
>  #
>  # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>  
> -obj-y += board.o
> +obj-y += board.o dram.o
>  obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
>  obj-$(CONFIG_OF_LIVE) += of_fixup.o
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index e12d3d00caa4..a2d97ad77910 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -42,123 +42,8 @@ enum qcom_boot_source qcom_boot_source __section(".data") = 0;
>  static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
>  
>  struct mm_region *mem_map = rbx_mem_map;
>  
> -static struct {
> -	phys_addr_t start;
> -	phys_size_t size;
> -} prevbl_ddr_banks[CONFIG_NR_DRAM_BANKS] __section(".data") = { 0 };
> -
> -int dram_init(void)
> -{
> -	/*
> -	 * gd->ram_base / ram_size have been setup already
> -	 * in qcom_parse_memory().
> -	 */
> -	return 0;
> -}
> -
> -static int ddr_bank_cmp(const void *v1, const void *v2)
> -{
> -	const struct {
> -		phys_addr_t start;
> -		phys_size_t size;
> -	} *res1 = v1, *res2 = v2;
> -
> -	if (!res1->size)
> -		return 1;
> -	if (!res2->size)
> -		return -1;
> -
> -	return (res1->start >> 24) - (res2->start >> 24);
> -}
> -
> -/* This has to be done post-relocation since gd->bd isn't preserved */
> -static void qcom_configure_bi_dram(void)
> -{
> -	int i;
> -
> -	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> -		gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
> -		gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
> -	}
> -}
> -
> -int dram_init_banksize(void)
> -{
> -	qcom_configure_bi_dram();
> -
> -	return 0;
> -}
> -
> -/**
> - * The generic memory parsing code in U-Boot lacks a few things that we
> - * need on Qualcomm:
> - *
> - * 1. It sets gd->ram_size and gd->ram_base to represent a single memory block
> - * 2. setup_dest_addr() later relocates U-Boot to ram_base + ram_size, the end
> - *    of that first memory block.
> - *
> - * This results in all memory beyond U-Boot being unusable in Linux when booting
> - * with EFI.
> - *
> - * Since the ranges in the memory node may be out of order, the only way for us
> - * to correctly determine the relocation address for U-Boot is to parse all
> - * memory regions and find the highest valid address.
> - *
> - * We can't use fdtdec_setup_memory_banksize() since it stores the result in
> - * gd->bd, which is not yet allocated.
> - *
> - * @fdt: FDT blob to parse /memory node from
> - *
> - * Return: 0 on success or -ENODATA if /memory node is missing or incomplete
> - */
> -static int qcom_parse_memory(const void *fdt)
> -{
> -	int offset;
> -	const fdt64_t *memory;
> -	int memsize;
> -	phys_addr_t ram_end = 0;
> -	int i, j, banks;
> -
> -	offset = fdt_path_offset(fdt, "/memory");
> -	if (offset < 0)
> -		return -ENODATA;
> -
> -	memory = fdt_getprop(fdt, offset, "reg", &memsize);
> -	if (!memory)
> -		return -ENODATA;
> -
> -	banks = min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS);
> -
> -	if (memsize / sizeof(u64) > CONFIG_NR_DRAM_BANKS * 2)
> -		log_err("Provided more than the max of %d memory banks\n", CONFIG_NR_DRAM_BANKS);
> -
> -	if (banks > CONFIG_NR_DRAM_BANKS)
> -		log_err("Provided more memory banks than we can handle\n");
> -
> -	for (i = 0, j = 0; i < banks * 2; i += 2, j++) {
> -		prevbl_ddr_banks[j].start = get_unaligned_be64(&memory[i]);
> -		prevbl_ddr_banks[j].size = get_unaligned_be64(&memory[i + 1]);
> -		if (!prevbl_ddr_banks[j].size) {
> -			j--;
> -			continue;
> -		}
> -		ram_end = max(ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
> -	}
> -
> -	if (!banks || !prevbl_ddr_banks[0].size)
> -		return -ENODATA;
> -
> -	/* Sort our RAM banks -_- */
> -	qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
> -
> -	gd->ram_base = prevbl_ddr_banks[0].start;
> -	gd->ram_size = ram_end - gd->ram_base;
> -
> -	return 0;
> -}
> -
>  static void show_psci_version(void)
>  {
>  	struct arm_smccc_res res;
>  
> diff --git a/arch/arm/mach-snapdragon/dram.c b/arch/arm/mach-snapdragon/dram.c
> new file mode 100644
> index 000000000000..ad73b685a935
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/dram.c
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Memory layout parsing for Qualcomm.
> + */
> +
> +#define LOG_CATEGORY LOGC_BOARD
> +#define pr_fmt(fmt) "QCOM-DRAM: " fmt
> +
> +#include <asm-generic/unaligned.h>
> +#include <dm.h>
> +#include <log.h>
> +#include <sort.h>
> +
> +static struct {
> +	phys_addr_t start;
> +	phys_size_t size;
> +} prevbl_ddr_banks[CONFIG_NR_DRAM_BANKS] __section(".data") = { 0 };
> +
> +int dram_init(void)
> +{
> +	/*
> +	 * gd->ram_base / ram_size have been setup already
> +	 * in qcom_parse_memory().
> +	 */
> +	return 0;
> +}
> +
> +static int ddr_bank_cmp(const void *v1, const void *v2)
> +{
> +	const struct {
> +		phys_addr_t start;
> +		phys_size_t size;
> +	} *res1 = v1, *res2 = v2;
> +
> +	if (!res1->size)
> +		return 1;
> +	if (!res2->size)
> +		return -1;
> +
> +	return (res1->start >> 24) - (res2->start >> 24);
> +}
> +
> +/* This has to be done post-relocation since gd->bd isn't preserved */
> +static void qcom_configure_bi_dram(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> +		gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
> +		gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
> +	}
> +}
> +
> +int dram_init_banksize(void)
> +{
> +	qcom_configure_bi_dram();
> +
> +	return 0;
> +}
> +
> +/**
> + * The generic memory parsing code in U-Boot lacks a few things that we
> + * need on Qualcomm:
> + *
> + * 1. It sets gd->ram_size and gd->ram_base to represent a single memory block
> + * 2. setup_dest_addr() later relocates U-Boot to ram_base + ram_size, the end
> + *    of that first memory block.
> + *
> + * This results in all memory beyond U-Boot being unusable in Linux when booting
> + * with EFI.
> + *
> + * Since the ranges in the memory node may be out of order, the only way for us
> + * to correctly determine the relocation address for U-Boot is to parse all
> + * memory regions and find the highest valid address.
> + *
> + * We can't use fdtdec_setup_memory_banksize() since it stores the result in
> + * gd->bd, which is not yet allocated.
> + *
> + * @fdt: FDT blob to parse /memory node from
> + *
> + * Return: 0 on success or -ENODATA if /memory node is missing or incomplete
> + */
> +int qcom_parse_memory(const void *fdt)
> +{
> +	int offset;
> +	const fdt64_t *memory;
> +	int memsize;
> +	phys_addr_t ram_end = 0;
> +	int i, j, banks;
> +
> +	offset = fdt_path_offset(fdt, "/memory");
> +	if (offset < 0)
> +		return -ENODATA;
> +
> +	memory = fdt_getprop(fdt, offset, "reg", &memsize);
> +	if (!memory)
> +		return -ENODATA;
> +
> +	banks = min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS);
> +
> +	if (memsize / sizeof(u64) > CONFIG_NR_DRAM_BANKS * 2)
> +		log_err("Provided more than the max of %d memory banks\n", CONFIG_NR_DRAM_BANKS);
> +
> +	if (banks > CONFIG_NR_DRAM_BANKS)
> +		log_err("Provided more memory banks than we can handle\n");
> +
> +	for (i = 0, j = 0; i < banks * 2; i += 2, j++) {
> +		prevbl_ddr_banks[j].start = get_unaligned_be64(&memory[i]);
> +		prevbl_ddr_banks[j].size = get_unaligned_be64(&memory[i + 1]);
> +		if (!prevbl_ddr_banks[j].size) {
> +			j--;
> +			continue;
> +		}
> +		ram_end = max(ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
> +	}
> +
> +	if (!banks || !prevbl_ddr_banks[0].size)
> +		return -ENODATA;
> +
> +	/* Sort our RAM banks -_- */
> +	qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
> +
> +	gd->ram_base = prevbl_ddr_banks[0].start;
> +	gd->ram_size = ram_end - gd->ram_base;
> +
> +	return 0;
> +}
> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> index b8bf574e8bbb..ce409314a98b 100644
> --- a/arch/arm/mach-snapdragon/qcom-priv.h
> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -22,5 +22,7 @@ void qcom_configure_capsule_updates(void);
>  #else
>  void qcom_configure_capsule_updates(void) {}
>  #endif /* EFI_HAVE_CAPSULE_SUPPORT */
>  
> +int qcom_parse_memory(const void *fdt);
> +
>  #endif /* __QCOM_PRIV_H__ */
> 
> -- 
> 2.53.0
> 
