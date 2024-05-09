Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA02C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 15:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CD4F880A5;
	Thu,  9 May 2024 17:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aiy6Rn/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D74F68812C; Thu,  9 May 2024 17:07:04 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EEF788076
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 17:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 449F6jme012040;
 Thu, 9 May 2024 10:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715267205;
 bh=ldlWgIoTtDYnhvvnZ6V2qmfo5iD15kIO8ab8k8hHyw8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=aiy6Rn/ENn9/ZmDBB9/zqoa491wh2DhPD8XYWN+yjaiR8jItaoRfSHNqVhgMUJj9v
 arOWIuaFA0Hkvn/x2RSLGHHQqLpALC27jV8dVxpj6Ux7CZkXejHPZ0gfxUsXRzLpYD
 4RdP6cwt2eW6jQSnlcC8/2ceR6eX6B/cyD6Hc+lQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 449F6jtM032207
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 10:06:45 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 10:06:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 10:06:44 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 449F6iC2027907;
 Thu, 9 May 2024 10:06:44 -0500
Message-ID: <1c00963a-c581-4ef5-a1b9-33db78d6e7d2@ti.com>
Date: Thu, 9 May 2024 10:06:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm: dts: k3-j721e-binman: Add support for HSFS1.1
To: Neha Malcom Francis <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <sjg@chromium.org>
CC: <kamlesh@ti.com>, <m-chawdhry@ti.com>, <u-kumar1@ti.com>, <bsheraw@ti.com>,
 <s-anna@ti.com>, <a-limaye@ti.com>
References: <20240425220659.2056955-1-n-francis@ti.com>
 <20240425220659.2056955-2-n-francis@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240425220659.2056955-2-n-francis@ti.com>
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

On 4/25/24 5:06 PM, Neha Malcom Francis wrote:
> J721E has SR1.1 and SR2.0 having three variants of each GP, HS-FS and
> HS-SE. Current build does not generate HS-FS SR1.1 so add support for
> them.
> 
> Reported-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Changes since v1:
> - removed redundant HS-SE SR2.0 generation
> 

Looks good to me now,

Reviewed-by: Andrew Davis <afd@ti.com>

>   arch/arm/dts/k3-j721e-binman.dtsi | 90 ++++++++++++++++++++++++++++++-
>   1 file changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
> index 75a6e9599b9..1514d897634 100644
> --- a/arch/arm/dts/k3-j721e-binman.dtsi
> +++ b/arch/arm/dts/k3-j721e-binman.dtsi
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #include "k3-binman.dtsi"
> @@ -129,6 +129,94 @@
>   	};
>   };
>   
> +&binman {
> +	tiboot3-j721e_sr1_1-hs-fs-evm.bin {
> +		filename = "tiboot3-j721e_sr1_1-hs-fs-evm.bin";
> +		ti-secure-rom {
> +			content = <&u_boot_spl_fs_sr1_1>;
> +			core = "public";
> +			core-opts = <2>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
> +			keyfile = "custMpk.pem";
> +		};
> +		u_boot_spl_fs_sr1_1: u-boot-spl {
> +			no-expanded;
> +		};
> +	};
> +	sysfw_fs_sr1_1 {
> +		filename = "sysfw.bin_fs_sr1_1";
> +		ti-fs-cert-fs.bin {
> +			filename = "ti-sysfw/ti-fs-firmware-j721e_sr1_1-hs-fs-cert.bin";
> +			type = "blob-ext";
> +			optional;
> +		};
> +		ti-fs-firmware-j721e-hs-fs-enc.bin {
> +			filename = "ti-sysfw/ti-fs-firmware-j721e_sr1_1-hs-fs-enc.bin";
> +			type = "blob-ext";
> +			optional;
> +		};
> +	};
> +	itb_fs_sr1_1 {
> +		filename = "sysfw-j721e_sr1_1-hs-fs-evm.itb";
> +		fit {
> +			description = "SYSFW and Config fragments";
> +			#address-cells = <1>;
> +			images {
> +				sysfw.bin {
> +					description = "sysfw";
> +					type = "firmware";
> +					arch = "arm";
> +					compression = "none";
> +					blob-ext {
> +					    filename = "sysfw.bin_fs_sr1_1";
> +					};
> +				};
> +				board-cfg.bin {
> +					description = "board-cfg";
> +					type = "firmware";
> +					arch = "arm";
> +					compression = "none";
> +					board-cfg {
> +						filename = "board-cfg.bin";
> +						type = "blob-ext";
> +					};
> +
> +				};
> +				pm-cfg.bin {
> +					description = "pm-cfg";
> +					type = "firmware";
> +					arch = "arm";
> +					compression = "none";
> +					pm-cfg {
> +						filename = "pm-cfg.bin";
> +						type = "blob-ext";
> +					};
> +				};
> +				rm-cfg.bin {
> +					description = "rm-cfg";
> +					type = "firmware";
> +					arch = "arm";
> +					compression = "none";
> +					rm-cfg {
> +						filename = "rm-cfg.bin";
> +						type = "blob-ext";
> +					};
> +				};
> +				sec-cfg.bin {
> +					description = "sec-cfg";
> +					type = "firmware";
> +					arch = "arm";
> +					compression = "none";
> +					sec-cfg {
> +						filename = "sec-cfg.bin";
> +						type = "blob-ext";
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
>   &binman {
>   	tiboot3-j721e_sr2-hs-fs-evm.bin {
>   		filename = "tiboot3-j721e_sr2-hs-fs-evm.bin";
