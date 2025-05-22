Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FF9C54756
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 07:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93B3A82FC8;
	Thu, 22 May 2025 09:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YWfY1Cd5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B23198301E; Thu, 22 May 2025 09:57:48 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 591A482F67
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 09:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54M7vibS1744324;
 Thu, 22 May 2025 02:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747900664;
 bh=K8IdqXqk5SbljewlMJq/jJ3n3sLHF+hWX60gX5ateS4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=YWfY1Cd5vIZbK+2e/QF98dhJeKYYhZWHM1s/eemRZkCMrxZW3ALgSukDjPaUC3QPq
 UHultcl1IjT3nBaqUg1r4dfgztl58voz8lmPfoZNBnFvByGNof6t3O77a0zy7+EF6V
 GtKl64wfXXwAGa4GhM1GFvI81NyOPIvAdjrFgnMo=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54M7viqr3333882
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 22 May 2025 02:57:44 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 May 2025 02:57:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 May 2025 02:57:43 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54M7veCd115785;
 Thu, 22 May 2025 02:57:41 -0500
Message-ID: <caa5a9fd-956a-451b-9389-c7877d7f5371@ti.com>
Date: Thu, 22 May 2025 13:27:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm: dts: k3-j7*-binman: Enable split mode for MCU R5F
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <m-shah@ti.com>, <u-boot@lists.denx.de>
References: <20250522071828.285462-1-b-padhi@ti.com>
 <20250522071828.285462-6-b-padhi@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250522071828.285462-6-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

On 22/05/25 12:48, Beleswar Padhi wrote:
> Set boot core-opts to enable split mode for MCU R5 cluster by default.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>  arch/arm/dts/k3-j7200-binman.dtsi  | 3 +++
>  arch/arm/dts/k3-j721e-binman.dtsi  | 4 ++++
>  arch/arm/dts/k3-j721s2-binman.dtsi | 3 +++
>  arch/arm/dts/k3-j784s4-binman.dtsi | 3 +++
>  4 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
> index 47a4cde6b85..cf281bc72e0 100644
> --- a/arch/arm/dts/k3-j7200-binman.dtsi
> +++ b/arch/arm/dts/k3-j7200-binman.dtsi
> @@ -61,6 +61,7 @@
>  				<&combined_dm_cfg>, <&sysfw_inner_cert>;
>  			combined;
>  			dm-data;
> +			core-opts = <2>;
>  			sysfw-inner-cert;
>  			keyfile = "custMpk.pem";
>  			sw-rev = <1>;
> @@ -153,6 +154,7 @@
>  				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
>  			combined;
>  			dm-data;
> +			core-opts = <2>;
>  			sysfw-inner-cert;
>  			keyfile = "custMpk.pem";
>  			sw-rev = <1>;
> @@ -199,6 +201,7 @@
>  				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
>  			combined;
>  			dm-data;
> +			core-opts = <2>;
>  			content-sbl = <&u_boot_spl_unsigned>;
>  			load = <0x41c00000>;
>  			content-sysfw = <&ti_fs_gp>;
> diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
> index 6adfab164ee..54c7ad92069 100644
> --- a/arch/arm/dts/k3-j721e-binman.dtsi
> +++ b/arch/arm/dts/k3-j721e-binman.dtsi
> @@ -13,6 +13,7 @@
>  		ti-secure-rom {
>  			content = <&u_boot_spl>;
>  			core = "public";
> +			core-opts = <2>;
>  			load = <CONFIG_SPL_TEXT_BASE>;
>  			keyfile = "custMpk.pem";
>  		};
> @@ -26,6 +27,7 @@
>  		ti-secure-rom {
>  			content = <&u_boot_spl_sr2>;
>  			core = "public";
> +			core-opts = <2>;
>  			load = <CONFIG_SPL_TEXT_BASE>;
>  			keyfile = "custMpk.pem";
>  		};
> @@ -223,6 +225,7 @@
>  		ti-secure-rom {
>  			content = <&u_boot_spl_fs>;
>  			core = "public";
> +			core-opts = <2>;
>  			load = <CONFIG_SPL_TEXT_BASE>;
>  			keyfile = "custMpk.pem";
>  		};
> @@ -256,6 +259,7 @@
>  		ti-secure-rom {
>  			content = <&u_boot_spl_unsigned>;
>  			core = "public";
> +			core-opts = <2>;
>  			load = <CONFIG_SPL_TEXT_BASE>;
>  			sw-rev = <CONFIG_K3_X509_SWRV>;
>  			keyfile = "ti-degenerate-key.pem";
> diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
> index 73af184d27e..2d34b193813 100644
> --- a/arch/arm/dts/k3-j721s2-binman.dtsi
> +++ b/arch/arm/dts/k3-j721s2-binman.dtsi
> @@ -15,6 +15,7 @@
>  				<&combined_dm_cfg>, <&sysfw_inner_cert>;
>  			combined;
>  			dm-data;
> +			core-opts = <2>;
>  			sysfw-inner-cert;
>  			keyfile = "custMpk.pem";
>  			sw-rev = <1>;
> @@ -60,6 +61,7 @@
>  				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
>  			combined;
>  			dm-data;
> +			core-opts = <2>;
>  			sysfw-inner-cert;
>  			keyfile = "custMpk.pem";
>  			sw-rev = <1>;
> @@ -106,6 +108,7 @@
>  				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
>  			combined;
>  			dm-data;
> +			core-opts = <2>;
>  			content-sbl = <&u_boot_spl_unsigned>;
>  			load = <0x41c00000>;
>  			content-sysfw = <&ti_fs_gp>;
> diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
> index cb1fbc65923..14e71ab0f20 100644
> --- a/arch/arm/dts/k3-j784s4-binman.dtsi
> +++ b/arch/arm/dts/k3-j784s4-binman.dtsi
> @@ -19,6 +19,7 @@
>  				<&combined_dm_cfg>, <&sysfw_inner_cert>;
>  			combined;
>  			dm-data;
> +			core-opts = <2>;
>  			sysfw-inner-cert;
>  			keyfile = "custMpk.pem";
>  			sw-rev = <1>;
> @@ -68,6 +69,7 @@
>  				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
>  			combined;
>  			dm-data;
> +			core-opts = <2>;
>  			sysfw-inner-cert;
>  			keyfile = "custMpk.pem";
>  			sw-rev = <1>;
> @@ -117,6 +119,7 @@
>  				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
>  			combined;
>  			dm-data;
> +			core-opts = <2>;
>  			content-sbl = <&u_boot_spl_unsigned>;
>  			load = <0x41c00000>;
>  			content-sysfw = <&ti_fs_gp>;

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
