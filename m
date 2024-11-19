Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090FBD60D1A
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 05:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 712DD894FD;
	Tue, 19 Nov 2024 06:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XTpkvdav";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E2A0894FA; Tue, 19 Nov 2024 06:00:17 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E2BF894E0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 06:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ50ERS077679;
 Mon, 18 Nov 2024 23:00:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731992414;
 bh=RAGEr4pXdNkDSHziFZT13Q7pFE5LPzwhQXe/SGZHaOE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=XTpkvdav6uEeDkZ3NEig7ExDbWVp5+ySb9R6JEUfVw4pHqux2s/BwZv8Qv5klmYHc
 8YqK19RBSoZIAbfNiYgleeHsNz8OV57jIqLwoj5/G1tvRBTbEDRntpfI1oiQFz/Pnm
 QvLra7kEypA6T3M9zdi6SIhGgi4DwnqClUl2Jx4w=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ50EY6084751;
 Mon, 18 Nov 2024 23:00:14 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 23:00:13 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 23:00:13 -0600
Received: from localhost (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ50DcD017038;
 Mon, 18 Nov 2024 23:00:13 -0600
Date: Tue, 19 Nov 2024 10:30:12 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <b-padhi@ti.com>, <sabiya.d@ti.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/5] arch: arm: mach-k3: j784s4_init: Probe AVS driver
Message-ID: <20241119050012.etdsnixpx3uvjbvd@uda0497581>
References: <20241118105714.1973573-1-n-francis@ti.com>
 <20241118105714.1973573-4-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241118105714.1973573-4-n-francis@ti.com>
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

Hi Neha,

On 16:27-20241118, Neha Malcom Francis wrote:
> Probe the AVS driver to set the AVS voltage.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  arch/arm/mach-k3/j784s4/j784s4_init.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
> index 07b5d7d7504..8a41cd3bb50 100644
> --- a/arch/arm/mach-k3/j784s4/j784s4_init.c
> +++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
> @@ -233,9 +233,19 @@ void k3_mem_init(void)
>  
>  void board_init_f(ulong dummy)
>  {
> +	struct udevice *dev;
> +	int ret;
> +
>  	k3_spl_init();
>  	k3_mem_init();
>  
> +	if (IS_ENABLED(CONFIG_CPU_V7R) && IS_ENABLED(CONFIG_K3_AVS0)) {
> +		ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(k3_avs),
> +						  &dev);
> +		if (ret)
> +			printf("AVS init failed: %d\n", ret);
> +	}
> +

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit

>  	if (IS_ENABLED(CONFIG_CPU_V7R))
>  		setup_navss_nb();
>  
> -- 
> 2.34.1
> 
