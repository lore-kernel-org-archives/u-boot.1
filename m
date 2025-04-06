Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E419C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08DCE82B4A;
	Sun,  6 Apr 2025 17:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Yp8DoV4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2502082B7C; Sun,  6 Apr 2025 17:33:22 +0200 (CEST)
Received: from mail-m1973189.qiye.163.com (mail-m1973189.qiye.163.com
 [220.197.31.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFBBA82A96
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10d0680c1;
 Sun, 6 Apr 2025 23:33:12 +0800 (GMT+08:00)
Message-ID: <825f38d8-e095-49bd-ab20-a7f02913198a@rock-chips.com>
Date: Sun, 6 Apr 2025 23:33:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] rockchip: binman: Un-indent the FIT template
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki
 <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250329150626.2879942-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSR8aVh9PGUoZHxhDTBpCGFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a960bbc03c703afkunm10d0680c1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQg6TCo5LjIBKUkKGTMrPBwW
 ECswChdVSlVKTE9IQk5ITkJPS0JOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTEhVSVlXWQgBWUFNT0xPNwY+
DKIM-Signature: a=rsa-sha256;
 b=Yp8DoV4iE+ZZpJaoTXnDB1fA9OiwKCP3Z8/cxLAC60ZvF7PIEdz0YBsVMTD+XQT2Hvo0CucZqt/ZbvztjckWdyd4p1e77B8HVVDvLCKl4SsB/gftL5/aUqVN1iorM0tN/mJB4oM6gD8k9M3xpVQp3QteIFHj3+vLpbnF7xkq3iA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=iBUfo/uJjyK0H3XdTeWjN0eHHLk0AMr4N926g2BuKII=;
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
> Fix the indentation on the template. This is done in a separate patch
> so that it is easier to review.
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
>   arch/arm/dts/rockchip-u-boot.dtsi | 176 +++++++++++++++---------------
>   1 file changed, 88 insertions(+), 88 deletions(-)
>
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 9ef1ca6cd13a..f860bfc1ba72 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -33,120 +33,120 @@
>   &binman {
>   #ifdef HAS_FIT
>   	fit_template: template-1 {
> -			type = "fit";
> +		type = "fit";
>   #ifdef CONFIG_ARM64
> -			description = "FIT image for U-Boot with bl31 (TF-A)";
> +		description = "FIT image for U-Boot with bl31 (TF-A)";
>   #else
> -			description = "FIT image with OP-TEE";
> +		description = "FIT image with OP-TEE";
>   #endif
> -			#address-cells = <1>;
> -			fit,fdt-list = "of-list";
> -			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
> -			fit,align = <512>;
> -			images {
> -				u-boot {
> -					description = "U-Boot";
> -					type = "standalone";
> -					os = "u-boot";
> -					arch = ARCH;
> -					compression = COMP;
> -					load = <CONFIG_TEXT_BASE>;
> -					entry = <CONFIG_TEXT_BASE>;
> -					u-boot-nodtb {
> +		#address-cells = <1>;
> +		fit,fdt-list = "of-list";
> +		fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
> +		fit,align = <512>;
> +		images {
> +			u-boot {
> +				description = "U-Boot";
> +				type = "standalone";
> +				os = "u-boot";
> +				arch = ARCH;
> +				compression = COMP;
> +				load = <CONFIG_TEXT_BASE>;
> +				entry = <CONFIG_TEXT_BASE>;
> +				u-boot-nodtb {
>   					compress = COMP;
> -					};
> +				};
>   #ifdef CONFIG_SPL_FIT_SIGNATURE
> -					hash {
> -						algo = "sha256";
> -					};
> -#endif
> +				hash {
> +					algo = "sha256";
>   				};
> +#endif
> +			};
>   
>   #ifdef CONFIG_ARM64
> -				@atf-SEQ {
> -					fit,operation = "split-elf";
> -					description = "ARM Trusted Firmware";
> -					type = "firmware";
> -					arch = ARCH;
> -					os = "arm-trusted-firmware";
> -					compression = "none";
> -					fit,load;
> -					fit,entry;
> -					fit,data;
> -
> -					atf-bl31 {
> -					};
> +			@atf-SEQ {
> +				fit,operation = "split-elf";
> +				description = "ARM Trusted Firmware";
> +				type = "firmware";
> +				arch = ARCH;
> +				os = "arm-trusted-firmware";
> +				compression = "none";
> +				fit,load;
> +				fit,entry;
> +				fit,data;
> +
> +				atf-bl31 {
> +				};
>   #ifdef CONFIG_SPL_FIT_SIGNATURE
> -					hash {
> -						algo = "sha256";
> -					};
> +				hash {
> +					algo = "sha256";
> +				};
>   #endif
> +			};
> +			@tee-SEQ {
> +				fit,operation = "split-elf";
> +				description = "TEE";
> +				type = "tee";
> +				arch = ARCH;
> +				os = "tee";
> +				compression = "none";
> +				fit,load;
> +				fit,entry;
> +				fit,data;
> +
> +				tee-os {
> +					optional;
>   				};
> -				@tee-SEQ {
> -					fit,operation = "split-elf";
> -					description = "TEE";
> -					type = "tee";
> -					arch = ARCH;
> -					os = "tee";
> -					compression = "none";
> -					fit,load;
> -					fit,entry;
> -					fit,data;
> -
> -					tee-os {
> -						optional;
> -					};
>   #ifdef CONFIG_SPL_FIT_SIGNATURE
> -					hash {
> -						algo = "sha256";
> -					};
> -#endif
> +				hash {
> +					algo = "sha256";
>   				};
> +#endif
> +			};
>   #else /* !CONFIG_ARM64 */
> -				op-tee {
> -					description = "OP-TEE";
> -					type = "tee";
> -					arch = ARCH;
> -					os = "tee";
> -					compression = "none";
> -					load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
> -					entry = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
> -
> -					tee-os {
> -					};
> +			op-tee {
> +				description = "OP-TEE";
> +				type = "tee";
> +				arch = ARCH;
> +				os = "tee";
> +				compression = "none";
> +				load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
> +				entry = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
> +
> +				tee-os {
> +				};
>   #ifdef CONFIG_SPL_FIT_SIGNATURE
> -					hash {
> -						algo = "sha256";
> -					};
> -#endif
> +				hash {
> +					algo = "sha256";
>   				};
> +#endif
> +			};
>   #endif /* CONFIG_ARM64 */
>   
> -				@fdt-SEQ {
> -					description = "fdt-NAME";
> -					compression = "none";
> -					type = "flat_dt";
> +			@fdt-SEQ {
> +				description = "fdt-NAME";
> +				compression = "none";
> +				type = "flat_dt";
>   #ifdef CONFIG_SPL_FIT_SIGNATURE
> -					hash {
> -						algo = "sha256";
> -					};
> -#endif
> +				hash {
> +					algo = "sha256";
>   				};
> +#endif
>   			};
> +		};
>   
> -			configurations {
> -				default = "@config-DEFAULT-SEQ";
> -				@config-SEQ {
> -					description = "NAME.dtb";
> -					fdt = "fdt-SEQ";
> +		configurations {
> +			default = "@config-DEFAULT-SEQ";
> +			@config-SEQ {
> +				description = "NAME.dtb";
> +				fdt = "fdt-SEQ";
>   #ifdef CONFIG_ARM64
> -					fit,firmware = "atf-1", "u-boot";
> +				fit,firmware = "atf-1", "u-boot";
>   #else
> -					fit,firmware = "op-tee", "u-boot";
> +				fit,firmware = "op-tee", "u-boot";
>   #endif
> -					fit,loadables;
> -				};
> +				fit,loadables;
>   			};
> +		};
>   	};
>   #endif /* HAS_FIT */
>   
