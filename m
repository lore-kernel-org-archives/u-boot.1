Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B25FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB44D83693;
	Mon, 27 Apr 2026 14:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="I2Cyw1b1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B17C83BC4; Mon, 27 Apr 2026 14:13:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D071680433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 14:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9724D1684;
 Mon, 27 Apr 2026 05:13:42 -0700 (PDT)
Received: from [10.41.150.145] (e142021.arm.com [10.41.150.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEF093F62B;
 Mon, 27 Apr 2026 05:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777292028; bh=T3qO5gyY+2fnfufZjGE9mDAW2Apy+DnOhN9TBrrqwhI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=I2Cyw1b1BjtwAujYg4lIObJ54xXiHhwfhX9SrY0EOwhp39UR54WvJD7x1rOOnU5wy
 QlRaQELCe6mgLFIAAQ4j3bjdM8r9KSyyk7Ye/WJ9VpkMz6nZQegB9QlL9cgNYRJ6bu
 7HYUdN3uM6YTEUo5sIqWwD+7AAbW61EdvygF1OnI=
Message-ID: <32260d09-4b23-4b13-916e-b9e330178087@arm.com>
Date: Mon, 27 Apr 2026 14:13:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] sunxi: move SID MAC fallback from board env setup to
 EMAC read_rom_hwaddr
To: Lukas Schmid <lukas.schmid@netcube.li>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.denx.de
References: <20260325192628.750398-1-lukas.schmid@netcube.li>
 <20260325192628.750398-2-lukas.schmid@netcube.li>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260325192628.750398-2-lukas.schmid@netcube.li>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Lukas,

On 3/25/26 20:26, Lukas Schmid wrote:
> sunxi currently seeds ethaddr/ethXaddr in setup_environment() from SID.
> That happens before Ethernet probe, so even with a clean persisted
> environment we can populate env with a generated MAC and later get a
> mismatch warning when DM Ethernet reads a different MAC from DT/NVMEM.
> 
> Stop generating Ethernet MAC env variables in setup_environment() and
> provide SID-derived fallback addresses through read_rom_hwaddr in the
> sunxi EMAC drivers instead.
> 
> Also move the SID uniqueness/MAC derivation logic into shared sunxi arch
> helpers so board code and drivers use one implementation and keep legacy
> algorithm compatibility across SoCs.
> 
> This keeps the generic MAC source order (DT/NVMEM first, fallback second),
> avoids board-level MAC policy special-casing, and prevents same-boot
> env-vs-NVMEM mismatch warnings caused by early env seeding.
> 

Many thanks for reworking this, it looks indeed much better now! I was a 
bit uneasy first about selling the SID based MAC generation as a "MAC 
ROM read", but I now thinks that somehow fits, since it's some kind of 
ROM inside the "network chip" (SoC in this case).
The only problem is that there is a third MAC in use by Allwinner chips: 
SUN7I_GMAC, using the ETH_DESIGNWARE/designware.c driver.
So we can add the same read_rom_hwaddr there, and guard this with an 
IS_ENABLED(CONFIG_ARCH_SUNXI), but then the sunxi_get_sid_mac_addr() 
prototype needs to either move into a different header, or we find some 
other solution without (too many) #ifdef's.
Try "Bananapi_defconfig" for an Allwinner board using this MAC, and say 
rock-pi-s-rk3308_defconfig for an example outside of Allwinner, to test 
this.

> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> ---
>   arch/arm/include/asm/arch-sunxi/sys_proto.h |  6 +++
>   arch/arm/mach-sunxi/cpu_info.c              | 44 ++++++++++++++++
>   board/sunxi/board.c                         | 57 +--------------------
>   drivers/net/sun8i_emac.c                    | 15 ++++++
>   drivers/net/sunxi_emac.c                    | 15 ++++++
>   5 files changed, 81 insertions(+), 56 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-sunxi/sys_proto.h b/arch/arm/include/asm/arch-sunxi/sys_proto.h
> index 92c7721a530..6f70753e948 100644
> --- a/arch/arm/include/asm/arch-sunxi/sys_proto.h
> +++ b/arch/arm/include/asm/arch-sunxi/sys_proto.h
> @@ -12,6 +12,12 @@
>   
>   void sdelay(unsigned long);
>   
> +/* Read SID and apply legacy/newer-SoC normalization for uniqueness. */
> +bool sunxi_get_unique_sid(unsigned int *sid);
> +
> +/* Build legacy-compatible SID-derived locally administered MAC address. */
> +bool sunxi_get_sid_mac_addr(int index, u8 mac[6]);
> +
>   /* return_to_fel() - Return to BROM from SPL
>    *
>    * This returns back into the BROM after U-Boot SPL has performed its initial
> diff --git a/arch/arm/mach-sunxi/cpu_info.c b/arch/arm/mach-sunxi/cpu_info.c
> index c3a51d9956e..d804307e280 100644
> --- a/arch/arm/mach-sunxi/cpu_info.c
> +++ b/arch/arm/mach-sunxi/cpu_info.c
> @@ -9,8 +9,10 @@
>   #include <asm/io.h>
>   #include <asm/arch/cpu.h>
>   #include <asm/arch/clock.h>
> +#include <asm/arch/sys_proto.h>
>   #include <axp_pmic.h>
>   #include <errno.h>
> +#include <u-boot/crc.h>
>   
>   #ifdef CONFIG_MACH_SUN6I
>   int sunxi_get_ss_bonding_id(void)
> @@ -175,3 +177,45 @@ int sunxi_get_sid(unsigned int *sid)
>   	return -ENODEV;
>   #endif
>   }
> +
> +bool sunxi_get_unique_sid(unsigned int *sid)
> +{
> +	if (sunxi_get_sid(sid) != 0)
> +		return false;
> +
> +	if (!sid[0])
> +		return false;
> +
> +	/*
> +	 * On newer SoCs use a CRC over SID words 1..3 for better uniqueness,
> +	 * while keeping the long-standing algorithm on older SoCs.
> +	 */
> +#if !defined(CONFIG_MACH_SUN4I) && !defined(CONFIG_MACH_SUN5I) && \
> +	!defined(CONFIG_MACH_SUN6I) && !defined(CONFIG_MACH_SUN7I) && \
> +	!defined(CONFIG_MACH_SUN8I_A23) && !defined(CONFIG_MACH_SUN8I_A33)
> +	sid[3] = crc32(0, (unsigned char *)&sid[1], 12);
> +#endif
> +
> +	/* Ensure the NIC-specific bytes are not all 0. */
> +	if ((sid[3] & 0xffffff) == 0)
> +		sid[3] |= 0x800000;
> +
> +	return true;
> +}
> +
> +bool sunxi_get_sid_mac_addr(int index, u8 mac[6])
> +{
> +	unsigned int sid[4];
> +
> +	if (!sunxi_get_unique_sid(sid))
> +		return false;
> +
> +	mac[0] = ((index & 0xf) << 4) | 0x02;
> +	mac[1] = (sid[0] >>  0) & 0xff;
> +	mac[2] = (sid[3] >> 24) & 0xff;
> +	mac[3] = (sid[3] >> 16) & 0xff;
> +	mac[4] = (sid[3] >>  8) & 0xff;
> +	mac[5] = (sid[3] >>  0) & 0xff;
> +
> +	return true;
> +}
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index d7722d1858a..420c4504720 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -41,7 +41,6 @@
>   #include <asm/gpio.h>
>   #include <sunxi_gpio.h>
>   #include <asm/io.h>
> -#include <u-boot/crc.h>
>   #include <env_internal.h>
>   #include <linux/libfdt.h>
>   #include <fdt_support.h>
> @@ -750,34 +749,7 @@ static void parse_spl_header(const uint32_t spl_addr)
>   
>   static bool get_unique_sid(unsigned int *sid)
>   {
> -	if (sunxi_get_sid(sid) != 0)
> -		return false;
> -
> -	if (!sid[0])
> -		return false;
> -
> -	/*
> -	 * The single words 1 - 3 of the SID have quite a few bits
> -	 * which are the same on many models, so we take a crc32
> -	 * of all 3 words, to get a more unique value.
> -	 *
> -	 * Note we only do this on newer SoCs as we cannot change
> -	 * the algorithm on older SoCs since those have been using
> -	 * fixed mac-addresses based on only using word 3 for a
> -	 * long time and changing a fixed mac-address with an
> -	 * u-boot update is not good.
> -	 */
> -#if !defined(CONFIG_MACH_SUN4I) && !defined(CONFIG_MACH_SUN5I) && \
> -    !defined(CONFIG_MACH_SUN6I) && !defined(CONFIG_MACH_SUN7I) && \
> -    !defined(CONFIG_MACH_SUN8I_A23) && !defined(CONFIG_MACH_SUN8I_A33)
> -	sid[3] = crc32(0, (unsigned char *)&sid[1], 12);
> -#endif
> -
> -	/* Ensure the NIC specific bytes of the mac are not all 0 */
> -	if ((sid[3] & 0xffffff) == 0)
> -		sid[3] |= 0x800000;
> -
> -	return true;
> +	return sunxi_get_unique_sid(sid);

So why do we need this extra get_unique_sid() function still? The 
prototyp is the same, so can't we just change all callers to use the 
new, external function?

Cheers,
Andre

>   }
>   
>   /*
> @@ -788,37 +760,10 @@ static void setup_environment(const void *fdt)
>   {
>   	char serial_string[17] = { 0 };
>   	unsigned int sid[4];
> -	uint8_t mac_addr[6];
> -	char ethaddr[16];
> -	int i;
>   
>   	if (!get_unique_sid(sid))
>   		return;
>   
> -	for (i = 0; i < 4; i++) {
> -		sprintf(ethaddr, "ethernet%d", i);
> -		if (!fdt_get_alias(fdt, ethaddr))
> -			continue;
> -
> -		if (i == 0)
> -			strcpy(ethaddr, "ethaddr");
> -		else
> -			sprintf(ethaddr, "eth%daddr", i);
> -
> -		if (env_get(ethaddr))
> -			continue;
> -
> -		/* Non OUI / registered MAC address */
> -		mac_addr[0] = (i << 4) | 0x02;
> -		mac_addr[1] = (sid[0] >>  0) & 0xff;
> -		mac_addr[2] = (sid[3] >> 24) & 0xff;
> -		mac_addr[3] = (sid[3] >> 16) & 0xff;
> -		mac_addr[4] = (sid[3] >>  8) & 0xff;
> -		mac_addr[5] = (sid[3] >>  0) & 0xff;
> -
> -		eth_env_set_enetaddr(ethaddr, mac_addr);
> -	}
> -
>   	if (!env_get("serial#")) {
>   		snprintf(serial_string, sizeof(serial_string),
>   			"%08x%08x", sid[0], sid[3]);
> diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
> index 41c52f56d7a..a267b6cd7f5 100644
> --- a/drivers/net/sun8i_emac.c
> +++ b/drivers/net/sun8i_emac.c
> @@ -13,6 +13,7 @@
>   #include <cpu_func.h>
>   #include <log.h>
>   #include <asm/cache.h>
> +#include <asm/arch/sys_proto.h>
>   #include <asm/global_data.h>
>   #include <asm/gpio.h>
>   #include <asm/io.h>
> @@ -259,6 +260,19 @@ static int sun8i_eth_write_hwaddr(struct udevice *dev)
>   	return 0;
>   }
>   
> +static int sun8i_eth_read_rom_hwaddr(struct udevice *dev)
> +{
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	u8 mac[ARP_HLEN];
> +
> +	if (!sunxi_get_sid_mac_addr(dev_seq(dev), mac))
> +		return -ENODEV;
> +
> +	memcpy(pdata->enetaddr, mac, ARP_HLEN);
> +
> +	return 0;
> +}
> +
>   static void sun8i_adjust_link(struct emac_eth_dev *priv,
>   			      struct phy_device *phydev)
>   {
> @@ -715,6 +729,7 @@ static int sun8i_emac_eth_probe(struct udevice *dev)
>   
>   static const struct eth_ops sun8i_emac_eth_ops = {
>   	.start                  = sun8i_emac_eth_start,
> +	.read_rom_hwaddr	= sun8i_eth_read_rom_hwaddr,
>   	.write_hwaddr           = sun8i_eth_write_hwaddr,
>   	.send                   = sun8i_emac_eth_send,
>   	.recv                   = sun8i_emac_eth_recv,
> diff --git a/drivers/net/sunxi_emac.c b/drivers/net/sunxi_emac.c
> index 3dee849c97e..f45a0790a40 100644
> --- a/drivers/net/sunxi_emac.c
> +++ b/drivers/net/sunxi_emac.c
> @@ -15,6 +15,7 @@
>   #include <miiphy.h>
>   #include <net.h>
>   #include <asm/io.h>
> +#include <asm/arch/sys_proto.h>
>   #include <asm/arch/clock.h>
>   #include <power/regulator.h>
>   
> @@ -539,6 +540,19 @@ static int sunxi_emac_eth_send(struct udevice *dev, void *packet, int length)
>   	return _sunxi_emac_eth_send(priv, packet, length);
>   }
>   
> +static int sunxi_emac_read_rom_hwaddr(struct udevice *dev)
> +{
> +	struct eth_pdata *pdata = dev_get_plat(dev);
> +	u8 mac[ARP_HLEN];
> +
> +	if (!sunxi_get_sid_mac_addr(dev_seq(dev), mac))
> +		return -ENODEV;
> +
> +	memcpy(pdata->enetaddr, mac, ARP_HLEN);
> +
> +	return 0;
> +}
> +
>   static int sunxi_emac_eth_recv(struct udevice *dev, int flags, uchar **packetp)
>   {
>   	struct emac_eth_dev *priv = dev_get_priv(dev);
> @@ -581,6 +595,7 @@ static int sunxi_emac_eth_probe(struct udevice *dev)
>   
>   static const struct eth_ops sunxi_emac_eth_ops = {
>   	.start			= sunxi_emac_eth_start,
> +	.read_rom_hwaddr	= sunxi_emac_read_rom_hwaddr,
>   	.send			= sunxi_emac_eth_send,
>   	.recv			= sunxi_emac_eth_recv,
>   	.stop			= sunxi_emac_eth_stop,

