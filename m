Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309B8C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:32:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A49A882ABA;
	Sun,  6 Apr 2025 17:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="B0+TE2IE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C08FF82B4A; Sun,  6 Apr 2025 17:32:43 +0200 (CEST)
Received: from mail-m3297.qiye.163.com (mail-m3297.qiye.163.com
 [220.197.32.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7838082A96
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10d0680ae;
 Sun, 6 Apr 2025 23:32:34 +0800 (GMT+08:00)
Message-ID: <7f4f9482-9f98-4621-8d1a-42c7dac981c1@rock-chips.com>
Date: Sun, 6 Apr 2025 23:32:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] rockchip: binman: Create a template for the FIT
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki
 <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250329150626.2879942-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUJKVhhOSEgeTEsfTUxMGVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a960bbb6bcb03afkunm10d0680ae
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46HAw4CDJMC0k*NzwIPA5L
 NzgwFEpVSlVKTE9IQk5ITk5OS0NLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTEhVSVlXWQgBWUFPSklJNwY+
DKIM-Signature: a=rsa-sha256;
 b=B0+TE2IEozxDkKyDsO23JDcdrLEXKz5yLrxr7zX+hNuc2APDW2UvSjTWfUgSNOVDeVRz2zM714YNaLyokmpt7p2BpxfmMjFRCzp0X3jj/tP6jRuFyM8Oa6IKbhuTnV7zvFgPaFk77FhWcXgzzW2wH5A+J7CegVvCp9A8J0gc0Do=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=Zi3vgFvSlJKc6sfFeaFJf2orCE6/mnYgD89mLTJHYoQ=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/3/29 23:06, Jonas Karlman wrote:
> From: Simon Glass <sjg@chromium.org>
>
> Move the FIT description into a template so that it can (later) be used
> in multiple places in the image.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v4:
> - Rename template label to fit_template
> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
>
> Changes in v3:
> - Use HAS_FIT for the SPI node also
> - Leave fit { node open within #ifdef HAS_FIT
> - Move placement of CONFIG_SPL_PAD_TO
> - Keep the FIT filename
> ---
>   arch/arm/dts/rockchip-u-boot.dtsi | 61 ++++++++++++++++++-------------
>   1 file changed, 35 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 8aea2e6f5713..9ef1ca6cd13a 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -19,6 +19,10 @@
>   #define COMP	"none"
>   #endif
>   
> +#if defined(CONFIG_SPL_FIT) && (defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE))
> +#define HAS_FIT
> +#endif
> +
>   / {
>   	binman: binman {
>   		multiple-images;
> @@ -27,28 +31,9 @@
>   
>   #ifdef CONFIG_SPL
>   &binman {
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
> +	fit_template: template-1 {
> +			type = "fit";
>   #ifdef CONFIG_ARM64
>   			description = "FIT image for U-Boot with bl31 (TF-A)";
>   #else
> @@ -56,10 +41,8 @@
>   #endif
>   			#address-cells = <1>;
>   			fit,fdt-list = "of-list";
> -			filename = "u-boot.itb";
>   			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
>   			fit,align = <512>;
> -			offset = <CONFIG_SPL_PAD_TO>;
>   			images {
>   				u-boot {
>   					description = "U-Boot";
> @@ -164,12 +147,38 @@
>   					fit,loadables;
>   				};
>   			};
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
>   		};
> +
> +#ifdef HAS_FIT
> +		fit {
> +			filename = "u-boot.itb";
> +			insert-template = <&fit_template>;
>   #else
>   		u-boot-img {
> +#endif
>   			offset = <CONFIG_SPL_PAD_TO>;
>   		};
> -#endif
>   
>   		fdtmap {
>   		};
> @@ -196,7 +205,7 @@
>   			};
>   		};
>   
> -#if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)
> +#ifdef HAS_FIT
>   		fit {
>   			type = "blob";
>   			filename = "u-boot.itb";
