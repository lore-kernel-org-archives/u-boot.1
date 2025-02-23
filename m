Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D599DC021B2
	for <u-boot@archiver.kernel.org>; Sun, 23 Feb 2025 01:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5366980F92;
	Sun, 23 Feb 2025 02:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="mYY6zmI8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A124480F96; Sun, 23 Feb 2025 02:36:32 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A256D80F88
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 02:36:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.26.251])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id E57EAB4C0390;
 Sun, 23 Feb 2025 02:36:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=mail; t=1740274590;
 bh=lvKpdItj1UZYXiiSSKfyPnbjkhjoqwESVDKE6ZWsp2g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mYY6zmI8QcJc9v8saHY+d6PqYikkN0xQU0wVKPIXUmpT11Qr06Ql+8cH2htrk947M
 nXxPczFYSxXrviSQ96eK5+DsrMPlKxtMTNSmY4JFUwxzGSMSw0Tc9CyO0Nec5rkGAA
 9DnMJF7QKiAyYv8S9nz+rmf0NWcPKky3Iob93u5Y=
Message-ID: <7baa4904-16cc-4bde-9b7b-72a1f2899645@freeshell.de>
Date: Sat, 22 Feb 2025 17:36:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] riscv: dts: starfive: remove duplicate itb entries
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, Sumit Garg
 <sumit.garg@linaro.org>, "Leon M . Busch-George" <leon@georgemail.eu>,
 Lukas Funke <lukas.funke@weidmueller.com>, H Bell <dmoo_dv@protonmail.com>,
 u-boot@lists.denx.de
References: <20250221095856.36530-1-heinrich.schuchardt@canonical.com>
 <20250221095856.36530-5-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250221095856.36530-5-heinrich.schuchardt@canonical.com>
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



On 2/21/25 01:58, Heinrich Schuchardt wrote:
> As binman already creates nodes based on CONFIG_OF_LIST we don't need to
> add extra nodes.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Tested-by: Simon Glass <sjg@chromium.org> # StarFIve VisionFive 2
> ---
> v3:
> 	no change
> v2:
> 	no change
> ---
>  .../dts/starfive-visionfive2-binman.dtsi      | 76 -------------------
>  1 file changed, 76 deletions(-)
> 
> diff --git a/arch/riscv/dts/starfive-visionfive2-binman.dtsi b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
> index 4cce001e80d..05787bdb92d 100644
> --- a/arch/riscv/dts/starfive-visionfive2-binman.dtsi
> +++ b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
> @@ -13,82 +13,6 @@
>  };
>  
>  &binman {
> -	itb {
> -		fit {
> -			images {
> -				fdt-jh7110-milkv-mars {
> -					description = "jh7110-milkv-mars";
> -					load = <0x40400000>;
> -					compression = "none";
> -
> -					blob-ext {
> -						filename = "dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dtb";
> -					};
> -				};
> -
> -				fdt-jh7110-pine64-star64 {
> -					description = "jh7110-pine64-star64";
> -					load = <0x40400000>;
> -					compression = "none";
> -
> -					blob-ext {
> -						filename = "dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dtb";
> -					};
> -				};
> -
> -				fdt-jh7110-starfive-visionfive-2-v1.2a {
> -					description = "jh7110-starfive-visionfive-2-v1.2a";
> -					load = <0x40400000>;
> -					compression = "none";
> -
> -					blob-ext {
> -						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
> -					};
> -				};
> -
> -				fdt-jh7110-starfive-visionfive-2-v1.3b {
> -					description = "jh7110-starfive-visionfive-2-v1.3b";
> -					load = <0x40400000>;
> -					compression = "none";
> -
> -					blob-ext {
> -						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
> -					};
> -				};
> -			};
> -
> -			configurations {
> -				conf-jh7110-milkv-mars {
> -					description = "jh7110-milkv-mars";
> -					firmware = "opensbi";
> -					loadables = "uboot";
> -					fdt = "fdt-jh7110-milkv-mars";
> -				};
> -
> -				conf-jh7110-pine64-star64 {
> -					description = "jh7110-pine64-star64";
> -					firmware = "opensbi";
> -					loadables = "uboot";
> -					fdt = "fdt-jh7110-pine64-star64";
> -				};
> -
> -				conf-jh7110-starfive-visionfive-2-v1.2a {
> -					description = "jh7110-starfive-visionfive-2-v1.2a";
> -					firmware = "opensbi";
> -					loadables = "uboot";
> -					fdt = "fdt-jh7110-starfive-visionfive-2-v1.2a";
> -				};
> -
> -				conf-jh7110-starfive-visionfive-2-v1.3b {
> -					description = "jh7110-starfive-visionfive-2-v1.3b";
> -					firmware = "opensbi";
> -					loadables = "uboot";
> -					fdt = "fdt-jh7110-starfive-visionfive-2-v1.3b";
> -				};
> -			};
> -		};
> -	};
> -
>  	spl-img {
>  		filename = "spl/u-boot-spl.bin.normal.out";
>  

Reviewed-by: E Shattow <e@freeshell.de>
