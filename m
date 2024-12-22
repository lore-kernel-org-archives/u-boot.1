Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0537E77188
	for <u-boot@archiver.kernel.org>; Sun, 22 Dec 2024 13:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA5E08056B;
	Sun, 22 Dec 2024 14:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="t4BY6I1+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43569805FE; Sun, 22 Dec 2024 14:56:12 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71C9B8056A
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 14:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BMDtu6L718548
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 22 Dec 2024 07:55:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734875756;
 bh=gFazQOh+9NbUGGwQX/FTN6azXejpm/7jOT1+Va95xwE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=t4BY6I1+ovbhj+r/SzFlBfFbPj9w5fUzEvYHlrPNlOf7uTCfvOplJjWPad0b43lZH
 sCm1imP1f82lQcbJuSgybuvBpcDz8rLjIjmgnVFD1/T/OHCb1CQDmBjBGzDavOgu8e
 ugQdWwHvvyCSB5w62mk8qzpXYF/s8qmX1tXZixxQ=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BMDtuE4130729
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 22 Dec 2024 07:55:56 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 22
 Dec 2024 07:55:55 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 22 Dec 2024 07:55:55 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BMDtpes107866;
 Sun, 22 Dec 2024 07:55:52 -0600
Message-ID: <0285f45f-0ab1-43ea-8ae0-70e0a8e5a201@ti.com>
Date: Sun, 22 Dec 2024 19:25:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/8] arm: dts: k3-j784s4-binman.dtsi: Clean up and
 templatize boot binaries
To: Manorit Chawdhry <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20241217-b4-upstream-j742s2-v1-0-13a6a127b344@ti.com>
 <20241217-b4-upstream-j742s2-v1-2-13a6a127b344@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241217-b4-upstream-j742s2-v1-2-13a6a127b344@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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


On 12/17/2024 4:37 PM, Manorit Chawdhry wrote:
> From: Neha Malcom Francis <n-francis@ti.com>
>
> Clean up templatized boot binaries for j784s4 soc. This includes
> modifying the k3-j784s4-binman.dtsi to use SPL_BOARD_DTB,
> BOARD_DESCRIPTION and UBOOT_BOARD_DESCRIPTION from the files that
> include it to further reuse code.
>
> k3-j784s4-binman.dtsi will contain only templates. Only required boot
> binaries can be built from the templates in the boards' respective
> -u-boot.dtsi file (or k3-<board>-binman.dtsi if it exists). This allows
> clear distinction between the SoC common stuff vs. what is additionally
> needed to boot up a specific board.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> [ Do it only for j784s4 ]
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   arch/arm/dts/k3-am69-sk-u-boot.dtsi    | 120 +++++++++++++++++++++++++++------
>   arch/arm/dts/k3-j784s4-binman.dtsi     | 116 +++++++++----------------------
>   arch/arm/dts/k3-j784s4-evm-u-boot.dtsi |  74 ++++++++++++++++++++
>   3 files changed, 203 insertions(+), 107 deletions(-)
>
> diff --git a/arch/arm/dts/k3-am69-sk-u-boot.dtsi b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> index 4a82d2fd222669c4b390d4d877bc15329eab8894..b37fa3ceb0e0a6296294aaaaaa561a67e8506064 100644
> --- a/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> @@ -3,8 +3,106 @@
>    * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/

Copyright, please include 2024


>    */
>   
> +#define SPL_BOARD_DTB "spl/dts/ti/k3-am69-sk.dtb"
> +#define BOARD_DESCRIPTION "k3-am69-sk"
> +#define UBOOT_BOARD_DESCRIPTION "U-Boot for AM69 board"
> +
>   #include "k3-j784s4-binman.dtsi"
>   
> +#if !defined(CONFIG_ARM64)
Cosmetic, I suggest to use #if defined
> +&binman {
> +	tiboot3-am69-hs {
> +		insert-template = <&tiboot3_j784s4_hs>;
> +		filename = "tiboot3-am69-hs-sk.bin";
> +	};
> +
> +	tiboot3-am69-hs-fs {
> +		insert-template = <&tiboot3_j784s4_hs_fs>;
> +		filename = "tiboot3-am69-hs-fs-sk.bin";
> +		symlink = "tiboot3.bin";
> +	};
> +};
> +
> +&ti_fs_enc {
> +	filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-enc.bin";
> +};
> +
> +&sysfw_inner_cert {
> +	filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-cert.bin";
> +};
> +
> +&ti_fs_enc_fs {
> +	filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-fs-enc.bin";
> +};
> +
> +&sysfw_inner_cert_fs {
> +	filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-fs-cert.bin";
> +};
> +
> +#include "k3-binman-capsule-r5.dtsi"
> +
> +// Capsule update GUIDs in string form.  See j784s4_evm.h
> +#define AM69_SK_TIBOOT3_IMAGE_GUID_STR "adf49ec5-61bb-4dbe-8b8d-39df4d7ebf46"
> +
> +&capsule_tiboot3 {
> +	efi-capsule {
> +		image-guid = AM69_SK_TIBOOT3_IMAGE_GUID_STR;
> +
> +		blob {
> +			filename = "tiboot3-am69-hs-fs-sk.bin";
> +		};

I am wondering, how you plan to take care of capsule for hs devices.


> +	};
> +};
> +
> +#else // CONFIG_ARM64
> +
> +&binman {
> +	ti-dm {
> +		filename = "ti-dm.bin";
> +
> +		blob-ext {
> +			filename = "ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> +			optional;

is dm block optional ?


> +		};
> +	};
> +
> +	tispl {
> +		insert-template = <&ti_spl>;
> +	};
> +
> +	u-boot {
> +		insert-template = <&u_boot>;
> +	};
> +
> +	tispl-unsigned {
> +		insert-template = <&ti_spl_unsigned>;
> +	};
> +
> +	u-boot-unsigned {
> +		insert-template = <&u_boot_unsigned>;
> +	};

Do we need unsigned tispl and u-boot here ?


> +};
> +
> +#include "k3-binman-capsule.dtsi"
> +
> +// Capsule update GUIDs in string form.  See j784s4_evm.h
> +#define AM69_SK_SPL_IMAGE_GUID_STR "787f0059-63a1-461c-a18e-9d838345fe8e"
> +#define AM69_SK_UBOOT_IMAGE_GUID_STR "9300505d-6ec5-4ff8-99e4-5459a04be617"
> +
> +&capsule_tispl {
> +	efi-capsule {
> +		image-guid = AM69_SK_SPL_IMAGE_GUID_STR;
> +	};
> +};
> +
> +&capsule_uboot {
> +	efi-capsule {
> +		image-guid = AM69_SK_UBOOT_IMAGE_GUID_STR;
> +	};
> +};
> +
> +#endif
> +
>   / {
>   	memory@80000000 {
>   		bootph-all;
> @@ -23,25 +121,3 @@
>   	bootph-pre-ram;
>   };
>   
> -#ifdef CONFIG_TARGET_J784S4_A72_EVM
> -
> -#define SPL_AM69_SK_DTB "spl/dts/ti/k3-am69-sk.dtb"
> -#define AM69_SK_DTB "u-boot.dtb"
> -
> -&spl_j784s4_evm_dtb {
> -	filename = SPL_AM69_SK_DTB;
> -};
> -
> -&j784s4_evm_dtb {
> -	filename = AM69_SK_DTB;
> -};
> -
> -&spl_j784s4_evm_dtb_unsigned {
> -	filename = SPL_AM69_SK_DTB;
> -};
> -
> -&j784s4_evm_dtb_unsigned {
> -	filename = AM69_SK_DTB;
> -};
> -
> -#endif
> diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
> index 85bdd1f5b6cf8f2856fe3af178980a2f19d51c92..ed1e061a8ed0266420f93cbc0494e4d7a49c4e35 100644
> --- a/arch/arm/dts/k3-j784s4-binman.dtsi
> +++ b/arch/arm/dts/k3-j784s4-binman.dtsi
> @@ -5,16 +5,15 @@
>   
>   #include "k3-binman.dtsi"
>   
> -#ifdef CONFIG_TARGET_J784S4_R5_EVM
> +#if !defined(CONFIG_ARM64)
>   
>   &rcfg_yaml_tifs {
>   	config = "tifs-rm-cfg.yaml";
>   };
>   
>   &binman {
> -	tiboot3-j784s4-hs-evm.bin {
> -		filename = "tiboot3-j784s4-hs-evm.bin";
> -
> +	tiboot3_j784s4_hs: template-9 {
> +		section {
>   		ti-secure-rom {
>   			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
>   				<&combined_dm_cfg>, <&sysfw_inner_cert>;
> @@ -39,7 +38,6 @@
>   		};
>   
>   		ti_fs_enc: ti-fs-enc.bin {
> -			filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-enc.bin";
>   			type = "blob-ext";
>   			optional;
>   		};
> @@ -50,7 +48,6 @@
>   		};
>   
>   		sysfw_inner_cert: sysfw-inner-cert {
> -			filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-cert.bin";
>   			type = "blob-ext";
>   			optional;
>   		};
> @@ -59,13 +56,13 @@
>   			filename = "combined-dm-cfg.bin";
>   			type = "blob-ext";
>   		};
> +		};
>   	};
>   };
>   
>   &binman {
> -	tiboot3-j784s4-hs-fs-evm.bin {
> -		filename = "tiboot3-j784s4-hs-fs-evm.bin";
> -
> +	tiboot3_j784s4_hs_fs: template-10 {
> +		section {
>   		ti-secure-rom {
>   			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
>   				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
> @@ -90,7 +87,6 @@
>   		};
>   
>   		ti_fs_enc_fs: ti-fs-enc.bin {
> -			filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-fs-enc.bin";
>   			type = "blob-ext";
>   			optional;
>   		};
> @@ -101,7 +97,6 @@
>   		};
>   
>   		sysfw_inner_cert_fs: sysfw-inner-cert {
> -			filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-fs-cert.bin";
>   			type = "blob-ext";
>   			optional;
>   		};
> @@ -110,14 +105,13 @@
>   			filename = "combined-dm-cfg.bin";
>   			type = "blob-ext";
>   		};
> +		};
>   	};
>   };
>   
>   &binman {
> -	tiboot3-j784s4-gp-evm.bin {
> -		filename = "tiboot3-j784s4-gp-evm.bin";
> -		symlink = "tiboot3.bin";
> -
> +	tiboot3_j784s4_gp: template-11 {
> +		section {
>   		ti-secure-rom {
>   			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
>   				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
> @@ -140,7 +134,6 @@
>   		};
>   
>   		ti_fs_gp: ti-fs-gp.bin {
> -			filename = "ti-sysfw/ti-fs-firmware-j784s4-gp.bin";
>   			type = "blob-ext";
>   			optional;
>   		};
> @@ -154,43 +147,14 @@
>   			filename = "combined-dm-cfg.bin";
>   			type = "blob-ext";
>   		};
> -
> -	};
> -};
> -
> -#include "k3-binman-capsule-r5.dtsi"
> -
> -// Capsule update GUIDs in string form.  See j784s4_evm.h
> -#define AM69_SK_TIBOOT3_IMAGE_GUID_STR "adf49ec5-61bb-4dbe-8b8d-39df4d7ebf46"
> -
> -&capsule_tiboot3 {
> -	efi-capsule {
> -		image-guid = AM69_SK_TIBOOT3_IMAGE_GUID_STR;
> -
> -		blob {
> -			filename = "tiboot3-j784s4-hs-fs-evm.bin";
>   		};
>   	};
>   };
>   
> -#endif
> -
> -#ifdef CONFIG_TARGET_J784S4_A72_EVM
> -
> -#define SPL_J784S4_EVM_DTB "spl/dts/ti/k3-j784s4-evm.dtb"
> -#define J784S4_EVM_DTB "u-boot.dtb"
> +#else
>   
>   &binman {
> -	ti-dm {
> -		filename = "ti-dm.bin";
> -
> -		blob-ext {
> -			filename = "ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> -			optional;
> -		};
> -	};
> -
> -	ti-spl {
> +	ti_spl: template-12 {
>   		insert-template = <&ti_spl_template>;
>   
>   		fit {
> @@ -207,19 +171,20 @@
>   				};
>   
>   				fdt-0 {
> -					description = "k3-j784s4-evm";
> +					description = BOARD_DESCRIPTION;
>   					type = "flat_dt";
>   					arch = "arm";
>   					compression = "none";
>   
>   					ti-secure {
> -						content = <&spl_j784s4_evm_dtb>;
> +						content = <&spl_board_dtb>;
>   						keyfile = "custMpk.pem";
>   					};
>   
> -					spl_j784s4_evm_dtb: blob-ext {
> -						filename = SPL_J784S4_EVM_DTB;
> +					spl_board_dtb: blob-ext {
> +						filename = SPL_BOARD_DTB;
>   					};
> +
>   				};
>   			};
>   
> @@ -227,7 +192,7 @@
>   				default = "conf-0";
>   
>   				conf-0 {
> -					description = "k3-j784s4-evm";
> +					description = BOARD_DESCRIPTION;
>   					firmware = "atf";
>   					loadables = "tee", "dm", "spl";
>   					fdt = "fdt-0";
> @@ -238,17 +203,17 @@
>   };
>   
>   &binman {
> -	u-boot {
> +	u_boot: template-13 {
>   		insert-template = <&u_boot_template>;
>   
>   		fit {
>   			images {
>   				uboot {
> -					description = "U-Boot for J784S4 board";
> +					description = UBOOT_BOARD_DESCRIPTION;
>   				};
>   
>   				fdt-0 {
> -					description = "k3-j784s4-evm";
> +					description = BOARD_DESCRIPTION;
>   					type = "flat_dt";
>   					arch = "arm";
>   					compression = "none";
> @@ -259,7 +224,7 @@
>   					};
>   
>   					j784s4_evm_dtb: blob-ext {
> -						filename = J784S4_EVM_DTB;
> +						filename = "u-boot.dtb";
>   					};
>   
>   					hash {
> @@ -272,7 +237,7 @@
>   				default = "conf-0";
>   
>   				conf-0 {
> -					description = "k3-j784s4-evm";
> +					description = BOARD_DESCRIPTION;
>   					firmware = "uboot";
>   					loadables = "uboot";
>   					fdt = "fdt-0";
> @@ -283,7 +248,7 @@
>   };
>   
>   &binman {
> -	ti-spl_unsigned {
> +	ti_spl_unsigned: template-14 {
>   		insert-template = <&ti_spl_unsigned_template>;
>   
>   		fit {
> @@ -295,13 +260,13 @@
>   				};
>   
>   				fdt-0 {
> -					description = "k3-j784s4-evm";
> +					description = BOARD_DESCRIPTION;
>   					type = "flat_dt";
>   					arch = "arm";
>   					compression = "none";
>   
>   					spl_j784s4_evm_dtb_unsigned: blob {
> -						filename = SPL_J784S4_EVM_DTB;
> +						filename = SPL_BOARD_DTB;
>   					};
>   				};
>   			};
> @@ -310,7 +275,7 @@
>   				default = "conf-0";
>   
>   				conf-0 {
> -					description = "k3-j784s4-evm";
> +					description = BOARD_DESCRIPTION;
>   					firmware = "atf";
>   					loadables = "tee", "dm", "spl";
>   					fdt = "fdt-0";
> @@ -321,23 +286,23 @@
>   };
>   
>   &binman {
> -	u-boot_unsigned {
> +	u_boot_unsigned: template-15 {
>   		insert-template = <&u_boot_unsigned_template>;
>   
>   		fit {
>   			images {
>   				uboot {
> -					description = "U-Boot for J784S4 board";
> +					description = UBOOT_BOARD_DESCRIPTION;
>   				};
>   
>   				fdt-0 {
> -					description = "k3-j784s4-evm";
> +					description = BOARD_DESCRIPTION;
>   					type = "flat_dt";
>   					arch = "arm";
>   					compression = "none";
>   
>   					j784s4_evm_dtb_unsigned: blob {
> -						filename = J784S4_EVM_DTB;
> +						filename = "u-boot.dtb";
>   					};
>   
>   					hash {
> @@ -350,7 +315,7 @@
>   				default = "conf-0";
>   
>   				conf-0 {
> -					description = "k3-j784s4-evm";
> +					description = BOARD_DESCRIPTION;
>   					firmware = "uboot";
>   					loadables = "uboot";
>   					fdt = "fdt-0";
> @@ -359,23 +324,4 @@
>   		};
>   	};
>   };
> -
> -#include "k3-binman-capsule.dtsi"
> -
> -// Capsule update GUIDs in string form.  See j784s4_evm.h
> -#define AM69_SK_SPL_IMAGE_GUID_STR "787f0059-63a1-461c-a18e-9d838345fe8e"
> -#define AM69_SK_UBOOT_IMAGE_GUID_STR "9300505d-6ec5-4ff8-99e4-5459a04be617"
> -
> -&capsule_tispl {
> -	efi-capsule {
> -		image-guid = AM69_SK_SPL_IMAGE_GUID_STR;
> -	};
> -};
> -
> -&capsule_uboot {
> -	efi-capsule {
> -		image-guid = AM69_SK_UBOOT_IMAGE_GUID_STR;
> -	};
> -};
> -
>   #endif
> diff --git a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
> index 8f0307321e843a10ee0696ff41f2e3a8fc83add0..61eab2c2dfd404861da4cce5d6083a8daa3f4fe9 100644
> --- a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
> @@ -3,8 +3,82 @@
>    * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
> +#define SPL_BOARD_DTB "spl/dts/ti/k3-j784s4-evm.dtb"
> +#define BOARD_DESCRIPTION "k3-j784s4-evm"
> +#define UBOOT_BOARD_DESCRIPTION "U-Boot for J784S4 board"
> +
>   #include "k3-j784s4-binman.dtsi"
>   
> +#if !defined(CONFIG_ARM64)
> +&binman {
> +	tiboot3-j784s4-hs {
> +		insert-template = <&tiboot3_j784s4_hs>;
> +		filename = "tiboot3-j784s4-hs-evm.bin";
> +	};
> +
> +	tiboot3-j784s4-hs-fs {
> +		insert-template = <&tiboot3_j784s4_hs_fs>;
> +		filename = "tiboot3-j784s4-hs-fs-evm.bin";
> +	};
> +
> +	tiboot3-j784s4-gp {
> +		insert-template = <&tiboot3_j784s4_gp>;
> +		filename = "tiboot3-j784s4-gp-evm.bin";
> +		symlink = "tiboot3.bin";
> +	};
> +};
> +
> +&ti_fs_gp {
> +	filename = "ti-sysfw/ti-fs-firmware-j784s4-gp.bin";
> +};
> +
> +&ti_fs_enc {
> +	filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-enc.bin";
> +};
> +
> +&sysfw_inner_cert {
> +	filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-cert.bin";
> +};
> +
> +&ti_fs_enc_fs {
> +	filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-fs-enc.bin";
> +};
> +
> +&sysfw_inner_cert_fs {
> +	filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-fs-cert.bin";
> +};
> +
> +#else // CONFIG_ARM64
> +
> +&binman {
> +	ti-dm {
> +		filename = "ti-dm.bin";
> +
> +		blob-ext {
> +			filename = "ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> +			optional;
> +		};
> +	};
> +
> +	tispl {
> +		insert-template = <&ti_spl>;
> +	};
> +
> +	u-boot {
> +		insert-template = <&u_boot>;
> +	};
> +
> +	tispl-unsigned {
> +		insert-template = <&ti_spl_unsigned>;
> +	};
> +
> +	u-boot-unsigned {
> +		insert-template = <&u_boot_unsigned>;
> +	};
> +};
> +
> +#endif
> +
>   / {
>   	memory@80000000 {
>   		bootph-all;
>
