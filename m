Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7139EE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 11:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB6986DFF;
	Mon, 11 Sep 2023 13:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cbbMHzSP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2C1B86E14; Mon, 11 Sep 2023 13:23:33 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA8AC86D92
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 13:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BBNS4q123947;
 Mon, 11 Sep 2023 06:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694431408;
 bh=h7z4VSjQNSUNXB5nWwFTxhaVRXWsTxnuIETZg56f8rc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=cbbMHzSPk2tH5MAJxFcYQmWBl9pXmu8cmhmzF2S6MEclXEEom12xj4Pb/tMippOaq
 KunQoxGp80UWjRVAAFmGDvj5mxq6Z9hAxR2yPikmKRDW16IXUcZNrdItDkVy1Y+OY4
 A2iRrp/kbzmcyPeLdBz1Jc4dJT3oR6ib81p2kVFE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BBNSnp094640
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Sep 2023 06:23:28 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 06:23:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 06:23:28 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BBNSSx022065;
 Mon, 11 Sep 2023 06:23:28 -0500
Date: Mon, 11 Sep 2023 06:23:28 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <reidt@ti.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <sinthu.raja@ti.com>,
 <gadiyar@ti.com>, <a-nandan@ti.com>, <vaishnav.a@ti.com>
Subject: Re: [PATCH v2 7/7] arm: dts: k3-j721e: Sync with v6.5-rc1
Message-ID: <20230911112328.hvskhfdjxtlvx5di@sublime>
References: <20230907141407.382215-1-n-francis@ti.com>
 <20230907141407.382215-8-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230907141407.382215-8-n-francis@ti.com>
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

On 19:44-20230907, Neha Malcom Francis wrote:
> Sync k3-j721e DTS with kernel.org v6.5-rc1.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  .../k3-j721e-common-proc-board-u-boot.dtsi    | 146 +--
>  arch/arm/dts/k3-j721e-common-proc-board.dts   | 483 ++++++---
>  arch/arm/dts/k3-j721e-main.dtsi               | 974 ++++++++++++++++--
>  arch/arm/dts/k3-j721e-mcu-wakeup.dtsi         | 280 ++++-
>  .../arm/dts/k3-j721e-r5-common-proc-board.dts | 302 +-----
>  arch/arm/dts/k3-j721e-r5-sk.dts               | 522 +---------
>  arch/arm/dts/k3-j721e-sk-u-boot.dtsi          | 177 +---
>  arch/arm/dts/k3-j721e-sk.dts                  | 663 +++++++++---
>  arch/arm/dts/k3-j721e-som-p0.dtsi             | 226 ++--
>  arch/arm/dts/k3-j721e-thermal.dtsi            |  75 ++
>  arch/arm/dts/k3-j721e.dtsi                    |  32 +-
>  11 files changed, 2365 insertions(+), 1515 deletions(-)
>  create mode 100644 arch/arm/dts/k3-j721e-thermal.dtsi
> 
> diff --git a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
> index 540c847eb3..4cca01be61 100644
> --- a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
> @@ -7,15 +7,7 @@
>  #include "k3-j721e-binman.dtsi"
>  
>  / {
> -	chosen {
> -		stdout-path = "serial2:115200n8";
> -		tick-timer = &timer1;
> -	};
> -
>  	aliases {
> -		ethernet0 = &cpsw_port1;
> -		spi0 = &ospi0;
> -		spi1 = &ospi1;
>  		remoteproc0 = &mcu_r5fss0_core0;
>  		remoteproc1 = &mcu_r5fss0_core1;
>  		remoteproc2 = &main_r5fss0_core0;
> @@ -25,61 +17,49 @@
>  		remoteproc6 = &c66_0;
>  		remoteproc7 = &c66_1;
>  		remoteproc8 = &c71_0;
> -		i2c0 = &wkup_i2c0;
> -		i2c1 = &mcu_i2c0;
> -		i2c2 = &mcu_i2c1;
> -		i2c3 = &main_i2c0;
>  	};

As Manorit mentioned, drop the aliases

[...]

> diff --git a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> index 7bb5ce775c..0452e94b6d 100644
> --- a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> @@ -12,16 +12,15 @@
>  #include <dt-bindings/phy/phy-cadence.h>

What are you using from phy-cadence.h?

>  

This file has:
* tps659413 -> Should come in from upstream kernel please.
* flash@0 -> are intentionally changing properties here? if so document
  why - same with ospi nodes (reg)
* hbmc is still retained. Though the node is disabled in u-boot.dtsi

[...]

> diff --git a/arch/arm/dts/k3-j721e-r5-sk.dts b/arch/arm/dts/k3-j721e-r5-sk.dts
> index 1cc64d07f7..f5eb29a861 100644
> --- a/arch/arm/dts/k3-j721e-r5-sk.dts
> +++ b/arch/arm/dts/k3-j721e-r5-sk.dts
> @@ -11,151 +11,13 @@
>  #include "k3-j721e-sk-u-boot.dtsi"
>  
>  / {
> -	model = "Texas Instruments J721E SK R5";
> +	chosen {
> +		tick-timer = &mcu_timer0;
> +	};
>  
we have tps659412 defined here - should have come in from
upstream kernel.org
[...]

>  	flash@0{
	please fix that space before {
> -		compatible = "jedec,spi-nor";
> -		reg = <0x0>;
> -		spi-tx-bus-width = <8>;
> -		spi-rx-bus-width = <8>;
> -		spi-max-frequency = <25000000>;
> -		cdns,tshsl-ns = <60>;
> -		cdns,tsd2d-ns = <60>;
> -		cdns,tchsh-ns = <60>;
> -		cdns,tslch-ns = <60>;
> -		cdns,read-delay = <4>;
>  		cdns,phy-mode;

Why do we need this anymore?

>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  	};
>  };
[...]

> diff --git a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
> index 205dacff4d..e4bd71913c 100644
> --- a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
> @@ -7,14 +7,7 @@
>  #include "k3-j721e-binman.dtsi"

You dont need to include ti-dp83867.h anymore.

>  
>  / {
> -	chosen {
> -		stdout-path = "serial2:115200n8";
> -		tick-timer = &timer1;
> -	};
> -
>  	aliases {
> -		ethernet0 = &cpsw_port1;
> -		spi0 = &ospi0;
>  		remoteproc0 = &mcu_r5fss0_core0;
>  		remoteproc1 = &mcu_r5fss0_core1;
>  		remoteproc2 = &main_r5fss0_core0;
> @@ -24,61 +17,49 @@
>  		remoteproc6 = &c66_0;
>  		remoteproc7 = &c66_1;
>  		remoteproc8 = &c71_0;
> -		i2c0 = &wkup_i2c0;
> -		i2c1 = &mcu_i2c0;
> -		i2c2 = &main_i2c0;
> -		mmc1 = &main_sdhci1;  /* SD Card */

Same comment as before - drop all these aliases.

[...]

> +&mcu_ringacc {
> +	reg =	<0x0 0x2b800000 0x0 0x400000>,
> +		<0x0 0x2b000000 0x0 0x400000>,
> +		<0x0 0x28590000 0x0 0x100>,
> +		<0x0 0x2a500000 0x0 0x40000>,
> +		<0x0 0x28440000 0x0 0x40000>;
> +		reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
> +		bootph-pre-ram;
> +};
>  
> -	chipid@43000014 {
> +&mcu_udmap {
> +	reg =	<0x0 0x285c0000 0x0 0x100>,
> +		<0x0 0x284c0000 0x0 0x4000>,
> +		<0x0 0x2a800000 0x0 0x40000>,
> +		<0x0 0x284a0000 0x0 0x4000>,
> +		<0x0 0x2aa00000 0x0 0x40000>,
> +		<0x0 0x28400000 0x0 0x2000>;
> +		reg-names = "gcfg", "rchan", "rchanrt", "tchan",
> +			    "tchanrt", "rflow";
>  		bootph-pre-ram;
> -	};
>  };

NOTE: v6.6-rc1 has been tagged yesterday - so it is probably time for us
to sync with that and drop these.

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
