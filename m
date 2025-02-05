Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549B5C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 22:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BFB180104;
	Wed,  5 Feb 2025 23:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="gUfH6HE4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D2E8033D; Wed,  5 Feb 2025 23:37:13 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE057800CF
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 23:37:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9fbe=U5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738795027;
 bh=lSQDfeiF3CF0yQdIE77+sZ1WNeuH2TjhXON1b+9Nyj0=;
 b=gUfH6HE4v9NADnIMOn/rDHW6kswYoKgyb6CvG6Pm+VL5kuUU2P/6hR1Yc9t3VzgphdQQ/0jSk
 aaujomWPK36bHX++8k6pFKRh7rLlMW4OdVswLCUQjKERSDFl/BRCWvR9L8b4dB6rHyaIwfHu2x/
 5UPUAUsGUmGDCaoPifnP0WGoLtTnJnhkJBQqHRcxYMJlWx8MR1BoyBMPiqhgWp4MH93agu69Kwg
 P/9bpHmZRoNfT06v48kbrMM/drVocWBBgFUsfPJWGbZuv38iOT8vMz+/Eumd+IAm8opr9xMsm5g
 QgjAWijT1FqhFxda7rnMCY8L2KVjk6W/dCNW6+Sg3WVQ==
X-Forward-Email-ID: 67a3e8114f7eea50c61f4aae
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <73802b2c-1cf5-4b16-a44d-e5211c8c7536@kwiboo.se>
Date: Wed, 5 Feb 2025 23:37:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/29] rockchip: dts: Create a template for the FIT
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-10-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250205015606.2686149-10-sjg@chromium.org>
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

On 2025-02-05 02:54, Simon Glass wrote:
> Move the FIT description into a template so that it can (later) be used
> in multiple places in the image.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  arch/arm/dts/rockchip-u-boot.dtsi | 57 ++++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index da0ac078cb6..8418635ed84 100644
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
> +			type = "fit";
>  #ifdef CONFIG_ARM64
>  			description = "FIT image for U-Boot with bl31 (TF-A)";
>  #else
> @@ -59,7 +44,6 @@
>  			filename = "u-boot.itb";
>  			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
>  			fit,align = <512>;
> -			offset = <CONFIG_SPL_PAD_TO>;
>  			images {
>  				u-boot {
>  					description = "U-Boot";
> @@ -164,6 +148,33 @@
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
> +		};
> +
> +#ifdef HAS_FIT
> +		fit {
> +			offset = <CONFIG_SPL_PAD_TO>;
> +			insert-template = <&common_part>;
>  		};
>  #else
>  		u-boot-img {

This looks fine in theory, but we should probably also fix the possible
abuse of following in simple-bin-spi and rk3399-u-boot.dtsi rom images.

  fit {
  	type = "blob";
  	filename = "u-boot.itb";
  };

Regards,
Jonas
