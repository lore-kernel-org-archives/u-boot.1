Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B326CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 09:43:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 987CE830B4;
	Wed, 10 Sep 2025 11:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f0JMXpRv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C7208318E; Wed, 10 Sep 2025 11:42:59 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDE8982B20
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 11:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58A9gsIu541624;
 Wed, 10 Sep 2025 04:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757497374;
 bh=neWvcfsurolru/RVlGMwBJDI5ypPYv3PnAphgTfhpNQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=f0JMXpRvjCkJ3ISrqOzU/ADKDlO2ZA34IzrFtsKceQYa5rrx0ltp2GhU8MUhfERLk
 uvPrM7MFkz72ExJw8RCEb0OLY022obeKfxuiQ0A+OHQRfRKlAMJwtrqxTsi51lZlY4
 SWS2zydFdhEv+mBqTrQbGZ5i4JEEagRL41g/ggzo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58A9grfd1061613
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 10 Sep 2025 04:42:54 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 04:42:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 04:42:53 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58A9gpwb287093;
 Wed, 10 Sep 2025 04:42:52 -0500
Date: Wed, 10 Sep 2025 15:12:51 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <b-padhi@ti.com>, <vigneshr@ti.com>,
 <trini@konsulko.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>,
 <ggiordano@phytec.com>, <m-chawdhry@ti.com>, <a-nandan@ti.com>,
 <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>, <devarsht@ti.com>,
 <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH -next v6 01/10] mach-k3: use minimal memory map for all K3
Message-ID: <20250910094251.snf2iifvs7nl3ysx@lcpd911>
References: <20250905081902.489345-1-anshuld@ti.com>
 <20250905081902.489345-2-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250905081902.489345-2-anshuld@ti.com>
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

On Sep 05, 2025 at 13:48:52 +0530, Anshul Dalal wrote:
> The K3 family of SoCs encompasses a wide variety of devices with varying

Nit: s/encompasses/encompass

> DDR configurations and memory carveout requirements, the current static
> memory map provides basic support for TI EVMs but does not scale well
> for newer platforms (such as AM62SiP with 512MiB of RAM).
> 
> Therefore this patch replaces the existing memory map with a minimal
> one, that could be more easily modified at runtime.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/mach-k3/arm64/arm64-mmu.c | 32 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/arm64/arm64-mmu.c b/arch/arm/mach-k3/arm64/arm64-mmu.c
> index 0e07b1b7ce0..79650a7e346 100644
> --- a/arch/arm/mach-k3/arm64/arm64-mmu.c
> +++ b/arch/arm/mach-k3/arm64/arm64-mmu.c
> @@ -11,42 +11,30 @@
>  
>  #include <asm/system.h>
>  #include <asm/armv8/mmu.h>
> +#include <linux/sizes.h>
>  
>  struct mm_region k3_mem_map[] = {
> -	{
> +	{ /* SoC Peripherals */
>  		.virt = 0x0UL,
>  		.phys = 0x0UL,
>  		.size = 0x80000000UL,
>  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>  			 PTE_BLOCK_NON_SHARE |
>  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
[...]

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
