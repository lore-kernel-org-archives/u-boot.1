Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74F6C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 05:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 383CE80104;
	Wed,  5 Feb 2025 06:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Hj46BaR7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB0E7805E7; Wed,  5 Feb 2025 06:55:50 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC48F80087
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 06:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5155tkYP3364188
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Feb 2025 23:55:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738734946;
 bh=4quRJTeYQ1kp55QES0MRGIugYIJoPU5Oi0hjUdMyd90=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Hj46BaR7KX8sDuSpz4jfvh5zaCRk96lidWF3IJLgFOX6cWlKyHw/0YKTdgWi5FcbT
 PJWUn+cJV7DZNvqZSrrl/5kXdqEFY6upu0nJmsEJxNdZkmbaLqaMmMwrqsUcoGoJfp
 NmPrceRGhuGojgPaSEGJCMDFUU62VRpWov8DIQ9o=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5155tk1f009563
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 4 Feb 2025 23:55:46 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Feb 2025 23:55:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Feb 2025 23:55:45 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5155tjc1050918;
 Tue, 4 Feb 2025 23:55:45 -0600
Date: Wed, 5 Feb 2025 11:25:44 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <trini@konsulko.com>, 
 <n-francis@ti.com>, <nmorrisson@phytec.com>, <d.schultz@phytec.de>,
 <sjg@chromium.org>
Subject: Re: [PATCH v2 1/3] arch: arm: dts: phyboard-electra-uboot.dtsi: Add
 bootph props to i2c
Message-ID: <20250205055544.ajyj73fvow5ngmgt@lcpd911>
References: <20250205043013.1404917-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250205043013.1404917-1-w.egorov@phytec.de>
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

On Feb 05, 2025 at 05:30:11 +0100, Wadim Egorov wrote:
> Add bootph-all properties to I2C0 nodes to ensure the bus and EEPROM
> are accessible across all stages. This enables reading the SoM
> configuration at any point during the boot process.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> Tested-by: Daniel Schultz <d.schultz@phytec.de>
> ---
> v2: Add Tested-by from Daniel
> ---
>  arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
> index 8f3c3a185ae..c68a48678a2 100644
> --- a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
> @@ -72,6 +72,14 @@
>  	bootph-all;
>  };
>  
> +&main_i2c0 {
> +	bootph-all;
> +};
> +
> +&main_i2c0_pins_default {
> +	bootph-all;
> +};
> +

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
