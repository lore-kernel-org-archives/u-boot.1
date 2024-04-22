Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41216C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F1538835D;
	Mon, 22 Apr 2024 10:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="HFjocVrp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D048588362; Mon, 22 Apr 2024 10:23:59 +0200 (CEST)
Received: from mail-m254101.xmail.ntesmail.com
 (mail-m254101.xmail.ntesmail.com [103.129.254.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 150B488350
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=HFjocVrp73FT2c9+KFuqpbADQ29n+6bfE3aa5f0Lmnqt36MHDkh9atRM/hL3/itUvf0w5lIEyCaJgAXonVr747vthhqnSpUhjH4gQNBUk9Db0VDGkFec1Qn/xqQ0uTIoKC7aq+AOdFnaF+UoBJMYrmfem6DiyQiCYF6GFgTt0EM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=FG4AxV5UTBWqJWHNF+DZQeLFfBCs9gncGXbml5IUXUA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 7882A9002FB;
 Mon, 22 Apr 2024 16:23:47 +0800 (CST)
Message-ID: <9d862fda-6030-4efc-b974-8e40e8a9477d@rock-chips.com>
Date: Mon, 22 Apr 2024 16:23:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rockchip: rk3328: Sort imply statements
 alphabetically
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240421200908.518855-1-jonas@kwiboo.se>
 <20240421200908.518855-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240421200908.518855-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkpIHlYdGk5JSxgeTRkdTx5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04e7712003a9kunm7882a9002fb
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mz46KRw6AzMDFDoITBdNCR5R
 NB9PC01VSlVKTEpITExPSUlDSUhMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTENINwY+
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


On 2024/4/22 04:09, Jonas Karlman wrote:
> Sort imply statements under ROCKCHIP_RK3328 alphabetically and remove
> ENABLE_ARM_SOC_BOOT0_HOOK, DEBUG_UART_BOARD_INIT and SYS_NS16550, they
> are already implyed or selected by ARCH_ROCKCHIP.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever

> ---
> v2: No change, rebase on latest master bransh
> ---
>   arch/arm/mach-rockchip/Kconfig | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 4f22d9bde9f9..ee0f338995b9 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -180,19 +180,16 @@ config ROCKCHIP_RK3328
>   	select SUPPORT_TPL
>   	select TPL
>   	select TPL_NEEDS_SEPARATE_STACK if TPL
> +	imply MISC
> +	imply MISC_INIT_R
>   	imply PRE_CONSOLE_BUFFER
>   	imply ROCKCHIP_COMMON_BOARD
> +	imply ROCKCHIP_EFUSE
>   	imply ROCKCHIP_SDRAM_COMMON
>   	imply SPL_ROCKCHIP_COMMON_BOARD
> +	imply SPL_SEPARATE_BSS
>   	imply SPL_SERIAL
>   	imply TPL_SERIAL
> -	imply SPL_SEPARATE_BSS
> -	select ENABLE_ARM_SOC_BOOT0_HOOK
> -	select DEBUG_UART_BOARD_INIT
> -	select SYS_NS16550
> -	imply MISC
> -	imply ROCKCHIP_EFUSE
> -	imply MISC_INIT_R
>   	help
>   	  The Rockchip RK3328 is a ARM-based SoC with a quad-core Cortex-A53.
>   	  including NEON and GPU, 1MB L2 cache, Mali-T7 graphics, two
