Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F22EC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 21:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B2D08043C;
	Mon, 10 Feb 2025 22:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="RNHzyRJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1456F805E7; Mon, 10 Feb 2025 22:52:25 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E67C803CC
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 22:52:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cbf1=VC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739224340;
 bh=wHflmKcldcQ5iVFlg8HU6AZl6MbRcghcEbdxEormpko=;
 b=RNHzyRJdZW+egfcVNWWZQs2MtQodBnI8Oy/sUH3l61WcGnNn31nCGn3sFHnxRh9s5b0xw08/y
 LcSKzTO1r8JX1d5GTbrxWfe2AzhTN20Ffbq4ZRMUUm0c6pBtZpzZvleQbDuo/xoEDSmpdPtL7iC
 eAIPBLJUieHpbh2WOIfqecNvrLzhAHdKRBZhfAb0SaKyt2mVD4O2yE91SvqoMuPprl63all0Nzj
 gfDEju7PNwqzL9vA+lOOF61oSEHUEknKRMtfr+swMLmoI38S+cECG4HTpwtHsFLe8CQoBTuttgk
 xKVizXlm3EWfaoHKFtKNNPj7m6CI/Wg2BCjEiCBtXQlw==
X-Forward-Email-ID: 67aa7513e0c507d2fc8fbd21
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1c308da8-2fa5-494f-b175-c8519e5480fb@kwiboo.se>
Date: Mon, 10 Feb 2025 22:52:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/35] rockchip: dts: Create a template for the FIT
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-13-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250209211502.2299245-13-sjg@chromium.org>
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

On 2025-02-09 22:14, Simon Glass wrote:
> Move the FIT description into a template so that it can (later) be used
> in multiple places in the image.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/dts/rockchip-u-boot.dtsi | 57 ++++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 64a6b57d5fd..ca666ba0cd4 100644
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

Please move the filename prop to the fit node in this patch.

There are lots of guides and Linux image building scripts that depend on
the u-boot.itb file, so we should continue to keep this file to be
backward compatible for a few more releases.

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

There is one more fit node in simple-bin-spi that should change to use
#ifdef HAS_FIT. Also for consistency with fit/u-boot-img node in
simple-bin-spi I recommend we move the #else/#endif to not include the
offset and closing bracket.

I suggest something like the following fixup to be included in this patch:

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index c3013e75ed10..460bf15e0032 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -41,7 +41,6 @@
 #endif
 			#address-cells = <1>;
 			fit,fdt-list = "of-list";
-			filename = "u-boot.itb";
 			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
 			fit,align = <512>;
 			images {
@@ -173,14 +172,13 @@
 
 #ifdef HAS_FIT
 		fit {
-			offset = <CONFIG_SPL_PAD_TO>;
+			filename = "u-boot.itb";
 			insert-template = <&common_part>;
-		};
 #else
 		u-boot-img {
+#endif
 			offset = <CONFIG_SPL_PAD_TO>;
 		};
-#endif
 
 		fdtmap {
 		};
@@ -207,7 +205,7 @@
 			};
 		};
 
-#if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)
+#ifdef HAS_FIT
 		fit {
 			type = "blob";
 			filename = "u-boot.itb";


With something like that applied this is:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas
