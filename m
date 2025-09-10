Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAA4CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 11:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0FA98318E;
	Wed, 10 Sep 2025 13:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Vxl7Acph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 291AB8319C; Wed, 10 Sep 2025 13:14:43 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A71B7830B4
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 13:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58ABEZSv047047;
 Wed, 10 Sep 2025 06:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757502875;
 bh=9HiisOmkWvhN97PhI5y5Ivz7gnd4NYWqfr/EV5rdrxw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Vxl7AcphBpi6xjE7UQQ0WLZX3zjTclx7ac0V26QgVgQ363iXMtTvKS6UyAx8lKjJB
 Tef+wS5au566yxyKbY5iy4o7TBBm5elRAUOQzkyVfoXhqHigbT3Pk4TM6pO0ABXznp
 f1ARvxNTdKPCEa993bNEjn2ltrUr+pbnDNlwMgcs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58ABEZhP1107178
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 10 Sep 2025 06:14:35 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 06:14:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 06:14:34 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58ABEYks090982;
 Wed, 10 Sep 2025 06:14:34 -0500
Date: Wed, 10 Sep 2025 06:14:34 -0500
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>, <afd@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH -next v6 10/10] mach-k3: add carveouts for TFA and optee
Message-ID: <20250910111434.xz57ywvmx6kc7ku5@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250905081902.489345-1-anshuld@ti.com>
 <20250905081902.489345-11-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250905081902.489345-11-anshuld@ti.com>
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

On September  5, 2025 thus sayeth Anshul Dalal:
> K3 platforms have reserved memory regions for TFA and OPTEE which should
> be unmapped for U-Boot.
> 
> Therefore this patch adds the necessary fdt fixups to properly set the
> load address for TFA/OPTEE and unmaps both by mmu_unmap_reserved_mem.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/mach-k3/common.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 9c2fe92cf25..71fc7d31abe 100644
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
> +			debug("%s: Failed to unmap tfa rsvd mem (%s)\n",
> +			      __func__, fdt_strerror(ret));
> +	}
> +
> +	if (CONFIG_K3_OPTEE_LOAD_ADDR >= CFG_SYS_SDRAM_BASE) {
> +		ret = fdt_fixup_reserved(fdt, "optee",
> +					 CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);

We will most likely need to move these sizes into Kconfig. The fact they 
have remained the same is purely an artifact from us not changing
anything nor developing much on OP-TEE for most of K3's lifetime.

For future chips BL1 and OP-TEE will likely need to grow.

~Bryan
