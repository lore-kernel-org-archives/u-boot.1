Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F53C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 22:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6942680104;
	Wed,  5 Feb 2025 23:25:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="M/6sQAat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5906880562; Wed,  5 Feb 2025 23:25:11 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D58E0800CF
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 23:25:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9fbe=U5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738794307;
 bh=VHhLJrZRg1XSuQIt/vd9ECgREkK0rNu9qzuMW/0dM+I=;
 b=M/6sQAatDQTvrJKoyZ8Ko3UM6BKn+ugHuNKCr0Z2scRPzrDjxhQgMPaKLmZfutBDvEgkWHTdT
 jQiKwgfetZ4hAUcktZQIHQVOBOfcfqOg4hxNVXQrQ/NfejoedToZSqkfJDRsVKkt8Vzg33rtLRc
 3DnM3vdWHt1Z4UX7I7NXl9YW1AjmsAX6+KdJ94D6f3appY12B9Pamaw654WsiNukpIAy0Z5hpPg
 Mcg2gCCmyosP75fuMJfDehn8rl3S8G0SvVcXEh3WR/EQi7Gh8uWq8NQakaY9xk+C0976L1cPJvP
 msuqxTcJ2FPeew1zABQ3dXyxAcJ3JUQjLTh7NJd5Wp3A==
X-Forward-Email-ID: 67a3e5424f7eea50c61f49d9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c86d71df-9747-4534-ad2d-8ef0c639b9d4@kwiboo.se>
Date: Wed, 5 Feb 2025 23:25:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/29] rockchip: dts: Factor out arch and compression
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-7-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250205015606.2686149-7-sjg@chromium.org>
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
> Declare these at the top of the file to avoid needing #ifdefs in every
> usage.
> 
> Add a few comments to help with the remaining #ifdefs
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

This patch should happen after the os = "U-Boot" fix if they are part of
same series, fixes before features/enhancements, with that:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> ---
> 
>  arch/arm/dts/rockchip-u-boot.dtsi | 44 +++++++++++++++----------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index c8c928c7e50..8d6b2184f43 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -5,6 +5,20 @@
>  
>  #include <config.h>
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
>  / {
>  	binman: binman {
>  		multiple-images;
> @@ -51,26 +65,12 @@
>  					description = "U-Boot";
>  					type = "standalone";
>  					os = "U-Boot";
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
>  					load = <CONFIG_TEXT_BASE>;
>  					entry = <CONFIG_TEXT_BASE>;
>  					u-boot-nodtb {
> -#if defined(CONFIG_SPL_GZIP)
> -					compress = "gzip";
> -#elif defined(CONFIG_SPL_LZMA)
> -					compress = "lzma";
> -#endif
> +					compress = COMP;
>  					};
>  #ifdef CONFIG_SPL_FIT_SIGNATURE
>  					hash {
> @@ -84,7 +84,7 @@
>  					fit,operation = "split-elf";
>  					description = "ARM Trusted Firmware";
>  					type = "firmware";
> -					arch = "arm64";
> +					arch = ARCH;
>  					os = "arm-trusted-firmware";
>  					compression = "none";
>  					fit,load;
> @@ -103,7 +103,7 @@
>  					fit,operation = "split-elf";
>  					description = "TEE";
>  					type = "tee";
> -					arch = "arm64";
> +					arch = ARCH;
>  					os = "tee";
>  					compression = "none";
>  					fit,load;
> @@ -119,11 +119,11 @@
>  					};
>  #endif
>  				};
> -#else
> +#else /* !CONFIG_ARM64 */
>  				op-tee {
>  					description = "OP-TEE";
>  					type = "tee";
> -					arch = "arm";
> +					arch = ARCH;
>  					os = "tee";
>  					compression = "none";
>  					load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
> @@ -137,7 +137,7 @@
>  					};
>  #endif
>  				};
> -#endif
> +#endif /* CONFIG_ARM64 */
>  
>  				@fdt-SEQ {
>  					description = "fdt-NAME";

