Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699DFCD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 04:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED8188280;
	Thu,  4 Apr 2024 06:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Hd5EJmuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 845048815A; Thu,  4 Apr 2024 06:50:29 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44DB788260
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 06:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4344oPxU062965;
 Wed, 3 Apr 2024 23:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712206225;
 bh=tM0NcfOL2ILwm26VyoTD8hBxU1fKT8U65XBH3lZUenc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Hd5EJmuSi5wptNi2ix4wGpkrXQSFep4iQn6YfbrNxRIKRiG6RK6CZrEV9nc7mSybn
 a4Ff7ecvkjJUKY0ZWzRbtO8tpPb+7J/vl29W/ryANWna0Bo9K2nneyoFStD6nhUHSU
 6abB6SNAgPP1IENu44OEFRN0qtnxcPYRK99sUbsQ=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4344oOGf007152
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Apr 2024 23:50:25 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 23:50:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 23:50:24 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4344oMwo053588;
 Wed, 3 Apr 2024 23:50:23 -0500
Message-ID: <967ef615-58f8-48e7-bb8e-1c9903e771db@ti.com>
Date: Thu, 4 Apr 2024 10:20:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: k3: binman: am625: add support for signing
 TIFSSTUB Images
To: Dhruva Gole <d-gole@ti.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Vibhore Vardhan <vibhore@ti.com>, Kamlesh
 Gurudasani <kamlesh@ti.com>
References: <20240403120309.4026170-1-d-gole@ti.com>
 <20240403120309.4026170-3-d-gole@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240403120309.4026170-3-d-gole@ti.com>
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

Hi Dhruva

On 03/04/24 17:33, Dhruva Gole wrote:
> From: Kamlesh Gurudasani <kamlesh@ti.com>
> 
> Add support for signing of TIFSSTUB images for HSSE, HSFS and GP devices
> and include them in tispl.bin and tispl.bin_unsigned.
> 
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>   arch/arm/dts/k3-am625-sk-binman.dtsi | 141 ++++++++++++++++++++++++++-
>   1 file changed, 139 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
> index 5b058bd03a07..dfd38d64f638 100644
> --- a/arch/arm/dts/k3-am625-sk-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
> @@ -151,11 +151,107 @@
>   			filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
>   		};
>   	};
> +
> +	tifsstub-hs {
> +		filename = "tifsstub.bin_hs";
> +		ti-secure-rom {
> +			content = <&tifsstub_hs_cert>;
> +			core = "secure";
> +			load = <0x40000>;
> +			sw-rev = <CONFIG_K3_X509_SWRV>;
> +			keyfile = "custMpk.pem";
> +			countersign;
> +			tifsstub;
> +		};
> +		tifsstub_hs_cert: tifsstub-hs-cert.bin {
> +			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
> +			type = "blob-ext";
> +			optional;
> +		};
> +		tifsstub_hs_enc: tifsstub-hs-enc.bin {
> +			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
> +			type = "blob-ext";
> +			optional;
> +		};
> +	};
> +
> +	tifsstub-fs {
> +		filename = "tifsstub.bin_fs";
> +		tifsstub_fs_cert: tifsstub-fs-cert.bin {
> +			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
> +			type = "blob-ext";
> +			optional;
> +		};
> +		tifsstub_fs_enc: tifsstub-fs-enc.bin {
> +			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
> +			type = "blob-ext";
> +			optional;
> +		};
> +
> +	};
> +
> +	tifsstub-gp {
> +		filename = "tifsstub.bin_gp";
> +		ti-secure-rom {
> +			content = <&tifsstub_gp>;
> +			core = "secure";
> +			load = <0x60000>;
> +			sw-rev = <CONFIG_K3_X509_SWRV>;
> +			keyfile = "ti-degenerate-key.pem";
> +			tifsstub;
> +		};
> +		tifsstub_gp: tifsstub-gp.bin {
> +			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-gp.bin";
> +			type = "blob-ext";
> +			optional;
> +		};
> +	};
> +
>   	ti-spl {
>   		insert-template = <&ti_spl_template>;
>   
>   		fit {
>   			images {
> +
> +				tifsstub-hs {
> +					description = "TIFSSTUB";
> +					type = "firmware";
> +					arch = "arm32";
> +					compression = "none";
> +					os = "tifsstub-hs";
> +					load = <0x9dc00000>;
> +					entry = <0x9dc00000>;
> +					blob-ext {
> +						filename = "tifsstub.bin_hs";
> +					};
> +				};
> +
> +				tifsstub-fs {
> +					description = "TIFSSTUB";
> +					type = "firmware";
> +					arch = "arm32";
> +					compression = "none";
> +					os = "tifsstub-fs";
> +					load = <0x9dc00000>;
> +					entry = <0x9dc00000>;
> +					blob-ext {
> +						filename = "tifsstub.bin_fs";
> +					};
> +				};
> +
> +				tifsstub-gp {
> +					description = "TIFSSTUB";
> +					type = "firmware";
> +					arch = "arm32";
> +					compression = "none";
> +					os = "tifsstub-gp";
> +					load = <0x9dc00000>;
> +					entry = <0x9dc00000>;
> +					blob-ext {
> +						filename = "tifsstub.bin_gp";
> +					};
> +				};
> +
>   				dm {
>   					ti-secure {
>   						content = <&dm>;
> @@ -189,7 +285,8 @@
>   				conf-0 {
>   					description = "k3-am625-sk";
>   					firmware = "atf";
> -					loadables = "tee", "dm", "spl";
> +					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
> +					"tifsstub-gp", "dm", "spl";
>   					fdt = "fdt-0";
>   				};
>   			};
> @@ -247,6 +344,45 @@
>   		fit {
>   			images {
>   
> +				tifsstub-hs {
> +					description = "tifsstub";
> +					type = "firmware";
> +					arch = "arm32";
> +					compression = "none";
> +					os = "tifsstub-hs";
> +					load = <0x9dc00000>;
> +					entry = <0x9dc00000>;
> +					blob-ext {
> +						filename = "tifsstub.bin_hs";
> +					};
> +				};
> +
> +				tifsstub-fs {
> +					description = "tifsstub";
> +					type = "firmware";
> +					arch = "arm32";
> +					compression = "none";
> +					os = "tifsstub-fs";
> +					load = <0x9dc00000>;
> +					entry = <0x9dc00000>;
> +					blob-ext {
> +						filename = "tifsstub.bin_fs";
> +					};
> +				};
> +
> +				tifsstub-gp {
> +					description = "tifsstub";
> +					type = "firmware";
> +					arch = "arm32";
> +					compression = "none";
> +					os = "tifsstub-gp";
> +					load = <0x9dc00000>;
> +					entry = <0x9dc00000>;
> +					blob-ext {
> +						filename = "tifsstub.bin_gp";
> +					};
> +				};
> +
>   				dm {
>   					ti-dm {
>   						filename = "ti-dm.bin";
> @@ -270,7 +406,8 @@
>   				conf-0 {
>   					description = "k3-am625-sk";
>   					firmware = "atf";
> -					loadables = "tee", "dm", "spl";
> +					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
> +						  "tifsstub-gp", "dm", "spl";
>   					fdt = "fdt-0";
>   				};
>   			};


If there are multiple boards that will support TIFSSTUB in future, I would 
prefer templating these out and putting them in k3-binman.dtsi. However 
considering there's a lot of movement currently (cleanup and OF_STREAM) in that 
file, you can maybe take this up when adding support for the next board.

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
