Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA14CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 15:29:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1964787CFC;
	Thu,  4 Apr 2024 17:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CLy+N4y2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF9E487D74; Thu,  4 Apr 2024 17:29:52 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64DE687CF9
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 17:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 434FTfHq082506;
 Thu, 4 Apr 2024 10:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712244581;
 bh=BUxgHXzGKh3BSwforNHPCCXtiTVih65k+Ae9JKbQDpc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=CLy+N4y2IU8bzBBtSVfPANE8UQy4jqlJ6Ah1KWNBB5y92jK2R7GQ7Jve9EBkAeJ0X
 m/WChL7wT2iosrMCLAFh0K20DLpehuLQTxSUE0HwdGOwPiValpzxo7i1MbMQ7QFcjB
 AwmiXhtvUlD3di+X+76TC1ZADNwuhjMTAvvTF1So=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 434FTfnW004895
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Apr 2024 10:29:41 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 10:29:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 10:29:40 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 434FTeUH006298;
 Thu, 4 Apr 2024 10:29:40 -0500
Message-ID: <d738eaaf-6f13-4502-98a1-ef1bfe82d2ff@ti.com>
Date: Thu, 4 Apr 2024 10:29:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/15] arm: dts: Introduce J722S U-Boot dts files
To: Jayesh Choudhary <j-choudhary@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <jh80.chung@samsung.com>, <lukma@denx.de>,
 <seanga2@gmail.com>, <vaishnav.a@ti.com>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <sumit.garg@linaro.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>,
 <r-gunasekaran@ti.com>
References: <20240404090039.87458-1-j-choudhary@ti.com>
 <20240404090039.87458-14-j-choudhary@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240404090039.87458-14-j-choudhary@ti.com>
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

On 4/4/24 4:00 AM, Jayesh Choudhary wrote:
> Include the uboot device tree files needed to boot the board.
> 
> Co-developed-by: Vaishnav Achath <vaishnav.a@ti.com>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>   arch/arm/dts/Makefile                      |    2 +
>   arch/arm/dts/k3-j722s-binman.dtsi          |  171 ++
>   arch/arm/dts/k3-j722s-ddr-lp4-50-3733.dtsi | 2795 ++++++++++++++++++++
>   arch/arm/dts/k3-j722s-evm-u-boot.dtsi      |   36 +
>   arch/arm/dts/k3-j722s-r5-evm.dts           |   82 +
>   5 files changed, 3086 insertions(+)
>   create mode 100644 arch/arm/dts/k3-j722s-binman.dtsi
>   create mode 100644 arch/arm/dts/k3-j722s-ddr-lp4-50-3733.dtsi
>   create mode 100644 arch/arm/dts/k3-j722s-evm-u-boot.dtsi
>   create mode 100644 arch/arm/dts/k3-j722s-r5-evm.dts
> 

[...]

> diff --git a/arch/arm/dts/k3-j722s-evm-u-boot.dtsi b/arch/arm/dts/k3-j722s-evm-u-boot.dtsi
> new file mode 100644
> index 0000000000..056ef08455
> --- /dev/null
> +++ b/arch/arm/dts/k3-j722s-evm-u-boot.dtsi
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Common J722S EVM dts file for SPLs
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include "k3-j722s-binman.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +		tick-timer = &main_timer0;
> +	};
> +};
> +
> +&main_pktdma {
> +	reg = <0x00 0x485c0000 0x00 0x000100>,
> +	      <0x00 0x4a800000 0x00 0x020000>,
> +	      <0x00 0x4aa00000 0x00 0x040000>,
> +	      <0x00 0x4b800000 0x00 0x400000>,
> +	      <0x00 0x485e0000 0x00 0x020000>,
> +	      <0x00 0x484a0000 0x00 0x004000>,
> +	      <0x00 0x484c0000 0x00 0x002000>,
> +	      <0x00 0x48430000 0x00 0x004000>;
> +	reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt",
> +		    "cfg", "tchan", "rchan", "rflow";

Is this needed? Do we still not have the correct regs in
upstream kernel?

> +};
> +
> +&dmsc {
> +	bootph-pre-ram;
> +
> +	k3_sysreset: sysreset-controller {
> +		compatible = "ti,sci-sysreset";
> +		bootph-pre-ram;

This node won't be needed soon either[0]. Should mean an
almost empty -u-boot.dtsi file, which should be the goal.

Andrew

[0] https://lore.kernel.org/all/20240402160908.508974-1-afd@ti.com/

> +	};
> +};
> diff --git a/arch/arm/dts/k3-j722s-r5-evm.dts b/arch/arm/dts/k3-j722s-r5-evm.dts
> new file mode 100644
> index 0000000000..aff83cd5d9
> --- /dev/null
> +++ b/arch/arm/dts/k3-j722s-r5-evm.dts
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * J722S EVM dts file for R5 SPL
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include "k3-j722s-evm.dts"
> +#include "k3-j722s-evm-u-boot.dtsi"
> +
> +#include "k3-j722s-ddr-lp4-50-3733.dtsi"
> +#include "k3-am62a-ddr.dtsi"
> +
> +/ {
> +	aliases {
> +		remoteproc0 = &sysctrler;
> +		remoteproc1 = &a53_0;
> +		serial0 = &wkup_uart0;
> +		serial2 = &main_uart0;
> +	};
> +
> +	a53_0: a53@0 {
> +		compatible = "ti,am654-rproc";
> +		reg = <0x00 0x00a90000 0x00 0x10>;
> +		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> +			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> +			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> +		resets = <&k3_reset 135 0>;
> +		clocks = <&k3_clks 61 0>;
> +		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		assigned-clock-parents = <&k3_clks 61 2>;
> +		assigned-clock-rates = <200000000>, <1200000000>;
> +		ti,sci = <&dmsc>;
> +		ti,sci-proc-id = <32>;
> +		ti,sci-host-id = <10>;
> +		bootph-all;
> +	};
> +
> +	dm_tifs: dm-tifs {
> +		compatible = "ti,j721e-dm-sci";
> +		ti,host-id = <36>;
> +		ti,secure-host;
> +		mbox-names = "rx", "tx";
> +		mboxes= <&secure_proxy_main 22>,
> +			<&secure_proxy_main 23>;
> +		bootph-all;
> +	};
> +};
> +
> +&dmsc {
> +	mboxes= <&secure_proxy_main 0>,
> +		<&secure_proxy_main 1>,
> +		<&secure_proxy_main 0>;
> +	mbox-names = "rx", "tx", "notify";
> +	ti,host-id = <35>;
> +	ti,secure-host;
> +};
> +
> +&cbass_main {
> +	sa3_secproxy: secproxy@44880000 {
> +		compatible = "ti,am654-secure-proxy";
> +		#mbox-cells = <1>;
> +		reg = <0x00 0x44880000 0x00 0x20000>,
> +		      <0x00 0x44860000 0x00 0x20000>,
> +		      <0x00 0x43600000 0x00 0x10000>;
> +		reg-names = "rt", "scfg", "target_data";
> +		bootph-all;
> +	};
> +
> +	sysctrler: sysctrler {
> +		compatible = "ti,am654-system-controller";
> +		mboxes= <&secure_proxy_main 1>,
> +			<&secure_proxy_main 0>,
> +			<&sa3_secproxy 0>;
> +		mbox-names = "tx", "rx", "boot_notify";
> +		bootph-all;
> +	};
> +};
> +
> +/* WKUP UART0 is used for DM firmware logs */
> +&wkup_uart0 {
> +	status = "okay";
> +};
