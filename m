Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B064EE49AB
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 19:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6863486497;
	Tue, 22 Aug 2023 21:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G+JucykY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 884AB86482; Tue, 22 Aug 2023 21:58:22 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F1EB8647E
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 21:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MJwCVl070384;
 Tue, 22 Aug 2023 14:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692734292;
 bh=b77JCZ6O/DLii2oMlV0yDOw9JAVvW5dhGNCMSmXoAiM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=G+JucykYyS2iFCP4Opyht+1xgkOU7kRKTN0oFVKhhKMBD2mMp5RxgoiqzKtDBgqJd
 e02wtVtBPSquKx7fxsat0xfTtbvB6MeEZVoi4zW7L18TanmS7n702SzxKe244xtu1S
 rmqSLqM0hUMmXHwTi9PtNvRLHDq/5vLIfFK/zWNY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MJwB1b069909
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 14:58:11 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 14:58:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 14:58:11 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MJwBFJ004440;
 Tue, 22 Aug 2023 14:58:11 -0500
Date: Tue, 22 Aug 2023 14:58:11 -0500
From: reidt <reidt@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>
Subject: Re: [PATCH] arm: dts: j7200: dtb sync with Linux 6.5-rc1
Message-ID: <20230822195811.hhmtkfjobawtcd7f@reidt-HP-Z2>
References: <20230822185725.6718-1-reidt@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230822185725.6718-1-reidt@ti.com>
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

On 13:57-20230822, Reid Tonking wrote:

[...]

> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> index e62f9218e8..bd4be7215f 100644
> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> @@ -41,44 +31,34 @@
>  		ti,sci-host-id = <10>;
>  		bootph-pre-ram;
>  	};
> -
> -	clk_200mhz: dummy_clock_200mhz {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <200000000>;
> -		bootph-pre-ram;
> -	};
> -
> -	clk_19_2mhz: dummy_clock_19_2mhz {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <19200000>;
> -		bootph-pre-ram;
> -	};
>  };
>  
>  &memorycontroller {
>  	power-domains = <&k3_pds 8 TI_SCI_PD_SHARED>,
>  			<&k3_pds 90 TI_SCI_PD_SHARED>;
>  	clocks = <&k3_clks 8 5>, <&k3_clks 30 9>;
> +	bootph-pre-ram;
> +};
> +
> +&mcu_timer0 {
> +	/delete-property/ power-domains;
> +	ti,timer-alwon;
> +	clock-frequency = <25000000>;
> +	bootph-pre-ram;
>  };

This needs to be..
$mcu_timer0 {
clock-frequency = <25000000>;
bootph-pre-ram;
};

This fix was accidently left out of the commit, so it'll be changed for
v2. The change to dev-data.c allows this.

-Reid
