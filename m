Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B57C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 03:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A13EE889F8;
	Thu, 15 Aug 2024 05:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BLNgZoEd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA7FD889FD; Thu, 15 Aug 2024 05:03:02 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84158889C9
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 05:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47F32wog006498;
 Wed, 14 Aug 2024 22:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723690978;
 bh=IeI9wasN+8JIj692pDVlbltTyHfifxW71HRGxGZ7+mA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=BLNgZoEd3tV9L1TTbT3D+R0iE9Sac4MygFCLQgL6a9GWVNS9yS7EmqFyMtRNalZKR
 WJJfBf75ykPIh594kQ9NHG67SA8cfQ+VYvBkisKZ6+93aCMDTGwFc7EGQRCWcP1RO1
 PsAfDZkYqeR8uJ0QEI63CfY8eJrZ1wZBzO4oQbPc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47F32w14003687
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Aug 2024 22:02:58 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 22:02:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 22:02:58 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47F32rG3031222;
 Wed, 14 Aug 2024 22:02:54 -0500
Message-ID: <7be4c52f-bebc-4cdb-af39-f58dba729fd1@ti.com>
Date: Thu, 15 Aug 2024 08:32:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] arm: dts: k3-j7*-r5: Add MPU clock in clocks
 property
To: Manorit Chawdhry <m-chawdhry@ti.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Aniket Limaye <a-limaye@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis
 <afd@ti.com>, Nishanth Menon <nm@ti.com>
References: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
 <20240813-b4-upstream-j721s2-avs-v3-3-5115d93cdeb2@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240813-b4-upstream-j721s2-avs-v3-3-5115d93cdeb2@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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


On 8/13/2024 11:40 AM, Manorit Chawdhry wrote:
> MPU clock had been missing. Distinguish multiple clocks with clock-names
> and add MPU clock as well.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   arch/arm/dts/k3-am69-r5-sk.dts                 | 3 ++-
>   arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 3 ++-
>   arch/arm/dts/k3-j721e-r5.dtsi                  | 3 ++-
>   arch/arm/dts/k3-j721s2-r5.dtsi                 | 3 ++-
>   arch/arm/dts/k3-j784s4-r5-evm.dts              | 3 ++-
>   5 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/dts/k3-am69-r5-sk.dts b/arch/arm/dts/k3-am69-r5-sk.dts
> index f177f563527f..9bbf76d8bf35 100644
> --- a/arch/arm/dts/k3-am69-r5-sk.dts
> +++ b/arch/arm/dts/k3-am69-r5-sk.dts
> @@ -26,7 +26,8 @@
>   		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
>   				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
>   		resets = <&k3_reset 202 0>;
> -		clocks = <&k3_clks 61 0>;
> +		clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;


Thanks for catching this

Could we think of having SOC specific R5 dt , So that we don't need to 
update such SOC information at each board level

Similar to what is done (k3-j721e-r5.dtsi)

> +		clock-names = "gtc", "core";
>   		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
>   		assigned-clock-parents = <&k3_clks 61 2>;
>   		assigned-clock-rates = <200000000>, <2000000000>;
> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> index fb7e2e502392..e6da86f3cd10 100644
> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> @@ -23,7 +23,8 @@
>   				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
>   				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
>   		resets = <&k3_reset 202 0>;
> -		clocks = <&k3_clks 61 1>;
> +		clocks = <&k3_clks 61 1>, <&k3_clks 202 2>;
> +		clock-names = "gtc", "core";
>   		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 323 0>;
>   		assigned-clock-parents= <0>, <0>, <&k3_clks 323 2>;
>   		assigned-clock-rates = <2000000000>, <200000000>;
> diff --git a/arch/arm/dts/k3-j721e-r5.dtsi b/arch/arm/dts/k3-j721e-r5.dtsi
> index fd0d921272c5..688a6cf40892 100644
> --- a/arch/arm/dts/k3-j721e-r5.dtsi
> +++ b/arch/arm/dts/k3-j721e-r5.dtsi
> @@ -20,7 +20,8 @@
>   				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
>   				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
>   		resets = <&k3_reset 202 0>;
> -		clocks = <&k3_clks 61 1>;
> +		clocks = <&k3_clks 61 1>, <&k3_clks 202 2>;
> +		clock-names = "gtc", "core";
>   		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>;
>   		assigned-clock-rates = <2000000000>, <200000000>;
>   		ti,sci = <&dmsc>;
> diff --git a/arch/arm/dts/k3-j721s2-r5.dtsi b/arch/arm/dts/k3-j721s2-r5.dtsi
> index caf696c2d960..634676c8491e 100644
> --- a/arch/arm/dts/k3-j721s2-r5.dtsi
> +++ b/arch/arm/dts/k3-j721s2-r5.dtsi
> @@ -20,7 +20,8 @@
>   				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
>   				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
>   		resets = <&k3_reset 202 0>;
> -		clocks = <&k3_clks 61 1>;
> +		clocks = <&k3_clks 61 1>, <&k3_clks 202 0>;
> +		clock-names = "gtc", "core";
>   		assigned-clocks = <&k3_clks 61 1>, <&k3_clks 202 0>;
>   		assigned-clock-parents = <&k3_clks 61 3>;
>   		assigned-clock-rates = <200000000>, <2000000000>;
> diff --git a/arch/arm/dts/k3-j784s4-r5-evm.dts b/arch/arm/dts/k3-j784s4-r5-evm.dts
> index bef4573d3d20..306d2007f89e 100644
> --- a/arch/arm/dts/k3-j784s4-r5-evm.dts
> +++ b/arch/arm/dts/k3-j784s4-r5-evm.dts
> @@ -26,7 +26,8 @@
>   		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
>   				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
>   		resets = <&k3_reset 202 0>;
> -		clocks = <&k3_clks 61 0>;
> +		clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
> +		clock-names = "gtc", "core";
>   		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
>   		assigned-clock-parents = <&k3_clks 61 2>;
>   		assigned-clock-rates = <200000000>, <2000000000>;
>
