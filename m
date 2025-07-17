Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3312CC83F34
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 17:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C1AA8346A;
	Thu, 17 Jul 2025 19:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VANbqVDr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 534BD8346A; Thu, 17 Jul 2025 19:20:34 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1976833FC
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 19:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56HHKTl2520764;
 Thu, 17 Jul 2025 12:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752772829;
 bh=hgy+D3Kxgym2/PQeuilZOmQmGNXw9FQi4LayhtcOBEc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=VANbqVDrSa2X5TpbL7+STuFNZwn2B0sfB41HPrAnSpzovM4ycSMKn7GIR+dM1iKTM
 N13UmuoRVB7fIarXqDsgfUV5+rBFRA2OhAq0kvUcC6rgYOhKuiIRbvROy/jDYrSkCT
 64SL87ZZdSg1KPCAtwgJzInipVBI3LejeYfzpB4Q=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56HHKTJv1789424
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 17 Jul 2025 12:20:29 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 17
 Jul 2025 12:20:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 17 Jul 2025 12:20:29 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56HHKSfE2209784;
 Thu, 17 Jul 2025 12:20:28 -0500
Message-ID: <3d30853a-59eb-4907-8810-9daf49209eb6@ti.com>
Date: Thu, 17 Jul 2025 12:20:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3: use SPL_TEXT_BASE for R5 SPL load address
To: Bryan Brattlof <bb@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Tom Rini
 <trini@konsulko.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>
CC: <u-boot@lists.denx.de>
References: <20250717-dt-cleanup-v1-1-a911b0bb832b@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250717-dt-cleanup-v1-1-a911b0bb832b@ti.com>
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

On 7/17/25 7:13 AM, Bryan Brattlof wrote:
> The load address for the R5's SPL is defined in Kconfig by
> SPL_TEXT_BASE. Rather than hard coding the load address which could
> lead to hard to debug issues if this value is changed, just use the
> SPL_TEXT_BASE value.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---

Seems resonable, but looks like you missed the same in J784s4 and
J721s2, otherwise,

Reviewed-by: Andrew Davis <afd@ti.com>

>   arch/arm/dts/k3-am625-phycore-som-binman.dtsi      | 6 +++---
>   arch/arm/dts/k3-am625-sk-binman.dtsi               | 6 +++---
>   arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 6 +++---
>   arch/arm/dts/k3-am62a-phycore-som-binman.dtsi      | 6 +++---
>   arch/arm/dts/k3-am62a-sk-binman.dtsi               | 6 +++---
>   arch/arm/dts/k3-am62p-sk-binman.dtsi               | 4 ++--
>   arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi | 4 ++--
>   arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi       | 4 ++--
>   arch/arm/dts/k3-j722s-binman.dtsi                  | 4 ++--
>   9 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> index 6deebdadf092aff27ddb4201e408f2aefe9a0f0f..a9bd5a2be84abf5645c540360b08f15260bca5d3 100644
> --- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> @@ -25,7 +25,7 @@
>   			content-sysfw-data = <&combined_tifs_cfg>;
>   			content-sysfw-inner-cert = <&sysfw_inner_cert>;
>   			content-dm-data = <&combined_dm_cfg>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			load-sysfw = <0x40000>;
>   			load-sysfw-data = <0x67000>;
>   			load-dm-data = <0x43c3a800>;
> @@ -69,7 +69,7 @@
>   			content-sysfw-data = <&combined_tifs_cfg_fs>;
>   			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
>   			content-dm-data = <&combined_dm_cfg_fs>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			load-sysfw = <0x40000>;
>   			load-sysfw-data = <0x67000>;
>   			load-dm-data = <0x43c3a800>;
> @@ -105,7 +105,7 @@
>   			combined;
>   			dm-data;
>   			content-sbl = <&u_boot_spl_unsigned>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			content-sysfw = <&ti_fs_gp>;
>   			load-sysfw = <0x40000>;
>   			content-sysfw-data = <&combined_tifs_cfg_gp>;
> diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
> index 6822a5dac896eb55de15d8c9eb38061f76ec6e51..f743c4353b49c882a87631610232e6d6de1300c4 100644
> --- a/arch/arm/dts/k3-am625-sk-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
> @@ -23,7 +23,7 @@
>   			content-sysfw-data = <&combined_tifs_cfg>;
>   			content-sysfw-inner-cert = <&sysfw_inner_cert>;
>   			content-dm-data = <&combined_dm_cfg>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			load-sysfw = <0x40000>;
>   			load-sysfw-data = <0x67000>;
>   			load-dm-data = <0x43c3a800>;
> @@ -67,7 +67,7 @@
>   			content-sysfw-data = <&combined_tifs_cfg_fs>;
>   			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
>   			content-dm-data = <&combined_dm_cfg_fs>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			load-sysfw = <0x40000>;
>   			load-sysfw-data = <0x67000>;
>   			load-dm-data = <0x43c3a800>;
> @@ -103,7 +103,7 @@
>   			combined;
>   			dm-data;
>   			content-sbl = <&u_boot_spl_unsigned>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			content-sysfw = <&ti_fs_gp>;
>   			load-sysfw = <0x40000>;
>   			content-sysfw-data = <&combined_tifs_cfg_gp>;
> diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> index bfbba28269cf3435944e2e25bf9c454af88046f4..65fef6e479070bb64cd1297d17b189c72892379f 100644
> --- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> @@ -23,7 +23,7 @@
>   			content-sysfw-data = <&combined_tifs_cfg>;
>   			content-sysfw-inner-cert = <&sysfw_inner_cert>;
>   			content-dm-data = <&combined_dm_cfg>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			load-sysfw = <0x40000>;
>   			load-sysfw-data = <0x67000>;
>   			load-dm-data = <0x43c3a800>;
> @@ -67,7 +67,7 @@
>   			content-sysfw-data = <&combined_tifs_cfg_fs>;
>   			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
>   			content-dm-data = <&combined_dm_cfg_fs>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			load-sysfw = <0x40000>;
>   			load-sysfw-data = <0x67000>;
>   			load-dm-data = <0x43c3a800>;
> @@ -103,7 +103,7 @@
>   			combined;
>   			dm-data;
>   			content-sbl = <&u_boot_spl_unsigned>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			content-sysfw = <&ti_fs_gp>;
>   			load-sysfw = <0x40000>;
>   			content-sysfw-data = <&combined_tifs_cfg_gp>;
> diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
> index fd3401015325cd34fd7e3592e1f5bc6cfec50b3a..9bcdf74ffe46368ddc6a872d02f26378aba763a9 100644
> --- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
> @@ -30,7 +30,7 @@
>   			content-sysfw-data = <&combined_tifs_cfg>;
>   			content-sysfw-inner-cert = <&sysfw_inner_cert>;
>   			content-dm-data = <&combined_dm_cfg>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			load-sysfw = <0x40000>;
>   			load-sysfw-data = <0x67000>;
>   			load-dm-data = <0x43c3a800>;
> @@ -74,7 +74,7 @@
>   			content-sysfw-data = <&combined_tifs_cfg_fs>;
>   			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
>   			content-dm-data = <&combined_dm_cfg_fs>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			load-sysfw = <0x40000>;
>   			load-sysfw-data = <0x67000>;
>   			load-dm-data = <0x43c3a800>;
> @@ -110,7 +110,7 @@
>   			combined;
>   			dm-data;
>   			content-sbl = <&u_boot_spl_unsigned>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			content-sysfw = <&ti_fs_gp>;
>   			load-sysfw = <0x40000>;
>   			content-sysfw-data = <&combined_tifs_cfg_gp>;
> diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
> index 877a513a2418611b491963925440011cc1e319bf..0685bdd7e0c78087777e12cfa3d936c63f2fa597 100644
> --- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
> +++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
> @@ -27,7 +27,7 @@
>   			content-sysfw-data = <&combined_tifs_cfg>;
>   			content-sysfw-inner-cert = <&sysfw_inner_cert>;
>   			content-dm-data = <&combined_dm_cfg>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			load-sysfw = <0x40000>;
>   			load-sysfw-data = <0x67000>;
>   			load-dm-data = <0x43c3a800>;
> @@ -71,7 +71,7 @@
>   			content-sysfw-data = <&combined_tifs_cfg_fs>;
>   			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
>   			content-dm-data = <&combined_dm_cfg_fs>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			load-sysfw = <0x40000>;
>   			load-sysfw-data = <0x67000>;
>   			load-dm-data = <0x43c3a800>;
> @@ -107,7 +107,7 @@
>   			combined;
>   			dm-data;
>   			content-sbl = <&u_boot_spl_unsigned>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			content-sysfw = <&ti_fs_gp>;
>   			load-sysfw = <0x40000>;
>   			content-sysfw-data = <&combined_tifs_cfg_gp>;
> diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
> index d65e5c4d4e1e53f30040f32306d7b8c0159a3176..feb59edcd832ba535deac296ff82f3d9929050fe 100644
> --- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
> +++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
> @@ -25,7 +25,7 @@
>   			content-sysfw-data = <&combined_tifs_cfg_fs>;
>   			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
>   			content-dm-data = <&combined_dm_cfg_fs>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			load-sysfw = <0x40000>;
>   			load-sysfw-data = <0x67000>;
>   			load-dm-data = <0x43c4a800>;
> @@ -72,7 +72,7 @@
>   			content-sysfw-data = <&combined_tifs_cfg_hs>;
>   			content-sysfw-inner-cert = <&sysfw_inner_cert_hs>;
>   			content-dm-data = <&combined_dm_cfg_hs>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			load-sysfw = <0x40000>;
>   			load-sysfw-data = <0x67000>;
>   			load-dm-data = <0x43c4a800>;
> diff --git a/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
> index 13fac18d7aac6fd5d146bcd5b815282f8e53372d..b1591faaf0a52e9f18e95c85b9da18d43d8a8758 100644
> --- a/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
> +++ b/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
> @@ -25,7 +25,7 @@
>   			content-sysfw-data = <&combined_tifs_cfg_fs>;
>   			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
>   			content-dm-data = <&combined_dm_cfg_fs>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			load-sysfw = <0x40000>;
>   			load-sysfw-data = <0x67000>;
>   			load-dm-data = <0x43c4a800>;
> @@ -74,7 +74,7 @@
>   			content-sysfw-data = <&combined_tifs_cfg_hs>;
>   			content-sysfw-inner-cert = <&sysfw_inner_cert_hs>;
>   			content-dm-data = <&combined_dm_cfg_hs>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			load-sysfw = <0x40000>;
>   			load-sysfw-data = <0x67000>;
>   			load-dm-data = <0x43c4a800>;
> diff --git a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
> index 2a0023fb7c313270ed6b4ccf967a2b59bf8e3d09..0e810e7f492dbb37cde89b6adc8b78098e0134e7 100644
> --- a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
> @@ -75,7 +75,7 @@
>   			content-sysfw-data = <&combined_tifs_cfg>;
>   			content-sysfw-inner-cert = <&sysfw_inner_cert>;
>   			content-dm-data = <&combined_dm_cfg>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			load-sysfw = <0x40000>;
>   			load-sysfw-data = <0x67000>;
>   			load-dm-data = <0x43c7a800>;
> @@ -125,7 +125,7 @@
>   			content-sysfw-data = <&combined_tifs_cfg_fs>;
>   			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
>   			content-dm-data = <&combined_dm_cfg_fs>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			load-sysfw = <0x40000>;
>   			load-sysfw-data = <0x67000>;
>   			load-dm-data = <0x43c7a800>;
> diff --git a/arch/arm/dts/k3-j722s-binman.dtsi b/arch/arm/dts/k3-j722s-binman.dtsi
> index 57e966ea666447118503e59ed0ddf40f471ae4c0..278b7bfac7fa0369f1227941d392a17ce71a1112 100644
> --- a/arch/arm/dts/k3-j722s-binman.dtsi
> +++ b/arch/arm/dts/k3-j722s-binman.dtsi
> @@ -23,7 +23,7 @@
>   			content-sysfw-data = <&combined_tifs_cfg>;
>   			content-sysfw-inner-cert = <&sysfw_inner_cert>;
>   			content-dm-data = <&combined_dm_cfg>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			load-sysfw = <0x40000>;
>   			load-sysfw-data = <0x67000>;
>   			load-dm-data = <0x43c7a800>;
> @@ -73,7 +73,7 @@
>   			content-sysfw-data = <&combined_tifs_cfg_fs>;
>   			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
>   			content-dm-data = <&combined_dm_cfg_fs>;
> -			load = <0x43c00000>;
> +			load = <CONFIG_SPL_TEXT_BASE>;
>   			load-sysfw = <0x40000>;
>   			load-sysfw-data = <0x67000>;
>   			load-dm-data = <0x43c7a800>;
> 
> ---
> base-commit: 3b4604a40b9fd61b87e9d059fc56f04d36f1a380
> change-id: 20250717-dt-cleanup-8892f5dbacf0
> 
> Best regards,
