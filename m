Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDFCC369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 22:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B32A78426C;
	Sat, 12 Apr 2025 00:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mbeyiLtN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A3A88426E; Sat, 12 Apr 2025 00:59:26 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50F2084262
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 00:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BMxHMP1564618
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 17:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744412357;
 bh=7cvwkoyeE6e+HDngL4OOCMQ23Om5boeV8vGRhusADpA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=mbeyiLtNmX5ZWgQE75S5eULjoULWHNdGwYr8kFs1TuaPkCBuTLaf/DhuLnLXgiSlp
 cPItovADhtEguWcBSP2Q79RD65IyJ2+8s0LRemrtglyGAfnjfhP+NdqgeoSpU0t+qO
 PrHx1s31QC1NOVW+SIUdQVlk9bLl2mYUPY+Gg5QU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BMxHg1037064
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 11 Apr 2025 17:59:17 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 17:59:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 17:59:17 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BMxHJQ093950;
 Fri, 11 Apr 2025 17:59:17 -0500
Date: Fri, 11 Apr 2025 17:59:17 -0500
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>
CC: Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/9] arch: arm: dts: k3-am67a-beagley-ai-u-boot: Mark
 main_gpio1 as bootph-all
Message-ID: <20250411225917.64o7bhux3wkccp6k@reunite>
References: <20250411225717.3117370-1-nm@ti.com>
 <20250411225717.3117370-3-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250411225717.3117370-3-nm@ti.com>
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

On 17:57-20250411, Nishanth Menon wrote:
> main_gpio1 controls the voltage for the SDcard from 3.3v to 1.8v.
> This is required for proper operation of SDcard through various boot
> stages.
> 
> Fixes the following seen in the boot log:
> failed to set vqmmc-voltage to 3.3V
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
> index 6c52038cdcaf..6330ca93fc74 100644
> --- a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
> @@ -53,6 +53,10 @@
>  	status = "disabled";
>  };
>  
> +&main_gpio1 {
> +	bootph-all;
> +};
> +
>  #if IS_ENABLED(CONFIG_TARGET_J722S_R5_BEAGLEY_AI)
>  
>  &binman {
> -- 
> 2.47.0
> 

Forgot to mention, I have posted an upstream kernel patch:
https://lore.kernel.org/all/20250411203950.2859356-1-nm@ti.com/

But the warning was too glaring to ignore :(

There are probably other bootph patches that may need to be synced up to
upstream.. hoping others will contribute there.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
