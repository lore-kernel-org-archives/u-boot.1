Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41B9C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 10:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04B9D87509;
	Wed, 20 Dec 2023 11:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KS/VTWTw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D21D987646; Wed, 20 Dec 2023 11:40:53 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A1B086CF4
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 11:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4A09BCE1AB7;
 Wed, 20 Dec 2023 10:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BE8C433C7;
 Wed, 20 Dec 2023 10:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1703068847;
 bh=zGi7lWjpfKEmC4KcJygwz+lcsW+ZD6gDzRDhIksnaHw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KS/VTWTwwxar+61yH0ozX9/N0zhS/b58w5xnQTKylSRmG0RTNnb/j6kCd+M2rnbwI
 8mamkGTVdEXiCA0IVk/xo3TfLxBicl8NAzFu7S8/iFOi5coZaZkWGg63IaEmUiIZNg
 4bvrH9sXsCaF4D17IfB87GYLLmGn4rlODKUYQljtK9LkWSLl2eLO3V2pc1wjAdLJ56
 YUscMagRaGkyYVCO5QuzNwIcQRytCQy9mGVRv2YszaTY6l8v0ternxMaERaK5IUdqT
 q1Lk+JGYPXwt+u4YyIf0bmEJhQeFGn8G2NALV3amXdIDrmJ2vPsvjEXqIwwoU8sJgi
 BWmYs/1GzDzXg==
Message-ID: <1745ec33-7446-41fc-886a-704eb6e53c7e@kernel.org>
Date: Wed, 20 Dec 2023 12:40:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/16] arm: dts: k3-am65x-binman: Add ICSSG2 overlay
 and configuration
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Maxime Ripard <mripard@kernel.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, srk@ti.com, r-gunasekaran@ti.com
References: <20231219103418.3445886-1-danishanwar@ti.com>
 <20231219103418.3445886-13-danishanwar@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231219103418.3445886-13-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 19/12/2023 12:34, MD Danish Anwar wrote:
> Add ICSSG2 overlay and configuration to tispl and u-boot images.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  arch/arm/dts/k3-am65x-binman.dtsi | 85 +++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am65x-binman.dtsi b/arch/arm/dts/k3-am65x-binman.dtsi
> index 8cc24da1f3..9a0c0fca47 100644
> --- a/arch/arm/dts/k3-am65x-binman.dtsi
> +++ b/arch/arm/dts/k3-am65x-binman.dtsi
> @@ -98,6 +98,8 @@
>  #define SPL_AM654_EVM_DTB "spl/dts/k3-am654-base-board.dtb"
>  #define AM654_EVM_DTB "u-boot.dtb"
>  
> +#define AM654_EVM_ICSSG2_DTBO "arch/arm/dts/k3-am654-icssg2.dtbo"
> +
>  &binman {
>  	ti-spl {
>  		insert-template = <&ti_spl_template>;
> @@ -124,6 +126,20 @@
>  						filename = SPL_AM654_EVM_DTB;
>  					};
>  				};
> +
> +				fdt-1 {
> +					description = "k3-am654-icssg2 overlay";
> +					type = "flat_dt";
> +					arch = "arm";
> +					compression = "none";
> +					ti-secure {
> +						content = <&spl_am65x_evm_icssg2_dtb>;
> +						keyfile = "custMpk.pem";
> +					};
> +					spl_am65x_evm_icssg2_dtb: blob-ext {
> +						filename = AM654_EVM_ICSSG2_DTBO;
> +					};

This is wrong.

ICSSG2 Ethernet should be part of the fdt-0 configuration as the 2 Ethernet ports
on the board are hardwired to ICSSG2. Not having them working by default
is an invalid configuration.

> +				};
>  			};
>  
>  			configurations {
> @@ -135,6 +151,13 @@
>  					loadables = "tee", "dm", "spl";
>  					fdt = "fdt-0";
>  				};
> +
> +				conf-1 {
> +					description = "k3-am654-icssg2";
> +					firmware = "atf";
> +					loadables = "tee", "dm", "spl";
> +					fdt = "fdt-0", "fdt-1";
> +				};
>  			};
>  		};
>  	};
> @@ -168,6 +191,24 @@
>  					};
>  				};
>  
> +				fdt-1 {
> +					description = "k3-am654-icssg2 overlay";
> +					type = "flat_dt";
> +					arch = "arm";
> +					compression = "none";
> +					ti-secure {
> +						content = <&am65x_evm_icssg2_dtb>;
> +						keyfile = "custMpk.pem";
> +
> +					};
> +					am65x_evm_icssg2_dtb: blob-ext {
> +						filename = AM654_EVM_ICSSG2_DTBO;
> +					};
> +					hash {
> +						algo = "crc32";
> +					};
> +				};
> +
>  			};
>  
>  			configurations {
> @@ -179,6 +220,13 @@
>  					loadables = "uboot";
>  					fdt = "fdt-0";
>  				};
> +
> +				conf-1 {
> +					description = "k3-am654-icssg2";
> +					firmware = "uboot";
> +					loadables = "uboot";
> +					fdt = "fdt-0", "fdt-1";
> +				};
>  			};
>  		};
>  	};
> @@ -205,6 +253,16 @@
>  						filename = SPL_AM654_EVM_DTB;
>  					};
>  				};
> +
> +				fdt-1 {
> +					description = "k3-am654-icssg2 overlay";
> +					type = "flat_dt";
> +					arch = "arm";
> +					compression = "none";
> +					blob {
> +						filename = AM654_EVM_ICSSG2_DTBO;
> +					};
> +				};
>  			};
>  
>  			configurations {
> @@ -216,6 +274,13 @@
>  					loadables = "tee", "dm", "spl";
>  					fdt = "fdt-0";
>  				};
> +
> +				conf-1 {
> +					description = "k3-am654-icssg2";
> +					firmware = "atf";
> +					loadables = "tee", "dm", "spl";
> +					fdt = "fdt-0", "fdt-1";
> +				};
>  			};
>  		};
>  	};
> @@ -243,6 +308,19 @@
>  						algo = "crc32";
>  					};
>  				};
> +
> +				fdt-1 {
> +					description = "k3-am654-icssg2";
> +					type = "flat_dt";
> +					arch = "arm";
> +					compression = "none";
> +					blob {
> +						filename = AM654_EVM_ICSSG2_DTBO;
> +					};
> +					hash {
> +						algo = "crc32";
> +					};
> +				};
>  			};
>  
>  			configurations {
> @@ -254,6 +332,13 @@
>  					loadables = "uboot";
>  					fdt = "fdt-0";
>  				};
> +
> +				conf-1 {
> +					description = "k3-am654-icssg2";
> +					firmware = "uboot";
> +					loadables = "uboot";
> +					fdt = "fdt-0", "fdt-1";
> +				};
>  			};
>  		};
>  	};

-- 
cheers,
-roger
