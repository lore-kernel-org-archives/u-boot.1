Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FC6D44001
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 05:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C04388D9B;
	Tue, 19 Nov 2024 06:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uZITqTou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D25688E6B; Tue, 19 Nov 2024 06:16:33 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78F7988B0B
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 06:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJ5GSXh3804848
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2024 23:16:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731993388;
 bh=CEm0yqXl3kq1TDZpBJ/7zWU/WQ0ed/N4txfyZcGnNEk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=uZITqTouueRq/KlzImWnf9/q3PK5at4hLA9h4tPUadIDNWq2faIRdw4lVr1PULvVK
 bEuM5PrFhzoVQtx+IABLY+ilhj0BEbEFUyXjapGG1xqh79Ozu9/6ECgH+HqIQEVsAa
 30MhH9IqFKH/wkNhV9n6stAa1ABgEuDurk0rCrJk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJ5GSBk063282
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Nov 2024 23:16:28 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 23:16:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 23:16:24 -0600
Received: from localhost (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ5GO1p031422;
 Mon, 18 Nov 2024 23:16:24 -0600
Date: Tue, 19 Nov 2024 10:46:23 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Aniket Limaye <a-limaye@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <nm@ti.com>, <n-francis@ti.com>
Subject: Re: [PATCH v4 1/5] arm: dts: k3-j7200-r5-common: Add msmc clk to a72
 node
Message-ID: <20241119051623.j5c7rztya34wsljd@uda0497581>
References: <20241119003617.1871183-1-a-limaye@ti.com>
 <20241119003617.1871183-2-a-limaye@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241119003617.1871183-2-a-limaye@ti.com>
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

Hi Aniket,

On 06:02-20241119, Aniket Limaye wrote:
> From: Reid Tonking <reidt@ti.com>
> 
> The j7200 SOC has a single DDR controller and hence no need for
> configuring the MSMC interleaver. Hence we do not have an explicit node
> for MSMC in j7200 DT, unlike j721s2/j784s4.
> 
> Also, MSMC clk id is described under A72SS0_CORE0 Device in TISCI
> documentation [0].
> 
> Considering the above, define the MSMC clk in the a72 node.
> 
> [0]: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html#clocks-for-a72ss0-core0-device
> 
> Signed-off-by: Reid Tonking <reidt@ti.com>
> ---
[..]
> ---
>  arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> index f096b102793..06fffe2a11b 100644
> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> @@ -23,11 +23,12 @@
>  				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
>  				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
>  		resets = <&k3_reset 202 0>;
> -		clocks = <&k3_clks 61 1>, <&k3_clks 202 2>;
> -		clock-names = "gtc", "core";
> -		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 323 0>;
> -		assigned-clock-parents= <0>, <0>, <&k3_clks 323 2>;
> -		assigned-clock-rates = <2000000000>, <200000000>;
> +		clocks = <&k3_clks 61 1>, <&k3_clks 202 2>, <&k3_clks 4 1> ;
> +		clock-names = "gtc", "core", "msmc";
> +		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 4 1>,
> +						  <&k3_clks 323 0>;
> +		assigned-clock-parents= <0>, <0>, <0>, <&k3_clks 323 2>;
> +		assigned-clock-rates = <2000000000>, <200000000>, <1000000000>;

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit

>  		ti,sci = <&dmsc>;
>  		ti,sci-proc-id = <32>;
>  		ti,sci-host-id = <10>;
> -- 
> 2.47.0
> 
