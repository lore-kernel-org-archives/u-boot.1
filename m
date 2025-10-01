Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8417CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 11:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2401C800B1;
	Wed,  1 Oct 2025 13:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="siCyHjkK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF9FC81D6A; Wed,  1 Oct 2025 13:39:00 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E589800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 13:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 591Bcnp93117604;
 Wed, 1 Oct 2025 06:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759318729;
 bh=pDsTk3hcQ9NUTkUjkzBouhWixvSRAf8g1yOoAfzjoKo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=siCyHjkKjQENUbbAAx5Ps7mY/IarpgEtwtUZooYLGh0DjURbsutFfvR/16SRDXyPu
 OQHhkaI3PUQzpNfAdw0uxvWT9cSAR+7FczvQks8BPMoFPa7+SfIrvd+zWXnNR2qE9Q
 +VfwHymMuf6msPH/DrnKyZH1DravM+6g3uYZb2RY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 591Bcn9H3400695
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 1 Oct 2025 06:38:49 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 1
 Oct 2025 06:38:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Oct 2025 06:38:49 -0500
Received: from [172.24.31.60] (ltd1nqfk3.dhcp.ti.com [172.24.31.60])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 591BckGx250222;
 Wed, 1 Oct 2025 06:38:47 -0500
Message-ID: <99f08016-a451-498d-987c-d392d3e3e29c@ti.com>
Date: Wed, 1 Oct 2025 17:08:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: ti: Tighten some TI clock driver dependencies
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Andrew
 Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>
References: <20250926153132.3680837-1-trini@konsulko.com>
Content-Language: en-US
From: "Chawdhry, Manorit" <m-chawdhry@ti.com>
In-Reply-To: <20250926153132.3680837-1-trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Tom,

On 9/26/2025 9:01 PM, Tom Rini wrote:
> A few of the TI clock drivers cannot link without access to TI platform
> specific drivers and headers.  Express those requirements in Kconfig as
> well.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Manorit Chawdhry <m-chawdhry@ti.com>
> Cc: Andrew Davis <afd@ti.com>
> Cc: Udit Kumar <u-kumar1@ti.com>
> ---
>   drivers/clk/ti/Kconfig | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/ti/Kconfig b/drivers/clk/ti/Kconfig
> index e0f15f57f826..ba658c741c4d 100644
> --- a/drivers/clk/ti/Kconfig
> +++ b/drivers/clk/ti/Kconfig
> @@ -18,19 +18,19 @@ config CLK_TI_CTRL
>   
>   config CLK_TI_DIVIDER
>   	bool "TI divider clock driver"
> -	depends on CLK && OF_CONTROL && CLK_CCF
> +	depends on CLK && OF_CONTROL && CLK_CCF && ARCH_OMAP2PLUS
>   	help
>   	  This enables the divider clock driver support on TI's SoCs.
>   
>   config CLK_TI_GATE
>   	bool "TI gate clock driver"
> -	depends on CLK && OF_CONTROL
> +	depends on CLK && OF_CONTROL && ARCH_OMAP2PLUS
>   	help
>   	  This enables the gate clock driver support on TI's SoCs.
>   
>   config CLK_TI_MUX
>   	bool "TI mux clock driver"
> -	depends on CLK && OF_CONTROL && CLK_CCF
> +	depends on CLK && OF_CONTROL && CLK_CCF && ARCH_OMAP2PLUS
>   	help
>   	  This enables the mux clock driver support on TI's SoCs.
>   

Do other Kconfigs' work in this file without access to TI platform 
specific drivers and headers? am wondering that every Kconfig in this 
file would ideally be TI specific only..

Regards,
Manorit
