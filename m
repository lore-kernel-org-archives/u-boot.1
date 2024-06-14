Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1F8C27C79
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6B5D87F8D;
	Fri, 14 Jun 2024 14:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iYlBNbX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1BC688176; Fri, 14 Jun 2024 14:00:37 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D35FA87F8C
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45EC0Yx4059308;
 Fri, 14 Jun 2024 07:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718366434;
 bh=MX6AFlEgp/jWYMcsZ7jM36O/ikjCqDBspJzgSBjenkk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=iYlBNbX7OV3CV2PgDgNvbfN1phdtlIuS9V0Bdyv17Oiaz4rd/9Myp4wtwAA6xDEh5
 6iJWsHRTmZGQy2WZgvgxHzy1FpG0l9T4Abzo1CPJxPQg36qdFbbm67epKZg/YdVVIH
 IPNgrNzRMgBJJI6zWDHLtcINK7cM11ePVWbAto6Q=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45EC0Yko021009
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Jun 2024 07:00:34 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 07:00:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 07:00:34 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45EC0V9W104123;
 Fri, 14 Jun 2024 07:00:32 -0500
Message-ID: <d9347696-e361-427b-8d49-9b8d14379937@ti.com>
Date: Fri, 14 Jun 2024 17:30:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-am625-beagleplay: Package TIFS Stub
To: Dhruva Gole <d-gole@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Vibhore Vardhan <vibhore@ti.com>, Nishant Menon
 <nm@ti.com>
References: <20240612062351.3690091-1-d-gole@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240612062351.3690091-1-d-gole@ti.com>
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

On 12/06/24 11:53, Dhruva Gole wrote:
> Add support for packaging the TIFS Stub as it's required for basic Low
> Power Modes like Deep Sleep.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>   arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 33 +++++++++++++++++++-
>   1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> index fb2032068d1c..5e2248a4a668 100644
> --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> @@ -69,6 +69,23 @@
>   		};
>   	};
>   
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
>   	ti-spl_unsigned {
>   		filename = "tispl.bin_unsigned";
>   		pad-byte = <0xff>;
> @@ -105,6 +122,19 @@
>   					};
>   				};
>   
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
>   					description = "DM binary";
>   					type = "firmware";
> @@ -148,7 +178,8 @@
>   				conf-0 {
>   					description = "k3-am625-beagleplay";
>   					firmware = "atf";
> -					loadables = "tee", "dm", "spl";
> +					loadables = "tee", "dm", "spl",
> +					"tifsstub-gp";
>   					fdt = "fdt-0";
>   				};
>   			};

Acked-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
