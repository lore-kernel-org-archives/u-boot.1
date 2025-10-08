Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06EECCA472
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 13:35:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FE2B8394E;
	Wed,  8 Oct 2025 15:35:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LqIGFmcI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A92F883EA9; Wed,  8 Oct 2025 15:34:59 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 820EB8394A
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 15:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 598DYprL306335;
 Wed, 8 Oct 2025 08:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759930491;
 bh=289KE7VGnhB534b0+Tt5DGKZvV845y+XxDyetya5vgw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=LqIGFmcImGm6STSmNbLnGHTmT7ijq4Nik8R3gnmhLK1RL+Lxwt310ZUoBuZeluv8/
 JfnXjk9pgBIzT7Gw7rPUUaSRUrvHO9dGwBP0eWyA564x5jAB1DEJdHGsiHldpxq3KJ
 dkjYhD/wR/8xFqlp0e384QW4bbvjFP2IVsTMPE3o=
Received: from DFLE202.ent.ti.com (dfle202.ent.ti.com [10.64.6.60])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 598DYp6H676646
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 8 Oct 2025 08:34:51 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Oct
 2025 08:34:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 08:34:51 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 598DYoiD2611327;
 Wed, 8 Oct 2025 08:34:50 -0500
Date: Wed, 8 Oct 2025 19:04:49 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <b-padhi@ti.com>, <vigneshr@ti.com>,
 <trini@konsulko.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>,
 <ggiordano@phytec.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>
Subject: Re: [PATCH -next v8 09/11] mach-k3: add reserved memory fixups for
 next boot stage
Message-ID: <20251008133449.x4luyldk5szkuxb6@lcpd911>
References: <20251006082852.4008937-1-anshuld@ti.com>
 <20251006082852.4008937-10-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251006082852.4008937-10-anshuld@ti.com>
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

On Oct 06, 2025 at 13:58:47 +0530, Anshul Dalal wrote:
> The boot flow in K3 platforms requires the subsequent boot stages to be
> aware of the memory reserved for previous boot binaries. In the regular
> boot sequence of:
> 
> R5 SPL -> ATF -> OP-TEE -> A-core SPL -> U-Boot -> Kernel,
> 
> Both A-core SPL and U-Boot should be made aware of the memory reserved
> for ATF and OP-TEE from their device-tree. Currently this information is
> absent.
> 
> Therefore this patch adds the reserved-memory regions as part of
> spl_perform_arch_fixups for the next stage's DT. This is called during
> both R5 and A-core SPL which fixes up the DT for their respective next
> stages: A-core SPL and U-Boot proper.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> Tested-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  arch/arm/mach-k3/common.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 0a73b1fa296..581a7246630 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -321,6 +321,17 @@ static __maybe_unused void k3_dma_remove(void)
>  		pr_warn("DMA Device not found (err=%d)\n", rc);
>  }
>  
> +void spl_perform_arch_fixups(struct spl_image_info *spl_image)
> +{
> +	void *fdt = spl_image_fdt_addr(spl_image);
> +
> +	if (!fdt)
> +		return;
> +
> +	fdt_fixup_reserved(fdt, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
> +	fdt_fixup_reserved(fdt, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
> +}
> +

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
