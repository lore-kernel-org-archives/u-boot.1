Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607A5C54E41
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 06:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4E1D87E3D;
	Wed, 28 Feb 2024 07:21:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YQBd0nrJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F04287E3D; Wed, 28 Feb 2024 07:21:21 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D14A87E28
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 07:21:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41S6LEQw060867;
 Wed, 28 Feb 2024 00:21:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709101274;
 bh=q1AaM1ZS3eyelvcfaxOYoz8cmJRmU4O/2Apg/oNggPA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=YQBd0nrJv+mt6/kZq+7xP6RVGfwfQkAb/hYUcbCEvjju7a7odKGi5wRqNa/nEqzcP
 jwAQysgkDDWHLa1W15fh8SAc43+IvPnyGPk+VWV6dPvz4ASDolRSvvmgOzlTE+Ol0Y
 +vZrL+EGJ+Mj/wAhE6zovS2FopYYjHVubP5RDcn0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41S6LEIM116933
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Feb 2024 00:21:14 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 00:21:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 00:21:14 -0600
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41S6LDcQ082266;
 Wed, 28 Feb 2024 00:21:14 -0600
Date: Wed, 28 Feb 2024 11:51:13 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/6] arm: mach-k3: Add config option for setting OP-TEE
 address
Message-ID: <20240228062113.bozx3di2daub4z7f@uda0497581>
References: <20240214163009.983034-1-afd@ti.com>
 <20240214163009.983034-3-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240214163009.983034-3-afd@ti.com>
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

Hi Andrew,

On 10:30-20240214, Andrew Davis wrote:
> Much like we have for ATF, OP-TEE has a standard address that we load
> it too and run it from. Add a Kconfig item for this to remove some
> hard-coding and allow this address to be more easily changed.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi     | 4 ++--
>  arch/arm/dts/k3-am65-iot2050-boot-image.dtsi     | 4 ++--
>  arch/arm/dts/k3-binman.dtsi                      | 8 ++++----
>  arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi | 4 ++--
>  arch/arm/mach-k3/Kconfig                         | 7 +++++++
>  5 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> index a723caa5805..cca0f44b7d8 100644
> --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> @@ -105,8 +105,8 @@
>  					arch = "arm64";
>  					compression = "none";
>  					os = "tee";
> -					load = <0x9e800000>;
> -					entry = <0x9e800000>;
> +					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
> +					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>  					tee-os {
>  						filename = "tee-raw.bin";
>  					};
> diff --git a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
> index 64318d09cf0..3a6db91e132 100644
> --- a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
> +++ b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
> @@ -51,8 +51,8 @@
>  					arch = "arm64";
>  					compression = "none";
>  					os = "tee";
> -					load = <0x9e800000>;
> -					entry = <0x9e800000>;
> +					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
> +					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>  					tee-os {
>  					};
>  				};
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index 758c8bf6ea1..621653e9471 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -286,8 +286,8 @@
>  					arch = "arm64";
>  					compression = "none";
>  					os = "tee";
> -					load = <0x9e800000>;
> -					entry = <0x9e800000>;
> +					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
> +					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>  					ti-secure {
>  						content = <&tee>;
>  						keyfile = "custMpk.pem";
> @@ -356,8 +356,8 @@
>  					arch = "arm64";
>  					compression = "none";
>  					os = "tee";
> -					load = <0x9e800000>;
> -					entry = <0x9e800000>;
> +					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
> +					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>  					tee-os {
>  						filename = "tee-raw.bin";
>  					};
> diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> index 017a5a722e0..ca99fa0e690 100644
> --- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> @@ -250,8 +250,8 @@
>  					arch = "arm64";
>  					compression = "none";
>  					os = "tee";
> -					load = <0x9e800000>;
> -					entry = <0x9e800000>;
> +					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
> +					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>  					tee-os {
>  						filename = "tee-raw.bin";
>  					};
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 0bd3f9fa12d..55bb874d9aa 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -129,6 +129,13 @@ config K3_ATF_LOAD_ADDR
>  	  The load address for the ATF image. This value is used to build the
>  	  FIT image header that places ATF in memory where it will run.
>  
> +config K3_OPTEE_LOAD_ADDR
> +	hex "Load address of OPTEE image"
> +	default 0x9e800000
> +	help
> +	  The load address for the OPTEE image. This value defaults to 0x9e800000
> +	  if not provided in the board defconfig file.
> +

Wondering if we should call out updating the firewall configurations as
well as a part of this so people don't end up with random failures..

Regards,
Manorit

>  config K3_DM_FW
>  	bool "Separate DM firmware image"
>  	depends on CPU_V7R && (SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_AM625 || SOC_K3_AM62A7) && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
> -- 
> 2.39.2
> 
