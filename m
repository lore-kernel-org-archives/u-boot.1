Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D385E784BD
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D06198717A;
	Mon,  2 Oct 2023 17:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TI/a2E8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DA2487194; Mon,  2 Oct 2023 17:20:41 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 662868717A
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 392FKWlf073125;
 Mon, 2 Oct 2023 10:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696260032;
 bh=QXL7EpdfNsv3JHq4eYa9pKTMRagXfBdmVCvo5Md1WAc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=TI/a2E8W7u80hn8eM9ivMpeNucwRMo2/rDarBsz3LbEkrEcZN78i4vEYpj4FIIsxW
 Pyq2Qkpl+gFLCFQN3U8xX+2fSNVwx8r8f4ou22wvcw+Ry4RnGzHk9ajY5HQSQteBC0
 He18PKaLvygJg5Wpik4UI4PwR+B/NO/mr7qRmnaw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 392FKWhZ064075
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Oct 2023 10:20:32 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Oct 2023 10:20:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Oct 2023 10:20:32 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 392FKW5n010585;
 Mon, 2 Oct 2023 10:20:32 -0500
Date: Mon, 2 Oct 2023 10:20:32 -0500
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>,
 <sjg@chromium.org>, <jonas@kwiboo.se>, <srk@ti.com>, <afd@ti.com>,
 <bb@ti.com>, <praneeth@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 4/6] arm: dts: k3-am642-sk: Mark dependent nodes for
 pre-relocation phase
Message-ID: <20231002152032.fzeq67zlcc6cjrdw@unburned>
References: <20230929134646.214781-1-rogerq@kernel.org>
 <20230929134646.214781-5-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230929134646.214781-5-rogerq@kernel.org>
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
> Mark them as 'bootph-all' so they are available in all
> pre-relocation phases.
> 
> Fixes below dts warnings:
> 
> <stdout>: Warning (reg_format): /bus@f4000/ethernet@8000000/mdio@f00/ethernet-phy@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> <stdout>: Warning (unit_address_vs_reg): /bus@f4000/ethernet@8000000/mdio@f00: node has a unit name, but no reg or ranges property
> <stdout>: Warning (pci_device_reg): Failed prerequisite 'reg_format'
> <stdout>: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> <stdout>: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> <stdout>: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> <stdout>: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> <stdout>: Warning (avoid_default_addr_size): /bus@f4000/ethernet@8000000/mdio@f00/ethernet-phy@1: Relying on default #address-cells value
> <stdout>: Warning (avoid_default_addr_size): /bus@f4000/ethernet@8000000/mdio@f00/ethernet-phy@1: Relying on default #size-cells value
> <stdout>: Warning (avoid_unnecessary_addr_size): Failed prerequisite 'avoid_default_addr_size'
> <stdout>: Warning (unique_unit_address): Failed prerequisite 'avoid_default_addr_size'
> <stdout>: Warning (msi_parent_property): /bus@f4000/bus@48000000/dma-controller@485c0100:msi-parent: Could not get phandle node for (cell 0)
> <stdout>: Warning (msi_parent_property): /bus@f4000/bus@48000000/dma-controller@485c0000:msi-parent: Could not get phandle node for (cell 0)
> <stdout>: Warning (phys_property): /bus@f4000/ethernet@8000000/ethernet-ports/port@2:phys: Could not get phandle node for (cell 0)
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  arch/arm/dts/k3-am642-sk-u-boot.dtsi | 36 ++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am642-sk-u-boot.dtsi b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
> index 5599977f6c..40a53df0b0 100644
> --- a/arch/arm/dts/k3-am642-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
> @@ -92,6 +92,38 @@
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
> +&cpsw3g_phy1 {
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
>  
> @@ -100,6 +132,10 @@
>  	};
>  };
>  
> +&phy_gmii_sel {
> +	bootph-all;
> +};
> +
>  &cpsw_port2 {
>  	bootph-all;
>  };
> -- 
> 2.34.1
> 
Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
