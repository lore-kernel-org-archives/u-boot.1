Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31060CFA76E
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 11:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DDE788B86;
	Fri,  4 Oct 2024 13:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="o6U6OGQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF53C88B89; Fri,  4 Oct 2024 13:30:11 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3150288B63
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 13:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 494BU3Ve019242;
 Fri, 4 Oct 2024 06:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728041403;
 bh=E/fUCRhTe7ONahk5ofhoiFqfsngGrDYedNIr/iIUNnc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=o6U6OGQWNDl/vtFzafgB0bj9HtmHz9QeklmHA0th6WZAjASAm9J80NGxCpMo/QU2X
 1o7FsSFQkbyv7Iu2UvOk/CL5ftBXbdu42GDjFp+pQvlSFLGCN3dyoryUUMjDWG9S/2
 MhPx/qJA1yzleake3IuTmtVNcykZzHS5SWBg1+oI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 494BU2JB028450
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 4 Oct 2024 06:30:03 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Oct 2024 06:30:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Oct 2024 06:30:01 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 494BU1br067952;
 Fri, 4 Oct 2024 06:30:01 -0500
Date: Fri, 4 Oct 2024 06:30:01 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha
 Malcom Francis <n-francis@ti.com>, Keerthy J <j-keerthy@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis
 <afd@ti.com>
Subject: Re: [PATCH v4 3/7] arm: dts: k3-j7*-r5: Add MPU clock in clocks
 property
Message-ID: <20241004113001.h4cshh74q2bqfhqj@frolic>
References: <20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com>
 <20241004-b4-upstream-j721s2-avs-v4-3-6d71c6bab9f4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241004-b4-upstream-j721s2-avs-v4-3-6d71c6bab9f4@ti.com>
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

On 11:54-20241004, Manorit Chawdhry wrote:
> MPU clock had been missing. Distinguish multiple clocks with clock-names
> and add MPU clock as well.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

We have been a bit hacky with GTC - do we want to pull it out as a
separate IP?
> ---
>  arch/arm/dts/k3-am69-r5-sk.dts                 | 3 ++-
>  arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 3 ++-
>  arch/arm/dts/k3-j721e-r5.dtsi                  | 3 ++-
>  arch/arm/dts/k3-j721s2-r5.dtsi                 | 3 ++-
>  arch/arm/dts/k3-j784s4-r5-evm.dts              | 3 ++-
>  5 files changed, 10 insertions(+), 5 deletions(-)

What about other boards? I think it might be time we refactor r5 view as
a include file?

> 
> diff --git a/arch/arm/dts/k3-am69-r5-sk.dts b/arch/arm/dts/k3-am69-r5-sk.dts
> index 4d6aab5ccc38..13809f82d99a 100644
> --- a/arch/arm/dts/k3-am69-r5-sk.dts
> +++ b/arch/arm/dts/k3-am69-r5-sk.dts
> @@ -26,7 +26,8 @@
>  		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
>  				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
>  		resets = <&k3_reset 202 0>;
> -		clocks = <&k3_clks 61 0>;
> +		clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
> +		clock-names = "gtc", "core";
>  		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
>  		assigned-clock-parents = <&k3_clks 61 2>;
>  		assigned-clock-rates = <200000000>, <2000000000>;
> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> index 94760c78dd35..f8df14935dbc 100644
> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> @@ -23,7 +23,8 @@
>  				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
>  				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
>  		resets = <&k3_reset 202 0>;
> -		clocks = <&k3_clks 61 1>;
> +		clocks = <&k3_clks 61 1>, <&k3_clks 202 2>;
> +		clock-names = "gtc", "core";
>  		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 323 0>;
>  		assigned-clock-parents= <0>, <0>, <&k3_clks 323 2>;
>  		assigned-clock-rates = <2000000000>, <200000000>;
> diff --git a/arch/arm/dts/k3-j721e-r5.dtsi b/arch/arm/dts/k3-j721e-r5.dtsi
> index fd0d921272c5..688a6cf40892 100644
> --- a/arch/arm/dts/k3-j721e-r5.dtsi
> +++ b/arch/arm/dts/k3-j721e-r5.dtsi
> @@ -20,7 +20,8 @@
>  				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
>  				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
>  		resets = <&k3_reset 202 0>;
> -		clocks = <&k3_clks 61 1>;
> +		clocks = <&k3_clks 61 1>, <&k3_clks 202 2>;
> +		clock-names = "gtc", "core";
>  		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>;
>  		assigned-clock-rates = <2000000000>, <200000000>;
>  		ti,sci = <&dmsc>;
> diff --git a/arch/arm/dts/k3-j721s2-r5.dtsi b/arch/arm/dts/k3-j721s2-r5.dtsi
> index caf696c2d960..634676c8491e 100644
> --- a/arch/arm/dts/k3-j721s2-r5.dtsi
> +++ b/arch/arm/dts/k3-j721s2-r5.dtsi
> @@ -20,7 +20,8 @@
>  				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
>  				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
>  		resets = <&k3_reset 202 0>;
> -		clocks = <&k3_clks 61 1>;
> +		clocks = <&k3_clks 61 1>, <&k3_clks 202 0>;
> +		clock-names = "gtc", "core";
>  		assigned-clocks = <&k3_clks 61 1>, <&k3_clks 202 0>;
>  		assigned-clock-parents = <&k3_clks 61 3>;
>  		assigned-clock-rates = <200000000>, <2000000000>;
> diff --git a/arch/arm/dts/k3-j784s4-r5-evm.dts b/arch/arm/dts/k3-j784s4-r5-evm.dts
> index d2c752293630..8b8b0e70047e 100644
> --- a/arch/arm/dts/k3-j784s4-r5-evm.dts
> +++ b/arch/arm/dts/k3-j784s4-r5-evm.dts
> @@ -26,7 +26,8 @@
>  		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
>  				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
>  		resets = <&k3_reset 202 0>;
> -		clocks = <&k3_clks 61 0>;
> +		clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
> +		clock-names = "gtc", "core";
>  		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
>  		assigned-clock-parents = <&k3_clks 61 2>;
>  		assigned-clock-rates = <200000000>, <2000000000>;
> 
> -- 
> 2.46.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
