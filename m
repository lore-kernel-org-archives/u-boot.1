Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3633BCAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 13:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B70FF83D77;
	Wed,  8 Oct 2025 15:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PpSAQSJt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8807283E8E; Wed,  8 Oct 2025 15:41:09 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BDF1839DE
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 15:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 598Df1FA4049212;
 Wed, 8 Oct 2025 08:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759930861;
 bh=QebecCYAE+f9FqAKcLzNkeGj+aCgCCNN8K9/M7ZsZu4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=PpSAQSJtNOxrxf2TauD8EldJCkXz5vnICFI9A2n9oMO9LuLGBJT6lL/eoi35P4XpT
 R2CBEBKhEKSXkjG2xueBkA+ANL8KRUQCh3HfL8+PdBDFDiQOxifONfmFSz4gvSi5rh
 /bm+44/Q5h9MgGZbR+iW2GRfo+Dgl0yVRNU1qZdI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 598Df1PQ185811
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 8 Oct 2025 08:41:01 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 8
 Oct 2025 08:41:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 08:41:01 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 598Df0sk2618904;
 Wed, 8 Oct 2025 08:41:00 -0500
Date: Wed, 8 Oct 2025 19:10:59 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <b-padhi@ti.com>, <vigneshr@ti.com>,
 <trini@konsulko.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>,
 <ggiordano@phytec.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>
Subject: Re: [PATCH -next v8 10/11] mach-k3: add carveouts for TFA and optee
Message-ID: <20251008134059.4mzl3tvyhh63avoy@lcpd911>
References: <20251006082852.4008937-1-anshuld@ti.com>
 <20251006082852.4008937-11-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251006082852.4008937-11-anshuld@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Oct 06, 2025 at 13:58:48 +0530, Anshul Dalal wrote:
> K3 platforms have reserved memory regions for TFA and OPTEE which should
> be unmapped for U-Boot.
> 
> Therefore this patch adds the necessary fdt fixups to properly set the
> load address for TFA/OPTEE and unmaps both by mmu_unmap_reserved_mem.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> Tested-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  arch/arm/mach-k3/common.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 581a7246630..83562a07435 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -31,6 +31,7 @@
>  #include <dm/uclass-internal.h>
>  #include <dm/device-internal.h>
>  #include <asm/armv8/mmu.h>
> +#include <mach/k3-common-fdt.h>
>  #include <mach/k3-ddr.h>
>  
>  #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT	0x00000001
> @@ -263,6 +264,7 @@ void board_prep_linux(struct bootm_headers *images)
>  
>  void enable_caches(void)
>  {
> +	void *fdt = (void *)gd->fdt_blob;
>  	int ret;
>  
>  	ret = mem_map_fix_dram_banks(K3_MEM_MAP_FIRST_BANK_IDX, K3_MEM_MAP_LEN,
> @@ -273,6 +275,30 @@ void enable_caches(void)
>  
>  	mmu_setup();
>  
> +	if (CONFIG_K3_ATF_LOAD_ADDR >= CFG_SYS_SDRAM_BASE) {
> +		ret = fdt_fixup_reserved(fdt, "tfa", CONFIG_K3_ATF_LOAD_ADDR,
> +					 0x80000);
> +		if (ret)
> +			debug("%s: Failed to perform tfa fixups (%s)\n",
> +			      __func__, fdt_strerror(ret));
> +		ret = mmu_unmap_reserved_mem("tfa");
> +		if (ret)
> +			debug("%s: Failed to unmap tfa reserved mem (%d)\n",
> +			      __func__, ret);
> +	}
> +
> +	if (CONFIG_K3_OPTEE_LOAD_ADDR >= CFG_SYS_SDRAM_BASE) {
> +		ret = fdt_fixup_reserved(fdt, "optee",
> +					 CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
> +		if (ret)
> +			debug("%s: Failed to perform optee fixups (%s)\n",
> +			      __func__, fdt_strerror(ret));
> +		ret = mmu_unmap_reserved_mem("optee");
> +		if (ret)
> +			debug("%s: Failed to unmap optee reserved mem (%d)\n",
> +			      __func__, ret);

All these are hardly "debug" messages. Use something like error() or
pr_err?
With that,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
