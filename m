Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4089DE784BD
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:21:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7CFE8718D;
	Mon,  2 Oct 2023 17:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Qg8gMl/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A4578718D; Mon,  2 Oct 2023 17:21:07 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DEE287166
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 392FKtxC043854;
 Mon, 2 Oct 2023 10:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696260055;
 bh=qyoPAkVhvO10foCQWkYAaaVnch/04KkPRzvAEjfLtVA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Qg8gMl/ETTLPmQzhidIhfUUoCNS1p2aTW7uWrMkrMGNKaKQG6eZyYWBm04i/jXxyO
 cWr4bb7VfsNA8icMDzdajSFveCKqf8JjMuzyOVPdCKWRPLdA4sxhKo1jeiFmqrpwsN
 fzH5mzgUrShgo0nkMUEY2qglLGh/2LCv9k67r5D8=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 392FKtpT116409
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Oct 2023 10:20:55 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Oct 2023 10:20:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Oct 2023 10:20:55 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 392FKtBC118254;
 Mon, 2 Oct 2023 10:20:55 -0500
Date: Mon, 2 Oct 2023 10:20:55 -0500
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>,
 <sjg@chromium.org>, <jonas@kwiboo.se>, <srk@ti.com>, <afd@ti.com>,
 <bb@ti.com>, <praneeth@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 6/6] arm: dts: k3-am625-sk: Mark dependent nodes for
 pre-relocation phase
Message-ID: <20231002152055.jvinjqqjbecupuuo@salon>
References: <20230929134646.214781-1-rogerq@kernel.org>
 <20230929134646.214781-7-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230929134646.214781-7-rogerq@kernel.org>
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
> main_conf is required for phy_gmii_sel.
> Mark them as 'bootph-all' so they are available in all
> pre-relocation phases.
> 
> Fixes the below dts warnings:
> 
> <stdout>: Warning (reg_format): /bus@f0000/syscon@100000/phy@4044:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
> <stdout>: Warning (reg_format): /bus@f0000/ethernet@8000000/ethernet-ports/port@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> <stdout>: Warning (unit_address_vs_reg): /bus@f0000/syscon@100000: node has a unit name, but no reg or ranges property
> <stdout>: Warning (pci_device_reg): Failed prerequisite 'reg_format'
> <stdout>: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> <stdout>: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> <stdout>: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> <stdout>: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> <stdout>: Warning (avoid_default_addr_size): /bus@f0000/syscon@100000/phy@4044: Relying on default #address-cells value
> <stdout>: Warning (avoid_default_addr_size): /bus@f0000/syscon@100000/phy@4044: Relying on default #size-cells value
> <stdout>: Warning (avoid_default_addr_size): /bus@f0000/ethernet@8000000/ethernet-ports/port@1: Relying on default #address-cells value
> <stdout>: Warning (avoid_default_addr_size): /bus@f0000/ethernet@8000000/ethernet-ports/port@1: Relying on default #size-cells value
> <stdout>: Warning (avoid_unnecessary_addr_size): Failed prerequisite 'avoid_default_addr_size'
> <stdout>: Warning (unique_unit_address): Failed prerequisite 'avoid_default_addr_size'
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  arch/arm/dts/k3-am625-sk-u-boot.dtsi | 39 ++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> index c658506256..b78d34b459 100644
> --- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> @@ -21,6 +21,10 @@
>  	};
>  };
>  
> +&main_conf {
> +	bootph-all;
> +};
> +
>  &cbass_main {
>  	bootph-all;
>  };
> @@ -118,8 +122,43 @@
>  	};
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
> +&cpsw3g_mdio {
> +	bootph-all;
> +};
> +
> +&cpsw3g_phy0 {
> +	bootph-all;
> +};
> +
> +&cpsw3g_phy1 {
> +	bootph-all;
> +};
> +
> +&main_rgmii1_pins_default {
> +	bootph-all;
> +};
> +
> +&main_rgmii2_pins_default {
> +	bootph-all;
> +};
> +
> +&phy_gmii_sel {
> +	bootph-all;
> +};
> +
>  &cpsw3g {
>  	bootph-all;
> +	ethernet-ports {
> +		bootph-all;
> +	};
>  };
>  
>  &cpsw_port1 {
> -- 
> 2.34.1
> 
Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
