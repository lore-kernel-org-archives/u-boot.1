Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DF5C54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 09:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6C0587E1B;
	Mon, 25 Mar 2024 10:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lFVwOpYH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D26187E2E; Mon, 25 Mar 2024 10:20:40 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9952F87DFA
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 10:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42P9KVDN071439;
 Mon, 25 Mar 2024 04:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711358431;
 bh=EWE7oKRKVNZ8uKkW3iphC6teVvzjnxFclMCnJqI+Huo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=lFVwOpYHJTe8qEHBqfkzH5mt4xffqq3OHy8zBY/dZFwQ7lnNM7GAbXw9VfORp8sGD
 8CFO3MOJBMYsdfDXW8VBJOwLms+SIAjv4+Ggdfb7IewJfFtvt14VyY3ot4l8JSTS9l
 HG8L9MH5DoSQEqN2U/AFhNckrA7YBVMJRbuRROpg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42P9KVmY013083
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Mar 2024 04:20:31 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 04:20:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 04:20:30 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42P9KSAn107451;
 Mon, 25 Mar 2024 04:20:29 -0500
Date: Mon, 25 Mar 2024 14:50:28 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <bb@ti.com>, <nm@ti.com>,
 <sumit.garg@linaro.org>, <michal.simek@amd.com>, <marex@denx.de>,
 <neil.armstrong@linaro.org>, <afd@ti.com>, <vigneshr@ti.com>,
 <kamlesh@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH 3/4] arm: dts: k3-*-binman.dtsi: Clean up and templatize
 boot binaries
Message-ID: <20240325092028.cjbtsdu4t7eo67dp@uda0497581>
References: <20240322131011.1029620-1-n-francis@ti.com>
 <20240322131011.1029620-4-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240322131011.1029620-4-n-francis@ti.com>
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

Hi Neha,

On 18:40-20240322, Neha Malcom Francis wrote:
> Clean up templatized boot binaries for all K3 boards. This includes
> modifying the k3-binman.dtsi to use SPL_BOARD_DTB, BOARD_DESCRIPTION and
> UBOOT_BOARD_DESCRIPTION from the files that include it to further reuse
> code.
> 
> All k3-<soc>-binman.dtsi will contain only templates. Only required boot
> binaries can be built from the templates in the boards' respective
> -u-boot.dtsi file (or k3-<board>-binman.dtsi if it exists). This allows
> clear distinction between the SoC common stuff vs. what is additionally
> needed to boot up a specific board.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  | 161 +---------
>  arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 291 +----------------
>  arch/arm/dts/k3-am625-r5-beagleplay.dts       |  39 ---
>  arch/arm/dts/k3-am625-sk-binman.dtsi          | 148 +--------
>  arch/arm/dts/k3-am625-sk-u-boot.dtsi          |  42 +++
>  .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 296 +-----------------
>  arch/arm/dts/k3-am62a-sk-binman.dtsi          | 146 +--------
>  arch/arm/dts/k3-am62a7-sk-u-boot.dtsi         |  42 +++
>  arch/arm/dts/k3-am642-evm-u-boot.dtsi         |  42 +++
>  arch/arm/dts/k3-am642-sk-u-boot.dtsi          |  42 +++
>  arch/arm/dts/k3-am64x-binman.dtsi             | 239 +-------------
>  arch/arm/dts/k3-am654-base-board-u-boot.dtsi  |  49 +++
>  arch/arm/dts/k3-am65x-binman.dtsi             | 144 +--------
>  .../arm/dts/k3-am68-sk-base-board-u-boot.dtsi |  26 ++
>  arch/arm/dts/k3-am69-sk-u-boot.dtsi           |  31 +-
>  arch/arm/dts/k3-binman.dtsi                   |  96 ++++++
>  arch/arm/dts/k3-j7200-binman.dtsi             | 145 +--------
>  .../k3-j7200-common-proc-board-u-boot.dtsi    |  40 +++
>  .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   | 154 +--------
>  arch/arm/dts/k3-j721e-binman.dtsi             | 262 +++-------------
>  .../k3-j721e-common-proc-board-u-boot.dtsi    |  84 +++++
>  arch/arm/dts/k3-j721e-r5-beagleboneai64.dts   |  91 +-----
>  arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |  84 +++++
>  arch/arm/dts/k3-j721s2-binman.dtsi            | 231 +-------------
>  .../k3-j721s2-common-proc-board-u-boot.dtsi   |  42 +++
>  arch/arm/dts/k3-j784s4-binman.dtsi            | 154 +--------
>  arch/arm/dts/k3-j784s4-evm-u-boot.dtsi        |  42 +++
>  27 files changed, 858 insertions(+), 2305 deletions(-)
> 

[ snip ]

> diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> index ed50bfeb031..14fc8468c56 100644
> --- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> @@ -6,309 +6,48 @@
>   * Author: Wadim Egorov <w.egorov@phytec.de>
>   */
>  
> -#include "k3-binman.dtsi"
> +#define SPL_BOARD_DTB "spl/dts/k3-am625-phyboard-lyra-rdk.dtb"
> +#define BOARD_DESCRIPTION "k3-am625-phyboard-lyra-rdk"
> +#define UBOOT_BOARD_DESCRIPTION "U-Boot for phyCORE-AM62x"
> +
> +#include "k3-am625-sk-binman.dtsi"
>  
>  #ifdef CONFIG_TARGET_PHYCORE_AM62X_R5
>  &binman {
>  	tiboot3-am62x-hs-phycore-som.bin {
>  		filename = "tiboot3-am62x-hs-phycore-som.bin";
> -		ti-secure-rom {
> -			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
> -				<&combined_dm_cfg>, <&sysfw_inner_cert>;
> -			combined;
> -			dm-data;
> -			sysfw-inner-cert;
> -			keyfile = "custMpk.pem";
> -			sw-rev = <1>;
> -			content-sbl = <&u_boot_spl>;
> -			content-sysfw = <&ti_fs_enc>;
> -			content-sysfw-data = <&combined_tifs_cfg>;
> -			content-sysfw-inner-cert = <&sysfw_inner_cert>;
> -			content-dm-data = <&combined_dm_cfg>;

I was looking between SoCs that we have and all this data seems common
to me on first glance, like there is only some delta in tiboot3
templates as well and maybe we can minimise those as well if am not
missing anything.

in k3-binman.dtsi:

tiboot3_combined_gp: template-x {
	section {
		ti-secure-rom {
			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
			combined;
			dm-data;
			content-sbl = <&u_boot_spl_unsigned>;
			content-sysfw = <&ti_fs_gp>;
			content-sysfw-data = <&combined_tifs_cfg_gp>;
			content-dm-data = <&combined_dm_cfg_gp>;
			sw-rev = <1>;
			keyfile = "ti-degenerate-key.pem";
		};
		u_boot_spl_unsigned: u-boot-spl {
			no-expanded;
		};
		ti_fs_gp: ti-fs-gp.bin {
			type = "blob-ext";
			optional;
		};
		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
			filename = "combined-tifs-cfg.bin";
			type = "blob-ext";
		};
		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
			filename = "combined-dm-cfg.bin";
			type = "blob-ext";
		};
	};
};

in k3-j721s2-binman.dtsi:

tiboot3_j721s2_gp_evm {
	insert-template = <&tiboot3_combined_gp>;
	filename = "tiboot3-j721s2-gp-evm.bin";
	section {
		ti-secure-rom {
			load = <0x41c00000>;
			load-sysfw = <0x40000>;
			load-sysfw-data = <0x67000>;
			load-dm-data = <0x41c80000>;
		}
		ti_fs_gp {
			filename = "ti-sysfw/ti-fs-firmware-j721s2-gp.bin";
		}
	}
};

in k3-j784s4-binman.dtsi:

tiboot3_j784s4_gp_evm {
	insert-template = <&tiboot3_combined_gp>;
	filename = "tiboot3-j784s4-gp-evm.bin";
	section {
		ti-secure-rom {
			load = <0x41c00000>;
			load-sysfw = <0x40000>;
			load-sysfw-data = <0x66800>;
			load-dm-data = <0x41c80000>;
		}
		ti_fs_gp {
			filename = "ti-sysfw/ti-fs-firmware-j784s4-gp.bin";
		}
	}

}

Similar re-use can be done for other GP devices as well based on
this template and similar can be extended for other variants HS-FS,
HS-SE and other SR variants. This might end up a bit complicated as well
as we do have a lot of combinations of combined boot and other boot
variants that we have so let me know if you don't find improvement with
this but I feel this might help in more readability and understanding
for the initial bootloader template designs as well.

Regards,
Manorit

> -			load = <0x43c00000>;
> -			load-sysfw = <0x40000>;
> -			load-sysfw-data = <0x67000>;
> -			load-dm-data = <0x43c3a800>;


> -		};
> -		u_boot_spl: u-boot-spl {
> -			no-expanded;
> -		};
> -		ti_fs_enc: ti-fs-enc.bin {
> -			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
> -			type = "blob-ext";
> -			optional;
> -		};
> -		combined_tifs_cfg: combined-tifs-cfg.bin {
> -			filename = "combined-tifs-cfg.bin";
> -			type = "blob-ext";
> -		};
> -		sysfw_inner_cert: sysfw-inner-cert {
> -			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
> -			type = "blob-ext";
> -			optional;
> -		};
> -		combined_dm_cfg: combined-dm-cfg.bin {
> -			filename = "combined-dm-cfg.bin";
> -			type = "blob-ext";
> -		};
> +		insert-template = <&tiboot3_am62x_hs>;
>  	};
> -};
>  
> -&binman {
>  	tiboot3-am62x-hs-fs-phycore-som.bin {
>  		filename = "tiboot3-am62x-hs-fs-phycore-som.bin";
> -		symlink = "tiboot3.bin";
> -		ti-secure-rom {
> -			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
> -				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
> -			combined;
> -			dm-data;
> -			sysfw-inner-cert;
> -			keyfile = "custMpk.pem";
> -			sw-rev = <1>;
> -			content-sbl = <&u_boot_spl_fs>;
> -			content-sysfw = <&ti_fs_enc_fs>;
> -			content-sysfw-data = <&combined_tifs_cfg_fs>;
> -			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
> -			content-dm-data = <&combined_dm_cfg_fs>;
> -			load = <0x43c00000>;
> -			load-sysfw = <0x40000>;
> -			load-sysfw-data = <0x67000>;
> -			load-dm-data = <0x43c3a800>;
> -		};
> -		u_boot_spl_fs: u-boot-spl {
> -			no-expanded;
> -		};
> -		ti_fs_enc_fs: ti-fs-enc.bin {
> -			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
> -			type = "blob-ext";
> -			optional;
> -		};
> -		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
> -			filename = "combined-tifs-cfg.bin";
> -			type = "blob-ext";
> -		};
> -		sysfw_inner_cert_fs: sysfw-inner-cert {
> -			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
> -			type = "blob-ext";
> -			optional;
> -		};
> -		combined_dm_cfg_fs: combined-dm-cfg.bin {
> -			filename = "combined-dm-cfg.bin";
> -			type = "blob-ext";
> -		};
> +		insert-template = <&tiboot3_am62x_hs_fs>;
>  	};
> -};
>  
> -&binman {
>  	tiboot3-am62x-gp-phycore-som.bin {
>  		filename = "tiboot3-am62x-gp-phycore-som.bin";
> -		ti-secure-rom {
> -			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
> -				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
> -			combined;
> -			dm-data;
> -			content-sbl = <&u_boot_spl_unsigned>;
> -			load = <0x43c00000>;
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
> -			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
> -			type = "blob-ext";
> -			optional;
> -		};
> -		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
> -			filename = "combined-tifs-cfg.bin";
> -			type = "blob-ext";
> -		};
> -		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
> -			filename = "combined-dm-cfg.bin";
> -			type = "blob-ext";
> -		};
> +		insert-template = <&tiboot3_am62x_gp>;
>  	};
>  };
>  #endif /* CONFIG_TARGET_PHYCORE_AM62X_R5 */
