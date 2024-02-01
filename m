Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53ECC47DB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 02:49:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DC2187C1F;
	Thu,  1 Feb 2024 03:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DP7mUNCy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 498E387C49; Thu,  1 Feb 2024 03:49:21 +0100 (CET)
Received: from mail-m19731111.qiye.163.com (mail-m19731111.qiye.163.com
 [220.197.31.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBC7087C1F
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 03:49:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=DP7mUNCyihK9xDGkyCcyNfvVkhOUEZHu6UwJgz535l+zkzRDR9r24Ck160AOKFH3WgILWZet+Qd+1Q4rvNpAi0jXEeyT00d+7dlH1o/zI/ZW8T7l9bzJnGThjZ8ERLlpQFAar7AV8b2V36FCkhfQD00xaosrhTwOb9LgdwEg3uo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=A/Bon5pb1a8SqNRsJDzWfVAba925IsQjihs63XRP9fg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A4C189001E2;
 Thu,  1 Feb 2024 10:49:05 +0800 (CST)
Message-ID: <bd6d0b73-1e93-442e-b5fa-dffac0522d8e@rock-chips.com>
Date: Thu, 1 Feb 2024 10:49:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] rockchip: theobroma-systems: puma: migrate to
 rockchip_early_misc_init_r
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
 <20240123-jaguar-v1-9-1eec1c34953c@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240123-jaguar-v1-9-1eec1c34953c@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUhOHlZLTUxOTh5JTUtIHhpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d6291ef5403a9kunma4c189001e2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pyo6Ngw*OjMVMk0VUQ8IDCNJ
 LwkKCT9VSlVKTEtNTE5OTE9DS05MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTEtONwY+
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
> Only setup_iodomain() and setup_boottargets differ from the original
> misc_init_r from Rockchip mach code, so let's use
> rockchip_early_misc_init_r instead of reimplementing the whole
> misc_init_r from Rockchip.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/theobroma-systems/puma_rk3399/puma-rk3399.c | 20 +-------------------
>   1 file changed, 1 insertion(+), 19 deletions(-)
>
> diff --git a/board/theobroma-systems/puma_rk3399/puma-rk3399.c b/board/theobroma-systems/puma_rk3399/puma-rk3399.c
> index a82f97b2d54..98a818b135d 100644
> --- a/board/theobroma-systems/puma_rk3399/puma-rk3399.c
> +++ b/board/theobroma-systems/puma_rk3399/puma-rk3399.c
> @@ -10,7 +10,6 @@
>   #include <asm/arch-rockchip/clock.h>
>   #include <asm/arch-rockchip/hardware.h>
>   #include <asm/arch-rockchip/grf_rk3399.h>
> -#include <asm/arch-rockchip/misc.h>
>   #include "../common/common.h"
>   
>   static void setup_iodomain(void)
> @@ -27,25 +26,8 @@ static void setup_iodomain(void)
>   	rk_setreg(&grf->io_vsel, 1 << GRF_IO_VSEL_GPIO4CD_SHIFT);
>   }
>   
> -int misc_init_r(void)
> +int rockchip_early_misc_init_r(void)
>   {
> -	const u32 cpuid_offset = 0x7;
> -	const u32 cpuid_length = 0x10;
> -	u8 cpuid[cpuid_length];
> -	int ret;
> -
> -	ret = rockchip_cpuid_from_efuse(cpuid_offset, cpuid_length, cpuid);
> -	if (ret)
> -		return ret;
> -
> -	ret = rockchip_cpuid_set(cpuid, cpuid_length);
> -	if (ret)
> -		return ret;
> -
> -	ret = rockchip_setup_macaddr();
> -	if (ret)
> -		return ret;
> -
>   	setup_iodomain();
>   	setup_boottargets();
>   
>
