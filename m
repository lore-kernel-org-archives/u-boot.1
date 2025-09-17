Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66730CAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 12:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9BF4833ED;
	Wed, 17 Sep 2025 14:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hIImrBsU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A787834E1; Wed, 17 Sep 2025 14:49:10 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0848B80C93
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 14:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58HCn2I4251370;
 Wed, 17 Sep 2025 07:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758113342;
 bh=7gHsL/C0XCYD1Uye4cA2ROPTKF6COlVTEsILIywjvvQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=hIImrBsUJ0kwZvFPVGbgIsLJxpnOPP7LDXh5xFs1TvthN0AvT+vrJF4tLEkcg8W7s
 jKXry+jlS8eUR4bhrCE3q4y1WCTfGtiUAxuOvOr9DHJAMc1y1BBgTdk9ypw9qBDqJu
 j0czUv+Fuu40NI47BJNrlvDEYauygAU/POqGCpjQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58HCn2Qp2345164
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 17 Sep 2025 07:49:02 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 17
 Sep 2025 07:49:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Sep 2025 07:49:01 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58HCn0Sr3355600;
 Wed, 17 Sep 2025 07:49:01 -0500
Date: Wed, 17 Sep 2025 18:18:59 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <b-padhi@ti.com>, <vigneshr@ti.com>,
 <trini@konsulko.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>,
 <ggiordano@phytec.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>,
 <patrice.chotard@foss.st.com>, <patrick.delaunay@foss.st.com>
Subject: Re: [PATCH -next v1] arm: armv8: remove redundant definition of
 mmu_status
Message-ID: <20250917124859.t3phgju3jxthkmpm@lcpd911>
References: <20250916112205.238811-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250916112205.238811-1-anshuld@ti.com>
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

On Sep 16, 2025 at 16:52:05 +0530, Anshul Dalal wrote:
> mmu_status is used in io memcpy functions to prevent accesses to non
> 8-byte aligned addresses when the mmu is disabled. Though there is a
> redundant definition enabled when icaches is turned off by setting
> SYS_ICACHE_OFF.
> 
> This patch removes the redundant definition, allowing mmu_status to
> properly report the status regardless of config settings. This shouldn't
> be a problem since access to non 8-byte aligned data can be done
> irrespective of icache state.
> 
> Fixes: 268f6ac1f95c ("arm64: Update memcpy_{from, to}io() helpers")
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/cpu/armv8/cache_v8.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 1dcb6007475..74814601483 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -1184,11 +1184,6 @@ int icache_status(void)
>  	return (get_sctlr() & CR_I) != 0;
>  }
>  
> -int mmu_status(void)
> -{
> -	return (get_sctlr() & CR_M) != 0;
> -}
> -
>  void invalidate_icache_all(void)
>  {
>  	__asm_invalidate_icache_all();
> @@ -1210,17 +1205,17 @@ int icache_status(void)
>  	return 0;
>  }
>  
> -int mmu_status(void)
> -{
> -	return 0;
> -}
> -
>  void invalidate_icache_all(void)
>  {
>  }
>  
>  #endif	/* !CONFIG_IS_ENABLED(SYS_ICACHE_OFF) */
>  
> +int mmu_status(void)
> +{
> +	return (get_sctlr() & CR_M) != 0;
> +}
> +
>  /*

Good catch,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
