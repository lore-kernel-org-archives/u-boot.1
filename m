Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F85C47DB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 02:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 403A787BF4;
	Thu,  1 Feb 2024 03:58:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OAusDebr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1447D87BFC; Thu,  1 Feb 2024 03:58:47 +0100 (CET)
Received: from mail-m17205.xmail.ntesmail.com (mail-m17205.xmail.ntesmail.com
 [45.195.17.205])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85CA78760D
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 03:58:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=OAusDebrhSp3uepAlr5TCymgOIFCIfKcrye1TVpt4Cjhzm1WSjmJdSOVy2De0kY11GISm7ddekbQAECTtSIbJ3lTGcS4u8qyBR90j1f1r0clsrjQBGiWkDc6DvHLCJp1xr9QCrwydwdgWJ1S2DK86w4bnodqLXHtSp9+E4X9QLs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=dcnB6VRDSLWuM+5efW3VZaICqk71RGFRO6k5S1bW64s=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id CE6AE900112;
 Thu,  1 Feb 2024 10:58:29 +0800 (CST)
Message-ID: <88e5e2b2-711f-4205-ba70-27cdeb4f3581@rock-chips.com>
Date: Thu, 1 Feb 2024 10:58:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/18] rockchip: rk3588: add constants for some register
 address spaces
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
 <20240123-jaguar-v1-14-1eec1c34953c@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240123-jaguar-v1-14-1eec1c34953c@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGksZSFZOS0kdQkMdHh1MShpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d629a87ac03a9kunmce6ae900112
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORw6Nww4IjMLUU1DLSkOTTJW
 AyNPCxZVSlVKTEtNTE5NSEpKSENOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNSU1LNwY+
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
> It's one thing to have the register mapped via a well-defined struct but
> it's another to be able to make use of it. For that to happen, one needs
> to cast the physical address memory of the beginning of the register
> address space with the struct. Since this cannot change, let's hardcode
> it in the include files so that users do not need to duplicate this line
> of code in their own implementation.
Usually only one place using these base address when the dts is not 
using, so it's not a
big issue to define at where it's used.


Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever

>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>   arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 2 ++
>   arch/arm/include/asm/arch-rockchip/ioc_rk3588.h | 6 ++++++
>   arch/arm/mach-rockchip/rk3588/rk3588.c          | 4 ----
>   3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> index 7f4a9085392..a4507e5fdd7 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> @@ -63,6 +63,8 @@ struct rk3588_pll {
>   	unsigned int reserved0[3];
>   };
>   
> +#define CRU_BASE	0xfd7c0000
> +
>   struct rk3588_cru {
>   	struct rk3588_pll pll[18];
>   	unsigned int reserved0[16];/* Address Offset: 0x0240 */
> diff --git a/arch/arm/include/asm/arch-rockchip/ioc_rk3588.h b/arch/arm/include/asm/arch-rockchip/ioc_rk3588.h
> index 5a656f850c7..7ad98466c39 100644
> --- a/arch/arm/include/asm/arch-rockchip/ioc_rk3588.h
> +++ b/arch/arm/include/asm/arch-rockchip/ioc_rk3588.h
> @@ -5,6 +5,8 @@
>   #ifndef _ASM_ARCH_IOC_RK3588_H
>   #define _ASM_ARCH_IOC_RK3588_H
>   
> +#define BUS_IOC_BASE	0xfd5f8000
> +
>   struct rk3588_bus_ioc {
>   	unsigned int reserved0000[3];      /* Address Offset: 0x0000 */
>   	unsigned int gpio0b_iomux_sel_h;   /* Address Offset: 0x000C */
> @@ -48,6 +50,8 @@ struct rk3588_bus_ioc {
>   
>   check_member(rk3588_bus_ioc, gpio4d_iomux_sel_h, 0x009C);
>   
> +#define PMU1_IOC_BASE	0xfd5f0000
> +
>   struct rk3588_pmu1_ioc {
>   	unsigned int gpio0a_iomux_sel_l;   /* Address Offset: 0x0000 */
>   	unsigned int gpio0a_iomux_sel_h;   /* Address Offset: 0x0004 */
> @@ -70,6 +74,8 @@ struct rk3588_pmu1_ioc {
>   
>   check_member(rk3588_pmu1_ioc, xin_con, 0x0040);
>   
> +#define PMU2_IOC_BASE	0xfd5f4000
> +
>   struct rk3588_pmu2_ioc {
>   	unsigned int gpio0b_iomux_sel_h;  /* Address Offset: 0x0000 */
>   	unsigned int gpio0c_iomux_sel_l;  /* Address Offset: 0x0004 */
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index c5eeda9d751..53ee9f1cebc 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -26,10 +26,6 @@
>   #define FW_SYSM_MST26_REG		0xa8
>   #define FW_SYSM_MST27_REG		0xac
>   
> -#define PMU1_IOC_BASE			0xfd5f0000
> -#define PMU2_IOC_BASE			0xfd5f4000
> -
> -#define BUS_IOC_BASE			0xfd5f8000
>   #define BUS_IOC_GPIO2A_IOMUX_SEL_L	0x40
>   #define BUS_IOC_GPIO2B_IOMUX_SEL_L	0x48
>   #define BUS_IOC_GPIO2D_IOMUX_SEL_L	0x58
>
