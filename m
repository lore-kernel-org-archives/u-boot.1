Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D79C47DB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 02:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C270087C68;
	Thu,  1 Feb 2024 03:50:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Nt3I3+uI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33BA887C4B; Thu,  1 Feb 2024 03:50:14 +0100 (CET)
Received: from mail-m49214.qiye.163.com (mail-m49214.qiye.163.com
 [45.254.49.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F22AD87C66
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 03:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Nt3I3+uIo7W2AaTG+Mhs07C8w0XUAlXEVeiyXGFT2vGOnuLNHefUoThRvUrfDqBksGdvqXiu3mVl+7tXStVSRTEhf3epVjZ9yxvV9+M4AmnWHqXvb+lhBZkg6yuWdGOh4gH1kv/z1ZKFX/tD0uCKlz8Q/SYYj3tVS4X0UVSfNEw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=qhVRgg8Bu0tAMBxDxLKO3RWwD59tNfLlpQTS+39aClc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id D15A19001EA;
 Thu,  1 Feb 2024 10:49:56 +0800 (CST)
Message-ID: <f2836ab1-04d2-42c8-a119-c7bf7908ba53@rock-chips.com>
Date: Thu, 1 Feb 2024 10:49:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] rockchip: transform
 rockchip_capsule_update_board_setup into a weak function symbol
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, Andy Yan
 <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>
Cc: heiko@sntech.de, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-12-1eec1c34953c@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240123-jaguar-v1-12-1eec1c34953c@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQktOGlZITU9DHRoYHRpDQx5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d6292b7b103a9kunmd15a19001ea
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6My46Aww4LDMUUU0eLlYMIyk4
 TTYKCxVVSlVKTEtNTE5OTEJCSEpPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPQ0JMNwY+
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


On 2024/1/23 22:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> There's only one user of rockchip_capsule_update_board_setup, which is
> in board.c, and only one board defines it, so instead of having a header
> only for one function symbol, let's just use a weak symbol instead.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/include/asm/arch-rockchip/misc.h | 9 ---------
>   arch/arm/mach-rockchip/board.c            | 5 ++++-
>   2 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/misc.h b/arch/arm/include/asm/arch-rockchip/misc.h
> deleted file mode 100644
> index ef37ff1661a..00000000000
> --- a/arch/arm/include/asm/arch-rockchip/misc.h
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * RK3399: Architecture common definitions
> - *
> - * Copyright (C) 2019 Collabora Inc - https://www.collabora.com/
> - *      Rohan Garg <rohan.garg@collabora.com>
> - */
> -
> -void rockchip_capsule_update_board_setup(void);
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index 80b4514852f..4f666aee706 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -32,7 +32,6 @@
>   #include <asm/arch-rockchip/boot_mode.h>
>   #include <asm/arch-rockchip/clock.h>
>   #include <asm/arch-rockchip/periph.h>
> -#include <asm/arch-rockchip/misc.h>
>   #include <power/regulator.h>
>   
>   #if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
> @@ -148,6 +147,10 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   	env_set("dfu_alt_info", buf);
>   }
>   
> +__weak void rockchip_capsule_update_board_setup(void)
> +{
> +}
> +
>   static void gpt_capsule_update_setup(void)
>   {
>   	int p, i, ret;
>
