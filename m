Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253F5C87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 07:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F4F98334A;
	Thu, 31 Jul 2025 09:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ApikzPrG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71E7C8334D; Thu, 31 Jul 2025 09:00:50 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4D088313B
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 08:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56V6xdKR3385633;
 Thu, 31 Jul 2025 01:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753945179;
 bh=+6nHuAW2KQn9AteDosp2xoeutfHvVbzJ9S7sU7ftQ4Y=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ApikzPrG7mnbBlDhEUJhWy0HE65TE77UxGtK3aujZcFcO+gT3yJyEHUNUJvgAK7/s
 2WvdSR+HpwCYSKUM1JnOxMMKU8RKXywFJI0aj6fBvOMHsxHxfFwuSmaGN+VMs/Q4pn
 IKy8gxXrI7tvN0/1EwP1OVeSWsQ/48hF8EoLgHg0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56V6xdki3131078
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 31 Jul 2025 01:59:39 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 01:59:39 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 01:59:39 -0500
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56V6xbv12191059;
 Thu, 31 Jul 2025 01:59:37 -0500
Message-ID: <a5fe7848-9109-42aa-a54d-dc51c5feb4fa@ti.com>
Date: Thu, 31 Jul 2025 12:29:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm: dts: k3-am62a-sk: remove GP tiboot3 builds
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, Garrett
 Giordano <ggiordano@phytec.com>, Wadim Egorov <w.egorov@phytec.de>
CC: <u-boot@lists.denx.de>
References: <20250729-no-62a-gp-v1-0-1dbdb4469ad3@ti.com>
 <20250729-no-62a-gp-v1-1-1dbdb4469ad3@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250729-no-62a-gp-v1-1-1dbdb4469ad3@ti.com>
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

Hi Bryan

On 30/07/25 00:06, Bryan Brattlof wrote:
> The AM62Ax SoC family was the last part from TI to support the GP
> security variant, however this security variant was used mostly
> internally and with select early partners and never sold publicly.
> 
> To simplify things and to avoid any confusion of which parts are
> supported in the future, remove the GP tiboot3.bin builds from binman.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---

As per the discussion, in the hope that no more of these are "in the wild":

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

Is there a Yocto patch that goes along with this?

>  arch/arm/dts/k3-am62a-sk-binman.dtsi | 181 +----------------------------------
>  doc/board/ti/am62ax_sk.rst           |   7 +-
>  2 files changed, 2 insertions(+), 186 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
> index 0685bdd7e0c78087777e12cfa3d936c63f2fa597..e64c165ecbf1cd82586b850549776ad189b104dc 100644
> --- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
> +++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
> @@ -98,43 +98,6 @@
>  	};
>  };
>  
> -&binman {
> -	tiboot3-am62ax-gp-evm.bin {
> -		filename = "tiboot3-am62ax-gp-evm.bin";
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
>  #endif
>  
>  #ifdef CONFIG_TARGET_AM62A7_A53_EVM
> @@ -181,23 +144,6 @@
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
> @@ -229,18 +175,6 @@
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
> @@ -275,7 +209,7 @@
>  					description = "k3-am62a7-sk";
>  					firmware = "atf";
>  					loadables = "tee", "dm", "spl",
> -					"tifsstub-hs", "tifsstub-fs", "tifsstub-gp";
> +					"tifsstub-hs", "tifsstub-fs";
>  					fdt = "fdt-0";
>  				};
>  			};
> @@ -326,117 +260,4 @@
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
> -					description = "k3-am62a7-sk";
> -					type = "flat_dt";
> -					arch = "arm";
> -					compression = "none";
> -					blob {
> -						filename = SPL_AM62A7_SK_DTB;
> -					};
> -				};
> -			};
> -
> -			configurations {
> -				default = "conf-0";
> -
> -				conf-0 {
> -					description = "k3-am62a7-sk";
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
> -					description = "U-Boot for AM62Ax Board";
> -				};
> -
> -				fdt-0 {
> -					description = "k3-am62a7-sk";
> -					type = "flat_dt";
> -					arch = "arm";
> -					compression = "none";
> -					blob {
> -						filename = AM62A7_SK_DTB;
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
> -					description = "k3-am62a7-sk";
> -					firmware = "uboot";
> -					loadables = "uboot";
> -					fdt = "fdt-0";
> -				};
> -			};
> -		};
> -	};
> -};
>  #endif
> diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
> index 43a1db688738d5c08dacdb698f4ac78d919c23ed..4dd998bcce95068f5d1b260a088fdeb8c3422f41 100644
> --- a/doc/board/ti/am62ax_sk.rst
> +++ b/doc/board/ti/am62ax_sk.rst
> @@ -121,12 +121,7 @@ Set the variables corresponding to this platform:
>  Target Images
>  --------------
>  In order to boot we need tiboot3.bin, tispl.bin and u-boot.img.  Each SoC
> -variant (GP, HS-FS, HS-SE) requires a different source for these files.
> -
> - - GP
> -
> -        * tiboot3-am62ax-gp-evm.bin from step 3.1
> -        * tispl.bin_unsigned, u-boot.img_unsigned from step 3.2
> +variant (HS-FS, HS-SE) requires a different source for these files.
>  
>   - HS-FS
>  
> 

-- 
Thanking You
Neha Malcom Francis
