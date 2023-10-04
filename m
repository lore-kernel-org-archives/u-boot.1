Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F98E7B5FB
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 12:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBD5B87522;
	Wed,  4 Oct 2023 14:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YXc/HzUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EDCC87523; Wed,  4 Oct 2023 14:15:57 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 146B787521
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 14:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 394CFlHC034089;
 Wed, 4 Oct 2023 07:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696421747;
 bh=acIu81G0HEmq6Yd+23iwABwosnxF6/ZSHR2DeqyAH40=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=YXc/HzUGkNHpvKYquyoBEoyft6Y1VPK1IgGfIthDPhK22k2XRNP0b5i5M2R8Uv2jj
 9g+XrerD5hk6UvbBMn8PwWAv9qM/p6D7nqVLcuG3LiPp3gUQOWyIHwJ88J/6Gxr7L3
 51/rbcJNNdMzNGxkjk3sqIHFZ001he0Ue26JpFoQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 394CFl6b072409
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 4 Oct 2023 07:15:47 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Oct 2023 07:15:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Oct 2023 07:15:46 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 394CFkCu064775;
 Wed, 4 Oct 2023 07:15:46 -0500
Date: Wed, 4 Oct 2023 07:15:46 -0500
From: Nishanth Menon <nm@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: Roger Quadros <rogerq@kernel.org>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <m-chawdhry@ti.com>, <sjg@chromium.org>, <jonas@kwiboo.se>,
 <srk@ti.com>, <afd@ti.com>, <bb@ti.com>, <praneeth@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: dts: k3-am625-beagleplay: Fix boot
Message-ID: <20231004121546.uvvqcbewyt5s6kdx@extrude>
References: <20230929134646.214781-1-rogerq@kernel.org>
 <c430c549-6c6d-4d32-a51b-e2bfa597bd4a@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c430c549-6c6d-4d32-a51b-e2bfa597bd4a@siemens.com>
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

On 22:26-20231003, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Since commit [1] A53 u-boot proper is broken. This is because nodes
> marked as 'bootph-pre-ram' are not available at u-boot proper before
> relocation.
> 
> To fix this we mark all nodes as 'bootph-all'.
> 
> [1] 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> This may overshoot, but at least the board boots again. Could it be that 
> [1] broke even more boards?

Jan: https://lore.kernel.org/all/b1c62a7d-a90e-4212-8972-9b622e147975@kernel.org/

I got boot without r5-beagleplay.dts modified. and it is in line with
the changes in linux-next commit 944adefc7f88 ("arm64: dts: ti:
k3-am625-beagleplay: Add boot phase tags marking")

> 
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 70 ++++++++++----------
>  arch/arm/dts/k3-am625-r5-beagleplay.dts      | 12 ++--
>  2 files changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> index f8c04e8a300..d6c6baa5518 100644
> --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> @@ -14,143 +14,143 @@
>  	};
>   	memory@80000000 {
> -		bootph-pre-ram;
> +		bootph-all;
>  	};
>   	/* Keep the LEDs on by default to indicate life */
>  	leds {
> -		bootph-pre-ram;
> +		bootph-all;
>  		led-0 {
>  			default-state = "on";
> -			bootph-pre-ram;
> +			bootph-all;
>  		};
>   		led-1 {
>  			default-state = "on";
> -			bootph-pre-ram;
> +			bootph-all;
>  		};
>   		led-2 {
>  			default-state = "on";
> -			bootph-pre-ram;
> +			bootph-all;
>  		};
>   		led-3 {
>  			default-state = "on";
> -			bootph-pre-ram;
> +			bootph-all;
>  		};
>   		led-4 {
>  			default-state = "on";
> -			bootph-pre-ram;
> +			bootph-all;
>  		};
>  	};
>  };
>   &cbass_main {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &main_timer0 {
>  	clock-frequency = <25000000>;
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &dmss {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &secure_proxy_main {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &dmsc {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &k3_pds {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &k3_clks {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &k3_reset {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &dmsc {
> -	bootph-pre-ram;
> +	bootph-all;
>  	k3_sysreset: sysreset-controller {
>  		compatible = "ti,sci-sysreset";
> -		bootph-pre-ram;
> +		bootph-all;
>  	};
>  };
>   &wkup_conf {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &chipid {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &main_pmx0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &main_uart0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &console_pins_default {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &cbass_mcu {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &cbass_wakeup {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &mcu_pmx0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &main_i2c0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &local_i2c_pins_default {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &gpio0_pins_default {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &main_gpio0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &main_gpio1 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &sdhci0 {
>  	/* EMMC */
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &emmc_pins_default {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &sd_pins_default {
> -	bootph-pre-ram;
> +	bootph-all;
>  	/* Force to use SDCD card detect pin */
>  	pinctrl-single,pins = <
>  		AM62X_IOPAD(0x023c, PIN_INPUT, 0) /* (A21) MMC1_CMD */
> @@ -164,11 +164,11 @@
>  };
>   &tps65219 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &sdhci1 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   #ifdef CONFIG_TARGET_AM625_A53_EVM
> diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-am625-r5-beagleplay.dts
> index 9c9d0570592..ac5461a32c0 100644
> --- a/arch/arm/dts/k3-am625-r5-beagleplay.dts
> +++ b/arch/arm/dts/k3-am625-r5-beagleplay.dts
> @@ -31,7 +31,7 @@
>  		ti,sci = <&dmsc>;
>  		ti,sci-proc-id = <32>;
>  		ti,sci-host-id = <10>;
> -		bootph-pre-ram;
> +		bootph-all;
>  	};
>   	dm_tifs: dm-tifs {
> @@ -41,7 +41,7 @@
>  		mbox-names = "rx", "tx";
>  		mboxes= <&secure_proxy_main 22>,
>  			<&secure_proxy_main 23>;
> -		bootph-pre-ram;
> +		bootph-all;
>  	};
>  };
>  @@ -55,11 +55,11 @@
>  };
>   &mcu_esm {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &secure_proxy_sa3 {
> -	bootph-pre-ram;
> +	bootph-all;
>  	/* We require this for boot handshake */
>  	status = "okay";
>  };
> @@ -69,12 +69,12 @@
>  		compatible = "ti,am654-system-controller";
>  		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
>  		mbox-names = "tx", "rx", "boot_notify";
> -		bootph-pre-ram;
> +		bootph-all;
>  	};
>  };
>   &main_esm {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>   &main_pktdma {
> -- 
> 2.35.3

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
