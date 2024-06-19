Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2D6C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 18:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDDC88840C;
	Wed, 19 Jun 2024 20:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kpZu16nk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C468840C; Wed, 19 Jun 2024 20:47:47 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 054DD8839D
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 20:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45JIlbiV070625;
 Wed, 19 Jun 2024 13:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718822857;
 bh=foA+4F3QwZn8509jyvKMDHY0Lx45u2EnMlTikXF1WWk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=kpZu16nkad/qF3UcBjQiPxV9JfjD2vUQbcvyQl8pT7FjgFhllDvm5I7ioUHylV9EW
 0Mjj6isB3L+oJb4x0n9W5U0UGxfMVGoNgVqKS9HoIlBgiR7SSiFcg1z3jpKWZ1LJ8c
 8lAD6Ksi4bZj/RXLDbpl21hnLN3/t3ii5JMBwBIA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45JIlbaV111745
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Jun 2024 13:47:37 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Jun 2024 13:47:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Jun 2024 13:47:36 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45JIlaNP033116;
 Wed, 19 Jun 2024 13:47:36 -0500
Date: Wed, 19 Jun 2024 13:47:36 -0500
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, <c-shilwant@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v2] arm: dts: k3-am625-beagleplay: Package TIFS Stub
Message-ID: <20240619184736.lnxyxdy44opk5in3@erased>
References: <20240618045610.271884-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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

On 10:26-20240618, Dhruva Gole wrote:
> Add support for packaging the TIFS Stub as it's required for basic Low
> Power Modes like Deep Sleep.

What the heck is tifs stub?
https://docs.u-boot.org/en/latest/search.html?q=tifs&check_keywords=yes&area=default
I see no mention of the same?

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

two issues with this:
a) if the tifsstub-gp is not automatically consumed by tifs by the time
u-boot is up or kernel is up, this is going to get clobbered by OS
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts#n78
Should be updated before this is done.
b) Documentation update - please always make sure you update
  documentation when doing this kind of change
https://docs.u-boot.org/en/latest/board/beagle/am62x_beagleplay.html#image-formats


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

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
