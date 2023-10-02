Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8833E784BD
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED11687184;
	Mon,  2 Oct 2023 17:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yLiU2vNd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41C4E87180; Mon,  2 Oct 2023 17:20:12 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA34F87179
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 392FK14b047719;
 Mon, 2 Oct 2023 10:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696260001;
 bh=ZgUotXRT9T4H9AF7FgcB20ohMp6R2ry8/0P6EOXvPYY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=yLiU2vNdrfh85sh+62ffx+aj2CmIqKsskAxI8XWgWzulqZA2un9LM/322m3zDh9t/
 rVGIqJko1BJI4E6PkVNxgtfTaUnXQcHYNjdWKpyIMhQZADSdme4hiJX/NhBvuUobLU
 M6w7yRqA7cvoUWFnKS86vZDirpgOip5RI/u5MsfA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 392FK1EN115913
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Oct 2023 10:20:01 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Oct 2023 10:20:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Oct 2023 10:20:01 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 392FK1Nr113947;
 Mon, 2 Oct 2023 10:20:01 -0500
Date: Mon, 2 Oct 2023 10:20:01 -0500
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>,
 <sjg@chromium.org>, <jonas@kwiboo.se>, <srk@ti.com>, <afd@ti.com>,
 <bb@ti.com>, <praneeth@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/6] arm: dts: k3-am64-evm: Mark dependent nodes for
 pre-relocation phase
Message-ID: <20231002152001.qusdm4rijpnnj7ce@riverboat>
References: <20230929134646.214781-1-rogerq@kernel.org>
 <20230929134646.214781-3-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230929134646.214781-3-rogerq@kernel.org>
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

On 16:46-20230929, Roger Quadros wrote:
> CPSW node needs PHY, MDIO, pinmux, DMA and INTC nodes.
> USB and MMC nodes need pinmux.
> 
> Mark them as 'bootph-all' so they are available in all
> pre-relocation phases.
> 
> Fixes below dts warning:
> 
> <stdout>: Warning (dmas_property): /bus@f4000/ethernet@8000000:dmas: Could not get phandle node for (cell 0)
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  arch/arm/dts/k3-am642-evm-u-boot.dtsi | 48 +++++++++++++++++++++++++++
>  arch/arm/dts/k3-am642-r5-evm.dts      |  8 +++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> index d06955dfbc..953bbe9aaf 100644
> --- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> @@ -51,6 +51,10 @@
>  	bootph-all;
>  };
>  
> +&main_usb0_pins_default {
> +	bootph-all;
> +};
> +
>  &usb0 {
>  	dr_mode="peripheral";
>  	bootph-all;
> @@ -100,12 +104,56 @@
>  	bootph-all;
>  };
>  
> +&main_mmc1_pins_default {
> +	bootph-all;
> +};
> +
>  &sdhci1 {
>  	bootph-all;
>  };
>  
> +&inta_main_dmss {
> +	bootph-all;
> +};
> +
> +&main_pktdma {
> +	bootph-all;
> +};
> +
> +&mdio1_pins_default {
> +	bootph-all;
> +};
> +
> +&cpsw3g_mdio {
> +	bootph-all;
> +};
> +
> +&cpsw3g_phy0 {
> +	bootph-all;
> +};
> +
> +&rgmii1_pins_default {
> +	bootph-all;
> +};
> +
> +&rgmii2_pins_default {
> +	bootph-all;
> +};
> +
>  &cpsw3g {
>  	bootph-all;
> +
> +	ethernet-ports {
> +		bootph-all;
> +	};
> +};
> +
> +&phy_gmii_sel {
> +	bootph-all;
> +};
> +
> +&cpsw_port1 {
> +	bootph-all;
>  };
>  
>  &cpsw_port2 {
> diff --git a/arch/arm/dts/k3-am642-r5-evm.dts b/arch/arm/dts/k3-am642-r5-evm.dts
> index 696735d8e2..64b3c3af63 100644
> --- a/arch/arm/dts/k3-am642-r5-evm.dts
> +++ b/arch/arm/dts/k3-am642-r5-evm.dts
> @@ -74,6 +74,14 @@
>  	ti,secure-host;
>  };
>  
> +&vtt_supply {
> +	bootph-pre-ram;
> +};
> +
> +&memorycontroller {
> +	vtt-supply = <&vtt_supply>;
> +};
> +
>  &sdhci0 {
>  	clocks = <&clk_200mhz>;
>  	clock-names = "clk_xin";
> -- 
> 2.34.1
> 

Reviewed-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
