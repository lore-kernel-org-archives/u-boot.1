Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D32C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 21:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D97884A3;
	Wed, 19 Jun 2024 23:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uYE2ugY8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E88A884BA; Wed, 19 Jun 2024 23:44:55 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B06BF88485
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 23:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45JLinX6085318;
 Wed, 19 Jun 2024 16:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718833489;
 bh=vsPw7iWcOrvCF6VV6Itjsiuv+vKXmvNqlmoEdLIDOng=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=uYE2ugY8i3OuWM/4ETQcFem52DxQ6SxyqyE1tZ7DipD8Az94W1HqcQT/Jjx1M0cEK
 m1oS0VWvrIokF/FgUbapQSx8fvYK/O/uriPJWUFc1aZNzM7PGntz8LiEEI7bJMxyXS
 IOe4q8QNRmFw9eZjq5jGf/MsQAmAYc/qmXJvm6Xs=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45JLinxk077517
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Jun 2024 16:44:49 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Jun 2024 16:44:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Jun 2024 16:44:48 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45JLimrX030341;
 Wed, 19 Jun 2024 16:44:48 -0500
Date: Wed, 19 Jun 2024 16:44:48 -0500
From: Bryan Brattlof <bb@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, Nishant Menon <nm@ti.com>,
 <c-shilwant@ti.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>
Subject: Re: [PATCH v2] arm: dts: k3-am625-beagleplay: Package TIFS Stub
Message-ID: <20240619214448.saaw6w2iueolb6vd@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240618045610.271884-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240618045610.271884-1-d-gole@ti.com>
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

On June 18, 2024 thus sayeth Dhruva Gole:
> Add support for packaging the TIFS Stub as it's required for basic Low
> Power Modes like Deep Sleep.
> 
> Acked-by: Neha Malcom Francis <n-francis@ti.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> 
> No changes from v1, just picked Neha's ack and rebased on master again.
> Link to v1:
> https://lore.kernel.org/u-boot/20240612062351.3690091-1-d-gole@ti.com/
> 
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 33 +++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> index fb2032068d1c..5e2248a4a668 100644
> --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> @@ -69,6 +69,23 @@
>  		};
>  	};
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
>  	ti-spl_unsigned {
>  		filename = "tispl.bin_unsigned";
>  		pad-byte = <0xff>;
> @@ -105,6 +122,19 @@
>  					};
>  				};
>  
> +				tifsstub-gp {
> +					description = "tifsstub";
> +					type = "firmware";
> +					arch = "arm32";
> +					compression = "none";
> +					os = "tifsstub-gp";
> +					load = <0x9dc00000>;
> +					entry = <0x9dc00000>;

Is this stub position independent? Or is this address compiled in at 
build time? We have some variants of 62x that don't have these addresses 
backed by DRAM.

~Bryan

> +					blob-ext {
> +						filename = "tifsstub.bin_gp";
> +					};
> +				};
> +
>  				dm {
>  					description = "DM binary";
>  					type = "firmware";
> @@ -148,7 +178,8 @@
>  				conf-0 {
>  					description = "k3-am625-beagleplay";
>  					firmware = "atf";
> -					loadables = "tee", "dm", "spl";
> +					loadables = "tee", "dm", "spl",
> +					"tifsstub-gp";
>  					fdt = "fdt-0";
>  				};
>  			};
> 
> base-commit: 16324b43db3f2b4fbbc3b701893fcfc4104f33fb
> -- 
> 2.34.1
> 
