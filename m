Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A19C47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 02:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F41F98760D;
	Thu,  1 Feb 2024 03:47:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="EslNXXH9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B52F8760D; Thu,  1 Feb 2024 03:47:50 +0100 (CET)
Received: from mail-m49195.qiye.163.com (mail-m49195.qiye.163.com
 [45.254.49.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3E43875EB
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 03:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=EslNXXH9b1B4bxvcp+cwWaUbUaHG0sJAU7Gmaqo/ju+0aQG80volntCG2HGnXX8TqVBg2UGqaADF0V6xeGOsnimWpd17TscyhBxpyqGf3QDRDdtZskYtnBZ58IoLiXy6AEJ/U4NV9lymYtCAl4Nx1WGP0XoUqVZc1A3k00D59n0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=L+YvRmRkap/VtBVOzrP0TCvFU0RWYHH7O9tL/YwNark=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id AC75F9001B5;
 Thu,  1 Feb 2024 10:47:33 +0800 (CST)
Message-ID: <688f76d1-4186-477b-a500-9e64ab7d0012@rock-chips.com>
Date: Thu, 1 Feb 2024 10:47:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] rockchip: rk3588: use mainline pmu-grf compatible
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
 <20240123-jaguar-v1-1-1eec1c34953c@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240123-jaguar-v1-1-1eec1c34953c@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRhOHVZMSRhNHk1NTUlPGEhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d629084e903a9kunmac75f9001b5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTI6Sjo6DzMcMk0#Lgs6GC0y
 MBIKFA9VSlVKTEtNTE5OTU5OSE9LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTE1INwY+
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
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>
> The compatible for the pmugrf in the mainline kernel is dfferent from the
> one currently used in u-boot. Adapt the -u-boot.dtsi and syscon driver
> to use the correct compatible.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588s-u-boot.dtsi              | 2 +-
>   arch/arm/mach-rockchip/rk3588/syscon_rk3588.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index c0fd16c4022..9a5ffec926e 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -66,7 +66,7 @@
>   
>   	pmu1_grf: syscon@fd58a000 {
>   		bootph-all;
> -		compatible = "rockchip,rk3588-pmu1-grf", "syscon";
> +		compatible = "rockchip,rk3588-pmugrf", "syscon";
>   		reg = <0x0 0xfd58a000 0x0 0x2000>;
>   	};
>   
> diff --git a/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c b/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
> index e8772d3a382..7b2cf37d9da 100644
> --- a/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
> @@ -10,7 +10,7 @@
>   
>   static const struct udevice_id rk3588_syscon_ids[] = {
>   	{ .compatible = "rockchip,rk3588-sys-grf", .data = ROCKCHIP_SYSCON_GRF },
> -	{ .compatible = "rockchip,rk3588-pmu1-grf", .data = ROCKCHIP_SYSCON_PMUGRF },
> +	{ .compatible = "rockchip,rk3588-pmugrf",  .data = ROCKCHIP_SYSCON_PMUGRF },
>   	{ .compatible = "rockchip,rk3588-vop-grf", .data = ROCKCHIP_SYSCON_VOP_GRF },
>   	{ .compatible = "rockchip,rk3588-vo-grf",  .data = ROCKCHIP_SYSCON_VO_GRF },
>   	{ .compatible = "rockchip,pcie30-phy-grf", .data = ROCKCHIP_SYSCON_PCIE30_PHY_GRF },
>
