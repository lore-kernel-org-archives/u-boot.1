Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9998FC07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 03:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE4D686F93;
	Wed, 15 Nov 2023 04:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V8pzjdH0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFE98871E7; Wed, 15 Nov 2023 04:34:32 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE0CE863FD
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 04:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AF3YQxR119089;
 Tue, 14 Nov 2023 21:34:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700019266;
 bh=4XkgO2bsMgeDaSNKGF6IngMy+xhRGVuNWYMyg1Ag9/U=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=V8pzjdH0WmKvZh/Zi2bhAb7hmYDvXz1I+OkfI2L1hylHdu3RdQlXhjtn4GVh3Ymv5
 zEKGsJNfgcHMGsuBs15g1HYWsIaXSKBv0Eaxdd8A6Eb5Lq3Q/4coNFLrqS0gU4T1bN
 ImI0sJVTaJDOkjRhijjD4kg7ti9RbNoySa9YTeZE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AF3YQog130646
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 14 Nov 2023 21:34:26 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 Nov 2023 21:34:26 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 Nov 2023 21:34:26 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AF3YQJ5004211;
 Tue, 14 Nov 2023 21:34:26 -0600
Date: Tue, 14 Nov 2023 21:34:26 -0600
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: <trini@konsulko.com>, <marcel.ziswiler@toradex.com>, <s-vadapalli@ti.com>, 
 <r-gunasekaran@ti.com>, <vigneshr@ti.com>, <srk@ti.com>,
 <u-boot@lists.denx.de>, Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH] arm: dts: k3-am625-verdin-wifi-dev-u-boot.dtsi: Fix DMA
 with BCDMA
Message-ID: <20231115033426.h7di3hgcta5fplrf@humbling>
References: <20231114202856.39072-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231114202856.39072-1-rogerq@kernel.org>
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

On 22:28-20231114, Roger Quadros wrote:
> BCDMA can be used at SPL for OSPI boot and mem-to-mem DMA
> so add "bootph-all" to BCDMA node.
> 
> Suggested-by: Nishanth Menon <nm@ti.com>
> Fixes: 9a3f2b6798b0 ("arm: dts: k3-am625-verdin-wifi-dev-u-boot.dtsi: Fix DMA/Ethernet")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
> index 75cb60b57d..588d9594a8 100644
> --- a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
> @@ -53,6 +53,7 @@
>  	      <0x00 0x484c2000 0x00 0x2000>;
>  	reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt",
>  		    "ringrt" , "cfg", "tchan", "rchan";
> +	bootph-all;

Reviewed-by: Nishanth Menon <nm@ti.com>

>  };
>  
>  &main_pktdma {
> 
> base-commit: 92b27528d777ce85362af45e7d2974a6c856219b
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
