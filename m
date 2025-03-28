Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB88C36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61D938144A;
	Fri, 28 Mar 2025 17:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LFe7KTUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B7B58144A; Fri, 28 Mar 2025 17:27:04 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8815E810EA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:27:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=72be=WQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743179219;
 bh=/s6dj6DDoQR7VRKQ61lgPzC9IDoU/sPOQ2Cytpc3220=;
 b=LFe7KTUgHhC4qWRpptxjVzKlIemUxXPUH8zj8tkLd+PvG20duiEUPvhafTJj/209TRYZNnS4u
 P6ZqkesILlfgac0xqm1Od3PT5R7J82ZJ52GFcuWyl0R3vb51rTvCEvZtJl4rXsBFWB69bGJ2FAy
 B512RPxjpxwEiJyiiHTm0tI7px3hoyLq228wrTW+pumfOa1ot5OHSZbc5zTfjsZE/A/tOw45rGA
 e9Caqg2we7aeDeg497dv1wru6nz+cnOzsigVZ/Z1eUm1lD2udLNDkB6rdS6+wEPAV6fndagh1BG
 5epqnfqU1yj/mbWeJW3leeEYQP8iZJfUkXKNl7ITXMvg==
X-Forward-Email-ID: 67e6cdcf37e81528de2ba4c6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d18f2a43-9a08-49d6-abf6-ff1b71cab890@kwiboo.se>
Date: Fri, 28 Mar 2025 17:26:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/31] rockchip: dts: Create a template for the FIT
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250328153522.3555472-1-sjg@chromium.org>
 <20250328153522.3555472-9-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250328153522.3555472-9-sjg@chromium.org>
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

Hi Simon,

On 2025-03-28 16:34, Simon Glass wrote:
> Move the FIT description into a template so that it can (later) be used
> in multiple places in the image.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> 
> Changes in v3:
> - Use HAS_FIT for the SPI node also
> - Leave fit { node open within #ifdef HAS_FIT
> - Move placement of CONFIG_SPL_PAD_TO
> - Keep the FIT filename
> 
>  arch/arm/dts/rockchip-u-boot.dtsi | 61 ++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 8aea2e6f571..460bf15e003 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -19,6 +19,10 @@
>  #define COMP	"none"
>  #endif
>  
> +#if defined(CONFIG_SPL_FIT) && (defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE))
> +#define HAS_FIT
> +#endif
> +
>  / {
>  	binman: binman {
>  		multiple-images;
> @@ -27,28 +31,9 @@
>  
>  #ifdef CONFIG_SPL
>  &binman {
> -	simple-bin {
> -		filename = "u-boot-rockchip.bin";
> -		pad-byte = <0xff>;
> -
> -		mkimage {
> -			filename = "idbloader.img";
> -			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> -			multiple-data-files;
> -
> -#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
> -			rockchip-tpl {
> -			};
> -#elif defined(CONFIG_TPL)
> -			u-boot-tpl {
> -			};
> -#endif
> -			u-boot-spl {
> -			};
> -		};
> -
> -#if defined(CONFIG_SPL_FIT) && (defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE))
> -		fit: fit {
> +#ifdef HAS_FIT
> +	common_part: template-1 {

This name may be a little bit too generic, maybe fit_template could be
more specific and matches closer to your later added spl_template.

Regards,
Jonas

> +			type = "fit";
>  #ifdef CONFIG_ARM64
>  			description = "FIT image for U-Boot with bl31 (TF-A)";
>  #else
> @@ -56,10 +41,8 @@
>  #endif
>  			#address-cells = <1>;
>  			fit,fdt-list = "of-list";
> -			filename = "u-boot.itb";
>  			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
>  			fit,align = <512>;
> -			offset = <CONFIG_SPL_PAD_TO>;
>  			images {
>  				u-boot {
>  					description = "U-Boot";
> @@ -164,12 +147,38 @@
>  					fit,loadables;
>  				};
>  			};
> +	};
> +#endif /* HAS_FIT */
> +
> +	simple-bin {
> +		filename = "u-boot-rockchip.bin";
> +		pad-byte = <0xff>;
> +
> +		mkimage {
> +			filename = "idbloader.img";
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> +			multiple-data-files;
> +
> +#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
> +			rockchip-tpl {
> +			};
> +#elif defined(CONFIG_TPL)
> +			u-boot-tpl {
> +			};
> +#endif
> +			u-boot-spl {
> +			};
>  		};
> +
> +#ifdef HAS_FIT
> +		fit {
> +			filename = "u-boot.itb";
> +			insert-template = <&common_part>;
>  #else
>  		u-boot-img {
> +#endif
>  			offset = <CONFIG_SPL_PAD_TO>;
>  		};
> -#endif
>  
>  		fdtmap {
>  		};
> @@ -196,7 +205,7 @@
>  			};
>  		};
>  
> -#if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)
> +#ifdef HAS_FIT
>  		fit {
>  			type = "blob";
>  			filename = "u-boot.itb";

