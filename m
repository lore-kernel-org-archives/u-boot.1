Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEF3C48260
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 04:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6493687E32;
	Fri, 16 Feb 2024 05:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lIoXYa1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8892587E30; Fri, 16 Feb 2024 05:59:49 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE4AA87E47
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 05:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41G4xhYj083905;
 Thu, 15 Feb 2024 22:59:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708059583;
 bh=kjYY/w7ZTdNz22bCpwsT2QpAgk9kRA6hevVtUScIf+E=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=lIoXYa1KZ/PqOl41NyZfjQ4RzpDcnN6wb1Kl9oZPTuHvwufnHWed5s59rOWZKLquw
 GWdi26T7qyk+ihJJ3niFrjPVyzmDQv/YP+gFggEXzTm9rBh690IDe8/kOWSzuffrs7
 /ZmHu3adQTa9i5vZR0n35lTcWOSQupGv5jUm1YHQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41G4xhm2017217
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Feb 2024 22:59:43 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 22:59:42 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 22:59:42 -0600
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41G4xewR113398;
 Thu, 15 Feb 2024 22:59:41 -0600
Message-ID: <85a90bf8-e645-4065-b83a-323279987417@ti.com>
Date: Fri, 16 Feb 2024 10:29:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] arm: mach-k3: Add config option for setting OP-TEE
 address
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20240214163009.983034-1-afd@ti.com>
 <20240214163009.983034-3-afd@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240214163009.983034-3-afd@ti.com>
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

On 14/02/24 22:00, Andrew Davis wrote:
> Much like we have for ATF, OP-TEE has a standard address that we load
> it too and run it from. Add a Kconfig item for this to remove some
> hard-coding and allow this address to be more easily changed.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>   arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi     | 4 ++--
>   arch/arm/dts/k3-am65-iot2050-boot-image.dtsi     | 4 ++--
>   arch/arm/dts/k3-binman.dtsi                      | 8 ++++----
>   arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi | 4 ++--
>   arch/arm/mach-k3/Kconfig                         | 7 +++++++
>   5 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> index a723caa5805..cca0f44b7d8 100644
> --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> @@ -105,8 +105,8 @@
>   					arch = "arm64";
>   					compression = "none";
>   					os = "tee";
> -					load = <0x9e800000>;
> -					entry = <0x9e800000>;
> +					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
> +					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>   					tee-os {
>   						filename = "tee-raw.bin";
>   					};
> diff --git a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
> index 64318d09cf0..3a6db91e132 100644
> --- a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
> +++ b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
> @@ -51,8 +51,8 @@
>   					arch = "arm64";
>   					compression = "none";
>   					os = "tee";
> -					load = <0x9e800000>;
> -					entry = <0x9e800000>;
> +					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
> +					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>   					tee-os {
>   					};
>   				};
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index 758c8bf6ea1..621653e9471 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -286,8 +286,8 @@
>   					arch = "arm64";
>   					compression = "none";
>   					os = "tee";
> -					load = <0x9e800000>;
> -					entry = <0x9e800000>;
> +					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
> +					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>   					ti-secure {
>   						content = <&tee>;
>   						keyfile = "custMpk.pem";
> @@ -356,8 +356,8 @@
>   					arch = "arm64";
>   					compression = "none";
>   					os = "tee";
> -					load = <0x9e800000>;
> -					entry = <0x9e800000>;
> +					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
> +					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>   					tee-os {
>   						filename = "tee-raw.bin";
>   					};
> diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> index 017a5a722e0..ca99fa0e690 100644
> --- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> @@ -250,8 +250,8 @@
>   					arch = "arm64";
>   					compression = "none";
>   					os = "tee";
> -					load = <0x9e800000>;
> -					entry = <0x9e800000>;
> +					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
> +					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
>   					tee-os {
>   						filename = "tee-raw.bin";
>   					};
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 0bd3f9fa12d..55bb874d9aa 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -129,6 +129,13 @@ config K3_ATF_LOAD_ADDR
>   	  The load address for the ATF image. This value is used to build the
>   	  FIT image header that places ATF in memory where it will run.
>   
> +config K3_OPTEE_LOAD_ADDR
> +	hex "Load address of OPTEE image"
> +	default 0x9e800000
> +	help
> +	  The load address for the OPTEE image. This value defaults to 0x9e800000
> +	  if not provided in the board defconfig file.
> +
>   config K3_DM_FW
>   	bool "Separate DM firmware image"
>   	depends on CPU_V7R && (SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_AM625 || SOC_K3_AM62A7) && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
