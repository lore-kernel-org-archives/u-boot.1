Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3289CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 19:45:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4301881A6;
	Wed, 10 Apr 2024 21:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PDXMCvrP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C101C88120; Wed, 10 Apr 2024 21:37:45 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AB5187572
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 21:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43AJbdd7089600;
 Wed, 10 Apr 2024 14:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712777859;
 bh=InGd2FrPPeLPzrMv/FYfuKOMOoJ78m4IlhDLHgE9wcg=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=PDXMCvrPVPc3SNZ0ScBOD5kNMuuGx+y19OioDc7V839dRbcdcqOtdlKdi8pyG+kqr
 K6JnlXMb+9Wi0L1KtCjt1f7JkXY5zgfNxbSpihtuVvtHORGnXv6sm176xDZFy8KSp1
 OQVJlhJRhQE/1XG0kJea9Elj1wQ2ow7T20SzUmgM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43AJbdZo040547
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Apr 2024 14:37:39 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 14:37:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 14:37:39 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43AJbdhU063921;
 Wed, 10 Apr 2024 14:37:39 -0500
From: Jon Humphreys <j-humphreys@ti.com>
To: Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, "Simon Glass"
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH 2/2] arm: dts: k3: Remove unneeded ti, sci-sysreset
 binding and nodes
In-Reply-To: <20240402160908.508974-3-afd@ti.com>
References: <20240402160908.508974-1-afd@ti.com>
 <20240402160908.508974-3-afd@ti.com>
Date: Wed, 10 Apr 2024 14:37:39 -0500
Message-ID: <86h6g9ypoc.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 10 Apr 2024 21:45:19 +0200
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

Andrew Davis <afd@ti.com> writes:

> This extra binding is non-standard and now unneeded as we bind the
> sysreset driver automatically. This matches what is done in Linux
> and allows us to more closely match the DTBs. Remove the binding
> and all users.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  |  7 -----
>  .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    |  7 -----
>  .../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi  |  7 -----
>  arch/arm/dts/k3-am62a7-sk-u-boot.dtsi         |  4 ---
>  arch/arm/dts/k3-am62p5-sk-u-boot.dtsi         |  5 ----
>  arch/arm/dts/k3-am642-evm-u-boot.dtsi         |  7 -----
>  .../k3-am642-phyboard-electra-rdk-u-boot.dtsi |  4 ---
>  arch/arm/dts/k3-am642-sk-u-boot.dtsi          |  7 -----
>  .../dts/k3-am65-iot2050-common-u-boot.dtsi    |  4 ---
>  .../arm/dts/k3-am68-sk-base-board-u-boot.dtsi |  4 ---
>  arch/arm/dts/k3-am69-sk-u-boot.dtsi           |  7 -----
>  .../k3-j7200-common-proc-board-u-boot.dtsi    |  4 ---
>  .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   |  4 ---
>  .../k3-j721e-common-proc-board-u-boot.dtsi    |  4 ---
>  arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |  4 ---
>  .../k3-j721s2-common-proc-board-u-boot.dtsi   |  4 ---
>  arch/arm/dts/k3-j784s4-evm-u-boot.dtsi        |  7 -----
>  .../sysreset/ti,sci-sysreset.txt              | 29 -------------------
>  18 files changed, 119 deletions(-)
>  delete mode 100644 doc/device-tree-bindings/sysreset/ti,sci-sysreset.txt
>
> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> index cca0f44b7d8..fb2032068d1 100644
> --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> @@ -41,13 +41,6 @@
>  	clock-frequency = <25000000>;
>  };
>  
> -&dmsc {
> -	k3_sysreset: sysreset-controller {
> -		compatible = "ti,sci-sysreset";
> -		bootph-all;
> -	};
> -};
> -
>  &sd_pins_default {
>  	/* Force to use SDCD card detect pin */
>  	pinctrl-single,pins = <
> diff --git a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
> index f6138f3058f..94162282068 100644
> --- a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
> @@ -42,13 +42,6 @@
>  	bootph-all;
>  };
>  
> -&dmsc {
> -	k3_sysreset: sysreset-controller {
> -		compatible = "ti,sci-sysreset";
> -		bootph-all;
> -	};
> -};
> -
>  &fss {
>  	bootph-all;
>  };
> diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
> index 28b697b67ae..7fe7ae41543 100644
> --- a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
> @@ -85,13 +85,6 @@
>  	bootph-all;
>  };
>  
> -&dmsc {
> -	k3_sysreset: sysreset-controller {
> -		compatible = "ti,sci-sysreset";
> -		bootph-all;
> -	};
> -};
> -
>  &fss {
>  	bootph-all;
>  };
> diff --git a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
> index 31b89b41748..c42dec16194 100644
> --- a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
> @@ -119,10 +119,6 @@
>  
>  &dmsc {
>  	bootph-all;
> -	k3_sysreset: sysreset-controller {
> -		compatible = "ti,sci-sysreset";
> -		bootph-all;
> -	};
>  };
>  
>  &vdd_mmc1 {
> diff --git a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> index c166d655390..cf087c6e343 100644
> --- a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> @@ -15,9 +15,4 @@
>  
>  &dmsc {
>  	bootph-pre-ram;
> -
> -	k3_sysreset: sysreset-controller {
> -		compatible = "ti,sci-sysreset";
> -		bootph-pre-ram;
> -	};
>  };
> diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> index ee6656774d6..705b3baa81c 100644
> --- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> @@ -23,13 +23,6 @@
>  	bootph-all;
>  };
>  
> -&dmsc {
> -	k3_sysreset: sysreset-controller {
> -		compatible = "ti,sci-sysreset";
> -		bootph-all;
> -	};
> -};
> -
>  &sdhci0 {
>  	bootph-all;
>  };
> diff --git a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
> index 5dfc40a843b..4677c35e2d9 100644
> --- a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
> @@ -29,10 +29,6 @@
>  
>  &dmsc {
>  	bootph-all;
> -	k3_sysreset: sysreset-controller {
> -		compatible = "ti,sci-sysreset";
> -		bootph-all;
> -	};
>  };
>  
>  &dmss {
> diff --git a/arch/arm/dts/k3-am642-sk-u-boot.dtsi b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
> index 7e6b2981346..6fcb11bd04d 100644
> --- a/arch/arm/dts/k3-am642-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
> @@ -15,13 +15,6 @@
>  	clock-frequency = <200000000>;
>  };
>  
> -&dmsc {
> -	k3_sysreset: sysreset-controller {
> -		compatible = "ti,sci-sysreset";
> -		bootph-all;
> -	};
> -};
> -
>  &sdhci0 {
>  	status = "disabled";
>  };
> diff --git a/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi b/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
> index d53f133cd63..b6d2c816acc 100644
> --- a/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
> @@ -99,10 +99,6 @@
>  
>  &dmsc {
>  	bootph-all;
> -	k3_sysreset: sysreset-controller {
> -		compatible = "ti,sci-sysreset";
> -		bootph-all;
> -	};
>  };
>  
>  &k3_pds {
> diff --git a/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi b/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
> index 4f34347586e..b8fc62f0dd1 100644
> --- a/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
> @@ -51,10 +51,6 @@
>  
>  &sms {
>  	bootph-all;
> -	k3_sysreset: sysreset-controller {
> -		compatible = "ti,sci-sysreset";
> -		bootph-all;
> -	};
>  };
>  
>  &main_pmx0 {
> diff --git a/arch/arm/dts/k3-am69-sk-u-boot.dtsi b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> index bed330e6d4e..4a82d2fd222 100644
> --- a/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> @@ -23,13 +23,6 @@
>  	bootph-pre-ram;
>  };
>  
> -&sms {
> -	k3_sysreset: sysreset-controller {
> -		compatible = "ti,sci-sysreset";
> -		bootph-pre-ram;
> -	};
> -};
> -
>  #ifdef CONFIG_TARGET_J784S4_A72_EVM
>  
>  #define SPL_AM69_SK_DTB "spl/dts/ti/k3-am69-sk.dtb"
> diff --git a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
> index c9fee0ea99b..485f17c5f06 100644
> --- a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
> @@ -57,10 +57,6 @@
>  
>  &dmsc {
>  	bootph-all;
> -	k3_sysreset: sysreset-controller {
> -		compatible = "ti,sci-sysreset";
> -		bootph-all;
> -	};
>  };
>  
>  &k3_pds {
> diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> index 116ee373118..e202ae16644 100644
> --- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> @@ -92,10 +92,6 @@
>  
>  &dmsc {
>  	bootph-all;
> -	k3_sysreset: sysreset-controller {
> -		compatible = "ti,sci-sysreset";
> -		bootph-all;
> -	};
>  };
>  
>  &k3_pds {
> diff --git a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
> index 9433f3bafae..aa919b40702 100644
> --- a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
> @@ -47,10 +47,6 @@
>  
>  &dmsc {
>  	bootph-all;
> -	k3_sysreset: sysreset-controller {
> -		compatible = "ti,sci-sysreset";
> -		bootph-all;
> -	};
>  };
>  
>  &k3_pds {
> diff --git a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
> index 8b205553cdf..8f4f944263e 100644
> --- a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
> @@ -47,10 +47,6 @@
>  
>  &dmsc {
>  	bootph-all;
> -	k3_sysreset: sysreset-controller {
> -		compatible = "ti,sci-sysreset";
> -		bootph-all;
> -	};
>  };
>  
>  &k3_pds {
> diff --git a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
> index a3ebf5996ea..19b2d48c7f8 100644
> --- a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
> @@ -51,10 +51,6 @@
>  
>  &sms {
>  	bootph-all;
> -	k3_sysreset: sysreset-controller {
> -		compatible = "ti,sci-sysreset";
> -		bootph-all;
> -	};
>  };
>  
>  &main_pmx0 {
> diff --git a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
> index ac749782bfc..8f0307321e8 100644
> --- a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
> @@ -22,10 +22,3 @@
>  		    "tchanrt", "rflow";
>  	bootph-pre-ram;
>  };
> -
> -&sms {
> -	k3_sysreset: sysreset-controller {
> -		compatible = "ti,sci-sysreset";
> -		bootph-pre-ram;
> -	};
> -};
> diff --git a/doc/device-tree-bindings/sysreset/ti,sci-sysreset.txt b/doc/device-tree-bindings/sysreset/ti,sci-sysreset.txt
> deleted file mode 100644
> index 02704c6487e..00000000000
> --- a/doc/device-tree-bindings/sysreset/ti,sci-sysreset.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -Texas Instruments TI SCI System Reset Controller
> -================================================
> -
> -Some TI SoCs contain a system controller (like the SYSFW, etc...) that is
> -responsible for controlling the state of the IPs that are present.
> -Communication between the host processor running an OS and the system
> -controller happens through a protocol known as TI SCI [1].
> -
> -[1] http://processors.wiki.ti.com/index.php/TISCI
> -
> -System Reset Controller Node
> -============================
> -The sysreset controller node represents the reset for the overall SoC
> -which is managed by the SYSFW. Because this relies on the TI SCI protocol
> -to communicate with the SYSFW it must be a child of the sysfw node.
> -
> -Required Properties:
> ---------------------
> - - compatible: Must be "ti,sci-sysreset"
> -
> -Example (AM65x):
> -----------------
> -	sysfw: sysfw {
> -		compatible = "ti,am654-system-controller";
> -		...
> -		k3_sysreset: sysreset-controller {
> -			compatible = "ti,sci-sysreset";
> -		};
> -	};
> -- 
> 2.39.2

Tested-by: Jonathan Humphreys <j-humphreys@ti.com>
