Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1FCCA1012
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 19:43:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A838B834E5;
	Wed,  3 Sep 2025 21:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KHLV9smY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2410834EC; Wed,  3 Sep 2025 21:43:36 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86E6A833BF
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 21:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 583JhWNw3302876;
 Wed, 3 Sep 2025 14:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756928612;
 bh=c5fgZgeoLQJTmsjmUm/pRtzYzokBvgc6Qncwamo1Yg4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=KHLV9smYrMkpKCASZZFq8EH/Iprl6SDnK8axRmGaJs9WOoiEwq7H0XUTBWty6zOv+
 Zou4s7S/dbskP01jhzRxzgeDBRWoWKcPg5oL4wAzs79Y5ddaEPtNcpuoYC2GVhXMs5
 Jpctfo4Sp6TAq0JMf6R6LImUsC9mro1zO147ssGE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 583JhWX93276776
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 3 Sep 2025 14:43:32 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 14:43:31 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 14:43:31 -0500
Received: from localhost (prasanth-server.dhcp.ti.com [172.24.235.150])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 583JhUTn1807016;
 Wed, 3 Sep 2025 14:43:31 -0500
Date: Thu, 4 Sep 2025 01:13:30 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <u-kumar1@ti.com>
Subject: Re: [PATCH v3 2/2] config: arch: k3: enable DMA_ADDR_T_64BIT
Message-ID: <20250903194330.c3uwkxqswcxrprge@prasanth-server>
References: <20250903115207.572304-1-anshuld@ti.com>
 <20250903115207.572304-3-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250903115207.572304-3-anshuld@ti.com>
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

On 17:22, Anshul Dalal wrote:
> ARCH_K3 encompasses both 32 and 64-bit cores on the same SoC, though the
> DMA addresses are always 64-bit in size.
> 
> With the current implementation, the R5 SPL uses a u32 for dma_addr_t
> which leads to data overflow when functions such as k3_nav_*_pop_mem try
> to write a 64-bit address to dma_addr_t variable.
> 
> In certain cases it leads to stack corruption which manifest as boot
> failures on certain compilers, such as SPI boot on GCC 14.2 or 13.3.
> 
> Therefore this patch selects CONFIG_DMA_ADDR_T_64BIT for all ARCH_K3.
> 
> Fixes: ffcc66e8fec5 ("dma: ti: add driver to K3 UDMA")
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 40368abc297..16db046f4b8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -833,6 +833,7 @@ config ARCH_K3
>  	select FIT
>  	select REGEX
>  	select FIT_SIGNATURE if ARM64
> +	select DMA_ADDR_T_64BIT
>  	select LTO
>  	imply TI_SECURE_DEVICE
>  	imply DM_RNG if ARM64
> -- 
> 2.50.1
> 

Reviewed-by:  Prasanth Babu Mantena <p-mantena@ti.com>

Thanks
Prasanth
