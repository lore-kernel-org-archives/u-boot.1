Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF0FC36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E75A682B7C;
	Sun,  6 Apr 2025 17:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="CAZ5KqTj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 132CD82ABA; Sun,  6 Apr 2025 17:34:13 +0200 (CEST)
Received: from mail-m19731103.qiye.163.com (mail-m19731103.qiye.163.com
 [220.197.31.103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37AE082B9D
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10d0680e0;
 Sun, 6 Apr 2025 23:34:06 +0800 (GMT+08:00)
Message-ID: <66797cb4-ff6a-445b-881d-1299c9067d01@rock-chips.com>
Date: Sun, 6 Apr 2025 23:34:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] rockchip: binman: Support use of crc32 for
 SPL_FIT_SIGNATURE
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki
 <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-10-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250329150626.2879942-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGEsZVkMaSBlCTE1KGktCHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a960bbcd3fd03afkunm10d0680e0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhQ6Lyo6TDJKE0k6GT4CPE0I
 CSwwCStVSlVKTE9IQk5ITU9MSE5LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTEhVSVlXWQgBWUFISEpONwY+
DKIM-Signature: a=rsa-sha256;
 b=CAZ5KqTjF4t+8m2wfHWrjew4oYt5ovq8/NLkXEGbtOTjoYp2itUd9AYK+9CCwRXGuceXi9HfhNNSdmiJfaKOXcLbjxYYg+j6FWXByBBJbREIDSAiM9Vi0rRKBtLFw8zM/m6riZCTY48NldKnc+tTUqx5Cbnf0lw03kDVJfSl62s=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=IXhsPi4zVNge2j9X90k1GHsKlfCQYVVUBcqN6VuT8y4=;
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
> Use of SHA256 checksum validation on ARMv7 SoCs can be very time
> consuming compared to ARMv8 SoCs with Crypto Extensions.
>
> Add support for use of the crc32 hash algo when SHA256 is not supported.
> Also use a HAS_HASH to simplify the ifdefs when no known hash algo is
> compiled.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v4:
> - New patch
> ---
>   arch/arm/dts/rockchip-u-boot.dtsi | 30 ++++++++++++++++++++----------
>   1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 65b81bf58626..0dfd45bb9bed 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -19,10 +19,20 @@
>   #define COMP	"none"
>   #endif
>   
> +#if defined(CONFIG_SPL_SHA256)
> +#define HASH	"sha256"
> +#elif defined(CONFIG_SPL_CRC32)
> +#define HASH	"crc32"
> +#endif
> +
>   #if defined(CONFIG_SPL_FIT) && (defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE))
>   #define HAS_FIT
>   #endif
>   
> +#if defined(CONFIG_SPL_FIT_SIGNATURE) && defined(HASH)
> +#define HAS_HASH
> +#endif
> +
>   / {
>   	binman: binman {
>   		multiple-images;
> @@ -55,9 +65,9 @@
>   				u-boot-nodtb {
>   					compress = COMP;
>   				};
> -#ifdef CONFIG_SPL_FIT_SIGNATURE
> +#ifdef HAS_HASH
>   				hash {
> -					algo = "sha256";
> +					algo = HASH;
>   				};
>   #endif
>   			};
> @@ -76,9 +86,9 @@
>   
>   				atf-bl31 {
>   				};
> -#ifdef CONFIG_SPL_FIT_SIGNATURE
> +#ifdef HAS_HASH
>   				hash {
> -					algo = "sha256";
> +					algo = HASH;
>   				};
>   #endif
>   			};
> @@ -96,9 +106,9 @@
>   				tee-os {
>   					optional;
>   				};
> -#ifdef CONFIG_SPL_FIT_SIGNATURE
> +#ifdef HAS_HASH
>   				hash {
> -					algo = "sha256";
> +					algo = HASH;
>   				};
>   #endif
>   			};
> @@ -114,9 +124,9 @@
>   
>   				tee-os {
>   				};
> -#ifdef CONFIG_SPL_FIT_SIGNATURE
> +#ifdef HAS_HASH
>   				hash {
> -					algo = "sha256";
> +					algo = HASH;
>   				};
>   #endif
>   			};
> @@ -126,9 +136,9 @@
>   				description = "fdt-NAME";
>   				compression = "none";
>   				type = "flat_dt";
> -#ifdef CONFIG_SPL_FIT_SIGNATURE
> +#ifdef HAS_HASH
>   				hash {
> -					algo = "sha256";
> +					algo = HASH;
>   				};
>   #endif
>   			};
