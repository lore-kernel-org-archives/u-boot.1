Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFC3C61CE8
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 11:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7728181FEE;
	Fri,  6 Jun 2025 13:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iM9wu7OY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A279982977; Fri,  6 Jun 2025 13:57:24 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3951381F0D
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 13:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 556BvKIE164945;
 Fri, 6 Jun 2025 06:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749211040;
 bh=Jyd+f4pV3RcfB31xMzSvyhzVYKKddvq9OtvgtJVzdko=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=iM9wu7OY62AotufL3X5me2zFoUjdoNqcLmmSplAR1cy8npjPYD9HOft30n2X/hRtF
 wKa8GXct91MvxhbWIVVA62IpekXvgNcq8eGonkwcJzCc4Y/JcVePJXxmSlSGiYRak7
 TeISZtV4qhhYg0d+To/MK+xsxIg5Jnk67AUNTXIk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 556BvK9q1645817
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 6 Jun 2025 06:57:20 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Jun 2025 06:57:19 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Jun 2025 06:57:19 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 556BvJOA909857;
 Fri, 6 Jun 2025 06:57:19 -0500
Date: Fri, 6 Jun 2025 06:57:19 -0500
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>
Subject: Re: [PATCH v7 04/10] arch: arm: k3-binman: add fit for falcon boot
Message-ID: <20250606115719.eyu2vk3zdwygzmc2@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-5-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250603142452.2707171-5-anshuld@ti.com>
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

On June  3, 2025 thus sayeth Anshul Dalal:
> This adds creation of tispl_falcon.bin for the am62a, 62p and 62x.
> 
> The contents are the same as the existing tispl.bin but A53's spl and
> the fdt have been removed as they are not needed in falcon boot.
> 
> This reduces boot time since the payload size is smaller and we also
> aren't authenticating the spl and fdt in secure boot.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/dts/k3-am625-sk-binman.dtsi | 64 ++++++++++++++++++++++++++++
>  arch/arm/dts/k3-am62a-sk-binman.dtsi | 64 ++++++++++++++++++++++++++++
>  arch/arm/dts/k3-am62p-sk-binman.dtsi | 51 ++++++++++++++++++++++
>  arch/arm/dts/k3-binman.dtsi          | 54 +++++++++++++++++++++++
>  4 files changed, 233 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
> index cc619f5920e..9544b9d1134 100644
> --- a/arch/arm/dts/k3-am625-sk-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-sk-binman.dtsi

...

> +				dm {
> +					ti-secure {
> +						content = <&dm_falcon>;
> +						keyfile = "custMpk.pem";
> +					};
> +					dm_falcon: ti-dm {
> +						filename = "ti-dm.bin";
> +					};

When you build this are you using the TI_DM argument? Or are you using 
BINMAN_INDIRS to point to all the firmware? I think this will only look 
for "${BINMAN_INDIRS}/ti-dm.bin" and error out now that DM is mandatory 
unless you use TI_DM which will break a few distro builders' recipes

...

> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index 5163161b94d..a678379dae9 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -489,6 +489,60 @@
>  		end_address = <0x0 0x9fffffff>;
>  	};
>  
> +	ti_falcon_template: template-9 {
> +		filename = "tispl_falcon.bin";

Small nitpick: We could probably just call this tifalcon.bin or 
something shorter. It's not really an SPL now.

The bigger issue here (in my mind) is this requires our falcon.config 
fragment to work properly. I don't think it is wise of use to produce 
this image if that fragment isn't applied. It would be a debugging 
nightmare for others outside of the U-Boot space.

> +		pad-byte = <0xff>;
> +
> +		fit {
> +			description = "Configuration without SPL and FDT";
> +			#address-cells = <1>;
> +
> +			images {
> +				atf {
> +					description = "ARM Trusted Firmware";
> +					type = "firmware";
> +					arch = "arm64";
> +					compression = "none";
> +					os = "arm-trusted-firmware";
> +					load = <CONFIG_K3_ATF_LOAD_ADDR>;
> +					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
> +					ti-secure {
> +						content = <&atf_falcon>;
> +						keyfile = "custMpk.pem";
> +					};
> +					atf_falcon: atf-bl31 {
> +					};
> +				};
> +				tee {
> +					description = "OP-TEE";
> +					type = "tee";
> +					arch = "arm64";
> +					compression = "none";
> +					os = "tee";
> +					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
> +					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
> +					ti-secure {
> +						content = <&tee_falcon>;
> +						keyfile = "custMpk.pem";
> +					};
> +					tee_falcon: tee-os {
> +						optional;
> +					};
> +				};
> +				dm {
> +					description = "DM binary";
> +					type = "firmware";
> +					arch = "arm32";
> +					compression = "none";
> +					os = "DM";
> +					load = <0x89000000>;
> +					entry = <0x89000000>;
> +				};
> +
> +			};
> +		};
> +	};
> +
>  };
>  
>  #endif
> -- 
> 2.49.0
> 
