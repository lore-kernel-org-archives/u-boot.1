Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B80C83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 07:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8898D8334A;
	Thu, 31 Jul 2025 09:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pt5zvTHQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88346833C7; Thu, 31 Jul 2025 09:01:19 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F1938318E
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 09:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56V707AM2972087;
 Thu, 31 Jul 2025 02:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753945207;
 bh=QUeqCBw0Jbx7gkROs04ypNNEmN4FCRVWeMcANyCrWxI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=pt5zvTHQjmh+MNaRr+fstnwLVVSijV0N2ZJw2sw9OuQM7mffrpNNXNzgZEC1kTLMB
 ISi5KJ1rgaQFYQIG2fOwIqDYzgrDJAefS1aNx0KdhSiUEorI096Xx6bJjLcivp6prY
 ydRkL08qUGPJakTz5z898aTgt9k3DaeXZTn5eWks=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56V707873771005
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 31 Jul 2025 02:00:07 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 02:00:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 02:00:00 -0500
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56V6xwv82493570;
 Thu, 31 Jul 2025 01:59:59 -0500
Message-ID: <5a5bf2a5-1ef4-4ee6-b73c-1dcfe9e2c722@ti.com>
Date: Thu, 31 Jul 2025 12:29:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: k3-am62a-phycore: remove GP tiboot3 builds
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, Garrett
 Giordano <ggiordano@phytec.com>, Wadim Egorov <w.egorov@phytec.de>
CC: <u-boot@lists.denx.de>
References: <20250729-no-62a-gp-v1-0-1dbdb4469ad3@ti.com>
 <20250729-no-62a-gp-v1-2-1dbdb4469ad3@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250729-no-62a-gp-v1-2-1dbdb4469ad3@ti.com>
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

On 30/07/25 00:06, Bryan Brattlof wrote:
> The AM62Ax SoC family was the last part from TI to support the GP
> security variant, however this security variant was used mostly
> internally and with select early partners and never sold publicly.
> 
> To simplify things and to avoid any confusion on which parts are
> supported in the future, remove the GP tiboo3.bin builds from binman.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

>  arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 182 +-------------------------
>  1 file changed, 1 insertion(+), 181 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
> index 9bcdf74ffe46368ddc6a872d02f26378aba763a9..a284226320ccdf9953f2f107ee6595664e425156 100644
> --- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
> @@ -101,43 +101,6 @@
>  	};
>  };
>  
> -&binman {
> -	tiboot3-am62ax-gp-phycore-som.bin {
> -		filename = "tiboot3-am62ax-gp-phycore-som.bin";
> -		ti-secure-rom {
> -			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
> -				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
> -			combined;
> -			dm-data;
> -			content-sbl = <&u_boot_spl_unsigned>;
> -			load = <CONFIG_SPL_TEXT_BASE>;
> -			content-sysfw = <&ti_fs_gp>;
> -			load-sysfw = <0x40000>;
> -			content-sysfw-data = <&combined_tifs_cfg_gp>;
> -			load-sysfw-data = <0x67000>;
> -			content-dm-data = <&combined_dm_cfg_gp>;
> -			load-dm-data = <0x43c3a800>;
> -			sw-rev = <1>;
> -			keyfile = "ti-degenerate-key.pem";
> -		};
> -		u_boot_spl_unsigned: u-boot-spl {
> -			no-expanded;
> -		};
> -		ti_fs_gp: ti-fs-gp.bin {
> -			filename = "ti-sysfw/ti-fs-firmware-am62ax-gp.bin";
> -			type = "blob-ext";
> -		};
> -		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
> -			filename = "combined-tifs-cfg.bin";
> -			type = "blob-ext";
> -		};
> -		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
> -			filename = "combined-dm-cfg.bin";
> -			type = "blob-ext";
> -		};
> -	};
> -};
> -
>  #include "k3-binman-capsule-r5.dtsi"
>  
>  &capsule_tiboot3 {
> @@ -197,23 +160,6 @@
>  
>  	};
>  
> -	tifsstub-gp {
> -		filename = "tifsstub.bin_gp";
> -		ti-secure-rom {
> -			content = <&tifsstub_gp>;
> -			core = "secure";
> -			load = <0x60000>;
> -			sw-rev = <CONFIG_K3_X509_SWRV>;
> -			keyfile = "ti-degenerate-key.pem";
> -			tifsstub;
> -		};
> -		tifsstub_gp: tifsstub-gp.bin {
> -			filename = "ti-sysfw/ti-fs-stub-firmware-am62ax-gp.bin";
> -			type = "blob-ext";
> -			optional;
> -		};
> -	};
> -
>  	ti-spl {
>  		insert-template = <&ti_spl_template>;
>  
> @@ -245,18 +191,6 @@
>  					};
>  				};
>  
> -				tifsstub-gp {
> -					description = "TIFSSTUB";
> -					type = "firmware";
> -					arch = "arm32";
> -					compression = "none";
> -					os = "tifsstub-gp";
> -					load = <0x9ca00000>;
> -					entry = <0x9ca00000>;
> -					blob-ext {
> -						filename = "tifsstub.bin_gp";
> -					};
> -				};
>  				dm {
>  					ti-secure {
>  						content = <&dm>;
> @@ -289,7 +223,7 @@
>  					description = "k3-am62a7-phyboard-lyra-rdk";
>  					firmware = "atf";
>  					loadables = "tee", "dm", "spl",
> -					"tifsstub-hs", "tifsstub-fs", "tifsstub-gp";
> +					"tifsstub-hs", "tifsstub-fs";
>  					fdt = "fdt-0";
>  				};
>  			};
> @@ -403,120 +337,6 @@
>  	};
>  };
>  
> -&binman {
> -	ti-spl_unsigned {
> -		insert-template = <&ti_spl_unsigned_template>;
> -
> -		fit {
> -			images {
> -				tifsstub-hs {
> -					description = "tifsstub";
> -					type = "firmware";
> -					arch = "arm32";
> -					compression = "none";
> -					os = "tifsstub-hs";
> -					load = <0x9ca00000>;
> -					entry = <0x9ca00000>;
> -					blob-ext {
> -						filename = "tifsstub.bin_hs";
> -					};
> -				};
> -
> -				tifsstub-fs {
> -					description = "tifsstub";
> -					type = "firmware";
> -					arch = "arm32";
> -					compression = "none";
> -					os = "tifsstub-fs";
> -					load = <0x9ca00000>;
> -					entry = <0x9ca00000>;
> -					blob-ext {
> -						filename = "tifsstub.bin_fs";
> -					};
> -				};
> -
> -				tifsstub-gp {
> -					description = "tifsstub";
> -					type = "firmware";
> -					arch = "arm32";
> -					compression = "none";
> -					os = "tifsstub-gp";
> -					load = <0x9ca00000>;
> -					entry = <0x9ca00000>;
> -					blob-ext {
> -						filename = "tifsstub.bin_gp";
> -					};
> -				};
> -				dm {
> -					ti-dm {
> -						filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> -					};
> -				};
> -
> -				fdt-0 {
> -					description = "k3-am62a7-phyboard-lyra-rdk";
> -					type = "flat_dt";
> -					arch = "arm";
> -					compression = "none";
> -					spl_am62a7_phyboard_lyra_dtb_unsigned: blob {
> -						filename = SPL_AM62A7_PHYBOARD_LYRA_DTB;
> -					};
> -				};
> -			};
> -
> -			configurations {
> -				default = "conf-0";
> -
> -				conf-0 {
> -					description = "k3-am62a7-phyboard-lyra-rdk";
> -					firmware = "atf";
> -					loadables = "tee", "dm", "spl",
> -					"tifsstub-hs", "tifsstub-fs", "tifsstub-gp";
> -					fdt = "fdt-0";
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&binman {
> -	u-boot_unsigned {
> -		insert-template = <&u_boot_unsigned_template>;
> -
> -		fit {
> -			images {
> -				uboot {
> -					description = "U-Boot for AM62Ax board";
> -				};
> -
> -				fdt-0 {
> -					description = "k3-am62a7-phyboard-lyra-rdk";
> -					type = "flat_dt";
> -					arch = "arm";
> -					compression = "none";
> -					blob {
> -						filename = AM62A7_PHYBOARD_LYRA_DTB;
> -					};
> -					hash {
> -						algo = "crc32";
> -					};
> -				};
> -			};
> -
> -			configurations {
> -				default = "conf-0";
> -
> -				conf-0 {
> -					description = "k3-am62a7-phyboard-lyra-rdk";
> -					firmware = "uboot";
> -					loadables = "uboot";
> -					fdt = "fdt-0";
> -				};
> -			};
> -		};
> -	};
> -};
> -
>  #include "k3-binman-capsule.dtsi"
>  
>  &capsule_tispl {
> 

-- 
Thanking You
Neha Malcom Francis
