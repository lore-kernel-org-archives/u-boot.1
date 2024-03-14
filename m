Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2076AC54E5D
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 18:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C46787CF9;
	Thu, 14 Mar 2024 19:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="DdNBoxw9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27A7587CEA; Thu, 14 Mar 2024 19:38:58 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FDD587F19
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 19:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=664e=KV=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1710441518;
 bh=H/lqCz6ZaSjI+73VNqH2/60swT3AXv+IA4O0p1ZoyX4=;
 b=DdNBoxw9C63qQiF80LLx4oKdVydyFD4FrST727VxxZ2my/E+YIL1szvPr0BT9PuwD06ucuI2P
 c8FPwOE/Nc3DAuiXu5Pfaf7SGhjBBWAZvM9HvkdGFdd92XvLsjF7DZ9AjFPHX1Bv5vfmr20YLBs
 ZT4ZNPTGQtqq74NOh4pj8R7fGUzJHCEePYaDHSfr7Z4iByD0dVe/8pWB1EtJDM9g2LmxqzNSpEU
 AJplWDG7GO9rXRM5/JhR6/hn1zOrvXmDDwC5dVfxlK5dAcWwmjsTGM7odPnkfvCuyu0eUj99iBm
 eo5VzUAN7Q9Q2n+uTBrefrsMg7ndbPexgUy70c8HR3fQ==
Message-ID: <55dcdf42-b446-4718-a99a-1e454d14c5cf@kwiboo.se>
Date: Thu, 14 Mar 2024 19:38:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rockchip: Add a board_gen_ethaddr() function
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Fabio Estevam <festevam@denx.de>, u-boot@lists.denx.de
References: <20240314144403.491850-1-detlev.casanova@collabora.com>
 <20240314144403.491850-3-detlev.casanova@collabora.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240314144403.491850-3-detlev.casanova@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f3442ceb942b031758603c
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

Hi Detlev,

On 2024-03-14 15:43, Detlev Casanova wrote:
> Set the MAC address based on the CPU ID only if the ethernet device has
> no ROM or DT address set.

This patch changes behavior and once again require CONFIG_NET to fixup
the device tree with local-mac-address for the ethernet0/1 alias nodes.

I.e. reverts one of the intentions with the commit 628fb0683b65
("rockchip: misc: Set eth1addr mac address"), fixup of ethaddr in DT
should not depend on enabled and working ethernet in U-Boot.

Maybe just having a Kconfig to control if ENV ethaddr should overwrite
ROM ethaddr could as easily solve your issue?

Please also note that misc.c is merging into board.c in another pending
series, see custodian u-boot-rockchip/for-next branch.

> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  arch/arm/Kconfig                          |  1 +
>  arch/arm/include/asm/arch-rockchip/misc.h |  1 +
>  arch/arm/mach-rockchip/board.c            | 30 ++++++++++++++++++-----
>  arch/arm/mach-rockchip/misc.c             | 22 ++++++++++++-----
>  4 files changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 01d6556c42b..21b41675ef6 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -2003,6 +2003,7 @@ config ARCH_ROCKCHIP
>  	select DM_SPI_FLASH
>  	select DM_USB_GADGET if USB_DWC3_GADGET
>  	select ENABLE_ARM_SOC_BOOT0_HOOK
> +	select NET_BOARD_ETHADDR

You are selecting here, so why the need for IS_ENABLED checks below?

>  	select OF_CONTROL
>  	select MTD
>  	select SPI
> diff --git a/arch/arm/include/asm/arch-rockchip/misc.h b/arch/arm/include/asm/arch-rockchip/misc.h
> index 4155af8c3b0..6e972de6279 100644
> --- a/arch/arm/include/asm/arch-rockchip/misc.h
> +++ b/arch/arm/include/asm/arch-rockchip/misc.h
> @@ -10,5 +10,6 @@ int rockchip_cpuid_from_efuse(const u32 cpuid_offset,
>  			      const u32 cpuid_length,
>  			      u8 *cpuid);
>  int rockchip_cpuid_set(const u8 *cpuid, const u32 cpuid_length);
> +int rockchip_gen_macaddr(int dev_num, u8 *mac_addr);
>  int rockchip_setup_macaddr(void);
>  void rockchip_capsule_update_board_setup(void);
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index 2620530e03f..283d3b9ed3a 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -296,8 +296,8 @@ int fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
>  }
>  #endif
>  
> -#ifdef CONFIG_MISC_INIT_R
> -__weak int misc_init_r(void)
> +#if IS_ENABLED(CONFIG_MISC_INIT_R) || IS_ENABLED(CONFIG_NET_BOARD_ETHADDR)

NET_BOARD_ETHADDR is selected so this #if will always be true.

> +static int set_cpuid(void)
>  {
>  	const u32 cpuid_offset = CFG_CPUID_OFFSET;
>  	const u32 cpuid_length = 0x10;
> @@ -309,10 +309,6 @@ __weak int misc_init_r(void)
>  		return ret;
>  
>  	ret = rockchip_cpuid_set(cpuid, cpuid_length);
> -	if (ret)
> -		return ret;
> -
> -	ret = rockchip_setup_macaddr();
>  
>  	return ret;
>  }
> @@ -349,3 +345,25 @@ __weak int board_rng_seed(struct abuf *buf)
>  	return 0;
>  }
>  #endif
> +
> +#if IS_ENABLED(CONFIG_MISC_INIT_R)
> +__weak int misc_init_r(void)
> +{
> +	return set_cpuid();
> +}
> +#endif
> +
> +int board_gen_ethaddr(int dev_num, u8 *mac_addr)
> +{
> +	if (!IS_ENABLED(CONFIG_NET_BOARD_ETHADDR))
> +		return 0;

NET_BOARD_ETHADDR is selected so this if return 0 is dead code?

Regards,
Jonas

> +
> +	if (!env_get("cpuid#")) {
> +		int err = set_cpuid();
> +
> +		if (err)
> +			return err;
> +	}
> +
> +	return rockchip_gen_macaddr(dev_num, mac_addr);
> +}
> diff --git a/arch/arm/mach-rockchip/misc.c b/arch/arm/mach-rockchip/misc.c
> index 7d03f0c2b67..9c7b04ee5a8 100644
> --- a/arch/arm/mach-rockchip/misc.c
> +++ b/arch/arm/mach-rockchip/misc.c
> @@ -21,14 +21,13 @@
>  
>  #include <asm/arch-rockchip/misc.h>
>  
> -int rockchip_setup_macaddr(void)
> +int rockchip_gen_macaddr(int dev_num, u8 *mac_addr)
>  {
>  #if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256)
>  	int ret;
>  	const char *cpuid = env_get("cpuid#");
>  	u8 hash[SHA256_SUM_LEN];
>  	int size = sizeof(hash);
> -	u8 mac_addr[6];
>  
>  	/* Only generate a MAC address, if none is set in the environment */
>  	if (env_get("ethaddr"))
> @@ -51,15 +50,26 @@ int rockchip_setup_macaddr(void)
>  	/* Make this a valid MAC address and set it */
>  	mac_addr[0] &= 0xfe;  /* clear multicast bit */
>  	mac_addr[0] |= 0x02;  /* set local assignment bit (IEEE802) */
> -	eth_env_set_enetaddr("ethaddr", mac_addr);
>  
> -	/* Make a valid MAC address for ethernet1 */
> -	mac_addr[5] ^= 0x01;
> -	eth_env_set_enetaddr("eth1addr", mac_addr);
> +	/* Make a valid MAC address for the given device number */
> +	mac_addr[5] ^= dev_num;
>  #endif
>  	return 0;
>  }
>  
> +int rockchip_setup_macaddr(void)
> +{
> +	u8 mac_addr[6];
> +
> +	if (rockchip_gen_macaddr(0, mac_addr) == 0)
> +		eth_env_set_enetaddr("ethaddr", mac_addr);
> +
> +	if (rockchip_gen_macaddr(1, mac_addr) == 0)
> +		eth_env_set_enetaddr("eth1addr", mac_addr);
> +
> +	return 0;
> +}
> +
>  int rockchip_cpuid_from_efuse(const u32 cpuid_offset,
>  			      const u32 cpuid_length,
>  			      u8 *cpuid)

