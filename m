Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E17CA0FFC
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 15:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F03988A24;
	Fri, 30 Aug 2024 17:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CgZIJy9r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78E7F88C2E; Fri, 30 Aug 2024 17:00:24 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AC2C88907
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 17:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UF040v126202;
 Fri, 30 Aug 2024 10:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725030004;
 bh=j956VEK64FfgzlAWO0k8v7EeEm+jXG5tjxz/tAx1gQ0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=CgZIJy9rbaK4r7r75TikPtzfEi5XT7jA3dI9otTNyTmXdY/55D6nc2bp4nllcPyOX
 yFOad0h3ddN1jlOFhOwJo9cl9wcp+OjIijtyiv0JN7L3mY5X2NXtZGfzWjLkRett9N
 pcdqsOFNtkxy7qA1qpSlKd2Fl0F6IBJOUEG8JfrM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47UF02NB007486
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 30 Aug 2024 10:00:04 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 10:00:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 10:00:02 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UExsvR011323;
 Fri, 30 Aug 2024 09:59:55 -0500
Message-ID: <debe9b01-9c43-46e3-9d8b-7ac812c5f2d3@ti.com>
Date: Fri, 30 Aug 2024 20:29:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/11] soc: ti: k3-navss-ringacc: Fix reconfiguration
 of qmode API
To: Chintan Vankar <c-vankar@ti.com>, Michal Simek <michal.simek@amd.com>,
 Dhruva Gole <d-gole@ti.com>, Neha Malcom Francis <n-francis@ti.com>, "Udit
 Kumar" <u-kumar1@ti.com>, MD Danish Anwar <danishanwar@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>,
 "Quentin Schulz" <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, "Simon Glass" <sjg@chromium.org>,
 Kishon Vijay Abraham I <kishon@ti.com>, "Andrew Davis" <afd@ti.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Wadim Egorov
 <w.egorov@phytec.de>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>, Sumit Garg
 <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20240826102515.2774296-1-c-vankar@ti.com>
 <20240826102515.2774296-6-c-vankar@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240826102515.2774296-6-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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



On 26/08/24 15:55, Chintan Vankar wrote:
> Function "k3_ringacc_ring_reconfig_qmode_raw()" should reset qmode to
> requested value and should not update other fields in ring configuration
> register.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 

Thanks for fix this up:


Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>


> This patch is newely added in this series.
> 
>  drivers/soc/ti/k3-navss-ringacc-u-boot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/k3-navss-ringacc-u-boot.c b/drivers/soc/ti/k3-navss-ringacc-u-boot.c
> index 2799f214c77..8227d8bc3e3 100644
> --- a/drivers/soc/ti/k3-navss-ringacc-u-boot.c
> +++ b/drivers/soc/ti/k3-navss-ringacc-u-boot.c
> @@ -42,7 +42,7 @@ static void k3_ringacc_ring_reconfig_qmode_raw(struct k3_nav_ring *ring, enum k3
>  	u32 val;
>  
>  	val = readl(&ring->cfg->size);
> -	val &= KNAV_RINGACC_CFG_RING_SIZE_QMODE_MASK;
> +	val &= ~KNAV_RINGACC_CFG_RING_SIZE_QMODE_MASK;
>  	val |= mode << KNAV_RINGACC_CFG_RING_SIZE_QMODE_SHIFT;
>  	writel(val, &ring->cfg->size);
>  }

-- 
Regards
Vignesh
