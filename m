Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9CBC25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 06:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9898088488;
	Wed, 22 May 2024 08:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QpDLwdjv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C578887C0; Wed, 22 May 2024 08:20:43 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B528288412
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 08:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44M6KYGC014451;
 Wed, 22 May 2024 01:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716358834;
 bh=24EUrj0RWUKdvDSvStaP0oCE+SDrCpuaGXI8SxHLdq8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=QpDLwdjvXlecrOWmMubFmpjSqlvtBYdPe0wJm5QFJRY+4yxZaFqhldi9+mpKheCPX
 CgedvcbdcuZG9pFMx6BQerX+EQjKJ4QrjaPvwRbTiyVo+qktl1l1EIz5JigFousZpH
 xURzRyLWXgA5A7fwgM6VZoNkaq5Nn5N1r/3sNpZM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44M6KYkv045908
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 May 2024 01:20:34 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 May 2024 01:20:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 May 2024 01:20:33 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44M6KXDW081774;
 Wed, 22 May 2024 01:20:33 -0500
Date: Wed, 22 May 2024 11:50:32 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <bb@ti.com>, <nm@ti.com>,
 <sumit.garg@linaro.org>, <michal.simek@amd.com>, <marex@denx.de>,
 <neil.armstrong@linaro.org>, <afd@ti.com>, <vigneshr@ti.com>,
 <kamlesh@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH 1/3] arm: dts: k3-j721e-r5*: Introduce k3-j721e-r5.dtsi
Message-ID: <20240522062032.vgfigufih5q7yc2j@uda0497581>
References: <20240520095916.1809962-1-n-francis@ti.com>
 <20240520095916.1809962-2-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240520095916.1809962-2-n-francis@ti.com>
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

Hi Neha,

On 15:29-20240520, Neha Malcom Francis wrote:
> Introduce k3-j721e-r5.dtsi to be used by board R5 DTS files. This
> helps sync SoC changes across boards.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  arch/arm/dts/k3-j721e-r5-beagleboneai64.dts   | 78 +-----------------
>  .../arm/dts/k3-j721e-r5-common-proc-board.dts | 75 +----------------
>  arch/arm/dts/k3-j721e-r5-sk.dts               | 75 +----------------
>  arch/arm/dts/k3-j721e-r5.dtsi                 | 80 +++++++++++++++++++
>  4 files changed, 83 insertions(+), 225 deletions(-)
>  create mode 100644 arch/arm/dts/k3-j721e-r5.dtsi
> 
> diff --git a/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts b/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
> index 43da4dafba8..4f97af4fd94 100644
> --- a/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
> +++ b/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
> @@ -12,84 +12,8 @@
>  #include "k3-j721e-ddr.dtsi"
>  
>  #include "k3-j721e-beagleboneai64-u-boot.dtsi"
> +#include "k3-j721e-r5.dtsi"
>  
> -/ {
> -	aliases {
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a72_0;
> -	};
> -
> -	chosen {
> -		tick-timer = &mcu_timer0;
> -	};
> -
> -	a72_0: a72@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x0 0x00a90000 0x0 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 202 0>;
> -		clocks = <&k3_clks 61 1>;
> -		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>;
> -		assigned-clock-rates = <2000000000>, <200000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-pre-ram;
> -	};
> -
> -	dm_tifs: dm-tifs {
> -		compatible = "ti,j721e-dm-sci";
> -		ti,host-id = <3>;
> -		ti,secure-host;
> -		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_mcu 21>,
> -				<&secure_proxy_mcu 23>;
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_mcu 6>,
> -		<&secure_proxy_mcu 8>,
> -		<&secure_proxy_mcu 5>;
> -	mbox-names = "rx", "tx", "notify";
> -	ti,host-id = <4>;
> -	ti,secure-host;
> -};
> -
> -&mcu_timer0 {
> -	status = "okay";
> -	bootph-pre-ram;
> -};
> -
> -&secure_proxy_mcu {
> -	bootph-pre-ram;
> -	/* We require this for boot handshake */
> -	status = "okay";
> -};
> -
> -&cbass_mcu_wakeup {
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-system-controller";
> -		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>;
> -		mbox-names = "tx", "rx";
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&mcu_ringacc {
> -	ti,sci = <&dm_tifs>;
> -};
> -
> -&mcu_udmap {
> -	ti,sci = <&dm_tifs>;
> -};
> -
> -&wkup_uart0_pins_default {
> -	bootph-pre-ram;
> -};
>  
>  &wkup_i2c0 {
>  	bootph-pre-ram;
> diff --git a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> index 9655ca21d02..c7e344350c8 100644
> --- a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> @@ -10,76 +10,7 @@
>  #include "k3-j721e-ddr.dtsi"
>  #include "k3-j721e-common-proc-board-u-boot.dtsi"
>  
> -/ {
> -	chosen {
> -		tick-timer = &mcu_timer0;
> -	};
> -
> -	aliases {
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a72_0;
> -	};
> -
> -	a72_0: a72@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x0 0x00a90000 0x0 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 202 0>;
> -		clocks = <&k3_clks 61 1>;
> -		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>;
> -		assigned-clock-rates = <2000000000>, <200000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-pre-ram;
> -	};
> -
> -	dm_tifs: dm-tifs {
> -		compatible = "ti,j721e-dm-sci";
> -		ti,host-id = <3>;
> -		ti,secure-host;
> -		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_mcu 21>,
> -			<&secure_proxy_mcu 23>;
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&mcu_timer0 {
> -	status = "okay";
> -	bootph-pre-ram;
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_mcu 8>, <&secure_proxy_mcu 6>, <&secure_proxy_mcu 5>;
> -	mbox-names = "tx", "rx", "notify";
> -	ti,host-id = <4>;
> -	ti,secure-host;
> -};
> -
> -&secure_proxy_mcu {
> -	bootph-pre-ram;
> -	status = "okay";
> -};
> -
> -&cbass_mcu_wakeup {
> -	sysctrler: sysctrler {
> -		bootph-pre-ram;
> -		compatible = "ti,am654-system-controller";
> -		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>;
> -		mbox-names = "tx", "rx";
> -	};
> -};
> -
> -&mcu_ringacc {
> -	ti,sci = <&dm_tifs>;
> -};
> -
> -&mcu_udmap {
> -	ti,sci = <&dm_tifs>;
> -};
> +#include "k3-j721e-r5.dtsi"
>  
>  &wkup_i2c0 {
>  	bootph-pre-ram;
> @@ -111,10 +42,6 @@
>  	};
>  };
>  
> -&wkup_uart0_pins_default {
> -	bootph-pre-ram;
> -};
> -
>  &mcu_uart0_pins_default {
>  	bootph-pre-ram;
>  };
> diff --git a/arch/arm/dts/k3-j721e-r5-sk.dts b/arch/arm/dts/k3-j721e-r5-sk.dts
> index b0c108e9693..96a13b2cb2b 100644
> --- a/arch/arm/dts/k3-j721e-r5-sk.dts
> +++ b/arch/arm/dts/k3-j721e-r5-sk.dts
> @@ -10,80 +10,7 @@
>  #include "k3-j721e-ddr.dtsi"
>  #include "k3-j721e-sk-u-boot.dtsi"
>  
> -/ {
> -	chosen {
> -		tick-timer = &mcu_timer0;
> -	};
> -
> -	aliases {
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a72_0;
> -	};
> -
> -	a72_0: a72@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x0 0x00a90000 0x0 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 202 0>;
> -		clocks = <&k3_clks 61 1>;
> -		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>;
> -		assigned-clock-rates = <2000000000>, <200000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-pre-ram;
> -	};
> -
> -	dm_tifs: dm-tifs {
> -		compatible = "ti,j721e-dm-sci";
> -		ti,host-id = <3>;
> -		ti,secure-host;
> -		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_mcu 21>,
> -				<&secure_proxy_mcu 23>;
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&mcu_timer0 {
> -	status = "okay";
> -	bootph-pre-ram;
> -};
> -
> -&secure_proxy_mcu {
> -	bootph-pre-ram;
> -	status = "okay";
> -};
> -
> -&cbass_mcu_wakeup {
> -	sysctrler: sysctrler {
> -		bootph-pre-ram;
> -		compatible = "ti,am654-system-controller";
> -		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>;
> -		mbox-names = "tx", "rx";
> -	};
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_mcu 8>, <&secure_proxy_mcu 6>, <&secure_proxy_mcu 5>;
> -	mbox-names = "tx", "rx", "notify";
> -	ti,host-id = <4>;
> -	ti,secure-host;
> -};
> -
> -&mcu_ringacc {
> -	ti,sci = <&dm_tifs>;
> -};
> -
> -&mcu_udmap {
> -	ti,sci = <&dm_tifs>;
> -};
> -
> -&wkup_uart0_pins_default {
> -	bootph-pre-ram;
> -};
> +#include "k3-j721e-r5.dtsi"
>  
>  &mcu_uart0_pins_default {
>  	bootph-pre-ram;
> diff --git a/arch/arm/dts/k3-j721e-r5.dtsi b/arch/arm/dts/k3-j721e-r5.dtsi
> new file mode 100644
> index 00000000000..fd0d921272c
> --- /dev/null
> +++ b/arch/arm/dts/k3-j721e-r5.dtsi
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/ {
> +	chosen {
> +		tick-timer = &mcu_timer0;
> +	};
> +
> +	aliases {
> +		remoteproc0 = &sysctrler;
> +		remoteproc1 = &a72_0;
> +	};
> +
> +	a72_0: a72@0 {
> +		compatible = "ti,am654-rproc";
> +		reg = <0x0 0x00a90000 0x0 0x10>;
> +		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
> +		resets = <&k3_reset 202 0>;
> +		clocks = <&k3_clks 61 1>;
> +		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>;
> +		assigned-clock-rates = <2000000000>, <200000000>;
> +		ti,sci = <&dmsc>;
> +		ti,sci-proc-id = <32>;
> +		ti,sci-host-id = <10>;
> +		bootph-pre-ram;
> +	};
> +
> +	dm_tifs: dm-tifs {
> +		compatible = "ti,j721e-dm-sci";
> +		ti,host-id = <3>;
> +		ti,secure-host;
> +		mbox-names = "rx", "tx";
> +		mboxes= <&secure_proxy_mcu 21>,
> +			<&secure_proxy_mcu 23>;
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&mcu_timer0 {
> +	status = "okay";
> +	bootph-pre-ram;
> +};
> +
> +&dmsc {
> +	mboxes= <&secure_proxy_mcu 8>, <&secure_proxy_mcu 6>, <&secure_proxy_mcu 5>;
> +	mbox-names = "tx", "rx", "notify";
> +	ti,host-id = <4>;
> +	ti,secure-host;
> +};
> +
> +&secure_proxy_mcu {
> +	bootph-pre-ram;
> +	/* We require this for boot handshake */
> +	status = "okay";
> +};
> +
> +&cbass_mcu_wakeup {
> +	sysctrler: sysctrler {
> +		bootph-pre-ram;
> +		compatible = "ti,am654-system-controller";
> +		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>;
> +		mbox-names = "tx", "rx";
> +	};
> +};
> +
> +&mcu_ringacc {
> +	ti,sci = <&dm_tifs>;
> +};
> +
> +&mcu_udmap {
> +	ti,sci = <&dm_tifs>;
> +};
> +
> +&wkup_uart0_pins_default {
> +	bootph-pre-ram;
> +};

I think I just noticed that this node is only enabled in R5 dts for
j721e, though not required for cleanup in this series as we'll be
porting these tags to kernel anyways but the node is marked with
bootph-all in -u-boot.dtsi and the pins are only marked bootph-pre-ram.
Might be good to look at some other tags as well while porting these to
kernel [0].

Rest LGTM.

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

[0]: https://lore.kernel.org/linux-arm-kernel/20240507-b4-upstream-bootph-all-v1-0-c6d52651856f@ti.com/

Regards,
Manorit

> -- 
> 2.34.1
> 
