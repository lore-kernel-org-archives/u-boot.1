Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EABC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 03:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 566CA88549;
	Thu, 23 May 2024 05:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="fg7cG8nS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5D4C88548; Thu, 23 May 2024 05:48:31 +0200 (CEST)
Received: from mail-m127210.xmail.ntesmail.com
 (mail-m127210.xmail.ntesmail.com [115.236.127.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CA2987F65
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 05:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=fg7cG8nSWyRpY9Vkrso/Qi0Lfmrs5ZhEeJQcZQsmJUvWG+5CVxK6Kpiuxfhf6j7l5uHbiB2XCsu1bOQwpp9IWNdacw0T4LyUrDz7DMShnoNBjCJHKwfVHXFDIKky8LGMNv4u+fw1AnCGtd18G7AttE+ftqePCx2LahR/H57Eeqc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=+IxrGxuVsEXCUC9sFlBmlC0I4x35PlWwhaIu/IqzFck=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id C59439002F5;
 Thu, 23 May 2024 11:48:13 +0800 (CST)
Message-ID: <7a6a55ff-200f-4951-8488-f19a73185cc1@rock-chips.com>
Date: Thu, 23 May 2024 11:48:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] rockchip: Use common bss and stack addresses on PX30
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: jonas@kwiboo.se, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20240521-px30-2024-07-rc-v1-0-62109c84d44f@cherry.de>
 <20240521-px30-2024-07-rc-v1-2-62109c84d44f@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240521-px30-2024-07-rc-v1-2-62109c84d44f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUNMGlYdHhkaH0pNTx9PGhhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fa3904ecb03a9kunmc59439002f5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PS46ECo4AzNLORwVPwIuSw8*
 Qg8aCxxVSlVKTEpNT0hNS0JOS0JLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITkpCNwY+
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


On 2024/5/22 01:39, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> See commit 008ba0d56d00 ("rockchip: Add common default bss and stack
> addresses") for memory layout. This migrates PX30 to use the new layout,
> except for TPL. Indeed, PX30 is extremely limited in SRAM, so we need to
> be extra careful about what goes into the TPL and how much we can
> allocate there, so let's keep the current value for
> TPL_SYS_MALLOC_F_LEN (already present in the PX30-specific Kconfig, from
> an earlier commit).
>
> This will allow us to use the same memory layout on one more Rockchip
> SoC, which is always a nice thing. Additionally, this will make it
> easier to fix U-Boot proper pre-reloc running out of memory on PX30 in a
> subsequent commit.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/px30/Kconfig | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/px30/Kconfig
> index e39472604c3..dcf9eb8144b 100644
> --- a/arch/arm/mach-rockchip/px30/Kconfig
> +++ b/arch/arm/mach-rockchip/px30/Kconfig
> @@ -68,8 +68,11 @@ config ROCKCHIP_STIMER_BASE
>   config SYS_SOC
>   	default "px30"
>   
> +config ROCKCHIP_COMMON_STACK_ADDR
> +	default y
> +
>   config SYS_MALLOC_F_LEN
> -	default 0x400
> +	default 0x400 if !SPL_SHARES_INIT_SP_ADDR
>   
>   config SPL_SERIAL
>   	default y
>
