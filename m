Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE22CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 09:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA285830B4;
	Wed, 10 Sep 2025 11:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lPG4mYim";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 974548319C; Wed, 10 Sep 2025 11:44:48 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D7CA82B20
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 11:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58A9iing541984;
 Wed, 10 Sep 2025 04:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757497484;
 bh=QKFqnqSoMqZBYR/Q8gtfNvgGMQPF8uQVig0jl07Y6vg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=lPG4mYimmhpooeXl8nIBIBJEjeQAgFUCUGlHrWFGv03Pj7QIdSym6Gq631xAvQIgq
 3zKS6x47qKn/wa4CKhYdcHmZbK/6ildsGjY5ltsjhG1bCzsGAbzYPD5GpNFRaJnqdn
 jLKEkcVyT62mMd8aN9zh8PsZCkyvXPMLAGnL9qi4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58A9ih493834103
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 10 Sep 2025 04:44:43 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 04:44:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 04:44:43 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58A9ig0S4183366;
 Wed, 10 Sep 2025 04:44:42 -0500
Date: Wed, 10 Sep 2025 15:14:41 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <b-padhi@ti.com>, <vigneshr@ti.com>,
 <trini@konsulko.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>,
 <ggiordano@phytec.com>, <m-chawdhry@ti.com>, <a-nandan@ti.com>,
 <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>, <devarsht@ti.com>,
 <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH -next v6 02/10] mach-k3: use custom enable_cache
Message-ID: <20250910094441.4m4fiaaf2xb6pum3@lcpd911>
References: <20250905081902.489345-1-anshuld@ti.com>
 <20250905081902.489345-3-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250905081902.489345-3-anshuld@ti.com>
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

On Sep 05, 2025 at 13:48:53 +0530, Anshul Dalal wrote:
> U-Boot's provided enable_caches enforces the following sequence:
> icache_enable -> mmu_setup (as part of dcache_enable) -> dcache_enable
> 
> Whereas for K3 devices, we would like to add entries to the provided
> static array (k3_mem_map) as per gd->bd->bi_dram and then call mmu_setup
> to configure the MMU but also create carveouts for TFA/TEE before we
> enable caches to prevent speculative accesses to the region. Thus the
> following desired sequence:
> 
> add dram banks -> mmu_setup -> carveout TFA/TEE -> icache/dcache enable
> 
> Therefore this patch adds K3's own implementation of enable_cache for
> ARM64, allowing for greater control over the cache enablement sequence.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/mach-k3/common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index f8c53b286eb..9d6c6fea451 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -258,6 +258,12 @@ void board_prep_linux(struct bootm_headers *images)
>  				 ROUND(images->os.end,
>  				       CONFIG_SYS_CACHELINE_SIZE));
>  }
> +
> +void enable_caches(void)
> +{
> +	icache_enable();
> +	dcache_enable();
> +}

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
