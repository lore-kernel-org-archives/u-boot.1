Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1794ACF5398
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 14:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F5F7892AA;
	Wed, 23 Oct 2024 16:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BK3eDp7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D456B8926F; Wed, 23 Oct 2024 16:46:05 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0A44892E7
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 16:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49NEjxVt057977;
 Wed, 23 Oct 2024 09:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729694759;
 bh=8NcgRDI33nmLfP5qGFBEd9cZkZbOQNbz7tp0vSI/G9E=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=BK3eDp7WBQJG5PS1YdfJBsyMkEb7m83YFmjl08hQBXVvD4rnvvLD/9b2vVOD4RM8C
 ED545xRUlhgzSDUyGy6NLL0YA6KjflJ8Ta4y8mawsfD/iz+Qh8ilqncV7HL1cvp8eO
 JiBO23glLa7heNZYg/gzFbOGyPKjEVq/5VejXyts=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49NEjxfb085975
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Oct 2024 09:45:59 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 09:45:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 09:45:59 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49NEjxpo043312;
 Wed, 23 Oct 2024 09:45:59 -0500
Date: Wed, 23 Oct 2024 09:45:59 -0500
From: Bryan Brattlof <bb@ti.com>
To: Santhosh Kumar K <s-k6@ti.com>
CC: <trini@konsulko.com>, <m-chawdhry@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>, 
 <vigneshr@ti.com>, <u-boot@lists.denx.de>, <w.egorov@phytec.de>,
 <n-francis@ti.com>
Subject: Re: [PATCH v4 5/8] drivers: ram: Kconfig: Add CONFIG_K3_INLINE_ECC
Message-ID: <20241023144559.dtwggwlxwljpky6p@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20241021044024.835846-1-s-k6@ti.com>
 <20241021044024.835846-6-s-k6@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20241021044024.835846-6-s-k6@ti.com>
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

On October 21, 2024 thus sayeth Santhosh Kumar K:
> From: Neha Malcom Francis <n-francis@ti.com>
> 
> Add CONFIG_K3_INLINE_ECC so that ECC functions can be compiled into R5 SPL
> only when the config has been enabled.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  drivers/ram/Kconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
> index f7e357f24da7..533d0c629a64 100644
> --- a/drivers/ram/Kconfig
> +++ b/drivers/ram/Kconfig
> @@ -116,6 +116,16 @@ config IMXRT_SDRAM
>  	  to support external memories like sdram, psram & nand.
>  	  This driver is for the sdram memory interface with the SEMC.
>  
> +config K3_INLINE_ECC
> +	bool "Enable TI Inline ECC support"
> +	depends on K3_DDRSS
> +	help
> +	  Enable Inline ECC support on K3 platforms. 1/9th of the SDRAM space
> +	  is used for ECC storage and the rest 8/9th is available for system
> +	  use. Enabling ECC increases boot time as the ECC protected regions
> +	  need to be primed with a predefined value prior to enabling ECC
> +	  check.
> +

I agree size will always be a complaint at such an early stage of boot 
but we're already adding the ECC configuration in the memory{} node.

We should do one or the other but not both. It would be hard to debug 
problems if someone added the protected{} node but not enable this 
config
