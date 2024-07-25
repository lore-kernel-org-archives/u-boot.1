Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DBAC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 09:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C5528692C;
	Thu, 25 Jul 2024 11:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="VFriQXGW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 342E186D4C; Thu, 25 Jul 2024 11:55:23 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B5B386463
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1721901320; x=1724493320;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gvXo7WpxOeB7+tsY8CdEJJXD/shMaqPdXY0uj0wLMno=;
 b=VFriQXGWfb8F3kzEMDd1AFezcUPrIBLZaEZQtPsXsLrKh2f2+WrBLcwt8M7fzBzK
 WXIkkDDu0iaGwykjF8P5s0kwSlJOHrmbdiBnchiNXdkdK12FOvg6HX3YU6vK2wXJ
 n//czZixJErgAURoYU65PvZEu97emZUYp79lRUY57Os=;
X-AuditID: ac14000a-03e52700000021bc-a6-66a221088f1d
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 20.EC.08636.80122A66;
 Thu, 25 Jul 2024 11:55:20 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 25 Jul
 2024 11:55:19 +0200
Message-ID: <2ca52835-7bda-4765-ac73-5479db52bdf7@phytec.de>
Date: Thu, 25 Jul 2024 11:55:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 7/7] arm: dts: phycore-am62x: Package TIFS Stub
To: Dhruva Gole <d-gole@ti.com>, Tom Rini <trini@konsulko.com>, Nishant Menon
 <nm@ti.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>,
 <c-shilwant@ti.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Vibhore Vardhan <vibhore@ti.com>, Vishal Mahaveer
 <vishalm@ti.com>, Sebin Francis <sebin.francis@ti.com>, <t.remmet@phytec.de>, 
 <mkorpershoek@baylibre.com>, Daniel Schultz <d.schultz@phytec.de>
References: <20240725093546.4193107-1-d-gole@ti.com>
 <20240725093546.4193107-8-d-gole@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240725093546.4193107-8-d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWyRpKBR5dDcVGawYs1mhZ/TixntmhZ62Fx
 6UGqxYtjc9ktTt5oZbd48+Msk8X7JR8ZLe5cmcVkMXXSZnaLt3s72S0eTtjKbvH/7Ad2i9cH
 L7M68Hq8Byr32DnrLrvHqwOr2D3O3tnB6HH8xnamANYoLpuU1JzMstQifbsErowDi9azFSxW
 r+ib85y5gfGnTBcjJ4eEgIlE85Lv7F2MXBxCAkuYJBrP/2MBSQgJ3GWU2HwzE8TmFbCRWLn4
 PlicRUBV4nDjCkaIuKDEyZlPwOKiAvIS92/NYAexhQXcJBZMaGLuYuTgEBGIlri2VgdkPrPA
 ZyaJpo2djBDz4yVWLFsIVs8sIC5x68l8JhCbTUBd4s6Gb6wgNqeAqcSVOf3MEDUWEovfHISq
 l5fY/nYOM8QceYkXl5azQDwjLzHt3GtmCDtUYuuX7UwTGIVnITl1FpJ1s5CMnYVk7AJGllWM
 QrmZydmpRZnZegUZlSWpyXopqZsYQZEnwsC1g7FvjschRiYOxkOMEhzMSiK8y+4vTBPiTUms
 rEotyo8vKs1JLT7EKM3BoiTOu7ojOFVIID2xJDU7NbUgtQgmy8TBKdXAaD7FVsXSbFe33Erx
 1bNXn7157FQuf/AzZYctMYdE3Uq26X687p1V+OVRm5Gw1nNt1tdtfyeus16TlBwefOui4exF
 B95odommTePwVZWNWaJ7m9tn2qbwSRkzJorsNzhSvmzW49tWtv/b7Q5mPf+WEnUk7PC3gztF
 1O3DTz44+sVd0OXTw5WrDyqxFGckGmoxFxUnAgCWAlj9qgIAAA==
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


Am 25.07.24 um 11:35 schrieb Dhruva Gole:
> Add support for packaging the TIFS Stub as it's required for basic Low
> Power Modes like Deep Sleep.
> The reason it is packaged using binman and not inherently as part of the
> DM firmware is because for HS devices, customer owns the customer key
> and only customer has access to it.
> DM is release by TI, Since TI doesn't have access to the customer key it
> cannot have a component that is signed by customer key.
> Hence, it's left as part of binman to be signed and packaged.
> 
> While at it, also make sure it's documented in phycore-am62x
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

Thank you,

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 101 +++++++++++++++++-
>   doc/board/phytec/phycore-am62x.rst            |   2 +-
>   2 files changed, 100 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> index dbee4aa8d8a5..0961ca66f280 100644
> --- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> @@ -150,12 +150,107 @@
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
> +
>   	ti-spl {
>   		insert-template = <&ti_spl_template>;
>   
>   		fit {
>   
>   			images {
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
>   				dm {
>   					ti-secure {
>   						content = <&dm>;
> @@ -187,7 +282,8 @@
>   				conf-0 {
>   					description = "k3-am625-phyboard-lyra-rdk";
>   					firmware = "atf";
> -					loadables = "tee", "dm", "spl";
> +					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
> +						    "tifsstub-gp", "dm", "spl";
>   					fdt = "fdt-0";
>   				};
>   			};
> @@ -266,7 +362,8 @@
>   				conf-0 {
>   					description = "k3-am625-phyboard-lyra-rdk";
>   					firmware = "atf";
> -					loadables = "tee", "dm", "spl";
> +					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
> +						    "tifsstub-gp", "dm", "spl";
>   					fdt = "fdt-0";
>   				};
>   			};
> diff --git a/doc/board/phytec/phycore-am62x.rst b/doc/board/phytec/phycore-am62x.rst
> index af24acf9aac4..56c1fd8354b4 100644
> --- a/doc/board/phytec/phycore-am62x.rst
> +++ b/doc/board/phytec/phycore-am62x.rst
> @@ -32,7 +32,7 @@ Sources
>   
>   .. include::  ../ti/k3.rst
>       :start-after: .. k3_rst_include_start_boot_firmwares
> -    :end-before: .. k3_rst_include_end_boot_firmwares
> +    :end-before: .. k3_rst_include_end_tifsstub
>   
>   Build procedure
>   ---------------
