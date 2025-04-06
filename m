Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A14BC36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B17B82B63;
	Sun,  6 Apr 2025 17:18:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ft2m3QkO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 069A082BA2; Sun,  6 Apr 2025 17:18:24 +0200 (CEST)
Received: from mail-m19731111.qiye.163.com (mail-m19731111.qiye.163.com
 [220.197.31.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CCB882B4A
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10d020669;
 Sun, 6 Apr 2025 23:18:16 +0800 (GMT+08:00)
Message-ID: <1c146d41-b25e-40e2-87e4-cebf475b5ee7@rock-chips.com>
Date: Sun, 6 Apr 2025 23:18:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] rockchip: binman: Factor out arch and compression
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki
 <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250329150626.2879942-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHh9JVk9LSh9MSxlMGh1KGFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a960bae54b703afkunm10d020669
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MyI6PBw*AjIDPUlNGk4DMy0X
 IigaFDBVSlVKTE9IQk5JTUJMQ0JJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTEhVSVlXWQgBWUFIQ0pKNwY+
DKIM-Signature: a=rsa-sha256;
 b=ft2m3QkOyqTdr/zgHO4cH6hkOdx9pJTYRaMGWmC0CUV487+38KNmW0dtQMPTuK+y5SAaUG+iKtaGPwcdWzgi9d9+jHQ4lVMZ5Z+lFxhx21yLjDtI5lKp+bl6o2tMIQKxR4O6wQF184GWIZtfJAZDHiWrtKECYNCzY7VCb3LksE8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=lRj3avsCN4BJatVgv7V8EqHiUSU31VlCG9Xy78fN8mY=;
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
> Declare arch and compression at the top of the file to avoid needing
> ifdefs in every usage.
>
> Add a few comments to help with the remaining #ifdefs.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v4:
> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
> ---
>   arch/arm/dts/rockchip-u-boot.dtsi | 44 +++++++++++++++----------------
>   1 file changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index e9ed1d4b5738..2b01dc660562 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -5,6 +5,20 @@
>   
>   #include <config.h>
>   
> +#ifdef CONFIG_ARM64
> +#define ARCH	"arm64"
> +#else
> +#define ARCH	"arm"
> +#endif
> +
> +#if defined(CONFIG_SPL_GZIP)
> +#define COMP	"gzip"
> +#elif defined(CONFIG_SPL_LZMA)
> +#define COMP	"lzma"
> +#else
> +#define COMP	"none"
> +#endif
> +
>   / {
>   	binman: binman {
>   		multiple-images;
> @@ -51,26 +65,12 @@
>   					description = "U-Boot";
>   					type = "standalone";
>   					os = "u-boot";
> -#ifdef CONFIG_ARM64
> -					arch = "arm64";
> -#else
> -					arch = "arm";
> -#endif
> -#if defined(CONFIG_SPL_GZIP)
> -					compression = "gzip";
> -#elif defined(CONFIG_SPL_LZMA)
> -					compression = "lzma";
> -#else
> -					compression = "none";
> -#endif
> +					arch = ARCH;
> +					compression = COMP;
>   					load = <CONFIG_TEXT_BASE>;
>   					entry = <CONFIG_TEXT_BASE>;
>   					u-boot-nodtb {
> -#if defined(CONFIG_SPL_GZIP)
> -					compress = "gzip";
> -#elif defined(CONFIG_SPL_LZMA)
> -					compress = "lzma";
> -#endif
> +					compress = COMP;
>   					};
>   #ifdef CONFIG_SPL_FIT_SIGNATURE
>   					hash {
> @@ -84,7 +84,7 @@
>   					fit,operation = "split-elf";
>   					description = "ARM Trusted Firmware";
>   					type = "firmware";
> -					arch = "arm64";
> +					arch = ARCH;
>   					os = "arm-trusted-firmware";
>   					compression = "none";
>   					fit,load;
> @@ -103,7 +103,7 @@
>   					fit,operation = "split-elf";
>   					description = "TEE";
>   					type = "tee";
> -					arch = "arm64";
> +					arch = ARCH;
>   					os = "tee";
>   					compression = "none";
>   					fit,load;
> @@ -119,11 +119,11 @@
>   					};
>   #endif
>   				};
> -#else
> +#else /* !CONFIG_ARM64 */
>   				op-tee {
>   					description = "OP-TEE";
>   					type = "tee";
> -					arch = "arm";
> +					arch = ARCH;
>   					os = "tee";
>   					compression = "none";
>   					load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
> @@ -137,7 +137,7 @@
>   					};
>   #endif
>   				};
> -#endif
> +#endif /* CONFIG_ARM64 */
>   
>   				@fdt-SEQ {
>   					description = "fdt-NAME";
