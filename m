Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3B8C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 05:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AAD5883B1;
	Fri,  5 Jul 2024 07:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uSTtdQhp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B407588373; Fri,  5 Jul 2024 07:51:09 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A199D884FC
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 07:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4655oiGL047327;
 Fri, 5 Jul 2024 00:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720158644;
 bh=jQ0NC78kVFIlj1IbN5YIT+8h/wCz1ohPQDijpNrUxh4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=uSTtdQhp9HT/DTuRJbHY4mnwCUxZF7fW1GhnuHQ/KPGD80AJPISDKLPXLehcbNqs3
 OMpq+qZt9dmvB8nsSHL0XLklpTkz5YEH+ySGB+lMWlSwbmzuDWTMsrYezq2PRm6MQM
 E6GECn84uJgai3fgrwFZnfZuUa7A2j4Rg8+Yp0hA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4655oiSu030142
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 5 Jul 2024 00:50:44 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jul 2024 00:50:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jul 2024 00:50:43 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4655ohu9073608;
 Fri, 5 Jul 2024 00:50:43 -0500
Date: Fri, 5 Jul 2024 11:20:42 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>, Marek
 =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Udit Kumar <u-kumar1@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>, "Sean
 Anderson" <seanga2@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 "Nikhil M Jain" <n-jain1@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Wadim Egorov <w.egorov@phytec.de>, Sjoerd
 Simons <sjoerd@collabora.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 "Roger Quadros" <rogerq@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, "Nishanth Menon" <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, <srk@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 01/10] common: spl: spl: Init DRAM size in R5/A53 SPL
Message-ID: <20240705055042.q6qg3kdcm6cf2mjt@dhruva>
References: <20240705045030.1141934-1-c-vankar@ti.com>
 <20240705045030.1141934-2-c-vankar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240705045030.1141934-2-c-vankar@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On Jul 05, 2024 at 10:20:21 +0530, Chintan Vankar wrote:
> Initialize DRAM size in SPL stage since networking requires DDR
> to be initialized.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 

Reviewed-by: Dhruva Gole <d-gole@ti.com>

Best regards,
Dhruva

> Link to v2:
> https://lore.kernel.org/r/20240425120822.2048012-2-c-vankar@ti.com/
> 
> Changes from v2 to v3:
> - No changes.
> 
>  common/spl/spl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 7794ddccad..5914eb8205 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -720,7 +720,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>  		initr_watchdog();
>  
>  	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) || CONFIG_IS_ENABLED(HANDOFF) ||
> -	    IS_ENABLED(CONFIG_SPL_ATF))
> +	    IS_ENABLED(CONFIG_SPL_ATF) || IS_ENABLED(CONFIG_SPL_NET))
>  		dram_init_banksize();
>  
>  	if (CONFIG_IS_ENABLED(PCI) && !(gd->flags & GD_FLG_DM_DEAD)) {
> -- 
> 2.34.1
> 

