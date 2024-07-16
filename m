Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E8DC3DA4B
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 01:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 009CF88934;
	Tue, 16 Jul 2024 03:56:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Vc5jh+zm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 665BB8887A; Tue, 16 Jul 2024 03:56:09 +0200 (CEST)
Received: from mail-m1973197.qiye.163.com (mail-m1973197.qiye.163.com
 [220.197.31.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B21388887A
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 03:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Vc5jh+zmtmnUAnH9td3ptlPcAuGgfGuVoDODlOQ4N6UehprB3w9FJdWDj6JZG2QUmRNbfwDMMe7OB4ddWow2E7s7pN5KzoLPO+qmSrsWaDOvEDr3azukYaYAaiRc+q0DMYGsPAGzvCV9TNITokEiAYMdjCzJQpR7yQgg3/2ZBrA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=03jnxFyeIQmtSeSTg81G5DZd3/8u1IH7uW23aZrv6Xk=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 39C87900397;
 Tue, 16 Jul 2024 09:55:51 +0800 (CST)
Message-ID: <41287016-39ab-4805-b98e-e088986f7075@rock-chips.com>
Date: Tue, 16 Jul 2024 09:55:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 3/4] rockchip: px30: imply ARMV8_CRYPTO
To: Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger
 <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240614-ringneck-no-gadget-v1-0-d3bc6e5088de@cherry.de>
 <20240614-ringneck-no-gadget-v1-3-d3bc6e5088de@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240614-ringneck-no-gadget-v1-3-d3bc6e5088de@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkhOGFZNHkIYHk1KS0gaHUpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b940d2b003a9kunm39c87900397
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhA6OCo5TDI5SRgDGjMTEQoK
 PxcwCx9VSlVKTElKS0JPQk5JS0pCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIS0hKNwY+
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


On 2024/6/14 19:04, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> PX30 supports ARMv8 Cryptography Extensions so let's enable it by
> default for all PX30 to make FIT verification when enabled much faster.
>
> While A35 shouldn't be impacted by ARMV8_SET_SMPEN cache coherency
> according to the Kconfig help text, let's enable it just in case since
> it exists in the documentation[1].
>
> For u-boot part of the FIT image, it is now taking 5ms against currently
> 35ms. fdt-1 check lowered from 3ms to <1ms. atf-1 from 6ms to <1ms.
>
> [1] https://developer.arm.com/documentation/100236/0100/register-descriptions/aarch64-system-registers/cpu-extended-control-register--el1?lang=en
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 14b3ab1a572..2242ed9184b 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -16,6 +16,8 @@ config ROCKCHIP_PX30
>   	select DEBUG_UART_BOARD_INIT
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply SPL_ROCKCHIP_COMMON_BOARD
> +	imply ARMV8_CRYPTO
> +	imply ARMV8_SET_SMPEN
>   	help
>   	  The Rockchip PX30 is a ARM-based SoC with a quad-core Cortex-A35
>   	  including NEON and GPU, Mali-400 graphics, several DDR3 options
>
