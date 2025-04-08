Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478DBC36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 00:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E00883032;
	Tue,  8 Apr 2025 02:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="UQOn+n8w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7523983032; Tue,  8 Apr 2025 02:49:20 +0200 (CEST)
Received: from mail-m3295.qiye.163.com (mail-m3295.qiye.163.com
 [220.197.32.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB39C83028
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 02:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10fbbe930;
 Tue, 8 Apr 2025 08:49:08 +0800 (GMT+08:00)
Message-ID: <8a7e59e8-60c4-4aaf-bd86-9531583b103b@rock-chips.com>
Date: Tue, 8 Apr 2025 08:49:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] rockchip: Move imply TPL_ROCKCHIP_COMMON_BOARD
 under SoC Kconfig symbol
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Alex Bee <knaerzche@gmail.com>, u-boot@lists.denx.de
References: <20250220215709.407413-1-jonas@kwiboo.se>
 <20250220215709.407413-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250220215709.407413-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSU1LVk5KSRkYTkpJTk4fH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9612df57a503afkunm10fbbe930
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006Ngw6LTICA0MLEBYuSgg8
 CBUaCU1VSlVKTE9PS0xISE5LTkNIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlCQ0k3Bg++
DKIM-Signature: a=rsa-sha256;
 b=UQOn+n8wmi0hXX/PDEmmuuMg/WKTXMKLiGcNbqlNeAiZFJe/ebaENFTy54HYq4Eqxm6AuH0eWDoZ+e7DqakYZvX+U08sbm6ULs6x6cShTH7lY57S/pPQWQfg0S7+Lkeg2YOVu0HnBZfm8Vt64AoCG2BqpK18FFS1e5H1XmSBki4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=/R4TQJOthxYHVLm+XzW9Cy2iv/btlg1dw0kifZ81PJA=;
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


On 2025/2/21 05:56, Jonas Karlman wrote:
> The Kconfig symbol ROCKCHIP_COMMON_STACK_ADDR currently imply the
> TPL_ROCKCHIP_COMMON_BOARD option when TPL=y. This is inconvenient for a
> SoC with very limited SRAM to use a custom tpl.c together with the
> common stack addresses.
>
> Move any imply TPL_ROCKCHIP_COMMON_BOARD to under the SoC symbol, where
> it belongs. Add the missing imply to RK3328 and PX30 use a SoC specific
> tpl.c and only expect imply TPL_LIBGENERIC_SUPPORT.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   arch/arm/mach-rockchip/Kconfig | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index adac11a6b89c..bb5d009a1c34 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -16,6 +16,7 @@ config ROCKCHIP_PX30
>   	select DEBUG_UART_BOARD_INIT
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply SPL_ROCKCHIP_COMMON_BOARD
> +	imply TPL_LIBGENERIC_SUPPORT
>   	imply ARMV8_CRYPTO
>   	imply ARMV8_SET_SMPEN
>   	help
> @@ -213,6 +214,7 @@ config ROCKCHIP_RK3328
>   	imply SPL_ROCKCHIP_COMMON_BOARD
>   	imply SPL_SEPARATE_BSS
>   	imply SPL_SERIAL
> +	imply TPL_ROCKCHIP_COMMON_BOARD
>   	imply TPL_SERIAL
>   	help
>   	  The Rockchip RK3328 is a ARM-based SoC with a quad-core Cortex-A53.
> @@ -609,11 +611,10 @@ config ROCKCHIP_COMMON_STACK_ADDR
>   	imply SPL_ROCKCHIP_COMMON_BOARD if SPL
>   	imply SPL_SYS_MALLOC_F if SPL
>   	imply SPL_SYS_MALLOC_SIMPLE if SPL
> -	imply TPL_LIBCOMMON_SUPPORT if TPL
> -	imply TPL_LIBGENERIC_SUPPORT if TPL
> -	imply TPL_ROCKCHIP_COMMON_BOARD if TPL
> -	imply TPL_SYS_MALLOC_F if TPL
> -	imply TPL_SYS_MALLOC_SIMPLE if TPL
> +	imply TPL_LIBCOMMON_SUPPORT if TPL && TPL_ROCKCHIP_COMMON_BOARD
> +	imply TPL_LIBGENERIC_SUPPORT if TPL && TPL_ROCKCHIP_COMMON_BOARD
> +	imply TPL_SYS_MALLOC_F if TPL && TPL_ROCKCHIP_COMMON_BOARD
> +	imply TPL_SYS_MALLOC_SIMPLE if TPL && TPL_ROCKCHIP_COMMON_BOARD
>   
>   config NR_DRAM_BANKS
>   	default 10 if ROCKCHIP_EXTERNAL_TPL
